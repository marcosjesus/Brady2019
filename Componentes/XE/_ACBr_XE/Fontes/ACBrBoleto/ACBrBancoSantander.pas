{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:   Juliana Rodrigues Prado                       }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrBancoSantander;

interface

uses
  Classes, SysUtils,ACBrBoleto,
  {$IFDEF COMPILER6_UP} dateutils {$ELSE} ACBrD5 {$ENDIF};

type

  { TACBrBancoSantander }

  TACBrBancoSantander = class(TACBrBancoClass)
  private
  protected
    vTotalTitulos : Double;
  public
    Constructor create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo:TACBrTitulo): String; override;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
    function MontarCampoNossoNumero(const ACBrTitulo :TACBrTitulo): String; override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String; override;
    function GerarRegistroHeader240(NumeroRemessa: Integer): String; override;
    function GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler240(ARemessa : TStringList): String;  override;
    procedure GerarRegistroHeader400(NumeroRemessa : Integer; aRemessa: TStringList); override;
    procedure GerarRegistroTransacao400(ACBrTitulo : TACBrTitulo; aRemessa: TStringList); override;
    procedure GerarRegistroTrailler400(ARemessa:TStringList);  override;
    Procedure LerRetorno240(ARetorno:TStringList); override;
    Procedure LerRetorno400(ARetorno:TStringList); override;

    function TipoOcorrenciaToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia) : String; override;
    function CodOcorrenciaToTipo(const CodOcorrencia:Integer): TACBrTipoOcorrencia; override;
    function TipoOCorrenciaToCod(const TipoOcorrencia: TACBrTipoOcorrencia):String; override;
    function CodMotivoRejeicaoToDescricao(const TipoOcorrencia:TACBrTipoOcorrencia; CodMotivo:Integer): String; override;
  end;

implementation

uses ACBrUtil, StrUtils, math;

{ TACBrBancoSantander }

constructor TACBrBancoSantander.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 7;
   fpNome   := 'Santander';
   fpNumero:= 033;
   fpTamanhoMaximoNossoNum := 12;
   fpTamanhoCarteira:= 3;
   fpTamanhoConta := 11;
end;

function TACBrBancoSantander.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
begin
   Modulo.CalculoPadrao;
   Modulo.MultiplicadorFinal := 9;
   Modulo.Documento := ACBrTitulo.NossoNumero;
   Modulo.Calcular;

   Result:= IntToStr(Modulo.DigitoFinal);
end;

function TACBrBancoSantander.MontarCodigoBarras ( const ACBrTitulo: TACBrTitulo) : String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras, DigitoNossoNumero:String;
begin

   with ACBrTitulo.ACBrBoleto do
   begin
      DigitoNossoNumero := CalcularDigitoVerificador(ACBrTitulo);
      FatorVencimento   := CalcularFatorVencimento(ACBrTitulo.Vencimento);

      CodigoBarras := '033'+'9'+ FatorVencimento +
                       IntToStrZero(Round(ACBrTitulo.ValorDocumento*100),10) +
                       '9'+ padR(trim(Cedente.CodigoCedente),7,'0') +
                       padR(ACBrTitulo.NossoNumero + DigitoNossoNumero, 13,'0') +
                       '0'+ padR(trim(Cedente.Modalidade),3,'0');



      DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);
   end;

   Result:= '033' + '9'+ DigitoCodBarras + Copy(CodigoBarras,5,39);
end;

