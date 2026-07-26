--=========================================================
-- TẠO DATABASE
--=========================================================
CREATE DATABASE HotelManagement;
GO

USE HotelManagement;
GO

--=========================================================
-- ROLE
--=========================================================
CREATE TABLE Role(
                     RoleID INT IDENTITY(1,1) PRIMARY KEY,
                     RoleName NVARCHAR(50) NOT NULL UNIQUE,
                     Description NVARCHAR(255),
                     Status BIT NOT NULL DEFAULT 1
);

--=========================================================
-- PERMISSION
--=========================================================
CREATE TABLE Permission(
                           PermissionID INT IDENTITY(1,1) PRIMARY KEY,
                           PermissionName NVARCHAR(100) NOT NULL,
                           PermissionCode NVARCHAR(50) NOT NULL UNIQUE,
                           Description NVARCHAR(255),
                           Status BIT DEFAULT 1
);

--=========================================================
-- ROLE_PERMISSION
--=========================================================
CREATE TABLE Role_Permission(
                                RoleID INT NOT NULL,
                                PermissionID INT NOT NULL,

                                CONSTRAINT PK_RolePermission
                                    PRIMARY KEY(RoleID,PermissionID),

                                CONSTRAINT FK_RolePermission_Role
                                    FOREIGN KEY(RoleID)
                                        REFERENCES Role(RoleID),

                                CONSTRAINT FK_RolePermission_Permission
                                    FOREIGN KEY(PermissionID)
                                        REFERENCES Permission(PermissionID)
);

--=========================================================
-- USER
--=========================================================
CREATE TABLE [User](
                       UserID INT IDENTITY(1,1) PRIMARY KEY,

    RoleID INT NOT NULL,

    FullName NVARCHAR(100) NOT NULL,

    Email VARCHAR(100) NOT NULL UNIQUE,

    Phone VARCHAR(15) UNIQUE,

    Password NVARCHAR(255) NOT NULL,

    Gender BIT,

    DateOfBirth DATE,

    CCCD VARCHAR(20) UNIQUE,

    Address NVARCHAR(255),

    Nationality NVARCHAR(50),

    Status BIT DEFAULT 1,

    CreatedAt DATETIME DEFAULT GETDATE(),

    UpdatedAt DATETIME,

    CONSTRAINT FK_User_Role
    FOREIGN KEY(RoleID)
    REFERENCES Role(RoleID)
    );

--=========================================================
-- CONTACT
--=========================================================
CREATE TABLE Contact(
                        ContactID INT IDENTITY(1,1) PRIMARY KEY,

                        UserID INT NOT NULL,

                        Subject NVARCHAR(200),

                        Content NVARCHAR(MAX),

                        Status BIT DEFAULT 0,

                        CreatedAt DATETIME DEFAULT GETDATE(),

                        CONSTRAINT FK_Contact_User
                            FOREIGN KEY(UserID)
                                REFERENCES [User](UserID)
);

--=========================================================
-- NOTIFICATION
--=========================================================
CREATE TABLE Notification(

                             NotifyID INT IDENTITY(1,1) PRIMARY KEY,

                             UserID INT NOT NULL,

                             Title NVARCHAR(200),

                             Content NVARCHAR(MAX),

                             Type NVARCHAR(50),

                             IsRead BIT DEFAULT 0,

                             CreatedAt DATETIME DEFAULT GETDATE(),

                             CONSTRAINT FK_Notification_User
                                 FOREIGN KEY(UserID)
                                     REFERENCES [User](UserID)
);

--=========================================================
-- SYSTEM_LOG
--=========================================================
CREATE TABLE System_Log(

                           LogID INT IDENTITY(1,1) PRIMARY KEY,

                           UserID INT,

                           Action NVARCHAR(100),

                           Description NVARCHAR(MAX),

                           IPAddress VARCHAR(50),

                           CreatedAt DATETIME DEFAULT GETDATE(),

                           CONSTRAINT FK_SystemLog_User
                               FOREIGN KEY(UserID)
                                   REFERENCES [User](UserID)
);

