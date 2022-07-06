create table employee(
id int,
firstname varchar(20) not null,
middlename varchar(20),
lastname varchar(20) not null,
age int not null,
salary int not null,
location varchar(20) not null default 'bangalore',
primary key(id, firstname)
);

insert into employee (id, firstname, lastname, age, salary) values (1, 'rajesh', 'sharma', 28, 100000);

insert into employee (id, firstname, lastname, age, salary) values (null, 'rajesh', 'sharma', 28, 100000);

drop table employee;

create table employee(
id int auto_increment,
firstname varchar(20) not null,
middlename varchar(20),
lastname varchar(20) not null,
age int not null,
salary int not null,
location varchar(20) not null default 'bangalore',
primary key(id)
);

insert into employee (id, firstname, lastname, age, salary) values ('rajesh', 'sharma', 28, 100000);

Unique key
==========

create table employee(
firstname varchar(20) not null,
lastname varchar(20) not null,
age int not null,
primary key(firstname, lastname)
);

desc employee;

insert into employee values ('rajesh', 'sharma', 28);
insert into employee values ('rajesh', 'sharma', 30);

create table employee(
id int,
firstname varchar(20),
lastname varchar(20),
age int not null,
unique key (id, firstname)
);

desc employee;

insert into employee values(1, 'kapil', 'sharma');

insert into employee values(null, 'kapil', 'sharma');

select * from employee;

drop database abc;

create database abc;

use abc;

desc employee;

select * from employee;

select firstname,lastname from employee;

select * from employee where age > 29;

select * from employee where firstname = 'maneesh';

Case sensitive:
select * from employee where binary firstname = 'maneesh';

select firstname as Name, lastname as Surname from employee;

update employee set lastname = 'sinha' where firstname = 'maneesh';

update employee set location = 'Hyderabad' where firstname = 'kapil';

update employee set location = 'Hyderabad';

update employee set salary = salary+5000;

update employee set location = 'bangalore' where firstname = 'maneesh' and lastname = 'malhotra';

select * from employee;

delete from employee where id = 3;

delete from employee;

select * from employee;

desc employee;

alter table employee add column jobtitle varchar(50);

alter table employee drop column jobtitle;

alter table employee modify column firstname varchar(30);

alter table employee drop primary key;

alter table employee add primary key(id);

DDL vs DML

DML - insert, update, delete

DDL - create, alter, drop

delete from employee;

select * from employee;

truncate table employee; -> DDL command

Foreign Key constraint

create table students(
student_id int auto_increment,
student_fname varchar(30) not null,
student_lname varchar(30) not null,
student_mname varchar(30),
student_email varchar(30) not null,
student_phone varchar(15) not null,
student_alternate_phone varchar(15),
enrollment_date TIMESTAMP not null,
selected_course int not null default 1,
years_of_exp int not null,
student_company varchar(30),
batch_date varchar(30) not null,
source_of_joining varchar(30) not null,
location varchar(30) not null,
primary key (student_id),
unique key (student_email)
foreign key (selected_course) references courses(course_id)
);

parent - courses
child - students

drop database abc;

create database abc;

use abc;

desc students;

select * from students;
 
create table courses(
course_id int not null,
course_name varchar(30) not null,
course_duration_months int not null,
course_fee int not null,
primary key (course_id)
);

drop table students;

desc students;

delete from courses where course_id = 2;

delete from courses where course_id = 4;

the foreign key constraint is used to prevent actions that would destroy links between two tables.

not null
unique key
primary key
foreign key
check constraint

show tables;

select * from students;

select location from students;

select distinct location from students;

select distinct student_company from students;

select distinct source_of_joining from students;

select student_fname from students order by years_of_exp;

select student_fname from students order by student_fname;

select student_fname, years_of_exp from students order by years_of_exp;

select student_fname, years_of_exp from students order by years_of_exp desc;

select student_fname, years_of_exp from students order by 2 desc;

select student_fname, years_of_exp from students order by years_of_exp, student_fname;

