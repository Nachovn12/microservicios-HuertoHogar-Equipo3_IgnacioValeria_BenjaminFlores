-- Script de datos de prueba para producto-service
-- Puedes ejecutar este script en la base de datos huertohogar_productos para probar el microservicio

INSERT INTO producto (codigo, nombre, descripcion, categoria, origen, stock, precio)
VALUES
('FR001', 'Manzanas Fuji', 'Manzanas Fuji crujientes y dulces, cultivadas en el Valle del Maule.', 'Frutas Frescas', 'Valle del Maule', 150, 1200),
('FR002', 'Naranjas Valencia', 'Jugosas y ricas en vitamina C, ideales para zumos frescos.', 'Frutas Frescas', 'Valparaíso', 200, 1000),
('FR003', 'Plátanos Cavendish', 'Plátanos maduros y dulces, perfectos para el desayuno.', 'Frutas Frescas', 'Santiago', 250, 800),
('VR001', 'Zanahorias Orgánicas', 'Zanahorias crujientes cultivadas sin pesticidas.', 'Verduras Orgánicas', 'O''Higgins', 100, 900),
('VR002', 'Espinacas Frescas', 'Espinacas frescas y nutritivas, perfectas para ensaladas.', 'Verduras Orgánicas', 'Puerto Montt', 80, 700),
('VR003', 'Pimientos Tricolores', 'Pimientos rojos, amarillos y verdes, ideales para salteados.', 'Verduras Orgánicas', 'Concepción', 120, 1500),
('PO001', 'Miel Orgánica', 'Miel pura y orgánica producida por apicultores locales.', 'Productos Orgánicos', 'Nacimiento', 50, 5000);
