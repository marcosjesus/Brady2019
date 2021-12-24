unit uCadastroSetonForecast;

interface

uses
  System.IOUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxContainer,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxLabel, dxGDIPlusClasses, Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, dxSkinOffice2013White,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
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
  Vcl.Menus, Vcl.StdCtrls, cxButtons, Vcl.ComCtrls, cxGroupBox, cxRadioGroup;

type
  TFr_CadastroSetonForecast = class(TForm)
    cxGridSetonForecast: TcxGrid;
    cxGridLevelSetonForecast: TcxGridLevel;
    cxTableViewSetonForecast: TcxGridDBTableView;
    DataSourceTSTOP_SetonForecast: TDataSource;
    FDConnection: TFDConnection;
    FDQueryTSOP_SetonForecast: TFDQuery;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    FDQueryTSOP_SetonForecastTSOP_SETON_FORECASTCOD: TFDAutoIncField;
    FDQueryTSOP_SetonForecastTSOP_DPACANTXTDEP: TStringField;
    FDQueryTSOP_SetonForecastTSOP_PERIODO: TDateField;
    FDQueryTSOP_SetonForecastTSOP_VALOR_FORECAST: TBCDField;
    cxTableViewSetonForecastTSOP_DPACANTXTDEP: TcxGridDBColumn;
    cxTableViewSetonForecastTSOP_PERIODO: TcxGridDBColumn;
    cxTableViewSetonForecastTSOP_VALOR_FORECAST: TcxGridDBColumn;
    cxTableViewSetonForecastTSOP_SETON_FORECASTCOD: TcxGridDBColumn;
    FDQueryTSOP_SetonForecastTSOP_USUCOD: TIntegerField;
    FDQueryTSOP_SetonForecastTSIS_USUNOM: TStringField;
    cxTableViewSetonForecastTSIS_USUNOM: TcxGridDBColumn;
    Panel1: TPanel;
    cxLabel1: TcxLabel;
    DtInicial: TDateTimePicker;
    RgFiltro: TcxRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FDQueryTSOP_SetonForecastAfterInsert(DataSet: TDataSet);
    procedure RgFiltroClick(Sender: TObject);
  private
    procedure Mensagem( pMensagem: String );
    { Private declarations }
  public
    procedure AbrirDataset;
    procedure LoadGridCustomization;
    { Public declarations }
  end;

var
  Fr_CadastroSetonForecast: TFr_CadastroSetonForecast;

implementation

{$R *.dfm}

uses uUtils, uBrady;

procedure TFr_CadastroSetonForecast.AbrirDataset;
begin

  if not FDConnection.Connected then
  begin

    Mensagem( 'Abrindo conex�o...' );
    try

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

      Mensagem( 'Obtendo dados (Forecast Seton (DM))...' );
      FDQueryTSOP_SetonForecast.Close;
      FDQueryTSOP_SetonForecast.SQL.Clear;
      FDQueryTSOP_SetonForecast.SQL.Add('SELECT A01.*, U.TSIS_USUNOM  ');
      FDQueryTSOP_SetonForecast.SQL.Add('FROM TSOP_SetonForecast A01  ');
      FDQueryTSOP_SetonForecast.SQL.Add('LEFT OUTER JOIN TSIS_USUARIO U ON U.TSIS_USUCOD = A01.TSOP_USUCOD ');
      FDQueryTSOP_SetonForecast.SQL.Add(' WHERE 1 = 1 ');

      if (Fr_Brady.SalesRep) then
       FDQueryTSOP_SetonForecast.SQL.Add('AND A01.TSOP_USUCOD = ' + IntToStr(Fr_Brady.TSIS_USUCOD));


      FDQueryTSOP_SetonForecast.SQL.Add('ORDER BY A01.TSOP_PERIODO  ');
      FDQueryTSOP_SetonForecast.Open;

    finally

      Mensagem( EmptyStr );

    end;

  end;

end;

procedure TFr_CadastroSetonForecast.RgFiltroClick(Sender: TObject);
var
 Ano, Mes, Dia: Word;
begin

    DecodeDate(DtInicial.Date, Ano, Mes, Dia);
    Mensagem( 'Abrindo conex�o...' );
    try

      Mensagem( 'Filtrando Dados por M�s e Ano...' );
      FDQueryTSOP_SetonForecast.Close;
      FDQueryTSOP_SetonForecast.SQL.Clear;
      FDQueryTSOP_SetonForecast.SQL.Add('SELECT A01.*, U.TSIS_USUNOM  ');
      FDQueryTSOP_SetonForecast.SQL.Add('FROM TSOP_SetonForecast A01  ');
      FDQueryTSOP_SetonForecast.SQL.Add('LEFT OUTER JOIN TSIS_USUARIO U ON U.TSIS_USUCOD = A01.TSOP_USUCOD ');
      FDQueryTSOP_SetonForecast.SQL.Add(' WHERE 1 = 1 ');


      if (Fr_Brady.SalesRep) then
       FDQueryTSOP_SetonForecast.SQL.Add ('AND A01.TSOP_USUCOD = ' + IntToStr(Fr_Brady.TSIS_USUCOD));

      if RgFiltro.ItemIndex = 0 then
      begin

        FDQueryTSOP_SetonForecast.SQL.Add('AND  CONVERT(VARCHAR(2),DATEPART(MONTH,A01.TSOP_PERIODO)) = :MES ');
        FDQueryTSOP_SetonForecast.SQL.Add('AND  CONVERT(VARCHAR(4),DATEPART(YEAR,A01.TSOP_PERIODO)) = :ANO  ');


       if (Fr_Brady.SalesRep) then
         FDQueryTSOP_SetonForecast.SQL.Add ('AND A01.TSOP_USUCOD = ' + IntToStr(Fr_Brady.TSIS_USUCOD));


        FDQueryTSOP_SetonForecast.Params.ParamByName('MES').AsInteger := Mes;
        FDQueryTSOP_SetonForecast.Params.ParamByName('ANO').AsInteger := Ano;

      end;

      FDQueryTSOP_SetonForecast.SQL.Add('ORDER BY A01.TSOP_PERIODO  ');
      FDQueryTSOP_SetonForecast.Open;

    finally

      Mensagem( EmptyStr );

    end;


end;

procedure TFr_CadastroSetonForecast.FDQueryTSOP_SetonForecastAfterInsert(
  DataSet: TDataSet);
begin
   FDQueryTSOP_SetonForecastTSOP_DPACANTXTDEP.AsString := 'DM';
   FDQueryTSOP_SetonForecastTSOP_USUCOD.AsInteger := Fr_Brady.TSIS_USUCOD;
end;

procedure TFr_CadastroSetonForecast.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  FDQueryTSOP_SetonForecast.Close;
  FDConnection.Close;

  Fr_CadastroSetonForecast := nil;
  Action := caFree;

end;

procedure TFr_CadastroSetonForecast.FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin

  Fr_Brady.PopupGridTools( cxGridSetonForecast.ActiveView );

end;

procedure TFr_CadastroSetonForecast.FormCreate(Sender: TObject);
begin

  LoadGridCustomization;

  DtInicial.Date := now;

end;

procedure TFr_CadastroSetonForecast.LoadGridCustomization;
begin

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxTableViewSetonForecast.Name + '.ini' ) then
    cxTableViewSetonForecast.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxTableViewSetonForecast.Name + '.ini' );

end;

procedure TFr_CadastroSetonForecast.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

end.
