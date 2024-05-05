-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema littlelemondb2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemondb2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemondb2` DEFAULT CHARACTER SET utf8 ;
USE `littlelemondb2` ;

-- -----------------------------------------------------
-- Table `littlelemondb2`.`Customer_Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb2`.`Customer_Details` (
  `customer_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `contact_number` INT NULL,
  `email` VARCHAR(255) NULL,
  `Customer_Detailscol` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondb2`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb2`.`Staff` (
  `staff_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `salary` DECIMAL NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondb2`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb2`.`Bookings` (
  `booking_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `table_number` INT NULL,
  `customer_id` INT NOT NULL,
  `Staff_staff_id` INT NOT NULL,
  PRIMARY KEY (`booking_id`),
  INDEX `fk_Bookings_Customer_Details1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_Bookings_Staff1_idx` (`Staff_staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_Bookings_Customer_Details1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `littlelemondb2`.`Customer_Details` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bookings_Staff1`
    FOREIGN KEY (`Staff_staff_id`)
    REFERENCES `littlelemondb2`.`Staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondb2`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb2`.`Orders` (
  `order_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `quantity` INT NOT NULL,
  `total_cost` DECIMAL NOT NULL,
  PRIMARY KEY (`order_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondb2`.`Order_Delivery_Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb2`.`Order_Delivery_Status` (
  `delivery_id` INT NOT NULL,
  `delivery_date` DATE NULL,
  `status` VARCHAR(45) NULL,
  `Orders_order_id` INT NOT NULL,
  PRIMARY KEY (`delivery_id`),
  INDEX `fk_Order_Delivery_Status_Orders_idx` (`Orders_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Delivery_Status_Orders`
    FOREIGN KEY (`Orders_order_id`)
    REFERENCES `littlelemondb2`.`Orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondb2`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb2`.`Menu` (
  `menu_id` INT NOT NULL,
  `starter` VARCHAR(45) NULL,
  `course` VARCHAR(45) NULL,
  `drink` VARCHAR(45) NULL,
  `dessert` VARCHAR(45) NULL,
  `cusine` VARCHAR(45) NULL,
  PRIMARY KEY (`menu_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
