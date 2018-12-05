/*
���к�����ÿ��ֻ���������ݼ���һ��
���к������ۺϺ�������麯��
*/
--��Сдת��
SELECT LOWER(100+100),LOWER('SQL'),LOWER(SYSDATE) FROM dual;
SELECT UPPER('sql'), c.* FROM countries c WHERE UPPER(country_name) LIKE '%U%S%A%';
--����ĸ��д
SELECT INITCAP('init cap or init_cap or init*cap or init%cap') FROM dual;

--�ַ���������
--�����ַ���
SELECT CONCAT('Today is:',SYSDATE) FROM dual;
--���㳤��
SELECT * FROM countries WHERE LENGTH(country_name)>10;
--���̶�����
SELECT first_name|| ' '||last_name||' earns '||salary no_lpad_rpad_example FROM employees WHERE department_id=100;
SELECT RPAD(first_name|| ' '||last_name, 18,'-')||' earns '||LPAD(salary,6,'0') lpad_rpad_example FROM employees WHERE department_id=100;
--��ȡ����
--ȥ�ո�
SELECT TRIM(' space  ') FROM dual;
--������
SELECT TRIM(BOTH '*' FROM '**Hidden**') FROM dual;
--��ͷ
SELECT TRIM(LEADING '*' FROM '**Hidden**') FROM dual;
--��β
SELECT TRIM(TRAILING '*' FROM '**Hidden**') FROM dual;

--�����ַ����ֵ�λ��
--��1�γ���#��λ��
SELECT INSTR('1#3#5#7#9#','#') FROM dual;
--�ӵ�5���ַ���ʼ��1�γ���#��λ��
SELECT INSTR('1#3#5#7#9#','#',5) FROM dual;
--�ӵ�3���ַ���ʼ��4�γ���#��λ��
SELECT INSTR('1#3#5#7#9#','#',3,4) FROM dual;
--���ַ�λ�ý�ȡ
SELECT SUBSTR('1#3#5#7#9#',5) FROM dual;
SELECT SUBSTR('1#3#5#7#9#',5,3) FROM dual;
-- -3��ʶ��β��ǰ3���ַ�
SELECT SUBSTR('1#3#5#7#9#',-3,2) FROM dual;

--��->�滻#�滻
SELECT REPLACE('1#3#5#7#9#','#','->') FROM dual;
--����������Ϊ�գ���Ĭ���ÿ��ַ����#���༴��#ɾ��
SELECT REPLACE('1#3#5#7#9#','#') FROM dual;

--4��5��
SELECT ROUND(1601.916,1) FROM dual; 
SELECT ROUND(1601.916,2) FROM dual; 
SELECT ROUND(1601.916,-3) FROM dual; 
--Ĭ����0
SELECT ROUND(1601.916) FROM dual; 

--�����Ƚض�
SELECT TRUNC(1601.916,1) FROM dual;
SELECT TRUNC(1601.916,2) FROM dual;
SELECT TRUNC(1601.916,-3) FROM dual;
SELECT TRUNC(1601.916) FROM dual;

--ȡ��
SELECT MOD(4,2) FROM dual;
SELECT MOD(5,3) FROM dual;
SELECT MOD(7,3.51) FROM dual;
SELECT MOD(5.2,3) FROM dual;

--�����ຯ��
SELECT SYSDATE FROM dual;
SELECT SYSDATE-1 FROM dual;
SELECT SYSDATE-10/1440 FROM dual;
--��
SELECT months_between(SYSDATE, SYSDATE-30) FROM dual;
SELECT add_months(to_date('02-12-2018','DD-MM-YYYY'),1) FROM dual;
SELECT add_months(to_date('02-12-2018','DD-MM-YYYY'),2.5) FROM dual;
SELECT add_months(to_date('02-12-2018','DD-MM-YYYY'),-12) FROM dual;
--������һ������
SELECT next_day(to_date('2018-12-02','YYYY-MM-DD'),'����һ') FROM dual;

SELECT * FROM nls_database_parameters t WHERE t.parameter='NLS_DATE_LANGUAGE';
SELECT * FROM nls_instance_parameters t WHERE t.parameter='NLS_DATE_LANGUAGE';
SELECT * FROM nls_session_parameters t WHERE t.parameter='NLS_DATE_LANGUAGE';

SELECT add_months(to_date('2018-12-07','YYYY-MM-DD'), 1) FROM dual;
SELECT add_months(to_date('2018-12-07','YYYY-MM-DD'), 1.4) FROM dual;
SELECT add_months(to_date('2018-12-07','YYYY-MM-DD'), -12) FROM dual;

--��ȡָ�����������µ����һ��
SELECT last_day(to_date('01-01-2009','DD-MM-YYYY')) FROM dual;
--ROUND���뵽��������Ŀ�ͷ���β
SELECT ROUND(SYSDATE) DAY, ROUND(SYSDATE,'w'), ROUND(SYSDATE,'month') MONTH, ROUND(SYSDATE,'year') YEAR FROM dual;
--TTRUNC 
--TRUNC(SYSDATE,'w')���ص������ǣ����µ�һ��������A���򷵻�ʱ��֮ǰ�������A���������
SELECT TRUNC(SYSDATE) DAY, TRUNC(SYSDATE,'w'), TRUNC(SYSDATE,'month') MONTH, TRUNC(SYSDATE,'year') YEAR FROM dual;

--TO_CHAR��ʽ����Ϊ�ַ���
--ȥ��ǰ��0
SELECT to_char(00001) FROM dual;
--��ʽ��Ϊ��0
SELECT to_char(00001,'0999999') FROM dual;
--С����λ��
SELECT to_char(030.40,'0999.999') FROM dual;
SELECT to_char(030.40,'0999D999') FROM dual;
--���ŵ�λ��  0003,040
SELECT to_char(03040,'0999,999') FROM dual;
SELECT to_char(03040,'0999G999') FROM dual;
--��Ԫ����
SELECT to_char(03040,'$0999,999') FROM dual;
--���ػ��ҷ���
SELECT to_char(03040,'L0999G999') FROM dual;
--�����ļ���λ�� 3040-
SELECT to_char(-3040,'99999MI') FROM dual;
--�����������ڵĸ��� <3040>
SELECT to_char(-3040,'99999PR') FROM dual;
--����10��n�η� 000304000
SELECT to_char(304,'099999V999') FROM dual;
--��ǰ���+��
SELECT to_char(304,'S0999999') FROM dual;

SELECT 'Ա�� '||employee_id|| ' ��ְ�ڸ�λ '||job_id||' ��ʱ�䣺'||to_char(end_date, 'fmDAY "the " ddth "of" MONTH YYYY') 
FROM job_history ORDER BY end_date; 

--TO_DATE()���ַ���ת��Ϊ����
SELECT to_date('2018-12-01','YYYY-MM-DD') FROM dual;
SELECT to_date('12-01','MM-DD') FROM dual;
SELECT to_date('2018-12-01 22:48:23','YYYY-MM-DD HH24:MI:SS') FROM dual;

--TO_NUMBER()���ַ���תΪ����
SELECT to_number('120') FROM dual;
SELECT to_number('$1,000.55','$999,999.99') FROM dual;

--Ƕ�׺���
SELECT next_day(last_day(SYSDATE)-7,'������') FROM dual;
















