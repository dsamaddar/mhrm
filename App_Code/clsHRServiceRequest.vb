Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class clsHRServiceRequest

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _EmployeeName, _EmployeeID, _HRServiceIssueID, _HRService, _HRServiceID, _Remarks, _ServiceProvider, _ServiceProviderRemarks, _RejectionRemarks, _RejectedBy, _ServiceStatus, _EntryBy, _ServiceEvent, _IsServiceProvidedEX, _IsRejectedEX As String

    Public Property EmployeeName() As String
        Get
            Return _EmployeeName
        End Get
        Set(ByVal value As String)
            _EmployeeName = value
        End Set
    End Property

    Public Property EmployeeID() As String
        Get
            Return _EmployeeID
        End Get
        Set(ByVal value As String)
            _EmployeeID = value
        End Set
    End Property

    Public Property HRServiceIssueID() As String
        Get
            Return _HRServiceIssueID
        End Get
        Set(ByVal value As String)
            _HRServiceIssueID = value
        End Set
    End Property

    Public Property HRService() As String
        Get
            Return _HRService
        End Get
        Set(ByVal value As String)
            _HRService = value
        End Set
    End Property

    Public Property HRServiceID() As String
        Get
            Return _HRServiceID
        End Get
        Set(ByVal value As String)
            _HRServiceID = value
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

    Public Property ServiceProvider() As String
        Get
            Return _ServiceProvider
        End Get
        Set(ByVal value As String)
            _ServiceProvider = value
        End Set
    End Property

    Public Property ServiceProviderRemarks() As String
        Get
            Return _ServiceProviderRemarks
        End Get
        Set(ByVal value As String)
            _ServiceProviderRemarks = value
        End Set
    End Property

    Public Property RejectionRemarks() As String
        Get
            Return _RejectionRemarks
        End Get
        Set(ByVal value As String)
            _RejectionRemarks = value
        End Set
    End Property

    Public Property RejectedBy() As String
        Get
            Return _RejectedBy
        End Get
        Set(ByVal value As String)
            _RejectedBy = value
        End Set
    End Property

    Public Property ServiceStatus() As String
        Get
            Return _ServiceStatus
        End Get
        Set(ByVal value As String)
            _ServiceStatus = value
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

    Public Property ServiceEvent() As String
        Get
            Return _ServiceEvent
        End Get
        Set(ByVal value As String)
            _ServiceEvent = value
        End Set
    End Property

    Public Property IsServiceProvidedEX() As String
        Get
            Return _IsServiceProvidedEX
        End Get
        Set(ByVal value As String)
            _IsServiceProvidedEX = value
        End Set
    End Property

    Public Property IsRejectedEX() As String
        Get
            Return _IsRejectedEX
        End Get
        Set(ByVal value As String)
            _IsRejectedEX = value
        End Set
    End Property

    Dim _EffectiveDate, _ServingDate, _RejectionDate, _EntryDate As DateTime

    Public Property EffectiveDate() As DateTime
        Get
            Return _EffectiveDate
        End Get
        Set(ByVal value As DateTime)
            _EffectiveDate = value
        End Set
    End Property

    Public Property ServingDate() As DateTime
        Get
            Return _ServingDate
        End Get
        Set(ByVal value As DateTime)
            _ServingDate = value
        End Set
    End Property

    Public Property RejectionDate() As DateTime
        Get
            Return _RejectionDate
        End Get
        Set(ByVal value As DateTime)
            _RejectionDate = value
        End Set
    End Property

    Public Property EntryDate() As DateTime
        Get
            Return _EntryDate
        End Get
        Set(ByVal value As DateTime)
            _EntryDate = value
        End Set
    End Property

    Dim _IsServiceProvided, _IsRejected As Boolean

    Public Property IsServiceProvided() As Boolean
        Get
            Return _IsServiceProvided
        End Get
        Set(ByVal value As Boolean)
            _IsServiceProvided = value
        End Set
    End Property

    Public Property IsRejected() As Boolean
        Get
            Return _IsRejected
        End Get
        Set(ByVal value As Boolean)
            _IsRejected = value
        End Set
    End Property

    Public Function fnInsertHRServiceIssue(ByVal HRServiceRequest As clsHRServiceRequest) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertHRServiceIssue", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@HRServiceID", HRServiceRequest.HRServiceID)
            cmd.Parameters.AddWithValue("@EmployeeID", HRServiceRequest.EmployeeID)
            cmd.Parameters.AddWithValue("@EffectiveDate", HRServiceRequest.EffectiveDate)
            cmd.Parameters.AddWithValue("@Remarks", HRServiceRequest.Remarks)
            cmd.Parameters.AddWithValue("@EntryBy", HRServiceRequest.EntryBy)
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

    Public Function fnProvideHRService(ByVal HRServiceRequest As clsHRServiceRequest) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spProvideHRService", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@HRServiceIssueID", HRServiceRequest.HRServiceIssueID)
            cmd.Parameters.AddWithValue("@ServiceProviderRemarks", HRServiceRequest.ServiceProviderRemarks)
            cmd.Parameters.AddWithValue("@ServiceProvider", HRServiceRequest.ServiceProvider)
            cmd.Parameters.AddWithValue("@ServiceEvent", HRServiceRequest.ServiceEvent)
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

    Public Function fnGetHRServiceMailInfoSubmitted(ByVal HRServiceRequest As clsHRServiceRequest) As clsMailProperty
        Dim sp As String = "spGetHRServiceMailInfoSubmitted"
        Dim dr As SqlDataReader
        Dim MailProp As New clsMailProperty()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", HRServiceRequest.EmployeeID)
                cmd.Parameters.AddWithValue("@HRServiceID", HRServiceRequest.HRServiceID)
                cmd.Parameters.AddWithValue("@EffectiveDate", HRServiceRequest.EffectiveDate)
                cmd.Parameters.AddWithValue("@Remarks", HRServiceRequest.Remarks)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    MailProp.MailSubject = dr.Item("MailSubject")
                    MailProp.MailBody = dr.Item("MailBody")
                    MailProp.MailFrom = dr.Item("MailFrom")
                    MailProp.MailTo = dr.Item("MailTo")
                    MailProp.MailCC = dr.Item("MailCC")
                    MailProp.MailBCC = dr.Item("MailBCC")
                End While
                con.Close()

                Return MailProp
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetHRServiceProvidedMail(ByVal HRServiceRequest As clsHRServiceRequest) As clsMailProperty
        Dim sp As String = "spGetHRServiceProvidedMail"
        Dim dr As SqlDataReader
        Dim MailProp As New clsMailProperty()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@HRServiceIssueID", HRServiceRequest.HRServiceIssueID)
                cmd.Parameters.AddWithValue("@ServiceEvent", HRServiceRequest.ServiceEvent)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    MailProp.MailSubject = dr.Item("MailSubject")
                    MailProp.MailBody = dr.Item("MailBody")
                    MailProp.MailFrom = dr.Item("MailFrom")
                    MailProp.MailTo = dr.Item("MailTo")
                    MailProp.MailCC = dr.Item("MailCC")
                    MailProp.MailBCC = dr.Item("MailBCC")
                End While
                con.Close()
                Return MailProp
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetHRServiceIssueByEmp(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetHRServiceIssueByEmp"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
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

    Public Function fnGetHRServiceRequest() As DataSet

        Dim sp As String = "spGetHRServiceRequest"
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

    Public Function fnReportHRServicesIssue(ByVal HRServices As clsHRServiceRequest) As DataSet

        Dim sp As String = "spReportHRServicesIssue"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@HRServiceID", HRServices.HRServiceID)
                cmd.Parameters.AddWithValue("@EmployeeID", HRServices.EmployeeID)
                cmd.Parameters.AddWithValue("@ServiceStatus", HRServices.ServiceStatus)
                cmd.Parameters.AddWithValue("@IsServiceProvided", HRServices.IsServiceProvidedEX)
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
