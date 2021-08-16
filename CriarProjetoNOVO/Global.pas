{
 ********************** Descri��o das Atividades *******************************
  OS    Programador  Data         Descri��o
  003   Marcos Luiz  06/04/16     Cria��o da Variavel Global Codigo do Regime Tributario da Filial
}

unit Global ;

interface

Uses
   Graphics, Forms, dbTables, IniFiles,  BDE, CCambio, CParFinanc, SysUtils, Classes, FMTBcd,
   Aguardando,
    FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

Var

   G_DBHnd : hDbiDb ;                                // Database Handle

   GCorDeFundo : TColor ;

   GFormHeight, GFormWidth, GFormLeft,             // Posi��o e tamanho
   GFormTop : Integer ;                            // dos forms de cadastro
   GLastForm : TForm ;                             // �ltimo formul�rio aberto
   GPerOperacao: Array Of String ;                 // Vetor com as operacoes permitidas para o usuario
   GPerManut: Array of String ;                    // Vetor com as opcoes de manutencao das operacoes
   GPerNumOpe : Integer ;                          // Operacoes disponiveis para um usuario
   GClienteNovo : String;

   GDatabase : String ;                            // Nome da base de dados

   GEmpresa : String ;                             // Codigo da empresa padr�o
   GEmpRazao: String ;                             // Razao social da empresa padrao
   GFone : String ;                                // Telefone
   GCGC : String ;                                 // CGC
   GLogo : String ;                                // Arquivo com o logotipo da empresa
   GMascContab : String ;                          // M�scara cont�bil
   GUsuario : String ;                             // Usuario que esta utilizando o sistema
   GNome  : String ;
   GSenha : String ;                               // Senha descriptografada
   GPerfil : String ;                             // Perfil  de usuario que esta utilizando o sistema
   GCCusto : String ;                             // C.Custo  de usuario que esta utilizando o sistema
   GOpeId : String ;                             // Ope Id que esta utilizando a planilha

   GUsuFil : String ;                             // Lista de Filiais que o usurio tem permissao

   GPathIMG : String;
   GImagemFTP : Boolean;  // Sistema salva imagem em ftp ou rede.

   (* Vari�veis do arquivo ini *)
   GGerarAviso     : String[1] ;
   GGerarCheque    : String[1] ;
   GFilial         : String[15] ;
   GVendedor       : String[15] ;
   GFilCod         : Integer ;
   GUsuarioAtivo   : String[1];

   (* Cambio *)
   GCambio     : TCambio ;

   (* Par�metros Financeiros *)
   GParFin : TParFinanc ;
   GMoedaUs : String[15] ;
   GMoedaBR : String[15] ;
   GMoedaCB : String[15] ;
   GCaixaUS : String[15] ;
   GVersao  : String[4] ;
   GFatorComInvoice : Double;
   GFatorVenInvoice : Double;
   GFatorVen : Double;
   GFatorCom : Double;

   (* Uso  do Banco Generico *)
   GBanGen     : Boolean ;
   GValBanGen  : Double;
   GBanGenFim  : Boolean;

   {* Parametros Fiscais *}
   GRegimeTrib : Integer; //003
   GFilialUF   : String[2];
    Listtemp2: TStringList;


Function Glob_FillPerfil ( CodUsu : String ) : Boolean ; Export ;
Function Glob_GetAccess ( CodOpe : String ; CodManut : String = '' ) : Boolean ; Export ;
Procedure Glob_ReadIni() ; Export ;
Function Glob_Cript ( Value : String ) : String ; Export ;
Function Glob_Decript ( Value : String ) : String ; Export ;
Function Glob_GetDigito ( CodRes : Integer ) : String ; Overload ; Export ;
Function Glob_GetDigito ( CodRes : String ) : String ; Overload ; Export ;
Function Glob_GetParFin : Boolean ;
procedure AguardandoProcesso(Formulario: TForm; Visivel: Boolean; Titulo : String= '');

function ContaChar(Palavra, BuscaCaracter: string): integer;
procedure ListarArquivos(diretorioInicial, mascara: string; listtotaldir: boolean = false; recursive: boolean = true);

Function Glob_FillPerfilPG ( CodUsu : Integer ) : Boolean ; Export ;

implementation

Uses
   StrFun, SQLTableFun, NumFun, DBConect ;

Function Glob_FillPerfilPG ( CodUsu : Integer ) : Boolean ;
Var
   Tab : TSQLTableClass ;
   CodPer : String ;
   QPerOpe, QUsuario : TFDQuery ;
   i : Integer ;
