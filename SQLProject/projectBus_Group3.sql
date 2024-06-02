CREATE DATABASE BusManage
GO

USE BusManage
GO

--Tao Bang Hoc Sinh
CREATE TABLE HocSinh 
(
    idHocSinh VARCHAR(50) NOT NULL,
    TenHocSinh NVARCHAR(50) NOT NULL,
    GioiTinh NVARCHAR(10) NOT NULL,
    DiaChi NVARCHAR(50) NOT NULL,
    NgaySinh DATE NOT NULL,
    SoDienThoai VARCHAR(50),
    TenNguoiThan NVARCHAR(50) NOT NULL,
    SoDienThoaiNguoiThan NVARCHAR(50) NOT NULL,
    SoTien int NOT NULL,
    CONSTRAINT checkGT1 CHECK (GioiTinh in (N'nam', N'nữ')),
    CONSTRAINT idHS PRIMARY KEY (idHocSinh)
);
GO

-- Tao Bang Tai Khoan
CREATE TABLE TaiKhoan 
(
    idTaiKhoan VARCHAR(50) NOT NULL,
    TenDangNhap VARCHAR(50) NOT NULL,
    MatKhau VARCHAR(50) NOT NULL,
    idHocSinh VARCHAR(50) NOT NULL
    FOREIGN KEY (idHocSinh) REFERENCES HocSinh(idHocSinh)
    CONSTRAINT idTK PRIMARY KEY (idTaiKhoan)
);
GO

-- Tao Bang Loai Nhan Vien
CREATE TABLE LoaiNhanVien 
(
    idLoaiNhanVien VARCHAR(50) NOT NULL,
    TenLoaiNhanVien NVARCHAR(50) NOT NULL,
    CONSTRAINT idLNV PRIMARY KEY (idLoaiNhanVien)
)

-- Tao Bang Nhan Vien
CREATE TABLE NhanVien 
(
    idNhanVien VARCHAR(50) NOT NULL,
    TenNhanVien NVARCHAR(50) NOT NULL,
    GioiTinh NVARCHAR(50) NOT NULL,
    DiaChi NVARCHAR(50) NOT NULL,
    NgaySinh DATE NOT NULL,
    CCCD NVARCHAR(50) NOT NULL,
    SoDienThoai NVARCHAR(50) NOT NULL,
    Luong INT NOT NULL,
    BangCap NVARCHAR(50) NOT NULL,
    idLoaiNhanVien VARCHAR(50) NOT NULL,
    FOREIGN KEY (idLoaiNhanVien) REFERENCES LoaiNhanVien(idLoaiNhanVien),
    CONSTRAINT checkGT2 CHECK (GioiTinh in (N'nam', N'nữ')),
    CONSTRAINT idNV PRIMARY KEY (idNhanVien)
);
GO

-- Tao Bang Phuong Thuc Thanh Toan
CREATE TABLE PhuongThucThanhToan
(
    idPhuongThuc VARCHAR(50) NOT NULL, 
    TenPhuongThuc NVARCHAR(50) NOT NULL
    CONSTRAINT idPT PRIMARY KEY (idPhuongThuc)
);
GO

-- Tao Bang Xe
CREATE TABLE Xe
(
    idXe VARCHAR(50) NOT NULL,
    LoaiXe NVARCHAR(50) NOT NULL,
    BienSoXe VARCHAR(50) NOT NULL,
    SoLuongGhe INT NOT NULL,
    CONSTRAINT idX PRIMARY KEY (idXe)
);
GO

-- Tao Bang Tuyen 
CREATE TABLE Tuyen
(
    idTuyen VARCHAR(50) NOT NULL,
    GioXuatPhat TIME NOT NULL,
    GioDen TIME NOT NULL,
    BenDi NVARCHAR(50) NOT NULL,
    BenDen NVARCHAR(50) NOT NULL,
    NguoiPhuTrach VARCHAR(50) NOT NULL,
    FOREIGN KEY (NguoiPhuTrach) REFERENCES NhanVien(idNhanVien),
    Ngay DATE NOT NULL,
    idXe VARCHAR(50) NOT NULL,
    FOREIGN KEY (idXe) REFERENCES Xe(idXe),
    CONSTRAINT idT PRIMARY KEY (idTuyen)
);
GO

