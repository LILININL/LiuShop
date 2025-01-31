unit HOSxPOrderDetailEntryFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxControls, cxContainer, cxEdit, ComCtrls,
  dxCore, cxDateUtils, cxCurrencyEdit, cxDBEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, DB, DBClient, cxTextEdit, cxMaskEdit,
  cxCalendar, cxLabel, cxGroupBox, JvExControls, JvNavigationPane, StdCtrls,
  cxButtons, ExtCtrls;

type
  THOSxPOrderDetailEntryForm = class(TForm)
    Panel1: TPanel;
    cxButton5: TcxButton;
    cxButton4: TcxButton;
    JvNavPanelHeader1: TJvNavPanelHeader;
    cxButton7: TcxButton;
    cxGroupBox2: TcxGroupBox;
    cxLabel2: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxDateEdit1: TcxDateEdit;
    ProductCDS: TClientDataSet;
    OrderDetailCDS: TClientDataSet;
    orderdetailDS: TDataSource;
    DataSourcePro: TDataSource;
    OrderCDS: TClientDataSet;
    DataSourceOrder: TDataSource;
    cxLookupComboBox2: TcxLookupComboBox;
    cxLookupComboBox1: TcxLookupComboBox;
    cxLookupComboBox3: TcxLookupComboBox;
    cxLabel1: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel6: TcxLabel;
    cxTextEdit1: TcxTextEdit;
    cxTextEdit2: TcxTextEdit;
    EmployeeCDS: TClientDataSet;
    CustomerCDS: TClientDataSet;
    DataSourceEmployee: TDataSource;
    DataSourceCustomer: TDataSource;

    procedure cxButton4Click(Sender: TObject);
    procedure cxButton6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxButton7Click(Sender: TObject);
    procedure cxButton444Click(Sender: TObject);
  private
    FOrderDetailCDS: TClientDataSet;
    FOrderDetailID: Integer;
    FOrderID: Integer;
    procedure DoSaveData;
    procedure DoDeleteData;
    procedure DoRefreshData;
    procedure SetOrderDetailID(const Value: Integer);
    procedure SetOrderID(const Value: Integer);
  public
    class procedure DoShowForm(OrderDetailCDS: TClientDataSet;
      OrderDetailID: Integer; IsNew: Boolean);
    property OrderDetailID: Integer read FOrderDetailID write SetOrderDetailID;
    property OrderID: Integer read FOrderID write SetOrderID;
  end;

var
  HOSxPOrderDetailEntryForm: THOSxPOrderDetailEntryForm;

implementation

uses BMSApplicationUtil, HOSxPDMU;

{$R *.dfm}

procedure THOSxPOrderDetailEntryForm.cxButton444Click(Sender: TObject);
begin
Close;
end;

procedure THOSxPOrderDetailEntryForm.cxButton4Click(Sender: TObject);
var
  CustomerName, EmployeeName, ProductName: string;
begin
  // ��Ǩ�ͺ��д֧��Ҩҡ cxLookupComboBox2 (Customer)
  if not VarIsNull(cxLookupComboBox2.EditValue) then
  begin
    if CustomerCDS.Locate('liulin_customer_id',
      cxLookupComboBox2.EditValue, []) then
    begin
      CustomerName := CustomerCDS.FieldByName('liulin_customer_name').AsString;
      ShowMessage('Selected Customer: ' + CustomerName);
    end;
  end
  else
    ShowMessage('No customer selected.');

  // ��Ǩ�ͺ��д֧��Ҩҡ cxLookupComboBox1 (Employee)
  if not VarIsNull(cxLookupComboBox1.EditValue) then
  begin
    if EmployeeCDS.Locate('liulin_employee_id',
      cxLookupComboBox1.EditValue, []) then
    begin
      EmployeeName := EmployeeCDS.FieldByName('liulin_employee_name').AsString;
      ShowMessage('Selected Employee: ' + EmployeeName);
    end;
  end
  else
    ShowMessage('No employee selected.');

  // ��Ǩ�ͺ��д֧��Ҩҡ cxLookupComboBox3 (Product)
  if not VarIsNull(cxLookupComboBox3.EditValue) then
  begin
    if ProductCDS.Locate('liulin_product_id',
      cxLookupComboBox3.EditValue, []) then
    begin
      ProductName := ProductCDS.FieldByName('liulin_product_name').AsString;
      ShowMessage('Selected Product: ' + ProductName);
    end;
  end
  else
    ShowMessage('No product selected.');

  DoSaveData;
end;

