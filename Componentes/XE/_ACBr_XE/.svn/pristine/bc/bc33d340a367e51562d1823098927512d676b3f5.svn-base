unit ACBrUtilTest;

{$IFDEF FPC}
{$mode objfpc}{$H+}
{$ENDIF}

interface

uses
  Classes, SysUtils,
  {$ifdef FPC}
  fpcunit, testutils, testregistry
  {$else}
  TestFramework
  {$endif};

type

  { TiraPontosTest }

  TiraPontosTest = class(TTestCase)
  published
    procedure TiraPontos_StringInvalida_RetornaVazio;
    procedure TiraPontos_StringInicioInvalido_RetornaFinal;
    procedure TiraPontos_StringFimInvalido_RetornaInicio;
    procedure TiraPontos_StringMeioInvalido_RetornaExtremos;
    procedure TiraPontos_StringExtremosInvalidos_RetornaMeio;
    procedure TiraPontos_StringComEspacos_RetornaMeioSemEspacos;
  end;

  { ParseTextTest }

  ParseTextTest = class(TTestCase)
  private
  published
    procedure VerificarConversao;
    procedure VerificarConversaoTextoLongo;
  end;

  { LerTagXMLTest }

  LerTagXMLTest = class(TTestCase)
  published
    procedure Simples;
    procedure SemIgnorarCase;
    procedure ComVariasTags;
  end;

  { SepararDadosTest }

  SepararDadosTest = class(TTestCase)
  published
    procedure Simples;
    procedure TextoLongo;
    procedure MostrarChave;
    procedure ComVariasChaves;
    procedure SemFecharChave;
    procedure SemAbrirChave;
  end;

  { padLTest }

  padLTest = class(TTestCase)
  published
    procedure CompletarString;
    procedure ManterString;
    procedure TruncarString;
  end;

  { padRTest }

  padRTest = class(TTestCase)
  published
   procedure CompletarString;
   procedure ManterString;
   procedure TruncarString;
  end;

  { padCTest }

  padCTest = class(TTestCase)
  published
   procedure PreencherString;
   procedure TruncarString;
  end;

  { padSTest }

  padSTest = class(TTestCase)
  published
   procedure CompletarString;
   procedure TruncarString;
   procedure SubstituirSeparadorPorEspacos;
   procedure SubstituirSeparadorPorCaracter;
  end;

  { RemoverEspacosDuplosTest }

  RemoverEspacosDuplosTest = class(TTestCase)
  published
   procedure RemoverApenasEspacosDuplos;
   procedure RemoverMaisQueDoisEspacos;
  end;

  { RemoveStringTest }

  RemoveStringTest = class(TTestCase)
  published
   procedure Remover;
  end;

  { RemoveStringsTest }

  RemoveStringsTest = class(TTestCase)
  private
    StringsToRemove: array [1..5] of AnsiString;
  protected
    procedure SetUp; override;
  published
   procedure TextoSimples;
   procedure TextoLongo;
  end;

  { StripHTMLTest }

  StripHTMLTest = class(TTestCase)
  published
   procedure TesteSimples;
   procedure TesteCompleto;
  end;

  { CompareVersionsTest }

  CompareVersionsTest = class(TTestCase)
  published
   procedure VersaoIgual;
   procedure VersaoMaior;
   procedure VersaoMenor;
   procedure TrocarDelimitador;
  end;

  { IfEmptyThenTest }

  IfEmptyThenTest = class(TTestCase)
  published
   procedure RetornarValorNormal;
   procedure SeVazioRetornaValorPadrao;
   procedure RealizarDoTrim;
   procedure NaoRealizarDoTrim;
  end;

  { Poem_ZerosTest }

  Poem_ZerosTest = class(TTestCase)
  published
   procedure ColocarZeros;
  end;

  { IntToStrZeroTest }

  IntToStrZeroTest = class(TTestCase)
  published
   procedure AdicionarZerosAoNumero;
   procedure TamanhoMenorQueLimite;
  end;

  { FloatToIntStrTest }

  FloatToIntStrTest = class(TTestCase)
  published
   procedure Normal;
   procedure ValorSemDecimais;
   procedure MudandoPadraoDeDecimais;
   procedure EnviandoDecimaisDiferenteDoPadrao;
  end;

  { FloatToStringTest }

  FloatToStringTest = class(TTestCase)
  published
   procedure Normal;
   procedure ComDecimaisZerados;
  end;

  { StringToFloatTest }

  StringToFloatTest = class(TTestCase)
  published
   procedure Normal;
  end;

  { StringToFloatDefTest }

  StringToFloatDefTest = class(TTestCase)
  published
   procedure Normal;
   procedure ValorDefault;
  end;

  { StringToDateTimeTest }

  StringToDateTimeTest = class(TTestCase)
  published
   procedure Data;
   procedure Hora;
   procedure DataEHora;
  end;

  { StringToDateTimeDefTest }

  StringToDateTimeDefTest = class(TTestCase)
  published
   procedure Data;
   procedure Hora;
   procedure DataEHora;
   procedure ValorDefault;
  end;

  { StoDTest }

  StoDTest = class(TTestCase)
  published
   procedure Normal;
   procedure DataInvalida;
  end;

  { DtoSTest }

  DtoSTest = class(TTestCase)
  published
   procedure Data;
  end;

  { DTtoSTest }

  DTtoSTest = class(TTestCase)
  published
   procedure DataEHora;
   procedure DataSemHora;
  end;

  { StrIsAlphaTest }

  StrIsAlphaTest = class(TTestCase)
  published
   procedure Texto;
   procedure TextoComNumeros;
   procedure TextoComCaractersEspeciais;
   procedure TextoComCaractersAcentuados;
  end;

  { StrIsAlphaNumTest }

  StrIsAlphaNumTest = class(TTestCase)
  published
    procedure Texto;
    procedure TextoComNumeros;
    procedure TextoComCaractersEspeciais;
    procedure TextoComCaractersAcentuados;
  end;

  { StrIsNumberTest }

  StrIsNumberTest = class(TTestCase)
  published
    procedure Texto;
    procedure Numeros;
    procedure TextoComNumeros;
    procedure TextoComCaractersEspeciais;
  end;

  { CharIsAlphaTest }

  CharIsAlphaTest = class(TTestCase)
  published
    procedure Caracter;
    procedure Numero;
    procedure CaracterEspecial;
  end;

  { CharIsAlphaNumTest }

  CharIsAlphaNumTest = class(TTestCase)
  published
    procedure Caracter;
    procedure Numero;
    procedure CaracterEspecial;
  end;

  { CharIsNumTest }

  CharIsNumTest = class(TTestCase)
  published
    procedure Caracter;
    procedure Numero;
    procedure CaracterEspecial;
  end;

  { OnlyNumberTest }

  OnlyNumberTest = class(TTestCase)
  private
  published
    procedure Texto;
    procedure Numeros;
    procedure TextoComNumeros;
    procedure TextoComCaractersEspeciais;
  end;

  { OnlyAlphaTest }

  OnlyAlphaTest = class(TTestCase)
  published
    procedure Texto;
    procedure Numeros;
    procedure TextoComNumeros;
    procedure TextoComCaractersEspeciais;
  end;

  { OnlyAlphaNumTest }

  OnlyAlphaNumTest = class(TTestCase)
  published
    procedure Texto;
    procedure Numeros;
    procedure TextoComNumeros;
    procedure TextoComCaractersEspeciais;
  end;

  { StrIsIPTest }

  StrIsIPTest = class(TTestCase)
  published
    procedure Normal;
    procedure SemPonto;
  end;

  { TiraAcentosTest }

  TiraAcentosTest = class(TTestCase)
  published
    procedure Normal;
  end;

  { TiraAcentoTest }

  TiraAcentoTest = class(TTestCase)
  published
    procedure Normal;
  end;


  { EAN13Test }

  EAN13Test = class(TTestCase)
  published
    procedure EAN13Valido_StringInvalida_RetornaFalso;
    procedure EAN13Valido_StringValida_RetornaTrue;
    procedure EAN13Valido_String0000000000000_RetornaTrue;
    procedure EAN13Valido_String7896232517828_RetornaTrue;
    procedure EAN13Valido_String7896645900026_RetornaTrue;
    procedure EAN13Valido_String7898908141016_RetornaTrue;
    procedure EAN13Valido_String7893946087173_RetornaTrue;
    procedure EAN13Valido_String7897186015095_RetornaTrue;
    procedure EAN13Valido_String7891060886139_RetornaTrue;
    procedure EAN13Valido_String7898132132019_RetornaTrue;
    procedure EAN13Valido_String7506195185568_RetornaTrue;
    procedure EAN13Valido_String2000100002629_RetornaTrue;
    procedure EAN13_DV_StringAlphanumerica_RetornaVazio;
    procedure EAN13_DV_Codigo000000000000_Retorna0;
    procedure EAN13_DV_Codigo789623251782_Retorna8;
    procedure EAN13_DV_Codigo789664590002_Retorna6;
    procedure EAN13_DV_Codigo789890814101_Retorna6;
    procedure EAN13_DV_Codigo789394608717_Retorna3;
    procedure EAN13_DV_Codigo789718601509_Retorna5;
    procedure EAN13_DV_Codigo789106088613_Retorna9;
    procedure EAN13_DV_Codigo789813213201_Retorna9;
    procedure EAN13_DV_Codigo750619518556_Retorna8;
    procedure EAN13_DV_Codigo200010000262_Retorna9;
  end;


