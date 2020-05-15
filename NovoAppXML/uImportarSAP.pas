unit uImportarSAP;

interface

uses
  System.DateUtils,
  dxHashUtils,
  dxSpreadSheet,
  dxSpreadSheetTypes,
  dxSpreadSheetCore,
  Vcl.FileCtrl,
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
  Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, cxControls, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLabel, dxGDIPlusClasses,
  cxCheckBox, dxBarBuiltInMenu, cxPC, dxSkinsdxStatusBarPainter, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxCalendar, EditBusca, dxStatusBar, Vcl.Mask, rsEdit,
  RseditDB, Datasnap.Provider, Datasnap.DBClient, cxCheckListBox, Vcl.ImgList,
  cxGroupBox;

type
  TfrmImportarSAP = class(TForm)
    pnlBarra: TPanel;
    Shape1: TShape;
    ButSair: TcxButton;
    dsControle: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    cxAno: TcxComboBox;
    ButExcluir: TcxButton;
    btnImportar: TcxButton;
    FDQueryAux: TFDQuery;
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
    FDQueryGrid: TFDQuery;
    FDQueryGridORDEM: TIntegerField;
    FDQueryGridCODIGO_LINHA: TStringField;
    FDQueryGridDESC_L210: TStringField;
    FDQueryGridJANEIRO: TFMTBCDField;
    FDQueryGridFEVEREIRO: TFMTBCDField;
    FDQueryGridMARCO: TFMTBCDField;
    FDQueryGridABRIL: TFMTBCDField;
    FDQueryGridMAIO: TFMTBCDField;
    FDQueryGridJUNHO: TFMTBCDField;
    FDQueryGridJULHO: TFMTBCDField;
    FDQueryGridAGOSTO: TFMTBCDField;
    FDQueryGridSETEMBRO: TFMTBCDField;
    FDQueryGridOUTUBRO: TFMTBCDField;
    FDQueryGridNOVEMBRO: TFMTBCDField;
    FDQueryGridDEZEMBRO: TFMTBCDField;
    ButCancelar: TcxButton;
    chkImportar: TcxCheckBox;
    FDQueryControle: TFDQuery;
    FDQueryControleECF_CONTROLE_ID: TFDAutoIncField;
    FDQueryControleANO: TStringField;
    FDQueryControleANO_ANTERIOR: TStringField;
    FDQueryControleDATA_IMPORT: TSQLTimeStampField;
    Page: TcxPageControl;
    TabControle: TcxTabSheet;
    TabInventario: TcxTabSheet;
    TabRateio: TcxTabSheet;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1ECF_CONTROLE_ID: TcxGridDBColumn;
    cxGrid1DBTableView1ANO: TcxGridDBColumn;
    cxGrid1DBTableView1ANO_ANTERIOR: TcxGridDBColumn;
    cxGrid1DBTableView1DATA_IMPORT: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    Panel7: TPanel;
    Image1: TImage;
    cxLabel2: TcxLabel;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    OpenDialog: TOpenDialog;
    sqlGrupo: TFDQuery;
    sqlCC: TFDQuery;
    sqlAux: TFDQuery;
    FDQueryRateio: TFDQuery;
    dsRateio: TDataSource;
    FDQueryRateioGRUPO: TIntegerField;
    FDQueryRateioCENTRO_CUSTO: TStringField;
    FDQueryRateioCENTRO_CUSTO_1: TStringField;
    FDQueryRateioPERCENTUAL: TBCDField;
    FDQueryRateioEXERCICIO: TStringField;
    FDQueryRateioPERIODO_FISCAL: TStringField;
    cxGrid2DBTableView1GRUPO: TcxGridDBColumn;
    cxGrid2DBTableView1CENTRO_CUSTO: TcxGridDBColumn;
    cxGrid2DBTableView1CENTRO_CUSTO_1: TcxGridDBColumn;
    cxGrid2DBTableView1PERCENTUAL: TcxGridDBColumn;
    cxGrid2DBTableView1EXERCICIO: TcxGridDBColumn;
    cxGrid2DBTableView1PERIODO_FISCAL: TcxGridDBColumn;
    cxPageControl1: TcxPageControl;
    TabF01: TcxTabSheet;
    TabKe5z: TcxTabSheet;
    TabFbl3n: TcxTabSheet;
    cxGrid3: TcxGrid;
    cxGrid3DBTableView1: TcxGridDBTableView;
    cxGrid3Level1: TcxGridLevel;
    Panel2: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    cxGrid4DBTableView1: TcxGridDBTableView;
    cxGrid4Level1: TcxGridLevel;
    cxGrid4: TcxGrid;
    cxGrid5DBTableView1: TcxGridDBTableView;
    cxGrid5Level1: TcxGridLevel;
    cxGrid5: TcxGrid;
    ButPesquisar: TcxButton;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    FDQueryF01: TFDQuery;
    dsF01: TDataSource;
    cdsF01: TClientDataSet;
    dspF01: TDataSetProvider;
    FDQueryF01ECF_MOV_F01_ID: TFDAutoIncField;
    FDQueryF01NUMERO_CONTA: TStringField;
    FDQueryF01TIPO: TStringField;
    FDQueryF01VALOR_FIS_01: TBCDField;
    FDQueryF01VALOR_FIS_02: TBCDField;
    FDQueryF01VALOR_FIS_03: TBCDField;
    FDQueryF01VALOR_FIS_04: TBCDField;
    FDQueryF01VALOR_FIS_05: TBCDField;
    FDQueryF01VALOR_FIS_06: TBCDField;
    FDQueryF01VALOR_FIS_07: TBCDField;
    FDQueryF01VALOR_FIS_08: TBCDField;
    FDQueryF01VALOR_FIS_09: TBCDField;
    FDQueryF01VALOR_FIS_10: TBCDField;
    FDQueryF01VALOR_FIS_11: TBCDField;
    FDQueryF01VALOR_FIS_12: TBCDField;
    FDQueryF01VALOR_FIS_13: TBCDField;
    FDQueryF01ANO: TIntegerField;
    FDQueryF01EMPRESA: TStringField;
    FDQueryF01DATA_IMPORT: TSQLTimeStampField;
    FDQueryF01ECF_CONTROLE_ID: TIntegerField;
    cdsF01ECF_MOV_F01_ID: TAutoIncField;
    cdsF01NUMERO_CONTA: TStringField;
    cdsF01TIPO: TStringField;
    cdsF01VALOR_FIS_01: TBCDField;
    cdsF01VALOR_FIS_02: TBCDField;
    cdsF01VALOR_FIS_03: TBCDField;
    cdsF01VALOR_FIS_04: TBCDField;
    cdsF01VALOR_FIS_05: TBCDField;
    cdsF01VALOR_FIS_06: TBCDField;
    cdsF01VALOR_FIS_07: TBCDField;
    cdsF01VALOR_FIS_08: TBCDField;
    cdsF01VALOR_FIS_09: TBCDField;
    cdsF01VALOR_FIS_10: TBCDField;
    cdsF01VALOR_FIS_11: TBCDField;
    cdsF01VALOR_FIS_12: TBCDField;
    cdsF01VALOR_FIS_13: TBCDField;
    cdsF01ANO: TIntegerField;
    cdsF01EMPRESA: TStringField;
    cdsF01DATA_IMPORT: TSQLTimeStampField;
    cdsF01ECF_CONTROLE_ID: TIntegerField;
    cxGrid3DBTableView1NUMERO_CONTA: TcxGridDBColumn;
    cxGrid3DBTableView1TIPO: TcxGridDBColumn;
    cxGrid3DBTableView1VALOR_FIS_01: TcxGridDBColumn;
    cxGrid3DBTableView1VALOR_FIS_02: TcxGridDBColumn;
    cxGrid3DBTableView1VALOR_FIS_03: TcxGridDBColumn;
    cxGrid3DBTableView1VALOR_FIS_04: TcxGridDBColumn;
    cxGrid3DBTableView1VALOR_FIS_05: TcxGridDBColumn;
    cxGrid3DBTableView1VALOR_FIS_06: TcxGridDBColumn;
    cxGrid3DBTableView1VALOR_FIS_07: TcxGridDBColumn;
    cxGrid3DBTableView1VALOR_FIS_08: TcxGridDBColumn;
    cxGrid3DBTableView1VALOR_FIS_09: TcxGridDBColumn;
    cxGrid3DBTableView1VALOR_FIS_10: TcxGridDBColumn;
    cxGrid3DBTableView1VALOR_FIS_11: TcxGridDBColumn;
    cxGrid3DBTableView1VALOR_FIS_12: TcxGridDBColumn;
    cxGrid3DBTableView1VALOR_FIS_13: TcxGridDBColumn;
    cxGrid3DBTableView1ANO: TcxGridDBColumn;
    cxGrid3DBTableView1EMPRESA: TcxGridDBColumn;
    cxGrid3DBTableView1DATA_IMPORT: TcxGridDBColumn;
    FDQueryKE5Z: TFDQuery;
    cdsKE5Z: TClientDataSet;
    dspKE5Z: TDataSetProvider;
    dsKE5Z: TDataSource;
    FDQueryKE5ZECF_MOV_KE5Z_ID: TFDAutoIncField;
    FDQueryKE5ZPlant: TStringField;
    FDQueryKE5ZDC: TStringField;
    FDQueryKE5ZACC_NUMBER: TStringField;
    FDQueryKE5ZPURCHASING_DOC: TStringField;
    FDQueryKE5ZACC_NUMBER_VEN_CRE: TStringField;
    FDQueryKE5ZNAME: TStringField;
    FDQueryKE5ZPOSITION_PERIODO: TStringField;
    FDQueryKE5ZANO_BASE: TStringField;
    FDQueryKE5ZFISCAL_YEAR: TStringField;
    FDQueryKE5ZAMOUNT: TBCDField;
    FDQueryKE5ZMOEDA: TStringField;
    FDQueryKE5ZPAIS: TStringField;
    FDQueryKE5ZDATA_IMPORT: TSQLTimeStampField;
    FDQueryKE5ZECF_CONTROLE_ID: TIntegerField;
    cdsKE5ZECF_MOV_KE5Z_ID: TAutoIncField;
    cdsKE5ZPlant: TStringField;
    cdsKE5ZDC: TStringField;
    cdsKE5ZACC_NUMBER: TStringField;
    cdsKE5ZPURCHASING_DOC: TStringField;
    cdsKE5ZACC_NUMBER_VEN_CRE: TStringField;
    cdsKE5ZNAME: TStringField;
    cdsKE5ZPOSITION_PERIODO: TStringField;
    cdsKE5ZANO_BASE: TStringField;
    cdsKE5ZFISCAL_YEAR: TStringField;
    cdsKE5ZAMOUNT: TBCDField;
    cdsKE5ZMOEDA: TStringField;
    cdsKE5ZPAIS: TStringField;
    cdsKE5ZDATA_IMPORT: TSQLTimeStampField;
    cdsKE5ZECF_CONTROLE_ID: TIntegerField;
    cxGrid4DBTableView1Plant: TcxGridDBColumn;
    cxGrid4DBTableView1DC: TcxGridDBColumn;
    cxGrid4DBTableView1ACC_NUMBER: TcxGridDBColumn;
    cxGrid4DBTableView1PURCHASING_DOC: TcxGridDBColumn;
    cxGrid4DBTableView1ACC_NUMBER_VEN_CRE: TcxGridDBColumn;
    cxGrid4DBTableView1NAME: TcxGridDBColumn;
    cxGrid4DBTableView1POSITION_PERIODO: TcxGridDBColumn;
    cxGrid4DBTableView1ANO_BASE: TcxGridDBColumn;
    cxGrid4DBTableView1FISCAL_YEAR: TcxGridDBColumn;
    cxGrid4DBTableView1AMOUNT: TcxGridDBColumn;
    cxGrid4DBTableView1DATA_IMPORT: TcxGridDBColumn;
    FDQueryFBL3N: TFDQuery;
    cdsFBL3N: TClientDataSet;
    dspFBL3N: TDataSetProvider;
    dsFBL3N: TDataSource;
    FDQueryFBL3NFBL3N_ID: TFDAutoIncField;
    FDQueryFBL3NCD: TStringField;
    FDQueryFBL3NNUMERO_CONTA: TStringField;
    FDQueryFBL3NCENTRO_CUSTO: TStringField;
    FDQueryFBL3NDATA: TDateField;
    FDQueryFBL3NANO_BASE: TStringField;
    FDQueryFBL3NANO_FISCAL: TStringField;
    FDQueryFBL3NMES_FISCAL: TStringField;
    FDQueryFBL3NVALOR: TBCDField;
    FDQueryFBL3NMOEDA: TStringField;
    FDQueryFBL3NDC: TStringField;
    FDQueryFBL3NDATA_IMPORT: TSQLTimeStampField;
    FDQueryFBL3NECF_CONTROLE_ID: TIntegerField;
    cdsFBL3NFBL3N_ID: TAutoIncField;
    cdsFBL3NCD: TStringField;
    cdsFBL3NNUMERO_CONTA: TStringField;
    cdsFBL3NCENTRO_CUSTO: TStringField;
    cdsFBL3NDATA: TDateField;
    cdsFBL3NANO_BASE: TStringField;
    cdsFBL3NANO_FISCAL: TStringField;
    cdsFBL3NMES_FISCAL: TStringField;
    cdsFBL3NVALOR: TBCDField;
    cdsFBL3NMOEDA: TStringField;
    cdsFBL3NDC: TStringField;
    cdsFBL3NDATA_IMPORT: TSQLTimeStampField;
    cdsFBL3NECF_CONTROLE_ID: TIntegerField;
    cxGrid5DBTableView1CD: TcxGridDBColumn;
    cxGrid5DBTableView1NUMERO_CONTA: TcxGridDBColumn;
    cxGrid5DBTableView1CENTRO_CUSTO: TcxGridDBColumn;
    cxGrid5DBTableView1DATA: TcxGridDBColumn;
    cxGrid5DBTableView1ANO_BASE: TcxGridDBColumn;
    cxGrid5DBTableView1ANO_FISCAL: TcxGridDBColumn;
    cxGrid5DBTableView1MES_FISCAL: TcxGridDBColumn;
    cxGrid5DBTableView1VALOR: TcxGridDBColumn;
    cxGrid5DBTableView1DC: TcxGridDBColumn;
    cxGrid5DBTableView1DATA_IMPORT: TcxGridDBColumn;
    FDQueryGridSUBGRUPO: TFloatField;
    pnlConsultas: TPanel;
    cxGrid6DBTableView1: TcxGridDBTableView;
    cxGrid6Level1: TcxGridLevel;
    cxGrid6: TcxGrid;
    FDQueryConsultaSAP: TFDQuery;
    dsConsultaSAP: TDataSource;
    FDQueryConsultaSAPECF_CONSULTA_ID: TIntegerField;
    FDQueryConsultaSAPNOME: TStringField;
    FDQueryConsultaSAPUSUARIO_SAP: TStringField;
    FDQueryConsultaSAPQUERY: TStringField;
    FDQueryConsultaSAPVARIANTE: TStringField;
    FDQueryConsultaSAPANO: TStringField;
    FDQueryConsultaSAPDATA_CADASTRO: TSQLTimeStampField;
    cxGrid6DBTableView1ECF_CONSULTA_ID: TcxGridDBColumn;
    cxGrid6DBTableView1NOME: TcxGridDBColumn;
    cxGrid6DBTableView1USUARIO_SAP: TcxGridDBColumn;
    cxGrid6DBTableView1QUERY: TcxGridDBColumn;
    cxGrid6DBTableView1VARIANTE: TcxGridDBColumn;
    cxGrid6DBTableView1ANO: TcxGridDBColumn;
    cxGrid6DBTableView1DATA_CADASTRO: TcxGridDBColumn;
    FDQueryConsultaSAPSELECAO: TStringField;
    cxGrid6DBTableView1SELECAO: TcxGridDBColumn;
    Panel3: TPanel;
    FDQueryAux2: TFDQuery;
    Panel6: TPanel;
    chkTodos: TCheckBox;
    chkNenhum: TCheckBox;
    btnProcessar: TcxButton;
    cxGroupBox3: TcxGroupBox;
    Label2: TLabel;
    editSalvarSped: TrsSuperEdit;
    btnSelecionaPath: TcxButton;
    ImageList1: TImageList;
    sqlPath: TFDQuery;
    sqlPathARQ_PARAMETRO_ID: TFDAutoIncField;
    sqlPathCAMINHO_SAV_SPED: TStringField;
    cxButton4: TcxButton;
    FDQueryConsultaSAPArquivo: TStringField;
    cxGrid6DBTableView1Arquivo: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButExcluirClick(Sender: TObject);
    procedure ButCancelarClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure cxAnoPropertiesChange(Sender: TObject);
    procedure PageChange(Sender: TObject);
    procedure ButPesquisarClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure chkImportarClick(Sender: TObject);
    procedure btnExecutarClick(Sender: TObject);
    procedure chkTodosClick(Sender: TObject);
    procedure chkNenhumClick(Sender: TObject);
    procedure btnProcessarClick(Sender: TObject);
    procedure btnSelecionaPathClick(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
  private
    FSearchRecord: TSearchRec;
    ArrayCentroCusto : Variant;
    pECF_Centro_Custo_ID_OLD : String;
    bCancelar : Boolean;
    sPath : String;
    varExercicio_AnoFiscal, varExercicio_MesFiscal : String;
    procedure ImportarInventario;

    procedure Mensagem(pMensagem: String);
    procedure Importar_Arquivos_Fiscal(Ano : String; QtdeExecutar : Integer);
    procedure ConfiguraAnoFiscal(Data: TDateTime); overload;

    function TransformaNegativo(Valor: String): String;
    procedure CriarSaldo(pAnoAnterior, pAno: String);
    function CalcularSaldo(pIndice: Integer; pMES_ANT: String = ''): Currency;
    procedure ImportarRateio;
    function BuscaCentroCustoID(pCentroCusto: String): Integer;
    function BuscaGrupoID(pCentroCusto: String): Integer;
    procedure GravaVinculoCentroCusto;
    procedure ConfiguraAnoFiscal(varMes: Integer); overload;
    function  AtualizarGridConsulta(pSelecao : String) : Integer;
    procedure SalvarPath(Caminho: String);
    procedure BuscaPastaArquivosSAP;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImportarSAP: TfrmImportarSAP;

implementation

{$R *.dfm}

uses DBConect;

procedure TfrmImportarSAP.Mensagem(pMensagem : String);
begin

  cxLabel2.Caption := pMensagem;
  Panel7.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

procedure TfrmImportarSAP.PageChange(Sender: TObject);
begin
   chkImportar.Visible := Page.ActivePageIndex = 0;
end;

procedure TfrmImportarSAP.Importar_Arquivos_Fiscal(Ano : String; QtdeExecutar : Integer);
var

  StrComando : Array of AnsiString;

  CharComando : Array of PAnsiChar;



  AnoShort : String;
  i,x, y : Integer;

begin

 SetLength(StrComando, QtdeExecutar);
 SetLength(CharComando,QtdeExecutar);

 FDQueryConsultaSAP.First;

 x:= 0;
 while not FDQueryConsultaSAP.eof do
 begin
     if FDQueryConsultaSAPSELECAO.AsString = 'S' then
     begin

         StrComando[x]  := '\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 ' + FDQueryConsultaSAPUSUARIO_SAP.AsString +
         ' ' + FDQueryConsultaSAPQUERY.AsString +
         ' ' + FDQueryConsultaSAPVARIANTE.AsString +
         ' ' + sPath + 'BR_L210_' + FDQueryConsultaSAPQUERY.AsString + '_' +
                StringReplace(FDQueryConsultaSAPVARIANTE.AsString,'/','_', [rfReplaceAll, rfIgnoreCase]) + '_' +
                              FDQueryConsultaSAPANO.AsString+'.TXT';

         i := 1;
         CharComando[x] :=  Addr(StrComando[x][i]);
         Inc(x);
     end;

     FDQueryConsultaSAP.Next;
 end;

 for y := Low(CharComando) to High(CharComando) do
 begin
   if  CharComando[y] <> Nil Then
      WinExec( CharComando[y], 1);
 end;

end;

procedure TfrmImportarSAP.ConfiguraAnoFiscal(Data: TDateTime);
var
 Ano, Mes, Dia: Word;
 MesFiscal : String;
begin
  DecodeDate(Data, Ano, Mes, Dia);
   varExercicio_AnoFiscal  := '';
   varExercicio_MesFiscal  := '';

   Case Mes Of
      // Grupo 2
       8  : MesFiscal := '1' ;
       9  : MesFiscal := '2' ;
       10 : MesFiscal := '3' ;
       11 : MesFiscal := '4' ;
       12 : MesFiscal := '5' ;
      // Grupo 1
       1  : MesFiscal := '6' ;
       2  : MesFiscal := '7' ;
       3  : MesFiscal := '8' ;
       4  : MesFiscal := '9' ;
       5  : MesFiscal := '10' ;
       6  : MesFiscal := '11' ;
       7  : MesFiscal := '12' ;
   End ;

   if Mes >= 8 then
      Ano := Ano + 1;

   varExercicio_AnoFiscal    := IntToStr(Ano);
   varExercicio_MesFiscal := MesFiscal;

end;


procedure TfrmImportarSAP.ConfiguraAnoFiscal(varMes: Integer);
var
 MesFiscal : String;
 Ano       : Word;
begin

   varExercicio_AnoFiscal  := '';
   varExercicio_MesFiscal  := '';
   Ano := StrToInt(cxAno.Text);

   Case varMes Of
      // Grupo 2
       8  : MesFiscal := '1' ;
       9  : MesFiscal := '2' ;
       10 : MesFiscal := '3' ;
       11 : MesFiscal := '4' ;
       12 : MesFiscal := '5' ;
      // Grupo 1
       1  : MesFiscal := '6' ;
       2  : MesFiscal := '7' ;
       3  : MesFiscal := '8' ;
       4  : MesFiscal := '9' ;
       5  : MesFiscal := '10' ;
       6  : MesFiscal := '11' ;
       7  : MesFiscal := '12' ;
   End ;

   if varMes >= 8 then
      Ano := Ano + 1;

   varExercicio_AnoFiscal    := IntToStr(Ano);
   varExercicio_MesFiscal    := MesFiscal;

end;

function TfrmImportarSAP.TransformaNegativo(Valor: String): String;
var
 varValor : String;
begin
   varValor := Valor;

   if Pos('-',Valor) > 1 then
       varValor := '-' + Valor.Replace( '-', '', [rfReplaceAll] );

   result :=  varValor;


end;

procedure TfrmImportarSAP.ImportarInventario;
var
  X, I : Integer;
  varArquivo: TStringList;
  varConta, varTipo : String;
  varValor_01,    varValor_02, varValor_03, varValor_04, varValor_05, varValor_06, varValor_07, varValor_08,
  varValor_09, varValor_10, varValor_11, varValor_12, varValor_13 : Extended;
  varArquivosMov : Array [0..1] of String;
  vetArquivos    : Array [0..7] of String;
  varArquivosBalance5 : Array [0..1] of String;
  vetArquivosFBL3N : String;

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
  varMOEDACONTABIL,
  varDCCONTABIL : String;

  varDATA : TDateTime;
  varVALORCONTABIL : Extended;
  varControle_ID : Integer;

  varAnoAtual, varAnoAnterior, varAnoAtualShort, varAnoAnteriorShort, varAnoPosterior : String;

  varCentroCustoPos10 : String;
  //Path, PathLocal, PathRede : String;

begin
  varAnoAtual      := cxAno.Text;
  varAnoAnterior   := IntToStr(StrToInt(cxAno.Text)-1);
  varAnoPosterior  := IntToStr(StrToInt(cxAno.Text)+1);

  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
  FDQueryAux.SQL.Add('Select ECF_CONTROLE_ID, ANO, ANO_ANTERIOR From ECF_CONTROLE where ANO = :ANO AND ANO_ANTERIOR = :ANO_ANTERIOR');
  FDQueryAux.Params.ParamByName('ANO').AsString          := varAnoAtual;
  FDQueryAux.Params.ParamByName('ANO_ANTERIOR').AsString := varAnoAnterior;
  FDQueryAux.Open;

  if not FDQueryAux.IsEmpty then
  begin
     MessageDlg('Ano selecionado já foi importado!',mtInformation,[mbOk],0);
     Exit;
  end;

  Mensagem( 'Aguarde...' );
  bCancelar := False;
  ButCancelar.Visible := True;
  varAnoAtualShort    := Copy(varAnoAtual,3,2);
  varAnoAnteriorShort := Copy(varAnoAnterior,3,2);
  {
  PathLocal := 'C:\Brady\Files\L210\';
  PathRede := '\\GHOS2024\Brady\Files\L210\';

  //Path := PathLocal;
  Path := PathRede;
   }
  FDQueryAux2.Close;
  FDQueryAux2.SQL.Clear;
  FDQueryAux2.SQL.Add('SELECT * FROM ECF_CONSULTA WHERE ');
  FDQueryAux2.SQL.Add('(QUERY = ''GL_BALANCE'' AND ANO = :ANO and ANO_FISCAL = :ANO_FISCAL ) ');
  FDQueryAux2.Params.ParamByName('ANO').AsString           := varAnoAtual;
  FDQueryAux2.Params.ParamByName('ANO_FISCAL').AsString    := varAnoAtual;

  FDQueryAux2.Open;
  FDQueryAux2.First;
  I := 0;
  while not  FDQueryAux2.eof do
  begin
       varArquivosMov[I] := 'BR_L210_' + FDQueryAux2.FieldByName('QUERY').AsString + '_' +
                           StringReplace(FDQueryAux2.FieldByName('VARIANTE').AsString,'/','_', [rfReplaceAll, rfIgnoreCase]) + '_' +
                                         FDQueryAux2.FieldByName('ANO').AsString+'.TXT';

       Inc(I);

     FDQueryAux2.Next;
  end;

  FDQueryAux2.Close;
  FDQueryAux2.SQL.Clear;
  FDQueryAux2.SQL.Add('SELECT * FROM ECF_CONSULTA WHERE ANO_FISCAL = :ANO_FISCAL and ');
  FDQueryAux2.SQL.Add('(QUERY = ''L210-KE5Z'' AND ANO = :ANO and ANO_FISCAL = :ANO_FISCAL) OR ');
  FDQueryAux2.SQL.Add('(QUERY = ''KE5Z-8'' AND ANO = :ANO and ANO_FISCAL = :ANO_FISCAL)');
  FDQueryAux2.SQL.Add('ORDER BY QUERY DESC ');
  FDQueryAux2.Params.ParamByName('ANO_FISCAL').AsString :=  varAnoAtual;
  FDQueryAux2.Params.ParamByName('ANO').AsString :=  varAnoAtual;
  FDQueryAux2.Open;
  FDQueryAux2.First;
  I := 0;
  while not FDQueryAux2.Eof  do
  begin
    vetArquivos[I] := 'BR_L210_' + FDQueryAux2.FieldByName('QUERY').AsString + '_' +
                           StringReplace(FDQueryAux2.FieldByName('VARIANTE').AsString,'/','_', [rfReplaceAll, rfIgnoreCase]) + '_' +
                                         FDQueryAux2.FieldByName('ANO').AsString+'.TXT';
    Inc(I);

    FDQueryAux2.Next;
  end;


  FDQueryAux2.Close;
  FDQueryAux2.SQL.Clear;
  FDQueryAux2.SQL.Add('SELECT * FROM ECF_CONSULTA WHERE ANO_FISCAL = :ANO_FISCAL AND ');
  FDQueryAux2.SQL.Add('(QUERY = ''FBL3N'' AND ANO = :ANO and ANO_FISCAL = :ANO_FISCAL) ') ;
  FDQueryAux2.Params.ParamByName('ANO').AsString :=  varAnoAtual;
  FDQueryAux2.Params.ParamByName('ANO_FISCAL').AsString :=  varAnoAtual;
  FDQueryAux2.Open;
  FDQueryAux2.First;
  while not FDQueryAux2.Eof do
  begin
     vetArquivosFBL3N := 'BR_L210_' + FDQueryAux2.FieldByName('QUERY').AsString + '_' +
                           StringReplace(FDQueryAux2.FieldByName('VARIANTE').AsString,'/','_', [rfReplaceAll, rfIgnoreCase]) + '_' +
                                         FDQueryAux2.FieldByName('ANO').AsString+'.TXT';
     FDQueryAux2.Next;
  end;

 //vetArquivosFBL3N := 'FBL3N_ANUAL_'+varAnoAtual+'.TXT';

  FDQueryAux2.Close;
  FDQueryAux2.SQL.Clear;
  FDQueryAux2.SQL.Add('SELECT * FROM ECF_CONSULTA WHERE ANO_FISCAL = :ANO_FISCAL AND ');
  FDQueryAux2.SQL.Add('(QUERY = ''GL_BALANCE5'' AND ANO = :ANO and ANO_FISCAL = :ANO_FISCAL)  OR ');
  FDQueryAux2.SQL.Add('(QUERY = ''GL_BALANCE5'' AND ANO = :ANO_POSTERIOR and ANO_FISCAL = :ANO_FISCAL) ');
  FDQueryAux2.SQL.Add('ORDER BY  ANO') ;
  FDQueryAux2.Params.ParamByName('ANO').AsString           := varAnoAtual;
  FDQueryAux2.Params.ParamByName('ANO_FISCAL').AsString    := varAnoAtual;
  FDQueryAux2.Params.ParamByName('ANO_POSTERIOR').AsString := varAnoPosterior;
  FDQueryAux2.Open;
  FDQueryAux2.First;
  i := 0;
  while not FDQueryAux2.Eof do
  begin
     varArquivosBalance5[i] :='BR_L210_' + FDQueryAux2.FieldByName('QUERY').AsString + '_' +
                           StringReplace(FDQueryAux2.FieldByName('VARIANTE').AsString,'/','_', [rfReplaceAll, rfIgnoreCase]) + '_' +
                                         FDQueryAux2.FieldByName('ANO').AsString+'.TXT';
     Inc(i);
     FDQueryAux2.Next;
  end;



  Mensagem( 'Criando DataModule' );

  with DB_Conect do
  begin

    Mensagem( 'Iniciando processo de importação...' );
    try

      varArquivo := TStringList.Create;
      try

          Mensagem( 'Carregando arquivo...' );

          Mensagem( 'Abrindo Conexão...' );
          FDConnection.Open;

          try

            try

              FDQuery_Controle.Open;
              FDQuery_Controle.Append;
              FDQuery_ControleANO.asString          := varAnoAtual;
              FDQuery_ControleANO_ANTERIOR.AsString := varAnoAnterior;

              try

                FDQuery_Controle.Post;

              except

                on E: Exception do
                begin

                  MessageDlg(pChar('Post; ' + E.Message),mtInformation,[mbOk],0);
                  FDQuery_Controle.Cancel;

                end;

              end;


              try

                FDQuery_Controle.ApplyUpdates;
                FDQuery_Controle.CommitUpdates;

              except

                on E: Exception do
                begin

                 MessageDlg(pChar('CommitUpdates; ' + E.Message),mtInformation,[mbOk],0);

                end;

              end;

            Finally
              FDQuery_Controle.Close;

            end;

            FDQueryAux.Close;
            FDQueryAux.SQL.Clear;
            FDQueryAux.SQL.Add('Select ECF_CONTROLE_ID, ANO, ANO_ANTERIOR From ECF_CONTROLE where ANO = :ANO AND ANO_ANTERIOR = :ANO_ANTERIOR');
            FDQueryAux.Params.ParamByName('ANO').AsString          := varAnoAtual;
            FDQueryAux.Params.ParamByName('ANO_ANTERIOR').AsString := varAnoAnterior;
            FDQueryAux.Open;
            varControle_ID := FDQueryAux.FieldByName('ECF_CONTROLE_ID').AsInteger;
            FDQueryAux.Close;

            if varControle_ID <= 0 then
               raise Exception.Create('Ano na tabela de Controle não encontrado. Comunicar Depto IT');


            FDQuery_Insert_F01.Open;
            Try

              for I  := 0 to High(varArquivosMov) do
              begin

                  X := 0;
                  varArquivo.Clear;
                  varArquivo.LoadFromFile(sPath+varArquivosMov[I]);
                  varANO :=  StringReplace(varArquivosMov[I].Split(['_'])[6].Trim,'.TXT','', [rfReplaceAll, rfIgnoreCase]);

                  Mensagem( 'Lendo linhas do arquivo ' + varArquivosMov[I]);
                  while X <= varArquivo.Count-1 do
                  begin
                    if bCancelar then
                    begin
                        MessageDlg('Importação cancelada pelo Usuário!',mtInformation,[mbOk],0);
                        Exit;
                    end;

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


                   //   Mensagem( 'Linha (" ' + IntToStr(X) + '/' + IntToStr(varArquivo.Count-1) + '") "' + Trim(varArquivo[X].Split(['|'])[1]) + '" ...' );


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

                        Mensagem( 'Erro_1: ' + IntToStr( X ) + E.Message );

                      end;

                    end;

                    Inc(X);
                  end;

                  if not DirectoryExists(sPath + varAnoAtual + '_'+ varAnoAnterior) then
                    ForceDirectories(sPath + varAnoAtual + '_'+ varAnoAnterior);


                  CopyFile( PWideChar(sPath+varArquivosMov[I]), PWideChar(sPath+ varAnoAtual + '_'+ varAnoAnterior +'\'+ varArquivosMov[I]), True );
                  DeleteFile(PWideChar(sPath+varArquivosMov[I]));
              end;

            finally


              FDQuery_Insert_F01.Close;

            end;


            for I  := 0 to High(vetArquivos) do
            begin
                varArquivo.Clear;
                varArquivo.LoadFromFile(sPath+vetArquivos[I]);
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
                      varCENTRO_CUSTO       :='';
                      if bCancelar then
                      begin
                          MessageDlg('Importação cancelada pelo Usuário!',mtInformation,[mbOk],0);
                          Exit;
                      end;
                      try
                        if I < 4 then
                        begin
                          if not (varArquivo[X].CountChar('|') = 12) then
                             Continue;

                        end
                        else
                        begin
                          if not (varArquivo[X].CountChar('|') = 10) then
                             Continue;
                        end;

                     //   Mensagem( 'Linha (" ' + IntToStr(X) + '/' + IntToStr(varArquivo.Count-1) + '") "' + Trim(varArquivo[X].Split(['|'])[1]) + '" ...' );

                        if I < 4 then
                        begin
                         try
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
                                 except

                          on E: Exception do
                          begin

                            Mensagem( 'Erro 5: ' + E.Message );

                          end;

                        end;
                        end
                        else
                        begin
                         try
                          varPlant               := varArquivo[X].Split(['|'])[1].Trim;
                          varDC                  := varArquivo[X].Split(['|'])[2].Trim;
                          varACC_NUMBER          := varArquivo[X].Split(['|'])[3].Trim;
                          varPURCHASING_DOC      := varArquivo[X].Split(['|'])[4].Trim;
                          varACC_NUMBER_VEN_CRE  := varArquivo[X].Split(['|'])[5].Trim;

                          varNAME                := '';

                          varPOSITION_PERIODO    := varArquivo[X].Split(['|'])[6].Trim;
                          varFISCAL_YEAR         := varArquivo[X].Split(['|'])[7].Trim;
                          varAMOUNT              := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[8].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                          varMOEDA               := varArquivo[X].Split(['|'])[9].Trim;

                          if not varArquivo[X].Split(['|'])[10].IsEmpty then
                            varCENTRO_CUSTO        := varArquivo[X].Split(['|'])[10].Trim;

                          varPAIS                := '';
                        except

                          on E: Exception do
                          begin

                            Mensagem( 'Erro_4: ' + varArquivo[X] + '-' + IntToStr(X) );

                          end;

                        end;
                        end;

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
                        FDQuery_Insert_KE5ZANO_BASE.AsString            := varAnoAtual;
                        FDQuery_Insert_KE5ZCENTRO_CUSTO.AsString        := varCENTRO_CUSTO;


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
                            MessageDlg(E.Message ,mtInformation,[mbOk],0);

                          end;

                        end;


                      except

                        on E: Exception do
                        begin

                          Mensagem( 'Erro_2: ' + IntToStr( X ) + E.Message );
                          MessageDlg(E.Message ,mtInformation,[mbOk],0);

                        end;

                      end;

                      Inc(X);
                   end;

                Finally
                   FDQuery_Insert_KE5Z.Close;

                End;

                if not DirectoryExists(sPath + varAnoAtual + '_'+ varAnoAnterior) then
                   ForceDirectories(sPath + varAnoAtual + '_'+ varAnoAnterior);


                CopyFile( PWideChar(sPath + vetArquivos[I]), PWideChar(sPath + varAnoAtual + '_'+ varAnoAnterior +'\'+ vetArquivos[I]), True );
                DeleteFile(PWideChar(sPath + vetArquivos[I]));


            end;


          //***************

            varArquivo.Clear;
            Try
               FDQuery_FBL3N.Open;
               Try
                      varArquivo.Clear;
                      varArquivo.LoadFromFile(sPath + vetArquivosFBL3N );
                      vaarCD := '';
                      varNUMERO_CONTA := '';
                      varCENTRO_CUSTO := '';
                      varVALORCONTABIL := 0;
                      varDCCONTABIL := '';
                      varDATA := 0;
                      varMOEDACONTABIL := '';

                      try
                          X := 0;
                          Mensagem( 'Lendo linhas do arquivo ' + vetArquivosFBL3N );
                          while X <= varArquivo.Count-1 do
                          begin

                          //  Mensagem( 'Linha (" ' + IntToStr(X) + '/' + IntToStr(varArquivo.Count-1) + '") "' + Trim(varArquivo[X].Split(['|'])[1]) + '" ...' );

                            if bCancelar then
                            begin
                               MessageDlg('Importação cancelada pelo Usuário!',mtInformation,[mbOk],0);
                               Exit;
                            end;

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
                            FDQuery_FBL3NANO_BASE.AsString     := varAnoAtual;

                            try

                               FDQuery_FBL3N.Post;

                             except

                               on E: Exception do
                               begin

                                 MessageDlg(E.Message ,mtInformation,[mbOk],0);
                                 FDQuery_FBL3N.Cancel;

                               end;

                            end;


                            try
                                FDQuery_FBL3N.ApplyUpdates;
                                FDQuery_FBL3N.CommitUpdates;

                            except

                               on E: Exception do
                               begin

                               MessageDlg(E.Message ,mtInformation,[mbOk],0);
                                end;
                            end;
                            Inc(X);

                         end;
                      except

                          on E: Exception do
                          begin

                             MessageDlg(E.Message ,mtInformation,[mbOk],0);
                          end;

                      end;

                      if not DirectoryExists(sPath+ varAnoAtual + '_'+ varAnoAnterior) then
                        ForceDirectories(sPath + varAnoAtual + '_'+ varAnoAnterior);


                      CopyFile( PWideChar(sPath+vetArquivosFBL3N), PWideChar(sPath+ varAnoAtual + '_'+ varAnoAnterior +'\'+ vetArquivosFBL3N), True );
                      DeleteFile(PWideChar(sPath+vetArquivosFBL3N));



               Finally
                  FDQuery_FBL3N.Close;
               End;

            except
                  on E: Exception do
                  begin

                     MessageDlg(E.Message ,mtInformation,[mbOk],0);
                  end;

            end;


            FDQuery_Insert_F01.Open;
            Try

              for I  := 0 to High(varArquivosBalance5) do
              begin


                  X := 0;
                  varArquivo.Clear;
                  varArquivo.LoadFromFile(sPath+varArquivosBalance5[I]);
                  varANO :=  StringReplace(varArquivosBalance5[I].Split(['_'])[6].Trim,'.TXT','', [rfReplaceAll, rfIgnoreCase]);

                  Mensagem( 'Lendo linhas do arquivo ' + varArquivosBalance5[I]);
                  while X <= varArquivo.Count-1 do
                  begin
                    if bCancelar then
                    begin
                        MessageDlg('Importação cancelada pelo Usuário!',mtInformation,[mbOk],0);
                        Exit;
                    end;

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


                   //   Mensagem( 'Linha (" ' + IntToStr(X) + '/' + IntToStr(varArquivo.Count-1) + '") "' + Trim(varArquivo[X].Split(['|'])[1]) + '" ...' );

                      varEmpresa      := varArquivo[X].Split(['|'])[1].Trim;
                      varAno          := varArquivo[X].Split(['|'])[2].Trim;
                      varConta        := varArquivo[X].Split(['|'])[3].Trim;
                      varTipo         := varArquivo[X].Split(['|'])[4].Trim;
                      varValor_01     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[7].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll]  )));
                      varValor_02     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[9].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll]  )));
                      varValor_03     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[11].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll]  )));
                      varValor_04     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[13].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll]  )));
                      varValor_05     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[15].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                      varValor_06     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[17].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                      varValor_07     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[19].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                      varValor_08     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[21].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                      varValor_09     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[23].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                      varValor_10     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[25].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                      varValor_11     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[27].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                      varValor_12     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[29].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));
                      varValor_13     := StrToFloat(TransformaNegativo(varArquivo[X].Split(['|'])[5].Trim.Replace( ',', '', [rfReplaceAll] ).Replace( '.', FormatSettings.DecimalSeparator, [rfReplaceAll] )));



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

                        Mensagem( 'Erro_3: ' + IntToStr( X ) + E.Message );

                      end;

                    end;

                    Inc(X);
                  end;

                  if not DirectoryExists(sPath + varAnoAtual + '_'+ varAnoAnterior) then
                    ForceDirectories(sPath + varAnoAtual + '_'+ varAnoAnterior);


                  CopyFile( PWideChar(sPath+varArquivosBalance5[I]), PWideChar(sPath+ varAnoAtual + '_'+ varAnoAnterior +'\'+ varArquivosBalance5[I]), True );
                  DeleteFile(PWideChar(sPath+varArquivosBalance5[I]));

              end;

            finally


              FDQuery_Insert_F01.Close;

            end;




          finally

            FDConnection.Close;

          end;


           FDQueryControle.Close;
           FDQueryControle.Open;
      finally

        FreeAndNil(varArquivo);

      end;

    finally

       Mensagem('');

    end;

  end;

end;

function TfrmImportarSAP.CalcularSaldo(pIndice : Integer; pMES_ANT : String ='') : Currency;
var
 i      : Integer;
 iTotalRegistro : Integer;
 varMeses :  Currency;
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

         FDQueryGrid.Close;
         FDQueryGrid.ParamByName( 'ANO_ANT' ).AsInteger :=  StrToInt(pMES_ANT)-1;
         FDQueryGrid.ParamByName( 'ANO' ).AsInteger     :=  StrToInt(pMES_ANT);
         FDQueryGrid.Open;

         FDQueryGrid.First;
         varMeses := 0;
         while not FDQueryGrid.eof do
         begin
           varMesAnterior  := varMesAnterior + FDQueryGrid.FieldList.Fields[11 + 4].AsCurrency;
           FDQueryGrid.Next;
         end;

     end;

   end;

   if pIndice >= 0 then
   begin

     FDQueryGrid.First;
     varMeses := 0;
     while not FDQueryGrid.eof do
     begin
        varMeses  := varMeses + FDQueryGrid.FieldList.Fields[pIndice + 4].AsCurrency;
        FDQueryGrid.Next;
     end;

   end;


   if (pIndice = -1) Then
      varMeses  := varMesAnterior;


   result := VarMeses;

end;


procedure TfrmImportarSAP.chkImportarClick(Sender: TObject);
begin
   if cxAno.Text = EmptyStr then
   begin
     raise Exception.Create('Período de Importação não informado');
     chkImportar.Checked := False;
   end;

   pnlBarra.Enabled     := not chkImportar.Checked;
   pnlConsultas.Visible := chkImportar.Checked;

   if pnlConsultas.Visible  then
   begin
         AtualizarGridConsulta('S');

        if FDQueryConsultaSAP.IsEmpty then
        begin
            raise Exception.Create('Consultas não configuradas para o ano de ' + cxAno.Text );
            chkImportar.Checked := False;
        end;

        if FDQueryConsultaSAP.RecordCount < 11 then
        begin
            raise Exception.Create('Faltam Consultas a serem configuradas pelo Depto do IT no Menu ECF->Consultas do SAP ');
            chkImportar.Checked := False;
        end;

   end;

end;

procedure TfrmImportarSAP.chkNenhumClick(Sender: TObject);
begin
  AtualizarGridConsulta('N');
end;

procedure TfrmImportarSAP.chkTodosClick(Sender: TObject);
begin
  AtualizarGridConsulta('S');
end;

function  TfrmImportarSAP.AtualizarGridConsulta(pSelecao : String) : Integer;
var
 iResultado : Integer;
begin
  if pSelecao <> '' then
  begin

    FDQueryAux.Close;
    FDQueryAux.SQL.Clear;
    FDQueryAux.SQL.Add('Update ECF_CONSULTA Set SELECAO = :Selecao, Arquivo = :Arquivo ');
    FDQueryAux.Params.ParamByName('Selecao').AsString := pSelecao;
    FDQueryAux.Params.ParamByName('Arquivo').AsString := EmptyStr;
    FDQueryAux.ExecSQL;

  end;

  iResultado := 0;
  FDQueryConsultaSAP.Close;

  FDQueryConsultaSAP.Params.ParamByName('ANO').AsString           := cxAno.Text;
  FDQueryConsultaSAP.Params.ParamByName('ANO_FISCAL').AsString    := cxAno.Text;

  FDQueryConsultaSAP.Params.ParamByName('ANO_ANTERIOR').AsString  := IntToStr(StrToInt(cxAno.Text)-1);
  FDQueryConsultaSAP.Params.ParamByName('ANO_POSTERIOR').AsString := IntToStr(StrToInt(cxAno.Text)+1);

  FDQueryConsultaSAP.Params.ParamByName('GL_BALANCE').AsString    := 'GL_BALANCE';
  FDQueryConsultaSAP.Params.ParamByName('GL_BALANCE5').AsString   := 'GL_BALANCE5';

  FDQueryConsultaSAP.Open;
  if pSelecao = '' then
  begin
    FDQueryConsultaSAP.Filtered := True;
    FDQueryConsultaSAP.Filter := 'SELECAO = ' + QuotedStr('S');
    iResultado := FDQueryConsultaSAP.RecordCount;
    FDQueryConsultaSAP.Filtered := False;
  end
  else
  begin
    iResultado := FDQueryConsultaSAP.RecordCount;
  end;
  Result := iResultado;
end;

procedure TfrmImportarSAP.CriarSaldo(pAnoAnterior, pAno : String);
var
 varSaldoTempJan, varSaldoTempFev, varSaldoTempMar, varSaldoTempAbr, varSaldoTempMai, varSaldoTempJun,
 varSaldoTempJul,varSaldoTempAgo,varSaldoTempSep,varSaldoTempOtu,varSaldoTempNov, varSaldoTempDez : Currency;
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

  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
  FDQueryAux.SQL.Add('Delete from ECF_SALDO Where ANO = :ANO and ANO_ANTERIOR = :ANO_ANTERIOR');
  FDQueryAux.Params.ParamByName('ANO').AsString          := pAno;
  FDQueryAux.Params.ParamByName('ANO_ANTERIOR').AsString := pAnoAnterior;
  try

    FDQueryAux.ExecSQL;

  except

    on E: Exception do
    begin

      Mensagem( 'Delete ECF_SALDO: ' + E.Message );
      FDQueryAux.Cancel;

    end;

  end;


  FDQueryCriaSaldo.Open;

  FDQueryCriaSaldo.Append;
  FDQueryCriaSaldoANO.AsString         :=  pAno;
  FDQueryCriaSaldoANO_ANTERIOR.AsString:=  pAnoAnterior;

  // Pega no Ano Anterior
  varSaldoTempJan :=  CalcularSaldo(-1,pAnoAnterior);
  FDQueryCriaSaldoJANEIRO.AsCurrency   := varSaldoTempJan;    //dezembro

  // Pega do Ano Atual
  FDQueryGrid.Close;
  FDQueryGrid.ParamByName( 'ANO' ).AsInteger     :=  StrToInt(pAno);
  FDQueryGrid.Open;

  varSaldoTempFev := varSaldoTempJan + CalcularSaldo(0);
  FDQueryCriaSaldoFEVEREIRO.AsCurrency := varSaldoTempFev;    // janeiro

  varSaldoTempMar :=  varSaldoTempFev + CalcularSaldo(1);
  FDQueryCriaSaldoMARCO.AsCurrency    :=  varSaldoTempMar;   // fevereiro

  varSaldoTempAbr :=  varSaldoTempMar + CalcularSaldo(2);
  FDQueryCriaSaldoABRIL.AsCurrency    := varSaldoTempAbr;   // marco

  varSaldoTempMai :=  varSaldoTempAbr +  CalcularSaldo(3);
  FDQueryCriaSaldoMAIO.AsCurrency     :=  varSaldoTempMai; // abril

  varSaldoTempJun :=  varSaldoTempMai +  CalcularSaldo(4);
  FDQueryCriaSaldoJUNHO.AsCurrency    :=  varSaldoTempJun;  // maio

  varSaldoTempJul := varSaldoTempJun  +  CalcularSaldo(5);
  FDQueryCriaSaldoJULHO.AsCurrency    := varSaldoTempJul;  // junho

  varSaldoTempAgo := varSaldoTempJul  +   CalcularSaldo(6);
  FDQueryCriaSaldoAGOSTO.AsCurrency   :=  varSaldoTempAgo;  // julho

  varSaldoTempSep :=  varSaldoTempAgo  + CalcularSaldo(7);
  FDQueryCriaSaldoSETEMBRO.AsCurrency  := varSaldoTempSep; // agosto

  varSaldoTempOtu := varSaldoTempSep +  CalcularSaldo(8);
  FDQueryCriaSaldoOUTUBRO.AsCurrency   :=  varSaldoTempOtu; // setembro

  varSaldoTempNov :=  varSaldoTempOtu + CalcularSaldo(9);
  FDQueryCriaSaldoNOVEMBRO.AsCurrency  :=  varSaldoTempNov;  // outubro

  varSaldoTempDez :=  varSaldoTempNov +  CalcularSaldo(10);
  FDQueryCriaSaldoDEZEMBRO.AsCurrency  := varSaldoTempDez;  // novembro

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
        MessageDlg(E.Message ,mtInformation,[mbOk],0);
     end;
  end;
  FDQueryCriaSaldo.Close;
end;

procedure TfrmImportarSAP.cxAnoPropertiesChange(Sender: TObject);
begin
   if cxAno.Text <> '' then
   begin
     FDQueryRateio.Close;
     FDQueryRateio.Params.ParamByName('EXERCICIO').AsString := cxAno.Text;
     FDQueryRateio.Open;
   end;
end;

procedure TfrmImportarSAP.cxButton1Click(Sender: TObject);
begin
  if cxAno.Text = EmptyStr then
    raise Exception.Create('Período de Importação não informado');

   if cxAno.Text <> '' then
   begin
     cdsKE5Z.Close;
     cdsKE5Z.Params.ParamByName('ANO_BASE').AsString := cxAno.Text;
     cdsKE5Z.Open;
   end;
end;

procedure TfrmImportarSAP.cxButton2Click(Sender: TObject);
begin
   if cxAno.Text = EmptyStr then
    raise Exception.Create('Período de Importação não informado');

   if cxAno.Text <> '' then
   begin
     cdsFBL3N.Close;
     cdsFBL3N.Params.ParamByName('ANO_BASE').AsString := cxAno.Text;
     cdsFBL3N.Open;
   end;
end;

procedure TfrmImportarSAP.cxButton4Click(Sender: TObject);
var
 sArquivo : String;
begin
 FDQueryConsultaSAP.First;

 while not FDQueryConsultaSAP.eof do
 begin
    FDQueryAux.Close;
    FDQueryAux.SQL.Clear;
    FDQueryAux.SQL.Add('Update ECF_CONSULTA Set Arquivo = :Arquivo Where ECF_CONSULTA_ID = :ECF_CONSULTA_ID ');
    FDQueryAux.Params.ParamByName('ECF_CONSULTA_ID').AsInteger := FDQueryConsultaSAPECF_CONSULTA_ID.AsInteger;
    FDQueryAux.Params.ParamByName('Arquivo').AsString := EmptyStr;
    FDQueryAux.ExecSQL;

    FDQueryConsultaSAP.Next;
 end;
 FDQueryConsultaSAP.First;

 while not FDQueryConsultaSAP.eof do
 begin
     if FDQueryConsultaSAPSELECAO.AsString = 'S' then
     begin

        sArquivo :=  sPath + 'BR_L210_' + FDQueryConsultaSAPQUERY.AsString + '_' +
                              StringReplace(FDQueryConsultaSAPVARIANTE.AsString,'/','_', [rfReplaceAll, rfIgnoreCase]) + '_' +
                              FDQueryConsultaSAPANO.AsString+'.TXT';
        while FindFirst(sArquivo, faAnyFile-faDirectory, FSearchRecord) = 0 do
        begin
         FDQueryAux.Close;
         FDQueryAux.SQL.Clear;
         FDQueryAux.SQL.Add('Update ECF_CONSULTA  SET Arquivo = :Arquivo  Where ECF_CONSULTA_ID = :ECF_CONSULTA_ID');
         FDQueryAux.Params.ParamByName('Arquivo').AsString := sArquivo;
         FDQueryAux.Params.ParamByName('ECF_CONSULTA_ID').AsInteger := FDQueryConsultaSAPECF_CONSULTA_ID.AsInteger;
         FDQueryAux.ExecSQL;

         break;
        end;

     end;

     FDQueryConsultaSAP.Next;
 end;

 AtualizarGridConsulta('');
 FDQueryConsultaSAP.First;

end;

function TfrmImportarSAP.BuscaCentroCustoID(
  pCentroCusto: String): Integer;
var
 varResultado : Integer;
begin
  varResultado := 0;
  sqlCC.Close;
  sqlCC.Params.ParamByName('CENTRO_CUSTO').AsString := pCentroCusto;
  sqlCC.Open;
  if not sqlCC.IsEmpty then
    varResultado := sqlCC.FieldByName('ECF_CENTRO_CUSTO_ID').AsInteger;

  result := varResultado;
end;

function TfrmImportarSAP.BuscaGrupoID(pCentroCusto: String): Integer;
var
 varResultado : Integer;
begin
  varResultado := 0;
  sqlGrupo.Close;
  sqlGrupo.Params.ParamByName('CENTRO_CUSTO').AsString := pCentroCusto;
  sqlGrupo.Open;
  if not sqlGrupo.IsEmpty then
    varResultado := sqlGrupo.FieldByName('GRUPO').AsInteger;

  result := varResultado;

end;

procedure TfrmImportarSAP.GravaVinculoCentroCusto;
begin
   sqlAux.Close;
   sqlAux.SQL.Clear;
   sqlAux.SQL.Add('INSERT INTO ECF_VINCULO(GRUPO, ECF_CENTRO_CUSTO_ID, ECF_CENTRO_CUSTO_FILHO, PERCENTUAL, PERIODO, EXERCICIO, PERIODO_FISCAL) ');
   sqlAux.SQL.Add('VALUES (:GRUPO, :ECF_CENTRO_CUSTO_ID, :ECF_CENTRO_CUSTO_FILHO, :PERCENTUAL, :PERIODO, :EXERCICIO, :PERIODO_FISCAL) ');
   sqlAux.Params.ParamByName('GRUPO').AsInteger                  :=  ArrayCentroCusto[0];
   sqlAux.Params.ParamByName('ECF_CENTRO_CUSTO_ID').AsInteger    :=  ArrayCentroCusto[1];
   sqlAux.Params.ParamByName('ECF_CENTRO_CUSTO_FILHO').AsInteger :=  ArrayCentroCusto[2];
   sqlAux.Params.ParamByName('PERCENTUAL').AsFloat               :=  ArrayCentroCusto[3];
   sqlAux.Params.ParamByName('PERIODO').AsInteger                :=  StrToInt(ArrayCentroCusto[4]);
   sqlAux.Params.ParamByName('EXERCICIO').AsString               :=  ArrayCentroCusto[5];
   sqlAux.Params.ParamByName('PERIODO_FISCAL').AsString          :=  ArrayCentroCusto[6];

    try

      sqlAux.ExecSQL;
    except

      on E: Exception do
      begin

        Mensagem( 'Erro ao Gravar:  ' + E.Message );

      end;

    end;

end;

procedure TfrmImportarSAP.ImportarRateio;
var
 varNomeArq : String;
  I, X: Integer;
  dxSpreadSheet: TdxSpreadSheet;
  varMes, varAno: Integer;
  varData: TDateTime;
  varPlanta, varBudget, varCentro: String;
  varSetup, varMachine, varLabor, varOverhead: Extended;

  varCC : Integer;
  var2642,	var9216,	varCOEM,	var9211,	var2640,	var9215,	varCMAO,	var9229,	varADMIN : Extended;
  varCCFilho : array[0..8] of Integer;

  varInicio, varFim : Integer;

begin
  inherited;


  if not OpenDialog.Execute then
    exit;

  varNomeArq := OpenDialog.FileName;

      with DB_Conect do
      begin
      Mensagem( 'Iniciando processo de importação...' );
      try

        dxSpreadSheet := TdxSpreadSheet.Create(nil);
        try

          Mensagem( 'Carregando planilha...' );
          dxSpreadSheet.LoadFromFile( varNomeArq );
          dxSpreadSheet.BeginUpdate;

          sqlAux.Close;
          sqlAux.SQL.Clear;
          sqlAux.SQL.Add('SELECT * FROM ECF_VINCULO WHERE EXERCICIO = :EXERCICIO and PERIODO = :PERIODO');
          sqlAux.Params.ParamByName('EXERCICIO').AsString := cxAno.Text;
          sqlAux.Params.ParamByName('PERIODO').AsString   := dxSpreadSheet.ActiveSheetAsTable.Rows[1].Cells[11].AsString;

          sqlAux.Open;

          if not sqlAux.IsEmpty then
          begin
             MessageDlg('Ano selecionado para Rateio já foi importado!',mtInformation,[mbOk],0);
             Exit;
          end;


          Mensagem( 'Abrindo Conexão...' );
          FDConnection.Open;
          try
            varInicio := 0;
            varFim    := 0;
            if dxSpreadSheet.ActiveSheetAsTable.Rows[1].Cells[11].AsString = '1' then
            begin
                varInicio :=  1;
                varFim    :=  7;
            end
            else
            begin
                varInicio := 8;
                varFim    := 12;
            end;

            for I := varInicio to varFim do
            begin

              ArrayCentroCusto := VarArrayCreate([0, 6], varVariant);

              varCCFilho[0]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[2].AsString);
              varCCFilho[1]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[3].AsString);
              varCCFilho[2]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[4].AsString);
              varCCFilho[3]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[5].AsString);
              varCCFilho[4]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[6].AsString);
              varCCFilho[5]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[7].AsString);
              varCCFilho[6]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[8].AsString);
              varCCFilho[7]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[9].AsString);
              varCCFilho[8]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[10].AsString);



              Mensagem( 'Lendo linhas da planilha...' );
              for X := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
              begin
                var2642    := 0;
                var9216    := 0;
                varCOEM    := 0;
                var9211    := 0;
                var2640    := 0;
                var9215    := 0;
                varCMAO    := 0;
                var9229    := 0;
                varADMIN   := 0;

                try

                  Mensagem( 'Linha (" ' + IntToStr(X) + '/' + IntToStr(dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex) + '") "' + Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsString) + '" ...' );

                  if Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString) = EmptyStr then
                    Continue;

                except

                  Continue;

                end;

                varCC               := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString);

                //Grupo
                ArrayCentroCusto[0] := BuscaGrupoID(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString);
                // Centro Custo PAI
                ArrayCentroCusto[1] := varCC;

                // Periodo
                ArrayCentroCusto[4] := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[11].AsString;
                ConfiguraAnoFiscal(I);
                //Exercicio
                ArrayCentroCusto[5] := varExercicio_AnoFiscal;
                //Periodo Fiscal
                ArrayCentroCusto[6] := varExercicio_MesFiscal;

                var2642    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsFloat;
                if var2642 <> 0 then
                begin
                   // Centro Custo FILHO
                   ArrayCentroCusto[2] := varCCFilho[0];
                   // Percentual
                   ArrayCentroCusto[3] := var2642;
                   GravaVinculoCentroCusto;

                end;

                var9216    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[3].AsFloat;
                if var9216 <> 0 then
                begin
                    ArrayCentroCusto[2] := varCCFilho[1];
                    ArrayCentroCusto[3] := var9216;
                    GravaVinculoCentroCusto;
                end;


                varCOEM    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[4].AsFloat;
                if varCOEM <> 0 then
                begin
                    ArrayCentroCusto[2] := varCCFilho[2];
                    ArrayCentroCusto[3] := varCOEM;
                    GravaVinculoCentroCusto;
                end;


                var9211    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[5].AsFloat;
                if var9211 <> 0 then
                begin
                   ArrayCentroCusto[2] := varCCFilho[3];
                   ArrayCentroCusto[3] := var9211;
                   GravaVinculoCentroCusto;
                end;

                var2640    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6].AsFloat;
                if var2640 <> 0 then
                begin
                   ArrayCentroCusto[2] := varCCFilho[4];
                   ArrayCentroCusto[3] := var2640;
                   GravaVinculoCentroCusto;
                end;

                var9215    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[7].AsFloat;
                if var9215 <> 0 then
                begin
                   ArrayCentroCusto[2] := varCCFilho[5];
                   ArrayCentroCusto[3] := var9215;
                   GravaVinculoCentroCusto;
                end;

                varCMAO    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[8].AsFloat;
                if varCMAO <> 0 then
                begin
                   ArrayCentroCusto[2] := varCCFilho[6];
                   ArrayCentroCusto[3] := varCMAO;
                   GravaVinculoCentroCusto;
                end;

                var9229    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[9].AsFloat;
                if var9229 <> 0 then
                begin
                   ArrayCentroCusto[2] := varCCFilho[7];
                   ArrayCentroCusto[3] := var9229;
                   GravaVinculoCentroCusto;
                end;


                varADMIN   := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[10].AsFloat;
                if varADMIN <> 0 then
                begin
                   ArrayCentroCusto[2] := varCCFilho[8];
                   ArrayCentroCusto[3] := varADMIN;
                   GravaVinculoCentroCusto;
                end;

                Application.ProcessMessages;

              end;

            end;
          finally

            FDConnection.Close;

          end;

        finally

          FreeAndNil(dxSpreadSheet);

        end;

      finally

        Mensagem( EmptyStr );

      end;

      cxAnoPropertiesChange(Nil);

      end;

