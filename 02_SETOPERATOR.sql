/*
    <집합 연산자>
        여러 개의 쿼리문을 하나의 쿼리문으로 만드는 연산자.
        여러 개의 쿠리문에서 조회하려고 하는 컬럼의 개수와 이름이 같아야 집합 연산자를 사용할 수 있다.
        
        1) UNION
        -- EMPLOYEE 테이블에서 부서 코드가 D5인 사원 또는 급여가 300만원 초과인 사원들의 사번,... 조회
*/

-- EMPLOYEE 테이블에서 부서 코드가 D5인 사원들의 사번, 직원명, 부서 코드, 급여를 조회
SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'D5';
    
-- EMPLOYEE 테이블에서 급여가 300만원 초과인 사원들의 사번, 직원명, 부서 코드, 급여를 조회
SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    SALARY > 3000000;
    
-- 1) UNION

SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'D5'
UNION
SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    SALARY > 3000000
ORDER BY
    EMP_NAME;

-- 위 쿼리문 대신 WHERE전에 OR 연산자를 사용해서 처리 가능

-- UNION ALL (중복 제거 하지 않음)
SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'D5'
    OR SALARY > 3000000;

SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'D5'
UNION ALL
SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    SALARY > 3000000;
    
-- 3) INTERSECT 
-- EMPLOYEE 테이블에서 부서 코드가 D5인 사원 또는 급여가 300만원 초과인 사원들의 사번,... 조회  > AND 연산자
SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'D5'
    OR SALARY > 3000000;

SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'D5'
INTERSECT
SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    SALARY > 3000000;
   
-- 위 커리문 대신 AND 연산자를 통해 처리 가능    

SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
        DEPT_CODE = 'D5'
    AND SALARY > 3000000;
    
-- 4) MINUS
-- 부서 코드가 D5인 사원들 중에서 급여가 300만원 초과인 사원 들은 제외해서 조회
SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'D5'
    OR SALARY > 3000000;

SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'D5'
MINUS
SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    SALARY > 3000000;

-- 위 커리문 대신 AND 연산자 사용해서 사용 가능

SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
        DEPT_CODE = 'D5'
    AND SALARY <= 3000000;
    
/*
    <GROUPING SETS>
*/  
-- 부서별 사원수

SELECT
    NVL(DEPT_CODE, '미배치'),
    COUNT(*)
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE
ORDER BY
    DEPT_CODE;

-- 직급별 사원수

SELECT
    NVL(JOB_CODE, '직급없음'),
    COUNT(*)
FROM
    EMPLOYEE
GROUP BY
    JOB_CODE
ORDER BY
    JOB_CODE;
    
-- 부서별, 직급별 사원수
-- 1) UNION ALL 연산자를 사용하는 방법
SELECT
    NVL(DEPT_CODE, '미배치'),
    COUNT(*)
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE
UNION ALL
SELECT
    NVL(JOB_CODE, '직급없음'),
    COUNT(*)
FROM
    EMPLOYEE
GROUP BY
    JOB_CODE;
    
-- 부서별, 직급별 사원수    
-- 2) GROUPING SETS 함수를 사용하는 방법
SELECT
    DEPT_CODE,
    JOB_CODE,
    COUNT(*)
FROM
    EMPLOYEE
GROUP BY
    GROUPING SETS ( DEPT_CODE,
                    JOB_CODE )
ORDER BY
    DEPT_CODE,
    JOB_CODE;
    
 -- EMPLOYEE 테이블에서 부서 코드, 직급 코드, 사수 사번이 동일한 사원의 급여 평균 조회
SELECT
    DEPT_CODE,
    JOB_CODE,
    MANAGER_ID,
    COUNT(*),
    TO_CHAR(FLOOR(AVG(SALARY)),
            '99,999,999L')
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE,
    JOB_CODE,
    MANAGER_ID
HAVING
    COUNT(*) > 1
ORDER BY
    DEPT_CODE,
    JOB_CODE,
    MANAGER_ID;
 
 -- EMPLOYEE 테이블에서 부서 코드, 사수 사번이 동일한 사원의 급여 평균 조회
SELECT
    DEPT_CODE,
    MANAGER_ID,
    COUNT(*),
    TO_CHAR(FLOOR(AVG(SALARY)),
            '99,999,999L')
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE,
    MANAGER_ID
HAVING
    COUNT(*) > 1
ORDER BY
    DEPT_CODE,
    MANAGER_ID;

 
 -- EMPLOYEE 테이블에서 직급 코드, 사수 사번이 동일한 사원의 급여 평균 조회
SELECT
    JOB_CODE,
    MANAGER_ID,
    COUNT(*),
    TO_CHAR(FLOOR(AVG(SALARY)),
            '99,999,999L')
FROM
    EMPLOYEE
GROUP BY
    JOB_CODE,
    MANAGER_ID
HAVING
    COUNT(*) > 1
ORDER BY
    JOB_CODE,
    MANAGER_ID;
    
 -- 위 커리를 각각 실행해서 합친 것과 동일한 결과를 갖는 쿼리문   

SELECT
    DEPT_CODE,
    JOB_CODE,
    MANAGER_ID,
    COUNT(*),
    TO_CHAR(FLOOR(AVG(SALARY)),
            '99,999,999L')
FROM
    EMPLOYEE
GROUP BY
    GROUPING SETS ( ( DEPT_CODE,
                      JOB_CODE,
                      MANAGER_ID ), ( DEPT_CODE,
                                      MANAGER_ID ), ( JOB_CODE,
                                                      MANAGER_ID ) )
HAVING
    COUNT(*) > 1;