# 🏨 Hotel Management System

## 1. Project Overview

Hotel Management System là website quản lý khách sạn được xây dựng bằng Java Web theo mô hình MVC.

Hệ thống hỗ trợ:

- Quản lý tài khoản
- Quản lý phòng
- Quản lý loại phòng
- Quản lý dịch vụ
- Quản lý danh mục dịch vụ
- Quản lý voucher
- Đặt phòng
- Thanh toán
- Hóa đơn
- Đánh giá
- Thông báo
- Nhật ký hệ thống

---

# 2. Technology Stack

Backend

- Java 17
- Servlet
- JSP
- JSTL
- JDBC

Database

- SQL Server

Build Tool

- Maven

Frontend

- HTML5
- CSS3
- Bootstrap 5
- JavaScript

IDE

- IntelliJ IDEA

Server

- Apache Tomcat 10

---

# 3. Architecture

Project sử dụng mô hình MVC.

```

src

├── entity

├── dao

├── servlet

├── filter

├── utils

├── database

webapp

├── admin

├── customer

├── assets

├── WEB-INF

```

---

# 4. Database

Database đã được thiết kế hoàn chỉnh.

Bao gồm các bảng:

- Role
- Permission
- Role_Permission
- User
- Contact
- Notification
- System_Log
- System_Setting
- Room_Category
- Room
- Room_Image
- Room_Favorite
- Service_Category
- Service
- Voucher
- Booking
- Booking_Detail
- Payment
- Invoice
- Review
- Service_Usage

⚠️ Không được:

- thêm bảng
- xóa bảng
- đổi tên bảng
- đổi tên cột
- đổi kiểu dữ liệu
- sửa khóa chính
- sửa khóa ngoại

Nếu cần mở rộng, chỉ được thêm bảng mới sau khi có yêu cầu.

---

# 5. Coding Rules

Luôn sử dụng

- Java Servlet
- JSP
- JSTL
- JDBC
- SQL Server

Không sử dụng

- Spring
- Spring Boot
- Hibernate
- JPA
- MySQL
- Oracle

---

# 6. Java Coding Convention

- package viết thường

Ví dụ

```

entity

dao

servlet

utils

```

Class

```

User

Room

Booking

```

DAO

```

UserDAO

RoomDAO

BookingDAO

```

Servlet

```

LoginServlet

RoomServlet

BookingServlet

```

Method

```

findAll()

findById()

insert()

update()

delete()

search()

```

---

# 7. SQL Rules

Luôn sử dụng

- PreparedStatement

Không được

- nối chuỗi SQL
- Statement

Ví dụ

Đúng

```

SELECT * FROM Room WHERE RoomID=?

```

Sai

```

SELECT * FROM Room WHERE RoomID="+id

```

---

# 8. Validation

Bắt buộc kiểm tra

- dữ liệu rỗng
- email
- số điện thoại
- ngày nhận phòng
- ngày trả phòng
- số lượng
- giá tiền

Không được để lỗi SQL mới báo.

---

# 9. UI Rules

Sử dụng

- Bootstrap 5

Responsive

Không dùng

- React
- Vue
- Angular

---

# 10. Security

Password hiện tại chỉ là dữ liệu mẫu.

Trong thực tế nên mã hóa bằng BCrypt.

Không lưu Plain Text Password.

---

# 11. AI Instructions

Đây là quy tắc bắt buộc.

AI KHÔNG ĐƯỢC:

- đổi database
- đổi tên bảng
- đổi tên cột
- tự thêm bảng
- tự thêm cột
- tự thêm package
- tự đổi cấu trúc project

AI PHẢI:

- sử dụng đúng database
- viết đúng MVC
- code sạch
- comment đầy đủ
- có try catch
- có validation
- xử lý exception
- sử dụng PreparedStatement
- tách DAO riêng
- không viết SQL trong Servlet

---

# 12. Development Order

Thực hiện theo đúng thứ tự sau

1. Login
2. Role
3. User
4. Room Category
5. Room
6. Room Image
7. Service Category
8. Service
9. Voucher
10. Booking
11. Booking Detail
12. Payment
13. Invoice
14. Review
15. Notification
16. Contact
17. Dashboard
18. Report

---

# 13. AI Response Rules

Mỗi lần được yêu cầu sinh code:

- Chỉ làm đúng chức năng được yêu cầu.
- Không sửa code của chức năng khác.
- Không đổi cấu trúc project.
- Không đổi database.
- Không tự thêm thư viện.
- Nếu thiếu thông tin thì hỏi trước.
- Luôn ưu tiên code dễ đọc, dễ bảo trì.

---

# 14. Goal

Mục tiêu của dự án:

- Dễ bảo trì.
- Dễ mở rộng.
- Chuẩn MVC.
- Chuẩn JDBC.
- Chuẩn SQL Server.
- Có thể phát triển thành hệ thống quản lý khách sạn hoàn chỉnh.