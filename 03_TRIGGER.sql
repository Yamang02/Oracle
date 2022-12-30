/*
  
    <TRIGGER>  
        오라클에서 제공하는 객체로
        테이블이나 뷰가 DML(INSERT, UPDATE, DELETE)문에 의해 변경될 경우 자동으로 실행될 내용 정의하며 지칭한다.

*/
-- 1. 문장 트리거
-- EMPLOYEE 테이블에 새로운 행이 INSERT 될 때 '신입사원이 입사했습니다.' 메시지를 자동으로 출력하는 트리거를 생성

DROP TRIGGER TRG_01;

CREATE TRIGGER TRG_01 AFTER
    INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원이 입사했습니다.');
END;
/

INSERT INTO EMPLOYEE (
    EMP_ID,
    EMP_NAME,
    EMP_NO
) VALUES (
    SEQ_EMPID.NEXTVAL,
    '공유',
    '221229-3777777'
);


-- 2. 행 트리거
-- EMPLOYEE 테이블에 UPDATE 수행 후 '업데이트 실행' 메시지를 자동으로 출력
-- :OLD : 수정, 삭제 전 데이터에 접근 가능
-- :NEW : 입력, 수정 후 데이터에 접근 가능

CREATE OR REPLACE TRIGGER TRG_02 AFTER
    UPDATE ON EMPLOYEE
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE(NEW.EMP_NAME, '변경 전 : '
                                       || :OLD.DEPT_CODE
                                       || ', 변경 후 : '
                                       || :NEW.DEPT_CODE);
END;
/

-- EMPLOYEE 테이블에서 부서 코드가 D9인 직원들의 부서 코드를 D3로 변경
UPDATE EMPLOYEE
SET
    DEPT_CODE = 'D3'
WHERE
    DEPT_CODE = 'D9';

ROLLBACK;

-- 상품 입/출고 관련 예시

-- 1. 상품에 대한 데이터를 보관할 테이블 생성 (TB_PRODUCT)

CREATE TABLE TB_PRODUCT (
    PCODE NUMBER,           -- 상품 코드
    PNAME VARCHAR2(150),    -- 상품명
    BRAND VARCHAR2(100),    -- 브랜드
    PRICE NUMBER,           -- 가격
    STOCK NUMBER DEFAULT 0,  -- 재고
    CONSTRAINT TB_PRODUCT_PCODE_PK PRIMARY KEY ( PCODE )
);

-- 상품코드가 중복되지 않게 새로운 번호를 발생하는 시퀀스 생성한다.
CREATE SEQUENCE SEQ_PCODE;

-- 샘플 데이터 3개 INSERT
INSERT INTO TB_PRODUCT VALUES (
    SEQ_PCODE.NEXTVAL,
    '아이폰14',
    '애플',
    1000000, DEFAULT
);

INSERT INTO TB_PRODUCT VALUES (
    SEQ_PCODE.NEXTVAL,
    'Z플립',
    '삼성',
    1500000, DEFAULT
);

INSERT INTO TB_PRODUCT VALUES (
    SEQ_PCODE.NEXTVAL,
    '샤오미',
    '애플',
    5000000, DEFAULT
);

COMMIT;

SELECT
    *
FROM
    TB_PRODUCT;

-- 2. 상품 입/출고 상세 이력 테이블 생성 (TB_PRODETAIL)
CREATE TABLE TB_PRODETAIL (
    DCODE  NUMBER,           -- 입출고 이력 코드
    PCODE  NUMBER,           -- 상품코드(외래 키로 지정, TB_PRODUCT 테이블을 참조)
    STATUS VARCHAR2(10),    -- 상태(입고/출고)
    AMOUNT NUMBER,          -- 수량
    DDATE  DATE DEFAULT SYSDATE, -- 상품 입/출고 일자
    CONSTRAINT TB_PRODETAIL_DCODE_PK PRIMARY KEY ( DCODE ),
    CONSTRAINT TB_PRODETAIL_PCODE_FK FOREIGN KEY ( PCODE )
        REFERENCES TB_PRODUCT,
    CONSTRAINT TB_PRODETAIL_STATUS_CH CHECK ( STATUS IN ( '입고', '출고' ) )
);

-- 입출력 이력코드가 중복되지 않게 새로운 번호를 발생하는 시퀀스 생성한다.
CREATE SEQUENCE SEQ_DCODE;

SELECT
    *
FROM
    TB_PRODUCT;

SELECT
    *
FROM
    TB_PRODETAIL;
    
-- 1번 상품이 22/12/20 날짜로 10개 입고 
INSERT INTO TB_PRODETAIL VALUES (
    SEQ_DCODE.NEXTVAL,
    1,
    '입고',
    10,
    '22/12/20'
);

-- 1번 상품의 재고 수량도 변경해야 한다.

