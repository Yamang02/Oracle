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
    SYSDATE);
    
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
    PASSWORD, NAME
) VALUES (
    'USER4',
    '0000',
    '진도준'
    
);
-- 테이블의 데이터를 수정하는 SQL 구문
UPDATE MEMBER
SET ID = 'USER33';

-- 제약조건 확인
-- 사용자가 작성한 제약조건을 확인하는 뷰 테이블이다.
SELECT *
FROM USER_CONSTRAINTS;

-- 사용자가 작성한 제약조건DL 걸려있는 컬럼을 확인하는 뷰 테이블이다.
SELECT *
FROM USER_CONS_COLUMNS;

/*
    2. UNIQUE 제약조건
    컬럼에 중복된 값을 저장하거나 중복된 값으로 수정할 수 없도록 한다.
    UNIQUE 제약조건은 컬럼 레벨, 테이블 레벨에서 모두 설정이 가능하다.
*/
INSERT INTO MEMBER VALUES ('USER1', '1234', '문인수', DEFAULT);
INSERT INTO MEMBER VALUES ('USER1', '1234', '문인수', DEFAULT);

SELECT * FROM MEMBER;

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    ID          VARCHAR2(20) CONSTRAINT MEMBER_ID_NN NOT NULL,
    PASSWORD    VARCHAR2(20) CONSTRAINT MEMBER_PASSWORD_NN NOT NULL ,
    NAME        VARCHAR2(15) CONSTRAINT "이름 낫널" NOT NULL ,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID)
);

-- UNIQUE 제약조건에 위배되었으므로 INSERT 실패
INSERT INTO MEMBER VALUES ('USER1', '1234', '문인수', DEFAULT);
INSERT INTO MEMBER VALUES ('USER1', '1234', '성춘향', DEFAULT);
