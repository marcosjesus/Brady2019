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

unit ACBrMDFeDAEventoRL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RLReport, RLPDFFilter, pmdfeMDFe, ACBrMDFe, ACBrMDFeUtil,
  RLPrinters, pcnConversao, pmdfeEnvEventoMDFe
  {$IFDEF BORLAND} , DB, DBClient {$ELSE}, BufDataset, DB {$ENDIF} ;

type

  { TfrmMDFeDAEventoRL }

  TfrmMDFeDAEventoRL = class(TForm)
    Datasource1: TDatasource;
    RLMDFeEvento: TRLReport;
    RLPDFFilter1: TRLPDFFilter;
    procedure FormDestroy(Sender: TObject);
  private
    cdsDocumentos: {$IFDEF BORLAND}TClientDataSet{$ELSE}TBufDataset{$ENDIF};
  protected
    FACBrMDFe: TACBrMDFe;
    FMDFe: TMDFe;
    FEventoMDFe: TInfEventoCollectionItem;
    FLogo: string;
    FNumCopias: integer;
    FSistema: string;
    FUsuario: string;
    FMostrarPreview: boolean;
    FMargemSuperior: double;
    FMargemInferior: double;
    FMargemEsquerda: double;
    FMargemDireita: double;
    FImpressora: string;

  public
    class procedure Imprimir(AEventoMDFe: TInfEventoCollectionItem; ALogo: string = '';
      ANumCopias: integer = 1; ASistema: string = '';
      AUsuario: string = ''; AMostrarPreview: boolean = True;
      AMargemSuperior: double = 0.7; AMargemInferior: double = 0.7;
      AMargemEsquerda: double = 0.7; AMargemDireita: double = 0.7;
      AImpressora: string = ''; AMDFe: TMDFe = nil);

    class procedure SavePDF(AEventoMDFe: TInfEventoCollectionItem; ALogo: string = '';
      AFile: string = ''; ASistema: string = '';
      AUsuario: string = ''; AMargemSuperior: double = 0.7;
      AMargemInferior: double = 0.7; AMargemEsquerda: double = 0.7;
      AMargemDireita: double = 0.7; AMDFe: TMDFe = nil);
  end;

implementation

uses
  MaskUtils;

{$R *.dfm}

class procedure TfrmMDFeDAEventorl.Imprimir(AEventoMDFe: TInfEventoCollectionItem;
  ALogo: string = '';
  ANumCopias: integer = 1;
  ASistema: string = '';
  AUsuario: string = '';
  AMostrarPreview: boolean = True;
  AMargemSuperior: double = 0.7;
  AMargemInferior: double = 0.7;
  AMargemEsquerda: double = 0.7;
  AMargemDireita: double = 0.7;
  AImpressora: string = '';
  AMDFe: TMDFe = nil);
begin
  with Create ( nil ) do
  //with TfrmMDFeDAEventoRL do
    try
      FEventoMDFe := AEventoMDFe;
      FLogo := ALogo;
      FNumCopias := ANumCopias;
      FSistema := ASistema;
      FUsuario := AUsuario;
      FMostrarPreview := AMostrarPreview;
      FMargemSuperior := AMargemSuperior;
      FMargemInferior := AMargemInferior;
      FMargemEsquerda := AMargemEsquerda;
      FMargemDireita := AMargemDireita;
      FImpressora := AImpressora;

      if AMDFe <> nil then
        FMDFe := AMDFe;

      if FImpressora > '' then
        RLPrinter.PrinterName := FImpressora;

      if FNumCopias > 0 then
        RLPrinter.Copies := FNumCopias
      else
        RLPrinter.Copies := 1;

      //if APreview = True then
        //RLMDFe.PreviewModal
      //else
        RLMDFeEvento.Print;
    finally
      RLMDFeEvento.Free;
      RLMDFeEvento := nil;
      Free;
    end;
end;

class procedure TfrmMDFeDAEventorl.SavePDF(AEventoMDFe: TInfEventoCollectionItem;
  ALogo: string = ''; AFile: string = '';
  ASistema: string = '';
  AUsuario: string = '';
  AMargemSuperior: double = 0.7;
  AMargemInferior: double = 0.7;
  AMargemEsquerda: double = 0.7;
  AMargemDireita: double = 0.7;
  AMDFe: TMDFe = nil);
begin
  with Create(nil) do
    //with TfrmMDFeDAEventoRL do
    try
      FEventoMDFe := AEventoMDFe;
      FLogo := ALogo;
      FSistema := ASistema;
      FUsuario := AUsuario;
      FMargemSuperior := AMargemSuperior;
      FMargemInferior := AMargemInferior;
      FMargemEsquerda := AMargemEsquerda;
      FMargemDireita := AMargemDireita;

      if AMDFe <> nil then
        FMDFe := AMDFe;

      with RLPDFFilter1.DocumentInfo do
      begin
        Title := 'DAMDFe EVENTO - MDFe n� ' +
          FormatFloat('000,000,000', FMDFe.Ide.nMDF);
        KeyWords := 'N�mero:' + FormatFloat('000,000,000', FMDFe.Ide.nMDF) +
          '; Data de emiss�o: ' + FormatDateTime('dd/mm/yyyy', FMDFe.Ide.dhEmi) +
          '; CNPJ: ' + FMDFe.emit.CNPJ;
      end;

      RLMDFeEvento.SaveToFile(AFile);
    finally
      Free;
    end;

end;

procedure TfrmMDFeDAEventorl.FormDestroy(Sender: TObject);
begin
  RLMDFeEvento.Free;
end;

end.













