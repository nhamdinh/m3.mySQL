create database StudenTest;

/*2
	Tao cau truc 4 bang*/

create table `StudenTest`.Class
(
	 ClassID	int 	not null primary key auto_increment
	,ClassName	nvarchar(50)	not null
	,StartDate	datetime		not null
    ,Status bit

);
create table `StudenTest`.Student
(
StudentID int not null primary key 
,StudentName nvarchar(50) not null
,Address	nvarchar(50) not null
,Phone	varchar(20)
,Status bit
,ClassID int not null
);

create table `StudenTest`.Subject
(
SubID int	not null	primary key 	auto_increment
,SubName nvarchar(50) not null
,Credit tinyint not null 
default 1 
check(Credit>=1)
,Status bit default 1
);

create table `StudenTest`.Mark
(
MarkID int not null primary key auto_increment
,SubID int not null 
,StudentID int not null
,Mark float default 0
check(Mark between 0 and 100)
,ExamTimes tinyint default 1
,unique(SubID,StudentID)
);

/*3.
	--a.	Thêm ràng buộc khóa ngoại trên cột ClassID của  bảng Student
, tham chiếu đến cột ClassID trên bảng Class.*/
alter table `StudenTest`.Student
add foreign key(ClassID) references Class(ClassID);
/*3.
	--b.	Thêm ràng buộc cho cột StartDate của  bảng Class là ngày hiện hành.*/
alter table `StudenTest`.Class
add check(StartDate >=getdate());
/*3.
	--c.	Thêm ràng buộc mặc định cho cột Status của bảng Student là 1.*/
alter table `StudenTest`.Student
alter Status set default 1 ;
/*3.
	--d.	Thêm ràng buộc khóa ngoại cho bảng Mark trên cột:
-SubID trên bảng Mark tham chiếu đến cột SubID trên bảng Subject
-StudentID tren bảng Mark tham chiếu đến cột StudentID của bảng Student.*/
Alter table `StudenTest`.Mark
add foreign key(SubID) references Subject(SubID);

Alter table `StudenTest`.Mark
add foreign key(StudentID) references Student(StudentID);
/*4.
	Thêm dữ liệu vào các bảng.
	Bảng Class:
*/
		
insert into `StudenTest`.Class(ClassName,StartDate,Status)
values('A1','2015-12-25 15:30:00',1);

insert into `StudenTest`.Class(ClassName,StartDate,Status)
values('A2','2015-12-22 15:30:00',1);

insert into `StudenTest`.Class(ClassName,StartDate,Status)
values('B3',curdate(),0);

select * from `StudenTest`.Class;
/*4.
	Thêm dữ liệu vào các bảng.
	Bảng Student:
*/
insert into `StudenTest`.Student(StudentID,StudentName,Address,Phone,Status,ClassID)
values('1','Hung','Ha noi','0912113113',1,'1');

insert into `StudenTest`.Student(StudentID,StudentName,Address,Status,ClassID)
values('2','Hoa','Hai phong',1,'1');

insert into `StudenTest`.Student(StudentID,StudentName,Address,Phone,Status,ClassID)
values('3','Manh','HCM','0123123123',0,'2');

select * from `StudenTest`.Student;
/*4.
	Thêm dữ liệu vào các bảng.
	Bảng Subject:
*/
insert into `StudenTest`.Subject(SubName,Credit,Status)
values('CF','5',1);

insert into `StudenTest`.Subject(SubName,Credit,Status)
values('C','6',1);

insert into `StudenTest`.Subject(SubName,Credit,Status)
values('HDJ','5',1);

insert into `StudenTest`.Subject(SubName,Credit,Status)
values('RDBMS','10',1);

select * from `StudenTest`.Subject;

/*4.
	Thêm dữ liệu vào các bảng.
	Bảng Mark:
*/
insert into `StudenTest`.Mark(SubID,StudentID,Mark,ExamTimes)
values('1','1','8','1');

insert into `StudenTest`.Mark(SubID,StudentID,Mark,ExamTimes)
values('1','2','10','2');

