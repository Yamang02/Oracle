/*
    
    < PL / SQL >
    
        PL/SQL은 오라클에서 제공하는 절차적인 프로그래밍 언어이다.
        SQL 문의 반복적인 실행이나 조건에 따른 분기 등 다양한 기능을 제공한다.
        PL/SQL은 선언부(DECLARE SECTION), 실행부(EXECUTABLE SECTION), 예외 처리부(EXCEPTION SECTION)로 구성된다.
    
    
*/

-- HELLO ORACLE 출력
-- 출력기능 활성화
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE!');
END;
/

/*
    1. 선언부
        변수 및 상수를 선언하는 영역. (선언과 동시에 초기화도 가능하다)
        변수 및 상수는 일반 타입 변수, 레퍼런스 타입 변수, ROW 타입 변수로 선언해서 사용할 수 있다.
        
    1) 일반 타입 변수 선언 및 초기화
    

*/

DECLARE
    EID   NUMBER;
    ENAME VARCHAR2(15) := '문인수';
    PI    CONSTRANT NUMBER := 3.14; -- 상수는 선언과 동시에 초기화만 가능하다.

BEGIN
    EID := 300;
    ENAME := '공유';
--  PI := 3.15;


    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
END;
/

-- 1) 레퍼런스 타입 변수 선언 및 초기화

-- 노옹철 사원의 사번, 직원명, 급여 정보를 조회해서 출력
DECLARE
    EID   EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL   EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT
        EMP_ID,
        EMP_NAME,
        SALARY
    INTO
        EID,
        ENAME,
        SAL
    FROM
        EMPLOYEE
    WHERE
        EMP_NAME = '&직원명';

    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/

-- 레퍼런스 타입의 변수로 EID, ENAME, JCODE, DTITLE, SAL를 선언하고
-- 각 변수의 자료형은 EMPLOYEE 테이블의 EMP_ID, EMP_NAME, JOB_CODE, SALARY 컬럼과 DEPARTMENT 테이블의 DEPT_TITLE 컬럼의 자료형을 참조한다.
-- 사용자가 입력한 사번과 일치하는 사원을 조회한 후 조회 결과를 각 변수에 대입 후 출력한다.

SELECT
    E.EMP_ID,
    E.EMP_NAME,
    E.JOB_CODE,
    E.SALARY,
    D.DEPT_TITLE
FROM
         EMPLOYEE E
    INNER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID );

DECLARE
    EID    EMPLOYEE.EMP_ID%TYPE;
    ENAME  EMPLOYEE.EMP_NAME%TYPE;
    JCODE  EMPLOYEE.JOB_CODE%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    SAL    EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT
        E.EMP_ID,
        E.EMP_NAME,
        E.JOB_CODE,
        D.DEPT_TITLE,
        E.SALARY
    INTO
        EID,
        ENAME,
        JCODE,
        DTITLE,
        SAL
    FROM
             EMPLOYEE E
        INNER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID )
    WHERE
        E.EMP_ID = 200;

    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('직급 : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SAL);
END;
/

-- 3) ROW타입 변수 선언 및 초기화

DECLARE
    EMP EMPLOYEE%ROWTYPE;
BEGIN
    SELECT
        *
    INTO EMP
    FROM
        EMPLOYEE
    WHERE
        EMP_NAME = '&직원명';

    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('주민등록번호 : ' || EMP.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('이메일 : ' || EMP.EMAIL);
    DBMS_OUTPUT.PUT_LINE('급여 : '
                         || TO_CHAR(EMP.SALARY, 'FM99,999,999L'));
    DBMS_OUTPUT.PUT_LINE('입사일 : '
                         || TO_CHAR(EMP.HIRE_DATE, 'YYYY"년" MM"월" DD"일"'));
END;
/


/*

    2. 실행부
        제어문, 반복문, 쿼리문 등의 로직을 기술하는 영역이다. 
        
    1) 선택문
        1-1) IF 구문

*/
--    사번을 입력받은 후 해당 사원의 사번, 이름, 급여, 보너스를 출력
--    단, 보너스를 받지 않는 사원은 보너스 출력 전에 '보너스를 지급받지 않는 사원입니다.'라는 문구 출력

CREATE SYNONYM EM FOR EMPLOYEE;

SELECT
    EMP_ID,
    EMP_NAME,
    SALARY,
    BONUS
FROM
    EM
WHERE
    EMP_ID = 200;

DECLARE
    EID   EM.EMP_ID%TYPE;
    ENAME EM.EMP_NAME%TYPE;
    SAL   EM.SALARY%TYPE;
    BONUS EM.BONUS%TYPE;
BEGIN
    SELECT
        EMP_ID,
        EMP_NAME,
        SALARY,
        NVL(BONUS, 0)
    INTO
        EID,
        ENAME,
        SAL,
        BONUS
    FROM
        EM
    WHERE
        EMP_ID = '&사번';

    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SAL);
    IF ( BONUS = 0 ) THEN
        DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('보너스 : ' || BONUS);