end;


procedure TfrmImportarSAP.btnExecutarClick(Sender: TObject);
begin
  pnlConsultas.Visible := False;
  frmImportarSAP.Enabled := True;
end;

procedure TfrmImportarSAP.btnImportarClick(Sender: TObject);
begin
  if cxAno.Text = EmptyStr then
    raise Exception.Create('Período de Importação não informado');


  if Page.ActivePageIndex <> 2 then
     ImportarInventario
  else ImportarRateio;

end;

procedure TfrmImportarSAP.btnProcessarClick(Sender: TObject);
var
 varAnoAtual, varAnoAnterior,  varAnoPosterior : String;
begin
  varAnoAtual    := cxAno.Text;
  varAnoAnterior := IntToStr(StrToInt(cxAno.Text)-1);
  varAnoPosterior  := IntToStr(StrToInt(cxAno.Text)+1);

  If  MessageDlg('O Depto de T.I criou as consultas no SAP referente ao ano de ' + varAnoAtual + ' e ' + varAnoAnterior + '?',mtConfirmation,[mbyes,mbno],0)=mrNo Then
     exit;

  Mensagem( 'Aguarde...' );

  if FDQueryConsultaSAP.State = dsEdit Then
     FDQueryConsultaSAP.Post;

  Importar_Arquivos_Fiscal(varAnoAtual,AtualizarGridConsulta(''));

  Mensagem( '' );

