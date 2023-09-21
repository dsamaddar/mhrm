Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Public Class clsMenu

    Dim _MenuID, _MenuName, _MenuGroupID As String
    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Public Property MenuID() As String
        Get
            Return _MenuID
        End Get
        Set(ByVal value As String)
            _MenuID = value
        End Set
    End Property

    Public Property MenuName() As String
        Get
            Return _MenuName
        End Get
        Set(ByVal value As String)
            _MenuName = value
        End Set
    End Property

    Public Property MenuGroupID() As String
        Get
            Return _MenuGroupID
        End Get
        Set(ByVal value As String)
            _MenuGroupID = value
        End Set
    End Property

    Dim _ViewOrder As Integer

    Public Property ViewOrder() As Integer
        Get
            Return _ViewOrder
        End Get
        Set(ByVal value As Integer)
            _ViewOrder = value
        End Set
    End Property

#Region " Get Menu List By Group "

    Public Function fnGetMenuListByGroup(ByVal MenuGroupID As String) As DataSet

        Dim sp As String = "spGetMenuListByGroup"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@MenuGroupID", MenuGroupID)
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

#Region " GetMenuGroupList "

    Public Function fnGetMenuGroupList() As DataSet

        Dim sp As String = "spGetMenuGroupList"
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
