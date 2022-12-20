/*
1. 계열 정보를 저장핛 카테고리 테이블을 맊들려고 핚다. 다음과 같은 테이블을
작성하시오.

테이블 이름
TB_CATEGORY
컬럼
NAME, VARCHAR2(10) 
USE_YN, CHAR(1), 기본값은 Y 가 들어가도록

*/

CREATE TABLE TB_CATEGORY (
    NAME   VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

/*
2. 과목 구분을 저장핛 테이블을 맊들려고 핚다. 다음과 같은 테이블을 작성하시오.
테이블이름
TB_CLASS_TYPE
컬럼
NO, VARCHAR2(5), PRIMARY KEY
NAME , VARCHAR2(10)
*/

CREATE TABLE TB_CLASS_TYPE ( 
    NO  VARCHAR2(5) PRIMARY KEY,
    NAME    VARCHAR2(10)
);

COMMIT;



/*
3. TB_CATAGORY 테이블의 NAME 컬럼에 PRIMARY KEY 를 생성하시오.
(KEY 이름을 생성하지 않아도 무방함. 맊일 KEY 이를 지정하고자 핚다면 이름은 본인이
알아서 적당핚 이름을 사용핚다.)

/*
4. TB_CLASS_TYPE 테이블의 NAME 컬럼에 NULL 값이 들어가지 않도록 속성을 변경하시오
*/

ALTER TABLE TB_CLASS_TYPE MODIFY NAME [CONSTRAINT STUDY_TB_CT_NAME_NN] NOT NULL;

