unit uDashBoard;

interface

uses
  System.DateUtils,
  System.StrUtils,
  dxSpreadSheet,
  dxSpreadSheetTypes,
  cxExportPivotGridLink,
  cxGridDBDataDefinitions,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinOffice2013White,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.ExtCtrls, cxContainer, cxLabel, dxGDIPlusClasses, Vcl.ComCtrls, dxCore,
  cxDateUtils, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxGridBandedTableView, cxGridDBBandedTableView,
  Vcl.Grids, Vcl.DBGrids, dxBarBuiltInMenu, cxPC, FireDAC.Comp.ScriptCommands,
  FireDAC.Comp.Script, cxCheckBox, cxGridExportLink, cxCustomPivotGrid,
  cxDBPivotGrid, cxButtonEdit, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, cxCurrencyEdit, Math;

type
  TfrmExibeDashBoard = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    FDQueryForecast: TFDQuery;
    FDConnection: TFDConnection;
    DSForecast: TDataSource;
    cxButtonRefresh: TcxButton;
    Page: TcxPageControl;
    TabForecast: TcxTabSheet;
    cxGridTargetAno: TcxGrid;
    cxGridTargetAnoDBBandedTableView1: TcxGridDBBandedTableView;
    cxGridTargetAnoLevel1: TcxGridLevel;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    FDQueryTSOP_Budget: TFDQuery;
    FDQueryTSOP_BudgetTSOP_BUDCOD: TFDAutoIncField;
    FDQueryTSOP_BudgetTSOP_BUDTIP: TStringField;
    FDQueryTSOP_BudgetTSOP_BUDDATREF: TSQLTimeStampField;
    FDQueryTSOP_BudgetTSOP_BUDDAT: TSQLTimeStampField;
    FDQueryTSOP_BudgetTSOP_BUDCLICOD: TStringField;
    FDQueryTSOP_BudgetTSOP_BUDVLF: TBCDField;
    FDQueryTSOP_BudgetTSOP_BUDFAM: TStringField;
    FDQueryTSOP_BudgetTSOP_ORDBILSITNOM: TStringField;
    FDQueryTSOP_BudgetTSOP_USUCOD: TIntegerField;
    FDQueryTSOP_BudgetTSOP_BUDDATCAD: TSQLTimeStampField;
    sqlAux: TFDQuery;
    lblAno: TcxLabel;
    FDScript: TFDScript;
    chkVendedor: TcxCheckBox;
    ButExcel: TcxButton;
    SaveDialog: TSaveDialog;
    FDQueryDet: TFDQuery;
    DSDet: TDataSource;
    FDQueryDetTSOP_BUDCOD: TFDAutoIncField;
    FDQueryDetTSOP_BUDTIP: TStringField;
    FDQueryDetTSOP_BUDDATREF: TSQLTimeStampField;
    FDQueryDetTSOP_BUDDAT: TSQLTimeStampField;
    FDQueryDetTSOP_BUDCLICOD: TStringField;
    FDQueryDetTSOP_BUDVLF: TBCDField;
    FDQueryDetTSOP_BUDFAM: TStringField;
    FDQueryDetTSOP_ORDBILSITNOM: TStringField;
    FDQueryDetTSOP_USUCOD: TIntegerField;
    FDQueryDetTSOP_BUDDATCAD: TSQLTimeStampField;
    FDQueryDetTSIS_USUNOM: TStringField;
    cxStyleRepository1: TcxStyleRepository;
    cxStyleData: TcxStyle;
    dsFDStoredProc: TDataSource;
    TabTarget: TcxTabSheet;
    TabPedidos: TcxTabSheet;
    cxDBPivotGrid00: TcxDBPivotGrid;
    cxDBPivotGrid00FieldTSOP_ORDBILCANNOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_ORDBILGRUCLINOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_ORDBILREPNOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_ORDBILSITNOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldBILLING: TcxDBPivotGridField;
    cxDBPivotGrid00FieldVARIACAO_PORC: TcxDBPivotGridField;
    cxDBPivotGrid00Field_REAL: TcxDBPivotGridField;
    cxDBPivotGrid1: TcxDBPivotGrid;
    cxDBPivotGridFieldTSOP_ORDBILCANNOM: TcxDBPivotGridField;
    cxDBPivotGridFieldTSOP_ORDBILGRUCLINOM: TcxDBPivotGridField;
    cxDBPivotGridFieldTSOP_ORDBILREPNOM: TcxDBPivotGridField;
    cxDBPivotGridFieldTSOP_ORDBILSITNOM: TcxDBPivotGridField;
    cxDBPivotGridFieldAct_Fcst: TcxDBPivotGridField;
    cxDBPivotGridFieldTARGET: TcxDBPivotGridField;
    cxDBPivotGridFieldVARIACAO_PORC_TARGET: TcxDBPivotGridField;
    cxDBPivotGridFieldVARIACAO_REAL_TARGET: TcxDBPivotGridField;
    cxDBPivotGrid2: TcxDBPivotGrid;
    FDStoredProc2: TFDStoredProc;
    dsFDStoredProc2: TDataSource;
    FDStoredProc2TSOP_ORDBILREPNOM: TStringField;
    FDStoredProc2TSOP_ORDBILGRUCLINOM: TStringField;
    FDStoredProc2TSOP_ORDBILCANNOM: TStringField;
    FDStoredProc2TSOP_ORDBILSITNOM: TStringField;
    FDStoredProc2Actual: TFMTBCDField;
    FDStoredProc2Backlog: TFMTBCDField;
    FDStoredProc2Billing: TFMTBCDField;
    FDStoredProc2GrossMargin: TFMTBCDField;
    FDStoredProc2SalesFCST: TFMTBCDField;
    cxDBPivotGrid2TSOP_ORDBILREPNOM: TcxDBPivotGridField;
    cxDBPivotGrid2TSOP_ORDBILCANNOM: TcxDBPivotGridField;
    cxDBPivotGrid2TSOP_ORDBILSITNOM: TcxDBPivotGridField;
    cxDBPivotGrid2TSOP_ORDBILGRUCLINOM: TcxDBPivotGridField;
    cxDBPivotGrid2Actual: TcxDBPivotGridField;
    cxDBPivotGrid2SalesFCT: TcxDBPivotGridField;
    cxDBPivotGrid2Billing: TcxDBPivotGridField;
    cxDBPivotGrid2Backlog: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_BUDCLICOD: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_ORDBILCLINOM: TcxDBPivotGridField;
    cxDBPivotGrid1FieldTSOP_BUDCLICOD: TcxDBPivotGridField;
    cxDBPivotGrid1FieldTSOP_ORDBILCLINOM: TcxDBPivotGridField;
    FDStoredProc2BacklogTotal: TFMTBCDField;
    cxDBPivotGrid2BacklogTotal: TcxDBPivotGridField;
    DtInicial: TDateTimePicker;
    FDStoredProc: TFDStoredProc;
    FDStoredProcTSOP_ORDBILREPNOM: TStringField;
    FDStoredProcTSOP_BUDCLICOD: TStringField;
    FDStoredProcTSOP_ORDBILGRUCLINOM: TStringField;
    FDStoredProcTSOP_ORDBILCLINOM: TStringField;
    FDStoredProcTSOP_ORDBILCANNOM: TStringField;
    FDStoredProcTSOP_ORDBILSITNOM: TStringField;
    FDStoredProcBILLING: TBCDField;
    FDStoredProcFORECAST: TBCDField;
    FDStoredProcVARIACAO_REAL: TBCDField;
    FDStoredProcVARIACAO_PORC: TFMTBCDField;
    FDStoredProcAct_Fcst: TBCDField;
    FDStoredProcTARGET: TBCDField;
    FDStoredProcVARIACAO_REAL_TARGET: TBCDField;
    FDStoredProcVARIACAO_PORC_TARGET: TFMTBCDField;
    TabGM: TcxTabSheet;
    DataSourceGM_Cliente: TDataSource;
    FDQueryVSOP_OrderBilling00: TFDQuery;
    FDQueryVSOP_OrderBilling00SITE: TStringField;
    FDQueryVSOP_OrderBilling00CANAL: TStringField;
    FDQueryVSOP_OrderBilling00COD_CLIENTE: TStringField;
    FDQueryVSOP_OrderBilling00RAZAO_SOCIAL: TStringField;
    FDQueryVSOP_OrderBilling00GRUPO_CLIENTE: TStringField;
    FDQueryVSOP_OrderBilling00ACC_OWNER: TStringField;
    FDQueryVSOP_OrderBilling00COD_ITEM: TStringField;
    cxDBPivotGrid3: TcxDBPivotGrid;
    cxDBPivotGridFieldCANAL: TcxDBPivotGridField;
    cxDBPivotGridFieldGRUPO_CLIENTE: TcxDBPivotGridField;
    cxDBPivotGridFieldACC_OWNER: TcxDBPivotGridField;
    cxDBPivotGridFieldSITE: TcxDBPivotGridField;
    cxDBPivotGridFieldTOTAL_VENDAS_QTD: TcxDBPivotGridField;
    cxDBPivotGridFieldNET_SALE: TcxDBPivotGridField;
    cxDBPivotGridFieldGM_VALOR: TcxDBPivotGridField;
    cxDBPivotGridFieldGM_PERCENTUAL: TcxDBPivotGridField;
    cxDBPivotGridFieldCOD_CLIENTE: TcxDBPivotGridField;
    cxDBPivotGridFieldCOD_ITEM: TcxDBPivotGridField;
    FDStoredProcTSOP_ORDBILREG: TStringField;
    FDStoredProcTSOP_ORDBILREGEST: TStringField;
    FDStoredProcTSOP_GRUCLIMER: TStringField;
    FDStoredProcTSOP_ORDBILITEFAM: TStringField;
    cxDBPivotGrid00FieldTSOP_ORDBILREG: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_ORDBILREGEST: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_GRUCLIMER: TcxDBPivotGridField;
    cxDBPivotGrid1FieldTSOP_ORDBILREG: TcxDBPivotGridField;
    cxDBPivotGrid1FieldTSOP_ORDBILREGEST: TcxDBPivotGridField;
    cxDBPivotGrid1FieldTSOP_GRUCLIMER: TcxDBPivotGridField;
    FDStoredProc2TSOP_ORDBILREG: TStringField;
    FDStoredProc2TSOP_ORDBILREGEST: TStringField;
    FDStoredProc2TSOP_GRUCLIMER: TStringField;
    cxDBPivotGrid2FieldTSOP_ORDBILREG: TcxDBPivotGridField;
    cxDBPivotGrid2FieldTSOP_ORDBILREGEST: TcxDBPivotGridField;
    cxDBPivotGrid2FieldTSOP_GRUCLIMER: TcxDBPivotGridField;
    FDQueryVSOP_OrderBilling00Regi�o: TStringField;
    FDQueryVSOP_OrderBilling00UF: TStringField;
    FDQueryVSOP_OrderBilling00UoM: TStringField;
    cxDBPivotGrid3FieldRegi�o: TcxDBPivotGridField;
    cxDBPivotGrid3FieldUF: TcxDBPivotGridField;
    cxStyleRepository2: TcxStyleRepository;
    NegativeStyle: TcxStyle;
    PositiveStyle: TcxStyle;
    cxDBPivotGrid3FieldUoM: TcxDBPivotGridField;
    cxDBPivotGridForecast: TcxDBPivotGridField;
    FDQueryVSOP_OrderBilling00Periodo: TDateField;
    cxDBPivotGrid3Periodo: TcxDBPivotGridField;
    FDQueryVSOP_OrderBilling00TOTAL_VENDAS_QTD: TBCDField;
    FDQueryVSOP_OrderBilling00NET_SALE: TBCDField;
    FDQueryVSOP_OrderBilling00GM_VALOR: TBCDField;
    cxStyleRepository3: TcxStyleRepository;
    stlRed: TcxStyle;
    cxGridPedidoDBTableView1: TcxGridDBTableView;
    cxGridPedidoLevel1: TcxGridLevel;
    cxGridPedido: TcxGrid;
    cxGridPedidoDBTableView1TSOP_ORDBILREPNOM: TcxGridDBColumn;
    cxGridPedidoDBTableView1TSOP_ORDBILGRUCLINOM: TcxGridDBColumn;
    cxGridPedidoDBTableView1TSOP_ORDBILCANNOM: TcxGridDBColumn;
    cxGridPedidoDBTableView1TSOP_ORDBILSITNOM: TcxGridDBColumn;
    cxGridPedidoDBTableView1Actual: TcxGridDBColumn;
    cxGridPedidoDBTableView1Backlog: TcxGridDBColumn;
    cxGridPedidoDBTableView1Billing: TcxGridDBColumn;
    cxGridPedidoDBTableView1GrossMargin: TcxGridDBColumn;
    cxGridPedidoDBTableView1SalesFCST: TcxGridDBColumn;
    cxGridPedidoDBTableView1BacklogTotal: TcxGridDBColumn;
    cxGridPedidoDBTableView1TSOP_ORDBILREG: TcxGridDBColumn;
    cxGridPedidoDBTableView1TSOP_ORDBILREGEST: TcxGridDBColumn;
    cxGridPedidoDBTableView1TSOP_GRUCLIMER: TcxGridDBColumn;
    cxGridForecastAnoDBTableView1: TcxGridDBTableView;
    cxGridForecastAnoLevel1: TcxGridLevel;
    cxGridForecastAno: TcxGrid;
    cxGridForecastAnoDBTableView1TSOP_ORDBILREPNOM: TcxGridDBColumn;
    cxGridForecastAnoDBTableView1TSOP_BUDCLICOD: TcxGridDBColumn;
    cxGridForecastAnoDBTableView1TSOP_ORDBILGRUCLINOM: TcxGridDBColumn;
    cxGridForecastAnoDBTableView1TSOP_ORDBILCLINOM: TcxGridDBColumn;
    cxGridForecastAnoDBTableView1TSOP_ORDBILCANNOM: TcxGridDBColumn;
    cxGridForecastAnoDBTableView1TSOP_ORDBILSITNOM: TcxGridDBColumn;
    cxGridForecastAnoDBTableView1Act_Fcst: TcxGridDBColumn;
    cxGridForecastAnoDBTableView1TARGET: TcxGridDBColumn;
    cxGridForecastAnoDBTableView1TSOP_ORDBILREG: TcxGridDBColumn;
    cxGridForecastAnoDBTableView1TSOP_ORDBILREGEST: TcxGridDBColumn;
    cxGridForecastAnoDBTableView1TSOP_GRUCLIMER: TcxGridDBColumn;
    cxGridForecastAnoDBTableView1TSOP_ORDBILITEFAM: TcxGridDBColumn;
    cxGridGmClienteDBTableView1: TcxGridDBTableView;
    cxGridGmClienteLevel1: TcxGridLevel;
    cxGridGmCliente: TcxGrid;
    cxGridGmClienteDBTableView1SITE: TcxGridDBColumn;
    cxGridGmClienteDBTableView1CANAL: TcxGridDBColumn;
    cxGridGmClienteDBTableView1COD_CLIENTE: TcxGridDBColumn;
    cxGridGmClienteDBTableView1RAZAO_SOCIAL: TcxGridDBColumn;
    cxGridGmClienteDBTableView1GRUPO_CLIENTE: TcxGridDBColumn;
    cxGridGmClienteDBTableView1ACC_OWNER: TcxGridDBColumn;
    cxGridGmClienteDBTableView1COD_ITEM: TcxGridDBColumn;
    cxGridGmClienteDBTableView1Regio: TcxGridDBColumn;
    cxGridGmClienteDBTableView1UF: TcxGridDBColumn;
    cxGridGmClienteDBTableView1UoM: TcxGridDBColumn;
    cxGridGmClienteDBTableView1Periodo: TcxGridDBColumn;
    cxGridGmClienteDBTableView1TOTAL_VENDAS_QTD: TcxGridDBColumn;
    cxGridGmClienteDBTableView1NET_SALE: TcxGridDBColumn;
    cxGridGmClienteDBTableView1GM_VALOR: TcxGridDBColumn;
    cxGridGmClienteDBTableView1GM_PERCENTUAL: TcxGridDBColumn;
    cxGridTargetAnoDBBandedTableView1TSOP_ORDBILREPNOM: TcxGridDBBandedColumn;
    cxGridTargetAnoDBBandedTableView1TSOP_BUDCLICOD: TcxGridDBBandedColumn;
    cxGridTargetAnoDBBandedTableView1TSOP_ORDBILGRUCLINOM: TcxGridDBBandedColumn;
    cxGridTargetAnoDBBandedTableView1TSOP_ORDBILCLINOM: TcxGridDBBandedColumn;
    cxGridTargetAnoDBBandedTableView1TSOP_ORDBILCANNOM: TcxGridDBBandedColumn;
    cxGridTargetAnoDBBandedTableView1TSOP_ORDBILSITNOM: TcxGridDBBandedColumn;
    cxGridTargetAnoDBBandedTableView1BILLING: TcxGridDBBandedColumn;
    cxGridTargetAnoDBBandedTableView1FORECAST: TcxGridDBBandedColumn;
    cxGridTargetAnoDBBandedTableView1VARIACAO_REAL: TcxGridDBBandedColumn;
    cxGridTargetAnoDBBandedTableView1VARIACAO_PORC: TcxGridDBBandedColumn;
    cxGridTargetAnoDBBandedTableView1TSOP_ORDBILREG: TcxGridDBBandedColumn;
    cxGridTargetAnoDBBandedTableView1TSOP_ORDBILREGEST: TcxGridDBBandedColumn;
    cxGridTargetAnoDBBandedTableView1TSOP_GRUCLIMER: TcxGridDBBandedColumn;
    FDQueryVSOP_OrderBilling00GM_PERCENTUAL: TFMTBCDField;
    cxButtonEditPath: TcxButtonEdit;
    cxLabel2: TcxLabel;
    cbxMeses: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButtonRefreshClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cxButton1Click(Sender: TObject);
    procedure ButExcelClick(Sender: TObject);
    procedure cxGridTargetAnoDBBandedTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure PageChange(Sender: TObject);
    procedure cxDBPivotGrid00StylesGetContentStyle(Sender: TcxCustomPivotGrid;
      ACell: TcxPivotGridDataCellViewInfo; var AStyle: TcxStyle);
    procedure cxDBPivotGrid1StylesGetContentStyle(Sender: TcxCustomPivotGrid;
      ACell: TcxPivotGridDataCellViewInfo; var AStyle: TcxStyle);
    procedure cxDBPivotGrid2StylesGetContentStyle(Sender: TcxCustomPivotGrid;
      ACell: TcxPivotGridDataCellViewInfo; var AStyle: TcxStyle);
    procedure cxButtonEditPathClick(Sender: TObject);
    procedure cxDBPivotGridFieldGM_PERCENTUALCalculateCustomSummary(
      Sender: TcxPivotGridField; ASummary: TcxPivotGridCrossCellSummary);
    procedure cxDBPivotGrid3StylesGetContentStyle(Sender: TcxCustomPivotGrid;
      ACell: TcxPivotGridDataCellViewInfo; var AStyle: TcxStyle);
  private
    { Private declarations }
    dxSpreadSheet : TdxSpreadSheet;
    NumeroLinhasGrid : Integer;
    ABand  : TcxGridBand;
    iContaGrupo : Integer;
    Edit : Array  of TEdit;
    lblTotal : Array of TLabel;

    LblForecast : Array of TLabel;
    LblCodigo   : Array of TLabel;
    LblNome    : Array of TLabel;
    varMedia : Array of Currency;

    LblTitulo, LblMedia : Array of TLabel;
    varMesesArrayB, varMesesArrayF : Array of TDateTime;

    lstMeses : TStringList;

    varMesesComLabel,  varMesesComLabelB, varMesesComLabelF, varMesesSemLabelB, varMesesSemLabelF, varMesesSomaLinha : WideString;
    varDtInicial, varDtFinal : TDateTime;
    procedure Mensagem(pMensagem: String);
    function MontaStringMes(bMostraLabel : Boolean; Alias : String; Tipo : String; SomarL : Boolean) : WideString;
    function BuscaMes(Data: TDateTime; bLabel : Boolean; Alias : String; SomarLinha : Boolean) : String;
    function TrataDataHint (varData : String) : String;
    procedure KeyPressProc(Sender: TObject; var Key: Char);
    procedure Summarize(ASummary: TcxDataSummary; AColumn: TcxGridDBBandedColumn;
      AKind: TcxSummaryKind; AFormat: string);
