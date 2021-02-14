/*
Summary: Data 607, Assignment 2 - Movie Ratings
Database Schema : movie_ratings
Tables: 
	users
    movies
    ratings
    preference
    user_movie_rating
    user_preference
Created By: Ramnivas Singh
Created On: 02/14/2021
Database: MySQL 8.0
File : movie_ratings.sql
*/
DROP DATABASE IF EXISTS movie_ratings;
CREATE DATABASE `movie_ratings`
USE movie_ratings;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS preference;
DROP TABLE IF EXISTS user_movie_rating;
DROP TABLE IF EXISTS user_preference;

CREATE TABLE `users` (
  `userId` int NOT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `addedOn` datetime DEFAULT NULL,
  `addedBy` varchar(100) DEFAULT NULL,
  `updatedOn` datetime DEFAULT NULL,
  `updatedBy` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`userId`)
);

CREATE TABLE `movies` (
  `movieId` int NOT NULL,
  `movie_name` varchar(100) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `addedOn` datetime DEFAULT NULL,
  `addedBy` varchar(100) DEFAULT NULL,
  `updatedOn` datetime DEFAULT NULL,
  `updatedBy` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`movieId`)
);

CREATE TABLE `ratings` (
  `rating` int NOT NULL,
  `rating_desc` varchar(100) DEFAULT NULL,
  `addedOn` datetime DEFAULT NULL,
  `addedBy` varchar(100) DEFAULT NULL,
  `updatedOn` datetime DEFAULT NULL,
  `updatedBy` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`rating`)
 );


CREATE TABLE `preference` (
  `preferenceId` int NOT NULL,
  `preference` varchar(100) DEFAULT NULL,
  `addedOn` datetime DEFAULT NULL,
  `addedBy` varchar(100) DEFAULT NULL,
  `updatedOn` datetime DEFAULT NULL,
  `updatedBy` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`preferenceId`)
);

 
CREATE TABLE `user_movie_rating` (
  `userId` int NOT NULL,
  `movieId` int NOT NULL,
  `rating` int DEFAULT NULL,
  `addedOn` datetime DEFAULT NULL,
  `addedBy` varchar(100) DEFAULT NULL,
  `updatedOn` datetime DEFAULT NULL,
  `updatedBy` varchar(100) DEFAULT NULL,
  KEY `userId_idx` (`userId`),
  KEY `movieId_idx` (`movieId`),
  KEY `rating_idx` (`rating`),
  CONSTRAINT `movieId` FOREIGN KEY (`movieId`) REFERENCES `movies` (`movieId`),
  CONSTRAINT `rating` FOREIGN KEY (`rating`) REFERENCES `ratings` (`rating`),
  CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`)
);

CREATE TABLE `user_preference` (
  `userId` int NOT NULL,
  `preferenceId` int NOT NULL,
  `addedOn` datetime DEFAULT NULL,
  `addedBy` varchar(100) DEFAULT NULL,
  `updatedOn` datetime DEFAULT NULL,
  `updatedBy` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`userId`),
  KEY `preferenceId_idx` (`preferenceId`),
  CONSTRAINT `preferenceId` FOREIGN KEY (`preferenceId`) REFERENCES `preference` (`preferenceId`),
  CONSTRAINT `userIdx` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\users.csv' 
INTO TABLE users 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\movies.csv' 
INTO TABLE movies 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\ratings.csv' 
INTO TABLE ratings 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\preference.csv' 
INTO TABLE preference 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\user_movie_rating.csv' 
INTO TABLE user_movie_rating 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\user_preference.csv' 
INTO TABLE user_preference 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;