
-- How many total encounters ocurred each year?
select YEAR(STOP),COUNT(Id)  from Hospital.dbo.encounters GROUP BY YEAR(STOP) ORDER BY YEAR(STOP) ASC



--for each year ,what percentage of all encounters belong to each encounter class ()

 select YEAR(START),
		round(sum(case when encounterclass ='ambulatory' then 1 else 0 end) *100.0/ COUNT(*) ,2) as ambulatory,
		round(sum(case when encounterclass ='outpatient' then 1 else 0 end) *100.0 / COUNT(*),2) as outpatient,
		round(sum(case when encounterclass ='wellness' then 1 else 0 end) *100.0 / COUNT(*),2) as wellness,
		round(sum(case when encounterclass ='urgentcare' then 1 else 0 end) *100.0 / COUNT(*) ,2) as urgentcare,
		round(sum(case when encounterclass ='inpatient' then 1 else 0 end) *100.0 / COUNT(*),2) as inpatient

 from Hospital.dbo.encounters 
 group by YEAR(START)
 order by YEAR(START)
 


 --What percenatage of encounter were over 24 hours verse under 24 hours ?
 select 
		round(sum(case when DATEDIFF(HOUR,start,stop) < 24 then 1 else 0 end)*100.0/ COUNT(*),2) as under_24_hour,
		round(sum(case when DATEDIFF(HOUR,start,stop) >= 24 then 1 else 0 end)*100.0/ COUNT(*),2) as above_24_hour

from Hospital.dbo.encounters



--Encounters with zero payer coverage and their percentage
select 
		sum(case when PAYER_COVERAGE=0 then 1 else 0 end) as Encounters_Have_zero_converge,
		round(sum(case when PAYER_COVERAGE=0 then 1 else 0 end)*100.0 /COUNT(*),2) as Percentage_Encounters_Have_zero_converge
from Hospital.dbo.encounters 


--Top 10 most frequent procedures and their average base cost
select top 10 DESCRIPTION,COUNT(*)as most_frequent , round(avg(BASE_COST),2) as Average_base_cost  
from Hospital.dbo.procedures 
group by DESCRIPTION 
order by most_frequent desc 

-- Top 10 procedures with the highest average cost and their frequency
select top 10 round(avg(BASE_COST),2) as Average_base_cost, count(*) as frequent,DESCRIPTION   
from Hospital.dbo.procedures 
group by DESCRIPTION 
order by Average_base_cost desc 

--Average total claim cost per encounter by payer

select p.name, round(Avg(TOTAL_CLAIM_COST),2) as average_total_claim 
from Hospital.dbo.encounters as e
left join Hospital.dbo.payers AS p
on e.PAYER=p.Id
Group by p.name
order by average_total_claim desc


--Unique patient admissions by quarter
select DATEPART(YEAR, CAST(START AS DATE)) AS Year, DATEPART(QUARTER, CAST(START AS DATE)) AS QRT , count(distinct (patient)) as unique_patients
from Hospital.dbo.encounters 
group by DATEPART(YEAR, CAST(START AS DATE)),DATEPART(QUARTER, CAST(START AS DATE))
order by DATEPART(YEAR, CAST(START AS DATE)),DATEPART(QUARTER, CAST(START AS DATE))


-- Patients readmitted within 30 days of a previous encounter
WITH Readmission AS (
    SELECT 
        patient,
		start,
        stop,
        
        LEAD(START)over(partition by patient order by start)as next_admission 
    FROM Hospital.dbo.encounters
)
SELECT count(patient) as redmitted_patient
FROM Readmission
where DATEDIFF(day,next_admission , STOP)<30