//    procedure CriarGrid;
    function  ContaGrupo(pGrupo, pVendedor : String) : Integer;
    procedure LimparTelaDinamica;
    function LeftPad(value: integer; length: integer=2; pad: char='0'): string;

    function MontaDataDashBoard(DataAtual : TDateTime; bForecast : Boolean; bForecastDataFinal : Boolean; bPeriodoTodo : Boolean) : TDateTime;
    procedure Exportar_GMCliente;

  public
    { Public declarations }
     procedure AbrirDataset;
     procedure AbrirDataSet2;
     procedure AbrirDataSet3;
  end;

type
  TStringGridHack = class(TStringGrid)
  protected
    procedure DeleteRow(ARow: Longint); reintroduce;
    procedure InsertRow(ARow: Longint);
  end;

var
  frmExibeDashBoard: TfrmExibeDashBoard;

implementation

{$R *.dfm}

uses uUtils, uBrady;

procedure TfrmExibeDashBoard.Mensagem(pMensagem: String);
begin
  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;
end;

function TfrmExibeDashBoard.MontaDataDashBoard(DataAtual: TDateTime; bForecast : Boolean; bForecastDataFinal : Boolean; bPeriodoTodo : Boolean): TDateTime;
var
 Ano, Mes, Dia: Word;
 MesFiscal, MesAbrev : String;
 varData : string;
