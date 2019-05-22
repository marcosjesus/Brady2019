unit Global ;

interface

Uses
   Graphics, Forms, dbTables, IniFiles,  BDE, CCambio, CParFinanc,
    FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

Var

   G_DBHnd : hDbiDb ;                                // Database Handle

   GCorDeFundo : TColor ;

   GFormHeight, GFormWidth, GFormLeft,             // Posição e tamanho
   GFormTop : Integer ;                            // dos forms de cadastro
   GLastForm : TForm ;                             // Último formulário aberto
   GPerOperacao: Array Of String ;                 // Vetor com as operacoes permitidas para o usuario
   GPerManut: Array of String ;                    // Vetor com as opcoes de manutencao das operacoes
   GPerNumOpe : Integer ;                          // Operacoes disponiveis para um usuario

   GDatabase : String ;                            // Nome da base de dados

   GEmpresa : String ;                             // Codigo da empresa padrão
   GEmpRazao: String ;                             // Razao social da empresa padrao
   GLogo : String ;                                // Arquivo com o logotipo da empresa
   GMascContab : String ;                          // Máscara contábil
   GUsuario : String ;                             // Usuario que esta utilizando o sistema
   GSenha : String ;                               // Senha descriptografada

   (* Variáveis do arquivo ini *)
   GMoedaPrincipal : String[15] ;
   GGerarAviso     : String[1] ;
   GGerarCheque    : String[1] ;
   GFilial         : String[15] ;

   (* Cambio *)
   GCambio     : TCambio ;

   (* Parâmetros Financeiros *)
   GParFin : TParFinanc ;

Function Glob_FillPerfil ( CodUsu : String ) : Boolean ; Export ;
Function Glob_GetAccess ( CodOpe : String ; CodManut : String = '' ) : Boolean ; Export ;
Procedure Glob_ReadIni() ; Export ;
Function Glob_Cript ( Value : String ) : String ; Export ;
Function Glob_Decript ( Value : String ) : String ; Export ;
Function Glob_GetDigito ( CodRes : Integer ) : String ; Overload ; Export ;
Function Glob_GetDigito ( CodRes : String ) : String ; Overload ; Export ;
Function Glob_GetParFin : Boolean ;

implementation

Uses
   StrFun, SQLTableFun, NumFun ;

(* ---------------------------------------------------------------------- *)
(* Glob_FillPerfil => Enche os vetores com as caracteristicas do perfil   *)
(*                   do usuario                                           *)
(* ---------------------------------------------------------------------- *)
Function Glob_FillPerfil ( CodUsu : String ) : Boolean ;
Var
   Tab : TSqlTableClass ;
   CodPer : String ;
   QPerOpe : TFDQuery ;
   i : Integer ;
