unit UProcessarL210;

interface

uses
 System.IOUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, cxControls, cxContainer, cxEdit,
  cxLabel, dxGDIPlusClasses,DateUtils, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB, cxDBData,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxSpreadSheet, cxTextEdit,
  cxMaskEdit, cxButtonEdit, cxDropDownEdit, Vcl.ImgList, cxCustomPivotGrid,
  cxDBPivotGrid, dxBarBuiltInMenu, cxPC;


Type
 TControle = record
   ano         : String;
   Controle_ID : String;
end;

type
  TfrmProcessarL210 = class(TForm)
    Panel3: TPanel;
    ButSair: TcxButton;
    Panel1: TPanel;
    Panel2: TPanel;
    dsGrid: TDataSource;
    FDQueryGrid: TFDQuery;
    SaveDialog: TSaveDialog;
    FDQueryGridORDEM: TIntegerField;
    FDQueryGridCODIGO_LINHA: TStringField;
    FDQueryGridDESC_L210: TStringField;
    FDQueryGridJANEIRO: TFMTBCDField;
    FDQueryGridFEVEREIRO: TFMTBCDField;
    FDQueryGridABRIL: TFMTBCDField;
    FDQueryGridMAIO: TFMTBCDField;
    FDQueryGridJUNHO: TFMTBCDField;
    FDQueryGridJULHO: TFMTBCDField;
    FDQueryGridAGOSTO: TFMTBCDField;
    FDQueryGridSETEMBRO: TFMTBCDField;
    FDQueryGridOUTUBRO: TFMTBCDField;
    FDQueryGridNOVEMBRO: TFMTBCDField;
    FDQueryGridDEZEMBRO: TFMTBCDField;
    ImageList1: TImageList;
    cxAno: TcxComboBox;
    Label1: TLabel;
    Shape1: TShape;
    FDQueryAux: TFDQuery;
    Page: TcxPageControl;
    cxTabL210: TcxTabSheet;
    cxTabMapa: TcxTabSheet;
    Panel7: TPanel;
    Image1: TImage;
    cxLabel2: TcxLabel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1SUBGRUPO: TcxGridDBColumn;
    cxGrid1DBTableView1CODIGO_LINHA: TcxGridDBColumn;
    cxGrid1DBTableView1DESC_L210: TcxGridDBColumn;
    cxGrid1DBTableView1JANEIRO: TcxGridDBColumn;
    cxGrid1DBTableView1FEVEREIRO: TcxGridDBColumn;
    cxGrid1DBTableView1MARO: TcxGridDBColumn;
    cxGrid1DBTableView1ABRIL: TcxGridDBColumn;
    cxGrid1DBTableView1MAIO: TcxGridDBColumn;
    cxGrid1DBTableView1JUNHO: TcxGridDBColumn;
    cxGrid1DBTableView1JULHO: TcxGridDBColumn;
    cxGrid1DBTableView1AGOSTO: TcxGridDBColumn;
    cxGrid1DBTableView1SETEMBRO: TcxGridDBColumn;
    cxGrid1DBTableView1OUTUBRO: TcxGridDBColumn;
    cxGrid1DBTableView1NOVEMBRO: TcxGridDBColumn;
    cxGrid1DBTableView1DEZEMBRO: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    FDQueryMapa: TFDQuery;
    DsMapa: TDataSource;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    FDQueryMapaACC_NUMBER: TStringField;
    FDQueryMapaFMTBCDField2: TFMTBCDField;
    FDQueryMapaFMTBCDField3: TFMTBCDField;
    FDQueryMapaFMTBCDField4: TFMTBCDField;
    FDQueryMapaFMTBCDField9: TFMTBCDField;
    FDQueryMapaFMTBCDField11: TFMTBCDField;
    FDQueryMapaFMTBCDField13: TFMTBCDField;
    FDQueryMapaFMTBCDField15: TFMTBCDField;
    FDQueryMapaFMTBCDField18: TFMTBCDField;
    FDQueryMapaFMTBCDField23: TFMTBCDField;
    FDQueryMapaFMTBCDField24: TFMTBCDField;
    FDQueryMapaFMTBCDField29: TFMTBCDField;
    FDQueryMapaFMTBCDField29B: TFMTBCDField;
    FDQueryMapaFMTBCDField29C: TFMTBCDField;
    FDQueryMapaFMTBCDField30: TFMTBCDField;
    FDQueryMapaFMTBCDField33: TFMTBCDField;
    FDQueryMapaFMTBCDField34: TFMTBCDField;
    FDQueryMapaFMTBCDField35: TFMTBCDField;
    FDQueryMapaFMTBCDField36: TFMTBCDField;
    FDQueryMapaCENTRO_CUSTO: TStringField;
    FDQueryMapaPERCENTUAL: TBCDField;
    FDQueryMapaECF_CONTROLE_ID: TIntegerField;
    cxGrid2DBTableView1ACC_NUMBER: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn2: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn3: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn4: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn9: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn11: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn13: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn15: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn18: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn23: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn24: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn29: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn29B: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn29C: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn30: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn33: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn34: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn35: TcxGridDBColumn;
    cxGrid2DBTableView1DBColumn36: TcxGridDBColumn;
    cxGrid2DBTableView1MES: TcxGridDBColumn;
    cxGrid2DBTableView1CENTRO_CUSTO: TcxGridDBColumn;
    cxGrid2DBTableView1PERCENTUAL: TcxGridDBColumn;
    FDQueryCriaSaldo: TFDQuery;
    FDQueryCriaSaldoECF_SALDO_ID: TFDAutoIncField;
    FDQueryCriaSaldoEMPRESA: TStringField;
    FDQueryCriaSaldoORDEM: TIntegerField;
    FDQueryCriaSaldoCODIGO_LINHA: TStringField;
    FDQueryCriaSaldoDESC_L210: TStringField;
    FDQueryCriaSaldoSUBGRUPO: TIntegerField;
    FDQueryCriaSaldoANO: TStringField;
    FDQueryCriaSaldoANO_ANTERIOR: TStringField;
    FDQueryCriaSaldoJANEIRO: TBCDField;
    FDQueryCriaSaldoFEVEREIRO: TBCDField;
    FDQueryCriaSaldoMARCO: TBCDField;
    FDQueryCriaSaldoABRIL: TBCDField;
    FDQueryCriaSaldoMAIO: TBCDField;
    FDQueryCriaSaldoJUNHO: TBCDField;
    FDQueryCriaSaldoJULHO: TBCDField;
    FDQueryCriaSaldoAGOSTO: TBCDField;
    FDQueryCriaSaldoSETEMBRO: TBCDField;
    FDQueryCriaSaldoOUTUBRO: TBCDField;
    FDQueryCriaSaldoNOVEMBRO: TBCDField;
    FDQueryCriaSaldoDEZEMBRO: TBCDField;
    FDQueryCriaSaldoDATA_IMPORT: TSQLTimeStampField;
    FDQueryGridMARCO: TFMTBCDField;
    FDQueryMapaCENTRO_CUSTO_FILHO: TStringField;
    cxGrid2DBTableView1CENTRO_CUSTO_FILHO: TcxGridDBColumn;
    FDQueryMapaMES: TIntegerField;
    FDQueryRemontaSaldo: TFDQuery;
    FDQueryRemontaSaldoORDEM: TIntegerField;
    FDQueryRemontaSaldoCODIGO_LINHA: TStringField;
    FDQueryRemontaSaldoDESC_L210: TStringField;
    FDQueryRemontaSaldoSUBGRUPO: TIntegerField;
    FDQueryRemontaSaldoJANEIRO: TFMTBCDField;
    FDQueryRemontaSaldoFEVEREIRO: TFMTBCDField;
    FDQueryRemontaSaldoABRIL: TFMTBCDField;
    FDQueryRemontaSaldoMAIO: TFMTBCDField;
    FDQueryRemontaSaldoJUNHO: TFMTBCDField;
    FDQueryRemontaSaldoJULHO: TFMTBCDField;
    FDQueryRemontaSaldoAGOSTO: TFMTBCDField;
    FDQueryRemontaSaldoSETEMBRO: TFMTBCDField;
    FDQueryRemontaSaldoOUTUBRO: TFMTBCDField;
    FDQueryRemontaSaldoNOVEMBRO: TFMTBCDField;
    FDQueryRemontaSaldoDEZEMBRO: TFMTBCDField;
    FDQueryRemontaSaldoMARCO: TFMTBCDField;
    FDQueryGridSUBGRUPO: TFloatField;
    FDQueryMapaFMTBCDField16: TFMTBCDField;
    cxGrid2DBTableView1DBColumn16: TcxGridDBColumn;
    lblExportar: TLabel;
    cxButtonEditPath: TcxButtonEdit;
    cxButton3: TcxButton;
    ButPesquisar: TcxButton;
    FDQueryControle: TFDQuery;
    FDQueryControleECF_CONTROLE_ID: TFDAutoIncField;
    FDQueryControleANO: TStringField;
    FDQueryControleANO_ANTERIOR: TStringField;
    FDQueryControleDATA_IMPORT: TSQLTimeStampField;
    procedure ButSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImportarClick(Sender: TObject);
    procedure cxButtonEditPathClick(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButPesquisarClick(Sender: TObject);
    procedure PageChange(Sender: TObject);
  private
    varSaldoTempJan, varSaldoTempFev, varSaldoTempMar, varSaldoTempAbr, varSaldoTempMai, varSaldoTempJun,
    varSaldoTempJul,varSaldoTempAgo,varSaldoTempSep,varSaldoTempOtu,varSaldoTempNov, varSaldoTempDez : Currency;
    Controle : TControle;
    varExercicio_AnoFiscal, varExercicio_MesFiscal : String;
    procedure Mensagem(pMensagem : String);
    procedure Importar_Arquivos_Fiscal(Ano : String);
    procedure ConfiguraAnoFiscal(Data: TDateTime);
    Function  TransformaNegativo (Valor : String) : String;
    function MyDocumentsPath: String;
    function WUserName: String;
    function CalcularSaldo(pIndice : Integer;pMES_ANT : String= '') : Currency;
    procedure CriarSaldo(pAnoAnterior, pAno, pCodigoLinha, pDescricao, pOrdem : String);
    procedure GerarPlanilhaMapeamento;
    procedure GeraPlanilha210;
    procedure CalcularLinha29a;
    procedure CalcularLinha31;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProcessarL210: TfrmProcessarL210;

implementation

{$R *.dfm}

uses DBConect;


function TfrmProcessarL210.MyDocumentsPath: String;
begin

  Result := System.IOUtils.TPath.GetDocumentsPath + '\' + 'Brady Brazil';

  if not ParamStr(1).Equals('-carga_maquina') then
    Result := '\\ghos2024\Brady\Users\' + WUserName + '\' + 'Brady Brazil';

  if not System.IOUtils.TDirectory.Exists(Result) then
    System.IOUtils.TDirectory.CreateDirectory(Result);

end;

procedure TfrmProcessarL210.PageChange(Sender: TObject);
begin
  if Page.ActivePageIndex = 0 then
     lblExportar.Caption := 'Exportar Planilha L210 para:'
  else   lblExportar.Caption := 'Exportar Planilha Mapeamento para:'
end;

function TfrmProcessarL210.WUserName: String;
var
  nSize: DWord;

begin

  nSize := 1024;
  SetLength(Result, nSize);
  if GetUserName(PChar(Result), nSize) then
    SetLength(Result, nSize-1)
  else
    RaiseLastOSError;

  if Result.Equals('rafae') then
    Result := 'petrelra';
//    Result := 'gocaloal';

end;

procedure TfrmProcessarL210.ConfiguraAnoFiscal(Data: TDateTime);
var
 Ano, Mes, Dia: Word;
 MesFiscal : String;
begin
  DecodeDate(Data, Ano, Mes, Dia);
   varExercicio_AnoFiscal  := '';
   varExercicio_MesFiscal  := '';

   Case Mes Of
       8  : MesFiscal := '1' ;
       9  : MesFiscal := '2' ;
       10 : MesFiscal := '3' ;
       11 : MesFiscal := '4' ;
       12 : MesFiscal := '5' ;
       1  : MesFiscal := '6' ;
       2  : MesFiscal := '7' ;
       3  : MesFiscal := '8' ;
       4  : MesFiscal := '9' ;
       5  : MesFiscal := '10' ;
       6  : MesFiscal := '11' ;
       7  : MesFiscal := '12' ;
   End ;

   if Mes >= 8 then Ano := Ano + 1;
   varExercicio_AnoFiscal    := IntToStr(Ano);
   varExercicio_MesFiscal := MesFiscal;

end;

procedure TfrmProcessarL210.GerarPlanilhaMapeamento;
const
  varLinhas: array[0..23] of string = ('Conta','2','3','4','9','11','13','15','16','18','23','24','29','29B','29C','30','33','34','35','36','Mes','Centro_Custo','CC_Rateio','Percentual');

var
  I, X, LastX: Integer;
  dxSpreadSheet: TdxSpreadSheet;
  varLastGrupoCliente: String;
  varCor1,varCor2: TColor;
begin
  if cxButtonEditPath.Text = EmptyStr then
    raise Exception.Create('Informe o arquivo primeiro');

  DB_Conect.FDConnection.Open;

  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
  FDQueryAux.SQL.Add('Select ECF_CONTROLE_ID, ANO, ANO_ANTERIOR From ECF_CONTROLE where ANO = :ANO AND ANO_ANTERIOR = :ANO_ANTERIOR');
  FDQueryAux.Params.ParamByName('ANO').AsString          := cxAno.Text;
  FDQueryAux.Params.ParamByName('ANO_ANTERIOR').AsString := IntToStr(StrToInt(cxAno.Text)-1);
  FDQueryAux.Open;

  if FDQueryAux.IsEmpty then
     raise Exception.Create('Planilha L210 n�o gerada para o per�odo informado.');

  Mensagem( 'Iniciando processo de exporta��o...' );
  try

    Mensagem( 'Criando planilha...' );
    DeleteFile(PWideChar(MyDocumentsPath+'\Planilha_Mapeamento_L210.xlsx'));
    CopyFile( PWideChar('\\ghos2024\Brady\Planilha_Mapeamento_L210.xlsx'), PWideChar(MyDocumentsPath+'\Planilha_Mapeamento_L210.xlsx'), True );

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    try

      Mensagem( 'Carregando planilha...' );
      dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\Planilha_Mapeamento_L210.xlsx' );
      dxSpreadSheet.BeginUpdate;
      for I := 0 to 23 do
      begin

        with dxSpreadSheet.ActiveSheetAsTable.CreateCell(0,I) do;

      end;

      for I := 0 to 23 do
      begin
        with dxSpreadSheet.ActiveSheetAsTable.CreateCell(0,I) do
        begin

          AsString := varLinhas[I];

        end;
      end;


      FDQueryMapa.Close;
      FDQueryMapa.ParamByName( 'ANO_ANT' ).AsInteger :=  StrToInt(cxAno.Text)-1;
      FDQueryMapa.ParamByName( 'ANO' ).AsInteger     :=  StrToInt(cxAno.Text);
      FDQueryMapa.Open;
      try

        try

          varLastGrupoCliente := EmptyStr;
          varCor1 := RGB( 255, 255, 204 );
          varCor2 := RGB(255,255,225);

          X := 1;
          LastX := 1;
          while not FDQueryMapa.Eof do
          begin

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant :=  FDQueryMapaACC_NUMBER.AsString;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField2.AsFloat;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,2) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField3.AsFloat;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,3) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField4.AsFloat;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,4) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField9.AsFloat;

            end;


            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,5) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField11.AsFloat;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,6) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField13.AsFloat;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,7) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField15.AsFloat;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,8) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField16.AsFloat;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,9) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField18.AsFloat;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,10) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField23.AsFloat;

            end;


            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,11) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField24.AsFloat;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,12) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField29.AsFloat;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,13) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField29B.AsFloat;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,14) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField29C.AsFloat;

            end;


            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,15) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField30.AsFloat;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,16) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField33.AsFloat;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,17) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField34.AsFloat;

            end;


            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,18) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField35.AsFloat;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,19) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaFMTBCDField36.AsFloat;

            end;


            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,20) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant := FDQueryMapaMES.AsString;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,21) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant := FDQueryMapaCENTRO_CUSTO.AsString;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,22) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant := FDQueryMapaCENTRO_CUSTO_FILHO.AsString;

            end;


            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,23) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              Style.DataFormat.FormatCode := '#,##0.00';
              AsVariant := FDQueryMapaPERCENTUAL.AsFloat;

            end;

            if varCor1 = RGB( 197, 224, 178 ) then
              varCor1 := RGB( 255, 255, 204 )
            else
              varCor1 := RGB( 197, 224, 178 );

            if varCor1 = RGB(255,255,204) then
              varCor2 := RGB(255,255,225)
            else
              varCor2 := RGB(216,234,204);


            FDQueryMapa.Next;
            Inc(X);
          end;
        finally
          FDQueryMapa.Close;
        end;
      finally
          DB_Conect.FDConnection.Close;
      end;

      Mensagem( 'Salvando a planilha...' );
      dxSpreadSheet.SaveToFile( cxButtonEditPath.Text );

      MessageDlg('Planilha gerada com sucesso!!',mtInformation,[mbOk],0);

    finally
      FreeAndNil(dxSpreadSheet);
    end;
  finally
     Mensagem( EmptyStr );
  end;