procedure THOSxPOrderDetailEntryForm.cxButton6Click(Sender: TObject);
begin
  // Delete record
  if MessageDlg('�س��ͧ���ź�����Ź�����������?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    DoDeleteData;
    Close;
  end;
end;

procedure THOSxPOrderDetailEntryForm.cxButton7Click(Sender: TObject);
begin
  SafeLoadPackage('HOSxPUserManagerPackage.bpl');
  ExecuteRTTIFunction
    ('HOSxPUserManagerLogViewerFormUnit.THOSxPUserManagerLogViewerForm',
    'DoShowForm', ['liulin_order_detail', IntToStr(FOrderDetailID)]);
end;

procedure THOSxPOrderDetailEntryForm.DoDeleteData;
begin
  if FOrderDetailCDS.Locate('liulin_orderdetail_id', FOrderDetailID, []) then
  begin
    FOrderDetailCDS.Delete;
    if FOrderDetailCDS.ChangeCount > 0 then
    begin
      HOSxP_UpdateDelta_log(FOrderDetailCDS,
        'SELECT * FROM liulin_orderdetail WHERE liulin_orderdetail_id=' +
        IntToStr(FOrderDetailID), 'liulin_order_detail',
        IntToStr(FOrderDetailID), '');
      FOrderDetailCDS.MergeChangeLog;
    end;
  end;
end;

procedure THOSxPOrderDetailEntryForm.DoRefreshData;
begin
  // Ensure that CustomerCDS, EmployeeCDS, and ProductCDS are open
  if not CustomerCDS.Active then
    CustomerCDS.Open;
  if not EmployeeCDS.Active then
    EmployeeCDS.Open;
  if not ProductCDS.Active then
    ProductCDS.Open;

  FOrderDetailCDS.Data := HOSxP_GetDataSet('SELECT od.liulin_orderdetail_id, ' +
    'od.liulin_quantity, ' + 'od.liulin_total_price, ' + 'p.liulin_product_id, '
    + 'p.liulin_product_name, ' + 'o.liulin_order_date, ' +
    'o.liulin_employee_id, ' + 'o.liulin_customer_id, ' + 'o.liulin_order_id, '
    + // ������Ŵ���� Query
    'e.liulin_employee_name, ' + 'c.liulin_customer_name ' +
    'FROM liulin_orderdetail od ' +
    'JOIN liulin_order o ON od.liulin_order_id = o.liulin_order_id ' +
    'JOIN liulin_employee e ON o.liulin_employee_id = e.liulin_employee_id ' +
    'JOIN liulin_customer c ON o.liulin_customer_id = c.liulin_customer_id ' +
    'JOIN liulin_product p ON od.liulin_product_id = p.liulin_product_id ' +
    'WHERE od.liulin_orderdetail_id = ' + IntToStr(FOrderDetailID));
  FOrderDetailCDS.Open;

  if FOrderDetailCDS.Locate('liulin_orderdetail_id', FOrderDetailID, []) then
  begin
    cxDateEdit1.Date := FOrderDetailCDS.FieldByName('liulin_order_date')
      .AsDateTime;
    cxLookupComboBox1.EditValue := FOrderDetailCDS.FieldByName
      ('liulin_employee_id').AsInteger;
    cxLookupComboBox2.EditValue := FOrderDetailCDS.FieldByName
      ('liulin_customer_id').AsInteger;
    cxLookupComboBox3.EditValue := FOrderDetailCDS.FieldByName
      ('liulin_product_id').AsInteger;
    cxTextEdit1.EditValue := FOrderDetailCDS.FieldByName
      ('liulin_quantity').AsFloat;
    cxTextEdit2.EditValue := FOrderDetailCDS.FieldByName
      ('liulin_total_price').AsFloat;
  end;
end;

procedure THOSxPOrderDetailEntryForm.DoSaveData;
var
  ErrorMsg: string;
  Quantity, TotalPrice: Double;
  OrderDate: TDateTime;
  OrderID: Variant;
  SQLQuery: string;
begin
  ErrorMsg := '';

  // Ensure that CustomerCDS, EmployeeCDS, and ProductCDS are open
  if not CustomerCDS.Active then
    CustomerCDS.Open;
  if not EmployeeCDS.Active then
    EmployeeCDS.Open;
  if not ProductCDS.Active then
    ProductCDS.Open;

  if VarIsNull(cxLookupComboBox2.EditValue) or
    (cxLookupComboBox2.Text = '') then
    ErrorMsg := ErrorMsg + '��س����͡ Customer' + sLineBreak;

  if VarIsNull(cxLookupComboBox1.EditValue) or
    (cxLookupComboBox1.Text = '') then
    ErrorMsg := ErrorMsg + '��س����͡ Employee' + sLineBreak;

  if VarIsNull(cxLookupComboBox3.EditValue) or
    (cxLookupComboBox3.Text = '') then
    ErrorMsg := ErrorMsg + '��س����͡ Product' + sLineBreak;

  if VarIsNull(cxDateEdit1.EditValue) then
    ErrorMsg := ErrorMsg + '��س����͡�ѹ���' + sLineBreak;

  if VarIsNull(cxTextEdit1.EditValue) then
    ErrorMsg := ErrorMsg + '��سҡ�͡�ӹǹ' + sLineBreak;

  if VarIsNull(cxTextEdit2.EditValue) then
    ErrorMsg := ErrorMsg + '��سҡ�͡�Ҥ����' + sLineBreak;

  if ErrorMsg <> '' then
  begin
    ShowMessage(ErrorMsg);
    Exit;
  end;

  Quantity := cxTextEdit1.EditValue;
  TotalPrice := cxTextEdit2.EditValue;
  OrderDate := cxDateEdit1.Date;

  ShowMessage('Quantity: ' + FloatToStr(Quantity) + sLineBreak + 'Total Price: '
    + FloatToStr(TotalPrice) + sLineBreak + 'Order Date: ' +
    DateToStr(OrderDate));

  // Find the corresponding OrderID or insert a new order if not exists
  SQLQuery :=
    'SELECT liulin_order_id FROM liulin_order WHERE liulin_order_date = ''' +
    FormatDateTime('yyyy-mm-dd', OrderDate) + '''';
  OrderID := GetSQLData(SQLQuery);

  if VarIsNull(OrderID) or (OrderID = 0) then
  begin
    // Insert a new order
    HOSxP_GetDataSet
      ('INSERT INTO liulin_order (liulin_order_date, liulin_employee_id, liulin_customer_id) '
      + 'VALUES (''' + FormatDateTime('yyyy-mm-dd', OrderDate) + ''', ' +
      IntToStr(cxLookupComboBox1.EditValue) + ', ' +
      IntToStr(cxLookupComboBox2.EditValue) + ');');

    // Retrieve the new OrderID
    OrderID := GetSQLData(SQLQuery);
  end;

  if VarIsNull(OrderID) then
  begin
    ShowMessage('Error retrieving or creating order.');
    Exit;
  end;

  // Start editing the dataset
  FOrderDetailCDS.Edit;

  try
    // Set the OrderDetailID if it's a new record
    if FOrderDetailCDS.State = dsInsert then
      FOrderDetailCDS.FieldByName('liulin_orderdetail_id').AsInteger :=
        FOrderDetailID;

    FOrderDetailCDS.FieldByName('liulin_order_id').AsInteger := OrderID;
    FOrderDetailCDS.FieldByName('liulin_order_date').AsDateTime := OrderDate;
    FOrderDetailCDS.FieldByName('liulin_employee_id').AsInteger :=
      cxLookupComboBox1.EditValue;
    FOrderDetailCDS.FieldByName('liulin_customer_id').AsInteger :=
      cxLookupComboBox2.EditValue;
    FOrderDetailCDS.FieldByName('liulin_product_id').AsInteger :=
      cxLookupComboBox3.EditValue;
    FOrderDetailCDS.FieldByName('liulin_quantity').AsFloat := Quantity;
    FOrderDetailCDS.FieldByName('liulin_total_price').AsFloat := TotalPrice;

    // Commit the changes to the dataset
    FOrderDetailCDS.Post;

    if FOrderDetailCDS.ChangeCount > 0 then
    begin
      HOSxP_UpdateDelta_log(FOrderDetailCDS,
        'SELECT * FROM liulin_orderdetail WHERE liulin_orderdetail_id=' +
        IntToStr(FOrderDetailID), 'liulin_order_detail',
        IntToStr(FOrderDetailID), '');
      FOrderDetailCDS.MergeChangeLog;
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Error while saving data: ' + E.Message);
      FOrderDetailCDS.Cancel; // Cancel changes if there is an error
    end;
  end;

  Close;
end;

class procedure THOSxPOrderDetailEntryForm.DoShowForm(OrderDetailCDS
  : TClientDataSet; OrderDetailID: Integer; IsNew: Boolean);
var
  HOSxPOrderDetailEntryForm: THOSxPOrderDetailEntryForm;
begin
  HOSxPOrderDetailEntryForm := THOSxPOrderDetailEntryForm.Create(Application);
  try
    HOSxPOrderDetailEntryForm.FOrderDetailCDS := OrderDetailCDS;
    if IsNew then
    begin
      HOSxPOrderDetailEntryForm.OrderDetailID := 0;
      HOSxPOrderDetailEntryForm.FOrderDetailCDS.Append;
      HOSxPOrderDetailEntryForm.cxButton5.Enabled := False;
    end
    else
    begin
      HOSxPOrderDetailEntryForm.OrderDetailID := OrderDetailID;
      HOSxPOrderDetailEntryForm.DoRefreshData;
      HOSxPOrderDetailEntryForm.FOrderDetailCDS.Edit;
      HOSxPOrderDetailEntryForm.cxButton5.Enabled := True;
    end;
    HOSxPOrderDetailEntryForm.ShowModal;
  finally
    HOSxPOrderDetailEntryForm.Free;
  end;
end;

procedure THOSxPOrderDetailEntryForm.FormCreate(Sender: TObject);
begin
  // Load data into ProductCDS
  ProductCDS := TClientDataSet.Create(nil);
  ProductCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_product_id, liulin_product_name FROM liulin_product');
  DataSourcePro.DataSet := ProductCDS;
  cxLookupComboBox3.Properties.ListSource := DataSourcePro;
  cxLookupComboBox3.Properties.KeyFieldNames := 'liulin_product_id';
  cxLookupComboBox3.Properties.ListFieldNames := 'liulin_product_name';
  ProductCDS.Open;

  // Load data into EmployeeCDS
  EmployeeCDS := TClientDataSet.Create(nil);
  EmployeeCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_employee_id, liulin_employee_name FROM liulin_employee');
  DataSourceEmployee.DataSet := EmployeeCDS;
  cxLookupComboBox1.Properties.ListSource := DataSourceEmployee;
  cxLookupComboBox1.Properties.KeyFieldNames := 'liulin_employee_id';
  cxLookupComboBox1.Properties.ListFieldNames := 'liulin_employee_name';
  EmployeeCDS.Open;

  // Load data into CustomerCDS
  CustomerCDS := TClientDataSet.Create(nil);
  CustomerCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_customer_id, liulin_customer_name FROM liulin_customer');
  DataSourceCustomer.DataSet := CustomerCDS;
  cxLookupComboBox2.Properties.ListSource := DataSourceCustomer;
  cxLookupComboBox2.Properties.KeyFieldNames := 'liulin_customer_id';
  cxLookupComboBox2.Properties.ListFieldNames := 'liulin_customer_name';
  CustomerCDS.Open;

  // Load data into OrderCDS
  OrderCDS := TClientDataSet.Create(nil);
  OrderCDS.Data := HOSxP_GetDataSet('SELECT * FROM liulin_order');
  DataSourceOrder.DataSet := OrderCDS;
  OrderCDS.Open;

  // Create OrderDetailCDS structure
  OrderDetailCDS.FieldDefs.Clear;
  OrderDetailCDS.FieldDefs.Add('liulin_orderdetail_id', ftInteger);
  OrderDetailCDS.FieldDefs.Add('liulin_quantity', ftFloat);
  OrderDetailCDS.FieldDefs.Add('liulin_total_price', ftFloat);
  OrderDetailCDS.FieldDefs.Add('liulin_product_id', ftInteger);
  OrderDetailCDS.FieldDefs.Add('liulin_order_id', ftInteger); // Add this line
  OrderDetailCDS.FieldDefs.Add('liulin_employee_id', ftInteger);
  OrderDetailCDS.FieldDefs.Add('liulin_customer_id', ftInteger);
  OrderDetailCDS.FieldDefs.Add('liulin_order_date', ftDateTime);
  OrderDetailCDS.CreateDataSet;
end;

procedure THOSxPOrderDetailEntryForm.SetOrderDetailID(const Value: Integer);
var
  MaxID: Integer;
begin
  FOrderDetailID := Value;

  if FOrderDetailID = 0 then
  begin
    // �֧��� ID �٧�ش�ҡ�ҹ������
    MaxID := GetSQLData
      ('SELECT MAX(liulin_orderdetail_id) FROM liulin_orderdetail');

    if MaxID = 0 then
      FOrderDetailID := 1
    else
      FOrderDetailID := MaxID + 1;

    while GetSQLData
      ('SELECT COUNT(*) FROM liulin_orderdetail WHERE liulin_orderdetail_id=' +
      IntToStr(FOrderDetailID)) > 0 do
    begin
      ShowMessage('Generated OrderDetailID: ' + IntToStr(FOrderDetailID));
      Inc(FOrderDetailID);
    end;
  end;
end;

procedure THOSxPOrderDetailEntryForm.SetOrderID(const Value: Integer);
var
  OrderDate: TDateTime;
begin
  FOrderID := Value;

  // �֧��� OrderID �ҡ liulin_order ���� liulin_order_date
  if FOrderID = 0 then
  begin
    OrderDate := cxDateEdit1.Date;
    FOrderID := GetSQLData
      ('SELECT liulin_order_id FROM liulin_order WHERE liulin_order_date=''' +
      FormatDateTime('yyyy-mm-dd', OrderDate) + '''');
    if FOrderID = 0 then
      raise Exception.Create('��辺 OrderID ���ç�Ѻ�ѹ��������͡');
  end;
end;

end.
