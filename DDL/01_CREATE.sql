/*
        <DDL(DATA DEFINITION LANGUAGE)>
        데이터 정의 언어로 오라클에서 제공하는 객체를 만들고(CREATE), 변경하고(ALTER), 삭제하는(DROP) 등
        실제 데이터 값이 아닌 데이터의 구조를 정의하는 언어이다.        
        
        <CREATE>
            데이터베이스 객체(테이블, 인덱스, 뷰 등)를 생성하는 구문이다.
        
        <테이블 생성>
            [표현법]
                CREAT TABLE 테이블명 (
                    컬럼명 자료형(크기) [DEFAULT 기본값][제약조건]  -- 비어있어도 들어갈 값
                    컬럼명 자료형(크기) [DEFAULT 기본값][제약조건]  -- 비어있어도 들어갈 값
                    컬럼명 자료형(크기) [DEFAULT 기본값][제약조건]  -- 비어있어도 들어갈 값
                ) ;
        
        
*/

-- 테이블 삭제
DROP TABLE MEMBER

-- 학원에 대한 데이터를 담을 수 있는 MEMBER 테이블 생성

CREATE TABLE MEMBER (
    ID          VARCHAR2(20),
    PASSWORD    VARCHAR2(20),
    NAME        VARCHAR2(15),
    ENROLL_DATE DATE DEFAULT SYSDATE
);

-- 테이블의 구조를 표시해주는 구문
DESC MEMBER;

-- USER_TABLES : 사용자가 가지고 있는 테이블들의 구조를 확인하는 뷰 테이블
SELECT
    *
FROM
    USER_TABLES;

-- USER_TAB_COLUMS : 사용자가 가지고 있는 테이블, 뷰의 컬럼과 관련된 정보를 조회하는 뷰 테이블이다.
SELECT
    *
FROM
    USER_TAB_COLUMNS;

SELECT
    *
FROM
    MEMBER;
/*
    <컬럼 주석>
        [표현법]
            COMMENT ON COLUMN 테이블명. 컬럼명 IS '주석 내용';

*/

COMMENT ON COLUMN MEMBER.ID IS
    '회원 아이디';

COMMENT ON COLUMN MEMBER.PASSWORD IS
    '회원 비밀번호';

COMMENT ON COLUMN MEMBER.NAME IS
    '회원 이름';

COMMENT ON COLUMN MEMBER.ENROLL_DATE IS
    '회원 가입일';
    
 -- 데이터에 샘플 데이터 추가(INSERT)
 -- INSERT INTO 테이블명[(컬럼명, ..., 컬럼명 )] --생략시 모든 테이블에 데이터 삽입 VALUES (값, ... 값);

INSERT INTO MEMBER VALUES (
    'USER1',
    '1234',
    '문인수',
    '2022-12-20'
);

INSERT INTO MEMBER VALUES (
    'USER2',
    '5678',
    '홍길동',
    SYSDATE
);

INSERT INTO MEMBER (
    ID,
    PASSWORD,
    NAME,
    ENROLL_DATE
) VALUES (
    'USER3',
    '9999',
    '이몽룡', DEFAULT
);

INSERT INTO MEMBER (
    ID,
    PASSWORD
) VALUES (
    'USER4',
    '0000'
);

-- 위에서 추가한 데이터를 실제 테이블에 반영한다.
COMMIT;

SHOW AUTOCOMMIT;
SET AUTOCOMMIT OFF;

ROLLBACK;

/*
    <제약조건>
        사용자가 원하는 조건의 데이터만 유지하기 위해서 테이블 작성 시 각 칼럼에 대해 저장될 값에 대한 제약 조건을 설정할 수 있다.
        제약조건은 데이터 무결성 보장을 목적으로 한다. (데이터가 정확하고 항상 일관성을 유지)
        
        [표현법]
        1) 컬럼 레벨
            CREATE TABLE 테이블명(
                컬럼명 자료형(크기) [CONSTRAINT 제약조건명] 제약조건,
                ...
                );
                
        2) 테이블 레벨
            CREATE TABLE 테이블명(
                컬럼명 자료형(크기),
                ...
                [CONSTRAINT 제약조건명] 제약조건 (컬럼명)


        1. NOT NULL 제약조건
            해당 컬럼에 반드시 값이 있어야 하는 경우에 사용.
            NOT NULL 제약조건은 칼럼 레벨에서만 설정이 가능하다.

*/

SELECT
    *