end;

procedure TfrmImportarSAP.SalvarPath(Caminho : String);
begin
  if Caminho = '' then
  begin
     Application.MessageBox('Pasta não informada.', 'L210', mb_iconinformation +  MB_OK);
     exit;
  end;

  sqlPath.Close;
  sqlPath.SQL.Clear;
  sqlPath.SQL.Add('UPDATE ARQ_PARAMETRO SET PathArqL210 = :PathArqL210');
  sqlPath.Params.ParamByName('PathArqL210').AsString := IncludeTrailingBackslash(Caminho);
  Try
    sqlPath.ExecSQL;
  except
     Application.MessageBox('Erro ao Salvar a Pasta', 'L210', mb_iconError+  MB_OK);
  End;

  BuscaPastaArquivosSAP;
end;

procedure TfrmImportarSAP.btnSelecionaPathClick(Sender: TObject);
var
  FDir : String;
begin
  inherited;
  if Win32MajorVersion >= 6 then
    with TFileOpenDialog.Create(nil) do
    try
      Title := 'Selecionar Diretório';
      Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem]; // YMMV
      OkButtonLabel := 'Selecionar';
      DefaultFolder := FDir;
      FileName := FDir;
      if Execute then
      begin
        editSalvarSped.Text := FileName;

        if editSalvarSped.Text  <> '' then
           SalvarPath(editSalvarSped.Text);
      end;
    finally
      Free;
    end
  else
    if SelectDirectory('Selecionar Diretório', ExtractFileDrive(FDir), FDir,
             [sdNewUI, sdNewFolder]) then
      editSalvarSped.Text := FDir;

   if FDir <> '' then
      SalvarPath(FDir);


