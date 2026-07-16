# ============================================================
# Backend remoto — S3 + DynamoDB
# ============================================================
terraform {
  backend "s3" {
    bucket         = "tfstate-908345399651-tienda-vehiculos"
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "tfstate-tienda-vehiculos-lock"
  }
}