--=========================================================
-- SYSTEM_SETTING
--=========================================================
CREATE TABLE System_Setting(

                               SettingID INT IDENTITY(1,1) PRIMARY KEY,

                               HotelName NVARCHAR(200),

                               Address NVARCHAR(255),

                               Phone VARCHAR(15),

                               Email VARCHAR(100),

                               CheckInTime TIME,

                               CheckOutTime TIME,

                               CancelPolicy NVARCHAR(MAX),

                               PaymentMethods NVARCHAR(255),

                               OtherSetting NVARCHAR(MAX),

                               UpdatedAt DATETIME
);

--=========================================================
-- ROOM_CATEGORY
--=========================================================
CREATE TABLE Room_Category(
                              CategoryID INT IDENTITY(1,1) PRIMARY KEY,
                              CategoryName NVARCHAR(100) NOT NULL UNIQUE,
                              Description NVARCHAR(255),
                              BasePrice DECIMAL(18,2) NOT NULL CHECK(BasePrice>=0),
                              MaxPeople INT NOT NULL CHECK(MaxPeople>0),
                              Status BIT DEFAULT 1,
                              CreatedAt DATETIME DEFAULT GETDATE()
);

--=========================================================
-- ROOM
--=========================================================
CREATE TABLE Room(
                     RoomID INT IDENTITY(1,1) PRIMARY KEY,

                     CategoryID INT NOT NULL,

                     RoomNumber NVARCHAR(20) NOT NULL UNIQUE,

                     RoomName NVARCHAR(100),

                     Price DECIMAL(18,2) NOT NULL CHECK(Price>=0),

                     Acreage FLOAT,

                     Bed INT CHECK(Bed>0),

                     Area NVARCHAR(100),

                     Description NVARCHAR(MAX),

                     Status BIT DEFAULT 1,

                     CreatedAt DATETIME DEFAULT GETDATE(),

                     UpdatedAt DATETIME,

                     CONSTRAINT FK_Room_Category
                         FOREIGN KEY(CategoryID)
                             REFERENCES Room_Category(CategoryID)
);

--=========================================================
-- ROOM_IMAGE
--=========================================================
CREATE TABLE Room_Image(
                           ImageID INT IDENTITY(1,1) PRIMARY KEY,

                           RoomID INT NOT NULL,

                           ImageURL NVARCHAR(255) NOT NULL,

                           IsMain BIT DEFAULT 0,

                           SortOrder INT DEFAULT 1,

                           CONSTRAINT FK_RoomImage_Room
                               FOREIGN KEY(RoomID)
                                   REFERENCES Room(RoomID)
);

--=========================================================
-- ROOM_FAVORITE
--=========================================================
CREATE TABLE Room_Favorite(

                              FavoriteID INT IDENTITY(1,1) PRIMARY KEY,

                              UserID INT NOT NULL,

                              RoomID INT NOT NULL,

                              CreatedAt DATETIME DEFAULT GETDATE(),

                              CONSTRAINT FK_Favorite_User
                                  FOREIGN KEY(UserID)
                                      REFERENCES [User](UserID),

                              CONSTRAINT FK_Favorite_Room
                                  FOREIGN KEY(RoomID)
                                      REFERENCES Room(RoomID),

                              CONSTRAINT UQ_Favorite
                                  UNIQUE(UserID,RoomID)
);

--=========================================================
-- SERVICE_CATEGORY
--=========================================================
CREATE TABLE Service_Category(
                                 CategoryID INT IDENTITY(1,1) PRIMARY KEY,
                                 CategoryName NVARCHAR(100) NOT NULL UNIQUE,
                                 Description NVARCHAR(255),
                                 Status BIT DEFAULT 1
);

CREATE TABLE Service(
                        ServiceID INT IDENTITY(1,1) PRIMARY KEY,
                        CategoryID INT NOT NULL,
                        ServiceName NVARCHAR(100) NOT NULL,
                        Price DECIMAL(18,2) NOT NULL CHECK(Price>=0),
                        Unit NVARCHAR(50),
                        Description NVARCHAR(255),
                        Status BIT DEFAULT 1,
                        CONSTRAINT FK_Service_Category FOREIGN KEY(CategoryID) REFERENCES Service_Category(CategoryID)
);

