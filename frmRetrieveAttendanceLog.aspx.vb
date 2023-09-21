
Imports System.Data.OleDb

Partial Class frmRetrieveAttendanceLog
    Inherits System.Web.UI.Page

    Dim UsrAttData As New clsUserAttendance()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetAttendanceLog()
        End If
    End Sub

    Protected Sub GetAttendanceLog()
        Try
            grdAttendanceLog.DataSource = UsrAttData.fnGetUsrAttInfo(UsrAttData.fnUsrAttLogIndex())
            grdAttendanceLog.DataBind()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub


    Protected Sub btnImportData_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnImportData.Click
        Dim UsrAtt As New clsUserAttendance()
        Dim chkItems As CheckBox
        Dim Counter As Integer = 0
        Dim lbllogindex, lbllogtime, lbluserid, lblnodeid, lblauthtype, lblslogtime As Label

        Try
            For Each row As GridViewRow In grdAttendanceLog.Rows
                chkItems = row.FindControl("chkItems")
                If chkItems.Checked = True Then
                    lbllogindex = row.FindControl("lbllogindex")
                    lbllogtime = row.FindControl("lbllogtime")
                    lbluserid = row.FindControl("lbluserid")
                    lblnodeid = row.FindControl("lblnodeid")
                    lblauthtype = row.FindControl("lblauthtype")
                    lblslogtime = row.FindControl("lblslogtime")

                    UsrAtt.LogIndex = lbllogindex.Text
                    UsrAtt.LogTime = lbllogtime.Text
                    UsrAtt.AttendanceID = lbluserid.Text
                    UsrAtt.NodeID = lblnodeid.Text
                    UsrAtt.AuthType = lblauthtype.Text
                    UsrAtt.SLogTime = lblslogtime.Text

                    Dim check As Integer = UsrAttData.fnInsertUserAttendance(UsrAtt)

                    If check = 1 Then
                        Counter += 1
                        chkItems.Checked = False
                    End If

                End If
            Next

            MessageBox("Total Imported Attendance Log : " & Counter.ToString())
            GetAttendanceLog()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

    Protected Sub chkSelectAll_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim chkSelectAll, chkItems As CheckBox

        Try
            chkSelectAll = grdAttendanceLog.HeaderRow.FindControl("chkSelectAll")

            If chkSelectAll.Checked = True Then
                For Each row As GridViewRow In grdAttendanceLog.Rows
                    chkItems = row.FindControl("chkItems")
                    chkItems.Checked = True
                Next
            Else
                For Each row As GridViewRow In grdAttendanceLog.Rows
                    chkItems = row.FindControl("chkItems")
                    chkItems.Checked = False
                Next
            End If
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

End Class
