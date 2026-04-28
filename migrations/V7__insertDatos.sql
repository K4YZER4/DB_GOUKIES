-- Insertar moneda MXN
INSERT INTO "userSchema".moneda (codigo, nombre) VALUES ('MXN', 'Peso Mexicano');

-- Insertar usuario
INSERT INTO "userSchema".usuario (id, nombre, correoElectronico, contraseñaHash, monedaCodigo) 
VALUES ('550e8400-e29b-41d4-a716-446655440000', 'Galletas Deliciosas', 'admin@galletasdeliciosas.com', 'hashed_password_123', 'MXN');

-- Insertar unidades
INSERT INTO "receta".unidad (id, nombre, cantidadGramos) VALUES 
(1, 'gramo', 1),
(2, 'mililitro', 1),
(3, 'libra', 453.592),
(4, 'kilogramo', 1000),
(5, 'cucharada', 15),
(6, 'taza', 240);

-- Insertar ingredientes (insumos base)
INSERT INTO "receta".ingrediente (id, nombre) VALUES 
(1, 'Harina'),
(2, 'Azúcar'),
(3, 'Mantequilla'),
(4, 'Huevo'),
(5, 'Vainilla'),
(6, 'Polvo de Hornear'),
(7, 'Sal'),
(8, 'Chocolate');

-- Insertar marcas
INSERT INTO "receta".marca (id, nombre) VALUES 
(1, 'Genérica'),
(2, 'Premium'),
(3, 'La Costeña');

-- Insertar tipos de producto
INSERT INTO "receta".tipo (id, nombre) VALUES 
(1, 'Ingrediente'),
(2, 'Acabado');

-- Insertar tags
INSERT INTO "receta".tags (id, nombre) VALUES 
(1, 'Dulce'),
(2, 'Integral'),
(3, 'Sin Gluten');

-- Insertar productos (convertidos a gramos como cantidad unitaria)
-- Harina 1kg a 30 pesos
INSERT INTO "receta".producto (id, idIngrediente, idMarca, idUnidad, pzas, precioMedio, cantidadInventario, cantidadUnitario, idTipo, idUsuario) VALUES 
('650e8400-e29b-41d4-a716-446655440001', 1, 1, 4, 1, 30.00, 100, 1000, 1, '550e8400-e29b-41d4-a716-446655440000');

-- Mantequilla 500g a 60 pesos
INSERT INTO "receta".producto (id, idIngrediente, idMarca, idUnidad, pzas, precioMedio, cantidadInventario, cantidadUnitario, idTipo, idUsuario) VALUES 
('650e8400-e29b-41d4-a716-446655440002', 3, 1, 1, 1, 60.00, 50, 500, 1, '550e8400-e29b-41d4-a716-446655440000');

-- Azúcar 1kg a 25 pesos
INSERT INTO "receta".producto (id, idIngrediente, idMarca, idUnidad, pzas, precioMedio, cantidadInventario, cantidadUnitario, idTipo, idUsuario) VALUES 
('650e8400-e29b-41d4-a716-446655440003', 2, 1, 4, 1, 25.00, 80, 1000, 1, '550e8400-e29b-41d4-a716-446655440000');

-- Huevo por docena a 45 pesos (unidad = 1 huevo = ~50g)
INSERT INTO "receta".producto (id, idIngrediente, idMarca, idUnidad, pzas, precioMedio, cantidadInventario, cantidadUnitario, idTipo, idUsuario) VALUES 
('650e8400-e29b-41d4-a716-446655440004', 4, 1, 1, 12, 45.00, 100, 50, 1, '550e8400-e29b-41d4-a716-446655440000');

-- Polvo de Hornear 100g a 12 pesos
INSERT INTO "receta".producto (id, idIngrediente, idMarca, idUnidad, pzas, precioMedio, cantidadInventario, cantidadUnitario, idTipo, idUsuario) VALUES 
('650e8400-e29b-41d4-a716-446655440005', 6, 1, 1, 1, 12.00, 30, 100, 1, '550e8400-e29b-41d4-a716-446655440000');

-- Chocolate 500g a 80 pesos
INSERT INTO "receta".producto (id, idIngrediente, idMarca, idUnidad, pzas, precioMedio, cantidadInventario, cantidadUnitario, idTipo, idUsuario) VALUES 
('650e8400-e29b-41d4-a716-446655440006', 8, 2, 1, 1, 80.00, 40, 500, 1, '550e8400-e29b-41d4-a716-446655440000');

-- Insertar insumos (ingredientes que el usuario crea)
-- Mezcla base para galletas
INSERT INTO "receta".insumo (id, nombre, precioUnitario, idUnidad, idUsuario) VALUES 
('750e8400-e29b-41d4-a716-446655440001', 'Mezcla Base', 5.50, 1, '550e8400-e29b-41d4-a716-446655440000');

-- Decoración
INSERT INTO "receta".insumo (id, nombre, precioUnitario, idUnidad, idUsuario) VALUES 
('750e8400-e29b-41d4-a716-446655440002', 'Decoración de Azúcar', 2.00, 1, '550e8400-e29b-41d4-a716-446655440000');

-- RECETA 1: Galletas de Vainilla (150% profit)
INSERT INTO "receta".receta (id, profit, nombre, porcionesTotales, imagenURL, idUsuario) VALUES 
('850e8400-e29b-41d4-a716-446655440001', 150.00, 'Galletas de Vainilla', 24, 'https://example.com/galletas-vainilla.jpg', '550e8400-e29b-41d4-a716-446655440000');

