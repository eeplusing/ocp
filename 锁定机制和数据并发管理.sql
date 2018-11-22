--锁定机制和数据并发管理
--排他锁：
  --行级排他锁：锁定一行防止其他会话对该行更新，但其他会话可以进行读取操作，在指定记录上请求排他锁的第一个会话会得到这个锁定，
              --其他请求对该记录进行写访问的会话必须等待，对该记录进行读访问的会话可以正常进行（读操作涉及撤销数据的使用，
              --从而保证读会话不会看到任何未被提交的变更）。
  --表级排他锁：执行DDL命令时，需要使用涉及对象上的排他锁，只有在针对指定表的所有DML事务结束，且行上的排他锁和表上的共享锁都解除后，
              --才能获得执行DDL命令的排他锁。
--共享锁：
  --行级共享锁：共享锁放在表上无意义，因为锁定一行的唯一目的就是获得修改改行所需的排他锁。
  --表级共享锁：在表上放置共享锁的目的是防止其他会话获取该表的排他锁（表上在已经存在共享锁的情况下无法再获得排他锁）。
    
--所有DML语句至少都需要两种锁：受影响记录上的排他锁和受影响记录所在表上的共享锁，排他锁能够防止其他会话干预指定的行，
--共享锁可以放置其他会话使用DDL修改表的定义。 


--排队机制
--不排队
SELECT * FROM tablename FOR UPDATE NO WAIT; 
--排队一定时间(200单位秒)
SELECT * FROM tablename FOR UPDATE WAIT<200>;
--排队，指导获取到锁
SELECT * FROM tablename WHERE tid=primarykeyvalue FOR UPDATE;
--排队，获取未被其他会话锁定的行
SELECT * FROM TABLE WHERE tid > primarykeyvalue FOR UPDATE SKIP LOCKED;

--检测锁定争用 需要使用拥有v$session视图权限的用户
SELECT waiter.username "Blocked session", waiter.SID, blocker.username "Blocking session", 
blocker.sid, blocker.SERIAL# FROM v$session waiter JOIN v$session blocker ON(waiter.BLOCKING_SESSION=blocker.sid);

--查询日志trace信息
SELECT * FROM v$diag_info WHERE NAME='Diag Trace';

--less alert_orcl1.log
--2018-11-22T23:24:40.424369+08:00
--ORA-00060: Deadlock detected. See Note 60.1 at My Oracle Support for Troubleshooting ORA-60 Errors. More info in file /u01/app/oracle/diag/rdbms/orcl1/orcl1/trace/orcl1_s000_3771.trc.
--less /u01/app/oracle/diag/rdbms/orcl1/orcl1/trace/orcl1_s000_3771.trc
/*
2018-11-22 23:24:39.197*:ksq.c@12954:ksqdld_hdr_dump(): 
DEADLOCK DETECTED ( ORA-00060 )
See Note 60.1 at My Oracle Support for Troubleshooting ORA-60 Errors

[Transaction Deadlock]
 
The following deadlock is not an ORACLE error. It is a
deadlock due to user error in the design of an application
or from issuing incorrect ad-hoc SQL. The following
information may aid in determining the deadlock:
 
Deadlock graph:
                                          ------------Blocker(s)-----------  ------------Waiter(s)------------
Resource Name                             process session holds waits serial  process session holds waits serial
TX-0006001E-000003E9-00000000-00000000         33     142     X        31924      26     147           X   4162
TX-00020015-000003E5-00000000-00000000         26     147     X         4162      33     142           X  31924
*/
