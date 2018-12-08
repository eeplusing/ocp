/*
单行函数：每次只作用于数据集的一行
多行函数：聚合函数或分组函数
*/
--大小写转换
SELECT LOWER(100+100),LOWER('SQL'),LOWER(SYSDATE) FROM dual;
SELECT UPPER('sql'), c.* FROM countries c WHERE UPPER(country_name) LIKE '%U%S%A%';
--首字母大写
SELECT INITCAP('init cap or init_cap or init*cap or init%cap') FROM dual;

--字符操作涵数
--连接字符串
SELECT CONCAT('Today is:',SYSDATE) FROM dual;
--计算长度
SELECT * FROM countries WHERE LENGTH(country_name)>10;
--填充固定长度
SELECT first_name|| ' '||last_name||' earns '||salary no_lpad_rpad_example FROM employees WHERE department_id=100;
SELECT RPAD(first_name|| ' '||last_name, 18,'-')||' earns '||LPAD(salary,6,'0') lpad_rpad_example FROM employees WHERE department_id=100;
--截取函数
--去空格
SELECT TRIM(' space  ') FROM dual;
--截两端
SELECT TRIM(BOTH '*' FROM '**Hidden**') FROM dual;
--截头
SELECT TRIM(LEADING '*' FROM '**Hidden**') FROM dual;
--截尾
SELECT TRIM(TRAILING '*' FROM '**Hidden**') FROM dual;

--查找字符出现的位置
--第1次出现#的位置
SELECT INSTR('1#3#5#7#9#','#') FROM dual;
--从第5个字符开始第1次出现#的位置
SELECT INSTR('1#3#5#7#9#','#',5) FROM dual;
--从第3个字符开始第4次出现#的位置
SELECT INSTR('1#3#5#7#9#','#',3,4) FROM dual;
--按字符位置截取
SELECT SUBSTR('1#3#5#7#9#',5) FROM dual;
SELECT SUBSTR('1#3#5#7#9#',5,3) FROM dual;
-- -3标识从尾向前3个字符
SELECT SUBSTR('1#3#5#7#9#',-3,2) FROM dual;

--用->替换#替换
SELECT REPLACE('1#3#5#7#9#','#','->') FROM dual;
--第三个参数为空，则默认用空字符提黄#，亦即将#删除
SELECT REPLACE('1#3#5#7#9#','#') FROM dual;

--4舍5入
SELECT ROUND(1601.916,1) FROM dual; 
SELECT ROUND(1601.916,2) FROM dual; 
SELECT ROUND(1601.916,-3) FROM dual; 
--默认是0
SELECT ROUND(1601.916) FROM dual; 

--按精度截断
SELECT TRUNC(1601.916,1) FROM dual;
SELECT TRUNC(1601.916,2) FROM dual;
SELECT TRUNC(1601.916,-3) FROM dual;
SELECT TRUNC(1601.916) FROM dual;

--取余
SELECT MOD(4,2) FROM dual;
SELECT MOD(5,3) FROM dual;
SELECT MOD(7,3.51) FROM dual;
SELECT MOD(5.2,3) FROM dual;

--日期类函数
SELECT SYSDATE FROM dual;
SELECT SYSDATE-1 FROM dual;
SELECT SYSDATE-10/1440 FROM dual;
--月
SELECT months_between(SYSDATE, SYSDATE-30) FROM dual;
SELECT add_months(to_date('02-12-2018','DD-MM-YYYY'),1) FROM dual;
SELECT add_months(to_date('02-12-2018','DD-MM-YYYY'),2.5) FROM dual;
SELECT add_months(to_date('02-12-2018','DD-MM-YYYY'),-12) FROM dual;
--查找下一个日期
SELECT next_day(to_date('2018-12-02','YYYY-MM-DD'),'星期一') FROM dual;

SELECT * FROM nls_database_parameters t WHERE t.parameter='NLS_DATE_LANGUAGE';
SELECT * FROM nls_instance_parameters t WHERE t.parameter='NLS_DATE_LANGUAGE';
SELECT * FROM nls_session_parameters t WHERE t.parameter='NLS_DATE_LANGUAGE';

SELECT add_months(to_date('2018-12-07','YYYY-MM-DD'), 1) FROM dual;
SELECT add_months(to_date('2018-12-07','YYYY-MM-DD'), 1.4) FROM dual;
SELECT add_months(to_date('2018-12-07','YYYY-MM-DD'), -12) FROM dual;

--获取指定日子所属月的最后一天
SELECT last_day(to_date('01-01-2009','DD-MM-YYYY')) FROM dual;
--ROUND舍入到精度最近的开头或结尾
SELECT ROUND(SYSDATE) DAY, ROUND(SYSDATE,'w'), ROUND(SYSDATE,'month') MONTH, ROUND(SYSDATE,'year') YEAR FROM dual;
--TTRUNC 
--TRUNC(SYSDATE,'w')返回的日期是：本月第一天所属周A，则返回时刻之前的最近周A那天的日期
SELECT TRUNC(SYSDATE) DAY, TRUNC(SYSDATE,'w'), TRUNC(SYSDATE,'month') MONTH, TRUNC(SYSDATE,'year') YEAR FROM dual;

