unit uRelatGrossMargin;

interface

uses
  System.IOUtils,
  System.DateUtils,

  dxSpreadSheet,
  dxSpreadSheetTypes,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinOffice2013White,
  dxSkinscxPCPainter, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.Menus, cxContainer,
  Vcl.ComCtrls, dxCore, cxDateUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, Vcl.ImgList, cxCheckBox, cxButtonEdit, cxDropDownEdit,
  cxTextEdit, cxMaskEdit, cxCalendar, cxLabel, Vcl.StdCtrls, cxButtons,
  Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxPC, dxGDIPlusClasses,
  ShellApi, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  FireDAC.Comp.ScriptCommands, FireDAC.Comp.Script;

type
  TFr_RelatGrossMargin = class(TForm)
    cxPageControlFiltro: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxPageControl: TcxPageControl;
    cxTabSheetGrossMargin: TcxTabSheet;
    cxGridGrossMargin: TcxGrid;
    cxTableViewGrossMargin00: TcxGridDBTableView;
    cxTableViewGrossMargin00SITE: TcxGridDBColumn;
    cxTableViewGrossMargin00Regio: TcxGridDBColumn;
    cxTableViewGrossMargin00UF: TcxGridDBColumn;
    cxTableViewGrossMargin00CANAL: TcxGridDBColumn;
    cxTableViewGrossMargin00COD_CLIENTE: TcxGridDBColumn;
    cxTableViewGrossMargin00RAZAO_SOCIAL: TcxGridDBColumn;
    cxTableViewGrossMargin00GRUPO_CLIENTE: TcxGridDBColumn;
    cxTableViewGrossMargin00ACC_OWNER: TcxGridDBColumn;
    cxTableViewGrossMargin00COD_ITEM: TcxGridDBColumn;
    cxTableViewGrossMargin00MTO_MTS: TcxGridDBColumn;
    cxTableViewGrossMargin00FY: TcxGridDBColumn;
    cxTableViewGrossMargin00QTR: TcxGridDBColumn;
    cxTableViewGrossMargin00DTREF: TcxGridDBColumn;
    cxTableViewGrossMargin00COST_LOT_SIZE: TcxGridDBColumn;
    cxTableViewGrossMargin00TOTAL_VENDAS_QTD: TcxGridDBColumn;
    cxTableViewGrossMargin00UOM: TcxGridDBColumn;
    cxTableViewGrossMargin00NET_SALE: TcxGridDBColumn;
    cxTableViewGrossMargin00MATERIAL_SETUP: TcxGridDBColumn;
    cxTableViewGrossMargin00MATERIAL_RESALE_RUN_SCRAP: TcxGridDBColumn;
    cxTableViewGrossMargin00TOTAL_MATERIAL: TcxGridDBColumn;
    cxTableViewGrossMargin00MACHINE_SETUP: TcxGridDBColumn;
    cxTableViewGrossMargin00MACHINE_RUN: TcxGridDBColumn;
    cxTableViewGrossMargin00TOTAL_MACHINE: TcxGridDBColumn;
    cxTableViewGrossMargin00LABOR_SETUP: TcxGridDBColumn;
    cxTableViewGrossMargin00LABOR_RUN: TcxGridDBColumn;
    cxTableViewGrossMargin00TOTAL_LABOR: TcxGridDBColumn;
    cxTableViewGrossMargin00DIRECT_COST: TcxGridDBColumn;
    cxTableViewGrossMargin00CM_VALOR: TcxGridDBColumn;
    cxTableViewGrossMargin00CM_PERCENTUAL: TcxGridDBColumn;
    cxTableViewGrossMargin00INDIRECT_COST: TcxGridDBColumn;
    cxTableViewGrossMargin00TOTAL_COST: TcxGridDBColumn;
    cxTableViewGrossMargin00GM_VALOR: TcxGridDBColumn;
    cxTableViewGrossMargin00GM_PERCENTUAL: TcxGridDBColumn;
    cxTableViewGrossMargin00MRP_Controler: TcxGridDBColumn;
    cxTableViewGrossMargin00MaterialSETUPSTD: TcxGridDBColumn;
    cxTableViewGrossMargin00MaterialResaleRUNScrapSTD: TcxGridDBColumn;
    cxTableViewGrossMargin00TOTAL_MATERIAL_STD: TcxGridDBColumn;
    cxTableViewGrossMargin00MachineSETUPSTD: TcxGridDBColumn;
    cxTableViewGrossMargin00MachineRUNSTD: TcxGridDBColumn;
    cxTableViewGrossMargin00TotalMachineSTD: TcxGridDBColumn;
    cxTableViewGrossMargin00LaborSETUPSTD: TcxGridDBColumn;
    cxTableViewGrossMargin00LaborRUNSTD: TcxGridDBColumn;
    cxTableViewGrossMargin00TotalLaborSTD: TcxGridDBColumn;
    cxTableViewGrossMargin00DIRECT_COST_STD: TcxGridDBColumn;
    cxTableViewGrossMargin00CM_VALOR_STD: TcxGridDBColumn;
    cxTableViewGrossMargin00CM_PERCENTUAL_STD: TcxGridDBColumn;
    cxTableViewGrossMargin00INDIRECT_COST_STD: TcxGridDBColumn;
    cxTableViewGrossMargin00TOTAL_COST_STD: TcxGridDBColumn;
    cxTableViewGrossMargin00GM_VALOR_STD: TcxGridDBColumn;
    cxTableViewGrossMargin00GM_PERCENTUAL_STD: TcxGridDBColumn;
    cxGridLevelGrossMargin00: TcxGridLevel;
    cxTabSheetBom: TcxTabSheet;
    cxGridBom: TcxGrid;
    cxTableViewBom: TcxGridDBTableView;
    cxTableViewBomPlanta: TcxGridDBColumn;
    cxTableViewBomYNumberPA: TcxGridDBColumn;
    cxTableViewBomUN: TcxGridDBColumn;
    cxTableViewBomYNumberMP: TcxGridDBColumn;
    cxTableViewBomUNMP: TcxGridDBColumn;
    cxTableViewBomCostLotSize: TcxGridDBColumn;
    cxTableViewBomQtdeFixaSN: TcxGridDBColumn;
    cxTableViewBomQtderMP: TcxGridDBColumn;
    cxTableViewBomCusto: TcxGridDBColumn;
    cxTableViewBomCustoSTD: TcxGridDBColumn;
    cxTableViewBomOrdem: TcxGridDBColumn;
    cxGridBomLevel1: TcxGridLevel;
    cxTabSheetCosting: TcxTabSheet;
    cxGridCosting: TcxGrid;
    cxTableViewCosting: TcxGridDBTableView;
    cxTableViewCostingCodItemYNumber: TcxGridDBColumn;
    cxTableViewCostingSite: TcxGridDBColumn;
    cxTableViewCostingUOM: TcxGridDBColumn;
    cxTableViewCostingCostLotSize: TcxGridDBColumn;
    cxTableViewCostingStandard: TcxGridDBColumn;
    cxTableViewCostingMoving: TcxGridDBColumn;
    cxTableViewCostingPriceUnit: TcxGridDBColumn;
    cxGridCostingLevel1: TcxGridLevel;
    cxTabSheetRouting: TcxTabSheet;
    cxGridRouting: TcxGrid;
    cxTableViewRouting: TcxGridDBTableView;
    cxTableViewRoutingSite: TcxGridDBColumn;
    cxTableViewRoutingYNumber: TcxGridDBColumn;
    cxTableViewRoutingUN: TcxGridDBColumn;
    cxTableViewRoutingWorkCenter: TcxGridDBColumn;
    cxTableViewRoutingCentroCusto: TcxGridDBColumn;
    cxTableViewRoutingCostLotSize: TcxGridDBColumn;
    cxTableViewRoutingSetupMIN: TcxGridDBColumn;
    cxTableViewRoutingMachineMIN: TcxGridDBColumn;
    cxTableViewRoutingLaborMIN: TcxGridDBColumn;
    cxTableViewRoutingOverheadMIN: TcxGridDBColumn;
    cxTableViewRoutingSetupcost: TcxGridDBColumn;
    cxTableViewRoutingSetupMachineCost: TcxGridDBColumn;
    cxTableViewRoutingSetupLaborCost: TcxGridDBColumn;
    cxTableViewRoutingSetupOverheadCost: TcxGridDBColumn;
    cxTableViewRoutingRunMachineCost: TcxGridDBColumn;
    cxTableViewRoutingRunLaborCost: TcxGridDBColumn;
    cxTableViewRoutingRunOverheadCost: TcxGridDBColumn;
    cxGridRoutingLevel1: TcxGridLevel;
    Panel1: TPanel;
    cxButtonRefresh: TcxButton;
    ButExcel: TcxButton;
    cxLabel4: TcxLabel;
    cxButtonEditPath: TcxButtonEdit;
    cxCheckBoxGerar: TcxCheckBox;
    cxSmallImages: TcxImageList;
    FDQueryTSOP_GMHoras: TFDQuery;
    FDQueryTSOP_GMHorasTSOP_GMHCOD: TFDAutoIncField;
    FDQueryTSOP_GMHorasTSOP_GMHSIT: TStringField;
    FDQueryTSOP_GMHorasTSOP_GMHCCU: TStringField;
    FDQueryTSOP_GMHorasTSOP_GMHSUP: TBCDField;
    FDQueryTSOP_GMHorasTSOP_GMHMAQ: TBCDField;
    FDQueryTSOP_GMHorasTSOP_GMHLAB: TBCDField;
    FDQueryTSOP_GMHorasTSOP_GMHOVE: TBCDField;
    FDQueryTSOP_GMHorasTSOP_GMHDAT: TSQLTimeStampField;
    FDQueryTSOP_GMHorasTSOP_GMHBUD: TStringField;
    SaveDialog: TSaveDialog;
    DataSourceCosting: TDataSource;
    FDQueryCosting: TFDQuery;
    FDQueryCostingCodItemYNumber: TStringField;
    FDQueryCostingSite: TStringField;
    FDQueryCostingUOM: TStringField;
    FDQueryCostingCostLotSize: TBCDField;
    FDQueryCostingStandard: TFloatField;
    FDQueryCostingMoving: TFloatField;
    FDQueryCostingPriceUnit: TFloatField;
    DataSourceBOM: TDataSource;
    FDConnection: TFDConnection;
    FDQueryGMHoras: TFDQuery;
    FDQueryBOM: TFDQuery;
    FDQueryBOMPlanta: TStringField;
    FDQueryBOMYNumberPA: TStringField;
    FDQueryBOMUN: TStringField;
    FDQueryBOMYNumberMP: TStringField;
    FDQueryBOMUNMP: TStringField;
    FDQueryBOMCostLotSize: TFloatField;
    FDQueryBOMQtdeFixaSN: TStringField;
    FDQueryBOMQtderMP: TFloatField;
    FDQueryBOMCusto: TFloatField;
    FDQueryBOMCustoSTD: TFloatField;
    FDQueryBOMOrdem: TStringField;
    FDQueryRouting: TFDQuery;
    FDQueryRoutingSite: TStringField;
    FDQueryRoutingYNumber: TStringField;
    FDQueryRoutingUN: TStringField;
    FDQueryRoutingWorkCenter: TStringField;
    FDQueryRoutingCentroCusto: TStringField;
    FDQueryRoutingCostLotSize: TFloatField;
    FDQueryRoutingSetupMIN: TFloatField;
    FDQueryRoutingMachineMIN: TFloatField;
    FDQueryRoutingLaborMIN: TFloatField;
    FDQueryRoutingOverheadMIN: TFloatField;
    FDQueryRoutingSetupcost: TFloatField;
    FDQueryRoutingSetupMachineCost: TFloatField;
    FDQueryRoutingSetupLaborCost: TFloatField;
    FDQueryRoutingSetupOverheadCost: TFloatField;
    FDQueryRoutingRunMachineCost: TFloatField;
    FDQueryRoutingRunLaborCost: TFloatField;
    FDQueryRoutingRunOverheadCost: TFloatField;
    FDQueryVSOP_OrderBilling00: TFDQuery;
    FDQueryVSOP_OrderBilling00SITE: TStringField;
    FDQueryVSOP_OrderBilling00CANAL: TStringField;
    FDQueryVSOP_OrderBilling00Regi�o: TStringField;
    FDQueryVSOP_OrderBilling00UF: TStringField;
    FDQueryVSOP_OrderBilling00COD_CLIENTE: TStringField;
    FDQueryVSOP_OrderBilling00RAZAO_SOCIAL: TStringField;
    FDQueryVSOP_OrderBilling00GRUPO_CLIENTE: TStringField;
    FDQueryVSOP_OrderBilling00ACC_OWNER: TStringField;
    FDQueryVSOP_OrderBilling00COD_ITEM: TStringField;
    FDQueryVSOP_OrderBilling00MTO_MTS: TStringField;
    FDQueryVSOP_OrderBilling00FY: TIntegerField;
    FDQueryVSOP_OrderBilling00QTR: TStringField;
    FDQueryVSOP_OrderBilling00COST_LOT_SIZE: TFloatField;
    FDQueryVSOP_OrderBilling00TOTAL_VENDAS_QTD: TFloatField;
    FDQueryVSOP_OrderBilling00UOM: TStringField;
    FDQueryVSOP_OrderBilling00NET_SALE: TFloatField;
    FDQueryVSOP_OrderBilling00MATERIAL_SETUP: TFloatField;
    FDQueryVSOP_OrderBilling00MATERIAL_RESALE_RUN_SCRAP: TFloatField;
    FDQueryVSOP_OrderBilling00TOTAL_MATERIAL: TFloatField;
    FDQueryVSOP_OrderBilling00MACHINE_SETUP: TFloatField;
    FDQueryVSOP_OrderBilling00MACHINE_RUN: TFloatField;
    FDQueryVSOP_OrderBilling00TOTAL_MACHINE: TFloatField;
    FDQueryVSOP_OrderBilling00LABOR_SETUP: TFloatField;
    FDQueryVSOP_OrderBilling00LABOR_RUN: TFloatField;
    FDQueryVSOP_OrderBilling00TOTAL_LABOR: TFloatField;
    FDQueryVSOP_OrderBilling00DIRECT_COST: TFloatField;
    FDQueryVSOP_OrderBilling00CM_VALOR: TFloatField;
    FDQueryVSOP_OrderBilling00CM_PERCENTUAL: TFloatField;
    FDQueryVSOP_OrderBilling00INDIRECT_COST: TFloatField;
    FDQueryVSOP_OrderBilling00TOTAL_COST: TFloatField;
    FDQueryVSOP_OrderBilling00GM_VALOR: TFloatField;
    FDQueryVSOP_OrderBilling00GM_PERCENTUAL: TFloatField;
    FDQueryVSOP_OrderBilling00MRP_Controler: TStringField;
    FDQueryVSOP_OrderBilling00MaterialSETUPSTD: TFloatField;
    FDQueryVSOP_OrderBilling00MaterialResaleRUNScrapSTD: TFloatField;
    FDQueryVSOP_OrderBilling00TOTAL_MATERIAL_STD: TFloatField;
    FDQueryVSOP_OrderBilling00MachineSETUPSTD: TFloatField;
    FDQueryVSOP_OrderBilling00MachineRUNSTD: TFloatField;
    FDQueryVSOP_OrderBilling00TotalMachineSTD: TFloatField;
    FDQueryVSOP_OrderBilling00LaborSETUPSTD: TFloatField;
    FDQueryVSOP_OrderBilling00LaborRUNSTD: TFloatField;
    FDQueryVSOP_OrderBilling00TotalLaborSTD: TFloatField;
    FDQueryVSOP_OrderBilling00DIRECT_COST_STD: TFloatField;
    FDQueryVSOP_OrderBilling00CM_VALOR_STD: TFloatField;
    FDQueryVSOP_OrderBilling00CM_PERCENTUAL_STD: TFloatField;
    FDQueryVSOP_OrderBilling00INDIRECT_COST_STD: TFloatField;
    FDQueryVSOP_OrderBilling00TOTAL_COST_STD: TFloatField;
    FDQueryVSOP_OrderBilling00GM_VALOR_STD: TFloatField;
    FDQueryVSOP_OrderBilling00GM_PERCENTUAL_STD: TFloatField;
    DataSourceVSOP_OrderBilling00: TDataSource;
    DataSourceRouting: TDataSource;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxDateEditTSOP_ORDBILDATDOCFIM: TcxDateEdit;
    cxComboBoxTipo: TcxComboBox;
    cxLabel3: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    DtRefBOM: TcxDateEdit;
    cxDateEditTSOP_ORDBILDATDOCINI: TcxDateEdit;
    cxLabel7: TcxLabel;
    DtRefCosting: TcxDateEdit;
    FDQueryVSOP_OrderBilling00UNIT_PRICE: TFloatField;
    FDQueryVSOP_OrderBilling00UNIT_COST: TFloatField;
    FDQueryVSOP_OrderBilling00Standard: TFloatField;
    FDQueryVSOP_OrderBilling00PriceUnit: TFloatField;
    FDQueryVSOP_OrderBilling00UOM_1: TStringField;
    cxTableViewGrossMargin00UNIT_PRICE: TcxGridDBColumn;
    cxTableViewGrossMargin00UNIT_COST: TcxGridDBColumn;
    cxTableViewGrossMargin00Standard: TcxGridDBColumn;
    cxTableViewGrossMargin00PriceUnit: TcxGridDBColumn;
    cxTableViewGrossMargin00UOM_1: TcxGridDBColumn;
    FDQueryVSOP_OrderBilling00DTREF: TStringField;
    cxCheckBoxConsultar: TcxCheckBox;
    FDStoredProcGet: TFDStoredProc;
    FDQueryAux: TFDQuery;
    FDScriptInsert: TFDScript;
    FDScriptReindexa: TFDScript;
    cxbtnProcessarGM: TcxButton;
    FDStoredGavaHistoricoGM: TFDStoredProc;
    dttaxaHora: TcxDateEdit;
    cxBtnLiberarConsultaGM: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButtonEditPathClick(Sender: TObject);
    procedure ButExcelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxButtonRefreshClick(Sender: TObject);
    procedure cxCheckBoxConsultarClick(Sender: TObject);
    procedure cxPageControlChange(Sender: TObject);
    procedure cxbtnProcessarGMClick(Sender: TObject);
    procedure cxDateEditTSOP_ORDBILDATDOCFIMExit(Sender: TObject);
    procedure cxBtnLiberarConsultaGMClick(Sender: TObject);
  private
    { Private declarations }
    pNivel : smallint;
    dxSpreadSheet: TdxSpreadSheet;
    procedure LoadGridCustomization;
    procedure CreatePlanilhaGrossMargin;
    procedure CreatePlanilhaBOM;
    procedure CreatePlanilhaCosting;
    procedure CreatePlanilhaRouting;
    function DescricaoMes(MesExtenso, Ano : String) : TDateTime;
    function RetornaMes(Mes : Word ) : String;

  public
    { Public declarations }
     procedure AbrirDataSet;
     procedure Mensagem(pMensagem: String);
  end;

