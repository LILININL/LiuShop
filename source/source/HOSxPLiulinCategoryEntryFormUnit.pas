unit HOSxPLiulinCategoryEntryFormUnit;

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
  THOSxPLiulinCategoryEntryForm = class(TForm)
    cxTextEdit1: TcxTextEdit;
    cxLabel1: TcxLabel;
    JvNavPanelHeader1: TJvNavPanelHeader;
    cxButton5: TcxButton;
    Panel1: TPanel;
    cxButton6: TcxButton;
    cxButton7: TcxButton;
    cxButton8: TcxButton;
    cxGroupBox2: TcxGroupBox;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FCategoryCDS: TClientDataSet;
    FCategoryID: Integer;
    procedure DoSaveData;
    procedure DoDeleteData;
    procedure DoRefreshData;
    procedure SetCategoryID(const Value: Integer);

  public
    { Public declarations }
    class procedure DoShowForm(CategoryCDS: TClientDataSet; CategoryID: Integer;
      IsNew: Boolean);
    property CategoryID: Integer read FCategoryID write SetCategoryID;
  end;

var
  HOSxPLiulinCategoryEntryForm: THOSxPLiulinCategoryEntryForm;

implementation

uses BMSApplicationUtil, HOSxPDMU;

{$R *.dfm}

procedure THOSxPLiulinCategoryEntryForm.cxButton1Click(Sender: TObject);
begin
  DoSaveData;
  Close;
end;

procedure THOSxPLiulinCategoryEntryForm.cxButton2Click(Sender: TObject);
begin
  if MessageDlg('�׹�ѹ���ź', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DoDeleteData;
    Close;
  end;

end;

procedure THOSxPLiulinCategoryEntryForm.cxButton3Click(Sender: TObject);
begin
  Close;
end;

procedure THOSxPLiulinCategoryEntryForm.cxButton4Click(Sender: TObject);
begin
  SafeLoadPackage('HOSxPUserManagerPackage.bpl');
  ExecuteRTTIFunction
    ('HOSxPUserManagerLogViewerFormUnit.THOSxPUserManagerLogViewerForm',
    'DoShowForm', ['liulin_category', IntToStr(FCategoryID)]);
end;

procedure THOSxPLiulinCategoryEntryForm.DoDeleteData;
begin
  if FCategoryCDS.Locate('liulin_category_id', FCategoryID, []) then
  begin
    FCategoryCDS.Delete;
    if FCategoryCDS.ChangeCount > 0 then
    begin
      HOSxP_UpdateDelta_log(FCategoryCDS, 'SELECT * FROM liulin_category WHERE '
        + 'liulin_category_id=' + IntToStr(FCategoryID), 'liulin_category',
        IntToStr(FCategoryID), '');
      FCategoryCDS.MergeChangeLog;
    end;
  end;
end;

procedure THOSxPLiulinCategoryEntryForm.DoRefreshData;
begin
  if FCategoryCDS.Locate('liulin_category_id', FCategoryID, []) then
  begin
    cxTextEdit1.Text := FCategoryCDS.FieldByName
      ('liulin_category_name').AsString;
  end;
end;

procedure THOSxPLiulinCategoryEntryForm.DoSaveData;
var
  ErrorMsg: string;
begin
  ErrorMsg := '';

  if Trim(cxTextEdit1.Text) = '' then
    ErrorMsg := ErrorMsg + '��س������� Category' + sLineBreak;

  if ErrorMsg <> '' then
  begin
    ShowMessage(ErrorMsg);
    Exit;
  end;

  if FCategoryCDS.State in [dsInsert, dsEdit] then
  begin
    FCategoryCDS.FieldByName('liulin_category_name').AsString :=
      cxTextEdit1.Text;
    FCategoryCDS.Post;
  end;

  if FCategoryCDS.ChangeCount > 0 then
  begin
    HOSxP_UpdateDelta_log(FCategoryCDS, 'SELECT * FROM liulin_category WHERE ' +
      'liulin_category_id=' + IntToStr(FCategoryID), 'liulin_category',
      IntToStr(FCategoryID), '');
    FCategoryCDS.MergeChangeLog;
  end;
end;

class procedure THOSxPLiulinCategoryEntryForm.DoShowForm
  (CategoryCDS: TClientDataSet; CategoryID: Integer; IsNew: Boolean);
var
  HOSxPLiulinCategoryEntryForm: THOSxPLiulinCategoryEntryForm;
begin
  HOSxPLiulinCategoryEntryForm := THOSxPLiulinCategoryEntryForm.Create
    (Application);
  try
    HOSxPLiulinCategoryEntryForm.FCategoryCDS := CategoryCDS;
    HOSxPLiulinCategoryEntryForm.CategoryID := CategoryID;
    if IsNew then
    begin
      HOSxPLiulinCategoryEntryForm.FCategoryCDS.Append;
      HOSxPLiulinCategoryEntryForm.cxButton7.Enabled := False;
      // �Դ�����ҹ����ź
    end
    else
    begin
      HOSxPLiulinCategoryEntryForm.DoRefreshData;
      HOSxPLiulinCategoryEntryForm.FCategoryCDS.Edit;
      HOSxPLiulinCategoryEntryForm.cxButton7.Enabled := True;
      // �Դ�����ҹ����ź
    end;
    HOSxPLiulinCategoryEntryForm.ShowModal;
  finally
    HOSxPLiulinCategoryEntryForm.Free;
  end;
end;

procedure THOSxPLiulinCategoryEntryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure THOSxPLiulinCategoryEntryForm.SetCategoryID(const Value: Integer);
var
  MaxID: Integer;
begin
  FCategoryID := Value;

  if FCategoryID = 0 then
  begin
    // �֧��� ID �٧�ش�ҡ�ҹ������
    MaxID := GetSQLData('SELECT MAX(liulin_category_id) FROM liulin_category');

    if MaxID = 0 then
      FCategoryID := 1
    else
      FCategoryID := MaxID + 1;

    while GetSQLData
      ('SELECT COUNT(*) FROM liulin_category WHERE liulin_category_id=' +
      IntToStr(FCategoryID)) > 0 do
    begin
      ShowMessage('Generated CategoryID: ' + IntToStr(FCategoryID));
      Inc(FCategoryID);
    end;
  end;
end;

end.
