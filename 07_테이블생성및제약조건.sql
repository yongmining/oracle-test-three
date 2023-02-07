-- DDL (CREATE TABLE) �� ��������

-- DDL (Data Definition Language) : ������ ���Ǿ��
-- ��ü (OBJECT)�� �����(CREATE), �����ϰ�(ALTER), �����ϴ�(DROP) ����

--���̺� �����
-- [ǥ����] : CREATE TABLE ���̺�� (�÷��� �ڷ��� (ũ��), �÷��� �ڷ���(ũ��), ...);

CREATE TABLE MEMBER (
    MEMBER_ID VARCHAR2 (20),
    MEMBER_PWD VARCHAR2 (20),
    MEMBER_NAME VARCHAR2 (20)
 );

-- �÷��� �ּ� �ޱ�
-- [ǥ����] : COMMENT ON COLUMN ���̺��,�÷��� IS ' �ּ�����';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEMBE_PWD IS '��й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸�';

SELECT
        M.*
   FROM MEMBER M;

SELECT
        UT.*
   FROM USER_TABLES UT;
   
SELECT
        UTC.*
   FROM USER_TAB_COLUMNS UTC
  WHERE UTC.TABLE_NAME = 'MEMBER';
  
DESC MEMBER;

-- ��������
-- ���̺� ���� �� �� �÷��� ���� ���� ���� �� �ִ� ������ ������ �� �ִ�.
-- ������ ���Ἲ ������ �������� �Ѵ�.
-- PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY

