INSERT INTO clientes (id, nombre, apellidos, celular, direccion, correo_electronico) VALUES 
    ('CLI000', 'Pepito', 'Perez', 1234567891.0, 'Calle 1, carrera 1', 'pepito@gmail.com'),
    ('CLI001', 'Juan', 'Gonzales', 1917641256.0, 'Calle 2, carrera 2', 'juan@gmail.com'),
    ('CLI002', 'Pedro', 'Sanchez', 5623451874.0, 'Calle 3, carrera 3', 'pedro@gmail.com');

INSERT INTO categorias (id_categoria, descripcion, estado) VALUES
    (0, 'Descripcion 1', 0),
    (1, 'Descripcion 2', 1),
    (2, 'Descripcion 3', 2);

INSERT INTO compras (id_compra, fecha, medio_pago, comentario, estado, id_cliente) VALUES
    (0, '2006-01-10', 0, 'Comentario 1', 0, 'CLI000'),
    (1, '2007-02-10', 1, 'Comentario 2', 1, 'CLI001'),
    (2, '2008-03-10', 2, 'Comentario 3', 2, 'CLI002');

INSERT INTO productos (id_producto, nombre, codigo_barras, precio_venta, cantidad_stock, estado, id_categoria) VALUES
    (0, 'Computadores', 'AAA-BBB-CCC', 1500.08, 100, 0, 0),
    (1, 'Impresoras', 'DDD-000-XYZ', 1450.00, 200, 1, 1),
    (2, 'Celulares', 'OOI-787-XWC', 2780.60, 300, 2, 2);

INSERT INTO compras_productos (id_compra, id_producto, cantidad, total, estado) VALUES
    (0, 0, 100, 1500.08, 0),
    (1, 1, 200, 1450.00, 1),
    (2, 2, 300, 2780.60, 2);