-- Tao Bang Tram
CREATE TABLE Tram
(
    idTram VARCHAR(50) NOT NULL,
    idTuyen VARCHAR(50) NOT NULL,
    FOREIGN KEY (idTuyen) REFERENCES Tuyen(idTuyen),
    TramXuatPhat int NOT NULL,
    TramDen int NOT NULL,
    CONSTRAINT idTram PRIMARY KEY (idTram),
    CONSTRAINT checkTram CHECK (TramXuatPhat BETWEEN 1 AND 10 AND TramDen BETWEEN 1 AND 10)
);
GO

-- Tao Bang Khuyen Mai
CREATE TABLE KhuyenMai
(
    idKhuyenMai VARCHAR(50) NOT NULL,
    TenKhuyenMai NVARCHAR(50) NOT NULL,
    NgayBatDau DATE NOT NULL,
    NgayKetThuc DATE NOT NULL,
    TyLeGiamGia INT NOT NULL
    CONSTRAINT idKM PRIMARY KEY (idKhuyenMai)
);
GO

-- Tao Bang Ve
CREATE TABLE Ve
(
    idVe VARCHAR(50) NOT NULL,
    idHocSinh VARCHAR(50) NOT NULL,
    FOREIGN KEY (idHocSinh) REFERENCES HocSinh(idHocSinh),
    NgayDatVe DATE NOT NULL,
    NgayDi DATE NOT NULL,
    GiaVe INT NOT NULL,
    NhanVienDatVe VARCHAR(50) NOT NULL,
    FOREIGN KEY (NhanVienDatVe) REFERENCES NhanVien(idNhanVien),
    MaXe VARCHAR(50) NOT NULL,
    FOREIGN KEY (MaXe) REFERENCES Xe(idXe),
    idTram VARCHAR(50) NOT NULL,
    FOREIGN KEY (idTram) REFERENCES Tram(idTram),
    idKhuyenMai VARCHAR(50),
    FOREIGN KEY (idKhuyenMai) REFERENCES KhuyenMai(idKhuyenMai),
    idPhuongThuc VARCHAR(50) NOT NULL,
    FOREIGN KEY (idPhuongThuc) REFERENCES PhuongThucThanhToan(idPhuongThuc),
    CONSTRAINT idV PRIMARY KEY (idVe)
);
GO

-- Add data to HocSinh table
INSERT INTO HocSinh (idHocSinh, TenHocSinh, GioiTinh, DiaChi, NgaySinh, SoDienThoai, TenNguoiThan, SoDienThoaiNguoiThan, SoTien)
VALUES 
('HS001', 'Nguyen Van An', N'nam', '123 ABC Street', '2005-05-10', '123456789', 'Nguyen Van Binh', '987654321', 100000),
('HS002', 'Tran Thi Bich', N'nữ', '456 XYZ Street', '2006-08-15', '987654321', 'Tran Van Chuong', '123456789', 120000),
('HS003', 'Pham Thi Cuc', N'nữ', '789 DEF Street', '2007-11-20', '456789123', 'Pham Van Dung', '321654987', 150000),
('HS004', 'Hoang Van Duy', N'nam', '321 GHI Street', '2008-02-15', '987123654', 'Hoang Thi Yen', '654987321', 180000),
('HS005', 'Nguyen Van Minh', N'nữ', '987 JKL Street', '2009-05-10', '741852963', 'Nguyen Thi Ngoc', '159263874', 120000),
('HS006', 'Tran Thi Nhi', N'nữ', '654 MNO Street', '2010-08-25', '258963147', 'Tran Van Phuoc', '963147258', 135000),
('HS007', 'Le Van Giau', N'nam', '852 PQR Street', '2011-10-30', '369852741', 'Le Thi Hong', '852741369', 110000),
('HS008', 'Hoang Thi Huong', N'nữ', '147 STU Street', '2012-12-05', '147258369', 'Hoang Van Quy', '369852147', 170000),
('HS009', 'Tran Van Sang', N'nam', '369 VWX Street', '2013-03-10', '258369147', 'Tran Thi Khue', '987654321', 130000),
('HS010', 'Nguyen Thi My', N'nữ', '258 YZ Street', '2014-07-15', '147369258', 'Nguyen Van Long', '321654987', 160000);
GO