end;


procedure  TfrmProcessarL210.GeraPlanilha210;
const
  varCelulas: array[2..13] of string = ('C','D','E','F','G','H','I','J','K','L','M','N');


var
  I, X, LastX: Integer;
  dxSpreadSheet: TdxSpreadSheet;
  varData: TDateTime;
  varLastGrupoCliente: String;
  varCor1,varCor2: TColor;
  varSubtotal: array[2..13] of string;
  fValor : Array [2..13] of Currency;
  varbFirst : Boolean;

begin

  if cxButtonEditPath.Text = EmptyStr then
    raise Exception.Create('Informe o arquivo primeiro');


  DB_Conect.FDConnection.Open;

  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
  FDQueryAux.SQL.Add('Select ECF_CONTROLE_ID, ANO, ANO_ANTERIOR From ECF_CONTROLE where ANO = :ANO AND ANO_ANTERIOR = :ANO_ANTERIOR');
  FDQueryAux.Params.ParamByName('ANO').AsString          := cxAno.Text;
  FDQueryAux.Params.ParamByName('ANO_ANTERIOR').AsString := IntToStr(StrToInt(cxAno.Text)-1);
  FDQueryAux.Open;

  if FDQueryAux.IsEmpty then
     raise Exception.Create('Planilha L210 n�o gerada para o per�odo informado.');

  if  MessageDlg('Exportar Planilha L210 do ano de ' + cxAno.Text +' ?',mtConfirmation,[mbyes,mbno],0)=mrNo Then
    exit;


  Mensagem( 'Iniciando processo de exporta��o...' );

  CalcularLinha29a;
  CalcularLinha31;

  try

    Mensagem( 'Criando planilha...' );
    DeleteFile(PWideChar(MyDocumentsPath+'\Planilha_L210.xlsx'));
    CopyFile( PWideChar('\\ghos2024\Brady\Planilha_L210.xlsx'), PWideChar(MyDocumentsPath+'\Planilha_L210.xlsx'), True );

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    try

      Mensagem( 'Carregando planilha...' );
      dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\Planilha_L210.xlsx' );
      dxSpreadSheet.BeginUpdate;

      for I := 0 to 30 do
      begin

        with dxSpreadSheet.ActiveSheetAsTable.CreateCell(0,I) do;

      end;

      varData := System.DateUtils.StartOfTheYear(Date);
      for I := 1 to 12 do
      begin
        with dxSpreadSheet.ActiveSheetAsTable.CreateCell(0,I+1) do
        begin

          AsString := FormatDateTime('mmmm', varData);

        end;
        varData := System.DateUtils.StartOfTheMonth(System.DateUtils.EndOfTheMonth(varData)+1);
      end;


      try

        try

          varLastGrupoCliente := EmptyStr;
          varCor1 := RGB( 255, 255, 204 );
          varCor2 := RGB(255,255,225);

          X := 1;
          LastX := 1;
          FDQueryGrid.First;
          while not FDQueryGrid.Eof do
          begin


            if FDQueryGridCODIGO_LINHA.AsString = '29' then
             begin
                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
                begin

                  Style.Brush.BackgroundColor := varCor1;
                  AsVariant :=  '29'

                end;

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
                begin

                  Style.Brush.BackgroundColor := varCor1;
                  AsVariant :=  'Outros Custos'

                end;
                varbFirst := True;
                for I := 2 to 13 do
                begin

                  with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,I) do
                  begin

                    Style.Font.Style := Style.Font.Style + [fsBold];
                    Style.Brush.BackgroundColor := varCor2;
                    Style.DataFormat.FormatCode := '#,##0.00';


                    if varbFirst then
                      SetText('=SUM('+ varCelulas[I] + IntToStr( 11 ) + ':' + varCelulas[I] + IntToStr(13)+')', True)
                    else
                      SetText('=' + varCelulas[I-1] + IntToStr(X+1) + '+' + 'SUM('+ varCelulas[I] + IntToStr( 11 ) + ':' + varCelulas[I] + IntToStr(13)+')', True);

                    varbFirst := False;

                    if varSubtotal[I].IsEmpty then
                      varSubtotal[I] := '=' + varCelulas[I] + IntToStr(X+1)
                    else
                      varSubtotal[I] := varSubtotal[I] + '+' + varCelulas[I] + IntToStr(X+1);

                  end;

                end;

                Inc(X);
                LastX := X;
             end;



            if FDQueryGridCODIGO_LINHA.AsString = '29B' then
             begin
                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
                begin

                  Style.Brush.BackgroundColor := varCor1;
                  AsVariant :=  '29A'

                end;

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
                begin

                  Style.Brush.BackgroundColor := varCor1;
                  AsVariant :=  'VARIA��O DE CUSTO MENSAL'

                end;

                for I := 2 to 13 do
                begin

                  with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,I) do
                  begin

                    Style.Font.Style := Style.Font.Style + [fsBold];
                    Style.Brush.BackgroundColor := varCor2;
                    Style.DataFormat.FormatCode := '#,##0.00';
                    SetText('0');

                  end;

                end;

                Inc(X);
                LastX := X;
             end;


             if FDQueryGridCODIGO_LINHA.AsString = '33' then
             begin
                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
                begin

                  Style.Brush.BackgroundColor := varCor1;
                  AsVariant :=  '31'

                end;

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
                begin

                  Style.Brush.BackgroundColor := varCor1;
                  AsVariant :=  'CUSTO DOS PRODUTOS DE FABRICA��O PR�PRIA VENDIDOS'

                end;

                for I := 2 to 13 do
                begin

                  with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,I) do
                  begin

                    Style.Font.Style := Style.Font.Style + [fsBold];
                    Style.Brush.BackgroundColor := varCor2;
                    Style.DataFormat.FormatCode := '#,##0.00';
                    SetText('=SUM('+ varCelulas[I] + IntToStr( 2 )  + '+' +
                                     varCelulas[I] + IntToStr( 3 )  + '+' +
                                     varCelulas[I] + IntToStr( 4 )  + '+' +
                                     varCelulas[I] + IntToStr( 5 )  + '+' +
                                     varCelulas[I] + IntToStr( 6 )  + '+' +
                                     varCelulas[I] + IntToStr( 7 )  + '+' +
                                     varCelulas[I] + IntToStr( 8 )  + '+' +
                                     varCelulas[I] + IntToStr( 9 )  + '+' +
                                     varCelulas[I] + IntToStr( 10 ) + '+' +
                                     varCelulas[I] + IntToStr( 14 ) + '+' +
                                     varCelulas[I] + IntToStr( 15 ) + '+' +
                                     varCelulas[I] + IntToStr( 16 ) + ')', True);

                    if varSubtotal[I].IsEmpty then
                      varSubtotal[I] := '=' + varCelulas[I] + IntToStr(X+1)
                    else
                      varSubtotal[I] := varSubtotal[I] + '+' + varCelulas[I] + IntToStr(X+1);

                  end;

                end;

                Inc(X);
                LastX := X;
             end;

             if varCor1 = RGB( 197, 224, 178 ) then
               varCor1 := RGB( 255, 255, 204 )
             else
               varCor1 := RGB( 197, 224, 178 );

             if varCor1 = RGB(255,255,204) then
               varCor2 := RGB(255,255,225)
             else
               varCor2 := RGB(216,234,204);

            //end;

            //if FDQueryVSOP_ClienteFamiliaBySalesRep.Eof then
            //begin

              for I := 2 to 13 do
              begin

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,I) do
                begin

                  Style.Font.Style := Style.Font.Style + [fsBold];
                  Style.DataFormat.FormatCode := '#,##0.00';
                  SetText(varSubtotal[I], True);

                end;

              end;

            //  Break;
            //end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant :=  FDQueryGridCODIGO_LINHA.AsString;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant := FDQueryGridDESC_L210.AsString;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,2) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant := FDQueryGridJANEIRO.AsString;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,3) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant := FDQueryGridFEVEREIRO.AsString;


            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,4) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant := FDQueryGridMARCO.AsString;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,5) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant := FDQueryGridABRIL.AsString;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,6) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant := FDQueryGridMAIO.AsString;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,7) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant := FDQueryGridJUNHO.AsString;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,8) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant := FDQueryGridJULHO.AsString;

            end;


            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,9) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant := FDQueryGridAGOSTO.AsString;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,10) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant := FDQueryGridSETEMBRO.AsString;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,11) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant := FDQueryGridOUTUBRO.AsString;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,12) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant := FDQueryGridNOVEMBRO.AsString;

            end;

            with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,13) do
            begin

              Style.Brush.BackgroundColor := varCor1;
              AsVariant := FDQueryGridDEZEMBRO.AsString;

            end;



            Inc(X);
            if FDQueryGridCODIGO_LINHA.AsString = '36'  then
            begin
                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
                begin

                  Style.Brush.BackgroundColor := varCor1;
                  AsVariant :=  '37'

                end;

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
                begin

                  Style.Brush.BackgroundColor := varCor1;
                  AsVariant :=  'CUSTO DAS MERCADORIAS REVENDIDAS'

                end;

                varbFirst := True;
                for I := 2 to 13 do
                begin

                  with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,I) do
                  begin

                    Style.Font.Style := Style.Font.Style + [fsBold];
                    Style.Brush.BackgroundColor := varCor2;
                    Style.DataFormat.FormatCode := '#,##0.00';

                     {
                    if varbFirst then
                      SetText('=SUM('+ varCelulas[I] + IntToStr( 11 ) + ':' + varCelulas[I] + IntToStr(13)+')', True)
                    else
                      SetText('=' + varCelulas[I-1] + IntToStr(X+1) + '+' + 'SUM('+ varCelulas[I] + IntToStr( 11 ) + ':' + varCelulas[I] + IntToStr(13)+')', True);

                    varbFirst := False;
                    }

                    SetText('=SUM('+ varCelulas[I] + IntToStr( 18 ) + ':' + varCelulas[I] + IntToStr(21)+')', True);

                    if varSubtotal[I].IsEmpty then
                      varSubtotal[I] := '=' + varCelulas[I] + IntToStr(X+1)
                    else
                      varSubtotal[I] := varSubtotal[I] + '+' + varCelulas[I] + IntToStr(X+1);

                  end;

                end;

                Inc(X);
                LastX := X;


                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
                begin

                  Style.Brush.BackgroundColor := varCor1;
                  AsVariant :=  '69'

                end;

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
                begin

                  Style.Brush.BackgroundColor := varCor1;
                  AsVariant :=  'TOTAL DOS CUSTOS DAS ATIVIDADES EM GERAL'

                end;

                for I := 2 to 13 do
                begin

                  with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,I) do
                  begin

                    Style.Font.Style := Style.Font.Style + [fsBold];
                    Style.Brush.BackgroundColor := varCor2;
                    Style.DataFormat.FormatCode := '#,##0.00';

                    SetText('=SUM('+ varCelulas[I] + IntToStr( 17 ) + '+' + varCelulas[I] + IntToStr(22)+')', True);


                    if varSubtotal[I].IsEmpty then
                      varSubtotal[I] := '=' + varCelulas[I] + IntToStr(X+1)
                    else
                      varSubtotal[I] := varSubtotal[I] + '+' + varCelulas[I] + IntToStr(X+1);

                  end;

                end;

                Inc(X);
                LastX := X;


            end;

            FDQueryGrid.Next;


            if FDQueryGrid.Eof  then
            begin


                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
                begin

                  Style.Brush.BackgroundColor := varCor1;
                  AsVariant :=  '999'

                end;

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
                begin

                  Style.Brush.BackgroundColor := varCor1;
                  AsVariant :=  'Valor da Linha 29A'

                end;

                for I := 2 to 13 do
                begin

                  with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,I) do
                  begin

                    Style.Font.Style := Style.Font.Style + [fsBold];
                    Style.Brush.BackgroundColor := varCor2;
                    Style.DataFormat.FormatCode := '#,##0.00';
                    SetText('=SUM('+ varCelulas[I] + IntToStr( 23 ) + '-(' + varCelulas[I] + IntToStr(24) + '+' +  varCelulas[I] + IntToStr(25) +  '))*-1', True);


                    if varSubtotal[I].IsEmpty then
                      varSubtotal[I] := '=' + varCelulas[I] + IntToStr(X+1)
                    else
                      varSubtotal[I] := varSubtotal[I] + '+' + varCelulas[I] + IntToStr(X+1);

                  end;

                end;

                Inc(X);
                LastX := X;




            end;


            Application.ProcessMessages;

          end;

        finally

          FDQueryGrid.Close;
        end;


        Mensagem( 'Salvando a planilha...' );
        dxSpreadSheet.SaveToFile( cxButtonEditPath.Text );

        MessageDlg('Planilha gerada com sucesso!!',mtInformation,[mbOk],0);

      finally

       DB_Conect.FDConnection.Close;

      end;


    finally

      FreeAndNil(dxSpreadSheet);

    end;

  finally

    Mensagem( EmptyStr );
  end;


