{******************************************************************************}
{ Projeto: Componente ACBrMDFe                                                 }
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

{******************************************************************************
|* Historico
|*
******************************************************************************}

{$I ACBr.inc}

unit ACBrMDFeDAMDFeRLClass;

interface

uses
  Forms, SysUtils, Classes, ACBrMDFeDAMDFeClass, pmdfeMDFe;

type
  TACBrMDFeDAMDFeRL = class(TACBrMDFeDAMDFeClass)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDAMDFe(MDFe: TMDFe = nil); override;
    procedure ImprimirDAMDFePDF(MDFe: TMDFe = nil); override;
    procedure ImprimirEVENTO(MDFe: TMDFe = nil); override;
    procedure ImprimirEVENTOPDF(MDFe: TMDFe = nil); override;
  end;

implementation

uses
  StrUtils, Dialogs, ACBrUtil, ACBrMDFe, ACBrMDFeUtil,
  ACBrMDFeDAMDFeRLRetrato, ACBrMDFeDAEventoRL, ACBrMDFeDAEventoRLRetrato;

var
  frmMDFeDAEventoRL: TfrmMDFeDAEventoRL;

constructor TACBrMDFeDAMDFeRL.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TACBrMDFeDAMDFeRL.Destroy;
begin
  inherited Destroy;
end;

procedure TACBrMDFeDAMDFeRL.ImprimirDAMDFE(MDFe: TMDFe = nil);
var
  i: integer;
  frlDAMDFeRLRetrato: TfrlDAMDFeRLRetrato;
  sProt: string;
begin
  frlDAMDFeRLRetrato := TfrlDAMDFeRLRetrato.Create(Self);
  try
    sProt := TACBrMDFe(ACBrMDFe).DAMDFE.ProtocoloMDFe;
    frlDAMDFeRLRetrato.ProtocoloMDFe(sProt);

    if MDFe = nil then
    begin
      for i := 0 to TACBrMDFe(ACBrMDFe).Manifestos.Count - 1 do
      begin
        frlDAMDFeRLRetrato.Imprimir(TACBrMDFe(ACBrMDFe).Manifestos.Items[i].MDFe
          , Logo
          , Email
          , ExpandirLogoMarca
          , Fax
          , NumCopias
          , Sistema
          , Site
          , Usuario
          , MostrarPreview
          , MargemSuperior
          , MargemInferior
          , MargemEsquerda
          , MargemDireita
          , Impressora
          , MDFeCancelada
          , MDFeEncerrado);
      end;
    end
    else
      frlDAMDFeRLRetrato.Imprimir(MDFe
        , Logo
        , Email
        , ExpandirLogoMarca
        , Fax
        , NumCopias
        , Sistema
        , Site
        , Usuario
        , MostrarPreview
        , MargemSuperior
        , MargemInferior
        , MargemEsquerda
        , MargemDireita
        , Impressora
        , MDFeCancelada
        , MDFeEncerrado);
  finally
    frlDAMDFeRLRetrato.Free;
  end;
end;

procedure TACBrMDFeDAMDFeRL.ImprimirDAMDFEPDF(MDFe: TMDFe = nil);
var
  NomeArq: string;
  i: integer;
  frlDAMDFeRLRetrato: TfrlDAMDFeRLRetrato;
  sProt: string;
begin
  frlDAMDFeRLRetrato := TfrlDAMDFeRLRetrato.Create(Self);
  try
    sProt := TACBrMDFe(ACBrMDFe).DAMDFe.ProtocoloMDFe;
    frlDAMDFeRLRetrato.ProtocoloMDFe(sProt);

    if MDFe = nil then
    begin
      for i := 0 to TACBrMDFe(ACBrMDFe).Manifestos.Count - 1 do
      begin
        NomeArq := StringReplace(TACBrMDFe(ACBrMDFe).Manifestos.Items[i].MDFe.infMDFe.ID, 'MDFe', '', [rfIgnoreCase]);
        NomeArq := PathWithDelim(Self.PathPDF) + NomeArq + '-mdfe.pdf';

        frlDAMDFeRLRetrato.SavePDF(NomeArq
          , TACBrMDFe(ACBrMDFe).Manifestos.Items[i].MDFe
          , Logo
          , Email
          , ExpandirLogoMarca
          , Fax
          , NumCopias
          , Sistema
          , Site
          , Usuario
          , MargemSuperior
          , MargemInferior
          , MargemEsquerda
          , MargemDireita
          , MDFeCancelada
          , MDFeEncerrado);
      end;
    end
    else
    begin
      NomeArq := StringReplace(MDFe.infMDFe.ID, 'MDFe', '', [rfIgnoreCase]);
      NomeArq := PathWithDelim(Self.PathPDF) + NomeArq + '-mdfe.pdf';

      frlDAMDFeRLRetrato.SavePDF(NomeArq
        , MDFe
        , Logo
        , Email
        , ExpandirLogoMarca
        , Fax
        , NumCopias
        , Sistema
        , Site
        , Usuario
        , MargemSuperior
        , MargemInferior
        , MargemEsquerda
        , MargemDireita
        , MDFeCancelada
        , MDFeEncerrado);
    end;
  finally
    frlDAMDFeRLRetrato.Free;
  end;
end;

