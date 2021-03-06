DROP TABLE TRAINER_HOURS CASCADE;
DROP TABLE GROUP_TRAINING CASCADE;
DROP TABLE WORKING_HOURS CASCADE;
DROP TABLE GROUP_TRAINING_SCHEDULE CASCADE;
DROP TABLE TRAINER CASCADE;
DROP TABLE SHOP_PRODUCTS CASCADE;
DROP TABLE SHOP CASCADE;
DROP TABLE PRODUCTS CASCADE;
DROP TABLE MEMBERSHIP CASCADE;
DROP TABLE GYM_MEMBER CASCADE;
DROP TABLE ADDRESS CASCADE;
DROP TABLE PERSONAL_DATA CASCADE;
DROP TABLE MEMBER_MEMBERSHIPS CASCADE;
DROP TABLE RECEPTIONIST CASCADE;

CREATE TABLE ADDRESS (
	ADDRESS_ID SERIAL,
	POSTCODE VARCHAR(20) NOT NULL,
	CITY VARCHAR(20) NOT NULL,
	STREET VARCHAR(20) NOT NULL,
	CONSTRAINT ADDRESS_PK PRIMARY KEY(ADDRESS_ID)
);

CREATE TABLE PERSONAL_DATA(
	PERSONAL_DATA_ID SERIAL,
	FIRST_NAME VARCHAR(30) NOT NULL,
    LAST_NAME VARCHAR(30) NOT NULL,
    ADDRESS_ID INTEGER NOT NULL,
    PHONE_NUMBER VARCHAR(9),
    EMAIL VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT PERSONAL_DATA_PK PRIMARY KEY (PERSONAL_DATA_ID),
    CONSTRAINT PERSONAL_DATA_ADDRESS_FK FOREIGN KEY (ADDRESS_ID) REFERENCES ADDRESS(ADDRESS_ID)
);

--------------------------------------
-- CREATE TRAINER
--------------------------------------
CREATE TABLE TRAINER (
    TRAINER_ID SERIAL,
    PERSONAL_DATA_ID INTEGER NOT NULL,
    NUMBER_OF_CERTIFICATIONS INTEGER,
    CONSTRAINT TRAINER_PK PRIMARY KEY (TRAINER_ID),
    CONSTRAINT TRAINER_PERSONAL_DATA_FK FOREIGN KEY (PERSONAL_DATA_ID) REFERENCES PERSONAL_DATA(PERSONAL_DATA_ID),
    CONSTRAINT TRAINER_NUMBER_OF_CERTIFICATIONS_CHECK CHECK(NUMBER_OF_CERTIFICATIONS >= 0)
);

--------------------------------------
-- CREATE GYM MEMBER
--------------------------------------
CREATE TABLE GYM_MEMBER (
    MEMBER_ID SERIAL,
    PERSONAL_DATA_ID INTEGER NOT NULL,
    SIGN_UP_DATE DATE NOT NULL,
    IS_SUSPENDED BOOLEAN,
    CONSTRAINT MEMBER_PK PRIMARY KEY(MEMBER_ID),
    CONSTRAINT MEMBER_PERSONAL_DATA_FK FOREIGN KEY (PERSONAL_DATA_ID) REFERENCES PERSONAL_DATA(PERSONAL_DATA_ID)
);

-------------------------------------
-- CREATE RECEPTIONIST
-------------------------------------
CREATE TABLE RECEPTIONIST(
    RECEPTIONIST_ID SERIAL,
    PERSONAL_DATA_ID INTEGER NOT NULL,
    IS_SENIOR_RECEPTIONIST BOOLEAN,
    CONSTRAINT RECEPTIONIST_PK PRIMARY KEY (RECEPTIONIST_ID),
    CONSTRAINT RECEPTIONIST_PERSONAL_DATA FOREIGN KEY(PERSONAL_DATA_ID) REFERENCES PERSONAL_DATA(PERSONAL_DATA_ID)
);

