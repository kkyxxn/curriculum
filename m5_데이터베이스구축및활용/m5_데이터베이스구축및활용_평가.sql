빅데이터 기반 AI 응용 솔루션 개발자 전문과정

교과목명 : 데이터베이스 구축 및 활용

- 평가일 : 22.02.25
- 성명 : 조경윤
- 점수 : 100

select * from EMPLOYEES;
select * from DEPARTMENTS;
select * from COUNTRIES;
select * from JOB_HISSTORY;
select * from JOBS;
select * from LOCATIONS;
select * from REGIONS;

※ HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)를 활용하여 다음 질문들을 수행하세요.
--Q1. HR EMPLOYEES 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력하세요.
--A. 
select first_name, salary, salary*1.1 as "10%인상된 연봉"
from employees;

--Q2.  2005년 상반기에 입사한 사람들만 출력	
--A.        
select *
from employees
where hire_date between '05/01/01' and '05/06/30';

SELECT FIRST_NAME, LAST_NAME, HIRE_DATE 
FROM EMPLOYEES 
WHERE HIRE_DATE > TO_DATE('2005/01/01') AND HIRE_DATE < TO_DATE('2005/07/01');

--Q3. job_id가 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
--A.
select *
from employees
where job_id in('SA_MAN', 'IT_PROG', 'ST_MAN');
   
--Q4. manager_id 가 101에서 103인 사람만 출력
--A.   	
select *
from employees
where manager_id between 101 and 103;

--Q5. EMPLOYEES 테이블에서 LAST_NAME, HIRE_DATE 및 입사일의 6개월 후 첫 번째 월요일을 출력하세요.
--A.
select last_name, hire_date, next_day( add_months( hire_date, 6 ), '월' ) as "입사일 6개월 후 첫번째 월요일"
from employees;
                                
--Q6. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 현재일까지의 W_MONTH(근속월수)를 정수로 계산해서 출력하세요.(근속월수 기준 내림차순)
--A.
select employee_id, last_name, salary, hire_date, trunc((months_between(sysdate, hire_date))) as "W_MONTH(근속월수)"
from employees
order by "W_MONTH(근속월수)" desc;

--Q7. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 W_YEAR(근속년수)를 계산해서 출력하세요.(근속년수 기준 내림차순)
--A.
select employee_id, last_name, salary, hire_date, trunc(( sysdate - hire_date)/ 365) as "W_YEAR(근속년수)"
from employees
order by "W_YEAR(근속년수)" desc;

--Q8. EMPLOYEE_ID가 홀수인 직원의 EMPLPYEE_ID와 LAST_NAME을 출력하세요.
--A. 
select employee_id, last_name
from employees
where mod(employee_id,2)=1;

--Q9. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME 및 M_SALARY(월급)을 출력하세요. 단 월급은 소수점 둘째자리까지만 표현하세요.
--A
select employee_id, last_name, round(salary/12,2) as "M_SALARY(월급)"
from employees;

--Q10. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 근속년수를 계산해서 아래사항을 추가한 후에 출력하세요.
--2001년 1월 1일 창업하여 현재까지 20년간 운영되온 회사는 직원의 근속년수에 따라 30 등급으로 나누어 등급에 따라 1000원의 BONUS를 지급.
--내림차순 정렬.    
--A.

-- width_bucket 구간 분할 함수
--expr : 분할할 데이터. 컬럼명이나 수식 등
--min_value : expr 값 중 분할 할 가장 작은 값
--max_value : expr 값 중 분할 할 가장 큰값
--num_buckets : 분할 할 개수
-- WIDTH_BUCKET(AGE, 1, 101, 4) age컬럼을 1부터 100까지 4개의 구간으로 분할

select employee_id, last_name, salary, hire_date,
trunc( ( ( to_date('20/12/31') - hire_date ) / 365)) as "근속연수",
(width_bucket( trunc( ( to_date('20/12/31') - hire_date ) / 365),0,20,30)) "wb",
(width_bucket( trunc( ( to_date('20/12/31') - hire_date ) / 365),0,20,30))  * 1000 as "bonus"
from employees
order by bonus desc;  

--20개 보너스 등급 적용시
select employee_id, last_name, salary, hire_date, trunc( ( sysdate - hire_date ) / 365) 근속연수,
trunc(( sysdate - hire_date ) / 365) 등급, (width_bucket( trunc( ( sysdate - hire_date ) / 365),0,22,20)) wb,
(width_bucket( trunc( ( sysdate - hire_date ) / 365),0,22,20))  * 1000 "bonus_wb",
trunc(( sysdate - hire_date ) / 365) * 1000 "bonus_등급"
from employees 
order by bonus_wb desc;


--Q11. EMPLOYEES 테이블에서 commission_pct 의  Null값 갯수를  출력하세요.
--A.
select count(*)
from EMPLOYEES
where commission_pct is null;

--Q12. EMPLOYEES 테이블에서 deparment_id 가 없는 직원을 추출하여  POSITION을 '신입'으로 출력하세요.
--A.
select last_name, first_name, nvl(to_char(department_id),'신입') AS "deparment_id 가 없는 직원"
from employees 
where department_id is null;

--Q13. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력(join~on, where 로 조인하는 두 가지 방법 모두)
--A.
select e.employee_id, e.last_name, j.job_id, j.job_title 
from employees e
join jobs j on e.job_id=j.job_id
where employee_id=120;

select  e.employee_id, e.last_name, j.job_id, j. job_title
from employees e, jobs j
where e.job_id=j.job_id and employee_id = 120;

