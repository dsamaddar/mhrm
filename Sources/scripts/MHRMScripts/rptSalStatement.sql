ALTER proc [dbo].[rptSalStatement]
@EntryPoint nvarchar(50)
as
begin
	select s.EmpCode,s.EmployeeName,s.EmpType,s.JoiningDate,s.DesignationName,s.DeptName,s.ULCBranchName,s.BasicSalary,s.HouseRent,
	s.Medical,s.Conveyance,s.LFA,s.Arrear,s.GrossSalary-s.CarAllowance-s.SpecialAllowance-s.MobileAllowance as GrossSalary,
	s.TaxDeduction,s.LoanDeduction,s.PFDeduction,s.NetDeduction,
	GrossSalary-NetDeduction-s.CarAllowance-s.SpecialAllowance-s.MobileAllowance as net_pay,
	s.SalaryMonth,DATENAME(MONTH, DATEADD(MONTH, s.SalaryMonth, '2023-12-01')) SalaryMonthNm,s.SalaryYear
	from vwSalarySummary s
	Where EntryPoint = @EntryPoint and s.DesignationName not in (
	'Managing Director & CEO','MD','Managing Director'
	)
	order by s.TypeOrder desc;
end

-- exec rptSalStatement '2024244107'