--------------------------------------
-- CREATE MEMBERSHIP
--------------------------------------
CREATE TABLE MEMBERSHIP (
    MEMBERSHIP_ID SERIAL,
    MEMBERSHIP_TYPE VARCHAR(30) NOT NULL,
    MEMBERSHIP_PRICE NUMERIC NOT NULL,
    CONSTRAINT MEMBERSHIP_PK PRIMARY KEY(MEMBERSHIP_ID)
);

--------------------------------------
-- CREATE MEMBER_MEMBERSHIPS
--------------------------------------
CREATE TABLE MEMBER_MEMBERSHIPS(
    MEMBER_MEMBERSHIPS_ID SERIAL,
    MEMBERSHIP_ID INTEGER NOT NULL,
    MEMBER_ID INTEGER NOT NULL,
    PURCHASE_DATE DATE NOT NULL,
    EXPIRY_DATE DATE NOT NULL,
    CONSTRAINT MEMBER_MEMBERSHIPS_PK PRIMARY KEY(MEMBER_MEMBERSHIPS_ID),
    CONSTRAINT MEMBER_MEMBERSHIPS_MEMBERSHIP_FK FOREIGN KEY (MEMBERSHIP_ID) REFERENCES MEMBERSHIP(MEMBERSHIP_ID),
    CONSTRAINT MEMBER_MEMBERSHIPS_MEMBER_FK FOREIGN KEY (MEMBER_ID) REFERENCES GYM_MEMBER(MEMBER_ID)
);

--------------------------------------
-- CREATE WORKING HOURS
--------------------------------------
CREATE TABLE WORKING_HOURS(
    WORKING_ID SERIAL,
    START_TIME VARCHAR(5) NOT NULL,
    FINISH_TIME VARCHAR(5) NOT NULL,
    CONSTRAINT WORKING_PK PRIMARY KEY(WORKING_ID)
);

-------------------------------------
-- CREATE GROUP TRAINING
-------------------------------------
CREATE TABLE GROUP_TRAINING(
    GROUP_TRAINING_ID SERIAL,
    GROUP_TRAINING_NAME VARCHAR(30) NOT NULL,
    TRAINER_ID INTEGER NOT NULL,
    WORKING_ID INTEGER NOT NULL,
    CONSTRAINT GROUP_TRAINING_PK PRIMARY KEY(GROUP_TRAINING_ID),
    CONSTRAINT TRAINER_GROUP_FK FOREIGN KEY (TRAINER_ID) REFERENCES TRAINER(TRAINER_ID),
    CONSTRAINT WORKING_GROUP_FK FOREIGN KEY (WORKING_ID) REFERENCES WORKING_HOURS(WORKING_ID)
);

--------------------------------------
-- CREATE SCHEDULE FOR GROUP TRAININGS
--------------------------------------
CREATE TABLE GROUP_TRAINING_SCHEDULE(
    GROUP_TRAINING_SCHEDULE_ID SERIAL,
    GROUP_TRAINING_ID INTEGER NOT NULL,
    MEMBER_ID INTEGER NOT NULL,
    CONSTRAINT GROUP_TRAINING_SCHEDULE_PK PRIMARY KEY(GROUP_TRAINING_SCHEDULE_ID),
    CONSTRAINT GROUP_TRAINING_FK FOREIGN KEY(GROUP_TRAINING_ID) REFERENCES GROUP_TRAINING(GROUP_TRAINING_ID),
    CONSTRAINT GROUP_MEMBER_FK FOREIGN KEY(MEMBER_ID) REFERENCES GYM_MEMBER(MEMBER_ID)
);

--------------------------------------
-- CREATE SCHEDULE HOUR FOR TAINERS
--------------------------------------
CREATE TABLE TRAINER_HOURS (
    SHIFT_ID SERIAL,
    TRAINER_ID INTEGER NOT NULL,
    WORKING_ID INTEGER NOT NULL,
    MEMBER_ID INTEGER,
    IS_ACTIVE BOOLEAN,
    CONSTRAINT SHIFT_PK PRIMARY KEY(SHIFT_ID),
    CONSTRAINT TRAINER_HOURS_FK FOREIGN KEY (TRAINER_ID) REFERENCES TRAINER(TRAINER_ID),
    CONSTRAINT WORKING_HOURS_FK FOREIGN KEY (WORKING_ID) REFERENCES WORKING_HOURS(WORKING_ID),
    CONSTRAINT MEMBER_HOURS_FK FOREIGN KEY (MEMBER_ID) REFERENCES GYM_MEMBER(MEMBER_ID)
);

