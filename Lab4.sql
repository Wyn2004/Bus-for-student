
use CompanyDB

/*managing the department named: Research and Development Department.*/
select	d.mgrSSN as EmployeeCode,
		e.empName as EmployeeName,
		d.depNum as DepartmentNumber,
		d.depName as DepartmentName
from tblDepartment as d 
inner join tblEmployee as e on e.empSSN=d.mgrSSN
where d.depName = N'Phòng Nghiên cứu và phát triển'


/*projects managed by Research and Development Department currently*/
select	p.proNum as ProjectNumber,
		p.proName as ProjectName,
		d.depName as DepartmentManageName
from tblDepartment as d
inner join tblProject as p on d.depNum=p.depNum
where d.depName = N'Phòng Nghiên cứu và phát triển'


/*project named ProjectB managed by department */
select	p.proNum as ProjectNumber,
		p.proName as ProjectName,
		d.depName as DepartmentManageName	
from tblDepartment as d
inner join tblProject as p on d.depNum = p.depNum
where p.proName = N'ProjectB'


/*employees who are supervised by employee name Mai Duy An */
select	e.empSSN as EmployeeNumber,
		e.empName as EmployeeName
from tblEmployee as e
where e.supervisorSSN = (select empSSN 
						from tblEmployee
						where empName = N'Mai Duy An')


/*supervises staff named Mai Duy An*/
select	e1.empSSN as EmployeeNumber,
		e2.empName as SupervisorName
from tblEmployee as e1
inner join tblEmployee as e2 on e1.supervisorSSN = e2.empSSN
where e1.empName = N'Mai Duy An';


/*where the project name ProjectA is working*/
select	l.locNum as WorkingPositionCode,
		l.locName as WorkingPositionName
from tblLocation as l
inner join tblProject as p on l.locNum=p.locNum
where p.proName = N'ProjectA'


/*Tp. Ho Chi Minh City is currently the working place of which projects*/
select	p.proNum as ProjectCode,
		p.proName as ProjectName
from tblProject as p
inner join tblLocation as l on p.locNum = l.locNum
where l.locName = N'TP Hồ Chí Minh'


/*dependents over 18 years old*/
select	d.depName as DependentName,
		d.depBirthdate as DependentDateOfBirth,
		e.empName as EmployeeName
from tblDependent as d
inner join tblEmployee as e on d.empSSN = e.empSSN
where DATEDIFF(YEAR, d.depBirthdate, GETDATE()) > 18


/*Show all male dependents*/
select	d.depName as DependentName,
		d.depBirthdate as DependentDateOfBirth,
		e.empName as EmployeeName
from tblDependent as d
inner join tblEmployee as e on d.empSSN = e.empSSN
where d.depSex = 'M'


/*workplace of the department named: Research and Development Department*/
select	dl.depNum as DepartmentCode,
		d.depName as DepartmentName,
		l.locName as WorkplaceName
from tblDepLocation as dl
inner join tblLocation as l on dl.locNum = l.locNum
inner join tblDepartment as d on dl.depNum = d.depNum
where d.depName = N'Phòng Nghiên cứu và phát triển'

/*total number of hours worked on the project by each employee*/
select	w.empSSN as EmployeeCode,
		e.empName as EmployeeName,
		d.depName as DepartmentName,
		SUM(w.workHours) as TotalWorkHours
from	tblEmployee as e
inner join tblWorksOn as w on e.empSSN=w.empSSN
inner join tblDepartment as d on e.depNum=d.depNum
group by w.empSSN, e.empName, d.depName


/*working projects in the HCM city*/
select	p.proNum as ProjectCode,
		p.proName as ProjectName,
		d.depName as DepartmentName
from tblProject as p
inner join tblLocation as l on p.locNum = l.locNum
inner join tblDepartment as d on p.depNum = d.depNum
where l.locName = N'TP Hồ Chí Minh'


/*female dependents of employees in a department: Research and Development Department*/
select	e.empName as EmployeeName,
		d.depName as DependentName,
		d.depRelationship as RelationshipBetweenDependentAndEmployee
from tblEmployee as e 
inner join tblDependent as d on e.empSSN = d.empSSN
inner join tblDepartment as dp on e.depNum = dp.depNum
where d.depSex = 'F' and dp.depName = N'Phòng Nghiên cứu và phát triển'


