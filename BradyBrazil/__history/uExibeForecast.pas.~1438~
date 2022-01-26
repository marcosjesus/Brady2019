unit uExibeForecast;

interface

uses
  System.DateUtils,
  System.StrUtils,
  ShellAPI,
  dxSpreadSheet,
  dxSpreadSheetTypes,
  dxSpreadSheetCore,
  cxCurrencyEdit,
  cxGridDBDataDefinitions,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinOffice2013White,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.ExtCtrls, cxContainer, cxLabel, dxGDIPlusClasses, Vcl.ComCtrls, dxCore,
  cxDateUtils, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxGridBandedTableView, cxGridDBBandedTableView,
  Vcl.Grids, Vcl.DBGrids, dxBarBuiltInMenu, cxPC, FireDAC.Comp.ScriptCommands,
  FireDAC.Comp.Script, cxCheckBox, cxGridExportLink, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
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
  dxSkinWhiteprint, dxSkinXmas2008Blue, cxButtonEdit, Datasnap.Provider,
  Datasnap.DBClient;

type
  TfrmExibeForecast = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    FDQueryForecast: TFDQuery;
    FDConnection: TFDConnection;
    DSForecast: TDataSource;
    cxButtonRefresh: TcxButton;
    Page: TcxPageControl;
    TabForecast: TcxTabSheet;
    TabLancamento: TcxTabSheet;
    cxGrid1: TcxGrid;
    cxGrid1DBBandedTableView1: TcxGridDBBandedTableView;
    cxGrid1Level1: TcxGridLevel;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    Panel14: TPanel;
    cxTextEdit12: TcxTextEdit;
    pnlEdit: TPanel;
    cxCanal: TcxComboBox;
    FDQueryTSOP_Budget: TFDQuery;
    FDQueryTSOP_BudgetTSOP_BUDCOD: TFDAutoIncField;
    FDQueryTSOP_BudgetTSOP_BUDTIP: TStringField;
    FDQueryTSOP_BudgetTSOP_BUDDATREF: TSQLTimeStampField;
    FDQueryTSOP_BudgetTSOP_BUDDAT: TSQLTimeStampField;
    FDQueryTSOP_BudgetTSOP_BUDCLICOD: TStringField;
    FDQueryTSOP_BudgetTSOP_BUDVLF: TBCDField;
    FDQueryTSOP_BudgetTSOP_BUDFAM: TStringField;
    FDQueryTSOP_BudgetTSOP_ORDBILSITNOM: TStringField;
    FDQueryTSOP_BudgetTSOP_USUCOD: TIntegerField;
    FDQueryTSOP_BudgetTSOP_BUDDATCAD: TSQLTimeStampField;
    cxComboBoxTipo: TcxComboBox;
    sqlAux: TFDQuery;
    pnlTop: TPanel;
    Panel3: TPanel;
    txtGrupo: TcxTextEdit;
    Panel6: TPanel;
    TxtCanal: TcxTextEdit;
    Panel5: TPanel;
    ScrollBox: TScrollBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    lblTipo: TcxLabel;
    DtInicial: TDateTimePicker;
    btnSalvar: TcxButton;
    FDScript: TFDScript;
    chkVendedor: TcxCheckBox;
    FDStoredProc: TFDStoredProc;
    ButExcel: TcxButton;
    SaveDialog: TSaveDialog;
    cxGridDetDBTableView1: TcxGridDBTableView;
    cxGridDetLevel1: TcxGridLevel;
    cxGridDet: TcxGrid;
    FDQueryDet: TFDQuery;
    DSDet: TDataSource;
    FDQueryDetTSOP_BUDCOD: TFDAutoIncField;
    FDQueryDetTSOP_BUDTIP: TStringField;
    FDQueryDetTSOP_BUDDATREF: TSQLTimeStampField;
    FDQueryDetTSOP_BUDDAT: TSQLTimeStampField;
    FDQueryDetTSOP_BUDCLICOD: TStringField;
    FDQueryDetTSOP_BUDVLF: TBCDField;
    FDQueryDetTSOP_BUDFAM: TStringField;
    FDQueryDetTSOP_ORDBILSITNOM: TStringField;
    FDQueryDetTSOP_USUCOD: TIntegerField;
    FDQueryDetTSOP_BUDDATCAD: TSQLTimeStampField;
    cxGridDetDBTableView1TSOP_BUDCOD: TcxGridDBColumn;
    cxGridDetDBTableView1TSOP_BUDTIP: TcxGridDBColumn;
    cxGridDetDBTableView1TSOP_BUDDATREF: TcxGridDBColumn;
    cxGridDetDBTableView1TSOP_BUDDAT: TcxGridDBColumn;
    cxGridDetDBTableView1TSOP_BUDCLICOD: TcxGridDBColumn;
    cxGridDetDBTableView1TSOP_BUDVLF: TcxGridDBColumn;
    cxGridDetDBTableView1TSOP_BUDFAM: TcxGridDBColumn;
    cxGridDetDBTableView1TSOP_ORDBILSITNOM: TcxGridDBColumn;
    cxGridDetDBTableView1TSOP_USUCOD: TcxGridDBColumn;
    cxGridDetDBTableView1TSOP_BUDDATCAD: TcxGridDBColumn;
    PopupMenuDet: TPopupMenu;
    VerDetalhe1: TMenuItem;
    FDQueryDetTSIS_USUNOM: TStringField;
    cxGridDetDBTableView1TSIS_USUNOM: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyleData: TcxStyle;
    cxStyleFamilia: TcxStyle;
    TabTarget: TcxTabSheet;
    cxButtonEditPath: TcxButtonEdit;
    cxLabel9: TcxLabel;
    cxButtonProcessar: TcxButton;
    FDSalvaBudgetLK: TFDQuery;
    FDSalvaBudgetLKTSOP_BUDCOD: TFDAutoIncField;
    FDSalvaBudgetLKTSOP_BUDTIP: TStringField;
    FDSalvaBudgetLKTSOP_BUDDATREF: TSQLTimeStampField;
    FDSalvaBudgetLKTSOP_BUDDAT: TSQLTimeStampField;
    FDSalvaBudgetLKTSOP_BUDCLICOD: TStringField;
    FDSalvaBudgetLKTSOP_BUDVLF: TBCDField;
    FDSalvaBudgetLKTSOP_BUDFAM: TStringField;
    FDSalvaBudgetLKTSOP_ORDBILSITNOM: TStringField;
    FDSalvaBudgetLKTSOP_USUCOD: TIntegerField;
    FDSalvaBudgetLKTSOP_BUDDATCAD: TSQLTimeStampField;
    CDSSalvaBudgetLK: TClientDataSet;
    DataSetProviderSalvaBudgetLK: TDataSetProvider;
    CDSSalvaBudgetLKTSOP_BUDCOD: TAutoIncField;
    CDSSalvaBudgetLKTSOP_BUDTIP: TStringField;
    CDSSalvaBudgetLKTSOP_BUDDATREF: TSQLTimeStampField;
    CDSSalvaBudgetLKTSOP_BUDDAT: TSQLTimeStampField;
    CDSSalvaBudgetLKTSOP_BUDCLICOD: TStringField;
    CDSSalvaBudgetLKTSOP_BUDVLF: TBCDField;
    CDSSalvaBudgetLKTSOP_BUDFAM: TStringField;
    CDSSalvaBudgetLKTSOP_ORDBILSITNOM: TStringField;
    CDSSalvaBudgetLKTSOP_USUCOD: TIntegerField;
    CDSSalvaBudgetLKTSOP_BUDDATCAD: TSQLTimeStampField;
    cxTabSheetUpload: TcxTabSheet;
    cxLabel3: TcxLabel;
    cxButtonEditUpload: TcxButtonEdit;
    cxButtonUpload: TcxButton;
    FDQueryTSOP_PeriodoImportacao: TFDQuery;
    FDQueryTSOP_PeriodoImportacaoTSOP_PERIMPINI: TIntegerField;
    FDQueryTSOP_PeriodoImportacaoTSOP_PERIMPFIN: TIntegerField;
    FDQueryTSOP_PeriodoImportacaoTSOP_USUCOD: TIntegerField;
    FDQueryTSOP_PeriodoImportacaoTSOP_PERIMPDATCAD: TSQLTimeStampField;
    cxTextEditIni: TcxTextEdit;
    cxTextEditFim: TcxTextEdit;
    cxLabelIni: TcxLabel;
    cxLabelAte: TcxLabel;
    cxLblLiberar: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButtonRefreshClick(Sender: TObject);
    procedure cxGrid1DBBandedTableView1DblClick(Sender: TObject);
    procedure cxButtonInicioClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cxButton1Click(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure btnSalvarClick(Sender: TObject);
    procedure ButExcelClick(Sender: TObject);
    procedure VerDetalhe1Click(Sender: TObject);
    procedure PageChange(Sender: TObject);
    procedure cxGrid1DBBandedTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxButtonEditPathClick(Sender: TObject);
    procedure cxButtonProcessarClick(Sender: TObject);
    procedure cxButtonUploadClick(Sender: TObject);
    procedure cxButtonEditUploadClick(Sender: TObject);
  private
    { Private declarations }
    NumeroLinhasGrid : Integer;
    ABand  : TcxGridBand;
    iContaGrupo : Integer;
    Edit : Array  of TEdit;
    lblTotal : Array of TLabel;

    LblForecast : Array of TLabel;
    LblCodigo   : Array of TLabel;
    LblNome    : Array of TLabel;
    varMedia : Array of Currency;

    LblTitulo, LblMedia : Array of TLabel;
    varMesesArrayB, varMesesArrayF : Array of TDateTime;

    varMesesComLabel,  varMesesComLabelB, varMesesComLabelF, varMesesSemLabelB, varMesesSemLabelF, varMesesSomaLinha : WideString;
    varDtInicial, varDtFinal : TDateTime;
    procedure Mensagem(pMensagem: String);
    function MontaStringMes(bMostraLabel : Boolean; Alias : String; Tipo : String; SomarL : Boolean) : WideString;
    function BuscaMes(Data: TDateTime; bLabel : Boolean; Alias : String; SomarLinha : Boolean) : String;
    function TrataDataHint (varData : String) : String;
    procedure AddColumn;
    procedure CriarEdit(pGrupo, pVendedor : String);
    function getTSOP_BUDTIP: string;
    procedure KeyPressProc(Sender: TObject; var Key: Char);
    procedure AutoAwesum(AView: TcxGridDBBandedTableView);
    procedure Summarize(ASummary: TcxDataSummary; AColumn: TcxGridDBBandedColumn;
      AKind: TcxSummaryKind; AFormat: string);
//    procedure CriarGrid;
    function  ContaGrupo(pGrupo, pVendedor : String) : Integer;
    procedure CallStoredProc(_pStoredProc: TFDStoredProc; _bOpen: boolean = false);
    function GetStoredProc(_sName: string): TFDStoredProc;
    procedure LimparTelaDinamica;
    function LeftPad(value: integer; length: integer=2; pad: char='0'): string;

    function MontaDataDashBoard(DataAtual : TDateTime; bForecast : Boolean; bForecastDataFinal : Boolean) : TDateTime;

  public
    { Public declarations }
     procedure AbrirDataset;
  end;

type
  TStringGridHack = class(TStringGrid)
  protected
    procedure DeleteRow(ARow: Longint); reintroduce;
    procedure InsertRow(ARow: Longint);
  end;

var
  frmExibeForecast: TfrmExibeForecast;

implementation

{$R *.dfm}

uses uUtils, uBrady;

procedure TfrmExibeForecast.Mensagem(pMensagem: String);
begin
  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;
end;

function TfrmExibeForecast.MontaDataDashBoard(DataAtual: TDateTime; bForecast : Boolean; bForecastDataFinal : Boolean): TDateTime;
var
 Ano, Mes, Dia: Word;
 MesFiscal, MesAbrev : String;
 varData : string;
begin

   //2019-03-17

   DecodeDate(DataAtual, Ano, Mes, Dia);

   if ((bForecast = False) and (bForecastDataFinal = False)) then // monta data inicial de billing
   begin
     if Mes <= 7 then
       Ano := Ano - 1;

     varData := '01/08/' +  VarToStr(Ano);
   end
   else    if ((bForecast = True) and (bForecastDataFinal = False)) then    // monta data inicial de forecast
   begin
     Mes := Mes + 1;
     varData := '01/' + VarToStr(Mes) +'/' +  VarToStr(Ano);
   end;

   if bForecastDataFinal = True then    // monta data final de forecast
   begin
     varData :=  '31/07/' + VarToStr(Ano);
   end;
   result :=  StrToDate(varData);

end;

function TfrmExibeForecast.MontaStringMes(bMostraLabel : Boolean; Alias : String; Tipo : String; SomarL : Boolean): WideString;
var
 I            : Integer;
 NovaData     : TDateTime;
 varResultado : String;
begin
  SetLength(varMesesArrayB, 12);
  SetLength(varMesesArrayF, 13);

  NovaData := System.DateUtils.StartOfTheMonth(dtInicial.Date);

  if ((Alias = '')or (Alias = 'B'))  and (Tipo = 'B') then
    NovaData     :=  IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -12);

  varResultado := '';
  if ((Alias = '')or (Alias = 'B')) and (Tipo = 'B') then
  begin
    for I := 0 to 11 do
    begin
      varMesesArrayB[I] := NovaData;
      varResultado      := varResultado + BuscaMes(NovaData, bMostraLabel,Alias,SomarL);
      NovaData          := IncMonth(NovaData,1);
    end;
  end
  else
  begin
    for I := 0 to 12 do
    begin
      varMesesArrayF[I] := NovaData;
      varResultado      := varResultado + BuscaMes(NovaData, bMostraLabel,Alias, SomarL);
      NovaData          := IncMonth(NovaData,1);
    end;
  end;

  result := varResultado;
