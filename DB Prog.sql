CREATE TABLE Vendedor (
    id_vendedor NUMBER,
    ventas_totales VARCHAR2(255) NOT NULL,
    nombre_vendedor VARCHAR2(255) NOT NULL,
    email_vendedor VARCHAR2(255) UNIQUE NOT NULL,
    contrasenha_vendedor VARCHAR2(255) NOT NULL,
    CONSTRAINT pk_vendedor_id PRIMARY KEY (id_vendedor)
);

CREATE TABLE Categoria (
    id_categoria NUMBER,
    nombre_categoria VARCHAR2(100) NOT NULL,
    descripcion VARCHAR2(500),
    CONSTRAINT pk_id_categoria PRIMARY KEY (id_categoria)
);

CREATE TABLE UsuarioComprador (
    id_usuario NUMBER NOT NULL,
    nombre_usuario VARCHAR2(255) NOT NULL,
    apellido_usuario VARCHAR2(255) NOT NULL,
    email_usuario VARCHAR2(255) UNIQUE NOT NULL,
    contrasenha_usuario VARCHAR2(255) NOT NULL,
    fecha_nacimiento_usuario DaTE NOT NULL,
    provincia VARCHAR2(255) NOT NULL,
    distrito VARCHAR2(255) NOT NULL,
    corregimiento VARCHAR2(255) NOT NULL,
    calle VARCHAR2(255) NOT NULL,
    numero_casa VARCHAR2(255) NOT NULL,
    id_carrito NUMBER NOT NULL,
    CONSTRAINT pk_id_usuario PRIMARY KEY (id_usuario)
);

CREATE TABLE Telefono (
    id_telefono NUMBER ,
    telefono VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_id_telefono PRIMARY KEY (id_telefono)
);

CREATE TABLE Carrito (
    id_carrito NUMBER NOT NULL,
    id_usuario NUMBER NOT NULL,
    precio_total NUMBER NOT NULL,
    items_total NUMBER NOT NULL,
    CONSTRAINT pk_id_carrito PRIMARY KEY (id_carrito),
    CONSTRAINT fk_id_usuario FOREIGN KEY (id_usuario) REFERENCES UsuarioComprador(id_usuario)
);

CREATE TABLE tipos_telefonos_vendedor (
    id_vendedor NUMBER NOT NULL,
    id_telefono NUMBER NOT NULL,
    tipo_telefono VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_telefonos_vendedor PRIMARY KEY (id_telefono, id_vendedor),
    CONSTRAINT fk_id_telefono FOREIGN KEY (id_telefono) REFERENCES Telefono(id_telefono),
    CONSTRAINT fk_id_vendedor FOREIGN KEY (id_vendedor) REFERENCES Vendedor(id_vendedor)
);

CREATE TABLE tipos_telefonos_usuario (
    id_usuario NUMBER NOT NULL,
    id_telefono NUMBER NOT NULL,
    tipo_telefono VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_telefonos_usuario PRIMARY KEY (id_telefono, id_usuario),
    CONSTRAINT fk_idtelefono FOREIGN KEY (id_telefono) REFERENCES Telefono(id_telefono),
    CONSTRAINT fk_idusuario FOREIGN KEY (id_usuario) REFERENCES UsuarioComprador(id_usuario)
);

CREATE TABLE Orden (
    id_orden NUMBER NOT NULL,
    cantidad_orden NUMBER NOT NULL,
    estado_orden VARCHAR2(255) NOT NULL,
    id_carrito NUMBER NOT NULL,
    id_usuario NUMBER NOT NULL,
    CONSTRAINT pk_id_orden PRIMARY KEY (id_orden),
    CONSTRAINT fk_id_orden_carrito FOREIGN KEY (id_carrito) REFERENCES Carrito(id_carrito),
    CONSTRAINT fk_id_orden_usuario FOREIGN KEY (id_usuario) REFERENCES UsuarioComprador(id_usuario)
);

