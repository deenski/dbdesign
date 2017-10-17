-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema CaptiveCar
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `CaptiveCar` ;

-- -----------------------------------------------------
-- Schema CaptiveCar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CaptiveCar` DEFAULT CHARACTER SET utf8 ;
USE `CaptiveCar` ;

-- -----------------------------------------------------
-- Table `CaptiveCar`.`Vehicles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CaptiveCar`.`Vehicles` ;

CREATE TABLE IF NOT EXISTS `CaptiveCar`.`Vehicles` (
  `v_id` INT NOT NULL AUTO_INCREMENT,
  `v_type` CHAR NOT NULL DEFAULT 'C' COMMENT 'C for car\nT for truck\nV for van',
  `car_name` VARCHAR(45) NOT NULL,
  `deploy_date` DATETIME NOT NULL,
  `mileage` INT NULL,
  PRIMARY KEY (`v_id`),
  UNIQUE INDEX `idCars_UNIQUE` (`v_id` ASC),
  UNIQUE INDEX `car_name_UNIQUE` (`car_name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CaptiveCar`.`Commercial_Accounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CaptiveCar`.`Commercial_Accounts` ;

CREATE TABLE IF NOT EXISTS `CaptiveCar`.`Commercial_Accounts` (
  `business_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `billing_email` VARCHAR(45) NULL,
  `contact_name` VARCHAR(45) NULL,
  `billing_id` INT NULL,
  PRIMARY KEY (`business_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CaptiveCar`.`Passengers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CaptiveCar`.`Passengers` ;

CREATE TABLE IF NOT EXISTS `CaptiveCar`.`Passengers` (
  `passID` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `BDay` DATE NOT NULL,
  `prefered_type` CHAR NOT NULL,
  `social` INT NOT NULL,
  `email` VARCHAR(45) NULL,
  `phone_number` VARCHAR(45) NULL,
  `rider_type` CHAR NULL,
  `commercial_id` INT NOT NULL,
  `rider_insurance_policy` CHAR NOT NULL DEFAULT 'N' COMMENT 'Y for opt into provided rider insurance\nN for opt out of provided rider insurance\n',
  PRIMARY KEY (`passID`),
  INDEX `fk_Passengers_Commercial_Accounts1_idx` (`commercial_id` ASC),
  CONSTRAINT `fk_Passengers_Commercial_Accounts1`
    FOREIGN KEY (`commercial_id`)
    REFERENCES `CaptiveCar`.`Commercial_Accounts` (`business_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CaptiveCar`.`Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CaptiveCar`.`Address` ;

CREATE TABLE IF NOT EXISTS `CaptiveCar`.`Address` (
  `addressID` INT NOT NULL,
  `passID` INT NOT NULL,
  `Street1` VARCHAR(45) NOT NULL,
  `Street2` VARCHAR(45) NULL,
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `Zip` INT NOT NULL,
  `address_type` CHAR NOT NULL COMMENT 'H for home, W for work, S for school, M for mailing, O for other',
  PRIMARY KEY (`addressID`),
  INDEX `fk_Address_Passengers1_idx` (`passID` ASC),
  CONSTRAINT `fk_Address_Passengers1`
    FOREIGN KEY (`passID`)
    REFERENCES `CaptiveCar`.`Passengers` (`passID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CaptiveCar`.`Ride_Request`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CaptiveCar`.`Ride_Request` ;

CREATE TABLE IF NOT EXISTS `CaptiveCar`.`Ride_Request` (
  `request_id` INT NOT NULL,
  `pickup_address_id` INT NULL,
  `dropoff_address_id` INT NULL,
  `request_time` DATETIME NULL,
  PRIMARY KEY (`request_id`),
  INDEX `fk_Ride_Request_Address1_idx` (`pickup_address_id` ASC),
  INDEX `fk_Ride_Request_Address2_idx` (`dropoff_address_id` ASC),
  CONSTRAINT `fk_Ride_Request_Address1`
    FOREIGN KEY (`pickup_address_id`)
    REFERENCES `CaptiveCar`.`Address` (`addressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ride_Request_Address2`
    FOREIGN KEY (`dropoff_address_id`)
    REFERENCES `CaptiveCar`.`Address` (`addressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CaptiveCar`.`Trip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CaptiveCar`.`Trip` ;

CREATE TABLE IF NOT EXISTS `CaptiveCar`.`Trip` (
  `trip_id` INT NOT NULL,
  `request_id` INT NULL,
  `date` DATE NOT NULL,
  `time` TIME NOT NULL COMMENT 'based on point type. if point type is \"P\", the time represents the time the passenger was picked up, and the ride was initiated. If point_type is \"D\", the time represents the time the passenger was dropped off and the ride was ended.',
  `point_type` CHAR NOT NULL COMMENT 'P for pickup D for dropoff\n',
  `address_id` INT NOT NULL,
  `vehicle_id` INT NOT NULL,
  `billable_miles` INT NULL,
  PRIMARY KEY (`trip_id`),
  INDEX `fk_Trips_Vehicles1_idx` (`vehicle_id` ASC),
  INDEX `fk_Trip_Ride_Request1_idx` (`request_id` ASC),
  CONSTRAINT `fk_Trips_Vehicles1`
    FOREIGN KEY (`vehicle_id`)
    REFERENCES `CaptiveCar`.`Vehicles` (`v_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trip_Ride_Request1`
    FOREIGN KEY (`request_id`)
    REFERENCES `CaptiveCar`.`Ride_Request` (`request_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CaptiveCar`.`Invoices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CaptiveCar`.`Invoices` ;

CREATE TABLE IF NOT EXISTS `CaptiveCar`.`Invoices` (
  `invoice_id` INT NOT NULL,
  `due_date` DATE NULL,
  `trip_id` INT NULL,
  PRIMARY KEY (`invoice_id`),
  INDEX `fk_Invoices_Trip1_idx` (`trip_id` ASC),
  CONSTRAINT `fk_Invoices_Trip1`
    FOREIGN KEY (`trip_id`)
    REFERENCES `CaptiveCar`.`Trip` (`trip_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
