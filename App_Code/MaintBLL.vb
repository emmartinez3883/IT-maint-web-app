Imports Microsoft.VisualBasic
Imports MaintDSTableAdapters

Public Class MaintBLL
    Private MaintAdapter As MaintMasterTableAdapter = Nothing
    Private ReadOnly Property Adapter() As MaintMasterTableAdapter
        Get
            If MaintAdapter Is Nothing Then
                MaintAdapter = New MaintMasterTableAdapter()
            End If
            Return MaintAdapter
        End Get
    End Property

    'get all maintenance records
    <System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, True)>
    Public Function GetMaintRecs() As MaintDS.MaintMasterDataTable
        Return Adapter.GetData()
    End Function

    'get hardware maintenance records
    <System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, True)>
    Public Function GetHardMaints() As MaintDS.MaintMasterDataTable
        Return Adapter.GetHardwareMaints()
    End Function

    'get sofware maintenance records
    <System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, True)>
    Public Function GetSoftMaints() As MaintDS.MaintMasterDataTable
        Return Adapter.GetSoftwareMaints()
    End Function


    'get maintenance record by MaintID
    <System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, True)>
    Public Function FindMaintRec(ByVal MaintID As Integer) As MaintDS.MaintMasterDataTable
        Return Adapter.GetByMaintID(MaintID)
    End Function

    'get maintenance records by ManufacturerID
    <System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, True)>
    Public Function FindMaintRecByMfr(ByVal ManufacturerID As Integer) As MaintDS.MaintMasterDataTable
        Return Adapter.GetByMfrID(ManufacturerID)
    End Function

    'get maintenance records by VendorID
    <System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, True)>
    Public Function FindMaintRecByVendor(ByVal VendorID As Integer) As MaintDS.MaintMasterDataTable
        Return Adapter.GetByVendorID(VendorID)
    End Function

    'Insert new maintenance record
    <System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, True)>
    Public Function AddMaintRec(ByVal MaintType As Integer, ByVal ManufacturerID As String, ByVal VendorID As String, _
                                ByVal ProductDesc As String, ByVal Quantity As String, ByVal ExtendedPrice As Decimal, ByVal DisperseMonthly As Boolean, _
                                ByVal LastPurchDate As String, ByVal ExpirationDate As String, ByVal Comments As String) As Boolean
        Dim NewMaintRec As New MaintDS.MaintMasterDataTable()
        Dim MaintRow As MaintDS.MaintMasterRow = NewMaintRec.NewMaintMasterRow()
        MaintRow.MaintType = MaintType
        If String.IsNullOrEmpty(ManufacturerID) Or ManufacturerID = "0" Then MaintRow.SetManufacturerIDNull() Else MaintRow.ManufacturerID = CInt(ManufacturerID)
        If String.IsNullOrEmpty(VendorID) Or VendorID = "0" Then MaintRow.SetVendorIDNull() Else MaintRow.VendorID = CInt(VendorID)
        MaintRow.ProductDesc = ProductDesc
        If String.IsNullOrEmpty(Quantity) Or Quantity = "0" Then MaintRow.SetQuantityNull() Else MaintRow.Quantity = CInt(Quantity)
        MaintRow.ExtendedPrice = ExtendedPrice
        MaintRow.DisperseMonthly = DisperseMonthly
        If String.IsNullOrEmpty(LastPurchDate) Or LastPurchDate = "__/__/____" Then MaintRow.SetLastPurchDateNull() Else MaintRow.LastPurchDate = CDate(LastPurchDate)
        If String.IsNullOrEmpty(ExpirationDate) Or ExpirationDate = "__/__/____" Then MaintRow.SetExpirationDateNull() Else MaintRow.ExpirationDate = CDate(ExpirationDate)
        MaintRow.Comments = Comments
        NewMaintRec.AddMaintMasterRow(MaintRow)
        Dim RowsAffected As Integer = Adapter.Update(MaintRow)
        Return RowsAffected = 1
    End Function

    'Update maintenance record
    <System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, True)>
    Public Function UpdateMaintRec(ByVal MaintID As Integer, ByVal MaintType As Integer, ByVal ManufacturerID As String, ByVal VendorID As String, _
                                ByVal ProductDesc As String, ByVal Quantity As String, ByVal ExtendedPrice As Decimal, ByVal DisperseMonthly As Boolean, _
                                ByVal LastPurchDate As String, ByVal ExpirationDate As String, ByVal Comments As String) As Boolean
        Dim ChgMaintRec As MaintDS.MaintMasterDataTable = Adapter.GetByMaintID(MaintID)
        If ChgMaintRec.Count = 0 Then
            Return False
            'return false if no matching record is found
        End If
        Dim MaintRow As MaintDS.MaintMasterRow = ChgMaintRec(0)
        MaintRow.MaintType = MaintType
        If String.IsNullOrEmpty(ManufacturerID) Or ManufacturerID = "0" Then MaintRow.SetManufacturerIDNull() Else MaintRow.ManufacturerID = CInt(ManufacturerID)
        If String.IsNullOrEmpty(VendorID) Or VendorID = "0" Then MaintRow.SetVendorIDNull() Else MaintRow.VendorID = CInt(VendorID)
        MaintRow.ProductDesc = ProductDesc
        If String.IsNullOrEmpty(Quantity) Or Quantity = "0" Then MaintRow.SetQuantityNull() Else MaintRow.Quantity = CInt(Quantity)
        MaintRow.ExtendedPrice = ExtendedPrice
        MaintRow.DisperseMonthly = DisperseMonthly
        If String.IsNullOrEmpty(LastPurchDate) Or LastPurchDate = "__/__/____" Then MaintRow.SetLastPurchDateNull() Else MaintRow.LastPurchDate = CDate(LastPurchDate)
        If String.IsNullOrEmpty(ExpirationDate) Or ExpirationDate = "__/__/____" Then MaintRow.SetExpirationDateNull() Else MaintRow.ExpirationDate = CDate(ExpirationDate)
        MaintRow.Comments = Comments
        Dim RowsAffected As Integer = Adapter.Update(MaintRow)
        Return RowsAffected = 1
    End Function

    'Delete maintenance record
    <System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Delete, True)>
    Public Function DeleteMaintRec(ByVal MaintID As Integer) As Boolean
        Dim rowsAffected As Integer = Adapter.DeleteByMaintID(MaintID)
        Return rowsAffected = 1
    End Function


End Class
