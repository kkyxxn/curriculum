-- ESCAPE
-- LIKE �������� '%'�� '_'�� �� ���ڸ� �˻��ϱ� ���ؼ��� ESCAPE�� ����ؾ� �Ѵ�.
SELECT * FROM employees where job_id like '%\_A%' ESCAPE '\';
SELECT * FROM employees WHERE job_id like '%#_A%' escape '#';

--IN : OR ��� ���
SELECT * FROM employees where manager_id=101 or manager_id=102 or manager_id=103;
select * from employees where manager_id in(101,102,103);

--BETWEEN a AND b : ���� -> ���� A ���� ���� B ������ ���� ��ȸ
select * from employees where manager_id =101 and manager_id =103;
SELECT * FROM employees WHERE manager_id BETWEEN 101 AND 103;

--IS NULL / IS NOT NULL
SELECT * FROM employees WHERE commission_pct IS NULL;
SELECT * FROM employees WHERE commission_pct IS NOT NULL;

--[�ֿ� �Լ�]
--MOD
select * from employees where mod(employee_id,2)=1; -- Ȧ���� ����� id�� ���
select mod(10,3) from dual; -- dual table�� ����Ŭ���� �����ϴ� �ӽ� ���̺�

--ROUND()
SELECT ROUND(355.95555) FROM dual;
SELECT ROUND(355.95555,0) FROM dual;
SELECT ROUND(355.95555,2) FROM dual;
SELECT ROUND(355.95555,-1) FROM dual;

--TRUNC() �ַ� �Ҽ��� ���� �� ��¥�� �ð��� ���� �� ����Ѵ�.
--  TRUNC("��", "�ɼ�")
SELECT TRUNC(45.5555,1)FROM dual;
select * from employees;
SELECT last_name, TRUNC(salary/12,2) FROM employees;

--��¥ ���� �Լ�
SELECT SYSDATE FROM dual; -- ���� ��¥ ���
select sysdate+ 1 from dual;

select * from employees;
SELECT EMPLOYEE_ID ,last_name, TRUNC((SYSDATE - hire_date)/365) as "�ټӿ���" FROM employees;
SELECT last_name, hire_date, ADD_MONTHS(hire_date, 6) FROM employees;

-- LAST_DAY() ���� ������ ��¥�� �����ش�. 
SELECT LAST_DAY(SYSDATE) FROM DUAL;

--NEXT_DAY('��������', 'ã������')
SELECT hire_date, NEXT_DAY(hire_date,'��') AS "ã�³�¥" FROM employees;
SELECT sysdate, NEXT_DAY(sysdate, '��') AS "ã�³�¥" FROM dual; -- ���� ��¥���� ���� ��¥ ���ϱ�

--MONTHS_BETWEEN(��¥, ��¥) �� ��¥ ������ ���� �� ���ϱ�
SELECT last_name, sysdate, hire_date, trunc(months_between(sysdate,hire_date)) from employees;

--����ȯ �Լ�
-- number character date
-- to_date() ���ڿ��� �Ǵ� �÷��� �����͸� ��¥�������� ��ȯ
-- to_number, to_char

--��¥ ����
--YYYY/MM/DD -> 1989/11/24
--YYYY-MM-DD HH24:MI:SS
SELECT last_name, trunc(months_between('2012/12/31',hire_date)) FROM employees;
SELECT trunc(sysdate - to_date('2014/01/01')) from dual;

--Q. employees ���̺� �ִ� ������(���, �̸� ��������)�� ���Ͽ� ����������� �ټӿ����� ���ϼ���
SELECT employee_id, last_name, TRUNC((sysdate- hire_date)/365) as "�ټӿ���" FROM employees;

select to_date('20210101'), to_char(to_date('20210101'), 'Month DD YYYY','NLS_DATE_LANGUAGE=ENGLISH') format1 FROM dual;

select to_char(sysdate, 'YY/MM/DD HH24:MI:SS') from dual; -- 22/02/28 21:37:31
select to_char(sysdate, 'yy/mm/dd') from dual; -- 22/02/28
select to_char(sysdate, 'YYYY-MM-DD') from dual; -- 2022-02-28
select to_char(sysdate, 'hh24:mi:ss') from dual; -- 21:39:36
select to_char(sysdate, 'day') from dual; -- ������

--TO_CHAR
--9 ���ڸ��� ����ǥ��
--0 �պκ��� 0���� ǥ��
--$ �޷� ��ȣ�� �տ� ǥ��
--. �Ҽ����� ǥ��
--, Ư�� ��ġ�� ǥ��
--MI �����ʿ� ? ��ȣ ǥ��
--PR �������� <>���� ǥ��
--EEEE ������ ǥ��
--B ������ 0���� ǥ��
--L ������ȭ
select salary, to_char(salary,'0099999') from employees;
select to_char(-salary, '999999PR') from employees;
SELECT TO_CHAR(1111, '99.99EEEE') FROM dual;
SELECT TO_CHAR(1111, 'B9999.99') FROM dual;
SELECT TO_CHAR(1111,'L99999') FROM dual; 

