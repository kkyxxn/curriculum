
--2014 ~ 2015�� ������ 4�� ȸ�� ���� ������
SELECT COUNT(*) FROM PURPROD; -- 28593030

--�� �Ӽ����� : 19383��(����)
SELECT * FROM CUSTDEMO;
SELECT COUNT(*) FROM custdemo;
SELECT * FROM COMPET;
SELECT * FROM CHANNEL;
SELECT * FROM MEMBERSHIP;
SELECT * FROM PRODCL;
SELECT * FROM PURPROD;
SELECT * FROM pur_amt;
SELECT * FROM CHANNEL;
SELECT * FROM COMPET;

--# ���� �м�(���� �м�)
SELECT YEAR, ROUND(SUM(���űݾ�)/1000000) as �ѱ��ž�, ROUND(AVG(���űݾ�)) as ��ձ��ž�
FROM PURPROD
GROUP BY YEAR;

--# �� �Ӽ�
--����, ���ɺ�, �������� �پ��� ���պ� ���� ��ȭ 
--����� �̿�, ����� �̿�, �¶��� ä�ο� ���� ���� Ư�̼�

--# �� �����ൿ ������ ��ȭ
--�پ��� �� ������ ���� ����, ��ǰ ���� ����, ���� ����(�ð�, ��� ��)

--# ���� ȯ�濡 ���� ����(������)

ALTER TABLE PURPROD ADD YEAR NUMBER;
UPDATE PURPROD SET YEAR=substr(��������,1,4);
COMMIT;

SELECT * FROM PURPROD;
COMMIT;

CREATE TABLE PURBYYEAR AS
SELECT ����ȣ, YEAR, SUM(���űݾ�) ���ž�
FROM PURPROD
GROUP BY ����ȣ, YEAR
ORDER BY ����ȣ;

SELECT * FROM PURBYYEAR;

CREATE TABLE pur_amt AS
SELECT ����ȣ cusno, sum(���űݾ�) puramt
FROM PURPROD
GROUP BY ����ȣ 
ORDER BY ����ȣ;

select count('��з���') from prodcl;

select * from purprod;

SELECT * FROM PRODCL ORDER BY ���޻�, ��з��ڵ�, �ߺз��ڵ�, �Һз��ڵ�;

-- ����з� 
UPDATE PRODCL SET ����з�='��ǰ' WHERE ���޻�='A' AND ��з��ڵ�='1';
UPDATE PRODCL SET ����з�='�ü�' WHERE ���޻�='A' AND ��з��ڵ�='1' AND �ߺз���='��Ÿ';
UPDATE PRODCL SET ����з�='��ȭ' WHERE ���޻�='A' AND ��з��ڵ�='1' AND �ߺз���='�Ͽ���ȭ';
UPDATE PRODCL SET ����з�='�ü�' WHERE ���޻�='A' AND �Һз��ڵ� LIKE 'A01062%';
UPDATE PRODCL SET ����з�='�ü�' WHERE ���޻�='A' AND �Һз��ڵ� LIKE 'A01063%';
UPDATE PRODCL SET ����з�='�ü�' WHERE ���޻�='A' AND �Һз��ڵ� LIKE 'A01064%';
UPDATE PRODCL SET ����з�='�ü�' WHERE ���޻�='A' AND �Һз��ڵ� LIKE 'A01065%';
UPDATE PRODCL SET ����з�='��ǰ' WHERE ���޻�='A'
AND (�Һз��ڵ�='A010620' OR �Һз��ڵ�='A010621' OR �Һз��ڵ�='A010622' OR �Һз��ڵ�='A010623'
OR �Һз��ڵ�='A010624');
SAVEPOINT SV2;
UPDATE PRODCL SET ����з�='��ǰ' WHERE ���޻�='D' AND ��з��ڵ�='4' OR �ߺз��ڵ�='0302';
SELECT*FROM PRODCL WHERE ���޻�='D';

UPDATE PRODCL SET ����з�='��ǰ' WHERE ���޻�='B' AND (��з��ڵ�='1' OR ��з��ڵ�='2'
OR ��з��ڵ�='3' OR ��з��ڵ�='4' OR ��з��ڵ�='5' OR ��з��ڵ�='6' OR ��з��ڵ�='7' OR "��з��ڵ�"='9'
OR ��з��ڵ�='10' OR ��з��ڵ�='11' OR ��з��ڵ�='12' OR ��з��ڵ�='13' OR ��з��ڵ�='14' OR ��з��ڵ�='15'
OR ��з��ڵ�='16' OR ��з��ڵ�='38' OR ��з��ڵ�='43' OR ��з��ڵ�='46' OR ��з��ڵ�='47' OR ��з��ڵ�='48'
OR ��з��ڵ�='52' OR ��з��ڵ�='53' OR ��з��ڵ�='54' OR ��з��ڵ�='55' OR ��з��ڵ�='56' OR ��з��ڵ�='57'
OR ��з��ڵ�='58' OR ��з��ڵ�='59' OR ��з��ڵ�='60' OR ��з��ڵ�='61' OR ��з��ڵ�='62' OR ��з��ڵ�='64'
OR ��з��ڵ�='65' OR ��з��ڵ�='67' OR ��з��ڵ�='64' OR ��з��ڵ�='72' OR ��з��ڵ�='73' OR ��з��ڵ�='74'
OR ��з��ڵ�='75' OR ��з��ڵ�='76' OR ��з��ڵ�='77' OR ��з��ڵ�='78' OR ��з��ڵ�='79' OR ��з��ڵ�='80'
OR ��з��ڵ�='81' OR ��з��ڵ�='82' OR ��з��ڵ�='83' OR ��з��ڵ�='89' OR ��з��ڵ�='91' OR ��з��ڵ�='92'); 
UPDATE PRODCL SET ����з�='�ü�' WHERE ���޻�='B' AND ��з��ڵ�='8';
SAVEPOINT SV3;

