-- loadflights-normalized.sql
DROP DATABASE IF EXISTS flights;
CREATE DATABASE `flights`
USE flights;

DROP TABLE IF EXISTS airlines_status;
DROP TABLE IF EXISTS airlines;
DROP TABLE IF EXISTS cities;
DROP TABLE IF EXISTS status;

CREATE TABLE `airlines` (
  `id_airlines` int NOT NULL,
  `code_airlines` varchar(45) NOT NULL,
  `name_airlines` varchar(30) NOT NULL,
  PRIMARY KEY (`id_airlines`)
);

LOAD DATA INFILE 'airlines.csv' 
INTO TABLE airlines 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


CREATE TABLE `cities` (
  `id_city` int NOT NULL,
  `code_city` varchar(45) NOT NULL,
  `name_city` varchar(45) NOT NULL,
  PRIMARY KEY (`id_city`)
);

LOAD DATA INFILE 'cities.csv' 
INTO TABLE cities 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE `status` (
  `id_status` int NOT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id_status`)
) ;

LOAD DATA INFILE 'status.csv' 
INTO TABLE status 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE `airlines_status` (
  `id` int NOT NULL,
  `id_airlines` int NOT NULL,
  `id_city` int NOT NULL,
  `id_status` int NOT NULL,
  `count_status` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ID_AIRLINES_idx` (`id_airlines`),
  KEY `FK_ID_CITY_idx` (`id_city`),
  KEY `FK_ID_STATUS_idx` (`id_status`),
  CONSTRAINT `FK_ID_AIRLINES` FOREIGN KEY (`id_airlines`) REFERENCES `airlines` (`id_airlines`),
  CONSTRAINT `FK_ID_CITY` FOREIGN KEY (`id_city`) REFERENCES `cities` (`id_city`),
  CONSTRAINT `FK_ID_STATUS` FOREIGN KEY (`id_status`) REFERENCES `status` (`id_status`)
);

LOAD DATA INFILE 'airlines_status.csv' 
INTO TABLE airlines_status 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


