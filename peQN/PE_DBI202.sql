use SMS_PE
go

-- Q1
select top 5 id_customer as N'Mã khách hàng', first_name as 'Họ',
	last_name as N'Tên', Email as N'Email', phone as N'Số điện Thoại'
from customer
go

-- Q2
select code_product as N'Mã sản phẩm', product_name as N'Tên sản phẩm',
	sum(quantity*price) as N'Tổng tiền tồn kho (VND)'
from product
group by code_product, product_name
go

--Q3
select id_emp as N'Mã nhân viên', first_name as N'Họ',
	last_name as N'Tên', addr as N'Địa chỉ'
from employee
where addr like N'%Nguyễn%'
go

-- Q4
select p.product_name N'Tên sản phẩm'
from invoices i
	inner join inv_detail id on i.num_invoice = id.num_invoice
	inner join product p on p.code_product = id.code_product
where i.order_status like N'Chưa thanh toán đủ'
	and i.purch_date between '2023-9-1' and '2023-9-30'
go

-- Q5
select c.first_name as N'Họ', c.last_name as N'Tên'
from customer c
	inner join invoices i on i.id_customer = c.id_customer
where year(i.purch_date) != 2023 

-- Q6
select p.code_product as N'Mã sản phẩm', p.product_name as N'Tên sản phẩm', 
		 p.price as N'Giá trước khi giảm (VND)', (p.price - (p.price*20)/100) as N'Giá sau khi giảm (VND)'
from product p
where p.code_product in
	 (select producID
		from ( select top 2 id1.code_product as producID, id1.quantity_purch as countQuantity
				from invoices i1
					inner join inv_detail id1 on i1.num_invoice = id1.num_invoice
				where year(i1.purch_date) = 2023
				order by id1.quantity_purch
			)
	as productMin) 
go

-- Q7
create procedure dbo.printListInvoices
@invoiceCode int
as 
	begin
		select i.num_invoice as 'Num invoice', i.purch_date as 'Purch date',
		i.order_status as 'Order status', id.id_det_inv as 'ID detail',
		p.product_name as 'Product name', id.quantity_purch as 'Quantity'
		from invoices i
			inner join inv_detail id on i.num_invoice = id.num_invoice
			inner join product p on p.code_product = id.code_product 
		where  i.num_invoice = @invoiceCode
	end;
go

declare @inCode int 
set @inCode = 1
exec dbo.printListInvoices @inCode

-- Q8
create procedure dbo.listEmpl
@empCode varchar(10) 
as
	begin 
		select c.first_name as 'Họ', c.last_name as 'Tên'
		from employee e
			inner join invoices i on i.id_emp = e.id_emp
			inner join customer c on c.id_customer = i.id_customer
		where @empCode = e.id_emp
	end
go

declare @empCode varchar(10)
set @empCode = 'NV0002'
exec dbo.listEmpl @empCode