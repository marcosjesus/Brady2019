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
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 04/04/2013:  Andr� Ferreira de Moraes
|*   Inicio do desenvolvimento
******************************************************************************}
{$I ACBr.inc}

unit ACBrSATExtratoESCPOS;

interface

uses Classes, SysUtils,
	 {$IFDEF FPC}
       LResources,
     {$ENDIF} 
     ACBrSATExtratoClass, ACBrDevice, ACBrUtil,
     pcnCFe, pcnCFeCanc, pcnConversao, ACBrDFeUtil;

const
      cCmdImpZera = #27+'@';
      cCmdEspacoLinha = #27+'3'+#14;
      cCmdPagCod = #27+'t'+#39;
      cCmdImpNegrito = #27+'E1';
      cCmdImpFimNegrito = #27+'E2';
      cCmdImpExpandido = #29+'!'+#16;
      cCmdImpFimExpandido = #29+'!'+#0;
      cCmdFonteNormal = #27+'M0';
      cCmdFontePequena = #27+'M1';
      cCmdAlinhadoEsquerda = #27+'a0';
      cCmdAlinhadoCentro = #27+'a1';
      cCmdAlinhadoDireita = #27+'a2';
      cCmdCortaPapel = #29+'V1';      

type

   TACBrSATMarcaImpressora = (iEpson, iBematech);

  { TACBrSATExtratoESCPOS }
  TACBrSATExtratoESCPOS = class( TACBrSATExtratoClass )
  private
    FDevice : TACBrDevice ;
    FMarcaImpressora: TACBrSATMarcaImpressora;
    FLinhasEntreCupons : Integer ;
    FLinhaCmd : String;
    FBuffer : TStringList;
    FLinhasEntItens        : Integer;
    FLinhasEntTotais       : Integer;
    FLinhasEntPagamentos   : Integer;
    FLinhasEntDadosEntrega : Integer;
    FLinhasEntRodape       : Integer;
    FImprimirLei12741      : Boolean;
    procedure ImprimePorta( AString : AnsiString ) ;
  protected
    procedure GerarCabecalho;
    procedure GerarItens;
    procedure GerarTotais(Resumido : Boolean = False);
    procedure GerarPagamentos(Resumido : Boolean = False );
    procedure GerarObsFisco;
    procedure GerarDadosEntrega;
    procedure GerarObsContribuinte(Resumido : Boolean = False );
    procedure GerarRodape(CortaPapel: Boolean = True; Cancelamento: Boolean = False);
    procedure GerarDadosCancelamento;
    procedure PulaLinhas( NumLinhas : Integer = 0 );
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ImprimirExtrato(ACFe : TCFe = nil); override;
    procedure ImprimirExtratoResumido(ACFe : TCFe = nil); override;
    procedure ImprimirExtratoCancelamento(ACFe : TCFe = nil; ACFeCanc: TCFeCanc = nil); override;
  published
    property Device                : TACBrDevice read FDevice ;
    property MarcaImpressora       : TACBrSATMarcaImpressora read FMarcaImpressora write FMarcaImpressora default iEpson ;
    property LinhasEntreCupons     : Integer read FLinhasEntreCupons write FLinhasEntreCupons default 16 ;
    property LinhasEntItens        : Integer read FLinhasEntItens write FLinhasEntItens default 0;
    property LinhasEntTotais       : Integer read FLinhasEntTotais write FLinhasEntTotais default 0;
    property LinhasEntPagamentos   : Integer read FLinhasEntPagamentos write FLinhasEntPagamentos default 0;
    property LinhasEntDadosEntrega : Integer read FLinhasEntDadosEntrega write FLinhasEntDadosEntrega default 0;  
    property LinhasEntRodape       : Integer read FLinhasEntRodape write FLinhasEntRodape default 0;
    property ImprimirLei12741      : Boolean read FImprimirLei12741 write FImprimirLei12741 default True;
  end ;

procedure Register;

implementation

uses ACBrSAT;

