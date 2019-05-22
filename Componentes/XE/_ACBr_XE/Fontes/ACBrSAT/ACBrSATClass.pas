{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2014 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
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

{******************************************************************************
|* Historico
|*
|* 21/11/2009: Daniel Simoes de Almeida
|*  - Primeira Versao: Cria�ao e Distribui�ao da Primeira Versao
******************************************************************************}

{$I ACBr.inc}

unit ACBrSATClass ;

interface

uses
  Classes, SysUtils, pcnConversao ;

const
  cACBrSAT_Versao      = '0.1.1' ;
  cLIBSAT              = 'SAT.DLL';
  cversaoDadosEnt      = 0.05;

  cACBrSATClassCreateException = 'Essa Classe deve ser instanciada por TACBrSAT' ;
  cACBrSATSetModeloException   = 'N�o � poss�vel mudar o Modelo com o SAT Inicializado' ;
  cACBrSATModeloNaoDefinido    = 'Modelo de SAT n�o definido' ;
  cACBrSATNaoInicializado      = 'ACBrSAT n�o foi inicializado corretamente' ;
  cACBrSATFuncaoNaoEncontrada  = 'Erro ao carregar a fun��o: %s na Biblioteca: %s' ;
  cACBrSATCMDInvalidoException = 'Procedure: %s '+ sLineBreak +
                                 ' n�o implementada para o SAT: %s'+sLineBreak + sLineBreak +
                                 'Ajude no desenvolvimento do ACBrSAT. '+ sLineBreak+
                                 'Acesse nosso Forum em: http://projetoacbr.com.br/' ;
type

  TACBrSATModelo = ( satNenhum, satDinamico_cdecl, satDinamico_stdcall ) ;

  { EACBrSATErro }

  EACBrSATErro = class(Exception)
  public
    constructor Create(const msg : string);
  end ;

  { Eventos do componente }
  TACBrSATGetChave = procedure(var Chave: AnsiString) of object ;
  TACBrSATGetNumeroSessao = procedure(var NumeroSessao: Integer) of object ;

  { TACBrSATConfig }

  TACBrSATConfig = Class(TPersistent)
  private
    fsemit_CNPJ : String ;
    fsemit_cRegTrib : TpcnRegTrib ;
    fsemit_cRegTribISSQN : TpcnRegTribISSQN ;
    fsemit_IE : String ;
    fsemit_IM : String ;
    fsemit_indRatISSQN : TpcnindRatISSQN ;
    fside_CNPJ : String ;
    fside_numeroCaixa : Integer ;
    fsinfCFe_versaoDadosEnt : Real ;
    fside_tpAmb : TpcnTipoAmbiente ;
    fsPaginaDeCodigo: Word;
    function GetEhUTF8: Boolean;
    procedure SetEhUTF8(AValue: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
  published
    property infCFe_versaoDadosEnt : Real read fsinfCFe_versaoDadosEnt
        write fsinfCFe_versaoDadosEnt ;
    property ide_CNPJ : String  read fside_CNPJ write fside_CNPJ;
    property ide_numeroCaixa : Integer read fside_numeroCaixa
       write fside_numeroCaixa ;
    property ide_tpAmb : TpcnTipoAmbiente read fside_tpAmb write fside_tpAmb;

    property emit_CNPJ : String read fsemit_CNPJ write fsemit_CNPJ;
    property emit_IE   : String read fsemit_IE   write fsemit_IE;
    property emit_IM   : String read fsemit_IM   write fsemit_IM;
    property emit_cRegTrib: TpcnRegTrib read fsemit_cRegTrib
       write fsemit_cRegTrib ;
    property emit_cRegTribISSQN: TpcnRegTribISSQN read fsemit_cRegTribISSQN
       write fsemit_cRegTribISSQN ;
    property emit_indRatISSQN: TpcnindRatISSQN read fsemit_indRatISSQN
       write fsemit_indRatISSQN;
    property EhUTF8: Boolean read GetEhUTF8 write SetEhUTF8;
    property PaginaDeCodigo : Word read fsPaginaDeCodigo write fsPaginaDeCodigo;
  end;

  { TACBrSATRespostaClass }

  TACBrSATResposta = class
  private
    fnumeroSessao : Integer ;
    fcodigoDeRetorno : Integer ;
    fmensagemRetorno : String;
    fcodigoSEFAZ : Integer ;
    fmensagemSEFAZ : String;
    fRetornoLst : TStringList ;
    fRetornoStr : String ;
    procedure SetRetornoStr(AValue : String) ;
  public
    constructor Create ;
    Destructor Destroy ; override ;
    procedure Clear ;

    property numeroSessao : Integer read fnumeroSessao ;
    property codigoDeRetorno : Integer read  fcodigoDeRetorno;
    property mensagemRetorno : String read fmensagemRetorno;
    property codigoSEFAZ : Integer read  fcodigoSEFAZ;
    property mensagemSEFAZ : String read fmensagemSEFAZ;
    property RetornoLst : TStringList read fRetornoLst ;
    property RetornoStr : String read fRetornoStr write SetRetornoStr ;
  end ;

  TACBrSATStatusLan = ( lanCONECTADO, lanNAO_CONECTADO ) ;
  TACBrSATNivelBateria = ( batALTO, batMEDIO, batBAIXO ) ;
  TACBrSATEstadoOperacao = ( opDESBLOQUEADO, opBLOQUEIO_SEFAZ,
                             opBLOQUEIO_CONTRIBUINTE, opBLOQUEIO_AUTONOMO,
                             opBLOQUEIO_DESATIVACAO );

  { TACBrSATStatus }

  TACBrSATStatus = class
  private
    fCERT_EMISSAO: TDateTime;
    fCERT_VENCIMENTO: TDateTime;
    fDH_ATUAL: TDateTime;
    fDH_CFe: TDateTime;
    fDH_ULTIMA: TDateTime;
    fESTADO_OPERACAO: TACBrSATEstadoOperacao;
    fLAN_MAC: String;
    fLISTA_FINAL: String;
    fLISTA_INICIAL: String;
    fMT_TOTAL: String;
    fMT_USADA: String;
    fNIVEL_BATERIA: TACBrSATNivelBateria;
    fNSERIE: String;
    fSTATUS_LAN: TACBrSATStatusLan;
    fULTIMO_CFe: String;
    fVER_LAYOUT: String;
    fVER_SB: String;
  public
    procedure Clear;
    function StatusLanToStr(const t: TACBrSATStatusLan ): string;
    function StrToStatusLan(var ok: boolean; const s: string): TACBrSATStatusLan ;
    function NivelBateriaToStr(const t: TACBrSATNivelBateria ): string;
    function StrToNivelBateria(var ok: boolean; const s: string): TACBrSATNivelBateria ;
    function EstadoOperacaoToStr(const t: TACBrSATEstadoOperacao ): string;
    function StrToEstadoOperacao(var ok: boolean; const s: string): TACBrSATEstadoOperacao ;

    property NSERIE: String read fNSERIE write fNSERIE;
    property LAN_MAC: String read fLAN_MAC write fLAN_MAC;
    property STATUS_LAN: TACBrSATStatusLan read fSTATUS_LAN
       write fSTATUS_LAN;
    property NIVEL_BATERIA: TACBrSATNivelBateria read fNIVEL_BATERIA
       write fNIVEL_BATERIA;
    property MT_TOTAL: String read fMT_TOTAL write fMT_TOTAL;
    property MT_USADA: String read fMT_USADA write fMT_USADA;
    property DH_ATUAL: TDateTime read fDH_ATUAL write fDH_ATUAL;
    property VER_SB: String read fVER_SB write fVER_SB;
    property VER_LAYOUT: String read fVER_LAYOUT write fVER_LAYOUT;
    property ULTIMO_CFe: String read fULTIMO_CFe write fULTIMO_CFe;
    property LISTA_INICIAL: String read fLISTA_INICIAL write fLISTA_INICIAL;
    property LISTA_FINAL: String read fLISTA_FINAL write fLISTA_FINAL;
    property DH_CFe: TDateTime read fDH_CFe write fDH_CFe;
    property DH_ULTIMA: TDateTime read fDH_ULTIMA write fDH_ULTIMA;
    property CERT_EMISSAO: TDateTime read fCERT_EMISSAO write fCERT_EMISSAO;
    property CERT_VENCIMENTO: TDateTime read fCERT_VENCIMENTO write fCERT_VENCIMENTO;
    property ESTADO_OPERACAO: TACBrSATEstadoOperacao read fESTADO_OPERACAO
       write fESTADO_OPERACAO;
  end;

  { TACBrSATClass }

   TACBrSATClass = class( TComponent )
   private
     function GetcodigoDeAtivacao : AnsiString ;
     function GetnumeroSessao : Integer ;
     function GetNomeDLL : string ;

     procedure ErroAbstract( NomeProcedure : String ) ;
     function GetsignAC : AnsiString ;
   protected
     fpOwner : TComponent ;   { Componente ACBrSAT }
     fpModeloStr: String;

     function GetModeloStr: String; virtual ;

     property NomeDLL: String read GetNomeDLL ;

     property codigoDeAtivacao : AnsiString read GetcodigoDeAtivacao ;
     property signAC : AnsiString read GetsignAC ;
     property numeroSessao : Integer read GetnumeroSessao ;

     procedure LoadDLLFunctions ; virtual ;
     procedure UnLoadDLLFunctions ; virtual ;
     procedure FunctionDetectLibSAT(FuncName : String ;
       var LibPointer : Pointer) ; virtual ;
   public
     constructor Create( AOwner : TComponent ) ; override;
     destructor Destroy ; override;

     procedure Inicializar; virtual ;
     procedure DesInicializar ; virtual ;

     Property ModeloStr: String read GetModeloStr ;

     function AssociarAssinatura( CNPJvalue, assinaturaCNPJs : AnsiString ):
       String ; virtual;
     function AtivarSAT( subComando : Integer; CNPJ: AnsiString; cUF : Integer )
       : String ; virtual;
     function AtualizarSoftwareSAT : String ; virtual;
     function BloquearSAT : String ; virtual;
     function CancelarUltimaVenda( chave, dadosCancelamento : AnsiString ) :
       String ; virtual;
     function ComunicarCertificadoICPBRASIL( certificado : AnsiString ) :
       String ; virtual;
     function ConfigurarInterfaceDeRede( dadosConfiguracao : AnsiString ) :
       String ; virtual;
     function ConsultarNumeroSessao( cNumeroDeSessao : Integer) : String ;
       virtual;
     function ConsultarSAT : String ; virtual;
     function ConsultarStatusOperacional : String ; virtual;
     function DesbloquearSAT : String ; virtual;
     function EnviarDadosVenda( dadosVenda : AnsiString ) : String ; virtual;
     function ExtrairLogs : String ; virtual;
     function TesteFimAFim( dadosVenda : AnsiString) : String ; virtual;
     function TrocarCodigoDeAtivacao( codigoDeAtivacaoOuEmergencia: AnsiString;
       opcao : Integer; novoCodigo: AnsiString ) : String ; virtual;
   end;

implementation

Uses ACBrSAT, ACBrUtil, ACBrConsts ;

{ TACBrSATStatus }

procedure TACBrSATStatus.Clear;
begin
  fCERT_EMISSAO     := 0;
  fCERT_VENCIMENTO  := 0;
  fDH_ATUAL         := 0;
  fDH_CFe           := 0;
  fDH_ULTIMA        := 0;
  fESTADO_OPERACAO  := opDESBLOQUEADO;
  fLAN_MAC          := '';
  fLISTA_FINAL      := '';
  fLISTA_INICIAL    := '';
  fMT_TOTAL         := '';
  fMT_USADA         := '';
  fNIVEL_BATERIA    := batALTO;
  fNSERIE           := '';
  fSTATUS_LAN       := lanCONECTADO;
  fULTIMO_CFe       := '';
  fVER_LAYOUT       := '';
  fVER_SB           := '';
end;

function TACBrSATStatus.StatusLanToStr(const t: TACBrSATStatusLan): string;
begin
  result := EnumeradoToStr(t, ['CONECTADO', 'NAO_CONECTADO'], [lanCONECTADO, lanNAO_CONECTADO]);
end;

function TACBrSATStatus.StrToStatusLan(var ok: boolean; const s: string
  ): TACBrSATStatusLan;
begin
  result := StrToEnumerado(ok, s, ['CONECTADO', 'NAO_CONECTADO'], [lanCONECTADO, lanNAO_CONECTADO]);
end;

function TACBrSATStatus.NivelBateriaToStr(const t: TACBrSATNivelBateria
  ): string;
begin
  result := EnumeradoToStr(t, ['ALTO', 'MEDIO', 'BAIXO'], [batALTO, batMEDIO, batBAIXO]);
end;

function TACBrSATStatus.StrToNivelBateria(var ok: boolean; const s: string
  ): TACBrSATNivelBateria;
begin
  result := StrToEnumerado(ok, s, ['ALTO', 'MEDIO', 'BAIXO'], [batALTO, batMEDIO, batBAIXO]);
end;

function TACBrSATStatus.EstadoOperacaoToStr(const t: TACBrSATEstadoOperacao
  ): string;
begin
  result := EnumeradoToStr(t,
                ['DESBLOQUEADO', 'BLOQUEIO_SEFAZ', 'BLOQUEIO_CONTRIBUINTE',
                 'BLOQUEIO_AUTONOMO', 'BLOQUEIO_DESATIVACAO'],
                [opDESBLOQUEADO, opBLOQUEIO_SEFAZ, opBLOQUEIO_CONTRIBUINTE,
                 opBLOQUEIO_AUTONOMO, opBLOQUEIO_DESATIVACAO]);
end;

function TACBrSATStatus.StrToEstadoOperacao(var ok: boolean; const s: string
  ): TACBrSATEstadoOperacao;
begin
  result := StrToEnumerado(ok, s,
                ['DESBLOQUEADO', 'BLOQUEIO_SEFAZ', 'BLOQUEIO_CONTRIBUINTE',
                 'BLOQUEIO_AUTONOMO', 'BLOQUEIO_DESATIVACAO'],
                [opDESBLOQUEADO, opBLOQUEIO_SEFAZ, opBLOQUEIO_CONTRIBUINTE,
                 opBLOQUEIO_AUTONOMO, opBLOQUEIO_DESATIVACAO]);
end;

{ TACBrSATRespostaClass }

procedure TACBrSATResposta.SetRetornoStr(AValue : String) ;
var
  index : integer;
begin
  fRetornoStr := AValue;

  fnumeroSessao    := 0;
  fcodigoDeRetorno := 0;
  fmensagemRetorno := '';
  fcodigoSEFAZ := 0;
  fmensagemSEFAZ := '';

  Clear;
  fRetornoLst.Delimiter := '|';
  {$IFDEF FPC}
   fRetornoLst.StrictDelimiter := True;
  {$ELSE}
   AValue := '"' + StringReplace(AValue, fRetornoLst.Delimiter,
                            '"' + fRetornoLst.Delimiter + '"', [rfReplaceAll]) +
             '"';
  {$ENDIF}
  fRetornoLst.DelimitedText := AValue;

  if fRetornoLst.Count > 1 then
  begin
    fnumeroSessao    := StrToIntDef( fRetornoLst[0], 0);
    fcodigoDeRetorno := StrToIntDef( fRetornoLst[1], 0);
  end;

  if fRetornoLst.Count > 2 then
  begin
    if Length(Trim(fRetornoLst[2])) = 4 then //Enviar e Cancelar venda tem um campo a mais no inicio da resposta(CCCC)
      index := 3
    else
      index := 2;
  end;

  if fRetornoLst.Count > index+2 then
  begin
    fmensagemRetorno := fRetornoLst[index];
    fcodigoSEFAZ     := StrToIntDef( fRetornoLst[index+1], 0);
    fmensagemSEFAZ   := fRetornoLst[index+2];
  end
  else
    fmensagemRetorno := AValue;
end;

constructor TACBrSATResposta.Create ;
begin
  inherited Create;
  fRetornoLst := TStringList.Create;
  Clear;
end ;

destructor TACBrSATResposta.Destroy ;
begin
  fRetornoLst.Free;
  inherited Destroy;
end ;

procedure TACBrSATResposta.Clear ;
begin
  fRetornoLst.Clear;
  fRetornoStr      := '';
  fnumeroSessao    := 0;
  fcodigoDeRetorno := 0;
  fmensagemRetorno := '';
  fcodigoSEFAZ := 0;
  fmensagemSEFAZ := '';
end ;

{ TACBrSATConfig }

function TACBrSATConfig.GetEhUTF8: Boolean;
begin
  Result := (fsPaginaDeCodigo = 65001);
end;

procedure TACBrSATConfig.SetEhUTF8(AValue: Boolean);
begin
   if AValue then
     fsPaginaDeCodigo := 65001
   else
   begin
     if fsPaginaDeCodigo = 65001 then
       fsPaginaDeCodigo := 0;
   end ;

end;

constructor TACBrSATConfig.Create ;
begin
  inherited Create;
  Clear;
end ;

destructor TACBrSATConfig.Destroy ;
begin
  inherited Destroy ;
end ;

procedure TACBrSATConfig.Clear ;
begin
  fsemit_CNPJ             := '' ;
  fsemit_cRegTrib         := RTSimplesNacional;
  fsemit_cRegTribISSQN    := RTISSMicroempresaMunicipal;
  fsemit_IE               := '' ;
  fsemit_IM               := '' ;
  fsemit_indRatISSQN      := irSim ;
  fside_CNPJ              := '' ;
  fside_numeroCaixa       := 0 ;
  fside_tpAmb             := taHomologacao ;
  fsinfCFe_versaoDadosEnt := cversaoDadosEnt ;
end ;

{ EACBrSATErro }

constructor EACBrSATErro.Create(const msg : string) ;
begin
  inherited Create( ACBrStr(msg) );
end ;

{ TACBrSATClass }

constructor TACBrSATClass.Create(AOwner : TComponent) ;
begin
  if not (AOwner is TACBrSAT) then
     raise EACBrSATErro.create( cACBrSATClassCreateException );

  inherited Create(AOwner) ;

  fpOwner := AOwner ;
  fpModeloStr := 'N�o Definido' ;
end ;

destructor TACBrSATClass.Destroy ;
begin
  UnLoadDLLFunctions;
  inherited Destroy ;
end ;

procedure TACBrSATClass.Inicializar ;
begin
  LoadDLLFunctions;
end ;

procedure TACBrSATClass.DesInicializar ;
begin
  UnLoadDLLFunctions;
end ;

function TACBrSATClass.GetNomeDLL : string ;
begin
  Result := TACBrSAT(fpOwner).NomeDLL;
end;

procedure TACBrSATClass.ErroAbstract(NomeProcedure : String) ;
begin
  raise EACBrSATErro.create( Format( cACBrSATCMDInvalidoException,
                                     [NomeProcedure, ModeloStr] )) ;
end ;

function TACBrSATClass.GetsignAC : AnsiString ;
begin
  Result := TACBrSAT(fpOwner).signAC;
end;

function TACBrSATClass.GetcodigoDeAtivacao : AnsiString ;
begin
  Result := TACBrSAT(fpOwner).codigoDeAtivacao;
end;

function TACBrSATClass.GetnumeroSessao : Integer ;
begin
  Result := TACBrSAT(fpOwner).numeroSessao;
end;

procedure TACBrSATClass.LoadDLLFunctions;
begin
  ErroAbstract('LoadDLLFunctions');
end;

procedure TACBrSATClass.UnLoadDLLFunctions ;
begin
  UnLoadLibrary( NomeDLL );
end ;

function TACBrSATClass.AssociarAssinatura(CNPJvalue,
  assinaturaCNPJs : AnsiString) : String ;
begin
  ErroAbstract('AssociarAssinatura');
  Result := '';
end ;

function TACBrSATClass.AtivarSAT(subComando : Integer ; CNPJ : AnsiString ;
  cUF : Integer) : String ;
begin
  ErroAbstract('AtivarSAT');
  Result := '';
end ;

function TACBrSATClass.AtualizarSoftwareSAT : String ;
begin
  ErroAbstract('AtualizarSoftwareSAT');
  Result := '';
end ;

function TACBrSATClass.BloquearSAT : String ;
begin
  ErroAbstract('BloquearSAT');
  Result := '';
end ;

function TACBrSATClass.CancelarUltimaVenda(chave, dadosCancelamento : AnsiString
  ) : String ;
begin
  ErroAbstract('CancelarUltimaVenda');
  Result := '';
end ;

function TACBrSATClass.ComunicarCertificadoICPBRASIL(certificado : AnsiString
  ) : String ;
begin
  ErroAbstract('ComunicarCertificadoICPBRASIL');
  Result := '';
end ;

function TACBrSATClass.ConfigurarInterfaceDeRede(dadosConfiguracao : AnsiString
  ) : String ;
begin
  ErroAbstract('ConfigurarInterfaceDeRede');
  Result := '';
end ;

function TACBrSATClass.ConsultarNumeroSessao(cNumeroDeSessao : Integer
  ) : String ;
begin
  ErroAbstract('ConsultarNumeroSessao');
  Result := '';
end ;

function TACBrSATClass.ConsultarSAT : String ;
begin
  ErroAbstract('ConsultarSAT');
  Result := '';
end ;

function TACBrSATClass.ConsultarStatusOperacional : String ;
begin
  ErroAbstract('ConsultarStatusOperacional');
  Result := '';
end ;

function TACBrSATClass.DesbloquearSAT : String ;
begin
  ErroAbstract('DesbloquearSAT');
  Result := '';
end ;

function TACBrSATClass.EnviarDadosVenda(dadosVenda : AnsiString) : String ;
begin
  ErroAbstract('EnviarDadosVenda');
  Result := '';
end ;

function TACBrSATClass.ExtrairLogs : String ;
begin
  ErroAbstract('ExtrairLogs');
  Result := '';
end ;

function TACBrSATClass.TesteFimAFim(dadosVenda : AnsiString) : String ;
begin
  ErroAbstract('TesteFimAFim');
  Result := '';
end ;

function TACBrSATClass.TrocarCodigoDeAtivacao(
  codigoDeAtivacaoOuEmergencia: AnsiString; opcao: Integer; novoCodigo: AnsiString
  ): String;
begin
  ErroAbstract('TrocarCodigoDeAtivacao');
  Result := '';
end ;

function TACBrSATClass.GetModeloStr : String ;
begin
  Result := fpModeloStr;
end ;

procedure TACBrSATClass.FunctionDetectLibSAT(FuncName : String ;
  var LibPointer : Pointer) ;
var
  sLibName: String;
begin
  if not Assigned( LibPointer )  then
  begin
    sLibName := NomeDLL;
    if not FileExists(sLibName) then
      raise EACBrSATErro.Create( 'Arquivo n�o encontrado: '+sLibName );

    if not FunctionDetect( sLibName, FuncName, LibPointer) then
    begin
       LibPointer := NIL ;
       raise EACBrSATErro.Create( Format(cACBrSATFuncaoNaoEncontrada, [FuncName,sLibName]) ) ;
    end ;
  end ;
end ;

end.

