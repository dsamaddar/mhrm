
Partial Class Attendance_frmQueryOnAttendance
    Inherits System.Web.UI.Page

    Dim AttData As New clsUserAttendance()
    Dim EmpData As New clsEmployeeInfo()
    Dim DeptData As New clsDepartment()
    Dim DesignationData As New clsDesignation()
    Dim NodeData As New clsNodes()

    Protected Sub btnProcessReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcessReport.Click
        Try
            Dim Att As New clsUserAttendance()

            Att.EmployeeID = drpEmployeeList.SelectedValue
            Att.DesignationID = drpDesignation.SelectedValue
            Att.DepartmentID = drpDepartments.SelectedValue
            Att.ULCBranchID = drpBranchList.SelectedValue
            Att.NodeID = drpNodeList.SelectedValue
            Att.DateFrom = Convert.ToDateTime(txtDateFrom.Text)
            Att.DateTo = Convert.ToDateTime(txtDateTo.Text)

            grdAttReport.DataSource = AttData.fnQueryOnAttendance(Att)
            grdAttReport.DataBind()
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

    Protected Sub ShowDepertment()
        Try
            drpDepartments.DataTextField = "DeptName"
            drpDepartments.DataValueField = "DepartmentID"
            drpDepartments.DataSource = DeptData.fnGetDeptList()
            drpDepartments.DataBind()

            Dim A As New ListItem
            A.Text = "ALL"
            A.Value = "ALL"

            drpDepartments.Items.Insert(0, A)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ShowDesignation()
        Try
            drpDesignation.DataTextField = "DesignationName"
            drpDesignation.DataValueField = "DesignationID"
            drpDesignation.DataSource = EmpData.fnGetOfficialDesignation()
            drpDesignation.DataBind()

            Dim A As New ListItem
            A.Text = "ALL"
            A.Value = "ALL"

            drpDesignation.Items.Insert(0, A)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ShowBranchList()
        drpBranchList.DataTextField = "ULCBranchName"
        drpBranchList.DataValueField = "ULCBranchID"
        drpBranchList.DataSource = EmpData.fnGetULCBranch()
        drpBranchList.DataBind()

        Dim A As New ListItem
        A.Text = "ALL"
        A.Value = "ALL"
        drpBranchList.Items.Insert(0, A)
    End Sub

    Protected Sub ShowNodeList()
        drpNodeList.DataTextField = "NodeName"
        drpNodeList.DataValueField = "NodeCode"
        drpNodeList.DataSource = NodeData.fnShowNodeList()
        drpNodeList.DataBind()

        Dim A As New ListItem
        A.Text = "ALL"
        A.Value = "ALL"
        drpNodeList.Items.Insert(0, A)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetEmployeeList()
            ShowDesignation()
            ShowDepertment()
            ShowBranchList()
            ShowNodeList()
            txtDateFrom.Text = Now.Date
            txtDateTo.Text = Now.Date
        End If
    End Sub

End Class