begin

   //2019-03-17

   DecodeDate(DataAtual, Ano, Mes, Dia);


   if ((bForecast = False) and (bForecastDataFinal = False)) then // monta data inicial de billing
   begin
     if Mes < 8 then
       Ano := Ano - 1;

     varData := '01/08/' +  VarToStr(Ano);
   end
   else    if ((bForecast = True) and (bForecastDataFinal = False)) then    // monta data inicial de forecast
   begin


    if ((Mes < 8) and (bPeriodoTodo = false)) then
      Mes := Mes + 1;

     varData := '01/' + VarToStr(Mes) +'/' +  VarToStr(Ano);


   end;

   if bForecastDataFinal = True then    // monta data final de forecast
   begin

    if ((Mes >= 7) and (bPeriodoTodo = False)) then
      Ano := Ano + 1;

     varData :=  '01/07/' + VarToStr(Ano);
   end;
   result :=  StrToDate(varData);


   {

   if ((bForecast = False) and (bForecastDataFinal = False)) then // monta data inicial de billing
   begin
     if Mes < 8 then
       Ano := Ano - 1;

     varData := '01/08/' +  VarToStr(Ano);
   end
   else    if ((bForecast = True) and (bForecastDataFinal = False)) then    // monta data inicial de forecast
   begin

    if ((Mes < 8) and (bPeriodoTodo = false)) then
      Mes := Mes + 1;

     varData := '01/' + VarToStr(Mes) +'/' +  VarToStr(Ano);


   end;

   if bForecastDataFinal = True then    // monta data final de forecast
   begin

    if ((Mes >= 7) and (bPeriodoTodo = False)) then
      Ano := Ano + 1;

     varData :=  '01/07/' + VarToStr(Ano);
   end;
   result :=  StrToDate(varData);
   }
