-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 11, 2019 lúc 08:22 AM
-- Phiên bản máy phục vụ: 10.4.8-MariaDB
-- Phiên bản PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `android`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `rate_table`
--

CREATE TABLE `rate_table` (
  `username` varchar(40) NOT NULL,
  `idreview` int(11) NOT NULL,
  `ngaydang` datetime NOT NULL,
  `noidung` text NOT NULL,
  `rating` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `rate_table`
--

INSERT INTO `rate_table` (`username`, `idreview`, `ngaydang`, `noidung`, `rating`) VALUES
('admin', 28, '2019-11-10 14:26:00', '', 4),
('admin', 30, '2019-11-09 12:38:28', 'ngon', 3.5),
('duynhut1', 30, '2019-11-10 14:11:41', 'ngon lem', 5),
('duynhut1', 56, '2019-11-11 13:57:22', 'Cá rất hiền , vui vẻ hòa đồng', 5),
('triminh', 9, '2019-11-11 10:06:19', 'tot', 5);

--
-- Bẫy `rate_table`
--
DELIMITER $$
CREATE TRIGGER `rating_avg_del` AFTER DELETE ON `rate_table` FOR EACH ROW UPDATE review_table SET review_table.rating=( SELECT AVG(rate_table.rating) FROM rate_table WHERE review_table.id=rate_table.idreview )  WHERE review_table.id=old.idreview
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `rating_avg_ins` AFTER INSERT ON `rate_table` FOR EACH ROW UPDATE review_table SET review_table.rating=( SELECT AVG(rate_table.rating) FROM rate_table WHERE review_table.id=rate_table.idreview ) WHERE review_table.id=new.idreview
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `rating_avg_upd` AFTER UPDATE ON `rate_table` FOR EACH ROW UPDATE review_table SET review_table.rating=( SELECT AVG(rate_table.rating) FROM rate_table WHERE review_table.id=rate_table.idreview )  WHERE review_table.id=new.idreview
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `review_table`
--

CREATE TABLE `review_table` (
  `id` int(11) NOT NULL,
  `username` varchar(40) NOT NULL,
  `ngaydang` datetime NOT NULL,
  `tieude` varchar(255) NOT NULL,
  `noidung` text NOT NULL,
  `diachi` text NOT NULL,
  `hinhanh` varchar(255) NOT NULL,
  `rating` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `review_table`
--

INSERT INTO `review_table` (`id`, `username`, `ngaydang`, `tieude`, `noidung`, `diachi`, `hinhanh`, `rating`) VALUES
(1, 'admin', '2019-11-08 00:00:00', 'Bánh canh', 'Được làm từ bột gạo, bột mì, hoặc bột sắn hoặc bột gạo pha bột sắn cán thành tấm và cắt ra thành sợi to và ngắn với nước dùng được nấu từ tôm, cá, giò heo... thêm gia vị tùy theo từng loại', 'Tầng 3, Tầng 3, 5-7-9 Nguyễn Trung Trực, P. Bến Thành, Quận 1, TP. HCM', '1.jpg', 0),
(2, 'admin', '2019-10-01 00:00:00', 'Bánh đa cua', 'Bánh đa với nước dùng riêu cua', 'Tầng 3, Tầng 3, 5-7-9 Nguyễn Trung Trực, P. Bến Thành, Quận 1, TP. HCM', '2.jpg', 0),
(3, 'admin', '2019-10-01 00:00:00', 'Bún bò Huế', 'Bún đặc sản của xứ Huế, trong nước dùng có một ít mắm ruốc, góp phần làm nên hương vị rất riêng', 'S37-1 Hưng Vượng 2, Bùi Bằng Đoàn, Quận 7, TP. HCM', '3.jpg', 0),
(4, 'admin', '2019-10-01 00:00:00', 'Bún cá', 'Bún và chả cá nướng trộn nước mắm, rau sống', 'S37-1 Hưng Vượng 2, Bùi Bằng Đoàn, Quận 7, TP. HCM', '4.jpg', 0),
(5, 'admin', '2019-10-01 00:00:00', 'Bún chả', 'Bún ăn kèm chả viên và chả miếng với nước chấm', '61 Quang Trung, P. 10, Gò Vấp, TP. HCM', '5.jpg', 0),
(6, 'admin', '2019-10-01 00:00:00', 'Cao lầu', 'Đặc sản của Hội An với sợi mì được chế biến rất công phu ăn cùng giá đỗ và thịt xá xíu', '506 - 508 Nguyễn Thị Minh Khai, P. 2, Quận 3, TP. HCM', '6.jpg', 0),
(7, 'admin', '2019-10-01 00:00:00', 'Miến lươn', 'Được nấu từ miến với thịt lươn có hai dạng: dạng miến lươn khô và miến lươn nước nấu nước dùng là nước xương', '506 - 508 Nguyễn Thị Minh Khai, P. 2, Quận 3, TP. HCM', '7.jpg', 0),
(8, 'admin', '2019-11-08 00:00:00', 'Cơm cháy Ninh Bình', 'Cơm cháy là phần cơm dưới đáy nồi khi nấu cơm thường chín vàng giòn, cơm cháy lấy ra xong phải phơi nắng tự nhiên hai, ba nắng, để chỗ thoáng, tránh ẩm mốc, lúc gần ăn mới chiên giòn', 'Rooftop Tòa Nhà Thanh Thế, 2 - 4 - 6 Lưu Văn Lang, Quận 1, TP. HCM', '8.jpg', 0),
(9, 'admin', '2019-11-08 00:00:00', 'Cơm gà Quảng Nam', 'Cơm tẻ chín tới ăn với gà luộc rưới nước dùng gà', '601/32 Cách Mạng Tháng 8, P. 15, Quận 10, TP. HCM', '9.jpg', 5),
(10, 'admin', '2019-11-08 00:00:00', 'Canh chua', 'Các loại rau củ quả nấu với các loại thịt hay thủy sản khác nhau, trong đó dùng một gia vị chua để tạo vị chua thơm ngon cho nước canh', '752/38/24 Lạc Long Quân, Tân Bình, TP. HCM', '10.jpg', 0),
(11, 'admin', '2019-11-08 00:00:00', 'Thịt kho', 'Thịt lợn (luôn phải có mỡ, nếu không phải thêm mỡ hoặc dầu ăn) vào nồi đun cho tới chín, cho thêm nước mắm để có vị mặn nhạt theo sở thích', '850 Cách Mạng Tháng 8, P. 5, Tân Bình, TP. HCM', '11.jpg', 0),
(12, 'admin', '2019-11-08 00:00:00', 'Xôi chiên', 'Xôi trắng ấn dẹt thành từng bánh rồi chiên ngập dầu, hoặc có thể chiên phồng thành dạng tròn xoay như hình cầu.', '850 Cách Mạng Tháng 8, P. 5, Tân Bình, TP. HCM', '12.jpg', 0),
(13, 'admin', '2019-11-08 00:00:00', 'Xôi đỗ xanh', 'Đỗ xanh chà vỏ, ngâm nở và đãi bỏ vỏ (hoặc có thể để nguyên vỏ) trộn với gạo nếp và đồ chín. Đây là một loại xôi phổ biến và có rất nhiều loại xôi tương tự được chế biến với các loại đậu, đỗ', '850 Cách Mạng Tháng 8, P. 5, Tân Bình, TP. HCM', '13.jpg', 0),
(14, 'admin', '2019-11-08 00:00:00', 'Xôi lá cẩm', 'Tương tự xôi xéo với đậu xanh tán nhuyễn, nhưng kết hợp với nước sắc của lá cẩm để lấy màu tím đỏ.', '590/2/10 Phan Văn Trị, P. 7, Gò Vấp, TP. HCM', '14.jpg', 0),
(15, 'admin', '2019-11-08 00:00:00', 'Cháo lòng', 'Cháo kết hợp với nước dùng ngọt làm từ xương lợn hay nước luộc lòng lợn, và nguyên liệu chính cho bát cháo không thể thiếu các món phủ tạng lợn luộc', '007 Lô F Chung Cư Ngô Gia Tự, Hòa Hảo, P. 3, Quận 10, TP. HCM', '15.jpg', 0),
(16, 'admin', '2019-11-08 00:00:00', 'Canh khổ qua nhồi thịt', 'Mướp đắng được nhồi thịt, bó lại bằng hành hoa nấu trong nước xương ninh', '007 Lô F Chung Cư Ngô Gia Tự, Hòa Hảo, P. 3, Quận 10, TP. HCM', '16.jpg', 0),
(17, 'admin', '2019-11-08 00:00:00', 'Ốc nấu chuối đậu', 'Món ăn dân dã nhưng khá cầu kỳ với ốc luộc chín nấu cùng chuối xanh, đậu rán, thịt ba chỉ, có lá lốt, tía tô', '113 Pasteur, P. 6, Quận 3, TP. HCM', '17.jpg', 0),
(18, 'admin', '2019-11-08 00:00:00', 'Súp yến', 'Món ăn sang trọng, đắt tiền, bổ dưỡng nằm trong Bát trân nấu từ tổ yến với đường.', '62 Tô Vĩnh Diện, Thủ Đức, TP. HCM', '18.jpg', 0),
(19, 'admin', '2019-11-08 00:00:00', 'Bánh cuốn', 'Bột gạo hấp tráng mỏng, để ăn khi còn ướt, bên trong cuốn nhân. Bánh thường ăn với một loại nước chấm pha nhạt từ nước mắm', '127 Đinh Tiên Hoàng, P. Đa Kao, Quận 1, TP. HCM', '19.jpg', 0),
(20, 'admin', '2019-11-08 00:00:00', 'Bò bía', 'Gồm bò bía mặn và bò bía ngọt, đều là bột mì cuốn các nguyện liệu khác', '127 Đinh Tiên Hoàng, P. Đa Kao, Quận 1, TP. HCM', '20.jpg', 0),
(21, 'admin', '2019-11-08 00:00:00', 'Bánh bèo', 'Bánh làm từ bột gạo, nhân để rắc lên bánh làm bằng tôm xay nhuyễn, và nước chấm, một hỗn hợp mà nước mắm là thành phần chính và thường đổ trực tiếp vào bánh', '55/19 Vạn Kiếp, P. 3, Bình Thạnh, TP. HCM', '21.jpg', 0),
(22, 'admin', '2019-11-08 00:00:00', 'Bánh đúc', 'Làm bằng bột gạo (tại miền Bắc và miền Trung) hoặc bột năng (miền Nam) với nước vôi trong một số gia vị. Bánh được làm thành tấm to, khi ăn thì cắt nhỏ thành miếng tùy thích.', '11A Cao Thắng, P. 2, Quận 3, TP. HCM', '22.jpg', 0),
(23, 'admin', '2019-11-08 00:00:00', 'Chè bà ba', 'Chè khoai lang với đậu xanh cà và nước cốt dừa.', '111 Bùi Thị Xuân, P. Phạm Ngũ Lão , Quận 1, TP. HCM', '23.jpg', 0),
(24, 'admin', '2019-11-08 00:00:00', 'Sủi dìn', 'Bằng bột gạo nếp, nhân đậu xanh, vừng. Bên ngoài lăn vừng đen & nấu trong nước gừng nóng, rắc thêm một vài sợi dừa nạo.', '111 Bùi Thị Xuân, P. Phạm Ngũ Lão , Quận 1, TP. HCM', '24.jpg', 0),
(25, 'admin', '2019-11-08 00:00:00', 'Trà sữa trân châu trắng', 'Trân châu trắng được làm từ bột rau câu dẻo, bột rau câu giòn, tạo hình thành các hạt tròn bé có màu trắng.Trân châu trắng có mùi thơm, vị ngọt và giòn giòn, không dẻo như trân châu đen.', '86E Song Hành, P. An Phú, Quận 2, TP. HCM', '25.jpg', 0),
(26, 'admin', '2019-11-08 00:00:00', 'Trà sữa Oreo Cake Cream', 'Trà sữa Oreo Cake Cream được phủ thêm một lớp cake cream vàng nhạt phía trên và xung quanh thành cốc. Những miếng bánh Oreo thơm ngon, hấp dẫn được nghiền nhỏ và rắc vụn lên phía trên lớp kem', '86E Song Hành, P. An Phú, Quận 2, TP. HCM', '26.jpg', 0),
(27, 'admin', '2019-11-08 00:00:00', 'Trà sữa trân châu đường đen', 'Trà sữa trân châu đường đen sẽ sử dụng sữa tươi không đường để vị không bị ngọt quá và phù hợp với phần topping gồm trân châu và đường đen. Một điểm nữa khiến giới trẻ mê mẩn trà sữa trân châu đường đen so với các loại trà sữa khác đó là vẻ ngoài bắt mắt của cốc trà với phần trà sữa trắng hòa quyện khéo léo cùng phần đường đen, trân châu đen bên dưới.', '122 Huỳnh Mẫn Đạt, P. 3, Quận 5, TP. HCM', '27.jpg', 0),
(28, 'admin', '2019-11-08 00:00:00', 'Trà sữa sương sáo', 'Đặc điểm đặc trưng so với các loại trà sữa khác: có vị không quá ngọt béo hay ngọt ngậy như các loại trà sữa khác. Thay vào đó là vị ngọt thanh của sương sáo mà vẫn có chút thơm béo béo của sữa tươi và vị chát nhẹ của trà. Trà sữa sương sáo có độ ngọt vừa phải, có mùi thơm đặc trưng cũng như có tính giải khát cao.', '122 Huỳnh Mẫn Đạt, P. 3, Quận 5, TP. HCM', '28.jpg', 4),
(29, 'admin', '2019-11-08 00:00:00', 'Trà sữa Cà phê', 'Cho dù có mùi vị cà phê nhưng vị chát nhẹ của trà đen vẫn được giữ nguyên, vị thơm của trà và cà phê không những không át nhau mà còn hòa quyện tạo nên mùi hương độc đáo. Ngoài ra chút vị đắng nhẹ của cà phê cũng rất thích hợp để kết hợp cùng vị ngọt bùi của sữa.', '53 Đường Số 18, P. Hiệp Bình Chánh, Thủ Đức, TP. HCM', '29.jpg', 0),
(30, 'admin', '2019-11-08 00:00:00', 'Trà sữa cheese milk foam', 'Trà sữa cheese milk foam là một loại đồ uống được giới trẻ đặc biệt yêu thích thời gian đổ lại đây. Ngoài vị trà sữa truyền thống thì cốc trà còn được thêm một lớp kem sữa béo béo, ngậy ngậy tràn mùi thơm.', '53 Đường Số 18, P. Hiệp Bình Chánh, Thủ Đức, TP. HCM', '30.jpg', 4.25),
(56, 'duynhut1', '2019-11-11 13:56:08', 'Sông Sài Gòn', 'Sông dài nước rộng, cá nhiều lắm', 'Thành phố Hồ Chí Minh', '56.jpg', 5);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `save_table`
--

CREATE TABLE `save_table` (
  `username` varchar(40) CHARACTER SET utf8 NOT NULL,
  `idreview` int(11) NOT NULL,
  `ngayluu` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `save_table`
--

INSERT INTO `save_table` (`username`, `idreview`, `ngayluu`) VALUES
('admin', 1, '2019-11-11 10:06:24'),
('admin', 25, '2019-11-11 10:06:24'),
('admin', 29, '2019-11-11 13:18:18'),
('admin', 30, '2019-11-11 10:06:24'),
('duynhut1', 29, '2019-11-11 13:19:34'),
('duynhut1', 30, '2019-11-11 13:19:31'),
('triminh', 9, '2019-11-11 10:06:24');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_table`
--

CREATE TABLE `user_table` (
  `username` varchar(40) NOT NULL,
  `password` varchar(255) NOT NULL,
  `hoten` varchar(40) DEFAULT NULL,
  `ngaysinh` date DEFAULT NULL,
  `sdt` varchar(20) DEFAULT NULL,
  `ava` varchar(40) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `user_table`
--

INSERT INTO `user_table` (`username`, `password`, `hoten`, `ngaysinh`, `sdt`, `ava`, `admin`) VALUES
('admin', '$2y$10$YYjXsvnD5fnsfVORXpSLguHoe4V2D9gSgZbGFhrxYoPlwq14jEO4e', 'Phạm Lam Trường', '2000-10-22', '0123456789', 'admin.jpg', 1),
('duynhut1', '$2y$10$z7/jlyAJhoJvwN14EcrxD.9wfb5QDNVy8rnEo32eZT.MZFejCJvsW', 'duynhut', '2019-11-10', '0123456789', NULL, 0),
('triminh', '$2y$10$1p44tpI0LdN3OlI5FS8bneayxdIjcG6uvlkMsf32NF5aEJ.XQ3.Wa', 'tri', '2005-11-09', '00000002', NULL, 0);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `rate_table`
--
ALTER TABLE `rate_table`
  ADD PRIMARY KEY (`username`,`idreview`),
  ADD KEY `stt` (`idreview`);

--
-- Chỉ mục cho bảng `review_table`
--
ALTER TABLE `review_table`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nguoidang` (`username`);
ALTER TABLE `review_table` ADD FULLTEXT KEY `tieude` (`tieude`,`diachi`);

--
-- Chỉ mục cho bảng `save_table`
--
ALTER TABLE `save_table`
  ADD PRIMARY KEY (`username`,`idreview`),
  ADD KEY `bailuu` (`idreview`);

--
-- Chỉ mục cho bảng `user_table`
--
ALTER TABLE `user_table`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `review_table`
--
ALTER TABLE `review_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `rate_table`
--
ALTER TABLE `rate_table`
  ADD CONSTRAINT `nguoibl` FOREIGN KEY (`username`) REFERENCES `user_table` (`username`),
  ADD CONSTRAINT `stt` FOREIGN KEY (`idreview`) REFERENCES `review_table` (`id`);

--
-- Các ràng buộc cho bảng `review_table`
--
ALTER TABLE `review_table`
  ADD CONSTRAINT `nguoidang` FOREIGN KEY (`username`) REFERENCES `user_table` (`username`);

--
-- Các ràng buộc cho bảng `save_table`
--
ALTER TABLE `save_table`
  ADD CONSTRAINT `bailuu` FOREIGN KEY (`idreview`) REFERENCES `review_table` (`id`),
  ADD CONSTRAINT `nguoiluu` FOREIGN KEY (`username`) REFERENCES `user_table` (`username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
