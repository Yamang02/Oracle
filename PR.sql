DROP TABLE MEMBER_KH;

CREATE TABLE MEMBER_KH (
    MNO NUMBER PRIMARY KEY,
    MNAME VARCHAR2(300) NOT NULL,
    ADDRESS VARCHAR2(1000),
    TEL VARCHAR2(13) UNIQUE
);

COMMENT ON COLUMN MEMBER_KH.MNO IS '회원번호';
COMMENT ON COLUMN MEMBER_KH.MNAME IS '회원명';
COMMENT ON COLUMN MEMBER_KH.ADDRESS IS '주소';
COMMENT ON COLUMN MEMBER_KH.TEL IS '연락처';

INSERT INTO MEMBER_KH VALUES(1, '홍길동', '서울시 강남구', '011-0000-0000');
INSERT INTO MEMBER_KH VALUES(1, '고길동', '부산시 해운대구', '010-0000-0000');
INSERT INTO MEMBER_KH VALUES(1, '김갑환', '인천시 연수구', '019-0000-0000');

ALTER TABLE MEMBER_KH DROP CONSTRAINT SYS_C007299;

SELECT * FROM MEMBER_KH;


SELECT DEPT_CODE, SUM(SALARY) 합계, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수

FROM EMPLOYEE

--WHERE SALARY > 2800000

GROUP BY DEPT_CODE

ORDER BY DEPT_CODE ASC;