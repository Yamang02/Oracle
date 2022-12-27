/*

    <SEQUENCE>
    
    
*/
--    EMPLOYEE 테이블의 PK 값을 생성할 시퀀스 생성
CREATE SEQUENCE SEQ_EMPID START WITH 300 INCREMENT BY 5 MAXVALUE 310 NOCYCLE NOCACHE;

SELECT
    *
FROM
    USER_SEQUENCES;

/*

    2. SEQUENCE 사용
    
*/
-- NEXTVAL를 한번이라도 수행하지 않은 이상 CURRVAL를 가져올 수 없다.
SELECT
    SEQ_EMPID.CURRVAL
FROM
    DUAL;

SELECT
    SEQ_EMPID.NEXTVAL
FROM
    DUAL;
-- 지정한 MAXVALUE 값을 넘었기 때문에 오류
SELECT
    SEQ_EMPID.CURRVAL
FROM
    DUAL;
-- LAST NUM은 315

/*
    3. SEQUENCE 수정
*/

ALTER SEQUENCE SEQ_EMPID START WITH INCREMENT BY 10 MAXVALUE 400; --START WITH 는 한번 SEQUENCE 가 생성되면 바꿀 수 없다.

SELECT
    SEQ_EMPID.CURRVAL
FROM
    DUAL; -- 310
SELECT
    SEQ_EMPID.NEXTVAL
FROM
    DUAL; -- 320


/*
    
    4. SEQUENCE 삭제


*/

DROP SEQUENCE SEQ_EMPID;

SELECT
    *
FROM
    USER_SEQUENCES;
    
/*

    5. SEQUENCE 예시

*/
-- 매번 새로운 사번이 발생되는 SEQUENCE 생성

CREATE SEQUENCE SEQ_EMPID START WITH 300;

-- 2) 매번 새로운 사번이 발생되는 SEQUENCE 사용해서 INSERT 생성

DELETE FROM EMPLOYEE
WHERE
    EMP_ID = 300;

SELECT
    *
FROM
    EMPLOYEE;

COMMIT;

ROLLBACK;

INSERT INTO EMPLOYEE (
    EMP_ID,
    EMP_NAME,
    EMP_NO
) VALUES (
    SEQ_EMPID.NEXTVAL,
    '홍길동',
    '221227-3123456'
);

INSERT INTO EMPLOYEE (
    EMP_ID,
    EMP_NAME,
    EMP_NO
) VALUES (
    SEQ_EMPID.NEXTVAL,
    '성춘향',
    '221227-4987654'
);
    