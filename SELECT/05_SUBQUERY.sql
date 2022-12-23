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

SELECT
    E.EMP_ID,
    E.EMP_NAME,
    E.PHONE,
    J.JOB_NAME,
    D.DEPT_TITLE,
    E.HIRE_DATE
FROM
    EMPLOYEE   E
    RIGHT OUTER JOIN JOB        J USING ( JOB_CODE )
    LEFT OUTER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
WHERE
        D.DEPT_ID = (
            SELECT
                DEPT_CODE
            FROM
                EMPLOYEE
            WHERE
                EMP_NAME = '전지연'
        )
    AND E.EMP_NAME != '전지연';
    
--ORACLE

SELECT
    E.EMP_ID,
    E.EMP_NAME,
    E.PHONE,
    J.JOB_NAME,
    D.DEPT_TITLE,
    E.HIRE_DATE
FROM
    EMPLOYEE   E,
    JOB        J,
    DEPARTMENT D
WHERE
        J.JOB_CODE = E.JOB_CODE
    AND E.DEPT_CODE = D.DEPT_ID
    AND D.DEPT_ID = (
        SELECT
            DEPT_CODE
        FROM
            EMPLOYEE
        WHERE
            EMP_NAME = '전지연'
    )
    AND E.EMP_NAME != '전지연';
    
 /*
 
    2. 다중행 서브 쿼리
        서브 쿼리의 조회 결과 값의 개수가 여러 행일 때(열은 하나)
 
        하나의 값에 대해서 비교하는 연산자들은 사용할 수 없다.
        여러 값을 비교하는 연산자 (IN / NOT IN 등)
        
        ANY(값, 값, ...) : 여러 개의 값들 중 한 개라도 만족하면 TRUE 리턴, IN과의 차이점은 비교 연산자를 함께 사용하는 것이다.
                            SALARY = ANY(...) : IN 같은 결과
                            SALARY > ANY(...) : 최소값보다 크면 TRUE 리턴
                            SALARY < ANY(...) : 최대값보다 작으면 TRUE 리턴
        
        ALL(값, 값, 값) : 여러 개의 값들 중에서 조건을 모두 만족하면 TRUE 리턴한다. 비교 연산자를 함께 사용한다.
                            SALARY != ALL(...) : 모든 값들과 같지 않으면 TRUE 리턴
                            SALARY > ALL(...) : 최대값보다 크면 TRUE 리턴
                            SALARY < ALL(...) : 최소값보다 작으면 TRUE 리턴
 */
  -- 각 부서별 최고 급여를 받는 직원의 이름, 직급 코드, 부서 코드, 급여 조회

  -- 부서별 최고 급여
SELECT
    MAX(SALARY)
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE;

SELECT
    EMP_NAME,
    JOB_CODE,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    SALARY IN (
        SELECT
            MAX(SALARY)
        FROM
            EMPLOYEE
        GROUP BY
            DEPT_CODE
    )
ORDER BY
    DEPT_CODE;
    
-- 직원들에 대해 사번, 이름, 부서 코드, 구분(사수/사원)
-- 사수 사번 가져오기 중복 제외(201, 204, 100, 200, 211, 207, 214)
SELECT DISTINCT
    *
FROM
    EMPLOYEE E
    JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID)
WHERE
    E.MANAGER_ID IS NOT NULL;
-- 사수 사번

SELECT
    EMP_ID    사번,
    EMP_NAME  이름,
    DEPT_CODE "부서 코드",
    '사수'      AS 구분
FROM
    EMPLOYEE
WHERE
    EMP_ID IN (
        SELECT DISTINCT
            MANAGER_ID
        FROM
            EMPLOYEE
        WHERE
            MANAGER_ID IS NOT NULL
    )
UNION ALL

-- 사원 데이터 조회
SELECT
    EMP_ID    사번,
    EMP_NAME  이름,
    DEPT_CODE "부서 코드",
    '사원'      AS 구분
FROM
    EMPLOYEE
WHERE
    EMP_ID NOT IN (
        SELECT DISTINCT
            MANAGER_ID
        FROM
            EMPLOYEE
        WHERE
            MANAGER_ID IS NOT NULL
    )
ORDER BY
    사번;
    
-- 위의 결과를 하나로 합쳐 확인 (UNION)    
    
-- SELECT 절에 서브 쿼리를 사용하는 방법

SELECT
    EMP_ID    "사번",
    EMP_NAME  "이름",
    DEPT_CODE "부서 코드",
    CASE
        WHEN EMP_ID IN (
            SELECT DISTINCT
                MANAGER_ID
            FROM
                EMPLOYEE
            WHERE
                MANAGER_ID IS NOT NULL
        ) THEN
            '사수'
        ELSE
            '사원'
    END       AS "구분"
FROM
    EMPLOYEE
ORDER BY
    EMP_ID;
   
   
-- DECODE    
SELECT
    EMP_ID    "사번",
    EMP_NAME  "이름",
    DEPT_CODE "부서 코드",
    DECODE(EMP_ID , , '사수', '사원' ) 
FROM
    EMPLOYEE
ORDER BY
    EMP_ID;


