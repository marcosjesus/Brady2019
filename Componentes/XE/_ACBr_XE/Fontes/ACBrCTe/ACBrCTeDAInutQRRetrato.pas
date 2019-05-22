{******************************************************************************}
{ Projeto: Componente ACBrCTe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Conhecimen-}
{ to de Transporte eletr�nico - CTe - http://www.cte.fazenda.gov.br            }
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
*******************************************************************************}

{$I ACBr.inc}

unit ACBrCTeDAInutQRRetrato;

// Aten��o todos os comiters
// Quando enviar os fontes referentes ao DAEvento favor alterar
// a data e o nome da linha abaixo.
// �ltima libera��o:

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, XMLIntf, XMLDoc,
  JPEG, ACBrCTeQRCodeBar, pcnConversao, DB,
  DBClient, ACBrCTeDAInutQR;

type
  TfrmCTeDAInutQRRetrato = class(TfrmCTeDAInutQR)
    qrb_01_Titulo: TQRBand;
    qrlProtocolo: TQRLabel;
    qrlOrgao: TQRLabel;
    qrlDescricao: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel78: TQRLabel;
    qrlModelo: TQRLabel;
    qrb_07_Rodape: TQRBand;
    qrb_03_Inutilizacao: TQRChildBand;
    qrsQuadro01: TQRShape;
    qrsLinhaV10: TQRShape;
    qrsLinhaV09: TQRShape;
    qrsLinhaH04: TQRShape;
    qrsLinhaV01: TQRShape;
    QRShape46: TQRShape;
    qrlLinha3: TQRLabel;
    qrlLinha2: TQRLabel;
    qrlLinha1: TQRLabel;
    QRShape88: TQRShape;
    qrlTituloEvento: TQRLabel;
    QRShape48: TQRShape;
    QRLabel9: TQRLabel;
    qrlTipoAmbiente: TQRLabel;
    QRLabel6: TQRLabel;
    qrlSerie: TQRLabel;
    QRLabel28: TQRLabel;
    qrlAno: TQRLabel;
    QRLabel17: TQRLabel;
    qrlNumeracao: TQRLabel;
    QRShape49: TQRShape;
    QRShape50: TQRShape;
    QRLabel18: TQRLabel;
    qrlStatus: TQRLabel;
    cdsCorrecao: TClientDataSet;
    cdsCorrecaoItem: TIntegerField;
    cdsCorrecaoGrupo: TStringField;
    cdsCorrecaoCampo: TStringField;
    cdsCorrecaoValor: TStringField;
    qrb_05_NaoUsado_Detalhe: TQRBand;
    qrb_02_Emitente: TQRBand;
    qrsQuadro02: TQRShape;
    qrsLinhaH07: TQRShape;
    qrsLinhaH06: TQRShape;
    qrlRazaoEmitente: TQRLabel;
    qrlMunEmitente: TQRLabel;
    qrlInscEstEmitente: TQRLabel;
    qrlEnderecoEmitente: TQRLabel;
    qrlCNPJEmitente: TQRLabel;
    qrlCEPEmitente: TQRLabel;
    QRLabel98: TQRLabel;
    QRLabel93: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel12: TQRLabel;
    QRShape51: TQRShape;
    QRShape53: TQRShape;
    QRShape82: TQRShape;
    QRShape99: TQRShape;
    QRLabel4: TQRLabel;
    qrlBairroEmitente: TQRLabel;
    QRShape108: TQRShape;
    QRLabel5: TQRLabel;
    qrlFoneEmitente: TQRLabel;
    QRShape109: TQRShape;
    QRSysData1: TQRSysData;
    qrlblSistema: TQRLabel;
    QRShape1: TQRShape;
    qrb_04_NaoUsado: TQRBand;
    qrb_06_NaoUsado_Summary: TQRBand;
    QRLabel15: TQRLabel;
    QRShape2: TQRShape;
    QRLabel1: TQRLabel;
    qrlJustificativa: TQRLabel;
    procedure QRInutBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure qrb_02_EmitenteBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_03_InutilizacaoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_05_NaoUsado_DetalheBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_06_NaoUsado_SummaryBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_07_RodapeBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrdbtxtValorPrint(sender: TObject; var Value: String);
  private
    procedure Itens;
  public
    procedure ProtocoloCTe(const sProtocolo: String);
  end;

implementation

uses
  StrUtils, DateUtils,
  ACBrDFeUtil, ACBrCTeUtil;

{$R *.dfm}

var
  FProtocoloCTe : String;

procedure TfrmCTeDAInutQRRetrato.Itens;
var
  i: Integer;
