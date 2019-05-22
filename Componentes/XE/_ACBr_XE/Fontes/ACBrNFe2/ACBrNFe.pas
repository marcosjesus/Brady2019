{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Nota Fiscal}
{ eletr�nica - NFe - http://www.nfe.fazenda.gov.br                             }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
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

{*******************************************************************************
|* Historico
|*
|* 16/12/2008: Wemerson Souto
|*  - Doa��o do componente para o Projeto ACBr
|* 24/09/2012: Italo Jurisato Junior
|*  - Altera��es para funcionamento com NFC-e
*******************************************************************************}

{$I ACBr.inc}

unit ACBrNFe;

interface

uses
  Classes, Sysutils,
  pcnNFe, pcnConversao, pcnCCeNFe, pcnRetCCeNFe,
  pcnEnvEventoNFe, pcnRetEnvEventoNFe, pcnInutNFe, pcnRetInutNFe,
  pcnDownloadNFe, pcnRetDownloadNFe, pcnRetDistDFeInt,
  {$IF DEFINED(VisualCLX)}
     QDialogs, QForms,
  {$ELSEIF DEFINED(FMX)}
     FMX.Dialogs, FMX.Forms, System.UITypes,
  {$ELSE}
     Dialogs, Forms,
  {$IFEND}
  ACBrNFeNotasFiscais,
  ACBrNFeConfiguracoes,
  ACBrNFeWebServices, ACBrNFeUtil, ACBrDFeUtil,
  ACBrNFeDANFEClass, ACBrUtil,
  smtpsend, ssl_openssl, mimemess, mimepart; // units para enviar email

const
  ACBRNFE_VERSAO = '0.5.0a';

type
  TACBrNFeAboutInfo = (ACBrNFeAbout);

  EACBrNFeException = class(Exception);

  // Evento para gerar log das mensagens do Componente
  TACBrNFeLog = procedure(const Mensagem : String) of object;

  {Carta de Corre��o}
  TCartaCorrecao = Class(TComponent)
  private
    FCCe: TCCeNFe;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property CCe: TCCeNFe read FCCe write FCCe;
  end;

  {Download}
  TDownload = Class(TComponent)
  private
    FDownload: TDownloadNFe;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Download: TDownloadNFe read FDownload write FDownload;
  end;

  TACBrNFe = class(TComponent)
  private
    fsAbout: TACBrNFeAboutInfo;
    FDANFE : TACBrNFeDANFEClass;
    FNotasFiscais: TNotasFiscais;
    FCartaCorrecao: TCartaCorrecao;
    FEventoNFe: TEventoNFe;
    FInutNFe: TInutNFe;
    FDownloadNFe: TDownload;
    FRetDownloadNFe: TRetDownloadNFe;
    FRetDistDFeInt: TRetDistDFeInt;
    FWebServices: TWebServices;
    FConfiguracoes: TConfiguracoes;
    FStatus : TStatusACBrNFe;
    FOnStatusChange: TNotifyEvent;
    FOnGerarLog : TACBrNFeLog;

    procedure SetDANFE(const Value: TACBrNFeDANFEClass);
    procedure EnviaEmailThread(const sSmtpHost, sSmtpPort, sSmtpUser,
      sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings;
      SSL: Boolean; sCC, Anexos: TStrings; PedeConfirma, AguardarEnvio: Boolean;
      NomeRemetente: String; TLS: Boolean; StreamNFe: TStringStream;
      NomeArq: String; HTML:Boolean=false);
    procedure EnviarEmailNormal(const sSmtpHost, sSmtpPort, sSmtpUser,
      sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings;
      SSL: Boolean; sCC, Anexos: TStrings; PedeConfirma, AguardarEnvio: Boolean;
      NomeRemetente: String; TLS: Boolean; StreamNFe: TStringStream;
      NomeArq: String; HTML:Boolean=false);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Enviar(ALote: Integer; Imprimir: Boolean = True; Sincrono: Boolean = False): Boolean; overload;
    function Enviar(ALote: String; Imprimir: Boolean = True; Sincrono: Boolean = False): Boolean; overload;
    function Cancelamento(AJustificativa:WideString; ALote: Integer = 0): Boolean;
    function Consultar: Boolean;
    function EnviarCartaCorrecao(idLote : Integer): Boolean;
    function EnviarEventoNFe(idLote : Integer): Boolean;
    function ConsultaNFeDest(CNPJ: String;
                             IndNFe: TpcnIndicadorNFe;
                             IndEmi: TpcnIndicadorEmissor;
                             ultNSU: String): Boolean;
    function Download: Boolean;

    property WebServices: TWebServices     read FWebServices   write FWebServices;
    property NotasFiscais: TNotasFiscais   read FNotasFiscais  write FNotasFiscais;
    property CartaCorrecao: TCartaCorrecao read FCartaCorrecao write FCartaCorrecao;
    property EventoNFe: TEventoNFe         read FEventoNFe     write FEventoNFe;
    property InutNFe: TInutNFe             read FInutNFe       write FInutNFe;
    property DownloadNFe: TDownload        read FDownloadNFe   write FDownloadNFe;
    property RetDownloadNFe: TRetDownloadNFe read FRetDownloadNFe write FRetDownloadNFe;
    property RetDistDFeInt: TRetDistDFeInt read FRetDistDFeInt write FRetDistDFeInt;
    property Status: TStatusACBrNFe        read FStatus;

    procedure SetStatus( const stNewStatus : TStatusACBrNFe );
    procedure ImprimirEvento;
    procedure ImprimirEventoPDF;
    procedure ImprimirInutilizacao;
    procedure ImprimirInutilizacaoPDF;
    procedure EnviarEmailEvento(const sSmtpHost,
                                sSmtpPort,
                                sSmtpUser,
                                sSmtpPasswd,
                                sFrom,
                                sTo,
                                sAssunto: String;
                                sMensagem : TStrings;
                                SSL : Boolean;
                                EnviaPDF: Boolean = true;
                                sCC: TStrings = nil;
                                Anexos:TStrings=nil;
                                PedeConfirma: Boolean = False;
                                AguardarEnvio: Boolean = False;
                                NomeRemetente: String = '';
                                TLS : Boolean = True;
                                UsarThread: Boolean = True;
                                HTML: Boolean = False);

    procedure EnviaEmail(const sSmtpHost,
                                  sSmtpPort,
                                  sSmtpUser,
                                  sSmtpPasswd,
                                  sFrom,
                                  sTo,
                                  sAssunto: String;
                                  sMensagem : TStrings;
                                  SSL : Boolean;
                                  sCC: TStrings = nil;
                                  Anexos:TStrings=nil;
                                  PedeConfirma: Boolean = False;
                                  AguardarEnvio: Boolean = False;
                                  NomeRemetente: String = '';
                                  TLS : Boolean = True;
                                  StreamNFe : TStringStream = nil;
                                  NomeArq : String = '';
                                  UsarThread: Boolean = True;
                                  HTML: Boolean = False);

  // Incluido por Italo em 25/08/2014
    function AdministrarCSC(ARaizCNPJ: String;
                            AIndOP: TpcnIndOperacao;
                            AIdCSC: Integer;
                            ACodigoCSC: String): Boolean;
    function DistribuicaoDFe(AcUFAutor: Integer;
                             ACNPJCPF,
                             AultNSU,
                             ANSU: String): Boolean;
  published
    property Configuracoes: TConfiguracoes   read FConfiguracoes  write FConfiguracoes;
    property OnStatusChange: TNotifyEvent    read FOnStatusChange write FOnStatusChange;
    property DANFE: TACBrNFeDANFEClass       read FDANFE          write SetDANFE;
    property AboutACBrNFe: TACBrNFeAboutInfo read fsAbout         write fsAbout stored false;
    property OnGerarLog: TACBrNFeLog         read FOnGerarLog     write FOnGerarLog;
  end;

procedure ACBrAboutDialog;

implementation

procedure ACBrAboutDialog;
var
 Msg: String;
begin
    Msg := 'Componente ACBrNFe2'+#10+
           'Vers�o: '+ACBRNFE_VERSAO+#10+#10+
           'Automa��o Comercial Brasil'+#10+#10+
           'http://acbr.sourceforge.net'+#10+#10+
           'Projeto Cooperar - PCN'+#10+#10+
           'http://www.projetocooperar.org/pcn/';

  {$IFDEF FMX}
  MessageDlg(Msg, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK],0);
  {$ELSE}
  MessageDlg(Msg ,mtInformation ,[mbOk],0);
  {$ENDIF}
