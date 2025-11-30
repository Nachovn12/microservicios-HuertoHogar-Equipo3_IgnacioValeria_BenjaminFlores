package com.huertohogar.carrito.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.sqs.model.SendMessageRequest;
import software.amazon.awssdk.services.sqs.model.SendMessageResponse;

import java.util.HashMap;
import java.util.Map;

@Service
public class SqsProducerService {

    @Autowired
    private SqsClient sqsClient;

    @Value("${huertohogar.sqs.queue.name}")
    private String queueName;

    private final ObjectMapper objectMapper = new ObjectMapper();

    public void sendOrderConfirmation(Long carritoId, String usuarioEmail) {
        try {
            // Crear payload JSON
            Map<String, Object> payload = new HashMap<>();
            payload.put("orderId", "ORD-" + System.currentTimeMillis());
            payload.put("carritoId", carritoId);
            payload.put("email", usuarioEmail);
            payload.put("status", "CONFIRMED");
            payload.put("timestamp", System.currentTimeMillis());

            String messageBody = objectMapper.writeValueAsString(payload);

            System.out.println("=== ENVIANDO MENSAJE A SQS ===");
            System.out.println("Cola: " + queueName);
            System.out.println("Mensaje: " + messageBody);

            // Construir URL de la cola
            String accountId = getAccountId();
            if (accountId == null || accountId.trim().isEmpty()) {
                throw new IllegalStateException("AWS Account ID no encontrado");
            }

            String queueUrl = "https://sqs.us-east-1.amazonaws.com/" + accountId + "/" + queueName;

            System.out.println("URL Generada: " + queueUrl);

            // Enviar mensaje
            SendMessageRequest sendMsgRequest = SendMessageRequest.builder()
                    .queueUrl(queueUrl)
                    .messageBody(messageBody)
                    .build();

            SendMessageResponse response = sqsClient.sendMessage(sendMsgRequest);

            System.out.println("Mensaje enviado exitosamente. MessageId: " + response.messageId());
            System.out.println("===============================");

        } catch (Exception e) {
            System.err.println("ERROR al enviar mensaje a SQS: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Error al enviar mensaje a SQS: " + e.getMessage(), e);
        }
    }

    private String getAccountId() {
        // Usar variable de entorno o el ID correcto descubierto (115507373802)
        return System.getenv().getOrDefault("AWS_ACCOUNT_ID", "115507373802");
    }
}