--=========================================================
-- VOUCHER
--=========================================================
CREATE TABLE Voucher(
                        VoucherID INT IDENTITY(1,1) PRIMARY KEY,
                        VoucherCode NVARCHAR(50) NOT NULL UNIQUE,
                        VoucherName NVARCHAR(100) NOT NULL,
                        DiscountPercent INT CHECK(DiscountPercent BETWEEN 0 AND 100),
                        Quantity INT CHECK(Quantity>=0),
                        StartDate DATE,
                        EndDate DATE,
                        Description NVARCHAR(255),
                        Status BIT DEFAULT 1
);

--=========================================================
-- BOOKING
--=========================================================
CREATE TABLE Booking(
                        BookingID INT IDENTITY(1,1) PRIMARY KEY,
                        UserID INT NOT NULL,
                        VoucherID INT NULL,
                        BookingCode NVARCHAR(30) NOT NULL UNIQUE,
                        BookingDate DATETIME DEFAULT GETDATE(),
                        CheckIn DATE NOT NULL,
                        CheckOut DATE NOT NULL,
                        Adult INT DEFAULT 1,
                        Children INT DEFAULT 0,
                        TotalAmount DECIMAL(18,2) DEFAULT 0,
                        Status NVARCHAR(30),
                        Note NVARCHAR(255),

                        CONSTRAINT CK_Booking_Date CHECK (CheckOut > CheckIn),
                        CONSTRAINT FK_Booking_User FOREIGN KEY(UserID) REFERENCES [User](UserID),
                        CONSTRAINT FK_Booking_Voucher FOREIGN KEY(VoucherID) REFERENCES Voucher(VoucherID)
);

--=========================================================
-- BOOKING_DETAIL
--=========================================================
CREATE TABLE Booking_Detail(
                               BookingDetailID INT IDENTITY(1,1) PRIMARY KEY,
                               BookingID INT NOT NULL,
                               RoomID INT NOT NULL,
                               Price DECIMAL(18,2) NOT NULL,
                               Quantity INT DEFAULT 1,
                               Total DECIMAL(18,2) NOT NULL,
                               CONSTRAINT FK_BookingDetail_Booking FOREIGN KEY(BookingID) REFERENCES Booking(BookingID),
                               CONSTRAINT FK_BookingDetail_Room FOREIGN KEY(RoomID) REFERENCES Room(RoomID)
);

--=========================================================
-- SERVICE_USAGE
--=========================================================
CREATE TABLE Service_Usage(
                              UsageID INT IDENTITY(1,1) PRIMARY KEY,
                              BookingID INT NOT NULL,
                              ServiceID INT NOT NULL,
                              Quantity INT NOT NULL CHECK(Quantity>0),
                              UnitPrice DECIMAL(18,2) NOT NULL CHECK (UnitPrice >= 0),
                              TotalPrice DECIMAL(18,2) NOT NULL CHECK (TotalPrice >= 0),
                              CreatedAt DATETIME DEFAULT GETDATE(),
                              CONSTRAINT FK_ServiceUsage_Booking FOREIGN KEY(BookingID) REFERENCES Booking(BookingID),
                              CONSTRAINT FK_ServiceUsage_Service FOREIGN KEY(ServiceID) REFERENCES Service(ServiceID)
);

--=========================================================
-- PAYMENT
--=========================================================
CREATE TABLE Payment(
                        PaymentID INT IDENTITY(1,1) PRIMARY KEY,
                        BookingID INT NOT NULL,
                        PaymentMethod NVARCHAR(50),
                        PaymentDate DATETIME DEFAULT GETDATE(),
                        Amount DECIMAL(18,2) CHECK (Amount >= 0),
                        Status NVARCHAR(30),
                        TransactionCode NVARCHAR(100),
                        CONSTRAINT FK_Payment_Booking FOREIGN KEY(BookingID) REFERENCES Booking(BookingID)
);

