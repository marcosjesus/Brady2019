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

unit ACBrCTeDAInutQR;

// Aten��o todos os comiters
// Quando enviar os fontes referentes ao DAInut favor alterar
// a data e o nome da linha abaixo.
// �ltima libera��o:

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls,
  {$IFDEF QReport_PDF}
     QRPDFFilt, QRPrntr,
  {$ENDIF}
  ACBrCTeQRCodeBar, pcteCTe, ACBrCTe, ACBrCTeUtil, Printers, pcnConversao;

type

  TfrmCTeDAInutQR = class(TForm)
    QRCTeInut: TQuickRep;
    procedure FormDestroy(Sender: TObject);
  private

  protected
    //BarCode : TBarCode128c;
    FACBrCTe        : TACBrCTe;
    FCTe            : TCTe;
    FLogo           : String;
    FNumCopias      : Integer;
    FSistema        : String;
    FUsuario        : String;
    FMostrarPreview : Boolean;
    FMargemSuperior : Double;
    FMargemInferior : Double;
    FMargemEsquerda : Double;
    FMargemDireita  : Double;
    FImpressora     : String;

    procedure SetBarCodeImage(ACode: String; QRImage: TQRImage);
  public
    class procedure Imprimir(AACBrCTe: TACBrCTe;
                             ALogo: String = '';
                             ANumCopias: Integer = 1;
                             ASistema: String = '';
                             AUsuario: String = '';
                             AMostrarPreview: Boolean = True;
                             AMargemSuperior: Double = 0.7;
                             AMargemInferior: Double = 0.7;
                             AMargemEsquerda: Double = 0.7;
                             AMargemDireita: Double = 0.7;
                             AImpressora: String = '';
                             ACTe: TCTe = nil);

    class procedure SavePDF(AACBrCTe: TACBrCTe;
                            ALogo: String = '';
                            AFile: String = '';
                            ASistema: String = '';
                            AUsuario: String = '';
                            AMargemSuperior: Double = 0.7;
                            AMargemInferior: Double = 0.7;
                            AMargemEsquerda: Double = 0.7;
                            AMargemDireita: Double = 0.7;
                            ACTe: TCTe = nil);
  end;

implementation

uses
  MaskUtils;

var
  Printer: TPrinter;

{$R *.dfm}

class procedure TfrmCTeDAInutQR.Imprimir(AACBrCTe: TACBrCTe;
                                         ALogo: String = '';
                                         ANumCopias: Integer = 1;
                                         ASistema: String = '';
                                         AUsuario: String = '';
                                         AMostrarPreview: Boolean = True;
                                         AMargemSuperior: Double = 0.7;
                                         AMargemInferior: Double = 0.7;
                                         AMargemEsquerda: Double = 0.7;
                                         AMargemDireita: Double = 0.7;
                                         AImpressora: String = '';
                                         ACTe: TCTe = nil);
begin
  with Create(nil) do
     try
        FACBrCTe        := AACBrCTe;
        FLogo           := ALogo;
        FNumCopias      := ANumCopias;
        FSistema        := ASistema;
        FUsuario        := AUsuario;
        FMostrarPreview := AMostrarPreview;
        FMargemSuperior := AMargemSuperior;
        FMargemInferior := AMargemInferior;
        FMargemEsquerda := AMargemEsquerda;
        FMargemDireita  := AMargemDireita;
        FImpressora     := AImpressora;

        if ACTe <> nil then
         FCTe := ACTe;

        Printer := TPrinter.Create;

        if FImpressora > '' then
          QRCTeInut.PrinterSettings.PrinterIndex := Printer.Printers.IndexOf(FImpressora);

        if AMostrarPreview then
         begin
           QRCTeInut.PrinterSettings.Copies := FNumCopias;

         {$IFDEF QReport_PDF}
           QRCTeInut.PrevShowSearch      := False;
           QRCTeInut.PrevShowThumbs      := False;
           QRCTeInut.PreviewInitialState := wsMaximized;
           QRCTeInut.PrevInitialZoom     := qrZoomToWidth;

           QRExportFilterLibrary.AddFilter(TQRPDFDocumentFilter);
         {$ENDIF}

           QRCTeInut.Prepare;
           QRCTeInut.Preview;
           Application.ProcessMessages;
         end else
         begin
           FMostrarPreview := True;
           QRCTeInut.PrinterSettings.Copies := FNumCopias;
           QRCTeInut.Prepare;
           QRCTeInut.Print;
         end;
     finally
        QRCTeInut.Free;
        QRCTeInut := nil;
        Printer.Free;
        Free;
     end;
end;

class procedure TfrmCTeDAInutQR.SavePDF(AACBrCTe: TACBrCTe;
                                        ALogo: String = '';
                                        AFile: String = '';
                                        ASistema: String = '';
                                        AUsuario: String = '';
                                        AMargemSuperior: Double = 0.7;
                                        AMargemInferior: Double = 0.7;
                                        AMargemEsquerda: Double = 0.7;
                                        AMargemDireita: Double = 0.7;
                                        ACTe: TCTe = nil);
{$IFDEF QReport_PDF}
var
  qf: TQRPDFDocumentFilter;
  i: Integer;
{$ENDIF}
begin
{$IFDEF QReport_PDF}
  with Create ( nil ) do
     try
        FACBrCTe        := AACBrCTe;
        FLogo           := ALogo;
        FSistema        := ASistema;
        FUsuario        := AUsuario;
        FMargemSuperior := AMargemSuperior;
        FMargemInferior := AMargemInferior;
        FMargemEsquerda := AMargemEsquerda;
        FMargemDireita  := AMargemDireita;

        if ACTe <> nil then
          FCTe := ACTe;

        for i := 0 to ComponentCount -1 do
          begin
            if (Components[i] is TQRShape) and (TQRShape(Components[i]).Shape = qrsRoundRect) then
              begin
                TQRShape(Components[i]).Shape := qrsRectangle;
                TQRShape(Components[i]).Pen.Width := 1;
              end;
          end;

        FMostrarPreview := True;
        QRCTeInut.Prepare;

        qf := TQRPDFDocumentFilter.Create(AFile);
        try
          qf.CompressionOn := False;
          QRCTeInut.QRPrinter.ExportToFilter(qf);
        finally
          qf.Free;
        end;
     finally
        Free;
     end;
{$ENDIF}
end;

procedure TfrmCTeDAInutQR.SetBarCodeImage(ACode: String; QRImage: TQRImage);
var
  b: TBarCode128c;
begin
  b := TBarCode128c.Create;
  try
    //      Width  := QRImage.Width;
    b.Code := ACode;
    b.PaintCodeToCanvas(ACode, QRImage.Canvas, QRImage.ClientRect);
  finally
    b.free;
  end;
end;

procedure TfrmCTeDAInutQR.FormDestroy(Sender: TObject);
begin
  QRCTeInut.QRPrinter.Free;
  QRCTeInut.Free;
end;

end.

