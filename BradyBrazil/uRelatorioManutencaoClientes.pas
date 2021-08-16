unit uRelatorioManutencaoClientes;

interface

uses
  System.DateUtils,
  System.StrUtils,
  ShellAPI,
  dxSpreadSheet,
  dxSpreadSheetTypes,
  dxSpreadSheetCore,
  cxCurrencyEdit,
  cxGridDBDataDefinitions,
  cxGridExportLink,
  MidasLib,
  System.Math,
  ComObj,
  Excel,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, dxSkinsCore,
  dxSkinOffice2013White, dxSkinscxPCPainter, dxBarBuiltInMenu, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxContainer,
  cxEdit, cxButtonEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLabel,
  Vcl.StdCtrls, cxButtons, cxPC, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData,
  FireDAC.Comp.DataSet, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGrid, dxGDIPlusClasses, Vcl.ExtCtrls,
  VclTee.TeeGDIPlus, Datasnap.DBClient, VclTee.TeEngine, VclTee.Series,
  VclTee.TeeProcs, VclTee.Chart, VclTee.DBChart, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
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
  dxSkinWhiteprint, dxSkinXmas2008Blue, Vcl.Grids, Vcl.DBGrids,
  Datasnap.Provider, cxGridDBTableView, VCLTee.TeeDBCrossTab,
  dxSpreadSheetFormulas, dxSpreadSheetFunctions, dxSpreadSheetGraphics,
  dxSpreadSheetClasses, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  frxClass, frxDBSet, frxExportPDF, frxExportCSV, cxCustomPivotGrid,
  cxDBPivotGrid;

type
  TFr_RelatorioManutencaoClientes = class(TForm)
    FDConnection: TFDConnection;
    cxPageControlFiltro: TcxPageControl;
    cxTabSheetFiltro: TcxTabSheet;
    Label1: TLabel;
    cxButtonRefresh: TcxButton;
    cxLabel1: TcxLabel;
    cxCanal: TcxComboBox;
    ButExcel: TcxButton;
    cbPeriodo: TcxComboBox;
    Page: TcxPageControl;
    tabBaseClientes: TcxTabSheet;
    FDQueryBase: TFDQuery;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    cxGrid1: TcxGrid;
    cxGrid1Level1: TcxGridLevel;
    tabGrafico: TcxTabSheet;
    cdsGrafico: TClientDataSet;
    dsGrafico: TDataSource;
    DBGrid1: TDBGrid;
    Chart: TChart;
    FDQueryAux: TFDQuery;
    cdsGraficoDetalhe: TClientDataSet;
    dsGraficoDetalhe: TDataSource;
    FDQueryRecuperaCliente: TFDQuery;
    dsRecuperaCliente: TDataSource;
    tabDetalhe: TcxTabSheet;
    Label2: TLabel;
    SaveDialog: TSaveDialog;
    FDQueryRecuperaClienteMem: TClientDataSet;
    cxGrid1DBBandedTableView1: TcxGridDBBandedTableView;
    FDQueryResumo1: TFDQuery;
    dsResumo1: TDataSource;
    cxGrid3: TcxGrid;
    cxGrid3DBBandedTableView1: TcxGridDBBandedTableView;
    cxGrid3Level1: TcxGridLevel;
    FDQueryResumo2: TFDQuery;
    dsResumo2: TDataSource;
    FDQueryResumo3: TFDQuery;
    cxButtonPrint: TcxButton;
    tabHistorico: TcxTabSheet;
    cxTabSheet1: TcxTabSheet;
    cxGrid4: TcxGrid;
    cxGrid4DBBandedTableView1: TcxGridDBBandedTableView;
    cxGrid4Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    cxGrid2DBBandedTableView1: TcxGridDBBandedTableView;
    cxGrid2Level1: TcxGridLevel;
    Chart1: TChart;
    FDQueryClienteAtivo: TFDQuery;
    cxButtonEditPath: TcxButtonEdit;
    Label3: TLabel;
    FDQueryAux2: TFDQuery;
    Panel1: TPanel;
    FDQueryPeriodo: TFDQuery;
    DSFDQueryPeriodo: TDataSource;
    cxLookupComboBoxPeriodo: TcxLookupComboBox;
    FDQueryPeriodoPERIODO: TWideStringField;
    FDQueryPeriodoDATA: TDateField;
    Relatorio: TfrxReport;
    frxClienteAtivo: TfrxDBDataset;
    FDQueryRelClienteAtivo: TFDQuery;
    frxPDFExport1: TfrxPDFExport;
    Per�odo: TLabel;
    cxTabSheet2: TcxTabSheet;
    cxDBPivotGrid00: TcxDBPivotGrid;
    cxDBPivotGrid00FieldTSOP_ORDBILREPNOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_ORDBILGRUCLINOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_ORDBILCANNOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldVALOR: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_ORDBILSITNOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_ORDBILCLINOM: TcxDBPivotGridField;
    frxCSVExport1: TfrxCSVExport;
    FDQueryVisaoDinamica: TFDQuery;
    dsVisaoDinamica: TDataSource;
    FDQueryVisaoDinamicaTSOP_ORDBILCLICOD: TStringField;
    FDQueryVisaoDinamicaTSOP_ORDBILREPNOM: TStringField;
    FDQueryVisaoDinamicaTSOP_ORDBILGRUCLINOM: TStringField;
    FDQueryVisaoDinamicaTSOP_ORDBILCLINOM: TStringField;
    FDQueryVisaoDinamicaTSOP_ORDBILSITNOM: TStringField;
    FDQueryVisaoDinamicaTSOP_ORDBILCANNOM: TStringField;
    FDQueryVisaoDinamicaTSOP_ORDBILREG: TStringField;
    FDQueryVisaoDinamicaTSOP_ORDBILREGEST: TStringField;
    FDQueryVisaoDinamicaTSOP_REPCSR: TStringField;
    FDQueryVisaoDinamicaSTATUS: TStringField;
    FDQueryVisaoDinamicaHITS: TIntegerField;
    FDQueryVisaoDinamicaRECENCIA: TIntegerField;
    FDQueryVisaoDinamicaCLIENTENOVO: TIntegerField;
    FDQueryVisaoDinamicaMEDIA_12: TFMTBCDField;
    FDQueryVisaoDinamicaCLASSIFICACAO_12: TStringField;
    FDQueryVisaoDinamicaACUMULADO_12: TFMTBCDField;
    FDQueryVisaoDinamicaMEDIA: TFMTBCDField;
    FDQueryVisaoDinamicaCLASSIFICACAO: TStringField;
    FDQueryVisaoDinamicaACUMULADO: TFMTBCDField;
    FDQueryVisaoDinamicaMES: TWideStringField;
    FDQueryVisaoDinamicaVALOR: TFMTBCDField;
    FDQueryVisaoDinamicaDATA: TDateField;
    cxDBPivotGrid00FieldDATA: TcxDBPivotGridField;
    cxDBPivotGrid00FieldStatus: TcxDBPivotGridField;
    cxDBPivotGrid00FieldRecencia: TcxDBPivotGridField;
    cxDBPivotGrid00FieldClassificacao: TcxDBPivotGridField;
    cxButton1: TcxButton;
    Label4: TLabel;
    cxButtonPathPeriodo: TcxButtonEdit;
    procedure cxButtonRefreshClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsGraficoDetalheAfterOpen(DataSet: TDataSet);
    procedure ButExcelClick(Sender: TObject);
    procedure PageChange(Sender: TObject);
    procedure cxButtonPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxButtonEditPathClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButtonPathPeriodoClick(Sender: TObject);
  private
    NovaData: TDateTime;
    NomedoUsuario : String;
    { Private declarations }
    dxSpreadSheet : TdxSpreadSheet;
    iPeriodo, Fim_i, iPeriodoFixo : Integer;
    NumeroLinhasGrid: Integer;
    ABand: TcxGridBand;
    ABand1 : TcxGridBand;
    ABand2 : TcxGridBand;
    ABand3 : TcxGridBand;

    iContaGrupo: Integer;
    Edit: Array of TEdit;
    lblTotal: Array of TLabel;

    LblForecast: Array of TLabel;
    LblCodigo: Array of TLabel;
    LblNome: Array of TLabel;
    varMedia: Array of Currency;

    varMesesABC: Array of Currency;
    varMesesA: Array of Currency;
    varMesesB: Array of Currency;
    varMesesC: Array of Currency;

    varAnoAcumulado: Array of Currency;
    varAcumuladoA: Array of Currency;
    varAcumuladoB: Array of Currency;
    varAcumuladoC: Array of Currency;

    varMesesABCFixo: Array of Currency;
    varMesesAFixo: Array of Currency;
    varMesesBFixo: Array of Currency;
    varMesesCFixo: Array of Currency;

    varAnoAcumuladoFixo: Array of Currency;
    varAcumuladoAFixo: Array of Currency;
    varAcumuladoBFixo: Array of Currency;
    varAcumuladoCFixo: Array of Currency;



    varSomaABC: Array of Integer;



    LblTitulo, LblMedia: Array of TLabel;
    varMesesArrayB, varMesesArrayF: Array of TDateTime;

    varMesesComLabel, varMesesComLabelB, varMesesComLabelF, varMesesSemLabelB, varMesesSemLabelBUSA, VarMesesSUM, varMesesCaseVisaoDinamica,
      varMesesSemLabelF, varMesesSomaLinha, varMesesMediaComLabelB,varMesesMediaSomaLinha  : WideString;
    varDtInicial, varDtFinal: TDateTime;
    procedure Mensagem(pMensagem: String);
    function MontaStringMes(bMostraLabel: Boolean; Alias: String; Tipo: String;
      SomarL: Boolean; VisaoDinamica : Boolean; ComAS: Boolean = True; SUM : Boolean = False; Language : String = 'BR'): WideString;
    function BuscaMes(Data: TDateTime; bLabel: Boolean; Alias: String;
      SomarLinha: Boolean; VisaoDinamica : Boolean; ComAS: Boolean; SUM : Boolean; Language : String = 'BR'): String;
    procedure AddColumnGrid1;
    procedure AddColumnGrid2;
    procedure CreateDataSet;
    procedure SetaPeriodo;
    procedure CriarRegistroQtdeVendas;

    procedure InitGrid;
    procedure AddRegras;
    procedure DropObjetos;
    procedure CopiaDataSetParaMemoria;
    procedure CopiaDataSetParaBanco;
    procedure AddColumnGrid3;
    procedure AddColumnGrid4;
 //   procedure Imprimir;
    function RemoveAcento(const pText: string): string;
    procedure InitGrid2;
    function GetMonth(const ADate: TDate): Word;
    function GetNameOfMonth(const ADate: TDate): UnicodeString;
    function ClientesAtivosPorPeriodo : Integer;
    procedure Imprimir2;
    procedure Imprimir3;
    procedure SetaNomeUsuario;

  public
    { Public declarations }
    procedure AbrirDataset;
  end;

var
  Fr_RelatorioManutencaoClientes: TFr_RelatorioManutencaoClientes;

const
  DataFileBase  = 'myBase.xml';
  DataFileMestre = 'myChartMestre.xml';
  DataFileDetalhe = 'myChartDetalhe.xml';

implementation

{$R *.dfm}

uses uUtils, uBrady;

{ TFr_RelatorioManutencaoClientes }

function TFr_RelatorioManutencaoClientes.GetNameOfMonth(const ADate: TDate): UnicodeString;
var
   Month: Word;
begin
   Month := MonthOfTheYear(ADate);

   case Month of
      MonthJanuary:
         Result := 'Janeiro';
      MonthFebruary:
         Result := 'Fevereiro';
      MonthMarch:
         Result := 'Mar�o';
      MonthApril:
         Result := 'Abril';
      MonthMay:
         Result := 'Maio';
      MonthJune:
         Result := 'Junho';
      MonthJuly:
         Result := 'Julho';
      MonthAugust:
         Result := 'Agosto';
      MonthSeptember:
         Result := 'Setembro';
      MonthOctober:
         Result := 'Outubro';
      MonthNovember:
         Result := 'Novembro';
      MonthDecember:
         Result := 'Dezembro';
   end;
end;

function TFr_RelatorioManutencaoClientes.GetMonth(const ADate: TDate): Word;
var
     D, M, Y: Word;
begin
    DecodeDate(ADate, Y, M, D);

    Result := M;   // M � o m�s da data decodificada
end;


