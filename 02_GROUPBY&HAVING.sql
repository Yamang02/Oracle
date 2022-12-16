/*
    <GROUP BY>
        그룹 기준을 제시할 수 있는 구문이다.
        여러 개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용한다.
        
*/
-- 전체 사원의 급여의 총합을 구한 결과 조회
SELECT
--    DEPT_CODE,
    SUM(SALARY) AS "급여 합계"
FROM
    EMPLOYEE;

-- DEPT_CODE 컬럼을 기준으로 같은 값을 가진 행들을 그룹으로 묶는다. (중복 제거 X)
SELECT
    DEPT_CODE
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE
ORDER BY
    DEPT_CODE;
    
-- 각 부서별 그룹으로 묶어서 부서별 급여의 총합을 조회

SELECT
    DEPT_CODE,
    SUM(SALARY)
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE
ORDER BY
    DEPT_CODE;

-- DISTINCT로는 동작하지 않는다.    
/*
SELECT
    DISTINCT DEPT_CODE,
    SUM(SALARY)
FROM
    EMPLOYEE
ORDER BY
    DEPT_CODE;    
*/

-- EMPLOYEE 테이블에서 각 부서별 사원의 수를 조회
SELECT
    NVL(DEPT_CODE, '부서없음'),
    COUNT(*)
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE
ORDER BY
    DEPT_CODE;
    
-- EMPLOYEE 테이블에서 각 부서별 보너스를 받는 사원 수를 조회 : WHERE절이 먼저 수행되므로 0인 부서가 보이지 않음
SELECT
    NVL(DEPT_CODE, '부서없음') 부서,
    COUNT(*)               인원수
FROM
    EMPLOYEE
WHERE
    BONUS IS NOT NULL
GROUP BY
    DEPT_CODE
ORDER BY
    DEPT_CODE;
    
-- EMPLOYEE 테이블에서 각 직급별 사원의 수를 조회
SELECT
    JOB_CODE,
    COUNT(*)
FROM
    EMPLOYEE
GROUP BY
    JOB_CODE
ORDER BY
    JOB_CODE;
    
-- EMPLOYEE 테이블에서 각 직급별 보너스를 받는 사원의 수를 조회
SELECT
    JOB_CODE,
    COUNT(BONUS)
FROM
    EMPLOYEE
GROUP BY
    JOB_CODE
ORDER BY
    JOB_CODE;
    
-- EMPLOYEE 테이블에서 부서별 사원 수, 보너스를 받는 사원의 수, 급여의 합, 평균 급여, 최고 급여를 조회(부서별 오름차순) 급여는 자리수 표시, 평균은 버림

SELECT
    NVL(DEPT_CODE, '부서없음')        "부서",
    COUNT(NVL(DEPT_CODE, '부서없음')) "부서별 사원수",
    COUNT(BONUS)                  "보너스를 받는 사원수`",
    TO_CHAR(SUM(SALARY),
            '999,999,999L')       "급여의 합",
    TO_CHAR(FLOOR(AVG(NVL(SALARY, 0))),
            '99,999,999L')        "평균 급여",
    TO_CHAR(MAX(SALARY),
            '999,999,999L')       "최고 급여",
    TO_CHAR(MIN(SALARY),
            '999,999,999L')       "최저 급여"
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE
ORDER BY
    DEPT_CODE;
    
-- EMPLOYEE 테이블에서 성별별 사원의 수를 조회

SELECT
    DECODE(SUBSTR(EMP_NO, 8, 1),
           '1',
           '남자',
           '2',
           '여자',
           '외계인') AS "성별 코드",
    COUNT(*)      AS "사원 수"
FROM
    EMPLOYEE
GROUP BY
    SUBSTR(EMP_NO, 8, 1);

-- EMPLOYEE 테이블에서 부서 코드와 직급 코드가 같은 사원 수, 급여의 합

SELECT
    NVL(DEPT_CODE, '부서 없음')
    || ' '
    || JOB_CODE AS "부서와 직급",
    COUNT(*)    사원수,
    SUM(SALARY) AS "급여"
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE,
    JOB_CODE
ORDER BY
    DEPT_CODE;
    
/*

    <HAVING>
        그룹에 대한 조건을 제시할 때 사용하는 구문.
        
    <실행 순서>
        SELECT      (5)
        FROM        (1)
        WHERE       (2)
        GROUP BY    (3)
        HAVING      (4)
        ORDER BY    (6)
    
*/

-- EMPLOYEE 테이블에서 부서별로, 급여가 300만원 이상인 직원의 평균 급여

SELECT
    NVL(DEPT_CODE, '미배치'),
    COUNT(*),
    AVG(SALARY)
FROM
    EMPLOYEE
WHERE
    SALARY >= 3000000
GROUP BY
    DEPT_CODE
ORDER BY
    DEPT_CODE;
    
-- EMPLOYEE 테이블에서 부서별 평균 급여가 300만원 이상인 부서의 평균 급여

SELECT
    NVL(DEPT_CODE, '미배치'),
    FLOOR(AVG(SALARY))
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE
HAVING
    FLOOR(AVG(NVL(SALARY, 0))) >= 3000000
ORDER BY
    DEPT_CODE;
    
-- EMPLOYEE 테이블에서 직급별 총 급여의 합이 10,000,000 이상인 직급만 조회

SELECT
    NVL(JOB_CODE, '무직급'),
    SUM(SALARY)
FROM
    EMPLOYEE
GROUP BY
    JOB_CODE
HAVING
    SUM(SALARY) >= 10000000
ORDER BY
    JOB_CODE;

-- EMPLOYEE 테이블에서 부서별, 보너스를 받는 사원이 없는 부서만 조회

SELECT
    NVL(DEPT_CODE, '미배치'),
    COUNT(BONUS)
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE
HAVING
    COUNT(BONUS) = 0
ORDER BY
    DEPT_CODE;
    
/*
    <집계 함수>
    
    1) ROLL UP
    -- 마지막 행에 전체 합계까지 조회
*/

-- EMPLOYEE 테이블에서 직급별 급여의 합계를 조회
SELECT
    JOB_CODE,
    SUM(SALARY)
FROM
    EMPLOYEE
GROUP BY
    JOB_CODE
ORDER BY
    JOB_CODE;


 -- 마지막 행에 전체 총 급여의 합계까지 조회    
SELECT
    JOB_CODE,
    SUM(SALARY)
FROM
    EMPLOYEE
GROUP BY
    ROLLUP(JOB_CODE)
ORDER BY
    JOB_CODE;    
    
-- EMPLOYEE 테이블에서 직급 코드와 부서 코드가 같은 사원들의 급여의 합계를 조회

SELECT
    JOB_CODE,
    NVL(DEPT_CODE, '미배치'),
    COUNT(*),
    SUM(SALARY)
FROM
    EMPLOYEE
GROUP BY
    JOB_CODE,
    DEPT_CODE
ORDER BY
    JOB_CODE,
    DEPT_CODE;

SELECT
    JOB_CODE,
    DEPT_CODE,
    COUNT(*),
    SUM(SALARY)
FROM
    EMPLOYEE
GROUP BY
--    ROLLUP(JOB_CODE,
--           DEPT_CODE) -- 컬럼 1을 가지고 중간 집계를 내는 함수
    CUBE(JOB_CODE,
         DEPT_CODE)  -- 전달되는 모든 컬럼을 가지고 중간 집계를 내는 함수
ORDER BY
    JOB_CODE,
    DEPT_CODE;
