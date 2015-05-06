Imports Microsoft.VisualBasic
Imports ManufacturerDSTableAdapters

Public Class ManufacturerBLL

    Private MfgAdapter As ManufacturersTableAdapter = Nothing
    Private ReadOnly Property Adapter() As ManufacturersTableAdapter
        Get
            If MfgAdapter Is Nothing Then
                MfgAdapter = New ManufacturersTableAdapter()
            End If
            Return MfgAdapter
        End Get
    End Property

    'get all manufacturers
    <System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, True)>
    Public Function GetManufacturers() As ManufacturerDS.ManufacturersDataTable
        Return Adapter.GetData()
    End Function

    'get manufacturer by name
    <System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, True)>
    Public Function FindManufacturer(ByVal MfrName As String) As ManufacturerDS.ManufacturersDataTable
        Return Adapter.GetByMfrName(MfrName)
    End Function

    'add manufacturer
    <System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, True)>
    Public Function AddManufacturer(ByVal MfrName As String) As Boolean
        Dim rowsAffected As Integer = Adapter.InsertMfr(MfrName)
        Return rowsAffected = 1
    End Function
End Class
