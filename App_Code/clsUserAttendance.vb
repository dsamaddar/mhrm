Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports System.Data.OleDb

Public Class clsUserAttendance

    Dim con As OleDbConnection = New OleDbConnection(ConfigurationManager.ConnectionStrings("NITGENDBACConnectionString").ConnectionString)
    Dim conHRM As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim _UserAttendanceID, _EmpList, _IdealLogTimeText, _IdealLogOutTimeText, _UserID, _EmployeeID, _AttendanceID, _AttendanceIDList, _
    _DesignationID, _DepartmentID, _ULCBranchID, _UserIDList, _WorkStation, _Remarks, _DocumentReference, _EntryBy, _NodeID As String

    Public Property UserAttendanceID() As String
        Get
            Return _UserAttendanceID
        End Get
        Set(ByVal value As String)
            _UserAttendanceID = value
        End Set
    End Property

    Public Property EmpList() As String
        Get
            Return _EmpList
        End Get
        Set(ByVal value As String)
            _EmpList = value
        End Set
    End Property

    Public Property IdealLogTimeText() As String
        Get
            Return _IdealLogTimeText
        End Get
        Set(ByVal value As String)
            _IdealLogTimeText = value
        End Set
    End Property

    Public Property IdealLogOutTimeText() As String
        Get
            Return _IdealLogOutTimeText
        End Get
        Set(ByVal value As String)
            _IdealLogOutTimeText = value
        End Set
    End Property

    Public Property UserID() As String
        Get
            Return _UserID
        End Get
        Set(ByVal value As String)
            _UserID = value
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

    Public Property AttendanceID() As String
        Get
            Return _AttendanceID
        End Get
        Set(ByVal value As String)
            _AttendanceID = value
        End Set
    End Property

    Public Property AttendanceIDList() As String
        Get
            Return _AttendanceIDList
        End Get
        Set(ByVal value As String)
            _AttendanceIDList = value
        End Set
    End Property

    Public Property DesignationID() As String
        Get
            Return _DesignationID
        End Get
        Set(ByVal value As String)
            _DesignationID = value
        End Set
    End Property

    Public Property DepartmentID() As String
        Get
            Return _DepartmentID
        End Get
        Set(ByVal value As String)
            _DepartmentID = value
        End Set
    End Property

    Public Property ULCBranchID() As String
        Get
            Return _ULCBranchID
        End Get
        Set(ByVal value As String)
            _ULCBranchID = value
        End Set
    End Property

    Public Property UserIDList() As String
        Get
            Return _UserIDList
        End Get
        Set(ByVal value As String)
            _UserIDList = value
        End Set
    End Property

    Public Property WorkStation() As String
        Get
            Return _WorkStation
        End Get
        Set(ByVal value As String)
            _WorkStation = value
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

    Public Property DocumentReference() As String
        Get
            Return _DocumentReference
        End Get
        Set(ByVal value As String)
            _DocumentReference = value
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

    Public Property NodeID() As String
        Get
            Return _NodeID
        End Get
        Set(ByVal value As String)
            _NodeID = value
        End Set
    End Property

    Dim _LogIndex, _MaxLogIndex As Long

    Public Property LogIndex() As Long
        Get
            Return _LogIndex
        End Get
        Set(ByVal value As Long)
            _LogIndex = value
        End Set
    End Property

    Public Property MaxLogIndex() As Long
        Get
            Return _MaxLogIndex
        End Get
        Set(ByVal value As Long)
            _MaxLogIndex = value
        End Set
    End Property

    Dim _LogTime, _IdealLogTime, _IdealLogOutTime, _DateFrom, _DateTo, _MaxLogTime, _AbsentDate, _SLogTime As DateTime

    Public Property LogTime() As DateTime
        Get
            Return _LogTime
        End Get
        Set(ByVal value As DateTime)
            _LogTime = value
        End Set
    End Property

    Public Property IdealLogTime() As DateTime
        Get
            Return _IdealLogTime
        End Get
        Set(ByVal value As DateTime)
            _IdealLogTime = value
        End Set
    End Property

    Public Property IdealLogOutTime() As DateTime
        Get
            Return _IdealLogOutTime
        End Get
        Set(ByVal value As DateTime)
            _IdealLogOutTime = value
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

    Public Property MaxLogTime() As DateTime
        Get
            Return _MaxLogTime
        End Get
        Set(ByVal value As DateTime)
            _MaxLogTime = value
        End Set
    End Property

    Public Property AbsentDate() As DateTime
        Get
            Return _AbsentDate
        End Get
        Set(ByVal value As DateTime)
            _AbsentDate = value
        End Set
    End Property

    Public Property SLogTime() As DateTime
        Get
            Return _SLogTime
        End Get
        Set(ByVal value As DateTime)
            _SLogTime = value
        End Set
    End Property

    Dim _AuthType As Integer

    Public Property AuthType() As Integer
        Get
            Return _AuthType
        End Get
        Set(ByVal value As Integer)
            _AuthType = value
        End Set
    End Property