select * from students limit 5;

select * from students order by years_of_exp limit 3;

select * from students order by years_of_exp desc limit 3;

-- This query won't work

select distinct source_of_joining from students order by enrollment_date desc limit 3;

select * from students order by enrollment_date limit 0, 3;

select * from students order by enrollment_date limit 3, 2;

select * from students where student_fname like '%ra%';

% is a wildcard character

select * from students where student_fname like 'ra%';

select * from students where student_fname like '%at';

select * from students where student_fname like '_____';

_ is a wild card


_ (exactly one character)

select * from students where student_fname like 'ROHI\%T';

select * from students where student_fname like '%\%at';

select distinct source_of_joining from students order by enrollment_date desc;

select source_of_joining from students;

select source_of_joining,enrollment_date from students;

select source_of_joining,enrollment_date from students order by enrollment_date;

select source_of_joining from students order by enrollment_date;

select distinct source_of_joining from students order by enrollment_date;

Order of execution:

from -> select -> distinct -> order by (X)

select distinct source_of_joining, enrollment_date from students;

select count(*) from students;

select count(student_company) from students;

select count(distinct student_company) as num_companies from students;

select count(distinct location) as num_locations from students;

select count(distinct source_of_joining) as num_source_of_joining from students;

select batch_date from students;

select count(*) from students where batch_date like '19-%';

group by

select source_of_joining from students;

select source_of_joining, count(*) from students group by source_of_joining;

select location, count(*) from students group by location;

select location, source_of_joining, count(*) from students group by location, source_of_joining;

select selected_course from students;

select selected_course, count(*) from students group by selected_course;

select batch_date, selected_course, count(*) from students group by batch_date, selected_course;

select min(years_of_exp) from students;

select max(years_of_exp) from students;

select student_fname from students order by years_of_exp limit 1;

select source_of_joining, max(years_of_exp) from students group by source_of_joining;

select source_of_joining, sum(years_of_exp) from students group by source_of_joining;

select source_of_joining, avg(years_of_exp) from students group by source_of_joining;

select location, avg(years_of_exp) from students group by location;

select student_company, avg(years_of_exp) from students group by student_company;

select * from courses;

desc courses;

insert into courses values (4, 'datastructures', 3.5, 20000);

create table courses_new(
course_id int not null,
course_name varchar(30) not null,
course_duration_months decimal(3,1) not null,
course_fee int not null,
primary key (course_id)
);

update courses_new set course_fee=40000 where course_id = 2;

create table courses_new(
course_id int not null,
course_name varchar(30) not null,
course_duration_months decimal(3,1) not null,
course_fee int not null,
primary key (course_id)
);

create table courses_new(
course_id int not null,
course_name varchar(30) not null,
course_duration_months decimal(3,1) not null,
course_fee int not null,
changed_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW(),
primary key (course_id)
);

create table courses_new(
course_id int not null,
course_name varchar(30) not null,
course_duration_months decimal(3,1) not null,
course_fee int not null,
changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
primary key (course_id)
);

insert into courses_new(course_id, course_name, course_duration_months, course_fee) values (4, 'devops', 10.5, 10000);

update courses_new set course_fee = 30000 where course_id = 2;

select * from courses_new;

UPDATE COURSES_NEW SET COURSE_FEE = 40000 WHERE COURSE_ID = 2;

DECIMAL(5,3)
TIMESTAMP
CURRENT_TIMESTAMP

desc students;

select * from students where location = 'bangalore';

select * from students where location != 'bangalore';

select * from courses where course_name like '%data%';

select * from courses where course_name not like '%data%';

select * from students where years_of_exp < 8 and source_of_joining = 'linkedin' and location = 'bangalore';

select * from students where years_of_exp < 8 or years_of_exp > 12;

select * from students where years_of_exp between 8 and 12;

select * from students where years_of_exp not between 8 and 12;

select *  from students where student_company = 'flipkart' or student_company = 'walmart' or student_company = 'microsoft';

