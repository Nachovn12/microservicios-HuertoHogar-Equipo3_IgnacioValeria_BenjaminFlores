package com.huertohogar.carrito.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import software.amazon.awssdk.auth.credentials.EnvironmentVariableCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.sqs.SqsClient;

@Configuration
public class SqsConfig {

    @Bean
    public SqsClient sqsClient() {
        String accessKey = System.getenv("AWS_ACCESS_KEY_ID");
        String secretKey = System.getenv("AWS_SECRET_ACCESS_KEY");

        System.out.println("=== SQS CONFIG ===");
        System.out.println("AWS_ACCESS_KEY_ID: " + (accessKey != null ? accessKey.substring(0, 4) + "..." : "NULL"));
        System.out.println("AWS_SECRET_ACCESS_KEY: " + (secretKey != null ? "***SET***" : "NULL"));
        System.out.println("==================");

        if (accessKey == null || secretKey == null) {
            throw new IllegalStateException("AWS credentials not found in environment variables");
        }

        return SqsClient.builder()
                .region(Region.US_EAST_1)
                .credentialsProvider(EnvironmentVariableCredentialsProvider.create())
                .build();
    }
}
