-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 19, 2023 at 07:53 AM
-- Server version: 5.7.39-log
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mdik_tgp_2`
--

-- --------------------------------------------------------

--
-- Table structure for table `films`
--

CREATE TABLE `films` (
  `_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `poster_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `runtime` float DEFAULT '0',
  `ratingValue` float DEFAULT NULL,
  `summary_text` text COLLATE utf8mb4_unicode_ci,
  `ratingCount` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `film_casts`
--

CREATE TABLE `film_casts` (
  `film_cast_id` bigint(20) UNSIGNED NOT NULL,
  `_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `film_directors`
--

CREATE TABLE `film_directors` (
  `film_director_id` bigint(20) UNSIGNED NOT NULL,
  `_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `film_genres`
--

CREATE TABLE `film_genres` (
  `film_genre_id` bigint(20) UNSIGNED NOT NULL,
  `_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `films`
--
ALTER TABLE `films`
  ADD PRIMARY KEY (`_id`);

--
-- Indexes for table `film_casts`
--
ALTER TABLE `film_casts`
  ADD PRIMARY KEY (`film_cast_id`),
  ADD KEY `film_casts__id_foreign` (`_id`);

--
-- Indexes for table `film_directors`
--
ALTER TABLE `film_directors`
  ADD PRIMARY KEY (`film_director_id`),
  ADD KEY `film_directors__id_foreign` (`_id`);

--
-- Indexes for table `film_genres`
--
ALTER TABLE `film_genres`
  ADD PRIMARY KEY (`film_genre_id`),
  ADD KEY `film_genres__id_foreign` (`_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `film_casts`
--
ALTER TABLE `film_casts`
  MODIFY `film_cast_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `film_directors`
--
ALTER TABLE `film_directors`
  MODIFY `film_director_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `film_genres`
--
ALTER TABLE `film_genres`
  MODIFY `film_genre_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `film_casts`
--
ALTER TABLE `film_casts`
  ADD CONSTRAINT `film_casts__id_foreign` FOREIGN KEY (`_id`) REFERENCES `films` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `film_directors`
--
ALTER TABLE `film_directors`
  ADD CONSTRAINT `film_directors__id_foreign` FOREIGN KEY (`_id`) REFERENCES `films` (`_id`) ON DELETE CASCADE;

--
-- Constraints for table `film_genres`
--
ALTER TABLE `film_genres`
  ADD CONSTRAINT `film_genres__id_foreign` FOREIGN KEY (`_id`) REFERENCES `films` (`_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
