ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE USER kh_shop IDENTIFIED BY 1234;
GRANT RESOURCE, CONNECT TO kh_shop;
ALTER USER kh_shop DEFAULT TABLESPACE SYSTEM QUOTA UNLIMITED ON SYSTEM ;

CREATE TABLE CATEGORIES(
	CATEGORY_ID NUMBER PRIMARY KEY,
	CATEGORY_NAME VARCHAR2(100) UNIQUE
);

CREATE TABLE PRODUCTS(
	PRODUCT_ID NUMBER PRIMARY KEY,
	PRODUCT_NAME VARCHAR2(100) NOT NULL,
	CATEGORY NUMBER REFERENCES CATEGORIES(CATEGORY_ID),
	PRICE NUMBER DEFAULT 0,
  STOCK_QUANTITY NUMBER DEFAULT 0
);

--3. 고객 정보 테이블 (CUSTOMERS)
--고객 ID (CUSTOMER_ID) - NUMBER [PK]
--이름 (NAME) - VARCHAR2(20) [NOT NULL]
--성별 (GENDER) - CHAR(3) [CHECK 남, 여]
--주소 (ADDRESS) - VARCHAR2(100)
--전화번호 (PHONE) - VARCHAR2(30)
CREATE TABLE CUSTOMERS(
	CUSTOMER_ID NUMBER PRIMARY KEY,
	NAME VARCHAR2(20) NOT NULL,
	GENDER CHAR(3) CHECK( GENDER IN ('남','여') ) ,
	ADDRESS VARCHAR2(100),
  PHONE VARCHAR2(30)
);


--4. 주문 정보 테이블 (ORDERS)
--주문 번호 (ORDER_ID) - NUMBER [PK]
--주문일 (ORDER_DATE) - DATE [DEFAULT SYSDATE]
--처리상태 (STATUS) - CHAR(1) [CHECK ('Y', 'N') DEFAULT 'N']
--고객 ID (CUSTOMER_ID) - NUMBER [FK - CUSTOMERS(CUSTOMER_ID) ON DELETE
--CASCADE]

CREATE TABLE ORDERS(
	ORDER_ID NUMBER PRIMARY KEY,
	ORDER_DATE DATE DEFAULT SYSDATE,
	STATUS CHAR(1)  DEFAULT 'N' CHECK (STATUS IN ('Y', 'N')),
	CUSTOMER_ID NUMBER REFERENCES CUSTOMERS(CUSTOMER_ID) ON DELETE CASCADE
);

--5. 주문 상세 정보 테이블 (ORDER_DETAILS)
--주문 상세 ID (ORDER_DETAIL_ID) - NUMBER [PK]
--주문 번호 (ORDER_ID) NUMBER - [FK - ORDERS(ORDER_ID) ON DELETE CASCADE]
--상품 코드 (PRODUCT_ID) NUMBER - [FK - PRODUCTS(PRODUCT_ID) ON DELETE
--SET NULL]
--수량 (QUANTITY) NUMBER
--가격 (PRICE_PER_UNIT) NUMBER
CREATE TABLE ORDER_DETAILS(
	ORDER_DETAIL_ID NUMBER PRIMARY KEY,
	ORDER_ID NUMBER REFERENCES ORDERS(ORDER_ID) ON DELETE CASCADE,
	PRODUCT_ID NUMBER REFERENCES PRODUCTS(PRODUCT_ID) ON DELETE SET NULL,
	QUANTITY NUMBER,
	PRICE_PER_UNIT NUMBER
);

INSERT INTO CATEGORIES
VALUES(1 , '스마트폰');
INSERT INTO CATEGORIES
VALUES(2 , 'TV');
INSERT INTO CATEGORIES
VALUES(3 , 'Gaming');

SELECT * FROM CATEGORIES;

INSERT INTO PRODUCTS
VALUES(101 , 'Apple iPhone 12', 1, 1500000, 30);
INSERT INTO PRODUCTS
VALUES(102 , 'Samsung Galaxy', 1, 1800000, 50);
INSERT INTO PRODUCTS
VALUES(201 , 'LG OLED TV', 2, 3600000, 10);
INSERT INTO PRODUCTS
VALUES(301 , 'Sony PlayStation 5', 3, 700000, 15);

SELECT * FROM PRODUCTS;

INSERT INTO CUSTOMERS
VALUES(1 , '홍길동', '남', '서울시 성동구 왕십리', '010-1111-2222');
INSERT INTO CUSTOMERS
VALUES(2 , '유관순', '여', '서울시 종로구 안국동', '010-3333-1111');

SELECT * FROM CUSTOMERS;

INSERT INTO ORDERS
VALUES(576 , '2024-02-09', 'N', 1);
INSERT INTO ORDERS
VALUES(978 , '2024-03-11', 'Y', 2);
INSERT INTO ORDERS
VALUES(777 , '2024-03-11', 'N', 2);
INSERT INTO ORDERS
VALUES(134 , '2022-12-25', 'Y', 1);
INSERT INTO ORDERS
VALUES(499 , '2020-01-03', 'Y', 1);

SELECT * FROM ORDERS;

INSERT INTO ORDER_DETAILS
VALUES(111 , 576, 101, 1, 1500000);
INSERT INTO ORDER_DETAILS
VALUES(222 , 978, 201, 2, 3600000);
INSERT INTO ORDER_DETAILS
VALUES(333 , 978, 102, 1, 1800000);
INSERT INTO ORDER_DETAILS
VALUES(444 , 777, 301, 5, 700000);
INSERT INTO ORDER_DETAILS
VALUES(555 , 134, 102, 1, 1800000);
INSERT INTO ORDER_DETAILS
VALUES(666 , 499, 201, 3, 3600000);

SELECT * FROM ORDER_DETAILS;
-- 1번
SELECT NAME 고객명, ORDER_DATE 주문일, STATUS 처리상태
FROM ORDERS
JOIN CUSTOMERS USING ( CUSTOMER_ID)
WHERE STATUS = 'N';
--2번
SELECT ORDER_ID 주문번호, ORDER_DATE 주문일, STATUS 처리상태
FROM ORDERS
JOIN CUSTOMERS USING (CUSTOMER_ID)
WHERE SUBSTR(TO_CHAR(ORDER_DATE, 'YYYY'),1,4) >= '2024'
AND NAME = '홍길동';
--3번
SELECT ORDER_ID 주문번호, PRODUCT_NAME 상품명, QUANTITY 수량, PRICE_PER_UNIT 개별금액, PRICE_PER_UNIT * QUANTITY 주문별금액합계
FROM ORDERS
JOIN ORDER_DETAILS USING(ORDER_ID)
JOIN PRODUCTS USING (PRODUCT_ID)
JOIN CUSTOMERS USING (CUSTOMER_ID)
WHERE NAME = '유관순'
ORDER BY QUANTITY DESC;



SELECT PRICE_PER_UNIT * QUANTITY 주문별금액합계
FROM ORDER_DETAILS;



