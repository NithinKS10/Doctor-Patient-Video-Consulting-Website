-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 19, 2024 at 07:46 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `patient_doctor_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add appointment', 7, 'add_appointment'),
(26, 'Can change appointment', 7, 'change_appointment'),
(27, 'Can delete appointment', 7, 'delete_appointment'),
(28, 'Can view appointment', 7, 'view_appointment'),
(29, 'Can add complaint', 8, 'add_complaint'),
(30, 'Can change complaint', 8, 'change_complaint'),
(31, 'Can delete complaint', 8, 'delete_complaint'),
(32, 'Can view complaint', 8, 'view_complaint'),
(33, 'Can add district', 9, 'add_district'),
(34, 'Can change district', 9, 'change_district'),
(35, 'Can delete district', 9, 'delete_district'),
(36, 'Can view district', 9, 'view_district'),
(37, 'Can add doctor', 10, 'add_doctor'),
(38, 'Can change doctor', 10, 'change_doctor'),
(39, 'Can delete doctor', 10, 'delete_doctor'),
(40, 'Can view doctor', 10, 'view_doctor'),
(41, 'Can add feedback', 11, 'add_feedback'),
(42, 'Can change feedback', 11, 'change_feedback'),
(43, 'Can delete feedback', 11, 'delete_feedback'),
(44, 'Can view feedback', 11, 'view_feedback'),
(45, 'Can add insurance', 12, 'add_insurance'),
(46, 'Can change insurance', 12, 'change_insurance'),
(47, 'Can delete insurance', 12, 'delete_insurance'),
(48, 'Can view insurance', 12, 'view_insurance'),
(49, 'Can add lab', 13, 'add_lab'),
(50, 'Can change lab', 13, 'change_lab'),
(51, 'Can delete lab', 13, 'delete_lab'),
(52, 'Can view lab', 13, 'view_lab'),
(53, 'Can add lab_test', 14, 'add_lab_test'),
(54, 'Can change lab_test', 14, 'change_lab_test'),
(55, 'Can delete lab_test', 14, 'delete_lab_test'),
(56, 'Can view lab_test', 14, 'view_lab_test'),
(57, 'Can add lab_test_type', 15, 'add_lab_test_type'),
(58, 'Can change lab_test_type', 15, 'change_lab_test_type'),
(59, 'Can delete lab_test_type', 15, 'delete_lab_test_type'),
(60, 'Can view lab_test_type', 15, 'view_lab_test_type'),
(61, 'Can add login', 16, 'add_login'),
(62, 'Can change login', 16, 'change_login'),
(63, 'Can delete login', 16, 'delete_login'),
(64, 'Can view login', 16, 'view_login'),
(65, 'Can add medical speciality', 17, 'add_medicalspeciality'),
(66, 'Can change medical speciality', 17, 'change_medicalspeciality'),
(67, 'Can delete medical speciality', 17, 'delete_medicalspeciality'),
(68, 'Can view medical speciality', 17, 'view_medicalspeciality'),
(69, 'Can add patients', 18, 'add_patients'),
(70, 'Can change patients', 18, 'change_patients'),
(71, 'Can delete patients', 18, 'delete_patients'),
(72, 'Can view patients', 18, 'view_patients'),
(73, 'Can add prescription', 19, 'add_prescription'),
(74, 'Can change prescription', 19, 'change_prescription'),
(75, 'Can delete prescription', 19, 'delete_prescription'),
(76, 'Can view prescription', 19, 'view_prescription'),
(77, 'Can add state', 20, 'add_state'),
(78, 'Can change state', 20, 'change_state'),
(79, 'Can delete state', 20, 'delete_state'),
(80, 'Can view state', 20, 'view_state'),
(81, 'Can add category', 21, 'add_category'),
(82, 'Can change category', 21, 'change_category'),
(83, 'Can delete category', 21, 'delete_category'),
(84, 'Can view category', 21, 'view_category'),
(85, 'Can add icd_details', 22, 'add_icd_details'),
(86, 'Can change icd_details', 22, 'change_icd_details'),
(87, 'Can delete icd_details', 22, 'delete_icd_details'),
(88, 'Can view icd_details', 22, 'view_icd_details'),
(89, 'Can add sub_category', 23, 'add_sub_category'),
(90, 'Can change sub_category', 23, 'change_sub_category'),
(91, 'Can delete sub_category', 23, 'delete_sub_category'),
(92, 'Can view sub_category', 23, 'view_sub_category');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$720000$wQQULVn29NGlHqyvhwlKhf$5tnPbCHqnXJ/JcMtueAhD+gUKUJGoaG2zjQJvF4q8xo=', NULL, 1, 'admin', '', '', 'admin@gmail.com', 1, 1, '2024-09-17 06:39:13.400002');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'dispensaryapp', 'appointment'),
(21, 'dispensaryapp', 'category'),
(8, 'dispensaryapp', 'complaint'),
(9, 'dispensaryapp', 'district'),
(10, 'dispensaryapp', 'doctor'),
(11, 'dispensaryapp', 'feedback'),
(22, 'dispensaryapp', 'icd_details'),
(12, 'dispensaryapp', 'insurance'),
(13, 'dispensaryapp', 'lab'),
(14, 'dispensaryapp', 'lab_test'),
(15, 'dispensaryapp', 'lab_test_type'),
(16, 'dispensaryapp', 'login'),
(17, 'dispensaryapp', 'medicalspeciality'),
(18, 'dispensaryapp', 'patients'),
(19, 'dispensaryapp', 'prescription'),
(20, 'dispensaryapp', 'state'),
(23, 'dispensaryapp', 'sub_category'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-09-17 06:20:30.612682'),
(2, 'auth', '0001_initial', '2024-09-17 06:20:31.038316'),
(3, 'admin', '0001_initial', '2024-09-17 06:20:31.127208'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-09-17 06:20:31.133043'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-09-17 06:20:31.133043'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-09-17 06:20:31.180729'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-09-17 06:20:31.227898'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-09-17 06:20:31.249192'),
(9, 'auth', '0004_alter_user_username_opts', '2024-09-17 06:20:31.254036'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-09-17 06:20:31.301052'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-09-17 06:20:31.303824'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-09-17 06:20:31.307354'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-09-17 06:20:31.324021'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-09-17 06:20:31.332949'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-09-17 06:20:31.339552'),
(16, 'auth', '0011_update_proxy_permissions', '2024-09-17 06:20:31.354566'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-09-17 06:20:31.354566'),
(18, 'dispensaryapp', '0001_initial', '2024-09-17 06:20:31.473564'),
(19, 'dispensaryapp', '0002_appointment_time', '2024-09-17 06:20:31.485655'),
(20, 'dispensaryapp', '0003_patients_email', '2024-09-17 06:20:31.488174'),
(21, 'dispensaryapp', '0004_category_icd_details_sub_category', '2024-09-17 06:20:31.520137'),
(22, 'sessions', '0001_initial', '2024-09-17 06:20:31.544667'),
(23, 'dispensaryapp', '0005_prescription_icd_details_id', '2024-09-17 06:29:43.168200'),
(24, 'dispensaryapp', '0006_alter_prescription_icd_details_id', '2024-09-17 07:09:38.883358'),
(25, 'dispensaryapp', '0007_appointment_amount', '2024-09-19 11:05:18.409409'),
(26, 'dispensaryapp', '0008_rename_amount_appointment_fee_appointment_pay_status', '2024-09-19 11:08:50.989047'),
(27, 'dispensaryapp', '0009_delete_category_delete_icd_details_and_more', '2024-09-19 11:12:39.061952');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('1ovy0pj6j9v90irifp1kn9x6085lit9g', 'eyJkbmFtZSI6Imp1d2FuMTIzIiwic2xvZ2lkIjoxfQ:1sqsrM:egClbINxXe1S-hlYvarUJFjN0z9fsYA4tZvO2_cB_NQ', '2024-10-02 11:28:36.723032'),
('g4y16vlu4bdzjfjpd7brt7bj426khqvt', 'eyJhbmFtZSI6ImFkbWluIiwic2xvZ2lkIjoxfQ:1srLDZ:fou4PyXaUOMBIqZOcOgwGOWKPuywMoYsOXpTrNo27Dg', '2024-10-03 17:45:25.633561'),
('jhmd0sxdujp1ha3vwm3crjkdvdj7olib', 'eyJkbmFtZSI6Imp1d2FuMTIzIiwic2xvZ2lkIjoxfQ:1sqrsZ:tSNq9iwSWeQ-RgKqd1_NWgTUl85PeRqgFWLkt7y2nQw', '2024-10-02 10:25:47.144457');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_appointment`
--

