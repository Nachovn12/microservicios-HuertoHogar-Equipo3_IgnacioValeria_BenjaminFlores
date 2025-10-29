# Microservicio de Usuarios - HuertoHogar

Hola profe, este es el microservicio de usuarios para HuertoHogar. Aquí le explico el paso a paso cómo levantarlo y probarlo.

## ¿Qué hace este micro?
- Registrar nuevos usuarios
- Consultar usuarios
- Actualizar perfiles
- Eliminar usuarios
- Listar todos los usuarios

## Tecnologías
- Java 17
- Spring Boot 3.1.5
- MySQL 8.0
- Maven
- Lombok

## Estructura del proyecto
```
src/main/java/com/huertohogar/usuarios/
├── controller/       → Endpoints REST
├── service/          → Lógica de negocio
├── repository/       → Acceso a BD
├── entity/           → Tablas de la BD
└── dto/              → Transferencia de datos
```

## Requisitos previos
Antes de empezar, asegúrate de tener instalado:
1. Java 17 (`java -version`)
2. Maven (`mvn -version`)
3. MySQL (`mysql --version`)
4. Spring Tool Suite 4 (o Eclipse)
5. Postman (opcional, para probar los endpoints)

## Paso a paso para compilar y ejecutar

### 1. Clonar el repositorio
Abre la terminal y ejecuta:
```bash
git clone https://github.com/Nachovn12/microservicios-HuertoHogar-Equipo3_IgnacioValeria_BenjaminFlores.git
cd microservicios-HuertoHogar-Equipo3_IgnacioValeria_BenjaminFlores
git checkout main
cd usuarios-microservice
```

### 2. Crear la base de datos y cargar datos de prueba
Abre MySQL Workbench o tu cliente favorito y ejecuta:
```sql
CREATE DATABASE huertohogar_usuarios;
```
Luego, ejecuta el script de prueba:
```sql
source src/main/resources/insert_usuarios_prueba.sql;
```
Esto cargará datos de ejemplo para facilitar las pruebas del microservicio.

### 3. Configurar la conexión a la base de datos
Abre el archivo `src/main/resources/application.properties` y pon tus datos:
```properties
server.port=8081
spring.datasource.url=jdbc:mysql://localhost:3306/huertohogar_usuarios
spring.datasource.username=root
spring.datasource.password=TU_PASSWORD_AQUI
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```
**Importante:** Cambia `TU_PASSWORD_AQUI` por tu contraseña real de MySQL.

### 4. Compilar el proyecto
En la terminal o desde Spring Tool Suite, ejecuta:
```bash
mvn clean install
```
Esto descarga las dependencias y compila todo. Si sale algún error, revisa la configuración de la base de datos y que tengas Java 17.

### 5. Ejecutar el microservicio
**Opción A - Desde terminal:**
```bash
mvn spring-boot:run
```
**Opción B - Desde Spring Tool Suite:**
- Busca la clase `UsuariosServiceApplication.java` en el explorador de proyectos
- Haz clic derecho y selecciona "Run As → Spring Boot App"
Si todo está bien, verás en la consola:
```
Tomcat started on port(s): 8081 (http)
Started UsuariosServiceApplication in X seconds
```

## Endpoints principales
Base URL: `http://localhost:8081`

1. **Registrar usuario**
   - POST `/api/usuarios/registro`
   - Body (JSON):
     {
       "email": "test@ejemplo.cl",
       "password": "123456",
       "nombre": "Juan",
       "apellido": "Pérez",
       "telefono": "912345678",
       "direccion": "Calle Falsa 123"
     }

2. **Listar todos los usuarios**
   - GET `/api/usuarios`

3. **Ver un usuario**
   - GET `/api/usuarios/1`

4. **Actualizar usuario**
   - PUT `/api/usuarios/1`
   - Body (JSON):
     {
       "nombre": "Juan Carlos",
       "telefono": "987654321"
     }

5. **Eliminar usuario**
   - DELETE `/api/usuarios/1`

## Probar con Postman
1. Abre Postman
2. Haz una petición POST a `http://localhost:8081/api/usuarios/registro` con el JSON de arriba
3. Haz una petición GET a `http://localhost:8081/api/usuarios` para ver todos los usuarios
4. Haz una petición PUT o DELETE para actualizar o eliminar

## Problemas comunes y soluciones
- **Port 8081 already in use:** Cambia el puerto en `application.properties` (por ejemplo, a 8082)
- **Access denied for user 'root':** Revisa tu contraseña en `application.properties`
- **Table 'usuarios' doesn't exist:** Verifica que `spring.jpa.hibernate.ddl-auto=update` esté en el properties
- **No compila:** Borra la carpeta `target/` y vuelve a hacer `mvn clean install`

## Verificar que todo funciona
1. El micro arranca sin errores
2. Los endpoints responden en Postman
3. Los datos se guardan en MySQL
4. Puedes hacer un CRUD completo (crear, leer, actualizar, eliminar)

## Archivos importantes
- `pom.xml` → Dependencias del proyecto
- `application.properties` → Configuración de BD y puerto
- `UsuariosServiceApplication.java` → Clase principal
- `Usuario.java` → Entity que mapea la tabla usuarios
- `UsuarioController.java` → Endpoints REST

## Equipo 3 - HuertoHogar
Ignacio Valeria
Benjamín Flores