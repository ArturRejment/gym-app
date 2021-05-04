DROP TABLE TRAINER_HOURS CASCADE CONSTRAINTS;
DROP TABLE GROUP_TRAINING CASCADE CONSTRAINTS;
DROP TABLE WORKING_HOURS CASCADE CONSTRAINTS;
DROP TABLE GROUP_TRAINING_SCHEDULE CASCADE CONSTRAINTS;
DROP TABLE TRAINER CASCADE CONSTRAINTS;
DROP TABLE SHOP_PRODUCTS CASCADE CONSTRAINTS;
DROP TABLE SHOP CASCADE CONSTRAINTS;
DROP TABLE PRODUCTS CASCADE CONSTRAINTS;
DROP TABLE MEMBERSHIP CASCADE CONSTRAINTS;
DROP TABLE GYM_MEMBER CASCADE CONSTRAINTS;
DROP TABLE ADDRESS CASCADE CONSTRAINTS;


--------------------------------------
-- CREATE ADDRESSES
--------------------------------------
CREATE TABLE ADDRESS (
    ADDRESS_ID NUMBER,
    POSTCODE VARCHAR2(20 CHAR),
    CITY VARCHAR2(20 CHAR),
    STREET VARCHAR2(20 CHAR),
    CONSTRAINT ADDRESS_PK PRIMARY KEY (ADDRESS_ID)
);

--------------------------------------
-- CREATE TRAINER
--------------------------------------
CREATE TABLE TRAINER (
    TRAINER_ID NUMBER,
    FIRST_NAME VARCHAR2(20 CHAR) NOT NULL,
    LAST_NAME VARCHAR2(20 CHAR) NOT NULL,
    ADDRESS_ID NUMBER,
    PHONE_NUMBER VARCHAR2(9 CHAR),
    EMAIL VARCHAR2(30 CHAR) NOT NULL UNIQUE,
    CONSTRAINT TRAINER_PK PRIMARY KEY(TRAINER_ID),
    CONSTRAINT TRAINER_ADDRESS_FK FOREIGN KEY (ADDRESS_ID) REFERENCES ADDRESS(ADDRESS_ID)
);

--------------------------------------
-- CREATE GYM MEMBER
--------------------------------------
CREATE TABLE GYM_MEMBER (
    MEMBER_ID NUMBER,
    FIRST_NAME VARCHAR2(20 CHAR) NOT NULL,
    LAST_NAME VARCHAR2(20 CHAR) NOT NULL,
    ADDRESS_ID NUMBER,
    PHONE_NUMBER VARCHAR2(9 CHAR),
    EMAIL VARCHAR2(30 CHAR),
    CONSTRAINT MEMBER_PK PRIMARY KEY(MEMBER_ID),
    CONSTRAINT MEMBER_ADDRESS_FK FOREIGN KEY (ADDRESS_ID) REFERENCES ADDRESS(ADDRESS_ID)
);

--------------------------------------
-- CREATE MEMBERSHIP
--------------------------------------
CREATE TABLE MEMBERSHIP (
    MEMBERSHIP_ID NUMBER,
    PURCHASE_DATE DATE NOT NULL,
    EXPIRY_DATE DATE NOT NULL,
    MEMBER_ID NUMBER NOT NULL,
    TYPE VARCHAR2(15 CHAR) NOT NULL,
    CONSTRAINT MEMBERSHIP_PK PRIMARY KEY(MEMBERSHIP_ID),
    CONSTRAINT MEMBERSHIP_MEMBER_FK FOREIGN KEY(MEMBER_ID) REFERENCES GYM_MEMBER(MEMBER_ID)
);

--------------------------------------
-- CREATE WORKING HOURS
--------------------------------------
CREATE TABLE WORKING_HOURS(
    WORKING_ID NUMBER,
    START_TIME VARCHAR2(5 CHAR),
    FINISH_TIME VARCHAR2(5 CHAR),
    CONSTRAINT WORKING_PK PRIMARY KEY(WORKING_ID)
);

