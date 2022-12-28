/*
    <INDEX>
        INDEX는 오라클에서 제공하는 객체
        SQL 명령문의 처리 속도를 향상시키기 위해 행들의 위치 정보를 가지고 있다. 

*/

SELECT
    ROWID,
    E.*
FROM
    EMPLOYEE E;

SELECT
    *
FROM
    USER_IND_COLUMNS;

SELECT
    *
FROM
    USER_INDEXES;

-- 실행 계획으로 확인하면 TABLE FULL SCAN을 하는 것을 확인할 수 있다.
SELECT
    *
FROM
    EMPLOYEE;

-- 인덱스가 걸린 컬럼으로 데이터를 조회해도 TABLE FULL SCAN으로 확인된다.
-- 데이터가 얼마 없으면 오라클에서 굳이 인덱스를 사용해서 데이터를 조회하지 않는다.
SELECT
    *
FROM
    EMPLOYEE
WHERE
    EMP_ID = 200;

-- 춘 대학교 계정으로 접속
SELECT
    *
FROM
    TB_STUDENT
WHERE
    STUDENT_NAME = '한효종';

SELECT
    *
FROM
    TB_STUDENT
WHERE
    STUDENT_NO = 'A511320';

-- 비고유 인덱스 생성
CREATE INDEX IDX_STUDENT_NAME ON
    TB_STUDENT (
        STUDENT_NAME
    );

-- A031347	C5009600

SELECT
    *
FROM
    TB_GRADE
WHERE
        CLASS_NO = 'C5009600'
    AND STUDENT_NO = 'A031347';
    
-- 결합 인덱스 생성

CREATE INDEX IDX_TB_STUDENT_CLASS_NO ON
    TB_GRADE (
        STUDENT_NO,
        CLASS_NO
    );
    
DROP INDEX IDX_STUDENT_NAME;
DROP INDEX IDX_STUDENT_CLASS_NO;



