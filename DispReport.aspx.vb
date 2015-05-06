Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

Partial Class DispReport
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Dim icnetreport As ReportDocument
        icnetreport = New ReportDocument

        Dim icnetconnectioninfoMS As ConnectionInfo = New ConnectionInfo()
        icnetconnectioninfoMS.UserID = "mist_user"
        icnetconnectioninfoMS.Password = "mist!"

        icnetreport.Load(System.Configuration.ConfigurationManager.AppSettings("Exp_Date_Report"))

        Dim CR_beginDate As New ParameterDiscreteValue
        Dim CR_endDate As New ParameterDiscreteValue


        icnetlogon(icnetconnectioninfoMS, icnetreport)

        CrystalReportViewer1.ReportSource = icnetreport

        Dim CRParamCurrentValues As New ParameterValues
        Dim CRParameterFieldDefinitions As ParameterFieldDefinitions

        CRParameterFieldDefinitions = icnetreport.DataDefinition.ParameterFields

        Dim CRParameterFieldDefinition_beginDate As ParameterFieldDefinition
        CRParameterFieldDefinition_beginDate = CRParameterFieldDefinitions.Item("begin_date")
        CRParamCurrentValues = CRParameterFieldDefinition_beginDate.CurrentValues
        CR_beginDate.Value = Request.QueryString("beginDate").ToString
        CRParamCurrentValues.Add(CR_beginDate)
        CRParameterFieldDefinition_beginDate.ApplyCurrentValues(CRParamCurrentValues)
        '-----------------------------------------------------------------------------------------'
        Dim CRParameterFieldDefinition_endDate As ParameterFieldDefinition
        CRParameterFieldDefinition_endDate = CRParameterFieldDefinitions.Item("end_date")
        CRParamCurrentValues = CRParameterFieldDefinition_endDate.CurrentValues
        CR_endDate.Value = Request.QueryString("endDate").ToString
        CRParamCurrentValues.Add(CR_endDate)
        CRParameterFieldDefinition_endDate.ApplyCurrentValues(CRParamCurrentValues)

        CrystalReportViewer1.ReportSource = icnetreport
    End Sub

    Private Sub icnetlogon(ByVal icnetConnectionInfoMS As ConnectionInfo, ByVal icnetReportDocument As ReportDocument)
        Dim icnetTables As Tables = icnetReportDocument.Database.Tables
        For Each icnetTable As CrystalDecisions.CrystalReports.Engine.Table In icnetTables
            Dim icnetTableLogonInfo As TableLogOnInfo = icnetTable.LogOnInfo
            icnetTableLogonInfo.ConnectionInfo = icnetConnectionInfoMS
            icnetTable.ApplyLogOnInfo(icnetTableLogonInfo)
        Next
    End Sub
End Class
