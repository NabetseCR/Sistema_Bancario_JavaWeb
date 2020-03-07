/*Creo la base de datos*/
create schema Banco;

/*Se usa la base de datos*/
use Banco;

/*Se crean las tablas*/

/*Tabla persona*/
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
  
  /*Tabla cliente*/
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
  
  /*Tabla cuenta_cliente*/
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
    
    /*Tabla Moneda*/
CREATE TABLE `banco`.`moneda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));
  
  /*Se me olvido poner la porcentaje de interes de moneda*/
  /*Se agrega columna destinada para eso*/
  ALTER TABLE `banco`.`moneda` 
ADD COLUMN `porcentaje_interes` DECIMAL(3,3) NOT NULL AFTER `descripcion`;
  
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
    
    /*Tabla cuenta_vinculada*/
    CREATE TABLE `banco`.`cuenta_vinculada` (
  `numero_entrada` INT NOT NULL AUTO_INCREMENT,
  `numero_cuenta_raiz` INT NOT NULL,
  `numero_cuenta_objetivo` INT NOT NULL,
  PRIMARY KEY (`numero_entrada`),
  INDEX `fk_vinculada_raiz_idx` (`numero_cuenta_raiz` ASC) VISIBLE,
  INDEX `fk_vinculada_objetivo_idx` (`numero_cuenta_objetivo` ASC) VISIBLE,
  CONSTRAINT `fk_vinculada_raiz`
    FOREIGN KEY (`numero_cuenta_raiz`)
    REFERENCES `banco`.`cuenta` (`numero`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vinculada_objetivo`
    FOREIGN KEY (`numero_cuenta_objetivo`)
    REFERENCES `banco`.`cuenta` (`numero`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
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
    
    
    
    /*-------------------------------------------------------------------------------------*/
    
    /*Se queman datos*/
    
    
    /*-------------------------------------------------------------------------------------*/
    
    /*Procesos almacenados*/
