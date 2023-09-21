Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsTrainingType

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)
    Dim _TrngTypeID, _TrngType, _EntryBy As String

    Public Property TrngTypeID() As String
        Get
            Return _TrngTypeID
        End Get
        Set(ByVal value As String)
            _TrngTypeID = value
        End Set
    End Property

    Public Property TrngType() As String
        Get
            Return _TrngType
        End Get
        Set(ByVal value As String)
            _TrngType = value
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

#Region " Insert Trng Type "

    Public Function fnspInsertTrngType(ByVal TrngType As clsTrainingType) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertTrngType", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@TrngType", TrngType.TrngType)
            cmd.Parameters.AddWithValue("@EntryBy", TrngType.EntryBy)
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

#Region " Show Trng Type "

    Public Function fnShowTrngType() As DataSet
        Dim sp As String = "spShowTrngType"
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

#Region "Organization Name by Country"

    Public Function fnShowOrganizationList(ByVal CountryName As String) As DataSet
        Dim sp As String = "spShowOrganizationByCountry"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@CountryName", CountryName)
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

#Region " Insert Training Topic "

    Public Function fnspInsertTrngTopic(ByVal TrainingTopic As clsTrainingTopic) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertTrainingTopic", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@TrngSubjectID", TrainingTopic.TrngSubjectID)
            cmd.Parameters.AddWithValue("@TrngTopic", TrainingTopic.TrngTopic)
            cmd.Parameters.AddWithValue("@EntryBy", TrainingTopic.EntryBy)
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

#Region " Show Training Topic "

    Public Function fnShowTrngTopic(ByVal TrngSubjectID As String) As DataSet
        Dim sp As String = "spShowTrngTopic"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@TrngSubjectID", TrngSubjectID)
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

#Region " Show Training Topic By SubjectID "

    Public Function fnShowTrngTopicBySubjectID(ByVal TrngSubjectID As String) As DataSet
        Dim sp As String = "spShowTrngTopicBySubjectID"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@TrngSubjectID", TrngSubjectID)
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
