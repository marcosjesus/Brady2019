unit uConfig;

interface

uses
  System.IOUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinOffice2013White,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Comp.Client, cxContainer, cxLabel, dxGDIPlusClasses,
  Vcl.ExtCtrls, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, cxButtonEdit;

type
  TFConfig = class(TForm)
    cxGridConfig: TcxGrid;
    cxTableViewConfig: TcxGridDBTableView;
    cxGridLevelConfig: TcxGridLevel;
    FDConnection: TFDConnection;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    FDQueryTSOP_ConfigMKT: TFDQuery;
    DataSourceTSOP_ConfigMKT: TDataSource;
    FDQueryTSOP_ConfigMKTTSOP_MKT_PARAM: TFDAutoIncField;
    FDQueryTSOP_ConfigMKTTSOP_MKT_CHAVE: TStringField;
    FDQueryTSOP_ConfigMKTTSOP_MKT_VALOR: TStringField;
    FDQueryTSOP_ConfigMKTTSOP_MKT_DATCAD: TSQLTimeStampField;
    cxTableViewConfigTSOP_MKT_CHAVE: TcxGridDBColumn;
    cxTableViewConfigTSOP_MKT_VALOR: TcxGridDBColumn;
    FDQueryTSOP_ConfigMKTTSOP_MKT_LOGO: TStringField;
    cxTableViewConfigTSOP_MKT_LOGO: TcxGridDBColumn;
    SaveDialog: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxTableViewConfigTSOP_MKT_LOGOPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
  private

    procedure LoadGridCustomization;
    procedure Mensagem(pMensagem: String);
    { Private declarations }
  public
    { Public declarations }
    procedure AbrirDataset;
  end;

var
  FConfig: TFConfig;

implementation

{$R *.dfm}

uses uUtils, uBrady;



procedure TFConfig.AbrirDataset;
begin

  if not FDConnection.Connected then
  begin

    Mensagem( 'Abrindo conex�o...' );
    try

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

      Mensagem( 'Obtendo dados (Config)...' );
      FDQueryTSOP_ConfigMKT.Open;

    finally

      Mensagem( EmptyStr );

    end;

  end;

end;

procedure TFConfig.cxTableViewConfigTSOP_MKT_LOGOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
   if SaveDialog.Execute then
   begin
      FDQueryTSOP_ConfigMKT.Edit;
      FDQueryTSOP_ConfigMKTTSOP_MKT_LOGO.AsString := SaveDialog.FileName;
      FDQueryTSOP_ConfigMKT.Post;
   end;
end;

procedure TFConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FDQueryTSOP_ConfigMKT.Close;
  FDConnection.Close;

  FConfig := nil;
  Action := caFree;
end;

procedure TFConfig.FormContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  Fr_Brady.PopupGridTools( cxGridConfig.ActiveView );
end;

procedure TFConfig.FormCreate(Sender: TObject);
begin
  LoadGridCustomization;
end;

procedure TFConfig.LoadGridCustomization;
begin

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxTableViewConfig.Name + '.ini' ) then
    cxTableViewConfig.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxTableViewConfig.Name + '.ini' );

end;

procedure TFConfig.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

end.
