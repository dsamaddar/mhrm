Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsEmpSalaryProfile

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _EmpSalaryProfileID, _EmployeeID, _EntryBy As String

    Public Property EmpSalaryProfileID() As String
        Get
            Return _EmpSalaryProfileID
        End Get
        Set(ByVal value As String)
            _EmpSalaryProfileID = value
        End Set
    End Property

    Public Property EmployeeID() As String
        Get
            Return _EmployeeID
        End Get
        Set(ByVal value As String)
            _EmployeeID = value
        End Set
    End Property

    Public Property EntryBy() As String
        Get
            Return _EntryBy
        End Get
        Set(ByVal value As String)
            _EntryBy = value
        End Set
    End Property

    Dim _GrossSalary, _BasicSalary, _HouseRent, _Entertainment, _Medical, _Conveyance, _HouseMaintenance, _Consolidated, _
    _LFA, _PerformanceBonus, _FestivalBonus, _BaishakhiAllowance, _ProfessionalAllowance, _SpecialAllowance, _MobileAllowance, _CarAllowance, _Utility, _
    _Arrear, _Cash, _AccountsRecoverable, _PFDeduction, _PBTaxDeduction, _TaxDeduction, _ConveyanceDeduction, _LoanDeduction, _DonationDeduction As Double

    Public Property GrossSalary() As Double
        Get
            Return _GrossSalary
        End Get
        Set(ByVal value As Double)
            _GrossSalary = value
        End Set
    End Property

    Public Property BasicSalary() As Double
        Get
            Return _BasicSalary
        End Get
        Set(ByVal value As Double)
            _BasicSalary = value
        End Set
    End Property

    Public Property HouseRent() As Double
        Get
            Return _HouseRent
        End Get
        Set(ByVal value As Double)
            _HouseRent = value
        End Set
    End Property

    Public Property Entertainment() As Double
        Get
            Return _Entertainment
        End Get
        Set(ByVal value As Double)
            _Entertainment = value
        End Set
    End Property

    Public Property Medical() As Double
        Get
            Return _Medical
        End Get
        Set(ByVal value As Double)
            _Medical = value
        End Set
    End Property

    Public Property Conveyance() As Double
        Get
            Return _Conveyance
        End Get
        Set(ByVal value As Double)
            _Conveyance = value
        End Set
    End Property

    Public Property HouseMaintenance() As Double
        Get
            Return _HouseMaintenance
        End Get
        Set(ByVal value As Double)
            _HouseMaintenance = value
        End Set
    End Property

    Public Property Consolidated() As Double
        Get
            Return _Consolidated
        End Get
        Set(ByVal value As Double)
            _Consolidated = value
        End Set
    End Property

    Public Property LFA() As Double
        Get
            Return _LFA
        End Get
        Set(ByVal value As Double)
            _LFA = value
        End Set
    End Property

    Public Property PerformanceBonus() As Double
        Get
            Return _PerformanceBonus
        End Get
        Set(ByVal value As Double)
            _PerformanceBonus = value
        End Set
    End Property

    Public Property FestivalBonus() As Double
        Get
            Return _FestivalBonus
        End Get
        Set(ByVal value As Double)
            _FestivalBonus = value
        End Set
    End Property

    Public Property BaishakhiAllowance() As Double
        Get
            Return _BaishakhiAllowance
        End Get
        Set(ByVal value As Double)
            _BaishakhiAllowance = value
        End Set
    End Property

    Public Property ProfessionalAllowance() As Double
        Get
            Return _ProfessionalAllowance
        End Get
        Set(ByVal value As Double)
            _ProfessionalAllowance = value
        End Set
    End Property

    Public Property SpecialAllowance() As Double
        Get
            Return _SpecialAllowance
        End Get
        Set(ByVal value As Double)
            _SpecialAllowance = value
        End Set
    End Property

    Public Property MobileAllowance() As Double
        Get
            Return _MobileAllowance
        End Get
        Set(ByVal value As Double)
            _MobileAllowance = value
        End Set
    End Property

    Public Property CarAllowance() As Double
        Get
            Return _CarAllowance
        End Get
        Set(ByVal value As Double)
            _CarAllowance = value
        End Set
    End Property

    Public Property Utility() As Double
        Get
            Return _Utility
        End Get
        Set(ByVal value As Double)
            _Utility = value
        End Set
    End Property

    Public Property Arrear() As Double
        Get
            Return _Arrear
        End Get
        Set(ByVal value As Double)
            _Arrear = value
        End Set
    End Property

    Public Property Cash() As Double
        Get
            Return _Cash
        End Get
        Set(ByVal value As Double)
            _Cash = value
        End Set
    End Property

    Public Property AccountsRecoverable() As Double
        Get
            Return _AccountsRecoverable
        End Get
        Set(ByVal value As Double)
            _AccountsRecoverable = value
        End Set
    End Property

    Public Property PFDeduction() As Double
        Get
            Return _PFDeduction
        End Get
        Set(ByVal value As Double)
            _PFDeduction = value
        End Set
    End Property

    Public Property PBTaxDeduction() As Double
        Get
            Return _PBTaxDeduction
        End Get
        Set(ByVal value As Double)
            _PBTaxDeduction = value
        End Set
    End Property

    Public Property TaxDeduction() As Double
        Get
            Return _TaxDeduction
        End Get
        Set(ByVal value As Double)
            _TaxDeduction = value
        End Set
    End Property

    Public Property ConveyanceDeduction() As Double
        Get
            Return _ConveyanceDeduction
        End Get
        Set(ByVal value As Double)
            _ConveyanceDeduction = value
        End Set
    End Property

    Public Property LoanDeduction() As Double
        Get
            Return _LoanDeduction
        End Get
        Set(ByVal value As Double)
            _LoanDeduction = value
        End Set
    End Property

    Public Property DonationDeduction() As Double
        Get
            Return _DonationDeduction
        End Get
        Set(ByVal value As Double)
            _DonationDeduction = value
        End Set
    End Property

    Dim _EntryDate As DateTime

    Public Property EntryDate() As DateTime
        Get
            Return _EntryDate
        End Get
        Set(ByVal value As DateTime)
            _EntryDate = value
        End Set
    End Property

    Dim _EmployeeName, _EmpCode, _Designation As String

    Public Property EmployeeName() As String
        Get
            Return _EmployeeName
        End Get
        Set(ByVal value As String)
            _EmployeeName = value
        End Set
    End Property

    Public Property EmpCode() As String
        Get
            Return _EmpCode
        End Get
        Set(ByVal value As String)
            _EmpCode = value
        End Set
    End Property

    Public Property Designation() As String
        Get
            Return _Designation
        End Get
        Set(ByVal value As String)
            _Designation = value
        End Set
    End Property

    Dim _Tax, _PF, _Gross, _Deduction, _Net As Double

    Public Property Tax() As String
        Get
            Return _Tax
        End Get
        Set(ByVal value As String)
            _Tax = value
        End Set
    End Property

    Public Property PF() As String
        Get
            Return _PF
        End Get
        Set(ByVal value As String)
            _PF = value
        End Set
    End Property

    Public Property Gross() As Double
        Get
            Return _Gross
        End Get
        Set(ByVal value As Double)
            _Gross = value
        End Set
    End Property

    Public Property Deduction() As Double
        Get
            Return _Deduction
        End Get
        Set(ByVal value As Double)
            _Deduction = value
        End Set
    End Property

    Public Property Net() As Double
        Get
            Return _Net
        End Get
        Set(ByVal value As Double)
            _Net = value
        End Set
    End Property