end;

{ TACBrNFe }

constructor TACBrNFe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FConfiguracoes     := TConfiguracoes.Create( self );
  FConfiguracoes.Name:= 'Configuracoes';
  {$IFDEF COMPILER6_UP}
   FConfiguracoes.SetSubComponent( true );{ para gravar no DFM/XFM }
  {$ENDIF}

  FNotasFiscais      := TNotasFiscais.Create(Self,NotaFiscal);
  FNotasFiscais.Configuracoes := FConfiguracoes;
  FCartaCorrecao     := TCartaCorrecao.Create(Self);
  FEventoNFe         := TEventoNFe.Create;
  FInutNFe           := TInutNFe.Create;
  FDownloadNFe       := TDownload.Create(Self);
  FRetDistDFeInt     := TRetDistDFeInt.Create;
  FWebServices       := TWebServices.Create(Self);
  FRetDownloadNFe    := TRetDownloadNFe.Create;

  if FConfiguracoes.WebServices.Tentativas <= 0 then
     FConfiguracoes.WebServices.Tentativas := 5;
  {$IFDEF ACBrNFeOpenSSL}
    if FConfiguracoes.Geral.IniFinXMLSECAutomatico then
      NotaUtil.InitXmlSec;
  {$ENDIF}
  FOnGerarLog := nil;
