Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsCourseLevelDataAccess

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

#Region " Insert Course Level "
    Public Function fnInsertCourseLevel(ByVal CourseLevel As clsCourseLevel) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertCourseLevel", con)
            con.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@CourseLevel", CourseLevel.CourseLevel)
            cmd.Parameters.AddWithValue("@EntryBy", CourseLevel.EntryBy)

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

#Region " Show Course Level "

    Public Function fnShowCourseLevel() As DataSet

        Dim sp As String = "spShowCourseLevel"
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
