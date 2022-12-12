/*
        <SELECT>
            [표현법]
            SELECT 칼럼명 [, 칼럼명, ... ]
            FROM 테이블명

*/
-- EMPLOYEE 테이블에서 전체 사원들의 사번, 이름, 급여만 조회
SELECT
    EMP_ID,
    EMP_NAME,
    SALARY
FROM
    EMPLOYEE;

-- 쿼리는 대소문자를 가리지 않지만 관례상 대문자로 작성한다.
SELECT
    EMP_ID,
    EMP_NAME,
    SALARY
FROM
    EMPLOYEE;

-- EMPLOYEE 테이블에서 전체 사원들의 모든 컬럼 조회
SELECT
    *
FROM
    EMPLOYEE;

-- 현재 계정이 소유한 테이블의 목록 조회
SELECT
    *
FROM
    TABS;

-- 테이블 구조 확인 (컬럼 정보)
DESCRIBE EMPLOYEE;



------------------------  실습문제 -----------------------------

-- 1. JOB 테이블의 모든 컬럼 조회

-- 2. JOB 테이블의 직급명 컬럼만 조회

-- 3. DEPARTMENT 테이블의 모든 컬럼 조회

-- 4. EMPLOYEE 테이블의 직원명, 이메일, 전화번호, 입사일 조회

-- 5. EMPLOYEE 테이블의 입사일, 직원명, 급여 조회

----------------------------------------------------------------

-- 1. JOB 테이블의 모든 컬럼 조회
SELECT
    *
FROM
    JOB;

-- 2. JOB 테이블의 직급명 컬럼만 조회
SELECT
    JOB_NAME
FROM
    JOB;

-- 3. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT
    *
FROM
    DEPARTMENT;

-- 4. EMPLOYEE 테이블의 직원명, 이메일, 전화번호, 입사일 조회
SELECT
    EMP_NAME,
    EMAIL,
    PHONE,
    HIRE_DATE
FROM
    EMPLOYEE;

-- 5. EMPLOYEE 테이블의 입사일, 직원명, 급여 조회
SELECT
    HIRE_DATE,
    EMP_NAME,
    SALARY
FROM
    EMPLOYEE;



/*
    <컬럼의 산술 연산>

*/
-- EMPLOYEE 테이블에서 직원명, 직원의 연봉(급여*12) 조회
SELECT
    EMP_NAME,
    SALARY,
    SALARY * 12 AS 연봉
FROM
    EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 연봉, 보너스가 포함된 연봉((급여 + (보너스 * 급여)))* 12 조회
-- 산술 연산 중 NULL 값이 존재할 경우 결과는 무조건 NULL이다.

SELECT
    EMP_NAME,
    SALARY,
    SALARY * 12,
    ( SALARY + BONUS * SALARY ) * 12         AS "보너스가 포함된 연봉",
    ( SALARY + NVL(BONUS, 0) * SALARY ) * 12 AS "NULL값을 처리한 보너스"
FROM
    EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 입사일, 근무일수(오늘 날짜 - 입사일 )
-- SYSDATE는 현재 날짜를 출력한다.
SELECT
    SYSDATE
FROM
    DUAL;

-- DATA 타입도 연산이 가능하다.
SELECT
    EMP_NAME,
    HIRE_DATE,
    CEIL(SYSDATE - HIRE_DATE) --매개값으로 전달되는 수를 올림하는 함수
FROM
    EMPLOYEE;

/*
    <컬럼 별칭>
      [표현법]
      컬럼 AS 별칭 / 컬럼 AS "별칭" / 컬럼 별칭 / 컬럼 "별칭"
*/

-- EMPLOYEE 테이블에서 직원명, 연봉, 보너스가 포함된 연봉((급여 + (보너스 * 급여)))* 12 조회

SELECT
    EMP_NAME                             AS 직원명,
    SALARY * 12                          AS "연봉",
    ( SALARY + ( BONUS * SALARY ) ) * 12 "총 소득(원)"
