--子查询和集合运算符
--查询各国家的最高salary
SELECT MAX(salary),country_id FROM(
  SELECT e.salary, department_id, location_id, country_id 
    FROM employees e 
    JOIN departments d USING(department_id) JOIN locations USING(location_id)
) GROUP BY country_id;

--将子查询结果用于比较
SELECT last_name,salary FROM employees WHERE salary < (SELECT AVG(salary) FROM employees);

--查询所有有员工的部门名称
SELECT department_name, department_id FROM departments WHERE department_id IN(SELECT DISTINCT(department_id) FROM employees);
SELECT department_name, departments.department_id FROM departments JOIN employees ON departments.department_id=employees.department_id; 

--查询在英国的部门工作的所有员工
SELECT last_name FROM employees
WHERE department_id IN(
  SELECT department_id FROM departments WHERE location_id IN(
    SELECT location_id FROM locations WHERE country_id=(
      SELECT country_id FROM countries WHERE country_name='United Kingdom'
    )
  )
);

--查询薪水高于平均值且在IT部门工作的员工
SELECT last_name FROM employees
WHERE department_id IN(
  SELECT department_id FROM departments WHERE department_name LIKE '%IT%'
) AND salary > (SELECT AVG(salary) FROM employees);

--薪水少于平均水平的员工,单行子查询只执行一次
SELECT last_name FROM employees WHERE salary < (SELECT AVG(salary) FROM employees);
--薪水少于部门平均水平的员工，在计算外查询之前先执行子查询，单行子查询执行多次
SELECT p.last_name, p.department_id FROM employees p
  WHERE p.salary < (SELECT AVG(salary) FROM employees e WHERE e.department_id=p.department_id);

--查询薪水高于Tobias
SELECT last_name FROM employees WHERE salary > (SELECT salary FROM employees WHERE last_name='Tobias') ORDER BY last_name;
SELECT last_name FROM employees WHERE salary > ALL(SELECT salary FROM employees WHERE last_name='Taylor') ORDER BY last_name;
SELECT last_name FROM employees WHERE salary > ANY(SELECT salary FROM employees WHERE last_name='Taylor') ORDER BY last_name;

--查询有经理的员工且经理在位于英国的部门工作
SELECT last_name FROM employees WHERE manager_id IN(
  SELECT employee_id FROM employees WHERE department_id IN(
    SELECT department_id FROM departments WHERE location_id IN(
      SELECT location_id FROM locations WHERE country_id='UK'
    )
  )
);

--查询平均水平最高的工作
SELECT job_title FROM jobs NATURAL JOIN employees GROUP BY job_title 
HAVING AVG(salary)=(SELECT MAX(AVG(salary)) FROM employees GROUP BY job_id);
--查询薪水高于80部门的员工
SELECT last_name FROM employees WHERE salary > ALL(SELECT salary FROM employees WHERE department_id=80);
SELECT last_name FROM employees WHERE salary > (SELECT max(salary) FROM employees WHERE department_id=80);

--查询有员工的部门
SELECT department_name FROM departments d WHERE EXISTS(
  SELECT * FROM employees e WHERE d.department_id=e.department_id
);
--查询没有员工的部门
SELECT department_name FROM departments d WHERE NOT EXISTS(
  SELECT * FROM employees e WHERE d.department_id=e.department_id
);

--not in(子查询)当子查询中包含null值时相当于<>ALL，下面这个返回空
SELECT last_name,employee_id,manager_id FROM employees WHERE employee_id NOT IN(SELECT manager_id FROM employees);
SELECT last_name,employee_id,manager_id FROM employees WHERE employee_id NOT IN(SELECT manager_id FROM employees WHERE manager_id IS NOT NULL);
SELECT last_name,employee_id,manager_id FROM employees WHERE employee_id IN(SELECT manager_id FROM employees);

--复合查询
SELECT region_name FROM regions;
SELECT region_name FROM regions UNION SELECT region_name FROM regions; 
SELECT region_name FROM regions UNION ALL SELECT region_name FROM regions;
SELECT region_name FROM regions INTERSECT SELECT region_name FROM regions;
SELECT region_name FROM regions MINUS SELECT region_name FROM regions;




 















