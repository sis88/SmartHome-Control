-- MySQL dump 10.16  Distrib 10.1.16-MariaDB, for Win32 (AMD64)
--
-- Host: localhost    Database: smarthome
-- ------------------------------------------------------
-- Server version	10.1.16-MariaDB

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
-- Table structure for table `devicestate`
--

DROP TABLE IF EXISTS `devicestate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devicestate` (
  `devId` int(10) NOT NULL,
  `devName` varchar(200) DEFAULT NULL,
  `devLocation` varchar(200) DEFAULT NULL,
  `devState` int(1) DEFAULT NULL,
  `userType` varchar(200) DEFAULT NULL,
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devicestate`
--

LOCK TABLES `devicestate` WRITE;
/*!40000 ALTER TABLE `devicestate` DISABLE KEYS */;
INSERT INTO `devicestate` VALUES (19,'Kettle','Kitchen',0,'Father',1),(39,'Lamp','LivingROOM',0,'Father',2),(458,'Light','BedROOM',0,'Father',3),(463,'Light','Kitchen',1,'Father',4),(506,'Light','LivingROOM',0,'Father',5),(463,'Light','Kitchen',1,'Son',6),(463,'Light','Kitchen',0,'Son',7),(463,'Light','Kitchen',1,'Father',8),(463,'Light','Kitchen',0,'Son',9),(463,'Light','Kitchen',0,'Son',10),(463,'Light','Kitchen',1,'Father',11),(463,'Light','Kitchen',0,'Father',12),(463,'Light','Kitchen',1,'Father',13),(463,'Light','Kitchen',0,'Son',14),(463,'Light','Kitchen',1,'Father',15),(463,'Light','Kitchen',0,'Son',16),(463,'Light','Kitchen',1,'Son',17),(19,'Kettle','Kitchen',0,'Father',18),(463,'Light','Kitchen',0,'Son',19),(463,'Light','Kitchen',1,'Son',20),(19,'Kettle','Kitchen',1,'Father',21),(463,'Light','Kitchen',0,'Father',22),(19,'Kettle','Kitchen',0,'Father',23),(463,'Light','Kitchen',1,'Father',24),(460,'Light','Corridor',1,'Father',25),(463,'Light','Kitchen',0,'Father',26),(463,'Light','Kitchen',1,'Father',27),(19,'Kettle','Kitchen',0,'Father',28),(463,'Light','Kitchen',0,'Father',29),(460,'Light','Corridor',0,'Father',30),(460,'Light','Corridor',1,'Father',31),(508,'Light','BedROOM',0,'Father',32),(508,'Light','BedROOM',1,'Father',33),(507,'Light','LivingROOM',1,'Father',34),(507,'Light','LivingROOM',0,'Father',35),(463,'Light','Kitchen',1,'Father',36),(463,'Light','Kitchen',1,'Father',37),(463,'Light','Kitchen',1,'Father',38),(463,'Light','Kitchen',1,'Father',39),(460,'Light','Corridor',0,'Father',40),(460,'Light','Corridor',0,'Father',41),(507,'Light','LivingROOM',1,'Father',42),(507,'Light','LivingROOM',0,'Father',43),(463,'Light','Kitchen',0,'Father',44),(508,'Light','BedROOM',0,'Father',45),(508,'Light','BedROOM',1,'Father',46),(463,'Light','Kitchen',1,'Father',47),(507,'Light','LivingROOM',0,'Father',48),(507,'Light','LivingROOM',1,'Father',49),(508,'Light','BedROOM',0,'Father',50),(508,'Light','BedROOM',1,'Father',51),(508,'Light','BedROOM',0,'Father',52),(507,'Light','LivingROOM',0,'Father',53),(463,'Light','Kitchen',0,'Father',54),(463,'Light','Kitchen',1,'Father',55),(19,'Kettle','Kitchen',1,'Father',56),(19,'Kettle','Kitchen',0,'Father',57),(19,'Kettle','Kitchen',1,'Father',58),(19,'Kettle','Kitchen',0,'Father',59),(19,'Kettle','Kitchen',1,'Father',60),(19,'Kettle','Kitchen',0,'Father',61),(19,'Kettle','Kitchen',1,'Father',62),(19,'Kettle','Kitchen',0,'Father',63),(19,'Kettle','Kitchen',1,'Father',64),(19,'Kettle','Kitchen',0,'Father',65),(19,'Kettle','Kitchen',1,'Father',66),(19,'Kettle','Kitchen',0,'Father',67),(19,'Kettle','Kitchen',1,'Father',68),(21,'Radio','Kitchen',1,'Father',69),(21,'Radio','Kitchen',0,'Father',70),(21,'Radio','Kitchen',1,'Father',71),(21,'Radio','Kitchen',0,'Father',72),(21,'Radio','Kitchen',1,'Father',73),(21,'Radio','Kitchen',0,'Father',74),(19,'Kettle','Kitchen',1,'Father',75),(19,'Kettle','Kitchen',1,'Father',76),(19,'Kettle','Kitchen',0,'Father',77),(21,'Radio','Kitchen',1,'Father',78),(21,'Radio','Kitchen',0,'Father',79),(21,'Radio','Kitchen',1,'Father',80),(21,'Radio','Kitchen',0,'Father',81),(19,'Kettle','Kitchen',1,'Father',82),(19,'Kettle','Kitchen',0,'Father',83),(19,'Kettle','Kitchen',1,'Father',84),(19,'Kettle','Kitchen',0,'Father',85),(508,'Light','BedROOM',1,'Father',86),(508,'Light','BedROOM',1,'Father',87),(508,'Light','BedROOM',0,'Father',88),(508,'Light','BedROOM',1,'Father',89),(508,'Light','BedROOM',0,'Father',90),(508,'Light','BedROOM',1,'Father',91),(508,'Light','BedROOM',0,'Father',92),(508,'Light','BedROOM',1,'Father',93),(460,'Light','Corridor',1,'Father',94),(460,'Light','Corridor',1,'Father',95),(460,'Light','Corridor',0,'Father',96),(460,'Light','Corridor',1,'Father',97),(460,'Light','Corridor',1,'Father',98),(463,'Light','Kitchen',0,'Father',99),(463,'Light','Kitchen',1,'Father',100),(19,'Kettle','Kitchen',1,'Father',101),(19,'Kettle','Kitchen',0,'Father',102),(21,'Radio','Kitchen',1,'Father',103),(21,'Radio','Kitchen',0,'Father',104),(508,'Light','BedROOM',0,'Father',105),(508,'Light','BedROOM',1,'Father',106),(508,'Light','BedROOM',0,'Father',107),(508,'Light','BedROOM',1,'Father',108),(508,'Light','BedROOM',0,'Father',109),(508,'Light','BedROOM',1,'Father',110),(508,'Light','BedROOM',0,'Father',111),(508,'Light','BedROOM',1,'Father',112),(508,'Light','BedROOM',0,'Father',113),(463,'Light','Kitchen',0,'Father',114),(463,'Light','Kitchen',1,'Father',115),(19,'Kettle','Kitchen',1,'Father',116),(19,'Kettle','Kitchen',0,'Father',117),(19,'Kettle','Kitchen',1,'Father',118),(19,'Kettle','Kitchen',0,'Father',119),(21,'Radio','Kitchen',1,'Father',120),(21,'Radio','Kitchen',0,'Father',121),(21,'Radio','Kitchen',1,'Father',122),(463,'Light','Kitchen',0,'Father',123),(21,'Radio','Kitchen',0,'Father',124),(463,'Light','Kitchen',1,'Father',125),(463,'Light','Kitchen',0,'Father',126),(463,'Light','Kitchen',1,'Father',127),(463,'Light','Kitchen',0,'Father',128),(463,'Light','Kitchen',1,'Father',129),(463,'Light','Kitchen',0,'Father',130),(19,'Kettle','Kitchen',1,'Father',131),(19,'Kettle','Kitchen',0,'Father',132),(19,'Kettle','Kitchen',1,'Father',133),(463,'Light','Kitchen',1,'Father',134),(463,'Light','Kitchen',0,'Father',135),(463,'Light','Kitchen',1,'Father',136),(19,'Kettle','Kitchen',1,'Father',137),(19,'Kettle','Kitchen',0,'Father',138),(19,'Kettle','Kitchen',1,'Father',139),(19,'Kettle','Kitchen',0,'Father',140),(21,'Radio','Kitchen',1,'Father',141),(21,'Radio','Kitchen',0,'Father',142),(21,'Radio','Kitchen',1,'Father',143),(21,'Radio','Kitchen',0,'Father',144),(463,'Light','Kitchen',0,'Father',145),(463,'Light','Kitchen',1,'Father',146),(463,'Light','Kitchen',0,'Father',147),(463,'Light','Kitchen',1,'Father',148),(463,'Light','Kitchen',0,'Father',149),(507,'Light','LivingROOM',1,'Father',150),(507,'Light','LivingROOM',0,'Father',151),(507,'Light','LivingROOM',1,'Father',152),(21,'Radio','Kitchen',1,'Father',153),(19,'Kettle','Kitchen',1,'Father',154),(19,'Kettle','Kitchen',0,'Father',155),(19,'Kettle','Kitchen',1,'Father',156),(19,'Kettle','Kitchen',0,'Father',157),(19,'Kettle','Kitchen',1,'Father',158),(19,'Kettle','Kitchen',0,'Father',159),(21,'Radio','Kitchen',0,'Father',160),(508,'Light','BedROOM',1,'Father',161),(508,'Light','BedROOM',0,'Father',162);
/*!40000 ALTER TABLE `devicestate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `userName` varchar(200) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `userType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Shishay','sg@gmail.com','$5$rounds=535000$50pi2rOX.EFia0mx$9wnwg2rN3lrUO40x18oqXO1jp4EZRp/BmhMwV4p4Fv4','Father'),(2,'Shishay','sg@gmail.com','$5$rounds=535000$giUGNFsrZ8vO1udL$jKUPoWvdRq2khTzWFapbh82xG5URinEq5NHxlMpqxWB','Father'),(3,'Shishay','sg@gmail.com','$5$rounds=535000$VneDCmP66BkIAIAB$gSYYytVl6/TXxo7aoPk6ztFJYab1dsurWTKvrA0YP66','Father'),(4,'Mark','sg@gmail.com','$5$rounds=535000$Mnhht4DJseq.HBc3$A3ZfCc4f6NLj.mUK7aO.1evXB7jc.eJMzPWuyGcdDR6','Son'),(5,'Matias','mat@gmail.com','$5$rounds=535000$kJcP9DJxRkbKA7W6$un2/1BKC3QTTY2iGaMjQjI5Kz9.cqnqSQBwRvF75IF4','Son'),(6,'George','george@gmail.com','$5$rounds=535000$h2fnBD46AgJsro9t$typ0nstqmOoj/k6yjuTCGM/DVsAjsUW83xTq/0D.Zd8','Father'),(7,'Maria','mar@gmail.com','$5$rounds=535000$igRIB8mIAd9ECFRl$9HmJv1sbUylAOJEFIP5CZe6vEutXXq1ui6s3WEvW590','Mother'),(8,'Thomas','shishaylibe@gmail.com','$5$rounds=535000$yG3ALWr18mUHvoJp$TVeO2DI8d488cGc0XLa6pXg7PHcN/Zi/Ab1ra/kXVR8','Guest'),(9,'Thomas','shishaylibe@gmail.com','$5$rounds=535000$8NSK6tTXOpSpfmum$MZ5ZE/cHCXOtUtZODUfrQ8sKZ4OmI.UJFL2RgrsQYe6','Guest'),(10,'Thomas','shishaylibe@gmail.com','$5$rounds=535000$HfLicgifku39mIGo$Xmi6uvFJOkBZNMNA9Vjw8bAvopDE8wwR6eH5rgxkI9/','Guest'),(11,'Thomas','shishaylibe@gmail.com','$5$rounds=535000$yNJqbqmUwhmQJnpK$9ogs.DsbWz2lVx3u8VCAtv.wv0F9xTe48IA/teLxCW.','Guest'),(12,'Ben','ben@gmail.com','$5$rounds=535000$mFNER8TQuBJayeGr$FFmYJLrmCgtqdDJUFAghiOK9h99ywAfpa669m8iKxl.','Guest'),(13,'Ben','ben@gmail.com','$5$rounds=535000$HwiFO51owxlRD.t0$SVPX4f53qvI.RAxrzDiIwydp5k/NMy8880uZyTs9F61','Guest'),(14,'Ben','ben@gmail.com','$5$rounds=535000$wgHhCBiX1Wszd.og$M1Fk0xIvHtJFDXi8.i66VenfCaD0o7s6VrpYdlkR8Y.','Guest'),(15,'Ben','ben@gmail.com','$5$rounds=535000$TwU.AoPstZeu77Te$kbB1HvTSbIKj9khYPzCNRW5mDAlv76FrWNmp2ERo34C','Guest'),(16,'Ben','ben@gmail.com','$5$rounds=535000$ldzs199gsKBQR8F7$HtNzh40QZ9nk.a4Cvsi1H9hr7vaKiGIrtGEs4MVj.N0','Guest'),(17,'Ben','ben@gmail.com','$5$rounds=535000$I8llhG0aj4w0kw3R$oLRZYduBCZg9C9It5PCTZIsNTjGlptH520rPkBxriC1','Guest'),(18,'mam','mam@gmail.com','$5$rounds=535000$fXnTTrpzdfTzLNVW$uXtLjTETwtBxca/ExrnGSvDi.R43a6It00pNSM8Cfj2','Mother'),(19,'chala','chal@gmail.com','$5$rounds=535000$P8zjng3fdadT9iCy$1NbxILnY1PB1.l88IbFDrbk3hmGJlYrBx9aFaNdjamB','Guest'),(20,'baga','bag@gmail.com','$5$rounds=535000$mwSYJmT2pDqHjeIT$eNNVONKpT49czdBTjKgtIo3uTmXUWVv50SPIH267h8.','Siblings'),(21,'James','james@gmail.com','$5$rounds=535000$WCPyF.BQiN9PjlaA$M/BS7tGx2vDyKHbFUMtTq4dMFxLYFQYGMeKn6Felnn3','Father'),(22,'Mark','mark@yahoo.com','$5$rounds=535000$OYSmaQeTZ1FEg/0o$q1Nj9N8BP2WRCP5jDYNTQmnVq0bx4mYUYYCef50USE6','Guest'),(23,'leyla','leyla@gmail.com','$5$rounds=535000$Lx5tkNzsQ6GqUcoA$sudsBtZcgS1ch5SjU5NmQ9EDsZZCOj3Az4pDbYd6Qo.','Siblings'),(24,'David','david@gmail.com','$5$rounds=535000$GELtXACTkwztNvwO$vgwv7xkbR1.5frQxbdDnzW3eo8AesHuaDvZhlz5prI2','Siblings'),(25,'gines','abc@ac.es','$5$rounds=535000$3xzr4rSgpGUF2mh4$g.LnYw9IoogYP6fhndsp5e91g1eYMBuQKpJlIZqPi5A','Father'),(26,'Leo','leonard0@yahoo.co.uk','$5$rounds=535000$L.YPbYU5l7IBgqG9$YWnDOz3wnYcvvxx7/A/7ju8TXJ8u049Tn2Qz0cHJpQ3','Father'),(27,'mario.quinde','mquindelisaytan@gmail.com','$5$rounds=535000$sbU.eIVvV0op.5h1$Bz3ijKh28NqTdhNTJ9czRmg936JeXcBRbgN3nV7sw09','Father');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-27 13:50:38
