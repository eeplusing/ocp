--oracle网路
--测试oracle net的连接性 
--正确的测试
C:\Users\admin>tnsping orcl1
TNS Ping Utility for 64-bit Windows: Version 11.2.0.1.0 - Production on 31-12月-2018 11:21:47
Copyright (c) 1997, 2010, Oracle.  All rights reserved.
已使用的参数文件:
C:\app\admin\product\11.2.0\client_1\network\admin\sqlnet.ora
已使用 TNSNAMES 适配器来解析别名
尝试连接 (DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.1.103)(PORT = 1521))) (CONNECT_DATA = (SERVICE_NAME = orcl1.eplusing.com)))
OK (20 毫秒)

--错误的测试
C:\Users\admin>tnsping orcl
TNS Ping Utility for 64-bit Windows: Version 11.2.0.1.0 - Production on 31-12月-2018 11:22:16
Copyright (c) 1997, 2010, Oracle.  All rights reserved.
已使用的参数文件:
C:\app\admin\product\11.2.0\client_1\network\admin\sqlnet.ora
TNS-03505: 无法解析名称

--创建数据库连接
SQL> create database link dblink connect to system identified by Oracle123 using 'orcl1.eplusing.com';
Database link created




