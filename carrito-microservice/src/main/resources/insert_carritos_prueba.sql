-- Script de datos de prueba para carrito-service
-- Puedes ejecutar este script en la base de datos huertohogar_carritos para probar el microservicio

-- Insertar carritos
INSERT INTO carrito_entity (usuario_id, estado) VALUES
(1, 'Activo'),
(2, 'Finalizado');

-- Insertar ítems del carrito
INSERT INTO item_del_carrito_entity (producto_id, cantidad, precio_unitario, carrito_id) VALUES
(1, 2, 1200, 1), -- 2 Manzanas Fuji en el carrito 1
(2, 1, 1000, 1), -- 1 Naranja Valencia en el carrito 1
(3, 3, 800, 2);  -- 3 Plátanos Cavendish en el carrito 2