--WIDTH_BUCKET(�÷�,�ּҰ�,�ִ밪,���� ��)
SELECT WIDTH_BUCKET(92,0,100,10) from dual;
SELECT WIDTH_BUCKET(100,0,100,10) FROM dual;
SELECT department_id, last_name, salary, WIDTH_BUCKET(salary,0,20000,5) FROM employees WHERE department_id=50;

--[����] employees ���̺��� employee_id, last_name, salary, hire_date �� �Ի��� �������� �ټӳ���� ����ؼ� �Ʒ������� �߰��� �� ���
--2001�� 1�� 1�� â���Ͽ� ����(2020�� 12�� 31��)���� 20�Ⱓ ��Ǿ�� ȸ��� ������ �ټӿ����� ���� 30������� ������ ��޿�
--���� 1000���� bonus�� ����(bonus ���� �������� ����)
SELECT employee_id, last_name, salary, hire_date,
TRUNC(((to_date('20201231') - hire_date)/365)) as "�ټӿ���",
(WIDTH_BUCKET(TRUNC(((to_date('20.12.31') - hire_date)/365)),0,20,30)) as "���ʽ����",
(WIDTH_BUCKET(TRUNC(((to_date('20.12.31') - hire_date)/365)),0,20,30))*1000 as bonus
FROM employees
ORDER BY bonus DESC;

--�����Լ�
select upper('hello world') from dual;
select lower('HELLO WORLD') from dual;
select last_name, salary from employees where LOWER(last_name) ='seo';

--INITCAP�Լ��� �Է� ���ڿ� �߿��� �� �ܾ��� ù ���ڸ� �빮�ڷ� �������� �ҹ��ڷ� ��ȯ�Ͽ� ��ȯ�Ѵ�.
select initcap(job_id) from employees;
--������ ���� ���� ����
SELECT job_id, LENGTH(job_id) FROM employees;

--INSTR('���ڿ�', 'Ÿ�ٹ��ڿ�', ������ġ, Ƚ��)) -> �߰����� ���ϸ� 0�� ��ȯ��

-- 1) 3��°���� �����ϴ� ������ ����
-- 2) 'o'���ڸ� ã�� ���� ã������ �ι�° 'o'�� ã��
-- 3) 2���� 'o'�� �ε��� ���� ��ȯ
select instr('Hello World','o',3,2) from  dual;
select INSTR('ABBCCDXYZCDCD', 'D') from dual;

--SUBSTR([����], ������ġ[NUMBER], �ڸ��� ���� ����[NUMBER])
SELECT SUBSTR('Hello! World',3,4) FROM dual;
SELECT SUBSTR('Hello sexyWorld',-5,3) FROM dual;

--' ' STR���� ���� �ִ� ���� ��ġ ã��
SELECT INSTR('���ع��� ��λ��� ������ �⵵��', ' ') FROM dual; 
--STR�� 7° ���ں��� ���Ⱑ �ִ� ���� ��ġ ã��
SELECT INSTR('���ع��� ��λ��� ������ �⵵��', ' ', 7)FROM dual;
--STR�� 7° ���ں��� 2��° ���Ⱑ �ִ� ���� ã��
SELECT INSTR('���ع��� ��λ��� ������ �⵵��', ' ', 7,2) FROM dual;
--���� 2��° ���ڿ����� ���ڿ� �ڸ���
SELECT SUBSTR('���ع��� ��λ��� ������ �⵵��', 0, INSTR('���ع��� ��λ��� ������ �⵵��', ' ', 1, 2)) FROM dual; 
SELECT INSTR('���ع��� ��λ��� ������ �⵵��', ' ', 1, 2) FROM dual;

--�������� 20�ڸ��� ��ä���� ������ #�ֱ�
SELECT LPAD('Hello World',20,'#') FROM dual;
--���������� 20�ڸ��� ��ä���� ������ #�ֱ�
SELECT RPAD('Hello World',20,'#') FROM dual;

--���� ���� 'a' ����
SELECT LTRIM('aaaHello Worldaaa','a') FROM dual;
--������ ���� 'a' ����
SELECT RTRIM('aaaHello Worldaaa','a') FROM dual;

--���� ���� ����
select ltrim('   Hello World   ') from dual;
--������ ���� ����
SELECT RTRIM('   Hello World   ') FROM dual;
--���� ���� ����
SELECT TRIM('   Hello World   ') FROM dual; 

