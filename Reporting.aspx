<%@ Page Title="" Language="VB" MasterPageFile="~/MIST.master" AutoEventWireup="false" CodeFile="Reporting.aspx.vb" Inherits="Reporting" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="PageTitle" runat="server">
    MIST | Reporting
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
        <table cellpadding="5px">
        <tr>
        <td colspan="6" style="font-weight:bold">
        MAINTENANCE ITEMS BY EXPIRATION DATE
        </td>
        </tr>
        <tr style="margin-bottom: 10px">
            <td>From:
            </td>
            <td>
                <asp:TextBox ID="BeginDtTxt" runat="server" Width="100px"></asp:TextBox>
                <asp:MaskedEditExtender ID="PurchDtMask" runat="server" TargetControlID="BeginDtTxt" Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                    MaskType="Date" InputDirection="RightToLeft" AcceptNegative="None" ErrorTooltipEnabled="True" />
                <asp:ImageButton ID="BeginDtCalBtn" runat="server" ImageUrl="~/Images/Calendar.png" />
                <asp:CalendarExtender ID="BeginDtCalExt" runat="server" PopupButtonID="BeginDtCalBtn" TargetControlID="BeginDtTxt" Format="MM/dd/yyyy"></asp:CalendarExtender>
            </td>
            <td>
                <br />
            </td>
            <td>To:
            </td>
            <td>
                <asp:TextBox ID="EndDtTxt" runat="server" Width="100px"></asp:TextBox>
                <asp:MaskedEditExtender ID="EndDtMask" runat="server" TargetControlID="EndDtTxt" Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                    MaskType="Date" InputDirection="RightToLeft" AcceptNegative="None" ErrorTooltipEnabled="True" />
                <asp:ImageButton ID="EndDtCalBtn" runat="server" ImageUrl="~/Images/Calendar.png" />
                <asp:CalendarExtender ID="EndDtCalExt" runat="server" PopupButtonID="EndDtCalBtn" TargetControlID="EndDtTxt" Format="MM/dd/yyyy"></asp:CalendarExtender>
            </td>
            <td>
                <asp:Button ID="runRptBtn" runat="server" Text="Run Report" OnClick="runRptBtn_Click"/>
            </td>
        </tr>
    </table>
                    <asp:UpdatePanel ID="DtLblPnl" runat="server">
                    <ContentTemplate>
    <asp:Label ID="dtErrLbl" runat="server" ForeColor="Red"></asp:Label>
    </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <div  style="margin-left:5px">
    <asp:UpdatePanel ID="prevRptPnl" runat="server">
    <ContentTemplate>
    <iframe id="prevRptFrame" runat="server" src="RptPreview.htm" width="1200" height="600">
    </iframe>
    </ContentTemplate>
    <Triggers>
      <asp:AsyncPostBackTrigger ControlID="runRptBtn" EventName="Click" />
    </Triggers>
    </asp:UpdatePanel>
    </div>
</asp:Content>

