--��ͼ��������select���
/*
 ��ͼ���ã�
 1.ʵʩ��ȫ�ԣ�ֻ�����û�������Ĳ����л���
 2.���û�sql
 3.��ֹ���󣬰���û������ķ�ʽ�ṩ����
 4.ʹ����������⣬�����ݿ������û������Ķ���֮���ṩ�����
 5.�����������ܵ���ͼ���翪��֪�����ּ����ã���֪ͨ�Ż����������ּ������� */
--DROP VIEW dept_emp;
--create or replace VIEW dept_emp as 
--select /*+USE_HASH(employees departments)*/ 
--department_name, last_name FROM departments NATURAL JOIN employees;
 

--������ͼ
CREATE VIEW emp_anon_v AS 
SELECT hire_date, job_id, salary, commission_pct, department_id FROM employees;
 
CREATE VIEW dept_anon_v AS 
SELECT department_id, department_name, location_id FROM departments;

--����������ͼ
CREATE VIEW dep_sum_v AS 
SELECT e.department_id, COUNT(1) staff, SUM(e.salary) salaries, d.department_name FROM emp_anon_v e JOIN dept_anon_v d 
ON e.department_id=d.department_id
GROUP BY e.department_id, d.department_name;







