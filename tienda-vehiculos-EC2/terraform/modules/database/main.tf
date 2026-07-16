# ============================================================
# Database — RDS MySQL
# ============================================================

# ──── Password generada automaticamente ────

resource "random_password" "master" {
  length           = 16
  special          = true
  override_special = "!#$%&*"
}

# ──── Subnet Group para RDS (en subnets privadas) ────

resource "aws_db_subnet_group" "rds" {
  name       = "subnet-group-${var.proyecto}"
  subnet_ids = var.subnet_ids

  tags = { Name = "subnet-group-${var.proyecto}" }
}

# ──── Instancia RDS MySQL ────

resource "aws_db_instance" "rds" {
  identifier             = "rds-${var.proyecto}"
  engine                 = "mysql"
  engine_version         = "8.4"
  instance_class         = "db.t4g.micro"
  allocated_storage      = 20
  storage_type           = "gp3"
  storage_encrypted      = true

  db_name                = var.db_name
  username               = var.db_master_user
  password               = random_password.master.result
  port                   = 3306

  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [var.sg_rds_id]

  publicly_accessible    = false
  multi_az               = false
  skip_final_snapshot    = true

  tags = { Name = "rds-${var.proyecto}" }
}