-- Add data to TaiKhoan table
INSERT INTO TaiKhoan (idTaiKhoan, TenDangNhap, MatKhau, idHocSinh)
VALUES 
('TK001', 'user1', 'pass1', 'HS001'),
('TK002', 'user2', 'pass2', 'HS002'),
('TK003', 'user3', 'pass3', 'HS003'),
('TK004', 'user4', 'pass4', 'HS004'),
('TK005', 'user5', 'pass5', 'HS005'),
('TK006', 'user6', 'pass6', 'HS006'),
('TK007', 'user7', 'pass7', 'HS007'),
('TK008', 'user8', 'pass8', 'HS008'),
('TK009', 'user9', 'pass9', 'HS009'),
('TK010', 'user10', 'pass10', 'HS010');
GO

-- Add data to LoaiNhanVien table
INSERT INTO LoaiNhanVien (idLoaiNhanVien, TenLoaiNhanVien)
VALUES 
('LNV001', N'Quản lý'),
('LNV002', N'Nhân viên bán vé'),
('LNV003', N'Nhân viên lái xe'),
('LNV004', N'Nhân viên kiểm soát vé');
GO
delete from LoaiNhanVien

-- Add data to NhanVien table
INSERT INTO NhanVien (idNhanVien, TenNhanVien, GioiTinh, DiaChi, NgaySinh, CCCD, SoDienThoai, Luong, BangCap, idLoaiNhanVien)
VALUES 
('NV001', 'Le Van Quan', N'nam', '789 QWE Street', '1980-03-20', '123456789', '987654321', 5000000, N'Cao đẳng', 'LNV001'),
('NV002', 'Tran Thi Thao', N'nữ', '456 XYZ Street', '1995-07-25', '987654321', '123456789', 3500000, N'Đại học', 'LNV002'),
('NV003', 'Doan Van Anh', N'nam', '741 KLM Street', '1985-04-20', '963852741', '123654789', 5500000, N'Cao đẳng', 'LNV003'),
('NV004', 'Le Thi Bich', N'nữ', '369 NOP Street', '1990-09-25', '987654123', '321456987', 4000000, N'Trung cấp', 'LNV004'),
('NV005', 'Nguyen Van Hung', N'nam', '963 OPQ Street', '1988-06-15', '369852147', '147258369', 4500000, N'Cao đẳng', 'LNV003'),
('NV006', 'Tran Van Tung', N'nam', '147 RST Street', '1992-10-20', '852963741', '369147258', 4300000, N'Trung cấp', 'LNV004'),
('NV007', 'Le Thi Linh', N'nữ', '258 UVW Street', '1987-08-25', '741852963', '147369258', 4800000, N'Đại học', 'LNV003'),
('NV008', 'Pham Van Vu', N'nam', '369 XYZ Street', '1993-12-30', '963741852', '258147369', 4100000, N'Trung cấp', 'LNV004'),
('NV009', 'Hoang Thi Nuong', N'nữ', '741 YZA Street', '1989-03-05', '852741963', '963258741', 4700000, N'Cao đẳng', 'LNV003'),
('NV010', 'Doan Van Phuc', N'nam', '147 BCD Street', '1991-07-10', '741963852', '852369147', 4400000, N'Đại học', 'LNV004');
GO

-- Add data to PhuongThucThanhToan table
INSERT INTO PhuongThucThanhToan (idPhuongThuc, TenPhuongThuc)
VALUES 
('PT001', N'Tiền mặt'),
('PT002', N'Chuyển khoản'),
('PT003', N'Thẻ ngân hàng'),
('PT004', N'Ví điện tử');
GO

-- Add data to Xe table
INSERT INTO Xe (idXe, LoaiXe, BienSoXe, SoLuongGhe)
VALUES 
('X001', 'Audi', '1234-56', 16),
('X002', 'Lexus', '7890-12', 24),
('X003', 'Chevrolet', '9012-34', 16),
('X004', 'Toyota', '1357-2468', 24)
GO

