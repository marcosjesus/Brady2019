{******************************************************************************}
{ Projeto: Componente ACBrCTe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Conhecimen-}
{ to de Transporte eletr�nico - CTe - http://www.cte.fazenda.gov.br            }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }
{                                                                              }
{ Desenvolvimento                                                              }
{         de Cte: Wiliam Zacarias da Silva Rosa                                }
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

unit ACBrCTeConfiguracoes;

interface

uses
  Classes, Sysutils, ACBrDFeConfiguracoes, pcnConversao, pcteConversaoCTe;

type

  { TGeralConfCTe }

  TGeralConfCTe = class(TGeralConf)
  private
    FModeloDF: TModeloCTe;
    FModeloDFCodigo: integer;
    FVersaoDF: TVersaoCTe;

    procedure SetVersaoDF(const Value: TVersaoCTe);
    procedure SetModeloDF(const Value: TModeloCTe);
  public
    constructor Create(AOwner: TConfiguracoes); override;
    procedure Assign(DeGeralConfCTe: TGeralConfCTe); reintroduce;

  published
    property ModeloDF: TModeloCTe read FModeloDF write SetModeloDF default moCTe;
    property ModeloDFCodigo: integer read FModeloDFCodigo;
    property VersaoDF: TVersaoCTe read FVersaoDF write SetVersaoDF default ve200;
  end;

  { TDownloadConfCTe }

  TDownloadConfCTe = class(TPersistent)
  private
    FPathDownload: String;
    FSepararPorNome: Boolean;
  public
    Constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property PathDownload: String read FPathDownload write FPathDownload;
    property SepararPorNome: Boolean read FSepararPorNome write FSepararPorNome default False;
  end;

  { TArquivosConfCTe }

  TArquivosConfCTe = class(TArquivosConf)
  private
    FEmissaoPathCTe: Boolean;
    FSalvarApenasCTeProcessados: Boolean;
    FPathCTe: String;
    FPathInu: String;
    FPathEvento: String;
    FDownloadCTe: TDownloadConfCTe;
  public
    constructor Create(AOwner: TConfiguracoes); override;
    procedure Assign(DeArquivosConfCTe: TArquivosConfCTe); reintroduce;
    destructor Destroy; override;

    function GetPathCTe(Data: TDateTime = 0; CNPJ: String = ''): String;
    function GetPathInu(Data: TDateTime = 0; CNPJ: String = ''): String;
    function GetPathEvento(tipoEvento: TpcnTpEvento; CNPJ: String = ''; Data: TDateTime = 0): String;
    function GetPathDownload(xNome: String = ''; CNPJ: String = ''; Data: TDateTime = 0): String;
  published
    property EmissaoPathCTe: Boolean     read FEmissaoPathCte write FEmissaoPathCTe default False;
    property SalvarApenasCTeProcessados: Boolean read FSalvarApenasCTeProcessados write FSalvarApenasCTeProcessados default False;
    property PathCTe: String             read FPathCTe        write FPathCTe;
    property PathInu: String             read FPathInu        write FPathInu;
    property PathEvento: String          read FPathEvento     write FPathEvento;
    property DownloadCTe: TDownloadConfCTe read FDownloadCTe write FDownloadCTe;
  end;

  { TConfiguracoesCTe }

  TConfiguracoesCTe = class(TConfiguracoes)
  private
    function GetGeral: TGeralConfCTe;
    function GetArquivos: TArquivosConfCTe;
  protected
    procedure CreateGeralConf; override;
    procedure CreateArquivosConf; override;

  public
    constructor Create(AOwner: TComponent); override;
    procedure Assign(DeConfiguracoesCTe: TConfiguracoesCTe); reintroduce;

  published
    property Geral: TGeralConfCTe       read GetGeral;
    property Arquivos: TArquivosConfCTe read GetArquivos;
    property WebServices;
    property Certificados;
  end;

implementation

uses
  ACBrUtil, DateUtils;

{ TConfiguracoesCTe }

constructor TConfiguracoesCTe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  WebServices.ResourceName := 'ACBrCTeServicos';
end;

function TConfiguracoesCTe.GetGeral: TGeralConfCTe;
begin
  Result := TGeralConfCTe(FPGeral);
end;

function TConfiguracoesCTe.GetArquivos: TArquivosConfCTe;
begin
  Result := TArquivosConfCTe(FPArquivos);
end;

procedure TConfiguracoesCTe.CreateGeralConf;
begin
  FPGeral := TGeralConfCTe.Create(Self);
end;

procedure TConfiguracoesCTe.CreateArquivosConf;
begin
  FPArquivos := TArquivosConfCTe.Create(Self);
end;

procedure TConfiguracoesCTe.Assign(DeConfiguracoesCTe: TConfiguracoesCTe);
begin
  Geral.Assign(DeConfiguracoesCTe.Geral);
  WebServices.Assign(DeConfiguracoesCTe.WebServices);
  Certificados.Assign(DeConfiguracoesCTe.Certificados);
  Arquivos.Assign(DeConfiguracoesCTe.Arquivos);
end;

{ TGeralConfCTe }

procedure TGeralConfCTe.Assign(DeGeralConfCTe: TGeralConfCTe);
begin
  inherited Assign(DeGeralConfCTe);

  ModeloDF := DeGeralConfCTe.ModeloDF;
  FVersaoDF := DeGeralConfCTe.VersaoDF;
end;

constructor TGeralConfCTe.Create(AOwner: TConfiguracoes);
begin
  Inherited Create(AOwner);

  FModeloDF := moCTe;
  FModeloDFCodigo := StrToInt(ModeloCTeToStr(FModeloDF));
  FVersaoDF := ve200;
end;

procedure TGeralConfCTe.SetModeloDF(const Value: TModeloCTe);
begin
  FModeloDF := Value;
  FModeloDFCodigo := StrToInt(ModeloCTeToStr(FModeloDF));
end;

procedure TGeralConfCTe.SetVersaoDF(const Value: TVersaoCTe);
begin
  FVersaoDF := Value;
end;

{ TArquivosConfCTe }

procedure TArquivosConfCTe.Assign(DeArquivosConfCTe: TArquivosConfCTe);
begin
  inherited Assign(DeArquivosConfCTe);

  FEmissaoPathCTe := DeArquivosConfCTe.EmissaoPathCTe;
  FSalvarApenasCTeProcessados := DeArquivosConfCTe.SalvarApenasCTeProcessados;
  FPathCTe := DeArquivosConfCTe.PathCTe;
  FPathInu := DeArquivosConfCTe.PathInu;
  FPathEvento := DeArquivosConfCTe.PathEvento;

  FDownloadCTe.Assign(DeArquivosConfCTe.DownloadCTe);
end;

constructor TArquivosConfCTe.Create(AOwner: TConfiguracoes);
begin
  inherited Create(AOwner);

  FDownloadCTe := TDownloadConfCTe.Create;
  FEmissaoPathCTe := False;
  FSalvarApenasCTeProcessados := False;
  FPathCTe := '';
  FPathInu := '';
  FPathEvento := '';
end;

destructor TArquivosConfCTe.Destroy;
begin
  FDownloadCTe.Free;

  inherited;
end;

function TArquivosConfCTe.GetPathCTe(Data: TDateTime = 0; CNPJ: String = ''): String;
begin
  Result := GetPath(FPathCTe, 'CTe', CNPJ, Data);
end;

function TArquivosConfCTe.GetPathInu(Data: TDateTime = 0; CNPJ: String = ''): String;
begin
  Result := GetPath(FPathInu, 'Inu', CNPJ);
end;

function TArquivosConfCTe.GetPathEvento(tipoEvento: TpcnTpEvento;
  CNPJ: String = ''; Data: TDateTime = 0): String;
var
  Dir: String;
begin
  Dir := GetPath(FPathEvento, 'Evento', CNPJ, Data);

  if AdicionarLiteral then
    Dir := PathWithDelim(Dir) + TpEventoToDescStr(tipoEvento);

  if not DirectoryExists(Dir) then
     ForceDirectories(Dir);

  Result := Dir;
end;

function TArquivosConfCTe.GetPathDownload(xNome: String = ''; CNPJ: String = ''; Data: TDateTime = 0): String;
var
  rPathDown: String;
begin
  rPathDown := '';
  if EstaVazio(FDownloadCTe.PathDownload) then
     FDownloadCTe.PathDownload := PathSalvar;

  if (FDownloadCTe.SepararPorNome) and (NaoEstaVazio(xNome)) then
     rPathDown := rPathDown + PathWithDelim(FDownloadCTe.PathDownload) + TiraAcentos(xNome)
  else
     rPathDown := FDownloadCTe.PathDownload;

  Result := GetPath(rPathDown, 'Down', CNPJ, Data);
end;

{ TDownloadConfCTe }

procedure TDownloadConfCTe.Assign(Source: TPersistent);
begin
  if Source is TDownloadConfCTe then
  begin
    FPathDownload := TDownloadConfCTe(Source).PathDownload;
    FSepararPorNome := TDownloadConfCTe(Source).SepararPorNome;
  end
  else
    inherited Assign(Source);
end;

constructor TDownloadConfCTe.Create;
begin
  FPathDownload := '';
  FSepararPorNome := False;
end;

end.