--=========================================================
-- INVOICE
--=========================================================
CREATE TABLE Invoice(
                        InvoiceID INT IDENTITY(1,1) PRIMARY KEY,
                        BookingID INT NOT NULL,
                        EmployeeID INT NOT NULL,
                        InvoiceDate DATETIME DEFAULT GETDATE(),
                        TotalAmount DECIMAL(18,2) CHECK (TotalAmount >= 0),
                        VAT DECIMAL(5,2),
                        FinalAmount DECIMAL(18,2) CHECK (FinalAmount >= 0),
                        Status NVARCHAR(30),
                        CONSTRAINT FK_Invoice_Booking FOREIGN KEY(BookingID) REFERENCES Booking(BookingID),
                        CONSTRAINT FK_Invoice_User FOREIGN KEY(EmployeeID) REFERENCES [User](UserID)
);

--=========================================================
-- REVIEW
--=========================================================
CREATE TABLE Review(
                       ReviewID INT IDENTITY(1,1) PRIMARY KEY,
                       UserID INT NOT NULL,
                       RoomID INT NOT NULL,
                       Rating INT CHECK(Rating BETWEEN 1 AND 5),
                       Comment NVARCHAR(500),
                       CreatedAt DATETIME DEFAULT GETDATE(),
                       Status BIT DEFAULT 1,
                       CONSTRAINT FK_Review_User FOREIGN KEY(UserID) REFERENCES [User](UserID),
                       CONSTRAINT FK_Review_Room FOREIGN KEY(RoomID) REFERENCES Room(RoomID)
);


--=========================================================
-- INSERT ROLE
--=========================================================
INSERT INTO Role(RoleName,Description)
VALUES
    (N'Admin',N'Quản trị hệ thống'),
    (N'Manager',N'Quản lý'),
    (N'Staff',N'Nhân viên'),
    (N'Customer',N'Khách hàng');

--=========================================================
-- INSERT PERMISSION
--=========================================================
INSERT INTO Permission
(PermissionName,PermissionCode,Description)
VALUES
    (N'Quản lý người dùng','USER_MANAGE',N'CRUD User'),
    (N'Quản lý phòng','ROOM_MANAGE',N'CRUD Room'),
    (N'Quản lý đặt phòng','BOOKING_MANAGE',N'CRUD Booking'),
    (N'Quản lý hóa đơn','INVOICE_MANAGE',N'CRUD Invoice'),
    (N'Quản lý dịch vụ','SERVICE_MANAGE',N'CRUD Service'),
    (N'Quản lý Voucher','VOUCHER_MANAGE',N'CRUD Voucher');

--=========================================================
-- INSERT ROLE_PERMISSION
--=========================================================
INSERT INTO Role_Permission
VALUES
    (1,1),
    (1,2),
    (1,3),
    (1,4),
    (1,5),
    (1,6),

    (2,2),
    (2,3),
    (2,4),
    (2,5),

    (3,2),
    (3,3),
    (3,5);

--=========================================================
-- INSERT USER
--=========================================================
INSERT INTO [User]
(RoleID,FullName,Email,Phone,Password,Gender,
 DateOfBirth,CCCD,Address,Nationality)

VALUES(1,N'Nguyễn Văn Admin','admin@hotel.com','0900000001','123456',1,'1995-05-10','001111111111',N'Hà Nội',N'Việt Nam'),
    (2,N'Trần Văn Manager','manager@hotel.com','0900000002','123456',1,'1993-08-20','002222222222',N'Hà Nội',N'Việt Nam'),
    (3,N'Lê Thị Staff','staff@hotel.com','0900000003','123456',0,'1999-10-15','003333333333',N'Hà Nam',N'Việt Nam'),
    (4,N'Phạm Văn A','user1@gmail.com','0900000004','123456',1,'2001-02-01','004444444444',N'Hà Nam',N'Việt Nam'),
    (4,N'Nguyễn Thị B','user2@gmail.com','0900000005','123456',0,'2002-11-15','005555555555',N'Hải Phòng',N'Việt Nam');

