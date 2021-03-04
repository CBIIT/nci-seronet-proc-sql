-- SeroNet - Phase II Prod
-- Wed March 3 2021

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema
-- -----------------------------------------------------
DROP TABLE IF EXISTS `table_message_sender`;
drop table if exists `table_file_validator`;
drop table if exists `table_submission_validator`;
DROP TABLE IF EXISTS `table_file_remover`;


-- -----------------------------------------------------
-- Table `table_message_sender`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `table_message_sender` (
  `message_id` INT NOT NULL AUTO_INCREMENT,
  `message_sender_orig_file_id` INT NULL,
  `message_sender_cbc_id` VARCHAR(45) NULL,
  `message_sender_recepient` VARCHAR(255) NULL,
  `message_sender_sentdate` DATETIME NULL,
  `message_sender_sender_email` VARCHAR(45) NULL,
  `message_sender_sent_status` VARCHAR(45) NULL,
  PRIMARY KEY (`message_id`),
  UNIQUE INDEX `message_id_UNIQUE` (`message_id` ASC) VISIBLE,
  INDEX `fk_orig_job_id_idx` (`message_sender_orig_file_id` ASC) VISIBLE,
  CONSTRAINT `fk_orig_job_id`
    FOREIGN KEY (`message_sender_orig_file_id`)
    REFERENCES `table_file_remover` (`file_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `table_file_validator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `table_file_validator` (
  `unzipped_file_id` INT NOT NULL AUTO_INCREMENT,
  `submission_file_id` INT NOT NULL,
  `file_validation_file_location` VARCHAR(255) NULL,				
  `file_validation_date` DATETIME NULL,
  `file_validation_status` VARCHAR(45) NULL DEFAULT 'NOT_PROCESSED',
  PRIMARY KEY (`unzipped_file_id`),
  FOREIGN KEY (`submission_file_id`)
    REFERENCES `table_submission_validator` (`submission_file_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `table_submission_validator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `table_submission_validator` (
  `submission_file_id` INT NOT NULL AUTO_INCREMENT,
  `orig_file_id` INT NULL,
  `submission_validation_file_location` VARCHAR(255) NOT NULL,
  `submission_validation_result_location` VARCHAR(255) NOT NULL,
  `submission_validation_notification_arn` VARCHAR(255) NULL,
  `submission_validation_date` DATETIME NULL,
  `batch_validation_status` VARCHAR(45) NULL,
  `submission_validation_type` VARCHAR(45) NULL DEFAULT 'CREATE',
  `submission_validation_updated_by` VARCHAR(45) NULL DEFAULT 'SELECT USER()',
  INDEX `fk_file_id_idx` (`orig_file_id` ASC) VISIBLE,
  PRIMARY KEY (`submission_file_id`),
  CONSTRAINT `fk_file_id`
    FOREIGN KEY (`orig_file_id`)
    REFERENCES `table_file_remover` (`file_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `table_file_remover`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `table_file_remover` (
  `file_id` INT NOT NULL AUTO_INCREMENT,
  `file_name` VARCHAR(255) NOT NULL,
  `file_location` VARCHAR(255) NOT NULL,
  `file_added_on` DATETIME NOT NULL,
  `file_last_processed_on` DATETIME NULL,
  `file_status` VARCHAR(45) NOT NULL DEFAULT 'IN_PROCESS',
  `file_origin` VARCHAR(45) NOT NULL DEFAULT 'cbcXX',
  `file_type` VARCHAR(45) NOT NULL,
  `file_action` VARCHAR(45) NULL,
  `file_submitted_by` VARCHAR(45) NULL,
  `updated_by` VARCHAR(255) NULL DEFAULT 'SELECT USER()',
  `file_md5` VARCHAR(255) NULL,
  PRIMARY KEY (`file_id`),
  UNIQUE INDEX `file_id_UNIQUE` (`file_id` ASC) VISIBLE,
  UNIQUE INDEX `file_location_UNIQUE` (`file_location` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;