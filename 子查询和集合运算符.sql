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

