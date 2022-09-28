-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema steam
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema steam
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `steam` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `steam` ;

-- -----------------------------------------------------
-- Table `steam`.`chat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `steam`.`chat` (
  `idChat` INT NOT NULL AUTO_INCREMENT,
  `message` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`idChat`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `steam`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `steam`.`user` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `Chat_idChat` INT NOT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `steam`.`chat_has_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `steam`.`chat_has_user` (
  `ChatId` INT NOT NULL,
  `UserId` INT NOT NULL,
  INDEX `ChatId` (`ChatId` ASC) VISIBLE,
  INDEX `UserId` (`UserId` ASC) VISIBLE,
  CONSTRAINT `chat_has_user_ibfk_1`
    FOREIGN KEY (`ChatId`)
    REFERENCES `steam`.`chat` (`idChat`),
  CONSTRAINT `chat_has_user_ibfk_2`
    FOREIGN KEY (`UserId`)
    REFERENCES `steam`.`user` (`idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `steam`.`games`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `steam`.`games` (
  `idGame` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `creator` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY (`idGame`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `steam`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `steam`.`comments` (
  `idComments` INT NOT NULL AUTO_INCREMENT,
  `comment` VARCHAR(45) NOT NULL,
  `idUser` INT NOT NULL,
  `GamesId` INT NOT NULL,
  PRIMARY KEY (`idComments`),
  INDEX `GamesId` (`GamesId` ASC) VISIBLE,
  INDEX `idUser` (`idUser` ASC) VISIBLE,
  CONSTRAINT `comments_ibfk_1`
    FOREIGN KEY (`GamesId`)
    REFERENCES `steam`.`games` (`idGame`),
  CONSTRAINT `comments_ibfk_2`
    FOREIGN KEY (`idUser`)
    REFERENCES `steam`.`user` (`idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `steam`.`forum`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `steam`.`forum` (
  `idForum` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idForum`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `steam`.`forum_has_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `steam`.`forum_has_user` (
  `ForumId` INT NOT NULL,
  `UserId` INT NOT NULL,
  INDEX `ForumId` (`ForumId` ASC) VISIBLE,
  INDEX `UserId` (`UserId` ASC) VISIBLE,
  CONSTRAINT `forum_has_user_ibfk_1`
    FOREIGN KEY (`ForumId`)
    REFERENCES `steam`.`forum` (`idForum`),
  CONSTRAINT `forum_has_user_ibfk_2`
    FOREIGN KEY (`UserId`)
    REFERENCES `steam`.`user` (`idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `steam`.`friends`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `steam`.`friends` (
  `idFriends` INT NOT NULL AUTO_INCREMENT,
  `from_user_id` INT NOT NULL,
  `to_user_id` INT NOT NULL,
  PRIMARY KEY (`idFriends`),
  INDEX `from_user_id` (`from_user_id` ASC) VISIBLE,
  INDEX `to_user_id` (`to_user_id` ASC) VISIBLE,
  CONSTRAINT `friends_ibfk_1`
    FOREIGN KEY (`from_user_id`)
    REFERENCES `steam`.`user` (`idUser`),
  CONSTRAINT `friends_ibfk_2`
    FOREIGN KEY (`to_user_id`)
    REFERENCES `steam`.`user` (`idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `steam`.`profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `steam`.`profile` (
  `idProfile` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `idUser` INT NOT NULL,
  `level` INT NOT NULL,
  PRIMARY KEY (`idProfile`),
  INDEX `idUser` (`idUser` ASC) VISIBLE,
  CONSTRAINT `profile_ibfk_1`
    FOREIGN KEY (`idUser`)
    REFERENCES `steam`.`user` (`idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `steam`.`games_has_profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `steam`.`games_has_profile` (
  `GamesId` INT NOT NULL,
  `ProfileId` INT NOT NULL,
  INDEX `ProfileId` (`ProfileId` ASC) VISIBLE,
  INDEX `GamesId` (`GamesId` ASC) VISIBLE,
  CONSTRAINT `games_has_profile_ibfk_1`
    FOREIGN KEY (`ProfileId`)
    REFERENCES `steam`.`profile` (`idProfile`),
  CONSTRAINT `games_has_profile_ibfk_2`
    FOREIGN KEY (`GamesId`)
    REFERENCES `steam`.`games` (`idGame`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `steam`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `steam`.`item` (
  `idItem` INT NOT NULL AUTO_INCREMENT,
  `idGame` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `FomerOwner` VARCHAR(45) NOT NULL,
  `NewOwner` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idItem`),
  INDEX `idGame` (`idGame` ASC) VISIBLE,
  CONSTRAINT `item_ibfk_1`
    FOREIGN KEY (`idGame`)
    REFERENCES `steam`.`games` (`idGame`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `steam`.`inventar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `steam`.`inventar` (
  `idInventar` INT NOT NULL AUTO_INCREMENT,
  `idGame` INT NOT NULL,
  `idItem` INT NOT NULL,
  `UserId` INT NOT NULL,
  PRIMARY KEY (`idInventar`),
  INDEX `idGame` (`idGame` ASC) VISIBLE,
  INDEX `idItem` (`idItem` ASC) VISIBLE,
  INDEX `UserId` (`UserId` ASC) VISIBLE,
  CONSTRAINT `inventar_ibfk_1`
    FOREIGN KEY (`idGame`)
    REFERENCES `steam`.`games` (`idGame`),
  CONSTRAINT `inventar_ibfk_2`
    FOREIGN KEY (`idItem`)
    REFERENCES `steam`.`item` (`idItem`),
  CONSTRAINT `inventar_ibfk_3`
    FOREIGN KEY (`UserId`)
    REFERENCES `steam`.`user` (`idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
