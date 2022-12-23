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
    INNER JOIN JOB        J USING ( JOB_CODE );

-------------------------------------------------------------

/*

    2. OUTER JOIN
        - 두 테이블 간의 JOIN 시 일치하지 않는 행도 포함시켜서 조회가 가능ㅎ다.
        단, 반드시 기준이 되는 테이블(컬럼)을 저장해야 한다. (LEFT, RIGHT, FULL, (+))

*/

-- OUTER JOIN과 비교할 INNER JOIN 구문 작성
-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인해서 사원들의 사원명, 부서명, 급여, 연봉

SELECT
    E.EMP_NAME    사원명,
    D.DEPT_TITLE  부서명,
    E.SALARY      급여,
    E.SALARY * 12 연봉
FROM
    EMPLOYEE   E,
    DEPARTMENT D
WHERE
    E.DEPT_CODE = D.DEPT_ID;
    
-- INNER JOIN은 부서가 지정되지 않은 사원 2명에 대한 정보가 조회되지 않음
-- 부서가 지정되어 있어도 DEPARTMENT에 부서에 대한 정보가 없으면 조회되지 않는다.

/*

    1) LEFT OUTER JOIN 
        두 테이블 중 왼편에 기술된 테이블의 갈림을 기준으로 JOIN을 진행한다.
*/

-- ANSI 표준 구문
-- 부서 코드가 없던 사원(이오리, 하동운)의 정보가 출력된다.
SELECT
    E.EMP_NAME    사원명,
    D.DEPT_TITLE  부서명,
    E.SALARY      급여,
    E.SALARY * 12 연봉
FROM
    EMPLOYEE   E
    LEFT OUTER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
 -- OUTER 생략가능   

ORDER BY
    E.DEPT_CODE DESC;
    
-- 오라클 구문
SELECT
    E.EMP_NAME    사원명,
    D.DEPT_TITLE  부서명,
    E.SALARY      급여,
    E.SALARY * 12 연봉
FROM
    EMPLOYEE   E,
    DEPARTMENT D
WHERE
    E.DEPT_CODE = D.DEPT_ID (+)
ORDER BY
    E.DEPT_CODE DESC;
    
/*

    2) RIGHT OUTER JOIN 
        두 테이블 중 오른편에 기술된 테이블의 컬럼을 기준으로 JOIN을 진행한다.
    
*/

-- ANSI 표준 구문
SELECT
    *
FROM
    EMPLOYEE   E
    RIGHT OUTER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
ORDER BY
    E.DEPT_CODE DESC;

-- 오라클 구문
SELECT
    E.EMP_NAME    사원명,
    D.DEPT_TITLE  부서명,
    E.SALARY      급여,
    E.SALARY * 12 연봉
FROM
    EMPLOYEE   E,
    DEPARTMENT D
WHERE
    E.DEPT_CODE (+) = D.DEPT_ID
ORDER BY
    E.DEPT_CODE DESC;
    
/*
    3) FULL OUTER JOIN
        두 테이블이 가진 모든 행을 조회할 수 있다.(단, 오라클 구문은 지원하지 않는다.)
*/

SELECT
    *
FROM
    EMPLOYEE   E
    FULL OUTER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
ORDER BY
    E.DEPT_CODE DESC;
    
 /* 
 
    3. CROSS JOIN
    조인되는 모든 테이블의 각 행들이 서로서로 매핑된 데이터가 검색된다.
 
 */
-- ANSI 표준 구문
SELECT
    E.EMP_NAME,
    D.DEPT_TITLE
FROM
         EMPLOYEE E
    CROSS JOIN DEPARTMENT D
ORDER BY
    E.EMP_NAME;

-- 오라클 구문(JOIN 조건 생략)
SELECT
    E.EMP_NAME,
    D.DEPT_TITLE
FROM
    EMPLOYEE   E,
    DEPARTMENT D
ORDER BY
    E.EMP_NAME;
    
    
/*

    4. NON EQUAL JOIN
        조인 조건에 등호(=)를 사용하지 않는 조인문을 비등가 조인이라고 한다.
        ANSI 구문으로는 JOIN ON 구문으로만 사용이 가능하다. (USING 사용 불가)

*/

-- EMPLOYEE 테이블과 SALARY_GRADE 테이블을 비등가 조인하여 직원명, 급여, 급여 등급을 조회
-- ANSI 표준구문
SELECT
    E.EMP_NAME,
    E.SALARY,
    S.*
FROM
         EMPLOYEE E
    INNER JOIN SAL_GRADE S ON ( E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL );

