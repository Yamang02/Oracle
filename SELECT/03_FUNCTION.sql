/*
    <문자 처리 함수>
    
    1) LENGTH / LENGTHB
        LENGTH(컬럼 | '문자값') : 글자 수 반환
        LENGTHB(컬럼 | '문자값') : 글자의 바이트 수 반환
        
        한글 한 글자는 3BYTE
        영문자, 숫자, 특수문자 한 글자는 1BYTE
*/

SELECT
    LENGTH('오라클'),
    LENGTHB('오라클')
FROM
    DUAL;

SELECT
    EMP_NAME,
    LENGTH(EMP_NAME),
    LENGTHB(EMP_NAME),
    EMAIL,
    LENGTH(EMAIL),
    LENGTHB(EMAIL)
FROM
    EMPLOYEE;
    
/*
    <INSTR>
    INSTR('문자값', '문자값' [, POSITION, OCCURRENCE]);
    첫번째 문자 데이터에서 두 번째 문자 데이터를 찾아 첫 문자의 순서를 알려줌
    
    POSITION : 찾을 위치의 시작 값(기본 값 1)
    OCCURRENCE : 찾을 문자값이 반복될 때 지칭하는 빈도(기본 값 1), 음수 사용불가 없으면 0
    
*/
SELECT
    INSTR('AABAACAABBAA', 'B')
FROM
    DUAL;
    
    
-- 포지션 값
SELECT
    INSTR('AABAACAABBAA', 'B', 1) -- 왼쪽에서 오른쪽으로 검색
FROM
    DUAL;

SELECT
    INSTR('AABAACAABBAA', 'B', - 1) -- 오른쪽에서 왼쪽으로 검색
FROM
    DUAL;

-- OCCURRENCE 값
SELECT
    INSTR('AABAACAABBAA', 'B', 1, 2) -- 왼쪽에서 오른쪽으로 검색, 두 번째로 등장하는 B값 알려줌
FROM
    DUAL;

/*
SELECT
    INSTR('AABAACAABBAA', 'B', 1, -1)  -- 음수는 사용할 수 없음
FROM
    DUAL;
*/

SELECT
    INSTR('AABAACAABBAA', 'B', - 1, 3) -- 오른쪽에서 왼쪽으로 검색, 3번째 'B'의 위치
FROM
    DUAL;

SELECT
    EMAIL,
    INSTR(EMAIL, '@')       AS "@ 위치",
    INSTR(EMAIL, 's', 1, 2) AS "두 번째 s"
FROM
    EMPLOYEE;
    
/*
    3) LPAD / RPAD
        LPAD / RPAD ('문자값', 길이 [, '문자값'])
        
*/

SELECT
    LPAD('HELLO', 10)
FROM
    DUAL; -- 10 만큼의 길이 중 오른쪽에 HELLO값을 입력하고, 왼쪽에 공백을 채운다.
SELECT
    LPAD('HELLO', 10, 'A')
FROM
    DUAL; --2번째 주는 문자열로 공백을 채운다.(2자 이상도 가능)
SELECT
    RPAD('HELLO', 10)
FROM
    DUAL; -- 10 만큼의 길이 중 왼쪽에 HELLO값을 입력하고, 오른쪽에 공백을 채운다.
SELECT
    RPAD('HELLO', 10, 'A')
FROM
    DUAL; --2번째 주는 문자열로 공백을 채운다.(2자 이상도 가능)

--- EMAIL 정렬하기
SELECT
    LPAD(EMAIL, 20)
FROM
    EMPLOYEE;
    
-- 주민등록번호 마스킹해서 출력하기

SELECT
    RPAD('991213-1', 14, '*')
FROM
    DUAL;

/*
    4) LTRIM / RTRIM 공백제거
        LTRIM / RTRIM ('문자값' [, '문자값'])

*/
-- 제거하고자 하는 문자 생략 시 기본값으로 공백을 제거한다.
SELECT
    '   ',
    LTRIM('    KH     ') -- 왼쪽의 공백을 제거(오른쪽은 남아 있음)
