-- CREATE TABLE 권한이 없기 때문에 오류가 발생한다.
-- 3. SAMPLE 계정에 CREATE TABLE 권한을 주어야 한다.
-- 4. 테이블 스페이스 할당 (테이블, 뷰, 인덱스 등 객체들이 저장되는 공간)

CREATE TABLE TEST (
    TID NUMBER
);

-- 계정이 소유하고 있는 TABLE은 바로 조작이 가능하다.
SELECT * FROM TEST
INSERT INTO TEST VALUES(1)
DROP TABLE TEST;

-- 다른 테이블에 있는 자료에 접근하기 위해선 권한 필요
-- 다른 계정의 테이블에 접근할 수 있는 권한이 없기 때문에 오류가 발생
SELECT *
FROM KH.EMPLOYEE;


SELECT *
FROM KH.DEPARTMENT;

INSERT INTO KH.DEPARTMENT VALUES ('D0', '인사팀', 'L2');

ROLLBACK;