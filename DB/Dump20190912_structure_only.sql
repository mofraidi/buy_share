CREATE DATABASE  IF NOT EXISTS `achatdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `achatdb`;
-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: achatdb
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `adhesions`
--

DROP TABLE IF EXISTS `adhesions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `adhesions` (
  `id_user` bigint(20) unsigned NOT NULL,
  `id_groupe` bigint(20) unsigned NOT NULL,
  `approuvee` bit(1) NOT NULL,
  `date_heure_adh` datetime DEFAULT NULL,
  `date_debut_utilisation` datetime DEFAULT NULL,
  `date_heure_reservation` datetime DEFAULT NULL,
  `nbr_heures_penalisation` smallint(5) unsigned DEFAULT NULL,
  `nbr_heures_utilisation` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_user`,`id_groupe`),
  KEY `fk_users_joint_groupes_users1_idx` (`id_user`),
  KEY `fk_users_joint_groupes_groupes1_idx` (`id_groupe`),
  CONSTRAINT `fk_users_joint_groupes_groupes1` FOREIGN KEY (`id_groupe`) REFERENCES `groupes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_users_joint_groupes_users1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alertes`
--

DROP TABLE IF EXISTS `alertes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `alertes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_heure_envoi` datetime NOT NULL,
  `contenu` text NOT NULL,
  `lu` bit(1) NOT NULL,
  `type` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alertes_users`
--

DROP TABLE IF EXISTS `alertes_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `alertes_users` (
  `id_alerte` bigint(20) unsigned NOT NULL,
  `id_user` bigint(20) unsigned NOT NULL,
  KEY `fk_alertes_users_alertes1_idx` (`id_alerte`),
  KEY `fk_alertes_users_users1_idx` (`id_user`),
  CONSTRAINT `fk_alertes_users_alertes1` FOREIGN KEY (`id_alerte`) REFERENCES `alertes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_alertes_users_users1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `annonces`
--

DROP TABLE IF EXISTS `annonces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `annonces` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `titre` varchar(45) NOT NULL,
  `description` text NOT NULL,
  `date_heure_pub` datetime NOT NULL,
  `nbr_min_membres` tinyint(3) unsigned NOT NULL,
  `nbr_max_membres` tinyint(4) NOT NULL,
  `id_article` bigint(20) unsigned NOT NULL,
  `id_user_publicateur` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Annonces_articles1_idx` (`id_article`),
  KEY `fk_Annonces_users1_idx` (`id_user_publicateur`),
  CONSTRAINT `fk_Annonces_articles1` FOREIGN KEY (`id_article`) REFERENCES `articles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Annonces_users1` FOREIGN KEY (`id_user_publicateur`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `articles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `prix` double NOT NULL,
  `delai_utilisation` mediumint(8) unsigned NOT NULL,
  `id_categorie` bigint(20) unsigned DEFAULT NULL,
  `delai_min_utilisation` smallint(5) unsigned NOT NULL,
  `delai_transition` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_articles_categories1_idx` (`id_categorie`),
  CONSTRAINT `fk_articles_categories1` FOREIGN KEY (`id_categorie`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blocages`
--

DROP TABLE IF EXISTS `blocages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `blocages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `bloque` bit(1) NOT NULL,
  `date_heure_debut` datetime DEFAULT NULL,
  `duree` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nom_UNIQUE` (`nom`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commentaires`
--

DROP TABLE IF EXISTS `commentaires`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `commentaires` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `contenu` tinytext NOT NULL,
  `date_heure_publi` datetime NOT NULL,
  `id_user_publicateur` bigint(20) unsigned NOT NULL,
  `id_user_concerne` bigint(20) unsigned NOT NULL,
  `id_article` bigint(20) unsigned NOT NULL,
  `id_user_signale` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_commentaires_users1_idx` (`id_user_publicateur`),
  KEY `fk_commentaires_users2_idx` (`id_user_concerne`),
  KEY `fk_commentaires_articles1_idx` (`id_article`),
  CONSTRAINT `fk_commentaires_articles1` FOREIGN KEY (`id_article`) REFERENCES `articles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_commentaires_users1` FOREIGN KEY (`id_user_publicateur`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_commentaires_users2` FOREIGN KEY (`id_user_concerne`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `configurations`
--

DROP TABLE IF EXISTS `configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `configurations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cle` varchar(45) NOT NULL,
  `valeur` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groupes`
--

DROP TABLE IF EXISTS `groupes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `groupes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `etat` bit(1) NOT NULL,
  `id_article` bigint(20) unsigned NOT NULL,
  `id_user_createur` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_groupes_articles1_idx` (`id_article`),
  KEY `fk_groupes_users1_idx` (`id_user_createur`),
  CONSTRAINT `fk_groupes_articles1` FOREIGN KEY (`id_article`) REFERENCES `articles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_groupes_users1` FOREIGN KEY (`id_user_createur`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `journal`
--

DROP TABLE IF EXISTS `journal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `journal` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_heure` datetime NOT NULL,
  `activite` text NOT NULL,
  `id_activite_journal` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_jornal_activites_idx` (`id_activite_journal`),
  CONSTRAINT `fk_jornal_activites` FOREIGN KEY (`id_activite_journal`) REFERENCES `types_activ_journal` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `localites`
--

DROP TABLE IF EXISTS `localites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `localites` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code_postal` varchar(10) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `longitude` double NOT NULL,
  `latitude` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2761 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date_heure_publi` datetime NOT NULL,
  `contenu` text NOT NULL,
  `lu` bit(1) NOT NULL,
  `id_user_src` bigint(20) unsigned NOT NULL,
  `id_groupe` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_messages_groupes1_idx` (`id_groupe`),
  KEY `fk_messages_users1_idx` (`id_user_src`),
  CONSTRAINT `fk_messages_groupes1` FOREIGN KEY (`id_groupe`) REFERENCES `groupes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_messages_users1` FOREIGN KEY (`id_user_src`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages_users`
--

DROP TABLE IF EXISTS `messages_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `messages_users` (
  `id_message` bigint(20) unsigned NOT NULL,
  `id_user_dest` bigint(20) unsigned NOT NULL,
  KEY `fk_messages_users_users1_idx` (`id_user_dest`),
  KEY `fk_messages_users_messages1_idx` (`id_message`),
  CONSTRAINT `fk_messages_users_messages1` FOREIGN KEY (`id_message`) REFERENCES `messages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_messages_users_users1` FOREIGN KEY (`id_user_dest`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `parametres`
--

DROP TABLE IF EXISTS `parametres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `parametres` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cle` varchar(100) NOT NULL,
  `valeur` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cle_UNIQUE` (`cle`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ressources`
--

DROP TABLE IF EXISTS `ressources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ressources` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lien` text NOT NULL,
  `id_article` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ressources_articles1_idx` (`id_article`),
  CONSTRAINT `fk_ressources_articles1` FOREIGN KEY (`id_article`) REFERENCES `articles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nom_UNIQUE` (`nom`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `types_activ_journal`
--

DROP TABLE IF EXISTS `types_activ_journal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `types_activ_journal` (
  `id` bigint(20) unsigned NOT NULL,
  `nom` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) NOT NULL,
  `mot_de_passe` varchar(245) NOT NULL,
  `email` varchar(45) NOT NULL,
  `confirmation` bit(1) NOT NULL,
  `date_heure_inscription` datetime NOT NULL,
  `date_derniere_connexion` date DEFAULT NULL,
  `code_confirmation` varchar(45) DEFAULT NULL,
  `id_role` bigint(20) unsigned NOT NULL,
  `id_localite` bigint(20) unsigned NOT NULL,
  `id_blocage` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userName_UNIQUE` (`user_name`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `fk_users_roles1_idx` (`id_role`),
  KEY `fk_users_localites1_idx` (`id_localite`),
  KEY `fk_users_blocages1_idx` (`id_blocage`),
  CONSTRAINT `fk_users_blocages1` FOREIGN KEY (`id_blocage`) REFERENCES `blocages` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_users_localites1` FOREIGN KEY (`id_localite`) REFERENCES `localites` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_users_roles1` FOREIGN KEY (`id_role`) REFERENCES `roles` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_signale_comments`
--

DROP TABLE IF EXISTS `users_signale_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users_signale_comments` (
  `id_user` bigint(20) unsigned NOT NULL,
  `id_comment` bigint(20) unsigned NOT NULL,
  KEY `fk_users_signale_comments_users1_idx` (`id_user`),
  KEY `fk_users_signale_comments_commentaires1_idx` (`id_comment`),
  CONSTRAINT `fk_users_signale_comments_commentaires1` FOREIGN KEY (`id_comment`) REFERENCES `commentaires` (`id`),
  CONSTRAINT `fk_users_signale_comments_users1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-12 14:23:27
