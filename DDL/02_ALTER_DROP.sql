/*
    <ALTER>
        데이터베이스 객체를 수정하는 구문이다.
    
    <TABLE 수정>
    
    1. 컬럼 추가 / 수정 / 삭제 / 이름 변경
*/
-- 실습에 사용할 테이블 생성
CREATE TABLE DEPT_COPY
    AS
        SELECT
            *
        FROM
            DEPARTMENT;

SELECT
    *
FROM
    DEPT_COPY;

/*
    1. 컬럼 추가 / 수정 / 삭제 / 이름 변경
        1) 컬럼 추가 (ADD)
        
*/
-- DEPT_COPY 테이블에 CNAME 컬럼을 테이블 맨 뒤에 추가한다.

ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);

-- DEPT_COPY 테이블에 LNAME 컬럼을 테이블 맨 뒤에 추가한다 (기본값 : 대한민국)

ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(40) DEFAULT '대한민국';


--        2) 컬럼 수정(MODIFY)

-- DEPT_ID 의 자료형을 CHAR(3)으로 변경
ALTER TABLE DEPT_COPY MODIFY
    DEPT_ID CHAR(3);

ALTER TABLE DEPT_COPY MODIFY
    DEPT_ID VARCHAR(5);


-- DEPT_COPY 테이블에 CNAME 컬럼의 데이터 타입을 NUMBER로 변경
ALTER TABLE DEPT_COPY MODIFY
    CNAME NUMBER; --값이 없으면 데이터 타입 변경이 가능하다. 

-- DEPT_COPY 테이블에 DEPT_TITLE 컬럼의 데이터타입을 VARCHAR2(40),
ALTER TABLE DEPT_COPY MODIFY
    DEPT_TITLE VARCHAR2(40);
-- LOCATION_ID 컬럼의 데이터 타입을 VARCHAR2(2)로 변경하기
ALTER TABLE DEPT_COPY MODIFY
    LOCATION_ID VARCHAR2(2);

ALTER TABLE DEPT_COPY MODIFY
    LNAME DEFAULT '미국';

ALTER TABLE DEPT_COPY MODIFY
    DEPT_TITLE VARCHAR2(40)
MODIFY
    LOCATION_ID VARCHAR2(2)
MODIFY
    LNAME DEFAULT '미국';
    
/*
    3) 컬럼 삭제 (DROP COLUMN)
*/

-- DEPT_COPY 테이블에서 DEPT_ID 컬럼 삭제
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_ID;

ROLLBACK; -- DDL 구문은 ROLLBACK으로 복구 불가능

SELECT
    *
FROM
    DEPT_COPY;

ALTER TABLE DEPT_COPY DROP COLUMN DEPT_TITLE;

ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID;

ALTER TABLE DEPT_COPY DROP COLUMN CNAME;

-- 테이블에 최소한 한 개의 칼럼은 존재해야 한다.
ALTER TABLE DEPT_COPY DROP COLUMN LNAME;

SELECT
    *
FROM
    MEMBER_GRADE;
-- PARENT 키는 삭제할 수 없다.
ALTER TABLE MEMBER_GRADE DROP COLUMN GRADE_CODE;

-- 그래도 삭제하려면, 제약조건과 함께 삭제한다
ALTER TABLE MEMBER_GRADE DROP COLUMN GRADE_CODE CASCADE CONSTRAINTS;

--ALTER와 RENAME 구문을 이용해서 컬럼의 이름을 변경할 수 있다.
ALTER TABLE DEPT_COPY RENAME COLUMN LNAME TO LOCATIONNAME;

/*
    2. 제약조건 추가/ 삭제/ 이름 변경
    1) 제약조건 추가 (ADD)
*/
-- 실습에 사용할 테이블 생성
CREATE TABLE DEPT_COPY
    AS
        SELECT
            *
        FROM
            DEPARTMENT;
            
--DEPT_COPY 테이블의 DEPT_ID 컬럼에 PK 제약조건 추가
ALTER TABLE DEPT_COPY ADD CONSTRAINT DEPT_COPY_DEPT_ID_PK PRIMARY KEY ( DEPT_ID );

--DEPT_TITLE 컬럼에 NN과 UQ 제약조건 추가
ALTER TABLE DEPT_COPY ADD CONSTRAINT DEPT_COPY_DEPT_ID_PK PRIMARY KEY ( DEPT_ID );

ALTER TABLE DEPT_COPY ADD CONSTRAINT DEPT_COPY_DEPT_TITLE_UQ UNIQUE ( DEPT_TITLE );

ALTER TABLE DEPT_COPY MODIFY
    DEPT_TITLE
        CONSTRAINT DEPT_COPY_TITLE_NN NOT NULL;

