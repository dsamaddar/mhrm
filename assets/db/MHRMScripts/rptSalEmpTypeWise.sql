
alter proc rptSalEmpTypeWise
@SalaryMonth int,
@SalaryYear int
as
begin
	
	select X.*,DATENAME(MONTH, DATEADD(MONTH, @SalaryMonth, '2023-12-01')) SalaryMonthNm,@SalaryYear as SalaryYear from (
	select s.EmpType,count(EmpType) as emp_size,SUM(GrossSalary-NetDeduction) as amount
	from vwSalarySummary s
	Where SalaryMonth = @SalaryMonth and SalaryYear = @SalaryYear
	group by s.EmpType
	) X order by X.amount desc;
end