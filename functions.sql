use mysql2;

-- primera función: calcular total con IVA para un pedido

DELIMITER $$

CREATE FUNCTION calcular_total_con_iva(p_id_pedido INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE subtotal_suma DECIMAL(10,2);
    DECLARE valor_iva DECIMAL(10,2);
    DECLARE total_final DECIMAL(10,2);

    SELECT SUM(subtotal) INTO subtotal_suma
    FROM detalle_pedido
    WHERE id_pedido = p_id_pedido;

    SET valor_iva   = subtotal_suma * 0.19;
    SET total_final = subtotal_suma + valor_iva;

    RETURN total_final;
END $$

DELIMITER ;

use mysql2;

-- prueba de validacion
SELECT calcular_total_con_iva(1) AS total_con_iva;


-- segunda función: validar stock disponible para un producto

use mysql2;

DELIMITER $$

CREATE FUNCTION validar_stock(p_id_producto INT, p_cantidad INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE stock_disponible INT;
    DECLARE mensaje VARCHAR(100);

    SELECT stock_actual INTO stock_disponible
    FROM productos
    WHERE id_producto = p_id_producto;

    SET mensaje = 'No hay stock suficiente';

    IF stock_disponible >= p_cantidad THEN
        SET mensaje = 'Hay suficiente stock disponible';
    END IF;

    RETURN mensaje;
END $$

DELIMITER ;

-- validando 

SELECT validar_stock(1, 50) AS resultado;
SELECT validar_stock(1, 200) AS resultado;

