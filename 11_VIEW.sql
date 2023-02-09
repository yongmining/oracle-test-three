-- VIEW(��)
-- ���������� ������ ��ü�̴�.
-- �������� �����͸� �����ϴ� ���̺���� �ٸ�
-- ���̺��� ����ϴ� �Ͱ� �����ϰ� ����� �� �ִ�.
-- CREATE (OR REPLACE) VIEW ���̸� AS ��������

-- ���, �̸�, ���޸�, �μ���, �ٹ����� ��ȸ�ϰ�
-- �� ����� V_RESULT_EMP ��� �並 �����ؼ� �����ϼ���
CREATE OR REPLACE VIEW V_RESULT_EMP
AS
SELECT E.EMP_ID
     , E.EMP_NAME
     , J.JOB_NAME
     , D.DEPT_TITLE
     , L.LOCAL_NAME
  FROM EMPLOYEE E
  LEFT JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);
  
SELECT
        V.*
   FROM V_RESULT_EMP V
  WHERE V.EMP_ID = '205';
  
SELECT
        UV.*
   FROM USER_VIEWS UV;
   
-- �信 ��Ī �ο�
CREATE OR REPLACE VIEW V_EMP
(
  ���
, �̸�
, �μ�
)
AS
SELECT E.EMP_ID
     , E.EMP_NAME
     , E.DEPT_CODE
  FROM EMPLOYEE E;

SELECT
        V.*
   FROM V_EMP V;