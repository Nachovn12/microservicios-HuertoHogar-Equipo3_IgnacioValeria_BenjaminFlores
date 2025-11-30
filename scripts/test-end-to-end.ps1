# Script de Prueba End-to-End para HuertoHogar
# Ejecutar con: .\scripts\test-end-to-end.ps1

$API_URL = "http://localhost:8080"
$CARRITO_URL = "http://localhost:8083"

Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "   PRUEBA END-TO-END HUERTOHOGAR (Windows PowerShell)" -ForegroundColor Cyan
Write-Host "===========================================================" -ForegroundColor Cyan

# 1. Verificar Ping del Microservicio
Write-Host ""
Write-Host "--- 1. Verificando Microservicio Carrito ---" -ForegroundColor Yellow
try {
    $pingResponse = Invoke-RestMethod -Uri "$CARRITO_URL/carritos/ping" -Method Get -ErrorAction Stop
    Write-Host "[OK] Microservicio Carrito responde: $pingResponse" -ForegroundColor Green
}
catch {
    Write-Host "[ERROR] Microservicio Carrito no responde en /ping" -ForegroundColor Red
    Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
}

# 2. Verificar API Gateway
Write-Host ""
Write-Host "--- 2. Verificando API Gateway ---" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "$API_URL/actuator/health" -Method Head -ErrorAction SilentlyContinue
    $statusCode = $response.StatusCode
    Write-Host "[OK] API Gateway accesible (Status: $statusCode)" -ForegroundColor Green
}
catch {
    if ($_.Exception.Response) {
        $statusCode = $_.Exception.Response.StatusCode.value__
        Write-Host "[OK] API Gateway accesible (Status: $statusCode)" -ForegroundColor Green
    }
    else {
        Write-Host "[ERROR] API Gateway no responde" -ForegroundColor Red
    }
}

# 3. Crear un Carrito
Write-Host ""
Write-Host "--- 3. Creando un Carrito de Compra ---" -ForegroundColor Yellow
$body = @{
    usuarioId = 1
} | ConvertTo-Json

try {
    $carritoResponse = Invoke-RestMethod -Uri "$CARRITO_URL/carritos" -Method Post -Body $body -ContentType "application/json" -ErrorAction Stop
    Write-Host "[OK] Carrito creado exitosamente" -ForegroundColor Green
    Write-Host "   ID: $($carritoResponse.id)" -ForegroundColor White
    Write-Host "   Usuario ID: $($carritoResponse.usuarioId)" -ForegroundColor White
    $carritoId = $carritoResponse.id
}
catch {
    Write-Host "[ERROR] Error creando carrito: $($_.Exception.Message)" -ForegroundColor Red
    $carritoId = 1
    Write-Host "   Usando ID de prueba: $carritoId" -ForegroundColor Yellow
}

# 4. Confirmar Compra (Trigger SQS)
Write-Host ""
Write-Host "--- 4. Confirmando Compra (Trigger SQS) ---" -ForegroundColor Yellow
Write-Host "   Endpoint: POST $CARRITO_URL/carritos/$carritoId/confirmar" -ForegroundColor Gray

try {
    $confirmResponse = Invoke-RestMethod -Uri "$CARRITO_URL/carritos/$carritoId/confirmar" -Method Post -ErrorAction Stop
    Write-Host "[OK] COMPRA CONFIRMADA EXITOSAMENTE!" -ForegroundColor Green
    Write-Host "   Respuesta: $confirmResponse" -ForegroundColor White
    Write-Host ""
    Write-Host "   >> El mensaje fue enviado a la cola SQS 'HuertoHogar-Orders'" -ForegroundColor Cyan
    Write-Host "   >> Email simulado: usuario$carritoId@huertohogar.com" -ForegroundColor Cyan
}
catch {
    $errorMessage = $_.Exception.Message
    $statusCode = "N/A"
    
    if ($_.Exception.Response) {
        $statusCode = $_.Exception.Response.StatusCode.value__
    }
    
    Write-Host "[ERROR] Error confirmando compra (Status: $statusCode)" -ForegroundColor Red
    Write-Host "   Mensaje: $errorMessage" -ForegroundColor Red
    
    if ($errorMessage -match "credentials") {
        Write-Host ""
        Write-Host "   [!] PROBLEMA: Credenciales AWS no configuradas" -ForegroundColor Yellow
        Write-Host "   Solucion: Configura las variables de entorno:" -ForegroundColor Yellow
        Write-Host '   $env:AWS_ACCESS_KEY_ID = "tu-access-key"' -ForegroundColor Gray
        Write-Host '   $env:AWS_SECRET_ACCESS_KEY = "tu-secret-key"' -ForegroundColor Gray
    }
}

# 5. Verificar logs de AWS Lambda
Write-Host ""
Write-Host "--- 5. Verificando logs de AWS Lambda ---" -ForegroundColor Yellow
if (Get-Command aws -ErrorAction SilentlyContinue) {
    Write-Host "   Esperando 10 segundos para que Lambda procese..." -ForegroundColor Gray
    Start-Sleep -Seconds 10
    
    Write-Host "   Consultando CloudWatch Logs..." -ForegroundColor Gray
    try {
        aws logs tail "/aws/lambda/huertohogar-lambda-dev-processOrder" --region us-east-1 --since 5m
    }
    catch {
        Write-Host "   [!] No se pudieron obtener los logs automaticamente" -ForegroundColor Yellow
    }
}
else {
    Write-Host "   [!] AWS CLI no instalado o no en PATH" -ForegroundColor Yellow
    Write-Host "   Para verificar manualmente:" -ForegroundColor Cyan
    Write-Host "   1. Ve a AWS Console -> CloudWatch -> Log Groups" -ForegroundColor Gray
    Write-Host "   2. Busca '/aws/lambda/huertohogar-lambda-dev-processOrder'" -ForegroundColor Gray
    Write-Host "   3. Revisa los ultimos logs" -ForegroundColor Gray
}

# Resumen Final
Write-Host ""
Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "   RESUMEN DE LA PRUEBA" -ForegroundColor Cyan
Write-Host "===========================================================" -ForegroundColor Cyan
Write-Host "   Carrito ID: $carritoId" -ForegroundColor White
Write-Host "   Email simulado: usuario$carritoId@huertohogar.com" -ForegroundColor White
Write-Host ""
Write-Host "   Proximos pasos:" -ForegroundColor Yellow
Write-Host "   1. Verifica en AWS Console -> SQS la cola 'HuertoHogar-Orders'" -ForegroundColor Gray
Write-Host "   2. Verifica en AWS Console -> Lambda los logs de ejecucion" -ForegroundColor Gray
Write-Host "   3. Revisa CloudWatch para ver el procesamiento completo" -ForegroundColor Gray
Write-Host "===========================================================" -ForegroundColor Cyan