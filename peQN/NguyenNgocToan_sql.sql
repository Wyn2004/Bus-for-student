INSERT INTO class(class_Id, dep_Id,	course_Id, pro_Id)
VALUES 
('SE15C01', 'IT', 'CSE15', 'FE'),
('AI15B01', 'IT', 'CAI15', 'FE'),
('MK17A01', 'MK', 'CMK17', 'FE'),
('BIZ17B01', 'BIZ', 'CBIZ17', 'FE');

INSERT INTO student(stu_Id, stu_name, stu_birthday, stu_email, class_Id)
VALUES
('SE150023', N'Nguyễn Quốc Khang', '2001-10-15', 'khangnq@fpt.edu.vn', 'SE15C01'),
('SE150040', N'Lê Quang Minh Đà', '2000-01-01', 'dalqm@fpt.edu.vn', 'SE15C01'),
('AI152541', N'Lê Võ Bảo Duy', '2002-05-20', 'duylvb@fpt.edu.vn', 'AI15B01'),
('AI152007', N'Võ Hoàng Nguyên', '2001-01-31', 'nguyenvh@fpt.edu.vn', 'AI15B01'),
('MK175489', N'Trương Việt Hoàng', '2001-02-23', 'hoangtv@fpt.edu.vn', 'MK17A01'),
('MK175694', N'Phan Thị Minh Phương', '2000-05-05', 'phuongptm@fpt.edu.vn', 'MK17A01'),
('BIZ179420', N'Thân Đức Quang Vinh', '2000-07-26', 'vinhtdq@fpt.edu.vn', 'BIZ17B01'),
('BIZ175642', N'Lương Gia Khánh', '2001-06-27', 'khanhlg@fpt.edu.vn', 'BIZ17B01');

INSERT INTO subjects(sub_Id, sub_name, dep_Id) 
VALUES 
('DBI202', N'Database Systems_Các hệ cơ sở dữ liệu', 'IT'),
('PRF192', N'Programming Fundamentals_Cơ sở lập trình', 'IT'),
('ECO111', N'Microeconomics_Kinh tế vi mô', 'MK'),
('MKT101', N'Marketing Principles_Nguyên lý Marketing', 'MK'),
('OBE102c', N'Organizational Behavior_Hành vi tổ chức', 'BIZ'),
('CHN111', N'Elementary Chinese 1_Hán ngữ sơ cấp 1', 'BIZ');

INSERT INTO result(stu_Id, sub_Id, on_time, mark)
VALUES 
('SE150023', 'DBI202', 1, 9),
('SE150040', 'DBI202', 1, 6.5),
('AI152541', 'DBI202', 1, 8),
('AI152007', 'DBI202', 1, 7),
('MK175489', 'ECO111', 1, 8),
('MK175694', 'MKT101', 1, 9),
('BIZ179420', 'OBE102c', 2, 9),
('BIZ175642', 'CHN111', 1, 8),
('SE150023', 'PRF192', 2, 7.5),
('BIZ179420', 'CHN111', 1, 8);

--a
select s.stu_name
from department d
join class c on d.dep_Id = c.dep_Id
join student s on c.class_Id = s.class_Id
where d.dep_Name = N'Công nghệ thông tin'
--b
select s.stu_name, r.mark
from class c
join student s on c.class_Id = s.class_Id
join result r on s.stu_Id = r.stu_Id
where c.class_Id = 'MK17A01'
--c
select cl.class_Id [class code], cl.dep_Id [class name], d.dep_Name [department name]
from course c
join class cl on c.course_Id = cl.course_Id
join department d on d.dep_Id = cl.dep_Id
where c.start_Year = 2021
--d
select s.stu_Id, s.stu_name, s.stu_birthday
from student s
join result r on s.stu_Id = r.stu_Id
where r.mark = (
	select MAX(mark)
	from result
) and r.on_time = 1
--e
select d.dep_Name, count(s.stu_Id) as [number of students]
from student s
join class c on s.class_Id = c.class_Id
join department d on c.dep_Id = d.dep_Id
group by d.dep_Name
order by [number of students] desc
--f
CREATE PROCEDURE listStudents
@class_code varchar(10)
AS
SELECT s.stu_Id, s.stu_name, s.class_Id
FROM class c
JOIN student s ON  c.class_Id = s.class_Id
WHERE c.class_Id = @class_code 
GO;
EXEC listStudents @class_code = 'SE15C01'
