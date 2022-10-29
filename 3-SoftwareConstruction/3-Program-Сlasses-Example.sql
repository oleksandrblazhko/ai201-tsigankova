sqlplus student/p1234@localhost:1521/XEPDB1
SET SERVEROUTPUT ON
SET LINESIZE 2000
SET PAGESIZE 100

/* Створення об'єктного типу (класу) Employee */
CREATE OR REPLACE TYPE Employee AS OBJECT (
    employee_id NUMBER(4), -- N співробітника
	  surname VARCHAR(20), -- прізвище співробітника
	  name VARCHAR(20), -- ім'я співробітника
	  patronymic VARCHAR(20), -- по-батькові співробітника
	  work_experience NUMBER(2), -- досвід (у роках) співробітника
	  salary NUMBER(6,2), -- з/п співробітника
	  email_address_id NUMBER(4), -- N email адреси співробітника
	  weather_forecast_id NUMBER(10), -- N прогнозу погоди
	  experiment_id NUMBER(10), -- N експерименту
	  office_worker_id NUMBER(4) -- N офісного робітника
    NOT FINAL MEMBER PROCEDURE display
) NOT FINAL 
/

/* Створення типу для зберігання списку співробітників - "Колекція екземплярів об`єктів класу Employee */
CREATE TYPE Employee_List IS TABLE OF Employee;
/

/* Cтворення об'єктного типу (класу) Office_worker, що успадковує об'єктний тип Employee */
CREATE OR REPLACE TYPE Office_worker UNDER Employee (
   office_worker_id NUMBER(4), -- N офісного робітника
	  surname VARCHAR(20), -- прізвище офісного робітника
	  name VARCHAR(20), -- ім'я офісного робітника
	  patronymic VARCHAR(20), -- по-батькові офісного робітника
	  email_address_id NUMBER(4), -- N email адреси офісного робітника
	  request_id NUMBER(10) -- N запиту
	  /* перевизначення методу-процедури класу Employee */
    OVERRIDING MEMBER PROCEDURE display 
);
/
