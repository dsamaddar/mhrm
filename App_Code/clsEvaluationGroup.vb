Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data


Public Class clsEvaluationGroup


    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _EvaluationGroupID, _EvaluationGroup, _EntryBy As String

    Public Property EvaluationGroupID() As String
        Get
            Return _EvaluationGroupID
        End Get
        Set(ByVal value As String)
            _EvaluationGroupID = value
        End Set
    End Property

    Public Property EvaluationGroup() As String
        Get
            Return _EvaluationGroup
        End Get
        Set(ByVal value As String)
            _EvaluationGroup = value
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

#Region " Insert Evaluation Group "

    Public Function fnInsertEvaluationGroup(ByVal EvalGroup As clsEvaluationGroup) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertEvaluationGroup", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EvaluationGroup", EvalGroup.EvaluationGroup)
            cmd.Parameters.AddWithValue("@IsActive", EvalGroup.IsActive)
            cmd.Parameters.AddWithValue("@EntryBy", EvalGroup.EntryBy)
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

#Region " Get Active Eval Group "

    Public Function fnGetActiveEvalGroup() As DataSet
        Dim sp As String = "spGetActiveEvalGroup"
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
