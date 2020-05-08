SELECT * FROM "departments";
SELECT * FROM "dept_emp";
SELECT * FROM "dept_manager";
SELECT * FROM "employees";
SELECT * FROM "title";
SELECT * FROM "salaries";

------------- DATA ANALYSIS ---------------

-- List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM "salaries"
LEFT JOIN employees ON employees.emp_no = salaries.emp_no

-- List first name, last name, and hire date for employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM "employees"
WHERE hire_date LIKE '%86';

-- List the manager of each department with the following information: department number, department name, 
-- the manager's employee number, last name, first name.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager
LEFT JOIN departments on departments.dept_no = dept_manager.dept_no
JOIN employees on dept_manager.emp_no = employees.emp_no

-- List the department of each employee with the following information: employee number, 
-- last name, first name, and department name
SELECT employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no
FROM dept_emp
LEFT JOIN employees ON employees.emp_no = dept_emp.emp_no

-- List first name, last name, and sex for employees whose first name 
-- is "Hercules" and last names begin with "B."

SELECT first_name, last_name, hire_date
FROM "employees"
WHERE first_name = 'Herculues' OR last_name LIKE 'B%';

-- List all employees in the Sales department, including their employee number, 
-- last name, first name, and department name.

SELECT emp_no, last_name, first_name, 'Sales' as department_name
FROM employees
WHERE emp_no IN
(
  SELECT emp_no
  FROM dept_emp a
  WHERE dept_no IN
  (
    SELECT dept_no
    FROM departments
    WHERE dept_name = 'Sales'
  )
);

-- List all employees in the Sales and Development departments, including their 
-- employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees ON dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';

-- In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.

SELECT last_name AS "Last Name", 
Count(last_name) AS "Frequency Count of Employee Last Names"
FROM employees
GROUP BY last_name
ORDER BY "Frequency Count of Employee Last Names" DESC;