FROM
    MEMBER;

-- 기존 MEMBER 테이블은 값에 NULL이 있어도 행의 삽입이 가능하다.
INSERT INTO MEMBER VALUES (
    NULL,
    NULL,
    NULL,
    NULL
);

-- NOT NULL 제약조건을 설정한 테이블 생성
DROP TABLE MEMBER;

-- NOT NULL 제약 조건에 위배되어 오류 발생
CREATE TABLE MEMBER (
    ID          VARCHAR2(20) NOT NULL,
    PASSWORD    VARCHAR2(20) NOT NULL,
    NAME        VARCHAR2(15) NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE
);

INSERT INTO MEMBER VALUES (
    'USER1',
    '1234',
    '문인수',
    NULL
);

INSERT INTO MEMBER VALUES (
    'USER2',
    '5678',
    '홍길동',
    SYSDATE
);

INSERT INTO MEMBER (
    ID,
    PASSWORD,
    NAME,
    ENROLL_DATE
) VALUES (
    'USER3',
    '9999',
    '이몽룡', DEFAULT
);

INSERT INTO MEMBER (
    ID,
    PASSWORD,
    NAME
) VALUES (
    'USER4',
    '0000',
    '진도준'
);
-- 테이블의 데이터를 수정하는 SQL 구문
UPDATE MEMBER
SET
    ID = 'USER33';

-- 제약조건 확인
-- 사용자가 작성한 제약조건을 확인하는 뷰 테이블이다.
SELECT
    *
FROM
    USER_CONSTRAINTS;

-- 사용자가 작성한 제약조건이 걸려있는 컬럼을 확인하는 뷰 테이블이다.
SELECT
    *
FROM
    USER_CONS_COLUMNS;

/*
    2. UNIQUE 제약조건
    컬럼에 중복된 값을 저장하거나 중복된 값으로 수정할 수 없도록 한다.
    UNIQUE 제약조건은 컬럼 레벨, 테이블 레벨에서 모두 설정이 가능하다.
*/
INSERT INTO MEMBER VALUES (
    'USER1',
    '1234',
    '문인수', DEFAULT
);

INSERT INTO MEMBER VALUES (
    'USER1',
    '1234',
    '문인수', DEFAULT
);

SELECT
    *
FROM
    MEMBER;

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO          NUMBER NOT NULL,
    ID          VARCHAR2(20)
        CONSTRAINT MEMBER_ID_NN NOT NULL,
    PASSWORD    VARCHAR2(20)
        CONSTRAINT MEMBER_PASSWORD_NN NOT NULL,
    NAME        VARCHAR2(15)
        CONSTRAINT MEMBER_NAME_NN NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_ID_UQ UNIQUE ( ID )
);

-- UNIQUE 제약조건에 위배되었으므로 INSERT 실패
INSERT INTO MEMBER VALUES (
    'USER1',
    '1234',
    '문인수', DEFAULT
);

INSERT INTO MEMBER VALUES (
    'USER1',
    '1234',
    '성춘향', DEFAULT
);

DROP TABLE MEMBER;

SELECT
    *
FROM
    USER_CONS_COLUMNS
WHERE
    TABLE_NAME = 'MEMBER';

SELECT
    UC.CONSTRAINT_NAME,
    UC.TABLE_NAME,
    UCC.COLUMN_NAME,
    UCC.POSITION,
    UC.CONSTRAINT_TYPE
FROM
         USER_CONSTRAINTS UC
    INNER JOIN USER_CONS_COLUMNS UCC ON ( UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME )
WHERE
    UC.TABLE_NAME = 'MEMBER';



-- 여러 개의 컬럼을 묶어서 하나의 UNIQUE 제약조건으로 설정 (단, 반드시 테이블 레벨로만 설정)
CREATE TABLE MEMBER (
    NO          NUMBER NOT NULL,
    ID          VARCHAR2(20)
        CONSTRAINT MEMBER_ID_NN NOT NULL,
    PASSWORD    VARCHAR2(20)
        CONSTRAINT MEMBER_PASSWORD_NN NOT NULL,
    NAME        VARCHAR2(15)
        CONSTRAINT MEMBER_NAME_NN NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_ID_UQ UNIQUE ( NO,
                                        ID )
);

-- 여러 컬럼을 묶어서 UNIQUE 제약 조건이 설정되어 있으면
-- 제약조건이 설정되어 있는 컬럼 값이 모두 중복되는 경우에만 오류가 발생한다.
INSERT INTO MEMBER VALUES (
    1,
    'USER1',
    '1234',
    '문인수', DEFAULT
);

