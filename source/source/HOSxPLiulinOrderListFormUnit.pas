unit HOSxPLiulinOrderListFormUnit;

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
  dxScrollbarAnnotations, DB, cxDBData, Menus, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, DBClient, StdCtrls, cxButtons,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxContainer, cxLabel,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel,
  cxGroupBox, cxCalendar, ComCtrls, dxCore, cxDateUtils, JvExControls,
  JvNavigationPane;

type
  THOSxPLiulinOrderListForm = class(TForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataSource1: TDataSource;
    OrderCDS: TClientDataSet;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxTextEdit1: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxDateEdit1: TcxDateEdit;
    cxDateEdit2: TcxDateEdit;
    Panel2: TPanel;
    cxButton66: TcxButton;
    cxButton7: TcxButton;
    cxButton8: TcxButton;
    JvNavPanelHeader1: TJvNavPanelHeader;
    cxButton1: TcxButton;
    cxButton6: TcxButton;
    cxButton4: TcxButton;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    cxGrid1DBTableView1Column6: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxTextEdit1PropertiesChange(Sender: TObject);
    procedure cxDateEdit1PropertiesChange(Sender: TObject);
    procedure cxDateEdit2PropertiesChange(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton66Click(Sender: TObject);
    procedure cxGrid1DBTableView1Column1GetDisplayText
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGrid1DBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    procedure DoRefreshData;
    procedure DoSearchData;
  public
    { Public declarations }
  end;

var
  HOSxPLiulinOrderListForm: THOSxPLiulinOrderListForm;

implementation

uses BMSApplicationUtil, HOSxPDMU, HOSxPLiuLinOrderEntryFormUnit;

{$R *.dfm}

procedure THOSxPLiulinOrderListForm.DoRefreshData;
begin
  OrderCDS.Data := HOSxP_GetDataSet('SELECT ' + '  o.liulin_order_id, ' +
    '  o.liulin_order_date, ' + '  o.liulin_order_number, ' +
    '  o.liulin_order_lastupdate, ' + '  e.liulin_employee_name, ' +
    '  c.liulin_customer_name, ' + '  e.liulin_employee_id, ' +
    '  c.liulin_customer_id, ' + '  lod.liulin_product_id, ' +
    '  lp.liulin_product_name, ' + '  lod.liulin_quantity ' + 'FROM ' +
    '  liulin_order o ' + 'JOIN ' +
    '  liulin_employee e ON o.liulin_employee_id = e.liulin_employee_id ' +
    'JOIN ' + '  liulin_customer c ON o.liulin_customer_id = c.liulin_customer_id '
    + 'LEFT JOIN ' +

    '  liulin_orderdetail lod ON o.liulin_order_id = lod.liulin_order_id ' +
    'LEFT JOIN ' +
    '  liulin_product lp ON lod.liulin_product_id = lp.liulin_product_id;');
end;

procedure THOSxPLiulinOrderListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure THOSxPLiulinOrderListForm.FormCreate(Sender: TObject);
begin
  DoRefreshData;
end;

procedure THOSxPLiulinOrderListForm.cxButton1Click(Sender: TObject);
begin
  ExecuteRTTIFunction
    ('HOSxPLiuLinOrderEntryFormUnit.THOSxPLiuLinOrderEntryForm', 'DoShowForm',
    [OrderCDS, 0, True]);
  DoRefreshData;
end;

procedure THOSxPLiulinOrderListForm.cxButton2Click(Sender: TObject);
begin
  if OrderCDS.RecordCount = 0 then
    Exit;
  ExecuteRTTIFunction
    ('HOSxPLiuLinOrderEntryFormUnit.THOSxPLiuLinOrderEntryForm', 'DoShowForm',
    [OrderCDS, OrderCDS.FieldByName('liulin_order_id').AsInteger, False]);
  DoRefreshData;
end;

procedure THOSxPLiulinOrderListForm.cxButton3Click(Sender: TObject);
begin
  // export to Excel
  if OrderCDS.RecordCount = 0 then
    Exit;
  DoExportCxGridToExcel(cxGrid1);
end;

procedure THOSxPLiulinOrderListForm.cxButton4Click(Sender: TObject);
begin
  // view log
  SafeLoadPackage('HOSxPUserManagerPackage.bpl');
  ExecuteRTTIFunction
    ('HOSxPUserManagerLogViewerFormUnit.THOSxPUserManagerLogViewerForm',
    'DoShowForm', ['liulin_order', '']);
end;

procedure THOSxPLiulinOrderListForm.cxButton5Click(Sender: TObject);
begin
  DoSearchData;
end;

procedure THOSxPLiulinOrderListForm.cxButton66Click(Sender: TObject);
begin
  close;
end;

procedure THOSxPLiulinOrderListForm.cxTextEdit1PropertiesChange
  (Sender: TObject);
begin
  DoSearchData;
end;

procedure THOSxPLiulinOrderListForm.cxDateEdit1PropertiesChange
  (Sender: TObject);
begin
  DoSearchData;
end;

procedure THOSxPLiulinOrderListForm.cxDateEdit2PropertiesChange
  (Sender: TObject);
begin
  DoSearchData;
end;

procedure THOSxPLiulinOrderListForm.cxGrid1DBTableView1CellDblClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  cxButton8.Click;
end;

procedure THOSxPLiulinOrderListForm.cxGrid1DBTableView1Column1GetDisplayText
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := IntToStr(ARecord.Index + 1);
end;

procedure THOSxPLiulinOrderListForm.DoSearchData;
var
  SQL: string;
  NameFilter, DateFrom, DateTo: string;
begin
  SQL := 'SELECT ' + '  o.liulin_order_id, ' + '  o.liulin_order_number, ' +
    '  o.liulin_order_date, ' + '  o.liulin_order_lastupdate, ' +
    '  e.liulin_employee_name, ' + '  c.liulin_customer_name, ' +
    '  e.liulin_employee_id, ' + '  c.liulin_customer_id, ' +
    '  lod.liulin_product_id, ' + '  lp.liulin_product_name, ' +
    '  lod.liulin_quantity ' + 'FROM ' + '  liulin_order o ' + 'JOIN ' +
    '  liulin_employee e ON o.liulin_employee_id = e.liulin_employee_id ' +
    'JOIN ' + '  liulin_customer c ON o.liulin_customer_id = c.liulin_customer_id '
    + 'LEFT JOIN ' +
    '  liulin_orderdetail lod ON o.liulin_order_id = lod.liulin_order_id ' +
    'LEFT JOIN ' +
    '  liulin_product lp ON lod.liulin_product_id = lp.liulin_product_id ' +
    'WHERE 1=1 ';

  NameFilter := Trim(cxTextEdit1.Text);
  if NameFilter <> '' then
    SQL := SQL + ' AND (e.liulin_employee_name LIKE ''%' + NameFilter +
      '%'' OR ' + 'c.liulin_customer_name LIKE ''%' + NameFilter + '%'')';

  if not VarIsNull(cxDateEdit1.EditValue) then
  begin
    DateFrom := FormatDateTime('yyyy-mm-dd', cxDateEdit1.Date);
    SQL := SQL + ' AND o.liulin_order_date >= ''' + DateFrom + '''';
  end;

  if not VarIsNull(cxDateEdit2.EditValue) then
  begin
    DateTo := FormatDateTime('yyyy-mm-dd', cxDateEdit2.Date);
    SQL := SQL + ' AND o.liulin_order_date <= ''' + DateTo + '''';
  end;

  OrderCDS.Data := HOSxP_GetDataSet(SQL);
end;

end.