end;


procedure TfrmProcessarL210.cxButton3Click(Sender: TObject);
begin


  if Page.ActivePageIndex = 0 then
  begin
    if FDQueryGrid.IsEmpty then
      raise Exception.Create('N�o h� dados para serem exportados.');

    GeraPlanilha210;
  end
  else
  begin

    if FDQueryMapa.IsEmpty then
     raise Exception.Create('N�o h� dados para serem exportados.');

    GerarPlanilhaMapeamento;
  end;

end;

procedure TfrmProcessarL210.cxButtonEditPathClick(Sender: TObject);
var
 varTempArq : String;
begin
  if  SaveDialog.Execute(Handle)  then
  begin
   varTempArq :=  SaveDialog.FileName;
   if Pos('xlsx', varTempArq) = 0 then
      cxButtonEditPath.Text :=  varTempArq + '.xlsx'
   else
      cxButtonEditPath.Text  := varTempArq;
  end;
end;

procedure TfrmProcessarL210.Mensagem(pMensagem : String);
begin

  cxLabel2.Caption := pMensagem;
  Panel7.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;



function TfrmProcessarL210.TransformaNegativo(Valor: String): String;
var
 varValor : String;
begin
   varValor := Valor;

   if Pos('-',Valor) > 1 then
       varValor := '-' + Valor.Replace( '-', '', [rfReplaceAll] );

   result :=  varValor;