var
  Fr_RelatGrossMargin: TFr_RelatGrossMargin;

implementation

{$R *.dfm}

uses uBrady, uUtils, StrFun;


{ TForm1 }

procedure TFr_RelatGrossMargin.AbrirDataSet;
var
 VAR_TSOP_GMHBUD  : String;
 I : Integer;
 varDTAplicada : TDateTime;
begin

  Mensagem( 'Abrindo conex�o...' );
  try

    if not FDConnection.Connected then
    begin

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

    end;


    VAR_TSOP_GMHBUD := 'E';
    if cxComboBoxTipo.ItemIndex = 0 then
       VAR_TSOP_GMHBUD := 'E'
    else if cxComboBoxTipo.ItemIndex = 1 then
       VAR_TSOP_GMHBUD := 'B'
    else if cxComboBoxTipo.ItemIndex = 2 then
       VAR_TSOP_GMHBUD := 'A'
    else if cxComboBoxTipo.ItemIndex = 3 then
       VAR_TSOP_GMHBUD := 'T'
    else if cxComboBoxTipo.ItemIndex = 4 then
       VAR_TSOP_GMHBUD := 'M';

    try
      FDStoredProcGet.Close;
      FDStoredProcGet.Connection := FDConnection;
      FDStoredProcGet.StoredProcName := AnsiUpperCase( 'PSOP_RECUPERAGM' );
      for I := 0 to FDStoredProcGet.Params.Count-1 do
        FDStoredProcGet.Params.ClearValues(i);

      FDStoredProcGet.Prepare;
    except
      on E : Exception do
        begin
          MessageDlg( 'Stored procedure error: ' + #13 + #13 +
                       E.Message, mtError, [ mbOk ], 0 );
        end;
    end;


    // data em que os dados foram exportados do SAP
    FDStoredProcGet.ParamByName( '@DATA' ).AsString          := FormatDateTime('yyyy-mm-dd 00:00:00',  System.DateUtils.StartOfTheMonth(DtRefBOM.Date));

    if System.DateUtils.StartOfTheMonth(DtRefBOM.Date) =  System.DateUtils.StartOfTheMonth(dttaxaHora.Date) then
    begin
      FDStoredProcGet.ParamByName( '@DATAAPLICADA' ).IsNull;
      FDStoredProcGet.ParamByName( '@PROCESSADO' ).AsBoolean := True; // Arquivo j� processado
    end
    else
    begin
      FDStoredProcGet.ParamByName( '@DATAAPLICADA' ).AsString  := FormatDateTime('yyyy-mm-dd 00:00:00', System.DateUtils.StartOfTheMonth(dttaxaHora.Date));
      FDStoredProcGet.ParamByName( '@PROCESSADO' ).AsBoolean   := True; // Arquivo j� processado
    end;

    Try
        Try
           FDStoredProcGet.ExecProc;

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


    if pNivel = 0 then
    begin
        FDQueryVSOP_OrderBilling00.Close;
        Mensagem( 'Obtendo dados (Gross Margin)...' );
        FDQueryVSOP_OrderBilling00.ParamByName( 'V_BILLING_INI' ).AsDateTime := cxDateEditTSOP_ORDBILDATDOCINI.Date;
        FDQueryVSOP_OrderBilling00.ParamByName( 'V_BILLING_FIM' ).AsDateTime := cxDateEditTSOP_ORDBILDATDOCFIM.Date;
        FDQueryVSOP_OrderBilling00.ParamByName( 'V_COSTREF' ).AsDateTime     := dttaxaHora.Date;
        FDQueryVSOP_OrderBilling00.ParamByName( 'V_BOMREF' ).AsDateTime      := DtRefBOM.Date;
        FDQueryVSOP_OrderBilling00.ParamByName( 'V_TSOP_GMHBUD' ).AsString   := VAR_TSOP_GMHBUD;
        FDQueryVSOP_OrderBilling00.Open;
    end
    else
    if pNivel = 1 then
    begin
        FDQueryVSOP_OrderBilling00.Close;
        Mensagem( 'Obtendo dados (Gross Margin)...' );
        FDQueryVSOP_OrderBilling00.ParamByName( 'V_BILLING_INI' ).AsDateTime := cxDateEditTSOP_ORDBILDATDOCINI.Date;
        FDQueryVSOP_OrderBilling00.ParamByName( 'V_BILLING_FIM' ).AsDateTime := cxDateEditTSOP_ORDBILDATDOCFIM.Date;
        FDQueryVSOP_OrderBilling00.ParamByName( 'V_COSTREF' ).AsDateTime     := dttaxaHora.Date;
        FDQueryVSOP_OrderBilling00.ParamByName( 'V_BOMREF' ).AsDateTime      := DtRefBOM.Date;
        FDQueryVSOP_OrderBilling00.ParamByName( 'V_TSOP_GMHBUD' ).AsString   := VAR_TSOP_GMHBUD;
        FDQueryVSOP_OrderBilling00.Open;

        FDQueryBOM.Close;
        Mensagem( 'Obtendo dados (BOM)...' );
        FDQueryBOM.ParamByName( 'V_DATA1' ).AsDateTime      := DtRefBOM.Date;
        FDQueryBOM.ParamByName( 'V_DATA2' ).AsDateTime      := DtRefBOM.Date;
        FDQueryBOM.ParamByName( 'V_TSOP_GMHBUD' ).AsString  := VAR_TSOP_GMHBUD;
        FDQueryBOM.Open;

        FDQueryCosting.Close;
        Mensagem( 'Obtendo dados (Costing)...' );
        FDQueryCosting.ParamByName( 'V_DATA' ).AsDateTime       := DtRefCosting.Date;
        FDQueryCosting.ParamByName( 'V_TSOP_GMHBUD' ).AsString  := VAR_TSOP_GMHBUD;
        FDQueryCosting.Open;

        FDQueryRouting.Close;
        Mensagem( 'Obtendo dados (Routing)...' );
        FDQueryRouting.ParamByName( 'V_DATA1' ).AsDateTime      := DtRefBOM.Date;
        FDQueryRouting.ParamByName( 'V_DATA2' ).AsDateTime      := DtRefBOM.Date;
        FDQueryRouting.ParamByName( 'V_TSOP_GMHBUD' ).AsString  := VAR_TSOP_GMHBUD;
        FDQueryRouting.Open;
    end
    else if pNivel = 2 then
    begin
        FDQueryBOM.Close;
        Mensagem( 'Obtendo dados (BOM)...' );
        FDQueryBOM.ParamByName( 'V_DATA1' ).AsDateTime      := DtRefBOM.Date;
        FDQueryBOM.ParamByName( 'V_DATA2' ).AsDateTime      := DtRefBOM.Date;
        FDQueryBOM.ParamByName( 'V_TSOP_GMHBUD' ).AsString  := VAR_TSOP_GMHBUD;
        FDQueryBOM.Open;
    end
    else if pNivel = 3 then
    begin
        FDQueryCosting.Close;
        Mensagem( 'Obtendo dados (Costing)...' );
        FDQueryCosting.ParamByName( 'V_DATA' ).AsDateTime       := DtRefCosting.Date;
        FDQueryCosting.ParamByName( 'V_TSOP_GMHBUD' ).AsString  := VAR_TSOP_GMHBUD;
        FDQueryCosting.Open;
    end
    else if pNivel = 4 then
    begin
        FDQueryRouting.Close;
        Mensagem( 'Obtendo dados (Routing)...' );
        FDQueryRouting.ParamByName( 'V_DATA1' ).AsDateTime      := DtRefBOM.Date;
        FDQueryRouting.ParamByName( 'V_DATA2' ).AsDateTime      := DtRefBOM.Date;
        FDQueryRouting.ParamByName( 'V_TSOP_GMHBUD' ).AsString  := VAR_TSOP_GMHBUD;
        FDQueryRouting.Open;
    end;

  finally

    Mensagem( EmptyStr );

  end;


