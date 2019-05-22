unit CParFinanc ;

interface

Uses
     SysUtils, Windows, DB, DBTables, Classes, SqlTableFun ;

Const

   DBTYPE_PARADOX   = 1 ;
   DBTYPE_SQLSERVER = 2 ;

Type TParFinanc = Class(TComponent)
       Private
           FTable : TSqlTable ;
           FQuery : TQuery ;
           FError : Integer ;
           FMensErro : String ;
           Procedure SetError ( Num : Integer ; Mens : String = '' ) ;
       Public
           DtTrab : TDateTime ;
           ConRec_IR : Double ;
           ContaUS, ContaBR, ContaCabo : String[15] ;
           PercBoaTaxa : Double ;
           Constructor Create ( DBType : Integer = -1 ; DBName : String = '' ) ; reintroduce ;
           Destructor Destroy ; reintroduce ;
           Function ErrorNumber : Integer ;
           Function Error : Boolean ;
           Function GetMensErro : String ;
           Function Update : Boolean ;
           Function Select : Boolean ;
           Function UpdDtTrab ( Dt : TDateTime ) : Boolean ;
End ;

implementation

Uses
   Global, TestFun, StrFun, NumFun, MensFun, DateFun, Constantes ;

Const
   ERROR_OK        = 0 ;
   ERROR_QUERY     = 1 ;
   ERROR_EOF       = 2 ;
   ERROR_CHECK     = 4 ;

(* ------------------------------------------------------------------------- *
 * Create -> Cria a variável                                                 *
(* ------------------------------------------------------------------------- *)
Constructor TParFinanc.Create ( DBType : Integer = -1 ; DBName : String = '' ) ;
Begin
   FTable := TSqlTable.Create ;
   FTable.OpenTable('ParFinanc') ;
   FQuery := TQuery.Create(Self) ;
   FQuery.DatabaseName := SqlTable_GetDBName() ;
End ;

(* ------------------------------------------------------------------------- *
 * Destroy -> Destroi a variável                                             *
(* ------------------------------------------------------------------------- *)
Destructor TParFinanc.Destroy ;
Begin
   FQuery.Close ;
   FTable.Destroy ;
End ;

(* ------------------------------------------------------------------------- *
 * ErrorNumber -> Devolve o numero do erro                                      *
(* ------------------------------------------------------------------------- *)
Function TParFinanc.ErrorNumber : Integer ;
Begin
   Result := FError ;
End ;

(* ------------------------------------------------------------------------- *
 * Error -> Devolve se ocorreu um erro                                          *
(* ------------------------------------------------------------------------- *)
Function TParFinanc.Error : Boolean ;
Begin
   Result := (FError = ERROR_OK) ;
End ;

(* ------------------------------------------------------------------------- *
 * GetMensErro --> Devolve a menagem de erro                                 *
(* ------------------------------------------------------------------------- *)
Function TParFinanc.GetMensErro : String ;
Begin
   Result := FMensErro ;
End ;

(* ------------------------------------------------------------------------- *
 * SetError -> Indica a ocorrencia de um erro                                 *
(* ------------------------------------------------------------------------- *)
Procedure TParFinanc.SetError ( Num : Integer ; Mens : String = '' ) ;
Begin
   FError := Num ;
   If ( Num = ERROR_OK ) Then
      FMensErro := ''
   Else
      FMensErro := Mens ;
End ;

(* ------------------------------------------------------------------------- *
 * Update --> Atualiza os dados                                              *
(* ------------------------------------------------------------------------- *)
Function TParFinanc.Update : Boolean ;
Begin
    SetError(ERROR_OK) ;
    FTable.SetFieldKey('') ;
    FTable.SetFieldValue('DtTrab',DtTrab) ;
    FTable.SetFieldValue('ConRec_IR',ConRec_IR) ;
    FTable.SetFieldValue('ContaUS',ContaUS) ;
    FTable.SetFieldValue('ContaBR',ContaBR) ;
    FTable.SetFieldValue('ContaCabo',ContaCabo) ;
    FTable.SetFieldValue('PercBoaTaxa',PercBoaTaxa) ;
    Result := FTable.Update() ;
End ;

(* ------------------------------------------------------------------------- *
 * Select -> Seleciona o registro                                            *
(* ------------------------------------------------------------------------- *)
Function TParFinanc.Select : Boolean ;
Begin
   Result := False ;
   If ( Not FTable.Find(True) ) Then
      Exit ;
   DtTrab      := FTable.GetFieldValue('DtTrab') ;
   ConRec_IR   := FTable.GetFieldValue('ConRec_IR') ;
   ContaUS     := FTable.GetFieldValue('ContaUS') ;
   ContaBR     := FTable.GetFieldValue('ContaBR') ;
   ContaCabo   := FTable.GetFieldValue('ContaCabo') ;
   PercBoaTaxa := FTable.GetFieldValue('PercBoaTaxa') ;
   Result := True ;
End ;

(* ------------------------------------------------------------------------- *
 * UpdDtTrab -> Atualiza a data de trabalho                                  *
(* ------------------------------------------------------------------------- *)
Function TParFinanc.UpdDtTrab ( Dt : TDateTime ) : Boolean ;
Begin
   DtTrab := Dt ;
   Result := Update() ;
End ;

end.