CREATE TABLE Pago (
    id_pago NUMBER NOT NULL,
    id_usuario NUMBER NOT NULL,
    modo_pago VARCHAR2(255) NOT NULL,
    fecha_pago DaTE DEFaULT SYSDATE,
    id_orden NUMBER NOT NULL,
    CONSTRAINT pk_id_pago PRIMARY KEY (id_pago),
    CONSTRAINT fk_id_pago_orden FOREIGN KEY (id_orden) REFERENCES Orden(id_orden),
    CONSTRAINT fk_id_pago_usuario FOREIGN KEY (id_usuario) REFERENCES UsuarioComprador(id_usuario)
);

CREATE TABLE Producto (
    id_producto NUMBER NOT NULL,
    nombre_producto VARCHAR2(255) NOT NULL,
    descripcion_producto VARCHAR2(500) NOT NULL,
    marca VARCHAR2(255) NOT NULL,
    inventario NUMBER NOT NULL,
    precio NUMBER NOT NULL,
    id_categoria NUMBER NOT NULL,
    id_vendedor NUMBER NOT NULL,
    id_pago NUMBER NOT NULL,
    CONSTRAINT pk_id_producto PRIMARY KEY (id_producto),
    CONSTRAINT fk_id_producto_categoria FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
    CONSTRAINT fk_id_producto_vendedor FOREIGN KEY (id_vendedor) REFERENCES Vendedor(id_vendedor),
    CONSTRAINT fk_id_producto_pago FOREIGN KEY (id_pago) REFERENCES Pago(id_pago)
);