end;

procedure TFr_RelatGrossMargin.ButExcelClick(Sender: TObject);
var
  // dxSpreadSheet: TdxSpreadSheet;
   I , X : Integer;
   varCor1,varCor2: TColor;
begin

  if cxButtonEditPath.Text = EmptyStr then
    raise Exception.Create('Informe o arquivo primeiro.');


  if (FDQueryVSOP_OrderBilling00.IsEmpty and
     FDQueryBOM.IsEmpty and
     FDQueryCosting.IsEmpty and
     FDQueryRouting.IsEmpty) then
       raise Exception.Create('N�o h� dados para serem exportados ao Excel');

  Mensagem( 'Iniciando processo de exporta��o...' );
  try

    Mensagem( 'Criando planilha...' );
    DeleteFile(PWideChar(MyDocumentsPath+'\GM_PowerQuery.xlsx'));
    CopyFile( PWideChar('\\ghos2024\Brady\GM_PowerQuery.xlsx'), PWideChar(MyDocumentsPath+'\GM_PowerQuery.xlsx'), True );

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    try
      if cxCheckBoxGerar.Checked then
      begin

        Mensagem( 'Exportando planilha, processo pode demorar alguns minutos ( Gross Margin )' );
        dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\GM_PowerQuery.xlsx' );
        dxSpreadSheet.BeginUpdate;

        if FDQueryVSOP_OrderBilling00.IsEmpty Then
          raise Exception.Create('N�o h� dados de Gross Margin para serem exportados ao Excel');

        if  FDQueryBOM.IsEmpty Then
          raise Exception.Create('N�o h� dados de BOM para serem exportados ao Excel');

        if FDQueryCosting.IsEmpty Then
          raise Exception.Create('N�o h� dados de Costing para serem exportados ao Excel');

        if FDQueryRouting.IsEmpty then
          raise Exception.Create('N�o h� dados de Routing para serem exportados ao Excel');

        CreatePlanilhaGrossMargin;
        dxSpreadSheet.BeginUpdate;
        dxSpreadSheet.SaveToFile( cxButtonEditPath.Text );
        FreeAndNil(dxSpreadSheet);
        dxSpreadSheet := TdxSpreadSheet.Create(nil);
        dxSpreadSheet.LoadFromFile( cxButtonEditPath.Text );
        Mensagem( 'Exportando planilha, processo pode demorar alguns minutos ( BOM )' );
        CreatePlanilhaBOM;
        dxSpreadSheet.BeginUpdate;
        dxSpreadSheet.SaveToFile( cxButtonEditPath.Text );
        FreeAndNil(dxSpreadSheet);
        dxSpreadSheet := TdxSpreadSheet.Create(nil);
        dxSpreadSheet.LoadFromFile( cxButtonEditPath.Text );

        Mensagem( 'Exportando planilha, processo pode demorar alguns minutos ( Costing )' );
        CreatePlanilhaCosting;
        dxSpreadSheet.BeginUpdate;
        dxSpreadSheet.SaveToFile( cxButtonEditPath.Text );
        FreeAndNil(dxSpreadSheet);
        dxSpreadSheet := TdxSpreadSheet.Create(nil);
        dxSpreadSheet.LoadFromFile( cxButtonEditPath.Text );
        dxSpreadSheet.BeginUpdate;

        Mensagem( 'Exportando planilha, processo pode demorar alguns minutos ( Routing )' );
        CreatePlanilhaRouting;
        dxSpreadSheet.BeginUpdate;



      end
      else
      if cxPageControl.ActivePage = cxTabSheetGrossMargin Then
      begin

         Mensagem( 'Exportando planilha do Gross Margin...' );
         dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\GM_PowerQuery.xlsx' );
         dxSpreadSheet.BeginUpdate;
         CreatePlanilhaGrossMargin;

      end
      else if cxPageControl.ActivePage = cxTabSheetBom then
      begin

         Mensagem( 'Exportando planilha do BOM...' );
         dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\GM_PowerQuery.xlsx' );
         dxSpreadSheet.BeginUpdate;
         CreatePlanilhaBOM;

      end
      else
      if cxPageControl.ActivePage = cxTabSheetCosting then
      begin

          Mensagem( 'Exportando planilha do Costing...' );
          dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\GM_PowerQuery.xlsx' );
          dxSpreadSheet.BeginUpdate;
          CreatePlanilhaCosting;


      end
      else
      if cxPageControl.ActivePage = cxTabSheetRouting then
      begin

          Mensagem( 'Exportando planilha do Routing...' );
          dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\GM_PowerQuery.xlsx' );
          dxSpreadSheet.BeginUpdate;
          CreatePlanilhaRouting;


      end;



      Mensagem( 'Salvando a planilha...' );
      dxSpreadSheet.SaveToFile( cxButtonEditPath.Text );

    finally

      FreeAndNil(dxSpreadSheet);

    end;

  finally

    Mensagem( EmptyStr );

  end;