-- EMPLOYEE 테이블의 DEPT_CODE와 JOB_CODE 컬럼에 FOREIGN KEY 제약 조건 적용(추가)
ALTER TABLE EMPLOYEE
    ADD CONSTRAINT TB_EMP_DEPT_CODE_FK FOREIGN KEY ( DEPT_CODE )
        REFERENCES DEPARTMENT ( DEPT_ID );

ALTER TABLE EMPLOYEE
    ADD CONSTRAINT TB_EMP_JOB_CODE_FK FOREIGN KEY ( JOB_CODE )
        REFERENCES JOB ( JOB_CODE );

--MEMBER_GRADE 테이블에 ALTER를 통해 PRIAMRY KEY 제약조건 추가
-- MEMBER_GRADE
CREATE TABLE MEMBER_GRADE (
    GRADE_CODE NUMBER,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

ALTER TABLE MEMBER_GRADE ADD CONSTRAINT MEM_GR_GRADE_CODE_PK PRIMARY KEY ( GRADE_CODE );

-- MEMBER 테이블에 PK. UQ, FK ,C 제약조건을 추가
CREATE TABLE MEMBER (
    NO          NUMBER,
    ID          VARCHAR2(20) NOT NULL,
    PASSWORD    VARCHAR2(20) NOT NULL,
    NAME        VARCHAR2(15) NOT NULL,
    GENDER      CHAR(3),
    AGE         NUMBER,
    GRADE_ID    NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE
);

ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_NO_PK PRIMARY KEY ( NO );

ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_ID_UQ UNIQUE ( ID );

ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_GRADE_ID_FK FOREIGN KEY ( GRADE_ID )
    REFERENCES MEMBER_GRADE;

ALTER TABLE MEMBER
    ADD CONSTRAINT MEMBER_GENDER_CK CHECK ( GENDER IN ( '남', '여' ) );

ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_AGE_CK CHECK ( AGE > 0 );


/*
    2) 제약조건 삭제
*/
-- DEPT_COPY 테이블의 DEPT_COPY_DEPT_ID_PK 제약조건 삭제

ALTER TABLE DEPT_COPY DROP CONSTRAINT DEPT_COPY_DEPT_ID_PK;

-- DEPT_COPY 테이블의 DEPT_COPY_DEPT_TITLE_UQ, DEPT_COPY_DEPT_TITLE_NN 제약조건 삭제
ALTER TABLE DEPT_COPY DROP CONSTRAINT DEPT_COPY_DEPT_TITLE_UQ;
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE NULL;

/*
    3) 제약조건명 변경(RENAME CONSTRAINT)
*/
-- DEPT_COPY 테이블의 SYS_C007236 제약조건명을 DEPT_COPY_DEPT_ID_NN으로 변경

ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007236 TO DEPT_COPY_DEPT_ID_NN;

-- DEPT_COPY 테이블의 SYS_C007237 제약조건명을 DEPT_COPY_LOCATION_ID_NN으로 변경

ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007237 TO DEPT_COPY_LOCATION_ID_NN;

-- MEMBER와 MEMBER_GRADE SYS_C007244, SYS_C007245, SYS_C007246 ID, PW, NAME
/*
ALTER TABLE MEMBER와 RENAME CONSTRAINT SYS_C007244 TO MEMEBER_ID_NN
    RENAME CONSTRAINT SYS_C007245 TO MEMEBER_PW_NN,
    RENAME CONSTRAINT SYS_C007246 TO MEMEBER_NAME_NN  
; */

/*
    3. 테이블명 변경 (RENAME)
*/
-- DEPT_COPY 테이블의 이름을 DEPT_TEST로 변경

ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;
RENAME DEPT_TEST TO DPET_TETS;

SELECT * FROM DPET_TETS;
RENAME DPET_TETS TO DEPT_TEST;

SELECT * FROM DEPT_TEST;

/*
    <DROP>
        데이터베이스 객체(테이블, 인덱스, 뷰 등)을 삭제하는 구문이다.
*/

-- DEPT_TEST 테이블 삭제
DROP TABLE DEPT_TEST;


-- MEMBER_GRADE 테이블 삭제
-- 참조되고 있는 부모 테이블은 함부로 삭제가 되지 않는다.
DROP TABLE MEMBER_GRADE;

-- 그래도 삭제하고 싶다면 1) 자식 테이블 먼저 삭제하고 삭제
DROP TABLE MEMBER;
DROP TABLE MEMBER_GRADE;

-- 2) 부모 테이블을 삭제할 때 제약 조건도 함께 삭제한다.
DROP TABLE MEMBER_GRADE CASCADE CONSTRAINTS;

