unit uFr_CadastroIQFCategoria;

interface

uses
  System.IOUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinOffice2013White,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxContainer, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxLabel, dxGDIPlusClasses, Vcl.ExtCtrls, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
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
  TFr_CadastroIQFCategoria = class(TForm)
    FDConnection: TFDConnection;
    FDQueryIQF_Categoria: TFDQuery;
    DataSourceCategoria: TDataSource;
    FDQueryIQF_CategoriaTIQF_Categoria_ID: TFDAutoIncField;
    cxGridIQF_Categoria: TcxGrid;
    cxTableViewIQF_Categoria: TcxGridDBTableView;
    cxGridLevelIQF_Categoria: TcxGridLevel;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    cxTableViewIQF_CategoriaTIQF_Categoria_ID: TcxGridDBColumn;
    cxTableViewIQF_CategoriaTIQF_Categoria_Descricao: TcxGridDBColumn;
    FDQueryIQF_CategoriaTIQF_Categoria_Descricao: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    procedure Mensagem(pMensagem: String);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure LoadGridCustomization;
    { Private declarations }
  public
    { Public declarations }
     procedure AbrirDataset;
  end;

var
  Fr_CadastroIQFCategoria: TFr_CadastroIQFCategoria;

implementation

{$R *.dfm}

uses uUtils, uBrady;

{ TFr_CadastroIQFCategoria }

procedure TFr_CadastroIQFCategoria.AbrirDataset;
begin
  if not FDConnection.Connected then
  begin

    Mensagem( 'Abrindo conexão...' );
    try

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

      Mensagem( 'Obtendo dados (IQF Categoria)...' );
      FDQueryIQF_Categoria.Open;

    finally

      Mensagem( EmptyStr );

    end;

  end;
end;

procedure TFr_CadastroIQFCategoria.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FDQueryIQF_Categoria.Close;
  FDConnection.Close;

  Fr_CadastroIQFCategoria := nil;
  Action := caFree;
end;

procedure TFr_CadastroIQFCategoria.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

procedure TFr_CadastroIQFCategoria.FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin

  Fr_Brady.PopupGridTools( cxGridIQF_Categoria.ActiveView );

end;

procedure TFr_CadastroIQFCategoria.FormCreate(Sender: TObject);
begin
   LoadGridCustomization;
end;

procedure TFr_CadastroIQFCategoria.LoadGridCustomization;
begin

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxTableViewIQF_Categoria.Name + '.ini' ) then
    cxTableViewIQF_Categoria.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxTableViewIQF_Categoria.Name + '.ini' );

end;

end.