end;

procedure TFr_RelatGrossMargin.CreatePlanilhaBOM;
var
   I , X : Integer;
   varCor1,varCor2: TColor;
begin

      dxSpreadSheet.Sheets[1].Active := True;

      for I := 0 to 10 do
      begin

        with dxSpreadSheet.ActiveSheetAsTable.CreateCell(0,I) do;

      end;

      FDQueryBOM.First;
      varCor1 := RGB( 255, 255, 204 );
      varCor2 := RGB(255,255,225);

      X := 1;
      while not FDQueryBOM.eof do
      begin

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryBOMPlanta .AsString;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryBOMYNumberPA .AsString;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,2) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryBOMUN.AsString;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,3) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryBOMYNumberMP.AsString;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,4) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryBOMUNMP.AsString;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,5) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryBOMCostLotSize.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,6) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryBOMQtdeFixaSN.AsString;
          end;


          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,7) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryBOMQtderMP.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,8) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryBOMCusto.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,9) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryBOMCustoSTD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,10) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryBOMOrdem.AsString;
          end;
          {
         with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,11) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := 'dd/mm/yyyy';
             AsVariant := FormatDateTime('dd/mm/yyyy', FDQueryBOMDataProcessamento.AsDateTime);
          end;
           }

          if Odd(X) then
            varCor1 := RGB(255,255,225)
          else
            varCor1 := RGB(216,234,204);

          Inc(X);
          FDQueryBOM.Next;
      end;

