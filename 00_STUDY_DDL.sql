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
    NO   VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

COMMIT;



/*
3. TB_CATAGORY 테이블의 NAME 컬럼에 PRIMARY KEY 를 생성하시오.
(KEY 이름을 생성하지 않아도 무방함. 맊일 KEY 이를 지정하고자 핚다면 이름은 본인이
알아서 적당핚 이름을 사용핚다.)
*/

ALTER TABLE TB_CATEGORY ADD CONSTRAINT TB_CAT_NAME_PK PRIMARY KEY ( NAME );



/*
4. TB_CLASS_TYPE 테이블의 NAME 컬럼에 NULL 값이 들어가지 않도록 속성을 변경하시오
*/

ALTER TABLE TB_CLASS_TYPE MODIFY
    NAME
        CONSTRAINT STUDY_TB_CT_NAME_NN NOT NULL;


/*
5. 두 테이블에서 컬럼 명이 NO 인 것은 기존 타입을 유지하면서 크기는 10 으로, 컬럼명이
NAME 인 것은 마찪가지로 기존 타입을 유지하면서 크기 20 으로 변경하시오
*/

ALTER TABLE TB_CLASS_TYPE MODIFY
    NO VARCHAR2(10)
MODIFY
    NAME VARCHAR2(20);

ALTER TABLE TB_CATEGORY MODIFY
    NAME VARCHAR2(20);
    
/*
6. 두 테이블의 NO 컬럼과 NAME 컬럼의 이름을 각 각 TB_ 를 제외핚 테이블 이름이 앞에
붙은 형태로 변경핚다.
(ex. CATEGORY_NAME)
*/

ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NAME TO CLASS_TYPE_NAME;

ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;

/*
7. TB_CATAGORY 테이블과 TB_CLASS_TYPE 테이블의 PRIMARY KEY 이름을 다음과 같이
변경하시오.
*/

ALTER TABLE TB_CATEGORY RENAME CONSTRAINT TB_CAT_NAME_PK TO PK_CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINT SYS_C007062 TO PK_CLASS_TYPE_NO;

/*
8. 다음과 같은 INSERT 문을 수행핚다.
*/

INSERT INTO TB_CATEGORY VALUES (
    '공학',
    'Y'
);

INSERT INTO TB_CATEGORY VALUES (
    '자연과학',
    'Y'
);

INSERT INTO TB_CATEGORY VALUES (
    '의학',
    'Y'
);

INSERT INTO TB_CATEGORY VALUES (
    '예체능',
    'Y'
);

INSERT INTO TB_CATEGORY VALUES (
    '인문사회',
    'Y'
);

COMMIT; 

/*
9.TB_DEPARTMENT 의 CATEGORY 컬럼이 TB_CATEGORY 테이블의 CATEGORY_NAME 컬럼을 부모
값으로 참조하도록 FOREIGN KEY 를 지정하시오. 이 때 KEY 이름은
FK_테이블이름_컬럼이름으로 지정핚다. (ex. FK_DEPARTMENT_CATEGORY )
*/

ALTER TABLE TB_DEPARTMENT
    ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY ( CATEGORY )
        REFERENCES TB_CATEGORY ( CATEGORY_NAME );
        
/*
10. 춘 기술대학교 학생들의 정보맊이 포함되어 있는 학생일반정보 VIEW 를 맊들고자 핚다. 
아래 내용을 참고하여 적젃핚 SQL 문을 작성하시오.
*/

CREATE OR REPLACE VIEW VW_학생일반정보 AS
    SELECT
        TB_STUDENT.STUDENT_NO      AS "학번",
        TB_STUDENT.STUDENT_NAME    AS "학생이름",
        TB_STUDENT.STUDENT_ADDRESS AS "주소"
    FROM
        TB_STUDENT;
        
