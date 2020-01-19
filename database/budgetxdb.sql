-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.28-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for budgetxdb
CREATE DATABASE IF NOT EXISTS `budgetxdb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `budgetxdb`;

-- Dumping structure for table budgetxdb.admin_settings
CREATE TABLE IF NOT EXISTS `admin_settings` (
  `id` int(1) NOT NULL,
  `maintainance` int(11) NOT NULL,
  `settings` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table budgetxdb.admin_settings: ~0 rows (approximately)
/*!40000 ALTER TABLE `admin_settings` DISABLE KEYS */;
INSERT INTO `admin_settings` (`id`, `maintainance`, `settings`) VALUES
	(1, 0, 0);
/*!40000 ALTER TABLE `admin_settings` ENABLE KEYS */;

-- Dumping structure for table budgetxdb.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` text,
  `finance_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_categories_finance_type` (`finance_type_id`),
  CONSTRAINT `FK_categories_finance_type` FOREIGN KEY (`finance_type_id`) REFERENCES `finance_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Dumping data for table budgetxdb.categories: ~9 rows (approximately)
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `category`, `finance_type_id`) VALUES
	(1, 'Rent', 2),
	(2, 'Food', 2),
	(3, 'Transport', 2),
	(4, 'Salary', 1),
	(5, 'Property', 1),
	(6, 'Allowance', 1),
	(7, 'Clothes', 2),
	(8, 'Others', 1),
	(9, 'Others', 2);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Dumping structure for table budgetxdb.counts
CREATE TABLE IF NOT EXISTS `counts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visits` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table budgetxdb.counts: ~0 rows (approximately)
/*!40000 ALTER TABLE `counts` DISABLE KEYS */;
INSERT INTO `counts` (`id`, `visits`) VALUES
	(1, 23);
/*!40000 ALTER TABLE `counts` ENABLE KEYS */;

-- Dumping structure for table budgetxdb.feedback
CREATE TABLE IF NOT EXISTS `feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text,
  `body` text,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_feedback_users` (`user_id`),
  CONSTRAINT `FK_feedback_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Dumping data for table budgetxdb.feedback: ~3 rows (approximately)
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` (`id`, `title`, `body`, `user_id`, `created_at`, `updated_at`) VALUES
	(2, 'Feedback 1', 'This is body of feedback 1', 1, '2017-12-25 18:22:18', '2017-12-23 19:02:18'),
	(6, 'Sending feedback', 'Bla bla', 6, '2017-12-26 21:35:47', '2017-12-26 21:35:47'),
	(7, 'Sending feedback 2', 'bbbhyh', 6, '2017-12-28 10:13:55', '2017-12-28 10:13:55');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;

-- Dumping structure for table budgetxdb.finances
CREATE TABLE IF NOT EXISTS `finances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `finance_type_id` int(11) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `description` text,
  `frequency` int(11) DEFAULT NULL,
  `last_transaction_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`),
  KEY `finance_type_id` (`finance_type_id`),
  KEY `frequency` (`frequency`),
  CONSTRAINT `finances_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `finances_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `finances_ibfk_3` FOREIGN KEY (`finance_type_id`) REFERENCES `finance_type` (`id`),
  CONSTRAINT `finances_ibfk_4` FOREIGN KEY (`frequency`) REFERENCES `frequency` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=latin1;

