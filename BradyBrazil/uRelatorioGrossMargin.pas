unit uRelatorioGrossMargin;

interface

uses
  System.IOUtils,
  System.DateUtils,

  dxSpreadSheet,
  dxSpreadSheetTypes,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinscxPCPainter, dxBarBuiltInMenu, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxContainer, cxClasses, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxCustomPivotGrid, cxDBPivotGrid, cxLabel,
  dxGDIPlusClasses, Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGrid, cxPC, dxSkinsDefaultPainters, dxSkinOffice2013White, Vcl.ComCtrls, dxCore, cxDateUtils, Vcl.Menus, Vcl.StdCtrls,
  cxButtons, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxCheckBox, cxCheckComboBox, FireDAC.Comp.ScriptCommands,
  FireDAC.Comp.Script, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue,cxGridExportLink, cxButtonEdit,
  Vcl.ImgList,ShellApi;

type
  TFr_RelatorioGrossMargin = class(TForm)
    FDConnection: TFDConnection;
    FDQueryVSOP_OrderBilling00: TFDQuery;
    DataSourceVSOP_OrderBilling00: TDataSource;
    cxPageControlFiltro: TcxPageControl;
    FDQueryVSOP_OrderBilling00SITE: TStringField;
    FDQueryVSOP_OrderBilling00CANAL: TStringField;
    FDQueryVSOP_OrderBilling00COD_CLIENTE: TStringField;
    FDQueryVSOP_OrderBilling00RAZAO_SOCIAL: TStringField;
    FDQueryVSOP_OrderBilling00GRUPO_CLIENTE: TStringField;
    FDQueryVSOP_OrderBilling00ACC_OWNER: TStringField;
    FDQueryVSOP_OrderBilling00COD_ITEM: TStringField;
    FDQueryVSOP_OrderBilling00MTO_MTS: TStringField;
    FDQueryVSOP_OrderBilling00FY: TIntegerField;
    FDQueryVSOP_OrderBilling00QTR: TStringField;
    FDQueryVSOP_OrderBilling00DTREF: TSQLTimeStampField;
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
    SaveDialog: TSaveDialog;
    FDQueryVSOP_OrderBilling00Regi�o: TStringField;
    FDQueryVSOP_OrderBilling00UF: TStringField;
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
    FDQueryBOM: TFDQuery;
    DataSourceBOM: TDataSource;
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
    FDQueryCosting: TFDQuery;
    FDQueryRouting: TFDQuery;
    DataSourceCosting: TDataSource;
    DataSourceRouting: TDataSource;
    FDQueryCostingCodItemYNumber: TStringField;
    FDQueryCostingSite: TStringField;
    FDQueryCostingUOM: TStringField;
    FDQueryCostingCostLotSize: TBCDField;
    FDQueryCostingStandard: TFloatField;
    FDQueryCostingMoving: TFloatField;
    FDQueryCostingPriceUnit: TFloatField;
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
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    cxSmallImages: TcxImageList;
    FDScriptInsert: TFDScript;
    FDQueryGMHoras: TFDQuery;
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
    cxLabel1: TcxLabel;
    cxDateEditTSOP_ORDBILDATDOCINI: TcxDateEdit;
    cxLabel2: TcxLabel;
    cxDateEditTSOP_ORDBILDATDOCFIM: TcxDateEdit;
    cxComboBoxTipo: TcxComboBox;
    cxLabel3: TcxLabel;
    ButExcel: TcxButton;
    cxLabel4: TcxLabel;
    cxButtonEditPath: TcxButtonEdit;
    cxCheckBoxGerar: TcxCheckBox;
    FDScriptDelete: TFDScript;
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
    cxLabel5: TcxLabel;
    dtRefTaxaHora: TcxDateEdit;
    cxLabel6: TcxLabel;
    DtRefBOM: TcxDateEdit;
    Shape1: TShape;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure cxButtonRefreshClick(Sender: TObject);
    procedure ButExcelClick(Sender: TObject);
    procedure cxButtonEditPathClick(Sender: TObject);
    procedure cxButtonProcessarBOM1Click(Sender: TObject);
    procedure cxButtonProcessarBOM2Click(Sender: TObject);
    procedure cxButtonProcessarITEMClick(Sender: TObject);
    procedure cxButtonProcessarROUTINGClick(Sender: TObject);
    procedure cxButtonProcessarCUSTOClick(Sender: TObject);
    procedure cxButtonProcessarUOMClick(Sender: TObject);
    procedure cxButtonAtualizaBOMClick(Sender: TObject);
    procedure cxButtonAtualizaBOM2Click(Sender: TObject);
    procedure cxButtonAtualizaItemClick(Sender: TObject);
    procedure cxButtonAtualizaOrdemMPRClick(Sender: TObject);
    procedure cxButtonAtualizaMPRClick(Sender: TObject);
    procedure cxButtonAtualizaRoutingClick(Sender: TObject);
    procedure cxButtonAtualizaCustoClick(Sender: TObject);
    procedure cxButtonAtualizaUOMClick(Sender: TObject);
    procedure cxButtonInicioClick(Sender: TObject);
    procedure cxButtonInsertSQLClick(Sender: TObject);
    procedure cxButtonVerBom1Click(Sender: TObject);
    procedure cxButtonProcessarClick(Sender: TObject);
  private
    dxSpreadSheet: TdxSpreadSheet;
    procedure ImportarHoras;
    procedure Mensagem( pMensagem: String );
    procedure CreatePlanilhaGrossMargin;
    procedure CreatePlanilhaBOM;
    procedure CreatePlanilhaCosting;
    procedure CreatePlanilhaRouting;
    { Private declarations }
  public
    procedure AbrirDataset;
    procedure LoadGridCustomization;
    { Public declarations }
  end;

