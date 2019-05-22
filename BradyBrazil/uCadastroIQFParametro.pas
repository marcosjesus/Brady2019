unit uCadastroIQFParametro;

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
  cxGridBandedTableView, cxGridDBBandedTableView;

type
  TFr_CadastroIQFParametro = class(TForm)
    cxGridIQF_Parametro: TcxGrid;
    cxGridLevelIQF_Parametro: TcxGridLevel;
    DataSourceTIQF_Parametro: TDataSource;
    FDConnection: TFDConnection;
    FDQueryTIQF_Parametro: TFDQuery;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    FDQueryTIQF_ParametroTIQF_PARCOD: TFDAutoIncField;
    FDQueryTIQF_ParametroTIQF_PARENTPRA: TIntegerField;
    FDQueryTIQF_ParametroTIQF_PARRNCEMB: TIntegerField;
    FDQueryTIQF_ParametroTIQF_PARFAL: TIntegerField;
    FDQueryTIQF_ParametroTIQF_PARCER: TIntegerField;
    cxTableViewIQF_Parametro: TcxGridDBBandedTableView;
    FDQueryTIQF_ParametroTIQF_PARDOCMANUAL: TBCDField;
    FDQueryTIQF_ParametroTIQF_PARDOCCER: TBCDField;
    FDQueryTIQF_ParametroTIQF_PARDOCSUPA: TBCDField;
    FDQueryTIQF_ParametroTIQF_PARDOCBALP: TBCDField;
    FDQueryTIQF_ParametroTIQF_PARDOP3045: TBCDField;
    FDQueryTIQF_ParametroTIQF_PARDOP4660: TBCDField;
    FDQueryTIQF_ParametroTIQF_PARDOP6190: TBCDField;
    FDQueryTIQF_ParametroTIQF_PARNFEXML: TBCDField;
    FDQueryTIQF_ParametroTIQF_PARNFENFP: TBCDField;
    FDQueryTIQF_ParametroTIQF_PARNFEVCT: TBCDField;
    FDQueryTIQF_ParametroTIQF_PARNFEDEI: TBCDField;
    cxTableViewIQF_ParametroTIQF_PARCOD: TcxGridDBBandedColumn;
    cxTableViewIQF_ParametroTIQF_PARENTPRA: TcxGridDBBandedColumn;
    cxTableViewIQF_ParametroTIQF_PARDOCMANUAL: TcxGridDBBandedColumn;
    cxTableViewIQF_ParametroTIQF_PARDOCCER: TcxGridDBBandedColumn;
    cxTableViewIQF_ParametroTIQF_PARDOCSUPA: TcxGridDBBandedColumn;
    cxTableViewIQF_ParametroTIQF_PARDOCBALP: TcxGridDBBandedColumn;
    cxTableViewIQF_ParametroTIQF_PARDOP3045: TcxGridDBBandedColumn;
    cxTableViewIQF_ParametroTIQF_PARDOP4660: TcxGridDBBandedColumn;
    cxTableViewIQF_ParametroTIQF_PARDOP6190: TcxGridDBBandedColumn;
    cxTableViewIQF_ParametroTIQF_PARNFEXML: TcxGridDBBandedColumn;
    cxTableViewIQF_ParametroTIQF_PARNFENFP: TcxGridDBBandedColumn;
    cxTableViewIQF_ParametroTIQF_PARNFEVCT: TcxGridDBBandedColumn;
    cxTableViewIQF_ParametroTIQF_PARNFEDEI: TcxGridDBBandedColumn;
    FDQueryTIQF_ParametroTIQF_PARQN: TBCDField;
    cxTableViewIQF_ParametroTIQF_PARQN: TcxGridDBBandedColumn;
    FDQueryTIQF_ParametroTIQF_PARDOP0029: TBCDField;
    cxTableViewIQF_ParametroTIQF_PARDOP0029: TcxGridDBBandedColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    procedure Mensagem( pMensagem: String );
    { Private declarations }
  public
    procedure AbrirDataset;
    procedure LoadGridCustomization;
    { Public declarations }
  end;

var
  Fr_CadastroIQFParametro: TFr_CadastroIQFParametro;

implementation

{$R *.dfm}

uses uUtils, uBrady;

procedure TFr_CadastroIQFParametro.AbrirDataset;
begin

  if not FDConnection.Connected then
  begin

    Mensagem( 'Abrindo conex�o...' );
    try

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

      Mensagem( 'Obtendo dados (IQF Parametros)...' );
      FDQueryTIQF_Parametro.Open;

    finally

      Mensagem( EmptyStr );

    end;

  end;

end;

procedure TFr_CadastroIQFParametro.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  FDQueryTIQF_Parametro.Close;
  FDConnection.Close;

  Fr_CadastroIQFParametro := nil;
  Action := caFree;

end;

procedure TFr_CadastroIQFParametro.FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin

  Fr_Brady.PopupGridTools( cxGridIQF_Parametro.ActiveView );

end;

procedure TFr_CadastroIQFParametro.FormCreate(Sender: TObject);
begin

  LoadGridCustomization;

end;

procedure TFr_CadastroIQFParametro.LoadGridCustomization;
begin

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxTableViewIQF_Parametro.Name + '.ini' ) then
    cxTableViewIQF_Parametro.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxTableViewIQF_Parametro.Name + '.ini' );

end;

procedure TFr_CadastroIQFParametro.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

end.
