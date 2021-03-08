-- loadflights-denormalized.sql
DROP DATABASE IF EXISTS flights;
CREATE DATABASE `flights`
USE flights;

DROP TABLE IF EXISTS airlines_status_cities;
CREATE TABLE `airlines_status_cities` (
  `airlines` varchar(25) NOT NULL,
  `status` varchar(45) NOT NULL,
  `los_angeles` int NOT NULL,
  `phoenix` int NOT NULL,
  `san_diego` int NOT NULL,
  `san_francisco` int NOT NULL,
  `seattle` int NOT NULL
);

LOAD DATA INFILE 'airlines_status_cities.csv' 
INTO TABLE airlines_status_cities 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