-------------------------------------
-- CREATE GROUP TRAINING
-------------------------------------
CREATE TABLE GROUP_TRAINING(
    GROUP_TRAINING_ID NUMBER,
    GROUP_TRAINING_NAME VARCHAR2(30 CHAR),
    TRAINER_ID NUMBER NOT NULL,
    WORKING_ID NUMBER NOT NULL,
    CONSTRAINT GROUP_TRAINING_PK PRIMARY KEY(GROUP_TRAINING_ID),
    CONSTRAINT TRAINER_GROUP_FK FOREIGN KEY (TRAINER_ID) REFERENCES TRAINER(TRAINER_ID),
    CONSTRAINT WORKING_GROUP_FK FOREIGN KEY (WORKING_ID) REFERENCES WORKING_HOURS(WORKING_ID)
);

--------------------------------------
-- CREATE SCHEDULE FOR GROUP TRAININGS
--------------------------------------
CREATE TABLE GROUP_TRAINING_SCHEDULE(
    GROUP_TRAINING_SCHEDULE_ID NUMBER,
    GROUP_TRAINING_ID NUMBER NOT NULL,
    GYM_MEMBER_ID NUMBER NOT NULL,
    CONSTRAINT GROUP_TRAINING_SCHEDULE_PK PRIMARY KEY(GROUP_TRAINING_SCHEDULE_ID),
    CONSTRAINT GROUP_TRAINING_FK FOREIGN KEY(GROUP_TRAINING_ID) REFERENCES GROUP_TRAINING(GROUP_TRAINING_ID),
    CONSTRAINT GROUP_MEMBER_FK FOREIGN KEY(GYM_MEMBER_ID) REFERENCES GYM_MEMBER(MEMBER_ID)
);

--------------------------------------
-- CREATE SCHEDULE HOUR FOR TAINERS
--------------------------------------
CREATE TABLE TRAINER_HOURS (
    SHIFT_ID NUMBER,
    TRAINER_ID NUMBER,
    WORKING_ID NUMBER,
    MEMBER_ID NUMBER,
    IS_ACTIVE NUMBER(1),
    IS_TAKEN NUMBER(1),
    CONSTRAINT SHIFT_PK PRIMARY KEY(SHIFT_ID),
    CONSTRAINT TRAINER_HOURS_FK FOREIGN KEY (TRAINER_ID) REFERENCES TRAINER(TRAINER_ID),
    CONSTRAINT WORKING_HOURS_FK FOREIGN KEY (WORKING_ID) REFERENCES WORKING_HOURS(WORKING_ID),
    CONSTRAINT MEMBER_HOURS_FK FOREIGN KEY (MEMBER_ID) REFERENCES GYM_MEMBER(MEMBER_ID),
    CONSTRAINT IS_ACTIVE CHECK ( IS_ACTIVE IN (0,1)),
    CONSTRAINT IS_TAKEN CHECK ( IS_TAKEN IN (0,1))
);

--------------------------------------
-- CREATE SHOP
--------------------------------------
CREATE TABLE SHOP (
    SHOP_ID NUMBER,
    SHOP_NAME VARCHAR2(20 CHAR) NOT NULL,
    ADDRESS_ID NUMBER,
    CONSTRAINT SHOP_PK PRIMARY KEY(SHOP_ID),
    CONSTRAINT SHOP_ADDRESS_FK FOREIGN KEY (ADDRESS_ID) REFERENCES ADDRESS(ADDRESS_ID)
);

--------------------------------------
-- CREATE PRODUCTS FOR THE SHOP
--------------------------------------
CREATE TABLE PRODUCTS(
    PRODUCT_ID NUMBER,
    PRICE NUMBER NOT NULL,
    PRODUCT_NAME VARCHAR2(20 CHAR) NOT NULL,
    CONSTRAINT PRODUCT_PK PRIMARY KEY(PRODUCT_ID)
);

