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
-- Dumping routines for database 'employee_registration'
--
/*!50003 DROP PROCEDURE IF EXISTS `demo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `demo`(in country varchar(255))
BEGIN
   DECLARE front TEXT DEFAULT NULL;
   DECLARE frontlen INT DEFAULT NULL;
   DECLARE TempValue TEXT DEFAULT NULL;
	iterator:
	LOOP  
		IF LENGTH(TRIM(country)) = 0 OR country IS NULL THEN
			LEAVE iterator;
		END IF;
        SET front = SUBSTRING_INDEX(country,',',1);
        SET frontlen = LENGTH(front);
		SET TempValue = TRIM(front);
		INSERT INTO `master_country` (`countryname`) VALUES	(TempValue);
        SET country = INSERT(country,1,frontlen + 1,'');
    end loop;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `demo1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `demo1`(in lang json ,out object varchar(225) )
BEGIN
	DECLARE langCount INT DEFAULT 0;
    DECLARE noofyear varchar(255) DEFAULT null;
    DECLARE company varchar(255) DEFAULT null;
    DECLARE des varchar(255) DEFAULT null;
    lang:
    loop
     if JSON_LENGTH(lang) <= langCount  then 
		LEAVE lang;
     end if;
      select JSON_EXTRACT(lang, concat("$[",langCount,"].0")) into noofyear;
      select JSON_EXTRACT(lang, concat("$[",langCount,"].1")) into company;
      select JSON_EXTRACT(lang, concat("$[",langCount,"].2")) into des;
      
      INSERT INTO `employee_registration`.`user_experiences`
		(`userid`,`noofyears`,`company_name`,`jobdescription`,`createdon`)
		VALUES(64,noofyear,company,des,'2019-12-24 12:55:09');
		
	SET langCount=langCount+1;
    set object=company;
    end loop;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertEmployee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEmployee`(
IN email VARCHAR(255),
IN pwd VARCHAR(255),
IN createdon datetime,
IN updatedon datetime,
IN fname VARCHAR(255),
IN lname VARCHAR(255),
IN contact varchar(14),
IN country int(4),
IN state int(4),
IN city VARCHAR(255),
IN userType int(4),	
OUT massege varchar(256))
BEGIN
	DECLARE countEmployee INT DEFAULT 0;
	INSERT INTO `employee_registration`.`user_register`
	(`emailid`,`password`,`createdon`,`updatedon`)
	VALUES
	(email,pwd,createdon,updatedon);
    
    select max(userid) into countEmployee from `employee_registration`.`user_register`;
    
    INSERT INTO `employee_registration`.`user_details`
	(`userid`,`firstname`,`lastname`,`mobileno`,`countryid`,`stateid`,`city`,`usertypeid`,`profileimg`)
	VALUES
	(countEmployee,fname,lname,contact,country,state,city,userType," ");
    
    set massege=countEmployee;
    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertEmployeeDemo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertEmployeeDemo`(
IN email VARCHAR(255),
IN pwd VARCHAR(255),
IN createdon datetime,
IN updatedon datetime,
IN fname VARCHAR(255),
IN lname VARCHAR(255),
IN contact varchar(14),
IN country int(4),
IN state int(4),
IN city VARCHAR(255),
IN userType int(4),	
in lang json,
OUT massege varchar(256))
BEGIN
	DECLARE countEmployee INT DEFAULT 0;
    DECLARE langCount INT DEFAULT 0;
    DECLARE langName INT DEFAULT 0;
    
	INSERT INTO `employee_registration`.`user_register`(`emailid`,`password`,`createdon`,`updatedon`)
	VALUES(email,pwd,createdon,updatedon);
    
    select max(userid) into countEmployee from `employee_registration`.`user_register`;
    
    INSERT INTO `employee_registration`.`user_details`(`userid`,`firstname`,`lastname`,`mobileno`,`countryid`,`stateid`,`city`,`usertypeid`,`profileimg`)
	VALUES (countEmployee,fname,lname,contact,country,state,city,userType," ");
    
    set massege=countEmployee;
    
    lang:
    loop
		if JSON_LENGTH(lang) <= langCount  then 
			LEAVE lang;
		end if;
		select JSON_EXTRACT(lang, concat("$[",langCount,"]")) into langName;
        
		INSERT INTO `employee_registration`.`user_language`(`userid`,`languageid`,`createdon`)
        VALUES(countEmployee ,langName ,createdon);
		SET langCount=langCount+1;
    end loop;
    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateEmployee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployee`(
in id int,
IN email VARCHAR(255),
IN pwd VARCHAR(255),
IN updatedon datetime,
IN fname VARCHAR(255),
IN lname VARCHAR(255),
IN contact varchar(14),
IN country int(4),
IN state int(4),
IN city VARCHAR(255),
IN userType int(4))
BEGIN
    UPDATE `employee_registration`.`user_register`
	SET
	`emailid` = email,
	`password` = pwd,
	`updatedon` = updatedon
	WHERE `userid` = id;
    
    UPDATE `employee_registration`.`user_details`
	SET
	`firstname` = fname,
	`lastname` =lname,
	`mobileno` = contact,
	`countryid` = country,
	`stateid` = state,
	`city` =	city,
	`usertypeid` = userType
	WHERE `userid` = id;

    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-02 21:19:32
