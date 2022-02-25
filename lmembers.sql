
--2014 ~ 2015년 사이의 4개 회사 구매 데이터
SELECT COUNT(*) FROM PURPROD; -- 28593030

--고객 속성정보 : 19383명(고객수)
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

--# 구매 분석(매출 분석)
SELECT YEAR, ROUND(SUM(구매금액)/1000000) as 총구매액, ROUND(AVG(구매금액)) as 평균구매액
FROM PURPROD
GROUP BY YEAR;

--# 고객 속성
--성별, 연령별, 거주지별 다양한 조합별 매출 변화 
--경쟁사 이용, 멤버십 이용, 온라인 채널에 대한 매출 특이성

--# 고객 구매행동 패턴의 변화
--다양한 고객 유형별 구매 증감, 상품 구매 패턴, 구매 형태(시간, 장소 등)

--# 유통 환경에 대한 이해(도매인)

ALTER TABLE PURPROD ADD YEAR NUMBER;
UPDATE PURPROD SET YEAR=substr(구매일자,1,4);
COMMIT;

SELECT * FROM PURPROD;
COMMIT;

CREATE TABLE PURBYYEAR AS
SELECT 고객번호, YEAR, SUM(구매금액) 구매액
FROM PURPROD
GROUP BY 고객번호, YEAR
ORDER BY 고객번호;

SELECT * FROM PURBYYEAR;

CREATE TABLE pur_amt AS
SELECT 고객번호 cusno, sum(구매금액) puramt
FROM PURPROD
GROUP BY 고객번호 
ORDER BY 고객번호;

select count('대분류명') from prodcl;

select * from purprod;

SELECT * FROM PRODCL ORDER BY 제휴사, 대분류코드, 중분류코드, 소분류코드;

-- 공통분류 
UPDATE PRODCL SET 공통분류='식품' WHERE 제휴사='A' AND 대분류코드='1';
UPDATE PRODCL SET 공통분류='시설' WHERE 제휴사='A' AND 대분류코드='1' AND 중분류명='기타';
UPDATE PRODCL SET 공통분류='잡화' WHERE 제휴사='A' AND 대분류코드='1' AND 중분류명='일용잡화';
UPDATE PRODCL SET 공통분류='시설' WHERE 제휴사='A' AND 소분류코드 LIKE 'A01062%';
UPDATE PRODCL SET 공통분류='시설' WHERE 제휴사='A' AND 소분류코드 LIKE 'A01063%';
UPDATE PRODCL SET 공통분류='시설' WHERE 제휴사='A' AND 소분류코드 LIKE 'A01064%';
UPDATE PRODCL SET 공통분류='시설' WHERE 제휴사='A' AND 소분류코드 LIKE 'A01065%';
UPDATE PRODCL SET 공통분류='식품' WHERE 제휴사='A'
AND (소분류코드='A010620' OR 소분류코드='A010621' OR 소분류코드='A010622' OR 소분류코드='A010623'
OR 소분류코드='A010624');
SAVEPOINT SV2;
UPDATE PRODCL SET 공통분류='식품' WHERE 제휴사='D' AND 대분류코드='4' OR 중분류코드='0302';
SELECT*FROM PRODCL WHERE 제휴사='D';

UPDATE PRODCL SET 공통분류='식품' WHERE 제휴사='B' AND (대분류코드='1' OR 대분류코드='2'
OR 대분류코드='3' OR 대분류코드='4' OR 대분류코드='5' OR 대분류코드='6' OR 대분류코드='7' OR "대분류코드"='9'
OR 대분류코드='10' OR 대분류코드='11' OR 대분류코드='12' OR 대분류코드='13' OR 대분류코드='14' OR 대분류코드='15'
OR 대분류코드='16' OR 대분류코드='38' OR 대분류코드='43' OR 대분류코드='46' OR 대분류코드='47' OR 대분류코드='48'
OR 대분류코드='52' OR 대분류코드='53' OR 대분류코드='54' OR 대분류코드='55' OR 대분류코드='56' OR 대분류코드='57'
OR 대분류코드='58' OR 대분류코드='59' OR 대분류코드='60' OR 대분류코드='61' OR 대분류코드='62' OR 대분류코드='64'
OR 대분류코드='65' OR 대분류코드='67' OR 대분류코드='64' OR 대분류코드='72' OR 대분류코드='73' OR 대분류코드='74'
OR 대분류코드='75' OR 대분류코드='76' OR 대분류코드='77' OR 대분류코드='78' OR 대분류코드='79' OR 대분류코드='80'
OR 대분류코드='81' OR 대분류코드='82' OR 대분류코드='83' OR 대분류코드='89' OR 대분류코드='91' OR 대분류코드='92'); 
UPDATE PRODCL SET 공통분류='시설' WHERE 제휴사='B' AND 대분류코드='8';
SAVEPOINT SV3;

