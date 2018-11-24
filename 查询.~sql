--数据库建模步骤：逻辑模型，关系模型，物理模型
--查询 
SELECT t.*, t.job_id FROM employees t;

SELECT distinct(t.job_id) FROM employees t;

SELECT DISTINCT(t.department_id) FROM employees t;

SELECT * FROM regions;
--统计总数
SELECT COUNT(*) FROM countries t WHERE t.region_id=1;
--算数运算
SELECT j.employee_id, j.job_id, j.start_date, j.end_date, (end_date-start_date)+1 "Days Employed" FROM job_history j;
--字符串连接
SELECT 'THE '||region_name||' region is on Planet Earth' "Planetary Location" FROM regions;
--DUAL表
SELECT (5*9+3)/7 FROM dual;
--两个单引号或引用运算符
--使用两个单引号
SELECT 'I''m lucy' "describe" FROM dual;
--使用引用运算符
SELECT q'<plural's>' FROM dual;
 