--------------------------------------
-- CREATE SHOP
--------------------------------------
CREATE TABLE SHOP (
    SHOP_ID SERIAL,
    SHOP_NAME VARCHAR(20) NOT NULL,
    ADDRESS_ID INTEGER,
    CONSTRAINT SHOP_PK PRIMARY KEY(SHOP_ID),
    CONSTRAINT SHOP_ADDRESS_FK FOREIGN KEY (ADDRESS_ID) REFERENCES ADDRESS(ADDRESS_ID)
);

--------------------------------------
-- CREATE PRODUCTS FOR THE SHOP
--------------------------------------
CREATE TABLE PRODUCTS(
    PRODUCT_ID SERIAL,
    PRODUCT_PRICE NUMERIC NOT NULL,
    PRODUCT_NAME VARCHAR(20) NOT NULL,
    CONSTRAINT PRODUCT_PK PRIMARY KEY(PRODUCT_ID)
);

--------------------------------------
-- CREATE LIST OF PRODUCTS
--------------------------------------
CREATE TABLE SHOP_PRODUCTS (
    LISTING_ID SERIAL,
    SHOP_ID INTEGER NOT NULL,
    PRODUCT_ID INTEGER NOT NULL,
    PRODUCT_AMOUNT INTEGER NOT NULL,
    CONSTRAINT LISTING_PK PRIMARY KEY(LISTING_ID),
    CONSTRAINT SHOP_LIST_FK FOREIGN KEY(SHOP_ID) REFERENCES SHOP(SHOP_ID),
    CONSTRAINT PRODUCT_LIST FOREIGN KEY(PRODUCT_ID) REFERENCES PRODUCTS(PRODUCT_ID),
    CONSTRAINT PRODUCT_AMOUNT_CHECK CHECK(PRODUCT_AMOUNT >= 0)
);

INSERT INTO MEMBERSHIP(MEMBERSHIP_ID, MEMBERSHIP_TYPE, MEMBERSHIP_PRICE)
VALUES(1, 'Open 24', 145.99);
INSERT INTO MEMBERSHIP(MEMBERSHIP_ID, MEMBERSHIP_TYPE, MEMBERSHIP_PRICE) 
VALUES(2, 'Uczniowski', 79.99);
INSERT INTO MEMBERSHIP(MEMBERSHIP_ID, MEMBERSHIP_TYPE, MEMBERSHIP_PRICE) 
VALUES(3, 'Studencki', 89.99);
INSERT INTO MEMBERSHIP(MEMBERSHIP_ID, MEMBERSHIP_TYPE, MEMBERSHIP_PRICE)
VALUES(4, 'Zajecia grupowe', 145.99);
INSERT INTO MEMBERSHIP(MEMBERSHIP_ID, MEMBERSHIP_TYPE, MEMBERSHIP_PRICE)
VALUES(5, 'Sauna Open', 49.99);

