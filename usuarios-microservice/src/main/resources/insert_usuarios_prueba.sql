
-- Este script es solo para poner usuarios de prueba en la base de datos y poder probar el microservicio de usuario.

INSERT INTO usuario (nombre, correo, contrasena, direccion, telefono)
VALUES
('Camila Soto', 'camila.soto@gmail.com', 'chile2025', 'Av. Providencia 1234, Santiago', '987654321'),
('Felipe Rojas', 'felipe.rojas@hotmail.com', 'rojas123', 'Calle Los Robles 456, Concepción', '912345678'),
('Javiera Pino', 'javiera.pino@gmail.com', 'pino456', 'Av. Alemania 789, Temuco', '956789123'),
('Matías Herrera', 'matias.herrera@gmail.com', 'matias2025', 'Calle O''Higgins 321, Valparaíso', '934567890'),
('Sofía Muñoz', 'sofia.munoz@gmail.com', 'sofia321', 'Pasaje Las Flores 654, Puerto Montt', '945612378');