implementation

uses
  Math, dateutils,
  ACBrUtil, ACBrConsts;

{ TiraPontosTest }

procedure TiraPontosTest.TiraPontos_StringComEspacos_RetornaMeioSemEspacos;
begin
  CheckEquals('AaBbCcDdç123', ACBrUtil.TiraPontos('/-.) (,/-. )AaBbCc Ddç 1 23 (,,( ).-/'));

end;

procedure TiraPontosTest.TiraPontos_StringExtremosInvalidos_RetornaMeio;
begin
  CheckEquals('AaBbCcDdç123', ACBrUtil.TiraPontos('/-.)(,/-.)AaBbCcDdç123(,,().-/'));

end;

procedure TiraPontosTest.TiraPontos_StringFimInvalido_RetornaInicio;
begin
  CheckEquals('AaBbCcDdç123', ACBrUtil.TiraPontos('AaBbCcDdç123/-.)(,/-.)(,,().-/'));

end;

procedure TiraPontosTest.TiraPontos_StringInicioInvalido_RetornaFinal;
begin
  CheckEquals('AaBbCcDdç123', ACBrUtil.TiraPontos('/-.)(,/-.)(,,().-/AaBbCcDdç123'));
end;

procedure TiraPontosTest.TiraPontos_StringInvalida_RetornaVazio;
begin
  CheckEquals('', ACBrUtil.TiraPontos('/-.)(,/-.)(,,().-/'));
