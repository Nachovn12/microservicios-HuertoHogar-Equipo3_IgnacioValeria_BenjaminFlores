#!/bin/bash
# Script de Demostración End-to-End para HuertoHogar
# Ejecutar en Git Bash o terminal Linux/Mac

# Configuración
API_URL="http://localhost:8080"
LAMBDA_FUNCTION_NAME="huertohogar-lambda-dev-processOrder" # Nombre por defecto de Serverless Framework
REGION="us-east-1"

echo "==========================================================="
echo "   PRUEBA END-TO-END HUERTOHOGAR (Local Swarm + AWS)"
echo "==========================================================="

# 1. Verificar que el API Gateway responde
echo ""
echo "--- 1. Verificando estado del API Gateway ---"
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" $API_URL/actuator/health)
# Si no tienes actuator, probamos un endpoint de usuarios
if [ "$HTTP_CODE" != "200" ]; then
    echo "⚠️  API Gateway no responde en /actuator/health (Código: $HTTP_CODE). Probando /usuarios..."
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" $API_URL/usuarios)
fi

echo "Estado API: $HTTP_CODE"

# 2. Crear un Carrito (Simulado)
echo ""
echo "--- 2. Creando un Carrito de Compra ---"
# Asumimos que el endpoint POST /carritos crea un carrito vacío
CARRITO_RESPONSE=$(curl -s -X POST $API_URL/carritos \
  -H "Content-Type: application/json" \
  -d '{"usuarioId": 1}')

echo "Respuesta: $CARRITO_RESPONSE"
# Extraer ID del carrito (usando grep/sed básico si no hay jq)
CARRITO_ID=$(echo $CARRITO_RESPONSE | grep -o '"id":[0-9]*' | grep -o '[0-9]*')

if [ -z "$CARRITO_ID" ]; then
    echo "⚠️  No se pudo obtener ID del carrito. Usando ID de prueba '1'."
    CARRITO_ID=1
else
    echo "✅ Carrito creado con ID: $CARRITO_ID"
fi

# 3. Confirmar Compra (Dispara SQS)
echo ""
echo "--- 3. Confirmando Compra (Trigger SQS) ---"
echo "Enviando petición POST a $API_URL/carritos/$CARRITO_ID/confirmar ..."

CONFIRM_RESPONSE=$(curl -s -X POST "$API_URL/carritos/$CARRITO_ID/confirmar")
echo "Respuesta del Servidor: $CONFIRM_RESPONSE"

# 4. Verificar en AWS (Logs de Lambda)
echo ""
echo "--- 4. Verificando procesamiento en AWS Lambda ---"
echo "Esperando 10 segundos para que Lambda procese el mensaje..."
sleep 10

echo "Consultando logs recientes de CloudWatch para la función: $LAMBDA_FUNCTION_NAME"
# Intentamos obtener los logs. Si falla, es probable que falten credenciales o el nombre sea distinto.
aws logs tail "/aws/lambda/$LAMBDA_FUNCTION_NAME" --region $REGION --since 5m

echo ""
echo "==========================================================="
echo "   PRUEBA FINALIZADA"
echo "==========================================================="
echo "Si viste el log 'Procesando pedido', ¡la integración funciona!"