--------------------------------------
-- CREATE LIST OF PRODUCTS
--------------------------------------
CREATE TABLE SHOP_PRODUCTS (
    LISTING_ID NUMBER,
    SHOP_ID NUMBER NOT NULL,
    PRODUCT_ID NUMBER NOT NULL,
    CONSTRAINT LISTING_PK PRIMARY KEY(LISTING_ID),
    CONSTRAINT SHOP_LIST_FK FOREIGN KEY(SHOP_ID) REFERENCES SHOP(SHOP_ID),
    CONSTRAINT PRODUCT_LIST FOREIGN KEY(PRODUCT_ID) REFERENCES PRODUCTS(PRODUCT_ID)
);

--------------------------------------
-- CREATE VIEV
--------------------------------------
CREATE OR REPLACE VIEW AVAILABLE_TRAINERS AS
SELECT TRAINER.LAST_NAME , TRAINER.FIRST_NAME , WORKING_HOURS.START_TIME , WORKING_HOURS.FINISH_TIME 
FROM TRAINER_HOURS
JOIN TRAINER USING(TRAINER_ID)
JOIN WORKING_HOURS USING(WORKING_ID)
WHERE IS_ACTIVE = 1 AND IS_TAKEN = 1
ORDER BY "Last name" DESC;






-----------------------------------------
--       INSERTING INTO ADDRESSES
-----------------------------------------
INSERT INTO ADDRESS VALUES (1, '47-224', 'K�dzierzyn-Ko�le', 'Tartaczna 5/3');
INSERT INTO ADDRESS VALUES (2, '47-224', 'K�dzierzyn-Ko�le', 'Kozielska 2');
INSERT INTO ADDRESS VALUES (3, '37-255', 'Wroclaw', 'G�rnickiego');
INSERT INTO ADDRESS VALUES (4, '21-556', 'Opole', 'Dubois 5');
INSERT INTO ADDRESS VALUES (5, '77-256', 'Lubsza', 'Piastowice 48a');
INSERT INTO ADDRESS VALUES (6, '47-224', 'K�dzierzyn-Ko�le', 'Przechodnia 8');

----------------------------------------
--        INSERT INTO WORKING HOURS
----------------------------------------
INSERT INTO WORKING_HOURS VALUES(1, '7:00', '8:00');
INSERT INTO WORKING_HOURS VALUES(2, '8:00', '9:00');
INSERT INTO WORKING_HOURS VALUES(3, '9:00', '10:00');
INSERT INTO WORKING_HOURS VALUES(4, '10:00', '11:00');
INSERT INTO WORKING_HOURS VALUES(5, '11:00', '12:00');
INSERT INTO WORKING_HOURS VALUES(6, '12:00', '13:00');
INSERT INTO WORKING_HOURS VALUES(7, '13:00', '14:00');
INSERT INTO WORKING_HOURS VALUES(8, '14:00', '15:00');
INSERT INTO WORKING_HOURS VALUES(9, '15:00', '16:00');
INSERT INTO WORKING_HOURS VALUES(10, '16:00', '17:00');
INSERT INTO WORKING_HOURS VALUES(11, '17:00', '18:00');
INSERT INTO WORKING_HOURS VALUES(12, '18:00', '19:00');
INSERT INTO WORKING_HOURS VALUES(13, '19:00', '20:00');
INSERT INTO WORKING_HOURS VALUES(14, '20:00', '21:00');
INSERT INTO WORKING_HOURS VALUES(15, '21:00', '22:00');

