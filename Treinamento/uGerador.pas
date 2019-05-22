﻿unit uGerador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FGrid, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  cxControls, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinsdxStatusBarPainter, FMTBcd, cxContainer, cxEdit,
  StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, ComCtrls, EditBusca,
  cxGroupBox, DBClient, Provider, ExtCtrls, DB, SqlExpr, dxStatusBar, cxButtons,
  ToolWin, jpeg, SQLTimST,  SetParametro, IniFiles, dxSkinscxPCPainter, cxLabel,
  cxPC, Mask, rsEdit, cxCheckBox, ExtDlgs, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, dxBarBuiltInMenu,
  cxNavigator, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmGerador = class(TFrmGrid)
    cxGroupBox: TcxGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    editFilial: TEditBusca;
    cmbRegime: TcxComboBox;
    cmbTipoGia: TcxComboBox;
    btnProcessar: TcxButton;
    Panel1: TPanel;
    Page: TcxPageControl;
    tabValores: TcxTabSheet;
    TabST: TcxTabSheet;
    TabNaturezas: TcxTabSheet;
    TabObs: TcxTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    EditPorSaidasPrestacoes: TrsSuperEdit;
    editOutrosDebito: TrsSuperEdit;
    editEstornoCredito: TrsSuperEdit;
    editTotalDebito: TrsSuperEdit;
    editPorEntradasAqui: TrsSuperEdit;
    editOutrosCreditos: TrsSuperEdit;
    editEstornoDebitos: TrsSuperEdit;
    editSubTotal: TrsSuperEdit;
    editSaldoCredorAnterior: TrsSuperEdit;
    EditTotalCredito: TrsSuperEdit;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    editSaldoDevedor: TrsSuperEdit;
    editDeducoes: TrsSuperEdit;
    EditImpostoRecolher: TrsSuperEdit;
    editSaldoCredorSeguinte: TrsSuperEdit;
    mskperiodo: TMaskEdit;
    chkTransmitida: TcxCheckBox;
    editArquivo: TrsSuperEdit;
    Label1: TLabel;
    OpenTextFileDialog: TOpenTextFileDialog;
    tabGIA: TcxTabSheet;
    cxGroupBox13: TcxGroupBox;
    cdsGridCTE_SALDOCREDOR_ID: TIntegerField;
    cdsGridNOME: TStringField;
    cdsGridCTE_FILIAL_ID: TStringField;
    cdsGridARQUIVO: TStringField;
    cdsGridPERIODO: TStringField;
    cdsGridDATACADASTRO: TSQLTimeStampField;
    cdsGridSALDOINICIAL: TFMTBCDField;
    cdsGridSALDOFINAL: TFMTBCDField;
    Panel5: TPanel;
    Panel6: TPanel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView: TcxGridDBTableView;
    cxGrid1DBTableViewCTE_SALDOCREDOR_ID: TcxGridDBColumn;
    cxGrid1DBTableViewNOME: TcxGridDBColumn;
    cxGrid1DBTableViewCTE_FILIAL_ID: TcxGridDBColumn;
    cxGrid1DBTableViewARQUIVO: TcxGridDBColumn;
    cxGrid1DBTableViewPERIODO: TcxGridDBColumn;
    cxGrid1DBTableViewDATACADASTRO: TcxGridDBColumn;
    cxGrid1DBTableViewSALDOINICIAL: TcxGridDBColumn;
    cxGrid1DBTableViewSALDOFINAL: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    ButExcluirItem: TcxButton;
    procedure btnProcessarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure editFilialExit(Sender: TObject);
    procedure mskperiodoExit(Sender: TObject);
    procedure ButEscapeClick(Sender: TObject);
    procedure ButImprimirClick(Sender: TObject);
    procedure editOutrosDebitoExit(Sender: TObject);
    procedure editEstornoDebitosExit(Sender: TObject);
    procedure ButExcluirItemClick(Sender: TObject);
    procedure PageChange(Sender: TObject);
  private
    procedure AtualizaGridGIA;
    { Private declarations }
  public
    { Public declarations }
  end;

function DirExists( const Directory: string ): boolean;

var
  frmGerador: TfrmGerador;

implementation

{$R *.dfm}

uses MensFun, Funcoes , DBConect, Global, ufrmVisualizarTexto;


function DirExists( const Directory: string ): boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(Directory));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;



procedure TfrmGerador.btnProcessarClick(Sender: TObject);
var ArquivoTexto: TextFile;
    i           : integer;
    strConteudo : string;
    pArquivo    : String;
    fSaldoCredor: Double;
    iRegimeTributario : Integer;
    xCNPJ, xRegime, xInscricao, xTipoGia : string;
    fCredito : Double;
    sqlAux, sqlCR05, sqlCR07, sqlCR10, sqlCR14, sqlCR18, sqlCR20, sqlCR25,
    sqlCR26, sqlCR27, sqlCR28, sqlCR30, sqlCR31 : TSQLQuery;
    dataInicial, dataFinal : TDateTime;
    xPathLocal : String;
    iRegistro : Integer;
    bMostraQuery : Boolean;