CREATE TABLE OrdenItem (
    id_orden NUMBER NOT NULL,
    id_producto NUMBER NOT NULL,
    cantidad NUMBER NOT NULL,
    precio NUMBER NOT NULL,
    fecha_de_orden DaTE NOT NULL,
    fecha_envio DaTE NOT NULL,
    CONSTRAINT pk_ordenitem PRIMARY KEY (id_orden, id_producto ),
    CONSTRAINT fk_id_orden_item FOREIGN KEY (id_orden) REFERENCES Orden(id_orden),
    CONSTRAINT fk_id_producto_ordenitem FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE resenhas (
    id_resenha NUMBER NOT NULL,
    id_usuario NUMBER NOT NULL,
    calificacion VARCHAR2(255) NOT NULL,
    descripcion VARCHAR2(255) NOT NULL,
    id_producto NUMBER NOT NULL,
    CONSTRAINT pk_id_resenha PRIMARY KEY (id_resenha),
    CONSTRAINT fk_id_producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    CONSTRAINT fk_id_resenha_usuario FOREIGN KEY (id_usuario) REFERENCES UsuarioComprador(id_usuario)
);

-- Secuencias

CREATE SEQUENCE seq_vendedor START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_categoria START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_usuario START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_telefono START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_carrito START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_orden START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_pago START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_producto START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_resenha START WITH 1 INCREMENT BY 1;

-- Inserciones de vendedores

INSERT INTO Categoria (id_categoria, nombre_categoria, descripcion)
VaLUES (seq_categoria.NEXTVAL, 'Electronica', 'Productos electronicos de todo tipo');

INSERT INTO Categoria (id_categoria, nombre_categoria, descripcion)
VaLUES (seq_categoria.NEXTVAL, 'Computadoras', 'Laptops, Desktops y accesorios relacionados');

INSERT INTO Categoria (id_categoria, nombre_categoria, descripcion)
VaLUES (seq_categoria.NEXTVAL, 'Telefonos', 'Telefonos moviles y accesorios');

INSERT INTO Vendedor (id_vendedor, ventas_totales, nombre_vendedor, email_vendedor, contrasenha_vendedor)
VaLUES (seq_vendedor.NEXTVAL, '0', 'Eliecer Perez', 'eliecer@email.com', '123');

INSERT INTO Vendedor (id_vendedor, ventas_totales, nombre_vendedor, email_vendedor, contrasenha_vendedor)
VaLUES (seq_vendedor.NEXTVAL, '0', 'Rodrigo Molinar', 'rodrigo@email.com', '123');


-- Inserciones de usuario

INSERT INTO UsuarioComprador (id_usuario, nombre_usuario, apellido_usuario, email_usuario, contrasenha_usuario, fecha_nacimiento_usuario, provincia, distrito, corregimiento, calle, numero_casa, id_carrito)
VaLUES (seq_usuario.NEXTVAL, 'Eynar', 'Morales', 'eynar.morales@email.com', '123', TO_DaTE('1990-01-01', 'YYYY-MM-DD'), 'Panama', 'Panama', 'alcade diaz', 'Calle 1', '1', 1);

INSERT INTO UsuarioComprador (id_usuario, nombre_usuario, apellido_usuario, email_usuario, contrasenha_usuario, fecha_nacimiento_usuario, provincia, distrito, corregimiento, calle, numero_casa, id_carrito)
VaLUES (seq_usuario.NEXTVAL, 'Kenshin', 'Ng', 'kenshin.ng@email.com', '123', TO_DaTE('1992-02-02', 'YYYY-MM-DD'), 'Colon', 'Colon', 'Colon 2000', 'Calle 2', '2', 2);

INSERT INTO UsuarioComprador (id_usuario, nombre_usuario, apellido_usuario, email_usuario, contrasenha_usuario, fecha_nacimiento_usuario, provincia, distrito, corregimiento, calle, numero_casa, id_carrito)
VaLUES (seq_usuario.NEXTVAL, 'Paola', 'Quiñones', 'paola.quiñones@email.com', '123', TO_DaTE('1993-03-03', 'YYYY-MM-DD'), 'Panama', 'Panama', 'ancon', 'Calle 3', '3', 3);

INSERT INTO UsuarioComprador (id_usuario, nombre_usuario, apellido_usuario, email_usuario, contrasenha_usuario, fecha_nacimiento_usuario, provincia, distrito, corregimiento, calle, numero_casa, id_carrito)
VaLUES (seq_usuario.NEXTVAL, 'Jonathan', 'Reyes', 'jonathan.reyes@email.com', '123', TO_DaTE('1994-04-04', 'YYYY-MM-DD'), 'Panama', 'Panama', 'Bethania', 'Calle 4', '4', 4);


-- Inserciones de carrito

INSERT INTO Carrito (id_carrito, id_usuario, precio_total, items_total)
VaLUES (seq_carrito.NEXTVAL, 1, 0, 0);
INSERT INTO Carrito (id_carrito, id_usuario, precio_total, items_total)
VaLUES (seq_carrito.NEXTVAL, 2, 0, 0);
INSERT INTO Carrito (id_carrito, id_usuario, precio_total, items_total)
VaLUES (seq_carrito.NEXTVAL, 3, 0, 0);
INSERT INTO Carrito (id_carrito, id_usuario, precio_total, items_total)
VaLUES (seq_carrito.NEXTVAL, 4, 0, 0);


-- Insercion de ordenes

-- Usuario 1

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 2, 'Entregada', 1, 1);

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 3, 'Enviada', 1, 1);

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 4, 'En Proceso', 1, 1);

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 4, 'Pendiente', 1, 1);

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 5, 'Pendiente', 1, 1);


-- Usuario 2

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 3, 'Entregada', 2, 2);

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 4, 'Enviada', 2, 2);

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 5, 'En Proceso', 2, 2);

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 4, 'Enviada', 2, 2);

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 6, 'Pendiente', 2, 2);


-- Usuario 3

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 2, 'Entregada', 3, 3);

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 5, 'Enviada', 3, 3);

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 4, 'En proceso', 3, 3);

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 6, 'Pendiente', 3, 3);



-- Usuario 4

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 3, 'Entregada', 4, 4);

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 5, 'Enviada', 4, 4);

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 4, 'Enviada', 4, 4);

