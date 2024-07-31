# CONSULTAS

## Consultas Básicas

### Consultar todos los productos y sus categorías

```sql
SELECT
	prod.id_producto,
	prod.nombre,
	prod.codigo_barras,
	prod.precio_venta,
	prod.cantidad_stock,
	prod.estado,
	prod.id_categoria,
	cat.descripcion AS descripcion_categoria,
	cat.estado AS estado_categoria
FROM productos prod
INNER JOIN categorias cat ON prod.id_categoria = cat.id_categoria;
```

### Consultar todas las compras y los clientes que las realizaron

```sql
SELECT
	com.id_compra,
	com.fecha,
	com.medio_pago,
	com.comentario,
	com.estado,
	com.id_cliente,
    cli.nombre AS nombre_cliente,
	cli.apellidos AS apellidos_cliente,
	cli.celular AS celular_cliente,
	cli.direccion AS direccion_cliente,
	cli.correo_electronico AS correo_cliente

FROM compras com
INNER JOIN clientes cli ON com.id_cliente = cli.id;
```

### Consultar los productos comprados en una compra específica

```sql
SELECT
	prod.id_producto,
	prod.nombre,
	prod.codigo_barras,
	prod.precio_venta,
	prod.cantidad_stock,
	prod.estado,
	prod.id_categoria
FROM productos prod
INNER JOIN compras_productos cp ON prod.id_producto = cp.id_producto
WHERE cp.id_compra = 0;
```

### Agregar un nuevo producto

```sql
INSERT INTO productos (id_producto, nombre, codigo_barras, precio_venta, cantidad_stock, estado, id_categoria) VALUES
    (3, 'Nuevo Prod', 'JOS-GGH-NEWW', 2700.08, 400, 3, 1);
```

### Actualizar el stock de un producto

```sql
UPDATE productos SET stock = 450 WHERE id_producto = 3;
```

### Consultar todas las compras de un cliente específico

```sql
SELECT
	comp.id_compra,
	comp.fecha,
	comp.medio_pago,
	comp.comentario,
	comp.estado,
	comp.id_cliente
FROM compras comp
INNER JOIN clientes cli ON comp.id_cliente = cli.id
WHERE cli.id = 'CLI000';
```

### Consultar todos los clientes y sus correos electrónicos

```sql
SELECT
	id,
    nombre,
    correo_electronico
FROM clientes;
```

### Consultar la cantidad total de productos comprados en cada compra

```sql
SELECT
	id_compra,
    id_producto,
    cantidad
FROM compras_productos;
```

### Consultar las compras realizadas en un rango de fechas

```sql
SELECT
	comp.id_compra,
	comp.fecha,
	comp.medio_pago,
	comp.comentario,
	comp.estado,
	comp.id_cliente
FROM compras comp
WHERE comp.fecha BETWEEN '2007-02-10 00:00:00' AND '2008-03-10 00:00:00';
```

## Consultas usando funciones agregadas

### Contar la cantidad de productos por categoría

```sql
SELECT
	prod.id_categoria,
	COUNT(prod.id_categoria) AS total_productos
FROM productos prod
GROUP BY prod.id_categoria;
```

### Calcular el precio total de ventas por cada cliente

```sql
SELECT
	cli.id,
    cli.nombre,
    SUM(cp.total) AS total_ventas
FROM clientes cli
INNER JOIN compras comp ON cli.id = comp.id_cliente
INNER JOIN compras_productos cp ON comp.id_compra = cp.id_compra
WHERE cli.id = 'CLI001';
```

### Calcular el precio promedio de los productos por categoría

```sql
SELECT
	cat.id_categoria,
    AVG(prod.precio_venta) AS promedio
FROM categorias cat
INNER JOIN productos prod ON cat.id_categoria = prod.id_categoria
GROUP BY cat.id_categoria;
```

### Encontrar la fecha de la primera y ultima compra registrada

```sql
SELECT
    MIN(fecha) AS primera_compra,
    MAX(fecha) AS ultima_compra
FROM compras;
```

### Calcular el total de ingresos por ventas

