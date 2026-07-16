# ============================================================
# Networking — VPC, subnets, IGW, route tables, Security Groups
# ============================================================

# ──── VPC ────

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = { Name = "vpc-${var.proyecto}" }
}

# ──── Subnets Públicas ────

resource "aws_subnet" "publica" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = { Name = "subnet-publica-${var.proyecto}-${element(split("-", var.azs[count.index]), 1)}" }
}

# ──── Subnets Privadas ────

resource "aws_subnet" "privada" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + length(var.azs))
  availability_zone = var.azs[count.index]

  tags = { Name = "subnet-privada-${var.proyecto}-${element(split("-", var.azs[count.index]), 1)}" }
}

# ──── Internet Gateway ────

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = "igw-${var.proyecto}" }
}

# ──── NAT Gateway ────

resource "aws_eip" "nat" {
  domain = "vpc"
  tags   = { Name = "eip-nat-${var.proyecto}" }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.publica[0].id
  tags          = { Name = "nat-${var.proyecto}" }
}

# ──── Route Tables ────

resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { Name = "rt-publica-${var.proyecto}" }
}

resource "aws_route_table" "privada" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = { Name = "rt-privada-${var.proyecto}" }
}

resource "aws_route_table_association" "publica" {
  count          = length(aws_subnet.publica)
  subnet_id      = aws_subnet.publica[count.index].id
  route_table_id = aws_route_table.publica.id
}

resource "aws_route_table_association" "privada" {
  count          = length(aws_subnet.privada)
  subnet_id      = aws_subnet.privada[count.index].id
  route_table_id = aws_route_table.privada.id
}

# ──── Security Groups ────

resource "aws_security_group" "sg_ec2" {
  name_prefix = "ec2-${var.proyecto}-"
  description = "Permite SSH desde mi IP y HTTP desde internet"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "SSH desde mi IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.mi_ip]
  }

  ingress {
    description = "HTTP desde cualquier origen"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Backend API desde cualquier origen"
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "sg-ec2-${var.proyecto}" }
}

resource "aws_security_group" "sg_rds" {
  name_prefix = "rds-${var.proyecto}-"
  description = "Permite MySQL solo desde el SG de la EC2"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "MySQL desde EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_ec2.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "sg-rds-${var.proyecto}" }
}
