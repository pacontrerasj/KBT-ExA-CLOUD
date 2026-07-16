# ============================================================
# Tienda Vehiculos — Infraestructura en AWS con Terraform
# ============================================================

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Proyecto   = "TiendaVehiculos"
      Proposito  = "EP2-Cloud-II"
      Gestion    = "Terraform"
    }
  }
}

# ──── Módulo de Redes ────

module "networking" {
  source = "./modules/networking"

  proyecto        = var.proyecto
  vpc_cidr        = var.vpc_cidr
  azs             = var.azs
  mi_ip           = var.mi_ip
  existing_vpc_id = var.existing_vpc_id
}

# ──── Módulo de Base de Datos ────

module "database" {
  source = "./modules/database"

  proyecto          = var.proyecto
  vpc_id            = module.networking.vpc_id
  subnet_ids        = module.networking.subnets_privadas_ids
  sg_rds_id         = module.networking.sg_rds_id
  db_master_user    = var.db_master_user
  db_master_password = var.db_master_password
  db_name           = var.db_name
}

# ──── Módulo de Cómputo (EC2 + Docker) ────

module "compute" {
  source = "./modules/compute"

  proyecto           = var.proyecto
  subnet_id          = module.networking.subnet_publica_id
  sg_ec2_id          = module.networking.sg_ec2_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  db_host            = module.database.rds_endpoint
  db_user            = var.db_master_user
  db_password        = var.db_master_password
  db_name            = var.db_name
  db_port            = module.database.rds_port
}

# ──── Módulo de ECR ────

module "ecr" {
  source = "./modules/ecr"

  proyecto = var.proyecto
}
