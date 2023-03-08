
call 통계(@a, @b);
SELECT @a AS 학생수,  @b AS 과목수;


-- 수강신청내역 테이블에서 과목별로 수강자수를 반환하는 저장 프로시저를 작성
call 과목수강자수('k20002', @Count);
select @Count;

-- 수강신청내역 테이블에서 과목별로 수강자수를 반환하는 저장 프로시저를 작성
call 새수강신청('1804003', @수강신청번호);
select @수강신청번호;


delimiter //
CREATE PROCEDURE Interest()
BEGIN
DECLARE myInterest INTEGER DEFAULT 0.0;
DECLARE Price INTEGER;
DECLARE endOfRow BOOLEAN DEFAULT FALSE; /* 행의 끝 여부 */
DECLARE InterestCursor CURSOR FOR /* 커서 선언 */
SELECT saleprice FROM Orders;
DECLARE CONTINUE handler			/* 행의 끝일 때 handler 정의 */
FOR NOT FOUND SET endOfRow=TRUE;
OPEN InterestCursor; /* 커서 열기 */
cursor_loop: LOOP
FETCH InterestCursor INTO Price;
IF endOfRow THEN LEAVE cursor_loop;
END IF;
IF Price >= 30000 THEN
SET myInterest = myInterest + Price * 0.1;
ELSE
SET myInterest = myInterest + Price * 0.05;
END IF;
END LOOP cursor_loop;
CLOSE InterestCursor;
SELECT CONCAT(' 전체 이익 금액 = ', myInterest);
END;
//
delimiter ;
CALL Interest();

SELECT saleprice FROM Orders;

-- trigger
-- data 변경 문
-- before trigger after trigger

/* madang 계정에서 실습을 위한 Book_log 테이블 생성해준다. */
CREATE TABLE Book_log(
bookid_l INTEGER,
bookname_l VARCHAR(40),
publisher_l VARCHAR(40),
price_l INTEGER);

/* trigger 구문. table 아래에 생김 */
delimiter //
CREATE TRIGGER AfterInsertBook
AFTER INSERT ON Book FOR EACH ROW
BEGIN
DECLARE average INTEGER;
INSERT INTO Book_log
VALUES(new.bookid, new.bookname, new.publisher, new.price);
END;
//
delimiter ;

INSERT INTO Book VALUES(14, '스포츠 과학 1', '이상미디어', 25000, null);
SELECT * FROM Book WHERE BOOKID=14;
SELECT * FROM Book_log WHERE BOOKID_L='14' ; -- AfterInsertBook결과 확인


-- 상품 테이블 작성
CREATE TABLE 상품 (
상품코드 VARCHAR(6) NOT NULL PRIMARY KEY
  ,상품명 VARCHAR(30) NOT NULL
  ,제조사 VARCHAR(30) NOT NULL
  ,소비자가격 int 
  ,재고수량 int DEFAULT 0
);

-- 입고 테이블 작성
CREATE TABLE 입고 (
   입고번호 int PRIMARY KEY
  ,상품코드 VARCHAR(6) NOT NULL
  ,입고일자 date
  ,입고수량 int
  ,입고단가 int
);

-- 판매 테이블 작성
CREATE TABLE 판매 (
   판매번호      int  PRIMARY KEY
  ,상품코드      VARCHAR(6) NOT NULL 
  ,판매일자      DATE
  ,판매수량      int
  ,판매단가      int
);

-- 상품 테이블에 자료 추가
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('AAAAAA', '디카', '삼싱', 100000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('BBBBBB', '컴퓨터', '엘디', 1500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('CCCCCC', '모니터', '삼싱', 600000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
        ('DDDDDD', '핸드폰', '다우', 500000);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
         ('EEEEEE', '프린터', '삼싱', 200000);
COMMIT;
SELECT * FROM 상품;

-- 입고와 판매에 따라 재고수량이 달라져야함

/* madang 계정에서 실습을 위한 Book_log 테이블 생성해준다. */
/*
CREATE TABLE Inoutput_log(
상품코드 varchar(6),
재고수량 int,
입고 enum ('Y', 'N') default null,
판매 enum ('Y', 'N') default null);
*/

-- 입고 수량만큼 더해서 상품에 반영
delimiter //
CREATE TRIGGER AfterInput
AFTER INSERT ON 입고 FOR EACH ROW
BEGIN
DECLARE x INTEGER;
set x = new.입고수량;
UPDATE 상품 SET 재고수량 = 재고수량 + x where 상품.상품코드 = new.상품코드;
END;
//
delimiter ;
insert into 입고 values (1, 'AAAAAA', curdate(), 10, 50000);


-- 판매 수량만큼 빼서 상품에 반영
delimiter //
CREATE TRIGGER AfterOutput
AFTER INSERT ON 판매 FOR EACH ROW
BEGIN
DECLARE x INTEGER;
set x = new.판매수량;
UPDATE 상품 SET 재고수량 = 재고수량 - x where 상품.상품코드 = new.상품코드;
END;
//
delimiter ;
insert into 판매 values (1, 'AAAAAA', curdate(), 3, 50000);
