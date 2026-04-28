CREATE SCHEMA "userSchema";

CREATE SCHEMA "receta";

CREATE TABLE "userSchema"."usuario" (
  "id" UUID PRIMARY KEY,
  "nombre" "VARCHAR(30)" NOT NULL,
  "correoElectronico" "VARCHAR(100)" NOT NULL,
  "contraseñaHash" "VARCHAR(100)" NOT NULL
);

CREATE TABLE "userSchema"."proveedor" (
  "id" UUID PRIMARY KEY DEFAULT (gen_random_uuid()),
  "nombre" "VARCHAR(30)" NOT NULL,
  "numCelular" "VARCHAR(15)" NOT NULL
);

CREATE TABLE "receta"."unidad" (
  "id" INT PRIMARY KEY,
  "nombre" "VARCHAR(30)" NOT NULL,
  "cantidadGramos" INT
);

CREATE TABLE "receta"."ingrediente" (
  "id" INT PRIMARY KEY,
  "nombre" "VARCHAR(50)" NOT NULL
);

CREATE TABLE "receta"."marca" (
  "id" INT PRIMARY KEY,
  "nombre" "VARCHAR(30)" NOT NULL
);

CREATE TABLE "receta"."tags" (
  "id" INT PRIMARY KEY,
  "nombre" "VARCHAR(30)" NOT NULL
);

CREATE TABLE "receta"."tipo" (
  "id" INT PRIMARY KEY,
  "nombre" "VARCHAR(50)" NOT NULL
);

CREATE TABLE "receta"."producto" (
  "id" UUID PRIMARY KEY,
  "idIngrediente" INT NOT NULL,
  "idMarca" INT NOT NULL,
  "idUnidad" INT NOT NULL,
  "pzas" INT,
  "precioMedio" "NUMERIC(10,2)" NOT NULL,
  "cantidadInventario" INT NOT NULL,
  "cantidadUnitario" INT NOT NULL,
  "idTipo" INT NOT NULL,
  "idUsuario" UUID NOT NULL
);

CREATE TABLE "receta"."receta" (
  "id" UUID PRIMARY KEY,
  "profit" INT NOT NULL,
  "nombre" "VARCHAR(30)" NOT NULL,
  "porcionesTotales" INT NOT NULL,
  "imagenURL" "VARCHAR(300)",
  "fechaCreacion" TIMESTAMP NOT NULL DEFAULT (NOW()),
  "fechaModificacion" TIMESTAMP,
  "idUsuario" UUID NOT NULL
);

CREATE TABLE "receta"."insumo" (
  "id" UUID PRIMARY KEY,
  "nombre" varchar(50) NOT NULL,
  "precioUnitario" "NUMERIC(10,2)" NOT NULL,
  "idUnidad" INT NOT NULL,
  "idUsuario" uuid NOT NULL
);

CREATE TABLE "receta"."tagsReceta" (
  "idReceta" UUID NOT NULL,
  "idTags" INT NOT NULL,
  PRIMARY KEY ("idReceta", "idTags")
);

CREATE TABLE "receta"."productoProveedor" (
  "idProveedor" UUID NOT NULL,
  "idProducto" uuid NOT NULL,
  "precio" "NUMERIC(10,2)" NOT NULL,
  PRIMARY KEY ("idProveedor", "idProducto")
);

CREATE TABLE "receta"."recetaProducto" (
  "idReceta" UUID NOT NULL,
  "idProducto" UUID NOT NULL,
  "fechaCreacion" TIMESTAMP NOT NULL DEFAULT (NOW()),
  PRIMARY KEY ("idReceta", "idProducto")
);

CREATE TABLE "receta"."recetaInsumo" (
  "idReceta" UUID NOT NULL,
  "idInsumo" uuid NOT NULL,
  "cantidad" "NUMERIC(10,2)" NOT NULL,
  PRIMARY KEY ("idReceta", "idInsumo")
);

CREATE TABLE "receta"."recetaPasos" (
  "id" INT PRIMARY KEY,
  "idReceta" uuid NOT NULL,
  "paso" "VARCHAR(300)",
  "orden" INT NOT NULL
);