begin
  if editFilial.Text = EmptyStr then
  begin
     Mens_MensErro('Não foi informado nenhuma Filial');
     editFilial.SetFocus;
     Exit;
  end;

  if (editFilial.bs_KeyValues[6] = '') then
  begin
      Mens_MensInf('Falta informar o caminho para salvar o arquivo da GIA (PRF). Verifique no cadastro da Filial');
      Exit;
  end;

  if cmbRegime.ItemIndex = -1 then
  begin
     Mens_MensErro('Informe o Regime Tributário');
     cmbRegime.SetFocus;
     Exit;
  end;

  if cmbTipoGia.ItemIndex = -1 Then
  begin
     Mens_MensErro('Informe o Tipo de GIA');
     cmbTipoGia.SetFocus;
     Exit;
  end;

  if (mskperiodo.Text = '  /    ') then
  begin
     Mens_MensErro('Informe o período de apuração');
     mskperiodo.SetFocus;
     Exit;
  end;

  dataInicial := StrToDate('01/' + mskperiodo.Text);
  dataFinal := StrToDate(Copy(DateToStr(LastDayOfMonth(dataInicial,true)),1,2) + '/' + mskperiodo.Text);

  xPathLocal := EditFilial.bs_KeyValues[6];
  xPathLocal := IncludeTrailingPathDelimiter( xPathLocal ) ;

  if not DirExists( xPathLocal) then
     CreateDir( xPathLocal  );

  pArquivo :=  xPathLocal  + 'GIA_' + Zero(editFilial.bs_KeyValue,4) + '_' + FormatDateTime('yyyymm', dataInicial) + '.prf';

  If ( Mens_MensConf('Confirma Geração da GIA ' + pArquivo + '?') <> mrOk ) Then
     Exit;

  editArquivo.Text := pArquivo;

  if cmbRegime.ItemIndex = 0 then
     xRegime := '01'
  else if cmbRegime.ItemIndex = 1 then
     xRegime := '02'
  else if cmbRegime.ItemIndex = 2 then
     xRegime := '03'
  else if cmbRegime.ItemIndex = 3 then
     xRegime := '04';

  if cmbTipoGia.ItemIndex = 0 then
    xTipoGia := '01'
  else if cmbTipoGia.ItemIndex = 1 then
    xTipoGia := '02'
  else if cmbTipoGia.ItemIndex = 2 then
    xTipoGia := '03';

  AguardandoProcesso(frmGerador, true, 'Realizando apuraçao do ICMS');


  fCredito          := 0;
  iRegimeTributario := 0;
  xCNPJ             := '';
  xInscricao        := '';


  bMostraQuery  := false;

  sqlCR05 := TSQLQuery.Create(Nil);
  Try
    sqlCR05.SQLConnection := DB_Conect.SQLConnection;
    sqlCR05.Close;
    sqlCR05.SQL.Clear;
    sqlCR05.SQL.Add('Select CNPJ, Inscricao, Regime, Credito From CTE_Filial');
    sqlCR05.SQL.Add(' Where CTE_FILIAL_ID = :CTE_FILIAL_ID');
    sqlCR05.ParamByName('CTE_FILIAL_ID').AsString := VarToStr(editFilial.bs_KeyValue);
    sqlCR05.Open;
    xCNPJ      := sqlCR05.FieldByName('CNPJ').AsString;
    xInscricao := Zero(sqlCR05.FieldByName('Inscricao').AsString,12);
    iRegimeTributario := sqlCR05.FieldByName('Regime').AsInteger;
    fCredito :=  sqlCR05.FieldByName('Credito').AsFloat;

  Finally
    FreeAndNil(sqlCR05);
  End;

  (* cria um novo arquivo *)
  AssignFile(ArquivoTexto, pArquivo);

  Rewrite(ArquivoTexto);

  try
    sqlAux := TSQLQuery.Create(Nil);
    Try
      sqlAux.SQLConnection := DB_Conect.SQLConnection;

        strConteudo := '0101';

        strConteudo := strConteudo + FormatDateTime('yyyymmddhhnnss', Now);

        strConteudo := strConteudo + '00000210';

        strConteudo := strConteudo + '0001'; // Colocar aqui a qtde de registro na CR=05

        strConteudo := strConteudo + #13#10;

        {*******************************************}
        strConteudo := strConteudo + '05';

        strConteudo := strConteudo + xInscricao;

        strConteudo := strConteudo + xCNPJ;

        strConteudo := strConteudo + Zero('0',7);

        strConteudo := strConteudo + xRegime;

        {AAAAMM (AAAA: Ano, MM: Mês)
         Ref >= 200007 e =< mês da data atual
         Se existir CR=30 (Dipam B), o campo Ref deve ser >=200101
         Se RegTrib = 02 (RES), o campo Ref deve dever ser <= 200012
         Se RegTrib = 04 (Simples-ST) , o campo Ref deve ser >= 200007 e =< 200512
         Não pode ocorrer duplicidade de Ref para a mesma IE. }
        strConteudo := strConteudo + FormatDateTime('yyyymm', Now); // data atual

        { AAAAMM (AAAA: Ano, MM: Mês)
        RefInicial >=200007
        Se RegTrib = 01 (RPA) , RefInicial = 000000 (ZEROS)
        Se RegTrib = 02 (RES), RefInicial =< Ref e deve pertencer ao mesmo semestre de Ref
        Se RegTrib = 03 (RPA-DISPENSADO), RefInicial = 000000 (ZEROS)
        Se RegTrib = 04 (Simples-ST), RefInicial = 000000 (ZEROS)}
        if ((xRegime = '01') or (xRegime = '03') or (xRegime = '04')) then
          strConteudo := strConteudo + '000000'
        else
          strConteudo := strConteudo + FormatDateTime('yyyymm', dataInicial);  // data de inicio

        strConteudo := strConteudo + xTipoGia;

        strConteudo := strConteudo + '1'; // zero nao deve ter reg. filho / um deve haver reg. filho

        strConteudo := strConteudo + '0'; // doc ja transmitido = 0 não 1 sim


        {Saldo Credor do Periodo Anterior
        De 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
        Este valor é utilizado na Apuração de Operações Próprias
        Alinhar à direita e preencher com ZEROS à esquerda}
        strConteudo := strConteudo + Zero(StrTran(StrTran(FloatToStrF(editSaldoCredorAnterior.AsDouble, ffCurrency,18,2),',',''),'.',''),15);

        sqlAux.Close;
        sqlAux.SQL.Clear;
        sqlAux.SQL.Add('SELECT  IsNull(SUM(I.VICMS),0) as ValorICMS ');
        sqlAux.SQL.Add('FROM CTE_CAPA CP ');
        sqlAux.SQL.Add('INNER JOIN CTE_IMPOSTOS I ON I.CCT = CP.CCT ');
        sqlAux.SQL.Add('WHERE CP.Lote is null and  CP.CTE_FILIAL_ID = :CTE_Filial_ID ');
        sqlAux.SQL.Add('  AND CP.DHEMI BETWEEN :Data1 and :Data2');
        sqlAux.SQL.Add(' and ((I.CFOP like ''5%'') or (I.CFOP like ''6%'') or (I.CFOP like ''7%'')) ' );
        sqlAux.ParamByName('CTE_FILIAL_ID').AsString := VarToStr(editFilial.bs_KeyValue);
        sqlAux.ParamByName('Data1').asString   := formatdatetime('dd/mm/yyyy  00:00:00', dataInicial);
        sqlAux.ParamByName('Data2').asString   := formatdatetime('dd/mm/yyyy  00:00:00', dataFinal);
        DB_Conect.GetComando(sqlAux,bMostraQuery);
        sqlAux.Open;
        if (sqlAux.FieldByName('ValorICMS').AsFloat = 0)  then
        begin
           AguardandoProcesso(frmGerador, False);
           Mens_MensInf('Não há registros na base para apuração do ICMS no periodo informado');
           Exit;
        end;

        EditPorSaidasPrestacoes.AsDouble := sqlAux.FieldByName('ValorICMS').AsFloat;

        // Regra para Empresas do Ramo de Transporte
        if ((iRegimeTributario <> 3) and (fCredito <> 0)) then
        begin
          sqlAux.Close;
          sqlAux.SQL.Clear;
          sqlAux.SQL.Add('SELECT  IsNull(SUM(I.VICMS),0) as ValorICMS ');
          sqlAux.SQL.Add('FROM CTE_CAPA CP ');
          sqlAux.SQL.Add('INNER JOIN CTE_IMPOSTOS   I ON I.CCT   = CP.CCT ');
          sqlAux.SQL.Add('INNER JOIN CTE_EMITENTE EMI ON EMI.cte_emitente_id = CP.codFornecedor');
          sqlAux.SQL.Add('INNER JOIN XML_IMPORTADA XML ON XML.CCT = CP.CCT');

          sqlAux.SQL.Add('WHERE CP.Lote is null and  CP.CTE_FILIAL_ID = :CTE_Filial_ID ');
          sqlAux.SQL.Add('  AND CP.DHEMI BETWEEN :Data1 and :Data2');
          sqlAux.SQL.Add('  AND UPPER(CP.OrigemNota) = ''NFE'' and XML.Origem = ''E'' ');

          sqlAux.SQL.Add(' and ((I.CFOP like ''1%'') or (I.CFOP like ''2%'')) ' );
          sqlAux.SQL.Add(' and EMI.UF = :UF ' );

          sqlAux.ParamByName('CTE_FILIAL_ID').AsString := VarToStr(editFilial.bs_KeyValue);
          sqlAux.ParamByName('Data1').asString   := formatdatetime('dd/mm/yyyy  00:00:00', dataInicial);
          sqlAux.ParamByName('Data2').asString   := formatdatetime('dd/mm/yyyy  00:00:00', dataFinal);
          sqlAux.ParamByName('UF').asString      := editFilial.bs_KeyValues[3]; // uf
          DB_Conect.GetComando(sqlAux,bMostraQuery);
          sqlAux.Open;

          editPorEntradasAqui.AsDouble := sqlAux.FieldByName('ValorICMS').AsFloat;
        end
        else
          editPorEntradasAqui.AsDouble  :=  (EditPorSaidasPrestacoes.AsDouble / 100) * fCredito;


        EditTotalCredito.AsDouble    := editPorEntradasAqui.AsDouble + editSaldoCredorAnterior.AsDouble;

        fSaldoCredor := EditPorSaidasPrestacoes.AsDouble  - (editPorEntradasAqui.AsDouble + editSaldoCredorAnterior.AsDouble);

        if (EditPorSaidasPrestacoes.AsDouble > editPorEntradasAqui.AsDouble) then
           EditImpostoRecolher.AsDouble := fSaldoCredor
        else
           EditSaldoCredorSeguinte.AsDouble := fSaldoCredor;



        {De 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
        Este valor é utilizado na Apuração de Operações com ST
        Alinhar à direita e preencher com ZEROS à esquerda
        Preencher com zeros se RegTrib = 04}
        strConteudo := strConteudo + Zero('0',15);


        {CNPJ ou CPF do fabricante
        Validar CNPJ ou CPF
        Alinhar à direita com zeros à esquerda}
        strConteudo := strConteudo + Zero('13202601873',14);

        {Indica se o arquivo Pré-formatadoNG
        foi gerado por algum sistema de
        informação contábil
        0 – Pré-formatado-NG (gerado pelo sistema de informação contábil)
        1 – Digitado (quando gerado ou modificado pelo front-end)}
        strConteudo := strConteudo + '0';


        {De 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
        Se RegTrib = 02 Conteúdo > ZEROS
        Se RegTrib = 01 ou 03 ou 04 , conteúdo = ZEROS
        Alinhar à direita com preenchimento de ZEROS à esquerda}
        if ((xRegime = '01') or (xRegime = '03') or (xRegime = '04')) then
          strConteudo := strConteudo + Zero('0',15)
        else
          strConteudo := strConteudo + Zero('0',15);  // data de inicio


        {No caso em que o Pré-formatado-NG é gerado por algum
        sistema de informação contábil, deixar este campo com ZEROS.}
        strConteudo := strConteudo + Zero('0',32);

        {Verificar se Q07 = quantidade de registros-filhos 07 existente  no arquivo
        Valor máximo = 0010 (5 para operações próprias e 5 para operações de ST)
        Deve ser igual a ZEROS se Ref < 201201}
        strConteudo := strConteudo + Zero('0',4);

        {Verificar se Q10 = quantidade de registros-filhos 10 existente no arquivo
        Alinhar à direita e preencher com ZEROS à esquerda}

        sqlAux.Close;
        sqlAux.SQL.Clear;
        sqlAux.SQL.Add('WITH DADOS ');
        sqlAux.SQL.Add('AS ( ');
        sqlAux.SQL.Add('SELECT I.CFOP  ');
        sqlAux.SQL.Add('FROM CTE_CAPA CP  ');
        sqlAux.SQL.Add('INNER JOIN CTE_IMPOSTOS I ON I.CCT = CP.CCT ');
        sqlAux.SQL.Add('INNER JOIN CTE_Destinatario D ON D.cte_destinatario = CP.codDestinatario ');

        sqlAux.SQL.Add('WHERE CP.Lote is null and  CP.CTE_FILIAL_ID = :CTE_Filial_ID ');
        sqlAux.SQL.Add('  AND CP.DHEMI BETWEEN :Data1 and :Data2');
        sqlAux.SQL.Add(' and ((I.CFOP like ''5%'') or (I.CFOP like ''6%'') or (I.CFOP like ''7%'')) ' );
        sqlAux.ParamByName('CTE_FILIAL_ID').AsString := VarToStr(editFilial.bs_KeyValue);
        sqlAux.ParamByName('Data1').asString         := formatdatetime('dd/mm/yyyy  00:00:00', dataInicial);
        sqlAux.ParamByName('Data2').asString         := formatdatetime('dd/mm/yyyy  00:00:00', dataFinal);
        sqlAux.SQL.Add('GROUP BY I.CFOP  ');
        sqlAux.SQL.Add(' )');
        sqlAux.SQL.Add('SELECT COUNT(1) as TOTAL10 FROM DADOS ');
        DB_Conect.GetComando(sqlAux,bMostraQuery);

        sqlAux.Open;
        strConteudo := strConteudo + Zero(StrTran(StrTran(sqlAux.FieldByName('TOTAL10').AsString,',',''),'.',''),4);

        {Verificar se Q20 = quantidade de registros-filhos 20 existente no arquivo
        Alinhar à direita e preencher com ZEROS à esquerda}
        strConteudo := strConteudo + Zero('0',4);

        {Verificar se Q30 = quantidade de registros-filhos 30 existente no arquivo
        Alinhar à direita e preencher com ZEROS à esquerda
        Deve ser igual a ZEROS se RegTrib = 04 (Simples -ST)
        Deve ser igual a ZEROS se Ref < 200101}

        sqlAux.Close;
        sqlAux.SQL.Clear;
        sqlAux.SQL.Add( ' With Dados as (');
        sqlAux.SQL.Add('SELECT  distinct E.cMun ');
        sqlAux.SQL.Add('FROM CTE_CAPA CP  ');
        sqlAux.SQL.Add('iNNER JOIN CTE_EMITENTE E ON E.cte_emitente_id = CP.codFornecedor  ');
        sqlAux.SQL.Add('iNNER JOIN CTE_VPREST V ON V.CCT = CP.CCT   ');
        sqlAux.SQL.Add('iNNER JOIN CTE_IMPOSTOS I ON I.CCT = CP.CCT  ');
        sqlAux.SQL.Add('Where CP.Lote is null and  CP.CTE_FILIAL_ID = :CTE_Filial_ID ');
        sqlAux.SQL.Add('  AND CP.DHEMI BETWEEN :Data1 and :Data2');
        sqlAux.SQL.Add(' and ((I.CFOP like ''5%'') or (I.CFOP like ''6%'') or (I.CFOP like ''7%'')) ' );

        sqlAux.SQL.Add(') Select Count(1) as Total From Dados ');
        sqlAux.ParamByName('CTE_FILIAL_ID').AsString := VarToStr(editFilial.bs_KeyValue);
        sqlAux.ParamByName('Data1').AsSQLTimeStamp   := DateTimeToSqlTimeStamp(dataInicial + StrToTime('00:00:00') );
        sqlAux.ParamByName('Data2').AsSQLTimeStamp   := DateTimeToSqlTimeStamp(dataFinal + StrToTime('00:00:00'));
        DB_Conect.GetComando(sqlAux,bMostraQuery);
        sqlAux.Open;

        strConteudo := strConteudo + Zero(sqlAux.FieldByName('Total').AsString,4);

        {Verificar se Q31 = quantidade de registros-filhos CR 31 existente no arquivo
        Alinhar à direita e preencher com ZEROS à esquerda
        Deve ser igual a ZEROS se Ref < 200201}
        strConteudo := strConteudo + Zero('0',4);

        strConteudo := strConteudo + #13#10;
       {*******************************************}

   //     strConteudo := strConteudo + '07';

        {Indica se o pagamento está associado à Apuração do ICMS para Operações
        Próprias ou de Substituição Tributária
        0 – Própria
        1 – ST}
   //     strConteudo := strConteudo + '0';

        {Valor do imposto a recolher para a referente data de vencimento
        de 0,01 a 9.999.999.999.999,99 exceto pontos e vírgulas
        Alinhar à direita e preencher com ZEROS à esquerda}
   //     strConteudo := strConteudo + Zero('0',15);


        {Data de vencimento do valor do imposto de acordo com o CPR
        relacionado à atividade
        AAAAMMDD (AAAA: Ano, MM: Mês, DD: Dia)
        As datas devem estar contidas no intervalo entre o primeiro dia
        do mês de referência da GIA (dia 1 do mês de referência da
        GIA), e o último dia do segundo mês subsequente.}
  //      strConteudo := strConteudo + FormatDateTime('yyyymmdd', dataFinal);

  //      strConteudo := strConteudo + #13#10;
       {*******************************************}


         sqlCR10 := TSQLQuery.Create(Nil);
        Try
           sqlCR10.SQLConnection := DB_Conect.SQLConnection;
           sqlCR10.Close;
           sqlCR10.SQL.Clear;

           sqlCR10.SQL.Add('WITH DADOS AS ( ');
           sqlCR10.SQL.Add('SELECT  I.CFOP, ');
           sqlCR10.SQL.Add(' SUM(V.VREC) AS VALORCONTABIL, ');
           sqlCR10.SQL.Add(' ISNULL(CASE WHEN I.CST = ''00'' THEN SUM(V.VREC)  END,0) AS VALORCONTABILST, ');
           sqlCR10.SQL.Add(' ISNULL(CASE WHEN I.CST = ''00'' THEN SUM(V.VREC)  END,0) AS VALORCONTABIL00, ');
           sqlCR10.SQL.Add(' ISNULL(CASE WHEN I.CST = ''90'' THEN SUM(V.VREC)  END,0) AS VALORCONTABIL90, ');
           sqlCR10.SQL.Add(' ISNULL(CASE WHEN I.CST = ''60'' THEN SUM(V.VREC)  END,0) AS VALORCONTABIL60, ');
           sqlCR10.SQL.Add(' ISNULL(CASE WHEN I.CST = ''40'' THEN SUM(V.VREC)  END,0) AS VALORCONTABIL40, ');
           sqlCR10.SQL.Add(' ISNULL(CASE WHEN I.CST = ''00'' THEN SUM(I.VBC)   END,0) AS BASECALCULO00, ');
           sqlCR10.SQL.Add(' ISNULL(CASE WHEN I.CST = ''90'' THEN SUM(I.VBC)   END,0) AS BASECALCULO90, ');
           sqlCR10.SQL.Add(' ISNULL(CASE WHEN I.CST = ''10'' THEN SUM(I.VBC)   END,0) AS BASECALCULOST, ');
           sqlCR10.SQL.Add(' ISNULL(CASE WHEN I.CST = ''00'' THEN SUM(I.VICMS) END,0) AS VICMS00, ');
           sqlCR10.SQL.Add(' ISNULL(CASE WHEN I.CST = ''90'' THEN SUM(I.VICMS) END,0) AS VICMS90, ');
           sqlCR10.SQL.Add(' ISNULL(CASE WHEN I.CST = ''10'' THEN SUM(I.VICMS) END,0) AS VICMSST ');
           sqlCR10.SQL.Add('FROM CTE_CAPA CP ');
           sqlCR10.SQL.Add('INNER JOIN CTE_DESTINATARIO D ON D.cte_destinatario = CP.codDestinatario ');
           sqlCR10.SQL.Add('INNER JOIN CTE_VPREST V       ON V.CCT = CP.CCT ');
           sqlCR10.SQL.Add('INNER JOIN CTE_IMPOSTOS I     ON I.CCT = CP.CCT ');
           sqlCR10.SQL.Add('WHERE CP.Lote is null and  CP.CTE_FILIAL_ID = :CTE_Filial_ID ');
           sqlCR10.SQL.Add('  AND CP.DHEMI BETWEEN :Data1 and :Data2');
         // sqlCR10.SQL.Add(' and ((I.CFOP like ''5%'') or (I.CFOP like ''6%'') or (I.CFOP like ''7%'')) ' );
           sqlCR10.ParamByName('CTE_FILIAL_ID').AsString := VarToStr(editFilial.bs_KeyValue);
           sqlCR10.ParamByName('Data1').AsSQLTimeStamp   := DateTimeToSqlTimeStamp(dataInicial + StrToTime('00:00:00') );
           sqlCR10.ParamByName('Data2').AsSQLTimeStamp   := DateTimeToSqlTimeStamp(dataFinal + StrToTime('00:00:00'));
           sqlCR10.SQL.Add('GROUP BY I.CFOP, i.CST  ');
           sqlCR10.SQL.Add(')  ');
           sqlCR10.SQL.Add('SELECT CFOP,  ');
           sqlCR10.SQL.Add(' ISNULL(SUM(VALORCONTABIL),0) AS VALORCONTABIL, ');
           sqlCR10.SQL.Add(' ISNULL(SUM(BASECALCULO00),0) AS BASECALCULO, ');
           sqlCR10.SQL.Add(' ISNULL(SUM(BASECALCULOST),0) AS BASECALCULOST, ');
           sqlCR10.SQL.Add(' ISNULL(SUM(VICMS00),0) AS VICMS00, ');
           sqlCR10.SQL.Add(' ISNULL(SUM(VICMS90),0) AS VICMS90OUTROS, ');
           sqlCR10.SQL.Add(' ISNULL(SUM(VICMSST),0) AS VICMSST, ');
           sqlCR10.SQL.Add(' ISNULL(SUM(VALORCONTABIL40),0) AS VALORISENTNAOTRIB ');
           sqlCR10.SQL.Add('FROM DADOS  ');
           sqlCR10.SQL.Add('GROUP BY CFOP ');
           sqlCR10.SQL.Add('ORDER BY  CFOP ');

           DB_Conect.GetComando(sqlCR10,bMostraQuery);

           sqlCR10.Open;
           sqlCR10.First;
           while not sqlCR10.Eof do
           begin
               {10
               535200
               000000081275559
               000000081275559
               000000009753068
               0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
               }
               strConteudo := strConteudo + '10';

               {Código Fiscal de Operação e Prestação}
               {Ver Tabela10F para valores válidos para referência > 200804 e <= 200906
               Ver Tabela10G para valores válidos para referência > 200906   e <= 201006
               Ver Tabela10H para valores válidos para referência > 201006   e <= 201012
               Ver Tabela10I para valores válidos para referência > 201012
               Se CFOP <> 2xxxxx e 6xxxxx, então não poderá existir
               registros-filhos CR=14 e o campo Q14=0000 (ZEROS)
               Se CFOP = 2xxxxx ou 6xxxxx, então deve existir registros filhos CR=14 e Q14>0000.
               O campo deve estar alinhado à esquerda e com ZEROS à
               direita. Por exemplo, para CFOP 1.101, o campo CFOP deve
               se apresentar como 110100
               Os CFOPs devem estar classificados em ordem ascendente
               Não poderá haver duplicidade de CFOPs
               CFOP´s do grupo X.99, com a Quarta posição = ZEROS
               devem ter a referência <= 200012, a partir da referência
               200101 , não serão aceitos tais CFOP´s. Por exemplo, CFOP 599000
               ** Para referências a partir de 2003, foram consideradas as faixas de
               CFOPs possíveis, apesar de nem todos os CFOPs compreendidos nestas faixas existirem}
               strConteudo := strConteudo + sqlCR10.FieldByName('CFOP').AsString + '00';

                {Valor Contábil}
               {de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
               Alinhar à direita e preencher com ZEROS à esquerda
               Quando CFOP = 2xxxxx, o valor deste campo deve ser igual à
               somatória do campo Valor_Contábil_1 dos registros-filhos CR=14
               Quando CFOP = 6xxxxx, o valor deste campo deve ser igual à
               somatória dos campos (Valor_Contábil_1+Valor_Contábil_2)
               dos registros-filhos CR=14}
               strConteudo := strConteudo + Zero(StrTran(StrTran(FloatToStrF(sqlCR10.FieldByName('ValorContabil').AsFloat, ffCurrency,18,2),',',''),'.',''),15);


               {Base de Cálculo}
               {de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
               Alinhar à direita e preencher com ZEROS à esquerda
               Quando CFOP = 2xxxxx, o valor deste campo deve ser igual à
               somatória do campo BaseCálculo_1 dos registros-filhos
               CR=14
               Quando CFOP = 6xxxxx, o valor deste campo deve ser igual à
               somatória dos campos (BaseCálculo_1+BaseCálculo_2) dos
               registros-filhos CR=14}
               strConteudo := strConteudo + Zero(StrTran(StrTran(FloatToStrF(sqlCR10.FieldByName('BaseCalculo').AsFloat, ffCurrency,18,2),',',''),'.',''),15);

               {Imposto Creditado ou Debitado}
               {de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
               Alinhar à direita e preencher com ZEROS à esquerda
               Se BaseCálculo > 0 então, obrigatoriamente,
               Imposto > 0 e <= 25% do valor referente à BaseCálculo
               Se BaseCálculo = 0 pode ocorrer Imposto > 0
               Se campo Ref (CR=05) >= 200201 e CFOP (CR=10) =
               2xxxxx ou 6xxxxx, o valor deste campo deve ser igual à
               somatória do campo Imposto dos registros-filhos CR=14}
               strConteudo := strConteudo + Zero(StrTran(StrTran(FloatToStrF(sqlCR10.FieldByName('VICMS00').AsFloat, ffCurrency,18,2),',',''),'.',''),15);

               {Isentas e Não Tributadas}
               {de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
               Alinhar à direita e preencher com ZEROS à esquerda}
               strConteudo := strConteudo + Zero(StrTran(StrTran(FloatToStrF(sqlCR10.FieldByName('VALORISENTNAOTRIB').AsFloat, ffCurrency,18,2),',',''),'.',''),15);

               {Outros valores}
               {de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
               Quando CFOP = 2xxxxx ou CFOP=6xxxxx, o valor deste
               campo deve ser igual à somatória do campo Outras dos
               registros-filhos CR=14
               Alinhar à direita e preencher com ZEROS à esquerda}
               strConteudo := strConteudo + Zero(StrTran(StrTran(FloatToStrF(sqlCR10.FieldByName('VICMS90OUTROS').AsFloat, ffCurrency,18,2),',',''),'.',''),15);

               {Imposto Retido por Substituição Tributária}
               {Se Ref => 200201, então ImpostoRetidoST = ZEROS
                de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
                Quando CFOP = 2xxxxx, o valor deste campo deve ser igual à
                somatória dos campos PetróleoEnergia + OutrosProdutos dos
                registros–filhos CR=14.
                Quando CFOP = 6xxxxx, o valor deste campo deve ser igual à
                somatória do campo ICMSCobradoST dos registros–filhos CR=14.
                Alinhar à direita e preencher com ZEROS à esquerda}
               strConteudo := strConteudo + Zero(StrTran(StrTran(FloatToStrF(sqlCR10.FieldByName('VICMSST').AsFloat, ffCurrency,18,2),',',''),'.',''),15);


               {Imposto lançado para contribuinte
                do tipo Substituto, responsável pelo
                recolhimento do imposto.
               de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
                Se Ref < 200201, então ImpRetSubstitutoST = ZEROS e
               ImpRetSubstituído = ZEROS, Senão, seguir as regras abaixo :
                Quando CFOP = 2xxxxx, então ImpRetSubstitutoST +
               ImpRetSubstituídoST deve ser igual à somatória dos campos
               PetróleoEnergia + OutrosProdutos dos registros-filhos CR=14.
                Quando CFOP = 6xxxxx, então ImpRetSubstituídoST +
               ImpRetSubstitutoST deve ser igual à somatória do campo
               ICMSCobradoST dos registros-filhos CR=14.
                Alinhar à direita e preencher com ZEROS à esquerda
                Para referência > 200804
                Se (CFOP <> 1.360 e (1.401 a 1.449) e (1.651 a 1.699) e
               1.9xx e (2.401 a 2.449) e (2.651 a 2.699) e 2.9xx e 5.360 e
               (5.401 a 5.449) e (5.651 a 5.699) e 5.9xx e 6.360 e (6.401 a
               6.449) e (6.651 a 6. 6.99) e 6.9xx então os campos
               ImpRetSubstitutoST e ImpRetSubstituído devem ser
               preenchidos com ZEROS
                Se BaseCálculo = 0 pode ocorrer (ImpRetSubstitutoST +
               ImpRetSubstituído) > 0.
               ** Para referências a partir de 2003, foram consideradas as faixas de
               CFOPs possíveis, apesar de nem todos os CFOPs compreendidos
               nestas faixas existirem.}
               strConteudo := strConteudo + Zero('0',15);

                {Imposto Retido por Substituição
                Tributária (Substituído)
               de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
                Se Ref < 200201, então ImpRetSubstitutoST = ZEROS e
               ImpRetSubstituído = ZEROS, Senão, seguir as regras abaixo :
                Quando CFOP = 2xxxxx, então ImpRetSubstitutoST +
               ImpRetSubstituídoST deve ser igual à somatória dos campos
               PetróleoEnergia + OutrosProdutos dos registros-filhos CR=14.
                Quando CFOP = 6xxxxx, então ImpRetSubstituídoST +
               ImpRetSubstitutoST deve ser igual à somatória do campo
               ICMSCobradoST dos registros-filhos CR=14.
                Alinhar à direita e preencher com ZEROS à esquerda
                Para referência > 200804
                Se (CFOP <> 1.360 e (1.401 a 1.449) e (1.651 a 1.699) e
               1.9xx e (2.401 a 2.449) e (2.651 a 2.699) e 2.9xx e 5.360 e
               (5.401 a 5.449) e (5.651 a 5.699) e 5.9xx e 6.360 e (6.401 a
               6.449) e (6.651 a 6. 6.99) e 6.9xx então os campos
               ImpRetSubstitutoST e ImpRetSubstituído devem ser
               preenchidos com ZEROS
                Se BaseCálculo = 0 pode ocorrer (ImpRetSubstitutoST +
               ImpRetSubstituído) > 0.
               ** Para referências a partir de 2003, foram consideradas as faixas de
               CFOPs possíveis, apesar de nem todos os CFOPs compreendidos
               nestas faixas existirem.}
               strConteudo := strConteudo + Zero('0',15);

               {Outros Impostos
                de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
                Alinhar à direita e preencher com ZEROS à esquerda}
               strConteudo := strConteudo + Zero('0',15);

               {Quantidade de registros CR=14}
               {Verificar se Q14 = quantidade de registros-filhos CR=14
               existentes no arquivo
               Alinhar à direita e preencher com ZEROS à esquerda
               Deve ser igual a ZEROS se RegTrib = 04 (Simples-ST)}
               if ((Copy(sqlCR10.FieldByName('CFOP').AsString,1,1) = '2') or
                   (Copy(sqlCR10.FieldByName('CFOP').AsString,1,1) = '6')) then
               begin
                  sqlAux.Close;
                  sqlAux.SQL.Clear;
                  sqlAux.SQL.Add('WITH DADOS AS ( ');
                  sqlAux.SQL.Add(' SELECT  I.CFOP, CASE D.UF WHEN  ''SP'' THEN (SELECT T.UF FROM CTE_TOMADOR  T WHERE T.CCT = D.CCT) ELSE D.UF END AS UF, ');
                  sqlAux.SQL.Add('SUM(V.VREC) AS VALORCONTABIL, ');
                  sqlAux.SQL.Add('SUM(I.VBC) AS BASECALCULO, ');
                  sqlAux.SQL.Add('SUM(I.VICMS) AS IMPOSTO ');
                  sqlAux.SQL.Add('FROM CTE_CAPA CP ');
                  sqlAux.SQL.Add('INNER JOIN CTE_DESTINATARIO D ON D.cte_destinatario = CP.codDestinatario ');
                  sqlAux.SQL.Add('INNER JOIN CTE_VPREST V ON V.CCT = CP.CCT ');
                  sqlAux.SQL.Add('INNER JOIN CTE_IMPOSTOS I ON I.CCT = CP.CCT  ');
                  sqlAux.SQL.Add('  Where CP.Lote is null and  CP.CTE_FILIAL_ID = :CTE_Filial_ID ');
                  sqlAux.SQL.Add('  AND CP.DHEMI BETWEEN :Data1 and :Data2');
                  sqlAux.SQL.Add('  AND I.CFOP = :CFOP');
                  sqlAux.ParamByName('CTE_FILIAL_ID').AsString := VarToStr(editFilial.bs_KeyValue);
                  sqlAux.ParamByName('Data1').AsSQLTimeStamp   := DateTimeToSqlTimeStamp(dataInicial + StrToTime('00:00:00') );
                  sqlAux.ParamByName('Data2').AsSQLTimeStamp   := DateTimeToSqlTimeStamp(dataFinal + StrToTime('00:00:00'));
                  sqlAux.ParamByName('CFOP').AsString          := sqlCR10.FieldByName('CFOP').AsString;

                  sqlAux.SQL.Add('GROUP BY I.CFOP ,  D.CCT, D.UF ');
                  sqlAux.SQL.Add(' ) SELECT DADOS.CFOP, DADOS.UF ');
                  sqlAux.SQL.Add('FROM DADOS ');
                  sqlAux.SQL.Add('GROUP BY DADOS.CFOP, DADOS.UF  ');
                  DB_Conect.GetComando(sqlAux,bMostraQuery);
                  iRegistro := 0;
                  sqlAux.Open;
                  sqlAux.First;
                  while not sqlAux.Eof do
                  begin
                     inc(iRegistro);
                     sqlAux.Next;
                  end;

                  strConteudo := strConteudo + Zero(IntToStr(iRegistro) ,4);
               end
               else
               begin
                  strConteudo := strConteudo + Zero('0',4);
               end;

               strConteudo := strConteudo + #13#10;


               if ((Copy(sqlCR10.FieldByName('CFOP').AsString,1,1) = '2') or
                   (Copy(sqlCR10.FieldByName('CFOP').AsString,1,1) = '6')) then
                  begin

                    sqlCR14 := TSQLQuery.Create(Nil);
                    Try
                      sqlCR14.SQLConnection := DB_Conect.SQLConnection;
                      sqlCR14.Close;


                      sqlCR14.SQL.Add('  WITH DADOS AS ( ');
                      sqlCR14.SQL.Add('  SELECT  I.CFOP, CASE D.UF WHEN  ''SP'' THEN (SELECT T.UF FROM CTE_TOMADOR  T WHERE T.CCT = D.CCT) ELSE D.UF END AS UF, ');
                      sqlCR14.SQL.Add('  SUM(V.VREC) AS VALORCONTABIL,  ');
                      sqlCR14.SQL.Add('  ISNULL(CASE WHEN CST = ''00'' THEN SUM(I.VBC)   END,0) AS BASECALCULO00, ');
                      sqlCR14.SQL.Add('  ISNULL(CASE WHEN CST = ''90'' THEN SUM(I.VBC)   END,0) AS BASECALCULO90, ');
                      sqlCR14.SQL.Add('  ISNULL(CASE WHEN CST = ''10'' THEN SUM(I.VBC)   END,0) AS BASECALCULOST,');
                      sqlCR14.SQL.Add('  ISNULL(CASE WHEN CST = ''00'' THEN SUM(I.VICMS) END,0) AS VICMS00,');
                      sqlCR14.SQL.Add('  ISNULL(CASE WHEN CST = ''90'' THEN SUM(I.VICMS) END,0) AS VICMS90,');
                      sqlCR14.SQL.Add('  ISNULL(CASE WHEN CST = ''10'' THEN SUM(I.VICMS) END,0) AS VICMSST,');
                      sqlCR14.SQL.Add('  ISNULL(CASE WHEN CST = ''40'' THEN SUM(I.VICMS) END,0) AS VICMS40,');
                      sqlCR14.SQL.Add('  ISNULL(CASE WHEN CST = ''60'' THEN SUM(I.VICMS) END,0) AS VICMS60 ');
                      sqlCR14.SQL.Add('  FROM CTE_CAPA CP ');
                      sqlCR14.SQL.Add('  INNER JOIN CTE_DESTINATARIO D ON D.cte_destinatario = CP.codDestinatario ');
                      sqlCR14.SQL.Add('  INNER JOIN CTE_VPREST V ON V.CCT = CP.CCT  ');
                      sqlCR14.SQL.Add('  INNER JOIN CTE_IMPOSTOS I ON I.CCT = CP.CCT ');
                      sqlCR14.SQL.Add('Where ' );
                      sqlCR14.SQL.Add('      CP.Lote is null and  CP.CTE_FILIAL_ID = :CTE_Filial_ID ');
                      sqlCR14.SQL.Add('  AND CP.DHEMI BETWEEN :Data1 and :Data2');
                      sqlCR14.SQL.Add('  AND I.CFOP = :CFOP');
                      sqlCR14.ParamByName('CFOP').AsString          := sqlCR10.FieldByName('CFOP').AsString;
                      sqlCR14.ParamByName('CTE_FILIAL_ID').AsString := VarToStr(editFilial.bs_KeyValue);
                      sqlCR14.ParamByName('Data1').AsSQLTimeStamp   := DateTimeToSqlTimeStamp(dataInicial + StrToTime('00:00:00') );
                      sqlCR14.ParamByName('Data2').AsSQLTimeStamp   := DateTimeToSqlTimeStamp(dataFinal + StrToTime('00:00:00'));
                      sqlCR14.SQL.Add('GROUP BY I.CFOP , I.CST, D.CCT, D.UF ');
                      sqlCR14.SQL.Add('  ) SELECT DADOS.CFOP, dados.uf,  e.CODIGO,');
                      sqlCR14.SQL.Add('  SUM(VALORCONTABIL) as VALORCONTABIL, ');
                      sqlCR14.SQL.Add('  SUM(BASECALCULO00) AS BASECALCULO00, ');
                      sqlCR14.SQL.Add('  SUM(BASECALCULO90) AS BASECALCULO90, ');
                      sqlCR14.SQL.Add('  SUM(BASECALCULOST) AS BASECALCULOST,');
                      sqlCR14.SQL.Add('  SUM(VICMS00) AS VICMS00, ');
                      sqlCR14.SQL.Add('  SUM(VICMS90) AS VICMS90, ');
                      sqlCR14.SQL.Add('  SUM(VICMSST) AS VICMSST, ');
                      sqlCR14.SQL.Add('  SUM(VICMS40) AS VICMS40, ');
                      sqlCR14.SQL.Add('  SUM(VICMS60) AS VICMS60  ');
                      sqlCR14.SQL.Add('  FROM DADOS  ');
                      sqlCR14.SQL.Add('  inner join CTE_ESTADOS E on E.UF = DADOS.UF ');
                      sqlCR14.SQL.Add('  GROUP BY DADOS.CFOP, DADOS.UF, E.codigo ');
                      sqlCR14.SQL.Add('  ORDER BY E.CODIGO ');
                      DB_Conect.GetComando(sqlCR14,bMostraQuery);
                      sqlCR14.Open;
                      sqlCR14.First;
                      while not sqlCR14.Eof do
                      begin
                         strConteudo := strConteudo + '14';

                         {Unidade da Federação
                         Os valores válidos são de 01a 08, 10, 12 a 25, ou 27 a 29 descritos na Tabela 11
                         Classificação ascendente Não poderá haver duplicidade de UF}
                         strConteudo := strConteudo + Zero(sqlCR14.FieldByName('CODIGO').AsString,2);

                         {Valor Contábil de Contribuinte
                         de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
                         Alinhar à direita e preencher com ZEROS à esquerda  CFOPs dos grupos 2 e 6}
                         strConteudo := strConteudo + Zero(StrTran(StrTran(FloatToStrF(sqlCR14.FieldByName('VALORCONTABIL').AsFloat, ffCurrency,18,2),',',''),'.',''),15);


                         {Base de Cálculo de Contribuinte
                         de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
                         Alinhar à direita e preencher com ZEROS à esquerda
                         CFOPs dos grupos 2 e 6}
                         strConteudo := strConteudo + Zero(StrTran(StrTran(FloatToStrF(sqlCR14.FieldByName('BASECALCULO00').AsFloat, ffCurrency,18,2),',',''),'.',''),15);


                         {Valor Contábil de Não Contribuinte
                         de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
                         Alinhar à direita e preencher com ZEROS à esquerda
                         CFOPs do grupo 6}
                         strConteudo := strConteudo + Zero('0',15);


                         {Base de Cálculo de Não Contribuinte
                         de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
                         Alinhar à direita e preencher com ZEROS à esquerda
                         CFOPs do grupo 6 15}
                         strConteudo := strConteudo + Zero('0',15);


                         {Imposto  Imposto Creditado ou Debitado
                         de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
                         Alinhar à direita e preencher com ZEROS à esquerda
                         CFOPs dos grupos 2 e 6
                         Se Ref < 200201, então Imposto = ZEROS.15}
                         strConteudo := strConteudo + Zero(StrTran(StrTran(FloatToStrF(sqlCR14.FieldByName('VICMS00').AsFloat, ffCurrency,18,2),',',''),'.',''),15);

                         {Outras  Outros valores
                         de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
                         Alinhar à direita e preencher com ZEROS à esquerda
                         CFOPs dos grupos 2 e 6 15}
                         strConteudo := strConteudo + Zero(StrTran(StrTran(FloatToStrF(sqlCR14.FieldByName('VICMS90').AsFloat, ffCurrency,18,2),',',''),'.',''),15);

                         {ICMSCobradoST  ICMS Cobrado por Substituição Tributária
                         de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
                         Alinhar à direita e preencher com ZEROS à esquerda
                         CFOPs do grupo 6 15}
                         strConteudo := strConteudo + Zero(StrTran(StrTran(FloatToStrF(sqlCR14.FieldByName('VICMSST').AsFloat, ffCurrency,18,2),',',''),'.',''),15);

                         {PetróleoEnergia  Petróleo e Energia quando ICMS cobrado por Substituição Tributária
                         de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
                         Alinhar à direita e preencher com ZEROS à esquerda CFOPs do grupo 2 15}
                         strConteudo := strConteudo + Zero('0',15);

                         {Outros Produtos  Outros Produtos quando ICMS cobrado por Substituição Tributária
                         de 0,00 a 9.999.999.999.999,99 exceto pontos e vírgulas
                         Alinhar à direita e preencher com ZEROS à esquerda CFOPs do grupo 2}
                         strConteudo := strConteudo + Zero('0',15);

                         {Indica se há alguma operação
                         Beneficiada por isenção de ICMS (ZFM/ALC)
                         0 – Não, neste caso não deve haver registros-filhos CR=18
                         ZFM/ALC e o campo Q18 deve ser = 0000 (ZEROS)
                         Se CFOP = 6.107 ou 6.108, Benef = 0
                         1 – Sim, (CFOP do grupo 6) neste caso deve haver registrosfilhos
                         CR=18 ZFM/ALC, o campo Q18 deve ser > 0000 e UF
                         deve ser = 01, 03, 04, 23 ou 24 (ver Tabela 12). Além disso, a
                         somatória do campo Valor dos registros-filhos CR=18 <=
                         (Valor_Contábil_1 + Valor_Contábil_2)
                         Na mesma UF poderão ser lançadas operações ISENTAS
                         juntamente com operações NÃO ISENTAS de ICMS , porém o
                         CR =18 irá representar somente as operações ISENTAS de ICMS.}
                         sqlAux.Close;
                         sqlAux.SQL.Clear;
                         sqlAux.SQL.Add('SELECT  I.CFOP, CP.nCT, CP.DHEMI, D.CNPJ, ZF.CODMUNICIPIO_DEST, ');
                         sqlAux.SQL.Add('		IsNull(case when i.cst = ''00'' then SUM(i.VBC) end,0) as BaseCalculo00, ');
                         sqlAux.SQL.Add('		IsNull(case when i.cst = ''00'' then SUM(v.vrec) end,0) as ValorContabil00,  ');
                         sqlAux.SQL.Add('		IsNull(case when i.cst = ''00'' then SUM(i.VICMS) end,0) as VICMS00  ');
                         sqlAux.SQL.Add('FROM CTE_CAPA CP  ');
                         sqlAux.SQL.Add('iNNER JOIN CTE_DESTINATARIO D ON D.cte_destinatario = CP.codDestinatario  ');
                         sqlAux.SQL.Add('iNNER JOIN CTE_VPREST V ON V.CCT = CP.CCT  ');
                         sqlAux.SQL.Add('iNNER JOIN CTE_IMPOSTOS I ON I.CCT = CP.CCT  ');
                         sqlAux.SQL.Add('iNNER JOIN CTE_MUNICIPIO_ZFM ZF ON D.xMun =  ZF.MUNICIPIO  ');
                         sqlAux.SQL.Add('Where  CP.Lote is null and  D.UF = :UF   ');
                         sqlAux.SQL.Add('  AND    CP.CTE_FILIAL_ID = :CTE_Filial_ID ');
                         sqlAux.SQL.Add('  AND CP.DHEMI BETWEEN :Data1 and :Data2');
                         sqlAux.SQL.Add('  AND I.CFOP = :CFOP');
                         sqlAux.SQL.Add('GROUP BY  I.CFOP, CP.nCT, CP.DHEMI, D.CNPJ, ZF.CODMUNICIPIO_DEST, i.cst ');
                         sqlAux.ParamByName('UF').AsString            := sqlCR14.FieldByName('UF').AsString;
                         sqlAux.ParamByName('CFOP').AsString          := sqlCR10.FieldByName('CFOP').AsString;
                         sqlAux.ParamByName('CTE_FILIAL_ID').AsString := VarToStr(editFilial.bs_KeyValue);
                         sqlAux.ParamByName('Data1').AsSQLTimeStamp   := DateTimeToSqlTimeStamp(dataInicial + StrToTime('00:00:00') );
                         sqlAux.ParamByName('Data2').AsSQLTimeStamp   := DateTimeToSqlTimeStamp(dataFinal + StrToTime('00:00:00'));
                         DB_Conect.GetComando(sqlAux,bMostraQuery);
                         sqlAux.Open;
                         sqlAux.First;
                         iRegistro := 0;
                         while not sqlAux.Eof do
                         begin
                           if TestaCNPJ(sqlAux.FieldByName('CNPJ').AsString) then
                               inc(iRegistro);
                           sqlAux.Next;
                         end;

                         if iRegistro > 0 then
                         begin
                           strConteudo := strConteudo + Zero('1',1);
                           {Quantidade de registros CR=18
                           Verificar se Q18 = quantidade de registros-filhos 18 existente
                           no arquivo
                           Alinhar à direita e preencher com ZEROS à esquerda}
                           strConteudo := strConteudo + Zero(IntToStr(iRegistro),4);
                         end
                         else
                         begin
                           strConteudo := strConteudo + Zero('0',1);
                           {Quantidade de registros CR=18
                           Verificar se Q18 = quantidade de registros-filhos 18 existente
                           no arquivo
                           Alinhar à direita e preencher com ZEROS à esquerda}
                           strConteudo := strConteudo + Zero('0',4);

                         end;

                         strConteudo := strConteudo + #13#10;

                         if (iRegistro > 0) then
                         begin
                           sqlCR18 := TSQLQuery.Create(Nil) ;
                           Try
                              sqlCR18.SQLConnection := DB_Conect.SQLConnection;
                              sqlCR18.Close;
                              sqlCR18.SQL.Clear;
                              sqlCR18.SQL.Add('SELECT  I.CFOP, CP.nCT, CP.DHEMI, D.CNPJ, ZF.CODMUNICIPIO_DEST, ');
                              sqlCR18.SQL.Add('		IsNull(case when i.cst = ''00'' then SUM(i.VBC) end,0) as BaseCalculo00, ');
                              sqlCR18.SQL.Add('		IsNull(case when i.cst = ''00'' then SUM(v.vrec) end,0) as ValorContabil00,  ');
                              sqlCR18.SQL.Add('		IsNull(case when i.cst = ''00'' then SUM(i.VICMS) end,0) as VICMS00  ');
                              sqlCR18.SQL.Add('FROM CTE_CAPA CP  ');
                              sqlCR18.SQL.Add('iNNER JOIN CTE_DESTINATARIO D ON D.cte_destinatario = CP.codDestinatario  ');
                              sqlCR18.SQL.Add('iNNER JOIN CTE_VPREST V ON V.CCT = CP.CCT  ');
                              sqlCR18.SQL.Add('iNNER JOIN CTE_IMPOSTOS I ON I.CCT = CP.CCT  ');
                              sqlCR18.SQL.Add('iNNER JOIN CTE_MUNICIPIO_ZFM ZF ON D.xMun =  ZF.MUNICIPIO  ');

                              sqlCR18.SQL.Add('Where CP.Lote is null and   D.UF = :UF   ');
                              sqlCR18.SQL.Add('  AND    CP.CTE_FILIAL_ID = :CTE_Filial_ID ');
                              sqlCR18.SQL.Add('  AND CP.DHEMI BETWEEN :Data1 and :Data2');
                              sqlCR18.SQL.Add('  AND I.CFOP = :CFOP');
                              sqlCR18.SQL.Add('GROUP BY  I.CFOP, CP.nCT, CP.DHEMI, D.CNPJ, ZF.CODMUNICIPIO_DEST, i.cst ');
                              sqlCR18.ParamByName('UF').AsString            := sqlCR14.FieldByName('UF').AsString;
                              sqlCR18.ParamByName('CFOP').AsString          := sqlCR10.FieldByName('CFOP').AsString;
                              sqlCR18.ParamByName('CTE_FILIAL_ID').AsString := VarToStr(editFilial.bs_KeyValue);
                              sqlCR18.ParamByName('Data1').AsSQLTimeStamp   := DateTimeToSqlTimeStamp(dataInicial + StrToTime('00:00:00') );
                              sqlCR18.ParamByName('Data2').AsSQLTimeStamp   := DateTimeToSqlTimeStamp(dataFinal + StrToTime('00:00:00'));
                              DB_Conect.GetComando(sqlCR18,bMostraQuery);
                              sqlCR18.Open;
                              sqlCR18.First;
                              while not sqlCR18.Eof do
                              begin

                                 strConteudo := strConteudo + '18';

                                 {Número da Nota Fiscal
                                 NF>000000000
                                 Informar apenas dígitos com alinhamento à direita. Por
                                 exemplo, se o número for 4321, então NF=000004321}
                                 strConteudo := strConteudo + Zero(sqlCR18.FieldByName('nCT').AsString ,9);

                                 {Data da emissão da nota fiscal
                                 AAAAMMDD (AAAA: Ano, MM: Mês, DD: Dia)
                                 O ano e mês devem ser iguais a referência indicada}
                                 strConteudo := strConteudo + FormatDateTime('yyyymmdd', sqlCR18.FieldByName('DHEMI').AsDateTime);


                                 {Valor da nota fiscal
                                 de 0.000. 000. 000. 000,01a 9.999.999.999.999,99 exceto pontos e vírgulas
                                 Alinhar à direita e preencher com ZEROS à esquerda}
                                 strConteudo := strConteudo + Zero(StrTran(StrTran(FloatToStrF(sqlCR18.FieldByName('ValorContabil00').AsFloat, ffCurrency,18,2),',',''),'.',''),15);


                                 {Cadastro Nacional de Pessoa Jurídica do Destinatário
                                 Informar apenas dígitos e validar CNPJ}
                                 strConteudo := strConteudo + Zero(sqlCR18.FieldByName('CNPJ').AsString,14);


                                 {Código do município destinatário
                                 Informar apenas dígitos
                                 Ver Tabela 12 para valores válidos.
                                 A UF do município deverá ser a mesma do registro-pai
                                 (Detalhes Interestaduais CR=14), campo UF.}
                                 strConteudo := strConteudo + Zero(sqlCR18.FieldByName('CODMUNICIPIO_DEST').AsString,5);

                                 strConteudo := strConteudo + #13#10;

                                 sqlCR18.Next;
                              end;

                           Finally
                             FreeAndNil(sqlCR18);
                           End;

                         end;

                         sqlCR14.Next;
                      end;
                    Finally
                       FreeAndNil(sqlCR14);
                    End;

                  end;


               sqlCR10.Next;
           end;
        Finally
           FreeAndNil(sqlCR10);
        End;


        {*******************************************}
        {*******************************************}

//        strConteudo := strConteudo + '20';

        { Código do Subitem
        Informar apenas dígitos
        Ver Tabela 13 para valores válidos,considerando o campo
        PrópriaOuST
         Se (CódSubItem >= 00704 e CódSubItem =< 00707) e campo
        PrópriaOuST = 0, então deve haver registro(s)-filho(s) CR=25
        e campo Q25 > 0000 (ZEROS) quando Ref (CR=05) < 201005.
        Caso contrário, não deve haver CR = 25 e campo Q25 = 0000
        (ZEROS) .
         Se (CódSubItem = 00201, 00203, 00204, 00702 OU 00703) e
        campo PrópriaOuST = 0, deve haver registro (s) somente
        quando Ref (CR=05) < 201005
         Se (CódSubItem = 00220, 00221, 00740 OU 00741) e campo
        PrópriaOuST = 0, e Ref (CR=05) >= 201004 então deve haver
        registro(s)-filho(s) CR=28 e campo Q28 > 0000 (ZEROS)
         Se (CódSubItem = 00205, 00701 ou 00715) e campo
        PrópriaOuST = 0, deve haver registro(s) somente quando Ref
        (CR=05) < 201201
         Se (CódSubItem = 00287) e campo PrópriaOuST = 0, deve
        haver registro somente quando Ref (CR=05) >= 201601
         Se (CódSubItem = 00770) deve haver registro somente quando
        Ref (CR=05) >= 201602
         Se (CódSubItem = 00223, 00744 ou 00745) e campo
        PrópriaOuST = 0, e Ref (CR=05) >= 201201 então deve haver
        registro(s)-filho(s) CR=28 e campo Q28 > 0000 (ZEROS)
         Se (CódSubItem = 00224 ou 00746) e campo PrópriaOuST = 0,
        deve haver registro(s) somente quando Ref (CR=05) >= 201201
        e o campo IE (CR=05) começar com 8.
         Se (CódSubItem = 00225 ou 00747) e campo PrópriaOuST = 0,
        então deve haver registro(s)-filho(s) CR=25 e campo Q25 >
        0000 (ZEROS) quando Ref (CR=05) >= 201201.
         Se (CódSubItem = 00226 ou 00748) e campo PrópriaOuST = 0,
        então deve haver registro(s)-filho(s) CR=25 e campo Q25 >
        0000 (ZEROS) quando Ref (CR=05) >= 201301.
         Se CodSuItem - Não pode ocorrer os CodSubItens
         = 00226 - 00748
         = 00748 - 00226
         Se (CódSubItem = 00739) e campo PrópriaOuST = 0, deve
        haver registro somente quando Ref (CR=05) >= 200611
         Se (CódSubItem = 00742) e campo PrópriaOuST = 0, deve
        haver registro somente quando Ref (CR=05) >= 201001
        As regras abaixo são válidas quando Ref (CR=05) > 200112
         Se (CódSubItem = 00218 ou 00729) e campo PrópriaOuST = 0
        então deve haver apenas um registro filho CR=25.
         Se (CódSubItem = 00219 ou 00730) e campo PrópriaOuST = 0
        então deve haver registro(s)-filho(s) CR=25.
         Se CodSuItem - Não pode ocorrer os CodSubItens
         = 00218 - 00219 00729 00730
         = 00729 - 00218 00219 00730
         = 00219 - 00218 00729
         = 00730 - 00218 00729
        Os CodSubitens 00219 e 00730 podem ocorrer em conjunto
         Se (CódSubItem = 00210 ou 00211) e campo PrópriaOuST = 0
        então deve haver registro(s)-filho(s) CR=26 e campos Q26 >
         zeros.
         Se (CódSubItem = 00701 ou 00702) e campo PrópriaOuST = 1
         então deve haver registro(s)-filho(s) CR=27 e campos Q27 >
         zeros.
         Somente poderá haver repetições se CódSubItem=xxx99,
        considerando o campo PrópriaOuST.
         Classificação ascendente: CódSubItem, PrópriaOuST
         PrópriaOuST=0 e RegTrib=04 não podem ocorrer em conjunto}
       // strConteudo := strConteudo + Zero('0',5);

        {Valor   Valor associado ao subitem
          de 0.000. 000. 000. 000,01 a 9.999.999.999.999,99 exceto
          pontos e vírgulas.
          Alinhar à direita e preencher com ZEROS à esquerda.
          O valor deste campo deve ser =  (campo Valor dos CR= 25 ou
        CR=26 ou CR=27 ou CR=28), quando existirem estes registrosfilho.
        15}
       //   strConteudo := strConteudo + Zero('0',15);

        {PrópriaOuST
          Indica se a ocorrência está associada
        à Apuração do ICMS para Operações
        Próprias ou de Substituição
        Tributária
          0 – Própria
          1 – ST
          PrópriaOuST=0 e RegTrib=04 não podem ocorrer em conjunto
        01}
       //  strConteudo := strConteudo + Zero('0',1);

        {
        FLegal   Fundamentação Legal associada ao
        Subitem
          Texto sem caracteres de controle ou de formatação. Se
        CódSubItem=xxx99, preenchimento de texto obrigatório, caso
        contrário, preencher com caracteres de espaço.
        100}
       //  strConteudo := strConteudo + Zero('0',100);

        {Ocorrência   Descrição da ocorrência associada ao
        Subitem
          Texto sem caracteres de controle ou de formatação. Se
        CódSubItem=xxx99, preenchimento de texto obrigatório, caso
        contrário, preencher com caracteres ASCII 32.
        300}
      //   strConteudo := strConteudo + Zero('0',300);

        {Q25   Quantidade de registros CR = 25
          Verificar se Q25 = quantidade de registros-filhos 25
          Alinhar à direita e preencher com ZEROS à esquerda
          Deve ser igual a ZEROS se Ref < 200201
        04}
       //  strConteudo := strConteudo + Zero('0',4);

        {Q26   Quantidade de registros CR = 26
          Verificar se Q26 = quantidade de registros-filhos 26
          Alinhar à direita e preencher com ZEROS à esquerda
          Deve ser igual a ZEROS se Ref < 200201
        04}
      //   strConteudo := strConteudo + Zero('0',4);

        {Q27   Quantidade de registros CR = 27
          Verificar se Q27 = quantidade de registros-filhos 27
          Alinhar à direita e preencher com ZEROS à esquerda
          Deve ser igual a ZEROS se Ref < 200201
        04}
      //   strConteudo := strConteudo + Zero('0',4);

        {Q28   Quantidade de registros CR = 28
          Verificar se Q28 = quantidade de registros-filhos 28
          Alinhar à direita e preencher com ZEROS à esquerda
          Deve ser igual a ZEROS se Ref < 200801
        04}
      //   strConteudo := strConteudo + Zero('0',4);


      //  strConteudo := strConteudo + #13#10;
       {*******************************************}

//        strConteudo := strConteudo + '25';

        {IE   Inscrição Estadual
        Informar apenas dígitos
        Não pode haver IE em duplicidade para um dado CódSubItem
        do Registro Ocorrências CR=20
        Não pode iniciar com 8 ( Se IE’s utilizados pela GIA-STNacional).
        Exemplo: 801.999.777.112
        Classificação Ascendente.
        12}
  //      strConteudo := strConteudo + Zero('0',12);

        {Valor   Valor associado à IE
        de 0.000. 000. 000. 000,01 a 9.999.999.999.999,99 exceto
        pontos e vírgulas
        Alinhar à direita e preencher com ZEROS à esquerda 15}
 //       strConteudo := strConteudo + Zero('0',15);

  //      strConteudo := strConteudo + #13#10;
       {*******************************************}

  //      strConteudo := strConteudo + '26';

        {IESubstituto   Inscrição Estadual do Substituto
        Informar apenas dígitos  12

                  Classificação
                  Ascendente de
                  IESubstituto +
                  NF
                    Não poderá
                  haver
                  duplicidade de
                  IESubstituto +
                  NF


        strConteudo := strConteudo + '12';}
    //    strConteudo := strConteudo + Zero('0',12);

        {NF   Número da Nota Fiscal
          Informar apenas dígitos com alinhamento à
        direita. Por exemplo, se o número for 4321,
        então NF=000004321
          Se CódSubItem =00211, então NF deve ser
        igual a ZEROS.
          Se CódSubItem = 00210, então NF >
        000000000
        09}
//        strConteudo := strConteudo + Zero('0',9);


       {DataInicio   Data do início do período de
       apuração
         AAAAMM (AAAA: Ano, MM: Mês);
         Diferente de Zeros 06
       }
  //     strConteudo := strConteudo + FormatDateTime('yyyymm', dataFinal);

       {DataFim   Data final do período de
       apuração
         AAAAMM (AAAA: Ano, MM: Mês);
         Diferente de Zeros
         DataFim >= DataInicio
         DataFim <= Ref (Campo do CR=05)
       06}
  //     strConteudo := strConteudo + FormatDateTime('yyyymm', dataFinal);


       {Valor   Valor associado à IE do
       Substituto
         De 0.000. 000. 000. 000,01 a 9.999.999.999.999,99 exceto pontos e
       vírgulas
         Alinhar à direita e preencher com ZEROS à esquerda
         Se CódSubItem = 00210, este valor irá corresponder ao valor da
       NF.
         Se CódSubItem = 00211, este valor irá corresponder ao valor de
       Ressarcimento.
       15}
  //     strConteudo := strConteudo + Zero('0',15);

  //     strConteudo := strConteudo + #13#10;
        {*******************************************}

  //     strConteudo := strConteudo + '27';

       {IESubstituído   Inscrição Estadual do Substituído
         Informar apenas dígitos
         Não pode iniciar com 8 (São IE´s
       utilizadas pela GIA-ST-Nacional).
       Exemplo: 801.999.777.112 12 }
           {  Classificação
           ascendente de
           IESubstituído +
           NF.
             Não poderá haver
           duplicade de
           IESubstituído +
           NF.}
  //      strConteudo := strConteudo + Zero('0',12);

       {NF   Número da Nota Fiscal
          Informar apenas dígitos com alinhamento à direita. Por exemplo, se
        o número for 4321, então
        NF=000004321
          Se CódSubItem = 00702, então NF
        deve ser igual a ZEROS.
          Se CódSubItem = 00701, então NF >
        000000000.
        09}
  //      strConteudo := strConteudo + Zero('0',9);
        {
        Valor   Valor associado à IE do Substituído
          De 0.000. 000. 000. 000,01 a 9.999.999.999.999,99 exceto
        pontos e vírgulas
          Alinhar à direita e preencher com ZEROS à esquerda
          Se CódSubItem = 00701, este campo conterá o valor
        corresponde ao Valor da Nota Fiscal,.
          Se CódSubItem = 00702, este campo conterá o valor do
        Depósito Bancário.
        15}
  //      strConteudo := strConteudo + Zero('0',15);

  //      strConteudo := strConteudo + #13#10;
        {*******************************************}

  //      strConteudo := strConteudo + '28';

        {CodAutorizacao   Código de Autorização
          Informar apenas os 12 caracteres sem os pontos
          Não pode haver CodAutorizacao em duplicidade para um dado
        CódSubItem do Registro Ocorrências CR=28
          Classificação Ascendente.
        12
        }
  //      strConteudo := strConteudo + Zero('0',12);

        {Valor   Valor da Operação
          de 0.000. 000. 000. 000,01 a 9.999.999.999.999,99 exceto
        pontos e vírgulas
          Alinhar à direita e preencher com ZEROS à esquerda 15
        }
  //      strConteudo := strConteudo + Zero('0',15);

  //      strConteudo := strConteudo + #13#10;

        {*******************************************}



         {Transportes
         Para referência <= 200212
         Se Existe CFOP 5.61, 5.62, 5.63, 6.61, 6.62 , 6.63 ou 7.61
         Então
         X= (BaseCálculo + IsentasNãoTrib + Outras) dos CFOP´s
         5.61 e 5.62 e 5.63 e 6.61 e 6.62 e 6.63 e 7.61
         Se X > zero, Então
         Y = dos valores lançados nos Municípios para os
         CódDIP) CR=30 (DIPAM-B), com CódDIP = 2.3
         Onde Y deve ser > zero e =< X
         Fim Se
         Fim Se

         Se houver lançamento no CódDIP 2.3 Então
         X = (BaseCálculo + IsentasNãoTrib + Outras) dos CFOP´s
         5.61 e 5.62 e 5.63 e 6.61 e 6.62 e 6.63 e 7.61
         Y = dos valores lançados nos Municípios para os
         CódDIP) CR=30 (DIPAM-B), com CódDIP = 2.3
         Onde (X e Y devem ser > zero) e (Y deve ser =< X)
         Fim Se

                    Para referência > 200212
                    Se Existe CFOP (5.351 a 5.399) OU (6.351 a 6.399) OU (7.351 a
                    7.399)
                    Então
                    X= (BaseCálculo + IsentasNãoTrib + Outras) dos CFOP´s
                    (5.351 a 5.399) e (6.351 a 6.399) E (7.351 a 7.399)
                    Se X > zero, Então
                    Y = dos valores lançados nos Municípios para os
                    CódDIP) CR=30 (DIPAM-B), com CódDIP = 2.3
                     Onde Y deve ser > zero e =< X
                    Fim Se
                    Fim Se

                    Se houver lançamento no CódDIP 2.3 Então
                    X = (BaseCálculo + IsentasNãoTrib + Outras) dos CFOP´s
                    (5.351 a 5.399) e (6.351 a 6.399) E (7.351 a 7.399)
                    Y = dos valores lançados nos Municípios para os
                    CódDIP) CR=30 (DIPAM-B), com CódDIP = 2.3
                     Onde (X e Y devem ser > zero) e (Y deve ser =< X)
                    Fim Se}


         sqlCR30 := TSQLQuery.Create(Nil);
         Try
            sqlCR30.SQLConnection := DB_Conect.SQLConnection;
            sqlCR30.Close;
            sqlCR30.SQL.Clear;


            sqlCR30.SQL.Add('SELECT DISTINCT  M.CODIGO, ');
            sqlCR30.SQL.Add('		IsNull(SUM(I.VBC),0) as VICMS00   ');

            sqlCR30.SQL.Add('FROM CTE_CAPA CP  ');
            sqlCR30.SQL.Add('iNNER JOIN CTE_EMITENTE E ON E.cte_emitente_id = CP.codFornecedor  ');
            sqlCR30.SQL.Add('iNNER JOIN CTE_MUNICIPIO M ON M.CODIGOIBGE = E.CMUN  ');
            sqlCR30.SQL.Add('iNNER JOIN CTE_VPREST V ON V.CCT = CP.CCT   ');
            sqlCR30.SQL.Add('iNNER JOIN CTE_IMPOSTOS I ON I.CCT = CP.CCT  ');
            sqlCR30.SQL.Add('Where CP.Lote is null and  CP.CTE_FILIAL_ID = :CTE_Filial_ID ');
            sqlCR30.SQL.Add('  AND CP.DHEMI BETWEEN :Data1 and :Data2');
            //sqlCR30.SQL.Add(' and ((I.CFOP like ''5%'') or (I.CFOP like ''6%'') or (I.CFOP like ''7%'')) ' );
            sqlCR30.SQL.Add(' and E.UF = :UF ' );
            sqlCR30.SQL.Add(' and ((I.CFOP BETWEEN ''5351'' AND ''5399'') OR (I.CFOP BETWEEN ''6351'' AND ''6399'') ');
            sqlCR30.SQL.Add(' OR (I.CFOP BETWEEN ''7351'' AND ''7399'')) ');

            sqlCR30.SQL.Add('GROUP BY  M.CODIGO ');
            sqlCR30.ParamByName('CTE_FILIAL_ID').AsString := VarToStr(editFilial.bs_KeyValue);
            sqlCR30.ParamByName('UF').AsString            := editFilial.bs_KeyValues[3];
            sqlCR30.ParamByName('Data1').AsSQLTimeStamp   := DateTimeToSqlTimeStamp(dataInicial + StrToTime('00:00:00') );
            sqlCR30.ParamByName('Data2').AsSQLTimeStamp   := DateTimeToSqlTimeStamp(dataFinal + StrToTime('00:00:00'));
            DB_Conect.GetComando(sqlCR30,bMostraQuery);
            sqlCR30.Open;
            sqlCR30.First;
            while not sqlCR30.Eof do
            begin


               strConteudo := strConteudo + '30';

               strConteudo := strConteudo + Zero('23',2); //Transporte

               {Município   Código de um Município Paulista
               Ver Tabela 15 para valores válidos.
               Alinhar à direita com ZEROS à esquerda
               Não pode haver Município duplicado para o mesmo CódDIP
               Classificação ascendente
               Se CódDIP = 3.X, o Município deve ser = ZEROS 05}


               strConteudo := strConteudo + Zero(sqlCR30.FieldByName('CODIGO').AsString,5);


               {Valor   Valor associado ao CódDIP
               de 0.000.000. 000.000,00 a 9.999.999.999.999,99 exceto
               pontos e vírgulas
               Alinhar à direita e preencher com ZEROS à esquerda 15}
               strConteudo := strConteudo + Zero(StrTran(StrTran(FloatToStrF(sqlCR30.FieldByName('VICMS00').AsFloat, ffCurrency,18,2),',',''),'.',''),15);

               strConteudo := strConteudo + #13#10;

               sqlCR30.Next;
            end;


         Finally
            FreeAndNil(sqlCR30);
         End;


         {*******************************************}


       // strConteudo := strConteudo + '31';

        {RE   Registro de Exportação
        As 10 posições à direita devem ser diferente de zeros
        Informar apenas dígitos.
        Classificação ascendente.
        Não pode haver duplicidade.
        Alinhamento à direita com ZEROS à esquerda. Por exemplo,
        se o número da RE fosse 12/3456789012, então, esse campo
        deve ser preenchido da seguinte forma: 000123456789012 15}
        //strConteudo := strConteudo + Zero('000123456789012',15);

        //strConteudo := strConteudo + #13#10;
        {*******************************************}

        Write(ArquivoTexto, strConteudo);

        finally
           CloseFile(ArquivoTexto);
        end;

        sqlAux.Close;
        sqlAux.SQL.Clear;
        sqlAux.SQL.Add('Insert into CTE_SALDOCREDOR ');
        sqlAux.SQL.Add('(CTE_FILIAL_ID , ARQUIVO ,  PERIODO , SaldoFinal) VALUES  ');
        sqlAux.SQL.Add(' (:CTE_FILIAL_ID , :ARQUIVO ,  :PERIODO , :SaldoFinal) ');
        sqlAux.ParamByName('CTE_FILIAL_ID').AsString := VarToStr(editFilial.bs_KeyValue);
        sqlAux.ParamByName('ARQUIVO').AsString       := pArquivo;
        sqlAux.ParamByName('PERIODO').AsString       := mskperiodo.Text;
        sqlAux.ParamByName('SaldoFinal').AsFloat     := fSaldoCredor;
        try
          sqlAux.ExecSQL;
        except
          Mens_MensErro('Erro ao Gravar Saldo Credor');
        end;

        sqlAux.Close;
        sqlAux.SQL.Clear;
        sqlAux.SQL.Add('UPDATE CTE_CAPA ');
        sqlAux.SQL.Add('SET LOTE = :Arquivo ');
        sqlAux.SQL.Add('WHERE CTE_CAPA_ID IN (SELECT CP.CTE_CAPA_ID  ');
        sqlAux.SQL.Add('FROM CTE_CAPA CP ');
        sqlAux.SQL.Add('INNER JOIN CTE_IMPOSTOS I ON I.CCT = CP.CCT ');
        sqlAux.SQL.Add('WHERE  CP.CTE_FILIAL_ID = :CTE_Filial_ID ');
        sqlAux.SQL.Add('  AND CP.DHEMI BETWEEN :Data1 and :Data2');
        sqlAux.SQL.Add(' and ((I.CFOP like ''5%'') or (I.CFOP like ''6%'') or (I.CFOP like ''7%''))) ' );
        sqlAux.ParamByName('CTE_FILIAL_ID').AsString := VarToStr(editFilial.bs_KeyValue);
        sqlAux.ParamByName('Data1').asString     := formatdatetime('dd/mm/yyyy  00:00:00', dataInicial);
        sqlAux.ParamByName('Data2').asString     := formatdatetime('dd/mm/yyyy  00:00:00', dataFinal);
        sqlAux.ParamByName('Arquivo').asString   := pArquivo;
        try
          sqlAux.ExecSQL;
        except
          Mens_MensErro('Erro ao Fechar Lote de Arquivos');
        end;


        AtualizaGridGIA;

    Finally
      FreeAndNil(sqlAux);
    End;

  AguardandoProcesso(frmGerador, False);