end;

procedure TfrmProcessarL210.btnImportarClick(Sender: TObject);
const
 // varArquivosMov : Array [0..1] of String = ('BR-L210-MOV.TXT','BR-L210-MOV-ANT.TXT');
  vetArquivos : array  [0..3] of string = ('BR-L210-INS_MERC.TXT','BR-L210-INS_MERC_2.TXT','BR-L210-OUT_CUST_1.TXT','BR-L210-OUT_CUST_2.TXT');
  vetArquivosFBL3N : array  [0..11] of string = ('FBL3N_JAN.TXT','FBL3N_FEV.TXT','FBL3N_MAR.TXT','FBL3N_APR.TXT',
                                                 'FBL3N_MAY.TXT','FBL3N_JUN.TXT','FBL3N_JUL.TXT','FBL3N_AUG.TXT',
                                                 'FBL3N_SEP.TXT','FBL3N_OCT.TXT','FBL3N_NOV.TXT','FBL3N_DEZ.TXT'
                                                 );

var
  X, I : Integer;
  varArquivo: TStringList;
  varConta, varTipo : String;
  varValor_01,    varValor_02, varValor_03, varValor_04, varValor_05, varValor_06, varValor_07, varValor_08,
  varValor_09, varValor_10, varValor_11, varValor_12, varValor_13 : Extended;
  varArquivosMov : Array [0..1] of String;

  varPlant,
  varDC,
  varACC_NUMBER,
  varPURCHASING_DOC,
  varACC_NUMBER_VEN_CRE,
  varNAME,
  varPOSITION_PERIODO,
  varFISCAL_YEAR,
  varMOEDA,
  varPAIS,
  varANO, varEmpresa: String;
  varAMOUNT : Extended;


  vaarCD,
  varNUMERO_CONTA,
  varCENTRO_CUSTO,
  varMOEDACONTABIL   ,
  varDCCONTABIL : String;

  varDATA : TDateTime;
  varVALORCONTABIL : Extended;
  varControle_ID : Integer;