end;

function TfrmExibeDashBoard.MontaStringMes(bMostraLabel : Boolean; Alias : String; Tipo : String; SomarL : Boolean): WideString;
var
 I            : Integer;
 NovaData     : TDateTime;
 varResultado : String;
begin
  SetLength(varMesesArrayB, 12);
  SetLength(varMesesArrayF, 13);

  NovaData := System.DateUtils.StartOfTheMonth(dtInicial.Date);

  if ((Alias = '')or (Alias = 'B'))  and (Tipo = 'B') then
    NovaData     :=  IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -12);

  varResultado := '';
  if ((Alias = '')or (Alias = 'B')) and (Tipo = 'B') then
  begin
    for I := 0 to 11 do
    begin
      varMesesArrayB[I] := NovaData;
      varResultado      := varResultado + BuscaMes(NovaData, bMostraLabel,Alias,SomarL);
      NovaData          := IncMonth(NovaData,1);
    end;
  end
  else
  begin
    for I := 0 to 12 do
    begin
      varMesesArrayF[I] := NovaData;
      varResultado      := varResultado + BuscaMes(NovaData, bMostraLabel,Alias, SomarL);
      NovaData          := IncMonth(NovaData,1);
    end;
  end;

  result := varResultado;
end;


procedure TfrmExibeDashBoard.PageChange(Sender: TObject);
begin
{  DtInicial.Visible := Page.ActivePage <> TabGM;
  cbxMeses.Visible  := Page.ActivePage = TabGM;
  if DtInicial.Visible then lblAno.Caption := 'M�s/Ano:' else   lblAno.Caption := 'Ano:';
 }
end;

procedure TfrmExibeDashBoard.AbrirDataSet2;
var
  varDataReferencia: TDateTime;
  varCurrentMonth: Integer;
  varSQL , varInicialBill, varFinalBill, varAnteriorFor, varInicialFor, varFinalFor: TDateTime;

  varNow : TDateTime;

  I : Integer;
  varMesesB, varMesesF : Integer;
  varResultado : String;
  pStoredProc : TFDStoredProc;

begin
  Mensagem( 'Abrindo conex�o...' );
  try

    if not FDConnection.Connected then
    begin

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

    end;

    Mensagem( 'Obtendo dados Email Diario...' );

    varNow :=  DtInicial.Date;

    try
      FDStoredProc2.Close;
      FDStoredProc2.Connection := FDConnection;
      FDStoredProc2.StoredProcName := AnsiUpperCase( 'PSOP_DASHBOARD2' );
      for I := 0 to FDStoredProc2.Params.Count-1 do
        FDStoredProc2.Params.ClearValues(i);

      FDStoredProc2.Prepare;
    except
      on E : Exception do
        begin
          MessageDlg( 'Stored procedure error: ' + #13 + #13 +
                       E.Message, mtError, [ mbOk ], 0 );
        end;
    end;

    try



      FDStoredProc2.ParamByName( '@MES_INI' ).AsString := FormatDateTime('yyyy-mm-dd 00:00:00', System.DateUtils.StartOfTheMonth(varNow));
      FDStoredProc2.ParamByName( '@MES_FIM' ).AsString := FormatDateTime('yyyy-mm-dd 00:00:00', System.DateUtils.EndOfTheMonth(varNow));

      FDStoredProc2.ParamByName( '@MES_ANT' ).AsString := FormatDateTime('yyyy-mm-dd 00:00:00', System.DateUtils.StartOfTheMonth(System.DateUtils.StartOfTheMonth(varNow)-1));
      //FDQueryVSOP_OrderBillingPedidos.ParamByName( 'MES_ANT' ).AsDateTime := System.DateUtils.StartOfTheMonth(System.DateUtils.StartOfTheMonth(varNow));
      FDStoredProc2.ParamByName( '@SALESREP' ).isNull;

      if System.DateUtils.MonthOf(varNow) >= 8 then
        FDStoredProc2.ParamByName( '@YEARDOC' ).AsString :=  IntToStr(System.DateUtils.YearOf(varNow) + 1)
      else
        FDStoredProc2.ParamByName( '@YEARDOC' ).AsString :=  IntToStr(System.DateUtils.YearOf(varNow));

      if System.DateUtils.MonthOf(varNow) >= 8 then
        FDStoredProc2.ParamByName( '@MONTHDOC' ).AsString := IntToStr(System.DateUtils.MonthOf(varNow) - 7)
      else
        FDStoredProc2.ParamByName( '@MONTHDOC' ).AsString := IntToStr(System.DateUtils.MonthOf(varNow) + 5);

    //  FDStoredProc.ParamByName( '@MES_INI' ).AsString      := FormatDateTime('yyyy-mm-dd 00:00:00', varInicialBill);
    //  FDStoredProc.ParamByName( '@MES_FIM' ).AsString      := FormatDateTime('yyyy-mm-dd 00:00:00', varFinalBill);

      if ((Fr_Brady.SalesRep) or (chkVendedor.Checked)) then
        FDStoredProc2.ParamByName( '@VENDEDOR' ).AsString   := Fr_Brady.TSIS_USUNOM
      else  FDStoredProc2.ParamByName( '@VENDEDOR' ).IsNull;

      FDStoredProc2.Open;
       
    except
      on E : Exception do
        begin
          MessageDlg( 'Stored procedure error: ' + #13 + #13 +
                       E.Message, mtError, [ mbOk ], 0 );
        end;
    end;

  finally
     Mensagem( EmptyStr );
  end;

