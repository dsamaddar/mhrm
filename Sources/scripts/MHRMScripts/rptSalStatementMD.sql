alter proc rptSalStatementMD
@EntryPoint nvarchar(50)
as
begin
	select s.EmpCode,s.EmployeeName,s.EmpType,s.JoiningDate,s.DesignationName,s.DeptName,s.ULCBranchName,s.BasicSalary,s.HouseRent,
	s.Medical,s.Conveyance,s.LFA,s.Arrear,s.CarAllowance,s.Utility,s.MobileAllowance,s.HouseMaintenance,
	s.GrossSalary as GrossSalary,
	s.TaxDeduction,s.LoanDeduction,s.PFDeduction,s.NetDeduction,
	GrossSalary-NetDeduction as net_pay,
	s.SalaryMonth,DATENAME(MONTH, DATEADD(MONTH, s.SalaryMonth, '2023-12-01')) SalaryMonthNm,s.SalaryYear
	from vwSalarySummary s
	Where EntryPoint = @EntryPoint and s.DesignationName in (
	'Managing Director & CEO','MD','Managing Director'
	)
end