--��Ÿ�Լ�
-- nvl null���� ġȯ���ִ� �Լ� NVL(�÷�,NULL�ϰ�� ��ȯ��) 
-- NVL2('�÷�','NULL�� �ƴ� ��� ��ȯ��','NULL�ϰ�� ��ȯ��')
SELECT salary, commission_pct, salary*12*NVL(commission_pct,0) FROM employees;


SELECT last_name, department_id,
CASE WHEN department_id=90 THEN '�濵������'
WHEN department_id = 60 THEN '���α׷���'
WHEN department_id=100 THEN '�λ��'
END AS �Ҽ�
FROM employees;


--�������Լ���(�μ���) OVER ([PARTITION BY �÷�] [ORDER BY �� ASC|DESC] [��������])
-- 1) �������Լ����� RANK(), MAX(), FIRST_VALUE() ���� �ֽ��ϴ�. ���� ����Դϴ�.
-- 2) OVER�� �������Լ� �ٷ� �ڿ� ����ϰ� �ɼǵ��� �� �ڷ� �����մϴ�. �ʼ� Ű�����Դϴ�.
-- 3) PARTITION BY �÷��� ���� �ɼ��Դϴ�.
-- 4) ORDER BY �÷��� �ش� �÷��� ���ؼ� ������ �մϴ�. ���� �ɼ��Դϴ�.


--�м��Լ� : ���� ���� ������ ������ ���� ����� return �� �� ������ ó�� ����� �Ǵ� ���� ������ window��� ��Ī
--FIRST_VALUE() OVER() �׷��� ù��° ���� ���Ѵ�.
--����Ŭ�� ���� ������� ù��° ���� ���� �����ö��� FIRST_VALUE 
--������ ���� ���� �����ö��� LAST_VALUE 
--OVER(ORDER BY �÷���)�� ����� ��� ���� ���� ������ ������� ������ �÷����� �����Ͽ� ù��° ���� ���� ǥ���Ѵ�. 
select first_name as "�̸�", salary as "����",
first_value(salary) over(order by salary desc) as "�ְ���"
from employees;

--Q. 3�� ���� ������ �� ù��° ��
SELECT first_name �̸�, salary ����,
FIRST_VALUE(salary) OVER(ORDER BY salary DESC ROWS 3 PRECEDING) �ְ���
FROM employees;

--Q. 3�� ���� �������� ��������
select first_name �̸�, salary ����,
first_value(salary) over(order by salary asc rows 3 preceding) ��������
from employees;

select first_name �̸�, salary ����,
last_value(salary) over(order by salary asc rows 3 preceding) ��������
from employees;

select first_name �̸�, salary ����,
last_value(salary) over(order by salary desc rows 3 preceding) ��������
from employees;

--Q. ���Ʒ� ���� 2�� ���� �� ��������
SELECT first_name �̸�, salary ����,
LAST_VALUE(salary) OVER(ORDER BY salary DESC ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) ��������
FROM employees;


select * from employees;
--[����] employees ���̺��� department_id=50�� ������ ������ �������� �����Ͽ� ���� ī��带 ����ϼ���.
select department_id, last_name, salary,  count(*) over(order by salary desc)
from employees
where department_id=50;

--[����] employees ���̺��� department_id�� �������� �������� �����ϰ� department_id �׷� ������ ���� ���� �հ踦 ����ϼ���.
SELECT department_id, last_name, salary, SUM(salary) OVER(PARTITION BY department_id 
ORDER BY department_id asc) FROM employees;


--[����] employees ���̺��� first_name, department_id(�μ�)�� ���� ���������� ����ϼ���.
select first_name, department_id as �μ�, salary ����,
rank() over(partition by department_id order by salary desc) �μ���������
from employees;


SELECT first_name, department_id �μ�, salary ����,
RANK() OVER(ORDER BY salary DESC) ��������
FROM employees;

--dml
DESC BOOK;
SELECT * FROM BOOK;
SELECT BOOKNAME,PRICE FROM BOOK;
SELECT PUBLISHER FROM BOOK;

SELECT DISTINCT PUBLISHER FROM BOOK; --�ߺ� ���� distinct

-- book ���̺�� �Ʒ��� ���ǹ��� ����
--Q. ������ 10000�� ������ book�� ��ü �÷� ���
SELECT * 
FROM BOOK
WHERE PRICE < 10000;

--Q. ������ 10000�� �̻� 20000�� ������ ������ �˻��ϼ���.
select *
from book
where price >= 10000 and price <=20000;

--Q. ���ǻ簡 �½�����, Ȥ�� ���ѹ̵���� ������ �˻��ϼ���.
select *
from book
where publisher= '�½�����' or publisher= '���ѹ̵��';

select *
from book
where publisher in('�½�����','���ѹ̵��');

