-- DML(Data Manupulation Language)
-- INSERT, UPDATE, DELETE
-- : 데이터 조작 언어, 테이블에 데이터를 삽입하거나 수정하거나 삭제하는 언어

-- INSERT : 새로운 행을 추가하는 구문이다.
--          테이블의 행 갯수가 증가한다.

-- [표현식]
-- 테이블의 일부 컬럼에 INSERT할 때
-- INSERT INTO 테이블명 (컬럼명, 컬럼명, ...) VALUE (데이터, 데이터, ...);

-- 테이블의 모든 컬럼에 INSERT 할 때
-- INSERT INTO 테이블명 VALUE (데이터, 데이터, ...);

-- 모든 컬럼에 INSERT 할 때도 컬럼명을 기술하는 것이 의미 파악에 좋다.

SELECT * FROM EMPLOYEE;

INSERT
    INTO EMPLOYEE E
(
   E.EMP_ID, E.EMP_NAME, E.EMP_NO, E.EMAIL, E.PHONE
 , E.DEPT_CODE, E.JOB_CODE, E.SAL_LEVEL, E.SALARY, E.BONUS
 , E.MANAGER_ID, E.HIRE_DATE, E.ENT_DATE
)
VALUES
(
   '900', '장채현', '001123-1080503', 'jang_ch@greedy.com', '01055556666'
 , 'D1', 'J7', 'S3', 43000, 0.2
 , '200', SYSDATE, NULL
 );
 
 SELECT * FROM EMPLOYEE;
 
 ROLLBACK;
 
 COMMIT;
 
 -- INSERT 시 VALUES 대신 서브쿼리를 이용할 수 있다.
 CREATE TABLE EMP_01(
   EMP_ID NUMBER,
   EMP_NAME VARCHAR2(30),
   DEPT_TITLE VARCHAR2(20)
);

SELECT E.* FROM EMP_01 E;

INSERT
    INTO EMP_01 A
(
  A.EMP_ID
, A.EMP_NAME
, A.DEPT_TITLE
)
(
    SELECT E.EMP_ID
         , E.EMP_NAME
         , D.DEPT_TITLE
      FROM EMPLOYEE E
      LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
);

SELECT E.* FROM EMP_01 E;

-- INSERT ALL : INSERT 시에는 사용하는 서브쿼리가 같은 경우
--              두 개 이상의 테이블에 INSERT ALL을 이용하여
--              한 번에 데이터를 삽입할 수 있다
--              단, 각 서브쿼리의 조건절이 같아야 한다.
CREATE TABLE EMP_DEPT_01
AS
SELECT E.EMP_ID
     , E.EMP_NAME
     , E.DEPT_CODE
     , E.HIRE_DATE
  FROM EMPLOYEE E
 WHERE 1 = 0;
 
SELECT * FROM EMP_DEPT_01;

CREATE TABLE EMP_MANAGER
AS
SELECT E.EMP_ID
     , E.EMP_NAME
     , E.MANAGER_ID
  FROM EMPLOYEE E
 WHERE 1 = 0;

SELECT * FROM EMP_MANAGER;

-- EMP_DEPT_D1 테이블에 EMPLOYEE 테이블에서 부서코드가 D1인 직원을 조회하여
-- 사번, 이름, 소속부서, 입사일을 삽입하고
-- EMP_MANAGER 테이블에 EMPLOYEE 테이블에 있는 부서코드가 D1인 직원을 조회하여
-- 사번, 이름, 관리자 사번을 조회해서 삽입하세요
INSERT ALL
    INTO EMP_DEPT_01
VALUES
(
  EMP_ID
, EMP_NAME
, DEPT_CODE
, HIRE_DATE
)
    INTO EMP_MANAGER
VALUES
(
  EMP_ID
, EMP_NAME
, MANAGER_ID
)

SELECT E.EMP_ID
     , E.EMP_NAME
     , E.DEPT_CODE
     , E.HIRE_DATE
     , E.MANAGER_ID
  FROM EMPLOYEE E
 WHERE E.DEPT_CODE = 'D1';

SELECT * FROM EMP_DEPT_01;
SELECT * FROM EMP_MANAGER;

-- EMPLOYEE 테이블에서 입사일 기준으로 2000년 1월 1일 이전에 입사한 사원
-- 사번, 이름, 입사일, 급여를 조회하여 EMP_OLD 테이블에 삽입하고
-- 그 이후에 입사한 사원은 EMP_NEW 테이블에 삽입하세요
CREATE TABLE EMP_OLD
AS
SELECT E.EMP_ID
     , E.EMP_NAME
     , E.HIRE_DATE
     , E.SALARY
  FROM EMPLOYEE E
 WHERE 1 = 0;
 
