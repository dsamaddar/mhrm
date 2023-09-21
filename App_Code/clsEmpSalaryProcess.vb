Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsEmpSalaryProcess

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _EmployeeID, _EmployeeList, _EntryPoint, _ProcessedBy As String

    Public Property EmployeeID() As String
        Get
            Return _EmployeeID
        End Get
        Set(ByVal value As String)
            _EmployeeID = value
        End Set
    End Property

    Public Property EmployeeList() As String
        Get
            Return _EmployeeList
        End Get
        Set(ByVal value As String)
            _EmployeeList = value
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

    Public Property ProcessedBy() As String
        Get
            Return _ProcessedBy
        End Get
        Set(ByVal value As String)
            _ProcessedBy = value
        End Set
    End Property

    Dim _SalaryMonth, _SalaryYear As Integer

    Public Property SalaryMonth() As Integer
        Get
            Return _SalaryMonth
        End Get
        Set(ByVal value As Integer)
            _SalaryMonth = value
        End Set
    End Property

    Public Property SalaryYear() As Integer
        Get
            Return _SalaryYear
        End Get
        Set(ByVal value As Integer)
            _SalaryYear = value
        End Set
    End Property

    Dim _IsSalaryProcessSelected, _IsPBSelected, _IsFBSelected, _IsBaishakhiAllowanceSelected, _IsTDSelected As Boolean

    Public Property IsSalaryProcessSelected() As Boolean
        Get
            Return _IsSalaryProcessSelected
        End Get
        Set(ByVal value As Boolean)
            _IsSalaryProcessSelected = value
        End Set
    End Property

    Public Property IsPBSelected() As Boolean
        Get
            Return _IsPBSelected
        End Get
        Set(ByVal value As Boolean)
            _IsPBSelected = value
        End Set
    End Property

    Public Property IsFBSelected() As Boolean
        Get
            Return _IsFBSelected
        End Get
        Set(ByVal value As Boolean)
            _IsFBSelected = value
        End Set
    End Property

    Public Property IsBaishakhiAllowanceSelected() As Boolean
        Get
            Return _IsBaishakhiAllowanceSelected
        End Get
        Set(ByVal value As Boolean)
            _IsBaishakhiAllowanceSelected = value
        End Set
    End Property

    Public Property IsTDSelected() As Boolean
        Get
            Return _IsTDSelected
        End Get
        Set(ByVal value As Boolean)
            _IsTDSelected = value
        End Set
    End Property

#Region " Check Salary System "

    Public Function fnCheckSalarySystem(ByVal SalProcess As clsEmpSalaryProcess) As String
        Dim EmpSalaryProfile As New clsEmpSalaryProfile()
        Dim sp As String = "spCheckSalarySystem"
        Dim CanProceed As String = ""
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", SalProcess.EmployeeID)
                cmd.Parameters.AddWithValue("@SalaryMonth", SalProcess.SalaryMonth)
                cmd.Parameters.AddWithValue("@SalaryYear", SalProcess.SalaryYear)
                cmd.Parameters.AddWithValue("@IsSalaryProcessSelected", SalProcess.IsSalaryProcessSelected)
                cmd.Parameters.AddWithValue("@IsPBSelected", SalProcess.IsPBSelected)
                cmd.Parameters.AddWithValue("@IsFBSelected", SalProcess.IsFBSelected)
                cmd.Parameters.AddWithValue("@IsBaishakhiAllowanceSelected", SalProcess.IsBaishakhiAllowanceSelected)
                cmd.Parameters.AddWithValue("@IsTDSelected", SalProcess.IsTDSelected)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    CanProceed = dr.Item("CanProceed")
                End While
                con.Close()
                Return CanProceed
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Process Salary "
    Public Function fnProcessSalary(ByVal SalProcess As clsEmpSalaryProcess) As clsResult
        Dim EmpSalaryProfile As New clsEmpSalaryProfile()
        Dim sp As String = "spProcessSalary"
        Dim result As New clsResult()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeList", SalProcess.EmployeeID)
                cmd.Parameters.AddWithValue("@SalaryMonth", SalProcess.SalaryMonth)
                cmd.Parameters.AddWithValue("@SalaryYear", SalProcess.SalaryYear)
                cmd.Parameters.AddWithValue("@IsSalaryProcessSelected", SalProcess.IsSalaryProcessSelected)
                cmd.Parameters.AddWithValue("@IsPBSelected", SalProcess.IsPBSelected)
                cmd.Parameters.AddWithValue("@IsFBSelected", SalProcess.IsFBSelected)
                cmd.Parameters.AddWithValue("@IsBaishakhiAllowanceSelected", SalProcess.IsBaishakhiAllowanceSelected)
                cmd.Parameters.AddWithValue("@IsTDSelected", SalProcess.IsTDSelected)
                cmd.Parameters.AddWithValue("@EntryPoint", SalProcess.EntryPoint)
                cmd.Parameters.AddWithValue("@ProcessedBy", SalProcess.ProcessedBy)
                cmd.ExecuteNonQuery()
                con.Close()
                result.Success = True
                Return result
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

End Class
