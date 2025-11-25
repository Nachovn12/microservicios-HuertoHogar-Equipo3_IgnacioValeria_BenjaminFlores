# 🌊 Flujo de Mensajería Asíncrona: Productor y Consumidor

Este documento describe el flujo de mensajería asíncrona implementado usando **Amazon Simple Queue Service (SQS)** y **AWS Lambda** para desacoplar el proceso de confirmación de pedidos.

## 🎯 Objetivo

Garantizar que la confirmación de un pedido por parte del usuario sea rápida, delegando el procesamiento pesado (ej. actualización de inventario, envío de emails) a un proceso que se ejecuta en segundo plano.

## 🔗 Componentes del Flujo

| Rol | Componente | AWS Servicio | Descripción |
| :--- | :--- | :--- | :--- |
| **PRODUCTOR** | `carrito-microservice` | N/A (Microservicio) | Cuando un usuario confirma su carrito, este microservicio **envía el mensaje** JSON con los detalles del pedido a la cola SQS. |
| **COLA** | `HuertoHogar-OrderQueue` | SQS | Almacena temporalmente los mensajes de los pedidos en espera de ser procesados por el consumidor. |
| **CONSUMIDOR**| `HuertoHogar-ProcessOrder` | AWS Lambda | Se activa automáticamente cada vez que un mensaje llega a la cola SQS. Procesa la información del pedido y registra la acción. |

## 📐 Diagrama Lógico del Flujo

1.  **Usuario** hace POST a `/carritos/{id}/confirmar`.
2.  **`carrito-microservice`** (Productor) recibe la solicitud.
3.  **`carrito-microservice`** envía el mensaje del pedido a la cola **SQS** (`HuertoHogar-OrderQueue`).
4.  **SQS** notifica y dispara la función **AWS Lambda** (`HuertoHogar-ProcessOrder`).
5.  **AWS Lambda** (Consumidor) lee el mensaje, registra el pedido en los logs (CloudWatch) y completa el procesamiento.

Este diseño asegura que el microservicio del carrito no se bloquee esperando que se complete la tarea de procesamiento del pedido.