end;

procedure TiraPontosTest.TiraPontos_StringMeioInvalido_RetornaExtremos;
begin
  CheckEquals('AaBbCcDdç123', ACBrUtil.TiraPontos('AaBbCc/-.)(,/-.)(,,().-/Ddç123'));
end;

{ EAN13Test }

procedure EAN13Test.EAN13Valido_String0000000000000_RetornaTrue;
begin
  CheckTrue(ACBrUtil.EAN13Valido('0000000000000'));
end;

procedure EAN13Test.EAN13Valido_String2000100002629_RetornaTrue;
begin
  CheckTrue(ACBrUtil.EAN13Valido('2000100002629'));
end;

procedure EAN13Test.EAN13Valido_String7506195185568_RetornaTrue;
begin
  CheckTrue(ACBrUtil.EAN13Valido('7506195185568'));
end;

procedure EAN13Test.EAN13Valido_String7891060886139_RetornaTrue;
begin
  CheckTrue(ACBrUtil.EAN13Valido('7891060886139'));
end;

procedure EAN13Test.EAN13Valido_String7893946087173_RetornaTrue;
begin
  CheckTrue(ACBrUtil.EAN13Valido('7893946087173'));
end;

procedure EAN13Test.EAN13Valido_String7896232517828_RetornaTrue;
begin
  CheckTrue(ACBrUtil.EAN13Valido('7896232517828'));
end;

procedure EAN13Test.EAN13Valido_String7896645900026_RetornaTrue;
begin
  CheckTrue(ACBrUtil.EAN13Valido('7896645900026'));
end;

procedure EAN13Test.EAN13Valido_String7897186015095_RetornaTrue;
begin
  CheckTrue(ACBrUtil.EAN13Valido('7897186015095'));
end;

procedure EAN13Test.EAN13Valido_String7898132132019_RetornaTrue;
begin
  CheckTrue(ACBrUtil.EAN13Valido('7898132132019'));

end;

procedure EAN13Test.EAN13Valido_String7898908141016_RetornaTrue;
begin
  CheckTrue(ACBrUtil.EAN13Valido('7898908141016'));
end;

procedure EAN13Test.EAN13Valido_StringInvalida_RetornaFalso;
begin
  CheckFalse(ACBrUtil.EAN13Valido('abcdefghijklm'));
end;

procedure EAN13Test.EAN13Valido_StringValida_RetornaTrue;
begin
  CheckTrue(ACBrUtil.EAN13Valido('1234567890128'));
end;

procedure EAN13Test.EAN13_DV_Codigo000000000000_Retorna0;
begin
  CheckEquals('0', ACBrUtil.EAN13_DV('000000000000'));
end;

procedure EAN13Test.EAN13_DV_Codigo200010000262_Retorna9;
begin
  CheckEquals('9', ACBrUtil.EAN13_DV('200010000262'));
end;

procedure EAN13Test.EAN13_DV_Codigo750619518556_Retorna8;
begin
  CheckEquals('8', ACBrUtil.EAN13_DV('750619518556'));
end;

procedure EAN13Test.EAN13_DV_Codigo789106088613_Retorna9;
begin
  CheckEquals('9', ACBrUtil.EAN13_DV('789106088613'));
end;

procedure EAN13Test.EAN13_DV_Codigo789394608717_Retorna3;
begin
  CheckEquals('3', ACBrUtil.EAN13_DV('789394608717'));
end;

procedure EAN13Test.EAN13_DV_Codigo789623251782_Retorna8;
begin
  CheckEquals('8', ACBrUtil.EAN13_DV('789623251782'));
end;

procedure EAN13Test.EAN13_DV_Codigo789664590002_Retorna6;
begin
  CheckEquals('6', ACBrUtil.EAN13_DV('789664590002'));
end;

procedure EAN13Test.EAN13_DV_Codigo789718601509_Retorna5;
begin
  CheckEquals('5', ACBrUtil.EAN13_DV('789718601509'));
end;

procedure EAN13Test.EAN13_DV_Codigo789813213201_Retorna9;
begin
  CheckEquals('9', ACBrUtil.EAN13_DV('789813213201'));
end;

procedure EAN13Test.EAN13_DV_Codigo789890814101_Retorna6;
begin
  CheckEquals('6', ACBrUtil.EAN13_DV('789890814101'));
end;

procedure EAN13Test.EAN13_DV_StringAlphanumerica_RetornaVazio;
begin
  CheckEquals('', ACBrUtil.EAN13_DV('1234567890ab'));
end;

{ TiraAcentoTest }

