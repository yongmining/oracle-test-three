-- VIEW(뷰)
-- 서브쿼리를 지정한 객체이다.
-- 실질적인 데이터를 저장하는 테이블과는 다름
-- 테이블을 사용하는 것과 동일하게 사용할 수 있다.
-- CREATE (OR REPLACE) VIEW 뷰이름 AS 서브쿼리

-- 사번, 이름, 직급명, 부서명, 근무지역 조회하고
-- 그 결과를 V_RESULT_EMP 라는 뷰를 생성해서 저장하세요
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
   
-- 뷰에 별칭 부여
CREATE OR REPLACE VIEW V_EMP
(
  사번
, 이름
, 부서
)
AS
SELECT E.EMP_ID
     , E.EMP_NAME
     , E.DEPT_CODE
  FROM EMPLOYEE E;

SELECT
        V.*
   FROM V_EMP V;