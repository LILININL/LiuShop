unit HOSxPLiulinSupplierListFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinsDefaultPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Menus, DBClient, StdCtrls, cxButtons, cxContainer, cxLabel,
  cxTextEdit, cxGroupBox, ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel,
  JvExControls, JvNavigationPane;

type
  THOSxPLiulinSupplierListForm = class(TForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataSource1: TDataSource;
    SupplierCDS: TClientDataSet;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxTextEdit1: TcxTextEdit;
    cxLabel1: TcxLabel;
    Panel2: TPanel;
    cxButton666: TcxButton;
    cxButton7: TcxButton;
    cxButton8: TcxButton;
    JvNavPanelHeader1: TJvNavPanelHeader;
    cxButton1: TcxButton;
    cxButton6: TcxButton;
    cxButton4: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxTextEdit1PropertiesChange(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton666Click(Sender: TObject);
    procedure cxGrid1DBTableView1Column1GetDisplayText
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGrid1DBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    procedure DoRefreshData;
    procedure DoAddSupplier;
    procedure DoEditSupplier;
    procedure DoSearchSupplier(const AFilter: string);
  public
    { Public declarations }
  end;

var
  HOSxPLiulinSupplierListForm: THOSxPLiulinSupplierListForm;

implementation

uses BMSApplicationUtil, HOSxPDMU, HOSxPLiulinSupplierEntryFormUnit;

{$R *.dfm}

procedure THOSxPLiulinSupplierListForm.cxButton1Click(Sender: TObject);
begin
  DoEditSupplier;
end;

procedure THOSxPLiulinSupplierListForm.cxButton2Click(Sender: TObject);
begin
  DoAddSupplier;
end;

procedure THOSxPLiulinSupplierListForm.cxButton3Click(Sender: TObject);
begin
  // ���� Excel
  if SupplierCDS.RecordCount = 0 then
    Exit;
  DoExportCxGridToExcel(cxGrid1);
end;

procedure THOSxPLiulinSupplierListForm.cxButton4Click(Sender: TObject);
begin
  // ���� Log
  SafeLoadPackage('HOSxPUserManagerPackage.bpl');
  ExecuteRTTIFunction
    ('HOSxPUserManagerLogViewerFormUnit.THOSxPUserManagerLogViewerForm',
    'DoShowForm', ['liulin_supplier', '']);
end;

procedure THOSxPLiulinSupplierListForm.cxButton5Click(Sender: TObject);
begin
  // ��������
  DoSearchSupplier(cxTextEdit1.Text);
end;

procedure THOSxPLiulinSupplierListForm.cxButton666Click(Sender: TObject);
begin
  Close;
end;

procedure THOSxPLiulinSupplierListForm.cxGrid1DBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
cxButton8.Click;
end;

procedure THOSxPLiulinSupplierListForm.cxGrid1DBTableView1Column1GetDisplayText
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := IntToStr(ARecord.Index + 1);
end;

procedure THOSxPLiulinSupplierListForm.cxTextEdit1PropertiesChange
  (Sender: TObject);
begin
  // ��ͧ����
  DoSearchSupplier(cxTextEdit1.Text);
end;

procedure THOSxPLiulinSupplierListForm.DoRefreshData;
begin
  SupplierCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_supplier_id, liulin_supplier_name, liulin_supplier_contact FROM liulin_supplier;');
end;

procedure THOSxPLiulinSupplierListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure THOSxPLiulinSupplierListForm.FormCreate(Sender: TObject);
begin
  DoRefreshData;
end;

procedure THOSxPLiulinSupplierListForm.DoAddSupplier;
begin
  THOSxPLiulinSupplierEntryForm.DoShowForm(SupplierCDS, 0, True);
  DoRefreshData;
end;

procedure THOSxPLiulinSupplierListForm.DoEditSupplier;
begin
  if SupplierCDS.RecordCount = 0 then
    Exit;
  THOSxPLiulinSupplierEntryForm.DoShowForm(SupplierCDS,
    SupplierCDS.FieldByName('liulin_supplier_id').AsInteger, False);
  DoRefreshData;
end;

procedure THOSxPLiulinSupplierListForm.DoSearchSupplier(const AFilter: string);
begin
  if Trim(AFilter) = '' then
  begin
    DoRefreshData;
  end
  else
  begin
    SupplierCDS.Data := HOSxP_GetDataSet
      ('SELECT liulin_supplier_id, liulin_supplier_name, liulin_supplier_contact FROM liulin_supplier '
      + 'WHERE liulin_supplier_name LIKE ''%' + AFilter + '%''');
  end;
end;

end.
