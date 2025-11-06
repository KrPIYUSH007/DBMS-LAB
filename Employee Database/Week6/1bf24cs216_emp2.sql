create database employee_piyush; 
use employee_piyush;
create table dept (deptno int primary key, dname varchar(20), dloc varchar(20));
create table employee (empno int primary key, ename varchar(20), mgr_no int, hiredate date, sal int, deptno int, foreign key(deptno) references dept(deptno));
create table incentives (empno int, incentivedate date, incentiveamount int, primary key(empno,incentivedate), foreign key(empno) references employee(empno));
create table project (pno int primary key, pname varchar(20), ploc varchar(20));
create table assignedto (empno int, pno int, jobrole varchar(20), primary key(empno,pno), foreign key(empno) references employee(empno), foreign key(pno) references project(pno));

insert into dept values (10,'engineering','bengaluru'),(20,'sales','hyderabad'),(30,'hr','mysuru'),(40,'qa','pune'),
(50,'finance','chennai'),(60,'r&d','bengaluru');

insert into employee values (101,'asha',null,'2021-01-15',70000,10),(102,'rahul',101,'2021-02-10',60000,20),
(103,'meera',101,'2020-10-05',65000,30),(104,'vikram',103,'2019-07-01',80000,10),(105,'irfan',102,'2022-03-12',55000,40),
(106,'sneha',103,'2023-06-01',50000,50),(107,'kiran',104,'2021-11-11',62000,60);

insert into project values (100,'bridge','bengaluru'),(110,'nile','hyderabad'),
(120,'cauvery','mysuru'),(130,'pavement','pune'),(140,'ledger','chennai'),(150,'ai lab','bengaluru');

insert into assignedto values (101,100,'manager'),(102,110,'developer'),(103,120,'analyst'),
(104,150,'architect'),(105,130,'tester'),(106,140,'accountant'),(107,100,'researcher'),(103,100,'consultant');

insert into incentives values (101,'2023-12-01',5000),(101,'2024-06-01',3000),(102,'2023-12-15',2500),
(104,'2024-01-05',4000),(106,'2024-03-10',1500);

select distinct a.empno from assignedto a join project p on p.pno=a.pno where p.ploc in ('bengaluru','hyderabad','mysuru');
select e.empno from employee e left join incentives i on i.empno=e.empno where i.empno is null;
select e.ename,e.empno,d.dname,a.jobrole,d.dloc,p.ploc from employee e join dept d on e.deptno=d.deptno
join assignedto a on e.empno=a.empno join project p on a.pno=p.pno where d.dloc=p.ploc;

select m.ename, count(e.empno) as size from employee e join employee m on e.mgr_no=m.empno group by m.empno,m.ename order by size desc;
select m.empno ,m.ename,m.sal from employee m where m.empno in (select distinct mgr_no from employee ) and m.sal >(select avg(e.sal) from employee e where e.empno=m.mgr_no);
select d.deptno,d.dname,e.empno,e.ename from employee e join dept d on e.deptno=d.deptno where e.mgr_no in (select empno from employee where mgr_no is null) order by d.deptno ,e.empno; 
select e.ename, e.empno, e.deptno from employee e join employee m on m.empno=e.mgr_no where e.deptno=m.deptno;
insert into incentives values (106,'2019-01-16',4000),(102,'2019-01-20',3000);
select e.empno,e.ename,i.incentiveamount from employee e join incentives i on e.empno=i.empno where i.incentivedate between '2019-01-01' and '2019-01-31' order by i.incentiveamount desc limit 1 offset 1;