SELECT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;
    
    
-- 대리 직급임에도 과장 직급의 최소 급여보다 급여가 많은 사원의 사번, 이름, 직급, 급여 조회
--
SELECT
    SALARY
FROM
    EMPLOYEE
WHERE
    JOB_CODE = 'J5';

SELECT
    EMP_ID   사번,
    EMP_NAME 이름,
    JOB_CODE 직급,
    SALARY   급여
FROM
    EMPLOYEE
WHERE
    SALARY > ANY (
        SELECT
            SALARY
        FROM
            EMPLOYEE
        WHERE
            JOB_CODE = 'J5'
    )
    AND JOB_CODE = 'J6';
    
-- 과장 직급임에도 차장 직급의 최대 급여보다 더 많이 받는 직원들의 사번, 이름, 직급, 급여 조회 (사원 -> 대리 -> 과장 -> 차장 -> 부장)
-- 차장 직급들의 급여 조회 (2800000, 1550000, 2490000, 2480000)
SELECT
    SALARY
FROM
    EMPLOYEE
WHERE
    JOB_CODE = 'J4';

SELECT
    EMP_ID,
    EMP_NAME,
    JOB_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    SALARY > ALL (
        SELECT
            SALARY
        FROM
            EMPLOYEE
        WHERE
            JOB_CODE = 'J4'
    )
    AND JOB_CODE = 'J5';
    
/*    
    3. 다중열 서브 쿼리
        조회 결과 값은 한 행이지만 컬럼의 수가 여러 개일 때
 
*/

-- 하이유 사원과 같은 부서 코드, 같은 직급 코드에 해당하는 사원들을 조회

SELECT
    DEPT_CODE,
    JOB_CODE
FROM
    EMPLOYEE
WHERE
    EMP_NAME = '하이유';


-- 부서 코드가 D5이면서 직급 코드가 J5인 사원들 조회
SELECT
    EMP_NAME,
    DEPT_CODE,
    JOB_CODE
FROM
    EMPLOYEE
WHERE
        DEPT_CODE = (
            SELECT
                DEPT_CODE
            FROM
                EMPLOYEE
            WHERE
                EMP_NAME = '하이유'
        )
    AND JOB_CODE = (
        SELECT
            JOB_CODE
        FROM
            EMPLOYEE
        WHERE
            EMP_NAME = '하이유'
    );
    
-- 다중열 서브 쿼리를 사용해서 작성하는 방법

SELECT
    EMP_NAME,
    DEPT_CODE,
    JOB_CODE
FROM
    EMPLOYEE
WHERE
    ( DEPT_CODE,
      JOB_CODE ) = ( ( 'D5',
                       'J5' ) );

SELECT
    EMP_NAME,
    DEPT_CODE,
    JOB_CODE
FROM
    EMPLOYEE
WHERE
    ( DEPT_CODE,
      JOB_CODE ) = (
        SELECT
            DEPT_CODE,
            JOB_CODE
        FROM
            EMPLOYEE
        WHERE
            EMP_NAME = '하이유'
    );
    
-- 박나라 사원과 직급 코드가 일치하면서, 같은 사수를 가지고 있는 사원의 사번, 이름, 직급 코드, 사수 사번 조회
-- 박나라 직급 코드
SELECT
    JOB_CODE
FROM
    EMPLOYEE
WHERE
    EMP_NAME = '박나라';
    
-- 박나라 사수
SELECT
    MANAGER_ID
FROM
    EMPLOYEE
WHERE
    EMP_NAME = '박나라';
 
    
-- 박나라 직코 사수 
SELECT
    JOB_CODE,
    MANAGER_ID
FROM
    EMPLOYEE
WHERE
    EMP_NAME = '박나라';

    
-- 단일행 서브쿼리
SELECT
    EMP_ID,
    EMP_NAME,
    JOB_CODE,
    MANAGER_ID
FROM
    EMPLOYEE
WHERE
        JOB_CODE = (
            SELECT
                JOB_CODE
            FROM
                EMPLOYEE
            WHERE
                EMP_NAME = '박나라'
        )
    AND MANAGER_ID = (
        SELECT
            MANAGER_ID
        FROM
            EMPLOYEE
        WHERE
            EMP_NAME = '박나라'
    );
    
    
-- 비교쌍    
SELECT
    EMP_ID,
    EMP_NAME,
    JOB_CODE,
    MANAGER_ID
FROM
    EMPLOYEE
WHERE
    ( JOB_CODE,
      MANAGER_ID ) = (
        (
            SELECT
                JOB_CODE,
                MANAGER_ID
            FROM
                EMPLOYEE
            WHERE
                EMP_NAME = '박나라'
        )
    );
    
/*
    4. 다중행 다중열 서브 쿼리
        서브 쿼리의 조회 결과값이 여러 행, 여러 열일 경우
*/
-- 각 직급별로 최소 급여를 받는 사원들의 사번, 이름, 직급 코드, 급여 조회
-- 각 직급별 최소 급여
-- (J2,3700000) , (J7, 1380000) ... 

SELECT
    JOB_CODE,
    MIN(SALARY)
