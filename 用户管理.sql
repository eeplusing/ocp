--创建用户
CREATE USER scott IDENTIFIED BY scott;

--查看用户
SELECT * FROM all_users;

SELECT * FROM dba_users;


--查看表空间
SELECT * FROM user_tablespaces;

SELECT * FROM dba_tablespaces;

--查询使用过的表空间
SELECT DISTINCT tablespace_name FROM user_all_tables;

SELECT DISTINCT tablespace_name FROM dba_all_tables;