-----------------------------------------
--       INSERTING INTO ADDRESSES
-----------------------------------------
INSERT INTO ADDRESS(ADDRESS_ID, POSTCODE, CITY, STREET)
VALUES (1, '77-256', 'Lubsza', 'Piastowice 48a');
INSERT INTO ADDRESS VALUES (2, '47-224', 'Kedzierzyn-Kozle', 'Tartaczna 5/3');
INSERT INTO ADDRESS VALUES (3, '47-224', 'Kedzierzyn-Kozle', 'Kozielska 2');
INSERT INTO ADDRESS VALUES (4, '37-255', 'Wroclaw', 'Gornickiego 35');
INSERT INTO ADDRESS VALUES (5, '21-556', 'Opole', 'Dubois 5');
INSERT INTO ADDRESS VALUES (6, '32-123', 'Grzybnia', '15');
INSERT INTO ADDRESS VALUES (7, '33-789', 'Kadlub Turawski', '2');
INSERT INTO ADDRESS VALUES (8, '75-226', 'Wroclaw', 'Katowicka 14');
INSERT INTO ADDRESS VALUES (9, '71-956', 'Gdynia', 'Polna 7a');
INSERT INTO ADDRESS VALUES (10, '48-221', 'Kedzierzyn-Kozle', 'Gliwicka 8');
INSERT INTO ADDRESS VALUES (11, '14-226', 'Zawada', 'Parkowa 18');
INSERT INTO ADDRESS VALUES (12, '15-365', 'Raszowa', 'Akacjowa 7');
INSERT INTO ADDRESS VALUES (13, '16-845', 'Sopot', 'Sosnowa 158');
INSERT INTO ADDRESS VALUES (14, '71-625', 'Zakopane', 'Ogrodowa 2');
INSERT INTO ADDRESS VALUES (15, '74-625', 'Ustrzyki Dolne', 'Polna 19');
INSERT INTO ADDRESS VALUES (16, '65-485', 'Sopot', 'Zielona 3');
INSERT INTO ADDRESS VALUES (17, '48-625', 'Opole', 'Krakowska 89d');
INSERT INTO ADDRESS VALUES (18, '84-212', 'Bialystok', 'Szkolna 12');
INSERT INTO ADDRESS VALUES (19, '14-695', 'Wroclaw', 'Sosnowa 9/5');
INSERT INTO ADDRESS VALUES (20, '16-685', 'Wroclaw', 'Ogrodowa 7');
INSERT INTO ADDRESS VALUES (21, '19-658', 'Opole', 'Lipowa 3');
INSERT INTO ADDRESS VALUES (22, '34-485', 'Krakow', 'Sloneczna 15');
INSERT INTO ADDRESS VALUES (23, '15-885', 'Krakow', 'Polna 95c');
INSERT INTO ADDRESS VALUES (24, '15-885', 'Krakow', 'Polna 15e');


----------------------------------------
-- INSERTING INTO PERSONAL DATA
----------------------------------------
INSERT INTO PERSONAL_DATA(PERSONAL_DATA_ID, FIRST_NAME, LAST_NAME, ADDRESS_ID, PHONE_NUMBER, EMAIL)
VALUES(1, 'Kamil', 'Kowalewski', 1, '158659426', 'kamilKow@gmail.com');
INSERT INTO PERSONAL_DATA VALUES(2, 'Artur', 'Rejment', 2, '956428614', 'arturRejm@gmail.com');
INSERT INTO PERSONAL_DATA VALUES(3, 'Hikaru', 'Nakamura', 3, '846253145', 'hikaruNakam@gmail.com');
INSERT INTO PERSONAL_DATA VALUES(4, 'Sowa', 'Sowczak', 4, '846523419', 'sowaGetto@wp.pl');
INSERT INTO PERSONAL_DATA VALUES(5, 'Krystyna', 'Stecka', 5, '225486335', 'krystynaStec@gmail.com');
INSERT INTO PERSONAL_DATA VALUES(6, 'Andrzej', 'Baginski', 6, '846235114', 'andrzejBag@gmail.com');
INSERT INTO PERSONAL_DATA VALUES(7, 'Krzysztof', 'Farys', 7, '846951326', 'krzysztofFary@gmail.com');
INSERT INTO PERSONAL_DATA VALUES(8, 'Magnum', 'Carlos', 8, '114258647', 'magnumCarl@gmail.com');
INSERT INTO PERSONAL_DATA VALUES(9, 'Marianczello', 'Dominoni', 9, '994336512', 'marianczello@gmail.com');
INSERT INTO PERSONAL_DATA VALUES(10, 'Patryk', 'Lach', 10 , '158659426', 'patrykLach@gmail.com');
INSERT INTO PERSONAL_DATA VALUES(11, 'Giffy' ,' Tatton', 11 ,'245115590', 'gtatton0@bucket.com');
INSERT INTO PERSONAL_DATA VALUES(12, 'Shanda', 'Iddy', 12 , '980674371', 'siddy1@yellowbook.com');
INSERT INTO PERSONAL_DATA VALUES(13,'Courtnay', 'Lloyd', 13, '686194990', 'clloyd3@nytimes.com');
INSERT INTO PERSONAL_DATA VALUES(14, 'Babbette', 'Gewer' , 14, '71983962', 'bgewer8@utexas.edu');
INSERT INTO PERSONAL_DATA VALUES(15, 'Crissie', 'Perview', 15, '509075420', 'cperviewa@w3.org');
INSERT INTO PERSONAL_DATA VALUES(16, 'Adelaida', 'Conkay', 16, '519777852', 'aconkayb@hp.com');
INSERT INTO PERSONAL_DATA VALUES(17, 'Morry', 'Chainey', 17, '166507789', 'mchaineyd@rediff.com');
INSERT INTO PERSONAL_DATA VALUES(18, 'Jeffie', 'Dayton', 18, '172113953', 'jdaytonf@sohu.com');
INSERT INTO PERSONAL_DATA VALUES(19, 'Cindie', 'Brady', 19, '679742828', 'cbradyj@nps.gov');


