Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsDashBoard

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)
    Dim _LicenseExpiryDate, _MaximumUser As String

    Public Property LicenseExpiryDate() As String
        Get
            Return _LicenseExpiryDate
        End Get
        Set(ByVal value As String)
            _LicenseExpiryDate = value
        End Set
    End Property

    Public Property MaximumUser() As String
        Get
            Return _MaximumUser
        End Get
        Set(ByVal value As String)
            _MaximumUser = value
        End Set
    End Property

    Dim _ActiveUser, _InActiveUser, _AvailableUser, _TotalUser As Integer

    Public Property ActiveUser() As Integer
        Get
            Return _ActiveUser
        End Get
        Set(ByVal value As Integer)
            _ActiveUser = value
        End Set
    End Property

    Public Property InActiveUser() As Integer
        Get
            Return _InActiveUser
        End Get
        Set(ByVal value As Integer)
            _InActiveUser = value
        End Set
    End Property

    Public Property AvailableUser() As Integer
        Get
            Return _AvailableUser
        End Get
        Set(ByVal value As Integer)
            _AvailableUser = value
        End Set
    End Property

    Public Property TotalUser() As Integer
        Get
            Return _TotalUser
        End Get
        Set(ByVal value As Integer)
            _TotalUser = value
        End Set
    End Property

#Region " Get Dash Board Info "

    Public Function fnGetDashBoardInfo() As clsDashBoard
        Dim sp As String = "spGetDashBoardInfo"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim dr As SqlDataReader
        Dim DashBoard As New clsDashBoard()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                dr = cmd.ExecuteReader()
                While dr.Read()
                    DashBoard.LicenseExpiryDate = dr.Item("LicenseExpiryDate")
                    DashBoard.MaximumUser = dr.Item("MaximumUser")
                    DashBoard.ActiveUser = dr.Item("ActiveUser")
                    DashBoard.InActiveUser = dr.Item("InActiveUser")
                    DashBoard.AvailableUser = dr.Item("AvailableUser")
                    DashBoard.TotalUser = dr.Item("TotalUser")
                End While
                con.Close()
                Return DashBoard
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
