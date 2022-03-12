-- 테이블 2개 생성 (제약 조건 포함)
CREATE TABLE student
(
ID       VARCHAR2(20),
depart_num VARCHAR2(20),
NAME     VARCHAR2(20),
GRADE      NUMBER(3),
score NUMBER(5),
constraint student_pk PRIMARY key(name)
);

CREATE TABLE student1
(
ID       VARCHAR2(20),
depart_num VARCHAR2(20),
NAME     VARCHAR2(20),
GRADE      NUMBER(3),
score NUMBER(5),
constraint student_pk PRIMARY key(id)
);

CREATE TABLE teacher
(
name      VARCHAR2(20),
depart_num VARCHAR2(20),
position    VARCHAR2(20),
class_num      NUMBER(3),
lab_num     VARCHAR2(10),
constraint teacher_pk PRIMARY key(name)
);

DESC student;
DESC teacher;
DESC student1;

-- 데이터 각각 5개씩 삽입
insert into student(ID, depart_num, NAME, class_num, score) values ('11223344', 'A-3456', '마스터이', 1, 3.5);
insert into student(ID, depart_num, NAME, class_num, score) values ('10102022', 'B-3136', '베인', 3, 3.8);
insert into student(ID, depart_num, NAME, class_num, score) values ('15674845', 'A-3456', '티모', 2, 4.5);
insert into student(ID, depart_num, NAME, class_num, score) values ('12351361', 'C-1256', '신짜오', 4, 1.2);
insert into student(ID, depart_num, NAME, class_num, grade) values ('13125361', 'A-1426', '미스포춘', 4, 4.3);


insert into student1(ID, depart_num, NAME, GRADE, score) values ('11223344', 'D-3456', '마스터이', 1, 3.5);
insert into student1(ID, depart_num, NAME, GRADE, score) values ('10102022', 'D-3136', '베인', 3, 3.8);
insert into student1(ID, depart_num, NAME, GRADE, score) values ('15674845', 'D-3456', '티모', 2, 4.5);
insert into student1(ID, depart_num, NAME, GRADE, score) values ('12351361', 'D-1256', '신짜오', 4, 1.2);
insert into student1(ID, depart_num, NAME, GRADE, score) values ('13125361', 'D-1426', '미스포춘', 2, 4.3);

insert into teacher(name, depart_num, position, class_num, lab_num) values ('니달리', 'B-3136', '조교수', 3, '201호');
insert into teacher(name, depart_num, position, class_num, lab_num) values ('리신', 'A-3456', '부교수',  4, '203호');
insert into teacher(name, depart_num, position, class_num, lab_num) values ('말파이트', 'A-1426', '교수', 4, '301호');
insert into teacher(name, depart_num, position, class_num, lab_num) values ('피즈', 'C-1256', '부교수',3, '501호');
insert into teacher(name, depart_num, position, class_num, lab_num) values ('아트록스','A-3456', '조교수', 4, '302호');

alter table student1 rename column num to c_num;
alter table student drop column grade;
alter table student1 modify score number(10);
alter table student add grade number(10);
delete from student where id like '13%';


--update 구문
update student set grade = 3.2 where depart_num like '___2%';

update student set grade = 3.8 where name = '홍길동';

update student set grade = replace(grade,null,2.7) where name = '베인';

update student set grade = replace(grade,null,3) where class_num = 2;

update student set name = replace(name, '티모', '갓티모') where class_num = 2;

update student set name = replace(name, '갓갓티모', '갓티모') where grade is null;

SELECT * FROM student;
desc student;

-- 속성 타입 수정, 데이터 값 변경, 속성 이름 변경, 제약조건 추가, SAVEPOINT 2개 포함

alter table student rename column SCORE TO grade; -- 속성 이름 변경
alter table student modify depart_num not null;
ALTER TABLE student1 drop primary key; 
ALTER TABLE student add CONSTRAINT student_pk PRIMARY key(depart_num); -- 제약조건 추가
alter table student modify (grade float); -- 속성 타입 수정
update student set name = '알리스타' where name like '_미'; -- 데이터 값 변경
savepoint sv1;

-- SAVEPOINT 1번으로 ROLLBACK후 동일작업 수행
rollback to sv1;
alter table 

-- SAVEPOINT 2번으로 ROLLBACK 후 동일작업 수행
rollback to sv2;

-- 작업내용을 확정
commit;


select * from  student ;

select * from teacher;

select * from student1;

-- 2개 테이블 JOIN ( INNER JOIN, LEFT , RIGHT, FULL OUTER JOIN)을 수행

-- inner join
SELECT * 
from student s
inner join teacher t 
on(s.depart_num = t.depart_num and s.class_num = t.class_num); -- depart_num이랑 calss_num 같은것만 출력해줌

select
from 조인할 table1
inner join 조인할 table2
on 조인할 속성 매칭 table1.t1 = table2.t2

-- left outer join
-- 겹치는 요소들 먼저 순서대로 출력 후, 안겹치는것들은 null값으로 처리되어 출력
select *
from student s 
left outer join teacher t
on(s.class_num = t.class_num);

-- join할때 from에 넣어준 table이 왼쪽으로 배치된다.
-- left outer join에 넣어준 table은 오른쪽으로 배치된다.
select *
from teacher t
left outer join student s
on(s.class_num = t.class_num);

-- depart_num으로 left outer join 수행
-- usting(조인할 속성)
select *
from teacher t
left outer join student s
using (depart_num);

-- right outer join
select *
from student s
right outer join teacher t
on(s.class_num = t.class_num);
commit;

-- full outer join 
select *
from student s
full outer join teacher t
on s.depart_num = t.depart_num and s.class_num = t.class_num;

select *
from student s
full outer join teacher t
on s.depart_num = t.depart_num
full outer join student1 s1
on t.class_num = t.class_num;


-- 2개 테이블에 대하여 각 조건별로 결과물을 조회하고 그 결과물에 대하여 합집합(중복포함 및 미포함), 교집합, 차집합 출력

--UNION(두 결과를 합치면서 중복 값 제거)
select id, depart_num 학과번호, name 이름, class_num 교실번호
from student
where class_num >= 2
UNION
select id, depart_num 학과번호, name 이름, class_num 교실번호
from student
where depart_num like 'A%';

--UNINON ALL(두 결과를 합치면서 중복 포함)
select id, depart_num 학과번호, name 이름, class_num 교실번호
from student
where class_num >= 2
UNION ALL
select id, depart_num 학과번호, name 이름, class_num 교실번호
from student
where depart_num like 'A%';

--INTERSECT(교집합)
select id, depart_num 학과번호, name 이름, class_num 교실번호
from student
where class_num >= 2
INTERSECT
select id, depart_num 학과번호, name 이름, class_num 교실번호
from student
where depart_num like 'A%';

--MINUS(차집합)
select id, depart_num 학과번호, name 이름, class_num 교실번호
from student
where class_num >= 2
minus
select id, depart_num 학과번호, name 이름, class_num 교실번호
from student
where depart_num like 'A%';