function TACBrBancoSantander.MontarCampoNossoNumero (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
   with ACBrTitulo do
   begin
      case StrToIntDef(Carteira,0) of
         5: Carteira := '101';
         6: Carteira := '201';
         4: Carteira := '102';
      end;
   end;

   Result:= padR(ACBrTitulo.NossoNumero,12,'0')+ ' '+ CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBancoSantander.MontarCampoCodigoCedente (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
   Result := ACBrTitulo.ACBrBoleto.Cedente.Agencia+'-'+
             ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito+'/'+
             ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente
end;

function TACBrBancoSantander.GerarRegistroHeader240(NumeroRemessa: Integer): String;
begin
// by J�ter Rabelo Ferreira - 06/2014
   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      { REGISTRO HEADER DO ARQUIVO REMESSA }
      Result := '033'                                      + // 001 - 003 / C�digo do Banco na compensa��o
                '0000'                                     + // 004 - 007 / Lote de servi�o
                '0'                                        + // 008 - 008 / Tipo de registro
                Space(8)                                   + // 009 - 016 / Reservado (uso Banco)
                ifthen(TipoInscricao = pFisica, '1', '2')  + // 017 - 017 / Tipo de inscri��o da empresa
                PadR(trim(OnlyNumber(CNPJCPF)),15,'0')     + // 018 - 032 / N� de inscri��o da empresa
                PadR(CodigoTransmissao, 15)                + // 033 - 047 / C�digo de Transmiss�o
                Space(25)                                  + // 048 - 072 / Reservado (uso Banco)
                padL(Nome, 30)                             + // 073 - 102 / Nome da Empresa
                padL('BANCO SANTANDER', 30)                + // 103 - 132 / Nome do Banco(BANCO SANTANDER)
                Space(10)                                  + // 133 - 142 / Reservado (uso Banco)
                '1'                                        + // 143 - 143 / C�digo remessa = 1
                FormatDateTime('ddmmyyyy',Now)             + // 144 - 151 / Data de gera��o do arquivo
                Space(6)                                   + // 152 - 157 / Reservado (uso Banco)
                padR(IntToStr(NumeroRemessa), 6, '0')      + // 158 - 163 / N� seq�encial do arquivo
                '040'                                      + // 164 - 166 / N� da vers�o do layout do arquivo
                Space(74)                                  ; // 167 - 240 / Reservado (uso Banco)

      { REGISTRO HEADER DO LOTE REMESSA }
      Result := Result + #13#10 +
                '033'                                      + // 001 - 003 / C�digo do Banco na compensa��o
                '0001'                                     + // 004 - 007 / Numero do lote remessa
                '1'                                        + // 008 - 008 / Tipo de registro
                'R'                                        + // 009 - 009 / Tipo de opera��o
                '01'                                       + // 010 - 011 / Tipo de servi�o
                Space(2)                                   + // 012 - 013 / Reservado (uso Banco)
                '030'                                      + // 014 - 016 / N� da vers�o do layout do lote
                Space(1)                                   + // 017 - 017 / Reservado (uso Banco)
                ifthen(TipoInscricao = pFisica, '1', '2')  + // 018 - 018 / Tipo de inscri��o da empresa
                PadR(trim(OnlyNumber(CNPJCPF)),15,'0')     + // 019 - 033 / N� de inscri��o da empresa
                Space(20)                                  + // 034 - 053 / Reservado (uso Banco)
                PadR(CodigoTransmissao, 15)                + // 054 - 068 / C�digo de Transmiss�o
                Space(5)                                   + // 069 - 073 / Reservado (uso Banco)
                padL(Nome, 30)                             + // 074 - 0103 / Nome do Cedente
                Space(40)                                  + // 104 - 143 / Mensagem 1
                Space(40)                                  + // 144 - 183 / Mensagem 2
                padR(IntToStr(NumeroRemessa), 8, '0')      + // 184 - 191 / N� temessa
                FormatDateTime('ddmmyyyy',Now)             + // 192 - 199 / Data de gera��o do arquivo
                Space(41)                                  ; // 200 - 240 / Reservado (uso Banco)

      Result := UpperCase(Result);
   end;
end;

procedure TACBrBancoSantander.GerarRegistroHeader400(NumeroRemessa : Integer; aRemessa: TStringList);
var
  wLinha: String;
begin
   vTotalTitulos:= 0;
   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      wLinha:= '0'                                        + // ID do Registro
               '1'                                        + // ID do Arquivo( 1 - Remessa)
               'REMESSA'                                  + // Literal de Remessa
               '01'                                       + // C�digo do Tipo de Servi�o
               padL( 'COBRANCA', 15 )                     + // Descri��o do tipo de servi�o
               padR( CodigoTransmissao, 20, '0')          + // Codigo da Empresa no Banco
               padL( Nome, 30)                            + // Nome da Empresa
               '033'+ padL('SANTANDER', 15)               + // C�digo e Nome do Banco(237 - Bradesco)
               FormatDateTime('ddmmyy',Now)               + // Data de gera��o do arquivo + brancos
               StringOfChar( '0', 16)                     +
               Space(275)+ '000'                          + // Nr. Sequencial de Remessa + brancos
               IntToStrZero(1,6);                           // Nr. Sequencial de Remessa + brancos + Contador

      aRemessa.Text:= aRemessa.Text + UpperCase(wLinha);
   end;
end;

function TACBrBancoSantander.GerarRegistroTransacao240(ACBrTitulo: TACBrTitulo): String;
var
  ISequencia: Integer;
  iCarteira: Integer;
  sCodMovimento, sAgencia, sCCorrente: string;
  sDigitoNossoNumero, sTipoCobranca, sTipoDocto, sTipoCarteira: string;
  sEspecie, sDataMoraJuros, sDataDesconto: string;
  STipoJuros, sTipoDesconto, sDiasProtesto: string;
  sTipoInscricao, sEndereco, sMensagem: string;
  aTipoInscricao: Char;
  function MontarInstrucoes1: string;
  begin
    with ACBrTitulo do
    begin
      if Mensagem.Count = 0 then
      begin
        Result := padL('', 80, ' '); // 2 registros
        Exit;
      end;

      Result := '';
      if Mensagem.Count >= 1 then
      begin
        Result := Result +
                  Copy(padL(Mensagem[0], 40, ' '), 1, 40);
      end;

      if Mensagem.Count >= 2 then
      begin
        Result := Result +
                  Copy(padL(Mensagem[1], 40, ' '), 1, 40)
      end
      else
      begin
        if (Result <> EmptyStr) then
          Result := Result + padL('', 40, ' ')  // 1 registro
        else
          Result := Result + padL('', 80, ' '); // 2 registros
        Exit;
      end;
    end;
  end;

  function MontarInstrucoes2: string;
  begin
    with ACBrTitulo do
    begin
      if Mensagem.Count <= 2 then
      begin
        // Somente duas linhas, foi montado o MonarInstrucoes1
        Result := padL('', 200, ' '); // 5 registros
        Exit;
      end;

      Result := '';
      if Mensagem.Count >= 3 then
      begin
        Result := Copy(padL(Mensagem[2], 40, ' '), 1, 40);
      end;

      if Mensagem.Count >= 4 then
      begin
        Result := Result +
                  Copy(padL(Mensagem[3], 40, ' '), 1, 40)
      end;

      if Mensagem.Count >= 5 then
      begin
        Result := Result +
                  Copy(padL(Mensagem[4], 40, ' '), 1, 40)
      end;

      if Mensagem.Count >= 6 then
      begin
        Result := Result +
                  Copy(padL(Mensagem[5], 40, ' '), 1, 40)
      end;

      if Mensagem.Count >= 7 then
      begin
        Result := Result +
                  Copy(padL(Mensagem[6], 40, ' '), 1, 40)
      end;

      // Acertar a quantidade de caracteres
      Result := padL(Result, 200);
    end;
  end;

begin
// by J�ter Rabelo Ferreira - 06/2014
  with ACBrTitulo do
  begin
    case OcorrenciaOriginal.Tipo of
       toRemessaBaixar                        : sCodMovimento := '02'; {Pedido de Baixa}
       toRemessaConcederAbatimento            : sCodMovimento := '04'; {Concess�o de Abatimento}
       toRemessaCancelarAbatimento            : sCodMovimento := '05'; {Cancelamento de Abatimento concedido}
       toRemessaAlterarVencimento             : sCodMovimento := '06'; {Altera��o de vencimento}
       toRemessaAlterarControleParticipante   : sCodMovimento := '07'; {Altera��o N�mero Controle Cedente}
       toRemessaAlterarNumeroControle         : sCodMovimento := '08'; {Altera��o de seu n�mero}
       toRemessaProtestar                     : sCodMovimento := '09'; {Pedido de protesto}
       toRemessaCancelarInstrucaoProtesto     : sCodMovimento := '18'; {Sustar protesto e manter na carteira}
       toRemessaConcederDesconto              : sCodMovimento := '10'; {Concess�o de Desconto}
       toRemessaCancelarDesconto              : sCodMovimento := '11'; {Cancelamento de Desconto}
       toRemessaNaoProtestar                  : sCodMovimento := '98'; {N�o Protestar (Antes de iniciar o ciclo de protesto )}
    else
       sCodMovimento := '01';                                          {Remessa}
    end;

    iCarteira := StrToIntDef(ACBrTitulo.Carteira, 0 );

    sAgencia := padR(OnlyNumber(ACBrTitulo.ACBrBoleto.Cedente.Agencia) +
                        ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito,5,'0');

    // Tamanho da conta corrente definida como padr�o de 11 digitos, por�m no arquivo
    // remessa a conta solicitada � de 8 d�gitos.
    // Devemos retirar os zeros a esquerda da conta

    sCCorrente := OnlyNumber(ACBrTitulo.ACBrBoleto.Cedente.Conta);
    sCCorrente := Copy(SCCorrente, Length(sCCorrente) - 8, 9) +
                  OnlyNumber(ACBrTitulo.ACBrBoleto.Cedente.ContaDigito);

    sDigitoNossoNumero := CalcularDigitoVerificador(ACBrTitulo);

    case CaracTitulo of
      tcSimples     : sTipoCobranca  := '1'; {Cobran�a Simples (Sem Registro e Eletr�nica com Registro)}
      tcCaucionada  : sTipoCobranca  := '3'; {Cobran�a Caucionada (Eletr�nica com Registro e Convencional com Registro)}
      tcDescontada  : sTipoCobranca  := '4'; {Cobran�a Descontada (Eletr�nica com Registro)}
      tcVinculada   : sTipoCobranca  := '5'; {Cobran�a Simples (R�pida com Registro)}
      { TODO :
          6 = Cobran�a Caucionada (R�pida com Registro)
          8 = Cobranca Cessao (Eletronica com Registro)
      }
    end;

    case ACBrBoleto.Cedente.TipoCarteira of
      tctSimples: sTipoCarteira := '2';
      tctRegistrada: sTipoCarteira := '1';
      else 
       sTipoCarteira := '2';
    end;

    case ACBrBoleto.Cedente.TipoDocumento of
      Tradicional: sTipoDocto := '1';
      Escritural: sTipoDocto := '2';
    end;

    if sTipoDocto = '' then
      sTipoDocto := '1'; // Tradicional

    if Trim(EspecieDoc) = 'DM' then      {DM - DUPLICATA MERCANTIL}
      sEspecie := '02'
    else if Trim(EspecieDoc) = 'DS' then {DS - DUPLICATA DE SERVICO}
      sEspecie := '04'
    else if Trim(EspecieDoc) = 'NP' then {NP - NOTA PROMISSORIA}
      sEspecie := '12'
    else if Trim(EspecieDoc) = 'NR' then {NR - NOTA PROMISSORIA RURAL}
      sEspecie := '13'
    else if Trim(EspecieDoc) = 'RC' then {RC - RECIBO}
      sEspecie := '17'
    else if Trim(EspecieDoc) = 'AP' then {AP � APOLICE DE SEGURO}
      sEspecie := '20'
    else if Trim(EspecieDoc) = 'CH' then {CH - CHEQUE}
      sEspecie := '97'
    else if Trim(EspecieDoc) = 'CH' then {ND - NOTA PROMISSORIA DIRETA}
      sEspecie := '98'
    else
    begin
      if not MatchText(EspecieDoc, ['02', '04', '12', '13', '17', '20', '97', '98']) then
        raise Exception.Create('Esp�cie de documento informada incorretamente!');

      sEspecie := EspecieDoc;
    end;

    if (ValorMoraJuros > 0) then
    begin
      STipoJuros := '1';  // Valor por dia
//      STipoJuros := '2';  // Taxa Mensal
      if DataMoraJuros <> 0 then
        sDataMoraJuros := FormatDateTime('ddmmyyyy', DataMoraJuros)
      else
        sDataMoraJuros := padR('', 8, '0');
    end
    else
    begin
      sDataMoraJuros := padR('', 8, '0');
      STipoJuros := '3'; // Isento
    end;

    if ValorDesconto > 0 then
    begin
      sTipoDesconto := '1'; // Valor fixo ate a data informada � Informar o valor no campo �valor de desconto a ser concedido�.
      if DataDesconto <> 0 then
      begin
        sDataDesconto := FormatDateTime('ddmmyyyy', DataDesconto);
        sTipoDesconto := '2';
      end
      else
      begin
        sTipoDesconto := '0'; // ISENTO
        sDataDesconto := padR('', 8, '0');
      end;
    end
    else
    begin
      sTipoDesconto := '0'; // ISENTO
      sDataDesconto := padR('', 8, '0');
    end;

    {Instru��es}
    if (DataProtesto <> 0) and
       (DataProtesto > Vencimento) then
    begin
      if (Trim(Instrucao2) = '') then
        Instrucao2 := '1' // Protestar Dias Corridos
      else
      begin
        if not MatchText(Instrucao2, ['0', '1', '2', '3', '9']) then
          raise Exception.Create('C�digo de protesto informado incorretamente!');
      end;
      // Calcular os dias para protesto
      sDiasProtesto := padR(IntToStr(Trunc(DataProtesto) - Trunc(Vencimento)), 2, '0');
    end
    else
    begin
      Instrucao1 := '0';  // N�o protestar
      SDiasProtesto := '00';
    end;

    // Baixa/Devolu��o
    if Instrucao2 = '' then
      Instrucao2 := '2' // NAO BAIXAR / NAO DEVOLVER
    else
    begin
      if not MatchText(Instrucao2, ['1', '2', '3']) then
        raise Exception.Create('C�digo de Baixa/Devolu��o informado incorretamente!');
    end;

    case Sacado.Pessoa of
       pFisica  : sTipoInscricao := '1';
       pJuridica: sTipoInscricao := '2';
       pOutras  : sTipoInscricao := '9';
    end;

    if Sacado.SacadoAvalista.CNPJCPF <> '' then
     begin
      case Sacado.SacadoAvalista.Pessoa of
        pFisica  : aTipoInscricao := '1';
        pJuridica: aTipoInscricao := '2';
        pOutras  : aTipoInscricao := '9';
      end;
     end
    else
      aTipoInscricao:= '0';


    sEndereco := padL(Sacado.Logradouro + ' ' +
                      Sacado.Numero + ' ' +
                      Sacado.Complemento , 40, ' ');

    ISequencia := (ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo) * 4) + 1;
    {SEGMENTO P}
    Result := '033'                                            + // 001 - 003 / C�digo do Banco na compensa��o
              '0001'                                           + // 004 - 007 / Numero do lote remessa
              '3'                                              + // 008 - 008 / Tipo de registro
              IntToStrZero(ISequencia ,5)                      + // 009 - 013 / N�mero seq�encial do registro no lote
              'P'                                              + // 014 - 014 / C�d. Segmento do registro detalhe
              Space(1)                                         + // 015 - 015 / Reservado (uso Banco)
              sCodMovimento                                    + // 016 - 017 / C�digo de movimento remessa
              Copy(sAgencia, 1, 4)                             + // 018 � 021 / Ag�ncia do Cedente
              Copy(sAgencia, 5, 1)                             + // 022 � 022 / D�gito da Ag�ncia do Cedente
              Copy(sCCorrente, 1, 9)                           + // 023 - 031 / da conta corrente
              Copy(sCCorrente, 10, 1)                          + // 032 � 032 / D�gito verificador da conta
              Copy(sCCorrente, 1, 9)                           + // 033 - 041 / Conta cobran�a
              Copy(sCCorrente, 10, 1)                          + // 042 - 042 / D�gito da conta cobran�a
              Space(2)                                         + // 043 - 044 / Reservado (uso Banco)
              NossoNumero + sDigitoNossoNumero                 + // 045 � 057 / Identifica��o do t�tulo no Banco (Nosso N�mero
              sTipoCobranca                                    + // 058 - 058 / Tipo de cobran�a
              sTipoCarteira                                    + // 059 - 059 / Forma de Cadastramento = 1 Registrada / 2 Sem Registro
              sTipoDocto                                       + // 060 - 060 / Tipo de documento
              Space(1)                                         + // 061 - 061 / Reservado (uso Banco)
              Space(1)                                         + // 062 - 062 / Reservado (uso Banco)
              PadL(Copy(SeuNumero, 1, 15), 15)                 + // 063 - 077 / N� do documento
              FormatDateTime('ddmmyyyy',Vencimento)            + // 078 - 085 / Data de vencimento do t�tulo
              IntToStrZero(round(ValorDocumento * 100), 15)    + // 086 - 100 / Valor nominal do t�tulo
              PadR('0', 4, '0')                                + // 101 - 104 / Ag�ncia encarregada da cobran�a
              '0'                                              + // 105 - 105 / D�gito da Ag�ncia encarregada da cobran�a
              Space(1)                                         + // 106 - 106 / Reservado (uso Banco)
              sEspecie                                         + // 107 � 108 / Esp�cie do t�tulo
              ifThen(Aceite = atSim,  'S', 'N')                + // 109 - 109 / Identif. de t�tulo Aceito/N�o Aceito
              FormatDateTime('ddmmyyyy',DataDocumento)         + // 110 - 117 / Data da emiss�o do t�tulo
              STipoJuros                                       + // 118 - 118 / C�digo do juros de mora
              sDataMoraJuros                                   + // 119 - 126 / Data do juros de mora
              IntToStrZero(round(ValorMoraJuros * 100), 15)    + // 127 - 141 / Valor da mora/dia ou Taxa mensal
              sTipoDesconto                                    + // 142 - 142 / C�digo do desconto 1
              sDataDesconto                                    + // 143 - 150 / Data de desconto 1
              IntToStrZero(round(ValorDesconto * 100), 15)     + // 151 - 165 / Valor ou Percentual do desconto concedido
              IntToStrZero(round(ValorIOF * 100), 15)          + // 166 - 180 / Valor do IOF a ser recolhido
              IntToStrZero(round(ValorAbatimento * 100), 15)   + // 181 - 195 / Valor do abatimento
              padL(NossoNumero, 25)                            + // 196 - 220 / Identifica��o do t�tulo na empresa
              Instrucao1                                       + // 221 - 221 / C�digo para protesto
              sDiasProtesto                                    + // 222 - 223 / N�mero de dias para protesto
              Instrucao2                                       + // 224 - 224 / C�digo para Baixa/Devolu��o
              '0'                                              + // 225 - 225 / Reservado (uso Banco)
              '00'                                             + // 226 - 227 / N�mero de dias para Baixa/Devolu��o
              '00'                                             + // 228 - 229 / C�digo da moeda
              Space(11)                                        ; // 230 � 240 / Reservado (uso Banco)
    {SEGMENTO P - FIM}

    Inc(ISequencia);
    {SEGMENTO Q}
    Result := Result + #13#10 +
              '033'                                            + // 001 - 003 / C�digo do Banco na compensa��o
              '0001'                                           + // 004 - 007 / Numero do lote remessa
              '3'                                              + // 008 - 008 / Tipo de registro
              IntToStrZero(ISequencia ,5)                      + // 009 - 013 / N�mero seq�encial do registro no lote
              'Q'                                              + // 014 - 014 / C�d. Segmento do registro detalhe
              Space(1)                                         + // 015 - 015 / Reservado (uso Banco)
              sCodMovimento                                    + // 016 - 017 / C�digo de movimento remessa
              sTipoInscricao                                   + // 018 - 018 / Tipo de inscri��o do sacado
              PadR(trim(OnlyNumber(Sacado.CNPJCPF)),15,'0')    + // 019 - 033 / N�mero de inscri��o do sacado
              padL(Trim(Sacado.NomeSacado), 40)                + // 034 - 073 / Nome sacado
              sEndereco                                        + // 074 - 113 / Endere�o sacado
              padL(Trim(Sacado.Bairro), 15)                    + // 114 - 128 / Bairro sacado
              padR(Copy(OnlyNumber(Sacado.CEP), 1, 5), 5, '0') + // 129 - 133 / Cep sacado
              padR(Copy(OnlyNumber(Sacado.CEP), 6, 3), 3, '0') + // 134 - 136 / Sufixo do Cep do sacado
              padL(Trim(Sacado.Cidade), 15)                    + // 137 - 151 / Cidade do sacado
              Sacado.UF                                        + // 152 - 153 / Unidade da federa��o do sacado
              aTipoInscricao                                   + // 154 - 154 / Tipo de inscri��o sacador/avalista
              padR(Sacado.SacadoAvalista.CNPJCPF, 15,'0')       + // 155 - 169 / N� de inscri��o sacador/avalista
              padL(Sacado.SacadoAvalista.NomeAvalista,40,' ')  + // 170 - 209 / Nome do sacador/avalista
              '000'                                            + // 210 � 212 / Identificador de carne
              '000'                                            + // 213 � 215 / Seq�encial da Parcela ou n�mero inicial da parcela
              '000'                                            + // 216 � 218 / Quantidade total de parcelas
              '000'                                            + // 219 � 221 / N�mero do plano
              Space(19)                                        ; // 230 � 240 / Reservado (uso Banco)
    {SEGMENTO Q - FIM}

    Inc(ISequencia);
    {SEGMENTO R}
    Result := Result + #13#10 +
              '033'                                                      + // 001 - 003 / C�digo do Banco na compensa��o
              '0001'                                                     + // 004 - 007 / Numero do lote remessa
              '3'                                                        + // 008 - 008 / Tipo de registro
              IntToStrZero(ISequencia ,5)                                + // 009 - 013 / N�mero seq�encial do registro no lote
              'R'                                                        + // 014 - 014 / C�d. Segmento do registro detalhe
              Space(1)                                                   + // 015 - 015 / Reservado (uso Banco)
              sCodMovimento                                              + // 016 - 017 / C�digo de movimento remessa
              '0'                                                        + // 018 - 018 / C�digo do desconto 2
              padR('', 8, '0')                                           + // 019 - 026 / Data do desconto 2
              IntToStrZero(0, 15)                                        + // 027 - 041 / Valor/Percentual a ser concedido
              Space(24)                                                  + // 042 � 065 / Reservado (uso Banco)
              '1'                                                        + // 066 - 066 / C�digo da multa
              padR('', 8, '0')                                           + // 067 - 074 / Data da multa
              IntToStrZero(round(ValorDocumento * PercentualMulta), 15)  + // 075 - 089 / Valor/Percentual a ser aplicado
              Space(10)                                                  + // 090 - 099 / Reservado (uso Banco)
              MontarInstrucoes1                                          + // 100 - 139 / Mensagem 3
                                                                           // 140 - 179 / Mensagem 4
              Space(61)                                                  ; // 180 - 240 / Reservado (uso Banco)
    {SEGMENTO R - FIM}

    Inc(ISequencia);
    {SEGMENTO S}
    // Existe um Formmul�rio 1 - Especial, que n�o ser� implementado
    // Ser� implementado do Formul�rio 2
    Result := Result + #13#10 +
              '033'                                            + // 001 - 003 / C�digo do Banco na compensa��o
              '0001'                                           + // 004 - 007 / Numero do lote remessa
              '3'                                              + // 008 - 008 / Tipo de registro
              IntToStrZero(ISequencia ,5)                      + // 009 - 013 / N�mero seq�encial do registro no lote
              'S'                                              + // 014 - 014 / C�d. Segmento do registro detalhe
              Space(1)                                         + // 015 - 015 / Reservado (uso Banco)
              sCodMovimento                                    + // 016 - 017 / C�digo de movimento remessa
              '2'                                              + // 018 - 018 / Identifica��o da impress�o
              MontarInstrucoes2                                + // 019 - 058 / Mensagem 5
                                                                 // 059 - 098 / Mensagem 6
                                                                 // 099 - 138 / Mensagem 7
                                                                 // 139 - 178 / Mensagem 8
                                                                 // 179 - 218 / Mensagem 9
              Space(22)                                        ; // 219 - 240 / Reservado (uso Banco)
    {SEGMENTO S - FIM}
  end;
end;

procedure TACBrBancoSantander.GerarRegistroTransacao400(ACBrTitulo :TACBrTitulo; aRemessa: TStringList);
var
  DigitoNossoNumero, Ocorrencia,aEspecie :String;
  Protesto, aAgencia, TipoSacado, wLinha :String;
  aCarteira, I: Integer;
begin

   aCarteira := StrToIntDef(ACBrTitulo.Carteira, 0 );

   if aCarteira = 101  then
      aCarteira:= 5
   else if aCarteira = 201 then
      aCarteira:= 6
   else if aCarteira = 102 then
      aCarteira:= 4;

   if aCarteira = 5 then
      aAgencia := padR(OnlyNumber(ACBrTitulo.ACBrBoleto.Cedente.Agencia) +
                       ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito,5,'0')
   else
      aAgencia:= '00000';

   vTotalTitulos:= vTotalTitulos+ ACBrTitulo.ValorDocumento;
   with ACBrTitulo do
   begin
      DigitoNossoNumero := CalcularDigitoVerificador(ACBrTitulo);

      {Pegando C�digo da Ocorrencia}
      case OcorrenciaOriginal.Tipo of
         toRemessaBaixar                        : Ocorrencia := '02'; {Pedido de Baixa}
         toRemessaConcederAbatimento            : Ocorrencia := '04'; {Concess�o de Abatimento}
         toRemessaCancelarAbatimento            : Ocorrencia := '05'; {Cancelamento de Abatimento concedido}
         toRemessaAlterarVencimento             : Ocorrencia := '06'; {Altera��o de vencimento}
         toRemessaAlterarControleParticipante   : Ocorrencia := '07'; {Altera��o N�mero Controle Cedente}
         toRemessaAlterarNumeroControle         : Ocorrencia := '08'; {Altera��o de seu n�mero}
         toRemessaProtestar                     : Ocorrencia := '09'; {Pedido de protesto}
         toRemessaCancelarInstrucaoProtesto     : Ocorrencia := '18'; {Sustar protesto e manter na carteira}
      else
         Ocorrencia := '01';                                          {Remessa}
      end;

      {Pegando Especie}
      if trim(EspecieDoc) = 'DM' then
         aEspecie:= '01'
      else if trim(EspecieDoc) = 'NP' then
         aEspecie:= '02'
      else if trim(EspecieDoc) = 'NS' then
         aEspecie:= '03'
      else if trim(EspecieDoc) = 'RC' then
         aEspecie:= '05'
      else if trim(EspecieDoc) = 'DS' then
         aEspecie:= '06'
      else if trim(EspecieDoc) = 'LC' then
         aEspecie:= '07'
      else
         aEspecie := EspecieDoc;

      {Pegando campo Intru��es}
      if (DataProtesto > 0) and (DataProtesto > Vencimento) then //and (Instrucao1 = '06') then
       begin
         Protesto :=  IntToStrZero(DaysBetween(DataProtesto,Vencimento),2);
         if (trim(Instrucao1) <> '06' )  and (trim(Instrucao2) <> '06' ) then
            If Trim(Instrucao1) = '' then
               Instrucao1 := '06'
            else
               Instrucao2 := '06';
       end
      else
         Protesto:=  '00';

      {Pegando Tipo de Sacado}
      case Sacado.Pessoa of
         pFisica   : TipoSacado := '01';
         pJuridica : TipoSacado := '02';
      else
         TipoSacado := '99'; //TODO: CHECAR OQ FAZER PARA CEDENTE SEM TIPO
      end;

      with ACBrBoleto do
      begin
         wLinha:= '1'                                                     +  // ID Registro
                  IfThen(Length(Cedente.CNPJCPF) > 12,'02','01')          +
                  padR(trim(OnlyNumber(Cedente.CNPJCPF)),14,'0')          +
                  padL(trim(Cedente.CodigoTransmissao),20,'0')            +
                  padL( SeuNumero ,25,' ')                                +
                  padR(RightStr(NossoNumero,7),7,'0') + DigitoNossoNumero +
                  IfThen(DataAbatimento < EncodeDate(2000,01,01),
                         '000000',
                         FormatDateTime( 'ddmmyy', DataAbatimento))       +
                  ' '+IfThen(PercentualMulta > 0,'4','0')                 +
                  IntToStrZero( round( PercentualMulta * 100 ), 4)        +
                  '00'+StringOfChar( '0', 13)+space(4)                    +
                  IfThen(DataMoraJuros < EncodeDate(2000,01,01),
                         '000000',
                         FormatDateTime( 'ddmmyy', DataMoraJuros))        +
                   IntToStr(aCarteira) + Ocorrencia                       +
                  padL( NumeroDocumento,10,' ')                           +
                  FormatDateTime( 'ddmmyy', Vencimento)                   +
                  IntToStrZero( round( ValorDocumento * 100), 13)         +
                  '033' + aAgencia                                        +
                  padl(aEspecie,2) + 'N'                                  +
                  FormatDateTime( 'ddmmyy', DataDocumento )               +
                  padL(trim(Instrucao1),2,'0')                            +
                  padL(trim(Instrucao2),2,'0')                            +
                  IntToStrZero( round(ValorMoraJuros * 100 ), 13)         +
                  IfThen(DataDesconto < EncodeDate(2000,01,01),
                         '000000',
                         FormatDateTime( 'ddmmyy', DataDesconto))         +
                  IntToStrZero( round( ValorDesconto * 100), 13)          +
                  IntToStrZero( round( ValorIOF * 100 ), 13)              +
                  IntToStrZero( round( ValorAbatimento * 100 ), 13)       +
                  TipoSacado + padR(OnlyNumber(Sacado.CNPJCPF),14,'0')    +
                  padL( Sacado.NomeSacado, 40, ' ')                       +
                  padL( Sacado.Logradouro + ' '+ Sacado.Numero, 40, ' ')  +
                  padL( Sacado.Bairro,12,' ')                             +
                  padL( OnlyNumber(Sacado.CEP) , 8, ' ' )                 +
                  padL( Sacado.Cidade, 15, ' ') + Sacado.UF               +
				  IfThen(ACBrBoleto.Cedente.TipoInscricao = pJuridica,
                         Space(30),
                         padL(Sacado.Avalista, 30, ' ' )
                         )+ ' '+ 'I'                                       +
                  Copy(Cedente.Conta,Length(Cedente.Conta),1)             +
                  Cedente.ContaDigito + Space(6)                          +
                  Protesto + ' '                                          +
                  IntToStrZero( aRemessa.Count + 1, 6 );


         wLinha:= UpperCase(wLinha);

         for I := 0 to Mensagem.count-1 do
            wLinha:= wLinha + #13#10                         +
                     '2' + space(16)                             +
                     padL(Cedente.CodigoTransmissao,20,'0')      +
                     Space(10) + '01'                            +
                     padL(Mensagem[I],50)                        +
                     Space(283) + 'I'                            +
                     Copy(Cedente.Conta,Length(Cedente.Conta),1) +
                     Cedente.ContaDigito                         +
                     Space(9)                                    +
                     IntToStrZero( aRemessa.Count  + I + 2 , 6 );

         aRemessa.Text:= aRemessa.Text + UpperCase(wLinha);
      end;
   end;
end;

function TACBrBancoSantander.GerarRegistroTrailler240(
  ARemessa: TStringList): String;
begin
// by J�ter Rabelo Ferreira - 06/2014
   {REGISTRO TRAILER DO LOTE}
   Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + // 001 - 003 / C�digo do Banco na compensa��o
            '0001'                                                     + // 004 - 007 / Numero do lote remessa
            '5'                                                        + // 008 - 008 / Tipo de registro
            Space(9)                                                   + // 009 - 017 / Reservado (uso Banco)
            IntToStrZero((4 * (ARemessa.Count -1)) + 2, 6)             + // 018 - 023 / Quantidade de registros do lote
            space(217)                                                 ; // 024 - 240 / Reservado (uso Banco)

   {GERAR REGISTRO TRAILER DO ARQUIVO}
   Result:= Result + #13#10 +
            IntToStrZero(ACBrBanco.Numero, 3)                          + // 001 - 003 / C�digo do Banco na compensa��o
            '9999'                                                     + // 004 - 007 / Numero do lote remessa
            '9'                                                        + // 008 - 008 / Tipo de registro
            space(9)                                                   + // 009 - 017 / Reservado (uso Banco)
            '000001'                                                   + // 018 - 023 / Quantidade de lotes do arquivo
            IntToStrZero((4 * (ARemessa.Count -1)) + 4, 6)             + // 024 - 029 / Quantidade de registros do arquivo
            space(211)                                                 ; // 030 - 240 / Reservado (uso Banco)
end;

procedure TACBrBancoSantander.GerarRegistroTrailler400( ARemessa:TStringList );
var
  vQtdeLinha : Integer;
  wLinha: String;
begin
   vQtdeLinha := StrToInt(copy(ARemessa.Text,Length(ARemessa.Text)-7,6));//l� a ultima linha gravada para pergar o codigo seq.

   wLinha:= '9'                                            +           // ID Registro
            IntToStrZero( vQtdeLinha + 1, 6 )              +           // Contador de Registros
            IntToStrZero( round( vTotalTitulos* 100), 13)  +           // Valor Total dos Titulos
            StringOfChar( '0', 374)                        +
            IntToStrZero(ARemessa.Count + 1, 6);

   ARemessa.Text:= ARemessa.Text + UpperCase(wLinha);
end;

procedure TACBrBancoSantander.LerRetorno240(ARetorno: TStringList);
var
  Titulo: TACBrTitulo;
  Linha, rCodigoCedente, rCedente, rAgencia, rAgenciaDigito, rConta, rContaDigito, rCNPJCPF : String;
  iLinha : Integer;
  iIdxMotivo: Integer;
  procedure DoVerOcorrencia(AOcorrencia: string);
  begin
    with Titulo.OcorrenciaOriginal do
    begin
      if MatchText(AOcorrencia, ['02', '03', '06', '09', '11', '12', '13', '14'])  then
      begin
        Tipo := CodOcorrenciaToTipo(StrToInt(AOcorrencia));
      end
      else
      begin
        if AOcorrencia = '04' then
          Tipo := toRetornoTransferenciaCarteiraEntrada
        else if AOcorrencia = '05' then
          Tipo := toRetornoTransferenciaCarteiraBaixa
        else if AOcorrencia = '17' then
          Tipo := toRetornoLiquidadoAposBaixaOuNaoRegistro
        else if AOcorrencia = '19' then
          Tipo := toRetornoRecebimentoInstrucaoProtestar
        else if AOcorrencia = '20' then
          Tipo := toRetornoRecebimentoInstrucaoSustarProtesto
        else if AOcorrencia = '23' then
          Tipo := toRetornoEntradaEmCartorio
        else if AOcorrencia = '24' then
          Tipo := toRetornoRetiradoDeCartorio
        else if AOcorrencia = '25' then
          Tipo := toRetornoBaixaPorProtesto
        else if AOcorrencia = '26' then
          Tipo := toRetornoInstrucaoRejeitada
        else if AOcorrencia = '27' then
          Tipo := toRetornoAlteracaoUsoCedente
        else if AOcorrencia = '28' then
          Tipo := toRetornoDebitoTarifas
        else if AOcorrencia = '29' then
          Tipo := toRetornoOcorrenciasDoSacado
        else if AOcorrencia = '30' then
          Tipo := toRetornoAlteracaoDadosRejeitados
      end;
    end;
  end;
begin
  // by J�ter Rabelo Ferreira - 06/2014
  iLinha := 0;

  // Verificar se o retorno � do banco selecionado
  if StrToIntDef(copy(ARetorno.Strings[0], 1, 3),-1) <> Numero then
    raise Exception.create(ACBrStr(ACBrBanco.ACBrBoleto.NomeArqRetorno +
                           'n�o � um arquivo de retorno do banco' + sLineBreak + Nome));

  rCodigoCedente := Copy(ARetorno[0], 53, 9);
  rCedente       := Copy(ARetorno[0], 73, 30);
  rAgencia       := Copy(ARetorno[0], 33, 4);
  rAgenciaDigito := Copy(ARetorno[0], 37, 1);
  rConta         := padR(OnlyNumber(Copy(ARetorno[0], 38, 9)), fpTamanhoConta, '0');
  rContaDigito   := Copy(ARetorno[0], 47, 1);
  rCNPJCPF       := RightStr(OnlyNumber(Copy(ARetorno[0], 18, 15)), 14);

  with ACBrBanco.ACBrBoleto do
  begin
    if (not LeCedenteRetorno) and (rCNPJCPF <> OnlyNumber(Cedente.CNPJCPF)) then
       raise Exception.create(ACBrStr('CNPJ\CPF do arquivo inv�lido'));

    if (not LeCedenteRetorno) and ((rAgencia <> OnlyNumber(Cedente.Agencia)) or
        (rConta <> OnlyNumber(Cedente.Conta))) then
       raise Exception.Create(ACBrStr('Agencia\Conta do arquivo inv�lido'));

    Cedente.Nome := rCedente;
    Cedente.CodigoCedente := rCodigoCedente;
    Cedente.CNPJCPF := rCnpjCpf;
    Cedente.Agencia := rAgencia;
    Cedente.AgenciaDigito := rAgenciaDigito;
    Cedente.Conta := rConta;
    Cedente.ContaDigito := rContaDigito;

    case StrToIntDef(copy(ARetorno[0], 17, 1), 0) of
      1:
        Cedente.TipoInscricao := pFisica;
      else
        Cedente.TipoInscricao := pJuridica;
    end;

    ACBrBanco.ACBrBoleto.ListadeBoletos.Clear;
  end;

  ACBrBanco.ACBrBoleto.DataArquivo := StringToDateTimeDef(Copy(ARetorno[0],144,2)+'/'+
                                                          Copy(ARetorno[0],146,2)+'/'+
                                                          Copy(ARetorno[0],148,4),0, 'DD/MM/YYYY' );

  ACBrBanco.ACBrBoleto.NumeroArquivo := StrToIntDef(Copy(ARetorno[0],158,6),0);

  ACBrBanco.TamanhoMaximoNossoNum := 13;

  for iLinha := 1 to ARetorno.Count - 2 do
  begin
    Linha := ARetorno[iLinha];

    if copy(Linha, 14, 1) = 'T' then // se for segmento T cria um novo Titulo
       Titulo := ACBrBanco.ACBrBoleto.CriarTituloNaLista;

    with Titulo do
    begin
      if copy(Linha, 14, 1) = 'T' then
      begin
        NossoNumero := Copy(Linha, 41, ACBrBanco.TamanhoMaximoNossoNum);
        SeuNumero := Copy(Linha, 55, 15);
        NumeroDocumento := Copy(Linha, 55, 15);
        Carteira := Copy(Linha, 54, 1);
        ValorDocumento := StrToFloatDef(copy(Linha, 78, 15), 0) / 100;
        ValorDespesaCobranca := StrToFloatDef(copy(Linha, 194, 15), 0) / 100;
        // Sacado
        if Copy(Linha, 128, 1) = '1' then
          Sacado.Pessoa := pFisica
        else
          Sacado.Pessoa := pJuridica;
        Sacado.CNPJCPF := Trim(Copy(Linha, 129, 15));
        Sacado.NomeSacado := Trim(Copy(Linha, 144, 40));
      end
      else if copy(Linha, 14, 1) = 'U' then
      begin
        // Algumas ocorr�ncias est�o diferentes do cnab400, farei uma separada aqui
        DoVerOcorrencia(Copy(Linha, 16, 2));
        ValorDocumento := max(ValorDocumento,StrToFloatDef(copy(Linha, 78, 15), 0) / 100);
        ValorMoraJuros := StrToFloatDef(copy(Linha, 18, 15), 0) / 100;
        ValorDesconto := StrToFloatDef(copy(Linha, 33, 15), 0) / 100;
        ValorAbatimento := StrToFloatDef(copy(Linha, 48, 15), 0) / 100;
        ValorIOF := StrToFloatDef(copy(Linha, 63, 15), 0) / 100;
        ValorRecebido := StrToFloatDef(copy(Linha, 78, 15), 0) / 100;
        ValorOutrasDespesas := StrToFloatDef(copy(Linha, 108, 15), 0) / 100;
        ValorOutrosCreditos := StrToFloatDef(copy(Linha, 123, 15), 0) / 100;
        DataOcorrencia := StringToDateTimeDef(Copy(Linha, 138, 2)+'/'+
                                              Copy(Linha, 140, 2)+'/'+
                                              Copy(Linha, 142,4),0, 'DD/MM/YYYY' );
        DataCredito := StringToDateTimeDef(Copy(Linha, 146, 2)+'/'+
                                           Copy(Linha, 148, 2)+'/'+
                                           Copy(Linha, 150,4),0, 'DD/MM/YYYY' );
      end;
    end;
  end;
end;

Procedure TACBrBancoSantander.LerRetorno400 ( ARetorno: TStringList );
var
  Titulo : TACBrTitulo;
  ContLinha, CodOcorrencia, CodMotivo : Integer;
  Linha, rCedente, rAgencia, rConta, rDigitoConta, rCNPJCPF : String;
begin
   ContLinha := 0;

   if StrToIntDef(copy(ARetorno.Strings[0],77,3),-1) <> Numero then
      raise Exception.Create(ACBrStr(ACBrBanco.ACBrBoleto.NomeArqRetorno +
                             'n�o � um arquivo de retorno do '+ Nome));

   rCedente := trim(Copy(ARetorno[0],47,30));
   rAgencia := trim(Copy(ARetorno[1],18,4));
   rConta   := trim(Copy(ARetorno[1],22,8))+ Copy(ARetorno[1],384,1);
   rConta   := padR( OnlyNumber(rConta),fpTamanhoConta,'0');
   rDigitoConta := Copy(ARetorno[1],385,1);

   rCNPJCPF := OnlyNumber( Copy(ARetorno[1],04,14) );

   with ACBrBanco.ACBrBoleto do
   begin
      if (not LeCedenteRetorno) and (rCNPJCPF <> OnlyNumber(Cedente.CNPJCPF)) then
         raise Exception.Create(ACBrStr('CNPJ\CPF do arquivo inv�lido'));

      if (not LeCedenteRetorno) and ((rAgencia <> OnlyNumber(Cedente.Agencia)) or
          (rConta <> OnlyNumber(Cedente.Conta))) then
         raise Exception.Create(ACBrStr('Agencia\Conta do arquivo inv�lido'));

      Cedente.Nome    := rCedente;
      Cedente.CNPJCPF := rCNPJCPF;
      Cedente.Agencia := rAgencia;
      Cedente.AgenciaDigito:= '0';
      Cedente.Conta   := rConta;
      Cedente.ContaDigito:= rDigitoConta;

      DataArquivo   := StringToDateTimeDef(Copy(ARetorno[0],95,2)+'/'+
                                           Copy(ARetorno[0],97,2)+'/'+
                                           Copy(ARetorno[0],99,2),0, 'DD/MM/YY' );

      case StrToIntDef(Copy(ARetorno[1],2,2),0) of
         01: Cedente.TipoInscricao:= pFisica;
         else
            Cedente.TipoInscricao:= pJuridica;
      end;

      ACBrBanco.ACBrBoleto.ListadeBoletos.Clear;
   end;

   for ContLinha := 1 to ARetorno.Count - 2 do
   begin
      Linha := ARetorno[ContLinha] ;

      if Copy(Linha,1,1)<> '1' then
         Continue;

      Titulo := ACBrBanco.ACBrBoleto.CriarTituloNaLista;

      with Titulo do
      begin
         SeuNumero   := copy(Linha,38,25);
         NossoNumero := Copy(Linha,63,08);
         Carteira    := Copy(Linha,108,1);

         OcorrenciaOriginal.Tipo := CodOcorrenciaToTipo(StrToIntDef(
                                                        copy(Linha,109,2),0));

         DataOcorrencia:= StringToDateTimeDef(Copy(Linha,111,2)+'/'+
                                              Copy(Linha,113,2)+'/'+
                                              Copy(Linha,115,2),0, 'DD/MM/YY' );

         NumeroDocumento:= Copy(Linha,117,10);

         CodOcorrencia := StrToIntDef(copy(Linha,135,2),0);

         //-|Se a ocorrencia for igual a > 0 - Houve Erros
         if(CodOcorrencia > 0) then
         begin
            if copy(Linha,137,3) <> '   ' then
            begin
               CodMotivo:= StrToIntDef(copy(Linha,137,3),0);
               MotivoRejeicaoComando.Add(copy(Linha,137,3));
               DescricaoMotivoRejeicaoComando.Add(CodMotivoRejeicaoToDescricao(
                                                  OcorrenciaOriginal.Tipo,CodMotivo));
            end;

            if copy(Linha,140,3) <> '   ' then
            begin
               CodMotivo:= StrToIntDef(copy(Linha,140,3),0);
               MotivoRejeicaoComando.Add(copy(Linha,137,3));
               DescricaoMotivoRejeicaoComando.Add(CodMotivoRejeicaoToDescricao(
                                                  OcorrenciaOriginal.Tipo,CodMotivo));
            end;

            if copy(Linha,143,3) <> '   ' then
            begin
               CodMotivo:= StrToIntDef(copy(Linha,143,3),0);
               MotivoRejeicaoComando.Add(copy(Linha,137,3));
               DescricaoMotivoRejeicaoComando.Add(CodMotivoRejeicaoToDescricao(
                                                  OcorrenciaOriginal.Tipo,CodMotivo));
            end;
         end;

         Vencimento := StringToDateTimeDef( Copy(Linha,147,2)+'/'+
                                            Copy(Linha,149,2)+'/'+
                                            Copy(Linha,151,2),0, 'DD/MM/YY' );

         ValorDocumento       := StrToFloatDef(Copy(Linha,153,13),0)/100;

         case StrToIntDef(Copy(Linha,174,2),0) of
            1: EspecieDoc:= 'DM';
            2: EspecieDoc:= 'NP';
            3: EspecieDoc:= 'NS';
            5: EspecieDoc:= 'RC';
            6: EspecieDoc:= 'DS';
            7: EspecieDoc:= 'LS';
         end;

         ValorDespesaCobranca := StrToFloatDef(Copy(Linha,176,13),0)/100;
         ValorOutrasDespesas  := StrToFloatDef(Copy(Linha,189,13),0)/100;
         ValorMoraJuros       := StrToFloatDef(Copy(Linha,202,13),0) +
                                 StrToFloatDef(Copy(Linha,267,13),0)/100;
         ValorIOF             := StrToFloatDef(Copy(Linha,215,13),0)/100;
         ValorAbatimento      := StrToFloatDef(Copy(Linha,228,13),0)/100;
         ValorDesconto        := StrToFloatDef(Copy(Linha,241,13),0)/100;
         ValorRecebido        := StrToFloatDef(Copy(Linha,254,13),0)/100;
         ValorOutrosCreditos  := StrToFloatDef(Copy(Linha,280,13),0)/100;

         if Copy(Linha,294,1) = 'N' then
            Aceite:=  atNao
         else
            Aceite:=  atSim;

         if StrToIntDef(Copy(Linha,296,6),0) <> 0 then
            DataCredito:= StringToDateTimeDef( Copy(Linha,296,2)+'/'+
                                               Copy(Linha,298,2)+'/'+
                                               Copy(Linha,300,2),0, 'DD/MM/YY' );

         Sacado.NomeSacado:= Copy(Linha,302,36);
      end;
   end;
end;

function TACBrBancoSantander.TipoOcorrenciaToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia): String;
var
 CodOcorrencia: Integer;
