Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsUserWiseRole

    Dim _UserWiseRoleID, _EmployeeID, _RoleID, _EntryBy As String

    Public Property UserWiseRoleID() As String
        Get
            Return _UserWiseRoleID
        End Get
        Set(ByVal value As String)
            _UserWiseRoleID = value
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

    Public Property RoleID() As String
        Get
            Return _RoleID
        End Get
        Set(ByVal value As String)
            _RoleID = value
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

    Dim _EntryDate As DateTime

    Public Property EntryDate() As DateTime
        Get
            Return _EntryDate
        End Get
        Set(ByVal value As DateTime)
            _EntryDate = value
        End Set
    End Property

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

#Region " Insert User Wise Role "

    Public Function fnInsertUserWiseRole(ByVal UserWiseRole As clsUserWiseRole) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertUserWiseRole", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", UserWiseRole.EmployeeID)
            cmd.Parameters.AddWithValue("@RoleID", UserWiseRole.RoleID)
            cmd.Parameters.AddWithValue("@EntryBy", UserWiseRole.EntryBy)
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

#Region " Deactivate User Permission "

    Public Function fnInActiveUsrPermission(ByVal UserWiseRole As clsUserWiseRole) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInActiveUsrPermission", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@UserWiseRoleID", UserWiseRole.UserWiseRoleID)
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

#Region " Show User Wise Role "

    Public Function fnShowUserWiseRole(ByVal UserWiseRole As clsUserWiseRole) As DataSet

        Dim sp As String = "spShowUserWiseRole"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", UserWiseRole.EmployeeID)
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

#Region " Get User Permission "

    Public Function fnGetUserPermission(ByVal UserWiseRole As clsUserWiseRole) As String

        Dim sp As String = "spGetUserPermission"
        Dim MenuIDs As String = ""
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", UserWiseRole.EmployeeID)
                Dim dr As SqlDataReader = cmd.ExecuteReader()
                While dr.Read()
                    MenuIDs = dr.Item("MenuIDs")
                End While
                con.Close()
                Return MenuIDs
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