FROM
    DUAL;

SELECT
    LTRIM('000123456', '0') -- 해당하는 문자값 나오지 않을 때까지 지우는 것을 반복함 
FROM
    DUAL;

SELECT
    LTRIM('000123456', '021') --3456 문자 하나 하나 지울 수 있는 것이 없을 때까지 반복함
FROM
    DUAL;

SELECT
    LTRIM('123123KH123', '123') -- KH123 문자 하나 하나 지울 수 있는 것이 없을 때까지 반복함 (오른쪽은 남음)
FROM
    DUAL;

SELECT
    RTRIM('KH    ')
FROM
    DUAL;

SELECT
    RTRIM('    KH    ')
FROM
    DUAL;

SELECT
    RTRIM('000123000456000', '0')
FROM
    DUAL;    
    
-- 양쪽 문자 제거 (함수 중첩)
SELECT
    LTRIM(RTRIM('000123000456000', '0'),
          '0')
FROM
    DUAL;

/*
    5) TRIM
        TRIM('문자값') 문자 앞 뒤 공백 제거
        TRIM('[LEADING(앞) | TRAILIG(뒤) | BOTH(양쪽)] '문자값' FROM] '문자값'')
*/

SELECT
    TRIM('    KH    ')
FROM
    DUAL;

SELECT
    TRIM(' ' FROM '    KH    ')
FROM
    DUAL;

SELECT
    TRIM(BOTH ' ' FROM '    KH    ')
FROM
    DUAL;
-- 위 3개는 같음

SELECT
    TRIM(BOTH 'Z' FROM 'ZZZKHZZZ')
FROM
    DUAL;

SELECT
    TRIM(LEADING 'Z' FROM 'ZZZKHZZZ')
FROM
    DUAL;

SELECT
    TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ')
FROM
    DUAL;

/*
< SUBSTR > ('문자값', POSITION, [,LENGHT])

*/
SELECT
    SUBSTR('SHOWMETHEMONEY', 7)
FROM
    DUAL;

SELECT
    SUBSTR('SHOWMETHEMONEY', 7, 5)
FROM
    DUAL;

SELECT
    SUBSTR('SHOWMETHEMONEY', 1, 6) -- SHOWME
FROM
    DUAL;

SELECT
    SUBSTR('SHOWMETHEMONEY)', - 8, 3)
FROM
    DUAL;

SELECT
    SUBSTR('쇼우 미 더 머니', 2, 5) -- 공백을 포함함
FROM
    DUAL;
    
 -- EMPLOYE 테이블에서 주민번호에 성별을 나타내는 부분만 잘라서 조회
--    SUBSTR('문자열', 인덱스, 인덱스로부터)

SELECT
    EMP_NAME             AS "직원명",
    SUBSTR(EMP_NO, 8, 1) AS "성별코드"
FROM
    EMPLOYEE;
    
-- EMPLOY 테이블에서 여자 사원의 직원명, 성별코드를 조회    
SELECT
    EMP_NAME             AS "직원명",
    SUBSTR(EMP_NO, 8, 1) AS "성별코드"
FROM
    EMPLOYEE
WHERE
    SUBSTR(EMP_NO, 8, 1) = 2;
    
-- EMPLOY 테이블에서 남자 사원의 직원명, 성별(남) 조회   
SELECT
    EMP_NAME AS "직원명",
--    SUBSTR(EMP_NO, 8, 1) AS "성별코드",
    '남'      AS "성별"
FROM
    EMPLOYEE
WHERE
    NOT SUBSTR(EMP_NO, 8, 1) = 2;
    
-- EMPLOYEE 테이블에서 주민등록번호 첫 번째 자리부터 성별까지 추출한 결과값에 오른쪽에 *문자를 채워서 14글자 반환
SELECT
    EMP_NAME  AS 이름,
    RPAD(SUBSTR(EMP_NO, 1, 8),
         14,
         '*') AS "주민등록번호"
FROM
    EMPLOYEE;

SELECT
    SUBSTR('991213-122222', 1, 8)
FROM
    DUAL;

