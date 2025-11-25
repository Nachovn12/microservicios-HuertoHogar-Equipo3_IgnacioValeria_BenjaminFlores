# Microservicios HuertoHogar

Este proyecto implementa el backend de HuertoHogar, una tienda online de productos del campo, usando arquitectura de microservicios y Docker Swarm para alta disponibilidad y escalabilidad.

**Equipo 3:**
- Ignacio Valeria
- Benjamín Flores

---

## Descripción general

El sistema está compuesto por tres microservicios independientes:
- **usuarios-microservice:** Gestión y autenticación de usuarios (JWT). Puerto 8081.
- **core-microservice:** Gestión de productos y categorías. Puerto 8082.
- **carrito-microservice:** Gestión de carritos de compra asociados a usuarios. Puerto 8083.

Cada microservicio tiene su propia base de datos en MySQL y su propio README con ejemplos de endpoints.

---

## Tecnologías utilizadas

- Java 17
- Spring Boot 3.1.5
- Spring Data JPA
- MySQL 8.0
- Maven
- Lombok
- Docker & Docker Swarm

---

## Estructura del proyecto

```
microservicios-HuertoHogar/
├── core-microservice/
├── usuarios-microservice/
├── carrito-microservice/
├── docker-compose.yml
├── docker-compose.swarm.yml
├── init.sql
├── docs/
│   └── SWARM-COMMANDS.md
└── README.md
```

---

## Scripts de prueba

Cada microservicio incluye un script SQL con datos de prueba en `src/main/resources`:
- `insert_carritos_prueba.sql`
- `insert_productos_prueba.sql`
- `insert_usuarios_prueba.sql`

Ejecute estos scripts en la base de datos correspondiente para cargar datos de ejemplo.

---

## Despliegue local (desarrollo)

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/Nachovn12/microservicios-HuertoHogar-Equipo3_IgnacioValeria_BenjaminFlores.git
   cd microservicios-HuertoHogar-Equipo3_IgnacioValeria_BenjaminFlores
   ```

2. **Crear las bases de datos**
   Abre tu cliente MySQL y ejecuta:
   ```sql
   CREATE DATABASE huertohogar_usuarios;
   CREATE DATABASE huertohogar_productos;
   CREATE DATABASE huertohogar_carritos;
   ```

3. **Configurar cada microservicio**
   - Edita `application.properties` en cada microservicio con tus datos de MySQL.
   - Cambia el puerto si está ocupado.

4. **Compilar y ejecutar un microservicio**
   ```bash
   cd <nombre-del-microservicio>
   mvn clean install
   mvn spring-boot:run
   ```
   El microservicio estará disponible en el puerto configurado.

---

## Despliegue en Docker Swarm (producción)

Para producción y alta disponibilidad, implementamos Docker Swarm. Esto permite escalar los microservicios y gestionar múltiples nodos (manager y workers).

### ¿Cómo está implementado?

- Cada microservicio se empaqueta como imagen Docker y se publica en Docker Hub:
  - [Usuarios](https://hub.docker.com/r/nachovn114/huertohogar-usuarios)
  - [Core/Productos](https://hub.docker.com/r/nachovn114/huertohogar-core)
  - [Carrito](https://hub.docker.com/r/nachovn114/huertohogar-carrito)
- El archivo `docker-compose.swarm.yml` define los servicios, replicas, redes y variables de entorno para Swarm.
- El servicio MySQL se ejecuta solo en el nodo manager y persiste los datos con volúmenes.
- Cada microservicio se conecta a la base de datos usando el nombre del servicio (`mysqldb`) como host.
- El despliegue se realiza con el comando:
  ```bash
  docker stack deploy -c docker-compose.swarm.yml huertohogar
  ```
- Los comandos esenciales para administrar el clúster están documentados en [`docs/SWARM-COMMANDS.md`](docs/SWARM-COMMANDS.md).

### Ejemplo de despliegue y escalado

1. Inicializar Swarm en el manager:
   ```bash
   docker swarm init --advertise-addr IP_PRIVADA_MANAGER
   ```
2. Agregar workers con el token generado.
3. Desplegar el stack:
   ```bash
   docker stack deploy -c docker-compose.swarm.yml huertohogar
   ```
4. Escalar servicios:
   ```bash
   docker service scale huertohogar_core-ms=3
   ```
5. Ver logs y estado de los servicios:
   ```bash
   docker service ls
   docker service logs huertohogar_usuarios-ms
   ```

---

## Ventajas de la arquitectura

- Permite alta disponibilidad y escalabilidad.
- Cada microservicio es independiente y puede actualizarse sin afectar a los demás.
- El uso de Docker Hub facilita la integración con CI/CD y despliegue automatizado.
- La documentación y scripts permiten que cualquier miembro del equipo o evaluador pueda replicar el entorno fácilmente.

---

## Enlaces útiles

- [Repositorio en GitHub](https://github.com/Nachovn12/microservicios-HuertoHogar-Equipo3_IgnacioValeria_BenjaminFlores)
- [Imágenes en Docker Hub](https://hub.docker.com/u/nachovn114)
- [Documentación de comandos Swarm](docs/SWARM-COMMANDS.md)

---

## Problemas comunes y soluciones

- **Puerto ocupado:** Cambia el puerto en `application.properties`.
- **Error de conexión a MySQL:** Revisa usuario y contraseña en `application.properties`.
- **No compila:** Borra la carpeta `target/` y vuelve a hacer `mvn clean install`.