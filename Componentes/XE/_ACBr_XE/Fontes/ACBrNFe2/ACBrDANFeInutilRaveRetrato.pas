{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Nota Fiscal}
{ eletr�nica - NFe - http://www.nfe.fazenda.gov.br                          }
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

{******************************************************************************
|* Historico
|*
|* 06/08/2014: Jo�o Paulo da Silva Le�o
|*  - Impress�o do comprovante de Inutiliza��o da Numera��o
|*  - Adapta��o da rotina de impress�o de evento, para esta utilidade
******************************************************************************}
{$I ACBr.inc}

unit ACBrDANFeInutilRaveRetrato;

interface

uses Graphics, Forms, Windows, SysUtils, Classes,
     Variants, Math, StdCtrls, DB, Dialogs,
     Controls, ExtCtrls, Mask, MaskUtils,
     {$IFNDEF COMPILER16} JPEG, {$ELSE} Vcl.Imaging.jpeg, {$ENDIF}
     RpDefine, RpBase, RpSystem, RpBars, RpMemo,
     RpRenderText, RpRenderRTF, RpRenderHTML, RpRender, RpRenderPDF,
     ACBrNFe, pcnConversao, ACBrDANFeCBRave, ACBrNFeUtil, ACBrDFeUtil;

const aHeigthPadrao:Double=5.8;

procedure ImprimirInutilRetrato(aRaveSystem:TInutilizacaoRave);

implementation

uses pcnInutNFe;

procedure ImprimirInutilRetrato(aRaveSystem:TInutilizacaoRave);
var
 PosX, PosY, PosBarra : Double;
 aWidth, CenterX, YY : Double;
 FMemo : TMemoBuf;
begin
  InutilizacaoRave:=aRaveSystem;

  // marca d'agua de homologa��o ***********************************************
  with InutilizacaoRave, InutilizacaoRave.BaseReport, InutilizacaoRave.ACBrNFe.InutNFe.InutNFe do
  begin
    if ( tpAmb = taHomologacao ) then
     begin
        YY :=FLastY-15;
        SetFont(FontNameUsed,25);
        FontColor:=clSilver;
        Bold:=True;
        Underline:=True;
        GotoXY(FFirstX+5,YY);
        FontRotation:=30;
        Print('AMBIENTE DE HOMOLOGA��O - SEM VALOR FISCAL');
     end;

     PosX := 10;
     PosY := 10;
     aWidth := 190;

     Box([],PosX,PosY,aWidth,18,'');
     SetFont(FontNameUsed,12);
     CenterX:=PosX+(aWidth/2);
     NewLine;
     Bold:=True;
     PrintCenter('INUTILIZA��O DE NUMERA��O DA NF-e',CenterX);
     SetFont(FontNameUsed,10);
     NewLine;
     Bold:=False;
     PrintCenter('N�o possui valor fiscal, simples representa��o do fato indicado abaixo.',CenterX);
     NewLine;
     PrintCenter('CONSULTE A AUTENTICIDADE NO SITE DA SEFAZ AUTORIZADORA.',CenterX);
     NewLine;
     NewLine;
     PosY := YPos + 2;
     PosX := 10;
     SetFont(FontNameUsed,10);
     Box([],PosX,PosY, 12,aHeigthPadrao,'MODELO', IntToStr(modelo) ,taCenter);
     Box([],XPos,YPos, 12,aHeigthPadrao,'S�RIE', IntToStr(serie),taCenter);
     Box([],XPos,YPos, 43,aHeigthPadrao,'N�MERA��O',IntToStr(nNFIni)+' a '+IntToStr(nNFFin),taCenter);
     Box([],XPos,YPos, 43,aHeigthPadrao,'ANO',IntToStr(ano),taCenter);

     PosBarra := XPos+41;
     Box([],XPos,PosY, 80,aHeigthPadrao*2) ;
     with TRPBarsCode128.Create(InutilizacaoRave.BaseReport) do
      begin
        BaseReport:=InutilizacaoRave.BaseReport;
        CodePage:=cpCodeC;
        BarCodeJustify:=pjCenter;
        UseChecksum:=false;
        BarWidth:=0.254;
        BarHeight:=10.0;
        WideFactor:=BarWidth;
        PrintReadable:=False;
        Text:=DFeUtil.LimpaNumero(nProt);
        PrintXY(PosBarra,PosY+1);
        Free;
     end;

     PosY := YPos + aHeigthPadrao;
     PosX := 10;
     if (tpAmb = taProducao) then
        Box([],PosX,PosY,109.8,aHeigthPadrao,'AMBIENTE','PRODU��O',taLeftJustify)
       else
        Box([],PosX,PosY,109.8,aHeigthPadrao,'AMBIENTE','HOMOLOGA��O - SEM VALOR FISCAL',taLeftJustify);
     //NewLine;
     //NewLine;
     //PosY := YPos + 2;
     SetFont(FontNameUsed,10);
     PosY := YPos + aHeigthPadrao;
     Box([],PosX,PosY,110,aHeigthPadrao,'STATUS', IntToStr(cStat)+' - '+xMotivo,taLeftJustify);
     Box([],XPos,YPos, 38,aHeigthPadrao,'PROTOCOLO', nProt,taLeftJustify);
     Box([],XPos,YPos, 42,aHeigthPadrao,'DATA E HOR�RIO DO REGISTRO',DateTimeToStr(dhRecbto),taRightJustify);
     PosY := YPos + aHeigthPadrao;
     Box([],PosX,PosY,190,aHeigthPadrao,'JUSTIFICATIVA', xJust,taLeftJustify);

     SetFontTitle;
     PrintXY(PosX,FLastY,'DATA E HORA DA IMPRESS�O: '+FormatDateTime('dd/mm/yyyy hh:mm:ss',Now)+DFeUtil.SeSenao((Trim(NomeDoUsuario)<>''),' - '+NomeDoUsuario,''));
     if Trim(NomeDoERP)>'' then
      begin
        PrintRight('Desenvolvido por '+NomeDoERP,FLastX-5);
      end;
  end;

end;


end.

