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

--限制行的子句
SELECT last_name, salary FROM employees ORDER BY salary OFFSET 100 ROWS FETCH FIRST 7 ROWS ONLY;
  
SELECT last_name, salary FROM employees ORDER BY salary OFFSET 100 ROWS FETCH FIRST 5 ROWS ONLY;
--with ties 只有指定了order by子句才有效
SELECT last_name, salary FROM employees ORDER BY salary OFFSET 100 ROWS FETCH FIRST 5 ROWS WITH ties;

--&和&&替换 在sqlplus中执行
SELECT FIRST_NAME, '&&EMPLOYEE_ID', SALARY, SALARY * 12 AS "ANNUAL SALARY", '&&TAX_RATE', 
('&TAX_RATE'*(SALARY*12)) AS "TAX" FROM employees WHERE employee_id='&EMPLOYEE_ID';