----------------------------------------
--     INSERTING INTO WORKING HOURS
----------------------------------------
INSERT INTO WORKING_HOURS(WORKING_ID, START_TIME, FINISH_TIME) VALUES(1, '7:00', '8:00');
INSERT INTO WORKING_HOURS(WORKING_ID, START_TIME, FINISH_TIME) VALUES(2, '8:00', '9:00');
INSERT INTO WORKING_HOURS(WORKING_ID, START_TIME, FINISH_TIME) VALUES(3, '9:00', '10:00');
INSERT INTO WORKING_HOURS(WORKING_ID, START_TIME, FINISH_TIME) VALUES(4, '10:00', '11:00');
INSERT INTO WORKING_HOURS(WORKING_ID, START_TIME, FINISH_TIME) VALUES(5, '11:00', '12:00');
INSERT INTO WORKING_HOURS(WORKING_ID, START_TIME, FINISH_TIME) VALUES(6, '12:00', '13:00');
INSERT INTO WORKING_HOURS(WORKING_ID, START_TIME, FINISH_TIME) VALUES(7, '13:00', '14:00');
INSERT INTO WORKING_HOURS(WORKING_ID, START_TIME, FINISH_TIME) VALUES(8, '14:00', '15:00');
INSERT INTO WORKING_HOURS(WORKING_ID, START_TIME, FINISH_TIME) VALUES(9, '15:00', '16:00');
INSERT INTO WORKING_HOURS(WORKING_ID, START_TIME, FINISH_TIME) VALUES(10, '16:00', '17:00');
INSERT INTO WORKING_HOURS(WORKING_ID, START_TIME, FINISH_TIME) VALUES(11, '17:00', '18:00');
INSERT INTO WORKING_HOURS(WORKING_ID, START_TIME, FINISH_TIME) VALUES(12, '18:00', '19:00');
INSERT INTO WORKING_HOURS(WORKING_ID, START_TIME, FINISH_TIME) VALUES(13, '19:00', '20:00');
INSERT INTO WORKING_HOURS(WORKING_ID, START_TIME, FINISH_TIME) VALUES(14, '20:00', '21:00');
INSERT INTO WORKING_HOURS(WORKING_ID, START_TIME, FINISH_TIME) VALUES(15, '21:00', '22:00');

-----------------------------------------
--    INSERTING INTO SHOP
-----------------------------------------
INSERT INTO SHOP(SHOP_ID, SHOP_NAME, ADDRESS_ID) VALUES(1, 'Gym Fit Shop', NULL);
INSERT INTO SHOP(SHOP_ID, SHOP_NAME, ADDRESS_ID) VALUES(2, 'KFD Shop', 20);
INSERT INTO SHOP(SHOP_ID, SHOP_NAME, ADDRESS_ID) VALUES(3, 'Tesc Shop', 21);
INSERT INTO SHOP(SHOP_ID, SHOP_NAME, ADDRESS_ID) VALUES(4, 'SFD Centrum', 22);
INSERT INTO SHOP(SHOP_ID, SHOP_NAME, ADDRESS_ID) VALUES(5, 'Olimp Distro', 23);

