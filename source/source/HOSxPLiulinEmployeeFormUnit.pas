unit HOSxPLiulinEmployeeFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinsDefaultPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, cxBlobEdit, Menus, StdCtrls, cxButtons,
  HOSxPLiulinEmployeeEntryFormUnit, cxContainer, cxLabel, cxTextEdit,
  cxGroupBox, ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel, JvExControls,
  JvNavigationPane;

type
  THOSxPLiulinEmployeeListForm = class(TForm)
    EmployeeCDS: TClientDataSet;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    Datasouce1: TDataSource;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxTextEdit1: TcxTextEdit;
    Panel1: TPanel;
    JvNavPanelHeader2: TJvNavPanelHeader;
    cxButton7: TcxButton;
    cxButton8: TcxButton;
    cxButton4: TcxButton;
    cxLabel1: TcxLabel;
    cxButton3: TcxButton;
    cxButton5: TcxButton;
    cxButton11: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxTextEdit1PropertiesChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton11Click(Sender: TObject);
    procedure cxGrid1DBTableView1Column1GetDisplayText
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGrid1DBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    procedure DoRefreshData;
    procedure DoSearchEmployee(const AFilter: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HOSxPLiulinEmployeeListForm: THOSxPLiulinEmployeeListForm;

implementation

uses BMSApplicationUtil, HOSxPDMU, SiAuto;

{$R *.dfm}
{ THOSxPLiulinEmployeeListForm }

procedure THOSxPLiulinEmployeeListForm.DoRefreshData;
begin
  EmployeeCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_employee_id, liulin_employee_name, liulin_employee_tel FROM liulin_employee;');
end;

procedure THOSxPLiulinEmployeeListForm.DoSearchEmployee(const AFilter: string);
begin
  if Trim(AFilter) = '' then
  begin
    DoRefreshData;
  end
  else
  begin
    EmployeeCDS.Data := HOSxP_GetDataSet('SELECT ' + '    liulin_employee_id, '
      + '    liulin_employee_name, ' + '    liulin_employee_tel ' + 'FROM ' +
      '    liulin_employee ' + 'WHERE ' + '    liulin_employee_name LIKE ''%' +
      AFilter + '%'' OR ' + '    liulin_employee_tel LIKE ''%' +
      AFilter + '%''');
  end;
end;

procedure THOSxPLiulinEmployeeListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure THOSxPLiulinEmployeeListForm.FormCreate(Sender: TObject);
begin
  SiMain.LogDebug('sdasd');
  DoRefreshData;
end;

procedure THOSxPLiulinEmployeeListForm.FormShow(Sender: TObject);
begin
  DoRefreshData;
end;

procedure THOSxPLiulinEmployeeListForm.cxButton11Click(Sender: TObject);
begin
  close;
end;

procedure THOSxPLiulinEmployeeListForm.cxButton1Click(Sender: TObject);
begin
  ExecuteRTTIFunction
    ('HOSxPLiulinEmployeeEntryFormUnit.THOSxPLiulinEmployeeEntryForm',
    'DoShowForm', [EmployeeCDS, 0, True]);
  DoRefreshData;
end;

procedure THOSxPLiulinEmployeeListForm.cxButton2Click(Sender: TObject);
begin
  if EmployeeCDS.RecordCount = 0 then
    Exit;
  ExecuteRTTIFunction
    ('HOSxPLiulinEmployeeEntryFormUnit.THOSxPLiulinEmployeeEntryForm',
    'DoShowForm', [EmployeeCDS, EmployeeCDS.FieldByName('liulin_employee_id')
    .AsInteger, False]);
  DoRefreshData;
end;

procedure THOSxPLiulinEmployeeListForm.cxButton3Click(Sender: TObject);
begin
  // ��������
  DoSearchEmployee(cxTextEdit1.Text);
end;

procedure THOSxPLiulinEmployeeListForm.cxButton4Click(Sender: TObject);
begin
  if EmployeeCDS.RecordCount = 0 then
    Exit;
  DoExportCxGridToExcel(cxGrid1);
end;

procedure THOSxPLiulinEmployeeListForm.cxButton5Click(Sender: TObject);
begin
  SafeLoadPackage('HOSxPUserManagerPackage.bpl');
  ExecuteRTTIFunction
    ('HOSxPUserManagerLogViewerFormUnit.THOSxPUserManagerLogViewerForm',
    'DoShowForm', ['liulin_employee', '']);
end;

procedure THOSxPLiulinEmployeeListForm.cxGrid1DBTableView1CellDblClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  cxButton5.Click;
end;

procedure THOSxPLiulinEmployeeListForm.cxGrid1DBTableView1Column1GetDisplayText
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := IntToStr(ARecord.Index + 1);
end;

procedure THOSxPLiulinEmployeeListForm.cxTextEdit1PropertiesChange
  (Sender: TObject);
begin
  // ��ͧ����
  DoSearchEmployee(cxTextEdit1.Text);
end;

end.
