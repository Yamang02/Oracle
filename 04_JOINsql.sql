/*
    
    <JOIN>

    1. INNER JOIN -- 일치하지 않는 행은 조회하지 않음
        1) 오라클 전용 구문
            SELECT 컬럼, ...
            FROM 테이블1 테이블2            
            WHERE 테이블1.컬럼명 = 테이블2.컬럼명; 
              
        2) ANSI 표준 구문
            SELECT 컬럼, ...
            FROM 테이블1 
            JOIN 테이블2 ON (테이블1.컬럼명 = 테이블2.컬럼명);

*/

-- 각 사원들의 사번, 직원명, 부서 코드, 부서명

SELECT
    EMP_ID,
    EMP_NAME,
    DEPT_CODE
FROM
    EMPLOYEE;

SELECT
    DEDEPT_ID,
    DEDEPT_TITLE
FROM
    DEPARTMENT;

-- 각 사원들의 사번, 직원명, 직급 코드, 직급명 조회

SELECT
    EMP_ID,
    EMP_NAME,
    JOB_CODE
FROM
    EMPLOYEE;

SELECT
    JOB_CODE,
    JOB_NAME
FROM
    JOB;

-- 오라클 구문
-- 1) 연결할 두 컬럼명이 다른 경우
--  EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인하여 사번, 직원명, 부서 코드, 부서명을 조회
--  일치하는 값이 없는 행은 조회에서 제외된다. (DEFT_CODE가 NULL인 사원, DEPT_CODE가 D3,D4, D인 사람)

SELECT
    EMP_ID,
    EMP_NAME,
    DEPT_CODE,
    DEPT_TITLE
FROM
    EMPLOYEE,
    DEPARTMENT
WHERE
    DEPT_CODE = DEPT_ID;

SELECT
    EMP_ID,
    EMP_NAME,
    DEPT_ID,
    DEPT_TITLE
FROM
    EMPLOYEE,
    DEPARTMENT
WHERE
    DEPT_CODE = DEPT_ID;

--    2) 연결할 두 컬럼명이 같은 경우
-- EMPLOYEE 테이블과 JOB 데이블을 조인하여 사번, 직원명, 직급 코드, 직급명을 조회
-- 방법 1) 테이블명을 이용하는 방법

SELECT
    EMPLOYEE.EMP_ID,
    EMPLOYEE.EMP_NAME,
    EMPLOYEE.JOB_CODE,
    JOB.JOB_NAME
FROM
    EMPLOYEE,
    JOB
WHERE
    EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
    
-- 방법 2) 테이블에 별칭을 이용하는 방법
SELECT
    E.EMP_ID,
    E.EMP_NAME,
    J.JOB_CODE,
    J.JOB_NAME
FROM
    EMPLOYEE E,
    JOB      J
WHERE
    E.JOB_CODE = J.JOB_CODE;
    
-- ANSI 표준 구문
-- 1) 연결할 두 컬럼명이 다른 경우
-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인하여 사번, 직원명, 부서 코드, 부서명을 조회

SELECT
    E.EMP_ID,
    E.EMP_NAME,
    D.DEPT_ID,
    D.DEPT_TITLE
FROM
         EMPLOYEE E
    JOIN DEPARTMENT D ON ( DEPT_ID = DEPT_CODE );
    
--    2) 연결할 두 컬럼명이 같은 경우
-- EMPLOYEE 테이블과 JOB 데이블을 조인하여 사번, 직원명, 직급 코드, 직급명을 조회
-- 방법 1) 테이블명을 이용하는 방법

SELECT
    EMPLOYEE.EMP_ID,
    EMPLOYEE.EMP_NAME,
    JOB.JOB_CODE,
    JOB.JOB_NAME
FROM
         EMPLOYEE
    INNER JOIN JOB ON ( EMPLOYEE.JOB_CODE = JOB.JOB_CODE );

-- 방법 2) 테이블 별칭을 이용하는 방법    
SELECT
    E.EMP_ID,
    E.EMP_NAME,
    J.JOB_CODE,
    J.JOB_NAME
FROM
         EMPLOYEE E
    /*INNER*/
    JOIN JOB J ON ( E.JOB_CODE = J.JOB_CODE );
    
-- 방법 3) USING 구문을 사용하는 방법
SELECT
    EMP_ID,
    EMP_NAME,
    JOB_CODE,
    JOB_NAME
FROM
         EMPLOYEE
    INNER JOIN JOB USING ( JOB_CODE );
    
-- 방법 4) NATURAL JOIN 구문을 이용하는 방법 ) (참고 - 동일한 이름의 칼럼을 자동으로.. 하지만 원하는 방식으로 안될 가능성이 높아 잘 사용하지 않음)
SELECT
    EMP_ID,
    EMP_NAME,
    JOB_CODE,
    JOB_NAME
