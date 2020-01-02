CREATE DATABASE  IF NOT EXISTS `employee_registration` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `employee_registration`;
-- MySQL dump 10.13  Distrib 5.7.28, for Linux (x86_64)
--
-- Host: localhost    Database: employee_registration
-- ------------------------------------------------------
-- Server version	5.7.28-0ubuntu0.18.04.4

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `user_details`
--

DROP TABLE IF EXISTS `user_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_details` (
  `userdetailid` int(10) NOT NULL AUTO_INCREMENT,
  `userid` int(10) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `mobileno` varchar(15) NOT NULL,
  `countryid` smallint(4) NOT NULL,
  `stateid` smallint(4) NOT NULL,
  `city` varchar(30) NOT NULL,
  `usertypeid` tinyint(4) NOT NULL,
  `profileimg` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`userdetailid`),
  KEY `fk_user_details_2_idx` (`countryid`),
  KEY `fk_user_details_3_idx` (`stateid`),
  KEY `fk_user_details_4_idx` (`usertypeid`),
  KEY `fk_user_details_1_idx` (`userid`),
  CONSTRAINT `fk_user_details_1` FOREIGN KEY (`userid`) REFERENCES `user_register` (`userid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_details_2` FOREIGN KEY (`countryid`) REFERENCES `master_country` (`countryid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_details_3` FOREIGN KEY (`stateid`) REFERENCES `master_state` (`stateid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_details_4` FOREIGN KEY (`usertypeid`) REFERENCES `master_usertype` (`usertypeid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-02 21:19:31