END;
/

/*
    1-2) IF - ELSE 구문
*/

SELECT
    EMP_ID,
    EMP_NAME,
    SALARY,
    BONUS
FROM
    EM
WHERE
    EMP_ID = 200;

DECLARE
    EID   EM.EMP_ID%TYPE;
    ENAME EM.EMP_NAME%TYPE;
    SAL   EM.SALARY%TYPE;
    BONUS EM.BONUS%TYPE;
BEGIN
    SELECT
        EMP_ID,
        EMP_NAME,
        SALARY,
        NVL(BONUS, 0)
    INTO
        EID,
        ENAME,
        SAL,
        BONUS
    FROM
        EM
    WHERE
        EMP_ID = '&사번';

    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SAL);
    IF ( BONUS = 0 ) THEN
        DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('보너스 : ' || TO_CHAR(BONUS, 'FM9990.9999'));
    END IF;

END;
/


--  1-3) IF - ELSIF ~ ELSE 구문
-- 사용자에게 점수를 입력받아 SCORE 변수에 저장한 후 학점은 입력된 점수에 따라 GRADE 변수에 저장한다.
-- 90점 이상은 A 80 70 60 미만은 F
-- 출력은 '당신의 점수는 95점이고, 학점은 A학점입니다.'와 같이 출력한다.


DECLARE
    SCORE NUMBER;
    GRADE CHAR(1);
BEGIN
    SCORE := '&점수';
    IF ( SCORE >= 90 ) THEN
        GRADE := 'A';
    ELSIF ( SCORE >= 80 ) THEN
        GRADE := 'B';
    ELSIF ( SCORE >= 70 ) THEN
        GRADE := 'C';
    ELSIF ( SCORE >= 60 ) THEN
        GRADE := 'D';
    ELSE
        GRADE := 'F';
    END IF;

    DBMS_OUTPUT.PUT_LINE('당신의 점수는 : '
                         || SCORE
                         || '점이고, 학점은'
                         || GRADE
                         || '입니다.');

END;
/


-- 사용자에게 입력받은 사번과 일치하는 사원의 급여 조회 후 출력한다. (조회한 급여는 SAL 변수에 대입)


SELECT
    SALARY
FROM
    EM;

DECLARE
    SAL   EM.SALARY%TYPE;
    GRADE VARCHAR2(6);
BEGIN
    SELECT
        SALARY
    INTO SAL
    FROM
        EM
    WHERE
        EMP_ID = '&사번';

    IF ( SAL >= 5000000 ) THEN
        GRADE := '고급';
    ELSIF ( SAL >= 3000000 ) THEN
        GRADE := '중급';
    ELSIF ( SAL < 3000000 ) THEN
        GRADE := '초급';
    END IF;

    DBMS_OUTPUT.PUT_LINE('해당 사원의 급여 등급은 '
                         || GRADE
                         || '입니다.');
END;
/

DECLARE
    SAL   EM.SALARY%TYPE;
    GRADE VARCHAR2(10);
BEGIN
    SELECT
        SALARY
    INTO SAL
    FROM
        EM
    WHERE
        EMP_ID = '&사번';

    SELECT
        SAL_LEVEL
    INTO GRADE
    FROM
        SAL_GRADE
    WHERE
        SAL BETWEEN MIN_SAL AND MAX_SAL;

    DBMS_OUTPUT.PUT_LINE('해당 사원의 급여 등급은 '
                         || GRADE
                         || '입니다.');
END;
/

-- 1-3) CASE 구문
-- 사번을 입력받은 후에 사원의 모든 컬럼 데이터를 EMP ROWTYPE변수에 대입하고 DEPT_COD에 따라서 알맞는 부서를 출력한다.


DECLARE
    EMP   EM%ROWTYPE;
    DNAME VARCHAR2(30);
BEGIN
    SELECT
        *
    INTO EMP
    FROM
        EM
    WHERE
        EMP_ID = '&사번';

    DNAME :=
        CASE EMP.DEPT_CODE
            WHEN 'D1' THEN
                '인사관리부'
            WHEN 'D2' THEN
                '회계관리부'
            WHEN 'D3' THEN
                '마케팅부'
            WHEN 'D4' THEN
                '국내영업부'
            WHEN 'D5' THEN
                '해외영업1부'
            WHEN 'D6' THEN
                '해외영업2부'
            WHEN 'D7' THEN
                '해외영업3부'
            WHEN 'D8' THEN
                '기술지원부'
            WHEN 'D9' THEN
                '총무부'
            ELSE '부서 없음'
        END;

    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서코드 : ' || EMP.DEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || DNAME);
