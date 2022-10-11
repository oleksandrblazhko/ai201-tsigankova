/* видалення таблиць з каскадним видаленням 
можливих описів цілісності */
drop table Employee CASCADE CONSTRAINTS;
drop table Office_worker CASCADE CONSTRAINTS;
drop table Weather_forecast CASCADE CONSTRAINTS;
drop table Experiment CASCADE CONSTRAINTS;
drop table Equipment_indicators CASCADE CONSTRAINTS;
drop table Laboratory_equipment CASCADE CONSTRAINTS;
drop table Searching_system CASCADE CONSTRAINTS;
drop table Online_message CASCADE CONSTRAINTS;
drop table Sender_email_address CASCADE CONSTRAINTS;
drop table Receiver_email_address CASCADE CONSTRAINTS;

CREATE TABLE Employee ( -- опис співробітників
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
);

-- обмеження первинного ключа
ALTER TABLE Employee ADD CONSTRAINT emp_pk
	PRIMARY KEY (employee_id);
	
-- обмеження зовнішніх ключів
ALTER TABLE Employee ADD CONSTRAINT emp_sender_email_address_id_fk
	FOREIGN KEY (email_address_id)
	REFERENCES Sender_email_address (sender_email_address_id);
	
ALTER TABLE Employee ADD CONSTRAINT emp_receiver_email_address_id_fk
	FOREIGN KEY (email_address_id)
	REFERENCES Receiver_email_address (receiver_email_address_id);

ALTER TABLE Employee ADD CONSTRAINT emp_weather_forecast_id_fk
	FOREIGN KEY (weather_forecast_id)
	REFERENCES Weather_forecast (weather_forecast_id);
	
ALTER TABLE Employee ADD CONSTRAINT emp_experiment_id_fk
	FOREIGN KEY (experiment_id)
	REFERENCES Experiment (experiment_id);
	
ALTER TABLE Employee ADD CONSTRAINT emp_office_worker_id_fk
	FOREIGN KEY (office_worker_id)
	REFERENCES Office_worker (office_worker_id);

-- обмеження вмісту стовпчиків таблиці
ALTER TABLE Employee ADD CONSTRAINT emp_salary_range
	CHECK (salary between 0 and 10000);
	
ALTER TABLE Employee ADD CONSTRAINT emp_salary_range
	CHECK (work_experience>0);
	
CREATE TABLE Office_worker ( -- опис офісних робітників
	office_worker_id NUMBER(4), -- N офісного робітника
	surname VARCHAR(20), -- прізвище офісного робітника
	name VARCHAR(20), -- ім'я офісного робітника
	patronymic VARCHAR(20), -- по-батькові офісного робітника
	email_address_id NUMBER(4), -- N email адреси офісного робітника
	request_id NUMBER(10) -- N запиту
);

-- обмеження первинного ключа
ALTER TABLE Office_worker ADD CONSTRAINT wrk_pk
	PRIMARY KEY (office_worker_id);
	
-- обмеження зовнішніх ключів
ALTER TABLE Office_worker ADD CONSTRAINT wrk_sender_email_address_id_fk
	FOREIGN KEY (email_address_id)
	REFERENCES Sender_email_address (email_address_id);
	
ALTER TABLE Office_worker ADD CONSTRAINT wrk_receiver_email_address_id_fk
	FOREIGN KEY (email_address_id)
	REFERENCES Receiver_email_address (email_address_id);
	
ALTER TABLE Office_worker ADD CONSTRAINT wrk_request_id_fk
	FOREIGN KEY (request_id)
	REFERENCES Searching_system (request_id);
	
CREATE TABLE Weather_forecast ( -- опис прогнозів погоди
	weather_forecast_id NUMBER(10), -- N прогнозу погоди
	wf_date DATE, -- дата прогнозу погоди
	wf_time TIME, -- час прогнозу погоди
	experiment_id NUMBER(10) -- N експерименту
);

-- обмеження первинного ключа
ALTER TABLE Weather_forecast ADD CONSTRAINT wf_pk
	PRIMARY KEY (weather_forecast_id);
	
-- обмеження зовнішнього ключа
ALTER TABLE Weather_forecast ADD CONSTRAINT wf_experiment_id_fk
	FOREIGN KEY (experiment_id)
	REFERENCES Experiment (experiment_id);
	
CREATE TABLE Experiment ( -- опис експериментів
	experiment_id NUMBER(10), -- N експерименту
	exp_research VARCHAR(100), -- дослід експерименту
	exp_result VARCHAR(100), -- результат експерименту
	indicators_list_id NUMBER(10) -- N списку змін індикаторів
);

-- обмеження первинного ключа
ALTER TABLE Experiment ADD CONSTRAINT exp_pk
	PRIMARY KEY (experiment_id);
	