Begin

   Result := False ;

   Tab := TSqlTableClass.Create ;
   If ( Not Tab.OpenTable('USUARIO') ) Then
   Begin
       Tab.SetError('[Glob_SetPerfil] - Não foi possível abrir a tabela USUARIO') ;
       Exit ;
   End ;
   If ( Not Tab.SetFieldKey('CodUsuario') ) Then
   Begin
       Tab.SetError('[Glob_SetPerfil] - Não foi possível definir a chave primária da tabela USUARIO') ;
       Exit ;
   End ;
   Tab.SetKey([CodUsu]) ;
   If ( Not Tab.Find(True) ) Then
   Begin
       Tab.SetError('[Glob_SetPerfil] - Usuário não encontrado') ;
       Exit ;
   End ;

   CodPer := Tab.GetFieldValue('CodPerfil') ;
   QPerOpe := Tab.ExecSqlSel('Select CodOperacao, Manut From Perfil_Operacao ' +
                               'Where CodPerfil = ''' + CodPer + '''') ;
   If ( QPerOpe.Eof ) Then
   Begin
       Tab.SetError('[Glob_SetPerfil] - Este usuário não apresenta perfil cadastrado') ;
       GPerNumOpe := 1 ;
       SetLength(GPerOperacao,1) ;
       SetLength(GPerManut,1) ;
       GPerOperacao[0] := 'CAD-ESTADO' ;
       GPerManut[0]    :='T' ;
       Exit ;
   End;

   GPerNumOpe := QPerOpe.RecordCount ;
   SetLength(GPerOperacao,GPerNumOpe) ;
   SetLength(GPerManut,GPerNumOpe) ;
   i := 0 ;
   While ( Not QPerOpe.Eof ) Do
   Begin
       GPerOperacao[i] := QPerOpe.FieldByName('CodOperacao').AsString ;
       GPerManut[i]    := QPerOpe.FieldByName('Manut').AsString ;
       i := i + 1 ;
       QPerOpe.Next ;
   End;

   GUsuario := CodUsu ;

   Tab.SetError ;
   Tab.Destroy ;
   Result := True ;

End ;

(* ---------------------------------------------------------------------- *)
(* Glob_GetAccess => Devolve se um usuario tem ou nao acesso a uma        *)
(*                   operacao / manutencao                                *)
(* ---------------------------------------------------------------------- *)
Function Glob_GetAccess ( CodOpe : String ; CodManut : String = '' ) : Boolean ;
Var
   i : Integer ;
Begin
   Result := False ;
   For i:=0 To GPerNumOpe-1 Do
   Begin
       If ( GPerOperacao[i] = CodOpe ) Then
       Begin
           If ( Pos('T',GPerManut[i]) <> 0 ) Then
           Begin
               Result := True ;
               Break ;
           End ;
           If ( (CodManut = '') Or (Pos(CodManut,GPerManut[i]) <> 0) ) Then
           Begin
               Result := True ;
               Break ;
           End ;
       End ;
   End ;
   Result := True ;
End ;

(* ---------------------------------------------------------------------- *)
(* Glob_ReadIni => Le o arquivo MESTRE.INI                                *)
(* ---------------------------------------------------------------------- *)
Procedure Glob_ReadIni() ;
Var
   Ini : TIniFile ;
Begin
   Ini := TIniFile.Create('.\mestre.ini') ;
   GFilial := Ini.ReadString('Empresa','Filial','') ;
   GLogo := Ini.ReadString('Empresa','Logo','') ;
   GMoedaPrincipal := Ini.ReadString('Padroes','MoedaPrincipal','00') ;
   GGerarCheque    := Ini.ReadString('MovCorrente','GerarCheque','N') ;
   GGerarAviso     := Ini.ReadString('MovCorrente','GerarAviso','N') ;
   Ini.Free ;
End ;

(* ---------------------------------------------------------------------- *)
(* Glob_Cript => Recebe um string e o criptografa                         *)
(* ---------------------------------------------------------------------- *)
Function Glob_Cript ( Value : String ) : String ;
Begin
   Result := Value ;
End ;

(* ---------------------------------------------------------------------- *)
(* Glob_Decript => Recebe um string criptografado e o descriptografa      *)
(* ---------------------------------------------------------------------- *)
Function Glob_Decript ( Value : String ) : String ;
Begin
   Result := Value ;
End ;

(* ---------------------------------------------------------------------- *)
(* Glob_GetDigito => Devolve o digito verificador                         *)
(* ---------------------------------------------------------------------- *)
Function Glob_GetDigito ( CodRes : Integer ) : String ;
Var
   Fxa : String ;
   Fclc, Fmul, Fdig : Integer ;
   Fdiv : Integer ;
Begin
   Fxa  := Num_IntToStrZ(CodRes,4) ;
   Fclc := Str_StrToInt( Copy(Fxa,4,1) ) * 4 ;
   Fmul := Str_StrToInt(Copy(Num_IntToStrZ(Fclc,2),1,1)) +
           Str_StrToInt(Copy(Num_IntToStrZ(Fclc,2),2,1)) ;
   Fclc := Str_StrToInt( Copy(Fxa,3,1) ) * 3 ;
   Fmul := Fmul + Str_StrToInt(Copy(Num_IntToStrZ(Fclc,2),1,1)) +
                  Str_StrToInt(Copy(Num_IntToStrZ(Fclc,2),2,1)) ;
   Fclc := Str_StrToInt( Copy(Fxa,2,1) ) * 2 ;
   Fmul := Fmul + Str_StrToInt(Copy(Num_IntToStrZ(Fclc,2),1,1)) +
                  Str_StrToInt(Copy(Num_IntToStrZ(Fclc,2),2,1)) ;
   Fdiv := Trunc(Fmul/10) * 10 ;
   Fdig := Abs(10 - Str_StrToInt(Copy(Num_IntToStrZ((Fmul - Fdiv),2),2,1))) ;
   Result := Copy(Num_IntToStrZ(Fdig,2),2,1) ;
End ;

(* ---------------------------------------------------------------------- *)
(* Glob_GetDigito => Devolve o digito verificador                         *)
(* ---------------------------------------------------------------------- *)
Function Glob_GetDigito ( CodRes : String ) : String ;
Var
   Cod : Integer ;
   Fxa : String ;
   Fclc, Fmul, Fdig : Integer ;
   Fdiv : Integer ;
Begin
   Cod := Str_StrToInt(CodRes) ;
   Fxa  := Num_IntToStrZ(Cod,4) ;
   Fclc := Str_StrToInt( Copy(Fxa,4,1) ) * 4 ;
   Fmul := Str_StrToInt(Copy(Num_IntToStrZ(Fclc,2),1,1)) +
           Str_StrToInt(Copy(Num_IntToStrZ(Fclc,2),2,1)) ;
   Fclc := Str_StrToInt( Copy(Fxa,3,1) ) * 3 ;
   Fmul := Fmul + Str_StrToInt(Copy(Num_IntToStrZ(Fclc,2),1,1)) +
                  Str_StrToInt(Copy(Num_IntToStrZ(Fclc,2),2,1)) ;
   Fclc := Str_StrToInt( Copy(Fxa,2,1) ) * 2 ;
   Fmul := Fmul + Str_StrToInt(Copy(Num_IntToStrZ(Fclc,2),1,1)) +
                  Str_StrToInt(Copy(Num_IntToStrZ(Fclc,2),2,1)) ;
   Fdiv := Trunc(Fmul/10) * 10 ;
   Fdig := Abs(10 - Str_StrToInt(Copy(Num_IntToStrZ((Fmul - Fdiv),2),2,1))) ;
   Result := Copy(Num_IntToStrZ(Fdig,2),2,1) ;
End ;

(* ---------------------------------------------------------------------- *)
(* Glob_GetParFin ==> Lê os parâmetros financeiros                        *)
(* ---------------------------------------------------------------------- *)
Function Glob_GetParFin : Boolean ;
Begin

   Result := False ;
   GParFin := TParFinanc.Create() ;

   If ( Not GParFin.Select() ) Then
       Exit ;

   GCambio := TCambio.Create() ;

   Result := True ;

End ;

Initialization

   GDatabase := 'TallerDB' ;

   GCorDeFundo := $007CA6BD ;

   GFormHeight := 455 ;
   GFormWidth  := 634 ;

   GEmpresa  := 'Taller' ;
   GEmpRazao := 'Tal Factoring Fomento' ;

end.