update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='1' AND �ߺз���='�������';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='1' AND �ߺз���='���԰���';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='1' AND �ߺз���='�õ�����';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='1' AND �ߺз���='�ǰ���';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='1' AND �ߺз���='�߰���';

update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='2' AND �ߺз���='���';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='2' AND �ߺз���='���';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='2' AND �ߺз���='���ķ�';

update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='3' AND �ߺз���='��ä��';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='3' AND �ߺз���='��ä��';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='3' AND �ߺз���='��ä��';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='3' AND �ߺз���='��ä��';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='3' AND �ߺз���='��ġä�ҷ�';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='3' AND �ߺз���='������';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='3' AND �ߺз���='��ä��';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='3' AND �ߺз���='������';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='3' AND �ߺз���='�����';


update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='4' AND �ߺз���='�ع���';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='4' AND �ߺз���='��Ÿ����';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='4' AND �ߺз���='�����';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='4' AND �ߺз���='�����';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='4' AND �ߺз���='�Ǿ��';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='4' AND �ߺз���='�Ǿ��';

update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='5' AND �ߺз���='���������';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='5' AND �ߺз���='�����굷��';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='5' AND �ߺз���='���������';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='5' AND �ߺз���='���Կ���';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='5' AND �ߺз���='���Ե���';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='5' AND �ߺз���='��Ÿ���';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='5' AND �ߺз���='���������';

update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='6' AND �ߺз���='������';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='6' AND �ߺз���='������';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='6' AND �ߺз���='�Ļ��';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='6' AND �ߺз���='����Ŀ��';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='6' AND �ߺз���='��Ÿ������ǰ';

update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='7' AND �ߺз���='����';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='7' AND �ߺз���='��ȿ��';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='7' AND �ߺз���='ġ�����';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='7' AND �ߺз���='��������';

update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='8' AND �ߺз���='������';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='8' AND �ߺз���='�������';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='8' AND �ߺз���='�������';

update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='9' AND �ߺз���='���̽�ũ��';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='9' AND �ߺз���='����';

update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='10' AND �ߺз���='���尣��MS';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='10' AND �ߺз���='����Ļ�MS';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='10' AND �ߺз���='�����ŸMS';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='10' AND �ߺз���='�ó�MS';

update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='11' AND �ߺз���='����';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='11' AND �ߺз���='ź������';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='11' AND �ߺз���='��ä����';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='11' AND �ߺз���='Ŀ������';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='11' AND �ߺз���='������';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='11' AND �ߺз���='��ɼ�����';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='11' AND �ߺз���='����';

update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='12' AND �ߺз���='����';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='12' AND �ߺз���='����';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='12' AND �ߺз���='����';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='12' AND �ߺз���='����';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='12' AND �ߺз���='������';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='12' AND �ߺз���='��Ÿ���ַ�';

update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='13' AND �ߺз���='��������';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='13' AND �ߺз���='Ŀ�Ƿ�';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='13' AND �ߺз���='���';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='13' AND �ߺз���='����';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='13' AND �ߺз���='����';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='13' AND �ߺз���='�ǰ���ǰ';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='13' AND �ߺз���='�Ｎ��ǰ';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='13' AND �ߺз���='�����ǽ�ǰ';

update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='14' AND �ߺз���='���';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='14' AND �ߺз���='�Ŀ���';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='14' AND �ߺз���='���̷�';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='14' AND �ߺз���='��ø�������';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='14' AND �ߺз���='���̷�';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='14' AND �ߺз���='�����и���';

update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='15' AND �ߺз���='���';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='15' AND �ߺз���='�Ǹ�';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='15' AND �ߺз���='��Ű����ũ';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='15' AND �ߺз���='����';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='15' AND �ߺз���='ĵ�𲭷�';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='15' AND �ߺз���='���ݷ�';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='15' AND �ߺз���='�������';
update prodcl set ����з�='��ǰ' where ���޻� ='C' AND ��з��ڵ�='15' AND �ߺз���='������';

UPDATE PRODCL SET ����з�='�ü�' WHERE ���޻�='B' AND �ߺз��ڵ�='0901';


SELECT*FROM PRODCL WHERE ���޻�='C';

UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='A' AND �ߺз��ڵ�= '0201';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='A' AND �ߺз��ڵ�= '0207';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='A' AND ��з��ڵ�= '3';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='A' AND ��з��ڵ�= '4';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='A' AND ��з��ڵ�= '5';
UPDATE PRODCL SET ����з�=NULL WHERE �Һз��ڵ�='A020107' OR �Һз��ڵ�='A020109' OR �Һз��ڵ�='A020116' OR �Һз��ڵ�='A030112'
OR �Һз��ڵ�='A030114' OR �Һз��ڵ�='A040238' OR �Һз��ڵ�='A040240' OR �Һз��ڵ�='A040241' OR �Һз��ڵ�='A050230' OR �Һз��ڵ�='A050224' OR �Һз��ڵ�='A050504';
SAVEPOINT SV1;
UPDATE PRODCL SET ����з� = '�Ƿ�' WHERE ���޻� ='B' AND �Һз��ڵ� LIKE 'B50%' OR �Һз��ڵ� LIKE 'B51%' OR 
�Һз��ڵ� LIKE 'B68%' OR "�Һз��ڵ�" LIKE 'B69%';
UPDATE PRODCL SET ����з�='�ü�' WHERE ���޻�='B' AND ��з��ڵ�= '37';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='A' AND ��з��ڵ�='6' AND "�ߺз���"='������';
UPDATE PRODCL SET ����з�=NULL WHERE ���޻�='A' AND ��з��ڵ�='6' AND (�Һз���='��������'
OR �Һз���='�� ��' OR �Һз���='���ǰ' OR �Һз���='��������ǰ' OR �Һз���='��Ű' OR �Һз���='���۶�'
OR �Һз���='�����Ͻ�����' OR �Һз���='�ƿ�����');
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='A' AND �ߺз���='������ǰ' AND (�Һз���='N/B�����Ƿ�'
OR �Һз���='L/C�����Ƿ�' OR �Һз���='������ �����Ƿ�');



UPDATE PRODCL SET ����з�=NULL WHERE �Һз��ڵ�='B510302' OR �Һз��ڵ�='B510303' OR �Һз��ڵ�='B510305' OR �Һз��ڵ�='B510307'
OR �Һз��ڵ�='B510308' OR �Һз��ڵ�='B510309';
SAVEPOINT SV2;
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ��з��ڵ�='29';
UPDATE PRODCL SET ����з�=NULL WHERE �Һз��ڵ�='B290101' OR �Һз��ڵ�='B290102' OR �Һз��ڵ�='B290103' OR �Һз��ڵ�='B290201' OR �Һз��ڵ�='B290202';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ��з��ڵ�='30';
UPDATE PRODCL SET ����з�=NULL WHERE �Һз��ڵ�='B300503' ;
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE �Һз��ڵ�='B320201' OR �Һз��ڵ�='B320202' OR �Һз��ڵ�='B320203' OR �Һз��ڵ�='B320204'OR �Һз��ڵ�='B320205';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE �Һз��ڵ�='B320301' OR �Һз��ڵ�='B320302' OR �Һз��ڵ�='B320303' OR �Һз��ڵ�='B320304';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE �Һз��ڵ�='B320401' OR �Һз��ڵ�='B320402' OR �Һз��ڵ�='B320403' OR �Һз��ڵ�='B320404';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE �Һз��ڵ�='B320401' OR �Һз��ڵ�='B320402' OR �Һз��ڵ�='B320403' OR �Һз��ڵ�='B320404';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ��з��ڵ�='33';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE �Һз��ڵ�='B350103' OR �Һз��ڵ�='B350201' OR �Һз��ڵ�='B350401' OR �Һз��ڵ�='B350402' OR �Һз��ڵ�='B350403' OR �Һз��ڵ�='B350405' OR �Һз��ڵ�='B350406';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE �Һз��ڵ�='B350504' OR �Һз��ڵ�='B350603' OR �Һз��ڵ�='B350701' OR �Һз��ڵ�='B350702' OR �Һз��ڵ�='B350703' OR �Һз��ڵ�='B360208';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE �Һз��ڵ�='B360501' OR �Һз��ڵ�='B360502' OR �Һз��ڵ�='B360503' OR �Һз��ڵ�='B360801' OR �Һз��ڵ�='B360802';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE �Һз��ڵ�='B360501' OR �Һз��ڵ�='B360502' OR �Һз��ڵ�='B360503' OR �Һз��ڵ�='B360801' OR �Һз��ڵ�='B360802';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ��з��ڵ�='44';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE �Һз��ڵ�='B451502' OR �Һз��ڵ�='B451503' OR �Һз��ڵ�='B451504';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE �Һз��ڵ�='B451601' OR �Һз��ڵ�='B451602' OR �Һз��ڵ�='B451603';

UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='7004';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='7007';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE �Һз��ڵ�='B700601' OR �Һз��ڵ�='B700602' OR �Һз��ڵ�='B700603' OR �Һз��ڵ�='B710201' OR �Һз��ڵ�='B710202';