/*

11. 춘 기술대학교는 1 년에 두 번씩 학과별로 학생과 지도교수가 지도 면담을 진행핚다. 
이를 위해 사용핛 학생이름, 학과이름, 담당교수이름 으로 구성되어 있는 VIEW 를 맊드시오.
이때 지도 교수가 없는 학생이 있을 수 있음을 고려하시오 (단, 이 VIEW 는 단순 SELECT 
맊을 핛 경우 학과별로 정렬되어 화면에 보여지게 맊드시오.)

*/

CREATE VIEW VW_CONSULTING AS
    WITH STU_COACH_PR AS (
        SELECT
            S.STUDENT_NAME       "학생이름",
            S.COACH_PROFESSOR_NO "담당교수NO",
            P.PROFESSOR_NAME     "담당교수이름",
            S.DEPARTMENT_NO
        FROM
            TB_STUDENT   S
            LEFT OUTER JOIN TB_PROFESSOR P ON ( S.COACH_PROFESSOR_NO = P.PROFESSOR_NO )
    )
    SELECT
        C.학생이름,
        D.DEPARTMENT_NAME "학과 이름",
        C.담당교수이름
    FROM
        STU_COACH_PR  C
        LEFT OUTER JOIN TB_DEPARTMENT D USING ( DEPARTMENT_NO )
    ORDER BY
        D.DEPARTMENT_NAME;
        
 /*
 12. 모든 학과의 학과별 학생 수를 확인핛 수 있도록 적젃핚 VIEW 를 작성해 보자.
 */

DROP VIEW STU_COUNT_BY_DEPT;

CREATE VIEW STU_COUNT_BY_DEPT AS
    SELECT
        C."학과코드",
        D.DEPARTMENT_NAME 학과명,
        C."학과별 학생수"
    FROM
             (
            SELECT
                DEPARTMENT_NO "학과코드",
                LPAD(CONCAT(COUNT(*),
                            '명'),
                     14)      "학과별 학생수"
            FROM
                TB_STUDENT
            GROUP BY
                DEPARTMENT_NO
        ) C
        JOIN TB_DEPARTMENT D ON ( C.학과코드 = D.DEPARTMENT_NO )
    ORDER BY
        C."학과코드";
        
 /*
 13. 위에서 생성핚 학생일반정보 View 를 통해서 학번이 A213046 인 학생의 이름을 본인
이름으로 변경하는 SQL 문을 작성하시오. 
 */

UPDATE VW_학생일반정보
SET
    학생이름 = '이정준'
WHERE
    학번 = 'A213046';

SELECT
    학생이름
FROM
    VW_학생일반정보
WHERE
    학번 = 'A213046';

SELECT
    *
FROM
    TB_STUDENT
WHERE
    STUDENT_NO = 'A213046';    
    
/*
14. 13 번에서와 같이 VIEW 를 통해서 데이터가 변경될 수 있는 상황을 막으려면 VIEW 를
어떻게 생성해야 하는지 작성하시오. 

-- 기름같은 걸 끼얹나?
-- CREATE VIEW WITH READ ONLY
*/

DROP VIEW VW_학생일반정보;
-- CREATE OR REPLACE VIEW
CREATE VIEW VW_학생일반정보 AS
    SELECT
        TB_STUDENT.STUDENT_NO      AS "학번",
        TB_STUDENT.STUDENT_NAME    AS "학생이름",
        TB_STUDENT.STUDENT_ADDRESS AS "주소"
    FROM
        TB_STUDENT
WITH READ ONLY;

UPDATE VW_학생일반정보
SET
    학생이름 = '이정준'
WHERE
    학번 = 'A213046';
/*
SQL 오류: ORA-42399: cannot perform a DML operation on a read-only view
42399.0000 - "cannot perform a DML operation on a read-only view"
*/

/*
15. 춘 기술대학교는 매년 수강신청 기갂맊 되면 특정 인기 과목들에 수강 신청이 몰려
문제가 되고 있다. (2003 기준)최근 3 년을 기준으로 수강인원이 가장 맋았던 3 과목을 찾는 구문을
작성해보시오.

-- 기간별 수강인원 = TB_GRADE 테이블의 TERM_NO 와 CLASS_NO 사용...?
-- CLASS_NO가 PRIMARY_KEY  =  CLASS_NO, 학기가 달라도 CLASS_NO은 같음

*/

