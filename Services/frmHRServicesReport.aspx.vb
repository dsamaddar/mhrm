
Partial Class frmHRServicesReport
    Inherits System.Web.UI.Page

    Dim HRServiceData As New clsHRServices()
    Dim EmpInfoData As New clsEmployeeInfo()
    Dim HRServiceReqData As New clsHRServiceRequest()

    Protected Sub btnShowReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowReport.Click

        Dim HRServiceReq As New clsHRServiceRequest()
        HRServiceReq.HRServiceID = drpHRServices.SelectedValue
        HRServiceReq.EmployeeID = drpUserList.SelectedValue
        HRServiceReq.IsServiceProvidedEX = drpIsServiceProvided.SelectedValue
        HRServiceReq.ServiceStatus = drpServiceStatus.SelectedValue

        grdHRServicesReport.DataSource = HRServiceReqData.fnReportHRServicesIssue(HRServiceReq)
        grdHRServicesReport.DataBind()

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetActiveHRServices()
            ShowUserList()
        End If
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub ShowUserList()
        drpUserList.DataTextField = "EmployeeName"
        drpUserList.DataValueField = "EmployeeID"
        drpUserList.DataSource = EmpInfoData.fnGetEmployeeList()
        drpUserList.DataBind()

        Dim A As New ListItem()

        A.Text = "N\A"
        A.Value = "N\A"

        drpUserList.Items.Insert(0, A)
    End Sub

    Protected Sub GetActiveHRServices()
        drpHRServices.DataTextField = "HRService"
        drpHRServices.DataValueField = "HRServiceID"
        drpHRServices.DataSource = HRServiceData.fnGetActiveHRServices()
        drpHRServices.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpHRServices.Items.Insert(0, A)
    End Sub

End Class
