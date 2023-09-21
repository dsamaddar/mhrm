Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Public Class clsOrgBranch

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _ULCBranchID, _ULCBranchName, _BranchLocation, _RegionID, _EntryBy As String

    Public Property ULCBranchID() As String
        Get
            Return _ULCBranchID
        End Get
        Set(ByVal value As String)
            _ULCBranchID = value
        End Set
    End Property

    Public Property ULCBranchName() As String
        Get
            Return _ULCBranchName
        End Get
        Set(ByVal value As String)
            _ULCBranchName = value
        End Set
    End Property

    Public Property BranchLocation() As String
        Get
            Return _BranchLocation
        End Get
        Set(ByVal value As String)
            _BranchLocation = value
        End Set
    End Property

    Public Property RegionID() As String
        Get
            Return _RegionID
        End Get
        Set(ByVal value As String)
            _RegionID = value
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

    Dim _isActive As Boolean

    Public Property isActive() As Boolean
        Get
            Return _isActive
        End Get
        Set(ByVal value As Boolean)
            _isActive = value
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

#Region " Insert ULC Branch "

    Public Function fnInsertULCBranch(ByVal Branch As clsOrgBranch) As clsResult
        Dim result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertULCBranch", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ULCBranchName", Branch.ULCBranchName)
            cmd.Parameters.AddWithValue("@BranchLocation", Branch.BranchLocation)
            cmd.Parameters.AddWithValue("@IsActive", Branch.isActive)
            cmd.Parameters.AddWithValue("@EntryBy", Branch.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            result.Success = True
            result.Message = "Branch Successfully Inserted."
            Return result
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            result.Success = False
            result.Message = "Error Found : " & ex.Message
            Return result
        End Try
    End Function

#End Region

#Region " Update ULC Branch "

    Public Function fnUpdateULCBranch(ByVal Branch As clsOrgBranch) As clsResult
        Dim result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateULCBranch", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ULCBranchID", Branch.ULCBranchID)
            cmd.Parameters.AddWithValue("@ULCBranchName", Branch.ULCBranchName)
            cmd.Parameters.AddWithValue("@BranchLocation", Branch.BranchLocation)
            cmd.Parameters.AddWithValue("@IsActive", Branch.isActive)
            cmd.ExecuteNonQuery()
            con.Close()
            result.Success = True
            result.Message = "Branch Successfully Updated."
            Return result
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            result.Success = False
            result.Message = "Error Found : " & ex.Message
            Return result
        End Try
    End Function

#End Region

#Region " Get Total ULC Branch "

    Public Function fnGetTotalULCBranch() As DataSet
        Dim sp As String = "spGetTotalULCBranch"
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