begin

  CodOcorrencia := StrToIntDef(TipoOCorrenciaToCod(TipoOcorrencia),0);

  case CodOcorrencia of
    02: Result:='02-Entrada Confirmada' ;
    03: Result:='03-Entrada Rejeitada' ;
    06: Result:='06-Liquida��o normal' ;
    09: Result:='09-Baixado Automaticamente via Arquivo' ;
    10: Result:='10-Baixado conforme instru��es da Ag�ncia' ;
    11: Result:='11-Em Ser - Arquivo de T�tulos pendentes' ;
    12: Result:='12-Abatimento Concedido' ;
    13: Result:='13-Abatimento Cancelado' ;
    14: Result:='14-Vencimento Alterado' ;
    15: Result:='15-Liquida��o em Cart�rio' ;
    16: Result:= '16-Titulo Pago em Cheque - Vinculado';
    17: Result:='17-Liquida��o ap�s baixa ou T�tulo n�o registrado' ;
    18: Result:='18-Acerto de Deposit�ria' ;
    19: Result:='19-Confirma��o Recebimento Instru��o de Protesto' ;
    20: Result:='20-Confirma��o Recebimento Instru��o Susta��o de Protesto' ;
    21: Result:='21-Acerto do Controle do Participante' ;
    22: Result:='22-Titulo com Pagamento Cancelado';
    23: Result:='23-Entrada do T�tulo em Cart�rio' ;
    24: Result:='24-Entrada rejeitada por CEP Irregular' ;
    27: Result:='27-Baixa Rejeitada' ;
    28: Result:='28-D�bito de tarifas/custas' ;
    29: Result:= '29-Ocorr�ncias do Sacado';
    30: Result:='30-Altera��o de Outros Dados Rejeitados' ;
    32: Result:='32-Instru��o Rejeitada' ;
    33: Result:='33-Confirma��o Pedido Altera��o Outros Dados' ;
    34: Result:='34-Retirado de Cart�rio e Manuten��o Carteira' ;
    35: Result:='35-Desagendamento do d�bito autom�tico' ;
    40: Result:='40-Estorno de Pagamento';
    55: Result:='55-Sustado Judicial';
    68: Result:='68-Acerto dos dados do rateio de Cr�dito' ;
    69: Result:='69-Cancelamento dos dados do rateio' ;
  end;
