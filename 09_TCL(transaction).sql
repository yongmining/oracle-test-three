-- TCL (Transaction Control Language)
-- Ʈ������ ���� ���
-- COMMIT�� ROLLBACK�� �ִ�.

-- Ʈ������̶�?
-- �Ѳ����� ����ǿ� �� �ּ��� �۾� ������ �ǹ��Ѵ�.
-- ���� �۾� ���� (Logical Unit of Work - LUW) ��� �Ѵ�.
-- �ϳ��� Ʈ���������� �̷���� �۾��� �ݵ�� �Ѳ����� �Ϸ� (COMMIT)�� �Ǿ�� �ϸ�,
-- �׷��� ���� ��쿡�� �Ѳ����� ���(ROLLBACK) �Ǿ�� �Ѵ�.

-- COMMIT : Ʈ������ �۾��� ���� �Ϸ�Ǹ� ���� ������ ������ ����
-- ROLLBACK : Ʈ������ �۾��� ����ϰ� �ֱ� COMMIT�� �������� �̵�
-- SAVEPOINT ���̺�����Ʈ�� : ���� Ʈ������ �۾� ������ ������ ������ �� ������ �̸��� ����
-- ROLLBACK TO ���̺�����Ʈ�� : Ʈ������ �۾��� ����ϰ� SAVEPOINT �������� �̵�

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
