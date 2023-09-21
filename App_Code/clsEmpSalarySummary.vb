Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Public Class clsEmpSalarySummary

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _EmpSalarySummaryID, _EmployeeID, _EntryPoint, _FinalizedBy, _ProcessedBy As String

    Public Property EmpSalarySummaryID() As String
        Get
            Return _EmpSalarySummaryID
        End Get
        Set(ByVal value As String)
            _EmpSalarySummaryID = value
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

    Public Property EntryPoint() As String
        Get
            Return _EntryPoint
        End Get
        Set(ByVal value As String)
            _EntryPoint = value
        End Set
    End Property

    Dim _BasicSalary, _HouseRent, _Entertainment, _Medical, _Conveyance, _HouseMaintenance, _Consolidated, _LFA, _PerformanceBonus, _
    _FestivalBonus, _BaishakhiAllowance, _ProfessionalAllowance, _SpecialAllowance, _MobileAllowance, _Arrear, _AccountsRecoverable, _
    _PFDeduction, _PBTaxDeduction, _TaxDeduction, _ConveyanceDeduction, _LoanDeduciton, _DonationDeduction, _GrossSalary, _NetDeduction, _
    _NetSalary As Double

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

    Public Property Arrear() As Double
        Get
            Return _Arrear
        End Get
        Set(ByVal value As Double)
            _Arrear = value
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

    Public Property DonationDeduction() As Double
        Get
            Return _DonationDeduction
        End Get
        Set(ByVal value As Double)
            _DonationDeduction = value
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

    Public Property LoanDeduciton() As Double
        Get
            Return _LoanDeduciton
        End Get
        Set(ByVal value As Double)
            _LoanDeduciton = value
        End Set
    End Property

    Public Property GrossSalary() As Double
        Get
            Return _GrossSalary
        End Get
        Set(ByVal value As Double)
            _GrossSalary = value
        End Set
    End Property

    Public Property NetDeduction() As Double
        Get
            Return _NetDeduction
        End Get
        Set(ByVal value As Double)
            _NetDeduction = value
        End Set
    End Property

    Public Property NetSalary() As Double
        Get
            Return _NetSalary
        End Get
        Set(ByVal value As Double)
            _NetSalary = value
        End Set
    End Property

    Dim _IsFinalized As Boolean

    Public Property IsFinalized() As Boolean
        Get
            Return _IsFinalized
        End Get
        Set(ByVal value As Boolean)
            _IsFinalized = value
        End Set
    End Property

    Dim _FinalizedDate, _ProcessedDate As DateTime

    Public Property FinalizedDate() As DateTime
        Get
            Return _FinalizedDate
        End Get
        Set(ByVal value As DateTime)
            _FinalizedDate = value
        End Set
    End Property

    Public Property ProcessedDate() As DateTime
        Get
            Return _ProcessedDate
        End Get
        Set(ByVal value As DateTime)
            _ProcessedDate = value
        End Set
    End Property

    Public Function fnGetSalaryEntryPointForConfirmation() As DataSet
        Dim sp As String = "spGetSalaryEntryPointForConfirmation"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetReportableSalaryEntryPoint() As DataSet
        Dim sp As String = "spGetReportableSalaryEntryPoint"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#Region " Reverse Salary "

    Public Function fnReverseSalary(ByVal EntryPoint As String) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spReverseSalary", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EntryPoint", EntryPoint)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Salary Successfully Reversed."
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

#Region " spFinalizeSalary "

    Public Function fnFinalizeSalary(ByVal EntryPoint As String, ByVal FinalizedBy As String) As clsResult
        Dim Result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spFinalizeSalary", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EntryPoint", EntryPoint)
            cmd.Parameters.AddWithValue("@FinalizedBy", FinalizedBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Result.Success = True
            Result.Message = "Salary Successfully Finalized."
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
