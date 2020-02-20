/*[Thực hành] Thao tác với bảng
*/
create database DESIGNDATABASE;
/* Tạo bảng mới
*/
create table `DESIGNDATABASE`.contacts
( 
contact_id int(11) not null auto_increment
,last_name varchar(30) not null
,first_name varchar(25)
,birthday date
,constraint contacts_pk primary key (contact_id)
);
create table `DESIGNDATABASE`.suppliers
( 
supplier_id int(11) not null auto_increment
,supplier_name varchar(30) not null
,account_rep varchar(30) not null default 'TBD'
,constraint suppliers_pk primary key (supplier_id)
);
/* Xoá bảng
*/
drop table `DESIGNDATABASE`.contacts, `DESIGNDATABASE`.suppliers;
/* Chỉnh sửa bảng
*/
alter table `DESIGNDATABASE`.contacts
  add column last_name1 varchar(40) not null
    after contact_id,
  add column first_name1 varchar(35) null
    after last_name;

alter table `DESIGNDATABASE`.contacts
  drop column last_name1;
  
alter table `DESIGNDATABASE`.contacts
  change column first_name1 first_name2
    varchar(20) not null;
    
alter table `DESIGNDATABASE`.contacts
  rename to `DESIGNDATABASE`.people;
  /*[Thực hành] Tạo khoá chính
*/
create table `DESIGNDATABASE`.users
(
   user_id int auto_increment primary key,
   username varchar(40),
   password varchar(255),
   email varchar(255)
);
create table `DESIGNDATABASE`.roles
(
   role_id int auto_increment,
   role_name varchar(50),
   primary key(role_id)
);
create table `DESIGNDATABASE`.userroles
(
   user_id int not null,
   role_id int not null,
   primary key(user_id,role_id),
   foreign key (user_id) references users(user_id),
   foreign key (role_id) references roles(role_id)
);
  /*[Thực hành] Tạo khoá ngoại
*/
create table `DESIGNDATABASE`.customers
(
   id int auto_increment primary key,
   name varchar(40),
   address varchar(255),
   email varchar(255)
);
create table `DESIGNDATABASE`.orders
(
   id int auto_increment,
   staff varchar(50),
   primary key (id),
   customer_id int,
   foreign key  (customer_id) references customers(id)
);