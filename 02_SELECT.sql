/*
        <SELECT>
            [표현법]
            SELECT 칼럼명 [, 칼럼명, ... ]
            FROM 테이블명

*/
-- EMPLOYEE 테이블에서 전체 사원들의 사번, 이름, 급여만 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- 쿼리는 대소문자를 가리지 않지만 관례상 대문자로 작성한다.
Select Emp_Id, Emp_Name, Salary
From Employee;

-- EMPLOYEE 테이블에서 전체 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE;

-- 현재 계정이 소유한 테이블의 목록 조회
SELECT *
FROM TABS;

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
SELECT *
FROM JOB;

-- 2. JOB 테이블의 직급명 컬럼만 조회
SELECT JOB_NAME
FROM JOB;

-- 3. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT;

-- 4. EMPLOYEE 테이블의 직원명, 이메일, 전화번호, 입사일 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE 
FROM EMPLOYEE;