begin

  if cxAno.Text = EmptyStr then
    raise Exception.Create('Ano n�o informado');

  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
  FDQueryAux.SQL.Add('Select ECF_CONTROLE_ID, ANO, ANO_ANTERIOR From ECF_CONTROLE where ANO = :ANO AND ANO_ANTERIOR = :ANO_ANTERIOR');
  FDQueryAux.Params.ParamByName('ANO').AsString          := cxAno.Text;
  FDQueryAux.Params.ParamByName('ANO_ANTERIOR').AsString := IntToStr(StrToInt(cxAno.Text)-1);
  FDQueryAux.Open;

  if not FDQueryAux.IsEmpty then
  begin
    If  MessageDlg('Processo deste ano j� foi executado.Deseja reimportar o ano de ' + cxAno.Text +' novamente?',mtConfirmation,[mbyes,mbno],0)=mryes
    then
     begin
        varControle_ID := FDQueryAux.FieldByName('ECF_CONTROLE_ID').AsInteger;
        FDQueryAux.Close;
        FDQueryAux.SQL.Clear;
        FDQueryAux.SQL.Add('Delete from ECF_MOV_F01 where ECF_CONTROLE_ID = :ECF_CONTROLE_ID');
        FDQueryAux.Params.ParamByName('ECF_CONTROLE_ID').AsInteger          :=varControle_ID;

        try

          FDQueryAux.ExecSQL;

        except

          on E: Exception do
          begin

            Mensagem( 'Delete ECF_MOV_F01: ' + E.Message );
            FDQueryAux.Cancel;

          end;

        end;

        FDQueryAux.Close;
        FDQueryAux.SQL.Clear;
        FDQueryAux.SQL.Add('Delete from ECF_MOV_KE5Z where ECF_CONTROLE_ID = :ECF_CONTROLE_ID');
        FDQueryAux.Params.ParamByName('ECF_CONTROLE_ID').AsInteger          :=varControle_ID;

        try

          FDQueryAux.ExecSQL;

        except

          on E: Exception do
          begin

            Mensagem( 'Delete ECF_MOV_KE5Z: ' + E.Message );
            FDQueryAux.Cancel;

          end;

        end;

        FDQueryAux.Close;
        FDQueryAux.SQL.Clear;
        FDQueryAux.SQL.Add('Delete from ECF_FBL3N where ECF_CONTROLE_ID = :ECF_CONTROLE_ID');
        FDQueryAux.Params.ParamByName('ECF_CONTROLE_ID').AsInteger          :=varControle_ID;

        try

          FDQueryAux.ExecSQL;

        except

          on E: Exception do
          begin

            Mensagem( 'Delete ECF_FBL3N: ' + E.Message );
            FDQueryAux.Cancel;

          end;

        end;

     end;
  end;

  If  MessageDlg('O Depto de T.I criou as consultas no SAP referente ao ano de ' + cxAno.Text + ' e ' + IntToStr(StrToInt(cxAno.Text)-1) + '?',mtConfirmation,[mbyes,mbno],0)=mrNo Then
     exit;

  Importar_Arquivos_Fiscal(cxAno.Text);
  varArquivosMov[0] := 'BR_L210_MOV-'+IntToStr(StrToInt(cxAno.Text)-1)+'.TXT';
  varArquivosMov[1] := 'BR_L210_MOV-'+cxAno.Text+'.TXT';

 // Sleep(60000*2);

  Mensagem( 'Criando DataModule' );
  with DB_Conect do
  begin

    Mensagem( 'Iniciando processo de importa��o...' );
    try

      varArquivo := TStringList.Create;
      try

          Mensagem( 'Carregando arquivo...' );

          Mensagem( 'Abrindo Conex�o...' );
          FDConnection.Open;

          try


            try

              FDQuery_Controle.Open;
              FDQuery_Controle.Append;
              FDQuery_ControleANO.asString          := cxAno.Text;
              FDQuery_ControleANO_ANTERIOR.AsString := IntToStr(StrToInt(cxAno.Text)-1);

              try

                FDQuery_Controle.Post;

              except

                on E: Exception do
                begin

                  Mensagem( 'Post: ' + E.Message );
                  FDQuery_Controle.Cancel;

                end;

              end;


              try

                FDQuery_Controle.ApplyUpdates;
                FDQuery_Controle.CommitUpdates;

              except

                on E: Exception do
                begin

                  Mensagem( 'CommitUpdates: ' + E.Message );

                end;

              end;

              FDQueryAux.Close;
              FDQueryAux.SQL.Clear;
              FDQueryAux.SQL.Add('Select ECF_CONTROLE_ID, ANO, ANO_ANTERIOR From ECF_CONTROLE where ANO = :ANO AND ANO_ANTERIOR = :ANO_ANTERIOR');
              FDQueryAux.Params.ParamByName('ANO').AsString          := cxAno.Text;
              FDQueryAux.Params.ParamByName('ANO_ANTERIOR').AsString := IntToStr(StrToInt(cxAno.Text)-1);
              FDQueryAux.Open;
              varControle_ID := FDQueryAux.FieldByName('ECF_CONTROLE_ID').AsInteger;

              FDQuery_Insert_F01.Open;
              for I  := 0 to High(varArquivosMov) do
              begin
                  X := 0;
                  varArquivo.Clear;
                  varArquivo.LoadFromFile('\\GHOS2024\Brady\Files\L210\'+varArquivosMov[I]);
                  varANO :=  varArquivosMov[I].Split(['-'])[1].Trim;
                  if Pos('.',varANO) > 0 then
                      varANO := Copy(varANO,1,4);

                  Mensagem( 'Lendo linhas do arquivo ' + varArquivosMov[I]);
                  while X <= varArquivo.Count-1 do
                  begin
                    varConta    := '';
                    varTipo     := '';
                    varAno      := '';
                    varEmpresa  := '';
                    varValor_01 := 0.00;
                    varValor_02 := 0.00;
                    varValor_03 := 0.00;
                    varValor_04 := 0.00;
                    varValor_05 := 0.00;
                    varValor_06 := 0.00;
                    varValor_07 := 0.00;
                    varValor_08 := 0.00;
                    varValor_09 := 0.00;
                    varValor_10 := 0.00;
                    varValor_11 := 0.00;
                    varValor_12 := 0.00;
                    varValor_13 := 0.00;

                    try
                      if not (varArquivo[X].CountChar('|') = 30) then
                        Continue;


                      Mensagem( 'Linha (" ' + IntToStr(X) + '/' + IntToStr(varArquivo.Count-1) + '") "' + Trim(varArquivo[X].Split(['|'])[1]) + '" ...' );


                      varEmpresa      := varArquivo[X].Split(['|'])[1].Trim;
                      varAno          := varArquivo[X].Split(['|'])[2].Trim;
                      varConta        := varArquivo[X].Split(['|'])[3].Trim;
                      varTipo         := varArquivo[X].Split(['|'])[4].Trim;
                      varValor_01     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[5].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll]  )));
                      varValor_02     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[7].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll]  )));
                      varValor_03     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[9].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll]  )));
                      varValor_04     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[11].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll]  )));
                      varValor_05     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[13].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                      varValor_06     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[15].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                      varValor_07     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[17].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                      varValor_08     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[19].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                      varValor_09     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[21].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                      varValor_10     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[23].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                      varValor_11     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[25].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                      varValor_12     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[27].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                      varValor_13     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[29].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));



                      FDQuery_Insert_F01.Append;

                      FDQuery_Insert_F01Empresa.AsString      := varEmpresa;
                      FDQuery_Insert_F01ANO.AsInteger         := StrToInt(varANO);
                      FDQuery_Insert_F01NUMERO_CONTA.AsString := varConta;
                      FDQuery_Insert_F01TIPO.AsString         := varTipo;
                      FDQuery_Insert_F01VALOR_FIS_01.AsFloat  := varValor_01;
                      FDQuery_Insert_F01VALOR_FIS_02.AsFloat  := varValor_02;
                      FDQuery_Insert_F01VALOR_FIS_03.AsFloat  := varValor_03;
                      FDQuery_Insert_F01VALOR_FIS_04.AsFloat  := varValor_04;
                      FDQuery_Insert_F01VALOR_FIS_05.AsFloat  := varValor_05;
                      FDQuery_Insert_F01VALOR_FIS_06.AsFloat  := varValor_06;
                      FDQuery_Insert_F01VALOR_FIS_07.AsFloat  := varValor_07;
                      FDQuery_Insert_F01VALOR_FIS_08.AsFloat  := varValor_08;
                      FDQuery_Insert_F01VALOR_FIS_09.AsFloat  := varValor_09;
                      FDQuery_Insert_F01VALOR_FIS_10.AsFloat  := varValor_10;
                      FDQuery_Insert_F01VALOR_FIS_11.AsFloat  := varValor_11;
                      FDQuery_Insert_F01VALOR_FIS_12.AsFloat  := varValor_12;
                      FDQuery_Insert_F01VALOR_FIS_13.AsFloat  := varValor_13;
                      FDQuery_Insert_F01ECF_CONTROLE_ID.AsInteger := varControle_ID;



                     try

                        FDQuery_Insert_F01.Post;

                      except

                        on E: Exception do
                        begin

                          Mensagem( 'Post: ' + E.Message );
                          FDQuery_Insert_F01.Cancel;

                        end;

                      end;



                      try


                        FDQuery_Insert_F01.ApplyUpdates;


                        FDQuery_Insert_F01.CommitUpdates;

                      except

                        on E: Exception do
                        begin

                          Mensagem( 'CommitUpdates: ' + E.Message );

                        end;

                      end;



                    except

                      on E: Exception do
                      begin

                        Mensagem( 'Erro: ' + IntToStr( X ) + E.Message );

                      end;

                    end;

                    Inc(X);
                  end;

              end;
            finally


              FDQuery_Insert_F01.Close;

            end;



            for I  := 0 to High(vetArquivos) do
            begin
                varArquivo.Clear;
                varArquivo.LoadFromFile('\\GHOS2024\Brady\Files\L210\'+vetArquivos[I]);
                FDQuery_Insert_KE5Z.Open;
                Try
                   X := 0;
                   Mensagem( 'Lendo linhas do arquivo ' + varArquivo[I] );
                   while X <= varArquivo.Count-1 do
                   begin
                      varPlant              :='';
                      varDC                 :='';
                      varACC_NUMBER         :='';
                      varPURCHASING_DOC     :='';
                      varACC_NUMBER_VEN_CRE :='';
                      varNAME               :='';
                      varPOSITION_PERIODO   :='';
                      varFISCAL_YEAR        :='';
                      varAMOUNT             := 0.00;
                      varMOEDA              :='';
                      varPAIS               :='';

                      try
                        if not (varArquivo[X].CountChar('|') = 11) then
                           Continue;


                        Mensagem( 'Linha (" ' + IntToStr(X) + '/' + IntToStr(varArquivo.Count-1) + '") "' + Trim(varArquivo[X].Split(['|'])[1]) + '" ...' );

                        varPlant               := varArquivo[X].Split(['|'])[1].Trim;
                        varDC                  := varArquivo[X].Split(['|'])[2].Trim;
                        varACC_NUMBER          := varArquivo[X].Split(['|'])[3].Trim;
                        varPURCHASING_DOC      := varArquivo[X].Split(['|'])[4].Trim;
                        varACC_NUMBER_VEN_CRE  := varArquivo[X].Split(['|'])[5].Trim;
                        varNAME                := varArquivo[X].Split(['|'])[6].Trim;
                        varPOSITION_PERIODO    := varArquivo[X].Split(['|'])[7].Trim;
                        varFISCAL_YEAR         := varArquivo[X].Split(['|'])[8].Trim;
                        varAMOUNT              := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[9].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                        varMOEDA               := varArquivo[X].Split(['|'])[10].Trim;
                        varPAIS                := varArquivo[X].Split(['|'])[11].Trim;

                        FDQuery_Insert_KE5Z.Append;

                        FDQuery_Insert_KE5ZPlant.AsString               := varPlant;
                        FDQuery_Insert_KE5ZDC.AsString                  := varDC;
                        FDQuery_Insert_KE5ZACC_NUMBER.AsString          := varACC_NUMBER;
                        FDQuery_Insert_KE5ZPURCHASING_DOC.AsString      := varPURCHASING_DOC;
                        FDQuery_Insert_KE5ZACC_NUMBER_VEN_CRE.AsString  := varACC_NUMBER_VEN_CRE;
                        FDQuery_Insert_KE5ZNAME.AsString                := varNAME;
                        FDQuery_Insert_KE5ZPOSITION_PERIODO.AsString    := varPOSITION_PERIODO;
                        FDQuery_Insert_KE5ZFISCAL_YEAR.AsString         := varFISCAL_YEAR;
                        FDQuery_Insert_KE5ZAMOUNT.AsFloat               := varAMOUNT;
                        FDQuery_Insert_KE5ZMOEDA.AsString               := varMOEDA;
                        FDQuery_Insert_KE5ZPAIS.AsString                := varPAIS;
                        FDQuery_Insert_KE5ZECF_CONTROLE_ID.AsInteger    := varControle_ID;

                       try

                          FDQuery_Insert_KE5Z.Post;

                        except

                          on E: Exception do
                          begin

                            Mensagem( 'Post: ' + E.Message );
                            FDQuery_Insert_KE5Z.Cancel;

                          end;

                        end;



                        try


                          FDQuery_Insert_KE5Z.ApplyUpdates;


                          FDQuery_Insert_KE5Z.CommitUpdates;

                        except

                          on E: Exception do
                          begin

                            Mensagem( 'CommitUpdates: ' + E.Message );
                            MessageDlg(E.Message,mtInformation,[mbOk],0);
                          end;

                        end;


                      except

                        on E: Exception do
                        begin

                          Mensagem( 'Erro: ' + IntToStr( X ) + E.Message );
                          MessageDlg(E.Message,mtInformation,[mbOk],0);
                        end;

                      end;

                      Inc(X);
                   end;

                Finally
                   FDQuery_Insert_KE5Z.Close;

                End;

            end;


          //***************

            varArquivo.Clear;
            Try
               FDQuery_FBL3N.Open;
               Try
                   for I := Low(vetArquivosFBL3N) to High(vetArquivosFBL3N) do
                   begin
                      varArquivo.Clear;
                      varArquivo.LoadFromFile( '\\GHOS2024\Brady\Files\L210\' + vetArquivosFBL3N[I] );
                      vaarCD := '';
                      varNUMERO_CONTA := '';
                      varCENTRO_CUSTO := '';
                      varVALORCONTABIL := 0;
                      varDCCONTABIL := '';
                      varDATA := 0;
                      varMOEDACONTABIL := '';

                      try
                          X := 0;
                          Mensagem( 'Lendo linhas do arquivo ' + vetArquivosFBL3N[I] );
                          while X <= varArquivo.Count-1 do
                          begin
                            vaarCD           := varArquivo[X].Split(['|'])[1].Trim;
                            varNUMERO_CONTA  := varArquivo[X].Split(['|'])[2].Trim;
                            varCENTRO_CUSTO  := varArquivo[X].Split(['|'])[3].Trim;
                            varDATA          := EncodeDate( StrToInt(Copy(varArquivo[X].Split(['|'])[4],1,4)), StrToInt(Copy(varArquivo[X].Split(['|'])[4],5,2)), StrToInt(Copy(varArquivo[X].Split(['|'])[4],7,2)));
                            varDCCONTABIL    := varArquivo[X].Split(['|'])[7].Trim;
                            if varDCCONTABIL = 'H' then
                             varVALORCONTABIL :=  StrToFloat(varArquivo[X].Split(['|'])[5].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )) * -1
                            else  varVALORCONTABIL := StrToFloat(varArquivo[X].Split(['|'])[5].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] ));

                            varMOEDACONTABIL := varArquivo[X].Split(['|'])[6].Trim;


                            FDQuery_FBL3N.Append;

                            FDQuery_FBL3NCD.AsString           := vaarCD;
                            FDQuery_FBL3NNUMERO_CONTA.AsString := varNUMERO_CONTA;
                            FDQuery_FBL3NCENTRO_CUSTO.AsString := varCENTRO_CUSTO;
                            FDQuery_FBL3NDATA.asDateTime       := varDATA;
                            ConfiguraAnoFiscal(varData);
                            FDQuery_FBL3NANO_FISCAL.AsString   := varExercicio_AnoFiscal;
                            FDQuery_FBL3NMES_FISCAL.AsString   := varExercicio_MesFiscal;
                            FDQuery_FBL3NVALOR.AsFloat         := varVALORCONTABIL;
                            FDQuery_FBL3NMOEDA.AsString        := varMOEDACONTABIL;
                            FDQuery_FBL3NDC.AsString           := varDCCONTABIL;
                            FDQuery_FBL3NECF_CONTROLE_ID.AsInteger  := varControle_ID;

                            try

                               FDQuery_FBL3N.Post;

                             except

                               on E: Exception do
                               begin

                                 Mensagem( 'Post: ' +  E.Message );
                                 FDQuery_FBL3N.Cancel;

                               end;

                            end;



                            try


                                FDQuery_FBL3N.ApplyUpdates;


                                FDQuery_FBL3N.CommitUpdates;

                            except

                               on E: Exception do
                               begin

                                 Mensagem( 'CommitUpdates: ' + E.Message );
                                 MessageDlg(E.Message,mtInformation,[mbOk],0);
                               end;
                            end;
                            Inc(X);

                         end;
                      except

                          on E: Exception do
                          begin

                            Mensagem( 'Erro: ' + IntToStr( X ) + E.Message );
                            MessageDlg(E.Message,mtInformation,[mbOk],0);
                          end;

                      end;
                   end;
               Finally
                  FDQuery_FBL3N.Close;
               End;

            except
                  on E: Exception do
                  begin

                    Mensagem( 'Erro: ' + E.Message );
                    MessageDlg(E.Message,mtInformation,[mbOk],0);
                  end;

            end;


          finally

            FDConnection.Close;

          end;


      finally

        FreeAndNil(varArquivo);

      end;

    finally

       Mensagem('');

    end;

  end;