select * from students where student_company in ('flipkart', 'walmart', 'microsoft');

select * from students where student_company not in ('flipkart', 'walmart', 'microsoft');

select * from courses;

select course_id, course_name, course_fee, case when course_duration_months > 4 then 'Masters' else 'diploma' end as course_type from courses;

select * from courses;

select student_id, student_fname, student_lname, student_company, case when student_company in ('flipkart', 'walmart', 'microsoft') then 'product based' when student_company is null then 'invalid company' else 'service based' end as company_type from students;

show tables;

select student_fname, selected_course from students;

select * from courses;

select course_name from courses where course_id = (select selected_course from students where student_fname = 'rahul');

select students.student_fname, students.student_lname, courses.course_name from students join courses on students.selected_course = courses.course_id;

by default it is an inner join

select student_fname, selected_course from students;

select course_id from courses;

select * from courses;

delete from courses where course_id = 2;

create table students_latest as select * from students;

create table courses_latest as select * from courses;

select * from courses_latest;

delete from courses_latest where course_id = 2;

select students_latest.student_fname, students_latest.student_lname, courses_latest.course_name from students_latest join courses_latest on students_latest.selected_course = courses_latest.course_id;

select students_latest.student_fname, students_latest.student_lname, courses_latest.course_name from students_latest left join courses_latest on students_latest.selected_course = courses_latest.course_id;

select students_latest.student_fname, students_latest.student_lname, courses_latest.course_name from students_latest right join courses_latest on students_latest.selected_course = courses_latest.course_id;

select students_latest.student_fname, students_latest.student_lname, courses_latest.course_name from students_latest full outer join courses_latest on students_latest.selected_course = courses_latest.course_id;

select students_latest.student_fname, students_latest.student_lname, courses_latest.course_name from students_latest left join courses_latest on students_latest.selected_course = courses_latest.course_id
union
select students_latest.student_fname, students_latest.student_lname, courses_latest.course_name from students_latest right join courses_latest on students_latest.selected_course = courses_latest.course_id;

select count(*) from students, courses;

select count(*) from students;
select count(*) from courses;

select * from students join courses;

create table orders(
order_id INT,
order_date DATE,
customer_name VARCHAR(250),
city VARCHAR(100),
order_amount INT
);

insert into orders
select '1001', '2017-04-01', 'David Smith', 'GuildFord', 10000
union all
select '1002', '2017-04-02', 'David Jones', 'Arlington', 20000
union all
select '1003', '2017-04-03', 'John Smith', 'Shalford', 50000
union all
select '1004', '2017-04-04', 'Michael Smith', 'Guilford', 15000
union all
select '1005', '2017-04-05', 'David Williams', 'Shalford', 7000
union all
select '1006', '2017-04-06', 'Paum Smith', 'Guilford', 25000
union all
select '1007', '2017-04-07', 'Andrew Smith', 'Arlington', 15000
union all
select '1008', '2017-04-08', 'David Brown', 'Arlington', 20000
union all
select '1009', '2017-04-09', 'Robert Smith', 'Shalford', 1000
union all
select '1010', '2017-04-10', 'Peter Smith', 'GuildFord', 500;

Where Vs Having Class

show tables;

select * from students;

select source_of_joining, count(*) as total  from students group by source_of_joining;

Not work
select source_of_joining, count(*) as total  from students group by source_of_joining where total>1;

work
select source_of_joining, count(*) as total  from students group by source_of_joining having total>1;

select source_of_joining, count(*) as total from students group by source_of_joining having source_of_joining = 'linkedin';

select source_of_joining, count(*) as total from students where source_of_joining = 'linkedin' group by source_of_joining;

select location, count(*) as total from students where years_of_exp>10 group by location having total>1;

select location, count(location) as total, avg(salary) as average from employee group by location;

select firstname, lastname, employee.location, total_count, avg_salary from employee join
(select location, count(location) as total, avg(salary) as avg_salary from employee group by location) temptable on employee.location = temptable.location;