--Q. ���ǻ簡 �½�����, Ȥ�� ���ѹ̵� �ƴ� ������ �˻��ϼ���.
select *
from book
where publisher not in ('�½�����', '���ѹ̵��');

--Q. �����̸��� �౸�� ���Ե� ���ǻ縦 �˻��ϼ���.
select *
from book
where bookname like '%�౸%';

select publisher
from book
where bookname like '%�౸%';

--[����] �����̸��� ���� �� ��° ��ġ�� ����� ���ڿ��� ���� ������ �˻��ϼ���.
-- _�� Ư�� ��ġ�� �Ѱ��� ���ڿ� ��ġ
-- %�� 0�� �̻��� ���ڿ� ��ġ
SELECT BOOKNAME,PUBLISHER
FROM BOOK
WHERE BOOKNAME LIKE'_��%';

--[����] �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��ϼ���.
select *
from book
where bookname like '%�౸%' and price >=20000;

--Q. ������ ���ݼ����� �˻��ϰ� ������ ������ �̸������� �˻��ϼ���.
select *
from book
order by price, publisher;

--Q. ������ ������ ������������ �˻��ϰ� ���� ������ ���ٸ� ���ǻ��� ������������ ����ϼ���.
-- desc �������� , asc ��������(�⺻)
select *
from book
order by price desc, publisher;


SELECT * FROM ORDERS; -- orders ���̺�� �Ʒ��� ���ǹ��� ����
--Q.��ü �ֹ��ݾ��� ���ϼ���.
SELECT SUM(SALEPRICE)
FROM ORDERS;

--Q.CUSTID �� 2���� ���� �ֹ��� ������ ���Ǹž��� ���ϼ���.
select sum(saleprice) as "���Ǹž�"
from orders
where custid =2;

--Q.orders ���̺��� �� �Ǹž�, ���, �ּҰ���, �ִ밡���� ���ϼ���.
select sum(saleprice) as total,
avg(saleprice) as average,
min(saleprice) as minimum,
max(saleprice) as maximum
from orders;

--Q.orders table�� ��� row�� ���� ����.
SELECT COUNT(*) 
FROM ORDERS;

--Q.orders table�� not null�� row�� ���� ����.
select count(custid)
from orders;

--Q.orders table�� �ߺ��� �����ϰ� not null�� row�� ���� ����.
select count(distinct custid)
from orders;

--Q. CUSTID�� ���������� ���Ǹž��� ����ϼ���.
select custid, count(*) as ��������, sum(saleprice) as ���Ǹž�
from orders
group by custid;


SELECT * FROM ORDERS;
--Q. ������ 8000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���ϼ���. �� �α� �̻� ������ ���� ������
select custid, count(custid) as "���� �� �ֹ�����" 
from orders
where saleprice >=8000
group by custid 
having count(custid) >=2;

select count(distinct custid)
from orders;

SELECT CUSTID, COUNT(*) AS ��������
FROM ORDERS
WHERE SALEPRICE >= 8000
GROUP BY CUSTID
HAVING COUNT(*) >= 2;


SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
SELECT * FROM BOOK;
-- �� �� �̻� ���̺��� SQL ���� -> custid�� ��ø�� -> join Ȱ��
-- ���� ���� �ֹ��� ���� �����͸� CUSTID���� �����Ͽ� ���̼���.
SELECT *
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID
ORDER BY CUSTOMER.CUSTID;

--Q. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ� ���̸����� �����ϼ���.
select c.name, sum(o.saleprice)
from customer c, orders o
where c.custid = o.custid
group by c.name
order by c.name;

--Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���ϼ���.
select c.name, b.bookname
from customer c, book b, orders o
where c.custid = o.custid and o.bookid= b.bookid;

--[����] ������ 20,000�� ������ �ֹ��� ���� �̸��� ������ �̸��� ���ϼ���.
select c.name, b.bookname, o.saleprice
from customer c, orders o, book b
where c.custid = o.custid and o.bookid = b.bookid and b.price =20000;


--left outer join : ���� ���̺� ���� ���� �� ������ ���̺��� ���ǿ� ���� �ʾƵ� ����
-- �ϴ� ���� ���̺� �ִ� ���� �� ���� -> �� �� ������ ���̺��� ��ġ���� �ʴ°� nulló���Ͽ� ��µ�

--right outer join : ������ ���̺� ���� ���� �� ���� ���̺��� ���ǿ� ���� �ʾƵ� ���� 
-- �ϴ� ������ ���̺� �ִ� ���� �� ���� -> �� �� ���� ���̺��� ��ġ���� �ʴ°� nulló���Ͽ� ��µ�

--full outer join : ���� ���̺� ���� ���� �� �ٸ� �� ���̺��� ���ǿ� ���� �ʾƵ� ����

--[����] ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���ϼ���.
--outer join ���������� �������� ���ϴ��� �ش� ���� ��Ÿ��

select c.name, o.saleprice
from customer c, orders o
where c.custid = o.custid(+); -- name�÷��̶� saleprice�÷��̶� ������ left outer join

select name, saleprice
from customer left outer join orders
on customer.custid = orders.custid;

select c.name, o.saleprice
from customer c left outer join orders o
on c.custid = o.custid;

select name, saleprice
from customer c left outer join orders o
using(custid)

-- �������� > ��ø���� (where���� ��ġ��)
--[����] ���� ��� ������ �̸� ������ ����ϼ���.
select bookname, price
from book
where price = (select max(price) from book);

--[����] ������ ������ ���� �ִ� ���� �̸��� �˻��ϼ���.
select name,custid
from customer 
where custid in (select custid from orders)
order by custid desc;

--[����] ���ѹ̵��� ������ ������ ������ ���� �̸��� ����ϼ���.
select name
from customer
where custid in (select custid 
                    from orders
                    where bookid in(select bookid 
                                        from book
                                        where publisher='���ѹ̵��'));
--1) book table���� ���ǻ簡 ���ѹ̵���� bookid�� ���ϰ�
--2) order table���� �� bookid�� ������ custid�� ���ϰ�
--3) customer table���� custid�� ������ name�� ���Ѵ�

--��� �μ����� 
--Q. ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.(��������)
-- ����� ���� �� ��պ��� ��� ������ ���ؾ���
select b1.bookname
from book b1
where b1.price > (select avg(b2.price)
                    from book b2
                    where b2.publisher = b1.publisher);


--Q. �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
select name, address
from customer
where custid in(select custid from orders); --�ֹ��� �ִ��� -> �ֹ����̺��� custid�� select�Ǵ���

--Q.Customer ���̺��� ����ȣ�� 5�� ���� �ּҸ� �����ѹα� �λꡯ���� �����Ͻÿ�.
update customer
set address = '���ѹα� �λ�'
where custid = 5;

--Q.Customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.
update customer
set address = (select address 
                    from customer
                    where name='�迬��')
where name = '�ڼ���';
SELECT * FROM customer;

--Q.Customer ���̺��� ����ȣ�� 5�� ���� ������ �� ����� Ȯ���Ͻÿ�.
delete 
from customer
where custid =5;


select abs(-78), abs(+78) from dual;
select round(4.875,1) from dual;
--Q.���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.
select custid ����ȣ ,round(avg(saleprice),-2) as "��� �ֹ� �ݾ�"
from orders
group by custid


select * from book;

--Q.���� ���� ���߱����� ���Ե� ������ ������ �������̺��� �������� �����ϼ���.
update book
set price = (select price from book where bookname='���� ���̺�')
where bookname like '�߱�%';
rollback;

--Q.���� ���� ���߱����� ���Ե� ������ ���󱸡��� ������ �� ���� ���, ������ ���̽ÿ�.
select bookid, replace(bookname, '�߱�','��') bookname, price
from book;

--UPDATE ���̺�� SET �÷��� = REPLACE(�÷��� ,'������ ����','������ ����') 
update book 
set bookname = replace(bookname, '�߱�','��')
where publisher like '�̻�%';


--Q.���½����������� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.
select bookname ���� , length(bookname) as "������ ���� ��" , lengthb(bookname) as "����Ʈ ��"
from book
where publisher = '�½�����';

--Q.���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
select substr(name,1,1) as "��" from customer; 

select substr(name,1,1) as "��" , count(*) �ο���
from customer
group by substr(name,1,1)
order by "��";


--Q. ���缭���� �ֹ��Ϸ� ���� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���ϼ���.
 select orderdate as �ֹ�����,orderdate+10 as "Ȯ������"
 from orders;
 
--Q.DBMS ������ ������ ���� ��¥�� �ð�, ������ Ȯ���Ͻÿ�. 
select sysdate from dual;
select sysdate, to_char(sysdate, 'yyyy/MM/DD dy hh24:mi:ss') as"���糯¥�� to_char�� ��ȯ"
FROM dual;

--Q.���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�.
select orderid "������ �ֹ���ȣ", to_char(orderdate, 'yyyy-mm-dd day') �ֹ���, custid ����ȣ, bookid ������ȣ
from orders
where orderdate ='20/07/07';

--Q.����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̽ÿ�.
select rownum ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ
from customer
where rownum <=2;

--Q.��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
select avg(saleprice) from orders; --11800

select orderid �ֹ���ȣ, saleprice �ֹ��ݾ�
from orders
where saleprice <= (select avg(saleprice) from orders);