end;

procedure TfrmProcessarL210.CalcularLinha29a;
var
 Ano, Ano_Fut, Ano_Ant: Integer;
begin
  varSaldoTempJan := 0;
  varSaldoTempFev := 0;
  varSaldoTempMar := 0;
  varSaldoTempAbr := 0;
  varSaldoTempMai := 0;
  varSaldoTempJun := 0;
  varSaldoTempJul := 0;
  varSaldoTempAgo := 0;
  varSaldoTempSep := 0;
  varSaldoTempOtu := 0;
  varSaldoTempNov := 0;
  varSaldoTempDez := 0;

  Ano     :=  StrToInt(cxAno.Text);
  Ano_Ant :=  StrToInt(cxAno.Text)-1;
  Ano_Fut :=  StrToInt(cxAno.Text)+1;


  FDQueryGrid.First;
  while Not FDQueryGrid.EOF do
  begin
    if ((FDQueryGridCODIGO_LINHA.AsString = '2')   or
        (FDQueryGridCODIGO_LINHA.AsString = '30')  or
        (FDQueryGridCODIGO_LINHA.AsString = '3')   or
        (FDQueryGridCODIGO_LINHA.AsString = '4')   or
        (FDQueryGridCODIGO_LINHA.AsString = '9')   or
        (FDQueryGridCODIGO_LINHA.AsString = '11')  or
        (FDQueryGridCODIGO_LINHA.AsString = '15')  or
        (FDQueryGridCODIGO_LINHA.AsString = '16')  or
        (FDQueryGridCODIGO_LINHA.AsString = '18')  or
        (FDQueryGridCODIGO_LINHA.AsString = '23')  or
        (FDQueryGridCODIGO_LINHA.AsString = '29')  or
        (FDQueryGridCODIGO_LINHA.AsString = '29B') or
        (FDQueryGridCODIGO_LINHA.AsString = '29C')) Then
        begin
          varSaldoTempJan := varSaldoTempJan + FDQueryGridJANEIRO.AsCurrency;
          varSaldoTempFev := varSaldoTempFev + FDQueryGridFEVEREIRO.AsCurrency;
          varSaldoTempMar := varSaldoTempMar + FDQueryGridMARCO.AsCurrency;
          varSaldoTempAbr := varSaldoTempAbr + FDQueryGridABRIL.AsCurrency;
          varSaldoTempMai := varSaldoTempMai + FDQueryGridMAIO.AsCurrency;
          varSaldoTempJun := varSaldoTempJun + FDQueryGridJUNHO.AsCurrency;
          varSaldoTempJul := varSaldoTempJul + FDQueryGridJULHO.AsCurrency;
          varSaldoTempAgo := varSaldoTempAgo + FDQueryGridAGOSTO.AsCurrency;
          varSaldoTempSep := varSaldoTempSep + FDQueryGridSETEMBRO.AsCurrency;
          varSaldoTempOtu := varSaldoTempOtu + FDQueryGridOUTUBRO.AsCurrency;
          varSaldoTempNov := varSaldoTempNov + FDQueryGridNOVEMBRO.AsCurrency;
          varSaldoTempDez := varSaldoTempDez + FDQueryGridDEZEMBRO.AsCurrency;
        end;

        FDQueryGrid.Next;

  end;

  CriarSaldo(IntToStr(Ano_Ant), IntToStr(Ano), '29A','Varia��o do Custo Mensal','11');