-- RECETA 2: Galletas de Chocolate (225% profit)
INSERT INTO "receta".receta (id, profit, nombre, porcionesTotales, imagenURL, idUsuario) VALUES 
('850e8400-e29b-41d4-a716-446655440002', 225.00, 'Galletas de Chocolate', 20, 'https://example.com/galletas-chocolate.jpg', '550e8400-e29b-41d4-a716-446655440000');

-- RECETA 3: Galletas de Mantequilla (200% profit)
INSERT INTO "receta".receta (id, profit, nombre, porcionesTotales, imagenURL, idUsuario) VALUES 
('850e8400-e29b-41d4-a716-446655440003', 200.00, 'Galletas de Mantequilla', 18, 'https://example.com/galletas-mantequilla.jpg', '550e8400-e29b-41d4-a716-446655440000');

-- RECETA 4: Galletas Integrales (150% profit)
INSERT INTO "receta".receta (id, profit, nombre, porcionesTotales, imagenURL, idUsuario) VALUES 
('850e8400-e29b-41d4-a716-446655440004', 150.00, 'Galletas Integrales', 22, 'https://example.com/galletas-integrales.jpg', '550e8400-e29b-41d4-a716-446655440000');

-- RECETA 5: Galletas Decoradas (225% profit)
INSERT INTO "receta".receta (id, profit, nombre, porcionesTotales, imagenURL, idUsuario) VALUES 
('850e8400-e29b-41d4-a716-446655440005', 225.00, 'Galletas Decoradas', 16, 'https://example.com/galletas-decoradas.jpg', '550e8400-e29b-41d4-a716-446655440000');

-- RELACIONES RECETA-INSUMO
-- Receta 1: Galletas de Vainilla - 200g mezcla base
INSERT INTO "receta".recetainsumo (idreceta, idinsumo, cantidad) VALUES 
('850e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440001', 200.00);

-- Receta 2: Galletas de Chocolate - 250g mezcla base
INSERT INTO "receta".recetainsumo (idreceta, idinsumo, cantidad) VALUES 
('850e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440001', 250.00);

-- Receta 3: Galletas de Mantequilla - 180g mezcla base
INSERT INTO "receta".recetainsumo (idreceta, idinsumo, cantidad) VALUES 
('850e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440001', 180.00);

-- Receta 4: Galletas Integrales - 220g mezcla base
INSERT INTO "receta".recetainsumo (idreceta, idinsumo, cantidad) VALUES 
('850e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440001', 220.00);

-- Receta 5: Galletas Decoradas - 200g mezcla base, 30g decoración
INSERT INTO "receta".recetainsumo (idreceta, idinsumo, cantidad) VALUES 
('850e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440001', 200.00),
('850e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440002', 30.00);

-- RELACIONES RECETA-PRODUCTO
-- Receta 1: Galletas de Vainilla - 300g harina, 150g azúcar, 100g mantequilla, 2 huevos
INSERT INTO "receta".recetaproducto (idreceta, idproducto, cantidad) VALUES 
('850e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', 300.00),
('850e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440003', 150.00),
('850e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440002', 100.00),
('850e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440004', 100.00);

-- Receta 2: Galletas de Chocolate - 350g harina, 180g azúcar, 120g mantequilla, 2 huevos, 80g chocolate
INSERT INTO "receta".recetaproducto (idreceta, idproducto, cantidad) VALUES 
('850e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440001', 350.00),
('850e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440003', 180.00),
('850e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440002', 120.00),
('850e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440004', 100.00),
('850e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440006', 80.00);

-- Receta 3: Galletas de Mantequilla - 280g harina, 140g azúcar, 150g mantequilla, 2 huevos, 5g polvo hornear
INSERT INTO "receta".recetaproducto (idreceta, idproducto, cantidad) VALUES 
('850e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440001', 280.00),
('850e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440003', 140.00),
('850e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440002', 150.00),
('850e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440004', 100.00),
('850e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440005', 5.00);

-- Receta 4: Galletas Integrales - 320g harina, 160g azúcar, 110g mantequilla, 2 huevos, 5g polvo hornear
INSERT INTO "receta".recetaproducto (idreceta, idproducto, cantidad) VALUES 
('850e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440001', 320.00),
('850e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440003', 160.00),
('850e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440002', 110.00),
('850e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440004', 100.00),
('850e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440005', 5.00);

-- Receta 5: Galletas Decoradas - 300g harina, 150g azúcar, 100g mantequilla, 2 huevos, 60g chocolate
INSERT INTO "receta".recetaproducto (idreceta, idproducto, cantidad) VALUES 
('850e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440001', 300.00),
('850e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440003', 150.00),
('850e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440002', 100.00),
('850e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440004', 100.00),
('850e8400-e29b-41d4-a716-446655440005', '650e8400-e29b-41d4-a716-446655440006', 60.00);

-- Asignar tags a recetas
INSERT INTO "receta".tagsreceta (idreceta, idtags) VALUES 
('850e8400-e29b-41d4-a716-446655440001', 1),
('850e8400-e29b-41d4-a716-446655440002', 1),
('850e8400-e29b-41d4-a716-446655440003', 1),
('850e8400-e29b-41d4-a716-446655440004', 2),
('850e8400-e29b-41d4-a716-446655440005', 1);