--Q.��� �ֹ��ݾ� �̻��� �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
--where���� �μ����� (��ø����)
--- ����� ������Ű�� ���� ����. ��� Ȥ�� ���� ����
-- WHERE���� ���� �����͸� �����ϴ� ���� Ȥ�� ����� ���� ����. �׷��� ��ø���Ǹ� ���� �μ����Ƕ�� ��

select orderid �ֹ���ȣ, saleprice �ֹ��ݾ�
from orders
where saleprice >= (select avg(saleprice) from orders);

--Q.�� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ���̽ÿ�.
select * from orders;
select orderid, custid, saleprice
from orders b1
where b1.saleprice > (select avg(b2.saleprice)
from orders b2 where b2.custid = b1.custid);


--Q.�����ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
select sum(saleprice) as "���Ǹž�"
from orders o, customer c
where o.custid = c.custid and c.address like '���ѹα�%';

select sum(saleprice) ���Ǹž�
from orders
where custid in(select custid from customer where address like '%���ѹα�%');


--Q.3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
select orderid �ֹ���ȣ, saleprice �ֹ��ݾ�, custid
from orders
where custid = 3 ;

select orderid �ֹ���ȣ, saleprice �ֹ��ݾ�
from orders
where saleprice > (select max(saleprice) from orders where custid ='3');


--[����]EXISTS �����ڸ� ����Ͽ� �����ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
-- EXISTS : ���� �����ϴ��� Ȯ�� �� TRUE, FALSE�� ��ȯ
select sum(saleprice) 
from orders o
where exists (select * from customer c  where address like '%���ѹα�%' and o.custid=c.custid);

-- IN
select sum(saleprice)
from orders
where custid in(select custid from customer where address like '%���ѹα�%');

-- JOIN ON
select sum(saleprice)
from customer c join orders o on o.custid=c.custid
where address like '%���ѹα�%'; 


--[����]���缭���� ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���)
-- select���� �μ�����, ��Į�� �μ����� 
select (select name from customer c where o.custid = c.custid) as ���̸�,
sum(saleprice) ���Ǹž� 
from orders o
group by o.custid;

-- join
select c.custid, c.name, sum(o.saleprice)
from orders o, customer c
where o.custid= c.custid
group by c.custid, c.name
order by sum(o.saleprice) desc;

--FROM JOIN ON
select c.custid, c.name, sum(o.saleprice)
from orders o join customer c on c.custid=o.custid -- from A JOIN B ON A = B
group by c.custid, c.name -- csutid�� �̸����� �׷���
order by custid desc; --custid ��������


--[����] ����ȣ�� 2 ������ ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���)
SELECT c.name, SUM(o.saleprice) total
FROM(SELECT custid, name
FROM customer
WHERE custid<=2) c,
orders o
WHERE c.custid = o.custid
GROUP BY c.name;

-- error
SELECT c.name
FROM customer c, orders o
WHERE c.custid = o.custid AND custid <=2
GROUP BY c.name;


--Q.�ּҿ� �����ѹα����� �����ϴ� ����� ������ �並 ����� ��ȸ�Ͻÿ�. ���� �̸��� vw_Customer�� �����Ͻÿ�.

create view vw_Customer
as select *
from customer
where address like '%���ѹα�%';

select * from vw_Customer;
SELECT * FROM customer;


--[����]Orders ���̺��� ���̸��� �����̸��� �ٷ� Ȯ���� �� �ִ� �並 ������ ��, 
-- 3�� ���̺� join
create view vw_Orders(orderid,custid,name,bookid,bookname,saleprice,orderdate)
as select o.orderid, o.custid, c.name, o.bookid, b.bookname, o.saleprice, o.orderdate
from orders o, customer c, book b
where o.custid = c.custid and o.bookid= b.bookid;

--���迬�ơ� ���� ������ ������ �ֹ���ȣ, ����ȣ, �����̸�, �ֹ����� ���̽ÿ�.
select * from vw_Orders;
select orderid, custid, bookname, saleprice
from vw_Orders
where name ='�迬��';


--[����]vw_Customer�� �̱��� �ּҷ� ���� ������ �����ϼ���.
select * from vw_Customer;

--�並 �����ϰų� �����ϰ��� �� �� ����ϴ� ��ɾ�
create or replace view vw_Customer
as select *
from customer
where address like '%�̱�%';

--[����]�ռ� ������ �� vw_Customer�� �����Ͻÿ�.
DROP VIEW vw_Customer;

--[HR Tables]

SELECT * FROM employees;

--[����]EMPLOYEES ���̺��� commission_pct ��  Null�� ������  ����ϼ���.
SELECT COUNT(*)
FROM employees
WHERE commission_pct is null;

--[����]EMPLOYEES ���̺��� employee_id�� Ȧ���� �͸� ����ϼ���.
select *
from employees
where mod(employee_id,2)=1;

