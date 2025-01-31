unit HOSxPLiulinCustomerListFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinsDefaultPainters,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, StdCtrls, cxButtons,
  cxControls, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, dxDateRanges, dxScrollbarAnnotations, DB, cxDBData,
  cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, DBClient, Provider, SqlExpr, BMSApplicationUtil, HOSxPDMU,
  HOSxPLiulinCustomerEntryFormUnit, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  cxCustomPivotGrid, cxContainer, cxGroupBox, ExtCtrls, JvExExtCtrls,
  JvExtComponent, JvPanel, cxLabel, cxTextEdit, cxSplitter, JvExControls,
  JvNavigationPane;

type
  THOSxPLiulinCustomerListForm = class(TForm)
    CustomerCDS: TClientDataSet;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    DataSource1: TDataSource;
    cxTextEdit1: TcxTextEdit;
    cxLabel1: TcxLabel;
    Panel1: TPanel;
    JvNavPanelHeader2: TJvNavPanelHeader;
    cxButton7: TcxButton;
    cxButton8: TcxButton;
    cxButton4: TcxButton;
    cxButton3: TcxButton;
    cxButton1: TcxButton;
    cxButton5: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure AddBottomClick(Sender: TObject);
    procedure DeletebottomClick(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxTextEdit1PropertiesChange(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton5Click(Sender: TObject);
    procedure cxGridDBColumn1GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    procedure DoRefreshData;
    procedure DoSearchCustomer(const AFilter: string);
    procedure DoSaveData;
    procedure DoDeleteData;
    { Private declarations }
  public
    class procedure DoShowForm;
    { Public declarations }
  end;

var
  HOSxPLiulinCustomerListForm: THOSxPLiulinCustomerListForm;

implementation

// uses BMSApplicationUtil, HOSxPDMU;
{$R *.dfm}

procedure THOSxPLiulinCustomerListForm.cxButton4Click(Sender: TObject);
begin
  // ��������
  DoSearchCustomer(cxTextEdit1.Text);
end;

procedure THOSxPLiulinCustomerListForm.cxButton5Click(Sender: TObject);
begin
  close;
end;

procedure THOSxPLiulinCustomerListForm.DoRefreshData;
begin
  CustomerCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_customer_id, liulin_customer_name, customer_tel FROM liulin_customer;');
end;

procedure THOSxPLiulinCustomerListForm.DoSearchCustomer(const AFilter: string);
begin
  if Trim(AFilter) = '' then
  begin
    DoRefreshData;
  end
  else
  begin
    CustomerCDS.Data := HOSxP_GetDataSet
      ('SELECT liulin_customer_id, liulin_customer_name, customer_tel ' +
      'FROM liulin_customer ' + 'WHERE liulin_customer_name LIKE ''%' + AFilter
      + '%'' OR ' + 'customer_tel LIKE ''%' + AFilter + '%''');
  end;
end;

procedure THOSxPLiulinCustomerListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure THOSxPLiulinCustomerListForm.FormShow(Sender: TObject);
begin
  DoRefreshData;
end;

procedure THOSxPLiulinCustomerListForm.AddBottomClick(Sender: TObject);
begin
  ExecuteRTTIFunction
    ('HOSxPLiulinCustomerEntryFormUnit.THOSxPLiulinCustomerEntryForm',
    'DoShowForm', [CustomerCDS, 0, True]);
  DoRefreshData;
end;

procedure THOSxPLiulinCustomerListForm.DeletebottomClick(Sender: TObject);
begin
  if CustomerCDS.RecordCount = 0 then
    Exit;
  ExecuteRTTIFunction
    ('HOSxPLiulinCustomerEntryFormUnit.THOSxPLiulinCustomerEntryForm',
    'DoShowForm', [CustomerCDS, CustomerCDS.FieldByName('liulin_customer_id')
    .AsInteger, False]);
  DoRefreshData;
end;

procedure THOSxPLiulinCustomerListForm.DoDeleteData;
begin
  if CustomerCDS.RecordCount > 0 then
  begin
    CustomerCDS.Delete;
    DoSaveData;
  end;
end;

procedure THOSxPLiulinCustomerListForm.DoSaveData;
begin
  if CustomerCDS.State in [dsInsert, dsEdit] then
  begin
    CustomerCDS.Post;
  end;
  if CustomerCDS.ChangeCount > 0 then
  begin
    try
      CustomerCDS.ApplyUpdates(0);
      ShowMessage('Data updated successfully.');
    except
      on E: Exception do
      begin
        ShowMessage('Error updating data: ' + E.Message);
        CustomerCDS.CancelUpdates;
      end;
    end;
  end;
end;

procedure THOSxPLiulinCustomerListForm.cxButton2Click(Sender: TObject);
begin
  if CustomerCDS.RecordCount = 0 then
    Exit;
  ExecuteRTTIFunction
    ('HOSxPLiulinCustomerEntryFormUnit.THOSxPLiulinCustomerEntryForm',
    'DoShowForm', [CustomerCDS, CustomerCDS.FieldByName('liulin_customer_id')
    .AsInteger, False]);
  DoRefreshData;
end;

procedure THOSxPLiulinCustomerListForm.cxButton3Click(Sender: TObject);
begin
  SafeLoadPackage('HOSxPUserManagerPackage.bpl');
  ExecuteRTTIFunction
    ('HOSxPUserManagerLogViewerFormUnit.THOSxPUserManagerLogViewerForm',
    'DoShowForm', ['liulin_customer', '']);
end;

procedure THOSxPLiulinCustomerListForm.cxButton8Click(Sender: TObject);
begin
  if CustomerCDS.RecordCount = 0 then
    Exit;
  DoExportCxGridToExcel(cxGrid1);
end;

procedure THOSxPLiulinCustomerListForm.cxGridDBColumn1GetDisplayText
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := IntToStr(ARecord.Index + 1);
end;

procedure THOSxPLiulinCustomerListForm.cxGridDBTableView1CellDblClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  cxButton3.Click;
end;

procedure THOSxPLiulinCustomerListForm.cxTextEdit1PropertiesChange
  (Sender: TObject);
begin
  // ��ͧ����
  DoSearchCustomer(cxTextEdit1.Text);
end;

class procedure THOSxPLiulinCustomerListForm.DoShowForm;
begin
  FindShowForm(THOSxPLiulinCustomerListForm, '');
end;

end.
