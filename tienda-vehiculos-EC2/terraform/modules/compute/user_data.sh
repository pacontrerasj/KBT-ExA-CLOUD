#!/bin/bash
# ============================================================
# User Data — Tienda Vehiculos EC2
# ============================================================
exec > /var/log/user-data.log 2>&1
set -x

# ──── Variables inyectadas por Terraform ────

DB_HOST="${db_host}"
DB_USER="${db_user}"
DB_PASSWORD="${db_password}"
DB_NAME="${db_name}"
DB_PORT="${db_port}"
AWS_ACCOUNT_ID="${aws_account_id}"
AWS_REGION="${aws_region}"

# ──── Actualizar paquetes ────

sudo yum update -y
sudo yum install -y docker git

# ──── Habilitar Docker ────

sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

# ──── Instalar Docker Compose plugin ────

sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL "https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-linux-x86_64" -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# ──── Instalar cliente MySQL ────

sudo yum install -y mariadb105

# ──── Crear directorio de la app ────

mkdir -p /home/ec2-user/tienda-vehiculos
cd /home/ec2-user/tienda-vehiculos

# ──── Crear archivo .env ────

cat > /home/ec2-user/tienda-vehiculos/.env <<EOF
DB_HOST=${db_host}
DB_USER=${db_user}
DB_PASSWORD=${db_password}
DB_NAME=${db_name}
DB_PORT=${db_port}
EOF

# ──── Autenticarse en ECR ────

aws ecr get-login-password --region "${AWS_REGION}" | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

echo "✅ User Data completado"
