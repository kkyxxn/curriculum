-- ESCAPE
-- LIKE 연산으로 '%'나 '_'가 들어간 문자를 검색하기 위해서는 ESCAPE를 사용해야 한다.
SELECT * FROM employees where job_id like '%\_A%' ESCAPE '\';
SELECT * FROM employees WHERE job_id like '%#_A%' escape '#';

--IN : OR 대신 사용
SELECT * FROM employees where manager_id=101 or manager_id=102 or manager_id=103;
select * from employees where manager_id in(101,102,103);

--BETWEEN a AND b : 포함 -> 조건 A 에서 조건 B 사이의 값을 조회
select * from employees where manager_id =101 and manager_id =103;
SELECT * FROM employees WHERE manager_id BETWEEN 101 AND 103;

--IS NULL / IS NOT NULL
SELECT * FROM employees WHERE commission_pct IS NULL;
SELECT * FROM employees WHERE commission_pct IS NOT NULL;

--[주요 함수]
--MOD
select * from employees where mod(employee_id,2)=1; -- 홀수인 사원의 id만 출력
select mod(10,3) from dual; -- dual table은 오라클에서 제공하는 임시 테이블

--ROUND()
SELECT ROUND(355.95555) FROM dual;
SELECT ROUND(355.95555,0) FROM dual;
SELECT ROUND(355.95555,2) FROM dual;
SELECT ROUND(355.95555,-1) FROM dual;

--TRUNC() 주로 소수점 절사 및 날짜의 시간을 없앨 때 사용한다.
--  TRUNC("값", "옵션")
SELECT TRUNC(45.5555,1)FROM dual;
select * from employees;
SELECT last_name, TRUNC(salary/12,2) FROM employees;

--날짜 관련 함수
SELECT SYSDATE FROM dual; -- 현재 날짜 출력
select sysdate+ 1 from dual;

select * from employees;
SELECT EMPLOYEE_ID ,last_name, TRUNC((SYSDATE - hire_date)/365) as "근속연수" FROM employees;
SELECT last_name, hire_date, ADD_MONTHS(hire_date, 6) FROM employees;

-- LAST_DAY() 달의 마지막 날짜를 구해준다. 
SELECT LAST_DAY(SYSDATE) FROM DUAL;

--NEXT_DAY('기준일자', '찾을요일')
SELECT hire_date, NEXT_DAY(hire_date,'월') AS "찾는날짜" FROM employees;
SELECT sysdate, NEXT_DAY(sysdate, '금') AS "찾는날짜" FROM dual; -- 현재 날짜에서 다음 날짜 구하기

--MONTHS_BETWEEN(날짜, 날짜) 두 날짜 사이의 개월 수 구하기
SELECT last_name, sysdate, hire_date, trunc(months_between(sysdate,hire_date)) from employees;

--형변환 함수
-- number character date
-- to_date() 문자열을 또는 컬럼의 데이터를 날짜포멧으로 변환
-- to_number, to_char

--날짜 형식
--YYYY/MM/DD -> 1989/11/24
--YYYY-MM-DD HH24:MI:SS
SELECT last_name, trunc(months_between('2012/12/31',hire_date)) FROM employees;
SELECT trunc(sysdate - to_date('2014/01/01')) from dual;

--Q. employees 테이블에 있는 직원들(사번, 이름 기준으로)에 대하여 현재기준으로 근속연수를 구하세요
SELECT employee_id, last_name, TRUNC((sysdate- hire_date)/365) as "근속연수" FROM employees;

select to_date('20210101'), to_char(to_date('20210101'), 'Month DD YYYY','NLS_DATE_LANGUAGE=ENGLISH') format1 FROM dual;

select to_char(sysdate, 'YY/MM/DD HH24:MI:SS') from dual; -- 22/02/28 21:37:31
select to_char(sysdate, 'yy/mm/dd') from dual; -- 22/02/28
select to_char(sysdate, 'YYYY-MM-DD') from dual; -- 2022-02-28
select to_char(sysdate, 'hh24:mi:ss') from dual; -- 21:39:36
select to_char(sysdate, 'day') from dual; -- 월요일

