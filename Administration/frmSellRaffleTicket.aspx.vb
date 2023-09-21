Imports System.Data
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Net
Imports System.IO

Partial Class Administration_frmSellRaffleTicket
    Inherits System.Web.UI.Page

    Dim EmpData As New clsEmployeeInfo()
    Dim DeptData As New clsDepartment()
    Dim CouponData As New clsCoupons()
    Public dtTicketStructure As New DataTable()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetEmployeeList()
            ShowDepertment()
            GetAvailableTickets()
            dtTicketStructure = FormatTicket()
        End If
    End Sub

    Protected Sub GetAvailableTickets()
        Try
            chkTicketList.DataTextField = "CouponNo"
            chkTicketList.DataValueField = "SLNO"
            chkTicketList.DataSource = CouponData.fnGetAvailableTickets()
            chkTicketList.DataBind()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ShowDepertment()
        Try
            drpSelectDepartment.DataTextField = "DeptName"
            drpSelectDepartment.DataValueField = "DepartmentID"
            drpSelectDepartment.DataSource = DeptData.fnGetDeptList()
            drpSelectDepartment.DataBind()

            Dim A As New ListItem
            A.Text = "ALL"
            A.Value = "ALL"

            drpSelectDepartment.Items.Insert(0, A)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub GetEmployeeList()
        drpEmployeeList.DataValueField = "EmployeeID"
        drpEmployeeList.DataTextField = "EmployeeName"
        drpEmployeeList.DataSource = EmpData.fnGetEmpListPayrollActive()
        drpEmployeeList.DataBind()

        Dim A As New ListItem
        A.Text = "ALL"
        A.Value = "ALL"

        drpEmployeeList.Items.Insert(0, A)
    End Sub

    Protected Sub drpEmployeeList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpEmployeeList.SelectedIndexChanged
        GetTicketsOwnedByEmp(drpEmployeeList.SelectedValue)
    End Sub

    Protected Sub GetTicketsOwnedByEmp(ByVal EmployeeID As String)
        Try
            lblTicketsOwnedByEmp.Text = CouponData.fnGetTicketsOwnedByEmp(drpEmployeeList.SelectedValue)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnConfirmTicket_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnConfirmTicket.Click
        Try
            If drpEmployeeList.SelectedValue = "ALL" Then
                MessageBox("Select An Employee First.")
                Exit Sub
            End If

            Dim Count As Boolean = False
            For Each item As ListItem In chkTicketList.Items
                If item.Selected = True Then
                    Count = True
                    Exit For
                End If
            Next

            If Count = False Then
                MessageBox("Select A Valid Coupon No.")
                Exit Sub
            End If

            Dim Coupon As New clsCoupons()
            Coupon.EmployeeID = drpEmployeeList.SelectedValue
            Coupon.SoldBy = Session("LoginUserID")

            For Each item As ListItem In chkTicketList.Items
                If item.Selected = True Then
                    Coupon.SLNO = item.Value
                    Dim result As Integer = CouponData.fnConfirmTicketSelection(Coupon)
                    If result = 1 Then
                        MessageBox(" Coupon No : " & item.Text & " Confirmed for " & drpEmployeeList.SelectedItem.Text)
                    Else
                        MessageBox("Error In Coupon Selection.")
                    End If
                End If
            Next
            ClearForm()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ClearForm()
        GetAvailableTickets()
        GetTicketsOwnedByEmp(drpEmployeeList.SelectedValue)
    End Sub

    Protected Sub btnExportTicket_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExportTicket.Click
        Dim strPath As String = ""
        Dim myImage As System.Drawing.Image
        Dim converter As New System.Drawing.ImageConverter
        Dim myReport As New ReportDocument()
        Dim folder As String
        Dim f As String
        Dim repName As String

        Try
            Dim serverName As [String], uid As [String], pwd As [String], dbName As [String]
            dtTicketStructure = CouponData.fnRptExportTicket(drpSelectDepartment.SelectedValue, drpEmployeeList.SelectedValue).Tables(0)

            'dtTicketStructure.Columns.Add(New DataColumn("Picture", System.Type.GetType("System.Byte[]")))
            'dtTicketStructure.AcceptChanges()

            Dim tClient As WebClient = New WebClient

            For Each rw As DataRow In dtTicketStructure.Rows
                strPath = ConfigurationManager.AppSettings("OutputEHRMFiles") & rw.Item("Photos")
                Dim memStrmPic As MemoryStream = New MemoryStream(tClient.DownloadData(strPath))
                myImage = System.Drawing.Image.FromStream(memStrmPic)
                rw.Item("Picture") = converter.ConvertTo(myImage, System.Type.GetType("System.Byte[]"))
                rw.AcceptChanges()
            Next

            Dim conStr As String = ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString
            Dim retArr As [String](), usrArr As [String](), pwdArr As [String](), serverArr As [String](), dbArr As [String]()


            f = "~/Reports/"
            folder = Server.MapPath(f)
            repName = folder & "rptRaffleTicket.rpt"
            myReport.Load(repName)

            retArr = conStr.Split(";")
            serverArr = retArr(0).Split("=")
            dbArr = retArr(1).Split("=")
            usrArr = retArr(2).Split("=")
            pwdArr = retArr(3).Split("=")

            serverName = serverArr(1)
            uid = usrArr(1)
            pwd = pwdArr(1)
            dbName = dbArr(1)

            myReport.SetDatabaseLogon(uid, pwd, serverName, dbName)
            myReport.SetDataSource(dtTicketStructure)
            myReport.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, True, "Ticket-" & Now.Ticks.ToString())

            'Dim mem As MemoryStream
            'mem = DirectCast(myReport.ExportToStream(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat), MemoryStream)
            'Response.Clear()
            'Response.Buffer = True
            'Response.ContentType = "application/pdf"
            'Response.AddHeader("Content-Disposition", "attachment;filename=Ticket-" & Now.Ticks.ToString() & ".pdf")
            'Response.BinaryWrite(mem.ToArray())
            'Response.End()

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Function FormatTicket() As DataTable
        Dim dt As DataTable = New DataTable()
        dt.Columns.Add("EmployeeName", System.Type.GetType("System.String"))
        dt.Columns.Add("TicketList", System.Type.GetType("System.String"))
        dt.Columns.Add("Photos", System.Type.GetType("System.String"))
        dt.Columns.Add("Picture", System.Type.GetType("System.Byte[]"))
        Return dt
    End Function

End Class