FROM
    EMPLOYEE
GROUP BY
    JOB_CODE;

SELECT
    EMP_ID,
    EMP_NAME,
    JOB_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
        JOB_CODE = 'J2'
    AND SALARY = 3700000
    OR JOB_CODE = 'J7'
    AND SALARY = 1380000;

-- 비교쌍 이용
SELECT
    EMP_ID,
    EMP_NAME,
    JOB_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    ( JOB_CODE, SALARY ) IN ( ( 'J2', 3700000 ), ( 'J7', 1380000 ) );

-- 다중행 다중열    
SELECT
    EMP_ID,
    EMP_NAME,
    JOB_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    ( JOB_CODE, SALARY ) IN (
        SELECT
            JOB_CODE, MIN(SALARY)
        FROM
            EMPLOYEE
        GROUP BY
            JOB_CODE
    )
ORDER BY
    JOB_CODE;


-- 각 부서별 최소급여를 받는 사원들의 사번, 이름 부서 코드 급여 조회

SELECT
    EMP_ID,
    EMP_NAME,
    NVL(DEPT_CODE, '부서없음'),
    SALARY
FROM
    EMPLOYEE
WHERE
    ( NVL(DEPT_CODE, '부서없음'), SALARY ) IN ( (
        SELECT
            NVL(DEPT_CODE, '부서없음'), MIN(SALARY)
        FROM
            EMPLOYEE
        GROUP BY
            DEPT_CODE
    ) )
ORDER BY
    DEPT_CODE;
    
/*
        <인라인 뷰> 
        
*/
-- 전 직원 중 급여가 가장 높은 상위 5명 순위, 이름, 급여 조회
-- ROWNUM : 오라클에서 제공하는 컬럼, 조회된 순서대로 1부터 순번을 부여하는 컬럼

SELECT
    ROWNUM,
    EMP_NAME,
    SALARY
FROM
    EMPLOYEE
ORDER BY
    SALARY DESC;
    
--  이미 순번이 정해진 다음에 정렬이 되었다.
-- FROM -> SELECT(ROWNUM) -> ORDER BY


SELECT
    ROWNUM   AS "순위",
    EMP_NAME AS "이름",
    SALARY   AS "급여"
FROM
    (
        SELECT
            EMP_NAME,
            SALARY
        FROM
            EMPLOYEE
        ORDER BY
            SALARY DESC
    )
WHERE
    ROWNUM <= 5;
    
-- 부서별 평균 급여가 높은 3개 부서의 부서 코드, 평균 급여 조회

SELECT
    NVL(DEPT_CODE, '부서없음'),
    AVG(NVL(SALARY, 0))
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE
ORDER BY
    AVG(NVL(SALARY, 0)) DESC;

-- 인라인 뷰
SELECT
    ROWNUM AS "순위",
    "부서 코드",
    FLOOR("평균 급여")
FROM
    (
        SELECT
            NVL(DEPT_CODE, '부서없음') AS "부서 코드",
            AVG(NVL(SALARY, 0))    AS "평균 급여"
        FROM
            EMPLOYEE
        GROUP BY
            DEPT_CODE
        ORDER BY
            AVG(NVL(SALARY, 0)) DESC
    )
WHERE
    ROWNUM <= 3;


-- WITH 사용 구문
WITH TOPN_SAL AS (
    SELECT
        NVL(DEPT_CODE, '부서없음') "부서 코드",
        AVG(NVL(SALARY, 0))    "평균 급여"
    FROM
        EMPLOYEE
    GROUP BY
        DEPT_CODE
    ORDER BY
        AVG(NVL(SALARY, 0)) DESC
)
SELECT
    ROWNUM,
    "부서 코드",
    FLOOR("평균 급여")
FROM
    TOPN_SAL
WHERE
    ROWNUM <= 3;

/*
    <RANK 함수>  
*/

-- 사원별 급여가 높은 순서대로 순위를 매겨서 순위, 직원명, 급여를 조회
-- 공동 19위 2명 뒤에 순위는 21위
SELECT
    RANK()
    OVER(
        ORDER BY
            SALARY DESC
    ) "순위",
    EMP_NAME,
    SALARY
FROM
    EMPLOYEE;

-- 공동 19위 2명 뒤에 순위는 20위    
SELECT
    DENSE_RANK()
    OVER(
        ORDER BY
            SALARY DESC
    ) "순위",
    EMP_NAME,
    SALARY
FROM
    EMPLOYEE;    

-- 상위 5명만 조회
SELECT
    RANK()
    OVER(
        ORDER BY
            SALARY DESC
    ) "순위",
    SALARY
FROM
    EMPLOYEE
--WHERE RANK() OVER(ORDER BY SALARY DESC) "순위" RANK함수는 WHERE절에 사용할 수 없음 > 서브쿼리 사용
    ;

SELECT
    *
FROM
    (
        SELECT
            RANK()
            OVER(
                ORDER BY
                    SALARY DESC
            )      "RANK",
            EMP_NAME,
            SALARY SALARY
        FROM
            EMPLOYEE
    )
WHERE
    RANK <= 5;