--TO_CHAR
--9 한자리의 숫자표현
--0 앞부분을 0으로 표현
--$ 달러 기호를 앞에 표현
--. 소수점을 표시
--, 특정 위치에 표시
--MI 오른쪽에 ? 기호 표시
--PR 음수값을 <>으로 표현
--EEEE 과학적 표현
--B 공백을 0으로 표현
--L 지역통화
select salary, to_char(salary,'0099999') from employees;
select to_char(-salary, '999999PR') from employees;
SELECT TO_CHAR(1111, '99.99EEEE') FROM dual;
SELECT TO_CHAR(1111, 'B9999.99') FROM dual;
SELECT TO_CHAR(1111,'L99999') FROM dual; 

--WIDTH_BUCKET(컬럼,최소값,최대값,분할 수)
SELECT WIDTH_BUCKET(92,0,100,10) from dual;
SELECT WIDTH_BUCKET(100,0,100,10) FROM dual;
SELECT department_id, last_name, salary, WIDTH_BUCKET(salary,0,20000,5) FROM employees WHERE department_id=50;

--[과제] employees 테이블에서 employee_id, last_name, salary, hire_date 및 입사일 기준으로 근속년수를 계산해서 아래사항을 추가한 후 출력
--2001년 1월 1일 창업하여 현재(2020년 12월 31일)까지 20년간 운영되어온 회사는 직원의 근속연수에 따라 30등급으로 나누어 등급에
--따라 1000원의 bonus를 지급(bonus 기준 내림차순 정렬)
SELECT employee_id, last_name, salary, hire_date,
TRUNC(((to_date('20201231') - hire_date)/365)) as "근속연수",
(WIDTH_BUCKET(TRUNC(((to_date('20.12.31') - hire_date)/365)),0,20,30)) as "보너스등급",
(WIDTH_BUCKET(TRUNC(((to_date('20.12.31') - hire_date)/365)),0,20,30))*1000 as bonus
FROM employees
ORDER BY bonus DESC;

--문자함수
select upper('hello world') from dual;
select lower('HELLO WORLD') from dual;
select last_name, salary from employees where LOWER(last_name) ='seo';

--INITCAP함수는 입력 문자열 중에서 각 단어의 첫 글자를 대문자로 나머지는 소문자로 변환하여 반환한다.
select initcap(job_id) from employees;
--문자의 길이 공백 포함
SELECT job_id, LENGTH(job_id) FROM employees;

--INSTR('문자열', '타겟문자열', 시작위치, 횟수)) -> 발견하지 못하면 0을 반환함

-- 1) 3번째부터 시작하는 문장을 추출
-- 2) 'o'문자를 찾기 시작 찾았으면 두번째 'o'를 찾음
-- 3) 2번재 'o'의 인덱스 값을 반환
select instr('Hello World','o',3,2) from  dual;
select INSTR('ABBCCDXYZCDCD', 'D') from dual;

--SUBSTR([문장], 시작위치[NUMBER], 자르고 싶은 길이[NUMBER])
SELECT SUBSTR('Hello! World',3,4) FROM dual;
SELECT SUBSTR('Hello sexyWorld',-5,3) FROM dual;

--' ' STR에서 띄어쓰기 있는 문자 위치 찾기
SELECT INSTR('동해물과 백두산이 마르고 닳도록', ' ') FROM dual; 
--STR의 7째 문자부터 띄어쓰기가 있는 문자 위치 찾기
SELECT INSTR('동해물과 백두산이 마르고 닳도록', ' ', 7)FROM dual;
--STR의 7째 문자부터 2번째 띄어쓰기가 있는 문자 찾기
SELECT INSTR('동해물과 백두산이 마르고 닳도록', ' ', 7,2) FROM dual;
--띄어쓰기 2번째 문자열까지 문자열 자르기
SELECT SUBSTR('동해물과 백두산이 마르고 닳도록', 0, INSTR('동해물과 백두산이 마르고 닳도록', ' ', 1, 2)) FROM dual; 
SELECT INSTR('동해물과 백두산이 마르고 닳도록', ' ', 1, 2) FROM dual;

--왼쪽으로 20자리수 안채워진 공간에 #넣기
SELECT LPAD('Hello World',20,'#') FROM dual;
--오른쪽으로 20자리수 안채워진 공간에 #넣기
SELECT RPAD('Hello World',20,'#') FROM dual;

--왼쪽 문자 'a' 제거
SELECT LTRIM('aaaHello Worldaaa','a') FROM dual;
--오른쪽 문자 'a' 제거
SELECT RTRIM('aaaHello Worldaaa','a') FROM dual;