-- ��ü ����
UPDATE PRODCL SET ����з�='����' WHERE ���޻�='A' AND �ߺз��ڵ�='0905';
UPDATE PRODCL SET ����з�='����' WHERE ���޻�='A' AND �ߺз��ڵ�='0906';
UPDATE PRODCL SET ����з�='����' WHERE ���޻�='B' AND �ߺз��ڵ�='2207';
UPDATE PRODCL SET ����з�='����' WHERE ���޻�='B' AND �ߺз��ڵ�='2208';
UPDATE PRODCL SET ����з�='����' WHERE ���޻�='B' AND �ߺз��ڵ�='2209';
UPDATE PRODCL SET ����з�='����' WHERE ���޻�='B' AND �ߺз��ڵ�='2210';
UPDATE PRODCL SET ����з�='����' WHERE ���޻�='B' AND �ߺз��ڵ�='2214';
UPDATE PRODCL SET ����з�='����' WHERE ���޻�='B' AND �ߺз��ڵ�='2301';
UPDATE PRODCL SET ����з�='����' WHERE ���޻�='B' AND �ߺз��ڵ�='2303';
UPDATE PRODCL SET ����з�='����' WHERE ���޻�='B' AND �ߺз��ڵ�='2304';
UPDATE PRODCL SET ����з�='����' WHERE ���޻�='B' AND �ߺз��ڵ�='2305';
UPDATE PRODCL SET ����з�='����' WHERE ���޻�='B' AND ��з��ڵ�='88';
UPDATE PRODCL SET ����з�='����' WHERE �Һз��ڵ�='B220301' OR �Һз��ڵ�='B220302' OR �Һз��ڵ�='C170438';

UPDATE PRODCL SET ����з�=NULL WHERE �Һз��ڵ�='B230403' OR �Һз��ڵ�='B230404' OR �Һз��ڵ�='B230407' OR �Һз��ڵ�='B230503';

-- B, C �Ƿ� �Ϻ� �߰��߾��
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND ��з��ڵ�='49';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='4513';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='C' AND �ߺз��ڵ�='1704';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='C' AND �Һз��ڵ�='B451501';
UPDATE PRODCL SET ����з�=NULL WHERE �Һз��ڵ�='C170422' OR �Һз��ڵ�='C170423' OR �Һз��ڵ�='C170427' OR �Һз��ڵ�='C170428'
OR �Һз��ڵ�='C170429' OR �Һз��ڵ�='C170430' OR �Һз��ڵ�='C170431' OR �Һз��ڵ�='C170432' OR �Һз��ڵ�='C170433' OR �Һз��ڵ�='C170434'
OR �Һз��ڵ�='C170435' OR �Һз��ڵ�='C170436' OR �Һз��ڵ�='C170437' OR �Һз��ڵ�='A090606' OR �Һз��ڵ�='A090608';
SAVEPOINT S1;

UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE �ߺз��ڵ�='0203';

SELECT * FROM PRODCL WHERE "���޻�" = 'A' ORDER BY ��з��ڵ�;

UPDATE PRODCL SET ����з�=NULL WHERE ���޻�='A' AND ��з��ڵ�='2' AND (�Һз���='��Ÿ');
---------------------------------------------------------------------------------------
SELECT * FROM PRODCL WHERE "���޻�" = 'B' ORDER BY ��з��ڵ�;

UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='19' AND (�Һз���='������') AND (�Һз���='��Ǫ')AND(�Һз���='����')AND (�Һз���='��Ÿ�ϸ�')AND (�Һз���='��ġ�뿰����')AND (�Һз���='Į��뿰����');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='19' AND (�Һз���='�¶�����Ÿ�ϸ�') AND (�Һз���='�¶��� ����ǰ')AND (�Һз���='�̿��')AND (�Һз���='�ٵ�Ŭ����')AND (�Һз���='���̼�Ŭ����')AND (�Һз���='�ڵ����');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='19' AND (�Һз���='�ٵ�Ų�ɾ�') AND (�Һз���='���ƽ�Ų�ɾ�')AND (�Һз���='���̼Ƚ�Ų�ɾ�')AND (�Һз���='�¶��� ��Ų�ɾ�')AND (�Һз���='�ٵ��ǰ������Ʈ')AND (�Һз���='�귣�弼Ʈ');

UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='19' AND (�Һз���='�Ϲݼ�Ǫ��ǰ') AND (�Һз���='�Ϲݸ�����ǰ')AND (�Һз���='�¶����Ϲ�����ɾ�')AND (�Һз���='�����̾���Ǫ')AND (�Һз���='��߿����ɾ�');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='19' AND (�Һз���='���/�ѹ漤Ǫ') AND (�Һз���='���Ǽ�Ǫ')AND (�Һз���='���߷���Ǫ');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='34' AND (�Һз���='����ȭ���') AND (�Һз���='����ȭ���')AND (�Һз���='��ɼ�ȭ��ǰ')AND (�Һз���='ũ����/������')AND (�Һз���='����ȭ��ǰ');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='34' AND (�Һз���='���/�ٵ��ɾ�') AND (�Һз���='������ȭ��ǰ��Ÿ')AND (�Һз���='�ٵ��ǰ')or (�Һз���='����ǰ')AND (�Һз���='��Ÿ�Ʒθ���ǰ');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='34' AND (�Һз���='�¶��� ȭ��ǰ') AND (�Һз���='�̿��ǰ')AND (�Һз���='�̿��ǰ')AND (�Һз���='�Ʒθ���ǰ')AND (�Һз���='��Ÿ�Ʒθ���ǰ');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='66' AND (�Һз���='�����ٵ��ɾ�') OR (�Һз���='��������ɾ�')OR (�Һз���='�������̼��ɾ�')OR (�Һз���='��Ÿ �ٵ��ɾ�')OR (�Һз���='�ٵ�Ų�ɾ�');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='66' AND (�Һз���='����ũ��') OR (�Һз���='���ν�Ų�ɾ�')OR (�Һз���='�¶��ν�Ų�ɾ�')OR (�Һз���='�ڽ��޽�Ƽ��')OR (�Һз���='ƾ��Ų�ɾ�');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='66' AND (�Һз���='���̼�Ŭ����') OR (�Һз���='���̺�Ų�ɾ�')OR (�Һз���='���̺�Ŭ����')OR (�Һз���='�ڽ��޽�Ƽ��')OR (�Һз���='�ӻ���ɾ�');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='66' AND (�Һз���='�����ɾ�') OR (�Һз���='ǲ�ɾ�')OR (�Һз���='�ڵ��ɾ�')OR (�Һз���='��Ÿ�̿��ǰ')OR (�Һз���='����ũ���귯��');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='66' AND (�Һз���='��Ż') OR (�Һз���='��ø')OR (�Һз���='�����ǰ')OR (�Һз���='���')OR (�Һз���='Ŭ��¡');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='66' AND (�Һз���='���귯��/�ſ�') OR (�Һз���='ȭ���/���')OR (�Һз���='��ǻ��')OR (�Һз���='������')OR (�Һз���='�Կ���');
UPDATE PRODCL SET ����з�=null WHERE ���޻�='B' AND ��з��ڵ�='70' AND (�Һз���='�����ǰ') ;
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='70' AND (�Һз���='���') ;
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='86' AND (�Һз���='����Ÿ��') OR (�Һз���='��Ǽ�����ǰ');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='90' AND (�Һз���='����ȭ��ǰ') OR (�Һз���='����ȭ��ǰ')OR (�Һз���='�Ϲ�ȭ��ǰ')OR (�Һз���='��Ÿ����ȭ��ǰ')OR (�Һз���='����');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='90' AND (�Һз���='��') OR (�Һз���='���̽�')OR (�Һз���='����')OR (�Һз���='����')OR (�Һз���='�¶���ȭ��ǰ');
---------------------------

SELECT * FROM PRODCL WHERE "���޻�" = 'C' ORDER BY ��з��ڵ�;

UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='C' AND ��з��ڵ�='16' or (�Һз���='�����ɾ�') OR (�Һз���='ũ��/��/����')OR (�Һз���='���̼��ѷ�')OR (�Һз���='��Ų�ɾƮ')OR (�Һз���='BB/�Ŀ�̼�/����Ʈ��');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='C' AND ��з��ڵ�='16' or (�Һз���='����ī��') OR (�Һз���='����ƽ/�����̳�')OR (�Һз���='���۷���/ƾƮ')OR (�Һз���='�Ϲݳ���/�ɾ��')OR (�Һз���='��Ż�̿�ҵ���');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='C' AND ��з��ڵ�='16' or (�Һз���='������/����') OR (�Һз���='ǲ�ɾ��')OR (�Һз���='���/ȭ���')OR (�Һз���='����������')OR (�Һз���='����/����ų�');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='C' AND ��з��ڵ�='16' or (�Һз���='��Ǫ/������Ʈ') OR (�Һз���='Ʈ��Ʈ��Ʈ/��')OR (�Һз���='������')OR (�Һз���='��������')OR (�Һз���='����/��');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='C' AND ��з��ڵ�='16' or (�Һз���='���ν�') OR (�Һз���='������');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='C' AND ��з��ڵ�='16' or (�Һз���='�ٵ����') OR (�Һз���='�ٵ𺸽�')OR (�Һз���='�����ǰ')OR (�Һз���='�ٵ���ġ/��')OR (�Һз���='�ڵ����/�ռ�����')OR (�Һз���='�ڵ�μ�/ũ��');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='C' AND ��з��ڵ�='16' or (�Һз���='�ڵ�/ǲ�ɾƮ') OR (�Һз���='����������')OR (�Һз���='���̼�Ŭ����')OR (�Һз���='��Ų/���')OR (�Һз���='����/����ũ��')OR (�Һз���='��ũ����');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='C' AND ��з��ڵ�='16' or (�Һз���='���ƿ�ȭ��ǰ') OR (�Һз���='���ƿ뼤Ǫ/�ٵ����')OR (�Һз���='����/����ũ��')OR (�Һз���='���Ƹ���ǰ');
-----------------------------------------------

