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
|* 16/12/2008: Wemerson Souto
|*  - Doa��o do componente para o Projeto ACBr
|* 20/08/2009: Caique Rodrigues
|*  - Doa��o units para gera��o do DACTe via QuickReport
|* 06/04/2010: Italo Jurisato Junior
|*  - Acr�scimo dos par�metros "FEmail", "FResumoCanhoto", "FFax", "FNumCopias",
|*    "FSistema", "FUsuario", "FImprimeHoraSaida", "FHoraSaida",
|*    "FMargemSuperior", "FMargemInferior", "FMargemEsquerda", "FMargemDireita",
|*    nas Class procedures "Imprimir" e "SavePDF"
|*  - Habilitada a funcionalidade da procedure "SavePDF";
|* 15/02/2012: Italo Jurisato Junior
*******************************************************************************}

{$I ACBr.inc}

unit ACBrCTeDACTeQR;

// Aten��o todos os comiters
// Quando enviar os fontes referentes ao DACTE favor alterar
// a data e o nome da linha abaixo.
// �ltima libera��o:
// 27/08/2013 por Italo Jurisato Junior
// 21/08/2013 por Italo Jurisato Junior
// 06/08/2013 por Italo Jurisato Junior
// 28/01/2014 por Italo Jurisato Junior

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls,
  {$IFDEF QReport_PDF}
     QRPDFFilt, QRPrntr,
  {$ENDIF}
  ACBrCTeQRCodeBar, pcteCTe, ACBrCTe, ACBrCTeUtil, Printers, pcnConversao;

type

  TfrmDACTeQR = class(TForm)
    QRCTe: TQuickRep;
    procedure FormDestroy(Sender: TObject);
  private

  protected
    //BarCode : TBarCode128c;
    FACBrCTe            : TACBrCTe;
    FCTe                : TCTe;
    FLogo               : String;
    FEmail              : String;
    FImprimeHoraSaida   : Boolean;
    FHoraSaida          : String;
    FResumoCanhoto      : Boolean;
    FFax                : String;
    FNumCopias          : Integer;
    FSistema            : String;
    FUrl                : String;
    FUsuario            : String;
    AfterPreview        : Boolean;
    FExpandirLogoMarca  : Boolean;
    ChangedPos          : Boolean;
    FSemValorFiscal     : Boolean;
    FMargemSuperior     : Double;
    FMargemInferior     : Double;
    FMargemEsquerda     : Double;
    FMargemDireita      : Double;
    FImpressora         : String;
    FPosRecibo          : TPosRecibo;
    FCTeCancelada       : Boolean;
    FTotalPages         : Integer;
    FEPECEnviado        : Boolean;

    procedure qrlSemValorFiscalPrint(sender: TObject; var Value: String);
    procedure SetBarCodeImage(ACode: String; QRImage: TQRImage);
    function getTextoResumoCanhoto:String;
  public
    class procedure Imprimir(ACTe               : TCTe;
                             ALogo              : String    = '';
                             AEmail             : String    = '';
                             AImprimeHoraSaida  : Boolean   = False;
                             AExpandirLogoMarca : Boolean   = False;
                             AHoraSaida         : String    = '';
                             AResumoCanhoto     : Boolean   = False;
                             AFax               : String    = '';
                             ANumCopias         : Integer   = 1;
                             ASistema           : String    = '';
                             AUrl               : String    = '';
                             AUsuario           : String    = '';
                             APreview           : Boolean   = True;
                             AMargemSuperior    : Double    = 0.8;
                             AMargemInferior    : Double    = 0.8;
                             AMargemEsquerda    : Double    = 0.6;
                             AMargemDireita     : Double    = 0.51;
                             AImpressora        : String    = '';
                             APosRecibo         : TPosRecibo = prCabecalho;
                             ACTeCancelada      : Boolean   = False;
                             AEPECEnviado       : Boolean   = False);

    class procedure SavePDF(AFile              : String;
                            ACTe               : TCTe;
                            ALogo              : String    = '';
                            AEmail             : String    = '';
                            AImprimeHoraSaida  : Boolean   = False;
                            AExpandirLogoMarca : Boolean   = False;
                            AHoraSaida         : String    = '';
                            AResumoCanhoto     : Boolean   = False;
                            AFax               : String    = '';
                            ANumCopias         : Integer   = 1;
                            ASistema           : String    = '';
                            AUrl               : String    = '';
                            AUsuario           : String    = '';
                            AMargemSuperior    : Double    = 0.8;
                            AMargemInferior    : Double    = 0.8;
                            AMargemEsquerda    : Double    = 0.6;
                            AMargemDireita     : Double    = 0.51;
                            APosRecibo         : TPosRecibo = prCabecalho;
                            ACTeCancelada      : Boolean   = False;
                            AEPECEnviado       : Boolean   = False);

  end;