#Region " Get Emp Salary Profile "

    Public Function fnGetEmpSalaryProfile(ByVal EmployeeID As String) As clsEmpSalaryProfile
        Dim EmpSalaryProfile As New clsEmpSalaryProfile()
        Dim sp As String = "spGetEmpSalaryProfile"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    EmpSalaryProfile.EmpSalaryProfileID = dr.Item("EmpSalaryProfileID")
                    EmpSalaryProfile.GrossSalary = dr.Item("GrossSalary")
                    EmpSalaryProfile.BasicSalary = dr.Item("BasicSalary")
                    EmpSalaryProfile.HouseRent = dr.Item("HouseRent")
                    EmpSalaryProfile.Entertainment = dr.Item("Entertainment")
                    EmpSalaryProfile.Medical = dr.Item("Medical")
                    EmpSalaryProfile.Conveyance = dr.Item("Conveyance")
                    EmpSalaryProfile.HouseMaintenance = dr.Item("HouseMaintenance")
                    EmpSalaryProfile.Consolidated = dr.Item("Consolidated")
                    EmpSalaryProfile.LFA = dr.Item("LFA")
                    EmpSalaryProfile.PerformanceBonus = dr.Item("PerformanceBonus")
                    EmpSalaryProfile.FestivalBonus = dr.Item("FestivalBonus")
                    EmpSalaryProfile.BaishakhiAllowance = dr.Item("BaishakhiAllowance")
                    EmpSalaryProfile.ProfessionalAllowance = dr.Item("ProfessionalAllowance")
                    EmpSalaryProfile.SpecialAllowance = dr.Item("SpecialAllowance")
                    EmpSalaryProfile.MobileAllowance = dr.Item("MobileAllowance")
                    EmpSalaryProfile.CarAllowance = dr.Item("CarAllowance")
                    EmpSalaryProfile.Utility = dr.Item("Utility")
                    EmpSalaryProfile.Arrear = dr.Item("Arrear")
                    EmpSalaryProfile.Cash = dr.Item("Cash")
                    EmpSalaryProfile.AccountsRecoverable = dr.Item("AccountsRecoverable")
                    EmpSalaryProfile.PFDeduction = dr.Item("PFDeduction")
                    EmpSalaryProfile.PBTaxDeduction = dr.Item("PBTaxDeduction")
                    EmpSalaryProfile.TaxDeduction = dr.Item("TaxDeduction")
                    EmpSalaryProfile.ConveyanceDeduction = dr.Item("ConveyanceDeduction")
                    EmpSalaryProfile.LoanDeduction = dr.Item("LoanDeduction")
                    EmpSalaryProfile.DonationDeduction = dr.Item("DonationDeduction")
                    EmpSalaryProfile.EntryBy = dr.Item("EntryBy")
                    EmpSalaryProfile.EntryDate = dr.Item("EntryDate")
                End While
                con.Close()
                Return EmpSalaryProfile
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetEmpSalaryByID(ByVal EmployeeID As String) As clsEmpSalaryProfile
        Dim EmpSalaryProfile As New clsEmpSalaryProfile()
        Dim sp As String = "spGetEmpSalaryByID"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    EmpSalaryProfile.EmployeeName = dr.Item("EmployeeName")
                    EmpSalaryProfile.EmpCode = dr.Item("EmpCode")
                    EmpSalaryProfile.Designation = dr.Item("Designation")
                    EmpSalaryProfile.BasicSalary = dr.Item("BasicSalary")
                    EmpSalaryProfile.Consolidated = dr.Item("Consolidated")
                    EmpSalaryProfile.HouseRent = dr.Item("HouseRent")
                    EmpSalaryProfile.Medical = dr.Item("Medical")
                    EmpSalaryProfile.Entertainment = dr.Item("Entertainment")
                    EmpSalaryProfile.Conveyance = dr.Item("Conveyance")
                    EmpSalaryProfile.HouseMaintenance = dr.Item("HouseMaintenance")
                    EmpSalaryProfile.PF = dr.Item("PF")
                    EmpSalaryProfile.Tax = dr.Item("Tax")
                    EmpSalaryProfile.Gross = dr.Item("Gross")
                    EmpSalaryProfile.Deduction = dr.Item("Deduction")
                    EmpSalaryProfile.Net = dr.Item("Net")
                End While
                con.Close()
                Return EmpSalaryProfile
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Insert Emp Salary Profile "
    Public Function fnInsertEmpSalaryProfile(ByVal EmpSalaryProfile As clsEmpSalaryProfile) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertEmpSalaryProfile", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", EmpSalaryProfile.EmployeeID)
            cmd.Parameters.AddWithValue("@GrossSalary", EmpSalaryProfile.GrossSalary)
            cmd.Parameters.AddWithValue("@BasicSalary", EmpSalaryProfile.BasicSalary)
            cmd.Parameters.AddWithValue("@HouseRent", EmpSalaryProfile.HouseRent)
            cmd.Parameters.AddWithValue("@Entertainment", EmpSalaryProfile.Entertainment)
            cmd.Parameters.AddWithValue("@Medical", EmpSalaryProfile.Medical)
            cmd.Parameters.AddWithValue("@Conveyance", EmpSalaryProfile.Conveyance)
            cmd.Parameters.AddWithValue("@HouseMaintenance", EmpSalaryProfile.HouseMaintenance)
            cmd.Parameters.AddWithValue("@Consolidated", EmpSalaryProfile.Consolidated)
            cmd.Parameters.AddWithValue("@LFA", EmpSalaryProfile.LFA)
            cmd.Parameters.AddWithValue("@PerformanceBonus", EmpSalaryProfile.PerformanceBonus)
            cmd.Parameters.AddWithValue("@FestivalBonus", EmpSalaryProfile.FestivalBonus)
            cmd.Parameters.AddWithValue("@BaishakhiAllowance", EmpSalaryProfile.BaishakhiAllowance)
            cmd.Parameters.AddWithValue("@ProfessionalAllowance", EmpSalaryProfile.ProfessionalAllowance)
            cmd.Parameters.AddWithValue("@SpecialAllowance", EmpSalaryProfile.SpecialAllowance)
            cmd.Parameters.AddWithValue("@MobileAllowance", EmpSalaryProfile.MobileAllowance)
            cmd.Parameters.AddWithValue("@CarAllowance", EmpSalaryProfile.CarAllowance)
            cmd.Parameters.AddWithValue("@Utility", EmpSalaryProfile.Utility)
            cmd.Parameters.AddWithValue("@Arrear", EmpSalaryProfile.Arrear)
            cmd.Parameters.AddWithValue("@Cash", EmpSalaryProfile.Cash)
            cmd.Parameters.AddWithValue("@AccountsRecoverable", EmpSalaryProfile.AccountsRecoverable)
            cmd.Parameters.AddWithValue("@PFDeduction", EmpSalaryProfile.PFDeduction)
            cmd.Parameters.AddWithValue("@PBTaxDeduction", EmpSalaryProfile.PBTaxDeduction)
            cmd.Parameters.AddWithValue("@TaxDeduction", EmpSalaryProfile.TaxDeduction)
            cmd.Parameters.AddWithValue("@ConveyanceDeduction", EmpSalaryProfile.ConveyanceDeduction)
            cmd.Parameters.AddWithValue("@LoanDeduction", EmpSalaryProfile.LoanDeduction)
            cmd.Parameters.AddWithValue("@DonationDeduction", EmpSalaryProfile.DonationDeduction)
            cmd.Parameters.AddWithValue("@EntryBy", EmpSalaryProfile.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()

            Result.Success = True
            Result.Message = "Successfully Inserted."
            Return Result
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Result.Success = False
            Result.Message = ex.Message
            Return Result
        End Try
    End Function
#End Region

#Region " Update Emp Salary Profile "
    Public Function fnUpdateEmpSalaryProfile(ByVal EmpSalaryProfile As clsEmpSalaryProfile) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateEmpSalaryProfile", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@EmpSalaryProfileID", EmpSalaryProfile.EmpSalaryProfileID)
            cmd.Parameters.AddWithValue("@EmployeeID", EmpSalaryProfile.EmployeeID)
            cmd.Parameters.AddWithValue("@GrossSalary", EmpSalaryProfile.GrossSalary)
            cmd.Parameters.AddWithValue("@BasicSalary", EmpSalaryProfile.BasicSalary)
            cmd.Parameters.AddWithValue("@HouseRent", EmpSalaryProfile.HouseRent)
            cmd.Parameters.AddWithValue("@Entertainment", EmpSalaryProfile.Entertainment)
            cmd.Parameters.AddWithValue("@Medical", EmpSalaryProfile.Medical)
            cmd.Parameters.AddWithValue("@Conveyance", EmpSalaryProfile.Conveyance)
            cmd.Parameters.AddWithValue("@HouseMaintenance", EmpSalaryProfile.HouseMaintenance)
            cmd.Parameters.AddWithValue("@Consolidated", EmpSalaryProfile.Consolidated)
            cmd.Parameters.AddWithValue("@LFA", EmpSalaryProfile.LFA)
            cmd.Parameters.AddWithValue("@PerformanceBonus", EmpSalaryProfile.PerformanceBonus)
            cmd.Parameters.AddWithValue("@FestivalBonus", EmpSalaryProfile.FestivalBonus)
            cmd.Parameters.AddWithValue("@BaishakhiAllowance", EmpSalaryProfile.BaishakhiAllowance)
            cmd.Parameters.AddWithValue("@ProfessionalAllowance", EmpSalaryProfile.ProfessionalAllowance)
            cmd.Parameters.AddWithValue("@SpecialAllowance", EmpSalaryProfile.SpecialAllowance)
            cmd.Parameters.AddWithValue("@MobileAllowance", EmpSalaryProfile.MobileAllowance)
            cmd.Parameters.AddWithValue("@CarAllowance", EmpSalaryProfile.CarAllowance)
            cmd.Parameters.AddWithValue("@Utility", EmpSalaryProfile.Utility)
            cmd.Parameters.AddWithValue("@Arrear", EmpSalaryProfile.Arrear)
            cmd.Parameters.AddWithValue("@Cash", EmpSalaryProfile.Cash)
            cmd.Parameters.AddWithValue("@AccountsRecoverable", EmpSalaryProfile.AccountsRecoverable)
            cmd.Parameters.AddWithValue("@PFDeduction", EmpSalaryProfile.PFDeduction)
            cmd.Parameters.AddWithValue("@PBTaxDeduction", EmpSalaryProfile.PBTaxDeduction)
            cmd.Parameters.AddWithValue("@TaxDeduction", EmpSalaryProfile.TaxDeduction)
            cmd.Parameters.AddWithValue("@ConveyanceDeduction", EmpSalaryProfile.ConveyanceDeduction)
            cmd.Parameters.AddWithValue("@LoanDeduction", EmpSalaryProfile.LoanDeduction)
            cmd.Parameters.AddWithValue("@DonationDeduction", EmpSalaryProfile.DonationDeduction)
            cmd.Parameters.AddWithValue("@EntryBy", EmpSalaryProfile.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()

            Result.Success = True
            Result.Message = "Successfully Updated."
            Return Result
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Result.Success = False
            Result.Message = ex.Message
            Return Result
        End Try
    End Function
#End Region

End Class
