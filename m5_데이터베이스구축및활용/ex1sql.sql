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


insert into teacher(name, depart_num, position, class_num, lab_num) values ('니달리', 'B-3136', '조교수', 3, '201호');
insert into teacher(name, depart_num, position, class_num, lab_num) values ('리신', 'A-3456', '부교수',  4, '203호');
insert into teacher(name, depart_num, position, class_num, lab_num) values ('말파이트', 'A-1426', '교수', 4, '301호');
insert into teacher(name, depart_num, position, class_num, lab_num) values ('피즈', 'C-1256', '부교수',3, '501호');
insert into teacher(name, depart_num, position, class_num, lab_num) values ('아트록스','A-3456', '조교수', 4, '302호');

alter table student drop column grade;
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
alter table student modify (grade float ); -- 속성 타입 수정
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

-- 2개 테이블 JOIN ( INNER JOIN, LEFT , RIGHT, FULL OUTER JOIN)을 수행

-- inner join
SELECT * -- 전체 컬럼 선택
from student s
inner join teacher t 
on(s.depart_num = t.depart_num and s.class_num = t.class_num); -- depart_num이랑 calss_num 같은것만 출력해줌

-- left outer join
select *
from student s 
left outer join teacher t
on(s.class_num = t.class_num);

select *
from student s 
left outer join teacher t
on(t.class_num = s.class_num);

select *
from teacher t
left outer join student s
on(s.class_num = t.class_num);


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


-- 2개 테이블에 대하여 각 조건별로 결과물을 조회하고 그 결과물에 대하여 합집합(중복포함 및 미포함), 교집합, 차집합 출력