-- EMPLOYEE 테이블에서 직원명, 이메일, 아이디(이메일에서 '@' 앞의 문자값만 출력)    
SELECT
    EMP_NAME                      직원명,
    EMAIL                         이메일,
    SUBSTR(EMAIL,
           1,
           INSTR(EMAIL, '@') - 1) AS "아이디"
FROM
    EMPLOYEE;
/*
SELECT
    EMP_NAME 직원명,
    EMAIL    이메일,
    RTRIM(EMAIL, '@kh.or.kr') -- 안됨ㅠㅠ
FROM
    EMPLOYEE;
*/
SELECT
    EMP_NAME 직원명,
    EMAIL    이메일,
    REPLACE(EMAIL, '@kh.or.kr', '')
FROM
    EMPLOYEE;

SELECT
    EMP_NAME 직원명,
    EMAIL    이메일,
    RPAD(EMAIL,
         INSTR(EMAIL, '@') - 1)
FROM
    EMPLOYEE;

SELECT
    EMP_NAME                  직원명,
    EMAIL                     이메일,
    SUBSTR(EMAIL,
           1,
           LENGTH(EMAIL) - 9) AS "아이디"
FROM
    EMPLOYEE;      
 
/*
    7) LOWER / UPPER / INITCAP
        LOWER/UPPER/INITCAP('문자값')
*/

SELECT
    'welcome to my world' AS "message"
FROM
    DUAL;

SELECT
    UPPER('welcome to my world')
FROM
    DUAL;

SELECT
    LOWER('WELCOME TO MY WORLD')
FROM
    DUAL;

SELECT
    INITCAP('welcome to my world')
FROM
    DUAL;

/*
    8) CONCAT('문자값', '문자값')
*/

SELECT -- CONCAT은 2개의 문자열만 받을 수 있음
    CONCAT('가나다라', 'ABCD')
FROM
    DUAL;

SELECT -- 연결 연산자는 2개 이상도 가능함
    '가나다라'
    || 'ABCD'
    || '1234'
FROM
    DUAL;

SELECT -- CONCAT은 2개의 문자열만 받을 수 있음
    CONCAT('가나다라',
           CONCAT('ABCD', '1234'))
FROM
    DUAL;

SELECT
    CONCAT(EMP_ID, EMP_NAME)
FROM
    EMPLOYEE;
    
/*
    9) REPLACE
        REPLACE('대상 문자값', '찾을 문자값', '변경할 문자값')
*/

SELECT
    REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동')
FROM
    DUAL;

-- EMPLOYEE 태이블에서 이메일의 kh.or.kr을 gmail.com으로 변경해서 조회

SELECT
    EMP_NAME 직원명,
    EMAIL    이메일,
    REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
FROM
    EMPLOYEE;
    
/*
    <숫자 처리 함수>
    1) ABS
        ABS(NUMBER)
*/

SELECT
    ABS(10.9)
FROM
    DUAL;

SELECT
    ABS(- 10.9)
FROM
    DUAL;
    
    
/*
     2) MOD
*/

SELECT
    MOD(10, 4)
FROM
    DUAL;

SELECT
    10 + 3,
    10 - 3,
    10 * 3,
    10 / 3,
    MOD(10, 3)
FROM
    DUAL;
    
/*
    3) ROUND
       ROUND(NUMBER, [, POSITION])

    // 기본값은 소수점(0)을 기준으로 반올림
*/

SELECT
    ROUND(123.456)
FROM
    DUAL;

SELECT
    ROUND(123.456, 0)
FROM
    DUAL;

SELECT
    ROUND(123.456, 1)
FROM
    DUAL;

SELECT
    ROUND(123.456, 2)
FROM
    DUAL;

SELECT
    ROUND(123.456, 4)
FROM
    DUAL;

SELECT
    ROUND(123.456, - 1)
FROM
    DUAL;

SELECT
    ROUND(123.456, - 3)
FROM
    DUAL;

/*
    4) CEIL
        CEIL(NUMBER) 소수점 기준으로 올림

*/