/*dependents over the age of 18 who belong to a department named: Research and Development Department.*/
select	e.empName as EmployeeName,
		d.depName as DependentName,
		d.depRelationship as RelationshipBetweenDependentAndEmployee
from tblEmployee as e
inner join tblDependent as d on e.empSSN = d.empSSN
inner join tblDepartment as dp on e.depNum = dp.depNum
where DATEDIFF(YEAR, d.depBirthdate, GETDATE()) > 18 and dp.depName = N'Phòng Nghiên cứu và phát triển'


/*number of dependents by gender*/
select	d.depSex as Gender,
		COUNT(d.depName) as NumberOfDependents
from tblDependent as d
group by d.depSex


/*number of dependents according to the employee relationship*/
select	d.depRelationship as Relationship,
		COUNT(d.depName) as NumberOfDependents
from tblDependent as d
group by d.depRelationship


/*department has the least number of dependendent*/
select 	dp.depNum as DepartmentCode,
		dp.depName as DepartmentName,
		COUNT(d.depName) NumberOfDependents
from tblDepartment as dp
left join tblEmployee as e on dp.depNum = e.depNum
left join tblDependent as d on e.empSSN = d.empSSN
group by dp.depNum, dp.depName
having COUNT(d.depName) = (	select MIN(NumberOfDependents)
							from (	select	COUNT(d2.depName) as NumberOfDependents
									from tblDepartment as dp2
									left join tblEmployee as e2 on dp2.depNum = e2.depNum
									left join tblDependent as d2 on e2.empSSN = d2.empSSN
									group by dp2.depNum) 
							as DepartmentDependents)


/*department has the largest number of dependents*/
select 	dp.depNum as DepartmentCode,
		dp.depName as DepartmentName,
		COUNT(d.depName) NumberOfDependents
from tblDepartment as dp
left join tblEmployee as e on dp.depNum = e.depNum
left join tblDependent as d on e.empSSN = d.empSSN
group by dp.depNum, dp.depName
having COUNT(d.depName) = (	select MAX(NumberOfDependents)
							from (	select	COUNT(d2.depName) as NumberOfDependents
									from tblDepartment as dp2
									left join tblEmployee as e2 on dp2.depNum = e2.depNum
									left join tblDependent as d2 on e2.empSSN = d2.empSSN
									group by dp2.depNum) 
							as DepartmentDependents)


/*total number of project hours of each department*/
select	d.depNum as DepartmentCode,
		d.depName as DepartmentName,
		SUM(w.workHours) as TotalWorkHours
from	tblProject as p
inner join tblWorksOn as w on p.proNum=w.proNum
inner join tblDepartment as d on p.depNum=d.depNum
group by d.depNum, d.depName


/*employee has the least number of hours on the project*/
select	e.empSSN as EmployeeCode, 
		e.empName as EmployeeName,
		SUM(w.workHours) as TotalWorkHours
from tblEmployee as e
inner join tblWorksOn as w on e.empSSN=w.empSSN
group by e.empName, e.empSSN
having SUM(w.workHours) =	(select MIN(totalHours) 
							from	(	select sum(w2.workHours) as TotalHours
										from tblWorksOn as w2
										group by w2.empSSN) 
							as MinHours)


/*employee has the most hours on the project*/
select	e.empSSN as EmployeeCode, 
		e.empName as EmployeeName,
		SUM(w.workHours) as TotalWorkHours
from tblEmployee as e
inner join tblWorksOn as w on e.empSSN=w.empSSN
group by e.empName, e.empSSN
having SUM(w.workHours) =	(select MAX(totalHours) 
							from	(	select sum(w2.workHours) as TotalHours
										from tblWorksOn as w2
										group by w2.empSSN) 
							as MaxHours)


/*employees have joined the project for the first time*/
select distinct	e.empSSN as EmployeeCode,
		e.empName as EmployeeName,
		d.depName as EmployeeDepartmentName
from tblEmployee as e
inner join tblWorksOn as w on e.empSSN = w.empSSN
inner join tblDepartment as d on e.depNum = d.depNum
where e.empSSN in (	select empSSN 
					from tblWorksOn 
					group by empSSN 
					having COUNT(proNum)=1)


/*employees have joined the project for the second time*/
select distinct	e.empSSN as EmployeeCode,
		e.empName as EmployeeName,
		d.depName as EmployeeDepartmentName
