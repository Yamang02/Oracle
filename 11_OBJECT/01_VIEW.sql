/*
    <VIEW>
        SELECT 구문을 저장할 수 있는 객체이다.
        데이터를 저장하고 있지 않으며 VIEW에 접근할 때 SQL을 수행하면서 결과값을 가져온다.
    
*/

-- '한국'에서 근무하는 사원의 사번, 이름, 부서명, 급여, 근무 국가명을 조회
SELECT
    E.EMP_NO,
    E.EMP_NAME,
    D.DEPT_TITLE,
    E.SALARY,
    N.NATIONAL_NAME
FROM
    EMPLOYEE   E,
    DEPARTMENT D,
    LOCATION   L,
    NATIONAL   N
WHERE
        E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE
    AND N.NATIONAL_NAME = '한국';

-- '러시아'에서 근무하는 사원의 사번, 이름, 부서명, 급여, 근무 국가명을 조회
SELECT
    E.EMP_NO,
    E.EMP_NAME,
    D.DEPT_TITLE,
    E.SALARY,
    N.NATIONAL_NAME
FROM
    EMPLOYEE   E,
    DEPARTMENT D,
    LOCATION   L,
    NATIONAL   N
WHERE
        E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE
    AND N.NATIONAL_NAME = '러시아';


-- '일본'에서 근무하는 사원의 사번, 이름, 부서명, 급여, 근무 국가명을 조회
SELECT
    E.EMP_NO,
    E.EMP_NAME,
    D.DEPT_TITLE,
    E.SALARY,
    N.NATIONAL_NAME
FROM
    EMPLOYEE   E,
    DEPARTMENT D,
    LOCATION   L,
    NATIONAL   N
WHERE
        E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE
    AND N.NATIONAL_NAME = '일본';

----------- VIEW 만들기
CREATE VIEW V_EMPLOYEE AS
    SELECT
        E.EMP_NO,
        E.EMP_NAME,
        D.DEPT_TITLE,
        E.SALARY,
        N.NATIONAL_NAME
    FROM
             EMPLOYEE E
        INNER JOIN DEPARTMENT D ON ( D.DEPT_ID = E.DEPT_CODE )
        INNER JOIN LOCATION   L ON ( L.LOCAL_CODE = D.LOCATION_ID )
        INNER JOIN NATIONAL   N USING ( NATIONAL_CODE );

-- 가상의 테이블로 실제 데이터가 담겨있는 것은 아니다.
SELECT
    *
FROM
    V_EMPLOYEE;

-- 접속한 계정이 가지고 있는 VIEW에 대한 정보를 조회하는 뷰 테이블이다.
SELECT
    *
FROM
    USER_VIEWS;

-- VEIW 를 이용한 조회
SELECT
    *
FROM
    V_EMPLOYEE
WHERE
    NATIONAL_NAME = '한국';

SELECT
    *
FROM
    V_EMPLOYEE
WHERE
    NATIONAL_NAME = '러시아';

SELECT
    *
FROM
    V_EMPLOYEE
WHERE
    NATIONAL_NAME = '일본';
    
/*
    <뷰 컬럼에 별칭 부여>

*/
    
    
-- 사원의 사번, 직원명, 성별, 근무년수 조회

SELECT
    EMP_ID                                                    AS "사번",
    EMP_NAME                                                  AS "직원명",
    LPAD(DECODE(SUBSTR(EMP_NO, 8, 1),
                '1',
                '남',
                '2',
                '여',
                '외계인'),
         6)                                                   AS "성별",
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "근무년수"
FROM
    EMPLOYEE;


-- 1) 서브쿼리에서 별칭을 부여하는 방법
CREATE VIEW V_EMP AS
    SELECT
        EMP_ID                                                    AS "사번",
        EMP_NAME                                                  AS "직원명",
        LPAD(DECODE(SUBSTR(EMP_NO, 8, 1),
                    '1',
                    '남',
                    '2',
                    '여',
                    '외계인'),
             6)                                                   AS "성별",
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "근무년수"
    FROM
        EMPLOYEE;