INSERT INTO MEMBER VALUES (
    2,
    'USER1',
    '1234',
    '성춘향', DEFAULT
);

INSERT INTO MEMBER VALUES (
    2,
    'USER1',
    '1234',
    '문인수', DEFAULT
);

SELECT
    *
FROM
    USER_CONS_COLUMNS
WHERE
    TABLE_NAME = 'MEMBER';


/*
3. CHECK 제약조건
    컬럼에 기록되는 값에 조건을 설정하고 조건을 만족하는 값만 저장하거나 수정하도록 한다.
    비교 연산자를 이용하여 조건을 설정하며 비교 값을 리터럴만 사용 가능하고 변하는 값이나 함수 사용할 수 없다.
    CHECK 제약조건은 컬럼 레벨, 테이블 레벨에서 모두 설정이 가능하다.
    
    CHECK(조건식)
    CHECK (컬럼 (NOT) IN (값, 값, ...))
    CHECK (컬럼 = 값)
    CHECK (컬럼 BETWEEN 값 AND 값)
    CHECK (컬럼 LIKE '_문자') ...
    
*/
DROP TABLE MEMBER;

-- 성별, 나이에 유효한 값이 아닌 값들도 INSERT 된다.
CREATE TABLE MEMBER (
    NO          NUMBER NOT NULL,
    ID          VARCHAR2(20) NOT NULL,
    PASSWORD    VARCHAR2(20) NOT NULL,
    NAME        VARCHAR2(15) NOT NULL,
    GENDER      CHAR(3),
    AGE         NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_ID_UQ UNIQUE ( ID )
);

INSERT INTO MEMBER VALUES (
    1,
    'USER1',
    '1234',
    '문인수',
    '남',
    21, DEFAULT
);

INSERT INTO MEMBER VALUES (
    2,
    'USER2',
    '1234',
    '성춘향',
    '여',
    16, DEFAULT
);

INSERT INTO MEMBER VALUES (
    3,
    'USER3',
    '1234',
    '홍길동',
    '강',
    30, DEFAULT
);

INSERT INTO MEMBER VALUES (
    4,
    'USER4',
    '1234',
    '이몽룡',
    '남',
    - 20, DEFAULT
);

SELECT
    *
FROM
    MEMBER;
    
-- CHECK 제약조건을 설정한 테이블 생성
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO          NUMBER NOT NULL,
    ID          VARCHAR2(20) NOT NULL,
    PASSWORD    VARCHAR2(20) NOT NULL,
    NAME        VARCHAR2(15) NOT NULL,
    GENDER      CHAR(3)
        CONSTRAINT MEMBER_GEDER_CK CHECK ( GENDER IN ( '남', '여' ) ),
    AGE         NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_ID_UQ UNIQUE ( ID ),
    CONSTRAINT MEMBER_AGE_CK CHECK ( AGE > 0 )
);

-- 각각 GENDER 에러, AGE 에러
INSERT INTO MEMBER VALUES (
    3,
    'USER3',
    '1234',
    '홍길동',
    '강',
    30, DEFAULT
);

INSERT INTO MEMBER VALUES (
    4,
    'USER4',
    '1234',
    '이몽룡',
    '남',
    - 20, DEFAULT
);

UPDATE MEMBER
--SET GENDER = '약'
SET
    AGE = - 10
WHERE
    NAME = '문인수';

/*
    4. PRIMARY KEY(기본키)
    테이블에서 한 행의 정보를 식별하기 위해 사용할 컬럼에 부여하는 제약조건이다.
    PRIMARY KEY 제약조건을 설정하게 되면 자동으로 해당 컬럼에 NOT NULL, UNIQUE 제약조건이 걸린다.
    PRIMARY KEY 제약조건은 컬럼 레벨, 테이블 레벨에서 모두 설정이 가능하다.        
    
    비지니스로직과 상관없는 대리키를 설정하는 것이 일반적
    
*/

