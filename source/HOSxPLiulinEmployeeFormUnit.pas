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
  cxGrid, cxBlobEdit;

type
  THOSxPLiulinEmployeeListForm = class(TForm)
    EmployeeCDS: TClientDataSet;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    Datasouce1: TDataSource;
    procedure FormShow(Sender: TObject);

  private
    procedure DoRefreshData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HOSxPLiulinEmployeeListForm: THOSxPLiulinEmployeeListForm;

implementation

uses BMSApplicationUtil, HOSxPDMU;
{$R *.dfm}
{ THOSxPLiulinEmployeeListForm }

procedure THOSxPLiulinEmployeeListForm.DoRefreshData;

begin
  EmployeeCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_employee_id, liulin_employee_name, liulin_employee_tel FROM liulin_employee; ');
end;

procedure THOSxPLiulinEmployeeListForm.FormShow(Sender: TObject);
begin
  DoRefreshData;
end;

end.
