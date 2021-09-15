
/***********************
 **                   **
 **   Table Creation  **
 **                   **
 ***********************/   

CREATE TABLE supplier(
product_id INT PRIMARY KEY,
supplier_name varchar(20)
)
CREATE TABLE branch_address(
br_id INT PRIMARY KEY,
	branch_country varchar(20),
	branch_location VARCHAR(20)
)
CREATE TABLE manager(
manager_id INT PRIMARY KEY,
	manager_name VARCHAR(20),
	start_date DATE
)
CREATE TABLE Branch(
branch_id INT PRIMARY KEY,
	branch_name VARCHAR(20),
	br_id INT REFERENCES Branch_address(br_id),
	manager_id INT REFERENCES manager(manager_id)
)
CREATE TABLE Product_branch(
pb_id INT PRIMARY KEY,
	product_id INT REFERENCES Supplier(product_id),
	branch_id INT REFERENCES Branch(branch_id)
)

CREATE TABLE mail(
manager_id INT REFERENCES manager(manager_id),
	manager_email varchar(20),
	PRIMARY KEY(manager_id,manager_email)
)


CREATE TABLE employee(
employee_id INT PRIMARY KEY,
	employee_name VARCHAR(20),
	employee_birth_date DATE,
	employee_gender varchar(3) check(employee_gender='M' OR employee_gender='F'),
	employee_salary INT ,
	branch_id INT REFERENCES branch(branch_id)
)


CREATE TABLE Employee_addr(
employee_id INT REFERENCES Employee(employee_id),
	employee_address VARCHAR(20),
	PRIMARY KEY(employee_id,employee_address)

)
CREATE TABLE Users(
user_id INT PRIMARY KEY,
	user_name VARCHAR(20)
)

CREATE TABLE Employee_user(
eu_id_pk INT PRIMARY KEY,
	employee_id INT REFERENCES employee(employee_id),
	user_id INT REFERENCES Users(user_id)
)

/***********************
 **                   **
 ** Creating sequence **
 **                   **
 ***********************/        

create sequence sup_seq
start with 101
increment by 1
maxvalue 110

/******************************
 **                          **
 ** Insertion into our table **
 **                          **
 ******************************/   

insert into supplier(product_id, supplier_name) values(101,'Octa');
insert into supplier(product_id, supplier_name) values(102,'Adidas');
insert into supplier(product_id, supplier_name) values(103,'Nike');
insert into supplier(product_id, supplier_name) values(104,'Puma');



insert into Branch_address values(201,'Bangladesh','Dhaka');
insert into Branch_address values(202,'USA','Las Vegas');
insert into Branch_address values(203,'UK','London');
insert into Branch_address values(204,'France','Paris');


insert into Manager values(301,'Sadman Akib', to_date('17-01-2021','dd-mm-yyyy'));
insert into Manager values(302,'Muvin mahmud', to_date('17-12-2020','dd-mm-yyyy'));
insert into Manager values(303,'Tanjib Rubyat', to_date('07-02-2021','dd-mm-yyyy'));
insert into Manager values(304,'Nafisa hossain', to_date('13-10-2019','dd-mm-yyyy'));

insert into Branch values(601,'Dhaka branch',201,301);
insert into Branch values(602,'Las Vegas branch',202,302);
insert into Branch values(603,'London branch',203,303);
insert into Branch values(604,'Paris branch',204,304);

insert into Product_branch values(501,101,601);
insert into Product_branch values(502,102,602);
insert into Product_branch values(503,103,603);
insert into Product_branch values(504,104,604);

insert into Mail values(301,'akib@gmail.com');
insert into Mail values(302,'muvin@gmail.com');
insert into Mail values(303,'tanjib@gmail.com');
insert into Mail values(304,'nafisa@gmail.com');

insert into Employee values(401,'Sakib',to_date('17-01-2000','dd-mm-yyyy'),'M',10000, 601);
insert into Employee values(402,'Rahim',to_date('07-02-2001','dd-mm-yyyy'),'M',15000, 602);
insert into Employee values(403,'Riha',to_date('10-05-2003','dd-mm-yyyy'),'F',12000, 603);
insert into Employee values(404,'Anika',to_date('03-05-1999','dd-mm-yyyy'),'F',10000, 604);



insert into Employee_addr values(401,'Dhaka');
insert into Employee_addr values(402,'Las Vegas');
insert into Employee_addr values(403, 'London');
insert into Employee_addr values(404,'Paris');

insert into Users values(801,'Leonardo');
insert into Users values(802,'Hanks');
insert into Users values(803,'Smith');
insert into Users values(804,'Stark');

insert into Employee_user values(901,401,801);
insert into Employee_user values(902,402,802);
insert into Employee_user values(903,403,803);
insert into Employee_user values(904,404,804);





select * from manager where start_date>(select start_date from manager where manager_name='Muvin mahmud')

select employee_name,employee_birth_date,employee_salary from employee 
where employee_salary=ALL(select employee_salary from employee where employee_gender='M')

select branch_name,branch_location from branch JOIN branch_address
On branch.br_id=branch_address.br_id

select employee_name,employee_birth_date,branch_name
from employee JOIN branch
ON employee.branch_id = branch.branch_id and 
branch_name='Paris branch'

select manager_name,start_date from manager order by
manager_name

select employee_name,employee_gender,employee_salary 
from employee 
where employee_salary > 10000

create view v_emp as select employee_id,employee_name
,employee_salary from employee 

select * from v_emp

select employee_salary from employee where employee_birth_date >'01-JAN-00'