-----------------------------------------
--    INSERTING INTO PRODUCTS
-----------------------------------------
INSERT INTO PRODUCTS(PRODUCT_ID, PRODUCT_PRICE, PRODUCT_NAME) VALUES(1, 80.00, 'Protein WPC 80%');
INSERT INTO PRODUCTS(PRODUCT_ID, PRODUCT_PRICE, PRODUCT_NAME) VALUES(2, 6.00, 'Dzik Energy');
INSERT INTO PRODUCTS(PRODUCT_ID, PRODUCT_PRICE, PRODUCT_NAME) VALUES(3, 2.49, 'Lody Ekipy');
INSERT INTO PRODUCTS(PRODUCT_ID, PRODUCT_PRICE, PRODUCT_NAME) VALUES(4, 59.99, 'Bomba');
INSERT INTO PRODUCTS(PRODUCT_ID, PRODUCT_PRICE, PRODUCT_NAME) VALUES(5, 420.00, 'Testosteron');
INSERT INTO PRODUCTS(PRODUCT_ID, PRODUCT_PRICE, PRODUCT_NAME) VALUES(6, 5.50, 'Woda');
INSERT INTO PRODUCTS(PRODUCT_ID, PRODUCT_PRICE, PRODUCT_NAME) VALUES(7, 2137.99, 'Sztanga i gryf');
INSERT INTO PRODUCTS(PRODUCT_ID, PRODUCT_PRICE, PRODUCT_NAME) VALUES(8, 15.59, 'Kreatyna 200g');
INSERT INTO PRODUCTS(PRODUCT_ID, PRODUCT_PRICE, PRODUCT_NAME) VALUES(9, 39.99, 'Cytrulina');
INSERT INTO PRODUCTS(PRODUCT_ID, PRODUCT_PRICE, PRODUCT_NAME) VALUES(10, 3.99, 'Baton proteinowy');

-----------------------------------------
--    INSERTING INTO SHOP_PRODUCTS
-----------------------------------------
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (1, 1, 1, 25);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (2, 1, 2, 30);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (3, 1, 3, 12);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (4, 1, 4, 2);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (5, 1, 5, 11);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (6, 1, 6, 7);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (8, 2, 6, 10);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (9, 2, 3, 15);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (10, 2, 4, 26);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (11, 3, 5, 54);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (12, 4, 2, 18);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (13, 4, 4, 7);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (14, 4, 6, 3);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (15, 5, 1, 15);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (16, 5, 2, 45);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (17, 5, 3, 14);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (18, 5, 4, 26);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (19, 5, 5, 45);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (20, 1, 8, 2);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (21, 2, 9, 12);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (22, 3, 5, 3);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (23, 4, 8, 18);
INSERT INTO SHOP_PRODUCTS(LISTING_ID, SHOP_ID, PRODUCT_ID, PRODUCT_AMOUNT) VALUES (24, 1, 7, 32);


---------------------------------------
--     INSERTING INTO TRAINERS
---------------------------------------
INSERT INTO TRAINER(TRAINER_ID, PERSONAL_DATA_ID, NUMBER_OF_CERTIFICATIONS) VALUES(1, 1, 3);
INSERT INTO TRAINER(TRAINER_ID, PERSONAL_DATA_ID, NUMBER_OF_CERTIFICATIONS) VALUES(2, 2, 5);
INSERT INTO TRAINER(TRAINER_ID, PERSONAL_DATA_ID, NUMBER_OF_CERTIFICATIONS) VALUES(3, 3, 1);
INSERT INTO TRAINER(TRAINER_ID, PERSONAL_DATA_ID, NUMBER_OF_CERTIFICATIONS) VALUES(4, 4, 15);
INSERT INTO TRAINER(TRAINER_ID, PERSONAL_DATA_ID, NUMBER_OF_CERTIFICATIONS) VALUES(5, 5, 4);

