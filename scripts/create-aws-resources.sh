#!/bin/bash
# Aprovisionamiento de recursos AWS para HuertoHogar

QUEUE_NAME="HuertoHogar-Orders"
REGION="us-east-1"

# Verificar credenciales
if ! aws sts get-caller-identity &> /dev/null; then
    echo "Error: AWS CLI no configurado."
    exit 1
fi

# Crear cola si no existe
if aws sqs get-queue-url --queue-name "$QUEUE_NAME" --region "$REGION" &> /dev/null; then
    echo "SQS: La cola '$QUEUE_NAME' ya existe."
else
    echo "SQS: Creando cola '$QUEUE_NAME'..."
    aws sqs create-queue --queue-name "$QUEUE_NAME" --region "$REGION"
    echo "SQS: Cola creada exitosamente."
fi