--[����]job_id�� ���� ���̸� ���ϼ���.
select job_id, length(job_id) from employees;

--[����]job_id ���� �����հ� ������� �ְ��� �������� ���
select job_id, sum(salary) as �����հ�, avg(salary) �������, max(salary) as "�ְ���" ,min(salary) ��������
from employees
group by job_id;


--��¥ ���� �Լ�
--TRUNC �Լ��� �ַ� �Ҽ��� ���� �� ��¥�� �ð��� ���� �� ����Ѵ�.
-- �Լ�  :  TRUNC("��", "�ɼ�")
select sysdate from dual; -- ���� ��¥
select * from employees;
select last_name, hire_date, TRUNC((SYSDATE - hire_date)/365,0) as " �� �� �� �� " from employees;

--Ư�� ���� ���� ���� ��¥�� ���ϱ�
select last_name, hire_date, add_months(hire_date, 6) from employees;


--�ش� ��¥�� ���� ���� ����(last_day)�� ��ȯ�ϴ� �Լ�
select last_day(sysdate) from dual;


--Q. ���� �� ����(hire_data ����)
select last_name, hire_date, last_day(add_months(hire_date,1)) as "�Ի� ������ ����"
from employees;


--�ش� ��¥�� �������� ��õ� ���Ͽ� �ش��ϴ� ������ ��¥(next_day)�� ��ȯ
select hire_date, next_day(hire_date,'��') from employees;


--months_between() ��¥�� ��¥ ������ ���� ���� ���ϱ�
select last_name, trunc(months_between(sysdate, hire_date),0) �ټӿ���1, ROUND(MONTHS_BETWEEN(sysdate,hire_date),0)�ټӿ���2 FROM employees;
from employees;

--Q.�Ի��� 6���� �� ù ��° �������� �����̸����� ����ϼ���.
select last_name, hire_date, next_day(add_months(hire_date, 6),'��')d_day
from employees;


--Q.employee_id�� 100�� 106 ������ ������ hire_date���� ���� ����� �ݿ����� ��¥�� �������� ���ڷ� �����ؼ� ����ϰ�, ���ڷε� �����ؼ� ����ϼ���
select hire_date, next_day(hire_date, '�ݿ���'), next_day(hire_date, 6)
from employees
WHERE employee_id between 100 and 106;

--Q.���� ��¥�� ���� ���ϱ�
select TO_CHAR(hire_date, 'day' )
from employees;

select TO_CHAR(hire_date, 'dy' )
from employees;

-- d = ( 1~7 ��~��)
select TO_CHAR(hire_date, 'd' )
from employees;

--Q.job_id ���� �����հ� ������� �ְ��� �������� ���, �� ��տ����� 5000 �̻��� ��츸 ����
select job_id , sum(salary)�����հ�,avg(salary)�������,max(salary)�ְ���,min(salary)��������
from employees
group by job_id
having avg(salary) >= 5000;

--Q.job_id ���� �����հ� ������� �ְ��� �������� ���, �� ��տ����� 5000 �̻��� ��츸 ������������ ����
select job_id,  sum(salary) �����հ�, avg(salary) �������, max(salary) �ְ���,  min(salary) ��������
from employees
group by job_id
having avg(salary) >=5000
order by avg(salary) desc;


--Q. last_name�� L�� ���Ե� ������ ������ ���϶�
select last_name, salary
from employees
where last_name like '%L%';



--Q. job_id�� PROG�� ���Ե� ������ �Ի��� ���϶�
select hire_date, job_id
from employees
where job_id like '%PROG%';


--Q. ������ 10000$ �̻��� MANAGER_ID �� 100�� ������ ������ ���
select *
from employees
where salary >= 10000 and manager_id = 100;


--Q. DEPARTMENT_ID �� 100���� ���� ��� ������ ������ ���Ͽ���
select department_id, salary
from employees
where department_id < 100;


--Q. MANAGER_ID �� 101,103�� ������ JOB_ID�� ���Ͽ���
select job_id, manager_id
from employees
where manager_id = 101 or manager_id = 103;

--join

--Q. �����ȣ�� 110�� ����� �μ���
select *
from employees;
select *
from departments;
select *
from jobs;

select dp.department_name, employee_id
from departments dp, employees em
where dp.department_id = em.department_id and em.employee_id =110;

SELECT employee_id, department_name
FROM employees e
join departments d on e.department_id=d.department_id
WHERE employee_id=110;


--Q.����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���(�ΰ��� ���)
SELECT employee_id, last_name, e.job_id, job_title
FROM employees e, jobs j
WHERE e.job_id =j.job_id and employee_id =120;

