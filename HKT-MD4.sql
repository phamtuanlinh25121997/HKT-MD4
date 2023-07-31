create database QLSV;
use QLSV;

create table dmkhoa(
MaKhoa varchar(20) primary key,
TenKhoa varchar(255)
);

create table dmnganh(
MaNganh int primary key ,
TenNganh varchar(255),
MaKhoa varchar(20),
foreign key (MaKhoa) references dmkhoa(MaKhoa)
);
 
 create table dmlop(
 MaLop varchar(20) primary key,
 TenLop varchar(255),
 MaNganh int ,
 KhoaHoc int ,
 HeDT varchar(255),
 NamNhapHoc int,
 foreign key (MaNganh) references dmnganh(MaNganh)
 );
 
 create table dmhocphan(
 MaHP int primary key,
 TenHP varchar(255),
 Sodvht int,
 MaNganh int,
 HocKy int ,
 foreign key (MaNganh) references dmnganh(MaNganh)
 );
 
 create table  sinhvien(
 MaSV int primary key,
 HoTen varchar(255),
 MaLop varchar(20) ,
 GioiTinh tinyint(1),
 NgaySinh date,
 DiaChi varchar(255),
 foreign key (MaLop) references dmlop(MaLop)
 );
 
 create table  diemhp(
 MaSV int,
 MaHP int,
 DiemHP float,
 foreign key (MaSV) references sinhvien(MaSV),
 foreign key (MaHP) references dmhocphan(MaHP),
 primary key(MaSV,MaHP)
 );
 
 insert into dmkhoa() 
 values
 ('CNTT','Công nghệ thông tin'),
 ('KT','Kế Toán'),
 ('SP','Sư phạm');
 
 insert into dmnganh()
 values
 ('140902','Sư phạm toán tin','SP'),
 ('480202','Tin học ứng dụng','CNTT');
 
 insert into dmlop()
 values
 ('CT11','Cao đẳng tin học',480202,11,'TC',2013),
 ('CT12','Cao đẳng tin học',480202,12,'TC',2013),
 ('CT13','Cao đẳng tin học',480202,13,'TC',2014);
 
 insert into dmhocphan()
 values
 (1,'Toán cao câp A1',4,480202,1),
 (2,'Tiếng anh1',3,480202,1),
 (3,'Vật lý đại cương',4,480202,1),
 (4,'Tiếng anh 2',7,480202,1),
 (5,'Tiếng anh 1',3,140902,2),
 (6,'Xác xuất thống kê',3,480202,2);
 
 insert into sinhvien()
 values
 (1,'Phan Thanh','CT12','0','1990-09-12','Tuy Phước'),
 (2,'Nguyễn Thị Cấm','CT12','1','1994-01-12','Quy Nhơn'),
 (3,'Võ THị Hà','CT12','1','1995-07-02','An Nhơn'),
 (4,'Trần Hoài Nam','CT12','0','1994-04-05','Tây Sơn'),
 (5,'Trần Văn Hoàng','CT13','0','1995-08-04','Vĩnh Thạnh'),
 (6,'Đặng Thị Thảo','CT13','1','1995-06-12','Quy Nhơn'),
 (7,'Lê Thị Sen','CT13','1','1994-08-12','Phù Mỹ'),
 (8,'Nguyễn Văn Huy','CT11','0','1995-06-04','Tuy Phước'),
 (9,'Trần THị Hoa','CT11','1','1994-05-09','Hoài Nhơn');
 
 insert into diemhp()
 values
 (2,2,5.9),
 (2,3,4.5),
 (3,1,4.3),
 (3,2,6.7),
 (3,3,7.3),
 (4,1,4),
 (4,2,5.2),
 (4,3,3.5),
 (5,1,9.8),
 (5,2,7.9),
 (5,3,7.5),
 (6,1,6.1),
 (6,2,5.6),
 (6,3,5.4),
 (2,1,6.2);
 
--  1.	 Hiển thị danh sách gồm MaSV, HoTên, MaLop, DiemHP, MaHP của những sinh viên có điểm HP >= 5    
select sv.MaSV,sv.HoTen,sv.MaLop,dhp.DiemHP,dhp.MaHP from sinhvien sv join diemhp dhp on sv.MaSV = dhp.MaSV
where dhp.DiemHP >=5;


-- 2.	Hiển thị danh sách MaSV, HoTen, MaLop, MaHP, DiemHP, MaHP được sắp xếp theo ưu tiên MaLop, HoTen tăng dần
select sv.MaSV,sv.HoTen,sv.MaLop,dhp.DiemHP,dhp.MaHP from sinhvien sv join diemhp dhp on sv.MaSV = dhp.MaSV
order by sv.MaLop asc , sv.HoTen asc;


-- 3.	Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, HocKy của những sinh viên có DiemHP từ 5  7 ở học kỳ I. (5đ)
select sv.MaSV,sv.HoTen,sv.MaLop,dhp.DiemHP,dmhp.HocKy from sinhvien sv join diemhp dhp on sv.MaSV = dhp.MaSV join dmhocphan dmhp on dhp.MaHP = dmhp.MaHP
where dhp.DiemHP between 5 and 7;


