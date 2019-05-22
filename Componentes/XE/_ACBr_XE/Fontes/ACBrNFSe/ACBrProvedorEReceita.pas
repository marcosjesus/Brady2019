{$I ACBr.inc}

unit ACBrProvedorEReceita;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorEReceita }

  TProvedorEReceita = class(TProvedorClass)
  protected
   { protected }
  private
    function GeraEnvelopeSubstituirNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
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

   function GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String; OverRide;
   function GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString; OverRide;

   function GeraRetornoNFSe(Prefixo: String; RetNFSe: AnsiString; NomeCidade: String): AnsiString; OverRide;
   function GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer; ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String; OverRide;
  end;

implementation

{ TProvedorEReceita }

constructor TProvedorEReceita.Create;
begin
 {-----}
end;

function TProvedorEReceita.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap        := '1.1';
 ConfigCidade.Prefixo2          := '';
 ConfigCidade.Prefixo3          := '';
 ConfigCidade.Prefixo4          := '';
 ConfigCidade.Identificador     := 'Id';
 ConfigCidade.QuebradeLinha     := ';';
 ConfigCidade.NameSpaceEnvelope := 'http://nfse.montesclaros.mg.gov.br/soap/NfseWebService'; //'http://nfse.abrasf.org.br';

 ConfigCidade.AssinaRPS         := True;
 ConfigCidade.AssinaLote        := True;
 ConfigCidade.AssinaGerar       := True;

 Result := ConfigCidade;
end;

function TProvedorEReceita.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
  ConfigSchema.VersaoCabecalho       := '2.02';
  ConfigSchema.VersaoDados           := '2.02';
  ConfigSchema.VersaoXML             := '2';
  ConfigSchema.NameSpaceXML          := 'http://www.abrasf.org.br/';//'http://webservice.ereceita.net.br/soap/NfseWebService';
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

function TProvedorEReceita.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 case ACodCidade of

  3143302: begin // Montes Claros/MG
            ConfigURL.HomNomeCidade         := 'Montes Claros';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsHomologacao.php';
            ConfigURL.HomConsultaLoteRPS    := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsHomologacao.php';
            ConfigURL.HomConsultaNFSeRPS    := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsHomologacao.php';
            ConfigURL.HomConsultaSitLoteRPS := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsHomologacao.php';
            ConfigURL.HomConsultaNFSe       := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsHomologacao.php';
            ConfigURL.HomCancelaNFSe        := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsHomologacao.php';
            ConfigURL.HomGerarNFSe          := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsHomologacao.php';
            ConfigURL.HomConsultaSeqRPS     := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsHomologacao.php';
            ConfigURL.HomRecepcaoSincrono   := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsHomologacao.php';
            ConfigURL.HomSubstituiNFSe      := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsHomologacao.php';

            ConfigURL.ProNomeCidade         := 'Montes Claros';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsProducao.php';
            ConfigURL.ProConsultaLoteRPS    := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsProducao.php';
            ConfigURL.ProConsultaNFSeRPS    := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsProducao.php';
            ConfigURL.ProConsultaSitLoteRPS := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsProducao.php';
            ConfigURL.ProConsultaNFSe       := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsProducao.php';
            ConfigURL.ProCancelaNFSe        := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsProducao.php';
            ConfigURL.ProGerarNFSe          := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsProducao.php';
            ConfigURL.ProConsultaSeqRPS     := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsProducao.php';
            ConfigURL.ProRecepcaoSincrono   := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsProducao.php';
            ConfigURL.ProSubstituiNFSe      := 'http://nfse.montesclaros.mg.gov.br/ws/montesclaros/wsProducao.php';
           end;
 end;

 Result := ConfigURL;
end;

function TProvedorEReceita.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorEReceita.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 case Acao of
   acRecepcionar: Result := false;
   acConsSit:     Result := false;
   acConsLote:    Result := False;
   acConsNFSeRps: Result := false;
   acConsNFSe:    Result := false;
   acCancelar:    Result := True;
   acGerar:       Result := True;
   acRecSincrono: Result := false;
   acSubstituir:  Result := false;
 end;
end;

function TProvedorEReceita.GetValidarLote: Boolean;
begin
 Result := False;
end;

function TProvedorEReceita.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
var
  xmlns: String;
begin
  xmlns := NameSpaceDad;

  case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + xmlns;
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio' + xmlns;
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + xmlns;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio' + xmlns;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseServicoPrestadoEnvio' + xmlns;
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + xmlns +
                             '<' + Prefixo3 + 'Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                 DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
   acGerar:       Result := '<' + Prefixo3 + 'GerarNfseEnvio' + xmlns;
   acRecSincrono: Result := '<' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio' + xmlns;
   acSubstituir:  Result := '<' + Prefixo3 + 'SubstituirNfseEnvio' + xmlns +
                             '<' + Prefixo3 + 'SubstituicaoNfse>' +
                              '<' + Prefixo3 + 'Pedido>' +
                               '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                  DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
  end;
