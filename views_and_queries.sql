
-- primera vista: resumen de pedidos por sede
use mysql2;


CREATE VIEW resumen_pedidos_sede AS
SELECT 
    s.nombre_sede,
    COUNT(p.id_pedido) AS total_pedidos,
    SUM(p.total_con_iva) AS total_ventas
FROM pedidos p
JOIN sedes s ON p.id_sede = s.id_sede
GROUP BY s.nombre_sede;

SELECT * FROM resumen_pedidos_sede;


-- segunda vista: productos con stock por debajo del mínimo

CREATE VIEW productos_bajo_stock AS
SELECT 
    id_producto,
    nombre,
    categoria,
    stock_actual,
    stock_minimo
FROM productos
WHERE stock_actual <= stock_minimo;

SELECT * FROM productos_bajo_stock;

-- tercera vista: clientes activos con número de pedidos
use mysql2;



CREATE VIEW vista_clientes_activos AS
SELECT 
    c.id_cliente,
    c.nombre_completo,
    c.telefono,
    c.correo_electronico,
    COUNT(p.id_pedido) AS total_pedidos
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre_completo, c.telefono, c.correo_electronico;


SELECT * FROM vista_clientes_activos;

-- consultas
-- Consultar los productos con stock por debajo del mínimo.
SELECT id_producto, nombre, categoria, stock_actual, stock_minimo
FROM productos
WHERE stock_actual <= stock_minimo;

--consultar los pedidos realizados entre dos fechas (BETWEEN).
SELECT id_pedido, fecha_pedido, total_sin_iva, total_con_iva
FROM pedidos
WHERE fecha_pedido BETWEEN '2026-01-01' AND '2026-02-28';

-- Listar los productos más vendidos (con JOIN y GROUP BY).

SELECT p.nombre, SUM(dp.cantidad) AS total
FROM detalle_pedido dp
JOIN productos p ON dp.id_producto = p.id_producto
GROUP BY p.nombre
ORDER BY total_vendido DESC;

--Mostrar clientes y la cantidad de pedidos realizados.
SELECT c.nombre_completo, COUNT(p.id_pedido) AS total
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.nombre_completo;

-- Buscar clientes por nombre parcial usando LIKE.
SELECT * FROM clientes
WHERE nombre_completo LIKE '%García%';

-- Consultar productos de ciertas categorías usando IN.
SELECT nombre, categoria, precio
FROM productos
WHERE categoria IN ('Cola', 'Agua', 'Isotónica');

-- Mostrar el cliente con mayor número de pedidos (subconsulta).
SELECT nombre_completo
FROM clientes
WHERE id_cliente = (
    SELECT id_cliente
    FROM pedidos
    GROUP BY id_cliente
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- Consultar pedidos y sus totales agrupados por sede.
SELECT s.nombre_sede, 
       COUNT(p.id_pedido) AS total_de_pedidos,
       SUM(p.total_con_iva) AS total_ventas
FROM pedidos p
JOIN sedes s ON p.id_sede = s.id_sede
GROUP BY s.nombre_sede;