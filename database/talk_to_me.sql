-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: talk_to_me
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB\
--
-- Database create
--
DROP DATABASE IF EXISTS talk_to_me;

CREATE DATABASE talk_to_me;

USE talk_to_me;

--
-- Table structur
--
--
-- Table structure for table `users`
--
DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin', 'user') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`, `email`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `users`
--
INSERT INTO
  `users`
VALUES
  (
    1,
    'Zhukha',
    'mzhukha@gmail.com',
    '$2y$10$lTSdhl0/.XSCalttUFYujOnYachXpkMQym7d2OL2P7smSVAOnzOve',
    'admin',
    '2025-11-23 02:47:18'
  ),
  (
    2,
    'Al Ikhlas',
    'muhammadzhukhaalikhlas@gmail.com',
    '$2y$10$NEXsltjB.euefgzE.Si2d.UcSzQhyFextPIJenE6AeknOyXjSdw4q',
    'user',
    '2025-11-23 02:54:19'
  ),
  (
    3,
    'Raisa Puja Alifya',
    'raisapuja6@gmail.com',
    '$2y$10$v.OpUBA82mHSwKjwgVWmreEv6RUqpeLoh9X0rhpUP8xz/SGZm/3WS',
    'user',
    '2025-11-23 03:03:04'
  );

--
-- Table structure for table `follows`
--
DROP TABLE IF EXISTS `follows`;

CREATE TABLE `follows` (
  `followed_id` int(11) NOT NULL,
  `follower_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`followed_id`, `follower_id`),
  KEY `follower_id` (`follower_id`),
  CONSTRAINT `follows_ibfk_1` FOREIGN KEY (`followed_id`) REFERENCES `users` (`id`),
  CONSTRAINT `follows_ibfk_2` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `follows`
--


--
-- Table structure for table `post`
--
DROP TABLE IF EXISTS `post`;

CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `type_content` enum('text', 'photo') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `post`
--
INSERT
  IGNORE INTO `post`
VALUES
  (
    1,
    3,
    'Capek banget jadi cantik !!',
    'text',
    '2025-11-23 03:07:04'
  );


--
-- Table structure for table `comment`
--
DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_post` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `comment_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_post` (`id_post`),
  KEY `parent_id` (`parent_id`),
  KEY `comment_by` (`comment_by`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`id_post`) REFERENCES `post` (`id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `comment` (`id`),
  CONSTRAINT `comment_ibfk_3` FOREIGN KEY (`comment_by`) REFERENCES `users` (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `comment`
--
INSERT
  IGNORE INTO `comment`
VALUES
  (
    2,
    1,
    NULL,
    'Macam betull ajaa, wkwk',
    '2025-11-23 03:41:32',
    2
  );

--
-- Table structure for table `like`
--
DROP TABLE IF EXISTS `like`;

CREATE TABLE `like` (
  `like_by` int(11) NOT NULL,
  `id_post` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`like_by`, `id_post`),
  KEY `id_post` (`id_post`),
  CONSTRAINT `like_ibfk_1` FOREIGN KEY (`id_post`) REFERENCES `post` (`id`),
  CONSTRAINT `like_ibfk_2` FOREIGN KEY (`like_by`) REFERENCES `users` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

--
-- Dumping data for table `like`
--
INSERT
  IGNORE INTO `like`
VALUES
  (2, 1, '2025-11-23 03:21:31');



-- Dump completed on 2025-11-23 11:42:36