--------------------------------------
--    INSERTING INTO GYM_MEMBERS
--------------------------------------
INSERT INTO GYM_MEMBER(MEMBER_ID, PERSONAL_DATA_ID, SIGN_UP_DATE, IS_SUSPENDED)
VALUES(1, 6,  date '2020-12-05', false);
INSERT INTO GYM_MEMBER(MEMBER_ID, PERSONAL_DATA_ID, SIGN_UP_DATE, IS_SUSPENDED)
VALUES(2, 7,  date '2019-11-02', false);
INSERT INTO GYM_MEMBER(MEMBER_ID, PERSONAL_DATA_ID, SIGN_UP_DATE, IS_SUSPENDED)
VALUES(3, 8,  date '2018-10-28', false);
INSERT INTO GYM_MEMBER(MEMBER_ID, PERSONAL_DATA_ID, SIGN_UP_DATE, IS_SUSPENDED)
VALUES(4, 9,  date '2021-05-05', false);
INSERT INTO GYM_MEMBER(MEMBER_ID, PERSONAL_DATA_ID, SIGN_UP_DATE, IS_SUSPENDED)
VALUES(5, 10,  date '2021-01-01', true);
INSERT INTO GYM_MEMBER(MEMBER_ID, PERSONAL_DATA_ID, SIGN_UP_DATE, IS_SUSPENDED)
VALUES(6, 11,  date '2021-02-13', false);
INSERT INTO GYM_MEMBER(MEMBER_ID, PERSONAL_DATA_ID, SIGN_UP_DATE, IS_SUSPENDED)
VALUES(7, 12,  date '2019-04-15', false);
INSERT INTO GYM_MEMBER(MEMBER_ID, PERSONAL_DATA_ID, SIGN_UP_DATE, IS_SUSPENDED)
VALUES(8, 13,  date '2017-11-12', false);
INSERT INTO GYM_MEMBER(MEMBER_ID, PERSONAL_DATA_ID, SIGN_UP_DATE, IS_SUSPENDED)
VALUES(9, 19,  date '2020-12-15', false);

--------------------------------------
-- INSERTING INTO RECEPTIONIST
--------------------------------------
INSERT INTO RECEPTIONIST(PERSONAL_DATA_ID, IS_SENIOR_RECEPTIONIST) 
VALUES(14, true);
INSERT INTO RECEPTIONIST(RECEPTIONIST_ID, PERSONAL_DATA_ID, IS_SENIOR_RECEPTIONIST) 
VALUES(2, 15, false);
INSERT INTO RECEPTIONIST(RECEPTIONIST_ID, PERSONAL_DATA_ID, IS_SENIOR_RECEPTIONIST) 
VALUES(3, 16, false);
INSERT INTO RECEPTIONIST(RECEPTIONIST_ID, PERSONAL_DATA_ID, IS_SENIOR_RECEPTIONIST) 
VALUES(4, 17, false);
INSERT INTO RECEPTIONIST(RECEPTIONIST_ID, PERSONAL_DATA_ID, IS_SENIOR_RECEPTIONIST) 
VALUES(5, 18, true);

--------------------------------------
-- INSERTING INTO GRUOP TRAININGS
--------------------------------------
INSERT INTO GROUP_TRAINING(GROUP_TRAINING_ID, GROUP_TRAINING_NAME, TRAINER_ID, WORKING_ID)
VALUES(1, 'Zumba z Arczim', 2, 1);
INSERT INTO GROUP_TRAINING(GROUP_TRAINING_ID, GROUP_TRAINING_NAME, TRAINER_ID, WORKING_ID)
VALUES(2, 'Wyciskanie z Sowa', 4, 3);
INSERT INTO GROUP_TRAINING(GROUP_TRAINING_ID, GROUP_TRAINING_NAME, TRAINER_ID, WORKING_ID)
VALUES(3, 'Joga bez Maty', 1, 6);
INSERT INTO GROUP_TRAINING(GROUP_TRAINING_ID, GROUP_TRAINING_NAME, TRAINER_ID, WORKING_ID)
VALUES(4, 'Blitz z Hikaru', 3, 12);
INSERT INTO GROUP_TRAINING(GROUP_TRAINING_ID, GROUP_TRAINING_NAME, TRAINER_ID, WORKING_ID)
VALUES(5, 'Bulgarski przysiad z Krysia', 5, 7);

