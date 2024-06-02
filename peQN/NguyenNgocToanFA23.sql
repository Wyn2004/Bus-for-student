--1
select p.proNum, p.proName, d.depName
from tblDepartment d
join tblProject p on d.depNum = p.depNum
where d.depName = N'Phòng phần mềm nước ngoài'
--2
select p.proNum, p.proName, d.depName
from tblProject p
join tblLocation l on p.locNum = l.locNum
join tblDepartment d on p.depNum = d.depNum
where l.locName = N'TP Đà Nẵng'
--3
select p.proNum, p.proName, SUM(w.workHours)
from tblProject p
join tblWorksOn w on p.proNum = w.proNum
join tblDepartment d on p.depNum = d.depNum
group by p.proNum, p.proName
--4
select d.depNum, d.depName, SUM(w.workHours)
from tblProject p
join tblWorksOn w on p.proNum = w.proNum
join tblDepartment d on p.depNum = d.depNum
group by d.depNum, d.depName
--5
select lo.locName, COUNT(d.depNum)
from tblDepartment d
join tblDepLocation dep on d.depNum = dep.depNum
join tblLocation lo on dep.locNum = lo.locNum
group by lo.locName
--6
select lo.locName, COUNT(d.depNum)
from tblDepartment d
join tblDepLocation dep on d.depNum = dep.depNum
join tblLocation lo on dep.locNum = lo.locNum
group by lo.locName
having COUNT(d.depNum) = (
	select top 1 COUNT(d.depNum)
	from tblDepartment d
join tblDepLocation dep on d.depNum = dep.depNum
join tblLocation lo on dep.locNum = lo.locNum
group by lo.locName
	order by COUNT(d.depNum) desc
)
--7
CREATE PROCEDURE list_Employee
@departmentcode int
AS
SELECT e.*
FROM tblEmployee e
join tblDepartment d on e.depNum = d.depNum
where d.depNum = @departmentcode
go

exec list_Employee @departmentcode = '1'

select * from tblDepartment