-- Dumping data for table budgetxdb.finances: ~46 rows (approximately)
/*!40000 ALTER TABLE `finances` DISABLE KEYS */;
INSERT INTO `finances` (`id`, `user_id`, `finance_type_id`, `amount`, `transaction_date`, `category_id`, `description`, `frequency`, `last_transaction_date`) VALUES
	(1, 2, 2, 1000, '2017-12-13', 2, 'Birthday Party Expense', NULL, NULL),
	(2, 1, 1, 2000, '2016-11-05', 4, '', NULL, NULL),
	(7, 2, 1, 1000, '2017-12-05', 1, NULL, NULL, NULL),
	(8, 2, 2, 5000, '2017-12-21', 7, NULL, NULL, NULL),
	(9, 2, 2, 1000, '2017-12-21', 7, NULL, NULL, NULL),
	(11, 6, 2, 4000, '2017-12-19', 1, NULL, 1, '0000-00-00'),
	(15, 6, 2, 1000, '2016-10-19', 3, NULL, 1, '0000-00-00'),
	(17, 6, 2, 5000, '2017-12-18', 1, NULL, 1, '0000-00-00'),
	(18, 6, 2, 5000, '2017-12-25', 7, NULL, 1, '0000-00-00'),
	(21, 6, 2, 7000, '2018-01-01', 2, '', 1, '0000-00-00'),
	(22, 6, 2, 80, '2018-01-14', 2, 'Buff Mo:Mo', 1, '0000-00-00'),
	(23, 6, 2, 90, '2018-01-16', 2, 'Buff Fried C Mo:Mo', 1, '0000-00-00'),
	(62, 6, 1, 100, '2018-01-16', 6, 'Lunch', 2, '2018-02-15'),
	(63, 6, 1, 100, '2018-01-17', 6, 'Lunch', 5, '0000-00-00'),
	(64, 6, 1, 100, '2018-01-18', 6, 'Lunch', 5, '0000-00-00'),
	(65, 6, 1, 1000, '2018-01-04', 6, 'Pocke Money', 3, '2018-02-15'),
	(66, 6, 1, 1000, '2018-01-11', 6, 'Pocke Money', 5, '0000-00-00'),
	(67, 6, 1, 1000, '2018-01-18', 6, 'Pocke Money', 5, '0000-00-00'),
	(68, 6, 1, 15000, '2017-12-13', 5, 'home bhada', 4, '2018-03-13'),
	(69, 6, 1, 15000, '2018-01-12', 5, 'home bhada', 5, '0000-00-00'),
	(70, 6, 1, 100, '2018-01-20', 6, 'Lunch', 5, '0000-00-00'),
	(71, 6, 1, 100, '2018-01-21', 6, 'Lunch', 5, '0000-00-00'),
	(72, 6, 1, 500, '2018-01-09', 8, '', 1, '2018-01-09'),
	(74, 6, 2, 330, '2018-01-16', 8, '', 1, '2018-01-16'),
	(75, 6, 1, 5000, '2018-01-10', 8, '', 3, '2018-02-21'),
	(76, 6, 1, 5000, '2018-01-17', 8, '', 5, '0000-00-00'),
	(77, 6, 1, 5000, '2018-01-24', 8, '', 5, '0000-00-00'),
	(78, 6, 1, 100, '2018-01-28', 6, 'Lunch', 5, '0000-00-00'),
	(79, 6, 1, 100, '2018-01-29', 6, 'Lunch', 5, '0000-00-00'),
	(80, 6, 1, 100, '2018-01-30', 6, 'Lunch', 5, '0000-00-00'),
	(81, 6, 1, 100, '2018-01-31', 6, 'Lunch', 5, '0000-00-00'),
	(82, 6, 1, 100, '2018-02-01', 6, 'Lunch', 5, '0000-00-00'),
	(83, 6, 1, 100, '2018-02-02', 6, 'Lunch', 5, '0000-00-00'),
	(84, 6, 1, 100, '2018-02-03', 6, 'Lunch', 5, '0000-00-00'),
	(85, 6, 1, 100, '2018-02-04', 6, 'Lunch', 5, '0000-00-00'),
	(86, 6, 1, 100, '2018-02-05', 6, 'Lunch', 5, '0000-00-00'),
	(87, 6, 1, 100, '2018-02-06', 6, 'Lunch', 5, '0000-00-00'),
	(88, 6, 1, 100, '2018-02-07', 6, 'Lunch', 5, '0000-00-00'),
	(89, 6, 1, 100, '2018-02-08', 6, 'Lunch', 5, '0000-00-00'),
	(90, 6, 1, 100, '2018-02-09', 6, 'Lunch', 5, '0000-00-00'),
	(91, 6, 1, 100, '2018-02-10', 6, 'Lunch', 5, '0000-00-00'),
	(92, 6, 1, 100, '2018-02-11', 6, 'Lunch', 5, '0000-00-00'),
	(93, 6, 1, 100, '2018-02-12', 6, 'Lunch', 5, '0000-00-00'),
	(94, 6, 1, 100, '2018-02-13', 6, 'Lunch', 5, '0000-00-00'),
	(95, 6, 1, 5000, '2018-02-07', 8, '', 5, '0000-00-00'),
	(96, 6, 1, 1000, '2018-02-08', 6, 'Pocke Money', 5, '0000-00-00');
/*!40000 ALTER TABLE `finances` ENABLE KEYS */;

-- Dumping structure for table budgetxdb.finance_type
CREATE TABLE IF NOT EXISTS `finance_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table budgetxdb.finance_type: ~2 rows (approximately)
/*!40000 ALTER TABLE `finance_type` DISABLE KEYS */;
INSERT INTO `finance_type` (`id`, `type`) VALUES
	(1, 'income'),
	(2, 'expense');
/*!40000 ALTER TABLE `finance_type` ENABLE KEYS */;

-- Dumping structure for table budgetxdb.frequency
CREATE TABLE IF NOT EXISTS `frequency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `frequency_type` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table budgetxdb.frequency: ~5 rows (approximately)
/*!40000 ALTER TABLE `frequency` DISABLE KEYS */;
INSERT INTO `frequency` (`id`, `frequency_type`) VALUES
	(1, 'One-Time'),
	(2, 'Daily'),
	(3, 'Weekly'),
	(4, 'Monthly'),
	(5, 'Automated');
/*!40000 ALTER TABLE `frequency` ENABLE KEYS */;

