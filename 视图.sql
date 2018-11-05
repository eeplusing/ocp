--视图：命名的select语句
/*
 视图作用：
 1.实施安全性，只允许用户看到表的部分行或列
 2.简化用户sql
 3.防止错误，按照没有歧义的方式提供数据
 4.使数据易于理解，在数据库对象和用户看到的对象之间提供抽象层
 5.用于提升性能的视图，如开发知道哪种技术好，可通知优化器采用这种技术，如 */
--DROP VIEW dept_emp;
--create or replace VIEW dept_emp as 
--select /*+USE_HASH(employees departments)*/ 
--department_name, last_name FROM departments NATURAL JOIN employees;
 

--创建视图
CREATE VIEW emp_anon_v AS 
SELECT hire_date, job_id, salary, commission_pct, department_id FROM employees;
 
CREATE VIEW dept_anon_v AS 
SELECT department_id, department_name, location_id FROM departments;

--创建复杂视图
CREATE VIEW dep_sum_v AS 
SELECT e.department_id, COUNT(1) staff, SUM(e.salary) salaries, d.department_name FROM emp_anon_v e JOIN dept_anon_v d 
ON e.department_id=d.department_id
GROUP BY e.department_id, d.department_name;