SELECT
    *
FROM
    V_EMP;

-- 2) 뷰 생성 시 모든 컬럼에 별칭을 부여하는 방법
CREATE OR REPLACE VIEW V_EMP (
    "사번",
    "직원명",
    "성별",
    "근무년수"
) AS
    SELECT
        EMP_ID,
        EMP_NAME,
        LPAD(DECODE(SUBSTR(EMP_NO, 8, 1),
                    '1',
                    '남',
                    '2',
                    '여',
                    '외계인'),
             6),
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
    FROM
        EMPLOYEE;

SELECT
    *
FROM
    V_EMP;

DROP VIEW V_EMP;

DROP VIEW V_EMPLOYEE;

/*
    <VIEW를 이용해서 DML(INSERT, UPDATE, DELETE) 사용>
*/

CREATE VIEW V_JOB AS
    SELECT
        *
    FROM
        JOB;

SELECT
    *
FROM
    V_JOB;

-- VEIW 에 SELECT
SELECT
    JOB_CODE,
    JOB_NAME
FROM
    V_JOB;
    
-- VEIW 에 INSERT
INSERT INTO V_JOB VALUES (
    'J8',
    '알바'
);

SELECT
    JOB_CODE,
    JOB_NAME
FROM
    V_JOB;

SELECT
    *
FROM
    JOB;

-- VEIW 에 UPDATE
UPDATE V_JOB
SET
    JOB_NAME = '인턴'
WHERE
    JOB_CODE = 'J8';


-- VIEW 에 DELETE
DELETE FROM V_JOB
WHERE
    JOB_CODE = 'J8';

/*
    <DML 구문으로 조작이 불가능한 경우 >
       
    1.뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
    2. 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 컬럼이 NOT NULL 제약조건이 지정된 경우
    3. 산술 표현식으로 정의된 경우
    4. 그룹 함수나 GROUP BY 절을 포함한 경우
    5. DISTINCT를 포함한 경우
    6. JOIN을 이용해 여러 테이블을 연결한 경우

*/

-- 1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
CREATE OR REPLACE VIEW V_JOB AS
    SELECT
        JOB_CODE
    FROM
        JOB;

SELECT
    *
FROM
    V_JOB;

-- INSERT    
INSERT INTO V_JOB VALUES (
    'J0',
    '인턴'
); -- 에러 발생
INSERT INTO V_JOB VALUES ( 'J0' );

--UPDATE
UPDATE V_JOB
SET
    JOB_NAME = '인턴'
WHERE
    JOB_CODE = 'J0'; -- 에러 발생

UPDATE V_JOB
SET
    JOB_CODE = 'J8'
WHERE
    JOB_CODE = 'J0';
    
-- DELETE 
DELETE FROM V_JOB
WHERE
    JOB_NAME = '사원';

DELETE FROM V_JOB
WHERE
    JOB_CODE = 'J8';   
    
    
--  2. VIEW에 포함되지 않은 컬럼 중에 NOT NULL 제약조건이 지정된 경우
CREATE OR REPLACE VIEW V_JOB AS
    SELECT
        JOB_NAME
    FROM
        JOB;

SELECT
    *
FROM
    V_JOB;
    
--  INSERT
INSERT INTO V_JOB VALUES ( '인턴' );


-- UPDATE
UPDATE V_JOB
SET
    JOB_NAME = '인턴'
WHERE
    JOB_NAME = '사원';

-- DELETE
DELETE FROM V_JOB
WHERE
    JOB_NAME = '인턴';
-- EMPLOYEE 테이블의 PK 제약조건이 걸려 있기 때문에 오류 발생

ROLLBACK;

-- 3. 산술 표현식으로 정의된 경우
-- 사원의 연봉 정보를 조회하는 뷰

CREATE VIEW V_EMP_SAL AS
    SELECT
        EMP_ID,
        EMP_NAME,
        EMP_NO,
        SALARY,
        SALARY * 12 AS "연봉"
    FROM
        EMPLOYEE;

SELECT
    *