implementation

uses
  MaskUtils, ACBrDFeUtil;

var
  Printer: TPrinter;

{$R *.dfm}

class procedure TfrmDACTeQR.Imprimir(ACTe               : TCTe;
                                     ALogo              : String    = '';
                                     AEmail             : String    = '';
                                     AImprimeHoraSaida  : Boolean   = False;
                                     AExpandirLogoMarca : Boolean   = False;
                                     AHoraSaida         : String    = '';
                                     AResumoCanhoto     : Boolean   = False;
                                     AFax               : String    = '';
                                     ANumCopias         : Integer   = 1;
                                     ASistema           : String    = '';
                                     AUrl               : String    = '';
                                     AUsuario           : String    = '';
                                     APreview           : Boolean   = True;
                                     AMargemSuperior    : Double    = 0.8;
                                     AMargemInferior    : Double    = 0.8;
                                     AMargemEsquerda    : Double    = 0.6;
                                     AMargemDireita     : Double    = 0.51;
                                     AImpressora        : String    = '';
                                     APosRecibo         : TPosRecibo = prCabecalho;
                                     ACTeCancelada      : Boolean   = False;
                                     AEPECEnviado       : Boolean   = False);
begin
  with Create(nil) do
     try
        FCTe               := ACTe;
        FLogo              := ALogo;
        FEmail             := AEmail;
        FImprimeHoraSaida  := AImprimeHoraSaida;
        FExpandirLogoMarca := AExpandirLogoMarca;
        FHoraSaida         := AHoraSaida;
        FResumoCanhoto     := AResumoCanhoto;
        FFax               := AFax;
        FNumCopias         := ANumCopias;
        FSistema           := ASistema;
        FUrl               := AUrl;
        FUsuario           := AUsuario;
        FMargemSuperior    := AMargemSuperior;
        FMargemInferior    := AMargemInferior;
        FMargemEsquerda    := AMargemEsquerda;
        FMargemDireita     := AMargemDireita;
        FImpressora        := AImpressora;
        FPosRecibo         := APosRecibo;
        FCTeCancelada      := ACTeCancelada;
        FEPECEnviado       := AEPECEnviado;

        Printer := TPrinter.Create;

        if FImpressora > '' then
          QRCTe.PrinterSettings.PrinterIndex := Printer.Printers.IndexOf(FImpressora);

        if APreview then
         begin
           QRCTe.PrinterSettings.Copies := FNumCopias;

         {$IFDEF QReport_PDF}
           QRCTe.PrevShowSearch      := False;
           QRCTe.PrevShowThumbs      := False;
           QRCTe.PreviewInitialState := wsMaximized;
           QRCTe.PrevInitialZoom     := qrZoomToWidth;

           QRExportFilterLibrary.AddFilter(TQRPDFDocumentFilter);
         {$ENDIF}

           QRCTe.Prepare;
           FTotalPages := QRCTe.QRPrinter.PageCount;
           QRCTe.Preview;

           Application.ProcessMessages;
         end else
         begin
           AfterPreview := True;
           QRCTe.PrinterSettings.Copies := FNumCopias;
           QRCTe.Prepare;
           FTotalPages := QRCTe.QRPrinter.PageCount;
           QRCTe.Print;
         end;
     finally
        QRCTe.Free;
        QRCTe := nil;
        Printer.Free;
        Free;
     end;
end;

