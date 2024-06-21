<%@ Page Language="VB" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master"
    AutoEventWireup="false" CodeFile="frmAssetList.aspx.vb" Inherits="EmployeeProfile_frmAssetList"
    Title="MHRM:Asset List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <div class="widget-title">
                    Assigned Assets
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlAssetList" runat="server" SkinID="pnlInner">
                    <div style="max-width: 1000px; max-height: 450px; overflow: auto">
                        <asp:GridView ID="grdAssetList" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                            <Columns>
                                <asp:BoundField DataField="DEVICE_TYPE" HeaderText="DEVICE_TYPE" />
                                <asp:BoundField DataField="BRANCH" HeaderText="BRANCH" />
                                <asp:BoundField DataField="MODEL" HeaderText="MODEL" />
                                <asp:BoundField DataField="ASSET_TAG" HeaderText="ASSET_TAG" />
                                <asp:BoundField DataField="HOST_NAME" HeaderText="HOST_NAME" />
                                <asp:BoundField DataField="DESCRIPTION" HeaderText="DESCRIPTION" />
                                <asp:BoundField DataField="STATUS" HeaderText="STATUS" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