procedure TiraAcentoTest.Normal;
begin
   CheckEquals('a', TiraAcento('á'));
   CheckEquals('a', TiraAcento('à'));
   CheckEquals('a', TiraAcento('ã'));
   CheckEquals('a', TiraAcento('ä'));
   CheckEquals('a', TiraAcento('â'));
   CheckEquals('A', TiraAcento('À'));
   CheckEquals('A', TiraAcento('Á'));
   CheckEquals('A', TiraAcento('Ã'));
   CheckEquals('A', TiraAcento('Ä'));
   CheckEquals('A', TiraAcento('Â'));
   CheckEquals('e', TiraAcento('è'));
   CheckEquals('e', TiraAcento('é'));
   CheckEquals('e', TiraAcento('ë'));
   CheckEquals('e', TiraAcento('ê'));
   CheckEquals('E', TiraAcento('È'));
   CheckEquals('E', TiraAcento('É'));
   CheckEquals('E', TiraAcento('Ë'));
   CheckEquals('E', TiraAcento('Ê'));
   CheckEquals('i', TiraAcento('ì'));
   CheckEquals('i', TiraAcento('í'));
   CheckEquals('i', TiraAcento('ï'));
   CheckEquals('i', TiraAcento('î'));
   CheckEquals('I', TiraAcento('Ì'));
   CheckEquals('I', TiraAcento('Í'));
   CheckEquals('I', TiraAcento('Ï'));
   CheckEquals('I', TiraAcento('Î'));
   CheckEquals('o', TiraAcento('ò'));
   CheckEquals('o', TiraAcento('ó'));
   CheckEquals('o', TiraAcento('õ'));
   CheckEquals('o', TiraAcento('ö'));
   CheckEquals('o', TiraAcento('ô'));
   CheckEquals('O', TiraAcento('Ò'));
   CheckEquals('O', TiraAcento('Ó'));
   CheckEquals('O', TiraAcento('Õ'));
   CheckEquals('O', TiraAcento('Ö'));
   CheckEquals('O', TiraAcento('Ô'));
   CheckEquals('u', TiraAcento('ù'));
   CheckEquals('u', TiraAcento('ú'));
   CheckEquals('u', TiraAcento('ü'));
   CheckEquals('u', TiraAcento('û'));
   CheckEquals('U', TiraAcento('Ù'));
   CheckEquals('U', TiraAcento('Ú'));
   CheckEquals('U', TiraAcento('Ü'));
   CheckEquals('U', TiraAcento('Û'));
   CheckEquals('c', TiraAcento('ç'));
   CheckEquals('C', TiraAcento('Ç'));
   CheckEquals('n', TiraAcento('ñ'));
   CheckEquals('N', TiraAcento('Ñ'));
end;

{ TiraAcentosTest }

procedure TiraAcentosTest.Normal;
begin
  //CheckEquals('TesteACBrUtil', TiraAcentos('TêstéÃCBrÜtìl'));
end;

{ StrIsIPTest }

procedure StrIsIPTest.Normal;
begin
  CheckTrue(StrIsIP('192.168.0.1'));
end;

procedure StrIsIPTest.SemPonto;
begin
   CheckFalse(StrIsIP('19216801'));
end;

{ OnlyAlphaNumTest }

procedure OnlyAlphaNumTest.Texto;
begin
  CheckEquals('TesteACBr', OnlyAlphaNum('TesteACBr'));
end;

procedure OnlyAlphaNumTest.Numeros;
begin
  CheckEquals('12345', OnlyAlphaNum('12345'));
end;

procedure OnlyAlphaNumTest.TextoComNumeros;
begin
  CheckEquals('TesteACBr12345', OnlyAlphaNum('TesteACBr12345'));
end;

procedure OnlyAlphaNumTest.TextoComCaractersEspeciais;
begin
  CheckEquals('TesteACBr12345', OnlyAlphaNum('T!e@s#t$e%A&C*B(r)1_2-3=4+5"'));
end;

{ OnlyAlphaTest }

procedure OnlyAlphaTest.Texto;
begin
  CheckEquals('TesteACBr', OnlyAlpha('TesteACBr'));
end;

procedure OnlyAlphaTest.Numeros;
begin
  CheckEquals('', OnlyAlpha('12345'));
end;

procedure OnlyAlphaTest.TextoComNumeros;
begin
   CheckEquals('TesteACBr', OnlyAlpha('TesteACBr12345'));
end;

procedure OnlyAlphaTest.TextoComCaractersEspeciais;
begin
   CheckEquals('TesteACBr', OnlyAlpha('T!e@s#t$e%A&C*B(r)'));
end;

{ OnlyNumberTest }

procedure OnlyNumberTest.Texto;
begin
   CheckEquals('', OnlyNumber('TesteACBr'));
end;

procedure OnlyNumberTest.Numeros;
begin
   CheckEquals('12345', OnlyNumber('12345'));
end;

procedure OnlyNumberTest.TextoComNumeros;
begin
   CheckEquals('12345', OnlyNumber('TesteACBr12345'));
end;

procedure OnlyNumberTest.TextoComCaractersEspeciais;
begin
  CheckEquals('12345', OnlyNumber('!1@2#34$5%'));
end;

{ CharIsNumTest }

procedure CharIsNumTest.Caracter;
begin
  CheckFalse(CharIsNum('A'));
end;

procedure CharIsNumTest.Numero;
begin
  CheckTrue(CharIsNum('1'));
end;

procedure CharIsNumTest.CaracterEspecial;
begin
  CheckFalse(CharIsNum('#'));
end;

{ CharIsAlphaNumTest }

procedure CharIsAlphaNumTest.Caracter;
begin
  CheckTrue(CharIsAlphaNum('A'));
end;

procedure CharIsAlphaNumTest.Numero;
begin
  CheckTrue(CharIsAlphaNum('1'));
end;

procedure CharIsAlphaNumTest.CaracterEspecial;
begin
  CheckFalse(CharIsAlphaNum('#'));
end;

{ CharIsAlphaTest }

procedure CharIsAlphaTest.Caracter;
begin
  CheckTrue(CharIsAlpha('A'));
end;

procedure CharIsAlphaTest.Numero;
begin
  CheckFalse(CharIsAlpha('1'));
end;

procedure CharIsAlphaTest.CaracterEspecial;
begin
  CheckFalse(CharIsAlpha('#'));
end;


{ StrIsNumberTest }

