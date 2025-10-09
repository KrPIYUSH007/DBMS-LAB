create database insurance_piyush;
show databases;
use insurance_piyush;
create table person( driver_id varchar(10),name varchar(20), address varchar(30), primary key(driver_id));
desc person;
create table car( reg_num varchar(10), model varchar(10),year int,primary key(reg_num));
desc car;
create table accident( report_num int, accident_date date, location varchar(20), primary key(report_num));
desc accident;
create table owns( driver_id varchar(10) ,reg_num varchar(10),
primary key(driver_id, reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num));
desc owns;
create table participated(driver_id varchar(10), reg_num varchar(10),
report_num int, damage_amount int, primary key(driver_id, reg_num, report_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num));
desc participated;
insert into person(driver_id,name,address) values('A01','Richard','Srinivas Nagar');
insert into person(driver_id,name,address) values('A02','Pradeep','Rajaji Nagar');
insert into person(driver_id,name,address) values('A03','Smith','Ashok Nagar');
insert into person(driver_id,name,address) values('A04','Venu','N R Colony');
insert into person(driver_id,name,address) values('A05','Jhon','Hanumanth Nagar');
select * from person;
insert into car(reg_num,model,year) values('KA052250','Indica','1990');
insert into car(reg_num,model,year) values('KA031181','Lancer','1957');
insert into car(reg_num,model,year) values('KA095477','Toyota','1998');
insert into car(reg_num,model,year) values('KA053408','Honda','2008');
insert into car(reg_num,model,year) values('KA041702','Audi','2005');
select * from car;
insert accident(report_num,accident_date,location) values(11,'2003-01-01','Mysore Road');
insert accident(report_num,accident_date,location) values(12,'2004-02-02','South end circle');
insert accident(report_num,accident_date,location) values(13,'2003-01-21','Bull Temple Road');
insert accident(report_num,accident_date,location) values(14,'2008-02-17','Mysore Road');
insert accident(report_num,accident_date,location) values(15,'2005-03-05','Kanakura Road');
select * from accident;
insert owns(driver_id, reg_num) values('A01','KA052250');
insert owns(driver_id, reg_num) values('A02','KA053408');
insert owns(driver_id, reg_num) values('A03','KA031181');
insert owns(driver_id, reg_num) values('A04','KA095477');
insert owns(driver_id, reg_num) values('A05','KA041702');
select * from owns;
drop table owns;
select * from owns order by driver_id asc;
insert participated( driver_id,reg_num, report_num,damage_amount)values('A01','KA052250',11,10000);
insert participated( driver_id,reg_num, report_num,damage_amount)values('A02','KA053408',12,50000);
insert participated( driver_id,reg_num, report_num,damage_amount)values('A03','KA031181',13,25000);
insert participated( driver_id,reg_num, report_num,damage_amount)values('A04','KA095477',14,3000);
insert participated( driver_id,reg_num, report_num,damage_amount)values('A05','KA041702',15,5000);
select * from participated;
select accident_date,location from accident;
select driver_id from participated where damage_amount>=25000;
update participated set damage_amount=25000 where report_num=12;
select * from participated;
insert into accident values(16,'2008-03-15','Domlur');
select * from accident;
select * from car order by year asc;
select avg (damage_amount) as average_damage from participated;
select count(*) from  car where model="Lancer";
select count(*) from car where year="2008";
select * from participated order by damage_amount desc;
delete from participated where damage_amount < (select avg(damage_amount) from participated);
select * from participated where damage_amount < (select avg(damage_amount) from participated);
select distinct p.name as driver_name from person p where exists (select * from participated d where d.driver_id = p.driver_id and d.damage_amount > (select avg(damage_amount) from participated));
select max(damage_amount) from participated;
delete from insurance_piyush.participated where damage_amount <(select * from(select avg(damage_amount) from insurance_piyush.participated)as a);
select * from participated;
