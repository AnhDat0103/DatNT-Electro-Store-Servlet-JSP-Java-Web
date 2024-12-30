USE [master]
GO

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'Electro_Store')
BEGIN
	ALTER DATABASE Electro_Store SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE Electro_Store SET ONLINE;
	DROP DATABASE Electro_Store;
END
--=========================================================================
-- create database

CREATE DATABASE Electro_Store
GO

USE Electro_Store
GO
--=========================================================================
-- create table

CREATE TABLE Roles
(
	role_id int IDENTITY(1,1) primary key,
	[name] varchar(20) NOT NULL unique,
	[description] nvarchar(255)
)


CREATE TABLE Users
(
	[user_id] int IDENTITY(1,1) primary key,
	[full_name] nvarchar(30),
	email varchar(30) NOT NULL unique,
	password varchar(30) NOT NULL,
	telephone varchar(15) NOT NULL,
	[address] nvarchar(50),
	role_id int references Roles(role_id)
)

-- Bước 1: Cho phép cột telephone nhận giá trị NULL
ALTER TABLE Users
ALTER COLUMN telephone varchar(15) NULL;

-- Bước 2: Đặt giá trị mặc định cho cột telephone
ALTER TABLE Users
ADD CONSTRAINT DF_Users_Telephone DEFAULT NULL FOR telephone;

CREATE TABLE Product_Categories
(
	category_id int IDENTITY(1,1) primary key,
	[name] nvarchar(255) NOT NULL unique,
)
alter table Product_Categories
add [description] nvarchar(max)

create table Brands
(	
	brand_id int IDENTITY(1,1) primary key,
	[name] nvarchar(255) NOT NULL unique,
	[country] nvarchar(255) NOT NULL
)

CREATE TABLE Products 
(
	product_id int IDENTITY(1,1) primary key,
	[name] nvarchar(255) NOT NULL unique,
	price DECIMAL(15, 2) NOT NULL,
	quantity int  NOT NULL DEFAULT 1,
	category_id int NOT NULL,
    brand_id int NOT NULL, 
	[description] nvarchar(max) default null,
	[image] varchar(255) default null,
	foreign key(category_id) references Product_Categories(category_id),
	foreign key(brand_id) references Brands(brand_id),
	CONSTRAINT chk_product_price_positive CHECK (price >= 0)
)

CREATE TABLE Status
(
	status_id int IDENTITY(1,1) primary key,
	status_name varchar(30) CHECK (status_name in (N'ĐANG XỬ LÝ', N'HOÀN THÀNH', N'ĐÃ HỦY')),
	[description] nvarchar(255) default null
)

CREATE TABLE Carts
(
	cart_id int IDENTITY(1,1) primary key,
	[user_id] int not null,
	total_quantity int NOT NULL DEFAULT 1,
	foreign key ([user_id]) references Users([user_id])
)

CREATE TABLE Cart_details
(
	cart_id int not null,
	product_id int not null,
	product_quantity int NOT NULL,
	product_price DECIMAL(10, 2),
	primary key(cart_id,product_id),
	FOREIGN KEY (cart_id) REFERENCES Carts(cart_id),
	FOREIGN KEY (product_id) REFERENCES Products(product_id),
	CONSTRAINT chk_cart_price_positive CHECK (product_price >= 0)
)

CREATE TABLE Deals
(	
	deal_id int IDENTITY(1,1) primary key,
	[start_date] date not null,
	[end_date] date not null,
	[percent] int not null,
	CONSTRAINT chk_date_range CHECK ([end_date] > [start_date]),
	CONSTRAINT chk_deal_percent CHECK ([percent] BETWEEN 0 AND 100)
)

CREATE TABLE Orders
(
	order_id int IDENTITY(1,1) primary key,
	order_date date NOT NULL,
	delivery_date date ,
	status_id int not null,
	total_price decimal(10,2) DEFAULT 0.00,
	[user_id] int not null,
	deal_id int default null,
	foreign key (status_id) references Status(status_id),
	foreign key ([user_id]) references Users([user_id]),
	foreign key (deal_id) references Deals(deal_id)
)

CREATE TABLE Order_details
(
	order_id int references Orders(order_id),
	product_id int references Products(product_id),
	primary key (order_id, product_id),
	product_quantity int NOT NULL,
	product_price DECIMAL(10, 2),
	CONSTRAINT chk_order_quantity_positive CHECK (product_quantity > 0)
)

--============================================================
-- them du lieu

INSERT INTO Roles ([name], [description]) VALUES
('ADMIN', N'Quản trị viên toàn hệ thống'),
('USER', N'Khách hàng sử dụng hệ thống');

--==============================================================