var
  Fr_RelatorioGrossMargin: TFr_RelatorioGrossMargin;

implementation

{$R *.dfm}

uses uBrady, uUtils, uUtilsOwner;

procedure TFr_RelatorioGrossMargin.AbrirDataset;
var
 VAR_TSOP_GMHBUD  : String;
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



    if cxPageControl.ActivePage = cxTabSheetGrossMargin then
    begin
      FDQueryVSOP_OrderBilling00.Close;
      Mensagem( 'Obtendo dados (Gross Margin)...' );
      FDQueryVSOP_OrderBilling00.ParamByName( 'V_BILLING_INI' ).AsDateTime := cxDateEditTSOP_ORDBILDATDOCINI.Date;
      FDQueryVSOP_OrderBilling00.ParamByName( 'V_BILLING_FIM' ).AsDateTime := cxDateEditTSOP_ORDBILDATDOCFIM.Date;
      FDQueryVSOP_OrderBilling00.ParamByName( 'V_COSTREF' ).AsDateTime     := dtRefTaxaHora.Date;
      FDQueryVSOP_OrderBilling00.ParamByName( 'V_BOMREF' ).AsDateTime      := DtRefBOM.Date;
      FDQueryVSOP_OrderBilling00.ParamByName( 'V_TSOP_GMHBUD' ).AsString   := VAR_TSOP_GMHBUD;
      FDQueryVSOP_OrderBilling00.Open;
    end
    else if cxPageControl.ActivePage = cxTabSheetBom then
    begin
      FDQueryBOM.Close;
      Mensagem( 'Obtendo dados (BOM)...' );
      FDQueryBOM.ParamByName( 'V_DATA1' ).AsDateTime      := cxDateEditTSOP_ORDBILDATDOCINI.Date;
      FDQueryBOM.ParamByName( 'V_DATA2' ).AsDateTime      := cxDateEditTSOP_ORDBILDATDOCINI.Date;
      FDQueryBOM.ParamByName( 'V_TSOP_GMHBUD' ).AsString  := VAR_TSOP_GMHBUD;
      FDQueryBOM.Open;
    end
    else if cxPageControl.ActivePage = cxTabSheetCosting then
    begin
      FDQueryCosting.Close;
      Mensagem( 'Obtendo dados (Costing)...' );
      FDQueryCosting.ParamByName( 'V_DATA' ).AsDateTime       := cxDateEditTSOP_ORDBILDATDOCINI.Date;
      FDQueryCosting.ParamByName( 'V_TSOP_GMHBUD' ).AsString  := VAR_TSOP_GMHBUD;
      FDQueryCosting.Open;
    end
    else if cxPageControl.ActivePage = cxTabSheetRouting then
    begin
      FDQueryRouting.Close;
      Mensagem( 'Obtendo dados (Routing)...' );
      FDQueryRouting.ParamByName( 'V_DATA1' ).AsDateTime      := cxDateEditTSOP_ORDBILDATDOCINI.Date;
      FDQueryRouting.ParamByName( 'V_DATA2' ).AsDateTime      := cxDateEditTSOP_ORDBILDATDOCINI.Date;
      FDQueryRouting.ParamByName( 'V_TSOP_GMHBUD' ).AsString  := VAR_TSOP_GMHBUD;
      FDQueryRouting.Open;
    end;


  finally

    Mensagem( EmptyStr );

  end;

