Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsProfessionalCertification

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _CertificationName, _InstituteName, _Location As String
    Dim _DateFrom, _DateTo As DateTime
    Dim _NeverExpire As Integer

    Public Property CertificationName() As String
        Get
            Return _CertificationName
        End Get
        Set(ByVal value As String)
            _CertificationName = value
        End Set
    End Property

    Public Property InstituteName() As String
        Get
            Return _InstituteName
        End Get
        Set(ByVal value As String)
            _InstituteName = value
        End Set
    End Property

    Public Property Location() As String
        Get
            Return _Location
        End Get
        Set(ByVal value As String)
            _Location = value
        End Set
    End Property

    Public Property DateFrom() As DateTime
        Get
            Return _DateFrom
        End Get
        Set(ByVal value As DateTime)
            _DateFrom = value
        End Set
    End Property

    Public Property DateTo() As DateTime
        Get
            Return _DateTo
        End Get
        Set(ByVal value As DateTime)
            _DateTo = value
        End Set
    End Property

    Public Property NeverExpire() As Boolean
        Get
            Return _NeverExpire
        End Get
        Set(ByVal value As Boolean)
            _NeverExpire = value
        End Set
    End Property

    Public Function fnAddProfessionalCertification(ByVal EmployeeID As String, ByVal isoProfessionalCertificationParts As String) As String
        Dim ApplicationID As String
        Try
            Dim cmd As SqlCommand = New SqlCommand("spAddEmpProfCertification", con)
            cmd.CommandType = CommandType.StoredProcedure
            con.Open()
            cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
            cmd.Parameters.AddWithValue("@isoProfessionalCertificationParts", isoProfessionalCertificationParts)
            cmd.ExecuteNonQuery()
            con.Close()
            Return 1
        Catch ex As SqlException
            con.Close()
            ApplicationID = ""
            Return 0
        End Try
    End Function

    Public Function fnGetProCertificationInformation(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetEmployeeProCertiInformation"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.Add("@EmployeeID", SqlDbType.VarChar, 50).Value = EmployeeID
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

End Class
