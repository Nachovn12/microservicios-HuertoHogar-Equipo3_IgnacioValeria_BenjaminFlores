

# Microservicio de Usuarios - HuertoHogar

Este proyecto es el microservicio de usuarios para HuertoHogar. Permite registrar, iniciar sesión, actualizar y eliminar usuarios.

## ¿Qué hace?

- Registrar usuarios nuevos
- Iniciar sesión
- Actualizar datos de usuario
- Eliminar usuario
- Listar usuarios

## Estructura

Carpetas principales:
- controller: aquí están los endpoints
- model: aquí está la clase Usuario
- repository: acceso a la base de datos
- service: lógica de usuario

## Tecnologías

- Spring Boot
- Java 17
- MySQL
- Maven

## Puerto

Funciona en el puerto 8081

## ¿Cómo lo ejecuto?

1. Abre el proyecto en tu IDE
2. Configura la base de datos en `application.properties`
3. Corre la clase principal
4. Prueba los endpoints con Postman

## Endpoints

- POST /usuarios (registrar)
- POST /usuarios/login (login)
- GET /usuarios (listar)
- GET /usuarios/{id} (ver uno)
- PUT /usuarios/{id} (actualizar)
- DELETE /usuarios/{id} (eliminar)



## Guía rápida para revisar y probar el microservicio

Si vas a revisar este repositorio, aquí tienes ejemplos para probar los endpoints principales usando Postman, Insomnia o cualquier cliente REST. Así puedes validar que el microservicio funciona correctamente:

1. **Registrar usuario**
   - POST a `http://localhost:8081/usuarios`
   - Body (JSON):
     {
       "nombre": "Camila Soto",
       "correo": "camila.soto@gmail.com",
       "contrasena": "chile2025"
     }

2. **Login de usuario**
   - POST a `http://localhost:8081/usuarios/login`
   - Body (JSON):
     {
       "correo": "camila.soto@gmail.com",
       "contrasena": "chile2025"
     }

3. **Listar todos los usuarios**
   - GET a `http://localhost:8081/usuarios`

4. **Actualizar usuario**
   - PUT a `http://localhost:8081/usuarios/1`
   - Body (JSON):
     {
       "nombre": "Felipe Rojas",
       "correo": "felipe.rojas@hotmail.com",
       "contrasena": "rojas123"
     }

5. **Eliminar usuario**
   - DELETE a `http://localhost:8081/usuarios/1`
