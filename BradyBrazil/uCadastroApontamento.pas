unit uCadastroApontamento;

interface

uses
  System.IOUtils,
  System.DateUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxCheckComboBox,
  cxCalendar, cxTimeEdit, cxCheckBox, cxContainer, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxLabel, dxGDIPlusClasses, Vcl.ExtCtrls,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  dxSkinOffice2013White, dxBarBuiltInMenu, Vcl.ComCtrls, dxCore, cxDateUtils, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxPC, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
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
  dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TFr_CadastroApontamento = class(TForm)
    cxGridApontamento: TcxGrid;
    cxGridLevelApontamento: TcxGridLevel;
    cxTableViewApontamento: TcxGridDBTableView;
    DataSourceTMAQ_Apontamento: TDataSource;
    FDConnection: TFDConnection;
    FDQueryTMAQ_Apontamento: TFDQuery;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    FDQueryTMAQ_ApontamentoTMAQ_APOCOD: TFDAutoIncField;
    FDQueryTMAQ_ApontamentoTMAQ_APOKEY: TStringField;
    FDQueryTMAQ_ApontamentoTMAQ_MAQCOD: TIntegerField;
    FDQueryTMAQ_ApontamentoTMAQ_ATICOD: TIntegerField;
    FDQueryTMAQ_ApontamentoTMAQ_APODATINI: TSQLTimeStampField;
    FDQueryTMAQ_ApontamentoTMAQ_APOMIN: TIntegerField;
    FDQueryTMAQ_ApontamentoTMAQ_APOOSE: TStringField;
    FDQueryTMAQ_ApontamentoTMAQ_APOITE: TStringField;
    FDQueryTMAQ_ApontamentoTMAQ_APOQTD: TIntegerField;
    FDQueryTMAQ_ApontamentoTMAQ_APOMET: TBCDField;
    FDQueryTMAQ_ApontamentoTMAQ_APOENCOSE: TStringField;
    FDQueryTMAQ_ApontamentoTMAQ_APOOBS: TStringField;
    cxTableViewApontamentoTMAQ_APOCOD: TcxGridDBColumn;
    cxTableViewApontamentoTMAQ_APOMIN: TcxGridDBColumn;
    cxTableViewApontamentoTMAQ_APOOSE: TcxGridDBColumn;
    cxTableViewApontamentoTMAQ_APOITE: TcxGridDBColumn;
    cxTableViewApontamentoTMAQ_APOQTD: TcxGridDBColumn;
    cxTableViewApontamentoTMAQ_APOMET: TcxGridDBColumn;
    cxTableViewApontamentoTMAQ_APOENCOSE: TcxGridDBColumn;
    cxTableViewApontamentoTMAQ_APOOBS: TcxGridDBColumn;
    FDQueryTMAQ_MaquinaLookup: TFDQuery;
    FDQueryTMAQ_MaquinaLookupTMAQ_MAQCOD: TFDAutoIncField;
    FDQueryTMAQ_MaquinaLookupTMAQ_MAQNOM: TStringField;
    FDQueryTMAQ_AtividadeLookup: TFDQuery;
    FDQueryTMAQ_AtividadeLookupTMAQ_ATICOD: TFDAutoIncField;
    FDQueryTMAQ_AtividadeLookupTMAQ_ATINOM: TStringField;
    FDQueryTMAQ_ApontamentoTMAQ_MAQNOM: TStringField;
    FDQueryTMAQ_ApontamentoTMAQ_ATINOM: TStringField;
    cxTableViewApontamentoTMAQ_MAQNOM: TcxGridDBColumn;
    cxTableViewApontamentoTMAQ_ATINOM: TcxGridDBColumn;
    cxTableViewApontamentoTMAQ_APODAT: TcxGridDBColumn;
    cxTableViewApontamentoTMAQ_APOTIM: TcxGridDBColumn;
    FDQueryTMAQ_ApontamentoTMAQ_APODAT: TSQLTimeStampField;
    FDQueryTMAQ_ApontamentoTMAQ_APOTIM: TSQLTimeStampField;
    FDQueryTMAQ_ApontamentoTMAQ_APOOPE: TStringField;
    cxTableViewApontamentoTMAQ_APOOPE: TcxGridDBColumn;
    FDQueryTMAQ_OperadorLookup: TFDQuery;
    FDQueryTMAQ_OperadorLookupTMAQ_OPECOD: TFDAutoIncField;
    FDQueryTMAQ_OperadorLookupTMAQ_OPEBAR: TStringField;
    FDQueryTMAQ_OperadorLookupTMAQ_SITCOD: TIntegerField;
    FDQueryTMAQ_OperadorLookupTMAQ_OPENOM: TStringField;
    cxPageControlFiltro: TcxPageControl;
    cxTabSheetFiltro: TcxTabSheet;
    cxLabelDataInicial: TcxLabel;
    cxDateEditTMAQ_APODATINI: TcxDateEdit;
    cxLabelDataFinal: TcxLabel;
    cxDateEditTMAQ_APODATFIM: TcxDateEdit;
    cxButtonRefresh: TcxButton;
    FDQueryTMAQ_MaquinaLookupTMAQ_SITNOM: TStringField;
    FDQueryTMAQ_ApontamentoTMAQ_SITNOM: TStringField;
    cxTableViewApontamentoTMAQ_SITNOM: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FDQueryTMAQ_ApontamentoNewRecord(DataSet: TDataSet);
    procedure FDQueryTMAQ_ApontamentoTMAQ_APODATValidate(Sender: TField);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure cxButtonRefreshClick(Sender: TObject);
  private
    procedure Mensagem( pMensagem: String );
    { Private declarations }
  public
    procedure AbrirDataset;
    procedure LoadGridCustomization;
    { Public declarations }
  end;

