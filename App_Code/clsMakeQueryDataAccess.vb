Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsMakeQueryDataAccess

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

#Region " Get Foreign Key Reference "
    Public Function fnGetForeignKeyReference(ByVal PRIMARYKEYTABLE As String, ByVal FOREIGNKEYTABLE As String) As String
        Try
            Dim ForeignKey As String = ""
            Dim cmd As SqlCommand = New SqlCommand("spGetForeignKeyReference", con)

            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@PRIMARYKEYTABLE", PRIMARYKEYTABLE)
            cmd.Parameters.AddWithValue("@FOREIGNKEYTABLE", FOREIGNKEYTABLE)
            Dim dr As SqlDataReader = cmd.ExecuteReader()

            While dr.Read()
                ForeignKey = dr.Item("ForeignKey")
            End While
            con.Close()
            Return ForeignKey
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return 0
        End Try
    End Function
#End Region

End Class