CREATE TABLE EMP_NEW
AS
SELECT E.EMP_ID
     , E.EMP_NAME
     , E.HIRE_DATE
     , E.SALARY
  FROM EMPLOYEE E
 WHERE 1 = 0;
 
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

INSERT ALL
   WHEN HIRE_DATE < '2000/01/01'
   THEN
   INTO EMP_OLD
VALUES
(
  EMP_ID
, EMP_NAME
, HIRE_DATE
, SALARY
)
    WHEN HIRE_DATE >= '2000/01/01'
    THEN
    INTO EMP_NEW
VALUES
(
  EMP_ID, EMP_NAME, HIRE_DATE, SALARY
)
SELECT E.EMP_ID
     , E.EMP_NAME
     , E.HIRE_DATE
     , E.SALARY
  FROM EMPLOYEE E;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

-- UPDATE : 테이블에 기론된 컬럼의 값을 수정하는 구문이다.
--          테이블의 전체 행 갯수는 변화가 없다.
CREATE TABLE DEPT_COPY
AS
SELECT D.*
  FROM DEPARTMENT D;

SELECT * FROM DEPT_COPY;

-- UPDATE 테이블명 SET 컬럼명 = 바꿀값, 컬럼명 = 바꿀값, ...
-- [WHERE 조건식]
UPDATE
        DEPT_COPY DC
    SET DC.DEPT_TITLE = '전략기획팀'
  WHERE DC.DEPT_ID = 'D9';

-- UPDATE 시에도 서브쿼리를 이용할 수 있다.
-- UPDATE 테이블명
-- SET 컬럼명 = (서브쿼리)
CREATE TABLE EMP_SALARY
AS
SELECT E.EMP_ID
     , E.EMP_NAME
     , E.DEPT_CODE
     , E.SALARY
     , E.BONUS
  FROM EMPLOYEE E;
  
SELECT * FROM EMP_SALARY;

SELECT
        ES.*
   FROM EMP_SALARY ES
  WHERE ES.EMP_NAME IN ('유재식', '방명수');

-- 평상시 유재식 사원을 부러워하는 방명수 사원의 급여와 보너스를
-- 유재식 사원과 동일하게 변경해주기로 했다.
-- 이를 반영하는 UPDATE문을 작성해보세요
UPDATE
        EMP_SALARY ES
    SET ES.SALARY = (SELECT E1.SALARY
                        FROM EMPLOYEE E1
                       WHERE E1.EMP_NAME = '유재식'
                    )
      , ES.BONUS = (SELECT E2.BONUS
                      FROM EMPLOYEE E2
                     WHERE E2.EMP_NAME = '유재식'
                    )
  WHERE ES.EMP_NAME = '방명수';

-- 다중열 서브쿼리를 이용한 UPDATE로
-- 방명수 사원의 급여 인상 소식을 전해들은 다른 직원들이 단체로 파업을 진행했다.
-- 파업을 막기 위해 노옹철, 전형돈, 정중하, 하동운 사원의 급여와 보너스를
-- 유재식 사원의 급여와 보너스와 같에 변경하는 UPDATE문 작성
UPDATE
        EMP_SALARY ES
    SET (ES.SALARY, ES.BONUS) = (SELECT E1.SALARY
                                      , E1.BONUS
                                   FROM EMPLOYEE E1
                                  WHERE E1.EMP_NAME = '유재식'
                                )
  WHERE ES.EMP_NAME IN ('노옹철', '전형돈', '정중하', '하동운');
  
SELECT * FROM EMP_SALARY;

-- 다중행 서브쿼리를 이용한 UPDATE문
-- EMP_SALARY 테이블에서 아시아 지역에 근무하는 직원의 보너스를
-- 0.5로  변경하세요

UPDATE
        EMP_SALARY ES
    SET ES.BONUS = 0.5
  WHERE ES.EMP_ID IN (SELECT E1.EMP_ID
                        FROM EMPLOYEE E1
                        JOIN DEPARTMENT D1 ON (E1.DEPT_CODE = D1.DEPT_ID)
                        JOIN LOCATION L1 ON(D1.LOCATION_ID = L1.LOCAL_CODE)
                       WHERE L1.LOCAL_NAME LIKE 'ASIA%'
                    );

-- UPDATE 시 변경할 값은 해당 컬럼에 대한 제약조건에 위배되지 않아야 함
UPDATE
        EMPLOYEE E
    SET E.DEPT_CODE = '65'
  WHERE E.DEPT_CODE = 'D9';

UPDATE
        EMPLOYEE E
    SET E.EMP_NAME = NULL
  WHERE E.EMP_ID = '200';

