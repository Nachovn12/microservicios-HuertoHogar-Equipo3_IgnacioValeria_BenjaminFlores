# Microservicios HuertoHogar

Este proyecto implementa el backend de HuertoHogar, una tienda online de productos del campo, utilizando una arquitectura de microservicios moderna, contenerizada con Docker Swarm, orquestada con CI/CD y potenciada por servicios Cloud de AWS (SQS y Lambda).

**Equipo 3:**

- Ignacio Valeria
- Benjamín Flores

---

## 🏗️ Arquitectura del Sistema

El sistema está compuesto por los siguientes componentes distribuidos:

### Microservicios (Spring Boot)

- **api-gateway:** Puerta de entrada única (Spring Cloud Gateway). Puerto **8080**.
- **usuarios-microservice:** Gestión y autenticación de usuarios (JWT). Puerto Interno 8081.
- **core-microservice:** Catálogo de productos y categorías. Puerto Interno 8082.
- **carrito-microservice:** Gestión de compras y pedidos. Puerto Interno 8083.
  - _Productor SQS:_ Envía mensajes de confirmación de pedido a la nube.

### Servicios Cloud (AWS)

- **Amazon SQS:** Cola de mensajes (`HuertoHogar-Orders`) para desacoplar el proceso de compra.
- **AWS Lambda:** Función Serverless (Python) que consume mensajes de la cola y procesa los pedidos asíncronamente.

### Base de Datos

- **MySQL 8.0:** Contenedor único con bases de datos separadas por microservicio (`huertohogar_usuarios`, `huertohogar_productos`, `huertohogar_carritos`).

---

## 🚀 Tecnologías Utilizadas

- **Backend:** Java 17, Spring Boot 3.1.5, Spring Data JPA, Spring Cloud Gateway.
- **Base de Datos:** MySQL 8.0.
- **Contenedores:** Docker, Docker Swarm (Orquestación).
- **Cloud:** AWS SDK (SQS), AWS Lambda (Serverless).
- **CI/CD:** GitHub Actions (Pipeline automatizado de Build, Test y Deploy).
- **Herramientas:** Maven, Lombok, Postman.

---

## 📂 Estructura del Proyecto

```
microservicios-HuertoHogar/
├── api-gateway/            # Gateway principal
├── core-microservice/      # Catálogo de productos
├── usuarios-microservice/  # Autenticación
├── carrito-microservice/   # Compras y SQS Producer
├── lambda/                 # Función Serverless (Python)
├── scripts/                # Scripts de utilidad (Testing, AWS)
├── .github/workflows/      # Pipelines de CI/CD
├── docker-compose.swarm.yml # Definición del Stack para Producción
└── README.md
```

---

## ⚙️ Despliegue y Ejecución

### 1. Requisitos Previos

- Docker y Docker Compose instalados.
- Cuenta de AWS (para SQS/Lambda) con credenciales configuradas.
- Java 17 y Maven (opcional si se usa Docker).

### 2. Despliegue en Docker Swarm (Producción)

El proyecto está diseñado para correr en un clúster Swarm.

1. **Inicializar Swarm:**

   ```bash
   docker swarm init
   ```

2. **Configurar Credenciales:**
   Crear un archivo `.env` con las credenciales de AWS y DB (ver `docker-compose.swarm.yml` para variables requeridas).

3. **Desplegar el Stack:**

   ```bash
   docker stack deploy -c docker-compose.swarm.yml huertohogar
   ```

4. **Escalar Servicios:**
   ```bash
   docker service scale huertohogar_carrito-ms=3
   ```

### 3. Pipeline de CI/CD

El proyecto cuenta con un pipeline automatizado en GitHub Actions (`.github/workflows/deploy.yml`) que:

1. Compila todos los microservicios (Maven).
2. Construye imágenes Docker optimizadas (Multi-stage).
3. Sube las imágenes a Docker Hub.
4. Despliega automáticamente a AWS (si se configura EC2).
5. Aprovisiona recursos Cloud (Cola SQS) automáticamente.

---

## 🧪 Pruebas End-to-End

Para validar el flujo completo (Compra -> API -> Microservicio -> SQS -> Lambda), utilice el script de prueba incluido:

```powershell
./scripts/test-end-to-end.ps1
```

Este script:

1. Crea un carrito.
2. Agrega productos.
3. Confirma la compra.
4. Verifica la respuesta exitosa del backend.

---

## 🔗 Enlaces

- [Repositorio GitHub](https://github.com/Nachovn12/microservicios-HuertoHogar-Equipo3_IgnacioValeria_BenjaminFlores)
- [Docker Hub (Imágenes)](https://hub.docker.com/u/nachovn114)
