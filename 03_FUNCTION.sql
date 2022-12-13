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

SELECT RPAD('991213-1',14,'*')
FROM DUAL;
    
    
    