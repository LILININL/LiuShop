unit HOSxPLiulinTypeListFormUnit;

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
  cxTextEdit, cxGroupBox, ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel,
  JvExControls, JvNavigationPane;

type
  THOSxPLiulinTypeListForm = class(TForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataSource1: TDataSource;
    TypeCDS: TClientDataSet;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxTextEdit1: TcxTextEdit;
    cxLabel1: TcxLabel;
    Panel2: TPanel;
    cxButton6: TcxButton;
    cxButton7: TcxButton;
    cxButton8: TcxButton;
    JvNavPanelHeader1: TJvNavPanelHeader;
    cxButton9: TcxButton;
    cxButton10: TcxButton;
    cxButton4: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxTextEdit1PropertiesChange(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);

    procedure cxButton4Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton6Click(Sender: TObject);
    procedure cxGrid1DBTableView1Column1GetDisplayText
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGrid1DBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    procedure DoRefreshData;
    procedure DoAddType;
    procedure DoEditType;
    procedure DoSearchType(const AFilter: string);
  public
    { Public declarations }
  end;

var
  HOSxPLiulinTypeListForm: THOSxPLiulinTypeListForm;

implementation

uses BMSApplicationUtil, HOSxPDMU, HOSxPLiulinTypeEntryFormUnit;

{$R *.dfm}

procedure THOSxPLiulinTypeListForm.cxButton1Click(Sender: TObject);
begin
  DoEditType;
end;

procedure THOSxPLiulinTypeListForm.cxButton2Click(Sender: TObject);
begin
  DoAddType;
end;

procedure THOSxPLiulinTypeListForm.cxButton3Click(Sender: TObject);
begin
  // ���� Excel
  if TypeCDS.RecordCount = 0 then
    Exit;
  DoExportCxGridToExcel(cxGrid1);
end;

procedure THOSxPLiulinTypeListForm.cxButton4Click(Sender: TObject);
begin
  // ���� Log
  SafeLoadPackage('HOSxPUserManagerPackage.bpl');
  ExecuteRTTIFunction
    ('HOSxPUserManagerLogViewerFormUnit.THOSxPUserManagerLogViewerForm',
    'DoShowForm', ['liulin_type', '']);
end;

procedure THOSxPLiulinTypeListForm.cxButton5Click(Sender: TObject);
begin
  // ��������
  DoSearchType(cxTextEdit1.Text);
end;

procedure THOSxPLiulinTypeListForm.cxButton6Click(Sender: TObject);
begin
  Close;
end;

procedure THOSxPLiulinTypeListForm.cxGrid1DBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
cxButton8.Click;
end;

procedure THOSxPLiulinTypeListForm.cxGrid1DBTableView1Column1GetDisplayText
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := IntToStr(ARecord.Index + 1);
end;

procedure THOSxPLiulinTypeListForm.cxTextEdit1PropertiesChange(Sender: TObject);
begin
  // ��ͧ����
  DoSearchType(cxTextEdit1.Text);
end;

procedure THOSxPLiulinTypeListForm.DoRefreshData;
begin
  TypeCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_type_id, liulin_type_name FROM liulin_type;');
end;

procedure THOSxPLiulinTypeListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure THOSxPLiulinTypeListForm.FormCreate(Sender: TObject);
begin
  DoRefreshData;
end;

procedure THOSxPLiulinTypeListForm.DoAddType;
begin
  THOSxPLiulinTypeEntryForm.DoShowForm(TypeCDS, 0, True);
  DoRefreshData;
end;

procedure THOSxPLiulinTypeListForm.DoEditType;
begin
  if TypeCDS.RecordCount = 0 then
    Exit;
  THOSxPLiulinTypeEntryForm.DoShowForm(TypeCDS,
    TypeCDS.FieldByName('liulin_type_id').AsInteger, False);
  DoRefreshData;
end;

procedure THOSxPLiulinTypeListForm.DoSearchType(const AFilter: string);
begin
  if Trim(AFilter) = '' then
  begin
    DoRefreshData;
  end
  else
  begin
    TypeCDS.Data := HOSxP_GetDataSet
      ('SELECT liulin_type_id, liulin_type_name FROM liulin_type ' +
      'WHERE liulin_type_name LIKE ''%' + AFilter + '%''');
  end;
end;

end.
