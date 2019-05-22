unit Funcoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, WinSock, IniFiles,
  Registry, ShellAPI, TypInfo, ADODB, DbGrids, DB, DBCtrls,
  DateUtils, menus, math, DBClient,  SqlExpr,  Grids, TLHelp32;

type
  TGeral = class
    CodUsuario: Integer;
    CodCliente : Integer;
    CodEndereco : Integer;
    CodUsuFuncao: SmallInt;
    NomeUsuario: ShortString;
    Apelido: ShortString;
    IPMaquina: ShortString;
    NomeMaquina: ShortString;
    FuncaoUsuario: ShortString;
    Acesso_Cadastros: ShortString;
    Acesso_Lancamentos: ShortString;
    Acesso_Faturamento: ShortString;
    Acesso_Relatorios: ShortString;
    Acesso_Consulta: ShortString;
    Acesso_Web: ShortString;
    Modulo: ShortString;
    CodEmpresa: Integer;
    NomeEmpresa: ShortString;
    EMP_RazaoSocial: ShortString;
    EMP_NomeFantasia: ShortString;
    EMP_CgcCpf: ShortString;
    EMP_RegistroJunta: ShortString;
    EMP_Representante: ShortString;
    EMP_Representante2: ShortString;
    EMP_InscricaoEstadual: ShortString;
    EMP_Endereco: ShortString;
    EMP_Numero: ShortString;
    EMP_Complemento: ShortString;
    EMP_Bairro: ShortString;
    EMP_Cidade: ShortString;
    EMP_Estado: ShortString;
    EMP_Cep: ShortString;
    EMP_TelefoneDDD: ShortString;
    EMP_Telefone: ShortString;
    EMP_TelefoneDDD2: ShortString;
    EMP_Telefone2: ShortString;
    EMP_FaxDDD: ShortString;
    EMP_Fax: ShortString;
    EMP_Email: ShortString;
    EMP_Contato: ShortString;
    EMP_CCMFDC: ShortString;
    CodCentroCusto: Integer;
    CentroCusto: ShortString;
    SenhaAuxiliar: ShortString;
    Senha: ShortString;
    ValorCompra: Double;
    AcessoRelatorio: Byte;
  end;

  TGeraSM = class
    Protocolo: ShortString;
    FAV_Codigo: Integer;
    END_Codigo: SmallInt;
    DataRecebimento: TDateTime;
    HoraRecebimento: ShortString;
    Controlador: Integer;
    Selecionada: ShortString;
    Sel_Fat: ShortString;
    Viagem: ShortString;
    Baixado: ShortString;
    Encerrada: ShortString;
    Comboio: ShortString;
    Itinerario: ShortString;
    SMlida: ShortString;
    WebSM: ShortString;
    Especial: ShortString;
    TEQ_Codigo: Smallint;
    HoraInicial: ShortString;
    HoraFinal: ShortString;
    DataInicial: TDateTime;
    DataFinal: TDateTime;
    CodigoCavalo: Integer;
    CodigoCarreta: Integer;
    Origem: Integer;
    Destino: Integer;
    PRF_Codigo: Integer;
    Solicitante: ShortString;
    DDD_Solicitante: ShortString;
    Tel_Solicitante: ShortString;
    ValorSm: Double;
    FAV_CodigoRelaciona: Integer;
    END_CodigoRelaciona: SmallInt;
    Produtor: ShortString;
    Temperatura: Integer;
    MOP_Codigo: Smallint;
    rsm_statusProfissional: string;
    constructor Create;
  end;

  TTabela_Mestre = record
    CodCliente: ShortString;
    Macro_Tecnologia: ShortString;
    NumMacro: Smallint;
  end;

const
  CHAVE_REGISTRY = 'Software\Buonny\';
  CRIPTOGRAFIAC1 = 52845;
  CRIPTOGRAFIAC2 = 22719;
var
  Flag, FlagAbre: Boolean;
  VersaoSistema: ShortString;

  Intervalo, Arquivos: string;
  Tempo : Integer;
  Diretorio: array[0..5] of string;
  Pastas: array[0..5] of string;
  ArquivosIni: string;
  Listtemp2: TStringList;
  MostraErro: TStringList;
  GeraArquivoLogAcessoBanco: Boolean;

// ******************************************************************************
// *                               Functions                                    *
// ******************************************************************************
function After(const Search, Find: string): string;
function AnsiToAscii(str: string): string;
function AnoBiSexto(Ayear: Integer): Boolean;
function AtualizaArquivos(pAtual: string): Boolean;
function Arredonda(nNum: Double; nCasas: Integer): Double;

function BuscaDireita(Busca, Text: string): integer;
function BuscaTroca(Text, Busca, Troca: string): string;

function cConverte(Valor: Integer): string;
function CaseWhenStr(aCondicao: Boolean; aResultTrue, aResultFalse: string): string;
function ComponentToString(const AValue: TComponent): WideString;
function ConsisteUF(UF: ShortString): Boolean;
function ContaChar(Palavra, BuscaCaracter: string): integer;

function DataExtenso(Data: TDateTime): string;
function DataValida(StrD: string): Boolean;
function DiaExtenso(Dia: Integer): string;
function DiasNoMes(Ano, Mes: Integer): Integer;
function DifDateUtil(dataini, datafin: string): integer;
function Decrypt(const sStr: string; Key: Word): string;

function EliminaBrancos(sTexto: string): string;
function Encrypt(const sStr: string; Key: Word): string;
function ExtractName(const Filename: string): string;

function FileTamanho(const FileName: string): LongInt;
function FirstDayOfMonth(Data: TDateTime; lSabDom: Boolean): TDateTime;
function FileSize(const FileName: string): LongInt;
function FileExec(const aCmdLine: string; aHide, aWait, bWait: Boolean): Boolean;
function FileDate(Arquivo: string): string;
function FormataCPF(const CPF: string): string;
function FormataCNPJ(const CNPJ: string): string;
function FloatToExtenso(Valor: Extended): string;

function GetTotalComponents: Integer;
function GetStateK(Key: integer): boolean;
function GetShortFileName(const Arquivo: string): string;

function IndiceCampoGrid(Campo: string; Grid: TDbGrid): Integer;
function IsInteger(TestaString: string): boolean;
function IsFloat(TestaString: string): boolean;

function LastDayOfMonth(Data: TDateTime; lSabDom: Boolean): TDateTime;
function LeIni(Inifile: string; Secao: string; Chave: string): string;
function LocalizaColuna(aGrid: TDBGrid; aCampo: string): TColumn;
function LocalizaColunaIndice(aGrid: TDBGrid; aCampo: string): Integer;


function MesRefe(S: string): string;
function MesExtenso(xMes: Variant): string;

function NomeUF(UF: string): string;
function NumLinhasArq(Arqtexto: string): integer;

function PadC(S: string; Len: byte): string;
function PADL(Texto: string; Caracter: string; Quantidade: Byte): string;
function PADR(Texto: string; Caracter: string; Quantidade: Byte): string;

function Pal(cOrig: string; nPos: Word; cSep: ShortString): string;
function PasswordInputBox(const ACaption, APrompt: string): string;
function PosR(Substr: string; S: string): Integer;
function Pri_Maiuscula(Nome: string): string;

function RetornaMes(Data: TDateTime): Integer;
function RetornaSemana(Data: TDateTime): Integer;
function RetornaTexto(Texto: string; Caracter: Char): string;
function Replicate(Caracter: string; Quant: Integer): string;
function ReplaceStr(Text, oldstring, newstring: string): string;

function STRFloat(S: string): string;
function SomaCampoQ(tabela: TADOQuery; Field: TField): Integer;
function SomaCampoSQLDataSet(tabela: TSQLDataSet; Field: TField): Integer;
function SomaCampoCDSFloat(tabela: TClientDataSet; Field: TField): Double;
function StrTran(sOrigem: string; sLoc: string; sSub: string): string;
function StrZero(iInt, iTamanho: Integer): string;
function StrToReal(inString: string): Real;
function SeparaMemo(cMemo: string; iTam: SmallInt; Lista: TStringList): SmallInt;
function StringCaracteresIguais(aText: string): Boolean;
function StringToComponent(const AValue: WideString): TComponent;
procedure AguardandoProcesso(Formulario: TForm; Visivel: Boolean; Titulo : String= '');

function TransData(Data: string): string;
function TrataPath(sPath: string): string;
function TestaCpf(num: string): Boolean;
function TestaCNPJ(num: string): boolean;
function TestaParaPar(TestaInteiro: Integer): boolean;
function TiraPontos(const CPF: string): string;
function TbStrIsDate(const S: string): boolean;
function TiraAcento(cString: string): string;
function TrocaChars(Texto: string; Caracter_Anterior, Caracter_Novo: Char): string;

function UltDiaDoMes(Mdt: TDateTime): TDateTime;

function ValidaCamposVazio(Componente: TComponent; CorOriginal: TColor = clWindow; Mensagem: string = ''): Boolean;
function ValidaDateTimePickerMaior(aDTP1, aDTP2: TDateTimePicker; aMensagem: string = ''): Boolean;
function ValidaCEP(CEP: string): boolean;
function ValidaCNPJ(CNPJ: string): boolean;
function ValidaCPF(CPF: string): boolean;
function ValidaEmail(email: string): boolean;
function ValidaTelefone(Telefone: string): boolean;
function ValidaPlaca(Texto: ShortString; var Key: char): Boolean;


function WeekNum(const TDT: TDateTime): Integer;
function WinExecAndWait32(FileName: string; Visibility: Integer): Longword;
function WinExecAndWait(FileName: string; WorkDir: string; Visibility: integer): Cardinal;

function Zero(Texto: string; Quant: Integer): string;

function Justifica(mCad: string; mMAx: integer): string;

// ******************************************************************************
// *                              Procedures                                    *
// ******************************************************************************
procedure AlteraCaptionColunaGrid(aGrid: TDBGrid; aCampo, aCaption: string);
procedure ApagaEAL(Caminho: string; Arquivo: string);
procedure CarregaPosicaoGrid(Grid: TDBGrid);
procedure CriaEAL(Caminho: string);
procedure CriaLinha(Caminho: string; Arquivo: string);

procedure EntreDatas(DataFinal, DataInicial: TDate; var Anos, Meses, Dias: Integer);
procedure GuardaPosicaoGrid(Grid: TDBGrid);
procedure GravaIni(Inifile: string; Secao: string; Chave: string; valor: string);
procedure GravaIniBool(Inifile: string; Secao: string; Chave: string; valor: Boolean);
procedure GravaIni_Integra(Control: Longint; DiretorioEntrada: string; DiretorioSaida: string; Servidor: string; Condicao: Boolean);
procedure LimpaEdit(Form: TForm);
procedure LeIni_Integra(var Control: Longint; var DiretorioEntrada: string; var DiretorioSaida: string; var Servidor: string; var Condicao: Boolean);
procedure LeituraArquivoIni(ExtraFolder: Smallint);
procedure ListarArquivos(diretorioInicial, mascara: string; listtotaldir: boolean = false; recursive: boolean = true);
procedure ListProcess(List: TStrings);
Procedure CarregaPastas(Formulario : TForm);
Procedure CopyFile( Const sourcefilename, targetfilename: String );
Function ProcessArquivo(const Origem, Destino : string; Operacao, Modo:Integer) : Boolean;
function AdicionaHora(TimeAdd: Integer) : String;
Function InverteData(Data : String) : String;



procedure OrdenarGrid(aColumn: TColumn);
procedure OrdenarGridPintando(pColumn: TColumn; aColor1: TColor = clWhite;
  aColor2: TColor = clInfoBk);

procedure SetaVariaveisAmbiente;
procedure SemPlaca(NomedoArquivo: string; Caminho: string; Arquivo: string);

procedure VerificaMenus(Menu: TMenuItem);

procedure ZapFiles(vMasc: string);

