unit HOSxPLiulinProductEntryFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxControls, cxContainer, cxEdit, cxLabel,
  cxTextEdit, StdCtrls, cxButtons, DB, DBClient, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, ExtCtrls, cxGroupBox,
  JvExControls, JvNavigationPane;

type
  THOSxPLiulinProductEntryForm = class(TForm)
    cxTextEdit1: TcxTextEdit;
    cxTextEdit2: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxButton1: TcxButton;
    cxLookupComboBox1: TcxLookupComboBox;
    cxLookupComboBox2: TcxLookupComboBox;
    cxLookupComboBox3: TcxLookupComboBox;
    DataSourceType: TDataSource;
    DataSourceCate: TDataSource;
    DataSourceSup: TDataSource;
    CategoryCDS: TClientDataSet;
    TypeCDS: TClientDataSet;
    SupplierCDS: TClientDataSet;
    JvNavPanelHeader1: TJvNavPanelHeader;
    cxButton5: TcxButton;
    cxGroupBox2: TcxGroupBox;
    Panel1: TPanel;
    cxButton4: TcxButton;
    cxButton6: TcxButton;
    cxButton7: TcxButton;
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton5Click(Sender: TObject);
  private
    FProductCDS: TClientDataSet;
    FProductID: Integer;
    procedure DoSaveData;
    procedure DoDeleteData;
    procedure DoRefreshData;
    procedure SetProductID(const Value: Integer);
    function IsNumeric(const S: string): Boolean;
    function ValidateData: Boolean;
  public
    class procedure DoShowForm(ProductCDS: TClientDataSet; ProductID: Integer;
      IsNew: Boolean);
    property ProductID: Integer read FProductID write SetProductID;
  end;

var
  HOSxPLiulinProductEntryForm: THOSxPLiulinProductEntryForm;

implementation

uses BMSApplicationUtil, HOSxPDMU;

{$R *.dfm}

procedure THOSxPLiulinProductEntryForm.cxButton1Click(Sender: TObject);
begin
  Close;
end;