end;


procedure TfrmExibeForecast.PageChange(Sender: TObject);
begin
  if Page.ActivePage = TabForecast then
  begin
     LimparTelaDinamica;
     FDQueryDet.Close;
     cxGridDet.Visible := False;
  end;
end;

function TfrmExibeForecast.BuscaMes(Data: TDateTime; bLabel : Boolean; Alias : String; SomarLinha : Boolean) : String;
var
 Ano, Mes, Dia: Word;
 MesFiscal, MesAbrev : String;
 strFormatDate : string;
begin
   DecodeDate(Data, Ano, Mes, Dia);
   MesAbrev := formatdatetime('mmm', Data);

   MesAbrev := StringReplace(MesAbrev,'dez','Dec',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'set','Sep',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'abr','Apr',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'ago','Aug',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'mai','May',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'out','Oct',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'fev','Feb',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'nov','Nov',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'jan','Jan',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'mar','Mar',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'jun','Jun',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'jul','Jul',[rfReplaceAll, rfIgnoreCase]);
   strFormatDate :=  '[' + MesAbrev  + ' ' + IntToStr(Ano)  +  ']';



   if bLabel then
   begin
     Case Mes Of
         1   : MesFiscal := strFormatDate + ','; // + ' AS JANEIRO,' ;
         2   : MesFiscal := strFormatDate + ','; // + ' AS FEVEREIRO,' ;
         3   : MesFiscal := strFormatDate + ','; // + ' AS MARÇO,' ;
         4   : MesFiscal := strFormatDate + ','; // + ' AS ABRIL,' ;
         5   : MesFiscal := strFormatDate + ','; // + ' AS MAIO,' ;
         6   : MesFiscal := strFormatDate + ','; // + ' AS JUNHO,' ;
         7   : MesFiscal := strFormatDate + ','; // + ' AS JULHO,' ;
         8   : MesFiscal := strFormatDate + ','; // + ' AS AGOSTO,' ;
         9   : MesFiscal := strFormatDate + ','; // + ' AS SETEMBRO,' ;
         10  : MesFiscal := strFormatDate + ','; // + ' AS OUTUBRO,' ;
         11  : MesFiscal := strFormatDate + ','; // + ' AS NOVEMBRO,' ;
         12  : MesFiscal := strFormatDate + ','; // + ' AS DEZEMBRO,' ;
     End ;
   end
   else
   begin
     Case Mes Of
         1   : MesFiscal := strFormatDate + ',' ;
         2   : MesFiscal := strFormatDate + ',' ;
         3   : MesFiscal := strFormatDate + ',' ;
         4   : MesFiscal := strFormatDate + ',' ;
         5   : MesFiscal := strFormatDate + ',' ;
         6   : MesFiscal := strFormatDate + ',' ;
         7   : MesFiscal := strFormatDate + ',' ;
         8   : MesFiscal := strFormatDate + ',' ;
         9   : MesFiscal := strFormatDate + ',' ;
         10  : MesFiscal := strFormatDate + ',' ;
         11  : MesFiscal := strFormatDate + ',' ;
         12  : MesFiscal := strFormatDate + ',' ;
     End ;
   end;


   //if (Alias <> '') then
   //    MesFiscal := Alias + '.' + MesFiscal;
   if SomarLinha then
   begin
      MesFiscal := Copy(MesFiscal,1,length(MesFiscal)-1);

      Case Mes Of
         1   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         2   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         3   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         4   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         5   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         6   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         7   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         8   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         9   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         10  : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         11  : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         12  : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
     End ;
   end
   else
   begin
     if (Alias <> '') and (bLabel) then
     begin
        MesFiscal := Copy(MesFiscal,1,length(MesFiscal)-1);

        Case Mes Of
           1   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Jan_' + IntToStr(Ano) + ',' ;
           2   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Fev_' + IntToStr(Ano) + ',' ;
           3   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Mar_' + IntToStr(Ano) + ',' ;
           4   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Abr_' + IntToStr(Ano) + ',' ;
           5   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Mai_' + IntToStr(Ano) + ',' ;
           6   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Jun_' + IntToStr(Ano) + ',' ;
           7   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Jul_' + IntToStr(Ano) + ',' ;
           8   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Ago_' + IntToStr(Ano) + ',' ;
           9   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Set_' + IntToStr(Ano) + ',' ;
           10  : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Out_' + IntToStr(Ano) + ',' ;
           11  : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Nov_' + IntToStr(Ano) + ',' ;
           12  : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Dez_' + IntToStr(Ano) + ',' ;
       End ;
     end;
   end;



   Result :=  MesFiscal;

end;


procedure TfrmExibeForecast.ButExcelClick(Sender: TObject);
begin
  if Page.ActivePageIndex = 0 then
  begin

        if FDQueryForecast.IsEmpty then
            raise Exception.Create('Não há dados para serem exportados ao Excel');

      //  SaveDialog.InitialDir := GetCurrentDir;
        Mensagem('Aguarde, Salvando Planilha...');
        if SaveDialog.Execute then
        begin
           Screen.Cursor := crHourGlass;
           ExportGridToExcel(SaveDialog.FileName, cxGrid1, True, True);
           MessageDlg( pChar( 'Planilha exportada em  ' + ExtractFilePath(SaveDialog.FileName) )  , mtInformation, [ mbOk ], 0 );

        end;
        Screen.Cursor := crDefault;
        Mensagem( EmptyStr );
  end;
end;

procedure  TfrmExibeForecast.LimparTelaDinamica;
var
 i : integer;
begin
  if Edit <> Nil then
  begin

   for i := ComponentCount - 1 downto 0 do
    begin
      If (Components[i] is tedit) then
      begin
        Tedit(Components[i]).Clear;
        Tedit(Components[i]).Free;
      end;
    end;

  end;

  if LblMedia <> Nil then
  begin

    for i := ComponentCount - 1 downto 0 do
    begin
      If (Components[i] is TLabel) then
        TLabel(Components[i]).Free;
    end;

  end;


end;

procedure TfrmExibeForecast.CriarEdit(pGrupo, pVendedor : String);
Const
  Letra : Array[0..50] of String = ('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','x','y','w','z', 'aa','bb','cc','dd','ee','ff','gg','hh','ii','kk','ll','mm','nn','oo','pp','qq','rr','ss','tt','uu','vv','xx','yy','ww','zz');
var
  o, i, x, y, f, g, h, l, j, w, m, a, itab, top1, top2, L1, L2, L3 : Integer;
  b : TBookMark;
  bPrintLabel : Boolean;
  TotalMeses : Array of Currency;
  varData : Array of  String;
  LabelTotal : TLabel;
begin

    LimparTelaDinamica;

    Mensagem('Aguarde...');

    iContaGrupo := ContaGrupo(pGrupo,pVendedor);

    SetLength(LblTitulo, 14);

    SetLength(LblForecast, iContaGrupo);
    SetLength(LblCodigo, iContaGrupo);
    SetLength(LblNome, iContaGrupo);

    SetLength(Edit,     12*iContaGrupo);
    SetLength(LblMedia, 13*iContaGrupo);

    SetLength(lblTotal,     12);
    SetLength(TotalMeses,   12);
    SetLength(varData,      12);


    FDQueryForecast.Locate( 'TSOP_ORDBILGRUCLINOM;TSOP_ORDBILREPNOM', VarArrayOf([pGrupo,pVendedor]));

    b:= FDQueryForecast.GetBookmark;
    FDQueryForecast.DisableControls;
    Try

     o     := 0;
     x     := 0;
     y     := 0;
     itab  := 0;
     w     := 0;
     l     := 370;
     f     := 0;
     g     := 0;
     h     := 0;
     j     := 0;
     m     := 0;
     top1  := 20;
     top2  := top1 + 22;
     L1    := 10;
     L2    := 70;
     L3    := 300;


      varData[0]  :=  TrataDataHint(FDQueryForecast.Fields[20].FieldName);
      varData[1]  :=  TrataDataHint(FDQueryForecast.Fields[21].FieldName);
      varData[2]  :=  TrataDataHint(FDQueryForecast.Fields[22].FieldName);
      varData[3]  :=  TrataDataHint(FDQueryForecast.Fields[23].FieldName);
      varData[4]  :=  TrataDataHint(FDQueryForecast.Fields[24].FieldName);
      varData[5]  :=  TrataDataHint(FDQueryForecast.Fields[25].FieldName);
      varData[6]  :=  TrataDataHint(FDQueryForecast.Fields[26].FieldName);
      varData[7]  :=  TrataDataHint(FDQueryForecast.Fields[27].FieldName);
      varData[8]  :=  TrataDataHint(FDQueryForecast.Fields[28].FieldName);
      varData[9]  :=  TrataDataHint(FDQueryForecast.Fields[29].FieldName);
      varData[10] :=  TrataDataHint(FDQueryForecast.Fields[30].FieldName);
      varData[11] :=  TrataDataHint(FDQueryForecast.Fields[31].FieldName);


       bPrintLabel := True;
       while  not FDQueryForecast.Eof  do
       begin

        if ((FDQueryForecast.Fields[1].AsString <> pGrupo) or (FDQueryForecast.Fields[0].AsString <> pVendedor)) then
        begin
           Mensagem(EmptyStr);
           LabelTotal                := TLabel.Create(Self);
           LabelTotal.Parent         := Panel5;
           LabelTotal.Top            := 10;
           LabelTotal.Left           := 300;
           LabelTotal.Font.Style     := [fsBold];
           LabelTotal.Caption        := 'Total por Grupo';

           top2 := 10;
           l    := 405;
           for I := Low(TotalMeses) to High(TotalMeses) do
           begin

               lblTotal[i]                := TLabel.Create(Self);
               lblTotal[i].Parent         := Panel5;
               lblTotal[i].Name           := 'Total_' + IntToStr(I);
              //lblTotal[i].Width          := 70;
               lblTotal[i].Alignment      := taRightJustify;
               lblTotal[i].Caption        := StringReplace(CurrToStrF(TotalMeses[i], ffCurrency, 2),'R$','',[rfReplaceAll, rfIgnoreCase]);
               lblTotal[i].Top            := top2;
               lblTotal[i].Left           := l;
               l := l + 80;
           end;

           for I := Low(Edit) to High(Edit) do
             if Edit[I].CanFocus then
             begin
               Edit[I].SetFocus;
               Break;
             end;

           Exit;
        end;

        if ((FDQueryForecast.Fields[1].AsString = pGrupo) and (FDQueryForecast.Fields[0].AsString = pVendedor)) then
        begin

            for I := 20 to 34 do
            begin

              if x = 0 then
              begin

                 LblCodigo[f]            := TLabel.Create(Self);
                 LblCodigo[f].Parent     := ScrollBox;
                 LblCodigo[f].Caption    := FDQueryForecast.Fields[2].AsString;
                 LblCodigo[f].Top        := top1;
                 LblCodigo[f].Left       := L1;
                 LblCodigo[f].Hint       := FDQueryForecast.Fields[4].AsString;
                 Inc(f);

              end;

              if x = 1 then
              begin

                 LblNome[g]            := TLabel.Create(Self);
                 LblNome[g].Parent     := ScrollBox;
                 LblNome[g].Width      := 50;
                 LblNome[g].Caption    := Copy(FDQueryForecast.Fields[3].AsString,1,38);
                 LblNome[g].Top        := top1;
                 LblNome[g].Left       := L2;
                 LblNome[g].Hint       := FDQueryForecast.Fields[7].AsString;
                 LblNome[g].AutoSize   := True;
                 Inc(g);

              end;

              if x = 2 then
              begin

                 LblForecast[h]            := TLabel.Create(Self);
                 LblForecast[h].Parent     := ScrollBox;
                 LblForecast[h].Name       := 'Forecast_' + IntToStr(I) + Letra[o];
                 LblForecast[h].Caption    := 'Forecast';
                 LblForecast[h].Top        := top1;
                 LblForecast[h].Left       := L3;
                 Inc(h);

                 LblMedia[j]               := TLabel.Create(Self);
                 LblMedia[j].Parent        := ScrollBox;
                 LblMedia[j].Name          := 'Media_' + IntToStr(I) + Letra[o];
                 LblMedia[j].Caption       := 'Média';
                 LblMedia[j].Top           := top2;
                 LblMedia[j].Left          := L3;

                 Inc(j);

              end
              else
              begin
                 if x >= 3 then
                 begin

                   LblTitulo[x]        := TLabel.Create(Self);
                   LblTitulo[x].Parent := pnlTop;
                   LblTitulo[x].Left   := l;

                   if bPrintLabel then
                   begin
                     LblTitulo[x].Caption      := Copy(FDQueryForecast.Fields[I-3].FieldName,1, length(FDQueryForecast.Fields[I-3].FieldName)-5);
                     LblTitulo[x].Top          := 61;
                   end;

                   if I = 34 then
                      bPrintLabel := False;

                   Edit[y]                    := TEdit.Create(Self);
                   Edit[y].Parent             := ScrollBox;
                   Edit[y].Width              := 70;
                   Edit[y].Alignment          := taRightJustify;
                   Edit[y].Left               := l;
                   Edit[y].Name               := FDQueryForecast.Fields[I-3].FieldName + '_' + Letra[o];
                   Edit[y].Text               := StringReplace(CurrToStrF(FDQueryForecast.Fields[I-3].AsFloat, ffCurrency, 2),'R$','',[rfReplaceAll, rfIgnoreCase]);
                   Edit[y].Top                := top1;
                   Edit[y].TabOrder           := itab;
                   Edit[y].Hint               := TrataDataHint(FDQueryForecast.Fields[I-3].FieldName);
                   Edit[y].OnKeyPress         := KeyPressProc;
                   // travar o mes atual
                   if ((I-3) = 20) then
                      Edit[y].Enabled := False;

                   // se dia for maior ou igual a 10, travar o mes seguinte.
                  { if ((DayOf(now) >= 10) and ((I-3) = 21)) then
                      Edit[y].Enabled := False;
                   }

                   if ((I-3) = 20)  then
                      if DayOf(now) in [StrToIntDef(cxTextEditFim.Text,0)..StrToIntDef(cxTextEditIni.Text,0)] = false then
                          Edit[y].Enabled := True;
                  {
                   if ((I-3) = 21)  then
                      if DayOf(now) in [StrToIntDef(cxTextEditFim.Text,0)..StrToIntDef(cxTextEditIni.Text,0)] = false then
                          Edit[y].Enabled := True
                      else  Edit[y].Enabled := False;
                   }
                                                                                            {
                   if (( (DayOf(now) >= StrToIntDef(cxTextEditIni.Text,0)) or (DayOf(now) <= StrToIntDef(cxTextEditFim.Text,0))  ) and ((I-3) = 20)) then
                      Edit[y].Enabled := True;


                   if (( (DayOf(now) >= StrToIntDef(cxTextEditIni.Text,0)) or (DayOf(now) <= StrToIntDef(cxTextEditFim.Text,0))  ) and ((I-3) = 21)) then
                      Edit[y].Enabled := True;

                                                                                             }

                   if (varData[0] = TrataDataHint(FDQueryForecast.Fields[I-3].FieldName)) then
                       TotalMeses[0]              := TotalMeses[0] + FDQueryForecast.Fields[I-3].AsFloat;

                   if (varData[1] = TrataDataHint(FDQueryForecast.Fields[I-3].FieldName)) then
                       TotalMeses[1]              := TotalMeses[1] + FDQueryForecast.Fields[I-3].AsFloat;

                   if (varData[2] = TrataDataHint(FDQueryForecast.Fields[I-3].FieldName)) then
                       TotalMeses[2]              := TotalMeses[2] + FDQueryForecast.Fields[I-3].AsFloat;

                   if (varData[3] = TrataDataHint(FDQueryForecast.Fields[I-3].FieldName)) then
                       TotalMeses[3]              := TotalMeses[3] + FDQueryForecast.Fields[I-3].AsFloat;

                   if (varData[4] = TrataDataHint(FDQueryForecast.Fields[I-3].FieldName)) then
                       TotalMeses[4]              := TotalMeses[4] + FDQueryForecast.Fields[I-3].AsFloat;

                   if (varData[5] = TrataDataHint(FDQueryForecast.Fields[I-3].FieldName)) then
                       TotalMeses[5]              := TotalMeses[5] + FDQueryForecast.Fields[I-3].AsFloat;

                   if (varData[6] = TrataDataHint(FDQueryForecast.Fields[I-3].FieldName)) then
                       TotalMeses[6]              := TotalMeses[6] + FDQueryForecast.Fields[I-3].AsFloat;

                   if (varData[7] = TrataDataHint(FDQueryForecast.Fields[I-3].FieldName)) then
                       TotalMeses[7]              := TotalMeses[7] + FDQueryForecast.Fields[I-3].AsFloat;

                   if (varData[8] = TrataDataHint(FDQueryForecast.Fields[I-3].FieldName)) then
                       TotalMeses[8]              := TotalMeses[8] + FDQueryForecast.Fields[I-3].AsFloat;

                   if (varData[9] = TrataDataHint(FDQueryForecast.Fields[I-3].FieldName)) then
                       TotalMeses[9]              := TotalMeses[9] + FDQueryForecast.Fields[I-3].AsFloat;

                   if (varData[10] = TrataDataHint(FDQueryForecast.Fields[I-3].FieldName)) then
                       TotalMeses[10]              := TotalMeses[10] + FDQueryForecast.Fields[I-3].AsFloat;

                   if (varData[11] = TrataDataHint(FDQueryForecast.Fields[I-3].FieldName)) then
                       TotalMeses[11]              := TotalMeses[11] + FDQueryForecast.Fields[I-3].AsFloat;

                   Inc(y);

                   Inc(itab);

                   SetLength(varMedia,     12);
                   for a := 0 to 11 do
                        varMedia[a] := 0;

                   if ((FDQueryForecast.Fields[8].AsFloat <> 0) or
                       (FDQueryForecast.Fields[9].AsFloat  <> 0) or
                       (FDQueryForecast.Fields[10].AsFloat <> 0) or
                       (FDQueryForecast.Fields[11].AsFloat <> 0) or
                       (FDQueryForecast.Fields[12].AsFloat <> 0) or
                       (FDQueryForecast.Fields[13].AsFloat <> 0) or
                       (FDQueryForecast.Fields[14].AsFloat <> 0) or
                       (FDQueryForecast.Fields[15].AsFloat <> 0) or
                       (FDQueryForecast.Fields[16].AsFloat <> 0) or
                       (FDQueryForecast.Fields[17].AsFloat <> 0) or
                       (FDQueryForecast.Fields[18].AsFloat <> 0) or
                       (FDQueryForecast.Fields[19].AsFloat <> 0))  Then


                       for a := 0 to 11 do
                          varMedia[a]  :=   (FDQueryForecast.Fields[8].AsFloat +
                                             FDQueryForecast.Fields[9].AsFloat +
                                             FDQueryForecast.Fields[10].AsFloat +
                                             FDQueryForecast.Fields[11].AsFloat +
                                             FDQueryForecast.Fields[12].AsFloat +
                                             FDQueryForecast.Fields[13].AsFloat +
                                             FDQueryForecast.Fields[14].AsFloat +
                                             FDQueryForecast.Fields[15].AsFloat +
                                             FDQueryForecast.Fields[16].AsFloat +
                                             FDQueryForecast.Fields[17].AsFloat +
                                             FDQueryForecast.Fields[18].AsFloat +
                                             FDQueryForecast.Fields[19].AsFloat) / 12;

                   LblMedia[y]               := TLabel.Create(Self);
                   LblMedia[y].Parent        := ScrollBox;
                   LblMedia[y].Width         := 72;
                   LblMedia[y].Alignment     := taRightJustify;
                   LblMedia[y].BiDiMode      := bdRightToLeftReadingOnly;
                   LblMedia[y].AutoSize      := False;
                   LblMedia[y].Name          := 'Media' + IntToStr(I) +  Letra[o];
                   LblMedia[y].Caption       := StringReplace(CurrToStrF(varMedia[I-23], ffCurrency, 2),'R$','',[rfReplaceAll, rfIgnoreCase]);
                   LblMedia[y].Top           := top2;
                   LblMedia[y].Left          := l;


                   Inc(j);
                   l := l + 80;
                 end;
              end;

              Inc(x);

            end;

            inc(o);
            top1  := top1 + 65;
            top2  := top1 + 20;

        end;
        x    := 0;
        l    := 370;
        FDQueryForecast.Next;

       end;
     Mensagem(EmptyStr);
     for I := Low(Edit) to High(Edit) do
     begin
       if Edit[I].CanFocus then
        begin
         Edit[I].SetFocus;
         Break;
       end;
     end;



  Finally
    FDQueryForecast.GotoBookmark(b);
    FDQueryForecast.FreeBookmark(b);
    FDQueryForecast.EnableControls;
  End;
