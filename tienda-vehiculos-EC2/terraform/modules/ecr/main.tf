# ============================================================
# ECR — Repositorios de imagenes Docker
# ============================================================

resource "aws_ecr_repository" "frontend" {
  name                 = "${var.proyecto}-frontend"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = { Name = "ecr-${var.proyecto}-frontend" }
}

resource "aws_ecr_repository" "backend" {
  name                 = "${var.proyecto}-backend"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = { Name = "ecr-${var.proyecto}-backend" }
}
