show databases;

create database mysql2;

use mysql2;

show tables;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    identificacion VARCHAR(20)  NOT NULL UNIQUE,
    direccion VARCHAR(150),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100)
);

use mysql2;

CREATE TABLE sedes (
    id_sede INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sede VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(150),
    capacidad_almacenamiento INT,
    encargado VARCHAR(100)
);


CREATE TABLE productos ( 
	id_producto INT AUTO_INCREMENT PRIMARY KEY, 
	nombre VARCHAR(100) NOT NULL, 
	categoria VARCHAR(100) NOT NULL, 
	precio DECIMAL(10,2), 
	volumen_ml INT, 
	stock_actual INT, 
	stock_minimo INT 
);

use mysql2;

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha_pedido DATE NOT NULL,
    id_cliente INT,
    id_sede INT,
    total_sin_iva DECIMAL(10,2),
    total_con_iva DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_sede) REFERENCES sedes(id_sede)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE auditoria_precios (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    precio_anterior DECIMAL(10,2),
    precio_nuevo DECIMAL(10,2),
    fecha_cambio DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
        ON DELETE CASCADE ON UPDATE CASCADE
);

show tables;


use mysql2;


INSERT INTO clientes (nombre_completo, identificacion, direccion, telefono, correo_electronico) VALUES
('Carlos Andrés Gómez', '13456789', 'Calle 5 #10-20 Girón', '3101234567', 'carlos@gmail.com'),
('María Fernanda López', '27891234', 'Carrera 8 #15-30 Bucaramanga', '3209876543', 'maria@hotmail.com'),
('Juan Pablo Martínez', '91234567', 'Av. Los Cedros #22-10 Piedecuesta', '3154567890', 'juan@yahoo.com'),
('Lucía Esperanza Ruiz', '45678912', 'Calle 12 #8-45 Girón', '3187654321', 'lucia@gmail.com'),
('Pedro Antonio Silva', '78912345', 'Carrera 15 #30-60 Bucaramanga', '3112345678', 'pedro@outlook.com'),
('Diana Carolina Peña', '32165498', 'Calle 20 #5-30 Girón', '3123456789', 'diana@gmail.com'),
('Andrés Felipe Mora', '65498732', 'Carrera 10 #40-15 Bucaramanga', '3198765432', 'andres@hotmail.com'),
('Valentina Castro', '98732165', 'Av. Principal #12-50 Piedecuesta', '3167891234', 'valentina@yahoo.com'),
('Jorge Iván Herrera', '14725836', 'Calle 8 #22-40 Girón', '3145678901', 'jorge@gmail.com'),
('Natalia Bermúdez', '25836914', 'Carrera 5 #18-25 Bucaramanga', '3156789012', 'natalia@outlook.com'),
('Sebastián Vargas', '36914725', 'Calle 30 #6-10 Piedecuesta', '3178901234', 'sebastian@gmail.com'),
('Camila Jiménez', '47025836', 'Carrera 12 #25-35 Girón', '3189012345', 'camila@hotmail.com');

-- 2. SEDES (12)
INSERT INTO sedes (nombre_sede, ubicacion, capacidad_almacenamiento, encargado) VALUES
('Sede Girón Centro', 'Calle Principal #1-10 Girón', 500, 'Roberto Díaz'),
('Sede Bucaramanga Norte', 'Av. Quebradaseca #45-20 Bucaramanga', 800, 'Ana Milena Torres'),
('Sede Piedecuesta', 'Carrera 7 #20-15 Piedecuesta', 300, 'Luis Fernando Prada'),
('Sede Girón Sur', 'Calle 15 #8-20 Girón', 450, 'Carmen Rosa Vega'),
('Sede Bucaramanga Sur', 'Av. González Valencia #30-10 Bucaramanga', 700, 'Héctor Ramírez'),
('Sede Bucaramanga Centro', 'Calle 35 #20-45 Bucaramanga', 600, 'Patricia Solano'),
('Sede Girón Industrial', 'Zona Industrial #5-30 Girón', 1000, 'Miguel Ángel Rojas'),
('Sede Piedecuesta Norte', 'Carrera 3 #10-50 Piedecuesta', 350, 'Sandra Milena Cruz'),
('Sede Cabecera', 'Av. Cabecera #60-15 Bucaramanga', 550, 'Fernando Alonso Niño'),
('Sede Lagos', 'Calle Lagos #12-40 Bucaramanga', 400, 'Gloria Inés Parra'),
('Sede Mensulí', 'Carrera Mensulí #3-20 Girón', 480, 'Jairo Alberto León'),
('Sede Autopista', 'Autopista Bucaramanga-Girón Km 3', 900, 'Rosa Elena Medina');

-- 3. PRODUCTOS (12)
INSERT INTO productos (nombre, categoria, precio, volumen_ml, stock_actual, stock_minimo) VALUES
('Coca-Cola', 'Cola', 2500.00, 350, 100, 20),
('Pepsi', 'Cola', 2300.00, 350, 80, 20),
('Sprite', 'Limón', 2500.00, 350, 60, 15),
('Fanta Naranja', 'Naranja', 2400.00, 350, 45, 15),
('Agua Cristal', 'Agua', 1800.00, 600, 200, 30),
('Gatorade Azul', 'Isotónica', 4500.00, 500, 12, 20),
('Manzana Postobón', 'Manzana', 2200.00, 350, 18, 20),
('Uva Postobón', 'Uva', 2200.00, 350, 55, 15),
('7UP', 'Limón', 2300.00, 350, 40, 15),
('Limonada Glacial', 'Limón', 3200.00, 400, 30, 10),
('Agua Brisa', 'Agua', 1900.00, 600, 150, 30),
('Red Bull', 'Energizante', 7500.00, 250, 25, 10);

-- 4. PEDIDOS (12)
INSERT INTO pedidos (fecha_pedido, id_cliente, id_sede, total_sin_iva, total_con_iva) VALUES
('2026-01-05', 1, 1, 25000.00, 29750.00),
('2026-01-10', 2, 2, 18000.00, 21420.00),
('2026-01-15', 3, 3, 32000.00, 38080.00),
('2026-01-20', 4, 1, 15000.00, 17850.00),
('2026-02-01', 5, 2, 45000.00, 53550.00),
('2026-02-10', 1, 3, 22000.00, 26180.00),
('2026-02-15', 2, 1, 38000.00, 45220.00),
('2026-02-20', 6, 2, 27000.00, 32130.00),
('2026-03-01', 7, 3, 19000.00, 22610.00),
('2026-03-10', 8, 1, 56000.00, 66640.00),
('2026-03-15', 9, 2, 33000.00, 39270.00),
('2026-03-20', 10, 3, 41000.00, 48790.00);

-- 5. DETALLE_PEDIDO (12)
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal) VALUES
(1, 1, 5, 12500.00),
(1, 3, 5, 12500.00),
(2, 5, 10, 18000.00),
(3, 2, 7, 16100.00),
(3, 4, 7, 16800.00),
(4, 6, 3, 13500.00),
(5, 1, 10, 25000.00),
(5, 7, 9, 19800.00),
(6, 8, 5, 11000.00),
(7, 9, 8, 18400.00),
(8, 10, 5, 16000.00),
(9, 11, 10, 19000.00);

SELECT COUNT(*) AS total FROM clientes;

SELECT COUNT(*) AS total FROM sedes;

SELECT COUNT(*) AS total FROM productos;

SELECT COUNT(*) AS total FROM pedidos;

SELECT COUNT(*) AS total FROM detalle_pedido;