INSERT INTO Users ([full_name], [email], password, role_id) VALUES
(N'admin', 'admin@gmail.com', '123456', 1),
(N'Nguyễn Trọng Đạt', 'datnt@gmail.com', '123456', 2),
(N'user', 'user@gmail.com', '123456', 2);

--=============================================================

INSERT INTO Product_Categories ([name], [description]) VALUES
(N'Laptop', N'Máy tính sách tay mỏng nhẹ, mạnh mẽ.'),
(N'Máy ảnh', N'Các mẫu máy ảnh cho ra những tấm ảnh chất lượng.'),
(N'Phụ kiện điện tử', N'Các phụ kiện đi kèm như tai nghe, mic, loa,...');

--============================================================

INSERT INTO Brands ([name], [country]) VALUES
(N'Apple', N'Mỹ'),
(N'Dell', N'Mỹ'),
(N'Asus', N'Đài Loan'),
(N'HP', N'Mỹ'),
(N'Lenovo', N'Trung Quốc'),
(N'Acer', N'Đài Loan'),
(N'Microsoft', N'Mỹ'),
(N'MSI', N'Đài Loan'),
(N'Razer', N'Mỹ'),
(N'LG', N'Hàn Quốc');

--===============================================================
-- Laptop
INSERT INTO Products ([name], price, quantity, category_id, brand_id, [description], [image]) VALUES
(N'MacBook Air M2', 1199.99, 10, 1, 1, N'Máy tính xách tay mỏng nhẹ của Apple, sử dụng chip M2.', 'macbook_air_m2.jpg'),
(N'Dell XPS 13', 999.99, 8, 1, 2, N'Laptop siêu nhẹ và mạnh mẽ từ Dell.', 'dell_xps_13.jpg'),
(N'Asus ZenBook 14', 849.99, 15, 1, 3, N'Mẫu Ultrabook với màn hình OLED và thiết kế sang trọng.', 'asus_zenbook_14.jpg'),
(N'HP Spectre x360', 1399.99, 5, 1, 4, N'Laptop lai 2-trong-1 với màn hình cảm ứng.', 'hp_spectre_x360.jpg'),
(N'Lenovo ThinkPad X1 Carbon', 1299.99, 10, 1, 5, N'Dòng laptop doanh nhân hàng đầu của Lenovo.', 'thinkpad_x1_carbon.jpg'),
(N'Acer Swift 3', 699.99, 20, 1, 6, N'Laptop giá rẻ với hiệu năng ổn định.', 'acer_swift_3.jpg'),
(N'Microsoft Surface Laptop 4', 999.99, 7, 1, 7, N'Laptop với hệ điều hành Windows được tối ưu từ Microsoft.', 'surface_laptop_4.jpg'),
(N'MSI Prestige 14', 1149.99, 12, 1, 8, N'Dòng laptop cao cấp của MSI cho công việc sáng tạo.', 'msi_prestige_14.jpg'),
(N'Razer Blade Stealth 13', 1599.99, 4, 1, 9, N'Laptop mỏng nhẹ, dành cho game thủ.', 'razer_blade_stealth_13.jpg'),
(N'LG Gram 16', 1199.99, 6, 1, 10, N'Laptop siêu nhẹ với màn hình lớn.', 'lg_gram_16.jpg');

-- Máy ảnh
INSERT INTO Products ([name], price, quantity, category_id, brand_id, [description], [image]) VALUES
(N'Canon EOS R6', 2499.99, 3, 2, 1, N'Máy ảnh không gương lật chuyên nghiệp.', 'canon_eos_r6.jpg'),
(N'Sony Alpha A7 III', 1999.99, 5, 2, 2, N'Máy ảnh full-frame dành cho nhiếp ảnh gia chuyên nghiệp.', 'sony_a7_iii.jpg'),
(N'Nikon Z6 II', 1799.99, 4, 2, 3, N'Máy ảnh mirrorless với chất lượng ảnh cao.', 'nikon_z6_ii.jpg'),
( N'Fujifilm X-T4', 1699.99, 6, 2, 4, N'Máy ảnh APS-C với thiết kế cổ điển.', 'fujifilm_xt4.jpg'),
( N'Panasonic Lumix S5', 1999.99, 2, 2, 5, N'Máy ảnh mirrorless nhỏ gọn với khả năng quay video mạnh.', 'lumix_s5.jpg'),
( N'Olympus OM-D E-M1 Mark III', 1499.99, 3, 2, 6, N'Máy ảnh MFT nhỏ gọn.', 'olympus_em1_mark3.jpg'),
( N'Leica Q2', 4999.99, 1, 2, 7, N'Máy ảnh cao cấp với ống kính cố định.', 'leica_q2.jpg'),
( N'GoPro HERO11', 399.99, 20, 2, 8, N'Camera hành trình phổ biến nhất.', 'gopro_hero11.jpg'),
(N'DJI Pocket 2', 349.99, 10, 2, 9, N'Camera nhỏ gọn với gimbal tích hợp.', 'dji_pocket_2.jpg'),
( N'Canon PowerShot G7 X Mark III', 749.99, 8, 2, 10, N'Máy ảnh compact chất lượng cao.', 'powershot_g7x_mark3.jpg');

