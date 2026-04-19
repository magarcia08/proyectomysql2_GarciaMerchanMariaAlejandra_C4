use mysql2;


-- primer trigger: actualizar stock después de insertar un detalle de pedido
DELIMITER $$

CREATE TRIGGER tr_actualizar_stock
AFTER INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    DECLARE stock_nuevo INT;

    SET stock_nuevo = (
        SELECT stock_actual - NEW.cantidad
        FROM productos
        WHERE id_producto = NEW.id_producto
    );

    UPDATE productos
    SET stock_actual = stock_nuevo
    WHERE id_producto = NEW.id_producto;
END $$

DELIMITER ;

-- prueba

SELECT stock_actual FROM productos WHERE id_producto = 1;


-- dos veces insert into
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal)
VALUES (1, 1, 10, 25000.00);

-- final
SELECT stock_actual FROM productos WHERE id_producto = 1;

-- segundo trigger: auditar cambios de precio

use mysql2;


DELIMITER $$

CREATE TRIGGER tr_auditar_cambio_precio
BEFORE UPDATE ON productos
FOR EACH ROW
BEGIN
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO auditoria_precios (id_producto, precio_anterior, precio_nuevo, fecha_cambio)
        VALUES (OLD.id_producto, OLD.precio, NEW.precio, NOW());
    END IF;
END $$

DELIMITER ;


-- datos de prueba
SELECT precio FROM productos WHERE id_producto = 1;

UPDATE productos SET precio = 3000.00 WHERE id_producto = 1;

-- auditoria

SELECT * FROM auditoria_precios;
