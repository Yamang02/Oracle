/*
    <DCL (DATA CONTROL LANGUAGE) >
        데이터를 제어하는 구문으로 계정에게 시스템 권한 또는 객체에 대한 접근 권한을 부여(GRANT)하거나 회수(REVOKE)하는 구문이다.
        
    <시스템 권한>
        데이터베이스에 접근하는 권한, 오라클에서 제공하는 객체들을 생성/삭제할 수 있는 권한
            - CREATE SESSION : 데이터베이스에 접속할 수 있는 권한
            - CREATE TABLE : 테이블을 생성할 수 있는 권한
            - CREATE VIEW : 뷰를 생성할 수 있는 권한
            - CREATE USER : 계정을 생성할 수 있는 권한
            - DROP USER : 계정을 삭제할 수 있는 권한
            ...
    
        [표현법]
            GRANT 권한[, 권한, 권한 ....] TO 계정;
            REVOKE 권한[, 권한, 권한 ....] FROM 계정;
    
*/

-- 1. SAMPLE 계정 생성

CREATE USER SAMPLE IDENTIFIED BY SAMPLE;

-- 계정 접속을 위한 권한 부여
GRANT
    CREATE SESSION
TO SAMPLE;

-- 3. SAMPLE 계정에 테이블 생성할 수 있는 권한 부여
GRANT
    CREATE TABLE
TO SAMPLE;

-- 4. 테이블 스페이스 할당 (테이블, 뷰, 인덱스 등 객체들이 저장되는 공간)
ALTER USER SAMPLE
    QUOTA 2M ON SYSTEM;

/*

    <객체 접근 권한>
        특정 개체를 조작할 수 있는 권한
        - SELCET : TABLE, VIEW, SEQUENCE
        - INSERT : TABLE, VIEW
        - UPDATE : TABLE, VIEW
        - ARLTER : TABLE, SEQUENCE

*/

-- 5.KH.EMPLOYEE 테이블을 조회할 수 있는 권한 부여
/*

[표현법]
            GRANT 권한[, 권한, 권한 ....] ON 객체 TO 계정;
            REVOKE 권한[, 권한, 권한 ....] ON 객체 FROM 계정;

*/
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

GRANT SELECT ON KH.DEPARTMENT TO SAMPLE;

-- 6.KH.DEPARTMENT 테이블에 데이터를 삽입할 수 있는 할 수 있는 권한 부여

GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

-- 7.KH.DEPARTMENT 테이블에 데이터를 삽입할 수 있는 권한을 회수
REVOKE INSERT ON KH.DEPARTMENT FROM SAMPLE;

/*
    <ROLE>  
        권한들을 하나의 집합으로 묶어놓은 것을 ROLE이라 한다. (SYS계정으로 확인 가능)
*/

SELECT
    *
FROM
    ROLE_SYS_PRIVS
WHERE
    ROLE = 'CONNECT';

SELECT
    *
FROM
    ROLE_SYS_PRIVS
WHERE
    ROLE = 'RESOURCE';

SELECT
    *
FROM
    ROLE_SYS_PRIVS
WHERE
    ROLE = 'DBA';



-- ROLE을 직접 만들 수도 있다.
CREATE ROLE MYROLE;

SELECT
    *
FROM
    ROLE_SYS_PRIVS
WHERE
    ROLE = 'MYROLE';

CREATE ROLE MYROLE;

GRANT
    CREATE SESSION,
    CREATE TABLE
TO MYROLE;




/*
CREATE USER SAMPLE2 IDENTIFIED BY SAMPLE2;

SELECT
    *
FROM
    DBA_SYS_PRIVS
WHERE
    GRANTEE = 'SAMPLE2';

SELECT
    TABLESPACE_NAME
FROM
    DBA_TABLESPACES;

SELECT
    FILE_ID,
    TABLESPACE_NAME,
    FILE_NAME
FROM
    DBA_DATA_FILES;

DROP USER SAMPLE2;

*/