SELECT
    CEIL(123.456)
FROM
    DUAL;

SELECT
    CEIL(123.456)
FROM
    DUAL; --포지션값 지정 불가
    
/*
    5) FLOOR 
        FLOOR(NUMBER) 소수점을 기준으로 버림
*/

SELECT
    FLOOR(123.456)
FROM
    DUAL; --포지션값 지정 불가

SELECT
    FLOOR(456.489)
FROM
    DUAL; --포지션값 지정 불가

/*
    6) TRUNC
        TRUNC[,POSTOIN]
*/

SELECT
    TRUNC(123.456)
FROM
    DUAL;

SELECT
    TRUNC(456.789)
FROM
    DUAL;

SELECT
    TRUNC(456.789, 0)
FROM
    DUAL;

SELECT
    TRUNC(456.789, - 1)
FROM
    DUAL;

SELECT
    TRUNC(456.789, 1)
FROM
    DUAL;
    
/*
    <날짜처리 함수>
    1) SYSDATE
    
*/

SELECT
    SYSDATE
FROM
    DUAL;
    
-- 날짜 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD'; --기본
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';    

/*
    2) MONTHS_BETWEEN
*/

SELECT
    FLOOR(MONTHS_BETWEEN(SYSDATE, '20220525')) AS "달 차이"
FROM
    DUAL;    

-- EMPLOYEE 테이블에서 직원명, 입사일, 근무 개월 수 조회

SELECT
    EMP_NAME                                  AS "직원명",
    HIRE_DATE                                 AS "입사일",
    FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS "근무개월수"
FROM
    EMPLOYEE;
    
/*

    3) ADD_MONTHS

*/

SELECT
    ADD_MONTHS(SYSDATE, 6)
FROM
    DUAL;
    
 -- EMPLOYEE 테이블에서 직원명, 입사일, 입사 후 6개월이 된 날짜를 조회

SELECT
    EMP_NAME,
    HIRE_DATE,
    ADD_MONTHS(HIRE_DATE, 6)
FROM
    EMPLOYEE;

/*
    4) NEXT_DAY

*/

SELECT
    SYSDATE,
    NEXT_DAY(SYSDATE, '월요일')
FROM
    DUAL;

SELECT
    SYSDATE,
    NEXT_DAY(SYSDATE, '월')
FROM
    DUAL; 
    
-- 현재 언어정보가 한국어로 설정되어 있어 오류
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

SELECT
    SYSDATE,
    NEXT_DAY(SYSDATE, 'MONDAY')
FROM
    DUAL;

SELECT
    SYSDATE,
    NEXT_DAY(SYSDATE, 'MON')
FROM
    DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- 숫자 데이터로 표현 (1 - 일 ~ 7 - 토)    
SELECT
    SYSDATE,
    NEXT_DAY(SYSDATE, 2)
FROM
    DUAL; 
    
/*
    5) LAST_DAY
    날짜 데이터 해당하는 달의 마지막 날 출력
*/

SELECT
    LAST_DAY(SYSDATE)
FROM
    DUAL;

SELECT
    LAST_DAY('20221114')
FROM
    DUAL;

SELECT
    LAST_DAY('20/02/01')
FROM
    DUAL;

SELECT
    LAST_DAY('20/02/01')
FROM
    DUAL;

-- EMPLOYEE 테이블에서 직원명, 입사일, 입사월의 마지막 날짜 조회
SELECT
    EMP_NAME,
    HIRE_DATE,
    LAST_DAY(HIRE_DATE)
FROM
    EMPLOYEE;
    
/*
    6) EXTRACT
*/

SELECT
    EXTRACT(YEAR FROM SYSDATE),
    EXTRACT(MONTH FROM SYSDATE),
    EXTRACT(DAY FROM SYSDATE)
FROM
    DUAL;
    
-- EMPLOYEE 테이블에서 직원명, 입사년도, 입사월, 입사일 조회

SELECT
    EMP_NAME                      AS 직원명,
    EXTRACT(YEAR FROM HIRE_DATE)  AS 입사년,
    EXTRACT(MONTH FROM HIRE_DATE) AS 입사월,
    EXTRACT(DAY FROM HIRE_DATE)   AS 입사일