--왼쪽 공백 제거
select ltrim('   Hello World   ') from dual;
--오른쪽 공백 제거
SELECT RTRIM('   Hello World   ') FROM dual;
--양쪽 공백 제거
SELECT TRIM('   Hello World   ') FROM dual; 

--기타함수
-- nvl null값을 치환해주는 함수 NVL(컬럼,NULL일경우 반환값) 
-- NVL2('컬럼','NULL이 아닐 경우 반환값','NULL일경우 반환값')
SELECT salary, commission_pct, salary*12*NVL(commission_pct,0) FROM employees;


SELECT last_name, department_id,
CASE WHEN department_id=90 THEN '경영지원실'
WHEN department_id = 60 THEN '프로그래머'
WHEN department_id=100 THEN '인사부'
END AS 소속
FROM employees;


--윈도우함수명(인수들) OVER ([PARTITION BY 컬럼] [ORDER BY 절 ASC|DESC] [윈도우절])
-- 1) 윈도우함수명은 RANK(), MAX(), FIRST_VALUE() 등이 있습니다. 메인 기능입니다.
-- 2) OVER는 윈도우함수 바로 뒤에 사용하고 옵션들을 그 뒤로 나열합니다. 필수 키워드입니다.
-- 3) PARTITION BY 컬럼은 선택 옵션입니다.
-- 4) ORDER BY 컬럼은 해당 컬럼에 대해서 정렬을 합니다. 선택 옵션입니다.


--분석함수 : 여러 가지 기준을 적용해 여러 결과를 return 할 수 있으며 처리 대상이 되는 행의 집단을 window라고 지칭
--FIRST_VALUE() OVER() 그룹의 첫번째 값을 구한다.
--오라클의 쿼리 결과에서 첫번째 행의 값을 가져올때는 FIRST_VALUE 
--마지막 행의 값을 가져올때는 LAST_VALUE 
--OVER(ORDER BY 컬럼명)을 사용할 경우 메인 쿼리 순서와 상관없이 지정한 컬럼으로 정렬하여 첫번째 행의 값을 표시한다. 
select first_name as "이름", salary as "연봉",
first_value(salary) over(order by salary desc) as "최고연봉"
from employees;

--Q. 3줄 위의 값까지 중 첫번째 값
SELECT first_name 이름, salary 연봉,
FIRST_VALUE(salary) OVER(ORDER BY salary DESC ROWS 3 PRECEDING) 최고연봉
FROM employees;

--Q. 3줄 위의 값까지중 최저연봉
select first_name 이름, salary 연봉,
first_value(salary) over(order by salary asc rows 3 preceding) 최저연봉
from employees;

select first_name 이름, salary 연봉,
last_value(salary) over(order by salary asc rows 3 preceding) 최저연봉
from employees;

select first_name 이름, salary 연봉,
last_value(salary) over(order by salary desc rows 3 preceding) 최저연봉
from employees;

--Q. 위아래 각각 2줄 까지 중 최저연봉
SELECT first_name 이름, salary 연봉,
LAST_VALUE(salary) OVER(ORDER BY salary DESC ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) 최저연봉
FROM employees;


select * from employees;
--[과제] employees 테이블에서 department_id=50인 직원의 연봉을 내림차순 정렬하여 누적 카운드를 출력하세요.
select department_id, last_name, salary,  count(*) over(order by salary desc)
from employees
where department_id=50;

--[과제] employees 테이블에서 department_id를 기준으로 오름차순 정렬하고 department_id 그룹 직원의 연봉 누적 합계를 출력하세요.
SELECT department_id, last_name, salary, SUM(salary) OVER(PARTITION BY department_id 
ORDER BY department_id asc) FROM employees;


--[과제] employees 테이블에서 first_name, department_id(부서)별 직원 연봉순위를 출력하세요.
select first_name, department_id as 부서, salary 연봉,
rank() over(partition by department_id order by salary desc) 부서연봉순위
from employees;


SELECT first_name, department_id 부서, salary 연봉,
RANK() OVER(ORDER BY salary DESC) 연봉순위
FROM employees;

--dml
DESC BOOK;
SELECT * FROM BOOK;
SELECT BOOKNAME,PRICE FROM BOOK;
SELECT PUBLISHER FROM BOOK;

SELECT DISTINCT PUBLISHER FROM BOOK; --중복 제거 distinct

-- book 테이블로 아래의 조건문을 실행
--Q. 가격이 10000원 이하인 book의 전체 컬럼 출력
SELECT * 
FROM BOOK
WHERE PRICE < 10000;