FROM
    EMPLOYEE;

/*
    <리터럴>

*/
-- SELECT 리터럴을 하면 해당 테이블의 행만큼 반복해 출력
SELECT
    1
FROM
    EMPLOYEE;

-- DUAL을 사용해 계산식 확인
SELECT
    8
FROM
    DUAL;

-- EMPLOYEE 테이블에서 사번, 직원명, 급여, 단위(원) 조회
SELECT
    EMP_ID   사번,
    EMP_NAME 직원명,
    SALARY   급여,
    '원'      AS "단위(원)"
FROM
    EMPLOYEE;

/*
    <DISTINCT>
    
    

*/
-- EMPLOYEE TABLE에서 직원 코드 조회
SELECT
    JOB_CODE
FROM
    EMPLOYEE;

-- EMPLOY 테이블에서 직급 코드(중복을 제외하고) 조회
SELECT DISTINCT
    JOB_CODE
FROM
    EMPLOYEE
ORDER BY
    JOB_CODE DESC;

-- EMPLOYEE 테이블에서 부서 코드(중복을 제외하고) 조회
SELECT DISTINCT
    DEPT_CODE
FROM
    EMPLOYEE
ORDER BY
    DEPT_CODE DESC; -- 내림차순

-- DISTINCT 는 SELECT절에 한 번만 기술할 수 있다.
-- SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
SELECT DISTINCT
    JOB_CODE,
    DEPT_CODE
FROM
    EMPLOYEE;

/*
    <WHERE>
      [표현법]
        SELECT 컬럼[, 컬럼, ... ]
        FROM 테이블
        WHERE 조건식;
*/

-- EMPLOY 테이블에서 부서 코드가 D9와 일치하는 사원들의 모든 컬럼 조회
SELECT
    *
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'D9';

-- EMPLOYEE 테이블에서 부서 코드가 D9와 일치하는 사원들의 직원명, 부서 코드, 급여 조회
SELECT
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'D9';


-- EMPLOYEE 테이블에서 부서 코드가 D9와 일치하지 않는 사원들의 사번, WLR원명, 부서코드 조회
SELECT
    EMP_ID,
    EMP_NAME,
    DEPT_CODE
FROM
    EMPLOYEE
WHERE
    DEPT_CODE != 'D9';

SELECT
    EMP_NAME,
    DEPT_CODE
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'J1';
-- 위도 가능 --



--- EMPLOYEE 테이블에서 급여가 400만원 이상인 직원명, 부서코드, 급여
SELECT
    EMP_NAME  AS 직원명,
    DEPT_CODE AS "부서 코드",
    SALARY    AS "급여"
FROM
    EMPLOYEE
WHERE
    SALARY >= 4000000;

---------------------- 실습 문제 --------------------------
-- 1. EMPLOYEE 테이블에서 재직 중인 직원들의 사번, 직원명, 입사일 조회

-- 2. EMP 테이블에서 급여가 300만원 이상인 직원의 직원명, 급여 , 입사일

-- 3. EMP 테이블에서 연봉이 5000만원 이상인 직원의 직원명, 급여, 연봉, 입사일
----------------------------------------------------------

--1.
SELECT
    EMP_ID    AS "사번",
    EMP_NAME  AS "직원명",
    HIRE_DATE AS "입사일",
    '재직중'     근무여부
FROM
    EMPLOYEE
WHERE
    ENT_YN = 'N';

--2.
SELECT
    EMP_NAME  AS "직원명",
    SALARY    AS "급여",
    HIRE_DATE AS "입사일"
FROM
    EMPLOYEE
WHERE
    SALARY >= 3000000;

--3.
SELECT
    EMP_NAME         AS "직원명",
    SALARY           AS "급여",
    SALARY * 12 + 10 AS "연봉",
    HIRE_DATE        AS "입사일"
FROM
    EMPLOYEE
WHERE
    SALARY * 12 >= 50000000;