update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='1' AND 중분류명='국산과일';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='1' AND 중분류명='수입과일';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='1' AND 중분류명='냉동과일';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='1' AND 중분류명='건과일';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='1' AND 중분류명='견과류';

update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='2' AND 중분류명='양곡';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='2' AND 중분류명='잡곡';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='2' AND 중분류명='선식류';

update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='3' AND 중분류명='엽채류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='3' AND 중분류명='과채류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='3' AND 중분류명='근채류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='3' AND 중분류명='두채류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='3' AND 중분류명='김치채소류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='3' AND 중분류명='버섯류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='3' AND 중분류명='양채류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='3' AND 중분류명='나물류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='3' AND 중분류명='계란류';


update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='4' AND 중분류명='해물류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='4' AND 중분류명='기타수산';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='4' AND 중분류명='선어류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='4' AND 중분류명='선어가공';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='4' AND 중분류명='건어류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='4' AND 중분류명='건어가공';

update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='5' AND 중분류명='국내산우육';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='5' AND 중분류명='국내산돈육';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='5' AND 중분류명='국내산계육';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='5' AND 중분류명='수입우육';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='5' AND 중분류명='수입돈육';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='5' AND 중분류명='기타축산';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='5' AND 중분류명='국내산우육';

update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='6' AND 중분류명='반찬류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='6' AND 중분류명='간편간식';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='6' AND 중분류명='식사류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='6' AND 중분류명='베이커리';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='6' AND 중분류명='기타조리식품';

update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='7' AND 중분류명='우유';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='7' AND 중분류명='발효유';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='7' AND 중분류명='치즈버터';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='7' AND 중분류명='냉장음료';

update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='8' AND 중분류명='냉장농산';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='8' AND 중분류명='냉장수산';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='8' AND 중분류명='냉장축산';

update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='9' AND 중분류명='아이스크림';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='9' AND 중분류명='만두';

update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='10' AND 중분류명='냉장간식MS';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='10' AND 중분류명='냉장식사MS';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='10' AND 중분류명='냉장기타MS';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='10' AND 중분류명='냉농MS';

update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='11' AND 중분류명='생수';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='11' AND 중분류명='탄산음료';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='11' AND 중분류명='과채음료';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='11' AND 중분류명='커피음료';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='11' AND 중분류명='차음료';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='11' AND 중분류명='기능성음료';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='11' AND 중분류명='두유';

update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='12' AND 중분류명='소주';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='12' AND 중분류명='맥주';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='12' AND 중분류명='와인';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='12' AND 중분류명='양주';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='12' AND 중분류명='전통주';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='12' AND 중분류명='기타음주류';

update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='13' AND 중분류명='병통조림';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='13' AND 중분류명='커피류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='13' AND 중분류명='담배';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='13' AND 중분류명='분유';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='13' AND 중분류명='차류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='13' AND 중분류명='건강식품';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='13' AND 중분류명='즉석식품';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='13' AND 중분류명='가공건식품';

update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='14' AND 중분류명='장류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='14' AND 중분류명='식용유';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='14' AND 중분류명='조미료';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='14' AND 중분류명='케첩마요네즈';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='14' AND 중분류명='감미료';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='14' AND 중분류명='가공분말류';

update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='15' AND 중분류명='라면';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='15' AND 중분류명='건면';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='15' AND 중분류명='쿠키케이크';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='15' AND 중분류명='스낵';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='15' AND 중분류명='캔디껌류';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='15' AND 중분류명='초콜렛';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='15' AND 중분류명='전통과자';
update prodcl set 공통분류='식품' where 제휴사 ='C' AND 대분류코드='15' AND 중분류명='씨리얼';

UPDATE PRODCL SET 공통분류='시설' WHERE 제휴사='B' AND 중분류코드='0901';


SELECT*FROM PRODCL WHERE 제휴사='C';

UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='A' AND 중분류코드= '0201';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='A' AND 중분류코드= '0207';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='A' AND 대분류코드= '3';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='A' AND 대분류코드= '4';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='A' AND 대분류코드= '5';
UPDATE PRODCL SET 공통분류=NULL WHERE 소분류코드='A020107' OR 소분류코드='A020109' OR 소분류코드='A020116' OR 소분류코드='A030112'
OR 소분류코드='A030114' OR 소분류코드='A040238' OR 소분류코드='A040240' OR 소분류코드='A040241' OR 소분류코드='A050230' OR 소분류코드='A050224' OR 소분류코드='A050504';
SAVEPOINT SV1;
UPDATE PRODCL SET 공통분류 = '의류' WHERE 제휴사 ='B' AND 소분류코드 LIKE 'B50%' OR 소분류코드 LIKE 'B51%' OR 
소분류코드 LIKE 'B68%' OR "소분류코드" LIKE 'B69%';
UPDATE PRODCL SET 공통분류='시설' WHERE 제휴사='B' AND 대분류코드= '37';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='A' AND 대분류코드='6' AND "중분류명"='스포츠';
UPDATE PRODCL SET 공통분류=NULL WHERE 제휴사='A' AND 대분류코드='6' AND (소분류명='백팩편집'
OR 소분류명='가 방' OR 소분류명='운동용품' OR 소분류명='스포츠용품' OR 소분류명='스키' OR 소분류명='선글라스'
OR 소분류명='배드민턴스퀘어' OR 소분류명='아웃도아');
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='A' AND 중분류명='골프용품' AND (소분류명='N/B골프의류'
OR 소분류명='L/C골프의류' OR 소분류명='직수입 골프의류');



UPDATE PRODCL SET 공통분류=NULL WHERE 소분류코드='B510302' OR 소분류코드='B510303' OR 소분류코드='B510305' OR 소분류코드='B510307'
OR 소분류코드='B510308' OR 소분류코드='B510309';
SAVEPOINT SV2;
UPDATE PRODCL SET 공통분류='의류' WHERE 대분류코드='29';
UPDATE PRODCL SET 공통분류=NULL WHERE 소분류코드='B290101' OR 소분류코드='B290102' OR 소분류코드='B290103' OR 소분류코드='B290201' OR 소분류코드='B290202';
UPDATE PRODCL SET 공통분류='의류' WHERE 대분류코드='30';
UPDATE PRODCL SET 공통분류=NULL WHERE 소분류코드='B300503' ;
UPDATE PRODCL SET 공통분류='의류' WHERE 소분류코드='B320201' OR 소분류코드='B320202' OR 소분류코드='B320203' OR 소분류코드='B320204'OR 소분류코드='B320205';
UPDATE PRODCL SET 공통분류='의류' WHERE 소분류코드='B320301' OR 소분류코드='B320302' OR 소분류코드='B320303' OR 소분류코드='B320304';
UPDATE PRODCL SET 공통분류='의류' WHERE 소분류코드='B320401' OR 소분류코드='B320402' OR 소분류코드='B320403' OR 소분류코드='B320404';
UPDATE PRODCL SET 공통분류='의류' WHERE 소분류코드='B320401' OR 소분류코드='B320402' OR 소분류코드='B320403' OR 소분류코드='B320404';
UPDATE PRODCL SET 공통분류='의류' WHERE 대분류코드='33';
UPDATE PRODCL SET 공통분류='의류' WHERE 소분류코드='B350103' OR 소분류코드='B350201' OR 소분류코드='B350401' OR 소분류코드='B350402' OR 소분류코드='B350403' OR 소분류코드='B350405' OR 소분류코드='B350406';
UPDATE PRODCL SET 공통분류='의류' WHERE 소분류코드='B350504' OR 소분류코드='B350603' OR 소분류코드='B350701' OR 소분류코드='B350702' OR 소분류코드='B350703' OR 소분류코드='B360208';
UPDATE PRODCL SET 공통분류='의류' WHERE 소분류코드='B360501' OR 소분류코드='B360502' OR 소분류코드='B360503' OR 소분류코드='B360801' OR 소분류코드='B360802';
UPDATE PRODCL SET 공통분류='의류' WHERE 소분류코드='B360501' OR 소분류코드='B360502' OR 소분류코드='B360503' OR 소분류코드='B360801' OR 소분류코드='B360802';
UPDATE PRODCL SET 공통분류='의류' WHERE 대분류코드='44';
UPDATE PRODCL SET 공통분류='의류' WHERE 소분류코드='B451502' OR 소분류코드='B451503' OR 소분류코드='B451504';
UPDATE PRODCL SET 공통분류='의류' WHERE 소분류코드='B451601' OR 소분류코드='B451602' OR 소분류코드='B451603';

UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='7004';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='7007';
UPDATE PRODCL SET 공통분류='의류' WHERE 소분류코드='B700601' OR 소분류코드='B700602' OR 소분류코드='B700603' OR 소분류코드='B710201' OR 소분류코드='B710202';





-- 전체 가구
UPDATE PRODCL SET 공통분류='가구' WHERE 제휴사='A' AND 중분류코드='0905';
UPDATE PRODCL SET 공통분류='가구' WHERE 제휴사='A' AND 중분류코드='0906';
UPDATE PRODCL SET 공통분류='가구' WHERE 제휴사='B' AND 중분류코드='2207';
UPDATE PRODCL SET 공통분류='가구' WHERE 제휴사='B' AND 중분류코드='2208';
UPDATE PRODCL SET 공통분류='가구' WHERE 제휴사='B' AND 중분류코드='2209';
UPDATE PRODCL SET 공통분류='가구' WHERE 제휴사='B' AND 중분류코드='2210';
UPDATE PRODCL SET 공통분류='가구' WHERE 제휴사='B' AND 중분류코드='2214';
UPDATE PRODCL SET 공통분류='가구' WHERE 제휴사='B' AND 중분류코드='2301';
UPDATE PRODCL SET 공통분류='가구' WHERE 제휴사='B' AND 중분류코드='2303';
UPDATE PRODCL SET 공통분류='가구' WHERE 제휴사='B' AND 중분류코드='2304';
UPDATE PRODCL SET 공통분류='가구' WHERE 제휴사='B' AND 중분류코드='2305';
UPDATE PRODCL SET 공통분류='가구' WHERE 제휴사='B' AND 대분류코드='88';
UPDATE PRODCL SET 공통분류='가구' WHERE 소분류코드='B220301' OR 소분류코드='B220302' OR 소분류코드='C170438';

UPDATE PRODCL SET 공통분류=NULL WHERE 소분류코드='B230403' OR 소분류코드='B230404' OR 소분류코드='B230407' OR 소분류코드='B230503';

-- B, C 의류 일부 추가했어용
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 대분류코드='49';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='4513';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='C' AND 중분류코드='1704';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='C' AND 소분류코드='B451501';
UPDATE PRODCL SET 공통분류=NULL WHERE 소분류코드='C170422' OR 소분류코드='C170423' OR 소분류코드='C170427' OR 소분류코드='C170428'
OR 소분류코드='C170429' OR 소분류코드='C170430' OR 소분류코드='C170431' OR 소분류코드='C170432' OR 소분류코드='C170433' OR 소분류코드='C170434'
OR 소분류코드='C170435' OR 소분류코드='C170436' OR 소분류코드='C170437' OR 소분류코드='A090606' OR 소분류코드='A090608';
SAVEPOINT S1;

UPDATE PRODCL SET 공통분류='화장품' WHERE 중분류코드='0203';

SELECT * FROM PRODCL WHERE "제휴사" = 'A' ORDER BY 대분류코드;

UPDATE PRODCL SET 공통분류=NULL WHERE 제휴사='A' AND 대분류코드='2' AND (소분류명='기타');
---------------------------------------------------------------------------------------
SELECT * FROM PRODCL WHERE "제휴사" = 'B' ORDER BY 대분류코드;

UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='19' AND (소분류명='염색약') AND (소분류명='샴푸')AND(소분류명='린스')AND (소분류명='헤어스타일링')AND (소분류명='새치용염색약')AND (소분류명='칼라용염색약');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='19' AND (소분류명='온라인헤어스타일링') AND (소분류명='온라인 헤어용품')AND (소분류명='미용비누')AND (소분류명='바디클린져')AND (소분류명='훼이셜클린져')AND (소분류명='핸드워시');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='19' AND (소분류명='바디스킨케어') AND (소분류명='유아스킨케어')AND (소분류명='훼이셜스킨케어')AND (소분류명='온라인 스킨케어')AND (소분류명='바디용품선물세트')AND (소분류명='브랜드세트');

UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='19' AND (소분류명='일반샴푸단품') AND (소분류명='일반린스단품')AND (소분류명='온라인일반헤어케어')AND (소분류명='프리미엄샴푸')AND (소분류명='모발영양케어');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='19' AND (소분류명='모근/한방샴푸') AND (소분류명='두피샴푸')AND (소분류명='내추럴샴푸');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='34' AND (소분류명='남성화장수') AND (소분류명='여성화장수')AND (소분류명='기능성화장품')AND (소분류명='크린싱/맛사지')AND (소분류명='색조화장품');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='34' AND (소분류명='헤어/바디케어') AND (소분류명='중저가화장품기타')AND (소분류명='바디용품')or (소분류명='헤어용품')AND (소분류명='기타아로마용품');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='34' AND (소분류명='온라인 화장품') AND (소분류명='미용소품')AND (소분류명='미용대품')AND (소분류명='아로마용품')AND (소분류명='기타아로마용품');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='66' AND (소분류명='남성바디케어') OR (소분류명='남성헤어케어')OR (소분류명='남성훼이셜케어')OR (소분류명='기타 바디케어')OR (소분류명='바디스킨케어');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='66' AND (소분류명='마스크팩') OR (소분류명='성인스킨케어')OR (소분류명='온라인스킨케어')OR (소분류명='코스메슈티컬')OR (소분류명='틴스킨케어');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='66' AND (소분류명='훼이셜클렌저') OR (소분류명='베이비스킨케어')OR (소분류명='베이비클렌저')OR (소분류명='코스메슈티컬')OR (소분류명='임산부케어');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='66' AND (소분류명='네일케어') OR (소분류명='풋케어')OR (소분류명='핸드케어')OR (소분류명='기타미용소품')OR (소분류명='메이크업브러쉬');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='66' AND (소분류명='메탈') OR (소분류명='분첩')OR (소분류명='여행용품')OR (소분류명='용기')OR (소분류명='클렌징');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='66' AND (소분류명='헤어브러쉬/거울') OR (소분류명='화장솜/면봉')OR (소분류명='디퓨져')OR (소분류명='방향제')OR (소분류명='입욕제');
UPDATE PRODCL SET 공통분류=null WHERE 제휴사='B' AND 대분류코드='70' AND (소분류명='여행용품') ;
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='70' AND (소분류명='향수') ;
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='86' AND (소분류명='샤워타월') OR (소분류명='욕실수납용품');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='90' AND (소분류명='남성화장품') OR (소분류명='여성화장품')OR (소분류명='일반화장품')OR (소분류명='기타색조화장품')OR (소분류명='네일');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='90' AND (소분류명='립') OR (소분류명='베이스')OR (소분류명='블러셔')OR (소분류명='아이')OR (소분류명='온라인화장품');
---------------------------

SELECT * FROM PRODCL WHERE "제휴사" = 'C' ORDER BY 대분류코드;

UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='C' AND 대분류코드='16' or (소분류명='아이케어') OR (소분류명='크림/밤/오일')OR (소분류명='페이셜팩류')OR (소분류명='스킨케어세트')OR (소분류명='BB/파운데이션/컴팩트류');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='C' AND 대분류코드='16' or (소분류명='마스카라') OR (소분류명='립스틱/립라이너')OR (소분류명='립글로즈/틴트')OR (소분류명='일반네일/케어류')OR (소분류명='메탈미용소도구');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='C' AND 대분류코드='16' or (소분류명='스폰지/퍼프') OR (소분류명='풋케어도구')OR (소분류명='면봉/화장솜')OR (소분류명='남녀공용향수')OR (소분류명='린스/컨디셔너');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='C' AND 대분류코드='16' or (소분류명='샴푸/린스세트') OR (소분류명='트리트먼트/팩')OR (소분류명='헤어에센스')OR (소분류명='헤어스프레이')OR (소분류명='헤어무스/젤');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='C' AND 대분류코드='16' or (소분류명='헤어왁스') OR (소분류명='염모제');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='C' AND 대분류코드='16' or (소분류명='바디워시') OR (소분류명='바디보습')OR (소분류명='제모용품')OR (소분류명='바디패치/팩')OR (소분류명='핸드워시/손세정제')OR (소분류명='핸드로션/크림');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='C' AND 대분류코드='16' or (소분류명='핸드/풋케어세트') OR (소분류명='여성세정제')OR (소분류명='페이셜클렌저')OR (소분류명='스킨/토너')OR (소분류명='립밤/립스크럽')OR (소분류명='선크림류');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='C' AND 대분류코드='16' or (소분류명='유아용화장품') OR (소분류명='유아용샴푸/바디워시')OR (소분류명='립밤/립스크럽')OR (소분류명='유아목욕용품');
-----------------------------------------------