-- Add data to Tuyen table
INSERT INTO Tuyen (idTuyen, GioXuatPhat, GioDen, BenDi, BenDen, NguoiPhuTrach, Ngay, idXe)
VALUES 
('T001', '07:00:00', '09:00:00', 'BenA', 'BenB', 'NV001', '2024-03-06', 'X001'),
('T002', '08:00:00', '10:00:00', 'BenA', 'BenB', 'NV002', '2024-03-07','X002'),
('T003', '09:00:00', '11:00:00', 'BenA', 'BenB', 'NV003', '2024-03-08','X003'),
('T004', '10:00:00', '12:00:00', 'BenA', 'BenB', 'NV004', '2024-03-09','X004'),
('T005', '11:00:00', '13:00:00', 'BenB', 'BenA', 'NV001', '2024-03-10','X001'),
('T006', '12:00:00', '14:00:00', 'BenB', 'BenA', 'NV002', '2024-03-11','X002'),
('T007', '13:00:00', '15:00:00', 'BenB', 'BenA', 'NV003', '2024-03-12','X003'),
('T008', '14:00:00', '16:00:00', 'BenB', 'BenA', 'NV004', '2024-03-13','X004'),
('T009', '15:00:00', '17:00:00', 'BenA', 'BenB', 'NV001', '2024-03-14','X001');
GO

-- Add data to Tram table
INSERT INTO Tram (idTram, idTuyen, TramXuatPhat, TramDen)
VALUES 
('TR001', 'T005', 1, 5),
('TR002', 'T006', 3, 7),
('TR003', 'T007', 2, 8),
('TR004', 'T008', 6, 10),
('TR005', 'T009', 4, 9),
('TR006', 'T001', 1, 10),
('TR007', 'T005', 2, 9),
('TR008', 'T006', 4, 6),
('TR009', 'T007', 5, 7),
('TR010', 'T008', 7, 8),
('TR011', 'T009', 8, 10),
('TR012', 'T003', 3, 4),
('TR013', 'T005', 10, 5),
('TR014', 'T006', 9, 3),
('TR015', 'T007', 8, 2),
('TR016', 'T008', 7, 1),
('TR017', 'T009', 6, 10),
('TR018', 'T003', 5, 9),
('TR019', 'T005', 3, 8),
('TR020', 'T006', 6, 7);
GO

-- Add data to KhuyenMai table
INSERT INTO KhuyenMai (idKhuyenMai, TenKhuyenMai, NgayBatDau, NgayKetThuc, TyLeGiamGia)
VALUES 
('KM001', N'Giảm giá mùa hè', '2024-06-01', '2024-08-31', 10),
('KM002', N'Giảm giá tháng 7', '2024-07-01', '2024-07-31', 15),
('KM003', N'Khuyến mãi sinh nhật', '2024-01-01', '2024-12-31', 25),
('KM004', N'Giảm giá đặc biệt', '2025-02-01', '2025-02-28', 35),
('KM005', N'Khuyến mãi đặc biệt', '2024-04-15', '2024-04-30', 30),
('KM006', N'Ưu đãi cuối năm', '2024-11-01', '2024-12-31', 25),
('KM007', N'Khuyến mãi năm mới', '2025-01-01', '2025-01-31', 15),
('KM008', N'Quà tặng hấp dẫn', '2026-06-01', '2026-08-31', 30);
GO

