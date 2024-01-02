select * from hrdata;

select sum(employee_count) as Emp_cnt from hrdata
-- where education = 'High School';
-- where department = 'R&D';
where education_field = 'Medical';

select count(attrition) as Total_Attrition
from hrdata
where attrition = 'Yes';

select count(attrition) as Total_Attrition
from hrdata
where attrition = 'Yes' and department = 'R&D';

select count(attrition) as Total_Attrition
from hrdata
where attrition = 'Yes' and department = 'R&D' and education_field = 'Medical';

select count(attrition) as Total_Attrition
from hrdata
where attrition = 'Yes' and department = 'R&D' and
education_field = 'Medical' and education = 'High School';

select cast((select count(attrition) from hrdata where attrition = 'Yes')/
sum(employee_count)*100 as decimal(10,2)) as Attrition_Rate from hrdata;

select round((select count(attrition) from hrdata where attrition = 'Yes' and department = 'Sales')/
sum(employee_count)*100, 2) as Attrition_Rate from hrdata
where department = 'Sales';

select sum(employee_count) - 
(select count(attrition) from hrdata where attrition = 'Yes' and gender = 'Male') as Active_Employee
from hrdata where gender = 'Male';

select round(avg(age), 0) as Avg_Age from hrdata;

-- attrition by gender

select gender, count(attrition) as Attrition_cnt from hrdata
where attrition = 'Yes' and education = 'High School'
group by gender
order by Attrition_cnt desc;

-- department by attrition

select department, count(attrition) as Attrition_cnt from hrdata
where attrition = 'Yes'
group by department;

select department, count(attrition) as Attrition_cnt,
		round(cast(count(attrition) as numeric)/(select count(attrition) from hrdata where attrition = 'Yes') * 100, 2) as attrition_pct
from hrdata
where attrition = 'Yes'
group by department
order by Attrition_pct desc;


select department, count(attrition) as Attrition_cnt,
		round(cast(count(attrition) as numeric)/(select count(attrition) from hrdata where attrition = 'Yes' and gender='Female') * 100, 2) as attrition_pct
from hrdata
where attrition = 'Yes' and gender = 'Female'
group by department
order by Attrition_pct desc;

select age, sum(employee_count)
from hrdata
group by age
order by age;


select age, sum(employee_count)
from hrdata
where department = 'R&D'
group by age
order by age;


select education_field, count(attrition) as total_attrition from hrdata
where attrition = 'Yes'
group by education_field
order by total_attrition desc;


select education_field, count(attrition) as total_attrition from hrdata
where attrition = 'Yes' and department = 'Sales'
group by education_field
order by total_attrition desc;

select age_band, gender, count(attrition) as total_attrition,
		round(cast(count(attrition) as numeric)/(select count(attrition) from hrdata where attrition = 'Yes')*100,2) as pct
from hrdata
where attrition = 'Yes'
group by age_band, gender
order by age_band, gender;

create extension if not exists tablefunc;

select * 
from crosstab(
	'Select job_role, job_satisfaction, sum(employee_count)
	 from hrdata
	 group by job_role, job_satisfaction
	 order by job_role, job_satisfaction'
	) as cte(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
order by job_role;


select age_band, gender, sum(employee_count) from hrdata
group by age_band, gender
order by age_band, gender desc;