-- обмеження зовнішнього ключа
ALTER TABLE Experiment ADD CONSTRAINT exp_indicators_list_id_fk
	FOREIGN KEY (indicators_list_id)
	REFERENCES Equipment_indicators (indicators_list_id);
	
CREATE TABLE Equipment_indicators ( -- опис змін індикаторів
	indicators_list_id NUMBER(10), -- N списку змін індикаторів
	air_temperature NUMBER(3,1), -- показник температури повітря
	air_humidity NUMBER(2), -- показник вологості повітря
	pressure NUMBER(5,2), -- показник тиску
	wind_direction VARCHAR(20), -- показник напряму вітру
	wind_power NUMBER(2), -- показник сили вітру
);

-- обмеження первинного ключа
ALTER TABLE Equipment_indicators ADD CONSTRAINT ei_pk
	PRIMARY KEY (indicators_list_id);
	
-- обмеження вмісту стовпчиків таблиці
ALTER TABLE Equipment_indicators ADD CONSTRAINT ei_air_humidity_range
	CHECK (air_humidity>0);
	
ALTER TABLE Equipment_indicators ADD CONSTRAINT ei_pressure_range
	CHECK (pressure>0);
	
ALTER TABLE Equipment_indicators ADD CONSTRAINT ei_wind_power_range
	CHECK (wind_power>0);
	
CREATE TABLE Laboratory_equipment ( -- опис лабораторного обладнання
	laboratory_equipment_id NUMBER(2), -- N лабораторного обладнання
	list_of_changes VARCHAR(100), -- список змін показників обладнання
	indicators_list_id NUMBER(10), -- N списку змін індикаторів
);

-- обмеження первинного ключа
ALTER TABLE Laboratory_equipment ADD CONSTRAINT le_pk
	PRIMARY KEY (laboratory_equipment_id);
	
-- обмеження зовнішнього ключа
ALTER TABLE Laboratory_equipment ADD CONSTRAINT le_indicators_list_id_fk
	FOREIGN KEY (indicators_list_id)
	REFERENCES Equipment_indicators (indicators_list_id);
	
CREATE TABLE Searching_system ( -- опис пошукової системи
	request_id NUMBER(10), -- N запиту
	request VARCHAR(100) -- запит
);

-- обмеження первинного ключа
ALTER TABLE Searching_system ADD CONSTRAINT ssystem_pk
	PRIMARY KEY (request_id);
	
CREATE TABLE Online_message ( -- опис онлайн-повідомлень
	online_message_id NUMBER(10), -- N онлайн-повідомлення
	message_text VARCHAR(200), -- текст онлайн-повідомлення
	sender_email_address_id NUMBER(4), -- N email адреси відправника
	receiver_email_address_id NUMBER(4), -- N email адреси отримувача
);

-- обмеження первинного ключа
ALTER TABLE Online_message ADD CONSTRAINT message_pk
	PRIMARY KEY (online_message_id);
	
-- обмеження зовнішніх ключів
ALTER TABLE Online_message ADD CONSTRAINT message_sender_email_address_id_fk
	FOREIGN KEY (sender_email_address_id)
	REFERENCES Sender_email_address (sender_email_address_id);
	
ALTER TABLE Online_message ADD CONSTRAINT message_receiver_email_address_id_fk
	FOREIGN KEY (receiver_email_address_id)
	REFERENCES Receiver_email_address (receiver_email_address_id);
	
CREATE TABLE Sender_email_address ( -- опис адрес відправників
	sender_email_address_id NUMBER(4), -- N email адреси відправника
	sender_email_address VARCHAR(20) -- адреса відправника
);

-- обмеження первинного ключа
ALTER TABLE Sender_email_address ADD CONSTRAINT sender_pk
	PRIMARY KEY (sender_email_address_id);
	
-- обмеження вмісту стовпчика таблиці
ALTER TABLE Sender_email_address ADD CONSTRAINT sender_email_template
    CHECK (regexp_like(sender_email_address, 
	           '^([a-z0-9][a-z0-9._-]*@[a-z][a-z0-9._-]*\.[a-z]{2,4})$'));
	
CREATE TABLE Receiver_email_address ( -- опис адрес отримувачів
	receiver_email_address_id NUMBER(4), -- N email адреси отримувача
	receiver_email_address VARCHAR(20) -- адреса отримувача
);

-- обмеження первинного ключа
ALTER TABLE Receiver_email_address ADD CONSTRAINT receiver_pk
	PRIMARY KEY (receiver_email_address_id);
	
-- обмеження вмісту стовпчика таблиці
ALTER TABLE Receiver_email_address ADD CONSTRAINT sender_email_template
    CHECK (regexp_like(receiver_email_address, 
	           '^([a-z0-9][a-z0-9._-]*@[a-z][a-z0-9._-]*\.[a-z]{2,4})$'));