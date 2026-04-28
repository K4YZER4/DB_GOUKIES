
CREATE OR REPLACE VIEW receta.vwProducto AS
SELECT
  p.id,
  ing.nombre        AS nombre_ingrediente,
  m.nombre          AS marca,
  u.nombre          AS unidad,
  p.pzas,
  p.precioMedio     AS precio_medio,
  p.cantidadInventario,
  p.cantidadUnitario,
  t.nombre          AS tipo,
  p.idUsuario,
  us.nombre         AS usuario_nombre
FROM receta.producto p
LEFT JOIN receta.ingrediente ing ON p.idIngrediente = ing.id
LEFT JOIN receta.marca ing2 ON p.idMarca = ing2.id
LEFT JOIN receta.marca m ON p.idMarca = m.id
LEFT JOIN receta.unidad u ON p.idUnidad = u.id
LEFT JOIN receta.tipo t ON p.idTipo = t.id
LEFT JOIN "userSchema".usuario us ON p.idUsuario = us.id;

CREATE OR REPLACE VIEW receta.vwInsumo AS
SELECT
  i.id,
  i.nombre,
  i.precioUnitario,
  u.nombre         AS unidad,
  i.idUsuario,
  us.nombre        AS usuario_nombre
FROM receta.insumo i
LEFT JOIN receta.unidad u ON i.idUnidad = u.id
LEFT JOIN "userSchema".usuario us ON i.idUsuario = us.id;

CREATE OR REPLACE VIEW receta.vwrecetainsumo AS
SELECT
  ri.idreceta,
  r.nombre         AS receta_nombre,
  ri.idinsumo,
  i.nombre         AS insumo_nombre,
  ri.cantidad,
  i.precioUnitario,
  (ri.cantidad * i.precioUnitario)::numeric(12,2) AS costo_estimado
FROM receta.recetainsumo ri
JOIN receta.receta r ON ri.idreceta = r.id
JOIN receta.insumo i ON ri.idinsumo = i.id;

CREATE OR REPLACE VIEW receta.vwrecetaproducto AS
SELECT
  rp.idreceta,
  r.nombre         AS receta_nombre,
  rp.idproducto,
  ing.nombre       AS producto_ingrediente,
  p.precioMedio,
  p.cantidadUnitario,
  rp.cantidad,
  (rp.cantidad * p.precioMedio)::numeric(12,2) AS costo_estimado
FROM receta.recetaproducto rp
JOIN receta.receta r ON rp.idreceta = r.id
JOIN receta.producto p ON rp.idproducto = p.id
LEFT JOIN receta.ingrediente ing ON p.idIngrediente = ing.id;