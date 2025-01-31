unit HOSxPLiulinEmployeeEntryFormUnit;

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
  THOSxPLiulinEmployeeEntryForm = class(TForm)
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
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxTextEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton5Click(Sender: TObject);
  private
    FEmployeeID: Integer;
    FEmployeeCDS: TClientDataSet;
    procedure DoSaveData;
    procedure DoDeleteData;
    procedure DoRefreshData;
    procedure SetEmployeeID(const Value: Integer);
    function IsNumeric(const S: string): Boolean;
    { Private declarations }
  public
    class procedure DoShowForm(EmployeeCDS: TClientDataSet; EmployeeID: Integer;
      IsNew: Boolean);
    property EmployeeID: Integer read FEmployeeID write SetEmployeeID;
    { Public declarations }
  end;

var
  HOSxPLiulinEmployeeEntryForm: THOSxPLiulinEmployeeEntryForm;

implementation

uses BMSApplicationUtil, HOSxPDMU;

{$R *.dfm}

procedure THOSxPLiulinEmployeeEntryForm.cxButton1Click(Sender: TObject);
begin
  Close;
end;

procedure THOSxPLiulinEmployeeEntryForm.cxButton2Click(Sender: TObject);
begin
  if not IsNumeric(cxTextEdit2.Text) then
  begin
    ShowMessage('��س���������Ţ���Ѿ�����繵���Ţ��ҹ��');
    Exit;
  end;
  DoSaveData;
  Close;
end;

procedure THOSxPLiulinEmployeeEntryForm.cxButton3Click(Sender: TObject);
begin
  if MessageDlg('�׹�ѹ���ź', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DoDeleteData;
    Close;
  end;
end;

procedure THOSxPLiulinEmployeeEntryForm.cxButton5Click(Sender: TObject);
begin
  SafeLoadPackage('HOSxPUserManagerPackage.bpl');
  ExecuteRTTIFunction
    ('HOSxPUserManagerLogViewerFormUnit.THOSxPUserManagerLogViewerForm',
    'DoShowForm', ['liulin_employee', IntToStr(FEmployeeID)]);
end;

procedure THOSxPLiulinEmployeeEntryForm.cxTextEdit2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if not CharInSet(Key, ['0' .. '9', #8, #13]) then
  begin
    Key := #0;
    ShowMessage('��س���������Ţ���Ѿ�����繵���Ţ��ҹ��');
  end;
end;

procedure THOSxPLiulinEmployeeEntryForm.DoDeleteData;
begin
  if FEmployeeCDS.Locate('liulin_employee_id', FEmployeeID, []) then
  begin
    FEmployeeCDS.Delete;
    if FEmployeeCDS.ChangeCount > 0 then
    begin
      HOSxP_UpdateDelta_log(FEmployeeCDS, 'SELECT * FROM liulin_employee WHERE '
        + 'liulin_employee_id=' + IntToStr(FEmployeeID), 'liulin_employee',
        IntToStr(FEmployeeID), '');
      FEmployeeCDS.MergeChangeLog;
    end;
  end;
end;

procedure THOSxPLiulinEmployeeEntryForm.DoRefreshData;
begin
  if FEmployeeCDS.Locate('liulin_employee_id', FEmployeeID, []) then
  begin
    cxTextEdit1.Text := FEmployeeCDS.FieldByName
      ('liulin_employee_name').AsString;
    cxTextEdit2.Text := FEmployeeCDS.FieldByName('liulin_employee_tel')
      .AsString;
  end;
end;

procedure THOSxPLiulinEmployeeEntryForm.DoSaveData;
begin
  if FEmployeeCDS.State in [dsInsert, dsEdit] then
  begin
    FEmployeeCDS.FieldByName('liulin_employee_name').AsString :=
      cxTextEdit1.Text;
    FEmployeeCDS.FieldByName('liulin_employee_tel').AsString :=
      cxTextEdit2.Text;
    FEmployeeCDS.Post;
  end;
  if FEmployeeCDS.ChangeCount > 0 then
  begin
    HOSxP_UpdateDelta_log(FEmployeeCDS, 'SELECT * FROM liulin_employee WHERE ' +
      'liulin_employee_id=' + IntToStr(FEmployeeID), 'liulin_employee',
      IntToStr(FEmployeeID), '');
    FEmployeeCDS.MergeChangeLog;
  end;
end;

class procedure THOSxPLiulinEmployeeEntryForm.DoShowForm
  (EmployeeCDS: TClientDataSet; EmployeeID: Integer; IsNew: Boolean);
var
  HOSxPLiulinEmployeeEntryForm: THOSxPLiulinEmployeeEntryForm;
begin
  HOSxPLiulinEmployeeEntryForm := THOSxPLiulinEmployeeEntryForm.Create
    (Application);
  try
    HOSxPLiulinEmployeeEntryForm.FEmployeeCDS := EmployeeCDS;
    HOSxPLiulinEmployeeEntryForm.EmployeeID := EmployeeID;

    if IsNew then
    begin
      HOSxPLiulinEmployeeEntryForm.cxButton7.Enabled := True;
      HOSxPLiulinEmployeeEntryForm.cxButton6.Enabled := False;
      HOSxPLiulinEmployeeEntryForm.FEmployeeCDS.Append;
      HOSxPLiulinEmployeeEntryForm.FEmployeeCDS.FieldByName
        ('liulin_employee_id').AsInteger :=
        HOSxPLiulinEmployeeEntryForm.EmployeeID;
    end
    else
    begin
      HOSxPLiulinEmployeeEntryForm.DoRefreshData;
      HOSxPLiulinEmployeeEntryForm.FEmployeeCDS.Edit;
      HOSxPLiulinEmployeeEntryForm.cxButton7.Enabled := True;
      HOSxPLiulinEmployeeEntryForm.cxButton6.Enabled := True;
    end;

    HOSxPLiulinEmployeeEntryForm.ShowModal;
  finally
    HOSxPLiulinEmployeeEntryForm.Free;
  end;
end;

procedure THOSxPLiulinEmployeeEntryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure THOSxPLiulinEmployeeEntryForm.SetEmployeeID(const Value: Integer);
var
  MaxID: Integer;
begin
  FEmployeeID := Value;

  if FEmployeeID = 0 then
  begin
    // �֧��� ID �٧�ش�ҡ�ҹ������
    MaxID := GetSQLData('SELECT MAX(liulin_employee_id) FROM liulin_employee');

    if MaxID = 0 then
      FEmployeeID := 1
    else
      FEmployeeID := MaxID + 1;

    while GetSQLData
      ('SELECT COUNT(*) FROM liulin_employee WHERE liulin_employee_id=' +
      IntToStr(FEmployeeID)) > 0 do
    begin
      Inc(FEmployeeID);
    end;
  end;
end;

function THOSxPLiulinEmployeeEntryForm.IsNumeric(const S: string): Boolean;
var
  P: PChar;
begin
  P := PChar(S);
  Result := False;
  while P^ <> #0 do
  begin
    if not(P^ in ['0' .. '9']) then
      Exit;
    Inc(P);
  end;
  Result := True;
end;

end.