end;

function TACBrBancoSantander.CodOcorrenciaToTipo(const CodOcorrencia:
   Integer ) : TACBrTipoOcorrencia;
begin
   case CodOcorrencia of
      01: Result := toRetornoTituloNaoExiste;
      02: Result := toRetornoRegistroConfirmado;
      03: Result := toRetornoRegistroRecusado;
      06: Result := toRetornoLiquidado;
      07: Result := toRetornoLiquidadoPorConta;
      08: Result := toRetornoLiquidadoSaldoRestante;
      09: Result := toRetornoBaixaAutomatica;
      10: Result := toRetornoBaixadoInstAgencia;
      11: Result := toRetornoTituloEmSer;
      12: Result := toRetornoAbatimentoConcedido;
      13: Result := toRetornoAbatimentoCancelado;
      14: Result := toRetornoVencimentoAlterado;
      15: Result := toRetornoEncaminhadoACartorio;
      16: Result := toRetornoTituloJaBaixado;
      17: Result := toRetornoLiquidadoEmCartorio;
      21: Result := toREtornoEntradaEmCartorio;
      22: Result := toRetornoRetiradoDeCartorio;
      24: Result := toRetornoCustasCartorioDistribuidor;
      25: Result := toRetornoProtestado;
      26: Result := toRetornoProtestoSustado;
   else
      Result := toRetornoOutrasOcorrencias;
   end;
