-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 28, 2025 at 12:35 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `complaints_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `id` int(11) NOT NULL,
  `citizen_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `status` enum('registered','in_progress','solved','referred') DEFAULT 'registered',
  `priority` enum('top','medium','normal','low') DEFAULT 'normal',
  `officer_id` int(11) DEFAULT NULL,
  `dept_head_id` int(11) DEFAULT NULL,
  `referred_by` int(11) DEFAULT NULL,
  `referred_at` timestamp NULL DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `response` text DEFAULT NULL,
  `review_rating` int(11) DEFAULT NULL,
  `review_feedback` text DEFAULT NULL,
  `ai_summary_complaint` text DEFAULT NULL,
  `ai_summary_response` text DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `target_role` enum('officer','dept_head') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`id`, `citizen_id`, `department_id`, `title`, `description`, `status`, `priority`, `officer_id`, `dept_head_id`, `referred_by`, `referred_at`, `remarks`, `response`, `review_rating`, `review_feedback`, `ai_summary_complaint`, `ai_summary_response`, `target_id`, `target_role`, `created_at`, `updated_at`) VALUES
(1, 4, 1, 'water shortage', 'water not coming from 1 week', 'referred', 'normal', 5, 2, 3, '2025-03-28 11:31:04', 'i am busy', NULL, NULL, NULL, NULL, NULL, 0, '', '2025-03-28 07:54:46', '2025-03-28 11:31:04'),
(2, 4, 1, 'water', 'water shortage', 'solved', 'normal', 3, 2, NULL, NULL, 'tanker sent and apologies', 'water tanker sent', NULL, NULL, NULL, NULL, 0, '', '2025-03-28 08:40:39', '2025-03-28 08:55:19'),
(3, 4, 1, 'water', 'water shortage', 'referred', 'normal', 3, 2, 5, '2025-03-28 08:59:25', 'not my dept', NULL, NULL, NULL, NULL, NULL, 0, '', '2025-03-28 08:56:25', '2025-03-28 08:59:25'),
(4, 4, 1, 'water', 'water shortage', 'solved', 'normal', 3, 2, NULL, NULL, 'water tanker sent and apollogies', 'water tanker sent', NULL, NULL, NULL, NULL, 0, '', '2025-03-28 08:56:42', '2025-03-28 11:31:29'),
(5, 4, 1, 'water shortage', 'water shortage since 1  week', 'referred', 'normal', 5, 2, 3, '2025-03-28 11:30:51', 'i am busy', NULL, NULL, NULL, NULL, NULL, 0, '', '2025-03-28 11:29:11', '2025-03-28 11:30:51');

-- --------------------------------------------------------

--
-- Table structure for table `complaint_activity`
--

CREATE TABLE `complaint_activity` (
  `id` int(11) NOT NULL,
  `complaint_id` int(11) NOT NULL,
  `activity` varchar(255) NOT NULL,
  `activity_by` int(11) NOT NULL,
  `activity_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `complaint_activity`
--

INSERT INTO `complaint_activity` (`id`, `complaint_id`, `activity`, `activity_by`, `activity_time`) VALUES
(1, 2, 'Complaint Registered', 4, '2025-03-28 08:40:39'),
(2, 2, 'Assigned to Officer', 2, '2025-03-28 08:45:44'),
(3, 2, 'Complaint Solved by Officer', 3, '2025-03-28 08:55:19'),
(4, 3, 'Complaint Registered', 4, '2025-03-28 08:56:25'),
(5, 4, 'Complaint Registered', 4, '2025-03-28 08:56:42'),
(6, 4, 'Assigned to Officer', 2, '2025-03-28 08:57:44'),
(7, 3, 'Assigned to Officer', 2, '2025-03-28 08:58:23'),
(8, 1, 'Assigned to Officer', 2, '2025-03-28 08:58:45'),
(9, 3, 'Complaint Referred to Officer', 5, '2025-03-28 08:59:25'),
(10, 5, 'Complaint Registered', 4, '2025-03-28 11:29:11'),
(11, 5, 'Assigned to Officer', 2, '2025-03-28 11:30:10'),
(12, 5, 'Complaint Referred to Officer', 3, '2025-03-28 11:30:51'),
(13, 1, 'Complaint Referred to Officer', 3, '2025-03-28 11:31:04'),
(14, 4, 'Complaint Solved by Officer', 3, '2025-03-28 11:31:29');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `description`, `created_at`) VALUES
(1, 'water', 'dams and irrigation', '2025-03-28 07:40:45');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('citizen','officer','dept_head','admin') NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `department_id`, `created_at`) VALUES
(1, 'het', 'het@doctor.com', '$2y$10$A6HVQIUi89rIeEMwsSRxrOKTA8fraFnvLA9qdlt1AYiMSAihBX/xi', 'admin', NULL, '2025-03-28 07:40:24'),
(2, 'manthan', 'hetvyas02@gmail.com', '$2y$10$KV58HqfSX0yKyXvc79ZbcOAhV.1NuzZ0OrEYKoVx/3Y8KEnSPj.wq', 'dept_head', 1, '2025-03-28 07:41:02'),
(3, 'dhruv', 'hetvyas@gmail.com', '$2y$10$XBiHDElNDEZarsaXvFA9X.iGHYvxj/9HEZfw1MeacQjMubghWSUZm', 'officer', 1, '2025-03-28 07:41:22'),
(4, 'het', 'het@mail.com', '$2y$10$A6HVQIUi89rIeEMwsSRxrOKTA8fraFnvLA9qdlt1AYiMSAihBX/xi', 'citizen', NULL, '2025-03-28 07:53:45'),
(5, 'manthan1', 'manthan@gm.co', '$2y$10$Y5YawmNM0ezjH9RfsiRi/.nAy6kD3k0Fbd9a.UQAUgCv6s/zcKiJG', 'officer', 1, '2025-03-28 08:58:04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizen_id` (`citizen_id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `officer_id` (`officer_id`),
  ADD KEY `dept_head_id` (`dept_head_id`),
  ADD KEY `referred_by` (`referred_by`);

--
-- Indexes for table `complaint_activity`
--
ALTER TABLE `complaint_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `complaint_id` (`complaint_id`),
  ADD KEY `activity_by` (`activity_by`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `department_id` (`department_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `complaint_activity`
--
ALTER TABLE `complaint_activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `complaints_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `complaints_ibfk_3` FOREIGN KEY (`officer_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `complaints_ibfk_4` FOREIGN KEY (`dept_head_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `complaints_ibfk_5` FOREIGN KEY (`referred_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `complaint_activity`
--
ALTER TABLE `complaint_activity`
  ADD CONSTRAINT `complaint_activity_ibfk_1` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`),
  ADD CONSTRAINT `complaint_activity_ibfk_2` FOREIGN KEY (`activity_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
