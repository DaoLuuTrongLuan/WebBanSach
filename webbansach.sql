/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80044 (8.0.44)
 Source Host           : localhost:3306
 Source Schema         : webbansach

 Target Server Type    : MySQL
 Target Server Version : 80044 (8.0.44)
 File Encoding         : 65001

 Date: 06/12/2025 21:33:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for authors
-- ----------------------------
DROP TABLE IF EXISTS `authors`;
CREATE TABLE `authors`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of authors
-- ----------------------------
INSERT INTO `authors` VALUES (1, 'Nguyễn Nhật Ánh', 'Việt Nam');
INSERT INTO `authors` VALUES (2, 'Dương Thụ', 'Việt Nam');
INSERT INTO `authors` VALUES (3, 'Bạch Liên', 'Việt Nam');
INSERT INTO `authors` VALUES (4, 'George R. R. Martin', 'Mỹ');
INSERT INTO `authors` VALUES (5, 'J.K. Rowling', 'Anh');
INSERT INTO `authors` VALUES (6, 'Paulo Coelho', 'Brazil');
INSERT INTO `authors` VALUES (7, 'Dale Carnegie', 'Mỹ');
INSERT INTO `authors` VALUES (8, 'Robert T. Kiyosaki', 'Mỹ');

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_id` int NULL DEFAULT NULL,
  `author_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `publisher_id` int NULL DEFAULT NULL,
  `publisher_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `category_id` int NOT NULL,
  `price` bigint NOT NULL,
  `original_price` bigint NULL DEFAULT NULL,
  `discount` int NULL DEFAULT 0,
  `pages` int NULL DEFAULT NULL,
  `year` int NULL DEFAULT NULL,
  `rating` double NULL DEFAULT 0,
  `reviews` int NULL DEFAULT 0,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'Còn hàng',
  `format` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `size` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `stock` int NULL DEFAULT 0,
  `featured` tinyint(1) NULL DEFAULT 0,
  `bestseller` tinyint(1) NULL DEFAULT 0,
  `is_new` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_id`(`category_id` ASC) USING BTREE,
  INDEX `author_id`(`author_id` ASC) USING BTREE,
  INDEX `publisher_id`(`publisher_id` ASC) USING BTREE,
  CONSTRAINT `books_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `books_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `books_ibfk_3` FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of books
