������ ��� AI ���� �ַ�� ������ ��������

������� : �����ͺ��̽� ���� �� Ȱ��

- ���� : 22.02.25
- ���� : ������
- ���� : 100

select * from EMPLOYEES;
select * from DEPARTMENTS;
select * from COUNTRIES;
select * from JOB_HISSTORY;
select * from JOBS;
select * from LOCATIONS;
select * from REGIONS;

�� HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)�� Ȱ���Ͽ� ���� �������� �����ϼ���.
--Q1. HR EMPLOYEES ���̺��� �̸�, ����, 10% �λ�� ������ ����ϼ���.
--A. 
select first_name, salary, salary*1.1 as "10%�λ�� ����"
from employees;

--Q2.  2005�� ��ݱ⿡ �Ի��� ����鸸 ���	
--A.        
select *
from employees
where hire_date between '05/01/01' and '05/06/30';

SELECT FIRST_NAME, LAST_NAME, HIRE_DATE 
FROM EMPLOYEES 
WHERE HIRE_DATE > TO_DATE('2005/01/01') AND HIRE_DATE < TO_DATE('2005/07/01');

--Q3. job_id�� SA_MAN, IT_PROG, ST_MAN �� ����� ���
--A.
select *
from employees
where job_id in('SA_MAN', 'IT_PROG', 'ST_MAN');
   
--Q4. manager_id �� 101���� 103�� ����� ���
--A.   	
select *
from employees
where manager_id between 101 and 103;

--Q5. EMPLOYEES ���̺��� LAST_NAME, HIRE_DATE �� �Ի����� 6���� �� ù ��° �������� ����ϼ���.
--A.
select last_name, hire_date, next_day( add_months( hire_date, 6 ), '��' ) as "�Ի��� 6���� �� ù��° ������"
from employees;
                                
--Q6. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �����ϱ����� W_MONTH(�ټӿ���)�� ������ ����ؼ� ����ϼ���.(�ټӿ��� ���� ��������)
--A.
select employee_id, last_name, salary, hire_date, trunc((months_between(sysdate, hire_date))) as "W_MONTH(�ټӿ���)"
from employees
order by "W_MONTH(�ټӿ���)" desc;

--Q7. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� W_YEAR(�ټӳ��)�� ����ؼ� ����ϼ���.(�ټӳ�� ���� ��������)
--A.
select employee_id, last_name, salary, hire_date, trunc(( sysdate - hire_date)/ 365) as "W_YEAR(�ټӳ��)"
from employees
order by "W_YEAR(�ټӳ��)" desc;

--Q8. EMPLOYEE_ID�� Ȧ���� ������ EMPLPYEE_ID�� LAST_NAME�� ����ϼ���.
--A. 
select employee_id, last_name
from employees
where mod(employee_id,2)=1;

--Q9. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME �� M_SALARY(����)�� ����ϼ���. �� ������ �Ҽ��� ��°�ڸ������� ǥ���ϼ���.
--A
select employee_id, last_name, round(salary/12,2) as "M_SALARY(����)"
from employees;

--Q10. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �ټӳ���� ����ؼ� �Ʒ������� �߰��� �Ŀ� ����ϼ���.
--2001�� 1�� 1�� â���Ͽ� ������� 20�Ⱓ ��ǿ� ȸ��� ������ �ټӳ���� ���� 30 ������� ������ ��޿� ���� 1000���� BONUS�� ����.
--�������� ����.    
--A.

-- width_bucket ���� ���� �Լ�
--expr : ������ ������. �÷����̳� ���� ��
--min_value : expr �� �� ���� �� ���� ���� ��
--max_value : expr �� �� ���� �� ���� ū��
--num_buckets : ���� �� ����
-- WIDTH_BUCKET(AGE, 1, 101, 4) age�÷��� 1���� 100���� 4���� �������� ����

select employee_id, last_name, salary, hire_date,
trunc( ( ( to_date('20/12/31') - hire_date ) / 365)) as "�ټӿ���",
(width_bucket( trunc( ( to_date('20/12/31') - hire_date ) / 365),0,20,30)) "wb",
(width_bucket( trunc( ( to_date('20/12/31') - hire_date ) / 365),0,20,30))  * 1000 as "bonus"
from employees
order by bonus desc;  

--20�� ���ʽ� ��� �����
select employee_id, last_name, salary, hire_date, trunc( ( sysdate - hire_date ) / 365) �ټӿ���,
trunc(( sysdate - hire_date ) / 365) ���, (width_bucket( trunc( ( sysdate - hire_date ) / 365),0,22,20)) wb,
(width_bucket( trunc( ( sysdate - hire_date ) / 365),0,22,20))  * 1000 "bonus_wb",
trunc(( sysdate - hire_date ) / 365) * 1000 "bonus_���"
from employees 
order by bonus_wb desc;


--Q11. EMPLOYEES ���̺��� commission_pct ��  Null�� ������  ����ϼ���.
--A.
select count(*)
from EMPLOYEES
where commission_pct is null;

--Q12. EMPLOYEES ���̺��� deparment_id �� ���� ������ �����Ͽ�  POSITION�� '����'���� ����ϼ���.
--A.
select last_name, first_name, nvl(to_char(department_id),'����') AS "deparment_id �� ���� ����"
from employees 
where department_id is null;

--Q13. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���(join~on, where �� �����ϴ� �� ���� ��� ���)
--A.
select e.employee_id, e.last_name, j.job_id, j.job_title 
from employees e
join jobs j on e.job_id=j.job_id
where employee_id=120;

select  e.employee_id, e.last_name, j.job_id, j. job_title
from employees e, jobs j
where e.job_id=j.job_id and employee_id = 120;

--Q14.  employees ���̺��� �̸��� FIRST_NAME�� LAST_NAME�� �ٿ��� 'NAME' �÷������� ����ϼ���.
--��) Steven King
--A. 
select first_name ||' '|| last_name as NAME
from employees;

select concat(first_name, last_name) as NAME
from employees;

select concat(concat(first_name, ' '), last_name) as NAME
from employees;


--Q15. lmembers purprod ���̺�� ���� �ѱ��ž�, 2014 ���ž�, 2015 ���ž��� �ѹ��� ����ϼ���.
--A.
select (select sum(p1.���űݾ�) from purprod p1)  as "�ѱ��ž�",
(select sum(p2.���űݾ�) from purprod p2 where p2.�������� <20150101) as "2014 ���ž�",
(select sum(p3.���űݾ�) from purprod p3 where p3.�������� >20141231) as "2015 ���ž�"
from dual;


--Q16. HR EMPLOYEES ���̺��� escape �ɼ��� ����Ͽ� �Ʒ��� ���� ��µǴ� SQL���� �ۼ��ϼ���.
--job_id Į������  _�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����Ͽ� '_A'�� �����ϴ�  ��� ���� ���
--A.
select *
from employees
where job_id like '%\_A%' escape '\';

--Q17. HR EMPLOYEES ���̺��� SALARY, LAST_NAME ������ �ø����� �����Ͽ� ����ϼ���.
--A. 
select SALARY, LAST_NAME
from employees 
order by salary, last_name;   
   
select SALARY, LAST_NAME
from employees 
order by salary desc, last_name;      
   
--Q18. Seo��� ����� �μ����� ����ϼ���.
--A.
select department_name
from departments 
where department_id=(select department_id from employees where last_name='Seo');     

select department_name
from departments d, employees e
where last_name='Seo' and d.department_id = e.department_id;