END;
/

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
        
--        IF (NUM > 5) THEN 
--            EXIT;
--        END IF;

        EXIT WHEN NUM > 5;
    END LOOP;
END;
/

--    2-2) WHILE LOOP
-- 1 ~ 5까지 순차적으로 1씩 증가하는 값을 출력
DECLARE
    NUM NUMBER := 1;
BEGIN
    WHILE ( NUM <= 5 ) LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
        NUM := NUM + 1;
    END LOOP;
END;
/
-- 구구단 (2 ~ 9단) 출력
DECLARE
    DAN NUMBER := 2;
    NUM NUMBER;
BEGIN
    WHILE ( DAN <= 9 ) LOOP
        NUM := 1;
        WHILE ( NUM <= 9 ) LOOP
            DBMS_OUTPUT.PUT_LINE(DAN
                                 || ' x '
                                 || NUM
                                 || ' = '
                                 || DAN * NUM);

            NUM := NUM + 1;
        END LOOP;

        DAN := DAN + 1;
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
END;
/

--    2-3) FOR LOOP
-- 1 ~ 5까지 순차적으로 1씩 증가하는 값 출력
BEGIN
    FOR NUM IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
    END LOOP;
END;
/

-- 역순으로 출력
BEGIN
    FOR NUM IN REVERSE 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
    END LOOP;
END;
/

-- 구구단 (2 ~ 9단) 출력(단, 짝수단만 출력한다.)
BEGIN
    FOR DAN IN 2..9 LOOP
        IF MOD(DAN, 2) = 0 THEN
            DBMS_OUTPUT.PUT_LINE(DAN || '단');
            FOR NUM IN 1..9 LOOP
                DBMS_OUTPUT.PUT_LINE(DAN
                                     || ' x '
                                     || NUM
                                     || ' = '
                                     || DAN * NUM);
            END LOOP;

            DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
    END LOOP;
END;
/

-- 반복문을 이용한 데이터 삽입

DROP TABLE TEST;

CREATE TABLE TEST (
    NUM         NUMBER,
    CREATE_DATE DATE
);

-- TEST 테이블에 10개의 행을 INSERT하는 PL/SQL 작성
BEGIN
    FOR NUM IN 1..10 LOOP
        INSERT INTO TEST VALUES (
            NUM,
            SYSDATE
        );

        IF ( MOD(NUM, 2) = 0 ) THEN
            COMMIT;
        ELSE
            ROLLBACK;
        END IF;

    END LOOP;
END;
/

ROLLBACK;

TRUNCATE TABLE TEST;

SELECT
    *
FROM
    TEST;
    
/*
    3. 예외처리부

    * 오라클에서 미리 정의되어 있는 예외
        - NO_DATA_FOUND : SELECET문의 수행 결과가 한 행도 없을 경우
        - TOO_MANY_ROWS : 한 행이 리턴되어야 하는데 SELECT 문ㅇ서 여러 개의 행을 반환할 때
        - ZERO_DIVIDE : 숫자를 0으로 나눌 때 발생
        - DUP_VAL_ON_INDEX : UNIQUE 제약조건을 가진 컬럼에 중복된 데이터가 INSERT 될 때 반환
        
*/
-- 사용자가 입력한 수로 나눗셈 연산한 결과 출력
BEGIN
    DBMS_OUTPUT.PUT_LINE(10 / &숫자);
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('나누기 연산시 0으로 나눌 수 없습니다.');
END;
/

-- UNIQUE 제약조건 위배시
BEGIN
    UPDATE EMPLOYEE
    SET
        EMP_ID = '200'
    WHERE
        EMP_NAME = '&이름';

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
END;
/

-- NO DATA_FOUND, TOO_MANY_ROWS 테스트
-- 너무 많은 행이 조회가 되었을 때

SELECT
    *
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'D1';

-- 조회되는 행이 없을 때
SELECT
    *
FROM
    EMPLOYEE
WHERE
    DEPT_CODE = 'D3';

DECLARE
    EID   EMPLOYEE.EMP_ID%TYPE;
    DCODE EMPLOYEE.DEPT_CODE%TYPE;
BEGIN
    SELECT
        EMP_ID,
        DEPT_CODE
    INTO
        EID,
        DCODE
    FROM
        EMPLOYEE
    WHERE
        DEPT_CODE = '&부서코드';

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('조회 결과가 없습니다.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('너무 많은 행을 조회했습니다.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('에러가 발생했습니다.');
END;
/

ROLLBACK;