end;

destructor TACBrNFe.Destroy;
begin
  {$IFDEF ACBrNFeOpenSSL}
    if FConfiguracoes.Geral.IniFinXMLSECAutomatico then
      NotaUtil.ShutDownXmlSec;
  {$ENDIF}
  FConfiguracoes.Free;
  FNotasFiscais.Free;
  FCartaCorrecao.Free;
  FEventoNFe.Free;
  FInutNFe.Free;
  FDownloadNFe.Free;
  FRetDistDFeInt.Free;
  FWebServices.Free;
  FRetDownloadNFe.Free;

  inherited;
end;

procedure TACBrNFe.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FDANFE <> nil) and (AComponent is TACBrNFeDANFEClass) then
     FDANFE := nil;
end;

procedure TACBrNFe.SetDANFE(const Value: TACBrNFeDANFEClass);
 Var OldValue: TACBrNFeDANFEClass;
begin
  if Value <> FDANFE then
  begin
     if Assigned(FDANFE) then
        FDANFE.RemoveFreeNotification(Self);

     OldValue  := FDANFE;   // Usa outra variavel para evitar Loop Infinito
     FDANFE    := Value;    // na remo��o da associa��o dos componentes

     if Assigned(OldValue) then
        if Assigned(OldValue.ACBrNFe) then
           OldValue.ACBrNFe := nil;

     if Value <> nil then
     begin
        Value.FreeNotification(self);
        Value.ACBrNFe := self;
     end;
  end;
end;

procedure TACBrNFe.SetStatus( const stNewStatus : TStatusACBrNFe );
begin
  if ( stNewStatus <> FStatus ) then
  begin
    FStatus := stNewStatus;
    if Assigned(fOnStatusChange) then
      FOnStatusChange(Self);
  end;
end;

function TACBrNFe.Cancelamento(
  AJustificativa: WideString; ALote: Integer = 0): Boolean;
var
  i : Integer;
begin
  if Self.NotasFiscais.Count = 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhuma Nota Fiscal Eletr�nica Informada!');
      raise EACBrNFeException.Create('Nenhuma Nota Fiscal Eletr�nica Informada!');
   end;

  for i:= 0 to self.NotasFiscais.Count-1 do
  begin
    Self.WebServices.Consulta.NFeChave := OnlyNumber(self.NotasFiscais.Items[i].NFe.infNFe.ID);

    if not Self.WebServices.Consulta.Executar then
       raise Exception.Create(Self.WebServices.Consulta.Msg);

    Self.EventoNFe.Evento.Clear;
    with Self.EventoNFe.Evento.Add do
     begin
       infEvento.CNPJ   := copy(DFeUtil.LimpaNumero(Self.WebServices.Consulta.NFeChave),7,14);
       infEvento.cOrgao := StrToIntDef(copy(OnlyNumber(Self.WebServices.Consulta.NFeChave),1,2),0);
       infEvento.dhEvento := now;
       infEvento.tpEvento := teCancelamento;
       infEvento.chNFe := Self.WebServices.Consulta.NFeChave;
       infEvento.detEvento.nProt := Self.WebServices.Consulta.Protocolo;
       infEvento.detEvento.xJust := AJustificativa;
     end;
     try
        Self.EnviarEventoNFe(ALote);
     except
        raise Exception.Create(Self.WebServices.EnvEvento.EventoRetorno.xMotivo);
     end;
  end;
  Result := True;