procedure THOSxPLiulinProductEntryForm.cxButton2Click(Sender: TObject);
begin
  if MessageDlg('�׹�ѹ���ź', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DoDeleteData;
    Close;
  end;
end;

procedure THOSxPLiulinProductEntryForm.cxButton3Click(Sender: TObject);
begin
  if ValidateData then
  begin
    DoSaveData;
    Close;
  end;
end;

procedure THOSxPLiulinProductEntryForm.cxButton5Click(Sender: TObject);
begin
  SafeLoadPackage('HOSxPUserManagerPackage.bpl');
  ExecuteRTTIFunction
    ('HOSxPUserManagerLogViewerFormUnit.THOSxPUserManagerLogViewerForm',
    'DoShowForm', ['liulin_product', IntToStr(FProductID)]);
end;

procedure THOSxPLiulinProductEntryForm.DoDeleteData;
begin
  if FProductCDS.Locate('liulin_product_id', FProductID, []) then
  begin
    FProductCDS.Delete;
    if FProductCDS.ChangeCount > 0 then
    begin
      HOSxP_UpdateDelta_log(FProductCDS, 'SELECT * FROM liulin_product WHERE ' +
        'liulin_product_id=' + IntToStr(FProductID), 'liulin_product',
        IntToStr(FProductID), '');
      FProductCDS.MergeChangeLog;
    end;
  end;
end;

procedure THOSxPLiulinProductEntryForm.DoRefreshData;
begin
  if FProductCDS.Locate('liulin_product_id', FProductID, []) then
  begin
    cxTextEdit1.Text := FProductCDS.FieldByName('liulin_product_name').AsString;
    cxTextEdit2.Text := FProductCDS.FieldByName('liulin_product_price')
      .AsString;

    // ��駤�� LookupComboBox ���ç�Ѻ���������
    cxLookupComboBox3.EditValue := FProductCDS.FieldByName('liulin_category_id')
      .AsInteger;
    cxLookupComboBox1.EditValue := FProductCDS.FieldByName('liulin_supplier_id')
      .AsInteger;
    cxLookupComboBox2.EditValue := FProductCDS.FieldByName('liulin_type_id')
      .AsInteger;
  end;
end;

function THOSxPLiulinProductEntryForm.ValidateData: Boolean;
var
  ErrorMsg: string;
  PriceValue: Double;
begin
  ErrorMsg := '';

  if Trim(cxTextEdit1.Text) = '' then
    ErrorMsg := ErrorMsg + '��س��������Թ���' + sLineBreak;

  if Trim(cxTextEdit2.Text) = '' then
    ErrorMsg := ErrorMsg + '��س�����Ҥ�' + sLineBreak
  else if not TryStrToFloat(cxTextEdit2.Text, PriceValue) then
    ErrorMsg := ErrorMsg + '��س�����Ҥҷ���繵���Ţ��ҹ��' + sLineBreak;

  if VarIsNull(cxLookupComboBox1.EditValue) or
    (cxLookupComboBox1.Text = '') then
    ErrorMsg := ErrorMsg + '��س����͡ Supplier' + sLineBreak;

  if VarIsNull(cxLookupComboBox2.EditValue) or
    (cxLookupComboBox2.Text = '') then
    ErrorMsg := ErrorMsg + '��س����͡ Type' + sLineBreak;

  if VarIsNull(cxLookupComboBox3.EditValue) or
    (cxLookupComboBox3.Text = '') then
    ErrorMsg := ErrorMsg + '��س����͡ Category' + sLineBreak;

  Result := ErrorMsg = '';
  if not Result then
    ShowMessage(ErrorMsg);
end;

procedure THOSxPLiulinProductEntryForm.DoSaveData;
begin
  if FProductCDS.State in [dsInsert, dsEdit] then
  begin
    FProductCDS.FieldByName('liulin_product_name').AsString := cxTextEdit1.Text;
    FProductCDS.FieldByName('liulin_product_price').AsFloat :=
      StrToFloat(cxTextEdit2.Text);

    // �Ѿവ ID ������͡�ҡ LookupComboBox
    if not VarIsNull(cxLookupComboBox3.EditValue) then
      FProductCDS.FieldByName('liulin_category_id').AsInteger :=
        cxLookupComboBox3.EditValue;
    if not VarIsNull(cxLookupComboBox1.EditValue) then
      FProductCDS.FieldByName('liulin_supplier_id').AsInteger :=
        cxLookupComboBox1.EditValue;
    if not VarIsNull(cxLookupComboBox2.EditValue) then
      FProductCDS.FieldByName('liulin_type_id').AsInteger :=
        cxLookupComboBox2.EditValue;
    FProductCDS.Post;
  end;

  if FProductCDS.ChangeCount > 0 then
  begin
    HOSxP_UpdateDelta_log(FProductCDS, 'SELECT * FROM liulin_product WHERE ' +
      'liulin_product_id=' + IntToStr(FProductID), 'liulin_product',
      IntToStr(FProductID), '');
    FProductCDS.MergeChangeLog;
  end;
end;

class procedure THOSxPLiulinProductEntryForm.DoShowForm
  (ProductCDS: TClientDataSet; ProductID: Integer; IsNew: Boolean);
var
  HOSxPLiulinProductEntryForm: THOSxPLiulinProductEntryForm;
begin
  HOSxPLiulinProductEntryForm := THOSxPLiulinProductEntryForm.Create
    (Application);
  try
    HOSxPLiulinProductEntryForm.FProductCDS := ProductCDS;
    HOSxPLiulinProductEntryForm.ProductID := ProductID;
    if IsNew then
    begin
      HOSxPLiulinProductEntryForm.FProductCDS.Append;
      HOSxPLiulinProductEntryForm.cxButton6.Enabled := False;
      // �Դ�����ҹ����ź
    end
    else
    begin
      HOSxPLiulinProductEntryForm.DoRefreshData;
      HOSxPLiulinProductEntryForm.FProductCDS.Edit;
      HOSxPLiulinProductEntryForm.cxButton6.Enabled := True;
      // �Դ�����ҹ����ź
    end;
    HOSxPLiulinProductEntryForm.ShowModal;
  finally
    HOSxPLiulinProductEntryForm.Free;
  end;
end;

procedure THOSxPLiulinProductEntryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure THOSxPLiulinProductEntryForm.FormCreate(Sender: TObject);
begin
  // ���������� LookupComboBox ����Ѻ Category
  CategoryCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_category_id, liulin_category_name FROM liulin_category');
  DataSourceCate.DataSet := CategoryCDS;
  cxLookupComboBox3.Properties.ListSource := DataSourceCate;
  cxLookupComboBox3.Properties.ListFieldNames := 'liulin_category_name';
  cxLookupComboBox3.Properties.KeyFieldNames := 'liulin_category_id';

  // ���������� LookupComboBox ����Ѻ Supplier
  SupplierCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_supplier_id, liulin_supplier_name FROM liulin_supplier');
  DataSourceSup.DataSet := SupplierCDS;
  cxLookupComboBox1.Properties.ListSource := DataSourceSup;
  cxLookupComboBox1.Properties.ListFieldNames := 'liulin_supplier_name';
  cxLookupComboBox1.Properties.KeyFieldNames := 'liulin_supplier_id';

  // ���������� LookupComboBox ����Ѻ Type
  TypeCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_type_id, liulin_type_name FROM liulin_type');
  DataSourceType.DataSet := TypeCDS;
  cxLookupComboBox2.Properties.ListSource := DataSourceType;
  cxLookupComboBox2.Properties.ListFieldNames := 'liulin_type_name';
  cxLookupComboBox2.Properties.KeyFieldNames := 'liulin_type_id';
end;

procedure THOSxPLiulinProductEntryForm.SetProductID(const Value: Integer);
var
  MaxID: Integer;
begin
  FProductID := Value;

  if FProductID = 0 then
  begin
    // �֧��� ID �٧�ش�ҡ�ҹ������
    MaxID := GetSQLData('SELECT MAX(liulin_product_id) FROM liulin_product');

    if MaxID = 0 then
      FProductID := 1
    else
      FProductID := MaxID + 1;

    while GetSQLData
      ('SELECT COUNT(*) FROM liulin_product WHERE liulin_product_id=' +
      IntToStr(FProductID)) > 0 do
    begin
      Inc(FProductID);
    end;
  end;
end;

function THOSxPLiulinProductEntryForm.IsNumeric(const S: string): Boolean;
var
  P: PChar;
begin
  P := PChar(S);
  Result := False;
  while P^ <> #0 do
  begin
    if not CharInSet(P^, ['0' .. '9', '.', ',']) then
      Exit;
    Inc(P);
  end;
  Result := True;
end;

end.
