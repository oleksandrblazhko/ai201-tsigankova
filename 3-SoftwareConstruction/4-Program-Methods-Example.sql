/* Методи класу Weather_forecast */
-- DROP TYPE Weather_forecast FORCE;
CREATE OR REPLACE TYPE BODY Weather_forecast AS 
    /* конструктор екземплярів об'єктів класів.
    Вхідні параметри:
	   1) p_wf_date - дата прогнозу погоди
	   умова 1) якщо в таблиці Weather_forecast вже існує вказана дата,
	   створюється екземпляр класу на основі даних таблиці,
	   інакше в таблиці Weather_forecast створюється новий рядок з одночасним
	   створюється екземпляр класу 
	  Вихідний параметр - екземпляр обєкту класу */
    CONSTRUCTOR FUNCTION Weather_forecast(p_wf_date DATE) 
        RETURN SELF AS RESULT
    IS
        v_weather_forecast_id Weather_forecast.weather_forecast_id%TYPE;
    BEGIN
        SELECT weather_forecast_id INTO v_weather_forecast_id
        FROM Weather_forecast
        WHERE 
            wf_date = p_wf_date;
        SELF.weather_forecast_id := v_weather_forecast_id;
        SELF.wf_date := p_wf_date;
        RETURN;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        INSERT INTO Weather_forecast (wf_date)
            VALUES (p_wf_date)
        RETURNING weather_forecast_id INTO v_weather_forecast_id;
        SELF.weather_forecast_id := v_weather_forecast_id;
        SELF.wf_date := p_wf_date;
        RETURN;
    END Weather_forecast;
    
        /* Процедура зміни значень атрибутів */
	      MEMBER PROCEDURE formWeatherForecast(p_weather_forecast_id NUMBER, p_wf_date DATE, p_wf_time TIME)
	      IS
	      BEGIN
        UPDATE Weather_forecast SET wf_date = p_wf_date, wf_time = p_wf_time
		      WHERE weather_forecast_id = p_weather_forecast_id;
		      SELF.wf_date := p_wf_date, SELF.wf_time := p_wf_time;;
	      END formWeatherForecast;
    
        /* Функції отримання значень атрибутів */
	      /* get_weather_forecast_id */
        MEMBER FUNCTION get_weather_forecast_id
	        RETURN NUMBER 
	      IS
        BEGIN
          RETURN SELF.weather_forecast_id;
        END get_weather_forecast_id;
        
        /* get_wf_date */
        MEMBER FUNCTION get_wf_date
	        RETURN NUMBER 
	      IS
        BEGIN
          RETURN SELF.wf_date;
        END get_wf_date;

        /* Процедура виводу на екран значень атрибутів */
        MEMBER PROCEDURE display 
        IS
        BEGIN 
          dbms_output.put_line('weather_forecast_id: ' || weather_forecast_id);
          dbms_output.put_line('wf_date: ' || wf_date);
          dbms_output.put_line('wf_time: ' || wf_time);
        END display;
END; 
/