SELECT * FROM PRODCL WHERE "���޻�" = 'D' ORDER BY ��з��ڵ�;
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='D' AND ��з��ڵ�='1' or (�Һз���='�̽�Ʈ') OR (�Һз���='������/�μ�')OR (�Һз���='������/����')OR (�Һз���='�����ɾ�')OR (�Һз���='ũ��/��/����')OR (�Һз���='��Ų�ɾƮ');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='D' AND ��з��ڵ�='1' or (�Һз���='�´�/�����ͼ��ɾ�') OR (�Һз���='������Ŭ����')OR (�Һз���='�����뽺Ų�ɾ��')OR (�Һз���='������Ų�ɾƮ')OR (�Һз���='�����뼱ũ��/����ũ����')OR (�Һз���='���ƿ�ȭ��ǰ');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='D' AND ��з��ڵ�='1' or (�Һз���='������ũ��/�Ŀ��') OR (�Һз���='���ƿ뼤Ǫ/�ٵ����')OR (�Һз���='���Ƹ���ǰ');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='D' AND ��з��ڵ�='2' or (�Һз���='����/����ų�') OR (�Һз���='Ʈ��Ʈ��Ʈ/��')OR (�Һз���='������')OR (�Һз���='��������')OR (�Һз���='����/��')OR (�Һз���='���ν�')OR (�Һз���='������');
UPDATE PRODCL SET ����з�=null WHERE ���޻�='D' AND ��з��ڵ�='2' or (�Һз���='ġ��/ĩ�ּ�Ʈ') OR (�Һз���='������')OR (�Һз���='Ž��')OR (�Һз���='��Ƽ���̳�');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='D' AND ��з��ڵ�='2' or (�Һз���='�ٵ����') OR (�Һз���='�ٵ𺸽�')OR (�Һз���='�Կ���/������ǰ')OR (�Һз���='�ٵ��ɾƮ')OR (�Һз���='�ٵ𽽸���/������')OR (�Һз���='�����ǰ')OR (�Һз���='��������Ʈ');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='D' AND ��з��ڵ�='2' or (�Һз���='�ڵ����/�ռ�����') OR (�Һз���='�ڵ�μ�/ũ��')OR (�Һз���='ǲ�ɾ�')OR (�Һз���='ǲ�ɾ��');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='D' AND ��з��ڵ�='6' or (�Һз���='�����ɾ��') OR (�Һз���='�Ӵ���/�ֲ�Ǯ')OR (�Һз���='�⸧����');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='D' AND ��з��ڵ�='7' or (�Һз���='�������') OR (�Һз���='�������');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='D' AND ��з��ڵ�='8' or (�Һз���='���̼�����') OR (�Һз���='����ī��')OR (�Һз���='���̺�ο�')OR (�Һз���='���̶��̳�')OR (�Һз���='����/���̵�/���̶�����')OR (�Һз���='����ũ�����̽�/�����̸�')OR (�Һз���='����ũ����Ʈ');

UPDATE PRODCL 
SET ����з� = '������'
WHERE ����з� IS NULL AND (�ߺз��� LIKE 'S%' OR �ߺз��� LIKE '_��%' OR �ߺз��� LIKE '����' OR �ߺз���  LIKE '���' OR 
�ߺз��� LIKE '�ѷ�����' OR �ߺз��� LIKE '���Ͻ�����' OR �ߺз��� LIKE '�ѷ�����' OR �ߺз��� LIKE '�����ǰ'
OR �ߺз��� LIKE '�ｺ��ǰ' OR �ߺз��� LIKE '������' OR �ߺз��� LIKE '������%' OR �ߺз��� LIKE '��Ű'
OR �ߺз��� LIKE '������ǰ');

UPDATE PRODCL SET ����з� = '�Ƿ�' WHERE ���޻� ='B' AND ��з��ڵ�='70' AND ("�ߺз���"='����' OR �ߺз���='�尩');
UPDATE PRODCL SET ����з�='ȭ��ǰ' WHERE ���޻�='B' AND ��з��ڵ�='19' AND (�ߺз���='��Ÿ�ϸ�');

UPDATE prodcl set ����з�='������ǰ' WHERE ���޻�='A' AND ("�ߺз���"='��������' OR "�ߺз���"='��������'
OR "�ߺз���"='����/����' OR "�ߺз���"='�ֹ氡��' OR "�ߺз���"='���/��ǻ��');

