{******************************************************************************}
{ Projeto: Componente ACBrNFSe                                                 }
{  Biblioteca multiplataforma de componentes Delphi                            }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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

unit ACBrProvedorVirtual;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorVirtual }

 TProvedorVirtual = class(TProvedorClass)
  protected
   { protected }
  private
   { private }
  public
   { public }
   Constructor Create;

   function GetConfigCidade(ACodCidade, AAmbiente: Integer): TConfigCidade; OverRide;
   function GetConfigSchema(ACodCidade: Integer): TConfigSchema; OverRide;
   function GetConfigURL(ACodCidade: Integer): TConfigURL; OverRide;
   function GetURI(URI: String): String; OverRide;
   function GetAssinarXML(Acao: TnfseAcao): Boolean; OverRide;
   function GetValidarLote: Boolean; OverRide;

   function Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4, NameSpaceDad, Identificador, URI: String): AnsiString; OverRide;
   function Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados, NameSpaceCab: String; ACodCidade: Integer): AnsiString; OverRide;
   function Gera_DadosSenha(CNPJ, Senha: String): AnsiString; OverRide;
   function Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString; OverRide;

   function GeraEnvelopeRecepcionarLoteRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarSituacaoLoteRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarLoteRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarNFSeporRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeGerarNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeRecepcionarSincrono(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeSubstituirNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;

   function GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String; OverRide;
   function GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString; OverRide;

   function GeraRetornoNFSe(Prefixo: String; RetNFSe: AnsiString; NomeCidade: String): AnsiString; OverRide;
   function GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer; ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String; OverRide;
  end;

implementation

{ TProvedorVirtual }

constructor TProvedorVirtual.Create;
begin
  {----}
end;

function TProvedorVirtual.GetConfigCidade(ACodCidade, AAmbiente: Integer): TConfigCidade;
var
  ConfigCidade: TConfigCidade;
begin
 	ConfigCidade.VersaoSoap        := '1.1';
 	ConfigCidade.Prefixo2          := '';
 	ConfigCidade.Prefixo3          := '';
 	ConfigCidade.Prefixo4          := '';
 	ConfigCidade.Identificador     := 'Id';
  ConfigCidade.QuebradeLinha     := ';';
	ConfigCidade.NameSpaceEnvelope := 'http://www.abrasf.org.br';

 	ConfigCidade.AssinaRPS   := False;
 	ConfigCidade.AssinaLote  := False;
  ConfigCidade.AssinaGerar := False;

 	Result := ConfigCidade;
end;

function TProvedorVirtual.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
  ConfigSchema: TConfigSchema;
begin
  ConfigSchema.VersaoCabecalho       := '2.02';
  ConfigSchema.VersaoDados           := '1.00';
  ConfigSchema.VersaoXML             := '2';
  ConfigSchema.NameSpaceXML          := 'http://www.abrasf.org.br/';
  ConfigSchema.Cabecalho             := 'nfse.xsd';
  ConfigSchema.ServicoEnviar         := 'nfse.xsd';
  ConfigSchema.ServicoConSit         := 'nfse.xsd';
  ConfigSchema.ServicoConLot         := 'nfse.xsd';
  ConfigSchema.ServicoConRps         := 'nfse.xsd';
  ConfigSchema.ServicoConNfse        := 'nfse.xsd';
  ConfigSchema.ServicoCancelar       := 'nfse.xsd';
  ConfigSchema.ServicoGerar          := 'nfse.xsd';
  ConfigSchema.ServicoEnviarSincrono := 'nfse.xsd';
  ConfigSchema.ServicoSubstituir     := 'nfse.xsd';
  ConfigSchema.DefTipos              := '';

  Result := ConfigSchema;
end;

function TProvedorVirtual.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 	ConfigURL: TConfigURL;
begin
 	ConfigURL.HomNomeCidade         := '';
  ConfigURL.HomRecepcaoLoteRPS    := 'http://servidor1.virtualtechnologia.com.br:82/WebServiceSCEMJavaEnvironment/servlet/awsnfsebarradogarcas';
  ConfigURL.HomConsultaLoteRPS    := 'http://servidor1.virtualtechnologia.com.br:82/WebServiceSCEMJavaEnvironment/servlet/awsnfsebarradogarcas';
  ConfigURL.HomConsultaNFSeRPS    := 'http://servidor1.virtualtechnologia.com.br:82/WebServiceSCEMJavaEnvironment/servlet/awsnfsebarradogarcas';
  ConfigURL.HomConsultaSitLoteRPS := '';
  ConfigURL.HomConsultaNFSe       := 'http://servidor1.virtualtechnologia.com.br:82/WebServiceSCEMJavaEnvironment/servlet/awsnfsebarradogarcas';
  ConfigURL.HomCancelaNFSe        := 'http://servidor1.virtualtechnologia.com.br:82/WebServiceSCEMJavaEnvironment/servlet/awsnfsebarradogarcas';
  ConfigURL.HomGerarNFSe          := 'http://servidor1.virtualtechnologia.com.br:82/WebServiceSCEMJavaEnvironment/servlet/awsnfsebarradogarcas';
  ConfigURL.HomRecepcaoSincrono   := 'http://servidor1.virtualtechnologia.com.br:82/WebServiceSCEMJavaEnvironment/servlet/awsnfsebarradogarcas';
  ConfigURL.HomSubstituiNFSe      := 'http://servidor1.virtualtechnologia.com.br:82/WebServiceSCEMJavaEnvironment/servlet/awsnfsebarradogarcas';

 	ConfigURL.ProNomeCidade         := '';
  ConfigURL.ProRecepcaoLoteRPS    := '';
  ConfigURL.ProConsultaLoteRPS    := '';
  ConfigURL.ProConsultaNFSeRPS    := '';
  ConfigURL.ProConsultaSitLoteRPS := '';
  ConfigURL.ProConsultaNFSe       := '';
  ConfigURL.ProCancelaNFSe        := 'https://financas2.barradogarcas.mt.gov.br:8080/SCEM/servlet/acancelarnfse_barradogarcas'; // ?wsdl';
  ConfigURL.ProGerarNFSe          := 'https://financas2.barradogarcas.mt.gov.br:8080/SCEM/servlet/agerarnfse_barradogarcas'; //?wsdl';
  ConfigURL.ProRecepcaoSincrono   := '';
  ConfigURL.ProSubstituiNFSe      := '';

 	Result := ConfigURL;
end;

function TProvedorVirtual.GetURI(URI: String): String;
begin
  Result := URI;
end;

function TProvedorVirtual.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
  case Acao of
   acRecepcionar: Result := False;
   acConsSit:     Result := False;
   acConsLote:    Result := False;
   acConsNFSeRps: Result := False;
   acConsNFSe:    Result := False;
   acCancelar:    Result := False;
   acGerar:       Result := False;
   acRecSincrono: Result := False;
   acSubstituir:  Result := False;
  end;
end;

function TProvedorVirtual.GetValidarLote: Boolean;
begin
  Result := True;
end;

function TProvedorVirtual.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
begin
  case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + NameSpaceDad;
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio' + NameSpaceDad;
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + NameSpaceDad;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRps' + NameSpaceDad;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseEnvio' + NameSpaceDad;
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + NameSpaceDad +
                             '<' + Prefixo3 + 'Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                 DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
   acGerar:       Result := '<' + Prefixo3 + 'GerarNfseEnvio' + NameSpaceDad;
   acRecSincrono: Result := '<' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio' + NameSpaceDad;
   acSubstituir:  Result := '<' + Prefixo3 + 'SubstituirNfseEnvio' + NameSpaceDad +
                             '<' + Prefixo3 + 'SubstituicaoNfse>' +
                              '<' + Prefixo3 + 'Pedido>' +
                               '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                  DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
  end;
end;

function TProvedorVirtual.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
  Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
             '<versaoDados>' + VersaoDados + '</versaoDados>'+
            '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorVirtual.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
  Result := '';
end;

function TProvedorVirtual.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
  case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfseRps>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '</' + Prefixo3 + 'Pedido>' +
                            '</' + Prefixo3 + 'CancelarNfseEnvio>';
   acGerar:       Result := '</' + Prefixo3 + 'GerarNfseEnvio>';
   acRecSincrono: Result := '</' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio>';
   acSubstituir:  Result := '</' + Prefixo3 + 'SubstituicaoNfse>' +
                            '</' + Prefixo3 + 'SubstituirNfseEnvio>';
  end;
end;

function TProvedorVirtual.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
  CabMsg := StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);
  DadosMsg := '<?xml version="1.0" encoding="utf-8"?>' + DadosMsg;
  DadosMsg := StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

  result := '<?xml version="1.0" encoding="utf-8"?>' +
            '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
                               'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                               'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
             '<SOAP-ENV:Body>' +
              '<WSNfseBarraDoGarcas.RECEPCIONARLOTERPS xmlns="http://nfse.abrasf.org.br">' +
               '<Entrada>' +
                 '<nfseCabecMsg xmlns="http://www.abrasf.org.br">' +
                   CabMsg +
                 '</nfseCabecMsg>' +
                 '<nfseDadosMsg xmlns="http://www.abrasf.org.br">' +
                   DadosMsg +
                 '</nfseDadosMsg>' +
               '</Entrada>' +
              '</WSNfseBarraDoGarcas.RECEPCIONARLOTERPS>' +
             '</SOAP-ENV:Body>' +
            '</SOAP-ENV:Envelope>';
