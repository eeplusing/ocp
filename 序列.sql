--����
--��������
CREATE SEQUENCE order_id_s
INCREMENT BY 1
START WITH 10000
MAXVALUE 10000000000
MIN VALUE 1
CYCLE
CACHE 10
--orderֻ�ڼ�Ⱥ���ݿ����йأ�orderǿ�Ƽ�Ⱥ�е�����ʵ��Эͬ�������У�
--�Ա㷢������ֵ���ǰ�˳�����У��������͸���ͬʵ���ĻỰҲ������
ORDER ;

CREATE SEQUENCE seq1 START WITH 10 NOCACHE MAXVALUE 15 CYCLE;

SELECT seq1.nextval FROM dual;
--currval�Ƿ��͸���ǰ�Ự����һ��ֵ����һ���Ƿ�������һ��ֵ
SELECT seq1.currval FROM dual;

--��ʾ������������ƻ���֮�Ⲣ����������һ��ֵ
CREATE TABLE seqtest(c1 NUMBER, c2 VARCHAR2(10));
ALTER TABLE seqtest ADD CONSTRAINT seqtest PRIMARY KEY (c1);

CREATE SEQUENCE seqtest_pk_s;
SELECT seqtest_pk_s.nextval FROM dual;
SELECT seqtest_pk_s.currval FROM dual;

--�ỰA
INSERT INTO seqtest(c1, c2)VALUES(seqtest_pk_s.nextval, 'first');
COMMIT;
--�ỰB
INSERT INTO seqtest(c1, c2)VALUES(seqtest_pk_s.nextval, 'second');
ROLLBACK;
--�ỰA
INSERT INTO seqtest(c1, c2)VALUES(seqtest_pk_s.nextval, 'third');
COMMIT;
--��ѯ���
SELECT * FROM seqtest;


DROP TABLE seqtest;
DROP SEQUENCE seqtest_pk_s;
DROP SEQUENCE seq1;


CREATE SEQUENCE prod_seq;
CREATE SEQUENCE cust_seq;
CREATE SEQUENCE order_seq;