--------------------------------------
-- INSERTING INTO GROUP TRAININGS SCHEDULE
---------------------------------------
INSERT INTO GROUP_TRAINING_SCHEDULE(GROUP_TRAINING_SCHEDULE_ID, GROUP_TRAINING_ID, MEMBER_ID)
VALUES(1, 1, 1);
INSERT INTO GROUP_TRAINING_SCHEDULE(GROUP_TRAINING_SCHEDULE_ID, GROUP_TRAINING_ID, MEMBER_ID)
VALUES(2, 1, 3);
INSERT INTO GROUP_TRAINING_SCHEDULE(GROUP_TRAINING_SCHEDULE_ID, GROUP_TRAINING_ID, MEMBER_ID)
VALUES(3, 1, 4);
INSERT INTO GROUP_TRAINING_SCHEDULE(GROUP_TRAINING_SCHEDULE_ID, GROUP_TRAINING_ID, MEMBER_ID)
VALUES(4, 2, 2);
INSERT INTO GROUP_TRAINING_SCHEDULE(GROUP_TRAINING_SCHEDULE_ID, GROUP_TRAINING_ID, MEMBER_ID)
VALUES(5, 2, 1);
INSERT INTO GROUP_TRAINING_SCHEDULE(GROUP_TRAINING_SCHEDULE_ID, GROUP_TRAINING_ID, MEMBER_ID)
VALUES(6, 3, 4);
INSERT INTO GROUP_TRAINING_SCHEDULE(GROUP_TRAINING_SCHEDULE_ID, GROUP_TRAINING_ID, MEMBER_ID)
VALUES(7, 4, 3);

--------------------------------------
--   INSERTING INTO SHIFTS
--------------------------------------
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(1, 1, 1, NULL, false);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(2, 1, 2,NULL, false);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(3, 1, 3,NULL, false);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(4, 1, 4,NULL, false);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(5, 1, 5,NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(6, 1, 6, NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(7, 1, 7,NULL, true);
--
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(8, 2, 1,NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(9, 2, 2, NULL,true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(10, 2, 3,NULL, false);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(11, 2, 4,NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(12, 2, 5,NULL, false);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(13, 2, 6,NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(14, 2, 7,NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(15, 2, 8,NULL, true);
--
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(16, 3, 9,NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(17, 3, 10,NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(18, 3, 11, 1, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(19, 3, 12, 3, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(20, 3, 13,NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(21, 3, 14,NULL, false);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(22, 3, 15,NULL, true);
--
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(23, 4, 9,NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(24, 4, 10,NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(25, 4, 11,NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(26, 4, 12,NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(27, 4, 13,NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(28, 4, 14, 2, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(29, 4, 15,NULL, true);
--
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(30, 5, 3,NULL, false);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(31, 5, 6,NULL, false);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(32, 5, 5,NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(33, 5, 7, 1, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(34, 5, 1,NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(35, 5, 11,NULL, true);
INSERT INTO TRAINER_HOURS(SHIFT_ID, TRAINER_ID, WORKING_ID, MEMBER_ID, IS_ACTIVE) VALUES(36, 5, 13,NULL, true);

-------------------------------------
-- INSERTING INTO MEMBER_MEMBERSHIPS
-------------------------------------
INSERT INTO MEMBER_MEMBERSHIPS(MEMBER_MEMBERSHIPS_ID, MEMBERSHIP_ID, MEMBER_ID, PURCHASE_DATE, EXPIRY_DATE) 
VALUES(1, 1, 3, date '2020-12-05', date '2021-01-05');


