--序列
--创建序列
CREATE SEQUENCE order_id_s
INCREMENT BY 1
START WITH 10000
MAXVALUE 10000000000
MIN VALUE 1
CYCLE
CACHE 10
--order只在集群数据库中有关，order强制集群中的所有实例协同递增序列，
--以便发出的数值总是按顺序排列，甚至发送给不同实例的会话也是这样
ORDER ;

CREATE SEQUENCE seq1 START WITH 10 NOCACHE MAXVALUE 15 CYCLE;

SELECT seq1.nextval FROM dual;
--currval是发送给当前会话的上一个值，不一定是发出的上一个值
SELECT seq1.currval FROM dual;

--演示序列在事务控制机制之外并立即发布下一个值
CREATE TABLE seqtest(c1 NUMBER, c2 VARCHAR2(10));
ALTER TABLE seqtest ADD CONSTRAINT seqtest PRIMARY KEY (c1);

CREATE SEQUENCE seqtest_pk_s;
SELECT seqtest_pk_s.nextval FROM dual;
SELECT seqtest_pk_s.currval FROM dual;

--会话A
INSERT INTO seqtest(c1, c2)VALUES(seqtest_pk_s.nextval, 'first');
COMMIT;
--会话B
INSERT INTO seqtest(c1, c2)VALUES(seqtest_pk_s.nextval, 'second');
ROLLBACK;
--会话A
INSERT INTO seqtest(c1, c2)VALUES(seqtest_pk_s.nextval, 'third');
COMMIT;
--查询结果
SELECT * FROM seqtest;


DROP TABLE seqtest;
DROP SEQUENCE seqtest_pk_s;
DROP SEQUENCE seq1;


CREATE SEQUENCE prod_seq;
CREATE SEQUENCE cust_seq;
CREATE SEQUENCE order_seq;







