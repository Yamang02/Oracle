/*
 1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른
순으로 표시하는 SQL 문장을 작성하시오.( 단, 헤더는 "학번", "이름", "입학년도" 가
표시되도록 한다.)
*/

SELECT
    STUDENT_NO,
    STUDENT_NAME,
    ENTRANCE_DATE
FROM
    TB_STUDENT
WHERE
    DEPARTMENT_NO = 002
ORDER BY
    ENTRANCE_DATE;
    
/*
 2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다. 그 교수의
이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자. (* 이때 올바르게 작성한 SQL
문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼 것)
*/

SELECT
    PROFESSOR_NAME,
    PROFESSOR_SSN
FROM
    TB_PROFESSOR
WHERE
    NOT PROFESSOR_NAME LIKE '___';
 
/*

3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오. 단
이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오. (단, 교수 중
2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 한다. 나이는 ‘만'으로
계산한다.)

*/

SELECT
    PROFESSOR_NAME                                                      AS 이름,
    EXTRACT(YEAR FROM SYSDATE) - ( 1900 + SUBSTR(PROFESSOR_SSN, 1, 2) ) AS "나이"
FROM
    TB_PROFESSOR
ORDER BY
    "나이";
    
/*
4. 교수들의 이름 중 성을 제외한 이름맊 출력하는 SQL 문장을 작성하시오. 출력 헤더는
‚이름‛ 이 찍히도록 한다. (성이 2 자인 경우는 교수는 없다고 가정하시오)
*/

SELECT
    SUBSTR(PROFESSOR_NAME,
           2,
           LENGTH(PROFESSOR_NAME))
FROM
    TB_PROFESSOR;

/*
5. 춘 기술대학교의 재수생 입학자를 구하려고 핚다. 어떻게 찾아낼 것인가? 이때,
19 살에 입학하면 재수를 하지 않은 것으로 갂주핚다.
*/

SELECT
    TO_DATE(SUBSTR(STUDENT_SSN, 1, 2),
            'RR')
FROM
    TB_STUDENT;

SELECT
    STUDENT_NO,
    STUDENT_NAME
FROM
    TB_STUDENT
WHERE
    EXTRACT(YEAR FROM(TO_DATE(SUBSTR(ENTRANCE_DATE, 1, 2),
        'RR'))) - EXTRACT(YEAR FROM(TO_DATE(SUBSTR(STUDENT_SSN, 1, 2),
        'RR'))) + 1 > 20;
        
/*
6. 2020 년 크리스마스는 무슨 요일인가?
*/

SELECT
    TO_CHAR(TO_DATE('201225', 'YYMMDD'), 'DAY')
FROM
    DUAL;

/*
7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') 은 각각 몇 년 몇
월 몇 일을 의미핛까? 또 TO_DATE('99/10/11','RR/MM/DD'),
TO_DATE('49/10/11','RR/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미핛까?
*/

SELECT
    EXTRACT(YEAR FROM TO_DATE('99/10/11', 'YY/MM/DD')) AS "1",
    EXTRACT(YEAR FROM TO_DATE('49/10/11', 'YY/MM/DD')) AS "2",
    EXTRACT(YEAR FROM TO_DATE('99/10/11', 'RR/MM/DD')) AS "3",
    EXTRACT(YEAR FROM TO_DATE('49/10/11', 'RR/MM/DD')) AS "4"
FROM
    DUAL;
    
/*
8. 춘 기술대학교의 2000 년도 이후 입학자들은 학번이 A 로 시작하게 되어있다. 2000 년도
이젂 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.
*/

SELECT
    STUDENT_NO,
    STUDENT_NAME
FROM
    TB_STUDENT
WHERE
    NOT SUBSTR(STUDENT_NO, 1, 1) = 'A';
    
/*
9. 학번이 A517178 인 핚아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오. 단,
이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 핚
자리까지맊 표시핚다.
*/

