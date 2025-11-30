#!/bin/bash
# Script para aprovisionar recursos en AWS (SQS)
# Requisito: Tener AWS CLI configurado

QUEUE_NAME="HuertoHogar-Orders"
REGION="us-east-1"

echo "--- Iniciando aprovisionamiento de recursos AWS ---"

# 1. Crear Cola SQS
echo "Verificando si la cola $QUEUE_NAME existe..."

QUEUE_URL=$(aws sqs get-queue-url --queue-name $QUEUE_NAME --region $REGION --output text 2>&1)

if [[ $? -ne 0 ]]; then
    echo "La cola no existe. Creando cola $QUEUE_NAME..."
    aws sqs create-queue --queue-name $QUEUE_NAME --region $REGION
    echo "✅ Cola creada exitosamente."
else
    echo "ℹ️ La cola ya existe: $QUEUE_URL"
fi

echo "--- Aprovisionamiento completado ---"