end;

procedure TFr_RelatorioGrossMargin.ButExcelClick(Sender: TObject);
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

        Mensagem( 'Carregando planilha, processo pode demorar alguns minutos...' );
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
        CreatePlanilhaBOM;
        dxSpreadSheet.BeginUpdate;
        CreatePlanilhaCosting;
        dxSpreadSheet.BeginUpdate;

        dxSpreadSheet.SaveToFile( cxButtonEditPath.Text );
        FreeAndNil(dxSpreadSheet);
        dxSpreadSheet := TdxSpreadSheet.Create(nil);
        dxSpreadSheet.LoadFromFile( cxButtonEditPath.Text );
        dxSpreadSheet.BeginUpdate;
        CreatePlanilhaRouting;
        dxSpreadSheet.BeginUpdate;



      end
      else
      if cxPageControl.ActivePage = cxTabSheetGrossMargin Then
      begin

         Mensagem( 'Carregando planilha do Gross Margin...' );
         dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\GM_PowerQuery.xlsx' );
         dxSpreadSheet.BeginUpdate;
         CreatePlanilhaGrossMargin;

      end
      else if cxPageControl.ActivePage = cxTabSheetBom then
      begin

         Mensagem( 'Carregando planilha do BOM...' );
         dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\GM_PowerQuery.xlsx' );
         dxSpreadSheet.BeginUpdate;
         CreatePlanilhaBOM;

      end
      else
      if cxPageControl.ActivePage = cxTabSheetCosting then
      begin

          Mensagem( 'Carregando planilha do Costing...' );
          dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\GM_PowerQuery.xlsx' );
          dxSpreadSheet.BeginUpdate;
          CreatePlanilhaCosting;


      end
      else
      if cxPageControl.ActivePage = cxTabSheetRouting then
      begin

          Mensagem( 'Carregando planilha do Routing...' );
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

procedure TFr_RelatorioGrossMargin.CreatePlanilhaBOM;
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

          if Odd(X) then
            varCor1 := RGB(255,255,225)
          else
            varCor1 := RGB(216,234,204);

          Inc(X);
          FDQueryBOM.Next;
      end;




end;

procedure TFr_RelatorioGrossMargin.CreatePlanilhaCosting;
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

    if Odd(X) then
      varCor1 := RGB(255,255,225)
    else
      varCor1 := RGB(216,234,204);

    Inc(X);

    FDQueryCosting.Next;
  end;

end;

procedure TFr_RelatorioGrossMargin.CreatePlanilhaGrossMargin;
var
   I , X : Integer;
   varCor1,varCor2: TColor;
begin


      dxSpreadSheet.Sheets[0].Active := True;

      for I := 0 to 50 do
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
             AsVariant := FDQueryVSOP_OrderBilling00Regi�o.AsString;

          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,6) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryVSOP_OrderBilling00UF.AsString;

          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,7) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryVSOP_OrderBilling00ACC_OWNER.AsString;

          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,8) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryVSOP_OrderBilling00COD_ITEM.AsString;

          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,9) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryVSOP_OrderBilling00MTO_MTS.AsString;

          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,10) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryVSOP_OrderBilling00FY.AsString;

          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,11) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryVSOP_OrderBilling00QTR.AsString;

          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,12) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsString := FormatDateTime('dd/mm/yyyy', FDQueryVSOP_OrderBilling00DTREF.AsDateTime);

          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,13) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,###,###';
             AsVariant := FDQueryVSOP_OrderBilling00COST_LOT_SIZE.AsFloat;

          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,14) do
          begin
             Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,###,###';
             AsVariant := FDQueryVSOP_OrderBilling00TOTAL_VENDAS_QTD.AsFloat;

          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,15) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryVSOP_OrderBilling00UOM.AsString;

          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,16) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryVSOP_OrderBilling00MRP_Controler.AsString;

          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,17) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00NET_SALE.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,18) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00MATERIAL_SETUP.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,19) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00MATERIAL_RESALE_RUN_SCRAP.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,20) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00TOTAL_MATERIAL.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,21) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00MACHINE_SETUP.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,22) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00MACHINE_RUN.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,23) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00TOTAL_MACHINE.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,24) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00LABOR_SETUP.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,25) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00LABOR_RUN.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,26) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00TOTAL_LABOR.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,27) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00DIRECT_COST.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,28) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00CM_VALOR.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,29) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00CM_PERCENTUAL.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,30) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00INDIRECT_COST.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,31) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00TOTAL_COST.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,32) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00GM_VALOR.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,33) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00GM_PERCENTUAL.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,34) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00MaterialSETUPSTD.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,35) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00MaterialResaleRUNScrapSTD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,36) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00TOTAL_MATERIAL_STD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,37) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00MachineSETUPSTD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,38) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00MachineRUNSTD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,39) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00TotalMachineSTD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,40) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00LaborSETUPSTD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,41) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00LaborRUNSTD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,42) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00TotalLaborSTD.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,43) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00DIRECT_COST_STD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,44) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00CM_VALOR_STD.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,45) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00CM_PERCENTUAL_STD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,46) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00INDIRECT_COST_STD.AsFloat;
          end;
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,47) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00TOTAL_COST_STD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,48) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             Style.DataFormat.FormatCode := '#,##0.00';
             AsVariant := FDQueryVSOP_OrderBilling00GM_VALOR_STD.AsFloat;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,49) do
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

