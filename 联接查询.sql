--���Ӳ�ѯ
--1.������
--NATURAL JOIN��Ȼ����ʹ��Դ���Ŀ�����ͬ����
--regions��Դ��countries��Ŀ���
SELECT region_name FROM regions NATURAL JOIN countries WHERE country_name='Canada';
SELECT country_name FROM countries NATURAL JOIN regions WHERE region_name='Americas';
SELECT region_name FROM regions JOIN countries USING(region_id) WHERE country_name='Canada';
--���ַ�ʽ���
SELECT country_name FROM countries 
  JOIN regions ON(countries.region_id=regions.region_id)
WHERE region_name='Americas';

--������oracle��ͳ�����﷨
SELECT regions.region_name, countries.country_name FROM 
regions, countries
WHERE regions.region_id=countries.region_id;

--2������
--������oracle��ͳ�����﷨�����employees���ұ�departments,
--�Ⱥ���ߣ�+����ʶΪ�������ӣ��ұ���ʾ�����У����û�����ұ�ƥ�������ʾΪ��
SELECT last_name,department_name FROM employees, departments 
WHERE employees.department_id(+)=departments.department_id;
--������oracle��ͳ�����﷨�����employees���ұ�departments,
--�Ⱥ��ұߣ�+����ʶΪ�������ӣ������ʾ�����У��ұ�û�������ƥ�������ʾΪ��
SELECT last_name,department_name FROM employees, departments 
WHERE employees.department_id=departments.department_id(+);


--3.��������
SELECT * FROM regions CROSS JOIN countries;
SELECT COUNT(*) FROM employees CROSS JOIN departments;
--oracle��ͳ�����﷨
SELECT * FROM regions,countries;

--NATURAL JOIN,ʹ�ó�������ϤԴ���Ŀ�����У��������ʹ����Ȼ����
SELECT employee_id, job_id, department_id, emp.last_name, emp.hire_date, jh.end_date 
FROM job_history jh NATURAL JOIN employees emp;

--JOIN USING
SELECT * FROM locations JOIN countries USING(country_id);

--JOIN ON
SELECT * FROM departments d JOIN employees e ON(d.department_id=e.department_id);
--oracle��ͳ�﷨
SELECT * FROM departments d, employees e WHERE d.department_id=e.department_id;
--ָ����ѯ����
SELECT * FROM departments d JOIN locations l ON(l.location_id=d.location_id) WHERE d.department_name LIKE 'P%';
SELECT * FROM departments d JOIN locations l ON(l.location_id=d.location_id AND d.department_name LIKE 'P%');

--���Ӳ��Ҳ��ž���
SELECT e.first_name||'��'||d.department_name||'�Ĳ��ž���' FROM employees e JOIN departments d ON(e.employee_id=d.manager_id);

--N·����
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

--��ѯ��������Ա�����������Ϣ
SELECT e.employee_id, e.first_name||' '||e.last_name,e.salary,g.region_name,c.country_name,l.street_address,d.department_name
FROM employees e
JOIN departments d ON(d.department_id=e.department_id)
JOIN locations l ON(l.location_id=d.location_id)
JOIN countries c ON(c.country_id=l.country_id)
JOIN regions g ON(g.region_id=c.region_id)

--��ͬ������
SELECT e.job_id current_job, 'The salary of '||e.last_name||' can be doubled by changing job to '||j.job_id options,
  e.salary current_salary, j.max_salary potential_max_salary
  FROM employees e JOIN jobs j ON(2*e.salary<j.max_salary)
WHERE e.salary>11000 ORDER BY last_name;

--JOIN ONʵ�������� ���Ӳ���Ա���ľ���
SELECT e.last_name employee, e.manager_id, m.last_name, e.department_id
FROM employees e JOIN employees m ON(e.manager_id=m.employee_id AND e.department_id IN(10,20,30));
SELECT e.last_name employee, e.manager_id, m.last_name, e.department_id
FROM employees e JOIN employees m ON(e.manager_id=m.employee_id) WHERE e.department_id IN(10,20,30);

--�����ӣ�����ͬ�����Ӻͷ�ͬ�����ӣ�����ƥ��Դ���Ŀ����е���

--�����ӣ������������ӡ��������ӡ�ȫ������
--�������ӣ����������ӵĽ��+���������ų�����Դ���е���
SELECT e.employee_id, e.department_id EMP_DEPT_ID, d.department_id DEPT_DEPT_ID, d.department_name
FROM departments d LEFT OUTER JOIN employees e ON(d.department_id=e.department_id) WHERE d.department_name LIKE 'P%';
SELECT e.employee_id, e.department_id EMP_DEPT_ID, d.department_id DEPT_DEPT_ID, d.department_name
FROM departments d JOIN employees e ON(d.department_id=e.department_id) WHERE d.department_name LIKE 'P%';
--�������ӣ����������ӵĽ��+���������ų�����Ŀ����е���
SELECT e.last_name, d.department_name
FROM departments d RIGHT OUTER JOIN employees e ON(d.department_id=e.department_id) WHERE e.last_name LIKE 'G%';
--ȫ�����ӣ����������ӵĽ��+���������ų�����Դ���Ŀ����е���
SELECT e.last_name, d.department_name
FROM departments d FULL OUTER JOIN employees e ON(d.department_id=e.department_id) WHERE e.department_id IS NULL;

--���Ӳ���û�з���Ա���Ĳ���
SELECT d.department_id, d.department_name,e.* 
FROM departments d 
LEFT OUTER JOIN employees e on(d.department_id=e.department_id) WHERE e.department_id IS NULL; 




























