-- Function 1: Calculate Annual Salary for an Employee
CREATE OR REPLACE FUNCTION Calculate_Annual_Salary(p_employee_id IN INT)
RETURN DECIMAL IS
    v_monthly_salary DECIMAL(10, 2);
    v_annual_salary DECIMAL(10, 2);
BEGIN
    -- Fetch the employee's monthly salary
    SELECT salary INTO v_monthly_salary
    FROM Employees
    WHERE employee_id = p_employee_id;

    -- Calculate annual salary
    v_annual_salary := v_monthly_salary * 12;

    RETURN v_annual_salary;
END Calculate_Annual_Salary;
/
----------------------------------------------

-- Function 2: Get Full Name of an Employee
CREATE OR REPLACE FUNCTION Get_Full_Name(p_employee_id IN INT)
RETURN VARCHAR IS
    v_full_name VARCHAR(150);
BEGIN
    -- Concatenate first_name and last_name
    SELECT first_name || ' ' || last_name INTO v_full_name
    FROM Employees
    WHERE employee_id = p_employee_id;

    RETURN v_full_name;
END Get_Full_Name;
/
----------------------------------------------

-- Function 3: Get the Total Number of Employees in a Specific Department
CREATE OR REPLACE FUNCTION Get_Employee_Count(p_department IN VARCHAR)
RETURN INT IS
    v_count INT;
BEGIN
    -- Count the employees in the given department
    SELECT COUNT(*) INTO v_count
    FROM Employees
    WHERE department = p_department;

    RETURN v_count;
END Get_Employee_Count;
/
----------------------------------------------

-- Function 4: Check if an Employee Email Already Exists
CREATE OR REPLACE FUNCTION Check_Email_Exists(p_email IN VARCHAR)
RETURN VARCHAR IS
    v_exists VARCHAR(10);
    v_count INT;
BEGIN
    -- Check for email existence
    SELECT COUNT(*) INTO v_count
    FROM Employees
    WHERE email = p_email;

    IF v_count > 0 THEN
        v_exists := 'EXISTS';
    ELSE
        v_exists := 'NOT EXISTS';
    END IF;

    RETURN v_exists;
END Check_Email_Exists;
/
----------------------------------------------

-- Function 5: Calculate Average Salary for a Department
CREATE OR REPLACE FUNCTION Get_Avg_Salary(p_department IN VARCHAR)
RETURN DECIMAL IS
    v_avg_salary DECIMAL(10, 2);
BEGIN
    -- Calculate average salary in a department
    SELECT AVG(salary) INTO v_avg_salary
    FROM Employees
    WHERE department = p_department;

    RETURN v_avg_salary;
END Get_Avg_Salary;
/
