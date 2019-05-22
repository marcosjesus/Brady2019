unit CCambio ;

interface

Uses
     SysUtils, Windows, DB, DBTables, Classes, SqlTableFun, StdCtrls ;

Const

   DBTYPE_PARADOX      = 1 ;
   DBTYPE_SQLSERVER_65 = 2 ;
   DBTYPE_ACCESS       = 3 ;
   DBTYPE_SQLSERVER_70 = 4 ;

Type TCambio = Class(TComponent)
       Private
           FTable : TSqlTable ;
           FQuery : TQuery ;
           FDBType : Integer ;
           FDBName : String ;
           FSql : String ;
           Procedure SetMensErro ( pMens : String ) ;
       Public
           Eof : Boolean ;
           Error : Boolean ;
           MensErro : String ;
           OpeID : Integer ;
           Data : TDateTime ;
           Cliente : String[15] ;
           Valor : Double ;
           Qtde : Double ;
           Taxa : Double ;
           Conta : String[15] ;
           NumLanc : String ;
           Tipo : String ;
           Forma : String ;
           Mercado : String ;
           Posicao : String ;
           Status : String[1] ;
           Quitado : String[1] ;
           Obs : String ;
           Filial : String[15] ;
           Carga : String[1] ;
           DocOrigem, DocDestino : String ;
           Banco, Agencia, Nome : String ;
           Indice : Integer ;
           // Lista das pendências em US
           QPendUS : TQuery ;
           // Lista das pendências em BR
           QPendBR : TQuery ;
           Constructor Create ( DBType : Integer = -1 ; DBName : String = '' ) ; reintroduce ;
           Destructor Destroy ; reintroduce ;
           Function BeginTrans : Boolean ;
           Function ExecCommit : Boolean ;
           Function ExecRollBack : Boolean ;
           Function BoaTaxa ( pTaxa, pMedia : Double ) : Boolean ;
           Function CalcMed ( pOpcao : String ) : Double ;
           Function ValorDiaBanco ( pConta : String ; pData : TDateTime ; pValor : Double ) : Boolean ;
           Function InsNovoLanc ( pData : TDateTime ) : Boolean ;
           Function GetValContaCor ( pConta : String ; pData : TDateTime ; Var ValIni : Double ; Var ValFim : Double ) : Boolean ;
           Function UpdSaldoConta ( pConta : String ; pData : TDateTime ;
                                    pValor : Double ; pObs : String = '' ) : Boolean ;
           Function InsComVen ( pOpcao : Char ) : Boolean ;
           Function UpdComVen ( pOpcao : Char ; pID : Integer = -1 ) : Boolean ;
           Function DelComVen ( pOpcao : Char ; pID : Integer = -1 ) : Boolean ;
           Function UpdContaUS ( pValor : Double ; pObs : String = '' ) : Boolean ;
           Function UpdContaBR ( pValor : Double ; pObs : String = '' ) : Boolean ;
           Function InsPendUS : Boolean ;
           Function InsPendBR : Boolean ;
           Function UpdPendUS ( pID : Integer = -1 ) : Boolean ;
           Function GetPendUS ( pID : Integer = -1 ) : Boolean ;
           Function GetPendBR ( pID : Integer = -1 ) : Boolean ;
           Function UpdSaldoCli ( pTipo : String ; pUS_CB : String = '' ;
                                  pCodCli : String = '' ; pQtde : Double = 0 ;
                                  pValor : Double = 0 ; pObs : String = '' ) : Boolean ;
           Function InsMovCliente ( pData : TDateTime ; pCodCliente : String ;
                                    pMoeda : String ; pValor : Double ; pObs : String ;
                                    pTipo : String ; pPai : Integer = 0 ) : Boolean ;
           Function InsMovCorrente ( pConta : String ; pData : TDateTime ;
                                     pValor : Double ; pObs : String = '' ) : Boolean ;
           Function DelPendBR ( pOpeId : LongInt ; pOpcao : String ) : Boolean ;
           Function GetSaldoCli ( pCodCli : String ; pMoeda : String ) : Double ;
           Function QuitarPendBR ( pOpeId : LongInt ; pObs : String ) : Boolean ;
           Function QuitarPendUS ( pOpeId : LongInt ; pObs : String ) : Boolean ;
           Function SetPosBR ( pPendID : LongInt ; pObs : String = '' ; pPosicao : String = '' ) : Boolean ;
           Function SetFormaBR ( pPendID : LongInt ; pForma : String ) : Boolean ;
           Function SetPosVen ( pOpeId : LongInt ; pPosicao : String = '' ) : Boolean ;
           Function SetPosCom ( pOpeId : LongInt ; pPosicao : String = '' ) : Boolean ;
           Function UpdCliBR ( pCliente : String ; pValor : Double ; pObs : String = '' ) : Boolean ;
