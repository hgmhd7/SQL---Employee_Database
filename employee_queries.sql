--Check to see if my tables imported properly

SELECT * FROM departments;

SELECT * FROM employees;

SELECT * FROM dept_emp;

SELECT * FROM dept_manager;

SELECT * FROM salaries;

SELECT * FROM titles;



--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
CREATE VIEW Question1 as
SELECT e.emp_no,  e.last_name, e.first_name, e.gender, s.salary
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no =  s.emp_no);

SELECT * FROM Question1;
--DROP VIEW Question1;



--2. List employees who were hired in 1986.
SELECT * FROM employees
WHERE hire_date between  '1986-01-01' and '1986-12-31'
ORDER BY hire_date ASC;



--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
CREATE VIEW Question3Join as
SELECT d.dept_no, d.dept_name, dm.emp_no, dm.from_date, dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON (d.dept_no =  dm.dept_no);

CREATE VIEW Question3 as
SELECT q3j.dept_no, q3j.dept_name, q3j.emp_no, e.last_name, e.first_name, q3j.from_date, q3j.to_date
FROM Question3Join as q3j
INNER JOIN employees as e
ON (q3j.emp_no = e.emp_no);

SELECT * FROM Question3;
--DROP VIEW Question3Join;
--DROP VIEW Question3;



--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
CREATE VIEW Question4Join as
SELECT d.dept_no, d.dept_name, de.emp_no, de.from_date, de.to_date
FROM departments as d
INNER JOIN dept_emp as de
ON (d.dept_no =  de.dept_no);

CREATE VIEW Question4 as
SELECT e.emp_no, e.last_name, e.first_name, q4j.dept_name
FROM Question4Join as q4j
INNER JOIN employees as e
ON (q4j.emp_no = e.emp_no);

SELECT * FROM Question4;
--DROP VIEW Question4Join;
--DROP VIEW Question4;



--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees 
WHERE first_name = 'Hercules' and last_name LIKE 'B%';



--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
CREATE VIEW Question6Join as
SELECT d.dept_no, d.dept_name, de.emp_no, de.from_date, de.to_date
FROM departments as d
INNER JOIN dept_emp as de
ON (d.dept_no =  de.dept_no);

CREATE VIEW Question6 as
SELECT e.emp_no, e.last_name, e.first_name, q6j.dept_name
FROM Question6Join as q6j
INNER JOIN employees as e
ON (q6j.emp_no = e.emp_no);

SELECT * FROM Question6
WHERE dept_name = 'Sales';
--DROP VIEW Question6Join;
--DROP VIEW Question6;



--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
CREATE VIEW Question7Join as
SELECT d.dept_no, d.dept_name, de.emp_no, de.from_date, de.to_date
FROM departments as d
INNER JOIN dept_emp as de
ON (d.dept_no =  de.dept_no);

CREATE VIEW Question7 as
SELECT e.emp_no, e.last_name, e.first_name, q7j.dept_name
FROM Question7Join as q7j
INNER JOIN employees as e
ON (q7j.emp_no = e.emp_no);

SELECT * FROM Question7
WHERE dept_name = 'Sales' or dept_name = 'Development';
--DROP VIEW Question7Join;
--DROP VIEW Question7;



--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, count(last_name) as "last_name_count" FROM employees 
GROUP BY last_name
ORDER BY "last_name_count" DESC; 


--bonus... "Search your ID number." You look down at your badge to see that your employee ID number is 499942.
CREATE VIEW BonusJoin as
SELECT d.dept_no, d.dept_name, de.emp_no, de.from_date, de.to_date
FROM departments as d
INNER JOIN dept_emp as de
ON (d.dept_no =  de.dept_no);

CREATE VIEW BonusJoin2 as
SELECT e.emp_no, e.last_name, e.first_name, e.gender, e.hire_date, bj.dept_name, bj.from_date, bj.to_date
FROM BonusJoin as bj
INNER JOIN employees as e
ON (bj.emp_no = e.emp_no);

CREATE VIEW Bonus as
SELECT bj2.emp_no, bj2.last_name, bj2.first_name, bj2.gender, s.salary,  bj2.dept_name, bj2.hire_date
FROM BonusJoin2 as bj2
INNER JOIN salaries as s
ON (bj2.emp_no = s.emp_no);

SELECT * FROM Bonus
WHERE emp_no = 499942;
--DROP VIEW BonusJoin;
--DROP VIEW BonusJoin2;
--DROP VIEW Bonus;

--Build table for the bonus "Average Salary vs. Title" bar chart
CREATE VIEW salary_v_title as
SELECT SUM(s.salary), tl.title, COUNT(tl.title)
FROM salaries as s
INNER JOIN titles as tl
ON (s.emp_no = tl.emp_no)
GROUP BY tl.title;


CREATE VIEW sal_v_tl_bonus as
SELECT tl.title as "Title", (tl.sum/ tl.count) as "Average Salary" 
FROM salary_v_title as tl;

SELECT * FROM sal_v_tl_bonus;
--DROP VIEW salary_v_title;
--DROP VIEW sal_v_tl_bonus;