-- 4.	Hiển thị danh sách sinh viên gồm MaSV, HoTen, MaLop, TenLop, MaKhoa của Khoa có mã CNTT (5đ)
select sv.MaSV,sv.HoTen,sv.MaLop,dl.TenLop,dn.MaKhoa from sinhvien sv join dmlop dl on sv.MaLop = dl.MaLop join dmnganh dn on dl.Manganh = dn.Manganh
where dn.MaKhoa like 'CNTT';


-- 5.	Cho biết MaLop, TenLop, tổng số sinh viên của mỗi lớp (SiSo): (5đ)
select sv.MaLop,dl.TenLop,count(*) as siso from sinhvien sv join dmlop dl on sv.MaLop = dl.MaLop
group by sv.MaLop,dl.TenLop;


-- 6    Cho biết điểm trung bình chung của mỗi sinh viên ở mỗi học kỳ, biết công thức tính DiemTBC như sau:
-- DiemTBC = ∑▒〖(DiemHP*Sodvhp)/∑(Sodvhp)〗
select HocKy, hp.MaSV,Sum(diemHP * Sodvht)/Sum(Sodvht) DiemTBC from diemhp hp join dmhocphan dmhp on hp.MaHP = dmhp.MaHP
where dmhp.Hocky = 1
group by hp.MaSV
order by hp.MaSV;


-- 7.	Cho biết MaLop, TenLop, số lượng nam nữ theo từng lớp.
SELECT lop.MaLop, lop.TenLop,
    SUM(CASE WHEN sv.GioiTinh = 1 THEN 1 ELSE 0 END) AS SoNam,
    SUM(CASE WHEN sv.GioiTinh = 0 THEN 1 ELSE 0 END) AS SoNu
FROM DmLop lop
LEFT JOIN SinhVien sv ON lop.MaLop = sv.MaLop
GROUP BY lop.MaLop, lop.TenLop;


-- 8    Cho biết điểm trung bình chung của mỗi sinh viên ở học kỳ 1
-- Biết: DiemTBC = ∑▒〖(DiemHP*Sodvhp)/∑(Sodvhp)〗
select  hp.MaSV,Sum(diemHP * Sodvht)/Sum(Sodvht) DiemTBC from diemhp hp join dmhocphan dmhp on hp.MaHP = dmhp.MaHP
where dmhp.Hocky = 1
group by hp.MaSV;


-- 9.	Cho biết MaSV, HoTen, Số các học phần thiếu điểm (DiemHP<5) của mỗi sinh viên
select sv.MaSV, HoTen,count(diemHP < 5) SLuong from sinhvien sv join diemhp hp on sv.MaSV = hp.MaSV
where diemHP < 5
group by MaSV;


-- 10. Số sinh viên có điểm HP < 5 của mỗi học phần
SELECT dh.MaHP, COUNT(sv.MaSV) AS SoSinhVienThieuDiem
FROM SinhVien sv
JOIN DiemHp dh ON sv.MaSV = dh.MaSV
WHERE dh.DiemHP < 5
GROUP BY dh.MaHP;

-- 11. Tổng số đơn vị học trình có điểm HP < 5 của mỗi sinh viên
SELECT sv.MaSV, sv.HoTen, SUM(hp.SOdvht) AS TongDvhtThieuDiem
FROM SinhVien sv
JOIN DiemHp dh ON sv.MaSV = dh.MaSV
JOIN DmHocPhan hp ON dh.MaHP = hp.MaHP
WHERE dh.DiemHP < 5
GROUP BY sv.MaSV, sv.HoTen
order by sv.MaSv;

-- 12. MaLop, TenLop có tổng số sinh viên > 2
SELECT lop.MaLop, lop.TenLop, Count(*) as siso
FROM DmLop lop
LEFT JOIN SinhVien sv ON lop.MaLop = sv.MaLop
GROUP BY lop.MaLop, lop.TenLop
HAVING COUNT(sv.MaSV) > 2;

-- 13. HoTen sinh viên có ít nhất 2 học phần có điểm < 5
SELECT sv.MaSv,sv.HoTen,  count(*)  as SoLuong
FROM SinhVien sv
JOIN DiemHp dh ON sv.MaSV = dh.MaSV
WHERE dh.DiemHP < 5
GROUP BY sv.HoTen, sv.MaSv
HAVING COUNT(DISTINCT dh.MaHP) >= 2;

-- 14. HoTen sinh viên học ít nhất 3 học phần mã 1,2,3
SELECT sv.HoTen, count(*) as SoLuong
FROM SinhVien sv
JOIN DiemHp dh ON sv.MaSV = dh.MaSV
WHERE dh.MaHP IN (1, 2, 3)
GROUP BY sv.HoTen
HAVING COUNT(DISTINCT dh.MaHP) >= 3;