DROP DATABASE IF EXISTS rac_ar;
CREATE DATABASE rac_ar;
USE rac_ar;

CREATE TABLE CLIENTE(
id_cliente INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(20),
apellido VARCHAR(20),
documento VARCHAR(11),
mail VARCHAR(100),
calificacion INT,
preferencias VARCHAR(254),
historial_de_alquiler VARCHAR(254),
medio_de_pago_preferido VARCHAR(50),
PRIMARY KEY (id_cliente)
) COMMENT 'INFORMACION BASICA DEL CLIENTE';

CREATE TABLE FLOTA_DE_AUTOS(
id_auto INT NOT NULL AUTO_INCREMENT,
marca VARCHAR(20),
modelo VARCHAR(20),
tipo_de_auto VARCHAR(20),
estado_mecanico VARCHAR(20),
calificacion INT NOT NULL,
disponibilidad BOOLEAN,
reparaciones_realizadas TEXT,
id_sucursal INT,
PRIMARY KEY (id_auto)
) COMMENT 'INFORMACION DE LA FLOTA DE AUTOS';

CREATE TABLE SUCURSALES(
id_sucursal INT NOT NULL AUTO_INCREMENT,
nombre_sucursal VARCHAR(50),
tipo_sucursal VARCHAR(50),
direccion VARCHAR(100),
telefono VARCHAR(15),
PRIMARY KEY (id_sucursal)
) COMMENT 'INFORMACION DE SUCURSALES Y FLOTA INTERNA';

CREATE TABLE PAGO(
id_pago INT NOT NULL AUTO_INCREMENT,
monto DECIMAL(10,2),
fecha_transaccion DATE DEFAULT(CURRENT_DATE),
metodo_pago VARCHAR(30),
tipo_factura VARCHAR(10),
reembolsos DECIMAL(10,2),
acuerdos_bancarios TEXT,
PRIMARY KEY (id_pago)
) COMMENT 'INFORMACION SOBRE EL PAGO DEL SERVICIO';

CREATE TABLE TECNICO_REVISION(
id_tecnico INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(30),
especialidad VARCHAR(100),
historial_revisiones TEXT,
referencias_revisiones TEXT,
PRIMARY KEY (id_tecnico)
) COMMENT 'INFORMACION SOBRE LOS TECNICOS QUE REVISAN LOS AUTOS ENTREGADOS';

CREATE TABLE COTIZACIONES_Y_TARIFAS(
id_tarifa INT NOT NULL AUTO_INCREMENT,
tipo_de_auto VARCHAR(30),
precio_diario DECIMAL(10,2),
promociones_especiales TEXT,
servicios_adicionales TEXT,
costo_serv_adic DECIMAL(10,2),
id_auto INT,
PRIMARY KEY(id_tarifa)
) COMMENT 'INFORMACION TARIFARIA';

CREATE TABLE INCIDENCIAS(
id_reclamo INT NOT NULL AUTO_INCREMENT,
id_alquiler INT,
descripcion_reclamo TEXT,
fecha_reclamo DATETIME DEFAULT(CURRENT_TIMESTAMP),
resolucion TEXT,
estado_abierto_cerrado BOOLEAN,
PRIMARY KEY (id_reclamo)
) COMMENT 'INFORMACION SOBRE INCIDENCIAS';

CREATE TABLE EMPLEADOS(
id_empleado INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(30),
puesto VARCHAR(20),
historia_laboral TEXT,
fecha_contrato DATE DEFAULT(CURRENT_DATE),
evaluacion_performance TEXT,
funciones_responsabilidades TEXT,
capacitaciones TEXT,
id_sucursal INT,
PRIMARY KEY(id_empleado)
) COMMENT 'INFORMACION DE LOS EMPLEADO';

