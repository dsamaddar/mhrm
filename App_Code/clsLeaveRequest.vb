Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports System.Net.Mail
Imports System.Web.Mail


Public Class clsLeaveRequest

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)
    Dim _EmployeeID, _LeaveRequestID, _AppLeaveRejectionID, _ActionType, _ActorRemarks, _ActedBy, _Remarks, _LeaveTypeID, _PurposeOfLeave, _EmergencyAddress, _EmergencyContactNo, _EmergencyMailAddress, _
    _Attachment, _RecommenderID, _ApproverID, _EventName, _EntryBy As String

    Public Property EmployeeID() As String
        Get
            Return _EmployeeID
        End Get
        Set(ByVal value As String)
            _EmployeeID = value
        End Set
    End Property

    Public Property LeaveRequestID() As String
        Get
            Return _LeaveRequestID
        End Get
        Set(ByVal value As String)
            _LeaveRequestID = value
        End Set
    End Property

    Public Property AppLeaveRejectionID() As String
        Get
            Return _AppLeaveRejectionID
        End Get
        Set(ByVal value As String)
            _AppLeaveRejectionID = value
        End Set
    End Property

    Public Property ActionType() As String
        Get
            Return _ActionType
        End Get
        Set(ByVal value As String)
            _ActionType = value
        End Set
    End Property

    Public Property ActorRemarks() As String
        Get
            Return _ActorRemarks
        End Get
        Set(ByVal value As String)
            _ActorRemarks = value
        End Set
    End Property

    Public Property ActedBy() As String
        Get
            Return _ActedBy
        End Get
        Set(ByVal value As String)
            _ActedBy = value
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

    Public Property EntryBy() As String
        Get
            Return _EntryBy
        End Get
        Set(ByVal value As String)
            _EntryBy = value
        End Set
    End Property

    Public Property LeaveTypeID() As String
        Get
            Return _LeaveTypeID
        End Get
        Set(ByVal value As String)
            _LeaveTypeID = value
        End Set
    End Property

    Public Property PurposeOfLeave() As String
        Get
            Return _PurposeOfLeave
        End Get
        Set(ByVal value As String)
            _PurposeOfLeave = value
        End Set
    End Property

    Public Property EmergencyAddress() As String
        Get
            Return _EmergencyAddress
        End Get
        Set(ByVal value As String)
            _EmergencyAddress = value
        End Set
    End Property

    Public Property EmergencyContactNo() As String
        Get
            Return _EmergencyContactNo
        End Get
        Set(ByVal value As String)
            _EmergencyContactNo = value
        End Set
    End Property

    Public Property EmergencyMailAddress() As String
        Get
            Return _EmergencyMailAddress
        End Get
        Set(ByVal value As String)
            _EmergencyMailAddress = value
        End Set
    End Property

    Public Property Attachment() As String
        Get
            Return _Attachment
        End Get
        Set(ByVal value As String)
            _Attachment = value
        End Set
    End Property

    Public Property RecommenderID() As String
        Get
            Return _RecommenderID
        End Get
        Set(ByVal value As String)
            _RecommenderID = value
        End Set
    End Property

    Public Property ApproverID() As String
        Get
            Return _ApproverID
        End Get
        Set(ByVal value As String)
            _ApproverID = value
        End Set
    End Property

    Public Property EventName() As String
        Get
            Return _EventName
        End Get
        Set(ByVal value As String)
            _EventName = value
        End Set
    End Property

    Dim _TotalDays, _TotalWorkingDays, _InBetweenHolidays As Integer

    Public Property TotalDays() As Integer
        Get
            Return _TotalDays
        End Get
        Set(ByVal value As Integer)
            _TotalDays = value
        End Set
    End Property

    Public Property TotalWorkingDays() As Integer
        Get
            Return _TotalWorkingDays
        End Get
        Set(ByVal value As Integer)
            _TotalWorkingDays = value
        End Set
    End Property

    Public Property InBetweenHolidays() As Integer
        Get
            Return _InBetweenHolidays
        End Get
        Set(ByVal value As Integer)
            _InBetweenHolidays = value
        End Set
    End Property

    Dim _LeaveFrom, _LeaveTo, _RequestedOn As DateTime

    Public Property LeaveFrom() As DateTime
        Get
            Return _LeaveFrom
        End Get
        Set(ByVal value As DateTime)
            _LeaveFrom = value
        End Set
    End Property

    Public Property LeaveTo() As DateTime
        Get
            Return _LeaveTo
        End Get
        Set(ByVal value As DateTime)
            _LeaveTo = value
        End Set
    End Property

    Public Property RequestedOn() As DateTime
        Get
            Return _RequestedOn
        End Get
        Set(ByVal value As DateTime)
            _RequestedOn = value
        End Set
    End Property

    Public Function fnInsertLeaveRequest(ByVal LeaveRequest As clsLeaveRequest, ByVal isoFromDateToDateParts As String) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertLeaveRequest", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", LeaveRequest.EmployeeID)
            cmd.Parameters.AddWithValue("@LeaveTypeID", LeaveRequest.LeaveTypeID)
            cmd.Parameters.AddWithValue("@EmergencyAddress", LeaveRequest.EmergencyAddress)
            cmd.Parameters.AddWithValue("@EmergencyContactNo", LeaveRequest.EmergencyContactNo)
            cmd.Parameters.AddWithValue("@EmergencyMailAddress", LeaveRequest.EmergencyMailAddress)
            cmd.Parameters.AddWithValue("@Attachment", LeaveRequest.Attachment)
            cmd.Parameters.AddWithValue("@RecommenderID", LeaveRequest.RecommenderID)
            cmd.Parameters.AddWithValue("@ApproverID", LeaveRequest.ApproverID)
            cmd.Parameters.AddWithValue("@EntryBy", LeaveRequest.EntryBy)
            cmd.Parameters.AddWithValue("@isoFromDateToDateParts", isoFromDateToDateParts)
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

    Public Function fnGetLeaveType() As DataSet

        Dim sp As String = "spShowLeaveType"
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

    Public Function fnGetCalcucationWorkingDay(ByVal DateFrom As DateTime, ByVal DateTo As DateTime, ByRef TotalHoliday As Integer, ByRef LeaveDays As Integer, ByRef TotalApplied As Integer) As Integer
        Dim sp As String = "prCalculateDays"
        Dim dr As SqlDataReader
        Dim ReturnValue As Integer
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@FromDateInput", DateFrom)
                cmd.Parameters.AddWithValue("@ToDateInput", DateTo)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    TotalHoliday = dr.Item("Holidays")
                    LeaveDays = dr.Item("LeaveDays")
                    TotalApplied = dr.Item("Applied")
                End While

                ReturnValue = 1
                con.Close()

                Return ReturnValue
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
                ReturnValue = 0
            End If
            Return ReturnValue
        End Try
        Return ReturnValue
    End Function

    Public Function fnGetLeaveMailInfo(ByVal LeaveRequestID As String, ByVal EventName As String, ByVal UniqueUserID As String, ByVal SupervisorComments As String) As clsMailProperty
        Dim sp As String = "spGetLeaveMailInfo"
        Dim dr As SqlDataReader
        Dim MailProp As New clsMailProperty()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@LeaveRequestID", LeaveRequestID)
                cmd.Parameters.AddWithValue("@Event", EventName)
                cmd.Parameters.AddWithValue("@UniqueUserID", UniqueUserID)
                cmd.Parameters.AddWithValue("@SupervisorComments", SupervisorComments)
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

    Public Function fnGetLeaveMailInfoSubmitted(ByVal LeaveReq As clsLeaveRequest) As clsMailProperty
        Dim sp As String = "spGetLeaveMailInfoSubmitted"
        Dim dr As SqlDataReader
        Dim MailProp As New clsMailProperty()
        Try
            con.Open()

            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", LeaveReq.EmployeeID)
                cmd.Parameters.AddWithValue("@LeaveFrom", LeaveReq.LeaveFrom)
                cmd.Parameters.AddWithValue("@LeaveTo", LeaveReq.LeaveTo)
                cmd.Parameters.AddWithValue("@TotalWorkingDays", LeaveReq.TotalWorkingDays)
                cmd.Parameters.AddWithValue("@PurposeOfLeave", LeaveReq.PurposeOfLeave)
                cmd.Parameters.AddWithValue("@Event", LeaveReq.EventName)
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

    Public Function fnGetLeaveTypeGenderWise(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spShowLeaveTypeGenderWise"
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

    Public Function fnGetApproverRecommender(ByVal EmployeeID As String, ByRef Approver As String, ByRef ApproverID As String, ByRef Recommender As String, ByRef RecommenderID As String) As Integer
        Dim sp As String = "spGetApproverRecommender"
        Dim dr As SqlDataReader
        Dim ReturnValue As Integer
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    Approver = dr.Item("Approver")
                    ApproverID = dr.Item("ApproverID")
                    Recommender = dr.Item("Recommender")
                    RecommenderID = dr.Item("RecommenderID")
                End While

                ReturnValue = 1
                con.Close()

                Return ReturnValue
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
                ReturnValue = 0
            End If
            Return ReturnValue
        End Try
        Return ReturnValue
    End Function

    Public Function fnGetLeaveBalance(ByVal EmployeeID As String, ByRef TotalLeave As Integer, ByRef LeaveTaken As Integer) As Integer
        Dim sp As String = "spGetLeaveBalance"
        Dim dr As SqlDataReader
        Dim ReturnValue As Integer
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    TotalLeave = dr.Item("TotalLeave")
                    LeaveTaken = dr.Item("LeaveTaken")
                End While

                ReturnValue = 1
                con.Close()

                Return ReturnValue
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
                ReturnValue = 0
            End If
            Return ReturnValue
        End Try
        Return ReturnValue
    End Function

    Public Function CheckAvailableDate(ByVal EmployeeID As String, ByVal dtLeaveFrom As DateTime, ByVal dtLeaveTo As DateTime) As String
        Dim sp As String = "spBetweenDateGet"
        Dim dr As SqlDataReader
        Dim ReturnValue As String = ""
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                cmd.Parameters.AddWithValue("@DateFrom", dtLeaveFrom)
                cmd.Parameters.AddWithValue("@DateTo", dtLeaveTo)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    ReturnValue = dr.Item("Result")
                End While
                con.Close()

                Return ReturnValue
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
                Return Nothing
            End If
        End Try
        Return ReturnValue
    End Function

    Public Shared Sub SendEMail(ByVal UserID As String, ByVal Category As String)
        Dim cmd As New SqlCommand()
        Dim rd As SqlDataReader
        Dim MailFrom As String
        Dim MailTo As String
        Dim MailSubject As String
        Dim MailBody As String
        Dim MailLink As String
        Dim MailCC As String
        Dim MailBCC As String

        Dim cn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)
        Try
            cn.Open()
            cmd.Connection = cn

            cmd.CommandText = "exec prMail '" & "','" & UserID & "','" & Category & "'"
            rd = cmd.ExecuteReader()
            rd.Read()

            MailFrom = rd.GetValue(0)
            MailTo = rd.GetValue(1)
            MailSubject = rd.GetValue(2)
            MailBody = rd.GetValue(3)
            MailLink = rd.GetValue(4)
            MailCC = rd.GetValue(5)
            MailBCC = rd.GetValue(6)
            cn.Close()


            'Dim message As New MailMessage
            Dim ToList As String()
            Dim ToCount As Integer
            Dim CCList As String()
            Dim CCCount As Integer
            Dim BCCList As String()
            Dim BCCCount As Integer
            Dim i As Integer
            Dim MessageClient As New SmtpClient

            Dim mail As New Net.Mail.MailMessage()

            ToList = Split(MailTo, ";")
            ToCount = ToList.Length
            For i = 1 To ToCount
                If ToList(i - 1) <> "" Then
                    mail.To.Add(New MailAddress(ToList(i - 1)))
                End If
            Next

            CCList = Split(MailCC, ";")
            CCCount = CCList.Length
            For i = 1 To CCCount
                If CCList(i - 1) <> "" Then
                    mail.CC.Add(New MailAddress(CCList(i - 1)))
                End If
            Next

            BCCList = Split(MailBCC, ";")
            BCCCount = BCCList.Length
            For i = 1 To BCCCount
                If BCCList(i - 1) <> "" Then
                    mail.Bcc.Add(New MailAddress(BCCList(i - 1)))
                End If
            Next

            mail.From = New MailAddress(MailFrom)
            mail.Subject = MailSubject
            mail.Body = MailBody + MailLink

            'MessageClient.Host = "ULX-MAIL-SRV"
            Dim smtp As New SmtpClient("192.168.1.242", 25)

            'smtp.Send(mail)

        Catch ex As SqlException
            cn.Close()
        End Try
    End Sub

    Public Function fnGetLeaveRequestForApproval(ByVal EmployeeID As String, ByVal Status As String) As DataSet

        Dim sp As String = "spGetLeaveReqForApproval"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                cmd.Parameters.AddWithValue("@Status", Status)
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

    Public Function fnGetReqLeaveReqByUser(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetReqLeaveReqByUser"
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

    Public Function ChangeApplicationStatus(ByVal LeaveTypeID As String, ByVal LeaveRequestID As String, ByVal TakenAction As String, ByVal ApproverID As String, ByVal Remarks As String) As Integer
        Dim sp As String = "spChangeStatusForLeaveRequest"
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@LeaveTypeID", LeaveTypeID)
                cmd.Parameters.AddWithValue("@LeaveRequestID", LeaveRequestID)
                cmd.Parameters.AddWithValue("@TakenAction", TakenAction)
                cmd.Parameters.AddWithValue("@ApproverID", ApproverID)
                cmd.Parameters.AddWithValue("@Remarks", Remarks)
                cmd.ExecuteNonQuery()
                con.Close()
                Return 1
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
                Return 0
            End If
        End Try
    End Function

    Public Function fnGetApprovedLeave(ByVal EmployeeID As String, ByVal DateFrom As String, ByVal DateTo As String, ByVal LeaveTypeID As String) As DataSet

        Dim sp As String = "spGetApprovedLeaveList"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                cmd.Parameters.AddWithValue("@DateFrom", DateFrom)
                cmd.Parameters.AddWithValue("@DateTo", DateTo)
                cmd.Parameters.AddWithValue("@LeaveTypeID", LeaveTypeID)
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

    Public Function fnRptLeaveQuery(ByVal EmployeeID As String, ByVal DateFrom As String, ByVal DateTo As String, ByVal LeaveTypeID As String) As DataSet

        Dim sp As String = "spRptLeaveQuery"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                cmd.Parameters.AddWithValue("@DateFrom", DateFrom)
                cmd.Parameters.AddWithValue("@DateTo", DateTo)
                cmd.Parameters.AddWithValue("@LeaveTypeID", LeaveTypeID)
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

    Public Function fnGetApprovedLeaveListForRejection(ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetApprovedLeaveListForRejection"
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

    Public Function fnInsertLeaveBalance(ByVal TotalLeave As String, ByVal LeaveYear As String, ByVal AllEmployeeID As String, ByVal EntryBy As String) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertLeaveBalance", con)
            con.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@TotalLeave", TotalLeave)
            cmd.Parameters.AddWithValue("@LeaveYear", LeaveYear)
            cmd.Parameters.AddWithValue("@AllEmployeeID", AllEmployeeID)
            cmd.Parameters.AddWithValue("@EntryBy", EntryBy)

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

    Public Function fnGetEmployeeDetailInfoFprLeave() As DataSet
        Dim sp As String = "spGetEmployeeInfoForLeave"
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

    Public Function fnGetLeaveMatrix(ByVal Year As String) As DataSet
        Dim sp As String = "spGetLeaveMatrix"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@Year", Year)
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

    Public Function GetBalancedEmployee(ByVal EmployeeID As String, ByVal LeaveYear As Integer) As String
        Dim sp As String = "spGetBalancedEmployee"
        Dim dr As SqlDataReader
        Dim ReturnValue As String = ""
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@LeaveYear", LeaveYear)
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    ReturnValue = dr.Item("Result")
                End While
                con.Close()

                Return ReturnValue
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
                Return Nothing
            End If
        End Try
        Return ReturnValue
    End Function

    Public Function IsApprover(ByVal LoginUserID As String) As String
        Dim sp As String = "spGetIsApprover"
        Dim dr As SqlDataReader
        Dim ReturnValue As String = ""
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@LoginUserID", LoginUserID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    ReturnValue = dr.Item("Status")
                End While
                con.Close()

                Return ReturnValue
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
                Return Nothing
            End If
        End Try
        Return ReturnValue
    End Function

    Public Function IsRecommender(ByVal LoginUserID As String) As String
        Dim sp As String = "spGetIsRecommender"
        Dim dr As SqlDataReader
        Dim ReturnValue As String = ""
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@LoginUserID", LoginUserID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    ReturnValue = dr.Item("Status")
                End While
                con.Close()

                Return ReturnValue
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
                Return Nothing
            End If
        End Try
        Return ReturnValue
    End Function

    Public Function fnInsertApprovedleaveRejection(ByVal LeaveRequest As clsLeaveRequest) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertApprovedleaveRejection", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@LeaveRequestID", LeaveRequest.LeaveRequestID)
            cmd.Parameters.AddWithValue("@Remarks", LeaveRequest.Remarks)
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

    Public Function fnApproveApprovedleaveRejection(ByVal LeaveRequest As clsLeaveRequest) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spApproveApprovedleaveRejection", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@AppLeaveRejectionID", LeaveRequest.AppLeaveRejectionID)
            cmd.Parameters.AddWithValue("@ActionType", LeaveRequest.ActionType)
            cmd.Parameters.AddWithValue("@ActorRemarks", LeaveRequest.ActorRemarks)
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

    Public Function fnGetPendingListOfAppLvRejectionReq(ByVal ApproverID As String) As DataSet
        Dim sp As String = "spGetPendingListOfAppLvRejectionReq"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ApproverID", ApproverID)
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

    Public Function fnGetEmpLeaveReqDetails(ByVal EmployeeID As String) As DataSet
        Dim sp As String = "spGetEmpLeaveReqDetails"
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

End Class
