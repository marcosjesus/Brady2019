unit uRelatorioGestaoMercados;

interface

uses
  System.IOUtils,
  System.DateUtils,


  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinscxPCPainter, dxBarBuiltInMenu, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxContainer, cxClasses, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxCustomPivotGrid, cxDBPivotGrid, cxLabel,
  dxGDIPlusClasses, Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGrid, cxPC, dxSkinsDefaultPainters, dxSkinOffice2013White, Vcl.ComCtrls, dxCore, cxDateUtils, Vcl.Menus, Vcl.StdCtrls,
  cxButtons, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxCheckBox, cxCheckComboBox, FireDAC.Comp.ScriptCommands,
  FireDAC.Comp.Script, cxCurrencyEdit, cxMemo, dxSkinBlack, dxSkinBlue,
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
  dxSkinTheAsphaltWorld, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TFr_RelatorioGestaoMercados = class(TForm)
    DataSourceVSOP_OrderBillingFaturamento: TDataSource;
    FDConnection: TFDConnection;
    FDQueryVSOP_OrderBillingFaturamento: TFDQuery;
    FDQueryVSOP_OrderBillingPedidos: TFDQuery;
    FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILCANNOM: TStringField;
    FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILGRUCLINOM: TStringField;
    FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILREPNOM: TStringField;
    FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILVALLIQ: TBCDField;
    DataSourceVSOP_OrderBillingPedidos: TDataSource;
    FDQueryVSOP_OrderBillingFaturamentoTSOP_ORDBILCANNOM: TStringField;
    FDQueryVSOP_OrderBillingFaturamentoTSOP_ORDBILGRUCLINOM: TStringField;
    FDQueryVSOP_OrderBillingFaturamentoTSOP_ORDBILREPNOM: TStringField;
    FDQueryVSOP_OrderBillingFaturamentoTSOP_ORDBILVALLIQ: TBCDField;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILDAT: TMemoField;
    FDQueryVSOP_OrderBillingFaturamentoTSOP_ORDBILDAT: TMemoField;
    FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILTYP: TStringField;
    FDQueryVSOP_OrderBillingPedidosTSOP_REPNOMINT: TStringField;
    FDQueryVSOP_OrderBillingPedidosTSOP_REPMKT: TStringField;
    FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILCLINOM: TStringField;
    FDQueryVSOP_OrderBillingPedidosTSOP_GRUCLIMER: TStringField;
    FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILSITNOM: TStringField;
    FDQueryVSOP_OrderBillingFaturamentoTSOP_REPNOMINT: TStringField;
    FDQueryVSOP_OrderBillingFaturamentoTSOP_REPMKT: TStringField;
    FDQueryVSOP_OrderBillingFaturamentoTSOP_ORDBILCLINOM: TStringField;
    FDQueryVSOP_OrderBillingFaturamentoTSOP_GRUCLIMER: TStringField;
    FDQueryVSOP_OrderBillingFaturamentoTSOP_ORDBILSITNOM: TStringField;
    FDQueryVSOP_OrderBillingFaturamentoTSOP_ORDBILTYP: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracy: TFDQuery;
    FDQueryVSOP_OrderBillingForecastAccuracyTSOP_ORDBILREPNOM: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyTSOP_ORDBILGRUCLINOM: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyTSOP_ORDBILCANNOM: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyTSOP_ORDBILDAT: TMemoField;
    FDQueryVSOP_OrderBillingForecastAccuracyTSOP_ORDBILTYP: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyTSOP_ORDBILVALLIQ: TBCDField;
    FDQueryVSOP_OrderBillingForecastAccuracyTSOP_REPNOMINT: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyTSOP_REPMKT: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyTSOP_ORDBILCLINOM: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyTSOP_GRUCLIMER: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyTSOP_ORDBILSITNOM: TStringField;
    DataSourceVSOP_OrderBillingForecastAccuracy: TDataSource;
    cxPageControlPivot: TcxPageControl;
    cxTabSheetPivot00: TcxTabSheet;
    cxDBPivotGrid000: TcxDBPivotGrid;
    cxDBPivotGrid00FieldTSOP_ORDBILREPNOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_ORDBILGRUCLINOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_ORDBILCANNOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_ORDBILDAT: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_ORDBILVALLIQ: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_REPNOMINT: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_ORDBILSITNOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_ORDBILCLINOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_GRUCLIMER: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_REPMKT: TcxDBPivotGridField;
    cxTabSheetPivot01: TcxTabSheet;
    cxDBPivotGrid001: TcxDBPivotGrid;
    cxDBPivotGrid01FieldTSOP_ORDBILREPNOM: TcxDBPivotGridField;
    cxDBPivotGrid01FieldTSOP_ORDBILGRUCLINOM: TcxDBPivotGridField;
    cxDBPivotGrid01FieldTSOP_ORDBILCANNOM: TcxDBPivotGridField;
    cxDBPivotGrid01FieldTSOP_ORDBILDAT: TcxDBPivotGridField;
    cxDBPivotGrid01FieldTSOP_ORDBILVALLIQ: TcxDBPivotGridField;
    cxDBPivotGrid01FieldTSOP_REPNOMINT: TcxDBPivotGridField;
    cxDBPivotGrid01FieldTSOP_ORDBILSITNOM: TcxDBPivotGridField;
    cxDBPivotGrid01FieldTSOP_ORDBILCLINOM: TcxDBPivotGridField;
    cxDBPivotGrid01FieldTSOP_GRUCLIMER: TcxDBPivotGridField;
    cxDBPivotGrid01FieldTSOP_REPMKT: TcxDBPivotGridField;
    cxDBPivotGrid01FieldTSOP_ORDBILTYP: TcxDBPivotGridField;
    cxTabSheetPivot02: TcxTabSheet;
    cxDBPivotGrid02: TcxDBPivotGrid;
    cxDBPivotGrid02FieldTSOP_ORDBILREPNOM: TcxDBPivotGridField;
    cxDBPivotGrid02FieldTSOP_ORDBILGRUCLINOM: TcxDBPivotGridField;
    cxDBPivotGrid02FieldTSOP_ORDBILCANNOM: TcxDBPivotGridField;
    cxDBPivotGrid02FieldTSOP_ORDBILDAT: TcxDBPivotGridField;
    cxDBPivotGrid02FieldTSOP_ORDBILVALLIQSAL: TcxDBPivotGridField;
    cxDBPivotGrid02FieldTSOP_REPNOMINT: TcxDBPivotGridField;
    cxDBPivotGrid02FieldTSOP_ORDBILSITNOM: TcxDBPivotGridField;
    cxDBPivotGrid02FieldTSOP_ORDBILCLINOM: TcxDBPivotGridField;
    cxDBPivotGrid02FieldTSOP_GRUCLIMER: TcxDBPivotGridField;
    cxDBPivotGrid02FieldTSOP_REPMKT: TcxDBPivotGridField;
    FDQueryVSOP_OrderBillingForecastAccuracyTSOP_ORDBILVALLIQSAL: TFloatField;
    FDQueryVSOP_OrderBillingForecastAccuracyTSOP_ORDBILVALLIQFOR: TFloatField;
    FDQueryVSOP_OrderBillingForecastAccuracyTSOP_ORDBILVALLIQACC: TFloatField;
    cxDBPivotGrid02FieldTSOP_ORDBILVALLIQFOR: TcxDBPivotGridField;
    cxDBPivotGrid02FieldTSOP_ORDBILVALLIQACC: TcxDBPivotGridField;
    cxStyleRepositoryColumns: TcxStyleRepository;
    cxStyleColumnAccuracy: TcxStyle;
    FDQueryVSOP_OrderBillingForecastAccuracyFamilia: TFDQuery;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_ORDBILREPNOM: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_ORDBILGRUCLINOM: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_ORDBILCANNOM: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_ORDBILDAT: TMemoField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_ORDBILTYP: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_ORDBILVALLIQ: TBCDField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_REPNOMINT: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_REPMKT: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_ORDBILCLINOM: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_GRUCLIMER: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_ORDBILSITNOM: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_ORDBILVALLIQSAL: TFloatField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_ORDBILVALLIQFOR: TFloatField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_ORDBILVALLIQACC: TFloatField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_ORDBILITEFAM: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_ORDBILITEFAMPAI: TStringField;
    cxTabSheetPivot03: TcxTabSheet;
    cxDBPivotGrid03: TcxDBPivotGrid;
    cxDBPivotGrid03FieldTSOP_ORDBILREPNOM: TcxDBPivotGridField;
    cxDBPivotGrid03FieldTSOP_ORDBILGRUCLINOM: TcxDBPivotGridField;
    cxDBPivotGrid03FieldTSOP_ORDBILCANNOM: TcxDBPivotGridField;
    cxDBPivotGrid03FieldTSOP_ORDBILDAT: TcxDBPivotGridField;
    cxDBPivotGrid03FieldTSOP_ORDBILVALLIQSAL: TcxDBPivotGridField;
    cxDBPivotGrid03FieldTSOP_ORDBILVALLIQFOR: TcxDBPivotGridField;
    cxDBPivotGrid03FieldTSOP_REPNOMINT: TcxDBPivotGridField;
    cxDBPivotGrid03FieldTSOP_ORDBILSITNOM: TcxDBPivotGridField;
    cxDBPivotGrid03FieldTSOP_ORDBILCLINOM: TcxDBPivotGridField;
    cxDBPivotGrid03FieldTSOP_ORDBILITEFAMPAI: TcxDBPivotGridField;
    cxDBPivotGrid03FieldTSOP_ORDBILITEFAM: TcxDBPivotGridField;
    cxDBPivotGrid03FieldTSOP_GRUCLIMER: TcxDBPivotGridField;
    cxDBPivotGrid03FieldTSOP_REPMKT: TcxDBPivotGridField;
    cxDBPivotGrid03FieldTSOP_ORDBILVALLIQACC: TcxDBPivotGridField;
    DataSourceVSOP_OrderBillingForecastAccuracyFamilia: TDataSource;
    FDQueryVSOP_OrderBillingForecastAccuracyTSOP_ORDBILREG: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyTSOP_ORDBILREGEST: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_ORDBILREG: TStringField;
    FDQueryVSOP_OrderBillingForecastAccuracyFamiliaTSOP_ORDBILREGEST: TStringField;
    cxDBPivotGrid02FieldTSOP_ORDBILREGEST: TcxDBPivotGridField;
    cxDBPivotGrid02FieldTSOP_ORDBILREG: TcxDBPivotGridField;
    cxDBPivotGrid03FieldTSOP_ORDBILREGEST: TcxDBPivotGridField;
    cxDBPivotGrid03FieldTSOP_ORDBILREG: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTSOP_ORDBILTYP: TcxDBPivotGridField;
    Panel1: TPanel;
    cxButtonRefresh: TcxButton;
    cxLabel3: TcxLabel;
    cxCheckComboBoxTSOP_CANAL: TcxCheckComboBox;
    cxLabelData: TcxLabel;
    cxDateEdit_DATINI: TcxDateEdit;
    cxLabelDataFinal: TcxLabel;
    FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILITECOD: TStringField;
    cxDBPivotGrid00FieldTSOP_ORDBILITECOD: TcxDBPivotGridField;
    cxDateEdit_DATFIM: TcxDateEdit;
    cbxData: TcxComboBox;
    FDQueryVSOP_OrderBillingPedidosTSOP_ORDBILQTDSKU: TBCDField;
    cxDBPivotGrid000FieldTSOP_ORDBILQTDSKU: TcxDBPivotGridField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FDQueryVSOP_OrderBillingForecastAccuracyCalcFields(
      DataSet: TDataSet);
    procedure cxDBPivotGrid02FieldTSOP_ORDBILVALLIQACCGetDisplayText(
      Sender: TcxPivotGridField; ACell: TcxPivotGridDataCellViewInfo;
      var AText: string);
    procedure Button1Click(Sender: TObject);
    procedure FDQueryVSOP_OrderBillingForecastAccuracyFamiliaCalcFields(
      DataSet: TDataSet);
    procedure cxDBPivotGrid03FieldTSOP_ORDBILVALLIQACCGetDisplayText(
      Sender: TcxPivotGridField; ACell: TcxPivotGridDataCellViewInfo;
      var AText: string);
    procedure cxButtonRefreshClick(Sender: TObject);
    procedure cbxDataPropertiesChange(Sender: TObject);
  private
    TextVendas: String;
    TextForecast: String;
    procedure Mensagem( pMensagem: String );
    { Private declarations }
  public
    procedure AbrirDataset;
    procedure LoadGridCustomization;
    function getText( AText: String ): String;
    { Public declarations }
  end;

