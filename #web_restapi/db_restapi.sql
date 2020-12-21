-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 21, 2020 at 12:52 AM
-- Server version: 5.7.24
-- PHP Version: 7.2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_restapi`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `admin_npp` varchar(255) DEFAULT NULL,
  `admin_nama` varchar(255) NOT NULL,
  `admin_username` varchar(255) NOT NULL,
  `admin_password` varchar(255) NOT NULL,
  `admin_is_delete` int(11) DEFAULT '0',
  `admin_update_by` int(11) DEFAULT NULL,
  `admin_update_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_npp`, `admin_nama`, `admin_username`, `admin_password`, `admin_is_delete`, `admin_update_by`, `admin_update_date`) VALUES
(1, 'ADM123', 'Agus Sumarna', 'kangagus@yahoo.com', '1ec9aacf21d135d882d21d63f33752d0', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_nik` varchar(255) NOT NULL,
  `user_nama` varchar(255) NOT NULL,
  `user_tanggal` date DEFAULT NULL,
  `user_username` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_is_delete` int(11) DEFAULT '0',
  `user_update_by` int(11) DEFAULT NULL,
  `user_update_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_nik`, `user_nama`, `user_tanggal`, `user_username`, `user_password`, `user_is_delete`, `user_update_by`, `user_update_date`) VALUES
(1, 'sis001', 'Agus Sumarna', '2020-12-16', 'siswa001', 'e172dd95f4feb21412a692e73929961e', 0, 1, '2020-12-16 13:13:45'),
(2, 'sis002', 'Nurfitri Annuurii', '2020-12-15', 'siswa002', 'E172dd95f4feb21412a692e73929961e', 0, 2, '2020-12-17 01:17:43'),
(5, 'Sis003', 'Siera Azzuri', '2020-12-20', 'Sis003', '40eea45e65214ea3a43e7a590c393e79', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_alamat`
--

CREATE TABLE `user_alamat` (
  `alamat_id` int(11) NOT NULL,
  `alamat_nik` varchar(255) NOT NULL,
  `alamat_lengkap` text NOT NULL,
  `alamat_is_delete` int(11) NOT NULL DEFAULT '0',
  `alamat_update_by` int(11) NOT NULL,
  `alamat_update_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_alamat`
--

INSERT INTO `user_alamat` (`alamat_id`, `alamat_nik`, `alamat_lengkap`, `alamat_is_delete`, `alamat_update_by`, `alamat_update_date`) VALUES
(1, 'sis001', 'Ciawi Jawa Barat', 0, 1, '2020-12-16 13:13:45'),
(2, 'sis002', 'Cilangkap Jakarta', 0, 2, '2020-12-17 01:17:43'),
(3, 'sis003', 'Jakarta', 0, 1, '2020-12-16 14:02:05');

-- --------------------------------------------------------

--
-- Table structure for table `user_personal`
--

CREATE TABLE `user_personal` (
  `personal_id` int(11) NOT NULL,
  `personal_nik` varchar(255) NOT NULL,
  `personal_skill` varchar(255) NOT NULL,
  `personal_nilai` varchar(255) NOT NULL,
  `personal_is_delete` int(11) NOT NULL DEFAULT '0',
  `personal_update_by` int(11) NOT NULL,
  `personal_update_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_personal`
--

INSERT INTO `user_personal` (`personal_id`, `personal_nik`, `personal_skill`, `personal_nilai`, `personal_is_delete`, `personal_update_by`, `personal_update_date`) VALUES
(1, 'sis001', 'Programmer', '99', 0, 1, '2020-12-16 13:13:45'),
(2, 'sis002', 'Design', '100', 0, 2, '2020-12-17 01:17:43'),
(3, 'sis003', 'Programmer', '100', 0, 1, '2020-12-16 14:02:05');

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_user`
-- (See below for the actual view)
--
CREATE TABLE `v_user` (
`user_id` int(11)
,`user_nik` varchar(255)
,`user_nama` varchar(255)
,`user_tanggal` date
,`user_username` varchar(255)
,`user_password` varchar(255)
,`user_is_delete` int(11)
,`user_update_by` int(11)
,`user_update_date` datetime
,`alamat_id` int(11)
,`alamat_nik` varchar(255)
,`alamat_lengkap` text
,`alamat_is_delete` int(11)
,`alamat_update_by` int(11)
,`alamat_update_date` datetime
,`personal_id` int(11)
,`personal_nik` varchar(255)
,`personal_skill` varchar(255)
,`personal_nilai` varchar(255)
,`personal_is_delete` int(11)
,`personal_update_by` int(11)
,`personal_update_date` datetime
);

-- --------------------------------------------------------

--
-- Structure for view `v_user`
--
DROP TABLE IF EXISTS `v_user`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_user`  AS SELECT `user`.`user_id` AS `user_id`, `user`.`user_nik` AS `user_nik`, `user`.`user_nama` AS `user_nama`, `user`.`user_tanggal` AS `user_tanggal`, `user`.`user_username` AS `user_username`, `user`.`user_password` AS `user_password`, `user`.`user_is_delete` AS `user_is_delete`, `user`.`user_update_by` AS `user_update_by`, `user`.`user_update_date` AS `user_update_date`, `alamat`.`alamat_id` AS `alamat_id`, `alamat`.`alamat_nik` AS `alamat_nik`, `alamat`.`alamat_lengkap` AS `alamat_lengkap`, `alamat`.`alamat_is_delete` AS `alamat_is_delete`, `alamat`.`alamat_update_by` AS `alamat_update_by`, `alamat`.`alamat_update_date` AS `alamat_update_date`, `personal`.`personal_id` AS `personal_id`, `personal`.`personal_nik` AS `personal_nik`, `personal`.`personal_skill` AS `personal_skill`, `personal`.`personal_nilai` AS `personal_nilai`, `personal`.`personal_is_delete` AS `personal_is_delete`, `personal`.`personal_update_by` AS `personal_update_by`, `personal`.`personal_update_date` AS `personal_update_date` FROM ((`user` left join `user_alamat` `alamat` on((`user`.`user_nik` = `alamat`.`alamat_nik`))) left join `user_personal` `personal` on((`user`.`user_nik` = `personal`.`personal_nik`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD KEY `admin_nama` (`admin_nama`),
  ADD KEY `admin_npp` (`admin_npp`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_alamat`
--
ALTER TABLE `user_alamat`
  ADD PRIMARY KEY (`alamat_id`);

--
-- Indexes for table `user_personal`
--
ALTER TABLE `user_personal`
  ADD PRIMARY KEY (`personal_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_alamat`
--
ALTER TABLE `user_alamat`
  MODIFY `alamat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_personal`
--
ALTER TABLE `user_personal`
  MODIFY `personal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
