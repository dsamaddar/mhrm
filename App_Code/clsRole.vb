Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsRole

    Dim _RoleID, _RoleName, _MenuIDs, _ActivityIDs, _CreatedBy, _LastUpdatedBy, _MenuIDList As String
    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Public Property RoleID() As String
        Get
            Return _RoleID
        End Get
        Set(ByVal value As String)
            _RoleID = value
        End Set
    End Property

    Public Property RoleName() As String
        Get
            Return _RoleName
        End Get
        Set(ByVal value As String)
            _RoleName = value
        End Set
    End Property

    Public Property MenuIDs() As String
        Get
            Return _MenuIDs
        End Get
        Set(ByVal value As String)
            _MenuIDs = value
        End Set
    End Property

    Public Property ActivityIDs() As String
        Get
            Return _ActivityIDs
        End Get
        Set(ByVal value As String)
            _ActivityIDs = value
        End Set
    End Property

    Public Property CreatedBy() As String
        Get
            Return _CreatedBy
        End Get
        Set(ByVal value As String)
            _CreatedBy = value
        End Set
    End Property

    Public Property LastUpdatedBy() As String
        Get
            Return _LastUpdatedBy
        End Get
        Set(ByVal value As String)
            _LastUpdatedBy = value
        End Set
    End Property

    Public Property MenuIDList() As String
        Get
            Return _MenuIDList
        End Get
        Set(ByVal value As String)
            _MenuIDList = value
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

    Dim _CreatedDate, _LastUpdatedDate As DateTime

    Public Property CreatedDate() As DateTime
        Get
            Return _CreatedDate
        End Get
        Set(ByVal value As DateTime)
            _CreatedDate = value
        End Set
    End Property

    Public Property LastUpdatedDate() As DateTime
        Get
            Return _LastUpdatedDate
        End Get
        Set(ByVal value As DateTime)
            _LastUpdatedDate = value
        End Set
    End Property


#Region " Insert Role "

    Public Function fnInsertRole(ByVal Role As clsRole) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertRole", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@RoleName", Role.RoleName)
            cmd.Parameters.AddWithValue("@isActive", Role.isActive)
            cmd.Parameters.AddWithValue("@CreatedBy", Role.CreatedBy)
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

#Region " Update Role "

    Public Function fnUpdateRole(ByVal Role As clsRole) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateRole", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@RoleID", Role.RoleID)
            cmd.Parameters.AddWithValue("@RoleName", Role.RoleName)
            cmd.Parameters.AddWithValue("@isActive", Role.isActive)
            cmd.Parameters.AddWithValue("@LastUpdatedBy", Role.LastUpdatedBy)
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

#Region " Get Details Role List "

    Public Function fnGetDetailsRoleList() As DataSet
        Dim sp As String = "spGetDetailsRoleList"
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

#Region " Get Role List "

    Public Function fnGetRoleList() As DataSet
        Dim sp As String = "spGetRoleList"
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

#Region " Get Role Wise Menu IDs "

    Public Function fnGetRoleWiseMenuIDs(ByVal RoleID As String) As String
        Dim sp As String = "spGetRoleWiseMenuIDs"
        Dim MenuIDs As String = ""
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@RoleID", RoleID)
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
            Return ""
        End Try
    End Function

#End Region

#Region " Update Role "

    Public Function fnUpdateRolePermission(ByVal Role As clsRole) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateRolePermission", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@RoleID", Role.RoleID)
            cmd.Parameters.AddWithValue("@MenuIDList", Role.MenuIDList)
            cmd.Parameters.AddWithValue("@LastUpdatedBy", Role.LastUpdatedBy)
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

End Class