SELECT * FROM PRODCL WHERE "제휴사" = 'D' ORDER BY 대분류코드;
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='D' AND 대분류코드='1' or (소분류명='미스트') OR (소분류명='에멀젼/로션')OR (소분류명='에센스/세럼')OR (소분류명='아이케어')OR (소분류명='크림/밤/오일')OR (소분류명='스킨케어세트');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='D' AND 대분류코드='1' or (소분류명='태닝/애프터선케어') OR (소분류명='남성용클렌저')OR (소분류명='남성용스킨케어류')OR (소분류명='남성스킨케어세트')OR (소분류명='남성용선크림/메이크업류')OR (소분류명='유아용화장품');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='D' AND 대분류코드='1' or (소분류명='기저귀크림/파우더') OR (소분류명='유아용샴푸/바디워시')OR (소분류명='유아목욕용품');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='D' AND 대분류코드='2' or (소분류명='린스/컨디셔너') OR (소분류명='트리트먼트/팩')OR (소분류명='헤어에센스')OR (소분류명='헤어스프레이')OR (소분류명='헤어무스/젤')OR (소분류명='헤어왁스')OR (소분류명='염모제');
UPDATE PRODCL SET 공통분류=null WHERE 제휴사='D' AND 대분류코드='2' or (소분류명='치약/칫솔세트') OR (소분류명='생리대')OR (소분류명='탐폰')OR (소분류명='팬티라이너');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='D' AND 대분류코드='2' or (소분류명='바디워시') OR (소분류명='바디보습')OR (소분류명='입욕제/스파제품')OR (소분류명='바디케어세트')OR (소분류명='바디슬리밍/리프팅')OR (소분류명='제모용품')OR (소분류명='데오도란트');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='D' AND 대분류코드='2' or (소분류명='핸드워시/손세정제') OR (소분류명='핸드로션/크림')OR (소분류명='풋케어')OR (소분류명='풋케어도구');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='D' AND 대분류코드='6' or (소분류명='네일케어도구') OR (소분류명='속눈썹/쌍꺼풀')OR (소분류명='기름종이');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='D' AND 대분류코드='7' or (소분류명='남성향수') OR (소분류명='여성향수');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='D' AND 대분류코드='8' or (소분류명='아이섀도우') OR (소분류명='마스카라')OR (소분류명='아이브로우')OR (소분류명='아이라이너')OR (소분류명='블러셔/쉐이딩/하이라이터')OR (소분류명='메이크업베이스/프라이머')OR (소분류명='메이크업세트');

UPDATE PRODCL 
SET 공통분류 = '스포츠'
WHERE 공통분류 IS NULL AND (중분류명 LIKE 'S%' OR 중분류명 LIKE '_터%' OR 중분류명 LIKE '낚시' OR 중분류명  LIKE '등산' OR 
중분류명 LIKE '롤러보드' OR 중분류명 LIKE '라켓스포츠' OR 중분류명 LIKE '롤러보드' OR 중분류명 LIKE '구기용품'
OR 중분류명 LIKE '헬스용품' OR 중분류명 LIKE '자전거' OR 중분류명 LIKE '스포츠%' OR 중분류명 LIKE '스키'
OR 중분류명 LIKE '골프용품');

UPDATE PRODCL SET 공통분류 = '의류' WHERE 제휴사 ='B' AND 대분류코드='70' AND ("중분류명"='모자' OR 중분류명='장갑');
UPDATE PRODCL SET 공통분류='화장품' WHERE 제휴사='B' AND 대분류코드='19' AND (중분류명='헤어스타일링');

UPDATE prodcl set 공통분류='전자제품' WHERE 제휴사='A' AND ("중분류명"='대형가전' OR "중분류명"='소형가전'
OR "중분류명"='전자/전기' OR "중분류명"='주방가전' OR "중분류명"='통신/컴퓨터');