end;
      {
procedure TfrmExibeForecast.CriarGrid;
var
  I, X: Integer;
  varGrupo, varVendedor : String;
   b : TBookMark;
begin
  Mensagem('Aguarde...');

  for i := 0 to 13  do
    StringGrid1.ColWidths[i] := 80;

  varGrupo    := FDQueryForecast.Fields[1].AsString;
  varVendedor := FDQueryForecast.Fields[0].AsString;

  NumeroLinhasGrid := ContaGrupo(FDQueryForecast.Fields[1].AsString,FDQueryForecast.Fields[0].AsString);


  for i := 0 to NumeroLinhasGrid do
    TStringGridHack(StringGrid1).InsertRow(1);

  StringGrid1.Cells[0,0] := FDQueryForecast.Fields[3].AsString;
  StringGrid1.Cells[1,0] :=  FDQueryForecast.Fields[2].AsString;

  for I := 20 to 33 do
    StringGrid1.Cells[I-18,0] := Copy(FDQueryForecast.Fields[I-2].FieldName,1, length(FDQueryForecast.Fields[I-2].FieldName)-5);

//


  b:= FDQueryForecast.GetBookmark;
  FDQueryForecast.DisableControls;
  X:= 1;
  Try
   FDQueryForecast.First;
   while not FDQueryForecast.eof do
   begin
      if ((FDQueryForecast.Fields[1].AsString = varGrupo) and (FDQueryForecast.Fields[0].AsString = varVendedor)) then
      begin
            for I := 20 to 33 do
            begin
              StringGrid1.Cells[I-18,X] := FloatToStr( FDQueryForecast.Fields[I-2].AsFloat);

            end;

            Inc(x);

      end;


      FDQueryForecast.Next;
   end;

  Finally
    FDQueryForecast.GotoBookmark(b);
    FDQueryForecast.FreeBookmark(b);
    FDQueryForecast.EnableControls;
  End;






  StringGrid1.Cells[0,1] := 'Adriano';
  StringGrid1.Cells[1,1] := 'Santos';
  StringGrid1.Cells[2,1] := 'asrsantos@gmail.com';
  StringGrid1.Cells[3,1] := 'delphitodelphi.blogspot.com';


  Mensagem('');
        {
    for I := 20 to 33  do
    begin

      Edit[x]         := TLabeledEdit.Create(Self);
      EditMedia[x]    := TLabeledEdit.Create(Self);

      if I = 20 then
        Edit[x].Enabled := False;

      if I = 20 then
        EditMedia[x].Enabled := False;


      Edit[x].Parent  := pnlEdit;
      EditMedia[x].Parent  := pnlEdit;

      Edit[x].Width   := 70;
      EditMedia[x].Width   := 70;


       Edit[x].Top   := 80;
       Edit[x].Left  := z;

       EditMedia[x].Top   := 110;
       EditMedia[x].Left  := z;

        z := z + 80;

       if I = 20 then
       begin
         Edit[x].Name              := 'Media_' + IntToStr(I); //FDQueryForecast.Fields[2].FieldName;
         Edit[x].Text              := 'Média'; //FDQueryForecast.Fields[2].AsString;
         EditMedia[x].Width        := 150;

       end
       else  if I = 21 then
       begin

         Edit[x].Name              := 'Forecast_' + IntToStr(I); // FDQueryForecast.Fields[3].FieldName;
         Edit[x].Text              := 'Forecast'; //FDQueryForecast.Fields[3].AsString;
         EditMedia[x].Width        := 150;
       end
       else
       begin
         Edit[x].Name              := FDQueryForecast.Fields[I-2].FieldName;
         Edit[x].EditLabel.Caption := Copy(FDQueryForecast.Fields[I-2].FieldName,1, length(FDQueryForecast.Fields[I-2].FieldName)-5);
         Edit[x].Text              := FDQueryForecast.Fields[I-2].AsString;
       end;

       Edit[x].TabOrder := x;
       EditMedia[x].TabOrder := x;

       Edit[x].OnKeyPress := KeyPressProc;
       EditMedia[x].OnKeyPress := KeyPressProc;

       Inc(x);

    end;
    Edit[1].SetFocus;



end;
}

procedure TFrmExibeForecast.KeyPressProc(Sender: TObject; var Key: Char);
var
  FormatBr: TFormatSettings;
begin
  FormatBr.DecimalSeparator    := ',';

  if not (Key in [#8, #13, '0'..'9', '-', '.', FormatBr.DecimalSeparator]) then
  begin
    ShowMessage('Tecla inválida: ' + Key);
    Key := #0;
  end
  else if ((Key = FormatBr.DecimalSeparator) or (Key = '-')) and
          (Pos(Key,   (Sender as TEdit).Text) > 0) then begin
    ShowMessage('Tecla inválida: 2 vezes ' + Key);
    Key := #0;
  end
  else if (Key = '-') and
          ((Sender as TEdit).SelStart <> 0) then begin
    ShowMessage('Somente permitido no inicio do número: ' + Key);
    Key := #0;
  end;
end;

procedure TfrmExibeForecast.cxButton1Click(Sender: TObject);
var
 i : Integer;
begin
   {
   if NumeroLinhasGrid > 0 then
   begin
    for I := 0 to NumeroLinhasGrid do
      TStringGridHack(StringGrid1).DeleteRow(i);
   end;
   NumeroLinhasGrid := 0;
   }
end;

procedure TfrmExibeForecast.cxButtonEditPathClick(Sender: TObject);
begin
  if SaveDialog.Execute(Handle) then
  begin
    cxButtonEditPath.Text := SaveDialog.FileName;
  end;
end;

procedure TfrmExibeForecast.cxButtonEditUploadClick(Sender: TObject);
begin
  if SaveDialog.Execute(Handle) then
  begin
    cxButtonEditUpload .Text := SaveDialog.FileName;
  end;
end;

procedure TfrmExibeForecast.cxButtonInicioClick(Sender: TObject);
var
  I, X: Integer;
  varData: TDateTime;
  varDataReferencia: TDateTime;
  varMesAno: String;
  varMes, varAno: Integer;
  varLocate: Boolean;
  varSite, varFamilia, varCliente: String;
  varForecast, varValidaForecast : Extended;
  varCurrentMonth: Integer;
   Ano, Mes, Dia: Word;
begin


  Mensagem( 'Salvando...' );
  try


      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );

      FDConnection.Open;
      try

        for varCurrentMonth := 1 to 12 do
        begin

          varDataReferencia := IncMonth(System.DateUtils.StartOfTheMonth(Now),varCurrentMonth-1);

          //if Fr_Brady.SalesRep then
          //  FDQueryTSOP_Budget.MacroByName( 'WHERE1' ).AsRaw := ' AND A01.TSOP_ORDBILREPNOM = ' + QuotedStr(Fr_Brady.TSIS_USUNOM);

        //  FDQueryTSOP_Budget.ParamByName( 'TSOP_BUDDATREF' ).AsDateTime := varDataReferencia;
        //  FDQueryTSOP_Budget.ParamByName( 'TSOP_BUDTIP' ).AsString      := getTSOP_BUDTIP;
        //  FDQueryTSOP_Budget.Open;
        //  try

              try

                for I := 1 to 12 do
                begin
                  DecodeDate(varMesesArrayF[I], Ano, Mes, Dia);
                  {
                  varMes := -1;
                  varMesAno := dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[I].AsString;

                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('JAN') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('JAN') then
                    varMes := 01
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('FEV') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('FEB') then
                    varMes := 02
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('MAR') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('MAR') then
                    varMes := 03
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('ABR') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('APR') then
                    varMes := 04
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('MAI') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('MAY') then
                    varMes := 05
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('JUN') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('JUN') then
                    varMes := 06
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('JUL') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('JUL') then
                    varMes := 07
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('AGO') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('AUG') then
                    varMes := 08
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('SET') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('SEP') then
                    varMes := 09
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('OUT') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('OCT') then
                    varMes := 10
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('NOV') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('NOV') then
                    varMes := 11
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('DEZ') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('DEC') then
                    varMes := 12;

                  varAno       := StrToInt(varMesAno.Split(['-'])[1].Trim);
                  }
                  varData      := EncodeDate( Ano, Mes, 01 );

                  varValidaForecast := 0;
                  if TryStrToFloat(Edit[i-1].Text, varValidaForecast) then
                     varForecast  := StrToFloat(Edit[i-1].Text)
                  else  varForecast := 0.00;

                  //varCliente   := txtCodigoCliente.Text;
                  //varSite      := txtSite.Text;
                  varFamilia   := EmptyStr;

                  varLocate := False;
                  sqlAux.Close;
                  sqlAux.SQL.Clear;
                  sqlAux.SQL.Add('Select TSOP_BUDCLICOD from TSOP_Budget WITH (NOLOCK) ');
                  sqlAux.SQL.Add('Where  TSOP_ORDBILSITNOM = :TSOP_ORDBILSITNOM');
                  sqlAux.SQL.Add('and    TSOP_BUDCLICOD = :TSOP_BUDCLICOD');
                  sqlAux.SQL.Add('and    TSOP_BUDDAT = :TSOP_BUDDAT');
                  sqlAux.SQL.Add('and    TSOP_BUDDATREF = :TSOP_BUDDATREF');
                  sqlAux.SQL.Add('and    TSOP_BUDTIP = :TSOP_BUDTIP');


                  sqlAux.Params.ParamByName('TSOP_ORDBILSITNOM').AsString :=  varSite;
                  sqlAux.Params.ParamByName('TSOP_BUDCLICOD').AsString    :=  varCliente;
                  sqlAux.Params.ParamByName('TSOP_BUDDAT').AsDateTime     :=  varData;
                  sqlAux.Params.ParamByName('TSOP_BUDDATREF').AsDateTime  :=  varDataReferencia;
                  sqlAux.Params.ParamByName('TSOP_BUDTIP').AsString       :=  getTSOP_BUDTIP;

                  sqlAux.Open;
                  if not sqlAux.IsEmpty then
                      varLocate := True;

                 // varLocate := FDQueryTSOP_Budget.Locate( 'TSOP_ORDBILSITNOM;TSOP_BUDCLICOD;TSOP_BUDDAT', VarArrayOf( [varSite,varCliente,varData] ) );

                  if varForecast < 0.00 then
                    varForecast := 0.00;

                  if varLocate then
                  begin


                    sqlAux.Close;
                    sqlAux.SQL.Clear;
                    sqlAux.SQL.Add('Update TSOP_Budget ');
                    sqlAux.SQL.Add('Set TSOP_BUDVLF = :TSOP_BUDVLF, TSOP_USUCOD = :TSOP_USUCOD, TSOP_BUDDATCAD = :TSOP_BUDDATCAD ');
                    sqlAux.SQL.Add(' Where  TSOP_ORDBILSITNOM = :TSOP_ORDBILSITNOM and  TSOP_BUDCLICOD = :TSOP_BUDCLICOD and  TSOP_BUDDAT = :TSOP_BUDDAT ');
                    sqlAux.SQL.Add(' and  TSOP_BUDDATREF = :TSOP_BUDDATREF and  TSOP_BUDTIP = :TSOP_BUDTIP ');
                    sqlAux.Params.ParamByName('TSOP_BUDVLF').AsFloat        :=  varForecast;
                    sqlAux.Params.ParamByName('TSOP_USUCOD').AsInteger      :=  Fr_Brady.TSIS_USUCOD;
                    sqlAux.Params.ParamByName('TSOP_BUDDATCAD').AsDateTime  :=  Now;
                    sqlAux.Params.ParamByName('TSOP_ORDBILSITNOM').AsString :=  varSite;
                    sqlAux.Params.ParamByName('TSOP_BUDCLICOD').AsString    :=  varCliente;
                    sqlAux.Params.ParamByName('TSOP_BUDDAT').AsDateTime     :=  varData;
                    sqlAux.Params.ParamByName('TSOP_BUDDATREF').AsDateTime  :=  varDataReferencia;
                    sqlAux.Params.ParamByName('TSOP_BUDTIP').AsString       :=  getTSOP_BUDTIP;


                    try
                      sqlAux.ExecSQL;
                    except
                      on E: Exception do
                      begin
                        ShowMessage(E.Message);
                      end;
                    end;
                    {
                    FDQueryTSOP_Budget.Edit;
                    FDQueryTSOP_BudgetTSOP_BUDVLF.AsFloat := varForecast;
                    FDQueryTSOP_BudgetTSOP_USUCOD.AsInteger := Fr_Brady.TSIS_USUCOD;
                    FDQueryTSOP_BudgetTSOP_BUDDATCAD.AsDateTime := Now;

                    try
                      FDQueryTSOP_Budget.Post;
                    except
                      on E: Exception do
                      begin
                        FDQueryTSOP_Budget.Cancel;
                        ShowMessage(E.Message);
                      end;
                    end;

                     }

                  end
                  else
                  begin

                    if varForecast > 0.00 then
                    begin

                      sqlAux.Close;
                      sqlAux.SQL.Clear;
                      sqlAux.SQL.Add('Insert Into TSOP_Budget (TSOP_BUDTIP, TSOP_BUDDATREF, TSOP_BUDDAT, TSOP_BUDCLICOD, TSOP_BUDVLF, ');
                      sqlAux.SQL.Add('TSOP_ORDBILSITNOM, TSOP_USUCOD, TSOP_BUDDATCAD) ');

                      sqlAux.SQL.Add(' Values (:TSOP_BUDTIP, :TSOP_BUDDATREF, :TSOP_BUDDAT, :TSOP_BUDCLICOD, :TSOP_BUDVLF, ');
                      sqlAux.SQL.Add(':TSOP_ORDBILSITNOM, :TSOP_USUCOD, :TSOP_BUDDATCAD)');


                      sqlAux.Params.ParamByName('TSOP_BUDTIP').AsString       :=  getTSOP_BUDTIP;
                      sqlAux.Params.ParamByName('TSOP_BUDDATREF').AsDateTime  :=  varDataReferencia;
                      sqlAux.Params.ParamByName('TSOP_BUDDAT').AsDateTime     :=  varData;
                      sqlAux.Params.ParamByName('TSOP_BUDCLICOD').AsString    :=  varCliente;
                      sqlAux.Params.ParamByName('TSOP_BUDVLF').AsFloat        :=  varForecast;
                      sqlAux.Params.ParamByName('TSOP_ORDBILSITNOM').AsString :=  varSite;
                      sqlAux.Params.ParamByName('TSOP_USUCOD').AsInteger      :=  Fr_Brady.TSIS_USUCOD;
                      sqlAux.Params.ParamByName('TSOP_BUDDATCAD').AsDateTime  :=  Now;

                      try
                        sqlAux.ExecSQL;
                      except
                        on E: Exception do
                        begin
                          ShowMessage(E.Message);
                        end;
                      end;

                      {
                      FDQueryTSOP_Budget.Append;

                      FDQueryTSOP_BudgetTSOP_BUDTIP.AsString := getTSOP_BUDTIP;
                      FDQueryTSOP_BudgetTSOP_BUDDATREF.AsDateTime := varDataReferencia;
                      FDQueryTSOP_BudgetTSOP_BUDDAT.AsDateTime := varData;
                      FDQueryTSOP_BudgetTSOP_BUDCLICOD.AsString := varCliente;
                      FDQueryTSOP_BudgetTSOP_BUDVLF.AsFloat := varForecast;


                      FDQueryTSOP_BudgetTSOP_BUDFAM.Clear;

                      FDQueryTSOP_BudgetTSOP_ORDBILSITNOM.AsString := varSite;

                      FDQueryTSOP_BudgetTSOP_USUCOD.AsInteger := Fr_Brady.TSIS_USUCOD;
                      FDQueryTSOP_BudgetTSOP_BUDDATCAD.AsDateTime := Now;

                      try
                        FDQueryTSOP_Budget.Post;
                      except
                        on E: Exception do
                        begin
                          FDQueryTSOP_Budget.Cancel;
                          ShowMessage(E.Message);
                        end;
                      end;

                      }

                    end;

                  end;

                end;

                Application.ProcessMessages;

              except

                on E: Exception do
                begin
                  ShowMessage(E.Message);
                end;

              end;



        // finally

        //    FDQueryTSOP_Budget.Close;

        //  end;

        end;

        Application.MessageBox( 'Salvo com sucesso!!!', 'S&OP', MB_ICONINFORMATION );

      finally

        FDConnection.Close;

      end;


  finally

    Mensagem( EmptyStr );

  end;

end;

procedure TfrmExibeForecast.cxButtonProcessarClick(Sender: TObject);
var
  I, X, Y, varAno, varMes : Integer;
  dxSpreadSheet: TdxSpreadSheet;
  varData, varDataReferencia : TDateTime;
  varCanal, varPlanta, varCodCliente, varConta, varGrupo, varRegiao, varMercado, varAccOwer: String;

  varMeses : Array of Extended;

begin

  Mensagem( 'Iniciando processo de importação...' );
  try

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    try

      Mensagem( 'Carregando planilha...' );
      dxSpreadSheet.LoadFromFile( cxButtonEditPath.Text );
      dxSpreadSheet.BeginUpdate;

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );

      Mensagem( 'Abrindo Conexão...' );
      FDConnection.Open;
      try
          CDSSalvaBudgetLK.Open;

          Mensagem( 'Lendo linhas da planilha...' );
          for X := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
          begin

            try

              if dxSpreadSheet.ActiveSheetAsTable.Rows[X].CellCount = 0 then
                Continue;

              if dxSpreadSheet.ActiveSheetAsTable.Rows[X].CellCount < 21 then
                Continue;

              Mensagem( 'Linha (" ' + IntToStr(X) + '/' + IntToStr(dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex) + '") "' + Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsString) + '" ...' );

              if Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString) = EmptyStr then
                Continue;

            except

              Continue;

            end;
            SetLength(varMeses, 12);


            varCanal      := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString;
            varPlanta     := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[1].AsString;
            varCodCliente := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsString;
            varConta      := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[3].AsString;
            varGrupo      := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[4].AsString;
            varRegiao     := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[5].AsString;
            varMercado    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6].AsString;
            varAccOwer    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[7].AsString;

            varMeses[0]   := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[9].AsFloat;
            varMeses[1]   := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[10].AsFloat;
            varMeses[2]   := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[11].AsFloat;
            varMeses[3]   := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[12].AsFloat;
            varMeses[4]   := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[13].AsFloat;
            varMeses[5]   := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[14].AsFloat;
            varMeses[6]   := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[15].AsFloat;
            varMeses[7]   := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[16].AsFloat;
            varMeses[8]   := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[17].AsFloat;
            varMeses[9]   := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[18].AsFloat;
            varMeses[10]  := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[19].AsFloat;
            varMeses[11]  := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[20].AsFloat;

            varAno := YearOf(Now);
            varMes := MonthOf(Now);
            if varMes < 8 then
               varAno := varAno - 1;

            varDataReferencia  := StrToDate('01/08/' + IntToStr(varAno));

            for I := 0 to 11 do
            begin
                varData := StrToDate('01/08/' + IntToStr(YearOf(Now)));
                for Y := 0 to 11 do
                begin



                    CDSSalvaBudgetLK.Append;
                    CDSSalvaBudgetLK.FieldByName('TSOP_BUDTIP').AsString       :=  'LK';
                    CDSSalvaBudgetLK.FieldByName('TSOP_BUDDATREF').AsDateTime  :=  varDataReferencia;
                    CDSSalvaBudgetLK.FieldByName('TSOP_BUDDAT').AsDateTime     :=  varData;
                    CDSSalvaBudgetLK.FieldByName('TSOP_BUDCLICOD').AsString    :=  varCodCliente;
                    CDSSalvaBudgetLK.FieldByName('TSOP_BUDVLF').AsFloat        :=  Round(varMeses[I]);
                    CDSSalvaBudgetLK.FieldByName('TSOP_ORDBILSITNOM').AsString :=  varPlanta;
                    CDSSalvaBudgetLK.FieldByName('TSOP_USUCOD').AsInteger      :=  Fr_Brady.TSIS_USUCOD;
                    CDSSalvaBudgetLK.FieldByName('TSOP_BUDDATCAD').AsDateTime  :=  Now;

                    try
                      CDSSalvaBudgetLK.Post;
                    except
                      on E: Exception do
                      begin
                        ShowMessage(E.Message);
                        CDSSalvaBudgetLK.Cancel;
                      end;
                    end;
                     varData := IncMonth(varData,1);
                end;

                varDataReferencia:= IncMonth(varDataReferencia, 1);
            end;

            for Y := 0 to 11 do
               varMeses[Y] := 0;

            try

              CDSSalvaBudgetLK.ApplyUpdates(-1);

            except

              on E: Exception do
              begin

                ShowMessage( E.Message );

              end;

            end;

            Application.ProcessMessages;

          end;


      finally

        FDConnection.Close;
        CDSSalvaBudgetLK.Close;
      end;

    finally

      FreeAndNil(dxSpreadSheet);

    end;

  finally

    Mensagem( EmptyStr );

  end;


