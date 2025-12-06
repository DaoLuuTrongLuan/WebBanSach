-- ================================================================================
-- DATABASE WEBBANSACH - SQL CREATE TABLES + SAMPLE DATA
-- ================================================================================
-- Database: webbansach
-- Tables: categories, authors, publishers, books
-- Sample Data: 6 categories, 8 authors, 6 publishers, 40 books
-- ================================================================================

-- 1. CREATE DATABASE
-- ================================================================================
CREATE DATABASE IF NOT EXISTS webbansach;
USE webbansach;

-- 2. CREATE TABLES
-- ================================================================================

-- Categories Table
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    icon VARCHAR(10),
    description VARCHAR(255),
    count INT DEFAULT 0
);

-- Authors Table
CREATE TABLE authors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL UNIQUE,
    country VARCHAR(100)
);

-- Publishers Table
CREATE TABLE publishers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL UNIQUE,
    country VARCHAR(100)
);

-- Books Table
CREATE TABLE books (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    author_name VARCHAR(150),
    publisher_id INT,
    publisher_name VARCHAR(150),
    category_id INT NOT NULL,
    price BIGINT NOT NULL,
    original_price BIGINT,
    discount INT DEFAULT 0,
    pages INT,
    year INT,
    rating DOUBLE DEFAULT 0.0,
    reviews INT DEFAULT 0,
    description TEXT,
    image VARCHAR(500),
    status VARCHAR(50) DEFAULT 'Còn hàng',
    format VARCHAR(50),
    size VARCHAR(50),
    stock INT DEFAULT 0,
    featured BOOLEAN DEFAULT FALSE,
    bestseller BOOLEAN DEFAULT FALSE,
    is_new BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (author_id) REFERENCES authors(id),
    FOREIGN KEY (publisher_id) REFERENCES publishers(id)
);

-- ================================================================================
-- 3. INSERT CATEGORIES (6 danh mục)
-- ================================================================================
INSERT INTO categories (id, name, icon, description, count) VALUES
(1, 'Văn Học', '📖', 'Các tác phẩm văn học kinh điển và hiện đại', 1250),
(2, 'Sách Kinh Tế', '💼', 'Sách về kinh doanh, tài chính và quản lý', 890),
(3, 'Kỹ Năng Sống', '💪', 'Phát triển kỹ năng cá nhân và chuyên môn', 750),
(4, 'Công Nghệ', '💻', 'Sách về lập trình, web, AI và công nghệ', 620),
(5, 'Trẻ Em', '👶', 'Sách truyện và học tập cho trẻ em', 540),
(6, 'Ngoại Ngữ', '🌍', 'Sách học tiếng Anh, Trung, Nhật...', 430);

-- ================================================================================
-- 4. INSERT AUTHORS (8 tác giả)
-- ================================================================================
INSERT INTO authors (id, name, country) VALUES
(1, 'Nguyễn Nhật Ánh', 'Việt Nam'),
(2, 'Dương Thụ', 'Việt Nam'),
(3, 'Bạch Liên', 'Việt Nam'),
(4, 'George R. R. Martin', 'Mỹ'),
(5, 'J.K. Rowling', 'Anh'),
(6, 'Paulo Coelho', 'Brazil'),
(7, 'Dale Carnegie', 'Mỹ'),
(8, 'Robert T. Kiyosaki', 'Mỹ');

-- ================================================================================
-- 5. INSERT PUBLISHERS (6 nhà xuất bản)
-- ================================================================================
INSERT INTO publishers (id, name, country) VALUES
(1, 'NXB Trẻ', 'Việt Nam'),
(2, 'NXB Lao Động', 'Việt Nam'),
(3, 'NXB Hà Nội', 'Việt Nam'),
(4, 'NXB Kim Đồng', 'Việt Nam'),
(5, 'Penguin Books', 'Anh'),
(6, 'Random House', 'Mỹ');

