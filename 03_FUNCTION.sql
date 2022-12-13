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