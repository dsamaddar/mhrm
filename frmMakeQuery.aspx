<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmMakeQuery.aspx.vb" Inherits="frmMakeQuery" Title=".:m-HRM:Query Tool:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td class="label">
                Select Type :
                <asp:DropDownList ID="drpObjects" runat="server" AutoPostBack="True" CssClass="InputTxtBox">
                    <%--<asp:ListItem>BASE TABLE</asp:ListItem>--%>
                    <asp:ListItem>VIEW</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
            <td align="left" class="label">
                TOP:
                <asp:DropDownList ID="drpTop" runat="server" CssClass="InputTxtBox">
                    <asp:ListItem>N\A</asp:ListItem>
                    <asp:ListItem>50</asp:ListItem>
                    <asp:ListItem>100</asp:ListItem>
                    <asp:ListItem>1000</asp:ListItem>
                </asp:DropDownList>
                &nbsp;JOIN TYPE :
                <asp:DropDownList ID="drpJoinType" runat="server" CssClass="InputTxtBox">
                    <asp:ListItem>N\A</asp:ListItem>
                    <asp:ListItem>Inner Join</asp:ListItem>
                    <asp:ListItem>Left Join</asp:ListItem>
                    <asp:ListItem>Right Join</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td valign="top" align="left" class="style1">
                <div style="max-height: 400px; max-width: 300px; overflow: auto">
                    <asp:CheckBoxList ID="ChkEntityNames" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                        DataTextField="TABLE_NAME" DataValueField="TABLE_NAME" CssClass="label">
                    </asp:CheckBoxList>
                    <cc1:RoundedCornersExtender ID="ChkEntityNames_RoundedCornersExtender" runat="server"
                        Enabled="True" TargetControlID="ChkEntityNames">
                    </cc1:RoundedCornersExtender>
                    <cc1:ListSearchExtender ID="ChkEntityNames_ListSearchExtender" runat="server" Enabled="True"
                        TargetControlID="ChkEntityNames">
                    </cc1:ListSearchExtender>
                </div>
            </td>
            <td valign="top" align="left" class="">
                <div style="max-width: 300px;">
                    <asp:CheckBox ID="chkCheckAllColumns" runat="server" runat="server" AutoPostBack="True"
                        Text="Check All" CssClass="label" />
                </div>
                <div style="max-height: 200px; max-width: 300px; overflow: auto">
                    <asp:CheckBoxList ID="chkColumnNames" runat="server" DataSourceID="SqlDataSource2"
                        DataTextField="COLUMN_NAME" DataValueField="COLUMN_NAME" CssClass="label" AutoPostBack="True">
                    </asp:CheckBoxList>
                </div>
                <div class="label">
                    Related Tables</div>
                <div style="max-height: 400px; max-width: 300px; overflow: auto">
                    <asp:TreeView ID="someTree" runat="server" ShowCheckBoxes="All" ShowLines="True">
                    </asp:TreeView>
                </div>
            </td>
            <td valign="top" align="left">
                <asp:Panel ID="Panel1" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <asp:Button ID="btnGenerateSql" runat="server" Text="Generate SQL" CssClass="styled-button-1" />
                                &nbsp;<asp:Button ID="btnShowResult" runat="server" Text="Show Result" CssClass="styled-button-1" />
                                &nbsp;<asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="styled-button-1" />
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <asp:TextBox ReadOnly="true" ID="txtGeneratedQuery" runat="server" Height="300px"
                                    TextMode="MultiLine" Width="400px" CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td>
                <table style="width: 100%;">
                    <tr>
                        <td class="label" align="left">
                            Add Condition
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="label" align="left">
                            Column Name
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="drpWhereClauseColumnNames" runat="server" CssClass="InputTxtBox"
                                Width="200px">
                            </asp:DropDownList>
                            &nbsp;<asp:RequiredFieldValidator ID="reqFldWhereClauseColumnNames" runat="server"
                                ControlToValidate="drpWhereClauseColumnNames" ErrorMessage="*" ValidationGroup="Condition"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="label" align="left">
                            Operator
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="drpWhereClauseOperatorList" runat="server" CssClass="InputTxtBox"
                                Width="100px" AutoPostBack="True">
                                <asp:ListItem>=</asp:ListItem>
                                <asp:ListItem>&gt;</asp:ListItem>
                                <asp:ListItem>&lt;</asp:ListItem>
                                <asp:ListItem>&gt;=</asp:ListItem>
                                <asp:ListItem>&lt;=</asp:ListItem>
                                <asp:ListItem>&lt;&gt;</asp:ListItem>
                                <asp:ListItem>LIKE</asp:ListItem>
                                <asp:ListItem>NOT LIKE</asp:ListItem>
                                <asp:ListItem>IS NULL</asp:ListItem>
                                <asp:ListItem>IS NOT NULL</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp;<asp:RequiredFieldValidator ID="reqFldOperatorList" runat="server" ControlToValidate="drpWhereClauseOperatorList"
                                ErrorMessage="*" ValidationGroup="Condition"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="label" align="left">
                            Value
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtValueField" runat="server" Width="100px" ValidationGroup="Condition"></asp:TextBox>
                            &nbsp;<asp:RequiredFieldValidator ID="reqFldValueField" runat="server" ControlToValidate="txtValueField"
                                ErrorMessage="*" ValidationGroup="Condition"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="left">
                            <asp:Button ID="btnAddWhereClause" runat="server" Text="ADD" CssClass="styled-button-1"
                                ValidationGroup="Condition" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="left">
                            <asp:GridView ID="grdWhereClauseList" runat="server" AutoGenerateColumns="False"
                                CssClass="mGrid">
                                <Columns>
                                    <asp:CommandField ShowDeleteButton="True" />
                                    <asp:TemplateField HeaderText="ParameterName">
                                        <ItemTemplate>
                                            <asp:Label ID="lblParameterName" runat="server" Text='<%#Eval("ParameterName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Operator">
                                        <ItemTemplate>
                                            <asp:Label ID="lblOperator" runat="server" Text='<%#Eval("Operator") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Value">
                                        <ItemTemplate>
                                            <asp:Label ID="lblValue" runat="server" Text='<%#Eval("Value") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top" align="left" class="" colspan="3">
                <asp:Button ID="btnExport" runat="server" CssClass="styled-button-1" Text="Export Result" />
                &nbsp;
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HRMConnectionString %>"
                    SelectCommand="spGetAllEntityByType" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:HRMConnectionString.ProviderName %>">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="EHRM" Name="TABLE_CATALOG" Type="String" />
                        <asp:ControlParameter ControlID="drpObjects" DefaultValue="BASE TABLE" Name="TABLE_TYPE"
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:HRMConnectionString %>"
                    SelectCommand="spGetColumnNamesByEntity" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="EHRM" Name="TABLE_CATALOG" Type="String" />
                        <asp:ControlParameter ControlID="ChkEntityNames" DefaultValue="%" Name="TABLE_NAME"
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                &nbsp;<asp:SqlDataSource ID="SqlDataSource3" runat="server"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td valign="top" align="left" class="" colspan="4">
                <div style="max-height: 600px; max-width: 100%; overflow: auto">
                    <asp:GridView ID="grdQueryResult" runat="server" EmptyDataText="Nothing Found" CssClass="mGrid">
                    </asp:GridView>
                </div>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="">
                &nbsp;
            </td>
            <td class="">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
