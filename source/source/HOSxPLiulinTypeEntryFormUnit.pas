unit HOSxPLiulinTypeEntryFormUnit;

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
  THOSxPLiulinTypeEntryForm = class(TForm)
    cxTextEdit1: TcxTextEdit;
    cxLabel1: TcxLabel;
    JvNavPanelHeader1: TJvNavPanelHeader;
    cxButton5: TcxButton;
    Panel1: TPanel;
    cxButton4: TcxButton;
    cxButton6: TcxButton;
    cxButton7: TcxButton;
    cxGroupBox2: TcxGroupBox;
    procedure cxButton1Click(Sender: TObject); // Close
    procedure cxButton2Click(Sender: TObject); // Delete
    procedure cxButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton5Click(Sender: TObject); // Save
  private
    { Private declarations }
    FTypeCDS: TClientDataSet;
    FTypeID: Integer;
    procedure DoSaveData;
    procedure DoDeleteData;
    procedure DoRefreshData;
    procedure SetTypeID(const Value: Integer);
  public
    { Public declarations }
    class procedure DoShowForm(TypeCDS: TClientDataSet; TypeID: Integer;
      IsNew: Boolean);
    property TypeID: Integer read FTypeID write SetTypeID;
  end;

var
  HOSxPLiulinTypeEntryForm: THOSxPLiulinTypeEntryForm;

implementation

uses BMSApplicationUtil, HOSxPDMU;

{$R *.dfm}

procedure THOSxPLiulinTypeEntryForm.cxButton1Click(Sender: TObject);
begin
  Close;
end;

procedure THOSxPLiulinTypeEntryForm.cxButton2Click(Sender: TObject);
begin
  if MessageDlg('�׹�ѹ���ź', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DoDeleteData;
    Close;
  end;
end;

procedure THOSxPLiulinTypeEntryForm.cxButton3Click(Sender: TObject);
begin
  DoSaveData;
  Close;
end;

procedure THOSxPLiulinTypeEntryForm.cxButton5Click(Sender: TObject);
begin
  SafeLoadPackage('HOSxPUserManagerPackage.bpl');
  ExecuteRTTIFunction
    ('HOSxPUserManagerLogViewerFormUnit.THOSxPUserManagerLogViewerForm',
    'DoShowForm', ['liulin_type', IntToStr(FTypeID)]);
end;

procedure THOSxPLiulinTypeEntryForm.DoDeleteData;
begin
  if FTypeCDS.Locate('liulin_type_id', FTypeID, []) then
  begin
    FTypeCDS.Delete;
    if FTypeCDS.ChangeCount > 0 then
    begin
      HOSxP_UpdateDelta_log(FTypeCDS, 'SELECT * FROM liulin_type WHERE ' +
        'liulin_type_id=' + IntToStr(FTypeID), 'liulin_type',
        IntToStr(FTypeID), '');
      FTypeCDS.MergeChangeLog;
    end;
  end;
end;

procedure THOSxPLiulinTypeEntryForm.DoRefreshData;
begin
  if FTypeCDS.Locate('liulin_type_id', FTypeID, []) then
  begin
    cxTextEdit1.Text := FTypeCDS.FieldByName('liulin_type_name').AsString;
  end;
end;

procedure THOSxPLiulinTypeEntryForm.DoSaveData;
var
  ErrorMsg: string;
begin
  ErrorMsg := '';

  if Trim(cxTextEdit1.Text) = '' then
    ErrorMsg := ErrorMsg + '��س������� Type' + sLineBreak;

  if ErrorMsg <> '' then
  begin
    ShowMessage(ErrorMsg);
    Exit;
  end;

  if FTypeCDS.State in [dsInsert, dsEdit] then
  begin
    FTypeCDS.FieldByName('liulin_type_name').AsString := cxTextEdit1.Text;
    FTypeCDS.Post;
  end;

  if FTypeCDS.ChangeCount > 0 then
  begin
    HOSxP_UpdateDelta_log(FTypeCDS, 'SELECT * FROM liulin_type WHERE ' +
      'liulin_type_id=' + IntToStr(FTypeID), 'liulin_type',
      IntToStr(FTypeID), '');
    FTypeCDS.MergeChangeLog;
  end;
end;

class procedure THOSxPLiulinTypeEntryForm.DoShowForm(TypeCDS: TClientDataSet;
  TypeID: Integer; IsNew: Boolean);
var
  HOSxPLiulinTypeEntryForm: THOSxPLiulinTypeEntryForm;
begin
  HOSxPLiulinTypeEntryForm := THOSxPLiulinTypeEntryForm.Create(Application);
  try
    HOSxPLiulinTypeEntryForm.FTypeCDS := TypeCDS;
    HOSxPLiulinTypeEntryForm.TypeID := TypeID;
    if IsNew then
    begin
      HOSxPLiulinTypeEntryForm.FTypeCDS.Append;
      HOSxPLiulinTypeEntryForm.cxButton6.Enabled := False;
      // �Դ�����ҹ����ź
    end
    else
    begin
      HOSxPLiulinTypeEntryForm.DoRefreshData;
      HOSxPLiulinTypeEntryForm.FTypeCDS.Edit;
      HOSxPLiulinTypeEntryForm.cxButton6.Enabled := True;
      // �Դ�����ҹ����ź
    end;
    HOSxPLiulinTypeEntryForm.ShowModal;
  finally
    HOSxPLiulinTypeEntryForm.Free;
  end;
end;

procedure THOSxPLiulinTypeEntryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure THOSxPLiulinTypeEntryForm.SetTypeID(const Value: Integer);
var
  MaxID: Integer;
begin
  FTypeID := Value;

  if FTypeID = 0 then
  begin
    // �֧��� ID �٧�ش�ҡ�ҹ������
    MaxID := GetSQLData('SELECT MAX(liulin_type_id) FROM liulin_type');

    if MaxID = 0 then
      FTypeID := 1
    else
      FTypeID := MaxID + 1;

    while GetSQLData('SELECT COUNT(*) FROM liulin_type WHERE liulin_type_id=' +
      IntToStr(FTypeID)) > 0 do
    begin
      Inc(FTypeID);
    end;
  end;
end;

end.
