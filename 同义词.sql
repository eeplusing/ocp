--同义词：任何sql都能通过实际名称和同义词访问该对象
/*
 同义词作用：用同义词可以不用考虑那个模式拥有视图和表，甚至不用考虑表驻留在那个数据库上
 */
 SELECT * FROM hr.employees@orcl1;

CREATE PUBLIC SYNONYM emp_synonym FOR hr.employees@orcl1;
--如上创建公共同义词，那么所有用户秩序输入如下语句，此处所有用户必须拥有访问底层对象的权限，才能成功使用基于同义词的引用
--这个语句提供了数据无关性、位置透明性，可以在不修改代码的情况下重命名或重定位表和视图

--创建同义词
CREATE SYNONYM emp_s FOR emp_anon_v;
CREATE SYNONYM dept_s FOR dept_anon_v;
CREATE SYNONYM dsum_s FOR dep_sum_v;

--查看同义词
describe emp_s;--在sqlplus下

--用dml与实际表明一样
SELECT * FROM dsum_s;
INSERT INTO dept_s VALUES(99,'Temp Dept',1800);
INSERT INTO emp_s VALUES(SYSDATE,'AC_MGR',10000,0,99);
UPDATE emp_s SET salary=salary*1.1;
ROLLBACK;
SELECT MAX(salaries / staff) FROM dsum_s;

--删除视图
DROP VIEW emp_anon_v;
DROP VIEW dept_anon_v;

--查询基于已删除视图的复杂视图
SELECT * FROM dep_sum_v;
--尝试编译被破坏的视图
ALTER VIEW dep_sum_v COMPILE;
--删除视图
DROP VIEW dep_sum_v;

--查询已删除视图的同义词
SELECT * FROM emp_s;

--重新编译被破坏的同义词
ALTER SYNONYM emp_s COMPILE;

--删除同义词
DROP SYNONYM emp_s;
DROP SYNONYM dept_s;
DROP SYNONYM dsum_s;









