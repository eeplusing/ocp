--���ݿ⽨ģ���裺�߼�ģ�ͣ���ϵģ�ͣ�����ģ��
--��ѯ 
SELECT t.*, t.job_id FROM employees t;

SELECT distinct(t.job_id) FROM employees t;

SELECT DISTINCT(t.department_id) FROM employees t;

SELECT * FROM regions;
--ͳ������
SELECT COUNT(*) FROM countries t WHERE t.region_id=1;
--��������
SELECT j.employee_id, j.job_id, j.start_date, j.end_date, (end_date-start_date)+1 "Days Employed" FROM job_history j;
--�ַ�������
SELECT 'THE '||region_name||' region is on Planet Earth' "Planetary Location" FROM regions;
--DUAL��
SELECT (5*9+3)/7 FROM dual;
--���������Ż����������
--ʹ������������
SELECT 'I''m lucy' "describe" FROM dual;
--ʹ�����������
SELECT q'<plural's>' FROM dual;

--�����е��Ӿ�
SELECT last_name, salary FROM employees ORDER BY salary OFFSET 100 ROWS FETCH FIRST 7 ROWS ONLY;
  
SELECT last_name, salary FROM employees ORDER BY salary OFFSET 100 ROWS FETCH FIRST 5 ROWS ONLY;
--with ties ֻ��ָ����order by�Ӿ����Ч
SELECT last_name, salary FROM employees ORDER BY salary OFFSET 100 ROWS FETCH FIRST 5 ROWS WITH ties;

--&��&&�滻 ��sqlplus��ִ��
SELECT FIRST_NAME, '&&EMPLOYEE_ID', SALARY, SALARY * 12 AS "ANNUAL SALARY", '&&TAX_RATE', 
('&TAX_RATE'*(SALARY*12)) AS "TAX" FROM employees WHERE employee_id='&EMPLOYEE_ID';