end;

procedure TfrmExibeDashBoard.AbrirDataSet3;
var
 varDataInicio, varDataFim, AnoFiscal : TDateTime;
 Idx: Integer;
begin   

  Mensagem( 'Abrindo conex�o...' );
  try

    if not FDConnection.Connected then
    begin

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

    end;

  Try

       varDataInicio := MontaDataDashBoard(DtInicial.Date, False, False, false);              
       varDataFim    := MontaDataDashBoard(varDataInicio, False, True, false); 
    
       if System.DateUtils.MonthOf(DtInicial.Date) >= 8 then
          AnoFiscal := System.DateUtils.YearOf(DtInicial.Date) + 1;
          
    
       if AnoFiscal >= System.DateUtils.YearOf(DtInicial.Date) then
       begin
          varDataFim := System.DateUtils.StartOfTheMonth(Now);
          sqlAux.Close;
          sqlAux.SQL.Clear;
          sqlAux.SQL.Add('Select * From TSOP_LiberarConsGM Where DataProcessamento = :DataProcessamento');
          sqlAux.Params.ParamByName('DataProcessamento').AsDate :=  IncMonth(varDataFim,-1);
          sqlAux.Open;
          if ((sqlAux.IsEmpty) or (sqlAux.FieldByName('Liberar').AsInteger = 0)) then
             varDataFim := System.DateUtils.EndOfTheMonth(IncMonth(varDataFim,-1));
       end;
      
      FDQueryVSOP_OrderBilling00.Close;
      Mensagem( 'Obtendo dados (Gross Margin)...' );
      FDQueryVSOP_OrderBilling00.ParamByName( 'DATAINI' ).AsDateTime := varDataInicio;
      FDQueryVSOP_OrderBilling00.ParamByName( 'DATAFIM' ).AsDateTime := varDataFim;


      if ((chkVendedor.Checked) or (Fr_Brady.SalesRep)) then
       FDQueryVSOP_OrderBilling00.MacroByName( 'WHERE' ).AsRaw := ' AND D01.TSOP_REPNOM = ' +  QuotedStr(Fr_Brady.TSIS_USUNOM);

      FDQueryVSOP_OrderBilling00.Open;

    except
      on E : Exception do
        begin
          MessageDlg( 'Stored procedure error: ' + #13 + #13 +
                       E.Message, mtError, [ mbOk ], 0 );
        end;
    end;


  finally

    Mensagem( EmptyStr );

  end;


end;

function TfrmExibeDashBoard.BuscaMes(Data: TDateTime; bLabel : Boolean; Alias : String; SomarLinha : Boolean) : String;
var
 Ano, Mes, Dia: Word;
 MesFiscal, MesAbrev : String;
 strFormatDate : string;
begin
   DecodeDate(Data, Ano, Mes, Dia);
   MesAbrev := formatdatetime('mmm', Data);

   MesAbrev := StringReplace(MesAbrev,'dez','Dec',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'set','Sep',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'abr','Apr',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'ago','Aug',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'mai','May',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'out','Oct',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'fev','Feb',[rfReplaceAll, rfIgnoreCase]);

   strFormatDate :=  '[' + MesAbrev  + ' ' + IntToStr(Ano)  +  ']';



   if bLabel then
   begin
     Case Mes Of
         1   : MesFiscal := strFormatDate + ','; // + ' AS JANEIRO,' ;
         2   : MesFiscal := strFormatDate + ','; // + ' AS FEVEREIRO,' ;
         3   : MesFiscal := strFormatDate + ','; // + ' AS MAR�O,' ;
         4   : MesFiscal := strFormatDate + ','; // + ' AS ABRIL,' ;
         5   : MesFiscal := strFormatDate + ','; // + ' AS MAIO,' ;
         6   : MesFiscal := strFormatDate + ','; // + ' AS JUNHO,' ;
         7   : MesFiscal := strFormatDate + ','; // + ' AS JULHO,' ;
         8   : MesFiscal := strFormatDate + ','; // + ' AS AGOSTO,' ;
         9   : MesFiscal := strFormatDate + ','; // + ' AS SETEMBRO,' ;
         10  : MesFiscal := strFormatDate + ','; // + ' AS OUTUBRO,' ;
         11  : MesFiscal := strFormatDate + ','; // + ' AS NOVEMBRO,' ;
         12  : MesFiscal := strFormatDate + ','; // + ' AS DEZEMBRO,' ;
     End ;
   end
   else
   begin
     Case Mes Of
         1   : MesFiscal := strFormatDate + ',' ;
         2   : MesFiscal := strFormatDate + ',' ;
         3   : MesFiscal := strFormatDate + ',' ;
         4   : MesFiscal := strFormatDate + ',' ;
         5   : MesFiscal := strFormatDate + ',' ;
         6   : MesFiscal := strFormatDate + ',' ;
         7   : MesFiscal := strFormatDate + ',' ;
         8   : MesFiscal := strFormatDate + ',' ;
         9   : MesFiscal := strFormatDate + ',' ;
         10  : MesFiscal := strFormatDate + ',' ;
         11  : MesFiscal := strFormatDate + ',' ;
         12  : MesFiscal := strFormatDate + ',' ;
     End ;
   end;


   //if (Alias <> '') then
   //    MesFiscal := Alias + '.' + MesFiscal;
   if SomarLinha then
   begin
      MesFiscal := Copy(MesFiscal,1,length(MesFiscal)-1);

      Case Mes Of
         1   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         2   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         3   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         4   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         5   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         6   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         7   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         8   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         9   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         10  : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         11  : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         12  : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
     End ;
   end
   else
   begin
     if (Alias <> '') and (bLabel) then
     begin
        MesFiscal := Copy(MesFiscal,1,length(MesFiscal)-1);

        Case Mes Of
           1   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Jan_' + IntToStr(Ano) + ',' ;
           2   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Fev_' + IntToStr(Ano) + ',' ;
           3   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Mar_' + IntToStr(Ano) + ',' ;
           4   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Abr_' + IntToStr(Ano) + ',' ;
           5   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Mai_' + IntToStr(Ano) + ',' ;
           6   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Jun_' + IntToStr(Ano) + ',' ;
           7   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Jul_' + IntToStr(Ano) + ',' ;
           8   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Ago_' + IntToStr(Ano) + ',' ;
           9   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Set_' + IntToStr(Ano) + ',' ;
           10  : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Out_' + IntToStr(Ano) + ',' ;
           11  : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Nov_' + IntToStr(Ano) + ',' ;
           12  : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Dez_' + IntToStr(Ano) + ',' ;
       End ;
     end;
   end;



   Result :=  MesFiscal;

end;


