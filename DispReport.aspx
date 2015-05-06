<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DispReport.aspx.vb" Inherits="DispReport" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" 
        ReportSourceID="CrystalReportSource1"  runat="server" AutoDataBind="true" 
	        EnableParameterPrompt="False"
	        ReuseParameterValuesOnRefresh="True" 
	        EnableDatabaseLogonPrompt="False"
	        HasCrystalLogo="False"
 BestFitPage="true" BorderStyle="Groove" PageZoomFactor="100" ToolPanelView="None" 
        ToolPanelWidth="0px" HasToggleGroupTreeButton="False" 
        HasToggleParameterPanelButton="False" Height="1000px" Width="1000px" 
        DisplayStatusbar="False" PrintMode="ActiveX" />
    <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
    </CR:CrystalReportSource>
    </div>
    </form>
</body>
</html>