-- Dumping structure for table budgetxdb.notices
CREATE TABLE IF NOT EXISTS `notices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text,
  `body` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Dumping data for table budgetxdb.notices: ~10 rows (approximately)
/*!40000 ALTER TABLE `notices` DISABLE KEYS */;
INSERT INTO `notices` (`id`, `title`, `body`, `created_at`, `updated_at`) VALUES
	(2, 'notice 1', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\r\ntempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,\r\nquis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo\r\nconsequat. Duis aute irure dolor in reprehenderit in voluptate velit esse\r\ncillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non\r\nproident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2017-12-23 17:01:57', '2017-12-23 16:55:59'),
	(3, 'notice 2', 'body of notice 2', '2017-12-23 18:15:32', '2017-12-23 18:15:32'),
	(4, 'New Notice', 'Changes #2', '2017-12-24 11:12:52', '2017-12-24 11:12:52'),
	(5, 'Notice 3', 'This is body of notice 3.', '2017-12-24 11:18:10', '2017-12-24 11:18:10'),
	(6, 'notice 4', 'notice noice', '2017-12-24 11:27:05', '2017-12-24 11:27:05'),
	(7, 'Notice 3', 'nsdkfjasfjlasdjkasdh ashfjadh fasd', '2017-12-24 11:27:22', '2017-12-24 11:27:22'),
	(8, 'ad,fj', 'sd,f', '2017-12-24 11:30:53', '2017-12-24 11:30:53'),
	(9, 'this is new notice', 'this is body of new notice.\r\nbla bla', '2017-12-26 13:17:19', '2017-12-26 13:17:19'),
	(10, 'abc', 'abcd', '2017-12-26 13:23:08', '2017-12-26 13:23:08'),
	(11, 'new', 'new notice', '2017-12-26 13:23:19', '2017-12-26 13:23:19');
/*!40000 ALTER TABLE `notices` ENABLE KEYS */;

-- Dumping structure for table budgetxdb.quotes
CREATE TABLE IF NOT EXISTS `quotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quote` text NOT NULL,
  KEY `Index` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table budgetxdb.quotes: ~4 rows (approximately)
/*!40000 ALTER TABLE `quotes` DISABLE KEYS */;
INSERT INTO `quotes` (`id`, `quote`) VALUES
	(1, 'There are two rules you need to follow for saving money.<br>1, Never waste your MONEY.<br>2, Never forget rule no. 1.'),
	(2, 'If the outcome is income and it is legal, then do it.'),
	(3, 'It is not the man who has too little, but the man who craves more, that is poor.<br> --Seneca'),
	(5, 'Empty pockets never held anyone back. Only empty heads and empty hearts can do that. <br>--Norman Vincent Peale');
/*!40000 ALTER TABLE `quotes` ENABLE KEYS */;

-- Dumping structure for table budgetxdb.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table budgetxdb.roles: ~2 rows (approximately)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `role`) VALUES
	(1, 'admin'),
	(2, 'user');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table budgetxdb.savings
CREATE TABLE IF NOT EXISTS `savings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `month_of_transaction` int(11) DEFAULT NULL,
  `expected_savings` int(11) DEFAULT NULL,
  `calculated_savings` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table budgetxdb.savings: ~0 rows (approximately)
/*!40000 ALTER TABLE `savings` DISABLE KEYS */;
INSERT INTO `savings` (`id`, `user_id`, `month_of_transaction`, `expected_savings`, `calculated_savings`) VALUES
	(1, 6, 1, 5000, 26500);
/*!40000 ALTER TABLE `savings` ENABLE KEYS */;

-- Dumping structure for table budgetxdb.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT '2',
  `image_path` varchar(255) DEFAULT '/media/default.png',
  `name` text,
  `email` varchar(255) DEFAULT NULL,
  `password` text,
  `hash` text,
  `active` int(11) DEFAULT '0',
  `count` int(11) DEFAULT '0',
  `quote_pref` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_5` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table budgetxdb.users: ~4 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `role_id`, `image_path`, `name`, `email`, `password`, `hash`, `active`, `count`, `quote_pref`) VALUES
	(1, 1, '/media/default.png', 'admin', 'admin@admin.com', 'c93ccd78b2076528346216b3b2f701e6', 'c93ccd78b2076528346216b3b2f701e6', 1, 0, NULL),
	(2, 2, '/media/default.png', 'user 1', 'user@user.com', 'b5b73fae0d87d8b4e2573105f8fbe7bc', 'b5b73fae0d87d8b4e2573105f8fbe7bc', 0, 0, NULL),
	(6, 2, '/media/22690162_1643972328968186_1970153719_o.jpg', 'Shantanu Bhattarai', 'zer0.shantanu@gmail.com', '25d55ad283aa400af464c76d713c07ad', '6da37dd3139aa4d9aa55b8d237ec5d4a', 1, 21, 1),
	(8, 2, '/media/default.png', 'bla', 'bla@bla.com', 'bf49f28e0507ba0fcfcabdcbf5d284a5', 'b0b183c207f46f0cca7dc63b2604f5cc', 0, 0, NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