/*
    <ORDER BY>
      [표현법]
        SELECT 컬럼[, 컬럼, ... ]
        FROM 테이블
        WHERE 조건식;
        ORDER BY 컬럼명 | 별칭 | 컬럼순번 [ASC | DESC] [NULLS FIRST | NULLS LAST] ; 

    <SELECT문의 실행 순서>
        1. FROM
        2. WHERE
        3. SELECT
        4. ORDER BY 
*/

    -- EMPLOYEE 테이블에서 BONUS로 오름차순 정렬

SELECT
    *
FROM
    EMPLOYEE
ORDER BY
    BONUS; 

    
    -- EMPLOYEE 테이블에서 BONUS로 내림차순 정렬
SELECT
    *
FROM
    EMPLOYEE
-- ORDER BY BONUS DESC NULLS LAST 내림차순 정렬은 기본적으로 NULLS FIRST
ORDER BY
    BONUS DESC NULLS LAST,
    SALARY DESC; -- 정렬 기준 여러 개를 제시할 수 없다.
    
--    EMPLOY 테이블에서 연봉별 내림차순으로 정렬된 직원들의 직원명, 연봉 조회
SELECT
    EMP_NAME    직원명,
    SALARY * 12 연봉
FROM
    EMPLOYEE
--    ORDER BY "연봉" DESC; -- 별칭 사용
ORDER BY
    2 DESC; -- COLUMN의 순서로 오더바이    

/*
    <연결 연산자>

*/
-- EMPLOYEE 테이블에서 사번, 직원명, 급여를 연결해서 조회

SELECT
    EMP_ID
    || EMP_NAME
    || SALARY
FROM
    EMPLOYEE;

-- EMPLOY 테이블에서 직원명, 급여를 리터럴과 연결해서 조회
SELECT
    EMP_NAME
    || '의 월급은 '
    || SALARY
    || '원입니다.' AS "급여정보"
FROM
    EMPLOYEE;

/*
    <논리 연산자, 비교 연산자>

*/

-- EMPLOYEE 테이블에서 부서 코드가 D6이면서 급여가 300만원 이상인 직원들의 사번, 직원명, 부서 코드, 급여 조회

SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
        DEPT_CODE = 'D6'
    AND SALARY >= 3000000;

-- EMPLOYEE 테이블에서 부서 코드가 D5이거나 급여가 500만원 이상인 직원들의 사번, 직원명, 부서 코드, 급여 조회

SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'D5'
    OR SALARY >= 5000000;

-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하를 받는 직원들의 사번, 직원명 부서 코드, 급여 조회

SELECT
    EMP_ID,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
        SALARY >= 3500000
    AND SALARY <= 6000000
ORDER BY
    SALARY;
    

/*
        <BETWEEN AND>
*/
-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하를 받는 직원들의 사번, 직원명, 부서 코드, 급여 조회

SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE
    SALARY BETWEEN 3500000 AND 6000000
ORDER BY
    SALARY;
    
-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하가 아닌 직원들의 사번, 직원명, 부서 코드, 급여 조회

SELECT
    EMP_NO,
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
--WHERE
--    SALARY NOT BETWEEN 3500000 AND 6000000
WHERE
    NOT SALARY BETWEEN 3500000 AND 6000000
ORDER BY
    SALARY;
    
-- EMPLOY 테이블에서 입사일이 '90/01/01'부터 '01/01/01'인 사원들의 모든 컬럼 조회
SELECT
    *
FROM
    EMPLOYEE
WHERE
    HIRE_DATE BETWEEN '90/01/01' AND '01/01/01'
ORDER BY
    HIRE_DATE DESC;
    
    
-- EMPLOY 테이블에서 입사일이 '90/01/01'부터 '01/01/01'이 아닌 사원들의 모든 컬럼 조회
SELECT
    *
FROM
    EMPLOYEE
WHERE
    NOT HIRE_DATE BETWEEN '90/01/01' AND '01/01/01'
ORDER BY
    HIRE_DATE DESC;