#Region " User Attendance LogIndex "

    Public Function fnUsrAttLogIndex() As clsUserAttendance
        Try
            Dim UsrAtt As New clsUserAttendance()
            Dim cmd As SqlCommand = New SqlCommand("spUsrAttLogIndex", conHRM)
            conHRM.Open()
            cmd.CommandType = CommandType.StoredProcedure
            Dim dr As SqlDataReader = cmd.ExecuteReader()
            While dr.Read()
                UsrAtt.MaxLogIndex = dr.Item("MaxLogIndex")
                UsrAtt.AttendanceIDList = dr.Item("AttendanceIDList")
            End While
            conHRM.Close()
            Return UsrAtt
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get User Attendance Info "

    Public Function fnGetUsrAttInfo(ByVal UsrAtt As clsUserAttendance) As DataSet

        Dim da As OleDbDataAdapter = New OleDbDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd As OleDbCommand = New OleDbCommand("SELECT  TOP 10000 logindex,logtime,userid,nodeid,authtype,slogtime FROM [NGAC_LOG] Where authresult=0 AND logindex > " + UsrAtt.MaxLogIndex.ToString() + " And userid in (" + UsrAtt.AttendanceIDList + ") order by logindex", con)
                cmd.CommandType = CommandType.Text
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

#Region " Get ZK Att Log "

    Public Function fnGetZKAttLog() As DataSet

        Dim sp As String = "spGetZKAttLog"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()

                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Insert User Attendance "
    Public Function fnInsertUserAttendance(ByVal UsrAtt As clsUserAttendance) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertUserAttendance", conHRM)
            conHRM.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@AttendanceID", UsrAtt.AttendanceID)
            cmd.Parameters.AddWithValue("@LogIndex", UsrAtt.LogIndex)
            cmd.Parameters.AddWithValue("@LogTime", UsrAtt.LogTime)
            cmd.Parameters.AddWithValue("@NodeID", UsrAtt.NodeID)
            cmd.Parameters.AddWithValue("@AuthType", UsrAtt.AuthType)
            cmd.Parameters.AddWithValue("@SLogTime", UsrAtt.SLogTime)
            cmd.ExecuteNonQuery()
            conHRM.Close()
            Return 1
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return 0
        End Try
    End Function
#End Region

#Region " Insert ZK User Attendance "
    Public Function fnInsertZKUserAttendance(ByVal UsrAtt As clsUserAttendance) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertZKUserAttendance", conHRM)
            conHRM.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@AttendanceID", UsrAtt.AttendanceID)
            cmd.Parameters.AddWithValue("@LogIndex", UsrAtt.LogIndex)
            cmd.Parameters.AddWithValue("@LogTime", UsrAtt.LogTime)
            cmd.Parameters.AddWithValue("@NodeID", UsrAtt.NodeID)
            cmd.Parameters.AddWithValue("@AuthType", UsrAtt.AuthType)
            cmd.Parameters.AddWithValue("@SLogTime", UsrAtt.SLogTime)
            cmd.ExecuteNonQuery()
            conHRM.Close()
            Return 1
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return 0
        End Try
    End Function
#End Region

