/*
    <PROCEDURE>
        PROCEDURE는 오라클에서 제공하는 객체로 PL/SQL 문을 저장하여 필요할 때마다 
        복잡한 구문을 다시 입력할 필요 없이 간단하게 호출해서 실행 결과를 얻을 수 있다.

*/

-- 테스트용 테이블 생성
CREATE TABLE EMP_COPY
    AS
        SELECT
            *
        FROM
            EMPLOYEE;

SELECT
    *
FROM
    EMP_COPY;

-- EMP_COPY 테이블의 모든 데이터를 삭제하는 프로시져 생성
CREATE PROCEDURE DEL_ALL_EMP IS
BEGIN
    DELETE FROM EMP_COPY;

    COMMIT;
END;
/

SELECT * FROM USER_SOURCE;

EXECUTE DEL_ALL_EMP;

DROP PROCEDURE DEL_ALL_EMP;
DROP TABLE EMP_COPY;