CREATE TABLE HISTORIA_ALQUI_DEVOL(
id_historial INT NOT NULL AUTO_INCREMENT,
id_alquiler INT,
fecha_devolucion DATETIME DEFAULT(CURRENT_TIMESTAMP),
estatus_devolucion VARCHAR(20),
incidencias_reparadas TEXT,
estatus_combustible VARCHAR(20),
kilometraje INT,
PRIMARY KEY (id_historial)
) COMMENT 'INFORMACION HISTORIA DE ALQUILERES';

CREATE TABLE PROVEEDORES(
id_proveedor INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(30),
tipo_acuerdo VARCHAR(50),
detalle_acuerdo TEXT,
contacto VARCHAR(15),
Id_sucursal INT,
PRIMARY KEY (id_proveedor)
) COMMENT 'INFORMACION SOBRE PROVEEDORES';

CREATE TABLE REVISION(
id_revision INT NOT NULL AUTO_INCREMENT,
fecha_revision DATE DEFAULT(CURRENT_DATE),
descripcion_problema TEXT,
resultado TEXT,
id_auto INT,
id_tecnico INT,
PRIMARY KEY (id_revision)
) COMMENT 'INFORMACION SOBRE LAS REVISIONES QUE TIENEN LOS AUTOS';

CREATE TABLE ALQUILERES(
id_alquiler INT NOT NULL AUTO_INCREMENT,
fecha_inicio DATETIME DEFAULT(CURRENT_TIMESTAMP),
fecha_fin DATETIME DEFAULT(CURRENT_TIMESTAMP),
monto_total DECIMAL(10,2),
id_cliente INT,
id_auto INT,
id_pago INT,
PRIMARY KEY (id_alquiler)
) COMMENT 'TABLA LOGICA DE LA RENTADORA';

ALTER TABLE FLOTA_DE_AUTOS
		ADD CONSTRAINT fk_auto_sucursal
	FOREIGN KEY (id_sucursal) REFERENCES SUCURSALES(id_sucursal);

ALTER TABLE COTIZACIONES_Y_TARIFAS
		ADD CONSTRAINT fk_cotiz_auto
    FOREIGN KEY (id_auto) REFERENCES FLOTA_DE_AUTOS(id_auto);
    
ALTER TABLE INCIDENCIAS
		ADD CONSTRAINT fk_reclamo_alquiler
	FOREIGN KEY (id_alquiler) REFERENCES ALQUILERES(id_alquiler);

ALTER TABLE EMPLEADOS
		ADD CONSTRAINT fk_empleado_sucursal
	FOREIGN KEY (id_sucursal) REFERENCES SUCURSALES(id_sucursal);
    
ALTER TABLE PROVEEDORES
		ADD CONSTRAINT fk_provee_sucursal
	FOREIGN KEY (id_sucursal) REFERENCES SUCURSALES(id_sucursal);
    
ALTER TABLE HISTORIA_ALQUI_DEVOL
		ADD CONSTRAINT fk_hist_alquiler
	FOREIGN KEY (id_alquiler) REFERENCES ALQUILERES(id_alquiler);
    
ALTER TABLE REVISION
		ADD CONSTRAINT fk_revision_auto
	FOREIGN KEY (id_auto) REFERENCES FLOTA_DE_AUTOS(id_auto);
    
ALTER TABLE REVISION
		ADD CONSTRAINT fk_revision_tecnico
	FOREIGN KEY (id_tecnico) REFERENCES TECNICO_REVISION (id_tecnico);
    
ALTER TABLE ALQUILERES
		ADD CONSTRAINT fk_alquiler_cliente
	FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente);
    
ALTER TABLE ALQUILERES
		ADD CONSTRAINT fk_alquiler_auto
	FOREIGN KEY (id_auto) REFERENCES FLOTA_DE_AUTOS(id_auto);
    
ALTER TABLE ALQUILERES
		ADD CONSTRAINT fk_alquiler_pago
	FOREIGN KEY (id_pago) REFERENCES PAGO(id_pago);
    