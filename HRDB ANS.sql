use HRDB;

-- Page - 1

-- 1. Display all information in the tables EMP and DEPT.

select * from departments,employees;

-- 2. Display only the hire date and employee name for each employee. 

select hire_date, first_name from employees;

-- 3. Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title 

select concat(job_id, ', ', first_name, ' ', last_name) as 'Employee & Title'  from employees;

-- 4. Display the hire date, name and department number for all clerks. 

select hire_date, first_Name, department_id from employees;

-- 5. Create a query to display all the data from the EMP table. Separate each column by a comma. Name the column THE OUTPUT 

select concat(employee_id, ', ', first_name,', ', last_name, ', ',email, ', ',phone_number, ', ',hire_date, ', ',job_id,
', ',salary, ', ',commission_pct, ', ',manager_id, ', ',department_id) as THE_OUTPUT from employees;

-- 6. Display the names and salaries of all employees with a salary greater than 2000. 

select first_name, salary from employees where salary > 2000;

select first_name, Min_salary from employees join jobs on 
employees.job_id = jobs.job_id
where min_salary > 2000;

-- 7. Display the names and dates of employees with the column headers "Name" and "Start Date" 

select first_name as Name , hire_date as Start_Date from employees;

-- 8. Display the names and hire dates of all employees in the order they were hired. 

select first_name , hire_date from employees
order by hire_date;

-- 9. Display the names and salaries of all employees in reverse salary order. 

select first_name, salary from employees
order by salary desc;

-- 10. Display 'ename" and "deptno" who are all earned commission and display salary in reverse order. 

select first_name, department_id, salary from employees 
where commission_pct is not null
order by salary desc;

-- 11. Display the last name and job title of all employees who do not have a manager 

select last_name, job_title, manager_id  from employees 
join jobs 
on employees.job_id = jobs.job_id
where manager_id is not null ;

-- 12. Display the last name, job, and salary for all employees whose job is sales representative or stock clerk
--  and whose salary is not equal to $2,500, $3,500, or $5,000

select last_name, job_title, salary from employees 
join jobs 
on jobs.job_id = employees.job_id
where job_title = 'sales representative' or 'stock clerk' and 
salary != 2500 or 3500 or 5000;

-- Page - 2

-- 1) Display the maximum, minimum and average salary and commission earned. 

select max_salary, min_salary, avg(salary), commission_pct from employees
join jobs 
on employees.job_id = jobs.job_id
group by employee_id;

-- 2) Display the department number, total salary payout and total commission payout for each department. 

select d.department_name, d.department_id, e.salary, e.commission_pct, e.salary + e.commission_pct as Total_Comission 
from departments d join  employees e 
on e.department_id = d.department_id;

-- 3) Display the department number and number of employees in each department. 

select department_id, count(*) as Number_of_emp from employees 
group by department_id;

-- 4) Display the department number and total salary of employees in each department. 

select department_id, salary +  commission_pct as totalcount from employees; 

-- 5) Display the employee's name who doesn't earn a commission. Order the result set without using the column name 

select first_name, commission_pct from employees
where commission_pct is null
order by first_name;

-- 6) Display the employees name, department id and commission. If an Employee doesn't earn the commission, then display as 'No commission'. Name the columns appropriately

select first_name, department_id, 
case 
	when commission_pct is null then "No commission"
    else commission_pct
    end as 'Commission'
from employees;

-- 7) Display the employee's name, salary and commission multiplied by 2. 
-- If an Employee doesn't earn the commission, then display as 'No commission. Name the columns appropriately

select first_name, salary, 
case 
	when commission_pct is null then "No Commission"
    else commission_pct*2
    end as "Commission"
from employees;

-- 8) Display the employee's name, department id who have the first name same as another employee in the same department

select  first_name, count(department_id) from employees
group by first_name;

-- 9) Display the sum of salaries of the employees working under each Manager. 

select sum(salary), manager_id from employees 
where manager_id is not null
group by manager_id;

-- 10) Select the Managers name, the count of employees working under and the department ID of the manager. 

select manager_id, count(first_name) from employees 
group by manager_id;

-- 11) Select the employee name, department id, and the salary. Group the result with the manager name 
-- and the employee last name should have second letter 'a! 

select first_name, last_name, department_id, salary from employees
where last_name like "%a";

-- 12) Display the average of sum of the salaries and group the result with the department id. Order the result with the department id. 

select sum(Salary), department_id from employees
group by department_id
order by department_id;

-- 13) Select the maximum salary of each department along with the department id 

select department_id, max(salary) from employees
group by department_id;

-- 14) Display the commission, if not null display 10% of salary, if null display a default value 1

