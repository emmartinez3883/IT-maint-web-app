<%@ Page Title="" Language="VB" MasterPageFile="~/MIST.master" AutoEventWireup="false" CodeFile="AddRecord.aspx.vb" Inherits="_AddRecord" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="PageTitle" runat="server">
    MIST | Add Record
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="margin: 2%" cellpadding="5px">
        <tr style="margin-bottom: 10px">
            <td>Maintenance Type:
            </td>
            <td>
                <asp:DropDownList ID="MaintTypeDL" runat="server" DataSourceID="MaintTypeDS" DataTextField="MaintType" DataValueField="MaintTypeID" Width="100px" AppendDataBoundItems="true">
                    <asp:ListItem Text="Select Type" Value="" />
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>Manufacturer:
            </td>
            <td>
                <asp:UpdatePanel ID="ManufPnl" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="ManufacturerDL" runat="server" DataSourceID="ManufacturerDS" DataTextField="ManufacturerName" DataValueField="ManufacturerID" Width="250px"
                            OnSelectedIndexChanged="ManufacturerDL_SelectedIndexChanged" AutoPostBack="true">
                        </asp:DropDownList>&nbsp;&nbsp;&nbsp;<asp:Button ID="AddMfrBtn" runat="server" Text="Add New" OnClick="AddMfrBtn_Click" />
                        <div id="NewMfrDiv" runat="server" style="display: none">
                            <br />
                            <asp:TextBox ID="NewMfrTxt" runat="server" Width="250px"></asp:TextBox>&nbsp;&nbsp;<asp:Button ID="AddNewMfr" runat="server" Text="Add" OnClick="AddNewMfr_Click" />
                            &nbsp;&nbsp;<asp:Button ID="CnclNewMfr" runat="server" Text="Cancel" OnClick="CnclNewMfr_Click" /><br />
                            <asp:Label ID="MfrLbl" runat="server" Visible="false" ForeColor="Red" />
                            <br />
                            <asp:TextBoxWatermarkExtender ID="NewMfrWaterMark" runat="server" TargetControlID="NewMfrTxt" WatermarkText="Type manufacturer name here" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>Vendor:
            </td>
            <td>
                <asp:UpdatePanel ID="VendorPnl" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="VendorDL" runat="server" DataSourceID="VendorDS" DataTextField="VendorName" DataValueField="VendorID" Width="250px"
                            OnSelectedIndexChanged="VendorDL_SelectedIndexChanged" AutoPostBack="true">
                        </asp:DropDownList>&nbsp;&nbsp;&nbsp;<asp:Button ID="AddVendorBtn" runat="server" Text="Add New" OnClick="AddVendorBtn_Click" />
                        <div id="NewVendorDiv" runat="server" style="display: none">
                            <br />
                            <asp:TextBox ID="NewVendorTxt" runat="server" Width="250px"></asp:TextBox>&nbsp;&nbsp;<asp:Button ID="AddNewVendor" runat="server" Text="Add" OnClick="AddNewVendor_Click" />
                            &nbsp;&nbsp;<asp:Button ID="CnclNewVendor" runat="server" Text="Cancel" OnClick="CnclNewVendor_Click" /><br />
                            <asp:Label ID="VendorLbl" runat="server" Visible="false" ForeColor="Red" />
                            <br />
                            <asp:TextBoxWatermarkExtender ID="NewVendorWaterMark" runat="server" TargetControlID="NewVendorTxt" WatermarkText="Type vendor name here" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>Product Description:
            </td>
            <td>
                <asp:TextBox ID="ProdDescTxt" runat="server" Width="500px" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Quantity:
            </td>
            <td>
                <asp:TextBox ID="QtyTxt" runat="server" Width="100px"></asp:TextBox>
                <asp:FilteredTextBoxExtender ID="QtyTxtFilter" runat="server" FilterType="Numbers" TargetControlID="QtyTxt" />
            </td>
        </tr>
        <tr>
            <td>Extended Price:
            </td>
            <td>
                <asp:TextBox ID="ExtPriceTxt" runat="server" Width="100px"></asp:TextBox>
                <asp:MaskedEditExtender ID="ExtPriceMask" runat="server" TargetControlID="ExtPriceTxt" Mask="9,999,999.99" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                    MaskType="Number" InputDirection="RightToLeft" AcceptNegative="None" DisplayMoney="Left" ErrorTooltipEnabled="True" />
            </td>
        </tr>
        <tr>
            <td>Disperse Monthly?:
            </td>
            <td>
                <asp:CheckBox ID="DispMonthlyCB" runat="server" Checked="false" />
            </td>
        </tr>
        <tr>
            <td>Purchase Date:
            </td>
            <td>
                <asp:TextBox ID="PurchDtTxt" runat="server" Width="100px"></asp:TextBox>
                <asp:MaskedEditExtender ID="PurchDtMask" runat="server" TargetControlID="PurchDtTxt" Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                    MaskType="Date" InputDirection="RightToLeft" AcceptNegative="None" ErrorTooltipEnabled="True" />
                <asp:ImageButton ID="PurchDtCalBtn" runat="server" ImageUrl="~/Images/Calendar.png" />
                <asp:CalendarExtender ID="PurchDtCalExt" runat="server" PopupButtonID="PurchDtCalBtn" TargetControlID="PurchDtTxt" Format="MM/dd/yyyy"></asp:CalendarExtender>
            </td>
        </tr>
        <tr>
            <td>Expiration Date:
            </td>
            <td>
                <asp:TextBox ID="ExpDtTxt" runat="server" Width="100px"></asp:TextBox>
                <asp:MaskedEditExtender ID="ExpDtMask" runat="server" TargetControlID="ExpDtTxt" Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                    MaskType="Date" InputDirection="RightToLeft" AcceptNegative="None" ErrorTooltipEnabled="True" />
                <asp:ImageButton ID="ExpDtCalBtn" runat="server" ImageUrl="~/Images/Calendar.png" />
                <asp:CalendarExtender ID="ExpDtCalExt" runat="server" PopupButtonID="ExpDtCalBtn" TargetControlID="ExpDtTxt" Format="MM/dd/yyyy"></asp:CalendarExtender>
            </td>
        </tr>
        <tr>
            <td>Comments:
            </td>
            <td>
                <asp:TextBox ID="CommentTxt" runat="server" Width="500px" Height="80px" TextMode="MultiLine" />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="right">
                <br />
                <asp:Button ID="SaveMaintBtn" runat="server" Text="Save Record" OnClick="SaveMaintBtn_Click" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label ID="SaveRsltLbl" runat="server" Visible="false" ForeColor="Red"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="MaintTypeDS" runat="server" ConnectionString="<%$ ConnectionStrings:MistConn %>"
        SelectCommand="Select MaintTypeID, MaintType from MaintTypes"></asp:SqlDataSource>
    <asp:SqlDataSource ID="ManufacturerDS" runat="server" ConnectionString="<%$ ConnectionStrings:MistConn %>"
        SelectCommand="Select 0 as ManufacturerId, '--Select Manufacturer--' as ManufacturerName, 1 as [sort] Union Select ManufacturerID, ManufacturerName, 2 as [sort] from Manufacturers order by [sort], ManufacturerName asc"></asp:SqlDataSource>
    <asp:SqlDataSource ID="VendorDS" runat="server" ConnectionString="<%$ ConnectionStrings:MistConn %>"
        SelectCommand="Select 0 as VendorId, '--Select Vendor--' as VendorName, 1 as [sort] Union Select VendorID, VendorName, 2 as [sort] from Vendors order by [sort], VendorName asc"></asp:SqlDataSource>
</asp:Content>

