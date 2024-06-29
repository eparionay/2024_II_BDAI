
CREATE OR ALTER FUNCTION FN_EMPLOYEE_X_ID(@EMPLOYEE int)
RETURNS TABLE
as
return(
	select * from employees where employee_id=@EMPLOYEE
)
go

CREATE OR ALTER FUNCTION FN_EMPLOYEE_X_Codigo(@EMPLOYEE int)
RETURNS int
as
begin
	Declare @codigo int
	set @codigo= @EMPLOYEE
	-- select @codigo=@EMPLOYEE
return @codigo
end
go

select dbo.FN_EMPLOYEE_X_Codigo(1)

select * from dbo.FN_EMPLOYEE_X_ID(100)

select * from regions

create procedure usp_region_crud
@codigo int,
@mensaje varchar(20) output
as
begin
	select @mensaje=last_name  from employees where employee_id=@codigo

end
go


Declare @mensaje varchar(20)
execute usp_region_crud 100, @mensaje output
print @mensaje

execute usp_region_crud 100, ''