-- 최종 개설학기 계산 , 3년 전 학기 계산------------------------------------------------
SELECT
    MAX(TERM_NO) - 300
FROM
    (
        SELECT
            TERM_NO
        FROM
            TB_GRADE
        GROUP BY
            TERM_NO
    );
    
---학기별, 과목별 수강인원 계산----------------------------------------------------

SELECT
    TERM_NO,
    CLASS_NO,
    COUNT(*) AS "수강인원"
FROM
    TB_GRADE GR
GROUP BY
    TERM_NO,
    CLASS_NO
ORDER BY
    수강인원 DESC;
-----------------------------------------------------------------------------------
-- 학기가 3년 이내인 과목의 누적 수강인원 계산

SELECT
    SU.CLASS_NO  과목번호,
    C.CLASS_NAME 과목명,
    SU."누적수강인원"
FROM
    (
        SELECT
            CLASS_NO,
            SUM(수강인원) AS "누적수강인원"
        FROM
            (
                SELECT
                    TERM_NO,
                    CLASS_NO,
                    COUNT(*) AS "수강인원"
                FROM
                    TB_GRADE GR
                GROUP BY
                    TERM_NO,
                    CLASS_NO
                ORDER BY
                    수강인원 DESC
            )
        WHERE
            TERM_NO >= (
                SELECT
                    MAX(TERM_NO) - 300
                FROM
                    (
                        SELECT
                            TERM_NO
                        FROM
                            TB_GRADE
                        GROUP BY
                            TERM_NO
                    )
            )
        GROUP BY
            CLASS_NO
    )        SU
    LEFT OUTER JOIN TB_CLASS C ON ( SU.CLASS_NO = C.CLASS_NO )
ORDER BY
    누적수강인원 DESC;






-----------------------------------------------------------------
---  3위까지만 보이게 출력 -------------------------
SELECT
    *
FROM
    (
        SELECT
            SU.CLASS_NO  과목번호,
            C.CLASS_NAME 과목명,
            SU."누적수강인원"
        FROM
            (
                SELECT
                    CLASS_NO,
                    SUM(수강인원) AS "누적수강인원"
                FROM
                    (
                        SELECT
                            TERM_NO,
                            CLASS_NO,
                            COUNT(*) AS "수강인원"
                        FROM
                            TB_GRADE GR
                        GROUP BY
                            TERM_NO,
                            CLASS_NO
                        ORDER BY
                            수강인원 DESC
                    )
                WHERE
                    TERM_NO >= (
                        SELECT
                            MAX(TERM_NO) - 300
                        FROM
                            (
                                SELECT
                                    TERM_NO
                                FROM
                                    TB_GRADE
                                GROUP BY
                                    TERM_NO
                            )
                    )
                GROUP BY
                    CLASS_NO
            )        SU
            LEFT OUTER JOIN TB_CLASS C ON ( SU.CLASS_NO = C.CLASS_NO )
        ORDER BY
            누적수강인원 DESC
    )
WHERE
    ROWNUM <= 3;
    
-------------------------------- 답안 (3개년) ---------------------------------

SELECT
    A.*
FROM
    (
        SELECT
            A.CLASS_NO,
            B.CLASS_NAME,
            COUNT(A.STUDENT_NO),
            DENSE_RANK()
            OVER(
                ORDER BY
                    COUNT(A.STUDENT_NO) DESC
            ) RANKCNT
        FROM
            TB_GRADE A
            LEFT JOIN TB_CLASS B ON A.CLASS_NO = B.CLASS_NO
        WHERE
                1 = 1
            AND SUBSTR(A.TERM_NO, 1, 4) IN (
                SELECT
                    SUBSTR(V.TERM_NO, 1, 4)
                FROM
                    (
                        SELECT
                            SUBSTR(A.TERM_NO, 1, 4) TERM_NO
                        FROM
                            TB_GRADE A
                            LEFT JOIN TB_CLASS B ON A.CLASS_NO = B.CLASS_NO
                        WHERE
                            1 = 1
                        GROUP BY
                            SUBSTR(A.TERM_NO, 1, 4)
                        ORDER BY
                            1 DESC
                    ) V
                WHERE
                        1 = 1
                    AND ROWNUM <= 3
            )
        GROUP BY
            A.CLASS_NO,
            B.CLASS_NAME
    ) A
