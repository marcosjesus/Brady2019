unit uCadastroGrupoCliente;

interface

uses
  System.IOUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxCheckBox,
  cxContainer, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxLabel, dxGDIPlusClasses, Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, dxSkinOffice2013White,
  cxHyperLinkEdit, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
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
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TFr_CadastroGrupoCliente = class(TForm)
    cxGridGrupoCliente: TcxGrid;
    cxGridLevelGrupoCliente: TcxGridLevel;
    cxTableViewGrupoCliente: TcxGridDBTableView;
    DataSourceTSOP_GrupoCliente: TDataSource;
    FDConnection: TFDConnection;
    FDQueryTSOP_GrupoCliente: TFDQuery;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    FDQueryTSOP_GrupoClienteTSOP_GRUCLICOD: TFDAutoIncField;
    FDQueryTSOP_GrupoClienteTSOP_ORICOD: TIntegerField;
    FDQueryTSOP_GrupoClienteTSOP_USUCODCAD: TIntegerField;
    FDQueryTSOP_GrupoClienteTSOP_GRUCLIDATCAD: TSQLTimeStampField;
    FDQueryTSOP_GrupoClienteTSOP_USUCODALT: TIntegerField;
    FDQueryTSOP_GrupoClienteTSOP_GRUCLIDATALT: TSQLTimeStampField;
    cxTableViewGrupoClienteTSOP_GRUCLICOD: TcxGridDBColumn;
    FDQueryTSOP_GrupoClienteTSOP_GRUCLIATUIMP: TStringField;
    FDQueryTSOP_GrupoClienteTSOP_GRUCLINOM: TStringField;
    cxTableViewGrupoClienteTSOP_GRUCLINOM: TcxGridDBColumn;
    cxTableViewGrupoClienteTSOP_GRUCLIATUIMP: TcxGridDBColumn;
    FDQueryTSOP_GrupoClienteTSOP_GRUCLICLICOD: TStringField;
    FDQueryTSOP_GrupoClienteTSOP_GRUCLIMER: TStringField;
    cxTableViewGrupoClienteTSOP_GRUCLICLICOD: TcxGridDBColumn;
    cxTableViewGrupoClienteTSOP_GRUCLIMER: TcxGridDBColumn;
    FDQueryTSOP_GrupoClienteTSOP_SUSPENDER: TStringField;
    FDQueryTSOP_GrupoClienteTSOP_LINKSALESFORCE: TStringField;
    cxTableViewGrupoClienteTSOP_SUSPENDER: TcxGridDBColumn;
    cxTableViewGrupoClienteTSOP_LINKSALESFORCE: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FDQueryTSOP_GrupoClienteNewRecord(DataSet: TDataSet);
    procedure FDQueryTSOP_GrupoClienteAfterEdit(DataSet: TDataSet);
    procedure cxTableViewGrupoClienteCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    procedure Mensagem( pMensagem: String );
    { Private declarations }
  public
    procedure AbrirDataset;
    procedure LoadGridCustomization;
    { Public declarations }
  end;

var
  Fr_CadastroGrupoCliente: TFr_CadastroGrupoCliente;

implementation

{$R *.dfm}

uses uUtils, uBrady, ShellAPI;

procedure TFr_CadastroGrupoCliente.AbrirDataset;
begin

  if not FDConnection.Connected then
  begin

    Mensagem( 'Abrindo conex�o...' );
    try

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

      Mensagem( 'Obtendo dados (Grupo de Cliente)...' );
      FDQueryTSOP_GrupoCliente.Open;

    finally

      Mensagem( EmptyStr );

    end;

  end;

end;

procedure TFr_CadastroGrupoCliente.cxTableViewGrupoClienteCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  AValue, aURL: string;
begin

  if FDQueryTSOP_GrupoCliente.IsEmpty then
     raise Exception.Create('N�o h� dados na Grid.');

  if FDQueryTSOP_GrupoClienteTSOP_LINKSALESFORCE.AsString = '' then
     raise Exception.Create('N�o h� link cadastrado para este cliente.');

  if (ACellViewInfo.Item = cxTableViewGrupoClienteTSOP_GRUCLICLICOD) and (AButton = mbLeft) then
  begin
    aURL := 'https://insidebrady.okta.com/home/salesforce/0oa1kietmbVQZCMLGIOU/46';
    AValue := FDQueryTSOP_GrupoClienteTSOP_LINKSALESFORCE.AsString;
    ShellExecute(0, 'OPEN', PChar(aURL), nil, nil, SW_SHOWMAXIMIZED);
    Sleep(4000);
    ShellExecute(0, 'OPEN', PChar(AValue), nil, nil, SW_SHOWMAXIMIZED);
  end;

end;

procedure TFr_CadastroGrupoCliente.FDQueryTSOP_GrupoClienteAfterEdit(DataSet: TDataSet);
begin

  FDQueryTSOP_GrupoClienteTSOP_ORICOD.AsInteger := 1;
  FDQueryTSOP_GrupoClienteTSOP_USUCODALT.AsInteger := 1;
  FDQueryTSOP_GrupoClienteTSOP_GRUCLIDATALT.AsDateTime := Now;

end;

procedure TFr_CadastroGrupoCliente.FDQueryTSOP_GrupoClienteNewRecord(DataSet: TDataSet);
begin

  FDQueryTSOP_GrupoClienteTSOP_ORICOD.AsInteger := 1;
  FDQueryTSOP_GrupoClienteTSOP_GRUCLIATUIMP.AsString := 'S';
  FDQueryTSOP_GrupoClienteTSOP_SUSPENDER.AsString := 'N';
  FDQueryTSOP_GrupoClienteTSOP_USUCODCAD.AsInteger := 1;
  FDQueryTSOP_GrupoClienteTSOP_USUCODALT.AsInteger := 1;
  FDQueryTSOP_GrupoClienteTSOP_GRUCLIDATCAD.AsDateTime := Now;
  FDQueryTSOP_GrupoClienteTSOP_GRUCLIDATALT.AsDateTime := Now;

end;

procedure TFr_CadastroGrupoCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  FDQueryTSOP_GrupoCliente.Close;
  FDConnection.Close;

  Fr_CadastroGrupoCliente := nil;
  Action := caFree;

end;

procedure TFr_CadastroGrupoCliente.FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin

  Fr_Brady.PopupGridTools( cxGridGrupoCliente.ActiveView );

end;

procedure TFr_CadastroGrupoCliente.FormCreate(Sender: TObject);
begin

  LoadGridCustomization;

end;

procedure TFr_CadastroGrupoCliente.LoadGridCustomization;
begin

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxTableViewGrupoCliente.Name + '.ini' ) then
    cxTableViewGrupoCliente.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxTableViewGrupoCliente.Name + '.ini' );

end;

procedure TFr_CadastroGrupoCliente.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

end.
