Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsLateAttendanceCause

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _LateAttCauseID, _Cause, _EntryBy, _ReportableToDept As String

    Public Property LateAttCauseID() As String
        Get
            Return _LateAttCauseID
        End Get
        Set(ByVal value As String)
            _LateAttCauseID = value
        End Set
    End Property

    Public Property Cause() As String
        Get
            Return _Cause
        End Get
        Set(ByVal value As String)
            _Cause = value
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

    Public Property ReportableToDept() As String
        Get
            Return _ReportableToDept
        End Get
        Set(ByVal value As String)
            _ReportableToDept = value
        End Set
    End Property

    Dim _IsReportable, _IsDetailsMandatory, _IsActive As Boolean

    Public Property IsReportable() As Boolean
        Get
            Return _IsReportable
        End Get
        Set(ByVal value As Boolean)
            _IsReportable = value
        End Set
    End Property

    Public Property IsDetailsMandatory() As Boolean
        Get
            Return _IsDetailsMandatory
        End Get
        Set(ByVal value As Boolean)
            _IsDetailsMandatory = value
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

    Dim _EntryDate As DateTime

    Public Property EntryDate() As DateTime
        Get
            Return _EntryDate
        End Get
        Set(ByVal value As DateTime)
            _EntryDate = value
        End Set
    End Property

#Region " Insert Late Att Cause "
    Public Function fnInsertLateAttCause(ByVal LateAttCause As clsLateAttendanceCause) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertLateAttCause", con)
            con.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@Cause", LateAttCause.Cause)
            cmd.Parameters.AddWithValue("@IsDetailsMandatory", LateAttCause.IsDetailsMandatory)
            cmd.Parameters.AddWithValue("@IsReportable", LateAttCause.IsReportable)
            cmd.Parameters.AddWithValue("@IsActive", LateAttCause.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", LateAttCause.EntryBy)

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

#Region " Update Late Att Cause "
    Public Function fnUpdateLateAttCause(ByVal LateAttCause As clsLateAttendanceCause) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateLateAttCause", con)
            con.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@LateAttCauseID", LateAttCause.LateAttCauseID)
            cmd.Parameters.AddWithValue("@Cause", LateAttCause.Cause)
            cmd.Parameters.AddWithValue("@IsDetailsMandatory", LateAttCause.IsDetailsMandatory)
            cmd.Parameters.AddWithValue("@IsReportable", LateAttCause.IsReportable)
            cmd.Parameters.AddWithValue("@IsActive", LateAttCause.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", LateAttCause.EntryBy)
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

#Region " Show Late Att Cause List "

    Public Function fnShowLateAttCauseList() As DataSet

        Dim sp As String = "spShowLateAttCauseList"
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

#Region " Get Active Late Att Cause "

    Public Function fnGetActiveLateAttCause() As DataSet

        Dim sp As String = "spGetActiveLateAttCause"
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

End Class
