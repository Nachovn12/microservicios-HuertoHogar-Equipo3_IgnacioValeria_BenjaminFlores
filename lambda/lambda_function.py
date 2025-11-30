import json
import logging
import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    """
    Función que procesa los mensajes que llegan de la cola SQS.
    """
    logger.info("🚀 Lambda ProcessOrder iniciada")

    for record in event['Records']:
        try:
            # El cuerpo del mensaje de SQS viene como texto JSON.
            message_body = json.loads(record['body'])

            # Extrae el ID del pedido para registrarlo.
            order_id = message_body.get('orderId', 'N/A')
            email = message_body.get('email', 'N/A')

            logger.info(f"Procesando pedido: {order_id} para {email}")

        except Exception as e:
            logger.error(f"❌ Error al procesar el mensaje: {e}")

    return {
        'statusCode': 200,
        'body': json.dumps('Pedidos procesados con éxito')
    }