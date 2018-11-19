--事务
--会话1
SELECT * FROM regions;
--会话2
SELECT * FROM regions;
--会话1
INSERT INTO regions VALUES(100,'UK');
--会话2
INSERT INTO regions VALUES(101,'GB');
--会话1
COMMIT;
SELECT * FROM regions;
--会话2
SELECT * FROM regions;
--会话1
ROLLBACK;
SELECT * FROM regions;
--会话2
ROLLBACK;
SELECT * FROM regions;


--闪回查询
ALTER SESSION SET nls_date_format='dd-mm-yy hh24:mi:ss';
SELECT SYSDATE FROM dual;
DELETE FROM regions WHERE region_id=100;
--查看regions19-11-2018 21:14:20时刻的数据，region=100这行是从撤销段中检索出来的
SELECT * FROM regions AS OF TIMESTAMP  to_timestamp('19-11-2018 21:14:20','dd-mm-yy hh24:mi:ss');

--闪回查询的应用
--查询数据库在以前某个时刻的状态
SELECT * FROM hr.employees AS OF TIMESTAMP(SYSTIMESTAMP - 10/1440);

--删除操作出错（已执行），希望把所有删除的行插回表中,把2分钟前删除的行插入表中
INSERT INTO regions(
       SELECT * FROM regions AS OF TIMESTAMP(SYSTIMESTAMP - 2/1440) MINUS SELECT * FROM regions
);