select employee_id,last_name,e.job_id,job_title 
from employees e 
join jobs j on e.job_id = j.job_id --join ������table on ���μӼ�
where employee_id =120;


--���, �̸�, department_name, job_title(employees, departments, jobs)
select * from employees;
SELECT * FROM departments;
SELECT * FROM jobs;

select e.employee_id, e.first_name, e.last_name, d.department_name, j.job_title
from employees e, jobs j, departments d
where e.department_id = d.department_id and e.job_id = j.job_id;


select e.employee_id ���, e.last_name �̸�, d.department_name �μ�, j.job_title ������
from  employees e
join departments d
on e.department_id = d.department_id
join jobs j
on e.job_id = j.job_id;


--self join �ϳ��� ���̺��� �� ���� ���̺��� ��ó�� ����
select e.employee_id ���, e.last_name �̸�, m.last_name, m.manager_id
from employees e, employees m
where e.employee_id = m.manager_id;


--outer join: ���� ���ǿ� �������� ���ϴ��� �ش� ���� ��Ÿ���� ���� �� ���
select e.employee_id ���, e.last_name �̸�, m.last_name, m.manager_id
from employees e, employees m
where e.employee_id(+) = m.manager_id;

SELECT e.employee_id ���, e.last_name �̸�, m.last_name, m.manager_id
FROM employees e, employees m
WHERE e.employee_id=m.manager_id(+);


--UNION(�� ����� ��ġ�鼭 �ߺ� �� ����)
select first_name �̸�, salary �޿�
from employees
where salary < 5000
union
select first_name �̸�, salary �޿�
from employees
where hire_date< '99/01/01';

--UNINON ALL(�� ����� ��ġ�鼭 �ߺ� ����)
SELECT first_name �̸�, salary �޿� 
FROM employees
WHERE salary < 5000
UNION ALL
SELECT first_name �̸�, salary �޿�
FROM employees
WHERE hire_date < '99/01/01';

--INTERSECT(������)
SELECT first_name �̸�, salary �޿� FROM employees
WHERE salary < 5000
INTERSECT
SELECT first_name �̸�, salary �޿� FROM employees
WHERE hire_date < '07/01/01';

--MINUS(������)
SELECT first_name �̸�, salary �޿� FROM employees
WHERE salary < 5000
MINUS
SELECT first_name �̸�, salary �޿� FROM employees
WHERE hire_date < '07/01/01';

--Q.100�� �μ��� ������ ����� �޿����� �� ���� �޿��� �޴� ���(last_name)�� salary ���
select salary 
from employees
where department_id =100;

select e.last_name, e.salary 
from employees e
where e.salary > All(select (salary) from employees where department_id =100);


--[����] 2005�� ���Ŀ� �Ի��� ������ ���, �̸�, �Ի���, �μ���(department_name), ������(job_title)�� ���
select employee_id ���, last_name �̸�, hire_date �Ի���, department_name �μ���, job_title ������
from employees e, departments d, jobs j
where hire_date > '05/01/01' and e.department_id = d.department_id and e.job_id = j.job_id
order by hire_date;

--Q. 06-01-03 ������ �Ի��ڵ�
select *
from employees
where to_date(hire_date, 'YY-MM-DD') > '06-01-03';


--[����]job_title, department_name���� ��� ������ ���� �� ����ϼ���. 
select round(avg(salary)) ��տ���, job_title, department_name
from jobs j, departments d, employees e
where e.job_id = j.job_id and e.department_id = d.department_id
group by job_title, department_name;


--[����]��պ��� ���� �޿��� �޴� ���� �˻� �� ����ϼ���.
select *
from employees
where salary > (select avg(salary) from employees);

--[����]last_name�� King�� ������ last_name, hire_date, department_id�� ����ϼ���
select last_name, hire_date, department_id
from employees
where last_name like '%King%';

SELECT last_name, hire_date, department_id
FROM employees
WHERE LOWER(last_name)='king';

--[����] ���, �̸�, ����, ����ϼ���. ��, ������ �Ʒ� ���ؿ� ����
--salary > 20000 then '��ǥ�̻�'
--salary > 15000 then '�̻�' 
--salary > 10000 then '����' 
--salary > 5000 then '����' 
--salary > 3000 then '�븮'
--������ '���'

select employee_id ���, last_name �̸�,
case 
when salary > 2000 then '��ǥ�̻�'
WHEN salary > 15000 then '�̻�' 
WHEN salary > 10000 then '����' 
WHEN salary > 5000 then '����' 
WHEN salary > 3000 then '�븮'
else '���'
end as ����
from employees;

-- select case when����
SELECT
 CASE
  WHEN '����' THEN '���ǿ� ������ �� ����� ������'
  ELSE '���ǿ� �������� ���� �� ��� ������'
 END as �ٲ� �÷���
FROM ���̺�;