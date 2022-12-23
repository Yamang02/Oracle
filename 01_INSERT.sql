/*
    
    < DML(Data Manipulation Language)>
    데이터 조작 언어로 테이블에 값을 삽입(INSERT), 수정(UPDATE), 삭제(DELETE)하는 구문이다.
    
    <INSERT>
        테이블에 새로운 행을 추가하는 구문이다.
        
        [표현법]
            1) INSERT INTO 테이블명 VALUES(값, 값, ..., 값);
            - 테이블에 모든 컬럼에 값을 INSERT하고자 할 때 사용한다.
            - 테이블 생성시 부여했던 컬럼의 순서대로 나열해야 한다.
            
            
            2) INSERT INTO 테이블명(컬럼, 컬럼, ... 컬럼) VALUES (값, 값, ... 값);
            - 테이블의 특정 컬럼에 값을 INSERT하고자 할 때 사용한다.
            - 선택이 안된 컬럼들은 기본적으로 NULL 값이 들어간다.
            - NOT NULL 제약조건이 걸려있는 컬럼은 반드시 선택해서 값을 제시해야 한다.
            - 단, 기본값이 지정되어 있으면 NULL이 아닌 기본값이 들어간다.
            
            
            3) INSERT INTO 테이블명 (SUBQUERY);
            - VALUES를 대신해서 서브 쿼리로 조회한 결과값을 통째로 INSERT한다
            - 서브 쿼리의 결과 값이 INSERT 문에 지정된 테이블 컬럼의 개수와 데이터 타입이 같아야 한다.
    
*/

-- 테스트에 사용할 테이블 생성
DROP TABLE EMP_01;

CREATE TABLE EMP_01 (
    EMP_ID     NUMBER PRIMARY KEY,
    EMP_NAME   VARCHAR2(30) NOT NULL,
    DEPT_TITLE VARCHAR2(30),
    HIRE_DATE  DATE DEFAULT SYSDATE NOT NULL
);

-- 표현법 1) 
INSERT INTO EMP_01 VALUES (
    100,
    '문인수',
    '서비스개발팀',
    SYSDATE
);

-- 모든 컬럼에 값을 지정하지 않아 에러남
INSERT INTO EMP_01 VALUES (
    200,
    '홍길동',
    '개발 지원팀'
);

-- 에러는 나지 않지만 값이 잘못 들어감
INSERT INTO EMP_01 VALUES (
    300,
    '인사팀',
    '홍길동', DEFAULT
);

-- 컬럼 순서와 데이터 타입이 맞지 않아 에러 발생
INSERT INTO EMP_01 VALUES (
    '인사팀',
    300,
    '홍길동', DEFAULT
);
    
-- 표현법 2)
INSERT INTO EMP_01 (
    EMP_ID,
    EMP_NAME,
    DEPT_TITLE,
    HIRE_DATE
) VALUES (
    400,
    '진도준',
    '보안팀',
    NULL
);

INSERT INTO EMP_01 (
    EMP_NAME,
    EMP_ID,
    DEPT_TITLE,
    HIRE_DATE
) VALUES (
    '이몽룡',
    '500',
    '마케팅',
    SYSDATE
);

INSERT INTO EMP_01 (
    EMP_ID,
    EMP_NAME
) VALUES (
    600,
    '성춘향'
);

-- EMP_NAME 컬럼에 NOT NULL 제약 조건이 걸려있어 에러 발생
INSERT INTO EMP_01 (
    EMP_ID,
    DEPT_TITLE
) VALUES (
    700,
    '마케팅'
);

INSERT INTO EMP_01 (
    EMP_ID,
    EMP_NAME,
    DEPT_TITLE
) VALUES (
    800,
    '심청이',
    '마케팅팀'
);

--표현법 3)
DELETE FROM EMP_01;

-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인, 직원들의 사번, 이름, 부서명, 입사일을 조회
INSERT INTO EMP_01
    (
        SELECT
            E.EMP_ID,
            E.EMP_NAME,
            D.DEPT_TITLE,
            E.HIRE_DATE
        FROM
                 EMPLOYEE E
            JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
    );

SELECT
    *
FROM
    EMP_01;
    
-- 테이블 컬럼 순서와 맞지 않아서 에러 발생    
INSERT INTO EMP_01
    (
        SELECT
            E.EMP_NAME,
            E.EMP_ID,
            D.DEPT_TITLE,
            E.HIRE_DATE
        FROM
                 EMPLOYEE E
            JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
    );