INSERT INTO Orden (id_orden, cantidad_orden, estado_orden, id_carrito, id_usuario)
VaLUES (seq_orden.NEXTVAL, 6, 'Pendiente', 4, 4);

-- Inserciones de pagos

-- Usuario 1

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 1, 'Tarjeta de Credito', SYSDATE, 1);

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 1, 'Tarjeta de Credito', SYSDATE, 2);

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 1, 'PayPal', SYSDATE, 3);

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 1, 'Transferencia Bancaria', SYSDATE, 4);

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 1, 'Tarjeta de Debito', SYSDATE, 5);


-- Usuario 2

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 2, 'PayPal', SYSDATE, 6);

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 2, 'Transferencia Bancaria', SYSDATE, 7);

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 2, 'Tarjeta de Debito', SYSDATE, 8);

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 2, 'PayPal', SYSDATE, 9);

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 2, 'Tarjeta de Credito', SYSDATE, 10);


-- Usuario 3

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 3, 'Tarjeta de Debito', SYSDATE, 11);

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 3, 'Tarjeta de Debito', SYSDATE, 12);

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 3, 'PayPal', SYSDATE, 13);

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 3, 'Tarjeta de Credito', SYSDATE, 14);

-- Usuario 4

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 4, 'Transferencia Bancaria', SYSDATE, 15);

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 4, 'Transferencia Bancaria', SYSDATE, 16);

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 4, 'PayPal', SYSDATE, 17);

INSERT INTO Pago (id_pago, id_usuario, modo_pago, fecha_pago, id_orden)
VaLUES (seq_pago.NEXTVAL, 4, 'Tarjeta de Credito', SYSDATE, 18);


-- Insercion para productos 23

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Smartwatch apple', 'Apple Watch Series 6', 'Apple', 200, 400.00, 3, 1, 1);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Tablet Samsung', 'Samsung Galaxy Tab S7', 'Samsung', 100, 700.00, 1, 2, 2);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Laptop HP', 'HP Pavilion 15', 'HP', 75, 650.00, 2, 2, 3);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Audifonos Sony', 'Sony WH-1000XM4', 'Sony', 120, 350.00, 1, 1, 4);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Televisor LG', 'LG OLED 55"', 'LG', 50, 1200.00, 1, 2, 5);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Camara Canon', 'Canon EOS R5', 'Canon', 30, 3500.00, 1, 1, 6);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Impresora Epson', 'Epson EcoTank L3150', 'Epson', 100, 200.00, 1, 2, 7);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Router TP-Link', 'TP-Link archer C7', 'TP-Link', 150, 100.00, 1, 1, 8);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Teclado Logitech', 'Logitech MX Keys', 'Logitech', 200, 100.00, 1, 2, 1);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Mouse Razer', 'Razer Deathadder V2', 'Razer', 250, 80.00, 1, 1, 2);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Disco Duro Seagate', 'Seagate Backup Plus 5TB', 'Seagate', 300, 150.00, 1, 2, 3);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Auriculares Bose', 'Bose QuietComfort 35 II', 'Bose', 100, 300.00, 1, 1, 4);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Microfono Blue', 'Blue Yeti', 'Blue', 80, 120.00, 1, 2, 5);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Smartphone Samsung Galaxy S21', 'Ultimo modelo de Samsung', 'Samsung', 100, 800.00, 1, 2, 1);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Smart TV Sony Bravia 65"', 'Televisor con tecnologia 4K', 'Sony', 50, 1500.00, 1, 1, 2);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Apple MacBook Pro 2023', 'Potente laptop de apple', 'Apple', 30, 2000.00, 2, 1, 3);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Canon EOS 5D Mark V', 'Camara profesional de Canon', 'Canon', 50, 3500.00, 1, 2, 4);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Apple iPad Air 2023', 'Tablet ligera y potente', 'Apple', 80, 900.00, 1, 1, 5);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Nintendo Switch OLED', 'Consola de videojuegos portatil', 'Nintendo', 60, 400.00, 2, 2, 6);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'DJI Mavic air 2S', 'Drone con camara de alta resolucion', 'DJI', 40, 1200.00, 3, 1, 7);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Sony PlayStation VR', 'Gafas de realidad virtual para PlayStation', 'Sony', 25, 300.00, 2, 2, 8);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Monitor LG UltraWide 34"', 'Monitor ultrapanoramico para gaming', 'LG', 35, 1000.00, 1, 1, 1);

