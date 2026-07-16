# ============================================================
# Backend remoto — S3 + DynamoDB
# ============================================================
# Descomenta y configura cuando tengas el bucket S3 creado:
#
# terraform {
#   backend "s3" {
#     bucket         = "tfstate-tienda-vehiculos"
#     key            = "infra/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "tfstate-tienda-vehiculos-lock"
#   }
# }
