-- TCL (Transaction Control Language)
-- 트랜젝션 제어 언어
-- COMMIT과 ROLLBACK이 있다.

-- 트랜잭션이란?
-- 한꺼번에 수행되여 할 최소의 작업 단위를 의미한다.
-- 논리적 작업 단위 (Logical Unit of Work - LUW) 라고도 한다.
-- 하나의 트랜젝션으로 이루어진 작업은 반드시 한꺼번에 완료 (COMMIT)가 되어야 하며,
-- 그렇지 않은 경우에는 한꺼번에 취소(ROLLBACK) 되어야 한다.

-- COMMIT : 트랜젝션 작업이 정상 완료되면 변경 내용을 영구히 저장
-- ROLLBACK : 트랜젝션 작업을 취소하고 최근 COMMIT한 시점으로 이동
-- SAVEPOINT 세이브포인트명 : 현재 트랜젝션 작업 시점에 구역을 나누고 그 구역에 이름을 정함
-- ROLLBACK TO 세이브포인트명 : 트랜젝션 작업을 취소하고 SAVEPOINT 시점으로 이동

CREATE TABLE TBL_USER(
  USERNO NUMBER UNIQUE,
  ID VARCHAR2(20) PRIMARY KEY,
  PASSWORD CHAR(20) NOT NULL
);

INSERT INTO TBL_USER VALUES (1, 'test01', 'pass01');
INSERT INTO TBL_USER VALUES (2, 'test02', 'pass02');
INSERT INTO TBL_USER VALUES (3, 'test03', 'pass03');

SELECT * FROM TBL_USER;

COMMIT;

INSERT INTO TBL_USER VALUES (4, 'test04', 'pass04');

SELECT * FROM TBL_USER;

ROLLBACK;

SELECT * FROM TBL_USER;

INSERT INTO TBL_USER VALUES (4, 'test04', 'pass04');

SAVEPOINT SP1;

INSERT INTO TBL_USER VALUES (5, 'test05', 'pass05');

SELECT * FROM TBL_USER;

ROLLBACK TO SP1;

SELECT * FROM TBL_USER;

ROLLBACK;

SELECT * FROM TBL_USER;