UPDATE TB_PRODUCT
SET
    STOCK = STOCK + 10
WHERE
    PCODE = 1;


-- 2번 상품이 22/12/21 날짜로 20개가 입고
INSERT INTO TB_PRODETAIL VALUES (
    SEQ_DCODE.NEXTVAL,
    2,
    '입고',
    20,
    '22/12/21'
);

UPDATE TB_PRODUCT
SET
    STOCK = STOCK + 20
WHERE
    PCODE = 2;




-- 3번 상품이 22/12/21 날짜로 5개 입고
INSERT INTO TB_PRODETAIL VALUES (
    SEQ_DCODE.NEXTVAL,
    3,
    '입고',
    5,
    '22/12/21'
);

UPDATE TB_PRODUCT
SET
    STOCK = STOCK + 5
WHERE
    PCODE = 3;



-- 2번 상품이 22/12/22 날짜로 5개 출고
INSERT INTO TB_PRODETAIL VALUES (
    SEQ_DCODE.NEXTVAL,
    2,
    '출고',
    5,
    '22/12/22'
);

UPDATE TB_PRODUCT
SET
    STOCK = STOCK - 5
WHERE
    PCODE = 2;

UPDATE TB_PRODUCT
SET
    PNAME = '샤오미폰',
    BRAND = '샤오미',
    PRICE = 500000
WHERE
    PCODE = 3;

COMMIT;

-- TB_PRODETAIL 테이블에 데이터 삽입 시 TB_PRODUCT 테이블에 
-- 재고 수량이 자동으로 업데이트 되도록 트리거를 생성한다.


CREATE OR REPLACE TRIGGER TRG_PRO_STOCK AFTER
    INSERT ON TB_PRODETAIL
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE(:NEW.STATUS
                         || ' '
                         || :NEW.AMOUNT
                         || ' '
                         || :NEW.PCODE);
    -- 상품이 입고된 경우 (재고 증가)
    IF ( :NEW.STATUS = '입고' ) THEN
        UPDATE TB_PRODUCT
        SET
            STOCK = STOCK + :NEW.AMOUNT
        WHERE
            PCODE = :NEW.PCODE;

    END IF;

    -- 상품이 출고된 경우 (재고 감소)
    IF ( :NEW.STATUS = '출고' ) THEN
        UPDATE TB_PRODUCT
        SET
            STOCK = STOCK - :NEW.AMOUNT
        WHERE
            PCODE = :NEW.PCODE;

    END IF;

END;
/
-- 트리거에서는 COMMIT을 포함한 TCL구문을 쓸 수 없다. -> 트리거가 되는 INSERT 까지 커밋되어버리기 때문이다. 


-- 2번 상품이 '22/12/25' 날짜로 20개 입고
INSERT INTO TB_PRODETAIL VALUES (
    SEQ_DCODE.NEXTVAL,
    2,
    '입고',
    20,
    '22/12/25'
);



-- 2번 상품이 '22/12/25' 날짜로 5개 출고
INSERT INTO TB_PRODETAIL VALUES (
    SEQ_DCODE.NEXTVAL,
    2,
    '출고',
    5,
    '22/12/25'
);


-- 3번 상품이 '22/12/29' 날짜로 100개 입고
/*
TABLE TB_PRODETAIL (
    DCODE  NUMBER,           -- 입출고 이력 코드
    PCODE  NUMBER,           -- 상품코드(외래 키로 지정, TB_PRODUCT 테이블을 참조)
    STATUS VARCHAR2(10),    -- 상태(입고/출고)
    AMOUNT NUMBER,          -- 수량
    DDATE  DATE DEFAULT SYSDATE, -- 상품 입/출고 일자   
    */

INSERT INTO TB_PRODETAIL VALUES (
    SEQ_DCODE.NEXTVAL,
    3,
    '입고',
    100,
    '22/12/29'
);

COMMIT;

ROLLBACK;

SELECT
    *
FROM
    TB_PRODUCT;

SELECT
    *
FROM
    TB_PRODETAIL;

DROP TRIGGER TRG_TEST;

CREATE OR REPLACE TRIGGER TRG_TEST BEFORE
    INSERT ON TB_PRODETAIL
BEGIN
    DBMS_OUTPUT.PUT_LINE('BEFORE 트리거 롤백 테스트');
    UPDATE EMPLOYEE
    SET
        EMP_NAME = '성동일'
    WHERE
        EMP_ID = '200';

END;
/

UPDATE EMPLOYEE
SET
    EMP_NAME = '성동일'
WHERE
    EMP_ID = '200';

INSERT INTO TB_PRODETAIL VALUES (
    SEQ_DCODE.NEXTVAL,
    3,
    '입고',
    1,
    '22/12/29'
);

ROLLBACK;
COMMIT;

DROP TRIGGER TRG_02;