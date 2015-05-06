
Partial Class Reporting
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Session("AuthMistUser") = True Then
            Response.Redirect("NotAuth.aspx")
        End If
    End Sub

    Protected Sub runRptBtn_Click(sender As Object, e As EventArgs)
        dtErrLbl.Text = Nothing
        If String.IsNullOrEmpty(BeginDtTxt.Text) Or String.IsNullOrEmpty(EndDtTxt.Text) Then
            dtErrLbl.Text = "Please select a begin and end date"
        Else
            If (BeginDtTxt.Text = "__/__/____" Or BeginDtTxt.Text = "") Or (EndDtTxt.Text = "__/__/____" Or EndDtTxt.Text = "") Then
                dtErrLbl.Text = "Please provide a valid begin and end date"
            Else
                Dim Result As Integer = Date.Compare(CDate(BeginDtTxt.Text), CDate(EndDtTxt.Text))
                If Result > 0 Then
                    dtErrLbl.Text = "Begin date cannot be greater than end date"
                Else
                    Dim qryStr As String = "DispReport.aspx/?beginDate=" & BeginDtTxt.Text & "&endDate=" & EndDtTxt.Text
                    prevRptFrame.Attributes.Add("Src", qryStr)
                End If
            End If
        End If
    End Sub
End Class
