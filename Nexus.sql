-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema japyld
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Nexus
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Nexus
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Nexus` ;
USE `mydb` ;
USE `Nexus` ;

-- -----------------------------------------------------
-- Table `Nexus`.`Cargos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Nexus`.`Cargos` (
  `idCargos` INT NOT NULL AUTO_INCREMENT,
  `nombreCargo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCargos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Nexus`.`Empresas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Nexus`.`Empresas` (
  `idEmpresas` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `ruc` INT NOT NULL,
  `telefono` INT NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `fechaAfiliacion` DATE NULL,
  PRIMARY KEY (`idEmpresas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Nexus`.`Imagenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Nexus`.`Imagenes` (
  `idImagenes` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  `imagen` LONGBLOB NULL,
  PRIMARY KEY (`idImagenes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Nexus`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Nexus`.`Usuarios` (
  `idUsuarios` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `contrasenia` VARCHAR(45) NOT NULL,
  `habilitado` TINYINT(1) NOT NULL,
  `fechaRegistro` DATE NULL,
  `tecnicoConCuadrilla` TINYINT(1) NULL,
  `idCargos` INT NOT NULL,
  `idEmpresas` INT NOT NULL,
  `idImagenPerfil` INT NOT NULL,
  PRIMARY KEY (`idUsuarios`),
  INDEX `fk_Usuarios_Cargos_idx` (`idCargos` ASC) VISIBLE,
  INDEX `fk_Usuarios_Empresas1_idx` (`idEmpresas` ASC) VISIBLE,
  INDEX `fk_Usuarios_Imagenes1_idx` (`idImagenPerfil` ASC) VISIBLE,
  CONSTRAINT `fk_Usuarios_Cargos`
    FOREIGN KEY (`idCargos`)
    REFERENCES `Nexus`.`Cargos` (`idCargos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_Empresas1`
    FOREIGN KEY (`idEmpresas`)
    REFERENCES `Nexus`.`Empresas` (`idEmpresas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_Imagenes1`
    FOREIGN KEY (`idImagenPerfil`)
    REFERENCES `Nexus`.`Imagenes` (`idImagenes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Nexus`.`Cuadrillas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Nexus`.`Cuadrillas` (
  `idCuadrillas` INT NOT NULL AUTO_INCREMENT,
  `idSupervisor` INT NOT NULL,
  `idTecnico` INT NOT NULL,
  `ocupado` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idCuadrillas`),
  INDEX `fk_Cuadrillas_Usuarios1_idx` (`idSupervisor` ASC) VISIBLE,
  INDEX `fk_Cuadrillas_Usuarios2_idx` (`idTecnico` ASC) VISIBLE,
  CONSTRAINT `fk_Cuadrillas_Usuarios1`
    FOREIGN KEY (`idSupervisor`)
    REFERENCES `Nexus`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cuadrillas_Usuarios2`
    FOREIGN KEY (`idTecnico`)
    REFERENCES `Nexus`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Nexus`.`Sitios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Nexus`.`Sitios` (
  `idSitios` INT NOT NULL AUTO_INCREMENT,
  `tipo` TINYINT(1) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `distrito` VARCHAR(45) NOT NULL,
  `ubigeo` INT NOT NULL,
  `longitud` DECIMAL(12) NOT NULL,
  `departamento` VARCHAR(45) NOT NULL,
  `latitud` DECIMAL(12) NOT NULL,
  `habilitado` TINYINT(1) NOT NULL,
  `tipoZona` TINYINT(1) NOT NULL,
  `archivo` LONGBLOB NULL,
  PRIMARY KEY (`idSitios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Nexus`.`Tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Nexus`.`Tickets` (
  `idTickets` INT NOT NULL AUTO_INCREMENT,
  `tipoTicket` TINYINT(1) NOT NULL,
  `latitud` DECIMAL(12) NULL,
  `longitud` DECIMAL(12) NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `estado` INT NOT NULL,
  `idImagenTicket` INT NOT NULL,
  `idSupervisorEncargado` INT NULL,
  `idUsuarioCreador` INT NOT NULL,
  `idEmpresaAsignada` INT NOT NULL,
  `idCuadrilla` INT NULL,
  `idSitios` INT NOT NULL,
  PRIMARY KEY (`idTickets`),
  INDEX `fk_Tickets_Imagenes1_idx` (`idImagenTicket` ASC) VISIBLE,
  INDEX `fk_Tickets_Usuarios1_idx` (`idSupervisorEncargado` ASC) VISIBLE,
  INDEX `fk_Tickets_Usuarios2_idx` (`idUsuarioCreador` ASC) VISIBLE,
  INDEX `fk_Tickets_Empresas1_idx` (`idEmpresaAsignada` ASC) VISIBLE,
  INDEX `fk_Tickets_Cuadrillas1_idx` (`idCuadrilla` ASC) VISIBLE,
  INDEX `fk_Tickets_Sitios1_idx` (`idSitios` ASC) VISIBLE,
  CONSTRAINT `fk_Tickets_Imagenes1`
    FOREIGN KEY (`idImagenTicket`)
    REFERENCES `Nexus`.`Imagenes` (`idImagenes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tickets_Usuarios1`
    FOREIGN KEY (`idSupervisorEncargado`)
    REFERENCES `Nexus`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tickets_Usuarios2`
    FOREIGN KEY (`idUsuarioCreador`)
    REFERENCES `Nexus`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tickets_Empresas1`
    FOREIGN KEY (`idEmpresaAsignada`)
    REFERENCES `Nexus`.`Empresas` (`idEmpresas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tickets_Cuadrillas1`
    FOREIGN KEY (`idCuadrilla`)
    REFERENCES `Nexus`.`Cuadrillas` (`idCuadrillas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tickets_Sitios1`
    FOREIGN KEY (`idSitios`)
    REFERENCES `Nexus`.`Sitios` (`idSitios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Nexus`.`Formularios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Nexus`.`Formularios` (
  `idFormularios` INT NOT NULL AUTO_INCREMENT,
  `fechaLlenado` DATETIME NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `confirmacion` TINYINT(1) NOT NULL,
  `idTecnico` INT NOT NULL,
  `idImagenesForm` INT NOT NULL,
  `idTickets` INT NOT NULL,
  PRIMARY KEY (`idFormularios`),
  INDEX `fk_Formularios_Usuarios1_idx` (`idTecnico` ASC) VISIBLE,
  INDEX `fk_Formularios_Imagenes1_idx` (`idImagenesForm` ASC) VISIBLE,
  INDEX `fk_Formularios_Tickets1_idx` (`idTickets` ASC) VISIBLE,
  CONSTRAINT `fk_Formularios_Usuarios1`
    FOREIGN KEY (`idTecnico`)
    REFERENCES `Nexus`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Formularios_Imagenes1`
    FOREIGN KEY (`idImagenesForm`)
    REFERENCES `Nexus`.`Imagenes` (`idImagenes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Formularios_Tickets1`
    FOREIGN KEY (`idTickets`)
    REFERENCES `Nexus`.`Tickets` (`idTickets`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Nexus`.`TipoEquipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Nexus`.`TipoEquipo` (
  `idTipoEquipo` INT NOT NULL AUTO_INCREMENT,
  `nombreTipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoEquipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Nexus`.`Equipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Nexus`.`Equipos` (
  `idEquipos` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `paginaModelo` VARCHAR(45) NULL,
  `idSitios` INT NOT NULL,
  `idImagenes` INT NOT NULL,
  `idTipoEquipo` INT NOT NULL,
  PRIMARY KEY (`idEquipos`),
  INDEX `fk_Equipos_Sitios1_idx` (`idSitios` ASC) VISIBLE,
  INDEX `fk_Equipos_Imagenes1_idx` (`idImagenes` ASC) VISIBLE,
  INDEX `fk_Equipos_TipoEquipo1_idx` (`idTipoEquipo` ASC) VISIBLE,
  CONSTRAINT `fk_Equipos_Sitios1`
    FOREIGN KEY (`idSitios`)
    REFERENCES `Nexus`.`Sitios` (`idSitios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipos_Imagenes1`
    FOREIGN KEY (`idImagenes`)
    REFERENCES `Nexus`.`Imagenes` (`idImagenes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipos_TipoEquipo1`
    FOREIGN KEY (`idTipoEquipo`)
    REFERENCES `Nexus`.`TipoEquipo` (`idTipoEquipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Nexus`.`DinamicaEquipoAtributo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Nexus`.`DinamicaEquipoAtributo` (
  `idDinamicaEquipoAtributo` INT NOT NULL AUTO_INCREMENT,
  `nuevoCampo` VARCHAR(45) NOT NULL,
  `tipoDato` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDinamicaEquipoAtributo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Nexus`.`DinamicaEquipoValor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Nexus`.`DinamicaEquipoValor` (
  `idAtributoEquipo` INT NOT NULL,
  `idEquipos` INT NOT NULL,
  `valorNuevoCampo` VARCHAR(45) NULL,
  PRIMARY KEY (`idAtributoEquipo`, `idEquipos`),
  INDEX `fk_DinamicaEquipoAtributo_has_Equipos_Equipos1_idx` (`idEquipos` ASC) VISIBLE,
  INDEX `fk_DinamicaEquipoAtributo_has_Equipos_DinamicaEquipoAtribut_idx` (`idAtributoEquipo` ASC) VISIBLE,
  CONSTRAINT `fk_DinamicaEquipoAtributo_has_Equipos_DinamicaEquipoAtributo1`
    FOREIGN KEY (`idAtributoEquipo`)
    REFERENCES `Nexus`.`DinamicaEquipoAtributo` (`idDinamicaEquipoAtributo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DinamicaEquipoAtributo_has_Equipos_Equipos1`
    FOREIGN KEY (`idEquipos`)
    REFERENCES `Nexus`.`Equipos` (`idEquipos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Nexus`.`DinamicaSitioAtributo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Nexus`.`DinamicaSitioAtributo` (
  `idDinamicaSitioAtributo` INT NOT NULL AUTO_INCREMENT,
  `nuevoCampo` VARCHAR(45) NOT NULL,
  `tipoAtributo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDinamicaSitioAtributo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Nexus`.`DinamicaSitioValor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Nexus`.`DinamicaSitioValor` (
  `idSitios` INT NOT NULL,
  `idAtributoSitio` INT NOT NULL,
  `valorNuevoCampo` VARCHAR(45) NULL,
  PRIMARY KEY (`idSitios`, `idAtributoSitio`),
  INDEX `fk_Sitios_has_DinamicaSitioAtributo_DinamicaSitioAtributo1_idx` (`idAtributoSitio` ASC) VISIBLE,
  INDEX `fk_Sitios_has_DinamicaSitioAtributo_Sitios1_idx` (`idSitios` ASC) VISIBLE,
  CONSTRAINT `fk_Sitios_has_DinamicaSitioAtributo_Sitios1`
    FOREIGN KEY (`idSitios`)
    REFERENCES `Nexus`.`Sitios` (`idSitios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sitios_has_DinamicaSitioAtributo_DinamicaSitioAtributo1`
    FOREIGN KEY (`idAtributoSitio`)
    REFERENCES `Nexus`.`DinamicaSitioAtributo` (`idDinamicaSitioAtributo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Nexus`.`Comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Nexus`.`Comentarios` (
  `idComentarios` INT NOT NULL AUTO_INCREMENT,
  `comentario` TEXT NULL,
  `fechaPublicacion` DATETIME NOT NULL,
  `idTickets` INT NOT NULL,
  `idComentarista` INT NOT NULL,
  PRIMARY KEY (`idComentarios`),
  INDEX `fk_Comentarios_Tickets1_idx` (`idTickets` ASC) VISIBLE,
  INDEX `fk_Comentarios_Usuarios1_idx` (`idComentarista` ASC) VISIBLE,
  CONSTRAINT `fk_Comentarios_Tickets1`
    FOREIGN KEY (`idTickets`)
    REFERENCES `Nexus`.`Tickets` (`idTickets`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comentarios_Usuarios1`
    FOREIGN KEY (`idComentarista`)
    REFERENCES `Nexus`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`view1` (`id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`view2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`view2` (`id` INT);

-- -----------------------------------------------------
-- View `mydb`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`view1`;
USE `mydb`;


-- -----------------------------------------------------
-- View `mydb`.`view2`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`view2`;
USE `mydb`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
