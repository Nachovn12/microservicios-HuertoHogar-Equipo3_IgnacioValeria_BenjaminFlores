# Microservicios HuertoHogar

Proyecto de microservicios para HuertoHogar, tienda online de productos del campo.

**Evaluación Parcial 2 - JVY0101**

**Equipo 3:**
- Ignacio Valeria
- Benjamín Flores

---

## Microservicios desarrollados

### usuario-service
Gestión de usuarios, autenticación y autorización con JWT.

- Puerto: 8081
- Base de datos: huertohogar_usuarios
- Estado: Terminado

### producto-service
Gestión de productos y categorías del catálogo.

- Puerto: 8082
- Base de datos: huertohogar_productos
- Estado: En desarrollo

### carrito-service
Gestión del carrito de compras.

- Puerto: 8083
- Base de datos: huertohogar_carritos
- Estado: En desarrollo

---

## Tecnologías

- Java 17
- Spring Boot 3.x
- Spring Data JPA
- MySQL 8.0
- Maven

---

## Instalación

### 1. Clonar el repositorio
```bash
git clone https://github.com/Nachovn12/microservicios-HuertoHogar-Equipo3_IgnacioValeria_BenjaminFlores.git
cd microservicios-HuertoHogar-Equipo3_IgnacioValeria_BenjaminFlores
```

### 2. Crear las bases de datos
```sql
CREATE DATABASE huertohogar_productos;
CREATE DATABASE huertohogar_usuarios;
CREATE DATABASE huertohogar_pedidos;
CREATE DATABASE huertohogar_carritos;
```

### 3. Ejecutar un microservicio
```bash
cd producto-service
mvn clean install
mvn spring-boot:run
```

El servicio estará en http://localhost:8081

---

## Estructura del proyecto
```
microservicios-HuertoHogar/
├── producto-service/
│   ├── src/
│   ├── pom.xml
│   └── README.md
├── usuario-service/
├── pedido-service/
├── carrito-service/
└── README.md
```

---
