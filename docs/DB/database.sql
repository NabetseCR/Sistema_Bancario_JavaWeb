/*Se crea la base de datos*/
create schema Banco;

/*Se usa la base de datos*/
use Banco;

/*Se crean las tablas*/
/*--------------------------------------------------*/
/*Tabla persona*/
/*Usuario primordial del sistema*/
CREATE TABLE `banco`.`persona` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `primer_apelido` VARCHAR(45) NOT NULL,
  `segundo_apellido` VARCHAR(45) NOT NULL,
  `estado_civil` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `canton` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NULL,
  `celular` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `edad` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE);
/*--------------------------------------------------*/
  /*Tabla cliente*/
  /*Clasifica a una persona como cliente*/
 CREATE TABLE `banco`.`cliente` (
  `numero_cliente` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  PRIMARY KEY (`numero_cliente`),
  UNIQUE INDEX `id_cliente_UNIQUE` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_persona`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `banco`.`persona` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
/*--------------------------------------------------*/
  /*Tabla cuenta_cliente*/
  /*Una vez clasificado se atomiza la contrasenna*/
  CREATE TABLE `banco`.`cuenta_cliente` (
  `numero_cuenta_cliente` INT NOT NULL AUTO_INCREMENT,
  `clave` VARCHAR(45) NOT NULL,
  `cedula_cliente_usuario` INT NOT NULL,
  PRIMARY KEY (`numero_cuenta_cliente`),
  INDEX `fk_cuentaCliente_cliente_idx` (`cedula_cliente_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_cuentaCliente_cliente`
    FOREIGN KEY (`cedula_cliente_usuario`)
    REFERENCES `banco`.`cliente` (`id_cliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
/*--------------------------------------------------*/    
    /*Tabla cajero*/
    CREATE TABLE `banco`.`cajero` (
  `numero_cajero` INT NOT NULL AUTO_INCREMENT,
  `id_cajero` INT NOT NULL,
  PRIMARY KEY (`numero_cajero`),
  INDEX `fk_cajero_persona_idx` (`id_cajero` ASC) VISIBLE,
  CONSTRAINT `fk_cajero_persona`
    FOREIGN KEY (`id_cajero`)
    REFERENCES `banco`.`persona` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
/*--------------------------------------------------*/
    /*Tabla cuenta_cajero*/
    CREATE TABLE `banco`.`cuenta_cajero` (
  `numero_cuenta_cajero` INT NOT NULL AUTO_INCREMENT,
  `clave` VARCHAR(45) NOT NULL,
  `cedula_cajero_usuario` INT NOT NULL,
  PRIMARY KEY (`numero_cuenta_cajero`),
  INDEX `fk_cuentaCajero_cajero_idx` (`cedula_cajero_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_cuentaCajero_cajero`
    FOREIGN KEY (`cedula_cajero_usuario`)
    REFERENCES `banco`.`cajero` (`id_cajero`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
/*--------------------------------------------------*/    
    /*Tabla Moneda*/
CREATE TABLE `banco`.`moneda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));
  /*Se me olvido poner la porcentaje de interes de moneda*/
  /*Se agrega columna destinada para eso*/
  ALTER TABLE `banco`.`moneda` 
ADD COLUMN `porcentaje_interes` DECIMAL(10,3) NOT NULL AFTER `descripcion`;
/*--------------------------------------------------*/
  /*Tabla cambio_valor*/
  CREATE TABLE `banco`.`cambio_valor` (
  `numero_entrada` INT NOT NULL AUTO_INCREMENT,
  `id_moneda` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `valor_compra` DECIMAL(10,5) NOT NULL,
  `valor_venta` DECIMAL(10,5) NOT NULL,
  PRIMARY KEY (`numero_entrada`),
  INDEX `fk_valor_moneda_idx` (`id_moneda` ASC) VISIBLE,
  CONSTRAINT `fk_valor_moneda`
    FOREIGN KEY (`id_moneda`)
    REFERENCES `banco`.`moneda` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
/*--------------------------------------------------*/
    /*Tabla Cuenta*/
    CREATE TABLE `banco`.`cuenta` (
  `numero` INT NOT NULL AUTO_INCREMENT,
  `id_persona` INT NOT NULL,
  `id_moneda` INT NOT NULL,
  `saldo` DECIMAL(65,10) NOT NULL,
  `interes` DECIMAL(65,10) NULL,
  `fecha_creacion` DATE NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_cuenta_persona_idx` (`id_persona` ASC) VISIBLE,
  INDEX `fk_cuenta_moneda_idx` (`id_moneda` ASC) VISIBLE,
  CONSTRAINT `fk_cuenta_persona`
    FOREIGN KEY (`id_persona`)
    REFERENCES `banco`.`persona` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cuenta_moneda`
    FOREIGN KEY (`id_moneda`)
    REFERENCES `banco`.`moneda` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    /*Se modifica cuenta por defecto 0, not null date*/
    ALTER TABLE `banco`.`cuenta` 
	CHANGE COLUMN `saldo` `saldo` DECIMAL(65,10) NULL DEFAULT 0 ,
	CHANGE COLUMN `fecha_creacion` `fecha_creacion` DATE NULL ;
/*--------------------------------------------------*/
    /*Tabla cuenta_vinculada*/
    /*Esta tabla relaciona cuentas con cuentas, con puede identificarse con fk*/
    /*id del usuario y numero de cuenta*/
    CREATE TABLE `banco`.`cuenta_vinculada` (
  `entrada` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `numero_cuenta_vinculada` INT NOT NULL,
  `id_cliente_vinculado` INT NOT NULL,
  PRIMARY KEY (`entrada`),
  INDEX `fk_cliente_raiz_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_cuenta_vinculada_idx` (`numero_cuenta_vinculada` ASC) VISIBLE,
  INDEX `fk_cliente_destino_idx` (`id_cliente_vinculado` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_raiz`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `banco`.`cliente` (`id_cliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cuenta_vinculada`
    FOREIGN KEY (`numero_cuenta_vinculada`)
    REFERENCES `banco`.`cuenta` (`numero`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cliente_destino`
    FOREIGN KEY (`id_cliente_vinculado`)
    REFERENCES `banco`.`cliente` (`id_cliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
/*--------------------------------------------------*/
    /*Tabla movimiento*/
    CREATE TABLE `banco`.`movimiento` (
  `numero` INT NOT NULL AUTO_INCREMENT,
  `numero_cuenta_origen` INT NOT NULL,
  `numero_cuenta_destino` INT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `monto` DECIMAL(65,10) NOT NULL,
  `nombre_persona` VARCHAR(45) NULL,
  `primer_apellido_persona` VARCHAR(45) NULL,
  `segundo_apellido_persona` VARCHAR(45) NULL,
  `motivo` VARCHAR(65) NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `pk_movimiento_origen_idx` (`numero_cuenta_origen` ASC) VISIBLE,
  INDEX `pk_movimiento_destino_idx` (`numero_cuenta_destino` ASC) VISIBLE,
  CONSTRAINT `pk_movimiento_origen`
    FOREIGN KEY (`numero_cuenta_origen`)
    REFERENCES `banco`.`cuenta` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pk_movimiento_destino`
    FOREIGN KEY (`numero_cuenta_destino`)
    REFERENCES `banco`.`cuenta` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    /*Se modifica tabla movimiento, ya que en deposito no es necesario cuenta origen*/
    ALTER TABLE `banco`.`movimiento` 
	DROP FOREIGN KEY `pk_movimiento_origen`;
	ALTER TABLE `banco`.`movimiento` 
	CHANGE COLUMN `numero_cuenta_origen` `numero_cuenta_origen` INT(11) NULL ;
	ALTER TABLE `banco`.`movimiento` 
	ADD CONSTRAINT `pk_movimiento_origen`
	FOREIGN KEY (`numero_cuenta_origen`)
	REFERENCES `banco`.`cuenta` (`numero`);
    /*-------------------------------------------------------------------------------------*/
    /*-------------------------------------------------------------------------------------*/
    /*Se queman datos*/
    /*Se insertan 10 Persona*/
    /*Persona 1*/
    INSERT INTO `banco`.`persona` (`id`, `nombre`, `primer_apelido`, `segundo_apellido`, `estado_civil`, `provincia`, `canton`, `direccion`, `telefono`, `celular`, `email`, `edad`)
    VALUES ('111', 'Esteban', 'Chinchilla', 'Brenes', 'Soltero', 'Alajuela', 'Alajuela', 'Calle la flory', '8903', '8978', 'est.e.com', '22');
    /*Persona 2*/
    INSERT INTO `banco`.`persona` (`id`, `nombre`, `primer_apelido`, `segundo_apellido`, `estado_civil`, `provincia`, `canton`, `direccion`, `telefono`, `celular`, `email`, `edad`) 
    VALUES ('222', 'Ana', 'Solano', 'Benavides', 'Soltera', 'Heredia', 'Santa Barbara', 'Calle Cajon', '2123', '8899', 'ana.a.com', '22');
    /*Persona 3*/
    INSERT INTO `banco`.`persona` (`id`, `nombre`, `primer_apelido`, `segundo_apellido`, `estado_civil`, `provincia`, `canton`, `direccion`, `telefono`, `celular`, `email`, `edad`)
    VALUES ('333', 'Carlos', 'Evaristo', 'Coronado', 'Soltero', 'Limon', 'Limon', 'Ubz. Los Gatos', '2321', '8978', 'est.c.com', '22');
    /*Persona 4*/
    INSERT INTO `banco`.`persona` (`id`, `nombre`, `primer_apelido`, `segundo_apellido`, `estado_civil`, `provincia`, `canton`, `direccion`, `telefono`, `celular`, `email`, `edad`) 
    VALUES ('444', 'Anabel', 'Martinez', 'Benavides', 'Soltera', 'Heredia', 'Santo Domingo', 'Calle Mona', '2123', '8899', 'ana.b.com', '23');
    /*Persona 5*/
    INSERT INTO `banco`.`persona` (`id`, `nombre`, `primer_apelido`, `segundo_apellido`, `estado_civil`, `provincia`, `canton`, `direccion`, `telefono`, `celular`, `email`, `edad`)
    VALUES ('555', 'Marta', 'Zamora', 'Artavia', 'Casada', 'Cartago', 'Cartago', 'Central', '2321', '8978', 'mart.e.com', '40');
    /*Persona 6*/
    INSERT INTO `banco`.`persona` (`id`, `nombre`, `primer_apelido`, `segundo_apellido`, `estado_civil`, `provincia`, `canton`, `direccion`, `telefono`, `celular`, `email`, `edad`) 
    VALUES ('666', 'Mayela', 'Solis', 'Berrocal', 'Soltera', 'Guanacaste', 'Nicoya', 'Avenida Sonrisa', '2123', '8899', 'may.a.com', '50');
    /*Persona 7*/
    INSERT INTO `banco`.`persona` (`id`, `nombre`, `primer_apelido`, `segundo_apellido`, `estado_civil`, `provincia`, `canton`, `direccion`, `telefono`, `celular`, `email`, `edad`)
    VALUES ('777', 'Jazmin', 'Elizondo', 'Brenes', 'Soltera', 'San Jose', 'Pavas', 'Cielito', '2321', '8978', 'jaz.e.com', '26');
    /*Persona 8*/
    INSERT INTO `banco`.`persona` (`id`, `nombre`, `primer_apelido`, `segundo_apellido`, `estado_civil`, `provincia`, `canton`, `direccion`, `telefono`, `celular`, `email`, `edad`) 
    VALUES ('888', 'Diego', 'Guell', 'Mata', 'Casado', 'Heredia', 'Santa Barbara', 'Central', '2123', '8899', 'die.a.com', '80');
    /*Persona 9*/
    INSERT INTO `banco`.`persona` (`id`, `nombre`, `primer_apelido`, `segundo_apellido`, `estado_civil`, `provincia`, `canton`, `direccion`, `telefono`, `celular`, `email`, `edad`)
    VALUES ('999', 'Cristiano', 'Constantine', 'Alvarado', 'Soltero', 'Puntarenas', 'Miramar', 'Calle la esperanza', '2321', '8978', 'cr7.siuu.com', '37');
    /*Persona 10*/
    INSERT INTO `banco`.`persona` (`id`, `nombre`, `primer_apelido`, `segundo_apellido`, `estado_civil`, `provincia`, `canton`, `direccion`, `telefono`, `celular`, `email`, `edad`) 
    VALUES ('101010', 'Cristina', 'Fernandes', 'Fernandes', 'Soltera', 'Heredia', 'Santa Barbara', 'Calle Cajon', '2123', '8899', 'crisna.a.com', '21');
    
    /*-------------------------------------------------------------------------------------*/
    /*-------------------------------------------------------------------------------------*/
    /*De esas 10 persona todas seran clientes*/
    /*Cliente 1*/
    INSERT INTO `banco`.`cliente` (`numero_cliente`, `id_cliente`) VALUES ('1', '111');
    INSERT INTO `banco`.`cuenta_cliente` (`numero_cuenta_cliente`, `clave`, `cedula_cliente_usuario`) VALUES ('1', '111', '111');
    /*Cliente 2*/
    INSERT INTO `banco`.`cliente` (`numero_cliente`, `id_cliente`) VALUES ('2', '222');
    INSERT INTO `banco`.`cuenta_cliente` (`numero_cuenta_cliente`, `clave`, `cedula_cliente_usuario`) VALUES ('2', '222', '222');
    /*Cliente 3*/
    INSERT INTO `banco`.`cliente` (`numero_cliente`, `id_cliente`) VALUES ('3', '333');
    INSERT INTO `banco`.`cuenta_cliente` (`numero_cuenta_cliente`, `clave`, `cedula_cliente_usuario`) VALUES ('3', '333', '333');
    /*Cliente 4*/
    INSERT INTO `banco`.`cliente` (`numero_cliente`, `id_cliente`) VALUES ('4', '444');
    INSERT INTO `banco`.`cuenta_cliente` (`numero_cuenta_cliente`, `clave`, `cedula_cliente_usuario`) VALUES ('4', '444', '444');
    /*Cliente 5*/
    INSERT INTO `banco`.`cliente` (`numero_cliente`, `id_cliente`) VALUES ('5', '555');
    INSERT INTO `banco`.`cuenta_cliente` (`numero_cuenta_cliente`, `clave`, `cedula_cliente_usuario`) VALUES ('5', '555', '555');
    /*Cliente 6*/
    INSERT INTO `banco`.`cliente` (`numero_cliente`, `id_cliente`) VALUES ('6', '666');
    INSERT INTO `banco`.`cuenta_cliente` (`numero_cuenta_cliente`, `clave`, `cedula_cliente_usuario`) VALUES ('6', '666', '666');
    /*Cliente 7*/
    INSERT INTO `banco`.`cliente` (`numero_cliente`, `id_cliente`) VALUES ('7', '777');
    INSERT INTO `banco`.`cuenta_cliente` (`numero_cuenta_cliente`, `clave`, `cedula_cliente_usuario`) VALUES ('7', '777', '777');
    /*Cliente 8*/
    INSERT INTO `banco`.`cliente` (`numero_cliente`, `id_cliente`) VALUES ('8', '888');
    INSERT INTO `banco`.`cuenta_cliente` (`numero_cuenta_cliente`, `clave`, `cedula_cliente_usuario`) VALUES ('8', '888', '888');
    /*Cliente 9*/
    INSERT INTO `banco`.`cliente` (`numero_cliente`, `id_cliente`) VALUES ('10', '101010');
    INSERT INTO `banco`.`cuenta_cliente` (`numero_cuenta_cliente`, `clave`, `cedula_cliente_usuario`) VALUES ('10', '101010', '101010');
    /*Cliente 10*/
    INSERT INTO `banco`.`cliente` (`numero_cliente`, `id_cliente`) VALUES ('9', '999');
    INSERT INTO `banco`.`cuenta_cliente` (`numero_cuenta_cliente`, `clave`, `cedula_cliente_usuario`) VALUES ('9', '999', '999');
    
    /*-------------------------------------------------------------------------------------*/
    /*-------------------------------------------------------------------------------------*/
    /*De esas 10 persona todas 4 seran cajeros 111 222 333 444*/
    INSERT INTO `banco`.`cajero` (`numero_cajero`, `id_cajero`) VALUES ('1', '111');
    INSERT INTO `banco`.`cuenta_cajero` (`numero_cuenta_cajero`, `clave`, `cedula_cajero_usuario`) VALUES ('1', '111c', '111');
    INSERT INTO `banco`.`cajero` (`numero_cajero`, `id_cajero`) VALUES ('2', '222');
    INSERT INTO `banco`.`cuenta_cajero` (`numero_cuenta_cajero`, `clave`, `cedula_cajero_usuario`) VALUES ('2', '222c', '222');
    INSERT INTO `banco`.`cajero` (`numero_cajero`, `id_cajero`) VALUES ('3', '333');
    INSERT INTO `banco`.`cuenta_cajero` (`numero_cuenta_cajero`, `clave`, `cedula_cajero_usuario`) VALUES ('3', '333c', '333');
    INSERT INTO `banco`.`cajero` (`numero_cajero`, `id_cajero`) VALUES ('4', '444');
    INSERT INTO `banco`.`cuenta_cajero` (`numero_cuenta_cajero`, `clave`, `cedula_cajero_usuario`) VALUES ('4', '444c', '444');
    
    /*-------------------------------------------------------------------------------------*/
    /*-------------------------------------------------------------------------------------*/
    /*Se agregan monedas*/
    INSERT INTO `banco`.`moneda` (`id`, `descripcion`, `porcentaje_interes`) VALUES ('1', 'colon', '4.5');
    INSERT INTO `banco`.`moneda` (`id`, `descripcion`, `porcentaje_interes`) VALUES ('2', 'dolar', '3.500');
    
    /*-------------------------------------------------------------------------------------*/
    /*-------------------------------------------------------------------------------------*/
    /*Se agregan a tablas de cambio_valor*/
    INSERT INTO `banco`.`cambio_valor` (`numero_entrada`, `id_moneda`, `fecha`, `valor_compra`, `valor_venta`) VALUES ('1', '1', '2020-03-21', '1', '1');
    INSERT INTO `banco`.`cambio_valor` (`numero_entrada`, `id_moneda`, `fecha`, `valor_compra`, `valor_venta`) VALUES ('2', '2', '2020-03-21', '640', '680');
    
    /*-------------------------------------------------------------------------------------*/
    /*-------------------------------------------------------------------------------------*/
    /*Se agregan cuentas*/
    /*Cada persona tendra 2 cuentas 1 en dolar y en colon*/
    /*Es decir se ingresaran 20 cuentas*/
    /*Cliente 1*/
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('1', '111', '1', '300000', '2', '2020-03-21');
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('2', '111', '2', '280', '3', '2020-03-21');
    /*Cliente 2*/
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('3', '222', '1', '330000', '2', '2020-03-21');
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('4', '222', '2', '1000', '3', '2020-03-21');
    /*Cliente 3*/
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('5', '333', '1', '1000000', '2', '2020-03-21');
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('6', '333', '2', '2800', '3', '2020-03-21');
    /*Cliente 4*/
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('7', '444', '1', '1000', '2', '2020-03-21');
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('8', '444', '2', '28', '3', '2020-03-21');
    /*Cliente 5*/
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('9', '555', '1', '550500', '2', '2020-03-21');
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('10', '555', '2', '300', '3', '2020-03-21');
    /*Cliente 6*/
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('11', '666', '1', '20000', '2', '2020-03-21');
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('12', '666', '2', '2', '3', '2020-03-21');
    /*Cliente 7*/
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('13', '777', '1', '5000', '2', '2020-03-21');
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('14', '777', '2', '700', '3', '2020-03-21');
    /*Cliente 8*/
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('15', '888', '1', '2245500', '2', '2020-03-21');
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('16', '888', '2', '10000', '3', '2020-03-21');
    /*Cliente 9*/
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('17', '999', '1', '3000', '2', '2020-03-21');
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('18', '999', '2', '280', '3', '2020-03-21');
    /*Cliente 10*/
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('19', '101010', '1', '12000', '2', '2020-03-21');
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('20', '101010', '2', '1000', '3', '2020-03-21');
    /*-------------------------------------------------------------------------------------*/
    /*-------------------------------------------------------------------------------------*/
    
    /*Se vinculan las cuentas con las siguientes relaciones, dejando cada cuenta con 2 cuentas vinculadas*/
    /*(numero cuenta)*/
    /*Cliente 1-10(19) 2-9(18) 3-8(15) 4-7(14) 5-6(11)*/
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('1', '111', '19','101010');
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('2', '222', '18','999');
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('3', '333', '15','888');
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('4', '444', '14','777');
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('5', '555', '11','666');
    /*Cliente 1-2(4) 2-8(16) 3-4(7) 4-5(9) 5-9(17)*/
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('6', '111', '4','222');
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('7', '222', '16','888');
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('8', '333', '7','444');
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('9', '444', '9','555');
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('10', '555', '17','999');
    /*Cliente 6-1(2) 7-2(3) 8-3(5) 9-4(8) 10-5(10)*/
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('11', '666', '2','111');
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('12', '777', '3','222');
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('13', '888', '5','333');
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('14', '999', '8','444');
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('15', '101010', '10','555');
    /*Cliente 6-2(4) 7-8(15) 8-4(8) 9-5(9) 10-9(18)*/
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('16', '666', '4','222');
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('17', '777', '15','888');
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('18', '888', '8','444');
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('19', '999', '9','555');
    INSERT INTO `banco`.`cuenta_vinculada` (`entrada`, `id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) VALUES ('20', '101010', '18','999');
    /*-------------------------------------------------------------------------------------*/
    /*-------------------------------------------------------------------------------------*/
    
    /*Se registran movimientos*/
    /*Se registran minimos ya que estos movimientos son pre funcionamiento de programa*/
    /*No se trabajara con ellos, ni seran necesarios para el funcionamiento del mismo*/
    /*Deposito de cliente 1 a 2*/
    INSERT INTO `banco`.`movimiento` (`numero`, `numero_cuenta_destino`, `tipo`, `monto`, `nombre_persona`, `primer_apellido_persona`, `segundo_apellido_persona`, `motivo`, `fecha`) 
    VALUES ('1', '3', 'Deposito', '10000', 'Esteban', 'Chinchilla', 'Brenes', 'Libro', '2020-03-21');
    
    /*Retiro de cliente 2 a su unica cuenta*/
    INSERT INTO `banco`.`movimiento` (`numero`, `numero_cuenta_destino`, `tipo`, `monto`, `fecha`)
    VALUES ('2', '3', 'Retiro', '2000', '2020-03-21');
    
    /*Transferencia de cliente 2 a cuenta 1 cliente 1*/
    INSERT INTO `banco`.`movimiento` (`numero`, `numero_cuenta_origen`, `numero_cuenta_destino`, `tipo`, `monto`, `motivo`, `fecha`)
    VALUES ('3', '3', '1', 'Transferencia', '40000', 'Clases', '2020-03-21');
    
    /*-------------------------------------------------------------------------------------*/
    /*-------------------------------------------------------------------------------------*/
    
    /*Procesos almacenados*/
    
    /*-------------------------------------------------------------------------------------*/
    /*-------------------------------------------------------------------------------------*/

    /*Consultas*/
    /*-------------------------------------------------------------------------------------*/
    /*-------------------------------------------------------------------------------------*/
    
	/*Buscar persona ID*/
    DELIMITER //
    CREATE PROCEDURE consultaPersonaID(IN _id INT)
    BEGIN
		SELECT * FROM persona WHERE id = _id;
    END//
    DELIMITER ;
    
    /*Llamo procedimiento*/
    CALL consultaPersonaID(111);
    
    /*-------------------------------------------------------------------------------------*/
    
    /*Consulta Cuenta por numero*/
    DELIMITER //
    CREATE PROCEDURE consultaCuentaNumero(IN _numero INT)
    BEGIN
		SELECT * FROM cuenta WHERE numero = _numero;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL consultaCuentaNumero(2);
    
    /*-------------------------------------------------------------------------------------*/
    
    /*Buscar Cuenta por id persona*/
    DELIMITER //
    CREATE PROCEDURE consultaCuentaID(IN _idpersona INT)
    BEGIN
		SELECT * FROM cuenta WHERE id_persona = _idpersona;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL consultaCuentaID(111);
    
    /*-------------------------------------------------------------------------------------*/
    
    /*Consulta Depositos cuenta*/
    DELIMITER //
    CREATE PROCEDURE consultaDepositoCuenta(IN _cuenta INT)
    BEGIN
		SELECT * FROM movimiento WHERE numero_cuenta_destino = _cuenta AND tipo = 'Deposito';
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL consultaDepositoCuenta(3);
    
    /*-------------------------------------------------------------------------------------*/
    
    /*Consulta Retiros cuenta*/
    DELIMITER //
    CREATE PROCEDURE consultaRetiroCuenta(IN _cuenta INT)
    BEGIN
		SELECT * FROM movimiento WHERE numero_cuenta_destino = _cuenta AND tipo = 'Retiro';
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL consultaRetiroCuenta(3);
    
    /*-------------------------------------------------------------------------------------*/
    
    /*Consulta Transferencias cuenta origen*/
    DELIMITER //
    CREATE PROCEDURE consultaTransferenciaOrigen(IN _cuenta INT)
    BEGIN
		SELECT * FROM movimiento WHERE numero_cuenta_origen = _cuenta AND tipo = 'Transferencia';
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL consultaTransferenciaOrigen(3);
    
    /*-------------------------------------------------------------------------------------*/
    
    /*Consulta Transferencias cuenta destino*/
    DELIMITER //
    CREATE PROCEDURE consultaTransferenciaDestino(IN _cuenta INT)
    BEGIN
		SELECT * FROM movimiento WHERE numero_cuenta_destino = _cuenta AND tipo = 'Transferencia';
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL consultaTransferenciaDestino(1);
    
    /*-------------------------------------------------------------------------------------*/
    
    /*Consulta Cuenta vinculada*/
    
    DELIMITER //
    CREATE PROCEDURE consultaCuentasVinculadas(IN _cliente INT)
    BEGIN
		SELECT * from cuenta AS x INNER JOIN cuenta_vinculada AS y 
        ON x.numero = y.numero_cuenta_vinculada AND y.id_cliente = _cliente;
    END//
    DELIMITER ;
    
    
    /*Llamo al procedimiento*/
    CALL consultaCuentasVinculadas(444);
    
/*-------------------------------------------------------------------------------------*/    
    
    /*Consulta Tabla monedas*/
    DELIMITER //
	CREATE PROCEDURE consultaMonedaID(IN _id INT)
    BEGIN
		SELECT * FROM moneda WHERE id = _id;
    END//
    DELIMITER ;
    
    /*Llamo procedimiento*/
    CALL consultaMonedaID(1);
    
    
    /*-------------------------------------------------------------------------------------*/
    /*-------------------------------------------------------------------------------------*/
  
    /*Listar*/
    
    /*-------------------------------------------------------------------------------------*/
    /*-------------------------------------------------------------------------------------*/
    
    /*listar clientes*/
    DELIMITER //
    CREATE PROCEDURE listarClientes()
    BEGIN
		SELECT * FROM persona, cuenta_cliente WHERE persona.id = cuenta_cliente.cedula_cliente_usuario;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listarClientes();
    
    /*-------------------------------------------------------------------------------------*/
    /*lista todos cajeros*/
    DELIMITER //
    CREATE PROCEDURE listarCajeros()
    BEGIN
		SELECT * FROM persona, cuenta_cajero WHERE persona.id = cuenta_cajero.cedula_cajero_usuario;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listarCajeros();
	
    /*-------------------------------------------------------------------------------------*/
	
    /*lista cuentas*/
    DELIMITER //
    CREATE PROCEDURE listarCuentas()
    BEGIN
		SELECT * FROM cuenta;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listarCuentas();
    
    /*-------------------------------------------------------------------------------------*/
    /*Lista monedas*/
    DELIMITER //
    CREATE PROCEDURE listarMonedas()
    BEGIN
		SELECT * FROM moneda;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listarMonedas();
    
    /*-------------------------------------------------------------------------------------*/
    
   /*-------------------------------------------------------------------------------------*/
    /*Lista monedas*/
    DELIMITER //
    CREATE PROCEDURE listarMovimientos()
    BEGIN
		SELECT * FROM movimiento;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listarMovimientos();
    
    /*-------------------------------------------------------------------------------------*/ 
    
    /*-------------------------------------------------------------------------------------*/
    /*Lista monedas*/
    DELIMITER //
    CREATE PROCEDURE listarMovimientos()
    BEGIN
		SELECT * FROM movimiento;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listarMovimientos();
    
    /*-------------------------------------------------------------------------------------*/
    
    /*Lista Cuentas Vinculadas*/
    DELIMITER //
    CREATE PROCEDURE listarCuentasVinculadas()
    BEGIN
		SELECT * from cuenta AS x INNER JOIN cuenta_vinculada AS y 
        ON x.id_persona = y.id_cliente;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listarCuentasVinculadas();
    
    /*-------------------------------------------------------------------------------------*/
    
    /*-------------------------------------------------------------------------------------*/
    
    /*Lista Cambio Valor*/
    DELIMITER //
    CREATE PROCEDURE listarCambioValor()
    BEGIN
		SELECT * from cambio_valor;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listarCambioValor();
    
    /*-------------------------------------------------------------------------------------*/
    
    /*-------------------------------------------------------------------------------------*/
    /*-------------------------------------------------------------------------------------*/
  
    /*Insertar*/
    
    /*-------------------------------------------------------------------------------------*/
    /*-------------------------------------------------------------------------------------*/
    
    /*-------------------------------------------------------------------------------------*/
    /*Insertar cliente*/
    DELIMITER //
    CREATE PROCEDURE insertarCliente(IN _id INT, _nombre VARCHAR(45), _primerApellido VARCHAR(45),
    _segundoApellido VARCHAR(45), _estadocivil VARCHAR(45), _provincia VARCHAR(45), _canton VARCHAR(45),
    _direccion VARCHAR(45), _telefono VARCHAR(45), _celular VARCHAR(45), _email VARCHAR(45), _edad INT,
    _clave VARCHAR(45)
    )
    BEGIN
		INSERT INTO persona (`id`, `nombre`, `primer_apelido`, `segundo_apellido`, `estado_civil`,
        `provincia`, `canton`, `direccion`, `telefono`, `celular`, `email`, `edad`) VALUES (
        _id, _nombre, _primerApellido, _segundoApellido, _estadocivil, _provincia, _canton,
        _direccion, _telefono, _celular, _email, _edad);
        INSERT INTO cliente(`id_cliente`) VALUE(_id);
        INSERT INTO cuenta_cliente(`clave`, `cedula_cliente_usuario`) VALUE(_clave, _id);
    END //
    DELIMITER ;
    
    /*Llamo procedimiento*/
    CALL insertarCliente('111111', 'Oscar', 'Arias', 'Sanchez', 'Soltero', 'San Jose', 'San Jose', 'La Sabana', '3423', '8982', 'osc.o.com', 99, '111111');
    /*-------------------------------------------------------------------------------------*/
    
    /*-------------------------------------------------------------------------------------*/
    /*Insertar cuenta*/
    DELIMITER //
    CREATE PROCEDURE insertarCuenta(
		IN _id_persona INT, _id_moneda INT, _interes DECIMAL(65,10)
    )
    BEGIN
		INSERT INTO cuenta(`id_persona`, `id_moneda`, `interes`, `fecha_creacion`) 
        VALUES(_id_persona, _id_moneda, _interes, CURRENT_DATE());
    END //
    DELIMITER ;
    
    /*Llamo procedimiento*/
    CALL insertarCuenta(111111,1,4.5);
    /*-------------------------------------------------------------------------------------*/
    
    /*-------------------------------------------------------------------------------------*/
    /*Insertar cuenta_vinculada*/
    DELIMITER //
    CREATE PROCEDURE insertarCuentaVinculada(
		IN _id INT, _cuenta_vinculada INT, _id_vinculado INT
    )
    BEGIN
		INSERT INTO cuenta_vinculada(`id_cliente`, `numero_cuenta_vinculada`, `id_cliente_vinculado`) 
        VALUES(_id, _cuenta_vinculada, _id_vinculado);
    END //
    DELIMITER ;
    
    /*Llamo procedimiento*/
    CALL insertarCuentaVinculada(111111,1,111);
    
    /*-------------------------------------------------------------------------------------*/
    
    /*-------------------------------------------------------------------------------------*/
    /*Insertar deposito*/
    DELIMITER //
    CREATE PROCEDURE insertarDeposito(
		IN _numero_cuenta_destino INT, _monto DECIMAL(65,10), _nombre_persona VARCHAR(45), _primer_apellido_persona VARCHAR(45),
           _segundo_apellido_persona VARCHAR(45), _motivo VARCHAR(65)
    )
    BEGIN
		INSERT INTO movimiento(`numero_cuenta_destino`, `tipo`, `monto`, `nombre_persona`, `primer_apellido_persona`, `segundo_apellido_persona`, `motivo`, `fecha`) 
        VALUES(_numero_cuenta_destino, 'Deposito', _monto, _nombre_persona, _primer_apellido_persona, _segundo_apellido_persona, _motivo, CURRENT_DATE());
    END //
    DELIMITER ;
	
    /*Llamo procedimiento*/
    CALL insertarDeposito(1, 450.56, 'Miguel', 'Vazquez', 'Coto', 'bicicleta');
    
    /*-------------------------------------------------------------------------------------*/
    
    /*-------------------------------------------------------------------------------------*/
    /*Insertar retiro*/
    DELIMITER //
    CREATE PROCEDURE insertarRetiro(
		IN _numero_cuenta_destino INT, _monto DECIMAL(65,10)
    )
    BEGIN
		INSERT INTO movimiento(`numero_cuenta_destino`, `tipo`, `monto`, `fecha`) 
        VALUES (_numero_cuenta_destino, 'Retiro', _monto, CURRENT_DATE());
    END //
    DELIMITER ;
	
    /*Llamo procedimiento*/
    CALL insertarRetiro(1, 100);
    /*-------------------------------------------------------------------------------------*/
    
    /*-------------------------------------------------------------------------------------*/
    /*Insertar Transferencia*/
    DELIMITER //
    CREATE PROCEDURE insertarTransferencia(
		IN _numero_cuenta_origen INT, _numero_cuenta_destino INT, _monto DECIMAL(65,10), _motivo VARCHAR(65)
    )
    BEGIN
		INSERT INTO movimiento(`numero_cuenta_origen`, `numero_cuenta_destino`, `tipo`, `monto`, `motivo`, `fecha`) 
        VALUES(_numero_cuenta_origen, _numero_cuenta_destino, 'Transferencia', _monto, _motivo, CURRENT_DATE());
    END //
    DELIMITER ;
	
    /*Llamo procedimiento*/
    CALL insertarTransferencia(1, 2, 500, 'Carro');
    /*-------------------------------------------------------------------------------------*/
    
    /*-------------------------------------------------------------------------------------*/
    /*------------------------------------------------------------------------------------------*/
    
    /*Consultas Especificas*/
    
    /*saldo cuenta por numero*/
    DELIMITER //
    CREATE PROCEDURE saldoCuenta(IN _numero INT)
    BEGIN
		SELECT saldo FROM cuenta WHERE numero = _numero;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL saldoCuenta(2);
    
    /*busqueda perfil usuario por id*/
    DELIMITER //
    CREATE PROCEDURE perfilUsuarioID(IN _id INT)
    BEGIN
		SELECT * FROM cuenta_cliente WHERE cedula_cliente_usuario = _id;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL perfilUsuarioID(111);
    
    /*lista todos clientes*/
    DELIMITER //
    CREATE PROCEDURE listaClientesTotales()
    BEGIN
		SELECT * FROM persona, cuenta_cliente WHERE persona.id = cuenta_cliente.cedula_cliente_usuario;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listaClientesTotales();
    
    /*lista todos cajeros*/
    DELIMITER //
    CREATE PROCEDURE listaCajerosTotales()
    BEGIN
		SELECT * FROM persona, cuenta_cajero WHERE persona.id = cuenta_cajero.cedula_cajero_usuario;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listaCajerosTotales();
    
    /*lista cuentas vinculadas*/
    
    
    /*busqueda perfil cajero por id*/
    DELIMITER //
    CREATE PROCEDURE perfilCajeroID(IN _id INT)
    BEGIN
		SELECT * FROM cuenta_cajero WHERE cedula_cajero_usuario = _id;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL perfilCajeroID(222);
    
    /*busqueda cambio_valor id moneda*/
    DELIMITER //
    CREATE PROCEDURE consultaCambioMoneda(IN _id INT)
    BEGIN
		SELECT * FROM cambio_valor WHERE id_moneda = _id;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL consultaCambioMoneda(1);
    
    /*modificar monto*/
    DELIMITER //
    CREATE PROCEDURE modificarSaldo(IN _numero INT, _saldo DECIMAL(65,10))
    BEGIN
		UPDATE cuenta SET saldo = _saldo WHERE  numero = _numero;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL modificarSaldo(1,9999);
    
    /*Falta queries para aplicar los intereses*/
    
    
    
    
    
    
    
    
    