insert into `StudenTest`.Mark(SubID,StudentID,Mark,ExamTimes)
values('2','1','12','1');

select * from `StudenTest`.Mark;
/*5.
	Cập nhật dữ liệu.
	--a.	Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
*/
update `StudenTest`.Student
set ClassID = '2'
where StudentName = 'Hung';

select * from `StudenTest`.Student
where StudentName = 'Hung';
/*5.
	Cập nhật dữ liệu.
	--b.	Cập nhật cột phone trên bảng sinh viên là ‘No phone’
    cho những sinh viên chưa có số điện thoại.
*/
update `StudenTest`.Student
set Phone = 'No phone'
where Phone = '' or Phone is null;

select * from `StudenTest`.Student
where Phone = 'No phone';
/*5.
	Cập nhật dữ liệu.
	--c.	Nếu trạng thái của lớp (Stutas) là 0 thì thêm từ ‘New’ vào trước tên lớp.
(Chú ý: phải sử dụng phương thức write).
*/
update `StudenTest`.Class
set ClassName = concat('New',ClassName)
where Status = 0;
select * from `StudenTest`.Class;
/*5.
	Cập nhật dữ liệu.
	--d.	Nếu trạng thái của status trên bảng Class là 1 
    và tên lớp bắt đầu là ‘New’ thì thay thế ‘New’ bằng ‘old’.
(Chú ý: phải sử dụng phương thức write)
*/
update `StudenTest`.Class
set ClassName = replace(ClassName,'New','Old') 
where Status = 1 and ClassName like 'New%';
select * from `StudenTest`.Class;
/*5.
	Cập nhật dữ liệu.
	--e.	Nếu lớp học chưa có sinh viên thì thay thế trạng thái là 0 (status=0).
*/
update `StudenTest`.Class
set Status = 0
where ClassID not in (select distinct ClassID from `StudenTest`.Student);
select * from `StudenTest`.Class;
/*5.
	Cập nhật dữ liệu.
	--f.	Cập nhật trạng thái của lớp học (bảng subject) là 0
    nếu môn học đó chưa có sinh viên dự thi.
*/
update `StudenTest`.Subject
set Status = 0
where SubID not in (select distinct SubID from `StudenTest`.Mark);
select * from `StudenTest`.Subject;
/*6.
	Hiện thị thông tin.
	--a.	Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’.
*/
select * from `StudenTest`.Student
where StudentName like 'h%';
/*6.
	Hiện thị thông tin.
	--b.	Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
*/
select * from `StudenTest`.Class
where extract(month from StartDate)=12;
/*6.
	Hiện thị thông tin.
	--c.	Hiển thị giá trị lớn nhất của credit trong bảng subject.
*/
select max(Credit) as MaxOfCredit
 from `StudenTest`.Subject;