SELECT
    E.EMP_NAME,
    E.SALARY,
    S.*
FROM
    EMPLOYEE  E
    LEFT OUTER JOIN SAL_GRADE S ON ( E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL );

-- 오라클 구문
SELECT
    E.EMP_NAME,
    E.SALARY,
    S.*
FROM
    EMPLOYEE  E,
    SAL_GRADE S
WHERE
    E.SALARY (+) BETWEEN S.MIN_SAL AND S.MAX_SAL;


-- 방명수 사원(월급이 최저등급 이하인 사원도 포함해서 찾기)    
SELECT
    E.EMP_NAME,
    E.SALARY,
    S.*
FROM
    EMPLOYEE  E,
    SAL_GRADE S
WHERE
    E.SALARY BETWEEN S.MIN_SAL (+) AND S.MAX_SAL (+);
    -- (+)를 둘다 넣어야 함
    
/*
    5. SELF JOIN
        동일한 테이블을 조인하는 경우에 사용한다.

*/
-- EMPLOYEE 테이블을 SELF JOIN하여 사번, 사원 이름, 부서 코드, 사수 사번, 사수 이름
-- ANSI표준 구문

SELECT
    EM.EMP_ID     사번,
    EM.EMP_NAME   사원명,
    EM.DEPT_CODE  부서명,
    EM.MANAGER_ID 사수사번,
    MA.EMP_NAME   사수명
FROM
    EMPLOYEE EM
    LEFT OUTER JOIN EMPLOYEE MA ON ( EM.MANAGER_ID = MA.EMP_ID );

-- 오라클 구문
SELECT
    E.EMP_ID     사번,
    E.EMP_NAME   사원명,
    E.DEPT_CODE  부서명,
    E.MANAGER_ID 사수사번,
    M.EMP_NAME   사수명
FROM
    EMPLOYEE E,
    EMPLOYEE M
WHERE
    E.MANAGER_ID = M.EMP_ID (+);
    
    
/*
    6. 다중 JOIN
        여러 개의 테이블을 조인하는 경우에 사용한다.
    
*/

-- EMPLOYEE, DEPARTMENT, LOCATION 테이블을 다중 JOIN하여 사번, 직원명, 부서명, 지역명을 조회

SELECT
    *
FROM
    EMPLOYEE; -- DEPT_CODE
SELECT
    *
FROM
    DEPARTMENT; -- DEPT_ID , LOCATION_ID
SELECT
    *
FROM
    LOCATION; -- LOCAL_CODE


-- ANSI 표준 구문 (다중 조인은 다중조인의 순서가 중요하다.)

SELECT
    E.EMP_ID,
    E.EMP_NAME,
    D.DEPT_TITLE,
    L.LOCAL_NAME
FROM
         EMPLOYEE E
    INNER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
    INNER JOIN LOCATION   L ON ( D.LOCATION_ID = L.LOCAL_CODE );
    
    
    -- 검색되지 않는 사원들 포함
SELECT
    E.EMP_ID,
    E.EMP_NAME,
    D.DEPT_TITLE,
    L.LOCAL_NAME
FROM
    EMPLOYEE   E
    LEFT OUTER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
    LEFT OUTER JOIN LOCATION   L ON ( D.LOCATION_ID = L.LOCAL_CODE );
    
-- 오라클 구문
-- 지역명이 ASIA1인 사원들만 조회

SELECT
    E.EMP_ID,
    E.EMP_NAME,
    D.DEPT_TITLE,
    L.LOCAL_NAME
FROM
    EMPLOYEE   E,
    DEPARTMENT D,
    LOCATION   L
WHERE
        E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.LOCAL_NAME = 'ASIA1';
    
----------------- 다중 조인 실습 문제 ---------------------   
 
 -- 1.
 -- ANSI
SELECT
    E.EMP_ID        사번,
    E.EMP_NAME      직원명,
    D.DEPT_TITLE    부서명,
    L.LOCAL_NAME    지역명,
    N.NATIONAL_NAME 국가명
FROM
    EMPLOYEE   E
    LEFT OUTER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
    LEFT OUTER JOIN LOCATION   L ON ( D.LOCATION_ID = L.LOCAL_CODE )
    LEFT OUTER JOIN NATIONAL   N ON ( L.NATIONAL_CODE = N.NATIONAL_CODE );
    
    
-- 오라클    
SELECT
    E.EMP_ID        사번,
    E.EMP_NAME      직원명,
    D.DEPT_TITLE    부서명,
    L.LOCAL_NAME    지역명,
    N.NATIONAL_NAME 국가명