end;

procedure TFr_RelatGrossMargin.CreatePlanilhaCosting;
var
   I , X : Integer;
   varCor1,varCor2: TColor;
begin

  dxSpreadSheet.Sheets[2].Active := True;

  for I := 0 to 6 do
  begin

    with dxSpreadSheet.ActiveSheetAsTable.CreateCell(0,I) do;

  end;


  FDQueryCosting.First;
  varCor1 := RGB( 255, 255, 204 );
  varCor2 := RGB(255,255,225);

  X := 1;
  while not FDQueryCosting.Eof do
  begin


    with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
    begin
       Style.Brush.BackgroundColor := varCor1;
       AsVariant := FDQueryCostingCodItemYNumber.AsString;
    end;

    with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
    begin
       Style.Brush.BackgroundColor := varCor1;
       AsVariant := FDQueryCostingSite.AsString;
    end;

    with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,2) do
    begin
       Style.Brush.BackgroundColor := varCor1;
       AsVariant := FDQueryCostingUOM.AsString;
    end;

    with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,3) do
    begin
       Style.Brush.BackgroundColor := varCor1;
       Style.DataFormat.FormatCode := '#,##0.00';
       AsVariant := FDQueryCostingCostLotSize.AsFloat;
    end;

    with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,4) do
    begin
       Style.Brush.BackgroundColor := varCor1;
       Style.DataFormat.FormatCode := '#,##0.00';
       AsVariant := FDQueryCostingStandard.AsFloat;
    end;

    with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,5) do
    begin
       Style.Brush.BackgroundColor := varCor1;
       Style.DataFormat.FormatCode := '#,##0.00';
       AsVariant := FDQueryCostingMoving.AsFloat;
    end;

    with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,6) do
    begin
       Style.Brush.BackgroundColor := varCor1;
       Style.DataFormat.FormatCode := '#,##0.00';
       AsVariant := FDQueryCostingPriceUnit.AsFloat;
    end;

   { with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,7) do
    begin
       Style.Brush.BackgroundColor := varCor1;
       Style.DataFormat.FormatCode := 'dd/mm/yyyy';
       AsVariant := FormatDateTime('dd/mm/yyyy', FDQueryCostingTSOP_DTIMPORTACAO.AsDateTime);
    end;
    }
    if Odd(X) then
      varCor1 := RGB(255,255,225)
    else
      varCor1 := RGB(216,234,204);

    Inc(X);

    FDQueryCosting.Next;
  end;

