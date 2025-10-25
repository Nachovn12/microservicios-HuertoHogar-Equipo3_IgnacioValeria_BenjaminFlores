# Microservicio de Carrito - HuertoHogar

Este proyecto es el microservicio de carrito para HuertoHogar. Permite crear, consultar, actualizar y eliminar carritos de compra asociados a los usuarios.

## ¿Qué hace?
- Crear carritos nuevos
- Consultar carritos
- Actualizar estado del carrito
- Eliminar carrito
- Listar carritos

## Estructura
Carpetas principales:
- controller: aquí están los endpoints
- entity: aquí está la clase CarritoEntity
- repository: acceso a la base de datos
- service: lógica de carrito
- dto: transferencia de datos

## Tecnologías
- Spring Boot
- Java 17
- MySQL
- Maven

## Puerto
Funciona en el puerto 8083

## ¿Cómo lo ejecuto?
1. Abre el proyecto en tu IDE
2. Configura la base de datos en `application.properties`
3. Corre la clase principal
4. Prueba los endpoints con Postman

## Endpoints
- POST /carritos (crear)
- GET /carritos (listar)
- GET /carritos/{id} (ver uno)
- PUT /carritos/{id} (actualizar)
- DELETE /carritos/{id} (eliminar)

## Guía rápida para revisar y probar el microservicio
Si vas a revisar este repositorio, aquí tienes ejemplos para probar los endpoints principales usando Postman, Insomnia o cualquier cliente REST. Así puedes validar que el microservicio funciona correctamente:

1. **Crear carrito**
	 - POST a `http://localhost:8083/carritos`

	 - Body (JSON):
		 {
			 "usuarioId": 1,
			 "estado": "Activo"
		 }

2. **Listar todos los carritos**
	 - GET a `http://localhost:8083/carritos`

3. **Actualizar carrito**
	 - PUT a `http://localhost:8083/carritos/1`

	 - Body (JSON):
		 {
			 "usuarioId": 1,
			 "estado": "Finalizado"
		 }

4. **Eliminar carrito**
	 - DELETE a `http://localhost:8083/carritos/1`