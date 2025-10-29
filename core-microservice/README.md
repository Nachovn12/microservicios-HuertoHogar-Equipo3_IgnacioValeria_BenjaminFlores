# Microservicio de Productos - HuertoHogar

Hola profe, este es el microservicio de productos para HuertoHogar. Aquí le explico el paso a paso cómo levantarlo y probarlo.

## ¿Qué hace este micro?
- Registrar nuevos productos
- Consultar productos
- Actualizar productos
- Eliminar productos
- Listar todos los productos

## Tecnologías
- Java 17
- Spring Boot 3.1.5
- MySQL 8.0
- Maven
- Lombok

## Estructura del proyecto
```
src/main/java/com/huertohogar/producto/
├── controller/       → Endpoints REST
├── service/          → Lógica de negocio
├── repository/       → Acceso a BD
├── entity/           → Tablas de la BD
├── dto/              → Transferencia de datos
├── model/            → Modelos de negocio (categorías)
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
cd core-microservice
```

### 2. Crear la base de datos y cargar datos de prueba
Abre MySQL Workbench o tu cliente favorito y ejecuta:
```sql
CREATE DATABASE huertohogar_productos;
```
Luego, ejecuta el script de prueba:
```sql
source src/main/resources/insert_productos_prueba.sql;
```
Esto cargará datos de ejemplo para facilitar las pruebas del microservicio.

### 3. Configurar la conexión a la base de datos
Abre el archivo `src/main/resources/application.properties` y pon tus datos:
```properties
server.port=8082
spring.datasource.url=jdbc:mysql://localhost:3306/huertohogar_productos
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
- Busca la clase `CoreMicroserviceApplication.java` en el explorador de proyectos
- Haz clic derecho y selecciona "Run As → Spring Boot App"
Si todo está bien, verás en la consola:
```
Tomcat started on port(s): 8082 (http)
Started CoreMicroserviceApplication in X seconds
```

## Endpoints principales
Base URL: `http://localhost:8082`

1. **Registrar producto**
	 - POST `/api/productos`
	 - Body (JSON):
		 {
			 "nombre": "Lechuga",
			 "categoria": "Verdura",
			 "precio": 500,
			 "stock": 100
		 }

2. **Listar todos los productos**
	 - GET `/api/productos`

3. **Ver un producto**
	 - GET `/api/productos/1`

4. **Actualizar producto**
	 - PUT `/api/productos/1`
	 - Body (JSON):
		 {
			 "precio": 600,
			 "stock": 80
		 }

5. **Eliminar producto**
	 - DELETE `/api/productos/1`

## Probar con Postman
1. Abre Postman
2. Haz una petición POST a `http://localhost:8082/api/productos` con el JSON de arriba
3. Haz una petición GET a `http://localhost:8082/api/productos` para ver todos los productos
4. Haz una petición PUT o DELETE para actualizar o eliminar

## Problemas comunes y soluciones
- **Port 8082 already in use:** Cambia el puerto en `application.properties` (por ejemplo, a 8083)
- **Access denied for user 'root':** Revisa tu contraseña en `application.properties`
- **Table 'productos' doesn't exist:** Verifica que `spring.jpa.hibernate.ddl-auto=update` esté en el properties
- **No compila:** Borra la carpeta `target/` y vuelve a hacer `mvn clean install`

## Verificar que todo funciona
1. El micro arranca sin errores
2. Los endpoints responden en Postman
3. Los datos se guardan en MySQL
4. Puedes hacer un CRUD completo (crear, leer, actualizar, eliminar)

## Archivos importantes
- `pom.xml` → Dependencias del proyecto
- `application.properties` → Configuración de BD y puerto
- `CoreMicroserviceApplication.java` → Clase principal
- `Producto.java` → Entity que mapea la tabla productos
- `ProductoController.java` → Endpoints REST

## Equipo 3 - HuertoHogar
Ignacio Valeria
Benjamín Flores