FROM
    V_EMP_SAL;
    
-- INSERT


ALTER TABLE EMPLOYEE MODIFY
    JOB_CODE NULL;

-- 가상 칼럼엔 대입 불가
INSERT INTO V_EMP_SAL VALUES (
    '300',
    '홍길동',
    '221227-3175230',
    300000,
    3600000
);

-- 산술연산과 무관한 칼럼엔 대입 가능
INSERT INTO V_EMP_SAL (
    EMP_ID,
    EMP_NAME,
    EMP_NO,
    SALARY
) VALUES (
    '300',
    '홍길동',
    '221227-3175230',
    300000
);

-- UPDATE

UPDATE V_EMP_SAL
SET
    연봉 = 4000000
WHERE
    EMP_ID = 300;
    
-- 산술 연산과 무관한 컬럼은 데이터 변경이 가능함
UPDATE V_EMP_SAL
SET
    SALARY = 400000
WHERE
    EMP_ID = 300;

SELECT
    *
FROM
    V_EMP_SAL
WHERE
    EMP_ID = 300;
    
-- DELETE
DELETE FROM V_EMP_SAL
WHERE
    "연봉" = 4800000; -- DELECT 는 가능함

ROLLBACK;



-- 4. 그룹 함수나 GROUP BY 절을 포함한 경우
-- 부서별 급여의 합계, 평균을 조회

SELECT
    DEPT_CODE,
    SUM(SALARY),
    FLOOR(AVG(NVL(SALARY, 0)))
FROM
    EMPLOYEE
GROUP BY
    DEPT_CODE;

CREATE OR REPLACE VIEW V_EMP_SAL (
    "부서코드",
    "합계",
    "평균"
) AS
    SELECT
        DEPT_CODE,
        SUM(SALARY),
        FLOOR(AVG(NVL(SALARY, 0)))
    FROM
        EMPLOYEE
    GROUP BY
        DEPT_CODE;
        
-- INSERT

INSERT INTO V_EMP_SAL VALUES (
    'D9',
    8000000,
    4000000
);

SELECT
    *
FROM
    V_EMP_SAL;

INSERT INTO V_EMP_SAL ( "부서코드" ) VALUES ( 'D0' );

-- UPDATE 
UPDATE V_EMP_SAL
SET
    "부서코드" = 'D0'
WHERE
    "부서코드" = 'D1';

SELECT
    *
FROM
    V_EMP_SAL;
    
-- DELETE 
DELETE FROM V_EMP_SAL
WHERE
    "부서코드" = 'D1';
    
 -- 5. DISTINCT를 포함한 경우
SELECT DISTINCT
    JOB_CODE
FROM
    EMPLOYEE;

CREATE VIEW V_EMP_JOB AS
    SELECT DISTINCT
        JOB_CODE
    FROM
        EMPLOYEE;

SELECT
    *
FROM
    V_EMP_JOB;
    
--  INSERT 
INSERT INTO V_EMP_JOB VALUES ( 'J8' );

-- UPDATE

UPDATE V_EMP_JOB
SET
    JOB_CODE = 'J8'
WHERE
    JOB_CODE = 'J7';

SELECT
    *
FROM
    V_EMP_JOB;
    
-- 6. JOIN을 이용해서 여러 테이블을 연결한 경우
-- 직원들의 사번, 직원명, 주민번호 부서명을 조회
CREATE VIEW V_EMP_DEPT AS
    SELECT
        E.EMP_ID,
        E.EMP_NAME,
        E.EMP_NO,
        D.DEPT_TITLE
    FROM
             EMPLOYEE E
        INNER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID );

SELECT
    *
FROM
    V_EMP_DEPT;

-- INSERT
INSERT INTO V_EMP_DEPT VALUES (
    '300',
    '홍길동',
    '221227-3888888',
    '총부무'
);

INSERT INTO V_EMP_DEPT (
    EMP_ID,
    EMP_NAME,
    EMP_NO
) VALUES (
    '300',
    '홍길동',
    '221227-3888888'
);

SELECT
    *
