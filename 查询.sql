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
 











