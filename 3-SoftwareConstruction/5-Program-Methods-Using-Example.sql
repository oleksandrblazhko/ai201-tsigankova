/* Приклади роботи з класом Weather_forecast */
DECLARE
    wf1 Weather_forecast;
BEGIN 
    wf1:= NEW Weather_forecast(TO_TIME('12:15','HH:MM'),TO_DATE('10.02.2023','DD/MM/YYYY'));
	    dbms_output.put_line('get weather_forecast_id: ' || wf1.get_weather_forecast_id);
	    dbms_output.put_line('get wf_date: ' || wf1.wf_date);
      dbms_output.put_line('get wf_time: ' || wf1.wf_time);
    wf1.display();
END;
/

/* Приклад роботи з класами Weather_forecast, Experiment */
DECLARE 
    wf1 Weather_forecast;
    exp1 Experiment;
BEGIN 
    wf1:= Weather_forecast(TO_TIME('16:45','HH:MM'),TO_DATE('23.09.2023','DD/MM/YYYY'));
    exp1:= Experiment(203, 'pressure-flow', 'normalized pressure result', wf1);
    exp1.display();
END;
/

/* Приклад роботи з класами Weather_forecast, Experiment, Equipment_indicators */
DECLARE 
   wf1 Weather_forecast;
   exp1 Experiment;
   ei1 Equipment_indicators;
BEGIN
    wf1:= Weather_forecast(TO_TIME('16:45','HH:MM'),TO_DATE('23.09.2023','DD/MM/YYYY'));
    exp1:= Experiment(203, 'pressure-flow', 'normalized pressure result', wf1);

    ei1 := Equipment_indicators(354, 15.2, 10, 120, 'північно-східний', 5, exp1);
    ei1.display(); 
END;
/

/* Приклад роботи з класами Weather_forecast, Experiment, Equipment_indicators, Employee */
DECLARE 
    wf1 Weather_forecast;
    exp1 Experiment;
    exp2 Experiment;
    ei1 Equipment_indicators;
    emp1 Employee;
    emp2 Employee;
BEGIN 
    wf1:= Weather_forecast(TO_TIME('16:45','HH:MM'),TO_DATE('23.09.2023','DD/MM/YYYY'));
    exp1:= Experiment(203, 'pressure-flow', 'normalized pressure result', wf1);
    exp2:= Experiment(149, 'anemometry', 'determination of wind strength', wf1);
    ei1 := Equipment_indicators(354, 15.2, 10, 120, 'північно-східний', 5, exp1);
    ei1 := Equipment_indicators(354, 15.2, 10, 120, 'північно-східний', 5, exp2);
    emp1 := Employee(2071, 'JOHNS', 'ARTUR', NULL, 5, 21500, 'artur.johns@gmail.com', wf1, exp1, NULL);
    emp2 := Employee(2071, 'KINGSMAN', 'BILL', NULL, 7, 23150, 'bill.kingsman@gmail.com', wf1, exp2, NULL);
    emp1.display(); 
    emp2.display(); 
END;
/
