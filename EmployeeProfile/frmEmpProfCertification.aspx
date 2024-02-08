<%@ Page Language="VB" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master"
    AutoEventWireup="false" CodeFile="frmEmpProfCertification.aspx.vb" Inherits="EmployeeProfile_frmEmpProfCertification"
    Title=".:m-HRM:Employee Professional Certification:." Theme="CommonSkin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <div class="widgettitle">
                    Professional Certification</div>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlEmpProfCertificationInfo" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td align="left" class="label" style="width: 20px">
                                &nbsp;
                            </td>
                            <td align="left" class="label" style="width: 150px">
                            </td>
                            <td align="left" style="width: 230px">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label" style="width: 20px">
                                &nbsp;
                            </td>
                            <td align="left" class="label" style="width: 100px">
                                Certification<span class="RequiredLabel">*</span>
                            </td>
                            <td align="left" style="width: 300px">
                                <asp:TextBox ID="txtCertificationName" runat="server" Width="250px" CssClass="InputTxtBox"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ReqFldValidatorCertificationName" runat="server"
                                    ControlToValidate="txtCertificationName" ErrorMessage="Certification Required"
                                    ValidationGroup="SubmitCan" Display="None"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="ReqFldValidatorCertificationName_ValidatorCalloutExtender0"
                                    runat="server" Enabled="True" TargetControlID="ReqFldValidatorCertificationName"
                                    CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                Issuing Authority<span class="RequiredLabel">*</span>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtInstitutionName" runat="server" Width="250px" CssClass="InputTxtBox"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ReqFldValidatorInstitutionName" runat="server" ControlToValidate="txtInstitutionName"
                                    ErrorMessage="Issuing Authority Required" ValidationGroup="SubmitCan" Display="None"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="ReqFldValidatorInstitutionName_ValidatorCalloutExtender0"
                                    runat="server" Enabled="True" TargetControlID="ReqFldValidatorInstitutionName"
                                    CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                                &nbsp;<samp style="color: Red; font-weight: bold;">[maximum 20 words]</samp>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Location
                            </td>
                            <td>
                                <asp:TextBox ID="txtLocation" runat="server" Width="250px" CssClass="InputTxtBox"></asp:TextBox>
                                <samp style="color: Red; font-weight: bold;">
                                    [maximum 100 words]</samp>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                Issuing Date<span class="RequiredLabel">*</span>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="drpMonth" runat="server" CssClass="InputTxtBox" Width="82px"
                                    Font-Size="15px">
                                    <asp:ListItem Value="MM" Text="MM"></asp:ListItem>
                                    <asp:ListItem Value="1" Text="January"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="February"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="March"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="April"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="May"></asp:ListItem>
                                    <asp:ListItem Value="6" Text="June"></asp:ListItem>
                                    <asp:ListItem Value="7" Text="July"></asp:ListItem>
                                    <asp:ListItem Value="8" Text="August"></asp:ListItem>
                                    <asp:ListItem Value="9" Text="September"></asp:ListItem>
                                    <asp:ListItem Value="10" Text="October"></asp:ListItem>
                                    <asp:ListItem Value="11" Text="November"></asp:ListItem>
                                    <asp:ListItem Value="12" Text="December"></asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpDay" runat="server" CssClass="InputTxtBox" Width="80px"
                                    Font-Size="15px">
                                    <asp:ListItem Value="DD" Text="DD"></asp:ListItem>
                                    <asp:ListItem Value="1" Text="1"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="2"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="3"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="4"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="5"></asp:ListItem>
                                    <asp:ListItem Value="6" Text="6"></asp:ListItem>
                                    <asp:ListItem Value="7" Text="7"></asp:ListItem>
                                    <asp:ListItem Value="8" Text="8"></asp:ListItem>
                                    <asp:ListItem Value="9" Text="9"></asp:ListItem>
                                    <asp:ListItem Value="10" Text="10"></asp:ListItem>
                                    <asp:ListItem Value="11" Text="11"></asp:ListItem>
                                    <asp:ListItem Value="12" Text="12"></asp:ListItem>
                                    <asp:ListItem Value="13" Text="13"></asp:ListItem>
                                    <asp:ListItem Value="14" Text="14"></asp:ListItem>
                                    <asp:ListItem Value="15" Text="15"></asp:ListItem>
                                    <asp:ListItem Value="16" Text="16"></asp:ListItem>
                                    <asp:ListItem Value="17" Text="17"></asp:ListItem>
                                    <asp:ListItem Value="18" Text="18"></asp:ListItem>
                                    <asp:ListItem Value="19" Text="19"></asp:ListItem>
                                    <asp:ListItem Value="20" Text="20"></asp:ListItem>
                                    <asp:ListItem Value="21" Text="21"></asp:ListItem>
                                    <asp:ListItem Value="22" Text="22"></asp:ListItem>
                                    <asp:ListItem Value="23" Text="23"></asp:ListItem>
                                    <asp:ListItem Value="24" Text="24"></asp:ListItem>
                                    <asp:ListItem Value="25" Text="25"></asp:ListItem>
                                    <asp:ListItem Value="26" Text="26"></asp:ListItem>
                                    <asp:ListItem Value="27" Text="27"></asp:ListItem>
                                    <asp:ListItem Value="28" Text="28"></asp:ListItem>
                                    <asp:ListItem Value="29" Text="29"></asp:ListItem>
                                    <asp:ListItem Value="30" Text="30"></asp:ListItem>
                                    <asp:ListItem Value="31" Text="31"></asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpYear" runat="server" CssClass="InputTxtBox" Width="78px"
                                    Font-Size="15px">
                                    <asp:ListItem Value="YYYY" Text="YYYY"></asp:ListItem>
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
                                    <asp:ListItem Value="2021" Text="2021"></asp:ListItem>
                                    <asp:ListItem Value="2022" Text="2022"></asp:ListItem>
                                    <asp:ListItem Value="2023" Text="2023"></asp:ListItem>
                                    <asp:ListItem Value="2024" Text="2024"></asp:ListItem>
                                    <asp:ListItem Value="2025" Text="2025"></asp:ListItem>
                                    <asp:ListItem Value="2026" Text="2026"></asp:ListItem>
                                    <asp:ListItem Value="2027" Text="2027"></asp:ListItem>
                                    <asp:ListItem Value="2028" Text="2028"></asp:ListItem>
                                    <asp:ListItem Value="2029" Text="2029"></asp:ListItem>
                                    <asp:ListItem Value="2030" Text="2030"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                Expire Date<span class="RequiredLabel">*</span>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="drpMonthTo" runat="server" CssClass="InputTxtBox" Width="82px"
                                    Font-Size="15px">
                                    <asp:ListItem Value="MM" Text="MM"></asp:ListItem>
                                    <asp:ListItem Value="1" Text="January"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="February"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="March"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="April"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="May"></asp:ListItem>
                                    <asp:ListItem Value="6" Text="June"></asp:ListItem>
                                    <asp:ListItem Value="7" Text="July"></asp:ListItem>
                                    <asp:ListItem Value="8" Text="August"></asp:ListItem>
                                    <asp:ListItem Value="9" Text="September"></asp:ListItem>
                                    <asp:ListItem Value="10" Text="October"></asp:ListItem>
                                    <asp:ListItem Value="11" Text="November"></asp:ListItem>
                                    <asp:ListItem Value="12" Text="December"></asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpDayTo" runat="server" CssClass="InputTxtBox" Width="80px"
                                    Font-Size="15px">
                                    <asp:ListItem Value="DD" Text="DD"></asp:ListItem>
                                    <asp:ListItem Value="1" Text="1"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="2"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="3"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="4"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="5"></asp:ListItem>
                                    <asp:ListItem Value="6" Text="6"></asp:ListItem>
                                    <asp:ListItem Value="7" Text="7"></asp:ListItem>
                                    <asp:ListItem Value="8" Text="8"></asp:ListItem>
                                    <asp:ListItem Value="9" Text="9"></asp:ListItem>
                                    <asp:ListItem Value="10" Text="10"></asp:ListItem>
                                    <asp:ListItem Value="11" Text="11"></asp:ListItem>
                                    <asp:ListItem Value="12" Text="12"></asp:ListItem>
                                    <asp:ListItem Value="13" Text="13"></asp:ListItem>
                                    <asp:ListItem Value="14" Text="14"></asp:ListItem>
                                    <asp:ListItem Value="15" Text="15"></asp:ListItem>
                                    <asp:ListItem Value="16" Text="16"></asp:ListItem>
                                    <asp:ListItem Value="17" Text="17"></asp:ListItem>
                                    <asp:ListItem Value="18" Text="18"></asp:ListItem>
                                    <asp:ListItem Value="19" Text="19"></asp:ListItem>
                                    <asp:ListItem Value="20" Text="20"></asp:ListItem>
                                    <asp:ListItem Value="21" Text="21"></asp:ListItem>
                                    <asp:ListItem Value="22" Text="22"></asp:ListItem>
                                    <asp:ListItem Value="23" Text="23"></asp:ListItem>
                                    <asp:ListItem Value="24" Text="24"></asp:ListItem>
                                    <asp:ListItem Value="25" Text="25"></asp:ListItem>
                                    <asp:ListItem Value="26" Text="26"></asp:ListItem>
                                    <asp:ListItem Value="27" Text="27"></asp:ListItem>
                                    <asp:ListItem Value="28" Text="28"></asp:ListItem>
                                    <asp:ListItem Value="29" Text="29"></asp:ListItem>
                                    <asp:ListItem Value="30" Text="30"></asp:ListItem>
                                    <asp:ListItem Value="31" Text="31"></asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpYearTo" runat="server" CssClass="InputTxtBox" Width="78px"
                                    Font-Size="15px">
                                    <asp:ListItem Value="YYYY" Text="YYYY"></asp:ListItem>
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
                                    <asp:ListItem Value="2021" Text="2021"></asp:ListItem>
                                    <asp:ListItem Value="2022" Text="2022"></asp:ListItem>
                                    <asp:ListItem Value="2023" Text="2023"></asp:ListItem>
                                    <asp:ListItem Value="2024" Text="2024"></asp:ListItem>
                                    <asp:ListItem Value="2025" Text="2025"></asp:ListItem>
                                    <asp:ListItem Value="2026" Text="2026"></asp:ListItem>
                                    <asp:ListItem Value="2027" Text="2027"></asp:ListItem>
                                    <asp:ListItem Value="2028" Text="2028"></asp:ListItem>
                                    <asp:ListItem Value="2029" Text="2029"></asp:ListItem>
                                    <asp:ListItem Value="2030" Text="2030"></asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;
                                <asp:CheckBox ID="chkNeverExpire" runat="server" AutoPostBack="true" />Never Expire
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td align="left">
                                <asp:Button ID="btnAddCerti" runat="server" CssClass="styled-button-1" Text="ADD"
                                    ValidationGroup="SubmitCan" Width="80px" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlCertification" runat="server" Width="100%" SkinID="pnlInner">
                    <div style="max-height: 200px; max-width: 100%; overflow: auto">
                        <asp:GridView ID="grdCertification" runat="server" AutoGenerateColumns="False" SkinID="grdNoFooter"
                            CssClass="mGrid">
                            <Columns>
                                <asp:TemplateField HeaderText="Sl">
                                    <ItemTemplate>
                                        <font style="font-size: 12px"><b>
                                            <%#CType(Container, GridViewRow).RowIndex + 1%></b> </font>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Certification">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCertificationName" runat="server" Text='<%# Bind("CertificationName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Issuing Authority">
                                    <ItemTemplate>
                                        <asp:Label ID="lblInstituteName" runat="server" Text='<%# Bind("InstituteName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Location">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLocation" runat="server" Text='<%# Bind("Location") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Issuing Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateFrom" runat="server" Text='<%#Eval("IssuingDate", "{0:D}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Expire Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateTo" runat="server" Text='<%#Eval("ExpireDate", "{0:D}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblNeverExpire" runat="server" Text='<%#Eval("NeverExpire") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:ImageButton Width="20px" ID="imgDelete" CommandName="Delete" runat="server"
                                            OnClientClick="return confirm('Are You Sure You Want to Delete?')" ImageUrl="~/Sources/images/erase.png"
                                            CausesValidation="False" Height="20px" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlProfCertSave" runat="server" SkinID="pnlInner" Style="margin-top: 0px"
                    Width="100%">
                    <asp:Button ID="btnSubmit" runat="server" Text="Save" CssClass="styled-button-1"
                        ValidationGroup="SubmitCanDef" Width="120px" />
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
