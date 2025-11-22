CREATE TABLE telco_customers (
    customerID VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    SeniorCitizen SMALLINT,
    Partner VARCHAR(3),
    Dependents VARCHAR(3),
    tenure INT,
    PhoneService VARCHAR(3),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(30),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    PaperlessBilling VARCHAR(3),
    PaymentMethod VARCHAR(50),
    MonthlyCharges NUMERIC(10,2),
    TotalCharges NUMERIC(10,2),
    Churn VARCHAR(3)
);

select * from telco_customers;


--1. How many customers are in the dataset?
select count(*) as Total_Customers
from telco_customers;


--2. How many customers have churned?
select count(*) as total_churned
from telco_customers
where churn = 'Yes';

--3. What is the churn rate of the company?
select
	(SUM(CASE WHEN churn = 'Yes' then 1 else 0 end) *100.0 / count(*)) as churn_nrate_percentage
from telco_customers;


--4. What is the average tenure of churned vs non-churned customers?
select churn, avg(tenure) as average_tenure
from telco_customers
group by Churn;


--5. What is the average monthly charge for customers using Fiber Optic internet?
SELECT avg(monthlycharges) as avg_charge
from telco_customers
where internetservice = 'Fiber optic';


--6. List the top 10 highest-paying customers.
select customerid, monthlycharges
from telco_customers
order by monthlycharges desc
limit 10;

--7. How many customers use each type of contract?
select contract, count(*) as total_customers8. 
from telco_customers
group by contract;


-- Which internet service type has the highest churn rate?
select
	 Internetservice,
		sum(case when Churn = 'Yes' then 1 else 0 end) as churned,
		count(*) as total,
		(sum(case when Churn = 'Yes' then 1 else 0 END) * 100.0 / count(*)) as rate_churn
from telco_customers
group by internetservice
order by rate_churn desc;

--9. Find customers who pay more than 100 per month but have tenure less than 6 months.
SELECT customerid, monthlycharges, tenure
from telco_customers
where monthlycharges > 100 and tenure < 6;


--10. What is the average TotalCharges for each gender?
select gender, avg(totalcharges) as avg_charges
from telco_customers
group by gender;


--11. Is Paperless Billing associated with higher churn?
select 
	paperlessbilling,
	(sum(case when churn = 'Yes' then 1 else 0 end) * 100.0 / COUNT(*))
	AS churn_rate
from telco_customers
group by paperlessbilling;


--12. How many senior citizens have churned?
select count(*) as senior_churned
from telco_customers
where seniorcitizen = 1 and churn = 'Yes';

--13. Compare monthly charges between customers with and without dependents.
select dependents, avg(monthlycharges) as avg_monthly_charges
from telco_customers
group by dependents;

--14. Which payment method has the highest total revenue?
select paymentmethod, sum(monthlycharges) as total_revenue
from telco_customers
group by paymentmethod
order by total_revenue desc;

--15. Find the top 5 longest-tenure customers who churned.
select customerid, tenure, churn
from telco_customers
where churn = 'Yes'
order by tenure desc
limit 5;