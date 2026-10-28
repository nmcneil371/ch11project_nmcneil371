-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 28, 2026 at 11:12 PM
-- Server version: 8.0.46
-- PHP Version: 8.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `taus_data`
--
CREATE DATABASE IF NOT EXISTS `taus_data` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `taus_data`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getStudentByEmail` (IN `p_email` VARCHAR(254))   SELECT * FROM tbl_student
WHERE email = p_email$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getStudents` ()   SELECT * FROM tbl_student$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertStudent` (IN `p_firstName` VARCHAR(50), IN `p_lastName` VARCHAR(50), IN `p_email` VARCHAR(254))   INSERT INTO tbl_student (firstName, lastName, email)
VALUES (p_firstName, p_lastName, p_email)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_class`
--

CREATE TABLE `tbl_class` (
  `classID` int NOT NULL,
  `className` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_class`
--

INSERT INTO `tbl_class` (`classID`, `className`, `location`) VALUES
(101, 'Database Fundamentals', 'Room 101'),
(102, 'Web Develoment', 'Room 102'),
(103, 'Computer Support', 'Room 103');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_student`
--

CREATE TABLE `tbl_student` (
  `studentID` int NOT NULL,
  `firstName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_student`
--

INSERT INTO `tbl_student` (`studentID`, `firstName`, `lastName`, `email`) VALUES
(1, 'Alex', 'Carter', 'alex.carter@example.com'),
(2, 'Jordan', 'Lee', 'jordan.lee@example.com'),
(3, 'Taylor', 'Davis', 'taylor.davis@example.com'),
(4, 'Naquan', 'McNeil', 'Nmcneil371@mail.cfcc.edu');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_student_class`
--

CREATE TABLE `tbl_student_class` (
  `studentID` int NOT NULL,
  `classID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_student_class`
--

INSERT INTO `tbl_student_class` (`studentID`, `classID`) VALUES
(1, 101),
(2, 102),
(3, 103);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_student_classes`
-- (See below for the actual view)
--
CREATE TABLE `vw_student_classes` (
`studentID` int
,`firstName` varchar(50)
,`lastName` varchar(50)
,`email` varchar(254)
,`classID` int
,`className` varchar(100)
,`location` varchar(100)
);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_class`
--
ALTER TABLE `tbl_class`
  ADD PRIMARY KEY (`classID`);

--
-- Indexes for table `tbl_student`
--
ALTER TABLE `tbl_student`
  ADD PRIMARY KEY (`studentID`);

--
-- Indexes for table `tbl_student_class`
--
ALTER TABLE `tbl_student_class`
  ADD PRIMARY KEY (`studentID`,`classID`),
  ADD KEY `fl_class` (`classID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_student`
--
ALTER TABLE `tbl_student`
  MODIFY `studentID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

-- --------------------------------------------------------

--
-- Structure for view `vw_student_classes`
--
DROP TABLE IF EXISTS `vw_student_classes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_student_classes`  AS SELECT `s`.`studentID` AS `studentID`, `s`.`firstName` AS `firstName`, `s`.`lastName` AS `lastName`, `s`.`email` AS `email`, `c`.`classID` AS `classID`, `c`.`className` AS `className`, `c`.`location` AS `location` FROM ((`tbl_student` `s` left join `tbl_student_class` `sc` on((`s`.`studentID` = `sc`.`studentID`))) left join `tbl_class` `c` on((`sc`.`classID` = `c`.`classID`))) ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_student_class`
--
ALTER TABLE `tbl_student_class`
  ADD CONSTRAINT `fk_student` FOREIGN KEY (`studentID`) REFERENCES `tbl_student` (`studentID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fl_class` FOREIGN KEY (`classID`) REFERENCES `tbl_class` (`classID`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