--Q. 가격이 10000원 이상 20000원 이하인 도서를 검색하세요.
select *
from book
where price >= 10000 and price <=20000;

--Q. 출판사가 굿스포츠, 혹은 대한미디어인 도서를 검색하세요.
select *
from book
where publisher= '굿스포츠' or publisher= '대한미디어';

select *
from book
where publisher in('굿스포츠','대한미디어');

--Q. 출판사가 굿스포츠, 혹은 대한미디어가 아닌 도서를 검색하세요.
select *
from book
where publisher not in ('굿스포츠', '대한미디어');

--Q. 도서이름에 축구가 포함된 출판사를 검색하세요.
select *
from book
where bookname like '%축구%';

select publisher
from book
where bookname like '%축구%';

--[과제] 도서이름의 왼쪽 두 번째 위치에 구라는 문자열을 갖는 도서를 검색하세요.
-- _은 특정 위치의 한개의 문자와 일치
-- %은 0개 이상의 문자와 일치
SELECT BOOKNAME,PUBLISHER
FROM BOOK
WHERE BOOKNAME LIKE'_구%';

--[과제] 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하세요.
select *
from book
where bookname like '%축구%' and price >=20000;

--Q. 도서를 가격순으로 검색하고 가격이 같으면 이름순으로 검색하세요.
select *
from book
order by price, publisher;

--Q. 도서를 가격의 내림차순으로 검색하고 만약 가격이 같다면 출판사의 오름차순으로 출력하세요.
-- desc 내림차순 , asc 오름차순(기본)
select *
from book
order by price desc, publisher;


SELECT * FROM ORDERS; -- orders 테이블로 아래의 조건문을 실행
--Q.전체 주문금액을 구하세요.
SELECT SUM(SALEPRICE)
FROM ORDERS;

--Q.CUSTID 가 2번인 고객이 주문한 도서의 총판매액을 구하세요.
select sum(saleprice) as "총판매액"
from orders
where custid =2;

--Q.orders 테이블의 총 판매액, 평균, 최소가격, 최대가격을 구하세요.
select sum(saleprice) as total,
avg(saleprice) as average,
min(saleprice) as minimum,
max(saleprice) as maximum
from orders;

--Q.orders table의 모든 row의 수를 센다.
SELECT COUNT(*) 
FROM ORDERS;

--Q.orders table의 not null인 row의 수를 센다.
select count(custid)
from orders;

--Q.orders table의 중복을 제거하고 not null인 row의 수를 센다.
select count(distinct custid)
from orders;

--Q. CUSTID별 도서수량과 총판매액을 출력하세요.
select custid, count(*) as 도서수량, sum(saleprice) as 총판매액
from orders
group by custid;


SELECT * FROM ORDERS;
--Q. 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하세요. 단 두권 이상 구매한 고객에 한정함
select custid, count(custid) as "고객별 총 주문도서" 
from orders
where saleprice >=8000
group by custid 
having count(custid) >=2;

select count(distinct custid)
from orders;

SELECT CUSTID, COUNT(*) AS 도서수량
FROM ORDERS
WHERE SALEPRICE >= 8000
GROUP BY CUSTID
HAVING COUNT(*) >= 2;


SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
SELECT * FROM BOOK;
-- 두 개 이상 테이블에서 SQL 질의 -> custid가 중첩됨 -> join 활용
-- 고객과 고객의 주문에 관한 데이터를 CUSTID별로 정렬하여 보이세요.
SELECT *
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID
ORDER BY CUSTOMER.CUSTID;

--Q. 고객별로 주문한 모든 도서의 총 판매액을 구하고 고객이름별로 정렬하세요.
select c.name, sum(o.saleprice)
from customer c, orders o
where c.custid = o.custid
group by c.name
order by c.name;

--Q. 고객의 이름과 고객이 주문한 도서의 이름을 구하세요.
select c.name, b.bookname
from customer c, book b, orders o
where c.custid = o.custid and o.bookid= b.bookid;

--[과제] 가격이 20,000인 도서를 주문한 고객의 이름과 도서의 이름을 구하세요.
select c.name, b.bookname, o.saleprice
from customer c, orders o, book b
where c.custid = o.custid and o.bookid = b.bookid and b.price =20000;


--left outer join : 왼쪽 테이블에 값이 있을 시 오른쪽 테이블이 조건에 맞지 않아도 나옴
-- 일단 왼쪽 테이블에 있는 값은 다 나옴 -> 그 후 오른쪽 테이블에서 일치하지 않는건 null처리하여 출력됨

