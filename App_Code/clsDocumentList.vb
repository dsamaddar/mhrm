Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data


Public Class clsDocumentList

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _DocListID, _DocTypeID, _UniqueUserID, _DocumentName, _FileName, _Remarks, _UploadedBy As String

    Public Property DocListID() As String
        Get
            Return _DocListID
        End Get
        Set(ByVal value As String)
            _DocListID = value
        End Set
    End Property

    Public Property DocTypeID() As String
        Get
            Return _DocTypeID
        End Get
        Set(ByVal value As String)
            _DocTypeID = value
        End Set
    End Property

    Public Property UniqueUserID() As String
        Get
            Return _UniqueUserID
        End Get
        Set(ByVal value As String)
            _UniqueUserID = value
        End Set
    End Property

    Public Property DocumentName() As String
        Get
            Return _DocumentName
        End Get
        Set(ByVal value As String)
            _DocumentName = value
        End Set
    End Property

    Public Property FileName() As String
        Get
            Return _FileName
        End Get
        Set(ByVal value As String)
            _FileName = value
        End Set
    End Property

    Public Property Remarks() As String
        Get
            Return _Remarks
        End Get
        Set(ByVal value As String)
            _Remarks = value
        End Set
    End Property

    Public Property UploadedBy() As String
        Get
            Return _UploadedBy
        End Get
        Set(ByVal value As String)
            _UploadedBy = value
        End Set
    End Property

    Dim _EntryDate, _IssueDate, _EffectiveDate As DateTime

    Public Property EntryDate() As DateTime
        Get
            Return _EntryDate
        End Get
        Set(ByVal value As DateTime)
            _EntryDate = value
        End Set
    End Property

    Public Property IssueDate() As DateTime
        Get
            Return _IssueDate
        End Get
        Set(ByVal value As DateTime)
            _IssueDate = value
        End Set
    End Property

    Public Property EffectiveDate() As DateTime
        Get
            Return _EffectiveDate
        End Get
        Set(ByVal value As DateTime)
            _EffectiveDate = value
        End Set
    End Property

#Region " Insert Documents "
    Public Function InsertDocuments(ByVal Document As clsDocumentList) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertDocumentList", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@DocTypeID", Document.DocTypeID)
            cmd.Parameters.AddWithValue("@UniqueUserID", Document.UniqueUserID)
            cmd.Parameters.AddWithValue("@DocumentName", Document.DocumentName)
            cmd.Parameters.AddWithValue("@FileName", Document.FileName)
            cmd.Parameters.AddWithValue("@IssueDate", Document.IssueDate)
            cmd.Parameters.AddWithValue("@EffectiveDate", Document.EffectiveDate)
            cmd.Parameters.AddWithValue("@Remarks", Document.Remarks)
            cmd.Parameters.AddWithValue("@UploadedBy", Document.UploadedBy)
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

#Region " Get Remaining Document List "
    Public Function fnGetRemainingMandatoryDocuments(ByVal DocTypeIDStr As String) As DataSet

        Dim sp As String = "spGetMandatoryDocumentType"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@DocTypeIDStr", DocTypeIDStr)
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

#Region " Get User Documents "
    Public Function fnGetUserDocuments(ByVal UniqueUserID As String) As DataSet
        Dim sp As String = "spGetUserDocuments"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@UniqueUserID", UniqueUserID)
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

#Region " Get Emp Documents "
    Public Function fnGetEmpDocuments(ByVal UniqueUserID As String, ByVal DocumentCategory As String) As DataSet
        Dim sp As String = "spGetEmpDocuments"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@UniqueUserID", UniqueUserID)
                cmd.Parameters.AddWithValue("@DocumentCategory", DocumentCategory)
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

#Region " DeleteUserDocuments "
    Public Function fnDeleteUserDocuments(ByVal DocumentID As String) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spDeleteUserDocuments", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@DocumentID", DocumentID)
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

#Region " Get Emp Documents Performance Issue "
    Public Function fnGetEmpDocumentsPerformanceIssue(ByVal UniqueUserID As String, ByVal DocumentCategory As String) As DataSet
        Dim sp As String = "spGetEmpDocumentsPerformanceIssue"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@UniqueUserID", UniqueUserID)
                cmd.Parameters.AddWithValue("@DocumentCategory", DocumentCategory)
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
