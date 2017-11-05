-- MySQL Workbench Synchronization
-- Generated: 2017-11-05 10:00
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: MASARU NAKAMURA

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `tmsdb` DEFAULT CHARACTER SET utf8mb4 ;

CREATE TABLE IF NOT EXISTS `tmsdb`.`t_user` (
  `user_id` INT(11) NOT NULL COMMENT 'ユーザーID',
  `first_name` VARCHAR(45) NULL DEFAULT NULL COMMENT '姓',
  `last_name` VARCHAR(45) NULL DEFAULT NULL COMMENT '名',
  `employee_number` VARCHAR(100) NOT NULL COMMENT '社員番号',
  PRIMARY KEY (`user_id`, `employee_number`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = 'ユーザー';

CREATE TABLE IF NOT EXISTS `tmsdb`.`t_report` (
  `report_id` VARCHAR(12) NOT NULL COMMENT 'レポートID',
  `user_id` INT(11) NOT NULL COMMENT 'ユーザーID',
  `year` INT(11) NOT NULL COMMENT '年',
  `month` INT(11) NOT NULL COMMENT '月',
  `this_month_goal` TEXT(2000) NULL DEFAULT NULL COMMENT '当月目標',
  `result` TEXT(2000) NULL DEFAULT NULL COMMENT '当月実績',
  `impression` TEXT(2000) NULL DEFAULT NULL COMMENT '感想',
  `next_month_goal` TEXT(2000) NULL DEFAULT NULL COMMENT '来月目標',
  `is_submitted` BIT(1) NULL DEFAULT NULL COMMENT '提出したか',
  `is_report_approval` BIT(1) NULL DEFAULT NULL COMMENT '提出承認されたか',
  PRIMARY KEY (`report_id`, `user_id`, `year`, `month`),
  INDEX `user_id_idx` (`user_id` ASC),
  CONSTRAINT `t_report_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tmsdb`.`t_user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = 'レポート';

CREATE TABLE IF NOT EXISTS `tmsdb`.`t_trainer` (
  `report_id` VARCHAR(12) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `priority` INT(11) NULL DEFAULT NULL,
  `comment` TEXT(2000) NULL DEFAULT NULL,
  PRIMARY KEY (`report_id`, `user_id`),
  INDEX `user_id_idx` (`user_id` ASC),
  CONSTRAINT `t_trainer_report_id`
    FOREIGN KEY (`report_id`)
    REFERENCES `tmsdb`.`t_report` (`report_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `t_traner_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tmsdb`.`t_user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = 'トレーナー';

CREATE TABLE IF NOT EXISTS `tmsdb`.`l_report_and_rader_element` (
  `report_id` VARCHAR(12) NOT NULL COMMENT 'レポートID',
  `rader_element_id` INT(11) NOT NULL COMMENT 'レーダー要素ID',
  PRIMARY KEY (`rader_element_id`, `report_id`),
  INDEX `report_id_idx` (`report_id` ASC),
  CONSTRAINT `l_report_and_rader_element_report_id`
    FOREIGN KEY (`report_id`)
    REFERENCES `tmsdb`.`t_report` (`report_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `l_report_and_rader_element_rader_element_id`
    FOREIGN KEY (`rader_element_id`)
    REFERENCES `tmsdb`.`t_rader_element` (`rader_element_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = 'レポート/レーダー要素紐付け';

CREATE TABLE IF NOT EXISTS `tmsdb`.`t_rader_element` (
  `rader_element_id` INT(11) NOT NULL COMMENT 'レーダー要素ID',
  `rader_master_id` INT(11) NOT NULL COMMENT 'レーダーマスタID',
  `evaluation` INT(11) NOT NULL DEFAULT 0 COMMENT '評価値',
  PRIMARY KEY (`rader_element_id`, `rader_master_id`),
  INDEX `rader_master_id_idx` (`rader_master_id` ASC),
  CONSTRAINT `t_rader_element_rader_master_id`
    FOREIGN KEY (`rader_master_id`)
    REFERENCES `tmsdb`.`m_rader_master` (`rader_master_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = 'レーダー要素';

CREATE TABLE IF NOT EXISTS `tmsdb`.`m_rader_master` (
  `rader_master_id` INT(11) NOT NULL COMMENT 'レーダーマスタID',
  `available_start` DATETIME NOT NULL COMMENT '有効期限開始',
  `available_end` DATETIME NOT NULL COMMENT '有効期限終了',
  `name` VARCHAR(45) NULL DEFAULT NULL COMMENT 'レーダ名',
  PRIMARY KEY (`rader_master_id`, `available_start`, `available_end`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = 'レーダーマスタ';

CREATE TABLE IF NOT EXISTS `tmsdb`.`l_user_and_role` (
  `user_id` INT(11) NOT NULL COMMENT 'ユーザーID',
  `role_master_id` INT(11) NOT NULL COMMENT '権限マスタID',
  PRIMARY KEY (`user_id`, `role_master_id`),
  INDEX `role_master_id_idx` (`role_master_id` ASC),
  CONSTRAINT `l_user_and_role_role_master_id`
    FOREIGN KEY (`role_master_id`)
    REFERENCES `tmsdb`.`m_role_master` (`role_master_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tmsdb`.`t_user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = 'ユーザー/権限紐付け';

CREATE TABLE IF NOT EXISTS `tmsdb`.`m_role_master` (
  `role_master_id` INT(11) NOT NULL COMMENT '権限マスタID',
  `name` VARCHAR(30) NOT NULL COMMENT '権限名',
  `avaliable_start` DATETIME NOT NULL,
  `avaliable_end` DATETIME NOT NULL,
  PRIMARY KEY (`role_master_id`, `avaliable_end`, `avaliable_start`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '権限マスタ';

CREATE TABLE IF NOT EXISTS `tmsdb`.`t_entry_filed_extend_` (
  `report_id` VARCHAR(12) NOT NULL,
  `filed_name` VARCHAR(45) NULL DEFAULT NULL COMMENT '記入欄名',
  `content` TEXT(2000) NULL DEFAULT NULL COMMENT '記述内容',
  `arrangement_id` INT(11) NOT NULL COMMENT '配置場所ID',
  PRIMARY KEY (`report_id`),
  CONSTRAINT `t_entry_filed_extend__report_id`
    FOREIGN KEY (`report_id`)
    REFERENCES `tmsdb`.`t_report` (`report_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '記入欄拡張';

CREATE TABLE IF NOT EXISTS `tmsdb`.`t_boss` (
  `report_id` VARCHAR(12) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `priory` INT(11) NOT NULL,
  `comment` TEXT(2000) NULL DEFAULT NULL,
  PRIMARY KEY (`report_id`, `user_id`, `priory`),
  INDEX `user_id_idx` (`user_id` ASC),
  CONSTRAINT `t_boss_report_id`
    FOREIGN KEY (`report_id`)
    REFERENCES `tmsdb`.`t_report` (`report_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `t_boss_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tmsdb`.`t_user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `tmsdb`.`t_self_check_element` (
  `report_id` VARCHAR(12) NOT NULL COMMENT 'セルフチェック要素ID',
  `user_id` INT(11) NOT NULL COMMENT 'セルフチェックユーザ（自身/トレーナー）',
  `self_check_master_id` INT(11) NOT NULL COMMENT 'セルフチェックマスタID',
  `is_yes` BIT(1) NOT NULL COMMENT 'セルフチェック（はい/いいえ）',
  PRIMARY KEY (`report_id`, `user_id`, `self_check_master_id`),
  INDEX `self_check_master_id_idx` (`self_check_master_id` ASC),
  INDEX `user_id_idx` (`user_id` ASC),
  CONSTRAINT `t_self_check_element_self_check_master_id`
    FOREIGN KEY (`self_check_master_id`)
    REFERENCES `tmsdb`.`m_self_check_master` (`self_check_master_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `t_self_check_element_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tmsdb`.`t_user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `t_self_check_element_report_id`
    FOREIGN KEY (`report_id`)
    REFERENCES `tmsdb`.`t_report` (`report_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = 'セルフチェック要素\n';

CREATE TABLE IF NOT EXISTS `tmsdb`.`m_self_check_master` (
  `self_check_master_id` INT(11) NOT NULL COMMENT 'セルフチェックマスタID',
  `available_start` DATETIME NOT NULL COMMENT '有効期限開始',
  `available_end` DATETIME NOT NULL COMMENT '有効期限終了',
  `self_check_contents` VARCHAR(255) NULL DEFAULT NULL COMMENT 'セルフチェック内容',
  PRIMARY KEY (`self_check_master_id`, `available_start`, `available_end`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = 'セルフチェックマスタ\n';

CREATE TABLE IF NOT EXISTS `tmsdb`.`t_report_timestamp` (
  `report_id` VARCHAR(12) NOT NULL COMMENT 'レポートID',
  `submit_number` INT(11) NOT NULL COMMENT '提出回数',
  `submit_time` DATETIME NULL DEFAULT NULL COMMENT '提出時間',
  `return_user_id` INT(11) NULL DEFAULT NULL COMMENT '返却者',
  `return_comment` TEXT(2000) NULL DEFAULT NULL COMMENT '返却コメント',
  `return_time` DATETIME NULL DEFAULT NULL COMMENT '返却時間',
  `is_returned` BIT(1) NULL DEFAULT NULL COMMENT '返却されたか',
  PRIMARY KEY (`report_id`, `submit_number`),
  INDEX `return_user_id_idx` (`return_user_id` ASC),
  CONSTRAINT `t_report_timestamp_report_id`
    FOREIGN KEY (`report_id`)
    REFERENCES `tmsdb`.`t_report` (`report_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `t_report_timestamp_return_user_id`
    FOREIGN KEY (`return_user_id`)
    REFERENCES `tmsdb`.`t_user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = 'レポートタイムスタンプ';

CREATE TABLE IF NOT EXISTS `tmsdb`.`t_sign_element` (
  `report_id` VARCHAR(12) NOT NULL COMMENT 'レオポートID',
  `sign_mastr_id` INT(11) NOT NULL COMMENT 'サインマスタID',
  `sign_user_id` INT(11) NOT NULL COMMENT 'サイン\n者名',
  `sign_time` DATETIME NULL DEFAULT NULL COMMENT 'サイン時間',
  `is_signed` BIT(1) NULL DEFAULT NULL COMMENT 'サイン済みフラグ',
  PRIMARY KEY (`report_id`, `sign_mastr_id`, `sign_user_id`),
  INDEX `sign_master_id_idx` (`sign_mastr_id` ASC),
  INDEX `sign_user_id_idx` (`sign_user_id` ASC),
  CONSTRAINT `t_sign_element_sign_master_id`
    FOREIGN KEY (`sign_mastr_id`)
    REFERENCES `tmsdb`.`m_sign_master` (`sign_master_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `t_sign_element_sign_user_id`
    FOREIGN KEY (`sign_user_id`)
    REFERENCES `tmsdb`.`t_user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `t_sign_element_report_id`
    FOREIGN KEY (`report_id`)
    REFERENCES `tmsdb`.`t_report` (`report_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '署名要素\n';

CREATE TABLE IF NOT EXISTS `tmsdb`.`m_sign_master` (
  `sign_master_id` INT(11) NOT NULL COMMENT 'サインマスタID',
  `available_start` DATETIME NOT NULL COMMENT '有効期限開始',
  `available_end` DATETIME NOT NULL COMMENT '有効期限終了',
  `sign_filed_name` VARCHAR(45) NULL DEFAULT NULL COMMENT 'サイン欄名（部長/課長/トレーナー/事業部長…etc）',
  PRIMARY KEY (`sign_master_id`, `available_start`, `available_end`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COMMENT = '署名マスタ';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