CREATE TABLE MEMBER (
    NO          NUMBER
        CONSTRAINT MEMBER_NO_PK PRIMARY KEY,
    ID          VARCHAR2(20) NOT NULL,
    PASSWORD    VARCHAR2(20) NOT NULL,
    NAME        VARCHAR2(15) NOT NULL,
    GENDER      CHAR(3)
        CONSTRAINT MEMBER_GEDER_CK CHECK ( GENDER IN ( '남', '여' ) ),
    AGE         NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_ID_UQ UNIQUE ( ID ),
    CONSTRAINT MEMBER_AGE_CK CHECK ( AGE > 0 )
);
-- 기본키 중복으로 에러 발생, 기본키로 NULL값으로 에러 발생
INSERT INTO MEMBER VALUES (
    3,
    'USER4',
    '1234',
    '이몽룡',
    '남',
    20, DEFAULT
);

INSERT INTO MEMBER VALUES (
    NULL,
    'USER4',
    '1234',
    '이몽룡',
    '남',
    20, DEFAULT
);

-- 컬럼을 묶어 하나의 기본 키 생성(복합키)
CREATE TABLE MEMBER (
--    각각 붙이면 PRIMARYM KEY 가 2개이므로 오류가 남
--    NO          NUMBER CONSTRAINT MEMBER_NO_PK PRIMARY KEY,
--    ID          VARCHAR2(20) PRIMARY KEY,
    NO          NUMBER,
    ID          VARCHAR2(20),
    PASSWORD    VARCHAR2(20) NOT NULL,
    NAME        VARCHAR2(15) NOT NULL,
    GENDER      CHAR(3),
    AGE         NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_ID_PK PRIMARY KEY ( NO,
                                             ID ),
    CONSTRAINT MEMBER_GEDER_CK CHECK ( GENDER IN ( '남', '여' ) ),
    CONSTRAINT MEMBER_AGE_CK CHECK ( AGE > 0 )
);

-- 회원번호, 아이디가 동일한 값이 이미 존재하기 때문에 에러가 발생한다.
--INSERT INTO MEMBER VALUES (
--    3,
--    'USER4',
--    '1234',
--    '심청이',
--    '여',
--    16, DEFAULT
--);

-- PRIMARY KEY로 설정된 컬럼 중 하나라도 NULL이 있으면 에러가 발생한다.
INSERT INTO MEMBER VALUES (
    NULL,
    'USER4',
    '1234',
    '심청이',
    '여',
    16, DEFAULT
);

INSERT INTO MEMBER VALUES (
    3,
    NULL,
    '1234',
    '심청이',
    '여',
    16, DEFAULT
);

INSERT INTO MEMBER VALUES (
    NULL,
    NULL,
    '1234',
    '심청이',
    '여',
    16, DEFAULT
);

/*

5. FOREIGN KEY 제약조건
외래 키는 다른 테이블을 참조하는 역학을 하며 외래 키를 통해 테이블 간의 관계를 형성할 수 있다.
즉, 외래 키로 참조한 컬럼의 값만 기록할 수 있다.

다른 테이블에 존재하는 값만을 가져야 하는 컬럼에 부여하는 제약조건이다. (단, NULL 값도 가질 수 있다.)
참조되는 컬럼은 PK(PRIMARY KEY)이거나 UK(Unique key)만 가능하다.
FOREIGN KEY 제약조건은 컬럼 레벨, 테이블 레벨에서 모두 설정이 가능하다.
부모 테이블의 데이터가 삭제될 때 자식 테이블의 데이터 처리에 대한 옵션을 지정할 수 있다.
ON DELETE RESTRICT : 자식 테이블의 참조 키가 부모 테이블의 키값을 참조하는 경우 부모 테이블의 행을 삭제할 수 없다. (기본)
ON DELETE SET NULL : 부모 테이블의 데이터가 삭제 시 참조하고 있는 자식 테이블의 컬럼 값이 NULL로 변경된다.
ON DELETE CASCADE : 부모 테이블의 데이터가 삭제 시 참조하고 있는 자식 테이블의 컬럼 값이 존재하는 행 전체가 삭제된다.

    [표현법]
        1) 컬럼 자료형_ [STSTRAION 제약 조건 명,]  REFRENCE 참조할 테이블명 (컬럼명) [삭제룰] 
        2) 테이블 레벨 - [CONSTRAINT 제약조건명]] FROEIN KEY(컬럼명), REFENCE 참조할 테이블 명 [] (컬럼명) [삭제룰];

    [삭제룰]
        1) ON DELETE RESTRICT : 자식 테이블의 참조 키가 부모 테이블의 기본 키 값을 참조하는 경우 부모 테이블의 행을 삭제할 수 없다. (기본값)
        2) ON DELETE SET NULL : 부모 테이블의 데이터 삭제 시 참조하고 있는 자식 테이블의 참조 키 값이 NULL로 변경된다.
        3) ON DELETE CASCADE : 부모 테이블의 데이터 삭제 시 참조하고 있는 자식 테이블 참조 키 값이 존재하는 행 전체가 삭제된다. 
 */