#Region " Show Message By User "

    Public Function fnGetUserAttendance(ByVal UsrAtt As clsUserAttendance) As DataSet

        Dim sp As String = "spGetUserAttendance"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", UsrAtt.EmployeeID)
                cmd.Parameters.AddWithValue("@DateFrom", UsrAtt.DateFrom)
                cmd.Parameters.AddWithValue("@DateTo", UsrAtt.DateTo)
                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()

                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Daily Att Report "

    Public Function fnGetDailyAttReport(ByVal AttDate As DateTime) As DataSet

        Dim sp As String = "spGetDailyAttReport"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@AttDate", AttDate)
                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()

                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Repor Yearly Att Status "

    Public Function fnReporYearlyAttStatus(ByVal EmployeeID As String, ByVal Year As String, ByVal AttStatus As String) As DataSet

        Dim sp As String = "spReporYearlyAttStatus"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                cmd.Parameters.AddWithValue("@Year", Year)
                cmd.Parameters.AddWithValue("@AttStatus", AttStatus)
                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()
                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Late Att Report "

    Public Function fnGetLateAttReport(ByVal AttDate As DateTime) As DataSet

        Dim sp As String = "spGetLateAttReport"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@AttDate", AttDate)
                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()

                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Absent Report "

    Public Function fnGetAbsentReport(ByVal UsrAtt As clsUserAttendance) As DataSet

        Dim sp As String = "spGetAbsentReport"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", UsrAtt.EmployeeID)
                cmd.Parameters.AddWithValue("@DateFrom", UsrAtt.DateFrom)
                cmd.Parameters.AddWithValue("@DateTo", UsrAtt.DateTo)
                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()

                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Absent Report All "

    Public Function fnGetAbsentReportAll(ByVal UsrAtt As clsUserAttendance) As DataSet

        Dim sp As String = "spGetAbsentReportAll"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@AbsentDate", UsrAtt.AbsentDate)
                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()

                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Att Entry By User "

    Public Function fnGetAttEntryByUser() As DataSet

        Dim sp As String = "spGetAttEntryByUser"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()

                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Insert Admin Attendance "
    Public Function fnInsertAdminAttendance(ByVal UsrAtt As clsUserAttendance) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertAdminAttendance", conHRM)
            conHRM.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmployeeID", UsrAtt.EmployeeID)
            cmd.Parameters.AddWithValue("@LogTime", UsrAtt.LogTime)
            cmd.Parameters.AddWithValue("@IdealLogTime", UsrAtt.IdealLogTime)
            cmd.Parameters.AddWithValue("@DateTo", UsrAtt.DateTo)
            cmd.Parameters.AddWithValue("@Remarks", UsrAtt.Remarks)
            cmd.Parameters.AddWithValue("@DocumentReference", UsrAtt.DocumentReference)
            cmd.Parameters.AddWithValue("@EntryBy", UsrAtt.EntryBy)
            cmd.ExecuteNonQuery()
            conHRM.Close()
            Return 1
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return 0
        End Try
    End Function
#End Region

#Region " Update Emp Wise Att Settings "
    Public Function fnUpdateEmpWiseAttSettings(ByVal UsrAtt As clsUserAttendance) As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spUpdateEmpWiseAttSettings", conHRM)
            conHRM.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmpList", UsrAtt.EmpList)
            cmd.Parameters.AddWithValue("@IdealLoginTime", UsrAtt.IdealLogTimeText)
            cmd.Parameters.AddWithValue("@IdealLogOutTime", UsrAtt.IdealLogOutTimeText)
            cmd.ExecuteNonQuery()
            conHRM.Close()
            Return 1
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return 0
        End Try
    End Function
#End Region

#Region " Insert Usr Att Info OLD System "
    Public Function fnInsertUsrAttInfoOLDSystem() As Integer
        Try
            Dim cmd As SqlCommand = New SqlCommand("spInsertUsrAttInfoOLDSystem", conHRM)
            conHRM.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.CommandTimeout = 999999
            cmd.ExecuteNonQuery()
            conHRM.Close()
            Return 1
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return 0
        End Try
    End Function
#End Region

