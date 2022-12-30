/*

    <CURSOR>
        SQL 구문의 처리 결과를 담고 있는 객체이다.
        CURSOR 사용 시 여러 행으로 나타난 처리 결과에 순차적으로 접근 가능하다.

    <CURSOR 종류>
        1. 묵시적 커서
            오라클에서 자동으로 생성되어 사용하는 커서이다. (커서면 : SQL)
            PL/SQL에서 SQL문 실행 시마다 자동으로 만들어져서 사용된다.
            
        2. 명시적 커서
            사용자가 직접 선언해서 사용할 수 있는 이름이 있는 커서이다.

            [표현법]
                CURSOR 커서명 IS SELECT 문
                OPEN 커서명;
                FETCH 커서명 INTO 변수[, 변수, ...];
                ...
                
                CLOSE 커서명;
            
            
        * 커서 속성
            커서명%FOUND : 커서 영역에 남아있는 행의 수가 한 개 이상일 경우 TRUE, 아니면 FALSE
            커서명%NOTFOUND : 커서 영역에 남아있는 행의 수가 없으면 TRUE, 아니면 FALSE
            커서명%ISOPEN : 커서가 OPEN 상태인 경우 TRUE, 아니면 FALSE (묵시적 커서는 항상 FALSE)
            커서명%ROWCOUNT : SQL 처리 결과로 얻어온 행(ROW)의 수

*/

-- 1묵시적 커서
SELECT
    *
FROM
    EMP_COPY;

-- PL/SQL에서 EMP_COPY에 BONUS가 NULL인 사원의 BONUS를 0으로 수정

BEGIN
    UPDATE EMP_COPY
    SET
        BONUS = 0
    WHERE
        BONUS IS NULL;

-- 묵시적 커서 사용
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || '개의 행이 수정됨');
END;
/

-- 2. 명시적 커서
-- 급여가 3000000원 이상인 사원의 사번, 이름, 급여 출력

DECLARE
    EID   EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL   EMPLOYEE.SALARY%TYPE;
    
    -- 커서 선언
    CURSOR C1 IS
    SELECT
        EMP_ID,
        EMP_NAME,
        SALARY
    FROM
        EMPLOYEE
    WHERE
        SALARY > 3000000;

BEGIN

    -- 커서 오픈
    OPEN C1;
    LOOP
        -- 커서 패치
        FETCH C1 INTO
            EID,
            ENAME,
            SAL;
        DBMS_OUTPUT.PUT_LINE(EID
                             || ' '
                             || ENAME
                             || ' '
                             || SAL);
        
        -- 반복문의 종료 조건
        EXIT WHEN C1%NOTFOUND;
    END LOOP;

    
    -- 커서 종료
    CLOSE C1;
END;
/

-- 프로시져 생성
-- 전체 부서에 대해 부서 코드, 부서명, 지역 조회

SELECT
    D.DEPT_ID,
    D.DEPT_TITLE,
    L.LOCAL_NAME
FROM
         DEPARTMENT D
    INNER JOIN LOCATION L ON ( D.LOCATION_ID = L.LOCAL_CODE );

DROP PROCEDURE SEL_DEP_LOCAL;

CREATE OR REPLACE PROCEDURE SEL_DEP_LOCAL IS
    DEPT DEPARTMENT%ROWTYPE;
    CURSOR C1 IS
    SELECT
        *
    FROM
        DEPARTMENT;

BEGIN
    OPEN C1;
    LOOP
        FETCH C1 INTO
            DEPT.DEPT_ID,
            DEPT.DEPT_TITLE,
            DEPT.LOCATION_ID;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(DEPT.DEPT_ID
                             || ' '
                             || DEPT.DEPT_TITLE
                             || ' '
                             || DEPT.LOCATION_ID);

    END LOOP;

    CLOSE C1;
END;
/

-- FOR LOOP를 이용한 커서 사용;
-- 1) LOOP 시작 시 자동으로 커서를 OPEN한다.
-- 2) 반복할 때마다 FETCH 자동으로 실행된다.
-- 3) LOOP 종료시 자동으로 커서를 CLOSE한다.

CREATE OR REPLACE PROCEDURE SEL_DEP_LOCAL IS
    DEPT DEPARTMENT%ROWTYPE;
    CURSOR C1 IS
    SELECT
        *
    FROM
        DEPARTMENT;

BEGIN
    FOR DEPT IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE(DEPT.DEPT_ID
                             || ' '
                             || DEPT.DEPT_TITLE
                             || ' '
                             || DEPT.LOCATION_ID);
    END LOOP;
END;
/

EXECUTE SEL_DEP_LOCAL;

CREATE OR REPLACE PROCEDURE SEL_DEP_LOCAL IS
    DEPT DEPARTMENT%ROWTYPE;
BEGIN
    FOR DEPT IN (
        SELECT
            *
        FROM
            DEPARTMENT
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(DEPT.DEPT_ID
                             || ' '
                             || DEPT.DEPT_TITLE
                             || ' '
                             || DEPT.LOCATION_ID);
    END LOOP;
END;
/
/*
CREATE OR REPLACE PROCEDURE SEL_DEPT_WITH_LOCAL IS

    DID DEPARTMENT.DEPT_ID;
    DTL DEPARTMENT.DEPT_TITLE;
    LOC LOCAL.LOCAL_NAME;
    CURSOR C1 IS
    SELECT
        D.DEPT_ID,
        D.DEPT_TITLE,
        L.LOCAL_NAME
    FROM
             DEPARTMENT D
        INNER JOIN LOCAL L ON ( D.LOCATION_ID = L.LOCAL_CODE );

BEGIN
    OPEN C1;
    LOOP
        FETCH C1 INTO
            DID,
            DTL,
            LOC;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(DEPT.DEPT_ID
                             || ' '
                             || DEPT.DEPT_TITLE
                             || ' '
                             || DEPT.LOCATION_ID);

    END LOOP;

    CLOSE C1;
END;
/
*/


SELECT
    D.DEPT_ID,
    D.DEPT_TITLE,
    L.LOCAL_NAME
FROM
         DEPARTMENT D
    INNER JOIN LOCATION L ON ( D.LOCATION_ID = L.LOCAL_CODE );

DECLARE
    DID DEPARTMENT.DEPT_ID%TYPE;
    DTL DEPARTMENT.DEPT_TITLE%TYPE;
    LOC LOCATION.LOCAL_NAME%TYPE;
    CURSOR C2 IS
    (SELECT
        D.DEPT_ID,
        D.DEPT_TITLE,
        L.LOCAL_NAME
    FROM
             DEPARTMENT D
        INNER JOIN LOCATION L ON ( D.LOCATION_ID = L.LOCAL_CODE ));

BEGIN

    -- 커서 오픈
    OPEN C2;
    LOOP
        -- 커서 패치
        FETCH C2 INTO
            DID,
            DTL,
            LOC;
        DBMS_OUTPUT.PUT_LINE(DID
                             || ' '
                             || DTL
                             || ' '
                             || LOC);
        
        -- 반복문의 종료 조건
        EXIT WHEN C2%NOTFOUND;
    END LOOP;

    
    -- 커서 종료
    CLOSE C2;
END;
/

ROLLBACK;