end;

procedure TfrmExibeForecast.cxButtonRefreshClick(Sender: TObject);

begin
   cxGrid1DBBandedTableView1.ClearItems;
   if ABand <> Nil then
   begin
       ABand.Bands.Clear;
   end;
   AbrirDataset;
end;

procedure TfrmExibeForecast.cxButtonUploadClick(Sender: TObject);
var
  I, X: Integer;
  dxSpreadSheet: TdxSpreadSheet;
  varData: TDateTime;
  varDataReferencia: TDateTime;
  varMesAno: String;
  varMes, varAno: Integer;
  varLocate: Boolean;
  varSite, varFamilia, varCliente: String;
  varForecast: Extended;
  varCurrentMonth: Integer;

begin

  Mensagem( 'Iniciando processo de importação...' );
  try

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    try

      Mensagem( 'Carregando planilha...' );
      dxSpreadSheet.LoadFromFile( cxButtonEditUpload.Text );
      dxSpreadSheet.BeginUpdate;

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );

      Mensagem( 'Abrindo Conexão...' );
      FDConnection.Open;
      try

        for varCurrentMonth := 1 to 12 do
        begin

          varDataReferencia := IncMonth(System.DateUtils.StartOfTheMonth(Now),varCurrentMonth-1);

          //if Fr_Brady.SalesRep then
          //  FDQueryTSOP_Budget.MacroByName( 'WHERE1' ).AsRaw := ' AND A01.TSOP_ORDBILREPNOM = ' + QuotedStr(Fr_Brady.TSIS_USUNOM);

          FDQueryTSOP_Budget.ParamByName( 'TSOP_BUDDATREF' ).AsDateTime := varDataReferencia;
          FDQueryTSOP_Budget.ParamByName( 'TSOP_BUDTIP' ).AsString := getTSOP_BUDTIP;
          FDQueryTSOP_Budget.Open;
          try

            Mensagem( 'Lendo linhas da planilha...' );
            Application.ProcessMessages;
            Sleep(1000);
            Application.ProcessMessages;
            Mensagem( 'Total de linhas: ' + IntToStr(dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex) );
            Application.ProcessMessages;
            Sleep(5000);
            Application.ProcessMessages;

            for X := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+2 to dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
            begin

              try

               //if (dxSpreadSheet.ActiveSheetAsTable.Rows[X].CellCount = 0) or (Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString) = EmptyStr) then
                //  Continue;

                Try
                   if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0]) then
                      Continue;

                   if ((dxSpreadSheet.ActiveSheetAsTable.Rows[X].CellCount = 0) or
                       (Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString) = EmptyStr)) then
                      Continue;

                except
                   on E: Exception do
                        begin
                          ShowMessage(E.Message + ' - Eliminar linhas em branco o final do Arquivo Excel.');
                        end;
                End;

                Mensagem( 'Mês ( ' + IntToStr(varCurrentMonth) + '/12 )' + 'Linha (" ' + IntToStr(X) + '/' + IntToStr(dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex) + '") "' + Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsString) + '" ...' );

                for I := 22 to 33 do    // era 19 e 32
                begin

                  {if (cxRadioGroupOpcao.ItemIndex = 0) and (I > 30) then
                    Continue;

                  if (cxRadioGroupOpcao.ItemIndex <> 0) and (I < 21) then
                    Continue;
                   }

                  varMes := -1;
                  varMesAno := dxSpreadSheet.ActiveSheetAsTable.Rows[1].Cells[I].AsString;
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('JAN') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('JAN') then
                    varMes := 01
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('FEV') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('FEB') then
                    varMes := 02
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('MAR') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('MAR') then
                    varMes := 03
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('ABR') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('APR') then
                    varMes := 04
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('MAI') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('MAY') then
                    varMes := 05
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('JUN') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('JUN') then
                    varMes := 06
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('JUL') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('JUL') then
                    varMes := 07
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('AGO') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('AUG') then
                    varMes := 08
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('SET') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('SEP') then
                    varMes := 09
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('OUT') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('OCT') then
                    varMes := 10
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('NOV') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('NOV') then
                    varMes := 11
                  else
                  if varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('DEZ') or varMesAno.Split(['-'])[0].Trim.ToUpper.Equals('DEC') then
                    varMes := 12;

                  try
                     varAno      := StrToInt(varMesAno.Split(['-'])[1].Trim);
                  except
                       on E: Exception do
                      begin
                        ShowMessage('oi' + E.Message);
                      end;
                  end;
                  varData     := EncodeDate( varAno, varMes, 01 );
                  varForecast := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[I].AsFloat;
                  varCliente  := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsString;
                  varSite     := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[4].AsString;
                  varFamilia  := EmptyStr;

                  varLocate := False;

                  varLocate := FDQueryTSOP_Budget.Locate( 'TSOP_ORDBILSITNOM;TSOP_BUDCLICOD;TSOP_BUDDAT', VarArrayOf( [varSite,varCliente,varData] ) );

                  if varForecast < 0.00 then
                    varForecast := 0.00;

                  if varLocate then
                  begin

                    FDQueryTSOP_Budget.Edit;
                    FDQueryTSOP_BudgetTSOP_BUDVLF.AsFloat       := varForecast;
                    FDQueryTSOP_BudgetTSOP_USUCOD.AsInteger     := Fr_Brady.TSIS_USUCOD;
                    FDQueryTSOP_BudgetTSOP_BUDDATCAD.AsDateTime := Now;

                    try
                      FDQueryTSOP_Budget.Post;
                    except
                      on E: Exception do
                      begin
                        FDQueryTSOP_Budget.Cancel;
                        ShowMessage(E.Message);
                      end;
                    end;

                  end
                  else
                  begin

                    if varForecast > 0.00 then
                    begin

                      FDQueryTSOP_Budget.Append;

                      FDQueryTSOP_BudgetTSOP_BUDTIP.AsString       := getTSOP_BUDTIP;
                      FDQueryTSOP_BudgetTSOP_BUDDATREF.AsDateTime  := varDataReferencia;
                      FDQueryTSOP_BudgetTSOP_BUDDAT.AsDateTime     := varData;
                      FDQueryTSOP_BudgetTSOP_BUDCLICOD.AsString    := varCliente;
                      FDQueryTSOP_BudgetTSOP_BUDVLF.AsFloat        := varForecast;
                      FDQueryTSOP_BudgetTSOP_ORDBILSITNOM.AsString := varSite;
                      FDQueryTSOP_BudgetTSOP_USUCOD.AsInteger      := Fr_Brady.TSIS_USUCOD;
                      FDQueryTSOP_BudgetTSOP_BUDDATCAD.AsDateTime  := Now;

                      try
                        FDQueryTSOP_Budget.Post;
                      except
                        on E: Exception do
                        begin
                          FDQueryTSOP_Budget.Cancel;
                          ShowMessage(E.Message);
                        end;
                      end;

                    end;

                  end;

                end;

                Application.ProcessMessages;

              except

                on E: Exception do
                begin
                  ShowMessage(E.Message);
                end;

              end;

            end;

          finally

            FDQueryTSOP_Budget.Close;

          end;

        end;

        Application.MessageBox( 'Dados carregados com sucesso!!!', 'S&OP', MB_ICONINFORMATION );

      finally

        FDConnection.Close;

      end;

    finally

      FreeAndNil(dxSpreadSheet);

    end;

  finally

    Mensagem( EmptyStr );

  end;
