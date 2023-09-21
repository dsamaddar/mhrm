Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data


Public Class clsDepartment

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _DepartmentID, _DeptName, _DeptCode, _EntryBy As String

    Public Property DepartmentID() As String
        Get
            Return _DepartmentID
        End Get
        Set(ByVal value As String)
            _DepartmentID = value
        End Set
    End Property

    Public Property DeptName() As String
        Get
            Return _DeptName
        End Get
        Set(ByVal value As String)
            _DeptName = value
        End Set
    End Property


    Public Property DeptCode() As String
        Get
            Return _DeptCode
        End Get
        Set(ByVal value As String)
            _DeptCode = value
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

#Region " Insert Department "
    Public Function fnInsertDepartment(ByVal DepartmentInfo As clsDepartment) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertDepartment", con)
            con.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@DeptName", DepartmentInfo.DeptName)
            cmd.Parameters.AddWithValue("@DeptCode", DepartmentInfo.DeptCode)
            cmd.Parameters.AddWithValue("@IsActive", DepartmentInfo.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", DepartmentInfo.EntryBy)

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

#Region " Update Dept Info By ID "
    Public Function fnUpdateDeptInfoByID(ByVal DepartmentInfo As clsDepartment) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateDeptInfoByID", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@DepartmentID", DepartmentInfo.DepartmentID)
            cmd.Parameters.AddWithValue("@DeptName", DepartmentInfo.DeptName)
            cmd.Parameters.AddWithValue("@DeptCode", DepartmentInfo.DeptCode)
            cmd.Parameters.AddWithValue("@IsActive", DepartmentInfo.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", DepartmentInfo.EntryBy)
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

#Region " Get Dept List "

    Public Function fnGetDeptList() As DataSet

        Dim sp As String = "spGetDeptList"
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

#Region " Get Department Details "

    Public Function fnGetDepartmentDetails() As DataSet

        Dim sp As String = "spGetDepartmentDetails"
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
