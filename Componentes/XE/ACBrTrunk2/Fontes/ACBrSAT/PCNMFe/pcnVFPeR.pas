{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2017 Andr� Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esse arquivo usa a classe  PCN (c) 2009 - Paulo Casagrande                  }
{  PCN - Projeto Cooperar NFe       (Found at URL:  www.projetocooperar.org)   }
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

unit pcnVFPeR;

interface uses

  SysUtils, Classes,
  pcnConversao, pcnLeitor, pcnVFPe;

type

  { TEnviarPagamentoR }
  TEnviarPagamentoR = class(TPersistent)
  private
    FLeitor: TLeitor;
    FEnviarPagamento: TEnviarPagamento;
  public
    constructor Create(AOwner: TEnviarPagamento);
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property EnviarPagamento: TEnviarPagamento read FEnviarPagamento write FEnviarPagamento;
  end;

  { TRespostaPagamentoR }
  TRespostaPagamentoR = class(TPersistent)
  private
    FLeitor: TLeitor;
    FRespostaPagamento: TRespostaPagamento;
  public
    constructor Create(AOwner: TRespostaPagamento);
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property RespostaPagamento: TRespostaPagamento read FRespostaPagamento write FRespostaPagamento;
  end;

  { TRespostaVerificarStatusValidadorR }
  TRespostaVerificarStatusValidadorR = class(TPersistent)
  private
    FLeitor: TLeitor;
    FRespostaVerificarStatusValidador: TRespostaVerificarStatusValidador;
  public
    constructor Create(AOwner: TRespostaVerificarStatusValidador);
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property RespostaVerificarStatusValidador: TRespostaVerificarStatusValidador read FRespostaVerificarStatusValidador write FRespostaVerificarStatusValidador;
  end;

  { TRetornoRespostaFiscalR }
  TRetornoRespostaFiscalR = class(TPersistent)
  private
    FLeitor: TLeitor;
    FRetornoRespostaFiscal: TRetornoRespostaFiscal;
  public
    constructor Create(AOwner: TRetornoRespostaFiscal);
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property RetornoRespostaFiscal: TRetornoRespostaFiscal read FRetornoRespostaFiscal write FRetornoRespostaFiscal;
  end;

  { TRespostaStatusPagamentoR }
  TRespostaStatusPagamentoR = class(TPersistent)
  private
    FLeitor: TLeitor;
    FRespostaStatusPagamento: TRespostaStatusPagamento;
  public
    constructor Create(AOwner: TRespostaStatusPagamento);
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property RespostaStatusPagamento: TRespostaStatusPagamento read FRespostaStatusPagamento write FRespostaStatusPagamento;
  end;


  ////////////////////////////////////////////////////////////////////////////////

implementation

uses ACBrConsts;

{ TRespostaStatusPagamentoR }

constructor TRespostaStatusPagamentoR.Create(AOwner: TRespostaStatusPagamento);
begin
  FLeitor := TLeitor.Create;
  FRespostaStatusPagamento := AOwner;
end;

destructor TRespostaStatusPagamentoR.Destroy;
begin
  FLeitor.Free;
  inherited Destroy;
end;

function TRespostaStatusPagamentoR.LerXml: boolean;
begin
  Result := False;
  RespostaStatusPagamento.Clear;

  if Leitor.rExtrai(1, 'Integrador') <> '' then
  begin
    RespostaStatusPagamento.Retorno := Leitor.rCampo(tcStr, 'retorno');
    RespostaStatusPagamento.IntegradorResposta.LerResposta(Leitor.Grupo);
  end ;

  Result := True;
end;

{ TRespostaVerificarStatusValidadorR }

constructor TRespostaVerificarStatusValidadorR.Create(
  AOwner: TRespostaVerificarStatusValidador);
begin
  FLeitor := TLeitor.Create;
  FRespostaVerificarStatusValidador := AOwner;
end;

destructor TRespostaVerificarStatusValidadorR.Destroy;
begin
  FLeitor.Free;
  inherited Destroy;
end;

