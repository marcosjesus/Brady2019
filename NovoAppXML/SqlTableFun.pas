unit SQLTableFun;

interface

Uses
     SysUtils, Windows, DB, DBTables, Classes, Forms, extctrls, Variants, CxPC,
     ComCtrls, StdCtrls, Controls, Dialogs,  FMTBcd, DBConect,
      FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

Const

   DBTYPE_PARADOX      = 1 ;
   DBTYPE_SQLSERVER_65 = 2 ;
   DBTYPE_ACCESS       = 3 ;
   DBTYPE_SQLSERVER_70 = 4 ;

   MAX_FIELDS    = 100 ;
   MAX_KEYFIELDS = 10 ;

   TAG_FIELD    = -1 ;
   TAG_KEY      = -2 ;
   TAG_ESPCOMBO = -3 ;
   TAG_ALT_KEY  = -4 ;

   ERRO_OK           = 0 ;
   ERRO_KEYVIOLATION = 2601 ;
   ERRO_REC_MODIFIED = 2 ;
   ERRO_CONSTRAINT   = 547 ;
   ERRO_NULL_VALUES  = 515 ;
   ERRO_COMMIT       = -1 ;

   FIELDTYPE_TEXT = 1 ;
   FIELDTYPE_ITEM = 2 ;
   FIELDTYPE_CODE = 3 ;

Type

   TFieldDesc = Record
       FName : String[50] ;
       FPos : Integer ;
       FType : TFieldType ;
       FValue : Variant ;
       FUpdOk : Boolean ;
       FDecimals: Integer ;
       FAutoVal : Integer ;
   End ;

   Type TSQLTableClass = Class(TComponent)
   	   Private
           FDBType      : Integer ;                            // -> Tipo do banco de dados
           FQuery       : TFDQuery ;                             // -> Query gen�rica
           FQResult     : TFDQuery ;                             // -> Query auxiliar
           FQuerySelect : TFDQuery ;								// -> Query para pesquisa
           FSql         : String ;                             // -> Comando sql utilizado
           FVariantKey  : Variant ;                            // -> Chave para pesquisa com PARADOX
           FDBName      : String[20] ;                         // -> Nome do DataBase
           FTableName   : String[50] ;                         // -> Nome da tabela default
           FFieldDesc   : Array[0..MAX_FIELDS] Of TFieldDesc ; // -> Descri��o dos campos
           FFieldCount  : Integer ;							// -> N�mero de campos da tabela
           FTable       : TTable ;                             // -> Tabela default
           FMensErro    : String ;								     // -> Mensagem de erro obtida
           FExceptErro  : String ;
           FErro        : Boolean ;  							     // -> Erro obtido em alguma fun��o que falhou
           FNumErro     : Integer ;                            // -> N�mero do erro
           FFieldPos    : Integer ;							// -> Posi��o do campo atual de trabalho
           FFieldName   : String[30] ;	         				// -> Nome do campo atual de trabalho
           FKeyCount    : Integer ;                            // -> N�mero de campos da chave
           FKeyFields   : Array[1..MAX_KEYFIELDS] Of Integer ; // -> Campos que comp�e a chave
           FNullValues  : Boolean ;                            // -> Indica se valores nulos ser�o convertidos
           FTimeStamp   : TDateTime ;
           FExecTS      : Boolean ;
           Function GetFieldType ( FieldName : String ) : TFieldType ;
           Function GetFieldPos ( FieldName : String ) : Integer ;
           Function PrivGetFieldValue ( FieldPos : Integer ; AsText : Boolean = True ) : Variant ;
           Function GetSqlInsert : Boolean ;
           Function GetSqlSelect : Boolean ;
           Function GetSqlUpdate : Boolean ;
           Function GetSqlDelete : Boolean ;
           Function GetSqlNextOrPrior ( Opcao : String ) : Boolean ;
           Function GetVariantKey : Boolean ;
           Function GetRowModified : Integer ;
           Function GetDBError : Integer ;
       Public
           QResult : TFDQuery ;
           Constructor Create ; reintroduce ;
           Destructor Destroy ; reintroduce ;
           Procedure SetDBName ( Value : String ) ;
           Procedure SetDBType ( Value : Integer ) ;
           Function GetFieldName ( pInd : Integer ) : String ;
           Function GetFieldAutoVal ( pInd : Integer ) : Boolean ;
           Procedure SetExecTS(pbValue : Boolean) ;
           Function FillDescFieldValues : Boolean ;
           Procedure FormToFieldValues ( F : TForm = Nil ) ;
           Procedure FieldValuesToForm ( F : TForm = Nil ) ;
           Procedure SetError ( Message : String = '' ; ErrorNum : Integer = 0 ) ;
           Function GetMensErro : String ;
           Function GetError : Boolean ;
           Function GetNumErro : Integer ;
           Function OpenTable ( TableName : String ) : Boolean ;
           Procedure ResetAllUpdFields ( Value : Boolean = False ) ;
           Function GetNumFields : Integer ;
           Function SetUpdField ( FieldName : String ) : Boolean ;
           Function ResetUpdField ( FieldName : String ; Value : Boolean = False ) : Boolean ;
           Function SetFieldValue ( FieldName : String ; FieldValue : Variant ) : Boolean ; Overload ;
           Function SetFieldValue ( FieldPos : Integer ; FieldValue : Variant ) : Boolean ; Overload ;
           Function GetFieldValue ( FieldName : String ) : Variant ;
           Function GetTabFieldType ( FieldName : String ) : TFieldType ;
           Procedure ResetKey ;
           Function SetKeyValue ( FieldName : String ; FieldValue : Variant ; ParResetKey : Boolean = False ) : Boolean ;
           Function SetFieldKey ( FieldName : String ) : Boolean ;
           Function SetKey ( Values : Array of Variant ) : Boolean ;
           Function GetLastIdentity : LongInt ;
           Function GetNumRows : LongInt ;
           Function Insert ( ClearUpdFields : Boolean = True ) : Boolean ;
           Function Update ( ClearUpdFields : Boolean = True ; ExecFind : Boolean = True ) : Boolean ;
           Function Find ( FillDesc : Boolean = False ) : Boolean ;
           Function Next ( FillFields : Boolean = True ) : Boolean ;
           Function Prior ( FillFields : Boolean = True ) : Boolean ;
           Function Delete : Boolean ;
           Function ExecSqlSel ( Sql : String ) : TFDQuery ;
           Function ExecSql ( Sql : String ) : TFDQuery ;
           Function SetInsert ( TabName : String ; Value : String ) : Boolean ;
           Function GetExecSqlSel ( Sql : String ) : Boolean ;
           Function GetExecSql ( Sql : String ) : Boolean ;
           Function ExecQuerySel ( Q : TFDQuery = Nil ) : Boolean ;
           Function ExecQuery ( Q : TFDQuery = Nil ) : Boolean ;
           Function FormSetFieldValue ( F : TForm = Nil ; Tag : Integer = 0 ) : Boolean ;
           Function SetFormObjValue ( F : TForm = Nil ; Tag : Integer = 0 ) : Boolean ;
           Function SeekGet ( TableName : String ; Fields : String ;
                             aKey : Array of Variant ; RetField : String ;
                             Erro : Boolean = False ) : Variant ;
           Function Seek ( TableName : String ; Fields : String ;  aKey : Array of Variant ) : Boolean ;
           Procedure IndexName ( Value : String ) ;
           Function GetSqlServerTabFields ( pTabName : String ) : TFDQuery ;
           Function BeginTrans : Boolean ;
           Function ExecCommit : Boolean ;
           Function ExecRollBack : Boolean ;
           Procedure SetNullValues ( Value : Boolean ) ;
           Function GetLastID ( FieldName : String ) : Double ;
           Function GetTransCount : Integer ;
   End ;


Function SqlTable_Start ( DBName : String ; DBType : Integer = DBTYPE_PARADOX ) : Boolean ; Export ;
Function SqlTable_GetDBType : Integer ; Export ;
Function SqlTable_GetDBName : String ; Export ;

implementation

Uses
   rsFlyovr, rsEdit, StrFun, TestFun, ObjFun, GN_RadioGroup, DateFun ;

Var
   VarDBName : String ;
   VarDBType : Integer ;


(* ========================================================================= *)
(*                    FUN��ES DE UTILIZA��O INTERNA                          *)