--Q14.  employees 테이블에서 이름에 FIRST_NAME에 LAST_NAME을 붙여서 'NAME' 컬럼명으로 출력하세요.
--예) Steven King
--A. 
select first_name ||' '|| last_name as NAME
from employees;

select concat(first_name, last_name) as NAME
from employees;

select concat(concat(first_name, ' '), last_name) as NAME
from employees;


--Q15. lmembers purprod 테이블로 부터 총구매액, 2014 구매액, 2015 구매액을 한번에 출력하세요.
--A.
select (select sum(p1.구매금액) from purprod p1)  as "총구매액",
(select sum(p2.구매금액) from purprod p2 where p2.구매일자 <20150101) as "2014 구매액",
(select sum(p3.구매금액) from purprod p3 where p3.구매일자 >20141231) as "2015 구매액"
from dual;


--Q16. HR EMPLOYEES 테이블에서 escape 옵션을 사용하여 아래와 같이 출력되는 SQL문을 작성하세요.
--job_id 칼럼에서  _을 와일드카드가 아닌 문자로 취급하여 '_A'를 포함하는  모든 행을 출력
--A.
select *
from employees
where job_id like '%\_A%' escape '\';

--Q17. HR EMPLOYEES 테이블에서 SALARY, LAST_NAME 순으로 올림차순 정렬하여 출력하세요.
--A. 
select SALARY, LAST_NAME
from employees 
order by salary, last_name;   
   
select SALARY, LAST_NAME
from employees 
order by salary desc, last_name;      
   
--Q18. Seo라는 사람의 부서명을 출력하세요.
--A.
select department_name
from departments 
where department_id=(select department_id from employees where last_name='Seo');     

select department_name
from departments d, employees e
where last_name='Seo' and d.department_id = e.department_id;


--Q19. LMEMBERS 데이터에서 고객별 구매금액의 합계를 구한 CUSPUR 테이블을 생성한 후 CUSTDEMO 테이블과 고객번호를 기준으로 결합하여 출력하세요.
--A.
create table CUSPUR
as select 고객번호, sum(구매금액) as 구매금액
from purprod
group by 고객번호
order by 고객번호;

select *
from CUSPUR;

--CUST와 CUSPUR 고객번호 기준 결합
select c.고객번호, c.성별, c.연령대, c.거주지역, cp.구매금액
from CUSTDEMO c, CUSPUR cp
where c.고객번호 = cp.고객번호;

SELECT C.*, CP.구매금액
FROM CUSTDEMO C, CUSPUR CP
WHERE C.고객번호 = CP.고객번호;


--Q20.PURPROD 테이블로 부터 아래 사항을 수행하세요.
-- 2년간 구매금액을 연간 단위로 분리하여 고객별, 제휴사별로 구매액을 표시하는 AMT_14, AMT_15 테이블 2개를 생성 (출력내용 : 고객번호, 제휴사, SUM(구매금액) 구매금액)
--A.
create table AMT_14
as select 고객번호, 제휴사, sum(구매금액) as 구매금액, 
from purprod
where 구매일자 < 20150101
group by 고객번호, 제휴사
order by 고객번호;

select * from amt14;

create table AMT_15
as select 고객번호, 제휴사, sum(구매금액) as "구매금액"
from purprod
where 구매일자 > 20141231
group by 고객번호, 제휴사
order by 고객번호;

select * from amt_15;

-- AMT_14와 AMT_15 2개 테이블을 고객번호와 제휴사를 기준으로 FULL OUTER JOIN 적용하여 결합한 AMT_YEAR_FOJ 테이블 생성
-- (고객번호, 제휴사, AMT_14구매금액, AMT_15구매금액) 출력

create table AMT_YEAR_FOJ
AS SELECT A1.고객번호, A1.제휴사, A1.구매금액 "14년도 구매", A2.구매금액 "15년도 구매"
from AMT_14 A1
FULL OUTER JOIN AMT_15 A2
ON A1.고객번호 = A2.고객번호 AND A1.제휴사 = A2.제휴사;

SELECT * FROM AMT_YEAR_FOJ;


--14년과 15년의 구매금액 차이를 표시하는 증감 컬럼을 추가하여 출력(단, 고객번호, 제휴사별로 구매금액 및 증감이 구분되어야 함)
-- NVL(컬럼, NULL일경우 반환값) 
-- NVL(컬럼,0)  컬럼의 값이 NULL일경우 0으로 치환
-- NVL(컬럼,'') 컬럼의 값이 NULL일경우 ''으로 치환
-- NVL(컬럼,SYSDATE) 컬럼의 값이 NULL일경우 현재날짜로 치환

SELECT * FROM AMT_YEAR_FOJ;

-- 증감 계산을 하기위해서 컬럼별로 NULL값을 0으로 치환해준다.
SELECT 고객번호, 제휴사, NVL("14년도 구매",0) 구매14, NVL("15년도 구매",0) 구매15, (NVL("15년도 구매",0)-NVL("14년도 구매",0)) 증감
FROM AMT_YEAR_FOJ;


--Q(BONUS). HR 테이블들을 분석해서 전체 현황을 설명할 수 있는 요약 테이블을 작성하세요. (예 : 부서별 평균 SALARY 순위)
--A.
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

-- 부서별 평균 SALARY 순위
SELECT d.DEPARTMENT_NAME, ROUND(AVG(e.SALARY)) AVG
FROM DEPARTMENTS d, EMPLOYEES e
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME
ORDER BY AVG DESC;