end;

procedure TfrmExibeForecast.cxGrid1DBBandedTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  anomes, ano, mes : String;
begin

  ano :=  IntToStr(YearOf(now)) ;
  mes :=  LeftPad(MonthOf(now));
  anomes := ano + '-' + mes;

   if(AViewInfo.GridRecord.Values[FDQueryForecast.FieldByName('DataProc').Index ] = anomes) then
    ACanvas.Brush.Color :=  clActiveCaption;
 // else ACanvas.Brush.Color := clWhite;
end;

function TfrmExibeForecast.LeftPad(value:integer; length:integer=2; pad:char='0'): string;
begin

   result := RightStr(StringOfChar(pad,length) + IntToStr(value), length );

end;



procedure TfrmExibeForecast.cxGrid1DBBandedTableView1DblClick(Sender: TObject);
var
 iQtdeReg : Integer;
begin

 if ((MonthOf(DtInicial.Date) < MonthOf(Now)) or  (YearOf(DtInicial.Date) < YearOf(Now)) ) then
   raise Exception.Create('Não é permitido alterar período anterior.');

   Page.ActivePage       := TabLancamento;
   //txtVendedor.Text      := FDQueryForecast.Fields[0].AsString;
   txtGrupo.Text         := FDQueryForecast.Fields[1].AsString;
   //txtCodigoCliente.Text := FDQueryForecast.Fields[2].AsString;
   //txtCliente.Text       := FDQueryForecast.Fields[3].AsString;
   //txtSite.Text          := FDQueryForecast.Fields[4].AsString;
   TxtCanal.Text         := FDQueryForecast.Fields[5].AsString;
   //txtRegiao.Text        := FDQueryForecast.Fields[6].AsString;
   //txtUF.Text            := FDQueryForecast.Fields[7].AsString;

   CriarEdit(FDQueryForecast.Fields[1].AsString,FDQueryForecast.Fields[0].AsString);

  // CriarGrid;

end;


function  TfrmExibeForecast.ContaGrupo(pGrupo, pVendedor : String) : Integer;
var
 b : TBookMark;
 i : Integer;
begin
  b:= FDQueryForecast.GetBookmark;
  FDQueryForecast.DisableControls;
  Try
   FDQueryForecast.First;
   I := 0;
   while not FDQueryForecast.eof do
   begin
      if ((FDQueryForecast.Fields[1].AsString = pGrupo) and (FDQueryForecast.Fields[0].AsString = pVendedor)) then
         Inc(I);
      FDQueryForecast.Next;
   end;

  Finally
    FDQueryForecast.GotoBookmark(b);
    FDQueryForecast.FreeBookmark(b);
    FDQueryForecast.EnableControls;
  End;

  Result := I;
end;

procedure TfrmExibeForecast.AddColumn;
var
  AColumn: TcxGridDBBandedColumn;
  I, X, Y   : Integer;
  Ano, Mes, Dia: Word;

  sumItem: TcxDataSummaryItem;
begin
   cxGrid1DBBandedTableView1.BeginUpdate();
   cxGrid1DBBandedTableView1.DataController.CreateAllItems;
   cxGrid1DBBandedTableView1.OptionsView.FixedBandSeparatorWidth := 2;

   try

    ABand := cxGrid1DBBandedTableView1.Bands.Add;
    ABand.Index := 0;
    ABand.HeaderAlignmentHorz := taCenter;
    ABand.Caption := 'Informações de Clientes';
    ABand.FixedKind :=  fkLeft;

    ABand := cxGrid1DBBandedTableView1.Bands.Add;
    ABand.Index := 1;
    ABand.HeaderAlignmentHorz := taCenter;
    ABand.Caption := 'Billing';

    ABand := cxGrid1DBBandedTableView1.Bands.Add;
    ABand.Index := 2;
    ABand.HeaderAlignmentHorz := taCenter;
    ABand.Caption := 'Forecast';


    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 120;
    AColumn.Caption := 'ACC OWNER';
    AColumn.DataBinding.FieldName := FDQueryForecast.Fields[0].FieldName;
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 200;
    AColumn.Caption := 'GRUPO';
    AColumn.DataBinding.FieldName := FDQueryForecast.Fields[1].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 70;
    AColumn.Caption := 'CÓDIGO';
    AColumn.DataBinding.FieldName := FDQueryForecast.Fields[2].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 230;
    AColumn.Caption := 'NOME';
    AColumn.DataBinding.FieldName := FDQueryForecast.Fields[3].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 60;
    AColumn.Caption := 'SITE';
    AColumn.DataBinding.FieldName := FDQueryForecast.Fields[4].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 65;
    AColumn.Caption := 'CANAL';
    AColumn.DataBinding.FieldName := FDQueryForecast.Fields[5].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 65;
    AColumn.Caption := 'REGIÃO';
    AColumn.DataBinding.FieldName := FDQueryForecast.Fields[6].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 40;
    AColumn.Caption := 'UF';
    AColumn.DataBinding.FieldName := FDQueryForecast.Fields[7].FieldName;
    AColumn.Position.BandIndex := 0;


    for I := 8 to 19  do
    begin


          AColumn := cxGrid1DBBandedTableView1.CreateColumn;
          AColumn.DataBinding.FieldName := FDQueryForecast.Fields[I].FieldName;
          AColumn.Caption := FormatDateTime('mmm',varMesesArrayB[i-8]) + '-' + IntToStr(Yearof(varMesesArrayB[i-8]));
          AColumn.Width := 80;
          AColumn.Position.BandIndex := 1;
          AColumn.PropertiesClass := TcxCurrencyEditProperties;
          TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat := 'R$,0.00;(R$,0.00)';

          cxGrid1DBBandedTableView1.DataController.Summary.FooterSummaryItems.Add(AColumn, spFooter, skSum, '##.###.###,##');

    end;


    for I := 20 to 33  do
    begin

          AColumn := cxGrid1DBBandedTableView1.CreateColumn;
          AColumn.DataBinding.FieldName := FDQueryForecast.Fields[I].FieldName;
          if I >= 21 then
            AColumn.Styles.Content := cxStyleFamilia;
          if I <= 32 then
            AColumn.Caption := FormatDateTime('mmm',varMesesArrayF[i-20]) + '-' + IntToStr(Yearof(varMesesArrayF[i-20]))
          else   AColumn.Caption := 'Total';

          AColumn.PropertiesClass := TcxCurrencyEditProperties;
          TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat := 'R$,0.00;(R$,0.00)';

          AColumn.Width := 80;
          AColumn.Position.BandIndex := 2;

          cxGrid1DBBandedTableView1.DataController.Summary.FooterSummaryItems.Add(AColumn, spFooter, skSum,  '##.###.###,##');
    end;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.DataBinding.FieldName := FDQueryForecast.Fields[34].FieldName;
    AColumn.Caption := 'DATAPROC';
    AColumn.Width := 80;
    AColumn.Visible := False;
    AColumn.Position.BandIndex := 1;

    cxGrid1DBBandedTableView1.OptionsView.Footer := True;
    cxGrid1DBBandedTableView1.OptionsView.GroupFooters := gfVisibleWhenExpanded;
    cxGrid1DBBandedTableView1.OptionsView.GroupFooterMultiSummaries := True;

    cxGrid1DBBandedTableView1.DataController.DataSource := Dsforecast;
  finally
    cxGrid1DBBandedTableView1.EndUpdate;
  end;
