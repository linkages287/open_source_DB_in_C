-- MySQL dump 10.13  Distrib 5.5.31, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: opensourcepj
-- ------------------------------------------------------
-- Server version	5.5.31-0ubuntu0.13.04.1

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
-- Table structure for table `competenze`
--

DROP TABLE IF EXISTS `competenze`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `competenze` (
  `id_comp` int(3) NOT NULL AUTO_INCREMENT,
  `nome_c` char(20) NOT NULL,
  `data_ins` date NOT NULL,
  PRIMARY KEY (`id_comp`),
  UNIQUE KEY `nome_c` (`nome_c`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competenze`
--

LOCK TABLES `competenze` WRITE;
/*!40000 ALTER TABLE `competenze` DISABLE KEYS */;
INSERT INTO `competenze` VALUES (1,'programmatore C','2013-05-01'),(2,'web designer','2013-04-20'),(3,'project manager','2013-03-07'),(4,'traduttore','2013-05-22'),(5,'programmatore PHP','2013-06-01'),(6,'sviluppatore Verilog','2013-05-21'),(7,'disegnatore','2013-03-20'),(8,'esperto filtri suono','2013-03-20'),(9,'sviluppatore DB','2013-05-20'),(10,'programmatore Java','2013-05-01'),(11,'sistemista','2013-06-02'),(12,'esperto linux kernel','2013-06-05'),(13,'programmatore C++','2013-05-01'),(14,'sviluppatore Qt','2013-04-23'),(15,'interface developer','2013-04-25'),(16,'programmatore fortra','2013-05-20'),(17,'esperto CAD','2013-04-28');
/*!40000 ALTER TABLE `competenze` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `composizione_pj`
--

DROP TABLE IF EXISTS `composizione_pj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `composizione_pj` (
  `id_composizione_pj` int(3) NOT NULL AUTO_INCREMENT,
  `id_progetto` int(3) NOT NULL,
  `id_sotto_pj` int(3) NOT NULL,
  PRIMARY KEY (`id_composizione_pj`),
  KEY `composizione_pj_ibfk_1` (`id_progetto`),
  KEY `composizione_pj_ibfk_2` (`id_sotto_pj`),
  CONSTRAINT `composizione_pj_ibfk_1` FOREIGN KEY (`id_progetto`) REFERENCES `progetto` (`id_project`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `composizione_pj_ibfk_2` FOREIGN KEY (`id_sotto_pj`) REFERENCES `sotto_progetto` (`id_sotto_progetto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `composizione_pj`
--

LOCK TABLES `composizione_pj` WRITE;
/*!40000 ALTER TABLE `composizione_pj` DISABLE KEYS */;
INSERT INTO `composizione_pj` VALUES (1,1,1),(2,1,2),(3,2,3),(4,2,5),(5,2,6),(6,3,4),(7,3,7);
/*!40000 ALTER TABLE `composizione_pj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contatti`
--

DROP TABLE IF EXISTS `contatti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contatti` (
  `id_contatto` int(3) NOT NULL AUTO_INCREMENT,
  `id_utente` int(3) NOT NULL,
  `id_utente_contatto` int(3) NOT NULL,
  PRIMARY KEY (`id_contatto`),
  KEY `contatti_ibfk_1` (`id_utente`),
  KEY `contatti_ibfk_2` (`id_utente_contatto`),
  CONSTRAINT `contatti_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utente_registrato` (`id_utente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contatti_ibfk_2` FOREIGN KEY (`id_utente_contatto`) REFERENCES `utente_registrato` (`id_utente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contatti`
--

LOCK TABLES `contatti` WRITE;
/*!40000 ALTER TABLE `contatti` DISABLE KEYS */;
INSERT INTO `contatti` VALUES (26,1,5),(27,1,14),(28,1,8),(29,2,15),(30,2,13),(31,3,7),(32,3,8),(33,4,2),(34,5,2),(35,5,8),(36,6,11),(37,7,11),(38,8,4),(39,8,5),(40,9,10),(41,10,9),(42,10,11),(43,11,9),(44,12,2),(45,12,1),(46,13,2),(47,14,1),(48,14,9),(49,14,13),(50,1,10);
/*!40000 ALTER TABLE `contatti` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER controllo_contatti BEFORE INSERT ON contatti FOR EACH ROW  
BEGIN  
    DECLARE dummy INT;  
    IF  NEW.id_utente_contatto = NEW.id_utente THEN  
      SELECT 'il contatto non è inseribile per questo utente' 
      INTO dummy FROM information_schema.tables;
    END IF;  
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER controllo_contatti_bu BEFORE UPDATE ON contatti FOR EACH ROW  
BEGIN  
    DECLARE dummy INT;  
    IF  NEW.id_utente_contatto = NEW.id_utente THEN 
     SELECT 'il contatto non è inseribile per questo utente' 
      INTO dummy FROM information_schema.tables;
    END IF;  
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `incaricato`
--

DROP TABLE IF EXISTS `incaricato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incaricato` (
  `id_utente_incaricato` int(3) NOT NULL AUTO_INCREMENT,
  `id_utente` int(3) NOT NULL,
  `id_incarico` int(3) NOT NULL,
  PRIMARY KEY (`id_utente_incaricato`),
  KEY `incaricato_ibfk_1` (`id_utente`),
  KEY `incaricato_ibfk_2` (`id_incarico`),
  CONSTRAINT `incaricato_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utente_registrato` (`id_utente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `incaricato_ibfk_2` FOREIGN KEY (`id_incarico`) REFERENCES `incarico` (`id_incarico`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incaricato`
--

LOCK TABLES `incaricato` WRITE;
/*!40000 ALTER TABLE `incaricato` DISABLE KEYS */;
INSERT INTO `incaricato` VALUES (1,1,3),(2,3,2),(3,3,1),(4,4,3),(5,2,4),(6,5,4),(7,6,1),(8,7,4),(9,8,1),(10,8,2),(11,9,3),(12,9,2),(13,10,3),(14,11,4),(15,12,1),(16,13,3),(17,14,3),(18,15,3),(19,7,1),(30,13,1);
/*!40000 ALTER TABLE `incaricato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incarico`
--

DROP TABLE IF EXISTS `incarico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incarico` (
  `id_incarico` int(3) NOT NULL AUTO_INCREMENT,
  `nome_incarico` enum('Project_Manager','Team_Manager','Team_Element','Normal_User') NOT NULL,
  `tipo_accesso` enum('r','w','rw') DEFAULT NULL,
  PRIMARY KEY (`id_incarico`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incarico`
--

LOCK TABLES `incarico` WRITE;
/*!40000 ALTER TABLE `incarico` DISABLE KEYS */;
INSERT INTO `incarico` VALUES (1,'Project_Manager','rw'),(2,'Team_Manager','rw'),(3,'Team_Element','r'),(4,'Normal_User','');
/*!40000 ALTER TABLE `incarico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incarico_di_progetto`
--

DROP TABLE IF EXISTS `incarico_di_progetto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incarico_di_progetto` (
  `id_proj_management` int(3) NOT NULL AUTO_INCREMENT,
  `id_incaricato` int(3) NOT NULL,
  `id_pj` int(3) NOT NULL,
  PRIMARY KEY (`id_proj_management`),
  KEY `incarico_di_progetto_ibfk_2` (`id_pj`),
  KEY `incarico_di_progetto_ibfk_1` (`id_incaricato`),
  CONSTRAINT `incarico_di_progetto_ibfk_1` FOREIGN KEY (`id_incaricato`) REFERENCES `incaricato` (`id_utente_incaricato`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `incarico_di_progetto_ibfk_2` FOREIGN KEY (`id_pj`) REFERENCES `progetto` (`id_project`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incarico_di_progetto`
--

LOCK TABLES `incarico_di_progetto` WRITE;
/*!40000 ALTER TABLE `incarico_di_progetto` DISABLE KEYS */;
INSERT INTO `incarico_di_progetto` VALUES (1,3,1),(2,3,2),(3,9,3),(4,15,1),(5,15,2),(6,7,2),(7,19,3),(17,30,17);
/*!40000 ALTER TABLE `incarico_di_progetto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incarico_di_sotto_progetto`
--

DROP TABLE IF EXISTS `incarico_di_sotto_progetto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incarico_di_sotto_progetto` (
  `id_gruppo_di_lavoro` int(3) NOT NULL AUTO_INCREMENT,
  `id_utente_incaricato` int(3) NOT NULL,
  `id_sotto_progetto` int(3) NOT NULL,
  PRIMARY KEY (`id_gruppo_di_lavoro`),
  KEY `incarico_di_sotto_progetto_ibfk_2` (`id_sotto_progetto`),
  KEY `incarico_di_sotto_progetto_ibfk_1` (`id_utente_incaricato`),
  CONSTRAINT `incarico_di_sotto_progetto_ibfk_1` FOREIGN KEY (`id_utente_incaricato`) REFERENCES `incaricato` (`id_utente_incaricato`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `incarico_di_sotto_progetto_ibfk_2` FOREIGN KEY (`id_sotto_progetto`) REFERENCES `sotto_progetto` (`id_sotto_progetto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incarico_di_sotto_progetto`
--

LOCK TABLES `incarico_di_sotto_progetto` WRITE;
/*!40000 ALTER TABLE `incarico_di_sotto_progetto` DISABLE KEYS */;
INSERT INTO `incarico_di_sotto_progetto` VALUES (1,1,2),(2,11,2),(3,13,1),(4,1,5),(5,1,3),(6,13,5),(7,17,5),(8,13,4),(9,18,7),(10,2,1),(11,2,2),(12,2,3),(13,10,4),(14,10,7),(15,12,5),(16,12,6);
/*!40000 ALTER TABLE `incarico_di_sotto_progetto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lettura_post`
--

DROP TABLE IF EXISTS `lettura_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lettura_post` (
  `id_lettura` int(3) NOT NULL AUTO_INCREMENT,
  `data_lettura` date NOT NULL,
  `id_post_letto` int(3) NOT NULL,
  `id_lettore_reg` int(3) DEFAULT NULL,
  `id_lettore_nr` int(3) DEFAULT NULL,
  PRIMARY KEY (`id_lettura`),
  KEY `lettura_post_ibfk_3` (`id_lettore_reg`),
  KEY `lettura_post_ibfk_1` (`id_post_letto`),
  CONSTRAINT `lettura_post_ibfk_1` FOREIGN KEY (`id_post_letto`) REFERENCES `post` (`id_post`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lettura_post_ibfk_3` FOREIGN KEY (`id_lettore_reg`) REFERENCES `utente_registrato` (`id_utente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lettura_post`
--

LOCK TABLES `lettura_post` WRITE;
/*!40000 ALTER TABLE `lettura_post` DISABLE KEYS */;
INSERT INTO `lettura_post` VALUES (1,'2013-05-05',2,13,NULL),(2,'2013-06-10',2,NULL,2);
/*!40000 ALTER TABLE `lettura_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lettura_post_utente_nr`
--

DROP TABLE IF EXISTS `lettura_post_utente_nr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lettura_post_utente_nr` (
  `id_lettura` int(3) NOT NULL AUTO_INCREMENT,
  `data_lettura` date NOT NULL,
  `id_post_letto` int(3) NOT NULL,
  `id_lettore` int(3) NOT NULL,
  PRIMARY KEY (`id_lettura`),
  KEY `id_post_letto` (`id_post_letto`),
  KEY `id_lettore` (`id_lettore`),
  CONSTRAINT `lettura_post_utente_nr_ibfk_1` FOREIGN KEY (`id_post_letto`) REFERENCES `post` (`id_post`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lettura_post_utente_nr_ibfk_2` FOREIGN KEY (`id_lettore`) REFERENCES `utente_non_registrato` (`id_utente_nr`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lettura_post_utente_nr`
--

LOCK TABLES `lettura_post_utente_nr` WRITE;
/*!40000 ALTER TABLE `lettura_post_utente_nr` DISABLE KEYS */;
INSERT INTO `lettura_post_utente_nr` VALUES (1,'2013-06-20',1,2),(2,'2013-06-20',2,2),(3,'2013-06-10',4,4),(4,'2013-06-10',2,4);
/*!40000 ALTER TABLE `lettura_post_utente_nr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messaggi`
--

DROP TABLE IF EXISTS `messaggi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messaggi` (
  `id_messaggio` int(3) NOT NULL AUTO_INCREMENT,
  `titolo_messaggio` varchar(255) DEFAULT NULL,
  `corpo_messaggio` text,
  PRIMARY KEY (`id_messaggio`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messaggi`
--

LOCK TABLES `messaggi` WRITE;
/*!40000 ALTER TABLE `messaggi` DISABLE KEYS */;
INSERT INTO `messaggi` VALUES (1,'ciao!','ho bisogno di aiuto per sviluppare il progetto, potresti aiutarmi?'),(2,'RE:ciao!','certo posso aiutarti, dimmi che cosa ti serve'),(3,'saluti','ben arrivato sul nostro sito'),(4,'miglioramenti','ho trovato alcuni miglioramenti effettuabili al progetto'),(5,'RE: miglioramenti','sono felice di sentirli');
/*!40000 ALTER TABLE `messaggi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messaggi_inv_ric`
--

DROP TABLE IF EXISTS `messaggi_inv_ric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messaggi_inv_ric` (
  `id_invio` int(3) NOT NULL AUTO_INCREMENT,
  `id_messaggio` int(3) NOT NULL,
  `id_utente_inv` int(3) DEFAULT NULL,
  `id_utente_ric` int(3) DEFAULT NULL,
  `data_invio` date NOT NULL,
  PRIMARY KEY (`id_invio`),
  KEY `messaggi_inv_ric_ibfk_1` (`id_messaggio`),
  KEY `messaggi_inv_ric_ibfk_2` (`id_utente_inv`),
  KEY `messaggi_inv_ric_ibfk_3` (`id_utente_ric`),
  CONSTRAINT `messaggi_inv_ric_ibfk_1` FOREIGN KEY (`id_messaggio`) REFERENCES `messaggi` (`id_messaggio`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `messaggi_inv_ric_ibfk_2` FOREIGN KEY (`id_utente_inv`) REFERENCES `utente_registrato` (`id_utente`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `messaggi_inv_ric_ibfk_3` FOREIGN KEY (`id_utente_ric`) REFERENCES `utente_registrato` (`id_utente`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messaggi_inv_ric`
--

LOCK TABLES `messaggi_inv_ric` WRITE;
/*!40000 ALTER TABLE `messaggi_inv_ric` DISABLE KEYS */;
INSERT INTO `messaggi_inv_ric` VALUES (1,1,2,6,'2013-05-07'),(2,2,6,2,'2013-05-07'),(3,3,8,9,'2013-05-08'),(4,4,15,8,'2013-05-20'),(5,5,8,15,'2013-05-21');
/*!40000 ALTER TABLE `messaggi_inv_ric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `possesso_c`
--

DROP TABLE IF EXISTS `possesso_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `possesso_c` (
  `id_possesso` int(3) NOT NULL AUTO_INCREMENT,
  `id_utente` int(3) NOT NULL,
  `id_competenza` int(3) NOT NULL,
  PRIMARY KEY (`id_possesso`),
  KEY `possesso_c_ibfk_2` (`id_competenza`),
  KEY `possesso_c_ibfk_1` (`id_utente`),
  CONSTRAINT `possesso_c_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utente_registrato` (`id_utente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `possesso_c_ibfk_2` FOREIGN KEY (`id_competenza`) REFERENCES `competenze` (`id_comp`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `possesso_c`
--

LOCK TABLES `possesso_c` WRITE;
/*!40000 ALTER TABLE `possesso_c` DISABLE KEYS */;
INSERT INTO `possesso_c` VALUES (1,1,1),(2,1,6),(3,2,9),(4,3,11),(5,4,2),(6,8,3),(7,9,1),(8,9,5),(9,10,10),(10,10,5),(11,12,3),(12,13,2),(13,14,4),(14,15,8),(15,10,13),(17,1,15);
/*!40000 ALTER TABLE `possesso_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id_post` int(3) NOT NULL AUTO_INCREMENT,
  `testo_post` text NOT NULL,
  `titolo_post` varchar(45) NOT NULL,
  PRIMARY KEY (`id_post`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,'ho difficoltà nel creare un modulo di gestione dell\'interfaccia grafica','problema di programmazione'),(2,'le difficoltà possono essere risolte con una condivisione delle informazioni','RE:problema di programmazione'),(3,'post di presentazione del progetto.','presentazione'),(4,'qualcuno ha le credenziali di accesso al DB?','cerco credenziali');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `progetto`
--

DROP TABLE IF EXISTS `progetto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `progetto` (
  `id_project` int(3) NOT NULL AUTO_INCREMENT,
  `dir_lavoro_radice` varchar(30) NOT NULL,
  `nome_progetto` varchar(30) NOT NULL,
  `id_ideatore` int(3) DEFAULT NULL,
  `specifiche_tecniche` text NOT NULL,
  `data_creazione` date NOT NULL,
  PRIMARY KEY (`id_project`),
  KEY `progetto_ibfk_1` (`id_ideatore`),
  CONSTRAINT `progetto_ibfk_1` FOREIGN KEY (`id_ideatore`) REFERENCES `utente_registrato` (`id_utente`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `progetto`
--

LOCK TABLES `progetto` WRITE;
/*!40000 ALTER TABLE `progetto` DISABLE KEYS */;
INSERT INTO `progetto` VALUES (1,'/dirproject1/','disegna',3,'programma per disegnare','2013-02-06'),(2,'/dirproject2/','scrivi',6,'programma di videoscrittura','2013-02-20'),(3,'/dirproject3/','suona',7,'programma di editing per fare musica','2013-01-30'),(17,'/home/progetti/web consultant','web consultant',13,'sito web coacing','2013-05-31');
/*!40000 ALTER TABLE `progetto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `risposta_post`
--

DROP TABLE IF EXISTS `risposta_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `risposta_post` (
  `id_risposta` int(3) NOT NULL AUTO_INCREMENT,
  `data_risposta` date NOT NULL,
  `id_post_origine` int(3) NOT NULL,
  `id_post_risposta` int(3) NOT NULL,
  `id_utente_risposta` int(3) NOT NULL,
  PRIMARY KEY (`id_risposta`),
  KEY `id_post_origine` (`id_post_origine`),
  KEY `id_post_risposta` (`id_post_risposta`),
  KEY `id_utente_risposta` (`id_utente_risposta`),
  CONSTRAINT `risposta_post_ibfk_1` FOREIGN KEY (`id_post_origine`) REFERENCES `post` (`id_post`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `risposta_post_ibfk_2` FOREIGN KEY (`id_post_risposta`) REFERENCES `post` (`id_post`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `risposta_post_ibfk_3` FOREIGN KEY (`id_utente_risposta`) REFERENCES `utente_registrato` (`id_utente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `risposta_post`
--

LOCK TABLES `risposta_post` WRITE;
/*!40000 ALTER TABLE `risposta_post` DISABLE KEYS */;
INSERT INTO `risposta_post` VALUES (1,'2013-05-05',1,2,13);
/*!40000 ALTER TABLE `risposta_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scrittura_post`
--

DROP TABLE IF EXISTS `scrittura_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scrittura_post` (
  `id_scrittura` int(3) NOT NULL AUTO_INCREMENT,
  `data_scrittura` date NOT NULL,
  `id_post_scritto` int(3) NOT NULL,
  `id_utente_scrittore` int(3) DEFAULT NULL,
  PRIMARY KEY (`id_scrittura`),
  KEY `scrittura_post_ibfk_1` (`id_post_scritto`),
  KEY `scrittura_post_ibfk_2` (`id_utente_scrittore`),
  CONSTRAINT `scrittura_post_ibfk_1` FOREIGN KEY (`id_post_scritto`) REFERENCES `post` (`id_post`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `scrittura_post_ibfk_2` FOREIGN KEY (`id_utente_scrittore`) REFERENCES `utente_registrato` (`id_utente`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scrittura_post`
--

LOCK TABLES `scrittura_post` WRITE;
/*!40000 ALTER TABLE `scrittura_post` DISABLE KEYS */;
INSERT INTO `scrittura_post` VALUES (1,'2013-05-06',1,4),(2,'2013-05-07',3,10),(3,'2013-05-07',4,4);
/*!40000 ALTER TABLE `scrittura_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sotto_progetto`
--

DROP TABLE IF EXISTS `sotto_progetto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sotto_progetto` (
  `id_sotto_progetto` int(3) NOT NULL AUTO_INCREMENT,
  `dir_lavoro_spj` varchar(40) NOT NULL,
  `data_ultima_modifica` date NOT NULL,
  `stato_avanzamento_spj` int(3) NOT NULL,
  `specifiche_spj` text NOT NULL,
  PRIMARY KEY (`id_sotto_progetto`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sotto_progetto`
--

LOCK TABLES `sotto_progetto` WRITE;
/*!40000 ALTER TABLE `sotto_progetto` DISABLE KEYS */;
INSERT INTO `sotto_progetto` VALUES (1,'/dirproject1/dir1','2013-05-05',15,'interfaccia grafica di disegno'),(2,'/dirproject1/dir2','2013-04-30',5,'sviluppo main program di disegno'),(3,'/dir/project2/dir1','2013-04-27',10,'interfaccia grafica di videoscrittura'),(4,'/dirproject3/dir1','2013-03-20',30,'sviluppo main program di editing sonoro '),(5,'/dirproject2/dir2','2013-05-01',20,'sviluppo main program di gestione videoscrittura'),(6,'/dirproject2/dir3','2013-05-03',45,'sviluppo thread controllo ortografico e dizionari'),(7,'/dirproject3/dir2','2013-03-25',0,'sviluppo filtri sonori');
/*!40000 ALTER TABLE `sotto_progetto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uso_competenza`
--

DROP TABLE IF EXISTS `uso_competenza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uso_competenza` (
  `id_uso_c` int(3) NOT NULL AUTO_INCREMENT,
  `id_comp` int(3) NOT NULL,
  `id_sotto_pj` int(3) NOT NULL,
  PRIMARY KEY (`id_uso_c`),
  KEY `uso_competenza_ibfk_1` (`id_comp`),
  KEY `uso_competenza_ibfk_2` (`id_sotto_pj`),
  CONSTRAINT `uso_competenza_ibfk_1` FOREIGN KEY (`id_comp`) REFERENCES `competenze` (`id_comp`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uso_competenza_ibfk_2` FOREIGN KEY (`id_sotto_pj`) REFERENCES `sotto_progetto` (`id_sotto_progetto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uso_competenza`
--

LOCK TABLES `uso_competenza` WRITE;
/*!40000 ALTER TABLE `uso_competenza` DISABLE KEYS */;
INSERT INTO `uso_competenza` VALUES (1,1,1),(2,7,1),(3,10,1),(4,1,2),(5,13,2),(6,15,3),(7,14,3),(8,13,4),(9,13,4),(10,8,4),(11,1,5),(12,10,5),(13,13,6),(14,4,6),(15,13,7),(16,8,7),(17,17,2),(18,16,2);
/*!40000 ALTER TABLE `uso_competenza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utente_non_registrato`
--

DROP TABLE IF EXISTS `utente_non_registrato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utente_non_registrato` (
  `id_utente_nr` int(3) NOT NULL AUTO_INCREMENT,
  `nome_utente` char(20) NOT NULL,
  PRIMARY KEY (`id_utente_nr`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utente_non_registrato`
--

LOCK TABLES `utente_non_registrato` WRITE;
/*!40000 ALTER TABLE `utente_non_registrato` DISABLE KEYS */;
INSERT INTO `utente_non_registrato` VALUES (1,'asdf'),(2,'zxcv'),(3,'lkjh'),(4,'bhun'),(5,'bhnj'),(6,'lkmi'),(7,'aqws'),(8,'poiu');
/*!40000 ALTER TABLE `utente_non_registrato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utente_registrato`
--

DROP TABLE IF EXISTS `utente_registrato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utente_registrato` (
  `id_utente` int(3) NOT NULL AUTO_INCREMENT,
  `nome_utente` char(20) NOT NULL,
  `password` char(20) NOT NULL,
  `nome` char(20) NOT NULL,
  `cognome` char(20) NOT NULL,
  `sesso` enum('F','M') NOT NULL,
  `data_di_nascita` date DEFAULT NULL,
  `professione` char(20) DEFAULT NULL,
  `cittadinanza` char(20) DEFAULT NULL,
  `lingua` char(20) NOT NULL,
  PRIMARY KEY (`id_utente`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utente_registrato`
--

LOCK TABLES `utente_registrato` WRITE;
/*!40000 ALTER TABLE `utente_registrato` DISABLE KEYS */;
INSERT INTO `utente_registrato` VALUES (1,'utente1','pass1','mario','rossi','M','1991-01-12','studente','italiana','italiana'),(2,'utente2','pass2','luca','bianchi','M','1985-02-10','studente','italiana','italiana'),(3,'utente3','pass3','stefano','verdi','M','1982-07-25','ricercatore','italiana','italiana'),(4,'utente4','pass4','eleonora','gianfranchi','F','1989-01-24','designer','italiana','italiana'),(5,'utente5','pass5','frank','smith','M','1990-10-10','studente','inglese','inglese'),(6,'utente6','pass6','sarah','green','F','1991-12-24','studente','inglese','inglese'),(7,'utente7','pass7','alberto','alberti','M','1995-05-03','studente','italiano','italiano'),(8,'utente8','pass8','marie','martin','F','1993-07-10','project manager','francese','francese'),(9,'utente9','pass9','michel','bernard','M','1993-01-10','programmatore','francese','francese'),(10,'utente10','pass10','sebastien','dubois','M','1993-12-12','programmatore','francese','francese'),(11,'utente11','pass11','fredrich','muller','M','1994-04-05','studente','tedesco','tedesco'),(12,'utente12','pass12','hans','neumann','M','1976-01-30','project manager','tedesco','tedesco'),(13,'utente13','pass13','himisci','minamoto','M','1989-07-10','web designer','giapponese','giapponese'),(14,'utente14','pass14','elena','teodori','F','1988-05-25','traduttrice','italiana','italiana'),(15,'utente15','pass15','peter','kock','M','1994-04-27','studente','tedesco','tedesco'),(17,'utente16','pass16','piergiorgio','casalegno','M','1997-01-13','studente','italiana','italiano'),(18,'user18','pass18','Tom','Robin','M','1991-12-21','studente','francese','francese'),(19,'user19','pass19','tiziano','slavi','M','1990-11-11','programmatore','italiana','italiano');
/*!40000 ALTER TABLE `utente_registrato` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-06-23 21:53:11