--=========================================================
-- INSERT CONTACT
--=========================================================
INSERT INTO Contact
(UserID,Subject,Content)
VALUES
    (4,N'Hỏi giá phòng',N'Cho tôi hỏi phòng Deluxe còn không?'),
    (5,N'Hủy đặt phòng',N'Tôi muốn hủy booking ngày mai.');

--=========================================================
-- INSERT NOTIFICATION
--=========================================================
INSERT INTO Notification
(UserID,Title,Content,Type)
VALUES
    (4,N'Đặt phòng thành công',
     N'Cảm ơn bạn đã đặt phòng.',
     N'Booking'),

    (5,N'Khuyến mãi',
     N'Giảm giá 20% cuối tuần.',
     N'Promotion');

--=========================================================
-- INSERT SYSTEM_LOG
--=========================================================
INSERT INTO System_Log
(UserID,Action,Description,IPAddress)
VALUES
    (1,'LOGIN','Admin login','192.168.1.10'),
    (2,'UPDATE ROOM','Update room information','192.168.1.11'),
    (3,'CREATE BOOKING','Staff created booking','192.168.1.12');

--=========================================================
-- INSERT SYSTEM_SETTING
--=========================================================
INSERT INTO System_Setting(HotelName,Address,Phone,Email,CheckInTime,CheckOutTime,CancelPolicy,PaymentMethods,OtherSetting)
VALUES(N'Luxury Hotel',N'Hà Nam, Việt Nam','02263888888','contact@hotel.com','14:00','12:00',N'Hủy trước 24 giờ miễn phí.',N'Tiền mặt, Chuyển khoản',N'Wifi miễn phí, Bãi đỗ xe');

--=========================================================
-- INSERT ROOM CATEGORY
--=========================================================
INSERT INTO Room_Category
(CategoryName,Description,BasePrice,MaxPeople)
VALUES(N'Standard',N'Phòng tiêu chuẩn',500000,2),
      (N'Deluxe',N'Phòng cao cấp',900000,3),
      (N'Suite',N'Phòng hạng sang',1800000,4),
      (N'Family',N'Phòng gia đình',2500000,6);

--=========================================================
-- INSERT ROOM
--=========================================================
INSERT INTO Room(CategoryID,RoomNumber,RoomName,Price,Acreage,Bed,Area,Description)
VALUES(1,'101',N'Standard 101',500000,25,1,N'Tầng 1',N'Hướng vườn'),
      (1,'102',N'Standard 102',550000,27,2,N'Tầng 1',N'Có ban công'),
      (2,'201',N'Deluxe 201',900000,35,2,N'Tầng 2',N'View thành phố'),
      (2,'202',N'Deluxe 202',950000,38,2,N'Tầng 2',N'View hồ'),
      (3,'301',N'Suite 301',1800000,55,2,N'Tầng 3',N'Có phòng khách'),
      (4,'401',N'Family 401',2500000,65,3,N'Tầng 4',N'Gia đình 6 người');
--=========================================================
-- INSERT ROOM IMAGE
--=========================================================
INSERT INTO Room_Image
(RoomID,ImageURL,IsMain,SortOrder)
VALUES
    (1,'room101_1.jpg',1,1),
    (1,'room101_2.jpg',0,2),

    (2,'room102.jpg',1,1),

    (3,'room201_1.jpg',1,1),
    (3,'room201_2.jpg',0,2),

    (4,'room202.jpg',1,1),

    (5,'suite301_1.jpg',1,1),
    (5,'suite301_2.jpg',0,2),

    (6,'family401_1.jpg',1,1),
    (6,'family401_2.jpg',0,2);

--=========================================================
-- INSERT ROOM FAVORITE
--=========================================================
INSERT INTO Room_Favorite
(UserID,RoomID)
VALUES
    (4,1),(4,3),(5,5),(5,6);