-- NOT NULL : �ش� �÷��� NULL���� ������� �ʴ� ��������
--            �÷��������� ����
CREATE TABLE USER_NOCONS (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

INSERT
    INTO USER_NOCONS
(
    USER_NO,   USER_ID,   USER_PWD
,   USER_NAME,   GENDER,   PHONE
,   EMAIL
)
VALUES
(
  1, 'user01', 'pass01'
, 'ȫ�浿', '��', '010-1234-5678'
, 'hong123@greedy.com'
);

INSERT
  INTO USER_NOCONS
(
  USER_NO, USER_ID, USER_PWD
, USER_NAME, GENDER, PHONE
, EMAIL
)
VALUES
(
   2, NULL, NULL
, NULL, NULL, '010-1234-5678'
, 'hong123@gmail.com'
);

CREATE TABLE USER_NOTNULL (
  USER_NO NUMBER NOT NULL,
  USER_ID VARCHAR2(20) NOT NULL,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NANE VARCHAR2(30) NOT NULL,
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

INSERT
  INTO USER_NOTNULL
(
  USER_NO, USER_ID, USER_PWD
, USER_NAME, GENDER, PHONE
, EMAIL
)
VALUES
(
   1, 'user01', 'pass01'
, NULL, NULL, '010-1234-5678'
, 'hong123@greedy.com'
);

SELECT
        UN.*
   FROM USER_NOTNULL UN;
   
SELECT
        UC.*
   FROM USER_CONSTRAINTS UC;
   
SELECT
        UCC.*
   FROM USER_CONS_COLUMNS UCC;

-- ������ ��ųʸ� ��ȭ
-- ������ ��ųʸ���?
-- ������ �����̶�� �Ҹ���. (�����Ϳ� ���� ������ -> ��Ÿ������)
-- DDL ������ �̿��ؼ� �������� ������ ����, ����, ������ �� �ڵ����� �ݿ��Ǵ� ��(���� ���̺�)
-- ��ųʸ� ��� ��ȸ�� �����ϴ�.
-- 1. USER_XXX
-- 2. DAB_XXX
-- 3, ALL_XXX

SELECT 
        UC.*
      , UCC.*
   FROM USER_CONSTRAINTS UC
   JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
  WHERE UC.TABLE_NAME = 'USER_NOTNULL';
  
-- UNIQUE ���� ���� : �÷� �Է°��� ���� ������ �����ϴ� ���� �ߺ��� ���� �� �� ������ ������ �Ŵ� ��������
--                   �÷� �������� ���� ����, ���̺� �������� ���� ����
SELECT
        UN.*
   FROM USER_NOCONS UN;

INSERT
    INTO USER_UNIQUE
(
    USER_NO,   USER_ID,   USER_PWD
,   USER_NAME,   GENDER,   PHONE
,   EMAIL
)
VALUES
(
  1, 'user01', 'pass01'
, 'ȫ�浿', '��', '010-1234-5678'
, 'hong123@greedy.com'
);

CREATE TABLE USER_UNIQUE(
  USER_NO NUMBER,
  USER_ID VARCHAR(20) UNIQUE NOT NULL,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);
INSERT
    INTO USER_UNIQUE
(
    USER_NO,   USER_ID,   USER_PWD
,   USER_NAME,   GENDER,   PHONE
,   EMAIL
)
VALUES
(
  1, 'user01', 'pass01'
, 'ȫ�浿', '��', '010-1234-5678'
, 'hong123@greedy.com'
);

INSERT
    INTO USER_UNIQUE
(
    USER_NO,   USER_ID,   USER_PWD
,   USER_NAME,   GENDER,   PHONE
,   EMAIL
)
VALUES
(
  1, 'user01', 'pass01'
, 'ȫ�浿', '��', '010-1234-5678'
, 'hong123@greedy.com'
);

SELECT
        UCC.TABLE_NAME
      , UCC.COLUMN_NAME
      , UC.CONSTRAINT_TYPE
   FROM USER_CONSTRAINTS UC
      , USER_CONS_COLUMNS UCC
  WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
    AND UCC.CONSTRAINT_NAME = 'SYS_C008554';

CREATE TABLE USER_UNIQUE2 (
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) NOT NULL,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  UNIQUE(USER_ID)
);
    
CREATE TABLE USER_UNIQUE3(
  USER_NO NUMBER,
  USER_ID VARCHAR(20) NOT NULL,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  UNIQUE(USER_NO, USER_ID)
);

-- �������ǿ� �̸� ����
CREATE TABLE CONS_NAME(
  TEST_DATA1 VARCHAR2(20) CONSTRAINT NN_TEST_DATA1 NOT NULL,
  TEST_DATA2 VARCHAR2(20) CONSTRAINT UN_TEST_DATA2 UNIQUE,
  TEST_DATA3 VARCHAR2(20),
  CONSTRAINT UN_TEST_DATA3 UNIQUE(TEST_DATA3)
);
  
-- CHECK �������� : �÷��� ���� ���� �񱳿����� �̿��� ������ �����ϴ� ��쿡�� ���� �� �� �ֵ��� �����ϴ� ��������
CREATE TABLE USER_CHECK(
  USER_NO NUMBER,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR(10) CHECK(GENDER IN('��', '��')),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

INSERT
    INTO USER_CHECK
(
    USER_NO,   USER_ID,   USER_PWD
,   USER_NAME,   GENDER,   PHONE
,   EMAIL
)
VALUES
(
  1, 'user01', 'pass01'
, 'ȫ�浿', '��', '010-1234-5678'
, 'hong123@greedy.com'
);

INSERT
    INTO USER_CHECK
(
    USER_NO,   USER_ID,   USER_PWD
,   USER_NAME,   GENDER,   PHONE
,   EMAIL
)
VALUES
(
  1, 'user01', 'pass01'
, 'ȫ�浿', '����', '010-1234-5678'
, 'hong123@greedy.com'
);

-- PRIMARY KEY(�⺻Ű) ��������
-- : �ֽĺ��� ������ �����ϴ� �÷��� �����ϴ� ���������̴�.
--  ���̺�� �� ���� �⺻Ű ���������� �ʼ��̴�.
--  ���̺�� �� ���� �⺻Ű �������Ǹ� ������ �� �ִ�.
--  �� �� �÷��� ������ �� �� �ְ�(����Ű), ���� ���� �÷��� ��� ������ �� �� �ִ�(����Ű).
--  �⺻Ű ���������� �����Ǹ� ���������� NOT NULL + UNIQUE�� �ǹ̸� ������.
--  �⺻Ű ���������� �����Ǹ� �ڵ����� �ش� �÷��� ���� �ε����� �����ȴ�.
CREATE TABLE USER_PRIMARYKEY(
  USER_NO NUMBER CONSTRAINT PK_USER_NO PRIMARY KEY,
  USER_ID VARCHAR(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50)
);

INSERT
    INTO USER_PRIMARYKEY
(
    USER_NO,   USER_ID,   USER_PWD
,   USER_NAME,   GENDER,   PHONE
,   EMAIL
)
VALUES
(
  1, 'user01', 'pass01'
, 'ȫ�浿', '����', '010-1234-5678'
, 'hong123@greedy.com'
);

INSERT
    INTO USER_PRIMARYKEY
(
    USER_NO,   USER_ID,   USER_PWD
,   USER_NAME,   GENDER,   PHONE
,   EMAIL
)
VALUES
(
  NULL, 'user01', 'pass01'
, 'ȫ�浿', '����', '010-1234-5678'
, 'hong123@greedy.com'
);

SELECT
        UC.TABLE_NAME
      , UCC.COLUMN_NAME
      , UC.CONSTRAINT_NAME
      , UC.CONSTRAINT_TYPE
   FROM USER_CONSTRAINTS UC
   JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
  WHERE UC.CONSTRAINT_NAME = 'PK_USER_NO';
  
CREATE TABLE USER_PRIMARYKEY2(
   USER_NO NUMBER,
   USER_ID VARCHAR2(20),
   USER_PWD VARCHAR2(30) NOT NULL,
   USER_NAME VARCHAR2(30),
   GENDER VARCHAR2(10),
   PHONE VARCHAR2(30),
   EMAIL VARCHAR2(50),
   CONSTRAINT PK_USER_NO2 PRIMARY KEY(USER_NO, USER_ID)
);

SELECT
        UC.TABLE_NAME
      , UCC.COLUMN_NAME
      , UC.CONSTRAINT_NAME
      , UC.CONSTRAINT_TYPE
   FROM USER_CONSTRAINTS UC
   JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
  WHERE UC.CONSTRAINT_NAME = 'PK_USER_NO2';
  
-- FOREIGN KEY(�ܺ�Ű/�ܷ�Ű/�������Ἲ ��������) :
-- ����(REFERENCES)�� �ٸ� ���̺��� �����ϴ� ���� ����� �� ����
-- ���� ���Ἲ�� �������� �ʰ� �ϱ� ���� ����Ѵ�.
-- FOREIGN KEY�������ǿ� ���ؼ� ���̺��� ����(RELATIONSHIP)�� �����ȴ�.
-- �����Ǵ� �� �ܿ��� NULL�� ����� �� �ִ�.
-- �����ؼ� �����Ͱ� ���� �ϴ� ���̺��� �θ����̺�, ���߿� �����Ͽ� �����͸� �ִ� ���̺��� �ڽ����̺��̶�� �Ѵ�.

-- �÷� ������ ���
-- �÷��� �ڷ���(ũ��) [CONSTRAINT �������� �̸�] REFERENCES ���������̺�� [(�������÷�)] [������]

-- ���̺� ������ ���
-- [CONSTRAINT �̸�] FOREIGN KEY (�������÷���) REFERENCES ���������̺�� [(�������÷�)] [������]

-- ������ ���̺��� ������ �÷����� �����Ǹ� PRIMARY KEY�� ������ �÷��� �ڵ����� ������ �÷��� �ȴ�.
-- ������ �� �ִ� �÷��� PRIMARY KEY�÷��� UNIQUE �÷��� �ܷ�Ű�� ������ �� �ִ�.
CREATE TABLE USER_GRADE(
  GRADE_CODE NUMBER PRIMARY KEY,
  GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT
  INTO USER_GRADE
(
  GRADE_CODE, GRADE_NAME
)
VALUES
(
  10, '�Ϲ�ȸ��'
);
INSERT
  INTO USER_GRADE
(
  GRADE_CODE, GRADE_NAME
)
VALUES
(
  20, '���ȸ��'
);
INSERT
  INTO USER_GRADE
(
  GRADE_CODE, GRADE_NAME
)
VALUES
(
  30, 'Ư��ȸ��'
);

SELECT * FROM USER_GRADE;

COMMIT;

CREATE TABLE USER_FOREIGNKEY(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER,
  CONSTRAINT FK_GRADE_CODE FOREIGN KEY (GRADE_CODE) REFERENCES USER_GRADE (GRADE_CODE)
);

INSERT INTO USER_FOREIGNKEY VALUES (1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@gmail.com', 10);
INSERT INTO USER_FOREIGNKEY VALUES (2, 'user02', 'pass02', '�̼���', '��', '010-1234-2222', 'lee123@gmail.com', 10);
INSERT INTO USER_FOREIGNKEY VALUES (3, 'user03', 'pass03', '������', '��', '010-1234-3131', 'yoo123@gmail.com', 30);
INSERT INTO USER_FOREIGNKEY VALUES (4, 'user04', 'pass04', '���߱�', '��', '010-1234-1111', 'hong123@gmail.com', null); 
INSERT INTO USER_FOREIGNKEY VALUES (5, 'user05', 'pass05', '�Ӳ���', '��', '010-1234-2322', 'leem123@gmail.com', 50);

COMMIT;

SELECT
        UC.TABLE_NAME
      , UCC.COLUMN_NAME
      , UC.CONSTRAINT_NAME
      , UC.CONSTRAINT_TYPE
   FROM USER_CONSTRAINTS UC
      , USER_CONS_COLUMNS UCC
  WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
    AND UC.CONSTRAINT_NAME = 'FK_GRADE_CODE';

-- ȸ�� ���̵�, �̸�, ����, ����ó, ȸ����޸� ��ȸ
SELECT
        UF.USER_ID
      , UF.USER_NAME
      , UF.GENDER
      , UF.PHONE
      , UG.GRADE_NAME
   FROM USER_FOREIGNKEY UF
NATURAL LEFT JOIN USER_GRADE UG;

-- ���� �ɼ�
-- : �θ� ���̺��� ������ ���� �� �ڽ� ���̺��� �����͸� � ������ ó���� ���� ���� ������ �����ϴ� �ɼ�
-- ON DELETE RESTRICT : �����ǰ� �ִ� �� ���� �Ұ� (�⺻��)
-- ON DELETE SET NULL : �����ϰ� �ִ� �� ���� �� �����ϴ� �÷��� NULL�� ����
-- ON DELETE CASCADE : �����ϰ� �ִ� �� ���� �� �����ϴ� �÷��� ���� �� ����

COMMIT;

DELETE
  FROM USER_GRADE
 WHERE GRADE_CODE = 10;

DELETE
  FROM USER_GRADE
 WHERE GRADE_CODE = 20;

SELECT
        UG.*
   FROM USER_GRADE UG;

ROLLBACK;

CREATE TABLE USER_GRADE2(
   GRADE_CODE NUMBER PRIMARY KEY,
   GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE2 (GRADE_CODE, GRADE_NAME) VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE2 (GRADE_CODE, GRADE_NAME) VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE2 (GRADE_CODE, GRADE_NAME) VALUES(30, 'Ư��ȸ��');

SELECT * FROM USER_GRADE2;

CREATE TABLE USER_FOREIGNKEY2(
   USER_NO NUMBER PRIMARY KEY,
   USER_ID VARCHAR2(20) UNIQUE,
   USER_PWD VARCHAR2(30) NOT NULL,
   USER_NAME VARCHAR2(30),
   GENDER VARCHAR2(10),
   PHONE VARCHAR2(30),
   EMAIL VARCHAR2(50),
   GRADE_CODE NUMBER,
   CONSTRAINT FK_GRADE_CODE2 FOREIGN KEY  (GRADE_CODE)
   REFERENCES USER_GRADE2 (GRADE_CODE) ON DELETE SET NULL
);

INSERT INTO USER_FOREIGNKEY2 VALUES (1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@gmail.com', 10);
INSERT INTO USER_FOREIGNKEY2 VALUES (2, 'user02', 'pass02', '�̼���', '��', '010-1234-2222', 'lee123@gmail.com', 10);
INSERT INTO USER_FOREIGNKEY2 VALUES (3, 'user03', 'pass03', '������', '��', '010-1234-3131', 'yoo123@gmail.com', 30);
INSERT INTO USER_FOREIGNKEY2 VALUES (4, 'user04', 'pass04', '���߱�', '��', '010-1234-1111', 'hong123@gmail.com', null);

SELECT * FROM USER_FOREIGNKEY2;

DELETE FROM USER_GRADE2 WHERE GRADE_CODE = 10;

SELECT * FROM USER_GRADE2;
-- ON DELETE CASCADE
CREATE TABLE USER_GRADE3(
   GRADE_CODE NUMBER PRIMARY KEY,
   GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO USER_GRADE3 (GRADE_CODE, GRADE_NAME) VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE3 (GRADE_CODE, GRADE_NAME) VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE3 (GRADE_CODE, GRADE_NAME) VALUES(30, 'Ư��ȸ��');

SELECT * FROM USER_GRADE3;

CREATE TABLE USER_FOREIGNKEY3(
  USER_NO NUMBER PRIMARY KEY,
  USER_ID VARCHAR2(20) UNIQUE,
  USER_PWD VARCHAR2(30) NOT NULL,
  USER_NAME VARCHAR2(30),
  GENDER VARCHAR2(10),
  PHONE VARCHAR2(30),
  EMAIL VARCHAR2(50),
  GRADE_CODE NUMBER,
  CONSTRAINT FK_GRADE_CODE3 FOREIGN KEY (GRADE_CODE)
  REFERENCES USER_GRADE3 (GRADE_CODE) ON DELETE CASCADE
);

INSERT INTO USER_FOREIGNKEY3 VALUES (1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'hong123@gmail.com', 10);
INSERT INTO USER_FOREIGNKEY3 VALUES (2, 'user02', 'pass02', '�̼���', '��', '010-1234-2222', 'lee123@gmail.com', 10);
INSERT INTO USER_FOREIGNKEY3 VALUES (3, 'user03', 'pass03', '������', '��', '010-1234-3131', 'yoo123@gmail.com', 30);
INSERT INTO USER_FOREIGNKEY3 VALUES (4, 'user04', 'pass04', '���߱�', '��', '010-1234-1111', 'hong123@gmail.com', null);

SELECT * FROM USER_FOREIGNKEY3;

DELETE FROM USER_GRADE3 WHERE GRADE_CODE = 10;
    
CREATE TABLE EMPLOYEE_COPY
AS
SELECT E.*
   FROM EMPLOYEE E;

SELECT * FROM EMPLOYEE_COPY;





    