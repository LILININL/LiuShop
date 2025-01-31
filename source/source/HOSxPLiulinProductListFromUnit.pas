unit HOSxPLiulinProductListFromUnit;

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
  dxScrollbarAnnotations, DB, cxDBData, Menus, StdCtrls, cxButtons,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, DBClient,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxContainer, cxLabel,
  cxTextEdit, cxGroupBox, ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel,
  JvExControls, JvNavigationPane;

type
  THOSxPLiulinProductListFrom = class(TForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataSource1: TDataSource;
    ProductCDS: TClientDataSet;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    cxGrid1DBTableView1Column6: TcxGridDBColumn;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxTextEdit1: TcxTextEdit;
    Panel2: TPanel;
    cxButton666: TcxButton;
    cxButton7: TcxButton;
    cxButton8: TcxButton;
    JvNavPanelHeader1: TJvNavPanelHeader;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxButton4: TcxButton; // ��ͧ����
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure PropertiesChange(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton666Click(Sender: TObject);
    procedure cxGrid1DBTableView1Column1GetDisplayText
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGrid1DBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    procedure DoRefreshData;
    procedure DoSearchProduct(const AFilter: string);
  public
    class procedure DoShowForm;
  end;

var
  HOSxPLiulinProductListFrom: THOSxPLiulinProductListFrom;

implementation

uses BMSApplicationUtil, HOSxPDMU, HOSxPLiulinProductEntryFormUnit;

{$R *.dfm}
{ THOSxPLiulinTypeListFrom }

procedure THOSxPLiulinProductListFrom.cxButton1Click(Sender: TObject);
begin
  ExecuteRTTIFunction
    ('HOSxPLiulinProductEntryFormUnit.THOSxPLiulinProductEntryForm',
    'DoShowForm', [ProductCDS, 0, True]);
  DoRefreshData;
end;

procedure THOSxPLiulinProductListFrom.cxButton2Click(Sender: TObject);
begin
  if ProductCDS.RecordCount = 0 then
    Exit;
  ExecuteRTTIFunction
    ('HOSxPLiulinProductEntryFormUnit.THOSxPLiulinProductEntryForm',
    'DoShowForm', [ProductCDS, ProductCDS.FieldByName('liulin_product_id')
    .AsInteger, False]);
  DoRefreshData;
end;

procedure THOSxPLiulinProductListFrom.cxButton3Click(Sender: TObject);
begin
  if ProductCDS.RecordCount = 0 then
    Exit;
  DoExportCxGridToExcel(cxGrid1);
end;

procedure THOSxPLiulinProductListFrom.cxButton4Click(Sender: TObject);
begin
  SafeLoadPackage('HOSxPUserManagerPackage.bpl');
  ExecuteRTTIFunction
    ('HOSxPUserManagerLogViewerFormUnit.THOSxPUserManagerLogViewerForm',
    'DoShowForm', ['liulin_product', '']);
end;

procedure THOSxPLiulinProductListFrom.cxButton5Click(Sender: TObject);
begin
  // ��������
  DoSearchProduct(cxTextEdit1.Text);
end;

procedure THOSxPLiulinProductListFrom.cxButton666Click(Sender: TObject);
begin
  Close;
end;

procedure THOSxPLiulinProductListFrom.cxGrid1DBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
cxButton8.Click;
end;

procedure THOSxPLiulinProductListFrom.cxGrid1DBTableView1Column1GetDisplayText
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := IntToStr(ARecord.Index + 1);
end;

class procedure THOSxPLiulinProductListFrom.DoShowForm;
begin
  FindShowForm(THOSxPLiulinProductListFrom, '');
end;

procedure THOSxPLiulinProductListFrom.DoRefreshData;
begin
  ProductCDS.Data := HOSxP_GetDataSet('SELECT ' + '    p.liulin_product_id, ' +
    '    p.liulin_product_name, ' + '    p.liulin_product_price, ' +
    '    c.liulin_category_name, ' + '    s.liulin_supplier_name, ' +
    '    t.liulin_type_name, ' + '    p.liulin_category_id, ' +
    '    p.liulin_supplier_id, ' + '    p.liulin_type_id ' + 'FROM ' +
    '    liulin_product p ' + 'LEFT JOIN ' +
    '    liulin_category c ON p.liulin_category_id = c.liulin_category_id ' +
    'LEFT JOIN ' +
    '    liulin_supplier s ON p.liulin_supplier_id = s.liulin_supplier_id ' +
    'LEFT JOIN ' + '    liulin_type t ON p.liulin_type_id = t.liulin_type_id;');
end;

procedure THOSxPLiulinProductListFrom.DoSearchProduct(const AFilter: string);
begin
  if Trim(AFilter) = '' then
  begin
    DoRefreshData;
  end
  else
  begin
    ProductCDS.Data := HOSxP_GetDataSet('SELECT ' + '    p.liulin_product_id, '
      + '    p.liulin_product_name, ' + '    p.liulin_product_price, ' +
      '    c.liulin_category_name, ' + '    s.liulin_supplier_name, ' +
      '    t.liulin_type_name, ' + '    p.liulin_category_id, ' +
      '    p.liulin_supplier_id, ' + '    p.liulin_type_id ' + 'FROM ' +
      '    liulin_product p ' + 'LEFT JOIN ' +
      '    liulin_category c ON p.liulin_category_id = c.liulin_category_id ' +
      'LEFT JOIN ' +
      '    liulin_supplier s ON p.liulin_supplier_id = s.liulin_supplier_id ' +
      'LEFT JOIN ' + '    liulin_type t ON p.liulin_type_id = t.liulin_type_id '
      + 'WHERE ' + '    p.liulin_product_name LIKE ''%' + AFilter + '%'' OR ' +
      '    c.liulin_category_name LIKE ''%' + AFilter + '%'' OR ' +
      '    s.liulin_supplier_name LIKE ''%' + AFilter + '%'' OR ' +
      '    t.liulin_type_name LIKE ''%' + AFilter + '%''');
  end;
end;

procedure THOSxPLiulinProductListFrom.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure THOSxPLiulinProductListFrom.FormCreate(Sender: TObject);
begin
  DoRefreshData;
end;

procedure THOSxPLiulinProductListFrom.FormShow(Sender: TObject);
begin
  DoRefreshData;
end;

procedure THOSxPLiulinProductListFrom.PropertiesChange(Sender: TObject);
begin
  // ��ͧ����
  DoSearchProduct(cxTextEdit1.Text);
end;

end.
