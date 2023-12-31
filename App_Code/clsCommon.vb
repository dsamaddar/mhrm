﻿Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports System.IO

Public Class clsCommon

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Public Function CheckPermissionForOwnInfo(ByVal LoginUserId As String) As Boolean
        Dim sp As String = "spPermissionForOwnInfo"
        Dim dr As SqlDataReader
        Dim ReturnValue As Boolean
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@LoginUserId", LoginUserId)
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

    Public Function CheckPermissionForOthers(ByVal LoginUserId As String) As String
        Dim sp As String = "spPermissionForOthers"
        Dim dr As SqlDataReader
        Dim ReturnValue As String = ""
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@LoginUserId", LoginUserId)
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

    Public Function CheckAsciiValue(ByVal str As String) As String
        Dim Ch As Char() = str
        Dim strVar As String = ""
        Dim Holder As Integer = 0
        Dim i As Integer = 0
        Dim Dch As Char = ""

        For i = 0 To str.Length - 1
            Holder = Asc(Ch(i))

            If i > 0 Then
                Dch = Ch(i - 1)
            Else
                Dch = Ch(i)
            End If

            If Holder >= 32 And Holder <= 122 Then
                If Ch(i) = Chr(32) And Dch = Chr(32) Then

                Else
                    strVar += Convert.ToString(Ch(i))
                End If
            Else
                strVar += Chr(32).ToString()
            End If

        Next
        Return Trim(strVar)
    End Function

    Public Shared Sub ExportToExel(ByVal grdvw As GridView, ByVal rptname As String)

        Dim attachment As String = "attachment; filename=" & rptname & ".xls"
        HttpContext.Current.Response.ClearContent()
        HttpContext.Current.Response.AddHeader("content-disposition", attachment)
        HttpContext.Current.Response.ContentType = "application/ms-excel"
        Dim sw As New StringWriter()
        Dim htw As New HtmlTextWriter(sw)

        grdvw.AllowSorting = False
        grdvw.AllowPaging = False
        grdvw.AutoGenerateSelectButton = False
        grdvw.AutoGenerateEditButton = False
        grdvw.AutoGenerateDeleteButton = False
        grdvw.DataBind()

        ' Create a form to contain the grid
        Dim frm As New HtmlForm()
        grdvw.Parent.Controls.Add(frm)
        frm.Attributes("runat") = "server"
        frm.Controls.Add(grdvw)

        frm.RenderControl(htw)
        'grdvw.RenderControl(htw)
        HttpContext.Current.Response.Write(sw.ToString())
        HttpContext.Current.Response.[End]()

    End Sub

End Class
