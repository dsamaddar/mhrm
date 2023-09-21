Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsEmpLeaveBalance

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _EmpLeaveBalanceID, _EmployeeID, _EntryBy As String

    Public Property EmpLeaveBalanceID() As String
        Get
            Return _EmpLeaveBalanceID
        End Get
        Set(ByVal value As String)
            _EmpLeaveBalanceID = value
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

    Dim _CasualLeave, _MedicalLeave, _AnnualLeave, _MaternityLeave, _LeaveWithOutPay, _SpecialLeave, _SickLeave, _TotalLeave, _LeaveYear As Integer

    Public Property CasualLeave() As Integer
        Get
            Return _CasualLeave
        End Get
        Set(ByVal value As Integer)
            _CasualLeave = value
        End Set
    End Property

    Public Property MedicalLeave() As Integer
        Get
            Return _MedicalLeave
        End Get
        Set(ByVal value As Integer)
            _MedicalLeave = value
        End Set
    End Property

    Public Property AnnualLeave() As Integer
        Get
            Return _AnnualLeave
        End Get
        Set(ByVal value As Integer)
            _AnnualLeave = value
        End Set
    End Property

    Public Property MaternityLeave() As Integer
        Get
            Return _MaternityLeave
        End Get
        Set(ByVal value As Integer)
            _MaternityLeave = value
        End Set
    End Property

    Public Property LeaveWithOutPay() As Integer
        Get
            Return _LeaveWithOutPay
        End Get
        Set(ByVal value As Integer)
            _LeaveWithOutPay = value
        End Set
    End Property

    Public Property SpecialLeave() As Integer
        Get
            Return _SpecialLeave
        End Get
        Set(ByVal value As Integer)
            _SpecialLeave = value
        End Set
    End Property

    Public Property SickLeave() As Integer
        Get
            Return _SickLeave
        End Get
        Set(ByVal value As Integer)
            _SickLeave = value
        End Set
    End Property

    Public Property TotalLeave() As Integer
        Get
            Return _TotalLeave
        End Get
        Set(ByVal value As Integer)
            _TotalLeave = value
        End Set
    End Property

    Public Property LeaveYear() As Integer
        Get
            Return _LeaveYear
        End Get
        Set(ByVal value As Integer)
            _LeaveYear = value
        End Set
    End Property

    Dim _IsActive As Boolean

    Public Property IsActive() As Boolean
        Get
            Return _IsActive
        End Get
        Set(ByVal value As Boolean)
            _IsActive = value
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

#Region " Insert Emp Leave Balance "
    Public Function fnInsertEmpLeaveBalance(ByVal EmpLeaveBalance As clsEmpLeaveBalance) As clsResult
        Dim result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertEmpLeaveBalance", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", EmpLeaveBalance.EmployeeID)
            cmd.Parameters.AddWithValue("@CasualLeave", EmpLeaveBalance.CasualLeave)
            cmd.Parameters.AddWithValue("@MedicalLeave", EmpLeaveBalance.MedicalLeave)
            cmd.Parameters.AddWithValue("@AnnualLeave", EmpLeaveBalance.AnnualLeave)
            cmd.Parameters.AddWithValue("@MaternityLeave", EmpLeaveBalance.MaternityLeave)
            cmd.Parameters.AddWithValue("@LeaveWithOutPay", EmpLeaveBalance.LeaveWithOutPay)
            cmd.Parameters.AddWithValue("@SpecialLeave", EmpLeaveBalance.SpecialLeave)
            cmd.Parameters.AddWithValue("@SickLeave", EmpLeaveBalance.SickLeave)
            cmd.Parameters.AddWithValue("@LeaveYear", EmpLeaveBalance.LeaveYear)
            cmd.Parameters.AddWithValue("@EntryBy", EmpLeaveBalance.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            result.Success = True
            result.Message = "Leave Balance Inserted Successfully."
            Return result
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            result.Success = False
            result.Message = ex.Message
            Return result
        End Try
    End Function
#End Region

#Region " Update Emp Leave Balance "
    Public Function fnUpdateEmpLeaveBalance(ByVal EmpLeaveBalance As clsEmpLeaveBalance) As clsResult
        Dim result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateEmpLeaveBalance", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmpLeaveBalanceID", EmpLeaveBalance.EmpLeaveBalanceID)
            cmd.Parameters.AddWithValue("@EmployeeID", EmpLeaveBalance.EmployeeID)
            cmd.Parameters.AddWithValue("@CasualLeave", EmpLeaveBalance.CasualLeave)
            cmd.Parameters.AddWithValue("@MedicalLeave", EmpLeaveBalance.MedicalLeave)
            cmd.Parameters.AddWithValue("@AnnualLeave", EmpLeaveBalance.AnnualLeave)
            cmd.Parameters.AddWithValue("@MaternityLeave", EmpLeaveBalance.MaternityLeave)
            cmd.Parameters.AddWithValue("@LeaveWithOutPay", EmpLeaveBalance.LeaveWithOutPay)
            cmd.Parameters.AddWithValue("@SpecialLeave", EmpLeaveBalance.SpecialLeave)
            cmd.Parameters.AddWithValue("@SickLeave", EmpLeaveBalance.SickLeave)
            cmd.Parameters.AddWithValue("@LeaveYear", EmpLeaveBalance.LeaveYear)
            cmd.Parameters.AddWithValue("@EntryBy", EmpLeaveBalance.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            result.Success = True
            result.Message = "Leave Balance Updated Successfully."
            Return result
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            result.Success = False
            result.Message = ex.Message
            Return result
        End Try
    End Function
#End Region

#Region " Process Yearly Leave Balance "

    Public Function fnProcessYearlyLeaveBalance(ByVal EmpLeaveBalance As clsEmpLeaveBalance) As clsResult
        Dim result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spProcessYearlyLeaveBalance", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@LeaveYear", EmpLeaveBalance.LeaveYear)
            cmd.Parameters.AddWithValue("@EntryBy", EmpLeaveBalance.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            result.Success = True
            result.Message = "Leave Balance Updated Successfully."
            Return result
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            result.Success = False
            result.Message = ex.Message
            Return result
        End Try
    End Function
#End Region

#Region " Get All Emp Leave Balance "
    Public Function fnGetAllEmpLeaveBalance(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetAllEmpLeaveBalance"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
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
#End Region

#Region " Get SubOrdinate Leave Balance "
    Public Function fnGetSubOrdinateLeaveBalance(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetSubOrdinateLeaveBalance"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
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

#End Region

End Class
