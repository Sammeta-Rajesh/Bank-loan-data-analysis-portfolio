CREATE TABLE bank_loan_data (
    id INT,
    address_state VARCHAR(50),
    application_type VARCHAR(50),
    emp_length VARCHAR(50),
    emp_title VARCHAR(100),
    grade VARCHAR(10),
    home_ownership VARCHAR(50),
    issue_date VARCHAR(20),
    last_credit_pull_date VARCHAR(20),
    last_payment_date VARCHAR(20),
    loan_status VARCHAR(50),
    next_payment_date VARCHAR(20),
    member_id INT,
    purpose VARCHAR(50),
    sub_grade VARCHAR(10),
    term VARCHAR(20),
    verification_status VARCHAR(50),
    annual_income NUMERIC,
    dti NUMERIC,
    installment NUMERIC,
    int_rate NUMERIC,
    loan_amount NUMERIC,
    total_acc INT,
    total_payment NUMERIC,
    PRIMARY KEY (id)
);
select * from bank_loan_data
select count(id) as total_loan_applications from bank_loan_data;

SELECT COUNT(id) AS MTD_Total_Loan_Applications 
FROM bank_loan_data 
WHERE EXTRACT(YEAR FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 2021 
  AND EXTRACT(MONTH FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 12;

SELECT COUNT(id) AS PMTD_Total_Loan_Applications 
FROM bank_loan_data 
WHERE EXTRACT(YEAR FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 2021 
  AND EXTRACT(MONTH FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 11;

select sum(loan_amount) as Total_Funded_Amount from bank_loan_data;

SELECT sum(loan_amount) AS MTD_Total_FUNDED_AMOUNT 
FROM bank_loan_data 
WHERE EXTRACT(YEAR FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 2021 
  AND EXTRACT(MONTH FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 12;

SELECT sum(loan_amount) AS PMTD_Total_FUNDED_AMOUNT 
FROM bank_loan_data 
WHERE EXTRACT(YEAR FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 2021 
  AND EXTRACT(MONTH FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 11;

select sum(total_payment) as total_payment_received from bank_loan_data;

SELECT sum(total_payment) AS MTD_Total_AMOUNT_RECEIVED 
FROM bank_loan_data 
WHERE EXTRACT(YEAR FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 2021 
  AND EXTRACT(MONTH FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 12;


SELECT sum(total_payment) AS PMTD_Total_AMOUNT_RECEIVED 
FROM bank_loan_data 
WHERE EXTRACT(YEAR FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 2021 
  AND EXTRACT(MONTH FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 11;

select round(avg(int_rate),4) * 100 as Average_interst_rate from bank_loan_data;

SELECT round(avg(int_rate),4) * 100 AS MTD_average_interest_rate
FROM bank_loan_data 
WHERE EXTRACT(YEAR FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 2021 
  AND EXTRACT(MONTH FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 12;


SELECT round(avg(int_rate),4) * 100 AS PMTD_average_interest_rate
FROM bank_loan_data 
WHERE EXTRACT(YEAR FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 2021 
  AND EXTRACT(MONTH FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 11;

select round(avg(dti),4)*100 as AVG_dti from bank_loan_data;

SELECT round(avg(dti),4) * 100 AS MTD_average_dti
FROM bank_loan_data 
WHERE EXTRACT(YEAR FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 2021 
  AND EXTRACT(MONTH FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 12;


SELECT round(avg(dti),4) * 100 AS PMTD_average_dti
FROM bank_loan_data 
WHERE EXTRACT(YEAR FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 2021 
  AND EXTRACT(MONTH FROM TO_DATE(issue_date, 'DD-MM-YYYY')) = 11;


select loan_status from bank_loan_data;

select 
       (count(case when loan_status= 'Fully Paid' or loan_status = 'Current' then id end)* 100)
	   /
	   count(id) AS good_loan_percentage from bank_loan_data

select count(id) as good_loan_applications from bank_loan_data
where loan_status ='Fully Paid' or loan_status ='current'

select sum(loan_amount) as good_loan_amount from bank_loan_data
where loan_status='Fully  Paid' or loan_status='Current' 

select sum(total_payment) as good_loan_recieved from bank_loan_data
where loan_status ='Fully Paid' or loan_status ='Current'

select 
      (count(case when loan_status= 'Charged Off' then id end)* 100)/
	   
	  count(id) AS bad_loan_percentage from bank_loan_data

select count(id) as bad_loan_applications from bank_loan_data
where loan_status='Charged Off'

select sum(total_payment) as bad_loan_amount_received from bank_loan_data
where loan_status='Charged Off'

select sum(loan_amount) as bad_loan_funded_amount from bank_loan_data
where loan_status='Charged Off'

select 
       loan_status,
	   count(id) as total_loan_applications,
	   sum(total_payment) as total_amount_received,
	   sum(loan_amount) as total_funded_amount,
	   avg(int_rate * 100) as interest_rate,
	   avg(dti*100) as dti
from bank_loan_data
group by loan_status

select * from bank_loan_data

SELECT 
    EXTRACT(MONTH FROM TO_DATE(issue_date, 'DD-MM-YYYY')) AS Month_Number,
    TO_CHAR(TO_DATE(issue_date, 'DD-MM-YYYY'), 'FMMonth') AS Month_Name,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY Month_Number, Month_Name
ORDER BY Month_Number;

select 
     address_state,
	 count(id) as total_loan_applications,
	 sum(loan_amount) as total_funded_amount,
	 sum(total_payment) as total_received_amount
from bank_loan_data
group by address_state
order by count(id)DESC

select 
     term,
	 count(id) as total_loan_applications,
	 sum(loan_amount) as total_funded_amount,
	 sum(total_payment) as total_received_amount
from bank_loan_data
group by term
order by term

select 
     emp_length,
	 count(id) as total_loan_applications,
	 sum(loan_amount) as total_funded_amount,
	 sum(total_payment) as total_received_amount
from bank_loan_data
group by emp_length
order by emp_length

select 
     purpose,
	 count(id) as total_loan_applications,
	 sum(loan_amount) as total_funded_amount,
	 sum(total_payment) as total_received_amount
from bank_loan_data
group by purpose
order by purpose


select 
     home_ownership,
	 count(id) as total_loan_applications,
	 sum(loan_amount) as total_funded_amount,
	 sum(total_payment) as total_received_amount
from bank_loan_data
group by home_ownership
order by home_ownership











