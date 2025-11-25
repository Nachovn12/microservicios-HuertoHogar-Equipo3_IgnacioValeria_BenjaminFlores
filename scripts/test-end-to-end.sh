#!/bin/bash
#
# Script de prueba básica de accesibilidad (End-to-End Test)
# Objetivo: Verificar que la URL base del API Gateway está respondiendo,
#           confirmando que la infraestructura está online.
#

# ----------------------------------------------------------------------
# CONFIGURACIÓN: REEMPLAZAR ANTES DE USAR
# ----------------------------------------------------------------------
API_URL="https://[REEMPLAZAR_CON_TU_ID_API_GATEWAY].execute-api.us-east-1.amazonaws.com/prod"

echo "--- 1. VERIFICANDO ACCESIBILIDAD DEL API GATEWAY ---"

# Intentamos acceder a un endpoint base que no debería requerir autenticación (si existe).
# Reemplazar '/usuarios/health' por el endpoint de salud de tu equipo, si es diferente.
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X GET "${API_URL}/usuarios/health")

if [ "$RESPONSE" -eq 200 ] || [ "$RESPONSE" -eq 403 ] || [ "$RESPONSE" -eq 401 ]; then
    echo "✅ ÉXITO: El API Gateway está respondiendo (Código: $RESPONSE)."
    echo "   (Se espera 200 o 401/403 si el endpoint está protegido.)"
else
    echo "❌ ERROR: El API Gateway NO responde correctamente (Código: $RESPONSE)."
    echo "   Verificar la URL base y el estado del despliegue."
fi

echo "--- 2. PRUEBAS FINALIZADAS ---"