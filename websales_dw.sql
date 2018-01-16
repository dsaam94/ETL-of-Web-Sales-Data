-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 05, 2017 at 07:40 AM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `websales_dw`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `CATEGORYID` float NOT NULL,
  `CATEGORYNAME` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `CUSTOMERID` varchar(11) NOT NULL,
  `COMPANYNAME` varchar(50) DEFAULT NULL,
  `CONTACTNAME` varchar(50) DEFAULT NULL,
  `CONTACTTITLE` varchar(50) DEFAULT NULL,
  `ADDRESS` varchar(100) DEFAULT NULL,
  `CITY` varchar(50) DEFAULT NULL,
  `REGION` varchar(100) DEFAULT NULL,
  `POSTALCODE` varchar(50) DEFAULT NULL,
  `COUNTRY` varchar(50) DEFAULT NULL,
  `PHONE` varchar(25) DEFAULT NULL,
  `FAX` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `datedimension`
--

CREATE TABLE `datedimension` (
  `DATEKEY` int(11) NOT NULL,
  `DATEVALUE` date NOT NULL,
  `WEEK` int(11) NOT NULL,
  `MONTH` int(11) NOT NULL,
  `MONTHNAME` varchar(25) NOT NULL,
  `QUARTER` int(11) NOT NULL,
  `YEAR` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `EMPLOYEEID` float NOT NULL,
  `LASTNAME` varchar(100) DEFAULT NULL,
  `FIRSTNAME` varchar(100) DEFAULT NULL,
  `TITLE` varchar(50) DEFAULT NULL,
  `TITLEOFCOURTESY` varchar(50) DEFAULT NULL,
  `BIRTHDATE` datetime DEFAULT NULL,
  `HIREDATE` datetime DEFAULT NULL,
  `ADDRESS` varchar(255) DEFAULT NULL,
  `CITY` varchar(50) DEFAULT NULL,
  `REGION` varchar(50) DEFAULT NULL,
  `POSTALCOST` varchar(20) DEFAULT NULL,
  `COUNTRY` varchar(50) DEFAULT NULL,
  `HOMEPHONE` varchar(50) DEFAULT NULL,
  `EXTENSION` varchar(50) DEFAULT NULL,
  `NOTES` varchar(500) DEFAULT NULL,
  `REPORTSTO` float DEFAULT NULL,
  `PHOTOPATH` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `factorders`
--

CREATE TABLE `factorders` (
  `ORDERID` int(11) NOT NULL,
  `CUSTOMERID` varchar(11) DEFAULT NULL,
  `EMPLOYEEID` float DEFAULT NULL,
  `ORDERDATE` date NOT NULL,
  `REQUIREDDATE` date NOT NULL,
  `SHIPDATE` date NOT NULL,
  `SHIPVIA` float NOT NULL,
  `FREIGHT` float DEFAULT NULL,
  `PRODUCTID` float NOT NULL,
  `UNITPRICE` float NOT NULL,
  `QUANTITY` float NOT NULL,
  `DISCOUNT` float DEFAULT NULL,
  `ORDERDATEKEY` int(11) NOT NULL,
  `REQUIREDDATEKEY` int(11) NOT NULL,
  `SHIPDATEKEY` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `PRODUCTID` float NOT NULL,
  `PRODUCTNAME` varchar(255) DEFAULT NULL,
  `SUPPLIERID` float DEFAULT NULL,
  `CATEGORYID` float DEFAULT NULL,
  `QUANTITYPERUNIT` varchar(255) DEFAULT NULL,
  `UNITPRICE` float DEFAULT NULL,
  `UNITSINSTOCK` float DEFAULT NULL,
  `UNITSONORDER` float DEFAULT NULL,
  `REORDERLEVEL` float DEFAULT NULL,
  `DISCONTINUED` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `shippers`
--

CREATE TABLE `shippers` (
  `SHIPPERID` float NOT NULL,
  `COMPANYNAME` varchar(100) DEFAULT NULL,
  `PHONE` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`CATEGORYID`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`CUSTOMERID`);

--
-- Indexes for table `datedimension`
--
ALTER TABLE `datedimension`
  ADD PRIMARY KEY (`DATEKEY`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`EMPLOYEEID`);

--
-- Indexes for table `factorders`
--
ALTER TABLE `factorders`
  ADD PRIMARY KEY (`ORDERID`),
  ADD KEY `CUSTID_IDX` (`CUSTOMERID`),
  ADD KEY `IDX_EMPLOYEE_ID` (`EMPLOYEEID`),
  ADD KEY `ORDERDATEKEY` (`ORDERDATEKEY`),
  ADD KEY `REQUIREDDATEKEY` (`REQUIREDDATEKEY`),
  ADD KEY `SHIPDATEKEY` (`SHIPDATEKEY`),
  ADD KEY `PRODUCTID` (`PRODUCTID`),
  ADD KEY `SHIPVIA` (`SHIPVIA`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`PRODUCTID`),
  ADD KEY `CATEGORYID` (`CATEGORYID`);

--
-- Indexes for table `shippers`
--
ALTER TABLE `shippers`
  ADD PRIMARY KEY (`SHIPPERID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `factorders`
--
ALTER TABLE `factorders`
  ADD CONSTRAINT `FK_CUSTOMERID` FOREIGN KEY (`CUSTOMERID`) REFERENCES `customers` (`CUSTOMERID`),
  ADD CONSTRAINT `FK_EMPLOYEE` FOREIGN KEY (`EMPLOYEEID`) REFERENCES `employees` (`EMPLOYEEID`),
  ADD CONSTRAINT `FK_ORDERDATE` FOREIGN KEY (`ORDERDATEKEY`) REFERENCES `datedimension` (`DATEKEY`),
  ADD CONSTRAINT `FK_PRODUCTID` FOREIGN KEY (`PRODUCTID`) REFERENCES `products` (`PRODUCTID`),
  ADD CONSTRAINT `FK_REQUIREDDATE` FOREIGN KEY (`REQUIREDDATEKEY`) REFERENCES `datedimension` (`DATEKEY`),
  ADD CONSTRAINT `FK_SHIPDATE` FOREIGN KEY (`SHIPDATEKEY`) REFERENCES `datedimension` (`DATEKEY`),
  ADD CONSTRAINT `FK_SHIPVIA` FOREIGN KEY (`SHIPVIA`) REFERENCES `shippers` (`SHIPPERID`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `FK_CATEGORY` FOREIGN KEY (`CATEGORYID`) REFERENCES `categories` (`CATEGORYID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
