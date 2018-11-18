--以system用户登录db
--查询数据库使用撤销段还是回滚段
SELECT v.VALUE, v.* FROM v$parameter v WHERE v.NAME='undo_management';

--若不是value!=AUTO 调用下面命令并重启实例
ALTER SYSTEM SET undo_management=AUTO SCOPE=SPFILE;

--查询已经创建的撤销表空间及正在使用的是哪个撤销表空间
SELECT tablespace_name FROM dba_tablespaces WHERE CONTENTS='UNDO';
SELECT VALUE FROM v$parameter WHERE NAME='undo_tablespace';

--查询数据使用的撤销段及其大小
SELECT tablespace_name, segment_name, segment_id, status FROM dba_rollback_segs;
SELECT usn, rssize FROM v$rollstat;

--查看数据进来生产的撤销数据量
ALTER SESSION SET nls_date_format='dd-mm-yy hh24:mi:ss';

SELECT begin_time, end_time, (
       undoblks * (SELECT VALUE FROM v$parameter WHERE NAME='db_block_size')
) undo_bytes FROM v$undostat;



--创建撤销表空间
CREATE UNDO TABLESPACE undo2 DATAFILE '/home/oracle/oracleDBFile/undo2'
SIZE 100m;
--查询数据库中的表空间
SELECT tablespace_name, CONTENTS, RETENTION FROM dba_tablespaces;

--查询数据库中的撤销段
SELECT tablespace_name, segment_name, status FROM dba_rollback_segs;

--调整实例使用新的撤销表空间
ALTER SYSTEM SET undo_tablespace=undo2 SCOPE=MEMORY;

--调整撤销表空间原初始值
ALTER SYSTEM SET undo_tablespace=undotbs1;

--删除撤销表空间
DROP TABLESPACE undo2 INCLUDING CONTENTS AND DATAFILES;




