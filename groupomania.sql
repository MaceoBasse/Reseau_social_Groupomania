-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 24 nov. 2021 à 14:38
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `groupomania`
--

-- --------------------------------------------------------

--
-- Structure de la table `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `publication_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` text COLLATE latin1_general_ci NOT NULL,
  `user_id` smallint(5) UNSIGNED DEFAULT NULL,
  `post_id` mediumint(8) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Comments_Users_id` (`user_id`),
  KEY `fk_Comments_Posts_id` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `likes`
--

DROP TABLE IF EXISTS `likes`;
CREATE TABLE IF NOT EXISTS `likes` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `rate` tinyint(4) NOT NULL,
  `user_id` smallint(5) UNSIGNED NOT NULL,
  `post_id` mediumint(8) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Likes_Users_id` (`user_id`),
  KEY `fk_Likes_Posts_id` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` smallint(5) UNSIGNED NOT NULL,
  `initiator_id` smallint(5) UNSIGNED DEFAULT NULL,
  `post_id` mediumint(8) UNSIGNED NOT NULL,
  `type_id` tinyint(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Notifications_Users_id` (`user_id`),
  KEY `fk_Notifications_Initiator_id` (`initiator_id`),
  KEY `fk_Notifications_Posts_id` (`post_id`),
  KEY `fk_Notifications_Notifications_types_id` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `notification_types`
--

DROP TABLE IF EXISTS `notification_types`;
CREATE TABLE IF NOT EXISTS `notification_types` (
  `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(10) COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Déchargement des données de la table `notification_types`
--

INSERT INTO `notification_types` (`id`, `name`) VALUES
(1, 'reaction'),
(2, 'comment'),
(3, 'answer');

-- --------------------------------------------------------

--
-- Structure de la table `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `publication_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` smallint(5) UNSIGNED DEFAULT NULL,
  `imageurl` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  `content` text COLLATE latin1_general_ci,
  PRIMARY KEY (`id`),
  KEY `fk_Posts_Users_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `email` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `password` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `pictureurl` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  `outline` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  `isadmin` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ind_uni_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `pictureurl`, `outline`, `isadmin`) VALUES
(21, 'admin', 'admin@groupomania.com', 'U2FsdGVkX1+Piw929q2ncX3O0XSY5RuO5Ex3GV56t1z3Bw/5CEYdJM86/Y/kLipjBvLBnlJrY/iZTTIokOIgjIzoL5yCJgfeOTapc4+Xi5c=', NULL, NULL, 1);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_Comments_Posts_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Comments_Users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Contraintes pour la table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `fk_Likes_Posts_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Likes_Users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_Notifications_Initiator_id` FOREIGN KEY (`initiator_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Notifications_Notifications_types_id` FOREIGN KEY (`type_id`) REFERENCES `notification_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Notifications_Posts_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Notifications_Users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `fk_Posts_Users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
