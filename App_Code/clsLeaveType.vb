Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsLeaveType

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _LeaveTypeID, _LeaveType, _EntryBy As String

    Public Property LeaveTypeID() As String
        Get
            Return _LeaveTypeID
        End Get
        Set(ByVal value As String)
            _LeaveTypeID = value
        End Set
    End Property

    Public Property LeaveType() As String
        Get
            Return _LeaveType
        End Get
        Set(ByVal value As String)
            _LeaveType = value
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

    Dim _OnlyForMale, _OnlyForFemale, _IsDedFrmLeaveBalance, _IsActive, _IsCarryForwardEnabled As Boolean

    Public Property OnlyForMale() As Boolean
        Get
            Return _OnlyForMale
        End Get
        Set(ByVal value As Boolean)
            _OnlyForMale = value
        End Set
    End Property

    Public Property OnlyForFemale() As Boolean
        Get
            Return _OnlyForFemale
        End Get
        Set(ByVal value As Boolean)
            _OnlyForFemale = value
        End Set
    End Property

    Public Property IsDedFrmLeaveBalance() As Boolean
        Get
            Return _IsDedFrmLeaveBalance
        End Get
        Set(ByVal value As Boolean)
            _IsDedFrmLeaveBalance = value
        End Set
    End Property

    Public Property IsActive() As Boolean
        Get
            Return _IsActive
        End Get
        Set(ByVal value As Boolean)
            _IsActive = value
        End Set
    End Property

    Public Property IsCarryForwardEnabled() As Boolean
        Get
            Return _IsCarryForwardEnabled
        End Get
        Set(ByVal value As Boolean)
            _IsCarryForwardEnabled = value
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

    Dim _YearlyBalanceForward, _MaxBalance As Integer

    Public Property YearlyBalanceForward() As Integer
        Get
            Return _YearlyBalanceForward
        End Get
        Set(ByVal value As Integer)
            _YearlyBalanceForward = value
        End Set
    End Property

    Public Property MaxBalance() As Integer
        Get
            Return _MaxBalance
        End Get
        Set(ByVal value As Integer)
            _MaxBalance = value
        End Set
    End Property

#Region " Insert Leave Type "

    Public Function fnInsertLeaveType(ByVal LeaveType As clsLeaveType) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertLeaveType", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@LeaveType", LeaveType.LeaveType)
            cmd.Parameters.AddWithValue("@OnlyForMale", LeaveType.OnlyForMale)
            cmd.Parameters.AddWithValue("@OnlyForFemale", LeaveType.OnlyForFemale)
            cmd.Parameters.AddWithValue("@IsDedFrmLeaveBalance", LeaveType.IsDedFrmLeaveBalance)
            cmd.Parameters.AddWithValue("@IsCarryForwardEnabled", LeaveType.IsCarryForwardEnabled)
            cmd.Parameters.AddWithValue("@YearlyBalanceForward", LeaveType.YearlyBalanceForward)
            cmd.Parameters.AddWithValue("@MaxBalance", LeaveType.MaxBalance)
            cmd.Parameters.AddWithValue("@IsActive", LeaveType.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", LeaveType.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

#End Region

#Region " Update Leave Type "

    Public Function fnUpdateLeaveType(ByVal LeaveType As clsLeaveType) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateLeaveType", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@LeaveTypeID", LeaveType.LeaveTypeID)
            cmd.Parameters.AddWithValue("@LeaveType", LeaveType.LeaveType)
            cmd.Parameters.AddWithValue("@OnlyForMale", LeaveType.OnlyForMale)
            cmd.Parameters.AddWithValue("@OnlyForFemale", LeaveType.OnlyForFemale)
            cmd.Parameters.AddWithValue("@IsDedFrmLeaveBalance", LeaveType.IsDedFrmLeaveBalance)
            cmd.Parameters.AddWithValue("@IsCarryForwardEnabled", LeaveType.IsCarryForwardEnabled)
            cmd.Parameters.AddWithValue("@YearlyBalanceForward", LeaveType.YearlyBalanceForward)
            cmd.Parameters.AddWithValue("@MaxBalance", LeaveType.MaxBalance)
            cmd.Parameters.AddWithValue("@IsActive", LeaveType.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", LeaveType.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function

#End Region

#Region " Show Leave Type "

    Public Function fnShowLeaveType() As DataSet

        Dim sp As String = "spShowLeaveType"
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

#End Region

#Region " Get Leave Settings By ID "

    Public Function fnGetLeaveSettingsByID(ByVal LeaveTypeID As String) As clsLeaveType
        Dim LeaveType As New clsLeaveType()
        Dim sp As String = "spGetLeaveSettingsInfoByID"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@LeaveTypeID", LeaveTypeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    LeaveType.LeaveType = dr.Item("LeaveType")
                    LeaveType.OnlyForMale = dr.Item("OnlyForMale")
                    LeaveType.OnlyForFemale = dr.Item("OnlyForFemale")
                    LeaveType.IsDedFrmLeaveBalance = dr.Item("IsDedFrmLeaveBalance")
                    LeaveType.IsCarryForwardEnabled = dr.Item("IsCarryForwardEnabled")
                    LeaveType.YearlyBalanceForward = dr.Item("YearlyBalanceForward")
                    LeaveType.MaxBalance = dr.Item("MaxBalance")
                    LeaveType.IsActive = dr.Item("IsActive")
                End While
                con.Close()

                Return LeaveType
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Show Leave Type Active List "

    Public Function fnShowLeaveTypeActive() As DataSet

        Dim sp As String = "spGetLeaveType"
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

#End Region

#Region " Get Query On Leave "

    Public Function fnGetQueryForLeave(ByVal EmployeeID As String, ByVal LeaveYear As String, ByVal LeaveTypeID As String) As DataSet

        Dim sp As String = "spGetQueryOnLeave"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                cmd.Parameters.AddWithValue("@LeaveYear", LeaveYear)
                cmd.Parameters.AddWithValue("@LeaveTypeID", LeaveTypeID)
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