CREATE TABLE `tbl_appointment` (
  `appointment_id` int(11) NOT NULL,
  `doctor_login_id` int(11) NOT NULL,
  `patient_login_id` int(11) NOT NULL,
  `appointment_date` date NOT NULL,
  `entry_date` datetime(6) NOT NULL,
  `status` varchar(50) NOT NULL,
  `time` time(6) DEFAULT NULL,
  `fee` int(11) DEFAULT NULL,
  `pay_status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_appointment`
--

INSERT INTO `tbl_appointment` (`appointment_id`, `doctor_login_id`, `patient_login_id`, `appointment_date`, `entry_date`, `status`, `time`, `fee`, `pay_status`) VALUES
(4, 1, 5, '2024-09-17', '2024-09-17 13:34:43.223588', 'Accepted', '08:40:00.000000', NULL, 'Not Paid'),
(5, 1, 5, '2024-09-18', '2024-09-17 13:34:51.144247', 'Accepted', '08:10:00.000000', NULL, 'Not Paid'),
(6, 1, 5, '2024-09-19', '2024-09-17 13:35:00.540396', 'Paid', '09:00:00.000000', 230, 'Not Paid'),
(7, 1, 5, '2024-09-19', '2024-09-17 13:35:07.442168', 'Not Consulted', NULL, NULL, 'Not Paid'),
(8, 1, 5, '2024-09-18', '2024-09-17 13:35:15.376839', 'Not Consulted', NULL, NULL, 'Not Paid'),
(9, 1, 5, '2024-09-18', '2024-09-17 13:36:10.716354', 'Not Consulted', NULL, NULL, 'Not Paid'),
(10, 1, 5, '2024-09-17', '2024-09-17 13:36:17.809190', 'Consulted', '09:10:00.000000', 130, 'Not Paid');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_complaint`
--

CREATE TABLE `tbl_complaint` (
  `complaint_id` int(11) NOT NULL,
  `complaint` varchar(150) NOT NULL,
  `user_login_id` int(11) NOT NULL,
  `reply` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_complaint`
--

INSERT INTO `tbl_complaint` (`complaint_id`, `complaint`, `user_login_id`, `reply`) VALUES
(1, 'Bad Service', 5, 'No');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_district`
--

CREATE TABLE `tbl_district` (
  `district_id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `district` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_district`
--

INSERT INTO `tbl_district` (`district_id`, `state_id`, `district`) VALUES
(1, 32, 'North and Middle Andaman'),
(2, 32, 'South Andaman'),
(3, 32, 'Nicobar'),
(4, 1, 'Adilabad'),
(5, 1, 'Anantapur'),
(6, 1, 'Chittoor'),
(7, 1, 'East Godavari'),
(8, 1, 'Guntur'),
(9, 1, 'Hyderabad'),
(10, 1, 'Kadapa'),
(11, 1, 'Karimnagar'),
(12, 1, 'Khammam'),
(13, 1, 'Krishna'),
(14, 1, 'Kurnool'),
(15, 1, 'Mahbubnagar'),
(16, 1, 'Medak'),
(17, 1, 'Nalgonda'),
(18, 1, 'Nellore'),
(19, 1, 'Nizamabad'),
(20, 1, 'Prakasam'),
(21, 1, 'Rangareddi'),
(22, 1, 'Srikakulam'),
(23, 1, 'Vishakhapatnam'),
(24, 1, 'Vizianagaram'),
(25, 1, 'Warangal'),
(26, 1, 'West Godavari'),
(27, 3, 'Anjaw'),
(28, 3, 'Changlang'),
(29, 3, 'East Kameng'),
(30, 3, 'Lohit'),
(31, 3, 'Lower Subansiri'),
(32, 3, 'Papum Pare'),
(33, 3, 'Tirap'),
(34, 3, 'Dibang Valley'),
(35, 3, 'Upper Subansiri'),
(36, 3, 'West Kameng'),
(37, 2, 'Barpeta'),
(38, 2, 'Bongaigaon'),
(39, 2, 'Cachar'),
(40, 2, 'Darrang'),
(41, 2, 'Dhemaji'),
(42, 2, 'Dhubri'),
(43, 2, 'Dibrugarh'),
(44, 2, 'Goalpara'),
(45, 2, 'Golaghat'),
(46, 2, 'Hailakandi'),
(47, 2, 'Jorhat'),
(48, 2, 'Karbi Anglong'),
(49, 2, 'Karimganj'),
(50, 2, 'Kokrajhar'),
(51, 2, 'Lakhimpur'),
(52, 2, 'Marigaon'),
(53, 2, 'Nagaon'),
(54, 2, 'Nalbari'),
(55, 2, 'North Cachar Hills'),
(56, 2, 'Sibsagar'),
(57, 2, 'Sonitpur'),
(58, 2, 'Tinsukia'),
(59, 4, 'Araria'),
(60, 4, 'Aurangabad'),
(61, 4, 'Banka'),
(62, 4, 'Begusarai'),
(63, 4, 'Bhagalpur'),
(64, 4, 'Bhojpur'),
(65, 4, 'Buxar'),
(66, 4, 'Darbhanga'),
(67, 4, 'Purba Champaran'),
(68, 4, 'Gaya'),
(69, 4, 'Gopalganj'),
(70, 4, 'Jamui'),
(71, 4, 'Jehanabad'),
(72, 4, 'Khagaria'),
(73, 4, 'Kishanganj'),
(74, 4, 'Kaimur'),
(75, 4, 'Katihar'),
(76, 4, 'Lakhisarai'),
(77, 4, 'Madhubani'),
(78, 4, 'Munger'),
(79, 4, 'Madhepura'),
(80, 4, 'Muzaffarpur'),
(81, 4, 'Nalanda'),
(82, 4, 'Nawada'),
(83, 4, 'Patna'),
(84, 4, 'Purnia'),
(85, 4, 'Rohtas'),
(86, 4, 'Saharsa'),
(87, 4, 'Samastipur'),
(88, 4, 'Sheohar'),
(89, 4, 'Sheikhpura'),
(90, 4, 'Saran'),
(91, 4, 'Sitamarhi'),
(92, 4, 'Supaul'),
(93, 4, 'Siwan'),
(94, 4, 'Vaishali'),
(95, 4, 'Pashchim Champaran'),
(96, 36, 'Bastar'),
(97, 36, 'Bilaspur'),
(98, 36, 'Dantewada'),
(99, 36, 'Dhamtari'),
(100, 36, 'Durg'),
(101, 36, 'Jashpur'),
(102, 36, 'Janjgir-Champa'),
(103, 36, 'Korba'),
(104, 36, 'Koriya'),
(105, 36, 'Kanker'),
(106, 36, 'Kawardha'),
(107, 36, 'Mahasamund'),
(108, 36, 'Raigarh'),
(109, 36, 'Rajnandgaon'),
(110, 36, 'Raipur'),
(111, 36, 'Surguja'),
(112, 29, 'Diu'),
(113, 29, 'Daman'),
(114, 25, 'Central Delhi'),
(115, 25, 'East Delhi'),
(116, 25, 'New Delhi'),
(117, 25, 'North Delhi'),
(118, 25, 'North East Delhi'),
(119, 25, 'North West Delhi'),
(120, 25, 'South Delhi'),
(121, 25, 'South West Delhi'),
(122, 25, 'West Delhi'),
(123, 26, 'North Goa'),
(124, 26, 'South Goa'),
(125, 5, 'Ahmedabad'),
(126, 5, 'Amreli District'),
(127, 5, 'Anand'),
(128, 5, 'Banaskantha'),
(129, 5, 'Bharuch'),
(130, 5, 'Bhavnagar'),
(131, 5, 'Dahod'),
(132, 5, 'The Dangs'),
(133, 5, 'Gandhinagar'),
(134, 5, 'Jamnagar'),
(135, 5, 'Junagadh'),
(136, 5, 'Kutch'),
(137, 5, 'Kheda'),
(138, 5, 'Mehsana'),
(139, 5, 'Narmada'),
(140, 5, 'Navsari'),
(141, 5, 'Patan'),
(142, 5, 'Panchmahal'),
(143, 5, 'Porbandar'),
(144, 5, 'Rajkot'),
(145, 5, 'Sabarkantha'),
(146, 5, 'Surendranagar'),
(147, 5, 'Surat'),
(148, 5, 'Vadodara'),
(149, 5, 'Valsad'),
(150, 6, 'Ambala'),
(151, 6, 'Bhiwani'),
(152, 6, 'Faridabad'),
(153, 6, 'Fatehabad'),
(154, 6, 'Gurgaon'),
(155, 6, 'Hissar'),
(156, 6, 'Jhajjar'),
(157, 6, 'Jind'),
(158, 6, 'Karnal'),
(159, 6, 'Kaithal'),
(160, 6, 'Kurukshetra'),
(161, 6, 'Mahendragarh'),
(162, 6, 'Mewat'),
(163, 6, 'Panchkula'),
(164, 6, 'Panipat'),
(165, 6, 'Rewari'),
(166, 6, 'Rohtak'),
(167, 6, 'Sirsa'),
(168, 6, 'Sonepat'),
(169, 6, 'Yamuna Nagar'),
(170, 6, 'Palwal'),
(171, 7, 'Bilaspur'),
(172, 7, 'Chamba'),
(173, 7, 'Hamirpur'),
(174, 7, 'Kangra'),
(175, 7, 'Kinnaur'),
(176, 7, 'Kulu'),
(177, 7, 'Lahaul and Spiti'),
(178, 7, 'Mandi'),
(179, 7, 'Shimla'),
(180, 7, 'Sirmaur'),
(181, 7, 'Solan'),
(182, 7, 'Una'),
(183, 8, 'Anantnag'),
(184, 8, 'Badgam'),
(185, 8, 'Bandipore'),
(186, 8, 'Baramula'),
(187, 8, 'Doda'),
(188, 8, 'Jammu'),
(189, 8, 'Kargil'),
(190, 8, 'Kathua'),
(191, 8, 'Kupwara'),
(192, 8, 'Leh'),
(193, 8, 'Poonch'),
(194, 8, 'Pulwama'),
(195, 8, 'Rajauri'),
(196, 8, 'Srinagar'),
(197, 8, 'Samba'),
(198, 8, 'Udhampur'),
(199, 34, 'Bokaro'),
(200, 34, 'Chatra'),
(201, 34, 'Deoghar'),
(202, 34, 'Dhanbad'),
(203, 34, 'Dumka'),
(204, 34, 'Purba Singhbhum'),
(205, 34, 'Garhwa'),
(206, 34, 'Giridih'),
(207, 34, 'Godda'),
(208, 34, 'Gumla'),
(209, 34, 'Hazaribagh'),
(210, 34, 'Koderma'),
(211, 34, 'Lohardaga'),
(212, 34, 'Pakur'),
(213, 34, 'Palamu'),
(214, 34, 'Ranchi'),
(215, 34, 'Sahibganj'),
(216, 34, 'Seraikela and Kharsawan'),
(217, 34, 'Pashchim Singhbhum'),
(218, 34, 'Ramgarh'),
(219, 9, 'Bidar'),
(220, 9, 'Belgaum'),
(221, 9, 'Bijapur'),
(222, 9, 'Bagalkot'),
(223, 9, 'Bellary'),
(224, 9, 'Bangalore Rural District'),
(225, 9, 'Bangalore Urban District'),
(226, 9, 'Chamarajnagar'),
(227, 9, 'Chikmagalur'),
(228, 9, 'Chitradurga'),
(229, 9, 'Davanagere'),
(230, 9, 'Dharwad'),
(231, 9, 'Dakshina Kannada'),
(232, 9, 'Gadag'),
(233, 9, 'Gulbarga'),
(234, 9, 'Hassan'),
(235, 9, 'Haveri District'),
(236, 9, 'Kodagu'),
(237, 9, 'Kolar'),
(238, 9, 'Koppal'),
(239, 9, 'Mandya'),
(240, 9, 'Mysore'),
(241, 9, 'Raichur'),
(242, 9, 'Shimoga'),
(243, 9, 'Tumkur'),
(244, 9, 'Udupi'),
(245, 9, 'Uttara Kannada'),
(246, 9, 'Ramanagara'),
(247, 9, 'Chikballapur'),
(248, 9, 'Yadagiri'),
(249, 10, 'Alappuzha'),
(250, 10, 'Ernakulam'),
(251, 10, 'Idukki'),
(252, 10, 'Kollam'),
(253, 10, 'Kannur'),
(254, 10, 'Kasaragod'),
(255, 10, 'Kottayam'),
(256, 10, 'Kozhikode'),
(257, 10, 'Malappuram'),
(258, 10, 'Palakkad'),
(259, 10, 'Pathanamthitta'),
(260, 10, 'Thrissur'),
(261, 10, 'Thiruvananthapuram'),
(262, 10, 'Wayanad'),
(263, 11, 'Alirajpur'),
(264, 11, 'Anuppur'),
(265, 11, 'Ashok Nagar'),
(266, 11, 'Balaghat'),
(267, 11, 'Barwani'),
(268, 11, 'Betul'),
(269, 11, 'Bhind'),
(270, 11, 'Bhopal'),
(271, 11, 'Burhanpur'),
(272, 11, 'Chhatarpur'),
(273, 11, 'Chhindwara'),
(274, 11, 'Damoh'),
(275, 11, 'Datia'),
(276, 11, 'Dewas'),
(277, 11, 'Dhar'),
(278, 11, 'Dindori'),
(279, 11, 'Guna'),
(280, 11, 'Gwalior'),
(281, 11, 'Harda'),
(282, 11, 'Hoshangabad'),
(283, 11, 'Indore'),
(284, 11, 'Jabalpur'),
(285, 11, 'Jhabua'),
(286, 11, 'Katni'),
(287, 11, 'Khandwa'),
(288, 11, 'Khargone'),
(289, 11, 'Mandla'),
(290, 11, 'Mandsaur'),
(291, 11, 'Morena'),
(292, 11, 'Narsinghpur'),
(293, 11, 'Neemuch'),
(294, 11, 'Panna'),
(295, 11, 'Rewa'),
(296, 11, 'Rajgarh'),
(297, 11, 'Ratlam'),
(298, 11, 'Raisen'),
(299, 11, 'Sagar'),
(300, 11, 'Satna'),
(301, 11, 'Sehore'),
(302, 11, 'Seoni'),
(303, 11, 'Shahdol'),
(304, 11, 'Shajapur'),
(305, 11, 'Sheopur'),
(306, 11, 'Shivpuri'),
(307, 11, 'Sidhi'),
(308, 11, 'Singrauli'),
(309, 11, 'Tikamgarh'),
(310, 11, 'Ujjain'),
(311, 11, 'Umaria'),
(312, 11, 'Vidisha'),
(313, 12, 'Ahmednagar'),
(314, 12, 'Akola'),
(315, 12, 'Amrawati'),
(316, 12, 'Aurangabad'),
(317, 12, 'Bhandara'),
(318, 12, 'Beed'),
(319, 12, 'Buldhana'),
(320, 12, 'Chandrapur'),
(321, 12, 'Dhule'),
(322, 12, 'Gadchiroli'),
(323, 12, 'Gondiya'),
(324, 12, 'Hingoli'),
(325, 12, 'Jalgaon'),
(326, 12, 'Jalna'),
(327, 12, 'Kolhapur'),
(328, 12, 'Latur'),
(329, 12, 'Mumbai City'),
(330, 12, 'Mumbai suburban'),
(331, 12, 'Nandurbar'),
(332, 12, 'Nanded'),
(333, 12, 'Nagpur'),
(334, 12, 'Nashik'),
(335, 12, 'Osmanabad'),
(336, 12, 'Parbhani'),
(337, 12, 'Pune'),
(338, 12, 'Raigad'),
(339, 12, 'Ratnagiri'),
(340, 12, 'Sindhudurg'),
(341, 12, 'Sangli'),
(342, 12, 'Solapur'),
(343, 12, 'Satara'),
(344, 12, 'Thane'),
(345, 12, 'Wardha'),
(346, 12, 'Washim'),
(347, 12, 'Yavatmal'),
(348, 13, 'Bishnupur'),
(349, 13, 'Churachandpur'),
(350, 13, 'Chandel'),
(351, 13, 'Imphal East'),
(352, 13, 'Senapati'),
(353, 13, 'Tamenglong'),
(354, 13, 'Thoubal'),
(355, 13, 'Ukhrul'),
(356, 13, 'Imphal West'),
(357, 14, 'East Garo Hills'),
(358, 14, 'East Khasi Hills'),
(359, 14, 'Jaintia Hills'),
(360, 14, 'Ri-Bhoi'),
(361, 14, 'South Garo Hills'),
(362, 14, 'West Garo Hills'),
(363, 14, 'West Khasi Hills'),
(364, 15, 'Aizawl'),
(365, 15, 'Champhai'),
(366, 15, 'Kolasib'),
(367, 15, 'Lawngtlai'),
(368, 15, 'Lunglei'),
(369, 15, 'Mamit'),
(370, 15, 'Saiha'),
(371, 15, 'Serchhip'),
(372, 16, 'Dimapur'),
(373, 16, 'Kohima'),
(374, 16, 'Mokokchung'),
(375, 16, 'Mon'),
(376, 16, 'Phek'),
(377, 16, 'Tuensang'),
(378, 16, 'Wokha'),
(379, 16, 'Zunheboto'),
(380, 17, 'Angul'),
(381, 17, 'Boudh'),
(382, 17, 'Bhadrak'),
(383, 17, 'Bolangir'),
(384, 17, 'Bargarh'),
(385, 17, 'Baleswar'),
(386, 17, 'Cuttack'),
(387, 17, 'Debagarh'),
(388, 17, 'Dhenkanal'),
(389, 17, 'Ganjam'),
(390, 17, 'Gajapati'),
(391, 17, 'Jharsuguda'),
(392, 17, 'Jajapur'),
(393, 17, 'Jagatsinghpur'),
(394, 17, 'Khordha'),
(395, 17, 'Kendujhar'),
(396, 17, 'Kalahandi'),
(397, 17, 'Kandhamal'),
(398, 17, 'Koraput'),
(399, 17, 'Kendrapara'),
(400, 17, 'Malkangiri'),
(401, 17, 'Mayurbhanj'),
(402, 17, 'Nabarangpur'),
(403, 17, 'Nuapada'),
(404, 17, 'Nayagarh'),
(405, 17, 'Puri'),
(406, 17, 'Rayagada'),
(407, 17, 'Sambalpur'),
(408, 17, 'Subarnapur'),
(409, 17, 'Sundargarh'),
(410, 27, 'Karaikal'),
(411, 27, 'Mahe'),
(412, 27, 'Puducherry'),
(413, 27, 'Yanam'),
(414, 18, 'Amritsar'),
(415, 18, 'Bathinda'),
(416, 18, 'Firozpur'),
(417, 18, 'Faridkot'),
(418, 18, 'Fatehgarh Sahib'),
(419, 18, 'Gurdaspur'),
(420, 18, 'Hoshiarpur'),
(421, 18, 'Jalandhar'),
(422, 18, 'Kapurthala'),
(423, 18, 'Ludhiana'),
(424, 18, 'Mansa'),
(425, 18, 'Moga'),
(426, 18, 'Mukatsar'),
(427, 18, 'Nawan Shehar'),
(428, 18, 'Patiala'),
(429, 18, 'Rupnagar'),
(430, 18, 'Sangrur'),
(431, 19, 'Ajmer'),
(432, 19, 'Alwar'),
(433, 19, 'Bikaner'),
(434, 19, 'Barmer'),
(435, 19, 'Banswara'),
(436, 19, 'Bharatpur'),
(437, 19, 'Baran'),
(438, 19, 'Bundi'),
(439, 19, 'Bhilwara'),
(440, 19, 'Churu'),
(441, 19, 'Chittorgarh'),
(442, 19, 'Dausa'),
(443, 19, 'Dholpur'),
(444, 19, 'Dungapur'),
(445, 19, 'Ganganagar'),
(446, 19, 'Hanumangarh'),
(447, 19, 'Juhnjhunun'),
(448, 19, 'Jalore'),
(449, 19, 'Jodhpur'),
(450, 19, 'Jaipur'),
(451, 19, 'Jaisalmer'),
(452, 19, 'Jhalawar'),
(453, 19, 'Karauli'),
(454, 19, 'Kota'),
(455, 19, 'Nagaur'),
(456, 19, 'Pali'),
(457, 19, 'Pratapgarh'),
(458, 19, 'Rajsamand'),
(459, 19, 'Sikar'),
(460, 19, 'Sawai Madhopur'),
(461, 19, 'Sirohi'),
(462, 19, 'Tonk'),
(463, 19, 'Udaipur'),
(464, 20, 'East Sikkim'),
(465, 20, 'North Sikkim'),
(466, 20, 'South Sikkim'),
(467, 20, 'West Sikkim'),
(468, 21, 'Ariyalur'),
(469, 21, 'Chennai'),
(470, 21, 'Coimbatore'),
(471, 21, 'Cuddalore'),
(472, 21, 'Dharmapuri'),
(473, 21, 'Dindigul'),
(474, 21, 'Erode'),
(475, 21, 'Kanchipuram'),
(476, 21, 'Kanyakumari'),
(477, 21, 'Karur'),
(478, 21, 'Madurai'),
(479, 21, 'Nagapattinam'),
(480, 21, 'The Nilgiris'),
(481, 21, 'Namakkal'),
(482, 21, 'Perambalur'),
(483, 21, 'Pudukkottai'),
(484, 21, 'Ramanathapuram'),
(485, 21, 'Salem'),
(486, 21, 'Sivagangai'),
(487, 21, 'Tiruppur'),
(488, 21, 'Tiruchirappalli'),
(489, 21, 'Theni'),
(490, 21, 'Tirunelveli'),
(491, 21, 'Thanjavur'),
(492, 21, 'Thoothukudi'),
(493, 21, 'Thiruvallur'),
(494, 21, 'Thiruvarur'),
(495, 21, 'Tiruvannamalai'),
(496, 21, 'Vellore'),
(497, 21, 'Villupuram'),
(498, 22, 'Dhalai'),
(499, 22, 'North Tripura'),
(500, 22, 'South Tripura'),
(501, 22, 'West Tripura'),
(502, 33, 'Almora'),
(503, 33, 'Bageshwar'),
(504, 33, 'Chamoli'),
(505, 33, 'Champawat'),
(506, 33, 'Dehradun'),
(507, 33, 'Haridwar'),
(508, 33, 'Nainital'),
(509, 33, 'Pauri Garhwal'),
(510, 33, 'Pithoragharh'),
(511, 33, 'Rudraprayag'),
(512, 33, 'Tehri Garhwal'),
(513, 33, 'Udham Singh Nagar'),
(514, 33, 'Uttarkashi'),
(515, 23, 'Agra'),
(516, 23, 'Allahabad'),
(517, 23, 'Aligarh'),
(518, 23, 'Ambedkar Nagar'),
(519, 23, 'Auraiya'),
(520, 23, 'Azamgarh'),
(521, 23, 'Barabanki'),
(522, 23, 'Badaun'),
(523, 23, 'Bagpat'),
(524, 23, 'Bahraich'),
(525, 23, 'Bijnor'),
(526, 23, 'Ballia'),
(527, 23, 'Banda'),
(528, 23, 'Balrampur'),
(529, 23, 'Bareilly'),
(530, 23, 'Basti'),
(531, 23, 'Bulandshahr'),
(532, 23, 'Chandauli'),
(533, 23, 'Chitrakoot'),
(534, 23, 'Deoria'),
(535, 23, 'Etah'),
(536, 23, 'Kanshiram Nagar'),
(537, 23, 'Etawah'),
(538, 23, 'Firozabad'),
(539, 23, 'Farrukhabad'),
(540, 23, 'Fatehpur'),
(541, 23, 'Faizabad'),
(542, 23, 'Gautam Buddha Nagar'),
(543, 23, 'Gonda'),
(544, 23, 'Ghazipur'),
(545, 23, 'Gorkakhpur'),
(546, 23, 'Ghaziabad'),
(547, 23, 'Hamirpur'),
(548, 23, 'Hardoi'),
(549, 23, 'Mahamaya Nagar'),
(550, 23, 'Jhansi'),
(551, 23, 'Jalaun'),
(552, 23, 'Jyotiba Phule Nagar'),
(553, 23, 'Jaunpur District'),
(554, 23, 'Kanpur Dehat'),
(555, 23, 'Kannauj'),
(556, 23, 'Kanpur Nagar'),
(557, 23, 'Kaushambi'),
(558, 23, 'Kushinagar'),
(559, 23, 'Lalitpur'),
(560, 23, 'Lakhimpur Kheri'),
(561, 23, 'Lucknow'),
(562, 23, 'Mau'),
(563, 23, 'Meerut'),
(564, 23, 'Maharajganj'),
(565, 23, 'Mahoba'),
(566, 23, 'Mirzapur'),
(567, 23, 'Moradabad'),
(568, 23, 'Mainpuri'),
(569, 23, 'Mathura'),
(570, 23, 'Muzaffarnagar'),
(571, 23, 'Pilibhit'),
(572, 23, 'Pratapgarh'),
(573, 23, 'Rampur'),
(574, 23, 'Rae Bareli'),
(575, 23, 'Saharanpur'),
(576, 23, 'Sitapur'),
(577, 23, 'Shahjahanpur'),
(578, 23, 'Sant Kabir Nagar'),
(579, 23, 'Siddharthnagar'),
(580, 23, 'Sonbhadra'),
(581, 23, 'Sant Ravidas Nagar'),
(582, 23, 'Sultanpur'),
(583, 23, 'Shravasti'),
(584, 23, 'Unnao'),
(585, 23, 'Varanasi'),
(586, 24, 'Birbhum'),
(587, 24, 'Bankura'),
(588, 24, 'Bardhaman'),
(589, 24, 'Darjeeling'),
(590, 24, 'Dakshin Dinajpur'),
(591, 24, 'Hooghly'),
(592, 24, 'Howrah'),
(593, 24, 'Jalpaiguri'),
(594, 24, 'Cooch Behar'),
(595, 24, 'Kolkata'),
(596, 24, 'Malda'),
(597, 24, 'Midnapore'),
(598, 24, 'Murshidabad'),
(599, 24, 'Nadia'),
(600, 24, 'North 24 Parganas'),
(601, 24, 'South 24 Parganas'),
(602, 24, 'Purulia'),
(603, 24, 'Uttar Dinajpur');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_doctor`
--

CREATE TABLE `tbl_doctor` (
  `doctor_id` int(11) NOT NULL,
  `login_id` int(11) NOT NULL,
  `doctor_first_name` varchar(50) NOT NULL,
  `doctor_last_name` varchar(50) NOT NULL,
  `address` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `phone_number` bigint(20) DEFAULT NULL,
  `district_id` int(11) NOT NULL,
  `place` varchar(50) NOT NULL,
  `medical_speciality_id` int(11) NOT NULL,
  `qualification` varchar(50) DEFAULT NULL,
  `photo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_doctor`
--

INSERT INTO `tbl_doctor` (`doctor_id`, `login_id`, `doctor_first_name`, `doctor_last_name`, `address`, `email`, `phone_number`, `district_id`, `place`, `medical_speciality_id`, `qualification`, `photo`) VALUES
(1, 1, 'Juwan', 'Thomas', 'Juwan Villa', 'juwan@gmail.com', 8789765434, 259, 'Adoor', 1, 'MBBS MS', '/media/42..jpg'),
(2, 2, 'Jeevan', 'Joseph', 'Jeevan Villa', 'jeevan@gmail.com', 8789765434, 259, 'Adoor', 2, 'MBBS MS', '/media/43..jpg');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_feedback`
--

CREATE TABLE `tbl_feedback` (
  `feedback_id` int(11) NOT NULL,
  `feedback` varchar(150) NOT NULL,
  `user_login_id` int(11) NOT NULL,
  `reply` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_feedback`
--

INSERT INTO `tbl_feedback` (`feedback_id`, `feedback`, `user_login_id`, `reply`) VALUES
(1, 'Good Service', 5, 'No');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_insurance`
--

CREATE TABLE `tbl_insurance` (
  `insurance_id` int(11) NOT NULL,
  `insuarnce_company` varchar(50) NOT NULL,
  `description` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_insurance`
--

INSERT INTO `tbl_insurance` (`insurance_id`, `insuarnce_company`, `description`) VALUES
(1, 'Star Health Family', 'Cover your entire family under a single health plan. When it comes to protecting your family, nothing you do is considered too much. You take extra care in everything, be it ensuring that your children get the best education or taking care of your aged parents and loving spouse, ');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_lab`
--

CREATE TABLE `tbl_lab` (
  `lab_id` int(11) NOT NULL,
  `login_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `phone_number` bigint(20) DEFAULT NULL,
  `place` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_lab`
--

INSERT INTO `tbl_lab` (`lab_id`, `login_id`, `name`, `address`, `email`, `phone_number`, `place`) VALUES
(1, 3, 'Thriveni', 'Thriveni Villa', 'triveni@gmail.com', 8948848484, 'Adoor');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_lab_test`
--

CREATE TABLE `tbl_lab_test` (
  `lab_test_id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `result` varchar(50) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `entry_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_lab_test`
--

INSERT INTO `tbl_lab_test` (`lab_test_id`, `appointment_id`, `test_id`, `status`, `result`, `description`, `entry_date`) VALUES
(1, 10, 1, 'Result is prepared', '/media/45..pdf', 'gAAAAABm6TmPQs_DROefx6xnAKCI-5bwyeMT2_uJgmfHHhNZ-hdoD26vi0CwvU05ciO8mWKYzEJ_DJLUSbEStlZMP3gMOsRmo-AK-WCrwD9fS3SOVYkSh-M=', '2024-09-17 13:37:28.471202'),
(2, 10, 2, 'Result is prepared', '/media/46..pdf', 'gAAAAABm6TmfLfUGDT6QaxpT7UW0xZBSgiLMOPDSwY5prDPWFqJsWec2N7EZ0yM-B7XWm5x9fvMF3jzuhbz6_2KzzmHMbRYIPnV2FpCIYscZgYdFEuuHLv0=', '2024-09-17 13:37:28.471202'),
(3, 10, 3, 'Result is prepared', '/media/47..pdf', 'gAAAAABm6TnAK69NvTIoRBQ_crdWxpnyOdICjDk6B5XYoO3W7_Spei_0vLThQS5e_VDP4cdPNZ2jIcVM3duYyFbO4RKyLEKeyA==', '2024-09-17 13:37:28.471202'),
(4, 6, 1, 'Result is not Prepared', NULL, NULL, '2024-09-19 16:40:55.786270'),
(5, 6, 2, 'Result is not Prepared', NULL, NULL, '2024-09-19 16:40:55.801921'),
(6, 6, 1, 'Result is not Prepared', NULL, NULL, '2024-09-19 16:43:51.266133'),
(7, 6, 2, 'Result is not Prepared', NULL, NULL, '2024-09-19 16:43:51.266133'),
(8, 6, 1, 'Result is not Prepared', NULL, NULL, '2024-09-19 16:46:12.131342'),
(9, 6, 2, 'Result is not Prepared', NULL, NULL, '2024-09-19 16:46:12.131342');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_lab_test_type`
--

CREATE TABLE `tbl_lab_test_type` (
  `lab_test_type_id` int(11) NOT NULL,
  `tests` varchar(50) NOT NULL,
  `lab_login_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_lab_test_type`
--

INSERT INTO `tbl_lab_test_type` (`lab_test_type_id`, `tests`, `lab_login_id`) VALUES
(1, 'Blood count (CBC)', 3),
(2, 'Nutritional deficiencies, such as vitamin B6 or B1', 3),
(3, 'Basic metabolic panel (BMP)', 3),
(4, 'Comprehensive metabolic panel (CMP)', 3),
(5, 'HDL', 3),
(6, 'LDL', 3),
(7, 'FBS and PPBS test', 3),
(9, 'ddd', 3);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_login`
--

CREATE TABLE `tbl_login` (
  `login_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` longtext DEFAULT NULL,
  `Usertype` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_login`
--

INSERT INTO `tbl_login` (`login_id`, `username`, `password`, `Usertype`, `status`) VALUES
(1, 'juwan123', 'pbkdf2_sha256$720000$mySalt$QqhxvWock4Vfmn8tZrqjL6PqlREbm1zOCgcnZzwktp4=', 'Doctor', 'Approved'),
(2, 'jeevan123', 'pbkdf2_sha256$720000$mySalt$NCERKzd2BZWmnqQbSthhKgog3Kg9pHZiJ1AuzyHu6D4=', 'Doctor', 'Approved'),
(3, 'thriveni123', 'pbkdf2_sha256$720000$mySalt$R6JRrwe5Mq+t9kTPP3xK1hm2dBkjnH/2nk5wSsfgQBM=', 'Lab', 'Approved'),
(5, 'divya123', 'pbkdf2_sha256$720000$mySalt$Ty30kPSDtdyuFkM8FIdGRdhieZtUaqdOOm36OvteuJA=', 'Patient', 'Approved'),
(6, 'divya1234', 'pbkdf2_sha256$720000$mySalt$Ty30kPSDtdyuFkM8FIdGRdhieZtUaqdOOm36OvteuJA=', 'Patient', 'Approved'),
(8, 'jain123', 'pbkdf2_sha256$720000$mySalt$P3CwCUvqP/vf+B8wursJa6a62GYeiE4/TYfDUwog+RI=', 'Patient', 'Approved'),
(10, 'jithin123', 'pbkdf2_sha256$720000$mySalt$DEZA5MIShEp7AGU33aZ8GqLN2Y//yYyRtpQygGL37vM=', 'Patient', 'Approved'),
(11, 'justin123', 'pbkdf2_sha256$720000$mySalt$d6wETiVVwhLG8vaH3m16lAQnw98uFO/P5vLoPsAp3g4=', 'Patient', 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_medical_speciality`
--

CREATE TABLE `tbl_medical_speciality` (
  `medical_speciality_id` int(11) NOT NULL,
  `speciality` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_medical_speciality`
--

INSERT INTO `tbl_medical_speciality` (`medical_speciality_id`, `speciality`) VALUES
(1, 'Orthopedics'),
(2, 'Internal Medicine'),
(3, 'Obstetrics and Gynecology'),
(4, 'Dermatology'),
(5, 'Pediatrics'),
(6, 'Radiology'),
(7, 'General Surgery'),
(8, 'Ophthalmology'),
(9, 'Cardiology'),
(10, 'Endocrinology'),
(11, 'Gastroenterology'),
(12, 'Nephrology'),
(13, 'Urology'),
(14, 'Pulmonology'),
(15, 'Otolaryngology - ENT'),
(16, 'Neurology'),
(17, 'Psychiatrists'),
(18, 'Oncology'),
(19, 'Radiology'),
(20, 'Rheumatology'),
(21, 'General surgeons'),
(22, 'Orthopedic surgeons'),
(23, 'Cardiac surgeons'),
(24, 'Anesthesiologist'),
(26, 'Orthopedics'),
(27, 'Internal Medicine'),
(28, 'Obstetrics and Gynecology'),
(29, 'Dermatology'),
(30, 'Pediatrics'),
(31, 'Radiology'),
(32, 'General Surgery'),
(33, 'Ophthalmology'),
(34, 'Cardiology'),
(35, 'Endocrinology'),
(36, 'Gastroenterology'),
(37, 'Nephrology'),
(38, 'Urology'),
(39, 'Pulmonology'),
(40, 'Otolaryngology - ENT'),
(41, 'Neurology'),
(42, 'Psychiatrists'),
(43, 'Oncology'),
(44, 'Radiology'),
(45, 'Rheumatology'),
(46, 'General surgeons'),
(47, 'Orthopedic surgeons'),
(48, 'Cardiac surgeons'),
(49, 'Anesthesiologist');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_patient`
--

CREATE TABLE `tbl_patient` (
  `patient_id` int(11) NOT NULL,
  `login_id` int(11) NOT NULL,
  `patient_name` varchar(50) DEFAULT NULL,
  `phone_number` bigint(20) DEFAULT NULL,
  `Address` longtext NOT NULL,
  `district_id` int(11) NOT NULL,
  `place` varchar(50) DEFAULT NULL,
  `dob` date NOT NULL,
  `entry_date` datetime(6) NOT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_patient`
--

INSERT INTO `tbl_patient` (`patient_id`, `login_id`, `patient_name`, `phone_number`, `Address`, `district_id`, `place`, `dob`, `entry_date`, `email`) VALUES
(1, 5, 'Divya', 9865457852, 'Divya Bhavan', 259, 'Adoor', '2005-09-14', '2024-09-17 12:23:47.300208', 'phebaebenezer@gmail.com'),
(2, 6, 'Divya', 6789765678, 'Divya Villa', 259, 'Adoor', '2015-09-08', '2024-09-17 12:25:31.405826', 'phebaebenezer@gmail.com'),
(4, 8, 'Jain', 6767898767, 'Jain Villa', 259, 'Adoor', '2024-09-18', '2024-09-18 13:33:23.255612', 'phebaebenezer@gmail.com'),
(6, 10, 'Jithin', 8787678987, 'Jithin Villa', 259, 'Adoor', '2024-09-18', '2024-09-18 13:44:01.417837', 'phebaebenezer@gmail.com'),
(7, 11, 'Justin', 8956365241, 'Justin Villa', 259, 'Adoor', '2024-09-18', '2024-09-18 13:51:23.152866', 'phebaebenezer@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_prescription`
--

CREATE TABLE `tbl_prescription` (
  `prescription_id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `visiting_date` date NOT NULL,
  `symptoms` longtext NOT NULL,
  `medicine` longtext NOT NULL,
  `uses` longtext NOT NULL,
  `details` longtext NOT NULL,
  `entry_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_prescription`
--

INSERT INTO `tbl_prescription` (`prescription_id`, `appointment_id`, `visiting_date`, `symptoms`, `medicine`, `uses`, `details`, `entry_date`) VALUES
(1, 10, '2024-09-17', 'gAAAAABm6TjA9M2pfbEfk3Y-V_lSrxskIioHc88mZjRU4lwmGNVV3eSFQyUdFRz58kcP6InDQPZonwUC9nfwCkK3eH3poaw-ew==', 'gAAAAABm6TjA9f_-HIuofpTkiBAx0Ec_Kz_8u3o2fztxi9dePo7s_F7BwS446r1FuBOdN8jkmd63QAv2d39LxnobRMyB0Vidlg==', 'gAAAAABm6TjACm8DNDhOGLBRcBguA9GWbh8y4MW6yqjAKwyGe0C_FI8WojeSIHmwB63XI-xoopP6d2uDyM3QWnZUWi0MhpYb1w==', 'gAAAAABm6TjA5bHAyYcPh8indmqankHi6a8RwHbRYEoxDN68yPr06IJY6Gu8OfTRPPppqq31J6Wga83b_GoLdGfgOSbiVaEpAw==', '2024-09-17 13:37:28.471202'),
(4, 6, '2024-09-19', 'gAAAAABm7Af8nFCv40qqSBFhsvPjjMA6D-LUg9XjXDJ9wrqTFg707qg6riL1wka3-yw6NjlFE8NNXRVX8tPBpJrp28X7_WuljK_5tL_m4jaVDeoUF5Zo7p4=', 'gAAAAABm7Af8lOp7tXRy28xIhmEoBtfLnMyBEgXz6qneuAMjhXx8ZMLJnSkOAKMcizLvZWl2Xny9NotyOjFvu2oSLAAXoejdZw==', 'gAAAAABm7Af8EvDTHIiXnMyxVBbGl1C3gjatci1Px_jmhSm_L8UgW8uoY63g0R95dLiEG8NrtOR11owl94FCGhMU_bdUc7dPyQ==', 'gAAAAABm7Af8v42Zcgc1O2KqJKQyUpMoGYfDcGlu0wefxKH4toK6VQCrEdE8LAK1ad5nxE1LicDfbZ4hNMqhUdV2GktX7DbkwA==', '2024-09-19 16:46:12.083242');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_state`
--

CREATE TABLE `tbl_state` (
  `state_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `state` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_state`
--

INSERT INTO `tbl_state` (`state_id`, `country_id`, `state`) VALUES
(1, 105, 'ANDHRA PRADESH'),
(2, 105, 'ASSAM'),
(3, 105, 'ARUNACHAL PRADESH'),
(4, 105, 'BIHAR'),
(5, 105, 'GUJRAT'),
(6, 105, 'HARYANA'),
(7, 105, 'HIMACHAL PRADESH'),
(8, 105, 'JAMMU & KASHMIR'),
(9, 105, 'KARNATAKA'),
(10, 105, 'KERALA'),
(11, 105, 'MADHYA PRADESH'),
(12, 105, 'MAHARASHTRA'),
(13, 105, 'MANIPUR'),
(14, 105, 'MEGHALAYA'),
(15, 105, 'MIZORAM'),
(16, 105, 'NAGALAND'),
(17, 105, 'ORISSA'),
(18, 105, 'PUNJAB'),
(19, 105, 'RAJASTHAN'),
(20, 105, 'SIKKIM'),
(21, 105, 'TAMIL NADU'),
(22, 105, 'TRIPURA'),
(23, 105, 'UTTAR PRADESH'),
(24, 105, 'WEST BENGAL'),
(25, 105, 'DELHI'),
(26, 105, 'GOA'),
(27, 105, 'PONDICHERY'),
(28, 105, 'LAKSHDWEEP'),
(29, 105, 'DAMAN & DIU'),
(30, 105, 'DADRA & NAGAR'),
(31, 105, 'CHANDIGARH'),
(32, 105, 'ANDAMAN & NICOBAR'),
(33, 105, 'UTTARANCHAL'),
(34, 105, 'JHARKHAND'),
(35, 105, 'CHATTISGARH');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `tbl_appointment`
--
ALTER TABLE `tbl_appointment`
  ADD PRIMARY KEY (`appointment_id`);

--
-- Indexes for table `tbl_complaint`
--
ALTER TABLE `tbl_complaint`
  ADD PRIMARY KEY (`complaint_id`);

--
-- Indexes for table `tbl_district`
--
ALTER TABLE `tbl_district`
  ADD PRIMARY KEY (`district_id`);

--
-- Indexes for table `tbl_doctor`
--
ALTER TABLE `tbl_doctor`
  ADD PRIMARY KEY (`doctor_id`);

--
-- Indexes for table `tbl_feedback`
--
ALTER TABLE `tbl_feedback`
  ADD PRIMARY KEY (`feedback_id`);

--
-- Indexes for table `tbl_insurance`
--
ALTER TABLE `tbl_insurance`
  ADD PRIMARY KEY (`insurance_id`);

--
-- Indexes for table `tbl_lab`
--
ALTER TABLE `tbl_lab`
  ADD PRIMARY KEY (`lab_id`);

--
-- Indexes for table `tbl_lab_test`
--
ALTER TABLE `tbl_lab_test`
  ADD PRIMARY KEY (`lab_test_id`);

--
-- Indexes for table `tbl_lab_test_type`
--
ALTER TABLE `tbl_lab_test_type`
  ADD PRIMARY KEY (`lab_test_type_id`);

--
-- Indexes for table `tbl_login`
--
ALTER TABLE `tbl_login`
  ADD PRIMARY KEY (`login_id`);

--
-- Indexes for table `tbl_medical_speciality`
--
ALTER TABLE `tbl_medical_speciality`
  ADD PRIMARY KEY (`medical_speciality_id`);

--
-- Indexes for table `tbl_patient`
--
ALTER TABLE `tbl_patient`
  ADD PRIMARY KEY (`patient_id`);

--
-- Indexes for table `tbl_prescription`
--
ALTER TABLE `tbl_prescription`
  ADD PRIMARY KEY (`prescription_id`);

--
-- Indexes for table `tbl_state`
--
ALTER TABLE `tbl_state`
  ADD PRIMARY KEY (`state_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `tbl_appointment`
--
ALTER TABLE `tbl_appointment`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tbl_complaint`
--
ALTER TABLE `tbl_complaint`
  MODIFY `complaint_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_district`
--
ALTER TABLE `tbl_district`
  MODIFY `district_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=604;

--
-- AUTO_INCREMENT for table `tbl_doctor`
--
ALTER TABLE `tbl_doctor`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_feedback`
--
ALTER TABLE `tbl_feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_insurance`
--
ALTER TABLE `tbl_insurance`
  MODIFY `insurance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_lab`
--
ALTER TABLE `tbl_lab`
  MODIFY `lab_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_lab_test`
--
ALTER TABLE `tbl_lab_test`
  MODIFY `lab_test_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tbl_lab_test_type`
--
ALTER TABLE `tbl_lab_test_type`
  MODIFY `lab_test_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tbl_login`
--
ALTER TABLE `tbl_login`
  MODIFY `login_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tbl_medical_speciality`
--
ALTER TABLE `tbl_medical_speciality`
  MODIFY `medical_speciality_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `tbl_patient`
--
ALTER TABLE `tbl_patient`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_prescription`
--
ALTER TABLE `tbl_prescription`
  MODIFY `prescription_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_state`
--
ALTER TABLE `tbl_state`
  MODIFY `state_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