CREATE TABLE "receta"."detalleEntrada" (
  "id" INT PRIMARY KEY,
  "idProducto" uuid NOT NULL,
  "idEntrada" UUID NOT NULL,
  "precio" "NUMERIC(10,2)" NOT NULL,
  "cantidad" "NUMERIC(10,2)" NOT NULL
);

CREATE TABLE "receta"."entrada" (
  "id" UUID PRIMARY KEY,
  "fecha" DATE NOT NULL,
  "estado" BIT NOT NULL,
  "total" "NUMERIC(10,2)" NOT NULL,
  "idProveedor" UUID NOT NULL
);

CREATE TABLE "receta"."detalleSalida" (
  "id" INT PRIMARY KEY,
  "idSalida" uuid NOT NULL,
  "idProducto" uuid NOT NULL,
  "cantidad" INT NOT NULL
);

CREATE TABLE "receta"."salida" (
  "id" UUID PRIMARY KEY,
  "fecha" DATE NOT NULL,
  "estado" BIT NOT NULL,
  "total" "NUMERIC(10,2)" NOT NULL,
  "idReceta" uuid NOT NULL
);

ALTER TABLE "receta"."producto" ADD CONSTRAINT "fk_producto_ingrediente" FOREIGN KEY ("idIngrediente") REFERENCES "receta"."ingrediente" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."producto" ADD CONSTRAINT "fk_producto_marca" FOREIGN KEY ("idMarca") REFERENCES "receta"."marca" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."producto" ADD CONSTRAINT "fk_producto_unidad" FOREIGN KEY ("idUnidad") REFERENCES "receta"."unidad" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."producto" ADD CONSTRAINT "fk_producto_tipo" FOREIGN KEY ("idTipo") REFERENCES "receta"."tipo" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."producto" ADD CONSTRAINT "fk_producto_usuario" FOREIGN KEY ("idUsuario") REFERENCES "userSchema"."usuario" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."receta" ADD CONSTRAINT "fk_receta_usuario" FOREIGN KEY ("idUsuario") REFERENCES "userSchema"."usuario" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."tagsReceta" ADD CONSTRAINT "fk_tagsReceta_receta" FOREIGN KEY ("idReceta") REFERENCES "receta"."receta" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."tagsReceta" ADD CONSTRAINT "fk_tagsReceta_tags" FOREIGN KEY ("idTags") REFERENCES "receta"."tags" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."productoProveedor" ADD CONSTRAINT "fk_productoProv_proveedor" FOREIGN KEY ("idProveedor") REFERENCES "userSchema"."proveedor" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."productoProveedor" ADD CONSTRAINT "fk_productoProv_producto" FOREIGN KEY ("idProducto") REFERENCES "receta"."producto" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."recetaProducto" ADD CONSTRAINT "fk_recetaProd_receta" FOREIGN KEY ("idReceta") REFERENCES "receta"."receta" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."recetaProducto" ADD CONSTRAINT "fk_recetaProd_producto" FOREIGN KEY ("idProducto") REFERENCES "receta"."producto" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."recetaInsumo" ADD CONSTRAINT "fk_recetaEE_receta" FOREIGN KEY ("idReceta") REFERENCES "receta"."receta" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."detalleEntrada" ADD CONSTRAINT "fk_entrada_producto" FOREIGN KEY ("idProducto") REFERENCES "receta"."producto" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."detalleSalida" ADD CONSTRAINT "fk_salida_producto" FOREIGN KEY ("idProducto") REFERENCES "receta"."producto" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."recetaInsumo" ADD FOREIGN KEY ("idInsumo") REFERENCES "receta"."insumo" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."recetaPasos" ADD FOREIGN KEY ("idReceta") REFERENCES "receta"."receta" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."salida" ADD FOREIGN KEY ("idReceta") REFERENCES "receta"."receta" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."entrada" ADD FOREIGN KEY ("idProveedor") REFERENCES "userSchema"."proveedor" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."detalleSalida" ADD FOREIGN KEY ("idSalida") REFERENCES "receta"."salida" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."detalleEntrada" ADD FOREIGN KEY ("idEntrada") REFERENCES "receta"."entrada" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."insumo" ADD FOREIGN KEY ("idUnidad") REFERENCES "receta"."unidad" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "receta"."insumo" ADD FOREIGN KEY ("idUsuario") REFERENCES "userSchema"."usuario" ("id") DEFERRABLE INITIALLY IMMEDIATE;