end;

function TACBrBancoSantander.TipoOCorrenciaToCod (
   const TipoOcorrencia: TACBrTipoOcorrencia ) : String;
begin
   case TipoOcorrencia of
      toRetornoRegistroConfirmado : Result:='02';
      toRetornoRegistroRecusado   : Result:='03';
      toRetornoLiquidado          : Result:='06';
      toRetornoBaixadoViaArquivo  : Result:='09';
      toRetornoBaixadoInstAgencia : Result:='10';
      toRetornoTituloEmSer        : Result:='11';
      toRetornoAbatimentoConcedido: Result:='12';
      toRetornoAbatimentoCancelado: Result:='13';
      toRetornoVencimentoAlterado : Result:='14';
      toRetornoLiquidadoEmCartorio: Result:='15';
      toRetornoTituloPagoemCheque : Result:='16';
      toRetornoLiquidadoAposBaixaouNaoRegistro : Result:= '17';
      toRetornoAcertoDepositaria  : Result:='18';
      toRetornoRecebimentoInstrucaoProtestar      : Result := '19';
      toRetornoRecebimentoInstrucaoSustarProtesto : Result := '20';
      toRetornoAcertoControleParticipante         : Result := '21';
      toRetornoRecebimentoInstrucaoAlterarDados   : Result := '22';
      toRetornoEncaminhadoACartorio               : Result := '23';
      toRetornoEntradaRejeitaCEPIrregular         : Result := '24';
      toRetornoBaixaRejeitada                     : Result := '27';
      toRetornoDebitoTarifas      : Result:='28';
      toRetornoOcorrenciasdoSacado                : Result := '29';
      toRetornoALteracaoOutrosDadosRejeitada      : Result := '30';
      toRetornoComandoRecusado                    : Result := '32';
      toRetornoDesagendamentoDebitoAutomatico     : Result := '35';
   else
      Result:= '02';
   end;
