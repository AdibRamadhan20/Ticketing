-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 08 Jul 2025 pada 16.54
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ticketing`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `balance_transactions`
--

CREATE TABLE `balance_transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `transaction_type` enum('topup','purchase','refund','adjustment') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `related_order_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `transaction_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `seat_number` varchar(10) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `customer_phone` varchar(20) NOT NULL,
  `customer_email` varchar(100) NOT NULL,
  `customer_address` text NOT NULL,
  `total_price_at_purchase` decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT 'Price of one ticket unit at the time of purchase',
  `order_status` enum('booked','cancelled','completed') NOT NULL DEFAULT 'booked',
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `cancelled_at` timestamp NULL DEFAULT NULL,
  `status` enum('pending','confirmed','cancelled') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengaduan`
--

CREATE TABLE `pengaduan` (
  `id` int(11) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `kontak` varchar(100) NOT NULL,
  `tanggal_pemesanan` date NOT NULL,
  `jenis_tiket` enum('pesawat','kapal','kereta','penginapan','kendaraan','event','lainnya') NOT NULL,
  `nama_penumpang` varchar(100) NOT NULL,
  `jenis_pengaduan` enum('Tiket tidak diterima','Pembayaran gagal tapi saldo terpotong','Kesalahan data tiket','Perubahan jadwal sepihak','Pembatalan sepihak','Tiket tidak dapat digunakan saat hari H','Layanan CS tidak responsif') NOT NULL,
  `deskripsi` text NOT NULL,
  `harapan` varchar(255) NOT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `seats`
--

CREATE TABLE `seats` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `seat_number` varchar(10) NOT NULL,
  `is_booked` tinyint(1) NOT NULL DEFAULT 0,
  `order_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `seats`
--

INSERT INTO `seats` (`id`, `ticket_id`, `seat_number`, `is_booked`, `order_id`) VALUES
(509, 33, '1', 0, NULL),
(510, 33, '2', 0, NULL),
(511, 33, '3', 0, NULL),
(512, 33, '4', 0, NULL),
(513, 33, '5', 0, NULL),
(514, 33, '6', 0, NULL),
(515, 33, '7', 0, NULL),
(516, 33, '8', 0, NULL),
(517, 33, '9', 0, NULL),
(518, 33, '10', 0, NULL),
(519, 33, '11', 0, NULL),
(520, 33, '12', 0, NULL),
(521, 33, '13', 0, NULL),
(522, 33, '14', 0, NULL),
(523, 33, '15', 0, NULL),
(524, 33, '16', 0, NULL),
(525, 33, '17', 0, NULL),
(526, 33, '18', 0, NULL),
(527, 33, '19', 0, NULL),
(528, 33, '20', 0, NULL),
(529, 33, '21', 0, NULL),
(530, 33, '22', 0, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `type` enum('pesawat','kapal','kereta','penginapan','kendaraan') NOT NULL,
  `name` varchar(100) NOT NULL,
  `origin` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL,
  `address` text DEFAULT NULL,
  `depart_date` date NOT NULL,
  `depart_time` time NOT NULL,
  `check_in_date` date DEFAULT NULL,
  `check_out_date` date DEFAULT NULL,
  `rental_start_date` datetime DEFAULT NULL,
  `rental_end_date` datetime DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `price` decimal(15,2) NOT NULL,
  `with_driver` tinyint(1) DEFAULT 0,
  `num_guests` int(11) DEFAULT NULL,
  `room_type` varchar(100) DEFAULT NULL,
  `vehicle_brand` varchar(100) DEFAULT NULL,
  `vehicle_model` varchar(100) DEFAULT NULL,
  `vehicle_year` int(11) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `total_seats` int(11) NOT NULL DEFAULT 30,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tickets`
--

INSERT INTO `tickets` (`id`, `type`, `name`, `origin`, `destination`, `address`, `depart_date`, `depart_time`, `check_in_date`, `check_out_date`, `rental_start_date`, `rental_end_date`, `return_date`, `price`, `with_driver`, `num_guests`, `room_type`, `vehicle_brand`, `vehicle_model`, `vehicle_year`, `image`, `total_seats`, `created_at`) VALUES
(33, 'pesawat', 'asdas', 'asdfd', 'sdf', NULL, '2025-07-10', '10:51:00', NULL, NULL, NULL, NULL, NULL, 2.00, 0, NULL, NULL, NULL, NULL, NULL, 'ticket_1751986216_684638aa52.png', 22, '2025-07-08 14:50:16');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT 'User current balance'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `created_at`, `balance`) VALUES
(30, '1', '$2y$10$uOJ6JPXHVTq8rOcXkqU4q.JP.VF1pDPD2gE0AjqOABPu5E.BMSHBG', 'user', '2025-07-08 14:49:44', 0.00),
(31, '2', '$2y$10$54mljEkFx0N1QD7c8JroX.FB/2hZ1LzeTFKD8gN7kZm6LSiDy2PsW', 'admin', '2025-07-08 14:49:50', 0.00);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `balance_transactions`
--
ALTER TABLE `balance_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `related_order_id` (`related_order_id`);

--
-- Indeks untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `ticket_id` (`ticket_id`);

--
-- Indeks untuk tabel `pengaduan`
--
ALTER TABLE `pengaduan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `seats`
--
ALTER TABLE `seats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_id` (`ticket_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indeks untuk tabel `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `balance_transactions`
--
ALTER TABLE `balance_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT untuk tabel `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT untuk tabel `pengaduan`
--
ALTER TABLE `pengaduan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `seats`
--
ALTER TABLE `seats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=531;

--
-- AUTO_INCREMENT untuk tabel `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `balance_transactions`
--
ALTER TABLE `balance_transactions`
  ADD CONSTRAINT `balance_transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `balance_transactions_ibfk_2` FOREIGN KEY (`related_order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `seats`
--
ALTER TABLE `seats`
  ADD CONSTRAINT `seats_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `seats_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
