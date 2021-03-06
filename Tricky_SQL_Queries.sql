SELECT COUNT(*), GENDER FROM EMPLOYEES WHERE DOB BETWEEN '01/01/1960' AND '31/12/1975' GROUP BY GENDER;
SELECT STUDENT, MARKS FROM TABLE WHERE MARKS > SELECT AVG(MARKS) FROM TABLE;
SELECT * FROM EMPLOYEE WHERE EMPID = 2 AND EMPFIRSTNAME = 'SAM';
SELECT FIRST_NAME FROM EMPLOYEE WHERE LAST_NAME LIKE '%[%]%';
SELECT DATEPART(YYYY, JOINING_DATE) JOIN_YEAR, DATEPART(MM, JOINING_DATE) JOIN_MONTH, COUNT(*) TOTAL_EMP FROM EMPLOYEE GROUPBY DATEPART(YYYY, JOINING_DATE), DATEPART(MM, JOINING_DATE);
SELECT DEPARTMENT, SUM(SALARY) TOTAL_SALARY FROM EMPLOYEE GROUP BY DEPARTMENT HAVING SUM(SALARY) > 800000 ORDER BY TOTAL_SALARY DESC;
SELECT EMPLOYEE_ID FROM EMPLOYEE MINUS SELECT EMPLOYEE_REF_ID FROM INCENTIVES;
SELECT FIRST_NAME, CASE FIRST_NAME WHEN 'SAM' THEN SALARY*.2 WHEN 'ROY' THEN SALARY*.10 ELSE SALARY*.15 END "DEDUCED_AMOUNT" FROM EMPLOYEE;
SELECT FIRST_NAME, INCENTIVE_AMOUNT, DENSE_RANK() OVER (PARTITION BY INCENTIVE_DATE ORDER BY INCENTIVE_AMOUNT DESC) AS RANK FROM EMPLOYEE A, INCENTIVES B WHERE A.EMPLOYEE_ID=B.EMPLOYEE_REF_ID;
SELECT FIRST_NAME, ISNULL(INCENTIVE_AMOUNT,0) FROM EMPLOYEE A LEFT JOIN INCENTIVES B ON A.EMPLOYEE_ID = B.EMPLOYEE_REF_ID;
ALTER TABLE EMPLOYEE ADD CONSTRAINT EMPLOYEE_PK PRIMARY KEY (EMPLOYEE_ID);
ALTER TABLE EMPLOYEE ADD CONSTRAINT EMPLOYEE_PK PRIMARY KEY (EMPLOYEE_ID, FIRST_NAME);
ALTER TABLE INCENTIVES ADD CONSTRAINT INCENTIVES_FK FOR KEY (EMPLOYEE_REF_ID) REFERENCES EMPLOYEE (EMPLOYEE_ID);
UPDATE TBL SET NMBR = CASE WHEN NMBR > 0 THEN NMBR+3 ELSE NMBR+2 END;

