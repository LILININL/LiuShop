unit HOSxPLiulinOrderDetailListFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxControls, cxContainer, cxEdit, ComCtrls,
  dxCore, cxDateUtils, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, dxDateRanges, dxScrollbarAnnotations, DB, cxDBData, DBClient,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxTextEdit, cxLabel, cxGroupBox, ExtCtrls, StdCtrls, cxButtons, JvExControls,
  JvNavigationPane, HOSxPOrderDetailEntryFormUnit;

type
  THOSxPLiulinOrderDetailListForm = class(TForm)
    JvNavPanelHeader1: TJvNavPanelHeader;
    cxButton5: TcxButton;
    cxButton6: TcxButton;
    Panel1: TPanel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxButton3: TcxButton;
    cxGroupBox1: TcxGroupBox;
    cxButton4: TcxButton;
    cxLabel1: TcxLabel;
    cxTextEdit1: TcxTextEdit;
    cxDateEdit1: TcxDateEdit;
    cxLabel2: TcxLabel;
    cxDateEdit2: TcxDateEdit;
    cxLabel3: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    cxGrid1DBTableView1Column6: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    OrderDetailCDS: TClientDataSet;
    orderdetailDS: TDataSource;
    cxGrid1DBTableView1Column7: TcxGridDBColumn;
    cxGrid1DBTableView1Column8: TcxGridDBColumn;
    ProductCDS: TClientDataSet;
    DataSourcePro: TDataSource;
    EmployeeCDS: TClientDataSet;
    CustomerCDS: TClientDataSet;
    DataSourceOrder: TDataSource;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    OrderCDS: TClientDataSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DoRefreshData;
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
    procedure cxButton6Click(Sender: TObject);

    procedure cxButton1Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxGrid1DBTableView1Column1GetDisplayText
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGrid1DBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    procedure DoSearchData;
  public
    { Public declarations }
  end;

var
  HOSxPLiulinOrderDetailListForm: THOSxPLiulinOrderDetailListForm;

implementation

uses BMSApplicationUtil, HOSxPDMU;

{$R *.dfm}

procedure THOSxPLiulinOrderDetailListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure THOSxPLiulinOrderDetailListForm.FormCreate(Sender: TObject);
begin
  // ���ҧ�����Ŵ�������١���
  CustomerCDS := TClientDataSet.Create(nil);
  try
    CustomerCDS.Data := HOSxP_GetDataSet
      ('SELECT liulin_customer_id, liulin_customer_name FROM liulin_customer');
  except
    on E: Exception do
      ShowMessage('Error loading Customer data: ' + E.Message);
  end;
  DataSource1.DataSet := CustomerCDS;
  CustomerCDS.Open;

  // ���ҧ�����Ŵ�����ž�ѡ�ҹ
  EmployeeCDS := TClientDataSet.Create(nil);
  try
    EmployeeCDS.Data := HOSxP_GetDataSet
      ('SELECT liulin_employee_id, liulin_employee_name FROM liulin_employee');
  except
    on E: Exception do
      ShowMessage('Error loading Employee data: ' + E.Message);
  end;
  DataSource2.DataSet := EmployeeCDS;
  EmployeeCDS.Open;

  // ���ҧ�����Ŵ�������Թ���
  ProductCDS := TClientDataSet.Create(nil);
  try
    ProductCDS.Data := HOSxP_GetDataSet
      ('SELECT liulin_product_id, liulin_product_name FROM liulin_product');
  except
    on E: Exception do
      ShowMessage('Error loading Product data: ' + E.Message);
  end;
  DataSourcePro.DataSet := ProductCDS;
  ProductCDS.Open;

  DoRefreshData;
end;