procedure TACBrMDFeDAMDFeRL.ImprimirEVENTO(MDFe: TMDFe);
var
  i, j: integer;
  Impresso: boolean;
begin
  frmMDFeDAEventoRL := TfrmMDFeDAEventoRLRetrato.Create(Self);
  try
    if TACBrMDFe(ACBrMDFe).Manifestos.Count > 0 then
    begin
      for i := 0 to (TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Count - 1) do
      begin
        Impresso := False;
        for j := 0 to (TACBrMDFe(ACBrMDFe).Manifestos.Count - 1) do
        begin
//          if Copy(TACBrMDFe(ACBrMDFe).Manifestos.Items[j].MDFe.infMDFe.ID, 5, 44) =
//            TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Items[i].InfEvento.chMDFe then
          if StringReplace(TACBrMDFe(ACBrMDFe).Manifestos.Items[j].MDFe.infMDFe.ID, 'MDFe', '', [rfIgnoreCase]) = TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Items[i].InfEvento.chMDFe then
          begin
            frmMDFeDAEventoRL.Imprimir(TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Items[i],
              FLogo,
              FNumCopias,
              FSistema,
              FUsuario,
              FMostrarPreview,
              FMargemSuperior,
              FMargemInferior,
              FMargemEsquerda,
              FMargemDireita,
              FImpressora,
              TACBrMDFe(ACBrMDFe).Manifestos.Items[j].MDFe);
            Impresso := True;
            Break;
          end;
        end;

        if Impresso = False then
        begin
          frmMDFeDAEventoRL.Imprimir(TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Items[i],
            FLogo,
            FNumCopias,
            FSistema,
            FUsuario,
            FMostrarPreview,
            FMargemSuperior,
            FMargemInferior,
            FMargemEsquerda,
            FMargemDireita,
            FImpressora);
        end;
      end;
    end
    else
    begin
      for i := 0 to (TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Count - 1) do
      begin
        frmMDFeDAEventoRL.Imprimir(TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Items[i],
          FLogo,
          FNumCopias,
          FSistema,
          FUsuario,
          FMostrarPreview,
          FMargemSuperior,
          FMargemInferior,
          FMargemEsquerda,
          FMargemDireita,
          FImpressora);
      end;
    end;
  finally
    FreeAndNil(frmMDFeDAEventoRL);
  end;
end;

procedure TACBrMDFeDAMDFeRL.ImprimirEVENTOPDF(MDFe: TMDFe);
var
  i, j: integer;
  sFile: string;
  Impresso: boolean;
begin
  frmMDFeDAEventoRL := TfrmMDFeDAEventoRLRetrato.Create(Self);
  try
    if TACBrMDFe(ACBrMDFe).Manifestos.Count > 0 then
    begin
      for i := 0 to (TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Count - 1) do
      begin
        sFile := TACBrMDFe(ACBrMDFe).DAMDFe.PathPDF +
                 StringReplace(TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Items[i].InfEvento.id, 'ID', '', [rfIgnoreCase]) +
                 '-procEventoMDFe.pdf';
//          Copy(TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Items[i].InfEvento.id, 3, 52) + 'evento.pdf';
        Impresso := False;

        for j := 0 to (TACBrMDFe(ACBrMDFe).Manifestos.Count - 1) do
        begin
//          if Copy(TACBrMDFe(ACBrMDFe).Manifestos.Items[j].MDFe.infMDFe.ID, 5, 44) =
//            TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Items[i].InfEvento.chMDFe then
          if StringReplace(TACBrMDFe(ACBrMDFe).Manifestos.Items[j].MDFe.infMDFe.ID, 'MDFe', '', [rfIgnoreCase]) = TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Items[i].InfEvento.chMDFe then
          begin
            frmMDFeDAEventoRL.SavePDF(TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Items[i],
              FLogo,
              sFile,
              FSistema,
              FUsuario,
              FMargemSuperior,
              FMargemInferior,
              FMargemEsquerda,
              FMargemDireita,
              TACBrMDFe(ACBrMDFe).Manifestos.Items[j].MDFe);
            Impresso := True;
            Break;
          end;
        end;

        if Impresso = False then
        begin
          frmMDFeDAEventoRL.SavePDF(TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Items[i],
            FLogo,
            sFile,
            FSistema,
            FUsuario,
            FMargemSuperior,
            FMargemInferior,
            FMargemEsquerda,
            FMargemDireita);
        end;
      end;
    end
    else
    begin
      for i := 0 to (TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Count - 1) do
      begin
        sFile := TACBrMDFe(ACBrMDFe).DAMDFe.PathPDF +
                 StringReplace(TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Items[i].InfEvento.id, 'ID', '', [rfIgnoreCase]) +
                 '-procEventoMDFe.pdf';
//          Copy(TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Items[i].InfEvento.id, 3, 52) + 'evento.pdf';

        frmMDFeDAEventoRL.SavePDF(TACBrMDFe(ACBrMDFe).EventoMDFe.Evento.Items[i],
          FLogo,
          sFile,
          FSistema,
          FUsuario,
          FMargemSuperior,
          FMargemInferior,
          FMargemEsquerda,
          FMargemDireita);
      end;
    end;
  finally
    FreeAndNil(frmMDFeDAEventoRL);
  end;
end;

end.