FROM
    EMPLOYEE
ORDER BY
--    EXTRACT(YEAR FROM HIRE_DATE) DESC, "입사월";
    2 DESC,
    3,
    4;
    
/*
    <형 변환 함수>
    1) TO_CHAR
    
*/
-- 숫자 > 문자
SELECT
    TO_CHAR(1234)
FROM
    DUAL;

SELECT
    TO_CHAR(1234, '999999') -- 9만큼의 공간을 확보, 오른쪽 정렬, 빈칸은 공백으로
FROM
    DUAL;

SELECT
    TO_CHAR(1234, '000000') -- -- 0만큼의 공간을 확보, 오른쪽 정렬, 빈칸은 0으로
FROM
    DUAL;

SELECT
    TO_CHAR(1234, 'L999999') -- 설정된 나라의 화폐단위
FROM
    DUAL;

SELECT
    TO_CHAR(1234, '$999999')
FROM
    DUAL;

SELECT
    TO_CHAR(3000000, 'L99,999,999')
FROM
    DUAL;
    
-- EMPLOYEE 테이블에서 직원명, 급여, 연봉 조회    

SELECT
    EMP_NAME                                 AS "직원명",
    TO_CHAR(SALARY, 'FM99,999,999L')         AS "급여",
    TO_CHAR(SALARY * 12, 'FM9,999,999,999L') AS "연봉"
FROM
    EMPLOYEE
ORDER BY
    "연봉";
    
-- 날짜 > 문자
SELECT
    SYSDATE
FROM
    DUAL;

SELECT
    TO_CHAR(SYSDATE)
FROM
    DUAL;

SELECT
    TO_CHAR(SYSDATE, 'AM HH:MI:SS')
FROM
    DUAL;

SELECT
    TO_CHAR(SYSDATE, 'AM HH24:MI:SS')
FROM
    DUAL;

SELECT
    TO_CHAR(SYSDATE, 'MON DY, YYYY')
FROM
    DUAL;

SELECT
    TO_CHAR(SYSDATE, 'DAY')
FROM
    DUAL;

SELECT
    TO_CHAR(SYSDATE, 'YYYY MM DD(DY)')
FROM
    DUAL;

-- 연도에 대한 포맷
SELECT
    TO_CHAR(SYSDATE, 'YYYY'),
    TO_CHAR(SYSDATE, 'RRRR'),
    TO_CHAR(SYSDATE, 'YY'),
    TO_CHAR(SYSDATE, 'RR'),
    TO_CHAR(SYSDATE, 'YEAR')
FROM
    DUAL;
    
-- 월에 대한 포맷
SELECT
    TO_CHAR(SYSDATE, 'MM'),
    TO_CHAR(SYSDATE, 'MON'),
    TO_CHAR(SYSDATE, 'MONTH'),
    TO_CHAR(SYSDATE, 'RM')
FROM
    DUAL;

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- 일에 대한 포맷

SELECT
    TO_CHAR(SYSDATE, 'D'), -- 일주일 중 일요일 1을 기준으로 며칠째인지
    TO_CHAR(SYSDATE, 'DD'), -- 한 달을 기준으로
    TO_CHAR(SYSDATE, 'DDD') -- 한 해를 기준으로
FROM
    DUAL;
    
--  요일에 대한 포맷
SELECT
    TO_CHAR(SYSDATE, 'DAY'),
    TO_CHAR(SYSDATE, 'DY')
FROM
    DUAL;
    
-- EMPLOYEE 테이블에서 직원명과 입사일을 조회
-- 단, 입사일은 포맷을 지정해서 조회한다. (2022-12-14(수))
-- 2022년 12월 14일(수)

SELECT
    EMP_NAME,
    TO_CHAR(HIRE_DATE, 'YYYY-MM-DD(DY)')
FROM
    EMPLOYEE;

SELECT
    EMP_NAME,
    TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"(DY)')
FROM
    EMPLOYEE;
    
