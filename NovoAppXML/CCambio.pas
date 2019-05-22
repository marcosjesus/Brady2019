unit CCambio ;

interface

Uses
     SysUtils, Windows, DB, DBTables, Classes, SqlTableFun, StdCtrls, Constantes, DBConect, FMTBcd, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

Const

   DBTYPE_PARADOX      = 1 ;
   DBTYPE_SQLSERVER_65 = 2 ;
   DBTYPE_ACCESS       = 3 ;
   DBTYPE_SQLSERVER_70 = 4 ;

Type TCambio = Class(TComponent)
       Private
           FTable : TSQLTableClass ;
           FQuery : TFDQuery ;
           FDBType : Integer ;
           FDBName : String ;
           FSql : String ;
           Procedure SetMensErro ( pMens : String ) ;
       Public
           VarMoeda : String ;
           Eof : Boolean ;
           Error : Boolean ;
           MensErro : String ;
           OpeID : Integer ;
           Data : TDateTime ;
           DtLiqMoeda : TDateTime ;
           DtLiqMoedaEst: TDateTime ;
           Cliente : String[15] ;
           FormaEntr : String[2] ;
           TipoOpe : String[1] ;
           Valor : Double ;
           Qtde : Double ;
           Taxa : Double ;
           Conta : String[15] ;
           NatOperacao : String[16] ;
           FornecCredor : String[15] ;
           Comissionado : String[15] ;
           BancoOperador : String[15] ;
           TaxaOperada: Double;
           NumLanc : String ;
           Tipo : String ;
           Forma : String ;
           Mercado : String ;
           Posicao : String ;
           Status : String[1] ;
           Quitado : String[1] ;
           Obs, pOpcaoBR : String ;
           Filial : String[18] ;
           Carga : String[1] ;
           CodUsuario : String[10] ;
           DocOrigem, DocDestino : String ;
           Banco, Agencia, Nome : String ;
           CodCenCusto : String ;
           PaiID, NParcela, Parcela : Integer ;
           PaiTipo : String ;
           EmiteAviso, EmiteCheque : String[1] ;
           Ok : String[1] ;
           StatusFac : String[1] ;
           Indice : Integer ;
           // Lista das pend�ncias em US
           QPendUS : TFDQuery ;
           // Lista das pend�ncias em BR
           QPendBR : TFDQuery ;
           Constructor Create ( DBType : Integer = -1 ; DBName : String = '' ) ; reintroduce ;
           Destructor Destroy ; reintroduce ;
           Function BeginTrans : Boolean ;
           Function ExecCommit : Boolean ;
           Function ExecRollBack : Boolean ;
           Function BoaTaxa ( pTaxa, pMedia : Double ) : Boolean ;
           Function CalcMed ( pOpcao, pMoeda : String ) : Double ;
           Function ValorDiaBanco ( pConta : String ; pData : TDateTime ; pValor : Double ) : Boolean ;
           Function GetValorDiaBanco ( pConta : String ; pData : TDateTime ) : Double ;
           Function InsNovoLanc ( pData : TDateTime ) : Boolean ;
           Function GetValContaCor ( pConta : String ; pData : TDateTime ; Var ValIni : Double ; Var ValFim : Double ) : Boolean ;
           Function GetValContaCorFilial ( pCodFilial : String ; pConta : String ; pData : TDateTime ; Var ValIni : Double ; Var ValFim : Double ) : Boolean ;
           Function GetValContaCorOM ( pConta : String ; pData : TDateTime ; Var ValIni : Double ; Var ValFim : Double ) : Boolean ;
           Function GetValContaCorOMSPr ( pConta : String ; pData : TDateTime ; Var ValIni : Double ; Var ValFim : Double ) : Boolean ;
           Function GetValContaCorOMSldCli ( pMoeda, pCliente : String ; Var ValFim : Double ) : Boolean ;
           Function UpdPendMoedaOM ( pValor : Double ; pCliente, pMoeda: String): Boolean ;
           Function UpdSaldoConta ( pConta : String ; pData : TDateTime ;
                                    pValor : Double ; pPaiTipo : String ; pObs : String ;
                                    pCliente : String = '' ; pInsMov : Boolean = true ; pUsuario : String = '') : Boolean ;
           Function InsComVen ( pOpcao : Char ) : Boolean ;
           Function UpdComVen ( pOpcao : Char ; pID : Integer = -1 ) : Boolean ;
           Function DelComVen ( pOpcao : String ; pID : Integer = -1 ; CodMoeda: String = ''; psObs : String = 'Exclus�o' ) : Boolean ;
           Function UpdContaUS ( pValor : Double ; pPaiTipo : String ; pObs : String ) : Boolean ;
           Function UpdContaBR ( pValor : Double ; pPaiTipo : String ; pObs : String ) : Boolean ;
           Function UpdContaCB ( pValor : Double ; pPaiTipo : String ; pObs : String ) : Boolean ;
           Function DelPendBR ( pID : Integer ) : Boolean ;
           Function InsPendUS : Boolean ;
           Function InsPendOM : Boolean ;
           Function InsPendBR ( pPaiTipo : String ; pObs : String = '' ; pUpdConta : Boolean = True ) : Boolean ;
           Function UpdPendBR ( pID : Integer ; pTipoOpe : String ; pPaiTipo : String ; pObs : String ) : Boolean ;
           Function UpdPendUS ( pID : Integer = -1 ) : Boolean ;
           Function DelPendUS ( pID : Integer ; pPaiTipo : String ; pObs : String = '' ) : Boolean ;
           Function DelPendBRByPaiID ( pID : Integer ; pPaiTipo : String ; pObs : String = '' ) : Boolean ;
           Function GetPendUS ( pID : Integer = -1 ; pTipoOpe : String = PEND_PLANILHA ) : Boolean ;
           Function GetPendBR ( pID : Integer = -1 ; pTipoOpe : String = PEND_PLANILHA ) : Boolean ;
           Function UpdSaldoCli ( pTipo : String ; pStatus : String ; pPaiId : Integer ;
                                  pPaiTipo : String ; pUS_CB : String = '' ;
                                  pCodCli : String = '' ; pQtde : Double = 0 ;
                                  pValor : Double = 0 ; pObs : String = '' ) : Boolean ;
           Function UpdSaldoCliQuit ( pTipo : String ; pStatus : String ; pPaiId : Integer ;
                                  pPaiTipo : String ; pUS_CB : String = '' ;
                                  pCodCli : String = '' ; pQtde : Double = 0 ;
                                  pValor : Double = 0 ; pObs : String = '' ) : Boolean ;
           Function UpdLucroCli ( pCodCli : String ; pValor : Double ) : Boolean ;
           Function InsMovCliente ( pData : TDateTime ; pCodCliente : String ;
                                    pMoeda : String ; pValor : Double ; pObs : String ;
                                    pTipo : String ; pPaiId : Integer ;
                                    pPaiTipo : String ; pStatus : String = ' ' ) : Boolean ;
           Function InsMovCorrente ( pConta : String ; pData : TDateTime ;
                                     pValor : Double ; pPaiTipo : String ; pObs : String = '' ;
                                     pCliente : String = '' ; pUsuario : String = '') : Boolean ;
           Function DelMovCorrente ( pPai : LongInt ; pPaiTipo : String ; pObs : String ) : Boolean ;
           Function GetSaldoCli ( pCodCli : String ; pMoeda : String ) : Double ;
           Function QuitarPendBR ( pPendId : LongInt ; pObs : String ) : Boolean ;
           Function QuitarPendUS ( pPendId : LongInt ; pObs : String ) : Boolean ;
           Function QuitarPend ( pTipo : String ; pPendId : LongInt ; pObs : String ) : Boolean ;
           Function QuitarPendBRByOpe ( pOpeId : LongInt ; pObs : String ) : Boolean ;
           Function QuitarPendUSByOpe ( pOpeId : LongInt ; pObs : String ) : Boolean ;
           Function SetPosBR ( pPendID : LongInt ; pObs : String = '' ; pPosicao : String = '' ) : Boolean ;
           Function SetFormaBR ( pPendID : LongInt ; pForma : String ) : Boolean ;
           Function SetPosVen ( pOpeId : LongInt ; pPosicao : String = '' ) : Boolean ;
           Function SetPosCom ( pOpeId : LongInt ; pPosicao : String = '' ) : Boolean ;
           Function UpdCliBR ( pCliente : String ; pValor : Double ; pPaiId : Integer ;
                               pPaiTipo : String ; pObs : String = '' ) : Boolean ;
           Function InsMovUpdSaldo : Boolean ;
           Function CancQuitBR ( pOpeId : LongInt ) : Boolean ;
           Function SeekGet ( pColGet : String ; pTableName : String ; pColName : String ; pValue : Variant ; pTipo : Integer ) : String ;
           Function SetQuitado(psTipo : String ; pOpeId : LongInt ) : Boolean ;
           Function SumMovByData ( pConta : String ; pData : TDateTime ) : Double ;
           Function TransfPendBR ( pNewDate : TDateTime ) : Boolean ;
           Function GetNextBol : LongInt ;
           Function LimiteOK ( pCliente : String ; pValor : Double; var Limite : Double; var Disponivel : Double  ) : Boolean ;
           Function UpdLimCli ( pCliente : String ; pValor : Double ) : Boolean ;
           Function UpdLimCliPend ( pCliente : String ; pValor : Double ) : Boolean ;
           Function DelComVenEsp ( pOpcao : String ; pID : Integer ) : Boolean ;
           Function SeekCliBan ( pCliente : String ) : Boolean ;
           Function InsNovaConta ( pCodigo : String ) : Boolean ;
           Function UpdNovaConta ( pCodigo : String ; pNome : String ; pAgencia : String ; pNomeConta : String ) : Boolean ;
           Function UpdBordQuitPagar ( pLanc : Integer ) : Boolean ;
           Function UpdBancoCli ( pCodigo, pBanco, pAgencia, pConta, pNome : String ) : Boolean ;
           Function UpdMovCliPaiID ( OldPaiID, NewPaiID : Longint ) : Boolean ;
           Function InsConPagRec(Tipo : String; Status : String; Par_Valor : Double) : Boolean;
           Function GetLimiteCliNovo : Double ;
           Function AtualizaSaldo(CodConta : String) : Boolean;

           Function UpdEstoque ( pCodProduto : String ; pCodGrupo : String; pData : TDateTime ;
                                    pQtde : Double ; pTipoMov : String ;
                                    pCodCenEstoque : String; pCodFilial : String;
                                    pInsMov : Boolean = true) : Boolean ;

           Function InsMovEstoque ( pCodProduto : String; pCodGrupo : String; pData : TDateTime ;
                                     pQtde : Double ; pTipoMov : String ;
                                     pCodCenEstoque : String; pCodFilial : String; pObs : String = '') : Boolean ;




End ;

implementation

Uses
   Global, TestFun, StrFun, NumFun, MensFun, DateFun, ObjFun ;

Const
   ERROR_OK        = 0 ;
   ERROR_QUERY     = 1 ;
   ERROR_EOF       = 2 ;
   ERROR_SALDOANT  = 3 ;
   ERROR_CHECK     = 4 ;

