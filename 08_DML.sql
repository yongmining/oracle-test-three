-- DML(Data Manupulation Language)
-- INSERT, UPDATE, DELETE
-- : ������ ���� ���, ���̺� �����͸� �����ϰų� �����ϰų� �����ϴ� ���

-- INSERT : ���ο� ���� �߰��ϴ� �����̴�.
--          ���̺��� �� ������ �����Ѵ�.

-- [ǥ����]
-- ���̺��� �Ϻ� �÷��� INSERT�� ��
-- INSERT INTO ���̺�� (�÷���, �÷���, ...) VALUE (������, ������, ...);

-- ���̺��� ��� �÷��� INSERT �� ��
-- INSERT INTO ���̺�� VALUE (������, ������, ...);

-- ��� �÷��� INSERT �� ���� �÷����� ����ϴ� ���� �ǹ� �ľǿ� ����.

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
   '900', '��ä��', '001123-1080503', 'jang_ch@greedy.com', '01055556666'
 , 'D1', 'J7', 'S3', 43000, 0.2
 , '200', SYSDATE, NULL
 );
 
 SELECT * FROM EMPLOYEE;
 
 ROLLBACK;
 
 COMMIT;
 
 -- INSERT �� VALUES ��� ���������� �̿��� �� �ִ�.
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

-- INSERT ALL : INSERT �ÿ��� ����ϴ� ���������� ���� ���
--              �� �� �̻��� ���̺� INSERT ALL�� �̿��Ͽ�
--              �� ���� �����͸� ������ �� �ִ�
--              ��, �� ���������� �������� ���ƾ� �Ѵ�.
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

-- EMP_DEPT_D1 ���̺� EMPLOYEE ���̺��� �μ��ڵ尡 D1�� ������ ��ȸ�Ͽ�
-- ���, �̸�, �ҼӺμ�, �Ի����� �����ϰ�
-- EMP_MANAGER ���̺� EMPLOYEE ���̺� �ִ� �μ��ڵ尡 D1�� ������ ��ȸ�Ͽ�
-- ���, �̸�, ������ ����� ��ȸ�ؼ� �����ϼ���
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

-- EMPLOYEE ���̺��� �Ի��� �������� 2000�� 1�� 1�� ������ �Ի��� ���
-- ���, �̸�, �Ի���, �޿��� ��ȸ�Ͽ� EMP_OLD ���̺� �����ϰ�
-- �� ���Ŀ� �Ի��� ����� EMP_NEW ���̺� �����ϼ���
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

-- UPDATE : ���̺� ��е� �÷��� ���� �����ϴ� �����̴�.
--          ���̺��� ��ü �� ������ ��ȭ�� ����.
CREATE TABLE DEPT_COPY
AS
SELECT D.*
  FROM DEPARTMENT D;

SELECT * FROM DEPT_COPY;

-- UPDATE ���̺�� SET �÷��� = �ٲܰ�, �÷��� = �ٲܰ�, ...
-- [WHERE ���ǽ�]
UPDATE
        DEPT_COPY DC
    SET DC.DEPT_TITLE = '������ȹ��'
  WHERE DC.DEPT_ID = 'D9';

-- UPDATE �ÿ��� ���������� �̿��� �� �ִ�.
-- UPDATE ���̺��
-- SET �÷��� = (��������)
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
  WHERE ES.EMP_NAME IN ('�����', '����');

-- ���� ����� ����� �η����ϴ� ���� ����� �޿��� ���ʽ���
-- ����� ����� �����ϰ� �������ֱ�� �ߴ�.
-- �̸� �ݿ��ϴ� UPDATE���� �ۼ��غ�����
UPDATE
        EMP_SALARY ES
    SET ES.SALARY = (SELECT E1.SALARY
                        FROM EMPLOYEE E1
                       WHERE E1.EMP_NAME = '�����'
                    )
      , ES.BONUS = (SELECT E2.BONUS
                      FROM EMPLOYEE E2
                     WHERE E2.EMP_NAME = '�����'
                    )
  WHERE ES.EMP_NAME = '����';

-- ���߿� ���������� �̿��� UPDATE��
-- ���� ����� �޿� �λ� �ҽ��� ���ص��� �ٸ� �������� ��ü�� �ľ��� �����ߴ�.
-- �ľ��� ���� ���� ���ö, ������, ������, �ϵ��� ����� �޿��� ���ʽ���
-- ����� ����� �޿��� ���ʽ��� ���� �����ϴ� UPDATE�� �ۼ�
UPDATE
        EMP_SALARY ES
    SET (ES.SALARY, ES.BONUS) = (SELECT E1.SALARY
                                      , E1.BONUS
                                   FROM EMPLOYEE E1
                                  WHERE E1.EMP_NAME = '�����'
                                )
  WHERE ES.EMP_NAME IN ('���ö', '������', '������', '�ϵ���');
  
SELECT * FROM EMP_SALARY;

-- ������ ���������� �̿��� UPDATE��
-- EMP_SALARY ���̺��� �ƽþ� ������ �ٹ��ϴ� ������ ���ʽ���
-- 0.5��  �����ϼ���

UPDATE
        EMP_SALARY ES
    SET ES.BONUS = 0.5
  WHERE ES.EMP_ID IN (SELECT E1.EMP_ID
                        FROM EMPLOYEE E1
                        JOIN DEPARTMENT D1 ON (E1.DEPT_CODE = D1.DEPT_ID)
                        JOIN LOCATION L1 ON(D1.LOCATION_ID = L1.LOCAL_CODE)
                       WHERE L1.LOCAL_NAME LIKE 'ASIA%'
                    );

-- UPDATE �� ������ ���� �ش� �÷��� ���� �������ǿ� ������� �ʾƾ� ��
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

-- DELETE : ���̺��� ���� �����ϴ� �����̴�.
--          ���̺��� ���� ������ �پ���.

-- DELETE FROM ���̺�� [WHERE ���ǹ�]
-- ���� WHERE �������� �������� ������ ��� ���� �� �����ȴ�.

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

-- FOREIGN KEY ���������� �����Ǿ� �ִ� ���
-- �����ǰ� �ִ� ���� ���ؼ� �� ������ �� ����.
DELETE
   FROM DEPARTMENT D
  WHERE D.DEPT_ID = 'D1';

-- TRUNCATE : ���̺��� ��ü ���� ������ �� ����Ѵ�
--            DELETE���� ����ӵ��� ������
--            ROLLBACK�� ���� ������ �� ����.
SELECT * FROM EMP_SALARY;

COMMIT;

DELETE
   FROM EMP_SALARY ES;

SELECT * FROM EMP_SALARY;

ROLLBACK;

TRUNCATE TABLE EMP_SALARY;

ROLLBACK;

-- MERGE : ������ ���� �� ���� ���̺��� �ϳ��� ��ġ�� ����� �Ѵ�.
--         ���̺��� �����ϴ� ������ ���� �����ϸ� UPDATE
--         ������ ���� ������ INSERT �Ѵ�.
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
  '999', '����ȣ', '561212-1234567', 'kim_jh@greedy.com', '01011112222'
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
  


  
  