procedure StrIsNumberTest.Texto;
begin
  CheckFalse(StrIsNumber('TesteACBrUtil'));
end;

procedure StrIsNumberTest.Numeros;
begin
  CheckTrue(StrIsNumber('0123456789'));
end;

procedure StrIsNumberTest.TextoComNumeros;
begin
   CheckFalse(StrIsNumber('TesteACBrUtil1234'));
end;

procedure StrIsNumberTest.TextoComCaractersEspeciais;
begin
   CheckFalse(StrIsNumber('_%#$@$*&!""'));
end;


{ StrIsAlphaNumTest }

procedure StrIsAlphaNumTest.Texto;
begin
  CheckTrue(StrIsAlphaNum('TesteACBrUtil'));
end;

procedure StrIsAlphaNumTest.TextoComNumeros;
begin
  CheckTrue(StrIsAlphaNum('TesteACBrUtil1234'));
end;

procedure StrIsAlphaNumTest.TextoComCaractersEspeciais;
begin
  CheckFalse(StrIsAlphaNum('_%#$@$*&!""'));
end;

procedure StrIsAlphaNumTest.TextoComCaractersAcentuados;
begin
  CheckFalse(StrIsAlphaNum('TesteACBrÃštil'));
end;

{ StrIsAlphaTest }

procedure StrIsAlphaTest.Texto;
begin
  CheckTrue(StrIsAlpha('TesteACBrUtil'));
end;

procedure StrIsAlphaTest.TextoComNumeros;
begin
  CheckFalse(StrIsAlpha('TesteACBrUtil1234'));
end;

procedure StrIsAlphaTest.TextoComCaractersEspeciais;
begin
  CheckFalse(StrIsAlpha('_%#$@$*&!""'));
end;

procedure StrIsAlphaTest.TextoComCaractersAcentuados;
begin
  CheckFalse(StrIsAlpha('TesteACBrÃštil'));
end;

{ DTtoSTest }

procedure DTtoSTest.DataEHora;
var
  Date: TDateTime;
begin
  Date := StrToDateTime('14/01/2015 12:51:49');
  CheckEquals('20150114125149', DTtoS(Date));;
end;

procedure DTtoSTest.DataSemHora;
var
  Date: TDateTime;
begin
  Date := StrToDate('14/01/2015');
  CheckEquals('20150114000000', DTtoS(Date));
end;

{ DtoSTest }

procedure DtoSTest.Data;
var
  Date: TDateTime;
begin
  Date := StrToDate('14/01/2015');
  CheckEquals('20150114', DtoS(Date));
end;

{ StoDTest }

procedure StoDTest.Normal;
var
  Date: TDateTime;
begin
  Date := StrToDateTime('14/01/2015 16:28:12');
  CheckEquals(Date, StoD('20150114162812'));
end;

procedure StoDTest.DataInvalida;
begin
  CheckEquals(0, StoD('DataInvalida'));
end;

{ StringToDateTimeDefTest }

procedure StringToDateTimeDefTest.Data;
var
  Date: TDateTime;
begin
  Date := StrToDate('01/01/2015');
  CheckEquals(Date, StringToDateTimeDef('01/01/2015', Date));
end;

procedure StringToDateTimeDefTest.Hora;
var
  Date: TDateTime;
begin
  Date := StrToTime('12:45:12');
  CheckEquals(Date, StringToDateTimeDef('12:45:12', Date));
end;

procedure StringToDateTimeDefTest.DataEHora;
var
  Date: TDateTime;
begin
  Date := StrToDateTime('14/01/2015 12:45:12');
  CheckEquals(Date, StringToDateTimeDef('14/01/2015 12:45:12', Date));
end;

procedure StringToDateTimeDefTest.ValorDefault;
var
  Date: TDateTime;
begin
  Date := StrToDateTime('14/01/2015 12:45:12');
  CheckEquals(Date, StringToDateTimeDef('01-01-2001 00:01:12', Date));
end;

{ StringToDateTimeTest }

procedure StringToDateTimeTest.Data;
var
  Date: TDateTime;
begin
  Date := StrToDate('01/01/2015');
  CheckEquals(Date, StringToDateTime('01/01/2015'));
end;

procedure StringToDateTimeTest.Hora;
var
  Date: TDateTime;
begin
  Date := StrToTime('12:45:12');
  CheckEquals(Date, StringToDateTime('12:45:12'));
end;

procedure StringToDateTimeTest.DataEHora;
var
  Date: TDateTime;
begin
  Date := StrToDateTime('14/01/2015 12:45:12');
  CheckEquals(Date, StringToDateTime('14/01/2015 12:45:12'));
end;

{ StringToFloatDefTest }

procedure StringToFloatDefTest.Normal;
//var
//  t: Double;
begin
  CheckTrue(SameValue(123.45, StringToFloatDef('123,45', 10.00), 1));
  CheckTrue(SameValue(123.45, StringToFloatDef('123,45', 10.00), 0.1));
  CheckTrue(SameValue(123.45, StringToFloatDef('123,45', 10.00), 0.01));
  CheckTrue(SameValue(123.45, StringToFloatDef('123,45', 10.00), 0.001));
  CheckTrue(SameValue(123.45, StringToFloatDef('123,45', 10.00), 0.0001));
  CheckTrue(SameValue(123.45, StringToFloatDef('123,45', 10.00), 0.00001));
  CheckTrue(SameValue(123.45, StringToFloatDef('123,45', 10.00), 0.000001));
  CheckTrue(SameValue(123.45, StringToFloatDef('123,45', 10.00), 0.0000001));
  CheckTrue(SameValue(123.45, StringToFloatDef('123,45', 10.00), 0.00000000001));