end;

procedure TfrmImportarSAP.ButCancelarClick(Sender: TObject);
begin
  bCancelar := True;
  ButCancelar.Visible := False;
end;

procedure TfrmImportarSAP.ButExcluirClick(Sender: TObject);
var
 varControle_ID : Integer;
begin

    if Page.ActivePageIndex = 0 then
    begin
      if FDQueryControle.IsEmpty then
          raise Exception.Create('Não há dados para exclusão!');


      If  MessageDlg('Deseja excluir importação dos arquivos do ano de ' + FDQueryControle.FieldByName('ANO').AsString +' ?',mtConfirmation,[mbyes,mbno],0)=mryes then
       begin
        Try
          varControle_ID := FDQueryControle.FieldByName('ECF_CONTROLE_ID').AsInteger;
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

              Mensagem( 'Delete FBL3N: ' + E.Message );
              FDQueryAux.Cancel;

            end;

          end;


          FDQueryAux.Close;
          FDQueryAux.SQL.Clear;
          FDQueryAux.SQL.Add('Delete from ECF_CONTROLE where ECF_CONTROLE_ID = :ECF_CONTROLE_ID');
          FDQueryAux.Params.ParamByName('ECF_CONTROLE_ID').AsInteger          :=varControle_ID;

          try

            FDQueryAux.ExecSQL;

          except

            on E: Exception do
            begin

              Mensagem( 'Delete ECF_CONTROLE: ' + E.Message );
              FDQueryAux.Cancel;

            end;

          end;


          FDQueryAux.Close;
          FDQueryAux.SQL.Clear;
          FDQueryAux.SQL.Add('Delete from ECF_SALDO Where ANO = :ANO and ANO_ANTERIOR = :ANO_ANTERIOR');
          FDQueryAux.Params.ParamByName('ANO').AsString          := FDQueryControle.FieldByName('ANO').AsString;
          FDQueryAux.Params.ParamByName('ANO_ANTERIOR').AsString := IntToStr(StrToInt(FDQueryControle.FieldByName('ANO').AsString)-1);
          try

            FDQueryAux.ExecSQL;

          except

            on E: Exception do
            begin

              Mensagem( 'Delete ECF_SALDO: ' + E.Message );
              FDQueryAux.Cancel;

            end;

          end;

          FDQueryControle.Close;
          FDQueryControle.Open;

        except
            on E: Exception do
              Mensagem('Ocorreu um erro na exclusão' + E.Message);
        end;

         MessageDlg('Exclusão realizada com sucesso!',mtInformation,[mbOk],0);

      end;
    end
    else if Page.ActivePageIndex = 2 then
    begin
       if cxAno.Text = EmptyStr then
         raise Exception.Create('Ano do rateio não informado');

       If  MessageDlg('Deseja excluir importação do rateop no de ' + cxAno.Text +' ?',mtConfirmation,[mbyes,mbno],0)=mryes then
       begin
          sqlAux.Close;
          sqlAux.SQL.Clear;
          sqlAux.SQL.Add('Delete from  ECF_VINCULO WHERE EXERCICIO = :EXERCICIO');
          sqlAux.Params.ParamByName('EXERCICIO').AsString := cxAno.Text;

          try

            sqlAux.ExecSQL;

          except

            on E: Exception do
            begin

              Mensagem( 'Delete ECF_VINCULO: ' + E.Message );
              sqlAux.Cancel;

            end;

          end;

          cxAnoPropertiesChange(Nil);
       end;
    end;