#Region " Get User Att Input By Admin "

    Public Function fnGetUserAttInputByAdmin(ByVal UsrAtt As clsUserAttendance) As DataSet

        Dim sp As String = "spGetUserAttInputByAdmin"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", UsrAtt.EmployeeID)
                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()

                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Att Rpt Input By Admin Entry User "

    Public Function fnGetAttRptInputByAdminEntryUser(ByVal UsrAtt As clsUserAttendance) As DataSet

        Dim sp As String = "spGetAttRptInputByAdminEntryUser"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EntryBy", UsrAtt.EntryBy)
                cmd.Parameters.AddWithValue("@DateFrom", UsrAtt.DateFrom)
                cmd.Parameters.AddWithValue("@DateTo", UsrAtt.DateTo)
                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()

                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Monthly Att. Summary "

    Public Function fnMonthlyAttSummary(ByVal Month As Integer, ByVal Year As Integer) As DataSet

        Dim sp As String = "spMonthlyAttSummary"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.CommandTimeout = 999999
                cmd.Parameters.AddWithValue("@Month", Month)
                cmd.Parameters.AddWithValue("@Year", Year)
                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()
                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Absent Matrix "

    Public Function fnGetAbsentMatrix(ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As DataSet

        Dim sp As String = "spGetAbsentMatrix"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.CommandTimeout = 999999
                cmd.Parameters.AddWithValue("@DateFrom", DateFrom)
                cmd.Parameters.AddWithValue("@DateTo", DateTo)
                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()
                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Todays Absent Emp List "

    Public Function fnGetTodaysAbsentEmpList() As DataSet
        Dim sp As String = "spGetTodaysAbsentEmpList"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()
                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Primary Warning Absent Emp List "

    Public Function fnGetPrimaryWarningAbsentEmpList() As DataSet
        Dim sp As String = "spGetPrimaryWarningAbsentEmpList"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()
                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Final Warning Absent Emp List "

    Public Function fnGetFinalWarningAbsentEmpList() As DataSet
        Dim sp As String = "spGetFinalWarningAbsentEmpList"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()
                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

    Public Function fnGetMailForDailyAbsent(ByVal EmployeeID As String) As clsMailProperty
        Dim sp As String = "spGetMailForDailyAbsent"
        Dim dr As SqlDataReader
        Dim MailProp As New clsMailProperty()
        Try
            conHRM.Open()

            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    MailProp.MailSubject = dr.Item("MailSubject")
                    MailProp.MailBody = dr.Item("MailBody")
                    MailProp.MailFrom = dr.Item("MailFrom")
                    MailProp.MailTo = dr.Item("MailTo")
                    MailProp.MailCC = dr.Item("MailCC")
                    MailProp.MailBCC = dr.Item("MailBCC")
                    MailProp.SMTPServer = dr.Item("SMTPServer")
                    MailProp.SMTPPort = dr.Item("SMTPPort")
                End While
                conHRM.Close()

                Return MailProp
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetMailForPrimaryWarningAbs(ByVal EmployeeID As String) As clsMailProperty
        Dim sp As String = "spGetMailForPrimaryWarningAbs"
        Dim dr As SqlDataReader
        Dim MailProp As New clsMailProperty()
        Try
            conHRM.Open()

            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    MailProp.MailSubject = dr.Item("MailSubject")
                    MailProp.MailBody = dr.Item("MailBody")
                    MailProp.MailFrom = dr.Item("MailFrom")
                    MailProp.MailTo = dr.Item("MailTo")
                    MailProp.MailCC = dr.Item("MailCC")
                    MailProp.MailBCC = dr.Item("MailBCC")
                    MailProp.SMTPServer = dr.Item("SMTPServer")
                    MailProp.SMTPPort = dr.Item("SMTPPort")
                End While
                conHRM.Close()

                Return MailProp
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

    Public Function fnGetMailForFinalWarningAbs(ByVal EmployeeID As String) As clsMailProperty
        Dim sp As String = "spGetMailForFinalWarningAbs"
        Dim dr As SqlDataReader
        Dim MailProp As New clsMailProperty()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    MailProp.MailSubject = dr.Item("MailSubject")
                    MailProp.MailBody = dr.Item("MailBody")
                    MailProp.MailFrom = dr.Item("MailFrom")
                    MailProp.MailTo = dr.Item("MailTo")
                    MailProp.MailCC = dr.Item("MailCC")
                    MailProp.MailBCC = dr.Item("MailBCC")
                    MailProp.SMTPServer = dr.Item("SMTPServer")
                    MailProp.SMTPPort = dr.Item("SMTPPort")
                End While
                conHRM.Close()
                Return MailProp
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#Region " Query On Attendance "

    Public Function fnQueryOnAttendance(ByVal Att As clsUserAttendance) As DataSet

        Dim sp As String = "spQueryOnAttendance"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            conHRM.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, conHRM)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.CommandTimeout = 999999
                cmd.Parameters.AddWithValue("@EmployeeID", Att.EmployeeID)
                cmd.Parameters.AddWithValue("@DesignationID", Att.DesignationID)
                cmd.Parameters.AddWithValue("@DepartmentID", Att.DepartmentID)
                cmd.Parameters.AddWithValue("@ULCBranchID", Att.ULCBranchID)
                cmd.Parameters.AddWithValue("@NodeID", Att.NodeID)
                cmd.Parameters.AddWithValue("@DateFrom", Att.DateFrom)
                cmd.Parameters.AddWithValue("@DateTo", Att.DateTo)

                da.SelectCommand = cmd
                da.Fill(ds)
                conHRM.Close()
                Return ds
            End Using
        Catch ex As Exception
            If conHRM.State = ConnectionState.Open Then
                conHRM.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

End Class
