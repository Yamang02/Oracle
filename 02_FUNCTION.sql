/*
    <FUNCTION>
        FUNCTION은 오라클에서 제공하는 객체로 PROCEDURE와 거의 유사한 용도로 사용하지만 실행 결과를 되돌려 받을 수 있다는 점이 다르다.
    
*/
-- 사번을 입력받아 해당 사원의 보너스를 포함하는 연봉을 계산하고 리턴하는 함수 생성

CREATE FUNCTION BONUS_CALC (
    V_EMP_ID EMPLOYEE.EMP_ID%TYPE
) RETURN NUMBER IS
    V_SALARY EMPLOYEE.SALARY%TYPE;
    V_BONUS  EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT
        SALARY,
        NVL(BONUS, 0)
    INTO
        V_SALARY,
        V_BONUS
    FROM
        EMPLOYEE
    WHERE
        EMP_ID = V_EMP_ID;

    RETURN ( V_SALARY + ( V_SALARY * V_BONUS ) ) * 12;
END;
/

-- 함수 호출
SELECT
    BONUS_CALC('211')
FROM
    DUAL;

-- 함수 호출 결과를 반환받아 저장할 바인드 변수 선언
VARIABLE VAR_CALC_SALARY NUMBER;

--EXEC BONUS_CALC('200'); -- 에러
EXEC :VAR_CALC_SALARY := BONUS_CALC('200');


-- EMPLOYEE 테이블에서 전체 사원의 사원의 사번, 직원명, 급여, 보너스, 보너스를 포함한 연봉을 조회

SELECT
    EMP_ID,
    EMP_NAME,
    SALARY,
    BONUS,
    BONUS_CALC(EMP_ID)
FROM
    EMPLOYEE
WHERE
    BONUS_CALC(EMP_ID) > 40000000
ORDER BY
    BONUS_CALC(EMP_ID);
    
    
    
    