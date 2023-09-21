Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsTrainingSubject

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)
    Dim _TrngSubjectID, _TrngSubName, _TrngSubDescription, _Objectives, _EntryBy As String

    Public Property TrngSubjectID() As String
        Get
            Return _TrngSubjectID
        End Get
        Set(ByVal value As String)
            _TrngSubjectID = value
        End Set
    End Property

    Public Property TrngSubName() As String
        Get
            Return _TrngSubName
        End Get
        Set(ByVal value As String)
            _TrngSubName = value
        End Set
    End Property

    Public Property TrngSubDescription() As String
        Get
            Return _TrngSubDescription
        End Get
        Set(ByVal value As String)
            _TrngSubDescription = value
        End Set
    End Property

    Public Property Objectives() As String
        Get
            Return _Objectives
        End Get
        Set(ByVal value As String)
            _Objectives = value
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

    Public Property EntryDate() As String
        Get
            Return _EntryDate
        End Get
        Set(ByVal value As String)
            _EntryDate = value
        End Set
    End Property

#Region " Insert Trng Subject "
    Public Function fnInsertTrngSubject(ByVal TrngSub As clsTrainingSubject) As clsResult
        Dim result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertTrngSubject", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@TrngSubName", TrngSub.TrngSubName)
            cmd.Parameters.AddWithValue("@TrngSubDescription", TrngSub.TrngSubDescription)
            cmd.Parameters.AddWithValue("@Objectives", TrngSub.Objectives)
            cmd.Parameters.AddWithValue("@EntryBy", TrngSub.EntryBy)
            cmd.ExecuteNonQuery()
            con.Close()
            result.Success = True
            result.Message = "Training Information Submitted."
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

#Region " Show Trng Subjects "

    Public Function fnShowTrngSubjects() As DataSet

        Dim sp As String = "spShowTrngSubjects"
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