-- ================================================================================
-- 6. INSERT BOOKS (40 cuốn sách)
-- ================================================================================
INSERT INTO books (
    id, title, author_id, author_name, publisher_id, publisher_name, 
    category_id, price, original_price, discount, pages, year, 
    rating, reviews, description, image, status, format, size, stock, 
    featured, bestseller, is_new
) VALUES
(1, 'Thỏ Bông', 1, 'Nguyễn Nhật Ánh', 1, 'NXB Trẻ', 5, 120000, 150000, 20, 240, 2020, 4.8, 125, 'Một tác phẩm hay về tình yêu và cuộc sống của các bạn trẻ', 'https://books.google.com/books/content?id=5x_KDgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', 'Còn hàng', 'Bìa mềm', '14 x 20.5 cm', 50, TRUE, FALSE, TRUE),
(2, 'Cha Giàu Cha Nghèo', 8, 'Robert T. Kiyosaki', 2, 'NXB Lao Động', 2, 145000, 180000, 19, 336, 2019, 4.9, 892, 'Hướng dẫn cách xây dựng tư duy tài chính và đầu tư thông minh', 'https://books.google.com/books/content?id=FVdjDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api', 'Còn hàng', 'Bìa cứng', '15.5 x 22.5 cm', 120, TRUE, TRUE, FALSE),
(3, 'Sapiens', NULL, 'Yuval Noah Harari', 5, 'Penguin Books', 1, 165000, 220000, 25, 512, 2021, 4.7, 654, 'Lịch sử loài người nhìn từ một góc độ hoàn toàn mới', 'https://books.google.com/books/content?id=S5iBAwAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'Còn hàng', 'Bìa mềm', '15 x 22 cm', 80, TRUE, FALSE, FALSE),
(4, 'Đắc Nhân Tâm', 7, 'Dale Carnegie', 2, 'NXB Lao Động', 3, 135000, 160000, 16, 288, 2020, 4.6, 445, 'Những lợi ích trong cuộc sống bằng cách thay đổi tư tưởng', 'https://books.google.com/books/content?id=ljx90QEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'Còn hàng', 'Bìa cứng', '14 x 20.5 cm', 95, FALSE, TRUE, FALSE),
(5, 'Clean Code', NULL, 'Robert C. Martin', 6, 'Random House', 4, 185000, 240000, 23, 464, 2021, 4.8, 523, 'Hướng dẫn viết code sạch và dễ bảo trì', 'https://books.google.com/books/content?id=gPwfDgAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'Còn hàng', 'Bìa cứng', '15.5 x 23 cm', 60, FALSE, TRUE, TRUE),
(6, 'Dạy Con Thế Nào?', 1, 'Nguyễn Nhật Ánh', 1, 'NXB Trẻ', 3, 125000, 155000, 19, 256, 2021, 4.5, 234, 'Những cách dạy dỗ con em hiệu quả và khoa học', 'https://cdn.pixabay.com/photo/2018/02/08/14/36/book-3140662_640.jpg', 'Còn hàng', 'Bìa mềm', '14 x 20.5 cm', 75, FALSE, FALSE, TRUE),
(7, 'The Hobbit', NULL, 'J.R.R. Tolkien', 5, 'Penguin Books', 1, 155000, 200000, 23, 380, 2020, 4.9, 789, 'Cuộc phiêu lưu đầy kỳ diệu của Bilbo Baggins', 'https://cdn.pixabay.com/photo/2017/08/14/02/28/stack-of-books-2638586_640.jpg', 'Còn hàng', 'Bìa cứng', '15 x 22 cm', 110, TRUE, FALSE, FALSE),
(8, 'Lập Trình Java Cơ Bản', NULL, 'Trần Minh Tuấn', 3, 'NXB Hà Nội', 4, 175000, 220000, 20, 520, 2021, 4.7, 312, 'Học lập trình Java từ cơ bản đến nâng cao', 'https://cdn.pixabay.com/photo/2013/12/20/15/17/book-231100_640.jpg', 'Còn hàng', 'Bìa mềm', '16 x 24 cm', 45, FALSE, TRUE, TRUE),
(9, 'Con Chim Xanh', 3, 'Bạch Liên', 4, 'NXB Kim Đồng', 5, 85000, 110000, 23, 128, 2021, 4.4, 156, 'Truyện kỳ diệu dành cho các bạn nhỏ', 'https://images.pexels.com/photos/159866/books-book-pages-read-159866.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa cứng', '13.5 x 19 cm', 200, FALSE, FALSE, FALSE),
(10, 'Tiếng Anh Giao Tiếp', NULL, 'Phạm Thị Mai', 2, 'NXB Lao Động', 6, 145000, 180000, 19, 304, 2020, 4.6, 267, 'Học tiếng Anh giao tiếp hàng ngày một cách hiệu quả', 'https://images.pexels.com/photos/256514/pexels-photo-256514.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa mềm', '15 x 21 cm', 130, FALSE, FALSE, FALSE),
(11, 'Thất Bại Là Mẹ Của Thành Công', 4, 'George R. R. Martin', 6, 'Random House', 3, 135000, 165000, 18, 272, 2021, 4.5, 189, 'Học cách vượt qua thất bại và đạt được thành công', 'https://images.pexels.com/photos/1761279/pexels-photo-1761279.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa cứng', '14.5 x 21 cm', 85, FALSE, FALSE, TRUE),
(12, 'Cuộc Sống Sau 50 Tuổi', 2, 'Dương Thụ', 1, 'NXB Trẻ', 3, 125000, 160000, 22, 215, 2020, 4.3, 134, 'Hướng dẫn sống sẻ lành mạnh và bình yên sau 50 tuổi', 'https://images.pexels.com/photos/4439407/pexels-photo-4439407.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa mềm', '14.5 x 20.5 cm', 70, FALSE, FALSE, FALSE),
(13, 'Nhà Giả Kim', NULL, 'Paulo Coelho', 1, 'NXB Trẻ', 1, 99000, 125000, 21, 256, 2020, 4.7, 543, 'Hành trình tìm kiếm kho báu nội tâm', 'https://covers.openlibrary.org/b/id/6379847-M.jpg', 'Còn hàng', 'Bìa mềm', '14 x 20 cm', 150, TRUE, TRUE, FALSE),
(14, 'Tư Duy Nhanh và Chậm', NULL, 'Daniel Kahneman', 2, 'NXB Lao Động', 3, 155000, 195000, 20, 456, 2021, 4.8, 432, 'Khám phá hai hệ thống tư duy của con người', 'https://covers.openlibrary.org/b/id/8236101-M.jpg', 'Còn hàng', 'Bìa cứng', '15 x 22 cm', 88, FALSE, TRUE, FALSE),
(15, 'Lập Trình Python', NULL, 'Mark Lutz', 3, 'NXB Hà Nội', 4, 198000, 250000, 21, 640, 2021, 4.9, 567, 'Hướng dẫn toàn diện lập trình Python', 'https://covers.openlibrary.org/b/id/7725341-M.jpg', 'Còn hàng', 'Bìa cứng', '17 x 24 cm', 52, TRUE, TRUE, TRUE),
(16, 'Tôi Có Thể Bảo Vệ Bản Thân Mình', NULL, 'Lê Việt Hà', 1, 'NXB Trẻ', 3, 89000, 115000, 23, 200, 2021, 4.6, 223, 'Hướng dẫn tự vệ cho phụ nữ', 'https://covers.openlibrary.org/b/id/8429509-M.jpg', 'Còn hàng', 'Bìa mềm', '14 x 20 cm', 200, FALSE, FALSE, TRUE),
(17, 'Biết Chút Về Nhiều', NULL, 'Lê Minh', 4, 'NXB Kim Đồng', 1, 115000, 145000, 21, 320, 2020, 4.5, 178, 'Kiến thức tổng hợp về đa lĩnh vực', 'https://covers.openlibrary.org/b/id/8439022-M.jpg', 'Còn hàng', 'Bìa mềm', '14 x 20 cm', 95, FALSE, FALSE, FALSE),
(18, 'Kỹ Năng Quản Lý Thời Gian', NULL, 'Nguyễn Dung', 2, 'NXB Lao Động', 3, 79000, 99000, 20, 184, 2021, 4.4, 334, 'Quản lý thời gian hiệu quả', 'https://covers.openlibrary.org/b/id/8439110-M.jpg', 'Còn hàng', 'Bìa mềm', '13.5 x 19 cm', 240, FALSE, FALSE, TRUE),
(19, 'Trí Tuệ Nhân Tạo Giải Thích', NULL, 'Sebastian Thrun', 5, 'Penguin Books', 4, 210000, 270000, 22, 512, 2021, 4.8, 456, 'Hiểu biết sâu về AI và Machine Learning', 'https://books.google.com/books/content?id=ljx90QEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'Còn hàng', 'Bìa cứng', '15.5 x 23 cm', 38, TRUE, TRUE, TRUE),
(20, 'Nước Ý Xanh', NULL, 'Đặng Vũ Minh', 1, 'NXB Trẻ', 1, 135000, 168000, 20, 296, 2020, 4.7, 345, 'Tiểu thuyết lãng mạn', 'https://cdn.pixabay.com/photo/2018/02/08/14/36/book-3140662_640.jpg', 'Còn hàng', 'Bìa mềm', '14 x 20.5 cm', 120, FALSE, FALSE, FALSE),
(21, 'Bộ Não Sáng Tạo', NULL, 'David Eagleman', 5, 'Penguin Books', 3, 165000, 210000, 21, 384, 2021, 4.6, 289, 'Khám phá sức mạnh của bộ não', 'https://cdn.pixabay.com/photo/2017/08/14/02/28/stack-of-books-2638586_640.jpg', 'Còn hàng', 'Bìa cứng', '15 x 22 cm', 72, TRUE, FALSE, FALSE),
(22, 'Web Development Hiện Đại', NULL, 'Kyle Simpson', 3, 'NXB Hà Nội', 4, 189000, 240000, 21, 528, 2021, 4.9, 612, 'Hướng dẫn phát triển web hiện đại', 'https://cdn.pixabay.com/photo/2013/12/20/15/17/book-231100_640.jpg', 'Còn hàng', 'Bìa cứng', '16 x 24 cm', 66, FALSE, TRUE, TRUE),
(23, 'Tiếng Anh Thương Mại', NULL, 'John Smith', 5, 'Penguin Books', 6, 128000, 160000, 20, 272, 2021, 4.5, 198, 'Tiếng Anh chuyên nghiệp cho kinh doanh', 'https://images.pexels.com/photos/159866/books-book-pages-read-159866.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa mềm', '14 x 20 cm', 145, FALSE, FALSE, TRUE),
(24, 'Phân Tích Dữ Liệu Với Python', NULL, 'Wes McKinney', 3, 'NXB Hà Nội', 4, 195000, 250000, 22, 600, 2021, 4.8, 478, 'Phân tích dữ liệu chuyên sâu', 'https://images.pexels.com/photos/256514/pexels-photo-256514.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa cứng', '17 x 24 cm', 44, TRUE, TRUE, TRUE),
(25, 'Sáng Tạo Không Giới Hạn', NULL, 'Lê Huy Toàn', 1, 'NXB Trẻ', 3, 108000, 135000, 20, 256, 2021, 4.6, 267, 'Phát triển khả năng sáng tạo', 'https://images.pexels.com/photos/1761279/pexels-photo-1761279.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa mềm', '14 x 20 cm', 180, FALSE, FALSE, TRUE),
(26, 'Nơi Đó Có Nắng', 1, 'Nguyễn Nhật Ánh', 1, 'NXB Trẻ', 1, 98000, 125000, 22, 304, 2021, 4.7, 456, 'Chuyện tình yêu trong mưa', 'https://images.pexels.com/photos/4439407/pexels-photo-4439407.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa mềm', '14 x 20 cm', 156, TRUE, FALSE, TRUE),
(27, 'Hạnh Phúc Không Xa', NULL, 'Trương Thảo', 2, 'NXB Lao Động', 3, 85000, 110000, 23, 192, 2020, 4.4, 189, 'Hạnh phúc trong những điều giản dị', 'https://covers.openlibrary.org/b/id/6379847-M.jpg', 'Còn hàng', 'Bìa mềm', '13.5 x 19 cm', 210, FALSE, FALSE, FALSE),
(28, 'Kinh Tế Học Vi Mô', NULL, 'Paul Krugman', 5, 'Penguin Books', 2, 189000, 240000, 21, 528, 2021, 4.8, 334, 'Kiến thức kinh tế học vi mô toàn diện', 'https://covers.openlibrary.org/b/id/8236101-M.jpg', 'Còn hàng', 'Bìa cứng', '15.5 x 23 cm', 68, TRUE, TRUE, FALSE),
(29, 'Nghệ Thuật Ghi Chép', NULL, 'Sönke Ahrens', 3, 'NXB Hà Nội', 3, 145000, 185000, 22, 352, 2021, 4.7, 412, 'Ghi chép thông minh để học tập hiệu quả', 'https://covers.openlibrary.org/b/id/7725341-M.jpg', 'Còn hàng', 'Bìa cứng', '14.5 x 21 cm', 95, FALSE, TRUE, TRUE),
(30, 'Cơn Sóng Lớn', NULL, 'Margaret Mead', 4, 'NXB Kim Đồng', 1, 125000, 160000, 22, 288, 2020, 4.5, 267, 'Nhân học và xã hội học', 'https://covers.openlibrary.org/b/id/8429509-M.jpg', 'Còn hàng', 'Bìa mềm', '14 x 20.5 cm', 130, FALSE, FALSE, FALSE),
(31, 'JavaScript Tiên Tiến', NULL, 'Nicholas C. Zakas', 3, 'NXB Hà Nội', 4, 175000, 220000, 20, 608, 2021, 4.9, 589, 'Lập trình JavaScript nâng cao', 'https://covers.openlibrary.org/b/id/8439022-M.jpg', 'Còn hàng', 'Bìa cứng', '16 x 24 cm', 42, TRUE, TRUE, TRUE),
(32, 'Tâm Lý Học Tích Cực', NULL, 'Barbara L. Fredrickson', 2, 'NXB Lao Động', 3, 128000, 160000, 20, 304, 2021, 4.6, 298, 'Khám phá sức mạnh tâm lý tích cực', 'https://covers.openlibrary.org/b/id/8439110-M.jpg', 'Còn hàng', 'Bìa mềm', '14 x 20 cm', 162, FALSE, FALSE, TRUE),
(33, 'Lịch Sử Thế Giới Ngắn Gọn', NULL, 'Chris Harman', 5, 'Penguin Books', 1, 155000, 200000, 23, 456, 2020, 4.7, 378, 'Tóm tắt lịch sử nhân loại', 'https://books.google.com/books/content?id=S5iBAwAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api', 'Còn hàng', 'Bìa cứng', '15 x 22 cm', 88, TRUE, FALSE, FALSE),
(34, 'Quản Lý Dự Án Hiệu Quả', NULL, 'David Cohen', 2, 'NXB Lao Động', 2, 135000, 170000, 21, 272, 2021, 4.5, 223, 'Quản lý dự án chuyên nghiệp', 'https://cdn.pixabay.com/photo/2018/02/08/14/36/book-3140662_640.jpg', 'Còn hàng', 'Bìa mềm', '14.5 x 20.5 cm', 110, FALSE, FALSE, TRUE),
(35, 'Sức Mạnh Của Thói Quen', NULL, 'Charles Duhigg', 1, 'NXB Trẻ', 3, 125000, 160000, 22, 400, 2020, 4.8, 567, 'Thay đổi thói quen để thay đổi cuộc sống', 'https://cdn.pixabay.com/photo/2017/08/14/02/28/stack-of-books-2638586_640.jpg', 'Còn hàng', 'Bìa cứng', '14.5 x 21 cm', 145, TRUE, TRUE, FALSE),
(36, 'Database Thiết Kế', NULL, 'C.J. Date', 3, 'NXB Hà Nội', 4, 198000, 250000, 21, 560, 2021, 4.7, 289, 'Thiết kế cơ sở dữ liệu tối ưu', 'https://cdn.pixabay.com/photo/2013/12/20/15/17/book-231100_640.jpg', 'Còn hàng', 'Bìa cứng', '16 x 24 cm', 36, FALSE, TRUE, TRUE),
(37, 'Tiếng Pháp Cho Người Mới', NULL, 'Michel Thomas', 5, 'Penguin Books', 6, 135000, 175000, 23, 256, 2020, 4.5, 198, 'Học tiếng Pháp từ đầu', 'https://images.pexels.com/photos/159866/books-book-pages-read-159866.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa mềm', '14 x 20 cm', 124, FALSE, FALSE, FALSE),
(38, 'Triết Học Phương Đông', NULL, 'Alan Watts', 1, 'NXB Trẻ', 1, 105000, 135000, 22, 320, 2021, 4.6, 245, 'Hiểu biết về triết học phương Đông', 'https://images.pexels.com/photos/256514/pexels-photo-256514.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa mềm', '14 x 20.5 cm', 176, TRUE, FALSE, TRUE),
(39, 'Bán Hàng Thuyết Phục', NULL, 'Robert Cialdini', 2, 'NXB Lao Động', 2, 145000, 185000, 22, 336, 2021, 4.8, 423, 'Kỹ năng bán hàng chuyên nghiệp', 'https://images.pexels.com/photos/1761279/pexels-photo-1761279.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa cứng', '15 x 22 cm', 84, FALSE, TRUE, FALSE),
(40, 'Toán Học Thú Vị', NULL, 'Edward Frenkel', 4, 'NXB Kim Đồng', 4, 128000, 165000, 23, 384, 2020, 4.4, 167, 'Khám phá vẻ đẹp của toán học', 'https://images.pexels.com/photos/4439407/pexels-photo-4439407.jpeg?auto=compress&cs=tinysrgb&w=400&h=500&fit=crop', 'Còn hàng', 'Bìa cứng', '15.5 x 23 cm', 67, TRUE, FALSE, FALSE);

-- ================================================================================
-- 7. VERIFY DATA
-- ================================================================================
-- Xem số lượng records:
-- SELECT COUNT(*) as total_categories FROM categories;
-- SELECT COUNT(*) as total_authors FROM authors;
-- SELECT COUNT(*) as total_publishers FROM publishers;
-- SELECT COUNT(*) as total_books FROM books;

-- Xem dữ liệu:
-- SELECT * FROM categories;
-- SELECT * FROM books LIMIT 5;

-- ================================================================================
-- 8. ALTER TABLE FOR VNPAY INTEGRATION
-- ================================================================================

ALTER TABLE orders ADD COLUMN IF NOT EXISTS vnp_txn_ref VARCHAR(100);
ALTER TABLE orders ADD COLUMN IF NOT EXISTS vnp_transaction_no VARCHAR(50);
ALTER TABLE orders ADD COLUMN IF NOT EXISTS payment_status VARCHAR(20) DEFAULT 'pending';

-- ================================================================================
-- HẾT SQL SCRIPT
-- ================================================================================