--right outer join : 오른쪽 테이블에 값이 있을 시 왼쪽 테이블이 조건에 맞지 않아도 나옴 
-- 일단 오른쪽 테이블에 있는 값은 다 나옴 -> 그 후 왼쪽 테이블에서 일치하지 않는건 null처리하여 출력됨

--full outer join : 한쪽 테이블에 값이 있을 시 다른 쪽 테이블이 조건에 맞지 않아도 나옴

--[과제] 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하세요.
--outer join 조인조건을 만족하지 못하더라도 해당 행을 나타냄

select c.name, o.saleprice
from customer c, orders o
where c.custid = o.custid(+); -- name컬럼이랑 saleprice컬럼이랑 합쳐짐 left outer join

select name, saleprice
from customer left outer join orders
on customer.custid = orders.custid;

select c.name, o.saleprice
from customer c left outer join orders o
on c.custid = o.custid;

select name, saleprice
from customer c left outer join orders o
using(custid)

-- 서브쿼리 > 중첩질의 (where절에 위치함)
--[과제] 가장 비싼 도서의 이름 가격을 출력하세요.
select bookname, price
from book
where price = (select max(price) from book);

--[과제] 도서를 구매한 적이 있는 고객의 이름을 검색하세요.
select name,custid
from customer 
where custid in (select custid from orders)
order by custid desc;

--[과제] 대한미디어에서 출판한 도서를 구매한 고객의 이름을 출력하세요.
select name
from customer
where custid in (select custid 
                    from orders
                    where bookid in(select bookid 
                                        from book
                                        where publisher='대한미디어'));
--1) book table에서 출판사가 대한미디어인 bookid를 구하고
--2) order table에서 그 bookid를 가지고 custid를 구하고
--3) customer table에서 custid를 가지고 name을 구한다

--상관 부속질의 
--Q. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.(셀프조인)
-- 평균을 구한 후 평균보다 비싼 도서를 구해야함
select b1.bookname
from book b1
where b1.price > (select avg(b2.price)
                    from book b2
                    where b2.publisher = b1.publisher);


--Q. 주문이 있는 고객의 이름과 주소를 보이시오.
select name, address
from customer
where custid in(select custid from orders); --주문이 있는지 -> 주문테이블에서 custid가 select되는지

--Q.Customer 테이블에서 고객번호가 5인 고객의 주소를 ‘대한민국 부산’으로 변경하시오.
update customer
set address = '대한민국 부산'
where custid = 5;

--Q.Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.
update customer
set address = (select address 
                    from customer
                    where name='김연아')
where name = '박세리';
SELECT * FROM customer;

--Q.Customer 테이블에서 고객번호가 5인 고객을 삭제한 후 결과를 확인하시오.
delete 
from customer
where custid =5;


select abs(-78), abs(+78) from dual;
select round(4.875,1) from dual;
--Q.고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오.
select custid 고객번호 ,round(avg(saleprice),-2) as "평균 주문 금액"
from orders
group by custid


select * from book;

--Q.도서 제목에 ‘야구’가 포함된 도서의 가격을 골프바이블의 가격으로 변경하세요.
update book
set price = (select price from book where bookname='골프 바이블')
where bookname like '야구%';
rollback;

--Q.도서 제목에 ‘야구’가 포함된 도서를 ‘농구’로 변경한 후 도서 목록, 가격을 보이시오.
select bookid, replace(bookname, '야구','농구') bookname, price
from book;

--UPDATE 테이블명 SET 컬럼명 = REPLACE(컬럼명 ,'변경전 문자','변경후 문자') 
update book 
set bookname = replace(bookname, '야구','농구')
where publisher like '이상%';


--Q.‘굿스포츠’에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오.
select bookname 제목 , length(bookname) as "제목의 글자 수" , lengthb(bookname) as "바이트 수"
from book
where publisher = '굿스포츠';

--Q.마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
select substr(name,1,1) as "성" from customer; 

select substr(name,1,1) as "성" , count(*) 인원수
from customer
group by substr(name,1,1)
order by "성";


--Q. 마당서점은 주문일로 부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하세요.
 select orderdate as 주문일자,orderdate+10 as "확정일자"
 from orders;
 
--Q.DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오. 
select sysdate from dual;
select sysdate, to_char(sysdate, 'yyyy/MM/DD dy hh24:mi:ss') as"현재날짜를 to_char로 변환"
FROM dual;