(* ------------------------------------------------------------------------- *
 * Create -> Cria a vari�vel                                                 *
(* ------------------------------------------------------------------------- *)
Constructor TCambio.Create ( DBType : Integer = -1 ; DBName : String = '' ) ;
Begin
   If ( DBType = -1 ) Then
   Begin
       FDBType := SqlTable_GetDBType() ;
       FDBName := SqlTable_GetDBName() ;
   End
   Else Begin
       FDBType := DBType ;
       FDBName := DBName ;
   End ;
   FTable := TSQLTableClass.Create ;
   FTable.OpenTable('SaldosBancarios') ;
   FTable.SetFieldKey('CodFilial;CodConta;Data') ;
   FQuery := TFDQuery.Create(Self) ;
   FQuery.Connection := DB_Conect.FDConnection ;
//   FQuery.DatabaseName := FDBName ;
   QPendUS := TFDQuery.Create(Self) ;
   QPendUS.Connection := DB_Conect.FDConnection ;
//   QPendUS.DatabaseName := FDBName ;
   QPendBR := TFDQuery.Create(Self) ;
   QPendBR.Connection := DB_Conect.FDConnection ;
//   QPendBR.DatabaseName := FDBName ;
End ;

(* ------------------------------------------------------------------------- *
 * Destroy -> Destroi a vari�vel                                             *
(* ------------------------------------------------------------------------- *)
Destructor TCambio.Destroy ;
Begin
   FQuery.Close ;
   QPendUS.Close ;
   QPendBR.Close ;
   FTable.Destroy ;
End ;

Function TCambio.BeginTrans : Boolean ;
Begin
   Result := FTable.BeginTrans() ;
End ;
Function TCambio.ExecCommit : Boolean ;
Begin
   Result := FTable.ExecCommit() ;
End ;
Function TCambio.ExecRollBack : Boolean ;
Begin
   Result := FTable.GetExecSql('RollBack') ;
End ;

Procedure TCambio.SetMensErro ( pMens : String ) ;
Begin
   MensErro := pMens  ;
   If ( pMens = '' ) Then
      Error := False
   Else
      Error := True ;
End ;

(* ------------------------------------------------------------------------- *
 * SumMovByData -> Soma os movimentos de uma conta corrente na data            *
(* ------------------------------------------------------------------------- *)
Function TCambio.SumMovByData ( pConta : String ; pData : TDateTime ) : Double ;
Var
   nDeb, nCre : Double ;
Begin

   Result := -9999999999 ;

   // -- Debitos
   FSql := 'Select Sum(Valor) From MovCorrente Where  ' +
           'CodConta = :Par_Conta And DtMov = :Par_Data And TipMov = ''D''' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(FSql) ;
   //FQuery.ParamByName('Par_Filial').AsString := GFilial ;
   FQuery.ParamByName('Par_Conta').AsString  := pConta ;
   FQuery.ParamByName('Par_Data').AsDateTime := pData ;
   Try
      FQuery.Open ;
   Except
      On E:Exception Do
      Begin
         SetMensErro(E.Message) ;
         Exit ;
      End ;
   End;
   nDeb := FQuery.Fields[0].AsFloat ;

   // -- Cr�ditos
   FSql := 'Select Sum(Valor) From MovCorrente Where  ' +
           'CodConta = :Par_Conta And DtMov = :Par_Data And TipMov = ''C''' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(FSql) ;
   //FQuery.ParamByName('Par_Filial').AsString := GFilial ;
   FQuery.ParamByName('Par_Conta').AsString  := pConta ;
   FQuery.ParamByName('Par_Data').AsDateTime := pData ;
   Try
      FQuery.Open ;
   Except
      On E:Exception Do
      Begin
         SetMensErro(E.Message) ;
         Exit ;
      End ;
   End;
   nCre := FQuery.Fields[0].AsFloat ;

   SetMensErro('') ;
   Result := nCre - nDeb ;

End ;

(* ------------------------------------------------------------------------- *
 * ValorDiaBanco -> Inclui um valor na tabela SaldosBancarios                *
(* ------------------------------------------------------------------------- *)
Function TCambio.ValorDiaBanco ( pConta : String ; pData : TDateTime ; pValor : Double ) : Boolean ;
Var
   Sql, Filial : String ;
   nSumData : Double ;
   bInsert : Boolean ;
Begin
   Result := False ;
   nSumData := 0 ;

   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add('select codfilial from contacor where codconta = :CodConta') ;
   FQuery.ParamByName('CodConta').AsString  := pConta ;
   Try
       FQuery.Open ;
       Filial := FQuery.FieldByName('codFilial').AsString;
       FQuery.Close ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   End ;

   //Sql := 'Select * From SaldosBancarios Where CodFilial = :Par_Filial And ' +
   Sql := 'Select * From SaldosBancarios Where ' +
          'CodConta = :Par_Conta And Data = :Par_Data' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   //FQuery.ParamByName('Par_Filial').AsString := GFilial ;
//   FQuery.ParamByName('Par_Filial').AsString :=  ;
   FQuery.ParamByName('Par_Conta').AsString  := pConta ;
   FQuery.ParamByName('Par_Data').AsDateTime := pData ;
   Try
       FQuery.Open ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   End ;
   If ( FQuery.Eof ) Then
   Begin
      Sql := 'Insert Into SaldosBancarios ( CodFilial, CodConta, Data, ValorInicial, ValorFinal ) ' +
             'Values ( :Par_Filial, :Par_Conta, :Par_Data, :Par_Valor, :Par_Valor )' ;
      bInsert := True ;
   End
   Else Begin
      nSumData := SumMovByData(pConta,pData) ;
      If ( Error ) Then
         Exit ;

      if (pConta <> 'AC') and (pConta <> '*CXUS') then
          Sql := 'Update SaldosBancarios Set ValorInicial = :Par_Valor, ' +
                 'ValorFinal = :Par_Final Where CodFilial = :Par_Filial And ' +
                 'CodConta = :Par_Conta And Data = :Par_Data'
      else
          begin
            Result := true;
            Exit;
          end;

      bInsert := False ;
   End ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;

   FQuery.ParamByName('Par_Filial').AsString := Filial ;
   FQuery.ParamByName('Par_Conta').AsString  := pConta ;
   FQuery.ParamByName('Par_Data').AsDateTime := pData ;
   FQuery.ParamByName('Par_Valor').AsFloat   := pValor ;
   If ( Not bInsert ) Then
      FQuery.ParamByName('Par_Final').AsFloat := pValor + nSumData ;
   Try
       FQuery.ExecSql ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   End ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * GetValorDiaBanco -> Devolve o valor para a conta na data                  *
(* ------------------------------------------------------------------------- *)
Function TCambio.GetValorDiaBanco ( pConta : String ; pData : TDateTime ) : Double ;
Begin
   Result := -1 ;
   FSql := 'Select ValorInicial From SaldosBancarios Where  ' +
          'CodConta = :Par_Conta And Data = :Par_Data' ;

   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(FSql) ;
   FQuery.ParamByName('Par_Conta').AsString  := PConta ;
   FQuery.ParamByName('Par_Data').AsDateTime := pData ;
   Try
       FQuery.Open ;
   Except
       on E: Exception do
       Begin
           SetMensErro(E.Message) ;
           Exit ;
       End ;
   End ;
   If ( FQuery.Eof ) Then
   Begin
      SetMensErro('Conta/Data n�o apresenta saldo banc�rio') ;
      Exit ;
   End ;
   Result := FQuery.FieldByName('ValorInicial').AsFloat ;
End ;

(* ------------------------------------------------------------------------- *
 * InsNovosLanc -> Insere um novo registro de lan�amentos                    *
(* ------------------------------------------------------------------------- *)
Function TCambio.InsNovoLanc ( pData : TDateTime ) : Boolean ;
Var
   Sql : String ;
Begin
   Result := False ;
   Sql := 'Select * From NumLancamentos Where CodFilial = :Par_Filial And ' +
          'Data = :Par_Data' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_Filial').AsString := GFilial ;
   FQuery.ParamByName('Par_Data').AsDateTime := pData ;
   Try
       FQuery.ExecSql ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   End ;
   If ( Not FQuery.Eof ) Then
   Begin
      Result := True ;
      Exit ;
   End ;
   Sql := 'Insert Into NumLancamentos ( CodFilial, Data, NumCompra, NumVenda, ' +
          'NumMov, NumLanc, NumBR, NumUS ) Values ( :Par_Filial, :Par_Data, ' +
          '0, 0, 0, 0, 0, 0 )' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_Filial').AsString := GFilial ;
   FQuery.ParamByName('Par_Data').AsDateTime := pData ;
   Try
       FQuery.ExecSql ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   End ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * GetValContaCor -> Devolve o valor inicial de uma conta corrente           *
(* ------------------------------------------------------------------------- *)
Function TCambio.GetValContaCor ( pConta : String ; pData : TDateTime ;
                                  Var ValIni : Double ; Var ValFim : Double ) : Boolean ;
Var
   Sql : String ;
Begin
   Result := False ;
   if pConta = '*FACTOR*' then
      Sql := 'Select ValorInicial, ValorFinal From SaldosBancarios Where  ' +
             'CodConta = :Par_Conta And Data = :Par_Data'
   else
//      Sql := 'Select ValorInicial, ValorFinal From SaldosBancarios Where CodFilial = :Par_Filial And ' +
      Sql := 'Select ValorInicial, ValorFinal From SaldosBancarios Where  ' +
             'CodConta = :Par_Conta And Data = :Par_Data';

   if not Assigned(FTable.QResult) then begin
      FTable.QResult := TFDQuery.Create(Self) ;
      FQuery.Connection := DB_Conect.FDConnection ;
//      FQuery.DatabaseName := FDBName ;
   end;

   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   //if pConta <> '*FACTOR*' then FQuery.ParamByName('Par_Filial').AsString := GFilial ;
   FQuery.ParamByName('Par_Conta').AsString  := pConta ;
   FQuery.ParamByName('Par_Data').AsDateTime := pData ;
   Try
       FQuery.Open ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   End ;
   If ( FQuery.Eof ) Then
      Exit ;
   ValIni := FQuery.FieldByName('ValorInicial').AsFloat ;
   ValFim := FQuery.FieldByName('ValorFinal').AsFloat ;
   Result := True ;
   FQuery.Close ;
End ;

(* ------------------------------------------------------------------------- *
 * GetValContaCorFilial -> Devolve o valor inicial de uma conta corrente           *
(* ------------------------------------------------------------------------- *)
Function TCambio.GetValContaCorFilial ( pCodFilial: String ; pConta : String ; pData : TDateTime ;
                                      Var ValIni : Double ; Var ValFim : Double ) : Boolean ;
Var
   Sql : String ;
Begin
   Result := False ;
   if pConta = '*FACTOR*' then
      Sql := 'Select ValorInicial, ValorFinal From SaldosBancarios Where  ' +
             'CodFilial in ' + pCodFilial + ' And CodConta = :Par_Conta And Data = :Par_Data'
   else
//      Sql := 'Select ValorInicial, ValorFinal From SaldosBancarios Where CodFilial = :Par_Filial And ' +
      Sql := 'Select ValorInicial, ValorFinal From SaldosBancarios Where  ' +
             'CodFilial in ' + pCodFilial + ' And CodConta = :Par_Conta And Data = :Par_Data';

   if not Assigned(FTable.QResult) then begin
      FTable.QResult := TFDQuery.Create(Self) ;
      FQuery.Connection := DB_Conect.FDConnection ;
   //   FQuery.DatabaseName := FDBName ;
   end;

   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   //if pConta <> '*FACTOR*' then FQuery.ParamByName('Par_Filial').AsString := GFilial ;
   //FQuery.ParamByName('Par_CodFilial').AsString  := pCodFilial ;
   FQuery.ParamByName('Par_Conta').AsString  := pConta ;
   FQuery.ParamByName('Par_Data').AsDateTime := pData ;
   Try
       FQuery.Open ;
   Except
       on E: Exception do
       Begin
           Raise;
           MensErro := E.Message ;
           Exit ;
       End ;
   End ;
   If ( FQuery.Eof ) Then
      Exit ;
   ValIni := FQuery.FieldByName('ValorInicial').AsFloat ;
   ValFim := FQuery.FieldByName('ValorFinal').AsFloat ;
   Result := True ;
   FQuery.Close ;
End ;

(* ------------------------------------------------------------------------- *
 * GetValContaCor -> Devolve o valor inicial da conta OM                     *
(* ------------------------------------------------------------------------- *)
Function TCambio.GetValContaCorOM ( pConta : String ; pData : TDateTime ;
                                    Var ValIni : Double ; Var ValFim : Double ) : Boolean ;
Var
   Sql : String ;
Begin
   Result := False ;

   Sql := ' Select sum(case tipo when ''A'' then pendmoedaom.valor/valorbacen else pendmoedaom.valor*valorbacen end) as Valorfinal' +
          ' From pendmoedaom, moedavalor , moeda' +
          ' Where pendmoedaom.codmoeda = moedavalor.codmoeda and pendmoedaom.codmoeda = moeda.codmoeda' +
          ' And Data = :Par_Data And DataInic = :Par_Data and valorbacen <> 0 ';

   if not Assigned(FTable.QResult) then begin
      FTable.QResult := TFDQuery.Create(Self) ;
      FQuery.Connection := DB_Conect.FDConnection;
   end;

   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_Data').AsDateTime := pData ;
   Try
       FQuery.Open ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   End ;
   If ( FQuery.Eof ) Then
      Exit ;
   ValFim := FQuery.FieldByName('ValorFinal').AsFloat ;
   Result := True ;
   FQuery.Close ;
End ;

(* ------------------------------------------------------------------------- *
 * GetValContaCor -> Devolve o valor inicial da conta OM sem paridade        *
(* ------------------------------------------------------------------------- *)
Function TCambio.GetValContaCorOMSPr ( pConta : String ; pData : TDateTime ;
                                    Var ValIni : Double ; Var ValFim : Double ) : Boolean ;
Var
   Sql : String ;
Begin
   Result := False ;

   Sql := ' Select sum(pendmoedaom.valor) as Valorfinal' +
          ' From pendmoedaom where DataInic = :P_DataInic';
   if not Assigned(FTable.QResult) then begin
      FTable.QResult := TFDQuery.Create(Self) ;
      FQuery.Connection := DB_Conect.FDConnection ;
//      FQuery.DatabaseName := FDBName ;
   end;

   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('P_DataInic').AsDateTime := GParFin.DtTrab ;
   Try
       FQuery.Open ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   End ;
   If ( FQuery.Eof ) Then
      Exit ;
   ValFim := FQuery.FieldByName('ValorFinal').AsFloat ;
   Result := True ;
   FQuery.Close ;
End ;

(* ------------------------------------------------------------------------- *
 * GetValContaCor -> Devolve o valor do saldo do cliente no pend moeda OM    *
(* ------------------------------------------------------------------------- *)
Function TCambio.GetValContaCorOMSldCli ( pMoeda, pCliente : String ; Var ValFim : Double ) : Boolean ;
Var
   Sql : String ;
Begin
   Result := False ;

   Sql := ' Select pendmoedaom.valor*(-1) as Valorfinal' +
          ' From pendmoedaom where codcliente = :P_CodCliente and codmoeda = :P_CodMoeda and DataInic = :P_DataInic';
   if not Assigned(FTable.QResult) then begin
      FTable.QResult := TFDQuery.Create(Self) ;
      FQuery.Connection := DB_Conect.FDConnection ;
//      FQuery.DatabaseName := FDBName ;
   end;

   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('P_CodCliente').AsString := pCliente ;
   FQuery.ParamByName('P_CodMoeda').AsString := pMoeda ;
   FQuery.ParamByName('P_DataInic').AsDateTime := GParFin.DtTrab ;
   Try
       FQuery.Open ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   End ;
   If ( FQuery.Eof ) Then
       ValFim := 0
   else
       ValFim := FQuery.FieldByName('ValorFinal').AsFloat ;

   Result := True ;
   FQuery.Close ;
End ;

(* ------------------------------------------------------------------------- *
 * InsMovCorrente -> Insere um movimento banc�rio                            *
(* ------------------------------------------------------------------------- *)
Function TCambio.InsMovCorrente ( pConta : String ; pData : TDateTime ;
                                  pValor : Double ; pPaiTipo : String ; pObs : String = '' ;
                                  pCliente : String = '' ; pUsuario : String = '') : Boolean ;
Var
   Sql : String ;
   sTipo : String ;
Begin

   Result := False ;

   If ( pValor >= 0 ) Then
      sTipo := 'C'
   Else
      sTipo := 'D' ;
   pValor := Abs(pValor) ;
   Sql := 'Insert Into MovCorrente ( CodConta, DtMov, TipMov, Valor, Historico, ' +
          'CodCliFor, Pai_ID, Pai_Tipo, CodFilial, CodMoeda ) Values ( :Par_Conta, :Par_Data, :Par_Tipo, ' +
          ':Par_Valor, :Par_Hist, :Par_Cliente, :Par_Pai, :Par_Pai_Tipo, :Par_Filial, :Par_Moeda )' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_Conta').AsString   := pConta ;
   FQuery.ParamByName('Par_Data').AsDateTime  := pData ;
   FQuery.ParamByName('Par_Tipo').AsString    := sTipo ;
   FQuery.ParamByName('Par_Valor').AsFloat    := pValor ;
   FQuery.ParamByName('Par_Hist').AsString    := pObs ;

   If ( pCliente <> '' ) Then
      FQuery.ParamByName('Par_Cliente').AsString := pCliente
   Else
      FQuery.ParamByName('Par_Cliente').AsString := Cliente ;
   FQuery.ParamByName('Par_Pai').AsInteger     := OpeID ;
   FQuery.ParamByName('Par_Pai_Tipo').AsString := pPaiTipo;
   FQuery.ParamByName('Par_Filial').AsString   := pUsuario ;
   FQuery.ParamByName('Par_Moeda').AsString    := GCambio.VarMoeda ;
   Try
       FQuery.ExecSql ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   End ;

   Result := True ;

End ;

(* ------------------------------------------------------------------------- *
 * UpdSaldoConta -> Atualiza o saldo de uma conta                            *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdSaldoConta ( pConta : String ; pData : TDateTime ;
                                 pValor : Double ; pPaiTipo : String ; pObs : String ;
                                 pCliente : String = '' ; pInsMov : Boolean = true ; pUsuario : String = '' ) : Boolean ;
Var
   Sql, Nusuario : String ;
   Ok: Boolean;
Begin
   Result := False ;
   If ( pValor = 0 ) Then
   Begin
      Result := True ;
      Exit ;
   End;
/// claudi�o a 1000
   Nusuario := pUsuario ;
   If ( Nusuario = '' ) Then
   Begin
       FSql := 'select codfilial from contacor where codconta = :Par_Conta ';
       FQuery.Close ;
       FQuery.Sql.Clear ;
       FQuery.Sql.Add(FSql) ;
       FQuery.ParamByName('Par_Conta').AsString  := pConta ;
       Try
          FQuery.Open ;
       Except
          On E:Exception Do
          Begin
             SetMensErro(E.Message) ;
             Exit ;
          End ;
       End;
       Nusuario := FQuery.Fields[0].AsString ;
   End;
   if (pConta <> 'AC') and (pConta <> '*CXUS') {and (pConta <> '*PAGAR*')} then
       begin
         Sql := 'Update SaldosBancarios Set ValorFinal = ValorFinal + :Par_Valor ' +
                'Where CodConta = :Par_Conta And Data = :Par_Data';
         Ok := true;
       end
   else
       Ok := false;

   if Ok then
      begin
        FQuery.Close ;
        FQuery.Sql.Clear ;
        FQuery.Sql.Add(Sql) ;
        FQuery.ParamByName('Par_Conta').AsString  := pConta ;
        FQuery.ParamByName('Par_Data').AsDateTime := pData ;
        FQuery.ParamByName('Par_Valor').AsFloat   := pValor ;
        Try
            FQuery.ExecSql ;
        Except
            on E: Exception do
            Begin
                MensErro := E.Message ;
                Exit ;
            End ;
      end;
   End ;
   If ( pInsMov ) Then
   Begin
      If ( Not InsMovCorrente(pConta,pData,pValor,pPaiTipo,pObs,pCliente,Nusuario) ) Then
         Exit ;
   End ;
   Result := True ;
End ;


(* ------------------------------------------------------------------------- *
 * UpdPendMoedaOM -> Atualiza o PendMoeda OM                            *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdPendMoedaOM ( pValor : Double ; pCliente, pMoeda: String): Boolean ;
Var
   Existe: Boolean;
   Sql : String ;
Begin
   Result := False ;
   Existe := false;
   If ( pValor = 0 ) Then
   Begin
      Result := True ;
      Exit ;
   End;

    Sql := 'select * from pendmoedaom where codmoeda = :Par_Moeda and codcliente = :Par_Cliente and DataInic = :P_DataInic and codreduzido = :P_CodReduzido';
    FQuery.Close ;
    FQuery.Sql.Clear ;
    FQuery.Sql.Add(Sql) ;
    FQuery.ParamByName('Par_Cliente').AsString := pCliente ;
    FQuery.ParamByName('Par_Moeda').AsString   := pMoeda;
    FQuery.ParamByName('P_DataInic').AsDateTime := GParFin.DtTrab ;
    FQuery.ParamByName('P_CodReduzido').AsString := Filial ;
    FQuery.Open ;

   Existe := FQuery.RecordCount > 0;

   if Existe then
      begin
         Sql := 'update pendmoedaom set valor = valor + :Par_Valor where codcliente = :Par_Cliente and codmoeda = :Par_Moeda and dataInic = :Par_Data and codreduzido = :Par_CodReduzido';

          FQuery.Close ;
          FQuery.Sql.Clear ;
          FQuery.Sql.Add(Sql) ;
          FQuery.ParamByName('Par_Valor').AsFloat    := pValor;
          FQuery.ParamByName('Par_Cliente').AsString := pCliente ;
          FQuery.ParamByName('Par_Moeda').AsString   := pMoeda;
          FQuery.ParamByName('Par_Data').AsDateTime  := GParFin.DtTrab;
          FQuery.ParamByName('Par_CodReduzido').AsString := Filial ;
          Try
              FQuery.ExecSql ;
          Except
              on E: Exception do
              Begin
                  MensErro := E.Message ;
                  Exit ;
              End ;
         end;
      end
   else
      begin
          Sql := 'insert into pendmoedaom(codcliente, codmoeda, valor, dataInic, CodReduzido) values (:Par_Cliente,:Par_Moeda, :Par_Valor, :Par_Data, :Par_CodReduzido)';

          FQuery.Close ;
          FQuery.Sql.Clear ;
          FQuery.Sql.Add(Sql) ;
          FQuery.ParamByName('Par_Valor').AsFloat    := pValor;
          FQuery.ParamByName('Par_Cliente').AsString := pCliente ;
          FQuery.ParamByName('Par_Moeda').AsString   := pMoeda;
          FQuery.ParamByName('Par_Data').AsDateTime  := GParFin.DtTrab;
          FQuery.ParamByName('Par_CodReduzido').AsString := Filial;
          Try
              FQuery.ExecSql ;
          Except
              on E: Exception do
              Begin
                  MensErro := E.Message ;
                  Exit ;
              End ;
         end;
      end;

   Result := True ;
End ;



(* ------------------------------------------------------------------------- *
 * UpdContaUS -> Atualiza o saldo da conta US                                *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdContaUs ( pValor : Double ; pPaiTipo : String ; pObs : String ) : Boolean ;
Begin
   Result := False ;
   If ( pObs = '' ) Then
      pObs := Obs ;
   If ( pValor = 0 ) Then
   Begin
      Result := True ;
      Exit ;
   End ;
   Result := UpdSaldoConta(GParFin.ContaUS,GParFin.DtTrab,pValor,pPaiTipo,pObs) ;
   If ( Not Result ) Then
   Begin
      Mens_MensErro(MensErro) ;
      Mens_MensInf('Problemas na atualiza��o do saldo da conta US') ;
      Result := False ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * UpdContaBR -> Atualiza o saldo da conta BR                                *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdContaBR ( pValor : Double ; pPaiTipo : String ; pObs : String ) : Boolean ;
Begin
   Result := False ;
   If ( pValor = 0 ) Then
   Begin
      Result := True ;
      Exit ;
   End ;
   Result := UpdSaldoConta(GParFin.ContaBR,GParFin.DtTrab,pValor,pPaiTipo,pObs) ;
   If ( Not Result ) Then
   Begin
      Mens_MensErro(MensErro) ;
      Mens_MensInf('Problemas na atualiza��o do saldo da conta BR') ;
      Result := False ;
   End ;
End ;


(* ------------------------------------------------------------------------- *
 * UpdContaCB -> Atualiza o saldo da conta CB                                *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdContaCB ( pValor : Double ; pPaiTipo : String ; pObs : String ) : Boolean ;
Begin
   Result := False ;
   If ( pValor = 0 ) Then
   Begin
      Result := True ;
      Exit ;
   End ;
   Result := UpdSaldoConta(GParFin.ContaCB,GParFin.DtTrab,pValor,pPaiTipo,pObs) ;
   If ( Not Result ) Then
   Begin
      Mens_MensErro(MensErro) ;
      Mens_MensInf('Problemas na atualiza��o do saldo da conta BR') ;
      Result := False ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * DelMovCorrente -> Exclui um movimento banc�rio atualizando o saldo        *
(* ------------------------------------------------------------------------- *)
Function TCambio.DelMovCorrente ( pPai : LongInt ; pPaiTipo : String ; pObs : String ) : Boolean ;
Var
   Sql : String ;
   Ok : Boolean ;
   nValor : Double ;
Begin

   Result := False ;

   Sql := 'Select * From MovCorrente Where Pai_ID = ' + Str_IntToStr(pPai) + ' And ' +
          'Pai_Tipo = ''' + pPaiTipo + '''' ;
   If ( Not FTable.GetExecSqlSel(Sql) ) Then
   Begin
      MensErro := FTable.GetMensErro() ;
      Exit ;
   End;

   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.Open ;
   Ok := True ;

   With FQuery Do
   Begin
      While ( Not Eof ) Do
      Begin
         nValor := (-1) * FieldByName('Valor').AsFloat ;
         If ( Not UpdSaldoConta(FieldByName('CodConta').AsString,GParFin.DtTrab,nValor,pPaiTipo,pObs) ) Then
         Begin
            Ok := False ;
            Result := False ;
            Break ;
         End ;
         Next ;
      End;
   End ;

   If ( Not Ok ) Then
      Exit ;

(*
   // -- Se o saldo � atualizado no UpdSaldoConta acima, gerando movimentos, n�o �
         necess�rio excluir os movimentos

   Sql := 'Delete From MovCorrente Where Pai_ID = ' + Str_IntToStr(pPai) + ' And ' +
          'Pai_Tipo = ''' + pPaiTipo + '''' ;
   If ( Not FTable.GetExecSql(Sql) ) Then
   Begin
      MensErro := FTable.GetMensErro() ;
      Exit ;
   End;
*)

   Result := True ;

End ;

(* ------------------------------------------------------------------------- *
 * BoaTaxa -> Verifique se uma taxa para compra/venda esta dentro dos padroes*
(* ------------------------------------------------------------------------- *)
Function TCambio.BoaTaxa ( pTaxa, pMedia : Double ) : Boolean ;
Begin
   Result := False ;
   If ( (pTaxa > (pMedia * (1 + GParFin.PercBoaTaxa/100))) Or
        (pTaxa < (pMedia * (1 - GParFin.PercBoaTaxa/100))) ) Then
      Exit ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * CalcMed -> Calcula a m�dia de compras/vendas do dia                       *
(* ------------------------------------------------------------------------- *)
Function TCambio.CalcMed ( pOpcao, pMoeda : String ) : Double ;
Var
   SomaQtde, SomaTotal : Double ;
   Sql : String ;
Begin

   Result := -9999999999 ;
   Error := True ;

   If ( pOpcao = 'C' ) Then
      Sql := 'Select Sum(Qtde), Sum(Qtde * Taxa) From Vw_CompCli Where Data = :Par_Data and Codmoeda = :Par_tipo'
   Else
      Sql := 'Select Sum(Qtde), Sum(Qtde * Taxa) From Vw_VendCli Where Data = :Par_Data and Codmoeda = :Par_tipo' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_Data').AsDateTime := GParFin.DtTrab ;
   FQuery.ParamByName('Par_tipo').AsString := pMoeda ;
   If ( Not FTable.ExecQuerySel(FQuery) ) Then
   Begin
      Mens_MensErro(FTable.GetMensErro()) ;
      Exit ;
   End ;
   SomaQtde   := FQuery.Fields[0].AsFloat ;
   SomaTotal  := FQuery.Fields[1].AsFloat ;

   If ( SomaQtde <> 0 ) Then
      Result := SomaTotal / SomaQtde
   Else
      Result := 0 ;

   Error := False ;

End ;

(* ------------------------------------------------------------------------- *
 * InsComVen -> Insere uma compra ou venda                                   *
(* ------------------------------------------------------------------------- *)
Function TCambio.InsComVen ( pOpcao : Char ) : Boolean ;
Var
   T : TSQLTableClass ;
Begin
   OpeID := -1 ;
   T := TSQLTableClass.Create() ;
   Result := False ;
   If ( pOpcao = 'C' ) Then
      T.OpenTable('Compras')
   Else
      T.OpenTable('Vendas') ;
   T.ResetKey ;
   T.SetFieldKey('Ope_ID') ;
   T.SetFieldValue('Data',Data) ;
   T.SetFieldValue('CodCliente',Cliente) ;
   T.SetFieldValue('Qtde',Qtde) ;
   T.SetFieldValue('Taxa',Taxa) ;
   T.SetFieldValue('CodConta',Conta) ;
   T.SetFieldValue('NumLanc',NumLanc) ;
   T.SetFieldValue('Tipo',Forma) ;
   T.SetFieldValue('Status',Mercado) ;
   T.SetFieldValue('Posicao',Posicao) ;
   T.SetFieldValue('Observacao',Obs) ;
   T.SetFieldValue('CodFilial',Filial) ;
   T.SetFieldValue('Carga',Carga) ;
   T.SetFieldValue('CodUsuario',CodUsuario) ;
   T.SetFieldValue('NatOperacao',NatOperacao) ;
   T.SetFieldValue('FornecCredor',FornecCredor) ;
   T.SetFieldValue('Indicacao',Comissionado) ;
   T.SetFieldValue('Dtliqmoeda',Dtliqmoeda) ;
   T.SetFieldValue('Dtliqmoedaest',Dtliqmoedaest) ;
   T.SetFieldValue('Formaentr',Formaentr) ;
   Result := T.Insert(False) ;
   If ( Not Result ) Then
      MensErro := T.GetMensErro()
   Else
      OpeID := T.GetLastIdentity() ;
   T.Destroy ;
End ;

(* ------------------------------------------------------------------------- *
 * UpdComVen -> Atualiza uma compra ou venda                                 *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdComVen ( pOpcao : Char ; pID : Integer = -1 ) : Boolean ;
Var
   T : TSQLTableClass ;
Begin

   T := TSQLTableClass.Create() ;
   If ( pID = -1 ) Then
      pID := OpeID ;
   If ( pOpcao = 'C' ) Then
      T.OpenTable('Compras')
   Else
      T.OpenTable('Vendas') ;
   T.ResetKey ;
   T.SetFieldKey('Ope_ID') ;
   T.SetKeyValue('Ope_ID',pID) ;
   If ( Not T.Find(True) ) Then
   Begin
      Result := False ;
      Exit ;
   End ;
   T.SetFieldValue('Data',Data) ;
   T.SetFieldValue('CodCliente',Cliente) ;
   T.SetFieldValue('Qtde',Qtde) ;
   T.SetFieldValue('Taxa',Taxa) ;
   T.SetFieldValue('CodConta',Conta) ;
   T.SetFieldValue('NumLanc',NumLanc) ;
   T.SetFieldValue('Tipo',Forma) ;
   T.SetFieldValue('Status',Mercado) ;
   T.SetFieldValue('Posicao',Posicao) ;
   T.SetFieldValue('Observacao',Obs) ;
   T.SetFieldValue('CodFilial',Filial) ;
   T.SetFieldValue('Carga',Carga) ;
   T.SetFieldValue('Dtliqmoeda',Dtliqmoeda) ;
   T.SetFieldValue('Dtliqmoedaest',Dtliqmoeda) ;
   T.SetFieldValue('Formaentr',Formaentr) ;
   Result := T.Update() ;
   If ( Not Result ) Then
      MensErro := T.GetMensErro()
   Else
      OpeID := T.GetFieldValue('Ope_ID') ;
   T.Destroy ;

End ;

(* ------------------------------------------------------------------------- *
 * DelComVen -> Exclui uma compra ou venda                                   *
(* ------------------------------------------------------------------------- *)
Function TCambio.DelComVen ( pOpcao : String ; pID : Integer = -1 ; CodMoeda: String = ''; psObs : String = 'Exclus�o'  ) : Boolean ;
Var
   T : TSQLTableClass ;
   Ok : Boolean ;
   nQtde : Double ;
Begin

   Result := False ;

   If ( pOpcao = 'C' ) Then
        pOpcaoBR := 'C'
   else
        pOpcaoBR := 'V';

   T := TSQLTableClass.Create() ;
   If ( pID = -1 ) Then
      pID := OpeID ;
   If ( pOpcao = 'C' ) Then
      T.OpenTable('Compras')
   Else
      T.OpenTable('Vendas') ;

   T.ResetKey ;
   T.SetFieldKey('Ope_ID') ;
   T.SetKeyValue('Ope_ID',pID) ;
   If ( Not T.Find(True) ) Then
   Begin
      MensErro := T.GetMensErro() ;
      Exit ;
   End ;

   //----- Obtem as pendencias em US
   If ( Not GetPendUS(pID) ) Then
   Begin
      MensErro := T.GetMensErro() ;
      Exit ;
   End ;
   Ok := True ;
   // Testa se existem pendencias baixadas
   While ( Not QPendUS.Eof ) Do
   Begin
      If ( QPendUS.FieldByName('Status').AsString = '*' ) Then
      Begin
         Ok := False ;
         Result := False ;
         Break ;
      End;
      QPendUS.Next ;
   End ;

   If ( Not OK ) Then
   Begin
      MensErro := 'Pend�ncias de US j� baixadas. Registro n�o pode ser exclu�do' ;
      Exit ;
   End;

   if (CodMoeda = 'PP') or (CodMoeda = 'TC') or (CodMoeda = 'VTM') then
      begin
       // Atualizar a ContaUS
       If ( pOpcao = 'C' ) Then
          nQtde := (-1)*T.GetFieldValue('Qtde')
       Else
          nQtde := T.GetFieldValue('Qtde') ;
       If ( Not UpdContaUs(nQtde,'D',psObs) ) Then
       Begin
          MensErro := T.GetMensErro() ;
          Exit ;
       End ;
     end
   else
     begin
       // Atualiza a ContaOM
       If ( pOpcao = 'C' ) Then
          nQtde := (-1)*T.GetFieldValue('Qtde')
       Else
          nQtde := T.GetFieldValue('Qtde');
       If ( Not UpdContaCB(nQtde,'D',psObs) ) Then
       Begin
          MensErro := T.GetMensErro() ;
          Exit ;
       End ;
     end;

   // Atualiza a ContaBR
   If ( pOpcao = 'C' ) Then
      nQtde := T.GetFieldValue('Qtde')*T.GetFieldValue('Taxa')
   Else
      nQtde := (-1)*T.GetFieldValue('Qtde')*T.GetFieldValue('Taxa') ;
   If ( Not UpdContaBR(nQtde,'D',psObs) ) Then
   Begin
      MensErro := T.GetMensErro() ;
      Result := False ;
      Exit ;
   End ;

   //----- Obter as pendencias BR
   If ( Not GetPendBR(pID) ) Then
   Begin
      MensErro := T.GetMensErro() ;
      Result := False ;
      Exit ;
   End ;

   // Atualizar os bancos do lan�amento
   Ok := True ;
   While ( Not QPendBR.Eof ) Do
   Begin
      If ( Not UpdSaldoConta(QPendBR.FieldByName('Banco').AsString,GParFin.DtTrab,
                             QPendBR.FieldByName('Valor').AsFloat,'D',
                             psObs,'',True) ) Then
      Begin
         Ok := False ;
         Result := False ;
         Break ;
      End ;
      QPendBR.Next ;
   End ;

   If ( Not OK ) Then
   Begin
      MensErro := 'Problemas na atualiza��o das pend�ncias BR' ;
      Result := False ;
      Exit ;
   End;

   // Exclus�o das pend�ncias
   If ( Not DelPendBRByPaiID(pID,PEND_PLANILHA) ) Then
   Begin
      MensErro := T.GetMensErro() ;
      Result := False ;
      Exit ;
   End ;

   Result := T.Delete() ;
   If ( Not Result ) Then
   Begin
      MensErro := T.GetMensErro() ;
      Exit ;
   End ;

   Result := True ;

   T.Destroy ;

End ;

(* ------------------------------------------------------------------------- *
 * InsPendOM -> Insere uma pendencia OM                                      *
(* ------------------------------------------------------------------------- *)
Function TCambio.InsPendOM : Boolean ;
Var
   T : TSQLTableClass ;
Begin
   Result := False ;
   T := TSQLTableClass.Create() ;
   T.OpenTable('PendMoedaOM') ;
   T.ResetKey ;
   T.SetFieldValue('CodCliente',Cliente) ;
   T.SetFieldValue('Valor',Valor) ;
   T.SetFieldValue('CodMoeda',Forma) ;
   Result := T.Insert() ;
   If ( Not Result ) Then
      MensErro := T.GetMensErro() ;
   T.Destroy ;
End ;


(* ------------------------------------------------------------------------- *
 * InsPendUS -> Insere uma pendencia US                                      *
(* ------------------------------------------------------------------------- *)
Function TCambio.InsPendUS : Boolean ;
Var
   T : TSQLTableClass ;
Begin
   Result := False ;
   T := TSQLTableClass.Create() ;
   T.OpenTable('PendMoedaUS') ;
   T.ResetKey ;
   T.SetFieldKey('Pend_ID') ;
   T.SetFieldValue('Ope_ID',OpeID) ;
   T.SetFieldValue('CodCliente',Cliente) ;
   T.SetFieldValue('TipoOpe',TipoOpe) ;
   T.SetFieldValue('Data',Data) ;
   T.SetFieldValue('Valor',Valor) ;
   T.SetFieldValue('NumLanc',NumLanc) ;
   T.SetFieldValue('Status',Status) ;
   T.SetFieldValue('Tipo',Tipo) ;
   T.SetFieldValue('Mercado',Mercado) ;
   T.SetFieldValue('Forma',Forma) ;
   T.SetFieldValue('Posicao',Posicao) ;
   T.SetFieldValue('Quitado',Quitado) ;
   T.SetFieldValue('Observacao',Obs) ;
   T.SetFieldValue('CodFilial',Filial) ;
   T.SetFieldValue('Carga',Carga) ;
   Result := T.Insert() ;
   If ( Not Result ) Then
      MensErro := T.GetMensErro() ;
   T.Destroy ;
End ;

(* ------------------------------------------------------------------------- *
 * UpdPendUS -> Atualiza uma pendencia US                                    *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdPendUS ( pID : Integer = -1 ) : Boolean ;
Var
   T : TSQLTableClass ;
Begin

   If ( pID = -1 ) Then
      pID := OpeID ;

   T := TSQLTableClass.Create() ;
   T.OpenTable('PendMoedaUS') ;
   T.ResetKey ;
   T.SetFieldKey('Ope_ID') ;
   T.SetKeyValue('Ope_ID',pID) ;

   If ( Not T.Find(True) ) Then
   Begin
      Result := False ;
      Exit ;
   End ;

   T.SetFieldValue('CodCliente',Cliente) ;
   T.SetFieldValue('TipoOpe',TipoOpe) ;
   T.SetFieldValue('Data',Data) ;
   T.SetFieldValue('Valor',Valor) ;
   T.SetFieldValue('NumLanc',NumLanc) ;
   T.SetFieldValue('Status',Status) ;
   T.SetFieldValue('Tipo',Tipo) ;
   T.SetFieldValue('Mercado',Mercado) ;
   T.SetFieldValue('Forma',Forma) ;
   T.SetFieldValue('Posicao',Posicao) ;
   T.SetFieldValue('Quitado',Quitado) ;
   T.SetFieldValue('Observacao',Obs) ;
   T.SetFieldValue('CodFilial',Filial) ;
   T.SetFieldValue('Carga',Carga) ;
   Result := T.Update() ;
   If ( Not Result ) Then
      MensErro := T.GetMensErro() ;
   T.Destroy ;

End ;

(* ------------------------------------------------------------------------- *
 * DelPendUS -> Deleta uma pendencia US                                      *
(* ------------------------------------------------------------------------- *)
Function TCambio.DelPendUS ( pID : Integer ; pPaiTipo : String ; pObs : String = '' ) : Boolean ;
Var
   T : TSQLTableClass ;
Begin

   Result := False ;

   If ( pID = -1 ) Then
      pID := OpeID ;
   T := TSQLTableClass.Create() ;
   T.OpenTable('PendMoedaUS') ;
   T.ResetKey ;
   T.SetFieldKey('Ope_ID') ;
   T.SetKeyValue('Ope_ID',pID) ;
   If ( Not T.Find(True) ) Then
   Begin
      Exit ;
   End ;

   // -- Excluindo os movimentos banc�rios e atualizando os saldos
   If ( Not DelMovCorrente(pID,pPaiTipo,pObs) ) Then
   Begin
      MensErro := T.GetMensErro() ;
      Exit ;
   End;

   // -- Excluir a pend�ncia
   Result := T.Delete() ;
   If ( Not Result ) Then
      MensErro := T.GetMensErro() ;
   T.Destroy ;

End ;

(* ------------------------------------------------------------------------- *
 * DelPendBR -> Deleta uma pendencia BR                                      *
(* ------------------------------------------------------------------------- *)
Function TCambio.DelPendBR ( pID : Integer ) : Boolean ;
Var
   T : TSQLTableClass ;
Begin
   // 26/10 acerto do limite do cliente
   If ( Not GCambio.UpdLimCli(Cliente, Valor *(-1)) ) Then
   Begin
      Mens_MensInf('Problemas na atualiza��o do limite do cliente') ;
      Result := False ;
      Exit ;
   End ;

{   If ( Not GCambio.UpdLimCli(Cliente, Valor) ) Then
   Begin
      Mens_MensErro(GCambio.MensErro) ;
      Mens_MensInf('Problemas na atualiza��o do limite do cliente') ;
      GCambio.ExecRollBack() ;
      Exit ;
   End; // 26/10 }

   T := TSQLTableClass.Create() ;
   T.OpenTable('PendMoedaBR') ;
   T.ResetKey ;
   T.SetFieldKey('Pend_ID') ;
   T.SetKeyValue('Pend_ID',pID) ;
   Result := T.Delete() ;
   If ( Not Result ) Then
      MensErro := T.GetMensErro() ;
   T.Destroy ;
End ;

(* ------------------------------------------------------------------------- *
 * InsPendBR -> Insere uma pendencia BR                                      *
(* ------------------------------------------------------------------------- *)
Function TCambio.InsPendBR ( pPaiTipo : String ; pObs : String = '' ; pUpdConta : Boolean = True ) : Boolean ;
Var
   T : TSQLTableClass ;
   nValor : Double;
   sPaiTipo : String ;
Begin
   // 26/10 acerto do limite do cliente
   Result := False ;

   If ( Not GCambio.UpdLimCli(Cliente, Valor *(-1)) ) Then
   Begin
      Mens_MensInf('Problemas na atualiza��o do limite do cliente') ;
      Result := False ;
      Exit ;
   End ;

{   Begin
      Mens_MensErro(GCambio.MensErro) ;
      Mens_MensInf('Problemas na atualiza��o do limite do cliente') ;
      GCambio.ExecRollBack() ;
      Exit ;
   End; // 26/10 }


   If ( Tipo = '-' ) Then
   Begin
      sPaiTipo := '+' ;
      nValor := Valor * (-1) ;
   End
   Else Begin
      nValor := Valor ;
      sPaiTipo := '-' ;
   End ;
   If ( nValor = 0 ) Then
   Begin
      Result := True ;
      Exit ;
   End;
   If ( pObs = '' ) Then
      pObs := Obs ;
   T := TSQLTableClass.Create() ;
   T.OpenTable('PendMoedaBR') ;
   T.ResetKey ;
   T.SetFieldKey('Pend_ID') ;
   T.SetFieldValue('Ope_ID',OpeID) ;
   T.SetFieldValue('CodCliente',Cliente) ;
   T.SetFieldValue('TipoOpe',TipoOpe) ;
   T.SetFieldValue('Data',Data) ;
   T.SetFieldValue('Valor',nValor) ;
   T.SetFieldValue('Banco',Banco) ;
   T.SetFieldValue('Agencia',Agencia) ;
   T.SetFieldValue('Conta',Conta) ;
   T.SetFieldValue('Nome',Nome) ;
   T.SetFieldValue('PagRec',' ') ;
   T.SetFieldValue('NumLanc',NumLanc) ;
   T.SetFieldValue('Status',Status) ;
   T.SetFieldValue('Tipo',Tipo) ;
   T.SetFieldValue('Mercado',Mercado) ;
   T.SetFieldValue('Forma',Forma) ;
   T.SetFieldValue('Posicao',Posicao) ;
   T.SetFieldValue('Indice',Indice) ;
   T.SetFieldValue('Quitado',Quitado) ;
   T.SetFieldValue('Observacao',pObs) ;
   T.SetFieldValue('Pai_ID',PaiID) ;
   T.SetFieldValue('CodFilial',Filial) ;
   T.SetFieldValue('Carga',Carga) ;
   T.SetFieldValue('StatusFac',StatusFac) ;
   Result := T.Insert() ;
   If ( Not Result ) Then
   Begin
      MensErro := T.GetMensErro() ;
      T.Destroy ;
      Exit ;
   End ;
   If ( pUpdConta ) Then
   Begin
      // -- O mov. em conta corrente � ao contr�rio da pend�ncia
      nValor := nValor * (-1) ;
      Result := UpdSaldoConta(Banco,GParFin.DtTrab,nValor,pPaiTipo,pObs) ;
   End ;

   T.Destroy ;
End ;

(* ------------------------------------------------------------------------- *
 * UpdPendBR -> Atualiza uma pendencia BR                                      *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdPendBR ( pID : Integer ; pTipoOpe : String ; pPaiTipo : String ; pObs : String ) : Boolean ;
Var
   T : TSQLTableClass ;
   nOldVal, nValor : Double ;
   sTipo, sOldTipo, sOldBanco : String ;
Begin

   // -- Procura a pend�ncia
   T := TSQLTableClass.Create() ;
   T.OpenTable('PendMoedaBR') ;
   T.ResetKey ;
   T.SetKeyValue('Pend_ID',pID) ;
   T.SetKeyValue('TipoOpe',pTipoOpe) ;
   If ( Not T.Find(True) ) Then
   Begin
      Result := False ;
      Exit ;
   End ;
   sOldTipo  := T.GetFieldValue('Tipo') ;
   nOldVal   := T.GetFieldValue('Valor') ;
   sOldBanco := T.GetFieldValue('Banco') ;

   T.SetFieldValue('Ope_ID',pID) ;
   T.SetFieldValue('TipoOpe',pTipoOpe) ;
   T.SetFieldValue('CodCliente',Cliente) ;
   T.SetFieldValue('Data',Data) ;
   T.SetFieldValue('Valor',Valor) ;
   T.SetFieldValue('Banco',Banco) ;
   T.SetFieldValue('Agencia',Agencia) ;
   T.SetFieldValue('Conta',Conta) ;
   T.SetFieldValue('Nome',Nome) ;
   T.SetFieldValue('PagRec',' ') ;
   T.SetFieldValue('NumLanc',NumLanc) ;
   T.SetFieldValue('Status',Status) ;
   T.SetFieldValue('Tipo',Tipo) ;
   T.SetFieldValue('Mercado',Mercado) ;
   T.SetFieldValue('Forma',Forma) ;
   T.SetFieldValue('Posicao',Posicao) ;
   T.SetFieldValue('Indice',Indice) ;
   T.SetFieldValue('Quitado',Quitado) ;
   T.SetFieldValue('Observacao',Obs) ;
   T.SetFieldValue('CodFilial',Filial) ;
   T.SetFieldValue('Carga',Carga) ;
   T.SetFieldValue('StatusFac',StatusFac) ;
   Result := T.Update() ;
   If ( Not Result ) Then
   Begin
      MensErro := T.GetMensErro() ;
      T.Destroy ;
      Exit ;
   End ;

   // -- Atualizando o saldo antigo
   // -- Se o banco for GParFin.ContaFactor, inverter
   If ( sOldBanco = GParFin.ContaFactor ) Then
      nOldVal := nOldVal * (-1) ;
   If ( Not UpdSaldoConta(sOldBanco,GParFin.DtTrab,nOldVal,sOldTipo,'Atualiza��o de pend�ncia') ) Then
   Begin
      Result := False ;
      Exit ;
   End ;

   // -- Atualiza o saldo da conta
   If ( Tipo = '-' ) Then
   Begin
      sTipo := '+' ;
      nValor := Abs(Valor) ;
   End
   Else Begin
      sTipo := '-' ;
      nValor := Valor * (-1) ;
   End ;
   If ( sOldBanco = GParFin.ContaFactor ) Then
      nValor := nValor * (-1) ;
   If ( Not UpdSaldoConta(Banco,GParFin.DtTrab,nValor,sTipo,pObs) ) Then
   Begin
      MensErro := T.GetMensErro() ;
      Result := False ;
      T.Destroy ;
      Exit ;
   End ;

   Result := True ;

End ;

(* ------------------------------------------------------------------------- *
 * DelPendBRByPaiID -> Deleta uma pendencia BR dado o pai do registro        *
 *                     N�o atualiza os bancos da pend�ncia                   *
(* ------------------------------------------------------------------------- *)
Function TCambio.DelPendBRByPaiID ( pID : Integer ; pPaiTipo : String ; pObs : String = '' ) : Boolean ;
Begin
   Result := False ;
   FSql := 'Delete From PendMoedaBR Where Ope_ID = :Par_ID And TipoOpe = :Par_Tipo' ;

   if pOpcaoBR = 'C' then
      FSql := FSql + ' And Tipo = ''+'''
   else
      FSql := FSql + ' And Tipo = ''-''';

   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(FSql) ;
   FQuery.ParamByName('Par_ID').AsInteger  := pID ;
   FQuery.ParamByName('Par_Tipo').AsString := pPaiTipo ;
   Try
      FQuery.ExecSql ;
   Except
      On E:Exception Do
      Begin
         MensErro := E.Message ;
         Exit ;
      End ;
   End;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * GetPendUS -> Obtem as pendencias em US dado um ID de compra ou venda      *
(* ------------------------------------------------------------------------- *)
Function TCambio.GetPendUS ( pID : Integer = -1 ; pTipoOpe : String = PEND_PLANILHA ) : Boolean ;
Begin

   Result := False ;

   If ( pID = -1 ) Then
      pID := OpeID ;

   QPendUS.Close ;
   QPendUS.Sql.Clear ;
   QPendUS.Sql.Add('Select * From PendMoedaUS Where Ope_ID = :Par_ID And TipoOpe = :Par_TipoOpe') ;
   QPendUS.ParamByName('Par_ID').AsInteger := pID ;
   QPendUS.ParamByName('Par_TipoOpe').AsString := pTipoOpe ;
   Try
      QPendUS.Open ;
   Except
      on E: Exception do
      Begin
         MensErro := E.Message ;
         Exit ;
      End ;
   End ;

   Result := True ;

End ;

(* ------------------------------------------------------------------------- *
 * GetPendBR -> Obtem as pendencias em BR dado um ID de compra ou venda      *
(* ------------------------------------------------------------------------- *)
Function TCambio.GetPendBR ( pID : Integer = -1 ; pTipoOpe : String = PEND_PLANILHA ) : Boolean ;
Begin

   Result := False ;

   If ( pID = -1 ) Then
      pID := OpeID ;

   QPendBR.Close ;
   QPendBR.Sql.Clear ;
   QPendBR.Sql.Add('Select * From PendMoedaBR Where Ope_ID = :Par_ID And TipoOpe = :Par_TipoOpe') ;

   if pOpcaoBR = 'C' then
      QPendBR.Sql.Add(' And Tipo = ''+''')
   else
      QPendBR.Sql.Add(' And Tipo = ''-''');

   QPendBR.ParamByName('Par_ID').AsInteger := pID ;
   QPendBR.ParamByName('Par_TipoOpe').AsString := pTipoOpe ;
   Try
      QPendBR.Open ;
   Except
      on E: Exception do
      Begin
         MensErro := E.Message ;
         Exit ;
      End ;
   End ;

   Result := True ;

End ;

(* ------------------------------------------------------------------------- *
 * UpdSaldoCli -> Atualiza o saldo do cliente                                *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdSaldoCli ( pTipo : String ;
                               pStatus : String ;
                               pPaiId : Integer ;
                               pPaiTipo : String ;
                               pUS_CB : String = '' ;
                               pCodCli : String = '' ;
                               pQtde : Double = 0 ;
                               pValor : Double = 0 ;
                               pObs : String = '' ) : Boolean ;
Var
   Sql : String ;
   sTipo : String ;
Begin

   Result := False ;

   If ( pTipo = 'C' ) Then
      pTipo := '+' ;
   If ( pTipo = 'D' ) Then
      pTipo := '-' ;
   If ( (pTipo <> '+') And (pTipo <> '-') ) Then
   Begin
      MensErro := 'Tipo de atualiza��o do cliente inv�lido' ;
      Exit ;
   End ;
   If ( pUS_CB = '' ) Then
      pUS_CB := Forma ;
   If ( (pUS_CB <> 'PP') And (pUS_CB <> 'TC') And (pUS_CB <> 'VTM') And (pUS_CB <> 'BR') And (pUS_CB <> 'US') And (pUS_CB <> 'OM')) Then
   Begin
      MensErro := 'Moeda de atualiza��o do cliente inv�lida' ;
      Exit ;
   End ;
   If ( pCodCli = '' ) Then
      pCodCli := Cliente ;

   If ( pValor = 0 ) Then
   Begin
      pValor := Qtde * (Taxa);
      If ( pTipo = '+' ) Then
         pValor := pValor * (-1) ;
   End
   Else Begin
      If ( pTipo = '-' ) Then
         pValor := pValor * (-1) ;
   End ;
   If ( pQtde = 0 ) Then
      pQtde := Qtde ;
   If ( pTipo = '-' ) Then
      pQtde := (-1) * pQtde ;

   If ( pObs = '' ) Then
      pObs := Obs ;
   If ( pTipo = '-' ) Then
      sTipo := 'C'
   Else
      sTipo := 'V' ;

   If ( (pQtde <> 0) Or (pValor <> 0) ) Then
   Begin
      Sql := 'Update Cliente Set ' ;
      If ( pUS_CB = 'PP' ) Then
         Sql := Sql + 'Valor_US = Valor_US + :Par_Qtde, Valor_BR = Valor_BR + :Par_Valor, limite_cheque = limite_cheque + :Par_Valor  Where '
      else
      If ( pUS_CB = 'TC' ) Then
         Sql := Sql + 'Valor_Cabo = Valor_Cabo + :Par_Qtde, Valor_BR = Valor_BR + :Par_Valor, limite_cheque = limite_cheque + :Par_Valor   Where '
      else
      If ( pUS_CB = 'VTM' ) Then
         Sql := Sql + 'Valor_VTM = Valor_VTM + :Par_Qtde, Valor_BR = Valor_BR + :Par_Valor, limite_cheque = limite_cheque + :Par_Valor   Where '
      else
      If ( pUS_CB = 'BR' ) Then
         Sql := Sql + 'Valor_BR = Valor_BR + :Par_Valor, limite_cheque = limite_cheque + :Par_Valor   Where '
      else
         // 12/11 atualizacao para a moeda OM
         Sql := Sql + 'Valor_OM = Valor_OM + :Par_Qtde, Valor_BR = Valor_BR + :Par_Valor, limite_cheque = limite_cheque + :Par_Valor   Where ';

      Sql := Sql + 'CodCliente = :Par_Codigo' ;

      FQuery.Close ;
      FQuery.Sql.Clear ;
      FQuery.Sql.Add(Sql) ;
      FQuery.ParamByName('Par_Codigo').AsString := pCodCli ;
      If ( pUS_CB <> 'BR' ) Then
         FQuery.ParamByName('Par_Qtde').AsFloat    := pQtde ;
      FQuery.ParamByName('Par_Valor').AsFloat   := pValor ;
      Try
         FQuery.ExecSql ;
      Except
         on E: Exception do
         Begin
            MensErro := E.Message ;
            Exit ;
         End ;
      End ;

      // -- MovCliente Moeda
      If ( pUS_CB <> 'BR' ) Then
         If ( Not InsMovCliente(GParFin.DtTrab,pCodCli,pUS_CB,pQtde,pObs,sTipo,pPaiId,pPaiTipo,pStatus) ) Then
            Exit ;
      // -- MovCliente BR
      If ( (pValor <> -1) And (pValor <> 0) ) Then
         If ( Not InsMovCliente(GParFin.DtTrab,pCodCli,'BR',pValor,pObs,sTipo,pPaiId,pPaiTipo,pStatus) ) Then
            Exit ;

   End ;

   Result := True ;

End ;

(* ------------------------------------------------------------------------- *
 * UpdSaldoCli -> Atualiza o saldo do cliente                                *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdSaldoCliQuit ( pTipo : String ;
                               pStatus : String ;
                               pPaiId : Integer ;
                               pPaiTipo : String ;
                               pUS_CB : String = '' ;
                               pCodCli : String = '' ;
                               pQtde : Double = 0 ;
                               pValor : Double = 0 ;
                               pObs : String = '' ) : Boolean ;
Var
   Sql : String ;
   sTipo : String ;
Begin

   Result := False ;

   If ( pTipo = 'C' ) Then
      pTipo := '+' ;
   If ( pTipo = 'D' ) Then
      pTipo := '-' ;
   If ( (pTipo <> '+') And (pTipo <> '-') ) Then
   Begin
      MensErro := 'Tipo de atualiza��o do cliente inv�lido' ;
      Exit ;
   End ;
   If ( pUS_CB = '' ) Then
      pUS_CB := Forma ;
   If ( (pUS_CB <> 'PP') And (pUS_CB <> 'TC') And (pUS_CB <> 'VTM') And (pUS_CB <> 'BR') And (pUS_CB <> 'US') And (pUS_CB <> 'OM')) Then
   Begin
      MensErro := 'Moeda de atualiza��o do cliente inv�lida' ;
      Exit ;
   End ;
   If ( pCodCli = '' ) Then
      pCodCli := Cliente ;

   If ( pValor = 0 ) Then
   Begin
//      pValor := Qtde * (Taxa);
//      If ( pTipo = '+' ) Then
//         pValor := pValor * (-1) ;
   End
   Else Begin
      If ( pTipo = '-' ) Then
         pValor := pValor * (-1) ;
   End ;
   If ( pQtde = 0 ) Then
      pQtde := Qtde ;
   If ( pTipo = '-' ) Then
      pQtde := (-1) * pQtde ;

   If ( pObs = '' ) Then
      pObs := Obs ;
   If ( pTipo = '-' ) Then
      sTipo := 'C'
   Else
      sTipo := 'V' ;

   If ( (pQtde <> 0) Or (pValor <> 0) ) Then
   Begin
      Sql := 'Update Cliente Set ' ;
      If ( pUS_CB = 'PP' ) Then
         Sql := Sql + 'Valor_US = Valor_US + :Par_Qtde, Valor_BR = Valor_BR + :Par_Valor, limite_cheque = limite_cheque + :Par_Valor  Where '
      else
      If ( pUS_CB = 'TC' ) Then
         Sql := Sql + 'Valor_Cabo = Valor_Cabo + :Par_Qtde, Valor_BR = Valor_BR + :Par_Valor, limite_cheque = limite_cheque + :Par_Valor   Where '
      else
      If ( pUS_CB = 'VTM' ) Then
         Sql := Sql + 'Valor_VTM = Valor_VTM + :Par_Qtde, Valor_BR = Valor_BR + :Par_Valor, limite_cheque = limite_cheque + :Par_Valor   Where '
      else
      If ( pUS_CB = 'BR' ) Then
         Sql := Sql + 'Valor_BR = Valor_BR + :Par_Valor, limite_cheque = limite_cheque + :Par_Valor   Where '
      else
         // 12/11 atualizacao para a moeda OM
         Sql := Sql + 'Valor_OM = Valor_OM + :Par_Qtde, Valor_BR = Valor_BR + :Par_Valor, limite_cheque = limite_cheque + :Par_Valor   Where ';

      Sql := Sql + 'CodCliente = :Par_Codigo' ;

      FQuery.Close ;
      FQuery.Sql.Clear ;
      FQuery.Sql.Add(Sql) ;
      FQuery.ParamByName('Par_Codigo').AsString := pCodCli ;
      If ( pUS_CB <> 'BR' ) Then
         FQuery.ParamByName('Par_Qtde').AsFloat    := pQtde ;
      FQuery.ParamByName('Par_Valor').AsFloat   := pValor ;
      Try
         FQuery.ExecSql ;
      Except
         on E: Exception do
         Begin
            MensErro := E.Message ;
            Exit ;
         End ;
      End ;

      // -- MovCliente Moeda
      If ( pUS_CB <> 'BR' ) Then
         If ( Not InsMovCliente(GParFin.DtTrab,pCodCli,pUS_CB,pQtde,pObs,sTipo,pPaiId,pPaiTipo,pStatus) ) Then
            Exit ;
      // -- MovCliente BR
      If ( (pValor <> -1) And (pValor <> 0) ) Then
         If ( Not InsMovCliente(GParFin.DtTrab,pCodCli,'BR',pValor,pObs,sTipo,pPaiId,pPaiTipo,pStatus) ) Then
            Exit ;

   End ;

   Result := True ;

End ;

(* ------------------------------------------------------------------------- *
 * UpdLucroCli -> Atualiza o lucro dos borderos de um cliente                *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdLucroCli ( pCodCli : String ; pValor : Double ) : Boolean ;
Begin
   FSql := 'Update Cliente Set LucroBord = LucroBord + :Par_Valor Where ' +
           'CodCliente = :Par_Cliente' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(FSql) ;
   FQuery.ParamByName('Par_Valor').AsFloat := pValor ;
   FQuery.ParamByName('Par_Cliente').AsString := pCodCli ;
   Try
      FQuery.ExecSql ;
   Except
      on E: Exception do
      Begin
         MensErro := E.Message ;
         Result := False ;
         Exit ;
      End ;
   End ;
   MensErro := '' ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * InsMovCliente -> Insere um movimento do cliente                           *
(* ------------------------------------------------------------------------- *)
Function TCambio.InsMovCliente ( pData : TDateTime ; pCodCliente : String ;
                                    pMoeda : String ; pValor : Double ; pObs : String ;
                                    pTipo : String ; pPaiId : Integer ;
                                    pPaiTipo : String ; pStatus : String = ' ' ) : Boolean ;
Var
   Sql : String ;
Begin

   Result := False ;

// Altera��o CLAUDIO...precisa aumentar o campo para 100 posi��es
   pObs:= Copy(pObs, 1, 49) ;

   Sql := 'Insert Into MovCliente ( Status, Data, CodCliente, CodMoeda, Valor, Obs, Pai_ID, ' +
          'Pai_Tipo, Tipo, Carga, CodFilial ) Values ( :Par_Status, :Par_Data, :Par_CodCliente, :Par_Moeda, ' +
          ':Par_Valor, :Par_Obs, :Par_PaiID, :Par_PaiTipo, :Par_Tipo, :Par_Carga, :Par_Filial )' ;

   If ( pPaiId = 0 ) Then
      pPaiId := OpeID ;

   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_Data').AsDateTime     := pData ;
   FQuery.ParamByName('Par_CodCliente').AsString := pCodCliente ;

   // Alteracao de quando Moeda OM gravar a moeda especifica
   if pMoeda = 'OM' then
      FQuery.ParamByName('Par_Moeda').AsString   := GCambio.VarMoeda
   else
      FQuery.ParamByName('Par_Moeda').AsString   := pMoeda ;

   FQuery.ParamByName('Par_Valor').AsFloat       := pValor ;
   FQuery.ParamByName('Par_Obs').AsString        := pObs ;
   FQuery.ParamByName('Par_PaiID').AsInteger     := pPaiId ;
   FQuery.ParamByName('Par_PaiTipo').AsString    := pPaiTipo ;

   // GlobalNet - 29/01/2004

   if (pTipo = '+') and (pValor > 0) and (pMoeda = 'BR') then
       pTipo := 'C' ;

   if (pTipo = '-') and (pValor < 0) and (pMoeda = 'BR') then
       pTipo := 'V' ;

   FQuery.ParamByName('Par_Tipo').AsString       := pTipo ;
   FQuery.ParamByName('Par_Status').AsString     := pStatus ;
   FQuery.ParamByName('Par_Carga').AsString      := ' ' ;
   FQuery.ParamByName('Par_Filial').AsString     := GFilial ;

   // GlobalNet - 29/01/2004

   Try
      FQuery.ExecSql ;
   Except
      on E: Exception do
      Begin
         MensErro := E.Message ;
         Exit ;
      End ;
   End ;

   Result := True ;

End ;

(* ------------------------------------------------------------------------- *
 * CancQuitBR -> Cancela uma quita��o de BR                                  *
(* ------------------------------------------------------------------------- *)
Function TCambio.CancQuitBR ( pOpeId : LongInt ) : Boolean ;
Begin

   Result := False ;

   QPendBR.Close ;
   QPendBR.Sql.Clear ;
   QPendBR.Sql.Add('Select Posicao From PendMoedaBR Where Ope_ID = :Par_ID And TipoOpe = ''P''') ;
   QPendBR.ParamByName('Par_ID').AsInteger := pOpeId ;
   Try
      QPendBR.Open ;
   Except
      on E: Exception do
      Begin
         MensErro := E.Message ;
         Exit ;
      End ;
   End ;

   If ( QPendBR.FieldByName('Posicao').AsString <> 'F' ) Then
   Begin
      QPendBR.Close ;
      QPendBR.Sql.Clear ;
      QPendBR.Sql.Add('Delete PendMoedaBR Where Ope_ID = :Par_OpeID And TipoOpe = ''P''') ;
      QPendBR.ParamByName('Par_OpeID').AsInteger := pOpeId ;
      Try
         QPendBR.ExecSql ;
      Except
         on E: Exception do
         Begin
            MensErro := E.Message ;
            Exit ;
         End ;
      End ;
   End
   Else Begin
      QPendBR.Close ;
      QPendBR.Sql.Clear ;
      QPendBR.Sql.Add('Update PendMoedaBR Set Data = :Par_Data, Status = ''X'',  ' +
                      'Tipo = ''-'', Mercado = ''D'', Posicao = ''A'', Observacao = ''Quita��o cancelada'' ' +
                      'Where Ope_ID = :Par_ID And TipoOpe = ''P''') ;
      QPendBR.ParamByName('Par_Data').AsDateTime := GParFin.DtTrab ;
      QPendBR.ParamByName('Par_ID').AsInteger    := pOpeId ;
      Try
         QPendBR.ExecSql ;
      Except
         on E: Exception do
         Begin
            MensErro := E.Message ;
            Exit ;
         End ;
      End ;
   End ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * GetSaldoCli -> Devolve o saldo de um cliente                              *
(* ------------------------------------------------------------------------- *)
Function TCambio.GetSaldoCli ( pCodCli : String ; pMoeda : String ) : Double ;
Var
   Sql : String ;
Begin

   Result := -1 ;

   If ( (pMoeda <> 'PP') And (pMoeda <> 'TC') And (pMoeda <> 'VTM') And (pMoeda <> 'BR') And (pMoeda <> 'US') And (pMoeda <> 'OM')) Then
   Begin
      SetMensErro('Moeda inv�lida') ;
      Exit ;
   End ;

   Sql := 'Select Valor_US, Valor_Cabo, Valor_VTM, Valor_BR, Valor_OM From Cliente Where CodCliente = ''' +
          pCodCli + '''' ;
   If ( Not FTable.GetExecSqlSel(Sql) ) Then
   Begin
      SetMensErro(FTable.GetMensErro()) ;
      Exit ;
   End ;

   If ( pMoeda = 'PP' ) Then
      Result := FQuery.FieldByName('Valor_US').AsFloat ;
   If ( pMoeda = 'TC' ) Then
      Result := FQuery.FieldByName('Valor_Cabo').AsFloat ;
   If ( pMoeda = 'VTM' ) Then
      Result := FQuery.FieldByName('Valor_VTM').AsFloat ;
   If ( pMoeda = 'BR' ) Then
      Result := FQuery.FieldByName('Valor_BR').AsFloat ;
   If ( pMoeda = 'OM' ) Then
      Result := FQuery.FieldByName('Valor_OM').AsFloat ;

   SetMensErro('') ;

End ;

(* ------------------------------------------------------------------------- *
 * QuitarPendUS -> Quita uma pend�ncia US                                    *
(* ------------------------------------------------------------------------- *)
Function TCambio.QuitarPendUS ( pPendId : LongInt ; pObs : String ) : Boolean ;
Begin
   FSql := 'Update PendMoedaUS Set Quitado = ''S'', Observacao = ''' +
           pObs + ''' Where Pend_ID = ' + Str_IntToStr(pPendID) ;
   If ( Not FTable.GetExecSql(FSql) ) Then
   Begin
      SetMensErro(FTable.GetMensErro()) ;
      Result := False ;
      Exit ;
   End ;
   SetMensErro('') ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * QuitarPendBR -> Quita uma pend�ncia BR                                    *
(* ------------------------------------------------------------------------- *)
Function TCambio.QuitarPendBR ( pPendID : LongInt ; pObs : String ) : Boolean ;
Begin
   FSql := 'Update PendMoedaBR Set Quitado = ''S'', Observacao = ''' +
           pObs + ''' Where Pend_ID = ' + Str_IntToStr(pPendID) ;
   If ( Not FTable.GetExecSql(FSql) ) Then
   Begin
      SetMensErro(FTable.GetMensErro()) ;
      Result := False ;
      Exit ;
   End ;
   SetMensErro('') ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * QuitarPendUS -> Quita uma pend�ncia US  dado uma operacao                 *
(* ------------------------------------------------------------------------- *)
Function TCambio.QuitarPendUSByOpe ( pOpeId : LongInt ; pObs : String ) : Boolean ;
Begin
   FSql := 'Update PendMoedaUS Set Quitado = ''S'', Observacao = ''' +
           pObs + ''' Where Ope_ID = ' + Str_IntToStr(pOpeID) ;
   If ( Not FTable.GetExecSql(FSql) ) Then
   Begin
      SetMensErro(FTable.GetMensErro()) ;
      Result := False ;
      Exit ;
   End ;
   SetMensErro('') ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * QuitarPendBR -> Quita uma pend�ncia BR                                    *
(* ------------------------------------------------------------------------- *)
Function TCambio.QuitarPendBRByOpe ( pOpeID : LongInt ; pObs : String ) : Boolean ;
Begin
   FSql := 'Update PendMoedaBR Set Quitado = ''S'', Observacao = ''' +
           pObs + ''' Where Ope_ID = ' + Str_IntToStr(pOpeID) ;
   If ( Not FTable.GetExecSql(FSql) ) Then
   Begin
      SetMensErro(FTable.GetMensErro()) ;
      Result := False ;
      Exit ;
   End ;
   SetMensErro('') ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * QuitarPend -> Quita uma pend�ncia US                                      *
(* ------------------------------------------------------------------------- *)
Function TCambio.QuitarPend ( pTipo : String ; pPendId : LongInt ; pObs : String ) : Boolean ;
Begin
   FSql := 'Update ' ;
   If ( pTipo = 'US' ) Then
      FSql := FSql + 'PendMoedaUS '
   Else
      FSql := FSql + 'PendMoedaBR ' ;
   FSql := FSql + 'Set Quitado = ''S'', Observacao = ''' ;
   FSql := FSql + pObs + ''' Where Pend_ID = ' + Str_IntToStr(pPendID) ;
   If ( Not FTable.GetExecSql(FSql) ) Then
   Begin
      SetMensErro(FTable.GetMensErro()) ;
      Result := False ;
      Exit ;
   End ;
   SetMensErro('') ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * SetPosBR -> Determina a posicao de uma pendencia BR                       *
(* ------------------------------------------------------------------------- *)
Function TCambio.SetPosBR ( pPendID : LongInt ; pObs : String = '' ; pPosicao : String = '' ) : Boolean ;
Begin
   If ( pObs = '' ) Then
      pObs := GUsuario + ' [' + Date_GetTimeStamp() + ']' ;
   If ( pPosicao = '' ) Then
      pPosicao := 'F' ;
   FSql := 'Update PendMoedaBR Set Posicao = ''' + pPosicao + ''', Observacao = ''' +
           pObs + ''' Where Pend_ID = ' + Str_IntToStr(pPendID) ;
   If ( Not FTable.GetExecSql(FSql) ) Then
   Begin
      SetMensErro(FTable.GetMensErro()) ;
      Result := False ;
      Exit ;
   End ;
   SetMensErro('') ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * TransfPendBR -> Transfere as pend�ncias para a nova data                  *
(* ------------------------------------------------------------------------- *)
Function TCambio.TransfPendBR ( pNewDate : TDateTime ) : Boolean ;
Var
   dOldDate : TDateTime ;
Begin

   // -- Obtendo a data anterior
   FSql := 'Select Max(Data) From PendMoedaBR Where  Data < :Par_NewDate' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(FSql) ;
//   FQuery.ParamByName('Par_Filial').AsString     := GFilial ;
   FQuery.ParamByName('Par_NewDate').AsDateTime  := pNewDate ;
   Try
      FQuery.Open ;
   Except
      On E:Exception Do
      Begin
         SetMensErro(E.Message) ;
         Result := False ;
         Exit ;
      End ;
   End;
   dOldDate := FQuery.Fields[0].AsDateTime ;

   If ( dOldDate = pNewDate ) Then
   Begin
      Result := True ;
      Exit ;
   End;

   // -- Transportando as pend�ncias
   FSql := 'Update PendMoedaBR Set Data = :Par_NewDate Where  ' +
           ' Data = :Par_OldDate And Posicao <> ''F''' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(FSql) ;
//   FQuery.ParamByName('Par_Filial').AsString     := GFilial ;
   FQuery.ParamByName('Par_NewDate').AsDateTime  := pNewDate ;
   FQuery.ParamByName('Par_OldDate').AsDateTime  := dOldDate ;
   Try
      FQuery.ExecSql ;
   Except
      On E:Exception Do
      Begin
         SetMensErro(E.Message) ;
         Result := False ;
         Exit ;
      End ;
   End;

   SetMensErro('') ;
   Result := True ;

End ;

(* ------------------------------------------------------------------------- *
 * SetFormaBR -> Determina a forma de pagamento de uma pendencia BR          *
(* ------------------------------------------------------------------------- *)
Function TCambio.SetFormaBR ( pPendID : LongInt ; pForma : String ) : Boolean ;
Begin
   FSql := 'Update PendMoedaBR Set Forma = ''' + pForma + ''' Where Pend_ID = ' + Str_IntToStr(pPendID) ;
   If ( Not FTable.GetExecSql(FSql) ) Then
   Begin
      SetMensErro(FTable.GetMensErro()) ;
      Result := False ;
      Exit ;
   End ;
   SetMensErro('') ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * UpdCliBR -> Atualiza o Valor_BR de um cliente                             *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdCliBR ( pCliente : String ; pValor : Double ;
                            pPaiId : Integer ; pPaiTipo : String ; pObs : String = '' ) : Boolean ;
Var
   sTipo : String ;
Begin
   If ( pObs = '' ) Then
      pObs := GUsuario + ' [' + Date_GetTimeStamp() + ']' ;
   FSql := 'Update Cliente Set Valor_BR = Valor_BR + ' + Str_FloatToDBStr(pValor) +
           ' Where CodCliente = ''' + pCliente + '''' ;
   If ( Not FTable.GetExecSql(FSql) ) Then
   Begin
      SetMensErro(FTable.GetMensErro()) ;
      Result := False ;
      Exit ;
   End ;
   // -- MovCliente BR
   If ( pValor < 0 ) Then
      sTipo := '-'
   Else
      sTipo := '+' ;
   If ( Not InsMovCliente(GParFin.DtTrab,pCliente,'BR',pValor,pObs,sTipo,pPaiId,pPaiTipo,GCambio.Status) ) Then
   Begin
      SetMensErro(FTable.GetMensErro()) ;
      Result := False ;
      Exit ;
   End ;
   SetMensErro('') ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * SetPosCom -> Determina a posicao da compra                                *
(* ------------------------------------------------------------------------- *)
Function TCambio.SetPosCom ( pOpeId : LongInt ; pPosicao : String = '' ) : Boolean ;
Begin
   If ( pPosicao = '' ) Then
      pPosicao := 'X' ;
   FSql := 'Update Compras Set Posicao = ''' + pPosicao +
           ''' Where Ope_ID = ' + Str_IntToStr(pOpeID) ;
   If ( Not FTable.GetExecSql(FSql) ) Then
   Begin
      SetMensErro(FTable.GetMensErro()) ;
      Result := False ;
      Exit ;
   End ;
   SetMensErro('') ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * SetPosVen -> Determina a posicao da venda                                 *
(* ------------------------------------------------------------------------- *)
Function TCambio.SetPosVen ( pOpeId : LongInt ; pPosicao : String = '' ) : Boolean ;
Begin
   If ( pPosicao = '' ) Then
      pPosicao := 'X' ;
   FSql := 'Update Vendas Set Posicao = ''' + pPosicao +
           ''' Where Ope_ID = ' + Str_IntToStr(pOpeID) ;
   If ( Not FTable.GetExecSql(FSql) ) Then
   Begin
      SetMensErro(FTable.GetMensErro()) ;
      Result := False ;
      Exit ;
   End ;
   SetMensErro('') ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * SetQuitado -> Indica que um lancamento de compra/venda foi quitado        *
(* ------------------------------------------------------------------------- *)
Function TCambio.SetQuitado(psTipo : String ; pOpeId : LongInt ) : Boolean ;
Begin
   If ( psTipo = 'Ven' ) Then
      FSql := 'Update Vendas Set Quitado = ''S'' Where Ope_ID = ' + Str_IntToStr(pOpeID)
   Else
      FSql := 'Update Compras Set Quitado = ''S'' Where Ope_ID = ' + Str_IntToStr(pOpeID) ;
   If ( Not FTable.GetExecSql(FSql) ) Then
   Begin
      SetMensErro(FTable.GetMensErro()) ;
      Result := False ;
      Exit ;
   End ;
   SetMensErro('') ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * InsMovUpdSaldo -> Insere um movimento e atualiza o saldo da conta         *
(* ------------------------------------------------------------------------- *)
Function TCambio.InsMovUpdSaldo : Boolean ;
Var
   T : TSQLTableClass ;
   Sql : String ;
Begin

   Result := False ;

   T := TSQLTableClass.Create() ;
   T.OpenTable('MovCorrente') ;
   T.SetFieldValue('CodConta',Conta) ;
   T.SetFieldValue('DtMov',Data) ;
   T.SetFieldValue('TipMov',Tipo) ;
   T.SetFieldValue('Valor',Valor) ;
   T.SetFieldValue('Historico',Obs) ;
   T.SetFieldValue('CodCenCusto',CodCenCusto) ;
   T.SetFieldValue('DocOrigem',DocOrigem) ;
   T.SetFieldValue('DocDestino',DocDestino) ;
   T.SetFieldValue('CodCliFor',Cliente) ;
   T.SetFieldValue('Pai_ID',PaiID) ;
   T.SetFieldValue('EmiteAviso',EmiteAviso) ;
   T.SetFieldValue('EmiteCheque',EmiteCheque) ;
   T.SetFieldValue('CodFilial',GFilial) ;
   T.SetFieldValue('Carga',Carga) ;
   T.SetFieldValue('Ok',' ') ;
   If ( Not T.Insert() ) Then
   Begin
      MensErro := T.GetMensErro() ;
      T.Destroy ;
      Exit ;
   End ;
   T.Destroy ;

   if (Conta <> 'AC') and (Conta <> '*CXUS') {and (Conta <> '*PAGAR*')} then
       Sql := 'Update SaldosBancarios Set ValorFinal = ValorFinal + :Par_Valor ' +
              'Where CodFilial = :Par_Filial And CodConta = :Par_Conta And Data = :Par_Data'
   else
       begin
         Result := true;
         Exit;
       end;

   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_Filial').AsString := GFilial ;
   FQuery.ParamByName('Par_Conta').AsString  := Conta ;
   FQuery.ParamByName('Par_Data').AsDateTime := Data ;
   FQuery.ParamByName('Par_Valor').AsFloat   := Valor ;
   Try
       FQuery.ExecSql ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   End ;

   Result := True ;

End ;

(* ------------------------------------------------------------------------- *
 * SeekGet -> Pega um valor em uma tabela                                    *
(* ------------------------------------------------------------------------- *)
Function TCambio.SeekGet ( pColGet : String ; pTableName : String ; pColName : String ;
                           pValue : Variant ; pTipo : Integer ) : String ;
Var
   Sql : String ;
Begin
   Result := '' ;
   Sql := 'Select ' + pColGet + ' From ' + pTableName + ' Where ' + pColName ;
   If ( pTipo = TYPE_STRING ) Then
      Sql := Sql + ' = ''' + pValue + '''' ;
   If ( pTipo = TYPE_INTEGER ) Then
      Sql := Sql + ' = ' + Str_IntToStr(pValue) ;
   If ( pTipo = TYPE_FLOAT ) Then
      Sql := Sql + ' = ' + Str_FloatToStr(pValue) ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   Try
      FQuery.Open ;
   Except
      On E:Exception Do
      Begin
         SetMensErro(FTable.GetMensErro()) ;
         Exit ;
      End ;
   End;
   SetMensErro('') ;
   Result := FQuery.Fields[0].AsString ;
End ;

(* ------------------------------------------------------------------------- *
 * GetNextBol -> Pega o pr�ximo n�mero da boleta                             *
(* ------------------------------------------------------------------------- *)
Function TCambio.GetNextBol : LongInt ;
Begin
   FSql := 'Select NumBoleta From Filial Where CodFilial = ''' + GFilial + '''' ;
   If ( Not FTable.GetExecSqlSel(FSql) ) Then
   Begin
      SetMensErro(FTable.GetMensErro()) ;
      Result := -1 ;
      Exit ;
   End;
   Result := FQuery.Fields[0].AsInteger + 1 ;
   FSql := 'Update Filial Set NumBoleta = NumBoleta + 1 Where CodFilial = ''' + GFilial + '''' ;
   If ( Not FTable.GetExecSql(FSql) ) Then
   Begin
      SetMensErro(FTable.GetMensErro()) ;
      Result := -2 ;
      Exit ;
   End;
end ;

(* ------------------------------------------------------------------------- *
 * LimiteOk -> Testa o limite BR do cliente para a opera��o                  *
(* ------------------------------------------------------------------------- *)
Function TCambio.LimiteOK ( pCliente : String ; pValor : Double; var Limite, Disponivel : Double ) : Boolean ;
Var
   Aberto, nDif : Double ;
Begin

   Result := False ;

   // -- Pega o limite do cliente
   FSql := 'Select LimiteCredito From Clientes Where CodCliente = ''' + pCliente + '''' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(FSql) ;
   Try
      FQuery.Open ;
   Except
      On E:Exception Do
      Begin
         SetMensErro(E.Message) ;
         Exit ;
      End ;
   End;

   Limite := FQuery.FieldByName('LimiteCredito').AsFloat ;


   FSql := 'Select ISNull(Sum(valor),0) as Aberto From ConRec Where CodCliente = ' + QuotedStr(pCliente) ;
   FSql := FSql + 'and Status = ''A''  ';

   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(FSql) ;
   Try
      FQuery.Open ;
   Except
      On E:Exception Do
      Begin
         SetMensErro(E.Message) ;
         Exit ;
      End ;
   End;

  Aberto := FQuery.FieldByName('Aberto').AsFloat;

  Disponivel := Limite - Aberto;

   SetMensErro('') ;
   // -- Diferen�a
   nDif := Disponivel - pValor ;
   If ( nDif < 0 ) Then
   Begin
      Exit ;
   End;

   Result := True ;

End ;

(* ------------------------------------------------------------------------- *
 * UptLimCli -> Atualiza o limite do cliente                                 *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdLimCli ( pCliente : String ; pValor : Double ) : Boolean ;
Begin
   Result := False ;
   FSql := 'Update Cliente Set Limite_Cheque = Limite_Cheque - :Par_Valor Where ' +
           'CodCliente = :Par_Cliente' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(FSql) ;
   FQuery.ParamByName('Par_Valor').AsFloat    := pValor ;
   FQuery.ParamByName('Par_Cliente').AsString := pCliente ;
   Try
//      FQuery.ExecSQL ;
   Except
      On E:Exception Do
      Begin
         SetMensErro(FTable.GetMensErro()) ;
         Exit ;
      End ;
   End;
   SetMensErro('') ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * UptLimCli -> Atualiza o limite do cliente                                 *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdLimCliPend ( pCliente : String ; pValor : Double ) : Boolean ;
Begin
   Result := False ;
   FSql := 'Update Cliente Set Limite_Cheque = Limite_Cheque - :Par_Valor Where ' +
           'CodCliente = :Par_Cliente' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(FSql) ;
   FQuery.ParamByName('Par_Valor').AsFloat    := pValor ;
   FQuery.ParamByName('Par_Cliente').AsString := pCliente ;
   Try
      FQuery.ExecSQL ;
   Except
      On E:Exception Do
      Begin
         SetMensErro(FTable.GetMensErro()) ;
         Exit ;
      End ;
   End;
   SetMensErro('') ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * DelComVenEsp -> Exclui uma compra ou venda especialmente                  *
(* ------------------------------------------------------------------------- *)
Function TCambio.DelComVenEsp ( pOpcao : String ; pID : Integer ) : Boolean ;
Var
   T : TSQLTableClass ;
Begin
   Result := False ;
   T := TSQLTableClass.Create() ;
   If ( pOpcao = 'C' ) Then
      T.OpenTable('Compras')
   Else
      T.OpenTable('Vendas') ;
   T.ResetKey ;
   T.SetFieldKey('Ope_ID') ;
   T.SetKeyValue('Ope_ID',pID) ;
   If ( Not T.Find(True) ) Then
   Begin
      MensErro := T.GetMensErro() ;
      Exit ;
   End ;
   Result := T.Delete() ;
   If ( Not Result ) Then
   Begin
      MensErro := T.GetMensErro() ;
      Exit ;
   End ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * SeekCliBan -> Busca os dados do banco de um cliente                       *
(* ------------------------------------------------------------------------- *)
Function TCambio.SeekCliBan ( pCliente : String ) : Boolean ;
Begin
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add('Select Banco, Agencia, Conta, NomeDep From Cliente Where ' +
                       'CodCliente = ''' + pCliente + '''') ;
   Try
      FQuery.Open ;
   Except
      MensErro := FTable.GetMensErro() ;
      Result := False ;
      Exit ;
   End ;
   If ( FQuery.Eof ) Then
   Begin
      Result := False ;
      Exit ;
   End ;
   Banco   := FQuery.FieldByName('Banco').AsString ;
   Agencia := FQuery.FieldByName('Agencia').AsString ;
   Conta   := FQuery.FieldByName('Conta').AsString ;
   Nome    := FQuery.FieldByName('NomeDep').AsString ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * InsNovaConta -> Insere uma nova conta baseado nas vari�veis do GCanbio    *
(* ------------------------------------------------------------------------- *)
Function TCambio.InsNovaConta ( pCodigo : String ) : Boolean ;
Var
   Sql : String ;
Begin
   FQuery.Close ;
   FQuery.Sql.Clear ;
   Sql := 'Insert Into ContaCor ( CodConta, Nome, Agencia, NomeConta, ' +
          'CodFilial, Carga) Values ( ' ;
   Sql := Sql + '''' + pCodigo + ''', ' ;
   Sql := Sql + '''' + GCambio.Conta + ''', ' ;
   Sql := Sql + '''' + GCambio.Agencia + ''', ' ;
   Sql := Sql + '''' + GCambio.Nome + ''', ' ;
   Sql := Sql + '''' + GFilial + ''', '' '' )' ;
   FQuery.Sql.Add(Sql) ;
   Try
      FQuery.ExecSql ;
   Except
      MensErro := FTable.GetMensErro() ;
      Result := False ;
      Exit ;
   End ;
   Sql := 'Insert Into SaldosBancarios ( CodFilial, CodConta, Data, ValorInicial, ' +
          'ValorFinal, Carga ) Values ( ''' + GFilial + ''', ''' +
          pCodigo + ''', :Par_Data, 0, 0, '' '')' ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_Data').AsDateTime := GParFin.DtTrab ;
   Try
      FQuery.ExecSql ;
   Except
      MensErro := FTable.GetMensErro() ;
      Result := False ;
      Exit ;
   End ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * UpdNovaConta -> Altera uma nova conta baseado nas vari�veis do GCanbio    *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdNovaConta ( pCodigo : String ; pNome : String ; pAgencia : String ;
                                pNomeConta : String ) : Boolean ;
Var
   Sql : String ;
Begin
   FQuery.Close ;
   FQuery.Sql.Clear ;
   Sql := 'Update ContaCor Set Nome = :Par_Nome, Agencia = :Par_Agencia, ' +
          'NomeConta = :Par_NomeConta Where CodConta = :Par_Codigo And ' +
          'CodFilial = :Par_Filial' ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_Nome').AsString      := pNome ;
   FQuery.ParamByName('Par_Agencia').AsString   := pAgencia ;
   FQuery.ParamByName('Par_NomeConta').AsString := pNomeConta ;
   FQuery.ParamByName('Par_Codigo').AsString    := pCodigo ;
   FQuery.ParamByName('Par_Filial').AsString    := GFilial ;
   Try
      FQuery.ExecSql ;
   Except
      MensErro := FTable.GetMensErro() ;
      Result := False ;
      Exit ;
   End ;
   SetMensErro('') ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * UpdBancoCli --> Atualiza os dados da conta do cliente                     *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdBancoCli ( pCodigo, pBanco, pAgencia, pConta, pNome : String ) : Boolean ;
Var
   Sql : String ;
Begin
   FQuery.Close ;
   FQuery.Sql.Clear ;
   Sql := 'Update Cliente Set Banco = :Par_Banco, Agencia = :Par_Agencia, ' +
          'Conta = :Par_Conta, NomeDep = :Par_Nome Where CodCliente = :Par_Codigo' ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_Banco').AsString   := pBanco ;
   FQuery.ParamByName('Par_Agencia').AsString := pAgencia ;
   FQuery.ParamByName('Par_Conta').AsString   := pConta ;
   FQuery.ParamByName('Par_Codigo').AsString  := pCodigo ;
   FQuery.ParamByName('Par_Nome').AsString    := pNome ;
   Try
      FQuery.ExecSql ;
   Except
      MensErro := FTable.GetMensErro() ;
      Result := False ;
      Exit ;
   End ;
   SetMensErro('') ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * UpdBordQuitPagar -> Atualiza a quita��o pela pend�ncia pagar              *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdBordQuitPagar ( pLanc : Integer ) : Boolean ;
Var
   Sql : String ;
Begin
   FQuery.Close ;
   FQuery.Sql.Clear ;
   Sql := 'Update Borderos Set QuitPagar = ''S'' Where Lanc_ID = :Par_Lanc' ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_Lanc').AsInteger := pLanc ;
   Try
      FQuery.ExecSql ;
   Except
      MensErro := FTable.GetMensErro() ;
      Result := False ;
      Exit ;
   End ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * UpdMovCliPaiID -> Atualiza o PaiID dos movimentos                         *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdMovCliPaiID ( OldPaiID, NewPaiID : Longint ) : Boolean ;
Var
   Sql : String ;
Begin
   FQuery.Close ;
   FQuery.Sql.Clear ;
   Sql := 'Update MovCliente Set Pai_ID = :Par_New Where Pai_ID = :Par_Old' ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_New').AsInteger := NewPaiID ;
   FQuery.ParamByName('Par_Old').AsInteger := OldPaiID ;
   Try
      FQuery.ExecSql ;
   Except
      MensErro := FTable.GetMensErro() ;
      Result := False ;
      Exit ;
   End ;
   Result := True ;
End ;

function TCambio.InsConPagRec(Tipo, Status: String; Par_Valor : Double): Boolean;
Var
   T : TSQLTableClass ;
Begin
   T := TSQLTableClass.Create() ;
   if Tipo = 'P' then
     T.OpenTable('ConPag')
   else
     T.OpenTable('ConRec') ;

   T.ResetKey ;
//   T.SetFieldKey('Doc_ID') ;
   T.SetFieldValue('CodCliente', Cliente );
   T.SetFieldValue('DocDestino', IntToStr(OpeID) );
   T.SetFieldValue('DocOrigem',  DocOrigem );
   T.SetFieldValue('NumOcorrencia', Parcela ) ;
   T.SetFieldValue('QtdOcorrencia', NParcela ) ;
   T.SetFieldValue('CodConta', Banco) ;
   T.SetFieldValue('CodMoeda', 'R$') ;
   T.SetFieldValue('Valor',  Par_Valor );
   T.SetFieldValue('ValorQuitado', Par_Valor);
   T.SetFieldValue('ValorDesconto', 0 );
   T.SetFieldValue('DataEmissao', Data);
   T.SetFieldValue('DataVencimento', Data);
   T.SetFieldValue('DataQuitacao', Data);
   T.SetFieldValue('CodFilial', Filial );
   T.SetFieldValue('Historico', Obs) ;
   T.SetFieldValue('CodContabil', GParFin.ContaReceber) ;
   T.SetFieldValue('TipoDocQuitacao', '2') ;
   T.SetFieldValue('Status', Status);
   Result := T.Insert() ;
   If ( Not Result ) Then
      MensErro := T.GetMensErro() ;
   T.Destroy ;
End ;

function TCambio.GetLimiteCliNovo : Double;
var
  FSql : String;
begin

   FSql := 'Select LimiteCliNovo From Parametros ' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(FSql) ;
   Try
      FQuery.Open ;
   Except
      On E:Exception Do
      Begin
         SetMensErro(E.Message) ;
         Exit ;
      End ;
   End;

   Result := FQuery.FieldByName('LimiteCliNovo').AsFloat ;
   FQuery.Close ;

end;

function TCambio.AtualizaSaldo(CodConta: String): Boolean;
var
  FSql : String;
begin

   FSql := 'Select MostraSaldo From ContaCor ' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(FSql) ;
   Try
      FQuery.Open ;
   Except
      On E:Exception Do
      Begin
         SetMensErro(E.Message) ;
         Exit ;
      End ;
   End;

   Result := FQuery.FieldByName('MostraSaldo').AsString = 'S';
   FQuery.Close ;

end;

function TCambio.UpdEstoque(pCodProduto: String; pCodGrupo : String; pData: TDateTime;
  pQtde: Double; pTipoMov, pCodCenEstoque, pCodFilial: String;
  pInsMov: Boolean): Boolean;
var
  Sql : String;
begin

   Result := False ;
   If ( pQtde = 0 ) Then
   Begin
      Result := True ;
      Exit ;
   End;

   if pTipoMov = 'S' then
     pQtde := pQtde * (-1);


   Sql := 'Select ID From Estoque ' +
          'Where CodProduto = :Par_CodProduto and ' +
          '      CodFilial = :Par_CodFilial and '+
          '      CodCentroEstoque = :Par_Centro ';
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_CodProduto').AsString  := pCodProduto ;
   FQuery.ParamByName('Par_CodFilial').AsString   := pCodFilial ;
   FQuery.ParamByName('Par_Centro').AsString      := pCodCenEstoque ;
   Try
     FQuery.Open ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   end;

   if FQuery.IsEmpty then
   begin
     Sql := 'Insert Estoque (CodProduto, CodFilial, CodCentroEstoque, Qtde_Estoque, Qtde_Reservado ) ';
     Sql := Sql + 'Values (:Par_CodProduto, :Par_CodFilial, :Par_Centro, :Par_Qtde, 0) ';
   end
   else
   begin
     if PaiTipo <> 'R' then
       Sql := 'Update Estoque Set Qtde_Estoque = Qtde_Estoque + :Par_Qtde '
     else
       Sql := 'Update Estoque Set Qtde_Reservado = Qtde_Reservado + :Par_Qtde ';
     Sql := Sql + 'Where CodProduto = :Par_CodProduto and ' +
//            '      CodGrupo = :Par_CodGrupo and ' +
            '      CodFilial = :Par_CodFilial and '+
            '      CodCentroEstoque = :Par_Centro ';
   end;

   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_CodProduto').AsString  := pCodProduto ;
//   FQuery.ParamByName('Par_CodGrupo').AsString    := pCodGrupo ;
   FQuery.ParamByName('Par_CodFilial').AsString   := pCodFilial ;
   FQuery.ParamByName('Par_Centro').AsString      := pCodCenEstoque ;
   FQuery.ParamByName('Par_Qtde').AsFloat         := pQtde ;
   Try
     FQuery.ExecSql ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   end;

   If ( pInsMov ) Then
   Begin
      If ( Not InsMovEstoque(pCodProduto,pCodGrupo,pData,pQtde,pTipoMov,pCodCenEstoque,pCodFilial,Obs) ) Then
         Exit ;
   End ;
   Result := True ;

end;

function TCambio.InsMovEstoque(pCodProduto: String; pCodGrupo : String; pData: TDateTime;
  pQtde: Double; pTipoMov, pCodCenEstoque, pCodFilial,
  pObs: String): Boolean;
Var
   Sql : String ;
Begin
   Result := False ;
   pObs:= Copy(pObs, 1, 200) ;

   Sql := 'Insert Into MovEstoque ( DtMov, CodProduto, CodGrupo, TipoMov, Qtde, CodTipoMov, Pai_Mov, Documento, OrigemMov, Historico, ' +
          'CodFilial, CodCenEstoque, CodUsuario )  ' +
      	  'Values ( :Par_DtMov, :Par_CodProduto, :Par_CodGrupo, :Par_TipoMov, :Par_Qtde, :Par_CodTipoMov, :Par_Pai_Mov, :Par_Documento, :Par_OrigemMov, :Par_Historico, ' +
          ':Par_CodFilial, :Par_CodCenEstoque, :Par_CodUsuario )' ;

   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_DtMov').AsDateTime       := pData ;
   FQuery.ParamByName('Par_CodProduto').AsString    := pCodProduto ;
   FQuery.ParamByName('Par_CodGrupo').AsString      := pCodGrupo ;
   FQuery.ParamByName('Par_TipoMov').AsString       := pTipoMov ;
   FQuery.ParamByName('Par_Qtde').AsFloat           := pQtde ;
   FQuery.ParamByName('Par_CodTipoMov').AsString    := '' ;
   FQuery.ParamByName('Par_Pai_Mov').AsInteger      := PaiID ;
   FQuery.ParamByName('Par_Documento').AsString     := DocOrigem ;
   FQuery.ParamByName('Par_OrigemMov').AsString     := PaiTipo ;
   FQuery.ParamByName('Par_Historico').AsString     := pObs ;
   FQuery.ParamByName('Par_CodFilial').AsString     := pCodFilial;
   FQuery.ParamByName('Par_CodCenEstoque').AsString := pCodCenEstoque;
   FQuery.ParamByName('Par_CodUsuario').AsString    := GUsuario ;

   Try
      FQuery.ExecSql ;
   Except
      on E: Exception do
      Begin
         MensErro := E.Message ;
         Exit ;
      End ;
   End ;

   Result := True ;

end;

end.