--TO_CHAR格式数字为字符串
--去除前导0
SELECT to_char(00001) FROM dual;
--格式化为左补0
SELECT to_char(00001,'0999999') FROM dual;
--小数点位置
SELECT to_char(030.40,'0999.999') FROM dual;
SELECT to_char(030.40,'0999D999') FROM dual;
--逗号的位置  0003,040
SELECT to_char(03040,'0999,999') FROM dual;
SELECT to_char(03040,'0999G999') FROM dual;
--美元符号
SELECT to_char(03040,'$0999,999') FROM dual;
--当地货币符号
SELECT to_char(03040,'L0999G999') FROM dual;
--负数的减号位置 3040-
SELECT to_char(-3040,'99999MI') FROM dual;
--包含在括号内的负数 <3040>
SELECT to_char(-3040,'99999PR') FROM dual;
--乘以10的n次方 000304000
SELECT to_char(304,'099999V999') FROM dual;
--在前面加+号
SELECT to_char(304,'S0999999') FROM dual;

SELECT '员工 '||employee_id|| ' 离职于岗位 '||job_id||' ，时间：'||to_char(end_date, 'fmDAY "the " ddth "of" MONTH YYYY') 
FROM job_history ORDER BY end_date; 

--TO_DATE()将字符串转化为日期
SELECT to_date('2018-12-01','YYYY-MM-DD') FROM dual;
SELECT to_date('12-01','MM-DD') FROM dual;
SELECT to_date('2018-12-01 22:48:23','YYYY-MM-DD HH24:MI:SS') FROM dual;

--TO_NUMBER()将字符串转为数字
SELECT to_number('120') FROM dual;
SELECT to_number('$1,000.55','$999,999.99') FROM dual;

--嵌套函数
SELECT next_day(last_day(SYSDATE)-7,'星期三') FROM dual;

--条件函数
--NVL(original,ifnull)
--123
SELECT NVL(123,789) FROM dual;
--1234
SELECT NVL(NULL,1234) FROM dual;
--No substring exists
SELECT NVL(SUBSTR('abc', 4),'No substring exists') FROM dual;

--NVL2(original,ifnotnull,ifnull)
--5678
SELECT NVL2(NULL,1234,5678) FROM dual;
SELECT NVL2(SUBSTR('abc',2),'not bc','no substring') FROM dual;

--NULLIF(ifunequal,comparison_term),如果相等返回空，否则返回ifunequal
--返回空
SELECT NULLIF(1234,1234) FROM dual;
--abc
SELECT NULLIF('abc','a') FROM dual;

SELECT first_name,last_name,email,NVL2(
  NULLIF(
    SUBSTR(first_name,1,1)||UPPER(last_name),
    email
  ),
  'Email does not match pattern',
  'Match found'
) FROM employees WHERE length(first_name)=4;

--COALESCE(p1,p2,p3,...)返回第一个不为空的参数
SELECT COALESCE(NULL,NULL,NULL,'a string') FROM dual;
SELECT COALESCE(NULL,NULL,NULL)FROM dual;
SELECT COALESCE(SUBSTR('abc',4),'is null','not null')FROM dual;
--DECODE(exp1,comp1,iftrue1,comp2,true2,comp...,true...,false...)返回匹配的comp对应的true,否则返回空
SELECT DECODE(1234,123,'123 is match')FROM dual;
SELECT DECODE(1234,123,'123 is match', 'not match') FROM dual;
--true3,发现匹配后不再搜索 
SELECT DECODE('search','comp1','true1','comp2','true2','search','true3',SUBSTR('2search',2,6),'true4','false') FROM dual;

--CASE
SELECT
CASE SUBSTR(1234,1,3)
  WHEN '134' THEN '134 is a match'
  WHEN '135' THEN '135 is a match'
  WHEN CONCAT('1','23') THEN CONCAT('1','23')||'is a match'
  ELSE 'no match'
END
FROM dual;

--查询department_id=100的员工工作月数和年数对应的忠诚度
SELECT last_name,hire_date,SYSDATE,TRUNC(months_between(SYSDATE,hire_date))MONTH，TRUNC(months_between(SYSDATE,hire_date)/12) years,
  CASE TRUNC(months_between(SYSDATE,hire_date)/12)
    WHEN 6 THEN 'Intern'
    WHEN 7 THEN 'Junior'
    WHEN 8 THEN 'Intermediate' 
    WHEN 9 THEN 'Senior'
    ELSE 'Furniture'
  END loyalty
FROM employees WHERE department_id=100 ORDER BY years;

SELECT * FROM locations;
--下面这两个查询结果一样
SELECT DECODE(state_province,'Washington','Headquarters','Texas','Oil Wells','California',city,'New Jersey',street_address) location_info 
FROM locations WHERE country_id='US' ORDER BY location_info;

SELECT CASE state_province
  WHEN 'Washington' THEN 'Headquarters'
  WHEN 'Texas' THEN 'Oil Wells'
  WHEN 'California'THEN city
  WHEN 'New Jersey'THEN street_address
  END location_info 
FROM locations WHERE country_id='US' ORDER BY location_info;