-- Add data to Ve table
INSERT INTO Ve (idVe, idHocSinh, NgayDatVe, NgayDi, GiaVe, NhanVienDatVe, MaXe, idTram, idKhuyenMai, idPhuongThuc)
VALUES 
('V001', 'HS001', '2024-03-06', '2024-03-08', 20000, 'NV002', 'X001', 'TR001', 'KM001', 'PT001'),
('V002', 'HS002', '2024-03-06', '2024-03-09', 25000, 'NV001', 'X002', 'TR002', 'KM002', 'PT002'),
('V003', 'HS003', '2024-03-09', '2024-03-09', 22000, 'NV004', 'X003', 'TR003', null, 'PT003'),
('V004', 'HS004', '2024-03-08', '2024-03-10', 26000, 'NV003', 'X004', 'TR004', 'KM004', 'PT004'),
('V005', 'HS005', '2024-03-09', '2024-03-09', 22000, 'NV004', 'X003', 'TR004', 'KM005', 'PT004'),
('V006', 'HS006', '2024-04-08', '2024-04-10', 26000, 'NV003', 'X003', 'TR006', 'KM006', 'PT003'),
('V007', 'HS007', '2024-04-09', '2024-04-11', 28000, 'NV002', 'X003', 'TR007', 'KM007', 'PT004'),
('V008', 'HS008', '2024-04-12', '2024-04-12', 30000, 'NV001', 'X002', 'TR008', 'KM008', 'PT003'),
('V009', 'HS009', '2024-05-11', '2024-05-13', 32000, 'NV004', 'X002', 'TR009', null, 'PT004'),
('V010', 'HS010', '2024-05-12', '2024-05-14', 34000, 'NV003', 'X002', 'TR010', null, 'PT003'),
('V011', 'HS003', '2024-05-15', '2024-05-15', 22000, 'NV002', 'X002', 'TR011', 'KM001', 'PT004'),
('V012', 'HS004', '2024-05-14', '2024-05-16', 24000, 'NV001', 'X001', 'TR012', 'KM002', 'PT003'),
('V013', 'HS005', '2024-05-17', '2024-05-17', 26000, 'NV004', 'X001', 'TR013', 'KM003', 'PT004'),
('V014', 'HS006', '2024-08-16', '2024-08-18', 28000, 'NV003', 'X001', 'TR014', 'KM004', 'PT003'),
('V015', 'HS007', '2024-08-17', '2024-08-19', 30000, 'NV002', 'X003', 'TR015', 'KM005', 'PT004'),
('V016', 'HS008', '2024-07-18', '2024-07-20', 32000, 'NV001', 'X001', 'TR016', 'KM006', 'PT003'),
('V017', 'HS009', '2024-07-19', '2024-07-21', 34000, 'NV004', 'X004', 'TR017', 'KM007', 'PT004'),
('V018', 'HS010', '2024-02-22', '2024-02-22', 36000, 'NV003', 'X004', 'TR018', 'KM008', 'PT003'),
('V019', 'HS003', '2024-06-21', '2024-06-23', 38000, 'NV002', 'X004', 'TR019', null, 'PT004'),
('V020', 'HS004', '2024-06-24', '2024-06-24', 40000, 'NV001', 'X004', 'TR020', null, 'PT003');
GO

/* Average distance per student, sorted in descending order by distance and amount, and in ascending order by the number of tickets.
Display id, name, gender, average distance, and total number of tickets. */
-- Note (Each consecutive station is 2km apart)
select h.idHocSinh as 'Id Hoc Sinh', h.TenHocSinh as 'Ten Hoc Sinh',
    h.GioiTinh as 'Gioi Tinh', Round(avg(ABS(t.TramXuatPhat - t.TramDen)* 2),4) as 'Quang Duong Trung Binh',
    SUM(v.GiaVe) as 'Tong So Tien', COUNT(*) as 'Tong So Ve'
from HocSinh h inner join Ve v on v.idHocSinh = h.idHocSinh
inner join Tram t on t.idTram = v.idTram
GROUP by h.idHocSinh, h.TenHocSinh, h.GioiTinh
order by 'Quang Duong Trung Binh' desc, 'Tong So Tien' desc, 'Tong So Ve'
Go

-- Display students who booked tickets with the highest total amount in the year 2024. Show the student ID, name, gender, total amount, and total number of tickets.
select h.idHocSinh as 'Id Hoc Sinh', h.TenHocSinh as 'Ten Hoc Sinh',
    h.GioiTinh as 'Gioi Tinh', SUM(v.GiaVe) as 'Tong So Tien', COUNT(*) as 'Tong So Ve'
from HocSinh h inner join Ve v on h.idHocSinh = v.idHocSinh
GROUP by h.idHocSinh, h.TenHocSinh, h.GioiTinh
having SUM(v.GiaVe) = (select MAX(TongTien)
                        from ( select sum(GiaVe) as TongTien
                                from Ve 
                                group by idHocSinh)
                        as TongTienVe)
Go

-- Calculate the percentage of tickets used in a day compared to the total tickets a student used at the 'first booking,' and display the percentage.
select ROUND(SUM(case when v.NgayDatVe = v.NgayDi then 1 else 0 end) * 100 / count(*), 4) as 'Immediate Percentage At First Time'
from Ve v
where exists(select 1
            from (select idHocSinh, min(NgayDatVe) minDate
                 from Ve
                 group by idHocSinh) as MinNgayDatVe 
                 where v.idHocSinh = MinNgayDatVe.idHocSinh AND v.NgayDatVe = MinNgayDatVe.minDate
            )
Go

