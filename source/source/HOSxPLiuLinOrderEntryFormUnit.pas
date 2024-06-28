unit HOSxPLiuLinOrderEntryFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinsDefaultPainters, Menus,
  DB, DBClient, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, StdCtrls, cxButtons, cxLabel, cxTextEdit, ComCtrls,
  dxCore, cxDateUtils, cxCalendar, JvExControls, JvNavigationPane, cxGroupBox,
  ExtCtrls, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, cxCurrencyEdit,
  cxSpinEdit, cxDBEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxCheckBox, ppCtrls,
  ppPrnabl, ppClass, ppBands, ppCache, ppDesignLayer, ppParameter, ppDB,
  ppDBPipe, ppComm, ppRelatv, ppProd, ppReport;

type
  THOSxPLiuLinOrderEntryForm = class(TForm)
    cxLabel2: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLookupComboBox1: TcxLookupComboBox;
    DataSourceCus: TDataSource;
    DataSourceEmp: TDataSource;
    CustomerCDS: TClientDataSet;
    EmployeeCDS: TClientDataSet;
    Panel1: TPanel;
    cxButton4: TcxButton;
    cxButton5: TcxButton;
    cxButton6: TcxButton;
    cxGroupBox2: TcxGroupBox;
    JvNavPanelHeader1: TJvNavPanelHeader;
    cxButton7: TcxButton;
    cxLookupComboBox2: TcxLookupComboBox;
    cxGroupBox1: TcxGroupBox;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    cxGrid1DBTableView1Column6: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxDBTextEdit1: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    OrderDetailCDS: TClientDataSet;
    OrderCDS: TClientDataSet;
    DataSourceOrdertail: TDataSource;
    DataSourceOrder: TDataSource;
    DataSourceProduct: TDataSource;
    DataSourceType: TDataSource;
    ProductCDS: TClientDataSet;
    TypeCDS: TClientDataSet;
    printCDS: TClientDataSet;
    printDS: TDataSource;
    ppReport1: TppReport;
    ppDBPipeline1: TppDBPipeline;
    cxCheckBox1: TcxCheckBox;
    cxDBDateEdit1: TcxDBDateEdit;
    PDListgridCDS: TClientDataSet;
    DataSourcePDListgrid: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton7Click(Sender: TObject);
    procedure cxGrid1DBTableView1Column1GetDisplayText
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxCheckBox1Click(Sender: TObject);
    procedure cxGrid1Enter(Sender: TObject);
    procedure cxGrid1DBTableView1Column3PropertiesEditValueChanged
      (Sender: TObject);
    procedure cxGrid1DBTableView1Column5PropertiesEditValueChanged
      (Sender: TObject);

    procedure OrderdetailCDSBeforePost(DataSet: TDataSet);
    procedure OrderCDSBeforePost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure cxDBTextEdit1PropertiesChange(Sender: TObject);
    procedure cxGrid1DBTableView1InitEdit(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
  private
    FOrderCDS: TClientDataSet;
    FOrderID: Integer;
    procedure DoSaveData;
    procedure DoDeleteData;
    procedure DoRefreshData;

    procedure SetOrderID(const Value: Integer);
  public
    procedure DoPrintData;
    class procedure DoShowForm(OrderCDS: TClientDataSet; OrderID: Integer;
      IsNew: Boolean);
    property OrderID: Integer read FOrderID write SetOrderID;
    function sumprice(qty, price: Double): Double;
  end;

var
  HOSxPLiuLinOrderEntryForm: THOSxPLiuLinOrderEntryForm;

implementation

uses BMSApplicationUtil, HOSxPDMU;

{$R *.dfm}

procedure THOSxPLiuLinOrderEntryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure THOSxPLiuLinOrderEntryForm.FormCreate(Sender: TObject);
begin
  cxDBTextEdit1.DataBinding.DataSource := DataSourceOrder;
  cxDBTextEdit1.DataBinding.DataField := 'liulin_order_number';

  cxDBDateEdit1.DataBinding.DataSource := DataSourceOrder;
  cxDBDateEdit1.DataBinding.DataField := 'liulin_order_date';

  EmployeeCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_employee_id, liulin_employee_name FROM liulin_employee');
  DataSourceEmp.DataSet := EmployeeCDS;
  cxLookupComboBox1.Properties.ListSource := DataSourceEmp;
  cxLookupComboBox1.Properties.ListFieldNames := 'liulin_employee_name';
  cxLookupComboBox1.Properties.KeyFieldNames := 'liulin_employee_id';

  CustomerCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_customer_id, liulin_customer_name FROM liulin_customer');
  DataSourceCus.DataSet := CustomerCDS;
  cxLookupComboBox2.Properties.ListSource := DataSourceCus;
  cxLookupComboBox2.Properties.ListFieldNames := 'liulin_customer_name';
  cxLookupComboBox2.Properties.KeyFieldNames := 'liulin_customer_id';

  TypeCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_type_id, liulin_type_name FROM liulin_type');
  DataSourceType.DataSet := TypeCDS;

  ProductCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_product_id, liulin_product_name, liulin_product_price FROM liulin_product');
  DataSourceProduct.DataSet := ProductCDS;

  OrderCDS.Data := HOSxP_GetDataSet('SELECT * FROM liulin_order');
  DataSourceOrder.DataSet := OrderCDS;

  OrderDetailCDS.Data := HOSxP_GetDataSet('SELECT * FROM liulin_orderdetail');
  DataSourceOrdertail.DataSet := OrderDetailCDS;
  cxGrid1DBTableView1.DataController.DataSource := DataSourceOrdertail;
end;

procedure THOSxPLiuLinOrderEntryForm.FormShow(Sender: TObject);
begin
  OrderCDS.Open;
  OrderDetailCDS.Open;
  EmployeeCDS.Open;
  CustomerCDS.Open;

  if OrderCDS.State in [dsEdit] then
  begin
    cxLookupComboBox1.EditValue := OrderCDS.FieldByName('liulin_employee_id')
      .AsInteger;
    cxLookupComboBox2.EditValue := OrderCDS.FieldByName('liulin_customer_id')
      .AsInteger;
  end;
end;

procedure THOSxPLiuLinOrderEntryForm.cxButton1Click(Sender: TObject);
begin
  Close;
end;

procedure THOSxPLiuLinOrderEntryForm.cxButton2Click(Sender: TObject);
begin
  if MessageDlg('ยืนยันการลบ', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DoDeleteData;
    Close;
  end;
end;

procedure THOSxPLiuLinOrderEntryForm.cxButton3Click(Sender: TObject);
begin
  DoSaveData;
  begin
    DoRefreshData;
  end;
  if cxCheckBox1.Checked then
    DoPrintData;
  Close;
end;

procedure THOSxPLiuLinOrderEntryForm.cxButton7Click(Sender: TObject);
begin
  SafeLoadPackage('HOSxPUserManagerPackage.bpl');
  ExecuteRTTIFunction
    ('HOSxPUserManagerLogViewerFormUnit.THOSxPUserManagerLogViewerForm',
    'DoShowForm', ['liulin_orderdetail', IntToStr(FOrderID)]);
end;

procedure THOSxPLiuLinOrderEntryForm.cxCheckBox1Click(Sender: TObject);
begin
  if cxCheckBox1.Checked then
  begin
    SetUserVariable('LIULIN_ORDERDETAIL_CHECK_PRINT', 'Y');
  end
  else
  begin
    SetUserVariable('LIULIN_ORDERDETAIL_CHECK_PRINT', 'N');
  end;
end;

procedure THOSxPLiuLinOrderEntryForm.cxDBTextEdit1PropertiesChange
  (Sender: TObject);
begin
  cxDBTextEdit1.Text := OrderCDS.FieldByName('liulin_order_number').AsString;
end;

procedure THOSxPLiuLinOrderEntryForm.cxGrid1DBTableView1Column1GetDisplayText
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := IntToStr(ARecord.Index + 1);
end;

procedure THOSxPLiuLinOrderEntryForm.
  cxGrid1DBTableView1Column3PropertiesEditValueChanged(Sender: TObject);
begin
  if cxGrid1DBTableView1Column3.EditValue > 0 then
  begin
    cxGrid1DBTableView1Column4.EditValue :=
      GetSQLData('SELECT pp.liulin_product_price FROM liulin_product pp ' +
      'WHERE pp.liulin_product_id =' +
      VarToStr(cxGrid1DBTableView1Column3.EditValue));
  end;
end;

procedure THOSxPLiuLinOrderEntryForm.
  cxGrid1DBTableView1Column5PropertiesEditValueChanged(Sender: TObject);
begin
  if cxGrid1DBTableView1Column5.EditValue > 0 then
  begin
    if cxGrid1DBTableView1Column4.EditValue < 0 then
    begin
      ShowMessage('กรุณาเลือกสินค้า!');
    end
    else
    begin
      cxGrid1DBTableView1Column6.EditValue :=
        sumprice(cxGrid1DBTableView1Column4.EditValue,
        cxGrid1DBTableView1Column5.EditValue);
    end;
  end;
end;

procedure THOSxPLiuLinOrderEntryForm.cxGrid1DBTableView1InitEdit
  (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit);
var
  lookup: TcxLookupComboBoxProperties;
begin
  if AItem = cxGrid1DBTableView1Column3 then
  begin
    if cxGrid1DBTableView1Column2.EditValue < 0 then
    begin
      ShowMessage('กรุณาเลือกสินค้า!');
      Abort;
    end
    else
    begin
      lookup := TcxLookupComboBox(AEdit).Properties;
      PDListgridCDS.Data := HOSxP_GetDataSet('SELECT * FROM liulin_product pp '
        + 'WHERE pp.liulin_type_id =' +
        VarToStr(cxGrid1DBTableView1Column2.EditValue));
      lookup.ListSource := DataSourcePDListgrid;
    end;

  end;

end;

procedure THOSxPLiuLinOrderEntryForm.cxGrid1Enter(Sender: TObject);
begin
  if OrderDetailCDS.State in [dsBrowse] then
  begin
    OrderDetailCDS.Append;
  end;
end;

procedure THOSxPLiuLinOrderEntryForm.OrderdetailCDSBeforePost
  (DataSet: TDataSet);
var
  MaxID, NewID: Integer;
begin
  if OrderDetailCDS.State in [dsInsert] then
  begin
    // ดึงค่า ID สูงสุดจากฐานข้อมูล
    MaxID := GetSQLData
      ('SELECT MAX(liulin_orderdetail_id) FROM liulin_orderdetail');

    if MaxID = 0 then
      NewID := 1
    else
      NewID := MaxID + 1;

    while GetSQLData
      ('SELECT COUNT(*) FROM liulin_orderdetail WHERE liulin_orderdetail_id = '
      + IntToStr(NewID)) > 0 do
    begin
      Inc(NewID);
    end;

    OrderDetailCDS.FieldByName('liulin_orderdetail_id').AsInteger := NewID;
    OrderDetailCDS.FieldByName('liulin_order_id').AsInteger := FOrderID;
  end;
end;

procedure THOSxPLiuLinOrderEntryForm.OrderCDSBeforePost(DataSet: TDataSet);
begin
  if OrderCDS.State in [dsInsert] then
  begin
    OrderCDS.FieldByName('liulin_order_id').AsInteger := FOrderID;
  end;

  OrderCDS.FieldByName('liulin_order_lastupdate').AsDateTime :=
    GetServerDateTime;
end;

procedure THOSxPLiuLinOrderEntryForm.DoDeleteData;
begin
  if OrderCDS.State in [dsEdit] then
  begin
    OrderCDS.Cancel;
  end;

  while not OrderDetailCDS.Eof do
  begin
    OrderDetailCDS.Delete;
  end;
  if OrderDetailCDS.ChangeCount > 0 then
  begin
    HOSxP_UpdateDelta_log(OrderDetailCDS,
      'SELECT * FROM liulin_orderdetail WHERE liulin_order_id=' +
      IntToStr(FOrderID), 'liulin_orderdetail', IntToStr(FOrderID), '');
    OrderDetailCDS.MergeChangeLog;
  end;

  if OrderCDS.RecordCount > 0 then
  begin
    OrderCDS.Delete;
  end;
  if OrderCDS.ChangeCount > 0 then
  begin
    HOSxP_UpdateDelta_log(OrderCDS, 'SELECT * FROM liulin_order WHERE ' +
      'liulin_order_id=' + IntToStr(FOrderID), 'liulin_order',
      IntToStr(FOrderID), '');
    OrderCDS.MergeChangeLog;
  end;
end;

procedure THOSxPLiuLinOrderEntryForm.DoRefreshData;
var
  NewOrderNumber: Integer;
  FormattedOrderNumber: String;
  MaxID: Integer;
begin
  OrderCDS.Data := HOSxP_GetDataSet
    ('SELECT * FROM liulin_order WHERE liulin_order_id=' + IntToStr(FOrderID));

  OrderDetailCDS.Data := HOSxP_GetDataSet
    ('SELECT * FROM liulin_orderdetail lod ' +
    'LEFT JOIN liulin_product lp on lod.liulin_product_id = lp.liulin_product_id '
    + 'WHERE lod.liulin_order_id =' + IntToStr(FOrderID));

  if OrderCDS.RecordCount = 0 then
  begin
    OrderCDS.Append;
    OrderCDS.FieldByName('liulin_order_date').AsDateTime := GetServerDate;

    // ดึงค่า ID สูงสุดจากฐานข้อมูล
    MaxID := GetSQLData('SELECT MAX(liulin_order_number) FROM liulin_order');
    if MaxID = 0 then
      NewOrderNumber := 1
    else
      NewOrderNumber := MaxID + 1;

    FormattedOrderNumber := Format('%.6d', [NewOrderNumber]);
    OrderCDS.FieldByName('liulin_order_number').AsString :=
      FormattedOrderNumber;
  end
  else
  begin
    OrderCDS.Edit;
  end;

  cxDBTextEdit1.DataBinding.DataSource := DataSourceOrder;
  cxDBTextEdit1.DataBinding.DataField := 'liulin_order_number';
end;

procedure THOSxPLiuLinOrderEntryForm.DoSaveData;
var
  OrderID: Integer;
begin
  if OrderCDS.State in [dsInsert, dsEdit] then
  begin
    // ตรวจสอบค่า cxLookupComboBox1
    if VarIsNull(cxLookupComboBox1.EditValue) or
      (cxLookupComboBox1.EditValue = 0) then
    begin
      ShowMessage('กรุณาเลือกพนักงาน');
    end;

    OrderCDS.FieldByName('liulin_order_number').AsString :=
      Format('%.6d', [StrToInt(OrderCDS.FieldByName('liulin_order_number')
      .AsString)]);

    OrderCDS.FieldByName('liulin_employee_id').AsInteger :=
      cxLookupComboBox1.EditValue;

    if VarIsNull(cxLookupComboBox2.EditValue) then
    begin
      OrderCDS.FieldByName('liulin_customer_id').Clear;
    end
    else
    begin
      OrderCDS.FieldByName('liulin_customer_id').AsInteger :=
        cxLookupComboBox2.EditValue;
    end;
    OrderCDS.Post;
  end;

  if OrderCDS.ChangeCount > 0 then
  begin
    OrderID := OrderCDS.FieldByName('liulin_order_id').AsInteger;
    HOSxP_UpdateDelta_log(OrderCDS,
      'SELECT * FROM liulin_order WHERE liulin_order_id=' + IntToStr(OrderID),
      'liulin_order', IntToStr(OrderID), '');
    OrderCDS.MergeChangeLog;
  end;

  // ตรวจสอบว่ามีข้อมูลใน grid อย่างน้อย 1 รายการ
  if OrderDetailCDS.RecordCount = 0 then
  begin
    ShowMessage('กรุณาเพิ่มสินค้าที่ต้องการสั่งอย่างน้อย 1 รายการ');
  end;

  // บันทึกข้อมูลใน grid
  if OrderDetailCDS.State in [dsInsert, dsEdit] then
  begin
    OrderDetailCDS.FieldByName('liulin_order_id').AsInteger := OrderID;
    OrderDetailCDS.Post;
  end;

  if OrderDetailCDS.ChangeCount > 0 then
  begin
    HOSxP_UpdateDelta_log(OrderDetailCDS,
      'SELECT * FROM liulin_orderdetail WHERE liulin_order_id=' +
      IntToStr(OrderID), 'liulin_orderdetail', IntToStr(OrderID), '');
    OrderDetailCDS.MergeChangeLog;
  end;
end;

class procedure THOSxPLiuLinOrderEntryForm.DoShowForm(OrderCDS: TClientDataSet;
  OrderID: Integer; IsNew: Boolean);
var
  HOSxPLiuLinOrderEntryForm: THOSxPLiuLinOrderEntryForm;
begin
  HOSxPLiuLinOrderEntryForm := THOSxPLiuLinOrderEntryForm.Create(Application);
  try
    HOSxPLiuLinOrderEntryForm.FOrderCDS := OrderCDS;
    HOSxPLiuLinOrderEntryForm.OrderID := OrderID;
    if IsNew then
    begin
      HOSxPLiuLinOrderEntryForm.FOrderCDS.Append;
      HOSxPLiuLinOrderEntryForm.cxButton5.Enabled := False;
    end
    else
    begin
      HOSxPLiuLinOrderEntryForm.DoRefreshData;
      HOSxPLiuLinOrderEntryForm.FOrderCDS.Edit;
      HOSxPLiuLinOrderEntryForm.cxButton5.Enabled := True;
    end;
    HOSxPLiuLinOrderEntryForm.ShowModal;
  finally
    HOSxPLiuLinOrderEntryForm.Free;
  end;
end;

procedure THOSxPLiuLinOrderEntryForm.SetOrderID(const Value: Integer);
var
  MaxID: Integer;
begin
  FOrderID := Value;

  if FOrderID = 0 then
  begin
    // ดึงค่า ID สูงสุดจากฐานข้อมูล
    MaxID := GetSQLData('SELECT MAX(liulin_order_id) FROM liulin_order');

    if MaxID = 0 then
      FOrderID := 1
    else
      FOrderID := MaxID + 1;

    while GetSQLData('SELECT COUNT(*) FROM liulin_order WHERE liulin_order_id='
      + IntToStr(FOrderID)) > 0 do
    begin
      Inc(FOrderID);
    end;
  end;
  DoRefreshData;
end;

procedure THOSxPLiuLinOrderEntryForm.DoPrintData;
begin
  printCDS.Data := HOSxP_GetDataSet('SELECT * FROM liulin_orderdetail lod ' +
    'LEFT JOIN liulin_product lp on lod.liulin_product_id = lp.liulin_product_id '
    + 'LEFT JOIN liulin_type lt on lp.liulin_type_id = lt.liulin_type_id ' +
    'LEFT JOIN liulin_order lo on lod.liulin_order_id = lo.liulin_order_id ' +
    'LEFT JOIN liulin_employee le on le.liulin_employee_id = lo.liulin_employee_id '
    + 'LEFT JOIN liulin_customer lc on lo.liulin_customer_id = lc.liulin_customer_id '
    + 'WHERE lod.liulin_order_id = ' + IntToStr(FOrderID));
  ppReport1.Print;
end;

function THOSxPLiuLinOrderEntryForm.sumprice(qty, price: Double): Double;
begin
  Result := qty * price;
end;

end.