UPDATE prodcl set 공통분류='전자제품' WHERE 제휴사='B' AND ("중분류명"='기타전자완구'
OR "중분류명"='비디오게임기' OR "중분류명"='DVD' OR "중분류명"='김치냉장고' OR "중분류명"='냉장고' OR "중분류명"='세탁기'
OR "중분류명"='오디오' OR "중분류명"='홈시어터' OR "중분류명"='가습기' OR "중분류명"='공기청정기' OR "중분류명"='선풍기'
OR "중분류명"='에어컨' OR "중분류명"='전기요/장판' OR "중분류명"='정수기' OR "중분류명"='히터기' OR "중분류명"='기타주방가전'
OR "중분류명"='믹서기' OR "중분류명"='밥솥' OR "중분류명"='생활소형가전' OR "중분류명"='전기포트' OR "중분류명"='조리기'
OR "중분류명"='주방소형가전' OR "중분류명"='청소기' OR "중분류명"='커피메이커/머신' OR "중분류명"='MP3/PMP' OR "중분류명"='PC'
OR "중분류명"='전기면도기' OR "중분류명"='전자악기' OR "중분류명"='전자사전' OR "중분류명"='전화기/팩스' OR "중분류명"='컴퓨터주변기기'
OR "중분류명"='시즌/건강가전' OR "중분류명"='주방가전');
UPDATE prodcl set 공통분류='전자제품' WHERE 제휴사='B' AND "중분류명"='TV' AND ("소분류명"='LED TV');
UPDATE prodcl set 공통분류='전자제품' WHERE 제휴사='B' AND "중분류명"='건강가전' AND ("소분류명"='비데' OR "소분류명"='치솔살균기'
OR "소분류명"='안마의자' OR "소분류명"='전기안마기');
UPDATE prodcl set 공통분류='전자제품' WHERE 제휴사='B' AND "중분류명"='NAVI/하이패스' AND ("소분류명"='네비게이션');
UPDATE prodcl set 공통분류='전자제품' WHERE 제휴사='B' AND "중분류명"='건강디지털기기' AND ("소분류명"='전동칫솔');
UPDATE prodcl set 공통분류='전자제품' WHERE 제휴사='B' AND "중분류명"='기타음향기기' AND ("소분류명"='녹음기/라디오');
UPDATE prodcl set 공통분류='전자제품' WHERE 제휴사='B' AND "중분류명"='카메라/캠코더' AND ("소분류명"='녹음기/라디오' OR 
"소분류명"='기타 카메라');
UPDATE prodcl set 공통분류='전자제품' WHERE 제휴사='B' AND "중분류명"='안전용품' AND ("소분류명"='도어락');
UPDATE prodcl set 공통분류='전자제품' WHERE 제휴사='C' AND 대분류코드='17' AND "중분류명"='전기전자' AND ("소분류명"='선풍기'
OR 소분류명='히터' OR 소분류명='온풍기' OR 소분류명='라디에이터' OR 소분류명='전기요' OR 소분류명='전기매트' OR 소분류명='온수매트'
OR 소분류명='기타난방가전' OR 소분류명='선풍기' OR 소분류명='제습기' OR 소분류명='가습기' OR 소분류명='공기청정기' OR 소분류명='핸디형청소기'
OR 소분류명='기타청소기' OR 소분류명='전화기' OR 소분류명='다리미' OR 소분류명='헤어드라이어' OR 소분류명='고데기' OR 소분류명='기타이미용가전'
OR 소분류명='전기밥솥' OR 소분류명='오븐/전자레인지' OR 소분류명='인덕션/가스레인지' OR 소분류명='블랜더' OR 소분류명='히터' OR 소분류명='토스터/제빵기'
OR 소분류명='요구르트/청국장제조기' OR 소분류명='기타주방가전' OR 소분류명='저장장치' OR 소분류명='키보드' OR 소분류명='마우스' OR 소분류명='스피커'
OR 소분류명='공유기' OR 소분류명='건강마스크' OR 소분류명='녹즙기/원액기' OR 소분류명='체중계/신장계');

UPDATE prodcl set 공통분류=NULL WHERE "제휴사"='B' AND "중분류명"='히터기' AND "소분류명"='기타';
UPDATE prodcl set 공통분류=NULL WHERE "제휴사"='B' AND "중분류명"='기타주방가전' AND "소분류명"='기타소모품';
UPDATE prodcl set 공통분류=NULL WHERE "제휴사"='B' AND "중분류명"='청소기' AND 소분류명='청소기소품';
UPDATE prodcl set 공통분류=NULL WHERE "제휴사"='B' AND "중분류명"='컴퓨터주변기기' AND 소분류명='잉크';
UPDATE prodcl set 공통분류=NULL WHERE "제휴사"='B' AND "중분류명"='컴퓨터주변기기' AND 소분류명='기타소모품';
UPDATE prodcl set 공통분류=NULL WHERE "제휴사"='B' AND "중분류명"='컴퓨터주변기기' AND 소분류명='컴퓨터소품';
SAVEPOINT S2;


--총 악세사리 
--A 악세사리 
SELECT * FROM PRODCL WHERE "제휴사" = 'A' ORDER BY 대분류코드;
UPDATE PRODCL SET 공통분류='악세사리' WHERE 제휴사='A' AND 중분류코드='0202'; 
UPDATE PRODCL SET 공통분류='악세사리' WHERE 제휴사='A' AND 중분류코드='0204';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 제휴사='A' AND 중분류코드='0205';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 제휴사='A' AND 중분류코드='0206';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 제휴사='A' AND 중분류코드='0801';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 소분류코드='A040240' OR 소분류코드='A060105' OR 소분류코드='A060111';

