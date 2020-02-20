create database thongdung;

create table `hamthongdung`.thongdung
(
ID int,
TEN nvarchar(20),
TUOI INT,
KHOAHOC nvarchar(20),
SOTIEN int
);

insert into `hamthongdung`.thongdung(ID, TEN, TUOI,KHOAHOC,SOTIEN)
 values (1, 'HOANG',21,'CNTT',40000)

insert into `hamthongdung`.thongdung(ID, TEN, TUOI,KHOAHOC,SOTIEN)
 values (2, 'VIET',19,'CNTT',32000)
 
insert into `hamthongdung`.thongdung(ID, TEN, TUOI,KHOAHOC,SOTIEN)
 values (3, 'THANH',18,'DTVT',40000)
 
insert into `hamthongdung`.thongdung(ID, TEN, TUOI,KHOAHOC,SOTIEN)
 values (4, 'NHAN',19,'KTDN',45000)
 
insert into `hamthongdung`.thongdung(ID, TEN, TUOI,KHOAHOC,SOTIEN)
 values (5, 'HUONG',20,'CK',50000)
 
insert into `hamthongdung`.thongdung(ID, TEN, TUOI,KHOAHOC,SOTIEN)
 values (5, 'HUONG',20,'TCNH',20000);

select * from `hamthongdung`.thongdung
where TEN = 'HUONG';

select SUM(SOTIEN) from `hamthongdung`.thongdung
where TEN = 'HUONG';

select  distinct TEN as TENHOCVIEN FROM `hamthongdung`.thongdung;