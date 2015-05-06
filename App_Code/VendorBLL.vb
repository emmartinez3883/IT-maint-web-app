Imports Microsoft.VisualBasic
Imports VendorDSTableAdapters

Public Class VendorBLL
    Private VendorAdapter As VendorsTableAdapter = Nothing

    ReadOnly Property Adapter() As VendorsTableAdapter
        Get
            If VendorAdapter Is Nothing Then
                VendorAdapter = New VendorsTableAdapter()
            End If
            Return VendorAdapter
        End Get
    End Property

    'get all vendors
    <System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, True)>
    Public Function GetVendors() As VendorDS.VendorsDataTable
        Return Adapter.GetData()
    End Function

    'get vendors by name
    <System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, True)>
    Public Function FindVendor(ByVal VendorName As String) As VendorDS.VendorsDataTable
        Return Adapter.GetByVendorName(VendorName)
    End Function

    'add vendor
    <System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, True)>
    Public Function AddVendor(ByVal VendorName As String) As Boolean
        Dim RowsAffected As Integer = Adapter.InsertVendor(VendorName)
        Return RowsAffected = 1
    End Function

End Class