Begin

   Result := False ;
   QUsuario := TFDQuery.Create(Nil);

   Try
     QUsuario.Connection := DB_Conect.SQLConnection;
     QUsuario.Close;
     QUsuario.SQL.Clear;
     QUsuario.SQL.Add('Select codusuario, nome, senha, codfilial, codperfil From usuario ');
     QUsuario.SQL.Add(' Where codusuario = :codusuario');
     QUsuario.Params.ParamByName('codusuario').AsInteger  := CodUsu;
     QUsuario.Open;

     CodPer  := IntToStr(QUsuario.FieldByName('codperfil').AsInteger);
     GPerfil := IntToStr(QUsuario.FieldByName('codfilial').AsInteger);

   Finally
     FreeAndNil(QUsuario);
   End;


   QPerOpe := TFDQuery.Create(Nil);
   Try
      QPerOpe.Connection := DB_Conect.SQLConnection;
      QPerOpe.Close;
      QPerOpe.SQL.Clear;
      QPerOpe.SQL.Add('Select codoperacao, manut from perfil_operacao ');
      QPerOpe.SQL.Add(' where codperfil = :codperfil');
      QPerOpe.Params.ParamByName('codperfil').AsInteger :=  StrToInt(CodPer);
      QPerOpe.Open;

       If ( QPerOpe.Eof ) Then
       Begin
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
           GPerOperacao[i] := QPerOpe.FieldByName('codoperacao').AsString ;
           GPerManut[i]    := QPerOpe.FieldByName('manut').AsString ;
           i := i + 1 ;
           QPerOpe.Next ;
       End;

       GUsuario := IntToStr(CodUsu);

       Result := True ;

   Finally
      FreeAndNil(QPerOpe);
   End;



End ;



function ContaChar(Palavra, BuscaCaracter: string): integer;
var
  i: Integer;
begin
  result := 0;
  for i := 1 to length(Palavra) do
    if AnsiUpperCase(copy(Palavra, i, 1)) = AnsiUpperCase(BuscaCaracter) then
      inc(result);
end;

procedure ListarArquivos(diretorioInicial, mascara: string; listtotaldir: boolean = false;
  recursive: boolean = true);
var
  i, x: integer;
  listatemp: TStrings;
  ItemMask: ShortString;
  c: Integer;

  procedure ListarDiretorios(Folder: string; lista: Tstrings);
  var
    Rec: TSearchRec;
  begin
    lista.Clear;
    if SysUtils.FindFirst(Folder + '*', faDirectory, Rec) = 0 then
    try
      repeat
        lista.Add(rec.Name);
      until SysUtils.FindNext(Rec) <> 0;
    finally
      if lista.count <> 0 then
      begin
        // deleta o diretorio ..
        lista.Delete(1);
        // deleta o diretorio .
        lista.Delete(0);
      end;
    end;
  end;

  procedure ListarAtahos(Folder, mask: string; Lista: Tstrings);
  var
    Rec: TSearchRec;
  begin
    lista.Clear;
    if SysUtils.FindFirst(Folder + mask, faAnyFile, Rec) = 0 then
    try
      repeat
        lista.Add(rec.Name);
      until SysUtils.FindNext(Rec) <> 0;
    finally
      SysUtils.FindClose(Rec);
    end;
  end;

  procedure AddLIstInOther(ListSource, ListDestino: TStrings);
  var
    f: integer;
  begin
    for f := 0 to ListSource.Count - 1 do
    begin
      ListDestino.Add(ListSource.Strings[f]);
    end;
  end;

begin
  listatemp := TStringList.Create;
  c := ContaChar(Mascara, ';') + 1;
  for x := 1 to c do
  begin
    ItemMask := Str_Pal(mascara, x, ';');
    ListarAtahos(diretorioInicial, ItemMask, listatemp);
    if listtotaldir = true then
    begin
      for i := 0 to listatemp.Count - 1 do
      begin
        listatemp.Strings[i] := diretorioInicial + listatemp.Strings[i];
      end;
    end;
    AddLIstInOther(listatemp, listtemp2);
    if recursive = true then
    begin
      ListarDiretorios(diretorioInicial, listatemp);
      for i := 0 to listatemp.Count - 1 do
      begin
        ListarArquivos(diretorioInicial + listatemp.Strings[i] + '\', ItemMask,
          listtotaldir, recursive);
      end;
    end;
  end;
  listatemp.Free;
end;



procedure AguardandoProcesso(Formulario: TForm; Visivel: Boolean; Titulo : String='');
var
  i: integer;
begin
  if FrmAguardando <> nil then
  begin
    FreeAndNil(FrmAguardando);
  end;

  if Visivel then
  begin
    FrmAguardando := TFrmAguardando.Create(application);
    FrmAguardando.Position := poScreenCenter;
    FrmAguardando.Show;
    Application.ProcessMessages;
//    if Assigned(CDSBase) then
//    begin
//      i := -1;
//      while i <> CDSBase.RecordCount do
//      begin
//        i := CDSBase.RecordCount;
//        CDSBase.GetNextPacket;
        FrmAguardando.LbInfo.Caption := UpperCase(Titulo);
        FrmAguardando.Refresh;
//      end;
//    end;
  end;
end;

(* ---------------------------------------------------------------------- *)
(* Glob_FillPerfil => Enche os vetores com as caracteristicas do perfil   *)
(*                   do usuario                                           *)
(* ---------------------------------------------------------------------- *)
Function Glob_FillPerfil ( CodUsu : String ) : Boolean ;
Var
   Tab : TSQLTableClass ;
   CodPer : String ;
   QPerOpe : TFDQuery ;
   i : Integer ;
