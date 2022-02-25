-- ÆÄÀÌ½ã ¿¬µ¿
select * from book;

select * from sample1;
drop table sample1;
desc sample1;

desc sample2;
drop table sample2;
select * from sample2;
commit;

desc sample3;
drop table sample3;
select * from sample3;
truncate table sample3;

select * from sample3 where sales >= 10 order by id;