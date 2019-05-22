unit uRelatorioRecuperacaoClientes;

interface

uses
  System.IOUtils,
  System.DateUtils,
  dxSpreadSheet,
  dxSpreadSheetTypes,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinOffice2013White,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.ExtCtrls, cxContainer, cxLabel, dxGDIPlusClasses, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, dxBarBuiltInMenu, Vcl.Menus,
  cxTextEdit, cxMaskEdit, cxButtonEdit, Vcl.StdCtrls, cxButtons, cxPC,
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
  cxDropDownEdit;

type
  TFr_RelatorioRecuperacaoClientes = class(TForm)
    Panel2: TPanel;
    FDConnection: TFDConnection;
    FDQueryRecuperacaoClientes: TFDQuery;
    DSFDQueryRecuperacaoClientes: TDataSource;
    FDQueryRecuperacaoClientesTSOP_ORDBILCLICOD: TStringField;
    FDQueryRecuperacaoClientesTSOP_ORDBILGRUCLINOM: TStringField;
    FDQueryRecuperacaoClientesTSOP_GRUCLIMER: TStringField;
    FDQueryRecuperacaoClientesTSOP_ORDBILREPNOM: TStringField;
    FDQueryRecuperacaoClientesTSOP_ORDBILDATDOC: TSQLTimeStampField;
    FDQueryRecuperacaoClientesNRODIAS: TIntegerField;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    Panel1: TPanel;
    ButExcel: TcxButton;
    cxButtonEditPath: TcxButtonEdit;
    cxLabel4: TcxLabel;
    v: TcxGrid;
    cxGridRecuperaClientesDBTableCliente: TcxGridDBTableView;
    cxGridRecuperaClientesDBTableClienteTSOP_ORDBILCLICOD: TcxGridDBColumn;
    cxGridRecuperaClientesDBTableClienteTSOP_ORDBILGRUCLINOM: TcxGridDBColumn;
    cxGridRecuperaClientesDBTableClienteTSOP_GRUCLIMER: TcxGridDBColumn;
    cxGridRecuperaClientesDBTableClienteTSOP_ORDBILREPNOM: TcxGridDBColumn;
    cxGridRecuperaClientesDBTableClienteTSOP_ORDBILDATDOC: TcxGridDBColumn;
    cxGridRecuperaClientesDBTableClienteNRODIAS: TcxGridDBColumn;
    vLevel1: TcxGridLevel;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    SaveDialog: TSaveDialog;
    FDQueryRecuperacaoClientesTSOP_ORDBILCANNOM: TStringField;
    cxGridRecuperaClientesDBTableClienteTSOP_ORDBILCANNOM: TcxGridDBColumn;
    cxLabel1: TcxLabel;
    cbPeriodo: TcxComboBox;
    Label1: TLabel;
    cxCanal: TcxComboBox;
    cxButtonRefresh: TcxButton;
    FDQueryAux: TFDQuery;
    FDQueryAuxMES: TIntegerField;
    procedure cxButtonEditPathClick(Sender: TObject);
    procedure ButExcelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cxButtonRefreshClick(Sender: TObject);
  private
    { Private declarations }
    procedure Mensagem( pMensagem: String );
  public
    { Public declarations }
    procedure AbrirDataset;
    procedure LoadGridCustomization;
  end;

var
  Fr_RelatorioRecuperacaoClientes: TFr_RelatorioRecuperacaoClientes;

implementation

{$R *.dfm}

uses uBrady, uUtils, uUtilsOwner;

{ TfrmRelatorioRecuperacaoClientes }

procedure TFr_RelatorioRecuperacaoClientes.AbrirDataset;
var
 iPeriodo: Integer;
begin
  Mensagem( 'Abrindo conex�o...' );
  try

    if not FDConnection.Connected then
    begin

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

    end;

    Mensagem( 'Obtendo dados (Recupera��o de Clientes)...' );

    if cbPeriodo.ItemIndex = 0 then
      iPeriodo := 3
    else if cbPeriodo.ItemIndex = 1 then
      iPeriodo := 6
    else if cbPeriodo.ItemIndex = 2 then
      iPeriodo := 9
    else if cbPeriodo.ItemIndex = 3 then
      iPeriodo := 12
    else if cbPeriodo.ItemIndex = 4 then
      iPeriodo := 24
    else if cbPeriodo.ItemIndex = 5 then
    begin
      FDQueryAux.Close;
      FDQueryAux.Open;
      iPeriodo := FDQueryAuxMES.AsInteger;
    end;

    FDQueryRecuperacaoClientes.ParamByName( 'MESES' ).AsInteger := iPeriodo;

    if cxCanal.Text <> '' then
      FDQueryRecuperacaoClientes.MacroByName( 'WHERE1' ).AsRaw := ' AND TSOP_ORDBILCANNOM = ' + QuotedStr(cxCanal.Text);

    if Fr_Brady.SalesRep then
      FDQueryRecuperacaoClientes.MacroByName( 'WHERE' ).AsRaw := ' AND TSOP_ORDBILREPNOM  = ' + QuotedStr(Fr_Brady.TSIS_USUNOM);

    FDQueryRecuperacaoClientes.Open;

  finally

    Mensagem( EmptyStr );

  end;
