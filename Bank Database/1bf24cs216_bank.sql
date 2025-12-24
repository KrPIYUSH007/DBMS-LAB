create database bank_piyush;
show databases;
use bank_piyush;
create table branch(branchname varchar(50) primary key,branch_city varchar(50),assets real );
desc branch;
drop table branch;
create table bankaccount(accno int primary key,branch_name varchar(50),balance real,foreign key(branch_name) references branch(branchname));
desc bankaccount;
create table bankcustomer(customer_name varchar(50) primary key,customer_street varchar(50),customer_city varchar(50));
desc bankcustomer;
create table depositer(customer_name varchar(50),accno int,primary key(customer_name, accno),foreign key(customer_name) references bankcustomer(customer_name),foreign key(accno) references bankaccount(accno));
desc depositer;
create table loan(loan_number int primary key,branch_name varchar(50),amount real,foreign key(branch_name) references branch(branchname));
desc loan;
insert into branch values
('SBI_Chamrajpet','Bangalore',50000),
('SBI_ResidencyRoad','Bangalore',10000),
('SBI_ShivajiRoad','Bombay',20000),
('SBI_ParlimentRoad','Delhi',10000),
('SBI_Jantarmantar','Delhi',20000);
select * from branch;
insert into bankaccount values
(1,'SBI_Chamrajpet',2000),
(2,'SBI_ResidencyRoad',5000),
(3,'SBI_ShivajiRoad',6000),
(4,'SBI_ParlimentRoad',9000),
(5,'SBI_Jantarmantar',8000),
(6,'SBI_ShivajiRoad',4000),
(8,'SBI_ResidencyRoad',4000),
(9,'SBI_ParlimentRoad',3000),
(10,'SBI_ResidencyRoad',5000),
(11,'SBI_Jantarmantar',2000);
select * from bankaccount;
insert into bankcustomer values
('Avinash','Bull_Temple_Road','Bangalore'),
('Dinesh','Bannergatta_Road','Bangalore'),
('Mohan','NationalCollege_Road','Bangalore'),
('Nikil','Akbar_Road','Delhi'),
('Ravi','Prithviraj_Road','Delhi');
select * from bankcustomer;
insert into depositer values
('Avinash',1),
('Dinesh',2),
('Nikil',4),
('Ravi',5),
('Avinash',8),
('Nikil',9),
('Dinesh',10),
('Nikil',11);
select * from depositer;
insert into loan values
(1,'SBI_Chamrajpet',1000),
(2,'SBI_ResidencyRoad',2000),
(3,'SBI_ShivajiRoad',3000),
(4,'SBI_ParlimentRoad',4000),
(5,'SBI_Jantarmantar',5000);
select * from loan;
select branchname,(assets/100000) as assests_lakhs from branch;
select d.customer_name,b.branch_name, count(*) as num_accounts from depositer d join bankaccount b on d.accno=b.accno group by d.customer_name,b.branch_name having count(*)>=2;
create view amount_sum as select branch_name, sum(amount) as amount_total from loan group by branch_name;
select * from amount_sum;\
select distinct d.customer_name from depositer d
where d.customer_name in (select d2.customer_name from depositer d2 join bankaccount a2 on d2.accno = a2.accno join branch b2 on a2.branch_name = b2.branchname
where b2.branch_city = 'Delhi');
select distinct l.branch_name from loan l where l.branch_name not in (select distinct a.branch_name from bankaccount a);
select distinct d.customer_name
from depositer d join bankaccount a on d.accno = a.accno
join branch b on a.branch_name = b.branchname where b.branch_city = 'Bangalore'
and b.branchname in (select l.branch_name from loan l where l.branch_name = b.branchname);
select branchname from branch
where assets > all (select assets from branch where branch_city = 'Bangalore');
update bankaccount set balance = balance * 1.05;
select * from bankaccount;
delete from bankaccount
where branch_name in (select branch_name from branch where branch_city = 'Bombay');
select * from bankaccount;
ALTER TABLE depositer DROP FOREIGN KEY depositer_ibfk_2;

ALTER TABLE depositer
  ADD CONSTRAINT depositer_ibfk_2
  FOREIGN KEY (accno) REFERENCES bankaccount(accno)
  ON DELETE CASCADE;
DELETE a
FROM bankaccount a
JOIN branch b ON a.branch_name = b.branchname
WHERE b.branch_city = 'Bombay';
