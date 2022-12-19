/*1. 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고,
정렬은 이름으로 오름차순 표시하도록 핚다.*/

SELECT
    STUDENT_NAME    학생이름,
    STUDENT_ADDRESS 주소지
FROM
    TB_STUDENT
ORDER BY
    STUDENT_NAME;

/*
2. 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
*/

SELECT
    STUDENT_NAME,
    STUDENT_SSN
FROM
    TB_STUDENT
WHERE
    ABSENCE_YN = 'Y'
ORDER BY
    STUDENT_SSN DESC;


/*
3. 주소지가 강원도나 경기도인 학생들 중 1900 년대 학번을 가진 학생들의 이름과 학번, 
주소를 이름의 오름차순으로 화면에 출력하시오. 단, 출력헤더에는 "학생이름","학번",
"거주지 주소" 가 출력되도록 핚다.
*/

SELECT
    STUDENT_NAME    학생이름,
    STUDENT_NO      학번,
    STUDENT_ADDRESS "거주지 주소"
FROM
    TB_STUDENT
WHERE
        SUBSTR(ENTRANCE_DATE, 1, 2) >= 90
    AND SUBSTR(STUDENT_ADDRESS, 1, 2) IN ( '강원', '경기' )
ORDER BY
    STUDENT_NAME;

/*
4. 현재 법학과 교수 중 가장 나이가 맋은 사람부터 이름을 확인핛 수 있는 SQL 문장을
작성하시오. (법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아
내도록 하자
*/

SELECT
    DE.DEPARTMENT_NAME,
    PR.PROFESSOR_NAME,
    SUBSTR(PR.PROFESSOR_SSN, 1, 6)
FROM
    TB_PROFESSOR  PR,
    TB_DEPARTMENT DE
WHERE
        PR.DEPARTMENT_NO = DE.DEPARTMENT_NO
    AND DE.DEPARTMENT_NAME = '법학과'
ORDER BY
    PR.PROFESSOR_SSN;


/*
5. 2004 년 2 학기에 'C3118100' 과목을 수강핚 학생들의 학점을 조회하려고 핚다. 학점이
높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을
작성해보시오.
*/

SELECT
    *
FROM
    TB_GRADE GR
    LEFT JOIN TB_CLASS CL ON ( GR.CLASS_NO = CL.CLASS_NO )
WHERE
        CL.CLASS_NO = 'C3118100'
    AND TERM_NO = 200402
ORDER BY
    GR.POINT DESC,
    GR.STUDENT_NO DESC;

/*

6. 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL 
문을 작성하시오.

*/

SELECT
    S.STUDENT_NO,
    S.STUDENT_NAME,
    D.DEPARTMENT_NAME
FROM
    TB_STUDENT    S
    LEFT OUTER JOIN TB_DEPARTMENT D ON ( S.DEPARTMENT_NO = D.DEPARTMENT_NO )
ORDER BY
    S.STUDENT_NAME;

/*
7. 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL 문장을 작성하시오
*/

SELECT
    CLASS_NAME,
    DEPARTMENT_NO
FROM
    TB_CLASS;

/*
8. 과목별 교수 이름을 찾으려고 핚다. 과목 이름과 교수 이름을 출력하는 SQL 문을
작성하시오.
*/

SELECT
    C.CLASS_NAME,
    P.PROFESSOR_NAME
FROM
    TB_CLASS_PROFESSOR CP,
    TB_CLASS           C,
    TB_PROFESSOR       P
WHERE
        CP.CLASS_NO = C.CLASS_NO
    AND CP.PROFESSOR_NO = P.PROFESSOR_NO;


/*

9. 8 번의 결과 중 ‘인문사회’ 계열에 속핚 과목의 교수 이름을 찾으려고 핚다. 이에
해당하는 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.

*/

SELECT
    C.CLASS_NAME,
    P.PROFESSOR_NAME
FROM
    TB_CLASS_PROFESSOR CP,
    TB_CLASS           C,
    TB_PROFESSOR       P,
    TB_DEPARTMENT      D
WHERE
        CP.CLASS_NO = C.CLASS_NO
    AND CP.PROFESSOR_NO = P.PROFESSOR_NO
    AND P.DEPARTMENT_NO = D.DEPARTMENT_NO
    AND D.CATEGORY = '인문사회';

/*
10. ‘음악학과’ 학생들의 평점을 구하려고 핚다. 음악학과 학생들의 "학번", "학생 이름", 
"젂체 평점"을 출력하는 SQL 문장을 작성하시오. (단, 평점은 소수점 1 자리까지맊
반올림하여 표시핚다.)
*/

SELECT
    S.STUDENT_NO,
    S.STUDENT_NAME,
    ROUND(AVG(NVL(POINT, 0)),
          1)
FROM
    TB_STUDENT    S,
    TB_DEPARTMENT D,
    TB_GRADE      G
WHERE
        S.STUDENT_NO = G.STUDENT_NO
    AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
    AND D.DEPARTMENT_NAME LIKE '음악학과'
GROUP BY
    S.STUDENT_NO,
    S.STUDENT_NAME
ORDER BY
    S.STUDENT_NO;
    

/*

11. 학번이 A313047 인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 젂달하기
위핚 학과 이름, 학생 이름과 지도 교수 이름이 필요하다. 이때 사용핛 SQL 문을
작성하시오. 단, 출력헤더는 ‚학과이름‛, ‚학생이름‛, ‚지도교수이름‛으로
출력되도록 핚다

*/

SELECT
    D.DEPARTMENT_NAME 학과이름,
    S.STUDENT_NAME    학생이름,
    P.PROFESSOR_NAME  지도교수명
FROM
    TB_STUDENT    S,
    TB_DEPARTMENT D,
    TB_PROFESSOR  P
WHERE
        S.DEPARTMENT_NO = D.DEPARTMENT_NO
    AND S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
    AND S.STUDENT_NO = 'A313047';

/*

12. 2007 년도에 '인갂관계롞' 과목을 수강핚 학생을 찾아 학생이름과 수강학기름 표시하는
SQL 문장을 작성하시오.

*/

SELECT *
FROM TB_STUDENT S
LEFT OUTER JOIN TB_GRADE G ON (S.STUDENT_NO = G.STUDENT_NO)
LEFT OUTER JOIN TB_CLASS C ON ()
;



/*

13. 예체능 계열 과목 중 과목 담당교수를 핚 명도 배정받지 못핚 과목을 찾아 그 과목
이름과 학과 이름을 출력하는 SQL 문장을 작성하시오. 14.춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 핚다.학생이름과 지도교수 이름을 찾고 맊일 지도 교수가 없는 학생일 경우 "지도교수 미지정‛으로
표시하도록 하는 SQL 문을 작성하시오. 단, 출력헤더는 ‚학생이름‛, ‚지도교수‛로
표시하며 고학번 학생이 먼저 표시되도록 핚다

15. 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과
이름, 평점을 출력하는 SQL 문을 작성하시오.

16. 홖경조경학과 젂공과목들의 과목 별 평점을 파악핛 수 있는 SQL 문을 작성하시오.

17. 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는
SQL 문을 작성하시오.

18. 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL 문을
작성하시오.

19. 춘 기술대학교의 " 홖경조경학과 "가 속핚 같은 계열 학과들의 학과 별 젂공과목 평점을
파악하기 위핚 적젃핚 SQL 문을 찾아내시오. 단, 출력헤더는 " 계열 학과명 ", 
" 젂공평점 "으로 표시되도록 하고, 평점은 소수점 핚 자리까지맊 반올림하여 표시되도록
핚다.

*/