end;


procedure TfrmExibeForecast.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
//  if Key = #13 then
  //  StringGrid1.Perform(WM_KEYDOWN, VK_TAB, 0);
end;

procedure TfrmExibeForecast.Summarize(ASummary: TcxDataSummary; AColumn: TcxGridDBBandedColumn;
  AKind: TcxSummaryKind; AFormat: string);
var
  sumGroup: TcxDataSummaryGroup;
  link: TcxGridTableSummaryGroupItemLink;
  item: TcxGridDBTableSummaryItem;
begin
  AColumn.Summary.FooterKind := AKind;
  AColumn.Summary.FooterFormat := AFormat;
  AColumn.Summary.GroupKind := AKind;
  AColumn.Summary.GroupFormat := AFormat;
  AColumn.GroupIndex := -1;
  sumGroup := ASummary.SummaryGroups.Add;
  link := sumGroup.Links.Add as TcxGridTableSummaryGroupItemLink;
  link.Column :=  AColumn;
  item := sumGroup.SummaryItems.Add as TcxGridDBTableSummaryItem;
  item.Column := AColumn;
  item.Kind := skSum;
  item.Position := spGroup;
  item.Format := AColumn.Summary.FooterFormat;
end;

function TfrmExibeForecast.TrataDataHint(varData: String): String;
var
 Mes, Ano : String;
begin
   Mes := Copy(VarData,1,3);
   Ano := Copy(VarData,5,4);

   if Mes = 'Jan' then
     Mes := '01'
   else if Mes = 'Fev' then
     Mes := '02'
   else if Mes = 'Mar' then
     Mes := '03'
   else if Mes = 'Abr' then
     Mes := '04'
   else if Mes = 'Mai' then
     Mes := '05'
   else if Mes = 'Jun' then
     Mes := '06'
   else if Mes = 'Jul' then
     Mes := '07'
   else if Mes = 'Ago' then
     Mes := '08'
   else if Mes = 'Set' then
     Mes := '09'
   else if Mes = 'Out' then
     Mes := '10'
   else if Mes = 'Nov' then
     Mes := '11'
   else if Mes = 'Dez' then
     Mes := '12';


   result := Ano + '/' + Mes + '/' + '01';

end;

procedure TfrmExibeForecast.VerDetalhe1Click(Sender: TObject);
begin
  if not FDQueryForecast.IsEmpty then
  begin
     FDQueryDet.Close;
     FDQueryDet.Params.ParamByName('TSOP_BUDDATREF').AsDateTime    := System.DateUtils.StartOfTheMonth(dtInicial.Date);
     FDQueryDet.Params.ParamByName('TSOP_BUDCLICOD').AsString      := FDQueryForecast.FieldByName('TSOP_ORDBILCLICOD').AsString;
     FDQueryDet.Params.ParamByName('TSOP_ORDBILSITNOM').AsString   := FDQueryForecast.FieldByName('TSOP_ORDBILSITNOM').AsString;
     FDQueryDet.Params.ParamByName('TSOP_BUDTIP').AsString         := getTSOP_BUDTIP;
     FDQueryDet.Open;
     Page.ActivePage := TabLancamento;
     cxGridDet.Visible := True;
  end;
end;

procedure TfrmExibeForecast.AutoAwesum(AView: TcxGridDBBandedTableView);
var
  summary: TcxDataSummary;
  summing: Boolean;
  i: Integer;
  dc: TcxGridDBDataController;
  col: TcxGridDBBandedColumn;

begin
  dc := AView.DataController;
  summing := False;
  summary := dc.Summary;
  summary.BeginUpdate;
  try
    summary.SummaryGroups.Clear;
    dc.BeginFullUpdate;
    try
      dc.GridView.ClearItems;
      dc.CreateAllItems;
      for i := 1 to AView.ColumnCount - 1 do
      begin
        col := AView.Columns[i];
        case col.DataBinding.Field.DataType of
          ftSmallint, ftInteger, ftWord, ftLargeint, ftAutoInc,
          ftLongWord, ftShortint:
            begin
              summing := true;
              Summarize(summary, col, skSum, ',0');
            end;
          ftFloat, ftBCD, ftFMTBcd, ftExtended, ftSingle:
            begin
              summing := true;
              Summarize(summary, col, skSum, ',.00');
            end;
          ftCurrency:
            begin
              summing := true;
              Summarize(summary, col, skSum, '$,0.00');
            end;
        end;
      end;
//      dc.DataModeController.GridMode := not summing;
//      AView.OptionsView.Header := summing;
      AView.OptionsView.Footer := summing;
//      AView.OptionsView.GroupFooterMultiSummaries := summing;
//      AView.OptionsView.GroupFooters := gfVisibleWhenExpanded;
    finally
      dc.EndFullUpdate;
    end;
  finally
    summary.EndUpdate;
  end;
end;

procedure TfrmExibeForecast.btnSalvarClick(Sender: TObject);
var
 i,x,c,y : Integer;
 varCurrentMonth: Integer;
 varDataReferencia : TDateTime;
 varSQL : Array of String;
 Lista : TStringList;
 varCodigo : Array of Integer;
 varTipo : String;

 iGraphCount : integer;
 pStoredProc : TFDStoredProc;
 Valor : Currency;
 bValorOK : Boolean;

begin
   if Edit <> Nil then
   begin

        for I :=  Low(Edit) to High(Edit) do
        begin
           if Edit[I].Text <> EmptyStr then
           begin
             bValorOK := TryStrToCurr(StringReplace(Trim(Edit[I].Text),'.','',[rfReplaceAll, rfIgnoreCase]) , Valor);
             if bValorOK = false then
             begin
               MessageDlg( 'Valor inválido encontrado. Favor corrigir. ', mtError, [ mbOk ], 0 );
               Edit[I].SetFocus;
               exit;
             end;
           end;
        end;

        Mensagem('Aguarde, Salvando...');
        c:= 0;
        SetLength(varSQL, 12*12*iContaGrupo );
        x := 0;
        varTipo := getTSOP_BUDTIP;
        for y := Low(LblCodigo) to High(LblCodigo) do
        begin
          sqlAux.Close;
          sqlAux.SQL.Clear;
          sqlAux.SQL.Add('Delete from TSOP_Budget_Transaction ');
          sqlAux.SQL.Add('Where TSOP_BUDCLICOD = :TSOP_BUDCLICOD and TSOP_PROCESSADO = ''0'' ');
          sqlAux.Params.ParamByName('TSOP_BUDCLICOD').AsString :=  LblCodigo[y].Caption;

          try
             sqlAux.ExecSQL;
          except
            on E: Exception do
              begin
               ShowMessage(E.Message);
             end;
          end;
        end;


        with FDScript do
        begin
            ScriptOptions.SpoolOutput   := smOnAppend;
            ScriptOptions.SpoolFileName := MyDocumentsPath   + '\Log_Forecast.txt';
            SQLScripts.Clear;
            SQLScripts.Add;

            try
              for varCurrentMonth := 1 to 12 do
              begin
                  varDataReferencia := IncMonth(System.DateUtils.StartOfTheMonth(Now),varCurrentMonth-1);

                  for I :=  Low(Edit) to High(Edit) do
                  begin
                      if I <> 0 then
                      begin
                        if I MOD 12 = 0 then
                           Inc(c);
                      end;

                       with SQLScripts[0].SQL do
                       begin
                          if (Edit[I].Text <> '') then
                          begin
                            varSQL[x] := 'Insert Into TSOP_Budget_Transaction (TSOP_BUDCLICOD, TSOP_BUDDATREF, TSOP_BUDDAT, ';
                            varSQL[x] := varSQL[x] + 'TSOP_BUDTIP, TSOP_USUCOD, TSOP_ORDBILSITNOM, TSOP_BUDVLF) Values (';
                            varSQL[x] := varSQL[x] + QuotedStr(LblCodigo[c].Caption) + ',';   //TSOP_BUDCLICOD
                            varSQL[x] := varSQL[x] + QuotedStr(FormatDateTime('yyyy-mm-dd',(varDataReferencia))) + ',';  //TSOP_BUDDATREF
                            varSQL[x] := varSQL[x] + QuotedStr(Edit[I].Hint) + ',';   //  TSOP_BUDDAT
                            varSQL[x] := varSQL[x] + QuotedStr(varTipo) + ',';   //TSOP_BUDTIP
                            varSQL[x] := varSQL[x] + QuotedStr(IntToStr(Fr_Brady.TSIS_USUCOD)) + ',';   //TSOP_USUCOD
                            varSQL[x] := varSQL[x] + QuotedStr(LblCodigo[c].Hint) + ',';

                            varSQL[x] := varSQL[x] +  StringReplace(StringReplace( Trim(Edit[I].Text),'.','',[rfReplaceAll, rfIgnoreCase]),',','.',[rfReplaceAll, rfIgnoreCase]) + ');';  //TSOP_BUDVLF
                            Add(varSQL[x]);
                          end;
                       end;
                       Inc(x);
                  end;
                  c:= 0;
              end;
            except
              on E: Exception do
                 begin
                   ShowMessage(E.Message);
                end;
            end;

            ValidateAll;

            Try
                 ExecuteAll;

                 for y := Low(LblCodigo) to High(LblCodigo) do
                 begin

                    pStoredProc := GetStoredProc( 'PSOP_ATUALIZAR_FORECAST' );
                    try
                      pStoredProc.ParamByName( '@TSOP_USUCOD' ).AsInteger   :=  Fr_Brady.TSIS_USUCOD;
                      pStoredProc.ParamByName( '@TSOP_BUDCLICOD' ).AsString :=  LblCodigo[y].Caption;

                      CallStoredProc( pStoredProc );

                      iGraphCount := pStoredProc.ParamByName( '@return_value' ).AsInteger;

                      if iGraphCount <> 2 then
                         raise Exception.Create(' Houve algum  erro ao salvar. Contacte o IT deparment ');

                    finally
                      FreeAndNil(pStoredProc);
                    end;

                 end;

                 if iGraphCount = 2 then
                    Application.MessageBox( 'Forecast salvo com sucesso!!!', 'S&OP', MB_ICONINFORMATION );

            except
              on E: Exception do
                 begin
                   ShowMessage(E.Message);
                end;
            end;

            Mensagem(EmptyStr);
        end;
  end;
end;


function TfrmExibeForecast.GetStoredProc( _sName : string ) : TFDStoredProc;
var
  pStoredProc : TFDStoredProc;
begin
  pStoredProc := TFDStoredProc.Create( Application );

  if not FDConnection.Connected then
  begin

    FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
    FDConnection.Open;

  end;

  try
    pStoredProc.Connection := FDConnection;
    pStoredProc.StoredProcName := AnsiUpperCase( _sName );
    pStoredProc.Prepare;
  except
    on E : Exception do
      begin
        MessageDlg( 'Stored procedure error: ' + #13 + #13 +
                     E.Message, mtError, [ mbOk ], 0 );
      end;
  end;

  result := pStoredProc;
end;

procedure TfrmExibeForecast.CallStoredProc( _pStoredProc : TFDStoredProc; _bOpen : boolean = false );
begin
  if _pStoredProc = nil then exit;

  if ( not _bOpen ) then
    _pStoredProc.ExecProc
  else
    _pStoredProc.Open;
end;

function TfrmExibeForecast.getTSOP_BUDTIP: string;
begin

(*

Sales Forecast
Likely
Gross Margin

*)

  Result := 'SF';
  if cxComboBoxTipo.ItemIndex = 0 then
    Result := 'SF'
  else
  if cxComboBoxTipo.ItemIndex = 1 then
    Result := 'LK'
  else
  if cxComboBoxTipo.ItemIndex = 2 then
    Result := 'GM';

end;



procedure TfrmExibeForecast.AbrirDataset;
var
   varDataReferencia: TDateTime;
   varCurrentMonth: Integer;