end;

function TProvedorVirtual.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
  result := '';
end;

function TProvedorVirtual.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
  CabMsg := StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);
  DadosMsg := '<?xml version="1.0" encoding="utf-8"?>' + DadosMsg;
  DadosMsg := StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

  result := '<?xml version="1.0" encoding="utf-8"?>' +
            '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
                               'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                               'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
             '<SOAP-ENV:Body>' +
              '<WSNfseBarraDoGarcas.CONSULTARLOTERPS xmlns="http://nfse.abrasf.org.br">' +
               '<Entrada>' +
                 '<nfseCabecMsg xmlns="http://www.abrasf.org.br">' +
                   CabMsg +
                 '</nfseCabecMsg>' +
                 '<nfseDadosMsg xmlns="http://www.abrasf.org.br">' +
                   DadosMsg +
                 '</nfseDadosMsg>' +
               '</Entrada>' +
              '</WSNfseBarraDoGarcas.CONSULTARLOTERPS>' +
             '</SOAP-ENV:Body>' +
            '</SOAP-ENV:Envelope>';
end;

function TProvedorVirtual.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
  CabMsg := StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);
  DadosMsg := '<?xml version="1.0" encoding="utf-8"?>' + DadosMsg;
  DadosMsg := StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

  result := '<?xml version="1.0" encoding="utf-8"?>' +
            '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
                               'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                               'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
             '<SOAP-ENV:Body>' +
              '<WSNfseBarraDoGarcas.CONSULTARNFSEPORRPS xmlns="http://nfse.abrasf.org.br">' +
               '<Entrada>' +
                 '<nfseCabecMsg xmlns="http://www.abrasf.org.br">' +
                   CabMsg +
                 '</nfseCabecMsg>' +
                 '<nfseDadosMsg xmlns="http://www.abrasf.org.br">' +
                   DadosMsg +
                 '</nfseDadosMsg>' +
               '</Entrada>' +
              '</WSNfseBarraDoGarcas.CONSULTARNFSEPORRPS>' +
             '</SOAP-ENV:Body>' +
            '</SOAP-ENV:Envelope>';