/*
    2) TO_DATE
    
*/
-- 숫자 타입을 날짜 타입으로 변환
SELECT
    TO_DATE(20221214)
FROM
    DUAL;

SELECT
    TO_DATE(20221214113830)
FROM
    DUAL;

-- 날짜 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD'; --기본
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';

SELECT
    TO_DATE(20221214113830, 'YYYY-MM-DD HH:MI:SS')
FROM
    DUAL;

-- 문자 > 날짜
SELECT
    TO_DATE('20221214114330')
FROM
    DUAL;

SELECT
    TO_DATE('20221214 234330', 'YYYY-MM-DD HH24:MI:SS')
FROM
    DUAL;
    
-- YY 와 RR의 비교 ; YY는 무조건 현재 세기를 반영, RR는 50 미만이면 현재 세기 반영, 50이상이면 이전 세기를 반영

SELECT
    TO_DATE('140630', 'YYMMDD')
FROM
    DUAL;

SELECT
    TO_DATE('980630', 'YYMMDD')
FROM
    DUAL;

SELECT
    TO_DATE('140630', 'YYMMDD')
FROM
    DUAL;

SELECT
    TO_DATE('980630', 'RRMMDD')
FROM
    DUAL;
    
-- EMPLOYEE 테이블에서 1998년 1월 1일 이후에 입사한 사원의 사번, 이름, 입사일 조회
SELECT
    EMP_ID,
    EMP_NAME,
    HIRE_DATE
FROM
    EMPLOYEE
WHERE
--    HIRE_DATE > TO_DATE('980101', 'RRMMDD') 
    HIRE_DATE > '19980101'
ORDER BY
    HIRE_DATE;
    
/*
    3) TO_NUMBER
*/

SELECT
    TO_NUMBER('0123456789')
FROM
    DUAL;

SELECT
    '123' + '456'
FROM
    DUAL;  -- 자동으로 숫자 타입 형 변환 뒤 연산처리함.

SELECT
    '10,000,000' + '500,000' -- ,로 인해 숫자타입으로 변환될 수 없어 오류
FROM
    DUAL;

SELECT
    TO_NUMBER('10,000,000', '999,999,999')
FROM
    DUAL;

SELECT
    TO_NUMBER('500,000', '999,999,999')
FROM
    DUAL;

SELECT
    TO_NUMBER('10,000,000', '999,999,999') + TO_NUMBER('500,000', '999,999,999')
FROM
    DUAL;
    
/*
    <NULL 처리 함수>
    1) NVL

*/

-- EMPLOYEE 테이블에서 직원명, 보너스, 보너스가 포함된 연봉 조회

SELECT
    EMP_NAME                AS "직원명",
    NVL(BONUS, 0)           AS "보너스",
    TO_CHAR((SALARY * 12) *(1 + NVL(BONUS, 0)),
            '999,999,999L') AS "보너스가 포함된 연봉"
FROM
    EMPLOYEE;
    
-- EMPLOYEE 테이블에서 직원명, 부서코드 조회(단, 부서 코드가 NULL이면 '부서없음' 출력)   

SELECT
    EMP_NAME               AS "직원명",
    NVL(DEPT_CODE, '부서없음') AS "부서 코드"
FROM
    EMPLOYEE;
    
/*
 2)NVL2
*/
-- EMPLOYEE 테이블에서 보너스를 0.1로 동결하여 직원명, 보너스, 동결된 보너스, 동결된 보너스가 포함된 연봉 출력

SELECT
    EMP_NAME                AS "직원명",
    NVL(BONUS, 0)           "(원)보너스",
    NVL2(BONUS, 0.1, 0)     "동결된 보너스",
    TO_CHAR((SALARY * 12) *(1 + NVL(BONUS, 0)),
            '999,999,999L') AS "보너스가 포함된 연봉",
    TO_CHAR((SALARY * 12) *(1 + NVL2(BONUS, 0.1, 0)),
            '999,999,999L') AS "동결 보너스 연봉"
FROM
    EMPLOYEE;
    
 /*
    3) NULLIF
 */

