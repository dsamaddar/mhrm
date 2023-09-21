<%@ Page Language="VB" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master"
    AutoEventWireup="false" CodeFile="frmEmpEduInfo.aspx.vb" Inherits="EmployeeProfile_frmEmpEduInfo"
    Title=".:m-HRM:Employee Education:." Theme="CommonSkin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../Sources/css/UltraCssClass.css" rel="stylesheet" type="text/css" />
    <table style="width: 100%;">
        <tr align="center">
            <td align="left" style="width: 790px;">
                <div class="widgettitle">
                    Educational Qualification<asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                </div>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlEduInfo" runat="server" SkinID="pnlInner" Width="100%">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td class="label" colspan="2" style="color: Green;">
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td align="left" class="label" style="width: 150px">
                                <asp:Label ID="lblHolder" runat="server" Text="" Visible="false"></asp:Label>
                            </td>
                            <td style="width: 230px">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label" style="width: 20px">
                                &nbsp;
                            </td>
                            <td align="left" class="label" style="width: 100px">
                                Degree Type<span class="RequiredLabel">*</span>
                            </td>
                            <td align="left" style="width: 300px">
                                <asp:RadioButtonList ID="rdoDegreeType" runat="server" CssClass="rbdText" RepeatDirection="Horizontal"
                                    AutoPostBack="true">
                                    <asp:ListItem Value="Local"> Local </asp:ListItem>
                                    <asp:ListItem Value="Foreign"> Foreign </asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ID="reqFldGender" runat="server" ControlToValidate="rdoDegreeType"
                                    ErrorMessage="Degree Type Required" ValidationGroup="btnEdu" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldGender_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldGender" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png"
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                Degree Name<span class="RequiredLabel">*</span>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlExamName" runat="server" CssClass="InputTxtBox" Width="230px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                Major<span class="RequiredLabel">*</span>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlMajor" runat="server" Width="230px" CssClass="InputTxtBox">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                Passing Year<span class="RequiredLabel">*</span>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlPassingYear" runat="server" CssClass="InputTxtBox" Width="230px">
                                    <asp:ListItem Value="YYYY" Text="YYYY"></asp:ListItem>
                                    <asp:ListItem Value="1970" Text="1970"></asp:ListItem>
                                    <asp:ListItem Value="1971" Text="1971"></asp:ListItem>
                                    <asp:ListItem Value="1972" Text="1972"></asp:ListItem>
                                    <asp:ListItem Value="1973" Text="1973"></asp:ListItem>
                                    <asp:ListItem Value="1974" Text="1974"></asp:ListItem>
                                    <asp:ListItem Value="1975" Text="1975"></asp:ListItem>
                                    <asp:ListItem Value="1976" Text="1976"></asp:ListItem>
                                    <asp:ListItem Value="1977" Text="1977"></asp:ListItem>
                                    <asp:ListItem Value="1978" Text="1978"></asp:ListItem>
                                    <asp:ListItem Value="1979" Text="1979"></asp:ListItem>
                                    <asp:ListItem Value="1980" Text="1980"></asp:ListItem>
                                    <asp:ListItem Value="1981" Text="1981"></asp:ListItem>
                                    <asp:ListItem Value="1982" Text="1982"></asp:ListItem>
                                    <asp:ListItem Value="1983" Text="1983"></asp:ListItem>
                                    <asp:ListItem Value="1984" Text="1984"></asp:ListItem>
                                    <asp:ListItem Value="1985" Text="1985"></asp:ListItem>
                                    <asp:ListItem Value="1986" Text="1986"></asp:ListItem>
                                    <asp:ListItem Value="1987" Text="1987"></asp:ListItem>
                                    <asp:ListItem Value="1988" Text="1988"></asp:ListItem>
                                    <asp:ListItem Value="1989" Text="1989"></asp:ListItem>
                                    <asp:ListItem Value="1990" Text="1990"></asp:ListItem>
                                    <asp:ListItem Value="1991" Text="1991"></asp:ListItem>
                                    <asp:ListItem Value="1992" Text="1992"></asp:ListItem>
                                    <asp:ListItem Value="1993" Text="1993"></asp:ListItem>
                                    <asp:ListItem Value="1994" Text="1994"></asp:ListItem>
                                    <asp:ListItem Value="1995" Text="1995"></asp:ListItem>
                                    <asp:ListItem Value="1996" Text="1996"></asp:ListItem>
                                    <asp:ListItem Value="1997" Text="1997"></asp:ListItem>
                                    <asp:ListItem Value="1998" Text="1998"></asp:ListItem>
                                    <asp:ListItem Value="1999" Text="1999"></asp:ListItem>
                                    <asp:ListItem Value="2000" Text="2000"></asp:ListItem>
                                    <asp:ListItem Value="2001" Text="2001"></asp:ListItem>
                                    <asp:ListItem Value="2002" Text="2002"></asp:ListItem>
                                    <asp:ListItem Value="2003" Text="2003"></asp:ListItem>
                                    <asp:ListItem Value="2004" Text="2004"></asp:ListItem>
                                    <asp:ListItem Value="2005" Text="2005"></asp:ListItem>
                                    <asp:ListItem Value="2006" Text="2006"></asp:ListItem>
                                    <asp:ListItem Value="2007" Text="2007"></asp:ListItem>
                                    <asp:ListItem Value="2008" Text="2008"></asp:ListItem>
                                    <asp:ListItem Value="2009" Text="2009"></asp:ListItem>
                                    <asp:ListItem Value="2010" Text="2010"></asp:ListItem>
                                    <asp:ListItem Value="2011" Text="2011"></asp:ListItem>
                                    <asp:ListItem Value="2012" Text="2012"></asp:ListItem>
                                    <asp:ListItem Value="2013" Text="2013"></asp:ListItem>
                                    <asp:ListItem Value="2014" Text="2014"></asp:ListItem>
                                    <asp:ListItem Value="2015" Text="2015"></asp:ListItem>
                                    <asp:ListItem Value="2016" Text="2016"></asp:ListItem>
                                    <asp:ListItem Value="2017" Text="2017"></asp:ListItem>
                                    <asp:ListItem Value="2018" Text="2018"></asp:ListItem>
                                    <asp:ListItem Value="2019" Text="2019"></asp:ListItem>
                                    <asp:ListItem Value="2020" Text="2020"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                            </td>
                            <td align="left" class="label">
                                Board/University/College<span class="RequiredLabel">*</span>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlBoard" runat="server" CssClass="InputTxtBox" Width="230px"
                                    AutoPostBack="True">
                                </asp:DropDownList>
                                &nbsp;<asp:Button ID="btnAddInstitution" runat="server" CssClass="styled-button-1"
                                    Text="ADD" ValidationGroup="Submit" />
                                &nbsp;<asp:Label ID="lblInstitutionAdd" runat="server">
                                    <asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
                                    &nbsp;
                                    <asp:TextBox ID="txtBoard" runat="server" Width="200px" CssClass="InputTxtBox"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="reqFldBoardName" runat="server" ControlToValidate="txtBoard"
                                        ErrorMessage="Other Institution Name Required " ValidationGroup="Submit" Display="None"></asp:RequiredFieldValidator>
                                    <cc1:ValidatorCalloutExtender ID="reqFldBoardName_ValidatorCalloutExtender" runat="server"
                                        Enabled="True" TargetControlID="reqFldBoardName" CssClass="customCalloutStyle"
                                        CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                    </cc1:ValidatorCalloutExtender>
                                </asp:Label>
                            </td>
                        </tr>
                        <tr id="idForOthers" runat="server">
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                <b>Others Institution Name</b><span class="RequiredLabel">*</span>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtOtherInsName" runat="server" ValidationGroup="btnEdu" CssClass="InputTxtBox"
                                    Width="200px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ReqFldValidatorOtherInsName" runat="server" ControlToValidate="txtOtherInsName"
                                    ErrorMessage="Others Institution Name Required" ValidationGroup="btnEdu" Display="None"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="ReqFldValidatorOtherInsName_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="ReqFldValidatorOtherInsName" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                <b>Result Type</b><span class="RequiredLabel">*</span>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlResultType" runat="server" AutoPostBack="True" Width="230px"
                                    CssClass="InputTxtBox">
                                    <asp:ListItem Value="-Select-" Text="-Select-"></asp:ListItem>
                                    <asp:ListItem Value="GPA" Text="CGPA"></asp:ListItem>
                                    <asp:ListItem Value="Division" Text="Class/Division"></asp:ListItem>
                                    <asp:ListItem Value="Appeared" Text="Appeared"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="ForGPA" runat="server">
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                <b>Result</b><span class="RequiredLabel">*</span>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtResult" CssClass="InputTxtBox" runat="server" Width="80px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="ReqFldValidatorResult" runat="server" ControlToValidate="txtResult"
                                    ErrorMessage="Result Required" ValidationGroup="Submit" Display="None"></asp:RequiredFieldValidator><cc1:ValidatorCalloutExtender
                                        ID="ReqFldValidatorResult_ValidatorCalloutExtender" runat="server" Enabled="True"
                                        TargetControlID="ReqFldValidatorResult" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png"
                                        WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                    </cc1:ValidatorCalloutExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditResult" runat="server" AcceptNegative="None"
                                    ErrorTooltipEnabled="True" InputDirection="RightToLeft" Mask="9.99" MaskType="Number"
                                    MessageValidatorTip="true" TargetControlID="txtResult" />
                                <cc1:MaskedEditValidator ID="MaskedEditValResult" runat="server" ControlExtender="MaskedEditResult"
                                    ControlToValidate="txtResult" EmptyValueBlurredText="*" EmptyValueMessage="Enter Some Numbers"
                                    IsValidEmpty="false" MaximumValue="5" MaximumValueMessage="Number must be less than 5 or equal"
                                    MinimumValue="1" MinimumValueMessage="Number must be greater than -1 and posive"
                                    ToolTip="Enter values from 0 to 5" ValidationGroup="InsertJobCircular">
                                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </cc1:MaskedEditValidator>
                                Out of&nbsp;
                                <asp:TextBox ID="txtOutOf" CssClass="InputTxtBox" runat="server" Width="80px"></asp:TextBox>
                                &nbsp;
                                <asp:RequiredFieldValidator ID="reqfldOutOf" runat="server" ControlToValidate="txtOutOf"
                                    ErrorMessage="Out of Required" ValidationGroup="Submit" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqfldOutOf_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqfldOutOf" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png"
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                                <cc1:MaskedEditExtender ID="MskEdtPresentSalary" runat="server" AcceptNegative="None"
                                    ErrorTooltipEnabled="True" InputDirection="RightToLeft" Mask="9.99" MaskType="Number"
                                    MessageValidatorTip="true" TargetControlID="txtOutOf" />
                                <cc1:MaskedEditValidator ID="MskEdtValPresentSalary" runat="server" ControlExtender="MskEdtPresentSalary"
                                    ControlToValidate="txtOutOf" EmptyValueBlurredText="*" EmptyValueMessage="Enter Some Numbers"
                                    IsValidEmpty="false" MaximumValue="5" MaximumValueMessage="Number must be less than 5 or equal"
                                    MinimumValue="1" MinimumValueMessage="Number must be greater than -1 and posive"
                                    ToolTip="Enter values from 0 to 5" ValidationGroup="InsertJobCircular">
                                &nbsp;&nbsp;&nbsp;
                                </cc1:MaskedEditValidator>
                            </td>
                        </tr>
                        <tr id="ForDivision" runat="server">
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                <b>Result</b><span class="RequiredLabel">*</span>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlDivision" runat="server" Width="230px" CssClass="InputTxtBox">
                                    <asp:ListItem>1st Division</asp:ListItem>
                                    <asp:ListItem>2nd Division</asp:ListItem>
                                    <asp:ListItem>3rd Division</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="Tr1" runat="server">
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left">
                                <asp:Label ID="lblErrorMessageOnEDU" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left">
                                <asp:Button ID="btnAddEdu" runat="server" ValidationGroup="btnEdu" CssClass="styled-button-1"
                                    Text="ADD" Width="120px" />
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlEducation" runat="server" Width="100%" SkinID="pnlInner">
                    <div style="max-height: 200px; max-width: 100%; overflow: auto">
                        <asp:GridView ID="grdEducation" runat="server" AutoGenerateColumns="False" SkinID="grdNoFooter"
                            CssClass="mGrid">
                            <Columns>
                                <asp:TemplateField HeaderText="Sl">
                                    <ItemTemplate>
                                        <font style="font-size: 12px"><b>
                                            <%#CType(Container, GridViewRow).RowIndex + 1%></b> </font>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Degree Type">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDegreeType" runat="server" Text='<%# Bind("DegreeType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ExamID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblExamID" runat="server" Text='<%# Bind("ExamID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Degree Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblExamName" runat="server" Text='<%# Bind("ExamName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Major ID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMajorID" runat="server" Text='<%# Bind("MajorID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Major">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMajor" runat="server" Text='<%# Bind("Major") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="InstitutionID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblInstitutionID" runat="server" Text='<%# Bind("InstitutionID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Institutaion">
                                    <ItemTemplate>
                                        <asp:Label ID="lblInstitutaionName" runat="server" Text='<%# Bind("InstitutionName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Passing Year">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPassingYear" runat="server" Text='<%# Bind("PassingYear") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Result Type">
                                    <ItemTemplate>
                                        <asp:Label ID="lblResultType" runat="server" Text='<%# Bind("ResultType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Result">
                                    <ItemTemplate>
                                        <asp:Label ID="lblResult" runat="server" Text='<%# Bind("Result") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Out Of">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOutOf" runat="server" Text='<%# Bind("OutOf") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:ImageButton Height="20px" ID="imgDelete" CommandName="Delete" runat="server"
                                            OnClientClick="return confirm('Are You Sure You Want to Delete?')" ImageUrl="~/Sources/images/erase.png"
                                            CausesValidation="False" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlEduQuaSave" runat="server" SkinID="pnlInner" Width="100%">
                    <asp:Button ID="btnSubmitEmpEduInfo" runat="server" Text="Save" CssClass="styled-button-1"
                        ValidationGroup="SubmitCanDef" Width="120px" />
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>
