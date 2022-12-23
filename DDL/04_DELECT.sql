/*

    <DELETE>
        테이블에 기록된 데이터를 삭제하는 구문이다.

*/

COMMIT;

--EMP_SALARY 테이블에서 선동일 사장의 데이터를 지우기
SELECT
    *
FROM
    EMP_SALARY
WHERE
    EMP_NAME = '선동일';

-- EMP_SALARY 테이블에서 DEPT_CODE가 D5인 직원들을 삭제

--SELECT*
DELETE FROM EMP_SALARY
WHERE
    DEPT_CODE = 'D5';

ROLLBACK;

DELETE FROM EMP_SALARY;

ROLLBACK;

SELECT
    *
FROM
    EMP_SALARY;

/*
        <TRUNCATE>
            테이블의 전체 행을 삭제할 때 사용하는 구분이다.
            조건을 제시할 수 없고 ROLLBACK이 불가능하다.    
        
*/

SELECT
    *
FROM
    EMP_SALARY;

SELECT
    *
FROM
    DEPT_COPY;

DELETE FROM EMP_SALARY;

DELETE FROM DEPT_COPY;

TRUNCATE TABLE EMP_SALARY;

TRUNCATE TABLE DEPT_COPY;

ROLLBACK; -- ROLLBACK이 불가능하다.