# Script de Configuracion AWS y Redespliegue
# Ejecutar con: .\scripts\setup-aws-and-deploy.ps1

Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "   CONFIGURACION AWS Y REDESPLIEGUE HUERTOHOGAR" -ForegroundColor Cyan
Write-Host "===========================================================" -ForegroundColor Cyan

# PASO 1: Configurar credenciales AWS
Write-Host "`n--- PASO 1: Configurar Credenciales AWS ---" -ForegroundColor Yellow
Write-Host "Por favor, ingresa tus credenciales de AWS Academy Learner Lab:" -ForegroundColor White
Write-Host ""

$AWS_ACCESS_KEY_ID = Read-Host "AWS Access Key ID"
$AWS_SECRET_ACCESS_KEY = Read-Host "AWS Secret Access Key" -AsSecureString
$AWS_SECRET_ACCESS_KEY_PLAIN = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($AWS_SECRET_ACCESS_KEY))
$AWS_SESSION_TOKEN = Read-Host "AWS Session Token (opcional, presiona Enter si no tienes)"

# Exportar variables de entorno
$env:AWS_ACCESS_KEY_ID = $AWS_ACCESS_KEY_ID
$env:AWS_SECRET_ACCESS_KEY = $AWS_SECRET_ACCESS_KEY_PLAIN
if ($AWS_SESSION_TOKEN) {
    $env:AWS_SESSION_TOKEN = $AWS_SESSION_TOKEN
}
$env:AWS_REGION = "us-east-1"

Write-Host "[OK] Credenciales configuradas en el entorno" -ForegroundColor Green

# PASO 2: Verificar Docker Swarm
Write-Host "`n--- PASO 2: Verificar Docker Swarm ---" -ForegroundColor Yellow
$swarmStatus = docker info --format '{{.Swarm.LocalNodeState}}'
if ($swarmStatus -ne "active") {
    Write-Host "[!] Docker Swarm no esta activo. Inicializando..." -ForegroundColor Yellow
    docker swarm init
    Write-Host "[OK] Docker Swarm inicializado" -ForegroundColor Green
} else {
    Write-Host "[OK] Docker Swarm ya esta activo" -ForegroundColor Green
}

# PASO 3: Detener stack actual
Write-Host "`n--- PASO 3: Detener Stack Actual ---" -ForegroundColor Yellow
docker stack rm huertohogar
Write-Host "[OK] Stack detenido. Esperando 15 segundos..." -ForegroundColor Green
Start-Sleep -Seconds 15

# PASO 4: Redesplegar con nuevas credenciales
Write-Host "`n--- PASO 4: Redesplegar Stack ---" -ForegroundColor Yellow
docker stack deploy -c docker-compose.swarm.yml huertohogar
Write-Host "[OK] Stack desplegado" -ForegroundColor Green

# PASO 5: Esperar a que los servicios esten listos
Write-Host "`n--- PASO 5: Esperando servicios (60 segundos) ---" -ForegroundColor Yellow
Start-Sleep -Seconds 60

# PASO 6: Verificar servicios
Write-Host "`n--- PASO 6: Verificar Servicios ---" -ForegroundColor Yellow
docker service ls

# PASO 7: Probar endpoint
Write-Host "`n--- PASO 7: Probar Endpoint /confirmar ---" -ForegroundColor Yellow
Write-Host "Esperando 10 segundos adicionales..." -ForegroundColor Gray
Start-Sleep -Seconds 10

try {
    $response = Invoke-RestMethod -Uri "http://localhost:8083/carritos/1/confirmar" -Method Post
    Write-Host "[OK] EXITO! El endpoint funciona:" -ForegroundColor Green
    Write-Host "Respuesta: $response" -ForegroundColor White
} catch {
    Write-Host "[ERROR] El endpoint aun no responde:" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "`nRevisa los logs con: docker service logs huertohogar_carrito-ms" -ForegroundColor Yellow
}

Write-Host "`n===========================================================" -ForegroundColor Cyan
Write-Host "   CONFIGURACION COMPLETADA" -ForegroundColor Cyan
Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "`nProximos pasos:" -ForegroundColor Yellow
Write-Host "1. Si el endpoint funciono, ejecuta: .\scripts\test-end-to-end.ps1" -ForegroundColor Gray
Write-Host "2. Si fallo, revisa logs: docker service logs huertohogar_carrito-ms" -ForegroundColor Gray
Write-Host "3. Verifica que la cola SQS 'HuertoHogar-Orders' existe en AWS Console" -ForegroundColor Gray