select firstname, lastname, location, count(location) over (partition by location) as total, avg(salary) over (partition by location) as average from employee;

select firstname, lastname, salary, row_number() over (order by salary desc) from employee;

select * from 
(select firstname, lastname, salary, row_number() over (order by salary desc) as row_num from employee) temptable where row_num = 5;

select firstname, lastname, location, salary, row_number() over (partition by location order by salary desc) from employee;

select * from 
(select firstname, lastname, location, salary, row_number() over (partition by location order by salary desc) as row_num from employee) temptable where row_num = 1;

create table employee(
firstname varchar(20),
lastname varchar(20),
age int,
salary int,
location varchar(20)
);

insert into employee values ('sachin', 'sharma', 28, 10000, 'bangalore');

insert into employee values ('shane', 'warne', 30, 20000, 'bangalore');

insert into employee values ('rohit', 'sharma', 32, 30000, 'hyderabad');

insert into employee values ('shikhar', 'dhawan', 32, 30000, 'bangalore');

insert into employee values ('rahul', 'dravid', 31, 20000, 'bangalore');

insert into employee values ('saurabh', 'ganguly', 32, 15000, 'pune');

insert into employee values ('kapil', 'dev', 34, 10000, 'pune');

select firstname, lastname, salary, row_number() over (order by salary desc) from employee;

select firstname, lastname, salary, rank() over (order by salary desc) from employee;

select firstname, lastname, salary, dense_rank() over (order by salary desc) from employee;

select * from 
(select firstname, lastname, location, salary, row_number() over (partition by location order by salary desc) as row_num from employee) temptable where row_num = 1;

select max(salary) as secondHighestSalary from employee where salary < (select max(salary) from employee)

 SELECT IFNULL((select distinct salary from employee order by salary desc limit 1 offset 4), NULL) AS secondHighestSalary;

 SELECT IFNULL(select distinct salary from (select salary, dense_rank() over (order by salary desc) as denserank from employee) temp where temp.denserank = 2, NULL) AS secondHighestSalary;

select score, dense_rank() over (order by score desc) as "rank" from scores

select distinct l1.num as ConsecutiveNums from logs l1 join logs l2 on l1.id = l2.id + 1 and l1.num = l2.num join logs l3 on l1.id = l3.id + 2 and l1.num = l3.num 

select e1.name as employee from employee e1 join employee e2 on e1.managerID = e2.id and e1.salary > e2.salary

select email from (select email, count(email) as cnt from person group by email) temp where temp.cnt > 1;

select email from person group by email having count(email)>1;

select name from customers c left join orders o on c.id = o.customerId where o.customerId is NULL;

select name as customers from customers where id not in (select customerId from orders);

select department.name as department, employee.name as employee, salary from employee join department on employee.departmentID=department.id where (departmentId, salary) in (select departmentId, max(salary) as salary from employee group by departmentId);

select avg(total_orders_per_customer) as avg_orders_per_customer from (select order_customer_id, count(*) as total_orders_per_customer from orders group by order_customer_id) x;

with total_orders (order_customer_id,total_orders_per_customer) as (select order_customer_id, count(*) as total_orders_per_customer from orders group by order_customer_id) select avg(total_orders_per_customer) as avg_orders_per_customer from total_orders;

select * from (select order_customer_id, count(*) as total_orders_per_customer from orders group by order_customer_id) total_orders join (SELECT avg(total_orders_per_customer) as avg_orders_per_customer from (SELECT order_customer_id, count(*) as total_orders_per_customer from orders group by order_customer_id) x) average_orders on total_orders.total_orders_per_customer > average_orders.avg_orders_per_customer;

with total_orders(order_customer_id,total_orders_per_customer) as (select order_customer_id, count(*) as total_orders_per_customer from orders group by order_customer_id), average_orders(avg_orders_per_customer) as (SELECT avg(total_orders_per_customer) as avg_orders_per_customer from total_orders) select * from total_orders join average_orders on total_orders.total_orders_per_customer > average_orders.avg_orders_per_customer;
