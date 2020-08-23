CREATE DATABASE Lab5
GO

USE lab5
GO 

CREATE TABLE PhongBan 
(
	MaPB varchar(7) PRIMARY KEY,
	TenPB nvarchar(50)
)
GO

 CREATE TABLE NhanVien 
 (
	MaNV varchar(7) PRIMARY KEY,
	TenNV nvarchar(50),
	NgaySinh Datetime CHECK(NgaySinh < GetDate()),
	SoCMND char(9) CHECK(SoCMND not like '%[^0-9]%'),
	GioiTinh Char(1) CHECK (GioiTinh = 'M' or GioiTinh = 'F') DEFAULT('M'),
	DiaChi nvarchar(100),
	NgayVaoLam Datetime,
	MaPB varchar(7),
	CONSTRAINT year20 CHECK(DATEDIFF(year, NgaySinh, NgayVaoLam) >20),
	CONSTRAINT FK_PhongBan FOREIGN KEY (MaPB) REFERENCES PhongBan(MaPB)
 )
 

CREATE TABLE LuongDA 
(
   MaDA varchar(8), 
   MaNV varchar(7), 
   NgayNhan Datetime NOT NULL DEFAULT(GETDATE()),
   SoTien Money CHECK (SoTien>0),
   CONSTRAINT PK_LuongDA PRIMARY KEY (MaDA, MaNV),
   CONSTRAINT FK_NhanVien FOREIGN KEY(MaNV) REFERENCES NhanVien(MaNV)
)

-- Thực hiện chèn dữ liệu vào các bảng vừa tạo (ít nhất 5 bản ghi cho mỗi bảng).
INSERT INTO PhongBan values('P1', N'Kế Toán')
INSERT INTO PhongBan values('P2', N'Nhân Sự')
INSERT INTO PhongBan values('P3', N'Hành Chính')
INSERT INTO PhongBan values('P4', N'Kinh Doanh')
INSERT INTO PhongBan values('P5', N'Đầu Tư')
INSERT INTO PhongBan values('P6', N'Dự Án')

INSERT INTO NhanVien VALUES('NV1',N'Nguyễn Văn A','1961-07-08', '123', 'M', N'Ha Noi', '2020-01-07','P1')
INSERT INTO NhanVien VALUES('NV2',N'Nguyễn Văn B','1944-09-04', '122', 'F', N'Ha Noi', '2009-05-27','P2')
INSERT INTO NhanVien VALUES('NV3',N'Nguyễn Văn C','1945-06-06', '156', 'M', N'Ha Noi', '2010-06-24','P3')
INSERT INTO NhanVien VALUES('NV4',N'Nguyễn Văn D','1978-09-04', '782', 'F', N'Ha Noi', '2005-05-23','P4')
INSERT INTO NhanVien VALUES('NV5',N'Nguyễn Văn E','1977-08-04', '355', 'M', N'Ha Noi', '2015-11-17','P5')
INSERT INTO NhanVien VALUES('NV6',N'Nguyễn Văn F','1965-05-03', '459', 'M', N'Ha Noi', '2012-10-27','P6')

INSERT INTO LuongDA VALUES('L1','NV1','2005-14-15',200)
INSERT INTO LuongDA VALUES('L2','NV2','2015-04-05',250)
INSERT INTO LuongDA VALUES('L3','NV3','2020-11-25',250)
INSERT INTO LuongDA VALUES('L4','NV4','2008-07-27',270)
INSERT INTO LuongDA VALUES('L5','NV5','2006-04-09',300)

--Viết một query để hiển thị thông tin về các bảng LUONGDA, NHANVIEN, PHONGBAN.
SELECT * FROM PhongBan
SELECT * FROM NhanVien
SELECT * FROM LuongDA

-- Viết một query để hiển thị những nhân viên có giới tính là ‘F’.
SELECT MaNV, TenNV, GioiTinh, NgaySinh, SoCMND, DiaChi, NgayVaoLam, MaPB
FROM NhanVien
WHERE GioiTinh = 'F'

--Hiển thị tất cả các dự án, mỗi dự án trên 1 dòng.
 SELECT MaDA AS'All DA'
FROM LuongDa

--.Hiển thị tổng lương của từng nhân viên (dùng mệnh đề GROUP BY).
SELECT MaDA, MaNV,NgayNhan, SUM(SoTien)
FROM LuongDA
GROUP BY  MaDA, MaNV,NgayNhan;

--.Hiển thị tất cả các nhân viên trên một phòng ban cho trước (VD: ‘Hành chính’).

SELECT MaNV, TenNV, NgaySinh, SoCMND, GioiTinh, DiaChi, NgayVaoLam, MaPB 
FROM  NhanVien 
WHERE MaPB='NV1'

--SELECT TenNV
--FROM NhanVien
--WHERE MaPB LIKE 'T101'
--GROUP BY TenNV

--SELECT TenNV
--FROM NhanVien
--     JOIN PhongBan
--	    ON PhongBan.MaPB= NhanVien.MaPB
--WHERE TenPB = N'Phòng Bạn'

--Hiển thị mức lương của những nhân viên phòng hành chính.
SELECT TenNV, SoTien, GioiTinh
FROM NhanVien
     JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
WHERE TenPB = N'Hành Chính'

--SELECT  TenNV, SoTien, GioiTinh
--     FROM nhanvienhanhchinh
--     INNER JOIN luongDA
--     ON nhanvienhanhchinh.MaNV = luongDA.MaNV;