procedure TfrmExibeDashBoard.ButExcelClick(Sender: TObject);
begin


  SaveDialog.InitialDir := GetCurrentDir;

  if cxButtonEditPath.Text = EmptyStr then
    raise Exception.Create('Informe o arquivo primeiro.');

  if Page.ActivePageIndex = 0 then
  begin

        if FDStoredProc2.IsEmpty then
            raise Exception.Create('N�o h� dados para serem exportados ao Excel');

        SaveDialog.InitialDir := GetCurrentDir;

        if SaveDialog.Execute then
        begin
           Mensagem( 'Exportando Grid Pedidos vs Forecast M�s (MTD)...' );
           cxGridExportLink.ExportGridToXLSX(SaveDialog.FileName, cxGridPedido);
           Mensagem('');
           MessageDlg( pChar( 'Planilha exportada em  ' + ExtractFilePath(SaveDialog.FileName) )  , mtInformation, [ mbOk ], 0 );

        end;

  end
  else
   if  Page.ActivePageIndex = 1 then
   begin
        if FDStoredProc.IsEmpty then
            raise Exception.Create('N�o h� dados para serem exportados ao Excel');

        SaveDialog.InitialDir := GetCurrentDir;

        if SaveDialog.Execute then
        begin
          Mensagem( 'Exportando Grid Faturamento vs Target YTD (Ano)...' );
          cxGridExportLink.ExportGridToXLSX(SaveDialog.FileName, cxGridTargetAno);
          MessageDlg( pChar( 'Planilha exportada em  ' + ExtractFilePath(SaveDialog.FileName) )  , mtInformation, [ mbOk ], 0 );
          Mensagem('');
        end;

   end
   else if  Page.ActivePageIndex = 2 then
   begin

          if FDStoredProc.IsEmpty then
              raise Exception.Create('N�o h� dados para serem exportados ao Excel');

          SaveDialog.InitialDir := GetCurrentDir;

          if SaveDialog.Execute then
          begin
             Mensagem( 'Exportando Grid Faturamento + Forecast vs Target (Ano)...' );
             cxGridExportLink.ExportGridToXLSX(SaveDialog.FileName, cxGridForecastAno);
             MessageDlg( pChar( 'Planilha exportada em  ' + ExtractFilePath(SaveDialog.FileName) )  , mtInformation, [ mbOk ], 0 );
             Mensagem('');
          end;

   end
  else if  Page.ActivePageIndex = 3 then
       begin

          if FDQueryVSOP_OrderBilling00.IsEmpty then
              raise Exception.Create('N�o h� dados para serem exportados ao Excel');

          Exportar_GMCliente;
       end;

end;


procedure TfrmExibeDashBoard.Exportar_GMCliente;
var
  I, X : Integer;
  varCor1,varCor2: TColor;
begin

   Screen.Cursor := crHourGlass;
   DeleteFile(PWideChar(MyDocumentsPath+'\DashBoard_GM_Cliente.xlsx'));
   CopyFile( PWideChar('\\ghos2024\Brady\DashBoard_GM_Cliente.xlsx'), PWideChar(MyDocumentsPath+'\DashBoard_GM_Cliente.xlsx'), True );

   Try
       Mensagem( 'Criando Planilha...' );
       dxSpreadSheet := TdxSpreadSheet.Create(nil);
       try
           Mensagem( 'Exportando Grid GM Por Cliente...' );
           dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\DashBoard_GM_Cliente.xlsx' );
           dxSpreadSheet.BeginUpdate;

           dxSpreadSheet.Sheets[0].Active := True;

           for I := 0 to 14 do
           begin

             with dxSpreadSheet.ActiveSheetAsTable.CreateCell(0,I) do;

           end;

           FDQueryVSOP_OrderBilling00.First;
           varCor1 := RGB( 255, 255, 204 );
           varCor2 := RGB(255,255,225);

           X := 1;
           while not FDQueryVSOP_OrderBilling00.eof do
           begin

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryVSOP_OrderBilling00SITE.AsString;
               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryVSOP_OrderBilling00CANAL.AsString;
               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,2) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryVSOP_OrderBilling00COD_CLIENTE.AsString;
               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,3) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryVSOP_OrderBilling00RAZAO_SOCIAL.AsString;

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,4) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryVSOP_OrderBilling00GRUPO_CLIENTE.AsString;

               end;


               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,5) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryVSOP_OrderBilling00ACC_OWNER.AsString;

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,6) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryVSOP_OrderBilling00COD_ITEM.AsString;

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,7) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryVSOP_OrderBilling00Regi�o.AsString;

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,8) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryVSOP_OrderBilling00UF.AsString;

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,9) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryVSOP_OrderBilling00UoM.AsString;

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,10) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   Style.DataFormat.FormatCode:='dd-mm-yyyy';
                   AsVariant := FDQueryVSOP_OrderBilling00Periodo.AsString

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,11) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                    Style.DataFormat.FormatCode := '#,###,###';
                   AsVariant := FDQueryVSOP_OrderBilling00TOTAL_VENDAS_QTD.AsFloat;

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,12) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   Style.DataFormat.FormatCode := '#,###,###';
                   AsVariant := FDQueryVSOP_OrderBilling00NET_SALE.AsFloat;

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,13) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   Style.DataFormat.FormatCode := '#,##0.00';
                   AsVariant := FDQueryVSOP_OrderBilling00GM_VALOR.AsFloat;
               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,14) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   Style.DataFormat.FormatCode := '#,##0.00';
                   AsVariant := FDQueryVSOP_OrderBilling00GM_PERCENTUAL.AsFloat;
               end;

               if Odd(X) then
                varCor1 := RGB(255,255,225)
               else
                varCor1 := RGB(216,234,204);

               Inc(X);

               FDQueryVSOP_OrderBilling00.Next;
           end;

           dxSpreadSheet.BeginUpdate;
           dxSpreadSheet.SaveToFile( cxButtonEditPath.Text );
           MessageDlg( pChar( 'Planilha exportada em  ' + ExtractFilePath(SaveDialog.FileName) )  , mtInformation, [ mbOk ], 0 );

       finally
          FreeAndNil(dxSpreadSheet);
       end;
   Finally
          Mensagem( EmptyStr );
          Screen.Cursor := crDefault;
   End;
end;

procedure  TfrmExibeDashBoard.LimparTelaDinamica;
var
 i : integer;
begin
  if Edit <> Nil then
  begin

   for i := ComponentCount - 1 downto 0 do
    begin
      If (Components[i] is tedit) then
      begin
        Tedit(Components[i]).Clear;
        Tedit(Components[i]).Free;
      end;
    end;

  end;

  if LblMedia <> Nil then
  begin

    for i := ComponentCount - 1 downto 0 do
    begin
      If (Components[i] is TLabel) then
        TLabel(Components[i]).Free;
    end;

  end;


end;


procedure TfrmExibeDashBoard.KeyPressProc(Sender: TObject; var Key: Char);
var
  FormatBr: TFormatSettings;