function TRespostaVerificarStatusValidadorR.LerXml: boolean;
begin
  Result := False;
  RespostaVerificarStatusValidador.Clear;

  if Leitor.rExtrai(1, 'Integrador') <> '' then
  begin
    RespostaVerificarStatusValidador.CodigoAutorizacao := Leitor.rCampo(tcStr, 'CodigoAutorizacao');
    RespostaVerificarStatusValidador.Bin := Leitor.rCampo(tcStr, 'Bin');
    RespostaVerificarStatusValidador.DonoCartao := Leitor.rCampo(tcStr, 'DonoCartao');
    RespostaVerificarStatusValidador.DataExpiracao := Leitor.rCampo(tcStr, 'DataExpiracao');
    RespostaVerificarStatusValidador.InstituicaoFinanceira := Leitor.rCampo(tcStr, 'InstituicaoFinanceira');
    RespostaVerificarStatusValidador.Parcelas := Leitor.rCampo(tcInt, 'Parcelas');
    RespostaVerificarStatusValidador.UltimosQuatroDigitos := Leitor.rCampo(tcInt, 'UltimosQuatroDigitos');
    RespostaVerificarStatusValidador.CodigoPagamento := Leitor.rCampo(tcStr, 'CodigoPagamento');
    RespostaVerificarStatusValidador.ValorPagamento := Leitor.rCampo(tcDe2, 'ValorPagamento');
    RespostaVerificarStatusValidador.idFila := Leitor.rCampo(tcInt, 'idFila');
    RespostaVerificarStatusValidador.Tipo := Leitor.rCampo(tcStr, 'Tipo');

    RespostaVerificarStatusValidador.IntegradorResposta.LerResposta(Leitor.Grupo);
  end ;

  Result := True;
end;

{ TRespostaPagamentoR }

constructor TRespostaPagamentoR.Create(AOwner: TRespostaPagamento);
begin
  FLeitor := TLeitor.Create;
  FRespostaPagamento := AOwner;
end;

destructor TRespostaPagamentoR.Destroy;
begin
  FLeitor.Free;
  inherited Destroy;
end;

function TRespostaPagamentoR.LerXml: boolean;
begin
  Result := False;
  RespostaPagamento.Clear;

  if Leitor.rExtrai(1, 'Integrador') <> '' then
  begin
    RespostaPagamento.IDPagamento     := Leitor.rCampo(tcInt, 'IDPagamento');
    RespostaPagamento.Mensagem        := Leitor.rCampo(tcStr, 'Mensagem');
    RespostaPagamento.StatusPagamento := Leitor.rCampo(tcStr, 'StatusPagamento');

    RespostaPagamento.IntegradorResposta.LerResposta(Leitor.Grupo);
  end ;

  Result := True;
end;

{ TEnviarPagamentoR }

constructor TEnviarPagamentoR.Create(AOwner: TEnviarPagamento);
begin
  FLeitor := TLeitor.Create;
  FEnviarPagamento := AOwner;
end;

destructor TEnviarPagamentoR.Destroy;
begin
  FLeitor.Free;
  inherited Destroy;
end;

function TEnviarPagamentoR.LerXml: boolean;
begin
  Result := False;
  EnviarPagamento.Clear;

  if Leitor.rExtrai(1, 'Integrador') <> '' then
  begin
    EnviarPagamento.Identificador        := Leitor.rCampo(tcStr, 'identificador');
    EnviarPagamento.ChaveAcessoValidador := Leitor.rCampo(tcStr, 'chaveAcessoValidador');
    EnviarPagamento.ChaveRequisicao      := Leitor.rCampo(tcStr, 'chaveRequisicao');
    EnviarPagamento.Estabelecimento      := Leitor.rCampo(tcStr, 'Estabelecimento');
    EnviarPagamento.CNPJ                 := Leitor.rCampo(tcStr, 'CNPJ');
    EnviarPagamento.SerialPOS            := Leitor.rCampo(tcStr, 'SerialPOS');
    EnviarPagamento.IcmsBase             := Leitor.rCampo(tcDe2, 'IcmsBase');
    EnviarPagamento.ValorTotalVenda      := Leitor.rCampo(tcDe2, 'ValorTotalVenda');
  end ;

  Result := True;
end;

{ TRetornoRespostaFiscalR }

constructor TRetornoRespostaFiscalR.Create(AOwner: TRetornoRespostaFiscal);
begin
  FLeitor := TLeitor.Create;
  FRetornoRespostaFiscal := AOwner;
end;

destructor TRetornoRespostaFiscalR.Destroy;
begin
  FLeitor.Free;
  inherited Destroy;
end;

function TRetornoRespostaFiscalR.LerXml: boolean;
begin
  Result := False;
  RetornoRespostaFiscal.Clear;

  if Leitor.rExtrai(1, 'Integrador') <> '' then
  begin
    RetornoRespostaFiscal.IdRespostaFiscal := Leitor.rCampo(tcStr, 'retorno');
    RetornoRespostaFiscal.IntegradorResposta.LerResposta(Leitor.Grupo);
  end ;

  Result := True;
end;

end.