--Q19. LMEMBERS �����Ϳ��� ���� ���űݾ��� �հ踦 ���� CUSPUR ���̺��� ������ �� CUSTDEMO ���̺�� ����ȣ�� �������� �����Ͽ� ����ϼ���.
--A.
create table CUSPUR
as select ����ȣ, sum(���űݾ�) as ���űݾ�
from purprod
group by ����ȣ
order by ����ȣ;

select *
from CUSPUR;

--CUST�� CUSPUR ����ȣ ���� ����
select c.����ȣ, c.����, c.���ɴ�, c.��������, cp.���űݾ�
from CUSTDEMO c, CUSPUR cp
where c.����ȣ = cp.����ȣ;

SELECT C.*, CP.���űݾ�
FROM CUSTDEMO C, CUSPUR CP
WHERE C.����ȣ = CP.����ȣ;


--Q20.PURPROD ���̺�� ���� �Ʒ� ������ �����ϼ���.
-- 2�Ⱓ ���űݾ��� ���� ������ �и��Ͽ� ����, ���޻纰�� ���ž��� ǥ���ϴ� AMT_14, AMT_15 ���̺� 2���� ���� (��³��� : ����ȣ, ���޻�, SUM(���űݾ�) ���űݾ�)
--A.
create table AMT_14
as select ����ȣ, ���޻�, sum(���űݾ�) as ���űݾ�, 
from purprod
where �������� < 20150101
group by ����ȣ, ���޻�
order by ����ȣ;

select * from amt14;

create table AMT_15
as select ����ȣ, ���޻�, sum(���űݾ�) as "���űݾ�"
from purprod
where �������� > 20141231
group by ����ȣ, ���޻�
order by ����ȣ;

select * from amt_15;

-- AMT_14�� AMT_15 2�� ���̺��� ����ȣ�� ���޻縦 �������� FULL OUTER JOIN �����Ͽ� ������ AMT_YEAR_FOJ ���̺� ����
-- (����ȣ, ���޻�, AMT_14���űݾ�, AMT_15���űݾ�) ���

create table AMT_YEAR_FOJ
AS SELECT A1.����ȣ, A1.���޻�, A1.���űݾ� "14�⵵ ����", A2.���űݾ� "15�⵵ ����"
from AMT_14 A1
FULL OUTER JOIN AMT_15 A2
ON A1.����ȣ = A2.����ȣ AND A1.���޻� = A2.���޻�;

SELECT * FROM AMT_YEAR_FOJ;


--14��� 15���� ���űݾ� ���̸� ǥ���ϴ� ���� �÷��� �߰��Ͽ� ���(��, ����ȣ, ���޻纰�� ���űݾ� �� ������ ���еǾ�� ��)
-- NVL(�÷�, NULL�ϰ�� ��ȯ��) 
-- NVL(�÷�,0)  �÷��� ���� NULL�ϰ�� 0���� ġȯ
-- NVL(�÷�,'') �÷��� ���� NULL�ϰ�� ''���� ġȯ
-- NVL(�÷�,SYSDATE) �÷��� ���� NULL�ϰ�� ���糯¥�� ġȯ

SELECT * FROM AMT_YEAR_FOJ;

-- ���� ����� �ϱ����ؼ� �÷����� NULL���� 0���� ġȯ���ش�.
SELECT ����ȣ, ���޻�, NVL("14�⵵ ����",0) ����14, NVL("15�⵵ ����",0) ����15, (NVL("15�⵵ ����",0)-NVL("14�⵵ ����",0)) ����
FROM AMT_YEAR_FOJ;


--Q(BONUS). HR ���̺���� �м��ؼ� ��ü ��Ȳ�� ������ �� �ִ� ��� ���̺��� �ۼ��ϼ���. (�� : �μ��� ��� SALARY ����)
--A.
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

-- �μ��� ��� SALARY ����
SELECT d.DEPARTMENT_NAME, ROUND(AVG(e.SALARY)) AVG
FROM DEPARTMENTS d, EMPLOYEES e
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME
ORDER BY AVG DESC;
