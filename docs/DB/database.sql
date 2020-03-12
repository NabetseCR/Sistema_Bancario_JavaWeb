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
ADD COLUMN `porcentaje_interes` DECIMAL(10,3) NOT NULL AFTER `descripcion`;
  
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
    
    /*Se modifica cuenta por defecto 0, not null date*/
    ALTER TABLE `banco`.`cuenta` 
	CHANGE COLUMN `saldo` `saldo` DECIMAL(65,10) NULL DEFAULT 0 ,
	CHANGE COLUMN `fecha_creacion` `fecha_creacion` DATE NULL ;
    
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
    
    /*Se queman datos*/
    /*Se inserta Persona*/
    /*Persona 1*/
    INSERT INTO `banco`.`persona` (`id`, `nombre`, `primer_apelido`, `segundo_apellido`, `estado_civil`, `provincia`, `canton`, `direccion`, `telefono`, `celular`, `email`, `edad`)
    VALUES ('111', 'Esteban', 'Chinchilla', 'Brenes', 'Soltero', 'Alajuela', 'Alajuela', 'Calle la flory', '2321', '8978', 'est.e.com', '22');
    
    /*Persona 2*/
    INSERT INTO `banco`.`persona` (`id`, `nombre`, `primer_apelido`, `segundo_apellido`, `estado_civil`, `provincia`, `canton`, `direccion`, `telefono`, `celular`, `email`, `edad`) 
    VALUES ('222', 'Ana', 'Solano', 'Benavides', 'Soltera', 'Heredia', 'Santa Barbara', 'Calle Cajon', '2123', '8899', 'ana.a.com', '22');
    
    /*Persona 1 solo es cliente por cuanto se agrega a cliente y cuenta_cliente*/
    INSERT INTO `banco`.`cliente` (`numero_cliente`, `id_cliente`) VALUES ('1', '111');
    INSERT INTO `banco`.`cuenta_cliente` (`numero_cuenta_cliente`, `clave`, `cedula_cliente_usuario`) VALUES ('1', '111', '111');
    
    /*Persona 2 es cajera y cliente por cuanto se agrega en cajero/cliente cuenta_cajero/cliente */
    INSERT INTO `banco`.`cliente` (`numero_cliente`, `id_cliente`) VALUES ('2', '222');
    INSERT INTO `banco`.`cuenta_cliente` (`numero_cuenta_cliente`, `clave`, `cedula_cliente_usuario`) VALUES ('2', '222', '222');
    INSERT INTO `banco`.`cajero` (`numero_cajero`, `id_cajero`) VALUES ('1', '222');
    INSERT INTO `banco`.`cuenta_cajero` (`numero_cuenta_cajero`, `clave`, `cedula_cajero_usuario`) VALUES ('1', '222c', '222');
    
    /*Se agregan monedas*/
    INSERT INTO `banco`.`moneda` (`id`, `descripcion`, `porcentaje_interes`) VALUES ('1', 'colon', '4.5');
    INSERT INTO `banco`.`moneda` (`id`, `descripcion`, `porcentaje_interes`) VALUES ('2', 'dolar', '3.500');
    
    /*Se agregan a tablas de cambio_valor*/
    INSERT INTO `banco`.`cambio_valor` (`numero_entrada`, `id_moneda`, `fecha`, `valor_compra`, `valor_venta`) VALUES ('1', '1', '0000-00-00', '1', '1');
    INSERT INTO `banco`.`cambio_valor` (`numero_entrada`, `id_moneda`, `fecha`, `valor_compra`, `valor_venta`) VALUES ('2', '2', '0000-00-00', '640', '680');
    
    /*Se agregan cuentas*/
    
    /*Persona 1 tiene 2 cuentas 1 en colon otra en dolar*/
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('1', '111', '1', '300000', '2', '0000-00-00');
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('2', '111', '2', '280', '3', '0000-00-00');
    
    /*Persona 2 tiene 1 cuenta en colon*/
    INSERT INTO `banco`.`cuenta` (`numero`, `id_persona`, `id_moneda`, `saldo`, `interes`, `fecha_creacion`) VALUES ('3', '222', '1', '1000000', '2', '0000-00-00');
    
    /*Se vinculan las cuentas*/
    
    /*Persona 1 tiene vinculada cuenta 3 de persona 2*/
    INSERT INTO `banco`.`cuenta_vinculada` (`numero_entrada`, `numero_cuenta_raiz`, `numero_cuenta_objetivo`) VALUES ('1', '1', '3');
    
    /*Persona 2 tiene solo vinculada cuenta 1 de persona 1*/
    INSERT INTO `banco`.`cuenta_vinculada` (`numero_entrada`, `numero_cuenta_raiz`, `numero_cuenta_objetivo`) VALUES ('2', '3', '1');
    
    /*Se registran movimientos*/
    /*Deposito de persona 1 a persona 2*/
    INSERT INTO `banco`.`movimiento` (`numero`, `numero_cuenta_destino`, `tipo`, `monto`, `nombre_persona`, `primer_apellido_persona`, `segundo_apellido_persona`, `motivo`, `fecha`) 
    VALUES ('1', '3', 'Deposito', '10000', 'Esteban', 'Chinchilla', 'Brenes', 'Libro', '0000-00-00');
    
    /*Retiro de persona 2 a su unica cuenta*/
    INSERT INTO `banco`.`movimiento` (`numero`, `numero_cuenta_destino`, `tipo`, `monto`, `fecha`)
    VALUES ('2', '3', 'Retiro', '2000', '0000-00-00');
    
    /*Transferencia de persona 2 a cuenta 1 de persona 1*/
    INSERT INTO `banco`.`movimiento` (`numero`, `numero_cuenta_origen`, `numero_cuenta_destino`, `tipo`, `monto`, `motivo`, `fecha`)
    VALUES ('3', '3', '1', 'Transferencia', '40000', 'Clases', '0000-00-00');
    
    /*-------------------------------------------------------------------------------------*/
    
    /*Procesos almacenados*/
    
    /*Consultas*/
    
	/*Buscar persona ID*/
    DELIMITER //
    CREATE PROCEDURE listaPersona(IN _id INT)
    BEGIN
		SELECT * FROM persona WHERE id = _id;
    END//
    DELIMITER ;
    
    /*Llamo procedimiento*/
    CALL listaPersona(111);
    
    /*Buscar Cuenta por numero*/
    DELIMITER //
    CREATE PROCEDURE listaCuenta(IN _numero INT)
    BEGIN
		SELECT * FROM cuenta WHERE numero = _numero;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listaCuenta(2);
    
    /*Buscar Cuenta por id persona*/
    DELIMITER //
    CREATE PROCEDURE listaCuentaID(IN _idpersona INT)
    BEGIN
		SELECT * FROM cuenta WHERE id_persona = _idpersona;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listaCuentaID(111);
    
    /*Consulta Depositos cuenta*/
    DELIMITER //
    CREATE PROCEDURE listaDeposito(IN _cuenta INT)
    BEGIN
		SELECT * FROM movimiento WHERE numero_cuenta_destino = _cuenta AND tipo = 'Deposito';
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listaDeposito(3);
    
    /*Consulta Retiros cuenta*/
    DELIMITER //
    CREATE PROCEDURE listaRetiro(IN _cuenta INT)
    BEGIN
		SELECT * FROM movimiento WHERE numero_cuenta_destino = _cuenta AND tipo = 'Retiro';
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listaRetiro(3);
    
    /*Consulta Transferencias cuenta origen*/
    DELIMITER //
    CREATE PROCEDURE listaTransferenciaOrigen(IN _cuenta INT)
    BEGIN
		SELECT * FROM movimiento WHERE numero_cuenta_origen = _cuenta AND tipo = 'Transferencia';
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listaTransferenciaOrigen(3);
    
    /*Consulta Transferencias cuenta destino*/
    DELIMITER //
    CREATE PROCEDURE listaTransferenciaDestino(IN _cuenta INT)
    BEGIN
		SELECT * FROM movimiento WHERE numero_cuenta_destino = _cuenta AND tipo = 'Transferencia';
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listaTransferenciaDestino(1);
    
    /*Consulta Cuenta vinculada*/
    DELIMITER //
    CREATE PROCEDURE listaCuentaVinculada(IN _cuenta INT)
    BEGIN
		SELECT * FROM cuenta_vinculada WHERE numero_cuenta_raiz = _cuenta;
    END//
    DELIMITER ;
    
    /*Llamo al procedimiento*/
    CALL listaCuentaVinculada(1);
    
    /*Consulta Tabla monedas*/
    DELIMITER //
	CREATE PROCEDURE listaMoneda(IN _id INT)
    BEGIN
		SELECT * FROM moneda WHERE id = _id;
    END//
    DELIMITER ;
    
    /*Llamo procedimiento*/
    CALL listaMoneda(1);
    
    /*-----------------------------------------------------------------------------------*/
    
    /*Insertar*/
    
    /*Insertar persona*/
    DELIMITER //
    CREATE PROCEDURE insertarPersona(IN _id INT, _nombre VARCHAR(45), _primerApellido VARCHAR(45),
    _segundoApellido VARCHAR(45), _estadocivil VARCHAR(45), _provincia VARCHAR(45), _canton VARCHAR(45),
    _direccion VARCHAR(45), _telefono VARCHAR(45), _celular VARCHAR(45), _email VARCHAR(45), _edad INT
    )
    BEGIN
		INSERT INTO persona (`id`, `nombre`, `primer_apelido`, `segundo_apellido`, `estado_civil`,
        `provincia`, `canton`, `direccion`, `telefono`, `celular`, `email`, `edad`) VALUES (
        _id, _nombre, _primerApellido, _segundoApellido, _estadocivil, _provincia, _canton,
        _direccion, _telefono, _celular, _email, _edad);
    END //
    DELIMITER ;
    
    /*Llamo procedimiento*/
    CALL insertarPersona(333, 'Oscar', 'Arias', 'Sanchez', 'Soltero', 'San Jose', 'San Jose', 'La Sabana', '3423', '8982', 'osc.o.com', 99);
    
    /*Insertar persona cliente*/
    DELIMITER //
    CREATE PROCEDURE insertarCliente(IN _id_cliente INT)
    BEGIN
		INSERT INTO cliente(`id_cliente`) VALUE(_id_cliente);
    END //
    DELIMITER ;
    
    /*Llamo procedimiento*/
    CALL insertarCliente(333);
    
    /*Insertar cuenta_cliente*/
    DELIMITER //
    CREATE PROCEDURE insertarCuentaCliente(IN _clave VARCHAR(45), _cedula_cliente_usuario INT)
    BEGIN
		INSERT INTO cuenta_cliente(`clave`, `cedula_cliente_usuario`) VALUE(_clave, _cedula_cliente_usuario);
    END //
    DELIMITER ;
    
    /*Llamo procedimiento*/
    CALL insertarCuentaCliente('333',333);
    
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
    CALL insertarCuenta(333,1,4.5);
    
    /*Insertar cuenta_vinculada*/
    DELIMITER //
    CREATE PROCEDURE insertarCuentaVinculada(
		IN cuenta_raiz INT, cuenta_objetivo INT
    )
    BEGIN
		INSERT INTO cuenta_vinculada(`numero_cuenta_raiz`, `numero_cuenta_objetivo`) 
        VALUES(cuenta_raiz,cuenta_objetivo);
    END //
    DELIMITER ;
    
    /*Llamo procedimiento*/
    CALL insertarCuentaVinculada(4,1);
    
    
    
    
    
    
    
    
    