INSERT INTO Service_Category(CategoryName,Description,Status) VALUES (N'Ăn uống',N'Đồ ăn và đồ uống',1);
INSERT INTO Service_Category(CategoryName,Description,Status) VALUES (N'Giặt ủi',N'Dịch vụ giặt ủi',1);
INSERT INTO Service_Category(CategoryName,Description,Status) VALUES (N'Giải trí',N'Dịch vụ giải trí',1);
INSERT INTO Service_Category(CategoryName,Description,Status) VALUES (N'Khác',N'Dịch vụ khác',1);

INSERT INTO Service(CategoryID,ServiceName,Price,Unit,Description,Status) VALUES (1,N'Nước suối',10000,N'Chai',N'Nước suối Lavie',1);
INSERT INTO Service(CategoryID,ServiceName,Price,Unit,Description,Status) VALUES (1,N'Mì ly',25000,N'Ly',N'Mì ăn liền',1);
INSERT INTO Service(CategoryID,ServiceName,Price,Unit,Description,Status) VALUES (2,N'Giặt quần áo',50000,N'Lần',N'Giặt và sấy',1);
INSERT INTO Service(CategoryID,ServiceName,Price,Unit,Description,Status) VALUES (3,N'Karaoke',150000,N'Giờ',N'Phòng karaoke',1);
INSERT INTO Service(CategoryID,ServiceName,Price,Unit,Description,Status) VALUES (4,N'Đưa đón sân bay',300000,N'Chuyến',N'Xe 4 chỗ',1);

INSERT INTO Voucher(VoucherCode,VoucherName,DiscountPercent,Quantity,StartDate,EndDate,Description,Status) VALUES ('VC10',N'Giảm 10%',10,100,'2026-01-01','2026-12-31',N'Áp dụng toàn hệ thống',1);
INSERT INTO Voucher(VoucherCode,VoucherName,DiscountPercent,Quantity,StartDate,EndDate,Description,Status) VALUES ('VC20',N'Giảm 20%',20,50,'2026-01-01','2026-12-31',N'Khách VIP',1);

INSERT INTO Booking(UserID,VoucherID,BookingCode,CheckIn,CheckOut,Adult,Children,TotalAmount,Status,Note) VALUES (4,1,'BK0001','2026-08-01','2026-08-03',2,1,1800000,N'Đã xác nhận',N'Phòng gần thang máy');
INSERT INTO Booking(UserID,VoucherID,BookingCode,CheckIn,CheckOut,Adult,Children,TotalAmount,Status,Note) VALUES (5,NULL,'BK0002','2026-08-05','2026-08-06',2,0,900000,N'Chờ xác nhận',N'');

INSERT INTO Booking_Detail(BookingID,RoomID,Price,Quantity,Total) VALUES (1,3,900000,2,1800000);
INSERT INTO Booking_Detail(BookingID,RoomID,Price,Quantity,Total) VALUES (2,2,900000,1,900000);

INSERT INTO Payment(BookingID,PaymentMethod,Amount,Status,TransactionCode) VALUES (1,N'Tiền mặt',1800000,N'Đã thanh toán','PM0001');

INSERT INTO Invoice(BookingID,EmployeeID,TotalAmount,VAT,FinalAmount,Status) VALUES (1,3,1800000,8,1944000,N'Đã xuất');

INSERT INTO Review(UserID,RoomID,Rating,Comment,Status) VALUES (4,3,5,N'Phòng sạch sẽ, nhân viên thân thiện.',1);
INSERT INTO Review(UserID,RoomID,Rating,Comment,Status) VALUES (5,2,4,N'Phòng đẹp, giá hợp lý.',1);

INSERT INTO Service_Usage(BookingID,ServiceID,Quantity,UnitPrice,TotalPrice) VALUES (1,1,2,10000,20000);
INSERT INTO Service_Usage(BookingID,ServiceID,Quantity,UnitPrice,TotalPrice) VALUES (1,3,1,50000,50000);
INSERT INTO Service_Usage(BookingID,ServiceID,Quantity,UnitPrice,TotalPrice) VALUES (2,2,1,25000,25000);