--Q.마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오.
select orderid "도서의 주문번호", to_char(orderdate, 'yyyy-mm-dd day') 주문일, custid 고객번호, bookid 도서번호
from orders
where orderdate ='20/07/07';

--Q.고객목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오.
select rownum 순번, custid 고객번호, name 이름, phone 전화번호
from customer
where rownum <=2;

--Q.평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
select avg(saleprice) from orders; --11800

select orderid 주문번호, saleprice 주문금액
from orders
where saleprice <= (select avg(saleprice) from orders);

--Q.평균 주문금액 이상의 주문에 대해서 주문번호와 금액을 보이시오.
--where절의 부속질의 (중첩질의)
--- 결과를 한정시키기 위해 사용됨. 상관 혹은 비상관 형태
-- WHERE절은 보통 데이터를 선택하는 조건 혹은 술어와 같이 사용됨. 그래서 중첩질의를 술어 부속질의라고 함

select orderid 주문번호, saleprice 주문금액
from orders
where saleprice >= (select avg(saleprice) from orders);

--Q.각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오.
select * from orders;
select orderid, custid, saleprice
from orders b1
where b1.saleprice > (select avg(b2.saleprice)
from orders b2 where b2.custid = b1.custid);


--Q.‘대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
select sum(saleprice) as "총판매액"
from orders o, customer c
where o.custid = c.custid and c.address like '대한민국%';

select sum(saleprice) 총판매액
from orders
where custid in(select custid from customer where address like '%대한민국%');


--Q.3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.
select orderid 주문번호, saleprice 주문금액, custid
from orders
where custid = 3 ;

select orderid 주문번호, saleprice 주문금액
from orders
where saleprice > (select max(saleprice) from orders where custid ='3');


--[과제]EXISTS 연산자를 사용하여 ‘대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
-- EXISTS : 값이 존재하는지 확인 후 TRUE, FALSE를 반환
select sum(saleprice) 
from orders o
where exists (select * from customer c  where address like '%대한민국%' and o.custid=c.custid);

-- IN
select sum(saleprice)
from orders
where custid in(select custid from customer where address like '%대한민국%');

-- JOIN ON
select sum(saleprice)
from customer c join orders o on o.custid=c.custid
where address like '%대한민국%'; 


--[과제]마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액 출력)
-- select절에 부속질의, 스칼라 부속질의 
select (select name from customer c where o.custid = c.custid) as 고객이름,
sum(saleprice) 총판매액 
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
group by c.custid, c.name -- csutid별 이름별로 그룹핑
order by custid desc; --custid 내림차순


--[과제] 고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력)
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


--Q.주소에 ‘대한민국’을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 뷰의 이름은 vw_Customer로 설정하시오.

create view vw_Customer
as select *
from customer
where address like '%대한민국%';

select * from vw_Customer;
SELECT * FROM customer;


--[과제]Orders 테이블에서 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, 
-- 3개 테이블 join
create view vw_Orders(orderid,custid,name,bookid,bookname,saleprice,orderdate)
as select o.orderid, o.custid, c.name, o.bookid, b.bookname, o.saleprice, o.orderdate
from orders o, customer c, book b
where o.custid = c.custid and o.bookid= b.bookid;

--‘김연아’ 고객이 구입한 도서의 주문번호, 고객번호, 도서이름, 주문액을 보이시오.
select * from vw_Orders;
select orderid, custid, bookname, saleprice
from vw_Orders
where name ='김연아';


--[과제]vw_Customer를 미국을 주소로 가진 고객으로 변경하세요.
select * from vw_Customer;

--뷰를 변경하거나 생성하고자 할 때 사용하는 명령어
create or replace view vw_Customer
as select *
from customer
where address like '%미국%';

--[과제]앞서 생성한 뷰 vw_Customer를 삭제하시오.
DROP VIEW vw_Customer;

--[HR Tables]

SELECT * FROM employees;

--[과제]EMPLOYEES 테이블에서 commission_pct 의  Null값 갯수를  출력하세요.
SELECT COUNT(*)
FROM employees
WHERE commission_pct is null;

--[과제]EMPLOYEES 테이블에서 employee_id가 홀수인 것만 출력하세요.
select *
from employees
where mod(employee_id,2)=1;

--[과제]job_id의 문자 길이를 구하세요.
select job_id, length(job_id) from employees;

