Imports System.Web.HttpContext
Imports Util
Imports System.Data
Imports ClosedXML.Excel
Imports System.IO

Partial Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, e As System.EventArgs) Handles Me.Load
        Dim aduser As String = String.Empty
        If Session("OperatorId") Is Nothing Then
            aduser = Current.Request.LogonUserIdentity.Name.Replace("HQ\", "")
            Session("OperatorId") = aduser
        Else
            aduser = Session("OperatorId")
        End If

        If Session("AuthMistUser") Is Nothing Then
            If Not Page.IsPostBack Then
                Try
                    Util.SetSessionGroups(aduser)
                    Dim fullName As String = ""
                    Util.SetUserName(aduser, fullName)
                    Session("UserFullName") = fullName
                Catch ex As Exception
                    'LogIt.LogError(ex.Message, "Default.aspx", "Authenticate User")
                    Response.Redirect("NotAuth.aspx")
                End Try
            End If
        End If

        If Not Session("AuthMistUser") = True Then
            Response.Redirect("NotAuth.aspx")
        End If
    End Sub

    Protected Sub SoftGV_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        Dim MaintBLL As New MaintBLL
        If (e.CommandName = "Modify") Then
            Dim MaintID As Integer = Integer.Parse(e.CommandArgument.ToString())
            EditIframe.Attributes.Add("Src", "EditRecord.aspx?id=" & MaintID)
            mdlEdit.Show()
        ElseIf (e.CommandName = "Remove") Then
            Dim MaintID As Integer = Integer.Parse(e.CommandArgument.ToString())
            If MaintBLL.DeleteMaintRec(MaintID) Then
                'maintenance record was deleted
                SoftGV.DataBind()
            Else
                'failed to delete record
            End If
        End If
    End Sub

    Protected Sub SoftGV_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        Dim row As GridViewRow = Nothing
        Dim runningTotal As Double = 0.0
        For i As Integer = 0 To SoftGV.Rows.Count - 1
            row = SoftGV.Rows(i)
            If row.RowType = DataControlRowType.DataRow Then
                ' Add error handling here
                runningTotal += CType(row.Cells(5).Text, Double)
            End If
        Next i
        SoftTotalLbl.Text = runningTotal.ToString("C")
    End Sub

    Protected Sub HighlightGV_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim drv As DataRowView = TryCast(e.Row.DataItem, DataRowView)
            If drv("DisperseMonthly").ToString().Equals("Yes") Then
                e.Row.BackColor = System.Drawing.Color.PaleGoldenrod
            End If
        End If
    End Sub

    Protected Sub EquipGV_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        Dim MaintBLL As New MaintBLL
        If (e.CommandName = "Modify") Then
            Dim MaintID As Integer = Integer.Parse(e.CommandArgument.ToString())
            EditIframe.Attributes.Add("Src", "EditRecord.aspx?id=" & MaintID)
            mdlEdit.Show()
        ElseIf (e.CommandName = "Remove") Then
            Dim MaintID As Integer = Integer.Parse(e.CommandArgument.ToString())
            If MaintBLL.DeleteMaintRec(MaintID) Then
                'maintenance record was deleted
                EquipGV.DataBind()
            Else
                'failed to delete record
            End If
        End If
    End Sub

    Protected Sub EquipGV_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        Dim row As GridViewRow = Nothing
        Dim runningTotal As Double = 0.0
        For i As Integer = 0 To EquipGV.Rows.Count - 1
            row = EquipGV.Rows(i)
            If row.RowType = DataControlRowType.DataRow Then
                ' Add error handling here
                runningTotal += CType(row.Cells(5).Text, Double)
            End If
        Next i
        EquipTotalLbl.Text = runningTotal.ToString("C")
    End Sub

    Protected Sub BtnOK_Click(sender As Object, e As EventArgs)
        SoftGV.DataBind()
        SoftExtGV.DataBind()
        EquipGV.DataBind()
        EquipExtGV.DataBind()
    End Sub

    Protected Sub SftViewRB_SelectedIndexChanged(sender As Object, e As EventArgs)
        If SftViewRB.SelectedValue = 0 Then
            SoftGV.Visible = True
            ExportSoftGV.Visible = True
            SoftExtGV.Visible = False
            ExportSoftExtGV.Visible = False
        Else
            SoftGV.Visible = False
            ExportSoftGV.Visible = False
            SoftExtGV.Visible = True
            ExportSoftExtGV.Visible = True
        End If
    End Sub

    Protected Sub EquipViewRB_SelectedIndexChanged(sender As Object, e As EventArgs)
        If EquipViewRB.SelectedValue = 0 Then
            EquipGV.Visible = True
            ExportEquipGV.Visible = True
            EquipExtGV.Visible = False
            ExportEquipExtGV.Visible = False
        Else
            EquipGV.Visible = False
            ExportEquipGV.Visible = False
            EquipExtGV.Visible = True
            ExportEquipExtGV.Visible = True
        End If
    End Sub

    Protected Sub ExportSoftGV_Click(sender As Object, e As EventArgs)
        Dim fileName As String = "Software_Maints_"
        ExportToExcel(fileName, Me.SoftGV)
    End Sub

    Protected Sub ExportSoftExtGV_Click(sender As Object, e As EventArgs)
        Dim fileName As String = "Software_Maints_Ext_"
        ExportToExcel(fileName, Me.SoftExtGV)
    End Sub

    Protected Sub ExportEquipGV_Click(sender As Object, e As EventArgs)
        Dim fileName As String = "Equip_Maints_"
        ExportToExcel(fileName, Me.EquipGV)
    End Sub

    Protected Sub ExportEquipExtGV_Click(sender As Object, e As EventArgs)
        Dim fileName As String = "Equip_Maints_Ext_"
        ExportToExcel(fileName, Me.EquipExtGV)
    End Sub

    Protected Sub ExportToExcel(ByVal fileName As String, ByVal gv As GridView)
        If gv.Rows.Count > 0 Then
            Dim dt As New DataTable("GridView_Data")
            fileName = fileName & DateTime.Now.ToString("yyyyMMdd") & "_" & DateTime.Now.ToString("HHmmss") & ".xlsx"
            For i As Integer = 0 To gv.HeaderRow.Cells.Count - 1
                dt.Columns.Add(gv.Columns(i).HeaderText)
            Next

            For Each row As GridViewRow In gv.Rows
                dt.Rows.Add()
                For i As Integer = 0 To row.Cells.Count - 1
                    dt.Rows(dt.Rows.Count - 1)(i) = row.Cells(i).Text.Replace("&nbsp;", "")
                Next
            Next
            Using wb As New XLWorkbook()
                wb.Worksheets.Add(dt)

                Response.Clear()
                Response.Buffer = True
                Response.Charset = ""
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                Response.AddHeader("content-disposition", "attachment;filename=" & fileName)
                Using MyMemoryStream As New MemoryStream()
                    wb.SaveAs(MyMemoryStream)
                    MyMemoryStream.WriteTo(Response.OutputStream)
                    Response.Flush()
                    Response.[End]()
                End Using
            End Using
        End If
    End Sub

End Class
