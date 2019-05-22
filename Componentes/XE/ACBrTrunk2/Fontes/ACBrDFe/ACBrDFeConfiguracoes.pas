{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Nota Fiscal}
{ eletr�nica - NFe - http://www.nfe.fazenda.gov.br                             }

{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }

{ Colaboradores nesse arquivo:                                                 }

{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }


{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }

{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }

{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }

{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }

{******************************************************************************}

{$I ACBr.inc}

unit ACBrDFeConfiguracoes;

interface

uses
  Classes, SysUtils, types,
  pcnConversao, pcnAuxiliar,
  ACBrDFeSSL;

type

  TConfiguracoes = class;

  { TCertificadosConf }

  TCertificadosConf = class(TComponent)
  private
    FConfiguracoes: TConfiguracoes;
    FDadosPFX: AnsiString;
    FSenha: AnsiString;
    FK: String;
    FNumeroSerie: String;
    FArquivoPFX: String;
    FVerificarValidade: Boolean;

    function GetSenha: AnsiString;
    procedure SetArquivoPFX(AValue: String);
    procedure SetDadosPFX(AValue: AnsiString);
    procedure SetNumeroSerie(const AValue: String);
    procedure SetSenha(AValue: AnsiString);
  public
    constructor Create(AConfiguracoes: TConfiguracoes); reintroduce; overload;
    procedure Assign(DeCertificadosConf: TCertificadosConf); reintroduce; virtual;

  published
    property ArquivoPFX: String read FArquivoPFX write SetArquivoPFX;
    property DadosPFX: AnsiString read FDadosPFX write SetDadosPFX;
    property NumeroSerie: String read FNumeroSerie write SetNumeroSerie;
    property Senha: AnsiString read GetSenha write SetSenha;
    property VerificarValidade: Boolean read FVerificarValidade write
      FVerificarValidade default True;
  end;

  { TWebServicesConf }

  TWebServicesConf = class(TComponent)
  private
    FConfiguracoes: TConfiguracoes;
    FResourceName: String;
    FTimeOut: Integer;
    FTimeZoneConf: TTimeZoneConf;
    FVisualizar: Boolean;
    FUF: String;
    FUFCodigo: integer;
    FAmbiente: TpcnTipoAmbiente;
    FAmbienteCodigo: integer;
    FProxyHost: String;
    FProxyPort: String;
    FProxyUser: String;
    FProxyPass: String;
    FAguardarConsultaRet: cardinal;
    FTentativas: integer;
    FIntervaloTentativas: cardinal;
    FAjustaAguardaConsultaRet: Boolean;
    FSalvar: Boolean;
    FParams: TStrings;
    FQuebradeLinha: String;

    procedure SetProxyHost(AValue: String);
    procedure SetProxyPass(AValue: String);
    procedure SetProxyPort(AValue: String);
    procedure SetProxyUser(AValue: String);
    procedure SetTimeOut(AValue: Integer);
    procedure SetUF(AValue: String);
    procedure SetAmbiente(AValue: TpcnTipoAmbiente);
    procedure SetTentativas(const Value: integer);
    procedure SetIntervaloTentativas(const Value: cardinal);
    procedure SetParams(const AValue: TStrings);

  protected
    function LerParamsIniServicos: AnsiString; virtual;
    function LerParamsInterno: AnsiString; virtual;
  public
    constructor Create(AConfiguracoes: TConfiguracoes); reintroduce; overload;
    destructor Destroy; override;
    procedure Assign(DeWebServicesConf: TWebServicesConf); reintroduce; virtual;

    procedure LerParams; virtual;

    property ResourceName: String read FResourceName write FResourceName;
  published
    property Visualizar: Boolean read FVisualizar write FVisualizar default False;
    property UF: String read FUF write SetUF;
    property UFCodigo: integer read FUFCodigo;
    property Ambiente: TpcnTipoAmbiente
      read FAmbiente write SetAmbiente default taHomologacao;
    property AmbienteCodigo: integer read FAmbienteCodigo;
    property ProxyHost: String read FProxyHost write SetProxyHost;
    property ProxyPort: String read FProxyPort write SetProxyPort;
    property ProxyUser: String read FProxyUser write SetProxyUser;
    property ProxyPass: String read FProxyPass write SetProxyPass;
    property AguardarConsultaRet: cardinal read FAguardarConsultaRet
      write FAguardarConsultaRet;
    property Tentativas: integer read FTentativas write SetTentativas default 5;
    property IntervaloTentativas: cardinal read FIntervaloTentativas
      write SetIntervaloTentativas default 1000;
    property AjustaAguardaConsultaRet: Boolean
      read FAjustaAguardaConsultaRet write FAjustaAguardaConsultaRet default False;
    // WebService.Salvar - trata-se de arquivos gerais envelopados, ou seja,
    // arquivos de envio e de retorno sem validade jur�dica
    property Salvar: Boolean read FSalvar write FSalvar default False;
    property Params: TStrings read FParams write SetParams;
    property TimeOut: Integer read FTimeOut write SetTimeOut default 5000;
    property QuebradeLinha: String read FQuebradeLinha write FQuebradeLinha;
    property TimeZoneConf: TTimeZoneConf read FTimeZoneConf write FTimeZoneConf;
  end;

  { TGeralConf }

  TGeralConf = class(TComponent)
  private
    FConfiguracoes: TConfiguracoes;
    FIdentarXML: Boolean;
    FSSLLib: TSSLLib;
    FSSLCryptLib: TSSLCryptLib;
    FSSLHttpLib: TSSLHttpLib;
    FFormaEmissao: TpcnTipoEmissao;
    FFormaEmissaoCodigo: integer;
    FSalvar: Boolean;
    FExibirErroSchema: Boolean;
    FFormatoAlerta: String;
    FRetirarAcentos: Boolean;
    FRetirarEspacos: Boolean;
    FSSLXmlSignLib: TSSLXmlSignLib;
    FValidarDigest: Boolean;
    FCalcSSLLib: Boolean;

    procedure SetSSLLib(AValue: TSSLLib);
    procedure SetSSLCryptLib(AValue: TSSLCryptLib);
    procedure SetSSLHttpLib(AValue: TSSLHttpLib);
    procedure CalcSSLLib;

    procedure SetFormaEmissao(AValue: TpcnTipoEmissao);
    function GetFormatoAlerta: String;
    procedure SetSSLXmlSignLib(AValue: TSSLXmlSignLib);
  public
    constructor Create(AConfiguracoes: TConfiguracoes); reintroduce; overload; virtual;
    procedure Assign(DeGeralConf: TGeralConf); reintroduce; virtual;

  published
    property SSLLib: TSSLLib read FSSLLib write SetSSLLib;
    property SSLCryptLib: TSSLCryptLib read FSSLCryptLib write SetSSLCryptLib;
    property SSLHttpLib: TSSLHttpLib read FSSLHttpLib write SetSSLHttpLib;
    property SSLXmlSignLib: TSSLXmlSignLib read FSSLXmlSignLib write SetSSLXmlSignLib;

    property FormaEmissao: TpcnTipoEmissao read FFormaEmissao
      write SetFormaEmissao default teNormal;
    property FormaEmissaoCodigo: integer read FFormaEmissaoCodigo;
    // Geral.Salvar - trata-se de arquivos gerais, ou seja, arquivos de envio e
    // de retorno sem validade jur�dica.
    property Salvar: Boolean read FSalvar write FSalvar default True;
    property ExibirErroSchema: Boolean read FExibirErroSchema
      write FExibirErroSchema default True;
    property FormatoAlerta: String read GetFormatoAlerta write FFormatoAlerta;
    property RetirarAcentos: Boolean read FRetirarAcentos
      write FRetirarAcentos default True;
    property RetirarEspacos: Boolean read FRetirarEspacos
      write FRetirarEspacos default True;
    property IdentarXML: Boolean read FIdentarXML write FIdentarXML default False;
    property ValidarDigest: Boolean
      read FValidarDigest write FValidarDigest default True;
  end;

  { TArquivosConf }

  TArquivosConf = class(TComponent)
  private
    FPathSalvar: String;
    FPathSchemas: String;
    FIniServicos: String;

    FSalvar: Boolean;
    FAdicionarLiteral: Boolean;
    FSepararPorCNPJ: Boolean;
    FSepararPorModelo: Boolean;
    FSepararPorMes: Boolean;
    FSepararPorDia: Boolean;
  private
    function GetIniServicos: String;
    function GetPathSalvar: String;
    function GetPathSchemas: String;
    procedure SetSepararPorDia(const Value: Boolean);
    procedure SetSepararPorMes(const Value: Boolean);
  protected
    fpConfiguracoes: TConfiguracoes;
  public
    constructor Create(AConfiguracoes: TConfiguracoes); reintroduce; overload; virtual;
    procedure Assign(DeArquivosConf: TArquivosConf); reintroduce; virtual;

    function GetPath(APath: String; ALiteral: String; CNPJ: String = '';
      Data: TDateTime = 0): String; virtual;
  published
    property PathSalvar: String read GetPathSalvar write FPathSalvar;
    property PathSchemas: String read GetPathSchemas write FPathSchemas;
    property IniServicos: String read GetIniServicos write FIniServicos;
    // Arquivos.Salvar - trata-se de arquivos com validade jur�dica.
    property Salvar: Boolean read FSalvar write FSalvar default True;
    property AdicionarLiteral: Boolean read FAdicionarLiteral
      write FAdicionarLiteral default False;
    property SepararPorCNPJ: Boolean read FSepararPorCNPJ write FSepararPorCNPJ default False;
    property SepararPorModelo: Boolean read FSepararPorModelo
      write FSepararPorModelo default False;
    property SepararPorMes: Boolean
      read FSepararPorMes write SetSepararPorMes default False;
    property SepararPorDia: Boolean
      read FSepararPorDia write SetSepararPorDia default False;
  end;

  { TConfiguracoes }

  TConfiguracoes = class(TComponent)
  protected
    FPGeral: TGeralConf;
    FPWebServices: TWebServicesConf;
    FPCertificados: TCertificadosConf;
    FPArquivos: TArquivosConf;
  protected
    procedure CreateGeralConf; virtual;
    procedure CreateWebServicesConf; virtual;
    procedure CreateCertificadosConf; virtual;
    procedure CreateArquivosConf; virtual;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(DeConfiguracoes: TConfiguracoes); reintroduce; virtual;

    procedure LerParams(NomeArqParams: String = '');

    property Geral: TGeralConf read FPGeral;
    property WebServices: TWebServicesConf read FPWebServices;
    property Certificados: TCertificadosConf read FPCertificados;
    property Arquivos: TArquivosConf read FPArquivos;
  end;

implementation

uses
  Math, strutils, DateUtils,
  ACBrDFe, ACBrDFeException, ACBrUtil, synautil;

{ TConfiguracoes }

constructor TConfiguracoes.Create(AOwner: TComponent);
begin
  if not (AOwner is TACBrDFe) then
    raise EACBrDFeException.Create('Owner de TConfiguracoes deve ser do tipo TACBrDFe');

  inherited Create(AOwner);

  CreateGeralConf;
  FPGeral.Name := 'GeralConf';
  {$IFDEF COMPILER6_UP}
  FPGeral.SetSubComponent(True);{ para gravar no DFM/XFM }
  {$ENDIF}

  CreateWebServicesConf;
  FPWebServices.Name := 'WebServicesConf';
  {$IFDEF COMPILER6_UP}
  FPWebServices.SetSubComponent(True);{ para gravar no DFM/XFM }
  {$ENDIF}

  CreateCertificadosConf;
  FPCertificados.Name := 'CertificadosConf';
  {$IFDEF COMPILER6_UP}
  FPCertificados.SetSubComponent(True);{ para gravar no DFM/XFM }
  {$ENDIF}

  CreateArquivosConf;
  FPArquivos.Name := 'ArquivosConf';
  {$IFDEF COMPILER6_UP}
  FPArquivos.SetSubComponent(True);{ para gravar no DFM/XFM }
  {$ENDIF}
end;

procedure TConfiguracoes.CreateGeralConf;
begin
  FPGeral := TGeralConf.Create(Self);
end;

procedure TConfiguracoes.CreateWebServicesConf;
begin
  FPWebServices := TWebServicesConf.Create(self);
end;

procedure TConfiguracoes.CreateCertificadosConf;
begin
  FPCertificados := TCertificadosConf.Create(self);
end;

procedure TConfiguracoes.CreateArquivosConf;
begin
  FPArquivos := TArquivosConf.Create(self);
end;

destructor TConfiguracoes.Destroy;
begin
  FPGeral.Free;
  FPWebServices.Free;
  FPCertificados.Free;
  FPArquivos.Free;

  inherited;
end;

procedure TConfiguracoes.Assign(DeConfiguracoes: TConfiguracoes);
begin
  Geral.Assign(DeConfiguracoes.Geral);
  WebServices.Assign(DeConfiguracoes.WebServices);
  Certificados.Assign(DeConfiguracoes.Certificados);
  Arquivos.Assign(DeConfiguracoes.Arquivos);
end;

procedure TConfiguracoes.LerParams(NomeArqParams: String);
var
  SL: TStringList;
begin
  if not FileExists(NomeArqParams) then
    raise EACBrDFeException.Create('Arquivo de Par�metro n�o encontrado: ' +
      NomeArqParams);

  SL := TStringList.Create;
  try
    FPWebServices.Params := SL;
  finally
    SL.Free;
  end;
end;

{ TGeralConf }

constructor TGeralConf.Create(AConfiguracoes: TConfiguracoes);
begin
  inherited Create(AConfiguracoes);

  FConfiguracoes := AConfiguracoes;
  FSSLLib := libNone;
  FSSLCryptLib := cryNone;
  FSSLHttpLib := httpNone;
  FFormaEmissao := teNormal;
  FFormaEmissaoCodigo := StrToInt(TpEmisToStr(FFormaEmissao));
  FSalvar := True;
  FExibirErroSchema := True;
  FFormatoAlerta := 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.';
  // O Formato da mensagem de erro pode ser alterado pelo usuario alterando-se a property FFormatoAlerta: onde;
  // %TAGNIVEL%  : Representa o Nivel da TAG; ex: <transp><vol><lacres>
  // %TAG%       : Representa a TAG; ex: <nLacre>
  // %ID%        : Representa a ID da TAG; ex X34
  // %MSG%       : Representa a mensagem de alerta
  // %DESCRICAO% : Representa a Descri��o da TAG
  FRetirarAcentos := True;
  FRetirarEspacos := True;
  FIdentarXML := False;
  FValidarDigest := True;
  FCalcSSLLib := True;
end;

procedure TGeralConf.Assign(DeGeralConf: TGeralConf);
begin
  SSLLib           := DeGeralConf.SSLLib;
  SSLCryptLib      := DeGeralConf.SSLCryptLib;
  SSLHttpLib       := DeGeralConf.SSLHttpLib;
  SSLXmlSignLib    := DeGeralConf.SSLXmlSignLib;
  FormaEmissao     := DeGeralConf.FormaEmissao;
  Salvar           := DeGeralConf.Salvar;
  ExibirErroSchema := DeGeralConf.ExibirErroSchema;
  FormatoAlerta    := DeGeralConf.FormatoAlerta;
  RetirarAcentos   := DeGeralConf.RetirarAcentos;
  RetirarEspacos   := DeGeralConf.RetirarEspacos;
  ValidarDigest    := DeGeralConf.ValidarDigest;
end;

function TGeralConf.GetFormatoAlerta: String;
begin
  if (FFormatoAlerta = '') or ((pos('%TAGNIVEL%', FFormatoAlerta) <= 0) and
    (pos('%TAG%', FFormatoAlerta) <= 0) and (pos('%ID%', FFormatoAlerta) <= 0) and
    (pos('%MSG%', FFormatoAlerta) <= 0) and
    (pos('%DESCRICAO%', FFormatoAlerta) <= 0)) then
    Result := 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
  else
    Result := FFormatoAlerta;
end;

procedure TGeralConf.SetFormaEmissao(AValue: TpcnTipoEmissao);
begin
  FFormaEmissao := AValue;
  FFormaEmissaoCodigo := StrToInt(TpEmisToStr(FFormaEmissao));
end;

procedure TGeralConf.SetSSLLib(AValue: TSSLLib);
begin
  FCalcSSLLib := False;
  try
    case AValue of
      libNone:
      begin
        SSLCryptLib := cryNone;
        SSLHttpLib := httpNone;
        SSLXmlSignLib := xsNone;
      end;

      libOpenSSL:
      begin
        SSLCryptLib := cryOpenSSL;
        SSLHttpLib := httpOpenSSL;
        SSLXmlSignLib := xsXmlSec;
      end;

      libCapicom:
      begin
        SSLCryptLib := cryCapicom;
        SSLHttpLib := httpWinINet;
        SSLXmlSignLib := xsMsXmlCapicom;
      end;

      libCapicomDelphiSoap:
      begin
        SSLCryptLib := cryCapicom;
        SSLHttpLib := httpIndy;
        SSLXmlSignLib := xsMsXmlCapicom;
      end;

      libWinCrypt:
      begin
        SSLCryptLib := cryWinCrypt;
        SSLHttpLib := httpWinHttp;
        SSLXmlSignLib := xsMsXml;
      end;
    end;
  finally
    FCalcSSLLib := True;
  end;

  FSSLLib := AValue;
end;

procedure TGeralConf.SetSSLCryptLib(AValue: TSSLCryptLib);
begin
  TACBrDFe(FConfiguracoes.Owner).SSL.SSLCryptLib := AValue;
  FSSLCryptLib := AValue;
  CalcSSLLib;
end;

procedure TGeralConf.SetSSLHttpLib(AValue: TSSLHttpLib);
begin
  TACBrDFe(FConfiguracoes.Owner).SSL.SSLHttpLib := AValue;
  FSSLHttpLib := AValue;
  CalcSSLLib;
end;

procedure TGeralConf.SetSSLXmlSignLib(AValue: TSSLXmlSignLib);
begin
  TACBrDFe(FConfiguracoes.Owner).SSL.SSLXmlSignLib := AValue;
  FSSLXmlSignLib := AValue;
  CalcSSLLib;
end;


procedure TGeralConf.CalcSSLLib;
begin
  if not FCalcSSLLib then Exit;

  if (SSLCryptLib = cryOpenSSL) and (SSLHttpLib = httpOpenSSL) and (SSLXmlSignLib = xsXmlSec) then
    FSSLLib := libOpenSSL

  else if (SSLCryptLib = cryNone) and (SSLHttpLib = httpNone) and (SSLXmlSignLib = xsNone)then
    FSSLLib := libNone

  else if (SSLCryptLib = cryCapicom) and (SSLHttpLib = httpWinINet) and (SSLXmlSignLib = xsMsXmlCapicom) then
    FSSLLib := libCapicom

  else if (SSLCryptLib = cryCapicom) and (SSLHttpLib = httpIndy) and (SSLXmlSignLib = xsMsXmlCapicom) then
    FSSLLib := libCapicomDelphiSoap

  else if (SSLCryptLib = cryWinCrypt) and (SSLHttpLib = httpWinHttp) and (SSLXmlSignLib = xsMsXml) then
    FSSLLib := libWinCrypt

  else
    FSSLLib := libCustom;
end;


{ TWebServicesConf }

constructor TWebServicesConf.Create(AConfiguracoes: TConfiguracoes);
begin
  inherited Create(AConfiguracoes);

  FConfiguracoes := AConfiguracoes;
  FParams := TStringList.Create;
  FTimeZoneConf := TTimeZoneConf.Create;

  FUF := DFeUF[24];
  FUFCodigo := DFeUFCodigo[24];
  FAmbiente := taHomologacao;
  FAmbienteCodigo := StrToInt(TpAmbToStr(FAmbiente));
  FVisualizar := False;
  FProxyHost := '';
  FProxyPort := '';
  FProxyUser := '';
  FProxyPass := '';
  FAguardarConsultaRet := 0;
  FTentativas := 5;
  FIntervaloTentativas := 1000;
  FAjustaAguardaConsultaRet := False;
  FSalvar := False;
  FTimeOut := 5000;
  FResourceName := 'ACBrServicos';
  FQuebradeLinha := '|';
end;

destructor TWebServicesConf.Destroy;
begin
  FParams.Free;
  FTimeZoneConf.Free;
  inherited;
end;

procedure TWebServicesConf.Assign(DeWebServicesConf: TWebServicesConf);
begin
  ResourceName             := DeWebServicesConf.ResourceName;
  Visualizar               := DeWebServicesConf.Visualizar;
  UF                       := DeWebServicesConf.UF;
  Ambiente                 := DeWebServicesConf.Ambiente;
  ProxyHost                := DeWebServicesConf.ProxyHost;
  ProxyPort                := DeWebServicesConf.ProxyPort;
  ProxyUser                := DeWebServicesConf.ProxyUser;
  ProxyPass                := DeWebServicesConf.ProxyPass;
  AguardarConsultaRet      := DeWebServicesConf.AguardarConsultaRet;
  Tentativas               := DeWebServicesConf.Tentativas;
  IntervaloTentativas      := DeWebServicesConf.IntervaloTentativas;
  AjustaAguardaConsultaRet := DeWebServicesConf.AjustaAguardaConsultaRet;
  Salvar                   := DeWebServicesConf.Salvar;
  Params.Assign(DeWebServicesConf.Params);
end;

procedure TWebServicesConf.LerParams;
var
  ConteudoParams: AnsiString;
begin
  ConteudoParams := LerParamsIniServicos;

  if ConteudoParams = '' then
    ConteudoParams := LerParamsInterno;

  FParams.Text := ConteudoParams;
end;

procedure TWebServicesConf.SetAmbiente(AValue: TpcnTipoAmbiente);
begin
  FAmbiente := AValue;
  FAmbienteCodigo := StrToInt(TpAmbToStr(AValue));
end;

procedure TWebServicesConf.SetIntervaloTentativas(const Value: cardinal);
begin
  FIntervaloTentativas := max(Value, 1000);
end;

procedure TWebServicesConf.SetParams(const AValue: TStrings);
begin
  FParams.Assign(AValue);
end;

function TWebServicesConf.LerParamsIniServicos: AnsiString;
var
  SL: TStringList;
begin
  Result := '';

  if (FConfiguracoes.Arquivos.IniServicos <> '') and
    FileExists(FConfiguracoes.Arquivos.IniServicos) then
  begin
    SL := TStringList.Create;
    try
      SL.LoadFromFile(FConfiguracoes.Arquivos.IniServicos);
      Result := SL.Text;
    finally
      SL.Free;
    end;
  end;
end;

function TWebServicesConf.LerParamsInterno: AnsiString;
var
  RS: TResourceStream;
begin
  Result := '';

  RS := TResourceStream.Create(HInstance, FResourceName, RT_RCDATA);
  try
    RS.Position := 0;
    Result := ReadStrFromStream(RS, RS.Size);
  finally
    RS.Free;
  end;
end;

procedure TWebServicesConf.SetTentativas(const Value: integer);
begin
  if Value <= 0 then
    FTentativas := 5
  else
    FTentativas := Value;
end;

procedure TWebServicesConf.SetUF(AValue: String);
var
  Codigo, i: integer;
begin
  Codigo := -1;
  for i := 0 to High(DFeUF) do
  begin
    if DFeUF[I] = AValue then
    begin
      Codigo := DFeUFCodigo[I];
      Break;
    end;
  end;

  if Codigo > 0 then
  begin
    FUF := AValue;
    FUFCodigo := Codigo;
  end;
end;

procedure TWebServicesConf.SetProxyHost(AValue: String);
begin
  if FProxyHost = AValue then Exit;
  FProxyHost := AValue;
  TACBrDFe(FConfiguracoes.Owner).SSL.ProxyHost := AValue;
end;

procedure TWebServicesConf.SetProxyPass(AValue: String);
begin
  if FProxyPass = AValue then Exit;
  FProxyPass := AValue;
  TACBrDFe(FConfiguracoes.Owner).SSL.ProxyPass := AValue;
end;

procedure TWebServicesConf.SetProxyPort(AValue: String);
begin
  if FProxyPort = AValue then Exit;
  FProxyPort := AValue;
  TACBrDFe(FConfiguracoes.Owner).SSL.ProxyPort := AValue;
end;

procedure TWebServicesConf.SetProxyUser(AValue: String);
begin
  if FProxyUser = AValue then Exit;
  FProxyUser := AValue;
  TACBrDFe(FConfiguracoes.Owner).SSL.ProxyUser := AValue;
end;

procedure TWebServicesConf.SetTimeOut(AValue: Integer);
begin
  if FTimeOut = AValue then Exit;
  FTimeOut := AValue;
  TACBrDFe(FConfiguracoes.Owner).SSL.TimeOut := AValue;
end;

{ TCertificadosConf }

constructor TCertificadosConf.Create(AConfiguracoes: TConfiguracoes);
begin
  inherited Create(AConfiguracoes);

  FConfiguracoes := AConfiguracoes;
  FSenha := '';
  FK := '';
  FArquivoPFX := '';
  FDadosPFX := '';
  FNumeroSerie := '';
  FVerificarValidade := True;
end;

procedure TCertificadosConf.Assign(DeCertificadosConf: TCertificadosConf);
begin
  DadosPFX := DeCertificadosConf.DadosPFX;
  Senha := DeCertificadosConf.Senha;
  NumeroSerie := DeCertificadosConf.NumeroSerie;
  ArquivoPFX := DeCertificadosConf.ArquivoPFX;
end;

procedure TCertificadosConf.SetNumeroSerie(const AValue: String);
begin
  if FNumeroSerie = AValue then Exit;
  FNumeroSerie := Trim(UpperCase(StringReplace(AValue, ' ', '', [rfReplaceAll])));
  TACBrDFe(FConfiguracoes.Owner).SSL.NumeroSerie := FNumeroSerie;
end;

procedure TCertificadosConf.SetSenha(AValue: AnsiString);
begin
  if (FK <> '') and (FSenha = StrCrypt(AValue, FK)) then
    Exit;

  FK := FormatDateTime('hhnnsszzz',Now);
  FSenha := StrCrypt(AValue, FK);  // Salva Senha de forma Criptografada, para evitar "Inspect"

  TACBrDFe(FConfiguracoes.Owner).SSL.Senha := AValue;
end;

procedure TCertificadosConf.SetArquivoPFX(AValue: String);
begin
  if FArquivoPFX = AValue then Exit;
  FArquivoPFX := AValue;
  TACBrDFe(FConfiguracoes.Owner).SSL.ArquivoPFX := AValue;
end;

function TCertificadosConf.GetSenha: AnsiString;
begin
  Result := StrCrypt(FSenha, FK)  // Descritografa a Senha
end;

procedure TCertificadosConf.SetDadosPFX(AValue: AnsiString);
begin
  if FDadosPFX = AValue then Exit;
  FDadosPFX := AValue;
  TACBrDFe(FConfiguracoes.Owner).SSL.DadosPFX := AValue;
end;


{ TArquivosConf }

constructor TArquivosConf.Create(AConfiguracoes: TConfiguracoes);
begin
  inherited Create(AConfiguracoes);

  fpConfiguracoes := AConfiguracoes;
  FSalvar := True;
  FPathSalvar := '';
  FPathSchemas := '';
  FIniServicos := '';

  FSepararPorMes := False;
  FSepararPorDia := False;
  FAdicionarLiteral := False;
  FSepararPorCNPJ := False;
  FSepararPorModelo := False;
end;

procedure TArquivosConf.Assign(DeArquivosConf: TArquivosConf);
begin
  PathSalvar       := DeArquivosConf.PathSalvar;
  PathSchemas      := DeArquivosConf.PathSchemas;
  IniServicos      := DeArquivosConf.IniServicos;
  Salvar           := DeArquivosConf.Salvar;
  AdicionarLiteral := DeArquivosConf.AdicionarLiteral;
  SepararPorCNPJ   := DeArquivosConf.SepararPorCNPJ;
  SepararPorModelo := DeArquivosConf.SepararPorModelo;
  SepararPorMes    := DeArquivosConf.SepararPorMes;
  SepararPorDia    := DeArquivosConf.SepararPorDia;
end;

function TArquivosConf.GetPathSalvar: String;
begin
  if FPathSalvar = '' then
    if not (csDesigning in fpConfiguracoes.Owner.ComponentState) then
      FPathSalvar := ApplicationPath + 'Docs';

  FPathSalvar := PathWithDelim(Trim(FPathSalvar));
  Result := FPathSalvar;
end;

function TArquivosConf.GetPathSchemas: String;
begin
  if FPathSchemas = '' then
    if not (csDesigning in fpConfiguracoes.Owner.ComponentState) then
      FPathSchemas := ApplicationPath + 'Schemas';

  FPathSchemas := PathWithDelim(Trim(FPathSchemas));
  Result := FPathSchemas;
end;

procedure TArquivosConf.SetSepararPorDia(const Value: Boolean);
begin
  FSepararPorDia := Value;
  if Value then
    FSepararPorMes := Value;
end;

procedure TArquivosConf.SetSepararPorMes(const Value: Boolean);
begin
  FSepararPorMes := Value;
  if not Value then
    FSepararPorDia := Value;
end;

function TArquivosConf.GetIniServicos: String;
begin
  if FIniServicos = '' then
    if not (csDesigning in fpConfiguracoes.Owner.ComponentState) then
      FIniServicos := ApplicationPath + fpConfiguracoes.WebServices.ResourceName+'.ini';

  Result := FIniServicos;
end;

function TArquivosConf.GetPath(APath: String; ALiteral: String; CNPJ: String;
  Data: TDateTime): String;
var
  wDia, wMes, wAno: word;
  Dir, Modelo, AnoMes, Dia: String;
  LenLiteral: integer;
begin
  if EstaVazio(APath) then
    Dir := PathSalvar
  else
    Dir := APath;

  if SepararPorCNPJ then
  begin
    CNPJ := OnlyNumber(CNPJ);

    if EstaVazio(CNPJ) then
      CNPJ := OnlyNumber(TACBrDFe(fpConfiguracoes.Owner).SSL.CertCNPJ);

    if NaoEstaVazio(CNPJ) then
      Dir := PathWithDelim(Dir) + CNPJ;
  end;

  if SepararPorModelo then
  begin
    Modelo := TACBrDFe(fpConfiguracoes.Owner).GetNomeModeloDFe;
    Dir := PathWithDelim(Dir) + Modelo;
  end;

  if SepararPorMes then
  begin
    if Data = 0 then
      Data := Now;

    DecodeDate(Data, wAno, wMes, wDia);
    AnoMes := IntToStr(wAno) + IntToStrZero(wMes, 2);
    Dir := PathWithDelim(Dir) + AnoMes;
	  
    if SepararPorDia then
    begin
      Dia := IntToStrZero(wDia, 2);
      Dir := PathWithDelim(Dir) + Dia;
    end;
  end;

  LenLiteral := Length(ALiteral);
  if AdicionarLiteral and (LenLiteral > 0) then
  begin
    if RightStr(Dir, LenLiteral) <> ALiteral then
      Dir := PathWithDelim(Dir) + ALiteral;
  end;

  if not DirectoryExists(Dir) then
    ForceDirectories(Dir);

  Result := Dir;
end;


end.

// TODO: Salvar senha do Certificado na mem�ria de forma criptograda