UPDATE PRODCL SET 공통분류='의류' WHERE 소분류코드='A020609' OR 소분류코드='A080103' OR 소분류코드='A080114' OR 소분류코드='A080115' OR 소분류코드= 'A060102'  OR 소분류코드= 'A060105'  OR 소분류코드= 'A060111';
UPDATE PRODCL SET 공통분류=NULL WHERE 소분류코드='A020606'  OR 소분류코드='A080101' OR 소분류코드='A080104' OR 소분류코드= 'A080110' OR 소분류코드='A080111' OR 소분류코드='A080112' OR 소분류코드='A080112' OR 소분류코드='A080113';
UPDATE PRODCL SET 공통분류=NULL WHERE 소분류코드='A080121'  OR 소분류코드='A080122' OR 소분류코드='A080123' OR 소분류코드= 'A080124' OR 소분류코드='A080125';

--B 악세사리 
SELECT * FROM PRODCL WHERE "제휴사" = 'B' ORDER BY 대분류코드;
UPDATE PRODCL SET 공통분류='악세사리' WHERE 소분류코드='B290201' OR 소분류코드='A060105' OR 소분류코드='A060111' OR 소분류코드='B360504' OR 소분류코드='B360505' OR 소분류코드='B451505';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 소분류코드='B451801' OR 소분류코드='B451802' OR 소분류코드='B451803' OR 소분류코드='B450101' OR 소분류코드='B450102' OR 소분류코드='B450103' OR 소분류코드='B450104' OR 소분류코드='B450105';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 소분류코드='B450201' OR 소분류코드='B450202' OR 소분류코드='B450205' OR 소분류코드='B450206'  OR 소분류코드='B700301' OR 소분류코드='B710203';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 제휴사='B' AND 중분류코드='4503';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 제휴사='B' AND 중분류코드='4504';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 제휴사='B' AND 중분류코드='4505';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 제휴사='B' AND 중분류코드='4507';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 제휴사='B' AND 중분류코드='4508';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 제휴사='B' AND 중분류코드='4509';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 제휴사='B' AND 중분류코드='4510';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 제휴사='B' AND 중분류코드='4511';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 제휴사='B' AND 중분류코드='4512';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 제휴사='B' AND 중분류코드='7001';
UPDATE PRODCL SET 공통분류='악세사리' WHERE 제휴사='B' AND 중분류코드='7002';

UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='5002';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='5003';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='5004';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='5005';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='6801';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='6802';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='6803';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='6804';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='6805';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='6806';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='6808';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='6901';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='6902';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='6903';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='6904';
UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='B' AND 중분류코드='7004';
UPDATE PRODCL SET 공통분류='의류' WHERE 소분류코드='B510306' OR 소분류코드='B510304' OR 소분류코드='B080114' OR 소분류코드='B080115' OR 소분류코드= 'B060102'  OR 소분류코드= 'B060105'  OR 소분류코드= 'B060111';
UPDATE PRODCL SET 공통분류=NULL WHERE 소분류코드='B450301'  OR 소분류코드='B450306' OR 소분류코드='B450307' OR 소분류코드= 'B450308' OR 소분류코드='B450309' OR 소분류코드='B450311' OR 소분류코드='B450701';

--C 악세사리
SELECT * FROM PRODCL WHERE "제휴사" = 'C' ORDER BY 대분류코드;
UPDATE PRODCL SET 공통분류='악세사리' WHERE 소분류코드='C170422' OR 소분류코드='C170423' OR 소분류코드='C170435' OR 소분류코드='B360504' OR 소분류코드='B360505' OR 소분류코드='B451505';

--D 악세사리
SELECT * FROM PRODCL WHERE "제휴사" = 'D' ORDER BY 대분류코드;
UPDATE PRODCL SET 공통분류='악세사리' WHERE 소분류코드='C170422' OR 소분류코드='C170423' OR 소분류코드='C170435' OR 소분류코드='B360504' OR 소분류코드='B360505' OR 소분류코드='B451505';

UPDATE PRODCL SET 공통분류='의류' WHERE 제휴사='D' AND 중분류코드='0602';

SELECT * FROM PRODCL ORDER BY 제휴사, 대분류코드, 중분류코드, 소분류코드;
SELECT COUNT(*) FROM PRODCL WHERE 공통분류 IS NULL;

COMMIT;