-----------------------------------------
--    INSERT INTO SHOP, PRODUCTS AND LIST
-----------------------------------------
INSERT INTO SHOP VALUES(1, 'Gym Fit Shop', NULL);
INSERT INTO SHOP VALUES(2, 'KFD Shop', NULL);
INSERT INTO PRODUCTS VALUES(1, 80.00, 'Protein WPC 80%');
INSERT INTO PRODUCTS VALUES(2, 6.00, 'Dzik Energy');
INSERT INTO PRODUCTS VALUES(3, 2.49, 'Lody Ekipy');
INSERT INTO PRODUCTS VALUES(4, 59.99, 'Bomba');
INSERT INTO PRODUCTS VALUES(5, 420.00, 'Testosteron');
INSERT INTO PRODUCTS VALUES(6, 2137.99, 'Sztanga i gryf');
INSERT INTO SHOP_PRODUCTS VALUES (1, 1, 1);
INSERT INTO SHOP_PRODUCTS VALUES (2, 1, 2);
INSERT INTO SHOP_PRODUCTS VALUES (3, 1, 3);
INSERT INTO SHOP_PRODUCTS VALUES (4, 1, 4);
INSERT INTO SHOP_PRODUCTS VALUES (5, 1, 5);
INSERT INTO SHOP_PRODUCTS VALUES (6, 1, 6);
INSERT INTO SHOP_PRODUCTS VALUES (7, 2, 6);

---------------------------------------
--       INSERT INTO TRAINERS
---------------------------------------
INSERT INTO TRAINER VALUES(1, 'Kamil', 'Kowalewski', 5, '485695485', 'kamilKow@gmail.com');
INSERT INTO TRAINER VALUES(2, 'Artur', 'Rejment', 1, '600096864', 'rejmencik@gamil.com');
INSERT INTO TRAINER VALUES(3, 'Sowa', 'Sowa?', 2, '256384569', 'sowa@getto.com');
INSERT INTO TRAINER VALUES(4, 'Krzysztof', 'Farys', 3, '789513462', 'magicznyFaryso@onet.pl');
INSERT INTO TRAINER VALUES(5, 'Krystyna', 'Stecka', 4, '132568489', 'k.stecka@wp.pl');

--------------------------------------
--    INSERT INTO GYM_MEMBERS
--------------------------------------
INSERT INTO GYM_MEMBER
VALUES(1, 'Bob', 'Smith', 2, '845684265', 'bobSmith@gmail.com');
INSERT INTO GYM_MEMBER
VALUES(2, 'John', 'Mark', 4, '841184265', 'johnMark@gmail.com');
INSERT INTO GYM_MEMBER
VALUES(3, 'Jan', 'Kowalski', 1, '666684265', 'janKow@gmail.com');
INSERT INTO GYM_MEMBER
VALUES(4, 'Magnum', 'Carlos', 1, '465218649', 'magnumCarlos@gmail.com');

--------------------------------------
-- INSERT INTO GRUOP TRAININGS
--------------------------------------
INSERT INTO GROUP_TRAINING
VALUES(1, 'Zumba z Arczim', 2, 1);
INSERT INTO GROUP_TRAINING
VALUES(2, 'Wyciskanie z Sowa', 3, 3);
INSERT INTO GROUP_TRAINING
VALUES(3, 'Joga bez maty', 4, 6);
INSERT INTO GROUP_TRAINING
VALUES(4, 'Blitz z Hikaru', 1, 12);

--------------------------------------
-- INSERT INTO GROUP TRAININGS SCHEDULE
---------------------------------------
INSERT INTO GROUP_TRAINING_SCHEDULE
VALUES(1, 1, 1);
INSERT INTO GROUP_TRAINING_SCHEDULE
VALUES(2, 1, 3);
INSERT INTO GROUP_TRAINING_SCHEDULE
VALUES(3, 1, 4);
INSERT INTO GROUP_TRAINING_SCHEDULE
VALUES(4, 2, 2);
INSERT INTO GROUP_TRAINING_SCHEDULE
VALUES(5, 2, 1);
INSERT INTO GROUP_TRAINING_SCHEDULE
VALUES(6, 3, 4);
INSERT INTO GROUP_TRAINING_SCHEDULE
VALUES(7, 4, 3);