WHERE
        1 = 1
    AND RANKCNT <= 3;
    
-------------------------답안(누적) -----------------------------------

SELECT
    *
FROM
    (
        SELECT
            A.CLASS_NO,
            B.CLASS_NAME,
            COUNT(A.STUDENT_NO)
        FROM
                 TB_GRADE A
            INNER JOIN (
                SELECT
                    A.*
                FROM
                    (
                        SELECT
                            A.CLASS_NO,
                            B.CLASS_NAME,
                            COUNT(A.STUDENT_NO),
                            DENSE_RANK()
                            OVER(
                                ORDER BY
                                    COUNT(A.STUDENT_NO) DESC
                            ) RANKCNT
                        FROM
                            TB_GRADE A
                            LEFT JOIN TB_CLASS B ON A.CLASS_NO = B.CLASS_NO
                        WHERE
                                1 = 1
                            AND SUBSTR(A.TERM_NO, 1, 4) IN (
                                SELECT
                                    SUBSTR(V.TERM_NO, 1, 4)
                                FROM
                                    (
                                        SELECT
                                            SUBSTR(A.TERM_NO, 1, 4) TERM_NO
                                        FROM
                                            TB_GRADE A
                                            LEFT JOIN TB_CLASS B ON A.CLASS_NO = B.CLASS_NO
                                        WHERE
                                            1 = 1
                                        GROUP BY
                                            SUBSTR(A.TERM_NO, 1, 4)
                                        ORDER BY
                                            1 DESC
                                    ) V
                                WHERE
                                        1 = 1
                                    AND ROWNUM <= 3
                            )
                        GROUP BY
                            A.CLASS_NO,
                            B.CLASS_NAME
                    ) A
                WHERE
                        1 = 1
                    AND RANKCNT <= 3
            ) B ON A.CLASS_NO = B.CLASS_NO
        GROUP BY
            A.CLASS_NO,
            B.CLASS_NAME
        ORDER BY
            3 DESC
    ) A
WHERE
        1 = 1
    AND ROWNUM <= 3;



----------------------------------------------------------------------------

SELECT
    *
FROM
    (
        SELECT
            SU.CLASS_NO  과목번호,
            C.CLASS_NAME 과목명,
            SU."누적수강인원"
        FROM
            (
                SELECT
                    CLASS_NO,
                    SUM(수강인원) AS "누적수강인원"
                FROM
                    (
                        SELECT
                            TERM_NO,
                            CLASS_NO,
                            COUNT(*) AS "수강인원"
                        FROM
                            TB_GRADE GR
                        GROUP BY
                            TERM_NO,
                            CLASS_NO
                        ORDER BY
                            수강인원 DESC
                    )
                GROUP BY
                    CLASS_NO
            )        SU
            LEFT OUTER JOIN TB_CLASS C ON ( SU.CLASS_NO = C.CLASS_NO )
        ORDER BY
            누적수강인원 DESC
    )
WHERE
    ROWNUM <= 3;
    
--------------------------------------------------------------------------------    
-- 같은 학생이 동일한 CLASS를 들어도 COUNT가 늘어났을 경우?

SELECT
    G.CLASS_NO,
    COUNT(*)
FROM
         TB_GRADE G
    JOIN TB_STUDENT S USING ( STUDENT_NO )
GROUP BY
    G.CLASS_NO
ORDER BY
    COUNT(*) DESC;
    
----------------------------------------------------------------------------------    
    
    