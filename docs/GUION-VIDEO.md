# 🎬 Guion de Video - Borrador de la Persona B (AWS/DevOps)

**Tiempo estimado:** 4-5 minutos de la presentación total (los 9-10 minutos restantes).

## 1. Introducción y Arquitectura (Juntos con Persona A)

* **Punto a cubrir:** Describir brevemente el rol de los componentes AWS en el diseño general.
* **TU FRASE CLAVE:** "Como Persona B, configuré toda la infraestructura AWS para un despliegue escalable y el flujo de mensajería asíncrona, utilizando EC2, SQS y Lambda."

## 2. Demostración de Infraestructura (AWS Console)

* **Punto a cubrir:** Mostrar la Consola de AWS y los servicios clave.
* **DEMO:**
    * Mostrar la cola **SQS** (`HuertoHogar-OrderQueue`) creada. Explicar: "Esta cola desacopla el microservicio del carrito del procesamiento de pedidos."
    * Mostrar la función **Lambda** (`HuertoHogar-ProcessOrder`). Explicar: "Esta función es el consumidor. Se activa solo cuando llega un mensaje a SQS."
    * Mostrar la **conexión** (Event Source Mapping) entre SQS y Lambda.
    * Mostrar el **API Gateway** y el **JWT Authorizer**. Explicar: "Configuré el punto de entrada a la aplicación con seguridad a través de un Authorizer JWT, protegiendo todos los endpoints."

## 3. Demostración de Docker Swarm y Escalabilidad

* **Punto a cubrir:** Mostrar las instancias EC2 y el clúster Docker Swarm.
* **DEMO:**
    * Mostrar las 3 **Instancias EC2** (1 Manager, 2 Workers) corriendo.
    * Ejecutar `docker node ls` en la máquina Manager para mostrar los 3 nodos activos.
    * Ejecutar `docker service ls` para mostrar que los servicios están desplegados.
    * **ESCABILIDAD:** Ejecutar `docker service scale [nombre_servicio]=4` para mostrar el escalado horizontal en tiempo real.

## 4. Demostración de Flujo Completo y CI/CD

* **Punto a cubrir:** Demostrar el flujo Productor $\to$ Consumidor y el *pipeline* de despliegue.
* **DEMO:**
    * **FLUJO:** Usar el script **`demo-completo.sh`** (ejecutado por la Persona A o tú) para enviar un pedido y **mostrar los logs de CloudWatch** (tu rol) para probar que Lambda procesó el mensaje de SQS.
    * **CI/CD:** Mostrar el historial de GitHub Actions y el código del archivo `.github/workflows/ci-cd.yml`. Explicar: "Un *push* a la rama principal dispara el *pipeline* que construye, prueba, publica en Docker Hub y actualiza el *stack* de Swarm en AWS."

## 5. Cierre (Juntos)

* **Punto a cubrir:** Breve conclusión sobre los objetivos cumplidos (disponibilidad, escalabilidad, automatización).