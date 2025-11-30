# Test End-to-End - HuertoHogar
$ErrorActionPreference = "Stop"
$BaseUrl = "http://localhost:8083/api/carritos"

function Log($msg) { Write-Host "[$((Get-Date).ToString('HH:mm:ss'))] $msg" -ForegroundColor Cyan }
function Success($msg) { Write-Host "OK: $msg" -ForegroundColor Green }
function Fail($msg) { Write-Host "ERROR: $msg" -ForegroundColor Red; exit 1 }

Log "Iniciando prueba de flujo completo..."

# 1. Crear Carrito
Log "Creando nuevo carrito..."
try {
    $carrito = Invoke-RestMethod -Uri "$BaseUrl" -Method Post -Body (@{ usuarioId=1 } | ConvertTo-Json) -ContentType "application/json"
    $id = $carrito.id
    Success "Carrito #$id creado."
} catch { Fail "No se pudo crear el carrito. Verifica que el servicio esté arriba." }

# 2. Agregar Producto
Log "Agregando productos..."
$item = @{ productoId=101; cantidad=2 } | ConvertTo-Json
Invoke-RestMethod -Uri "$BaseUrl/$id/items" -Method Post -Body $item -ContentType "application/json" | Out-Null
Success "Producto agregado al carrito."

# 3. Confirmar Compra (Dispara SQS)
Log "Confirmando compra (Trigger SQS)..."
try {
    $res = Invoke-RestMethod -Uri "$BaseUrl/confirmar/$id" -Method Post
    Success "Respuesta del servidor: $res"
} catch {
    Fail "Falló la confirmación. $_"
}

Log "Prueba finalizada correctamente."