end;

procedure TFr_RelatGrossMargin.CreatePlanilhaGrossMargin;
var
   I , X : Integer;
   varCor1,varCor2: TColor;
begin


      dxSpreadSheet.Sheets[0].Active := True;

      for I := 0 to 55 do
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
             AsVariant := FDQueryVSOP_OrderBilling00MTO_MTS.AsString;

          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,8) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryVSOP_OrderBilling00FY.AsString;

          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,9) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryVSOP_OrderBilling00QTR.AsString;

          end;


          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,10) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,###,###';
             AsVariant := FDQueryVSOP_OrderBilling00COST_LOT_SIZE.AsFloat;

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
             AsVariant := FDQueryVSOP_OrderBilling00UOM.AsString;

          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,13) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00NET_SALE.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,14) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00MATERIAL_SETUP.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,15) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00MATERIAL_RESALE_RUN_SCRAP.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,16) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00TOTAL_MATERIAL.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,17) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00MACHINE_SETUP.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,18) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00MACHINE_RUN.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,19) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00TOTAL_MACHINE.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,20) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00LABOR_SETUP.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,21) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00LABOR_RUN.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,22) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00TOTAL_LABOR.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,23) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00DIRECT_COST.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,24) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00CM_VALOR.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,25) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00CM_PERCENTUAL.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,26) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00INDIRECT_COST.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,27) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00TOTAL_COST.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,28) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00GM_VALOR.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,29) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00GM_PERCENTUAL.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,30) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryVSOP_OrderBilling00Regi�o.AsString;

          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,31) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryVSOP_OrderBilling00UF.AsString;

          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,32) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryVSOP_OrderBilling00MRP_Controler.AsString;

          end;

         with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,33) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsString := FDQueryVSOP_OrderBilling00DTREF.AsString;

          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,34) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00UNIT_PRICE.AsFloat;
          end;

         with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,35) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00UNIT_COST.AsFloat;
          end;

         with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,36) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00Standard.AsFloat;
          end;

         with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,37) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00PriceUnit.AsFloat;
          end;

         with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,38) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryVSOP_OrderBilling00UOM_1.AsString;

          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,39) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00MaterialSETUPSTD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,40) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00MaterialResaleRUNScrapSTD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,41) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00TOTAL_MATERIAL_STD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,42) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00MachineSETUPSTD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,43) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00MachineRUNSTD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,44) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00TotalMachineSTD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,45) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00LaborSETUPSTD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,46) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00LaborRUNSTD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,47) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00TotalLaborSTD.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,48) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00DIRECT_COST_STD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,49) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00CM_VALOR_STD.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,50) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00CM_PERCENTUAL_STD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,51) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00INDIRECT_COST_STD.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,52) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00TOTAL_COST_STD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,53) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00GM_VALOR_STD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,54) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00GM_PERCENTUAL_STD.AsFloat;
          end;


          if Odd(X) then
            varCor1 := RGB(255,255,225)
          else
            varCor1 := RGB(216,234,204);

          Inc(X);
          FDQueryVSOP_OrderBilling00.Next;
      end;

end;

procedure TFr_RelatGrossMargin.CreatePlanilhaRouting;
var
   I , X : Integer;
   varCor1,varCor2: TColor;
begin

  dxSpreadSheet.Sheets[3].Active := True;

  for I := 0 to 16 do
  begin

    with dxSpreadSheet.ActiveSheetAsTable.CreateCell(0,I) do;

  end;

  FDQueryRouting.First;
  varCor1 := RGB( 255, 255, 204 );
  varCor2 := RGB(255,255,225);

  X := 1;
  while not FDQueryRouting.eof do
  begin

      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
      begin
         Style.Brush.BackgroundColor := varCor1;
         AsVariant := FDQueryRoutingSite.AsString;
      end;
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
      begin
         Style.Brush.BackgroundColor := varCor1;
         AsVariant := FDQueryRoutingYNumber.AsString;
      end;
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,2) do
      begin
         Style.Brush.BackgroundColor := varCor1;
         AsVariant := FDQueryRoutingUN.AsString;
      end;
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,3) do
      begin
         Style.Brush.BackgroundColor := varCor1;
         AsVariant := FDQueryRoutingWorkCenter.AsString;
      end;
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,4) do
      begin
         Style.Brush.BackgroundColor := varCor1;
         AsVariant := FDQueryRoutingCentroCusto.AsString;
      end;
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,5) do
      begin
         Style.Brush.BackgroundColor := varCor1;
         AsVariant := FDQueryRoutingCostLotSize.AsFloat;
      end;
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,6) do
      begin
         Style.Brush.BackgroundColor := varCor1;
        // Style.DataFormat.FormatCode := '#,###.####';
         AsVariant := FDQueryRoutingSetupMIN.AsFloat;
      end;
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,7) do
      begin
         Style.Brush.BackgroundColor := varCor1;
         Style.DataFormat.FormatCode :=  '#,###.####';
        // AsVariant := FDQueryRoutingMachineMIN.AsFloat;
      end;
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,8) do
      begin
         Style.Brush.BackgroundColor := varCor1;
        // Style.DataFormat.FormatCode := '#,###.####';
         AsVariant := FDQueryRoutingLaborMIN.AsFloat;
      end;
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,9) do
      begin
         Style.Brush.BackgroundColor := varCor1;
        // Style.DataFormat.FormatCode :=  '#,###.####';
         AsVariant := FDQueryRoutingOverheadMIN.AsFloat;
      end;
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,10) do
      begin
         Style.Brush.BackgroundColor := varCor1;
         Style.DataFormat.FormatCode :=  '#,###.####';
         AsVariant := FDQueryRoutingSetupcost.AsFloat;
      end;
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,11) do
      begin
         Style.Brush.BackgroundColor := varCor1;
         Style.DataFormat.FormatCode :=  '#,###.####';
         AsVariant := FDQueryRoutingSetupMachineCost.AsFloat;
      end;
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,12) do
      begin
         Style.Brush.BackgroundColor := varCor1;
         Style.DataFormat.FormatCode := '#,###.####';
         AsVariant := FDQueryRoutingSetupLaborCost.AsFloat;
      end;
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,13) do
      begin
         Style.Brush.BackgroundColor := varCor1;
         Style.DataFormat.FormatCode := '#,###.####';
         AsVariant := FDQueryRoutingSetupOverheadCost.AsFloat;
      end;
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,14) do
      begin
         Style.Brush.BackgroundColor := varCor1;
         Style.DataFormat.FormatCode := '#,###.####';
         AsVariant := FDQueryRoutingRunMachineCost.AsFloat;
      end;
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,15) do
      begin
         Style.Brush.BackgroundColor := varCor1;
         Style.DataFormat.FormatCode :=  '#,###.####';
         AsVariant := FDQueryRoutingRunLaborCost.AsFloat;
      end;
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,16) do
      begin
         Style.Brush.BackgroundColor := varCor1;
         Style.DataFormat.FormatCode := '#,###.####';
         AsVariant := FDQueryRoutingRunOverheadCost.AsString;
      end;
    {
      with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,17) do
      begin
        Style.Brush.BackgroundColor := varCor1;
        Style.DataFormat.FormatCode := 'dd/mm/yyyy';
        AsVariant := FormatDateTime('dd/mm/yyyy', FDQueryRoutingDataProcessamento.AsDateTime);
      end;
     }

      if Odd(X) then
        varCor1 := RGB(255,255,225)
      else
        varCor1 := RGB(216,234,204);

      Inc(X);

      FDQueryRouting.Next;
  end;