UPDATE prodcl set ����з�='������ǰ' WHERE ���޻�='B' AND ("�ߺз���"='��Ÿ���ڿϱ�'
OR "�ߺз���"='�������ӱ�' OR "�ߺз���"='DVD' OR "�ߺз���"='��ġ�����' OR "�ߺз���"='�����' OR "�ߺз���"='��Ź��'
OR "�ߺз���"='�����' OR "�ߺз���"='Ȩ�þ���' OR "�ߺз���"='������' OR "�ߺз���"='����û����' OR "�ߺз���"='��ǳ��'
OR "�ߺз���"='������' OR "�ߺз���"='�����/����' OR "�ߺз���"='������' OR "�ߺз���"='���ͱ�' OR "�ߺз���"='��Ÿ�ֹ氡��'
OR "�ߺз���"='�ͼ���' OR "�ߺз���"='���' OR "�ߺз���"='��Ȱ��������' OR "�ߺз���"='������Ʈ' OR "�ߺз���"='������'
OR "�ߺз���"='�ֹ��������' OR "�ߺз���"='û�ұ�' OR "�ߺз���"='Ŀ�Ǹ���Ŀ/�ӽ�' OR "�ߺз���"='MP3/PMP' OR "�ߺз���"='PC'
OR "�ߺз���"='����鵵��' OR "�ߺз���"='���ھǱ�' OR "�ߺз���"='���ڻ���' OR "�ߺз���"='��ȭ��/�ѽ�' OR "�ߺз���"='��ǻ���ֺ����'
OR "�ߺз���"='����/�ǰ�����' OR "�ߺз���"='�ֹ氡��');
UPDATE prodcl set ����з�='������ǰ' WHERE ���޻�='B' AND "�ߺз���"='TV' AND ("�Һз���"='LED TV');
UPDATE prodcl set ����з�='������ǰ' WHERE ���޻�='B' AND "�ߺз���"='�ǰ�����' AND ("�Һз���"='��' OR "�Һз���"='ġ�ֻ�ձ�'
OR "�Һз���"='�ȸ�����' OR "�Һз���"='����ȸ���');
UPDATE prodcl set ����з�='������ǰ' WHERE ���޻�='B' AND "�ߺз���"='NAVI/�����н�' AND ("�Һз���"='�׺���̼�');
UPDATE prodcl set ����з�='������ǰ' WHERE ���޻�='B' AND "�ߺз���"='�ǰ������б��' AND ("�Һз���"='����ĩ��');
UPDATE prodcl set ����з�='������ǰ' WHERE ���޻�='B' AND "�ߺз���"='��Ÿ������' AND ("�Һз���"='������/����');
UPDATE prodcl set ����з�='������ǰ' WHERE ���޻�='B' AND "�ߺз���"='ī�޶�/ķ�ڴ�' AND ("�Һз���"='������/����' OR 
"�Һз���"='��Ÿ ī�޶�');
UPDATE prodcl set ����з�='������ǰ' WHERE ���޻�='B' AND "�ߺз���"='������ǰ' AND ("�Һз���"='�����');
UPDATE prodcl set ����з�='������ǰ' WHERE ���޻�='C' AND ��з��ڵ�='17' AND "�ߺз���"='��������' AND ("�Һз���"='��ǳ��'
OR �Һз���='����' OR �Һз���='��ǳ��' OR �Һз���='�������' OR �Һз���='�����' OR �Һз���='�����Ʈ' OR �Һз���='�¼���Ʈ'
OR �Һз���='��Ÿ���氡��' OR �Һз���='��ǳ��' OR �Һз���='������' OR �Һз���='������' OR �Һз���='����û����' OR �Һз���='�ڵ���û�ұ�'
OR �Һз���='��Ÿû�ұ�' OR �Һз���='��ȭ��' OR �Һз���='�ٸ���' OR �Һз���='������̾�' OR �Һз���='����' OR �Һз���='��Ÿ�̹̿밡��'
OR �Һз���='������' OR �Һз���='����/���ڷ�����' OR �Һз���='�δ���/����������' OR �Һз���='����' OR �Һз���='����' OR �Һз���='�佺��/������'
OR �Һз���='�䱸��Ʈ/û����������' OR �Һз���='��Ÿ�ֹ氡��' OR �Һз���='������ġ' OR �Һз���='Ű����' OR �Һз���='���콺' OR �Һз���='����Ŀ'
OR �Һз���='������' OR �Һз���='�ǰ�����ũ' OR �Һз���='�����/���ױ�' OR �Һз���='ü�߰�/�����');

UPDATE prodcl set ����з�=NULL WHERE "���޻�"='B' AND "�ߺз���"='���ͱ�' AND "�Һз���"='��Ÿ';
UPDATE prodcl set ����з�=NULL WHERE "���޻�"='B' AND "�ߺз���"='��Ÿ�ֹ氡��' AND "�Һз���"='��Ÿ�Ҹ�ǰ';
UPDATE prodcl set ����з�=NULL WHERE "���޻�"='B' AND "�ߺз���"='û�ұ�' AND �Һз���='û�ұ��ǰ';
UPDATE prodcl set ����з�=NULL WHERE "���޻�"='B' AND "�ߺз���"='��ǻ���ֺ����' AND �Һз���='��ũ';
UPDATE prodcl set ����з�=NULL WHERE "���޻�"='B' AND "�ߺз���"='��ǻ���ֺ����' AND �Һз���='��Ÿ�Ҹ�ǰ';
UPDATE prodcl set ����з�=NULL WHERE "���޻�"='B' AND "�ߺз���"='��ǻ���ֺ����' AND �Һз���='��ǻ�ͼ�ǰ';
SAVEPOINT S2;


--�� �Ǽ��縮 
--A �Ǽ��縮 
SELECT * FROM PRODCL WHERE "���޻�" = 'A' ORDER BY ��з��ڵ�;
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE ���޻�='A' AND �ߺз��ڵ�='0202'; 
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE ���޻�='A' AND �ߺз��ڵ�='0204';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE ���޻�='A' AND �ߺз��ڵ�='0205';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE ���޻�='A' AND �ߺз��ڵ�='0206';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE ���޻�='A' AND �ߺз��ڵ�='0801';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE �Һз��ڵ�='A040240' OR �Һз��ڵ�='A060105' OR �Һз��ڵ�='A060111';

