Imports System.Data

Partial Class _AddRecord
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Session("AuthMistUser") = True Then
            Response.Redirect("NotAuth.aspx")
        End If
    End Sub
    Protected Sub AddMfrBtn_Click(sender As Object, e As EventArgs)
        NewMfrDiv.Attributes.Add("style", "display:block")
    End Sub

    Protected Sub CnclNewMfr_Click(sender As Object, e As EventArgs)
        NewMfrTxt.Text = Nothing
        NewMfrDiv.Attributes.Add("style", "display:none")
        MfrLbl.Visible = False
    End Sub

    Protected Sub AddNewMfr_Click(sender As Object, e As EventArgs)
        Dim NewMfr As String = NewMfrTxt.Text
        If Not String.IsNullOrEmpty(NewMfr) Then
            Dim MfrBll As New ManufacturerBLL
            If MfrBll.FindManufacturer(NewMfr).Rows.Count > 0 Then
                'manufacturer already exists
                MfrLbl.Text = "Manufacturer already exists!"
                MfrLbl.Visible = True
            Else
                'add it to the manufacturer table
                MfrBll.AddManufacturer(NewMfr)
                ManufacturerDL.DataBind()
                MfrLbl.Text = "Manufacturer added successfully. Select it from the drop-down list"
                MfrLbl.Visible = True
            End If
        End If
    End Sub

    Protected Sub AddVendorBtn_Click(sender As Object, e As EventArgs)
        NewVendorDiv.Attributes.Add("style", "display:block")
    End Sub

    Protected Sub CnclNewVendor_Click(sender As Object, e As EventArgs)
        NewVendorTxt.Text = Nothing
        NewVendorDiv.Attributes.Add("style", "display:none")
        VendorLbl.Visible = False
    End Sub

    Protected Sub AddNewVendor_Click(sender As Object, e As EventArgs)
        Dim NewVendor As String = NewVendorTxt.Text
        If Not String.IsNullOrEmpty(NewVendor) Then
            Dim VendorBLL As New VendorBLL
            If VendorBLL.FindVendor(NewVendor).Rows.Count > 0 Then
                'vendor already exists
                VendorLbl.Text = "Vendor already exists!"
                VendorLbl.Visible = True
            Else
                'add it to the vendor table
                VendorBLL.AddVendor(NewVendor)
                VendorDL.DataBind()
                VendorLbl.Text = "Vendor added successfully. Select it from the drop-down list"
                VendorLbl.Visible = True
            End If
        End If
    End Sub

    Private Function ContentIsValid() As String
        Dim ValErrors As String = Nothing
        If MaintTypeDL.SelectedIndex = 0 Then ValErrors += "<br />Please select a maintenance type"
        If ManufacturerDL.SelectedIndex = 0 And VendorDL.SelectedIndex = 0 Then ValErrors += "<br />Please select a manufacturer and/or vendor"
        If ProdDescTxt.Text.Trim.Length = 0 Then ValErrors += "<br />Please provide a description"
        'If QtyTxt.Text.Trim.Length = 0 Or QtyTxt.Text = "0" Then ValErrors += "<br />Quantity must be greater than zero"
        If ExtPriceTxt.Text.Trim.Length = 0 Or ExtPriceTxt.Text = "$ _,___,___.__" Then ValErrors += "<br />Please provide a valid extended price"
        'If DateTime.TryParse(PurchDtTxt.Text, Nothing) = False Then ValErrors += "<br />Please provide a purchase date"
        If Not (ExpDtTxt.Text = "__/__/____" Or ExpDtTxt.Text = "") And Not (PurchDtTxt.Text = "__/__/____" Or PurchDtTxt.Text = "") Then
            Dim Result As Integer = Date.Compare(CDate(PurchDtTxt.Text), CDate(ExpDtTxt.Text))
            If Result > 0 Then ValErrors += "<br />Expiration date must be greater than the purchase date"
        End If
        Return ValErrors
    End Function

    Function CleanExtPrice(strIn As String) As String
        ' Replace invalid characters with empty strings. 
        Try
            strIn = Replace(strIn, "_", "")
            Return Regex.Replace(strIn, "[^\w\.@-]", "")
        Catch e As System.TimeoutException
            Return String.Empty
        End Try
    End Function

    Sub ClearFields()
        MaintTypeDL.SelectedIndex = -1
        ManufacturerDL.SelectedIndex = -1
        VendorDL.SelectedIndex = -1
        ProdDescTxt.Text = ""
        QtyTxt.Text = ""
        ExtPriceTxt.Text = ""
        DispMonthlyCB.Checked = False
        PurchDtTxt.Text = ""
        ExpDtTxt.Text = ""
        CommentTxt.Text = ""
    End Sub

    Protected Sub SaveMaintBtn_Click(sender As Object, e As EventArgs)
        Dim valErrs As String = ContentIsValid()
        If String.IsNullOrEmpty(valErrs) Then
            Dim BLL As New MaintBLL
            Dim ExtPrice As String = CleanExtPrice(ExtPriceTxt.Text)
            If BLL.AddMaintRec(MaintTypeDL.SelectedValue, ManufacturerDL.SelectedValue, VendorDL.SelectedValue, ProdDescTxt.Text, QtyTxt.Text, CDec(ExtPrice), _
                            DispMonthlyCB.Checked, PurchDtTxt.Text, ExpDtTxt.Text, CommentTxt.Text) Then

                ClearFields()
                SaveRsltLbl.Text = "Maintenance record saved succesfully"
                SaveRsltLbl.Visible = True
            Else
                SaveRsltLbl.Text = "Failed to save maintenance record.  Please try again."
                SaveRsltLbl.Visible = True
            End If
        Else
            SaveRsltLbl.Text = "VALIDATION ERRORS:<br/>" & valErrs
            SaveRsltLbl.Visible = True
        End If
    End Sub

    Protected Sub ManufacturerDL_SelectedIndexChanged(sender As Object, e As EventArgs)
        NewMfrTxt.Text = Nothing
        MfrLbl.Visible = False
        NewMfrDiv.Attributes.Add("style", "display:none")
    End Sub

    Protected Sub VendorDL_SelectedIndexChanged(sender As Object, e As EventArgs)
        NewVendorTxt.Text = Nothing
        VendorLbl.Visible = False
        NewVendorDiv.Attributes.Add("style", "display:none")
    End Sub
End Class
