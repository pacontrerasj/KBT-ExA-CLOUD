# ============================================================
# Compute — Instancia EC2 con Docker + Docker Compose
# ============================================================

# ──── Buscar AMI de Amazon Linux 2023 ────

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ──── User Data: instalar Docker, Docker Compose, AWS CLI y preparar la app ────

locals {
  user_data = templatefile("${path.module}/user_data.sh", {
    db_host     = var.db_host
    db_user     = var.db_user
    db_password = var.db_password
    db_name     = var.db_name
    db_port     = var.db_port
    aws_account_id = var.aws_account_id
    aws_region  = var.aws_region
  })
}

# ──── Instancia EC2 ────

resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_ec2_id]
  key_name               = var.key_name
  user_data              = local.user_data
  user_data_replace_on_change = true

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name = "ec2-${var.proyecto}"
  }
}
