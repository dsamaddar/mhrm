Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Data
Imports System.Net
Imports System.IO

Partial Class frmOrganizationStructure
    Inherits System.Web.UI.Page

    Dim EmpData As New clsEmployeeInfo()
    Dim DeptData As New clsDepartment()
    Public dtOrgStructure As New DataTable()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("UserName") = "" Or Session("UniqueUserID") = "" Then
                Response.Redirect("~/frmHRMLogin.aspx")
            End If

            If Not IsPostBack Then
                ShowDepertment()
                ShowDesignationOfficial()
                ShowDesignationFunctional()
                ShowULCBranch()
                ShowEmployeeType()
                getBloodGroup()
                geDistrictName()
                ShowSupervisorList()

                drpActualBirthDay.SelectedValue = "0"
                drpActualBirthMonth.SelectedValue = "0"
                dtOrgStructure = FormatOrgStructure()
            End If
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
            A.Text = "N\A"
            A.Value = "N\A"
            drpSelectDepartment.Items.Insert(0, A)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ShowULCBranch()
        drpULCBranch.DataTextField = "ULCBranchName"
        drpULCBranch.DataValueField = "ULCBranchID"
        drpULCBranch.DataSource = EmpData.fnGetULCBranch()
        drpULCBranch.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpULCBranch.Items.Insert(0, A)
    End Sub

    Protected Sub ShowDesignationOfficial()
        Try
            drpSelectDesignation.DataTextField = "DesignationName"
            drpSelectDesignation.DataValueField = "DesignationID"
            drpSelectDesignation.DataSource = EmpData.fnGetOfficialDesignation()
            drpSelectDesignation.DataBind()

            Dim A As New ListItem
            A.Text = "N\A"
            A.Value = "N\A"
            drpSelectDesignation.Items.Insert(0, A)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ShowDesignationFunctional()
        Try
            drpFunctionalDesignation.DataTextField = "DesignationName"
            drpFunctionalDesignation.DataValueField = "DesignationID"
            drpFunctionalDesignation.DataSource = EmpData.fnGetFunctionalDesignation()
            drpFunctionalDesignation.DataBind()

            Dim A As New ListItem
            A.Text = "N\A"
            A.Value = "N\A"
            drpFunctionalDesignation.Items.Insert(0, A)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ShowEmployeeType()
        Try
            drpEmployeeType.DataTextField = "EmployeeTypeName"
            drpEmployeeType.DataValueField = "EmployeeTypeID"
            drpEmployeeType.DataSource = EmpData.fnGetEmployeeType()
            drpEmployeeType.DataBind()

            Dim A As New ListItem()
            A.Text = "N\A"
            A.Value = "N\A"
            drpEmployeeType.Items.Insert(0, A)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub getBloodGroup()
        Try
            ddlBloodGrp.DataTextField = "BloodGroupName"
            ddlBloodGrp.DataValueField = "BloodGroupID"
            ddlBloodGrp.DataSource = EmpData.fnGetBloodGroup()
            ddlBloodGrp.DataBind()

            Dim A As New ListItem()
            A.Text = "N\A"
            A.Value = "N\A"
            ddlBloodGrp.Items.Insert(0, A)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub geDistrictName()
        Try
            ddlPerDistrict.DataTextField = "DistrictName"
            ddlPerDistrict.DataValueField = "DistrictID"
            ddlPerDistrict.DataSource = EmpData.getDistrictName()
            ddlPerDistrict.DataBind()

            Dim A As New ListItem()
            A.Text = "N\A"
            A.Value = "0"
            ddlPerDistrict.Items.Insert(0, A)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ShowSupervisorList()
        Try
            ddlCurrentSupervisor.DataTextField = "EmployeeName"
            ddlCurrentSupervisor.DataValueField = "EmployeeID"
            ddlCurrentSupervisor.DataSource = EmpData.fnGetEmployeeList()
            ddlCurrentSupervisor.DataBind()

            Dim A As New ListItem()
            A.Text = "N\A"
            A.Value = "N\A"
            ddlCurrentSupervisor.Items.Insert(0, A)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnSearchEmployee_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearchEmployee.Click

        Dim OrgSrchStr As New clsEmployeeInfo

        Try
            grdOrgStructure.DataSource = ""
            grdOrgStructure.DataBind()

            OrgSrchStr.EmpIDOrName = txtEmpIDOrName.Text
            OrgSrchStr.EmpTypeID = drpEmployeeType.SelectedValue

            If drpSelectDesignation.SelectedIndex = 0 Then
                OrgSrchStr.OfficialDesignationID = "N\A"
            Else
                OrgSrchStr.OfficialDesignationID = drpSelectDesignation.SelectedValue
            End If

            If drpFunctionalDesignation.SelectedIndex = 0 Then
                OrgSrchStr.FunctionalDesignationID = "N\A"
            Else
                OrgSrchStr.FunctionalDesignationID = drpFunctionalDesignation.SelectedValue
            End If

            If drpSelectDepartment.SelectedIndex = 0 Then
                OrgSrchStr.DepartmentID = "N\A"
            Else
                OrgSrchStr.DepartmentID = drpSelectDepartment.SelectedValue
            End If

            If drpULCBranch.SelectedIndex = 0 Then
                OrgSrchStr.ULCBranchID = "N\A"
            Else
                OrgSrchStr.ULCBranchID = drpULCBranch.SelectedValue
            End If

            OrgSrchStr.isActive = drpEmployeeStatus.SelectedValue
            If rdbtnGender.SelectedIndex = -1 Then
                OrgSrchStr.Gender = "N\A"
            Else
                OrgSrchStr.Gender = rdbtnGender.SelectedValue
            End If

            OrgSrchStr.CurrentSupervisor = ddlCurrentSupervisor.SelectedValue
            OrgSrchStr.BloodGroupID = ddlBloodGrp.SelectedValue
            OrgSrchStr.Religion = ddlReligion.SelectedValue
            OrgSrchStr.PerDistrict = Convert.ToInt32(ddlPerDistrict.SelectedValue)
            OrgSrchStr.ActualBirthDay = drpActualBirthDay.SelectedValue
            OrgSrchStr.ActualBirthMonth = drpActualBirthMonth.SelectedValue

            If drpActualBirthDay.SelectedValue = "0" And drpActualBirthMonth.SelectedValue <> "0" Then
                MessageBox("Select Day And Month Property For DOB properly.")
                Exit Sub
            ElseIf drpActualBirthDay.SelectedValue <> "0" And drpActualBirthMonth.SelectedValue = "0" Then
                MessageBox("Select Day And Month Property For DOB properly.")
                Exit Sub
            End If

            If txtJoiningDate.Text = "" Then
                OrgSrchStr.JoiningDate = "1/1/1900"
            Else
                OrgSrchStr.JoiningDate = Convert.ToDateTime(txtJoiningDate.Text)
            End If

            If txtJoiningDateTo.Text = "" Then
                OrgSrchStr.JoiningDateTo = "1/1/2099"
            Else
                OrgSrchStr.JoiningDateTo = Convert.ToDateTime(txtJoiningDateTo.Text)
            End If

            dtOrgStructure = EmpData.fnShowOrgStructure(OrgSrchStr).Tables(0)
            grdOrgStructure.DataSource = dtOrgStructure
            grdOrgStructure.DataBind()

            lblTotalCount.Text = grdOrgStructure.Rows.Count.ToString()
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

    Protected Sub btnCancelSelection_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelSelection.Click

        Try
            txtEmpIDOrName.Text = ""
            txtJoiningDate.Text = ""

            drpEmployeeStatus.SelectedIndex = -1
            drpEmployeeType.SelectedIndex = -1
            drpSelectDepartment.SelectedIndex = -1
            drpSelectDesignation.SelectedIndex = -1
            drpULCBranch.SelectedIndex = -1
            drpActualBirthDay.SelectedIndex = -1
            drpActualBirthMonth.SelectedIndex = -1

            ddlBloodGrp.SelectedIndex = -1
            ddlCurrentSupervisor.SelectedIndex = -1
            ddlPerDistrict.SelectedIndex = -1
            ddlReligion.SelectedIndex = -1

            grdOrgStructure.DataSource = ""
            grdOrgStructure.DataBind()

            rdbtnGender.SelectedIndex = -1
            lblTotalCount.Text = "0"
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
       
    End Sub

    Protected Function FormatOrgStructure() As DataTable
        Dim dt As DataTable = New DataTable()
        dt.Columns.Add("Photos", System.Type.GetType("System.String"))
        dt.Columns.Add("OfficialDesignation", System.Type.GetType("System.String"))
        dt.Columns.Add("EmployeeName", System.Type.GetType("System.String"))
        dt.Columns.Add("EmpCode", System.Type.GetType("System.String"))
        dt.Columns.Add("DeptName", System.Type.GetType("System.String"))
        Return dt
    End Function

    Protected Sub btnExport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExport.Click
        Dim strPath As String = ""
        Dim myImage As System.Drawing.Image
        Dim converter As New System.Drawing.ImageConverter
        Dim myReport As New ReportDocument()
        Dim folder As String
        Dim f As String
        Dim repName As String

        Try
            Dim serverName As [String], uid As [String], pwd As [String], dbName As [String]

            Dim OrgSrchStr As New clsEmployeeInfo()

            OrgSrchStr.EmpIDOrName = txtEmpIDOrName.Text
            OrgSrchStr.EmpTypeID = drpEmployeeType.SelectedValue

            If drpSelectDesignation.SelectedIndex = 0 Then
                OrgSrchStr.OfficialDesignationID = "N\A"
            Else
                OrgSrchStr.OfficialDesignationID = drpSelectDesignation.SelectedValue
            End If

            If drpFunctionalDesignation.SelectedIndex = 0 Then
                OrgSrchStr.FunctionalDesignationID = "N\A"
            Else
                OrgSrchStr.FunctionalDesignationID = drpFunctionalDesignation.SelectedValue
            End If

            If drpSelectDepartment.SelectedIndex = 0 Then
                OrgSrchStr.DepartmentID = "N\A"
            Else
                OrgSrchStr.DepartmentID = drpSelectDepartment.SelectedValue
            End If

            If drpULCBranch.SelectedIndex = 0 Then
                OrgSrchStr.ULCBranchID = "N\A"
            Else
                OrgSrchStr.ULCBranchID = drpULCBranch.SelectedValue
            End If

            OrgSrchStr.IsActive = drpEmployeeStatus.SelectedValue
            If rdbtnGender.SelectedIndex = -1 Then
                OrgSrchStr.Gender = "N\A"
            Else
                OrgSrchStr.Gender = rdbtnGender.SelectedValue
            End If

            OrgSrchStr.CurrentSupervisor = ddlCurrentSupervisor.SelectedValue
            OrgSrchStr.BloodGroupID = ddlBloodGrp.SelectedValue
            OrgSrchStr.Religion = ddlReligion.SelectedValue
            OrgSrchStr.PerDistrict = Convert.ToInt32(ddlPerDistrict.SelectedValue)
            OrgSrchStr.ActualBirthDay = drpActualBirthDay.SelectedValue
            OrgSrchStr.ActualBirthMonth = drpActualBirthMonth.SelectedValue

            If drpActualBirthDay.SelectedValue = "0" And drpActualBirthMonth.SelectedValue <> "0" Then
                MessageBox("Select Day And Month Property For DOB properly.")
                Exit Sub
            ElseIf drpActualBirthDay.SelectedValue <> "0" And drpActualBirthMonth.SelectedValue = "0" Then
                MessageBox("Select Day And Month Property For DOB properly.")
                Exit Sub
            End If

            If txtJoiningDate.Text = "" Then
                OrgSrchStr.JoiningDate = "1/1/1900"
            Else
                OrgSrchStr.JoiningDate = Convert.ToDateTime(txtJoiningDate.Text)
            End If

            If txtJoiningDateTo.Text = "" Then
                OrgSrchStr.JoiningDateTo = "1/1/2099"
            Else
                OrgSrchStr.JoiningDateTo = Convert.ToDateTime(txtJoiningDateTo.Text)
            End If

            dtOrgStructure = EmpData.fnShowOrgStructure(OrgSrchStr).Tables(0)

            dtOrgStructure.Columns.Add(New DataColumn("Picture", System.Type.GetType("System.Byte[]")))
            dtOrgStructure.AcceptChanges()
            For Each rw As DataRow In dtOrgStructure.Rows
                strPath = Server.MapPath("~/Attachments/" + rw.Item("Photos"))
                myImage = System.Drawing.Image.FromFile(strPath)
                rw.Item("Picture") = converter.ConvertTo(myImage, System.Type.GetType("System.Byte[]"))
                rw.AcceptChanges()
            Next

            Dim conStr As String = ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString
            Dim retArr As [String](), usrArr As [String](), pwdArr As [String](), serverArr As [String](), dbArr As [String]()


            f = "~/Reports/"
            folder = Server.MapPath(f)
            repName = folder & "OrgStructureReport.rpt"
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
            myReport.SetDataSource(dtOrgStructure)
            myReport.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, True, "ExportedReport")
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

    Protected Sub grdOrgStructure_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdOrgStructure.RowDataBound
        Dim lblPhotoID As New Label
        Dim imgEmployee As New Image

        If e.Row.RowType = DataControlRowType.DataRow Then
            Try
                lblPhotoID = e.Row.FindControl("lblPhotoID")
                imgEmployee = e.Row.FindControl("imgEmployee")

                Dim tClient As WebClient = New WebClient
                Dim memStrmPic As MemoryStream = New MemoryStream(tClient.DownloadData(ConfigurationManager.AppSettings("OutputEHRMFiles") & lblPhotoID.Text))
                Dim bytesPic As Byte() = memStrmPic.ToArray()
                Dim base64StringPic As String = Convert.ToBase64String(bytesPic, 0, bytesPic.Length)
                imgEmployee.ImageUrl = "data:image/png;base64," & base64StringPic
                memStrmPic.Dispose()
            Catch ex As Exception
                MessageBox(ex.Message)
            End Try
        End If
    End Sub

End Class
