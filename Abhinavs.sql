/* Employee Performance Mapping - SQL Course end project
Submitted by Abhinav Pawar */

Create database Employee ;
Show tables in Employee;

/* Task 1 : Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and
DEPARTMENT from the employee record table, and make a list of employees
and details of their department */

USE employee;
Desc data_science_team ;
SELECT  EMP_ID, FIRST_NAME, LAST_NAME, GENDER,
DEPT
FROM data_science_team;


/*4. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER,
DEPARTMENT, and EMP_RATING if the EMP_RATING is:
● less than two
● greater than four
● between two and four */


SELECT 
    d.emp_id,
    d.first_name,
    d.last_name,
    d.gender,
    d.dept AS department,
    e.emp_rating
FROM data_science_team AS d
JOIN emp_record_table AS e
    ON d.emp_id = e.emp_id
WHERE e.emp_rating < 2;

SELECT 
d.emp_id,
d.first_name,
d.last_name,
d.gender,
d.dept,
e.emp_rating
FROM data_science_team AS d
JOIN emp_record_table AS e
ON d.emp_id = e.emp_id
WHERE e.emp_rating > 4;


SELECT 
d.emp_id,
d.first_name,
d.last_name,
d.gender,
d.dept,
e.emp_rating
FROM data_science_team AS d
JOIN emp_record_table AS e
ON d.emp_id = e.emp_id
WHERE e.emp_rating between 2 AND 4;

/* Write a query to concatenate the FIRST_NAME and the LAST_NAME of
employees in the Finance department from the employee table and then give
the resultant column alias as NAME.*/

SELECT dept, CONCAT(d.first_name , d.last_name) AS NAME
FROM data_science_team AS d
WHERE dept = 'FINANCE';


/* Write a SQL query to retrieve the employee ID, first name, role, and
department of employees who hold leadership positions (Manager,
President, or CEO). */
Desc data_science_team ;
Desc emp_record_table ;
Desc proj_table ;

SELECT * 
FROM emp_record_table ;
SELECT * 
FROM proj_table ;
SELECT * 
FROM data_science_team ;

SELECT emp_id , first_name , last_name, role , dept
FROM emp_record_table
WHERE Role IN  ('Manager','President','CEO');

SELECT emp_id , first_name , last_name, role , dept
FROM emp_record_table
WHERE  Role = 'CEO';

/* Write a query to list all the employees from the healthcare and finance
departments using the union. Take data from the employee record table. */

SELECT emp_id , first_name , last_name, role , dept
FROM emp_record_table
WHERE Dept = 'HEALTHCARE'
UNION
SELECT emp_id , first_name , last_name, role , dept
FROM emp_record_table
WHERE Dept = 'FINANCE';

/* Write a query to list employee details such as EMP_ID, FIRST_NAME,
LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also
include the respective employee rating along with the max emp rating for the
department.
*/
SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, max(emp_rating) OVER (PARTITION BY Dept) AS Dept_max_rating
FROM emp_record_table;



/* Write a query to calculate the minimum and the maximum salary of the
employees in each role. Take data from the employee record table.*/

SELECT ROLE , MAX(SALARY)
FROM emp_record_table AS Max_Salary
Group BY Role;

SELECT ROLE , MIN(SALARY) AS Min_Salary
FROM emp_record_table
Group BY Role;

/* Write a query to assign ranks to each employee based on their experience.
Take data from the employee record table.*/

SELECT *, 
DENSE_RANK() OVER (ORDER BY Salary DESC) As Salary_Rank
FROM emp_record_table;

/*Write a query to create a view that displays employees in various countries
whose salary is more than six thousand. Take data from the employee record
table.*/

SELECT * 
FROM emp_record_table ;
SELECT * 
FROM proj_table ;
SELECT * 
FROM data_science_team ;

CREATE VIEW High_Salary_Employee AS

SELECT Emp_ID , First_Name, Last_Name, Country, SALARY 
FROM emp_record_table
WHERE SALARY>6000;

SELECT *
FROM High_Salary_Employee;


/*Write a nested query to find employees with experience of more than ten
years. Take data from the employee record table.*/

SELECT * FROM (
SELECT emp_id , Last_Name , First_Name , Exp
FROM emp_record_table) AS checkexp
WHERE Exp > 10 ;



/* Write a query using stored functions in the project table to check whether
the job profile assigned to each employee in the data science team matches
the organization’s set standard.
The standard being:
For an employee with experience less than or equal to 2 years assign 'JUNIOR
DATA SCIENTIST',
For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA
SCIENTIST',
For an employee with the experience of 5 to 10 years assign 'SENIOR DATA
SCIENTIST',
For an employee with the experience of 10 to 12 years assign 'LEAD DATA
SCIENTIST',
For an employee with the experience of 12 to 16 years assign 'MANAGER'.
*/

SELECT * 
FROM data_science_team ;

DELIMITER $$

CREATE FUNCTION Determine_Role(Exp INT)
RETURNS Varchar(50)
deterministic
BEGIN
DECLARE Standard_Role VARCHAR(50);

If EXP <= 2 THEN
SET Standard_Role = 'JUNIOR DATA SCIENTIST';
ELSEIf EXP <=5 THEN
SET Standard_Role = 'ASSOCIATE DATA SCIENTIST';
ELSEIf EXP  <=10 THEN
SET Standard_Role = 'SENIOR DATA SCIENTIST';
ELSEIf EXP <=12 THEN
SET Standard_Role = 'LEAD DATA SCIENTIST';
ELSEIf EXP <=15 THEN
SET Standard_Role = 'MANAGER';
END If;

RETURN Standard_Role;
END $$
DELIMITER ;	

   SELECT First_Name , Emp_ID , EXP, Determine_Role(EXP) AS Standard_Role
   FROM data_science_team;


/*14. Create an index to improve the cost and performance of the query to find
the employee whose FIRST_NAME is ‘Eric’ in the employee table after
checking the execution plan.*/

ALTER TABLE emp_record_table
MODIFY Column First_Name VARCHAR(50);

EXPLAIN SELECT * FROM emp_record_table WHERE First_Name = 'Eric';

CREATE INDEX indx_First_Name
ON emp_record_table(First_Name);

SHOW INDEX FROM emp_record_table;


/*15.Write a query to calculate the bonus for all the employees, based on their
ratings and salaries (Use the formula: 5% of salary * employee rating).*/

SELECT Emp_id, Last_name, First_name, Salary, Emp_Rating , 5%(Salary)*Emp_Rating AS Bonus
FROM Emp_record_table;


/*16.Write a query to calculate the average salary distribution based on the
continent and country. Take data from the employee record table.*/

SELECT *
FROM emp_record_table;

SELECT country, AVG(Salary)AS Avg_Salary
FROM emp_record_table
GROUP BY Country;

SELECT continent, AVG(Salary)AS Avg_Salary
FROM emp_record_table
GROUP BY Continent;








