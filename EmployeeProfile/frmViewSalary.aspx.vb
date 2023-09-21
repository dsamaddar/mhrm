Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Net
Imports System.IO

Partial Class EmployeeProfile_frmViewSalary
    Inherits System.Web.UI.Page

    Dim EmpInfoData As New clsEmployeeInfo()
    Dim EmpSalaryProfileData As New clsEmpSalaryProfile()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim ToWhomProShow As String = Session("ToWhomProShow")

            getBasicProfileInfo(ToWhomProShow)
            'GetEmpSalaryByID(ToWhomProShow)
            GetEmpSalaryByID(Session("UniqueUserID"))
        End If
    End Sub

    Protected Sub GetEmpSalaryByID(ByVal EmployeeID As String)
        Try
            Dim EmpSalaryProfile As New clsEmpSalaryProfile()
            EmpSalaryProfile = EmpSalaryProfileData.fnGetEmpSalaryByID(EmployeeID)

            lblBasicSalary.Text = String.Format("{0:N2}", EmpSalaryProfile.BasicSalary)
            lblHouseMaintenance.Text = String.Format("{0:N2}", EmpSalaryProfile.HouseMaintenance)
            lblConsolidated.Text = String.Format("{0:N2}", EmpSalaryProfile.Consolidated)
            lblConveyanceAllowance.Text = String.Format("{0:N2}", EmpSalaryProfile.Conveyance)
            lblEntertainmentAllowance.Text = String.Format("{0:N2}", EmpSalaryProfile.Entertainment)
            lblHouseMaintenance.Text = String.Format("{0:N2}", EmpSalaryProfile.HouseMaintenance)
            lblHouseRentAllowance.Text = String.Format("{0:N2}", EmpSalaryProfile.HouseRent)
            lblMonthlyGross.Text = String.Format("{0:N2}", EmpSalaryProfile.Gross)
            lblPFContribution.Text = String.Format("{0:N2}", EmpSalaryProfile.PF)
            lblNetMonthlySalary.Text = String.Format("{0:N2}", EmpSalaryProfile.Net)
            lblMedicalAllowance.Text = String.Format("{0:N2}", EmpSalaryProfile.Medical)
            lblLoanDeduction.Text = String.Format("{0:N2}", EmpSalaryProfile.LoanDeduction)
            lblTAX.Text = String.Format("{0:N2}", EmpSalaryProfile.Tax)
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

    Protected Sub getBasicProfileInfo(ByVal EmployeeID As String)
        Try
            Dim EmpInfo As New clsEmployeeInfo()
            EmpInfo = EmpInfoData.fnGetBasicProfile(EmployeeID)

            Dim pnlEmpSummary As Panel
            Master.FindControl("pnlEmpSummary")
            pnlEmpSummary = Master.FindControl("pnlEmpSummary")

            Dim lblEmployeeName, lblEmployeeID, lblOfficialDesignation, lblFunctionalDesignation, lblDepartment, lblSupervisorName, lblEmployeeType, lblServiceLength, lblLocation As Label
            Dim imgEmployee As Image
            Dim hpLnkCanProfile As New HyperLink

            lblEmployeeName = pnlEmpSummary.FindControl("lblEmployeeName")
            lblEmployeeID = pnlEmpSummary.FindControl("lblEmployeeID")
            lblOfficialDesignation = pnlEmpSummary.FindControl("lblOfficialDesignation")
            lblFunctionalDesignation = pnlEmpSummary.FindControl("lblFunctionalDesignation")
            lblDepartment = pnlEmpSummary.FindControl("lblDepartment")
            lblSupervisorName = pnlEmpSummary.FindControl("lblSupervisorName")
            lblEmployeeType = pnlEmpSummary.FindControl("lblEmployeeType")
            lblServiceLength = pnlEmpSummary.FindControl("lblServiceLength")
            lblLocation = pnlEmpSummary.FindControl("lblLocation")
            imgEmployee = pnlEmpSummary.FindControl("imgEmployee")
            hpLnkCanProfile = pnlEmpSummary.FindControl("hpLnkCanProfile")

            lblEmployeeName.Text = EmpInfo.EmployeeName
            lblEmployeeID.Text = EmpInfo.EmpCode
            lblOfficialDesignation.Text = EmpInfo.OfficialDesignation
            lblFunctionalDesignation.Text = EmpInfo.FunctionalDesignation
            lblDepartment.Text = EmpInfo.Department
            lblSupervisorName.Text = EmpInfo.CurrentSupervisor
            lblEmployeeType.Text = EmpInfo.EmpType
            lblServiceLength.Text = EmpInfo.ServiceLength
            lblLocation.Text = EmpInfo.Branch

            If EmpInfo.Photos = "" Then
                imgEmployee.ImageUrl = "~\Sources\images\human.png"
            Else
                ShowImage(ConfigurationManager.AppSettings("OutputEHRMFiles") & EmpInfo.Photos, "imgEmployee")
            End If

            'lblImg.Text = imgEmployee.ImageUrl
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ShowImage(ByVal UrlStr As String, ByVal ControlName As String)
        Try
            Dim tClient As WebClient = New WebClient
            Dim memStrmPic As MemoryStream = New MemoryStream(tClient.DownloadData(UrlStr))
            Dim bytesPic As Byte() = memStrmPic.ToArray()
            Dim base64StringPic As String = Convert.ToBase64String(bytesPic, 0, bytesPic.Length)

            Dim imgCtrl As System.Web.UI.WebControls.Image = Master.FindControl(ControlName)
            imgCtrl.ImageUrl = "data:image/png;base64," & base64StringPic
            memStrmPic.Dispose()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub



End Class
