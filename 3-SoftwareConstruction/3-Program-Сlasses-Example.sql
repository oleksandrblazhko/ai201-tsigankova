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

/* Створення об'єктного типу (клас) Weather_forecast */
-- DROP TYPE Weather_forecast FORCE;
CREATE OR REPLACE TYPE Weather_forecast AS OBJECT (
    	weather_forecast_id NUMBER(10), -- N прогнозу погоди
	wf_date DATE, -- дата прогнозу погоди
	wf_time TIME, -- час прогнозу погоди
	experiment_id NUMBER(10) -- N експерименту
    	/* конструктор екземплярів об'єктів класів.
       	Вхідні параметри:
	   1) p_wf_date - дата прогнозу погоди
	   умова 1) якщо в таблиці Weather_forecast вже існує вказана дата,
	   створюється екземпляр класу на основі даних таблиці,
	   інакше в таблиці Weather_forecast створюється новий рядок з одночасним
	   створюється екземпляр класу 
	 Вихідний параметр - екземпляр обєкту класу */
    	CONSTRUCTOR FUNCTION Weather_forecast(p_wf_date DATE)
        	RETURN SELF AS RESULT,
		/* Процедура зміни значення атрибутів */
		MEMBER PROCEDURE set_wf_date(p_weather_forecast_id NUMBER, p_wf_date DATE),
    		/* Функції отримання значень атрибутів */
		MEMBER FUNCTION get_weather_forecast_id RETURN NUMBER,
		MEMBER FUNCTION get_wf_date RETURN DATE,
    	/* Процедура виводу на екран значень атрибутів */
    	MEMBER PROCEDURE display
); 
/
-- show errors;

/* Створення об'єктного типу (класу) Experiment */
CREATE OR REPLACE TYPE Experiment AS OBJECT (
    	experiment_id NUMBER(10), -- N експерименту
	exp_research VARCHAR(100), -- дослід експерименту
	exp_result VARCHAR(100), -- результат експерименту
	indicators_list_id NUMBER(10) -- N списку змін індикаторів
	/* конструктор екземплярів об'єктів класів.
       	Вхідні параметри:
	   1) p_exp_research - дослід експерименту
	   умова 1) якщо в таблиці Experiment вже існує вказаний дослід,
	   створюється екземпляр класу на основі даних таблиці,
	   інакше в таблиці Experiment створюється новий рядок з одночасним
	   створюється екземпляр класу 
	 Вихідний параметр - екземпляр обєкту класу */
    	CONSTRUCTOR FUNCTION Experiment(p_exp_research VARCHAR)
        	RETURN SELF AS RESULT,
		/* Процедура зміни значення атрибутів */
		MEMBER PROCEDURE set_exp_research(p_experiment_id NUMBER, p_exp_research VARCHAR),
    		/* Функції отримання значень атрибутів */
		MEMBER FUNCTION get_experiment_id RETURN NUMBER,
		MEMBER FUNCTION get_exp_research RETURN VARCHAR,
	/* Процедура виводу на екран значень атрибутів */
    	MEMBER PROCEDURE display
); 
/

/* Створення об'єктного типу (класу) Equipment_indicators */
CREATE OR REPLACE TYPE Equipment_indicators AS OBJECT (
    	indicators_list_id NUMBER(10), -- N списку змін індикаторів
	air_temperature NUMBER(3,1), -- показник температури повітря
	air_humidity NUMBER(2), -- показник вологості повітря
	pressure NUMBER(5,2), -- показник тиску
	wind_direction VARCHAR(20), -- показник напряму вітру
	wind_power NUMBER(2), -- показник сили вітру
	/* Процедура виводу на екран значень атрибутів */
    	MEMBER PROCEDURE display
); 
/

/* Створення об'єктного типу (класу) Laboratory_equipment */
CREATE OR REPLACE TYPE Laboratory_equipment AS OBJECT (
    	laboratory_equipment_id NUMBER(2), -- N лабораторного обладнання
	list_of_changes VARCHAR(100), -- список змін показників обладнання
	indicators_list_id NUMBER(10), -- N списку змін індикаторів
	/* конструктор екземплярів об'єктів класів.
       	Вхідні параметри:
	   1) p_list_of_changes - список змін показників обладнання
	   умова 1) якщо в таблиці Laboratory_equipment вже існує вказаний список,
	   створюється екземпляр класу на основі даних таблиці,
	   інакше в таблиці Laboratory_equipment створюється новий рядок з одночасним
	   створюється екземпляр класу 
	 Вихідний параметр - екземпляр обєкту класу */
    	CONSTRUCTOR FUNCTION Laboratory_equipment(p_list_of_changes VARCHAR)
        	RETURN SELF AS RESULT,
		/* Процедура зміни значення атрибутів */
		MEMBER PROCEDURE set_list_of_changes(p_laboratory_equipment_id NUMBER, p_list_of_changes VARCHAR),
    		/* Функції отримання значень атрибутів */
		MEMBER FUNCTION get_laboratory_equipment_id RETURN NUMBER,
		MEMBER FUNCTION get_list_of_changes RETURN VARCHAR,
	/* Процедура виводу на екран значень атрибутів */
    	MEMBER PROCEDURE display
); 
/

/* Створення об'єктного типу (класу) Searching_system */
CREATE OR REPLACE TYPE Searching_system AS OBJECT (
    	request_id NUMBER(10), -- N запиту
	request VARCHAR(100) -- запит
	/* Процедура виводу на екран значень атрибутів */
    	MEMBER PROCEDURE display
); 
/

/* Створення об'єктного типу (класу) Online_message */
CREATE OR REPLACE TYPE Online_message AS OBJECT (
    	online_message_id NUMBER(10), -- N онлайн-повідомлення
	message_text VARCHAR(200), -- текст онлайн-повідомлення
	sender_email_address_id NUMBER(4), -- N email адреси відправника
	receiver_email_address_id NUMBER(4), -- N email адреси отримувача
	/* Процедура виводу на екран значень атрибутів */
    	MEMBER PROCEDURE display
); 
/