FROM
         EMPLOYEE
    NATURAL JOIN JOB;

-- EMPLOYEE 테이블과 JOB 테이블을 조인하여 직급이 대리인 사원의 사번, 직원명, 직급명 급여를 조회

-- 오라클 구문 (JOIN 조건, 검색 조건 모두 WHERE)
SELECT
    E.EMP_ID,
    E.EMP_NAME,
    J.JOB_NAME,
    E.SALARY
FROM
    EMPLOYEE E,
    JOB      J
WHERE
        E.JOB_CODE = J.JOB_CODE
    AND J.JOB_NAME = '대리';
    

-- ANSI 표준구문
SELECT
    E.EMP_ID,
    E.EMP_NAME,
    J.JOB_NAME,
    E.SALARY
FROM
         EMPLOYEE E
    INNER JOIN JOB J ON ( E.JOB_CODE = J.JOB_CODE )
WHERE
    J.JOB_NAME = '대리';

SELECT
    E.EMP_NO,
    E.EMP_NAME,
    J.JOB_NAME,
    E.SALARY
FROM
         EMPLOYEE E
    INNER JOIN JOB J USING ( JOB_CODE )
WHERE
    J.JOB_NAME = '대리';
    
------------------------- 실습 문제 -------------------------
-- 1. DEPARTMENT 테이블과 LOCATION 테이블을 조인하여 부서 코드, 부서명, 지역 코드, 지역명을 조회
-- 오라클
SELECT
    D.DEPT_ID    부서코드,
    D.DEPT_TITLE 부서명,
    L.LOCAL_CODE 지역코드,
    L.LOCAL_NAME 지역명
FROM
    DEPARTMENT D,
    LOCATION   L
WHERE
    L.LOCAL_CODE = D.LOCATION_ID;

-- ANSI
SELECT
    D.DEPT_ID    부서코드,
    D.DEPT_TITLE 부서명,
    L.LOCAL_CODE 지역코드,
    L.LOCAL_NAME 지역명
FROM
         DEPARTMENT D
    INNER JOIN LOCATION L ON L.LOCAL_CODE = D.LOCATION_ID;

--2. EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인해서 보너스를 받는 사원들의 사번, 직원명, 보너스, 부서명을 조회
-- 오라클
SELECT
    E.EMP_ID     사번,
    E.EMP_NAME   직원명,
    E.BONUS      보너스,
    D.DEPT_TITLE 부서명
FROM
    EMPLOYEE   E,
    DEPARTMENT D
WHERE
        D.DEPT_ID = E.DEPT_CODE
    AND E.BONUS IS NOT NULL
ORDER BY
    EMP_ID;

-- ANSI
SELECT
    EMP_ID     사번,
    EMP_NAME   직원명,
    BONUS      보너스,
    DEPT_TITLE 부서명
FROM
         EMPLOYEE E
    INNER JOIN DEPARTMENT D ON ( DEPT_ID = DEPT_CODE )
WHERE
    BONUS IS NOT NULL
ORDER BY
    EMP_ID;


--3. EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인해서 인사관리부가 아닌 사원들의 직원명, 부서명, 급여를 조회
-- 오라클
SELECT
    E.EMP_NAME   직원명,
    D.DEPT_TITLE 부서명,
    E.SALARY     급여
FROM
    EMPLOYEE   E,
    DEPARTMENT D
WHERE
        E.DEPT_CODE = D.DEPT_ID
    AND DEPT_TITLE != '인사관리부';


-- ANSI
SELECT
    E.EMP_NAME   직원명,
    D.DEPT_TITLE 부서명,
    E.SALARY     급여
FROM
         EMPLOYEE E
    INNER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
WHERE
    D.DEPT_TITLE != '인사관리부';

-- 4. EMPLOYEE 테이블과 DEPARTMENT 테이블을, JOB 테이블을 조인해서 사번, 직원명, 부서명, 직급명을 조회
-- 오라클
SELECT
    E.EMP_ID     사번,
    E.EMP_NAME   직원명,
    D.DEPT_TITLE 부서명,
    J.JOB_NAME   직급명
FROM
    EMPLOYEE   E,
    DEPARTMENT D,
    JOB        J
WHERE
        E.DEPT_CODE = D.DEPT_ID
    AND E.JOB_CODE = J.JOB_CODE;


-- ANSI
SELECT
    E.EMP_ID     사번,
    E.EMP_NAME   직원명,
    D.DEPT_TITLE 부서명,
    J.JOB_NAME   직급명
FROM
         EMPLOYEE E
    INNER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
    INNER JOIN JOB        J ON ( E.JOB_CODE = J.JOB_CODE );

-------------------------------------------------------------