from tblEmployee as e
inner join tblWorksOn as w on e.empSSN = w.empSSN
inner join tblDepartment as d on e.depNum = d.depNum
where e.empSSN in (	select empSSN 
					from tblWorksOn 
					group by empSSN 
					having COUNT(proNum)=2)


/*employees are involved in at least two projects*/
select distinct	e.empSSN as EmployeeCode,
		e.empName as EmployeeName,
		d.depName as EmployeeDepartmentName
from tblEmployee as e
inner join tblWorksOn as w on e.empSSN = w.empSSN
inner join tblDepartment as d on e.depNum = d.depNum
where e.empSSN in (	select empSSN 
					from tblWorksOn 
					group by empSSN 
					having COUNT(distinct proNum)>=2)


/*number of members of each project*/
select	p.proNum as ProjectCode,
		p.proName as ProjectName,
		COUNT(w.empSSN) as NumberOfMembers
from tblProject as p
inner join tblWorksOn as w on p.proNum = w.proNum
group by p.proNum, p.proName


/*total number of hours worked on each project*/
select	p.proNum as ProjectCode,
		p.proName as ProjectName,
		SUM(w.workHours) as TotalWorkHours
from tblProject as p
inner join tblWorksOn as w on p.proNum = w.proNum
group by p.proNum, p.proName


/*project has the least number of members*/
select	w.proNum as ProjectCode,
		p.proName as ProjectName,
		COUNT(w.empSSN) as NumberOfMembers
from tblWorksOn as w
left join tblProject as p on w.proNum = p.proNum
left join tblEmployee as e on w.empSSN = e.empSSN
group by w.proNum, p.proName
having COUNT(w.empSSN) =(	select MIN(NumberOfMembers) 
							from	(	select COUNT(w2.empSSN) as NumberOfMembers
										from tblWorksOn as w2
										group by w2.proNum) 
							as MinMembers)


/*project has the largest number of members*/
select	w.proNum as ProjectCode,
		p.proName as ProjectName,
		COUNT(w.empSSN) as NumberOfMembers
from tblWorksOn as w
left join tblProject as p on w.proNum = p.proNum
left join tblEmployee as e on w.empSSN = e.empSSN
group by w.proNum, p.proName
having COUNT(w.empSSN) =(	select MAX(NumberOfMembers) 
							from	(	select COUNT(w2.empSSN) as NumberOfMembers
										from tblWorksOn as w2
										group by w2.proNum) 
							as MaxMembers)


/*project has the least total number of hours worked*/
select	p.proNum as ProjectCode,
		p.proName as ProjectName,
		SUM(w.workHours) as TotalWorkHours
from tblProject as p
inner join tblWorksOn as w on p.proNum = w.proNum
group by p.proNum, p.proName
having SUM(w.workHours) =	(select MIN(totalHours) 
							from	(	select sum(w2.workHours) as TotalHours
										from tblWorksOn as w2
										group by w2.proNum) 
							as MinHours)


/*project has the most total hours worked*/
select	p.proNum as ProjectCode,
		p.proName as ProjectName,
		SUM(w.workHours) as TotalWorkHours
from tblProject as p
inner join tblWorksOn as w on p.proNum = w.proNum
group by p.proNum, p.proName
having SUM(w.workHours) =	(select MAX(totalHours) 
							from	(	select sum(w2.workHours) as TotalHours
										from tblWorksOn as w2
										group by w2.proNum) 
							as MaxHours)


/*number of departments working in each workplace*/
select	l.locName as WorkplaceName,
		COUNT(p.depNum) as NumberOfDepartment
from tblProject as p
inner join tblLocation as l on p.locNum = l.locNum
group by l.locName


/*number of workplaces by department*/
select	dl.depNum as DepartmentCode,
		d.depName as DepartmentName,
		COUNT(dl.locNum) as NumberOfWorkplace
from tblDepLocation as dl
inner join tblLocation as l on dl.locNum = l.locNum
inner join tblDepartment as d on dl.depNum = d.depNum
group by dl.depNum, d.depName


/*department has the most jobs*/
select 	d.depNum as DepartmentCode,
		d.depName as DepartmentName,
		COUNT(dl.locNum) NumberOfWorkplaces
from tblDepLocation as dl
left join tblDepartment as d on dl.depNum = d.depNum
group by d.depNum, d.depName
having COUNT(dl.locNum) = (	select MAX(NumberOfWorkplaces)
							from (	select	COUNT(dl2.depNum) as NumberOfWorkplaces
									from tblDepLocation as dl2
									group by dl2.depNum) 
							as MaxJobs)