(* ------------------------------------------------------------------------- *
 * GetFieldType -> Retorno o tipo de um campo da tabela                      *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetFieldType ( FieldName : String ) : TFieldType ;
Begin
   Result := ftString ;
	Case FDBType Of
   	DBTYPE_PARADOX : Begin
           Case FTable.FieldByName(FieldName).DataType Of
               ftString   : Result := ftString ;
               ftSmallInt ,
               ftAutoInc ,
               ftInteger  : Result := ftInteger ;
               ftFloat    : Result := ftFloat ;
               ftDate     ,
               ftTime     ,
               ftDateTime : Result := ftDateTime ;
           End ;
       End ;
       DBTYPE_ACCESS  : Begin
           Case FQuery.FieldByName(FieldName).DataType Of
               ftString   : Result := ftString ;
               ftSmallInt ,
               ftAutoInc ,
               ftInteger  : Result := ftInteger ;
               ftFloat    : Result := ftFloat ;
               ftDate     ,
               ftTime     ,
               ftDateTime : Result := ftDateTime ;
           End ;
       End ;
       DBTYPE_SQLSERVER_65 ,
       DBTYPE_SQLSERVER_70 : Begin
           If ( (FieldName = 'varchar') Or (FieldName = 'char') ) Then
               Result := ftString
           Else If ( FieldName = 'datetime' ) Then
               Result := ftDateTime
           Else If ( (FieldName = 'decimal') Or (FieldName = 'float') Or
                (FieldName = 'numeric') Or (FieldName = 'real') Or (FieldName = 'money') ) Then
               Result := ftFloat
           Else If ( (FieldName = 'int') Or (FieldName = 'smallint') ) Then
               Result := ftInteger
           Else
               Result := ftString ;
       End ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * GetDBError -> Determina o n�mero do erro ocorrido no DB                    *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetDBError : Integer ;
Begin
    Result := -1 ;
    If ( (FDBType = DBTYPE_SQLSERVER_65) Or (FDBType = DBTYPE_SQLSERVER_70) ) Then
    Begin
       FQuerySelect.Close ;
       FQuerySelect.Sql.Clear ;
       FQuerySelect.Sql.Add('Select @@ERROR As ErrorNum') ;
       Try
          FQuerySelect.Open ;
       Except
          Exit ;
       End ;
       Result := FQuerySelect.FieldByName('ErrorNum').AsInteger ;
    End ;
End ;

(* ------------------------------------------------------------------------- *
 * SetError -> Seta um erro ocorrido                                         *
(* ------------------------------------------------------------------------- *)
Procedure TSQLTableClass.SetError ( Message : String = '' ; ErrorNum : Integer = 0 ) ;
Var
   Aux : String ;
Begin
	 If ( Message = '' ) Then
    Begin
     	 FErro := False ;
       FNumErro := ERRO_OK ;
       FMensErro := '' ;
    End
    Else If ( Message = '<>' ) Then
    Begin
       FNumErro := GetDBError() ;
       Case FNumErro Of
          ERRO_REC_MODIFIED : FMensErro := 'Estes registros provavelmente ' +
                                         'foram modificado(s) por outro processo. ' +
                                         'Por favor repita o processamento realizado.' ;
          ERRO_KEYVIOLATION : FMensErro := 'Registro j� existente' ;
          ERRO_CONSTRAINT   : FMensErro := 'A integridade referencial do banco de dados n�o ' +
                                         'permite que esta opera��o seja realizada' ;
          ERRO_NULL_VALUES  : FMensErro := 'Alguns valores obrigat�rios da tabela n�o foram informados' ;
       Else
          Aux := LowerCase(FExceptErro) ;
          If ( Pos('key violation',Aux) <> 0 ) Then
             FMensErro := 'Registro j� existente'
          Else
             FMensErro := FExceptErro ;
       End ;
    End
    Else Begin
       FNumErro := ErrorNum ;
       FErro := True ;
       FMensErro := Message ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * GetFieldPos -> Devolve a posi��o de um campo no vetor FFieldDesc          *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetFieldPos ( FieldName : String ) : Integer ;
Var
	i : Integer ;
Begin
	Result := -1 ;
	For i:=0 To FFieldCount-1 Do
    Begin
       If ( LowerCase(FFieldDesc[i].FName) = LowerCase(FieldName) ) Then
       Begin
       	Result := i ;
			Break ;
       End ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * PrivGetFieldValue -> Devolve o valor de um campo no vetor FFieldDesc      *
 *                      Uso interno ao m�dulo                                *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.PrivGetFieldValue ( FieldPos : Integer ; AsText : Boolean = True ) : Variant ;
Var
   ValInt : Integer ;
   ValFlo : Double ;
   ValDat : TDateTime ;
   ValDatStr : String ;
Begin
   Case FFieldDesc[FieldPos].FType Of
       ftString   : Begin
           Result := Trim(FFieldDesc[FieldPos].FValue) ;
           If ( (Result = Null) And (FNullValues) ) Then
              Result := '' ;
           If ( AsText ) Then
               If ( (FDBType = DBTYPE_SQLSERVER_65) Or (FDBType = DBTYPE_SQLSERVER_70) ) Then
                   Result := '''' + Result + ''''
               Else
                   Result := '"' + Result + '"' ;
		 End ;
       ftInteger  : Begin
           If ( ((FFieldDesc[FieldPos].FValue = Null)) And (FNullValues)) Then
              ValInt := 0
           Else
              ValInt := FFieldDesc[FieldPos].FValue ;
           Result := ValInt ;
           If ( AsText ) Then
               Result := Str_IntToStr(Result) ;
       End ;
       ftFloat    : Begin
           Try
              If ( (FFieldDesc[FieldPos].FValue = Null) And (FNullValues) ) Then
                 ValFlo := 0
              Else
                 ValFlo := FFieldDesc[FieldPos].FValue ;
			  Except
				  ValFlo := 0 ;
           End ;
           Result := ValFlo ;
           If ( AsText ) Then
           Begin
               Result := Str_FloatToStr(Result,FFieldDesc[FieldPos].FDecimals) ;
               Result := Str_ChangeDecPoint(Result,',','.') ;
           End ;
       End ;
       ftDateTime : Begin
           Try
               If ( (FFieldDesc[FieldPos].FValue = Null) And (FNullValues) ) Then
                  ValDat := Str_StrToDate('01/01/1900')
               Else Begin
                  ValDatStr := Str_DateToStr(FFieldDesc[FieldPos].FValue) ;
                  If ( ValDatStr = '30/12/1899' ) Then // Ocorre quando FFieldDesc[FieldPos].FValue = '00:00:00' ;
                     ValDat := Str_StrToDate('01/01/1900')
                  Else if ValDatStr <> '  /  /  ' then
                     ValDat := Str_StrToDate(ValDatStr)
                  else  ValDat := 0;
               End ;
           Except
               ValDat := Str_StrToDate(FFieldDesc[FieldPos].FValue) ;
           End ;
           Result := ValDat ;
           If ( AsText ) Then
           Begin

//    				  ValDatStr := FormatDateTime('yyyy-mm-dd', ValDat) ;
    				  ValDatStr := Str_DateToStr(ValDat) ;
(*
               If ( Length(Result) <= 8 ) Then
                   Result := Copy(Result,4,2) + '/' + Copy(Result,1,2) + '/' + Copy(Result,7,2)
               Else
                   Result := Copy(Result,4,2) + '/' + Copy(Result,1,2) + '/' + Copy(Result,7,4) ;
*)
               If ( (FDBType = DBTYPE_SQLSERVER_65) Or (FDBType = DBTYPE_SQLSERVER_70) ) Then
               Begin
                   if ValDat = 0 then
                     Result := 'Null' else
                   begin
//                    Result := Str_DDMMAA_To_AAMMDD(ValDatStr) ;
                      Result := ValDatStr;
//                       Result := Str_DDMMAA_To_MMDDAA(ValDatStr) ;
//                     Result := ValDatStr ;
                     Result := '''' + Result + ''''
                   end;
               End
               Else
                   Result := '"' + ValDatStr + '"' ;

           End ;
       End ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * GetSqlInsert -> Devolve o sql de de INSERT baseado nos campos de atualiz. *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetSqlInsert : Boolean ;
Var
   i : Integer ;
   OkFields : Boolean ;
Begin
   FSql := 'Insert Into ' + FTableName + ' ( ' ;
   OkFields := False ;
   For i:=0 To FFieldCount-1 Do
   Begin
		If ( FFieldDesc[i].FUpdOk ) Then
		Begin
			  OkFields := True ;
           If ( ( (FDBType = DBTYPE_SQLSERVER_65) Or (FDBType = DBTYPE_SQLSERVER_70) ) And
                (FFieldDesc[i].FAutoVal <> 0) ) Then
             Continue ;
			 FSql := FSql + FFieldDesc[i].FName + ', ' ;
		End ;
   End ;
   If ( Not OkFields ) Then
   Begin
		SetError('SQLTable Error: Insert -> Update Fields not found') ;
		Result := False ;
		Exit ;
   End ;
   FSql := Copy(FSql,1,Length(FSql)-2) + ' ) Values ( ' ;
   For i:=0 To FFieldCount-1 Do
   Begin
		If ( FFieldDesc[i].FUpdOk ) Then
		Begin
         If ( ( (FDBType = DBTYPE_SQLSERVER_65) Or (FDBType = DBTYPE_SQLSERVER_70) )
              And (FFieldDesc[i].FAutoVal <> 0) ) Then
            Continue ;
         FSql := FSql + PrivGetFieldValue(i) + ', ' ;
		End ;
   End ;
   // -- Desliga valores nulos
   FNullValues := False ;
   FSql := Copy(FSql,1,Length(FSql)-2) + ' )' ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * GetSqlSelect -> Devolve o comando sql de SELECT * FROM ...                *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetSqlSelect : Boolean ;
Var
   i, f : Integer ;
Begin
   Case FDBType Of
       DBTYPE_PARADOX : Begin
            FSql := '' ;
            For i:=1 To FKeyCount Do
            Begin
               f := FKeyFields[i] ;
               FSql := FSql + FFieldDesc[f].FName + ';' ;
            End ;
            FSql := Copy(FSql,1,Length(FSql)-1) ;
       End ;
       DBTYPE_SQLSERVER_65 : Begin
             FSql := 'Select * From ' + FTableName + ' Where ' ;
             For i:=1 To FKeyCount Do
             Begin
                f := FKeyFields[i] ;
                FSql := FSql + FFieldDesc[f].FName + ' = ' + PrivGetFieldValue(f) + ' And ' ;
             End ;
             // -- Desliga valores nulos
             FNullValues := False ;
             If ( FKeyCount > 0 ) Then
                FSql := Copy(FSql,1,Length(FSql)-4)
             Else
                FSql := Copy(FSql,1,Length(FSql)-6) ;
       End ;
       DBTYPE_SQLSERVER_70 : Begin
//             FSql := 'Select *, CONVERT(TimeStamp,TS) TimeStamp From ' + FTableName + ' Where ' ;
             FSql := 'Select * From ' + FTableName + ' Where ' ;
//             FSql := 'Select * From ' + FTableName + ' Where ' ;
             For i:=1 To FKeyCount Do
             Begin
                f := FKeyFields[i] ;
                FSql := FSql + FFieldDesc[f].FName + ' = ' + PrivGetFieldValue(f) + ' And ' ;
             End ;
             // -- Desliga valores nulos
             FNullValues := False ;
             If ( FKeyCount > 0 ) Then
                FSql := Copy(FSql,1,Length(FSql)-4)
             Else
                FSql := Copy(FSql,1,Length(FSql)-6) ;
       End ;
       DBTYPE_ACCESS : Begin
             FSql := 'Select * From ' + FTableName + ' Where ' ;
             For i:=1 To FKeyCount Do
             Begin
                f := FKeyFields[i] ;
                FSql := FSql + FFieldDesc[f].FName + ' = ' + PrivGetFieldValue(f) + ' And ' ;
             End ;
             // -- Desliga valores nulos
             FNullValues := False ;
             If ( FKeyCount > 0 ) Then
                FSql := Copy(FSql,1,Length(FSql)-4)
             Else
                FSql := Copy(FSql,1,Length(FSql)-6) ;
       End ;
   End ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * GetSqlNextOrPrior -> Devolve o comando sql de SELECT para o pr�ximo ou    *
 *                      para o registro anterior                             *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetSqlNextOrPrior ( Opcao : String ) : Boolean ;
Var
   f : Integer ;
   Op : String ;
Begin
   Result := False ;
   If ( Opcao = 'NEXT' ) Then
      Op := ' > '
   Else
      Op := ' < ' ;
   Case FDBType Of
       DBTYPE_SQLSERVER_65 : Begin
             If ( FKeyCount > 1 ) Then
                Exit ;
             FSql := 'Select TOP 1 * From ' + FTableName + ' Where ' ;
             f := FKeyFields[1] ;
             FSql := FSql + FFieldDesc[f].FName + Op + PrivGetFieldValue(f) ;
             FSql := FSql + ' Order By ' + FFieldDesc[f].FName ;
             If ( Opcao <> 'NEXT' ) Then
                FSql := FSql + ' DESC ' ;
             // -- Desliga valores nulos
             FNullValues := False ;
       End ;
       DBTYPE_SQLSERVER_70 : Begin
             If ( FKeyCount > 1 ) Then
                Exit ;
//             FSql := 'Select TOP 1 *, CONVERT(TimeStamp,TS) TimeStamp From ' + FTableName + ' Where ' ;
             FSql := 'Select TOP 1 * From ' + FTableName + ' Where ' ;
             f := FKeyFields[1] ;
             FSql := FSql + FFieldDesc[f].FName + Op + PrivGetFieldValue(f) ;
             FSql := FSql + ' Order By ' + FFieldDesc[f].FName ;
             If ( Opcao <> 'NEXT' ) Then
                FSql := FSql + ' DESC ' ;
             // -- Desliga valores nulos
             FNullValues := False ;
       End ;
       DBTYPE_ACCESS : Begin
             FSql := 'Select * From ' + FTableName + ' Where ' ;
             f := FKeyFields[1] ;
             FSql := FSql + FFieldDesc[f].FName + Op + PrivGetFieldValue(f) ;
             FSql := FSql + ' Order By ' + FFieldDesc[f].FName ;
             If ( Opcao <> 'NEXT' ) Then
                FSql := FSql + ' DESC ' ;
             // -- Desliga valores nulos
             FNullValues := False ;
       End ;
   End ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * GetSqlUpdate -> Devolve o comando sql de UPDATE baseado nos campos de atu.*
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetSqlUpdate : Boolean ;
Var
   i,f  : Integer ;
   OkFields : Boolean ;
Begin
   FSql := 'Update ' + FTableName + ' Set ' ;
   OkFields := False ;
   For i:=0 To FFieldCount-1 Do
   Begin
       If ( FFieldDesc[i].FUpdOk ) Then
       Begin
           OkFields := True ;
           If ( ( (FDBType = DBTYPE_SQLSERVER_65) Or (FDBType = DBTYPE_SQLSERVER_70) )
                And (FFieldDesc[i].FAutoVal <> 0) ) Then
              Continue ;
           try
             FSql := FSql + FFieldDesc[i].FName + ' = ' + PrivGetFieldValue(i) + ', ' ;
           except
             SetError('Erro ao Gerar FSQL Campo '+FFieldDesc[i].FName) ;
             Result := False ;
             Exit ;
           end;
        End ;
   End ;
   // -- Desliga valores nulos
   FNullValues := False ;
   If ( Not OkFields ) Then
   Begin
       SetError('SQLTable Error: Update -> Update Fields not found') ;
       Result := False ;
       Exit ;
   End ;
   FSql := Copy(FSql,1,Length(FSql)-2) + ' Where ' ;
   If ( FKeyCount > 0 ) Then
   Begin
      For i:=1 To FKeyCount Do
      Begin
          f := FKeyFields[i] ;
          FSql := FSql + FFieldDesc[f].FName + ' = ' + PrivGetFieldValue(f) + ' And ' ;
      End ;
   End ;
   // -- Desliga valores nulos
   FNullValues := False ;
   If ( FDBType = DBTYPE_SQLSERVER_70 ) Then
   Begin
      If ( FExecTS ) Then
         FSql := FSql + ' CONVERT(DateTime,TS) = :Par_TS'
      Else Begin
         If ( FKeyCount > 0 ) Then
            FSql := Copy(FSql,1,Length(FSql)-5)
         Else
            FSql := Copy(FSql,1,Length(FSql)-7) ;
      End ;
   End
   Else Begin
      If ( FKeyCount > 0 ) Then
         FSql := Copy(FSql,1,Length(FSql)-4)
      Else
         FSql := Copy(FSql,1,Length(FSql)-6) ;
   End ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * GetSqlDelete -> Devolve os campos sql de DELETE baseado nos campos de atu.*
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetSqlDelete : Boolean ;
Var
   i, f : Integer ;
Begin
   FSql := 'Delete From ' + FTableName + ' Where ' ;
   For i:=1 To FKeyCount Do
   Begin
       f := FKeyFields[i] ;
       FSql := FSql + FFieldDesc[f].FName + ' = ' + PrivGetFieldValue(f) + ' And ' ;
   End ;
   // -- Desliga valores nulos
   FNullValues := False ;
   // ----- Teste to TimeStamp
   If ( FDBType = DBTYPE_SQLSERVER_70 ) Then
   Begin
      If ( FExecTS ) Then
         FSql := FSql + ' CONVERT(DateTime,TS) = :Par_TS'
      Else Begin
         If ( FKeyCount > 0 ) Then
            FSql := Copy(FSql,1,Length(FSql)-5)
         Else
            FSql := Copy(FSql,1,Length(FSql)-7) ;
      End ;
   End
   Else Begin
      If ( FKeyCount > 0 ) Then
         FSql := Copy(FSql,1,Length(FSql)-4)
      Else
         FSql := Copy(FSql,1,Length(FSql)-6) ;
   End ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * FillDescFieldValues -> Preenche o vetor FFieldDesc com os valores da tab. *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.FillDescFieldValues : Boolean ;
Var
   i, Pos : Integer ;
   FieldName : String ;
Begin
   Result := True ;
   Case FDBType Of
		DBTYPE_PARADOX : Begin
			 For i:=0 To FTable.FieldCount-1 Do
			 Begin
				  If ( FTable.Fields[i].AsVariant = Null ) Then
						FFieldDesc[i].FValue := ''
				  Else
						FFieldDesc[i].FValue := FTable.Fields[i].AsVariant ;
			 End ;
		End ;
		DBTYPE_SQLSERVER_65 ,
      DBTYPE_SQLSERVER_70 ,
		DBTYPE_ACCESS    : Begin
			 For i:=0 To FQuerySelect.FieldCount-1 Do
			 Begin
				  FieldName := FQuerySelect.Fields[i].FieldName ;
				  Pos := GetFieldPos(FieldName) ;
				  If ( Pos = -1 ) or (FQuerySelect.Fields[i].FieldName = 'TS') Then
				  Begin
						SetError('SQLTable Error: FillDescFieldValues -> Field not found') ;
                  Continue ;
				  End ;
              If ( FFieldDesc[Pos].FType = ftDateTime ) Then
//                 FFieldDesc[Pos].FValue := Date_ChangeDayMonth(FQuerySelect.Fields[i].AsVariant)
                 FFieldDesc[Pos].FValue := FQuerySelect.Fields[i].AsVariant
              Else
                 FFieldDesc[Pos].FValue := FQuerySelect.Fields[i].AsVariant ;
			 End ;
//           If ( FDBType = DBTYPE_SQLSERVER_70 ) Then
//               FTimeStamp := FQuerySelect.FieldByName('TimeStamp').AsDateTime ;
		End ;
   End ;
   If ( Not Result ) Then
       Exit ;
End ;

(* ------------------------------------------------------------------------- *
 * GetVariantKey -> Preenche o vetor FVariantKey com o valor da chave da tab *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetVariantKey : Boolean ;
Var
   i,f : Integer ;
   VarArray : Array Of Variant ;
Begin
   If ( FKeyCount = 0 ) Then
   Begin
       SetError('SQLTable Error: GetVariantKey -> Key Fields not found') ;
       Result := False ;
       Exit ;
   End ;
   If ( FKeyCount > 1 ) Then
   Begin
       SetLength(VarArray,FKeyCount) ;
       For i:=1 To FKeyCount Do
       Begin
           f := FKeyFields[i] ;
           VarArray[i-1] := PrivGetFieldValue(f,False) ;
       End ;
       FVariantKey := VarArrayOf(VarArray) ;
   End
   Else Begin
       f := FKeyFields[1] ;
       FVariantKey := PrivGetFieldValue(f,False) ;
       If ( Copy(FVariantKey,1,1) = '"' ) Then
           FVariantKey := Copy(FVariantKey,2,Length(FVariantKey)-2) ;
   End ;
   // -- Desliga valores nulos
   FNullValues := False ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * GetRowModified -> Devole o n�mero de linhas modificadas no �ltimo comando *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetRowModified : Integer ;
//Var
//    Q : TSQLQuery ;
Begin
//	Q := TSQLQuery.Create(Self) ;
//  Q.SqlConnection := DB_Conect.SQLConnection ;
//	Q.DatabaseName := FDBName ;
{  FQuery.Close;
  FQuery.Sql.Clear;
	FQuery.Sql.Add('Select @@ROWCOUNT RowModified') ;
	Try
		FQuery.Open ;
   Except
       on E: Exception do
       Begin
           SetError(E.Message);
           FQuery.Close ;
           Result := -1 ;
           Exit ;
       End ;
   End ;
}
   Result := 1 ; //FQuery.FieldByName('RowModified').AsInteger ;
End ;

(* ------------------------------------------------------------------------- *
 * GetSqlServerTabFields -> Devolve uma Query com os campos da tabela        *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetSqlServerTabFields ( pTabName : String ) : TFDQuery ;
Var
    Q : TFDQuery ;
    Sql : String ;
Begin

	Q := TFDQuery.Create(Self) ;
  Q.Connection := DB_Conect.FDConnection ;
//	Q.DatabaseName := FDBName ;

	Sql := 'Select * From xTabDef Where ColTabName =  ''' + pTabName + ''' Order By ' +
          'ColTabName, ColID' ;
	Q.Sql.Clear ;
	Q.Sql.Add(Sql) ;
	Try
		Q.Open ;
   Except
       on E: Exception do
       Begin
           SetError(E.Message);
           Q.Close ;
           Exit ;
       End ;
   End ;
   If ( Not Q.Eof ) Then
   Begin
       SetError('');
       Result := Q ;
		 Exit ;
   End ;
{
   If ( FDBType = DBTYPE_SQLSERVER_65 ) Then
      Sql := 'Insert Into xTabDef ( ColTabName, ColID, ColName, ColType, ColLen, ColScale, ColAutoVal ) ' +
           'Select  B.NAME, A.COLID, A.NAME , C.NAME , ' +
           'A.LENGTH * (1 - sign(isnull(A.PREC,0))) + isnull(A.PREC,0), A.SCALE, A.STATUS ' +
           'From SYSCOLUMNS A , SYSOBJECTS B , SYSTYPES C ' +
           'Where B.NAME = ''' + pTabName + ''' And B.ID = A.ID And ' +
           'A.USERTYPE = C.USERTYPE Order by COLID'
    Else
      Sql := 'Insert Into xTabDef ( ColTabName, ColID, ColName, ColType, ColLen, ColScale ) ' +
           'Select  B.NAME, A.COLID, A.NAME , C.NAME , ' +
           'A.LENGTH * (1 - sign(isnull(A.PREC,0))) + isnull(A.PREC,0), A.SCALE ' +
           'From SYSCOLUMNS A , SYSOBJECTS B , SYSTYPES C ' +
           'Where B.NAME = ''' + pTabName + ''' And B.ID = A.ID And ' +
           'A.USERTYPE = C.USERTYPE Order by COLID' ;

	 Q.Sql.Clear ;
    Q.Sql.Add(Sql) ;
    Try
       Q.Open ;
    Except
       on E: Exception do
       Begin
           SetError(E.Message);
           Exit ;
       End ;
    End ;
}
	Sql := 'Select * From xTabDef Where ColTabName =  ''' + pTabName + ''' Order By ' +
          'ColTabName, ColID' ;
    Q.Sql.Clear ;
    Q.Sql.Add(Sql) ;
    Try
       Q.Open ;
       Result := Q ;
    Except
       Result := Nil ;
    End ;

End ;

(* ========================================================================= *)


(* ------------------------------------------------------------------------- *
 * Create -> Cria a vari�vel                                                 *
(* ------------------------------------------------------------------------- *)
Constructor TSQLTableClass.Create ;
Begin
   FDBName := VarDBName ;
   FDBType := VarDBType ;
   FSql      := ''  ;
   FMensErro := '' ;
   FErro     := False ;
   FNumErro  := 0 ;
   FNullValues := False ;
   FQuery := TFDQuery.Create(Self) ;
   FQuery.Connection := DB_Conect.FDConnection ;
//   FQuery.DatabaseName := FDBName ;
   FQuerySelect := TFDQuery.Create(Self) ;
   FQuerySelect.Connection := DB_Conect.FDConnection ;
//   FQuerySelect.DatabaseName := FDBName ;
   FQResult := TFDQuery.Create(Self) ;
   FQResult.Connection := DB_Conect.FDConnection ;
//   FQResult.DatabaseName := FDBName ;
   QResult := TFDQuery.Create(Self) ;
   QResult.Connection := DB_Conect.FDConnection ;
//   QResult.DatabaseName := FDBName ;
End ;

(* ------------------------------------------------------------------------- *
 * Destroy -> Destroi a vari�vel                                             *
(* ------------------------------------------------------------------------- *)
Destructor TSQLTableClass.Destroy ;
Begin
   Case FDBType Of
       DBTYPE_PARADOX : Begin
           FTable.Close ;
       End ;
   End ;
   FQuery.Close ;
   FQuerySelect.Close ;
   FQResult.Close ;
   If ( QResult <> Nil ) Then
      QResult.Close ;
End ;

(* ------------------------------------------------------------------------- *
 * SQLTable_GetMensErro -> Devolve a mensagem de erro obtida                 *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetMensErro : String ;
Begin
	Result := FMensErro ;
End ;

(* ------------------------------------------------------------------------- *
 * TSQLTableClass.Error -> Devolve se um erro ocorreu                              *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetError : Boolean ;
Begin
	Result := FErro ;
End ;

(* ------------------------------------------------------------------------- *
 * TSQLTableClass.GetNumErro -> Devolve se um erro ocorreu                        *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetNumErro : Integer ;
Begin
	Result := FNumErro ;
End ;

(* ------------------------------------------------------------------------- *
 * SqlTable_Start = Inicia a comunica��o com o banco de dados                *
 *                  Fun��o externa para ser chamada uma �nica vez            *
 *                                                                           *
 * Parametros: DBName -> Nome do database para a comunica��o                 *
 *             DBTyope -> Tipo do banco de dados                             *
(* ------------------------------------------------------------------------- *)
Function SqlTable_Start ( DBName : String ; DBType : Integer = DBTYPE_PARADOX ) : Boolean ;
Begin
   Result := False ;
   If ( Test_IsEmptyStr(DBName) ) Then
       Exit ;
   VarDBName := DBName ;
   VarDBType := DBType ;
End ;

(* ------------------------------------------------------------------------- *
 * SqlTable_GetDBType                                                        *
 *    Devolve o tipo de banco de dados utilizado                             *
(* ------------------------------------------------------------------------- *)
Function SqlTable_GetDBType : Integer ;
Begin
   Result := VarDBType ;
End ;

Function SqlTable_GetDBName : String ;
Begin
   Result := VarDBName ;
End ;

(* ------------------------------------------------------------------------- *
 * TSQLTableClass.OpenTable                                                       *
 *      Determina a tabela que ser� utilizada nas fun��es. Abre a tabela.    *
 *      Preenche o vetor com os dados dos campos                             *
 *                                                                           *
 * Parametros: TableName -> Nome da tabela                                   *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.OpenTable ( TableName : String ) : Boolean ;
Var
   i : Integer ;
   sLastCol : String ;
Begin
   Result := False ;
   Case FDBType Of
       DBTYPE_PARADOX : Begin
           If ( Str_CasePos('.db',TableName) = 0 ) Then
               TableName := TableName + '.db' ;
           FTableName := TableName ;
           Try
               FTable := TTable.Create(Self) ;

               FTable.DatabaseName := FDBName ;
               FTable.TableName := FTableName ;
               FTable.Open ;
               FFieldCount := FTable.FieldCount ;
               For i:=0 To FTable.FieldCount-1 Do
               Begin
                   FFieldDesc[i].FName     := FTable.Fields[i].FieldName ;
                   FFieldDesc[i].FPos      := i ;
                   FFieldDesc[i].FType     := GetFieldType(FTable.Fields[i].FieldName) ;
               End ;
               SetError ;
               Result := True ;
           Except
               on E: Exception do
               Begin
               	SetError(E.Message) ;
						Result := False ;
               End ;
           End ;
       End ;
       DBTYPE_ACCESS : Begin
           FTableName := TableName ;
           Try
               FQuery.Sql.Clear ;
               FQuery.Sql.Add('Select * From ' + FTableName) ;
               FQuery.Close ;
               FQuery.Open ;
               FFieldCount := FQuery.FieldCount ;
               For i:=0 To FQuery.FieldCount-1 Do
               Begin
                   FFieldDesc[i].FName := FQuery.Fields[i].FieldName ;
                   FFieldDesc[i].FPos  := i ;
                   FFieldDesc[i].FType := GetFieldType(FQuery.Fields[i].FieldName) ;
               End ;
               SetError ;
               Result := True ;
           Except
               on E: Exception do
               Begin
					   SetError(E.Message) ;
                   Result := False ;
               End ;
           End ;
       End ;
       DBTYPE_SQLSERVER_65 ,
       DBTYPE_SQLSERVER_70 : Begin
           FTableName := TableName ;
           FQuery := GetSqlServerTabFields(FTableName) ;
           If ( FErro ) Then
           Begin
               Result := False ;
               Exit ;
           End ;
           sLastCol := '' ;
           i := 0 ;
           While ( Not FQuery.Eof ) Do
           Begin
               If ( sLastCol <> FQuery.FieldByName('ColName').AsString ) Then
               Begin
                  FFieldDesc[i].FName     := FQuery.FieldByName('ColName').AsString ;
                  FFieldDesc[i].FPos      := i ;
                  FFieldDesc[i].FType     := GetFieldType(FQuery.FieldByName('ColType').AsString) ;
                  FFieldDesc[i].FDecimals := FQuery.FieldByName('ColScale').AsInteger ;
                  FFieldDesc[i].FAutoVal  := FQuery.FieldByName('ColAutoVal').AsInteger ;
                  sLastCol := FQuery.FieldByName('ColName').AsString ;
                  i := i + 1 ;
               End ;
               FQuery.Next ;
           End ;
           FFieldCount := i ;
           SetError ;
           Result := True ;
       End ;
   End ;
   FKeyCount := 0 ;
   For i:=1 To MAX_KEYFIELDS Do
       FKeyFields[i] := -1 ;
End ;

(* ------------------------------------------------------------------------- *
 * SetDBName -> Modifica o DBName                                            *
(* ------------------------------------------------------------------------- *)
Procedure TSQLTableClass.SetDBName ( Value : String ) ;
Begin
   FDBName := Value ;
   FQuery.Connection       := DB_Conect.FDConnection ;
   FQuerySelect.Connection := DB_Conect.FDConnection ;
   FQResult.Connection     := DB_Conect.FDConnection ;
   QResult.Connection      := DB_Conect.FDConnection ;

//   FQuery.DatabaseName := FDBName ;
//   FQuerySelect.DatabaseName := FDBName ;
//   FQResult.DatabaseName := FDBName ;
//   QResult.DatabaseName := FDBName ;
End ;

(* ------------------------------------------------------------------------- *
 * SetDBType -> Modifica o DBType                                            *
(* ------------------------------------------------------------------------- *)
Procedure TSQLTableClass.SetDBType ( Value : Integer ) ;
Begin
   FDBType := Value ;
End ;

(* ------------------------------------------------------------------------- *
 * TSQLTableClass.SetUpdField -> Determina se um campo vai participar de          *
 *                          atualiza��es                                     *
 *                                                                           *
 * Parametros: FieldName -> Determinador do campo                            *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.SetUpdField ( FieldName : String ) : Boolean ;
Begin
	FFieldPos := GetFieldPos(FieldName) ;
   If ( FFieldPos <> -1 ) Then
   Begin
		FFieldName := FieldName ;
		FFieldDesc[FFieldPos].FUpdOk := True ;
		SetError ;
		Result := True ;
   End
   Else Begin
		FFieldName := '' ;
		SetError('SQLTable Error: Field not Found [' + FieldName + ']') ;
		Result := False ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * ResetUpdField -> Set para nao atualizacao um determinado campo            *
 *                                                                           *
 * Parametros: FieldName -> Determinador do campo                            *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.ResetUpdField ( FieldName : String ; Value : Boolean = False ) : Boolean ;
Begin
   FFieldPos := GetFieldPos(FieldName) ;
   If ( FFieldPos <> -1 ) Then
   Begin
		FFieldName := FieldName ;
		FFieldDesc[FFieldPos].FUpdOk := Value ;
		SetError ;
		Result := True ;
   End
   Else Begin
		FFieldName := '' ;
		SetError('SQLTable Error: Field not Found [' + FieldName + ']') ;
		Result := False ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * ResetAllUpdFields -> Reseta os campos anteriormentes setados para atualizar  *
(* ------------------------------------------------------------------------- *)
Procedure TSQLTableClass.ResetAllUpdFields ( Value : Boolean = False ) ;
Var
   i : Integer ;
Begin
   For i:=0 To FFieldCount-1 Do
		FFieldDesc[i].FUpdOk := Value ;
End ;

(* ------------------------------------------------------------------------- *
 * GetNumFields -> Devolve o n�mero de campos de uma tabela                  *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetNumFields : Integer ;
Begin
   Result := FFieldCount ;
End ;

(* ------------------------------------------------------------------------- *
 * SetFieldValues -> Determina o valor de um campo                           *
 *                                                                           *
 * Parametros: FieldName -> Determinador do campo                            *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.SetFieldValue ( FieldName : String ; FieldValue : Variant ) : Boolean ;
Begin
   FFieldPos := GetFieldPos(FieldName) ;
   If ( FFieldPos <> -1 ) Then
   Begin
		FFieldName := FieldName ;
		FFieldDesc[FFieldPos].FValue := FieldValue ;
		FFieldDesc[FFieldPos].FUpdOk := True ;
		SetError ;
		Result := True ;
   End
   Else
   Begin
		FFieldName := '' ;
		SetError('SQLTable Error: SetFieldValues -> Field not Found [' + FieldName + ']') ;
//    ShowMessage('[SetFieldValue] - Field <' + FieldName + '> not found') ;
		Result := False ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * SetFieldValues -> Determina o valor de um campo                           *
 *                                                                           *
(* ------------------------------------------------------------------------- *)
Function TSqlTableClass.SetFieldValue ( FieldPos : Integer ; FieldValue : Variant ) : Boolean ;
Begin
   FFieldDesc[FieldPos].FValue := FieldValue ;
   FFieldDesc[FieldPos].FUpdOk := True ;
   SetError ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * FormToFieldValues -> Seta valores para os campos baseados nos objetos     *
 *                      do formulario com o mesmo nome dos campos da tabela  *
 *                      Os Nomes dos campos no formulario DEVEM ter as tres  *
 *                      primeiras letras determinando o tipo do campo; o nome*
 *                      do campo na tabela deve vir a partir da quarta pos.  *
 *                                                                           *
 * Parametros: F -> Formulario                                               *
(* ------------------------------------------------------------------------- *)
Procedure TSQLTableClass.FormToFieldValues ( F : TForm = Nil ) ;
Var
   i, p : Integer ;
   FormName : String ;
Begin
   If ( F = Nil ) Then
		F := Screen.ActiveForm ;
   For i:=0 To F.ComponentCount-1 Do
   Begin
		FormName := Obj_GetFormObjName(F,i) ;
		p := GetFieldPos(FormName) ;
		If ( p = -1 ) Then
			 Continue ;
		FFieldDesc[p].FValue := Obj_GetFormObjValue(F,i) ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * FieldValuesToForm -> Preenche os objetos do formulario baseado nos valores*
 *                      dos campos da tabela.                                *
 *                      Os Nomes dos campos no formulario DEVEM ter as tres  *
 *                      primeiras letras determinando o tipo do campo; o nome*
 *                      do campo na tabela deve vir a partir da quarta pos.  *
 *                                                                           *
 * Parametros: F -> Formulario                                               *
(* ------------------------------------------------------------------------- *)
Procedure TSQLTableClass.FieldValuesToForm ( F : TForm = Nil ) ;
Var
   i, p : Integer ;
   FormName : String ;
Begin
   If ( F = Nil ) Then
		F := Screen.ActiveForm ;
   For i:=0 To F.ComponentCount-1 Do
   Begin
		FormName := Obj_GetFormObjName(F,i) ;
		p := GetFieldPos(FormName) ;
		If ( p = -1 ) Then
			 Continue ;
		Obj_SetFormObjValue(F,i,FFieldDesc[p].FValue) ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * SetExecTS -> Indica se vai executar a compara��o do TimeStamp             *
(* ------------------------------------------------------------------------- *)
Procedure TSQLTableClass.SetExecTS(pbValue : Boolean) ;
Begin
   FExecTS := pbValue ;
End ;

(* ------------------------------------------------------------------------- *
 * SetKeyValue -> Indica que um campo faz parte da chave da tabela com o seu *
 *                valor                                                      *
 *                                                                           *
 * Parametros: FieldName -> Determinador do campo                            *
 *             FieldValue -> Valor do campo                                  *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.SetKeyValue ( FieldName : String ; FieldValue : Variant ; ParResetKey : Boolean = False ) : Boolean ;
Begin
   If ( ParResetKey ) Then
		ResetKey ;
   FFieldPos := GetFieldPos(FieldName) ;
   If ( FFieldPos <> -1 ) Then
   Begin
		FFieldName := FieldName ;
		Inc(FKeyCount) ;
		If ( FKeyCount > MAX_KEYFIELDS ) Then
		Begin
			 ResetKey ;
			 SetError('SQLTable Error: SetKey -> Number of key fields exceded') ;
			 Result := False ;
			 Exit ;
		End ;
		FKeyFields[FKeyCount] := FFieldPos ;
		FFieldDesc[FFieldPos].FValue := FieldValue ;
		FFieldDesc[FFieldPos].FUpdOk := True ;
		SetError ;
		Result := True ;
   End
   Else Begin
		ResetKey ;
		SetError('SQLTable Error: SetKey -> Field not Found [' + FieldName + ']') ;
	Result := False ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * ResetKey -> Reseta a chave da tabela                                      *
(* ------------------------------------------------------------------------- *)
Procedure TSQLTableClass.ResetKey ;
Var
   i : Integer ;
Begin
   FKeyCount := 0 ;
   For i:=1 To MAX_KEYFIELDS Do
		FKeyFields[i] := -1 ;
End ;

(* ------------------------------------------------------------------------- *
 * SetFieldKey -> Indica que um campo faz parte da chave da tabela           *
 *                                                                           *
 * Parametros: FieldName -> Determinador do campo                            *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.SetFieldKey ( FieldName : String ) : Boolean ;
Begin
   FFieldPos := GetFieldPos(FieldName) ;
   If ( FFieldPos <> -1 ) Then
   Begin
		FFieldName := FieldName ;
		Inc(FKeyCount) ;
		If ( FKeyCount > MAX_KEYFIELDS ) Then
		Begin
			 ResetKey ;
			 SetError('SQLTable Error: SetKey -> Number of key fields exceded') ;
			 Result := False ;
			 Exit ;
		End ;
		FKeyFields[FKeyCount] := FFieldPos ;
		FFieldDesc[FFieldPos].FUpdOk := True ;
		SetError ;
		Result := True ;
   End
   Else Begin
		ResetKey ;
		SetError('SQLTable Error: SetKey -> Field not Found [' + FieldName + ']') ;
		Result := False ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * SetKey -> Determina o valor das chaves da tabela                          *
 *                                                                           *
 * Parametros: Values -> array com os valores da chave da tabela             *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.SetKey ( Values : Array of Variant ) : Boolean ;
Var
   i : Integer;
Begin
   For i:=1 To FKeyCount Do
		FFieldDesc[FKeyFields[i]].FValue := Values[i-1] ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * GetFieldValue -> Pega o valor de um campo da tabela tabela                *
 *                                                                           *
 * Parametros: FieldName -> Determinador do campo                            *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetFieldValue ( FieldName : String ) : Variant ;
Begin
   FFieldPos := GetFieldPos(FieldName) ;
   If ( FFieldPos <> -1 ) Then
   Begin
		FFieldName := FieldName ;
		Try
			 Result := FFieldDesc[FFieldPos].FValue ;
			 If ( Result = Null ) Then
			 Begin
					Case FFieldDesc[FFieldPos].FType Of
						ftString   : Result := '' ;
						ftInteger  ,
						ftFloat    : Result := 0 ;
						ftDateTime : Result := Str_StrToDate('') ;
					End ;
			 End ;
		Except
			 SetError('SQLTable Error: GetFieldValue -> Invalid Field Value [' + FieldName + ']') ;
		End ;
   End
   Else Begin
		SetError('SQLTable Error: GetFieldValue -> Field not Found [' + FieldName + ']') ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * GetTabFieldType -> Devole o tipo de um campo da tabela                    *
 *                                                                           *
 * Parametros: FieldName -> Determinador do campo                            *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetTabFieldType ( FieldName : String ) : TFieldType ;
Begin
   FFieldPos := GetFieldPos(FieldName) ;
   If ( FFieldPos <> -1 ) Then
   Begin
		FFieldName := FieldName ;
		Try
			 Result := FFieldDesc[FFieldPos].FType ;
		Except
			 SetError('SQLTable Error: GetFieldType -> Invalid Field Value [' + FieldName + ']') ;
		End ;
   End
   Else Begin
		SetError('SQLTable Error: GetFieldType -> Field not Found [' + FieldName + ']') ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * GetFieldName -> Devolve o nome de um campo da tabela                      *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetFieldName ( pInd : Integer ) : String ;
Begin
   Result := FFieldDesc[pInd].FName ;
End ;

(* ------------------------------------------------------------------------- *
 * GetFieldName -> Devolve o nome de um campo da tabela                      *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetFieldAutoVal ( pInd : Integer ) : Boolean ;
Begin
   If ( FDBType = DBTYPE_SQLSERVER_70 ) Then
   Begin
      If ( FFieldDesc[pInd].FAutoVal = 0 ) Then
         Result := False
      Else
         Result := True ;
   End
   Else Begin
      If ( FFieldDesc[pInd].FAutoVal = 128 ) Then
         Result := False
      Else
         Result := True ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * Find -> Procura um registro baseado na chave setada em FKeyFields         *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.Find ( FillDesc : Boolean = False ) : Boolean ;
Var
   ResultEof : Boolean ;
Begin
   ResultEof := False ;
   Result := False ;
   If ( Not GetSqlSelect ) Then
		Exit ;
	Case FDBType Of
   	   DBTYPE_PARADOX : Begin
           If ( Not GetVariantKey ) Then
               Exit ;
           ResultEof := FTable.Locate(FSql,FVariantKey,[]) ;
       End ;
       DBTYPE_SQLSERVER_65 ,
       DBTYPE_SQLSERVER_70 ,
       DBTYPE_ACCESS    : Begin
           FQuerySelect.Close ;
           FQuerySelect.Sql.Clear ;
           FQuerySelect.Sql.Add(FSql) ;
           Try
               FQuerySelect.Open ;
           Except
               on E: Exception do
               Begin
                   SetError(E.Message);
                   Result := False ;
                   Exit ;
               End ;
           End ;
           ResultEof := Not FQuerySelect.Eof ;
//           If ( FDBType = DBTYPE_SQLSERVER_70 ) Then
//              FTimeStamp := FQuerySelect.FieldByName('TimeStamp').AsDateTime ;
		End ;
   End ;
   If ( ResultEof ) Then
   Begin
       If ( FillDesc ) Then
          If ( Not FillDescFieldValues ) Then
               Exit ;
       Result := True ;
   End
   Else
       Result := False ;
End ;

(* ------------------------------------------------------------------------- *
 * Next -> Pega o pr�ximo registro baseado na posicao da tabela              *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.Next ( FillFields : Boolean = True ) : Boolean ;
Var
   ResultEof : Boolean ;
Begin
	Result := False ;
	Case FDBType Of
	DBTYPE_PARADOX : Begin
			 FTable.Next ;
			 If ( FTable.Eof ) Then
				  Result := False
           Else Begin
               If ( FillFields ) Then
                   If ( Not FillDescFieldValues ) Then
                       Exit ;
               Result := True ;
           End ;
   End ;
   DBTYPE_SQLSERVER_65 ,
   DBTYPE_SQLSERVER_70 ,
   DBTYPE_ACCESS    : Begin
      If ( Not GetSqlNextOrPrior('NEXT') ) Then
         Exit ;
      If ( FDBType = DBTYPE_ACCESS ) Then
         If ( Not GetExecSql('SET ROWCOUNT 1') ) Then
            Exit ;
      FQuerySelect.Close ;
      FQuerySelect.Sql.Clear ;
      FQuerySelect.Sql.Add(FSql) ;
      Try
          FQuerySelect.Open ;
      Except
          on E: Exception do
          Begin
              GetExecSql('SET ROWCOUNT 0') ;
              SetError(E.Message);
              Result := False ;
              Exit ;
          End ;
      End ;
      GetExecSql('SET ROWCOUNT 0') ;
      ResultEof := FQuerySelect.Eof ;
//      If ( FDBType = DBTYPE_SQLSERVER_70 ) Then
//         FTimeStamp := FQuerySelect.FieldByName('TimeStamp').AsDateTime ;
      If ( Not ResultEof ) Then
      Begin
          If ( FillFields ) Then
             If ( Not FillDescFieldValues ) Then
                  Exit ;
          Result := True ;
      End
      Else
          Result := False ;
      GetExecSql('SET ROWCOUNT 0') ;
   End ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * Prior -> Pega o registro anterior baseado na posicao da tabela            *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.Prior ( FillFields : Boolean = True ) : Boolean ;
Begin
   Result := False ;
	Case FDBType Of
   	DBTYPE_PARADOX : Begin
           FTable.Prior ;
           If ( FTable.Bof ) Then
               Result := False
           Else Begin
               If ( FillFields ) Then
                   If ( Not FillDescFieldValues ) Then
                       Exit ;
               Result := True ;
           End ;
       End ;
       DBTYPE_SQLSERVER_65 ,
       DBTYPE_SQLSERVER_70 ,
       DBTYPE_ACCESS    : Begin
          If ( Not GetSqlNextOrPrior('PRIOR') ) Then
             Exit ;
          If ( FDBType = DBTYPE_ACCESS ) Then
             If ( Not GetExecSql('SET ROWCOUNT 1') ) Then
                Exit ;
          FQuerySelect.Close ;
          FQuerySelect.Sql.Clear ;
          FQuerySelect.Sql.Add(FSql) ;
          Try
             FQuerySelect.Open ;
          Except
             on E: Exception do
             Begin
                 GetExecSql('SET ROWCOUNT 0') ;
                 SetError(E.Message);
                 Result := False ;
                 Exit ;
             End ;
          End ;
          GetExecSql('SET ROWCOUNT 0') ;
//          If ( FDBType = DBTYPE_SQLSERVER_70 ) Then
//             FTimeStamp := FQuerySelect.FieldByName('TimeStamp').AsDateTime ;
          If ( FillFields ) Then
             If ( Not FillDescFieldValues ) Then
                  Exit ;
          Result := True ;
       End ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * GetLastIdentity : Devolve o ID do �ltimo registro                         *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetLastIdentity : LongInt ;
Begin
   Result := -1 ;
   If ( Not GetExecSqlSel('Select @@IDENTITY As ''Identity''') ) Then
      Exit ;
   Result := FQResult.FieldByName('Identity').AsInteger ;
End ;

(* ------------------------------------------------------------------------- *
 * GetNumRows -> Devolve o n�mero de linhas afetado pelo �ltimo statement    *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetNumRows : LongInt ;
Begin
   Result := -1 ;
   FQuerySelect.Close ;
   FQuerySelect.Sql.Clear ;
   FQuerySelect.Sql.Add('Select @@ROWCOUNT As ''NumRows''') ;
   Try
      FQuerySelect.Open ;
   Except
      On E:Exception Do
      Begin
         SetError(E.Message) ;
         Exit ;
      End ;
   End;
   Result := FQuerySelect.FieldByName('NumRows').AsInteger ;
End ;

(* ------------------------------------------------------------------------- *
 * Insert  = Insere um registro numa tabela                                  *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.Insert ( ClearUpdFields : Boolean = True ) : Boolean ;
Var
   i : Integer ;
Begin
   Result := False ;
   Case FDBType Of
		DBTYPE_PARADOX : Begin
			 Try
				  FTable.Append ;
				  For i:=0 To FFieldCount-1 Do
				  Begin
						If ( FFieldDesc[i].FUpdOk ) Then
							 Try
								  FTable.FieldValues[FFieldDesc[i].FName] := FFieldDesc[i].FValue ;
							 Except
							 End ;
				  End ;
					FTable.Post ;
           Except
               on E:Exception do
               Begin
                   FTable.Cancel ;
                   FExceptErro := E.Message ;
                   SetError('<>') ;
                   Exit ;
               End ;
           End ;
       End ;
       DBTYPE_SQLSERVER_65 ,
       DBTYPE_SQLSERVER_70 ,
       DBTYPE_ACCESS    : Begin
           If ( Not GetSqlInsert ) Then
               Exit ;
           FQuery.Close ;
           FQuery.Sql.Clear ;
           FQuery.Sql.Add(FSql) ;
           Try
               FQuery.ExecSql ;
           Except
               on E:Exception do
               Begin
                   FExceptErro := E.Message ;
                   SetError('<>') ;
                   Exit ;
               End ;
           End ;
       End ;
   End ;
   If ( ClearUpdFields ) Then
       ResetAllUpdFields ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * Update -> Altera um registro baseado nos campos determinados              *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.Update ( ClearUpdFields : Boolean = True ;
                            ExecFind : Boolean = True ) : Boolean ;
Var
   i : Integer ;
Begin
   Result := False ;
   Case FDBType Of
       DBTYPE_PARADOX : Begin
           If ( ExecFind ) Then
           Begin
               If ( Not Find ) Then
               Begin
                   SetError('SQLTable Error: Update -> Record not Found') ;
                   Exit ;
               End ;
           End ;
           Try
               FTable.Edit ;
               For i:=0 To FFieldCount-1 Do
               Begin
                   If ( FFieldDesc[i].FUpdOk ) Then
                       Try
                           FTable.FieldValues[FFieldDesc[i].FName] := FFieldDesc[i].FValue ;
                       Except
                       End ;
               End ;
               FTable.Post ;
           Except
               on E: Exception do
               Begin
                   FTable.Cancel ;
                   FExceptErro := E.Message ;
                   SetError('<>') ;
                   Exit ;
               End ;
           End ;
       End ;
       DBTYPE_SQLSERVER_65 ,
       DBTYPE_SQLSERVER_70 ,
       DBTYPE_ACCESS    : Begin
           If ( Not GetSqlUpdate ) Then
               Exit ;
           FQuery.Close ;
           FQuery.Sql.Clear ;
           FQuery.Sql.Add(FSql) ;
           If ( FDBType = DBTYPE_SQLSERVER_70 ) Then
           Begin
              If ( FExecTS ) Then
                 FQuery.ParamByName('Par_TS').AsDateTime := FTimeStamp ;
           End ;
           Try
               FQuery.ExecSql ;
           Except
               on E: Exception do
               Begin
                   FExceptErro := E.Message ;
                   SetError('<>') ;
						Exit ;
               End ;
           End ;
           If ( FDBType = DBTYPE_SQLSERVER_70 ) Then
           Begin
              If ( GetRowModified() <= 0 ) Then
              Begin
                  SetError('Este(s) registro(s) provavelmente foram modificado(s) ' +
                           'anteriormente por outro processo. ' +
                           'Por favor repita o processamento realizado.') ;
                  FNumErro := ERRO_REC_MODIFIED ;
                  Exit ;
              End ;
           End ;
       End ;
   End ;
   If ( ClearUpdFields ) Then
       ResetAllUpdFields ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * Delete -> Exclui um registro baseado nos campos determinados              *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.Delete : Boolean ;
Begin
   Result := False ;
	Case FDBType Of
   	DBTYPE_PARADOX : Begin
           If ( Not Find ) Then
           Begin
               SetError('SQLTable Error: Delete -> Record not Found') ;
               Exit ;
           End ;
			 Try
               FTable.Delete ;
               Result := True ;
           Except
               on E: Exception do
               Begin
                   FTable.Cancel ;
                   SetError('SQLTable Error: Delete (PARADOX) -> ' + E.Message);
                   Exit ;
               End ;
           End ;
       End ;
       DBTYPE_SQLSERVER_65 ,
       DBTYPE_SQLSERVER_70 ,
       DBTYPE_ACCESS    : Begin
           If ( Not GetSqlDelete ) Then
               Exit ;
           FQuery.Close ;
           FQuery.Sql.Clear ;
           FQuery.Sql.Add(FSql) ;
           If ( FDBType = DBTYPE_SQLSERVER_70 ) Then
           Begin
              If ( FExecTS ) Then
                 FQuery.ParamByName('Par_TS').AsDateTime := FTimeStamp ;
           End ;
           Try
               FQuery.ExecSql ;
           Except
               on E: Exception do
				  Begin
                   FExceptErro := E.Message ;
                   SetError('<>') ;
                   Result := False ;
                   Exit ;
               End ;
           End ;
           If ( FDBType = DBTYPE_SQLSERVER_70 ) Then
           Begin
              If ( GetRowModified() <= 0 ) Then
              Begin
                  SetError('Este(s) registro(s) provavelmente foram modificado(s) ' +
                           'anteriormente por outro processo. ' +
                           'Por favor repita o processamento realizado.') ;
                  FNumErro := ERRO_REC_MODIFIED ;
                  Exit ;
              End ;
           End ;
       End ;
   End ;
   ResetAllUpdFields ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * SetInsert => Executa o comando SET INDENTITY_INSERT (SQL 6.5)            *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.SetInsert ( TabName : String ; Value : String ) : Boolean ;
Var
   Sql : String ;
Begin
   Result := False ;
   If ( (FDBType <> DBTYPE_SQLSERVER_65) And (FDBType <> DBTYPE_SQLSERVER_70) ) Then
      Exit ;
   Sql := 'SET IDENTITY_INSERT ' + TabName + ' ' + Value ;
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add(Sql) ;
   Try
       FQuery.ExecSql ;
   Except
       on E: Exception do
       Begin
           SetError(E.Message) ;
           Exit ;
       End ;
   End ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * ExecSqlSel -> Executa um comando sql de select                            *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.ExecSqlSel ( Sql : String ) : TFDQuery ;
Begin
   SetError() ;
   QResult := Nil ;
   FQResult.Close ;
   FQResult.Sql.Clear ;
   FQResult.Sql.Add(Sql) ;
   Try
       FQResult.Open ;
   Except
       on E: Exception do
       Begin
           Result := Nil ;
           SetError(E.Message);
           FNumErro := GetDBError() ;
           Exit ;
       End ;
   End ;
   QResult := FQresult ;
   Result := FQResult ;
End ;

(* ------------------------------------------------------------------------- *
 * ExecSql -> Executa um comando sql generico                                *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.ExecSql ( Sql : String ) : TFDQuery ;
Begin
   SetError() ;
   QResult := Nil ;
   FQResult.Close ;
   FQResult.Sql.Clear ;
   FQResult.Sql.Add(Sql) ;
   Try
       FQResult.ExecSql ;
   Except
       on E: Exception do
       Begin
           Result := Nil ;
           SetError(E.Message);
           FNumErro := GetDBError() ;
           Exit ;
       End ;
   End ;
   QResult := FQresult ;
   Result := FQResult ;
End ;

(* ------------------------------------------------------------------------- *
 * GetExecSqlSel -> Devolve a execucao de uma query de select                *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetExecSqlSel ( Sql : String ) : Boolean ;
Begin
   ExecSqlSel(Sql) ;
   If ( FErro ) Then
      Result := False
   Else
      Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * GetExecSql -> Executa um comando sql generico                             *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetExecSql ( Sql : String ) : Boolean ;
Begin
   ExecSql(Sql) ;
   If ( FErro ) Then
      Result := False
   Else
      Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * ExecQuerySel -> Executa uma query de select                               *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.ExecQuerySel ( Q : TFDQuery = Nil ) : Boolean ;
Begin
   If ( Q = Nil ) Then
      Q := QResult ;
   SetError() ;
   Result := True ;
   Try
       Q.Open ;
   Except
       on E: Exception do
       Begin
          SetError(E.Message);
          Result := False ;
       End ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * ExecQuery -> Executa uma query                                            *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.ExecQuery ( Q : TFDQuery = Nil ) : Boolean ;
Begin
   If ( Q = Nil ) Then
      Q := QResult ;
   SetError() ;
   Result := True ;
   Try
       Q.ExecSql ;
   Except
       on E: Exception do
       Begin
          SetError(E.Message);
          Result := False ;
       End ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * BeginTrans -> Inicia uma transa��o                                        *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.BeginTrans : Boolean ;
Begin
	Case FDBType Of
// Mariana
       DBTYPE_PARADOX ,
       DBTYPE_SQLSERVER_65 ,
       DBTYPE_ACCESS : Begin
          Result := True ;
       End ;
       DBTYPE_SQLSERVER_70 : Begin
{          If ( Not GetExecSql('BEGIN TRANSACTION') ) Then
          Begin
             Result := False ;
             GetExecSql('RollBack') ;
          End
          Else Begin
}             Result := True ;
//          End ;
       End ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * ExeecCommit -> Executa um commit no banco de dados                        *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.ExecCommit : Boolean ;
Begin
	Case FDBType Of
       DBTYPE_PARADOX ,
       DBTYPE_ACCESS : Begin
          Result := True ;
       End ;
       DBTYPE_SQLSERVER_65 ,
       DBTYPE_SQLSERVER_70 : Begin
          If ( GetTransCount() > 0 ) Then
          Begin
{             If ( Not GetExecSql('COMMIT') ) Then
             Begin
                Result := False ;
                GetExecSql('RollBack') ;
             End
             Else Begin
}
                Result := True ;
//             End ;
          End ;
       End ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * RollBack -> Executa uma transacao de RollBack                             *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.ExecRollBack : Boolean ;
Begin
	Case FDBType Of
       DBTYPE_PARADOX ,
       DBTYPE_ACCESS : Begin
          Result := True ;
       End ;
       DBTYPE_SQLSERVER_65 ,
       DBTYPE_SQLSERVER_70 : Begin
{          If ( Not GetExecSql('RollBack') ) Then
          Begin
             Result := False ;
          End
          Else Begin
}
             Result := True ;
//          End ;
       End ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * FormSetFieldValue ==> Recebe um formul�rio para determinar os valores     *
 *                       dos campos                                          *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.FormSetFieldValue ( F : TForm = Nil ; Tag : Integer = 0 ) : Boolean ;
Var
   i : Integer ;
   FieldName : String ;
   Value : Variant ;
   Comp : TrsSuperEdit ;
Begin
   Result := True ;
   If ( F = Nil ) Then
       F := Screen.ActiveForm ;
   For i:=0 To F.ComponentCount-1 Do
   Begin
       If ( F.Components[i].Tag >= 0 ) Then
           Continue ;
       If ( (Tag <> 0)  And  (F.Components[i].Tag <> Tag) ) Then
			 Continue ;
		 If (( F.Components[i] Is TPanel ) or ( F.Components[i] Is TcxPageControl )) Then
			 Continue ;
		 If ( F.Components[i] Is TrsSuperEdit ) Then
			 FieldName := TrsSuperEdit(F.Components[i]).TagName
		 Else If ( F.Components[i] Is TGNRadioGroup ) Then
			 FieldName := TGNRadioGroup(F.Components[i]).FieldName
		 Else
			 FieldName := Copy(F.Components[i].Name,4,Length(F.Components[i].Name)) ;
		 If ( F.Components[i] Is TrsSuperEdit ) Then
		 Begin
			 Comp := TRSSuperEdit(F.Components[i]) ;
			 If ( Comp.Format = foReal ) Then
				  Value := Str_StrToFloat(Comp.Text)
			 Else If ( Comp.Format = foInteger ) Then
				  Value := Str_StrToInt(Comp.Text)
			 Else If  ( (Comp.Format = foDate) Or (Comp.Format = foFullDate) ) Then
       begin
            If ( (Comp.Text <> '  /  /  ') And (Comp.Text <> '  /  /    ') )   Then
                Value := Str_StrToDate(Comp.Text)
            else Value := 0;
       end
			 Else If ( Comp.Format = foCurrency ) Then
				  Value := Str_MoneyToFloat(Comp.Text,Comp.Decimals)
			 Else
				  Value := Comp.Text ;
		 End
		 Else If ( F.Components[i] Is TGNRadioGroup ) Then
			 Value := TGNRadioGroup(F.Components[i]).ItemChoice
		 Else If ( F.Components[i] Is TDateTimePicker ) Then
			 Value := TDateTimePicker(F.Components[i]).DateTime
		 Else If ( F.Components[i] Is TComboBox ) Then
			 Value := TComboBox(F.Components[i]).Text
		 Else Begin
			 Value := Obj_GetFormObjValue(F,i) ;
		 End ;
		 SetFieldValue(FieldName,Value) ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * SetFormObjValue ==> Atribui ao objetos do formulario os valores da tabela *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.SetFormObjValue ( F : TForm = Nil ; Tag : Integer = 0 ) : Boolean ;
Var
   i : Integer ;
   FieldName : String ;
   Value : Variant ;
Begin
   If ( F = Nil ) Then
		F := Screen.ActiveForm ;
   For i:=0 To F.ComponentCount-1 Do
   Begin
		If ( F.Components[i].Tag >= 0 ) Then
			 Continue ;
		If ( (Tag <> 0)  And  (F.Components[i].Tag <> Tag) ) Then
			 Continue ;
		If (( F.Components[i] Is TPanel ) or ( F.Components[i] Is TcxPageControl )) Then
			 Continue ;
		If ( F.Components[i] Is TrsSuperEdit ) Then
			 FieldName := TRSSuperEdit(F.Components[i]).TagName
		Else If ( F.Components[i] Is TGNRadioGroup ) Then
			 FieldName := TGNRadioGroup(F.Components[i]).FieldName
		Else
			 FieldName := Copy(F.Components[i].Name,4,Length(F.Components[i].Name)) ;
		Value := GetFieldValue(FieldName) ;
		Obj_SetFormObjValue(F,i,Value) ;
   End ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * SeekGet ==> Pesquisa uma chave numa tabela e devolve um campo             *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.SeekGet ( TableName : String ; Fields : String ;
									 aKey : Array of Variant ; RetField : String ;
									 Erro : Boolean = False ) : Variant ;
Var
   T : TTable ;
   bFind : Boolean ;
   k, i, j : Integer ;
   sTemp : String ;
   fldType : TFieldType ;
Begin
   Result := '' ;
	Case VarDBType Of
	    DBTYPE_PARADOX : Begin
			 T := TTable.Create(Self) ;
			 T.TableName := TableName ;
			 T.DatabaseName := FDBName ;
			 T.Open ;
			 If ( Length(aKey) > 1 ) Then
				  bFind := T.Locate(Fields,VarArrayOf(aKey),[])
           Else
               Try
                   bFind := T.Locate(Fields,aKey[0],[]) ;
               Except
                   bFind := False ;
               End ;
           If ( Not bFind ) Then
           Begin
               If ( Erro ) Then
                   Result := '**********'
               Else
                   Result := '' ;
           End
           Else
               Result := T.FieldByName(RetField).AsVariant ;
               If ( Result = Null ) Then
                   Result := '' ;
           T.Close ;
       End ;
       DBTYPE_ACCESS    ,
       DBTYPE_SQLSERVER_65 ,
       DBTYPE_SQLSERVER_70 : Begin
           FSql := 'Select ' + RetField + ' From ' + TableName + ' Where ' ;
           k := Pos(';',Fields) ;
           i := 1 ;
           j := 0 ;
           If ( k <> 0 ) Then
           Begin
               While ( k <> 0 ) Do
               Begin
                   sTemp := Copy(Fields,i,k-1) ;
                   fldType := GetFieldType(sTemp) ;
                   Case fldType Of
                       ftString ,
                       ftDateTime,
                       ftDate     : FSql := FSql + sTemp + ' = ''' + aKey[j] + ''' And ' ;
                       ftInteger,
                       ftFloat    : FSql := FSql + sTemp + ' = ' + aKey[j] + ' And ' ;
                   End ;
                   j := j + 1 ;
                   i := k + 1 ;
                   Fields := Copy(Fields,k+1,Length(Fields)) ;
                   k := Pos(';',Fields) ;
               End ;
               fldType := GetFieldType(Fields) ;
               Case fldType Of
                   ftString ,
                   ftDateTime,
                   ftDate     : FSql := FSql + Fields + ' = ''' + aKey[j] + ''' And ' ;
                   ftInteger,
                   ftFloat    : FSql := FSql + Fields + ' = ' + aKey[j] + ' And ' ;
               End ;
               FSql := Copy(FSql,1,Length(FSql)-4) ;
           End
           Else Begin
				  If ( Length(Fields) > 0 ) Then
               Begin
                   fldType := GetFieldType(Fields) ;
                   Case fldType Of
                       ftString ,
                       ftDateTime : FSql := FSql + Fields + ' = ''' + aKey[0] + '''' ;
                       ftInteger,
                       ftFloat    : FSql := FSql + Fields + ' = ' + aKey[0] ;
                   End ;
               End
               Else Begin
                   Result := '**********' ;
                   Exit ;
               End ;
           End ;
           Try
               FQuery.Close ;
               FQuery.Sql.Clear ;
               FQuery.Sql.Add(FSql) ;
               Try
                   FQuery.Open ;
               Except
                   on E: Exception do
                   Begin
                       SetError(E.Message);
                   End ;
               End ;
               If ( FQuery.Eof ) Then
               Begin
                   If ( Erro ) Then
							 Result := '**********'
                   Else
                      Result := '' ;
               End
               Else
                   Result := FQuery.Fields[0].AsString ;
                   If ( Result = Null ) Then
                       Result := '' ;
           Except
               If ( Erro ) Then
                   Result := '**********'
               Else
                   Result := '' ;
           End ;
           FQuery.Close ;
       End ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * Seek ==> Pesquisa uma chave numa tabela                                   *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.Seek ( TableName : String ; Fields : String ;  aKey : Array of Variant ) : Boolean ;
Var
   T : TTable ;
   k, i, j : Integer ;
   sTemp : String ;
Begin
   Result := False ;
	Case VarDBType Of
   	DBTYPE_PARADOX : Begin
           T := TTable.Create(Self) ;
           T.TableName := TableName ;
           T.DatabaseName := FDBName ;
           T.Open ;
           If ( Length(aKey) > 1 ) Then
               Result := T.Locate(Fields,VarArrayOf(aKey),[])
           Else Begin
               Try
                   Result := T.Locate(Fields,aKey[0],[]) ;
               Except
                   Result := False ;
               End ;
           End ;
           T.Close ;
       End ;
       DBTYPE_SQLSERVER_65 ,
       DBTYPE_SQLSERVER_70 ,
       DBTYPE_ACCESS : Begin
           FSql := 'Select ' + Fields + ' From ' + TableName + ' Where ' ;
           k := Pos(';',Fields) ;
           i := 1 ;
           j := 0 ;
           While ( k <> 0 ) Do
           Begin
               sTemp := Copy(Fields,i,k-1) ;
               FSql := FSql + sTemp + ' = ' + aKey[j] + ' And ' ;
               j := j + 1 ;
               i := k + 1 ;
               Fields := Copy(Fields,k+1,Length(Fields)) ;
               k := Pos(';',Fields) ;
           End ;
           FSql := Copy(FSql,1,Length(FSql)-4) ;
           Try
               FQuerySelect.Close ;
               FQuerySelect.Sql.Clear ;
               FQuerySelect.Sql.Add(FSql) ;
               FQuerySelect.Open ;
               Result := FQuerySelect.Eof ;
           Except
				  Result := False ;
           End ;
       End ;
   End ;
End ;

Procedure TSQLTableClass.IndexName ( Value : String ) ;
Begin
	Case VarDBType Of
   	DBTYPE_PARADOX : Begin
           FTable.IndexName := Value ;
       End ;
   End ;
End ;

(* ------------------------------------------------------------------------- *
 * SetNullValues -> Determina o valor da vari�vel para valores nulos         *
(* ------------------------------------------------------------------------- *)
Procedure TSQLTableClass.SetNullValues ( Value : Boolean ) ;
Begin
   FNullValues := Value ;
End ;

(* ------------------------------------------------------------------------- *
 * GetLastID ==> Devolve o �ltimo ID da tabela                               *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetLastID ( FieldName : String ) : Double ;
Begin
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add('Select Max(' + FieldName + ') From ' + FTableName) ;
   Try
      FQuery.Open ;
      Result := FQuery.Fields[0].AsFloat ;
   Except
      On E:Exception Do
      Begin
         SetError(E.Message) ;
         Result := -1 ;
      End ;
   End;
End ;

(* ------------------------------------------------------------------------- *
 * GetTransCount => Devolve o n�mero de transa��es abertas                   *
(* ------------------------------------------------------------------------- *)
Function TSQLTableClass.GetTransCount : Integer ;
Begin
   FQuery.Close ;
   FQuery.Sql.Clear ;
   FQuery.Sql.Add('Select @@TRANCOUNT') ;
   Try
      FQuery.Open ;
      Result := FQuery.Fields[0].AsInteger ;
   Except
      On E:Exception Do
      Begin
         SetError(E.Message) ;
         Result := -1 ;
      End ;
   End;
End ;

end.