end;

procedure TfrmGerador.ButEscapeClick(Sender: TObject);
begin
  inherited;
  mskperiodo.Enabled := true;
  btnProcessar.Enabled := true;
  editSaldoCredorAnterior.Enabled := true;

  editFilial.Text := '';
  editFilial.bs_KeyValues.Clear;
  editArquivo.Clear;
  mskperiodo.Clear;
  mskperiodo.EditMask := '!99/0000;1;_';
  cmbRegime.ItemIndex := -1;
  cmbTipoGia.ItemIndex := -1;
  EditPorSaidasPrestacoes.Clear;
  editOutrosDebito.Clear;
  editEstornoCredito.Clear;
  editTotalDebito.Clear;
  editPorEntradasAqui.Clear;
  editOutrosCreditos.Clear;
  editEstornoDebitos.Clear;
  editSubTotal.Clear;
  editSaldoCredorAnterior.Clear;
  EditTotalCredito.Clear;
  editSaldoDevedor.Clear;
  editDeducoes.Clear;
  EditImpostoRecolher.Clear;
  editSaldoCredorSeguinte.Clear;
  editFilial.SetFocus;

end;

procedure TfrmGerador.ButExcluirItemClick(Sender: TObject);
Var
 i, iCTE_SALDOCREDOR_ID, ARowIndex : integer;
 ARowInfo        : TcxRowInfo;
 pArquivo        : String;
 sqlAux          : TSQLQuery;