/*6.
	Hiện thị thông tin.
	--d.	Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
*/
select * from `StudenTest`.Subject
where (Credit>2 and Credit<6);
/*6.
	Hiện thị thông tin.
	--f.	Hiển thị các thông tin bao gồm: classid, className, studentname, Address 
    từ hai bảng Class, student
*/
select `StudenTest`.Class.ClassID, `StudenTest`.Class.ClassName
, `StudenTest`.Student.StudentName,	`StudenTest`.Student.Address 
from `StudenTest`.Student
join `StudenTest`.Class on `StudenTest`.Student.ClassID = `StudenTest`.Class.ClassID;
/*6.
	Hiện thị thông tin.
	--g.	Hiển thị các thông tin môn học chưa có sinh viên dự thi.
*/
select * from `StudenTest`.Subject
where SubID not in (select SubID from `StudenTest`.Mark);
/*6.
	Hiện thị thông tin.
	--h.	Hiển thị các thông tin môn học có điểm thi lớn nhất.
*/
select `StudenTest`.Subject.SubID, `StudenTest`.Subject.SubName
, `StudenTest`.Mark.MarkID,	`StudenTest`.Mark.Mark 
from `StudenTest`.Subject		
join `StudenTest`.Mark on `StudenTest`.Subject.SubID = `StudenTest`.Mark.SubID
where `StudenTest`.Mark.Mark = (select max(`StudenTest`.Mark.Mark) from `StudenTest`.Mark);
/*6.
	Hiện thị thông tin.
	--i.	Hiển thị các thông tin sinh viên và điểm trung bình tương ứng.
*/
select `StudenTest`.Student.StudentID, `StudenTest`.Student.StudentName
, `StudenTest`.Student.Address, `StudenTest`.Student.Phone
, avg(`StudenTest`.Mark.Mark) as DTB
from `StudenTest`.Student join `StudenTest`.Mark
on `StudenTest`.Student.StudentID = `StudenTest`.Mark.StudentID
group by  StudentID;
/*6.
	Hiện thị thông tin.
	--j.	Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên,
    xếp hạng theo thứ tự điểm giảm dần (gợi ý: sử dụng hàm rank)
*/
select `StudenTest`.Student.StudentID, `StudenTest`.Student.StudentName
, `StudenTest`.Student.Address, `StudenTest`.Student.Phone
, avg(`StudenTest`.Mark.Mark) as DTBdesc
from `StudenTest`.Student left join `StudenTest`.Mark
on `StudenTest`.Student.StudentID = `StudenTest`.Mark.StudentID
group by  `StudenTest`.Student.StudentID
having (avg(`StudenTest`.Mark.Mark) >0)
order by avg(`StudenTest`.Mark.Mark) desc;
/*6.
	Hiện thị thông tin.
	--k.	Hiển thị các thông tin sinh viên và điểm trung bình,
    chỉ đưa ra các sinh viên có điểm trung bình lớn hơn 10.
*/
select `StudenTest`.Student.StudentID, `StudenTest`.Student.StudentName
, `StudenTest`.Student.Address, `StudenTest`.Student.Phone
, avg(`StudenTest`.Mark.Mark) as DTB
from `StudenTest`.Student left join `StudenTest`.Mark
on `StudenTest`.Student.StudentID = `StudenTest`.Mark.StudentID
group by  `StudenTest`.Student.StudentID
having (avg(`StudenTest`.Mark.Mark) >10);
/*6.
	Hiện thị thông tin.
	--l.	Hiển thị các thông tin: StudentName, SubName, Mark.
    Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
*/
select `StudenTest`.Student.StudentName, `StudenTest`.Subject.SubName, `StudenTest`.Mark.Mark
from `StudenTest`.Student join `StudenTest`.Mark
on `StudenTest`.Student.StudentID = `StudenTest`.Mark.StudentID
join `StudenTest`.Subject on `StudenTest`.Subject.SubID = `StudenTest`.Mark.SubID
order by Mark desc, SubName asc;
/*7.
	Xóa dữ liệu.
	--a.	Xóa tất cả các lớp có trạng thái là 0.
*/
delete from  `StudenTest`.Subject
where Status = 0;
select * from `StudenTest`.Subject;
/*7.
	Xóa dữ liệu.
	--b.	Xóa tất cả các môn học chưa có sinh viên dự thi.
*/
delete from  `StudenTest`.Subject
where SubID not in (select distinct SubID from `StudenTest`.Mark);
/*8.
	Thay đổi.
	--a.	Xóa bỏ cột ExamTimes trên bảng Mark.
*/
alter table `StudenTest`.Mark
drop column ExamTimes;
/*8.
	Thay đổi.
	--b.	Sửa đổi cột status trên bảng class thành tên ClassStatus.
*/
alter table `StudenTest`.Class
change Status ClassStatus bit;
select * from `StudenTest`.Class;
/*8.
	Thay đổi.
	--c.	Đổi tên bảng Mark thành SubjectTest.
*/
alter table `StudenTest`.Mark
rename  to  `StudenTest`.SubjectTest;
/*8.
	Thay đổi.
	--d.	Chuyển cơ sở dữ liệu hiện hành sang cơ sở dữ liệu Master.
    */
drop database `StudenTest`;