//  t:= 123.45;
//  CheckEquals(t, StringToFloatDef('123,45', 10.00));
end;

procedure StringToFloatDefTest.ValorDefault;
begin
  CheckEquals(123.45, StringToFloatDef('ewerwt', 123.45));
end;

{ StringToFloatTest }

procedure StringToFloatTest.Normal;
begin
  CheckEquals(123.45, StringToFloat('123,45'));
end;


{ FloatToStringTest }

procedure FloatToStringTest.Normal;
begin
  CheckEquals('115.89', FloatToString(115.89));
end;

procedure FloatToStringTest.ComDecimaisZerados;
begin
  CheckEquals('115', FloatToString(115.00));
end;

{ FloatToIntStrTest }

procedure FloatToIntStrTest.Normal;
begin
  CheckEquals('12345', FloatToIntStr(123.45));
end;

procedure FloatToIntStrTest.ValorSemDecimais;
begin
  CheckEquals('1234500', FloatToIntStr(12345));
end;

procedure FloatToIntStrTest.MudandoPadraoDeDecimais;
begin
  CheckEquals('12345000', FloatToIntStr(123.45, 5));
end;

procedure FloatToIntStrTest.EnviandoDecimaisDiferenteDoPadrao;
begin
  CheckEquals('12345', FloatToIntStr(123.453));
end;

{ IntToStrZeroTest }

procedure IntToStrZeroTest.AdicionarZerosAoNumero;
begin
  CheckEquals('0000000123', IntToStrZero(123, 10));
end;

procedure IntToStrZeroTest.TamanhoMenorQueLimite;
begin
  CheckEquals('98', IntToStrZero(987, 2));
end;

{ Poem_ZerosTest }

procedure Poem_ZerosTest.ColocarZeros;
begin
  CheckEquals('000000TesteACBr', Poem_Zeros('TesteACBr', 15));
  CheckEquals('000000000000000', Poem_Zeros('         ', 15));
end;

{ IfEmptyThenTest }

procedure IfEmptyThenTest.RetornarValorNormal;
begin
  CheckEquals('ACBrTeste', IfEmptyThen('ACBrTeste', 'ValorPadrao'));
end;

procedure IfEmptyThenTest.SeVazioRetornaValorPadrao;
begin
  CheckEquals('ValorPadrao', IfEmptyThen('', 'ValorPadrao'));
end;

procedure IfEmptyThenTest.RealizarDoTrim;
begin
  CheckEquals('ValorPadrao', IfEmptyThen('      ', 'ValorPadrao', true));
  CheckEquals('ValorPadrao', IfEmptyThen('      ', 'ValorPadrao'));
end;

procedure IfEmptyThenTest.NaoRealizarDoTrim;
begin
  CheckEquals('ACBrTeste  ', IfEmptyThen('ACBrTeste  ', 'ValorPadrao', false));
end;

{ CompareVersionsTest }

procedure CompareVersionsTest.VersaoIgual;
begin
   CheckEquals(0, CompareVersions('1.3.1' , '1.3.1'));
end;

procedure CompareVersionsTest.VersaoMaior;
begin
   CheckEquals(11, CompareVersions('1.3.4' , '1.2.1'));
end;

procedure CompareVersionsTest.VersaoMenor;
begin
   CheckEquals(-11, CompareVersions('1.2.1' , '1.3.4'));
end;

procedure CompareVersionsTest.TrocarDelimitador;
begin
   CheckEquals(-109, CompareVersions('1-4-9', '3-8-7', '-'));
end;

{ StripHTMLTest }


procedure StripHTMLTest.TesteSimples;
begin
  CheckEquals('Teste string em html', StripHTML('<br><b>Teste string em html</b><br>'));
end;

procedure StripHTMLTest.TesteCompleto;
begin
  CheckEquals('FPCUnit de TestesACBrUtil, Testes Unitários', StripHTML('<!DOCTYPE html>'
                           +'<html>'
                               +'<head>'
                                   +'FPCUnit de Testes'
                               +'</head>'
                               +'<body>'
                                   +'ACBrUtil, Testes Unitários'
                               +'</body>'
                           +'</html>'));
end;

{ RemoveStringsTest }

procedure RemoveStringsTest.SetUp;
begin
  StringsToRemove[1] := 'a';
  StringsToRemove[2] := 'b';
  StringsToRemove[3] := 'c';
  StringsToRemove[4] := 'te';
  StringsToRemove[5] := 'AC';
end;

procedure RemoveStringsTest.TextoSimples;
begin
  CheckEquals('s', RemoveStrings('testeabc', StringsToRemove));
end;

procedure RemoveStringsTest.TextoLongo;
begin
  CheckEquals('Tes Unitrio BrUtil ', RemoveStrings('Teste Unitario ACBrUtil ', StringsToRemove));
end;

{ RemoveStringTest }

procedure RemoveStringTest.Remover;
begin
  CheckEquals('TstACBr', RemoveString('e', 'TesteACBr'));
  CheckEquals('#####', RemoveString('ACBr', '#ACBr#ACBr#ACBr#ACBr#'));
end;

{ RemoverEspacosDuplosTest }

procedure RemoverEspacosDuplosTest.RemoverApenasEspacosDuplos;
begin
  CheckEquals('Teste ACBr', RemoverEspacosDuplos('  Teste  ACBr  '));
end;