INSERT INTO Producto (id_producto, nombre_producto, descripcion_producto, marca, inventario, precio, id_categoria, id_vendedor, id_pago)
VaLUES (seq_producto.NEXTVAL, 'Bose Noise Cancelling Headphones 700', 'Auriculares con cancelacion de ruido', 'Bose', 50, 350.00, 1, 2, 2);




-- Insercion para ordenitem

INSERT INTO OrdenItem (id_orden, id_producto, cantidad, precio, fecha_de_orden, fecha_envio)
VaLUES (1, 1, 1, 1200, SYSDATE, SYSDATE + 5);

INSERT INTO OrdenItem (id_orden, id_producto, cantidad, precio, fecha_de_orden, fecha_envio)
VaLUES (1, 2, 1, 800, SYSDATE, SYSDATE + 5);

INSERT INTO OrdenItem (id_orden, id_producto, cantidad, precio, fecha_de_orden, fecha_envio)
VaLUES (2, 3, 1, 200, SYSDATE, SYSDATE + 5);

INSERT INTO OrdenItem (id_orden, id_producto, cantidad, precio, fecha_de_orden, fecha_envio)
VaLUES (2, 4, 1, 300, SYSDATE, SYSDATE + 5);

INSERT INTO OrdenItem (id_orden, id_producto, cantidad, precio, fecha_de_orden, fecha_envio)
VaLUES (3, 5, 2, 150, SYSDATE, SYSDATE + 5);

INSERT INTO OrdenItem (id_orden, id_producto, cantidad, precio, fecha_de_orden, fecha_envio)
VaLUES (4, 6, 1, 100, SYSDATE, SYSDATE + 5);

INSERT INTO OrdenItem (id_orden, id_producto, cantidad, precio, fecha_de_orden, fecha_envio)
VaLUES (5, 1, 1, 1200, SYSDATE, SYSDATE + 5);

INSERT INTO OrdenItem (id_orden, id_producto, cantidad, precio, fecha_de_orden, fecha_envio)
VaLUES (5, 2, 1, 800, SYSDATE, SYSDATE + 5);

INSERT INTO OrdenItem (id_orden, id_producto, cantidad, precio, fecha_de_orden, fecha_envio)
VaLUES (6, 3, 1, 200, SYSDATE, SYSDATE + 5);

INSERT INTO OrdenItem (id_orden, id_producto, cantidad, precio, fecha_de_orden, fecha_envio)
VaLUES (6, 4, 1, 300, SYSDATE, SYSDATE + 5);

INSERT INTO OrdenItem (id_orden, id_producto, cantidad, precio, fecha_de_orden, fecha_envio)
VaLUES (7, 9, 1, 200, SYSDATE, SYSDATE + 5);

INSERT INTO OrdenItem (id_orden, id_producto, cantidad, precio, fecha_de_orden, fecha_envio)
VaLUES (7, 10, 1, 300, SYSDATE, SYSDATE + 5);

INSERT INTO OrdenItem (id_orden, id_producto, cantidad, precio, fecha_de_orden, fecha_envio)
VaLUES (8, 12, 1, 200, SYSDATE, SYSDATE + 5);

INSERT INTO OrdenItem (id_orden, id_producto, cantidad, precio, fecha_de_orden, fecha_envio)
VaLUES (8, 11, 1, 300, SYSDATE, SYSDATE + 5);