FROM
    EMPLOYEE   E,
    DEPARTMENT D,
    LOCATION   L,
    NATIONAL   N,
    SAL_GRADE  S
WHERE
        E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE;
   
-- 2.
-- ANSI
SELECT
    E.EMP_ID        사번,
    E.EMP_NAME      직원명,
    S.SAL_LEVEL     "급여 등급",
    D.DEPT_TITLE    부서명,
    L.LOCAL_NAME    지역명,
    N.NATIONAL_NAME 국가명
FROM
    EMPLOYEE   E
    LEFT OUTER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
    LEFT OUTER JOIN LOCATION   L ON ( D.LOCATION_ID = L.LOCAL_CODE )
    LEFT OUTER JOIN NATIONAL   N ON ( L.NATIONAL_CODE = N.NATIONAL_CODE )
    LEFT OUTER JOIN SAL_GRADE  S ON ( E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL );
       
-- 오라클    
SELECT
    E.EMP_ID        사번,
    E.EMP_NAME      직원명,
    D.DEPT_TITLE    부서명,
    L.LOCAL_NAME    지역명,
    N.NATIONAL_NAME 국가명,
    S.SAL_LEVEL     "급여 등급"
FROM
    EMPLOYEE   E,
    DEPARTMENT D,
    LOCATION   L,
    NATIONAL   N,
    SAL_GRADE  S
WHERE
        E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE
    AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;
    
------------------- 조인 종합 실습 문제 -------------------
-- 1. 직급이 대리이면서 ASIA 지역에서 근무하는 직원들의 사번, 직원명, 직급명, 부서명, 근무지역, 급여를 조회하세요.
-- ANSI 구문

SELECT
    E.EMP_NO     사번,
    E.EMP_NAME   직원명,
    J.JOB_NAME   직급명,
    D.DEPT_TITLE 부서명,
    L.LOCAL_NAME 근무지역,
    E.SALARY     급여
FROM
         EMPLOYEE E
    INNER JOIN JOB        J USING ( JOB_CODE )
    INNER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
    INNER JOIN LOCATION   L ON ( D.LOCATION_ID = L.LOCAL_CODE )
WHERE
        J.JOB_NAME = '대리'
    AND L.LOCAL_NAME LIKE 'ASIA%';

-- 오라클 구문

SELECT
    E.EMP_NO     사번,
    E.EMP_NAME   직원명,
    J.JOB_NAME   직급명,
    D.DEPT_TITLE 부서명,
    L.LOCAL_NAME 근무지역,
    E.SALARY     급여
FROM
    EMPLOYEE   E,
    JOB        J,
    DEPARTMENT D,
    LOCATION   L
WHERE
        E.JOB_CODE = J.JOB_CODE
    AND E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND J.JOB_NAME = '대리'
    AND L.LOCAL_NAME LIKE 'ASIA%';

-- 2. 70년대생 이면서 여자이고, 성이 전 씨인 직원들의 직원명, 주민번호, 부서명, 직급명을 조회하세요.
-- ANSI 구문

SELECT
    E.EMP_NAME,
    E.EMP_NO,
    D.DEPT_TITLE,
    J.JOB_NAME
FROM
         EMPLOYEE E
    INNER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
    INNER JOIN JOB        J USING ( JOB_CODE )
WHERE
        SUBSTR(E.EMP_NO, 1, 1) = '7'
    AND SUBSTR(E.EMP_NO, 8, 1) = 2
    AND E.EMP_NAME LIKE '전%';

-- 오라클 구문




-- 3. 보너스를 받는 직원들의 직원명, 보너스 , 연봉, 부서명, 근무지역을 조회하세요.
--    단, 부서 코드가 없는 사원도 출력될 수 있게 Outer JOIN 사용
-- ANSI 구문

SELECT
    E.EMP_NAME,
    E.BONUS,
    D.DEPT_TITLE,
    L.LOCAL_NAME
FROM
    EMPLOYEE   E
    LEFT OUTER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
    LEFT OUTER JOIN LOCATION   L ON ( D.LOCATION_ID = L.LOCAL_CODE )
WHERE
    BONUS IS NOT NULL;

-- 오라클 구문

SELECT
    E.EMP_NAME,
    E.BONUS,
    D.DEPT_TITLE,
    L.LOCAL_NAME
FROM
    EMPLOYEE   E,
    DEPARTMENT D,
    LOCATION   L
