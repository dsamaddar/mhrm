Imports System.IO

Partial Class LeaveManagement_frmLeaveQuery
    Inherits System.Web.UI.Page

    Dim LeaveData As New clsLeaveRequest()
    Dim EmpData As New clsEmployeeInfo()

    Protected Sub btnSearchApprovedLeave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearchApprovedLeave.Click
        Dim DateFrom As String
        Dim DateTo As String
        Dim LeaveTypeID As String

        Try
            DateFrom = dtApprovedLeaveDateFrom.Text
            DateTo = dtApprovedLeaveDateTo.Text
            LeaveTypeID = ddlLeaveTypeApproved.SelectedValue

            If DateFrom = "" Then
                DateFrom = "1/1/1900"
            End If

            If DateTo = "" Then
                DateTo = "1/1/2099"
            End If

            grdApprovedLeave.DataSource = LeaveData.fnRptLeaveQuery(drpSelectEmployee.SelectedValue, DateFrom, DateTo, LeaveTypeID)
            grdApprovedLeave.DataBind()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub GetEmployeeList()
        drpSelectEmployee.DataValueField = "EmployeeID"
        drpSelectEmployee.DataTextField = "EmployeeName"
        drpSelectEmployee.DataSource = EmpData.fnGetEmpListPayrollActive()
        drpSelectEmployee.DataBind()
        drpSelectEmployee.Items.Insert(0, "ALL")
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub GetLeaveType()
        Try
            ddlLeaveTypeApproved.DataTextField = "LeaveType"
            ddlLeaveTypeApproved.DataValueField = "LeaveTypeID"
            ddlLeaveTypeApproved.DataSource = LeaveData.fnGetLeaveType()
            ddlLeaveTypeApproved.DataBind()
            ddlLeaveTypeApproved.Items.Insert(0, "ALL")
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetLeaveType()
            GetEmployeeList()
        End If
    End Sub

    Protected Sub imgBtnExport_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnExport.Click
        ExportToExcel(grdApprovedLeave)
    End Sub

    Protected Sub ExportToExcel(ByVal gridview As System.Web.UI.WebControls.GridView)
        Try
            Dim sw As New StringWriter()
            Dim hw As New System.Web.UI.HtmlTextWriter(sw)
            Dim frm As HtmlForm = New HtmlForm()

            Page.Response.AddHeader("content-disposition", "attachment;filename=LeaveQuery.xls")
            Page.Response.ContentType = "application/vnd.ms-excel"
            Page.Response.Charset = ""
            Page.EnableViewState = False
            frm.Attributes("runat") = "server"
            Controls.Add(frm)
            frm.Controls.Add(gridview)
            frm.RenderControl(hw)
            Response.Write(sw.ToString())
            Response.End()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub
End Class
