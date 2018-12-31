--段、区间、块、行
--查询段类型 以system登录
SELECT segment_type, COUNT(1) FROM dba_segments GROUP BY segment_type ORDER BY segment_type;

SELECT NAME FROM v$controlfile;

SELECT member, bytes FROM v$logfile JOIN v$log USING (group#);

--查看表空间及其包含的数据文件
SELECT tablespace_name, t.contents, d.file_name AS "数据文件" FROM dba_tablespaces t JOIN dba_data_files d USING(tablespace_name);
SELECT t.name, d.name, d.bytes FROM v$tablespace t JOIN v$datafile d USING(ts#) 
--查看临时表空间及其包含的数据文件
SELECT tablespace_name, t.contents, d.file_name AS "数据文件" FROM dba_tablespaces t JOIN dba_temp_files d USING(tablespace_name);
SELECT t.name, d.name, d.bytes FROM v$tablespace t JOIN v$tempfile d USING(ts#)

SELECT t.name, d.name, d.bytes FROM v$tablespace t JOIN v$datafile d USING(ts#) 
UNION ALL
SELECT t.name, d.name, d.bytes FROM v$tablespace t JOIN v$tempfile d USING(ts#); 

SELECT tablespace_name, t.contents, d.file_name, d.bytes FROM dba_tablespaces t JOIN dba_data_files d USING(tablespace_name) 
UNION ALL
SELECT tablespace_name, t.contents, d.file_name, d.bytes FROM dba_tablespaces t JOIN dba_temp_files d USING(tablespace_name); 

--查看表与物理存储位置
CREATE TABLE system.mytable AS SELECT * FROM all_objects;
SELECT tablespace_name FROM dba_tables WHERE owner='SYSTEM' AND table_name='MYTABLE';
SELECT tablespace_name, segment_type FROM dba_segments WHERE owner='SYSTEM' AND segment_name='MYTABLE';
SELECT file_name, extent_id, block_id FROM dba_data_files JOIN dba_extents USING(file_id) WHERE owner='SYSTEM' AND segment_name='MYTABLE';

ALTER TABLE system.mytable MOVE tablespace SYSAUX;

DROP TABLE system.mytable;

--创建表空间
--SMALLFILE是默认值，替换值BIGFILE
CREATE SMALLFILE TABLESPACE "TESTTABLESPACE" 
 DATAFILE '/u01/app/oracle/oradata/orcltesttablesapce01.dbf'
 SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE 200M
 LOGGING
 DEFAULT NOCOMPRESS NO INMEMORY
 ONLINE
 EXTENT MANAGEMENT LOCAL AUTOALLOCATE
 SEGMENT SPACE MANAGEMENT AUTO;
 
 --表空间管理示例
 CREATE tablespace newtbs 
 DATAFILE '/u01/app/oracle/oradata/ORCL1/datafile/newtbs_01.dbf' SIZE 10M
 EXTENT MANAGEMENT LOCAL AUTOALLOCATE
 SEGMENT SPACE MANAGEMENT AUTO;
 
 CREATE TABLE newtab(c1 DATE) TABLESPACE newtbs_new;
 
 SELECT extent_id,bytes FROM dba_extents WHERE owner='SYSTEM' AND segment_name='NEWTAB';
 --更改表空间
 ALTER TABLE newtab ALLOCATE EXTENT;
 --使表空间脱机
 ALTER TABLESPACE newtbs OFFLINE;
 --表空间脱机后不能再删除表
 DELETE newtab;
 DROP newtab;
 --使表空间联机
 ALTER TABLESPACE newtbs ONLINE;
 --将表空间置为只读
 ALTER TABLESPACE newtbs READ ONLY;
 DELETE newtab;
 DROP newtab;
 --将表空间置为读写
 ALTER TABLESPACE newtbs READ WRITE;
 --重命名表空间
 ALTER TABLESPACE newtbs RENAME TO newtbs_new;
 SELECT extent_id,bytes FROM dba_extents WHERE owner='SYSTEM' AND segment_name='NEWTAB';
 DROP TABLESPACE newtbs_new INCLUDING contents AND datafiles;
--重新调整表空间大小
ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/orcltesttablesapce01.dbf' RESIZE 10M;
--向表空间添加数据文件
ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/orcltesttablesapce02.dbf' RESIZE 2g;
--添加自动扩展子句
ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/orcltesttablesapce03.dbf' AUTOEXTEND ON NEXT 100M MAXSIZE 4g;

 --删除表空间
 DROP TABLESPACE newtbs INCLUDING contents AND datafiles;
 
 --查询表空间
 --查看区间管理是否为本地管理
 SELECT tablespace_name, extent_management FROM dba_tablespaces;
 --查看表空间是否在使用手动管理
 SELECT tablespace_name, segment_space_management FROM dba_tablespaces;
 
 --更改表空间特性 /u01/app/oracle/oradata/ORCL1/datafile/
 ALTER SYSTEM SET db_create_file_dest='/u01/app/oracle/oradata';
 CREATE TABLESPACE omftbs;
 SELECT file_name,bytes,autoextensible,maxbytes,increment_by FROM dba_data_files WHERE tablespace_name='OMFTBS';
 ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/ORCL1/datafile/o1_mf_omftbs_g2myjyg7_.dbf' RESIZE 500M;
 ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/ORCL1/datafile/o1_mf_omftbs_g2myjyg7_.dbf' AUTOEXTEND ON NEXT 100M MAXSIZE 2G;
 --删除表空间
 DROP TABLESPACE omftbs INCLUDING CONTENTS AND DATAFILES;
 
 --使用手动段空间管理创建表空间
 CREATE TABLESPACE manualsegs SEGMENT SPACE MANAGEMENT MANUAL;
 SELECT segment_space_management FROM dba_tablespaces WHERE tablespace_name='MANUALSEGS';
 CREATE TABLE mantab(c1 NUMBER) TABLESPACE manualsegs;
 CREATE INDEX mantabi ON mantab(c1) TABLESPACE manualsegs;
 --使用自动段空间管理创建表空间
 CREATE TABLESPACE autosegs;
 ALTER TABLE mantab MOVE TABLESPACE autosegs;
 ALTER INDEX mantabi REBUILD ONLINE TABLESPACE autosegs;
 SELECT * FROM dba_segments WHERE segment_name LIKE 'MANTAB%';
 --使用新表空间替换就表空间
 DROP TABLESPACE manualsegs INCLUDING CONTENTS AND DATAFILES;
 --重命名表空间
 ALTER TABLESPACE autosegs RENAME TO manualsegs;
 --清空表空间 删除非空表空间报错
 DROP TABLESPACE manualsegs;
 DROP TABLESPACE manualsegs INCLUDING CONTENTS AND DATAFILES;
 
 -------------------------------------------------------------------------------
 ----空间在3个级别上管理：表空间、段、块
 SELECT table_name,segment_created FROM user_tables;
 SELECT index_name,segment_created FROM user_indexes;
 SELECT segment_name, segment_type FROM user_segments;
 
 --管理段空间示例
CREATE USER ex7 IDENTIFIED BY ex7;
GRANT DBA TO ex7;
SQL> connect ex7/ex7
SQL> show parameter deferred_segment_creation
NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
deferred_segment_creation            boolean     TRUE
SQL> alter session set deferred_segment_creation=true;
Session altered

CREATE TABLE ex7a(c1 VARCHAR2(10));
--延迟创建段
CREATE TABLE ex7b(c1 VARCHAR2(10)) SEGMENT creation DEFERRED;
CREATE TABLE ex7c(c1 VARCHAR2(10)) SEGMENT creation IMMEDIATE;

CREATE INDEX ex7ai ON ex7a(c1);
CREATE INDEX ex7bi ON ex7b(c1);
CREATE INDEX ex7ci ON ex7c(c1);
 
SELECT segment_name FROM user_segments;
SELECT table_name, segment_created FROM user_tables;
SELECT index_name, segment_created FROM user_indexes;
 
INSERT INTO ex7a VALUES('a1'); 
INSERT INTO ex7b VALUES('b1');
--再次查询段是否创建
SELECT segment_name FROM user_segments;
SELECT table_name, segment_created FROM user_tables;
SELECT index_name, segment_created FROM user_indexes;

--创建使用压缩的表,压缩有3中形式，、混合列式压缩
--基本表压缩
CREATE TABLE testtable COMPRESS;
--高级行压缩
CREATE TABLE testtable1 ROW STORE COMPRESS ADVANCED;

--在会话级别设置可恢复空间分配，超过60s返回错误且语句失败
ALTER SESSION ENABLE RESUMABLE TIMEOUT 60;
ALTER SYSTEM SET resumable_timeout=60;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