/*department has the fewest jobs*/
select 	d.depNum as DepartmentCode,
		d.depName as DepartmentName,
		COUNT(dl.locNum) NumberOfWorkplaces
from tblDepLocation as dl
left join tblDepartment as d on dl.depNum = d.depNum
group by d.depNum, d.depName
having COUNT(dl.locNum) = (	select MIN(NumberOfWorkplaces)
							from (	select	COUNT(dl2.depNum) as NumberOfWorkplaces
									from tblDepLocation as dl2
									group by dl2.depNum) 
							as MinJobs)


/*location has the most departments*/
select 	l.locName as WorkplaceName,
		COUNT(dl.depNum) NumberOfDepartments
from tblDepLocation as dl
left join tblLocation as l on dl.locNum = l.locNum
group by l.locName
having COUNT(dl.depNum) = (	select MAX(NumberOfWorkplaces)
							from (	select	COUNT(dl2.locNum) as NumberOfWorkplaces
									from tblDepLocation as dl2
									group by dl2.locNum) 
							as MaxDepartments)


/*location has the fewest departments*/
select 	l.locName as WorkplaceName,
		COUNT(dl.depNum) NumberOfDepartments
from tblDepLocation as dl
left join tblLocation as l on dl.locNum = l.locNum
group by l.locName
having COUNT(dl.depNum) = (	select (NumberOfWorkplaces)
							from (	select	COUNT(dl2.locNum) as NumberOfWorkplaces
									from tblDepLocation as dl2
									group by dl2.locNum) 
							as MinDepartments)


/*employee has the most dependents*/
select	e.empSSN as EmployeeNumber,
		d.depName as DependentName,
		COUNT(d.depName) as NumberOfDependent
from tblEmployee as e
inner join tblDependent as d on e.empSSN =  d.empSSN
group by e.empSSN, d.depName
having COUNT(d.depName) = (	select MAX(NumberOfDependents)
							from (	select COUNT(d2.depName) as NumberOfDependents
									from tblDependent as d2
									group by d2.depName)
							as MaxDependents)


/*employee has the fewest dependents*/
select	e.empSSN as EmployeeNumber,
		d.depName as DependentName,
		COUNT(d.depName) as NumberOfDependent
from tblEmployee as e
inner join tblDependent as d on e.empSSN =  d.empSSN
group by e.empSSN, d.depName
having COUNT(d.depName) = (	select MIN(NumberOfDependents)
							from (	select COUNT(d2.depName) as NumberOfDependents
									from tblDependent as d2
									group by d2.depName)
							as MinDependents)


/*employee has no dependents*/
select	e.empSSN as EmployeeNumber,
		e.empName as EmployeeName,
		dp.depName as DepartmentName
from tblEmployee as e
inner join tblDepartment as dp on e.depNum = dp.depNum
left join tblDependent as d on e.empSSN = d.empSSN
group by e.empSSN, e.empName, dp.depName
having COUNT(d.depName) = 0
/*where d.empSSN IS NULL*/


/*department has no dependents*/
select	dp.depNum as DepartmentNumber,
		dp.depName as DepartmentName
from tblDepartment as dp
left join tblEmployee as e on dp.depNum = e.depNum
left join tblDependent as d on e.empSSN = d.empSSN
group by dp.depNum, dp.depName
having COUNT(d.depName)=0


/*employees have never participated in any projects*/
select	e.empSSN as EmployeeNumber,
		e.empName as EmployeeName,
		d.depName as DepartmentName
from tblEmployee as e
left join tblWorksOn as w on e.empSSN = w.empSSN
left join tblDepartment as d on d.depNum = e.depNum
group by e.empSSN, e.empName, d.depName
having COUNT(w.proNum) = 0


/*department does not have any employees involved in any project*/
select	d.depNum as DepartmentNumber,
		d.depName as DepartmentName
from tblEmployee as e
left join tblWorksOn as w on e.empSSN = w.empSSN
left join tblDepartment as d on d.depNum = e.depNum
group by d.depName, d.depNum
having COUNT(w.proNum) = 0


/*department has no employees involved in a project named ProjectA*/
select	d.depNum as DepartmentNumber,
		d.depName as DepartmentName