begin
  inherited;
  pArquivo            := '';
  iCTE_SALDOCREDOR_ID := -1;

  if cxGrid1DBTableView.DataController.GetSelectedCount = 0 then
  begin
    Mens_MensInf('Selecione ao menos 1 GIA Para Continuar !');
    Exit;
  end;

  if cxGrid1DBTableView.DataController.GetSelectedCount > 1 then
  begin
    Mens_MensInf('Permitido selecionar somente 1 GIA por vez !');
    Exit;
  end;

  with cxGrid1DBTableView.DataController do
  begin
      for i := 0 to Pred(GetSelectedCount) do
      begin
        ARowIndex := GetSelectedRowIndex(i);
        ARowInfo  := GetRowInfo(ARowIndex);

        pArquivo            := VarToStr(Values[ARowInfo.RecordIndex, cxGrid1DBTableViewARQUIVO.index]);
        iCTE_SALDOCREDOR_ID := Values[ARowInfo.RecordIndex, cxGrid1DBTableViewCTE_SALDOCREDOR_ID.index];
      end;
  end;

  if pArquivo <> '' then
  begin
    If ( Mens_MensConf('Confirma Geração da GIA ' + pArquivo + '?') = mrOk ) Then
    begin
       sqlAux := TSQLQuery.Create(Nil);
       Try
           sqlAux.SQLConnection := DB_Conect.SQLConnection;
           sqlAux.Close;
           sqlAux.SQL.Clear;
           sqlAux.SQL.Add('  UPDATE CTE_CAPA SET LOTE = NULL WHERE LOTE = :Lote');
           sqlAux.ParamByName('Lote').AsString :=  pArquivo;
           Try
              sqlAux.ExecSQL;
              AtualizaGridGIA;
           except
              Mens_MensErro('Erro ao apagar Arquivo');
           End;


           sqlAux.Close;
           sqlAux.SQL.Clear;
           sqlAux.SQL.Add('Delete from CTE_SALDOCREDOR Where CTE_SALDOCREDOR_ID = :CTE_SALDOCREDOR_ID');
           sqlAux.ParamByName('CTE_SALDOCREDOR_ID').AsInteger :=  iCTE_SALDOCREDOR_ID;
           Try
              sqlAux.ExecSQL;
              AtualizaGridGIA;
           except
              Mens_MensErro('Erro ao apagar Arquivo');
           End;

       Finally
          FreeAndNil(sqlAux);
       End;

    end;
  end;