-- 회원 등급에 대한 데이터를 저장하는 테이블 생성(부모 테이블)
CREATE TABLE MEMBER_GRADE (
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO MEMBER_GRADE VALUES (
    10,
    '일반회원'
);

INSERT INTO MEMBER_GRADE VALUES (
    20,
    '우수회원'
);

INSERT INTO MEMBER_GRADE VALUES (
    30,
    '특별회원'
);
    
-- 외래키 제약 조건    
CREATE TABLE MEMBER (
    NO          NUMBER,
    ID          VARCHAR2(20) NOT NULL,
    PASSWORD    VARCHAR2(20) NOT NULL,
    NAME        VARCHAR2(15) NOT NULL,
    GENDER      CHAR(3),
    AGE         NUMBER,
    GRADE_ID    NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_PK PRIMARY KEY ( NO ),
    CONSTRAINT MEMBER_ID_UQ UNIQUE ( ID ),
    CONSTRAINT MEMBER_GRADE_ID_FK FOREIGN KEY ( GRADE_ID )
        REFERENCES MEMBER_GRADE, /* [GRADE_CODE] */ -- 생략 가능(생략하면 자동으로 부모 테이블의 기본 키로 연결)
    CONSTRAINT MEMBER_GENDER_CK CHECK ( GENDER IN ( '남', '여' ) ),
    CONSTRAINT MEMBER_AGE_CK CHECK ( AGE > 0 )
);
-- 50이라는 값이 MEMBER_GRADE 테이블에 GRADE_CODE 컬럼에서 제공하는 값이 아니므로 외래 키 제약조건에 위배되어 에러가 발생한다.
INSERT INTO MEMBER VALUES (
    2,
    'USER2',
    '1234',
    '홍길동',
    '남',
    30,
    50, DEFAULT
);

INSERT INTO MEMBER VALUES (
    3,
    'USER3',
    '1234',
    '홍길동',
    '남',
    30,
    NULL, DEFAULT
);

INSERT INTO MEMBER VALUES (
    1,
    'USER1',
    '1234',
    '문인수',
    '남',
    30,
    NULL, DEFAULT
);



-- MEMBER 테이블과 MEMBER_GRADE 테이블을 조인해서 ID, NAME, GRADE_NAME 조회
-- ANSI
SELECT
    M.ID,
    M.NAME,
    G.GRADE_NAME
FROM
    MEMBER       M
    LEFT OUTER JOIN MEMBER_GRADE G ON ( M.GRADE_ID = G.GRADE_CODE );

-- ORACLE
SELECT
    M.ID,
    M.NAME,
    G.GRADE_NAME
FROM
    MEMBER       M,
    MEMBER_GRADE G
WHERE
    M.GRADE_ID = G.GRADE_CODE (+);
-- MEMBER_GRADE 테이블에서 GRADE_CODE가 10인 데이터를 지우기

-- 자식 테이블의 행들 중에 10을 참조하는 행이 있기 때문에 삭제할 수 없다.
DELETE FROM MEMBER_GRADE
WHERE
    GRADE_CODE = 10;

-- 자식 테이블의 행들이 30을 참조하고 있지 않기 때문에 삭제할 수 있다.
DELETE FROM MEMBER_GRADE
WHERE
    GRADE_CODE = 30;
    
-- ON DELETE SET 옵션  
CREATE TABLE MEMBER (
    NO          NUMBER,
    ID          VARCHAR2(20) NOT NULL,
    PASSWORD    VARCHAR2(20) NOT NULL,
    NAME        VARCHAR2(15) NOT NULL,
    GENDER      CHAR(3),
    AGE         NUMBER,
    GRADE_ID    NUMBER
        CONSTRAINT MEMBER_GRADE_ID_FK
            REFERENCES MEMBER_GRADE
                ON DELETE SET NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_PK PRIMARY KEY ( NO ),
    CONSTRAINT MEMBER_ID_UQ UNIQUE ( ID ),
    CONSTRAINT MEMBER_GENDER_CK CHECK ( GENDER IN ( '남', '여' ) ),
    CONSTRAINT MEMBER_AGE_CK CHECK ( AGE > 0 )
);

-- 자식 테이블의 행들 중에 10을 참조하는 행들의 값이 NULL로 변경된다.
DELETE FROM MEMBER_GRADE
WHERE
    GRADE_CODE = 10;

-- ON DELETE CASCADE 옵션  
CREATE TABLE MEMBER (
    NO          NUMBER,
    ID          VARCHAR2(20) NOT NULL,
    PASSWORD    VARCHAR2(20) NOT NULL,
    NAME        VARCHAR2(15) NOT NULL,
    GENDER      CHAR(3),
    AGE         NUMBER,
    GRADE_ID    NUMBER
        CONSTRAINT MEMBER_GRADE_ID_FK
            REFERENCES MEMBER_GRADE
                ON DELETE CASCADE,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_PK PRIMARY KEY ( NO ),
    CONSTRAINT MEMBER_ID_UQ UNIQUE ( ID ),
    CONSTRAINT MEMBER_GENDER_CK CHECK ( GENDER IN ( '남', '여' ) ),
    CONSTRAINT MEMBER_AGE_CK CHECK ( AGE > 0 )
);
-- 행이 삭제되는 것을 확인할 수 있다.
-- 단, 자식 테이블을 조회해 보면 삭제된 행을 참조하고 있던 컬럼의 행들이 모두 삭제된 것을 확인할 수 있다.
DELETE FROM MEMBER_GRADE
WHERE
    GRADE_CODE = 10;
    
/*
    <서브쿼리를 이용한 테이블 생성>
*/

-- EMPLOYEE 테이블을 복사한 새로운 테이블 생성(컬럼, 데이터 타입, 값, NOT NULL 제약조건 복사)
CREATE TABLE EMP_COPY
    AS
        SELECT
            *
        FROM
            EMPLOYEE;

SELECT
    *
FROM
    EMP_COPY;         

-- MEMBER 테이블 복사
CREATE TABLE MEM_COPY
    AS
        SELECT
            *
        FROM
            MEMBER;

SELECT
    *
FROM
    MEM_COPY;

DROP TABLE EMP_COPY;
            
-- EMPLOY 테이블을 복사한 새로운 테이블 생성(칼럼, 데이터 타입, NOT NULL 제약 조건을 복사) - 데이터 빼고
CREATE TABLE EMP_COPY
    AS
        SELECT
            *
        FROM
            EMPLOYEE
        WHERE
            1 = 0;  -- 모든 행에 대해서 매번 FALSE이므로 테이블의 구조만 복사한다.

SELECT
    *
FROM
    EMP_COPY;
    
 -- EMPLOYEE 테이블에서 사번, 직원명, 급여, 연봉을 저장하는 테이블 생성
CREATE TABLE EMP_COPY
    AS
        SELECT
            EMP_ID      사번,
            EMP_NAME    직원명,
            SALARY      급여,
            SALARY * 12 연봉 -- 산술연산 또는 함수 호출 구문이 기술된 경우 별칭을 정해줘야 한다.
        FROM
            EMPLOYEE;
            
------------------------- 실습 문제 -------------------------
-- 도서 관리 프로그램을 만들기 위한 테이블 만들기
-- 이때, 제약조건에 이름을 부여하고, 각 컬럼에 주석 달기

-- 1. 출판사들에 대한 데이터를 담기 위한 출판사 테이블 (TB_PUBLISHER)
--   1) 컬럼 : PUB_NO(출판사 번호) -- 기본 키
--             PUB_NAME(출판사명) -- NOT NULL
--             PHONE(출판사 전화번호)