SELECT
    NULLIF('123', '123')
FROM
    DUAL;

SELECT
    NULLIF('123', '456')
FROM
    DUAL;

SELECT
    NULLIF(123, 456)
FROM
    DUAL;
    
/*
    <선택 함수>   
    1) DECODE   
*/

-- EMPLOYEE 테이블에서 사번, 직원명, 주민번호, 성별(남자, 여자) 조회

SELECT
    EMP_ID                 AS "사번",
    EMP_NAME               AS "직원명",
    EMP_NO                 AS "주민번호",
    DECODE(SUBSTR(EMP_NO, 8, 1),
           1,
           '남자',
           2,
           '여자',
           '잘못된 주민번호입니다.') AS "성별"
FROM
    EMPLOYEE
ORDER BY
    "성별";
    
-- EMPLOYEE 테이블에서 직원명, 직급 코드, 기존 급여, 인상된 급여를 조회
-- 직급코드 J7인 사원은 급여를 10% 인상, J6는 15%, J5 20%, 그 외 직급의 사원은 급여를 5% 인상

SELECT
    EMP_NAME            AS 직원명,
    JOB_CODE            AS 직급코드,
    SALARY              AS 기존급여,
    SALARY * DECODE(JOB_CODE, 'J7', 1.1, 'J6', 1.15,
                    'J5', 1.2, 1.05) AS "인상된 급여"
FROM
    EMPLOYEE;
    
/*
   2) CASE문
   
*/

-- EMPLOYEE 테이블에서 사번, 직원명, 주민번호, 성별(남자, 여자) 조회

SELECT
    EMP_ID   AS "사번",
    EMP_NAME AS "직원명",
    EMP_NO   AS "주민번호",
    CASE
        WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN
            '남자'
        WHEN SUBSTR(EMP_NO, 8, 1) = 2 THEN
            '여자'
        ELSE
            '잘못된 주민번호입니다.'
    END      AS "성별"
FROM
    EMPLOYEE;
    
    
-- EMPLOYEE 테이블에서 직원명, 급여, 급여 등급(1~4) 조회
-- SALARY 값이 500만원 초과일 경우 1등급, 350~500 2등급, 200만원~350 초과일 경우 3등급, 그 외 4등급

SELECT
    EMP_NAME                       AS "직원명",
    TO_CHAR(SALARY, 'FM9,999,999') AS "급여",
    CASE
        WHEN SALARY > 5000000 THEN
            LPAD('1등급', 8)
        WHEN SALARY > 3500000 THEN
            LPAD('2등급', 8)
        WHEN SALARY > 2000000 THEN
            LPAD('3등급', 8)
--      WHEN SALARY < 2000000 THEN '4등급'
        ELSE
            LPAD('4등급', 8)
    END                            AS "급여등급"
FROM
    EMPLOYEE;
    
    
/*
     <그룹 함수>
    1) SUM
    
*/

-- EMPLOYEE 테이블에서 전 사원의 총 급여의 합계를 조회
SELECT
    TO_CHAR(SUM(SALARY),
            'FM999,999,999,999L') AS "계"
FROM
    EMPLOYEE;

-- EMPLOYEE 테이블에서 남자 사원의 총 급여의 합계 조회

SELECT
    TO_CHAR(SUM(SALARY),
            '999,999,999L') AS "계"
FROM
    EMPLOYEE
WHERE
    SUBSTR(EMP_NO, 8, 1) = 1;


-- EMPLOYEE 테이블에서 여자 사원의 총 급여의 합계 조회

SELECT
    TO_CHAR(SUM(SALARY),
            '999,999,999L') AS "계"
FROM
    EMPLOYEE
WHERE
    NOT SUBSTR(EMP_NO, 8, 1) = 1;
    
    
-- EMPLOYEE 테이블에서 전 사원의 총 연봉의 합계 조회

SELECT
    TO_CHAR(SUM(SALARY * 12),
            'FM999,999,999L') AS "계"
FROM
    EMPLOYEE;

