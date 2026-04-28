
CREATE SCHEMA IF NOT EXISTS "userSchema";
CREATE SCHEMA IF NOT EXISTS "receta";
CREATE TABLE IF NOT EXISTS "userSchema".moneda (
  codigo CHAR(3) PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS "userSchema".usuario (
  id UUID PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  correoElectronico VARCHAR(100) NOT NULL,
  contraseñaHash VARCHAR(100) NOT NULL,
  monedaCodigo CHAR(3) NOT NULL DEFAULT 'MXN'
);

CREATE TABLE IF NOT EXISTS "userSchema".proveedor (
  id UUID PRIMARY KEY DEFAULT (gen_random_uuid()),
  nombre VARCHAR(30) NOT NULL,
  numCelular VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS "receta".unidad (
  id INT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  cantidadGramos INT
);

CREATE TABLE IF NOT EXISTS "receta".ingrediente (
  id INT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS "receta".marca (
  id INT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS "receta".tags (
  id INT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS "receta".tipo (
  id INT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS "receta".producto (
  id UUID PRIMARY KEY,
  idIngrediente INT NOT NULL,
  idMarca INT NOT NULL,
  idUnidad INT NOT NULL,
  pzas INT,
  precioMedio NUMERIC(10,2) NOT NULL,
  cantidadInventario INT NOT NULL,
  cantidadUnitario INT NOT NULL,
  idTipo INT NOT NULL,
  idUsuario UUID NOT NULL
);

CREATE TABLE IF NOT EXISTS "receta".receta (
  id UUID PRIMARY KEY,
  profit NUMERIC(10,2) NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  porcionesTotales INT NOT NULL,
  imagenURL VARCHAR(300),
  fechaCreacion TIMESTAMP NOT NULL DEFAULT (NOW()),
  fechaModificacion TIMESTAMP,
  idUsuario UUID NOT NULL
);

CREATE TABLE IF NOT EXISTS "receta".insumo (
  id UUID PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  precioUnitario NUMERIC(10,2) NOT NULL,
  idUnidad INT NOT NULL,
  idUsuario UUID NOT NULL
);

CREATE TABLE IF NOT EXISTS "receta".tagsreceta (
  idreceta UUID NOT NULL,
  idtags INT NOT NULL,
  PRIMARY KEY (idreceta, idtags)
);

CREATE TABLE IF NOT EXISTS "receta".productoproveedor (
  idproveedor UUID NOT NULL,
  idproducto UUID NOT NULL,
  precio NUMERIC(10,2) NOT NULL,
  PRIMARY KEY (idproveedor, idproducto)
);

CREATE TABLE IF NOT EXISTS "receta".recetaproducto (
  idreceta UUID NOT NULL,
  idproducto UUID NOT NULL,
  cantidad NUMERIC(10,2) NOT NULL,
  fechacreacion TIMESTAMP NOT NULL DEFAULT (NOW()),
  PRIMARY KEY (idreceta, idproducto)
);

CREATE TABLE IF NOT EXISTS "receta".recetainsumo (
  idreceta UUID NOT NULL,
  idinsumo UUID NOT NULL,
  cantidad NUMERIC(10,2) NOT NULL,
  PRIMARY KEY (idreceta, idinsumo)
);

CREATE TABLE IF NOT EXISTS "receta".recetapasos (
  id INT PRIMARY KEY,
  idreceta UUID NOT NULL,
  paso VARCHAR(300),
  orden INT NOT NULL
);

CREATE TABLE IF NOT EXISTS "receta".detalleentrada (
  id INT PRIMARY KEY,
  idproducto UUID NOT NULL,
  identrada UUID NOT NULL,
  precio NUMERIC(10,2) NOT NULL,
  cantidad NUMERIC(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS "receta".entrada (
  id UUID PRIMARY KEY,
  fecha DATE NOT NULL,
  estado BOOLEAN NOT NULL,
  total NUMERIC(10,2) NOT NULL,
  idProveedor UUID NOT NULL
);

CREATE TABLE IF NOT EXISTS "receta".detallesalida (
  id INT PRIMARY KEY,
  idsalida UUID NOT NULL,
  idproducto UUID NOT NULL,
  cantidad INT NOT NULL
);

CREATE TABLE IF NOT EXISTS "receta".salida (
  id UUID PRIMARY KEY,
  fecha DATE NOT NULL,
  estado BOOLEAN NOT NULL,
  total NUMERIC(10,2) NOT NULL,
  idReceta UUID NOT NULL
);
ALTER TABLE "userSchema".usuario ADD CONSTRAINT fk_usuario_moneda FOREIGN KEY (monedaCodigo) REFERENCES "userSchema".moneda (codigo) DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "receta".producto ADD CONSTRAINT fk_producto_ingrediente FOREIGN KEY (idIngrediente) REFERENCES "receta".ingrediente (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".producto ADD CONSTRAINT fk_producto_marca FOREIGN KEY (idMarca) REFERENCES "receta".marca (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".producto ADD CONSTRAINT fk_producto_unidad FOREIGN KEY (idUnidad) REFERENCES "receta".unidad (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".producto ADD CONSTRAINT fk_producto_tipo FOREIGN KEY (idTipo) REFERENCES "receta".tipo (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".producto ADD CONSTRAINT fk_producto_usuario FOREIGN KEY (idUsuario) REFERENCES "userSchema".usuario (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".receta ADD CONSTRAINT fk_receta_usuario FOREIGN KEY (idUsuario) REFERENCES "userSchema".usuario (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".tagsreceta ADD CONSTRAINT fk_tagsreceta_receta FOREIGN KEY (idreceta) REFERENCES "receta".receta (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".tagsreceta ADD CONSTRAINT fk_tagsreceta_tags FOREIGN KEY (idtags) REFERENCES "receta".tags (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".productoproveedor ADD CONSTRAINT fk_productoprov_proveedor FOREIGN KEY (idproveedor) REFERENCES "userSchema".proveedor (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".productoproveedor ADD CONSTRAINT fk_productoprov_producto FOREIGN KEY (idproducto) REFERENCES "receta".producto (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".recetaproducto ADD CONSTRAINT fk_recetaprod_receta FOREIGN KEY (idreceta) REFERENCES "receta".receta (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".recetaproducto ADD CONSTRAINT fk_recetaprod_producto FOREIGN KEY (idproducto) REFERENCES "receta".producto (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".recetainsumo ADD CONSTRAINT fk_recetaee_receta FOREIGN KEY (idreceta) REFERENCES "receta".receta (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".detalleentrada ADD CONSTRAINT fk_entrada_producto FOREIGN KEY (idproducto) REFERENCES "receta".producto (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".detallesalida ADD CONSTRAINT fk_salida_producto FOREIGN KEY (idproducto) REFERENCES "receta".producto (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".recetainsumo ADD FOREIGN KEY (idinsumo) REFERENCES "receta".insumo (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".recetapasos ADD FOREIGN KEY (idreceta) REFERENCES "receta".receta (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".salida ADD FOREIGN KEY (idreceta) REFERENCES "receta".receta (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".entrada ADD FOREIGN KEY (idProveedor) REFERENCES "userSchema".proveedor (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".detallesalida ADD FOREIGN KEY (idsalida) REFERENCES "receta".salida (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".detalleentrada ADD FOREIGN KEY (identrada) REFERENCES "receta".entrada (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".insumo ADD FOREIGN KEY (idUnidad) REFERENCES "receta".unidad (id) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta".insumo ADD FOREIGN KEY (idUsuario) REFERENCES "userSchema".usuario (id) DEFERRABLE INITIALLY IMMEDIATE;
