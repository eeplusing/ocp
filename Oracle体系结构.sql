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

--查询oracle实例中运行的进程
SELECT * FROM v$bgprocess v WHERE paddr <> '00' ORDER BY name;
/*
000000006AB4DDB8  1 AQPC  AQ Process Coord  0   0
000000006AB47A58  1 ARC0  Archival Process 0  0   0
000000006AB49B78  1 ARC1  Archival Process 1  0   0
000000006AB4AC08  1 ARC2  Archival Process 2  0   0
000000006AB4BC98  1 ARC3  Archival Process 3  0   0
000000006AB5D628  1 CJQ0  Job Queue Coordinator 0   0
000000006AB32F18  1 CKPT  checkpoint  0   0
000000006AB21588  1 CLMN  process cleanup 0   0
000000006AB2BB28  1 DBRM  DataBase Resource Manager 0   0
000000006AB30DF8  1 DBW0  db writer process 0 0   0
000000006AB2FD68  1 DIA0  diagnosibility process 0  0   0
000000006AB26858  2 DIAG  diagnosibility process  0   0
000000006AB3D4B8  1 FENC  IOServer fence monitor  448   0
000000006AB24738  1 GEN0  generic0  0   0
000000006AB278E8  1 GEN1  generic1  0   0
000000006AB33FA8  1 LG00    0 SLAVE 0
000000006AB360C8  1 LG01    0 SLAVE 0
000000006AB31E88  1 LGWR  Redo etc. 0   0
000000006AB3A308  1 LREG  Listener Registration 0   0
000000006AB257C8  1 MMAN  Memory Manager  0   0
000000006AB3D4B8  2 MMNL  Manageability Monitor Process 2 0   0
000000006AB3E548  1 MMON  Manageability Monitor Process 0   0
000000006AB29A08  1 OFSD  Oracle File Server BG 0   0
000000006AB2ECD8  1 PMAN  process manager 0   0
000000006AB204F8  1 PMON  process cleanup 0   0
000000006AB22618  1 PSP0  process spawner 0 0   0
000000006AB3C428  1 PXMN  PX Monitor  0   0
000000006AB5F748  1 Q002    0 SLAVE 0
000000006AB607D8  1 Q003    0 SLAVE 0
000000006AB43818  4 QM02    0 SLAVE 0
000000006AB381E8  1 RECO  distributed recovery  0   0
000000006AB28978  1 SCMN    0 SLAVE 0
000000006AB2AA98  1 SCMN    0 SLAVE 0
000000006AB37158  1 SMCO  Space Manager Process 0   0
000000006AB35038  1 SMON  System Monitor Process  0   0
000000006AB2DC48  1 SVCB  services background monitor 0   0
000000006AB416F8  1 TMON  Transport Monitor 0   0
000000006AB469C8  1 TT00    0 SLAVE 0
000000006AB48AE8  1 TT01    0 SLAVE 0
000000006AB4CD28  1 TT02    0 SLAVE 0
000000006AB2CBB8  1 VKRM  Virtual sKeduler for Resource Manager 0   0
000000006AB236A8  1 VKTM  Virtual Keeper of TiMe process  0   0
000000006AB3B398  1 W001    0 SLAVE 0
000000006AB5E6B8  28  W004    0 SLAVE 0
000000006AB4EE48  106 W005    0 SLAVE 0
000000006AB61868  30  W006    0 SLAVE 0
000000006AB64A18  5 W007    0 SLAVE 0
 */

SELECT program, paddr FROM v$session ORDER BY program;
SELECT program, addr FROM v$process ORDER BY program;

--通过系统命令查看进程变化
--#ps -ef|grep LOCAL|wc -l

--在默认表空间中创建表
CREATE TABLE tab34(c1 VARCHAR2(10)) SEGMENT creation IMMEDIATE;
--查询表所在的表空间、区间大小、区间所在的文件标号、区间开始的文件块
SELECT tablespace_name, bytes, file_id, block_id, extent_id, ex.* FROM dba_extents ex WHERE owner='SYSTEM' AND segment_name='TAB34';

--查找数据文件名
SELECT NAME FROM v$datafile WHERE FILE#=&file_id;
--计算出段区间在的文件中的位置
SELECT block_size * &block_id FROM Dba_Tablespaces WHERE tablespace_name='&tablesapce_name';
 

















