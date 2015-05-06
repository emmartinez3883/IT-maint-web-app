<%@ Page Title="" Language="VB" MasterPageFile="~/MIST.master" AutoEventWireup="false"
    CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="PageTitle" runat="server">
    MIST | Home
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        /*Modal Popup*/
        .modalBkgrd
        {
            background-color: Gray;
            filter: alpha(opacity=70);
            opacity: 0.7;
        }
        
        .modalPopup
        {
            background-color: Gray;
            border-width: 3px;
            border-style: solid;
            border-color: Gray;
            padding: 3px;
        }
    </style>
    <script type="text/javascript">
        function okClick() {
            $find('<%= mdlEdit.ClientID%>').hide();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="MaintUpdPnl" runat="server">
        <ContentTemplate>
            <br />
            <div style="text-align: left; font-weight: bold">
                <asp:Label runat="server">Software Total:&nbsp;</asp:Label><asp:Label ID="SoftTotalLbl"
                    runat="server" Style="color: Yellow"></asp:Label>
                <br />
                <br />
                <asp:Label runat="server">Equipment Total:&nbsp;</asp:Label><asp:Label ID="EquipTotalLbl"
                    runat="server" Style="color: Yellow"></asp:Label>
            </div>
            <br />
            <br />
            <div>
                <h3>
                    SOFTWARE MAINTENANCE</h3>
            </div>
            <div id="SoftMaints">
                <asp:RadioButtonList ID="SftViewRB" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="SftViewRB_SelectedIndexChanged"
                    AutoPostBack="true">
                    <asp:ListItem Selected="True" Value="0">Summary</asp:ListItem>
                    <asp:ListItem Value="1">Extended</asp:ListItem>
                </asp:RadioButtonList>
                <%--                <asp:UpdatePanel ID="SoftUpdPnl" runat="server">
                    <ContentTemplate>--%>
                <asp:GridView ID="SoftGV" runat="server" AutoGenerateColumns="False" DataKeyNames="MaintID"
                    DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" OnRowCommand="SoftGV_RowCommand"
                    OnDataBound="SoftGV_DataBound" OnRowDataBound="HighlightGV_RowDataBound" AllowSorting="true"
                    EmptyDataText="No software maintenance items to display" EmptyDataRowStyle-ForeColor="White">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <RowStyle HorizontalAlign="Center" />
                    <Columns>
                        <asp:BoundField DataField="MaintID" HeaderText="Maint ID" InsertVisible="False" ReadOnly="True"
                            SortExpression="MaintID" HeaderStyle-Width="50px"></asp:BoundField>
                        <asp:BoundField DataField="ManufacturerName" HeaderText="Manufacturer" SortExpression="ManufacturerName" />
                        <asp:BoundField DataField="VendorName" HeaderText="Vendor" SortExpression="VendorName" />
                        <asp:BoundField DataField="ProductDesc" HeaderText="Description" SortExpression="ProductDesc"
                            HeaderStyle-Width="500px"></asp:BoundField>
                        <asp:BoundField DataField="Quantity" HeaderText="Qty" SortExpression="Quantity" />
                        <asp:BoundField DataField="ExtendedPrice" HeaderText="Ext. Price" SortExpression="ExtendedPrice"
                            HtmlEncode="false" DataFormatString="{0:c}" />
                        <asp:BoundField DataField="DisperseMonthly" HeaderText="Disperse Monthly?" SortExpression="DisperseMonthly"
                            HeaderStyle-Width="50px" ReadOnly="True"></asp:BoundField>
                        <asp:BoundField DataField="LastPurchDate" HeaderText="Last Purchased" SortExpression="LastPurchDate"
                            HeaderStyle-Width="75px" DataFormatString="{0:d}"></asp:BoundField>
                        <asp:BoundField DataField="ExpirationDate" HeaderText="Expires" SortExpression="ExpirationDate"
                            DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="EditBtn" runat="server" Text="Edit" CommandArgument='<%#Eval("MaintID")%>'
                                                CommandName="Modify"></asp:Button>
                                        </td>
                                        <td>
                                            <asp:Button ID="DelBtn" runat="server" Text="Delete" CommandArgument='<%#Eval("MaintID")%>'
                                                CommandName="Remove" />
                                            <asp:ConfirmButtonExtender ID="DelBtnConf" runat="server" TargetControlID="DelBtn"
                                                ConfirmText="WARNING: You are about to permanently delete this maintenance item. Continue?"
                                                ConfirmOnFormSubmit="false" />
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5F8EC2" ForeColor="White" Font-Bold="True" />
                    <HeaderStyle BackColor="#5F8EC2" Font-Bold="True" ForeColor="Black" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
                <br />
                <asp:Button ID="ExportSoftGV" runat="server" Text="Export Data" OnClick="ExportSoftGV_Click" />
                <br />
                <asp:GridView ID="SoftExtGV" runat="server" DataSourceID="SqlDataSource3" AutoGenerateColumns="False"
                    DataKeyNames="MaintID" ForeColor="#333333" Visible="False" OnRowDataBound="HighlightGV_RowDataBound"
                    AllowSorting="true" EmptyDataText="No software maintenance items to display"
                    EmptyDataRowStyle-ForeColor="White">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <RowStyle HorizontalAlign="Center" />
                    <Columns>
                        <asp:BoundField DataField="MaintID" HeaderText="Maint ID" ReadOnly="True" SortExpression="MaintID"
                            HeaderStyle-Width="50px" />
                        <asp:BoundField DataField="ManufacturerName" HeaderText="Manufacturer" SortExpression="ManufacturerName" />
                        <asp:BoundField DataField="VendorName" HeaderText="Vendor" SortExpression="VendorName" />
                        <asp:BoundField DataField="ProductDesc" HeaderText="Description" SortExpression="ProductDesc" />
                        <asp:BoundField DataField="Quantity" HeaderText="Qty" SortExpression="Quantity" />
                        <asp:BoundField DataField="ExtendedPrice" HeaderText="Ext. Price" SortExpression="ExtendedPrice"
                            HtmlEncode="false" DataFormatString="{0:c}" />
                        <asp:BoundField DataField="DisperseMonthly" HeaderText="Disperse Monthly?" ReadOnly="True"
                            SortExpression="DisperseMonthly" HeaderStyle-Width="50px" />
                        <asp:BoundField DataField="Jan" HeaderText="Jan" ReadOnly="True" SortExpression="Jan" />
                        <asp:BoundField DataField="Feb" HeaderText="Feb" ReadOnly="True" SortExpression="Feb" />
                        <asp:BoundField DataField="Mar" HeaderText="Mar" ReadOnly="True" SortExpression="Mar" />
                        <asp:BoundField DataField="Apr" HeaderText="Apr" ReadOnly="True" SortExpression="Apr" />
                        <asp:BoundField DataField="May" HeaderText="May" ReadOnly="True" SortExpression="May" />
                        <asp:BoundField DataField="Jun" HeaderText="Jun" ReadOnly="True" SortExpression="Jun" />
                        <asp:BoundField DataField="Jul" HeaderText="Jul" ReadOnly="True" SortExpression="Jul" />
                        <asp:BoundField DataField="Aug" HeaderText="Aug" ReadOnly="True" SortExpression="Aug" />
                        <asp:BoundField DataField="Sep" HeaderText="Sep" ReadOnly="True" SortExpression="Sep" />
                        <asp:BoundField DataField="Oct" HeaderText="Oct" ReadOnly="True" SortExpression="Oct" />
                        <asp:BoundField DataField="Nov" HeaderText="Nov" ReadOnly="True" SortExpression="Nov" />
                        <asp:BoundField DataField="Dec" HeaderText="Dec" ReadOnly="True" SortExpression="Dec" />
                        <asp:BoundField DataField="LastPurchDate" HeaderText="Last Purchased" SortExpression="LastPurchDate"
                            DataFormatString="{0:d}" />
                        <asp:BoundField DataField="ExpirationDate" HeaderText="Expires" SortExpression="ExpirationDate"
                            DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5F8EC2" ForeColor="White" Font-Bold="True" />
                    <HeaderStyle BackColor="#5F8EC2" Font-Bold="True" ForeColor="Black" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </div>
            <br />
            <asp:Button ID="ExportSoftExtGV" runat="server" Text="Export Data" OnClick="ExportSoftExtGV_Click"
                Visible="false" />
            <br />
            <br />
            <div>
                <h3>
                    EQUIPMENT MAINTENANCE</h3>
            </div>
            <div id="EquipMaints">
                <asp:RadioButtonList ID="EquipViewRB" runat="server" RepeatDirection="Horizontal"
                    OnSelectedIndexChanged="EquipViewRB_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Selected="True" Value="0">Summary</asp:ListItem>
                    <asp:ListItem Value="1">Extended</asp:ListItem>
                </asp:RadioButtonList>
                <asp:GridView ID="EquipGV" runat="server" AutoGenerateColumns="False" DataKeyNames="MaintID"
                    DataSourceID="SqlDataSource2" CellPadding="4" ForeColor="#333333" OnRowCommand="EquipGV_RowCommand"
                    OnDataBound="EquipGV_DataBound" OnRowDataBound="HighlightGV_RowDataBound" AllowSorting="true"
                    EmptyDataText="No equipment maintenance items to display" EmptyDataRowStyle-ForeColor="White">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <RowStyle HorizontalAlign="Center" />
                    <Columns>
                        <asp:BoundField DataField="MaintID" HeaderText="Maint ID" InsertVisible="False" ReadOnly="True"
                            SortExpression="MaintID" HeaderStyle-Width="50px"></asp:BoundField>
                        <asp:BoundField DataField="ManufacturerName" HeaderText="Manufacturer" SortExpression="ManufacturerName" />
                        <asp:BoundField DataField="VendorName" HeaderText="Vendor" SortExpression="VendorName" />
                        <asp:BoundField DataField="ProductDesc" HeaderText="Description" SortExpression="ProductDesc"
                            HeaderStyle-Width="500px"></asp:BoundField>
                        <asp:BoundField DataField="Quantity" HeaderText="Qty" SortExpression="Quantity" />
                        <asp:BoundField DataField="ExtendedPrice" HeaderText="Ext. Price" SortExpression="ExtendedPrice"
                            HtmlEncode="false" DataFormatString="{0:c}" />
                        <asp:BoundField DataField="DisperseMonthly" HeaderText="Disperse Monthly?" SortExpression="DisperseMonthly"
                            HeaderStyle-Width="50px" ReadOnly="True"></asp:BoundField>
                        <asp:BoundField DataField="LastPurchDate" HeaderText="Last Purchased" SortExpression="LastPurchDate"
                            HeaderStyle-Width="75px" DataFormatString="{0:d}"></asp:BoundField>
                        <asp:BoundField DataField="ExpirationDate" HeaderText="Expires" SortExpression="ExpirationDate"
                            DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="EditBtn" runat="server" Text="Edit" CommandArgument='<%#Eval("MaintID")%>'
                                                CommandName="Modify"></asp:Button>
                                        </td>
                                        <td>
                                            <asp:Button ID="DelBtn" runat="server" Text="Delete" CommandArgument='<%#Eval("MaintID")%>'
                                                CommandName="Remove" />
                                            <asp:ConfirmButtonExtender ID="DelBtnConf" runat="server" TargetControlID="DelBtn"
                                                ConfirmText="WARNING: You are about to permanently delete this maintenance item. Continue?"
                                                ConfirmOnFormSubmit="false" />
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5F8EC2" ForeColor="White" Font-Bold="True" />
                    <HeaderStyle BackColor="#5F8EC2" Font-Bold="True" ForeColor="Black" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
                <br />
                <asp:Button ID="ExportEquipGV" runat="server" Text="Export Data" OnClick="ExportEquipGV_Click" />
                <br />
                <asp:GridView ID="EquipExtGV" runat="server" DataSourceID="SqlDataSource4" AutoGenerateColumns="False"
                    DataKeyNames="MaintID" ForeColor="#333333" Visible="False" OnRowDataBound="HighlightGV_RowDataBound"
                    AllowSorting="true" EmptyDataText="No equipment maintenance items to display"
                    EmptyDataRowStyle-ForeColor="White">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <RowStyle HorizontalAlign="Center" />
                    <Columns>
                        <asp:BoundField DataField="MaintID" HeaderText="Maint ID" ReadOnly="True" SortExpression="MaintID"
                            HeaderStyle-Width="50px" />
                        <asp:BoundField DataField="ManufacturerName" HeaderText="Manufacturer" SortExpression="ManufacturerName" />
                        <asp:BoundField DataField="VendorName" HeaderText="Vendor" SortExpression="VendorName" />
                        <asp:BoundField DataField="ProductDesc" HeaderText="Description" SortExpression="ProductDesc" />
                        <asp:BoundField DataField="Quantity" HeaderText="Qty" SortExpression="Quantity" />
                        <asp:BoundField DataField="ExtendedPrice" HeaderText="Ext. Price" SortExpression="ExtendedPrice"
                            HtmlEncode="false" DataFormatString="{0:c}" />
                        <asp:BoundField DataField="DisperseMonthly" HeaderText="Disperse Monthly?" ReadOnly="True"
                            SortExpression="DisperseMonthly" HeaderStyle-Width="50px" />
                        <asp:BoundField DataField="Jan" HeaderText="Jan" ReadOnly="True" SortExpression="Jan" />
                        <asp:BoundField DataField="Feb" HeaderText="Feb" ReadOnly="True" SortExpression="Feb" />
                        <asp:BoundField DataField="Mar" HeaderText="Mar" ReadOnly="True" SortExpression="Mar" />
                        <asp:BoundField DataField="Apr" HeaderText="Apr" ReadOnly="True" SortExpression="Apr" />
                        <asp:BoundField DataField="May" HeaderText="May" ReadOnly="True" SortExpression="May" />
                        <asp:BoundField DataField="Jun" HeaderText="Jun" ReadOnly="True" SortExpression="Jun" />
                        <asp:BoundField DataField="Jul" HeaderText="Jul" ReadOnly="True" SortExpression="Jul" />
                        <asp:BoundField DataField="Aug" HeaderText="Aug" ReadOnly="True" SortExpression="Aug" />
                        <asp:BoundField DataField="Sep" HeaderText="Sep" ReadOnly="True" SortExpression="Sep" />
                        <asp:BoundField DataField="Oct" HeaderText="Oct" ReadOnly="True" SortExpression="Oct" />
                        <asp:BoundField DataField="Nov" HeaderText="Nov" ReadOnly="True" SortExpression="Nov" />
                        <asp:BoundField DataField="Dec" HeaderText="Dec" ReadOnly="True" SortExpression="Dec" />
                        <asp:BoundField DataField="LastPurchDate" HeaderText="Last Purchased" SortExpression="LastPurchDate"
                            DataFormatString="{0:d}" />
                        <asp:BoundField DataField="ExpirationDate" HeaderText="Expires" SortExpression="ExpirationDate"
                            DataFormatString="{0:d}" />
                        <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5F8EC2" ForeColor="White" Font-Bold="True" />
                    <HeaderStyle BackColor="#5F8EC2" Font-Bold="True" ForeColor="Black" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
                <br />
                <asp:Button ID="ExportEquipExtGV" runat="server" Text="Export Data" OnClick="ExportEquipExtGV_Click"
                    Visible="false" />
            </div>
            <asp:HiddenField ID="hidForMdl" runat="server" />
            <asp:ModalPopupExtender ID="mdlEdit" runat="server" TargetControlID="hidForMdl" PopupControlID="EditRecMP"
                BackgroundCssClass="modalBkgrd" />
            <asp:Panel ID="EditRecMP" runat="server" CssClass="modalPopup" Style="display: none;">
                <iframe id="EditIframe" runat="server" src="" width="700" height="700" scrolling="auto">
                </iframe>
                <br />
                <br />
                <div style="text-align: center">
                    <asp:Button ID="BtnOK" runat="server" Text="Done" OnClick="BtnOK_Click" />
                </div>
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="SftViewRB" EventName="SelectedIndexChanged" />
            <asp:AsyncPostBackTrigger ControlID="EquipViewRB" EventName="SelectedIndexChanged" />
            <asp:PostBackTrigger ControlID="ExportSoftGV" />
            <asp:PostBackTrigger ControlID="ExportSoftExtGV" />
            <asp:PostBackTrigger ControlID="ExportEquipGV" />
            <asp:PostBackTrigger ControlID="ExportEquipExtGV" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MistConn %>"
        SelectCommand="SELECT mm.MaintID, mf.ManufacturerName, v.VendorName, mm.ProductDesc, mm.Quantity, mm.ExtendedPrice, CASE WHEN DisperseMonthly = 1 THEN 'Yes' ELSE 'No' END AS DisperseMonthly, mm.LastPurchDate, mm.ExpirationDate, mm.Comments FROM MaintMaster AS mm LEFT OUTER JOIN Manufacturers AS mf ON mm.ManufacturerID = mf.ManufacturerID LEFT OUTER JOIN Vendors AS v ON mm.VendorID = v.VendorID WHERE (mm.MaintType = 2)">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MistConn %>"
        SelectCommand="select MaintID, mf.ManufacturerName, v.VendorName, 
        ProductDesc, Quantity, ExtendedPrice, case when DisperseMonthly = 1 then 'Yes' else 'No' end as DisperseMonthly, LastPurchDate, ExpirationDate, Comments
from MaintMaster mm left join Manufacturers mf on mm.ManufacturerID = mf.ManufacturerID left join Vendors v on mm.VendorID = v.VendorID where MaintType = 1">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MistConn %>"
        SelectCommand="SELECT * FROM [SoftMaints]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:MistConn %>"
        SelectCommand="SELECT * FROM [EquipMaints]"></asp:SqlDataSource>
</asp:Content>

