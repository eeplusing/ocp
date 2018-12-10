--�Ӳ�ѯ�ͼ��������
--��ѯ�����ҵ����salary
SELECT MAX(salary),country_id FROM(
  SELECT e.salary, department_id, location_id, country_id 
    FROM employees e 
    JOIN departments d USING(department_id) JOIN locations USING(location_id)
) GROUP BY country_id;

--���Ӳ�ѯ������ڱȽ�
SELECT last_name,salary FROM employees WHERE salary < (SELECT AVG(salary) FROM employees);

--��ѯ������Ա���Ĳ�������
SELECT department_name, department_id FROM departments WHERE department_id IN(SELECT DISTINCT(department_id) FROM employees);
SELECT department_name, departments.department_id FROM departments JOIN employees ON departments.department_id=employees.department_id; 

--��ѯ��Ӣ���Ĳ��Ź���������Ա��
SELECT last_name FROM employees
WHERE department_id IN(
  SELECT department_id FROM departments WHERE location_id IN(
    SELECT location_id FROM locations WHERE country_id=(
      SELECT country_id FROM countries WHERE country_name='United Kingdom'
    )
  )
);

--��ѯнˮ����ƽ��ֵ����IT���Ź�����Ա��
SELECT last_name FROM employees
WHERE department_id IN(
  SELECT department_id FROM departments WHERE department_name LIKE '%IT%'
) AND salary > (SELECT AVG(salary) FROM employees);

--нˮ����ƽ��ˮƽ��Ա��,�����Ӳ�ѯִֻ��һ��
SELECT last_name FROM employees WHERE salary < (SELECT AVG(salary) FROM employees);
--нˮ���ڲ���ƽ��ˮƽ��Ա�����ڼ������ѯ֮ǰ��ִ���Ӳ�ѯ�������Ӳ�ѯִ�ж��
SELECT p.last_name, p.department_id FROM employees p
  WHERE p.salary < (SELECT AVG(salary) FROM employees e WHERE e.department_id=p.department_id);

--��ѯнˮ����Tobias
SELECT last_name FROM employees WHERE salary > (SELECT salary FROM employees WHERE last_name='Tobias') ORDER BY last_name;
SELECT last_name FROM employees WHERE salary > ALL(SELECT salary FROM employees WHERE last_name='Taylor') ORDER BY last_name;
SELECT last_name FROM employees WHERE salary > ANY(SELECT salary FROM employees WHERE last_name='Taylor') ORDER BY last_name;

--��ѯ�о����Ա���Ҿ�����λ��Ӣ���Ĳ��Ź���
SELECT last_name FROM employees WHERE manager_id IN(
  SELECT employee_id FROM employees WHERE department_id IN(
    SELECT department_id FROM departments WHERE location_id IN(
      SELECT location_id FROM locations WHERE country_id='UK'
    )
  )
);

--��ѯƽ��ˮƽ��ߵĹ���
SELECT job_title FROM jobs NATURAL JOIN employees GROUP BY job_title 
HAVING AVG(salary)=(SELECT MAX(AVG(salary)) FROM employees GROUP BY job_id);
--��ѯнˮ����80���ŵ�Ա��
SELECT last_name FROM employees WHERE salary > ALL(SELECT salary FROM employees WHERE department_id=80);
SELECT last_name FROM employees WHERE salary > (SELECT max(salary) FROM employees WHERE department_id=80);

--��ѯ��Ա���Ĳ���
SELECT department_name FROM departments d WHERE EXISTS(
  SELECT * FROM employees e WHERE d.department_id=e.department_id
);
--��ѯû��Ա���Ĳ���
SELECT department_name FROM departments d WHERE NOT EXISTS(
  SELECT * FROM employees e WHERE d.department_id=e.department_id
);

--not in(�Ӳ�ѯ)���Ӳ�ѯ�а���nullֵʱ�൱��<>ALL������������ؿ�
SELECT last_name,employee_id,manager_id FROM employees WHERE employee_id NOT IN(SELECT manager_id FROM employees);
SELECT last_name,employee_id,manager_id FROM employees WHERE employee_id NOT IN(SELECT manager_id FROM employees WHERE manager_id IS NOT NULL);
SELECT last_name,employee_id,manager_id FROM employees WHERE employee_id IN(SELECT manager_id FROM employees);

--���ϲ�ѯ
SELECT region_name FROM regions;
SELECT region_name FROM regions UNION SELECT region_name FROM regions; 
SELECT region_name FROM regions UNION ALL SELECT region_name FROM regions;
SELECT region_name FROM regions INTERSECT SELECT region_name FROM regions;
SELECT region_name FROM regions MINUS SELECT region_name FROM regions;




 