procedure TFr_RelatorioGrossMargin.CreatePlanilhaRouting;
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

      if Odd(X) then
        varCor1 := RGB(255,255,225)
      else
        varCor1 := RGB(216,234,204);

      Inc(X);

      FDQueryRouting.Next;
  end;

end;

procedure TFr_RelatorioGrossMargin.cxButtonProcessarBOM2Click(Sender: TObject);
begin
 Try
   Mensagem( 'Exportando do SAP -> Bill of Material - Parte 2' );
   WinExec('\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000449 BR-ENG-BOM2 BR-ENG-BOM2 \\ghos2024\Brady\Files\ENG\BR-ENG-BOM2.TXT', 1);
 Finally
   Mensagem( EmptyStr );
   cxButtonProcessarBOM2.OptionsImage.ImageIndex := 39;
   cxButtonProcessarITEM.Enabled := True;
   cxButtonVerBom2.Enabled := True;
 End;
end;

procedure TFr_RelatorioGrossMargin.cxButtonProcessarClick(Sender: TObject);
begin

  if cxButtonEditPath.Text = EmptyStr then
    raise Exception.Create('Informe o arquivo primeiro.');

  ImportarHoras;
end;

procedure TFr_RelatorioGrossMargin.cxButtonProcessarCUSTOClick(Sender: TObject);
begin
 try
   Mensagem( 'Exportando do SAP -> Custo 2' );
   WinExec('\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000449 BR-GM-002 BR-GM-002 \\ghos2024\Brady\Files\ENG\BR-GM-001.TXT', 1);
 finally
   Mensagem( EmptyStr );
   cxButtonProcessarCUSTO.OptionsImage.ImageIndex := 39;
   cxButtonProcessarUOM.Enabled := True;
   cxButtonVerCusto.Enabled := true;
 end;
end;

procedure TFr_RelatorioGrossMargin.cxButtonProcessarITEMClick(Sender: TObject);
begin
 try
   Mensagem( 'Exportando do SAP -> Item' );
   WinExec('\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000448 BR-ENG-ITEM BR-ENG-ITEM \\ghos2024\Brady\Files\ENG\BR-ENG-ITEM.TXT', 1);
 finally
   Mensagem( EmptyStr );
   cxButtonProcessarITEM.OptionsImage.ImageIndex := 39;
   cxButtonProcessarROUTING.Enabled := True;
   cxButtonVerItem.Enabled := True;
 end;
end;

procedure TFr_RelatorioGrossMargin.cxButtonProcessarROUTINGClick(
  Sender: TObject);