end;

function TProvedorEReceita.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho' +
            ' versao="'  + VersaoLayOut + '"' +
             ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"'+
             ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"'+
              NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorEReceita.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorEReceita.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
  case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfseRpsEnvio>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseServicoPrestadoEnvio>';
   acCancelar:    Result := '</' + Prefixo3 + 'Pedido>' +
                            '</' + Prefixo3 + 'CancelarNfseEnvio>';
   acGerar:       Result := '</' + Prefixo3 + 'GerarNfseEnvio>';
   acRecSincrono: Result := '</' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio>';
   acSubstituir:  Result := '</' + Prefixo3 + 'SubstituicaoNfse>' +
                            '</' + Prefixo3 + 'SubstituirNfseEnvio>';
  end;
end;

function TProvedorEReceita.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 CabMsg   := StringReplace(StringReplace('<?xml version="1.0" encoding="utf-8"?>' +CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);
 DadosMsg := StringReplace(StringReplace('<?xml version="1.0" encoding="utf-8"?>' +DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" '+
                       'xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                       'xmlns:nfse="http://www.ereceita.net.br/soap/NfseWebService" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">' +
            '<SOAP-ENV:Header />' +
            '<SOAP-ENV:Body>' +
             '<nfse:RecepcionarLoteRpsRequest xmlns="' + URLNS + '/">' +
              '<nfseCabecMsg xmlns="">' +
                CabMsg +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg xmlns="">' +
                DadosMsg +
              '</nfseDadosMsg>' +
             '</nfse:RecepcionarLoteRpsRequest>' +
            '</SOAP-ENV:Body>' +
           '</SOAP-ENV:Envelope>';
end;

function TProvedorEReceita.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
end;

function TProvedorEReceita.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 CabMsg   := StringReplace(StringReplace('<?xml version="1.0" encoding="utf-8"?>' +CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);
 DadosMsg := StringReplace(StringReplace('<?xml version="1.0" encoding="utf-8"?>' +DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" '+
                       'xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                       'xmlns:nfse="http://www.ereceita.net.br/soap/NfseWebService" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">' +
            '<SOAP-ENV:Body>' +
             '<nfse:ConsultarLoteRpsRequest xmlns="' + URLNS + '/">' +
              '<nfseCabecMsg xmlns="">' +
                CabMsg +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg xmlns="">' +
                DadosMsg +
              '</nfseDadosMsg>' +
             '</nfse:ConsultarLoteRpsRequest>' +
            '</SOAP-ENV:Body>' +
           '</SOAP-ENV:Envelope>';
end;

function TProvedorEReceita.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 CabMsg   := StringReplace(StringReplace('<?xml version="1.0" encoding="utf-8"?>' +CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);
 DadosMsg := StringReplace(StringReplace('<?xml version="1.0" encoding="utf-8"?>' +DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" '+
                       'xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                       'xmlns:nfse="http://www.ereceita.net.br/soap/NfseWebService" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">' +
            '<SOAP-ENV:Header />' +
            '<SOAP-ENV:Body>' +
             '<nfse:ConsultarNfsePorRpsRequest xmlns="' + URLNS + '/">' +
              '<nfseCabecMsg xmlns="">' +
                CabMsg +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg xmlns="">' +
                DadosMsg +
              '</nfseDadosMsg>' +
             '</nfse:ConsultarNfsePorRpsRequest>' +
            '</SOAP-ENV:Body>' +
           '</SOAP-ENV:Envelope>';
end;

function TProvedorEReceita.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 CabMsg   := StringReplace(StringReplace('<?xml version="1.0" encoding="utf-8"?>' +CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);
 DadosMsg := StringReplace(StringReplace('<?xml version="1.0" encoding="utf-8"?>' +DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" '+
                       'xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                       'xmlns:nfse="http://www.ereceita.net.br/soap/NfseWebService" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">' +
            '<SOAP-ENV:Header />' +
            '<SOAP-ENV:Body>' +
             '<nfse:ConsultarNfsePorFaixaRequest xmlns="' + URLNS + '/">' +
              '<nfseCabecMsg xmlns="">' +
                CabMsg +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg xmlns="">' +
                DadosMsg +
              '</nfseDadosMsg>' +
             '</nfse:ConsultarNfsePorFaixaRequest>' +
            '</SOAP-ENV:Body>' +
           '</SOAP-ENV:Envelope>';
end;

function TProvedorEReceita.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 CabMsg   := StringReplace(StringReplace('<?xml version="1.0" encoding="utf-8"?>' +CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);
 DadosMsg := StringReplace(StringReplace('<?xml version="1.0" encoding="utf-8"?>' +DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" '+
                       'xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                       'xmlns:nfse="http://www.ereceita.net.br/soap/NfseWebService" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">' +
            '<SOAP-ENV:Header />' +
            '<SOAP-ENV:Body>' +
             '<nfse:CancelarNfseRequest xmlns="' + URLNS + '/">' +
              '<nfseCabecMsg xmlns="">' +
                CabMsg +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg xmlns="">' +
                DadosMsg +
              '</nfseDadosMsg>' +
             '</nfse:CancelarNfseRequest>' +
            '</SOAP-ENV:Body>' +
           '</SOAP-ENV:Envelope>';
end;

function TProvedorEReceita.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
var
  teste: TStringList;
begin
 CabMsg   := StringReplace(StringReplace('<?xml version="1.0" encoding="utf-8"?>' +CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);
 DadosMsg := StringReplace(StringReplace('<?xml version="1.0" encoding="utf-8"?>' +DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" '+
                       'xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                       'xmlns:nfse="http://www.ereceita.net.br/soap/NfseWebService" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">' +
            '<SOAP-ENV:Header />' +
            '<SOAP-ENV:Body>' +
             '<nfse:GerarNfseRequest xmlns="' + URLNS + '/">' +
              '<nfseCabecMsg xmlns="">' +
                CabMsg +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg xmlns="">' +
                DadosMsg +
              '</nfseDadosMsg>' +
             '</nfse:GerarNfseRequest>' +
            '</SOAP-ENV:Body>' +
           '</SOAP-ENV:Envelope>';
end;

function TProvedorEReceita.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 CabMsg   := StringReplace(StringReplace('<?xml version="1.0" encoding="utf-8"?>' +CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);
 DadosMsg := StringReplace(StringReplace('<?xml version="1.0" encoding="utf-8"?>' +DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<SOAP-ENV:Envelope SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" '+
                       'xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                       'xmlns:nfse="http://www.ereceita.net.br/soap/NfseWebService" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">' +
            '<SOAP-ENV:Header />' +
            '<SOAP-ENV:Body>' +
             '<nfse:RecepcionarLoteRpsSincronoRequest xmlns="' + URLNS + '/">' +
              '<nfseCabecMsg xmlns="">' +
                CabMsg +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg xmlns="">' +
                DadosMsg +
              '</nfseDadosMsg>' +
             '</nfse:RecepcionarLoteRpsSincronoRequest>' +
            '</SOAP-ENV:Body>' +
           '</SOAP-ENV:Envelope>';
end;

function TProvedorEReceita.GeraEnvelopeSubstituirNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
  Result := '';
end;

function TProvedorEReceita.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://nfse.montesclaros.mg.gov.br/RecepcionarLoteRps';
   acConsSit:     Result := 'http://nfse.montesclaros.mg.gov.br/ConsultarLoteRps';
   acConsLote:    Result := 'http://nfse.montesclaros.mg.gov.br/ConsultarLoteRps';
   acConsNFSeRps: Result := 'http://nfse.montesclaros.mg.gov.br/ConsultarNfsePorRps';
   acConsNFSe:    Result := 'http://nfse.montesclaros.mg.gov.br/ConsultarNfsePorFaixa';
   acCancelar:    Result := 'http://nfse.montesclaros.mg.gov.br/CancelarNfse';
   acGerar:       Result := 'http://nfse.montesclaros.mg.gov.br/GerarNfse';
   acSubstituir:  Result := 'http://nfse.montesclaros.mg.gov.br/SubstituirNfse';
   acRecSincrono: Result := 'http://nfse.montesclaros.mg.gov.br/RecepcionarLoteRpsSincrono';
 end;
end;

function TProvedorEReceita.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'Outputxml' );
   acConsSit:     Result := SeparaDados( RetornoWS, 'Outputxml' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'Outputxml' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'Outputxml' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'Outputxml' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'Outputxml' );
   acGerar:       Result := SeparaDados( RetornoWS, 'Outputxml' );
   acRecSincrono: Result := SeparaDados( RetornoWS, 'Outputxml' );
   acSubstituir:  Result := SeparaDados( RetornoWS, 'Outputxml' );
 end;
//   acRecepcionar: Result := SeparaDados( RetornoWS, 'RecepcionarLoteRpsResponse' );
//   acConsSit:     Result := RetornoWS;
//   acConsLote:    Result := SeparaDados( RetornoWS, 'ConsultarLoteRpsResponse' );
//   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'ConsultarNfsePorRpsResponse' );
//   acConsNFSe:    Result := SeparaDados( RetornoWS, 'ConsultarNfsePorFaixaResponse' );
//   acCancelar:    Result := SeparaDados( RetornoWS, 'CancelarNfseResponse' );
//   acGerar:       Result := SeparaDados( RetornoWS, 'GerarNfseResponse' );
//   acRecSincrono: Result := SeparaDados( RetornoWS, 'RecepcionarLoteRpsSincronoResponse');
//   acSubstituir:  Result := RetornoWS;
// end;
end;

function TProvedorEReceita.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';

end;

function TProvedorEReceita.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.