from tblEmployee as e
left join tblWorksOn as w on e.empSSN = w.empSSN
left join tblDepartment as d on d.depNum = e.depNum
left join tblProject as p on p.proNum = w.proNum
where p.proName = N'ProjectA' or w.proNum is null
group by d.depNum, d.depName
having COUNT(w.proNum) = 0


/*number of projects managed by each department*/
select 	d.depNum as DepartmentCode,
		d.depName as DepartmentName,
		COUNT(distinct p.proNum) as NumberOfProjects
from tblProject as p
left join tblDepartment as d on p.depNum = d.depNum
group by d.depNum, d.depName


/*department manages the fewest project*/
select	d.depNum as DepartmentCode,
		d.depName as DepartmentName,
		COUNT(p.proNum) as NumberOfProject
from tblDepartment as d
left join tblProject as p on d.depNum = p.depNum
group by d.depNum, d.depName
having COUNT(p.proNum) = (	select MIN(NumberOfProject)
							from (	select COUNT(distinct p2.proNum) as NumberOfProject
									from tblDepartment as d2
									left join tblProject as p2 on d2.depNum = p2.depNum
									group by d2.depNum, d2.depName)
							as MinProject) 


/*department manages the most projects*/
select	d.depNum as DepartmentCode,
		d.depName as DepartmentName,
		COUNT(p.proNum) as NumberOfProject
from tblDepartment as d
left join tblProject as p on d.depNum = p.depNum
group by d.depNum, d.depName
having COUNT(p.proNum) = (	select MAX(NumberOfProject)
							from (	select COUNT(distinct p2.proNum) as NumberOfProject
									from tblDepartment as d2
									left join tblProject as p2 on d2.depNum = p2.depNum
									group by d2.depNum, d2.depName)
							as MaxProject) 
							

/*departments with more than 5 employees are managing the project*/
select	d.depNum as DepartmentCode,
		d.depName as DepartmentName,
		COUNT(w.empSSN) as NumberOfEmployee,
		p.proName as ProjectName
from tblEmployee as e
left join tblWorksOn as w on e.empSSN = w.empSSN
inner join tblDepartment as d on e.depNum = d.depNum
inner join tblProject as p on w.proNum = p.proNum
group by d.depNum, d.depName, p.proName, p.proNum
having COUNT(w.empSSN) = (	select distinct COUNT(e2.empSSN) as NumberOfEmployee
							from tblEmployee as e2 
							group by e2.depNum
							having COUNT(e2.empSSN)>5)


/*employees who belong to the department named Research Department and have no dependents*/
select	e.empSSN as EmployeeCode,
		e.empName as EmployeeName
from tblEmployee as e
inner join tblDepartment as dp on e.depNum = dp.depNum
left join tblDependent as d on e.empSSN = d.empSSN
where dp.depName = N'Phòng Nghiên cứu và phát triển' and d.empSSN is null


/*total number of hours worked by employees, who have no dependents*/
select	e.empSSN as EmployeeCode,
		e.empName as EmployeeName,
		SUM(w.workHours) as TotalWorkHours
from tblEmployee as e
inner join tblDepartment as dp on e.depNum = dp.depNum
left join tblDependent as d on e.empSSN = d.empSSN
inner join tblWorksOn as w on e.empSSN = w.empSSN
group by e.empSSN, e.empName, d.empSSN
having COUNT(d.empSSN) = 0


/*total number of hours worked by employees who have more than 3 dependents*/
select	e.empSSN as EmployeeCode,
		e.empName as EmployeeName,
		SUM(w.workHours) as TotalWorkHours
from tblEmployee as e
inner join tblDepartment as dp on e.depNum = dp.depNum
left join tblDependent as d on e.empSSN = d.empSSN
inner join tblWorksOn as w on e.empSSN = w.empSSN
group by e.empSSN, e.empName, d.empSSN
having COUNT(d.empSSN) > 3


/*total working hours of employees currently under the supervision of employee Mai Duy An*/
select	e.empSSN as EmployeeCode,
		e.empName as EmployeeName,
		SUM(w.workHours) as TotalWorkHours
from tblEmployee as e
inner join tblDepartment as dp on e.depNum = dp.depNum
left join tblDependent as d on e.empSSN = d.empSSN
inner join tblWorksOn as w on e.empSSN = w.empSSN
group by e.empSSN, e.empName, d.empSSN, e.supervisorSSN
having e.supervisorSSN = (select empSSN 
						from tblEmployee
						where empName = N'Mai Duy An')