DROP DATABASE IF exists miscompras;
CREATE DATABASE miscompras;
use miscompras;

CREATE TABLE clientes(
    id VARCHAR(20),
    nombre VARCHAR(40),
    apellidos VARCHAR(100),
    celular DECIMAL(10, 0),
    direccion VARCHAR(80),
    correo_electronico VARCHAR(70),

    CONSTRAINT pk_id PRIMARY KEY (id)
);

CREATE TABLE categorias(
    id_categoria INT,
    descripcion VARCHAR(45),
    estado TINYINT,

    CONSTRAINT pk_id_categoria PRIMARY KEY (id_categoria)
);

CREATE TABLE compras(
    id_compra INT,
    fecha DATETIME,
    medio_pago CHAR(1),
    comentario VARCHAR(300),
    estado CHAR(1),

    id_cliente VARCHAR(20),

    CONSTRAINT pk_id_compra PRIMARY KEY (id_compra),
    CONSTRAINT fk_compras_clientes FOREIGN KEY (id_cliente) REFERENCES clientes (id)
);

CREATE TABLE productos(
    id_producto INT,
    nombre VARCHAR(45),
    codigo_barras VARCHAR(150),
    precio_venta DECIMAL(16, 2),
    cantidad_stock INT,
    estado TINYINT,

    id_categoria INT,

    CONSTRAINT pk_id_producto PRIMARY KEY (id_producto),
    CONSTRAINT fk_productos_categorias FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

CREATE TABLE compras_productos(
    id_compra INT,
    id_producto INT,

    cantidad INT,
    total DECIMAL(16, 2),
    estado TINYINT,

    CONSTRAINT fk_compras_productos_compras FOREIGN KEY (id_compra) REFERENCES compras (id_compra),
    CONSTRAINT fk_compras_productos_productos FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);