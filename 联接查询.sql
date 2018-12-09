--联接查询
--1.内联接
--NATURAL JOIN自然联接使用源表和目标表相同的列
--regions是源表，countries是目标表
SELECT region_name FROM regions NATURAL JOIN countries WHERE country_name='Canada';
SELECT country_name FROM countries NATURAL JOIN regions WHERE region_name='Americas';
SELECT region_name FROM regions JOIN countries USING(region_id) WHERE country_name='Canada';
--这种方式最常用
SELECT country_name FROM countries 
  JOIN regions ON(countries.region_id=regions.region_id)
WHERE region_name='Americas';

--内联接oracle传统联接语法
SELECT regions.region_name, countries.country_name FROM 
regions, countries
WHERE regions.region_id=countries.region_id;

--2外连接
--外连接oracle传统联接语法，左表employees，右表departments,
--等号左边（+）标识为右外联接，右表显示所有行，左表没有与右表匹配的行显示为空
SELECT last_name,department_name FROM employees, departments 
WHERE employees.department_id(+)=departments.department_id;
--外连接oracle传统联接语法，左表employees，右表departments,
--等号右边（+）标识为左外联接，左表显示所有行，右表没有与左表匹配的行显示为空
SELECT last_name,department_name FROM employees, departments 
WHERE employees.department_id=departments.department_id(+);


--3.交叉联接
SELECT * FROM regions CROSS JOIN countries;
SELECT COUNT(*) FROM employees CROSS JOIN departments;
--oracle传统联接语法
SELECT * FROM regions,countries;

--NATURAL JOIN,使用场景：熟悉源表和目标表的列，否则谨慎使用自然联接
SELECT employee_id, job_id, department_id, emp.last_name, emp.hire_date, jh.end_date 
FROM job_history jh NATURAL JOIN employees emp;

--JOIN USING
SELECT * FROM locations JOIN countries USING(country_id);

--JOIN ON
SELECT * FROM departments d JOIN employees e ON(d.department_id=e.department_id);
--oracle传统语法
SELECT * FROM departments d, employees e WHERE d.department_id=e.department_id;
--指定查询条件
SELECT * FROM departments d JOIN locations l ON(l.location_id=d.location_id) WHERE d.department_name LIKE 'P%';
SELECT * FROM departments d JOIN locations l ON(l.location_id=d.location_id AND d.department_name LIKE 'P%');

--例子查找部门经理
SELECT e.first_name||'是'||d.department_name||'的部门经理' FROM employees e JOIN departments d ON(e.employee_id=d.manager_id);

--N路联接
SELECT region_name, c.country_name, l.city, d.department_name 
FROM departments d
NATURAL JOIN locations l
NATURAL JOIN countries c
NATURAL JOIN regions r;

SELECT region_name, c.country_name, l.city, d.department_name 
FROM departments d
JOIN locations l USING(location_id)
JOIN countries c USING(country_id)
JOIN regions r USING (region_id); 

SELECT region_name, c.country_name, l.city, d.department_name 
FROM departments d
JOIN locations l ON(l.location_id=d.location_id)
JOIN countries c ON(c.country_id=l.country_id)
JOIN regions r ON (r.region_id=c.region_id); 

--查询收入最多的员工及其地理信息
SELECT e.employee_id, e.first_name||' '||e.last_name,e.salary,g.region_name,c.country_name,l.street_address,d.department_name
FROM employees e
JOIN departments d ON(d.department_id=e.department_id)
JOIN locations l ON(l.location_id=d.location_id)
JOIN countries c ON(c.country_id=l.country_id)
JOIN regions g ON(g.region_id=c.region_id)

--非同等联接
SELECT e.job_id current_job, 'The salary of '||e.last_name||' can be doubled by changing job to '||j.job_id options,
  e.salary current_salary, j.max_salary potential_max_salary
  FROM employees e JOIN jobs j ON(2*e.salary<j.max_salary)
WHERE e.salary>11000 ORDER BY last_name;

--JOIN ON实现自联接 例子查找员工的经理
SELECT e.last_name employee, e.manager_id, m.last_name, e.department_id
FROM employees e JOIN employees m ON(e.manager_id=m.employee_id AND e.department_id IN(10,20,30));
SELECT e.last_name employee, e.manager_id, m.last_name, e.department_id
FROM employees e JOIN employees m ON(e.manager_id=m.employee_id) WHERE e.department_id IN(10,20,30);

--内联接：包括同等联接和非同等联接，返回匹配源表和目标表中的行

--外联接：包括左外联接、右外联接、全外联接
--左外联接：返回内联接的结果+被内联接排除的在源表中的行
SELECT e.employee_id, e.department_id EMP_DEPT_ID, d.department_id DEPT_DEPT_ID, d.department_name
FROM departments d LEFT OUTER JOIN employees e ON(d.department_id=e.department_id) WHERE d.department_name LIKE 'P%';
SELECT e.employee_id, e.department_id EMP_DEPT_ID, d.department_id DEPT_DEPT_ID, d.department_name
FROM departments d JOIN employees e ON(d.department_id=e.department_id) WHERE d.department_name LIKE 'P%';
--右外联接：返回内联接的结果+被内联接排除的在目标表中的行
SELECT e.last_name, d.department_name
FROM departments d RIGHT OUTER JOIN employees e ON(d.department_id=e.department_id) WHERE e.last_name LIKE 'G%';
--全外联接：返回内联接的结果+被内联接排除的在源表和目标表中的行
SELECT e.last_name, d.department_name
FROM departments d FULL OUTER JOIN employees e ON(d.department_id=e.department_id) WHERE e.department_id IS NULL;

--例子查找没有分配员工的部门
SELECT d.department_id, d.department_name,e.* 
FROM departments d 
LEFT OUTER JOIN employees e on(d.department_id=e.department_id) WHERE e.department_id IS NULL; 




