Begin

   Result := False ;

   Tab := TSQLTableClass.Create ;
   If ( Not Tab.OpenTable('usuario') ) Then
   Begin
       Tab.SetError('[Glob_SetPerfil] - N�o foi poss�vel abrir a tabela USUARIO') ;
       Exit ;
   End ;
   If ( Not Tab.SetFieldKey('CodUsuario') ) Then
   Begin
       Tab.SetError('[Glob_SetPerfil] - N�o foi poss�vel definir a chave prim�ria da tabela USUARIO') ;
       Exit ;
   End ;
   Tab.SetKey([CodUsu]) ;
   If ( Not Tab.Find(True) ) Then
   Begin
       Tab.SetError('[Glob_SetPerfil] - Usu�rio n�o encontrado') ;
       Exit ;
   End ;

   //CodPer := Tab.GetFieldValue('CodPerfil') ;
   CodPer := Tab.GetFieldValue('Filial') ;
//   if Pos('T10', Tab.GetFieldValue('CodPerfil')) > 0 then
//      GPerfil := Copy(Tab.GetFieldValue('CodPerfil'), 5, 6)
//   else
      GPerfil := Copy(Tab.GetFieldValue('Filial'), 1, 10) ;

   GCCusto := Tab.GetFieldValue('filial') ;
   QPerOpe := Tab.ExecSqlSel('Select CodOperacao, Manut From Perfil_Operacao ' +
//                               'Where CodPerfil = ''' + CodPer + '''') ;
                               'Where CodPerfil = ''' + Tab.GetFieldValue('CodPerfil') + '''') ;
   If ( QPerOpe.Eof ) Then
   Begin
       Tab.SetError('[Glob_SetPerfil] - Este usu�rio n�o apresenta perfil cadastrado') ;
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
   If ( CodOpe = '' ) Then
   Begin
      Result := True ;
      Exit ;
   End ;
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
End ;

(* ---------------------------------------------------------------------- *)
(* Glob_ReadIni => Le o arquivo MESTRE.INI                                *)
(* ---------------------------------------------------------------------- *)
Procedure Glob_ReadIni() ;
Var
   Ini : TIniFile ;
   Tab : TSQLTableClass ;
Begin

   Ini := TIniFile.Create('.\mestre.ini') ;

   GFilial := Ini.ReadString('Empresa','Filial','') ;

   GLogo := Ini.ReadString('Empresa','Logo','') ;
   GGerarCheque    := Ini.ReadString('MovCorrente','GerarCheque','N') ;
   GGerarAviso     := Ini.ReadString('MovCorrente','GerarAviso','N') ;
   Ini.Free ;

   Tab := TSQLTableClass.Create ;
//   GEmpresa  := Tab.SeekGet('Filial','CodFilial',[GFilial],'Empresa') ;
//   GEmpRazao := Tab.SeekGet('Filial','CodFilial',[GFilial],'Razao') ;
//   GFone     := Tab.SeekGet('Filial','CodFilial',[GFilial],'Telefone') ;
//   GCGC      := Tab.SeekGet('Filial','CodFilial',[GFilial],'CGC') ;
   Tab.Destroy ;

End ;

(* ---------------------------------------------------------------------- *)
(* Glob_Cript => Recebe um string e o criptografa                         *)
(* ---------------------------------------------------------------------- *)
Function Glob_Cript ( Value : String ) : String ;
var
   p : Array [0..256] of Char ;
begin
{
   StrPCopy(p,Value) ;
   RC4Crypt(p,Length(Value)) ;
   Result := String(p) ;
}
End ;

(* ---------------------------------------------------------------------- *)
(* Glob_Decript => Recebe um string criptografado e o descriptografa      *)
(* ---------------------------------------------------------------------- *)
Function Glob_Decript ( Value : String ) : String ;
//var
 //  p : Array [0..256] of Char ;
Begin
{
   StrPCopy(p,Value) ;
   RC4Crypt(p,Length(Value)) ;
   Result := String(p) ;
}   
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
(* Glob_GetParFin ==> L� os par�metros financeiros                        *)
(* ---------------------------------------------------------------------- *)

Function Glob_GetParFin : Boolean ;
Begin

   Result := False ;
   GParFin := TParFinanc.Create() ;

   If ( Not GParFin.Select() ) Then
       Exit ;

   GMoedaUS := GParFin.CodMoedaUS ;
   GMoedaBR := GParFin.CodMoedaBR ;
   GMoedaCB := GParFin.CodMoedaCB ;
   GVersao  := GParFin.Versao ;
   GCaixaUS := 'CXUS' ;
   GFatorComInvoice := GParFin.FatorComInvoice;
   GFatorVenInvoice := GParFin.FatorVenInvoice;

   GFatorVen := GParFin.FatorVen;
   GFatorCom := GParFin.FatorCom;

   GCambio := TCambio.Create() ;

   Result := True ;

End ;

Initialization

   GDatabase := 'ESCGESTAO' ;

   GCorDeFundo := $007CA6BD ;

   GFormHeight := 512 ;
   GFormWidth  := 746 ;

end.