{$IFNDEF FPC}
   {$R ACBrSATExtratoESCPOS.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr',[TACBrSATExtratoESCPOS]);
end;

function Int2TB(AInteger: Integer): AnsiString;
var
   AHexStr: String;
begin
  AHexStr := IntToHex(AInteger,4);
  Result  := AnsiChar(chr( StrToInt('$'+copy(AHexStr,3,2) ) )) +
             AnsiChar(chr( StrToInt('$'+copy(AHexStr,1,2) ) )) ;
  AHexStr := Result;
end;

{ TACBrSATExtratoESCPOS }

constructor TACBrSATExtratoESCPOS.Create(AOwner: TComponent);
begin
  inherited create( AOwner );

  { Instanciando SubComponente TACBrDevice }
  FDevice := TACBrDevice.Create( self ) ;  { O dono � o proprio componente }
  FDevice.Name := 'ACBrDevice' ;      { Apenas para aparecer no Object Inspector}
  {$IFDEF COMPILER6_UP}
  FDevice.SetSubComponent( true );{ para gravar no DFM/XFM }
  {$ENDIF}
  FDevice.SetDefaultValues ;
  FDevice.Porta := 'COM1';

  FBuffer := TStringList.Create;
  FMarcaImpressora := iEpson;
  FLinhasEntreCupons := 16;
end;

destructor TACBrSATExtratoESCPOS.Destroy;
begin
  FBuffer.Free;

  FreeAndNil( FDevice ) ;
  
  inherited Destroy ;
end;

procedure TACBrSATExtratoESCPOS.GerarCabecalho;
begin
  FLinhaCmd := cCmdImpZera+cCmdEspacoLinha+cCmdPagCod+cCmdFonteNormal+cCmdAlinhadoCentro;
  FBuffer.clear;
  FBuffer.Add(FLinhaCmd+chr(29)+'(L'+chr(6)+chr(0)+'0E  '+chr(1)+chr(1)); // Imprimindo logo j� gravado na mem�ria

  FLinhaCmd := cCmdAlinhadoCentro+cCmdImpNegrito+CFe.Emit.xFant+cCmdImpFimNegrito;
  FBuffer.Add(FLinhaCmd);
  FBuffer.Add(cCmdFontePequena+CFe.Emit.xNome);
  FBuffer.Add(cCmdFontePequena+Trim(CFe.Emit.EnderEmit.xLgr)+' '+
              Trim(CFe.Emit.EnderEmit.nro)+' '+
              Trim(CFe.Emit.EnderEmit.xCpl)+' '+
              Trim(CFe.Emit.EnderEmit.xBairro)+'-'+
              Trim(CFe.Emit.EnderEmit.xMun)+'-'+
              DFeUtil.FormatarCEP(IntToStr(CFe.Emit.EnderEmit.CEP)));

  FLinhaCmd := cCmdAlinhadoEsquerda+cCmdFontePequena+
              'CNPJ:'+DFeUtil.FormatarCNPJ(CFe.Emit.CNPJCPF)+
              ' IE:'+Trim(CFe.Emit.IE)+
              ' IM:'+Trim(CFe.Emit.IM);
  FBuffer.Add(FLinhaCmd);
  FBuffer.Add(cCmdAlinhadoEsquerda+cCmdFonteNormal+'------------------------------------------------');


  if CFe.ide.tpAmb = taHomologacao then
  begin
    FLinhaCmd := cCmdFonteNormal+cCmdAlinhadoCentro+cCmdImpNegrito+
                'Extrato No. 000000';
    FBuffer.Add(FLinhaCmd);
    FLinhaCmd := 'CUPOM FISCAL ELETR�NICO - SAT'+cCmdImpFimNegrito;
    FBuffer.Add(FLinhaCmd);
    FBuffer.Add(' ');
    FBuffer.Add(padC(' = T E S T E =',48));
    FBuffer.Add(' ');
    FBuffer.Add(padC('>',48,'>'));
    FBuffer.Add(padC('>',48,'>'));
    FBuffer.Add(padC('>',48,'>'));
  end
  else
  begin
    FLinhaCmd := cCmdFonteNormal+cCmdAlinhadoCentro+cCmdImpNegrito+
                'Extrato No. '+IntToStrZero(CFe.ide.nCFe,6);
    FBuffer.Add(FLinhaCmd);
    FLinhaCmd := 'CUPOM FISCAL ELETR�NICO - SAT'+cCmdImpFimNegrito;
    FBuffer.Add(FLinhaCmd);
  end;

  FBuffer.Add('------------------------------------------------');
  FBuffer.Add(cCmdAlinhadoEsquerda+cCmdFontePequena+'CPF/CNPJ do Consumidor: '+
              DFeUtil.FormatarCNPJCPF(CFe.Dest.CNPJCPF));
end;

procedure TACBrSATExtratoESCPOS.GerarItens;
var
  i : integer;
begin
  FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
  FBuffer.Add('#|COD|DESC|QTD|UN|VL UN R$|(VLTR R$)*|VL ITEM R$');
  FBuffer.Add('------------------------------------------------');

  for i:=0 to CFe.Det.Count - 1 do
  begin
    FLinhaCmd := IntToStrZero(CFe.Det.Items[i].nItem,3)+' '+
                 Trim(CFe.Det.Items[i].Prod.cProd)+' '+
                 Trim(CFe.Det.Items[i].Prod.xProd)+' '+
                 DFeUtil.FormatFloat(CFe.Det.Items[i].Prod.qCom,Mask_vUnCom)+' '+
                 Trim(CFe.Det.Items[i].Prod.uCom)+' X '+
                 DFeUtil.FormatFloat(CFe.Det.Items[i].Prod.vUnCom,Mask_vUnCom)+' ';
    if CFe.Det.Items[i].Imposto.vItem12741 > 0 then
      FLinhaCmd := FLinhaCmd + '('+DFeUtil.FormatFloat(CFe.Det.Items[i].Imposto.vItem12741,'0.00')+') ';

    FLinhaCmd := FLinhaCmd + '|' + DFeUtil.FormatFloat(CFe.Det.Items[i].Prod.vProd,'#,###,##0.00')+' ';

    FLinhaCmd := padS(FLinhaCmd,64, '|');

    FBuffer.Add(cCmdAlinhadoEsquerda+cCmdFontePequena+FLinhaCmd);

    if CFe.Det.Items[i].Prod.vDesc > 0 then
    begin
    if FLinhasEntItens > 0 then
       PulaLinhas(FLinhasEntItens);
      FBuffer.Add(padS('Desconto|'+DFeUtil.FormatFloat(CFe.Det.Items[i].Prod.vDesc,'-#,###,##0.00'),64, '|'));
    if FLinhasEntItens > 0 then
       PulaLinhas(FLinhasEntItens);
      FBuffer.Add(padS('Valor l�quido|'+DFeUtil.FormatFloat(CFe.Det.Items[i].Prod.vProd-CFe.Det.Items[i].Prod.vDesc,'#,###,##0.00'),64, '|'));
    end;

    if CFe.Det.Items[i].Prod.vOutro > 0 then
    begin
    if FLinhasEntItens > 0 then
       PulaLinhas(FLinhasEntItens);
      FBuffer.Add(padS('Acr�scimo|'+DFeUtil.FormatFloat(CFe.Det.Items[i].Prod.vOutro,'+#,###,##0.00'),64, '|'));
    if FLinhasEntItens > 0 then
       PulaLinhas(FLinhasEntItens);
      FBuffer.Add(padS('Valor l�quido|'+DFeUtil.FormatFloat(CFe.Det.Items[i].Prod.vProd+CFe.Det.Items[i].Prod.vOutro,'#,###,##0.00'),64, '|'));
    end;

    if CFe.Det.Items[i].Imposto.ISSQN.vDeducISSQN > 0 then
    begin
    if FLinhasEntItens > 0 then
       PulaLinhas(FLinhasEntItens);
      FBuffer.Add(padS('Dedu��o para ISSQN|'+DFeUtil.FormatFloat(CFe.Det.Items[i].Imposto.ISSQN.vDeducISSQN,'-#,###,##0.00'),64, '|'));
    if FLinhasEntItens > 0 then
       PulaLinhas(FLinhasEntItens);
      FBuffer.Add(padS('Base de c�lculo ISSQN|'+DFeUtil.FormatFloat(CFe.Det.Items[i].Imposto.ISSQN.vBC,'#,###,##0.00'),64, '|'));
    end;

    if FLinhasEntItens > 0 then
       PulaLinhas(FLinhasEntItens);
  end;
  FBuffer.Add(cCmdAlinhadoEsquerda+cCmdFonteNormal);
end;

procedure TACBrSATExtratoESCPOS.GerarTotais(Resumido: Boolean);
var
  Descontos, Acrescimos: Double;
begin
  if not Resumido then
   begin
     Descontos  := (CFe.Total.ICMSTot.vDesc  + CFe.Total.DescAcrEntr.vDescSubtot);
     Acrescimos := (CFe.Total.ICMSTot.vOutro + CFe.Total.DescAcrEntr.vAcresSubtot);

     if (Descontos > 0) or (Acrescimos > 0) then
        Begin
        FBuffer.Add(cCmdFontePequena+padS('Subtotal|'+DFeUtil.FormatFloat(CFe.Total.ICMSTot.vProd,'#,###,##0.00'),64, '|'));
        if FLinhasEntTotais > 0 then
           PulaLinhas(FLinhasEntItens);
        End;
     if (CFe.Total.ICMSTot.vDesc > 0) or (CFe.Total.DescAcrEntr.vDescSubtot>0) then
        Begin
        FBuffer.Add(cCmdFontePequena+padS('Descontos|'+DFeUtil.FormatFloat(Descontos,'-#,###,##0.00'),64, '|'));
        if FLinhasEntTotais > 0 then
           PulaLinhas(FLinhasEntItens);
        End;
     if (CFe.Total.ICMSTot.vOutro > 0) or (CFe.Total.DescAcrEntr.vAcresSubtot>0) then
        Begin
        FBuffer.Add(cCmdFontePequena+padS('Acr�scimos|'+DFeUtil.FormatFloat(Acrescimos,'+#,###,##0.00'),64, '|'));
        if FLinhasEntTotais > 0 then
           PulaLinhas(FLinhasEntItens);
        End;
   end;

  FLinhaCmd := cCmdAlinhadoEsquerda+cCmdImpExpandido+
               padS('TOTAL R$|'+FormatFloat('#,###,##0.00',CFe.Total.vCFe),32, '|')+
               cCmdImpFimExpandido;
  FBuffer.Add(FLinhaCmd);
end;

procedure TACBrSATExtratoESCPOS.GerarPagamentos(Resumido : Boolean = False );
var
  i : integer;
begin
  if not Resumido then
    FBuffer.Add('');
  for i:=0 to CFe.Pagto.Count - 1 do
   begin
     FBuffer.Add(cCmdFontePequena+padS(CodigoMPToDescricao(CFe.Pagto.Items[i].cMP)+'|'+
                 DFeUtil.FormatFloat(CFe.Pagto.Items[i].vMP,'#,###,##0.00'),64, '|'));
     
    if FLinhasEntPagamentos > 0 then
       PulaLinhas(FLinhasEntPagamentos);
   end;
  if CFe.Pagto.vTroco > 0 then
     FBuffer.Add(cCmdFontePequena+padS('Troco R$|'+FormatFloat('#,###,##0.00',CFe.Pagto.vTroco),64, '|'));
end;

procedure TACBrSATExtratoESCPOS.GerarObsFisco;
var
  i : integer;
begin
  if (CFe.InfAdic.obsFisco.Count > 0) or
     (CFe.Emit.cRegTrib = RTSimplesNacional) then
     FBuffer.Add('');

  if CFe.Emit.cRegTrib = RTSimplesNacional then
     FBuffer.Add(cCmdFontePequena + Msg_ICMS_123_2006 );


  for i:=0 to CFe.InfAdic.obsFisco.Count - 1 do
   begin
      FBuffer.Add(cCmdFontePequena+CFe.InfAdic.obsFisco.Items[i].xCampo+'-'+CFe.InfAdic.obsFisco.Items[i].xTexto);
   end;
end;

procedure TACBrSATExtratoESCPOS.GerarDadosEntrega;
begin
  if Trim(CFe.Entrega.xLgr)+
     Trim(CFe.Entrega.nro)+
     Trim(CFe.Entrega.xCpl)+
     Trim(CFe.Entrega.xBairro)+
     Trim(CFe.Entrega.xMun) <> '' then
   begin
     FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
     FBuffer.Add('DADOS PARA ENTREGA');
    if FLinhasEntDadosEntrega > 0 then
       PulaLinhas(FLinhasEntDadosEntrega);
     FBuffer.Add(cCmdFontePequena+Trim(CFe.Entrega.xLgr)+' '+
                 Trim(CFe.Entrega.nro)+' '+
                 Trim(CFe.Entrega.xCpl)+' '+
                 Trim(CFe.Entrega.xBairro)+' '+
                 Trim(CFe.Entrega.xMun));
    if FLinhasEntDadosEntrega > 0 then
       PulaLinhas(FLinhasEntDadosEntrega);
     FBuffer.Add(CFe.Dest.xNome);
   end;
end;

procedure TACBrSATExtratoESCPOS.GerarObsContribuinte(Resumido : Boolean = False );
begin
  if Trim(CFe.InfAdic.infCpl) <> '' then
  begin
    FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
    FBuffer.Add('OBSERVA��ES DO CONTRIBUINTE');
    if FLinhasEntRodape > 0 then
       PulaLinhas(FLinhasEntRodape);
    FBuffer.Add(cCmdFontePequena+StringReplace(Trim(CFe.InfAdic.infCpl),';',sLineBreak,[rfReplaceAll]));
  end;

  if (CFe.Total.vCFeLei12741 > 0) and
     ((ImprimirLei12741) or (Trim(CFe.InfAdic.infCpl) = '' )) then
  begin
    if Trim(CFe.InfAdic.infCpl) = '' then
    begin
      FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
      FBuffer.Add('OBSERVA��ES DO CONTRIBUINTE');
      if FLinhasEntRodape > 0 then
         PulaLinhas(FLinhasEntRodape);
    end
    else
      FBuffer.Add(' ');

    FBuffer.Add(cCmdFontePequena+padS('Valor aproximado dos tributos do deste cupom R$ |'+cCmdImpNegrito+FormatFloat('#,###,##0.00',CFe.Total.vCFeLei12741),66, '|'));
    if FLinhasEntRodape > 0 then
       PulaLinhas(FLinhasEntRodape);
    FBuffer.Add(cCmdImpFimNegrito+'(conforme Lei Fed. 12.741/2012)');
    if not Resumido then
    begin
      FBuffer.Add(' ');
      FBuffer.Add('*Valor aproximado dos tributos do item');
    end;
  end;
end;

procedure TACBrSATExtratoESCPOS.GerarRodape(CortaPapel: Boolean = True; Cancelamento: Boolean = False);
var
  qrcode : string;
  cCaracter : AnsiString;
  i, cTam1, cTam2 : Integer;
begin
  FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
  if Cancelamento then
     FBuffer.Add(cCmdImpNegrito+'DADOS DO CUPOM FISCAL ELETR�NICO CANCELADO'+cCmdImpFimNegrito);
  FLinhaCmd := cCmdAlinhadoCentro+'SAT No. '+
               cCmdImpNegrito+IntToStr(CFe.ide.nserieSAT)+cCmdImpFimNegrito;
  FBuffer.Add(FLinhaCmd);
  FBuffer.Add(DFeUtil.FormatDate(DateToStr(CFe.ide.dEmi))+' '+TimeToStr(CFe.ide.hEmi));
  FBuffer.Add(' ');
  FLinhaCmd :=  cCmdFontePequena+DFeUtil.FormatarChaveAcesso((CFe.infCFe.ID))+cCmdFonteNormal;
  FBuffer.Add(FLinhaCmd);
  FBuffer.Add(' ');

  FLinhaCmd := chr(29)+'h'+chr(50)+
               chr(29)+'w'+chr(2)+
               chr(29)+'H0'+
               chr(29)+'kI'+chr(24)+'{C'+AscToBcd(CFe.infCFe.ID,22);
  FBuffer.Add(FLinhaCmd);
  FBuffer.Add(' ');

  cCaracter := '';

  if ImprimeQRCode then
  begin
    qrcode := CalcularConteudoQRCode( CFe.infCFe.ID,
                                      CFe.ide.dEmi+CFe.ide.hEmi,
                                      CFe.Total.vCFe,
                                      Trim(CFe.Dest.CNPJCPF),
                                      CFe.ide.assinaturaQRCODE );

    if MarcaImpressora = iBematech then
     begin
        for i := 1 to length(qrcode) do
         begin
            cCaracter := cCaracter + Chr(Ord(qrcode[i]));
         end;

        if (length(qrcode) > 255) then
         begin
           cTam1 := length(qrcode) mod 255;
           cTam2 := length(qrcode) div 255;
         end
        else
         begin
           cTam1 := length(qrcode);
           cTam2 := 0;
         end;

        FLinhaCmd :=  chr(27) + chr(97) + chr(1) +
                      chr(29) + chr(107) + chr(81) +
                      chr(3) + chr(8) +
                      chr(8) + chr(1) +
                      chr(cTam1) +
                      chr(cTam2) +
                      cCaracter;
     end
    else
     begin
       FLinhaCmd := chr(29)+'(k'+chr(4)+chr(0)+'1A2'+chr(0)+
                    chr(29)+'(k'+chr(3)+chr(0)+'1C'+chr(4)+
                    chr(29)+'(k'+chr(3)+chr(0)+'1E0'+
                    chr(29)+'(k'+Int2TB(length(qrcode)+3)+'1P0'+qrcode+
                    chr(29)+'(k'+chr(3)+chr(0)+'1Q0';
     end;               
    FBuffer.Add(FLinhaCmd);
  end;

  if CortaPapel then
  begin
    PulaLinhas;
    
    FBuffer.Add(cCmdCortaPapel);
  end;
end;

procedure TACBrSATExtratoESCPOS.GerarDadosCancelamento;
var
  qrcode : string;
begin
  FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
  FBuffer.Add(cCmdImpNegrito+'DADOS DO CUPOM FISCAL ELETR�NICO DE CANCELAMENTO'+cCmdImpFimNegrito);
  FLinhaCmd := cCmdAlinhadoCentro+'SAT No. '+
               cCmdImpNegrito+IntToStr(CFe.ide.nserieSAT)+cCmdImpFimNegrito;
  FBuffer.Add(FLinhaCmd);
  FBuffer.Add(DFeUtil.FormatDate(DateToStr(CFeCanc.ide.dEmi))+' '+TimeToStr(CFeCanc.ide.hEmi));
  FBuffer.Add('');
  FLinhaCmd :=  cCmdFontePequena+DFeUtil.FormatarChaveAcesso((CFeCanc.infCFe.ID))+cCmdFonteNormal;
  FBuffer.Add(FLinhaCmd);
  FBuffer.Add(' ');

  FLinhaCmd := chr(29)+'h'+chr(100)+
               chr(29)+'w'+chr(2)+
               chr(29)+'H0'+
               chr(29)+'kI'+chr(24)+'{C'+AscToBcd(CFeCanc.infCFe.ID,22);
  FBuffer.Add(FLinhaCmd);
  FBuffer.Add(' ');

  if ImprimeQRCode then
  begin
    qrcode := CalcularConteudoQRCode( CFeCanc.infCFe.ID,
                                      CFeCanc.ide.dEmi+CFeCanc.ide.hEmi,
                                      CFeCanc.Total.vCFe,
                                      Trim(CFeCanc.Dest.CNPJCPF),
                                      CFeCanc.ide.assinaturaQRCODE );

    FLinhaCmd := chr(29)+'(k'+chr(4)+chr(0)+'1A2'+chr(0)+
                 chr(29)+'(k'+chr(3)+chr(0)+'1C'+chr(6)+
                 chr(29)+'(k'+chr(3)+chr(0)+'1E0'+
                 chr(29)+'(k'+Int2TB(length(qrcode)+3)+'1P0'+qrcode+
                 chr(29)+'(k'+chr(3)+chr(0)+'1Q0';
    FBuffer.Add(FLinhaCmd);
  end;

  PulaLinhas;

  FBuffer.Add(cCmdCortaPapel);
end;

procedure TACBrSATExtratoESCPOS.PulaLinhas(NumLinhas: Integer);
var
  i : integer;
begin
  if NumLinhas = 0 then
     NumLinhas := LinhasEntreCupons ;

  for i:=0 to NumLinhas do
   begin
     FBuffer.Add('');
   end
end;


procedure TACBrSATExtratoESCPOS.ImprimePorta(AString: AnsiString);
var
  I: Integer;
begin
  for I := 1 to NumCopias do
    FDevice.EnviaString( AString );
end;

procedure TACBrSATExtratoESCPOS.ImprimirExtrato(ACFe: TCFe);
begin
  inherited;

  GerarCabecalho;
  GerarItens;
  GerarTotais;
  GerarPagamentos;
  GerarObsFisco;
  GerarDadosEntrega;
  GerarObsContribuinte;
  GerarRodape;

  ImprimePorta(FBuffer.Text);
end;

procedure TACBrSATExtratoESCPOS.ImprimirExtratoCancelamento(ACFe: TCFe;
  ACFeCanc: TCFeCanc);
begin
  inherited;

  GerarCabecalho;
  GerarTotais(True);
  GerarRodape(False, True);
  GerarDadosCancelamento;

  ImprimePorta(FBuffer.Text);
end;

procedure TACBrSATExtratoESCPOS.ImprimirExtratoResumido(ACFe: TCFe);
begin
  inherited;

  GerarCabecalho;
  GerarTotais(True);
  GerarPagamentos(True);
  GerarObsFisco;
  GerarDadosEntrega;
  GerarObsContribuinte(True);
  GerarRodape;

  ImprimePorta(FBuffer.Text);
end;

{$IFDEF FPC}
{$IFNDEF NOGUI}
initialization
   {$I ACBrSAT.lrs}
{$ENDIF}
{$ENDIF}

end.
