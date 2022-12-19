/*
    <SUBQUERY>
    
        하나의 SQL문 안에 포함된 또 다른 SQL문을 뜻한다.
    
*/
-- 서브 쿼리 예시
-- 1. 노옹철 사원과 같은 부서원들을 조회
-- 1) 노옹철 사원의 부서 코드 조회 (D9)
SELECT
    DEPT_CODE
FROM
    EMPLOYEE
WHERE
    EMP_NAME = '노옹철';

-- 2) 부서 코드가 노옹철 사원의 부서 코드와 동일한 사원들을 조회    
SELECT
    EMP_NAME
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'D9';

SELECT
    EMP_NAME,
    DEPT_CODE
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = (
        SELECT
            DEPT_CODE
        FROM
            EMPLOYEE
        WHERE
            EMP_NAME = '노옹철'
    );
    
-- 2. 전 직원의 평균 급여보다 더 많은 급여를 받고 있는 직원들의 사번, 직원명, 직급 코드, 급여를 조회   
-- 1_ 전직원의 평균 급여
SELECT
    FLOOR(AVG(SALARY))
FROM
    EMPLOYEE;

-- 2) 평균 급여보다 더 많은 급여를 받고 있는 사원

SELECT
    EMP_ID,
    EMP_NAME,
    JOB_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    (
        SELECT
            FLOOR(AVG(SALARY))
        FROM
            EMPLOYEE
    ) <= SALARY
ORDER BY
    EMPLOYEE.SALARY DESC;
    
/*
    <서브 쿼리 분류>
    
    1. 단일행 서브 쿼리
        서브 쿼리의 결과값의 개수가 1개일 때

*/


-- 최저 급여를 받는 직원의 사번, 이름, 직급 코드, 급여, 입사일 조회
-- 최저 급여 조회
SELECT
    MIN(SALARY)
FROM
    EMPLOYEE;


-- 위 쿼리를 서브 쿼리로 사용하는 메인 쿼리 작성
SELECT
    EMP_ID,
    EMP_NAME,
    JOB_CODE,
    HIRE_DATE
FROM
    EMPLOYEE
WHERE
    (
        SELECT
            MIN(SALARY)
        FROM
            EMPLOYEE
    ) = EMPLOYEE.SALARY;

-- 노옹철 사원의 급여보다 더 많이 받는 사원의 사번, 직원명, 부서명, 직급 코드, 급여 조회
-- 노옹철 사원의 급여
SELECT
    SALARY
FROM
    EMPLOYEE
WHERE
    EMP_NAME = '노옹철';

-- 위 쿼리를 서브 쿼리로 사용하는 메인 쿼리 작성

-- ANSI 표준    
SELECT
    E.EMP_ID,
    E.EMP_NAME,
    D.DEPT_TITLE,
    E.JOB_CODE,
    SALARY
FROM
         EMPLOYEE E
    JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
WHERE
    SALARY > (
        SELECT
            SALARY
        FROM
            EMPLOYEE
        WHERE
            EMP_NAME = '노옹철'
    );
    
-- 오라클 구문

SELECT
    E.EMP_ID,
    E.EMP_NAME,
    D.DEPT_TITLE,
    E.JOB_CODE,
    SALARY
FROM
    EMPLOYEE   E,
    DEPARTMENT D
WHERE
        E.DEPT_CODE = D.DEPT_ID
    AND SALARY > (
        SELECT
            SALARY
        FROM
            EMPLOYEE
        WHERE
            EMP_NAME = '노옹철'
    );

    
-- 부서별 급여의 합이 가장 큰 부서의 부서 코드, 급여의 합을 조회
-- 부서별 급여의 합

SELECT
    DEPT_CODE,
    SUM(SALARY)
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE
ORDER BY
    DEPT_CODE;
    
-- 부서별 급여의 합 중 가장 큰 값    
SELECT
    MAX(SUM(SALARY))
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE
ORDER BY
    DEPT_CODE;
    
/* 에러발생   
SELECT
    DEPT_CODE, MAX(SUM(SALARY))
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE
ORDER BY
    DEPT_CODE;
*/

-- 서브 쿼리는 WHERE절뿐만 아니라, SELECT/ FRO/ HAVING에서 사용이 가능하다.
SELECT
    DEPT_CODE,
    SUM(SALARY)
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE
HAVING
    SUM(SALARY) = (
        SELECT
            MAX(SUM(SALARY))
        FROM
            EMPLOYEE
        GROUP BY
            DEPT_CODE
    )
ORDER BY
    DEPT_CODE;
    

-- 전지연 사원이 속해있는 부서원들을 조회, (단, 전지연 사원은 제외)
-- 사번, 직원명, 전화번호, 직급명, 부서명, 입사일
-- 조인은 ANSI 와 ORACLE

SELECT *
FROM EMPLOYEE E
RIGHT OUTER JOIN JOB J USING (JOB_CODE)
LEFT OUTER JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
;

    