procedure TFr_RelatorioManutencaoClientes.AbrirDataset;
begin


  SetaPeriodo;

  Mensagem('Abrindo conex�o...');
  try

    if not FDConnection.Connected then
    begin

      FDConnection.Params.LoadFromFile(MyDocumentsPath + '\DB.ini');
      FDConnection.Open;

    end;

    Mensagem('Obtendo dados (Base de Clientes)...');

    varMesesComLabel := MontaStringMes(True, '', 'B', False, False);
    varMesesComLabel := Copy(varMesesComLabel, 1, Length(varMesesComLabel) - 1);

    varMesesComLabelB := MontaStringMes(True, 'B', 'B', False, False, False);
    varMesesComLabelB := Copy(varMesesComLabelB, 1, Length(varMesesComLabelB) - 1);

    VarMesesSUM := MontaStringMes(True, 'B', 'B', False, False, False, True);
    VarMesesSUM := Copy(VarMesesSUM, 1, Length(VarMesesSUM) - 1);

    varMesesSemLabelB := MontaStringMes(False, '', 'B', False, False);
    varMesesSemLabelB := Copy(varMesesSemLabelB, 1, Length(varMesesSemLabelB) - 1);

    varMesesSemLabelBUSA := MontaStringMes(False, '', 'B', False, False, True, False, 'US');
    varMesesSemLabelBUSA := Copy(varMesesSemLabelBUSA, 1, Length(varMesesSemLabelBUSA) - 1);

    varMesesSomaLinha := MontaStringMes(True, 'B', 'B', True, False);
    varMesesSomaLinha := '(' + Copy(varMesesSomaLinha, 1, Length(varMesesSomaLinha) - 1) + ')';

    varMesesCaseVisaoDinamica := MontaStringMes(False, '', 'B', False, True);
    varMesesCaseVisaoDinamica := Copy(varMesesCaseVisaoDinamica, 1, Length(varMesesCaseVisaoDinamica) - 1);


    DropObjetos;



    FDQueryBase.Close;
    FDQueryBase.SQL.Clear;
    FDQueryBase.SQL.Add('WITH BILLING ');
    FDQueryBase.SQL.Add('AS (  ');

    FDQueryBase.SQL.Add('SELECT  ');
    FDQueryBase.SQL.Add
      ('TSOP_ORDBILCLICOD,TSOP_ORDBILREPNOM,TSOP_ORDBILGRUCLINOM,TSOP_ORDBILCLINOM,TSOP_ORDBILSITNOM,TSOP_ORDBILCANNOM,TSOP_ORDBILREG,TSOP_ORDBILREGEST,  TSOP_REPCSR,   ');

    FDQueryBase.SQL.Add(varMesesComLabel);
    FDQueryBase.SQL.Add('FROM  ');
    FDQueryBase.SQL.Add('( ');
    FDQueryBase.SQL.Add('	SELECT ');
    FDQueryBase.SQL.Add
      ('		 CASE when B01.TSOP_ORDBILREPNOM = ''ALESSANDRA GO�ALO'' THEN '''' ELSE B01.TSOP_ORDBILGRUCLINOM END AS TSOP_ORDBILGRUCLINOM	,C01.TSOP_ORDBILCLICOD,B01.TSOP_ORDBILCANNOM ,B01.TSOP_ORDBILSITNOM ,B01.TSOP_ORDBILREPNOM,B01.TSOP_ORDBILCLINOM  ');
    FDQueryBase.SQL.Add
      ('		,TSOP_ORDBILTYP = CAST(''BILLING'' AS VARCHAR(255))');
    FDQueryBase.SQL.Add
      ('		,CONVERT(CHAR(4), C01.TSOP_ORDBILDATDOC, 100) + CONVERT(CHAR(4), C01.TSOP_ORDBILDATDOC, 120) AS MES ');
    FDQueryBase.SQL.Add
      ('		,TSOP_ORDBILVALLIQ = CAST(SUM(ISNULL(C01.TSOP_ORDBILVALLIQ,0.00)) AS NUMERIC(15,02)) ');
    FDQueryBase.SQL.Add
      ('	  ,COALESCE( C01.TSOP_ORDBILREG,	  B01.TSOP_ORDBILREG ) AS		TSOP_ORDBILREG   ');
    FDQueryBase.SQL.Add
      ('	  ,COALESCE( C01.TSOP_ORDBILREGEST,	  B01.TSOP_ORDBILREGEST ) AS	TSOP_ORDBILREGEST , C01.TSOP_REPCSR  ');

    FDQueryBase.SQL.Add
      ('	FROM DBO.VSOP_MONTHS A01 WITH (NOLOCK)  CROSS JOIN VSOP_ClienteBySalesRepForecast B01 WITH (NOLOCK) ');
    FDQueryBase.SQL.Add
      ('							LEFT  JOIN VSOP_ORDERBILLINGFULL C01 WITH (NOLOCK)  ON ( B01.TSOP_ORDBILCLICOD  = C01.TSOP_ORDBILCLICOD ');
    FDQueryBase.SQL.Add
      ('																	AND B01.TSOP_ORDBILCANNOM  = C01.TSOP_ORDBILCANNOM ');
    FDQueryBase.SQL.Add
      ('																	AND B01.TSOP_ORDBILSITNOM  = C01.TSOP_ORDBILSITNOM ');
    FDQueryBase.SQL.Add
      ('																	AND A01.YEARDOC            = C01.TSOP_ORDBILYEADOC ');
    FDQueryBase.SQL.Add
      ('																	AND A01.MONTHDOC           = C01.TSOP_ORDBILMONDOC ');
    FDQueryBase.SQL.Add
      ('																	AND C01.TSOP_ORDBILTIPDOC  IN (''BILLING'',''RETURN'') ) ');
    FDQueryBase.SQL.Add
      ('	    	      LEFT OUTER JOIN TSIS_USUARIO U ON UPPER(U.TSIS_USUNOM) = UPPER(B01.TSOP_ORDBILREPNOM) ');
    //FDQueryBase.SQL.Add('		WHERE  U.TSIS_USUATI = ''S'' ');
    FDQueryBase.SQL.Add('		WHERE  1 = 1 ');
    FDQueryBase.SQL.Add('	AND C01.TSOP_ORDBILDATDOC >= :MES_INI ');
    FDQueryBase.SQL.Add('	AND C01.TSOP_ORDBILDATDOC <= :MES_FIM  ');

    FDQueryBase.SQL.Add('    &WHERE1  ');
    // FDQueryBase.SQL.Add('         AND C01.TSOP_ORDBILCLICOD = ''6783971'' ');

    FDQueryBase.SQL.Add('	 AND Upper(COALESCE( B01.TSOP_ORDBILCANNOM, '''')) <> ''DM'' ');
    FDQueryBase.SQL.Add('	GROUP BY ');
    FDQueryBase.SQL.Add('	   B01.TSOP_ORDBILGRUCLINOM ');
    FDQueryBase.SQL.Add('		,C01.TSOP_ORDBILCLICOD ');
    FDQueryBase.SQL.Add('		,B01.TSOP_ORDBILCANNOM ');
    FDQueryBase.SQL.Add('		,B01.TSOP_ORDBILSITNOM ');
    FDQueryBase.SQL.Add('		,B01.TSOP_ORDBILREPNOM ');
    FDQueryBase.SQL.Add('		,B01.TSOP_ORDBILCLINOM ');
     FDQueryBase.SQL.Add('	,C01.TSOP_REPCSR ');
    FDQueryBase.SQL.Add
      ('		,CONVERT(CHAR(4), C01.TSOP_ORDBILDATDOC, 100) + CONVERT(CHAR(4), C01.TSOP_ORDBILDATDOC, 120)  ');
    FDQueryBase.SQL.Add('   ,C01.TSOP_ORDBILREG  ');
    FDQueryBase.SQL.Add('   ,C01.TSOP_ORDBILREGEST  ');
    FDQueryBase.SQL.Add('   ,B01.TSOP_ORDBILREG  ');
    FDQueryBase.SQL.Add('   ,B01.TSOP_ORDBILREGEST  ');

    FDQueryBase.SQL.Add('   UNION   ');
    FDQueryBase.SQL.Add(' 	SELECT DISTINCT ');
    FDQueryBase.SQL.Add
      (' 		 CASE when B01.TSOP_ORDBILREPNOM = ''ALESSANDRA GO�ALO'' THEN '''' ELSE B01.TSOP_ORDBILGRUCLINOM END AS TSOP_ORDBILGRUCLINOM ,C01.TSOP_ORDBILCLICOD,B01.TSOP_ORDBILCANNOM	,B01.TSOP_ORDBILSITNOM, B01.TSOP_ORDBILREPNOM, B01.TSOP_ORDBILCLINOM   ');
    FDQueryBase.SQL.Add
      (',TSOP_ORDBILTYP = CAST(''BILLING'' AS VARCHAR(255)) ,''0'' AS MES,0 TSOP_ORDBILVALLIQ ,COALESCE( C01.TSOP_ORDBILREG,  B01.TSOP_ORDBILREG ) AS	TSOP_ORDBILREG ,COALESCE( C01.TSOP_ORDBILREGEST, B01.TSOP_ORDBILREGEST ) AS	TSOP_ORDBILREGEST, C01.TSOP_REPCSR ');
    FDQueryBase.SQL.Add
      (' 	FROM  VSOP_ClienteBySalesRepForecast B01 WITH (NOLOCK)   ');
    FDQueryBase.SQL.Add
      (' 							LEFT  JOIN VSOP_ORDERBILLINGFULL C01 WITH (NOLOCK)  ON ( B01.TSOP_ORDBILCLICOD  = C01.TSOP_ORDBILCLICOD  ');
    FDQueryBase.SQL.Add
      (' 																	AND B01.TSOP_ORDBILCANNOM  = C01.TSOP_ORDBILCANNOM  ');
    FDQueryBase.SQL.Add
      (' 																	AND B01.TSOP_ORDBILSITNOM  = C01.TSOP_ORDBILSITNOM    ');
    FDQueryBase.SQL.Add
      (' 																	AND C01.TSOP_ORDBILTIPDOC  IN (''BILLING'',''RETURN'') )  ');
    FDQueryBase.SQL.Add
      ('  	LEFT OUTER JOIN TSIS_USUARIO U ON UPPER(U.TSIS_USUNOM) = UPPER(B01.TSOP_ORDBILREPNOM) ');
    FDQueryBase.SQL.Add('  	WHERE  1 = 1 ');
    // FDQueryBase.SQL.Add(' 	C01.TSOP_ORDBILDATDOC >= :MES_INIANT   ');
    // FDQueryBase.SQL.Add(' 	AND C01.TSOP_ORDBILDATDOC <= :MES_FIMANT   ');
    FDQueryBase.SQL.Add
      ('     AND  NOT EXISTS (SELECT TSOP_ORDBILCLICOD  FROM VSOP_ORDERBILLINGFULL D01 WITH(NOLOCK)   ');
    FDQueryBase.SQL.Add
      (' 	                                         WHERE 	 D01.TSOP_ORDBILTIPDOC  IN (''BILLING'',''RETURN'')  ');
    FDQueryBase.SQL.Add
      (' 													AND	D01.TSOP_ORDBILDATDOC >= :MES_INI    ');
    FDQueryBase.SQL.Add
      (' 	                        AND D01.TSOP_ORDBILDATDOC <= :MES_FIM    ');
    FDQueryBase.SQL.Add
      (' 	                        AND D01.TSOP_ORDBILCLICOD = C01.TSOP_ORDBILCLICOD  ');
    FDQueryBase.SQL.Add
      (' 									  			AND D01.TSOP_ORDBILCANNOM = C01.TSOP_ORDBILCANNOM  ');
    FDQueryBase.SQL.Add
      ('                           AND D01.TSOP_ORDBILSITNOM = C01.TSOP_ORDBILSITNOM )');
    FDQueryBase.SQL.Add('    &WHERE1  ');
    FDQueryBase.SQL.Add
      (' 	 AND      Upper(COALESCE( B01.TSOP_ORDBILCANNOM, '''')) <> ''DM''  ');

    FDQueryBase.SQL.Add('  ) SQ ');
    FDQueryBase.SQL.Add('  PIVOT ');
    FDQueryBase.SQL.Add('  ( ');
    FDQueryBase.SQL.Add('   SUM(TSOP_ORDBILVALLIQ)  ');
    FDQueryBase.SQL.Add('  FOR Mes IN ( ' + varMesesSemLabelB + ')');
    FDQueryBase.SQL.Add('  ) AS PIVOTTABLE  ');
    FDQueryBase.SQL.Add(' )  ');
    FDQueryBase.SQL.Add
      ('SELECT B.TSOP_ORDBILREPNOM,B.TSOP_ORDBILGRUCLINOM, B.TSOP_ORDBILCLICOD,');
    FDQueryBase.SQL.Add
      ('     B.TSOP_ORDBILCLINOM, B.TSOP_ORDBILSITNOM, B.TSOP_ORDBILCANNOM, B.TSOP_ORDBILREG, B.TSOP_ORDBILREGEST,  TSOP_REPCSR, ');
  //
  //  FDQueryBase.SQL.Add(' CASE WHEN  ( SELECT COUNT(*) FROM (VALUES  ' +
  //    varMesesComLabelB + ') AS V(COL) ');
  //  FDQueryBase.SQL.Add
  //    ('  WHERE V.COL IS NULL  ) <> 0 and  ( SELECT COUNT(*) FROM (VALUES  ' +
  //    varMesesComLabelB + ') AS V(COL)  WHERE V.COL IS NULL  ) ');
  //  FDQueryBase.SQL.Add(' % 3 = 0 THEN ''ATEN��O'' ELSE ''OK'' END STATUS, ');

    FDQueryBase.SQL.Add('''       ''  as STATUS, ');

    FDQueryBase.SQL.Add(' ( SELECT COUNT(*) FROM (VALUES ' + varMesesComLabelB +
      ')  AS V(COL) WHERE V.COL IS NOT NULL  AND V.COL > 0 ) AS HITS, ');

    //FDQueryBase.SQL.Add(' ( SELECT COUNT(*) FROM (VALUES  ' + varMesesComLabelB
    //  + ') AS V(COL) WHERE V.COL IS NULL  ) AS RECENCIA, ');
    FDQueryBase.SQL.Add('0  as RECENCIA, ');
    FDQueryBase.SQL.Add('0  as CLIENTENOVO, ');
       // Colunas Fixo em 12 Meses
    FDQueryBase.SQL.Add('99999999.999999  as MEDIA_12, ');
    FDQueryBase.SQL.Add('''F'' as CLASSIFICACAO_12, ');
    FDQueryBase.SQL.Add('99999999.999999  as ACUMULADO_12, ');


    // Colunas Flutuantes conforme o filtro por Periodo

    FDQueryBase.SQL.Add(' 	 CASE WHEN  ( SELECT COUNT(*)  ');
    FDQueryBase.SQL.Add('     FROM (VALUES ' + varMesesComLabelB +
      ') AS V(COL) WHERE V.COL IS NOT NULL ) > 0 THEN ' + varMesesSomaLinha);
    FDQueryBase.SQL.Add(' /  ( SELECT COUNT(*)   FROM (VALUES  ' +
      varMesesComLabelB +
      ') AS V(COL) WHERE V.COL IS NOT NULL ) ELSE 0 END MEDIA, ');
    FDQueryBase.SQL.Add('''''  as Classificacao, ');
    FDQueryBase.SQL.Add(varMesesSomaLinha + ' as Acumulado, ');
    FDQueryBase.SQL.Add(varMesesComLabelB);

   // FDQueryBase.SQL.Add(' , GETDATE()  AS DTA_GERADO,  ');

   // FDQueryBase.SQL.Add(QuotedStr(Fr_Brady.TSIS_USUNOM) + ' AS USUARIO');

    FDQueryBase.SQL.Add(' INTO TSOP_RECUPERACLIENTE_' + NomedoUsuario + ' FROM BILLING B ');
  //  FDQueryBase.SQL.Add(' FROM BILLING B ');

    FDQueryBase.SQL.Add(' ORDER BY 19 DESC ');

    FDQueryBase.ParamByName('MES_INI').AsDateTime := IncMonth(IncMonth(System.DateUtils.StartOfTheMonth(NovaData), +1), -(iPeriodo + 1));
    FDQueryBase.ParamByName('MES_FIM').AsDateTime := IncMonth(IncMonth(System.DateUtils.EndOfTheMonth(NovaData), -iPeriodo), iPeriodo);



    // FDQueryBase.ParamByName( 'TSOP_USUCOD' ).AsInteger := Fr_Brady.TSIS_USUCOD;


    // Fr_Brady.TSIS_USUNOM := 'ALESSANDRA GO�ALO';

    if cxCanal.Text <> '' then
      FDQueryBase.MacroByName('WHERE1').AsRaw := ' AND B01.TSOP_ORDBILCANNOM = '
        + QuotedStr(cxCanal.Text);
    {
      if ((Fr_Brady.SalesRep) or (chkVendedor.Checked)) then
      begin
      FDQueryBase.MacroByName( 'WHERE3' ).AsRaw := ' AND B01.TSOP_ORDBILREPNOM  = '  + QuotedStr(Fr_Brady.TSIS_USUNOM);
      FDQueryBase.MacroByName( 'WHERE4' ).AsRaw := ' AND B01.TSOP_ORDBILREPNOM  = '  + QuotedStr(Fr_Brady.TSIS_USUNOM);
      End;
    }

    {
      FDQueryBase.MacroByName( 'WHERE3' ).AsRaw := ' AND B01.TSOP_ORDBILREPNOM  = ''HUGO CASIMIRO'' ' ;
      FDQueryBase.MacroByName( 'WHERE4' ).AsRaw := ' AND B01.TSOP_ORDBILREPNOM  = ''HUGO CASIMIRO'' ' ;
    }

   //  FDQueryBase.SQL.SaveToFile('C:\Brady\BaseClientesMar_2021.sql');

    // Criando Tabela no Banco
    FDQueryBase.ExecSQL;


    CriarRegistroQtdeVendas;

    // Recuperando Tabela Criada
    FDQueryBase.Close;
    FDQueryBase.SQL.Clear;
    FDQueryBase.sql.Add('Select * From dbo.TSOP_RECUPERACLIENTE_' +  NomedoUsuario  + ' Where TSOP_ORDBILREPNOM <> :TSOP_ORDBILREPNOM Order by ACUMULADO DESC' );
    FDQueryBase.Params.ParamByName('TSOP_ORDBILREPNOM').AsString := 'ASSISTENCIA TECNICA';
    FDQueryBase.Open;


    // Copiando Tabela para Mem�ria
    CopiaDataSetParaMemoria;

    // Aplicando Regras na Mem�ria
    AddRegras;

    // Limpando Tabela do Banco
    FDQueryBase.Close;
    FDQueryBase.SQL.Clear;
    FDQueryBase.sql.Add('Truncate Table dbo.TSOP_RECUPERACLIENTE_' + NomedoUsuario);
    FDQueryBase.ExecSQL;

    Mensagem(' Organizando Dados...');
    //Copiando da Mem�ria para Dados para o Banco
    CopiaDataSetParaBanco;


    // Ajustando Cliente Novo, para codigos repetidos em diferentes regioes ( Tambore, Manaus )
    FDQueryAux2.Close;
    FDQueryAux2.SQL.Clear;
    FDQueryAux2.SQL.Add(' UPDATE dbo.TSOP_RECUPERACLIENTE_' + NomedoUsuario );
    FDQueryAux2.SQL.Add('  SET  CLIENTENOVO = 0  ');
    FDQueryAux2.SQL.Add('  WHERE TSOP_ORDBILCLICOD IN (  ');
    FDQueryAux2.SQL.Add('  SELECT TSOP_ORDBILCLICOD FROM TSOP_RECUPERACLIENTE_' + NomedoUsuario + ' WHERE TSOP_ORDBILCLICOD IN ( ');
    FDQueryAux2.SQL.Add('  SELECT TSOP_ORDBILCLICOD FROM TSOP_RECUPERACLIENTE_' + NomedoUsuario + ' WHERE CLIENTENOVO = 1) AND CLIENTENOVO = 0 AND HITS > 0)  ');
    FDQueryAux2.ExecSQL;


    // Recuperando Tabela Atualizada com as Regras
    FDQueryRecuperaCliente.Close;
    FDQueryRecuperaCliente.SQL.Clear;
    FDQueryRecuperaCliente.sql.Add('Select * From dbo.TSOP_RECUPERACLIENTE_' +  NomedoUsuario + ' Order by ACUMULADO DESC, CLASSIFICACAO ASC' );
    FDQueryRecuperaCliente.Open;


    //Adicionando Colunas no Grid
    AddColumnGrid1;


    FDQueryResumo1.Close;
    FDQueryResumo1.SQL.Clear;
    FDQueryResumo1.sql.Add('Select Classificacao, SUM(Acumulado) as Acumulado,  ' + VarMesesSUM + ' from TSOP_RECUPERACLIENTE_' + NomedoUsuario );
    FDQueryResumo1.sql.Add(' Where Acumulado <> 0 ');
    FDQueryResumo1.sql.Add(' Group BY Classificacao ' );
    FDQueryResumo1.Open;

    FDQueryAux.Close;
    FDQueryAux.SQL.Clear;
    //FDQueryAux.SQL.Add('SELECT DISTINCT COUNT(1) AS Quantidade ' );

    FDQueryAux.SQL.Add('SELECT COUNT(DISTINCT A.TSOP_ORDBILCLICOD) AS Quantidade ' );
    FDQueryAux.SQL.Add('FROM TSOP_CLIENTE_ATIVO A ');
    FDQueryAux.SQL.Add('INNER JOIN dbo.TSOP_RECUPERACLIENTE_' + NomedoUsuario + ' R ON R.TSOP_ORDBILCLICOD = A.TSOP_ORDBILCLICOD ');
    FDQueryAux.SQL.Add('INNER JOIN VSOP_CLIENTEBYSALESREPFORECAST B ON B.TSOP_ORDBILCLICOD = A.TSOP_ORDBILCLICOD AND B.TSOP_ORDBILSITNOM = A.TSOP_ORDBILSITNOM  ');
    FDQueryAux.SQL.Add('AND R.TSOP_ORDBILSITNOM = A.TSOP_ORDBILSITNOM AND R.CLASSIFICACAO IN (''A'', ''B'',''C'') ');
    FDQueryAux.SQL.Add('WHERE  A.DATAFINAL = :DATAFINAL AND B.TSOP_ORDBILCANNOM <> ''DM'' ');
    FDQueryAux.Params.ParamByName('DATAFINAL').AsDate :=   IncMonth(IncMonth(System.DateUtils.EndOfTheMonth(NovaData), -12), 11);
    FDQueryAux.Open;
    if not FDQueryAux.IsEmpty then
    begin
       FDQueryAux2.Close;
       FDQueryAux2.SQL.Clear;
       FDQueryAux2.SQL.Add('Update TSOP_RECUPERACLIENTE_QTDEVENDAS' );
       FDQueryAux2.SQL.Add(' Set Quantidade = :Quantidade');
       FDQueryAux2.SQL.Add( 'where Data = :Data');
       FDQueryAux2.Params.ParamByName('Quantidade').AsInteger := FDQueryAux.FieldByName('Quantidade').AsInteger;
       FDQueryAux2.Params.ParamByName('Data').AsDate :=   IncMonth(IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -12), 11);
       FDQueryAux2.ExecSQL;
    end;

    FDQueryAux.Close;
    FDQueryAux.SQL.Clear;
    FDQueryAux.SQL.Add('SELECT COUNT(1) AS Quantidade ' );
    FDQueryAux.SQL.Add(' FROM dbo.TSOP_RECUPERACLIENTE_' + NomedoUsuario );
    FDQueryAux.SQL.Add('WHERE CLIENTENOVO = 1 ');

    FDQueryAux.Open;
    if not FDQueryAux.IsEmpty then
    begin
       FDQueryAux2.Close;
       FDQueryAux2.SQL.Clear;
       FDQueryAux2.SQL.Add('Update TSOP_RECUPERACLIENTE_QTDEVENDAS' );
       FDQueryAux2.SQL.Add(' Set TOTALCLIENTES = :Quantidade');
       FDQueryAux2.SQL.Add( 'where Data = :Data');
       FDQueryAux2.Params.ParamByName('Quantidade').AsInteger := FDQueryAux.FieldByName('Quantidade').AsInteger;
       FDQueryAux2.Params.ParamByName('Data').AsDate :=   IncMonth(IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -12), 11);
       FDQueryAux2.ExecSQL;
    end;



    FDQueryResumo2.Close;
    FDQueryResumo2.SQL.Clear;
    FDQueryResumo2.sql.Add('Select  * from TSOP_RECUPERACLIENTE_RESUMO_' + NomedoUsuario );
    FDQueryResumo2.sql.Add(' Where Acumulado = 0.00 ');
    FDQueryResumo2.sql.Add(' UNION ALL ');
    FDQueryResumo2.sql.Add('SELECT ''GRAFICO'' AS TSOP_ORDBILREPNOM, ');
    FDQueryResumo2.sql.Add('  '''' AS TSOP_ORDBILGRUCLINOM,');
    FDQueryResumo2.sql.Add('  '''' AS TSOP_ORDBILCLICOD, ');
 	  FDQueryResumo2.sql.Add('  '''' AS TSOP_ORBBILCLINOM, ');
 	  FDQueryResumo2.sql.Add('  '''' AS TSOP_ORDBILSITNOM,');
 	  FDQueryResumo2.sql.Add('  '''' AS TSOP_ORDBILCANNOM, ');
	  FDQueryResumo2.sql.Add('  '''' AS TSOP_ORDBILREG, ');
	  FDQueryResumo2.sql.Add('  '''' AS TSOP_ORDBILREGEST, ');
	  FDQueryResumo2.sql.Add('  ''Clientes Ativos'' AS TSOP_REPCSR,');
	  FDQueryResumo2.sql.Add('  '''' AS STATUS, ');
	  FDQueryResumo2.sql.Add('  0 AS HITS,');
	  FDQueryResumo2.sql.Add('  0 AS RECENCIA, ');
	  FDQueryResumo2.sql.Add('  0 AS CLIENTENOVO, ');
	  FDQueryResumo2.sql.Add('  0.00 AS MEDIA_12, ');
	  FDQueryResumo2.sql.Add('  '''' AS CLASSIFICACAO_12, ');
	  FDQueryResumo2.sql.Add('  0.00 AS ACUMULADO_12, ');
	  FDQueryResumo2.sql.Add('  0.00 AS MEDIA, ');
	  FDQueryResumo2.sql.Add('  '''' AS CLASSIFICACAO, ');
	  FDQueryResumo2.sql.Add('  0.00 AS ACUMULADO, ');
    FDQueryResumo2.sql.Add(  varMesesSemLabelBUSA );
    FDQueryResumo2.sql.Add('FROM ( ');
    FDQueryResumo2.sql.Add('   Select QUANTIDADE, CONVERT(CHAR(4), DATA, 100) + CONVERT(CHAR(4), DATA, 120) AS Mes ');
    FDQueryResumo2.sql.Add('     From TSOP_RECUPERACLIENTE_QTDEVENDAS ');
    FDQueryResumo2.sql.Add(') sq  ');
    FDQueryResumo2.sql.Add(' PIVOT  ');
    FDQueryResumo2.sql.Add(' (  ');
    FDQueryResumo2.sql.Add(' SUM(QUANTIDADE)  ');
    FDQueryResumo2.sql.Add(' FOR Mes IN ( ' + varMesesSemLabelBUSA + ')');
    FDQueryResumo2.sql.Add(' ) AS PIVOTTABLE ');
    FDQueryResumo2.sql.Add(' UNION ALL ');

    FDQueryResumo2.sql.Add('SELECT ''GRAFICO'' AS TSOP_ORDBILREPNOM, ');
    FDQueryResumo2.sql.Add('  '''' AS TSOP_ORDBILGRUCLINOM,');
    FDQueryResumo2.sql.Add('  '''' AS TSOP_ORDBILCLICOD, ');
 	  FDQueryResumo2.sql.Add('  '''' AS TSOP_ORBBILCLINOM, ');
 	  FDQueryResumo2.sql.Add('  '''' AS TSOP_ORDBILSITNOM,');
 	  FDQueryResumo2.sql.Add('  '''' AS TSOP_ORDBILCANNOM, ');
	  FDQueryResumo2.sql.Add('  '''' AS TSOP_ORDBILREG, ');
	  FDQueryResumo2.sql.Add('  '''' AS TSOP_ORDBILREGEST, ');
	  FDQueryResumo2.sql.Add('  ''Novos Clientes'' AS TSOP_REPCSR,');
	  FDQueryResumo2.sql.Add('  '''' AS STATUS, ');
	  FDQueryResumo2.sql.Add('  0 AS HITS,');
	  FDQueryResumo2.sql.Add('  0 AS RECENCIA, ');
	  FDQueryResumo2.sql.Add('  0 AS CLIENTENOVO, ');
	  FDQueryResumo2.sql.Add('  0.00 AS MEDIA_12, ');
	  FDQueryResumo2.sql.Add('  '''' AS CLASSIFICACAO_12, ');
	  FDQueryResumo2.sql.Add('  0.00 AS ACUMULADO_12, ');
	  FDQueryResumo2.sql.Add('  0.00 AS MEDIA, ');
	  FDQueryResumo2.sql.Add('  '''' AS CLASSIFICACAO, ');
	  FDQueryResumo2.sql.Add('  0.00 AS ACUMULADO, ');
    FDQueryResumo2.sql.Add(  varMesesSemLabelBUSA );
    FDQueryResumo2.sql.Add('FROM ( ');
    FDQueryResumo2.sql.Add('   Select TOTALCLIENTES, CONVERT(CHAR(4), DATA, 100) + CONVERT(CHAR(4), DATA, 120) AS Mes ');
    FDQueryResumo2.sql.Add('     From TSOP_RECUPERACLIENTE_QTDEVENDAS ');
    FDQueryResumo2.sql.Add(') sq  ');
    FDQueryResumo2.sql.Add(' PIVOT  ');
    FDQueryResumo2.sql.Add(' (  ');
    FDQueryResumo2.sql.Add(' SUM(TOTALCLIENTES)  ');
    FDQueryResumo2.sql.Add(' FOR Mes IN ( ' + varMesesSemLabelBUSA + ')');
    FDQueryResumo2.sql.Add(' ) AS PIVOTTABLE ');
    FDQueryResumo2.Open;




    FDQueryResumo3.Close;
    FDQueryResumo3.SQL.Clear;
    FDQueryResumo3.sql.Add('Select  SUM(Acumulado) as Acumulado,  ' + VarMesesSUM + ' from TSOP_RECUPERACLIENTE_' + NomedoUsuario);
    FDQueryResumo3.sql.Add(' Where Acumulado <> 0 ');
    FDQueryResumo3.Open;

    //Adicionando Colunas no Grid
    AddColumnGrid2;

    AddColumnGrid3;

    AddColumnGrid4;

    FDQueryVisaoDinamica.Close;
    FDQueryVisaoDinamica.SQL.Clear;
    FDQueryVisaoDinamica.SQL.Add('SELECT TSOP_ORDBILCLICOD,TSOP_ORDBILREPNOM,TSOP_ORDBILGRUCLINOM,TSOP_ORDBILCLINOM,TSOP_ORDBILSITNOM,TSOP_ORDBILCANNOM,');
    FDQueryVisaoDinamica.SQL.Add('TSOP_ORDBILREG,TSOP_ORDBILREGEST,  TSOP_REPCSR, STATUS, HITS, RECENCIA, CLIENTENOVO, MEDIA_12, CLASSIFICACAO_12, ');
     {
    FDQueryVisaoDinamica.SQL.Add('CASE MES WHEN ''NOV 2019'' THEN  CAST(''2019'' + ''/'' + ''01'' + ''/'' + ''01'' AS DATE)  ');
    FDQueryVisaoDinamica.SQL.Add('         WHEN ''DEZ 2019'' THEN  CAST(''2019'' + ''/'' + ''02'' + ''/'' + ''01'' AS DATE) ');
    FDQueryVisaoDinamica.SQL.Add('         WHEN ''JAN 2020'' THEN  CAST(''2020'' + ''/'' + ''03'' + ''/'' + ''01'' AS DATE) ');
    FDQueryVisaoDinamica.SQL.Add('         WHEN ''FEV 2020'' THEN  CAST(''2020'' + ''/'' + ''04'' + ''/'' + ''01'' AS DATE) ');
    FDQueryVisaoDinamica.SQL.Add('         WHEN ''MAR 2020'' THEN  CAST(''2020'' + ''/'' + ''05'' + ''/'' + ''01'' AS DATE) ');
    FDQueryVisaoDinamica.SQL.Add('         WHEN ''ABR 2020'' THEN  CAST(''2020'' + ''/'' + ''06'' + ''/'' + ''01'' AS DATE) ');
    FDQueryVisaoDinamica.SQL.Add('         WHEN ''MAI 2020'' THEN  CAST(''2020'' + ''/'' + ''07'' + ''/'' + ''01'' AS DATE) ');
    FDQueryVisaoDinamica.SQL.Add('         WHEN ''JUN 2020'' THEN  CAST(''2020'' + ''/'' + ''08'' + ''/'' + ''01'' AS DATE) ');
    FDQueryVisaoDinamica.SQL.Add('         WHEN ''JUL 2020'' THEN  CAST(''2020'' + ''/'' + ''09'' + ''/'' + ''01'' AS DATE) ');
    FDQueryVisaoDinamica.SQL.Add('         WHEN ''AGO 2020'' THEN  CAST(''2020'' + ''/'' + ''10'' + ''/'' + ''01'' AS DATE)  ');
    FDQueryVisaoDinamica.SQL.Add('         WHEN ''SET 2020'' THEN  CAST(''2020'' + ''/'' + ''11'' + ''/'' + ''01'' AS DATE) ');
    FDQueryVisaoDinamica.SQL.Add('         WHEN ''OUT 2020'' THEN  CAST(''2020'' + ''/'' + ''12'' + ''/'' + ''01'' AS DATE)  ');
    FDQueryVisaoDinamica.SQL.Add(' 		  END DATA,  ');
                                                          }
    FDQueryVisaoDinamica.SQL.Add('CASE MES ' + varMesesCaseVisaoDinamica + ' END DATA, ');

    FDQueryVisaoDinamica.SQL.Add(' ACUMULADO_12, MEDIA, CLASSIFICACAO, ACUMULADO, [MES], [VALOR] ');
    FDQueryVisaoDinamica.SQL.Add(' FROM dbo.TSOP_RECUPERACLIENTE_' +  NomedoUsuario  );
    FDQueryVisaoDinamica.SQL.Add('UNPIVOT ( ');
    FDQueryVisaoDinamica.SQL.Add('    [VALOR] FOR [MES] IN ( ');
    FDQueryVisaoDinamica.SQL.Add(     varMesesSemLabelB );
    FDQueryVisaoDinamica.SQL.Add('    ) ');
    FDQueryVisaoDinamica.SQL.Add(') AS U ');
    FDQueryVisaoDinamica.SQL.Add('ORDER BY  TSOP_ORDBILCLICOD,TSOP_ORDBILREPNOM,TSOP_ORDBILGRUCLINOM, MES ');
    FDQueryVisaoDinamica.Open;

    FDQueryPeriodo.Close;
    FDQueryPeriodo.Open;

  finally

    Mensagem(EmptyStr);

  end;

end;

procedure TFr_RelatorioManutencaoClientes.AddRegras;
Var
  I, X, Y, J, Recession, TotalClientes : Integer;
  Ano, Mes, Dia: Word;
  ContaA, ContaB, ContaC: Integer;
  ContaClientesAtivos, ContaAcmA, ContaAcmB, ContaAcmC: Integer;
  SalvaValorA, SalvaValorB, SalvaValorC, GravaMediaCurrency, SomaMediaCurrency,  AcumuladoFixo, TotalAcumuladoFixo: Currency;

  ContaAFixo, ContaBFixo, ContaCFixo : Integer;
  ContaAcmAFixo, ContaAcmBFixo, ContaAcmCFixo : Integer;
  SalvaValorAFixo, SalvaValorBFixo, SalvaValorCFixo : Currency;

  //NovaData: TDateTime;
  Lista : TStringList;
  mesABC: String;

begin
    SetLength(varMesesABC, iPeriodo);
    SetLength(varMesesA, iPeriodo);
    SetLength(varMesesB, iPeriodo);
    SetLength(varMesesC, iPeriodo);
    SetLength(varSomaABC, iPeriodo);

    SetLength(varAnoAcumulado, 1);
    SetLength(varAcumuladoA, 1);
    SetLength(varAcumuladoB, 1);
    SetLength(varAcumuladoC, 1);

    for I := 0 to High(varMesesABC) do
    begin
       varMesesABC[I] := 0;
       varMesesA[I]   := 0;
       varMesesB[I]   := 0;
       varMesesC[I]   := 0;
       varSomaABC[I]  := 0;
    end;

    varAnoAcumulado[0] := 0;
    varAcumuladoA[0]   := 0;
    varAcumuladoB[0]   := 0;
    varAcumuladoC[0]   := 0;


    SetLength(varMesesABCFixo, iPeriodoFixo);
    SetLength(varMesesAFixo, iPeriodoFixo);
    SetLength(varMesesBFixo, iPeriodoFixo);
    SetLength(varMesesCFixo, iPeriodoFixo);

    SetLength(varAnoAcumuladoFixo, 1);
    SetLength(varAcumuladoAFixo, 1);
    SetLength(varAcumuladoBFixo,1);
    SetLength(varAcumuladoCFixo,1);



    for I := 0 to High(varMesesABCFixo) do
    begin
       varMesesABCFixo[I] := 0;
       varMesesAFixo[I]   := 0;
       varMesesBFixo[I]   := 0;
       varMesesCFixo[I]   := 0;
      // varSomaABC[I]  := 0;
    end;

    varAnoAcumuladoFixo[0] := 0;
    varAcumuladoAFixo[0]   := 0;
    varAcumuladoBFixo[0]   := 0;
    varAcumuladoCFixo[0]   := 0;


    // Acumulado de 12 meses fixos
    FDQueryRecuperaClienteMem.First;

    while not FDQueryRecuperaClienteMem.Eof do
    begin
        AcumuladoFixo := 0;
        for i := Fim_i downto 19 do
        begin
            if i > iPeriodoFixo then
            begin
              if not FDQueryRecuperaClienteMem.Fields[I].IsNull then
                AcumuladoFixo  := AcumuladoFixo +   FDQueryRecuperaClienteMem.Fields[I].Value;
            end;
        end;

        FDQueryRecuperaClienteMem.Edit;
        FDQueryRecuperaClienteMem.Fields[15].AsFloat := AcumuladoFixo;
        FDQueryRecuperaClienteMem.Post;
        varAnoAcumuladoFixo[0] := varAnoAcumuladoFixo[0] + AcumuladoFixo;
        FDQueryRecuperaClienteMem.next;
    end;


    // M�dia de 12 Meses fixos
    Mensagem('Obtendo dados (M�dia)...');
    FDQueryRecuperaClienteMem.First;
    while not FDQueryRecuperaClienteMem.Eof do
    begin
      Recession := 0;
      SomaMediaCurrency := 0;
      GravaMediaCurrency := 0;
      for i := Fim_i downto 19 do
      begin
        if FDQueryRecuperaClienteMem.Fields[I].AsFloat > 0 Then
        begin
          if i > iPeriodoFixo then
          begin
            Inc(Recession);
            SomaMediaCurrency := SomaMediaCurrency  + FDQueryRecuperaClienteMem.Fields[I].AsFloat;
          end;
        end;
      end;

      if Recession > 0 then
         GravaMediaCurrency :=  SomaMediaCurrency / Recession;
      FDQueryRecuperaClienteMem.Edit;
      FDQueryRecuperaClienteMem.FieldByName('MEDIA_12').ascurrency := GravaMediaCurrency;
      FDQueryRecuperaClienteMem.Post;

      FDQueryRecuperaClienteMem.Next;
    end;

    // 12 Meses Fixo
    FDQueryRecuperaClienteMem.DisableControls;
    for i := Fim_i downto 19 do
    begin
         if I >= iPeriodoFixo then
         begin
               FDQueryRecuperaClienteMem.First;
               while not FDQueryRecuperaClienteMem.Eof do
               begin
                  if (FDQueryRecuperaClienteMem.Fields[I].AsFloat > 0) then
                  begin
                      varMesesABCFixo[I-19] := varMesesABCFixo[I-19] +  FDQueryRecuperaClienteMem.Fields[I].Value;
                  end;
                  FDQueryRecuperaClienteMem.next;
               end;
         end;
    end;

    // 12 Meses Fixos
    for I := 0 to iPeriodo-1 do
    begin
      varMesesAFixo[I] := (varMesesABCFixo[I] / 100) * 80;
      varMesesBFixo[I] := (varMesesABCFixo[I] / 100) * 15;
      varMesesCFixo[I] := (varMesesABCFixo[I] / 100) * 5;
    end;
      // 12 Meses Fixos
    varAcumuladoAFixo[0] := (varAnoAcumuladoFixo[0] / 100) * 80;
    varAcumuladoBFixo[0] := (varAnoAcumuladoFixo[0] / 100) * 15;
    varAcumuladoCFixo[0] := (varAnoAcumuladoFixo[0] / 100) * 5;




    ContaAFixo := 0;
    ContaBFixo := 0;
    ContaCFixo := 0;

    ContaAcmAFixo := 0;
    ContaAcmBFixo := 0;
    ContaAcmCFixo := 0;


    SalvaValorAFixo := 0;
    SalvaValorBFixo := 0;
    SalvaValorCFixo := 0;

    SetLength(varMesesABCFixo, iPeriodoFixo);
    SetLength(varAnoAcumuladoFixo, 1);

    for i := 0 to High(varMesesABCFixo) do
        varMesesABCFixo[i] := 0;

    varAnoAcumuladoFixo[0] := 0;

    FDQueryRecuperaClienteMem.First;

    Mensagem('Obtendo dados (Classificando Cliente Anual)...');

    // Classificando 12 Meses Fixos


    while not FDQueryRecuperaClienteMem.Eof do
    begin
         if FDQueryRecuperaClienteMem.Fields[15].Value  <= 0 then
         begin

            FDQueryRecuperaClienteMem.Edit;
            FDQueryRecuperaClienteMem.Fields[14].Value := 'I';
            FDQueryRecuperaClienteMem.Post;

            FDQueryRecuperaClienteMem.next;
            Continue;
         end;

         varAnoAcumuladoFixo[0] :=  varAnoAcumuladoFixo[0] + FDQueryRecuperaClienteMem.Fields[15].Value ;

         if abs(varAnoAcumuladoFixo[0]) <= varAcumuladoAFixo[0] then
         begin
             Inc(ContaAcmAFixo);
             SalvaValorAFixo := varAnoAcumuladoFixo[0];

             FDQueryRecuperaClienteMem.Edit;
             FDQueryRecuperaClienteMem.Fields[14].Value  := 'A';
             FDQueryRecuperaClienteMem.Post;

         end
         else if (abs(varAnoAcumuladoFixo[0] - SalvaValorAFixo) <= varAcumuladoBFixo[0] ) then
         begin
             Inc(ContaAcmBFixo);
             SalvaValorBFixo := varAnoAcumuladoFixo[0];

             FDQueryRecuperaClienteMem.Edit;
             FDQueryRecuperaClienteMem.Fields[14].Value := 'B';
             FDQueryRecuperaClienteMem.Post;

         end
         else
         begin
             Inc(ContaAcmCFixo);

             FDQueryRecuperaClienteMem.Edit;
             FDQueryRecuperaClienteMem.Fields[14].Value  := 'C';
             FDQueryRecuperaClienteMem.Post;

         end;

         FDQueryRecuperaClienteMem.Next;
    end;

     //Limpar da Memoria
    SetLength(varMesesABCFixo, 0);
    SetLength(varMesesAFixo, 0);
    SetLength(varMesesBFixo, 0);
    SetLength(varMesesCFixo, 0);

    SetLength(varAnoAcumuladoFixo, 0);
    SetLength(varAcumuladoAFixo, 0);
    SetLength(varAcumuladoBFixo,0);
    SetLength(varAcumuladoCFixo,0);

   for I := 0 to High(varMesesABCFixo) do
    begin
       varMesesABCFixo[I] := 0;
       varMesesAFixo[I]   := 0;
       varMesesBFixo[I]   := 0;
       varMesesCFixo[I]   := 0;
    end;


    FDQueryRecuperaClienteMem.DisableControls;
    for i := 19 to Fim_i do
    begin
       FDQueryRecuperaClienteMem.First;
       begin
         while not FDQueryRecuperaClienteMem.Eof do
         begin
            if (FDQueryRecuperaClienteMem.Fields[I].AsFloat > 0) then
            begin
                varMesesABC[I-19] := varMesesABC[I-19] +  FDQueryRecuperaClienteMem.Fields[I].Value;
            end;
            FDQueryRecuperaClienteMem.next;
         end;
       end;
    end;


    FDQueryRecuperaClienteMem.First;
    while not FDQueryRecuperaClienteMem.Eof do
    begin
       varAnoAcumulado[0] :=  varAnoAcumulado[0] + FDQueryRecuperaClienteMem.FieldByName('Acumulado').AsCurrency;
       FDQueryRecuperaClienteMem.next;
    end;


    for I := 0 to iPeriodo-1 do
    begin
      varMesesA[I] := (varMesesABC[I] / 100) * 80;
      varMesesB[I] := (varMesesABC[I] / 100) * 15;
      varMesesC[I] := (varMesesABC[I] / 100) * 5;
    end;

    varAcumuladoA[0] := (varAnoAcumulado[0] / 100) * 80;
    varAcumuladoB[0] := (varAnoAcumulado[0] / 100) * 15;
    varAcumuladoC[0] := (varAnoAcumulado[0] / 100) * 5;

    ContaA := 0;
    ContaB := 0;
    ContaC := 0;

    ContaAcmA := 0;
    ContaAcmB := 0;
    ContaAcmC := 0;


    SalvaValorA := 0;
    SalvaValorB := 0;
    SalvaValorC := 0;

    SetLength(varMesesABC, iPeriodo);
    SetLength(varAnoAcumulado, 1);

    for i := 0 to High(varMesesABC) do
        varMesesABC[i] := 0;

    varAnoAcumulado[0] := 0;

    FDQueryRecuperaClienteMem.First;

    Mensagem('Obtendo dados (Classificando Cliente Anual)...');

    while not FDQueryRecuperaClienteMem.Eof do
    begin
         if FDQueryRecuperaClienteMem.Fields[18].Value  <= 0 then
         begin

            FDQueryRecuperaClienteMem.Edit;
            FDQueryRecuperaClienteMem.Fields[17].Value := 'I';
            FDQueryRecuperaClienteMem.Post;

            FDQueryRecuperaClienteMem.next;
            Continue;
         end;

         varAnoAcumulado[0] :=  varAnoAcumulado[0] + FDQueryRecuperaClienteMem.Fields[18].Value ;

         if abs(varAnoAcumulado[0]) <= varAcumuladoA[0] then
         begin
             Inc(ContaAcmA);
             SalvaValorA := varAnoAcumulado[0];

             FDQueryRecuperaClienteMem.Edit;
             FDQueryRecuperaClienteMem.Fields[17].Value  := 'A';
             FDQueryRecuperaClienteMem.Post;

         end
         else if (abs(varAnoAcumulado[0] - SalvaValorA) <= varAcumuladoB[0] ) then
         begin
             Inc(ContaAcmB);
             SalvaValorB := varAnoAcumulado[0];

             FDQueryRecuperaClienteMem.Edit;
             FDQueryRecuperaClienteMem.Fields[17].Value := 'B';
             FDQueryRecuperaClienteMem.Post;

         end
         else
         begin
             Inc(ContaAcmC);

             FDQueryRecuperaClienteMem.Edit;
             FDQueryRecuperaClienteMem.Fields[17].Value  := 'C';
             FDQueryRecuperaClienteMem.Post;

         end;

         FDQueryRecuperaClienteMem.Next;
    end;

    //Lista := TStringList.Create;
    //Lista.Clear;
    Mensagem('Obtendo dados (Frequ�ncia e Status)...');
    FDQueryRecuperaClienteMem.First;
    while not FDQueryRecuperaClienteMem.Eof do
    begin
        Recession := 0;
        for i := Fim_i downto 19 do
          if FDQueryRecuperaClienteMem.Fields[I].AsFloat <= 0 Then
          begin
               Inc(Recession);
          end
          else
          begin

             if (Recession > 3) then
             begin
               FDQueryRecuperaClienteMem.Edit;
               FDQueryRecuperaClienteMem.FieldByName('STATUS').AsString := 'ATEN��O';
               FDQueryRecuperaClienteMem.FieldByName('Recencia').AsInteger := Recession;
               FDQueryRecuperaClienteMem.Post;

             end
             else
             begin
               FDQueryRecuperaClienteMem.Edit;
               FDQueryRecuperaClienteMem.FieldByName('STATUS').AsString := 'OK';
               FDQueryRecuperaClienteMem.FieldByName('Recencia').AsInteger := Recession;
               FDQueryRecuperaClienteMem.Post;
             end;


             break;
          end;

      //     if (Recession <= 11) then
     //         Lista.Add(FDQueryRecuperaClienteMem.FieldByName('TSOP_ORDBILCLICOD').AsString + ';' + IntToStr(Recession) + ';');



          if FDQueryRecuperaClienteMem.fieldbyname('Classificacao').AsString = 'I' then
          begin
             FDQueryRecuperaClienteMem.Edit;
             FDQueryRecuperaClienteMem.FieldByName('STATUS').AsString    := 'ATEN��O';
             FDQueryRecuperaClienteMem.FieldByName('Recencia').AsInteger := Recession;
             FDQueryRecuperaClienteMem.Post;
          end;

        FDQueryRecuperaClienteMem.Next;
    end;
   // Lista.SaveToFile('c:\brady\lista_recencia_15.csv');
   // FreeAndNil(Lista);

    Mensagem('Obtendo dados (Clientes Novos)...');
    FDQueryRecuperaClienteMem.First;
    TotalClientes := 0;
    while not FDQueryRecuperaClienteMem.Eof do
    begin
        Recession := 0;

        for i := Fim_i downto 19 do
        begin
          if FDQueryRecuperaClienteMem.Fields[I].AsFloat > 0 Then
          begin
             if I = Fim_i then
               Inc(Recession)
             else
               Recession := 0;
          end;
        end;

        if (Recession = 1) then
        begin
          FDQueryRecuperaClienteMem.Edit;
          FDQueryRecuperaClienteMem.FieldByName('CLIENTENOVO').AsInteger := Recession;
          FDQueryRecuperaClienteMem.Post;
          TotalClientes := TotalClientes +  Recession;
        end;

        FDQueryRecuperaClienteMem.Next;
    end;

    if TotalClientes > 0 then
    begin
       Try
          FDQueryAux.Close;
          FDQueryAux.SQL.Clear;
          FDQueryAux.SQL.Add(' UPDATE  TSOP_RECUPERACLIENTE_QTDEVENDAS ');
          FDQueryAux.SQL.Add(' Set TOTALCLIENTES = :TOTALCLIENTES ');
          FDQueryAux.SQL.Add(' WHERE DATA = :DATA ');
          FDQueryAux.Params.ParamByName('TOTALCLIENTES').AsInteger :=  TotalClientes;
          FDQueryAux.Params.ParamByName('DATA').AsDate             :=  IncMonth(IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -12), 11);
          FDQueryAux.ExecSQL;
       except
       on E: Exception do
          begin
             Mensagem( '1 ' + E.Message );
          end;
       End;
    end;


    for I := 19 to Fim_i do
    begin

        FDQueryRecuperaClienteMem.First;
        ContaA := 0;
        ContaB := 0;
        ContaC := 0;
        SalvaValorA := 0;
        SalvaValorB := 0;
        SalvaValorC := 0;


        mesABC := BuscaMes(varMesesArrayB[I - 19], False, 'B', False, False, False, False);
        mesABC := Copy(mesABC, 1, Length(mesABC) - 1);

        while not FDQueryRecuperaClienteMem.Eof do
        begin
          Mensagem('Obtendo Dados Gr�fico M�s: ' + mesABC );

          if (FDQueryRecuperaClienteMem.Fields[I].AsFloat <= 0) then
          begin

              if cdsGraficoDetalhe.FindKey([FDQueryRecuperaClienteMem.Fields[2].AsString,FDQueryRecuperaClienteMem.Fields[4].AsString]) then
              begin
                 cdsGraficoDetalhe.Edit;
                 cdsGraficoDetalhe.Fields[I - 17].AsString := 'I';
                 cdsGraficoDetalhe.Post;
              end
              else
              begin
                 cdsGraficoDetalhe.Append;
                 cdsGraficoDetalhe.Fields[0].AsString := FDQueryRecuperaClienteMem.Fields[2].AsString;
                 cdsGraficoDetalhe.Fields[1].AsString := FDQueryRecuperaClienteMem.Fields[4].AsString;
                 cdsGraficoDetalhe.Fields[I - 17].AsString := 'I';
                 cdsGraficoDetalhe.Post;
              end;

              FDQueryRecuperaClienteMem.next;

              Continue;
          end;

          varMesesABC[I - 19] := varMesesABC[I - 19] + FDQueryRecuperaClienteMem.Fields[I].Value;

          if varMesesABC[I - 19] <= varMesesA[I - 19] then
          begin
              Inc(ContaA);
              SalvaValorA := varMesesABC[I - 19];

              if cdsGraficoDetalhe.FindKey([FDQueryRecuperaClienteMem.Fields[2].AsString,FDQueryRecuperaClienteMem.Fields[4].AsString]) then
              begin
                 cdsGraficoDetalhe.Edit;
                 cdsGraficoDetalhe.Fields[I - 17].AsString := 'A';
                 cdsGraficoDetalhe.Post;
              end
              else
              begin
                 Try
                   cdsGraficoDetalhe.Append;
                   cdsGraficoDetalhe.Fields[0].AsString := FDQueryRecuperaClienteMem.Fields[2].AsString;
                   cdsGraficoDetalhe.Fields[1].AsString := FDQueryRecuperaClienteMem.Fields[4].AsString;
                   cdsGraficoDetalhe.Fields[I - 17].AsString := 'A';
                   cdsGraficoDetalhe.Post;
                 except
                    on E: Exception do
                    begin

                      Mensagem( '1 ' + E.Message );


                    end;

                  end;
              end;

          end
          else if ((varMesesABC[I - 19] - SalvaValorA) <= varMesesB[I - 19]) then
          begin
              Inc(ContaB);
              SalvaValorB := varMesesABC[I - 19] - SalvaValorA;

              if cdsGraficoDetalhe.FindKey([FDQueryRecuperaClienteMem.Fields[2].AsString,FDQueryRecuperaClienteMem.Fields[4].AsString]) then
              begin
                 cdsGraficoDetalhe.Edit;
                 cdsGraficoDetalhe.Fields[I - 17].AsString := 'B';
                 cdsGraficoDetalhe.Post;
              end
              else
              begin
                 cdsGraficoDetalhe.Append;
                 cdsGraficoDetalhe.Fields[0].AsString := FDQueryRecuperaClienteMem.Fields[2].AsString;
                 cdsGraficoDetalhe.Fields[1].AsString := FDQueryRecuperaClienteMem.Fields[4].AsString;
                 cdsGraficoDetalhe.Fields[I - 17].AsString := 'B';
                 cdsGraficoDetalhe.Post;
              end;

            end
            else
            begin
              Inc(ContaC);

              if cdsGraficoDetalhe.FindKey([FDQueryRecuperaClienteMem.Fields[2].AsString,FDQueryRecuperaClienteMem.Fields[4].AsString]) then
              begin
                cdsGraficoDetalhe.Edit;
                cdsGraficoDetalhe.Fields[I - 17].AsString := 'C';
                cdsGraficoDetalhe.Post;
              end
              else
              begin
                 cdsGraficoDetalhe.Append;
                 cdsGraficoDetalhe.Fields[0].AsString := FDQueryRecuperaClienteMem.Fields[2].AsString;
                 cdsGraficoDetalhe.Fields[1].AsString := FDQueryRecuperaClienteMem.Fields[4].AsString;
                 cdsGraficoDetalhe.Fields[I - 17].AsString := 'C';
                 cdsGraficoDetalhe.Post;
              end;
            end;

            FDQueryRecuperaClienteMem.next;
          end;

          varSomaABC[I-19] := (ContaA + ContaB + ContaC);

          cdsGrafico.IndexFieldNames := 'Curva';
          if cdsGrafico.FindKey(['A']) then
          begin
            cdsGrafico.Edit;
            cdsGrafico.FieldByName(mesABC).AsInteger := ContaA;
            cdsGrafico.Post;
          end
          else
          begin
            cdsGrafico.Append;
            cdsGrafico.FieldByName('Curva').AsString := 'A';
            cdsGrafico.FieldByName(mesABC).AsInteger := ContaA;
            cdsGrafico.Post;
          end;

          if cdsGrafico.FindKey(['B']) then
          begin
            cdsGrafico.Edit;
            cdsGrafico.FieldByName(mesABC).AsInteger := ContaB;
            cdsGrafico.Post;
          end
          else
          begin
            cdsGrafico.Append;
            cdsGrafico.FieldByName('Curva').AsString := 'B';
            cdsGrafico.FieldByName(mesABC).AsInteger := ContaB;
            cdsGrafico.Post;
          end;

          if cdsGrafico.FindKey(['C']) then
          begin
            cdsGrafico.Edit;
            cdsGrafico.FieldByName(mesABC).AsInteger := ContaC;
            cdsGrafico.Post;
          end
          else
          begin
            cdsGrafico.Append;
            cdsGrafico.FieldByName('Curva').AsString := 'C';
            cdsGrafico.FieldByName(mesABC).AsInteger := ContaC;
            cdsGrafico.Post;
          end;

    end;


    if FileExists(MyDocumentsPath + '\' +  DataFileMestre) then
     DeleteFile(MyDocumentsPath + '\' +  DataFileMestre);

    if FileExists(MyDocumentsPath  + '\' +  DataFileDetalhe) then
     DeleteFile(MyDocumentsPath  + '\' +  DataFileDetalhe);

    cdsGrafico.SaveToFile(MyDocumentsPath + '\' +    DataFileMestre);
    cdsGraficoDetalhe.SaveToFile(MyDocumentsPath  + '\' +  DataFileDetalhe);




    FDQueryRecuperaClienteMem.First;
    cdsGraficoDetalhe.First;
    FDQueryRecuperaClienteMem.EnableControls;
    cdsGraficoDetalhe.EnableControls;
    try
      FDQueryAux.Close;
      FDQueryAux.SQL.Clear;
      FDQueryAux.SQL.Add(' SELECT * INTO TSOP_RECUPERACLIENTE_RESUMO_' + NomedoUsuario );
      FDQueryAux.SQL.Add(' From TSOP_RECUPERACLIENTE_' + NomedoUsuario);
      FDQueryAux.SQL.Add(' WHERE 1 <> 1 ');
      FDQueryAux.ExecSQL;
    except
      on E: Exception do
      begin
        Mensagem( '1 ' + E.Message );
      end;
    end;

    ContaClientesAtivos := 0;
   // NovaData := System.DateUtils.StartOfTheMonth(now);
   // NovaData := IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -1);

    {
    Try
      for i := Fim_i downto 19 do
      begin
         if i > iPeriodoFixo then
            ContaClientesAtivos := ContaClientesAtivos + varSomaABC[I-19];
      end;

      if ContaClientesAtivos > 0 then
      begin
        FDQueryAux.Close;
        FDQueryAux.SQL.Clear;
        FDQueryAux.SQL.Add(' UPDATE  TSOP_RECUPERACLIENTE_QTDEVENDAS ');
        FDQueryAux.SQL.Add(' Set QUANTIDADE = :QUANTIDADE');
        FDQueryAux.SQL.Add(' WHERE DATA = :DATA  ');
        FDQueryAux.Params.ParamByName('QUANTIDADE').AsInteger  :=  ContaClientesAtivos;
        FDQueryAux.Params.ParamByName('DATA').AsDate           :=  NovaData;
        FDQueryAux.ExecSQL;
      end;
    except
      on E: Exception do
        begin
        Mensagem( '1 ' + E.Message );
        end;
    End;
     }


    Try
      FDQueryAux.Close;
      FDQueryAux.SQL.Clear;
      FDQueryAux.SQL.Add('Insert Into TSOP_RECUPERACLIENTE_RESUMO_' + NomedoUsuario);
      FDQueryAux.SQL.Add(' ( Classificacao, Acumulado,  RECENCIA, STATUS, TSOP_REPCSR, CLIENTENOVO, MEDIA_12, CLASSIFICACAO_12, ACUMULADO_12, ');
      for I := 19 to Fim_i do
      begin
        mesABC := BuscaMes(varMesesArrayB[I - 19], False, 'B', False, False, False, False);
        if I = Fim_i then
          mesABC := Copy(mesABC, 1, Length(mesABC) - 1);
        FDQueryAux.SQL.Add(mesABC);
      end;


      FDQueryAux.SQL.Add(') Values ( '''', ');
      FDQueryAux.SQL.Add(' 0, ' );
      FDQueryAux.SQL.Add(' 0,''.'',''Total de Clientes'',0,0.0,''.'',0.0,');
      for I := 0 to iPeriodo-1 do
      begin
         FDQueryAux.SQL.Add( IntToStr(varSomaABC[I]));
         if i <> iPeriodo-1 then
           FDQueryAux.SQL.Add( ',');
      end;
      FDQueryAux.SQL.Add('),');


      FDQueryAux.SQL.Add(' ( '''', ');
      FDQueryAux.SQL.Add(   FormatFloat('0.##', varAnoAcumulado[0]).Replace(',','.') + ',' );
      FDQueryAux.SQL.Add(' 0,''.'','','',0,0.0,''.'',0.0,');
      for I := 0 to iPeriodo-1 do
      begin

        FDQueryAux.SQL.Add(  FormatFloat('0.##', varMesesA[I]+varMesesB[I]+varMesesC[I] ).Replace(',','.') );
        if i <> iPeriodo-1 then
           FDQueryAux.SQL.Add( ',');
      end;
      FDQueryAux.SQL.Add('),');


      FDQueryAux.SQL.Add(' ( ''A'', ');
      FDQueryAux.SQL.Add(   FormatFloat('0.##', varAcumuladoA[0]).Replace(',','.') + ',' );
       FDQueryAux.SQL.Add(' 0,''.'','','',0,0.0,''.'',0.0,');
      for I := 0 to iPeriodo-1 do
      begin

        FDQueryAux.SQL.Add(  FormatFloat('0.##', varMesesA[I]).Replace(',','.') );
        if i <> iPeriodo-1 then
           FDQueryAux.SQL.Add( ',');
      end;
      FDQueryAux.SQL.Add('),');

      FDQueryAux.SQL.Add(' ( ''B'', ');
      FDQueryAux.SQL.Add(   FormatFloat('0.##', varAcumuladoB[0]).Replace(',','.') + ',' );
       FDQueryAux.SQL.Add(' 0,''.'','','',0,0.0,''.'',0.0,');
      for I := 0 to iPeriodo-1 do
      begin

        FDQueryAux.SQL.Add( FormatFloat('0.##', varMesesB[I]).Replace(',','.') );
        if i <> iPeriodo-1 then
           FDQueryAux.SQL.Add( ',');

      end;
      FDQueryAux.SQL.Add('),');

      FDQueryAux.SQL.Add(' ( ''C'', ');
      FDQueryAux.SQL.Add(   FormatFloat('0.##', varAcumuladoC[0]).Replace(',','.') + ',' );
       FDQueryAux.SQL.Add(' 0,''.'','','',0,0.0,''.'',0.0,');
      for I := 0 to iPeriodo-1 do
      begin

        FDQueryAux.SQL.Add( FormatFloat('0.##', varMesesC[I]).Replace(',','.') );
        if i <> iPeriodo-1 then
           FDQueryAux.SQL.Add( ',');
      end;
      FDQueryAux.SQL.Add(')');

   //   FDQueryAux.SQL.SaveToFile('c:\brady\insert_resumo_erro.sql');

      FDQueryAux.ExecSQL;
    except
     on E: Exception do
      begin

        Mensagem( '2 ' + E.Message );


      end;

    end;



end;


procedure TFr_RelatorioManutencaoClientes.AddColumnGrid1;
var
  AColumn: TcxGridDBBandedColumn;
  I : Integer;
  sumItem: TcxDataSummaryItem;
begin
  cxGrid1DBBandedTableView1.BeginUpdate();
  cxGrid1DBBandedTableView1.DataController.CreateAllItems;
  cxGrid1DBBandedTableView1.OptionsView.FixedBandSeparatorWidth := 2;


  try

    ABand := cxGrid1DBBandedTableView1.Bands.Add;
    ABand.Index := 0;
    ABand.HeaderAlignmentHorz := taCenter;
    ABand.Caption := 'Informa��es de Clientes';
    ABand.FixedKind := fkLeft;

    ABand := cxGrid1DBBandedTableView1.Bands.Add;
    ABand.Index := 1;
    ABand.HeaderAlignmentHorz := taCenter;
    ABand.Caption := 'Billing';

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 120;
    AColumn.Caption := 'CSR';
    AColumn.DataBinding.FieldName :=  FDQueryRecuperaCliente.Fields[8].FieldName;
    AColumn.Position.BandIndex := 0;
    cxGrid1DBBandedTableView1.DataController.Summary.FooterSummaryItems.Add
        (AColumn, spFooter, skCount, '####');

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 120;
    AColumn.Caption := 'Acc Owner';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[0].FieldName;
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 120;
    AColumn.Caption := 'Grupo';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[1].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 70;
    AColumn.Caption := 'C�digo';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[2].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 200;
    AColumn.Caption := 'Nome';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[3].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 60;
    AColumn.Caption := 'Site';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[4].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 65;
    AColumn.Caption := 'Canal';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[5].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 65;
    AColumn.Caption := 'Regi�o';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[6].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 40;
    AColumn.Caption := 'UF';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[7].FieldName;
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 40;
    AColumn.Caption := 'Status';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[9].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 40;
    AColumn.Caption := 'Hits';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[10].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 40;
    AColumn.Caption := 'Rec�ncia';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[11].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 40;
    AColumn.Caption := 'Novos Clientes';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[12].FieldName;
    AColumn.Position.BandIndex := 0;
     cxGrid1DBBandedTableView1.DataController.Summary.FooterSummaryItems.Add
        (AColumn, spFooter, skSum, '####');


      AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 40;
    AColumn.Caption := 'M�dia_12';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[13].FieldName;
    AColumn.PropertiesClass := TcxCurrencyEditProperties;
    TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 40;
    AColumn.Caption := 'Classifica��o_12';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[14].FieldName;
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 40;
    AColumn.Caption := 'Acumulado_12';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[15].FieldName;
    AColumn.PropertiesClass := TcxCurrencyEditProperties;
    TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';
    AColumn.Position.BandIndex := 0;
    cxGrid1DBBandedTableView1.DataController.Summary.FooterSummaryItems.Add
        (AColumn, spFooter, skSum, '##.###.###,##');



    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 40;
    AColumn.Caption := 'M�dia';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[16].FieldName;
    AColumn.PropertiesClass := TcxCurrencyEditProperties;
    TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 40;
    AColumn.Caption := 'Classifica��o';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[17].FieldName;
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 40;
    AColumn.Caption := 'Acumulado';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[18].FieldName;
    AColumn.PropertiesClass := TcxCurrencyEditProperties;
    TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';
    AColumn.Position.BandIndex := 0;
    cxGrid1DBBandedTableView1.DataController.Summary.FooterSummaryItems.Add
        (AColumn, spFooter, skSum, '##.###.###,##');

    for I := 19 to Fim_i do
    begin

      AColumn := cxGrid1DBBandedTableView1.CreateColumn;
      AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[I].FieldName;
      AColumn.Caption := FormatDateTime('mmm', varMesesArrayB[I - 19]) + '-' +
        IntToStr(Yearof(varMesesArrayB[I - 19]));
      AColumn.Width := 80;
      AColumn.Position.BandIndex := 1;
      AColumn.PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';

      cxGrid1DBBandedTableView1.DataController.Summary.FooterSummaryItems.Add
        (AColumn, spFooter, skSum, '##.###.###,##');

    end;


    cxGrid1DBBandedTableView1.OptionsView.Footer := True;
    cxGrid1DBBandedTableView1.OptionsView.GroupFooters := gfVisibleWhenExpanded;
    cxGrid1DBBandedTableView1.OptionsView.GroupFooterMultiSummaries := True;

    cxGrid1DBBandedTableView1.DataController.DataSource := dsRecuperaCliente;


  finally
    cxGrid1DBBandedTableView1.EndUpdate;
  end;

end;

procedure TFr_RelatorioManutencaoClientes.AddColumnGrid2;
var
  AColumn: TcxGridDBBandedColumn;
  I : Integer;
  sumItem: TcxDataSummaryItem;
begin
  cxGrid2DBBandedTableView1.BeginUpdate();
  cxGrid2DBBandedTableView1.DataController.CreateAllItems;
  cxGrid2DBBandedTableView1.OptionsView.FixedBandSeparatorWidth := 2;


  try

    ABand1 := cxGrid2DBBandedTableView1.Bands.Add;
    ABand1.Index := 0;
    ABand1.HeaderAlignmentHorz := taCenter;
    ABand1.Caption := 'Informa��es de Clientes';
    ABand1.FixedKind := fkLeft;

    ABand1 := cxGrid2DBBandedTableView1.Bands.Add;
    ABand1.Index := 1;
    ABand1.HeaderAlignmentHorz := taCenter;
    ABand1.Caption := 'Billing';



    AColumn := cxGrid2DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Classifica��o';
    AColumn.DataBinding.FieldName := FDQueryResumo1.Fields[0].FieldName;
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid2DBBandedTableView1.CreateColumn;
    AColumn.Width := 150;
    AColumn.Caption := 'Acumulado';
    AColumn.DataBinding.FieldName := FDQueryResumo1.Fields[1].FieldName;
    AColumn.PropertiesClass := TcxCurrencyEditProperties;
    TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';
    AColumn.Position.BandIndex := 0;


    for I := 19 to Fim_i do
    begin

      AColumn := cxGrid2DBBandedTableView1.CreateColumn;
      AColumn.DataBinding.FieldName := FDQueryResumo1.Fields[I-17].FieldName;
      AColumn.Caption := FormatDateTime('mmm', varMesesArrayB[I - 19]) + '-' +
        IntToStr(Yearof(varMesesArrayB[I - 19]));
      AColumn.Width := 100;
      AColumn.Position.BandIndex := 1;
      AColumn.PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';


    end;


    cxGrid2DBBandedTableView1.OptionsView.Footer := True;
    cxGrid2DBBandedTableView1.OptionsView.GroupFooters := gfVisibleWhenExpanded;
    cxGrid2DBBandedTableView1.OptionsView.GroupFooterMultiSummaries := True;

    cxGrid2DBBandedTableView1.DataController.DataSource := dsResumo1;


  finally
    cxGrid2DBBandedTableView1.EndUpdate;
  end;


end;

procedure TFr_RelatorioManutencaoClientes.AddColumnGrid3;
var
  AColumn: TcxGridDBBandedColumn;
  I : Integer;
  sumItem: TcxDataSummaryItem;
begin
  cxGrid3DBBandedTableView1.BeginUpdate();
  cxGrid3DBBandedTableView1.DataController.CreateAllItems;
  cxGrid3DBBandedTableView1.OptionsView.FixedBandSeparatorWidth := 2;


  try

    ABand2 := cxGrid3DBBandedTableView1.Bands.Add;
    ABand2.Index := 0;
    ABand2.HeaderAlignmentHorz := taCenter;
    ABand2.Caption := 'Informa��es de Clientes';
    ABand2.FixedKind := fkLeft;

    ABand2 := cxGrid3DBBandedTableView1.Bands.Add;
    ABand2.Index := 1;
    ABand2.HeaderAlignmentHorz := taCenter;
    ABand2.Caption := 'Clientes Ativos';



    AColumn := cxGrid3DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := '-';
    AColumn.DataBinding.FieldName := FDQueryResumo2.Fields[13].FieldName;
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid3DBBandedTableView1.CreateColumn;
    AColumn.Width := 150;
    AColumn.Caption := 'Informa��o';
    AColumn.DataBinding.FieldName := FDQueryResumo2.Fields[8].FieldName;
    AColumn.Position.BandIndex := 0;
    for I := 19 to Fim_i do
    begin

      AColumn := cxGrid3DBBandedTableView1.CreateColumn;
      AColumn.DataBinding.FieldName := FDQueryResumo2.Fields[I].FieldName;
      AColumn.Caption := FormatDateTime('mmm', varMesesArrayB[I - 19]) + '-' +
        IntToStr(Yearof(varMesesArrayB[I - 19]));
      AColumn.Width := 100;
      AColumn.Position.BandIndex := 1;

    end;


    cxGrid3DBBandedTableView1.OptionsView.Footer := True;
    cxGrid3DBBandedTableView1.OptionsView.GroupFooters := gfVisibleWhenExpanded;
    cxGrid3DBBandedTableView1.OptionsView.GroupFooterMultiSummaries := True;

    cxGrid3DBBandedTableView1.DataController.DataSource := dsResumo2;


  finally
    cxGrid3DBBandedTableView1.EndUpdate;
  end;


end;


procedure TFr_RelatorioManutencaoClientes.AddColumnGrid4;
var
  AColumn: TcxGridDBBandedColumn;
  I : Integer;
  sumItem: TcxDataSummaryItem;
begin
  cxGrid4DBBandedTableView1.BeginUpdate();
  cxGrid4DBBandedTableView1.DataController.CreateAllItems;
  cxGrid4DBBandedTableView1.OptionsView.FixedBandSeparatorWidth := 2;


  try

    ABand3 := cxGrid4DBBandedTableView1.Bands.Add;
    ABand3.Index := 0;
    ABand3.HeaderAlignmentHorz := taCenter;
    ABand3.Caption := 'Informa��es de Clientes';
    ABand3.FixedKind := fkLeft;

    ABand3 := cxGrid4DBBandedTableView1.Bands.Add;
    ABand3.Index := 1;
    ABand3.HeaderAlignmentHorz := taCenter;
    ABand3.Caption := 'Hist�rico ABC';

    AColumn := cxGrid4DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'C�digo';
    AColumn.DataBinding.FieldName := cdsGraficoDetalhe.Fields[0].FieldName;
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid4DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Site';
    AColumn.DataBinding.FieldName := cdsGraficoDetalhe.Fields[1].FieldName;
    AColumn.Position.BandIndex := 0;

    for I := 19 to Fim_i do
    begin

      AColumn := cxGrid4DBBandedTableView1.CreateColumn;
      AColumn.DataBinding.FieldName := cdsGraficoDetalhe.Fields[I-17].FieldName;
      AColumn.Caption := FormatDateTime('mmm', varMesesArrayB[I - 19]) + '-' +
        IntToStr(Yearof(varMesesArrayB[I - 19]));
      AColumn.Width := 100;
      AColumn.Position.BandIndex := 1;

    end;


    cxGrid4DBBandedTableView1.OptionsView.Footer := True;
    cxGrid4DBBandedTableView1.OptionsView.GroupFooters := gfVisibleWhenExpanded;
    cxGrid4DBBandedTableView1.OptionsView.GroupFooterMultiSummaries := True;

    cxGrid4DBBandedTableView1.DataController.DataSource := dsGraficoDetalhe;


  finally
    cxGrid4DBBandedTableView1.EndUpdate;
  end;


end;


function TFr_RelatorioManutencaoClientes.ClientesAtivosPorPeriodo: Integer;
var
 Contador : Integer;
begin

    Contador := 0;
    FDQueryClienteAtivo.Close;
    FDQueryClienteAtivo.SQL.Clear;
    FDQueryClienteAtivo.SQL.Add('SELECT DISTINCT TSOP_ORDBILCLICOD, TSOP_ORDBILSITNOM ');
    FDQueryClienteAtivo.SQL.Add('FROM (  ');
    FDQueryClienteAtivo.SQL.Add('	SELECT ');
    FDQueryClienteAtivo.SQL.Add('		C01.TSOP_ORDBILCLICOD ');
    FDQueryClienteAtivo.SQL.Add('  ,B01.TSOP_ORDBILSITNOM  ');
    FDQueryClienteAtivo.SQL.Add('		,TSOP_ORDBILVALLIQ = CAST(SUM(ISNULL(C01.TSOP_ORDBILVALLIQ,0.00)) AS NUMERIC(15,02)) ');
    FDQueryClienteAtivo.SQL.Add('	FROM DBO.VSOP_MONTHS A01 WITH (NOLOCK)  CROSS JOIN VSOP_ClienteBySalesRepForecast B01 WITH (NOLOCK) ');
    FDQueryClienteAtivo.SQL.Add('							LEFT  JOIN VSOP_ORDERBILLINGFULL C01 WITH (NOLOCK)  ON ( B01.TSOP_ORDBILCLICOD  = C01.TSOP_ORDBILCLICOD  ');
    FDQueryClienteAtivo.SQL.Add('																	AND B01.TSOP_ORDBILCANNOM  = C01.TSOP_ORDBILCANNOM ');
    FDQueryClienteAtivo.SQL.Add('																	AND B01.TSOP_ORDBILSITNOM  = C01.TSOP_ORDBILSITNOM ');
    FDQueryClienteAtivo.SQL.Add('																	AND A01.YEARDOC            = C01.TSOP_ORDBILYEADOC ');
    FDQueryClienteAtivo.SQL.Add('																	AND A01.MONTHDOC           = C01.TSOP_ORDBILMONDOC ');
    FDQueryClienteAtivo.SQL.Add('																	AND C01.TSOP_ORDBILTIPDOC  IN (''BILLING'',''RETURN'') )  ');
    FDQueryClienteAtivo.SQL.Add('	    	      LEFT OUTER JOIN TSIS_USUARIO U ON UPPER(U.TSIS_USUNOM) = UPPER(B01.TSOP_ORDBILREPNOM) ');
    FDQueryClienteAtivo.SQL.Add('		WHERE  C01.TSOP_ORDBILDATDOC >= :MES_INI   ');
    FDQueryClienteAtivo.SQL.Add('	AND C01.TSOP_ORDBILDATDOC <= :MES_FIM  ');
    FDQueryClienteAtivo.SQL.Add('	 AND      Upper(COALESCE( B01.TSOP_ORDBILCANNOM, '''')) <> ''DM'' ');
    FDQueryClienteAtivo.SQL.Add('	 AND      COALESCE( B01.TSOP_ORDBILREPNOM, '''') <> ''ASSISTENCIA TECNICA'' ');

    FDQueryClienteAtivo.SQL.Add('    &WHERE1  ');

    FDQueryClienteAtivo.SQL.Add('	GROUP BY ');
    FDQueryClienteAtivo.SQL.Add('	   B01.TSOP_ORDBILGRUCLINOM ');
    FDQueryClienteAtivo.SQL.Add('		,C01.TSOP_ORDBILCLICOD  ');
    FDQueryClienteAtivo.SQL.Add('		,B01.TSOP_ORDBILCANNOM ');
    FDQueryClienteAtivo.SQL.Add('		,B01.TSOP_ORDBILSITNOM  ');
    FDQueryClienteAtivo.SQL.Add('		,B01.TSOP_ORDBILREPNOM ');
    FDQueryClienteAtivo.SQL.Add('		,B01.TSOP_ORDBILCLINOM  ');
    FDQueryClienteAtivo.SQL.Add('	,C01.TSOP_REPCSR  ');
    FDQueryClienteAtivo.SQL.Add('		,CONVERT(CHAR(4), C01.TSOP_ORDBILDATDOC, 100) + CONVERT(CHAR(4), C01.TSOP_ORDBILDATDOC, 120)  ');
    FDQueryClienteAtivo.SQL.Add('   ,C01.TSOP_ORDBILREG   ');
    FDQueryClienteAtivo.SQL.Add('   ,C01.TSOP_ORDBILREGEST ');
    FDQueryClienteAtivo.SQL.Add('   ,B01.TSOP_ORDBILREG ');
    FDQueryClienteAtivo.SQL.Add('   ,B01.TSOP_ORDBILREGEST  ');
    FDQueryClienteAtivo.SQL.Add('  UNION all    ');
    FDQueryClienteAtivo.SQL.Add(' 	SELECT    ');
    FDQueryClienteAtivo.SQL.Add(' 		C01.TSOP_ORDBILCLICOD  ');
    FDQueryClienteAtivo.SQL.Add('   , C01.TSOP_ORDBILSITNOM ');
    FDQueryClienteAtivo.SQL.Add('		, 0 AS TSOP_ORDBILVALLIQ  ');
    FDQueryClienteAtivo.SQL.Add('		 	FROM  VSOP_ClienteBySalesRepForecast B01 WITH (NOLOCK) ');
    FDQueryClienteAtivo.SQL.Add(' 							LEFT  JOIN VSOP_ORDERBILLINGFULL C01 WITH (NOLOCK)  ON ( B01.TSOP_ORDBILCLICOD  = C01.TSOP_ORDBILCLICOD  ');
    FDQueryClienteAtivo.SQL.Add(' 																	AND B01.TSOP_ORDBILCANNOM  = C01.TSOP_ORDBILCANNOM  ');
    FDQueryClienteAtivo.SQL.Add(' 																	AND B01.TSOP_ORDBILSITNOM  = C01.TSOP_ORDBILSITNOM   ');
    FDQueryClienteAtivo.SQL.Add(' 																	AND C01.TSOP_ORDBILTIPDOC  IN (''BILLING'',''RETURN'') )  ');
    FDQueryClienteAtivo.SQL.Add('  	LEFT OUTER JOIN TSIS_USUARIO U ON UPPER(U.TSIS_USUNOM) = UPPER(B01.TSOP_ORDBILREPNOM)  ');
    FDQueryClienteAtivo.SQL.Add('  	WHERE  1 = 1   ');
    FDQueryClienteAtivo.SQL.Add('	 AND      COALESCE( C01.TSOP_ORDBILREPNOM, '''') <> ''ASSISTENCIA TECNICA'' ');
    FDQueryClienteAtivo.SQL.Add('     AND  NOT EXISTS (SELECT TSOP_ORDBILCLICOD  FROM VSOP_ORDERBILLINGFULL D01 WITH(NOLOCK)  ');
    FDQueryClienteAtivo.SQL.Add(' 	                                         WHERE 	 D01.TSOP_ORDBILTIPDOC  IN (''BILLING'',''RETURN'')   ');
    FDQueryClienteAtivo.SQL.Add(' 													AND	D01.TSOP_ORDBILDATDOC >= :MES_INI   ');
    FDQueryClienteAtivo.SQL.Add(' 	                        AND D01.TSOP_ORDBILDATDOC <= :MES_FIM  ');
    FDQueryClienteAtivo.SQL.Add(' 	                        AND D01.TSOP_ORDBILCLICOD = C01.TSOP_ORDBILCLICOD  ');
    FDQueryClienteAtivo.SQL.Add(' 									  			AND D01.TSOP_ORDBILCANNOM = C01.TSOP_ORDBILCANNOM   ');
    FDQueryClienteAtivo.SQL.Add('                           AND D01.TSOP_ORDBILSITNOM = C01.TSOP_ORDBILSITNOM )   ');
    FDQueryClienteAtivo.SQL.Add(' 	 AND      Upper(COALESCE( B01.TSOP_ORDBILCANNOM, '''')) <> ''DM''  &WHERE1 ) A   ');
    FDQueryClienteAtivo.SQL.Add('	WHERE A.TSOP_ORDBILVALLIQ > 0  ');


    FDQueryClienteAtivo.Params.ParamByName('MES_INI').AsDateTime := IncMonth(IncMonth(System.DateUtils.StartOfTheMonth(NovaData)), -(13));
    FDQueryClienteAtivo.Params.ParamByName('MES_FIM').AsDateTime := IncMonth(IncMonth(System.DateUtils.EndOfTheMonth(NovaData), -12), 11);

    if cxCanal.Text <> '' then
      FDQueryClienteAtivo.MacroByName('WHERE1').AsRaw := ' AND B01.TSOP_ORDBILCANNOM = '
        + QuotedStr(cxCanal.Text);

    //FDQueryClienteAtivo.SQL.SaveToFile('c:\brady\clienteativo.sql');
    FDQueryClienteAtivo.Open;
    FDQueryClienteAtivo.First;

    FDQueryAux2.Close;
    FDQueryAux2.SQL.Clear;
    FDQueryAux2.SQL.Add('Delete from TSOP_CLIENTE_ATIVO Where DATAFINAL = :DATAFINAL' );
    FDQueryAux2.Params.ParamByName('DATAFINAL').AsDate := IncMonth(IncMonth(System.DateUtils.EndOfTheMonth(NovaData), -12), 11);
    FDQueryAux2.ExecSQL;

    while not FDQueryClienteAtivo.Eof do
    begin

         FDQueryAux2.Close;
         FDQueryAux2.SQL.Clear;
         FDQueryAux2.SQL.Add('Insert into TSOP_CLIENTE_ATIVO (DATAINICIAL, DATAFINAL,  TSOP_ORDBILCLICOD, TSOP_ORDBILSITNOM) values (:DATAINICIAL, :DATAFINAL, :TSOP_ORDBILCLICOD, :TSOP_ORDBILSITNOM)');
         FDQueryAux2.Params.ParamByName('DATAINICIAL').AsDate :=  IncMonth(IncMonth(System.DateUtils.StartOfTheMonth(NovaData), +1), -(13));
         FDQueryAux2.Params.ParamByName('DATAFINAL').AsDate :=  IncMonth(IncMonth(System.DateUtils.EndOfTheMonth(NovaData), -12), 11);
         FDQueryAux2.Params.ParamByName('TSOP_ORDBILCLICOD').AsString :=  FDQueryClienteAtivo.FieldByName('TSOP_ORDBILCLICOD').AsString;
         FDQueryAux2.Params.ParamByName('TSOP_ORDBILSITNOM').AsString :=  FDQueryClienteAtivo.FieldByName('TSOP_ORDBILSITNOM').AsString;
         FDQueryAux2.ExecSQL;

         inc(Contador);

       FDQueryClienteAtivo.Next;
    end;
    Result := Contador;
    FDQueryClienteAtivo.Close;
end;

procedure TFr_RelatorioManutencaoClientes.CopiaDataSetParaBanco;
var
 i : Integer;
begin


  try
    FDQueryBase.Close;
    FDQueryBase.SQL.Clear;
    FDQueryBase.sql.Add('Select * From dbo.TSOP_RECUPERACLIENTE_' +  NomedoUsuario);
    FDQueryBase.Open;

  except
   on E: Exception do
      begin

        Mensagem(  E.Message );


      end;

  end;

  FDQueryRecuperaClienteMem.First;
  while not FDQueryRecuperaClienteMem.Eof do
  begin
    FDQueryBase.Append;
    Try
      FDQueryBase.Fields[0].Value  := FDQueryRecuperaClienteMem.Fields[0].Value;
      FDQueryBase.Fields[1].Value  := FDQueryRecuperaClienteMem.Fields[1].Value;
      FDQueryBase.Fields[2].Value  := FDQueryRecuperaClienteMem.Fields[2].Value;
      FDQueryBase.Fields[3].Value  := FDQueryRecuperaClienteMem.Fields[3].Value;
      FDQueryBase.Fields[4].Value  := FDQueryRecuperaClienteMem.Fields[4].Value;
      FDQueryBase.Fields[5].Value  := FDQueryRecuperaClienteMem.Fields[5].Value;
      FDQueryBase.Fields[6].Value  := FDQueryRecuperaClienteMem.Fields[6].Value;
      FDQueryBase.Fields[7].Value  := FDQueryRecuperaClienteMem.Fields[7].Value;
      FDQueryBase.Fields[8].Value  := FDQueryRecuperaClienteMem.Fields[8].Value;
      FDQueryBase.Fields[9].Value  := FDQueryRecuperaClienteMem.Fields[9].Value;
      FDQueryBase.Fields[10].Value := FDQueryRecuperaClienteMem.Fields[10].Value;
      FDQueryBase.Fields[11].Value := FDQueryRecuperaClienteMem.Fields[11].Value;
      FDQueryBase.Fields[12].Value := FDQueryRecuperaClienteMem.Fields[12].Value;
      FDQueryBase.Fields[13].AsFloat := RoundTo(FDQueryRecuperaClienteMem.Fields[13].AsFloat,-2);
      FDQueryBase.Fields[14].Value := FDQueryRecuperaClienteMem.Fields[14].Value;
      FDQueryBase.Fields[15].AsFloat := RoundTo(FDQueryRecuperaClienteMem.Fields[15].AsFloat,-2);
      FDQueryBase.Fields[16].AsFloat := RoundTo(FDQueryRecuperaClienteMem.Fields[16].AsFloat,-2);
      FDQueryBase.Fields[17].Value := FDQueryRecuperaClienteMem.Fields[17].Value;
      FDQueryBase.Fields[18].AsFloat := RoundTo(FDQueryRecuperaClienteMem.Fields[18].AsFloat,-2);

    except

      on E: Exception do
      begin

        Mensagem( 'Post: ' + E.Message );
        FDQueryBase.Cancel;

      end;

    end;

    for I := 19 to Fim_i do
      begin
         FDQueryBase.Fields[i].Value := FDQueryRecuperaClienteMem.Fields[i].Value;
      end;

    try
      FDQueryBase.Post;
    except

      on E: Exception do
      begin

        Mensagem( 'Post: ' + E.Message );
        FDQueryBase.Cancel;

      end;

    end;

    FDQueryRecuperaClienteMem.Next;
  end;

  FDQueryBase.ApplyUpdates(0);


end;

procedure TFr_RelatorioManutencaoClientes.CopiaDataSetParaMemoria;
var
 i : Integer;
begin
  CreateDataSet;

  FDQueryRecuperaClienteMem.Open;
 // FDQueryRecuperaClienteMem.Addindex('IndAcumuladoDesc', 'Acumulado', [IxDescending]);
 // FDQueryRecuperaClienteMem.IndexName := 'IndAcumuladoDesc';


  FDQueryBase.First;

  while not FDQueryBase.Eof do
  begin

    FDQueryRecuperaClienteMem.Append;
    FDQueryRecuperaClienteMem.Fields[0].Value := FDQueryBase.Fields[0].Value;
    FDQueryRecuperaClienteMem.Fields[1].Value := FDQueryBase.Fields[1].Value;
    FDQueryRecuperaClienteMem.Fields[2].Value := FDQueryBase.Fields[2].Value;
    FDQueryRecuperaClienteMem.Fields[3].Value := FDQueryBase.Fields[3].Value;
    FDQueryRecuperaClienteMem.Fields[4].Value := FDQueryBase.Fields[4].Value;
    FDQueryRecuperaClienteMem.Fields[5].Value := FDQueryBase.Fields[5].Value;
    FDQueryRecuperaClienteMem.Fields[6].Value := FDQueryBase.Fields[6].Value;
    FDQueryRecuperaClienteMem.Fields[7].Value := FDQueryBase.Fields[7].Value;
    FDQueryRecuperaClienteMem.Fields[8].Value := FDQueryBase.Fields[8].Value;
    FDQueryRecuperaClienteMem.Fields[9].Value := FDQueryBase.Fields[9].Value;
    FDQueryRecuperaClienteMem.Fields[10].Value := FDQueryBase.Fields[10].Value;
    FDQueryRecuperaClienteMem.Fields[11].Value := FDQueryBase.Fields[11].Value;
    FDQueryRecuperaClienteMem.Fields[12].Value := FDQueryBase.Fields[12].Value;
    FDQueryRecuperaClienteMem.Fields[13].Value := FDQueryBase.Fields[13].Value;
    FDQueryRecuperaClienteMem.Fields[14].Value := FDQueryBase.Fields[14].Value;
    FDQueryRecuperaClienteMem.Fields[15].Value := FDQueryBase.Fields[15].Value;
    FDQueryRecuperaClienteMem.Fields[16].Value := FDQueryBase.Fields[16].Value;
    FDQueryRecuperaClienteMem.Fields[17].Value := FDQueryBase.Fields[17].Value;
    FDQueryRecuperaClienteMem.Fields[18].Value := FDQueryBase.Fields[18].Value;

    for I := 19 to Fim_i do
    begin
       FDQueryRecuperaClienteMem.Fields[i].Value := FDQueryBase.Fields[i].Value;
    end;

    try

     FDQueryRecuperaClienteMem.Post;

    except
     on E : Exception do
          begin
            MessageDlg( E.Message, mtError, [ mbOk ], 0 );
          end;
    end;

    FDQueryBase.Next;
  end;

  if FileExists(MyDocumentsPath + '\' + DataFileBase) then
    DeleteFile(MyDocumentsPath + '\' + DataFileBase);

  FDQueryRecuperaClienteMem.SaveToFile(MyDocumentsPath + '\' + DataFileBase);



end;

procedure TFr_RelatorioManutencaoClientes.CreateDataSet;
var
  I: Integer;
  Mes: string;
begin

  FDQueryRecuperaClienteMem.FieldDefs.Clear;
  cdsGrafico.FieldDefs.Clear;
  cdsGraficoDetalhe.FieldDefs.Clear;

  if DirectoryExists(MyDocumentsPath) then
    ForceDirectories(MyDocumentsPath);

  FDQueryRecuperaClienteMem.Close;
  FDQueryRecuperaClienteMem.FileName := MyDocumentsPath + '\' + DataFileBase;

  if FileExists(FDQueryRecuperaClienteMem.FileName) then
    DeleteFile(FDQueryRecuperaClienteMem.FileName);

  with FDQueryRecuperaClienteMem.FieldDefs do
  begin
    Clear;
     Add('TSOP_ORDBILREPNOM', ftString, 255, False);
     Add('TSOP_ORDBILGRUCLINOM', ftString, 255, False);
     Add('TSOP_ORDBILCLICOD', ftString, 255, False);
     Add('TSOP_ORDBILCLINOM', ftString, 255, False);
     Add('TSOP_ORDBILSITNOM', ftString, 255, False);
     Add('TSOP_ORDBILCANNOM', ftString, 255, False);
     Add('TSOP_ORDBILREG', ftString, 255, False);
     Add('TSOP_ORDBILREGEST', ftString, 2, False);
     Add('TSOP_REPCSR', ftString, 255, False);
     Add('STATUS', ftString, 7, False);
     Add('HITS', ftString, 2, False);
     Add('RECENCIA', ftInteger, 0, False);
     Add('CLIENTENOVO', ftString, 2, False);
     Add('MEDIA_12',  ftCurrency, 0, False);
     Add('CLASSIFICACAO_12',ftString, 1, False);
     Add('ACUMULADO_12',  ftCurrency, 0, False);
     Add('MEDIA', ftCurrency, 0, False);
     Add('CLASSIFICACAO', ftString, 1, False);
     Add('ACUMULADO', ftCurrency, 0, False);


     for I := Low(varMesesArrayB) to High(varMesesArrayB) do
        begin
          Mes := BuscaMes(varMesesArrayB[I], False, 'B', False, False, False, False);
          Mes := Copy(Mes, 1, Length(Mes) - 1);
          Add(Mes, ftCurrency, 0, False);
        end;


    FDQueryRecuperaClienteMem.CreateDataSet;
    FDQueryRecuperaClienteMem.LogChanges := False;
  end;


  cdsGrafico.Close;
  cdsGrafico.FileName := MyDocumentsPath + '\' + DataFileMestre;
  if FileExists(cdsGrafico.FileName) then
    DeleteFile(cdsGrafico.FileName);

  with cdsGrafico.FieldDefs do
  begin
    Clear;
    Add('Curva', ftString, 1);
    for I := Low(varMesesArrayB) to High(varMesesArrayB) do
    begin
      Mes := BuscaMes(varMesesArrayB[I], False, 'B', False, False, False, False);
      Mes := Copy(Mes, 1, Length(Mes) - 1);
      Add(Mes, ftInteger, 0, False);
    end;
    cdsGrafico.CreateDataSet;
    cdsGrafico.LogChanges := False;
  end;

  cdsGrafico.Open;
  cdsGrafico.IndexFieldNames := 'Curva';

  cdsGraficoDetalhe.Close;
  cdsGraficoDetalhe.FileName := MyDocumentsPath + '\' + DataFileDetalhe;
  if FileExists(cdsGraficoDetalhe.FileName) then
    DeleteFile(cdsGraficoDetalhe.FileName);

  with cdsGraficoDetalhe.FieldDefs do
  begin
    Clear;
    Add('TSOP_ORDBILCLICOD', ftString, 10);
    Add('TSOP_ORDBILSITNOM', ftString, 10);

    for I := Low(varMesesArrayB) to High(varMesesArrayB) do
    begin
      Mes := BuscaMes(varMesesArrayB[I], False, 'B', False, False, False, False);
      Mes := Copy(Mes, 1, Length(Mes) - 1);
      Add(Mes, ftString, 1, False);
    end;
    cdsGraficoDetalhe.CreateDataSet;
    cdsGraficoDetalhe.LogChanges := False;
  end;

  //FDQueryRecuperaClienteMem.Close;
  //cdsGrafico.Close;
  //cdsGraficoDetalhe.Close;



  cdsGraficoDetalhe.Open;
  cdsGraficoDetalhe.IndexFieldNames := 'TSOP_ORDBILCLICOD;TSOP_ORDBILSITNOM';


  //FDQueryRecuperaClienteMem.IndexFieldNames := 'TSOP_ORDBILCLICOD;TSOP_ORDBILSITNOM';  //voltei

 // cdsGrafico.DisableControls;
  cdsGraficoDetalhe.DisableControls;
  FDQueryRecuperaClienteMem.DisableControls;

end;


procedure TFr_RelatorioManutencaoClientes.CriarRegistroQtdeVendas;
begin

//  NovaData := IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -1);
  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
  FDQueryAux.SQL.Add('Delete From TSOP_RECUPERACLIENTE_QTDEVENDAS');
  FDQueryAux.SQL.Add(' Where Data = :Data  ');
  FDQueryAux.Params.ParamByName('Data').AsDate           := IncMonth(IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -12), 11);
  FDQueryAux.ExecSQL;


  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
  FDQueryAux.SQL.Add('Select Data From TSOP_RECUPERACLIENTE_QTDEVENDAS');
  FDQueryAux.SQL.Add(' Where Data = :Data  ');
  FDQueryAux.Params.ParamByName('Data').AsDate           :=  IncMonth(IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -12), 11);
  FDQueryAux.Open;
  if  FDQueryAux.IsEmpty then
  begin
     Try
     FDQueryAux.Close;
     FDQueryAux.SQL.Clear;
     FDQueryAux.SQL.Add('Insert into TSOP_RECUPERACLIENTE_QTDEVENDAS (Data,  QUANTIDADE) Values (:Data,  :QUANTIDADE)');
     FDQueryAux.Params.ParamByName('Data').AsDate           := IncMonth(IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -12), 11);;;
     FDQueryAux.Params.ParamByName('QUANTIDADE').AsInteger  := ClientesAtivosPorPeriodo;
     FDQueryAux.ExecSQL;
    except
      on E: Exception do
        begin
           Mensagem( 'Insert TSOP_RECUPERACLIENTE_QTDEVENDAS ' + E.Message );
        end;
    End;
  end;
end;

function TFr_RelatorioManutencaoClientes.BuscaMes(Data: TDateTime;
  bLabel: Boolean; Alias: String; SomarLinha: Boolean; VisaoDinamica : Boolean; ComAS: Boolean; SUM : Boolean; Language : String = 'BR'): String;
var
  Ano, Mes, Dia: Word;
  MesFiscal, MesAbrev: String;
  strFormatDate: string;
begin
  DecodeDate(Data, Ano, Mes, Dia);
  MesAbrev := FormatDateTime('mmm', Data);
  if Language = 'BR' then
  begin
    MesAbrev := StringReplace(MesAbrev, 'dez', 'Dez',    [rfReplaceAll, rfIgnoreCase]);
    MesAbrev := StringReplace(MesAbrev, 'set', 'Set',    [rfReplaceAll, rfIgnoreCase]);
    MesAbrev := StringReplace(MesAbrev, 'abr', 'Abr',    [rfReplaceAll, rfIgnoreCase]);
    MesAbrev := StringReplace(MesAbrev, 'ago', 'Ago',    [rfReplaceAll, rfIgnoreCase]);
    MesAbrev := StringReplace(MesAbrev, 'mai', 'Mai',    [rfReplaceAll, rfIgnoreCase]);
    MesAbrev := StringReplace(MesAbrev, 'out', 'Out',    [rfReplaceAll, rfIgnoreCase]);
    MesAbrev := StringReplace(MesAbrev, 'fev', 'Fev',    [rfReplaceAll, rfIgnoreCase]);
  end
  else
  begin
    MesAbrev := StringReplace(MesAbrev, 'dez', 'Dec',    [rfReplaceAll, rfIgnoreCase]);
    MesAbrev := StringReplace(MesAbrev, 'set', 'Sep',    [rfReplaceAll, rfIgnoreCase]);
    MesAbrev := StringReplace(MesAbrev, 'abr', 'Apr',    [rfReplaceAll, rfIgnoreCase]);
    MesAbrev := StringReplace(MesAbrev, 'ago', 'Aug',    [rfReplaceAll, rfIgnoreCase]);
    MesAbrev := StringReplace(MesAbrev, 'mai', 'May',    [rfReplaceAll, rfIgnoreCase]);
    MesAbrev := StringReplace(MesAbrev, 'out', 'Oct',    [rfReplaceAll, rfIgnoreCase]);
    MesAbrev := StringReplace(MesAbrev, 'fev', 'Feb',    [rfReplaceAll, rfIgnoreCase]);
  end;

  MesAbrev := StringReplace(MesAbrev, 'nov', 'Nov',    [rfReplaceAll, rfIgnoreCase]);
  MesAbrev := StringReplace(MesAbrev, 'jan', 'Jan',    [rfReplaceAll, rfIgnoreCase]);
  MesAbrev := StringReplace(MesAbrev, 'mar', 'Mar',    [rfReplaceAll, rfIgnoreCase]);
  MesAbrev := StringReplace(MesAbrev, 'jun', 'Jun',    [rfReplaceAll, rfIgnoreCase]);
  MesAbrev := StringReplace(MesAbrev, 'jul', 'Jul',    [rfReplaceAll, rfIgnoreCase]);

  strFormatDate :=  MesAbrev + ' ' + IntToStr(Ano) ;

  if VisaoDinamica then
  begin
      MesFiscal := ' WHEN ' + QuotedStr(strFormatDate) + ' Then CAST(' + QuotedStr(IntToStr(Ano) + '/' + IntToStr(Mes) + '/01' ) + ' AS Date) ';
      Result := MesFiscal;
      exit;
  end;

  strFormatDate := '[' + MesAbrev + ' ' + IntToStr(Ano) + ']';

  if bLabel then
  begin
    Case Mes Of
      1:
        MesFiscal := strFormatDate + ','; // + ' AS JANEIRO,' ;
      2:
        MesFiscal := strFormatDate + ','; // + ' AS FEVEREIRO,' ;
      3:
        MesFiscal := strFormatDate + ','; // + ' AS MAR�O,' ;
      4:
        MesFiscal := strFormatDate + ','; // + ' AS ABRIL,' ;
      5:
        MesFiscal := strFormatDate + ','; // + ' AS MAIO,' ;
      6:
        MesFiscal := strFormatDate + ','; // + ' AS JUNHO,' ;
      7:
        MesFiscal := strFormatDate + ','; // + ' AS JULHO,' ;
      8:
        MesFiscal := strFormatDate + ','; // + ' AS AGOSTO,' ;
      9:
        MesFiscal := strFormatDate + ','; // + ' AS SETEMBRO,' ;
      10:
        MesFiscal := strFormatDate + ','; // + ' AS OUTUBRO,' ;
      11:
        MesFiscal := strFormatDate + ','; // + ' AS NOVEMBRO,' ;
      12:
        MesFiscal := strFormatDate + ','; // + ' AS DEZEMBRO,' ;
    End;
  end
  else
  begin
    Case Mes Of
      1:
        MesFiscal := strFormatDate + ',';
      2:
        MesFiscal := strFormatDate + ',';
      3:
        MesFiscal := strFormatDate + ',';
      4:
        MesFiscal := strFormatDate + ',';
      5:
        MesFiscal := strFormatDate + ',';
      6:
        MesFiscal := strFormatDate + ',';
      7:
        MesFiscal := strFormatDate + ',';
      8:
        MesFiscal := strFormatDate + ',';
      9:
        MesFiscal := strFormatDate + ',';
      10:
        MesFiscal := strFormatDate + ',';
      11:
        MesFiscal := strFormatDate + ',';
      12:
        MesFiscal := strFormatDate + ',';
    End;
  end;

  // if (Alias <> '') then
  // MesFiscal := Alias + '.' + MesFiscal;
  if SomarLinha then
  begin
    MesFiscal := Copy(MesFiscal, 1, Length(MesFiscal) - 1);

    Case Mes Of
      1:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      2:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      3:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      4:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      5:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      6:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      7:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      8:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      9:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      10:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      11:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      12:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
    End;
  end
  else
  begin
    if (Alias <> '') and (bLabel) then
    begin
      MesFiscal := Copy(MesFiscal, 1, Length(MesFiscal) - 1);

      if ComAS then
      begin
        Case Mes Of
          1:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Jan_' +
              IntToStr(Ano) + ',';
          2:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Fev_' +
              IntToStr(Ano) + ',';
          3:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Mar_' +
              IntToStr(Ano) + ',';
          4:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Abr_' +
              IntToStr(Ano) + ',';
          5:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Mai_' +
              IntToStr(Ano) + ',';
          6:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Jun_' +
              IntToStr(Ano) + ',';
          7:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Jul_' +
              IntToStr(Ano) + ',';
          8:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Ago_' +
              IntToStr(Ano) + ',';
          9:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Set_' +
              IntToStr(Ano) + ',';
          10:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Out_' +
              IntToStr(Ano) + ',';
          11:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Nov_' +
              IntToStr(Ano) + ',';
          12:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Dez_' +
              IntToStr(Ano) + ',';
        End;
      end
      else
      begin
        Case Mes Of
          1:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          2:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          3:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          4:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          5:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          6:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          7:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          8:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          9:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          10:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          11:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          12:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
        End;
      end;

    end;
  end;

  if SUM then
  begin
       Case Mes Of
      1:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS JANEIRO,' ;
      2:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS FEVEREIRO,' ;
      3:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS MAR�O,' ;
      4:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS ABRIL,' ;
      5:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS MAIO,' ;
      6:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS JUNHO,' ;
      7:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS JULHO,' ;
      8:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS AGOSTO,' ;
      9:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS SETEMBRO,' ;
      10:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS OUTUBRO,' ;
      11:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS NOVEMBRO,' ;
      12:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS DEZEMBRO,' ;
    End;

  end;



  Result := MesFiscal;

end;

procedure TFr_RelatorioManutencaoClientes.ButExcelClick(Sender: TObject);
begin

 if Page.ActivePageIndex = 0 then
  begin

      if cxButtonEditPath.Text = EmptyStr then
        raise Exception.Create('Informe o arquivo primeiro.');


      if FDQueryRecuperaCliente.IsEmpty then
        raise Exception.Create('N�o h� dados para serem exportados ao Excel');

      Screen.Cursor := crHourGlass;
      Try
          Mensagem('Aguarde, Gerando a Planilha...');
          Imprimir2;
      Finally
          Mensagem( EmptyStr );
          Screen.Cursor := crDefault;
      End;
  end;
end;

procedure   TFr_RelatorioManutencaoClientes.Imprimir2;
var
  Planilha: OleVariant;
  I, X, J, ContaCliente : Integer;
  varCor1,varCor2: TColor;
begin
  Planilha:= CreateOleObject('Excel.Application');
  Planilha.caption := 'Delphi para excel';
  Planilha.visible:=false;
  Planilha.workbooks.add(1);

  Planilha.cells[1,1]:='CSR';
  Planilha.cells[1,2]:='Vendedor';
  Planilha.cells[1,3]:='Grupo';
  Planilha.cells[1,4]:='C�digo';
  Planilha.cells[1,5]:='Cliente';
  Planilha.cells[1,6]:='Site';
  Planilha.cells[1,7]:='Canal';
  Planilha.cells[1,8]:='Regi�o';

  Planilha.cells[1,9]:='UF';
  Planilha.cells[1,10]:='Status';
  Planilha.cells[1,11]:='Hits';
  Planilha.cells[1,12]:='Rec�ncia';
  Planilha.cells[1,13]:='Clientes Novos';
  Planilha.cells[1,14]:='M�dia_12';
  Planilha.cells[1,15]:='Classifica��o_12';
  Planilha.cells[1,16]:='Acumulado_12';

  Planilha.cells[1,17]:='M�dia';
  Planilha.cells[1,18]:='Classifica��o';
  Planilha.cells[1,19]:='Acumulado';

  for I := 19 to Fim_i do
  begin
      Planilha.cells[1,I+1] := FormatDateTime('mmm', varMesesArrayB[I - 19]) + '-' + IntToStr(Yearof(varMesesArrayB[I - 19]));
  end;

  FDQueryRecuperaCliente.DisableControls;
  FDQueryRecuperaCliente.First;

  X := 2;
  ContaCliente := 0;
  while not FDQueryRecuperaCliente.eof do
  begin
       Planilha.cells[X, 1] :=  FDQueryRecuperaCliente.Fields[8].AsString; //CSR
       Planilha.cells[X, 2] :=  FDQueryRecuperaCliente.Fields[0].AsString;  //Vendedor
       Planilha.cells[X, 3] :=  FDQueryRecuperaCliente.Fields[1].AsString; //Grupo

       Planilha.cells[X, 4] :=  FDQueryRecuperaCliente.Fields[2].AsString;  //Codigo
       Planilha.cells[X, 5] :=  FDQueryRecuperaCliente.Fields[3].AsString;  //Cliente
       Planilha.cells[X, 6] :=  FDQueryRecuperaCliente.Fields[4].AsString;   //Site
       Planilha.cells[X, 7] :=  FDQueryRecuperaCliente.Fields[5].AsString; //Canal
       Planilha.cells[X, 8] :=  FDQueryRecuperaCliente.Fields[6].AsString;  //Regi�o
       Planilha.cells[X, 9] :=  FDQueryRecuperaCliente.Fields[7].AsString; //Estado
       Planilha.cells[X,10] :=  FDQueryRecuperaCliente.Fields[9].AsString;  //Status
       Planilha.cells[X,11] :=  FDQueryRecuperaCliente.Fields[10].AsString; //Hits
       Planilha.cells[X,12] :=  FDQueryRecuperaCliente.Fields[11].AsString; //Recencia
       Planilha.cells[X,13] :=  FDQueryRecuperaCliente.Fields[12].AsInteger;
       ContaCliente := ContaCliente +  FDQueryRecuperaCliente.Fields[12].AsInteger;
       Planilha.cells[X,14] :=  FDQueryRecuperaCliente.Fields[13].AsFloat; //Media
       Planilha.cells[X,15] :=  FDQueryRecuperaCliente.Fields[14].AsString; //Classificacao
       Planilha.cells[X,16] :=  FDQueryRecuperaCliente.Fields[15].AsFloat;   //Acumulado
       Planilha.cells[X,17] :=  FDQueryRecuperaCliente.Fields[16].AsFloat; //Media
       Planilha.cells[X,18] :=  FDQueryRecuperaCliente.Fields[17].AsString; //Classificacao
       Planilha.cells[X,19] :=  FDQueryRecuperaCliente.Fields[18].AsFloat;   //Acumulado

       for J := 19 to Fim_i do
       begin
            // Style.Brush.BackgroundColor := varCor1;
            // Style.DataFormat.FormatCode := '#,##0.00';
             Planilha.cells[X,J+1] := FDQueryRecuperaCliente.Fields[J].AsFloat;

       end;

       if Odd(X) then
        varCor1 := RGB(255,255,225)
       else
        varCor1 := RGB(216,234,204);

       Inc(X);


       FDQueryRecuperaCliente.Next;
  end;

  Planilha.cells[X,13] :=  ContaCliente;
  FDQueryResumo3.First;

  while not FDQueryResumo3.Eof do
  begin

     for J := 18 to Fim_i do
     begin
      Planilha.cells[X,J+1] :=  FDQueryResumo3.Fields[J-18].AsFloat;
     end;

     Inc(X);

    FDQueryResumo3.next;
  end;

  Inc(X);
  FDQueryResumo1.First;
  while not FDQueryResumo1.Eof do
  begin

     Planilha.cells[X,18] :=  FDQueryResumo1.Fields[0].AsString;

     for J := 18 to Fim_i do
     begin
       Planilha.cells[X,J+1]  :=  FDQueryResumo1.Fields[J-17].AsFloat;
     end;

     Inc(X);

    FDQueryResumo1.next;
  end;

  Inc(X);
  FDQueryResumo2.First;
  while not FDQueryResumo2.Eof do
  begin
     Planilha.cells[X,18] :=  FDQueryResumo2.Fields[8].AsString;

     for J := 19 to Fim_i do
     begin
      Planilha.cells[X,J+1] :=  FDQueryResumo2.Fields[J].AsInteger;
     end;

     Inc(X);

    FDQueryResumo2.next;
  end;

  FDQueryRecuperaCliente.EnableControls;

  Planilha.columns.autofit;
  Planilha.Visible:=True;
  Planilha.workbooks[1].SaveAs( cxButtonEditPath.Text , xlWorkbookDefault);
  Planilha:= Unassigned;
  FDQueryRecuperaCliente.First;

end;

 {
procedure TFr_RelatorioManutencaoClientes.Imprimir;
var
  I, X, J, Y: Integer;
  varCor1,varCor2: TColor;
  CoontaCliente : Integer;
  varSubtotal: array[16..39] of string;
begin

   Screen.Cursor := crHourGlass;
   DeleteFile(PWideChar(MyDocumentsPath+'\BaseClientes.xlsx'));
   CopyFile( PWideChar('\\ghos2024\Brady\BaseClientes.xlsx'), PWideChar(MyDocumentsPath+'\BaseClientes.xlsx'), True );

   Try
       Mensagem( 'Criando Planilha...' );
       dxSpreadSheet := TdxSpreadSheet.Create(nil);
       try
           Mensagem( 'Exportando Base Cliente...' );
           dxSpreadSheet.LoadFromFile(MyDocumentsPath+'\BaseClientes.xlsx'  );
           dxSpreadSheet.BeginUpdate;

           for I := 0 to 18 do
           begin

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,I) do;

           end;

           varCor1 := RGB(216,234,204);
           varCor2 := RGB(255,255,225);
            {
           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(0,1) do
           begin
                Style.Font.Style := Style.Font.Style + [fsBold];
                Style.Font.Name := 'Tahoma';
                Style.Font.Size := 14;
                AsString := 'Base Clientes - Per�odo: ' + cbPeriodo.Text;
           end;


           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,1) do
           begin
                Style.Font.Style := Style.Font.Style + [fsBold];
                Style.Font.Name := 'Tahoma';
                Style.Font.Size := 12;
                AsString := 'Data: ' + DateToStr(date);
           end;



           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,0) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'CSR';
           end;

           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,1) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'Vendedor';
           end;

           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,2) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'Grupo';
           end;

           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,3) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'C�digo';
           end;

           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,4) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'Cliente';
           end;

           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,5) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'Site';
           end;
           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,6) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'Canal';
           end;
           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,7) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'Regi�o';
           end;
           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,8) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'UF';
           end;
           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,9) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'Status';
           end;
           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,10) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'Hits';
           end;
           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,11) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'Rec�ncia';
           end;
           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,12) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'Clientes Novos';
           end;
           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,13) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'M�dia_12';
           end;
           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,14) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'Classifica��o_12';
           end;
           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,15) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'Acumulado_12';
           end;
           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,16) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'M�dia';
           end;
           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,17) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'Classifica��o';
           end;
           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,18) do
           begin
               Style.Brush.BackgroundColor := varCor1;
               AsVariant := 'Acumulado';
           end;

           for I := 19 to Fim_i do
           begin

              with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,I) do
              begin
                Style.Font.Style := Style.Font.Style + [fsBold];
                Style.Brush.BackgroundColor := RGB(219,219,219);
                Style.Font.Name := 'Tahoma';
                Style.Font.Size := 8;
                Style.Font.Color := RGB(0,0,0);
                AsString := FormatDateTime('mmm', varMesesArrayB[I - 19]) + '-' + IntToStr(Yearof(varMesesArrayB[I - 19]));

              end;

           end;

           FDQueryRecuperaCliente.First;


           X := 2;
           CoontaCliente := 0;
           while not FDQueryRecuperaCliente.eof do
           begin

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryRecuperaCliente.Fields[8].AsString; //CSR
               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryRecuperaCliente.Fields[0].AsString;  //Vendedor
               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,2) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant :=  FDQueryRecuperaCliente.Fields[1].AsString; //Grupo
               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,3) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryRecuperaCliente.Fields[2].AsString;  //Codigo

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,4) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant :=  FDQueryRecuperaCliente.Fields[3].AsString;  //Cliente

               end;


               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,5) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant :=  FDQueryRecuperaCliente.Fields[4].AsString;   //Site

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,6) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant :=  FDQueryRecuperaCliente.Fields[5].AsString; //Canal

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,7) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryRecuperaCliente.Fields[6].AsString;  //Regi�o

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,8) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant :=  FDQueryRecuperaCliente.Fields[7].AsString; //Estado

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,9) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant :=  FDQueryRecuperaCliente.Fields[9].AsString;  //Status

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,10) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryRecuperaCliente.Fields[10].AsString; //Hits

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,11) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryRecuperaCliente.Fields[11].AsString; //Recencia

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,12) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryRecuperaCliente.Fields[12].AsInteger; //Novo Cliente
                   CoontaCliente := CoontaCliente +  FDQueryRecuperaCliente.Fields[12].AsInteger;
               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,13) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   Style.DataFormat.FormatCode := '#,##0.00';
                   AsVariant := FDQueryRecuperaCliente.Fields[13].AsFloat; //Media

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,14) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryRecuperaCliente.Fields[14].AsString; //Classificacao

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,15) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   Style.DataFormat.FormatCode := '#,##0.00';
                   AsVariant := FDQueryRecuperaCliente.Fields[15].AsFloat;   //Acumulado

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,16) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   Style.DataFormat.FormatCode := '#,##0.00';
                   AsVariant := FDQueryRecuperaCliente.Fields[16].AsFloat; //Media

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,17) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryRecuperaCliente.Fields[17].AsString; //Classificacao

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,18) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   Style.DataFormat.FormatCode := '#,##0.00';
                   AsVariant := FDQueryRecuperaCliente.Fields[18].AsFloat;   //Acumulado

               end;


               for J := 19 to Fim_i do
               begin
                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,J) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     Style.DataFormat.FormatCode := '#,##0.00';
                     AsVariant := FDQueryRecuperaCliente.Fields[J].AsFloat;
                 end;

               end;

               if Odd(X) then
                varCor1 := RGB(255,255,225)
               else
                varCor1 := RGB(216,234,204);

               Inc(X);


               FDQueryRecuperaCliente.Next;
           end;




           {
           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,12) do
             begin
                Style.Font.Style := Style.Font.Style + [fsBold];
                Style.Brush.BackgroundColor := varCor1;
                Style.DataFormat.FormatCode := '####';
                AsVariant := CoontaCliente;
             end;

           FDQueryResumo3.First;


           while not FDQueryResumo3.Eof do
           begin


               for J := 18 to Fim_i do
               begin
                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,J) do
                 begin
                     Style.Font.Style := Style.Font.Style + [fsBold];
                     Style.Brush.BackgroundColor := varCor1;
                     Style.DataFormat.FormatCode := '#,##0.00';
                     AsVariant := FDQueryResumo3.Fields[J-18].AsFloat;
                 end;

               end;

               if Odd(X) then
                varCor1 := RGB(255,255,225)
               else
                varCor1 := RGB(216,234,204);

               Inc(X);


              FDQueryResumo3.next;
           end;

           Inc(X);
           FDQueryResumo1.First;
           while not FDQueryResumo1.Eof do
           begin
               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,17) do
               begin
                   Style.Font.Style := Style.Font.Style + [fsBold];
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant :=  FDQueryResumo1.Fields[0].AsString;  //Status

               end;
              // Y:=0;
               for J := 18 to Fim_i do
               begin
                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,J) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     Style.DataFormat.FormatCode := '#,##0.00';
                     AsVariant := FDQueryResumo1.Fields[J-17].AsFloat;
                 end;
                // Inc(Y);
               end;

               if Odd(X) then
                varCor1 := RGB(255,255,225)
               else
                varCor1 := RGB(216,234,204);

               Inc(X);


              FDQueryResumo1.next;
           end;

           Inc(X);
           FDQueryResumo2.First;
           while not FDQueryResumo2.Eof do
           begin

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,17) do
               begin
                   Style.Font.Style := Style.Font.Style + [fsBold];
                   Style.Brush.BackgroundColor := varCor1;
                   AsString := FDQueryResumo2.Fields[8].AsString; //Total de Clientes
               end;

               for J := 19 to Fim_i do
               begin
                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,J) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     AsVariant := FDQueryResumo2.Fields[J].AsInteger;
                 end;
               end;

               if Odd(X) then
                varCor1 := RGB(255,255,225)
               else
                varCor1 := RGB(216,234,204);

               Inc(X);


              FDQueryResumo2.next;
           end;



           dxSpreadSheet.BeginUpdate;
           dxSpreadSheet.SaveToFile( cxButtonEditPath.Text );
           MessageDlg( pChar( 'Planilha exportada em  ' + ExtractFilePath(SaveDialog.FileName) )  , mtInformation, [ mbOk ], 0 );

       finally
          FreeAndNil(dxSpreadSheet);
       end;
       FDQueryRecuperaCliente.First;
   Finally
          Mensagem( EmptyStr );
          Screen.Cursor := crDefault;
   End;
end;

    }

procedure TFr_RelatorioManutencaoClientes.cdsGraficoDetalheAfterOpen(
  DataSet: TDataSet);
begin
    Label2.Caption := IntToStr(cdsGraficoDetalhe.RecordCount);
end;

procedure TFr_RelatorioManutencaoClientes.cxButton1Click(Sender: TObject);
begin

  if cxButtonPathPeriodo.Text = EmptyStr then
    raise Exception.Create('Informe o arquivo primeiro.');

  if cxLookupComboBoxPeriodo.Text = '' then
    raise Exception.Create('Informe o per�odo primeiro.');


  Screen.Cursor := crHourGlass;
  Try
      Mensagem('Aguarde, Gerando a Planilha...');
      Imprimir3;
  Finally
      Mensagem( EmptyStr );
      cxButtonPathPeriodo.Clear;
      cxLookupComboBoxPeriodo.ItemIndex := -1;
      Screen.Cursor := crDefault;
  End;

end;

procedure TFr_RelatorioManutencaoClientes.Imprimir3;
var
  Planilha: OleVariant;
  I, X, J, ContaCliente : Integer;
  varCor1,varCor2: TColor;
begin
  SetaNomeUsuario;
  FDQueryRelClienteAtivo.Close;
  FDQueryRelClienteAtivo.SQL.Clear;
  FDQueryRelClienteAtivo.SQL.Add('SELECT DISTINCT A.TSOP_ORDBILCLICOD, B.TSOP_ORDBILCLINOM, A.TSOP_ORDBILSITNOM ');
  FDQueryRelClienteAtivo.SQL.Add(' , CASE WHEN  R.CLIENTENOVO = 1 THEN ''X'' ELSE '''' END CLIENTENOVO ');
  FDQueryRelClienteAtivo.SQL.Add('FROM TSOP_CLIENTE_ATIVO A ');
  FDQueryRelClienteAtivo.SQL.Add('LEFT OUTER JOIN dbo.TSOP_RECUPERACLIENTE_' +  NomedoUsuario  + ' R ON R.TSOP_ORDBILCLICOD = A.TSOP_ORDBILCLICOD AND R.TSOP_ORDBILSITNOM = A.TSOP_ORDBILSITNOM ');
  FDQueryRelClienteAtivo.SQL.Add('INNER JOIN VSOP_CLIENTEBYSALESREPFORECAST B ON B.TSOP_ORDBILCLICOD = A.TSOP_ORDBILCLICOD AND B.TSOP_ORDBILSITNOM = A.TSOP_ORDBILSITNOM ');
  FDQueryRelClienteAtivo.SQL.Add('WHERE R.CLASSIFICACAO IN (''A'', ''B'',''C'')  AND DATAFINAL = :DataFinal AND B.TSOP_ORDBILCANNOM <> ''DM'' ORDER BY 2,1 ');
  FDQueryRelClienteAtivo.Params.ParamByName('DataFinal').AsDate := FDQueryPeriodoDATA.AsDateTime;
  FDQueryRelClienteAtivo.Open;
  FDQueryRelClienteAtivo.DisableControls;
  FDQueryRelClienteAtivo.First;

  Planilha:= CreateOleObject('Excel.Application');
  Planilha.caption := 'Clientes Novos do Periodo';
  Planilha.visible:=false;
  Planilha.workbooks.add(1);

  Planilha.cells[1,1]:='C�d. SAP ';
  Planilha.cells[1,2]:='Nome do Cliente';
  Planilha.cells[1,3]:='Site';
  Planilha.cells[1,4]:='Novo';

  X := 2;
  while not FDQueryRelClienteAtivo.eof do
  begin
       Planilha.cells[X, 1] :=  FDQueryRelClienteAtivo.Fields[0].AsString; //CSR
       Planilha.cells[X, 2] :=  FDQueryRelClienteAtivo.Fields[1].AsString; //Vendedor
       Planilha.cells[X, 3] :=  FDQueryRelClienteAtivo.Fields[2].AsString; //Vendedor
       Planilha.cells[X, 4] :=  FDQueryRelClienteAtivo.Fields[3].AsString; //Grupo
       Inc(X);
       FDQueryRelClienteAtivo.Next;
  end;

  FDQueryRelClienteAtivo.EnableControls;

  Planilha.columns.autofit;
  Planilha.Visible:=True;
  Planilha.workbooks[1].SaveAs( cxButtonPathPeriodo.Text , xlWorkbookDefault);
  Planilha:= Unassigned;
  FDQueryRelClienteAtivo.First;
end;

procedure TFr_RelatorioManutencaoClientes.cxButtonEditPathClick(
  Sender: TObject);
begin
  SaveDialog.InitialDir := GetCurrentDir;
  if SaveDialog.Execute(Handle) then
  begin
    cxButtonEditPath.Text := SaveDialog.FileName;
  end;
end;

procedure TFr_RelatorioManutencaoClientes.cxButtonPathPeriodoClick(
  Sender: TObject);
begin
  SaveDialog.InitialDir := GetCurrentDir;
  if SaveDialog.Execute(Handle) then
  begin
    cxButtonPathPeriodo.Text := SaveDialog.FileName;
  end;
end;

procedure TFr_RelatorioManutencaoClientes.cxButtonPrintClick(Sender: TObject);
begin
  if not cdsGrafico.IsEmpty then
  begin
     with TPrintDialog.Create(nil) do
    try
      if Execute then
        Chart.PrintLandscape;
    finally
      Free;
    end;
  end;

end;

function TFr_RelatorioManutencaoClientes.RemoveAcento(const pText: string): string;
type
  USAscii20127 = type AnsiString(20127);
begin
  Result := string(USAscii20127(pText));
end;

procedure TFr_RelatorioManutencaoClientes.SetaNomeUsuario;
begin
  NomedoUsuario := Fr_Brady.TSIS_USUNOM.Replace('.', '');
  NomedoUsuario :=  NomedoUsuario.Replace('-','');
  NomedoUsuario := RemoveAcento(NomedoUsuario);
  NomedoUsuario := StringReplace(NomedoUsuario,' ', EmptyStr, [rfReplaceAll]);
end;

procedure TFr_RelatorioManutencaoClientes.cxButtonRefreshClick(Sender: TObject);
begin
  Mensagem('Preparando Ambiente...');
  SetaNomeUsuario;

  cxGrid1DBBandedTableView1.ClearItems;
  cxGrid2DBBandedTableView1.ClearItems;
  cxGrid3DBBandedTableView1.ClearItems;
  cxGrid4DBBandedTableView1.ClearItems;

  FDQueryAux.Close;
  FDQueryBase.Close;
  FDQueryRecuperaCliente.Close;
  FDQueryRecuperaClienteMem.Close;
  cdsGrafico.Close;
  FDQueryResumo1.Close;
  FDQueryResumo2.Close;
  FDQueryResumo3.Close;
  cdsGraficoDetalhe.Close;


  if ABand <> Nil then
  begin
    ABand.Bands.Clear;
  end;

  if ABand1 <> Nil then
  begin
    ABand1.Bands.Clear;
  end;

  if ABand2 <> Nil then
  begin
    ABand2.Bands.Clear;
  end;

  if ABand3 <> Nil then
  begin
    ABand3.Bands.Clear;
  end;

  Try
     AbrirDataset;
  except
    on E: Exception do
      begin

        Mensagem( '3 ' + E.Message );


      end;

    end;
end;

procedure TFr_RelatorioManutencaoClientes.DropObjetos;
begin
  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
  FDQueryAux.SQL.Add(' IF OBJECT_ID(''' + 'dbo.TSOP_RECUPERACLIENTE_' + NomedoUsuario + ''', ''U'' )  IS NOT NULL ');
  FDQueryAux.SQL.Add('   Drop Table TSOP_RECUPERACLIENTE_' + NomedoUsuario);
  FDQueryAux.ExecSQL;

  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
  FDQueryAux.SQL.Add(' IF OBJECT_ID(''' + 'dbo.TSOP_RECUPERACLIENTE_RESUMO_' + NomedoUsuario + ''', ''U'' )  IS NOT NULL ');
  FDQueryAux.SQL.Add('   Drop Table TSOP_RECUPERACLIENTE_RESUMO_' + NomedoUsuario);
  FDQueryAux.ExecSQL;



  if FileExists(MyDocumentsPath + '\' + DataFileBase) then
   DeleteFile(MyDocumentsPath + '\' + DataFileBase);

  if FileExists(MyDocumentsPath + '\' +  DataFileMestre) then
    DeleteFile(MyDocumentsPath + '\' +  DataFileMestre);

  if FileExists(MyDocumentsPath  + '\' +  DataFileDetalhe) then
   DeleteFile(MyDocumentsPath  + '\' +  DataFileDetalhe);

end;

procedure TFr_RelatorioManutencaoClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FDQueryPeriodo.Close;
  DropObjetos;
  Mensagem('');
  Fr_RelatorioManutencaoClientes := nil;
  Action := caFree;
end;

procedure TFr_RelatorioManutencaoClientes.FormShow(Sender: TObject);
var
  i,j : Integer;
  Ano, MesInicio, MesAtual, Dia: Word;
  DataAnterior : TDateTime;
begin

  FDQueryPeriodo.Open;

 { DataAnterior := IncMonth(System.DateUtils.StartOfTheMonth(now),-1);
  MesInicio    := GetMonth(System.DateUtils.StartOfTheYear(now));
  MesAtual     := GetMonth(IncMonth(System.DateUtils.StartOfTheMonth(now),-1));
  cbMes.Properties.Items.Add('');

  for I := CurrentYear  downto 2016  do
    begin

      for j := MesAtual  downto MesInicio do
      begin
        cbMes.Properties.Items.Add(GetNameOfMonth(DataAnterior)+ '-' +  IntToStr(I) );
        DataAnterior := IncMonth(DataAnterior, -1) ;
      end;
      MesAtual  := 12;
      MesInicio := 1;

    end;
  cbMes.ItemIndex:=-1;
  }
end;

procedure TFr_RelatorioManutencaoClientes.InitGrid;
var
  col, I: Integer;
begin
  with Chart do
  begin
    while SeriesCount > 0 do
      Series[0].Free;

    Title.Text.Clear;
    Title.Text.Add('Clientes servidos no m�s - Per�odo: ' + cbPeriodo.Text);

    Legend.Visible := True;
    View3D := True;
    I:= 0;
    cdsGrafico.First;
    while not cdsGrafico.Eof do
    begin
      AddSeries(TBarSeries.Create(Self));
      (Series[I] as TBarSeries).MultiBar := mbStacked;
      Series[I].Marks.Visible := True;
      Series[I].Marks.Style := smsValue;

      Series[I].Name := 'Stacked' + cdsGrafico.FieldByName('Curva').AsString +  IntToStr(I);
      Series[I].LegendTitle := cdsGrafico.FieldByName('Curva').AsString;

      for col := 1 to iPeriodo do
        if not cdsGrafico.Fields[col].IsNull then
          Series[I].Add(cdsGrafico.Fields[col].Value,
            cdsGrafico.Fields[col].FieldName, clTeeColor);

      Inc(I);
      cdsGrafico.next;
    end;

  end;
  cdsGrafico.First;
  cdsGrafico.EnableControls;
end;

procedure TFr_RelatorioManutencaoClientes.InitGrid2;
var
  col, I: Integer;
begin
  with Chart1 do
  begin
    while SeriesCount > 0 do
      Series[0].Free;

    Title.Text.Clear;
    Title.Text.Add(' Per�odo: ' + cbPeriodo.Text);

    Legend.Visible := True;
    View3D := True;
    I:= 0;
    FDQueryResumo2.First;

    while not FDQueryResumo2.Eof do
    begin
      If FDQueryResumo2.FieldByName('TSOP_ORDBILREPNOM').AsString  = 'GRAFICO' Then
      begin
        AddSeries(TBarSeries.Create(Self));
      //  (Series[I] as TBarSeries).MultiBar := mbStacked;
        Series[I].Marks.Visible := True;
        Series[I].Marks.Style := smsValue;

        Series[I].Name := 'barClientesAtivoseNovos' +  IntToStr(I);
        Series[I].LegendTitle := FDQueryResumo2.FieldByName('TSOP_REPCSR').AsString;

        for col := 1 to iPeriodo do
          if not (FDQueryResumo2.Fields[col+18].IsNull) then
           Series[I].Add(FDQueryResumo2.Fields[col+18].Value,
             FDQueryResumo2.Fields[col+18].FieldName, clTeeColor);



        Inc(I);
      end;

      FDQueryResumo2.next;
    end;

  end;
  FDQueryResumo2.First;
  FDQueryResumo2.EnableControls;
end;



procedure TFr_RelatorioManutencaoClientes.Mensagem(pMensagem: String);
begin
  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;
end;

function TFr_RelatorioManutencaoClientes.MontaStringMes(bMostraLabel: Boolean;
  Alias, Tipo: String; SomarL: Boolean; VisaoDinamica : Boolean; ComAS: Boolean = True; SUM : Boolean = False; Language : String = 'BR'): WideString;
var
  I : Integer;
  NovaDataInterna : TDateTime;
  varResultado: String;
begin


  SetLength(varMesesArrayB, iPeriodo);
  SetLength(varMesesArrayF, iPeriodo + 1);

  NovaData := System.DateUtils.StartOfTheMonth(now);
 // if cbMes.ItemIndex > -1 then
 //   NovaData := IncMonth(System.DateUtils.StartOfTheMonth(now), (cbMes.ItemIndex-1)*-1 );

  //NovaData := IncMonth(System.DateUtils.StartOfTheMonth(now), -16); //

  if ((Alias = '') or (Alias = 'B')) and (Tipo = 'B') then
    NovaDataInterna := IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -iPeriodo);

  varResultado := '';
  if ((Alias = '') or (Alias = 'B')) and (Tipo = 'B') then
  begin
    for I := 0 to iPeriodo - 1 do
    begin
      varMesesArrayB[I] := NovaDataInterna;
      varResultado := varResultado + BuscaMes(NovaDataInterna, bMostraLabel, Alias, SomarL, VisaoDinamica,  ComAS, SUM, Language);
      NovaDataInterna := IncMonth(NovaDataInterna, 1);
    end;
  end
  else
  begin
    for I := 0 to iPeriodo do
    begin
      varMesesArrayF[I] := NovaDataInterna;
      varResultado := varResultado + BuscaMes(NovaDataInterna, bMostraLabel, Alias, SomarL, VisaoDinamica, ComAS, SUM, Language);
      NovaDataInterna := IncMonth(NovaDataInterna, 1);
    end;
  end;

  Result := varResultado;

end;

procedure TFr_RelatorioManutencaoClientes.PageChange(Sender: TObject);
begin
   if Page.ActivePage = tabGrafico then
   begin
      if Not cdsGrafico.IsEmpty then
      begin
        Mensagem('Gerando Gr�fico');
        InitGrid;
        Mensagem(EmptyStr);
      end;
   end;

   if Page.ActivePage = tabDetalhe then
   begin
      if Not FDQueryResumo2.IsEmpty then
      begin
        Mensagem('Gerando Gr�fico');
        InitGrid2;
        Mensagem(EmptyStr);
      end;
   end;

end;

procedure TFr_RelatorioManutencaoClientes.SetaPeriodo;
begin



    if cbPeriodo.ItemIndex = 0 then
    begin
      iPeriodo := 3;
      Fim_I    := 21;
    end
    else if cbPeriodo.ItemIndex = 1 then
    begin
      iPeriodo := 6;
      Fim_I    := 24;
    end
    else if cbPeriodo.ItemIndex = 2 then
    begin
      iPeriodo := 9;
      Fim_I    := 27;
    end
    else if cbPeriodo.ItemIndex = 3 then
    begin
      iPeriodo := 12;
      Fim_I    := 30;
    end
    else if cbPeriodo.ItemIndex = 4 then
    begin
      iPeriodo := 15;
      Fim_I    := 33;
    end
     else if cbPeriodo.ItemIndex = 5 then
    begin
      iPeriodo := 18;
      Fim_I    := 36;
    end
    else if cbPeriodo.ItemIndex = 6 then
    begin
      iPeriodo := 24;
      Fim_I    := 42;
    end
    else if cbPeriodo.ItemIndex = 7 then
    begin
      iPeriodo := 36;
      Fim_I    := 54;
    end;
    iPeriodoFixo := Fim_I - 12;

end;

end.




select * from TSOP_RECUPERACLIENTE_RESUMO_Alugacom
UNION ALL
SELECT '' AS TSOP_ORDBILREPNOM,
       '' AS TSOP_ORDBILGRUCLINOM,
	   '' AS TSOP_ORDBILCLICOD,
	   '' AS TSOP_ORBBILCLINOM,
	   '' AS TSOP_ORDBILSITNOM,
	   '' AS TSOP_ORDBILCANNOM,
	   '' AS TSOP_ORDBILREG,
	   '' AS TSOP_ORDBILREGEST,
	   'Clientes Ativos' AS TSOP_REPCSR,
	   '' AS STATUS,
	   0 AS HITS,
	   0 AS RECENCIA,
	   0 AS CLIENTENOVO,
	   0.00 AS MEDIA_12,
	   '' AS CLASSIFICACAO_12,
	   0.00 AS ACUMULADO_12,
	   0.00 AS MEDIA,
	   '' AS CLASSIFICACAO,
	   0.00 AS ACUMULADO,
 [Aug 2019],[Sep 2019],[Oct 2019],[Nov 2019],[Dec 2019],[Jan 2020],[Feb 2020],[Mar 2020],[Apr 2020],[May 2020],[Jun 2020],[Jul 2020]
FROM (
        select QUANTIDADE, CONVERT(CHAR(4), DATA, 100) + CONVERT(CHAR(4), DATA, 120) AS Mes
        from TSOP_RECUPERACLIENTE_QTDEVENDAS
) sq
 PIVOT
  (
   SUM(QUANTIDADE)
  FOR Mes IN ( [Aug 2019],[Sep 2019],[Oct 2019],[Nov 2019],[Dec 2019],[Jan 2020],[Feb 2020],[Mar 2020],[Apr 2020],[May 2020],[Jun 2020],[Jul 2020])
  ) AS PIVOTTABLE






