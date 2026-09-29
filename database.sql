USE master;
GO
DROP DATABASE IF EXISTS WebProgrammingSecurity
GO
-- 1. Tạo Database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'WebProgrammingSecurity')
BEGIN
    CREATE DATABASE WebProgrammingSecurity;
END
GO

USE WebProgrammingSecurity;
GO

-- Thêm dữ dữ liệu

-- 1. Thêm Roles
IF NOT EXISTS (SELECT 1 FROM roles WHERE name = 'ROLE_USER')
    INSERT INTO roles (name) VALUES ('ROLE_USER');
IF NOT EXISTS (SELECT 1 FROM roles WHERE name = 'ROLE_ADMIN')
    INSERT INTO roles (name) VALUES ('ROLE_ADMIN');
GO
-- 2. Thêm Users với mật khẩu BCrypt chuẩn của 123456
INSERT INTO users (username, email, password, full_name, enabled, role_id)
VALUES 
('admin', 'admin@gmail.com', '$2a$10$JQEGJ8Dztce15dm0.HuuKe0eaOYzbw6Osvsam8C8KH8gVRmHXYKk2', N'Administrator', 1, (SELECT TOP 1 id FROM roles WHERE name = 'ROLE_ADMIN')),
('user', 'user@gmail.com', '$2a$10$JQEGJ8Dztce15dm0.HuuKe0eaOYzbw6Osvsam8C8KH8gVRmHXYKk2', N'Lê Đại Thông', 1, (SELECT TOP 1 id FROM roles WHERE name = 'ROLE_USER'));
GO

-- 4. Insert dữ liệu mẫu cho bảng products
INSERT INTO products (name, description, price, image_url, user_id, created_at)
VALUES 
(N'Điện thoại Oppo A95', N'Điện thoại Oppo A95 chính hãng', 656565656.00, 'https://res.cloudinary.com/demo/image/upload/v1/shop/products/sample1.jpg|shop/products/sample1', (SELECT TOP 1 id FROM users WHERE username = 'user'), GETDATE()),
(N'Điện thoại Oppo A11', N'Điện thoại Oppo A11 chính hãng', 689990.00, 'https://res.cloudinary.com/demo/image/upload/v1/shop/products/sample2.jpg|shop/products/sample2', (SELECT TOP 1 id FROM users WHERE username = 'user'), GETDATE());
GO
