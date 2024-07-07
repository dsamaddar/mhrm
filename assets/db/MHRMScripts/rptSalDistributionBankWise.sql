create proc rptSalDistributionBankWise
@SalaryMonth int,
@SalaryYear int
as
begin
	
	select X.*,DATENAME(MONTH, DATEADD(MONTH, @SalaryMonth, '2023-12-01')) SalaryMonthNm,@SalaryYear as SalaryYear from (
	select b.BankName,count(b.BankName) as emp_size,SUM(GrossSalary-NetDeduction) as amount
	from vwSalarySummary s inner join tblBank b on s.BankID = b.BankID
	Where SalaryMonth = @SalaryMonth and SalaryYear = @SalaryYear
	group by b.BankName
	) X order by X.amount desc;
end