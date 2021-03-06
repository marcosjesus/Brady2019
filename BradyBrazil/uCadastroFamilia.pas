unit uCadastroFamilia;

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
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TFr_CadastroFamilia = class(TForm)
    cxGridFamilia: TcxGrid;
    cxGridLevelFamilia: TcxGridLevel;
    cxTableViewFamilia: TcxGridDBTableView;
    DataSourceTSOP_Familia: TDataSource;
    FDConnection: TFDConnection;
    FDQueryTSOP_Familia: TFDQuery;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    FDQueryTSOP_FamiliaTSOP_FAMCOD: TFDAutoIncField;
    FDQueryTSOP_FamiliaTSOP_ORICOD: TIntegerField;
    FDQueryTSOP_FamiliaTSOP_USUCODCAD: TIntegerField;
    FDQueryTSOP_FamiliaTSOP_FAMDATCAD: TSQLTimeStampField;
    FDQueryTSOP_FamiliaTSOP_USUCODALT: TIntegerField;
    FDQueryTSOP_FamiliaTSOP_FAMDATALT: TSQLTimeStampField;
    cxTableViewFamiliaTSOP_FAMCOD: TcxGridDBColumn;
    FDQueryTSOP_FamiliaTSOP_FAMITECOD: TStringField;
    FDQueryTSOP_FamiliaTSOP_FAMCOD001: TStringField;
    FDQueryTSOP_FamiliaTSOP_FAMCOD002: TStringField;
    FDQueryTSOP_FamiliaTSOP_FAMCOD003: TStringField;
    FDQueryTSOP_FamiliaTSOP_FAMCOD004: TStringField;
    FDQueryTSOP_FamiliaTSOP_FAMCOD005: TStringField;
    FDQueryTSOP_FamiliaTSOP_FAMATUIMP: TStringField;
    FDQueryTSOP_FamiliaTSOP_FAMNOM: TStringField;
    cxTableViewFamiliaTSOP_FAMITECOD: TcxGridDBColumn;
    cxTableViewFamiliaTSOP_FAMNOM: TcxGridDBColumn;
    cxTableViewFamiliaTSOP_FAMCOD001: TcxGridDBColumn;
    cxTableViewFamiliaTSOP_FAMCOD002: TcxGridDBColumn;
    cxTableViewFamiliaTSOP_FAMCOD003: TcxGridDBColumn;
    cxTableViewFamiliaTSOP_FAMCOD004: TcxGridDBColumn;
    cxTableViewFamiliaTSOP_FAMCOD005: TcxGridDBColumn;
    cxTableViewFamiliaTSOP_FAMATUIMP: TcxGridDBColumn;
    FDQueryTSOP_FamiliaTSOP_FAMNOMPAI: TStringField;
    cxTableViewFamiliaTSOP_FAMNOMPAI: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FDQueryTSOP_FamiliaNewRecord(DataSet: TDataSet);
    procedure FDQueryTSOP_FamiliaAfterEdit(DataSet: TDataSet);
  private
    procedure Mensagem( pMensagem: String );
    { Private declarations }
  public
    procedure AbrirDataset;
    procedure LoadGridCustomization;
    { Public declarations }
  end;

var
  Fr_CadastroFamilia: TFr_CadastroFamilia;

implementation

{$R *.dfm}

uses uUtils, uBrady;

procedure TFr_CadastroFamilia.AbrirDataset;
begin

  if not FDConnection.Connected then
  begin

    Mensagem( 'Abrindo conex�o...' );
    try

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

      Mensagem( 'Obtendo dados (Fam�lia)...' );
      FDQueryTSOP_Familia.Open;

    finally

      Mensagem( EmptyStr );

    end;

  end;

end;

procedure TFr_CadastroFamilia.FDQueryTSOP_FamiliaAfterEdit(DataSet: TDataSet);
begin

  FDQueryTSOP_FamiliaTSOP_ORICOD.AsInteger := 1;
  FDQueryTSOP_FamiliaTSOP_USUCODALT.AsInteger := 1;
  FDQueryTSOP_FamiliaTSOP_FAMDATALT.AsDateTime := Now;

end;

procedure TFr_CadastroFamilia.FDQueryTSOP_FamiliaNewRecord(DataSet: TDataSet);
begin

  FDQueryTSOP_FamiliaTSOP_ORICOD.AsInteger := 1;
  FDQueryTSOP_FamiliaTSOP_FAMATUIMP.AsString := 'S';
  FDQueryTSOP_FamiliaTSOP_USUCODCAD.AsInteger := 1;
  FDQueryTSOP_FamiliaTSOP_USUCODALT.AsInteger := 1;
  FDQueryTSOP_FamiliaTSOP_FAMDATCAD.AsDateTime := Now;
  FDQueryTSOP_FamiliaTSOP_FAMDATALT.AsDateTime := Now;

end;

procedure TFr_CadastroFamilia.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  FDQueryTSOP_Familia.Close;
  FDConnection.Close;

  Fr_CadastroFamilia := nil;
  Action := caFree;

end;

procedure TFr_CadastroFamilia.FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin

  Fr_Brady.PopupGridTools( cxGridFamilia.ActiveView );

end;

procedure TFr_CadastroFamilia.FormCreate(Sender: TObject);
begin

  LoadGridCustomization;

end;

procedure TFr_CadastroFamilia.LoadGridCustomization;
begin

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxTableViewFamilia.Name + '.ini' ) then
    cxTableViewFamilia.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxTableViewFamilia.Name + '.ini' );

end;

procedure TFr_CadastroFamilia.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

end.
