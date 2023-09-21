Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsNodes

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _NodeID, _NodeName, _NodeBranchID, _NodeDescription, _EntryBy As String

    Public Property NodeID() As String
        Get
            Return _NodeID
        End Get
        Set(ByVal value As String)
            _NodeID = value
        End Set
    End Property

    Public Property NodeName() As String
        Get
            Return _NodeName
        End Get
        Set(ByVal value As String)
            _NodeName = value
        End Set
    End Property

    Public Property NodeBranchID() As String
        Get
            Return _NodeBranchID
        End Get
        Set(ByVal value As String)
            _NodeBranchID = value
        End Set
    End Property

    Public Property NodeDescription() As String
        Get
            Return _NodeDescription
        End Get
        Set(ByVal value As String)
            _NodeDescription = value
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

    Dim _NodeCode As Integer

    Public Property NodeCode() As Integer
        Get
            Return _NodeCode
        End Get
        Set(ByVal value As Integer)
            _NodeCode = value
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


#Region " Insert Attendance Node "
    Public Function fnInsertAttendanceNode(ByVal Node As clsNodes) As clsResult
        Dim result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertAttendanceNode", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@NodeCode", Node.NodeCode)
            cmd.Parameters.AddWithValue("@NodeName", Node.NodeName)
            cmd.Parameters.AddWithValue("@NodeBranchID", Node.NodeBranchID)
            cmd.Parameters.AddWithValue("@NodeDescription", Node.NodeDescription)
            cmd.Parameters.AddWithValue("@IsActive", Node.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", Node.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            result.Success = True
            result.Message = "Attendance Node Inserted Successfully."
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

#Region " Update Attendance Node "
    Public Function fnUpdateAttendanceNode(ByVal Node As clsNodes) As clsResult
        Dim result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateAttendanceNode", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@NodeID", Node.NodeID)
            cmd.Parameters.AddWithValue("@NodeCode", Node.NodeCode)
            cmd.Parameters.AddWithValue("@NodeName", Node.NodeName)
            cmd.Parameters.AddWithValue("@NodeBranchID", Node.NodeBranchID)
            cmd.Parameters.AddWithValue("@NodeDescription", Node.NodeDescription)
            cmd.Parameters.AddWithValue("@IsActive", Node.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", Node.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            result.Success = True
            result.Message = "Attendance Node Updated Successfully."
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

#Region " Show Node List "

    Public Function fnShowNodeList() As DataSet

        Dim sp As String = "spShowNodeList"
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