end;

function TACBrNFe.Consultar: Boolean;
var
  i: Integer;
begin
  if Self.NotasFiscais.Count = 0 then
   begin
     if Assigned(Self.OnGerarLog) then
        Self.OnGerarLog('ERRO: Nenhuma Nota Fiscal Eletr�nica Informada!');
     raise EACBrNFeException.Create('Nenhuma Nota Fiscal Eletr�nica Informada!');
   end;

  for i := 0 to Self.NotasFiscais.Count-1 do
  begin
    WebServices.Consulta.NFeChave := OnlyNumber(self.NotasFiscais.Items[i].NFe.infNFe.ID);
    WebServices.Consulta.Executar;
  end;
  Result := True;
end;

function TACBrNFe.Enviar(ALote: Integer; Imprimir: Boolean = True; Sincrono: Boolean = False): Boolean;
begin
  Result := Enviar(IntToStr(ALote),Imprimir, Sincrono);
end;

function TACBrNFe.Enviar(ALote: String; Imprimir: Boolean; Sincrono: Boolean): Boolean;
var
  i: Integer;
begin
  if NotasFiscais.Count <= 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhuma NF-e adicionada ao Lote');
      raise EACBrNFeException.Create('ERRO: Nenhuma NF-e adicionada ao Lote');
     exit;
   end;

  if NotasFiscais.Count > 50 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Conjunto de NF-e transmitidas (m�ximo de 50 NF-e) excedido. Quantidade atual: '+IntToStr(NotasFiscais.Count));
      raise EACBrNFeException.Create('ERRO: Conjunto de NF-e transmitidas (m�ximo de 50 NF-e) excedido. Quantidade atual: '+IntToStr(NotasFiscais.Count));
     exit;
   end;
  NotasFiscais.Assinar;
  NotasFiscais.Valida;

  Result := WebServices.Envia(ALote, Sincrono);

  if DANFE <> nil then
  begin
     for i:= 0 to NotasFiscais.Count-1 do
     begin
       if NotasFiscais.Items[i].Confirmada and Imprimir then
       begin
          NotasFiscais.Items[i].Imprimir;
          if (DANFE.ClassName='TACBrNFeDANFERaveCB') then
            Break;
       end;
     end;
  end;
end;

function TACBrNFe.EnviarCartaCorrecao(idLote: Integer): Boolean;
var
  i : integer;
begin
  EventoNFe.Evento.Clear;
  for i:= 0 to CartaCorrecao.CCe.Evento.Count-1 do
   begin
     with EventoNFe.Evento.Add do
      begin
        infEvento.id       := CartaCorrecao.CCe.Evento[i].InfEvento.id;
        infEvento.cOrgao   := CartaCorrecao.CCe.Evento[i].InfEvento.cOrgao;
        infEvento.tpAmb    := CartaCorrecao.CCe.Evento[i].InfEvento.tpAmb;
        infEvento.CNPJ     := CartaCorrecao.CCe.Evento[i].InfEvento.CNPJ;
        infEvento.chNFe    := CartaCorrecao.CCe.Evento[i].InfEvento.chNFe;
        infEvento.dhEvento := CartaCorrecao.CCe.Evento[i].InfEvento.dhEvento;
        infEvento.tpEvento := teCCe;
        infEvento.nSeqEvento   := CartaCorrecao.CCe.Evento[i].InfEvento.nSeqEvento;
        infEvento.versaoEvento := CartaCorrecao.CCe.Evento[i].InfEvento.versaoEvento;
        infEvento.detEvento.versao     := CartaCorrecao.CCe.Evento[i].InfEvento.detEvento.versao;
        infEvento.detEvento.descEvento := CartaCorrecao.CCe.Evento[i].InfEvento.detEvento.descEvento;
        infEvento.detEvento.xCondUso   := CartaCorrecao.CCe.Evento[i].InfEvento.detEvento.xCondUso;
        infEvento.detEvento.xCorrecao  := CartaCorrecao.CCe.Evento[i].InfEvento.detEvento.xCorrecao;
      end;
   end;

  Result := EnviarEventoNFe(idLote);