--   2) 3개 정도의 샘플 데이터 추가하기

--1.1
CREATE TABLE TB_PUBLISHER (
    PUB_NO   VARCHAR2(30)
        CONSTRAINT PUB_NO_PK PRIMARY KEY,
    PUB_NAME VARCHAR2(30)
        CONSTRAINT PUB_NAME_NN NOT NULL,
    PHONE    NUMBER(12)
);

COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS
    '출판사 번호';

COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS
    '출판사명';

COMMENT ON COLUMN TB_PUBLISHER.PHONE IS
    '출판사 전화번호';
-- 1.2
INSERT INTO TB_PUBLISHER VALUES (
    1,
    '민음사',
    '024423909'
);

INSERT INTO TB_PUBLISHER VALUES (
    2,
    '비유와상징',
    '024420000'
);

INSERT INTO TB_PUBLISHER VALUES (
    3,
    '천재교육',
    '024427718'
);

SELECT * FROM TB_PUBLISHER;


-- 2. 도서들에 대한 데이터를 담기 위한 도서 테이블 (TB_BOOK)
--   1) 컬럼 : BK_NO(도서번호) -- 기본 키
--             BK_TITLE(도서명) -- NOT NULL
--             BK_AUTHOR(저자명) -- NOT NULL
--             BK_PRICE(가격)
--             BK_PUB_NO(출판사 번호) -- 외래 키(TB_PUBLISHER 테이블을 참조하도록)
--                                      이때 참조하고 있는 부모 데이터 삭제 시 자식 데이터도 삭제 되도록 옵션 지정

