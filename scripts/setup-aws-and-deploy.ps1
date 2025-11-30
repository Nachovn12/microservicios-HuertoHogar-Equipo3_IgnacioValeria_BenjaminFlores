# Setup AWS & Deploy
$ErrorActionPreference = "Stop"

Write-Host "Configurando entorno AWS..." -ForegroundColor Cyan

# Verificar AWS CLI
if (!(Get-Command aws -ErrorAction SilentlyContinue)) {
    Write-Error "AWS CLI no encontrado. Instálalo primero."
    exit 1
}

# Crear recursos
Write-Host "Aprovisionando SQS..."
# Usar bash si está disponible, o invocar el script sh
bash ./scripts/create-aws-resources.sh

# Build & Deploy
Write-Host "Construyendo imágenes..."
docker-compose -f docker-compose.swarm.yml build

Write-Host "Desplegando Stack..."
docker stack deploy -c docker-compose.swarm.yml huertohogar

Write-Host "Despliegue completado." -ForegroundColor Green
