/*
    <UPDATE>
        테이블에 기록된 데이터를 수정하는 구문이다.
        [표현법]
            UPDATE 테이블명
            SET 컬럼명 = 변경하려는 값,
                컬럼명 = 변경하려는 값,
                ...
            WHERE 조건;
            
            UPDATE 테이블명 (이때, 서브쿼리는 단일결과값을 가지는 쿼리여야 한다.)
            SET 컬럼명 = (서브 쿼리),
                컬럼명 = (서브 쿼리),
                ...
            [WHERE 조건]
            
*/

-- 테스트를 진행할 테이블 생성

CREATE TABLE DEPT_COPY
    AS
        SELECT
            *
        FROM
            DEPARTMENT;

CREATE TABLE EMP_SALARY
    AS
        SELECT
            EMP_ID,
            EMP_NAME,
            DEPT_CODE,
            SALARY,
            BONUS
        FROM
            EMPLOYEE;

-- EMP_SALARY 테이블에서 노옹철 사원의 급여를 100만원으로 변경
UPDATE EMP_SALARY
SET
    SALARY = 1000000
WHERE
    EMP_NAME = '노옹철';

SELECT
    *
FROM
    EMP_SALARY;

-- EMP_SALARY 테이블에서 선동일 사장의 급여를 700만원으로 변경 보너스도 삭감 0.2로
UPDATE EMP_SALARY
SET SALARY = 7000000,
    BONUS = 0.2



-- 모든 사원의 급여를 기존 급여에서 10프로 인상한 금액(급여 *1.1)로 변경

UPDATE EMP_SALARY
SET
    SALARY = SALARY * 1.1;

-- EMPLOYEE 테이블에 사번이 200번인 사원의 사원번호를 NULL로 변경
UPDATE EMPLOYEE
SET
    EMP_ID = NULL
WHERE
    EMP_ID = 200;

SELECT
    *
FROM
    DEPT_COPY;

-- DEPT_COPY 테이블에서 DEPT_ID가 D9인 부서명을 '미래전략전기획팀'으로 수정
UPDATE DEPT_COPY
SET
    DEPT_TITLE = '미래전략기획팀'
WHERE
    DEPT_ID = 'D9';
    
-- EMPLOYEE 테이블에 노옹철 사원의 부서 코드를 D0으로 변경

UPDATE EMPLOYEE
SET
    DEPT_CODE = 'D0'
WHERE
    EMP_NAME = '노옹철';

ROLLBACK;


-- UPDATE 시 서브쿼리를 사용할 수 있다.
-- 방명수 사원의 급여와 보너스를 유재식 사원과 동일하게 변경

SELECT
    SALARY,
    BONUS
FROM
    EMP_SALARY
WHERE
    EMP_NAME = '유재식';

-- 1) 단일행 서브쿼리를 각각의 컬럼에 적용
UPDATE EMP_SALARY
SET
    SALARY = (
        SELECT
            SALARY
        FROM
            EMP_SALARY
        WHERE
            EMP_NAME = '유재식'
    ),
    BONUS = (
        SELECT
            BONUS
        FROM
            EMP_SALARY
        WHERE
            EMP_NAME = '유재식'
    )
WHERE
    EMP_NAME = '방명수';

SELECT
    *
FROM
    EMP_SALARY
WHERE
    EMP_NAME = '방명수';

UPDATE EMP_SALARY
SET
    ( SALARY,
      BONUS ) = (
        (
            SELECT
                SALARY,
                BONUS
            FROM
                EMP_SALARY
            WHERE
                EMP_NAME = '유재식'
        )
    )
WHERE
    EMP_NAME = '방명수';


-- EMP_SALARY 테이블에서 아시아 지역에 근무하는 직원들의 보너스를 0.3으로 변경


UPDATE EMP_SALARY
SET
    BONUS = 0.3
WHERE
    EMP_ID IN (
        SELECT
            EMP_ID
        FROM
                 EMP_SALARY S
            JOIN DEPT_COPY D ON ( S.DEPT_CODE = D.DEPT_ID )
            JOIN LOCATION  L ON ( D.LOCATION_ID = L.LOCAL_CODE )
        WHERE
            L.LOCAL_NAME LIKE 'ASIA%'
    );

SELECT
    *
FROM
    EMP_SALARY;


