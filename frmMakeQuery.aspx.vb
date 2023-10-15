Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports System
Imports System.Web.UI
Imports System.IO
Imports System.Drawing

Partial Class frmMakeQuery
    Inherits System.Web.UI.Page

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString)

    Dim MakeQueryData As clsMakeQueryDataAccess = New clsMakeQueryDataAccess()
    Dim HoldChild(1000) As String
    Dim hchild As Integer = 0
    Dim TotalRowCount As Integer = 0

    Protected Sub btnGenerateSql_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerateSql.Click

        Dim Query As String = ""

        If drpTop.Text <> "N\A" Then
            Query = "Select top " + drpTop.SelectedValue + " "
        Else
            Query = "Select "
        End If

        Dim ListOfColumns As String = ""
        Dim ListOfColumnsForOtherTable As String = ""
        Dim FromString As String = ""

        Dim ColumnItem As ListItem
        For Each ColumnItem In chkColumnNames.Items

            If ColumnItem.Selected = True Then

                If ColumnItem.Text.Contains(" ") Then
                    ListOfColumns += ChkEntityNames.SelectedItem.ToString() + "." + "[" + ColumnItem.Text + "]" + ", "
                Else
                    ListOfColumns += ChkEntityNames.SelectedItem.ToString() + "." + ColumnItem.Text + ", "
                End If
            End If

        Next

        '' Building Related Tables.
        For Each node As TreeNode In someTree.Nodes
            If node.Checked = True Then
                If drpJoinType.SelectedValue <> "N\A" Then
                    FromString += " " + drpJoinType.SelectedValue.ToString() + " " + node.Text + " ON " + MakeQueryData.fnGetForeignKeyReference("dbo." + ChkEntityNames.SelectedItem.Text, "dbo." + node.Text)
                Else
                    FromString += node.Text + ","
                End If

                For Each childnode As TreeNode In node.ChildNodes
                    If childnode.Checked = True Then
                        ListOfColumnsForOtherTable += node.Text + "." + childnode.Text + ", "
                    End If
                Next
            End If

        Next

        If ListOfColumnsForOtherTable = "" Then
            ListOfColumns = ListOfColumns.Remove(Len(ListOfColumns) - 2)
        Else
            ListOfColumnsForOtherTable = ListOfColumnsForOtherTable.Remove(Len(ListOfColumnsForOtherTable) - 2)
        End If



        If drpJoinType.SelectedValue <> "N\A" Then
            Query += ListOfColumns + ListOfColumnsForOtherTable + " From " + ChkEntityNames.SelectedItem.Text + FromString
        Else
            '' Getting From String.
            If FromString <> "" Then
                FromString = FromString.Remove(Len(FromString) - 1)
                Query += ListOfColumns + ListOfColumnsForOtherTable + " From " + ChkEntityNames.SelectedItem.Text + "," + FromString
            Else
                Query += ListOfColumns + ListOfColumnsForOtherTable + " From " + ChkEntityNames.SelectedItem.Text
            End If

        End If

        '' Building Where Clause
        Dim WhereClause As String = ""
        Dim lblParameterName As System.Web.UI.WebControls.Label = New System.Web.UI.WebControls.Label
        Dim lblOperator As System.Web.UI.WebControls.Label = New System.Web.UI.WebControls.Label
        Dim lblValue As System.Web.UI.WebControls.Label = New System.Web.UI.WebControls.Label

        If grdWhereClauseList.Rows.Count > 0 Then
            WhereClause += " Where "
        End If

        For Each rw As GridViewRow In grdWhereClauseList.Rows
            lblParameterName = rw.FindControl("lblParameterName")
            lblOperator = rw.FindControl("lblOperator")
            lblValue = rw.FindControl("lblValue")

            If lblValue.Text = "N\A" Then
                WhereClause += lblParameterName.Text + " " + lblOperator.Text + " " + " AND "
            Else
                WhereClause += lblParameterName.Text + " " + lblOperator.Text + " " + "'" + lblValue.Text + "'" + " AND "
            End If

        Next

        If WhereClause <> "" Then
            WhereClause = WhereClause.Remove(Len(WhereClause) - 4)
        End If

        Query += WhereClause

        txtGeneratedQuery.Text = Query

    End Sub

    Protected Sub btnShowResult_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowResult.Click

        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()

        txtGeneratedQuery.Text = Replace(Replace(txtGeneratedQuery.Text, "update", ""), "delete", "")

        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(txtGeneratedQuery.Text, con)
                cmd.CommandType = CommandType.Text
                da.SelectCommand = cmd
                da.Fill(ds)

            End Using
            grdQueryResult.DataSource = ds
            grdQueryResult.DataBind()
            con.Close()
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If

        End Try

    End Sub

    Protected Sub chkCheckAllColumns_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkCheckAllColumns.CheckedChanged
        Dim ColumnItem As ListItem
        If chkCheckAllColumns.Checked = True Then

            If drpWhereClauseColumnNames.Items.Count = 0 Then
                For Each ColumnItem In chkColumnNames.Items
                    ColumnItem.Selected = True
                    If ColumnItem.Text.Contains(" ") Then
                        drpWhereClauseColumnNames.Items.Add(ChkEntityNames.Text + ".[" + ColumnItem.Text + "]")
                    Else
                        drpWhereClauseColumnNames.Items.Add(ChkEntityNames.Text + "." + ColumnItem.Text)
                    End If
                Next
            Else
                For Each ColumnItem In chkColumnNames.Items
                    ColumnItem.Selected = True
                Next
            End If


            chkCheckAllColumns.Text = "Un Check All"
        Else
            For Each ColumnItem In chkColumnNames.Items
                ColumnItem.Selected = False
            Next
            chkCheckAllColumns.Text = "Check All"
        End If
    End Sub

    Protected Sub btnReset_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReset.Click

        txtGeneratedQuery.Text = ""
        Dim ColumnItem As ListItem
        For Each ColumnItem In chkColumnNames.Items
            ColumnItem.Selected = False
        Next
        chkCheckAllColumns.Text = "Check All"
        chkCheckAllColumns.Checked = False

        grdQueryResult.DataSource = ""
        grdQueryResult.DataBind()

        drpTop.SelectedIndex = -1

        txtValueField.Text = ""
        drpWhereClauseColumnNames.SelectedIndex = -1
        drpWhereClauseOperatorList.SelectedIndex = -1

        drpWhereClauseColumnNames.DataSource = ""
        drpWhereClauseColumnNames.DataBind()

    End Sub

    Protected Sub btnExport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExport.Click
        Try
            Response.Clear()
            Response.Buffer = True
            Response.AddHeader("content-disposition", "attachment;filename=query_result.xls")
            Response.Charset = ""
            Response.ContentType = "application/vnd.ms-excel"
            Using sw As New StringWriter()
                Dim hw As New HtmlTextWriter(sw)

                'To Export all pages
                grdQueryResult.HeaderRow.BackColor = Color.White
                For Each cell As TableCell In grdQueryResult.HeaderRow.Cells
                    cell.BackColor = grdQueryResult.HeaderStyle.BackColor
                Next
                For Each row As GridViewRow In grdQueryResult.Rows
                    row.BackColor = Color.White
                    For Each cell As TableCell In row.Cells
                        If row.RowIndex Mod 2 = 0 Then
                            cell.BackColor = grdQueryResult.AlternatingRowStyle.BackColor
                        Else
                            cell.BackColor = grdQueryResult.RowStyle.BackColor
                        End If
                        cell.CssClass = "textmode"
                    Next
                Next

                grdQueryResult.RenderControl(hw)
                'style to format numbers to string
                Dim style As String = "<style> .textmode { } </style>"
                Response.Write(style)
                Response.Output.Write(sw.ToString())
                Response.Flush()
                Response.[End]()
            End Using
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            'Dim MenuIDs As String
            'MenuIDs = Session("PermittedMenus")

            'If InStr(MenuIDs, "MQuery~") = 0 Then
            '    Response.Redirect("~\Default.aspx")
            'End If


            Dim dtWhereClause As DataTable = New DataTable()
            dtWhereClause = FormatWhereClauseCondition()
            Session("WhereClause") = dtWhereClause
        End If
    End Sub

    Public Sub FillTree(ByVal PRIMARYKEYTABLE As String)
        Try
            someTree.Nodes.Clear()
            con.Open()
            Dim cmd As SqlCommand = New SqlCommand("Select distinct replace(FOREIGNKEYTABLE,'dbo.','') as 'FOREIGNKEYTABLE' from vwKeyConstraintList " & _
           " Where PRIMARYKEYTABLE='dbo." + PRIMARYKEYTABLE + "' and FOREIGNKEYTABLE <> 'N/A'", con)
            Dim dr As SqlDataReader = cmd.ExecuteReader()

            'cmd.Dispose()

            Dim ParentNode(100, 0) As String
            Dim count As Integer = 0
            Dim found As Integer = 0
            While dr.Read()
                ParentNode(count, 0) = dr.GetValue(dr.GetOrdinal("FOREIGNKEYTABLE")).ToString()
                count = count + 1
            End While

            dr.Close()
            For i As Integer = 0 To count - 1
                Dim childstr(100, 1) As String
                Dim countChild As Integer = 0

                Dim root As TreeNode = New TreeNode()
                root.Text = ParentNode(i, 0)
                cmd = New SqlCommand("Select COLUMN_NAME from information_schema.columns  " & _
             " Where TABLE_CATALOG='HRM' and TABLE_NAME='" + ParentNode(i, 0).ToString() + "'", con)
                dr = cmd.ExecuteReader()

                While dr.Read()
                    childstr(countChild, 0) = dr.GetValue(dr.GetOrdinal("COLUMN_NAME")).ToString()
                    childstr(countChild, 1) = dr.GetValue(dr.GetOrdinal("COLUMN_NAME")).ToString()
                    countChild = countChild + 1
                End While
                dr.Close()

                For j As Integer = 0 To countChild - 1
                    Dim child As TreeNode = New TreeNode()
                    child.Value = childstr(j, 0)
                    child.Text = childstr(j, 1)


                    For k As Integer = 0 To hchild

                        If HoldChild(k) = Nothing Then
                            Exit For
                        End If

                        If child.Text.ToString() = HoldChild(k).ToString() Then
                            found = 1
                            Exit For
                        End If
                    Next

                    If found = 0 Then
                        root.ChildNodes.Add(GetChild(child.Value, child))
                        ' root.ShowCheckBox = True
                        'root.ToolTip = child.Value

                        'root.ChildNodes.Add(child)
                    End If

                    found = 0
                Next
                someTree.Nodes.Add(root)
                countChild = 0
            Next
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Private Function GetChild(ByVal ParentID As String, ByVal ntreeNode As TreeNode) As TreeNode
        Try
            If ParentID = Nothing Then
                Return Nothing
            End If

            Dim node As TreeNode = New TreeNode()
            node = ntreeNode

            Dim cmd As SqlCommand = New SqlCommand("Select COLUMN_NAME from information_schema.columns  " & _
           " Where TABLE_CATALOG='HRM' and TABLE_NAME='" + ParentID + "'", con)

            Dim dr As SqlDataReader = cmd.ExecuteReader()
            Dim count As Integer = 0
            Dim childstr(100, 1) As String
            While dr.Read()
                childstr(count, 0) = dr.GetValue(dr.GetOrdinal("COLUMN_NAME")).ToString()
                childstr(count, 1) = dr.GetValue(dr.GetOrdinal("COLUMN_NAME")).ToString()
                count = count + 1
            End While
            dr.Close()

            For i As Integer = 0 To count - 1
                Dim child As TreeNode = New TreeNode()
                child.Value = childstr(i, 0)
                child.Text = childstr(i, 1)
                If child.Value <> "" Then
                    'node.ChildNodes.Add(child)
                    'node.ShowCheckBox = True
                    'node.ToolTip = child.Value
                    child.ToolTip = child.Value
                    node.ChildNodes.Add(GetChild(child.Value, child))

                End If
            Next
            HoldChild(hchild) = node.Text
            hchild = hchild + 1
            Return node
        Catch ex As Exception
            MessageBox(ex.Message)
            Return Nothing
        End Try
    End Function

    Protected Sub ChkEntityNames_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChkEntityNames.SelectedIndexChanged
        Try
            FillTree(ChkEntityNames.SelectedValue)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub grdQueryResult_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdQueryResult.RowDataBound
        Try
            If grdQueryResult.Rows.Count > -1 Then
                If e.Row.RowType = DataControlRowType.DataRow Then
                    TotalRowCount += 1
                End If
            End If

            If e.Row.RowType = DataControlRowType.Footer Then
                e.Row.Cells(1).Text = "Total Result :" + " (" + TotalRowCount.ToString() + ")"
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub chkColumnNames_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkColumnNames.SelectedIndexChanged
        'ClearWhereClauseColumns()
        Try
            If drpWhereClauseColumnNames.Items.Count = 0 Then
                Dim ColumnItem As ListItem
                For Each ColumnItem In chkColumnNames.Items
                    If ColumnItem.Text.Contains(" ") Then
                        drpWhereClauseColumnNames.Items.Add(ChkEntityNames.Text + ".[" + ColumnItem.Text + "]")
                    Else
                        drpWhereClauseColumnNames.Items.Add(ChkEntityNames.Text + "." + ColumnItem.Text)
                    End If
                Next
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ClearWhereClauseColumns()
        Try
            drpWhereClauseColumnNames.DataSource = ""
            drpWhereClauseColumnNames.DataBind()

            grdWhereClauseList.DataSource = ""
            grdWhereClauseList.DataBind()
            Session("WhereClause") = ""
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnAddWhereClause_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddWhereClause.Click
        Try
            Dim dtWhereClause As DataTable = New DataTable()
            dtWhereClause = GetWhereClauseCondition()
            Session("WhereClause") = dtWhereClause

            grdWhereClauseList.DataSource = dtWhereClause
            grdWhereClauseList.DataBind()

            drpWhereClauseColumnNames.SelectedIndex = -1
            drpWhereClauseOperatorList.SelectedIndex = -1
            txtValueField.Text = ""
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Function FormatWhereClauseCondition() As DataTable
        Try
            Dim dt As DataTable = New DataTable()
            dt.Columns.Add("ParameterName", System.Type.GetType("System.String"))
            dt.Columns.Add("Operator", System.Type.GetType("System.String"))
            dt.Columns.Add("Value", System.Type.GetType("System.String"))
            Return dt
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Function

    Protected Function GetWhereClauseCondition() As DataTable
        Try
            Dim dtWhereClause As DataTable = New DataTable()

            dtWhereClause = Session("WhereClause")

            'If (CheckProductLedger() = 0) Then
            '    Return dtSecurityInfo
            'End If
            Dim dr As DataRow
            dr = dtWhereClause.NewRow()
            dr("ParameterName") = drpWhereClauseColumnNames.Text
            dr("Operator") = drpWhereClauseOperatorList.Text

            If drpWhereClauseOperatorList.SelectedItem.Text = "LIKE" Or drpWhereClauseOperatorList.SelectedItem.Text = "NOT LIKE" Then
                dr("Value") = "%" + txtValueField.Text + "%"
            Else
                dr("Value") = txtValueField.Text
            End If

            dtWhereClause.Rows.Add(dr)
            dtWhereClause.AcceptChanges()
            Return dtWhereClause
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

        Return Nothing
    End Function

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub grdWhereClauseList_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles grdWhereClauseList.RowDeleting
        Try
            Dim i As Integer
            Dim dtWhereClause As DataTable = New DataTable()
            dtWhereClause = Session("WhereClause")

            i = e.RowIndex

            dtWhereClause.Rows(i).Delete()
            dtWhereClause.AcceptChanges()
            grdWhereClauseList.DataSource = dtWhereClause
            grdWhereClauseList.DataBind()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub drpWhereClauseOperatorList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpWhereClauseOperatorList.SelectedIndexChanged
        Try
            If drpWhereClauseOperatorList.SelectedValue = "IS NULL" Or drpWhereClauseOperatorList.SelectedValue = "IS NOT NULL" Then
                txtValueField.Text = "N\A"
                txtValueField.Enabled = False
            Else
                txtValueField.Enabled = True
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub someTree_TreeNodeCheckChanged(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.TreeNodeEventArgs) Handles someTree.TreeNodeCheckChanged

    End Sub

End Class