select commission_pct ,
case 
	when commission_pct is null then 1
    when commission_pct is not null then (Salary + (salary * 10/100))
    end as commission
from employees;

-- Page - 3

-- 1. Write a query that displays the employee's last names only from the string's 2-5th 
-- position with the first letter capitalized and all other letters lowercase, Give each column an appropriate label. 

select substr(last_name, 1, 5) as 'LastName' from employees;

-- 2. Write a query that displays the employee's first name and last name along with a " in between for 
--  e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the month on which the employee has joined.

select concat(first_name, ' - ', last_name) as EName, monthname(hire_date) as MOJ from employees;

-- 3. Write a query to display the employee's last name and 
-- if half of the salary is greater than 10,000 then increase the salary by 10% else by 11.5% along with the bonus amount of 1500 each. 
-- Provide each column an appropriate label. 

select last_name,
case 
	when salary/2 > 10000  then (salary + (salary * 10/100))
    else (salary + (salary * 11.5/100) + 1500) 
    end as bonus
    from employees;

-- 4. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, 
-- department id, salary and the manager name all in Upper case, 
-- if the Manager name consists of 'z' replace it with '$! 

select employee_id, first_name, last_name, salary from employees 
where instr(last_name, 'E') > 2; 

-- 5. Write a query that displays the employee's last names with the first letter capitalized and all other letters lowercase, 
-- and the length of the names, for all employees whose name starts with J, A, or M. Give each column an appropriate label. 
-- Sort the results by the employees' last names 

select last_name as 'LName', length(last_name) as 'LLength' from employees
where Last_name like 'J%' or last_name like 'A%' or last_name like 'M%'
order by last_name ;

-- 6. Create a query to display the last name and salary for all employees. 
-- Format the salary to be 15 characters long, left-padded with $. Label the column SALARY 

select last_name, lpad(salary,15,'$') as salary from employees;

-- 7. Display the employee's name if it is a palindrome  

select first_name, reverse(first_name) as ra from employees
where first_name = reverse(first_name);

-- 8. Display First names of all employees with initcaps(upper case). 

select upper(first_name) from employees;

-- 9. From LOCATIONS table, extract the word between first and second space from the STREET ADDRESS column.

select substring_index(substring_index(street_address, ' ', 2), ' ', -1) as Word from locations;

-- 10. Extract first letter from First Name column and append it with the Last Name. Also add "@systechusa.com" at the end. 
-- Name the column as e-mail address. All characters should be in lower case. Display this along with their First Name. 

select First_name, lower(concat(substr(first_name, 1, 1), last_name, '@systechusa.com')) as 'E-mail address' from employees;

-- 11. Display the names and job titles of all employees with the same job as Trenna. 

select first_name, Job_title from employees 
join jobs
on employees.job_id = jobs.job_id
where first_name = 'trenna';

select first_name, job_title from employees, jobs
where first_name = 'trenna';

-- 12. Display the names and department name of all employees working in the same city as Trenna. 

select first_name, department_name from employees 
join departments
on employees.department_id = departments.department_id
where first_name = 'trenna';

select first_name, department_name from employees, departments
where first_name = 'trenna';

-- 13. Display the name of the employee whose salary is the lowest. 

select first_name, salary from employees
order by salary limit 1;

-- 14. Display the names of all employees except the lowest paid.

select first_name, min_salary from employees 
join jobs
on employees.job_id = jobs.job_id
order by min_salary;

-- Page - 4

-- 1. Write a query to display the last name, department number, department name for all employees. 

select e.last_name, e.department_id, department_name from employees e join departments
on e.department_id = departments.department_id;

-- 2. Create a unique list of all jobs that are in department 40. Include the location of the department in the output. ------(department 4 or 40?)-- 

select department_name, job_title, state_province from jobs 
right join job_history on 
jobs.job_id = job_history.job_id
left join departments on
departments.department_id = job_history.department_id
join locations on 
locations.location_id = departments.location_id
having department_id = 40;

select first_name,job_id,location_id from employees 
join departments 
on employees.department_id = departments.department_id  
where department_id in (select department_id from departments having department_id = 40);

-- 3. Write a query to display the employee last name,department name,location id and city of all employees who earn commission. 

select last_name, department_name, commission_pct, l.location_id, city  from employees 
right join departments
on departments.department_id = employees.department_id 
right join locations l
on l.location_id = departments.location_id  
where commission_pct is not null;

-- 4. Display the employee last name and department name of all employees who have an 'a' in their last name 

select last_name, department_name from employees 
join departments
on departments.department_id = employees.department_id
where last_name like '%a';