UPDATE
        EMPLOYEE E
    SET E.EMP_NO = '621235-1985634'
  WHERE E.EMP_ID = '201';

UPDATE
        EMPLOYEE E
    SET E.ENT_YN = DEFAULT
  WHERE E.EMP_ID = '222';

SELECT * FROM EMPLOYEE;

-- DELETE : 테이블의 행을 삭제하는 구문이다.
--          테이블의 행의 갯수가 줄어든다.

-- DELETE FROM 테이블명 [WHERE 조건문]
-- 만약 WHERE 조건절을 설정하지 않으면 모든 행이 다 삭제된다.

COMMIT;

SELECT * FROM EMPLOYEE;

DELETE
    FROM EMPLOYEE E;

ROLLBACK;

DELETE
  FROM EMPLOYEE E
 WHERE E.EMP_ID = '900';
 
SELECT * FROM EMPLOYEE;

ROLLBACK;

-- FOREIGN KEY 제약조건이 설정되어 있는 경우
-- 참조되고 있는 값에 대해서 는 삭제할 수 없다.
DELETE
   FROM DEPARTMENT D
  WHERE D.DEPT_ID = 'D1';

-- TRUNCATE : 테이블의 전체 행을 삭제할 때 사용한다
--            DELETE보다 수행속도가 빠르다
--            ROLLBACK을 통해 복구할 수 없다.
SELECT * FROM EMP_SALARY;

COMMIT;

DELETE
   FROM EMP_SALARY ES;

SELECT * FROM EMP_SALARY;

ROLLBACK;

TRUNCATE TABLE EMP_SALARY;

ROLLBACK;

-- MERGE : 구조가 같은 두 개의 테이블을 하나로 합치는 기능을 한다.
--         테이블에서 지정하는 조건의 값이 존재하면 UPDATE
--         조건의 값이 없으면 INSERT 한다.
CREATE TABLE EMP_M01
AS
SELECT E.*
   FROM EMPLOYEE E;
   
CREATE TABLE EMP_M02
AS
SELECT E.*
   FROM EMPLOYEE E
  WHERE E.JOB_CODE = 'J4';

INSERT
   INTO EMP_M02 A
(
  A.EMP_ID, A.EMP_NAME, A.EMP_NO, A.EMAIL, A.PHONE
, A.DEPT_CODE, A.JOB_CODE, A.SAL_LEVEL, A.SALARY, A.BONUS
, A.MANAGER_ID, A.HIRE_DATE, A.ENT_DATE, A.ENT_YN
)
VALUES
(
  '999', '김진호', '561212-1234567', 'kim_jh@greedy.com', '01011112222'
, 'D9', 'J4', 'S1', 9000000, 0.5
, NULL, SYSDATE, NULL, DEFAULT
);

UPDATE
        EMP_M02 EM
    SET EM.SALARY = 0;

SELECT * FROM EMP_M02;

MERGE
  INTO EMP_M01 M1
 USING EMP_M02 M2
    ON (M1.EMP_ID = M2.EMP_ID)
  WHEN MATCHED THEN
UPDATE 
   SET M1.EMP_NAME = M2.EMP_NAME
     , M1.EMP_NO = M2.EMP_NO
     , M1.EMAIL = M2.EMAIL
     , M1.PHONE = M2.PHONE
     , M1.DEPT_CODE = M2.DEPT_CODE
     , M1.JOB_CODE = M2.JOB_CODE
     , M1.SAL_LEVEL = M2.SAL_LEVEL
     , M1.BONUS = M2.BONUS
     , M1.MANAGER_ID = M2.MANAGER_ID
     , M1.HIRE_DATE = M2.HIRE_DATE
     , M1.ENT_DATE = M2.ENT_DATE
     , M1.ENT_YN = M2.ENT_YN
  WHEN NOT MATCHED THEN
INSERT
(
  M1.EMP_ID, M1.EMP_NAME, M1.EMP_NO, M1.PHONE
, M1.DEPT_CODE, M1.JOB_CODE, M1.SAL_LEVEL, M1.SALARY, M1.BONUS
, M1.MANAGER_ID, M1.HIRE_DATE, M1.ENT_DATE, M1.ENT_YN
)
VALUES
(
  M2.EMP_ID, M2.EMP_NAME, M2.EMP_NO, M2.PHONE
, M2.DEPT_CODE, M2.JOB_CODE, M2.SAL_LEVEL, M2.SALARY, M2.BONUS
, M2.MANAGER_ID, M2.HIRE_DATE, M2.ENT_DATE, M2.ENT_YN
);

SELECT * FROM EMP_M01;
  


  
  