end;

procedure  TfrmGerador.AtualizaGridGIA;
begin
   cdsGrid.Close;
   cdsGrid.Params.ParamByName('CTE_FILIAL_ID').AsString := VarToStr(editFilial.bs_KeyValue);
   cdsGrid.Open;
end;

procedure TfrmGerador.ButImprimirClick(Sender: TObject);
var
 xArquivo : String;
begin
  inherited;
  if (editFilial.Text = '') then
  begin
    Mens_MensInf('Informe uma Filial para abrir a GIA');
    exit;
  end;

  if (editFilial.bs_KeyValues[6] = '') then
  begin
      Mens_MensInf('Falta informar o caminho para salvar o arquivo da GIA (TXT). Verifique no cadastro da Filial');
      Exit;
  end;

  if (editArquivo.Text <> '') then
    xArquivo := editArquivo.Text
  else
  begin
    OpenTextFileDialog.Title := 'Selecione a GIA';
    OpenTextFileDialog.DefaultExt := '*.TXT';
    OpenTextFileDialog.Filter := 'Arquivos TXT (*.TXT)';
    OpenTextFileDialog.InitialDir := editFilial.bs_KeyValues[6];
    if OpenTextFileDialog.Execute Then
        xArquivo := (OpenTextFileDialog.FileName)
  end;

  if (xArquivo <> '') then
  begin
     frmVisualizarTexto:=TfrmVisualizarTexto.Create(Self);
     frmVisualizarTexto.mmVisualizar.Clear;
     frmVisualizarTexto.pnTitulo.Caption :=  xArquivo;
     frmVisualizarTexto.mmVisualizar.Lines.LoadFromFile(xArquivo);
     frmVisualizarTexto.Show;
  end;