--[과제]job_id 별로 연봉합계 연봉평균 최고연봉 최저연봉 출력
select job_id, sum(salary) as 연봉합계, avg(salary) 연봉평균, max(salary) as "최고연봉" ,min(salary) 최저연봉
from employees
group by job_id;


--날짜 관련 함수
--TRUNC 함수는 주로 소수점 절사 및 날짜의 시간을 없앨 때 사용한다.
-- 함수  :  TRUNC("값", "옵션")
select sysdate from dual; -- 현재 날짜
select * from employees;
select last_name, hire_date, TRUNC((SYSDATE - hire_date)/365,0) as " 근 속 연 수 " from employees;

--특정 개월 수를 더한 날짜를 구하기
select last_name, hire_date, add_months(hire_date, 6) from employees;


--해당 날짜가 속한 월의 말일(last_day)을 반환하는 함수
select last_day(sysdate) from dual;


--Q. 다음 달 말일(hire_data 기준)
select last_name, hire_date, last_day(add_months(hire_date,1)) as "입사 다음달 말일"
from employees;


--해당 날짜를 기준으로 명시된 요일에 해당하는 다음주 날짜(next_day)를 반환
select hire_date, next_day(hire_date,'월') from employees;


--months_between() 날짜와 날짜 사이의 개월 수를 구하기
select last_name, trunc(months_between(sysdate, hire_date),0) 근속월수1, ROUND(MONTHS_BETWEEN(sysdate,hire_date),0)근속월수2 FROM employees;
from employees;

--Q.입사일 6개월 후 첫 번째 월요일을 직원이름별로 출력하세요.
select last_name, hire_date, next_day(add_months(hire_date, 6),'월')d_day
from employees;


--Q.employee_id가 100과 106 사이인 직원의 hire_date에서 가장 가까운 금요일의 날짜가 언제인지 문자로 지정해서 출력하고, 숫자로도 지정해서 출력하세요
select hire_date, next_day(hire_date, '금요일'), next_day(hire_date, 6)
from employees
WHERE employee_id between 100 and 106;

--Q.고용된 날짜의 요일 구하기
select TO_CHAR(hire_date, 'day' )
from employees;

select TO_CHAR(hire_date, 'dy' )
from employees;

-- d = ( 1~7 일~토)
select TO_CHAR(hire_date, 'd' )
from employees;

--Q.job_id 별로 연봉합계 연봉평균 최고연봉 최저연봉 출력, 단 평균연봉이 5000 이상인 경우만 포함
select job_id , sum(salary)연봉합계,avg(salary)연봉평균,max(salary)최고연봉,min(salary)최저연봉
from employees
group by job_id
having avg(salary) >= 5000;

--Q.job_id 별로 연봉합계 연봉평균 최고연봉 최저연봉 출력, 단 평균연봉이 5000 이상인 경우만 내림차순으로 정렬
select job_id,  sum(salary) 연봉합계, avg(salary) 연봉평균, max(salary) 최고연봉,  min(salary) 최저연봉
from employees
group by job_id
having avg(salary) >=5000
order by avg(salary) desc;


--Q. last_name에 L이 포함된 직원의 연봉을 구하라
select last_name, salary
from employees
where last_name like '%L%';



--Q. job_id에 PROG가 포함된 직원의 입사일 구하라
select hire_date, job_id
from employees
where job_id like '%PROG%';


--Q. 연봉이 10000$ 이상인 MANAGER_ID 가 100인 직원의 데이터 출력
select *
from employees
where salary >= 10000 and manager_id = 100;


--Q. DEPARTMENT_ID 가 100보다 적은 모든 직원의 연봉을 구하여라
select department_id, salary
from employees
where department_id < 100;


--Q. MANAGER_ID 가 101,103인 직원의 JOB_ID를 구하여라
select job_id, manager_id
from employees
where manager_id = 101 or manager_id = 103;

--join

--Q. 사원번호가 110인 사원의 부서명
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


--Q.사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력(두가지 방식)
SELECT employee_id, last_name, e.job_id, job_title
FROM employees e, jobs j
WHERE e.job_id =j.job_id and employee_id =120;

select employee_id,last_name,e.job_id,job_title 
from employees e 
join jobs j on e.job_id = j.job_id --join 조인할table on 조인속성
where employee_id =120;


--사번, 이름, department_name, job_title(employees, departments, jobs)
select * from employees;
SELECT * FROM departments;
SELECT * FROM jobs;