end;

function TProvedorVirtual.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
  CabMsg := StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);
  DadosMsg := '<?xml version="1.0" encoding="utf-8"?>' + DadosMsg;
  DadosMsg := StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

  result := '<?xml version="1.0" encoding="utf-8"?>' +
            '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
                               'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                               'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
             '<SOAP-ENV:Body>' +
              '<WSNfseBarraDoGarcas.CONSULTARNFSEFAIXA xmlns="http://nfse.abrasf.org.br">' +
               '<Entrada>' +
                 '<nfseCabecMsg xmlns="http://www.abrasf.org.br">' +
                   CabMsg +
                 '</nfseCabecMsg>' +
                 '<nfseDadosMsg xmlns="http://www.abrasf.org.br">' +
                   DadosMsg +
                 '</nfseDadosMsg>' +
               '</Entrada>' +
              '</WSNfseBarraDoGarcas.CONSULTARNFSEFAIXA>' +
             '</SOAP-ENV:Body>' +
            '</SOAP-ENV:Envelope>';
end;

function TProvedorVirtual.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
  CabMsg := StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);
  DadosMsg := '<?xml version="1.0" encoding="utf-8"?>' + DadosMsg;
  DadosMsg := StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

  result := '<?xml version="1.0" encoding="utf-8"?>' +
            '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
                               'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                               'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
             '<SOAP-ENV:Body>' +
              '<WSNfseBarraDoGarcas.CANCELARNFSE xmlns="http://nfse.abrasf.org.br">' +
               '<Entrada>' +
                 '<nfseCabecMsg xmlns="http://www.abrasf.org.br">' +
                   CabMsg +
                 '</nfseCabecMsg>' +
                 '<nfseDadosMsg xmlns="http://www.abrasf.org.br">' +
                   DadosMsg +
                 '</nfseDadosMsg>' +
               '</Entrada>' +
              '</WSNfseBarraDoGarcas.CANCELARNFSE>' +
             '</SOAP-ENV:Body>' +
            '</SOAP-ENV:Envelope>';
end;

function TProvedorVirtual.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
  CabMsg := StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);
  DadosMsg := '<?xml version="1.0" encoding="utf-8"?>' + DadosMsg;
  DadosMsg := StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

  result := '<?xml version="1.0" encoding="utf-8"?>' +
            '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
                               'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                               'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
             '<SOAP-ENV:Body>' +
              '<WSNfseBarraDoGarcas.GERARNFSE xmlns="http://nfse.abrasf.org.br">' +
               '<Entrada>' +
                 '<nfseCabecMsg xmlns="http://www.abrasf.org.br">' +
                   CabMsg +
                 '</nfseCabecMsg>' +
                 '<nfseDadosMsg xmlns="http://www.abrasf.org.br">' +
                   DadosMsg +
                 '</nfseDadosMsg>' +
               '</Entrada>' +
              '</WSNfseBarraDoGarcas.GERARNFSE>' +
             '</SOAP-ENV:Body>' +
            '</SOAP-ENV:Envelope>';
