object HOSxPLiulinCustomerListForm: THOSxPLiulinCustomerListForm
  Left = 0
  Top = 0
  Caption = 'HOSxPLiulinCustomerListForm'
  ClientHeight = 293
  ClientWidth = 649
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxButton1: TcxButton
    Left = 566
    Top = 8
    Width = 75
    Height = 33
    Caption = #3611#3636#3604
    TabOrder = 0
    OnClick = cxButton1Click
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 8
    Width = 418
    Height = 259
    TabOrder = 1
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = DataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'liulin_customer_id'
        SortIndex = 0
        SortOrder = soAscending
      end
      object cxGrid1DBTableView1Column2: TcxGridDBColumn
        Caption = #3594#3639#3656#3629
        DataBinding.FieldName = 'liulin_customer_name'
      end
      object cxGrid1DBTableView1Column3: TcxGridDBColumn
        Caption = #3648#3610#3629#3619#3660
        DataBinding.FieldName = 'customer_tel'
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object AddBottom: TcxButton
    Left = 432
    Top = 209
    Width = 75
    Height = 25
    Caption = #3648#3614#3636#3656#3617
    TabOrder = 2
  end
  object Deletebottom: TcxButton
    Left = 432
    Top = 240
    Width = 75
    Height = 25
    Caption = #3621#3610
    TabOrder = 3
    OnClick = cxButton1Click
  end
  object CustomerCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 312
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = CustomerCDS
    Left = 360
    Top = 8
  end
end