select e.employee_id, e.first_name, e.last_name, d.department_name, j.job_title
from employees e, jobs j, departments d
where e.department_id = d.department_id and e.job_id = j.job_id;


select e.employee_id 사번, e.last_name 이름, d.department_name 부서, j.job_title 직무명
from  employees e
join departments d
on e.department_id = d.department_id
join jobs j
on e.job_id = j.job_id;


--self join 하나의 테이블이 두 개의 테이블인 것처럼 조인
select e.employee_id 사번, e.last_name 이름, m.last_name, m.manager_id
from employees e, employees m
where e.employee_id = m.manager_id;


--outer join: 조인 조건에 만족하지 못하더라도 해당 행을 나타내고 싶을 때 사용
select e.employee_id 사번, e.last_name 이름, m.last_name, m.manager_id
from employees e, employees m
where e.employee_id(+) = m.manager_id;

SELECT e.employee_id 사번, e.last_name 이름, m.last_name, m.manager_id
FROM employees e, employees m
WHERE e.employee_id=m.manager_id(+);


--UNION(두 결과를 합치면서 중복 값 제거)
select first_name 이름, salary 급여
from employees
where salary < 5000
union
select first_name 이름, salary 급여
from employees
where hire_date< '99/01/01';

--UNINON ALL(두 결과를 합치면서 중복 포함)
SELECT first_name 이름, salary 급여 
FROM employees
WHERE salary < 5000
UNION ALL
SELECT first_name 이름, salary 급여
FROM employees
WHERE hire_date < '99/01/01';

--INTERSECT(교집합)
SELECT first_name 이름, salary 급여 FROM employees
WHERE salary < 5000
INTERSECT
SELECT first_name 이름, salary 급여 FROM employees
WHERE hire_date < '07/01/01';

--MINUS(차집합)
SELECT first_name 이름, salary 급여 FROM employees
WHERE salary < 5000
MINUS
SELECT first_name 이름, salary 급여 FROM employees
WHERE hire_date < '07/01/01';

--Q.100번 부서의 구성원 모두의 급여보다 더 많은 급여를 받는 사원(last_name)과 salary 출력
select salary 
from employees
where department_id =100;

select e.last_name, e.salary 
from employees e
where e.salary > All(select (salary) from employees where department_id =100);


--[과제] 2005년 이후에 입사한 직원의 사번, 이름, 입사일, 부서명(department_name), 업무명(job_title)을 출력
select employee_id 사번, last_name 이름, hire_date 입사일, department_name 부서명, job_title 업무명
from employees e, departments d, jobs j
where hire_date > '05/01/01' and e.department_id = d.department_id and e.job_id = j.job_id
order by hire_date;

--Q. 06-01-03 이후의 입사자들
select *
from employees
where to_date(hire_date, 'YY-MM-DD') > '06-01-03';


--[과제]job_title, department_name별로 평균 연봉을 구한 후 출력하세요. 
select round(avg(salary)) 평균연봉, job_title, department_name
from jobs j, departments d, employees e
where e.job_id = j.job_id and e.department_id = d.department_id
group by job_title, department_name;


--[과제]평균보다 많은 급여를 받는 직원 검색 후 출력하세요.
select *
from employees
where salary > (select avg(salary) from employees);

--[과제]last_name이 King인 직원의 last_name, hire_date, department_id를 출력하세요
select last_name, hire_date, department_id
from employees
where last_name like '%King%';

SELECT last_name, hire_date, department_id
FROM employees
WHERE LOWER(last_name)='king';

--[과제] 사번, 이름, 직급, 출력하세요. 단, 직급은 아래 기준에 의함
--salary > 20000 then '대표이사'
--salary > 15000 then '이사' 
--salary > 10000 then '부장' 
--salary > 5000 then '과장' 
--salary > 3000 then '대리'
--나머지 '사원'

select employee_id 사번, last_name 이름,
case 
when salary > 2000 then '대표이사'
WHEN salary > 15000 then '이사' 
WHEN salary > 10000 then '부장' 
WHEN salary > 5000 then '과장' 
WHEN salary > 3000 then '대리'
else '사원'
end as 직급
from employees;

-- select case when구문
SELECT
 CASE
  WHEN '조건' THEN '조건에 만족할 때 출력할 데이터'
  ELSE '조건에 만족하지 않을 때 출력 데이터'
 END as 바꿀 컬럼명
FROM 테이블;