procedure RemoverEspacosDuplosTest.RemoverMaisQueDoisEspacos;
begin
  CheckEquals('Teste ACBr Com FPCUnit', RemoverEspacosDuplos('Teste    ACBr Com  FPCUnit     '));
end;

{ padSTest }

procedure padSTest.CompletarString;
begin
  CheckEquals('TesteACBrZZZZZZ', padS('TesteACBr', 15, '|', 'Z'));
  CheckEquals('TesteACBr      ', padS('TesteACBr', 15, '|'));
end;

procedure padSTest.TruncarString;
begin
  CheckEquals('TesteACBr', padS('TesteACBrZZZZZZ', 9, '|'));
end;

procedure padSTest.SubstituirSeparadorPorEspacos;
begin
  CheckEquals(' Teste Unitario ACBr ', padS('|Teste|Unitario|ACBr|', 21, '|'));
  CheckEquals('   Teste   Unitario   ACBr    ', padS('|Teste|Unitario|ACBr|', 30, '|'));
end;

procedure padSTest.SubstituirSeparadorPorCaracter;
begin
  CheckEquals('ZTesteZUnitarioZACBrZ', padS('|Teste|Unitario|ACBr|', 21, '|', 'Z'));
  CheckEquals('ZZZTesteZZZUnitarioZZZACBrZZZZ', padS('|Teste|Unitario|ACBr|', 30, '|', 'Z'));
end;

{ padCTest }

procedure padCTest.PreencherString;
begin
  CheckEquals('ZZZTESTEZZZZ', padC('TESTE', 12, 'Z'));
  CheckEquals('ZZZZTESTEZZZZ', padC('TESTE', 13, 'Z'));
  CheckEquals('    TESTE    ', padC('TESTE', 13));
end;

procedure padCTest.TruncarString;
begin
  CheckEquals('TesteACBr', padC('TesteACBrUtil', 9));
end;

{ padRTest }

procedure padRTest.CompletarString;
begin
  CheckEquals('ZZZACBrCompletaString', padR('ACBrCompletaString', 21, 'Z'));
  CheckEquals('   ACBrCompletaString', padR('ACBrCompletaString', 21));
end;

procedure padRTest.ManterString;
begin
  CheckEquals('ACBrMantemString', padR('ACBrMantemString', 16, 'Z'));
end;

procedure padRTest.TruncarString;
begin
  CheckEquals('TruncaString', padR('ACBrTruncaString', 12, 'Z'));
end;

{ padLTest }

procedure padLTest.CompletarString;
begin
  CheckEquals('ACBrCompletaStringZZZ', padL('ACBrCompletaString', 21, 'Z'));
  CheckEquals('ACBrCompletaString   ', padL('ACBrCompletaString', 21));
end;

procedure padLTest.ManterString;
begin
  CheckEquals('ACBrMantemString', padL('ACBrMantemString', 16, 'Z'));
end;

procedure padLTest.TruncarString;
begin
  CheckEquals('ACBrTrunca', padL('ACBrTruncaString', 10, 'Z'));
end;

{ SepararDadosTest }

procedure SepararDadosTest.Simples;
begin
  CheckEquals('Teste Simples', SeparaDados('<ACBr>Teste Simples</ACBr>', 'ACBr'));
  CheckEquals('Teste     Simples', SeparaDados('<ACBr>Teste     Simples</ACBr>', 'ACBr'));
  CheckEquals('TesteSimples', SeparaDados('<ACBr>TesteSimples</ACBr>', 'ACBr'));
end;

procedure SepararDadosTest.TextoLongo;
begin
  CheckEquals('ACBr Util', SeparaDados('<ACBrUtil>Teste com texto longo <b>ACBr Util</b> feito por DJSystem</ACBrUtil>', 'b'));
  CheckEquals('#ACBrUtil', SeparaDados('<ACBrUtil>Teste com texto longo <b>#ACBrUtil</b> feito por DJSystem</ACBrUtil>', 'b'));
end;

procedure SepararDadosTest.MostrarChave;
begin
  CheckEquals('<ACBr>Teste Simples</ACBr>', SeparaDados('<ACBr>Teste Simples</ACBr>', 'ACBr',  true));
  CheckEquals('<ACBrTeste>Teste     Simples</ACBrTeste>', SeparaDados('<ACBrTeste>Teste     Simples</ACBrTeste>', 'ACBrTeste', true));
  CheckEquals('<ACBr>TesteSimples</ACBr>', SeparaDados('<ACBr>TesteSimples</ACBr>', 'ACBr', true));
  CheckEquals('<b>ACBr Util</b>', SeparaDados('<ACBrUtil>Teste com texto longo <b>ACBr Util</b> feito por DJSystem', 'b', true));
  CheckEquals('<u>#ACBrUtil</u>', SeparaDados('<ACBrUtil>Teste com texto longo <u>#ACBrUtil</u> feito por DJSystem', 'u', true));
end;

procedure SepararDadosTest.ComVariasChaves;
begin
  CheckEquals('ACBrUtil', SeparaDados('<ACBr>Teste <ACBrTeste>ACBrUtil</ACBrTeste> com <ACBrTeste>FPCUnit</ACBrTeste></ACBr>', 'ACBrTeste'));
end;

procedure SepararDadosTest.SemFecharChave;
begin
  CheckEquals('', SeparaDados('<ACBrUtil>Teste com texto longo <b>ACBr Util</b> realizado por FPCUnit', 'ACBrUtil'));
end;

