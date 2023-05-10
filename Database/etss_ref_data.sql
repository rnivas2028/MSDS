-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: raags-thinsvr    Database: etss
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ref_data`
--

DROP TABLE IF EXISTS `ref_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_data` (
  `reference_id` int NOT NULL,
  `reference_name` varchar(45) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`reference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_data`
--

LOCK TABLES `ref_data` WRITE;
/*!40000 ALTER TABLE `ref_data` DISABLE KEYS */;
INSERT INTO `ref_data` VALUES (30,'0-3 Year','0-3 Year Volatility Analytics'),(31,'0-6 Year','0-6 Year Volatility Analytics'),(32,'0-9 Year','0-9 Year Volatility Analytics'),(33,'0-12 Year','0-12 Year Volatility Analytics'),(34,'0-15 Year','0-15 Year Volatility Analytics'),(35,'0-18 Year','0-18 Year Volatility Analytics'),(50,'0-5 Year','0-5 Year Volatility Analytics'),(51,'0-10 Year','0-10 Year Volatility Analytics'),(52,'0-15 Year','0-15 Year Volatility Analytics'),(53,'0-20 Year','0-20 Year Volatility Analytics'),(300,'0-3 Year','0-3 Year Volatility Analytics'),(301,'3-6 Year','3-6 Year Volatility Analytics'),(302,'6-9 Year','6-9 Year Volatility Analytics'),(303,'9-12 Year','9-12 Year Volatility Analytics'),(304,'12-15 Year','12-15 Year Volatility Analytics'),(305,'15-18 Year','15-18 Year Volatility Analytics'),(500,'0-5 Year','0-5 Year Volatility Analytics'),(501,'5-10  Year','5-10  Year Volatility Analytics'),(502,'10-15 Year','10-15 Year Volatility Analytics'),(503,'15-20 Year','15-20 Year Volatility Analytics');
/*!40000 ALTER TABLE `ref_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-09 20:49:19