end;

procedure TfrmGerador.editEstornoDebitosExit(Sender: TObject);
begin
  inherited;
  editSubTotal.AsDouble := editPorEntradasAqui.AsDouble + editOutrosCreditos.AsDouble + editEstornoDebitos.AsDouble;
  EditTotalCredito.AsDouble := editSubTotal.AsDouble + editSaldoCredorAnterior.AsDouble;
end;

procedure TfrmGerador.editFilialExit(Sender: TObject);
Var
 sqlSaldo : TSQLQuery;
 xAno, xMes : String;
begin
  inherited;
  mskperiodo.Enabled := true;
  editSaldoCredorAnterior.Enabled := true;
  if (editFilial.Text <> '') then
  begin
     sqlSaldo := TSQLQuery.Create(Nil);
     Try
        sqlSaldo.SQLConnection := DB_Conect.SQLConnection;
        sqlSaldo.Close;
        sqlSaldo.SQL.Clear;
        sqlSaldo.SQL.Add('Select  isnull(saldo,0) as saldo, periodo from cte_filial ');
        sqlSaldo.SQL.Add('where cte_filial_id not in (select cte_filial_id from cte_saldocredor) ');
        sqlSaldo.SQL.Add('and cte_filial_id = :cte_filial_id ');
        sqlSaldo.ParamByName('cte_filial_id').AsString := VarToStr(editFilial.bs_KeyValue);
        sqlSaldo.Open;
        if not sqlSaldo.IsEmpty then
        begin

           editSaldoCredorAnterior.AsDouble := sqlSaldo.FieldByName('saldo').AsFloat;
           editSaldoCredorAnterior.Enabled := false;
           xMes := Copy(sqlSaldo.FieldByName('periodo').AsString,1,2);
           xAno := Copy(sqlSaldo.FieldByName('periodo').AsString,4,4);

           if (xMes = '12') then
           begin
             xAno := IntToStr(StrToInt(xAno)+1);
             xMes := Zero('1',2);
           end
           else
           begin
             xMes := Zero(IntToStr(StrToInt(xMes)+1),2);
           end;

           mskperiodo.Text    := xMes + '/' + xAno;
           mskperiodo.Enabled := False;
        end;

     Finally
        FreeAndNil(sqlSaldo);
     End;
     AtualizaGridGIA;

  end;