FROM
    EMPLOYEE;
    
-- UPDATE
UPDATE V_EMP_DEPT
SET
    DEPT_TITLE = '총무1팀'
WHERE
    EMP_ID = '200';  -- 에러 발생

UPDATE V_EMP_DEPT
SET
    EMP_NAME = '서동일'
WHERE
    EMP_ID = '200';
    
-- DELETE
-- 서브 쿼리의 FROM 절에 기술한 테이블에만 영향을 끼친다.
DELETE FROM V_EMP_DEPT
WHERE
    EMP_ID = '200';

SELECT
    *
FROM
    V_EMP_DEPT
WHERE
    EMP_ID = '200';

DELETE FROM V_EMP_DEPT
WHERE
    DEPT_TITLE = '총무부';

SELECT
    *
FROM
    DEPARTMENT;

ROLLBACK;

/*

    <VIEW 옵션>
    1. OR REPLACE
    2. 
    
*/

CREATE OR REPLACE VIEW V_EMP AS
    SELECT
        EMP_ID,
        EMP_NAME,
        SALARY,
        HIRE_DATE
    FROM
        EMPLOYEE;

SELECT
    *
FROM
    V_EMP;

SELECT
    *
FROM
    USER_VIEWS
WHERE
    VIEW_NAME = 'V_EMP';
    
    
 /*
    
    2. NOFORCE / FORCE
        1) NOFORCE
    
    
*/

CREATE /*NO FORCE*/ VIEW V_EMP_02 AS
    SELECT
        *
    FROM
        TEST;

SELECT
    *
FROM
    V_EMP_02;

CREATE TABLE TEST (
    TID NUMBER
);
-- TEST 테이블을 생성한 이후부터는 VIEW 생성 가능

DROP TABLE TEST;

DROP VIEW V_EMP_02;

/*

    2) FORCE

*/

CREATE FORCE VIEW V_EMP_02 AS
    SELECT
        *
    FROM
        TEST;

SELECT
    *
FROM
    V_EMP_02;
    
/*

    3. WITH CHECK OPTION

*/
DROP VIEW V_EMP_03;

CREATE OR REPLACE VIEW V_EMP_03 AS
    SELECT
        *
    FROM
        EMPLOYEE
    WHERE
        SALARY >= 3000000;

SELECT
    *
FROM
    V_EMP_03;
    
-- 선동일 사장의 급여를 200만원으로 변경 -- 서브쿼리의 조건에 부합하지 않아도 변경이 가능
UPDATE V_EMP_03
SET
    SALARY = 2000000
WHERE
    EMP_ID = 200;

ROLLBACK;

CREATE OR REPLACE VIEW V_EMP_03 AS
    SELECT
        *
    FROM
        EMPLOYEE
    WHERE
        SALARY >= 3000000
WITH CHECK OPTION;

UPDATE V_EMP_03
SET
    SALARY = 4000000
WHERE
    EMP_ID = 200;

SELECT
    *
FROM
    USER_VIEWS
WHERE
    VIEW_NAME = 'V_EMP_03';


/*

    4. WITH READ ONLY
    
*/

CREATE VIEW V_DEPT AS
    SELECT
        *
    FROM
        DEPARTMENT
WITH READ ONLY;

-- INSERT
INSERT INTO V_DEPT VALUES (
    'D0',
    '해외영업 4부',
    'L5'
);

-- UPDATE
UPDATE V_DEPT
SET
    LOCATION_ID = 'L2'
WHERE
    DEPT_TITLE = '해외영업 2부';

-- DELETE
DELETE FROM V_DEPT;

SELECT
    *
FROM
    V_DEPT;


/*
    <VIEW 삭제>
    
*/

DROP VIEW V_EMP_DEPT;

DROP VIEW V_EMP;

DROP VIEW V_EMP_03;

DROP VIEW V_EMP_JOB;

DROP VIEW V_EMP_SAL;

DROP VIEW V_JOB;

DROP VIEW V_JOB;
-------------------------------------
SELECT
    *
FROM
    USER_VIEWS;