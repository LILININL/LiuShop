unit HOSxPLiulinCustomerListFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinsDefaultPainters, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, StdCtrls, cxButtons, cxControls, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, DBClient;

type
  THOSxPLiulinCustomerListForm = class(TForm)
    cxButton1: TcxButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    CustomerCDS: TClientDataSet;
    DataSource1: TDataSource;
    AddBottom: TcxButton;
    Deletebottom: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  private
    procedure DoRefreshData;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  HOSxPLiulinCustomerListForm: THOSxPLiulinCustomerListForm;

implementation

uses BMSApplicationUtil, HOSxPDMU;
{$R *.dfm}

procedure THOSxPLiulinCustomerListForm.cxButton1Click(Sender: TObject);
begin
  Close;
end;

procedure THOSxPLiulinCustomerListForm.DoRefreshData;
begin
  CustomerCDS.Data := HOSxP_GetDataSet
    ('SELECT liulin_customer_id, liulin_customer_name, customer_tel FROM liulin_customer; ');
end;

procedure THOSxPLiulinCustomerListForm.FormShow(Sender: TObject);
begin
  DoRefreshData;
end;

end.