End ;

implementation

Uses
   Global, TestFun, StrFun, NumFun, MensFun, DateFun, ObjFun, Constantes ;

Const
   ERROR_OK        = 0 ;
   ERROR_QUERY     = 1 ;
   ERROR_EOF       = 2 ;
   ERROR_SALDOANT  = 3 ;
   ERROR_CHECK     = 4 ;

(* ------------------------------------------------------------------------- *
 * Create -> Cria a variável                                                 *
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
   FTable := TSqlTable.Create ;
   FTable.OpenTable('SaldosBancarios') ;
   FTable.SetFieldKey('CodFilial;CodConta;Data') ;
   FQuery := TQuery.Create(Self) ;
   FQuery.DatabaseName := FDBName ;
   QPendUS := TQuery.Create(Self) ;
   QPendUS.DatabaseName := FDBName ;
   QPendBR := TQuery.Create(Self) ;
   QPendBR.DatabaseName := FDBName ;
End ;

(* ------------------------------------------------------------------------- *
 * Destroy -> Destroi a variável                                             *
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
 * ValorDiaBanco -> Inclui um valor na tabela SaldosBancarios                *
(* ------------------------------------------------------------------------- *)
Function TCambio.ValorDiaBanco ( pConta : String ; pData : TDateTime ; pValor : Double ) : Boolean ;
Var
   Sql : String ;
Begin
   Result := False ;
   Sql := 'Select * From SaldosBancarios Where CodFilial = :Par_Filial And ' +
          'CodConta = :Par_Conta And Data = :Par_Data' ;
   FTable.QResult.Close ;
   FTable.QResult.Sql.Clear ;
   FTable.QResult.Sql.Add(Sql) ;
   FTable.QResult.ParamByName('Par_Filial').AsString := GFilial ;
   FTable.QResult.ParamByName('Par_Conta').AsString  := pConta ;
   FTable.QResult.ParamByName('Par_Data').AsDateTime := pData ;
   Try
       FTAble.QResult.Open ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   End ;
   If ( FTable.QResult.Eof ) Then
      Sql := 'Insert Into SaldosBancarios ( CodFilial, CodConta, Data, ValorInicial, ValorFinal ) ' +
             'Values ( :Par_Filial, :Par_Conta, :Par_Data, :Par_Valor, :Par_Valor )'
   Else
      Sql := 'Update SaldosBancarios Set ValorInicial = :Par_Valor ' +
             'Where CodFilial = :Par_Filial And CodConta = :Par_Conta And Data = :Par_Data' ;
   FTable.QResult.Close ;
   FTable.QResult.Sql.Clear ;
   FTable.QResult.Sql.Add(Sql) ;
   FTable.QResult.ParamByName('Par_Filial').AsString := GFilial ;
   FTable.QResult.ParamByName('Par_Conta').AsString  := pConta ;
   FTable.QResult.ParamByName('Par_Data').AsDateTime := pData ;
   FTable.QResult.ParamByName('Par_Valor').AsFloat   := pValor ;
   Try
       FTAble.QResult.ExecSql ;
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
 * InsNovosLanc -> Insere um novo registro de lançamentos                    *
(* ------------------------------------------------------------------------- *)
Function TCambio.InsNovoLanc ( pData : TDateTime ) : Boolean ;
Var
   Sql : String ;
Begin
   Result := False ;
   Sql := 'Select * From NumLancamentos Where CodFilial = :Par_Filial And ' +
          'Data = :Par_Data' ;
   FTable.QResult.Close ;
   FTable.QResult.Sql.Clear ;
   FTable.QResult.Sql.Add(Sql) ;
   FTable.QResult.ParamByName('Par_Filial').AsString := GFilial ;
   FTable.QResult.ParamByName('Par_Data').AsDateTime := pData ;
   Try
       FTAble.QResult.ExecSql ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   End ;
   If ( Not FTable.QResult.Eof ) Then
   Begin
      Result := True ;
      Exit ;
   End ;
   Sql := 'Insert Into NumLancamentos ( CodFilial, Data, NumCompra, NumVenda, ' +
          'NumMov, NumLanc, NumBR, NumUS ) Values ( :Par_Filial, :Par_Data, ' +
          '0, 0, 0, 0, 0, 0 )' ;
   FTable.QResult.Close ;
   FTable.QResult.Sql.Clear ;
   FTable.QResult.Sql.Add(Sql) ;
   FTable.QResult.ParamByName('Par_Filial').AsString := GFilial ;
   FTable.QResult.ParamByName('Par_Data').AsDateTime := pData ;
   Try
       FTable.QResult.ExecSql ;
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
   Sql := 'Select ValorInicial, ValorFinal From SaldosBancarios Where CodFilial = :Par_Filial And ' +
          'CodConta = :Par_Conta And Data = :Par_Data' ;
   FTable.QResult.Close ;
   FTable.QResult.Sql.Clear ;
   FTable.QResult.Sql.Add(Sql) ;
   FTable.QResult.ParamByName('Par_Filial').AsString := GFilial ;
   FTable.QResult.ParamByName('Par_Conta').AsString  := pConta ;
   FTable.QResult.ParamByName('Par_Data').AsDateTime := pData ;
   Try
       FTAble.QResult.Open ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   End ;
   If ( FTable.QResult.Eof ) Then
      Exit ;
   ValIni := FTable.QResult.FieldByName('ValorInicial').AsFloat ;
   ValFim := FTable.QResult.FieldByName('ValorFinal').AsFloat ;
   Result := True ;
   FTable.QResult.Close ;
End ;

(* ------------------------------------------------------------------------- *
 * UpdSaldoConta -> Atualiza o saldo de uma conta                            *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdSaldoConta ( pConta : String ; pData : TDateTime ;
                                 pValor : Double ; pObs : String = '' ) : Boolean ;
Var
   Sql : String ;
Begin
   Result := False ;
   Sql := 'Update SaldosBancarios Set ValorFinal = ValorFinal + :Par_Valor ' +
          'Where CodFilial = :Par_Filial And CodConta = :Par_Conta And Data = :Par_Data' ;
   FTable.QResult.Close ;
   FTable.QResult.Sql.Clear ;
   FTable.QResult.Sql.Add(Sql) ;
   FTable.QResult.ParamByName('Par_Filial').AsString := GFilial ;
   FTable.QResult.ParamByName('Par_Conta').AsString  := pConta ;
   FTable.QResult.ParamByName('Par_Data').AsDateTime := pData ;
   FTable.QResult.ParamByName('Par_Valor').AsFloat   := pValor ;
   Try
       FTAble.QResult.ExecSql ;
   Except
       on E: Exception do
       Begin
           MensErro := E.Message ;
           Exit ;
       End ;
   End ;
   If ( Not InsMovCorrente(pConta,pData,pValor,pObs) ) Then
      Exit ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * UpdContaUS -> Atualiza o saldo da conta US                                *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdContaUs ( pValor : Double ; pObs : String = '' ) : Boolean ;
Begin
   If ( pObs = '' ) Then
      pObs := Obs ;
   Result := UpdSaldoConta(GParFin.ContaUS,GParFin.DtTrab,pValor,pObs) ;
   If ( Not Result ) Then
   Begin
      Mens_MensErro(MensErro) ;
      Mens_MensInf('Problemas na atualização do saldo da conta US') ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * UpdContaBR -> Atualiza o saldo da conta BR                                *
(* ------------------------------------------------------------------------- *)
Function TCambio.UpdContaBR ( pValor : Double ; pObs : String = '' ) : Boolean ;
Begin
   Result := UpdSaldoConta(GParFin.ContaBR,GParFin.DtTrab,pValor,pObs) ;
   If ( Not Result ) Then
   Begin
      Mens_MensErro(MensErro) ;
      Mens_MensInf('Problemas na atualização do saldo da conta BR') ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * InsMovCorrente -> Insere um movimento bancário                            *
(* ------------------------------------------------------------------------- *)
Function TCambio.InsMovCorrente ( pConta : String ; pData : TDateTime ;
                                  pValor : Double ; pObs : String = '' ) : Boolean ;
Var
   Sql : String ;
   sTipo : String ;
Begin

   Result := False ;

   // -- Verificar a existência da conta antes de inserir o mov.
   Sql := 'Select CodConta From ContaCor Where CodConta = ''' + pConta + '''' ;
   If ( Not FTable.GetExecSqlSel(Sql) ) Then
   Begin
      MensErro := FTable.GetMensErro() ;
      Exit ;
   End ;
   If ( FTable.QResult.Eof ) Then
   Begin
      Result := True ;
      Exit ;
   End ;

   Sql := 'Insert Into MovCorrente ( CodConta, DtMov, TipMov, Valor, Historico, ' +
          'CodCliFor, Pai_ID, Filial ) Values ( :Par_Conta, :Par_Data, :Par_Tipo, ' +
          ':Par_Valor, :Par_Hist, :Par_Cliente, :Par_Pai, :Par_Filial )' ;
   If ( Valor >= 0 ) Then
      sTipo := 'C'
   Else
      sTipo := 'D' ;
   FTable.QResult.Close ;
   FTable.QResult.Sql.Clear ;
   FTable.QResult.Sql.Add(Sql) ;
   FTable.QResult.ParamByName('Par_Conta').AsString   := pConta ;
   FTable.QResult.ParamByName('Par_Data').AsDateTime  := pData ;
   FTable.QResult.ParamByName('Par_Tipo').AsString    := sTipo ;
   FTable.QResult.ParamByName('Par_Valor').AsFloat    := pValor ;
   FTable.QResult.ParamByName('Par_Hist').AsString    := pObs ;
   FTable.QResult.ParamByName('Par_Cliente').AsString := Cliente ;
   FTable.QResult.ParamByName('Par_Pai').AsInteger    := OpeID ;
   FTable.QResult.ParamByName('Par_Filial').AsString  := GFilial ;
   Try
       FTable.QResult.ExecSql ;
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
 * CalcMed -> Calcula a média de compras/vendas do dia                       *
(* ------------------------------------------------------------------------- *)
Function TCambio.CalcMed ( pOpcao : String ) : Double ;
Var
   SomaQtde, SomaTotal : Double ;
   Sql : String ;
Begin

   Result := -9999999999 ;
   Error := True ;

   If ( pOpcao = 'C' ) Then
      Sql := 'Select Sum(Qtde), Sum(Qtde * Taxa) From Compras Where Data = :Par_Data'
   Else
      Sql := 'Select Sum(Qtde), Sum(Qtde * Taxa) From Vendas Where Data = :Par_Data' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_Data').AsDateTime := GParFin.DtTrab ;
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
   T : TSqlTable ;
Begin
   OpeID := -1 ;
   T := TSqlTable.Create() ;
   If ( pOpcao = 'C' ) Then
      T.OpenTable('Compras')
   Else
      T.OpenTable('Vendas') ;
   T.SetFieldKey('Ope_ID') ;
   T.SetFieldValue('Data',Data) ;
   T.SetFieldValue('CodCliente',Cliente) ;
   T.SetFieldValue('Qtde',Qtde) ;
   T.SetFieldValue('Taxa',Taxa) ;
   T.SetFieldValue('CodConta',Conta) ;
   T.SetFieldValue('NumLanc',NumLanc) ;
   T.SetFieldValue('Tipo',Tipo) ;
   T.SetFieldValue('Status',Mercado) ;
   T.SetFieldValue('Posicao',Posicao) ;
   T.SetFieldValue('Observacao',Obs) ;
   T.SetFieldValue('CodFilial',Filial) ;
   T.SetFieldValue('Carga',Carga) ;
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
   T : TSqlTable ;
Begin

   T := TSqlTable.Create() ;
   If ( pID = -1 ) Then
      pID := OpeID ;
   If ( pOpcao = 'C' ) Then
      T.OpenTable('Compras')
   Else
      T.OpenTable('Vendas') ;
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
   T.SetFieldValue('Tipo',Tipo) ;
   T.SetFieldValue('Status',Mercado) ;
   T.SetFieldValue('Posicao',Posicao) ;
   T.SetFieldValue('Observacao',Obs) ;
   T.SetFieldValue('CodFilial',Filial) ;
   T.SetFieldValue('Carga',Carga) ;
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
Function TCambio.DelComVen ( pOpcao : Char ; pID : Integer = -1 ) : Boolean ;
Var
   T : TSqlTable ;
   Ok : Boolean ;
Begin

   Result := False ;

   T := TSqlTable.Create() ;
   If ( pID = -1 ) Then
      pID := OpeID ;
   If ( pOpcao = 'C' ) Then
      T.OpenTable('Compras')
   Else
      T.OpenTable('Vendas') ;

   T.SetFieldKey('Ope_ID') ;
   T.SetKeyValue('Ope_ID',pID) ;
   If ( Not T.Find(True) ) Then
   Begin
      MensErro := T.GetMensErro() ;
      Exit ;
   End ;

   BeginTrans() ;

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
         Break ;
      End;
      QPendUS.Next ;
   End ;
   If ( Not OK ) Then
   Begin
      MensErro := 'Pendências de US já baixadas. Registro não pode ser excluído' ;
      Exit ;
   End;

   //----- Obter as pendencias BR
   If ( Not GetPendUS(pID) ) Then
   Begin
      MensErro := T.GetMensErro() ;
      Exit ;
   End ;

   // Atualizar a ContaUS
   If ( Not UpdContaUs((-1)*T.GetFieldValue('Qtde')) ) Then
   Begin
      MensErro := T.GetMensErro() ;
      ExecRollBack() ;
      Exit ;
   End ;

   // Atualizar a ContaBR
   If ( Not UpdContaBR((-1)*T.GetFieldValue('Qtde')*T.GetFieldValue('Taxa')) ) Then
   Begin
      MensErro := T.GetMensErro() ;
      ExecRollBack() ;
      Exit ;
   End ;

   Result := T.Delete() ;
   If ( Not Result ) Then
   Begin
      MensErro := T.GetMensErro() ;
      ExecRollBack() ;
      Exit ;
   End ;

   ExecCommit() ;
   Result := True ;

   T.Destroy ;

End ;

(* ------------------------------------------------------------------------- *
 * InsPendUS -> Insere uma pendencia US                                      *
(* ------------------------------------------------------------------------- *)
Function TCambio.InsPendUS : Boolean ;
Var
   T : TSqlTable ;
Begin
   T := TSqlTable.Create() ;
   T.OpenTable('PendMoedaUS') ;
   T.SetFieldKey('Pend_ID') ;
   T.SetFieldValue('Ope_ID',OpeID) ;
   T.SetFieldValue('CodCliente',Cliente) ;
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
   T : TSqlTable ;
Begin

   If ( pID = -1 ) Then
      pID := OpeID ;

   T := TSqlTable.Create() ;
   T.OpenTable('PendMoedaUS') ;
   T.SetFieldKey('Ope_ID') ;
   T.SetKeyValue('Ope_ID',pID) ;
   If ( Not T.Find(True) ) Then
   Begin
      Result := False ;
      Exit ;
   End ;

   T.SetFieldValue('CodCliente',Cliente) ;
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
 * InsPendBR -> Insere uma pendencia BR                                      *
(* ------------------------------------------------------------------------- *)
Function TCambio.InsPendBR : Boolean ;
Var
   T : TSqlTable ;
Begin
   T := TSqlTable.Create() ;
   T.OpenTable('PendMoedaBR') ;
   T.SetFieldKey('Pend_ID') ;
   T.SetFieldValue('Ope_ID',OpeID) ;
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
   Result := T.Insert() ;
   If ( Not Result ) Then
   Begin
      MensErro := T.GetMensErro() ;
      T.Destroy ;
      Exit ;
   End ;
   Result := UpdSaldoConta(Banco,GParFin.DtTrab,Valor) ;
   T.Destroy ;
End ;

(* ------------------------------------------------------------------------- *
 * GetPendUS -> Obtem as pendencias em US dado um ID de compra ou venda      *
(* ------------------------------------------------------------------------- *)
Function TCambio.GetPendUS ( pID : Integer = -1 ) : Boolean ;
Begin

   Result := False ;

   If ( pID = -1 ) Then
      pID := OpeID ;

   QPendUS.Close ;
   QPendUS.Sql.Clear ;
   QPendUS.Sql.Add('Select * From PendMoedaUS Where Ope_ID = :Par_ID') ;
   QPendUS.ParamByName('Par_ID').AsInteger := pID ;
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
Function TCambio.GetPendBR ( pID : Integer = -1 ) : Boolean ;
Begin

   Result := False ;

   If ( pID = -1 ) Then
      pID := OpeID ;

   QPendBR.Close ;
   QPendBR.Sql.Clear ;
   QPendBR.Sql.Add('Select * From PendMoedaBR Where Ope_ID = :Par_ID') ;
   QPendBR.ParamByName('Par_ID').AsInteger := pID ;
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

   If ( (pTipo <> '+') And (pTipo <> '-') ) Then
   Begin
      MensErro := 'Tipo de atualização do cliente inválido' ;
      Exit ;
   End ;
   If ( pUS_CB = '' ) Then
      pUS_CB := Tipo ;
   If ( (pUS_CB <> 'PP') And (pUS_CB <> 'CB') ) Then
   Begin
      MensErro := 'Moeda de atualização do cliente inválida' ;
      Exit ;
   End ;

   If ( pCodCli = '' ) Then
      pCodCli := Cliente ;
   If ( pValor = 0 ) Then
   Begin
      pValor := Qtde * Taxa ;
      If ( pTipo = '+' ) Then
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

   Sql := 'Update Cliente Set ' ;
   If ( pUS_CB = 'PP' ) Then
      Sql := Sql + 'Valor_US = Valor_US + '
   Else
      Sql := Sql + 'Valor_Cabo = Valor_Cabo + ' ;
   Sql := Sql + ':Par_Qtde, Valor_BR = Valor_BR + :Par_Valor Where ' +
          'CodCliente = :Par_Codigo' ;

   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_Codigo').AsString := pCodCli ;
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
   If ( Not InsMovCliente(GParFin.DtTrab,pCodCli,pUS_CB,pQtde,pObs,sTipo) ) Then
      Exit ;
   // -- MovCliente BR
   If ( Not InsMovCliente(GParFin.DtTrab,pCodCli,'BR',pValor,pObs,sTipo) ) Then
      Exit ;

   Result := True ;

End ;

(* ------------------------------------------------------------------------- *
 * InsMovCliente -> Insere um movimento do cliente                           *
(* ------------------------------------------------------------------------- *)
Function TCambio.InsMovCliente ( pData : TDateTime ; pCodCliente : String ;
                                 pMoeda : String ; pValor : Double ; pObs : String ;
                                 pTipo : String ; pPai : Integer = 0 ) : Boolean ;
Var
   Sql : String ;
Begin

   Result := False ;

   Sql := 'Insert Into MovCliente ( Data, CodCliente, Moeda, Valor, Obs, Pai_ID, ' +
          'Tipo, Carga, Filial ) Values ( :Par_Data, :Par_CodCliente, :Par_Moeda, ' +
          ':Par_Valor, :Par_Obs, :Par_PaiID, :Par_Tipo, :Par_Carga, :Par_Filial )' ;

   If ( pPai = 0 ) Then
      pPai := OpeID ;

   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_Data').AsDateTime     := pData ;
   FQuery.ParamByName('Par_CodCliente').AsString := pCodCliente ;
   FQuery.ParamByName('Par_Moeda').AsString      := pMoeda ;
   FQuery.ParamByName('Par_Valor').AsFloat       := pValor ;
   FQuery.ParamByName('Par_Obs').AsString        := pObs ;
   FQuery.ParamByName('Par_PaiID').AsInteger     := pPai ;
   FQuery.ParamByName('Par_Tipo').AsString       := pTipo ;
   FQuery.ParamByName('Par_Carga').AsString      := ' ' ;
   FQuery.ParamByName('Par_Filial').AsString     := GFilial ;
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
 * DelPendBR -> Exclui uma pendência BR atualizando o saldo do banco         *
(* ------------------------------------------------------------------------- *)
Function TCambio.DelPendBR ( pOpeId : LongInt ; pOpcao : String ) : Boolean ;
Var
   Sql : String ;
   Ok : Boolean ;
   nValor : Double ;
Begin

   Result := False ;

   // -- Atualizando os saldos bancários
   Sql := 'Select Banco, Valor From PendMoedaBR Where Ope_ID = :Par_OpeID' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_OpeID').AsInteger := pOpeID ;
   Try
      FQuery.ExecSql ;
   Except
      on E: Exception do
      Begin
         MensErro := E.Message ;
         Exit ;
      End ;
   End ;

   Ok := True ;
   While ( Not FQuery.Eof ) Do
   Begin
      If ( pOpcao = 'C' ) Then
         nValor := FQuery.FieldByName('Valor').AsFloat
      Else
         nValor := FQuery.FieldByName('Valor').AsFloat * (-1) ;
      If ( Not UpdSaldoConta(FQuery.FieldByName('Banco').AsString,GParFin.DtTrab,nValor,
                             'Exclusão OPE [' + Str_IntToStr(pOpeId) + ']') ) Then
      Begin
         Ok := False ;
         Break ;
      End ;
      FQuery.Next ;
   End;
   If ( Not Ok ) Then
      Exit ;

   // ----- Atualizando os bancos das pendências
   Sql := 'Delete PendMoedaBR Where Ope_ID = :Par_OpeID' ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   FQuery.ParamByName('Par_OpeID').AsInteger := pOpeID ;
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
 * GetSaldoCli -> Devolve o saldo de um cliente                              *
(* ------------------------------------------------------------------------- *)
Function TCambio.GetSaldoCli ( pCodCli : String ; pMoeda : String ) : Double ;
Var
   Sql : String ;
Begin

   Result := -1 ;

   If ( (pMoeda <> 'PP') And (pMoeda <> 'CB') ) Then
   Begin
      SetMensErro('Moeda inválida') ;
      Exit ;
   End ;

   Sql := 'Select Valor_US, Valor_Cabo From Cliente Where CodCliente = ''' +
          pCodCli + '''' ;
   If ( Not FTable.GetExecSqlSel(Sql) ) Then
   Begin
      SetMensErro(FTable.GetMensErro()) ;
      Exit ;
   End ;

   If ( pMoeda = 'PP' ) Then
      Result := FTable.QResult.FieldByName('Valor_US').AsFloat
   Else
      Result := FTable.QResult.FieldByName('Valor_Cabo').AsFloat ;

   SetMensErro('') ;

End ;

(* ------------------------------------------------------------------------- *
 * QuitarPendUS -> Quita uma pendência US                                    *
(* ------------------------------------------------------------------------- *)
Function TCambio.QuitarPendUS ( pOpeId : LongInt ; pObs : String ) : Boolean ;
Begin
   FSql := 'Update PendMoedaUS Set Quitado = ''S'', Observacao = ''' +
           pObs + ''' Where Pend_ID = ' + Str_IntToStr(pOpeID) ;
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
 * QuitarPendBR -> Quita uma pendência BR                                    *
(* ------------------------------------------------------------------------- *)
Function TCambio.QuitarPendBR ( pOpeId : LongInt ; pObs : String ) : Boolean ;
Begin
   FSql := 'Update PendMoedaBR Set Quitado = ''S'', Observacao = ''' +
           pObs + ''' Where Pend_ID = ' + Str_IntToStr(pOpeID) ;
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
Function TCambio.UpdCliBR ( pCliente : String ; pValor : Double ; pObs : String = '' ) : Boolean ;
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
   If ( Not InsMovCliente(GParFin.DtTrab,pCliente,'BR',pValor,pObs,'+',-1) ) Then
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


end.

