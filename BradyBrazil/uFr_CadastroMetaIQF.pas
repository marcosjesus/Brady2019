unit uFr_CadastroMetaIQF;

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
  FireDAC.Comp.DataSet, cxCalendar;

type
  TFr_CadastroMetaIQF = class(TForm)
    cxGridIQF_Metas: TcxGrid;
    cxTableViewIQF_Metas: TcxGridDBTableView;
    cxGridLevelIQF_Metas: TcxGridLevel;
    FDConnection: TFDConnection;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    DataSourceTIQF_Meta: TDataSource;
    FDQueryTIQF_Meta: TFDQuery;
    FDQueryTIQF_MetaTIQF_METACOD: TFDAutoIncField;
    FDQueryTIQF_MetaVALOR: TBCDField;
    FDQueryTIQF_MetaDATA_INICIO: TSQLTimeStampField;
    FDQueryTIQF_MetaDATA_FIM: TSQLTimeStampField;
    cxTableViewIQF_MetasVALOR: TcxGridDBColumn;
    cxTableViewIQF_MetasDATA_INICIO: TcxGridDBColumn;
    cxTableViewIQF_MetasDATA_FIM: TcxGridDBColumn;
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
  Fr_CadastroMetaIQF: TFr_CadastroMetaIQF;

implementation

{$R *.dfm}

uses uUtils, uBrady;

procedure TFr_CadastroMetaIQF.AbrirDataset;
begin

  if not FDConnection.Connected then
  begin

    Mensagem( 'Abrindo conex�o...' );
    try

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

      Mensagem( 'Obtendo dados (IQF Metas)...' );
      FDQueryTIQF_Meta.Open;

    finally

      Mensagem( EmptyStr );

    end;

  end;

end;


procedure TFr_CadastroMetaIQF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FDConnection.Close;

  Fr_CadastroMetaIQF := nil;
  Action := caFree;
end;

procedure TFr_CadastroMetaIQF.FormCreate(Sender: TObject);
begin
  LoadGridCustomization;
end;

procedure TFr_CadastroMetaIQF.LoadGridCustomization;
begin

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxTableViewIQF_Metas.Name + '.ini' ) then
    cxTableViewIQF_Metas.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxTableViewIQF_Metas.Name + '.ini' );

end;


procedure TFr_CadastroMetaIQF.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

end.