end;

procedure TFr_RelatorioRecuperacaoClientes.ButExcelClick(Sender: TObject);
const
  varTitulos: array[0..6] of string = ('C�d. Cliente','Grupo de Cliente','Canal','Nome da Conta','Vendedor','Data Ultima Compra','Nro Dias');

var
   dxSpreadSheet: TdxSpreadSheet;
   I , X : Integer;
   varCor1,varCor2: TColor;
begin
  if cxButtonEditPath.Text = EmptyStr then
    raise Exception.Create('Informe o arquivo primeiro.');

  if (FDQueryRecuperacaoClientes.IsEmpty) then
       raise Exception.Create('N�o h� dados para serem exportados ao Excel');

  Mensagem( 'Iniciando processo de exporta��o...' );
  try

    Mensagem( 'Criando planilha...' );
    DeleteFile(PWideChar(MyDocumentsPath+'\Recuperacao_Clientes.xlsx'));
    CopyFile( PWideChar('\\ghos2024\Brady\Recuperacao_Clientes.xlsx'), PWideChar(MyDocumentsPath+'\Recuperacao_Clientes.xlsx'), True );

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    try
      for I := 0 to 6 do
      begin

        with dxSpreadSheet.ActiveSheetAsTable.CreateCell(0,I) do;

      end;
      varCor1 := RGB( 255, 255, 204 );
      varCor2 := RGB(255,255,225);

      for I := 0 to 6 do
      begin
        with dxSpreadSheet.ActiveSheetAsTable.CreateCell(0,I) do
        begin
          Style.Brush.BackgroundColor := varCor1;
          AsString := varTitulos[I];

        end;
      end;


      FDQueryRecuperacaoClientes.First;
      FDQueryRecuperacaoClientes.DisableControls;


      X := 1;
      while not FDQueryRecuperacaoClientes.eof do
      begin


          Mensagem( 'Exportando linha (" ' + IntToStr(X) + '/' + IntToStr(FDQueryRecuperacaoClientes.RecordCount) + '")');

          if not Odd(X) then
            varCor1 := RGB(216,234,204)
          else
            varCor1 :=RGB(255,255,225);

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryRecuperacaoClientesTSOP_ORDBILCLICOD.AsString;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryRecuperacaoClientesTSOP_ORDBILGRUCLINOM .AsString;
          end;


          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,2) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryRecuperacaoClientesTSOP_ORDBILCANNOM.AsString;
          end;


          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,3) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryRecuperacaoClientesTSOP_GRUCLIMER.AsString;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,4) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryRecuperacaoClientesTSOP_ORDBILREPNOM.AsString;
          end;

          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,5) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryRecuperacaoClientesTSOP_ORDBILDATDOC.AsString;
          end;


          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,6) do
          begin
             Style.Brush.BackgroundColor := varCor1;
             AsVariant := FDQueryRecuperacaoClientesNRODIAS.AsString;
          end;

          Inc(X);
          FDQueryRecuperacaoClientes.Next;
      end;

      FDQueryRecuperacaoClientes.EnableControls;
      FDQueryRecuperacaoClientes.First;
      Mensagem( 'Salvando a planilha...' );
      dxSpreadSheet.SaveToFile( cxButtonEditPath.Text );

    finally
      FreeAndNil(dxSpreadSheet);
    end;

  finally
       Mensagem( EmptyStr );
  end;


end;

procedure TFr_RelatorioRecuperacaoClientes.cxButtonEditPathClick(
  Sender: TObject);
begin
  if SaveDialog.Execute(Handle) then
  begin
    cxButtonEditPath.Text := SaveDialog.FileName;
  end;
end;

procedure TFr_RelatorioRecuperacaoClientes.cxButtonRefreshClick(
  Sender: TObject);
begin
  FDQueryRecuperacaoClientes.Close;
  AbrirDataset;
end;

procedure TFr_RelatorioRecuperacaoClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FDQueryRecuperacaoClientes.Close;
  FDConnection.Close;

  Fr_RelatorioRecuperacaoClientes := nil;
  Action := caFree;
end;

procedure TFr_RelatorioRecuperacaoClientes.FormCreate(Sender: TObject);
begin
  LoadGridCustomization;
end;

procedure TFr_RelatorioRecuperacaoClientes.LoadGridCustomization;
begin
  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxGridRecuperaClientesDBTableCliente.Name + '.ini' ) then
    cxGridRecuperaClientesDBTableCliente.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxGridRecuperaClientesDBTableCliente.Name + '.ini' );
end;

procedure TFr_RelatorioRecuperacaoClientes.Mensagem(pMensagem: String);
begin
  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;
end;

end.