WHERE
        E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND E.BONUS IS NOT NULL;

-- 4. 한국과 일본에서 근무하는 직원들의 직원명, 부서명, 근무지역, 근무 국가를 조회하세요.
-- ANSI 구문
SELECT
    E.EMP_NAME,
    D.DEPT_TITLE,
    L.LOCAL_NAME,
    N.NATIONAL_NAME
FROM
    EMPLOYEE   E
    LEFT OUTER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
    LEFT OUTER JOIN LOCATION   L ON ( D.LOCATION_ID = L.LOCAL_CODE )
    LEFT OUTER JOIN NATIONAL   N ON ( N.NATIONAL_CODE = L.NATIONAL_CODE )
WHERE
    N.NATIONAL_NAME IN ( '한국', '일본' );

-- 오라클 구문
SELECT
    E.EMP_NAME,
    D.DEPT_TITLE,
    L.LOCAL_NAME,
    N.NATIONAL_NAME
FROM
    EMPLOYEE   E,
    DEPARTMENT D,
    LOCATION   L,
    NATIONAL   N
WHERE
    ( E.DEPT_CODE = D.DEPT_ID )
    AND ( D.LOCATION_ID = L.LOCAL_CODE )
    AND ( N.NATIONAL_CODE = L.NATIONAL_CODE )
    AND N.NATIONAL_NAME IN ( '한국', '일본' );

-- 5. 각 부서별 평균 급여를 조회하여 부서명, 평균 급여(정수 처리)를 조회하세요.
--    단, 부서 배치가 안된 사원들의 평균도 같이 나오게끔 해주세요^^
-- ANSI 구문
SELECT
    D.DEPT_TITLE,
    FLOOR(AVG(NVL(SALARY, 0)))
FROM
    EMPLOYEE   E
    LEFT OUTER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
GROUP BY
    D.DEPT_TITLE
ORDER BY
    D.DEPT_TITLE;



-- 오라클 구문
SELECT
    D.DEPT_TITLE,
    ROUND(AVG(NVL(SALARY, 0)))
FROM
    EMPLOYEE   E,
    DEPARTMENT D
WHERE
    ( E.DEPT_CODE = D.DEPT_ID )
GROUP BY
    D.DEPT_TITLE
ORDER BY
    D.DEPT_TITLE;

-- 6. 각 부서별 총 급여의 합이 1000만원 이상인 부서명, 급여의 합을 조회하시오.
-- ANSI 구문

SELECT
    D.DEPT_TITLE,
    SUM(SALARY)
FROM
    EMPLOYEE   E
    LEFT OUTER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
GROUP BY
    D.DEPT_TITLE
HAVING
    SUM(SALARY) >= 10000000
ORDER BY
    D.DEPT_TITLE;



-- 오라클 구문


SELECT
    D.DEPT_TITLE,
    SUM(SALARY)
FROM
    EMPLOYEE   E,
    DEPARTMENT D
WHERE
    E.DEPT_CODE = D.DEPT_ID
GROUP BY
    D.DEPT_TITLE
HAVING
    SUM(SALARY) >= 10000000
ORDER BY
    D.DEPT_TITLE;

-- 7. 사번, 직원명, 직급명, 급여 등급, 구분을 조회
--    이때 구분에 해당하는 값은 아래와 같이 조회 되도록 하시오.
--    급여 등급이 S1, S2인 경우 '고급'
--    급여 등급이 S3, S4인 경우 '중급'
--    급여 등급이 S5, S6인 경우 '초급'
-- ANSI 구문

SELECT
    E.EMP_NO    사번,
    E.EMP_NAME  직원명,
    J.JOB_NAME  직급명,
    G.SAL_LEVEL "급여 등급",
    CASE
        WHEN G.SAL_LEVEL IN ( 'S1', 'S2' ) THEN
            '고급'
        WHEN G.SAL_LEVEL IN ( 'S3', 'S4' ) THEN
            '중급'
        WHEN G.SAL_LEVEL IN ( 'S5', 'S6' ) THEN
            '초급'
    END         구분
FROM
    EMPLOYEE  E
    LEFT OUTER JOIN JOB       J ON ( E.JOB_CODE = J.JOB_CODE )
    LEFT OUTER JOIN SAL_GRADE G ON ( E.SALARY BETWEEN G.MIN_SAL AND G.MAX_SAL );

-- 오라클 구문