var
  Fr_RelatorioGestaoMercados: TFr_RelatorioGestaoMercados;

implementation

{$R *.dfm}

uses uBrady, uUtils, uDados;

procedure TFr_RelatorioGestaoMercados.AbrirDataset;
var
 varTSOP_CANAL : String;
begin

  Mensagem( 'Abrindo conex�o...' );
  try

    if not FDConnection.Connected then
    begin

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

    end;


    Mensagem( 'Obtendo dados (Entrada de Pedidos do M�s)...' );

  //  FDQueryVSOP_OrderBillingPedidos.ParamByName( 'MES_INI' ).AsDateTime      := System.DateUtils.StartOfTheMonth(cxDateEdit_DATINI.Date);


  //  FDQueryVSOP_OrderBillingPedidos.ParamByName( 'MES_INI_ANT' ).AsDateTime := System.DateUtils.StartOfTheMonth(cxDateEdit_DATINI.Date)-365;


   {
    if System.DateUtils.MonthOf(Now) >= 8 then
    begin
      FDQueryVSOP_OrderBillingPedidos.ParamByName( 'YEARDOC' ).AsInteger := System.DateUtils.YearOf(cxDateEdit_DATINI.Date) + 1 ;
      FDQueryVSOP_OrderBillingPedidos.ParamByName( 'YEARDOC_ANT' ).AsInteger := System.DateUtils.YearOf(cxDateEdit_DATINI.Date);
    end
    else
    begin
      FDQueryVSOP_OrderBillingPedidos.ParamByName( 'YEARDOC' ).AsInteger := System.DateUtils.YearOf(cxDateEdit_DATINI.Date);
      FDQueryVSOP_OrderBillingPedidos.ParamByName( 'YEARDOC_ANT' ).AsInteger := System.DateUtils.YearOf(cxDateEdit_DATINI.Date) - 1;
    end;

    if System.DateUtils.MonthOf(Now) >= 8 then
    begin
      FDQueryVSOP_OrderBillingPedidos.ParamByName( 'MONTHDOC' ).AsInteger := System.DateUtils.MonthOf(cxDateEdit_DATINI.Date) - 7;
      FDQueryVSOP_OrderBillingPedidos.ParamByName( 'MONTHDOC_ANT' ).AsInteger := System.DateUtils.MonthOf(cxDateEdit_DATINI.Date) - 7;
    end
    else
    begin
      FDQueryVSOP_OrderBillingPedidos.ParamByName( 'MONTHDOC' ).AsInteger := System.DateUtils.MonthOf(cxDateEdit_DATINI.Date) + 5;
      FDQueryVSOP_OrderBillingPedidos.ParamByName( 'MONTHDOC_ANT' ).AsInteger := System.DateUtils.MonthOf(cxDateEdit_DATINI.Date) + 5;
    end;
    }
    varTSOP_CANAL := EmptyStr;

    if cxCheckComboBoxTSOP_CANAL.States[0] = cbsChecked then
    begin

      if varTSOP_CANAL = EmptyStr then
        varTSOP_CANAL := ' AND B01.TSOP_ORDBILCANNOM IN ('
      else
        varTSOP_CANAL := varTSOP_CANAL + ',';

      varTSOP_CANAL := varTSOP_CANAL + QuotedStr('DISTRIBUTORS');

    end;

    if cxCheckComboBoxTSOP_CANAL.States[1] = cbsChecked then
    begin

      if varTSOP_CANAL = EmptyStr then
        varTSOP_CANAL := ' AND B01.TSOP_ORDBILCANNOM IN ('
      else
        varTSOP_CANAL := varTSOP_CANAL + ',';

      varTSOP_CANAL := varTSOP_CANAL + QuotedStr('PID');

    end;

    if not (varTSOP_CANAL = EmptyStr) then
    begin

      varTSOP_CANAL := varTSOP_CANAL + ')';

    end;

    if cbxData.ItemIndex = 1 then
    begin
    {
      FDQueryVSOP_OrderBillingPedidos.MacroByName( 'WHERE3' ).AsRaw := ' AND C01.TSOP_ORDBILDATDOCREQ  >= ''' +
       FormatDateTime('yyyy-mm-dd 00:00:01',  cxDateEdit_DATINI.Date) + '''' +
       ' and C01.TSOP_ORDBILDATDOCREQ <= ''' + FormatDateTime('yyyy-mm-dd 23:59:59', cxDateEdit_DATFIM.Date) + '''';
 }
      FDQueryVSOP_OrderBillingPedidos.MacroByName( 'WHERE3' ).AsRaw := ' AND C01.TSOP_ORDBILDATDOCREQ  >= :DtRecIni and  C01.TSOP_ORDBILDATDOCREQ <= :DtRecFim ';
      FDQueryVSOP_OrderBillingPedidos.ParamByName( 'DtRecIni' ).AsString :=  FormatDateTime('yyyy-mm-dd 00:00:01',  System.DateUtils.StartOfTheMonth(System.DateUtils.EndOfTheMonth(cxDateEdit_DATINI.Date)));
      FDQueryVSOP_OrderBillingPedidos.ParamByName( 'DtRecFim' ).AsString :=  FormatDateTime('yyyy-mm-dd 23:59:59', System.DateUtils.EndOfTheMonth(System.DateUtils.EndOfTheMonth(cxDateEdit_DATINI.Date)));


  {
      FDQueryVSOP_OrderBillingPedidos.MacroByName( 'WHERE3ANT' ).AsRaw := ' AND C01.TSOP_ORDBILDATDOCREQ >= ''' +
        FormatDateTime('yyyy-mm-dd 00:00:01', cxDateEdit_DATINI.Date-365 ) + '''' +
        ' and C01.TSOP_ORDBILDATDOCREQ <= ''' + FormatDateTime('yyyy-mm-dd 23:59:59', cxDateEdit_DATFIM.Date-365) + '''';
 }

      FDQueryVSOP_OrderBillingPedidos.MacroByName( 'WHERE3ANT' ).AsRaw := ' AND C01.TSOP_ORDBILDATDOCREQ  >= :DtRecIniAnt and  C01.TSOP_ORDBILDATDOCREQ <= :DtRecFimAnt ';
      FDQueryVSOP_OrderBillingPedidos.ParamByName( 'DtRecIniAnt' ).AsString :=  FormatDateTime('yyyy-mm-dd 00:00:01', System.DateUtils.StartOfTheMonth(System.DateUtils.EndOfTheMonth(cxDateEdit_DATINI.Date)-365));
      FDQueryVSOP_OrderBillingPedidos.ParamByName( 'DtRecFimAnt' ).AsString :=  FormatDateTime('yyyy-mm-dd 23:59:59', System.DateUtils.EndOfTheMonth(System.DateUtils.EndOfTheMonth(cxDateEdit_DATINI.Date)-365));

      cxDBPivotGrid00FieldTSOP_ORDBILDAT.Caption := 'Data Requerida';



    end
    else
    begin
      FDQueryVSOP_OrderBillingPedidos.MacroByName( 'WHERE3' ).AsRaw := ' AND C01.TSOP_ORDBILDATDOC >= :DtDocIni and  C01.TSOP_ORDBILDATDOC <= :DtDocFim';
      FDQueryVSOP_OrderBillingPedidos.ParamByName( 'DtDocIni' ).AsDateTime :=  System.DateUtils.StartOfTheMonth(System.DateUtils.EndOfTheMonth(cxDateEdit_DATINI.Date));
      FDQueryVSOP_OrderBillingPedidos.ParamByName( 'DtDocFim' ).AsDateTime :=  System.DateUtils.EndOfTheMonth(System.DateUtils.EndOfTheMonth(cxDateEdit_DATINI.Date));

      FDQueryVSOP_OrderBillingPedidos.MacroByName( 'WHERE3ANT' ).AsRaw := ' AND C01.TSOP_ORDBILDATDOC >= :DtDocIniAnt and C01.TSOP_ORDBILDATDOC <= :DtDocFimAnt';
      FDQueryVSOP_OrderBillingPedidos.ParamByName( 'DtDocIniAnt' ).AsDateTime :=  System.DateUtils.StartOfTheMonth(System.DateUtils.EndOfTheMonth(cxDateEdit_DATINI.Date)-365);
      FDQueryVSOP_OrderBillingPedidos.ParamByName( 'DtDocFimAnt' ).AsDateTime :=  System.DateUtils.EndOfTheMonth(System.DateUtils.EndOfTheMonth(cxDateEdit_DATINI.Date)-365);

      cxDBPivotGrid00FieldTSOP_ORDBILDAT.Caption := 'Data Documento';
    end;

    if Fr_Brady.SalesRep then
      FDQueryVSOP_OrderBillingPedidos.MacroByName( 'WHERE1' ).AsRaw := 'AND (B01.TSOP_ORDBILREPNOM = ' + QuotedStr(Fr_Brady.TSIS_USUNOM) + ' OR B01.TSOP_REPMKT = ' + QuotedStr(Fr_Brady.TSIS_USUNOM) + ' OR B01.TSOP_REPNOMINT = ' + QuotedStr(Fr_Brady.TSIS_USUNOM) + ')';

    if Fr_Brady.CustomerService then
      FDQueryVSOP_OrderBillingPedidos.MacroByName( 'WHERE1' ).AsRaw := 'AND B01.TSOP_ORDBILREPCSR = ' + QuotedStr(Fr_Brady.TSIS_USUNOM);


    FDQueryVSOP_OrderBillingPedidos.MacroByName( 'WHERE2' ).AsRaw := varTSOP_CANAL;


    FDQueryVSOP_OrderBillingPedidos.Open;


    {
    Mensagem( 'Obtendo dados (Faturamento do M�s)...' );

    FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_ANO_INI' ).AsDateTime := System.DateUtils.StartOfTheMonth(System.DateUtils.EndOfTheMonth(Now)-365);
    FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_ANO_FIM' ).AsDateTime := System.DateUtils.EndOfTheMonth(System.DateUtils.EndOfTheMonth(Now)-365);

    if System.DateUtils.MonthOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_ANO_INI' ).AsDateTime) >= 8 then
      FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'YEARDOC_ANO' ).AsInteger := System.DateUtils.YearOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_ANO_INI' ).AsDateTime) + 1
    else
      FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'YEARDOC_ANO' ).AsInteger := System.DateUtils.YearOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_ANO_INI' ).AsDateTime);

    if System.DateUtils.MonthOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_ANO_INI' ).AsDateTime) >= 8 then
      FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MONTHDOC_ANO' ).AsInteger := System.DateUtils.MonthOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_ANO_INI' ).AsDateTime) - 7
    else
      FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MONTHDOC_ANO' ).AsInteger := System.DateUtils.MonthOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_ANO_INI' ).AsDateTime) + 5;

    FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_ANT_INI' ).AsDateTime := System.DateUtils.StartOfTheMonth(System.DateUtils.StartOfTheMonth(Now)-1);
    FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_ANT_FIM' ).AsDateTime := System.DateUtils.EndOfTheMonth(System.DateUtils.StartOfTheMonth(Now)-1);
    if System.DateUtils.MonthOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_ANT_INI' ).AsDateTime) >= 8 then
      FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'YEARDOC_ANT' ).AsInteger := System.DateUtils.YearOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_ANT_INI' ).AsDateTime) + 1
    else
      FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'YEARDOC_ANT' ).AsInteger := System.DateUtils.YearOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_ANT_INI' ).AsDateTime);

    if System.DateUtils.MonthOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_ANO_INI' ).AsDateTime) >= 8 then
      FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MONTHDOC_ANT' ).AsInteger := System.DateUtils.MonthOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_ANT_INI' ).AsDateTime) - 7
    else
      FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MONTHDOC_ANT' ).AsInteger := System.DateUtils.MonthOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_ANT_INI' ).AsDateTime) + 5;

    FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_INI' ).AsDateTime := System.DateUtils.StartOfTheMonth(Now);
    FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_FIM' ).AsDateTime := System.DateUtils.EndOfTheMonth(Now);
    if System.DateUtils.MonthOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_INI' ).AsDateTime) >= 8 then
      FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'YEARDOC' ).AsInteger := System.DateUtils.YearOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_INI' ).AsDateTime) + 1
    else
      FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'YEARDOC' ).AsInteger := System.DateUtils.YearOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_INI' ).AsDateTime);

    if System.DateUtils.MonthOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_INI' ).AsDateTime) >= 8 then
      FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MONTHDOC' ).AsInteger := System.DateUtils.MonthOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_INI' ).AsDateTime) - 7
    else
      FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MONTHDOC' ).AsInteger := System.DateUtils.MonthOf(FDQueryVSOP_OrderBillingFaturamento.ParamByName( 'MES_INI' ).AsDateTime) + 5;

    if Fr_Brady.SalesRep then
      FDQueryVSOP_OrderBillingFaturamento.MacroByName( 'WHERE1' ).AsRaw := 'AND (B01.TSOP_ORDBILREPNOM = ' + QuotedStr(Fr_Brady.TSIS_USUNOM) + ' OR B01.TSOP_REPMKT = ' + QuotedStr(Fr_Brady.TSIS_USUNOM) + ' OR B01.TSOP_REPNOMINT = ' + QuotedStr(Fr_Brady.TSIS_USUNOM) + ')';

    if Fr_Brady.CustomerService then
      FDQueryVSOP_OrderBillingFaturamento.MacroByName( 'WHERE1' ).AsRaw := 'AND B01.TSOP_ORDBILREPCSR = ' + QuotedStr(Fr_Brady.TSIS_USUNOM);

    FDQueryVSOP_OrderBillingFaturamento.Open;

    Mensagem( 'Obtendo dados (Forecast Accuracy)...' );

    FDQueryVSOP_OrderBillingForecastAccuracy.ParamByName( 'MES_INI' ).AsDateTime := System.DateUtils.IncYear(System.DateUtils.EndOfTheMonth(Now)+1,-1);

    if System.DateUtils.MonthOf(Now) >= 8 then
      FDQueryVSOP_OrderBillingForecastAccuracy.ParamByName( 'YEARDOC' ).AsInteger := System.DateUtils.YearOf(Now) + 1
    else
      FDQueryVSOP_OrderBillingForecastAccuracy.ParamByName( 'YEARDOC' ).AsInteger := System.DateUtils.YearOf(Now);

    if System.DateUtils.MonthOf(Now) >= 8 then
      FDQueryVSOP_OrderBillingForecastAccuracy.ParamByName( 'MONTHDOC' ).AsInteger := System.DateUtils.MonthOf(Now) - 7
    else
      FDQueryVSOP_OrderBillingForecastAccuracy.ParamByName( 'MONTHDOC' ).AsInteger := System.DateUtils.MonthOf(Now) + 5;

    if FDQueryVSOP_OrderBillingForecastAccuracy.ParamByName( 'MONTHDOC' ).AsInteger = 12 then
    begin

      FDQueryVSOP_OrderBillingForecastAccuracy.ParamByName( 'MONTHDOC' ).AsInteger := 01

    end
    else
    begin

      FDQueryVSOP_OrderBillingForecastAccuracy.ParamByName( 'MONTHDOC' ).AsInteger := FDQueryVSOP_OrderBillingForecastAccuracy.ParamByName( 'MONTHDOC' ).AsInteger + 1;
      FDQueryVSOP_OrderBillingForecastAccuracy.ParamByName( 'YEARDOC' ).AsInteger := FDQueryVSOP_OrderBillingForecastAccuracy.ParamByName( 'YEARDOC' ).AsInteger -1;

    end;

    if Fr_Brady.SalesRep then
      FDQueryVSOP_OrderBillingForecastAccuracy.MacroByName( 'WHERE1' ).AsRaw := 'AND (B01.TSOP_ORDBILREPNOM = ' + QuotedStr(Fr_Brady.TSIS_USUNOM) + ' OR B01.TSOP_REPMKT = ' + QuotedStr(Fr_Brady.TSIS_USUNOM) + ' OR B01.TSOP_REPNOMINT = ' + QuotedStr(Fr_Brady.TSIS_USUNOM) + ')';

    if Fr_Brady.CustomerService then
      FDQueryVSOP_OrderBillingForecastAccuracy.MacroByName( 'WHERE1' ).AsRaw := 'AND B01.TSOP_ORDBILREPCSR = ' + QuotedStr(Fr_Brady.TSIS_USUNOM);

    FDQueryVSOP_OrderBillingForecastAccuracy.Open;

    Mensagem( 'Obtendo dados (Forecast Accuracy Familia)...' );

    FDQueryVSOP_OrderBillingForecastAccuracyFamilia.ParamByName( 'MES_INI' ).AsDateTime := System.DateUtils.IncYear(System.DateUtils.EndOfTheMonth(Now)+1,-1);

    if System.DateUtils.MonthOf(Now) >= 8 then
      FDQueryVSOP_OrderBillingForecastAccuracyFamilia.ParamByName( 'YEARDOC' ).AsInteger := System.DateUtils.YearOf(Now) + 1
    else
      FDQueryVSOP_OrderBillingForecastAccuracyFamilia.ParamByName( 'YEARDOC' ).AsInteger := System.DateUtils.YearOf(Now);

    if System.DateUtils.MonthOf(Now) >= 8 then
      FDQueryVSOP_OrderBillingForecastAccuracyFamilia.ParamByName( 'MONTHDOC' ).AsInteger := System.DateUtils.MonthOf(Now) - 7
    else
      FDQueryVSOP_OrderBillingForecastAccuracyFamilia.ParamByName( 'MONTHDOC' ).AsInteger := System.DateUtils.MonthOf(Now) + 5;

    if FDQueryVSOP_OrderBillingForecastAccuracyFamilia.ParamByName( 'MONTHDOC' ).AsInteger = 12 then
    begin

      FDQueryVSOP_OrderBillingForecastAccuracyFamilia.ParamByName( 'MONTHDOC' ).AsInteger := 01

    end
    else
    begin

      FDQueryVSOP_OrderBillingForecastAccuracyFamilia.ParamByName( 'MONTHDOC' ).AsInteger := FDQueryVSOP_OrderBillingForecastAccuracyFamilia.ParamByName( 'MONTHDOC' ).AsInteger + 1;
      FDQueryVSOP_OrderBillingForecastAccuracyFamilia.ParamByName( 'YEARDOC' ).AsInteger := FDQueryVSOP_OrderBillingForecastAccuracyFamilia.ParamByName( 'YEARDOC' ).AsInteger -1;

    end;

    if Fr_Brady.SalesRep then
      FDQueryVSOP_OrderBillingForecastAccuracyFamilia.MacroByName( 'WHERE1' ).AsRaw := 'AND (B01.TSOP_ORDBILREPNOM = ' + QuotedStr(Fr_Brady.TSIS_USUNOM) + ' OR B01.TSOP_REPMKT = ' + QuotedStr(Fr_Brady.TSIS_USUNOM) + ' OR B01.TSOP_REPNOMINT = ' + QuotedStr(Fr_Brady.TSIS_USUNOM) + ')';

    if Fr_Brady.CustomerService then
      FDQueryVSOP_OrderBillingForecastAccuracyFamilia.MacroByName( 'WHERE1' ).AsRaw := 'AND B01.TSOP_ORDBILREPCSR = ' + QuotedStr(Fr_Brady.TSIS_USUNOM);

    FDQueryVSOP_OrderBillingForecastAccuracyFamilia.Open;
     }
  finally

    Mensagem( EmptyStr );

  end;

end;

procedure TFr_RelatorioGestaoMercados.Button1Click(Sender: TObject);
begin

  FDQueryVSOP_OrderBillingFaturamento.SQL.SaveToFile( '.\FDQueryVSOP_OrderBillingFaturamento.SQL' );
  FDQueryVSOP_OrderBillingPedidos.SQL.SaveToFile( '.\FDQueryVSOP_OrderBillingPedidos.SQL' );
  FDQueryVSOP_OrderBillingForecastAccuracy.SQL.SaveToFile( '.\FDQueryVSOP_OrderBillingForecastAccuracy.SQL' );
  FDQueryVSOP_OrderBillingForecastAccuracyFamilia.SQL.SaveToFile( '.\FDQueryVSOP_OrderBillingForecastAccuracyFamilia.SQL' );

end;

procedure TFr_RelatorioGestaoMercados.cbxDataPropertiesChange(Sender: TObject);
begin
  if cbxData.ItemIndex = 0 then
     cxLabelData.Caption := 'Data Documento:'
  else cxLabelData.Caption  := 'Data Requerida:';
end;

procedure TFr_RelatorioGestaoMercados.cxButtonRefreshClick(Sender: TObject);
begin
   FDQueryVSOP_OrderBillingPedidos.Close;
   AbrirDataset;
end;

procedure TFr_RelatorioGestaoMercados.cxDBPivotGrid02FieldTSOP_ORDBILVALLIQACCGetDisplayText(
  Sender: TcxPivotGridField; ACell: TcxPivotGridDataCellViewInfo;
  var AText: string);
var
  I: Integer;
  SumSales: Extended;
  SumForecast: Extended;
begin

  for I := 0 to ACell.CrossCell.Records.Count-1 do
  begin

    if not VarIsNull(ACell.CrossCell.DataController.Values[ACell.CrossCell.Records.Items[I],cxDBPivotGrid02FieldTSOP_ORDBILVALLIQSAL.Index]) then
      SumSales := SumSales + ACell.CrossCell.DataController.Values[ACell.CrossCell.Records.Items[I],cxDBPivotGrid02FieldTSOP_ORDBILVALLIQSAL.Index];

    if not VarIsNull(ACell.CrossCell.DataController.Values[ACell.CrossCell.Records.Items[I],cxDBPivotGrid02FieldTSOP_ORDBILVALLIQFOR.Index]) then
    SumForecast := SumForecast + ACell.CrossCell.DataController.Values[ACell.CrossCell.Records.Items[I],cxDBPivotGrid02FieldTSOP_ORDBILVALLIQFOR.Index];

  end;

  AText := '';
  if SumForecast > 0 then
    AText := FormatFloat('#,##0%', SumSales / SumForecast * 100);

end;

procedure TFr_RelatorioGestaoMercados.cxDBPivotGrid03FieldTSOP_ORDBILVALLIQACCGetDisplayText(
  Sender: TcxPivotGridField; ACell: TcxPivotGridDataCellViewInfo;
  var AText: string);
var
  I: Integer;
  SumSales: Extended;
  SumForecast: Extended;
begin

  for I := 0 to ACell.CrossCell.Records.Count-1 do
  begin

    if not VarIsNull(ACell.CrossCell.DataController.Values[ACell.CrossCell.Records.Items[I],cxDBPivotGrid03FieldTSOP_ORDBILVALLIQSAL.Index]) then
      SumSales := SumSales + ACell.CrossCell.DataController.Values[ACell.CrossCell.Records.Items[I],cxDBPivotGrid03FieldTSOP_ORDBILVALLIQSAL.Index];

    if not VarIsNull(ACell.CrossCell.DataController.Values[ACell.CrossCell.Records.Items[I],cxDBPivotGrid03FieldTSOP_ORDBILVALLIQFOR.Index]) then
    SumForecast := SumForecast + ACell.CrossCell.DataController.Values[ACell.CrossCell.Records.Items[I],cxDBPivotGrid03FieldTSOP_ORDBILVALLIQFOR.Index];

  end;

  AText := '';
  if SumForecast > 0 then
    AText := FormatFloat('#,##0%', SumSales / SumForecast * 100);

end;


procedure TFr_RelatorioGestaoMercados.FDQueryVSOP_OrderBillingForecastAccuracyCalcFields(
  DataSet: TDataSet);
begin

  if DataSet.FieldByName('TSOP_ORDBILTYP').AsString = '1 - Vendas' then
    DataSet.FieldByName('TSOP_ORDBILVALLIQSAL').AsFloat := DataSet.FieldByName('TSOP_ORDBILVALLIQ').AsFloat
  else
  if DataSet.FieldByName('TSOP_ORDBILTYP').AsString = '2 - Forecast' then
    DataSet.FieldByName('TSOP_ORDBILVALLIQFOR').AsFloat := DataSet.FieldByName('TSOP_ORDBILVALLIQ').AsFloat;

end;

procedure TFr_RelatorioGestaoMercados.FDQueryVSOP_OrderBillingForecastAccuracyFamiliaCalcFields(
  DataSet: TDataSet);
begin

  if DataSet.FieldByName('TSOP_ORDBILTYP').AsString = '1 - Vendas' then
    DataSet.FieldByName('TSOP_ORDBILVALLIQSAL').AsFloat := DataSet.FieldByName('TSOP_ORDBILVALLIQ').AsFloat
  else
  if DataSet.FieldByName('TSOP_ORDBILTYP').AsString = '2 - Forecast' then
    DataSet.FieldByName('TSOP_ORDBILVALLIQFOR').AsFloat := DataSet.FieldByName('TSOP_ORDBILVALLIQ').AsFloat;

end;

procedure TFr_RelatorioGestaoMercados.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  FDQueryVSOP_OrderBillingPedidos.Close;
  FDQueryVSOP_OrderBillingFaturamento.Close;
  FDConnection.Close;

  Fr_RelatorioGestaoMercados := nil;
  Action := caFree;

end;

procedure TFr_RelatorioGestaoMercados.FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin

  if cxPageControlPivot.ActivePage = cxTabSheetPivot00 then
    Fr_Brady.PopupPivotTools( cxDBPivotGrid000 )
  else
  if cxPageControlPivot.ActivePage = cxTabSheetPivot01 then
    Fr_Brady.PopupPivotTools( cxDBPivotGrid001 );

end;

procedure TFr_RelatorioGestaoMercados.FormCreate(Sender: TObject);
begin

  LoadGridCustomization;

  cxDateEdit_DATINI.Date := System.DateUtils.StartOfTheMonth(Now);
  cxDateEdit_DATFIM.Date := System.DateUtils.EndOfTheMonth(Now);

  cxCheckComboBoxTSOP_CANAL.States[0] := cbsChecked;
  cxCheckComboBoxTSOP_CANAL.States[1] := cbsChecked;

end;

function TFr_RelatorioGestaoMercados.getText(AText: String): String;
begin

  if TextVendas.IsEmpty then
  begin
    Result := 'Vendas';
    TextVendas := AText;
  end
  else
  if TextForecast.IsEmpty then
  begin
    Result := 'Forecast';
    TextForecast := AText;
  end
  else
  begin
    Result := 'Accuracy';
    TextForecast := EmptyStr;
    TextVendas := EmptyStr;
  end;

end;

procedure TFr_RelatorioGestaoMercados.LoadGridCustomization;
begin

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxDBPivotGrid000.Name + '.ini' ) then
    cxDBPivotGrid000.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxDBPivotGrid000.Name + '.ini' );

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxDBPivotGrid001.Name + '.ini' ) then
    cxDBPivotGrid001.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxDBPivotGrid001.Name + '.ini' );

end;

procedure TFr_RelatorioGestaoMercados.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

end.