end;


procedure TfrmProcessarL210.CalcularLinha31;
var
 Ano, Ano_Fut, Ano_Ant: Integer;
begin
  varSaldoTempJan := 0;
  varSaldoTempFev := 0;
  varSaldoTempMar := 0;
  varSaldoTempAbr := 0;
  varSaldoTempMai := 0;
  varSaldoTempJun := 0;
  varSaldoTempJul := 0;
  varSaldoTempAgo := 0;
  varSaldoTempSep := 0;
  varSaldoTempOtu := 0;
  varSaldoTempNov := 0;
  varSaldoTempDez := 0;

  Ano     :=  StrToInt(cxAno.Text);
  Ano_Ant :=  StrToInt(cxAno.Text)-1;
  Ano_Fut :=  StrToInt(cxAno.Text)+1;


  FDQueryGrid.First;
  while Not FDQueryGrid.EOF do
  begin
    if ((FDQueryGridCODIGO_LINHA.AsString = '2')   or
        (FDQueryGridCODIGO_LINHA.AsString = '3')   or
        (FDQueryGridCODIGO_LINHA.AsString = '4')   or

        (FDQueryGridCODIGO_LINHA.AsString = '9')   or
        (FDQueryGridCODIGO_LINHA.AsString = '11')  or
        (FDQueryGridCODIGO_LINHA.AsString = '15')  or
        (FDQueryGridCODIGO_LINHA.AsString = '16')  or
        (FDQueryGridCODIGO_LINHA.AsString = '18')  or
        (FDQueryGridCODIGO_LINHA.AsString = '23')  or

        (FDQueryGridCODIGO_LINHA.AsString = '29')) Then


        begin
          varSaldoTempJan := varSaldoTempJan + FDQueryGridJANEIRO.AsCurrency;
          varSaldoTempFev := varSaldoTempFev + FDQueryGridFEVEREIRO.AsCurrency;
          varSaldoTempMar := varSaldoTempMar + FDQueryGridMARCO.AsCurrency;
          varSaldoTempAbr := varSaldoTempAbr + FDQueryGridABRIL.AsCurrency;
          varSaldoTempMai := varSaldoTempMai + FDQueryGridMAIO.AsCurrency;
          varSaldoTempJun := varSaldoTempJun + FDQueryGridJUNHO.AsCurrency;
          varSaldoTempJul := varSaldoTempJul + FDQueryGridJULHO.AsCurrency;
          varSaldoTempAgo := varSaldoTempAgo + FDQueryGridAGOSTO.AsCurrency;
          varSaldoTempSep := varSaldoTempSep + FDQueryGridSETEMBRO.AsCurrency;
          varSaldoTempOtu := varSaldoTempOtu + FDQueryGridOUTUBRO.AsCurrency;
          varSaldoTempNov := varSaldoTempNov + FDQueryGridNOVEMBRO.AsCurrency;
          varSaldoTempDez := varSaldoTempDez + FDQueryGridDEZEMBRO.AsCurrency;
        end;

        FDQueryGrid.Next;

  end;

  CriarSaldo(IntToStr(Ano_Ant), IntToStr(Ano),  '31','CUSTO DOS PRODUTOS DE FABRICA��O PR�PRIA VENDIDOS', '14');

end;


function TfrmProcessarL210.CalcularSaldo(pIndice : Integer; pMES_ANT : String ='') : Currency;
var
 i              : Integer;
 iTotalRegistro : Integer;
 varMeses       : Currency;
 varMesAnterior : Currency;
begin

   varMeses       := 0;
   varMesAnterior := 0;
   iTotalRegistro := 0;

   if pIndice = -1 then
   begin
     FDQueryAux.Close;
     FDQueryAux.SQL.Clear;
     FDQueryAux.SQL.Add('SELECT COUNT(1) as TOTAL FROM  ECF_SALDO');
     FDQueryAux.Open;
     iTotalRegistro := FDQueryAux.FieldByName('TOTAL').AsInteger;
     if iTotalRegistro = 0 then
     begin
       FDQueryAux.Close;
       FDQueryAux.SQL.Clear;
       FDQueryAux.SQL.Add('SELECT C.ORDEM,  C.CODIGO_LINHA, C.DESC_L210, C.SUBGRUPO, ');
       FDQueryAux.SQL.Add('SUM(M.VALOR_FIS_01)  + SUM(M.VALOR_FIS_02) + SUM(M.VALOR_FIS_03) + SUM(M.VALOR_FIS_04) + SUM(M.VALOR_FIS_05) + SUM(M.VALOR_FIS_06) AS DEZEMBRO ');
       FDQueryAux.SQL.Add(' FROM ECF_MOV_F01 M ');
       FDQueryAux.SQL.Add(' INNER JOIN ECF_CONTA C ON C.NUMERO_CONTA = M.NUMERO_CONTA AND C.CODIGO_LINHA = ''2'' ');
       FDQueryAux.SQL.Add(' Where M.ANO = :MES_ANT ');
       FDQueryAux.SQL.Add(' GROUP BY  C.ORDEM, C.CODIGO_LINHA, C.DESC_L210,C.SUBGRUPO ');
       FDQueryAux.Params.ParamByName('MES_ANT').AsString := pMES_ANT;
       FDQueryAux.Open;
       varMesAnterior  := FDQueryAux.FieldByName('DEZEMBRO').AsFloat;
     end
     else
     begin

         FDQueryRemontaSaldo.Close;
         FDQueryRemontaSaldo.ParamByName( 'ANO' ).AsInteger     :=  StrToInt(pMES_ANT);
         FDQueryRemontaSaldo.Open;

         FDQueryRemontaSaldo.First;
         varMeses := 0;
         while not FDQueryRemontaSaldo.eof do
         begin
           varMesAnterior  := varMesAnterior + FDQueryRemontaSaldo.FieldList.Fields[11 + 4].AsCurrency;
           FDQueryRemontaSaldo.Next;
         end;

     end;

   end;

   if pIndice >= 0 then
   begin

     FDQueryRemontaSaldo.First;
     varMeses := 0;
     while not FDQueryRemontaSaldo.eof do
     begin
        varMeses  := varMeses + FDQueryRemontaSaldo.FieldList.Fields[pIndice + 4].AsCurrency;
        FDQueryRemontaSaldo.Next;
     end;

   end;


   if (pIndice = -1) Then
      varMeses  := varMesAnterior;


   result := VarMeses;