--SELECT
--    SUM(SALARY) * 12
--FROM
--    EMPLOYEE;


-- EMPLOYEE 테이블에서 부서 코드 D5인 사원들의 총 연봉의 합계 조회

SELECT
    TO_CHAR(SUM(SALARY) * 12,
            '999,999,999L') AS 계
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'D5';
    
/*
    2) AVG
*/
    
-- EMPLOYEE 테이블에서 전 사원의 급여 평균 조회
SELECT
    TO_CHAR(ROUND(NVL(AVG(SALARY),
                      0),
                  - 4)) AS 급여평균
FROM
    EMPLOYEE;

SELECT
    ROUND(AVG(BONUS),
          3)
FROM
    EMPLOYEE;

SELECT
    ROUND(AVG(NVL(BONUS, 0)),
          3)
FROM
    EMPLOYEE;
    
/*
    3) MIN / MAX
*/

SELECT
    MIN(EMP_NAME),
    MAX(EMP_NAME),
    MIN(SALARY),
    MAX(SALARY),
    MIN(HIRE_DATE),
    MAX(HIRE_DATE)
FROM
    EMPLOYEE;
    
    
/*
    4) COUNT

*/

-- EMPLOYEE 테이블에서 전체 사원의 수를 조회

SELECT
    COUNT(*)
FROM
    EMPLOYEE;

-- EMPLOYEE 테이블에서 남자 사원의 수를 조회

SELECT
    COUNT(SUBSTR(EMP_NO, 8, 1)) AS 남자_사원의_수
FROM
    EMPLOYEE
WHERE
    SUBSTR(EMP_NO, 8, 1) = 1;

-- EMPLOYEE 테이블에서 여자 사원의 수를 조회 
SELECT
    COUNT(SUBSTR(EMP_NO, 8, 1)) AS 여자_사원의_수
FROM
    EMPLOYEE
WHERE
    NOT SUBSTR(EMP_NO, 8, 1) = 1;
    
-- 보너스를 받는 사원의 수

-- NULL 값을 자동으로 제외
SELECT
    COUNT(BONUS)
FROM
    EMPLOYEE;

SELECT
    COUNT(*)
FROM
    EMPLOYEE
WHERE
    BONUS IS NOT NULL;

 -- EMPLOYEE 테이블에서 퇴사한 직원의 수 

SELECT
    COUNT(*)
FROM
    EMPLOYEE
WHERE
    ENT_YN = 'Y';

SELECT
    COUNT(ENT_DATE)
FROM
    EMPLOYEE;

-- EMPLOYEE 테이블에서 부서가 배치된 사원의 수를 조회

SELECT
    COUNT(DEPT_CODE)
FROM
    EMPLOYEE;

-- EMPLOYEE 테이블에서 현재 사원들이 속해있는 부서의 수를 조회
SELECT
    COUNT(DISTINCT DEPT_CODE)
FROM
    EMPLOYEE;

-- EMPLOYEE 테이블에서 현재 사원들이 분포되어 있는 직급의 수를 조회
SELECT
    COUNT(DISTINCT JOB_CODE)
FROM
    EMPLOYEE;


/*
    2. 반복문
        
    2-1) BASIC LOOP

*/

-- 1 ~ 5까지 순차적으로 1씩 증가하는 값을 출력

DECLARE
    NUM NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
        NUM := NUM + 1;
--        IF NUM > 5 THEN
--            EXIT;
--        END IF;


        EXIT WHEN NUM > 5;
    END LOOP;
END;
/


--  2-2) WHILE LOOP

DECLARE
    NUM NUMBER := 1;
BEGIN
    WHILE NUM <= 5 LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
        NUM := NUM + 1;
    END LOOP;
END;
/

DECLARE
    DAN NUMBER := 2;
    NUM NUMBER := 1;
BEGIN
    WHILE DAN < 9 LOOP
        WHILE NUM < 9 LOOP
            DBMS_OUTPUT.PUT_LINE(DAN);
            NUM := NUM + 1;
        END LOOP;
        DAN := DAN + 1;
    END LOOP;
END;
/