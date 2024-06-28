object HOSxPLiulinEmployeeListForm: THOSxPLiulinEmployeeListForm
  Left = 0
  Top = 0
  Caption = 'HOSxPLiulinEmployeeListForm'
  ClientHeight = 383
  ClientWidth = 483
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 8
    Top = 8
    Width = 345
    Height = 345
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = Datasouce1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      object cxGrid1DBTableView1Column1: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'liulin_employee_id'
        PropertiesClassName = 'TcxBlobEditProperties'
      end
      object cxGrid1DBTableView1Column2: TcxGridDBColumn
        Caption = #3594#3639#3656#3629
        DataBinding.FieldName = 'liulin_employee_name'
      end
      object cxGrid1DBTableView1Column3: TcxGridDBColumn
        Caption = #3648#3610#3629#3619#3660
        DataBinding.FieldName = 'liulin_employee_tel'
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object Datasouce1: TDataSource
    DataSet = EmployeeCDS
    Left = 440
    Top = 24
  end
  object EmployeeCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 368
    Top = 24
  end
end
