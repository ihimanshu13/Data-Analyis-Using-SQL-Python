select * from hospitaldataanalysis;

-- count the no. of people from both Gender
select Gender, Count(Gender) 
group by gender;


-- Count the people who are suffering from Heart disease and Cancer
select Condition, count(Condition)
from hospitaldataanalysis
where condition = 'Heart Disease' OR condition = 'Cancer'
group by Condition;

-- count the people who are suffering from Hypertension, Stroke
select Condition, count(Condition)
from hospitaldataanalysis
where condition = 'Stroke' OR condition = 'Hypertension'
group by Condition;

-- Give the list of Procedure and their revenue or cost
Select Procedure, Cost
From hospitaldataanalysis
group by Procedure 
Order by Cost Desc;

-- Give the list of Patient who are equal and above 20 and and less than equal to 50
Select Patient_ID, Age, Outcome
from hospitaldataanalysis
where Age>=20 and Age<=50
order by age desc;

-- outcome this age people Age>=20 ,Age<=50 are recovered
select Patient_ID, Age, Length_of_stay, outcome
from hospitaldataanalysis
where age<=50 AND age>=20 AND outcome = 'Recovered'
order by age desc;

-- count the people who are recoverd and there age is
select count(patient_id)
from hospitaldataanalysis
where age<=50 AND age>=20 AND outcome = 'Recovered'
order by age desc;

-- count of all patient admit
select count(patient_id) from hospitaldataanalysis;


-- profit to company show it by Patient COnditon wise
select Condition, sum(cost) as Profit
from hospitaldataanalysis
group by Condition
order by Profit desc;

-- count the readmission people
select count(patient_id), Readmission
from hospitaldataanalysis
group by readmission
order by readmission desc;

-- Coun the Patient who are suffering from Heart disease, diabetes, Cancer & Stroke
Select Condition, count(patient_id)
from hospitaldataanalysis
where Condition = 'Heart Disease' OR Condition = 'Diabetes'OR Condition =  'Cancer' OR Condition = 'Stroke'
group by Condition;

-- other way
select Condition, count(patient_id)
from hospitaldataanalysis
where Condition IN ('Heart Disease', 'Diabetes', 'Cancer', 'Stroke')
group by Condition;

-- Average Satisfaction score and Coount of Patient whose score above 3.
select count(Patient_id), avg(Satisfaction)
from hospitaldataanalysis
where satisfaction>3;


 