-- Phụ kiện điện tử
INSERT INTO Products ([name], price, quantity, category_id, brand_id, [description], [image]) VALUES
( N'AirPods Pro', 249.99, 30, 3, 1, N'Tai nghe không dây chống ồn của Apple.', 'airpods_pro.jpg'),
( N'JBL Flip 6', 129.99, 25, 3, 2, N'Loa bluetooth di động với âm thanh mạnh mẽ.', 'jbl_flip_6.jpg'),
( N'Sony WH-1000XM4', 349.99, 15, 3, 3, N'Tai nghe chống ồn hàng đầu.', 'sony_wh1000xm4.jpg'),
( N'Logitech MX Master 3', 99.99, 10, 3, 4, N'Chuột không dây dành cho dân văn phòng.', 'mx_master_3.jpg'),
( N'Samsung T7 Portable SSD', 149.99, 20, 3, 5, N'SSD di động tốc độ cao.', 'samsung_t7.jpg'),
(N'Corsair K70 RGB', 159.99, 10, 3, 6, N'Bàn phím cơ dành cho game thủ.', 'corsair_k70_rgb.jpg'),
( N'HyperX Cloud II', 99.99, 12, 3, 7, N'Tai nghe gaming phổ biến.', 'hyperx_cloud_ii.jpg'),
( N'Seagate Backup Plus', 89.99, 15, 3, 8, N'Ổ cứng ngoài cho lưu trữ dữ liệu.', 'seagate_backup_plus.jpg'),
( N'Anker PowerCore III', 59.99, 50, 3, 9, N'Pin sạc dự phòng dung lượng lớn.', 'anker_powercore3.jpg'),
( N'Elgato Stream Deck', 149.99, 5, 3, 10, N'Thiết bị điều khiển streaming.', 'stream_deck.jpg');

SELECT product_id, [name], image
FROM Products;

UPDATE Products
SET price = 
    CASE product_id
        WHEN 1 THEN 26000000  -- MacBook Air M2
        WHEN 2 THEN 23000000  -- Dell XPS 13
        WHEN 3 THEN 19000000  -- Asus VivoBook
        WHEN 4 THEN 32000000  -- MacBook Pro M2
        WHEN 5 THEN 30000000  -- Lenovo ThinkPad X1
        WHEN 6 THEN 15000000  -- Acer Aspire 5
        WHEN 7 THEN 22000000  -- HP Spectre x360
        WHEN 8 THEN 27000000  -- Microsoft Surface Laptop 5
        WHEN 9 THEN 40000000  -- MSI Gaming Laptop
        WHEN 10 THEN 28000000 -- LG Gram 16
        WHEN 11 THEN 12000000 -- Canon EOS 200D
        WHEN 12 THEN 18000000 -- Sony Alpha A6000
        WHEN 13 THEN 30000000 -- Nikon D7500
        WHEN 14 THEN 9000000  -- GoPro Hero 11
        WHEN 15 THEN 25000000 -- Fujifilm X-T30 II
        WHEN 16 THEN 800000   -- Tai nghe Sony WH-1000XM4
        WHEN 17 THEN 1200000  -- Chuột Logitech MX Master 3S
        WHEN 18 THEN 1500000  -- Webcam Logitech C920
        WHEN 19 THEN 1000000  -- Loa Bluetooth JBL Flip 6
        WHEN 20 THEN 300000   -- Bàn phím cơ Keychron K2
        WHEN 21 THEN 200000   -- Thẻ nhớ SanDisk Extreme 128GB
        WHEN 22 THEN 3500000  -- Ổ cứng SSD Samsung T7 1TB
        WHEN 23 THEN 500000   -- Đèn LED Razer Ring Light
        WHEN 24 THEN 750000   -- Micro Rode NT-USB Mini
        WHEN 25 THEN 1200000  -- Giá đỡ laptop Nillkin
        WHEN 26 THEN 8000000  -- iPad Air 5
        WHEN 27 THEN 16000000 -- Samsung Galaxy Tab S8
        WHEN 28 THEN 22000000 -- Dell Precision 5570
        WHEN 29 THEN 14000000 -- LG UltraFine 4K Monitor
        WHEN 30 THEN 1000000  -- Ổ cắm điện Xiaomi Mi Power Strip
    END;



