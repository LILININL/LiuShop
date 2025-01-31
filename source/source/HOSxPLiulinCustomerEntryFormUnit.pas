unit HOSxPLiulinCustomerEntryFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxControls, cxContainer, cxEdit, cxLabel,
  cxTextEdit, StdCtrls, cxButtons, DB, DBClient, cxGroupBox, ExtCtrls,
  JvExControls, JvNavigationPane;

type
  THOSxPLiulinCustomerEntryForm = class(TForm)
    cxTextEdit1: TcxTextEdit;
    cxTextEdit2: TcxTextEdit;
    JvNavPanelHeader1: TJvNavPanelHeader;
    cxButton5: TcxButton;
    Panel1: TPanel;
    cxButton4: TcxButton;
    cxButton6: TcxButton;
    cxButton7: TcxButton;
    cxGroupBox2: TcxGroupBox;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxTextEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton5Click(Sender: TObject);
  private
    FCustomerID: Integer;
    FCustomerCDS: TClientDataSet;
    procedure DoSaveData;
    procedure DoDeleteData;
    procedure DoRefreshData;
    procedure SetCustomerID(const Value: Integer);
    function IsNumeric(const S: string): Boolean;
    { Private declarations }
  public
    class procedure DoShowForm(CustomerCDS: TClientDataSet; CustomerID: Integer;
      IsNew: Boolean);
    property CustomerID: Integer read FCustomerID write SetCustomerID;
    { Public declarations }
  end;

var
  HOSxPLiulinCustomerEntryForm: THOSxPLiulinCustomerEntryForm;

implementation

uses BMSApplicationUtil, HOSxPDMU;

{$R *.dfm}

procedure THOSxPLiulinCustomerEntryForm.cxButton1Click(Sender: TObject);
begin
  if not IsNumeric(cxTextEdit2.Text) then
  begin
    ShowMessage('��س���������Ţ���Ѿ�����繵���Ţ��ҹ��');
    Exit;
  end;
  DoSaveData;
  Close;
end;

procedure THOSxPLiulinCustomerEntryForm.cxButton2Click(Sender: TObject);
begin
  if MessageDlg('�׹�ѹ���ź', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DoDeleteData;
    Close;
  end;
end;

procedure THOSxPLiulinCustomerEntryForm.cxButton3Click(Sender: TObject);
begin
  Close;
end;

procedure THOSxPLiulinCustomerEntryForm.cxButton5Click(Sender: TObject);
begin
  SafeLoadPackage('HOSxPUserManagerPackage.bpl');
  ExecuteRTTIFunction
    ('HOSxPUserManagerLogViewerFormUnit.THOSxPUserManagerLogViewerForm',
    'DoShowForm', ['liulin_customer', IntToStr(FCustomerID)]);
end;

procedure THOSxPLiulinCustomerEntryForm.cxTextEdit2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if not CharInSet(Key, ['+', '0' .. '9', #8, #13]) then
  begin
    Key := #0;
    ShowMessage('��س���������Ţ���Ѿ�����繵���Ţ��ҹ��');
  end;
end;

procedure THOSxPLiulinCustomerEntryForm.DoDeleteData;
begin
  if FCustomerCDS.Locate('liulin_customer_id', FCustomerID, []) then
  begin
    FCustomerCDS.Delete;
    if FCustomerCDS.ChangeCount > 0 then
    begin
      HOSxP_UpdateDelta_log(FCustomerCDS, 'SELECT * FROM liulin_customer WHERE '
        + 'liulin_customer_id=' + IntToStr(FCustomerID), 'liulin_customer',
        IntToStr(FCustomerID), '');
      FCustomerCDS.MergeChangeLog;
    end;
  end;
end;

procedure THOSxPLiulinCustomerEntryForm.DoRefreshData;
begin
  if FCustomerCDS.Locate('liulin_customer_id', FCustomerID, []) then
  begin
    cxTextEdit1.Text := FCustomerCDS.FieldByName
      ('liulin_customer_name').AsString;
    cxTextEdit2.Text := FCustomerCDS.FieldByName('customer_tel').AsString;
  end;
end;

procedure THOSxPLiulinCustomerEntryForm.DoSaveData;
begin
  if FCustomerCDS.State in [dsInsert, dsEdit] then
  begin
    FCustomerCDS.FieldByName('liulin_customer_name').AsString :=
      cxTextEdit1.Text;
    FCustomerCDS.FieldByName('customer_tel').AsString := cxTextEdit2.Text;
    FCustomerCDS.Post;
  end;
  if FCustomerCDS.ChangeCount > 0 then
  begin
    HOSxP_UpdateDelta_log(FCustomerCDS, 'SELECT * FROM liulin_customer WHERE ' +
      'liulin_customer_id=' + IntToStr(FCustomerID), 'liulin_customer',
      IntToStr(FCustomerID), '');
    FCustomerCDS.MergeChangeLog;
  end;
end;

class procedure THOSxPLiulinCustomerEntryForm.DoShowForm
  (CustomerCDS: TClientDataSet; CustomerID: Integer; IsNew: Boolean);
var
  HOSxPLiulinCustomerEntryForm: THOSxPLiulinCustomerEntryForm;
begin
  HOSxPLiulinCustomerEntryForm := THOSxPLiulinCustomerEntryForm.Create
    (Application);
  try
    HOSxPLiulinCustomerEntryForm.FCustomerCDS := CustomerCDS;
    HOSxPLiulinCustomerEntryForm.CustomerID := CustomerID;
    if IsNew then
    begin
      HOSxPLiulinCustomerEntryForm.cxButton6.Enabled := False;
      HOSxPLiulinCustomerEntryForm.FCustomerCDS.Append;
    end
    else
    begin
      HOSxPLiulinCustomerEntryForm.DoRefreshData;
      HOSxPLiulinCustomerEntryForm.FCustomerCDS.Edit; // ����������
    end;
    HOSxPLiulinCustomerEntryForm.ShowModal;
  finally
    HOSxPLiulinCustomerEntryForm.Free;
  end;
end;

procedure THOSxPLiulinCustomerEntryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure THOSxPLiulinCustomerEntryForm.SetCustomerID(const Value: Integer);
var
  MaxID: Integer;
begin
  FCustomerID := Value;

  if FCustomerID = 0 then
  begin
    // �֧��� ID �٧�ش�ҡ�ҹ������
    MaxID := GetSQLData('SELECT MAX(liulin_customer_id) FROM liulin_customer');

    if MaxID = 0 then
      FCustomerID := 1
    else
      FCustomerID := MaxID + 1;

    while GetSQLData
      ('SELECT COUNT(*) FROM liulin_customer WHERE liulin_customer_id=' +
      IntToStr(FCustomerID)) > 0 do
    begin
      ShowMessage('Generated CustomerID: ' + IntToStr(FCustomerID));
      Inc(FCustomerID);
    end;
  end;
end;

function THOSxPLiulinCustomerEntryForm.IsNumeric(const S: string): Boolean;
var
  P: PChar;
begin
  P := PChar(S);
  Result := False;
  while P^ <> #0 do
  begin
    if not(P^ in ['+', '0' .. '9']) then
      Exit;
    Inc(P);
  end;
  Result := True;
end;

end.