end;

function TACBrBancoSantander.COdMotivoRejeicaoToDescricao( const TipoOcorrencia:TACBrTipoOcorrencia ;CodMotivo: Integer) : String;
begin
   case TipoOcorrencia of
      toRetornoRegistroConfirmado:
      case CodMotivo  of
         00: Result := '00-Ocorrencia aceita';
         01: Result := '01-Codigo de banco inv�lido';
         04: Result := '04-Cod. movimentacao nao permitido p/ a carteira';
         15: Result := '15-Caracteristicas de Cobranca Imcompativeis';
         17: Result := '17-Data de vencimento anterior a data de emiss�o';
         21: Result := '21-Esp�cie do T�tulo inv�lido';
         24: Result := '24-Data da emiss�o inv�lida';
         38: Result := '38-Prazo para protesto inv�lido';
         39: Result := '39-Pedido para protesto n�o permitido para t�tulo';
         43: Result := '43-Prazo para baixa e devolu��o inv�lido';
         45: Result := '45-Nome do Sacado inv�lido';
         46: Result := '46-Tipo/num. de inscri��o do Sacado inv�lidos';
         47: Result := '47-Endere�o do Sacado n�o informado';
         48: Result := '48-CEP invalido';
         50: Result := '50-CEP referente a Banco correspondente';
         53: Result := '53-N� de inscri��o do Sacador/avalista inv�lidos (CPF/CNPJ)';
         54: Result := '54-Sacador/avalista n�o informado';
         67: Result := '67-D�bito autom�tico agendado';
         68: Result := '68-D�bito n�o agendado - erro nos dados de remessa';
         69: Result := '69-D�bito n�o agendado - Sacado n�o consta no cadastro de autorizante';
         70: Result := '70-D�bito n�o agendado - Cedente n�o autorizado pelo Sacado';
         71: Result := '71-D�bito n�o agendado - Cedente n�o participa da modalidade de d�bito autom�tico';
         72: Result := '72-D�bito n�o agendado - C�digo de moeda diferente de R$';
         73: Result := '73-D�bito n�o agendado - Data de vencimento inv�lida';
         75: Result := '75-D�bito n�o agendado - Tipo do n�mero de inscri��o do sacado debitado inv�lido';
         86: Result := '86-Seu n�mero do documento inv�lido';
         89: Result := '89-Email sacado nao enviado - Titulo com debito automatico';
         90: Result := '90-Email sacado nao enviado - Titulo com cobranca sem registro';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;
      toRetornoRegistroRecusado:
      case CodMotivo of
         02: Result:= '02-Codigo do registro detalhe invalido';
         03: Result:= '03-Codigo da Ocorrencia Invalida';
         04: Result:= '04-Codigo da Ocorrencia nao permitida para a carteira';
         05: Result:= '05-Codigo de Ocorrencia nao numerico';
         07: Result:= 'Agencia\Conta\Digito invalido';
         08: Result:= 'Nosso numero invalido';
         09: Result:= 'Nosso numero duplicado';
         10: Result:= 'Carteira invalida';
         13: Result:= 'Idetificacao da emissao do boleto invalida';
         16: Result:= 'Data de vencimento invalida';
         18: Result:= 'Vencimento fora do prazo de operacao';
         20: Result:= 'Valor do titulo invalido';
         21: Result:= 'Especie do titulo invalida';
         22: Result:= 'Especie nao permitida para a carteira';
         24: Result:= 'Data de emissao invalida';
         28: Result:= 'Codigo de desconto invalido';
         38: Result:= 'Prazo para protesto invalido';
         44: Result:= 'Agencia cedente nao prevista';
         45: Result:= 'Nome cedente nao informado';
         46: Result:= 'Tipo/numero inscricao sacado invalido';
         47: Result:= 'Endereco sacado nao informado';
         48: Result:= 'CEP invalido';
         50: Result:= 'CEP irregular - Banco correspondente';
         63: Result:= 'Entrada para titulo ja cadastrado';
         65: Result:= 'Limite excedido';
         66: Result:= 'Numero autorizacao inexistente';
         68: Result:= 'Debito nao agendado - Erro nos dados da remessa';
         69: Result:= 'Debito nao agendado - Sacado nao consta no cadastro de autorizante';
         70: Result:= 'Debito nao agendado - Cedente nao autorizado pelo sacado';
         71: Result:= 'Debito nao agendado - Cedente nao participa de debito automatico';
         72: Result:= 'Debito nao agendado - Codigo de moeda diferente de R$';
         73: Result:= 'Debito nao agendado - Data de vencimento invalida';
         74: Result:= 'Debito nao agendado - Conforme seu pedido titulo nao registrado';
         75: Result:= 'Debito nao agendado - Tipo de numero de inscricao de debitado invalido';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;
      toRetornoLiquidado:
      case CodMotivo of
         00: Result:= '00-Titulo pago com dinheiro';
         15: Result:= '15-Titulo pago com cheque';
         42: Result:= '42-Rateio nao efetuado';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;
      toRetornoBaixadoViaArquivo:
      case CodMotivo of
         00: Result:= '00-Ocorrencia aceita';
         10: Result:= '10=Baixa comandada pelo cliente';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;
      toRetornoBaixadoInstAgencia:
         case CodMotivo of
            00: Result:= '00-Baixado conforme instrucoes na agencia';
            14: Result:= '14-Titulo protestado';
            15: Result:= '15-Titulo excluido';
            16: Result:= '16-Titulo baixado pelo banco por decurso de prazo';
            20: Result:= '20-Titulo baixado e transferido para desconto';
         else
            Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
         end;
      toRetornoLiquidadoAposBaixaouNaoRegistro:
      case CodMotivo of
         00: Result:= '00-Pago com dinheiro';
         15: Result:= '15-Pago com cheque';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      toRetornoLiquidadoEmCartorio:
      case CodMotivo of
         00: Result:= '00-Pago com dinheiro';
         15: Result:= '15-Pago com cheque';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      toRetornoEntradaRejeitaCEPIrregular:
      case CodMotivo of
         48: Result:= '48-CEP invalido';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      toRetornoBaixaRejeitada:
      case CodMotivo of
         04: Result:= '04-Codigo de ocorrencia nao permitido para a carteira';
         07: Result:= '07-Agencia\Conta\Digito invalidos';
         08: Result:= '08-Nosso numero invalido';
         10: Result:= '10-Carteira invalida';
         15: Result:= '15-Carteira\Agencia\Conta\NossoNumero invalidos';
         40: Result:= '40-Titulo com ordem de protesto emitido';
         42: Result:= '42-Codigo para baixa/devolucao via Telebradesco invalido';
         60: Result:= '60-Movimento para titulo nao cadastrado';
         77: Result:= '70-Transferencia para desconto nao permitido para a carteira';
         85: Result:= '85-Titulo com pagamento vinculado';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      toRetornoDebitoTarifas:
      case CodMotivo of
         02: Result:= '02-Tarifa de perman�ncia t�tulo cadastrado';
         03: Result:= '03-Tarifa de susta��o';
         04: Result:= '04-Tarifa de protesto';
         05: Result:= '05-Tarifa de outras instrucoes';
         06: Result:= '06-Tarifa de outras ocorr�ncias';
         08: Result:= '08-Custas de protesto';
         12: Result:= '12-Tarifa de registro';
         13: Result:= '13-Tarifa titulo pago no Bradesco';
         14: Result:= '14-Tarifa titulo pago compensacao';
         15: Result:= '15-Tarifa t�tulo baixado n�o pago';
         16: Result:= '16-Tarifa alteracao de vencimento';
         17: Result:= '17-Tarifa concess�o abatimento';
         18: Result:= '18-Tarifa cancelamento de abatimento';
         19: Result:= '19-Tarifa concess�o desconto';
         20: Result:= '20-Tarifa cancelamento desconto';
         21: Result:= '21-Tarifa t�tulo pago cics';
         22: Result:= '22-Tarifa t�tulo pago Internet';
         23: Result:= '23-Tarifa t�tulo pago term. gerencial servi�os';
         24: Result:= '24-Tarifa t�tulo pago P�g-Contas';
         25: Result:= '25-Tarifa t�tulo pago Fone F�cil';
         26: Result:= '26-Tarifa t�tulo D�b. Postagem';
         27: Result:= '27-Tarifa impress�o de t�tulos pendentes';
         28: Result:= '28-Tarifa t�tulo pago BDN';
         29: Result:= '29-Tarifa t�tulo pago Term. Multi Funcao';
         30: Result:= '30-Impress�o de t�tulos baixados';
         31: Result:= '31-Impress�o de t�tulos pagos';
         32: Result:= '32-Tarifa t�tulo pago Pagfor';
         33: Result:= '33-Tarifa reg/pgto � guich� caixa';
         34: Result:= '34-Tarifa t�tulo pago retaguarda';
         35: Result:= '35-Tarifa t�tulo pago Subcentro';
         36: Result:= '36-Tarifa t�tulo pago Cartao de Credito';
         37: Result:= '37-Tarifa t�tulo pago Comp Eletr�nica';
         38: Result:= '38-Tarifa t�tulo Baix. Pg. Cartorio';
         39: Result:='39-Tarifa t�tulo baixado acerto BCO';
         40: Result:='40-Baixa registro em duplicidade';
         41: Result:='41-Tarifa t�tulo baixado decurso prazo';
         42: Result:='42-Tarifa t�tulo baixado Judicialmente';
         43: Result:='43-Tarifa t�tulo baixado via remessa';
         44: Result:='44-Tarifa t�tulo baixado rastreamento';
         45: Result:='45-Tarifa t�tulo baixado conf. Pedido';
         46: Result:='46-Tarifa t�tulo baixado protestado';
         47: Result:='47-Tarifa t�tulo baixado p/ devolucao';
         48: Result:='48-Tarifa t�tulo baixado franco pagto';
         49: Result:='49-Tarifa t�tulo baixado SUST/RET/CART�RIO';
         50: Result:='50-Tarifa t�tulo baixado SUS/SEM/REM/CART�RIO';
         51: Result:='51-Tarifa t�tulo transferido desconto';
         52: Result:='52-Cobrado baixa manual';
         53: Result:='53-Baixa por acerto cliente';
         54: Result:='54-Tarifa baixa por contabilidade';
         55: Result:='55-BIFAX';
         56: Result:='56-Consulta informa��es via internet';
         57: Result:='57-Arquivo retorno via internet';
         58: Result:='58-Tarifa emiss�o Papeleta';
         59: Result:='59-Tarifa fornec papeleta semi preenchida';
         60: Result:='60-Acondicionador de papeletas (RPB)S';
         61: Result:='61-Acond. De papelatas (RPB)s PERSONAL';
         62: Result:='62-Papeleta formul�rio branco';
         63: Result:='63-Formul�rio A4 serrilhado';
         64: Result:='64-Fornecimento de softwares transmiss';
         65: Result:='65-Fornecimento de softwares consulta';
         66: Result:='66-Fornecimento Micro Completo';
         67: Result:='67-Fornecimento MODEN';
         68: Result:='68-Fornecimento de m�quina FAX';
         69: Result:='69-Fornecimento de maquinas oticas';
         70: Result:='70-Fornecimento de Impressoras';
         71: Result:='71-Reativa��o de t�tulo';
         72: Result:='72-Altera��o de produto negociado';
         73: Result:='73-Tarifa emissao de contra recibo';
         74: Result:='74-Tarifa emissao 2� via papeleta';
         75: Result:='75-Tarifa regrava��o arquivo retorno';
         76: Result:='76-Arq. T�tulos a vencer mensal';
         77: Result:='77-Listagem auxiliar de cr�dito';
         78: Result:='78-Tarifa cadastro cartela instru��o permanente';
         79: Result:='79-Canaliza��o de Cr�dito';
         80: Result:='80-Cadastro de Mensagem Fixa';
         81: Result:='81-Tarifa reapresenta��o autom�tica t�tulo';
         82: Result:='82-Tarifa registro t�tulo d�b. Autom�tico';
         83: Result:='83-Tarifa Rateio de Cr�dito';
         84: Result:='84-Emiss�o papeleta sem valor';
         85: Result:='85-Sem uso';
         86: Result:='86-Cadastro de reembolso de diferen�a';
         87: Result:='87-Relat�rio fluxo de pagto';
         88: Result:='88-Emiss�o Extrato mov. Carteira';
         89: Result:='89-Mensagem campo local de pagto';
         90: Result:='90-Cadastro Concession�ria serv. Publ.';
         91: Result:='91-Classif. Extrato Conta Corrente';
         92: Result:='92-Contabilidade especial';
         93: Result:='93-Realimenta��o pagto';
         94: Result:='94-Repasse de Cr�ditos';
         95: Result:='95-Tarifa reg. pagto Banco Postal';
         96: Result:='96-Tarifa reg. Pagto outras m�dias';
         97: Result:='97-Tarifa Reg/Pagto � Net Empresa';
         98: Result:='98-Tarifa t�tulo pago vencido';
         99: Result:='99-TR T�t. Baixado por decurso prazo';
         100: Result:='100-Arquivo Retorno Antecipado';
         101: Result:='101-Arq retorno Hora/Hora';
         102: Result:='102-TR. Agendamento D�b Aut';
         103: Result:='103-TR. Tentativa cons D�b Aut';
         104: Result:='104-TR Cr�dito on-line';
         105: Result:='105-TR. Agendamento rat. Cr�dito';
         106: Result:='106-TR Emiss�o aviso rateio';
         107: Result:='107-Extrato de protesto';
         110: Result:='110-Tarifa reg/pagto Bradesco Expresso';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      toRetornoOcorrenciasdoSacado:
      case CodMotivo of
         78 : Result:= '78-Sacado alega que faturamento e indevido';
         116: Result:= '116-Sacado aceita/reconhece o faturamento';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      toRetornoALteracaoOutrosDadosRejeitada:
      case CodMotivo of
         01: Result:= '01-C�digo do Banco inv�lido';
         04: Result:= '04-C�digo de ocorr�ncia n�o permitido para a carteira';
         05: Result:= '05-C�digo da ocorr�ncia n�o num�rico';
         08: Result:= '08-Nosso n�mero inv�lido';
         15: Result:= '15-Caracter�stica da cobran�a incompat�vel';
         16: Result:= '16-Data de vencimento inv�lido';
         17: Result:= '17-Data de vencimento anterior a data de emiss�o';
         18: Result:= '18-Vencimento fora do prazo de opera��o';
         24: Result:= '24-Data de emiss�o Inv�lida';
         26: Result:= '26-C�digo de juros de mora inv�lido';
         27: Result:= '27-Valor/taxa de juros de mora inv�lido';
         28: Result:= '28-C�digo de desconto inv�lido';
         29: Result:= '29-Valor do desconto maior/igual ao valor do T�tulo';
         30: Result:= '30-Desconto a conceder n�o confere';
         31: Result:= '31-Concess�o de desconto j� existente ( Desconto anterior )';
         32: Result:= '32-Valor do IOF inv�lido';
         33: Result:= '33-Valor do abatimento inv�lido';
         34: Result:= '34-Valor do abatimento maior/igual ao valor do T�tulo';
         38: Result:= '38-Prazo para protesto inv�lido';
         39: Result:= '39-Pedido de protesto n�o permitido para o T�tulo';
         40: Result:= '40-T�tulo com ordem de protesto emitido';
         42: Result:= '42-C�digo para baixa/devolu��o inv�lido';
         46: Result:= '46-Tipo/n�mero de inscri��o do sacado inv�lidos';
         48: Result:= '48-Cep Inv�lido';
         53: Result:= '53-Tipo/N�mero de inscri��o do sacador/avalista inv�lidos';
         54: Result:= '54-Sacador/avalista n�o informado';
         57: Result:= '57-C�digo da multa inv�lido';
         58: Result:= '58-Data da multa inv�lida';
         60: Result:= '60-Movimento para T�tulo n�o cadastrado';
         79: Result:= '79-Data de Juros de mora Inv�lida';
         80: Result:= '80-Data do desconto inv�lida';
         85: Result:= '85-T�tulo com Pagamento Vinculado.';
         88: Result:= '88-E-mail Sacado n�o lido no prazo 5 dias';
         91: Result:= '91-E-mail sacado n�o recebido';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      toRetornoComandoRecusado:
      case CodMotivo of
         01 : Result:= '01-C�digo do Banco inv�lido';
         02 : Result:= '02-C�digo do registro detalhe inv�lido';
         04 : Result:= '04-C�digo de ocorr�ncia n�o permitido para a carteira';
         05 : Result:= '05-C�digo de ocorr�ncia n�o num�rico';
         07 : Result:= '07-Ag�ncia/Conta/d�gito inv�lidos';
         08 : Result:= '08-Nosso n�mero inv�lido';
         10 : Result:= '10-Carteira inv�lida';
         15 : Result:= '15-Caracter�sticas da cobran�a incompat�veis';
         16 : Result:= '16-Data de vencimento inv�lida';
         17 : Result:= '17-Data de vencimento anterior a data de emiss�o';
         18 : Result:= '18-Vencimento fora do prazo de opera��o';
         20 : Result:= '20-Valor do t�tulo inv�lido';
         21 : Result:= '21-Esp�cie do T�tulo inv�lida';
         22 : Result:= '22-Esp�cie n�o permitida para a carteira';
         24 : Result:= '24-Data de emiss�o inv�lida';
         28 : Result:= '28-C�digo de desconto via Telebradesco inv�lido';
         29 : Result:= '29-Valor do desconto maior/igual ao valor do T�tulo';
         30 : Result:= '30-Desconto a conceder n�o confere';
         31 : Result:= '31-Concess�o de desconto - J� existe desconto anterior';
         33 : Result:= '33-Valor do abatimento inv�lido';
         34 : Result:= '34-Valor do abatimento maior/igual ao valor do T�tulo';
         36 : Result:= '36-Concess�o abatimento - J� existe abatimento anterior';
         38 : Result:= '38-Prazo para protesto inv�lido';
         39 : Result:= '39-Pedido de protesto n�o permitido para o T�tulo';
         40 : Result:= '40-T�tulo com ordem de protesto emitido';
         41 : Result:= '41-Pedido cancelamento/susta��o para T�tulo sem instru��o de protesto';
         42 : Result:= '42-C�digo para baixa/devolu��o inv�lido';
         45 : Result:= '45-Nome do Sacado n�o informado';
         46 : Result:= '46-Tipo/n�mero de inscri��o do Sacado inv�lidos';
         47 : Result:= '47-Endere�o do Sacado n�o informado';
         48 : Result:= '48-CEP Inv�lido';
         50 : Result:= '50-CEP referente a um Banco correspondente';
         53 : Result:= '53-Tipo de inscri��o do sacador avalista inv�lidos';
         60 : Result:= '60-Movimento para T�tulo n�o cadastrado';
         85 : Result:= '85-T�tulo com pagamento vinculado';
         86 : Result:= '86-Seu n�mero inv�lido';
         94 : Result:= '94-T�tulo Penhorado � Instru��o N�o Liberada pela Ag�ncia';

      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;

      toRetornoDesagendamentoDebitoAutomatico:
      case CodMotivo of
         81 : Result:= '81-Tentativas esgotadas, baixado';
         82 : Result:= '82-Tentativas esgotadas, pendente';
         83 : Result:= '83-Cancelado pelo Sacado e Mantido Pendente, conforme negocia��o';
         84 : Result:= '84-Cancelado pelo sacado e baixado, conforme negocia��o';
      else
         Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
      end;
   else
      Result:= IntToStrZero(CodMotivo,2) +' - Outros Motivos';
   end;
end;


end.


