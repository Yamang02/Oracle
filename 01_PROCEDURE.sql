/*
    <PROCEDURE>
        PROCEDURE는 오라클에서 제공하는 객체로 PL/SQL 문을 저장하여 필요할 때마다 
        복잡한 구문을 다시 입력할 필요 없이 간단하게 호출해서 실행 결과를 얻을 수 있다.
*/
-- 테스트용 테이블 생성
CREATE TABLE EMP_COPY
AS SELECT *
   FROM EMPLOYEE;
   
SELECT * FROM EMP_COPY;

-- EMP_COPY 테이블의 모든 데이터를 삭제하는 프로시저 생성
CREATE PROCEDURE DEL_ALL_EMP
IS
BEGIN
    DELETE FROM EMP_COPY;
    
    COMMIT;
END;
/

SELECT * FROM USER_SOURCE;

-- DEL_ALL_EMP 프로시저 호출
EXECUTE DEL_ALL_EMP;

-- 프로시저 삭제
DROP PROCEDURE DEL_ALL_EMP;
DROP TABLE EMP_COPY;

/*
    1. 매개변수가 있는 프로시저
*/
SET SERVEROUTPUT ON;

-- 테스트용 테이블 생성
CREATE TABLE EMP_COPY
AS SELECT *
   FROM EMPLOYEE;

-- 사번을 입력받아서 해당하는 사번의 사원을 삭제하는 프로시저 생성
CREATE PROCEDURE DEL_EMP_ID (
    P_EMP_ID EMPLOYEE.EMP_ID%TYPE
)
IS
BEGIN
    DELETE FROM EMP_COPY 
    WHERE EMP_ID = P_EMP_ID;
END;
/

-- 프로시저 실행
--EXEC DEL_EMP_ID; -- 에러 발생
EXEC DEL_EMP_ID('205');

-- 사용자가 입력한 값도 전달이 가능하다.
EXEC DEL_EMP_ID('&사번');

SELECT * FROM EMP_COPY;

ROLLBACK;

/*
    2. IN/OUT 매개변수가 있는 프로시저(기본값은 IN)
*/
-- 사번을 입력받아서 해당하는 사원의 이름, 급여, 보너스를 전달하는 프로시저 생성
CREATE PROCEDURE SELECT_EMP_ID (
    P_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,
    P_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
    P_SALARY OUT EMPLOYEE.SALARY%TYPE,
    P_BONUS OUT EMPLOYEE.BONUS%TYPE
)
IS
BEGIN
    SELECT EMP_NAME, SALARY, BONUS
    INTO P_EMP_NAME, P_SALARY, P_BONUS
    FROM EMP_COPY
    WHERE EMP_ID = P_EMP_ID;
END;
/

-- 바인드 변수 선언
VAR VAR_EMP_NAME VARCHAR2(30);
VAR VAR_SALARY NUMBER;
VAR VAR_BONUS NUMBER;

-- 바인드 변수는 ':변수명' 형태로 참조 가능
EXEC SELECT_EMP_ID('200', :VAR_EMP_NAME, :VAR_SALARY, :VAR_BONUS);

-- 바인드 변수의 값을 출력하기 위해서 PRINT 구문을 사용한다.
PRINT VAR_EMP_NAME;
PRINT VAR_SALARY;
PRINT VAR_BONUS;

-- 바인드 변수의 값이 변경되면 변수의 값을 자동으로 출력한다.
SET AUTOPRINT ON;

EXEC SELECT_EMP_ID('&사번', :VAR_EMP_NAME, :VAR_SALARY, :VAR_BONUS);