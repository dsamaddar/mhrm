Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsDocumentType

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)
    Dim _DocTypeID, _DocTypeFor, _DocumentType, _DocumentCategory, _PerformanceCriteria, _EntryBy As String

    Public Property DocTypeID() As String
        Get
            Return _DocTypeID
        End Get
        Set(ByVal value As String)
            _DocTypeID = value
        End Set
    End Property

    Public Property DocTypeFor() As String
        Get
            Return _DocTypeFor
        End Get
        Set(ByVal value As String)
            _DocTypeFor = value
        End Set
    End Property

    Public Property DocumentType() As String
        Get
            Return _DocumentType
        End Get
        Set(ByVal value As String)
            _DocumentType = value
        End Set
    End Property

    Public Property DocumentCategory() As String
        Get
            Return _DocumentCategory
        End Get
        Set(ByVal value As String)
            _DocumentCategory = value
        End Set
    End Property

    Public Property PerformanceCriteria() As String
        Get
            Return _PerformanceCriteria
        End Get
        Set(ByVal value As String)
            _PerformanceCriteria = value
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

    Dim _IsMandatory, _IsActive, _IsPerformanceFactor As Boolean

    Public Property IsMandatory() As Boolean
        Get
            Return _IsMandatory
        End Get
        Set(ByVal value As Boolean)
            _IsMandatory = value
        End Set
    End Property

    Public Property IsActive() As Boolean
        Get
            Return _IsActive
        End Get
        Set(ByVal value As Boolean)
            _IsActive = value
        End Set
    End Property

    Public Property IsPerformanceFactor() As Boolean
        Get
            Return _IsPerformanceFactor
        End Get
        Set(ByVal value As Boolean)
            _IsPerformanceFactor = value
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

#Region " Insert Update Document Type "
    Public Function fnInsertDocumentType(ByVal DocType As clsDocumentType) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertDocumentType", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@DocumentType", DocType.DocumentType)
            cmd.Parameters.AddWithValue("@DocTypeFor", DocType.DocTypeFor)
            cmd.Parameters.AddWithValue("@DocumentCategory", DocType.DocumentCategory)
            cmd.Parameters.AddWithValue("@IsMandatory", DocType.IsMandatory)
            cmd.Parameters.AddWithValue("@IsActive", DocType.IsActive)
            cmd.Parameters.AddWithValue("@IsPerformanceFactor", DocType.IsPerformanceFactor)
            cmd.Parameters.AddWithValue("@PerformanceCriteria", DocType.PerformanceCriteria)
            cmd.Parameters.AddWithValue("@EntryBy", DocType.EntryBy)
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

    Public Function fnUpdateDocumentType(ByVal DocType As clsDocumentType) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateDocumentType", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@DocTypeID", DocType.DocTypeID)
            cmd.Parameters.AddWithValue("@DocumentType", DocType.DocumentType)
            cmd.Parameters.AddWithValue("@DocTypeFor", DocType.DocTypeFor)
            cmd.Parameters.AddWithValue("@DocumentCategory", DocType.DocumentCategory)
            cmd.Parameters.AddWithValue("@IsMandatory", DocType.IsMandatory)
            cmd.Parameters.AddWithValue("@IsActive", DocType.IsActive)
            cmd.Parameters.AddWithValue("@IsPerformanceFactor", DocType.IsPerformanceFactor)
            cmd.Parameters.AddWithValue("@PerformanceCriteria", DocType.PerformanceCriteria)
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

#Region " Show Document Type "
    Public Function fnShowDocumentType(ByVal DocumentFor As String) As DataSet
        Dim sp As String = "spShowDocumentType"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@DocumentFor", DocumentFor)
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

    Public Function fnShowDocumentTypeForGrid() As DataSet
        Dim sp As String = "spShowDocumentTypeForGrid"
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

    Public Function fnShowDocumentTypeByID(ByVal DocTypeID As String) As clsDocumentType
        Dim DocumentType As New clsDocumentType()
        Dim sp As String = "spShowDocumentTypeByID"
        Dim dr As SqlDataReader
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@DocTypeID", DocTypeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    DocumentType.DocumentType = dr.Item("DocumentType")
                    DocumentType.DocTypeFor = dr.Item("DocumentFor")
                    DocumentType.DocumentCategory = dr.Item("DocumentCategory")
                    DocumentType.IsMandatory = dr.Item("IsMandatory")
                    DocumentType.IsActive = dr.Item("IsActive")
                    DocumentType.IsPerformanceFactor = dr.Item("IsPerformanceFactor")
                End While
                con.Close()

                Return DocumentType
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
