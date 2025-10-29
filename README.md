# Microservicios HuertoHogar

Este es el proyecto backend para HuertoHogar, una tienda online de productos del campo. Aquí explico paso a paso cómo levantar y revisar cada microservicio.

**Evaluación Parcial 2 - JVY0101**

**Equipo 3:**
- Ignacio Valeria
- Benjamín Flores

---

## ¿Qué hace este proyecto?
Contiene tres microservicios independientes para gestionar usuarios, productos y carritos de compra en la tienda HuertoHogar.

---

## Microservicios incluidos

### 1. usuarios-microservice
Permite registrar, consultar, actualizar y eliminar usuarios. Incluye autenticación con JWT.
- Puerto por defecto: 8081
- Base de datos: huertohogar_usuarios

### 2. core-microservice
Permite registrar, consultar, actualizar y eliminar productos y categorías.
- Puerto por defecto: 8082
- Base de datos: huertohogar_productos

### 3. carrito-microservice
Permite crear, consultar, actualizar y eliminar carritos de compra asociados a los usuarios.
- Puerto por defecto: 8083
- Base de datos: huertohogar_carritos

Cada microservicio tiene su propio README con ejemplos de endpoints y pruebas.

---

## Tecnologías utilizadas
- Java 17
- Spring Boot 3.1.5
- Spring Data JPA
- MySQL 8.0
- Maven
- Lombok

---


## Scripts de prueba
Cada microservicio incluye un script SQL con datos de prueba en su carpeta `src/main/resources`. Por ejemplo:
- `carrito-microservice/src/main/resources/insert_carritos_prueba.sql`
- `core-microservice/src/main/resources/insert_productos_prueba.sql`
- `usuarios-microservice/src/main/resources/insert_usuarios_prueba.sql`
Ejecute estos scripts en la base de datos correspondiente para cargar datos de ejemplo y facilitar las pruebas.

## Guía rápida para compilar y ejecutar

### 1. Clonar el repositorio
```bash
git clone https://github.com/Nachovn12/microservicios-HuertoHogar-Equipo3_IgnacioValeria_BenjaminFlores.git
cd microservicios-HuertoHogar-Equipo3_IgnacioValeria_BenjaminFlores
```

### 2. Crear las bases de datos
Abre tu cliente MySQL y ejecuta:
```sql
CREATE DATABASE huertohogar_usuarios;
CREATE DATABASE huertohogar_productos;
CREATE DATABASE huertohogar_carritos;
```

### 3. Configurar cada microservicio
- Abre el archivo `application.properties` de cada microservicio y pon tus datos de MySQL.
- Cambia el puerto si está ocupado.

### 4. Compilar y ejecutar un microservicio
```bash
cd <nombre-del-microservicio>
mvn clean install
mvn spring-boot:run
```
El microservicio estará disponible en el puerto configurado en su archivo `application.properties`.
Consulta el README específico de cada microservicio para ver los endpoints y ejemplos de prueba.

---

## Estructura del proyecto
```
microservicios-HuertoHogar/
├── core-microservice/
│   ├── src/
│   ├── pom.xml
│   └── README.md
├── usuarios-microservice/
│   ├── src/
│   ├── pom.xml
│   └── README.md
├── carrito-microservice/
│   ├── src/
│   ├── pom.xml
│   └── README.md
└── README.md
```

---

## Problemas comunes y soluciones
- **Puerto ocupado:** Cambia el puerto en `application.properties`.
- **Error de conexión a MySQL:** Revisa usuario y contraseña en `application.properties`.
- **No compila:** Borra la carpeta `target/` y vuelve a hacer `mvn clean install`.