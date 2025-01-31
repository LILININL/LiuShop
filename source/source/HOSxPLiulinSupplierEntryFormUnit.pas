unit HOSxPLiulinSupplierEntryFormUnit;

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
  THOSxPLiulinSupplierEntryForm = class(TForm)
    cxTextEdit1: TcxTextEdit;
    cxTextEdit2: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    JvNavPanelHeader1: TJvNavPanelHeader;
    cxButton5: TcxButton;
    Panel1: TPanel;
    cxButton4: TcxButton;
    cxButton6: TcxButton;
    cxButton7: TcxButton;
    cxGroupBox2: TcxGroupBox;
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton5Click(Sender: TObject);
  private
    { Private declarations }
    FSupplierCDS: TClientDataSet;
    FSupplierID: Integer;
    procedure DoSaveData;
    procedure DoDeleteData;
    procedure DoRefreshData;
    procedure SetSupplierID(const Value: Integer);
    // function IsNumeric(const S: string): Boolean;
  public
    { Public declarations }
    class procedure DoShowForm(SupplierCDS: TClientDataSet; SupplierID: Integer;
      IsNew: Boolean);
    property SupplierID: Integer read FSupplierID write SetSupplierID;
  end;

var
  HOSxPLiulinSupplierEntryForm: THOSxPLiulinSupplierEntryForm;

implementation

uses BMSApplicationUtil, HOSxPDMU;

{$R *.dfm}

procedure THOSxPLiulinSupplierEntryForm.cxButton1Click(Sender: TObject);
begin
  if MessageDlg('�׹�ѹ���ź', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DoDeleteData;
    Close;
  end;
end;

procedure THOSxPLiulinSupplierEntryForm.cxButton2Click(Sender: TObject);
begin
  DoSaveData;
  Close;
end;

procedure THOSxPLiulinSupplierEntryForm.cxButton3Click(Sender: TObject);
begin
  Close;
end;

procedure THOSxPLiulinSupplierEntryForm.cxButton5Click(Sender: TObject);
begin
  SafeLoadPackage('HOSxPUserManagerPackage.bpl');
  ExecuteRTTIFunction
    ('HOSxPUserManagerLogViewerFormUnit.THOSxPUserManagerLogViewerForm',
    'DoShowForm', ['liulin_supplier', IntToStr(FSupplierID)]);
end;

procedure THOSxPLiulinSupplierEntryForm.DoDeleteData;
begin
  if FSupplierCDS.Locate('liulin_supplier_id', FSupplierID, []) then
  begin
    FSupplierCDS.Delete;
    if FSupplierCDS.ChangeCount > 0 then
    begin
      HOSxP_UpdateDelta_log(FSupplierCDS, 'SELECT * FROM liulin_supplier WHERE '
        + 'liulin_supplier_id=' + IntToStr(FSupplierID), 'liulin_supplier',
        IntToStr(FSupplierID), '');
      FSupplierCDS.MergeChangeLog;
    end;
  end;
end;

procedure THOSxPLiulinSupplierEntryForm.DoRefreshData;
begin
  if FSupplierCDS.Locate('liulin_supplier_id', FSupplierID, []) then
  begin
    cxTextEdit1.Text := FSupplierCDS.FieldByName
      ('liulin_supplier_name').AsString;
    cxTextEdit2.Text := FSupplierCDS.FieldByName
      ('liulin_supplier_contact').AsString;
  end;
end;

procedure THOSxPLiulinSupplierEntryForm.DoSaveData;
var
  ErrorMsg: string;
begin
  ErrorMsg := '';

  if Trim(cxTextEdit1.Text) = '' then
    ErrorMsg := ErrorMsg + '��س������� Supplier' + sLineBreak;

  if Trim(cxTextEdit2.Text) = '' then
    ErrorMsg := ErrorMsg + '��س��������ŵԴ���' + sLineBreak;

  if ErrorMsg <> '' then
  begin
    ShowMessage(ErrorMsg);
    Exit;
  end;

  if FSupplierCDS.State in [dsInsert, dsEdit] then
  begin
    FSupplierCDS.FieldByName('liulin_supplier_name').AsString :=
      cxTextEdit1.Text;
    FSupplierCDS.FieldByName('liulin_supplier_contact').AsString :=
      cxTextEdit2.Text;
    FSupplierCDS.Post;
  end;

  if FSupplierCDS.ChangeCount > 0 then
  begin
    HOSxP_UpdateDelta_log(FSupplierCDS, 'SELECT * FROM liulin_supplier WHERE ' +
      'liulin_supplier_id=' + IntToStr(FSupplierID), 'liulin_supplier',
      IntToStr(FSupplierID), '');
    FSupplierCDS.MergeChangeLog;
  end;
end;

class procedure THOSxPLiulinSupplierEntryForm.DoShowForm
  (SupplierCDS: TClientDataSet; SupplierID: Integer; IsNew: Boolean);
var
  HOSxPLiulinSupplierEntryForm: THOSxPLiulinSupplierEntryForm;
begin
  HOSxPLiulinSupplierEntryForm := THOSxPLiulinSupplierEntryForm.Create
    (Application);
  try
    HOSxPLiulinSupplierEntryForm.FSupplierCDS := SupplierCDS;
    HOSxPLiulinSupplierEntryForm.SupplierID := SupplierID;
    if IsNew then
    begin
      HOSxPLiulinSupplierEntryForm.FSupplierCDS.Append;
      HOSxPLiulinSupplierEntryForm.cxButton6.Enabled := False;
      // �Դ�����ҹ����ź
    end
    else
    begin
      HOSxPLiulinSupplierEntryForm.DoRefreshData;
      HOSxPLiulinSupplierEntryForm.FSupplierCDS.Edit;
      HOSxPLiulinSupplierEntryForm.cxButton6.Enabled := True;
      // �Դ�����ҹ����ź
    end;
    HOSxPLiulinSupplierEntryForm.ShowModal;
  finally
    HOSxPLiulinSupplierEntryForm.Free;
  end;
end;

procedure THOSxPLiulinSupplierEntryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure THOSxPLiulinSupplierEntryForm.SetSupplierID(const Value: Integer);
var
  MaxID: Integer;
begin
  FSupplierID := Value;

  if FSupplierID = 0 then
  begin
    // �֧��� ID �٧�ش�ҡ�ҹ������
    MaxID := GetSQLData('SELECT MAX(liulin_supplier_id) FROM liulin_supplier');

    if MaxID = 0 then
      FSupplierID := 1
    else
      FSupplierID := MaxID + 1;

    while GetSQLData
      ('SELECT COUNT(*) FROM liulin_supplier WHERE liulin_supplier_id=' +
      IntToStr(FSupplierID)) > 0 do
    begin
      Inc(FSupplierID);
    end;
  end;
end;

end.
