# Microservicio de Productos - HuertoHogar

Este proyecto es el microservicio de productos para HuertoHogar. Permite registrar, consultar, actualizar y eliminar productos del catálogo.

## ¿Qué hace?
- Registrar productos nuevos
- Consultar productos
- Actualizar datos de producto
- Eliminar producto
- Listar productos

## Estructura
Carpetas principales:
- controller: aquí están los endpoints
- entity: aquí está la clase ProductoEntity
- repository: acceso a la base de datos
- service: lógica de producto
- dto: transferencia de datos
- model: categorías fijas

## Tecnologías
- Spring Boot
- Java 17
- MySQL
- Maven

## Puerto
Funciona en el puerto 8082

## ¿Cómo lo ejecuto?
1. Abre el proyecto en tu IDE
2. Configura la base de datos en `application.properties`
3. Corre la clase principal
4. Prueba los endpoints con Postman

## Endpoints
- POST /productos (registrar)
- GET /productos (listar)
- GET /productos/{id} (ver uno)
- PUT /productos/{id} (actualizar)
- DELETE /productos/{id} (eliminar)

## Guía rápida para revisar y probar el microservicio
Si vas a revisar este repositorio, aquí tienes ejemplos para probar los endpoints principales usando Postman, Insomnia o cualquier cliente REST. Así puedes validar que el microservicio funciona correctamente:

1. **Registrar producto**
	 - POST a `http://localhost:8082/productos`
	 - Body (JSON):
		 {
			 "codigo": "FR001",
			 "nombre": "Manzanas Fuji",
			 "descripcion": "Manzanas Fuji crujientes y dulces, cultivadas en el Valle del Maule.",
			 "categoria": "Frutas Frescas",
			 "origen": "Valle del Maule",
			 "stock": 150,
			 "precio": 1200
		 }

2. **Listar todos los productos**
	 - GET a `http://localhost:8082/productos`

3. **Actualizar producto**
	 - PUT a `http://localhost:8082/productos/1`
	 - Body (JSON):
		 {
			 "codigo": "FR001",
			 "nombre": "Manzanas Fuji",
			 "descripcion": "Manzanas Fuji crujientes y dulces, cultivadas en el Valle del Maule.",
			 "categoria": "Frutas Frescas",
			 "origen": "Valle del Maule",
			 "stock": 120,
			 "precio": 1100
		 }

4. **Eliminar producto**
	 - DELETE a `http://localhost:8082/productos/1`
