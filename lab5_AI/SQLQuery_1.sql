USE ABCCompany
GO

--1.	Write function name: StudenID_ Func1 with parameter @mavt, return the sum of sl*giaban corresponding.
CREATE FUNCTION dbo.QE180058_Func1(@mavt NVARCHAR(5))
RETURNS INT
AS
BEGIN
	DECLARE @res INT
	SELECT @res= SUM(SL*GIABAN)
	FROM CHITIETHOADON
	WHERE @mavt = MaVT
	RETURN @res
END;
GO

DECLARE @vt1 VARCHAR(5) = 'VT01'
DECLARE @res1 INT
SET @res1 = dbo.QE180058_Func1(@vt1)
PRINT @res1
GO

--2.	Write  function to return a total of the HoaDon (@MahD is a parameter) 
CREATE FUNCTION dbo.QE180058_Func2(@MahD NVARCHAR(10))
RETURNS INT
AS
BEGIN
	DECLARE @res  INT
	SELECT @res = ISNULL(SUM(SL*GIABAN),0)
	FROM CHITIETHOADON
	WHERE @MahD = MaHD
	RETURN @res
END
GO

DECLARE @hd2 VARCHAR(10) = 'HD001'
DECLARE @res2 INT
SET @res2 = dbo.QE180058_Func2(@hd2)
PRINT @res2
GO


--3.	Write procedure name: StudenId _Proc1, parameter @makh, @diachi. This procedure help user update @diachi corresponding @makh.


CREATE PROCEDURE dbo.QE180058_Proc1
	@makh VARCHAR(5),
	@diachi VARCHAR(50)
AS
BEGIN
	UPDATE KHACHHANG
	SET DiaChi = @diachi 
	WHERE MaKH = @makh
END;
GO

EXEC QE180058_Proc1 'KH01', 'SANTIAGO'
EXEC QE180058_Proc1 'KH02', 'RIO DE JANEIRO'
SELECT *FROM KHACHHANG
GO

--4.	Write procedure to add an item into Hoadon


CREATE PROCEDURE dbo.QE180058_Proc2
	@new_mahd  NVARCHAR(10),
	@new_ngay  DATETIME,
	@new_makh NVARCHAR(5),
	@new_TongTG INT
AS
BEGIN
	INSERT HOADON
	VALUES
		(@new_mahd, @new_ngay, @new_makh, @new_TongTG)
END;
GO

EXEC QE180058_Proc2 'HD011','2023-03-09 02:19:00.000','KH01',NULL
SELECT *FROM HOADON
GO

--5.	Write trigger name: StudenId_ Trig1 on table Chitiethoadon, 
--when user insert data into Chitiethoadon, 
--the trigger will update the Tongtien in HoaDon(student should add Tongtien column into Hoadon, tongtien=sum(sl*giaban).

CREATE TRIGGER dbo.QE180058_Trig1 ON CHITIETHOADON AFTER INSERT AS
BEGIN
	UPDATE hd
	SET TongTG = dbo.QE180058_Func2(hd.MaHD)
	FROM HOADON hd
	JOIN CHITIETHOADON cthd ON hd.MaHD = cthd.MaHD
END
GO

INSERT INTO CHITIETHOADON(MaHD,MaVT,SL,GiaBan)
VALUES('HD011','VT02',2222,55000)

SELECT * FROM CHITIETHOADON
SELECT * FROM HOADON
GO

--6.	Write view name: StudentID_View1 to extract list of customers who bought �Gach Ong�


CREATE VIEW dbo.QE180058_View1
AS
	SELECT kh.MaKH, kh.TenKH
	FROM CHITIETHOADON cthd
		INNER JOIN VATTU vt ON cthd.MaVT = vt.MaVT
		INNER JOIN HOADON hd ON cthd.MaHD = hd.MaHD
		INNER JOIN KHACHHANG kh ON hd.MaKH = kh.MaKH
	WHERE vt.TenVT = 'GACH ONG'
GO

SELECT * FROM QE180058_View1
GO