--   2) 5개 정도의 샘플 데이터 추가하기
DROP TABLE TB_BOOK;

CREATE TABLE TB_BOOK (
    BK_NO     VARCHAR2(30)
        CONSTRAINT BK_NO_PK PRIMARY KEY,
    BK_TITLE  VARCHAR2(500)
        CONSTRAINT BK_TITLE_NN NOT NULL,
    BK_AUTHOR VARCHAR2(500)
        CONSTRAINT BK_AUTHOR_NN NOT NULL,
    BK_PRICE  NUMBER(8),
    BK_PUB_NO
        CONSTRAINT BK_PUB_NO_FK
            REFERENCES TB_PUBLISHER
                ON DELETE CASCADE
);
COMMENT ON COLUMN TB_BOOK.BK_NO IS
    '도서번호';

COMMENT ON COLUMN TB_BOOK.BK_TITLE IS
    '도서명';

COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS
    '저자명';

COMMENT ON COLUMN TB_BOOK.BK_PRICE IS
    '가격';

COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS
    '출판사 번호';

INSERT INTO TB_BOOK VALUES (
    1,
    '난 책이 싫어',
    '정주리',
    '25000',
    1
);

INSERT INTO TB_BOOK VALUES (
    2,
    '난 메이플이 좋아',
    '권승원',
    '7000',
    2
);

INSERT INTO TB_BOOK VALUES (
    3,
    '정씨가문 유명인 정처기',
    '이정환',
    '11000',
    3
);

INSERT INTO TB_BOOK VALUES (
    4,
    '언제나 20대',
    '문인수',
    '41000',
    1
);

INSERT INTO TB_BOOK VALUES (
    5,
    '집에 있어도 집에 가고 싶어',
    '이정준',
    '8000',
    2
);


-- 3. 회원에 대한 데이터를 담기 위한 회원 테이블 (TB_MEMBER)
--  1) 컬럼 : MEMBER_NO(회원번호) -- 기본 키
--           MEMBER_ID(아이디)   -- 중복 금지
--           MEMBER_PWD(비밀번호) -- NOT NULL
--           MEMBER_NAME(회원명) -- NOT NULL
--           GENDER(성별)        -- 'M' 또는 'F'로 입력되도록 제한
--           ADDRESS(주소)       
--           PHONE(연락처)       
--           STATUS(탈퇴 여부)     -- 기본값으로 'N' 그리고 'Y' 혹은 'N'으로 입력되도록 제약조건
--           ENROLL_DATE(가입일)  -- 기본값으로 SYSDATE, NOT NULL

--  2) 3개 정도의 샘플 데이터 추가하기
DROP TABLE TB_MEMBER;

CREATE TABLE TB_MEMBER (
    MEMBER_NO   VARCHAR2(30)
        CONSTRAINT MEM_NO_PK PRIMARY KEY,
    MEMBER_ID   VARCHAR2(30)
        CONSTRAINT MEM_ID_UQ UNIQUE,
    MEMBER_PWD  VARCHAR2(30)
        CONSTRAINT MEM_PW_NN NOT NULL,
    MEMBER_NAME VARCHAR2(30)
        CONSTRAINT MEM_NAME NOT NULL,
    GENDER      CHAR(3)
        CONSTRAINT MEM_GEN_CK CHECK ( GENDER IN ( 'M', 'F' ) ),
    ADDRESS     VARCHAR(200),
    PHONE       NUMBER(12),
    STATUS      CHAR(2) DEFAULT 'N'
        CONSTRAINT MEM_STAT_CK CHECK ( STATUS IN ( 'Y', 'N' ) ),
    ENROLL_DATE DATE DEFAULT SYSDATE
        CONSTRAINT MEM_ENDATE_NN NOT NULL
);

COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS
    '회원번호';

COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS
    '아이디';

COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS
    '비밀번호';

COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS
    '회원명';

COMMENT ON COLUMN TB_MEMBER.GENDER IS
    '성별';

COMMENT ON COLUMN TB_MEMBER.ADDRESS IS
    '주소';

COMMENT ON COLUMN TB_MEMBER.PHONE IS
    '연락처';

COMMENT ON COLUMN TB_MEMBER.STATUS IS
    '탈퇴 여부';

COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS
    '가입일';

INSERT INTO TB_MEMBER VALUES (
    1,
    '0001',
    '0000',
    '이정준',
    'M',
    '서울시',
    0000000000, DEFAULT, DEFAULT
);

INSERT INTO TB_MEMBER VALUES (
    2,
    '0002',
    '0000',
    '이정환',
    'M',
    '서울시',
    0000000000, DEFAULT, DEFAULT
);

INSERT INTO TB_MEMBER VALUES (
    3,
    '0003',
    '0000',
    '정주리',
    'F',
    '대전시',
    0000000000, DEFAULT, DEFAULT
);

-- 4. 도서를 대여한 회원에 대한 데이터를 담기 위한 대여 목록 테이블(TB_RENT)
--  1) 컬럼 : RENT_NO(대여번호) -- 기본 키
--           RENT_MEM_NO(대여 회원번호) -- 외래 키(TB_MEMBER와 참조)
--                                      이때 부모 데이터 삭제 시 NULL 값이 되도록 옵션 설정
--           RENT_BOOK_NO(대여 도서번호) -- 외래 키(TB_BOOK와 참조)
--                                      이때 부모 데이터 삭제 시 NULL 값이 되도록 옵션 설정
--           RENT_DATE(대여일) -- 기본값 SYSDATE

--  2) 샘플 데이터 3개 정도 

DROP TABLE TB_RENT;

CREATE TABLE TB_RENT (
    RENT_NO      VARCHAR(30)
        CONSTRAINT RT_NO_PK PRIMARY KEY,
    RENT_MEM_NO  VARCHAR(30)
        CONSTRAINT RT_MEM_NO_FK
            REFERENCES TB_MEMBER
                ON DELETE SET NULL,
    RENT_BOOK_NO VARCHAR(30)
        CONSTRAINT RT_BK_NO_FK
            REFERENCES TB_BOOK
                ON DELETE SET NULL,
    RENT_DATE    DATE DEFAULT SYSDATE
);

COMMENT ON COLUMN TB_RENT.RENT_NO IS
    '대여번호';

COMMENT ON COLUMN TB_RENT.RENT_MEM_NO IS
    '대여 회원번호';

COMMENT ON COLUMN TB_RENT.RENT_BOOK_NO IS
    '대여 도서번호';

COMMENT ON COLUMN TB_RENT.RENT_DATE IS
    '대여일';

INSERT INTO TB_RENT VALUES (
    1,
    3,
    1, DEFAULT
);

INSERT INTO TB_RENT VALUES (
    2,
    1,
    5, DEFAULT
);

INSERT INTO TB_RENT VALUES (
    3,
    1,
    3, DEFAULT
);

INSERT INTO TB_RENT VALUES (
    4,
    2,
    2, DEFAULT
);

-- 5. 2번 도서를 대여한 회원의 이름, 아이디, 대여일, 반납 예정일(대여일 + 7일)을 조회하시오.

SELECT
    M.MEMBER_NAME,
    M.MEMBER_ID,
    R.RENT_DATE,
    R.RENT_DATE + 7
FROM
         TB_MEMBER M
    JOIN TB_RENT R ON ( M.MEMBER_NO = R.RENT_MEM_NO )
WHERE
    R.RENT_BOOK_NO = 2;


-- 6. 회원번호가 1번인 회원이 대여한 도서들의 도서명, 출판사명, 대여일, 반납예정일을 조회하시오.
SELECT
    B.BK_TITLE,
    P.PUB_NAME,
    R.RENT_DATE,
    R.RENT_DATE + 7
FROM
         TB_MEMBER M
    JOIN TB_RENT      R ON ( M.MEMBER_NO = R.RENT_MEM_NO )
    JOIN TB_BOOK      B ON ( R.RENT_BOOK_NO = B.BK_NO )
    JOIN TB_PUBLISHER P ON ( B.BK_PUB_NO = P.PUB_NO )
WHERE
    M.MEMBER_NO = 1;

COMMIT;
------------------------------------------------------------     