end;

function TACBrNFe.EnviarEventoNFe(idLote: Integer): Boolean;
var
  i: integer;
begin
  if EventoNFe.Evento.Count <= 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhum Evento adicionado ao Lote');
      raise EACBrNFeException.Create('ERRO: Nenhum Evento adicionado ao Lote');
     exit;
   end;

  if EventoNFe.Evento.Count > 20 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Conjunto de Eventos transmitidos (m�ximo de 20) excedido. Quantidade atual: '+IntToStr(EventoNFe.Evento.Count));
      raise EACBrNFeException.Create('ERRO: Conjunto de Eventos transmitidos (m�ximo de 20) excedido. Quantidade atual: '+IntToStr(EventoNFe.Evento.Count));
     exit;
   end;

  WebServices.EnvEvento.idLote := idLote;

  {Atribuir nSeqEvento, CNPJ, Chave e/ou Protocolo quando n�o especificar}
  for i:= 0 to EventoNFe.Evento.Count -1 do
  begin
    try
      if EventoNFe.Evento.Items[i].InfEvento.nSeqEvento = 0 then
        EventoNFe.Evento.Items[i].infEvento.nSeqEvento := 1;
      if self.NotasFiscais.Count > 0 then
       begin
         if trim(EventoNFe.Evento.Items[i].InfEvento.CNPJ) = '' then
           EventoNFe.Evento.Items[i].InfEvento.CNPJ := self.NotasFiscais.Items[i].NFe.Emit.CNPJCPF;
         if trim(EventoNFe.Evento.Items[i].InfEvento.chNfe) = '' then
           EventoNFe.Evento.Items[i].InfEvento.chNfe := copy(self.NotasFiscais.Items[i].NFe.infNFe.ID, (length(self.NotasFiscais.Items[i].NFe.infNFe.ID)-44)+1, 44);
         if trim(EventoNFe.Evento.Items[i].infEvento.detEvento.nProt) = '' then
         begin
           if EventoNFe.Evento.Items[i].infEvento.tpEvento = teCancelamento then
            begin
              EventoNFe.Evento.Items[i].infEvento.detEvento.nProt := self.NotasFiscais.Items[i].NFe.procNFe.nProt;
              if trim(EventoNFe.Evento.Items[i].infEvento.detEvento.nProt) = '' then
               begin
                  WebServices.Consulta.NFeChave := EventoNFe.Evento.Items[i].InfEvento.chNfe;
                  if not WebServices.Consulta.Executar then
                    raise Exception.Create(WebServices.Consulta.Msg);
                  EventoNFe.Evento.Items[i].infEvento.detEvento.nProt := WebServices.Consulta.Protocolo;
               end; 
            end;
         end;
       end;
    except
    end;
  end;
  {**}

  Result := WebServices.EnvEvento.Executar;
  if not Result then
  begin
    if Assigned(Self.OnGerarLog) then
      Self.OnGerarLog(WebServices.EnvEvento.Msg);
    raise EACBrNFeException.Create(WebServices.EnvEvento.Msg);
  end;
end;

function TACBrNFe.ConsultaNFeDest(CNPJ: String; IndNFe: TpcnIndicadorNFe;
  IndEmi: TpcnIndicadorEmissor; ultNSU: String): Boolean;
begin
  WebServices.ConsNFeDest.CNPJ   := CNPJ;
  WebServices.ConsNFeDest.indNFe := IndNFe;
  WebServices.ConsNFeDest.indEmi := IndEmi;
  WebServices.ConsNFeDest.ultNSU := ultNSU;

  Result := WebServices.ConsNFeDest.Executar;
  if not Result then
  begin
    if Assigned(Self.OnGerarLog) then
      Self.OnGerarLog(WebServices.ConsNFeDest.Msg);
    raise EACBrNFeException.Create(WebServices.ConsNFeDest.Msg);
  end;
