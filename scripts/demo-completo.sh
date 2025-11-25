#!/bin/bash
#
# Script que simula el flujo completo de HuertoHogar (End-to-End Demo).
# Demuestra la integración de Microservicios -> SQS -> Lambda.
#
# ----------------------------------------------------------------------
# CONFIGURACIÓN: REEMPLAZAR ANTES DE USAR
# ----------------------------------------------------------------------
API_GATEWAY_URL="https://[REEMPLAZAR_CON_TU_ID_API_GATEWAY].execute-api.us-east-1.amazonaws.com/prod"
REGION="us-east-1"
LAMBDA_FUNCTION_NAME="HuertoHogar-ProcessOrder"

# Variables dinámicas para el pedido
ORDER_ID="ORDER-$(date +%s)"
USER_EMAIL="test-user-${ORDER_ID}@huertohogar.com"

# ----------------------------------------------------------------------
echo "--- 1. PREPARACIÓN: OBTENER TOKEN DE AUTENTICACIÓN ---"
# PENDIENTE: Aquí irían los comandos para obtener el JWT del API Gateway.
JWT_TOKEN="[TOKEN_DE_PRUEBA_GENERADO_POR_LOGIN]"

if [ -z "$JWT_TOKEN" ]; then
    echo "❌ ERROR: JWT_TOKEN no generado. No se puede continuar."
    exit 1
fi

# ----------------------------------------------------------------------
echo "--- 2. CREAR Y CONFIRMAR PEDIDO (Activa Productor SQS) ---"
# El carrito-microservice actúa como PRODUCTOR al confirmar, enviando a SQS.

echo "Enviando confirmación del pedido ${ORDER_ID}..."

# PENDIENTE: Aquí iría el comando cURL que llama al endpoint /carritos/confirmar
#            Usando el $JWT_TOKEN para autenticación.

echo "Mensaje de pedido enviado a la cola SQS."
sleep 5 # Esperar 5 segundos para que Lambda tenga tiempo de procesar.

# ----------------------------------------------------------------------
echo "--- 3. VERIFICAR PROCESAMIENTO EN LOGS DE CLOUDWATCH ---"
# La función Lambda (CONSUMIDOR) procesa el mensaje de SQS.

echo "Buscando logs de Lambda para el pedido ${ORDER_ID}..."
# Comando para ver los logs de la función Lambda usando AWS CLI.
aws logs tail /aws/lambda/${LAMBDA_FUNCTION_NAME} --region ${REGION} --follow --since 1m

echo "✅ Demostración completada."