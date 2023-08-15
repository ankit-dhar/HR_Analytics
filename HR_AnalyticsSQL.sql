use ECOM
-- Create 'departments' table
CREATE TABLE departments (
 id INT IDENTITY(1,1) PRIMARY KEY,
 name VARCHAR(50),
 manager_id INT
);
-- Create 'employees' table
CREATE TABLE employee (
 id INT IDENTITY(1,1) PRIMARY KEY,
 name VARCHAR(50),
 hire_date DATE,
 job_title VARCHAR(50),
 department_id INT REFERENCES departments(id)
);
-- Create 'projects' table
CREATE TABLE projects (
 id INT IDENTITY(1,1) PRIMARY KEY,
 name VARCHAR(50),
 start_date DATE,
 end_date DATE,
 department_id INT REFERENCES departments(id)
);
-- Insert data into 'departments'
INSERT INTO departments (name, manager_id)
VALUES ('HR', 1), ('IT', 2), ('Sales', 3);
select * from departments
-- Insert data into 'employees'
INSERT INTO employee (name, hire_date, job_title, department_id)
VALUES ('John Doe', '2018-06-20', 'HR Manager', 1),
 ('Jane Smith', '2019-07-15', 'IT Manager', 2),
 ('Alice Johnson', '2020-01-10', 'Sales Manager', 3),
 ('Bob Miller', '2021-04-30', 'HR Associate', 1),
 ('Charlie Brown', '2022-10-01', 'IT Associate', 2),
 ('Dave Davis', '2023-03-15', 'Sales Associate', 3);
-- Insert data into 'projects'
INSERT INTO projects (name, start_date, end_date, department_id)
VALUES ('HR Project 1', '2023-01-01', '2023-06-30', 1),
 ('IT Project 1', '2023-02-01', '2023-07-31', 2),
 ('Sales Project 1', '2023-03-01', '2023-08-31', 3);
 INSERT INTO projects (name, start_date, end_date, department_id)
VALUES ('HR Project 2', '2023-01-01', '2023-08-30', 1)
 UPDATE departments
SET manager_id = (SELECT id FROM employees WHERE name = 'John Doe')
WHERE name = 'HR';
UPDATE departments
SET manager_id = (SELECT id FROM employees WHERE name = 'Jane Smith')
WHERE name = 'IT';
UPDATE departments
SET manager_id = (SELECT id FROM employees WHERE name = 'Alice Johnson')
WHERE name = 'Sales';

----longest ongoing project with cte as(select d.name,department_id, max(datediff(day,start_date,end_date)) as duration from projects as p join departments as don p.department_id=d.idgroup by department_id,d.name)select c.*,p.name from projects as p join cte as c on p.department_id=c.department_idwhere (datediff(day,start_date,end_date))=durationorder by c.department_id ;--2. Find all employees who are not managers.select e.namefrom employee as eleft join departments as don e.department_id=d.idwhere e.id<>d.manager_id;--3. Find all employees who have been hired after the start of a project in their department.select e.id,e.name as name, e.hire_date as hire_date, p.start_date as start_datefrom employee as e join projects as p on p.department_id=e.department_idwhere e.hire_date>p.start_date--4. Rank employees within each department based on their hire date (earliest hire gets the highest rank).select *,DENSE_RANK() over(partition by department_id order by hire_date) as drnfrom employee--5. Find the duration between the hire date of each employee and the hire date of the next employee hired in the same department.select e1.*,DATEDIFF(day,e1.hire_date,e2.hire_date) as durationfrom employee as e1, employee as e2where e1.department_id=e2.department_id and e1.id<e2.id;