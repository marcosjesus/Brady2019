unit uFr_CadastroRegrasIQF;

interface

uses
  System.IOUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinOffice2013White,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxImageComboBox, cxCheckBox, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Comp.Client,
  cxContainer, cxLabel, dxGDIPlusClasses, Vcl.ExtCtrls, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, cxColorComboBox,
  FireDAC.Comp.DataSet;

type
  TFr_CadastroRegraIQF = class(TForm)
    cxGridIQF_Regras: TcxGrid;
    cxTableViewIQF_Regras: TcxGridDBTableView;
    cxGridLevelIQF_Regras: TcxGridLevel;
    FDConnection: TFDConnection;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    DataSourceTIQF_Regra: TDataSource;
    FDQueryTIQF_Regra: TFDQuery;
    FDQueryTIQF_RegraTIQF_REGRACOD: TFDAutoIncField;
    FDQueryTIQF_RegraTITULO: TStringField;
    FDQueryTIQF_RegraVALOR_MINIMO: TBCDField;
    FDQueryTIQF_RegraVALOR_MAXIMO: TBCDField;
    FDQueryTIQF_RegraCOR: TStringField;
    cxTableViewIQF_RegrasTITULO: TcxGridDBColumn;
    cxTableViewIQF_RegrasVALOR_MINIMO: TcxGridDBColumn;
    cxTableViewIQF_RegrasVALOR_MAXIMO: TcxGridDBColumn;
    cxTableViewIQF_RegrasCOR: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure Mensagem( pMensagem: String );

    { Private declarations }
  public
    { Public declarations }
    procedure AbrirDataset;
    procedure LoadGridCustomization;
  end;

var
  Fr_CadastroRegraIQF: TFr_CadastroRegraIQF;

implementation

{$R *.dfm}

uses uUtils, uBrady;

procedure TFr_CadastroRegraIQF.AbrirDataset;
begin

  if not FDConnection.Connected then
  begin

    Mensagem( 'Abrindo conexão...' );
    try

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

      Mensagem( 'Obtendo dados (IQF Regras)...' );
      FDQueryTIQF_Regra.Open;

    finally

      Mensagem( EmptyStr );

    end;

  end;

end;


procedure TFr_CadastroRegraIQF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FDConnection.Close;

  Fr_CadastroRegraIQF := nil;
  Action := caFree;
end;

procedure TFr_CadastroRegraIQF.FormCreate(Sender: TObject);
begin
  LoadGridCustomization;
end;

procedure TFr_CadastroRegraIQF.LoadGridCustomization;
begin

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxTableViewIQF_Regras.Name + '.ini' ) then
    cxTableViewIQF_Regras.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxTableViewIQF_Regras.Name + '.ini' );

end;


procedure TFr_CadastroRegraIQF.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

end.