SELECT
    E.EMP_NO    사번,
    E.EMP_NAME  직원명,
    J.JOB_NAME  직급명,
    G.SAL_LEVEL "급여 등급",
    CASE
        WHEN G.SAL_LEVEL IN ( 'S1', 'S2' ) THEN
            '고급'
        WHEN G.SAL_LEVEL IN ( 'S3', 'S4' ) THEN
            '중급'
        WHEN G.SAL_LEVEL IN ( 'S5', 'S6' ) THEN
            '초급'
    END         구분
FROM
    EMPLOYEE  E,
    JOB       J,
    SAL_GRADE G
WHERE
    ( E.JOB_CODE = J.JOB_CODE )
    AND ( E.SALARY BETWEEN G.MIN_SAL AND G.MAX_SAL );


-- 8. 보너스를 받지 않는 직원들 중 직급 코드가 J4 또는 J7인 직원들의 직원명, 직급명, 급여를 조회하시오.
-- ANSI 구문
- ANSI 구문

SELECT
    E.EMP_NAME,
    J.JOB_NAME,
    E.SALARY
FROM
    EMPLOYEE E
    LEFT OUTER JOIN JOB      J ON ( E.JOB_CODE = J.JOB_CODE )
WHERE
    BONUS IS NULL
    AND E.JOB_CODE IN ( 'J4', 'J7' );


-- 오라클 구문

SELECT
    E.EMP_NAME,
    J.JOB_NAME,
    E.SALARY
FROM
    EMPLOYEE E,
    JOB      J
WHERE
    ( E.JOB_CODE = J.JOB_CODE )
    AND BONUS IS NULL
    AND E.JOB_CODE IN ( 'J4', 'J7' );

-- 9. 부서가 있는 직원들의 직원명, 직급명, 부서명, 근무 지역을 조회하시오.
-- ANSI 구문

SELECT
    E.EMP_NAME,
    J.JOB_NAME,
    D.DEPT_TITLE,
    L.LOCAL_NAME
FROM
    EMPLOYEE   E
    LEFT OUTER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
    LEFT OUTER JOIN LOCATION   L ON ( D.LOCATION_ID = L.LOCAL_CODE )
    LEFT OUTER JOIN JOB        J USING ( JOB_CODE )
WHERE
    DEPT_CODE IS NOT NULL;

-- 오라클 구문

SELECT
    E.EMP_NAME,
    J.JOB_NAME,
    D.DEPT_TITLE,
    L.LOCAL_NAME
FROM
    EMPLOYEE   E,
    DEPARTMENT D,
    LOCATION   L,
    JOB        J
WHERE
        E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND E.JOB_CODE = J.JOB_CODE
    AND DEPT_CODE IS NOT NULL;
    
-- 10. 해외영업팀에 근무하는 직원들의 직원명, 직급명, 부서 코드, 부서명을 조회하시오.
-- ANSI 구문

SELECT
    E.EMP_NAME,
    J.JOB_NAME,
    J.JOB_CODE,
    D.DEPT_TITLE
FROM
    EMPLOYEE   E
    LEFT OUTER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
    LEFT OUTER JOIN JOB        J ON ( E.JOB_CODE = J.JOB_CODE )
    LEFT OUTER JOIN LOCATION   L ON ( D.LOCATION_ID = L.LOCAL_CODE )
WHERE
    D.DEPT_TITLE LIKE '해외영업%'
ORDER BY
    D.DEPT_TITLE;


-- 오라클 구문

SELECT
    E.EMP_NAME,
    J.JOB_NAME,
    J.JOB_CODE,
    D.DEPT_TITLE
FROM
    EMPLOYEE   E,
    DEPARTMENT D,
    JOB        J,
    LOCATION   L
WHERE
        E.DEPT_CODE = D.DEPT_ID
    AND E.JOB_CODE = J.JOB_CODE
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND D.DEPT_TITLE LIKE '해외영업%';

-- 11. 이름에 '형'자가 들어있는 직원들의 사번, 직원명, 직급명을 조회하시오.
-- ANSI 구문
SELECT
    E.EMP_ID,
    E.EMP_NAME,
    J.JOB_NAME
FROM
    EMPLOYEE E
    LEFT OUTER JOIN JOB      J USING ( JOB_CODE )
WHERE
    E.EMP_NAME LIKE '%형%';

-- 오라클 구문
SELECT
    E.EMP_ID,
    E.EMP_NAME,
    J.JOB_NAME
FROM
    EMPLOYEE E,
    JOB      J
WHERE
        E.JOB_CODE = J.JOB_CODE
    AND E.EMP_NAME LIKE '%형%';

---------------------------------------------------------  