end;

function TACBrNFe.Download: Boolean;
begin
  Result := WebServices.DownloadNFe.Executar;
  if not Result then
  begin
    if Assigned(Self.OnGerarLog) then
      Self.OnGerarLog(WebServices.DownloadNFe.Msg);
    raise EACBrNFeException.Create(WebServices.DownloadNFe.Msg);
  end;
end;

procedure TACBrNFe.ImprimirEvento;
begin
  if not Assigned( DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE n�o associado.')
  else
     DANFE.ImprimirEVENTO(nil);
end;

procedure TACBrNFe.ImprimirEventoPDF;
begin
  if not Assigned( DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE n�o associado.')
  else
     DANFE.ImprimirEVENTOPDF(nil);
end;

procedure TACBrNFe.ImprimirInutilizacao;
begin
  if not Assigned( DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE n�o associado.')
  else
     DANFE.ImprimirINUTILIZACAO(nil);
end;

procedure TACBrNFe.ImprimirInutilizacaoPDF;
begin
  if not Assigned( DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE n�o associado.')
  else
     DANFE.ImprimirINUTILIZACAOPDF(nil);
end;

procedure TACBrNFe.EnviarEmailNormal(const sSmtpHost, sSmtpPort, sSmtpUser,
      sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings;
      SSL: Boolean; sCC, Anexos: TStrings; PedeConfirma, AguardarEnvio: Boolean;
      NomeRemetente: String; TLS: Boolean; StreamNFe: TStringStream;
      NomeArq: String; HTML:Boolean);
var
  smtp: TSMTPSend;
  msg_lines: TStringList;
  m:TMimemess;
  p: TMimepart;
  I : Integer;
  CorpoEmail: TStringList;
begin
  SetStatus( stNFeEmail );

  msg_lines := TStringList.Create;
  CorpoEmail := TStringList.Create;
  smtp := TSMTPSend.Create;
  m:=TMimemess.create;
  try
     p := m.AddPartMultipart('mixed', nil);
     if sMensagem <> nil then
     begin
//        CorpoEmail.Text := sMensagem.Text;
//        m.AddPartText(CorpoEmail, p);
       if HTML = true then
         m.AddPartHTML(sMensagem, p)
       else
         m.AddPartText(sMensagem, p);
     end;

     if StreamNFe <> nil then
       m.AddPartBinary(StreamNFe,NomeArq, p);

     if assigned(Anexos) then
     for i := 0 to Anexos.Count - 1 do
     begin
        m.AddPartBinaryFromFile(Anexos[i], p);
     end;

     m.header.tolist.add(sTo);

     if Trim(NomeRemetente) <> '' then
       m.header.From := Format('%s<%s>', [NomeRemetente, sFrom])
     else
       m.header.From := sFrom;

     m.header.subject := sAssunto;
     m.EncodeMessage;
     msg_lines.Add(m.Lines.Text);

     smtp.UserName := sSmtpUser;
     smtp.Password := sSmtpPasswd;

     smtp.TargetHost := sSmtpHost;
     smtp.TargetPort := sSmtpPort;

     smtp.FullSSL := SSL;
     // smtp.AutoTLS := SSL; ?
     smtp.AutoTLS := TLS;

     if(TLS) then
       smtp.StartTLS;

     if not smtp.Login then
       raise Exception.Create('SMTP ERROR: Login: ' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

     if not smtp.MailFrom(sFrom, Length(sFrom)) then
       raise Exception.Create('SMTP ERROR: MailFrom: ' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

     if not smtp.MailTo(sTo) then
       raise Exception.Create('SMTP ERROR: MailTo: ' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

     if sCC <> nil then
     begin
       for I := 0 to sCC.Count - 1 do
       begin
         if not smtp.MailTo(sCC.Strings[i]) then
           raise Exception.Create('SMTP ERROR: MailTo: ' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
       end;
     end;

     if not smtp.MailData(msg_lines) then
       raise Exception.Create('SMTP ERROR: MailData: ' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

     if not smtp.Logout then
       raise Exception.Create('SMTP ERROR: Logout: ' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
  finally
     msg_lines.Free;
     CorpoEmail.Free;
     smtp.Free;
     m.free;
     SetStatus( stIdle );
  end;
end;

procedure TACBrNFe.EnviaEmailThread(const sSmtpHost, sSmtpPort, sSmtpUser,
  sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings;
  SSL: Boolean; sCC, Anexos: TStrings; PedeConfirma,
  AguardarEnvio: Boolean; NomeRemetente: String; TLS: Boolean;
  StreamNFe : TStringStream; NomeArq : String;HTML:Boolean=false);
var
 ThreadSMTP : TSendMailThread;
 m:TMimemess;
 p: TMimepart;
 i: Integer;
begin
 m:=TMimemess.create;

 ThreadSMTP := TSendMailThread.Create;  // N�o Libera, pois usa FreeOnTerminate := True;
 try
    p := m.AddPartMultipart('mixed', nil);
    if sMensagem <> nil then
    begin
       if HTML = true then
          m.AddPartHTML(sMensagem, p)
       else
          m.AddPartText(sMensagem, p);
    end;

    if StreamNFe <> nil then
      m.AddPartBinary(StreamNFe,NomeArq, p);

    if assigned(Anexos) then
      for i := 0 to Anexos.Count - 1 do
      begin
        m.AddPartBinaryFromFile(Anexos[i], p);
      end;

    m.header.tolist.add(sTo);

    if Trim(NomeRemetente) <> '' then
      m.header.From := Format('%s<%s>', [NomeRemetente, sFrom])
    else
      m.header.From := sFrom;

    m.header.subject:= sAssunto;
    m.Header.ReplyTo := sFrom;
    if PedeConfirma then
       m.Header.CustomHeaders.Add('Disposition-Notification-To: '+sFrom);
    m.EncodeMessage;

    ThreadSMTP.sFrom := sFrom;
    ThreadSMTP.sTo   := sTo;
    if sCC <> nil then
       ThreadSMTP.sCC.AddStrings(sCC);
    ThreadSMTP.slmsg_Lines.AddStrings(m.Lines);

    ThreadSMTP.smtp.UserName := sSmtpUser;
    ThreadSMTP.smtp.Password := sSmtpPasswd;

    ThreadSMTP.smtp.TargetHost := sSmtpHost;
    if not DFeUtil.EstaVazio( sSmtpPort ) then     // Usa default
       ThreadSMTP.smtp.TargetPort := sSmtpPort;

    ThreadSMTP.smtp.FullSSL := SSL;
    ThreadSMTP.smtp.AutoTLS := TLS;

    // ThreadSMTP.smtp.StartTLS; ?

    if(TLS) then
      ThreadSMTP.smtp.StartTLS;

    SetStatus( stNFeEmail );
    ThreadSMTP.Resume; // inicia a thread
    if AguardarEnvio then
    begin
      repeat
        Sleep(1000);
        Application.ProcessMessages;
      until ThreadSMTP.Terminado;
    end;
    SetStatus( stIdle );
 finally
    m.free;
 end;
end;

procedure TACBrNFe.EnviaEmail(const sSmtpHost, sSmtpPort, sSmtpUser,
  sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings;
  SSL: Boolean; sCC, Anexos: TStrings; PedeConfirma,
  AguardarEnvio: Boolean; NomeRemetente: String; TLS: Boolean;
  StreamNFe : TStringStream; NomeArq : String; UsarThread: Boolean;HTML:Boolean);
begin
  if UsarThread then
  begin
    EnviaEmailThread(
      sSmtpHost,
      sSmtpPort,
      sSmtpUser,
      sSmtpPasswd,
      sFrom,
      sTo,
      sAssunto,
      sMensagem,
      SSL,
      sCC,
      Anexos,
      PedeConfirma,
      AguardarEnvio,
      NomeRemetente,
      TLS,
      StreamNFe,
      NomeArq,
      HTML
    );
  end
  else
  begin
    EnviarEmailNormal(
      sSmtpHost,
      sSmtpPort,
      sSmtpUser,
      sSmtpPasswd,
      sFrom,
      sTo,
      sAssunto,
      sMensagem,
      SSL,
      sCC,
      Anexos,
      PedeConfirma,
      AguardarEnvio,
      NomeRemetente,
      TLS,
      StreamNFe,
      NomeArq,
      HTML
    );
  end;
end;

procedure TACBrNFe.EnviarEmailEvento(const sSmtpHost, sSmtpPort, sSmtpUser,
  sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings; SSL,
  EnviaPDF: Boolean; sCC, Anexos: TStrings; PedeConfirma,
  AguardarEnvio: Boolean; NomeRemetente: String; TLS: Boolean;
  UsarThread: Boolean; HTML: Boolean);
var
  NomeArq : String;
  AnexosEmail:TStrings;
begin
  AnexosEmail := TStringList.Create;
  try
    AnexosEmail.Clear;
    if Anexos <> nil then
      AnexosEmail.Text := Anexos.Text;

   // AnexosEmail.Add('');
    if (EnviaPDF) then
    begin
      if DANFE <> nil then
      begin
        ImprimirEventoPDF;
        NomeArq := OnlyNumber(EventoNFe.Evento[0].InfEvento.id);
//        NomeArq := Copy(EventoNFe.Evento[0].InfEvento.id, 09, 44) +
//                   Copy(EventoNFe.Evento[0].InfEvento.id, 03, 06) +
//                   Copy(EventoNFe.Evento[0].InfEvento.id, 53, 02);
        NomeArq := PathWithDelim(DANFE.PathPDF)+NomeArq+'-procEventoNFe.pdf';
        AnexosEmail.Add(NomeArq);
      end;
    end;

    EnviaEmail(sSmtpHost,
                sSmtpPort,
                sSmtpUser,
                sSmtpPasswd,
                sFrom,
                sTo,
                sAssunto,
                sMensagem,
                SSL,
                sCC,
                AnexosEmail,
                PedeConfirma,
                AguardarEnvio,
                NomeRemetente,
                TLS,
                nil,
                '',
                UsarThread,
                HTML);
  finally
    AnexosEmail.Free;
  end;
end;

function TACBrNFe.AdministrarCSC(ARaizCNPJ: String;
  AIndOP: TpcnIndOperacao; AIdCSC: Integer; ACodigoCSC: String): Boolean;
begin
  WebServices.AdministrarCSCNFCe.RaizCNPJ  := ARaizCNPJ;
  WebServices.AdministrarCSCNFCe.indOP     := AIndOP;
  WebServices.AdministrarCSCNFCe.idCsc     := AIdCSC;
  WebServices.AdministrarCSCNFCe.codigoCsc := ACodigoCSC;

  Result := WebServices.AdministrarCSCNFCe.Executar;

  if not Result then
  begin
    if Assigned(Self.OnGerarLog) then
      Self.OnGerarLog(WebServices.AdministrarCSCNFCe.Msg);
    raise EACBrNFeException.Create(WebServices.AdministrarCSCNFCe.Msg);
  end;
end;

function TACBrNFe.DistribuicaoDFe(AcUFAutor: Integer; ACNPJCPF, AultNSU,
  ANSU: String): Boolean;
begin
  WebServices.DistribuicaoDFe.cUFAutor := AcUFAutor;
  WebServices.DistribuicaoDFe.CNPJCPF  := ACNPJCPF;
  WebServices.DistribuicaoDFe.ultNSU   := AultNSU;
  WebServices.DistribuicaoDFe.NSU      := ANSU;

  Result := WebServices.DistribuicaoDFe.Executar;

  if not Result then
  begin
    if Assigned(Self.OnGerarLog) then
      Self.OnGerarLog(WebServices.DistribuicaoDFe.Msg);
    raise EACBrNFeException.Create(WebServices.DistribuicaoDFe.Msg);
  end;
end;

{ TCartaCorrecao }

constructor TCartaCorrecao.Create(AOwner: TComponent);
begin
  inherited;
  FCCe := TCCeNFe.Create;
end;

destructor TCartaCorrecao.Destroy;
begin
  FCCe.Free;
  inherited;
end;

{ TDownload }

constructor TDownload.Create(AOwner: TComponent);
begin
  inherited;
  FDownload := TDownloadNFe.Create;
end;

destructor TDownload.Destroy;
begin
  FDownload.Free;
  inherited;
end;

end.