end;

procedure TfrmProcessarL210.CriarSaldo(pAnoAnterior, pAno, pCodigoLinha, pDescricao, pOrdem : String);

begin

  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
  FDQueryAux.SQL.Add('Delete from ECF_SALDO Where ANO = :ANO and ANO_ANTERIOR = :ANO_ANTERIOR AND CODIGO_LINHA = :CODIGO_LINHA');
  FDQueryAux.Params.ParamByName('ANO').AsString          := pAno;
  FDQueryAux.Params.ParamByName('ANO_ANTERIOR').AsString := pAnoAnterior;
  FDQueryAux.Params.ParamByName('CODIGO_LINHA').AsString := pCodigoLinha;
  FDQueryAux.ExecSQL;


  FDQueryCriaSaldo.Open;
  FDQueryCriaSaldo.Append;
  FDQueryCriaSaldoANO.AsString          := pAno;
  FDQueryCriaSaldoANO_ANTERIOR.AsString := pAnoAnterior;
  FDQueryCriaSaldoDESC_L210.AsString    := pDescricao;
  FDQueryCriaSaldoCODIGO_LINHA.AsString := pCodigoLinha;
  FDQueryCriaSaldoJANEIRO.AsCurrency    := varSaldoTempJan;
  FDQueryCriaSaldoFEVEREIRO.AsCurrency  := varSaldoTempFev;
  FDQueryCriaSaldoMARCO.AsCurrency      := varSaldoTempMar;
  FDQueryCriaSaldoABRIL.AsCurrency      := varSaldoTempAbr;
  FDQueryCriaSaldoMAIO.AsCurrency       := varSaldoTempMai;
  FDQueryCriaSaldoJUNHO.AsCurrency      := varSaldoTempJun;
  FDQueryCriaSaldoJULHO.AsCurrency      := varSaldoTempJul;
  FDQueryCriaSaldoAGOSTO.AsCurrency     := varSaldoTempAgo;
  FDQueryCriaSaldoSETEMBRO.AsCurrency   := varSaldoTempSep;
  FDQueryCriaSaldoOUTUBRO.AsCurrency    := varSaldoTempOtu;
  FDQueryCriaSaldoNOVEMBRO.AsCurrency   := varSaldoTempNov;
  FDQueryCriaSaldoDEZEMBRO.AsCurrency   := varSaldoTempDez;

  try

     FDQueryCriaSaldo.Post;

   except

     on E: Exception do
     begin

       Mensagem( 'Post: ' + E.Message );
       FDQueryCriaSaldo.Cancel;

     end;

  end;


  try
      FDQueryCriaSaldo.ApplyUpdates;
      FDQueryCriaSaldo.CommitUpdates;

  except

     on E: Exception do
     begin
       Mensagem( 'CommitUpdates: ' + E.Message );
       MessageDlg(E.Message,mtInformation,[mbOk],0);
     end;
  end;
  FDQueryCriaSaldo.Close;
end;

procedure TfrmProcessarL210.ButPesquisarClick(Sender: TObject);
var
 i, Value : Integer;
begin
  if cxAno.Text = EmptyStr then
    raise Exception.Create('Per�odo n�o informado');

  if Page.ActivePageIndex = 0 then
  begin

    i     := cxAno.ItemIndex;
    Value := Integer(cxAno.Properties.Items.Objects[i]);

    FDQueryGrid.Close;
    FDQueryGrid.ParamByName( 'ANO_FUT' ).AsInteger      :=  StrToInt(cxAno.Text)+1;
    FDQueryGrid.ParamByName( 'ANO' ).AsInteger          :=  StrToInt(cxAno.Text);
    FDQueryGrid.ParamByName( 'CONTROLE_ID' ).AsInteger  :=  Value;

    FDQueryGrid.Open;
    if FDQueryGrid.IsEmpty then
       MessageDlg('Ano selecionado n�o importado do SAP',mtInformation,[mbOk],0);

  end
  else
  begin

    i     := cxAno.ItemIndex;
    Value := Integer(cxAno.Properties.Items.Objects[i]);

    FDQueryMapa.Close;
    FDQueryMapa.ParamByName( 'ANO_ANT' ).AsInteger :=  StrToInt(cxAno.Text)-1;
    FDQueryMapa.ParamByName( 'ANO' ).AsInteger     :=  StrToInt(cxAno.Text);
    FDQueryGrid.ParamByName( 'CONTROLE_ID' ).AsInteger  :=  Value;
    FDQueryMapa.Open;
    if FDQueryMapa.IsEmpty then
       MessageDlg('Ano selecionado n�o importado do SAP',mtInformation,[mbOk],0);
  end;

end;

procedure TfrmProcessarL210.ButSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmProcessarL210.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Self := NIL;
end;

procedure TfrmProcessarL210.FormCreate(Sender: TObject);
Var
 I : Integer;
begin
  Page.ActivePage := cxTabL210;
  cxAno.ItemIndex := cxAno.Properties.Items.IndexOf(FormatDateTime('yyyy',Date));
  FDQueryControle.Close;
  FDQueryControle.Open;
  FDQueryControle.First;
  while not FDQueryControle.eof do
  begin
     I  := FDQueryControleECF_CONTROLE_ID.AsInteger;
     cxAno.Properties.Items.AddObject(FDQueryControleANO.AsString, TObject(I));
     FDQueryControle.Next;
  end;


end;

procedure TfrmProcessarL210.Importar_Arquivos_Fiscal(Ano : String);
var
  myStringAnt, myStringAtual  : AnsiString;
  myCharPtrAnt, myCharPtrAtual : PAnsiChar;
  i : Integer;

begin
 myStringAnt   := '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000388 GL_BALANCE /'+IntToStr(StrToInt(ANO)-1)+' \\ghos2024\Brady\Files\L210\BR_L210_MOV-'+IntToStr(StrToInt(ANO)-1)+'.TXT';
 myStringAtual := '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000388 GL_BALANCE /'+ANO+' \\ghos2024\Brady\Files\L210\BR_L210_MOV-'+ANO+'.TXT';
 i := 1;
 myCharPtrAnt   := Addr(myStringAnt[i]);
 myCharPtrAtual := Addr(myStringAtual[i]);

 try

     WinExec( myCharPtrAnt, 1);
     WinExec( myCharPtrAtual, 1);


     WinExec( '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000544 L210-KE5Z OUT_CUST_1 \\ghos2024\Brady\Files\L210\BR-L210-OUT_CUST_1.TXT', 1);
     WinExec( '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000544 L210-KE5Z OUT_CUST_2 \\ghos2024\Brady\Files\L210\BR-L210-OUT_CUST_2.TXT', 1);

     WinExec( '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000544 L210-KE5Z INS_MERC   \\ghos2024\Brady\Files\L210\BR-L210-INS_MERC.TXT', 1);
     WinExec( '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000544 L210-KE5Z INS_MERC_2 \\ghos2024\Brady\Files\L210\BR-L210-INS_MERC_2.TXT', 1);

     WinExec( '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000544 FBL3N FBL3N_JAN \\ghos2024\Brady\Files\L210\FBL3N_JAN.TXT', 1);
     WinExec( '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000544 FBL3N FBL3N_FEV \\ghos2024\Brady\Files\L210\FBL3N_FEV.TXT', 1);
     WinExec( '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000544 FBL3N FBL3N_MAR \\ghos2024\Brady\Files\L210\FBL3N_MAR.TXT', 1);
     WinExec( '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000544 FBL3N FBL3N_APR \\ghos2024\Brady\Files\L210\FBL3N_APR.TXT', 1);
     WinExec( '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000544 FBL3N FBL3N_MAY \\ghos2024\Brady\Files\L210\FBL3N_MAY.TXT', 1);
     WinExec( '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000544 FBL3N FBL3N_JUN \\ghos2024\Brady\Files\L210\FBL3N_JUN.TXT', 1);
     WinExec( '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000544 FBL3N FBL3N_JUL \\ghos2024\Brady\Files\L210\FBL3N_JUL.TXT', 1);
     WinExec( '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000544 FBL3N FBL3N_AUG \\ghos2024\Brady\Files\L210\FBL3N_AUG.TXT', 1);
     WinExec( '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000544 FBL3N FBL3N_SEP \\ghos2024\Brady\Files\L210\FBL3N_SEP.TXT', 1);
     WinExec( '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000544 FBL3N FBL3N_OCT \\ghos2024\Brady\Files\L210\FBL3N_OCT.TXT', 1);
     WinExec( '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000544 FBL3N FBL3N_NOV \\ghos2024\Brady\Files\L210\FBL3N_NOV.TXT', 1);
     WinExec( '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000544 FBL3N FBL3N_DEZ \\ghos2024\Brady\Files\L210\FBL3N_DEZ.TXT', 1);

 finally
     Mensagem( EmptyStr );
 end;

end;

end.