var
  Fr_CadastroApontamento: TFr_CadastroApontamento;

implementation

{$R *.dfm}

uses uUtils, uBrady;

procedure TFr_CadastroApontamento.AbrirDataset;
begin

  if not FDConnection.Connected then
  begin

    Mensagem( 'Abrindo conex�o...' );
    try
      FDConnection.Close;
      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

      Mensagem( 'Obtendo dados (Operador)...' );
      FDQueryTMAQ_OperadorLookup.Close;
      FDQueryTMAQ_OperadorLookup.Open;
      FDQueryTMAQ_OperadorLookup.First;

      while not FDQueryTMAQ_OperadorLookup.Eof do
      begin

        with TcxCheckComboBoxProperties(cxTableViewApontamentoTMAQ_APOOPE.Properties).Items.Add do
        begin

          Description := FDQueryTMAQ_OperadorLookupTMAQ_OPEBAR.AsString + ' - ' + FDQueryTMAQ_OperadorLookupTMAQ_OPENOM.AsString;
          ShortDescription := FDQueryTMAQ_OperadorLookupTMAQ_OPENOM.AsString;

        end;

        FDQueryTMAQ_OperadorLookup.Next;

      end;

      Mensagem( 'Obtendo dados (Atividade)...' );
      FDQueryTMAQ_AtividadeLookup.Close;
      FDQueryTMAQ_AtividadeLookup.Open;

      Mensagem( 'Obtendo dados (M�quina)...' );
      FDQueryTMAQ_MaquinaLookup.Close;
      FDQueryTMAQ_MaquinaLookup.Open;

      Mensagem( 'Obtendo dados (Apontamento)...' );
      FDQueryTMAQ_Apontamento.Close;
      FDQueryTMAQ_Apontamento.ParamByName('TMAQ_APODATINI').AsDateTime := cxDateEditTMAQ_APODATINI.Date;
      FDQueryTMAQ_Apontamento.ParamByName('TMAQ_APODATFIM').AsDateTime := cxDateEditTMAQ_APODATFIM.Date;
      try
        FDQueryTMAQ_Apontamento.Open;
      except
        on E: Exception do
         begin
          Application.MessageBox( PWideChar(E.Message), 'Mensagem de Erro', mb_iconinformation + mb_ok );

        end;
      end;


    finally

      Mensagem( EmptyStr );

    end;

  end;

end;

procedure TFr_CadastroApontamento.cxButtonRefreshClick(Sender: TObject);
begin

  FDQueryTMAQ_Apontamento.Close;
  FDConnection.Close;
  AbrirDataset;

end;

procedure TFr_CadastroApontamento.FDQueryTMAQ_ApontamentoNewRecord(DataSet: TDataSet);
var
  varGUID: TGUID;

begin

  CreateGUID(varGUID);
  FDQueryTMAQ_Apontamento.FieldByName('TMAQ_APOKEY').AsString := GUIDToString(varGUID);
  FDQueryTMAQ_Apontamento.FieldByName('TMAQ_APOENCOSE').AsString := 'N';

end;

procedure TFr_CadastroApontamento.FDQueryTMAQ_ApontamentoTMAQ_APODATValidate(Sender: TField);
begin

  FDQueryTMAQ_Apontamento.FieldByName('TMAQ_APODATINI').AsDateTime :=
       Trunc(FDQueryTMAQ_Apontamento.FieldByName('TMAQ_APODAT').AsDateTime) +
       Frac(FDQueryTMAQ_Apontamento.FieldByName('TMAQ_APOTIM').AsDateTime);

end;

procedure TFr_CadastroApontamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  FDQueryTMAQ_MaquinaLookup.Close;
  FDQueryTMAQ_OperadorLookup.Close;
  FDQueryTMAQ_AtividadeLookup.Close;
  FDQueryTMAQ_Apontamento.Close;
  FDConnection.Close;

  Fr_CadastroApontamento := nil;
  Action := caFree;

end;

procedure TFr_CadastroApontamento.FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin

  Fr_Brady.PopupGridTools( cxGridApontamento.ActiveView );

end;

procedure TFr_CadastroApontamento.FormCreate(Sender: TObject);
begin

  LoadGridCustomization;

  cxDateEditTMAQ_APODATINI.Date := StartOfTheMonth(Now);
  cxDateEditTMAQ_APODATFIM.Date := EndOfTheMonth(Now);

end;

procedure TFr_CadastroApontamento.LoadGridCustomization;
begin

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxTableViewApontamento.Name + '.ini' ) then
    cxTableViewApontamento.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxTableViewApontamento.Name + '.ini' );

end;

procedure TFr_CadastroApontamento.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

end.