end;

procedure TfrmGerador.editOutrosDebitoExit(Sender: TObject);
begin
  inherited;
  editTotalDebito.AsDouble := EditPorSaidasPrestacoes.AsDouble + editOutrosDebito.AsDouble + editEstornoCredito.AsDouble;
end;

procedure TfrmGerador.FormCreate(Sender: TObject);
begin
 // FormOperacao := 'MAN_ORCAMENTO' ;
  inherited;

end;

procedure TfrmGerador.FormShow(Sender: TObject);
begin
  inherited;
  SetParametros(EditFilial, TipoFilial);
  Page.ActivePage := tabValores;
  WindowState := wsMaximized;
end;

procedure TfrmGerador.mskperiodoExit(Sender: TObject);
var
 sqlApuracao : TSQLQuery;
 xAno, xMes : Integer;
 yAno, yMes : Integer;
 dDataBanco, dDataTela : TDateTime;
begin
  inherited;
   btnProcessar.Enabled := True;
    editSaldoCredorAnterior.Enabled := True;
   if (mskperiodo.Text <> '  /    ') then
   begin
     sqlApuracao := TSQLQuery.Create(Nil);
     Try
        sqlApuracao.SQLConnection := DB_Conect.SQLConnection;
        sqlApuracao.Close;
        sqlApuracao.SQL.Clear;
        sqlApuracao.SQL.Add('Select Top 1 periodo, isnull(saldofinal,0) as saldofinal From CTE_SALDOCREDOR');
        sqlApuracao.SQL.Add('Where cte_filial_id = :cte_filial_id ');
        sqlApuracao.SQL.Add(' Order by cte_saldocredor_id desc');
        sqlApuracao.ParamByName('cte_filial_id').AsString := VarToStr(editFilial.bs_KeyValue);
        sqlApuracao.Open;
        if not sqlApuracao.IsEmpty then
        begin
           xMes := StrToInt(Copy(Trim(mskperiodo.Text),1,2));
           xAno := StrToInt(Copy(Trim(mskperiodo.Text),4,4));
           dDataTela := StrToDate('01/' + IntToStr(xMes) + '/' + IntToStr(xAno));

           yMes := StrToInt(Copy(Trim(sqlApuracao.FieldByName('periodo').AsString),1,2));
           yAno := StrToInt(Copy(Trim(sqlApuracao.FieldByName('periodo').AsString),4,4));
           dDataBanco   := StrToDate('01/' + IntToStr(yMes) + '/' + IntToStr(yAno));

           if (dDataTela <= dDataBanco) then
           begin
             Mens_MensInf('Periodo já processado para esta filial');
             mskperiodo.Clear;
             mskperiodo.EditMask := '!99/0000;1;_';
             mskperiodo.SetFocus;
             btnProcessar.Enabled := False;
           end
           else
           begin
              editSaldoCredorAnterior.AsDouble := sqlApuracao.FieldByName('saldofinal').AsFloat;
              editSaldoCredorAnterior.Enabled := False;
           end;
        end;
     Finally
        FreeAndNil(sqlApuracao);
     End;
   end;
end;

procedure TfrmGerador.PageChange(Sender: TObject);
begin
  inherited;

  if (Page.ActivePage =  tabGIA) then
  begin
     if ((editFilial.Text <> '') and ( editFilial.bs_KeyValues.Count > 0)) then
     begin
       AtualizaGridGIA
     end;
  end;

end;

end.