-- with a ticket purchase number above 2 in 2024.
SELECT hs.idHocSinh, hs.TenHocSinh, count(v.idVe) as TotalTicket
FROM [dbo].[HocSinh] hs
LEFT JOIN [dbo].[Ve] v
ON  hs.idHocSinh = v.idHocSinh
WHERE year(v.NgayDatVe) = 2024 
GROUP BY hs.idHocSinh, hs.TenHocSinh
HAVING count(v.idVe) > 2;


-- Find top 10 male employees with salaries higher than 85000 .

SELECT TOP 10 nv.idNhanVien, nv.TenNhanVien, nv.GioiTinh, SUM(nv.Luong) as TotalSalary
FROM [dbo].[NhanVien] nv
WHERE GioiTinh = 'nam' 
GROUP BY nv.idNhanVien, nv.TenNhanVien, nv.GioiTinh
HAVING SUM(nv.Luong) > 85000
ORDER BY TotalSalary DESC;

-- displays all information of students whose gender is "female"

SELECT *
FROM dbo.HocSinh
WHERE GioiTinh = 'nữ';

--Show student ID and student name whose relative name is Nguyen Van Binh and whose phone number is 987654321
Select s.idHocSinh, s.TenHocSinh 
from HocSinh s
where s.TenNguoiThan ='Nguyen Van Binh' AND s.SoDienThoaiNguoiThan = '987654321';
go

-- Display student ID, student name and gender of students driving vehicles with license plate number 1234-56
SELECT hs.IDHocSinh, hs.GioiTinh, hs.TenHocSinh
FROM HocSinh hs
	inner join Ve v on hs.idHocSinh = v.idHocSinh
	inner join Xe x on x.idXe = v.MaXe 
where hs.GioiTinh like N'nam'
	and v.MaXe = ( SELECT s.idXe
          FROM Xe s
		  WHERE s.BienSoXe = '1234-56')
go

--- Calculate the number of students going to stations 1 to 5
Select v.idVe, Ngaydi, count(v.idHocSinh) as SoluongHocsinh, tram.idTram 
From [Ve] v
Left JOIN [tram] tram
ON  tram.idtram = v.idtram
Where tram.TramXuatPhat = 1 AND tram.TramDen = 5
GROUP BY v.idVe, v.Ngaydi, tram.idTram
go

-- Indicate student over 13 years old. Required information: TenHocSinh, NgaySinh, SoDienThoai, TenNguoiThan.
SELECT TenHocSinh, NgaySinh, SoDienThoai, TenNguoiThan
FROM HocSinh
WHERE YEAR(GETDATE()) - YEAR(NgaySinh) > 13
    OR (YEAR(GETDATE()) - YEAR(NgaySinh) = 13 AND MONTH(GETDATE()) > MONTH(NgaySinh))
    OR (YEAR(GETDATE()) - YEAR(NgaySinh) = 13 AND MONTH(GETDATE()) = MONTH(NgaySinh) AND DAY(GETDATE()) >= DAY(NgaySinh));
-- Indicate which employees go with at least two service on a bus. Required information: TenNhanVien, NgaySinh, SoDienThoai.
SELECT x.idXe, n.TenNhanVien, count(n.idNhanVien) as 'SoLanPhuTrach'
FROM Tuyen t
	inner join Xe x on x.idXe = t.idXe
	inner join NhanVien n on n.idNhanVien = t.NguoiPhuTrach
GROUP BY 
	x.idXe, n.TenNhanVien
HAVING 
count(n.idNhanVien) >= 3;

/* Indicate the total number of go bus by ticket from students who have more than 3 time. 
Required information: TenHocSinh, NgaySinh, SoDienThoai, TenNguoiThan, TongSoLanLenXe. */

SELECT t.idHocSinh, S.TenHocSinh, COUNT(T.idVe) AS TongSoLanLenXe
FROM 
    HocSinh S
INNER JOIN 
    Ve T ON S.idHocSinh = T.idHocSinh
GROUP BY 
    T.idHocSinh, S.TenHocSinh
HAVING 
    COUNT(T.idVe) > 2;

select *
from Ve

-- Create trigger when input 'Gia ve'  <  0
create trigger check_price
on Ve
after insert, update
as
	declare @giaVe int 
		select @giaVe = Giave
		from inserted
		if (@giaVe < 1)
		begin 
			print 'Price must be greater than 1'
			rollback transaction 
		end
go