class procedure TfrmDACTeQR.SavePDF(AFile              : String;
                                    ACTe               : TCTe;
                                    ALogo              : String    = '';
                                    AEmail             : String    = '';
                                    AImprimeHoraSaida  : Boolean   = False;
                                    AExpandirLogoMarca : Boolean   = False;
                                    AHoraSaida         : String    = '';
                                    AResumoCanhoto     : Boolean   = False;
                                    AFax               : String    = '';
                                    ANumCopias         : Integer   = 1;
                                    ASistema           : String    = '';
                                    AUrl               : String    = '';
                                    AUsuario           : String    = '';
                                    AMargemSuperior    : Double    = 0.8;
                                    AMargemInferior    : Double    = 0.8;
                                    AMargemEsquerda    : Double    = 0.6;
                                    AMargemDireita     : Double    = 0.51;
                                    APosRecibo         : TPosRecibo = prCabecalho;
                                    ACTeCancelada      : Boolean   = False;
                                    AEPECEnviado       : Boolean   = False);
{$IFDEF QReport_PDF}
var
  qf: TQRPDFDocumentFilter;
  i: Integer;
{$ENDIF}
begin
{$IFDEF QReport_PDF}
  with Create(nil) do
     try
        FCTe               := ACTe;
        FLogo              := ALogo;
        FEmail             := AEmail;
        FImprimeHoraSaida  := AImprimeHoraSaida;
        FHoraSaida         := AHoraSaida;
        FResumoCanhoto     := AResumoCanhoto;
        FFax               := AFax;
        FNumCopias         := ANumCopias;
        FSistema           := ASistema;
        FUrl               := AUrl;
        FUsuario           := AUsuario;
        FMargemSuperior    := AMargemSuperior;
        FMargemInferior    := AMargemInferior;
        FMargemEsquerda    := AMargemEsquerda;
        FMargemDireita     := AMargemDireita;
        FExpandirLogoMarca := AExpandirLogoMarca;
        FPosRecibo         := APosRecibo;
        FCTeCancelada      := ACTeCancelada;
        FEPECEnviado       := AEPECEnviado;

        for i := 0 to ComponentCount -1 do
          begin
            if (Components[i] is TQRShape) and (TQRShape(Components[i]).Shape = qrsRoundRect) then
              begin
                TQRShape(Components[i]).Shape := qrsRectangle;
                TQRShape(Components[i]).Pen.Width := 1;
              end;
          end;
        AfterPreview := True;
        QRCTe.Prepare;
        FTotalPages := QRCTe.QRPrinter.PageCount;

        qf := TQRPDFDocumentFilter.Create(AFile);
        try
          qf.CompressionOn := False;
          QRCTe.QRPrinter.ExportToFilter(qf);
        finally
          qf.Free;
        end;
     finally
        // Incluido por Italo em 13/05/2014
        QRCTe.Free;
        QRCTe := nil;
        Free;    // removido o comentado por Italo em 07/03/2014
     end;
{$ENDIF}
end;

procedure TfrmDACTeQR.qrlSemValorFiscalPrint(sender: TObject;  var Value: String);
begin
  inherited;

  if FSemValorFiscal then
    Value := '';
end;

procedure TfrmDACTeQR.SetBarCodeImage(ACode: String; QRImage: TQRImage);
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

procedure TfrmDACTeQR.FormDestroy(Sender: TObject);
begin
  QRCTe.QRPrinter.Free;
  QRCTe.Free;
end;

function TfrmDACTeQR.getTextoResumoCanhoto: String;
begin
  Result := 'EMIT: ' + FCTe.Emit.xNome + ' - ' +
            'EMISS�O: ' + FormatDateTime('DD/MM/YYYY',FCTe.Ide.dhEmi) + '  -  TOMADOR: ';

  if FCTe.Ide.Toma4.xNome = ''
  then begin
    case FCTe.Ide.Toma03.Toma of
      tmRemetente:    Result := Result + FCTe.Rem.xNome;
    	tmExpedidor:    Result := Result + FCTe.Exped.xNome;
      tmRecebedor:    Result := Result + FCTe.Receb.xNome;
    	tmDestinatario: Result := Result + FCTe.Dest.xNome;
    end
  end
  else
    Result := Result + FCTe.Ide.Toma4.xNome;

  Result := Result + ' - VALOR A RECEBER: R$ ' + DFeUtil.FormatFloat(FCTe.vPrest.vRec, '###,###,###,##0.00');
end;

end.