-- ----------------------------
INSERT INTO `books` VALUES (1, 'Thỏ Bông', 1, 'Nguyễn Nhật Ánh', 1, 'NXB Trẻ', 5, 120000, 150000, 20, 240, 2020, 4.8, 125, 'Một tác phẩm hay về tình yêu và cuộc sống của các bạn trẻ', 'https://books.google.com/books/content?id=5x_KDgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', 'Còn hàng', 'Bìa mềm', '14 x 20.5 cm', 50, 1, 0, 1);
INSERT INTO `books` VALUES (2, 'Cha Giàu Cha Nghèo', 8, 'Robert T. Kiyosaki', 2, 'NXB Lao Động', 2, 145000, 180000, 19, 336, 2019, 4.9, 892, 'Hướng dẫn cách xây dựng tư duy tài chính và đầu tư thông minh', 'https://books.google.com/books/content?id=FVdjDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', 'Còn hàng', 'Bìa cứng', '15.5 x 22.5 cm', 120, 1, 1, 0);
INSERT INTO `books` VALUES (3, 'Sapiens', NULL, 'Yuval Noah Harari', 5, 'Penguin Books', 1, 165000, 220000, 25, 512, 2021, 4.7, 654, 'Lịch sử loài người nhìn từ một góc độ hoàn toàn mới', 'https://books.google.com/books/content?id=S5iBAwAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'Còn hàng', 'Bìa mềm', '15 x 22 cm', 80, 1, 0, 0);
INSERT INTO `books` VALUES (4, 'Đắc Nhân Tâm', 7, 'Dale Carnegie', 2, 'NXB Lao Động', 3, 135000, 160000, 16, 288, 2020, 4.6, 445, 'Những lợi ích trong cuộc sống bằng cách thay đổi tư tưởng', 'https://books.google.com/books/content?id=ljx90QEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'Còn hàng', 'Bìa cứng', '14 x 20.5 cm', 95, 0, 1, 0);
INSERT INTO `books` VALUES (5, 'Clean Code', NULL, 'Robert C. Martin', 6, 'Random House', 4, 185000, 240000, 23, 464, 2021, 4.8, 523, 'Hướng dẫn viết code sạch và dễ bảo trì', 'https://books.google.com/books/content?id=gPwfDgAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'Còn hàng', 'Bìa cứng', '15.5 x 23 cm', 60, 0, 1, 1);
INSERT INTO `books` VALUES (6, 'Dạy Con Thế Nào?', 1, 'Nguyễn Nhật Ánh', 1, 'NXB Trẻ', 3, 125000, 155000, 19, 256, 2021, 4.5, 234, 'Những cách dạy dỗ con em hiệu quả và khoa học', 'https://cdn.pixabay.com/photo/2018/02/08/14/36/book-3140662_640.jpg', 'Còn hàng', 'Bìa mềm', '14 x 20.5 cm', 75, 0, 0, 1);
INSERT INTO `books` VALUES (7, 'The Hobbit', NULL, 'J.R.R. Tolkien', 5, 'Penguin Books', 1, 155000, 200000, 23, 380, 2020, 4.9, 789, 'Cuộc phiêu lưu đầy kỳ diệu của Bilbo Baggins', 'https://cdn.pixabay.com/photo/2017/08/14/02/28/stack-of-books-2638586_640.jpg', 'Còn hàng', 'Bìa cứng', '15 x 22 cm', 110, 1, 0, 0);
INSERT INTO `books` VALUES (8, 'Lập Trình Java Cơ Bản', NULL, 'Trần Minh Tuấn', 3, 'NXB Hà Nội', 4, 175000, 220000, 20, 520, 2021, 4.7, 312, 'Học lập trình Java từ cơ bản đến nâng cao', 'https://cdn.pixabay.com/photo/2013/12/20/15/17/book-231100_640.jpg', 'Còn hàng', 'Bìa mềm', '16 x 24 cm', 45, 0, 1, 1);
INSERT INTO `books` VALUES (9, 'Con Chim Xanh', 3, 'Bạch Liên', 4, 'NXB Kim Đồng', 5, 85000, 110000, 23, 128, 2021, 4.4, 156, 'Truyện kỳ diệu dành cho các bạn nhỏ', 'https://images.pexels.com/photos/159866/books-book-pages-read-159866.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa cứng', '13.5 x 19 cm', 200, 0, 0, 0);
INSERT INTO `books` VALUES (10, 'Tiếng Anh Giao Tiếp', NULL, 'Phạm Thị Mai', 2, 'NXB Lao Động', 6, 145000, 180000, 19, 304, 2020, 4.6, 267, 'Học tiếng Anh giao tiếp hàng ngày một cách hiệu quả', 'https://images.pexels.com/photos/256514/pexels-photo-256514.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa mềm', '15 x 21 cm', 130, 0, 0, 0);
INSERT INTO `books` VALUES (11, 'Thất Bại Là Mẹ Của Thành Công', 4, 'George R. R. Martin', 6, 'Random House', 3, 135000, 165000, 18, 272, 2021, 4.5, 189, 'Học cách vượt qua thất bại và đạt được thành công', 'https://images.pexels.com/photos/1761279/pexels-photo-1761279.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa cứng', '14.5 x 21 cm', 85, 0, 0, 1);
INSERT INTO `books` VALUES (12, 'Cuộc Sống Sau 50 Tuổi', 2, 'Dương Thụ', 1, 'NXB Trẻ', 3, 125000, 160000, 22, 215, 2020, 4.3, 134, 'Hướng dẫn sống sẻ lành mạnh và bình yên sau 50 tuổi', 'https://images.pexels.com/photos/4439407/pexels-photo-4439407.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa mềm', '14.5 x 20.5 cm', 70, 0, 0, 0);
INSERT INTO `books` VALUES (13, 'Nhà Giả Kim', NULL, 'Paulo Coelho', 1, 'NXB Trẻ', 1, 99000, 125000, 21, 256, 2020, 4.7, 543, 'Hành trình tìm kiếm kho báu nội tâm', 'https://covers.openlibrary.org/b/id/6379847-M.jpg', 'Còn hàng', 'Bìa mềm', '14 x 20 cm', 150, 1, 1, 0);
INSERT INTO `books` VALUES (14, 'Tư Duy Nhanh và Chậm', NULL, 'Daniel Kahneman', 2, 'NXB Lao Động', 3, 155000, 195000, 20, 456, 2021, 4.8, 432, 'Khám phá hai hệ thống tư duy của con người', 'https://covers.openlibrary.org/b/id/8236101-M.jpg', 'Còn hàng', 'Bìa cứng', '15 x 22 cm', 88, 0, 1, 0);
INSERT INTO `books` VALUES (15, 'Lập Trình Python', NULL, 'Mark Lutz', 3, 'NXB Hà Nội', 4, 198000, 250000, 21, 640, 2021, 4.9, 567, 'Hướng dẫn toàn diện lập trình Python', 'https://covers.openlibrary.org/b/id/7725341-M.jpg', 'Còn hàng', 'Bìa cứng', '17 x 24 cm', 52, 1, 1, 1);
INSERT INTO `books` VALUES (16, 'Tôi Có Thể Bảo Vệ Bản Thân Mình', NULL, 'Lê Việt Hà', 1, 'NXB Trẻ', 3, 89000, 115000, 23, 200, 2021, 4.6, 223, 'Hướng dẫn tự vệ cho phụ nữ', 'https://covers.openlibrary.org/b/id/8429509-M.jpg', 'Còn hàng', 'Bìa mềm', '14 x 20 cm', 200, 0, 0, 1);
INSERT INTO `books` VALUES (17, 'Biết Chút Về Nhiều', NULL, 'Lê Minh', 4, 'NXB Kim Đồng', 1, 115000, 145000, 21, 320, 2020, 4.5, 178, 'Kiến thức tổng hợp về đa lĩnh vực', 'https://covers.openlibrary.org/b/id/8439022-M.jpg', 'Còn hàng', 'Bìa mềm', '14 x 20 cm', 95, 0, 0, 0);
INSERT INTO `books` VALUES (18, 'Kỹ Năng Quản Lý Thời Gian', NULL, 'Nguyễn Dung', 2, 'NXB Lao Động', 3, 79000, 99000, 20, 184, 2021, 4.4, 334, 'Quản lý thời gian hiệu quả', 'https://covers.openlibrary.org/b/id/8439110-M.jpg', 'Còn hàng', 'Bìa mềm', '13.5 x 19 cm', 240, 0, 0, 1);
INSERT INTO `books` VALUES (19, 'Trí Tuệ Nhân Tạo Giải Thích', NULL, 'Sebastian Thrun', 5, 'Penguin Books', 4, 210000, 270000, 22, 512, 2021, 4.8, 456, 'Hiểu biết sâu về AI và Machine Learning', 'https://books.google.com/books/content?id=ljx90QEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'Còn hàng', 'Bìa cứng', '15.5 x 23 cm', 38, 1, 1, 1);
INSERT INTO `books` VALUES (20, 'Nước Ý Xanh', NULL, 'Đặng Vũ Minh', 1, 'NXB Trẻ', 1, 135000, 168000, 20, 296, 2020, 4.7, 345, 'Tiểu thuyết lãng mạn', 'https://cdn.pixabay.com/photo/2018/02/08/14/36/book-3140662_640.jpg', 'Còn hàng', 'Bìa mềm', '14 x 20.5 cm', 120, 0, 0, 0);
INSERT INTO `books` VALUES (21, 'Bộ Não Sáng Tạo', NULL, 'David Eagleman', 5, 'Penguin Books', 3, 165000, 210000, 21, 384, 2021, 4.6, 289, 'Khám phá sức mạnh của bộ não', 'https://cdn.pixabay.com/photo/2017/08/14/02/28/stack-of-books-2638586_640.jpg', 'Còn hàng', 'Bìa cứng', '15 x 22 cm', 72, 1, 0, 0);
INSERT INTO `books` VALUES (22, 'Web Development Hiện Đại', NULL, 'Kyle Simpson', 3, 'NXB Hà Nội', 4, 189000, 240000, 21, 528, 2021, 4.9, 612, 'Hướng dẫn phát triển web hiện đại', 'https://cdn.pixabay.com/photo/2013/12/20/15/17/book-231100_640.jpg', 'Còn hàng', 'Bìa cứng', '16 x 24 cm', 66, 0, 1, 1);
INSERT INTO `books` VALUES (23, 'Tiếng Anh Thương Mại', NULL, 'John Smith', 5, 'Penguin Books', 6, 128000, 160000, 20, 272, 2021, 4.5, 198, 'Tiếng Anh chuyên nghiệp cho kinh doanh', 'https://images.pexels.com/photos/159866/books-book-pages-read-159866.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa mềm', '14 x 20 cm', 145, 0, 0, 1);
INSERT INTO `books` VALUES (24, 'Phân Tích Dữ Liệu Với Python', NULL, 'Wes McKinney', 3, 'NXB Hà Nội', 4, 195000, 250000, 22, 600, 2021, 4.8, 478, 'Phân tích dữ liệu chuyên sâu', 'https://images.pexels.com/photos/256514/pexels-photo-256514.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa cứng', '17 x 24 cm', 44, 1, 1, 1);
INSERT INTO `books` VALUES (25, 'Sáng Tạo Không Giới Hạn', NULL, 'Lê Huy Toàn', 1, 'NXB Trẻ', 3, 108000, 135000, 20, 256, 2021, 4.6, 267, 'Phát triển khả năng sáng tạo', 'https://images.pexels.com/photos/1761279/pexels-photo-1761279.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa mềm', '14 x 20 cm', 180, 0, 0, 1);
INSERT INTO `books` VALUES (26, 'Nơi Đó Có Nắng', 1, 'Nguyễn Nhật Ánh', 1, 'NXB Trẻ', 1, 98000, 125000, 22, 304, 2021, 4.7, 456, 'Chuyện tình yêu trong mưa', 'https://images.pexels.com/photos/4439407/pexels-photo-4439407.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa mềm', '14 x 20 cm', 156, 1, 0, 1);
INSERT INTO `books` VALUES (27, 'Hạnh Phúc Không Xa', NULL, 'Trương Thảo', 2, 'NXB Lao Động', 3, 85000, 110000, 23, 192, 2020, 4.4, 189, 'Hạnh phúc trong những điều giản dị', 'https://covers.openlibrary.org/b/id/6379847-M.jpg', 'Còn hàng', 'Bìa mềm', '13.5 x 19 cm', 210, 0, 0, 0);
INSERT INTO `books` VALUES (28, 'Kinh Tế Học Vi Mô', NULL, 'Paul Krugman', 5, 'Penguin Books', 2, 189000, 240000, 21, 528, 2021, 4.8, 334, 'Kiến thức kinh tế học vi mô toàn diện', 'https://covers.openlibrary.org/b/id/8236101-M.jpg', 'Còn hàng', 'Bìa cứng', '15.5 x 23 cm', 68, 1, 1, 0);
INSERT INTO `books` VALUES (29, 'Nghệ Thuật Ghi Chép', NULL, 'Sönke Ahrens', 3, 'NXB Hà Nội', 3, 145000, 185000, 22, 352, 2021, 4.7, 412, 'Ghi chép thông minh để học tập hiệu quả', 'https://covers.openlibrary.org/b/id/7725341-M.jpg', 'Còn hàng', 'Bìa cứng', '14.5 x 21 cm', 95, 0, 1, 1);
INSERT INTO `books` VALUES (30, 'Cơn Sóng Lớn', NULL, 'Margaret Mead', 4, 'NXB Kim Đồng', 1, 125000, 160000, 22, 288, 2020, 4.5, 267, 'Nhân học và xã hội học', 'https://covers.openlibrary.org/b/id/8429509-M.jpg', 'Còn hàng', 'Bìa mềm', '14 x 20.5 cm', 130, 0, 0, 0);
INSERT INTO `books` VALUES (31, 'JavaScript Tiên Tiến', NULL, 'Nicholas C. Zakas', 3, 'NXB Hà Nội', 4, 175000, 220000, 20, 608, 2021, 4.9, 589, 'Lập trình JavaScript nâng cao', 'https://covers.openlibrary.org/b/id/8439022-M.jpg', 'Còn hàng', 'Bìa cứng', '16 x 24 cm', 42, 1, 1, 1);
INSERT INTO `books` VALUES (32, 'Tâm Lý Học Tích Cực', NULL, 'Barbara L. Fredrickson', 2, 'NXB Lao Động', 3, 128000, 160000, 20, 304, 2021, 4.6, 298, 'Khám phá sức mạnh tâm lý tích cực', 'https://covers.openlibrary.org/b/id/8439110-M.jpg', 'Còn hàng', 'Bìa mềm', '14 x 20 cm', 162, 0, 0, 1);
INSERT INTO `books` VALUES (33, 'Lịch Sử Thế Giới Ngắn Gọn', NULL, 'Chris Harman', 5, 'Penguin Books', 1, 155000, 200000, 23, 456, 2020, 4.7, 378, 'Tóm tắt lịch sử nhân loại', 'https://books.google.com/books/content?id=S5iBAwAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'Còn hàng', 'Bìa cứng', '15 x 22 cm', 88, 1, 0, 0);
INSERT INTO `books` VALUES (34, 'Quản Lý Dự Án Hiệu Quả', NULL, 'David Cohen', 2, 'NXB Lao Động', 2, 135000, 170000, 21, 272, 2021, 4.5, 223, 'Quản lý dự án chuyên nghiệp', 'https://cdn.pixabay.com/photo/2018/02/08/14/36/book-3140662_640.jpg', 'Còn hàng', 'Bìa mềm', '14.5 x 20.5 cm', 110, 0, 0, 1);
INSERT INTO `books` VALUES (35, 'Sức Mạnh Của Thói Quen', NULL, 'Charles Duhigg', 1, 'NXB Trẻ', 3, 125000, 160000, 22, 400, 2020, 4.8, 567, 'Thay đổi thói quen để thay đổi cuộc sống', 'https://cdn.pixabay.com/photo/2017/08/14/02/28/stack-of-books-2638586_640.jpg', 'Còn hàng', 'Bìa cứng', '14.5 x 21 cm', 145, 1, 1, 0);
INSERT INTO `books` VALUES (36, 'Database Thiết Kế', NULL, 'C.J. Date', 3, 'NXB Hà Nội', 4, 198000, 250000, 21, 560, 2021, 4.7, 289, 'Thiết kế cơ sở dữ liệu tối ưu', 'https://cdn.pixabay.com/photo/2013/12/20/15/17/book-231100_640.jpg', 'Còn hàng', 'Bìa cứng', '16 x 24 cm', 36, 0, 1, 1);
INSERT INTO `books` VALUES (37, 'Tiếng Pháp Cho Người Mới', NULL, 'Michel Thomas', 5, 'Penguin Books', 6, 135000, 175000, 23, 256, 2020, 4.5, 198, 'Học tiếng Pháp từ đầu', 'https://images.pexels.com/photos/159866/books-book-pages-read-159866.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa mềm', '14 x 20 cm', 124, 0, 0, 0);
INSERT INTO `books` VALUES (38, 'Triết Học Phương Đông', NULL, 'Alan Watts', 1, 'NXB Trẻ', 1, 105000, 135000, 22, 320, 2021, 4.6, 245, 'Hiểu biết về triết học phương Đông', 'https://images.pexels.com/photos/256514/pexels-photo-256514.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa mềm', '14 x 20.5 cm', 176, 1, 0, 1);
INSERT INTO `books` VALUES (39, 'Bán Hàng Thuyết Phục', NULL, 'Robert Cialdini', 2, 'NXB Lao Động', 2, 145000, 185000, 22, 336, 2021, 4.8, 423, 'Kỹ năng bán hàng chuyên nghiệp', 'https://images.pexels.com/photos/1761279/pexels-photo-1761279.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa cứng', '15 x 22 cm', 84, 0, 1, 0);
INSERT INTO `books` VALUES (40, 'Toán Học Thú Vị', NULL, 'Edward Frenkel', 4, 'NXB Kim Đồng', 4, 128000, 165000, 23, 384, 2020, 4.4, 167, 'Khám phá vẻ đẹp của toán học', 'https://images.pexels.com/photos/4439407/pexels-photo-4439407.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa cứng', '15.5 x 23 cm', 67, 1, 0, 0);

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `count` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, 'Văn Học', '📖', 'Các tác phẩm văn học kinh điển và hiện đại', 1250);
INSERT INTO `categories` VALUES (2, 'Sách Kinh Tế', '💼', 'Sách về kinh doanh, tài chính và quản lý', 890);
INSERT INTO `categories` VALUES (3, 'Kỹ Năng Sống', '💪', 'Phát triển kỹ năng cá nhân và chuyên môn', 750);
INSERT INTO `categories` VALUES (4, 'Công Nghệ', '💻', 'Sách về lập trình, web, AI và công nghệ', 620);
INSERT INTO `categories` VALUES (5, 'Trẻ Em', '👶', 'Sách truyện và học tập cho trẻ em', 540);
INSERT INTO `categories` VALUES (6, 'Ngoại Ngữ', '🌍', 'Sách học tiếng Anh, Trung, Nhật...', 430);

-- ----------------------------
-- Table structure for publishers
-- ----------------------------
DROP TABLE IF EXISTS `publishers`;
CREATE TABLE `publishers`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of publishers
-- ----------------------------
INSERT INTO `publishers` VALUES (1, 'NXB Trẻ', 'Việt Nam');
INSERT INTO `publishers` VALUES (2, 'NXB Lao Động', 'Việt Nam');
INSERT INTO `publishers` VALUES (3, 'NXB Hà Nội', 'Việt Nam');
INSERT INTO `publishers` VALUES (4, 'NXB Kim Đồng', 'Việt Nam');
INSERT INTO `publishers` VALUES (5, 'Penguin Books', 'Anh');
INSERT INTO `publishers` VALUES (6, 'Random House', 'Mỹ');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fullname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email` (`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `fullname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `shipping_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'standard',
  `payment_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'vnpay',
  `total_amount` bigint NOT NULL,
  `shipping_cost` bigint NULL DEFAULT 0,
  `final_amount` bigint NOT NULL,
  `order_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'pending',
  `payment_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'pending',
  `vnp_txn_ref` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `vnp_transaction_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id` (`user_id` ASC) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for order_items
-- ----------------------------
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `book_id` int NOT NULL,
  `book_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` bigint NOT NULL,
  `total_price` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id` (`order_id` ASC) USING BTREE,
  INDEX `book_id` (`book_id` ASC) USING BTREE,
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