SELECT
    *
FROM
    EMP_01;    
    
-- 서브 쿼리로 조회한 데이터의 컬럼의 개수가 테이블의 컬럼의 개수보다 많아서 에러 발생
INSERT INTO EMP_01
    (
        SELECT
            E.EMP_ID,
            E.EMP_NAME,
            E.SALARY,
            D.DEPT_TITLE,
            E.HIRE_DATE
        FROM
                 EMPLOYEE E
            JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
    );

SELECT
    *
FROM
    EMP_01;

DELETE FROM EMP_01;    
    
-- EMPLOYEE 테이블에서 직원들의 사번, 직원명을 조회해서 EMP_01 테이블에 INSERT 하시오.
INSERT INTO EMP_01 (
    EMP_ID,
    EMP_NAME
)
    (
        SELECT
            EMP_ID,
            EMP_NAME
        FROM
            EMPLOYEE
    );

DROP TABLE EMP_01;

/*
    <INSERT ALL>
        [표현법]
        1) INSERT ALL
        INTO 테이블1[(컬럼, 컬럼... 컬럼)] VALUES (값, 값, ... ,값)
        INTO 테이블1[(컬럼, 컬럼... 컬럼)] VALUES (값, 값, ... ,값)
        서브쿼리;
        
        
        2) INSERT ALL
            WHEN 조건1 | THEN
                테이블1[(컬럼, 컬럼, 컬럼,)] VALUES(값, 값, 값)
            WHEN 조건2 | THEN
                테이블2[(컬럼, 컬럼, 컬럼,)] VALUES(값, 값, 값)    
            서브 쿼리;
            
*/


-- 표현법 1)
-- 테스트 테이블 만들기(테이블 구조만 복사)

CREATE TABLE EMP_DEPT
    AS
        SELECT
            EMP_ID,
            EMP_ID,
            DEPT_CODE,
            HIRE_DATE
        FROM
            EMPLOYEE
        WHERE
            0 = 1;

SELECT
    *
FROM
    EMP_DEPT;

SELECT
    *
FROM
    EMP_MANGER;

-- EMP_TABLE의 부서코드가 D1이면 직원의 사번, 이름, 부서코드, 입사일을 삽입
-- EMP_TABLE의 부서코드가 D1이면 직원의 사번, 이름, 부서코드, 입사일을 삽입


SELECT
    EMP_ID,
    EMP_NAME,
    DEPT_CODE,
    HIRE_DATE
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'D1';
/*
INSERT ALL
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE ) INTO EMP_MANAGER VALUES (
    EMP_ID,
    EMP_NAME,
    MANGER_ID
)
*/
--    표현법 2 
--      테스트할 테이블 만들기
CREATE TABLE EMP_OLD
    AS
        SELECT
            EMP_ID,
            EMP_NAME,
            SALARY,
            HIRE_DATE
        FROM
            EMPLOYEE
        WHERE
            1 = 2;

CREATE TABLE EMP_NEW
    AS
        SELECT
            EMP_ID,
            EMP_NAME,
            SALARY,
            HIRE_DATE
        FROM
            EMPLOYEE
        WHERE
            1 = 2;

SELECT
    *
FROM
    EMP_OLD;

SELECT
    *
FROM
    EMP_NEW;

SELECT
    EMP_ID,
    EMP_NAME,
    SALARY,
    HIRE_DATE
FROM
    EMPLOYEE;
-- EMPLOYEE 테이블의 입사일을 기준으로 
--2000년 1월 1일 이전에 입사한 사원의 정보는 EMP_OLD 테이블에 삽입하고 
--2000년 1월 1일 이후에 입사한 사원의 정보는 EMP_NEW 테이블에 삽입한다.

INSERT
    ALL WHEN HIRE_DATE < '2000/01/01' THEN
        INTO EMP_OLD
        VALUES (
            EMP_ID,
            EMP_NAME,
            SALARY,
            HIRE_DATE
        )
        WHEN HIRE_DATE >= '2000/01/01' THEN
            INTO EMP_NEW
            VALUES (
                EMP_ID,
                EMP_NAME,
                SALARY,
                HIRE_DATE
            )
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
    EMP_OLD;

SELECT
    *
FROM
    EMP_NEW;

DELETE FROM EMP_OLD;
DELETE FROM EMP_NEW;

DROP TABLE EMP_OLD;
DROP TABLE EMP_NEW;