begin


  Mensagem( 'Abrindo conexão...' );
  try

    if not FDConnection.Connected then
    begin

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

    end;

    Mensagem( 'Obtendo dados (Forecast)...' );

    varMesesComLabel  := MontaStringMes(True,'','B',False);
    varMesesComLabel  := Copy(varMesesComLabel, 1, Length(varMesesComLabel)-1);

    varMesesComLabelB  := MontaStringMes(True,'B','B', False);
    varMesesComLabelF  := MontaStringMes(True,'F','F', False);
    //varMesesComLabelF  := Copy(varMesesComLabelF, 1, Length(varMesesComLabelF)-1);

    varMesesSemLabelB  := MontaStringMes(False,'','B',False);
    varMesesSemLabelB  := Copy(varMesesSemLabelB, 1, Length(varMesesSemLabelB)-1);
    varMesesSemLabelF  := MontaStringMes(False,'','F',False);
    varMesesSemLabelF  := Copy(varMesesSemLabelF, 1, Length(varMesesSemLabelF)-1);

    varMesesSomaLinha   := MontaStringMes(True,'F','F', True);
    varMesesSomaLinha  := '(' + Copy(varMesesSomaLinha, 1, Length(varMesesSomaLinha)-1) + ') as Total';

    FDQueryForecast.Close;
    FDQueryForecast.SQL.Clear;
    FDQueryForecast.SQL.Add('WITH BILLING ');
    FDQueryForecast.SQL.Add('AS (  ');

    FDQueryForecast.SQL.Add('SELECT  ');
    FDQueryForecast.SQL.Add('TSOP_ORDBILCLICOD,TSOP_ORDBILREPNOM,TSOP_ORDBILGRUCLINOM,TSOP_ORDBILCLINOM,TSOP_ORDBILSITNOM,TSOP_ORDBILCANNOM,TSOP_ORDBILREG,TSOP_ORDBILREGEST,    ');

    FDQueryForecast.SQL.Add(varMesesComLabel);
    FDQueryForecast.SQL.Add('FROM  ');
    FDQueryForecast.SQL.Add('( ');
    FDQueryForecast.SQL.Add('	SELECT ');
    FDQueryForecast.SQL.Add('		 CASE when B01.TSOP_ORDBILREPNOM = ''ALESSANDRA GOÇALO'' THEN '''' ELSE B01.TSOP_ORDBILGRUCLINOM END AS TSOP_ORDBILGRUCLINOM	,C01.TSOP_ORDBILCLICOD,B01.TSOP_ORDBILCANNOM ,B01.TSOP_ORDBILSITNOM ,B01.TSOP_ORDBILREPNOM,B01.TSOP_ORDBILCLINOM  ');
    FDQueryForecast.SQL.Add('		,TSOP_ORDBILTYP = CAST(''BILLING'' AS VARCHAR(255))');
    FDQueryForecast.SQL.Add('		,CONVERT(CHAR(4), C01.TSOP_ORDBILDATDOC, 100) + CONVERT(CHAR(4), C01.TSOP_ORDBILDATDOC, 120) AS MES ');
    FDQueryForecast.SQL.Add('		,TSOP_ORDBILVALLIQ = CAST(SUM(ISNULL(C01.TSOP_ORDBILVALLIQ,0.00)) AS NUMERIC(15,02)) ');
    FDQueryForecast.SQL.Add('	  ,COALESCE( C01.TSOP_ORDBILREG,	  B01.TSOP_ORDBILREG ) AS		TSOP_ORDBILREG   ');
    FDQueryForecast.SQL.Add('	  ,COALESCE( C01.TSOP_ORDBILREGEST,	  B01.TSOP_ORDBILREGEST ) AS	TSOP_ORDBILREGEST   ');

    FDQueryForecast.SQL.Add('	FROM DBO.VSOP_MONTHS A01 WITH (NOLOCK)  CROSS JOIN VSOP_ClienteBySalesRepForecast B01 WITH (NOLOCK) ');
    FDQueryForecast.SQL.Add('							LEFT  JOIN VSOP_ORDERBILLINGFULL C01 WITH (NOLOCK)  ON ( B01.TSOP_ORDBILCLICOD  = C01.TSOP_ORDBILCLICOD ');
    FDQueryForecast.SQL.Add('																	AND B01.TSOP_ORDBILCANNOM  = C01.TSOP_ORDBILCANNOM ');
    FDQueryForecast.SQL.Add('																	AND B01.TSOP_ORDBILSITNOM  = C01.TSOP_ORDBILSITNOM ');
    FDQueryForecast.SQL.Add('																	AND A01.YEARDOC            = C01.TSOP_ORDBILYEADOC ');
    FDQueryForecast.SQL.Add('																	AND A01.MONTHDOC           = C01.TSOP_ORDBILMONDOC ');
    FDQueryForecast.SQL.Add('																	AND C01.TSOP_ORDBILTIPDOC  IN (''BILLING'',''RETURN'') ) ');
    FDQueryForecast.SQL.Add('	    	      LEFT OUTER JOIN TSIS_USUARIO U ON UPPER(U.TSIS_USUNOM) = UPPER(B01.TSOP_ORDBILREPNOM) ');
    FDQueryForecast.SQL.Add('		WHERE  U.TSIS_USUATI = ''S'' ');

    FDQueryForecast.SQL.Add('	AND C01.TSOP_ORDBILDATDOC >= :MES_INI ');
    FDQueryForecast.SQL.Add('	AND C01.TSOP_ORDBILDATDOC <= :MES_FIM  ');

    FDQueryForecast.SQL.Add('    &WHERE3  ');
    FDQueryForecast.SQL.Add('    &WHERE1  ');
 //   FDQueryForecast.SQL.Add('         AND C01.TSOP_ORDBILCLICOD = ''6783971'' ');
  //  FDQueryForecast.SQL.Add(' AND B01.TSOP_ORDBILGRUCLINOM= ''NORTEL'' ');
    FDQueryForecast.SQL.Add('	 AND      Upper(COALESCE( B01.TSOP_ORDBILCANNOM, '''')) <> ''DM'' ');
    FDQueryForecast.SQL.Add('	GROUP BY ');
    FDQueryForecast.SQL.Add('	   B01.TSOP_ORDBILGRUCLINOM ');
    FDQueryForecast.SQL.Add('		,C01.TSOP_ORDBILCLICOD ');
    FDQueryForecast.SQL.Add('		,B01.TSOP_ORDBILCANNOM ');
    FDQueryForecast.SQL.Add('		,B01.TSOP_ORDBILSITNOM ');
    FDQueryForecast.SQL.Add('		,B01.TSOP_ORDBILREPNOM ');
    FDQueryForecast.SQL.Add('		,B01.TSOP_ORDBILCLINOM ');
    FDQueryForecast.SQL.Add('		,CONVERT(CHAR(4), C01.TSOP_ORDBILDATDOC, 100) + CONVERT(CHAR(4), C01.TSOP_ORDBILDATDOC, 120)  ');
    FDQueryForecast.SQL.Add('   ,C01.TSOP_ORDBILREG  ');
	  FDQueryForecast.SQL.Add('   ,C01.TSOP_ORDBILREGEST  ');
	  FDQueryForecast.SQL.Add('   ,B01.TSOP_ORDBILREG  ');
	  FDQueryForecast.SQL.Add('   ,B01.TSOP_ORDBILREGEST  ');

    FDQueryForecast.SQL.Add('   UNION   ');
    FDQueryForecast.SQL.Add(' 	SELECT DISTINCT ');
    FDQueryForecast.SQL.Add(' 		 CASE when B01.TSOP_ORDBILREPNOM = ''ALESSANDRA GOÇALO'' THEN '''' ELSE B01.TSOP_ORDBILGRUCLINOM END AS TSOP_ORDBILGRUCLINOM ,C01.TSOP_ORDBILCLICOD,B01.TSOP_ORDBILCANNOM	,B01.TSOP_ORDBILSITNOM, B01.TSOP_ORDBILREPNOM, B01.TSOP_ORDBILCLINOM   ');
    FDQueryForecast.SQL.Add(' 		,TSOP_ORDBILTYP = CAST(''BILLING'' AS VARCHAR(255)) ,''0'' AS MES,0 TSOP_ORDBILVALLIQ ,COALESCE( C01.TSOP_ORDBILREG,	  B01.TSOP_ORDBILREG ) AS		TSOP_ORDBILREG ,COALESCE( C01.TSOP_ORDBILREGEST,	  B01.TSOP_ORDBILREGEST ) AS	TSOP_ORDBILREGEST  ');
    FDQueryForecast.SQL.Add(' 	FROM  VSOP_ClienteBySalesRepForecast B01 WITH (NOLOCK)   ');
    FDQueryForecast.SQL.Add(' 							LEFT  JOIN VSOP_ORDERBILLINGFULL C01 WITH (NOLOCK)  ON ( B01.TSOP_ORDBILCLICOD  = C01.TSOP_ORDBILCLICOD  ');
    FDQueryForecast.SQL.Add(' 																	AND B01.TSOP_ORDBILCANNOM  = C01.TSOP_ORDBILCANNOM  ');
    FDQueryForecast.SQL.Add(' 																	AND B01.TSOP_ORDBILSITNOM  = C01.TSOP_ORDBILSITNOM    ');
    FDQueryForecast.SQL.Add(' 																	AND C01.TSOP_ORDBILTIPDOC  IN (''BILLING'',''RETURN'') )  ');
    FDQueryForecast.SQL.Add('  	LEFT OUTER JOIN TSIS_USUARIO U ON UPPER(U.TSIS_USUNOM) = UPPER(B01.TSOP_ORDBILREPNOM) ');
    FDQueryForecast.SQL.Add('  	WHERE  U.TSIS_USUATI = ''S'' ');
    //FDQueryForecast.SQL.Add(' 	C01.TSOP_ORDBILDATDOC >= :MES_INIANT   ');
    //FDQueryForecast.SQL.Add(' 	AND C01.TSOP_ORDBILDATDOC <= :MES_FIMANT   ');
    FDQueryForecast.SQL.Add('     AND  NOT EXISTS (SELECT TSOP_ORDBILCLICOD  FROM VSOP_ORDERBILLINGFULL D01 WITH(NOLOCK)   ');
    FDQueryForecast.SQL.Add(' 	                                         WHERE 	 D01.TSOP_ORDBILTIPDOC  IN (''BILLING'',''RETURN'')  ');
    FDQueryForecast.SQL.Add(' 													AND	D01.TSOP_ORDBILDATDOC >= :MES_INI    ');
    FDQueryForecast.SQL.Add(' 	                        AND D01.TSOP_ORDBILDATDOC <= :MES_FIM    ');
    FDQueryForecast.SQL.Add(' 	                        AND D01.TSOP_ORDBILCLICOD = C01.TSOP_ORDBILCLICOD  ');
	  FDQueryForecast.SQL.Add(' 									  			AND D01.TSOP_ORDBILCANNOM = C01.TSOP_ORDBILCANNOM  ');
    FDQueryForecast.SQL.Add('                           AND D01.TSOP_ORDBILSITNOM = C01.TSOP_ORDBILSITNOM )');
    FDQueryForecast.SQL.Add('    &WHERE3  ');
    FDQueryForecast.SQL.Add('    &WHERE1  ');
    FDQueryForecast.SQL.Add(' 	 AND      Upper(COALESCE( B01.TSOP_ORDBILCANNOM, '''')) <> ''DM''  ');


    FDQueryForecast.SQL.Add('  ) SQ ');
    FDQueryForecast.SQL.Add('  PIVOT ');
    FDQueryForecast.SQL.Add('  ( ');
    FDQueryForecast.SQL.Add('   SUM(TSOP_ORDBILVALLIQ)  ');
    FDQueryForecast.SQL.Add('  FOR Mes IN ( ' + varMesesSemLabelB + ')');
    FDQueryForecast.SQL.Add('  ) AS PIVOTTABLE  ');
    FDQueryForecast.SQL.Add(' )  ');
    FDQueryForecast.SQL.Add('SELECT B.TSOP_ORDBILREPNOM,B.TSOP_ORDBILGRUCLINOM, B.TSOP_ORDBILCLICOD,');
    FDQueryForecast.SQL.Add('     B.TSOP_ORDBILCLINOM, B.TSOP_ORDBILSITNOM, B.TSOP_ORDBILCANNOM, B.TSOP_ORDBILREG, B.TSOP_ORDBILREGEST, ');

    FDQueryForecast.SQL.Add( varMesesComLabelB );
    FDQueryForecast.SQL.Add( varMesesComLabelF );
    FDQueryForecast.SQL.Add( varMesesSomaLinha );

    FDQueryForecast.SQL.Add( ',F.DATAPROC ' );

    FDQueryForecast.SQL.Add('  FROM BILLING B ');
    FDQueryForecast.SQL.Add('  LEFT OUTER JOIN (   ');
    FDQueryForecast.SQL.Add(' SELECT  ');
    FDQueryForecast.SQL.Add(' TSOP_BUDCLICOD, ');
    FDQueryForecast.SQL.Add(' TSOP_ORDBILREPNOM, ');
    FDQueryForecast.SQL.Add(' TSOP_ORDBILGRUCLINOM,');
    FDQueryForecast.SQL.Add(' TSOP_ORDBILCLINOM, ');
    FDQueryForecast.SQL.Add(' TSOP_ORDBILCANNOM, ');
    FDQueryForecast.SQL.Add(' TSOP_ORDBILSITNOM, ');
    FDQueryForecast.SQL.Add( varMesesSemLabelF);
    FDQueryForecast.SQL.Add( ', TSOP_BUDDATCAD AS DATAPROC ');
    FDQueryForecast.SQL.Add(' FROM  ');
    FDQueryForecast.SQL.Add(' (   ');
    FDQueryForecast.SQL.Add(' SELECT  ');
    FDQueryForecast.SQL.Add('    B01.TSOP_ORDBILREPNOM ');
    FDQueryForecast.SQL.Add('   ,B01.TSOP_ORDBILCLINOM ');
    FDQueryForecast.SQL.Add('		,B01.TSOP_ORDBILGRUCLINOM  ');
    FDQueryForecast.SQL.Add('		,C01.TSOP_BUDCLICOD ');
    FDQueryForecast.SQL.Add('		,B01.TSOP_ORDBILCANNOM  ');
    FDQueryForecast.SQL.Add('		,B01.TSOP_ORDBILSITNOM  ');
    FDQueryForecast.SQL.Add('		,CONVERT(CHAR(4), C01.TSOP_BUDDAT, 100) + CONVERT(CHAR(4), C01.TSOP_BUDDAT, 120) AS MESF ');
    FDQueryForecast.SQL.Add('		,TSOP_BUDVLF = CAST( SUM(ISNULL(C01.TSOP_BUDVLF,0.00)) AS NUMERIC(15,02)) ');
    FDQueryForecast.SQL.Add('   ,DT.TSOP_BUDDATCAD ');
    FDQueryForecast.SQL.Add('		FROM    VSOP_ClienteBySalesRepForecast B01 WITH (NOLOCK)  ');
  {
    FDQueryForecast.SQL.Add('								 LEFT  JOIN DBO.VSOP_CLIENTEBYSALESREP B02 WITH (NOLOCK)  ON ( B01.TSOP_ORDBILCLICOD  = B02.TSOP_ORDBILCLICOD  ');
    FDQueryForecast.SQL.Add('            																				  AND B01.TSOP_ORDBILCANNOM     = B02.TSOP_ORDBILCANNOM   ');
    FDQueryForecast.SQL.Add('																							  AND B01.TSOP_ORDBILSITNOM     = B02.TSOP_ORDBILSITNOM )  ');
   }
    FDQueryForecast.SQL.Add('								 LEFT  JOIN TSOP_BUDGET                      C01 WITH (NOLOCK)  ON ( B01.TSOP_ORDBILSITNOM  = C01.TSOP_ORDBILSITNOM ');
    FDQueryForecast.SQL.Add('																								 AND B01.TSOP_ORDBILCLICOD  = C01.TSOP_BUDCLICOD  ');
    FDQueryForecast.SQL.Add('																				  AND C01.TSOP_BUDTIP           = :TIPO) ');
    //FDQueryForecast.SQL.Add('																				  AND C01.TSOP_BUDFAM IS NULL ) ');


    FDQueryForecast.SQL.Add('	INNER JOIN ( select x.tsop_budclicod, x.tsop_ordbilsitnom,  x.tsop_buddat, Max(x.tsop_budcod) as max_codigo    ');
    FDQueryForecast.SQL.Add('	             from tsop_budget x WITH (NOLOCK)  ');
    FDQueryForecast.SQL.Add('	             where x.tsop_budtip = :TIPO    ');
    FDQueryForecast.SQL.Add('	               and x.TSOP_BUDDATREF = :MES_INIF  ');
    //FDQueryForecast.SQL.Add('	               and x.TSOP_BUDFAM IS NULL  ');


    FDQueryForecast.SQL.Add('			 group by  x.tsop_budclicod, x.tsop_ordbilsitnom, x.tsop_buddat ) J01    ');
    FDQueryForecast.SQL.Add('	 on    (   J01.tsop_budclicod = c01.tsop_budclicod   ');
    FDQueryForecast.SQL.Add('	       and J01.tsop_ordbilsitnom = c01.tsop_ordbilsitnom    ');
    FDQueryForecast.SQL.Add('	     and J01.tsop_buddat = c01.TSOP_BUDDAT ');
    FDQueryForecast.SQL.Add('		     and J01.max_codigo = c01.tsop_budcod )     ');

    FDQueryForecast.SQL.Add('	   LEFT OUTER JOIN TSIS_USUARIO U ON UPPER(U.TSIS_USUNOM) = UPPER(B01.TSOP_ORDBILREPNOM) ');

    FDQueryForecast.SQL.Add('  LEFT OUTER JOIN ( ');
    FDQueryForecast.SQL.Add('	 SELECT  X.TSOP_ORDBILSITNOM, X.TSOP_BUDCLICOD, TSOP_USUCOD, MAX(CAST(YEAR(TSOP_BUDDATCAD) AS CHAR(4)) + ''-'' +  RIGHT(''0'' + CAST(MONTH(TSOP_BUDDATCAD) AS VARCHAR(2)),2) ) AS TSOP_BUDDATCAD   ');
    FDQueryForecast.SQL.Add('	 FROM TSOP_BUDGET_TRANSACTION X WITH (NOLOCK) ');
    FDQueryForecast.SQL.Add('	 WHERE X.TSOP_USUCOD = :TSOP_USUCOD ');
    FDQueryForecast.SQL.Add('	 GROUP BY X.TSOP_ORDBILSITNOM, X.TSOP_BUDCLICOD, X.TSOP_USUCOD ) DT ON DT.TSOP_BUDCLICOD = c01.tsop_budclicod AND DT.TSOP_ORDBILSITNOM  = C01.TSOP_ORDBILSITNOM  ');


    FDQueryForecast.SQL.Add('		WHERE U.TSIS_USUATI = ''S'' ');
    FDQueryForecast.SQL.Add(' 		and C01.TSOP_BUDDATREF = :MES_INIF   ');
    //FDQueryForecast.SQL.Add(' 		and C01.TSOP_BUDFAM IS NULL  ');

    FDQueryForecast.SQL.Add('    &WHERE4  ');
    FDQueryForecast.SQL.Add('    &WHERE2  ');

    FDQueryForecast.SQL.Add('	   AND      Upper(COALESCE( B01.TSOP_ORDBILCANNOM, '''')) <> ''DM'' ');

    FDQueryForecast.SQL.Add('		GROUP BY B01.TSOP_ORDBILREPNOM ');
    FDQueryForecast.SQL.Add('		      ,B01.TSOP_ORDBILCLINOM  ');
    FDQueryForecast.SQL.Add('			   	,B01.TSOP_ORDBILGRUCLINOM  ');
    FDQueryForecast.SQL.Add('					,B01.TSOP_ORDBILCANNOM  ');
    FDQueryForecast.SQL.Add('					,B01.TSOP_ORDBILSITNOM  ');
    FDQueryForecast.SQL.Add('					,B01.TSOP_REPACCTYP  ');
    FDQueryForecast.SQL.Add('					,C01.TSOP_BUDCLICOD  ');
    FDQueryForecast.SQL.Add('					,CONVERT(CHAR(4), C01.TSOP_BUDDAT, 100) + CONVERT(CHAR(4), C01.TSOP_BUDDAT, 120) ');
    FDQueryForecast.SQL.Add('         ,DT.TSOP_BUDDATCAD ');
    FDQueryForecast.SQL.Add('	  ) X  ');
    FDQueryForecast.SQL.Add('	   PIVOT ');
    FDQueryForecast.SQL.Add('	  (  ');
    FDQueryForecast.SQL.Add('	   SUM(TSOP_BUDVLF) ');
    FDQueryForecast.SQL.Add('  FOR MESF IN ( ' + varMesesSemLabelF + ') ');
    FDQueryForecast.SQL.Add('	  ) AS PIVOTTABLE) F ON F.TSOP_BUDCLICOD = B.TSOP_ORDBILCLICOD AND F.TSOP_ORDBILSITNOM = B.TSOP_ORDBILSITNOM AND F.TSOP_ORDBILCANNOM = B.TSOP_ORDBILCANNOM   ');

    FDQueryForecast.SQL.Add('	 ORDER BY B.TSOP_ORDBILREPNOM,B.TSOP_ORDBILGRUCLINOM,B.TSOP_ORDBILCLICOD ');


    FDQueryForecast.ParamByName( 'MES_INI' ).AsDateTime := IncMonth(IncMonth(System.DateUtils.StartOfTheMonth(dtInicial.Date), +1), -13);
    FDQueryForecast.ParamByName( 'MES_FIM' ).AsDatetime := IncMonth(IncMonth(System.DateUtils.StartOfTheMonth(dtInicial.Date), -12), 12);

    FDQueryForecast.ParamByName( 'MES_INIF' ).AsDateTime := System.DateUtils.StartOfTheMonth(dtInicial.Date);
    FDQueryForecast.ParamByName( 'TIPO' ).AsString        := getTSOP_BUDTIP;
    FDQueryForecast.ParamByName( 'TSOP_USUCOD' ).AsInteger := Fr_Brady.TSIS_USUCOD;


     //Fr_Brady.TSIS_USUNOM := 'ALESSANDRA GOÇALO';

    if cxCanal.Text <> '' then
    begin
      FDQueryForecast.MacroByName( 'WHERE1' ).AsRaw := ' AND B01.TSOP_ORDBILCANNOM = ' + QuotedStr(cxCanal.Text);
      FDQueryForecast.MacroByName( 'WHERE2' ).AsRaw := ' AND B01.TSOP_ORDBILCANNOM = ' + QuotedStr(cxCanal.Text);
    end;

    if ((Fr_Brady.SalesRep) or (chkVendedor.Checked)) then
    begin
      FDQueryForecast.MacroByName( 'WHERE3' ).AsRaw := ' AND B01.TSOP_ORDBILREPNOM  = '  + QuotedStr(Fr_Brady.TSIS_USUNOM);
      FDQueryForecast.MacroByName( 'WHERE4' ).AsRaw := ' AND B01.TSOP_ORDBILREPNOM  = '  + QuotedStr(Fr_Brady.TSIS_USUNOM);
    End;


      {
    FDQueryForecast.MacroByName( 'WHERE3' ).AsRaw := ' AND B01.TSOP_ORDBILREPNOM  = ''HUGO CASIMIRO'' ' ;
    FDQueryForecast.MacroByName( 'WHERE4' ).AsRaw := ' AND B01.TSOP_ORDBILREPNOM  = ''HUGO CASIMIRO'' ' ;
       }


  //  FDQueryForecast.SQL.SaveToFile('C:\Brady\forecast1AGO_2021.sql');
    FDQueryForecast.Open;

    AddColumn;

  finally

    Mensagem( EmptyStr );

  end;

end;

procedure TfrmExibeForecast.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Mensagem( 'Abrindo Conexão...' );
  if not FDConnection.Connected then
  begin

    FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
    FDConnection.Open;

  end;

  Mensagem( 'Gravando periodo...' );
  FDQueryTSOP_PeriodoImportacao.Close;
  FDQueryTSOP_PeriodoImportacao.Open;

  if (FDQueryTSOP_PeriodoImportacao.FieldByName('TSOP_PERIMPINI').AsInteger <> StrToIntDef(cxTextEditIni.Text,0)) or
  (FDQueryTSOP_PeriodoImportacao.FieldByName('TSOP_PERIMPFIN').AsInteger <> StrToIntdef(cxTextEditFim.Text,0)) then
  begin

    FDQueryTSOP_PeriodoImportacao.Edit;
    FDQueryTSOP_PeriodoImportacao.FieldByName('TSOP_PERIMPINI').AsString := cxTextEditIni.Text;
    FDQueryTSOP_PeriodoImportacao.FieldByName('TSOP_PERIMPFIN').AsString := cxTextEditFim.Text;
    FDQueryTSOP_PeriodoImportacao.FieldByName('TSOP_PERIMPDATCAD').AsDateTime := Now;
    FDQueryTSOP_PeriodoImportacao.FieldByName('TSOP_USUCOD').AsInteger := Fr_Brady.TSIS_USUCOD;
    FDQueryTSOP_PeriodoImportacao.Post;

  end;

  Mensagem( '' );


  frmExibeForecast := nil;
  Action := caFree;
end;

procedure TfrmExibeForecast.FormCreate(Sender: TObject);
begin
  Page.ActivePage      := TabForecast;
  dtInicial.Date       := (Now);
  cxButtonRefresh.Left := 593;
  ButExcel.Left        := 635;

  if Fr_Brady.SalesRep then
  begin
    cxComboBoxTipo.Visible   := False;
    chkVendedor.Visible      := False;
    lblTipo.Visible          := False;
    Page.Pages[2].TabVisible := False;
    Page.Pages[3].TabVisible := False;
    cxLblLiberar.Visible     := False;
    cxLabelIni.Visible       := False;
    cxLabelAte.Visible       := False;
    cxTextEditIni.Visible    := False;
    cxTextEditFim.Visible    := False;
    cxButtonRefresh.Left     := 324;
    ButExcel.Left            := 370;
  end;

  Mensagem( 'Abrindo Conexão...' );

  if not FDConnection.Connected then
  begin

    FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
    FDConnection.Open;

  end;

  Mensagem( 'Verificando periodo...' );
  FDQueryTSOP_PeriodoImportacao.Close;
  FDQueryTSOP_PeriodoImportacao.Open;

  cxTextEditIni.Text := FDQueryTSOP_PeriodoImportacao.FieldByName('TSOP_PERIMPINI').AsString;
  cxTextEditFim.Text := FDQueryTSOP_PeriodoImportacao.FieldByName('TSOP_PERIMPFIN').AsString;

  FDConnection.Close;


  AbrirDataset;


end;

procedure TfrmExibeForecast.FormKeyPress(Sender: TObject; var Key: Char);
begin

 case Key of
   #13: Perform(WM_NEXTDLGCTL, 0, 0);
   #27: Perform(WM_NEXTDLGCTL, 1, 0);
  end;

end;

{ TStringGridHack }

procedure TStringGridHack.DeleteRow(ARow: Integer);
var
  GemRow: Integer;
begin
  GemRow := Row;
  if RowCount > FixedRows + 1 then
    inherited DeleteRow(ARow)
  else
    Rows[ARow].Clear;
  if GemRow < RowCount then
    Row := GemRow;
end;

procedure TStringGridHack.InsertRow(ARow: Integer);
var
  GemRow: Integer;
begin
  GemRow := Row;
  while ARow < FixedRows do
    Inc(ARow);
  RowCount := RowCount + 1;
  MoveRow(RowCount - 1, ARow);
  Row := GemRow;

end;

end.