begin
 // Itens
 (*
  if ( cdsCorrecao.Active ) then
  begin
    cdsCorrecao.CancelUpdates;
  end
  else
  begin
    cdsCorrecao.CreateDataSet;
  end;

  for i := 0 to (FEventoCTe.InfEvento.detEvento.infCorrecao.Count -1) do
  begin
    cdsCorrecao.Append;
    cdsCorrecaoItem.AsInteger := FEventoCTe.InfEvento.detEvento.infCorrecao[i].nroItemAlterado;
    cdsCorrecaoGrupo.AsString := FEventoCTe.InfEvento.detEvento.infCorrecao[i].grupoAlterado;
    cdsCorrecaoCampo.AsString := FEventoCTe.InfEvento.detEvento.infCorrecao[i].campoAlterado;
    cdsCorrecaoValor.AsString := FEventoCTe.InfEvento.detEvento.infCorrecao[i].valorAlterado;
    cdsCorrecao.Post;
  end;
  *)
end;

procedure TfrmCTeDAInutQRRetrato.ProtocoloCTe(const sProtocolo: String);
begin
  FProtocoloCTe := sProtocolo;
end;

procedure TfrmCTeDAInutQRRetrato.QRInutBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  inherited;

  Itens;

  QRCTeInut.ReportTitle := 'Inutiliza��o';

  QRCTeInut.Page.TopMargin    := FMargemSuperior * 100;
  QRCTeInut.Page.BottomMargin := FMargemInferior * 100;
  QRCTeInut.Page.LeftMargin   := FMargemEsquerda * 100;
  QRCTeInut.Page.RightMargin  := FMargemDireita  * 100;

end;

procedure TfrmCTeDAInutQRRetrato.qrb_02_EmitenteBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  PrintBand := False;

 (*
  if FCTe <> nil
   then begin
    PrintBand := True;

    qrlRazaoEmitente.Caption    := FCTe.emit.xNome;
    qrlCNPJEmitente.Caption     := DFeUtil.FormatarCNPJCPF(FCTe.emit.CNPJ);
    qrlEnderecoEmitente.Caption := FCTe.emit.EnderEmit.xLgr + ', ' + FCTe.emit.EnderEmit.nro;
    qrlBairroEmitente.Caption   := FCTe.emit.EnderEmit.xBairro;
    qrlCEPEmitente.Caption      := DFeUtil.FormatarCEP(FormatFloat('00000000', FCTe.emit.EnderEmit.CEP));
    qrlMunEmitente.Caption      := FCTe.emit.EnderEmit.xMun + ' - ' + FCTe.emit.EnderEmit.UF;
    qrlFoneEmitente.Caption     := DFeUtil.FormatarFone(FCTe.emit.enderEmit.fone);
    qrlInscEstEmitente.Caption  := FCTe.emit.IE;
   end;
   *)
end;

procedure TfrmCTeDAInutQRRetrato.qrb_03_InutilizacaoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;

  with FACBrCTe do
    begin
      qrlOrgao.Caption := IntToStr(InutCTe.RetInutCTe.cUF);

      case InutCTe.RetInutCTe.tpAmb of
       taProducao:    qrlTipoAmbiente.Caption := 'PRODU��O';
       taHomologacao: qrlTipoAmbiente.Caption := 'HOMOLOGA��O - SEM VALOR FISCAL';
      end;

      qrlAno.Caption       := IntToStr(InutCTe.RetInutCTe.ano);
      qrlModelo.Caption    := IntToStr(InutCTe.RetInutCTe.Modelo);
      qrlSerie.Caption     := IntToStr(InutCTe.RetInutCTe.Serie);
      qrlNumeracao.Caption := IntToStr(InutCTe.RetInutCTe.nCTIni) + ' a ' +
                              IntToStr(InutCTe.RetInutCTe.nCTFin);

      qrlStatus.Caption    := IntToStr(InutCTe.RetInutCTe.cStat) + ' - ' +
                              InutCTe.RetInutCTe.xMotivo;
      qrlProtocolo.Caption := InutCTe.RetInutCTe.nProt + ' ' +
                              DFeUtil.FormatDateTime(DateTimeToStr(InutCTe.RetInutCTe.dhRecbto));

      qrlJustificativa.Caption := InutCTe.RetInutCTe.xJust;
    end;
end;

procedure TfrmCTeDAInutQRRetrato.qrb_05_NaoUsado_DetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
//  PrintBand := True;
end;

procedure TfrmCTeDAInutQRRetrato.qrb_06_NaoUsado_SummaryBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
//  PrintBand := True;
end;

procedure TfrmCTeDAInutQRRetrato.qrb_07_RodapeBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;

  qrlblSistema.Caption := FSistema + ' - ' + FUsuario;
end;

procedure TfrmCTeDAInutQRRetrato.qrdbtxtValorPrint(sender: TObject;
  var Value: String);
var
  vLength: Integer;
begin
  inherited;
  (*
  vLength := 11 * ((Length(Value) div 90) + 1);

  qrb_08_Correcao_Detalhe.Height := vLength;

  qrdbtxtValor.Height := vLength;
  QRShape11.Height    := vLength;
  QRShape3.Height     := vLength;
  QRShape6.Height     := vLength;
  QRShape4.Height     := vLength;
  *)
end;

end.