```sql
SELECT SUM(total) AS total_vendido FROM compras_productos;
```

### Contar la cantidad de compras realizadas por cada medio de pago

```sql
SELECT
	comp.medio_pago,
	SUM(cp.total) AS total_by_medioPago
FROM compras comp
INNER JOIN compras_productos cp ON comp.id_compra = cp.id_compra
GROUP BY comp.medio_pago;
```

### Calcular el total de productos vendidos por cada producto

```sql
SELECT
	id_producto,
	SUM(cantidad) total_vendidos
FROM compras_productos
GROUP BY id_producto;
```

### Obtener el promedio de cantidad de productos comprados por compra

```sql
SELECT
	id_compra,
	AVG(cantidad) promedio_vendidos
FROM compras_productos
GROUP BY id_compra;
```

### Encontrar los productos con el stock mas bajo

```sql
SELECT
	MIN(cantidad_stock) AS stock_minimo
FROM productos;
```

### Calcular el total del productos comprados y el total gastado por el cliente

```sql
SELECT
	SUM(total) AS total_gastadoByCliente,
    SUM(cantidad) AS total_productos_vendidos
FROM compras_productos;
```

## JOINS

### Compras y clientes

```sql
SELECT
	comp.id_compra,
	comp.fecha,
	comp.medio_pago,
	comp.comentario,
	comp.estado,
	comp.id_cliente,
    cli.nombre AS nombre_cliente,
	cli.apellidos AS apellidos_cliente,
	cli.celular AS celular_cliente,
	cli.direccion AS direccion_cliente,
	cli.correo_electronico AS correo_cliente
FROM compras comp
INNER JOIN clientes cli ON comp.id_cliente = cli.id
```

### Productos comprados en cada compra

```sql
	SELECT
	comp.id_compra,
    prod.id_producto,
	prod.nombre,
	prod.codigo_barras,
	prod.precio_venta,
	prod.cantidad_stock,
	prod.estado,
	prod.id_categoria
FROM productos prod
INNER JOIN compras_productos cp ON prod.id_producto = cp.id_producto
INNER JOIN compras comp ON cp.id_compra = comp.id_compra;
```

### Compras por cliente

```sql
	SELECT
	cli.id,
    cli.nombre,
    comp.id_compra,
	comp.fecha,
	comp.medio_pago,
	comp.comentario,
	comp.estado
FROM compras comp
INNER JOIN clientes cli ON comp.id_cliente = cli.id
WHERE cli.id = 'CLI002';
```

### Total gastado por cada cliente

```sql
SELECT
	cli.id,
    cli.nombre,
    SUM(total) AS total_gastado
FROM clientes cli
INNER JOIN compras comp ON cli.id = comp.id_cliente
INNER JOIN compras_productos cp ON comp.id_compra = cp.id_compra
GROUP BY cli.id;
```

### Stock disponible de productos y sus categorias

```sql
SELECT
	prod.id_producto,
    prod.nombre,
    prod.cantidad_stock,
    cat.id_categoria,
    cat.descripcion,
    cat.estado
FROM productos prod
INNER JOIN categorias cat ON prod.id_categoria = cat.id_categoria;
```

### Detalles compras informacion clientes y productos

```sql
SELECT
	cp.cantidad,
    cp.total,
    cp.estado AS estado_comp_prod,
    cli.nombre AS nombre_cliente,
	cli.apellidos AS apellidos_cliente,
	cli.celular AS celular_cliente,
	cli.direccion AS direccion_cliente,
	cli.correo_electronico AS correo_cliente,
    comp.id_compra,
	comp.fecha,
	comp.medio_pago,
	comp.comentario,
	comp.estado
FROM compras_productos cp
INNER JOIN compras comp ON cp.id_compra = comp.id_compra
INNER JOIN clientes cli ON comp.id_cliente = cli.id;

```

### Productos comprados por una cantidad especifica

