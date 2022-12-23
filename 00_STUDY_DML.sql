/* DML
1. 과목유형 테이블(TB_CLASS_TYPE)에 아래와 같은 데이터를 입력하시오.


번호, 유형이름
------------
01, 전공필수
02, 전공선택
03, 교양필수
04, 교양선택
05. 논문지도

*/

INSERT INTO TB_CLASS_TYPE VALUES (
    01,
    '전공필수'
);

INSERT INTO TB_CLASS_TYPE VALUES (
    02,
    '전공선택'
);

INSERT INTO TB_CLASS_TYPE VALUES (
    03,
    '교양필수'
);

INSERT INTO TB_CLASS_TYPE VALUES (
    04,
    '교양선택'
);

INSERT INTO TB_CLASS_TYPE VALUES (
    05,
    '논문지도'
);


/*
2. 춘 기술대학교 학생들의 정보가 포함되어 있는 학생일반정보 테이블을 맊들고자 핚다. 
아래 내용을 참고하여 적젃핚 SQL 문을 작성하시오. (서브쿼리를 이용하시오)

테이블이름
TB_학생일반정보
컬럼
학번
학생이름
주소
*/

CREATE TABLE TB_학생일반정보
    AS
        SELECT
            STUDENT_NO      학번,
            STUDENT_NAME    학생이름,
            STUDENT_ADDRESS 주소
        FROM
            TB_STUDENT;
            
/*
3. 국어국문학과 학생들의 정보맊이 포함되어 있는 학과정보 테이블을 맊들고자 핚다. 
아래 내용을 참고하여 적젃핚 SQL 문을 작성하시오. (힌트 : 방법은 다양함, 소신껏
작성하시오)

테이블이름
TB_국어국문학과
컬럼
학번
학생이름
출생년도 <= 네자리 년도로 표기
교수이름

*/
DROP TABLE TB_국어국문학과;

CREATE TABLE TB_국어국문학과
    AS
        SELECT
            D.DEPARTMENT_NAME 학과명,
            S.STUDENT_NO      학번,
            S.STUDENT_NAME    학생이름,
            EXTRACT(YEAR FROM(TO_DATE(SUBSTR(S.STUDENT_SSN, 1, 2),
        'RR')))           출생년도,
            P.PROFESSOR_NAME  교수이름,
            S.COACH_PROFESSOR_NO
        FROM
            TB_STUDENT    S
            LEFT JOIN TB_PROFESSOR  P ON ( S.COACH_PROFESSOR_NO = P.PROFESSOR_NO )
            LEFT JOIN TB_DEPARTMENT D ON ( S.DEPARTMENT_NO = D.DEPARTMENT_NO )
        WHERE
            D.DEPARTMENT_NAME = '국어국문학과';