SELECT
    ROUND(AVG(POINT),
          1) AS "평점"
FROM
    TB_GRADE
WHERE
    STUDENT_NO = 'A517178';
    
/*
10. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 맊들어 결과값이
출력되도록 하시오.
*/

SELECT
    DEPARTMENT_NO AS "학과번호",
    COUNT(*)      AS "학생수(명)"
FROM
    TB_STUDENT
GROUP BY
    DEPARTMENT_NO
ORDER BY
    DEPARTMENT_NO;
    
/*
11. 지도 교수를 배정받지 못핚 학생의 수는 몇 명 정도 되는 알아내는 SQL 문을
작성하시오.
*/

SELECT
    COUNT(NVL(COACH_PROFESSOR_NO, '미배치'))
FROM
    TB_STUDENT
GROUP BY
    COACH_PROFESSOR_NO
HAVING
    COACH_PROFESSOR_NO IS NULL
ORDER BY
    COACH_PROFESSOR_NO;

/*
12. 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오. 단, 
이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여
소수점 이하 핚 자리까지맊 표시핚다.

*/

SELECT
    SUBSTR(TERM_NO, 1, 4) AS "년도",
    ROUND(AVG(POINT),
          1)              AS "년도별 평점"
FROM
    TB_GRADE
WHERE
    STUDENT_NO = 'A112113'
GROUP BY
    SUBSTR(TERM_NO, 1, 4)
ORDER BY
    SUBSTR(TERM_NO, 1, 4);
    
/*
13. 학과 별 휴학생 수를 파악하고자 핚다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을
작성하시오. (답 잘못된 듯?)
*/

SELECT
    DEPARTMENT_NO                           학과코드명,
    COUNT(DECODE(ABSENCE_YN, 'Y', 1, NULL)) "휴학생 수"
FROM
    TB_STUDENT
GROUP BY
    DEPARTMENT_NO
ORDER BY
    1;
    
/*
14. 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 핚다. 어떤 SQL 
문장을 사용하면 가능하겠는가?
*/

SELECT
    STUDENT_NAME 동일이름,
    COUNT(*)     "동명인 수"
FROM
    TB_STUDENT
GROUP BY
    STUDENT_NAME
HAVING
    COUNT(*) > 1
ORDER BY
    STUDENT_NAME;
    
/*
15. 학번이 A112113 인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점 , 총
평점을 구하는 SQL 문을 작성하시오. (단, 평점은 소수점 1 자리까지맊 반올림하여
표시핚다.)
*/

-- 내 답안
SELECT
    NVL(SUBSTR(TERM_NO, 1, 4),
        ' ') 년도,
    NVL(SUBSTR(TERM_NO, 5, 2),
        ' ') 학기,
    ROUND(AVG(POINT),
          1) 평점
FROM
    TB_GRADE
WHERE
    STUDENT_NO = 'A112113'
GROUP BY
    CUBE(SUBSTR(TERM_NO, 1, 4),
         SUBSTR(TERM_NO, 5, 2))
HAVING ( SUBSTR(TERM_NO, 1, 4) IS NULL
         AND SUBSTR(TERM_NO, 5, 2) IS NULL )
       OR SUBSTR(TERM_NO, 1, 4) IS NOT NULL
ORDER BY
    SUBSTR(TERM_NO, 1, 4),
    SUBSTR(TERM_NO, 5, 2);
    
-- 답안
SELECT
    SUBSTR(TERM_NO, 1, 4) AS 년도,
    SUBSTR(TERM_NO, 5, 2) AS 학기,
    ROUND(AVG(POINT),
          1)              AS 평점
FROM
    TB_GRADE
WHERE
    STUDENT_NO = 'A112113'
GROUP BY
    ROLLUP(SUBSTR(TERM_NO, 1, 4),
           SUBSTR(TERM_NO, 5, 2))
ORDER BY
    SUBSTR(TERM_NO, 1, 4);