-- 5. Write a query to display the last name,job,department number and department name for all employees who work in ATLANTA. 

select last_name, job_id, department_id from employees  
where department_id = (select department_id from departments 
where location_id = (select location_id from locations where city ='atlanta'));

-- 6. Display the employee last name and employee number along with their manager's last name and manager number. 
select last_name, employee_id, manager_id from employees;

-- 7. Display the employee last name and employee number along with their manager's last name and manager number 
 -- (including the employees who have no manager). 
select last_name, employee_id, manager_id from employees
where manager_id is not null;

select last_name, employee_id, manager_id from employees
where manager_id is null;

-- 8. Create a query that displays employees last name,department number,and all the employees who work in the same department as a given employee. 

select e.last_name, e.department_id, department_name from employees e
join departments
on departments.department_id = e.department_id;

-- 9. Create a query that displays the name,job,department name,salary,grade for all employees. 
-- Derive grade based on salary(>=5000=A, >=3000=B,<3000=C) 

select first_name, department_name, salary,  
case 
	when salary >= 5000 then 'A'
    when salary >= 3000 then 'B'
    when salary < 3000 then 'c'
    end as 'Grade'
from employees
join departments
on departments.department_id = employees.department_id;

-- 10. Display the names and hire date for all employees who were hired before their managers along withe their manager names and hire date. 
-- Label the columns as Employee name, emp_hire_date,manager name,man_hire_date

select first_name, hire_date from employees
where manager_id is null;

select first_name, hire_date from employees
where manager_id is not null;

-- Page - 5

-- 1. Write a query to display the last name and hire date of any employee in the same department as SALES. 

select last_name, hire_date, Department_name from employees
join departments
on departments.department_id = employees.department_id
where department_name = 'sales';

-- 2. Create a query to display the employee numbers and last names of all employees who earn more than the average salary. 
-- Sort the results in ascending order of salary. 

select employee_id, last_name, salary from employees where salary > (select avg(salary) from employees)
order by salary;

-- 3. Write a query that displays the employee numbers and last names of all employees 
-- who work in a department with any employee whose last name contains a' u 

select employee_id, last_name from employees where last_name like  'a%' or last_name like 'u%';

-- 4. Display the last name, department number, and job ID of all employees whose department location is ATLANTA. 

select last_name from employees 
right join departments on
departments.department_id = employees.department_id
right join locations on 
locations.location_id = departments.location_id
where city = (select city from locations where city = 'Toronto');

-- 5. Display the last name and salary of every employee who reports to FILLMORE.  

select last_name, salary from employees where first_name = 'FILLmore';

-- 6. Display the department number, last name, and job ID for every employee in the OPERATIONS department. 

select  e.department_id, last_name, e.job_id, department_name from employees e  
right join departments  on 
departments.department_id = e.department_id 
where department_name = 'OPERATIONS';

-- 7. Modify the above query to display the employee numbers, last names, and salaries of all employees who earn more than the average salary
--  And who work in a department with any employee with a 'u'in their name. 

select employee_id, last_name, salary from employees 
where salary > (select avg(salary) from employees) 
having last_name in(select last_name from employees where last_name like '%u%');

-- 8. Display the names of all employees whose job title is the same as anyone in the sales dept.  

select first_name,job_id, department_name from employees 
join departments 
on employees.department_id = departments.department_id 
where department_name = 'sales' ;

-- 9. Write a compound query to produce a list of employees showing raise percentages, employee IDs, and salaries. 
-- Employees in department 1 and 3 are given a 5% raise, 
-- employees in department 2 are given a 10% raise, employees in departments 4 and 5 are given a 15% raise, 
-- and employees in department 6 are not given a raise. 

select  employee_id, Salary,
case
	when department_id between 10 and 30 then (salary + salary * 0.05)
    when department_id = 20  then (salary + salary * 0.1)
    when department_id between 40 and 50 then (salary + salary *0.15)
    else 0 
    end as 'Raise_Salary' from  employees;  

-- 10. Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries. 

select last_name,salary from employees order by salary desc limit 3;

select last_name, max(salary) from employees
group by last_name
order by max(Salary) desc limit 3;

-- 11. Display the names of all employees with their salary and commission earned. 
-- Employees with a null commission should have O in the commission column 

select first_name, salary,
	case 
		when commission_pct is null then 0
        else commission_pct 
        end as 'commission_pct'
	from employees;

-- 12. Display the Managers (name) with top three salaries along with their salaries and department information.

select e.manager_id, e.salary, department_name  from employees e 
join departments 
on departments.department_id = e.department_id
order by e.salary desc limit 3;