begin
  FormatBr.DecimalSeparator    := ',';

  if not (Key in [#8, #13, '0'..'9', '-', '.', FormatBr.DecimalSeparator]) then
  begin
    ShowMessage('Tecla inv�lida: ' + Key);
    Key := #0;
  end
  else if ((Key = FormatBr.DecimalSeparator) or (Key = '-')) and
          (Pos(Key,   (Sender as TEdit).Text) > 0) then begin
    ShowMessage('Tecla inv�lida: 2 vezes ' + Key);
    Key := #0;
  end
  else if (Key = '-') and
          ((Sender as TEdit).SelStart <> 0) then begin
    ShowMessage('Somente permitido no inicio do n�mero: ' + Key);
    Key := #0;
  end;
end;

procedure TfrmExibeDashBoard.cxButton1Click(Sender: TObject);
var
 i : Integer;
begin
   {
   if NumeroLinhasGrid > 0 then
   begin
    for I := 0 to NumeroLinhasGrid do
      TStringGridHack(StringGrid1).DeleteRow(i);
   end;
   NumeroLinhasGrid := 0;
   }
end;

procedure TfrmExibeDashBoard.cxButtonEditPathClick(Sender: TObject);
begin
  if SaveDialog.Execute(Handle) then
  begin
    cxButtonEditPath.Text := SaveDialog.FileName;
  end;
end;

procedure TfrmExibeDashBoard.cxButtonRefreshClick(Sender: TObject);
begin
   if ((Page.ActivePage  = TabForecast) or (Page.ActivePage =  TabTarget))  then
     AbrirDataset
   else if Page.ActivePage = TabPedidos Then
     AbrirDataset2
   else  AbrirDataset3;

end;

procedure TfrmExibeDashBoard.cxDBPivotGrid00StylesGetContentStyle(
  Sender: TcxCustomPivotGrid; ACell: TcxPivotGridDataCellViewInfo;
  var AStyle: TcxStyle);
begin

  if ACell.Value < 0 then
    AStyle := NegativeStyle;

end;

procedure TfrmExibeDashBoard.cxDBPivotGrid1StylesGetContentStyle(
  Sender: TcxCustomPivotGrid; ACell: TcxPivotGridDataCellViewInfo;
  var AStyle: TcxStyle);
begin
  if ACell.Value < 0 then
    AStyle := NegativeStyle;
end;

procedure TfrmExibeDashBoard.cxDBPivotGrid2StylesGetContentStyle(
  Sender: TcxCustomPivotGrid; ACell: TcxPivotGridDataCellViewInfo;
  var AStyle: TcxStyle);
begin
  if ACell.Value < 0 then
    AStyle := NegativeStyle;
end;

procedure TfrmExibeDashBoard.cxDBPivotGrid3StylesGetContentStyle(
  Sender: TcxCustomPivotGrid; ACell: TcxPivotGridDataCellViewInfo;
  var AStyle: TcxStyle);
begin
  if ACell.Value < 0 then
    AStyle := NegativeStyle;

end;

procedure TfrmExibeDashBoard.cxDBPivotGridFieldGM_PERCENTUALCalculateCustomSummary(
  Sender: TcxPivotGridField; ASummary: TcxPivotGridCrossCellSummary);
var
  AValue: Variant;
  AValue2 : Variant;
begin
  // for last field you can use previous calculated field value
  AValue := ASummary.Owner.GetSummaryByField(cxDBPivotGridFieldGM_VALOR, cxDBPivotGridFieldGM_VALOR.SummaryType);
  AValue2 := ASummary.Owner.GetSummaryByField(cxDBPivotGridFieldNET_SALE, cxDBPivotGridFieldNET_SALE.SummaryType);

  if (VarIsNumeric(AValue) and VarIsNumeric(AValue2)) then
    ASummary.Custom := (AValue / AValue2) * 100;

end;

procedure TfrmExibeDashBoard.cxGridTargetAnoDBBandedTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
//var
 // anomes, ano, mes : String;
begin
  {
  ano :=  IntToStr(YearOf(now)) ;
  mes :=  LeftPad(MonthOf(now));
  anomes := ano + '-' + mes;

   if(AViewInfo.GridRecord.Values[FDQueryForecast.FieldByName('DataProc').Index ] = anomes) then
    ACanvas.Brush.Color :=  clActiveCaption;
 // else ACanvas.Brush.Color := clWhite;
 }
end;

function TfrmExibeDashBoard.LeftPad(value:integer; length:integer=2; pad:char='0'): string;
begin

   result := RightStr(StringOfChar(pad,length) + IntToStr(value), length );

end;



function  TfrmExibeDashBoard.ContaGrupo(pGrupo, pVendedor : String) : Integer;
var
 b : TBookMark;
 i : Integer;
begin
  b:= FDQueryForecast.GetBookmark;
  FDQueryForecast.DisableControls;
  Try
   FDQueryForecast.First;
   I := 0;
   while not FDQueryForecast.eof do
   begin
      if ((FDQueryForecast.Fields[1].AsString = pGrupo) and (FDQueryForecast.Fields[0].AsString = pVendedor)) then
         Inc(I);
      FDQueryForecast.Next;
   end;

  Finally
    FDQueryForecast.GotoBookmark(b);
    FDQueryForecast.FreeBookmark(b);
    FDQueryForecast.EnableControls;
  End;

  Result := I;
end;



procedure TfrmExibeDashBoard.Summarize(ASummary: TcxDataSummary; AColumn: TcxGridDBBandedColumn;
  AKind: TcxSummaryKind; AFormat: string);
var
  sumGroup: TcxDataSummaryGroup;
  link: TcxGridTableSummaryGroupItemLink;
  item: TcxGridDBTableSummaryItem;
begin
  AColumn.Summary.FooterKind := AKind;
  AColumn.Summary.FooterFormat := AFormat;
  AColumn.Summary.GroupKind := AKind;
  AColumn.Summary.GroupFormat := AFormat;
  AColumn.GroupIndex := -1;
  sumGroup := ASummary.SummaryGroups.Add;
  link := sumGroup.Links.Add as TcxGridTableSummaryGroupItemLink;
  link.Column :=  AColumn;
  item := sumGroup.SummaryItems.Add as TcxGridDBTableSummaryItem;
  item.Column := AColumn;
  item.Kind := skSum;
  item.Position := spGroup;
  item.Format := AColumn.Summary.FooterFormat;
end;

function TfrmExibeDashBoard.TrataDataHint(varData: String): String;
var
 Mes, Ano : String;
begin
   Mes := Copy(VarData,1,3);
   Ano := Copy(VarData,5,4);

   if Mes = 'Jan' then
     Mes := '01'
   else if Mes = 'Fev' then
     Mes := '02'
   else if Mes = 'Mar' then
     Mes := '03'
   else if Mes = 'Abr' then
     Mes := '04'
   else if Mes = 'Mai' then
     Mes := '05'
   else if Mes = 'Jun' then
     Mes := '06'
   else if Mes = 'Jul' then
     Mes := '07'
   else if Mes = 'Ago' then
     Mes := '08'
   else if Mes = 'Set' then
     Mes := '09'
   else if Mes = 'Out' then
     Mes := '10'
   else if Mes = 'Nov' then
     Mes := '11'
   else if Mes = 'Dez' then
     Mes := '12';


   result := Ano + '/' + Mes + '/' + '01';

end;




procedure TfrmExibeDashBoard.AbrirDataset;
var
  varDataReferencia: TDateTime;
  varCurrentMonth: Integer;
  varSQL , varInicialBill, varFinalBill, varAnteriorFor, varInicialFor, varFinalFor: TDateTime;

  varAnteriorForT, varInicialForT, varFinalForT : TDateTime;

  I : Integer;
  varMesesB, varMesesF : Integer;
  varResultado : String;
  pStoredProc : TFDStoredProc;

begin
  Mensagem( 'Abrindo conex�o...' );
  try

    if not FDConnection.Connected then
    begin

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

    end;

    Mensagem( 'Obtendo dados (Billing x Forecast)...' );

    //DtInicial.Date :=  IncMonth(System.DateUtils.StartOfTheMonth(Now),-5);
    varInicialBill := MontaDataDashBoard(DtInicial.Date, False, False, false);               // monta data inicial de billing
    varFinalBill   := System.DateUtils.EndOfTheMonth(IncMonth(dtInicial.Date,-1));  // monta data final de billing

    varMesesB      := MonthsBetween(varInicialBill, System.DateUtils.EndOfTheMonth(varFinalBill));

    if varMesesB <> 11 then
    begin
       // Monta data de Referencia do Budget

       // mudei de TRUE para FALSE o primeiro paramentro conforme Luciana 15-08-2019
        //varInicialFor  := MontaDataDashBoard(DtInicial.Date, True, False, false);
        varInicialFor  := MontaDataDashBoard(DtInicial.Date, False, False, false);                // monta data inicial de forecast
        varFinalFor    := MontaDataDashBoard(DtInicial.Date, False, True, false);                 // monta data final de forecast
        varAnteriorFor := System.DateUtils.StartOfTheMonth(IncMonth(varInicialFor,-1));


        varInicialForT  :=System.DateUtils.StartOfTheMonth(IncMonth(varFinalBill,+1));            // monta data inicial de forecast
        varFinalForT    := MontaDataDashBoard(DtInicial.Date, False, True, false);                // monta data final de forecast
        varAnteriorForT := IncMonth(varInicialForT,-1);                                           // Monta data de Referencia do Budget
    end
    else
    begin
        varInicialFor  := varInicialBill;                                     // monta data inicial de forecast
        varFinalFor    := System.DateUtils.StartOfTheMonth(varFinalBill);     // monta data final de forecast
        varAnteriorFor := IncMonth(varInicialFor,-1);                         // Monta data de Referencia do Budget


        varInicialForT  := varInicialFor;     // monta data inicial de forecast
        varFinalForT    := varFinalFor;       // monta data final de forecast
        varAnteriorForT := varAnteriorFor;    // Monta data de Referencia do Budget
    end;


    varMesesF :=    MonthsBetween(varInicialFor,  System.DateUtils.EndOfTheMonth(varFinalFor));

    try
      FDStoredProc.Close;
      FDStoredProc.Connection := FDConnection;
      FDStoredProc.StoredProcName := AnsiUpperCase( 'PSOP_DASHBOARD' );
      for I := 0 to FDStoredProc.Params.Count-1 do
        FDStoredProc.Params.ClearValues(i);

      FDStoredProc.Prepare;
    except
      on E : Exception do
        begin
          MessageDlg( 'Stored procedure error: ' + #13 + #13 +
                       E.Message, mtError, [ mbOk ], 0 );
        end;
    end;

    try


      FDStoredProc.ParamByName( '@TSOP_USUCOD' ).AsInteger := Fr_Brady.TSIS_USUCOD;
      FDStoredProc.ParamByName( '@MES_INI' ).AsString      := FormatDateTime('yyyy-mm-dd 00:00:00', varInicialBill);
      FDStoredProc.ParamByName( '@MES_FIM' ).AsString      := FormatDateTime('yyyy-mm-dd 00:00:00', varFinalBill);

      FDStoredProc.ParamByName( '@MES_ANTF' ).AsString     := FormatDateTime('yyyy-mm-dd 00:00:00', varAnteriorFor);
      FDStoredProc.ParamByName( '@MES_INIF' ).AsString     := FormatDateTime('yyyy-mm-dd 00:00:00', varInicialFor);
      FDStoredProc.ParamByName( '@MES_FIMF' ).AsString     := FormatDateTime('yyyy-mm-dd 00:00:00', varFinalFor);

      FDStoredProc.ParamByName( '@MES_ANTT' ).AsString     := FormatDateTime('yyyy-mm-dd 00:00:00', varAnteriorFor); //   varAnteriorForT
      FDStoredProc.ParamByName( '@MES_INIT' ).AsString     := FormatDateTime('yyyy-mm-dd 00:00:00', varInicialFor);  //   varInicialForT
      FDStoredProc.ParamByName( '@MES_FIMT' ).AsString     := FormatDateTime('yyyy-mm-dd 00:00:00', varFinalFor);  //   varFinalForT


      if ((Fr_Brady.SalesRep) or (chkVendedor.Checked)) then
        FDStoredProc.ParamByName( '@SALESREP' ).AsString   := Fr_Brady.TSIS_USUNOM
      else  FDStoredProc.ParamByName( '@SALESREP' ).IsNull;

      FDStoredProc.Open;

    except
      on E : Exception do
        begin
          MessageDlg( 'Stored procedure error: ' + #13 + #13 +
                       E.Message, mtError, [ mbOk ], 0 );
        end;
    end;

  finally
     Mensagem( EmptyStr );
  end;

end;

procedure TfrmExibeDashBoard.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(lstMeses);
  frmExibeDashBoard := nil;
  Action := caFree;
end;

procedure TfrmExibeDashBoard.FormCreate(Sender: TObject);
var
  sqlMeses :  TFDQuery;
  I : Integer;
begin
  Page.ActivePage      := TabPedidos;
  dtInicial.Date       := Date;
  cxButtonRefresh.Left := 232;

  if Fr_Brady.SalesRep then
  begin
    chkVendedor.Visible    := False;
    cxButtonRefresh.Left   := 155;
  end;
  
  // N�o utilizado at� o momento.
  {lstMeses := TStringList.Create;
  sqlMeses := TFDQuery.Create(Nil);
  Try
    sqlMeses.Connection := FDConnection;
    sqlMeses.SQL.Clear;
    sqlMeses.SQL.Add('SELECT DISTINCT YEARDOC FROM TSOP_MONTHS WHERE YEARDOC >= ''2019''  ORDER BY 1');
    sqlMeses.Open;
    sqlMeses.First;
    while not sqlMeses.Eof do
    begin
       lstMeses.Add(sqlMeses.FieldByName('YEARDOC').AsString);
       sqlMeses.Next;
    end;
  Finally
    FreeAndNil(sqlMeses);
  End;

  cbxMeses.Sorted := true;
  cbxMeses.Items.BeginUpdate;
  try
    for I := 0 to lstMeses.Count-1 do begin
      cbxMeses.Items.AddObject(lstMeses[I], TObject(I));
    end;
  finally
    cbxMeses.Items.EndUpdate;
  end;
   }


  //AbrirDataset;
end;

procedure TfrmExibeDashBoard.FormKeyPress(Sender: TObject; var Key: Char);
begin

 case Key of
   #13: Perform(WM_NEXTDLGCTL, 0, 0);
   #27: Perform(WM_NEXTDLGCTL, 1, 0);
  end;

end;

{ TStringGridHack }

procedure TStringGridHack.DeleteRow(ARow: Integer);
var
  GemRow: Integer;
begin
  GemRow := Row;
  if RowCount > FixedRows + 1 then
    inherited DeleteRow(ARow)
  else
    Rows[ARow].Clear;
  if GemRow < RowCount then
    Row := GemRow;
end;

procedure TStringGridHack.InsertRow(ARow: Integer);
var
  GemRow: Integer;
begin
  GemRow := Row;
  while ARow < FixedRows do
    Inc(ARow);
  RowCount := RowCount + 1;
  MoveRow(RowCount - 1, ARow);
  Row := GemRow;

end;

end.