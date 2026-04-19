use mysql2;


DELIMITER $$

CREATE FUNCTION fn_calcular_total_con_iva(p_id_pedido INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    
    SELECT SUM(subtotal) INTO total
    FROM detalle_pedido
    WHERE id_pedido = p_id_pedido;
    
    RETURN total * 1.19;
END $$

DELIMITER ;

use mysql2;


SELECT fn_calcular_total_con_iva(1) AS total_con_iva;


use mysql2;

DELIMITER $$

CREATE FUNCTION fn_validar_stock(p_id_producto INT, p_cantidad INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE stock_disponible INT;
    
    SELECT stock_actual INTO stock_disponible
    FROM productos
    WHERE id_producto = p_id_producto;
    
    IF stock_disponible >= p_cantidad THEN
        RETURN 'Hay suficiente stock disponible';
    ELSE
        RETURN 'No hay stock suficiente';
    END IF;
END $$

DELIMITER ;


SELECT fn_validar_stock(1, 50) AS resultado;
SELECT fn_validar_stock(1, 200) AS resultado;