begin
 try
     Mensagem( 'Exportando do SAP -> Routing' );
     WinExec('\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000449 BR-ROUT-001 BR-ROUT-001 \\ghos2024\Brady\Files\ENG\BR-ENG-ROUTING.TXT', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonProcessarROUTING.OptionsImage.ImageIndex := 39;
     cxButtonProcessarCUSTO.Enabled := True;
     cxButtonVerRouting.Enabled := True;
 end;
end;

procedure TFr_RelatorioGrossMargin.cxButtonProcessarUOMClick(Sender: TObject);
begin
 try
    Mensagem( 'Exportando do SAP -> UOM' );
    WinExec('\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000449 BR-UOM-001 BR-UOM-001 \\ghos2024\Brady\Files\ENG\BR-UOM-001.TXT', 1);
 finally
   cxButtonProcessarBOM2.Enabled    := False;
   cxButtonProcessarBOM2.Enabled    := False;
   cxButtonProcessarITEM.Enabled    := False;
   cxButtonProcessarROUTING.Enabled := False;
   cxButtonProcessarCUSTO.Enabled   := False;
   cxButtonProcessarUOM.Enabled     := False;
   cxButtonProcessarBOM1.Enabled    := False;
   cxButtonAtualizaBOM.Enabled      := True;
   cxButtonVerUOM.Enabled := True;
   cxButtonProcessarUOM.OptionsImage.ImageIndex := 39;
   Mensagem( EmptyStr );
 end;
end;

procedure TFr_RelatorioGrossMargin.cxButtonAtualizaBOM2Click(Sender: TObject);
begin
 try
     Mensagem( 'Atualizando Bill of Material - Parte 2' );
     WinExec('\\GHOS2024\Brady\BradyDataImport.exe -eng_bom2', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonAtualizaBOM2.OptionsImage.ImageIndex := 39;
     cxButtonAtualizaItem.Enabled := True;
 end;

end;

procedure TFr_RelatorioGrossMargin.cxButtonAtualizaBOMClick(Sender: TObject);
begin
 try
     Mensagem( 'Atualizando Bill of Material - Parte 1' );
     WinExec('\\GHOS2024\Brady\BradyDataImport.exe -eng_bom', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonAtualizaBOM.OptionsImage.ImageIndex := 39;
     cxButtonAtualizaBOM2.Enabled := True;
 end;
end;

procedure TFr_RelatorioGrossMargin.cxButtonAtualizaCustoClick(Sender: TObject);
begin
  try
     Mensagem( 'Atualizando Custo' );
     WinExec('\\GHOS2024\Brady\BradyDataImport.exe -gm_custos', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonAtualizaCusto.OptionsImage.ImageIndex := 39;
     cxButtonAtualizaUOM.Enabled := True;
 end;
end;

procedure TFr_RelatorioGrossMargin.cxButtonAtualizaItemClick(Sender: TObject);
begin
 try
     Mensagem( 'Atualizando Item' );
     WinExec('\\GHOS2024\Brady\BradyDataImport.exe -eng_item', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonAtualizaItem.OptionsImage.ImageIndex := 39;
     cxButtonAtualizaOrdemMPR.Enabled := True;
 end;

end;

procedure TFr_RelatorioGrossMargin.cxButtonAtualizaMPRClick(Sender: TObject);
begin
 try
     Mensagem( 'Atualizando Ordem de Produ��o' );
     WinExec('\\GHOS2024\Brady\BradyDataImport.exe -eng_op', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonAtualizaMPR.OptionsImage.ImageIndex := 39;
     cxButtonAtualizaRouting.Enabled := True;
 end;


end;

procedure TFr_RelatorioGrossMargin.cxButtonAtualizaOrdemMPRClick(
  Sender: TObject);
begin
 try
     Mensagem( 'Atualizando Ordem de Produ��o MPR' );
     WinExec('\\GHOS2024\Brady\BradyDataImport.exe -eng_opmpr', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonAtualizaOrdemMPR.OptionsImage.ImageIndex := 39;
     cxButtonAtualizaMPR.Enabled := True;
 end;

end;

procedure TFr_RelatorioGrossMargin.cxButtonAtualizaRoutingClick(
  Sender: TObject);
begin
  try
     Mensagem( 'Atualizando Routing' );
     WinExec('\\GHOS2024\Brady\BradyDataImport.exe -eng_routing', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonAtualizaRouting.OptionsImage.ImageIndex := 39;
     cxButtonAtualizaCusto.Enabled := True;
 end;

end;

procedure TFr_RelatorioGrossMargin.cxButtonAtualizaUOMClick(Sender: TObject);
begin
   try
     Mensagem( 'Atualizando UOM' );
     WinExec('\\GHOS2024\Brady\BradyDataImport.exe -uom', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonAtualizaBOM.Enabled := False;
     cxButtonAtualizaBOM2.Enabled := False;
     cxButtonAtualizaItem.Enabled := False;
     cxButtonAtualizaRouting.Enabled := False;
     cxButtonAtualizaOrdemMPR.Enabled := False;
     cxButtonAtualizaMPR.Enabled := False;
     cxButtonAtualizaCusto.Enabled := False;
     cxButtonAtualizaUOM.Enabled := False;
     cxButtonInsertSQL.Enabled := True;
     cxButtonAtualizaUOM.OptionsImage.ImageIndex := 39;
 end;
end;

procedure TFr_RelatorioGrossMargin.cxButtonEditPathClick(Sender: TObject);
begin
  if SaveDialog.Execute(Handle) then
  begin
    cxButtonEditPath.Text := SaveDialog.FileName;
  end;
end;

procedure TFr_RelatorioGrossMargin.cxButtonInicioClick(Sender: TObject);
Var
  VarMesAnterior : TDateTime;
  VAR_TSOP_GMHBUD : String;
begin

  VAR_TSOP_GMHBUD := 'E';
  if cxComboBoxTaxa.ItemIndex = 0 then
     VAR_TSOP_GMHBUD := 'E'
  else if cxComboBoxTaxa.ItemIndex = 1 then
     VAR_TSOP_GMHBUD := 'B'
  else if cxComboBoxTaxa.ItemIndex = 2 then
     VAR_TSOP_GMHBUD := 'A'
  else if cxComboBoxTaxa.ItemIndex = 3 then
     VAR_TSOP_GMHBUD := 'T'
  else if cxComboBoxTaxa.ItemIndex = 4 then
     VAR_TSOP_GMHBUD := 'M';

  VarMesAnterior :=  StartOfTheMonth(Now)-1;
  cxDateEditTSOP_ORDBILDATDOCINI.Date := StartOfTheMonth(VarMesAnterior);
  cxDateEditTSOP_ORDBILDATDOCFIM.Date := EndOfTheMonth(VarMesAnterior);
  FDQueryGMHoras.Close;
  FDQueryGMHoras.SQL.Clear;
  FDQueryGMHoras.SQL.Add('SELECT * FROM TSOP_GMHORAS  WHERE TSOP_GMHDAT BETWEEN ');
  FDQueryGMHoras.SQL.Add(' :V_BILLING_INI and :V_BILLING_FIM AND TSOP_GMHBUD  = :V_TSOP_GMHBUD ');
  FDQueryGMHoras.ParamByName( 'V_BILLING_INI' ).AsDateTime := cxDateEditTSOP_ORDBILDATDOCINI.Date;
  FDQueryGMHoras.ParamByName( 'V_BILLING_FIM' ).AsDateTime := cxDateEditTSOP_ORDBILDATDOCFIM.Date;
  FDQueryGMHoras.ParamByName( 'V_TSOP_GMHBUD' ).AsString   := VAR_TSOP_GMHBUD;
  FDQueryGMHoras.Open;
  if FDQueryGMHoras.IsEmpty then
      raise Exception.Create('Taxas Horas n�o encontrada para o per�odo e tipo de taxa informado.');

 try
    Mensagem( 'Apagando Tabelas Intermediarias...' );
    FDScriptDelete.ExecuteAll;
  finally
    Mensagem( EmptyStr);
 end;
  cxButtonInicio.OptionsImage.ImageIndex := 39;
  cxButtonProcessarBOM1.Enabled    := True;

end;

procedure TFr_RelatorioGrossMargin.cxButtonInsertSQLClick(Sender: TObject);
begin
  try
    Mensagem( 'Calculando Custo...' );
    FDScriptInsert.SQLScripts.Clear;
    FDScriptInsert.SQLScripts.Add.SQL.Add( 'EXEC dbo.PSOP_ProcessoGMCustos ' );
    FDScriptInsert.ExecuteAll;

    Mensagem( 'Calculo Finalizado.' );
  finally
    Mensagem( EmptyStr );
    cxButtonProcessarBOM1.Enabled    := False;
    cxButtonProcessarBOM2.Enabled    := False;
    cxButtonProcessarITEM.Enabled    := False;
    cxButtonProcessarROUTING.Enabled := False;
    cxButtonProcessarCUSTO.Enabled   := False;
    cxButtonProcessarUOM.Enabled := False;

    cxButtonAtualizaBOM.Enabled := False;
    cxButtonAtualizaBOM2.Enabled := False;
    cxButtonAtualizaItem.Enabled := False;
    cxButtonAtualizaRouting.Enabled := False;
    cxButtonAtualizaOrdemMPR.Enabled := False;
    cxButtonAtualizaMPR.Enabled := False;
    cxButtonAtualizaCusto.Enabled := False;
    cxButtonAtualizaUOM.Enabled := False;
    cxButtonInsertSQL.Enabled := False;

    cxButtonVerBom1.Enabled := False;
    cxButtonVerBom2.Enabled := False;
    cxButtonVerItem.Enabled := False;
    cxButtonVerRouting.Enabled := False;
    cxButtonVerCusto.Enabled := False;
    cxButtonVerUOM.Enabled := False;

    cxButtonProcessarBOM1.OptionsImage.ImageIndex    := 38;
    cxButtonProcessarBOM2.OptionsImage.ImageIndex    := 38;
    cxButtonProcessarITEM.OptionsImage.ImageIndex    := 38;
    cxButtonProcessarROUTING.OptionsImage.ImageIndex := 38;
    cxButtonProcessarCUSTO.OptionsImage.ImageIndex   := 38;
    cxButtonProcessarUOM.OptionsImage.ImageIndex     := 38;

    cxButtonAtualizaBOM.OptionsImage.ImageIndex      := 38;
    cxButtonAtualizaBOM2.OptionsImage.ImageIndex     := 38;
    cxButtonAtualizaItem.OptionsImage.ImageIndex     := 38;
    cxButtonAtualizaRouting.OptionsImage.ImageIndex  := 38;
    cxButtonAtualizaOrdemMPR.OptionsImage.ImageIndex := 38;
    cxButtonAtualizaMPR.OptionsImage.ImageIndex      := 38;
    cxButtonAtualizaCusto.OptionsImage.ImageIndex    := 38;
    cxButtonAtualizaUOM.OptionsImage.ImageIndex      := 38;

    cxButtonInsertSQL.OptionsImage.ImageIndex        := 38;
    cxButtonInicio.OptionsImage.ImageIndex := 38

  end;
end;

procedure TFr_RelatorioGrossMargin.cxButtonProcessarBOM1Click(Sender: TObject);
begin
 cxButtonProcessarBOM2.Enabled    := False;
 cxButtonProcessarBOM2.Enabled    := False;
 cxButtonProcessarITEM.Enabled    := False;
 cxButtonProcessarROUTING.Enabled := False;
 cxButtonProcessarCUSTO.Enabled   := False;

 try
     Mensagem( 'Exportando do SAP -> Bill of Material - Parte 1' );
     WinExec('\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000448 BR-ENG-BOM BR-ENG-BOM \\ghos2024\Brady\Files\ENG\BR-ENG-BOM.TXT', 1);
 finally
    cxButtonProcessarBOM1.OptionsImage.ImageIndex := 39;
     Mensagem( EmptyStr );
     cxButtonProcessarBOM2.Enabled := True;
     cxButtonVerBom1.Enabled := True;
 end;

end;

procedure TFr_RelatorioGrossMargin.cxButtonRefreshClick(Sender: TObject);
begin

  AbrirDataset;

end;

procedure TFr_RelatorioGrossMargin.cxButtonVerBom1Click(Sender: TObject);
begin
   if FileExists(TButton(Sender).Hint) then
     ShellExecute(Handle,'open', 'c:\windows\notepad.exe', pChar( TButton(Sender).Hint ), nil, SW_SHOWNORMAL)
   else   raise Exception.Create(' Arquivo ' + pChar( TButton(Sender).Hint ) + ' n�o encontrado.');

end;

procedure TFr_RelatorioGrossMargin.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  FDQueryVSOP_OrderBilling00.Close;
  FDQueryBOM.Close;
  FDQueryCosting.Close;
  FDQueryRouting.Close;
  FDConnection.Close;

  Fr_RelatorioGrossMargin := nil;
  Action := caFree;

end;

procedure TFr_RelatorioGrossMargin.FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin

  if cxPageControl.ActivePage = cxTabSheetGrossMargin then
    Fr_Brady.PopupGridTools( cxGridGrossMargin.ActiveView )
  else if cxPageControl.ActivePage = cxTabSheetBom then
    Fr_Brady.PopupGridTools( cxGridBom.ActiveView )
  else if cxPageControl.ActivePage = cxTabSheetCosting then
    Fr_Brady.PopupGridTools( cxGridCosting.ActiveView )
  else if cxPageControl.ActivePage = cxTabSheetRouting then
    Fr_Brady.PopupGridTools( cxGridRouting.ActiveView );

end;

procedure TFr_RelatorioGrossMargin.FormCreate(Sender: TObject);
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
  cxPageControl.ActivePage := cxTabSheetProcessar;
{
  if not Fr_Brady.SalesRep then
  begin
    for I := 0 to cxTableViewGrossMargin00.ColumnCount-1 do
    begin
      cxTableViewGrossMargin00.Columns[I].VisibleForCustomization := True;
      cxTableViewGrossMargin00.Columns[I].Visible := True;
    end;
  end;
 }
end;

procedure TFr_RelatorioGrossMargin.ImportarHoras;
var
  I, X: Integer;
  dxSpreadSheet: TdxSpreadSheet;
  varMes, varAno: Integer;
  varData: TDateTime;
  varPlanta, varBudget, varCentro: String;
  varSetup, varMachine, varLabor, varOverhead: Extended;

begin

  Mensagem( 'Iniciando processo de importa��o...' );
  try

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    try

      Mensagem( 'Carregando planilha...' );
      dxSpreadSheet.LoadFromFile( cxButtonEditPath.Text );
      dxSpreadSheet.BeginUpdate;

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );

      Mensagem( 'Abrindo Conex�o...' );
      FDConnection.Open;
      try

        FDQueryTSOP_GMHoras.Open;
        try

          Mensagem( 'Lendo linhas da planilha...' );
          for X := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
          begin

            try

              if dxSpreadSheet.ActiveSheetAsTable.Rows[X].CellCount = 0 then
                Continue;

              if dxSpreadSheet.ActiveSheetAsTable.Rows[X].CellCount < 9 then
                Continue;

              Mensagem( 'Linha (" ' + IntToStr(X) + '/' + IntToStr(dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex) + '") "' + Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsString) + '" ...' );

              if Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString) = EmptyStr then
                Continue;

            except

              Continue;

            end;

            varAno := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsInteger;
            varMes := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[1].AsInteger;
            varData := EncodeDate( varAno, varMes, 01 );
            varBudget := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsString;
            varPlanta := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[3].AsString;
            varCentro := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[4].AsString;
            varSetup := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[5].AsFloat;
            varMachine := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6].AsFloat;
            varLabor := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[7].AsFloat;
            varOverhead := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[8].AsFloat;

            if FDQueryTSOP_GMHoras.Locate( 'TSOP_GMHDAT;TSOP_GMHBUD;TSOP_GMHSIT;TSOP_GMHCCU', VarArrayOf( [varData,varBudget,varPlanta,varCentro] ) ) then
            begin

              if (varSetup+varMachine+varLabor+varOverhead) > 0.00 then
              begin

                FDQueryTSOP_GMHoras.Edit;
                FDQueryTSOP_GMHorasTSOP_GMHSUP.AsFloat := varSetup;
                FDQueryTSOP_GMHorasTSOP_GMHMAQ.AsFloat := varMachine;
                FDQueryTSOP_GMHorasTSOP_GMHLAB.AsFloat := varLabor;
                FDQueryTSOP_GMHorasTSOP_GMHOVE.AsFloat := varOverhead;

                try
                  FDQueryTSOP_GMHoras.Post;
                except
                  FDQueryTSOP_GMHoras.Cancel;
                end;

              end
              else
              begin

                try
                  FDQueryTSOP_GMHoras.Delete;
                except
                end;

              end;

            end
            else
            begin

              if (varSetup+varMachine+varLabor+varOverhead) > 0.00 then
              begin

                FDQueryTSOP_GMHoras.Append;

                FDQueryTSOP_GMHorasTSOP_GMHSIT.AsString := varPlanta;
                FDQueryTSOP_GMHorasTSOP_GMHBUD.AsString := varBudget;
                FDQueryTSOP_GMHorasTSOP_GMHCCU.AsString := varCentro;
                FDQueryTSOP_GMHorasTSOP_GMHDAT.AsDateTime := varData;

                FDQueryTSOP_GMHorasTSOP_GMHSUP.AsFloat := varSetup;
                FDQueryTSOP_GMHorasTSOP_GMHMAQ.AsFloat := varMachine;
                FDQueryTSOP_GMHorasTSOP_GMHLAB.AsFloat := varLabor;
                FDQueryTSOP_GMHorasTSOP_GMHOVE.AsFloat := varOverhead;

                try
                  FDQueryTSOP_GMHoras.Post;
                except
                  FDQueryTSOP_GMHoras.Cancel;
                end;

              end;

            end;

            Application.ProcessMessages;

          end;

        finally

          FDQueryTSOP_GMHoras.Close;

        end;

      finally

        FDConnection.Close;

      end;

    finally

      FreeAndNil(dxSpreadSheet);

    end;

  finally

    Mensagem( EmptyStr );

  end;


end;

procedure TFr_RelatorioGrossMargin.LoadGridCustomization;
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

procedure TFr_RelatorioGrossMargin.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

end.
