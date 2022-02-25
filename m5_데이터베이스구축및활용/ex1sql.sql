-- ���̺� 2�� ���� (���� ���� ����)
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

-- ������ ���� 5���� ����
insert into student(ID, depart_num, NAME, class_num, score) values ('11223344', 'A-3456', '��������', 1, 3.5);
insert into student(ID, depart_num, NAME, class_num, score) values ('10102022', 'B-3136', '����', 3, 3.8);
insert into student(ID, depart_num, NAME, class_num, score) values ('15674845', 'A-3456', 'Ƽ��', 2, 4.5);
insert into student(ID, depart_num, NAME, class_num, score) values ('12351361', 'C-1256', '��¥��', 4, 1.2);
insert into student(ID, depart_num, NAME, class_num, grade) values ('13125361', 'A-1426', '�̽�����', 4, 4.3);


insert into teacher(name, depart_num, position, class_num, lab_num) values ('�ϴ޸�', 'B-3136', '������', 3, '201ȣ');
insert into teacher(name, depart_num, position, class_num, lab_num) values ('����', 'A-3456', '�α���',  4, '203ȣ');
insert into teacher(name, depart_num, position, class_num, lab_num) values ('������Ʈ', 'A-1426', '����', 4, '301ȣ');
insert into teacher(name, depart_num, position, class_num, lab_num) values ('����', 'C-1256', '�α���',3, '501ȣ');
insert into teacher(name, depart_num, position, class_num, lab_num) values ('��Ʈ�Ͻ�','A-3456', '������', 4, '302ȣ');

alter table student drop column grade;
alter table student add grade number(10);
delete from student where id like '13%';
--update ����
update student set grade = 3.2 where depart_num like '___2%';

update student set grade = 3.8 where name = 'ȫ�浿';

update student set grade = replace(grade,null,2.7) where name = '����';

update student set grade = replace(grade,null,3) where class_num = 2;

update student set name = replace(name, 'Ƽ��', '��Ƽ��') where class_num = 2;

update student set name = replace(name, '����Ƽ��', '��Ƽ��') where grade is null;

SELECT * FROM student;
desc student;

-- �Ӽ� Ÿ�� ����, ������ �� ����, �Ӽ� �̸� ����, �������� �߰�, SAVEPOINT 2�� ����

alter table student rename column SCORE TO grade; -- �Ӽ� �̸� ����
alter table student modify depart_num not null;
ALTER TABLE student1 drop primary key; 
ALTER TABLE student add CONSTRAINT student_pk PRIMARY key(depart_num); -- �������� �߰�
alter table student modify (grade float ); -- �Ӽ� Ÿ�� ����
update student set name = '�˸���Ÿ' where name like '_��'; -- ������ �� ����
savepoint sv1;

-- SAVEPOINT 1������ ROLLBACK�� �����۾� ����
rollback to sv1;
alter table 

-- SAVEPOINT 2������ ROLLBACK �� �����۾� ����
rollback to sv2;

-- �۾������� Ȯ��
commit;


select * from  student ;

select * from teacher;

-- 2�� ���̺� JOIN ( INNER JOIN, LEFT , RIGHT, FULL OUTER JOIN)�� ����

-- inner join
SELECT * -- ��ü �÷� ����
from student s
inner join teacher t 
on(s.depart_num = t.depart_num and s.class_num = t.class_num); -- depart_num�̶� calss_num �����͸� �������

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


-- 2�� ���̺� ���Ͽ� �� ���Ǻ��� ������� ��ȸ�ϰ� �� ������� ���Ͽ� ������(�ߺ����� �� ������), ������, ������ ���