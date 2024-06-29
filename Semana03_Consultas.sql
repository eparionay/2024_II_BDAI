-- 1 LISTAR LOS PAISES
SELECT	* from countries
-- 2 Listar las regiones
select * from regions
-- 3 Listar los empleados
select * from employees
-- 4 Listar los departamentos
select * from departments
-- 5 Listar los 5 empleados
select top 5 * from employees
-- 6 -- Listar los empleados
-- cambiar el nombre de employee_id=>codigo
-- first_name => nombre, last_name => apellido
select employee_id as [Codigo], 
	   first_name as [Nombres],
	   last_name as  [Apellidos]
	from employees
-- 7 Listar el nombre completo de los empledos
select first_name  + ' ' + last_name as [NombreCompleto]
		from employees

select CONCAT('*',first_name, ' ', last_name, ' *') as NombreCompleto
from employees
-- ASC => ASCENDENTE   DESC => DESCENDENTE
-- Ordenar los empleados por su apellido de manera desc
select * from employees order by last_name desc
-- Ordenar los empleados por su apellido de manera asc
select * from employees order by last_name asc
-- Mostrar el codigo, nombre, apellido y fecha de 
-- contratacion de los empleados
select  employee_id, first_name, last_name, hire_date
	from employees
-- Consultar los datos del empleado 100
select * from employees where employee_id=100
-- Seleccionar los empleados que fueron contratados 
-- en el año 1987
select * FROM employees where  Year(hire_date) = 1987
-- Seleccionar los empleados que tienen su salario
-- en el rango de 1000 a 5000
select * from employees where salary between 1000 and 5000
go
-- Seleccionar los codigos 100 y 103 de la tabla empleados
select * from employees where employee_id in (100, 200, 300)
go
-- Seleccionar las regiones y paises

select c.country_name, r.region_name
		from regions r inner join countries c
			 on r.region_id = c.region_id
			 -- order by 2 asc
			 order by r.region_name asc



-- Union de 3 Tablas
select *
from jobs j inner join
employees e on j.job_id= e.job_id
inner join departments d on
d.department_id= e.department_id


select * from jobs j 
inner join employees e on j.job_id= e.job_id
inner join departments d  on d.department_id= e.department_id
inner join locations l on l.location_id= d.location_id
inner join countries c on c.country_id=l.country_id
inner join regions r on r.region_id= c.region_id
-- Seleccionar los empleados que ganan mas de 5000 y que su codigo de trabajo
-- sea 5   (salary, job_id)
select	employee_id, first_name, last_name
	from employees where salary> 5000 and job_id=5
-- Seleccionar todos los empleados excepto los del job_id 5
select * from employees where   job_id not in (5)
select * from employees where job_id <> 5
-- seleccionar los empleados que inician con la letra a
select * from employees where last_name like 'a%'
-- seleccionar los empleados que terminar en la letra ar
select * from employees where last_name like '%a'
-- seleccionar los empleados de una determinado palabra
select * from employees where last_name like '%ta%'
-- seleccionar los empleados que inician con la letra a,b
select * from employees where last_name like '[a-b]%'
-- seleccionar los empleados que no inicien con la letra a
select * from employees where last_name not like 'a%'
-- Seleccionar la cantidad de empleados
select count(*)  as TotalEmpleados from employees
-- Seleccionar el salario maximo de la tabla empleados
select  max(salary)  from employees
-- seleccionar el salario minimo de la tabla empleados
select min(salary) from employees
-- Obtener la sumatoria de los salarios
-- de todos los empleados
select sum(salary) from employees
-- obtener el promedio de los salarios
select avg(salary) from employees
-- Seleccionar la persona y el nombre de departamento asignado
select e.employee_id, e.last_name, d.department_name
from employees e inner join departments d
	on e.department_id= d.department_id
-- Obtener la cantidad de empleados por departamentos


select department_id ,  count(*) as TotalPersonas from employees
group by department_id


select d.department_name, count(*) as TotalEmpleados
from employees e inner join departments d
	on e.department_id= d.department_id
	group by d.department_name
	order by 1 asc
--- Seleccionar a las areas que tengan mas de 5 personas
select d.department_name, count(*) as TotalEmpleados
from employees e inner join departments d
	on e.department_id= d.department_id
	group by d.department_name
	having count(*)>5
	order by 1 asc