end;

function TProvedorVirtual.GeraEnvelopeRecepcionarSincrono(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
  CabMsg := StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);
  DadosMsg := '<?xml version="1.0" encoding="utf-8"?>' + DadosMsg;
  DadosMsg := StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

  result := '<?xml version="1.0" encoding="utf-8"?>' +
            '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
                               'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                               'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
             '<SOAP-ENV:Body>' +
              '<WSNfseBarraDoGarcas.RECEPCIONARLOTERPSSINCRONO xmlns="http://nfse.abrasf.org.br">' +
               '<Entrada>' +
                 '<nfseCabecMsg xmlns="http://www.abrasf.org.br">' +
                   CabMsg +
                 '</nfseCabecMsg>' +
                 '<nfseDadosMsg xmlns="http://www.abrasf.org.br">' +
                   DadosMsg +
                 '</nfseDadosMsg>' +
               '</Entrada>' +
              '</WSNfseBarraDoGarcas.RECEPCIONARLOTERPSSINCRONO>' +
             '</SOAP-ENV:Body>' +
            '</SOAP-ENV:Envelope>';
end;

function TProvedorVirtual.GeraEnvelopeSubstituirNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
  CabMsg := StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);
  DadosMsg := '<?xml version="1.0" encoding="utf-8"?>' + DadosMsg;
  DadosMsg := StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

  result := '<?xml version="1.0" encoding="utf-8"?>' +
            '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
                               'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                               'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
             '<SOAP-ENV:Body>' +
              '<WSNfseBarraDoGarcas.SUBSTITUIRNFSE xmlns="http://nfse.abrasf.org.br">' +
               '<Entrada>' +
                 '<nfseCabecMsg xmlns="http://www.abrasf.org.br">' +
                   CabMsg +
                 '</nfseCabecMsg>' +
                 '<nfseDadosMsg xmlns="http://www.abrasf.org.br">' +
                   DadosMsg +
                 '</nfseDadosMsg>' +
               '</Entrada>' +
              '</WSNfseBarraDoGarcas.SUBSTITUIRNFSE>' +
             '</SOAP-ENV:Body>' +
            '</SOAP-ENV:Envelope>';
end;

function TProvedorVirtual.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
  case Acao of
   acRecepcionar: Result := 'http://nfse.abrasf.org.braction/AWSNFSEBARRADOGARCAS.RECEPCIONARLOTERPS';
   acConsSit:     Result := '';
   acConsLote:    Result := 'http://nfse.abrasf.org.braction/AWSNFSEBARRADOGARCAS.CONSULTARLOTERPS';
   acConsNFSeRps: Result := 'http://nfse.abrasf.org.braction/AWSNFSEBARRADOGARCAS.CONSULTARNFSEPORRPS';
   acConsNFSe:    Result := 'http://nfse.abrasf.org.braction/AWSNFSEBARRADOGARCAS.CONSULTARNFSEFAIXA';
   acCancelar:    Result := 'http://nfse.abrasf.org.braction/AWSNFSEBARRADOGARCAS.CANCELARNFSE';
   acGerar:       Result := 'http://nfse.abrasf.org.braction/AWSNFSEBARRADOGARCAS.GERARNFSE';
   acRecSincrono: Result := 'http://nfse.abrasf.org.braction/AWSNFSEBARRADOGARCAS.RECEPCIONARLOTERPSSINCRONO';
   acSubstituir:  Result := 'http://nfse.abrasf.org.braction/AWSNFSEBARRADOGARCAS.SUBSTITUIRNFSE';
  end;
end;

function TProvedorVirtual.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
  case Acao of
   acRecepcionar: Result := RetornoWS;
   acConsSit:     Result := RetornoWS;
   acConsLote:    Result := RetornoWS;
   acConsNFSeRps: Result := RetornoWS;
   acConsNFSe:    Result := RetornoWS;
   acCancelar:    Result := RetornoWS; // SeparaDados( RetornoWS, 'nfse_barradogarcas.CANCELARNFSEResponse' );
   acGerar:       Result := RetornoWS; // SeparaDados( RetornoWS, 'Saida' );
   acRecSincrono: Result := RetornoWS;
   acSubstituir:  Result := RetornoWS;
  end;
end;

function TProvedorVirtual.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
  Result := '<?xml version="1.0" encoding="UTF-8"?>' +
            '<CompNfse xmlns="http://www.abrasf.org.br/nfse.xsd">' +
             RetNFSe +
            '</CompNfse>';
end;

function TProvedorVirtual.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
  // N�o implementada
  Result := ''; 
end;

end.