--Hiển thị số lượng nhân viên của từng phòng.
--Hành Chính
SELECT  COUNT(*) SoLuong
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
WHERE TenPB =  N'Hành Chính'
--Nhân Sự
SELECT  COUNT(*) SoLuongNhanVienNhanSu
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
WHERE TenPB =  N'Nhân Sự'
--Kết toán
SELECT  COUNT(*) SoLuongNhanVienKeToan
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
WHERE TenPB =  N'kế Toán'
--Kinh Doanh
SELECT  COUNT(*) SoLuongNhanVienKinhDoanh
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
WHERE TenPB =  N'Kinh Doanh'
--Đầu tư
SELECT  COUNT(*) SoLuongNhanVienDauTu
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
WHERE TenPB =  N'Đầu Tư'

--Viết một query để hiển thị những nhân viên mà tham gia ít nhất vào một dự án.
SELECT * FROM LuongDA WHERE MaDA!='';

--Viết một query hiển thị phòng ban có số lượng nhân viên nhiều nhất.
SELECT MAX(MaPB) as NVMAX FROM phongban;
--SELECT * FROM PhongBan WHERE MaPB!='';

--Tính tổng số lượng của các nhân viên trong phòng Hành chính.
SELECT COUNT(*) AS N'Tổng Số Lượng Nhân Viên' 
FROM NhanVien
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
WHERE TenPB = N'Hành Chính'

-- Hiển thị tống lương của các nhân viên có số CMND tận cùng bằng 9.
SELECT right(SoCMND, 1), SoCMND
FROM nhanvien
WHERE right(SoCMND, 1) = '9'

--SELECT right(SoCMND, 1), SoCMND
--FROM nhanvien
--WHERE right(SoCMND, 1) = '9'

--SELECT * FROM NhanVien , luongDA 
--WHERE RIGHT(NhanVien.SoCMND, 1) = '9'  and NhanVien.MaNV = LuongDA.MaNV

--Tìm nhân viên có số lương cao nhất.
SELECT MAX(SoTien) as N'Lương Cao Nhất' 
FROM LuongDA
JOIN NhanVien
          ON NhanVien.MaNV = LuongDA.MaNV

--Tìm nhân viên ở phòng Hành chính có giới tính bằng ‘F’ và có mức lương > 200.
SELECT TenNV 
FROM NhanVien
    JOIN PhongBan 
	   ON PhongBan.MaPB = NhanVien.MaPB
	JOIN LuongDA
	    On LuongDA.MaNV= NhanVien.MaNV
WHERE TenPB = N'Hành Chính' AND  GioiTinh = 'F' AND SoTien > 2000 

-- Tìm tổng lương trên từng phòng.
SELECT SUM(SoTien)
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
 WHERE TenPB =  N'Nhân Sự'

 SELECT SUM(SoTien)
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
 WHERE TenPB =  N'Kế Toán'
 SELECT SUM(SoTien)
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
 WHERE TenPB =  N'Kinh Doanh'
 SELECT SUM(SoTien)
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
 WHERE TenPB =  N'Hành Chính'
 SELECT SUM(SoTien)
FROM NhanVien
JOIN LuongDA
          ON NhanVien.MaNV = LuongDA.MaNV
     JOIN PhongBan
          ON PhongBan.MaPB = NhanVien.MaPB
 WHERE TenPB =  N'Đầu Tư'
-- SELECT pb.MaPB, pb.TenPB, summoney FROM phongban pb,(
--SELECT MaPB, SUM(SoTien) AS summoney FROM nhanvien AS nv, luongDA AS luong WHERE nv.MaNV = luong.MaNV 
--GROUP BY MaPB ) result WHERE pb.MaPB = result.MaPB;
 -- Liệt kê các dự án có ít nhất 2 người tham gia.
 SELECT MaDA FROM luongDA
 GROUP By MaDA
 Having COUNT(MaNV) >= 2;
 
SELECT * FROM NhanVien
WHERE TenNV LIKE '[N]%'

-- Hiển thị thông tin chi tiết của nhân viên được nhận tiền dự án trong năm 2008
SELECT * FROM luongDA 
WHERE NgayNhan= '2008-07-27';
--Hiển thị thông tin chi tiết của nhân viên không tham gia bất cứ dự án nào.
SELECT * FROM luongDA WHERE MaDA='L2';
-- Xoá dự án có mã dự án là DXD02.
DELETE FROM luongDA WHERE MaDA='L2';
-- Xoá đi từ bảng LuongDA những nhân viên có mức lương 2000.
DELETE FROM luongDA WHERE SoTien='2000';
-- Cập nhật lại lương cho những người tham gia dự án XDX01 thêm 10% lương cũ.
UPDATE luongDA
SET SoTien = '15000'
WHERE MaDA = 'L1';
SELECT * FROM luongDA;
--Xoá các bản ghi tương ứng từ bảng NhanVien đối với những nhân viên không có mã nhân viên  tồn tại trong bảng LuongDA.
DELETE FROM NhanVien WHERE MaNV not in (SELECT MaNV FROM LuongDA );
--Viết một truy vấn đặt lại ngày vào làm của tất cả các nhân viên thuộc phòng hành chính là ngày 2020-07-16
UPDATE nhanvienhanhchinh
SET NgayVaoLam = 2020-07-16;
select * from nhanvienhanhchinh;