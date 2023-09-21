Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Runtime.InteropServices
Imports System.Data.SqlClient
Imports System.Net.Dns
Imports System.Security.Principal
Imports System.Security.Cryptography

Partial Class frmHRMLogin
    Inherits System.Web.UI.Page

    Dim Cypher As New clsCaesarCypher()
    Dim EmpInfoData As New clsEmployeeInfo()
    Dim DashBoardData As New clsDashBoard()

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    <DllImport("ADVAPI32.dll", EntryPoint:="LogonUserW", SetLastError:=True, CharSet:=CharSet.Auto)> _
    Public Shared Function LogonUser(ByVal lpszUsername As String, ByVal lpszDomain As String, ByVal lpszPassword As String, ByVal dwLogonType As Integer, ByVal dwLogonProvider As Integer, ByRef phToken As IntPtr) As Boolean
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim UserID As String = ""
        Dim Password As String = ""

        UserID = Request.QueryString("UserID")
        Password = Request.QueryString("Password")

        Session("LoginUserID") = UserID
        Session("Password") = Password

        If Not IsPostBack Then
            Session("PermittedMenus") = ""
            Session("EmployeeID") = ""
            Session("UniqueUserID") = ""
            Session("UserID") = ""
            Session("UserType") = ""
            Session("UserName") = ""
            Session("ULCBranchID") = ""
        End If
    End Sub

    Protected Sub LoginButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LoginButton.Click
        Try
            '********************** Check License ********************************
            Dim DashBoard As clsDashBoard = DashBoardData.fnGetDashBoardInfo()

            If DashBoard.AvailableUser <= 0 Then
                MessageBox("License Expiry Date : " & DashBoard.LicenseExpiryDate.ToString() & "\n" & _
                           "Maximum User Limit  : " & DashBoard.MaximumUser.ToString() & "\n" & _
                           "Total Allocated User: " & DashBoard.TotalUser.ToString() & "\n" & _
                           "Available User      : " & DashBoard.AvailableUser.ToString() & "")
                Exit Sub
            End If
            '********************** Check License ********************************

            Dim UniqueUserID As String = ""
            Dim EmpInfo As New clsEmployeeInfo()
            EmpInfo.EmpCode = UserName.Text
            EmpInfo.UserID = UserName.Text
            EmpInfo.Password = Password.Text

            Session("LoginUserID") = UserName.Text
            Session("Password") = Password.Text

            EmpInfo = EmpInfoData.fnCheckUserLogin(EmpInfo)

            If EmpInfo.EmployeeID = "" Or EmpInfo.EmployeeID = Nothing Then
                MessageBox("Provide Correct Credentials")
            Else
                FormsAuthentication.RedirectFromLoginPage(EmpInfo.UserID, False)
                UniqueUserID = EmpInfo.EmployeeID
                Session("UniqueUserID") = EmpInfo.EmployeeID
                Session("UserID") = EmpInfo.UserID
                Session("UserType") = EmpInfo.UserType
                Session("UserName") = EmpInfo.EmployeeName
                Session("ULCBranchID") = EmpInfo.ULCBranchID
                Session("PermittedMenus") = EmpInfo.PermittedMenus
                If EmpInfo.UserType = "Admin" Then
                    Response.Redirect("frmDashBoard.aspx")
                Else
                    Session("EmployeeID") = UniqueUserID
                    UniqueUserID = Cypher.Encrypt(UniqueUserID)
                    Response.Redirect("~/EmployeeProfile/frmEmployeeDetails.aspx?EmployeeID=" & UniqueUserID)
                End If
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

End Class
