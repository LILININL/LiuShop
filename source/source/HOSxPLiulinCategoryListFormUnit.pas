unit HOSxPLiulinCategoryListFormUnit;

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
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxContainer, cxSplitter,
  cxGroupBox, ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel, cxLabel,
  cxTextEdit;

type
  THOSxPLiulinCategoryListForm = class(TForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataSource1: TDataSource;
    CategoryCDS: TClientDataSet;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxTextEdit1: TcxTextEdit;
    cxLabel1: TcxLabel;
    Panel1: TPanel;
    JvPanel1: TJvPanel;
    cxButton4: TcxButton;
    cxButton5: TcxButton;
    cxButton8: TcxButton;
    cxButton9: TcxButton;
    cxButton111: TcxButton;
    cxButton11: TcxButton;
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
    procedure cxTextEdit1PropertiesChange(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton6Click(Sender: TObject);
    procedure cxButton111Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton9Click(Sender: TObject);
    procedure cxGrid1DBTableView1Column1GetDisplayText
      (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGrid1DBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure DoRefreshData;
    procedure DoAddCategory;
    procedure DoEditCategory;
    procedure DoSearchCategory(const AFilter: string);
  public
    { Public declarations }
  end;

var
  HOSxPLiulinCategoryListForm: THOSxPLiulinCategoryListForm;

implementation

uses BMSApplicationUtil, HOSxPDMU, HOSxPLiulinCategoryEntryFormUnit;

{$R *.dfm}

procedure THOSxPLiulinCategoryListForm.cxButton111Click(Sender: TObject);
begin
  close;
end;

procedure THOSxPLiulinCategoryListForm.cxButton4Click(Sender: TObject);
begin
  DoAddCategory;
end;

procedure THOSxPLiulinCategoryListForm.cxButton3Click(Sender: TObject);
begin
  DoSearchCategory(cxTextEdit1.Text);
  DoRefreshData;
end;

procedure THOSxPLiulinCategoryListForm.cxButton5Click(Sender: TObject);
begin
  // export Excel
  if CategoryCDS.RecordCount = 0 then
    Exit;
  DoExportCxGridToExcel(cxGrid1);
end;

procedure THOSxPLiulinCategoryListForm.cxButton8Click(Sender: TObject);
begin
  SafeLoadPackage('HOSxPUserManagerPackage.bpl');
  ExecuteRTTIFunction
    ('HOSxPUserManagerLogViewerFormUnit.THOSxPUserManagerLogViewerForm',
    'DoShowForm', ['liulin_category', '']);
end;

procedure THOSxPLiulinCategoryListForm.cxButton9Click(Sender: TObject);
begin
  DoEditCategory;
end;

procedure THOSxPLiulinCategoryListForm.cxGrid1DBTableView1CellDblClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  cxButton9.Click;
end;

//
procedure THOSxPLiulinCategoryListForm.cxGrid1DBTableView1Column1GetDisplayText
  (Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin

  AText := IntToStr(ARecord.Index + 1);
  // AText := '   ' + AText + ' ';
end;

procedure THOSxPLiulinCategoryListForm.cxButton6Click(Sender: TObject);
begin
  if CategoryCDS.RecordCount = 0 then
    Exit;
  DoExportCxGridToExcel(cxGrid1);
end;

procedure THOSxPLiulinCategoryListForm.cxTextEdit1PropertiesChange
  (Sender: TObject);
begin
  DoSearchCategory(cxTextEdit1.Text);
end;

procedure THOSxPLiulinCategoryListForm.DoRefreshData;
begin
  CategoryCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_category_id, liulin_category_name FROM liulin_category;');
end;

procedure THOSxPLiulinCategoryListForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure THOSxPLiulinCategoryListForm.FormCreate(Sender: TObject);
begin
  DoRefreshData;
end;

procedure THOSxPLiulinCategoryListForm.DoAddCategory;
begin
  THOSxPLiulinCategoryEntryForm.DoShowForm(CategoryCDS, 0, True);
  DoRefreshData;
end;

procedure THOSxPLiulinCategoryListForm.DoEditCategory;
begin
  if CategoryCDS.RecordCount = 0 then
    Exit;
  THOSxPLiulinCategoryEntryForm.DoShowForm(CategoryCDS,
    CategoryCDS.FieldByName('liulin_category_id').AsInteger, False);
  DoRefreshData;
end;

procedure THOSxPLiulinCategoryListForm.DoSearchCategory(const AFilter: string);
begin
  if Trim(AFilter) = '' then
  begin
    DoRefreshData;
  end
  else
  begin
    CategoryCDS.Data := HOSxP_GetDataSet
      ('SELECT liulin_category_id, liulin_category_name FROM liulin_category ' +
      'WHERE liulin_category_name LIKE ''%' + AFilter + '%''');
  end;
end;

end.
