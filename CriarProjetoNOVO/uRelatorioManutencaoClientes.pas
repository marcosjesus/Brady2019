unit uRelatorioManutencaoClientes;

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
  cxGridExportLink,
  MidasLib,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, dxSkinsCore,
  dxSkinOffice2013White, dxSkinscxPCPainter, dxBarBuiltInMenu, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxContainer,
  cxEdit, cxButtonEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLabel,
  Vcl.StdCtrls, cxButtons, cxPC, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData,
  FireDAC.Comp.DataSet, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGrid, dxGDIPlusClasses, Vcl.ExtCtrls,
  VclTee.TeeGDIPlus, Datasnap.DBClient, VclTee.TeEngine, VclTee.Series,
  VclTee.TeeProcs, VclTee.Chart, VclTee.DBChart, dxSkinBlack, dxSkinBlue,
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
  dxSkinWhiteprint, dxSkinXmas2008Blue, Vcl.Grids, Vcl.DBGrids,
  Datasnap.Provider, cxGridDBTableView, VCLTee.TeeDBCrossTab, SetParametro,
  EditBusca, cxCheckBox;

type
  TFr_RelatorioManutencaoClientes = class(TForm)
    FDConnection: TFDConnection;
    cxPageControlFiltro: TcxPageControl;
    cxTabSheetFiltro: TcxTabSheet;
    Label1: TLabel;
    cxButtonRefresh: TcxButton;
    cxLabel1: TcxLabel;
    cxVisao: TcxComboBox;
    ButExcel: TcxButton;
    cbPeriodo: TcxComboBox;
    Page: TcxPageControl;
    tabBaseClientes: TcxTabSheet;
    FDQueryBase: TFDQuery;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    cxGrid1: TcxGrid;
    cxGrid1Level1: TcxGridLevel;
    tabGrafico: TcxTabSheet;
    cdsGrafico: TClientDataSet;
    dsGrafico: TDataSource;
    DBGrid1: TDBGrid;
    Chart: TChart;
    FDQueryAux: TFDQuery;
    cdsGraficoDetalhe: TClientDataSet;
    dsGraficoDetalhe: TDataSource;
    FDQueryRecuperaCliente: TFDQuery;
    dsRecuperaCliente: TDataSource;
    tabDetalhe: TcxTabSheet;
    Label2: TLabel;
    SaveDialog: TSaveDialog;
    FDQueryRecuperaClienteMem: TClientDataSet;
    cxGrid1DBBandedTableView1: TcxGridDBBandedTableView;
    FDQueryResumo1: TFDQuery;
    dsResumo1: TDataSource;
    cxGrid3: TcxGrid;
    cxGrid3DBBandedTableView1: TcxGridDBBandedTableView;
    cxGrid3Level1: TcxGridLevel;
    FDQueryResumo2: TFDQuery;
    dsResumo2: TDataSource;
    FDQueryResumo3: TFDQuery;
    cxButtonPrint: TcxButton;
    tabHistorico: TcxTabSheet;
    EdtEmitente: TEditBusca;
    Label3: TLabel;
    cbMes: TcxComboBox;
    Label4: TLabel;
    chkbImposto: TcxCheckBox;
    FDQueryClienteAtivo: TFDQuery;
    cxTabSheet1: TcxTabSheet;
    cxGrid4: TcxGrid;
    cxGrid4DBBandedTableView1: TcxGridDBBandedTableView;
    cxGrid4Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    cxGrid2DBBandedTableView1: TcxGridDBBandedTableView;
    cxGrid2Level1: TcxGridLevel;
    Chart1: TChart;
    procedure cxButtonRefreshClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsGraficoDetalheAfterOpen(DataSet: TDataSet);
    procedure ButExcelClick(Sender: TObject);
    procedure PageChange(Sender: TObject);
    procedure cxButtonPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdtEmitenteExit(Sender: TObject);
    procedure chkbImpostoClick(Sender: TObject);
    procedure cxVisaoClick(Sender: TObject);
  private
    varAlias : String;
    varCampoValor : String;
    NovaData: TDateTime;
    PathExcel, PathTemp : String;
    NomedoUsuario : String;
    { Private declarations }
    dxSpreadSheet : TdxSpreadSheet;
    iPeriodo, Fim_i, Ini_i, Acum_I, Clas_I, Det_I , iPeriodoFixo: Integer;
    ABand: TcxGridBand;
    ABand1 : TcxGridBand;
    ABand2 : TcxGridBand;
    ABand3 : TcxGridBand;

    varMesesABC: Array of Currency;
    varMesesA: Array of Currency;
    varMesesB: Array of Currency;
    varMesesC: Array of Currency;
    varMesSelect : Array of String;
    varMesQtdePro : Array of String;
    varMesTotCli  : Array of String;

    varAnoAcumulado: Array of Currency;
    varAcumuladoA: Array of Currency;
    varAcumuladoB: Array of Currency;
    varAcumuladoC: Array of Currency;

    varSomaABC: Array of Integer;

    varMesesArrayB : Array of TDateTime;

    VarMesesSUM :        WideString;
    varDtInicial, varDtFinal: TDateTime;
    procedure Mensagem(pMensagem: String);

    procedure MontaStringMes(Alias : String;setColumn: Boolean; Sum : Boolean = False);

    function BuscaMes(Data: TDateTime; setColumn : Boolean; Sum : Boolean; Alias : String='nfe'): String;
    procedure AddColumnGrid1;
    procedure AddColumnGrid2;
    procedure CreateDataSet;
    procedure SetaPeriodo;

    procedure InitGrid;
    procedure InitGrid2;
    procedure AddRegras;
    procedure DropObjetos;
    procedure CopiaDataSetParaMemoria;
    procedure CopiaDataSetParaBanco;
    procedure AddColumnGrid3;
    procedure AddColumnGrid4;
    procedure Imprimir;
    function RemoveAcento(const pText: string): string;
    procedure CriarRegistroQtdeVendas;
    function GetMonth(const ADate: TDate): Word;
    function GetNameOfMonth(const ADate: TDate): UnicodeString;
    function ClientesAtivosPorPeriodo(CNPJ : String): Integer;


  protected
 
  public
    { Public declarations }
    procedure AbrirDataset;
  end;

var
  Fr_RelatorioManutencaoClientes: TFr_RelatorioManutencaoClientes;

const
  DataFileBase  = 'myBase.xml';
  DataFileMestre = 'myChartMestre.xml';
  DataFileDetalhe = 'myChartDetalhe.xml';

implementation

{$R *.dfm}

Uses
  MensFun;

{ TFr_RelatorioManutencaoClientes }

procedure TFr_RelatorioManutencaoClientes.CriarRegistroQtdeVendas;
begin
  NovaData := IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -1);


  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
  FDQueryAux.SQL.Add('Delete From tsop_recuperacliente_qtdevendas');
  FDQueryAux.SQL.Add(' Where Data = :Data  ');
  FDQueryAux.SQL.Add(' and cnpj_emitente = :cnpj_emitente');
  FDQueryAux.Params.ParamByName('Data').AsDate           := NovaData;
  FDQueryAux.Params.ParamByName('cnpj_emitente').AsString := EdtEmitente.bs_KeyValues[2];
  FDQueryAux.ExecSQL;



  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
  FDQueryAux.SQL.Add('Select data From tsop_recuperacliente_qtdevendas');
  FDQueryAux.SQL.Add(' Where data = :data');
  FDQueryAux.SQL.Add(' and cnpj_emitente = :cnpj_emitente');

  FDQueryAux.Params.ParamByName('data').AsDate := NovaData;
  FDQueryAux.Params.ParamByName('cnpj_emitente').AsString := EdtEmitente.bs_KeyValues[2];

  FDQueryAux.Open;
  if  FDQueryAux.IsEmpty then
  begin
     Try
     FDQueryAux.Close;
     FDQueryAux.SQL.Clear;
     FDQueryAux.SQL.Add('Insert into tsop_recuperacliente_qtdevendas (data,cnpj_emitente, quantidade) Values (:data, :cnpj_emitente, :quantidade)');
     FDQueryAux.Params.ParamByName('Data').AsDate := NovaData;
     FDQueryAux.Params.ParamByName('cnpj_emitente').AsString := EdtEmitente.bs_KeyValues[2];
     FDQueryAux.Params.ParamByName('quantidade').AsInteger   := ClientesAtivosPorPeriodo(EdtEmitente.bs_KeyValues[2]);
     FDQueryAux.ExecSQL;
    except
      on E: Exception do
        begin
           Mensagem( 'Insert TSOP_RECUPERACLIENTE_QTDEVENDAS ' + E.Message );
        end;
    End;
  end;
end;

function TFr_RelatorioManutencaoClientes.ClientesAtivosPorPeriodo(CNPJ : String): Integer;
var
 Contador : Integer;
begin
   Contador := 0;
   FDQueryClienteAtivo.Close;
   FDQueryClienteAtivo.SQL.Clear;
   FDQueryClienteAtivo.SQL.Add(' Select  distinct  clientes.cnpj  FROM  clientes ');
   FDQueryClienteAtivo.SQL.Add(' left outer join nfe on clientes.cnpj = nfe.cnpj_destinatario and  nfe.cnpj_emitente = :CNPJ ');
   FDQueryClienteAtivo.SQL.Add(' Where  nfe.dataemissao between :MES_INI and :MES_FIM ');
   FDQueryClienteAtivo.Params.ParamByName('CNPJ').AsString := CNPJ;
   FDQueryClienteAtivo.Params.ParamByName('MES_INI').AsDateTime := IncMonth(IncMonth(System.DateUtils.StartOfTheMonth(NovaData), +1), -(12 + 1));
   FDQueryClienteAtivo.Params.ParamByName('MES_FIM').AsDateTime := IncMonth(IncMonth(System.DateUtils.EndOfTheMonth(NovaData), -12), 12);
   FDQueryClienteAtivo.Open;
   FDQueryClienteAtivo.First;
   while not FDQueryClienteAtivo.Eof do
   begin
      inc(Contador);
      FDQueryClienteAtivo.Next;
   end;
   Result := Contador;
   FDQueryClienteAtivo.Close;

end;


procedure TFr_RelatorioManutencaoClientes.AbrirDataset;
var
 i: Integer;