INSERT INTO Ve (idVe, idHocSinh, NgayDatVe, NgayDi, GiaVe, NhanVienDatVe, MaXe, idTram, idKhuyenMai, idPhuongThuc)
values
('V021', 'HS001', '2024-03-02', '2024-03-08', -20000, 'NV002', 'X001', 'TR001', 'KM001', 'PT001')
go

-- Create trigger when input xe is not found
create trigger check_xe
on Tuyen 
after insert, update
as	
begin
	declare @idXe VARCHAR(50)
	select @idXe = idXe
	from inserted
	if not exists (select 1 from Tuyen where @idXe = idXe)
		begin
			print 'This xe is not found'
			rollback transaction
		end
end
go

-- Create function return table include information student who emloyee with id input sold ticket
create function inforStudent
(@idNhanVien VARCHAR(50))
returns @StudentTable table
(
    idHocSinh VARCHAR(50), TenHocSinh NVARCHAR(50),
    GioiTinh NVARCHAR(10), DiaChi NVARCHAR(50),
    NgaySinh DATE, SoDienThoai VARCHAR(50),
    TenNguoiThan NVARCHAR(50), SoDienThoaiNguoiThan NVARCHAR(50),
	SoLuongVe int
)
as
begin	
	insert into @StudentTable
	select h.idHocSinh, h.TenHocSinh, h.GioiTinh, h.DiaChi, h.NgaySinh, 
		   h.SoDienThoai, h.TenNguoiThan, h.SoDienThoaiNguoiThan, count(h.idHocSinh)
	from HocSinh h
		inner join Ve v on v.idHocSinh = h.idHocSinh
		inner join NhanVien n on n.idNhanVien = v.NhanVienDatVe
	where n.idNhanVien = @idNhanVien
	group by h.idHocSinh, h.TenHocSinh, h.GioiTinh, h.DiaChi, h.NgaySinh, 
	         h.SoDienThoai, h.TenNguoiThan, h.SoDienThoaiNguoiThan
	return;
end
go

declare @idNV VARCHAR(50)
set @idNV = 'NV001'
select * from dbo.inforStudent(@idNV);

--Create a procedure to calculate the total income of an employee through the total amount of tickets sold.

CREATE PROCEDURE Total_Income
    @id_nv varchar(50),
    @Total_IncomeOfNhanvien int output
AS
BEGIN
    SELECT @Total_IncomeOfNhanvien = SUM(v.GiaVe) 
    FROM NhanVien n 
    JOIN Ve v ON n.idNhanVien = v.NhanVienDatVe
    WHERE n.idNhanVien = @id_nv;
END


DECLARE @idNhanVien VARCHAR(50)
SET @idNhanVien = 'NV001'

DECLARE @Total_IncomeOfNhanvien INT
EXEC Total_Income @id_nv = @idNhanVien, @Total_IncomeOfNhanvien = @Total_IncomeOfNhanvien OUTPUT

SELECT @Total_IncomeOfNhanvien AS Total_IncomeOfNhanvien

-- Display employees and their salaries if salary is lower than 4000000 then increase to 5000000
create function Salary (@luong int)
returns nvarchar(50)
as 
begin
if(@luong < 5000000)
return 5000000;
else 
return @luong ;
return N' không có dữ liệu';
end;
select dbo.Salary (Luong) as Lương,TenNhanVien from NhanVien

--Create a stored procedure named that fetches employee information from the NhanVien table and prints it out.
CREATE PROCEDURE DisplayEmployeeInfo
AS
BEGIN
    DECLARE @idNhanVien VARCHAR(50);
    DECLARE @TenNhanVien NVARCHAR(50);
    DECLARE @Luong DECIMAL(10, 2);

    DECLARE employee_cursor CURSOR FOR
    SELECT idNhanVien, TenNhanVien, Luong
    FROM NhanVien;

    OPEN employee_cursor;

    FETCH NEXT FROM employee_cursor INTO @idNhanVien, @TenNhanVien, @Luong;
    WHILE @@FETCH_STATUS = 0
    BEGIN

         PRINT 'EmployeeID: ' + @idNhanVien + N', Tên: ' + @TenNhanVien + N', Lương: ' + CONVERT(VARCHAR(20), @Luong);
        
        FETCH NEXT FROM employee_cursor INTO @idNhanVien, @TenNhanVien, @Luong;
    END

    CLOSE employee_cursor;
    DEALLOCATE employee_cursor;
END;

EXECUTE DisplayEmployeeInfo;