```sql
SELECT
	prod.id_producto,
	prod.nombre,
	prod.codigo_barras,
	prod.precio_venta,
	prod.cantidad_stock,
	prod.estado,
	prod.id_categoria
FROM productos prod
INNER JOIN compras_productos cp ON prod.id_producto = cp.id_producto
WHERE cp.cantidad = 200;
```

### Cantidad total de productos vendidos por categoria

```sql
SELECT
	cat.id_categoria,
    cat.descripcion,
	COUNT(distinct(cp.id_producto)) AS cantidad_productos
FROM compras_productos cp
INNER JOIN productos prod ON cp.id_producto = prod.id_producto
INNER JOIN categorias cat ON prod.id_categoria = cat.id_categoria
GROUP BY cat.id_categoria;
```

### Clientes que han realizado compras en un rango de fechas especifico

```sql
SELECT
	cli.id,
    cli.nombre AS nombre_cliente,
	cli.apellidos AS apellidos_cliente,
	cli.celular AS celular_cliente,
	cli.direccion AS direccion_cliente,
	cli.correo_electronico AS correo_cliente,
    comp.fecha
FROM clientes cli
INNER JOIN compras comp ON cli.id = comp.id_cliente
WHERE comp.fecha BETWEEN '2006-01-10 00:00:00' AND '2007-02-10 00:00:00';
```

### Total gastado por cada cliente junto a la cantidad total de productos comprados

```sql
SELECT
	cli.id,
    SUM(cp.total) AS total_gastado,
    SUM(cp.cantidad) AS total_productos_comprados
FROM clientes cli
INNER JOIN compras comp ON cli.id = comp.id_cliente
INNER JOIN compras_productos cp ON comp.id_compra = cp.id_compra
GROUP BY cli.id;
```

### Consultar los productos que nunca han sido comprados

```sql
SELECT
    prod.id_producto,
    prod.nombre,
    prod.codigo_barras,
    prod.precio_venta
FROM
    productos prod
LEFT JOIN
    compras_productos cp ON p.id_producto = cp.id_producto
WHERE
    cp.idProducto IS NULL;
```

### Clientes con mas de una compra y el total gastado por ellos

```sql
SELECT
    cl.id,
    cl.nombre,
    cl.apellidos,
    COUNT(c.id_compra) AS totalCompras,
    SUM(cp.cantidad * p.precio_venta) AS totalGastado
FROM
    clientes cl
INNER JOIN
    compras c ON c.id_cliente = cl.id
INNER JOIN
    compras_productos cp ON cp.id_compra = c.id_compra
INNER JOIN
    productos p ON cp.id_producto = p.id_producto
GROUP BY
    cl.id, cl.nombre, cl.apellidos
HAVING
    COUNT(c.id_compra) > 1;
```

### Productos mas vendidos por categoria

```sql
SELECT
    cat.id_categoria,
    cat.descripcion,
    p.id_producto,
    p.nombre,
    SUM(cp.cantidad) AS total_vendidos
FROM categorias cat
INNER JOIN  productos p ON p.id_categoria = cat.id_categoria
INNER JOIN compras_productos cp ON cp.id_producto = p.id_producto
INNER JOIN compras c ON c.id_compra = cp.id_compra
GROUP BY cat.id_categoria, cat.descripcion, p.id_producto, p.nombre
ORDER BY cat.id_categoria, total_vendidos DESC;
```

### No se puede realizar

### No se puede realizar

## Sub consultas

### Productos con precio mayor al promedio de todos los productos

```sql
SELECT
	prod.id_producto,
    prod.nombre,
    prod.codigo_barras,
    prod.precio_venta
FROM productos prod
WHERE prod.precio_venta > (SELECT AVG(precio_venta) AS promedio FROM productos);
```

### Consultar las categorías que tienen más de 5 productos

```sql
SELECT
    cat.id_categoria,
    cat.descripcion,
    COUNT(prod.id_producto) AS totalProductos
FROM categorias cat
INNER JOIN productos prod ON prod.id_categoria = cat.id_categoria
GROUP BY cat.id_categoria, cat.descripcion
HAVING COUNT(prod.id_producto) > 5;
```

### Productos mas vendidos

```sql

```