--------------------------------------
--     INSERT INTO SHIFTS
--------------------------------------
INSERT INTO TRAINER_HOURS VALUES(1, 1, 1, NULL, 0, 0);
INSERT INTO TRAINER_HOURS VALUES(2, 1, 2,NULL, 0, 0);
INSERT INTO TRAINER_HOURS VALUES(3, 1, 3,NULL, 0, 0);
INSERT INTO TRAINER_HOURS VALUES(4, 1, 4,NULL, 0, 0);
INSERT INTO TRAINER_HOURS VALUES(5, 1, 5,NULL, 1, 0);
INSERT INTO TRAINER_HOURS VALUES(6, 1, 6, NULL,1, 0);
INSERT INTO TRAINER_HOURS VALUES(7, 1, 7,NULL, 1, 0);
--
INSERT INTO TRAINER_HOURS VALUES(8, 2, 1,NULL, 1, 0);
INSERT INTO TRAINER_HOURS VALUES(9, 2, 2, NULL,1, 0);
INSERT INTO TRAINER_HOURS VALUES(10, 2, 3,NULL, 0, 0);
INSERT INTO TRAINER_HOURS VALUES(11, 2, 4,NULL, 1, 0);
INSERT INTO TRAINER_HOURS VALUES(12, 2, 5,NULL, 0, 0);
INSERT INTO TRAINER_HOURS VALUES(13, 2, 6,NULL, 1, 0);
INSERT INTO TRAINER_HOURS VALUES(14, 2, 7,NULL, 1, 0);
INSERT INTO TRAINER_HOURS VALUES(15, 2, 8,NULL, 1, 0);
--
INSERT INTO TRAINER_HOURS VALUES(16, 3, 9,NULL, 1, 0);
INSERT INTO TRAINER_HOURS VALUES(17, 3, 10,NULL, 1, 0);
INSERT INTO TRAINER_HOURS VALUES(18, 3, 11, 1, 1, 1);
INSERT INTO TRAINER_HOURS VALUES(19, 3, 12, 3, 1, 1);
INSERT INTO TRAINER_HOURS VALUES(20, 3, 13,NULL, 1, 0);
INSERT INTO TRAINER_HOURS VALUES(21, 3, 14,NULL, 0, 0);
INSERT INTO TRAINER_HOURS VALUES(22, 3, 15,NULL, 1, 0);
--
INSERT INTO TRAINER_HOURS VALUES(23, 4, 9,NULL, 1, 0);
INSERT INTO TRAINER_HOURS VALUES(24, 4, 10,NULL, 1, 0);
INSERT INTO TRAINER_HOURS VALUES(25, 4, 11,NULL, 1, 0);
INSERT INTO TRAINER_HOURS VALUES(26, 4, 12,NULL, 1, 0);
INSERT INTO TRAINER_HOURS VALUES(27, 4, 13,NULL, 1, 0);
INSERT INTO TRAINER_HOURS VALUES(28, 4, 14, 2, 1, 1);
INSERT INTO TRAINER_HOURS VALUES(29, 4, 15,NULL, 1, 0);
--
INSERT INTO TRAINER_HOURS VALUES(30, 5, 3,NULL, 0, 0);
INSERT INTO TRAINER_HOURS VALUES(31, 5, 6,NULL, 0, 0);
INSERT INTO TRAINER_HOURS VALUES(32, 5, 5,NULL, 1, 0);
INSERT INTO TRAINER_HOURS VALUES(33, 5, 7, 1, 1, 1);
INSERT INTO TRAINER_HOURS VALUES(34, 5, 1,NULL, 1, 0);
INSERT INTO TRAINER_HOURS VALUES(35, 5, 11,NULL, 1, 0);
INSERT INTO TRAINER_HOURS VALUES(36, 5, 13,NULL, 1, 0);


commit;
SELECT FIRST_NAME, START_TIME FROM TRAINER_HOURS
JOIN TRAINER USING(TRAINER_ID)
JOIN WORKING_HOURS USING(WORKING_ID)
WHERE IS_TAKEN = 1;
