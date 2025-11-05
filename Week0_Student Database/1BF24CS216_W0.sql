show databases;
create database piyush_01;
show databases;
use piyush_01;
create table uno
(
name varchar(20)
);
insert into uno values("piyush");
insert into uno values("omakr");
select * from uno;
insert into uno values("ishu");
show databases;
create database piyush_03;
use piyush_03;

create table student(
stdid int(5), stdname varchar(20), dob date, doj date, fee int(5), gender char );
desc student;
insert into student (stdid, stdname, dob, doj, fee, gender)
values(1, 'PIYUSH', '2005-01-10', '2015-10-05', 10000, 'M');
insert into student (stdid, stdname, dob, doj, fee, gender)
values(2, 'OMKAR', '2005-10-11', '2016-10-05', 20000, 'M');
alter table student add PHONE_NO varchar(10);
alter table STUDENT;
SELECT * FROM STUDENT;
ALTER TABLE student DROP COLUMN gender;
DELETE FROM student WHERE STDID = 2;