procedure ZebrarDBGrid(aGrid: TDBGrid; aState: TGridDrawState; const aRect: TRect;
  aDataCol: Integer; Column: TColumn; aColor1: TColor = clWhite; aColor2: TColor = $00F2F2F2);

var
  Geral: TGeral;
  GeraSM: TGeraSM;
  Tabela_Mestre: TTabela_Mestre;
implementation

uses Aguardando;

//uses guardando;

procedure ZapFiles(vMasc: string);
var Dir: TsearchRec;
  Erro: Integer;
begin
  Erro := FindFirst(vMasc, faArchive, Dir);
  while Erro = 0 do
  begin
    DeleteFile(ExtractFilePAth(vMasc) + Dir.Name);
    Erro := FindNext(Dir);
  end;
  FindClose(Dir);
end;

function ValidaEmail(email: string): boolean;
const
  atom_chars = [#33..#255] - ['(', ')', '<', '>', '@', ',', ';', ':', '\', '/', '"', '.', '[', ']', #127];
  quoted_string_chars = [#0..#255] - ['"', #13, '\'];
  letters = ['A'..'Z', 'a'..'z'];
  letters_digits = ['0'..'9', 'A'..'Z', 'a'..'z'];
type
  states = (State_Begin, State_Atom, State_Qtext, StatePostChar,
    State_Qchar, State_quote, State_Local_Period,
    State_Expecting_Subdomain, State_Subdomain, state_hyphen);

var
  State: States;
  i, n, subdomains: integer;
  c: char;
begin
  State := STATE_BEGIN;
  n := length(email);
  i := 1;
  subdomains := 1;
  while (i <= n) do
  begin
    c := email[i];

    case State of
      STATE_BEGIN:
        if (c in atom_chars) then
          State := STATE_ATOM
        else if (c = '"') then
          State := STATE_QTEXT
        else
          break;

      STATE_ATOM:
        if (c = '@') then
          State := STATEPOSTCHAR
        else if (c = '.') then
          State := STATE_LOCAL_PERIOD
        else if not (c in atom_chars) then
          break;

      STATE_QTEXT:
        if c = '\' then
          State := STATE_QCHAR
        else if c = '"' then
          State := STATE_QUOTE
        else if not (c in quoted_string_chars) then
          break;

      STATE_QCHAR: State := STATE_QTEXT;

      STATE_QUOTE:
        if c = '@' then
          State := STATEPOSTCHAR
        else if c = '.' then
          State := STATE_LOCAL_PERIOD
        else
          break;

      STATE_LOCAL_PERIOD:
        if c in atom_chars then
          State := STATE_ATOM
        else if c = '"' then
          State := STATE_QTEXT
        else
          break;

      STATE_EXPECTING_SUBDOMAIN:
        if c in letters then
          State := STATE_SUBDOMAIN
        else break;

      STATEPOSTCHAR:
        if c in letters_digits then
          State := STATE_SUBDOMAIN
        else
          break;

      STATE_SUBDOMAIN:
        if c = '.' then
        begin
          inc(subdomains);
          State := STATE_EXPECTING_SUBDOMAIN
        end
        else if c = '-' then
          State := STATE_HYPHEN
        else if not (c in letters_digits) then
          break;

      STATE_HYPHEN:
        if c in letters_digits then
          state := STATE_SUBDOMAIN
        else if c <> '-' then
          break;
    end;
    inc(i);
  end;
  if (i <= n) then Result := false
  else Result := (State = STATE_SUBDOMAIN) and (subdomains >= 2);
end;

function MesRefe(S: string): string;
// Mes de Referência
var
  sMesRefe: string;
begin

  if S = '01' then
    sMesRefe := 'JANEIRO';
  if S = '02' then
    sMesRefe := 'FEVEREIO';
  if S = '03' then
    sMesRefe := 'MARÇO';
  if S = '04' then
    sMesRefe := 'ABRIL';
  if S = '05' then
    sMesRefe := 'MAIO';
  if S = '06' then
    sMesRefe := 'JUNHO';
  if S = '07' then
    sMesRefe := 'JULHO';
  if S = '08' then
    sMesRefe := 'AGOSTO';
  if S = '09' then
    sMesRefe := 'SETEMBRO';
  if S = '10' then
    sMesRefe := 'OUTUBRO';
  if S = '11' then
    sMesRefe := 'NOVEMBRO';
  if S = '12' then
    sMesRefe := 'DEZEMBRO';

  MesRefe := sMesRefe;
end;

function STRFloat(S: string): string;
// String em valor
begin
  Result := '';
  if not (trim(S) = '') then
  begin
    if Pos('R', S) > 0 then
      delete(S, pos('R', S), 1);
    if Pos('$', S) > 0 then
      delete(S, pos('$', S), 1);
    if Pos('.', S) > 0 then
      while Pos('.', S) > 0 do
        delete(S, pos('.', S), 1);
    if Pos('-', S) > 0 then
      delete(S, pos('-', S), 1);
    result := S;
  end;
end;


function CaseWhenStr(aCondicao: Boolean; aResultTrue, aResultFalse: string): string;
begin
  if aCondicao then
    result := aResultTrue
  else
    result := aResultFalse;
end;

function TransData(Data: string): string;
// Coversor de Data para SQL
var
  sDia: string;
  sMes: string;
  sAno: string;
  sMonta: string;
begin
  sDia := Copy(Data, 1, 2);
  sMes := Copy(Data, 4, 2);
  sAno := Copy(Data, 7, 4);

  sMonta := sAno + '-' + sMes + '-' + sDia;

  TransData := sMonta;
end;

function PADL(Texto: string; Caracter: string; Quantidade: Byte): string;
// Alinhamento a Direita - Janeiro de 2003
var
  Contador: Byte;
begin
  if Quantidade < Length(Texto) then
    Texto := copy(Texto, Length(Texto) - quantidade + 1, quantidade);
  for Contador := 1 to Quantidade - Length(Texto) do
    Texto := Caracter + Texto;
  Result := Texto;
end;

function PADR(Texto: string; Caracter: string; Quantidade: Byte): string;
// Alinhamento a Esquerda - Janeiro de 2003
var
  Contador: Byte;
begin
  if Quantidade < Length(Texto) then
    Texto := copy(Texto, 1, quantidade);
  for Contador := 1 to Quantidade - Length(Texto) do
    Texto := Texto + Caracter;
  Result := Texto;
end;

function Zero(Texto: string; Quant: Integer): string;
// Zeros a Esquerda de uma STRING - Março de 2002
begin
  // Cola Zeros a Esquerda de um Número quantos forem necessários
  // Texto = 'TEXTO INFORMADO'
  // QUANT = Quantidade de Zeros a Esquerda

  while Length(Texto) < Quant do
    Texto := '0' + Texto;

  Result := Texto;
end;

function GetTotalComponents: Integer;
// Calcular a quantidade de componentes em uma FORM
var
  TotalComps,
    CurForm: Integer;
begin
  TotalComps := 0;
  for CurForm := 0 to (Screen.FormCount - 1) do begin
    TotalComps := TotalComps + Screen.Forms[CurForm].ComponentCount;
  end;
  Result := TotalComps;
end;

function GetStateK(Key: integer): boolean;
// Recuperar o ASCII de uma Tecla - Junho de 2004
begin
  Result := Odd(GetKeyState(Key));
end;

function DataValida(StrD: string): Boolean;
{Testa se uma data é valida}
begin
  Result := true;
  try
    StrToDate(StrD);
  except
    on EConvertError do Result := False;
  end;
end;

function AtualizaArquivos(pAtual: string): Boolean;
{ Verifica Necessidade de Atualização Por Comparação de Arquivos }
var
  SearchRecLocal: TSearchRec;
  SearchRecAtual: TSearchRec;
  sLocal: string;
  sLocalBDE: string;
  sArquivo: string;
begin
// Inicialização dos Parâmetros
  Result := False;
  pAtual := TrataPath(pAtual);
  sLocal := TrataPath(ExtractFilePath(Application.ExeName));
  sLocalBDE := TrataPath('C:\Arquivos de programas\Arquivos comuns\Borland Shared\BDE\');

  sArquivo := 'Monitora.exe';
  if (not Result) and (FileExists(sLocal + sArquivo)) then
  begin
    if (FileExists(pAtual + sArquivo)) then
    begin
    // Atualiza Variaveis de Controle
      FindFirst(sLocal + sArquivo, 0, SearchRecLocal);
      FindFirst(pAtual + sArquivo, 0, SearchRecAtual);
    // Verifica a Necessidade de Atualização
      if UpperCase(SearchRecAtual.Name) = UpperCase(SearchRecLocal.Name) then
        Result := FileDateToDateTime(SearchRecAtual.Time) > FileDateToDateTime(SearchRecLocal.Time);
    end;
  end
  else
    Result := True;
end;

function TrataPath(sPath: string): string;
begin
// Formação da Ultima Barra
  Result := '';
  if sPath[Length(sPath)] <> '\' then
    sPath := sPath + '\';
  Result := sPath;
end;

procedure LimpaEdit(Form: TForm);
var
  i: Integer;
begin
  for i := 0 to Form.ComponentCount - 1 do
    if Form.Components[i] is TCustomEdit then
      (Form.Components[i] as TCustomEdit).Clear;
end;

function FormataCPF(const CPF: string): string;
// Implementada por Marcos Luiz em 08/06/2005 as 9:57
var
  I: Byte;
begin
  Result := '';
  for I := 1 to Length(CPF) do
    if CPF[I] in ['0'..'9'] then
      Result := Result + CPF[I];
  if Length(Result) <> 11 then
    Application.MessageBox('CPF Inválido', 'Atenção', MB_OK + MB_ICONINFORMATION)
  else
    Result :=
      Copy(Result, 1, 3) + '.' +
      Copy(Result, 4, 3) + '.' +
      Copy(Result, 7, 3) + '-' +
      Copy(Result, 10, 2);
end;

function FormataCNPJ(const CNPJ: string): string;
var
  I: integer;
begin
  Result := '';
  for I := 1 to Length(CNPJ) do
    if CNPJ[I] in ['0'..'9'] then
      Result := Result + CNPJ[I];
  if Length(Result) <> 14 then
  //62.474.259/0001-21
  //62474259000121
    Application.MessageBox('CNPJ Inválido', 'Atenção', MB_OK + MB_ICONINFORMATION)
  else
    Result :=
      Copy(Result, 1, 2) + '.' +
      Copy(Result, 3, 3) + '.' +
      Copy(Result, 6, 3) + '/' +
      Copy(Result, 9, 4) + '-' +
      Copy(Result, 13, 2);
end;

procedure GuardaPosicaoGrid(Grid: TDBGrid);
var
  Reg: TRegistry;
  NumCol, i: Integer;
  col, Chave: string;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  chave := CHAVE_REGISTRY + 'Grids\' + Grid.Owner.ClassName + '.' + Grid.Name + '\';
  Reg.OpenKey(chave, True);
  NumCol := Grid.Columns.Count;
  Reg.WriteInteger('NumCol', NumCol);
  for i := 0 to NumCol - 1 do
  begin
    col := 'Col' + IntToStr(i) + '_';
    Reg.WriteString(col + 'FieldName', Grid.Columns[i].FieldName);
    Reg.WriteInteger(col + 'Width', Grid.Columns[i].Width);
  end;
  Reg.CloseKey;
  Reg.Free;
end;

procedure CarregaPosicaoGrid(Grid: TDBGrid);
var
  Reg: TRegistry;
  tamanho, NumCol, i, indatual: Integer;
  campo, chave, col: string;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  chave := CHAVE_REGISTRY + 'Grids\' + Grid.Owner.ClassName + '.' + Grid.Name + '\';
  if Reg.KeyExists(chave) then
  begin
    Reg.OpenKey(chave, True);
    NumCol := Reg.ReadInteger('NumCol');
    for i := 0 to NumCol - 1 do
    begin
      col := 'Col' + IntToStr(i) + '_';
      campo := Reg.ReadString(col + 'FieldName');
      tamanho := Reg.ReadInteger(col + 'Width');
      IndAtual := IndiceCampoGrid(campo, Grid);
      if IndAtual >= 0 then
      begin
        Grid.Columns[IndAtual].Width := tamanho;
        Grid.Columns[IndAtual].Index := i;
      end;
    end;
  end;
  Reg.CloseKey;
  Reg.Free;
end;

function IndiceCampoGrid(Campo: string; Grid: TDbGrid): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Grid.Columns.Count - 1 do
    if (UpperCase(Grid.Columns[i].FieldName) = UpperCase(Campo)) then
      Result := i;
end;

function ConsisteUF(UF: ShortString): Boolean;
const
  EstadosUniao: array[1..27] of string[2] =
  ('MG', 'SP', 'RJ', 'AL', 'AM', 'BA', 'DF', 'MS', 'MT',
    'TO', 'AC', 'MA', 'RO', 'RR', 'PE', 'RS', 'PA', 'PB',
    'CE', 'GO', 'SC', 'ES', 'AP', 'PI', 'RN', 'SE', 'PR');
var
  i: Byte;
begin
  Result := False;
  if UF = '' then Exit;
  UF := UpperCase(UF);
  for i := Low(EstadosUniao) to High(EstadosUniao) do
    if EstadosUniao[i] = UF then begin
      Result := True;
      Break;
    end;
end;

procedure GravaIni(Inifile: string; Secao: string; Chave: string; valor: string);
var
  Ini: TIniFile;
begin
  Ini := TInifile.Create(Inifile + '.ini');
  try
    Ini.WriteString(Secao, chave, valor);
  finally
    Ini.Free;
  end;
end;

procedure GravaIniBool(Inifile: string; Secao: string; Chave: string; valor: Boolean);
var
  Ini: TIniFile;
begin
  Ini := TInifile.Create(Inifile + '.ini');
  try
    Ini.WriteBool(Secao, chave, Valor);
  finally
    Ini.Free;
  end;
end;

function LeIni(Inifile: string; Secao: string; Chave: string): string;
var
  Ini: TIniFile;
begin
  Ini := nil;
  Ini := TInifile.Create(Inifile + '.ini');
  try
    Result := Ini.ReadString(Secao, chave, '');
  finally
    Ini.Free
  end;
end;

function LocalizaColuna(aGrid: TDBGrid; aCampo: string): TColumn;
var
  i: integer;
begin
  result := nil;
  i := LocalizaColunaIndice(aGrid, aCampo);
  if (i >= 0) then
    result := aGrid.Columns[i];
end;

function LocalizaColunaIndice(aGrid: TDBGrid; aCampo: string): Integer;
var
  i: integer;
begin
  result := -1;
  for i := 0 to aGrid.Columns.Count - 1 do
  begin
    if (CompareText(aGrid.Columns[i].FieldName, aCampo) = 0) then
    begin
      result := i;
      break;
    end;
  end;
end;

function NomeUF(UF: string): string;
var sNomeUF: string;
begin
  if UF = 'AC' then
    sNomeUF := 'ACRE'
  else if UF = 'AL' then
    sNomeUF := 'ALAGOAS'
  else if UF = 'AM' then
    sNomeUF := 'AMAZONAS'
  else if UF = 'AP' then
    sNomeUF := 'AMAPÁ'
  else if UF = 'BA' then
    sNomeUF := 'BAHIA'
  else if UF = 'CE' then
    sNomeUF := 'CEARÁ'
  else if UF = 'DF' then
    sNomeUF := 'DISTRITO FEDERAL'
  else if UF = 'ES' then
    sNomeUF := 'ESPIRITO SANTO'
  else if UF = 'GO' then
    sNomeUF := 'GOÍAS'
  else if UF = 'MA' then
    sNomeUF := 'MARANHÃO'
  else if UF = 'MG' then
    sNomeUF := 'MINAS GERAIS'
  else if UF = 'MS' then
    sNomeUF := 'MATO GROSSO DO SUL'
  else if UF = 'MT' then
    sNomeUF := 'MATO GROSSO'
  else if UF = 'PA' then
    sNomeUF := 'PARÁ'
  else if UF = 'PB' then
    sNomeUF := 'PARAÍBA'
  else if UF = 'PE' then
    sNomeUF := 'PERNAMBUCO'
  else if UF = 'PI' then
    sNomeUF := 'PÍAUI'
  else if UF = 'PR' then
    sNomeUF := 'PARANÁ'
  else if UF = 'RJ' then
    sNomeUF := 'RIO DE JANEIRO'
  else if UF = 'RN' then
    sNomeUF := 'RIO GRANDE DO NORTE'
  else if UF = 'RO' then
    sNomeUF := 'RONDÔNIA'
  else if UF = 'RR' then
    sNomeUF := 'RORAÍMA'
  else if UF = 'RS' then
    sNomeUF := 'RIO GRANDE DO SUL'
  else if UF = 'SC' then
    sNomeUF := 'SANTA CATARINA'
  else if UF = 'SE' then
    sNomeUF := 'SERGIPE'
  else if UF = 'SP' then
    sNomeUF := 'SÃO PAULO'
  else if UF = 'TO' then
    sNomeUF := 'TOCANTINS';
  NomeUF := sNomeUF
end;

function TestaCpf(num: string): Boolean;
var
  n1, n2, n3, n4, n5, n6, n7, n8, n9: integer;
  d1, d2: integer;
  digitado, calculado: string;
begin
  num := StrTran(num, '.', '');
  num := StrTran(num, '/', '');
  num := StrTran(num, '-', '');
  num := Trim(num);
  if (Trim(num) <> '') and
    (num <> '11111111111') and
    (num <> '22222222222') and
    (num <> '33333333333') and
    (num <> '44444444444') and
    (num <> '55555555555') and
    (num <> '66666666666') and
    (num <> '77777777777') and
    (num <> '88888888888') and
    (num <> '99999999999') and
    (num <> '00000000000') then
  begin
    n1 := StrToInt(num[1]);
    n2 := StrToInt(num[2]);
    n3 := StrToInt(num[3]);
    n4 := StrToInt(num[4]);
    n5 := StrToInt(num[5]);
    n6 := StrToInt(num[6]);
    n7 := StrToInt(num[7]);
    n8 := StrToInt(num[8]);
    n9 := StrToInt(num[9]);
    d1 := n9 * 2 + n8 * 3 + n7 * 4 + n6 * 5 + n5 * 6 + n4 * 7 + n3 * 8 + n2 * 9 + n1 * 10;
    d1 := 11 - (d1 mod 11);
    if d1 >= 10 then d1 := 0;
    d2 := d1 * 2 + n9 * 3 + n8 * 4 + n7 * 5 + n6 * 6 + n5 * 7 + n4 * 8 + n3 * 9 + n2 * 10 + n1 * 11;
    d2 := 11 - (d2 mod 11);
    if d2 >= 10 then d2 := 0;
    calculado := inttostr(d1) + inttostr(d2);
    digitado := num[10] + num[11];
    if calculado = digitado then
      result := true
    else
      result := false;
  end
  else
    result := false;
end;

function TiraPontos(const CPF: string): string;
var
  I: integer;
begin
  Result := '';
  for I := 1 to Length(CPF) do
    if CPF[I] in ['0'..'9'] then
      Result := Result + CPF[I];
  Result :=
    Copy(Result, 1, 3) +
    Copy(Result, 4, 3) +
    Copy(Result, 7, 3) +
    Copy(Result, 10, 2);
end;

function AnoBiSexto(Ayear: Integer): Boolean;
begin
  Result := (AYear mod 4 = 0) and ((AYear mod 100 <> 0) or
    (AYear mod 400 = 0));
end;

function SomaCampoQ(tabela: TADOQuery; Field: TField): Integer;
begin
  result := 0;
  Screen.Cursor := crHourglass;
  tabela.disableControls;
  tabela.first;
  while not tabela.eof do begin
    result := result + field.asInteger;
    tabela.next;
  end;
  tabela.first;
  tabela.enableControls;
  Screen.Cursor := crDefault;
end;

function SomaCampoSQLDataSet(tabela: TSQLDataSet; Field: TField): Integer;
begin
  result := 0;
  Screen.Cursor := crHourglass;
  tabela.disableControls;
  tabela.first;
  while not tabela.eof do begin
    result := result + field.asInteger;
    tabela.next;
  end;
  tabela.first;
  tabela.enableControls;
  Screen.Cursor := crDefault;
end;

function SomaCampoCDSFloat(tabela: TClientDataSet; Field: TField): Double;
begin
  result := 0;
  Screen.Cursor := crHourglass;
  tabela.disableControls;
  tabela.first;
  while not tabela.eof do begin
    result := result + field.asFloat;
    tabela.next;
  end;
  tabela.first;
  tabela.enableControls;
  Screen.Cursor := crDefault;
end;

function StrTran(sOrigem: string; sLoc: string; sSub: string): string;
var
  Aux: string;
  Calc: integer;
  Posicao: integer;
begin
//Localiza um conjunto de strings e subtitui por outro
  Aux := sOrigem;
  Calc := 0;
  Posicao := Pos(sLoc, Aux);
  while Posicao > 0 do
  begin

    Delete(Aux, Posicao, Length(sLoc));
    Posicao := Posicao + Calc;
    sOrigem := Copy(sOrigem, 1, Posicao - 1) + sSub +
      Copy(sOrigem, Posicao + Length(sLoc), Length(sOrigem));
    Calc := Calc + Length(sSub);
    Posicao := Pos(sLoc, Aux);
  end;
  Result := sOrigem;
end;

function DiasNoMes(Ano, Mes: Integer): Integer;
var
  DiasInMes: array[1..12] of Integer;
begin
  DiasInMes[1] := 31;
  DiasInMes[2] := 28;
  DiasInMes[3] := 31;
  DiasInMes[4] := 30;
  DiasInMes[5] := 31;
  DiasInMes[6] := 30;
  DiasInMes[7] := 31;
  DiasInMes[8] := 31;
  DiasInMes[9] := 30;
  DiasInMes[10] := 31;
  DiasInMes[11] := 30;
  DiasInMes[12] := 31;
  if Mes = 2 then
  begin
    if Ano mod 4 = 0 then
    begin
      Inc(DiasInMes[Mes]);
    end;
  end;
  Result := DiasInMes[Mes];
end;

function TestaCNPJ(num: string): boolean;
var
  n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12: integer;
  d1, d2: integer;
  digitado, calculado: string;
begin
  try
    num := StrTran(num, '.', '');
    num := StrTran(num, '/', '');
    num := StrTran(num, '-', '');
    num := Trim(num);
    n1 := StrToInt(num[1]);
    n2 := StrToInt(num[2]);
    n3 := StrToInt(num[3]);
    n4 := StrToInt(num[4]);
    n5 := StrToInt(num[5]);
    n6 := StrToInt(num[6]);
    n7 := StrToInt(num[7]);
    n8 := StrToInt(num[8]);
    n9 := StrToInt(num[9]);
    n10 := StrToInt(num[10]);
    n11 := StrToInt(num[11]);
    n12 := StrToInt(num[12]);
    d1 := n12 * 2 + n11 * 3 + n10 * 4 + n9 * 5 + n8 * 6 + n7 * 7 + n6 * 8 + n5 * 9 + n4 * 2 + n3 * 3 + n2 * 4 + n1 * 5;
    d1 := 11 - (d1 mod 11);
    if d1 >= 10 then d1 := 0;
    d2 := d1 * 2 + n12 * 3 + n11 * 4 + n10 * 5 + n9 * 6 + n8 * 7 + n7 * 8 + n6 * 9 + n5 * 2 + n4 * 3 + n3 * 4 + n2 * 5 + n1 * 6;
    d2 := 11 - (d2 mod 11);
    if d2 >= 10 then d2 := 0;
    calculado := inttostr(d1) + inttostr(d2);
    digitado := num[13] + num[14];
    if calculado = digitado then
      Result := true
    else
      Result := false;
  except
    Result := false;
  end;
end;

function Replicate(Caracter: string; Quant: Integer): string;
{Repete o mesmo caractere várias vezes}
var I: Integer;
begin
  Result := '';
  for I := 1 to Quant do
    Result := Result + Caracter;
end;

function Pal(cOrig: string; nPos: Word; cSep: ShortString): string;
var
  nCount: Word;
  nAtPos: Word;
begin
  nCount := 1;
  while TRUE do
  begin
    if (nPos = nCount) then
      Result := cOrig
    else
      Result := '';
    nAtPos := Pos(cSep, cOrig);
    if not (nAtPos > 0) then EXIT;
    Result := Copy(cOrig, 1, nAtPos - 1);
    if nCount = nPos then EXIT;
    cOrig := Copy(cOrig, nAtPos + 1, Length(cOrig));
    Inc(nCount);
  end;
end;

function after(const Search, Find: string): string;
{Retorna uma cadeia de caracteres após a parte da string selecionada}
var
  index: byte;
begin
  index := Pos(Find, Search);
  if index = 0 then
  begin
    Result := '';
  end
  else
  begin
    Result := Copy(Search, index + Length(Find), 255);
  end;
end;

function RetornaTexto(Texto: string; Caracter: Char): string;
var
  I, Posicao1, Posicao2: Integer;
  TextoInvertido: string;
begin
  Result := '';
  for I := Length(Texto) downto 1 do
  begin
    TextoInvertido := TextoInvertido + Texto[I]
  end;
  Posicao1 := Pos(Caracter, Texto) + 1;
  Posicao2 := Pos(Caracter, TextoInvertido) - 1;
  Result := Copy(Texto, Posicao1, Length(Texto) - (Posicao1 + Posicao2));
end;


function BuscaDireita(Busca, Text: string): integer;
{Pesquisa um caractere à direita da string, retornando sua posição}
var
  n, retorno: integer;
begin
  retorno := 0;
  for n := length(Text) downto 1 do
  begin
    if Copy(Text, n, 1) = Busca then
    begin
      retorno := n;
      break;
    end;
  end;
  Result := retorno;
end;

function TestaParaPar(TestaInteiro: Integer): boolean;
begin
  if (TestaInteiro div 2) = (TestaInteiro / 2) then
    result := True
  else
    result := False;
end;

function ValidaCamposVazio(Componente: TComponent; CorOriginal: TColor = clWindow;
  Mensagem: string = ''): Boolean;

  function EstaBranco(Texto: string): Boolean;
  begin
    if Trim(StrTran(
      StrTran(
      StrTran(
      StrTran(
      StrTran(
      StrTran(
      Trim(Texto), '-', '')
      , '.', '')
      , '/', '')
      , ',', '')
      , '''', '')
      , '"', '')) = '' then
      result := true
    else result := false;
  end;

begin
  Result := true;
  if (Componente is TDBEdit) then
  begin
    if EstaBranco((Componente as TDBEdit).Text) then
    begin
      (Componente as TDBEdit).Color := $008080FF;
      (Componente as TDBEdit).SelectAll;
      (Componente as TDBEdit).SetFocus;
      Result := False;
    end else (Componente as TDBEdit).Color := CorOriginal;
  end
  {else if (Componente is TCurrencyEdit) then
  begin
    if EstaBranco((Componente as TCurrencyEdit).Text) or
      ((Componente as TCurrencyEdit).Value = 0) then
    begin
      (Componente as TCurrencyEdit).Color := $008080FF;
      (Componente as TCurrencyEdit).SetFocus;
      Result := False;
    end else (Componente as TCurrencyEdit).Color := CorOriginal;
  end
  else if (Componente is TEditBusca) then
  begin
    if (Componente as TEditBusca).IsEmpyt then
    begin
      (Componente as TEditBusca).Color := $008080FF;
      (Componente as TEditBusca).SetFocus;
      Result := False;
    end else (Componente as TEditBusca).Color := CorOriginal;
  end}
  else if (Componente is TEdit) then
  begin
    if EstaBranco((Componente as TEdit).Text) then
    begin
      (Componente as TEdit).Color := $008080FF;
      (Componente as TEdit).SetFocus;
      Result := False;
    end else (Componente as TEdit).Color := CorOriginal;
  end
  else if (Componente is TDBComboBox) then
  begin
    if EstaBranco((Componente as TDBComboBox).Text) then
    begin
      (Componente as TDBComboBox).Color := $008080FF;
      (Componente as TDBComboBox).SetFocus;
      Result := False;
    end else (Componente as TDBComboBox).Color := CorOriginal;
  end
  {else if (Componente is TDBDateEdit) then
  begin
    if EstaBranco((Componente as TDBDateEdit).Text) then
    begin
      (Componente as TDBDateEdit).Color := $008080FF;
      (Componente as TDBDateEdit).SetFocus;
      Result := False;
    end else (Componente as TDBDateEdit).Color := CorOriginal;
  end}
  else if (Componente is TListBox) then
  begin
    if (Componente as TListBox).Count = 0 then
    begin
      (Componente as TListBox).Color := $008080FF;
      (Componente as TListBox).SetFocus;
      Result := False;
    end else (Componente as TListBox).Color := CorOriginal;
  end
  else if (Componente is TComboBox) then
  begin
    if EstaBranco((Componente as TComboBox).Text) then
    begin
      (Componente as TComboBox).Color := $008080FF;
      (Componente as TComboBox).SetFocus;
      Result := False;
    end else (Componente as TComboBox).Color := CorOriginal;
  end
  else if (Componente is TDBLookupComboBox) then
  begin
    if EstaBranco((Componente as TDBLookupComboBox).Text) then
    begin
      (Componente as TDBLookupComboBox).Color := $008080FF;
      (Componente as TDBLookupComboBox).SetFocus;

      Result := False;
    end else (Componente as TDBLookupComboBox).Color := CorOriginal;
  end
  else if (Componente is TDBMemo) then
  begin
    if EstaBranco((Componente as TDBMemo).Text) then
    begin
      (Componente as TDBMemo).Color := $008080FF;
      (Componente as TDBMemo).SetFocus;
      Result := False;
    end else (Componente as TDBMemo).Color := CorOriginal;
  end
  else if (Componente is TMemo) then {INSERIDO JOEL 01/08/2007}
  begin
    if EstaBranco((Componente as TMemo).Text) then
    begin
      (Componente as TMemo).Color := $008080FF;
      (Componente as TMemo).SetFocus;
      Result := False;
    end else (Componente as TMemo).Color := CorOriginal;
  end;

  if not result then
    if Mensagem = EmptyStr then
      Application.MessageBox('Preencha os campos obrigatorios (em vermelho)!', 'Atenção', MB_OK + MB_ICONINFORMATION)
    else Application.MessageBox(Pchar(Mensagem), 'Atenção', MB_OK + MB_ICONINFORMATION)

end;

function ValidaDateTimePickerMaior(aDTP1, aDTP2: TDateTimePicker; aMensagem: string = ''): Boolean;
begin
  if (aDTP1.DateTime > aDTP2.DateTime) then
  begin
    aDTP1.Color := $008080FF;
    aDTP1.SetFocus;
    result := False;
  end;

  if not result then
    if aMensagem = '' then
      Application.MessageBox('O campo inicial deve ser menor que o final.', ' Atenção', MB_OK + MB_ICONINFORMATION)
    else
      Application.MessageBox(Pchar(aMensagem), 'Atenção', MB_OK + MB_ICONINFORMATION)

end;

function MesExtenso(xMes: Variant): string;
var
  Dia, Mes, Ano: Word;
begin
  Mes := 0;
  case VarType(xMes) of
    VarDate: DecodeDate(xMes, Ano, Mes, Dia);
    VarString:
      try
        Mes := StrToInt(xMes);
      except
      end;
  else
    try
      Mes := Round(xMes);
    except
    end;
  end;
  case Mes of
    1: Result := 'Janeiro';
    2: Result := 'Fevereiro';
    3: Result := 'Março';
    4: Result := 'Abril';
    5: Result := 'Maio';
    6: Result := 'Junho';
    7: Result := 'Julho';
    8: Result := 'Agosto';
    9: Result := 'Setembro';
    10: Result := 'Outubro';
    11: Result := 'Novembro';
    12: Result := 'Dezembro';
  else
    Result := '';
  end;
end;

procedure EntreDatas(DataFinal, DataInicial: TDate; var Anos, Meses, Dias: Integer);
// Retorna a diferença em Dias,Meses e Anos entre 2 datas

  function Calcula(Periodo: Integer): Integer;
  var
    intCont: Integer;
  begin
    intCont := 0;
    repeat
      Inc(intCont);
      DataFinal := IncMonth(DataFinal, Periodo * -1);
    until DataFinal < DataInicial;
    DataFinal := IncMonth(DataFinal, Periodo);
    Inc(intCont, -1);
    Result := intCont;
  end;

begin
  if DataFinal <= DataInicial then
  begin
    Anos := 0;
    Meses := 0;
    Dias := 0;
    exit;
  end;
  Anos := Calcula(12);
  Meses := Calcula(1);
  Dias := Round(DataFinal - DataInicial);
end;

function DifDateUtil(dataini, datafin: string): integer;
var
  a, b, c: tdatetime;
  ct, s: integer;
begin
  if StrToDate(DataFin) < StrtoDate(DataIni) then
  begin
    Result := 0;
    exit;
  end;
  ct := 0;
  s := 1;
  a := strtodate(dataFin);
  b := strtodate(dataIni);
  if a > b then
  begin
    c := a;
    a := b;
    b := c;
    s := 1;
  end;
  a := a + 1;

  while (a <= b) do
  begin
    if dayofweek(a) in [1..7] then
    begin
      inc(ct);
    end;
    a := a + 1;
  end;
  ct := ct + round((5 * int((b - a) / 7)));
  a := a + (7 * int((b - a) / 7));
  while a <= b do
  begin
    if dayofweek(a) in [1..7] then
    begin
      inc(ct);
    end;
    a := a + 1;
  end;
  if ct < 0 then
  begin
    ct := 0;
  end;
  result := s * ct;
end;

function WeekNum(const TDT: TDateTime): Integer;
var
  Y, M, D: Word;
  dtTmp: TDateTime;
begin
  DecodeDate(TDT, Y, M, D);
  dtTmp := EnCodeDate(Y, 1, 1);
  Result := (Trunc(TDT - dtTmp) + (DayOfWeek(dtTmp) - 1)) div 7;
  if Result = 0 then
    Result := 51
  else
    Result := Result - 1;
end;

function RetornaMes(Data: TDateTime): Integer;
var
  Ano, Mes, Dia: Word;
begin
  Data := Now;
  DecodeDate(Data, Ano, Mes, Dia);
  Result := Mes;
end;

function RetornaSemana(Data: TDateTime): Integer;
var
  Ano, Mes, Dia: Word;
  Sair: Boolean;
begin
  Sair := False;
  DecodeDate(Data, Ano, Mes, Dia);
  if Dia < 7 then begin
    Result := 0;
    Exit;
  end;
  while not Sair do begin
    if Dia mod 7 = 0 then begin

      Sair := True;
    end
    else begin
      dia := Dia - 1;
      Sair := False;
    end;
  end;
  result := Dia div 7;
end;


function NumLinhasArq(Arqtexto: string): integer;
// Retorna o número de linhas que um arquivo possui
var
  f: Textfile;
  cont: integer;
begin
  cont := 0;
  AssignFile(f, Arqtexto);
  Reset(f);
  while not eof(f) do
  begin
    ReadLn(f);
    Cont := Cont + 1;
  end;
  Closefile(f);
  result := cont;
end;

function ExtractName(const Filename: string): string;
{Retorna o nome do Arquivo sem extensão}
var
  aExt: string;
  aPos: Integer;
begin
  aExt := ExtractFileExt(Filename);
  Result := ExtractFileName(Filename);
  if aExt <> '' then
  begin
    aPos := Pos(aExt, Result);
    if aPos > 0 then
      Delete(Result, aPos, Length(aExt));
  end;
end;

function StrZero(iInt, iTamanho: Integer): string;
var X: string;
  I: Integer;
begin
  for I := 1 to iTamanho do X := X + '0';
  X := X + IntToStr(iInt);
  Result := Copy(X, Length(X) - iTamanho + 1, iTamanho)
end;

function StrToReal(inString: string): Real;
{converte um número em Float}
var
  i: Real;
  k: Integer;
begin
  Val(inString, i, k);
  StrToReal := i;
end;

function fileSize(const FileName: string): LongInt;
{Retorna o tamanho de um arquivo}
var
  SearchRec: TSearchRec;
begin { !Win32! -> GetFileSize }
  if FindFirst(FileName, faAnyFile, SearchRec) = 0
    then Result := SearchRec.Size
  else Result := 0;
  FindClose(SearchRec);
end;

function BuscaTroca(Text, Busca, Troca: string): string;
{ Substitui um caractere dentro da string}
var n: integer;
begin
  for n := 1 to length(Text) do
  begin
    if Copy(Text, n, 1) = Busca then
    begin
      Delete(Text, n, 1);
      Insert(Troca, Text, n);
    end;
  end;
  Result := Text;
end;


procedure GravaIni_Integra(Control: Longint; DiretorioEntrada: string;
  DiretorioSaida: string; Servidor: string; Condicao: Boolean);
var
  ArqIni: TIniFile;
begin
  ArqIni := TIniFile.Create('c:\WINNT\SYSTEM\Teste.Ini');
  try
    ArqIni.WriteInteger('Dados', 'Control', Control);
    ArqIni.WriteString('Dados', 'DiretorioEntrada', DiretorioEntrada);
    ArqIni.WriteString('Dados', 'DiretorioSaida', DiretorioSaida);
    ArqIni.WriteString('Dados', 'Servidor', Servidor);
    ArqIni.WriteBool('Dados', 'Condição', Condicao);
  finally
    ArqIni.Free;
  end;
end;



procedure LeIni_Integra(var Control: Longint; var DiretorioEntrada: string;
  var DiretorioSaida: string; var Servidor: string; var Condicao: Boolean);
var
  ArqIni: tIniFile;
begin
  ArqIni := TIniFile.Create('c:\WINNT\SYSTEM\Teste.Ini');
  try
    Control := ArqIni.ReadInteger('Dados', 'Control', Control);
    DiretorioEntrada := ArqIni.ReadString('Dados', 'DiretorioEntrada', DiretorioEntrada);
    DiretorioSaida := ArqIni.ReadString('Dados', 'DiretorioSaida', DiretorioSaida);
    Servidor := ArqIni.ReadString('Dados', 'Servidor', Servidor);
    Condicao := ArqIni.ReadBool('Dados', 'Condição', Condicao);
  finally
    ArqIni.Free;
  end;
end;


function GetShortFileName(const Arquivo: string): string;
var
  aTmp: array[0..255] of char;
begin
  if GetShortPathName(PChar(Arquivo), aTmp, sizeof(aTmp) - 1) = 0 then
    Result := Arquivo
  else
    Result := StrPas(aTmp);
end;


function FileExec(const aCmdLine: string; aHide, aWait, bWait: Boolean): Boolean;
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
  with StartupInfo do
  begin
    cb := SizeOf(TStartupInfo);
    dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
    if aHide then
    begin
      wShowWindow := SW_SHOWMINIMIZED;
    end
    else
    begin
      wShowWindow := SW_SHOWMINIMIZED;
    end;
  end;
  Result := CreateProcess(nil, PChar(aCmdLine), nil, nil, False, NORMAL_PRIORITY_CLASS,
    nil, nil, StartupInfo, ProcessInfo);
  if aWait and Result then
  begin
    WaitForInputIdle(ProcessInfo.hProcess, INFINITE);
    if bWait then
    begin
      WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    end;
  end;
end;

function tbStrIsDate(const S: string): boolean;
begin
  try
    StrToDate(S);
    Result := true;
  except
    Result := false;
  end;
end;

function WinExecAndWait32(FileName: string; Visibility: Integer): Longword;
var
  zAppName: array[0..512] of Char;
  zCurDir: array[0..255] of Char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  if not CreateProcess(nil,
    zAppName, // pointer to command line string
    nil, // pointer to process security attributes
    nil, // pointer to thread security attributes
    False, // handle inheritance flag
    CREATE_NEW_CONSOLE or // creation flags
    NORMAL_PRIORITY_CLASS,
    nil, //pointer to new environment block
    nil, // pointer to current directory name
    StartupInfo, // pointer to STARTUPINFO
    ProcessInfo) // pointer to PROCESS_INF
    then Result := WAIT_FAILED
  else
  begin
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end;
end;

function WinExecAndWait(FileName: string; WorkDir: string; Visibility: integer): Cardinal;
var
  zAppName: array[0..512] of char;
  zCurDir: array[0..255] of char;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  StrPCopy(zAppName, FileName);
 {GetDir(0,WorkDir);}
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, Sizeof(StartupInfo), #0);
  StartupInfo.cb := Sizeof(StartupInfo);

  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  if not CreateProcess(nil,
    zAppName, { pointer to command
line string }
    nil, { pointer to process
security attributes }
    nil, { pointer to thread
security attributes }
    false, { handle inheritance
flag }
    CREATE_NEW_CONSOLE or { creation flags }
    NORMAL_PRIORITY_CLASS,
    nil, { pointer to new
environment block }
    zCurDir, { pointer to current
directory name }
    StartupInfo, { pointer to
STARTUPINFO }
    ProcessInfo) then Result := 0 { pointer to
PROCESS_INF }

  else
  begin
    WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
  end;
end;

function IsInteger(TestaString: string): boolean;
begin
  try
    StrToInt(TestaString);
  except on EConvertError do
      result := False;
  end;
  result := True;
end;

function IsFloat(TestaString: string): boolean;
begin
  try
    StrToFloat(TestaString);
  except on EConvertError do
      result := False;
  else
  end;
  result := True;
end;

function ReplaceStr(Text, oldstring, newstring: string): string;
var
  atual, strtofind, originalstr: pchar;
  NewText: string;
  lenoldstring, lennewstring, m, index: integer;
begin
  NewText := Text;
  originalstr := pchar(Text);
  strtofind := pchar(oldstring);
  lenoldstring := length(oldstring);
  lennewstring := length(newstring);
  Atual := StrPos(OriginalStr, StrtoFind);
  index := 0;
  while Atual <> nil do
  begin //Atual<>nil
    m := Atual - OriginalStr - index + 1;
    Delete(NewText, m, lenoldstring);
    Insert(newstring, NewText, m);
    inc(index, lenoldstring - lennewstring);
    Atual := StrPos(Atual + lenoldstring, StrtoFind);
  end; //Atual<>nil
  Result := NewText;
end;

function FileTamanho(const FileName: string): LongInt;
{Retorna o tamanho de um arquivo}
var
  SearchRec: TSearchRec;
begin { !Win32! -> GetFileSize }
  if FindFirst(FileName, faAnyFile, SearchRec) = 0
    then Result := SearchRec.Size
  else Result := 0;
  FindClose(SearchRec);
end;

function LastDayOfMonth(Data: TDateTime; lSabDom: Boolean): TDateTime;
var
  Ano, Mes, Dia: word;
  AuxData: TDateTime;
  DiaDaSemana: Integer;
begin
  AuxData := FirstDayOfMonth(MonthOf(Data) + 1, False) - 1;
  if lSabDom then
  begin
    DecodeDate(Auxdata, Ano, Mes, Dia);
    DiaDaSemana := DayOfWeek(AuxData);
    if DiaDaSemana = 1 then
      Dia := Dia - 2
    else
      if DiaDaSemana = 7 then
        Dec(Dia);
    AuxData := EnCodeDate(Ano, Mes, Dia);
  end;
  LastDayOfMonth := AuxData;
end;

function FirstDayOfMonth(Data: TDateTime; lSabDom: Boolean): TDateTime;
var
  Ano, Mes, Dia: word;
  DiaDaSemana: Integer;
begin
  DecodeDate(Data, Ano, Mes, Dia);
  Dia := 1;
  if lSabDom then
  begin
    DiaDaSemana := DayOfWeek(Data);
    if DiaDaSemana = 1 then
      Dia := 2
    else
      if DiaDaSemana = 7 then
        Dia := 3;
  end;
  FirstDayOfMonth := EncodeDate(Ano, Mes, Dia);
end;

function EliminaBrancos(sTexto: string): string;
// Elimina todos os espaços em branco da string
//(inclusive os espaços entre as palavras)
var
  nPos: Integer;
begin
  nPos := 1;
  while Pos(#9, sTexto) > 0 do
  begin
    nPos := Pos(#9, sTexto);
      //sTexto[nPos] := '';
    Delete(sTexto, nPos, 1);
  end;

  Result := sTexto;
end;


procedure CriaEAL(Caminho: string);
var
  Arq: TextFile;
begin
  AssignFile(arq, Caminho + 'EAL.LOC');
  if FileExists(Caminho + 'EAL.LOC') then begin
    Append(arq)
  end
  else
  begin
    Rewrite(arq);
  end;
  Write(arq, '1');
  WriteLn(arq);
  Flush(arq);
  CloseFile(arq);
end;

procedure CriaLinha(Caminho: string; Arquivo: string);
var
  Arq: TextFile;
begin
  AssignFile(arq, Caminho + Arquivo);
  if FileExists(Caminho + Arquivo) then begin
    Append(arq)
  end
  else begin
    Rewrite(arq);
  end;
  Write(arq, ' ');
  WriteLn(arq);
  Flush(arq);
  CloseFile(arq);
end;

procedure ApagaEAL(Caminho: string; Arquivo: string);
begin
  if FileExists(Caminho + Arquivo) then
    DeleteFile(Caminho + Arquivo); // apaga arquivo bat
end;

procedure AlteraCaptionColunaGrid(aGrid: TDBGrid; aCampo, aCaption: string);
var
  col: TColumn;
begin
  col := LocalizaColuna(aGrid, aCampo);
  if (col <> nil) then
    col.Title.Caption := aCaption;
end;

function ContaChar(Palavra, BuscaCaracter: string): integer;
var
  i: Integer;
begin
  result := 0;
  for i := 1 to length(Palavra) do
    if AnsiUpperCase(copy(Palavra, i, 1)) = AnsiUpperCase(BuscaCaracter) then
      inc(result);
end;

procedure SemPlaca(NomedoArquivo: string; Caminho: string; Arquivo: string);
var
  Arq: TextFile;
begin
  AssignFile(arq, Caminho + NomedoArquivo + '.txt');
  if FileExists(Caminho + NomeDoArquivo + '.txt') then begin
    Append(arq)
  end
  else
  begin
    Rewrite(arq);
  end;
  Write(arq, Arquivo);
  WriteLn(arq);
  Flush(arq);
  CloseFile(arq);
end;


function DiaExtenso(Dia: Integer): string;
begin
{ Dias da Semana }
  case Dia of
    1: Result := 'Domingo';
    2: Result := 'Segunda';
    3: Result := 'Terça';
    4: Result := 'Quarta';
    5: Result := 'Quinta';
    6: Result := 'Sexta';
    7: Result := 'Sábado';
  end;
end;

procedure VerificaMenus(Menu: TMenuItem);
var
  i: Integer;
  bEnabled: Boolean;
  bVisible: Boolean;
begin
  bEnabled := False;
  bVisible := False;
  for i := 0 to Menu.Count - 1 do
  begin
    VerificaMenus(Menu.Items[i]);
    if Menu.Items[i].Enabled then
      bEnabled := True;
    if Menu.Items[i].Visible then
      bVisible := True;
    if Menu.Items[i].IsLine then
      Menu.Items[i].Visible := True;
  end;
  if Menu.Count > 0 then
  begin
    Menu.Enabled := bEnabled;
    Menu.Visible := bVisible;
  end;
  Menu.RethinkLines;
end;

procedure LeituraArquivoIni(ExtraFolder: Smallint);
var
  ArqIni: TIniFile;
begin
  ArqIni := TIniFile.Create(GetCurrentDir + '\' + 'Integracao.ini');
  if ExtraFolder = 1 then
  begin
    ArquivosIni := ArqIni.ReadString('Configuracao', 'Arquivos', '');
    Pastas[0] := ArqIni.ReadString('Pastas', 'SRVAUTO00', '') + '\';
    Pastas[1] := ArqIni.ReadString('Pastas', 'SRVATRAC01', '') + '\';
    Pastas[2] := ArqIni.ReadString('Pastas', 'SRVATRAC02', '') + '\';
    Pastas[3] := ArqIni.ReadString('Pastas', 'SRVATRAC03', '') + '\';
    Pastas[4] := ArqIni.ReadString('Pastas', 'SRVATRAC04', '') + '\';
    Pastas[5] := ArqIni.ReadString('Pastas', 'SRVATRAC05', '') + '\';
  end
  else if ExtraFolder = 2 then
  begin
    ArquivosIni := ArqIni.ReadString('Configuracao', 'Arquivos', '');
    Pastas[0] := ArqIni.ReadString('Pastas', 'SRVAUTO00', '') + '\Macro\';
    Pastas[1] := ArqIni.ReadString('Pastas', 'SRVATRAC01', '') + '\Macro\';
    Pastas[2] := ArqIni.ReadString('Pastas', 'SRVATRAC02', '') + '\Macro\';
    Pastas[3] := ArqIni.ReadString('Pastas', 'SRVATRAC03', '') + '\Macro\';
    Pastas[4] := ArqIni.ReadString('Pastas', 'SRVATRAC04', '') + '\Macro\';
    Pastas[5] := ArqIni.ReadString('Pastas', 'SRVATRAC05', '') + '\Macro\';
  end;
  Arqini.free;
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
    ItemMask := Pal(mascara, x, ';');
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

procedure OrdenarGrid(aColumn: TColumn);
begin
  if aColumn.Grid.DataSource.DataSet <> nil then
  begin
    TClientDataSet(aColumn.Grid.DataSource.DataSet).IndexDefs.Clear;
    if TClientDataSet(aColumn.Grid.DataSource.DataSet).IndexName = 'ASC_' + aColumn.FieldName then
    begin
      TClientDataSet(aColumn.Grid.DataSource.DataSet).IndexDefs.Add('DESC_' + aColumn.FieldName, aColumn.FieldName, [ixDescending]);
      TClientDataSet(aColumn.Grid.DataSource.DataSet).IndexName := 'DESC_' + aColumn.FieldName;
    end
    else
    begin
      TClientDataSet(aColumn.Grid.DataSource.DataSet).IndexDefs.Add('ASC_' + aColumn.FieldName, aColumn.FieldName, []);
      TClientDataSet(aColumn.Grid.DataSource.DataSet).IndexName := 'ASC_' + aColumn.FieldName;
    end;
  end;
end;

function TrocaChars(Texto: string; Caracter_Anterior, Caracter_Novo: Char): string;
// Esta função substitui um caracter específico de uma string,
// por um outro caracter desejado.
begin

  while Pos(Caracter_Anterior, Texto) > 0 do
    Texto[Pos(Caracter_Anterior, Texto)] := Caracter_Novo;

  Result := Texto;

end;

function ValidaCEP(CEP: string): boolean;
begin
  if Length(StrTran(StrTran(CEP, '-', ''), ' ', '')) < 8 then
    Result := False
  else
    Result := True;
end;

function ValidaCNPJ(CNPJ: string): boolean;
// Verifica se o CNPJ possui 14(Quatorze) dígitos - Paulo Santos - 27/10/2005
begin
  if Length(StrTran(StrTran(StrTran(StrTran(Trim(CNPJ), '.', ''), '/', ''), '-', ''), ' ', '')) < 14 then
    Result := False
  else
    Result := True;
end;

function ValidaCPF(CPF: string): boolean;
// Verifica se o CPF possui 11(Onze) dígitos - Paulo Santos - 16/11/2005
begin
  if Length(StrTran(StrTran(StrTran(Trim(CPF), '.', ''), '-', ''), ' ', '')) < 11 then
    Result := False
  else
    Result := True;
end;

function ValidaTelefone(Telefone: string): boolean;
var
  Prefixo,
    Sufixo,
    Fone: string;
begin
  Prefixo := StrTran(Copy(Telefone, 1, 4), ' ', '');
  Sufixo := StrTran(Copy(Telefone, 6, 4), ' ', '');
  Fone := Prefixo + Sufixo;

  if ((Length(Fone) = 0)) or (Length(Fone) >= 7) then
    Result := true
  else
    Result := false;
end;

function Arredonda(nNum: Double; nCasas: Integer): Double;
var
  nTmp: Double;
begin
  nTmp := nNum * Power(10, nCasas);
  nTmp := Round(nTmp);

  Result := nTmp / Power(10, nCasas);
end;

function PasswordInputBox(const ACaption, APrompt: string): string;
var
  Form: TForm;
  Prompt: TLabel;
  Usuario: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
  Value: string;
  I: Integer;
  Imagem: TImage;
  Buffer: array[0..51] of Char;
begin
  Result := '';
  Form := TForm.Create(Application);
  with Form do
  try
    Canvas.Font := Font;
    for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
    for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
    GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(DialogUnits));
    DialogUnits.X := DialogUnits.X div 52;
    BorderStyle := bsDialog;
    Color := clWhite;
    Caption := ACaption;
    ClientWidth := MulDiv(300, DialogUnits.X, 4); //180
    ClientHeight := MulDiv(90, DialogUnits.Y, 8); //63
    Position := poScreenCenter;
    BorderIcons := [];

    Usuario := TLabel.Create(Form);
    with Usuario do
    begin
      Parent := Form;
      AutoSize := True;
      Left := MulDiv(125, DialogUnits.X, 4);
      Top := MulDiv(8, DialogUnits.Y, 8);
      Caption := 'Usuário : ' + Geral.Apelido;
    end;

    Prompt := TLabel.Create(Form);
    with Prompt do
    begin
      Parent := Form;
      AutoSize := True;
      Left := Usuario.Left;
      Top := MulDiv(25, DialogUnits.Y, 8);
      Caption := APrompt;
    end;

    Imagem := TImage.Create(Form);
    with Imagem do
    begin
      Parent := Form;
      Height := MulDiv(90, DialogUnits.Y, 8); //63
      Width := 180;
      Left := MulDiv(0, DialogUnits.X, 4);
      Top := MulDiv(0, DialogUnits.Y, 8);

      Stretch := True;
      Picture.LoadFromFile('\\srverp\erp\Imagem\PID.jpg');
    end;
    Edit := TEdit.Create(Form);
    with Edit do
    begin
      Parent := Form;
      Left := Prompt.Left;
      Top := MulDiv(35, DialogUnits.Y, 8);
      Width := MulDiv(164, DialogUnits.X, 4);
      MaxLength := 255;
      PasswordChar := '*';
      SelectAll;
    end;
    ButtonTop := MulDiv(56, DialogUnits.Y, 8);
    ButtonWidth := MulDiv(50, DialogUnits.X, 4);
    ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
    with TButton.Create(Form) do
    begin
      Parent := Form;
      Caption := 'OK';
      ModalResult := mrOk;
      Default := True;
      SetBounds(MulDiv(140, DialogUnits.X, 4), ButtonTop, ButtonWidth, ButtonHeight);
    end;
    with TButton.Create(Form) do
    begin
      Parent := Form;
      Caption := 'Cancel';
      ModalResult := mrCancel;
      Cancel := True;
      SetBounds(MulDiv(200, DialogUnits.X, 4), ButtonTop, ButtonWidth, ButtonHeight);
    end;
    if ShowModal = mrOk then
    begin
      Value := AnsiUpperCase(Edit.Text);
      Result := Value;
    end;
  finally
    FreeAndNil(Form);
  end;
end;

function FloatToExtenso(Valor: Extended): string;
var
  Centavos,
    Centena,
    Milhar,
    Milhao,
    Bilhao,
    Texto: string;
const
  Unidades: array[1..9] of string
  = ('Um', 'Dois', 'Três', 'Quatro', 'Cinco', 'Seis', 'Sete', 'Oito', 'Nove');
  Dez: array[1..9] of string
  = ('Onze', 'Doze', 'Treze', 'Quatorze', 'Quinze',
    'Dezesseis', 'Dezessete', 'Dezoito', 'Dezenove');
  Dezenas: array[1..9] of string
  = ('Dez', 'Vinte', 'Trinta', 'Quarenta', 'Cinquenta',
    'Sessenta', 'Setenta', 'Oitenta', 'Noventa');
  Centenas: array[1..9] of string
  = ('Cento', 'Duzentos', 'Trezentos', 'Quatrocentos', 'Quinhentos',
    'Seiscentos', 'Setecentos', 'Oitocentos', 'Novecentos');

  function ifs(Expressao: Boolean; CasoVerdadeiro, CasoFalso: string): string;
  begin
    if Expressao
      then Result := CasoVerdadeiro
    else Result := CasoFalso;
  end;

  function MiniExtenso(Valor: ShortString): string;
  var Unidade, Dezena, Centena: string;
  begin
    if (Valor[2] = '1') and (Valor[3] <> '0')
      then
    begin
      Unidade := Dez[StrToInt(Valor[3])];
      Dezena := '';
    end
    else
    begin
      if Valor[2] <> '0'
        then Dezena := Dezenas[StrToInt(Valor[2])];
      if Valor[3] <> '0'
        then unidade := Unidades[StrToInt(Valor[3])];
    end;
    if (Valor[1] = '1') and (Unidade = '') and (Dezena = '')
      then Centena := 'Cem'
    else
      if Valor[1] <> '0'
        then Centena := Centenas[StrToInt(Valor[1])]
      else Centena := '';
    Result := Centena + ifs((Centena <> '') and
      ((Dezena <> '') or (Unidade <> '')), ' e ', '') + Dezena +
      ifs((Dezena <> '') and (Unidade <> ''), ' e ', '') + Unidade;
  end;

begin
  if Valor = 0
    then
  begin
    Result := '';
    Exit;
  end;
  Texto := FormatFloat('000000000000.00', Valor);
  Centavos := MiniExtenso('0' + Copy(Texto, 14, 2));
  Centena := MiniExtenso(Copy(Texto, 10, 3));
  Milhar := MiniExtenso(Copy(Texto, 7, 3));
  if Milhar <> ''
    then Milhar := Milhar + ' Mil';
  Milhao := MiniExtenso(Copy(Texto, 4, 3));
  if Milhao <> ''
    then Milhao := Milhao +
    ifs(Copy(Texto, 4, 3) = '001', ' Milhão', ' Milhões');
  Bilhao := MiniExtenso(Copy(Texto, 1, 3));
  if Bilhao <> ''
    then Bilhao := Bilhao +
    ifs(Copy(Texto, 1, 3) = '001', ' Bilhão', ' Bilhões');
  if (Bilhao <> '') and (Milhao + Milhar + Centena = '')
    then Result := Bilhao + ' de Reais'
  else
    if (Milhao <> '') and (Milhar + Centena = '')
      then Result := Milhao + ' de Reais'
    else Result := Bilhao +
      ifs((Bilhao <> '') and
        (Milhao + Milhar + Centena <> ''),
        ifs((Pos(' e ', Bilhao) > 0) or
        (Pos(' e ', Milhao + Milhar + Centena) > 0)
        , ', ', ' e '), '') + Milhao +
        ifs((Milhao <> '') and
        (Milhar + Centena <> ''), ifs((Pos(' e ', Milhao) > 0)
        or (Pos(' e ', Milhar + Centena) > 0),
        ', ', ' e '), '') + Milhar + ifs((Milhar <> '') and
        (Centena <> ''),
        ifs(Pos(' e ', Centena) > 0, ', ', ' e '), '') +
        Centena + ifs(Int(Valor) = 1, ' Real', ' Reais');
  if Centavos <> ''
    then Result := Result + ' e ' + Centavos +
    ifs(Copy(Texto, 14, 2) = '01', ' Centavo', ' Centavos');
end;

function SeparaMemo(cMemo: string; iTam: SmallInt; Lista: TStringList): SmallInt;
var
  iPos, iDiv: SmallInt;
  aLinha: TStringList;
  cText: string;
begin
  aLinha := TStringList.Create;
  aLinha.Clear;
  iPos := 1;
  cMemo := StrTran(cMemo, #10, '');
  cMemo := StrTran(cMemo, #$D, '');
  while not (Pal(cMemo, iPos, #13) = '') do
  begin
    cText := Pal(cMemo, iPos, #13);
    aLinha.Add(cText);
    Inc(iPos);
  end;
  Lista.Clear;
  for iPos := 0 to aLinha.Count - 1 do
  begin
    cText := aLinha[iPos];
    while (Length(cText) > iTam) do
    begin
      iDiv := PosR(' ', PADR(cText, '', iTam));
      Lista.Add(Trim(Padr(cText, '', iDiv)));
      cText := Copy(cText, iDiv + 1, Length(cText));
    end;
    if not (cText = '') then
      Lista.Add(cText);
  end;
  Result := Lista.Count;
end;

function PosR(Substr: string; S: string): Integer;
var
  Cont: Integer;
begin
  Result := 0;
  for Cont := Length(S) downto 1 do
    if (Copy(S, Cont, 1) = Substr) then
    begin
      Result := Cont;
      Break;
    end;
end;

procedure SetaVariaveisAmbiente;
begin
  FormatSettings.ThousandSeparator := '.';
  FormatSettings.DecimalSeparator := ',';
  FormatSettings.TwoDigitYearCenturyWindow := 50;
  FormatSettings.DateSeparator := '/';
  FormatSettings.ShortDateFormat := 'dd/MM/yyyy';
  {aportuguesa a data}
  FormatSettings.ShortMonthNames[1] := 'Jan';
  FormatSettings.ShortMonthNames[2] := 'Fev';
  FormatSettings.ShortMonthNames[3] := 'Mar';
  FormatSettings.ShortMonthNames[4] := 'Abr';
  FormatSettings.ShortMonthNames[5] := 'Mai';
  FormatSettings.ShortMonthNames[6] := 'Jun';
  FormatSettings.ShortMonthNames[7] := 'Jul';
  FormatSettings.ShortMonthNames[8] := 'Ago';
  FormatSettings.ShortMonthNames[9] := 'Set';
  FormatSettings.ShortMonthNames[10] := 'Out';
  FormatSettings.ShortMonthNames[11] := 'Nov';
  FormatSettings.ShortMonthNames[12] := 'Dez';
  FormatSettings.LongMonthNames[1] := 'Janeiro';
  FormatSettings.LongMonthNames[2] := 'Fevereiro';
  FormatSettings.LongMonthNames[3] := 'Março';
  FormatSettings.LongMonthNames[4] := 'Abril';
  FormatSettings.LongMonthNames[5] := 'Maio';
  FormatSettings.LongMonthNames[6] := 'Junho';
  FormatSettings.LongMonthNames[7] := 'Julho';
  FormatSettings.LongMonthNames[8] := 'Agosto';
  FormatSettings.LongMonthNames[9] := 'Setembro';
  FormatSettings.LongMonthNames[10] := 'Outubro';
  FormatSettings.LongMonthNames[11] := 'Novembro';
  FormatSettings.LongMonthNames[12] := 'Dezembro';
  FormatSettings.ShortDayNames[1] := 'Dom';
  FormatSettings.ShortDayNames[2] := 'Seg';
  FormatSettings.ShortDayNames[3] := 'Ter';
  FormatSettings.ShortDayNames[4] := 'Qua';
  FormatSettings.ShortDayNames[5] := 'Qui';
  FormatSettings.ShortDayNames[6] := 'Sex';
  FormatSettings.ShortDayNames[7] := 'Sab';
  FormatSettings.LongDayNames[1] := 'Domingo';
  FormatSettings.LongDayNames[2] := 'Segunda';
  FormatSettings.LongDayNames[3] := 'Terça';
  FormatSettings.LongDayNames[4] := 'Quarta';
  FormatSettings.LongDayNames[5] := 'Quinta';
  FormatSettings.LongDayNames[6] := 'Sexta';
  FormatSettings.LongDayNames[7] := 'Sabado';
end;

function AnsiToAscii(str: string): string;
var
  i: Integer;
begin
  for i := 1 to Length(str) do
    case str[i] of
      'á': str[i] := 'a';
      'é': str[i] := 'e';
      'í': str[i] := 'i';
      'ó': str[i] := 'o';
      'ú': str[i] := 'u';
      'à': str[i] := 'a';
      'è': str[i] := 'e';
      'ì': str[i] := 'i';
      'ò': str[i] := 'o';
      'ù': str[i] := 'u';
      'â': str[i] := 'a';
      'ê': str[i] := 'e';
      'î': str[i] := 'i';
      'ô': str[i] := 'o';
      'û': str[i] := 'u';
      'ä': str[i] := 'a';
      'ë': str[i] := 'e';
      'ï': str[i] := 'i';
      'ö': str[i] := 'o';
      'ü': str[i] := 'u';
      'ã': str[i] := 'a';
      'õ': str[i] := 'o';
      'ñ': str[i] := 'n';
      'ç': str[i] := 'c';
      'Á': str[i] := 'A';
      'É': str[i] := 'E';
      'Í': str[i] := 'I';
      'Ó': str[i] := 'O';
      'Ú': str[i] := 'U';
      'À': str[i] := 'A';
      'È': str[i] := 'E';
      'Ì': str[i] := 'I';
      'Ò': str[i] := 'O';
      'Ù': str[i] := 'U';
      'Â': str[i] := 'A';
      'Ê': str[i] := 'E';
      'Î': str[i] := 'I';
      'Ô': str[i] := 'O';
      'Û': str[i] := 'U';
      'Ä': str[i] := 'A';
      'Ë': str[i] := 'E';
      'Ï': str[i] := 'I';
      'Ö': str[i] := 'O';
      'Ü': str[i] := 'U';
      'Ã': str[i] := 'A';
      'Õ': str[i] := 'O';
      'Ñ': str[i] := 'N';
      'Ç': str[i] := 'C';
    end;
  Result := str;
end;

function DataExtenso(Data: TDateTime): string;
{Retorna uma data por extenso}
var
  Meses: array[1..12] of string;
  Dia, Mes, Ano: Word;
begin
{ Meses do ano }
  Meses[1] := 'Janeiro';
  Meses[2] := 'Fevereiro';
  Meses[3] := 'Março';
  Meses[4] := 'Abril';
  Meses[5] := 'Maio';
  Meses[6] := 'Junho';
  Meses[7] := 'Julho';
  Meses[8] := 'Agosto';
  Meses[9] := 'Setembro';
  Meses[10] := 'Outubro';
  Meses[11] := 'Novembro';
  Meses[12] := 'Dezembro';
  DecodeDate(Data, Ano, Mes, Dia);
  Result := IntToStr(Dia) + ' de ' + Meses[Mes] + ' de ' + IntToStr(Ano);
end;

function Pri_Maiuscula(Nome: string): string;
var
  iLoop: integer;
  iLoop2: integer;
  Aux, AuxLower: string;
  Romano: boolean;
begin
  Result := '';
  if (Trim(Nome) <> '') then
  begin
    Aux := '';
    for iLoop := 1 to Length(Nome) + 1 do // adiciona 1 para executar ultima palavra
    begin
      if ((Nome[iLoop] = ' ') or (Nome[iLoop] = #0)) and (Trim(Aux) <> '') then
      begin // se tem espaco entre palavras ou fim do NOME ou aux nao esta vazio ( fim nome )
        AuxLower := AnsiLowerCase(Aux);
        if {(AuxLower <> 'de') and (AuxLower <> 'da') and (AuxLower <> 'dos') and
            (AuxLower <> 'e') (AuxLower <> 'do') and (AuxLower <> 'das') and
            (AuxLower <> 'des') and }(AuxLower <> 'sa') and (AuxLower <> 's.a.') and
          (AuxLower <> 's.a') and (AuxLower <> 's/a') then
        begin
          iLoop2 := 1;
          Romano := true;
          while Length(Aux) >= iLoop2 do
          begin
            if (Aux[iLoop2] <> 'i') and (Aux[iLoop2] <> 'v') and
              (Aux[iLoop2] <> 'l') and (Aux[iLoop2] <> 'c') and
              (Aux[iLoop2] <> 'x') and (Aux[iLoop2] <> 'd') and
              (Aux[iLoop2] <> 'm') then
            begin
              romano := false;
              Break;
            end;
            Inc(iLoop2);
          end;
          if not romano then
            Result := Result + AnsiUpperCase(Aux[1]) +
              AnsiLowerCase(Copy(Aux, 2, Length(Aux) - 1)) + ' '
          else
            Result := Result + AnsiUpperCase(Aux) + ' ';
          Aux := '';
        end
        else
        begin
          Result := Result + Aux + ' ';
          Aux := '';
        end
      end
      else // se fim do nome adiciona ultimo aux
        Aux := Aux + Trim(Nome[iLoop]);
    end;
  end;
  Result := Trim(Result);
end;

function ComponentToString(const AValue: TComponent): WideString;
var
  Memory_Stream: TMemoryStream;
  Str_Stream: TStringStream;
begin
  Memory_Stream := TMemoryStream.Create;
  Str_Stream := TStringStream.Create('');
  try
    Memory_Stream.WriteComponent(AValue);
    Memory_Stream.Seek(0, soFromBeginning);
    ObjectBinaryToText(Memory_Stream, Str_Stream);
    Str_Stream.Seek(0, soFromBeginning);
    Result := Str_Stream.DataString;
  finally
    Str_Stream.Free;
    Memory_Stream.Free
  end;
end;

function StringCaracteresIguais(aText: string): Boolean;
// função que verifica se todos os caracteres da string são iguais;
// retorno: True = todos caracteres iguais;
var
  i: Integer;
begin
  result := true;
  for i := 2 to Length(aText) do
  begin
    if (aText[i] = aText[i - 1]) then
      result := true
    else
    begin
      result := false;
      exit;
    end;
  end;
end;

function StringToComponent(const AValue: WideString): TComponent;
var
  Memory_Stream: TMemoryStream;
  Str_Stream: TStringStream;
begin
  Memory_Stream := TMemoryStream.Create;
  Str_Stream := TStringStream.Create(AValue);
  try
    ObjectTextToBinary(Str_Stream, Memory_Stream);
    Memory_Stream.Seek(0, soFromBeginning);
    Result := Memory_Stream.ReadComponent(nil);
  finally
    Str_Stream.Free;
    Memory_Stream.Free;
  end;
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

function Encrypt(const sStr: string; Key: Word): string;
var
  I: LongInt;
begin
  Result := sStr;
  for I := 1 to Length(sStr) do begin
    Result[I] := Char(Byte(sStr[I]) xor (Key shr 8));
    Key := (Byte(sStr[I]) + Key) * CriptografiaC1 + CriptografiaC2;
  end;
end;

function Decrypt(const sStr: string; Key: Word): string;
var
  I: LongInt;
begin
  Result := sStr;
  for I := 1 to Length(sStr) do begin
    Result[I] := Char(Byte(sStr[I]) xor (Key shr 8));
    Key := (Byte(Result[I]) + Key) * CriptografiaC1 + CriptografiaC2;
  end;
end;

function TiraAcento(cString: string): string;
var
  nCont: Integer;
begin
  for nCont := 1 to Length(cString) do
    case cString[nCont] of
      #224..#230: cString[nCont] := 'a';
      #192..#198: cString[nCont] := 'A';
      #231: cString[nCont] := 'c';
      #199: cString[nCont] := 'C';
      #232..#235: cString[nCont] := 'e';
      #200..#203: cString[nCont] := 'E';
      #236..#239: cString[nCont] := 'i';
      #204..#207: cString[nCont] := 'I';
      #241: cString[nCont] := 'n';
      #209: cString[nCont] := 'N';
      #242..#246: cString[nCont] := 'o';
      #210..#214: cString[nCont] := 'O';
      #249..#252: cString[nCont] := 'u';
      #217..#220: cString[nCont] := 'U';
    end;
  Result := cString;
end;

function FileDate(Arquivo: string): string;
{Retorna a data e a hora de um arquivo}
var
  FHandle: integer;
begin
  if not fileexists(Arquivo) then
  begin
    Result := 'Nome de Arquivo Inválido';
  end
  else
  begin
    FHandle := FileOpen(Arquivo, 0);
    try
      Result := DateTimeToStr(FileDateToDateTime(FileGetDate(FHandle)));
    finally
      FileClose(FHandle);
    end;
  end;
end;

function cConverte(Valor: Integer): string;
//Converte um número qualquer passado como parametro em representação na
//base 36
//const BaseNum : String = '0123456789abcdefghijklmnopqrstuvwxyz';
//const BaseNum : String = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const BaseNum: string = '0Z1F2C3L4B5A6I7S8K9VNEQGXJOPDRTMUWYH';
var
  temp, aux: string;
  iaux: Integer;
begin
    //Seta a variável de retorno
  Result := 'Erro';
  aux := BaseNum;

  if Valor >= 0 then
  begin
    Result := '';
    while valor > 0 do
    begin
      iaux := valor div length(Aux);
      iaux := Valor - (length(BaseNum) * iaux);
      temp := IntToStr(iaux);
      Valor := Valor div length(BaseNum);
      Result := Copy(BaseNum, iaux + 1, 1) + Result;
    end;
    if Result = '' then
      Result := Copy(BaseNum, 1, 1);
  end;
end;

function UltDiaDoMes(Mdt: TDateTime): TDateTime;
var
  ano, mes, dia: word;
  mDtTemp: TDateTime;
begin
  Decodedate(mDt, ano, mes, dia);
  mDtTemp := (mDt - dia) + 33;
  Decodedate(mDtTemp, ano, mes, dia);
  Result := mDtTemp - dia;
end;

function PadC(S: string; Len: byte): string;
// Centraliza uma string em um espaço determinado
var
  Str: string;
  L: byte;
begin
  str := '';
  if len < Length(s) then
  begin
    Result := '';
    Exit;
  end;
  l := (Len - Length(S)) div 2;
  while l > 0 do
  begin
    str := str + ' ';
    dec(l);
  end;
  for l := 1 to length(S) do
  begin
    str := str + s[L];
  end;
  Result := str;
end;

function ValidaPlaca(Texto: ShortString; var Key: char): Boolean;
begin
  Result := True;

  if (Key in ['A'..'Z', 'a'..'z', '0'..'9', #8]) then
  begin
    if (Key in ['A'..'Z', 'a'..'z']) then
    begin
      if Length(Copy(Texto, 1, 3)) = 3 then
      begin
        Key := #0;
        Texto := '';
        Result := False;
      end;
    end;

    if (Key in ['0'..'9']) then
    begin
      if (Length(Copy(Texto, 1, 3)) < 3) or (Length(Copy(Texto, 4, 4)) = 4) then
      begin
        Key := #0;
        Texto := '';
        Result := False;
      end;
    end;
  end
  else
  begin
    Key := #0;
    Texto := '';
    Result := False;
  end;
end;

{ TGeraSM }

constructor TGeraSM.Create;
begin
  DataRecebimento := 0;
  FAV_Codigo := 0;
  END_Codigo := 0;
  TEQ_Codigo := 0;
  Controlador := 0;
  DataInicial := 0;
  DataFinal := 0;
  CodigoCavalo := 0;
  CodigoCarreta := 0;
  Origem := 0;
  Destino := 0;
  PRF_Codigo := 0;
  ValorSm := 0;
  FAV_CodigoRelaciona := 0;
  END_CodigoRelaciona := 0;
  Temperatura := 0;
  MOP_Codigo := 0;
  HoraRecebimento := '';
  Especial := '';
  Selecionada := '';
  Sel_Fat := '';
  Viagem := '';
  Baixado := '';
  Encerrada := '';
  Comboio := '';
  Itinerario := '';
  SMlida := '';
  Protocolo := '';
  WebSM := '';
  HoraInicial := '';
  HoraFinal := '';
  Protocolo := '';
  Solicitante := '';
  DDD_Solicitante := '';
  Tel_Solicitante := '';
  Produtor := '';
end;

function Justifica(mCad: string; mMAx: integer): string;
var
  mPos, mPont, mTam, mNr, mCont: integer;
  mStr: string;
begin
  mTam := Length(mCad);
  if mTam >= mMax then
    Result := copy(mCad, 1, mMax)
  else
    mStr := '';
  mCont := 0;
  mPont := 1;
  mNr := mMax - mTam;
  while mCont < mNr do
  begin
    mPos := pos(mStr, copy(mCad, mPont, 100));
    if mPos = 0 then
    begin
      mStr := mStr + ' ';
      mPont := 1;
      continue;
    end
    else
    begin
      mCont := mCont + 1;
      Insert(' ', mCad, mPos + mPont);
      mPont := mPont + mPos + length(mStr);
    end;
    Result := mCad;
  end;
end;

procedure ZebrarDBGrid(aGrid: TDBGrid; aState: TGridDrawState; const aRect: TRect;
  aDataCol: Integer; Column: TColumn; aColor1: TColor = clWhite; aColor2: TColor = $00F2F2F2);
begin
  if aState = [] then
    if aGrid.DataSource.DataSet.RecNo mod 2 = 1 then
      aGrid.Canvas.Brush.Color := aColor1
    else
      aGrid.Canvas.Brush.Color := aColor2;

  aGrid.DefaultDrawColumnCell(aRect, aDataCol, Column, aState);
end;

procedure OrdenarGridPintando(pColumn: TColumn; aColor1: TColor = clWhite;
  aColor2: TColor = clInfoBk);
var
  i: Integer;
begin
  OrdenarGrid(pColumn);

  for i := 0 to TDBGrid(pColumn.Grid).Columns.Count - 1 do
    TDBGrid(pColumn.Grid).Columns[i].Color := aColor1;

  pColumn.Color := aColor2;
end;



procedure ListProcess(List: TStrings);
var
  ProcEntry: TProcessEntry32;
  Hnd: THandle;
  Fnd: Boolean;
begin
  List.Clear;
  Hnd := CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);
  if Hnd <> -1 then
  begin
  ProcEntry.dwSize := SizeOf(TProcessEntry32);
  Fnd := Process32First(Hnd, ProcEntry);
  while Fnd do
  begin
  List.Add(ProcEntry.szExeFile);
  Fnd := Process32Next(Hnd, ProcEntry);
  end;
  CloseHandle(Hnd);
  end;
end;


Procedure CarregaPastas(Formulario : TForm);
var
  Arqini: TIniFile;
begin
  Formulario.Refresh;
  if not FileExists(ExtractFilePath(Application.ExeName) + 'Exotech.ini') then
  begin
    Application.MessageBox(pchar('O arquivo ' + ExtractFilePath(Application.ExeName)
      + 'Exotech.ini' + ' não foi encontrado.' + #13 + 'O sistema necessita do mesmo para sua execução'),
      pchar('Arquivo de Inicialização.'), 48);
    Application.Terminate;
    Abort;
  end
  else
  begin
    ArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\' + 'Exotech.ini');
    Intervalo := ArqIni.ReadString('Configuracao', 'Intervalo', '5000');
    Arquivos := ArqIni.ReadString('Configuracao', 'Arquivos', '');
    Diretorio[0] := ArqIni.ReadString('Pastas', 'ENVIO', '');
    Diretorio[1] := ArqIni.ReadString('Pastas', 'RETORNO', '');
    Diretorio[2] := Arqini.ReadString('Pastas', 'ENVIADO', '');
    Diretorio[3] := Arqini.ReadString('Pastas', 'NAOENVIADO', '');
    Diretorio[4] := Arqini.ReadString('Pastas', 'LIDO', '');
    Tempo        := Arqini.ReadInteger('Tempo', 'MINUTOS',60); 

    FreeAndNil(ArqIni);
  end;
  Sleep(2000);
end;


Procedure CopyFile( Const sourcefilename, targetfilename: String );
{Copia um arquivo de um lugar para outro}
Var
  S, T: TFileStream;
Begin
  S := TFileStream.Create( sourcefilename, fmOpenRead );
  try
  T := TFileStream.Create( targetfilename, fmOpenWrite or fmCreate );
  try
  T.CopyFrom(S, S.Size ) ;
  finally
  T.Free;
  end;
  finally
  S.Free;
  end;
end;


function ProcessArquivo(const Origem, Destino : string; Operacao, Modo:Integer) : Boolean;
  // Requer a unit ShellApi na clausula uses da unit
  Const
  Aborted : Boolean = False;
  var
  shfo : TSHFileOpStruct;
  begin
  FillChar(shfo,SizeOf(shfo),$0);
  with shfo do
  begin
  if Operacao > 2 then
  begin
  operacao := 2;
  end;
  if Modo > 5 then
  begin
  modo := 1;
  end;
  case operacao of
  1: wFunc := FO_MOVE;
  2: wFunc := FO_COPY;
  end;
  pFrom := Pchar(Origem);
  pTo := Pchar(Destino);
  case Modo of
  1: fFlags := FOF_SILENT;
  2: fFlags := FOF_ALLOWUNDO or FOF_FILESONLY;
  3: fFlags := FOF_RENAMEONCOLLISION;
  4: fFlags := FOF_NOCONFIRMATION;
  5: fFlags := FOF_SIMPLEPROGRESS;
  end;
  end;
  Result := (SHFileOperation(shfo)= 0) and (not Aborted);
end;


function AdicionaHora(TimeAdd: Integer) : String;
{Adiciona à hora atual um numero de horas determinado. Caso este numero seje negativo, ele subtrairá da hora atual}
Var
Horas,Min,SomaHoras,SomaMin : Integer;
S, S1 : String;
begin
Horas := Strtoint(Copy(TimetoStr(Time),1,2))+ TimeAdd;
Min := Strtoint(Copy(TimetoStr(Time),4,2))+ TimeAdd ;
SomaHoras := SomaHoras+Horas;
SomaMin := SomaMin + Min;
If SomaMin > 59 Then
  begin
  if SomaMin mod 60 = 0 Then
  begin
  Somahoras := Somahoras+(Somamin div 60);
  Somamin := 0;
  end
  else
  begin
  SomaHoras := SomaHoras + (SomaMin div 60);
  SomaMin := SomaMin mod 60;
  end;
  end;
If Somamin = 0 Then
  begin
  S := '00';
  end
else
  begin
  S := InttoStr(Somamin);
  end;
If Length(InttoStr(SomaHoras)) = 1 Then
  begin
  S1 := Concat('0',InttoStr(Somahoras));
  end
else
  begin
  S1 := InttoStr(Somahoras);
  end;
Result := Concat(S1,':',S,':00');
end;



Function InverteData(Data : String) : String;
Var
 Dia, Mes, Ano, DataCorreta : String;
begin
  Dia := Copy(Data,5,2);
  Mes := Copy(Data,3,2);
  Ano := Copy(Data,1,2);
  DataCorreta := Dia + '/' + Mes + '/' +'20' + Ano;
  Result := DataCorreta;
end;


end.