begin
  SetaPeriodo;
  Mensagem('Abrindo conex�o...');
  try

    Mensagem('Obtendo dados (Base de Clientes)...');
    SetLength(varMesSelect, iPeriodo);
    SetLength(varMesesArrayB, iPeriodo);
    SetLength(varMesTotCli, iPeriodo);
    SetLength(varMesQtdePro, iPeriodo);
    VarMesesSUM := '';
    for I := 0 to High(varMesSelect) do
    begin
      varMesSelect[I]     := '';
      varMesesArrayB[I]   := 0;
    end;

    if cxVisao.ItemIndex = 0 then
      varAlias := 'nfe'
    else
      varAlias := 'nfe_itens';


    if cxVisao.ItemIndex = 0 then
    begin
      MontaStringMes(varAlias,True, False);
      MontaStringMes(varAlias,False, True);



   //   MontaStringMes('qtdepro',True, False);

    end
    else
    begin
      MontaStringMes(varAlias,True, False);
      MontaStringMes(varAlias,False, True);
    end;


    DropObjetos;

    if cxVisao.ItemIndex = 0 then
    begin
      FDQueryBase.Close;
      FDQueryBase.SQL.Clear;
      FDQueryBase.SQL.Add(' Select  ');
      FDQueryBase.SQL.Add(' clientes.cnpj, ');
      FDQueryBase.SQL.Add(' clientes.nome, ');
      FDQueryBase.SQL.Add(' clientes.estado, ');
      FDQueryBase.SQL.Add(' CASE ');
      FDQueryBase.SQL.Add('   WHEN COALESCE(clientes.estado,'''') IN (''AM'',''RR'',''AP'',''PA'',''TO'',''RO'',''AC'') THEN ''Regi�o Norte'' ');
      FDQueryBase.SQL.Add('   WHEN COALESCE(clientes.estado,'''') IN (''MA'',''PI'',''CE'',''RN'',''PE'',''PB'',''SE'',''AL'',''BA'') THEN ''Regi�o Nordeste''  ');
      FDQueryBase.SQL.Add('   WHEN COALESCE(clientes.estado,'''') IN (''MT'',''MS'',''GO'',''DF'') THEN ''Regi�o Centro-Oeste'' ');
      FDQueryBase.SQL.Add('   WHEN COALESCE(clientes.estado,'''') IN (''SP'',''RJ'',''ES'',''MG'') THEN ''Regi�o Sudeste'' ');
      FDQueryBase.SQL.Add('   WHEN COALESCE(clientes.estado,'''') IN (''PR'',''RS'',''SC'') THEN ''Regi�o Sul''  ');
      FDQueryBase.SQL.Add('	ELSE ''Outros''  ');
      FDQueryBase.SQL.Add('	END as Regiao, ');
      FDQueryBase.SQL.Add(' ''       '' as status, ');
      FDQueryBase.SQL.Add(' 0 as hits, ');
      FDQueryBase.SQL.Add(' 0 as recencia, ');
      FDQueryBase.SQL.Add(' 0 as clientenovo, ');
      FDQueryBase.SQL.Add(' 0.0 as media, ');
      FDQueryBase.SQL.Add(' '' '' as classificacao, ');
      FDQueryBase.SQL.Add(' SUM(' + varCampoValor  + ') as acumulado, ');
      for I := 0 to iPeriodo - 1 do
         FDQueryBase.SQL.Add( varMesSelect[I] );

      FDQueryBase.SQL.Add(' INTO tab_recuperacliente_' + NomedoUsuario + ' FROM  clientes ');
      FDQueryBase.SQL.Add(' left outer join nfe on clientes.cnpj = nfe.cnpj_destinatario and  nfe.cnpj_emitente = ' + QuotedStr(VarToStr(EdtEmitente.bs_KeyValues[2])));
      FDQueryBase.SQL.Add(' Where ');
      FDQueryBase.SQL.Add('  nfe.dataemissao between ' + QuotedStr(FormatDateTime('yyyy-mm-dd', IncMonth(IncMonth(System.DateUtils.StartOfTheMonth(NovaData), +1), -(iPeriodo + 1)))));
      FDQueryBase.SQL.Add(' and  ');
      FDQueryBase.SQL.Add( QuotedStr(FormatDateTime('yyyy-mm-dd', IncMonth(IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -iPeriodo), iPeriodo))));

      FDQueryBase.SQL.Add(' group by 1, 2, 3  ');
      FDQueryBase.SQL.Add(' Order by 11 DESC ');
    end
    else if cxVisao.ItemIndex = 1 then
    begin
      FDQueryBase.Close;
      FDQueryBase.SQL.Clear;
      FDQueryBase.SQL.Add(' Select distinct ');
      FDQueryBase.SQL.Add(' nfe_itens.codproduto,  ');
      FDQueryBase.SQL.Add(' nfe_itens.desc_produto, ');
      FDQueryBase.SQL.Add(' '''' as estado, ');
      FDQueryBase.SQL.Add(' '''' as regiao, ');
      FDQueryBase.SQL.Add(' ''       '' as status, ');
      FDQueryBase.SQL.Add(' 0 as hits, ');
      FDQueryBase.SQL.Add(' 0 as recencia, ');
      FDQueryBase.SQL.Add(' 0 as clientenovo, ');
      FDQueryBase.SQL.Add(' 0.0 as media, ');
      FDQueryBase.SQL.Add(' '' '' as classificacao, ');
      FDQueryBase.SQL.Add(' SUM(' + varCampoValor + ') as acumulado, ');
      for I := 0 to iPeriodo - 1 do
         FDQueryBase.SQL.Add( varMesSelect[I] );

      FDQueryBase.SQL.Add(' INTO tab_recuperacliente_' + NomedoUsuario + ' FROM  nfe_itens  ');
      FDQueryBase.SQL.Add(' inner join nfe on nfe_itens.cnpj_emitente = nfe.cnpj_emitente and nfe_itens.numnf = nfe.numnf  ');

      FDQueryBase.SQL.Add(' Where nfe.cnpj_emitente = ' + QuotedStr(VarToStr(EdtEmitente.bs_KeyValues[2])));
      FDQueryBase.SQL.Add(' and nfe.dataemissao between ' + QuotedStr(FormatDateTime('yyyy-mm-dd', IncMonth(IncMonth(System.DateUtils.StartOfTheMonth(NovaData), +1), -(iPeriodo + 1)))));
      FDQueryBase.SQL.Add(' and  ');
      FDQueryBase.SQL.Add( QuotedStr(FormatDateTime('yyyy-mm-dd', IncMonth(IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -iPeriodo), iPeriodo))));

      FDQueryBase.SQL.Add(' group by 1, 2  ');
      FDQueryBase.SQL.Add(' Order by 11 DESC ');
    end;

    FDQueryBase.SQL.SaveToFile('C:\Brady\BaseClientesAgoPG_2020.sql');

    // Criando Tabela no Banco
    FDQueryBase.ExecSQL;

    CriarRegistroQtdeVendas;

    // Recuperando Tabela Criada
    FDQueryBase.Close;
    FDQueryBase.SQL.Clear;
    FDQueryBase.sql.Add('Select * From tab_recuperacliente_' +  NomedoUsuario  + ' Order by ACUMULADO DESC' );
    FDQueryBase.Open;

    FDQueryBase.FetchAgain;
    FDQueryBase.FetchAll;

    // Copiando Tabela para Mem�ria
    CopiaDataSetParaMemoria;

    // Aplicando Regras na Mem�ria
    AddRegras;

    // Limpando Tabela do Banco
    FDQueryBase.Close;
    FDQueryBase.SQL.Clear;
    FDQueryBase.sql.Add('Truncate Table tab_recuperacliente_' + NomedoUsuario);
    FDQueryBase.ExecSQL;

    Mensagem(' Organizando Dados...');
    //Copiando da Mem�ria para Dados para o Banco
    CopiaDataSetParaBanco;

    // Recuperando Tabela Atualizada com as Regras
    FDQueryRecuperaCliente.Close;
    FDQueryRecuperaCliente.SQL.Clear;
    FDQueryRecuperaCliente.sql.Add('Select * From tab_recuperacliente_' +  NomedoUsuario + ' Order by acumulado DESC, classificacao ASC' );
    FDQueryRecuperaCliente.Open;


    //Adicionando Colunas no Grid
    AddColumnGrid1;


    FDQueryResumo1.Close;
    FDQueryResumo1.SQL.Clear;
    FDQueryResumo1.sql.Add('Select classificacao, SUM(acumulado) as acumulado,  ' + VarMesesSUM + ' from tab_recuperacliente_' + NomedoUsuario );
    FDQueryResumo1.sql.Add(' Where acumulado <> 0 ');
    FDQueryResumo1.sql.Add(' Group BY classificacao ' );
    FDQueryResumo1.sql.Add(' Order BY classificacao ' );

    FDQueryResumo1.Open;

    MontaStringMes('totcli',True, False);

    MontaStringMes('qtdepro',True, False);

    FDQueryResumo2.Close;
    FDQueryResumo2.SQL.Clear;
    FDQueryResumo2.sql.Add('Select  * from tab_recuperacliente_resumo_' + NomedoUsuario );
    FDQueryResumo2.sql.Add(' Where Acumulado = 0.00 ');

    FDQueryResumo2.sql.Add(' UNION ALL ');
    FDQueryResumo2.sql.Add(' Select ' );
    FDQueryResumo2.sql.Add(' ''GRAFICO'' as cnpj, ');
    FDQueryResumo2.sql.Add(' '''' as nome, ' );
    FDQueryResumo2.sql.Add(' '''' as estado, ' );
    FDQueryResumo2.sql.Add(' '''' as regiao, ' );
    FDQueryResumo2.sql.Add(' ''Novos Clientes'' as status, ' );
    FDQueryResumo2.sql.Add(' 0 as hits, ' );
    FDQueryResumo2.sql.Add(' 0 as recencia,  ' );
    FDQueryResumo2.sql.Add(' 0 as clientenovo, ' );
    FDQueryResumo2.sql.Add(' 0.0 as media, ' );
    FDQueryResumo2.sql.Add(' '''' as classificacao, ' );
    FDQueryResumo2.sql.Add(' 0 as acumulado, ' );

    for I := 0 to iPeriodo - 1 do
       FDQueryResumo2.SQL.Add( varMesTotCli[I] );
    FDQueryResumo2.sql.Add(' from  tsop_recuperacliente_qtdevendas totcli ');
    FDQueryResumo2.sql.Add(' where totcli.cnpj_emitente = :cnpj_emitente ');


    FDQueryResumo2.sql.Add(' UNION ALL ');
    FDQueryResumo2.sql.Add(' Select ' );
    FDQueryResumo2.sql.Add(' ''GRAFICO'' as cnpj, ');
    FDQueryResumo2.sql.Add(' '''' as nome, ' );
    FDQueryResumo2.sql.Add(' '''' as estado, ' );
    FDQueryResumo2.sql.Add(' '''' as regiao, ' );
    FDQueryResumo2.sql.Add(' ''Cli. Ativos Ult. 12 Meses'' as status, ' );
    FDQueryResumo2.sql.Add(' 0 as hits, ' );
    FDQueryResumo2.sql.Add(' 0 as recencia,  ' );
    FDQueryResumo2.sql.Add(' 0 as clientenovo, ' );
    FDQueryResumo2.sql.Add(' 0.0 as media, ' );
    FDQueryResumo2.sql.Add(' '''' as classificacao, ' );
    FDQueryResumo2.sql.Add(' 0 as acumulado, ' );

    for I := 0 to iPeriodo - 1 do
       FDQueryResumo2.SQL.Add( varMesQtdePro[I] );
    FDQueryResumo2.sql.Add(' from  tsop_recuperacliente_qtdevendas qtdepro ');
   FDQueryResumo2.sql.Add(' where qtdepro.cnpj_emitente = :cnpj_emitente ');
    //FDQueryResumo2.SQL.SaveToFile('c:\brady\tsop_recuperacliente_qtdevendas.sql');

    FDQueryResumo2.Params.ParamByName('cnpj_emitente').AsString := EdtEmitente.bs_KeyValues[2];

    FDQueryResumo2.Open;


    FDQueryResumo3.Close;
    FDQueryResumo3.SQL.Clear;
    FDQueryResumo3.sql.Add('Select  SUM(acumulado) as acumulado,  ' + VarMesesSUM + ' from tab_recuperacliente_' + NomedoUsuario);
    FDQueryResumo3.sql.Add(' Where acumulado <> 0 ');
    FDQueryResumo3.Open;

    //Adicionando Colunas no Grid
    AddColumnGrid2;

    AddColumnGrid3;

    AddColumnGrid4;


  finally

    Mensagem(EmptyStr);

  end;

end;

procedure TFr_RelatorioManutencaoClientes.AddRegras;
Var
  I, X, Y, J, Recession, TotalClientes, ContaClientesAtivos : Integer;
  Ano, Mes, Dia: Word;
  ContaA, ContaB, ContaC: Integer;
  ContaAcmA, ContaAcmB, ContaAcmC: Integer;
  SalvaValorA, SalvaValorB, SalvaValorC, GravaMediaCurrency, SomaMediaCurrency: Currency;
  mesABC: String;

begin
    SetLength(varMesesABC, iPeriodo);
    SetLength(varMesesA, iPeriodo);
    SetLength(varMesesB, iPeriodo);
    SetLength(varMesesC, iPeriodo);
    SetLength(varSomaABC, iPeriodo);

    SetLength(varAnoAcumulado, 1);
    SetLength(varAcumuladoA, 1);
    SetLength(varAcumuladoB, 1);
    SetLength(varAcumuladoC, 1);

    for I := 0 to High(varMesesABC) do
    begin
       varMesesABC[I] := 0;
       varMesesA[I]   := 0;
       varMesesB[I]   := 0;
       varMesesC[I]   := 0;
       varSomaABC[I]  := 0;
    end;

    varAnoAcumulado[0] := 0;
    varAcumuladoA[0]   := 0;
    varAcumuladoB[0]   := 0;
    varAcumuladoC[0]   := 0;

    FDQueryRecuperaClienteMem.DisableControls;
    for I := Ini_i to Fim_i do
    begin
       FDQueryRecuperaClienteMem.First;
       while not FDQueryRecuperaClienteMem.Eof do
       begin

        if (FDQueryRecuperaClienteMem.Fields[I].AsFloat > 0) then
          varMesesABC[I - Ini_i] := varMesesABC[I - Ini_i] +  FDQueryRecuperaClienteMem.Fields[I].Value;

        FDQueryRecuperaClienteMem.next;
       end;
    end;

    FDQueryRecuperaClienteMem.First;
    while not FDQueryRecuperaClienteMem.Eof do
    begin
       varAnoAcumulado[0] :=  varAnoAcumulado[0] + FDQueryRecuperaClienteMem.FieldByName('Acumulado').AsCurrency;
       FDQueryRecuperaClienteMem.next;
    end;

    for I := 0 to iPeriodo-1 do
    begin
      varMesesA[I] := (varMesesABC[I] / 100) * 80;
      varMesesB[I] := (varMesesABC[I] / 100) * 15;
      varMesesC[I] := (varMesesABC[I] / 100) * 5;
    end;

    varAcumuladoA[0] := (varAnoAcumulado[0] / 100) * 80;
    varAcumuladoB[0] := (varAnoAcumulado[0] / 100) * 15;
    varAcumuladoC[0] := (varAnoAcumulado[0] / 100) * 5;

    ContaA := 0;
    ContaB := 0;
    ContaC := 0;

    ContaAcmA := 0;
    ContaAcmB := 0;
    ContaAcmC := 0;


    SalvaValorA := 0;
    SalvaValorB := 0;
    SalvaValorC := 0;

    SetLength(varMesesABC, iPeriodo);
    SetLength(varAnoAcumulado, 1);

    for i := 0 to High(varMesesABC) do
        varMesesABC[i] := 0;

    varAnoAcumulado[0] := 0;

    FDQueryRecuperaClienteMem.First;

    Mensagem('Obtendo dados (Classificando Cliente Anual)...');

    while not FDQueryRecuperaClienteMem.Eof do
    begin
         if FDQueryRecuperaClienteMem.Fields[Acum_I].Value  <= 0 then
         begin

            FDQueryRecuperaClienteMem.Edit;
            FDQueryRecuperaClienteMem.Fields[Clas_I].Value := 'I';
            FDQueryRecuperaClienteMem.Post;

            FDQueryRecuperaClienteMem.next;
            Continue;
         end;

         varAnoAcumulado[0] :=  varAnoAcumulado[0] + FDQueryRecuperaClienteMem.Fields[Acum_I].Value ;

         if abs(varAnoAcumulado[0]) <= varAcumuladoA[0] then
         begin
             Inc(ContaAcmA);
             SalvaValorA := varAnoAcumulado[0];

             FDQueryRecuperaClienteMem.Edit;
             FDQueryRecuperaClienteMem.Fields[Clas_I].Value  := 'A';
             FDQueryRecuperaClienteMem.Post;

         end
         else if (abs(varAnoAcumulado[0] - SalvaValorA) <= varAcumuladoB[0] ) then
         begin
             Inc(ContaAcmB);
             SalvaValorB := varAnoAcumulado[0];

             FDQueryRecuperaClienteMem.Edit;
             FDQueryRecuperaClienteMem.Fields[Clas_I].Value := 'B';
             FDQueryRecuperaClienteMem.Post;

         end
         else
         begin
             Inc(ContaAcmB);

             FDQueryRecuperaClienteMem.Edit;
             FDQueryRecuperaClienteMem.Fields[Clas_I].Value  := 'C';
             FDQueryRecuperaClienteMem.Post;

         end;

         FDQueryRecuperaClienteMem.Next;
    end;



    Mensagem('Obtendo dados (Frequ�ncia e Status)...');
    FDQueryRecuperaClienteMem.First;
    while not FDQueryRecuperaClienteMem.Eof do
    begin
      Recession := 0;
      for i := Fim_i downto Ini_i do
        if FDQueryRecuperaClienteMem.Fields[I].AsFloat <= 0 Then
        begin
             Inc(Recession);
        end
        else
        begin
           if (Recession > 3) then
           begin
             FDQueryRecuperaClienteMem.Edit;
             FDQueryRecuperaClienteMem.FieldByName('status').AsString := 'ATEN��O';
             FDQueryRecuperaClienteMem.FieldByName('recencia').AsInteger := Recession;
             FDQueryRecuperaClienteMem.Post;
           end
           else
           begin
             FDQueryRecuperaClienteMem.Edit;
             FDQueryRecuperaClienteMem.FieldByName('status').AsString := 'OK';
             FDQueryRecuperaClienteMem.FieldByName('recencia').AsInteger := Recession;
             FDQueryRecuperaClienteMem.Post;
           end;

           break;
        end;

        if FDQueryRecuperaClienteMem.fieldbyname('classificacao').AsString = 'I' then
        begin
           FDQueryRecuperaClienteMem.Edit;
           FDQueryRecuperaClienteMem.FieldByName('status').AsString    := 'ATEN��O';
           FDQueryRecuperaClienteMem.FieldByName('recencia').AsInteger := Recession;
           FDQueryRecuperaClienteMem.Post;
        end;

        FDQueryRecuperaClienteMem.Next;
    end;


    Mensagem('Obtendo dados (Clientes Novos)...');
    FDQueryRecuperaClienteMem.First;
    TotalClientes := 0;
    while not FDQueryRecuperaClienteMem.Eof do
    begin
        Recession := 0;
        for i := Fim_i downto Ini_i do
        begin
          if FDQueryRecuperaClienteMem.Fields[I].AsFloat > 0 Then
          begin
             if I = Fim_i then
               Inc(Recession)
             else
               Recession := 0;
          end;
        end;

        if (Recession = 1) then
        begin
          FDQueryRecuperaClienteMem.Edit;
          FDQueryRecuperaClienteMem.FieldByName('clientenovo').AsInteger := Recession;
          FDQueryRecuperaClienteMem.Post;
          TotalClientes := TotalClientes +  Recession;
        end ;

        FDQueryRecuperaClienteMem.Next;
    end;

    if TotalClientes > 0 then
    begin
       Try
          FDQueryAux.Close;
          FDQueryAux.SQL.Clear;
          FDQueryAux.SQL.Add(' UPDATE  TSOP_RECUPERACLIENTE_QTDEVENDAS ');
          FDQueryAux.SQL.Add(' Set totalclientes = :totalclientes ');
          FDQueryAux.SQL.Add(' WHERE data = :data ');
          FDQueryAux.SQL.Add(' and cnpj_emitente = :cnpj_emitente');

          FDQueryAux.Params.ParamByName('totalclientes').AsInteger :=  TotalClientes;
          FDQueryAux.Params.ParamByName('data').AsDate             :=  NovaData;
          FDQueryAux.Params.ParamByName('cnpj_emitente').AsString := EdtEmitente.bs_KeyValues[2];
          FDQueryAux.ExecSQL;
       except
       on E: Exception do
          begin
             Mensagem( '1 ' + E.Message );
          end;
       End;
    end;


    Mensagem('Obtendo dados (Hits e M�dia)...');
    FDQueryRecuperaClienteMem.First;
    while not FDQueryRecuperaClienteMem.Eof do
    begin
        Recession := 0;
        SomaMediaCurrency := 0;
        GravaMediaCurrency := 0;
        for i := Fim_i downto Ini_i do
        begin
          if FDQueryRecuperaClienteMem.Fields[I].AsFloat > 0 Then
          begin
            Inc(Recession);
            SomaMediaCurrency := SomaMediaCurrency  + FDQueryRecuperaClienteMem.Fields[I].AsFloat;
          end;
        end;
        if Recession > 0 then
           GravaMediaCurrency :=  SomaMediaCurrency / Recession;
        FDQueryRecuperaClienteMem.Edit;
        FDQueryRecuperaClienteMem.FieldByName('hits').AsInteger   := Recession;
        FDQueryRecuperaClienteMem.FieldByName('media').ascurrency := GravaMediaCurrency;

        FDQueryRecuperaClienteMem.Post;

        FDQueryRecuperaClienteMem.Next;
    end;


    for I := Ini_i to Fim_i do
    begin
      FDQueryRecuperaClienteMem.First;
      ContaA := 0;
      ContaB := 0;
      ContaC := 0;
      SalvaValorA := 0;
      SalvaValorB := 0;
      SalvaValorC := 0;


      mesABC := BuscaMes(varMesesArrayB[I - Ini_i], False, False, varAlias);
      mesABC := Copy(mesABC, 1, Length(mesABC) - 1);

      while not FDQueryRecuperaClienteMem.Eof do
      begin
        Mensagem('Obtendo Dados Gr�fico M�s: ' + mesABC );

        if (FDQueryRecuperaClienteMem.Fields[I].AsFloat <= 0) then
        begin

            if cdsGraficoDetalhe.FindKey([FDQueryRecuperaClienteMem.Fields[0].AsString]) then
            begin
               cdsGraficoDetalhe.Edit;
               cdsGraficoDetalhe.Fields[I - Det_I].AsString := 'I';
               cdsGraficoDetalhe.Post;
            end
            else
            begin
               cdsGraficoDetalhe.Append;
               cdsGraficoDetalhe.Fields[0].AsString := FDQueryRecuperaClienteMem.Fields[0].AsString;
               cdsGraficoDetalhe.Fields[I - Det_I].AsString := 'I';
               cdsGraficoDetalhe.Post;
            end;

            FDQueryRecuperaClienteMem.next;

            Continue;
        end;

        varMesesABC[I - Ini_i] := varMesesABC[I - Ini_i] + FDQueryRecuperaClienteMem.Fields[I].Value;

        if varMesesABC[I - Ini_i] <= varMesesA[I - Ini_i] then
        begin
            Inc(ContaA);
            SalvaValorA := varMesesABC[I - Ini_i];

            if cdsGraficoDetalhe.FindKey([FDQueryRecuperaClienteMem.Fields[0].AsString]) then
            begin
               cdsGraficoDetalhe.Edit;
               cdsGraficoDetalhe.Fields[I - Det_I].AsString := 'A';
               cdsGraficoDetalhe.Post;
            end
            else
            begin
               cdsGraficoDetalhe.Append;
               cdsGraficoDetalhe.Fields[0].AsString := FDQueryRecuperaClienteMem.Fields[0].AsString;
               cdsGraficoDetalhe.Fields[I - Det_I].AsString := 'A';
               cdsGraficoDetalhe.Post;
            end;

        end
        else if ((varMesesABC[I - Ini_i] - SalvaValorA) <= varMesesB[I - Ini_i]) then
        begin
            Inc(ContaB);
            SalvaValorB := varMesesABC[I - Ini_i] - SalvaValorA;

            if cdsGraficoDetalhe.FindKey([FDQueryRecuperaClienteMem.Fields[0].AsString]) then
            begin
               cdsGraficoDetalhe.Edit;
               cdsGraficoDetalhe.Fields[I - Det_I].AsString := 'B';
               cdsGraficoDetalhe.Post;
            end
            else
            begin
               cdsGraficoDetalhe.Append;
               cdsGraficoDetalhe.Fields[0].AsString := FDQueryRecuperaClienteMem.Fields[0].AsString;
               cdsGraficoDetalhe.Fields[I - Det_I].AsString := 'B';
               cdsGraficoDetalhe.Post;
            end;

          end
          else
          begin
              Inc(ContaC);

              if cdsGraficoDetalhe.FindKey([FDQueryRecuperaClienteMem.Fields[0].AsString]) then
              begin
                 cdsGraficoDetalhe.Edit;
                 cdsGraficoDetalhe.Fields[I - Det_I].AsString := 'C';
                 cdsGraficoDetalhe.Post;
              end
              else
              begin
                 cdsGraficoDetalhe.Append;
                 cdsGraficoDetalhe.Fields[0].AsString := FDQueryRecuperaClienteMem.Fields[0].AsString;
                 cdsGraficoDetalhe.Fields[I - Det_I].AsString := 'C';
                 cdsGraficoDetalhe.Post;
              end;

          end;

          FDQueryRecuperaClienteMem.next;
        end;

        varSomaABC[I-Ini_i] := (ContaA + ContaB + ContaC);

        cdsGrafico.IndexFieldNames := 'Curva';
        if cdsGrafico.FindKey(['A']) then
        begin
          cdsGrafico.Edit;
          cdsGrafico.FieldByName(mesABC).AsInteger := ContaA;
          cdsGrafico.Post;
        end
        else
        begin
          cdsGrafico.Append;
          cdsGrafico.FieldByName('Curva').AsString := 'A';
          cdsGrafico.FieldByName(mesABC).AsInteger := ContaA;
          cdsGrafico.Post;
        end;

        if cdsGrafico.FindKey(['B']) then
        begin
          cdsGrafico.Edit;
          cdsGrafico.FieldByName(mesABC).AsInteger := ContaB;
          cdsGrafico.Post;
        end
        else
        begin
          cdsGrafico.Append;
          cdsGrafico.FieldByName('Curva').AsString := 'B';
          cdsGrafico.FieldByName(mesABC).AsInteger := ContaB;
          cdsGrafico.Post;
        end;

        if cdsGrafico.FindKey(['C']) then
        begin
          cdsGrafico.Edit;
          cdsGrafico.FieldByName(mesABC).AsInteger := ContaC;
          cdsGrafico.Post;
        end
        else
        begin
          cdsGrafico.Append;
          cdsGrafico.FieldByName('Curva').AsString := 'C';
          cdsGrafico.FieldByName(mesABC).AsInteger := ContaC;
          cdsGrafico.Post;
        end;

    end;


    if FileExists(PathTemp + '\' +  DataFileMestre) then
     DeleteFile(PathTemp + '\' +  DataFileMestre);

    if FileExists(PathTemp  + '\' +  DataFileDetalhe) then
     DeleteFile(PathTemp  + '\' +  DataFileDetalhe);

    cdsGrafico.SaveToFile(PathTemp + '\' +    DataFileMestre);
    cdsGraficoDetalhe.SaveToFile(PathTemp  + '\' +  DataFileDetalhe);


    FDQueryRecuperaClienteMem.First;
    cdsGraficoDetalhe.First;
    FDQueryRecuperaClienteMem.EnableControls;
    cdsGraficoDetalhe.EnableControls;
    try
    FDQueryAux.Close;
    FDQueryAux.SQL.Clear;
    FDQueryAux.SQL.Add(' SELECT * INTO tab_recuperacliente_resumo_' + NomedoUsuario );
    FDQueryAux.SQL.Add(' From tab_recuperacliente_' + NomedoUsuario);
    FDQueryAux.SQL.Add(' WHERE 1 <> 1 ');
    FDQueryAux.ExecSQL;
    except
      on E: Exception do
      begin
         Mensagem( '1 ' + E.Message );
       end;
     end;

    ContaClientesAtivos := 0;
   // NovaData := System.DateUtils.StartOfTheMonth(now);
   // NovaData := IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -1);



    Try
      FDQueryAux.Close;
      FDQueryAux.SQL.Clear;
      FDQueryAux.SQL.Add('Insert Into tab_recuperacliente_resumo_' + NomedoUsuario);
      FDQueryAux.SQL.Add(' ( Classificacao, Acumulado,  recencia, status, clientenovo, ');
      for I := Ini_i to Fim_i do
      begin
        mesABC := BuscaMes(varMesesArrayB[I - Ini_i], False, False, varAlias);
        if I = Fim_i then
          mesABC := Copy(mesABC, 1, Length(mesABC) - 1);
        FDQueryAux.SQL.Add(mesABC);
      end;


      FDQueryAux.SQL.Add(') Values ( '''', ');
      FDQueryAux.SQL.Add(' 0, ' );

      FDQueryAux.SQL.Add(' ''0'',''Total de Clientes'',0,');
      for I := 0 to iPeriodo-1 do
      begin
         FDQueryAux.SQL.Add( IntToStr(varSomaABC[I]));
         if i <> iPeriodo-1 then
           FDQueryAux.SQL.Add( ',');
      end;
      FDQueryAux.SQL.Add('),');


      FDQueryAux.SQL.Add(' ( '''', ');
      FDQueryAux.SQL.Add(   FormatFloat('0.##', varAnoAcumulado[0]).Replace(',','.') + ',' );

      FDQueryAux.SQL.Add(' ''0'',''.'',0,');
      for I := 0 to iPeriodo-1 do
      begin

        FDQueryAux.SQL.Add(  FormatFloat('0.##', varMesesA[I]+varMesesB[I]+varMesesC[I] ).Replace(',','.') );
        if i <> iPeriodo-1 then
           FDQueryAux.SQL.Add( ',');
      end;
      FDQueryAux.SQL.Add('),');


      FDQueryAux.SQL.Add(' ( ''A'', ');
      FDQueryAux.SQL.Add(   FormatFloat('0.##', varAcumuladoA[0]).Replace(',','.') + ',' );

      FDQueryAux.SQL.Add(' ''0'',''.'',0,');
      for I := 0 to iPeriodo-1 do
      begin

        FDQueryAux.SQL.Add(  FormatFloat('0.##', varMesesA[I]).Replace(',','.') );
        if i <> iPeriodo-1 then
           FDQueryAux.SQL.Add( ',');
      end;
      FDQueryAux.SQL.Add('),');

      FDQueryAux.SQL.Add(' ( ''B'', ');
      FDQueryAux.SQL.Add(   FormatFloat('0.##', varAcumuladoB[0]).Replace(',','.') + ',' );

      FDQueryAux.SQL.Add(' ''0'',''.'',0,');
      for I := 0 to iPeriodo-1 do
      begin

        FDQueryAux.SQL.Add( FormatFloat('0.##', varMesesB[I]).Replace(',','.') );
        if i <> iPeriodo-1 then
           FDQueryAux.SQL.Add( ',');

      end;
      FDQueryAux.SQL.Add('),');

      FDQueryAux.SQL.Add(' ( ''C'', ');
      FDQueryAux.SQL.Add(   FormatFloat('0.##', varAcumuladoC[0]).Replace(',','.') + ',' );

      FDQueryAux.SQL.Add(' ''0'',''.'',0,');
      for I := 0 to iPeriodo-1 do
      begin

        FDQueryAux.SQL.Add( FormatFloat('0.##', varMesesC[I]).Replace(',','.') );
        if i <> iPeriodo-1 then
           FDQueryAux.SQL.Add( ',');
      end;
      FDQueryAux.SQL.Add(')');

     // FDQueryAux.SQL.SaveToFile('c:\brady\insert_resumopg.sql');

      FDQueryAux.ExecSQL;
   except
     on E: Exception do
      begin

        Mensagem( '2 ' + E.Message );


      end;

    end;



end;


procedure TFr_RelatorioManutencaoClientes.AddColumnGrid1;
var
  AColumn: TcxGridDBBandedColumn;
  I : Integer;
  sumItem: TcxDataSummaryItem;
begin
  cxGrid1DBBandedTableView1.BeginUpdate();
  cxGrid1DBBandedTableView1.DataController.CreateAllItems;
  cxGrid1DBBandedTableView1.OptionsView.FixedBandSeparatorWidth := 2;


  try

    ABand := cxGrid1DBBandedTableView1.Bands.Add;
    ABand.Index := 0;
    ABand.HeaderAlignmentHorz := taCenter;
    ABand.Caption := 'Informa��es de Clientes';
    ABand.FixedKind := fkLeft;

    ABand := cxGrid1DBBandedTableView1.Bands.Add;
    ABand.Index := 1;
    ABand.HeaderAlignmentHorz := taCenter;
    ABand.Caption := 'Billing';



    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 90;
    if cxVisao.ItemIndex = 0 then
      AColumn.Caption := 'CNPJ'
    else   AColumn.Caption := 'C�DIGO';

    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[0].FieldName;
    AColumn.Position.BandIndex := 0;
    cxGrid1DBBandedTableView1.DataController.Summary.FooterSummaryItems.Add
        (AColumn, spFooter, skCount, '####');

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 150;
    if cxVisao.ItemIndex = 0 then
      AColumn.Caption := 'Cliente'
    else    AColumn.Caption := 'Produto';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[1].FieldName;
    AColumn.Position.BandIndex := 0;
    if cxVisao.ItemIndex = 0 then
    begin
      AColumn := cxGrid1DBBandedTableView1.CreateColumn;
      AColumn.Width := 40;
      AColumn.Caption := 'UF';
      AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[2].FieldName;
      AColumn.Position.BandIndex := 0;

      AColumn := cxGrid1DBBandedTableView1.CreateColumn;
      AColumn.Width := 100;
      AColumn.Caption := 'Regi�o';
      AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[3].FieldName;
      AColumn.Position.BandIndex := 0;
    end;


    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 40;
    AColumn.Caption := 'Status';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[4].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 40;
    AColumn.Caption := 'Hits';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[5].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 60;
    AColumn.Caption := 'Rec�ncia';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[6].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 80;
    AColumn.Caption := 'Clientes Novos';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[7].FieldName;
    AColumn.Position.BandIndex := 0;
     cxGrid1DBBandedTableView1.DataController.Summary.FooterSummaryItems.Add
        (AColumn, spFooter, skSum, '####');

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'M�dia';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[8].FieldName;
    AColumn.PropertiesClass := TcxCurrencyEditProperties;
    TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 70;
    AColumn.Caption := 'Classifica��o';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[9].FieldName;
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Acumulado';
    AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[10].FieldName;
    AColumn.PropertiesClass := TcxCurrencyEditProperties;
    TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';
    AColumn.Position.BandIndex := 0;
    cxGrid1DBBandedTableView1.DataController.Summary.FooterSummaryItems.Add
        (AColumn, spFooter, skSum, '##.###.###,##');

    for I := Ini_i to Fim_i do
    begin

      AColumn := cxGrid1DBBandedTableView1.CreateColumn;
      AColumn.DataBinding.FieldName := FDQueryRecuperaCliente.Fields[I].FieldName;
      AColumn.Caption := FormatDateTime('mmm', varMesesArrayB[I - Ini_i]) + '-' +
        IntToStr(Yearof(varMesesArrayB[I - Ini_i]));
      AColumn.Width := 80;
      AColumn.Position.BandIndex := 1;
      AColumn.PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';

      cxGrid1DBBandedTableView1.DataController.Summary.FooterSummaryItems.Add
        (AColumn, spFooter, skSum, '##.###.###,##');

    end;


    cxGrid1DBBandedTableView1.OptionsView.Footer := True;
    cxGrid1DBBandedTableView1.OptionsView.GroupFooters := gfVisibleWhenExpanded;
    cxGrid1DBBandedTableView1.OptionsView.GroupFooterMultiSummaries := True;

    cxGrid1DBBandedTableView1.DataController.DataSource := dsRecuperaCliente;


  finally
    cxGrid1DBBandedTableView1.EndUpdate;
  end;

end;

procedure TFr_RelatorioManutencaoClientes.AddColumnGrid2;
var
  AColumn: TcxGridDBBandedColumn;
  I : Integer;
  sumItem: TcxDataSummaryItem;
begin
  cxGrid2DBBandedTableView1.BeginUpdate();
  cxGrid2DBBandedTableView1.DataController.CreateAllItems;
  cxGrid2DBBandedTableView1.OptionsView.FixedBandSeparatorWidth := 2;


  try

    ABand1 := cxGrid2DBBandedTableView1.Bands.Add;
    ABand1.Index := 0;
    ABand1.HeaderAlignmentHorz := taCenter;
    ABand1.Caption := 'Informa��es de Clientes';
    ABand1.FixedKind := fkLeft;

    ABand1 := cxGrid2DBBandedTableView1.Bands.Add;
    ABand1.Index := 1;
    ABand1.HeaderAlignmentHorz := taCenter;
    ABand1.Caption := 'Billing';



    AColumn := cxGrid2DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Classifica��o';
    AColumn.DataBinding.FieldName := FDQueryResumo1.Fields[0].FieldName;
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid2DBBandedTableView1.CreateColumn;
    AColumn.Width := 150;
    AColumn.Caption := 'Acumulado';
    AColumn.DataBinding.FieldName := FDQueryResumo1.Fields[1].FieldName;
    AColumn.PropertiesClass := TcxCurrencyEditProperties;
    TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';
    AColumn.Position.BandIndex := 0;


    for I := Ini_i to Fim_i do
    begin

      AColumn := cxGrid2DBBandedTableView1.CreateColumn;
      AColumn.DataBinding.FieldName := FDQueryResumo1.Fields[I-9].FieldName;
      AColumn.Caption := FormatDateTime('mmm', varMesesArrayB[I - Ini_i]) + '-' +
        IntToStr(Yearof(varMesesArrayB[I - Ini_i]));
      AColumn.Width := 100;
      AColumn.Position.BandIndex := 1;
      AColumn.PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';


    end;


    cxGrid2DBBandedTableView1.OptionsView.Footer := True;
    cxGrid2DBBandedTableView1.OptionsView.GroupFooters := gfVisibleWhenExpanded;
    cxGrid2DBBandedTableView1.OptionsView.GroupFooterMultiSummaries := True;

    cxGrid2DBBandedTableView1.DataController.DataSource := dsResumo1;


  finally
    cxGrid2DBBandedTableView1.EndUpdate;
  end;


end;

procedure TFr_RelatorioManutencaoClientes.AddColumnGrid3;
var
  AColumn: TcxGridDBBandedColumn;
  I : Integer;
  sumItem: TcxDataSummaryItem;
begin
  cxGrid3DBBandedTableView1.BeginUpdate();
  cxGrid3DBBandedTableView1.DataController.CreateAllItems;
  cxGrid3DBBandedTableView1.OptionsView.FixedBandSeparatorWidth := 2;


  try

    ABand2 := cxGrid3DBBandedTableView1.Bands.Add;
    ABand2.Index := 0;
    ABand2.HeaderAlignmentHorz := taCenter;
    ABand2.Caption := 'Informa��es de Clientes';
    ABand2.FixedKind := fkLeft;

    ABand2 := cxGrid3DBBandedTableView1.Bands.Add;
    ABand2.Index := 1;
    ABand2.HeaderAlignmentHorz := taCenter;
    ABand2.Caption := 'Valores';


    AColumn := cxGrid3DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := '-';
    AColumn.DataBinding.FieldName := FDQueryResumo2.Fields[13].FieldName;
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid3DBBandedTableView1.CreateColumn;
    AColumn.Width := 150;
    AColumn.Caption := 'Informa��o';
    AColumn.DataBinding.FieldName := FDQueryResumo2.Fields[4].FieldName;
    AColumn.Position.BandIndex := 0;


    for I := Ini_i to Fim_i do
    begin

      AColumn := cxGrid3DBBandedTableView1.CreateColumn;
      AColumn.DataBinding.FieldName := FDQueryResumo2.Fields[I].FieldName;
      AColumn.Caption := FormatDateTime('mmm', varMesesArrayB[I - Ini_i]) + '-' +
        IntToStr(Yearof(varMesesArrayB[I - Ini_i]));
      AColumn.Width := 100;
      AColumn.Position.BandIndex := 1;

    end;


    cxGrid3DBBandedTableView1.OptionsView.Footer := True;
    cxGrid3DBBandedTableView1.OptionsView.GroupFooters := gfVisibleWhenExpanded;
    cxGrid3DBBandedTableView1.OptionsView.GroupFooterMultiSummaries := True;

    cxGrid3DBBandedTableView1.DataController.DataSource := dsResumo2;


  finally
    cxGrid3DBBandedTableView1.EndUpdate;
  end;


end;


procedure TFr_RelatorioManutencaoClientes.InitGrid2;
var
  col, I: Integer;
begin
  with Chart1 do
  begin
    while SeriesCount > 0 do
      Series[0].Free;

    Title.Text.Clear;
    Title.Text.Add('Base Clientes - Per�odo: ' + cbPeriodo.Text);

    Legend.Visible := True;
    View3D := True;
    I:= 0;
    FDQueryResumo2.First;

    while not FDQueryResumo2.Eof do
    begin
      If FDQueryResumo2.FieldByName('CNPJ').AsString  = 'GRAFICO' Then
      begin
        AddSeries(TBarSeries.Create(Self));
      //  (Series[I] as TBarSeries).MultiBar := mbStacked;
        Series[I].Marks.Visible := True;
        Series[I].Marks.Style := smsValue;

        Series[I].Name := 'barClientesAtivoseNovos' +  IntToStr(I);
        Series[I].LegendTitle := FDQueryResumo2.FieldByName('Status').AsString;


        for col := 1 to iPeriodo do
          if not (FDQueryResumo2.Fields[col+10].IsNull) then
           Series[I].Add(FDQueryResumo2.Fields[col+10].Value,
             FDQueryResumo2.Fields[col+10].FieldName, clTeeColor);

        Inc(I);
      end;

      FDQueryResumo2.next;
    end;

  end;
  FDQueryResumo2.First;
  FDQueryResumo2.EnableControls;
end;



procedure TFr_RelatorioManutencaoClientes.AddColumnGrid4;
var
  AColumn: TcxGridDBBandedColumn;
  I : Integer;
  sumItem: TcxDataSummaryItem;
begin
  cxGrid4DBBandedTableView1.BeginUpdate();
  cxGrid4DBBandedTableView1.DataController.CreateAllItems;
  cxGrid4DBBandedTableView1.OptionsView.FixedBandSeparatorWidth := 2;


  try

    ABand3 := cxGrid4DBBandedTableView1.Bands.Add;
    ABand3.Index := 0;
    ABand3.HeaderAlignmentHorz := taCenter;
    ABand3.Caption := 'Informa��es de Clientes';
    ABand3.FixedKind := fkLeft;

    ABand3 := cxGrid4DBBandedTableView1.Bands.Add;
    ABand3.Index := 1;
    ABand3.HeaderAlignmentHorz := taCenter;
    ABand3.Caption := 'Hist�rico ABC';

    AColumn := cxGrid4DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'C�digo';
    AColumn.DataBinding.FieldName := cdsGraficoDetalhe.Fields[0].FieldName;
    AColumn.Position.BandIndex := 0;

   {
    AColumn := cxGrid4DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Site';
    AColumn.DataBinding.FieldName := cdsGraficoDetalhe.Fields[1].FieldName;
    AColumn.Position.BandIndex := 0;
    }
    for I := Ini_i to Fim_i do
    begin

      AColumn := cxGrid4DBBandedTableView1.CreateColumn;
      AColumn.DataBinding.FieldName := cdsGraficoDetalhe.Fields[I-Det_I].FieldName;
      AColumn.Caption := FormatDateTime('mmm', varMesesArrayB[I - Ini_i]) + '-' +
        IntToStr(Yearof(varMesesArrayB[I - Ini_i]));
      AColumn.Width := 100;
      AColumn.Position.BandIndex := 1;

    end;


    cxGrid4DBBandedTableView1.OptionsView.Footer := True;
    cxGrid4DBBandedTableView1.OptionsView.GroupFooters := gfVisibleWhenExpanded;
    cxGrid4DBBandedTableView1.OptionsView.GroupFooterMultiSummaries := True;

    cxGrid4DBBandedTableView1.DataController.DataSource := dsGraficoDetalhe;


  finally
    cxGrid4DBBandedTableView1.EndUpdate;
  end;


end;


procedure TFr_RelatorioManutencaoClientes.CopiaDataSetParaBanco;
var
 i : Integer;
begin

  FDQueryRecuperaClienteMem.First;
  FDQueryBase.Close;
  FDQueryBase.SQL.Clear;
  FDQueryBase.sql.Add('Select * From tab_recuperacliente_' +  NomedoUsuario);
  FDQueryBase.Open;


  while not FDQueryRecuperaClienteMem.Eof do
  begin
    FDQueryBase.Append;
    FDQueryBase.Fields[0].Value  := FDQueryRecuperaClienteMem.Fields[0].Value;
    FDQueryBase.Fields[1].Value  := FDQueryRecuperaClienteMem.Fields[1].Value;
    FDQueryBase.Fields[2].Value  := FDQueryRecuperaClienteMem.Fields[2].Value;
    FDQueryBase.Fields[3].Value  := FDQueryRecuperaClienteMem.Fields[3].Value;
    FDQueryBase.Fields[4].Value  := FDQueryRecuperaClienteMem.Fields[4].Value;
    FDQueryBase.Fields[5].Value  := FDQueryRecuperaClienteMem.Fields[5].Value;
    FDQueryBase.Fields[6].Value  := FDQueryRecuperaClienteMem.Fields[6].Value;
    FDQueryBase.Fields[7].Value  := FDQueryRecuperaClienteMem.Fields[7].Value;
    FDQueryBase.Fields[8].Value  := FDQueryRecuperaClienteMem.Fields[8].Value;
    FDQueryBase.Fields[9].Value  := FDQueryRecuperaClienteMem.Fields[9].Value;
    FDQueryBase.Fields[10].Value := FDQueryRecuperaClienteMem.Fields[10].Value;

    for I := 11 to Fim_i do
      begin
         FDQueryBase.Fields[i].Value := FDQueryRecuperaClienteMem.Fields[i].Value;
      end;

    try
      FDQueryBase.Post;
    except

      on E: Exception do
      begin

        Mensagem( 'Post: ' + E.Message );
        FDQueryBase.Cancel;

      end;

    end;

    FDQueryRecuperaClienteMem.Next;
  end;

  FDQueryBase.ApplyUpdates(0);


end;

procedure TFr_RelatorioManutencaoClientes.CopiaDataSetParaMemoria;
var
 i : Integer;
begin
  CreateDataSet;

  FDQueryRecuperaClienteMem.Open;
 // FDQueryRecuperaClienteMem.Addindex('IndAcumuladoDesc', 'Acumulado', [IxDescending]);
 // FDQueryRecuperaClienteMem.IndexName := 'IndAcumuladoDesc';


  FDQueryBase.First;

  while not FDQueryBase.Eof do
  begin

    FDQueryRecuperaClienteMem.Append;
    FDQueryRecuperaClienteMem.Fields[0].Value := FDQueryBase.Fields[0].Value;
    FDQueryRecuperaClienteMem.Fields[1].Value := FDQueryBase.Fields[1].Value;
    FDQueryRecuperaClienteMem.Fields[2].Value := FDQueryBase.Fields[2].Value;
    FDQueryRecuperaClienteMem.Fields[3].Value := FDQueryBase.Fields[3].Value;
    FDQueryRecuperaClienteMem.Fields[4].Value := FDQueryBase.Fields[4].Value;
    FDQueryRecuperaClienteMem.Fields[5].Value := FDQueryBase.Fields[5].Value;
    FDQueryRecuperaClienteMem.Fields[6].Value := FDQueryBase.Fields[6].Value;
    FDQueryRecuperaClienteMem.Fields[7].Value := FDQueryBase.Fields[7].Value;
    FDQueryRecuperaClienteMem.Fields[8].Value := FDQueryBase.Fields[8].Value;
    FDQueryRecuperaClienteMem.Fields[9].Value := FDQueryBase.Fields[9].Value;
    FDQueryRecuperaClienteMem.Fields[10].Value := FDQueryBase.Fields[10].Value;


    for I := 11 to Fim_i do
      begin
         FDQueryRecuperaClienteMem.Fields[i].Value := FDQueryBase.Fields[i].Value;
      end;
    try

     FDQueryRecuperaClienteMem.Post;

    except
     on E : Exception do
          begin
            MessageDlg( E.Message, mtError, [ mbOk ], 0 );
          end;
    end;

    FDQueryBase.Next;
  end;

  if FileExists(PathTemp +  DataFileBase) then
    DeleteFile(PathTemp +  DataFileBase);

  FDQueryRecuperaClienteMem.SaveToFile(PathTemp + DataFileBase);



end;

procedure TFr_RelatorioManutencaoClientes.CreateDataSet;
var
  I: Integer;
  Mes: string;
begin


  if DirectoryExists(PathTemp) then
    ForceDirectories(PathTemp);

  FDQueryRecuperaClienteMem.Close;
  FDQueryRecuperaClienteMem.FileName := PathTemp + DataFileBase;
  if FileExists(FDQueryRecuperaClienteMem.FileName) then
    DeleteFile(FDQueryRecuperaClienteMem.FileName);

  with FDQueryRecuperaClienteMem.FieldDefs do
  begin
    Clear;
     Add('codcliente', ftString, 255, False);
     Add('nome', ftString, 255, False);
     Add('estado', ftString, 255, False);
     Add('regiao', ftString, 255, False);
     Add('status', ftString, 255, False);
     Add('hits', ftInteger, 0, False);
     Add('recencia', ftInteger, 0, False);
     Add('clientenovo', ftInteger, 0, False);
     Add('media', ftCurrency, 0, False);
     Add('classificacao', ftString, 7, False);
     Add('acumulado', ftCurrency, 0, False);


     for I := Low(varMesesArrayB) to High(varMesesArrayB) do
        begin
          Mes := BuscaMes(varMesesArrayB[I], False, False, varAlias);
          Mes := Copy(Mes, 1, Length(Mes) - 1);
          Add(Mes, ftCurrency, 0, False);
        end;


    FDQueryRecuperaClienteMem.CreateDataSet;
    FDQueryRecuperaClienteMem.LogChanges := False;
  end;


  cdsGrafico.Close;
  cdsGrafico.FileName := PathTemp +  DataFileMestre;
  if FileExists(cdsGrafico.FileName) then
    DeleteFile(cdsGrafico.FileName);

  with cdsGrafico.FieldDefs do
  begin
    Clear;
    Add('curva', ftString, 1);
    for I := Low(varMesesArrayB) to High(varMesesArrayB) do
    begin
      Mes := BuscaMes(varMesesArrayB[I], False, False, varAlias);
      Mes := Copy(Mes, 1, Length(Mes) - 1);
      Add(Mes, ftInteger, 0, False);
    end;
    cdsGrafico.CreateDataSet;
    cdsGrafico.LogChanges := False;
  end;

  cdsGraficoDetalhe.Close;
  cdsGraficoDetalhe.FileName := PathTemp +  DataFileDetalhe;
  if FileExists(cdsGraficoDetalhe.FileName) then
    DeleteFile(cdsGraficoDetalhe.FileName);

  with cdsGraficoDetalhe.FieldDefs do
  begin
    Clear;
    Add('codcliente', ftString, 255);

    for I := Low(varMesesArrayB) to High(varMesesArrayB) do
    begin
      Mes := BuscaMes(varMesesArrayB[I], False, False, varAlias);
      Mes := Copy(Mes, 1, Length(Mes) - 1);
      Add(Mes, ftString, 1, False);
    end;
    cdsGraficoDetalhe.CreateDataSet;
    cdsGraficoDetalhe.LogChanges := False;
  end;

  //FDQueryRecuperaClienteMem.Close;
  //cdsGrafico.Close;
  //cdsGraficoDetalhe.Close;

  cdsGrafico.Open;
  cdsGrafico.IndexFieldNames := 'curva';


  cdsGraficoDetalhe.Open;
  cdsGraficoDetalhe.IndexFieldNames := 'codcliente';


  cdsGrafico.DisableControls;
  cdsGraficoDetalhe.DisableControls;
  FDQueryRecuperaClienteMem.DisableControls;

end;


function TFr_RelatorioManutencaoClientes.BuscaMes(Data: TDateTime; setColumn : Boolean; Sum : Boolean; Alias : String='nfe'): String;
var
  Ano, Mes, Dia: Word;
  MesFiscal, MesAbrev, NewMes: String;
  strFormatDate: string;
begin
  DecodeDate(Data, Ano, Mes, Dia);
  MesAbrev := FormatDateTime('mmm', Data);

  MesAbrev := StringReplace(MesAbrev, 'dez', 'Dec',    [rfReplaceAll, rfIgnoreCase]);
  MesAbrev := StringReplace(MesAbrev, 'set', 'Sep',    [rfReplaceAll, rfIgnoreCase]);
  MesAbrev := StringReplace(MesAbrev, 'abr', 'Apr',    [rfReplaceAll, rfIgnoreCase]);
  MesAbrev := StringReplace(MesAbrev, 'ago', 'Aug',    [rfReplaceAll, rfIgnoreCase]);
  MesAbrev := StringReplace(MesAbrev, 'mai', 'May',    [rfReplaceAll, rfIgnoreCase]);
  MesAbrev := StringReplace(MesAbrev, 'out', 'Oct',    [rfReplaceAll, rfIgnoreCase]);
  MesAbrev := StringReplace(MesAbrev, 'fev', 'Feb',    [rfReplaceAll, rfIgnoreCase]);

  MesAbrev := StringReplace(MesAbrev, 'nov', 'Nov',    [rfReplaceAll, rfIgnoreCase]);
  MesAbrev := StringReplace(MesAbrev, 'jan', 'Jan',    [rfReplaceAll, rfIgnoreCase]);
  MesAbrev := StringReplace(MesAbrev, 'mar', 'Mar',    [rfReplaceAll, rfIgnoreCase]);
  MesAbrev := StringReplace(MesAbrev, 'jun', 'Jun',    [rfReplaceAll, rfIgnoreCase]);
  MesAbrev := StringReplace(MesAbrev, 'jul', 'Jul',    [rfReplaceAll, rfIgnoreCase]);

  strFormatDate := '"' + MesAbrev + ' ' + IntToStr(Ano) + '"';

  if length(IntToStr(Mes)) = 1 then
     NewMes := '0' + IntToStr(Mes)
  else NewMes := IntToStr(Mes);


  if setColumn then
  begin

    if ((Alias = 'nfe') or (Alias = 'nfe_itens')) then
    begin
      Case Mes Of
        1:
          MesFiscal :=   'SUM(CASE WHEN to_char(nfe.dataemissao, ''mm'') = ''' + NewMes  + ''' and to_char(nfe.dataemissao, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN ' +  varCampoValor + ' ELSE 0 END) AS ' + strFormatDate + ',';   // JANEIRO
        2:
           MesFiscal :=  'SUM(CASE WHEN to_char(nfe.dataemissao, ''mm'') = ''' + NewMes  + ''' and to_char(nfe.dataemissao, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN ' +  varCampoValor + ' ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS FEVEREIRO,' ;
        3:
           MesFiscal :=  'SUM(CASE WHEN to_char(nfe.dataemissao, ''mm'') = ''' + NewMes  + ''' and to_char(nfe.dataemissao, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN ' +  varCampoValor + ' ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS MAR�O,' ;
        4:
          MesFiscal :=   'SUM(CASE WHEN to_char(nfe.dataemissao, ''mm'') = ''' + NewMes  + ''' and to_char(nfe.dataemissao, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN ' +  varCampoValor + ' ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS ABRIL,' ;
        5:
           MesFiscal :=  'SUM(CASE WHEN to_char(nfe.dataemissao, ''mm'') = ''' + NewMes  + ''' and to_char(nfe.dataemissao, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN ' +  varCampoValor + ' ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS MAIO,' ;
        6:
           MesFiscal :=  'SUM(CASE WHEN to_char(nfe.dataemissao, ''mm'') = ''' + NewMes  + ''' and to_char(nfe.dataemissao, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN ' +  varCampoValor + ' ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS JUNHO,' ;
        7:
          MesFiscal :=   'SUM(CASE WHEN to_char(nfe.dataemissao, ''mm'') = ''' + NewMes  + ''' and to_char(nfe.dataemissao, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN ' +  varCampoValor + ' ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS JULHO,' ;
        8:
           MesFiscal :=  'SUM(CASE WHEN to_char(nfe.dataemissao, ''mm'') = ''' + NewMes  + ''' and to_char(nfe.dataemissao, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN ' +  varCampoValor + ' ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS AGOSTO,' ;
        9:
           MesFiscal :=  'SUM(CASE WHEN to_char(nfe.dataemissao, ''mm'') = ''' + NewMes  + ''' and to_char(nfe.dataemissao, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN ' +  varCampoValor + ' ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS SETEMBRO,' ;
        10:
           MesFiscal :=  'SUM(CASE WHEN to_char(nfe.dataemissao, ''mm'') = ''' + NewMes  + ''' and to_char(nfe.dataemissao, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN ' +  varCampoValor + ' ELSE 0 END) AS ' + strFormatDate + ','; // + ' AS OUTUBRO,' ;
        11:
           MesFiscal :=  'SUM(CASE WHEN to_char(nfe.dataemissao, ''mm'') = ''' + NewMes  + ''' and to_char(nfe.dataemissao, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN ' +  varCampoValor + ' ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS NOVEMBRO,' ;
        12:
           MesFiscal :=  'SUM(CASE WHEN to_char(nfe.dataemissao, ''mm'') = ''' + NewMes  + ''' and to_char(nfe.dataemissao, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN ' +  varCampoValor + ' ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS DEZEMBRO,' ;
       End;
    end
    else if (Alias = 'totcli') then
    begin
       Case Mes Of
        1:
          MesFiscal :=   'SUM(CASE WHEN to_char(totcli.data, ''mm'') = ''' + NewMes  + ''' and to_char(totcli.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN totalclientes ELSE 0 END) AS ' + strFormatDate + ',';   // JANEIRO
        2:
           MesFiscal :=  'SUM(CASE WHEN to_char(totcli.data, ''mm'') = ''' + NewMes  + ''' and to_char(totcli.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN totalclientes ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS FEVEREIRO,' ;
        3:
           MesFiscal :=  'SUM(CASE WHEN to_char(totcli.data, ''mm'') = ''' + NewMes  + ''' and to_char(totcli.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN totalclientes ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS MAR�O,' ;
        4:
          MesFiscal :=   'SUM(CASE WHEN to_char(totcli.data, ''mm'') = ''' + NewMes  + ''' and to_char(totcli.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN totalclientes ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS ABRIL,' ;
        5:
           MesFiscal :=  'SUM(CASE WHEN to_char(totcli.data, ''mm'') = ''' + NewMes  + ''' and to_char(totcli.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN totalclientes ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS MAIO,' ;
        6:
           MesFiscal :=  'SUM(CASE WHEN to_char(totcli.data, ''mm'') = ''' + NewMes  + ''' and to_char(totcli.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN totalclientes ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS JUNHO,' ;
        7:
          MesFiscal :=   'SUM(CASE WHEN to_char(totcli.data, ''mm'') = ''' + NewMes  + ''' and to_char(totcli.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN totalclientes ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS JULHO,' ;
        8:
           MesFiscal :=  'SUM(CASE WHEN to_char(totcli.data, ''mm'') = ''' + NewMes  + ''' and to_char(totcli.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN totalclientes ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS AGOSTO,' ;
        9:
           MesFiscal :=  'SUM(CASE WHEN to_char(totcli.data, ''mm'') = ''' + NewMes  + ''' and to_char(totcli.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN totalclientes ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS SETEMBRO,' ;
        10:
           MesFiscal :=  'SUM(CASE WHEN to_char(totcli.data, ''mm'') = ''' + NewMes  + ''' and to_char(totcli.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN totalclientes ELSE 0 END) AS ' + strFormatDate + ','; // + ' AS OUTUBRO,' ;
        11:
           MesFiscal :=  'SUM(CASE WHEN to_char(totcli.data, ''mm'') = ''' + NewMes  + ''' and to_char(totcli.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN totalclientes ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS NOVEMBRO,' ;
        12:
           MesFiscal :=  'SUM(CASE WHEN to_char(totcli.data, ''mm'') = ''' + NewMes  + ''' and to_char(totcli.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN totalclientes ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS DEZEMBRO,' ;
       End;

    end
    else if (Alias = 'qtdepro') then
    begin
       Case Mes Of
        1:
          MesFiscal :=   'SUM(CASE WHEN to_char(qtdepro.data, ''mm'') = ''' + NewMes  + ''' and to_char(qtdepro.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN quantidade ELSE 0 END) AS ' + strFormatDate + ',';   // JANEIRO
        2:
           MesFiscal :=  'SUM(CASE WHEN to_char(qtdepro.data, ''mm'') = ''' + NewMes  + ''' and to_char(qtdepro.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN quantidade ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS FEVEREIRO,' ;
        3:
           MesFiscal :=  'SUM(CASE WHEN to_char(qtdepro.data, ''mm'') = ''' + NewMes  + ''' and to_char(qtdepro.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN quantidade ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS MAR�O,' ;
        4:
          MesFiscal :=   'SUM(CASE WHEN to_char(qtdepro.data, ''mm'') = ''' + NewMes  + ''' and to_char(qtdepro.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN quantidade ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS ABRIL,' ;
        5:
           MesFiscal :=  'SUM(CASE WHEN to_char(qtdepro.data, ''mm'') = ''' + NewMes  + ''' and to_char(qtdepro.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN quantidade ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS MAIO,' ;
        6:
           MesFiscal :=  'SUM(CASE WHEN to_char(qtdepro.data, ''mm'') = ''' + NewMes  + ''' and to_char(qtdepro.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN quantidade ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS JUNHO,' ;
        7:
          MesFiscal :=   'SUM(CASE WHEN to_char(qtdepro.data, ''mm'') = ''' + NewMes  + ''' and to_char(qtdepro.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN quantidade ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS JULHO,' ;
        8:
           MesFiscal :=  'SUM(CASE WHEN to_char(qtdepro.data, ''mm'') = ''' + NewMes  + ''' and to_char(qtdepro.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN quantidade ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS AGOSTO,' ;
        9:
           MesFiscal :=  'SUM(CASE WHEN to_char(qtdepro.data, ''mm'') = ''' + NewMes  + ''' and to_char(qtdepro.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN quantidade ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS SETEMBRO,' ;
        10:
           MesFiscal :=  'SUM(CASE WHEN to_char(qtdepro.data, ''mm'') = ''' + NewMes  + ''' and to_char(qtdepro.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN quantidade ELSE 0 END) AS ' + strFormatDate + ','; // + ' AS OUTUBRO,' ;
        11:
           MesFiscal :=  'SUM(CASE WHEN to_char(qtdepro.data, ''mm'') = ''' + NewMes  + ''' and to_char(qtdepro.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN quantidade ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS NOVEMBRO,' ;
        12:
           MesFiscal :=  'SUM(CASE WHEN to_char(qtdepro.data, ''mm'') = ''' + NewMes  + ''' and to_char(qtdepro.data, ''yyyy'') = ''' + IntToStr(Ano) + ''' THEN quantidade ELSE 0 END) AS ' + strFormatDate + ',';  // + ' AS DEZEMBRO,' ;
       End;

    end;
  end
  else
  begin
    Case Mes Of
      1:
        MesFiscal := strFormatDate + ',';
      2:
        MesFiscal := strFormatDate + ',';
      3:
        MesFiscal := strFormatDate + ',';
      4:
        MesFiscal := strFormatDate + ',';
      5:
        MesFiscal := strFormatDate + ',';
      6:
        MesFiscal := strFormatDate + ',';
      7:
        MesFiscal := strFormatDate + ',';
      8:
        MesFiscal := strFormatDate + ',';
      9:
        MesFiscal := strFormatDate + ',';
      10:
        MesFiscal := strFormatDate + ',';
      11:
        MesFiscal := strFormatDate + ',';
      12:
        MesFiscal := strFormatDate + ',';
    End;
  end;
  {
  // if (Alias <> '') then
  // MesFiscal := Alias + '.' + MesFiscal;
  if SomarLinha then
  begin
    MesFiscal := Copy(MesFiscal, 1, Length(MesFiscal) - 1);

    Case Mes Of
      1:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      2:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      3:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      4:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      5:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      6:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      7:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      8:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      9:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      10:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      11:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
      12:
        MesFiscal := 'IsNull(' + Alias + '.' + MesFiscal + ',0) +';
    End;
  end
  else
  begin
    if (Alias <> '') and (bLabel) then
    begin
      MesFiscal := Copy(MesFiscal, 1, Length(MesFiscal) - 1);

      if ComAS then
      begin
        Case Mes Of
          1:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Jan_' +
              IntToStr(Ano) + ',';
          2:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Fev_' +
              IntToStr(Ano) + ',';
          3:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Mar_' +
              IntToStr(Ano) + ',';
          4:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Abr_' +
              IntToStr(Ano) + ',';
          5:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Mai_' +
              IntToStr(Ano) + ',';
          6:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Jun_' +
              IntToStr(Ano) + ',';
          7:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Jul_' +
              IntToStr(Ano) + ',';
          8:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Ago_' +
              IntToStr(Ano) + ',';
          9:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Set_' +
              IntToStr(Ano) + ',';
          10:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Out_' +
              IntToStr(Ano) + ',';
          11:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Nov_' +
              IntToStr(Ano) + ',';
          12:
            MesFiscal := Alias + '.' + MesFiscal + ' AS Dez_' +
              IntToStr(Ano) + ',';
        End;
      end
      else
      begin
        Case Mes Of
          1:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          2:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          3:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          4:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          5:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          6:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          7:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          8:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          9:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          10:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          11:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
          12:
            MesFiscal := '(' + Alias + '.' + MesFiscal + '),';
        End;
      end;

    end;
  end;

   }

  if Sum then
  begin
       Case Mes Of
      1:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS JANEIRO,' ;
      2:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS FEVEREIRO,' ;
      3:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS MAR�O,' ;
      4:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS ABRIL,' ;
      5:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS MAIO,' ;
      6:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS JUNHO,' ;
      7:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS JULHO,' ;
      8:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS AGOSTO,' ;
      9:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS SETEMBRO,' ;
      10:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS OUTUBRO,' ;
      11:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS NOVEMBRO,' ;
      12:
        MesFiscal := 'SUM(' + strFormatDate + '),'; // + ' AS DEZEMBRO,' ;
    End;

  end;



  Result := MesFiscal;

end;

procedure TFr_RelatorioManutencaoClientes.ButExcelClick(Sender: TObject);
begin

 if Page.ActivePageIndex = 0 then
  begin
     if ((EdtEmitente.Text = '') or (EdtEmitente.bs_KeyValue = 0)) then
     begin
      Mens_MensInf('Selecione o Fornecedor.') ;
      exit;
     end;
     if FDQueryRecuperaCliente.IsEmpty then
     begin
        Mens_MensInf('N�o h� informa��es para exportar ao exportar ao Excel ') ;
       exit;
     end;

     Imprimir;
  end;
end;

procedure TFr_RelatorioManutencaoClientes.Imprimir;

var
  I, X, J, Y: Integer;
  varCor1,varCor2: TColor;
  varSubtotal: array[11..34] of string;
  varNomeArquivo : String;
begin

   Screen.Cursor := crHourGlass;
   if cxVisao.ItemIndex = 0 then
   begin
     DeleteFile(PWideChar(PathExcel+'BaseClientes.xlsx'));
     CopyFile( PWideChar(ExtractFilePath(Application.ExeName)+ '\BaseClientes.xlsx'), PWideChar(PathExcel+'BaseClientes.xlsx'), True );
   end
   else
   begin
     DeleteFile(PWideChar(PathExcel+'BaseProdutos.xlsx'));
     CopyFile( PWideChar(ExtractFilePath(Application.ExeName)+ '\BaseProdutos.xlsx'), PWideChar(PathExcel+'BaseProdutos.xlsx'), True );
   end;


   varNomeArquivo := DateTimeToStr(now);

   varNomeArquivo := StringReplace(varNomeArquivo,'/','',[rfReplaceAll, rfIgnoreCase]);
   varNomeArquivo := StringReplace(varNomeArquivo,':','',[rfReplaceAll, rfIgnoreCase]);
   varNomeArquivo := StringReplace(varNomeArquivo,'.','',[rfReplaceAll, rfIgnoreCase]);
   varNomeArquivo := StringReplace(varNomeArquivo,' ','',[rfReplaceAll, rfIgnoreCase]);
   varNomeArquivo := varNomeArquivo + '.xlsx';

   Try
       Mensagem( 'Criando Planilha...' );
       dxSpreadSheet := TdxSpreadSheet.Create(nil);
       try
           if cxVisao.ItemIndex = 0 then
            Mensagem( 'Exportando Base de Clientes...' )
           else   Mensagem( 'Exportando Base de Produtos...' );
           if cxVisao.ItemIndex = 0 then
             dxSpreadSheet.LoadFromFile( PathExcel+'BaseClientes.xlsx' )
           else   dxSpreadSheet.LoadFromFile( PathExcel+'BaseProdutos.xlsx' );
           dxSpreadSheet.BeginUpdate;

           dxSpreadSheet.Sheets[0].Active := True;

           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(0,1) do
           begin
                Style.Font.Style := Style.Font.Style + [fsBold];
                Style.Font.Name := 'Tahoma';
                Style.Font.Size := 14;
                if cxVisao.ItemIndex = 0 then
                 AsString := 'Base de Clientes - Per�odo: ' + cbPeriodo.Text
                else   AsString := 'Base de Produtos - Per�odo: ' + cbPeriodo.Text;
           end;


           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(1,1) do
           begin
                Style.Font.Style := Style.Font.Style + [fsBold];
                Style.Font.Name := 'Tahoma';
                Style.Font.Size := 12;
                AsString := 'Data: ' + DateToStr(date);
           end;


           for I := Ini_i to Fim_i do
           begin
              if cxVisao.ItemIndex = 0 then
              begin

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(3,I) do
                begin
                  Style.Font.Style := Style.Font.Style + [fsBold];
                  Style.Brush.BackgroundColor := RGB(219,219,219);
                  Style.Font.Name := 'Tahoma';
                  Style.Font.Size := 8;
                  Style.Font.Color := RGB(0,0,0);
                  AsString := FormatDateTime('mmm', varMesesArrayB[I - Ini_i]) + '-' + IntToStr(Yearof(varMesesArrayB[I - Ini_i]));

                end;
              end
              else
              begin
                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(3,I-2) do
                begin
                  Style.Font.Style := Style.Font.Style + [fsBold];
                  Style.Brush.BackgroundColor := RGB(219,219,219);
                  Style.Font.Name := 'Tahoma';
                  Style.Font.Size := 8;
                  Style.Font.Color := RGB(0,0,0);
                  AsString := FormatDateTime('mmm', varMesesArrayB[I - Ini_i]) + '-' + IntToStr(Yearof(varMesesArrayB[I - Ini_i]));

                end;
              end;

           end;

           FDQueryRecuperaCliente.First;
           varCor1 := RGB(216,234,204);
           varCor2 := RGB(255,255,225);

           X := 4;
           while not FDQueryRecuperaCliente.eof do
           begin



               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryRecuperaCliente.Fields[0].AsString;  //Codigo

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant :=  FDQueryRecuperaCliente.Fields[1].AsString;  //Cliente

               end;

               if cxVisao.ItemIndex = 0 then
               begin
                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,2) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     AsVariant :=  FDQueryRecuperaCliente.Fields[2].AsString;   //UF

                 end;

                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,3) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     AsVariant :=  FDQueryRecuperaCliente.Fields[3].AsString; //Regi�o

                 end;


                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,4) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     AsVariant := FDQueryRecuperaCliente.Fields[4].AsString;  //Status

                 end;

                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,5) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     AsVariant :=  FDQueryRecuperaCliente.Fields[5].AsString; //Hits

                 end;

                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,6) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     AsVariant :=  FDQueryRecuperaCliente.Fields[6].AsString;  //Recencia

                 end;

                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,7) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     AsVariant := FDQueryRecuperaCliente.Fields[7].AsString; //Clientes Novos

                 end;

                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,8) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     Style.DataFormat.FormatCode := '#,##0.00';
                     AsVariant := FDQueryRecuperaCliente.Fields[8].AsFloat; //Classificacao
                 end;

                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,9) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     AsVariant := FDQueryRecuperaCliente.Fields[9].AsString; //Media

                 end;

                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,10) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     AsVariant := FDQueryRecuperaCliente.Fields[10].AsString; //Acumulado
                     Style.DataFormat.FormatCode := '#,##0.00';
                 end;

               end
               else
               begin

                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,2) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     AsVariant := FDQueryRecuperaCliente.Fields[4].AsString;  //Status

                 end;

                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,3) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     AsVariant :=  FDQueryRecuperaCliente.Fields[5].AsString; //Hits

                 end;

                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,4) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     AsVariant :=  FDQueryRecuperaCliente.Fields[6].AsString;  //Recencia

                 end;

                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,5) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     AsVariant := FDQueryRecuperaCliente.Fields[7].AsString; //Clientes Novos

                 end;

                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,6) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     Style.DataFormat.FormatCode := '#,##0.00';
                     AsVariant := FDQueryRecuperaCliente.Fields[8].AsFloat; //Classificacao
                 end;

                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,7) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     AsVariant := FDQueryRecuperaCliente.Fields[9].AsString; //Media

                 end;

                 with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,8) do
                 begin
                     Style.Brush.BackgroundColor := varCor1;
                     AsVariant := FDQueryRecuperaCliente.Fields[10].AsString; //Acumulado
                     Style.DataFormat.FormatCode := '#,##0.00';
                 end;



               end;

               for J := Ini_i to Fim_i do
               begin
                 if cxVisao.ItemIndex = 0 then
                 begin
                   with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,J) do
                   begin
                       Style.Brush.BackgroundColor := varCor1;
                       Style.DataFormat.FormatCode := '#,##0.00';
                       AsVariant := FDQueryRecuperaCliente.Fields[J].AsFloat;
                   end;
                 end
                 else
                 begin
                  with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,J-2) do
                   begin
                       Style.Brush.BackgroundColor := varCor1;
                       Style.DataFormat.FormatCode := '#,##0.00';
                       AsVariant := FDQueryRecuperaCliente.Fields[J].AsFloat;
                   end;
                 end;

               end;

               if Odd(X) then
                varCor1 := RGB(255,255,225)
               else
                varCor1 := RGB(216,234,204);

               Inc(X);


               FDQueryRecuperaCliente.Next;
           end;

           FDQueryResumo3.First;
           while not FDQueryResumo3.Eof do
           begin

               Y:= 0;
               for J := Acum_I to Fim_i do
               begin
                 if cxVisao.ItemIndex = 0 then
                 begin
                   with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,J) do
                   begin
                       Style.Font.Style := Style.Font.Style + [fsBold];
                       Style.Brush.BackgroundColor := varCor1;
                       Style.DataFormat.FormatCode := '#,##0.00';
                       AsVariant := FDQueryResumo3.Fields[J-Acum_I].AsFloat;
                   end;
                 end
                 else
                 begin
                   with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,J-2) do
                   begin
                       Style.Font.Style := Style.Font.Style + [fsBold];
                       Style.Brush.BackgroundColor := varCor1;
                       Style.DataFormat.FormatCode := '#,##0.00';
                       AsVariant := FDQueryResumo3.Fields[J-Acum_I].AsFloat;
                   end;
                 end;

                 Inc(Y)
               end;

               if Odd(X) then
                varCor1 := RGB(255,255,225)
               else
                varCor1 := RGB(216,234,204);

               Inc(X);


              FDQueryResumo3.next;
           end;

           Inc(X);
           FDQueryResumo1.First;
           while not FDQueryResumo1.Eof do
           begin
               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,13) do
               begin
                   Style.Font.Style := Style.Font.Style + [fsBold];
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant :=  FDQueryResumo1.Fields[0].AsString;  //Status

               end;
              // Y:=0;
               for J := Acum_I to Fim_i do
               begin
                 if cxVisao.ItemIndex = 0 then
                 begin
                   with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,J) do
                   begin
                       Style.Brush.BackgroundColor := varCor1;
                       Style.DataFormat.FormatCode := '#,##0.00';
                       AsVariant := FDQueryResumo1.Fields[J-Clas_I].AsFloat;
                   end;
                 end
                 else
                 begin
                   with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,J-2) do
                   begin
                       Style.Brush.BackgroundColor := varCor1;
                       Style.DataFormat.FormatCode := '#,##0.00';
                       AsVariant := FDQueryResumo1.Fields[J-Clas_I].AsFloat;
                   end;
                 end;
                // Inc(Y);
               end;

               if Odd(X) then
                varCor1 := RGB(255,255,225)
               else
                varCor1 := RGB(216,234,204);

               Inc(X);


              FDQueryResumo1.next;
           end;

           Inc(X);
           FDQueryResumo2.First;
           while not FDQueryResumo2.Eof do
           begin

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,13) do
               begin
                   Style.Font.Style := Style.Font.Style + [fsBold];
                   Style.Brush.BackgroundColor := varCor1;
                   AsString := FDQueryResumo2.Fields[8].AsString; //Total de Clientes
               end;

               for J := Ini_i to Fim_i do
               begin
                 if cxVisao.ItemIndex = 0 then
                 begin
                   with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,J) do
                   begin
                       Style.Brush.BackgroundColor := varCor1;
                       AsVariant := FDQueryResumo2.Fields[J].AsInteger;
                   end;
                 end
                 else
                 begin
                   with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,J-2) do
                   begin
                       Style.Brush.BackgroundColor := varCor1;
                       AsVariant := FDQueryResumo2.Fields[J].AsInteger;
                   end;
                 end;
               end;

               if Odd(X) then
                varCor1 := RGB(255,255,225)
               else
                varCor1 := RGB(216,234,204);

               Inc(X);


              FDQueryResumo2.next;
           end;



           dxSpreadSheet.BeginUpdate;
           if cxVisao.ItemIndex = 0 then
           begin
             dxSpreadSheet.SaveToFile( PathExcel + 'BaseClientes_' + varNomeArquivo );
             MessageDlg( pChar( 'Planilha exportada em  ' + PathExcel + 'BaseClientes_' + varNomeArquivo )  , mtInformation, [ mbOk ], 0 );
           end
           else
           begin
             dxSpreadSheet.SaveToFile( PathExcel + 'BaseProdutos_' + varNomeArquivo );
             MessageDlg( pChar( 'Planilha exportada em  ' + PathExcel + 'BaseProdutos_' + varNomeArquivo )  , mtInformation, [ mbOk ], 0 );
           end;
       finally
          FDQueryRecuperaCliente.First;
          FreeAndNil(dxSpreadSheet);
       end;
   Finally
          Mensagem( EmptyStr );
          Screen.Cursor := crDefault;
   End;
end;



procedure TFr_RelatorioManutencaoClientes.cdsGraficoDetalheAfterOpen(
  DataSet: TDataSet);
begin
    Label2.Caption := IntToStr(cdsGraficoDetalhe.RecordCount);
end;

procedure TFr_RelatorioManutencaoClientes.chkbImpostoClick(Sender: TObject);
begin


   if chkbImposto.Checked then
   begin
      if cxVisao.ItemIndex = 0 then   //cliente  com imposto
            varCampoValor := 'nfe.valortotal'
      else varCampoValor := '(nfe_itens.valortotal + nfe_itens.valoricms_st + nfe_itens.valoripi)';   // produto com imposto
   end
   else
   begin
      if cxVisao.ItemIndex = 0 then     // cliente sem imposto
            varCampoValor := 'nfe.totalprod'
      else varCampoValor := 'nfe_itens.valortotal'; // produto sem imposto
   end;

end;

procedure TFr_RelatorioManutencaoClientes.cxButtonPrintClick(Sender: TObject);
begin
  if not cdsGrafico.IsEmpty then
  begin
     with TPrintDialog.Create(nil) do
    try
      if Execute then
        Chart.PrintLandscape;
    finally
      Free;
    end;
  end;

end;

function TFr_RelatorioManutencaoClientes.RemoveAcento(const pText: string): string;
type
  USAscii20127 = type AnsiString(20127);
begin
  Result := string(USAscii20127(pText));
end;

procedure TFr_RelatorioManutencaoClientes.cxButtonRefreshClick(Sender: TObject);
begin

  if ((EdtEmitente.Text = '') or (EdtEmitente.bs_KeyValue = 0)) then
  begin
      Mens_MensInf('Selecione o Fornecedor.') ;
      exit;
  end;

  NomedoUsuario := EdtEmitente.bs_KeyValue;
  NomedoUsuario := NomedoUsuario.Replace('-','');
  NomedoUsuario := RemoveAcento(NomedoUsuario);
  NomedoUsuario := StringReplace(NomedoUsuario,' ', EmptyStr, [rfReplaceAll]);


  cxGrid1DBBandedTableView1.ClearItems;
  cxGrid2DBBandedTableView1.ClearItems;
  cxGrid3DBBandedTableView1.ClearItems;
  cxGrid4DBBandedTableView1.ClearItems;

  FDQueryAux.Close;
  FDQueryBase.Close;
  FDQueryRecuperaCliente.Close;
  FDQueryRecuperaClienteMem.Close;
  cdsGrafico.Close;
  FDQueryResumo1.Close;
  FDQueryResumo2.Close;
  FDQueryResumo3.Close;
  cdsGraficoDetalhe.Close;


  if ABand <> Nil then
  begin
    ABand.Bands.Clear;
  end;

  if ABand1 <> Nil then
  begin
    ABand1.Bands.Clear;
  end;

  if ABand2 <> Nil then
  begin
    ABand2.Bands.Clear;
  end;

  if ABand3 <> Nil then
  begin
    ABand3.Bands.Clear;
  end;

  Try

     AbrirDataset;

  except
    on E: Exception do
      begin

        Mensagem( '3 ' + E.Message );


      end;

    end;
end;

procedure TFr_RelatorioManutencaoClientes.cxVisaoClick(Sender: TObject);
begin
 chkbImpostoClick(Nil);
end;

procedure TFr_RelatorioManutencaoClientes.DropObjetos;
begin

  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
  FDQueryAux.SQL.Add(' DROP TABLE IF EXISTS tab_recuperacliente_' + NomedoUsuario) ;
  FDQueryAux.ExecSQL;

  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
  FDQueryAux.SQL.Add(' DROP TABLE IF EXISTS tab_recuperacliente_resumo_' + NomedoUsuario);
  FDQueryAux.ExecSQL;

  if FileExists(PathTemp  + DataFileBase) then
   DeleteFile(PathTemp  + DataFileBase);

  if FileExists(PathTemp  +  DataFileMestre) then
    DeleteFile(PathTemp +   DataFileMestre);

  if FileExists(PathTemp  +  DataFileDetalhe) then
   DeleteFile(PathTemp  +   DataFileDetalhe);

end;

procedure TFr_RelatorioManutencaoClientes.EdtEmitenteExit(Sender: TObject);
begin
  if ( Trim( EdtEmitente.Text ) <> '' ) and ( Trim( EdtEmitente.bs_KeyValue ) <> '' ) then
  begin

     FDQueryAux.Close;
     FDQueryAux.SQL.Clear;
     FDQueryAux.sql.Add(' Select path_nfe, path_importado, path_invalido, path_temp, path_excel ');
     FDQueryAux.sql.Add(' From fornecedores ');
     FDQueryAux.sql.Add(' Where codfornecedor = :codfornecedor ');
     FDQueryAux.ParamByName( 'codfornecedor').AsInteger := EdtEmitente.bs_KeyValue;
     FDQueryAux.Open;

     if FDQueryAux.FieldByName( 'path_nfe' ).AsString <> '' then
     begin

       PathTemp  := IncludeTrailingPathDelimiter( FDQueryAux.FieldByName( 'path_temp' ).AsString ) ;
       PathExcel := IncludeTrailingPathDelimiter( FDQueryAux.FieldByName( 'path_excel' ).AsString  );

       cxButtonRefresh.Enabled := True;
       cxButtonRefresh.SetFocus;
     end
     else
     begin
        Mens_MensErro( 'Cadastro de Filial - Campo Path NFE n�o informado.');
     end;
  end;
end;

procedure TFr_RelatorioManutencaoClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not FDConnection.Connected then
  begin

    FDConnection.Params.LoadFromFile( ExtractFilePath(Application.ExeName) + '\' +  'ConexaoABC.ini' );
    FDConnection.Open;

  end;

  DropObjetos;
  Mensagem('');
  Fr_RelatorioManutencaoClientes := nil;
  Action := caFree;
end;

procedure TFr_RelatorioManutencaoClientes.FormShow(Sender: TObject);
var
 i,j : Integer;
 Ano, MesInicio, MesAtual, Dia: Word;
 DataAnterior : TDateTime;
begin
  if not FDConnection.Connected then
  begin

    FDConnection.Params.LoadFromFile( ExtractFilePath(Application.ExeName) + '\' +  'ConexaoABC.ini' );
    FDConnection.Open;

  end;

  WindowState := wsMaximized;
  SetParametros(EdtEmitente, TipoFornecedorX);

  DataAnterior := now;
  MesInicio    := GetMonth(System.DateUtils.StartOfTheYear(now));
  MesAtual     := GetMonth(now);
  cbMes.Properties.Items.Add('');

  for I := CurrentYear  downto 2015  do
    begin

      for j := MesAtual  downto MesInicio do
      begin
        cbMes.Properties.Items.Add(GetNameOfMonth(DataAnterior)+ '-' +  IntToStr(I) );
        DataAnterior := IncMonth(DataAnterior, -1) ;
      end;
      MesAtual  := 12;
      MesInicio := 1;

    end;
  cbMes.ItemIndex:=-1;
  varCampoValor := 'nfe.totalprod';   // default � sem imposto
end;


function TFr_RelatorioManutencaoClientes.GetNameOfMonth(const ADate: TDate): UnicodeString;
var
   Month: Word;
begin
   Month := MonthOfTheYear(ADate);

   case Month of
      MonthJanuary:
         Result := 'Janeiro';
      MonthFebruary:
         Result := 'Fevereiro';
      MonthMarch:
         Result := 'Mar�o';
      MonthApril:
         Result := 'Abril';
      MonthMay:
         Result := 'Maio';
      MonthJune:
         Result := 'Junho';
      MonthJuly:
         Result := 'Julho';
      MonthAugust:
         Result := 'Agosto';
      MonthSeptember:
         Result := 'Setembro';
      MonthOctober:
         Result := 'Outubro';
      MonthNovember:
         Result := 'Novembro';
      MonthDecember:
         Result := 'Dezembro';
   end;
end;

function TFr_RelatorioManutencaoClientes.GetMonth(const ADate: TDate): Word;
var
     D, M, Y: Word;
begin
    DecodeDate(ADate, Y, M, D);

    Result := M;   // M � o m�s da data decodificada
end;


procedure TFr_RelatorioManutencaoClientes.InitGrid;
var
  col, I: Integer;
begin
  with Chart do
  begin
    while SeriesCount > 0 do
      Series[0].Free;

    Title.Text.Clear;
    Title.Text.Add('Base Clientes - Per�odo: ' + cbPeriodo.Text);

    Legend.Visible := True;
    View3D := True;
    I:= 0;
    cdsGrafico.First;
    while not cdsGrafico.Eof do
    begin
      AddSeries(TBarSeries.Create(Self));
      (Series[I] as TBarSeries).MultiBar := mbStacked;
      Series[I].Marks.Visible := True;
      Series[I].Marks.Style := smsValue;

      Series[I].Name := 'Stacked' + cdsGrafico.FieldByName('Curva').AsString +  IntToStr(I);
      Series[I].LegendTitle := cdsGrafico.FieldByName('Curva').AsString;

      for col := 1 to iPeriodo do
        Series[I].Add(cdsGrafico.Fields[col].Value,
          cdsGrafico.Fields[col].FieldName, clTeeColor);



      Inc(I);
      cdsGrafico.next;
    end;

  end;
  cdsGrafico.First;
  cdsGrafico.EnableControls;
end;

procedure TFr_RelatorioManutencaoClientes.Mensagem(pMensagem: String);
begin
  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;
end;

procedure TFr_RelatorioManutencaoClientes.MontaStringMes(Alias : String; setColumn: Boolean; Sum : Boolean = False);
var
  I : Integer;
  NovaDataInterna : TDateTime;
  varResultado: String;
begin


  NovaData := System.DateUtils.StartOfTheMonth(now);
  if cbMes.ItemIndex > -1 then
    NovaData := IncMonth(System.DateUtils.StartOfTheMonth(now), (cbMes.ItemIndex-1)*-1 );
  NovaDataInterna := IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -iPeriodo);

  varResultado := '';

  if setColumn then
  begin

    for I := 0 to iPeriodo - 1 do
    begin
      varMesesArrayB[I] := NovaDataInterna;
      varResultado :=   BuscaMes(NovaDataInterna, setColumn, False, Alias);
      if ( I = (iPeriodo - 1)) then
         varResultado :=  Copy(varResultado, 1, Length(varResultado) - 1);
      if ((Alias = 'nfe')  or (Alias = 'nfe_itens')) then
        varMesSelect[I]   :=  varResultado
      else if (Alias = 'totcli')then
         varMesTotCli[I]  :=  varResultado
      else if (Alias = 'qtdepro')then
         varMesQtdePro[I]   :=  varResultado;

      NovaDataInterna := IncMonth(NovaDataInterna, 1);
    end;

  end
  else
  begin

    for I := 0 to iPeriodo - 1 do
    begin
      varMesesArrayB[I] := NovaDataInterna;
      VarMesesSUM := VarMesesSUM + BuscaMes(NovaDataInterna, False, Sum, Alias);
      if ( I = (iPeriodo - 1)) then
         VarMesesSUM :=  Copy(VarMesesSUM, 1, Length(VarMesesSUM) - 1);
      NovaDataInterna := IncMonth(NovaDataInterna, 1);
    end;

  end;




end;

procedure TFr_RelatorioManutencaoClientes.PageChange(Sender: TObject);
begin
   if Page.ActivePage = tabGrafico then
   begin
      if Not cdsGrafico.IsEmpty then
      begin
        Mensagem('Gerando Gr�fico');
        InitGrid;
        Mensagem(EmptyStr);
      end;
   end;

   if Page.ActivePage = tabDetalhe then
   begin
      if Not FDQueryResumo2.IsEmpty then
      begin
        Mensagem('Gerando Gr�fico');
        InitGrid2;
        Mensagem(EmptyStr);
      end;
   end;

end;

procedure TFr_RelatorioManutencaoClientes.SetaPeriodo;
begin

    Ini_i  := 11;
    Acum_I := 10;
    Clas_I := 9;
    Det_I  := 10;

    if cbPeriodo.ItemIndex = 0 then
    begin
      iPeriodo := 3;
      Fim_I    := 13;
    end
    else if cbPeriodo.ItemIndex = 1 then
    begin
      iPeriodo := 6;
      Fim_I    := 16;
    end
    else if cbPeriodo.ItemIndex = 2 then
    begin
      iPeriodo := 9;
      Fim_I    := 19;
    end
    else if cbPeriodo.ItemIndex = 3 then
    begin
      iPeriodo := 12;
      Fim_I    := 22;
    end
    else if cbPeriodo.ItemIndex = 4 then
    begin
      iPeriodo := 15;
      Fim_I    := 25;
    end
     else if cbPeriodo.ItemIndex = 5 then
    begin
      iPeriodo := 18;
      Fim_I    := 28;
    end
    else if cbPeriodo.ItemIndex = 6 then
    begin
      iPeriodo := 24;
      Fim_I    := 34;
    end
    else if cbPeriodo.ItemIndex = 7 then
    begin
      iPeriodo := 36;
      Fim_I    := 46;
    end;
    iPeriodoFixo := Fim_I - 12;

end;

end.