UPDATE PRODCL SET ����з�='�Ƿ�' WHERE �Һз��ڵ�='A020609' OR �Һз��ڵ�='A080103' OR �Һз��ڵ�='A080114' OR �Һз��ڵ�='A080115' OR �Һз��ڵ�= 'A060102'  OR �Һз��ڵ�= 'A060105'  OR �Һз��ڵ�= 'A060111';
UPDATE PRODCL SET ����з�=NULL WHERE �Һз��ڵ�='A020606'  OR �Һз��ڵ�='A080101' OR �Һз��ڵ�='A080104' OR �Һз��ڵ�= 'A080110' OR �Һз��ڵ�='A080111' OR �Һз��ڵ�='A080112' OR �Һз��ڵ�='A080112' OR �Һз��ڵ�='A080113';
UPDATE PRODCL SET ����з�=NULL WHERE �Һз��ڵ�='A080121'  OR �Һз��ڵ�='A080122' OR �Һз��ڵ�='A080123' OR �Һз��ڵ�= 'A080124' OR �Һз��ڵ�='A080125';

--B �Ǽ��縮 
SELECT * FROM PRODCL WHERE "���޻�" = 'B' ORDER BY ��з��ڵ�;
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE �Һз��ڵ�='B290201' OR �Һз��ڵ�='A060105' OR �Һз��ڵ�='A060111' OR �Һз��ڵ�='B360504' OR �Һз��ڵ�='B360505' OR �Һз��ڵ�='B451505';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE �Һз��ڵ�='B451801' OR �Һз��ڵ�='B451802' OR �Һз��ڵ�='B451803' OR �Һз��ڵ�='B450101' OR �Һз��ڵ�='B450102' OR �Һз��ڵ�='B450103' OR �Һз��ڵ�='B450104' OR �Һз��ڵ�='B450105';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE �Һз��ڵ�='B450201' OR �Һз��ڵ�='B450202' OR �Һз��ڵ�='B450205' OR �Һз��ڵ�='B450206'  OR �Һз��ڵ�='B700301' OR �Һз��ڵ�='B710203';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE ���޻�='B' AND �ߺз��ڵ�='4503';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE ���޻�='B' AND �ߺз��ڵ�='4504';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE ���޻�='B' AND �ߺз��ڵ�='4505';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE ���޻�='B' AND �ߺз��ڵ�='4507';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE ���޻�='B' AND �ߺз��ڵ�='4508';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE ���޻�='B' AND �ߺз��ڵ�='4509';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE ���޻�='B' AND �ߺз��ڵ�='4510';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE ���޻�='B' AND �ߺз��ڵ�='4511';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE ���޻�='B' AND �ߺз��ڵ�='4512';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE ���޻�='B' AND �ߺз��ڵ�='7001';
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE ���޻�='B' AND �ߺз��ڵ�='7002';

UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='5002';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='5003';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='5004';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='5005';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='6801';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='6802';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='6803';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='6804';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='6805';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='6806';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='6808';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='6901';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='6902';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='6903';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='6904';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='B' AND �ߺз��ڵ�='7004';
UPDATE PRODCL SET ����з�='�Ƿ�' WHERE �Һз��ڵ�='B510306' OR �Һз��ڵ�='B510304' OR �Һз��ڵ�='B080114' OR �Һз��ڵ�='B080115' OR �Һз��ڵ�= 'B060102'  OR �Һз��ڵ�= 'B060105'  OR �Һз��ڵ�= 'B060111';
UPDATE PRODCL SET ����з�=NULL WHERE �Һз��ڵ�='B450301'  OR �Һз��ڵ�='B450306' OR �Һз��ڵ�='B450307' OR �Һз��ڵ�= 'B450308' OR �Һз��ڵ�='B450309' OR �Һз��ڵ�='B450311' OR �Һз��ڵ�='B450701';

--C �Ǽ��縮
SELECT * FROM PRODCL WHERE "���޻�" = 'C' ORDER BY ��з��ڵ�;
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE �Һз��ڵ�='C170422' OR �Һз��ڵ�='C170423' OR �Һз��ڵ�='C170435' OR �Һз��ڵ�='B360504' OR �Һз��ڵ�='B360505' OR �Һз��ڵ�='B451505';

--D �Ǽ��縮
SELECT * FROM PRODCL WHERE "���޻�" = 'D' ORDER BY ��з��ڵ�;
UPDATE PRODCL SET ����з�='�Ǽ��縮' WHERE �Һз��ڵ�='C170422' OR �Һз��ڵ�='C170423' OR �Һз��ڵ�='C170435' OR �Һз��ڵ�='B360504' OR �Һз��ڵ�='B360505' OR �Һз��ڵ�='B451505';

UPDATE PRODCL SET ����з�='�Ƿ�' WHERE ���޻�='D' AND �ߺз��ڵ�='0602';

SELECT * FROM PRODCL ORDER BY ���޻�, ��з��ڵ�, �ߺз��ڵ�, �Һз��ڵ�;
SELECT COUNT(*) FROM PRODCL WHERE ����з� IS NULL;

COMMIT;