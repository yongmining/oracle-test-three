-- ������(SEQUENCE)
-- �ڵ� ��ȣ �߻��� ������ �ϴ� ��ü
/*
CREAE SEQUENCE ������
(INCREMAENT BY ����) -- ���� ���� ���� ����ġ, �����ϸ� �ڵ� 1 �⺻
(START WITH ����) -- ó�� �߻���ų �� ����, �����ϸ� �ڵ� 1 �⺻
(MAXVALUE ���� | NOMAXVALUE) -- �߻���ų �ִ밪 ����
(MINVALUE ���� | NOMINVALUE) -- �ּҰ� ����
(CYCLE | NOCYCLE) -- �� ��ȯ ����
(CACHE ũ�� | NOCHCHE) -- ĳ�� ��� ����, �⺻����  20
*/

CREATE SEQUENCE SEQ_EMPID
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;

SELECT * FROM USER_SEQUENCES;

ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;

-- START WITH���� ���� �Ұ�
-- START WITH ���� �����ϰ��� �Ϸ��� ������Ʈ�� �����ϰ� �ٽ� �����ؾ� �Ѵ�.

DROP SEQUENCE SEQ_EMPID;

-- SELECT ������ ��� ����
-- INSERT ������ SELECT �������� ��밡��
-- INSERT ������ VALUE ������ ��� ����
-- UPDATE ������ SET ������ ��� ����

-- ��, ���������� SELECT�������� ��� �Ұ�
-- VIWE�� SELECT������ ��� �Ұ�
-- DISTINCT Ű���尡 �ִ� SELECT���� ��� �Ұ�
-- GROUP BY, HAVING ���� �ִ� SELECT������ ��� �Ұ�
-- ORDER BY ������ ��� �Ұ�
-- CREATE TABLE, ALTER TABLE�� DEFAULT ������ ��� �Ұ�

CREATE SEQUENCE SEQ_EID
START WITH 300
INCREMENT BY 1
MAXVALUE 10000
NOCYCLE
NOCACHE;

INSERT INTO EMPLOYEE A
(
  A.EMP_ID, A.EMP_NAME, A.EMP_NO, A.EMAIL, A.PHONE
, A.DEPT_CODE, A.JOB_CODE, A.SAL_LEVEL, A.SALARY, A.BONUS
, A.MANAGER_ID, A.HIRE_DATE, A.ENT_DATE, A.ENT_YN
)
VALUES
(
  SEQ_EID.NEXTVAL, 'ȫ�浿', '666666-6666666', 'hong123@greedy.com', '01012345678'
, 'D2', 'J7', 'S1', 5000000, 0.1
, '200', SYSDATE, NULL, DEFAULT
);

SELECT * FROM EMPLOYEE;

ROLLBACK;

CREATE SEQUENCE SEQ_EID2;

