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
    
/*
    <LIKE>
        '%' : 0글자 이상
            EX) 컬럼명 LIKE '문자%' > 컬럼값 중 '문자'로 시작하는 모든 행을 조회한다.
                컬럼명 LIKE '%문자' > 컬럼값 중 '문자'로 끝나는 모든 행을 조회한다.
                컬럼명 LIKE '%문자%' > 컬럼값 중 '문자'가 포함되어 있는 모든 행 조회한다.
            
        '_' : 1글자
            EX) 컬럼명 LIKE '_문자' > 컬럼값 중에 '문자' 앞에 무조건 한 글자가 오는 모든 행을 조회한다.
                컬럼명 LIKE '__문자' > 컬럼값 중에 '문자' 앞에 무조건 두 글자가 오는 모든 행을 조회한다.
                
*/
-- EMPLOYEE 테이블에서 성이 전 씨인 사원의 직원명, 급여, 입사일 조회

SELECT
    EMP_NAME,
    SALARY,
    HIRE_DATE
FROM
    EMPLOYEE
WHERE
    EMP_NAME LIKE '전%';
    
-- EMPLOYEE 테이블에서 이름 중에 '하'가 포함된 직원의 직원명, 주민번호, 부서 코드 조회

SELECT
    EMP_NAME,
    EMP_NO,
    DEPT_CODE
FROM
    EMPLOYEE
WHERE
    EMP_NAME LIKE '%하%';
    
-- EMPLOYEE 테이블에서 김씨 성이 아닌 사원의 사번, 직원명, 입사일 조회

SELECT
    EMP_ID,
    EMP_NAME,
    HIRE_DATE
FROM
    EMPLOYEE
WHERE
    NOT EMP_NAME LIKE '김%';
-- EMP_NAME NOT LIKE '김%';
-- WHERE NOT EMP_NAME NOT LIKE 도 가능!(TRUE)

-- EMPLOYEE 테이블에서 전화번호 4번째 자리가 9로 시작하는 사원의 사번, 직원명, 전화번호, 이메일 조회
-- 와일드 카드 : _(1글자), %(0글자 이상)
SELECT
    EMP_ID,
    EMP_NAME,
    PHONE,
    EMAIL
FROM
    EMPLOYEE
WHERE
    PHONE LIKE '___9%';


-- EMPLOYEE 테이블에서 이메일 중 _ 앞 글자가 3자리인 이메일 주소를 가진 사원의 사번, 직원명, 이메일 조회
SELECT
    EMP_ID,
    EMP_NAME,
    EMAIL
FROM
    EMPLOYEE
WHERE
    EMAIL LIKE '___#_%' ESCAPE '#'; -- 와일드 카드와 데이터 값이 구분이 되지 않는다.
-- WHERE EMAIL LIKE '___\_%' ESCAPE '\'; 데이터로 처리할 값 앞에 임의의 문자를 제시하고 임의의 문자를 ESCAPE 옵션에 등록
--    EMAIL LIKE '___\\%' ESCAPE '\'; 첫번째 탈출문자 다음은 그냥 문자로 취급됨. 이 경우에도 \를 포함한 컬럼을 조회

-- 실습 문제
-- 1. EMPLOYEE 테이블에서 이름 끝이 '연'으로 끝나는 사원의 직원명, 입사일 조회
SELECT
    EMP_NAME,
    HIRE_DATE
FROM
    EMPLOYEE
WHERE
    EMP_NAME LIKE '%연';
    
-- 2 EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 나닌 사원의 이름, 전화번호 조회

SELECT
    EMP_NAME,
    PHONE
FROM
    EMPLOYEE
WHERE
    PHONE NOT LIKE '010%';
    
-- 3. DEPARTMENT TABLE에서 해외 영업부에 대한 모든 컬럼을 조회

SELECT
    *
FROM
    DEPARTMENT
WHERE
    DEPT_TITLE LIKE '해외영업%';
    
/*
    <IS NULL>
*/

-- EMPLOYEE 테이블에서 BONUS를 받지 않는 사원의 사번, 직원명, 급여, 보너스 조회

SELECT
    EMP_ID,
    EMP_NAME,
    SALARY,
    BONUS
FROM
    EMPLOYEE
--WHERE BONUS IS NULL 은 조회되지 않음. NULL은 비교 연산자로 비교할 수 없다.
WHERE
    BONUS IS NULL;
    
-- EMPLOYEE 테이블에서 관리자(사수)가 없는 사원의 이름, 부서 코드 조회
SELECT
    EMP_NAME,
    DEPT_CODE,
    MANAGER_ID
FROM
    EMPLOYEE
WHERE
    MANAGER_ID IS NULL;

-- EMPLOYEE 테이블에서 관리자도 없고 부서도 배치 받지 않은 이름, 부서 코드 조회
SELECT
    EMP_NAME,
    DEPT_CODE,
    MANAGER_ID
FROM
    EMPLOYEE
WHERE
    MANAGER_ID IS NULL
    AND DEPT_CODE IS NULL;   


-- EMPLOYEE 테이블에서 부서 배치를 받진 않았지만 보너스를 받는 사원의 직원명, 부서 코드, 보너스 조회

SELECT
    EMP_NAME,
    DEPT_CODE,
    SALARY,
    BONUS
FROM
    EMPLOYEE
WHERE
    DEPT_CODE IS NULL
    AND BONUS IS NOT NULL;
    
/*
    <IN>
*/
-- EMPLOYEE 테이블에서 부서 코드가 'D5', 'D6', 'D8'인 부서원들의 직원명, 부서 코드, 급여 조회
SELECT
    EMP_NAME,
    DEPT_CODE,
    SALARY
FROM
    EMPLOYEE
WHERE 
-- 기존 방식
--  DEPT_CODE = 'D5' OR DEPT_CODE = 'D6' OR DEPT_CODE = 'D8';
    DEPT_CODE IN ( 'D5', 'D6', 'D8' ) --IN 사용
ORDER BY
    DEPT_CODE;
    
/*
    <연산자 우선순위>
*/

-- EMPLOYEE 테이블에서 직급 코드가 J2 또는 J1인 사원 들 중 급여가 200만원 이상인 사원들의 직원명, 직급 코드, 급여 조회
SELECT
    EMP_NAME,
    JOB_CODE,
    SALARY
FROM
    EMPLOYEE

-- OR 보다 AND가 먼저 수행된다. 아래 식의 값에는 J4 중 월급이 200만원 미만인 사람이 조회됨.
/*
WHERE
    JOB_CODE = 'J4'
    OR JOB_CODE = 'J7'
    AND SALARY >= 2000000;

WHERE --괄호를 넣어서 해결
    (JOB_CODE = 'J4'
    OR JOB_CODE = 'J7')
    AND SALARY >= 2000000;
*/
WHERE --IN은 논리 연산자보다 우선순위가 높으므로 아래와 같이 해도 된다.
    JOB_CODE IN ( 'J4', 'J7' )
    AND SALARY >= 2000000;