end;

procedure TFr_RelatGrossMargin.cxBtnLiberarConsultaGMClick(Sender: TObject);
var
  varLiberar : Integer;
begin

  if FDQueryVSOP_OrderBilling00.IsEmpty then
     raise Exception.Create('Realizar a consulta na tela para liberar');
  

  varLiberar := -1;

  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
  FDQueryAux.SQL.Add('Select * From TSOP_LiberarConsGM Where DataProcessamento = :DataProcessamento');
  FDQueryAux.Params.ParamByName('DataProcessamento').AsDate := DtRefBOM.Date;
  FDQueryAux.Open;
  if not FDQueryAux.IsEmpty then
    varLiberar :=  FDQueryAux.FieldByName('Liberar').AsInteger;

  if varLiberar <> -1 then
  begin
     if  varLiberar = 1 then
     begin
         if messagedlg(pChar('Deseja Bloquear a Consulta do GM da Data: ' + DateToStr(DtRefBOM.Date)  + ' ?'),mtConfirmation,[mbyes,mbno],0) = mrYes then
         begin
            FDQueryAux.Close;
            FDQueryAux.SQL.Clear;
            FDQueryAux.SQL.Add('Update TSOP_LiberarConsGM ');
            FDQueryAux.SQL.Add(' Set Liberar = 0');
            FDQueryAux.SQL.Add(' Where DataProcessamento = :DataProcessamento');
            FDQueryAux.Params.ParamByName('DataProcessamento').AsDate := DtRefBOM.Date;
            Try
              try
                 FDQueryAux.ExecSQL;
              finally
                 MessageDlg( 'Consulta bloqueada com sucesso!' + #13 + #13 , mtInformation, [ mbOk ], 0 );
              end;
            except
               on E: Exception do
                begin
                   MessageDlg( 'Erro ao tentar bloquear consulta do GM.' + #13 + #13 +E.Message, mtError, [ mbOk ], 0 );
                end;
            End;

         end;

     end
     else if varLiberar = 0 then
     begin
         if messagedlg(pChar('Deseja Liberar a Consulta do GM da Data: ' + DateToStr(DtRefBOM.Date)  + ' ?'),mtConfirmation,[mbyes,mbno],0) = mrYes then
         begin
            FDQueryAux.Close;
            FDQueryAux.SQL.Clear;
            FDQueryAux.SQL.Add('Update TSOP_LiberarConsGM ');
            FDQueryAux.SQL.Add(' Set Liberar = 1');
            FDQueryAux.SQL.Add(' Where DataProcessamento = :DataProcessamento');
            FDQueryAux.Params.ParamByName('DataProcessamento').AsDate := DtRefBOM.Date;
            Try
              try
                 FDQueryAux.ExecSQL;
              finally
                 MessageDlg( 'Consulta liberada com sucesso!' + #13 + #13 , mtInformation, [ mbOk ], 0 );
              end;
            except
               on E: Exception do
                begin
                   MessageDlg( 'Erro ao tentar liberar consulta do GM.' + #13 + #13 +E.Message, mtError, [ mbOk ], 0 );
                end;
            End;
         end;
     end;

  end
  else
  begin
    MessageDlg( 'Consulta do GM n�o encontrada para libera��o.' + #13 + #13, mtInformation, [ mbOk ], 0 );
  end;

end;

procedure TFr_RelatGrossMargin.cxbtnProcessarGMClick(Sender: TObject);
var
 I : Integer;
begin
     // se nao existir, precisa copiar os dados dos originais e chamar a rotina para processar ultimo historico.

     try
        Mensagem( 'Reindexando arquivos...' );
        FDScriptInsert.Params.ParamByName('Banco').AsString := Str_Pal(FDConnection.Params[4],2,'=');
        FDScriptInsert.ExecuteAll;

     finally
        Mensagem( EmptyStr );
     end;

    try
      FDStoredProcGet.Close;
      FDStoredProcGet.Connection := FDConnection;
      FDStoredProcGet.StoredProcName := AnsiUpperCase( 'PSOP_RECUPERAGM' );
      for I := 0 to FDStoredProcGet.Params.Count-1 do
        FDStoredProcGet.Params.ClearValues(i);

      FDStoredProcGet.Prepare;
    except
      on E : Exception do
        begin
          MessageDlg( 'Stored procedure error: ' + #13 + #13 +
                       E.Message, mtError, [ mbOk ], 0 );
        end;
    end;


    FDStoredProcGet.ParamByName( '@DATA' ).AsString          := FormatDateTime('yyyy-mm-dd 00:00:00', DtRefBOM.Date);
    FDStoredProcGet.ParamByName( '@DATAAPLICADA' ).IsNull;
    FDStoredProcGet.ParamByName( '@PROCESSADO' ).AsBoolean := False; // Arquivo n�o processado


    Try
        Try
           FDStoredProcGet.ExecProc;

        except
          on E : Exception do
            begin
              MessageDlg( 'Stored procedure error: ' + #13 + #13 +
                           E.Message, mtError, [ mbOk ], 0 );
            end;
        end;

    Finally
        Mensagem( EmptyStr );
    End;


    // processo em m�dia demora 4 horas!!!
    Try
      Mensagem( 'Calculando Custo...' );
      FDScriptInsert.ExecuteAll;

      Mensagem( 'Calculo Finalizado.' );
    Finally
      Mensagem( EmptyStr );
    End;

    Mensagem( 'Gravando Historico GM.' );
    Try
      FDStoredGavaHistoricoGM.Close;
      FDStoredGavaHistoricoGM.Connection := FDConnection;
      FDStoredGavaHistoricoGM.StoredProcName := AnsiUpperCase( 'PSOP_HISTORICOGM' );
      for I := 0 to FDStoredGavaHistoricoGM.Params.Count-1 do
        FDStoredGavaHistoricoGM.Params.ClearValues(i);

      FDStoredGavaHistoricoGM.Prepare;
    Except
      on E : Exception do
        begin
          MessageDlg( 'Stored procedure error: ' + #13 + #13 +
                       E.Message, mtError, [ mbOk ], 0 );
        end;
    End;


    FDStoredGavaHistoricoGM.ParamByName( '@DATA' ).AsString          := FormatDateTime('yyyy-mm-dd 00:00:00', DtRefBOM.Date);
    FDStoredGavaHistoricoGM.ParamByName( '@DATA_APLICADA' ).AsString := FormatDateTime('yyyy-mm-dd 00:00:00', dttaxaHora.Date);
    FDStoredGavaHistoricoGM.ParamByName( '@PROCESSADO' ).AsBoolean   := True; // Arquivo n�o processado
    Try
        Try
           FDStoredGavaHistoricoGM.ExecProc;

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

procedure TFr_RelatGrossMargin.cxButtonEditPathClick(Sender: TObject);
begin
  if SaveDialog.Execute(Handle) then
  begin
    cxButtonEditPath.Text := SaveDialog.FileName;
  end;
end;

procedure TFr_RelatGrossMargin.cxButtonRefreshClick(Sender: TObject);
begin
    AbrirDataSet;
end;

procedure TFr_RelatGrossMargin.cxCheckBoxConsultarClick(Sender: TObject);
begin
  if cxCheckBoxConsultar.Checked  then
    pNivel := 1
  else pNivel := 0;

end;

procedure TFr_RelatGrossMargin.cxDateEditTSOP_ORDBILDATDOCFIMExit(
  Sender: TObject);
begin
    cxDateEditTSOP_ORDBILDATDOCINI.Date := System.DateUtils.StartOfTheMonth(cxDateEditTSOP_ORDBILDATDOCINI.Date);
    DtRefBOM.Date   := cxDateEditTSOP_ORDBILDATDOCINI.Date;
    dttaxaHora.Date := cxDateEditTSOP_ORDBILDATDOCINI.Date;
    DtRefCosting.Date := cxDateEditTSOP_ORDBILDATDOCINI.Date;

end;

procedure TFr_RelatGrossMargin.cxPageControlChange(Sender: TObject);
begin
  if ((cxCheckBoxConsultar.Checked = False) and (cxPageControl.ActivePage = cxTabSheetGrossMargin)) then
  begin
      pNivel := 0;
  end
  else
  if ((cxCheckBoxConsultar.Checked = False) and (cxPageControl.ActivePage = cxTabSheetBom)) Then
  begin
      pNivel := 2;
  end
  else  if ((cxCheckBoxConsultar.Checked = False) and (cxPageControl.ActivePage = cxTabSheetCosting )) Then
  begin
      pNivel := 3;
  end
  else  if ((cxCheckBoxConsultar.Checked = False) and (cxPageControl.ActivePage = cxTabSheetRouting)) Then
  begin
      pNivel := 4;
  end;

end;

function TFr_RelatGrossMargin.DescricaoMes(MesExtenso, Ano: string): TDateTime;
var
    Dia, Mes : String;
    Dias_de_Semana: array[1..12] of  String ;
begin
    if MesExtenso <> '' then
    begin


      if MesExtenso = 'Janeiro' then
         Mes := '1'
      else if MesExtenso = 'Fevereiro' Then
         Mes := '2'
      else if MesExtenso = 'Mar�o' Then
         Mes := '3'
      else if MesExtenso = 'Abril' Then
         Mes := '4'
      else if MesExtenso = 'Maio' Then
         Mes := '5'
      else if MesExtenso = 'Junho' Then
         Mes := '6'
      else if MesExtenso = 'Julho' Then
         Mes := '7'
      else if MesExtenso = 'Agosto' Then
         Mes := '8'
      else if MesExtenso = 'Setembro' Then
         Mes := '9'
      else if MesExtenso = 'Outubro' Then
         Mes := '10'
      else if MesExtenso = 'Novembro' Then
         Mes := '11'
      else if MesExtenso = 'Dezembro' Then
         Mes := '12';


      result := StrToDate('1' + '/' + Mes + '/' + Ano);
    end;

end;

procedure TFr_RelatGrossMargin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Fr_RelatGrossMargin := nil;
  Action := caFree;
end;

procedure TFr_RelatGrossMargin.FormCreate(Sender: TObject);
var
  I: Integer;
  VarMesAnterior : TDateTime;

begin

  if not FDConnection.Connected then
  begin

    FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
    FDConnection.Open;

  end;

  LoadGridCustomization;
  VarMesAnterior :=  StartOfTheMonth(Now)-1;
  cxDateEditTSOP_ORDBILDATDOCINI.Date := StartOfTheMonth(VarMesAnterior);
  cxDateEditTSOP_ORDBILDATDOCFIM.Date := EndOfTheMonth(VarMesAnterior);

  cxPageControl.ActivePage := cxTabSheetGrossMargin;
  dttaxaHora.Date   :=  StartOfTheMonth(VarMesAnterior);
  DtRefBOM.Date     :=  StartOfTheMonth(VarMesAnterior);
  DtRefCosting.Date :=  StartOfTheMonth(VarMesAnterior);


  if not Fr_Brady.SalesRep then
  begin
    for I := 0 to cxTableViewGrossMargin00.ColumnCount-1 do
    begin
      cxTableViewGrossMargin00.Columns[I].VisibleForCustomization := True;
      cxTableViewGrossMargin00.Columns[I].Visible := True;
    end;
  end;

  pNivel := 0;

end;

procedure TFr_RelatGrossMargin.LoadGridCustomization;
begin
  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxTableViewGrossMargin00.Name + '.ini' ) then
    cxTableViewGrossMargin00.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxTableViewGrossMargin00.Name + '.ini' );

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxTableViewBom.Name + '.ini' ) then
    cxTableViewBom.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxTableViewBom.Name + '.ini' );

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxTableViewCosting.Name + '.ini' ) then
    cxTableViewCosting.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxTableViewCosting.Name + '.ini' );

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxTableViewRouting.Name + '.ini' ) then
    cxTableViewRouting.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxTableViewRouting.Name + '.ini' );

end;

procedure TFr_RelatGrossMargin.Mensagem(pMensagem: String);
begin
  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;
end;

function TFr_RelatGrossMargin.RetornaMes(Mes: Word): String;
var
 varMes : String;
begin
    case Mes of
      1 : varMes:= 'Janeiro';
      2 : varMes:= 'Fevereiro';
      3 : varMes:= 'Mar�o';
      4 : varMes:= 'Abril';
      5 : varMes:= 'Maio';
      6 : varMes:= 'Junho';
      7 : varMes:= 'Julho';
      8 : varMes:= 'Agosto';
      9 : varMes:= 'Setembro';
     10 : varMes:= 'Outubro';
     11 : varMes:= 'Novembro';
     12 : varMes:= 'Dezembro';
    end;


    result := varMes;


end;

end.