procedure THOSxPLiulinOrderDetailListForm.DoRefreshData;
begin
  OrderDetailCDS.Close;
  OrderDetailCDS.Data := HOSxP_GetDataSet('SELECT od.liulin_orderdetail_id, ' +
    'od.liulin_quantity, ' + 'od.liulin_total_price, ' +
    'p.liulin_product_name, ' + 'p.liulin_product_id, ' +
    'o.liulin_order_date, ' + 'o.liulin_order_id, ' +
    // ������ô֧ liulin_order_id
    'e.liulin_employee_name, ' + 'e.liulin_employee_id, ' +
    'c.liulin_customer_name, ' + 'c.liulin_customer_id ' +
    'FROM liulin_orderdetail od ' +
    'JOIN liulin_order o ON od.liulin_order_id = o.liulin_order_id ' +
    'JOIN liulin_employee e ON o.liulin_employee_id = e.liulin_employee_id ' +
    'JOIN liulin_customer c ON o.liulin_customer_id = c.liulin_customer_id ' +
    'JOIN liulin_product p ON od.liulin_product_id = p.liulin_product_id');
  orderdetailDS.DataSet := OrderDetailCDS;
  OrderDetailCDS.Open;
end;

procedure THOSxPLiulinOrderDetailListForm.cxButton1Click(Sender: TObject);
begin
  Close;
end;

procedure THOSxPLiulinOrderDetailListForm.cxButton4Click(Sender: TObject);
begin
  DoSearchData;
end;

procedure THOSxPLiulinOrderDetailListForm.cxButton5Click(Sender: TObject);
begin
  SafeLoadPackage('HOSxPUserManagerPackage.bpl');
  ExecuteRTTIFunction
    ('HOSxPUserManagerLogViewerFormUnit.THOSxPUserManagerLogViewerForm',
    'DoShowForm', ['liulin_order_detail', '']);
  DoRefreshData;
end;

procedure THOSxPLiulinOrderDetailListForm.cxButton6Click(Sender: TObject);
begin
  if OrderDetailCDS.RecordCount = 0 then
    Exit;
  DoExportCxGridToExcel(cxGrid1);
  DoRefreshData;
end;

procedure THOSxPLiulinOrderDetailListForm.cxGrid1DBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
cxButton3.Click;
end;

procedure THOSxPLiulinOrderDetailListForm.
  cxGrid1DBTableView1Column1GetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
  AText := IntToStr(ARecord.Index + 1);
end;

procedure THOSxPLiulinOrderDetailListForm.cxButton2Click(Sender: TObject);
begin
  ExecuteRTTIFunction
    ('HOSxPOrderDetailEntryFormUnit.THOSxPOrderDetailEntryForm', 'DoShowForm',
    [OrderDetailCDS, 0, True]);
  DoRefreshData;
end;

procedure THOSxPLiulinOrderDetailListForm.cxButton3Click(Sender: TObject);
begin
  if OrderDetailCDS.RecordCount = 0 then
    Exit;
  ExecuteRTTIFunction
    ('HOSxPOrderDetailEntryFormUnit.THOSxPOrderDetailEntryForm', 'DoShowForm',
    [OrderDetailCDS, OrderDetailCDS.FieldByName('liulin_orderdetail_id')
    .AsInteger, False]);
  DoRefreshData;
end;

procedure THOSxPLiulinOrderDetailListForm.DoSearchData;
var
  SQL: string;
  NameFilter, DateFrom, DateTo: string;
begin
  SQL := 'SELECT ' + '  od.liulin_orderdetail_id, ' + '  od.liulin_quantity, ' +
    '  od.liulin_total_price, ' + '  p.liulin_product_name, ' +
    '  o.liulin_order_date, ' + '  o.liulin_order_id, ' +
  // ������ô֧ liulin_order_id
    '  e.liulin_employee_name, ' + '  e.liulin_employee_id, ' +
    '  c.liulin_customer_name, ' + '  c.liulin_customer_id, ' +
    '  p.liulin_product_id ' + 'FROM ' + '  liulin_orderdetail od ' + 'JOIN ' +
    '  liulin_order o ON od.liulin_order_id = o.liulin_order_id ' + 'JOIN ' +
    '  liulin_employee e ON o.liulin_employee_id = e.liulin_employee_id ' +
    'JOIN ' + '  liulin_customer c ON o.liulin_customer_id = c.liulin_customer_id '
    + 'JOIN ' +
    '  liulin_product p ON od.liulin_product_id = p.liulin_product_id ' +
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

  OrderDetailCDS.Close;
  OrderDetailCDS.Data := HOSxP_GetDataSet(SQL);
  OrderDetailCDS.Open;
  orderdetailDS.DataSet := OrderDetailCDS;
  // ����� DataSource �Ѻ ClientDataSet
end;

end.