end;

procedure TfrmImportarSAP.ButPesquisarClick(Sender: TObject);
begin
  if cxAno.Text = EmptyStr then
    raise Exception.Create('Período de Importação não informado');

   if cxAno.Text <> '' then
   begin
     cdsF01.Close;
     cdsF01.Params.ParamByName('ANO').AsInteger := StrToInt(cxAno.Text);
     cdsF01.Open;
   end;

end;

procedure TfrmImportarSAP.ButSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmImportarSAP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Self := NIL;
end;

procedure  TfrmImportarSAP.BuscaPastaArquivosSAP;
begin
  sPath := '';

  sqlAux.Close;
  sqlAux.SQL.Clear;
  sqlAux.SQL.Add('Select PathArqL210 From ARQ_PARAMETRO where ARQ_PARAMETRO_ID = ''1''');
  sqlAux.Open;

  if sqlAux.IsEmpty then
    raise Exception.Create('Pasta para Salvar Arquivos do SAP, não está configurada.');

  sPath := sqlAux.FieldByName('PathArqL210').AsString;
  editSalvarSped.Text := sPath;
end;

procedure TfrmImportarSAP.FormCreate(Sender: TObject);
begin
  FDQueryControle.Close;
  FDQueryControle.Open;
  Page.ActivePageIndex := 0;

  BuscaPastaArquivosSAP;


end;

end.
