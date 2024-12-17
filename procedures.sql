CREATE OR REPLACE PROCEDURE Calculate_Bonus IS
BEGIN
    UPDATE Employees
    SET salary = salary + (salary * 0.10)
    WHERE department = 'Engineering';
    DBMS_OUTPUT.PUT_LINE('Bonuses calculated for Engineering employees');
END;

CREATE OR REPLACE TRIGGER Set_Hire_Date  
BEFORE INSERT ON Employees  
FOR EACH ROW  
BEGIN  
    :NEW.hire_date := SYSDATE;  
END;  