procedure SepararDadosTest.SemAbrirChave;
begin
  CheckEquals('', SeparaDados('Teste com texto longo <b>ACBr Util</b> realizado por FPCUnit</ACBrUtil>', 'ACBrUtil'));
end;

{ LerTagXMLTest }

procedure LerTagXMLTest.Simples;
begin
  CheckEquals('Teste Simples', LerTagXML('<ACBr>Teste Simples</ACBr>', 'acbr'));
end;

procedure LerTagXMLTest.SemIgnorarCase;
begin
  CheckEquals('Teste sem ignorar case', LerTagXML('<ACBr>Teste sem ignorar case</ACBr>', 'ACBr', false));
  CheckEquals('', LerTagXML('<ACBr>Teste sem ignorar case</ACBr>', 'acbr', false));
  CheckEquals('Ler Aqui', LerTagXML('<ACBr>Teste sem <acbr>Ler Aqui</acbr> ignorar case</ACBr>', 'acbr', false));
end;

procedure LerTagXMLTest.ComVariasTags;
begin
  CheckEquals('mais um teste', LerTagXML('<ACBr> teste <br> outro teste </br> <b>mais um teste</b> </ACBr>', 'b'));
end;

{ ParseTextTest }

procedure ParseTextTest.VerificarConversao;
begin
  CheckEquals('&', ParseText('&amp;'));
  CheckEquals('<', ParseText('&lt;'));
  CheckEquals('>', ParseText('&gt;'));
  CheckEquals('"', ParseText('&quot;'));
  CheckEquals(#39, ParseText('&#39;'));
  CheckEquals('á', ParseText('&aacute;', True, False));
  CheckEquals('Á', ParseText('&Aacute;', True, False));
  CheckEquals('â', ParseText('&acirc;',  True, False));
  CheckEquals('Â', ParseText('&Acirc;',  True, False));
  CheckEquals('ã', ParseText('&atilde;', True, False));
  CheckEquals('Ã', ParseText('&Atilde;', True, False));
  CheckEquals('à', ParseText('&agrave;', True, False));
  CheckEquals('À', ParseText('&Agrave;', True, False));
  CheckEquals('é', ParseText('&eacute;', True, False));
  CheckEquals('É', ParseText('&Eacute;', True, False));
  CheckEquals('ê', ParseText('&ecirc;',  True, False));
  CheckEquals('Ê', ParseText('&Ecirc;',  True, False));
  CheckEquals('í', ParseText('&iacute;', True, False));
  CheckEquals('Í', ParseText('&Iacute;', True, False));
  CheckEquals('ó', ParseText('&oacute;', True, False));
  CheckEquals('Ó', ParseText('&Oacute;', True, False));
  CheckEquals('õ', ParseText('&otilde;', True, False));
  CheckEquals('Õ', ParseText('&Otilde;', True, False));
  CheckEquals('ô', ParseText('&ocirc;',  True, False));
  CheckEquals('Ô', ParseText('&Ocirc;',  True, False));
  CheckEquals('ú', ParseText('&uacute;', True, False));
  CheckEquals('Ú', ParseText('&Uacute;', True, False));
  CheckEquals('ü', ParseText('&uuml;',   True, False));
  CheckEquals('Ü', ParseText('&Uuml;',   True, False));
  CheckEquals('ç', ParseText('&ccedil;', True, False));
  CheckEquals('Ç', ParseText('&Ccedil;', True, False));
  CheckEquals('''', ParseText('&apos;',  True, False));
end;

procedure ParseTextTest.VerificarConversaoTextoLongo;
begin
  CheckEquals('&<>"', ParseText('&amp;&lt;&gt;&quot;'));
  CheckEquals('&"<>', ParseText('&amp;&quot;&lt;&gt;'));
  CheckEquals('<&">', ParseText('&lt;&amp;&quot;&gt;'));
  CheckEquals(#39'áÃÇÜÉÊÕ''', ParseText('&#39;&aacute;&Atilde;&Ccedil;&Uuml;'
              + '&Eacute;&Ecirc;&Otilde;&apos;', True, False));
end;


initialization

  RegisterTest('ACBrComum.ACBrUtil', ParseTextTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', LerTagXMLTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', SepararDadosTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', padLTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', padRTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', padCTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', padSTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', RemoverEspacosDuplosTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', RemoveStringTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', RemoveStringsTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StripHTMLTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', CompareVersionsTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', IfEmptyThenTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', Poem_ZerosTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', IntToStrZeroTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', FloatToIntStrTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', FloatToStringTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StringToFloatTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StringToFloatDefTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StringToDateTimeTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StringToDateTimeDefTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StoDTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', DtoSTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', DTtoSTest{$ifndef FPC}.suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StrIsAlphaTest{$ifndef FPC}.suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StrIsAlphaNumTest{$ifndef FPC}.suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StrIsNumberTest{$ifndef FPC}.suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', CharIsAlphaTest{$ifndef FPC}.suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', CharIsAlphaNumTest{$ifndef FPC}.suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', CharIsNumTest{$ifndef FPC}.suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', OnlyNumberTest{$ifndef FPC}.suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', OnlyAlphaTest{$ifndef FPC}.suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', OnlyAlphaNumTest{$ifndef FPC}.suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StrIsIPTest{$ifndef FPC}.suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', TiraAcentosTest{$ifndef FPC}.suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', TiraAcentoTest{$ifndef FPC}.suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', TiraPontosTest{$ifndef FPC}.suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', EAN13Test{$ifndef FPC}.suite{$endif});
end.

