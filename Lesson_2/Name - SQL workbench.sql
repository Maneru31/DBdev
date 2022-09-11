-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Steam
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `User` ;

CREATE TABLE IF NOT EXISTS `User` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comments` ;

CREATE TABLE IF NOT EXISTS `Comments` (
  `idComments` INT NOT NULL AUTO_INCREMENT,
  `comment` VARCHAR(45) NOT NULL,
  `idUser` INT NOT NULL,
  PRIMARY KEY (`idComments`),
  INDEX `User_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `User`
    FOREIGN KEY (`idUser`)
    REFERENCES `User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Games`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Games` ;

CREATE TABLE IF NOT EXISTS `Games` (
  `idGame` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `creator` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  `idComment` INT NOT NULL,
  PRIMARY KEY (`idGame`),
  INDEX `Comments_idx` (`idComment` ASC) VISIBLE,
  CONSTRAINT `Comments`
    FOREIGN KEY (`idComment`)
    REFERENCES `Comments` (`idComments`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Item` ;

CREATE TABLE IF NOT EXISTS `Item` (
  `idItem` INT NOT NULL AUTO_INCREMENT,
  `idGame` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idItem`),
  INDEX `Game_idx` (`idGame` ASC) VISIBLE,
  CONSTRAINT `Game`
    FOREIGN KEY (`idGame`)
    REFERENCES `Games` (`idGame`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Trade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Trade` ;

CREATE TABLE IF NOT EXISTS `Trade` (
  `idTrade` INT NOT NULL AUTO_INCREMENT,
  `idItem` INT NOT NULL,
  PRIMARY KEY (`idTrade`),
  INDEX `Item_idx` (`idItem` ASC) VISIBLE,
  CONSTRAINT `Item`
    FOREIGN KEY (`idItem`)
    REFERENCES `Item` (`idItem`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Inventar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Inventar` ;

CREATE TABLE IF NOT EXISTS `Inventar` (
  `idInventar` INT NOT NULL AUTO_INCREMENT,
  `idGame` INT NOT NULL,
  `idItem` INT NOT NULL,
  `idTrade` INT NOT NULL,
  PRIMARY KEY (`idInventar`),
  INDEX `Trade_idx` (`idTrade` ASC) VISIBLE,
  INDEX `Item_idx` (`idItem` ASC) VISIBLE,
  CONSTRAINT `Trade`
    FOREIGN KEY (`idTrade`)
    REFERENCES `Trade` (`idTrade`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Item`
    FOREIGN KEY (`idItem`)
    REFERENCES `Item` (`idItem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Profile` ;

CREATE TABLE IF NOT EXISTS `Profile` (
  `idProfile` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `idUser` INT NOT NULL,
  `idGame` INT NOT NULL,
  `level` INT NOT NULL,
  `idInventar` INT NOT NULL,
  PRIMARY KEY (`idProfile`),
  INDEX `User_idx` (`idUser` ASC) VISIBLE,
  INDEX `Inventar_idx` (`idInventar` ASC) VISIBLE,
  CONSTRAINT `User`
    FOREIGN KEY (`idUser`)
    REFERENCES `User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Inventar`
    FOREIGN KEY (`idInventar`)
    REFERENCES `Inventar` (`idInventar`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Chat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Chat` ;

CREATE TABLE IF NOT EXISTS `Chat` (
  `idChat` INT NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(45) NOT NULL,
  `idUser` INT NOT NULL,
  PRIMARY KEY (`idChat`),
  INDEX `IdUser_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `IdUser`
    FOREIGN KEY (`idUser`)
    REFERENCES `User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Friends`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Friends` ;

CREATE TABLE IF NOT EXISTS `Friends` (
  `idFriends` INT NOT NULL AUTO_INCREMENT,
  `accept_friend` INT NOT NULL,
  `cancel_friend` INT NOT NULL,
  `message` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFriends`),
  INDEX `Accept_idx` (`accept_friend` ASC, `cancel_friend` ASC) VISIBLE,
  CONSTRAINT `Accept`
    FOREIGN KEY (`accept_friend` , `cancel_friend`)
    REFERENCES `User` (`idUser` , `idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Forum`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Forum` ;

CREATE TABLE IF NOT EXISTS `Forum` (
  `idForum` INT NOT NULL AUTO_INCREMENT,
  `idComments` INT NOT NULL,
  `idUser` INT NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idForum`),
  INDEX `Comments_idx` (`idComments` ASC) VISIBLE,
  INDEX `User_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `Comments`
    FOREIGN KEY (`idComments`)
    REFERENCES `Comments` (`idComments`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `User`
    FOREIGN KEY (`idUser`)
    REFERENCES `User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
