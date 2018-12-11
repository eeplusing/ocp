--Oracle体系结构
--oracle服务器由实例和数据库两个实体组成，实例：由内存结构和进程组成，数据库由磁盘上的文件组成。
--oracle db服务器上从物理存储中完全抽象了逻辑存储，程序员看到的存储结构不直接与系统管理员看到的物理结构相关，两者的关系由控制文件和数据字典中的结构维护。
 
--构成oracle数据库的物理文件是数据文件、联机重做日志文件、控制文件  /u01/app/oracle/oradata/dbinstancename/controlfile/、datafile/ 、onlinelog/ 

--以system用户登录
--单实例返回NO
SELECT parallel FROM v$instance;
--数据库未受保护返回UNPROTECTED
SELECT protection_level FROM v$database;
--是否配置了流,没配置返回空
SELECT * FROM dba_streams_administrator;
--查询数据库的物理结构文件名
--数据库文件
SELECT name,bytes FROM v$datafile;
--临时文件
SELECT name,bytes FROM v$tempfile;
--日志文件
SELECT MEMBER FROM v$logfile;
--控制文件
SELECT * FROM v$controlfile;

--show sga;汇总显示SGA信息
--查询SGA组件当前、最大、最小的容量
SELECT component,current_size,min_size,max_size FROM v$sga_dynamic_components;
--查询已为PGA分配了多少内存
SELECT NAME,VALUE FROM v$pgastat WHERE NAME IN('maximum PGA allocated','total PGA allocated');





