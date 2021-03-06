unit uCadastroIQFFornecedor;

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
  cxCheckBox, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
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
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  cxDropDownEdit, cxEditRepositoryItems, cxImageComboBox;

type
  TFr_CadastroIQFFornecedor = class(TForm)
    cxGridIQF_Fornecedor: TcxGrid;
    cxGridLevelIQF_Fornecedor: TcxGridLevel;
    cxTableViewIQF_Fornecedor: TcxGridDBTableView;
    DataSourceTIQF_Fornecedor: TDataSource;
    FDConnection: TFDConnection;
    FDQueryTIQF_Fornecedor: TFDQuery;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    FDQueryTIQF_FornecedorTIQF_FORCOD: TFDAutoIncField;
    FDQueryTIQF_FornecedorTIQF_FORSAP: TStringField;
    FDQueryTIQF_FornecedorTIQF_FORNOM: TStringField;
    FDQueryTIQF_FornecedorTIQF_FORATI: TStringField;
    cxTableViewIQF_FornecedorTIQF_FORCOD: TcxGridDBColumn;
    cxTableViewIQF_FornecedorTIQF_FORSAP: TcxGridDBColumn;
    cxTableViewIQF_FornecedorTIQF_FORNOM: TcxGridDBColumn;
    cxTableViewIQF_FornecedorTIQF_FORATI: TcxGridDBColumn;
    FDQueryTIQF_FornecedorTIQF_FORCER: TStringField;
    cxTableViewIQF_FornecedorTIQF_FORCER: TcxGridDBColumn;
    FDQueryTIQF_FornecedorTIQF_FORCERDATVAL: TSQLTimeStampField;
    FDQueryTIQF_FornecedorTIQF_FORDOCMANUAL: TStringField;
    FDQueryTIQF_FornecedorTIQF_FORDOCSUPA: TStringField;
    FDQueryTIQF_FornecedorTIQF_FORDOCBALP: TStringField;
    FDQueryTIQF_FornecedorTIQF_FORDPODIAS: TIntegerField;
    cxTableViewIQF_FornecedorTIQF_FORDOCMANUAL: TcxGridDBColumn;
    cxTableViewIQF_FornecedorTIQF_FORDOCSUPA: TcxGridDBColumn;
    cxTableViewIQF_FornecedorTIQF_FORDOCBALP: TcxGridDBColumn;
    cxTableViewIQF_FornecedorTIQF_FORDPODIAS: TcxGridDBColumn;
    cxEditRepository1: TcxEditRepository;
    cxEditRepository1ComboBoxItem1: TcxEditRepositoryComboBoxItem;
    FDQueryTIQF_FornecedorTIQF_CATEGORIA: TStringField;
    cxTableViewIQF_FornecedorTIQF_CATEGORIA: TcxGridDBColumn;
    FDQueryTIQF_FornecedorTIQF_DTMANUAL: TSQLTimeStampField;
    FDQueryTIQF_FornecedorTIQF_DTSUPPLY: TSQLTimeStampField;
    FDQueryTIQF_FornecedorTIQF_DTBALANCO: TSQLTimeStampField;
    FDQueryTIQF_FornecedorTIQF_DTDOP: TSQLTimeStampField;
    cxStyle: TcxStyleRepository;
    cxStylePVencido: TcxStyle;
    cxStyleRAtraso: TcxStyle;
    cxStylePQuitado: TcxStyle;
    cxStyleRQuitado: TcxStyle;
    cxStyleCancelado: TcxStyle;
    cxStylePAberto: TcxStyle;
    cxStyleRAberto: TcxStyle;
    cxStyleBoletoRec: TcxStyle;
    cxStylePagtoBanco: TcxStyle;
    cxStyleBaixa: TcxStyle;
    cxStyleCartorio: TcxStyle;
    cxStyleProtesto: TcxStyle;
    cxStyleConciliado: TcxStyle;
    FDQueryTIQF_FornecedorTIQF_CLASSIFICACAO: TStringField;
    cxTableViewIQF_FornecedorTIQF_CLASSIFICACAO: TcxGridDBColumn;
    FDQueryCategoria: TFDQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FDQueryTIQF_FornecedorTIQF_FORDOCMANUALChange(Sender: TField);
    procedure FDQueryTIQF_FornecedorTIQF_FORDOCSUPAChange(Sender: TField);
    procedure FDQueryTIQF_FornecedorTIQF_FORDOCBALPChange(Sender: TField);
    procedure FDQueryTIQF_FornecedorTIQF_FORDPODIASChange(Sender: TField);
    procedure cxTableViewIQF_FornecedorStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxTableViewIQF_FornecedorInitEdit(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
  private
    varCategoria : TStringList;
    procedure Mensagem( pMensagem: String );
    { Private declarations }
  public
    procedure AbrirDataset;
    procedure LoadGridCustomization;
    { Public declarations }
  end;

var
  Fr_CadastroIQFFornecedor: TFr_CadastroIQFFornecedor;

implementation

{$R *.dfm}

uses uUtils, uBrady;

procedure TFr_CadastroIQFFornecedor.AbrirDataset;
begin

  if not FDConnection.Connected then
  begin

    Mensagem( 'Abrindo conex�o...' );
    try

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

      Mensagem( 'Obtendo dados (IQF Fornecedores)...' );
      FDQueryTIQF_Fornecedor.Open;

    finally

      Mensagem( EmptyStr );

    end;
    varCategoria := TStringList.Create;

    FDQueryCategoria.Close;
    FDQueryCategoria.SQL.Clear;
    FDQueryCategoria.SQL.Add('Select * from TIQF_Categoria order by TIQF_Categoria_Descricao');
    FDQueryCategoria.Open;
    if not FDQueryCategoria.IsEmpty then
    begin
       FDQueryCategoria.First;
       while not FDQueryCategoria.Eof do
       begin
          varCategoria.Add(FDQueryCategoria.FieldByName('TIQF_Categoria_Descricao').AsString);
          FDQueryCategoria.Next;
       end;
    end;

  end;

end;

procedure TFr_CadastroIQFFornecedor.cxTableViewIQF_FornecedorInitEdit(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit);

var
  I: Integer;
begin
  if AEdit is TcxComboBox then
  begin
    TcxComboBox(AEdit).Clear;
    for I := 0 to varCategoria.Count - 1 do
      TcxComboBox(AEdit).Properties.Items.Add(varCategoria[I]);
  end;

end;

procedure TFr_CadastroIQFFornecedor.cxTableViewIQF_FornecedorStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  AColumn  : TcxCustomGridTableItem;
  Tipo, Status, vStatus, Boleto, Conciliado : Variant;
begin
  {
  try
    AColumn := Sender.FindItemByName('cxTableViewIQF_FornecedorTIQF_FORCERDATVAL');
    Status  := ARecord.Values[AColumn.Index];

    if (Status < Date)  then
    begin
      AStyle := cxStylePVencido;
      exit;
    end;
   Except

  end;
  }
end;

procedure TFr_CadastroIQFFornecedor.FDQueryTIQF_FornecedorTIQF_FORDOCBALPChange(
  Sender: TField);
begin
  if ((FDQueryTIQF_FornecedorTIQF_FORDOCBALP.AsString = 'S') and
      ((FDQueryTIQF_FornecedorTIQF_DTBALANCO.AsDateTime = 0) or (FDQueryTIQF_FornecedorTIQF_DTBALANCO.AsString = '31/12/9999'))) then
  begin
     FDQueryTIQF_Fornecedor.Edit;
     FDQueryTIQF_FornecedorTIQF_DTBALANCO.AsDateTime := Date;
     FDQueryTIQF_Fornecedor.Post;
  end;
end;

procedure TFr_CadastroIQFFornecedor.FDQueryTIQF_FornecedorTIQF_FORDOCMANUALChange(
  Sender: TField);
begin
  if ((FDQueryTIQF_FornecedorTIQF_FORDOCMANUAL.AsString = 'S') and
      ((FDQueryTIQF_FornecedorTIQF_DTMANUAL.AsDateTime = 0) or (FDQueryTIQF_FornecedorTIQF_DTMANUAL.AsString = '31/12/9999'))) then
  begin
     FDQueryTIQF_Fornecedor.Edit;
     FDQueryTIQF_FornecedorTIQF_DTMANUAL.AsDateTime := Date;
     FDQueryTIQF_Fornecedor.Post;
  end;

end;

procedure TFr_CadastroIQFFornecedor.FDQueryTIQF_FornecedorTIQF_FORDOCSUPAChange(
  Sender: TField);
begin
  if ((FDQueryTIQF_FornecedorTIQF_FORDOCSUPA.AsString = 'S') and
      ((FDQueryTIQF_FornecedorTIQF_DTSUPPLY.AsDateTime = 0) or (FDQueryTIQF_FornecedorTIQF_DTSUPPLY.AsString = '31/12/9999'))) then
  begin
     FDQueryTIQF_Fornecedor.Edit;
     FDQueryTIQF_FornecedorTIQF_DTSUPPLY.AsDateTime := Date;
     FDQueryTIQF_Fornecedor.Post;
  end;
end;

procedure TFr_CadastroIQFFornecedor.FDQueryTIQF_FornecedorTIQF_FORDPODIASChange(
  Sender: TField);
begin

  if ((not FDQueryTIQF_FornecedorTIQF_FORDPODIAS.IsNull) and
     ((FDQueryTIQF_FornecedorTIQF_DTDOP.AsDateTime = 0) or (FDQueryTIQF_FornecedorTIQF_DTDOP.AsString = '31/12/9999'))) then
  begin
     FDQueryTIQF_Fornecedor.Edit;
     FDQueryTIQF_FornecedorTIQF_DTDOP.AsDateTime := Date;
     FDQueryTIQF_Fornecedor.Post;
  end;
end;

procedure TFr_CadastroIQFFornecedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  if varCategoria <> Nil then
    FreeAndNil(varCategoria);

  FDQueryTIQF_Fornecedor.Close;
  FDConnection.Close;

  Fr_CadastroIQFFornecedor := nil;
  Action := caFree;

end;

procedure TFr_CadastroIQFFornecedor.FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin

  Fr_Brady.PopupGridTools( cxGridIQF_Fornecedor.ActiveView );

end;

procedure TFr_CadastroIQFFornecedor.FormCreate(Sender: TObject);
begin

  LoadGridCustomization;



end;

procedure TFr_CadastroIQFFornecedor.LoadGridCustomization;
begin

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxTableViewIQF_Fornecedor.Name + '.ini' ) then
    cxTableViewIQF_Fornecedor.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxTableViewIQF_Fornecedor.Name + '.ini' );

end;

procedure TFr_CadastroIQFFornecedor.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

end.
