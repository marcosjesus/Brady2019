{******************************************************************************}
{ Projeto: ACBrNFeMonitor                                                      }
{  Executavel multiplataforma que faz uso do conjunto de componentes ACBr para }
{ criar uma interface de comunica��o com equipamentos de automacao comercial.  }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na p�gina do Projeto ACBr     }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Este programa � software livre; voc� pode redistribu�-lo e/ou modific�-lo   }
{ sob os termos da Licen�a P�blica Geral GNU, conforme publicada pela Free     }
{ Software Foundation; tanto a vers�o 2 da Licen�a como (a seu crit�rio)       }
{ qualquer vers�o mais nova.                                                   }
{                                                                              }
{  Este programa � distribu�do na expectativa de ser �til, mas SEM NENHUMA     }
{ GARANTIA; nem mesmo a garantia impl�cita de COMERCIALIZA��O OU DE ADEQUA��O A}
{ QUALQUER PROP�SITO EM PARTICULAR. Consulte a Licen�a P�blica Geral GNU para  }
{ obter mais detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)                    }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral GNU junto com este}
{ programa; se n�o, escreva para a Free Software Foundation, Inc., 59 Temple   }
{ Place, Suite 330, Boston, MA 02111-1307, USA. Voc� tamb�m pode obter uma     }
{ copia da licen�a em:  http://www.opensource.org/licenses/gpl-license.php     }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}
{$I ACBr.inc}

unit DoACBrNFeUnit ;

interface

Uses Classes, TypInfo, SysUtils, CmdUnitNFe, Types, StdCtrls,
     smtpsend, ssl_openssl, mimemess, mimepart,
     ACBrNFeUtil, ACBrDFeUtil, RpDevice,
     IdMessage, IdSMTP, IdBaseComponent, IdComponent,
     IdIOHandler, IdIOHandlerSocket, IdSSLOpenSSL;

Procedure DoACBrNFe( Cmd : TACBrNFeCTeCmd ) ;
Function ConvertStrRecived( AStr: String ) : String ;
function UFparaCodigo(const UF: string): integer;
function ObterCodigoMunicipio(const xMun, xUF: string): integer;
procedure GerarIniNFe( AStr: WideString ) ;
function GerarNFeIni( XML : WideString ) : WideString;
procedure EnviarEmail(const sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto, sAttachment, sAttachment2: String; sMensagem : TStrings; SSL, TLS : Boolean; sCopias: String='');
procedure EnviarEmailIndy(const sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto, sAttachment, sAttachment2: String; sMensagem : TStrings; SSL, TLS : Boolean; sCopias: String='');
procedure GerarIniEvento( AStr: WideString; CCe : Boolean = False ) ;

implementation

Uses IniFiles, StrUtils, DateUtils,
  Windows, Forms, XMLIntf, XMLDoc,
  ACBrUtil, ACBrNFeMonitor1 , ACBrNFeWebServices, ACBrNFe,
  ACBrNFeConfiguracoes, ACBrNFeDANFEClass,
  pcnNFe, pcnConversao,
  pcnRetConsReciNFe, pcnConsStatServ, pcnRetConsStatServ,
  pcnCancNFe, pcnRetCancNFe,
  pcnConsSitNFe, pcnRetConsSitNFe,
  pcnInutNFe, pcnRetInutNFe,
  pcnRetEnvNFe, pcnConsReciNFe, pcnAuxiliar,
  pcnNFeRTXT, ACBrNFeNotasFiscais, pcnRetConsCad, pcnProcNFe,
  pcnRetCCeNFe, pcnNFeR, pcnEventoNFe, pcnRetConsNFeDest,
  pcnRetDownloadNFe, pcnRetEnvEventoNFe, pcnEnvEventoNFe, pcteCTe;

Procedure DoACBrNFe( Cmd : TACBrNFeCTeCmd ) ;
var
  I,J : Integer;
  ArqNFe, ArqPDF, ArqEvento, Chave : String;
  Salva, EnviadoDPEC, OK, OldMostrarPreview, MudouDANFe : Boolean;
  SL     : TStringList;
  ChavesNFe: Tstrings;
  Alertas : AnsiString;
  wDiretorioAtual : String;

  Lines   : TStringList ;
  MemoTXT : TMemo;
  Files  : String ;
  dtFim  : TDateTime ;

  RetFind   : Integer ;
  SearchRec : TSearchRec ;

  NFeRTXT   : TNFeRTXT;
  VersaoDF  : TpcnVersaoDF;
  ModeloDF  : TpcnModeloDF;
  OldDANFe  : TACBrNFeDANFEClass;
begin
 with frmAcbrNfeMonitor do
  begin
     wDiretorioAtual := GetCurrentDir;
     try
        if Cmd.Metodo = 'statusservico' then
         begin
           ACBrNFe1.WebServices.StatusServico.Executar;
           Cmd.Resposta := ACBrNFe1.WebServices.StatusServico.Msg+
                              '[STATUS]'+sLineBreak+
                              'Versao='+ACBrNFe1.WebServices.StatusServico.verAplic+sLineBreak+
                              'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.StatusServico.TpAmb)+sLineBreak+
                              'VerAplic='+ACBrNFe1.WebServices.StatusServico.VerAplic+sLineBreak+
                              'CStat='+IntToStr(ACBrNFe1.WebServices.StatusServico.CStat)+sLineBreak+
                              'XMotivo='+ACBrNFe1.WebServices.StatusServico.XMotivo+sLineBreak+
                              'CUF='+IntToStr(ACBrNFe1.WebServices.StatusServico.CUF)+sLineBreak+
                              'DhRecbto='+DateTimeToStr(ACBrNFe1.WebServices.StatusServico.DhRecbto)+sLineBreak+
                              'TMed='+IntToStr(ACBrNFe1.WebServices.StatusServico.TMed)+sLineBreak+
                              'DhRetorno='+DateTimeToStr(ACBrNFe1.WebServices.StatusServico.DhRetorno)+sLineBreak+
                              'XObs='+ACBrNFe1.WebServices.StatusServico.XObs+sLineBreak;
         end

        else if Cmd.Metodo = 'validarnfe' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' n�o encontrado.');

           ACBrNFe1.NotasFiscais.Valida;
         end

        else if Cmd.Metodo = 'assinarnfe' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' n�o encontrado.');

           Salva := ACBrNFe1.Configuracoes.Geral.Salvar;
           if not Salva then
            begin
             ForceDirectories(PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs');
             ACBrNFe1.Configuracoes.Geral.PathSalvar := PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs';
            end;
           ACBrNFe1.Configuracoes.Geral.Salvar := True;
           ACBrNFe1.NotasFiscais.Assinar;
           ACBrNFe1.Configuracoes.Geral.Salvar := Salva;
           if DFeUtil.NaoEstaVazio(ACBrNFe1.NotasFiscais.Items[0].NomeArq) then
              Cmd.Resposta := ACBrNFe1.NotasFiscais.Items[0].NomeArq
           else
              Cmd.Resposta := PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+StringReplace(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 'NFe', '', [rfIgnoreCase])+'-nfe.xml';
         end

        else if Cmd.Metodo = 'consultarnfe' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) or FileExists(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0)) then
            begin
              if FileExists(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0)) then
                 ACBrNFe1.NotasFiscais.LoadFromFile(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0))
              else
                 ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0));

              ACBrNFe1.WebServices.Consulta.NFeChave := StringReplace(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID,'NFe','',[rfIgnoreCase]);
            end
           else
            begin
              if not ValidarChave('NFe'+Cmd.Params(0)) then
                 raise Exception.Create('Chave '+Cmd.Params(0)+' inv�lida.')
              else
                 ACBrNFe1.WebServices.Consulta.NFeChave := Cmd.Params(0);
            end;
           try
              ACBrNFe1.WebServices.Consulta.Executar;

              Cmd.Resposta := ACBrNFe1.WebServices.Consulta.Msg+sLineBreak+
                              '[CONSULTA]'+sLineBreak+
                              'Versao='+ACBrNFe1.WebServices.Consulta.verAplic+sLineBreak+
                              'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Consulta.TpAmb)+sLineBreak+
                              'VerAplic='+ACBrNFe1.WebServices.Consulta.VerAplic+sLineBreak+
                              'CStat='+IntToStr(ACBrNFe1.WebServices.Consulta.CStat)+sLineBreak+
                              'XMotivo='+ACBrNFe1.WebServices.Consulta.XMotivo+sLineBreak+
                              'CUF='+IntToStr(ACBrNFe1.WebServices.Consulta.CUF)+sLineBreak+
                              'ChNFe='+ACBrNFe1.WebServices.Consulta.NFeChave+sLineBreak+
                              'DhRecbto='+DateTimeToStr(ACBrNFe1.WebServices.Consulta.DhRecbto)+sLineBreak+
                              'NProt='+ACBrNFe1.WebServices.Consulta.Protocolo+sLineBreak+
                              'DigVal='+ACBrNFe1.WebServices.Consulta.protNFe.digVal+sLineBreak;

           except
               on E: Exception do
                begin
                  raise Exception.Create(ACBrNFe1.WebServices.Consulta.Msg+sLineBreak+E.Message);
                end;
           end;
         end

        else if Cmd.Metodo = 'cancelarnfe' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if not ValidarChave('NFe'+Cmd.Params(0)) then
              raise Exception.Create('Chave '+Cmd.Params(0)+' inv�lida.')
           else
              ACBrNFe1.WebServices.Consulta.NFeChave := Cmd.Params(0);

           if not ACBrNFe1.WebServices.Consulta.Executar then
              raise Exception.Create(ACBrNFe1.WebServices.Consulta.Msg);

           ACBrNFe1.EventoNFe.Evento.Clear;
           with ACBrNFe1.EventoNFe.Evento.Add do
            begin
              infEvento.CNPJ   := Cmd.Params(2);
              if Trim(infEvento.CNPJ) = '' then
                 infEvento.CNPJ   := copy(DFeUtil.LimpaNumero(ACBrNFe1.WebServices.Consulta.NFeChave),7,14)
              else
               begin
                 if not ValidarCNPJ(Cmd.Params(2)) then
                   raise Exception.Create('CNPJ '+Cmd.Params(2)+' inv�lido.')
               end;

              infEvento.cOrgao := StrToIntDef(copy(DFeUtil.LimpaNumero(ACBrNFe1.WebServices.Consulta.NFeChave),1,2),0);
              infEvento.dhEvento := now;
              infEvento.tpEvento := teCancelamento;
              infEvento.chNFe := ACBrNFe1.WebServices.Consulta.NFeChave;
              infEvento.detEvento.nProt := ACBrNFe1.WebServices.Consulta.Protocolo;
              infEvento.detEvento.xJust := Cmd.Params(1);
            end;
           try
              ACBrNFe1.EnviarEventoNFe(StrToIntDef(Cmd.Params(3),1));

              Cmd.Resposta := ACBrNFe1.WebServices.EnvEvento.EventoRetorno.xMotivo+sLineBreak+
                              '[CANCELAMENTO]'+sLineBreak+
                              'Versao='+ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.verAplic+sLineBreak+
                              'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.TpAmb)+sLineBreak+
                              'VerAplic='+ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.VerAplic+sLineBreak+
                              'CStat='+IntToStr(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat)+sLineBreak+
                              'XMotivo='+ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XMotivo+sLineBreak+
                              'CUF='+IntToStr(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cOrgao)+sLineBreak+
                              'ChNFe='+ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.chNFe+sLineBreak+
                              'DhRecbto='+DateTimeToStr(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento)+sLineBreak+
                              'NProt='+ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt+sLineBreak+
                              'tpEvento='+TpEventoToStr(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.tpEvento)+sLineBreak+
                              'xEvento='+ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xEvento+sLineBreak+
                              'nSeqEvento='+IntToStr(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nSeqEvento)+sLineBreak+
                              'CNPJDest='+ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.CNPJDest+sLineBreak+
                              'emailDest='+ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.emailDest+sLineBreak+
                              'XML='+ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XML+sLineBreak;
           except
             on E: Exception do
              begin
                raise Exception.Create(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.xMotivo+sLineBreak+E.Message);
              end;
           end;
         end
        else if Cmd.Metodo = 'imprimirdanfe' then
         begin
           OldMostrarPreview := ACBrNFe1.DANFE.MostrarPreview;

           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) or FileExists(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0)) then
            begin
              if FileExists(Cmd.Params(0)) then
                 ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0))
              else
                 ACBrNFe1.NotasFiscais.LoadFromFile(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0));
            end
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' n�o encontrado.');

           ConfiguraDANFe;
           if ACBrNFe1.DANFE.MostrarPreview or (Cmd.Params(4) = '1') then
            begin
              Restaurar1.Click;
              Application.BringToFront;
              ACBrNFe1.DANFE.MostrarPreview := True;
            end;

           if DFeUtil.NaoEstaVazio(Cmd.Params(1)) then
              ACBrNFe1.DANFE.Impressora := Cmd.Params(1)
           else
              ACBrNFe1.DANFE.Impressora := cbxImpressora.Text;

           if DFeUtil.NaoEstaVazio(Cmd.Params(2)) then
              ACBrNFe1.DANFE.NumCopias := StrToIntDef(Cmd.Params(2),1)
           else
              ACBrNFe1.DANFE.NumCopias := StrToIntDef(edtNumCopia.Text,1);

           if DFeUtil.NaoEstaVazio(Cmd.Params(3)) then
              ACBrNFe1.DANFE.ProtocoloNFe := Cmd.Params(3);

           if (ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpEmis = teDPEC) and
              DFeUtil.EstaVazio(ACBrNFe1.DANFE.ProtocoloNFe) then
            begin
              ACBrNFe1.WebServices.ConsultaDPEC.NFeChave := ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID;
              ACBrNFe1.WebServices.ConsultaDPEC.Executar;
              ACBrNFe1.DANFE.ProtocoloNFe := ACBrNFe1.WebServices.ConsultaDPEC.nRegDPEC +' '+ DateTimeToStr(ACBrNFe1.WebServices.ConsultaDPEC.dhRegDPEC);
            end;

           if DFeUtil.NaoEstaVazio(Cmd.Params(5)) then
            begin
              ACBrNFeDANFERave1.MarcaDaguaMSG := Cmd.Params(5);
              ACBrNFeDANFERaveCB1.MarcaDaguaMSG := Cmd.Params(5);
            end
           else
            begin
              ACBrNFeDANFERave1.MarcaDaguaMSG := '';
              ACBrNFeDANFERaveCB1.MarcaDaguaMSG := '';
            end ;

           ACBrNFe1.NotasFiscais.Imprimir;
           Cmd.Resposta := 'Danfe Impresso com sucesso';
           if ACBrNFe1.DANFE.MostrarPreview or (Cmd.Params(4) = '1') then
            begin
              ACBrNFe1.DANFE.MostrarPreview := OldMostrarPreview;
              Ocultar1.Click;
            end;
         end

        else if Cmd.Metodo = 'imprimirdanfepdf' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' n�o encontrado.');

           ConfiguraDANFe;
           MudouDANFe := False;

           if ACBrNFe1.DANFE = ACBrNFeDANFeESCPOS1 then
            begin
              MudouDANFe := True;
              OldDANFe := ACBrNFe1.DANFE;
              ACBrNFe1.DANFE := ACBrNFeDANFCeFortes1;
            end;

           if DFeUtil.NaoEstaVazio(Cmd.Params(1)) then
              ACBrNFe1.DANFE.ProtocoloNFe := Cmd.Params(1);

           if (ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpEmis = teDPEC) and
              DFeUtil.EstaVazio(ACBrNFe1.DANFE.ProtocoloNFe) then
            begin
              ACBrNFe1.WebServices.ConsultaDPEC.NFeChave := ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID;
              ACBrNFe1.WebServices.ConsultaDPEC.Executar;
              ACBrNFe1.DANFE.ProtocoloNFe := ACBrNFe1.WebServices.ConsultaDPEC.nRegDPEC +' '+ DateTimeToStr(ACBrNFe1.WebServices.ConsultaDPEC.dhRegDPEC);
            end;

           try
              ACBrNFe1.NotasFiscais.ImprimirPDF;
              ArqPDF := OnlyNumber(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID)+'-nfe.pdf';
              if MudouDANFe then
               begin
                 MudouDANFe := False;
                 ACBrNFe1.DANFE := OldDANFe;
               end;
              Cmd.Resposta := 'Arquivo criado em: '+ PathWithDelim(ACBrNFe1.DANFE.PathPDF) +
                              ArqPDF ;
           except
              raise Exception.Create('Erro ao criar o arquivo PDF');
           end;
         end

        else if Cmd.Metodo = 'imprimirevento' then
         begin
           if ACBrNFe1.DANFE.MostrarPreview then
            begin
              Restaurar1.Click;
              Application.BringToFront;
            end;

           ACBrNFe1.EventoNFe.Evento.Clear;
           if FileExists(Cmd.Params(0)) or FileExists(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0)) then
            begin
              if FileExists(Cmd.Params(0)) then
                 ACBrNFe1.EventoNFe.LerXML(Cmd.Params(0))
              else
                 ACBrNFe1.EventoNFe.LerXML(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0));
            end
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' n�o encontrado.');

           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(1)) or FileExists(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(1)) then
            begin
              if FileExists(Cmd.Params(1)) then
                 ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(1))
              else
                 ACBrNFe1.NotasFiscais.LoadFromFile(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(1));
            end
           else
            begin
              if DFeUtil.NaoEstaVazio(Cmd.Params(1)) then
                 raise Exception.Create('Arquivo '+Cmd.Params(1)+' n�o encontrado.');
            end;

           ConfiguraDANFe;

           if (ACBrNFe1.Configuracoes.Geral.ModeloDF = moNFe) or (rgModoImpressaoEvento.ItemIndex = 0) then
              ACBrNFe1.DANFE := ACBrNFeDANFERaveCB1
           else
            begin
              if rgModeloDANFeNFCE.ItemIndex = 0 then
                 ACBrNFe1.DANFE := ACBrNFeDANFCeFortes1
              else
                 ACBrNFe1.DANFE := ACBrNFeDANFeESCPOS1;
            end;

           if DFeUtil.NaoEstaVazio(Cmd.Params(2)) then
              ACBrNFe1.DANFE.Impressora := Cmd.Params(2)
           else
              ACBrNFe1.DANFE.Impressora := cbxImpressora.Text;

           if DFeUtil.NaoEstaVazio(Cmd.Params(3)) then
              ACBrNFe1.DANFE.NumCopias := StrToIntDef(Cmd.Params(3),1)
           else
              ACBrNFe1.DANFE.NumCopias := StrToIntDef(edtNumCopia.Text,1);

           ACBrNFe1.ImprimirEvento;
           Cmd.Resposta := 'Evento Impresso com sucesso';
           if ACBrNFe1.DANFE.MostrarPreview then
              Ocultar1.Click;
         end

        else if Cmd.Metodo = 'imprimireventopdf' then
         begin
           ACBrNFe1.EventoNFe.Evento.Clear;
           if FileExists(Cmd.Params(0)) or FileExists(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0)) then
            begin
              if FileExists(Cmd.Params(0)) then
                 ACBrNFe1.EventoNFe.LerXML(Cmd.Params(0))
              else
                 ACBrNFe1.EventoNFe.LerXML(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0));
            end
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' n�o encontrado.');

           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(1)) or FileExists(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(1)) then
            begin
              if FileExists(Cmd.Params(1)) then
                 ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(1))
              else
                 ACBrNFe1.NotasFiscais.LoadFromFile(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(1));
            end
           else
            begin
              if DFeUtil.NaoEstaVazio(Cmd.Params(1)) then
                 raise Exception.Create('Arquivo '+Cmd.Params(1)+' n�o encontrado.');
            end;

           ConfiguraDANFe;

           if (ACBrNFe1.Configuracoes.Geral.ModeloDF = moNFe) or  (rgModoImpressaoEvento.ItemIndex = 0) then
              ACBrNFe1.DANFE := ACBrNFeDANFERaveCB1
           else
              ACBrNFe1.DANFE := ACBrNFeDANFCeFortes1;

           try
              ACBrNFe1.ImprimirEventoPDF;
              ArqPDF := OnlyNumber(ACBrNFe1.EventoNFe.Evento[0].InfEvento.id);
              ArqPDF := PathWithDelim(ACBrNFe1.DANFE.PathPDF)+ArqPDF+'-procEventoNFe.pdf';
              Cmd.Resposta := 'Arquivo criado em: ' + ArqPDF ;
           except
              raise Exception.Create('Erro ao criar o arquivo PDF');
           end;
         end
				else if Cmd.Metodo = 'imprimirinutilizacao' then
				 begin
						if ACBrNFe1.DANFE.MostrarPreview then
            begin
              Restaurar1.Click;
              Application.BringToFront;
            end;

           if FileExists(Cmd.Params(0)) or FileExists(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0)) then
            begin
              if FileExists(Cmd.Params(0)) then
                 ACBrNFe1.InutNFe.LerXML(Cmd.Params(0))
              else
                 ACBrNFe1.InutNFe.LerXML(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0));
            end
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' n�o encontrado.');        

           ConfiguraDANFe;

           if DFeUtil.NaoEstaVazio(Cmd.Params(1)) then
              ACBrNFe1.DANFE.Impressora := Cmd.Params(1)
           else
              ACBrNFe1.DANFE.Impressora := cbxImpressora.Text;

           if DFeUtil.NaoEstaVazio(Cmd.Params(2)) then
              ACBrNFe1.DANFE.NumCopias := StrToIntDef(Cmd.Params(2),1)
           else
              ACBrNFe1.DANFE.NumCopias := StrToIntDef(edtNumCopia.Text,1);

  				 ACBrNFe1.ImprimirInutilizacao;
					 Cmd.Resposta := 'Inutiliza��o Impresso com sucesso';
					 if ACBrNFe1.DANFE.MostrarPreview then
             Ocultar1.Click;
				 end
				else if Cmd.Metodo = 'imprimirinutilizacaopdf' then
         begin
           if FileExists(Cmd.Params(0)) or FileExists(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0)) then
            begin
              if FileExists(Cmd.Params(0)) then
                 ACBrNFe1.InutNFe.LerXML(Cmd.Params(0))
              else
                 ACBrNFe1.InutNFe.LerXML(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0));
            end
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' n�o encontrado.');         

           ConfiguraDANFe;

           try
              ACBrNFe1.ImprimirInutilizacaoPDF;
              ArqPDF := OnlyNumber(ACBrNFe1.InutNFe.Id);
              ArqPDF := PathWithDelim(ACBrNFe1.DANFE.PathPDF)+ArqPDF+'-procInutNFe.pdf';
              Cmd.Resposta := 'Arquivo criado em: ' + ArqPDF ;
           except
              raise Exception.Create('Erro ao criar o arquivo PDF');
           end;
         end				
        else if Cmd.Metodo = 'inutilizarnfe' then
         begin                            //CNPJ         //Justificat   //Ano                    //Modelo                 //S�rie                  //Num.Inicial            //Num.Final
           ACBrNFe1.WebServices.Inutiliza(Cmd.Params(0), Cmd.Params(1), StrToInt(Cmd.Params(2)), StrToInt(Cmd.Params(3)), StrToInt(Cmd.Params(4)), StrToInt(Cmd.Params(5)), StrToInt(Cmd.Params(6)));

           Cmd.Resposta := ACBrNFe1.WebServices.Inutilizacao.Msg+sLineBreak+
                           '[INUTILIZACAO]'+sLineBreak+
                           'Versao='+ACBrNFe1.WebServices.Inutilizacao.verAplic+sLineBreak+
                           'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Inutilizacao.TpAmb)+sLineBreak+
                           'VerAplic='+ACBrNFe1.WebServices.Inutilizacao.VerAplic+sLineBreak+
                           'CStat='+IntToStr(ACBrNFe1.WebServices.Inutilizacao.CStat)+sLineBreak+
                           'XMotivo='+ACBrNFe1.WebServices.Inutilizacao.XMotivo+sLineBreak+
                           'CUF='+IntToStr(ACBrNFe1.WebServices.Inutilizacao.CUF)+sLineBreak+
                           'DhRecbto='+DateTimeToStr(ACBrNFe1.WebServices.Inutilizacao.DhRecbto)+sLineBreak+
                           'NProt='+ACBrNFe1.WebServices.Inutilizacao.Protocolo+sLineBreak;
         end

        else if Cmd.Metodo = 'enviarnfe' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' n�o encontrado.');

           ACBrNFe1.NotasFiscais.GerarNFe;
           if Cmd.Params(2) <> '0' then
              ACBrNFe1.NotasFiscais.Assinar;

           ACBrNFe1.NotasFiscais.Valida;

//           if not(ACBrNFe1.WebServices.StatusServico.Executar) then
//            raise Exception.Create(ACBrNFe1.WebServices.StatusServico.Msg);

           if Trim(OnlyNumber(Cmd.Params(1))) = '' then
              ACBrNFe1.WebServices.Enviar.Lote := '1'
           else
              ACBrNFe1.WebServices.Enviar.Lote := OnlyNumber(Cmd.Params(1));

           ACBrNFe1.WebServices.Enviar.Sincrono := IIf(Cmd.Params(5)='1',True,False);
           ACBrNFe1.WebServices.Enviar.Executar;

           Cmd.Resposta :=  ACBrNFe1.WebServices.Enviar.Msg+sLineBreak+
                            '[ENVIO]'+sLineBreak+
                            'Versao='+ACBrNFe1.WebServices.Enviar.verAplic+sLineBreak+
                            'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Enviar.TpAmb)+sLineBreak+
                            'VerAplic='+ACBrNFe1.WebServices.Enviar.VerAplic+sLineBreak+
                            'CStat='+IntToStr(ACBrNFe1.WebServices.Enviar.CStat)+sLineBreak+
                            'XMotivo='+ACBrNFe1.WebServices.Enviar.XMotivo+sLineBreak+
                            'CUF='+IntToStr(ACBrNFe1.WebServices.Enviar.CUF)+sLineBreak+
                            'NRec='+ACBrNFe1.WebServices.Enviar.Recibo+sLineBreak+
                            'DhRecbto='+DateTimeToStr( ACBrNFe1.WebServices.Enviar.dhRecbto)+sLineBreak+
                            'TMed='+IntToStr( ACBrNFe1.WebServices.Enviar.tMed)+sLineBreak;

           if ACBrNFe1.WebServices.Enviar.Recibo <> '' then
            begin
              ACBrNFe1.WebServices.Retorno.Recibo := ACBrNFe1.WebServices.Enviar.Recibo;
              ACBrNFe1.WebServices.Retorno.Executar;

              Cmd.Resposta :=  Cmd.Resposta+
                               ACBrNFe1.WebServices.Retorno.Msg+sLineBreak+
                               '[RETORNO]'+sLineBreak+
                               'Versao='+ACBrNFe1.WebServices.Retorno.verAplic+sLineBreak+
                               'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Retorno.TpAmb)+sLineBreak+
                               'VerAplic='+ACBrNFe1.WebServices.Retorno.VerAplic+sLineBreak+
                               'NRec='+ACBrNFe1.WebServices.Retorno.NFeRetorno.nRec+sLineBreak+
                               'CStat='+IntToStr(ACBrNFe1.WebServices.Retorno.CStat)+sLineBreak+
                               'XMotivo='+ACBrNFe1.WebServices.Retorno.XMotivo+sLineBreak+
                               'CUF='+IntToStr(ACBrNFe1.WebServices.Retorno.CUF)+sLineBreak;

              for I:= 0 to ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Count-1 do
               begin
                 for J:= 0 to ACBrNFe1.NotasFiscais.Count-1 do
                 begin
                   if 'NFe'+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].chNFe = ACBrNFe1.NotasFiscais.Items[j].NFe.InfNFe.Id  then
                   begin
                     Cmd.Resposta := Cmd.Resposta+
                                '[NFE'+Trim(IntToStr(ACBrNFe1.NotasFiscais.Items[J].NFe.Ide.NNF))+']'+sLineBreak+
                                'Versao='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].verAplic+sLineBreak+
                                'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].tpAmb)+sLineBreak+
                                'VerAplic='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].verAplic+sLineBreak+
                                'CStat='+IntToStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].cStat)+sLineBreak+
                                'XMotivo='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].xMotivo+sLineBreak+
                                'CUF='+IntToStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.cUF)+sLineBreak+
                                'ChNFe='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].chNFe+sLineBreak+
                                'DhRecbto='+DateTimeToStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].dhRecbto)+sLineBreak+
                                'NProt='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].nProt+sLineBreak+
                                'DigVal='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].digVal+sLineBreak;
                     break;
                   end;
                 end;

                ConfiguraDANFe;

                if DFeUtil.NaoEstaVazio(Cmd.Params(4)) then
                   ACBrNFe1.DANFE.Impressora := Cmd.Params(4)
                else
                   ACBrNFe1.DANFE.Impressora := cbxImpressora.Text;

                if ACBrNFe1.NotasFiscais.Items[0].Confirmada and (Cmd.Params(3) = '1') then
                 begin
                   ACBrNFe1.NotasFiscais.Items[0].Imprimir;
                 end;
               end;
            end
           else
            begin
              ConfiguraDANFe;

              if DFeUtil.NaoEstaVazio(Cmd.Params(4)) then
                 ACBrNFe1.DANFE.Impressora := Cmd.Params(4)
              else
                 ACBrNFe1.DANFE.Impressora := cbxImpressora.Text;

              if ACBrNFe1.NotasFiscais.Items[0].Confirmada and (Cmd.Params(3) = '1') then
               begin
                 ACBrNFe1.NotasFiscais.Items[0].Imprimir;
               end;
            end;
         end
        else if (Cmd.Metodo = 'recibonfe')then
         begin
           ACBrNFe1.WebServices.Recibo.Recibo := Cmd.Params(0);
           if not(ACBrNFe1.WebServices.Recibo.Executar) then
             raise Exception.Create(ACBrNFe1.WebServices.Recibo.xMotivo);


           Cmd.Resposta :=  Cmd.Resposta+
                            ACBrNFe1.WebServices.Recibo.Msg+sLineBreak+
                           '[RETORNO]'+sLineBreak+
                           'Versao='+ACBrNFe1.WebServices.Recibo.verAplic+sLineBreak+
                           'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Recibo.TpAmb)+sLineBreak+
                           'VerAplic='+ACBrNFe1.WebServices.Recibo.VerAplic+sLineBreak+
                           'NRec='+ACBrNFe1.WebServices.Recibo.Recibo+sLineBreak+
                           'CStat='+IntToStr(ACBrNFe1.WebServices.Recibo.CStat)+sLineBreak+
                           'XMotivo='+ACBrNFe1.WebServices.Recibo.XMotivo+sLineBreak+
                           'CUF='+IntToStr(ACBrNFe1.WebServices.Recibo.CUF)+sLineBreak+
                           'ChNFe='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].chNFe+sLineBreak+
                           'NProt='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].nProt+sLineBreak+
                           'MotivoNFe='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[0].xMotivo+sLineBreak;

                           for I:= 0 to ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Count-1 do
                            begin
                              Cmd.Resposta := Cmd.Resposta+
                                '[NFE'+Trim(IntToStr(StrToInt(copy(ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].chNFe,26,9))))+']'+sLineBreak+
                                'Versao='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].verAplic+sLineBreak+
                                'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].tpAmb)+sLineBreak+
                                'VerAplic='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].verAplic+sLineBreak+
                                'CStat='+IntToStr(ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].cStat)+sLineBreak+
                                'XMotivo='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].xMotivo+sLineBreak+
                                'CUF='+IntToStr(ACBrNFe1.WebServices.Recibo.NFeRetorno.cUF)+sLineBreak+
                                'ChNFe='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].chNFe+sLineBreak+
                                'DhRecbto='+DateTimeToStr(ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].dhRecbto)+sLineBreak+
                                'NProt='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].nProt+sLineBreak+
                                'DigVal='+ACBrNFe1.WebServices.Recibo.NFeRetorno.ProtNFe.Items[i].digVal+sLineBreak;
                            end;

           if ACBrNFe1.Configuracoes.Geral.Salvar then
            begin
              Cmd.Resposta :=  Cmd.Resposta+
              'Arquivo='+ACBrNFe1.Configuracoes.Geral.PathSalvar+Cmd.Params(0)+'-pro-rec.xml';
            end;
         end
        else if (Cmd.Metodo = 'consultacadastro')then
         begin
           ACBrNFe1.WebServices.ConsultaCadastro.UF   := Cmd.Params(0);
           if Cmd.Params(2) = '1' then
              ACBrNFe1.WebServices.ConsultaCadastro.IE := Cmd.Params(1)
           else
            begin
              if Length(Cmd.Params(1)) > 11 then
                 ACBrNFe1.WebServices.ConsultaCadastro.CNPJ := Cmd.Params(1)
              else
                 ACBrNFe1.WebServices.ConsultaCadastro.CPF := Cmd.Params(1);
            end;
            ACBrNFe1.WebServices.ConsultaCadastro.Executar;

            Cmd.Resposta :=  Cmd.Resposta+
                             ACBrNFe1.WebServices.ConsultaCadastro.Msg+sLineBreak+
                             'verAplic=' +ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.verAplic+sLineBreak+
                             'cStat='    +IntToStr(ACBrNFe1.WebServices.ConsultaCadastro.cStat)+sLineBreak+
                             'xMotivo='  +ACBrNFe1.WebServices.ConsultaCadastro.xMotivo+sLineBreak+
                             'UF='       +ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.UF+sLineBreak+
                             'IE='       +ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.IE+sLineBreak+
                             'CNPJ='     +ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.CNPJ+sLineBreak+
                             'CPF='      +ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.CPF+sLineBreak+
                             'DhCons='   +DateTimeToStr(ACBrNFe1.WebServices.ConsultaCadastro.DhCons)+sLineBreak+
                             'cUF='      +IntToStr(ACBrNFe1.WebServices.ConsultaCadastro.cUF)+sLineBreak;

            for I:= 0 to ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Count - 1 do
             begin
              Cmd.Resposta := Cmd.Resposta+sLineBreak+
                            '[INFCAD'+Trim(IntToStrZero(I+1,3))+']'+sLineBreak+
                             'IE='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].IE+sLineBreak+
                             'CNPJ='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].CNPJ+sLineBreak+
                             'CPF='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].CPF+sLineBreak+
                             'UF='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].UF+sLineBreak+
                             'cSit='+IntToStr(ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].cSit)+sLineBreak+
                             'xNome='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].xNome+sLineBreak+
                             'xFant='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].xFant+sLineBreak+
                             'xRegApur='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].xRegApur+sLineBreak+
                             'CNAE='+inttostr(ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].CNAE)+sLineBreak+
                             'dIniAtiv='+DFeUtil.FormatDate(DateToStr(ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].dIniAtiv))+sLineBreak+
                             'dUltSit='+DFeUtil.FormatDate(DateToStr(ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].dUltSit))+sLineBreak+
                             'dBaixa='+DFeUtil.FormatDate(DateToStr(ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].dBaixa))+sLineBreak+
                             'IEUnica='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].IEUnica+sLineBreak+
                             'IEAtual='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].IEAtual+sLineBreak+
                             'xLgr='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].xLgr+sLineBreak+
                             'nro='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].nro+sLineBreak+
                             'xCpl='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].xCpl+sLineBreak+
                             'xBairro='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].xBairro+sLineBreak+
                             'cMun='+inttostr(ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].cMun)+sLineBreak+
                             'xMun='+ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].xMun+sLineBreak+
                             'CEP='+inttostr(ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[i].CEP)+sLineBreak;
             end;

         end
        else if (Cmd.Metodo = 'criarnfe')      or (Cmd.Metodo = 'criarenviarnfe') or
                (Cmd.Metodo = 'criarnfesefaz') or (Cmd.Metodo = 'criarenviarnfesefaz') or
                (Cmd.Metodo = 'adicionarnfe')  or (Cmd.Metodo = 'adicionarnfesefaz') or
                (Cmd.Metodo = 'enviarlotenfe') or (Cmd.Metodo = 'enviardpecnfe') then
         begin
           ConfiguraDANFe;

           if (Cmd.Metodo = 'criarnfe') or (Cmd.Metodo = 'criarenviarnfe') or
              (Cmd.Metodo = 'adicionarnfe') then
              GerarIniNFe( Cmd.Params(0)  )
           else
            begin
              if (Cmd.Metodo = 'criarnfesefaz') or (Cmd.Metodo = 'criarenviarnfesefaz') or
                 (Cmd.Metodo = 'adicionarnfesefaz') then
                  begin
                    if (copy(Cmd.Params(0), 1, 10) <> 'NOTAFISCAL') and (copy(Cmd.Params(0), 1, 11) <> 'NOTA FISCAL') then
                       if not FileExists(Cmd.Params(0)) then
                          raise Exception.Create('Arquivo '+Cmd.Params(0)+' n�o encontrado.');


                    ACBrNFe1.NotasFiscais.Clear;
                    ACBrNFe1.NotasFiscais.Add;
                    NFeRTXT := TNFeRTXT.Create(ACBrNFe1.NotasFiscais.Items[0].NFe);
                    try
                       if (copy(Cmd.Params(0), 1, 10) <> 'NOTAFISCAL') and (copy(Cmd.Params(0), 1, 11) <> 'NOTA FISCAL') then
                          NFeRTXT.CarregarArquivo(Cmd.Params(0))
                       else
                          NFeRTXT.ConteudoArquivo.Text := Cmd.Params(0);

                       if not NFeRTXT.LerTxt then
                          raise Exception.Create('Arquivo inv�lido!');
                    finally
                       NFeRTXT.Free;
                    end;
                  end;
            end;
           if (Cmd.Metodo = 'adicionarnfe')  or (Cmd.Metodo = 'adicionarnfesefaz') then
            begin
              ForceDirectories(PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+trim(Cmd.Params(1)));
              ACBrNFe1.NotasFiscais.GerarNFe;
              Alertas := ACBrNFe1.NotasFiscais.Items[0].Alertas;
              ACBrNFe1.NotasFiscais.Valida;
              ArqNFe := PathWithDelim(PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+trim(Cmd.Params(1)))+StringReplace(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 'NFe', '', [rfIgnoreCase])+'-nfe.xml';
              ACBrNFe1.NotasFiscais.SaveToFile(ExtractFilePath(ArqNFe));
              if not FileExists(ArqNFe) then
                 raise Exception.Create('N�o foi poss�vel criar o arquivo '+ArqNFe);
            end
           else if (Cmd.Metodo = 'criarnfe')  or (Cmd.Metodo = 'criarnfesefaz') or
           (Cmd.Metodo = 'criarenviarnfe') or (Cmd.Metodo = 'criarenviarnfesefaz') then
            begin
              Salva := ACBrNFe1.Configuracoes.Geral.Salvar;
              if not Salva then
               begin
                ForceDirectories(PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs');
                ACBrNFe1.Configuracoes.Geral.PathSalvar := PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs';
               end;
              ACBrNFe1.NotasFiscais.GerarNFe;
              Alertas := ACBrNFe1.NotasFiscais.Items[0].Alertas;
              ACBrNFe1.NotasFiscais.Valida;
              ArqNFe := PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+StringReplace(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, 'NFe', '', [rfIgnoreCase])+'-nfe.xml';
              ACBrNFe1.NotasFiscais.SaveToFile(ArqNFe);
              if not FileExists(ArqNFe) then
                raise Exception.Create('N�o foi poss�vel criar o arquivo '+ArqNFe);
            end;

           Cmd.Resposta := ArqNFe;
           if Alertas <> '' then
              Cmd.Resposta :=  Cmd.Resposta+sLineBreak+'Alertas:'+Alertas;
           if ((Cmd.Metodo = 'criarnfe') or (Cmd.Metodo = 'criarnfesefaz')) and (Cmd.Params(1) = '1') then
            begin
              SL := TStringList.Create;
              SL.LoadFromFile(ArqNFe);
              Cmd.Resposta :=  Cmd.Resposta+sLineBreak+SL.Text;
              SL.Free;
            end;

           if (Cmd.Metodo = 'criarenviarnfe') or (Cmd.Metodo = 'criarenviarnfesefaz') or (Cmd.Metodo = 'enviarlotenfe') or (Cmd.Metodo = 'enviardpecnfe') then
            begin
              //Carregar Notas quando enviar lote
              if (Cmd.Metodo = 'enviarlotenfe')  or (Cmd.Metodo = 'enviardpecnfe') then
               begin
                 if not DirectoryExists(PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+trim(Cmd.Params(0))) then
                    raise Exception.Create('Diret�rio n�o encontrado:'+PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+trim(Cmd.Params(0)))
                 else
                  begin
                    ACBrNFe1.NotasFiscais.Clear;
                    RetFind := SysUtils.FindFirst( PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+Cmd.Params(0)+PathDelim+'*-nfe.xml', faAnyFile, SearchRec) ;
                    if (RetFind = 0) then
                     begin
                       while RetFind = 0 do
                        begin
                           ACBrNFe1.NotasFiscais.LoadFromFile(PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+Cmd.Params(0)+PathDelim+SearchRec.Name);
                           RetFind := FindNext(SearchRec);
                        end;
                        ACBrNFe1.NotasFiscais.GerarNFe;
                        ACBrNFe1.NotasFiscais.Assinar;
                        ACBrNFe1.NotasFiscais.Valida;
                     end
                    else
                       raise Exception.Create('N�o foi encontrada nenhuma nota para o Lote: '+Cmd.Params(0) );
                  end;
               end;

              if (Cmd.Metodo = 'enviardpecnfe') then
               begin
                 EnviadoDPEC  := ACBrNFe1.WebServices.EnviarDPEC.Executar;
                 Cmd.Resposta :=  ACBrNFe1.WebServices.EnviarDPEC.Msg+sLineBreak+
                                 '[DPEC]'+sLineBreak+
                                 'ID='+ACBrNFe1.WebServices.EnviarDPEC.ID+sLineBreak+
                                 'Versao='+ACBrNFe1.WebServices.EnviarDPEC.verAplic+sLineBreak+
                                 'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.EnviarDPEC.TpAmb)+sLineBreak+
                                 'VerAplic='+ACBrNFe1.WebServices.EnviarDPEC.VerAplic+sLineBreak+
                                 'CStat='+IntToStr(ACBrNFe1.WebServices.EnviarDPEC.cStat)+sLineBreak+
                                 'XMotivo='+ACBrNFe1.WebServices.EnviarDPEC.xMotivo+sLineBreak+
                                 'DhRegDPEC='+DateTimeToStr(ACBrNFe1.WebServices.EnviarDPEC.DhRegDPEC)+sLineBreak+
                                 'nRegDPEC='+ACBrNFe1.WebServices.EnviarDPEC.nRegDPEC+sLineBreak+
                                 'ChNFe='+ACBrNFe1.WebServices.EnviarDPEC.NFeChave+sLineBreak;
                 if (Cmd.Params(1) = '1') and ACBrNFeDANFERave1.MostrarPreview then
                  begin
                    Restaurar1.Click;
                    Application.BringToFront;
                  end;
                 ACBrNFe1.DANFE.Impressora := cbxImpressora.Text;
                 for I:= 0 to ACBrNFe1.NotasFiscais.Count-1 do
                  begin
                    if (Cmd.Params(1) = '1') and EnviadoDPEC then
                     begin
                       ACBrNFe1.DANFE.ProtocoloNFe := ACBrNFe1.WebServices.EnviarDPEC.nRegDPEC +' '+ DateTimeToStr(ACBrNFe1.WebServices.EnviarDPEC.DhRegDPEC);
                       ACBrNFe1.NotasFiscais.Items[i].Imprimir;
                     end;
                  end;
                 if (Cmd.Params(2) = '1') and ACBrNFeDANFERave1.MostrarPreview then
                    Ocultar1.Click;
               end
              else //enviarlotenfe
               begin
//                 if not(ACBrNFe1.WebServices.StatusServico.Executar) then
//                  raise Exception.Create(ACBrNFe1.WebServices.StatusServico.Msg);

                 ACBrNFe1.WebServices.Enviar.Sincrono := IIf(Cmd.Params(3)='1',True,False);

                 if (Cmd.Metodo = 'criarenviarnfe') or (Cmd.Metodo = 'criarenviarnfesefaz') then
                  begin
                    if Trim(OnlyNumber(Cmd.Params(1))) = '' then
                       ACBrNFe1.WebServices.Enviar.Lote := '1'
                    else
                       ACBrNFe1.WebServices.Enviar.Lote := OnlyNumber(Cmd.Params(1));
                  end
                 else
                  begin
                    if Trim(OnlyNumber(Cmd.Params(0))) = '' then
                       ACBrNFe1.WebServices.Enviar.Lote := '1'
                    else
                       ACBrNFe1.WebServices.Enviar.Lote := OnlyNumber(Cmd.Params(0));
                  end;
                 ACBrNFe1.WebServices.Enviar.Executar ;

                 Cmd.Resposta :=  ACBrNFe1.WebServices.Enviar.Msg+sLineBreak+
                                 '[ENVIO]'+sLineBreak+
                                 'Versao='+ACBrNFe1.WebServices.Enviar.verAplic+sLineBreak+
                                 'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Enviar.TpAmb)+sLineBreak+
                                 'VerAplic='+ACBrNFe1.WebServices.Enviar.VerAplic+sLineBreak+
                                 'CStat='+IntToStr(ACBrNFe1.WebServices.Enviar.CStat)+sLineBreak+
                                 'XMotivo='+ACBrNFe1.WebServices.Enviar.XMotivo+sLineBreak+
                                 'CUF='+IntToStr(ACBrNFe1.WebServices.Enviar.CUF)+sLineBreak+
                                 'NRec='+ACBrNFe1.WebServices.Enviar.Recibo+sLineBreak+
                                 'DhRecbto='+DateTimeToStr(ACBrNFe1.WebServices.Enviar.dhRecbto)+sLineBreak+
                                 'TMed='+IntToStr(ACBrNFe1.WebServices.Enviar.TMed)+sLineBreak+
                                 'Msg='+ACBrNFe1.WebServices.Enviar.Msg+sLineBreak;

                 ACBrNFe1.WebServices.Retorno.Recibo := ACBrNFe1.WebServices.Enviar.Recibo;
                 ACBrNFe1.WebServices.Retorno.Executar;

                 Cmd.Resposta :=  Cmd.Resposta+
                                  ACBrNFe1.WebServices.Retorno.Msg+sLineBreak+
                                  '[RETORNO]'+sLineBreak+
                                  'Versao='+ACBrNFe1.WebServices.Retorno.verAplic+sLineBreak+
                                  'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Retorno.TpAmb)+sLineBreak+
                                  'VerAplic='+ACBrNFe1.WebServices.Retorno.VerAplic+sLineBreak+
                                  'NRec='+ACBrNFe1.WebServices.Retorno.NFeRetorno.nRec+sLineBreak+
                                  'CStat='+IntToStr(ACBrNFe1.WebServices.Retorno.CStat)+sLineBreak+
                                  'XMotivo='+ACBrNFe1.WebServices.Retorno.XMotivo+sLineBreak+
                                  'CUF='+IntToStr(ACBrNFe1.WebServices.Retorno.CUF)+sLineBreak;

                 for I:= 0 to ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Count-1 do
                  begin
                   for J:= 0 to ACBrNFe1.NotasFiscais.Count-1 do
                    begin
                     if 'NFe'+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].chNFe = ACBrNFe1.NotasFiscais.Items[j].NFe.InfNFe.Id  then
                      begin
                        Cmd.Resposta := Cmd.Resposta+
                                   '[NFE'+Trim(IntToStr(ACBrNFe1.NotasFiscais.Items[j].NFe.Ide.NNF))+']'+sLineBreak+
                                   'Versao='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].verAplic+sLineBreak+
                                   'TpAmb='+TpAmbToStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].tpAmb)+sLineBreak+
                                   'VerAplic='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].verAplic+sLineBreak+
                                   'CStat='+IntToStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].cStat)+sLineBreak+
                                   'XMotivo='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].xMotivo+sLineBreak+
                                   'CUF='+IntToStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.cUF)+sLineBreak+
                                   'ChNFe='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].chNFe+sLineBreak+
                                   'DhRecbto='+DateTimeToStr(ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].dhRecbto)+sLineBreak+
                                   'NProt='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].nProt+sLineBreak+
                                   'DigVal='+ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[i].digVal+sLineBreak+
                                   'Arquivo='+PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+StringReplace(ACBrNFe1.NotasFiscais.Items[j].NFe.infNFe.ID, 'NFe', '', [rfIgnoreCase])+'-nfe.xml'+sLineBreak;
                        if (Cmd.Params(2) = '1') and ACBrNFeDANFERave1.MostrarPreview then
                         begin
                           Restaurar1.Click;
                           Application.BringToFront;
                         end;

                        ConfiguraDANFe; 
                        ACBrNFe1.DANFE.Impressora := cbxImpressora.Text;
                        if ACBrNFe1.NotasFiscais.Items[i].Confirmada and (Cmd.Params(2) = '1') then
                         begin
                           ACBrNFe1.NotasFiscais.Items[i].Imprimir;
                         end;  
                        if (Cmd.Params(2) = '1') and ACBrNFeDANFERave1.MostrarPreview then
                           Ocultar1.Click;
                        break;
                      end;
                    end;
                  end;
               end;
            end;
         end

        else if (Cmd.Metodo = 'enviarevento') or  (Cmd.Metodo = 'cartadecorrecao') then
         begin
           Cmd.Resposta := '';
           ACBrNFe1.EventoNFe.Evento.Clear;

           GerarIniEvento( Cmd.Params(0), (Cmd.Metodo = 'cartadecorrecao') );

           ACBrNFe1.EnviarEventoNFe(ACBrNFe1.EventoNFe.idLote);

           Cmd.Resposta := Cmd.Resposta+sLineBreak+
                           'idLote='   +IntToStr(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.idLote)+sLineBreak+
                           'tpAmb='    +TpAmbToStr(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.tpAmb)+sLineBreak+
                           'verAplic=' +ACBrNFe1.WebServices.EnvEvento.EventoRetorno.verAplic+sLineBreak+
                           'cOrgao='   +IntToStr(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.cOrgao)+sLineBreak+
                           'cStat='    +IntToStr(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.cStat)+sLineBreak+
                           'xMotivo='  +ACBrNFe1.WebServices.EnvEvento.EventoRetorno.xMotivo+sLineBreak;

           for I:= 0 to ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Count-1 do
            begin

              Cmd.Resposta := Cmd.Resposta+sLineBreak+
               '[EVENTO'+Trim(IntToStrZero(I+1,3))+']'+sLineBreak+
               'id='        +ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[I].RetInfEvento.Id+sLineBreak+
               'tpAmb='     +TpAmbToStr(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[I].RetInfEvento.tpAmb)+sLineBreak+
               'verAplic='  +ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[I].RetInfEvento.verAplic+sLineBreak+
               'cOrgao='    +IntToStr(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[I].RetInfEvento.cOrgao)+sLineBreak+
               'cStat='     +IntToStr(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[I].RetInfEvento.cStat)+sLineBreak+
               'xMotivo='   +ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[I].RetInfEvento.xMotivo+sLineBreak+
               'chNFe='     +ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[I].RetInfEvento.chNFe+sLineBreak+
               'tpEvento='  +TpEventoToStr(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[I].RetInfEvento.tpEvento)+sLineBreak+
               'xEvento='   +ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[I].RetInfEvento.xEvento+sLineBreak+
               'nSeqEvento='+IntToStr(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[I].RetInfEvento.nSeqEvento)+sLineBreak+
               'CNPJDest='  +ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[I].RetInfEvento.CNPJDest+sLineBreak+
               'emailDest=' +ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[I].RetInfEvento.emailDest+sLineBreak+
               'dhRegEvento='+DateTimeToStr(ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[I].RetInfEvento.dhRegEvento)+sLineBreak+
               'nProt='     +ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[I].RetInfEvento.nProt+sLineBreak;
            end;
         end


        else if Cmd.Metodo = 'consultanfedest' then
         begin
           if not ValidarCNPJ(Cmd.Params(0)) then
              raise Exception.Create('CNPJ '+Cmd.Params(0)+' inv�lido.');

           try
              ACBrNFe1.ConsultaNFeDest(Cmd.Params(0),
                                       StrToIndicadorNFe(ok,Cmd.Params(1)),
                                       StrToIndicadorEmissor(ok,Cmd.Params(2)),
                                       Cmd.Params(3));

              Cmd.Resposta := Cmd.Resposta+sLineBreak+
                              'versao='   +ACBrNFe1.WebServices.ConsNFeDest.retConsNFeDest.versao+sLineBreak+
                              'tpAmb='    +TpAmbToStr(ACBrNFe1.WebServices.ConsNFeDest.retConsNFeDest.tpAmb)+sLineBreak+
                              'verAplic=' +ACBrNFe1.WebServices.ConsNFeDest.retConsNFeDest.verAplic+sLineBreak+
                              'cStat='    +IntToStr(ACBrNFe1.WebServices.ConsNFeDest.retConsNFeDest.cStat)+sLineBreak+
                              'xMotivo='  +ACBrNFe1.WebServices.ConsNFeDest.retConsNFeDest.xMotivo+sLineBreak+
                              'dhResp='   +DateTimeToStr(ACBrNFe1.WebServices.ConsNFeDest.retConsNFeDest.dhResp)+sLineBreak+
                              'indCont='  +IndicadorContinuacaoToStr(ACBrNFe1.WebServices.ConsNFeDest.retConsNFeDest.indCont)+sLineBreak+
                              'ultNSU='   +ACBrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ultNSU+sLineBreak;

              J := 1;
              for I:= 0 to AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Count-1 do
               begin
                 if Trim(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resNFe.chNFe) <> '' then
                  begin
                    Cmd.Resposta := Cmd.Resposta+sLineBreak+
                     '[RESNFE'+Trim(IntToStrZero(J,3))+']'+sLineBreak+
                     'NSU='     +AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resNFe.NSU+sLineBreak+
                     'chNFe='   +AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resNFe.chNFe+sLineBreak+
                     'CNPJ='    +AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resNFe.CNPJCPF+sLineBreak+
                     'xNome='   +AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resNFe.xNome+sLineBreak+
                     'IE='      +AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resNFe.IE+sLineBreak+
                     'dEmi='    +DateTimeToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resNFe.dEmi)+sLineBreak+
                     'tpNF='    +tpNFToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resNFe.tpNF)+sLineBreak+
                     'vNF='     +FloatToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resNFe.vNF)+sLineBreak+
                     'digVal='  +AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resNFe.digVal+sLineBreak+
                     'dhRecbto='+DateTimeToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resNFe.dhRecbto)+sLineBreak+
                     'cSitNFe=' +SituacaoNFeToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resNFe.cSitNFe)+sLineBreak+
                     'cSitConf='+SituacaoManifDestToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resNFe.cSitConf)+sLineBreak;
                     J := J + 1;
                  end;
               end;

              J := 1;
              for i := 0 to AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Count -1 do
               begin
                 if Trim(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCanc.chNFe) <> '' then
                  begin
                    Cmd.Resposta := Cmd.Resposta+sLineBreak+
                     '[RESCANC'+Trim(IntToStrZero(J,3))+']'+sLineBreak+
                     'NSU='     +AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCanc.NSU+sLineBreak+
                     'chNFe='   +AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCanc.chNFe+sLineBreak+
                     'CNPJ='    +AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCanc.CNPJCPF+sLineBreak+
                     'xNome='   +AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCanc.xNome+sLineBreak+
                     'IE='      +AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCanc.IE+sLineBreak+
                     'dEmi='    +DateTimeToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCanc.dEmi)+sLineBreak+
                     'tpNF='    +tpNFToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCanc.tpNF)+sLineBreak+
                     'vNF='     +FloatToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCanc.vNF)+sLineBreak+
                     'digVal='  +AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCanc.digVal+sLineBreak+
                     'dhRecbto='+DateTimeToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCanc.dhRecbto)+sLineBreak+
                     'cSitNFe=' +SituacaoNFeToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCanc.cSitNFe)+sLineBreak+
                     'cSitConf='+SituacaoManifDestToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCanc.cSitConf)+sLineBreak;
                     J := J + 1;
                  end;
               end;

              J := 1;
              for i := 0 to AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Count -1 do
               begin
                  if Trim(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCCe.chNFe) <> '' then
                   begin
                    Cmd.Resposta := Cmd.Resposta+sLineBreak+
                     '[RESCCE'+Trim(IntToStrZero(J,3))+']'+sLineBreak+
                     'NSU='       +AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCCe.NSU+sLineBreak+
                     'chNFe='     +AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCCe.chNFe+sLineBreak+
                     'dhEvento='  +DateTimeToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCCe.dhEvento)+sLineBreak+
                     'tpEvento='  +TpEventoToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCCe.tpEvento)+sLineBreak+
                     'nSeqEvento='+IntToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCCe.nSeqEvento)+sLineBreak+
                     'descEvento='+AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCCe.descEvento+sLineBreak+
                     'xCorrecao=' +AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCCe.xCorrecao+sLineBreak+
                     'tpNF='      +tpNFToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCCe.tpNF)+sLineBreak+
                     'dhRecbto='  +DateTimeToStr(AcbrNFe1.WebServices.ConsNFeDest.retConsNFeDest.ret.Items[i].resCCe.dhRecbto)+sLineBreak;
                     J := J + 1;
                   end;
               end;
           except
             on E: Exception do
              begin
                raise Exception.Create(AcbrNFe1.WebServices.ConsNFeDest.Msg+sLineBreak+E.Message);
              end;
           end;
         end

        else if Cmd.Metodo = 'downloadnfe' then
         begin
           if not ValidarCNPJ(Cmd.Params(0)) then
              raise Exception.Create('CNPJ '+Cmd.Params(0)+' inv�lido.');

           with ACBrNFe1.DownloadNFe do
             begin
              Download.CNPJ := Cmd.Params(0);

              if DFeUtil.NaoEstaVazio(Cmd.Params(1)) then
               begin
                 ChavesNFe:=TstringList.Create;
                 try
                    ChavesNFe.DelimitedText := sLineBreak;
                    ChavesNFe.Text := StringReplace(Cmd.Params(1),';',sLineBreak,[rfReplaceAll]);
                    Download.Chaves.Clear;
                    for I := 0 to ChavesNFe.Count - 1 do
                    begin
                       if not ValidarChave('NFe'+ChavesNFe.Strings[i]) then
                          raise Exception.Create('Chave '+ChavesNFe.Strings[i]+' inv�lida.');

                       with Download.Chaves.Add do
                       begin
                         chNFe := ChavesNFe.Strings[i];
                       end;
                    end;
                 finally
                    ChavesNFe.Free;
                 end;
               end;
             end;
           try
              ACBrNFe1.Download;

              Cmd.Resposta := ACBrNFe1.WebServices.DownloadNFe.Msg+sLineBreak+
                              '[DOWNLOADNFE]'+sLineBreak+
                              'versao='   +ACBrNFe1.WebServices.DownloadNFe.retDownloadNFe.versao+sLineBreak+
                              'tpAmb='    +TpAmbToStr(ACBrNFe1.WebServices.DownloadNFe.retDownloadNFe.tpAmb)+sLineBreak+
                              'verAplic=' +ACBrNFe1.WebServices.DownloadNFe.retDownloadNFe.verAplic+sLineBreak+
                              'cStat='    +IntToStr(ACBrNFe1.WebServices.DownloadNFe.retDownloadNFe.cStat)+sLineBreak+
                              'xMotivo='  +ACBrNFe1.WebServices.DownloadNFe.retDownloadNFe.xMotivo+sLineBreak+
                              'dhResp='   +DateTimeToStr(ACBrNFe1.WebServices.DownloadNFe.retDownloadNFe.dhResp)+sLineBreak;

              SL := TStringList.Create;
              try
                for i := 0 to ACBrNFe1.WebServices.DownloadNFe.retDownloadNFe.retNFe.Count -1 do
                 begin
                   ArqNFe := PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+
                             ACBrNFe1.WebServices.DownloadNFe.retDownloadNFe.retNFe.Items[i].chNFe+'-down-nfe.xml' ;
                   SL.Clear;
                   SL.Add(ACBrNFe1.WebServices.DownloadNFe.retDownloadNFe.retNFe.Items[i].procNFe);
                   SL.SaveToFile(ArqNFe);
                   Cmd.Resposta := Cmd.Resposta+sLineBreak+
                                   '[NFE'+Trim(IntToStrZero(I+1,3))+']'+sLineBreak+
                                   'ChNFe='+ACBrNFe1.WebServices.DownloadNFe.retDownloadNFe.retNFe.Items[i].chNFe+sLineBreak+
                                   'cStat='+IntToStr(ACBrNFe1.WebServices.DownloadNFe.retDownloadNFe.retNFe.Items[i].cStat)+sLineBreak+
                                   'xMotivo='+ACBrNFe1.WebServices.DownloadNFe.retDownloadNFe.retNFe.Items[i].xMotivo+sLineBreak+
                                   'Arquivo='+ArqNFe+sLineBreak+
                                   'procNFe='+SL.Text+sLineBreak;
                 end;
              finally
                SL.Free;
              end;
           except
             on E: Exception do
              begin
                raise Exception.Create(ACBrNFe1.WebServices.DownloadNFe.Msg+sLineBreak+E.Message);
              end;
           end;
         end

        else if Cmd.Metodo = 'enviaremail' then
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(1)) or FileExists(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(1)) then
            begin
              if FileExists(Cmd.Params(1)) then
               begin
                 ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(1));
                 ArqNFe := Cmd.Params(1);
               end
              else
               begin
                 ACBrNFe1.NotasFiscais.LoadFromFile(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(1));
                 ArqNFe := PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(1);
               end;
            end
           else
              raise Exception.Create('Arquivo '+Cmd.Params(1)+' n�o encontrado.');

           ConfiguraDANFe;
           MudouDANFe := False;

           if ACBrNFe1.DANFE = ACBrNFeDANFeESCPOS1 then
            begin
              MudouDANFe := True;
              OldDANFe := ACBrNFe1.DANFE;
              ACBrNFe1.DANFE := ACBrNFeDANFCeFortes1;
            end;

           if (Cmd.Params(2) = '1') then
            begin
              try
                 ACBrNFe1.NotasFiscais.ImprimirPDF;
                 if MudouDANFe then
                  begin
                    MudouDANFe := False;
                    ACBrNFe1.DANFE := OldDANFe;
                  end;

                 ArqPDF := OnlyNumber(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID);
                 ArqPDF := PathWithDelim(ACBrNFe1.DANFE.PathPDF)+ArqPDF+'-nfe.pdf';


              except
                 raise Exception.Create('Erro ao criar o arquivo PDF');
              end;
            end;
            try
               if rgEmailTipoEnvio.ItemIndex = 0 then
                  EnviarEmail(edtSmtpHost.Text, edtSmtpPort.Text, edtSmtpUser.Text, edtSmtpPass.Text, edtSmtpUser.Text, Cmd.Params(0),DFeUtil.SeSenao(DFeUtil.NaoEstaVazio(Cmd.Params(3)),Cmd.Params(3),edtEmailAssunto.Text), ArqNFe, ArqPDF, mmEmailMsg.Lines, cbEmailSSL.Checked, cbEmailTLS.Checked, Cmd.Params(4))
               else
                  EnviarEmailIndy(edtSmtpHost.Text, edtSmtpPort.Text, edtSmtpUser.Text, edtSmtpPass.Text, edtSmtpUser.Text, Cmd.Params(0),DFeUtil.SeSenao(DFeUtil.NaoEstaVazio(Cmd.Params(3)),Cmd.Params(3),edtEmailAssunto.Text), ArqNFe, ArqPDF, mmEmailMsg.Lines, cbEmailSSL.Checked, cbEmailTLS.Checked, Cmd.Params(4));
               Cmd.Resposta := 'Email enviado com sucesso';
            except
               on E: Exception do
                begin
                  raise Exception.Create('Erro ao enviar email'+sLineBreak+E.Message);
                end;
            end;
         end

        else if Cmd.Metodo = 'enviaremailevento' then
         begin
           ACBrNFe1.EventoNFe.Evento.Clear;
           if FileExists(Cmd.Params(1)) or FileExists(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(1)) then
            begin
              if FileExists(Cmd.Params(1)) then
               begin
                 ACBrNFe1.EventoNFe.LerXML(Cmd.Params(1));
                 ArqEvento := Cmd.Params(1);
               end
              else
               begin
                 ACBrNFe1.EventoNFe.LerXML(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(1));
                 ArqEvento := PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(1);
               end;
            end
           else
              raise Exception.Create('Arquivo '+Cmd.Params(1)+' n�o encontrado.');

           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(2)) or FileExists(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(2)) then
            begin
              if FileExists(Cmd.Params(2)) then
               begin
                 ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(2));
                 ArqNFe := Cmd.Params(2);
               end
              else
               begin
                 ACBrNFe1.NotasFiscais.LoadFromFile(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(2));
                 ArqNFe := PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(2);
               end;
            end
           else
            begin
              if DFeUtil.NaoEstaVazio(Cmd.Params(2)) then
                 raise Exception.Create('Arquivo '+Cmd.Params(2)+' n�o encontrado.');
            end;

           ConfiguraDANFe; 

           if (Cmd.Params(3) = '1') then
            begin
              try
                 ACBrNFe1.ImprimirEventoPDF;

                 ArqPDF := OnlyNumber(ACBrNFe1.EventoNFe.Evento[0].InfEvento.id);
                 ArqPDF := PathWithDelim(ACBrNFe1.DANFE.PathPDF)+ArqPDF+'-procEventoNFe.pdf';
              except
                 raise Exception.Create('Erro ao criar o arquivo PDF');
              end;
            end;
            try
               if rgEmailTipoEnvio.ItemIndex = 0 then
                  EnviarEmail(edtSmtpHost.Text, edtSmtpPort.Text, edtSmtpUser.Text, edtSmtpPass.Text, edtSmtpUser.Text, Cmd.Params(0),DFeUtil.SeSenao(DFeUtil.NaoEstaVazio(Cmd.Params(4)),Cmd.Params(4),edtEmailAssunto.Text), ArqEvento, ArqPDF, mmEmailMsg.Lines, cbEmailSSL.Checked, cbEmailTLS.Checked, Cmd.Params(5))
               else
                  EnviarEmailIndy(edtSmtpHost.Text, edtSmtpPort.Text, edtSmtpUser.Text, edtSmtpPass.Text, edtSmtpUser.Text, Cmd.Params(0),DFeUtil.SeSenao(DFeUtil.NaoEstaVazio(Cmd.Params(4)),Cmd.Params(4),edtEmailAssunto.Text), ArqEvento, ArqPDF, mmEmailMsg.Lines, cbEmailSSL.Checked, cbEmailTLS.Checked, Cmd.Params(5));
               Cmd.Resposta := 'Email enviado com sucesso';
            except
               on E: Exception do
                begin
                  raise Exception.Create('Erro ao enviar email'+sLineBreak+E.Message);
                end;
            end;
         end

        else if Cmd.Metodo = 'setcertificado' then
         begin
           if (Cmd.Params(0)<>'') then
            begin
             {$IFDEF ACBrNFeOpenSSL}
                ACBrNFe1.Configuracoes.Certificados.Certificado := Cmd.Params(0);
                ACBrNFe1.Configuracoes.Certificados.Senha       := Cmd.Params(1);
                edtCaminho.Text := ACBrNFe1.Configuracoes.Certificados.Certificado;
                edtSenha.Text   := ACBrNFe1.Configuracoes.Certificados.Senha;
             {$ELSE}
                ACBrNFe1.Configuracoes.Certificados.NumeroSerie := Cmd.Params(0);
                ACBrNFe1.Configuracoes.Certificados.Senha       := Cmd.Params(1);
                edtCaminho.Text := ACBrNFe1.Configuracoes.Certificados.NumeroSerie;
             {$ENDIF}
                frmAcbrNfeMonitor.SalvarIni;
            end
           else
              raise Exception.Create('Certificado '+Cmd.Params(0)+' Inv�lido.');
         end

        else if Cmd.Metodo = 'setambiente' then //1-Produ��o 2-Homologa��o
         begin
           if (StrToInt(Cmd.Params(0))>=1) and (StrToInt(Cmd.Params(0))<=2) then
            begin
              ACBrNFe1.Configuracoes.WebServices.Ambiente := StrToTpAmb(OK, Cmd.Params(0));
              rgTipoAmb.ItemIndex := ACBrNFe1.Configuracoes.WebServices.AmbienteCodigo-1;
              frmAcbrNfeMonitor.SalvarIni;
            end
           else
              raise Exception.Create('Ambiente Inv�lido.');
         end

        else if Cmd.Metodo = 'setformaemissao' then //1-Normal 2-Contingencia 3-SCAN 4-DPEC 5-FSDA
         begin
           if cbModoEmissao.checked then
             exit;
             
           if (StrToInt(Cmd.Params(0))>=1) and (StrToInt(Cmd.Params(0))<=9) then
            begin
              ACBrNFe1.Configuracoes.Geral.FormaEmissao := StrToTpEmis(OK, Cmd.Params(0));
              rgFormaEmissao.ItemIndex := ACBrNFe1.Configuracoes.Geral.FormaEmissaoCodigo-1;
              frmAcbrNfeMonitor.SalvarIni;
            end
           else
              raise Exception.Create('Forma de Emiss�o Inv�lida.');
         end

        else if Cmd.Metodo = 'setversaodf' then //2.00 3.00 3.10
         begin
            VersaoDF := StrToVersaoDF(OK, Cmd.Params(0));
            if OK then
             begin
               ACBrNFe1.Configuracoes.Geral.VersaoDF := VersaoDF;
               cbVersaoWS.ItemIndex := cbVersaoWS.Items.IndexOf(Cmd.Params(0)) ;
               frmAcbrNfeMonitor.SalvarIni;
             end
            else
              raise Exception.Create('Vers�o Inv�lida.');
         end

        else if Cmd.Metodo = 'setmodelodf' then //55 65
         begin
            ModeloDF := StrToModeloDF(OK, Cmd.Params(0));
            if OK then
               ACBrNFe1.Configuracoes.Geral.ModeloDF := ModeloDF
            else
              raise Exception.Create('Modelo Inv�lido(55/65).');
         end

        else if Cmd.Metodo = 'settoken' then
         begin
           ACBrNFe1.Configuracoes.Geral.Token := Cmd.Params(0);
           if (Cmd.Params(1) <> '') then
              ACBrNFe1.Configuracoes.Geral.IdToken := Cmd.Params(1);
           frmAcbrNfeMonitor.SalvarIni;
         end

        else if Cmd.Metodo = 'setidtoken' then
         begin
           ACBrNFe1.Configuracoes.Geral.IdToken := Cmd.Params(0);
           if (Cmd.Params(1) <> '') then
              ACBrNFe1.Configuracoes.Geral.Token := Cmd.Params(1);
           frmAcbrNfeMonitor.SalvarIni;
         end

        else if Cmd.Metodo = 'lernfe' then
         begin
           try
              Cmd.Resposta := GerarNFeIni( Cmd.Params(0)  )
           except
               on E: Exception do
                begin
                  raise Exception.Create('Erro ao gerar INI da NFe.'+sLineBreak+E.Message);
                end;
           end;
         end

        else if Cmd.Metodo = 'nfetotxt' then  //1-Arquivo XML, 2-NomeArqTXT
         begin
           ACBrNFe1.NotasFiscais.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrNFe1.NotasFiscais.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' n�o encontrado.');

           ACBrNFe1.NotasFiscais.Items[0].SaveToFile(Cmd.Params(1),True);
           Cmd.Resposta := ChangeFileExt(ACBrNFe1.NotasFiscais.Items[0].NomeArq,'.txt');
         end

        else if Cmd.Metodo = 'savetofile' then
         begin
           Lines := TStringList.Create ;
           try
              Lines.Clear ;
              Lines.Text := ConvertStrRecived( cmd.Params(1) );
              Lines.SaveToFile( Cmd.Params(0) );
           finally
              Lines.Free ;
           end ;
         end

        else if Cmd.Metodo = 'loadfromfile' then
         begin
           Files := Cmd.Params(0) ;
           dtFim := IncSecond(now, StrToIntDef(Cmd.Params(1),1) ) ;
           while now <= dtFim do
           begin
              if FileExists( Files ) then
              begin
                 Lines  := TStringList.Create ;
                 try
                    Lines.Clear ;
                    Lines.LoadFromFile( Files ) ;
                    Cmd.Resposta := Lines.Text ;
                    Break ;
                 finally
                    Lines.Free ;
                 end ;
              end ;

              {$IFNDEF NOGUI}
               Application.ProcessMessages ;
              {$ENDIF}
              sleep(100) ;
           end ;

           if not FileExists( Cmd.Params(0) ) then
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' n�o encontrado')
         end

        else if Cmd.Metodo = 'fileexists' then
         begin
           if not FileExists( Cmd.Params(0) ) then
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' n�o encontrado')
         end


        else if ((Cmd.Metodo = 'certificadodatavencimento') or (Cmd.Metodo = 'datavencimentocertificado')) then
         begin
           {$IFDEF ACBrNFeOpenSSL}
              Cmd.Resposta := 'Fun��o dispon�vel apenas na vers�o CAPICOM'
           {$ELSE}
              Cmd.Resposta := DateToStr(ACBrNFe1.Configuracoes.Certificados.DataVenc);
           {$ENDIF}
         end

        else if Cmd.Metodo = 'cnpjcertificado' then
         begin
           {$IFDEF ACBrNFeOpenSSL}
              Cmd.Resposta := 'Fun��o dispon�vel apenas na vers�o CAPICOM'
           {$ELSE}
              Cmd.Resposta := ACBrNFe1.Configuracoes.Certificados.CNPJ;
           {$ENDIF}
         end

        else if Cmd.Metodo = 'lerini' then // Recarrega configura��es do arquivo INI
           frmAcbrNfeMonitor.LerIni

        else if Cmd.Metodo = 'gerarchave' then
         begin
           GerarChave(Chave,
                      StrToInt(Cmd.Params(0)), //codigoUF
                      StrToInt(Cmd.Params(1)), //codigoNumerico
                      StrToInt(Cmd.Params(2)), //modelo
                      StrToInt(Cmd.Params(3)), //serie
                      StrToInt(Cmd.Params(4)), //numero
                      StrToInt(Cmd.Params(5)), //tpemi
                      DFeUtil.StringToDate(Cmd.Params(6)), //emissao
                      Cmd.Params(7)); //CNPJ
           Cmd.Resposta := Chave;
         end

        else if cmd.Metodo = 'getpathnfe' then
           Cmd.Resposta := ACBrNFe1.Configuracoes.Arquivos.GetPathNFe

        else if Cmd.Metodo = 'getpathcce' then // Retorna Path onde est� sendo salvo o xml das CCEs
           Cmd.Resposta := ACBrNFe1.Configuracoes.Arquivos.GetPathCCe

        else if Cmd.Metodo = 'getpathcan' then // Path Eventos de cancelamento
           Cmd.Resposta := ACBrNFe1.Configuracoes.Arquivos.GetPathCan

        else if Cmd.Metodo = 'getpathevento' then
           Cmd.Resposta := ACBrNFe1.Configuracoes.Arquivos.GetPathEvento( TpcnTpEvento(StrToInt(Cmd.Params(0))) )

        else if Cmd.Metodo = 'imprimirrelatorio' then
         begin
           ConfiguraDANFe;

           if rgModeloDANFeNFCE.ItemIndex <> 1  then
               raise Exception.Create('Comando dispon�vel apenas para o DANFe modelo DANFe ESCPOS');



           MemoTXT := TMemo.Create(frmAcbrNfeMonitor) ;
           try
              MemoTXT.Clear ;
              MemoTXT.Text := ConvertStrRecived( cmd.Params(1) );
              if not ACBrNFeDANFeESCPOS1.Device.Ativo then
                 ACBrNFeDANFeESCPOS1.Device.Ativar;
              ACBrNFeDANFeESCPOS1.ImprimirRelatorio(MemoTXT.Lines);
           finally
              MemoTXT.Free ;
           end ;

         end

        else if Cmd.Metodo = 'restaurar' then
           Restaurar1Click( frmAcbrNfeMonitor )

        else if Cmd.Metodo = 'ocultar' then
           Ocultar1Click( frmAcbrNfeMonitor )

        else if Cmd.Metodo = 'encerrarmonitor' then
           Application.Terminate

        else if Cmd.Metodo = 'ativo' then
           Cmd.Resposta := 'Ativo'

        else if Cmd.Metodo = 'versao' then
           Cmd.Resposta := Versao
        else if Cmd.Metodo ='datahora' then
           Cmd.Resposta := FormatDateTime('dd/mm/yyyy hh:nn:ss', Now )
        else if Cmd.Metodo ='data' then
           Cmd.Resposta := FormatDateTime('dd/mm/yyyy', Now )
        else if Cmd.Metodo ='hora' then
           Cmd.Resposta := FormatDateTime('hh:nn:ss', Now )
        else if Cmd.Metodo = 'versaonome' then
           Cmd.Resposta := {$IFDEF ACBrNFeOpenSSL} 'OpenSSL' {$ELSE} 'CAPICOM' {$ENDIF}

        else if pos('|'+Cmd.Metodo+'|', '|exit|bye|fim|sair|') > 0 then {fecha conexao}
         begin
           Cmd.Resposta := 'Obrigado por usar o ACBrNFeMonitor' ;
           mCmd.Lines.Clear;

           if Assigned( Conexao ) then
             Conexao.CloseSocket ;
         end


        else //Else Final - Se chegou ate aqui, o comando � inv�lido
           raise Exception.Create('Comando inv�lido ('+Cmd.Comando+')') ;

     finally
         if wDiretorioAtual <> GetCurrentDir then
           SetCurrentDir(wDiretorioAtual);
     end ;
  end;
end ;

Function ConvertStrRecived( AStr: String ) : String ;
 Var P   : Integer ;
     Hex : String ;
     CharHex : Char ;
begin
  { Verificando por codigos em Hexa }
  Result := AStr ;

  P := pos('\x',Result) ;
  while P > 0 do
  begin
     Hex := copy(Result,P+2,2) ;

     try
        CharHex := Chr(StrToInt('$'+Hex)) ;
     except
        CharHex := ' ' ;
     end ;

     Result := StringReplace(Result,'\x'+Hex,CharHex,[rfReplaceAll]) ;
     P      := pos('\x',Result) ;
  end ;
end ;

function UFparaCodigo(const UF: string): integer;
const
  (**)UFS = '.AC.AL.AP.AM.BA.CE.DF.ES.GO.MA.MT.MS.MG.PA.PB.PR.PE.PI.RJ.RN.RS.RO.RR.SC.SP.SE.TO.';
  CODIGOS = '.12.27.16.13.29.23.53.32.52.21.51.50.31.15.25.41.26.22.33.24.43.11.14.42.35.28.17.';
begin
  try
    result := StrToInt(copy(CODIGOS, pos('.' + UF + '.', UFS) + 1, 2));
  except
    result := 0;
  end;
end;

function ObterCodigoMunicipio(const xMun, xUF: string): integer;
var
  i: integer;
  PathArquivo: string;
  List: TstringList;
begin
  result := 0;
  PathArquivo :=  PathWithDelim(ExtractFilePath(Application.ExeName))+ 'MunIBGE'+PathDelim+'MunIBGE-UF' + InttoStr(UFparaCodigo(xUF)) + '.txt';
  if FileExists(PathArquivo) then
   begin
     List := TstringList.Create;
     List.LoadFromFile(PathArquivo);
     i := 0;
     while (i < list.count) and (result = 0) do
      begin
       if pos(UpperCase(TiraAcentos(xMun)), UpperCase(TiraAcentos(List[i]))) > 0 then
          result := StrToInt(Trim(copy(list[i],1,7)));
       inc(i);
      end;
     List.free;
   end;
end;

procedure GerarIniNFe( AStr: WideString ) ;
var
  I, J, K : Integer;
  versao, sSecao, sFim, sCodPro, sNumeroDI, sNumeroADI, sQtdVol,
  sNumDup, sCampoAdic, sTipo, sDia, sDeduc, sNVE : String;
  INIRec : TMemIniFile ;
  SL     : TStringList;
  OK     : boolean;
  TributosFonte : String;
begin
 INIRec := TMemIniFile.create( 'nfe.ini' ) ;
 SL := TStringList.Create;
 if FilesExists(Astr) then
    SL.LoadFromFile(AStr)
 else
    Sl.Text := ConvertStrRecived( Astr );
 INIRec.SetStrings( SL );
 SL.Free ;
 with frmAcbrNfeMonitor do
  begin
   try
      ACBrNFe1.NotasFiscais.Clear;
      with ACBrNFe1.NotasFiscais.Add.NFe do
       begin
         versao        :=                   INIRec.ReadString('infNFe','versao', VersaoDFToStr(ACBrNFe1.Configuracoes.Geral.VersaoDF));
         infNFe.versao := StringToFloatDef( INIRec.ReadString('infNFe','versao', VersaoDFToStr(ACBrNFe1.Configuracoes.Geral.VersaoDF)),0) ;

         versao := infNFe.VersaoStr;
         versao := StringReplace(versao,'versao="','',[rfReplaceAll,rfIgnoreCase]);
         versao := StringReplace(versao,'"','',[rfReplaceAll,rfIgnoreCase]);

         Ide.cNF        := INIRec.ReadInteger( 'Identificacao','Codigo' ,INIRec.ReadInteger( 'Identificacao','cNF' ,0));
         Ide.natOp      := INIRec.ReadString(  'Identificacao','NaturezaOperacao' ,INIRec.ReadString(  'Identificacao','natOp' ,''));
         Ide.indPag     := StrToIndpag(OK,INIRec.ReadString( 'Identificacao','FormaPag',INIRec.ReadString( 'Identificacao','indPag','0')));
         Ide.modelo     := INIRec.ReadInteger( 'Identificacao','Modelo' ,INIRec.ReadInteger( 'Identificacao','mod' ,55));
         ACBrNFe1.Configuracoes.Geral.ModeloDF := StrToModeloDF(OK,IntToStr(Ide.modelo));
         ACBrNFe1.Configuracoes.Geral.VersaoDF := StrToVersaoDF(OK,versao);
         Ide.serie      := INIRec.ReadInteger( 'Identificacao','Serie'  ,1);
         Ide.nNF        := INIRec.ReadInteger( 'Identificacao','Numero' ,INIRec.ReadInteger( 'Identificacao','nNF' ,0));
         Ide.dEmi       := NotaUtil.StringToDateTime(INIRec.ReadString( 'Identificacao','Emissao',INIRec.ReadString( 'Identificacao','dEmi',INIRec.ReadString( 'Identificacao','dhEmi','0'))));
         Ide.dSaiEnt    := NotaUtil.StringToDateTime(INIRec.ReadString( 'Identificacao','Saida'  ,INIRec.ReadString( 'Identificacao','dSaiEnt'  ,'0')));
         Ide.hSaiEnt    := DFeUtil.StringToTime(INIRec.ReadString( 'Identificacao','hSaiEnt','0'));  //NFe2
         Ide.tpNF       := StrToTpNF(OK,INIRec.ReadString( 'Identificacao','Tipo',INIRec.ReadString( 'Identificacao','tpNF','1')));

         Ide.idDest     := StrToDestinoOperacao(OK,INIRec.ReadString( 'Identificacao','idDest','1'));

         Ide.tpImp      := StrToTpImp(  OK, INIRec.ReadString( 'Identificacao','tpImp',TpImpToStr(ACBrNFe1.DANFE.TipoDANFE)));  //NFe2
         Ide.tpEmis     := StrToTpEmis( OK,INIRec.ReadString( 'Identificacao','tpemis',IntToStr(ACBrNFe1.Configuracoes.Geral.FormaEmissaoCodigo)));
//         Ide.cDV
//         Ide.tpAmb
         Ide.finNFe     := StrToFinNFe( OK,INIRec.ReadString( 'Identificacao','Finalidade',INIRec.ReadString( 'Identificacao','finNFe','0')));
         Ide.indFinal   := StrToConsumidorFinal(OK,INIRec.ReadString( 'Identificacao','indFinal','0'));
         Ide.indPres    := StrToPresencaComprador(OK,INIRec.ReadString( 'Identificacao','indPres','0'));

         Ide.procEmi    := StrToProcEmi(OK,INIRec.ReadString( 'Identificacao','procEmi','0')); //NFe2
         Ide.verProc    := INIRec.ReadString(  'Identificacao','verProc' ,'ACBrNFeMonitor2' );
         Ide.dhCont     := NotaUtil.StringToDateTime(INIRec.ReadString( 'Identificacao','dhCont'  ,'0')); //NFe2
         Ide.xJust      := INIRec.ReadString(  'Identificacao','xJust' ,'' ); //NFe2

         I := 1 ;
         while true do
          begin
            sSecao := 'NFRef'+IntToStrZero(I,3) ;
            sFim   := INIRec.ReadString(  sSecao,'Tipo'  ,'FIM');
            sTipo := UpperCase(INIRec.ReadString(  sSecao,'Tipo'  ,'NFe')); //NFe2 NF NFe NFP CTe ECF)            
            if (sFim = 'FIM') or (Length(sFim) <= 0) then
             begin
               if INIRec.ReadString(sSecao,'refNFe','') <> '' then
                  sTipo := 'NFE'
               else if INIRec.ReadString(  sSecao,'refCTe'  ,'') <> '' then
                  sTipo := 'CTE'
               else if INIRec.ReadString(  sSecao,'nECF'  ,'') <> '' then
                  sTipo :=  'ECF'
               else if INIRec.ReadString(  sSecao,'IE'    ,'') <> '' then
                  sTipo := 'NFP'
               else if INIRec.ReadString(  sSecao,'CNPJ'  ,'') <> '' then
                  sTipo := 'NF';
               break ;
             end;

            with Ide.NFref.Add do
             begin
               if sTipo = 'NFE' then
                  refNFe :=  INIRec.ReadString(sSecao,'refNFe','')
               else if sTipo = 'NF' then
                begin
                  RefNF.cUF    := INIRec.ReadInteger( sSecao,'cUF'   ,0);
                  RefNF.AAMM   := INIRec.ReadString(  sSecao,'AAMM'  ,'');
                  RefNF.CNPJ   := INIRec.ReadString(  sSecao,'CNPJ'  ,'');
                  RefNF.modelo := INIRec.ReadInteger( sSecao,'Modelo',INIRec.ReadInteger( sSecao,'mod',0));
                  RefNF.serie  := INIRec.ReadInteger( sSecao,'Serie' ,0);
                  RefNF.nNF    := INIRec.ReadInteger( sSecao,'nNF'   ,0);
                end
               else if sTipo = 'NFP' then
                begin
                  RefNFP.cUF    := INIRec.ReadInteger( sSecao,'cUF'   ,0);
                  RefNFP.AAMM   := INIRec.ReadString(  sSecao,'AAMM'  ,'');
                  RefNFP.CNPJCPF:= INIRec.ReadString(  sSecao,'CNPJ'  ,INIRec.ReadString(sSecao,'CPF',INIRec.ReadString(sSecao,'CNPJCPF','')));
                  RefNFP.IE     := INIRec.ReadString(  sSecao,'IE'    ,'');
                  RefNFP.Modelo := INIRec.ReadString(  sSecao,'Modelo',INIRec.ReadString(  sSecao,'mod',''));
                  RefNFP.serie  := INIRec.ReadInteger( sSecao,'Serie' ,0);
                  RefNFP.nNF    := INIRec.ReadInteger( sSecao,'nNF'   ,0);
                end
               else if sTipo = 'CTE' then
                  refCTe         := INIRec.ReadString(  sSecao,'refCTe'  ,'')
               else if sTipo = 'ECF' then
                begin
                  RefECF.modelo := StrToECFModRef(ok,INIRec.ReadString(  sSecao,'ModECF'  ,INIRec.ReadString(  sSecao,'mod'  ,''))) ;
                  RefECF.nECF   := INIRec.ReadString(  sSecao,'nECF'  ,'');
                  RefECF.nCOO   := INIRec.ReadString(  sSecao,'nCOO'  ,'');
                end;
             end;
            Inc(I);
          end;

         Emit.CNPJCPF           := INIRec.ReadString(  'Emitente','CNPJ'    ,INIRec.ReadString(  'Emitente','CNPJCPF'    ,''));
         Emit.xNome             := INIRec.ReadString(  'Emitente','Razao'   ,INIRec.ReadString(  'Emitente','xNome'   ,''));
         Emit.xFant             := INIRec.ReadString(  'Emitente','Fantasia',INIRec.ReadString(  'Emitente','xFant',''));
         Emit.IE                := INIRec.ReadString(  'Emitente','IE'      ,'');
         Emit.IEST              := INIRec.ReadString(  'Emitente','IEST','');
         Emit.IM                := INIRec.ReadString(  'Emitente','IM'  ,'');
         Emit.CNAE              := INIRec.ReadString(  'Emitente','CNAE','');
         Emit.CRT               := StrToCRT(ok, INIRec.ReadString(  'Emitente','CRT','3')); //NFe2

         Emit.EnderEmit.xLgr    := INIRec.ReadString(  'Emitente','Logradouro' ,INIRec.ReadString(  'Emitente','xLgr' ,''));
         if (INIRec.ReadString(  'Emitente','Numero'     ,'') <> '') or (INIRec.ReadString(  'Emitente','nro'     ,'') <> '') then
            Emit.EnderEmit.nro     := INIRec.ReadString(  'Emitente','Numero'     ,INIRec.ReadString(  'Emitente','nro'     ,''));
         if (INIRec.ReadString(  'Emitente','Complemento'     ,'') <> '') or (INIRec.ReadString(  'Emitente','xCpl'     ,'') <> '') then
            Emit.EnderEmit.xCpl    := INIRec.ReadString(  'Emitente','Complemento',INIRec.ReadString(  'Emitente','xCpl'     ,''));
         Emit.EnderEmit.xBairro := INIRec.ReadString(  'Emitente','Bairro'     ,INIRec.ReadString(  'Emitente','xBairro',''));
         Emit.EnderEmit.cMun    := INIRec.ReadInteger( 'Emitente','CidadeCod'  ,INIRec.ReadInteger( 'Emitente','cMun'   ,0));
         Emit.EnderEmit.xMun    := INIRec.ReadString(  'Emitente','Cidade'     ,INIRec.ReadString(  'Emitente','xMun'   ,''));
         Emit.EnderEmit.UF      := INIRec.ReadString(  'Emitente','UF'         ,'');
         Emit.EnderEmit.CEP     := INIRec.ReadInteger( 'Emitente','CEP'  ,0);
         if Emit.EnderEmit.cMun <= 0 then
            Emit.EnderEmit.cMun := ObterCodigoMunicipio(Emit.EnderEmit.xMun,Emit.EnderEmit.UF);
         Emit.EnderEmit.cPais   := INIRec.ReadInteger( 'Emitente','PaisCod'    ,INIRec.ReadInteger( 'Emitente','cPais'    ,1058));
         Emit.EnderEmit.xPais   := INIRec.ReadString(  'Emitente','Pais'       ,INIRec.ReadString(  'Emitente','xPais'    ,'BRASIL'));
         Emit.EnderEmit.fone    := INIRec.ReadString(  'Emitente','Fone' ,'');

         Ide.cUF       := INIRec.ReadInteger( 'Identificacao','cUF'       ,UFparaCodigo(Emit.EnderEmit.UF));
         Ide.cMunFG    := INIRec.ReadInteger( 'Identificacao','CidadeCod' ,INIRec.ReadInteger( 'Identificacao','cMunFG' ,Emit.EnderEmit.cMun));

         if INIRec.ReadString(  'Avulsa','CNPJ','') <> '' then
          begin
            Avulsa.CNPJ    := INIRec.ReadString(  'Avulsa','CNPJ','');
            Avulsa.xOrgao  := INIRec.ReadString(  'Avulsa','xOrgao','');
            Avulsa.matr    := INIRec.ReadString(  'Avulsa','matr','');
            Avulsa.xAgente := INIRec.ReadString(  'Avulsa','xAgente','');
            Avulsa.fone    := INIRec.ReadString(  'Avulsa','fone','');
            Avulsa.UF      := INIRec.ReadString(  'Avulsa','UF','');
            Avulsa.nDAR    := INIRec.ReadString(  'Avulsa','nDAR','');
            Avulsa.dEmi    := DFeUtil.StringToDate(INIRec.ReadString(  'Avulsa','dEmi','0'));
            Avulsa.vDAR    := StringToFloatDef(INIRec.ReadString(  'Avulsa','vDAR',''),0);
            Avulsa.repEmi  := INIRec.ReadString(  'Avulsa','repEmi','');
            Avulsa.dPag    := DFeUtil.StringToDate(INIRec.ReadString(  'Avulsa','dPag','0'));
          end;

         Dest.idEstrangeiro     := INIRec.ReadString(  'Destinatario','idEstrangeiro','');
         Dest.CNPJCPF           := INIRec.ReadString(  'Destinatario','CNPJ'       ,INIRec.ReadString(  'Destinatario','CNPJCPF',INIRec.ReadString(  'Destinatario','CPF','')));
         Dest.xNome             := INIRec.ReadString(  'Destinatario','NomeRazao'  ,INIRec.ReadString(  'Destinatario','xNome'  ,''));
         Dest.indIEDest         := StrToindIEDest(OK,INIRec.ReadString( 'Destinatario','indIEDest','1'));
         Dest.IE                := INIRec.ReadString(  'Destinatario','IE'         ,'');
         Dest.ISUF              := INIRec.ReadString(  'Destinatario','ISUF'       ,'');
         Dest.Email             := INIRec.ReadString(  'Destinatario','Email'      ,'');  //NFe2

         Dest.EnderDest.xLgr    := INIRec.ReadString(  'Destinatario','Logradouro' ,INIRec.ReadString(  'Destinatario','xLgr' ,''));
         if (INIRec.ReadString('Destinatario','Numero','') <> '') or (INIRec.ReadString('Destinatario','nro','') <> '') then
            Dest.EnderDest.nro     := INIRec.ReadString(  'Destinatario','Numero'     ,INIRec.ReadString('Destinatario','nro',''));
         if (INIRec.ReadString('Destinatario','Complemento','') <> '') or (INIRec.ReadString('Destinatario','xCpl','') <> '') then
            Dest.EnderDest.xCpl    := INIRec.ReadString(  'Destinatario','Complemento',INIRec.ReadString('Destinatario','xCpl',''));
         Dest.EnderDest.xBairro := INIRec.ReadString(  'Destinatario','Bairro'     ,INIRec.ReadString(  'Destinatario','xBairro',''));
         Dest.EnderDest.cMun    := INIRec.ReadInteger( 'Destinatario','CidadeCod'  ,INIRec.ReadInteger( 'Destinatario','cMun'   ,0));
         Dest.EnderDest.xMun    := INIRec.ReadString(  'Destinatario','Cidade'     ,INIRec.ReadString(  'Destinatario','xMun'   ,''));
         Dest.EnderDest.UF      := INIRec.ReadString(  'Destinatario','UF'         ,'');
         Dest.EnderDest.CEP     := INIRec.ReadInteger( 'Destinatario','CEP'       ,0);
         if Dest.EnderDest.cMun <= 0 then
            Dest.EnderDest.cMun := ObterCodigoMunicipio(Dest.EnderDest.xMun,Dest.EnderDest.UF);
         Dest.EnderDest.cPais   := INIRec.ReadInteger( 'Destinatario','PaisCod'    ,INIRec.ReadInteger('Destinatario','cPais',1058));
         Dest.EnderDest.xPais   := INIRec.ReadString(  'Destinatario','Pais'       ,INIRec.ReadString( 'Destinatario','xPais','BRASIL'));
         Dest.EnderDest.Fone    := INIRec.ReadString(  'Destinatario','Fone'       ,'');

         if INIRec.ReadString(  'Retirada','CNPJ','') <> '' then
          begin
            Retirada.CNPJCPF := INIRec.ReadString( 'Retirada','CNPJ',INIRec.ReadString( 'Retirada','CPF',INIRec.ReadString( 'Retirada','CNPJCPF',''))); //NFe2
            Retirada.xLgr    := INIRec.ReadString( 'Retirada','xLgr','');
            Retirada.nro     := INIRec.ReadString( 'Retirada','nro' ,'');
            Retirada.xCpl    := INIRec.ReadString( 'Retirada','xCpl','');
            Retirada.xBairro := INIRec.ReadString( 'Retirada','xBairro','');
            Retirada.cMun    := INIRec.ReadInteger('Retirada','cMun',0);
            Retirada.xMun    := INIRec.ReadString( 'Retirada','xMun','');
            Retirada.UF      := INIRec.ReadString( 'Retirada','UF'  ,'');
            if Retirada.cMun <= 0 then
               Retirada.cMun := ObterCodigoMunicipio(Retirada.xMun,Retirada.UF);

          end;

         if INIRec.ReadString(  'Entrega','CNPJ','') <> '' then
          begin
            Entrega.CNPJCPF := INIRec.ReadString(  'Entrega','CNPJ',INIRec.ReadString(  'Entrega','CPF',INIRec.ReadString(  'Entrega','CNPJCPF',''))); //NFe2
            Entrega.xLgr    := INIRec.ReadString(  'Entrega','xLgr','');
            Entrega.nro     := INIRec.ReadString(  'Entrega','nro' ,'');
            Entrega.xCpl    := INIRec.ReadString(  'Entrega','xCpl','');
            Entrega.xBairro := INIRec.ReadString(  'Entrega','xBairro','');
            Entrega.cMun    := INIRec.ReadInteger( 'Entrega','cMun',0);
            Entrega.xMun    := INIRec.ReadString(  'Entrega','xMun','');
            Entrega.UF      := INIRec.ReadString(  'Entrega','UF','');
            if Entrega.cMun <= 0 then
               Entrega.cMun := ObterCodigoMunicipio(Entrega.xMun,Entrega.UF);
          end;

        I := 1 ;
         while true do
          begin
            sSecao := 'autXML'+IntToStrZero(I,3) ;
            sFim   := INIRec.ReadString( sSecao ,'CNPJ',INIRec.ReadString(  sSecao,'CPF',INIRec.ReadString(  sSecao,'CNPJCPF','FIM')));
            if (sFim = 'FIM') or (Length(sFim) <= 0) then
               break ;

            with autXML.Add do
             begin
               CNPJCPF := sFim;
             end;
            Inc(I);
          end;

         I := 1 ;

         while true do
          begin
            sSecao    := 'Produto'+IntToStrZero(I,3) ;
            sCodPro   := INIRec.ReadString(sSecao,'Codigo',INIRec.ReadString( sSecao,'cProd','FIM')) ;
            if sCodPro = 'FIM' then
               break ;

            with Det.Add do
             begin
               Prod.nItem := I;
               infAdProd      := INIRec.ReadString(sSecao,'infAdProd','');

               Prod.cProd    := INIRec.ReadString( sSecao,'Codigo'   ,INIRec.ReadString( sSecao,'cProd'   ,''));
               if (Length(INIRec.ReadString( sSecao,'EAN','')) > 0) or (Length(INIRec.ReadString( sSecao,'cEAN','')) > 0)  then
                  Prod.cEAN      := INIRec.ReadString( sSecao,'EAN'      ,INIRec.ReadString( sSecao,'cEAN'      ,''));
               Prod.xProd    := INIRec.ReadString( sSecao,'Descricao',INIRec.ReadString( sSecao,'xProd',''));
               Prod.NCM       := INIRec.ReadString( sSecao,'NCM'      ,'');
//               Prod.NVE       := INIRec.ReadString( sSecao,'NVE'      ,'');
               Prod.EXTIPI       := INIRec.ReadString( sSecao,'EXTIPI'      ,'');
               Prod.CFOP     := INIRec.ReadString( sSecao,'CFOP'     ,'');
               Prod.uCom     := INIRec.ReadString( sSecao,'Unidade'  ,INIRec.ReadString( sSecao,'uCom'  ,''));
               Prod.qCom     := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade'   ,INIRec.ReadString(sSecao,'qCom'  ,'')) ,0) ;
               Prod.vUnCom   := StringToFloatDef( INIRec.ReadString(sSecao,'ValorUnitario',INIRec.ReadString(sSecao,'vUnCom','')) ,0) ;
               Prod.vProd    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorTotal'   ,INIRec.ReadString(sSecao,'vProd' ,'')) ,0) ;

               if Length(INIRec.ReadString( sSecao,'cEANTrib','')) > 0 then
                  Prod.cEANTrib      := INIRec.ReadString( sSecao,'cEANTrib'      ,'');
               Prod.uTrib     := INIRec.ReadString( sSecao,'uTrib'  , Prod.uCom);
               Prod.qTrib     := StringToFloatDef( INIRec.ReadString(sSecao,'qTrib'  ,''), Prod.qCom);
               Prod.vUnTrib   := StringToFloatDef( INIRec.ReadString(sSecao,'vUnTrib','') ,Prod.vUnCom) ;

               Prod.vFrete    := StringToFloatDef( INIRec.ReadString(sSecao,'vFrete','') ,0) ;
               Prod.vSeg      := StringToFloatDef( INIRec.ReadString(sSecao,'vSeg','') ,0) ;
               Prod.vDesc     := StringToFloatDef( INIRec.ReadString(sSecao,'ValorDesconto',INIRec.ReadString(sSecao,'vDesc','')) ,0) ;
               Prod.vOutro    := StringToFloatDef( INIRec.ReadString(sSecao,'vOutro','') ,0) ; //NFe2
               Prod.IndTot    := StrToindTot(OK,INIRec.ReadString(sSecao,'indTot','1'));       //NFe2

               Prod.xPed      := INIRec.ReadString( sSecao,'xPed'    ,'');  //NFe2
               Prod.nItemPed  := INIRec.ReadInteger( sSecao,'nItemPed',0);  //NFe2
               Prod.nFCI      := INIRec.ReadString( sSecao,'nFCI','');  //NFe2

               Prod.nFCI      := INIRec.ReadString( sSecao,'nFCI','');  //NFe3
               Prod.nRECOPI   := INIRec.ReadString( sSecao,'nRECOPI','');  //NFe3

               pDevol := StringToFloatDef( INIRec.ReadString(sSecao,'pDevol','') ,0);
               vIPIDevol := StringToFloatDef( INIRec.ReadString(sSecao,'vIPIDevol','') ,0);

               Imposto.vTotTrib := StringToFloatDef( INIRec.ReadString(sSecao,'vTotTrib','') ,0) ; //NFe2

               J := 1 ;
               while true do
                begin
                  sSecao  := 'NVE'+IntToStrZero(I,3)+IntToStrZero(J,3) ;
                  sNVE    := INIRec.ReadString(sSecao,'NVE','') ;
                  if (sNVE <> '') then
                     Prod.NVE.Add.NVE := sNVE
                  else
                     Break;   
                  Inc(J);
                end;

               J := 1 ;
               while true do
                begin
                  sSecao      := 'DI'+IntToStrZero(I,3)+IntToStrZero(J,3) ;
                  sNumeroDI := INIRec.ReadString(sSecao,'NumeroDI',INIRec.ReadString(sSecao,'nDi','')) ;

                  if sNumeroDI <> '' then
                   begin
                     with Prod.DI.Add do
                      begin
                        nDi         := sNumeroDI;
                        dDi         := DFeUtil.StringToDate(INIRec.ReadString(sSecao,'DataRegistroDI'  ,INIRec.ReadString(sSecao,'dDi'  ,'0')));
                        xLocDesemb  := INIRec.ReadString(sSecao,'LocalDesembaraco',INIRec.ReadString(sSecao,'xLocDesemb',''));
                        UFDesemb    := INIRec.ReadString(sSecao,'UFDesembaraco'   ,INIRec.ReadString(sSecao,'UFDesemb'   ,''));
                        dDesemb     := DFeUtil.StringToDate(INIRec.ReadString(sSecao,'DataDesembaraco',INIRec.ReadString(sSecao,'dDesemb','0')));

                        tpViaTransp  := StrToTipoViaTransp(OK,INIRec.ReadString(sSecao,'tpViaTransp',''));
                        vAFRMM       := StringToFloatDef( INIRec.ReadString(sSecao,'vAFRMM','') ,0) ;
                        tpIntermedio := StrToTipoIntermedio(OK,INIRec.ReadString(sSecao,'tpIntermedio',''));
                        CNPJ         := INIRec.ReadString(sSecao,'CNPJ','');
                        UFTerceiro   := INIRec.ReadString(sSecao,'UFTerceiro','');

                        cExportador := INIRec.ReadString(sSecao,'CodigoExportador',INIRec.ReadString(sSecao,'cExportador',''));

                        K := 1 ;
                        while true do
                         begin
                           sSecao      := 'LADI'+IntToStrZero(I,3)+IntToStrZero(J,3)+IntToStrZero(K,3)  ;
                           sNumeroADI := INIRec.ReadString(sSecao,'NumeroAdicao',INIRec.ReadString(sSecao,'nAdicao','FIM')) ;
                           if (sNumeroADI = 'FIM') or (Length(sNumeroADI) <= 0) then
                              break;

                           with adi.Add do
                            begin
                              nAdicao     := StrToInt(sNumeroADI);
                              nSeqAdi     := INIRec.ReadInteger( sSecao,'nSeqAdi',K);
                              cFabricante := INIRec.ReadString(  sSecao,'CodigoFabricante',INIRec.ReadString(  sSecao,'cFabricante',''));
                              vDescDI     := StringToFloatDef( INIRec.ReadString(sSecao,'DescontoADI',INIRec.ReadString(sSecao,'vDescDI','')) ,0);
                              nDraw       := INIRec.ReadString( sSecao,'nDraw','');
                            end;
                           Inc(K)
                         end;
                      end;
                   end
                  else
                    Break;
                  Inc(J);
                end;

               J := 1 ;
               while true do
                begin
                  sSecao  := 'detExport'+IntToStrZero(I,3)+IntToStrZero(J,3) ;
                  sFim    := INIRec.ReadString(sSecao,'nDraw',INIRec.ReadString(sSecao,'nRE','FIM')) ;
                  if (sFim = 'FIM') or (Length(sFim) <= 0) then
                     break ;

                  with Prod.detExport.Add do
                   begin
                     nDraw       := INIRec.ReadString( sSecao,'nDraw','');
                     nRE         := INIRec.ReadString( sSecao,'nRE','');
                     chNFe       := INIRec.ReadString( sSecao,'chNFe','');
                     qExport     := StringToFloatDef( INIRec.ReadString(sSecao,'qExport','') ,0);
                   end;
                  Inc(J);
                end;

              sSecao := 'impostoDevol'+IntToStrZero(I,3) ;
              sFim   := INIRec.ReadString( sSecao,'pDevol','FIM') ;
              if (sFim <> 'FIM') then
               begin
                 pDevol := StringToFloatDef( INIRec.ReadString(sSecao,'pDevol','') ,0);
                 vIPIDevol := StringToFloatDef( INIRec.ReadString(sSecao,'vIPIDevol','') ,0);
               end;


              sSecao := 'Veiculo'+IntToStrZero(I,3) ;
              sFim   := INIRec.ReadString( sSecao,'Chassi','FIM') ;
              if (sFim <> 'FIM') then
               begin
                 with Prod.veicProd do
                  begin
                    tpOP    := StrTotpOP(OK,INIRec.ReadString( sSecao,'tpOP','0'));
                    chassi  := sFim;
                    cCor    := INIRec.ReadString( sSecao,'cCor'   ,'');
                    xCor    := INIRec.ReadString( sSecao,'xCor'   ,'');
                    pot     := INIRec.ReadString( sSecao,'pot'    ,'');

                    Cilin   := INIRec.ReadString( sSecao,'CM3'    ,INIRec.ReadString( sSecao,'Cilin'  ,''));    //NFe2

                    pesoL   := INIRec.ReadString( sSecao,'pesoL'  ,'');
                    pesoB   := INIRec.ReadString( sSecao,'pesoB'  ,'');
                    nSerie  := INIRec.ReadString( sSecao,'nSerie' ,'');
                    tpComb  := INIRec.ReadString( sSecao,'tpComb' ,'');
                    nMotor  := INIRec.ReadString( sSecao,'nMotor' ,'');

                    CMT     := INIRec.ReadString( sSecao,'CMKG'   ,INIRec.ReadString( sSecao,'CMT'    ,''));    //NFe2

                    dist    := INIRec.ReadString( sSecao,'dist'   ,'');
//                    RENAVAM := INIRec.ReadString( sSecao,'RENAVAM','');
                    anoMod  := INIRec.ReadInteger(sSecao,'anoMod' ,0);
                    anoFab  := INIRec.ReadInteger(sSecao,'anoFab' ,0);
                    tpPint  := INIRec.ReadString( sSecao,'tpPint' ,'');
                    tpVeic  := INIRec.ReadInteger(sSecao,'tpVeic' ,0);
                    espVeic := INIRec.ReadInteger(sSecao,'espVeic',0);
                    VIN     := INIRec.ReadString( sSecao,'VIN'    ,'');
                    condVeic := StrTocondVeic(OK,INIRec.ReadString( sSecao,'condVeic','1'));
                    cMod    := INIRec.ReadString( sSecao,'cMod'   ,'');
                    cCorDENATRAN := INIRec.ReadString( sSecao,'cCorDENATRAN',''); //NFe2
                    lota    := INIRec.ReadInteger(sSecao,'lota'   ,0);            //NFe2
                    tpRest  := INIRec.ReadInteger(sSecao,'tpRest' ,0);            //NFe2
                  end;
               end;

               J := 1 ;
               while true do
                begin
                  sSecao := 'Medicamento'+IntToStrZero(I,3)+IntToStrZero(J,3) ;
                  sFim   := INIRec.ReadString(sSecao,'nLote','FIM') ;
                  if (sFim = 'FIM') or (Length(sFim) <= 0) then
                     break;

                 with Prod.med.Add do
                  begin
                    nLote := sFim;
                    qLote := StringToFloatDef(INIRec.ReadString( sSecao,'qLote',''),0) ;
                    dFab  := DFeUtil.StringToDate(INIRec.ReadString( sSecao,'dFab','0')) ;
                    dVal  := DFeUtil.StringToDate(INIRec.ReadString( sSecao,'dVal','0')) ;
                    vPMC  := StringToFloatDef(INIRec.ReadString( sSecao,'vPMC',''),0) ;
                   end;
                  Inc(J)
                end;

               J := 1 ;
               while true do
                begin
                  sSecao := 'Arma'+IntToStrZero(I,3)+IntToStrZero(J,3) ;
                  sFim   := INIRec.ReadString(sSecao,'nSerie','FIM') ;
                  if (sFim = 'FIM') or (Length(sFim) <= 0) then
                     break;

                 with Prod.arma.Add do
                  begin
                    tpArma := StrTotpArma(OK,INIRec.ReadString( sSecao,'tpArma','0')) ;
                    nSerie := sFim;
                    nCano  := INIRec.ReadString( sSecao,'nCano','') ;
                    descr  := INIRec.ReadString( sSecao,'descr','') ;
                   end;
                  Inc(J)
                end;

              sSecao := 'Combustivel'+IntToStrZero(I,3) ;
              sFim   := INIRec.ReadString( sSecao,'cProdANP','FIM') ;
              if (sFim <> 'FIM') then
               begin
                 with Prod.comb do
                  begin
                    cProdANP := INIRec.ReadInteger( sSecao,'cProdANP',0) ;
                    pMixGN   := StringToFloatDef(INIRec.ReadString( sSecao,'pMixGN',''),0) ;
                    CODIF    := INIRec.ReadString(  sSecao,'CODIF'   ,'') ;
                    qTemp    := StringToFloatDef(INIRec.ReadString( sSecao,'qTemp',''),0) ;
                    UFcons   := INIRec.ReadString( sSecao,'UFCons','') ;

                    sSecao := 'CIDE'+IntToStrZero(I,3) ;
                    CIDE.qBCprod   := StringToFloatDef(INIRec.ReadString( sSecao,'qBCprod'  ,''),0) ;
                    CIDE.vAliqProd := StringToFloatDef(INIRec.ReadString( sSecao,'vAliqProd',''),0) ;
                    CIDE.vCIDE     := StringToFloatDef(INIRec.ReadString( sSecao,'vCIDE'    ,''),0) ;

                    sSecao := 'ICMSComb'+IntToStrZero(I,3) ;
                    ICMS.vBCICMS   := StringToFloatDef(INIRec.ReadString( sSecao,'vBCICMS'  ,''),0) ;
                    ICMS.vICMS     := StringToFloatDef(INIRec.ReadString( sSecao,'vICMS'    ,''),0) ;
                    ICMS.vBCICMSST := StringToFloatDef(INIRec.ReadString( sSecao,'vBCICMSST',''),0) ;
                    ICMS.vICMSST   := StringToFloatDef(INIRec.ReadString( sSecao,'vICMSST'  ,''),0) ;

                    sSecao := 'ICMSInter'+IntToStrZero(I,3) ;
                    sFim   := INIRec.ReadString( sSecao,'vBCICMSSTDest','FIM') ;
                    if (sFim <> 'FIM') then
                     begin
                       ICMSInter.vBCICMSSTDest := StringToFloatDef(sFim,0) ;
                       ICMSInter.vICMSSTDest   := StringToFloatDef(INIRec.ReadString( sSecao,'vICMSSTDest',''),0) ;
                     end;

                    sSecao := 'ICMSCons'+IntToStrZero(I,3) ;
                    sFim   := INIRec.ReadString( sSecao,'vBCICMSSTCons','FIM') ;
                    if (sFim <> 'FIM') then
                     begin
                       ICMSCons.vBCICMSSTCons := StringToFloatDef(sFim,0) ;
                       ICMSCons.vICMSSTCons   := StringToFloatDef(INIRec.ReadString( sSecao,'vICMSSTCons',''),0) ;
                       ICMSCons.UFcons        := INIRec.ReadString( sSecao,'UFCons','') ;
                     end;
                  end;
               end;

               with Imposto do
                begin
                   sSecao := 'ICMS'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'CST',INIRec.ReadString(sSecao,'CSOSN','FIM')) ;
                   if (sFim <> 'FIM') then
                    begin
                      with ICMS do
                      begin
                        ICMS.orig       := StrToOrig(     OK, INIRec.ReadString(sSecao,'Origem'    ,INIRec.ReadString(sSecao,'orig'    ,'0' ) ));
                        CST             := StrToCSTICMS(  OK, INIRec.ReadString(sSecao,'CST'       ,'00'));
                        CSOSN           := StrToCSOSNIcms(OK, INIRec.ReadString(sSecao,'CSOSN'     ,''  ));     //NFe2
                        ICMS.modBC      := StrTomodBC(    OK, INIRec.ReadString(sSecao,'Modalidade',INIRec.ReadString(sSecao,'modBC','0' ) ));
                        ICMS.pRedBC     := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducao',INIRec.ReadString(sSecao,'pRedBC','')) ,0);
                        ICMS.vBC        := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase',INIRec.ReadString(sSecao,'vBC'  ,'')) ,0);
                        ICMS.pICMS      := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota' ,INIRec.ReadString(sSecao,'pICMS','')) ,0);
                        ICMS.vICMS      := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'    ,INIRec.ReadString(sSecao,'vICMS','')) ,0);
                        ICMS.modBCST    := StrTomodBCST(OK, INIRec.ReadString(sSecao,'ModalidadeST',INIRec.ReadString(sSecao,'modBCST','0')));
                        ICMS.pMVAST     := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualMargemST' ,INIRec.ReadString(sSecao,'pMVAST' ,'')) ,0);
                        ICMS.pRedBCST   := StringToFloatDef( INIRec.ReadString(sSecao,'PercentualReducaoST',INIRec.ReadString(sSecao,'pRedBCST','')) ,0);
                        ICMS.vBCST      := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBaseST',INIRec.ReadString(sSecao,'vBCST','')) ,0);
                        ICMS.pICMSST    := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaST' ,INIRec.ReadString(sSecao,'pICMSST' ,'')) ,0);
                        ICMS.vICMSST    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorST'    ,INIRec.ReadString(sSecao,'vICMSST'    ,'')) ,0);
                        ICMS.UFST       := INIRec.ReadString(sSecao,'UFST'    ,'');                           //NFe2
                        ICMS.pBCOp      := StringToFloatDef( INIRec.ReadString(sSecao,'pBCOp'    ,'') ,0);    //NFe2
                        ICMS.vBCSTRet   := StringToFloatDef( INIRec.ReadString(sSecao,'vBCSTRet','') ,0);     //NFe2
                        ICMS.vICMSSTRet := StringToFloatDef( INIRec.ReadString(sSecao,'vICMSSTRet','') ,0);   //NFe2
                        ICMS.motDesICMS := StrTomotDesICMS(OK, INIRec.ReadString(sSecao,'motDesICMS','0'));   //NFe2
                        ICMS.pCredSN    := StringToFloatDef( INIRec.ReadString(sSecao,'pCredSN','') ,0);      //NFe2
                        ICMS.vCredICMSSN:= StringToFloatDef( INIRec.ReadString(sSecao,'vCredICMSSN','') ,0);  //NFe2
                        ICMS.vBCSTDest  := StringToFloatDef( INIRec.ReadString(sSecao,'vBCSTDest','') ,0);    //NFe2
                        ICMS.vICMSSTDest:= StringToFloatDef( INIRec.ReadString(sSecao,'vICMSSTDest','') ,0);   //NFe2
                        ICMS.vICMSDeson := StringToFloatDef( INIRec.ReadString(sSecao,'vICMSDeson','') ,0);
                        ICMS.vICMSOp    := StringToFloatDef( INIRec.ReadString(sSecao,'vICMSOp','') ,0);
                        ICMS.pDif       := StringToFloatDef( INIRec.ReadString(sSecao,'pDif','') ,0);
                        ICMS.vICMSDif   := StringToFloatDef( INIRec.ReadString(sSecao,'vICMSDif','') ,0);
                      end;
                    end;

                   sSecao := 'IPI'+IntToStrZero(I,3) ;
                   sFim  := INIRec.ReadString( sSecao,'CST','FIM') ;
                   if (sFim <> 'FIM') then
                    begin
                     with IPI do
                      begin
                        CST      := StrToCSTIPI(OK, INIRec.ReadString( sSecao,'CST','')) ;
                        clEnq    := INIRec.ReadString(  sSecao,'ClasseEnquadramento',INIRec.ReadString(  sSecao,'clEnq'   ,''));
                        CNPJProd := INIRec.ReadString(  sSecao,'CNPJProdutor'       ,INIRec.ReadString(  sSecao,'CNPJProd',''));
                        cSelo    := INIRec.ReadString(  sSecao,'CodigoSeloIPI'      ,INIRec.ReadString(  sSecao,'cSelo'   ,''));
                        qSelo    := INIRec.ReadInteger( sSecao,'QuantidadeSelos'    ,INIRec.ReadInteger( sSecao,'qSelo'   ,0));
                        cEnq     := INIRec.ReadString(  sSecao,'CodigoEnquadramento',INIRec.ReadString(  sSecao,'cEnq'    ,''));

                        vBC    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'   ,INIRec.ReadString(sSecao,'vBC'   ,'')) ,0);
                        qUnid  := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade'  ,INIRec.ReadString(sSecao,'qUnid' ,'')) ,0);
                        vUnid  := StringToFloatDef( INIRec.ReadString(sSecao,'ValorUnidade',INIRec.ReadString(sSecao,'vUnid' ,'')) ,0);
                        pIPI   := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota'    ,INIRec.ReadString(sSecao,'pIPI'  ,'')) ,0);
                        vIPI   := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'       ,INIRec.ReadString(sSecao,'vIPI'  ,'')) ,0);
                      end;
                    end;

                   sSecao   := 'II'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'ValorBase',INIRec.ReadString( sSecao,'vBC','FIM')) ;
                   if (sFim <> 'FIM') then
                    begin
                     with II do
                      begin
                        vBc      := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'          ,INIRec.ReadString(sSecao,'vBC'     ,'')) ,0);
                        vDespAdu := StringToFloatDef( INIRec.ReadString(sSecao,'ValorDespAduaneiras',INIRec.ReadString(sSecao,'vDespAdu','')) ,0);
                        vII      := StringToFloatDef( INIRec.ReadString(sSecao,'ValorII'            ,INIRec.ReadString(sSecao,'vII'     ,'')) ,0);
                        vIOF     := StringToFloatDef( INIRec.ReadString(sSecao,'ValorIOF'           ,INIRec.ReadString(sSecao,'vIOF'    ,'')) ,0);
                      end;
                    end;

                   sSecao    := 'PIS'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'CST','FIM') ;
                   if (sFim <> 'FIM') then
                    begin
                     with PIS do
                       begin
                        CST :=  StrToCSTPIS(OK, INIRec.ReadString( sSecao,'CST','01'));

                        PIS.vBC       := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'    ,INIRec.ReadString(sSecao,'vBC'      ,'')) ,0);
                        PIS.pPIS      := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota'     ,INIRec.ReadString(sSecao,'pPIS'     ,'')) ,0);
                        PIS.qBCProd   := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade'   ,INIRec.ReadString(sSecao,'qBCProd'  ,'')) ,0);
                        PIS.vAliqProd := StringToFloatDef( INIRec.ReadString(sSecao,'ValorAliquota',INIRec.ReadString(sSecao,'vAliqProd','')) ,0);
                        PIS.vPIS      := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'        ,INIRec.ReadString(sSecao,'vPIS'     ,'')) ,0);
                       end;
                    end;

                   sSecao    := 'PISST'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'ValorBase','F')+ INIRec.ReadString( sSecao,'Quantidade','IM') ;
                   if (sFim = 'FIM') then
                      sFim   := INIRec.ReadString( sSecao,'vBC','F')+ INIRec.ReadString( sSecao,'qBCProd','IM') ;

                   if (sFim <> 'FIM') then
                    begin
                     with PISST do
                      begin
                        vBc       := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'    ,INIRec.ReadString(sSecao,'vBC'      ,'')) ,0);
                        pPis      := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaPerc' ,INIRec.ReadString(sSecao,'pPis'     ,'')) ,0);
                        qBCProd   := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade'   ,INIRec.ReadString(sSecao,'qBCProd'  ,'')) ,0);
                        vAliqProd := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaValor',INIRec.ReadString(sSecao,'vAliqProd','')) ,0);
                        vPIS      := StringToFloatDef( INIRec.ReadString(sSecao,'ValorPISST'   ,INIRec.ReadString(sSecao,'vPIS'     ,'')) ,0);
                      end;
                    end;

                   sSecao    := 'COFINS'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'CST','FIM') ;
                   if (sFim <> 'FIM') then
                    begin
                     with COFINS do
                      begin
                        CST := StrToCSTCOFINS(OK, INIRec.ReadString( sSecao,'CST','01'));

                        COFINS.vBC       := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'    ,INIRec.ReadString(sSecao,'vBC'      ,'')) ,0);
                        COFINS.pCOFINS   := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota'     ,INIRec.ReadString(sSecao,'pCOFINS'  ,'')) ,0);
                        COFINS.qBCProd   := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade'   ,INIRec.ReadString(sSecao,'qBCProd'  ,'')) ,0);
                        COFINS.vAliqProd := StringToFloatDef( INIRec.ReadString(sSecao,'ValorAliquota',INIRec.ReadString(sSecao,'vAliqProd','')) ,0);
                        COFINS.vCOFINS   := StringToFloatDef( INIRec.ReadString(sSecao,'Valor'        ,INIRec.ReadString(sSecao,'vCOFINS'  ,'')) ,0);
                      end;
                    end;

                   sSecao    := 'COFINSST'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'ValorBase','F')+ INIRec.ReadString( sSecao,'Quantidade','IM');
                   if (sFim = 'FIM') then
                      sFim   := INIRec.ReadString( sSecao,'vBC','F')+ INIRec.ReadString( sSecao,'qBCProd','IM') ;

                   if (sFim <> 'FIM') then
                    begin
                     with COFINSST do
                      begin
                         vBC       := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'    ,INIRec.ReadString(sSecao,'vBC'      ,'')) ,0);
                         pCOFINS   := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaPerc' ,INIRec.ReadString(sSecao,'pCOFINS'  ,'')) ,0);
                         qBCProd   := StringToFloatDef( INIRec.ReadString(sSecao,'Quantidade'   ,INIRec.ReadString(sSecao,'qBCProd'  ,'')) ,0);
                         vAliqProd := StringToFloatDef( INIRec.ReadString(sSecao,'AliquotaValor',INIRec.ReadString(sSecao,'vAliqProd','')) ,0);
                         vCOFINS   := StringToFloatDef( INIRec.ReadString(sSecao,'ValorCOFINSST',INIRec.ReadString(sSecao,'vCOFINS'  ,'')) ,0);
                       end;
                    end;

                   sSecao    := 'ISSQN'+IntToStrZero(I,3) ;
                   sFim   := INIRec.ReadString( sSecao,'ValorBase',INIRec.ReadString(sSecao,'vBC'   ,'FIM')) ;
                   if (sFim = 'FIM') then
                      sFim   := INIRec.ReadString( sSecao,'vBC','FIM');
                   if (sFim <> 'FIM') then
                    begin
                     with ISSQN do
                      begin
                        if StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase',INIRec.ReadString(sSecao,'vBC','')) ,0) > 0 then
                         begin
                           vBC       := StringToFloatDef( INIRec.ReadString(sSecao,'ValorBase'   ,INIRec.ReadString(sSecao,'vBC'   ,'')) ,0);
                           vAliq     := StringToFloatDef( INIRec.ReadString(sSecao,'Aliquota'    ,INIRec.ReadString(sSecao,'vAliq' ,'')) ,0);
                           vISSQN    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorISSQN'  ,INIRec.ReadString(sSecao,'vISSQN','')) ,0);
                           cMunFG    := StrToInt( INIRec.ReadString(sSecao,'MunicipioFatoGerador',INIRec.ReadString(sSecao,'cMunFG','')));
                           cListServ := INIRec.ReadString(sSecao,'CodigoServico',INIRec.ReadString(sSecao,'cListServ',''));
                           cSitTrib  := StrToISSQNcSitTrib( OK,INIRec.ReadString(sSecao,'cSitTrib','')) ;
                           vDeducao    := StringToFloatDef( INIRec.ReadString(sSecao,'ValorDeducao'   ,INIRec.ReadString(sSecao,'vDeducao'   ,'')) ,0);
                           vOutro      := StringToFloatDef( INIRec.ReadString(sSecao,'ValorOutro'   ,INIRec.ReadString(sSecao,'vOutro'   ,'')) ,0);
                           vDescIncond := StringToFloatDef( INIRec.ReadString(sSecao,'ValorDescontoIncondicional'   ,INIRec.ReadString(sSecao,'vDescIncond'   ,'')) ,0);
                           vDescCond   := StringToFloatDef( INIRec.ReadString(sSecao,'vDescontoCondicional'   ,INIRec.ReadString(sSecao,'vDescCond'   ,'')) ,0);
                           vISSRet     := StringToFloatDef( INIRec.ReadString(sSecao,'ValorISSRetido'   ,INIRec.ReadString(sSecao,'vISSRet'   ,'')) ,0);
                           indISS      := StrToindISS( OK,INIRec.ReadString(sSecao,'indISS','')) ;
                           cServico    := INIRec.ReadString(sSecao,'cServico','');
                           cMun        := INIRec.ReadInteger(sSecao,'cMun',0);
                           cPais       := INIRec.ReadInteger(sSecao,'cPais',1058);
                           nProcesso   := INIRec.ReadString(sSecao,'nProcesso','');
                           indIncentivo := StrToindIncentivo( OK,INIRec.ReadString(sSecao,'indIncentivo','')) ;
                         end;
                      end;
                    end;
                end;

             end;
            Inc( I ) ;
          end ;

         Total.ICMSTot.vBC     := StringToFloatDef( INIRec.ReadString('Total','BaseICMS'     ,INIRec.ReadString('Total','vBC'     ,'')) ,0) ;
         Total.ICMSTot.vICMS   := StringToFloatDef( INIRec.ReadString('Total','ValorICMS'    ,INIRec.ReadString('Total','vICMS'   ,'')) ,0) ;
         Total.ICMSTot.vICMSDeson := StringToFloatDef( INIRec.ReadString('Total','vICMSDeson',''),0) ;
         Total.ICMSTot.vBCST   := StringToFloatDef( INIRec.ReadString('Total','BaseICMSSubstituicao' ,INIRec.ReadString('Total','vBCST','')) ,0) ;
         Total.ICMSTot.vST     := StringToFloatDef( INIRec.ReadString('Total','ValorICMSSubstituicao',INIRec.ReadString('Total','vST'  ,'')) ,0) ;
         Total.ICMSTot.vProd   := StringToFloatDef( INIRec.ReadString('Total','ValorProduto' ,INIRec.ReadString('Total','vProd'  ,'')) ,0) ;
         Total.ICMSTot.vFrete  := StringToFloatDef( INIRec.ReadString('Total','ValorFrete'   ,INIRec.ReadString('Total','vFrete' ,'')) ,0) ;
         Total.ICMSTot.vSeg    := StringToFloatDef( INIRec.ReadString('Total','ValorSeguro'  ,INIRec.ReadString('Total','vSeg'   ,'')) ,0) ;
         Total.ICMSTot.vDesc   := StringToFloatDef( INIRec.ReadString('Total','ValorDesconto',INIRec.ReadString('Total','vDesc'  ,'')) ,0) ;
         Total.ICMSTot.vII     := StringToFloatDef( INIRec.ReadString('Total','ValorII'      ,INIRec.ReadString('Total','vII'    ,'')) ,0) ;
         Total.ICMSTot.vIPI    := StringToFloatDef( INIRec.ReadString('Total','ValorIPI'     ,INIRec.ReadString('Total','vIPI'   ,'')) ,0) ;
         Total.ICMSTot.vPIS    := StringToFloatDef( INIRec.ReadString('Total','ValorPIS'     ,INIRec.ReadString('Total','vPIS'   ,'')) ,0) ;
         Total.ICMSTot.vCOFINS := StringToFloatDef( INIRec.ReadString('Total','ValorCOFINS'  ,INIRec.ReadString('Total','vCOFINS','')) ,0) ;
         Total.ICMSTot.vOutro  := StringToFloatDef( INIRec.ReadString('Total','ValorOutrasDespesas',INIRec.ReadString('Total','vOutro','')) ,0) ;
         Total.ICMSTot.vNF     := StringToFloatDef( INIRec.ReadString('Total','ValorNota'    ,INIRec.ReadString('Total','vNF'    ,'')) ,0) ;
         Total.ICMSTot.vTotTrib:= StringToFloatDef( INIRec.ReadString('Total','vTotTrib'     ,''),0) ;

         Total.ISSQNtot.vServ  := StringToFloatDef( INIRec.ReadString('Total','ValorServicos',INIRec.ReadString('ISSQNtot','vServ','')) ,0) ;
         Total.ISSQNTot.vBC    := StringToFloatDef( INIRec.ReadString('Total','ValorBaseISS' ,INIRec.ReadString('ISSQNtot','vBC'  ,'')) ,0) ;
         Total.ISSQNTot.vISS   := StringToFloatDef( INIRec.ReadString('Total','ValorISSQN'   ,INIRec.ReadString('ISSQNtot','vISS' ,'')) ,0) ;
         Total.ISSQNTot.vPIS   := StringToFloatDef( INIRec.ReadString('Total','ValorPISISS'  ,INIRec.ReadString('ISSQNtot','vPIS' ,'')) ,0) ;
         Total.ISSQNTot.vCOFINS := StringToFloatDef( INIRec.ReadString('Total','ValorCONFINSISS',INIRec.ReadString('ISSQNtot','vCOFINS','')) ,0) ;
         Total.ISSQNtot.dCompet     := DFeUtil.StringToDate(INIRec.ReadString('ISSQNtot','dCompet','0'));
         Total.ISSQNtot.vDeducao    := StringToFloatDef( INIRec.ReadString('ISSQNtot','vDeducao'   ,'') ,0) ;
         Total.ISSQNtot.vOutro      := StringToFloatDef( INIRec.ReadString('ISSQNtot','vOutro'   ,'') ,0) ;
         Total.ISSQNtot.vDescIncond := StringToFloatDef( INIRec.ReadString('ISSQNtot','vDescIncond'   ,'') ,0) ;
         Total.ISSQNtot.vDescCond   := StringToFloatDef( INIRec.ReadString('ISSQNtot','vDescCond'   ,'') ,0) ;
         Total.ISSQNtot.vISSRet     := StringToFloatDef( INIRec.ReadString('ISSQNtot','vISSRet'   ,'') ,0) ;
         Total.ISSQNtot.cRegTrib    := StrToRegTribISSQN( OK,INIRec.ReadString('ISSQNtot','cRegTrib','1')) ;

         Total.retTrib.vRetPIS    := StringToFloatDef( INIRec.ReadString('retTrib','vRetPIS'   ,'') ,0) ;
         Total.retTrib.vRetCOFINS := StringToFloatDef( INIRec.ReadString('retTrib','vRetCOFINS','') ,0) ;
         Total.retTrib.vRetCSLL   := StringToFloatDef( INIRec.ReadString('retTrib','vRetCSLL'  ,'') ,0) ;
         Total.retTrib.vBCIRRF    := StringToFloatDef( INIRec.ReadString('retTrib','vBCIRRF'   ,'') ,0) ;
         Total.retTrib.vIRRF      := StringToFloatDef( INIRec.ReadString('retTrib','vIRRF'     ,'') ,0) ;
         Total.retTrib.vBCRetPrev := StringToFloatDef( INIRec.ReadString('retTrib','vBCRetPrev','') ,0) ;
         Total.retTrib.vRetPrev   := StringToFloatDef( INIRec.ReadString('retTrib','vRetPrev'  ,'') ,0) ;

         Transp.modFrete := StrTomodFrete(OK, INIRec.ReadString('Transportador','FretePorConta',INIRec.ReadString('Transportador','modFrete','0')));
         Transp.Transporta.CNPJCPF  := INIRec.ReadString('Transportador','CNPJCPF'  ,'');
         Transp.Transporta.xNome    := INIRec.ReadString('Transportador','NomeRazao',INIRec.ReadString('Transportador','xNome',''));
         Transp.Transporta.IE       := INIRec.ReadString('Transportador','IE'       ,'');
         Transp.Transporta.xEnder   := INIRec.ReadString('Transportador','Endereco' ,INIRec.ReadString('Transportador','xEnder',''));
         Transp.Transporta.xMun     := INIRec.ReadString('Transportador','Cidade'   ,INIRec.ReadString('Transportador','xMun',''));
         Transp.Transporta.UF       := INIRec.ReadString('Transportador','UF'       ,'');

         Transp.retTransp.vServ    := StringToFloatDef( INIRec.ReadString('Transportador','ValorServico',INIRec.ReadString('Transportador','vServ'   ,'')) ,0) ;
         Transp.retTransp.vBCRet   := StringToFloatDef( INIRec.ReadString('Transportador','ValorBase'   ,INIRec.ReadString('Transportador','vBCRet'  ,'')) ,0) ;
         Transp.retTransp.pICMSRet := StringToFloatDef( INIRec.ReadString('Transportador','Aliquota'    ,INIRec.ReadString('Transportador','pICMSRet','')) ,0) ;
         Transp.retTransp.vICMSRet := StringToFloatDef( INIRec.ReadString('Transportador','Valor'       ,INIRec.ReadString('Transportador','vICMSRet','')) ,0) ;
         Transp.retTransp.CFOP     := INIRec.ReadString('Transportador','CFOP'     ,'');
         Transp.retTransp.cMunFG   := INIRec.ReadInteger('Transportador','CidadeCod',INIRec.ReadInteger('Transportador','cMunFG',0));

         Transp.veicTransp.placa := INIRec.ReadString('Transportador','Placa'  ,'');
         Transp.veicTransp.UF    := INIRec.ReadString('Transportador','UFPlaca','');
         Transp.veicTransp.RNTC  := INIRec.ReadString('Transportador','RNTC'   ,'');

         Transp.vagao := INIRec.ReadString( 'Transportador','vagao','') ;  //NFe2
         Transp.balsa := INIRec.ReadString( 'Transportador','balsa','') ;  //NFe2

         J := 1 ;
         while true do
          begin
            sSecao := 'Reboque'+IntToStrZero(J,3) ;
            sFim   := INIRec.ReadString(sSecao,'placa','FIM') ;
            if (sFim = 'FIM') or (Length(sFim) <= 0) then
               break;

            with Transp.Reboque.Add do
             begin
               placa := sFim;
               UF    := INIRec.ReadString( sSecao,'UF'  ,'') ;
               RNTC  := INIRec.ReadString( sSecao,'RNTC','') ;
             end;
            Inc(J)
          end;

         I := 1 ;
         while true do
          begin
            sSecao    := 'Volume'+IntToStrZero(I,3) ;
            sQtdVol   := INIRec.ReadString(sSecao,'Quantidade',INIRec.ReadString(sSecao,'qVol','FIM')) ;
            if (sQtdVol = 'FIM') or (Length(sQtdVol) <= 0)  then
               break ;

            with Transp.Vol.Add do
             begin
               qVol  := StrToInt(sQtdVol);
               esp   := INIRec.ReadString( sSecao,'Especie'  ,INIRec.ReadString( sSecao,'esp'  ,''));
               marca := INIRec.ReadString( sSecao,'Marca'    ,'');
               nVol  := INIRec.ReadString( sSecao,'Numeracao',INIRec.ReadString( sSecao,'nVol'  ,''));
               pesoL := StringToFloatDef( INIRec.ReadString(sSecao,'PesoLiquido',INIRec.ReadString(sSecao,'pesoL','')) ,0) ;
               pesoB := StringToFloatDef( INIRec.ReadString(sSecao,'PesoBruto'  ,INIRec.ReadString(sSecao,'pesoB','')) ,0) ;

               J := 1;
               while true do
                begin
                  sSecao := 'Lacre'+IntToStrZero(I,3)+IntToStrZero(J,3) ;
                  sFim   := INIRec.ReadString(sSecao,'nLacre','FIM') ;
                  if (sFim = 'FIM') or (Length(sFim) <= 0)  then
                     break ;

                  Lacres.Add.nLacre := sFim;

                  Inc(J);
                end;
             end;
            Inc(I);
          end;

         Cobr.Fat.nFat  := INIRec.ReadString( 'Fatura','Numero',INIRec.ReadString( 'Fatura','nFat',''));
         Cobr.Fat.vOrig := StringToFloatDef( INIRec.ReadString('Fatura','ValorOriginal',INIRec.ReadString('Fatura','vOrig','')) ,0) ;
         Cobr.Fat.vDesc := StringToFloatDef( INIRec.ReadString('Fatura','ValorDesconto',INIRec.ReadString('Fatura','vDesc','')) ,0) ;
         Cobr.Fat.vLiq  := StringToFloatDef( INIRec.ReadString('Fatura','ValorLiquido' ,INIRec.ReadString('Fatura','vLiq' ,'')) ,0) ;

         I := 1 ;
         while true do
          begin
            sSecao    := 'Duplicata'+IntToStrZero(I,3) ;
            sNumDup   := INIRec.ReadString(sSecao,'Numero',INIRec.ReadString(sSecao,'nDup','FIM')) ;
            if (sNumDup = 'FIM') or (Length(sNumDup) <= 0) then
               break ;

            with Cobr.Dup.Add do
             begin
               nDup  := sNumDup;
               dVenc := DFeUtil.StringToDate(INIRec.ReadString( sSecao,'DataVencimento',INIRec.ReadString( sSecao,'dVenc','0')));
               vDup  := StringToFloatDef( INIRec.ReadString(sSecao,'Valor',INIRec.ReadString(sSecao,'vDup','')) ,0) ;
             end;
            Inc(I);
          end;

         I := 1 ;
         while true do
          begin
            sSecao    := 'pag'+IntToStrZero(I,3) ;
            sFim      := INIRec.ReadString(sSecao,'tpag','FIM');
            if (sFim = 'FIM') or (Length(sFim) <= 0) then
               break ;

            with pag.Add do
             begin
               tPag  := StrToFormaPagamento(OK,sFim);
               vPag  := StringToFloatDef( INIRec.ReadString(sSecao,'vPag','') ,0) ;

               CNPJ  := INIRec.ReadString(sSecao,'CNPJ','');
               tBand := StrToBandeiraCartao(OK,INIRec.ReadString(sSecao,'tBand','99'));
               cAut  := INIRec.ReadString(sSecao,'cAut','');
             end;
            Inc(I);
          end;

         InfAdic.infAdFisco :=  INIRec.ReadString( 'DadosAdicionais','Fisco'      ,INIRec.ReadString( 'DadosAdicionais','infAdFisco',''));
         InfAdic.infCpl     :=  INIRec.ReadString( 'DadosAdicionais','Complemento',INIRec.ReadString( 'DadosAdicionais','infCpl'    ,''));

         I := 1 ;
         while true do
          begin
            sSecao     := 'InfAdic'+IntToStrZero(I,3) ;
            sCampoAdic := INIRec.ReadString(sSecao,'Campo',INIRec.ReadString(sSecao,'xCampo','FIM')) ;
            if (sCampoAdic = 'FIM') or (Length(sCampoAdic) <= 0) then
               break ;

            with InfAdic.obsCont.Add do
             begin
               xCampo := sCampoAdic;
               xTexto := INIRec.ReadString( sSecao,'Texto',INIRec.ReadString( sSecao,'xTexto',''));
             end;
            Inc(I);
          end;

         I := 1 ;
         while true do
          begin
            sSecao     := 'ObsFisco'+IntToStrZero(I,3) ;
            sCampoAdic := INIRec.ReadString(sSecao,'Campo',INIRec.ReadString(sSecao,'xCampo','FIM')) ;
            if (sCampoAdic = 'FIM') or (Length(sCampoAdic) <= 0) then
               break ;

            with InfAdic.obsFisco.Add do
             begin
               xCampo := sCampoAdic;
               xTexto := INIRec.ReadString( sSecao,'Texto',INIRec.ReadString( sSecao,'xTexto',''));
             end;
            Inc(I);
          end;

         I := 1 ;
         while true do
          begin
            sSecao     := 'procRef'+IntToStrZero(I,3) ;
            sCampoAdic := INIRec.ReadString(sSecao,'nProc','FIM') ;
            if (sCampoAdic = 'FIM') or (Length(sCampoAdic) <= 0) then
               break ;

            with InfAdic.procRef.Add do
             begin
               nProc := sCampoAdic;
               indProc := StrToindProc(OK,INIRec.ReadString( sSecao,'indProc','0'));
             end;
            Inc(I);
          end;

         sFim   := INIRec.ReadString( 'Exporta','UFembarq',INIRec.ReadString( 'Exporta','UFSaidaPais','FIM')) ;
         if (sFim <> 'FIM') then
          begin
            exporta.UFembarq   := INIRec.ReadString( 'Exporta','UFembarq','') ;;
            exporta.xLocEmbarq := INIRec.ReadString( 'Exporta','xLocEmbarq','');

            exporta.UFSaidaPais := INIRec.ReadString( 'Exporta','UFSaidaPais','');
            exporta.xLocExporta := INIRec.ReadString( 'Exporta','xLocExporta','');
            exporta.xLocDespacho := INIRec.ReadString( 'Exporta','xLocDespacho','');
          end;

         if (INIRec.ReadString( 'Compra','xNEmp','') <> '') or
            (INIRec.ReadString( 'Compra','xPed' ,'') <> '') or
            (INIRec.ReadString( 'Compra','xCont','') <> '') then
          begin
            compra.xNEmp := INIRec.ReadString( 'Compra','xNEmp','');
            compra.xPed  := INIRec.ReadString( 'Compra','xPed','');
            compra.xCont := INIRec.ReadString( 'Compra','xCont','');
          end;

         cana.safra  := INIRec.ReadString( 'cana','safra','');  //NFe2
         cana.ref    := INIRec.ReadString( 'cana','ref'  ,'');  //NFe2
         cana.qTotMes := StringToFloatDef( INIRec.ReadString('cana','qTotMes','') ,0) ; //NFe2
         cana.qTotAnt := StringToFloatDef( INIRec.ReadString('cana','qTotAnt','') ,0) ; //NFe2
         cana.qTotGer := StringToFloatDef( INIRec.ReadString('cana','qTotGer','') ,0) ; //NFe2
         cana.vFor    := StringToFloatDef( INIRec.ReadString('cana','vFor'   ,'') ,0) ; //NFe2
         cana.vTotDed := StringToFloatDef( INIRec.ReadString('cana','vTotDed','') ,0) ; //NFe2
         cana.vLiqFor := StringToFloatDef( INIRec.ReadString('cana','vLiqFor','') ,0) ; //NFe2

         I := 1 ;
         while true do
          begin
            sSecao    := 'forDia'+IntToStrZero(I,3) ;
            sDia      := INIRec.ReadString(sSecao,'dia','FIM') ;
            if (sDia = 'FIM') or (Length(sDia) <= 0) then
               break ;

            with cana.fordia.Add do
             begin
               dia     := StrToInt(sDia);                                                //NFe2
               qtde    := StringToFloatDef( INIRec.ReadString(sSecao,'qtde'   ,'') ,0) ; //NFe2
             end;
            Inc(I);
          end;

         I := 1 ;
         while true do
          begin
            sSecao    := 'deduc'+IntToStrZero(I,3) ;
            sDeduc    := INIRec.ReadString(sSecao,'xDed','FIM') ;
            if (sDeduc = 'FIM') or (Length(sDeduc) <= 0) then
               break ;

            with cana.deduc.Add do
             begin
               xDed    := sDeduc;                                                        //NFe2
               vDed    := StringToFloatDef( INIRec.ReadString(sSecao,'vDed'   ,'') ,0) ; //NFe2
             end;
            Inc(I);
          end;

          TributosFonte := INIRec.ReadString('Tributos','Fonte','');
          ACBrNFeDANFERave1.TributosFonte := TributosFonte;
          ACBrNFeDANFERaveCB1.TributosFonte := TributosFonte;
//          ACBrNFeDANFCeFortes1.TributosFonte := TributosFonte;
//          ACBrNFeDANFeESCPOS1.TributosFonte := TributosFonte;
       end;
   finally
      INIRec.Free ;
   end;
  end;
end;

function GerarNFeIni( XML : WideString ) : WideString;
var
  I, J, K : Integer;
  sSecao : String;
  INIRec : TMemIniFile ;
  OK     : boolean;
  IniNFe : TStringList;
  LocNFeR : TNFeR;
begin
 INIRec := TMemIniFile.create( 'nfe.ini' ) ;
 frmAcbrNfeMonitor.ACBrNFe1.NotasFiscais.Clear;
 if FilesExists(XML) then
    frmAcbrNfeMonitor.ACBrNFe1.NotasFiscais.LoadFromFile(XML)
 else
  begin
    LocNFeR := TNFeR.Create(frmAcbrNfeMonitor.ACBrNFe1.NotasFiscais.Add.NFe);
    try
       LocNFeR.Leitor.Arquivo := ConvertStrRecived( XML );
       LocNFeR.LerXml;
       frmAcbrNfeMonitor.ACBrNFe1.NotasFiscais.Items[0].XML := LocNFeR.Leitor.Arquivo;
       frmAcbrNfeMonitor.ACBrNFe1.NotasFiscais.GerarNFe;
    finally
       LocNFeR.Free;
    end;
  end;

 with frmAcbrNfeMonitor do
  begin
   try
      with ACBrNFe1.NotasFiscais.Items[0].NFe do
       begin
         INIRec.WriteString( 'infNFe','ID' ,infNFe.ID);
         INIRec.WriteString( 'infNFe','Versao' ,FloatToStr(infNFe.Versao));

         INIRec.WriteInteger('Identificacao','cUF'     ,Ide.cUF);
         INIRec.WriteInteger('Identificacao','Codigo'  ,Ide.cNF);
         INIRec.WriteString( 'Identificacao','NaturezaOperacao' ,Ide.natOp);
         INIRec.WriteString( 'Identificacao','FormaPag',IndpagToStr(Ide.indPag));
         INIRec.WriteInteger('Identificacao','Modelo'  ,Ide.modelo);
         INIRec.WriteInteger('Identificacao','Serie'   ,Ide.serie);
         INIRec.WriteInteger('Identificacao','Numero'  ,Ide.nNF);
         INIRec.WriteString( 'Identificacao','Emissao' ,DateToStr(Ide.dEmi));
         INIRec.WriteString( 'Identificacao','Saida'   ,DateToStr(Ide.dSaiEnt));
         INIRec.WriteString( 'Identificacao','hSaiEnt' ,TimeToStr(Ide.hSaiEnt));
         INIRec.WriteString( 'Identificacao','Tipo'    ,tpNFToStr(Ide.tpNF ));
         INIRec.WriteInteger('Identificacao','CidadeCod' ,Ide.cMunFG);
         INIRec.WriteString( 'Identificacao','tpAmb'   ,TpAmbToStr(Ide.tpAmb ));
         INIRec.WriteString( 'Identificacao','tpImp'   ,TpImpToStr(Ide.tpImp ));
         INIRec.WriteString( 'Identificacao','tpemis'  ,TpEmisToStr(Ide.tpemis ));
         INIRec.WriteString( 'Identificacao','Finalidade',FinNFeToStr(Ide.finNFe));
         INIRec.WriteString( 'Identificacao','procEmi' ,procEmiToStr(Ide.procEmi) );
         INIRec.WriteString( 'Identificacao','verProc' ,Ide.verProc );
         INIRec.WriteString( 'Identificacao','dhCont'  ,DateToStr(Ide.dhCont));
         INIRec.WriteString( 'Identificacao','xJust'   ,Ide.xJust);

         for I:= 0 to Ide.NFref.Count -1 do
          begin
            with Ide.NFref.Items[i] do
             begin
               sSecao    := 'NFRef'+IntToStrZero(I+1,3) ;
               if trim(refNFe) <> '' then
                begin
                  INIRec.WriteString(  sSecao,'Tipo','NFe') ;
                  INIRec.WriteString(  sSecao,'refNFe',refNFe) ;
                end
               else if trim(RefNF.CNPJ) <> '' then
                begin
                  INIRec.WriteString(  sSecao,'Tipo','NF') ;
                  INIRec.WriteInteger( sSecao,'cUF'   ,RefNF.cUF);
                  INIRec.WriteString(  sSecao,'AAMM'  ,RefNF.AAMM);
                  INIRec.WriteString(  sSecao,'CNPJ'  ,RefNF.CNPJ);
                  INIRec.WriteInteger( sSecao,'Modelo',RefNF.modelo);
                  INIRec.WriteInteger( sSecao,'Serie' ,RefNF.serie);
                  INIRec.WriteInteger( sSecao,'nNF'   ,RefNF.nNF);
                end
               else if trim(RefNFP.CNPJCPF) <> '' then
                begin
                  INIRec.WriteString(  sSecao,'Tipo','NFP') ;
                  INIRec.WriteInteger( sSecao,'cUF'   ,RefNFP.cUF);
                  INIRec.WriteString(  sSecao,'AAMM'  ,RefNFP.AAMM);
                  INIRec.WriteString(  sSecao,'CNPJ'  ,RefNFP.CNPJCPF);
                  INIRec.WriteString(  sSecao,'IE'    ,RefNFP.IE);
                  INIRec.WriteString(  sSecao,'Modelo',RefNFP.modelo);
                  INIRec.WriteInteger( sSecao,'Serie' ,RefNFP.serie);
                  INIRec.WriteInteger( sSecao,'nNF'   ,RefNFP.nNF);
                end
               else if trim(refCTe) <> '' then
                begin
                  INIRec.WriteString(  sSecao,'Tipo','CTe') ;
                  INIRec.WriteString(  sSecao,'reCTe',refCTe) ;
                end
               else if trim(RefECF.nCOO) <> '' then
                begin
                  INIRec.WriteString(  sSecao,'Tipo','ECF') ;
                  INIRec.WriteString(  sSecao,'modelo'  ,ECFModRefToStr(RefECF.modelo));
                  INIRec.WriteString(  sSecao,'nECF'  ,RefECF.nECF);
                  INIRec.WriteString(  sSecao,'nCOO'  ,RefECF.nCOO);
                end;
             end;
          end;

         INIRec.WriteString(  'Emitente','CNPJ'    ,Emit.CNPJCPF );
         INIRec.WriteString(  'Emitente','Razao'   ,Emit.xNome);
         INIRec.WriteString(  'Emitente','Fantasia', Emit.xFant );
         INIRec.WriteString(  'Emitente','IE'      ,Emit.IE);
         INIRec.WriteString(  'Emitente','IEST',Emit.IEST);
         INIRec.WriteString(  'Emitente','IM'  ,Emit.IM);
         INIRec.WriteString(  'Emitente','CNAE',Emit.CNAE);
         INIRec.WriteString(  'Emitente','CRT' ,CRTToStr(Emit.CRT));

         INIRec.WriteString(  'Emitente','Logradouro' ,Emit.EnderEmit.xLgr);
         INIRec.WriteString(  'Emitente','Numero'     ,Emit.EnderEmit.nro);
         INIRec.WriteString(  'Emitente','Complemento',Emit.EnderEmit.xCpl);
         INIRec.WriteString(  'Emitente','Bairro'     ,Emit.EnderEmit.xBairro);
         INIRec.WriteInteger( 'Emitente','CidadeCod'  ,Emit.EnderEmit.cMun);
         INIRec.WriteString(  'Emitente','Cidade'     ,Emit.EnderEmit.xMun);
         INIRec.WriteString(  'Emitente','UF'         ,Emit.EnderEmit.UF);
         INIRec.WriteInteger( 'Emitente','CEP'        ,Emit.EnderEmit.CEP);
         INIRec.WriteInteger( 'Emitente','PaisCod'    ,Emit.EnderEmit.cPais);
         INIRec.WriteString(  'Emitente','Pais'       ,Emit.EnderEmit.xPais);
         INIRec.WriteString(  'Emitente','Fone'       ,Emit.EnderEmit.fone);

         if Avulsa.CNPJ  <> '' then
          begin
            INIRec.WriteString(  'Avulsa','CNPJ'   ,Avulsa.CNPJ);
            INIRec.WriteString(  'Avulsa','xOrgao' ,Avulsa.xOrgao);
            INIRec.WriteString(  'Avulsa','matr'   ,Avulsa.matr );
            INIRec.WriteString(  'Avulsa','xAgente',Avulsa.xAgente);
            INIRec.WriteString(  'Avulsa','fone'   ,Avulsa.fone);
            INIRec.WriteString(  'Avulsa','UF'     ,Avulsa.UF);
            INIRec.WriteString(  'Avulsa','nDAR'   ,Avulsa.nDAR);
            INIRec.WriteString(  'Avulsa','dEmi'   ,DateToStr(Avulsa.dEmi));
            INIRec.WriteFloat(   'Avulsa','vDAR'   ,Avulsa.vDAR);
            INIRec.WriteString(  'Avulsa','repEmi' ,Avulsa.repEmi);
            INIRec.WriteString(  'Avulsa','dPag'   ,DateToStr(Avulsa.dPag));
          end;

         INIRec.WriteString(  'Destinatario','CNPJ'       ,Dest.CNPJCPF);
         INIRec.WriteString(  'Destinatario','NomeRazao'  ,Dest.xNome);
         INIRec.WriteString(  'Destinatario','IE'         ,Dest.IE);
         INIRec.WriteString(  'Destinatario','ISUF'       ,Dest.ISUF);
         INIRec.WriteString(  'Destinatario','Email'      ,Dest.Email);

         INIRec.WriteString(  'Destinatario','Logradouro' ,Dest.EnderDest.xLgr);
         INIRec.WriteString(  'Destinatario','Numero'     ,Dest.EnderDest.nro);
         INIRec.WriteString(  'Destinatario','Complemento',Dest.EnderDest.xCpl);
         INIRec.WriteString(  'Destinatario','Bairro'     ,Dest.EnderDest.xBairro);
         INIRec.WriteInteger( 'Destinatario','CidadeCod'  ,Dest.EnderDest.cMun);
         INIRec.WriteString(  'Destinatario','Cidade'     ,Dest.EnderDest.xMun);
         INIRec.WriteString(  'Destinatario','UF'         ,Dest.EnderDest.UF );
         INIRec.WriteInteger( 'Destinatario','CEP'        ,Dest.EnderDest.CEP);
         INIRec.WriteInteger( 'Destinatario','PaisCod'    ,Dest.EnderDest.cPais);
         INIRec.WriteString(  'Destinatario','Pais'       ,Dest.EnderDest.xPais);
         INIRec.WriteString(  'Destinatario','Fone'       ,Dest.EnderDest.Fone);

         if Retirada.CNPJCPF <> '' then
          begin
            INIRec.WriteString( 'Retirada','CNPJ',Retirada.CNPJCPF);
            INIRec.WriteString( 'Retirada','xLgr',Retirada.xLgr);
            INIRec.WriteString( 'Retirada','nro' ,Retirada.nro);
            INIRec.WriteString( 'Retirada','xCpl',Retirada.xCpl);
            INIRec.WriteString( 'Retirada','xBairro',Retirada.xBairro);
            INIRec.WriteInteger('Retirada','cMun',Retirada.cMun);
            INIRec.WriteString( 'Retirada','xMun',Retirada.xMun);
            INIRec.WriteString( 'Retirada','UF'  ,Retirada.UF);
          end;

         if Entrega.CNPJCPF <> '' then
          begin
            INIRec.WriteString(  'Entrega','CNPJ',Entrega.CNPJCPF);
            INIRec.WriteString(  'Entrega','xLgr',Entrega.xLgr);
            INIRec.WriteString(  'Entrega','nro' ,Entrega.nro);
            INIRec.WriteString(  'Entrega','xCpl',Entrega.xCpl);
            INIRec.WriteString(  'Entrega','xBairro',Entrega.xBairro);
            INIRec.WriteInteger( 'Entrega','cMun',Entrega.cMun);
            INIRec.WriteString(  'Entrega','xMun',Entrega.xMun);
            INIRec.WriteString(  'Entrega','UF'  ,Entrega.UF);
          end;

         for I := 0 to Det.Count-1 do
          begin
            with Det.Items[I] do
             begin
               sSecao    := 'Produto'+IntToStrZero(I+1,3) ;
               INIRec.WriteInteger( sSecao,'nItem'    ,Prod.nItem );
               INIRec.WriteString(  sSecao,'infAdProd',infAdProd);

               INIRec.WriteString(  sSecao,'Codigo'   ,Prod.cProd );
               INIRec.WriteString(  sSecao,'EAN'      ,Prod.cEAN);
               INIRec.WriteString(  sSecao,'Descricao',Prod.xProd);
               INIRec.WriteString(  sSecao,'NCM'      ,Prod.NCM);
               INIRec.WriteString(  sSecao,'EXTIPI'   ,Prod.EXTIPI);
               INIRec.WriteString( sSecao,'CFOP'      ,Prod.CFOP);
               INIRec.WriteString( sSecao,'Unidade'   ,Prod.uCom);
               INIRec.WriteFloat(sSecao,'Quantidade'   ,Prod.qCom) ;
               INIRec.WriteFloat(sSecao,'ValorUnitario',Prod.vUnCom) ;
               INIRec.WriteFloat(sSecao,'ValorTotal'   ,Prod.vProd) ;

               INIRec.WriteString( sSecao,'cEANTrib'      ,Prod.cEANTrib);
               INIRec.WriteString( sSecao,'uTrib'  , Prod.uTrib);
               INIRec.WriteFloat(sSecao,'qTrib'  ,Prod.qTrib);
               INIRec.WriteFloat(sSecao,'vUnTrib',Prod.vUnTrib) ;

               INIRec.WriteFloat(sSecao,'vFrete',Prod.vFrete) ;
               INIRec.WriteFloat(sSecao,'vSeg',Prod.vSeg) ;
               INIRec.WriteFloat(sSecao,'ValorDesconto',Prod.vDesc) ;
               INIRec.WriteFloat(sSecao,'vOutro',Prod.vOutro) ;
               INIRec.WriteString(sSecao,'IndTot',indTotToStr(Prod.IndTot));

               INIRec.WriteString(  sSecao,'xPed'     , Prod.xPed);
               INIRec.WriteInteger( sSecao,'nItemPed' , Prod.nItemPed);

               INIRec.WriteFloat(sSecao,'vTotTrib',Imposto.vTotTrib) ;

               for J:=0 to Prod.DI.Count-1 do
                begin
                  if Prod.DI.Items[j].nDi <> '' then
                   begin
                     with Prod.DI.Items[j] do
                      begin
                        sSecao      := 'DI'+IntToStrZero(I+1,3)+IntToStrZero(J+1,3) ;
                        INIRec.WriteString(sSecao,'NumeroDI',nDi);
                        INIRec.WriteString(sSecao,'DataRegistroDI'  ,DateToStr(dDi));
                        INIRec.WriteString(sSecao,'LocalDesembaraco',xLocDesemb);
                        INIRec.WriteString(sSecao,'UFDesembaraco'   ,UFDesemb);
                        INIRec.WriteString(sSecao,'DataDesembaraco',DateToStr(dDesemb));
                        INIRec.WriteString(sSecao,'CodigoExportador',cExportador);;

                        for K:=0 to adi.Count-1 do
                         begin
                           with adi.Items[K] do
                            begin
                              sSecao      := 'LADI'+IntToStrZero(I+1,3)+IntToStrZero(J+1,3)+IntToStrZero(K+1,3)  ;
                              INIRec.WriteInteger(sSecao,'NumeroAdicao',nAdicao) ;
                              INIRec.WriteInteger(sSecao,'nSeqAdi'     ,nSeqAdi) ;
                              INIRec.WriteString( sSecao,'CodigoFrabricante',cFabricante);
                              INIRec.WriteFloat(  sSecao,'DescontoADI' ,vDescDI);
                            end;
                         end;
                      end;
                   end
                  else
                    Break;
                end;

              if Prod.veicProd.chassi <> '' then
               begin
                 sSecao := 'Veiculo'+IntToStrZero(I+1,3) ;
                 with Prod.veicProd do
                  begin
                    INIRec.WriteString( sSecao,'tpOP'  ,tpOPToStr(tpOP));
                    INIRec.WriteString( sSecao,'Chassi',chassi) ;
                    INIRec.WriteString( sSecao,'cCor'   ,cCor);
                    INIRec.WriteString( sSecao,'xCor'   ,xCor);
                    INIRec.WriteString( sSecao,'pot'    ,pot);
                    INIRec.WriteString( sSecao,'CM3'    ,Cilin);  //Mantido por compatibilidade com NFe 1.1
                    INIRec.WriteString( sSecao,'Cilin'  ,Cilin);                    
                    INIRec.WriteString( sSecao,'pesoL'  ,pesoL);
                    INIRec.WriteString( sSecao,'pesoB'  ,pesoB);
                    INIRec.WriteString( sSecao,'nSerie' ,nSerie);
                    INIRec.WriteString( sSecao,'tpComb' ,tpComb);
                    INIRec.WriteString( sSecao,'nMotor' ,nMotor);
                    INIRec.WriteString( sSecao,'CMKG'   ,CMT);    //Mantido por compatibilidade com NFe 1.1
                    INIRec.WriteString( sSecao,'CMT'    ,CMT);
                    INIRec.WriteString( sSecao,'dist'   ,dist);
//                    INIRec.WriteString( sSecao,'RENAVAM',RENAVAM);
                    INIRec.WriteInteger(sSecao,'anoMod' ,anoMod);
                    INIRec.WriteInteger(sSecao,'anoFab' ,anoFab);
                    INIRec.WriteString( sSecao,'tpPint' ,tpPint);
                    INIRec.WriteInteger(sSecao,'tpVeic' ,tpVeic);
                    INIRec.WriteInteger(sSecao,'espVeic',espVeic);
                    INIRec.WriteString( sSecao,'VIN'    ,VIN);
                    INIRec.WriteString( sSecao,'condVeic',condVeicToStr(condVeic));
                    INIRec.WriteString( sSecao,'cMod'   ,cMod);
                    INIRec.WriteString( sSecao,'cCorDENATRAN' ,cCorDENATRAN);
                    INIRec.WriteInteger(sSecao,'lota'   ,lota);
                    INIRec.WriteInteger(sSecao,'tpRest' ,tpRest);
                  end;
               end;

               for J:=0 to Prod.med.Count-1 do
                begin
                  sSecao := 'Medicamento'+IntToStrZero(I+1,3)+IntToStrZero(J+1,3) ;
                  with Prod.med.Items[J] do
                   begin
                     INIRec.WriteString(sSecao,'nLote',nLote) ;
                     INIRec.WriteFloat( sSecao,'qLote',qLote) ;
                     INIRec.WriteString(sSecao,'dFab',DateToStr(dFab)) ;
                     INIRec.WriteString(sSecao,'dVal',DateToStr(dVal)) ;
                     INIRec.WriteFloat( sSecao,'vPMC',vPMC) ;
                    end;
                end;

               for J:=0 to Prod.arma.Count-1 do
                begin
                  sSecao := 'Arma'+IntToStrZero(I+1,3)+IntToStrZero(J+1,3) ;
                  with Prod.arma.Items[J] do
                   begin
                     INIRec.WriteString( sSecao,'tpArma',tpArmaToStr(tpArma)) ;
                     INIRec.WriteString( sSecao,'nSerie',nSerie) ;
                     INIRec.WriteString( sSecao,'nCano' ,nCano) ;
                     INIRec.WriteString( sSecao,'descr' ,descr) ;
                    end;
                end;

               if (Prod.comb.cProdANP > 0) then
                begin
                 sSecao := 'Combustivel'+IntToStrZero(I+1,3) ;
                 with Prod.comb do
                  begin
                    INIRec.WriteInteger( sSecao,'cProdANP',cProdANP) ;
                    INIRec.WriteString(  sSecao,'CODIF'   ,CODIF) ;
                    INIRec.WriteFloat(   sSecao,'qTemp'   ,qTemp) ;
                    INIRec.WriteString(  sSecao,'UFCons'  ,UFcons) ;

                    sSecao := 'CIDE'+IntToStrZero(I+1,3) ;
                    INIRec.WriteFloat( sSecao,'qBCprod'  ,CIDE.qBCprod) ;
                    INIRec.WriteFloat( sSecao,'vAliqProd',CIDE.vAliqProd) ;
                    INIRec.WriteFloat( sSecao,'vCIDE'    ,CIDE.vCIDE) ;


                    if infNFe.Versao < 2 then
                     begin
                       sSecao := 'ICMSComb'+IntToStrZero(I+1,3) ;
                       INIRec.WriteFloat( sSecao,'vBCICMS'  ,ICMS.vBCICMS) ;
                       INIRec.WriteFloat( sSecao,'vICMS'    ,ICMS.vICMS) ;
                       INIRec.WriteFloat( sSecao,'vBCICMSST',ICMS.vBCICMSST) ;
                       INIRec.WriteFloat( sSecao,'vICMSST'  ,ICMS.vICMSST) ;

                       if (ICMSInter.vBCICMSSTDest>0) then
                        begin
                          sSecao := 'ICMSInter'+IntToStrZero(I+1,3) ;
                          INIRec.WriteFloat( sSecao,'vBCICMSSTDest',ICMSInter.vBCICMSSTDest) ;
                          INIRec.WriteFloat( sSecao,'vICMSSTDest'  ,ICMSInter.vICMSSTDest) ;
                        end;

                       if (ICMSCons.vBCICMSSTCons>0) then
                        begin
                          sSecao := 'ICMSCons'+IntToStrZero(I+1,3) ;
                          INIRec.WriteFloat( sSecao,'vBCICMSSTCons',ICMSCons.vBCICMSSTCons) ;
                          INIRec.WriteFloat( sSecao,'vICMSSTCons'  ,ICMSCons.vICMSSTCons) ;
                          INIRec.WriteString(sSecao,'UFCons'       ,ICMSCons.UFcons) ;
                        end;
                     end;
                  end;
               end;

               with Imposto do
                begin
                   sSecao := 'ICMS'+IntToStrZero(I+1,3) ;
                   with ICMS do
                    begin
                      INIRec.WriteString( sSecao,'Origem',OrigToStr(ICMS.orig));
                      INIRec.WriteString( sSecao,'CST',CSTICMSToStr(CST));
                      INIRec.WriteString( sSecao,'CSOSN',CSOSNIcmsToStr(CSOSN));
                      INIRec.WriteString(sSecao,'Modalidade',modBCToStr(ICMS.modBC));
                      INIRec.WriteFloat( sSecao,'PercentualReducao',ICMS.pRedBC);
                      INIRec.WriteFloat( sSecao,'ValorBase',ICMS.vBC);
                      INIRec.WriteFloat( sSecao,'Aliquota' ,ICMS.pICMS);
                      INIRec.WriteFloat( sSecao,'Valor'    ,ICMS.vICMS);
                      INIRec.WriteString(sSecao,'ModalidadeST',modBCSTToStr(ICMS.modBCST));
                      INIRec.WriteFloat( sSecao,'PercentualMargemST' ,ICMS.pMVAST);
                      INIRec.WriteFloat( sSecao,'PercentualReducaoST',ICMS.pRedBCST);
                      INIRec.WriteFloat( sSecao,'ValorBaseST',ICMS.vBCST);
                      INIRec.WriteFloat( sSecao,'AliquotaST' ,ICMS.pICMSST);
                      INIRec.WriteFloat( sSecao,'ValorST'    ,ICMS.vICMSST);
                      INIRec.WriteString(sSecao,'UFST'       ,ICMS.UFST);
                      INIRec.WriteFloat( sSecao,'pBCOp'      ,ICMS.pBCOp);
                      INIRec.WriteFloat( sSecao,'vBCSTRet'   ,ICMS.vBCSTRet);
                      INIRec.WriteFloat( sSecao,'vICMSSTRet' ,ICMS.vICMSSTRet);
                      INIRec.WriteString(sSecao,'motDesICMS' ,motDesICMSToStr(ICMS.motDesICMS));
                      INIRec.WriteFloat( sSecao,'pCredSN'    ,ICMS.pCredSN);
                      INIRec.WriteFloat( sSecao,'vCredICMSSN',ICMS.vCredICMSSN);
                      INIRec.WriteFloat( sSecao,'vBCSTDest'  ,ICMS.vBCSTDest);
                      INIRec.WriteFloat( sSecao,'vICMSSTDest',ICMS.vICMSSTDest);
                    end;

                   if (IPI.vBC > 0) or
                      (IPI.qUnid > 0) or
                      (IPI.vIPI > 0) then
                    begin
                      sSecao := 'IPI'+IntToStrZero(I+1,3) ;
                      with IPI do
                       begin
                         INIRec.WriteString(  sSecao,'CST',CSTIPIToStr(CST)) ;
                         INIRec.WriteString(  sSecao,'ClasseEnquadramento',clEnq);
                         INIRec.WriteString(  sSecao,'CNPJProdutor'       ,CNPJProd);
                         INIRec.WriteString(  sSecao,'CodigoSeloIPI'      ,cSelo);
                         INIRec.WriteInteger( sSecao,'QuantidadeSelos'    ,qSelo);
                         INIRec.WriteString(  sSecao,'CodigoEnquadramento',cEnq);

                         INIRec.WriteFloat( sSecao,'ValorBase'   ,vBC);
                         INIRec.WriteFloat(sSecao,'Quantidade'  ,qUnid);
                         INIRec.WriteFloat(sSecao,'ValorUnidade',vUnid);
                         INIRec.WriteFloat(sSecao,'Aliquota'    ,pIPI);
                         INIRec.WriteFloat(sSecao,'Valor'       ,vIPI);
                       end;
                    end;

                   if (II.vBc > 0) then
                    begin
                      sSecao   := 'II'+IntToStrZero(I+1,3) ;
                      with II do
                       begin
                         INIRec.WriteFloat(sSecao,'ValorBase',vBc);
                         INIRec.WriteFloat(sSecao,'ValorDespAduaneiras',vDespAdu);
                         INIRec.WriteFloat(sSecao,'ValorII'  ,vII);
                         INIRec.WriteFloat(sSecao,'ValorIOF' ,vIOF);
                       end;
                    end;

                   sSecao    := 'PIS'+IntToStrZero(I+1,3) ;
                   with PIS do
                    begin
                      INIRec.WriteString( sSecao,'CST',CSTPISToStr(CST));

                      if (CST = pis01) or (CST = pis02) then
                       begin
                         INIRec.WriteFloat(sSecao,'ValorBase',PIS.vBC);
                         INIRec.WriteFloat(sSecao,'Aliquota' ,PIS.pPIS);
                         INIRec.WriteFloat(sSecao,'Valor'    ,PIS.vPIS);
                       end
                      else if CST = pis03 then
                       begin
                         INIRec.WriteFloat(sSecao,'Quantidade'   ,PIS.qBCProd);
                         INIRec.WriteFloat(sSecao,'ValorAliquota',PIS.vAliqProd);
                         INIRec.WriteFloat(sSecao,'Valor'        ,PIS.vPIS);
                       end
                      else if CST = pis99 then
                       begin
                         INIRec.WriteFloat(sSecao,'ValorBase' ,PIS.vBC);
                         INIRec.WriteFloat(sSecao,'Aliquota'  ,PIS.pPIS);
                         INIRec.WriteFloat(sSecao,'Quantidade',PIS.qBCProd);
                         INIRec.WriteFloat(sSecao,'ValorAliquota',PIS.vAliqProd);
                         INIRec.WriteFloat(sSecao,'Valor'     ,PIS.vPIS);
                       end;
                    end;

                   if (PISST.vBc>0) then
                    begin
                      sSecao    := 'PISST'+IntToStrZero(I+1,3) ;
                      with PISST do
                       begin
                         INIRec.WriteFloat(sSecao,'ValorBase'    ,vBc);
                         INIRec.WriteFloat(sSecao,'AliquotaPerc' ,pPis);
                         INIRec.WriteFloat(sSecao,'Quantidade'   ,qBCProd);
                         INIRec.WriteFloat(sSecao,'AliquotaValor',vAliqProd);
                         INIRec.WriteFloat(sSecao,'ValorPISST'   ,vPIS);
                       end;
                     end;

                   sSecao    := 'COFINS'+IntToStrZero(I+1,3) ;
                   with COFINS do
                    begin
                      INIRec.WriteString( sSecao,'CST',CSTCOFINSToStr(CST));

                      if (CST = cof01) or (CST = cof02)   then
                       begin
                         INIRec.WriteFloat(sSecao,'ValorBase',COFINS.vBC);
                         INIRec.WriteFloat(sSecao,'Aliquota' ,COFINS.pCOFINS);
                         INIRec.WriteFloat(sSecao,'Valor'    ,COFINS.vCOFINS);
                       end
                      else if CST = cof03 then
                       begin
                         INIRec.WriteFloat(sSecao,'Quantidade',COFINS.qBCProd);
                         INIRec.WriteFloat(sSecao,'Aliquota'  ,COFINS.vAliqProd);
                         INIRec.WriteFloat(sSecao,'Valor'     ,COFINS.vCOFINS);
                       end
                      else if CST = cof99 then
                       begin
                         INIRec.WriteFloat(sSecao,'Valor'     ,COFINS.vBC);
                         INIRec.WriteFloat(sSecao,'Aliquota'  ,COFINS.pCOFINS);
                         INIRec.WriteFloat(sSecao,'Quantidade',COFINS.qBCProd);
                         INIRec.WriteFloat(sSecao,'ValorAliquota',COFINS.vAliqProd);
                         INIRec.WriteFloat(sSecao,'ValorBase' ,COFINS.vCOFINS);
                       end;
                    end;

                   if (COFINSST.vBC > 0) then
                    begin
                      sSecao    := 'COFINSST'+IntToStrZero(I+1,3) ;
                      with COFINSST do
                       begin
                         INIRec.WriteFloat(sSecao,'ValorBase'    ,vBC);
                         INIRec.WriteFloat(sSecao,'AliquotaPerc' ,pCOFINS);
                         INIRec.WriteFloat(sSecao,'Quantidade'   ,qBCProd);
                         INIRec.WriteFloat(sSecao,'AliquotaValor',vAliqProd);
                         INIRec.WriteFloat(sSecao,'ValorCOFINSST',vCOFINS);
                       end;
                    end;

                   if (ISSQN.vBC > 0) then
                    begin
                     sSecao    := 'ISSQN'+IntToStrZero(I+1,3) ;
                     with ISSQN do
                      begin
                        INIRec.WriteFloat(  sSecao,'ValorBase' ,vBC);
                        INIRec.WriteFloat(  sSecao,'Aliquota'  ,vAliq);
                        INIRec.WriteFloat(  sSecao,'ValorISSQN',vISSQN);
                        INIRec.WriteInteger(sSecao,'MunicipioFatoGerador',cMunFG);
                        INIRec.WriteString(sSecao,'CodigoServico',cListServ);
                        INIRec.WriteString( sSecao,'cSitTrib',ISSQNcSitTribToStr(cSitTrib));
                      end;
                    end;
                end;

             end;
          end ;

         INIRec.WriteFloat('Total','BaseICMS'     ,Total.ICMSTot.vBC) ;
         INIRec.WriteFloat('Total','ValorICMS'    ,Total.ICMSTot.vICMS) ;
         INIRec.WriteFloat('Total','BaseICMSSubstituicao' ,Total.ICMSTot.vBCST) ;
         INIRec.WriteFloat('Total','ValorICMSSubstituicao',Total.ICMSTot.vST) ;
         INIRec.WriteFloat('Total','ValorProduto' ,Total.ICMSTot.vProd) ;
         INIRec.WriteFloat('Total','ValorFrete'   ,Total.ICMSTot.vFrete) ;
         INIRec.WriteFloat('Total','ValorSeguro'  ,Total.ICMSTot.vSeg) ;
         INIRec.WriteFloat('Total','ValorDesconto',Total.ICMSTot.vDesc) ;
         INIRec.WriteFloat('Total','ValorII'      ,Total.ICMSTot.vII) ;
         INIRec.WriteFloat('Total','ValorIPI'     ,Total.ICMSTot.vIPI) ;
         INIRec.WriteFloat('Total','ValorPIS'     ,Total.ICMSTot.vPIS) ;
         INIRec.WriteFloat('Total','ValorCOFINS'  ,Total.ICMSTot.vCOFINS) ;
         INIRec.WriteFloat('Total','ValorOutrasDespesas',Total.ICMSTot.vOutro) ;
         INIRec.WriteFloat('Total','ValorNota'    ,Total.ICMSTot.vNF) ;
         INIRec.WriteFloat('Total','vTotTrib'    ,Total.ICMSTot.vTotTrib) ;

         INIRec.WriteFloat('Total','ValorServicos',Total.ISSQNtot.vServ) ;
         INIRec.WriteFloat('Total','ValorBaseISS' ,Total.ISSQNTot.vBC) ;
         INIRec.WriteFloat('Total','ValorISSQN'   ,Total.ISSQNTot.vISS) ;
         INIRec.WriteFloat('Total','ValorPISISS'  ,Total.ISSQNTot.vPIS) ;
         INIRec.WriteFloat('Total','ValorCONFINSISS',Total.ISSQNTot.vCOFINS) ;

         INIRec.WriteFloat('retTrib','vRetPIS'   ,Total.retTrib.vRetPIS) ;
         INIRec.WriteFloat('retTrib','vRetCOFINS',Total.retTrib.vRetCOFINS) ;
         INIRec.WriteFloat('retTrib','vRetCSLL'  ,Total.retTrib.vRetCSLL) ;
         INIRec.WriteFloat('retTrib','vBCIRRF'   ,Total.retTrib.vBCIRRF) ;
         INIRec.WriteFloat('retTrib','vIRRF'     ,Total.retTrib.vIRRF) ;
         INIRec.WriteFloat('retTrib','vBCRetPrev',Total.retTrib.vBCRetPrev) ;
         INIRec.WriteFloat('retTrib','vRetPrev'  ,Total.retTrib.vRetPrev) ;

         INIRec.WriteString('Transportador','FretePorConta',modFreteToStr(Transp.modFrete));
         INIRec.WriteString('Transportador','CnpjCpf'  ,Transp.Transporta.CNPJCPF);
         INIRec.WriteString('Transportador','NomeRazao',Transp.Transporta.xNome);
         INIRec.WriteString('Transportador','IE'       ,Transp.Transporta.IE);
         INIRec.WriteString('Transportador','Endereco' ,Transp.Transporta.xEnder);
         INIRec.WriteString('Transportador','Cidade'   ,Transp.Transporta.xMun);
         INIRec.WriteString('Transportador','UF'       ,Transp.Transporta.UF);

         INIRec.WriteFloat( 'Transportador','ValorServico',Transp.retTransp.vServ) ;
         INIRec.WriteFloat( 'Transportador','ValorBase'   ,Transp.retTransp.vBCRet) ;
         INIRec.WriteFloat( 'Transportador','Aliquota'    ,Transp.retTransp.pICMSRet) ;
         INIRec.WriteFloat( 'Transportador','Valor'       ,Transp.retTransp.vICMSRet) ;
         INIRec.WriteString('Transportador','CFOP'        ,Transp.retTransp.CFOP);
         INIRec.WriteInteger('Transportador','CidadeCod'  ,Transp.retTransp.cMunFG);

         INIRec.WriteString('Transportador','Placa'  ,Transp.veicTransp.placa);
         INIRec.WriteString('Transportador','UFPlaca',Transp.veicTransp.UF);
         INIRec.WriteString('Transportador','RNTC'   ,Transp.veicTransp.RNTC);

         INIRec.WriteString( 'Transportador','vagao' ,Transp.vagao) ;
         INIRec.WriteString( 'Transportador','balsa' ,Transp.balsa) ;

         for J:=0 to Transp.Reboque.Count-1 do
          begin
            sSecao := 'Reboque'+IntToStrZero(J+1,3) ;
            with Transp.Reboque.Items[J] do
             begin
               INIRec.WriteString(sSecao,'placa',placa) ;
               INIRec.WriteString( sSecao,'UF'  ,UF) ;
               INIRec.WriteString( sSecao,'RNTC',RNTC) ;
             end;
          end;

         for I:=0 to Transp.Vol.Count-1 do
          begin
            sSecao    := 'Volume'+IntToStrZero(I+1,3) ;
            with Transp.Vol.Items[I] do
             begin
               INIRec.WriteInteger(sSecao,'Quantidade' ,qVol) ;
               INIRec.WriteString( sSecao,'Especie'    ,esp);
               INIRec.WriteString( sSecao,'Marca'      ,marca);
               INIRec.WriteString( sSecao,'Numeracao'  ,nVol);
               INIRec.WriteFloat(  sSecao,'PesoLiquido',pesoL) ;
               INIRec.WriteFloat(  sSecao,'PesoBruto'  ,pesoB) ;

               for J:=0 to Lacres.Count-1 do
                begin
                  sSecao := 'Lacre'+IntToStrZero(I+1,3)+IntToStrZero(J+1,3) ;
                  INIRec.WriteString(sSecao,'nLacre',Lacres.Items[J].nLacre) ;
                end;
             end;
          end;

         INIRec.WriteString('Fatura','Numero',Cobr.Fat.nFat);
         INIRec.WriteFloat( 'Fatura','ValorOriginal',Cobr.Fat.vOrig) ;
         INIRec.WriteFloat( 'Fatura','ValorDesconto',Cobr.Fat.vDesc) ;
         INIRec.WriteFloat( 'Fatura','ValorLiquido' ,Cobr.Fat.vLiq) ;

         for I:=0 to Cobr.Dup.Count-1 do
          begin
            sSecao    := 'Duplicata'+IntToStrZero(I+1,3) ;
            with Cobr.Dup.Items[I] do
             begin
               INIRec.WriteString(sSecao,'Numero',nDup) ;
               INIRec.WriteString(sSecao,'DataVencimento',DateToStr(dVenc));
               INIRec.WriteFloat( sSecao,'Valor' ,vDup) ;
             end;
          end;

         INIRec.WriteString( 'DadosAdicionais','Fisco',InfAdic.infAdFisco);
         INIRec.WriteString( 'DadosAdicionais','Complemento',InfAdic.infCpl);

         for I:=0 to InfAdic.obsCont.Count-1 do
          begin
            sSecao     := 'InfAdic'+IntToStrZero(I+1,3) ;
            with InfAdic.obsCont.Items[I] do
             begin
               INIRec.WriteString(sSecao,'Campo',xCampo) ;
               INIRec.WriteString(sSecao,'Texto',xTexto);
             end;
          end;

         for I:=0 to InfAdic.obsFisco.Count-1 do
          begin
            sSecao     := 'ObsFisco'+IntToStrZero(I+1,3) ;
            with InfAdic.obsFisco.Items[I] do
             begin
               INIRec.WriteString(sSecao,'Campo',xCampo) ;
               INIRec.WriteString(sSecao,'Texto',xTexto);
             end;
          end;

         for I:=0 to InfAdic.procRef.Count-1 do
          begin
            sSecao     := 'procRef'+IntToStrZero(I+1,3) ;
            with InfAdic.procRef.Items[I] do
             begin
               INIRec.WriteString(sSecao,'nProc',nProc) ;
               INIRec.WriteString( sSecao,'indProc', indProcToStr(indProc));
             end;
          end;

         if (exporta.UFembarq <> '') then
          begin
            INIRec.WriteString( 'Exporta','UFembarq'  ,exporta.UFembarq) ;
            INIRec.WriteString( 'Exporta','xLocEmbarq',exporta.xLocEmbarq);
          end;

         if (compra.xNEmp <> '') then
          begin
            INIRec.WriteString( 'Compra','xNEmp',compra.xNEmp) ;
            INIRec.WriteString( 'Compra','xPed' ,compra.xPed);
            INIRec.WriteString( 'Compra','xCont',compra.xCont);
          end;

         INIRec.WriteString('cana','safra'   ,cana.safra);
         INIRec.WriteString('cana','ref'     ,cana.ref);
         INIRec.WriteFloat( 'cana','qTotMes' ,cana.qTotMes) ;
         INIRec.WriteFloat( 'cana','qTotAnt' ,cana.qTotAnt) ;
         INIRec.WriteFloat( 'cana','qTotGer' ,cana.qTotGer) ;
         INIRec.WriteFloat( 'cana','vFor'    ,cana.vFor) ;
         INIRec.WriteFloat( 'cana','vTotDed' ,cana.vTotDed) ;
         INIRec.WriteFloat( 'cana','vLiqFor' ,cana.vLiqFor) ;

         for I:=0 to cana.fordia.Count-1 do
          begin
            sSecao    := 'forDia'+IntToStrZero(I+1,3) ;
            with cana.fordia.Items[I] do
             begin
               INIRec.WriteInteger(sSecao,'dia',dia) ;
               INIRec.WriteFloat( sSecao,'qtde' ,qtde) ;
             end;
          end;

         for I:=0 to cana.deduc.Count-1 do
          begin
            sSecao    := 'deduc'+IntToStrZero(I+1,3) ;
            with cana.deduc.Items[I] do
             begin
               INIRec.WriteString(sSecao,'xDed',xDed) ;
               INIRec.WriteFloat( sSecao,'vDed' ,vDed) ;
             end;
          end;                        

          INIRec.WriteString('procNFe','tpAmb',TpAmbToStr(procNFe.tpAmb)) ;
          INIRec.WriteString('procNFe','verAplic',procNFe.verAplic) ;
          INIRec.WriteString('procNFe','chNFe',procNFe.chNFe) ;
          INIRec.WriteString('procNFe','dhRecbto'  ,DateToStr(procNFe.dhRecbto));
          INIRec.WriteString('procNFe','nProt',procNFe.nProt) ;
          INIRec.WriteString('procNFe','digVal',procNFe.digVal) ;
          INIRec.WriteString('procNFe','cStat',IntToStr(procNFe.cStat)) ;
          INIRec.WriteString('procNFe','xMotivo',procNFe.xMotivo) ;
       end;
   finally
      IniNFe := TStringList.Create;
      INIRec.GetStrings(IniNfe);
      INIRec.Free ;
      Result := StringReplace(IniNFe.Text,sLineBreak+sLineBreak,sLineBreak,[rfReplaceAll]);
      IniNFe.Free;
   end;
  end;
end;

function SubstituirVariaveis(const ATexto: String): String;
var
  TextoStr: String;
begin
  if Trim(ATexto) = '' then
    Result := ''
  else
  begin
    TextoStr := ATexto;

    if frmAcbrNfeMonitor.ACBrNFe1.NotasFiscais.Count > 0 then
    begin
      with frmAcbrNfeMonitor.ACBrNFe1.NotasFiscais.Items[0].NFe do
      begin
        TextoStr := StringReplace(TextoStr,'[EmitNome]',     Emit.xNome,   [rfReplaceAll, rfIgnoreCase]);
        TextoStr := StringReplace(TextoStr,'[EmitFantasia]', Emit.xFant,   [rfReplaceAll, rfIgnoreCase]);
        TextoStr := StringReplace(TextoStr,'[EmitCNPJCPF]',  Emit.CNPJCPF, [rfReplaceAll, rfIgnoreCase]);
        TextoStr := StringReplace(TextoStr,'[EmitIE]',       Emit.IE,      [rfReplaceAll, rfIgnoreCase]);

        TextoStr := StringReplace(TextoStr,'[DestNome]',     Dest.xNome,   [rfReplaceAll, rfIgnoreCase]);
        TextoStr := StringReplace(TextoStr,'[DestCNPJCPF]',  Dest.CNPJCPF, [rfReplaceAll, rfIgnoreCase]);
        TextoStr := StringReplace(TextoStr,'[DestIE]',       Dest.IE,      [rfReplaceAll, rfIgnoreCase]);

        TextoStr := StringReplace(TextoStr,'[ChaveNFe]',     procNFe.chNFe, [rfReplaceAll, rfIgnoreCase]);

        TextoStr := StringReplace(TextoStr,'[SerieNF]',      FormatFloat('000',           Ide.serie),         [rfReplaceAll, rfIgnoreCase]);
        TextoStr := StringReplace(TextoStr,'[NumeroNF]',     FormatFloat('000000000',     Ide.nNF),           [rfReplaceAll, rfIgnoreCase]);
        TextoStr := StringReplace(TextoStr,'[ValorNF]',      FormatFloat('0.00',          Total.ICMSTot.vNF), [rfReplaceAll, rfIgnoreCase]);
        TextoStr := StringReplace(TextoStr,'[dtEmissao]',    FormatDateTime('dd/mm/yyyy', Ide.dEmi),          [rfReplaceAll, rfIgnoreCase]);
        TextoStr := StringReplace(TextoStr,'[dtSaida]',      FormatDateTime('dd/mm/yyyy', Ide.dSaiEnt),       [rfReplaceAll, rfIgnoreCase]);
        TextoStr := StringReplace(TextoStr,'[hrSaida]',      FormatDateTime('hh:mm:ss',   Ide.hSaiEnt),       [rfReplaceAll, rfIgnoreCase]);
      end;
    end
    else
    if frmAcbrNfeMonitor.ACBrCTe1.Conhecimentos.Count > 0 then
    begin
      with frmAcbrNfeMonitor.ACBrCTe1.Conhecimentos.Items[0].CTe do
      begin
        TextoStr := StringReplace(TextoStr,'[EmitNome]',     Emit.xNome,   [rfReplaceAll, rfIgnoreCase]);
        TextoStr := StringReplace(TextoStr,'[EmitFantasia]', Emit.xFant,   [rfReplaceAll, rfIgnoreCase]);
        TextoStr := StringReplace(TextoStr,'[EmitCNPJ]',     Emit.CNPJ, [rfReplaceAll, rfIgnoreCase]);
        TextoStr := StringReplace(TextoStr,'[EmitIE]',       Emit.IE,      [rfReplaceAll, rfIgnoreCase]);

        TextoStr := StringReplace(TextoStr,'[DestNome]',     Dest.xNome,   [rfReplaceAll, rfIgnoreCase]);
        TextoStr := StringReplace(TextoStr,'[DestCNPJCPF]',  Dest.CNPJCPF, [rfReplaceAll, rfIgnoreCase]);
        TextoStr := StringReplace(TextoStr,'[DestIE]',       Dest.IE,      [rfReplaceAll, rfIgnoreCase]);

        TextoStr := StringReplace(TextoStr,'[ChaveCTe]',     procCTe.chCTe, [rfReplaceAll, rfIgnoreCase]);

        TextoStr := StringReplace(TextoStr,'[NumeroCT]',     FormatFloat('000000000',     Ide.nCT),           [rfReplaceAll, rfIgnoreCase]);
//        TextoStr := StringReplace(TextoStr,'[ValorCT]',      FormatFloat('0.00',          Total.ICMSTot.vNF), [rfReplaceAll, rfIgnoreCase]);
//        TextoStr := StringReplace(TextoStr,'[dtEmissao]',    FormatDateTime('dd/mm/yyyy', Ide.dEmi),          [rfReplaceAll, rfIgnoreCase]);
//        TextoStr := StringReplace(TextoStr,'[dtSaida]',      FormatDateTime('dd/mm/yyyy', Ide.dSaiEnt),       [rfReplaceAll, rfIgnoreCase]);
//        TextoStr := StringReplace(TextoStr,'[hrSaida]',      FormatDateTime('hh:mm:ss',   Ide.hSaiEnt),       [rfReplaceAll, rfIgnoreCase]);

      end;
    end;

    Result := TextoStr;
  end;
end;


procedure EnviarEmail(const sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto, sAttachment, sAttachment2: String; sMensagem : TStrings; SSL, TLS : Boolean; sCopias: String='');
var
  smtp: TSMTPSend;
  msg_lines: TStringList;
  m:TMimemess;
  p: TMimepart;
  CC: Tstrings;
  I : Integer;
  CorpoEmail: TStringList;
begin
  msg_lines := TStringList.Create;
  CorpoEmail := TStringList.Create;
  smtp := TSMTPSend.Create;
  m:=TMimemess.create;
  try
     p := m.AddPartMultipart('mixed', nil);
     if sMensagem <> nil then
     begin
        CorpoEmail.Text := SubstituirVariaveis(sMensagem.Text);
        m.AddPartText(CorpoEmail, p);
     end;

     if sAttachment <> '' then
       m.AddPartBinaryFromFile(sAttachment, p);
     if sAttachment2 <> '' then
       m.AddPartBinaryFromFile(sAttachment2, p);
     m.header.tolist.add(sTo);
     m.header.From := sFrom;
     m.header.subject:=SubstituirVariaveis(sAssunto);
     m.EncodeMessage;
     msg_lines.Add(m.Lines.Text);

     smtp.UserName := sSmtpUser;
     smtp.Password := sSmtpPasswd;

     smtp.TargetHost := sSmtpHost;
     smtp.TargetPort := sSmtpPort;

     smtp.FullSSL := SSL;
     smtp.AutoTLS := TLS;
     if not smtp.Login() then
       raise Exception.Create('SMTP ERROR: Login:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

     if not smtp.MailFrom(sFrom, Length(sFrom)) then
       raise Exception.Create('SMTP ERROR: MailFrom:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
     if not smtp.MailTo(sTo) then
       raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
     if DFeUtil.NaoEstaVazio(sCopias) then
      begin
        CC:=TstringList.Create;
        CC.DelimitedText := sLineBreak;
        CC.Text := StringReplace(sCopias,';',sLineBreak,[rfReplaceAll]);
        for I := 0 to CC.Count - 1 do
        begin
           if not smtp.MailTo(CC.Strings[i]) then
              raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
        end;
      end;
     if not smtp.MailData(msg_lines) then
       raise Exception.Create('SMTP ERROR: MailData:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

     if not smtp.Logout() then
       raise Exception.Create('SMTP ERROR: Logout:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
  finally
     msg_lines.Free;
     CorpoEmail.Free;
     smtp.Free;
     m.free;
  end;
end;

procedure EnviarEmailIndy(const sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto, sAttachment, sAttachment2: String; sMensagem : TStrings; SSL, TLS : Boolean; sCopias: String='');
var
  IdSMTP    : TIdSMTP;
  IdMessage : TIdMessage;
  IdISSLOHANDLERSocket : TIdSSLIOHandlerSocket;
begin
  IdSMTP    := TIdSMTP.Create(Application);
  IdMessage := TIdMessage.Create(Application);
  IdISSLOHANDLERSocket := TIdSSLIOHandlerSocket.Create(Application);
  try
     IdSMTP.Host := sSmtpHost;
     IdSMTP.Port := StrToIntDef(sSmtpPort,25);
     IdSMTP.Username := sSmtpUser;
     IdSMTP.Password := sSmtpPasswd;

     if SSL or TLS then
      begin
        IdISSLOHANDLERSocket.SSLOptions.Method := sslvSSLv3;
        if TLS and not SSL then
           IdISSLOHANDLERSocket.SSLOptions.Method := sslvTLSv1;
        IdISSLOHANDLERSocket.SSLOptions.Mode := sslmClient;
        IdSMTP.AuthenticationType := atLogin;
        IdSMTP.IOHandler := IdISSLOHANDLERSocket;
      end
     else
        IdSMTP.AuthenticationType := atNone;

     IdMessage.From.Address := sFrom;
     IdMessage.Recipients.EMailAddresses := sTo;
     if DFeUtil.NaoEstaVazio(sCopias) then
        IdMessage.CCList.EMailAddresses := sCopias;

     IdMessage.Priority := mpNormal;
     IdMessage.Subject := SubstituirVariaveis(sAssunto);
     IdMessage.Body.Text := SubstituirVariaveis(sMensagem.Text);

     if DFeUtil.NaoEstaVazio(sAttachment) then
        TIdAttachment.create(IdMessage.MessageParts, sAttachment);

     if DFeUtil.NaoEstaVazio(sAttachment2) then
        TIdAttachment.create(IdMessage.MessageParts, sAttachment2);

     try
        IdSMTP.Connect;
     except
        IdSMTP.Connect;
     end;

     try
        IdSMTP.Send(IdMessage);
     finally
        IdSMTP.Disconnect;
     end;
  finally
    IdISSLOHANDLERSocket.Free;
    IdMessage.Free;
    IdSMTP.Free;
  end;
end;

procedure GerarIniEvento( AStr: WideString; CCe : Boolean = False ) ;
var
  I      : Integer;
  sSecao, sFim : String;
  INIRec : TMemIniFile ;
  SL     : TStringList;
  ok     : Boolean;
begin
 INIRec := TMemIniFile.create( 'evento.ini' ) ;

 SL := TStringList.Create;
 if FilesExists(Astr) then
    SL.LoadFromFile(AStr)
 else
    Sl.Text := ConvertStrRecived( Astr );

 INIRec.SetStrings( SL );
 SL.Free ;

 with frmAcbrNfeMonitor do
  begin
   try
     ACBrNFe1.EventoNFe.idLote := INIRec.ReadInteger( 'EVENTO','idLote' ,INIRec.ReadInteger( 'CCE','idLote',0));
     ACBrNFe1.EventoNFe.Evento.Clear;
     I := 1 ;
     while true do
      begin
        sSecao := 'EVENTO'+IntToStrZero(I,3) ;
        sFim   := INIRec.ReadString(  sSecao,'chNFe'  ,'FIM');
        if (sFim = 'FIM') or (Length(sFim) <= 0) then
           break ;

        with ACBrNFe1.EventoNFe.Evento.Add do
         begin
           infEvento.cOrgao := INIRec.ReadInteger( sSecao,'cOrgao' ,0);
           infEvento.CNPJ   := INIRec.ReadString(  sSecao,'CNPJ' ,'');
           infEvento.chNFe  := INIRec.ReadString(  sSecao,'chNFe' ,'');
           infEvento.dhEvento :=  NotaUtil.StringToDateTime(INIRec.ReadString(  sSecao,'dhEvento' ,''));
           if CCe then
            begin
              infEvento.tpEvento := teCCe;
//              infEvento.detEvento.descEvento := 'Carta de Corre��o';
            end
           else
            begin
             infEvento.tpEvento := StrToTpEvento(ok,INIRec.ReadString(  sSecao,'tpEvento' ,''));
//             infEvento.detEvento.descEvento := INIRec.ReadString(  sSecao,'descEvento' ,'');
            end;

           infEvento.nSeqEvento   := INIRec.ReadInteger( sSecao,'nSeqEvento' ,1);
           infEvento.versaoEvento := INIRec.ReadString(  sSecao,'versaoEvento' ,'1.00');;

           // Alterado por Italo em 15/01/2015
           if infEvento.tpEvento = teEPECNFe then
           begin
             infEvento.detEvento.cOrgaoAutor := INIRec.ReadInteger(sSecao, 'cOrgaoAutor', 0);
//           TpcnTipoAutor = (taEmpresaEmitente, taEmpresaDestinataria, taEmpresa, taFisco, taRFB, taOutros)
             infEvento.detEvento.tpAutor     := StrToTipoAutor(ok,INIRec.ReadString(sSecao, 'tpAutor', '1'));
             infEvento.detEvento.verAplic    := INIRec.ReadString(sSecao, 'verAplic', '1.0');
             infEvento.detEvento.dhEmi       := NotaUtil.StringToDateTime(INIRec.ReadString(sSecao, 'dhEmi', ''));
//           TpcnTipoNFe = (tnEntrada, tnSaida)
             infEvento.detEvento.tpNF        := StrToTpNF(ok,INIRec.ReadString(sSecao, 'tpNF', '1'));
             infEvento.detEvento.IE          := INIRec.ReadString(sSecao, 'IE', '');

             infEvento.detEvento.dest.UF      := INIRec.ReadString('DEST', 'UF', '');
             infEvento.detEvento.dest.CNPJCPF := INIRec.ReadString('DEST', 'CNPJCPF', '');
             infEvento.detEvento.dest.IE      := INIRec.ReadString('DEST', 'IE', '');

             infEvento.detEvento.vNF   := StringToFloatDef(INIRec.ReadString(sSecao, 'vNF', ''), 0);
             infEvento.detEvento.vICMS := StringToFloatDef(INIRec.ReadString(sSecao, 'vICMS', ''), 0);
             infEvento.detEvento.vST   := StringToFloatDef(INIRec.ReadString(sSecao, 'vST', ''), 0);
           end
           else begin
             infEvento.detEvento.xCorrecao := INIRec.ReadString(  sSecao,'xCorrecao' ,'');
             infEvento.detEvento.xCondUso  := INIRec.ReadString(  sSecao,'xCondUso' ,''); //Texto fixo conforme NT 2011.003 -  http://www.nfe.fazenda.gov.br/portal/exibirArquivo.aspx?conteudo=tsiloeZ6vBw=
             infEvento.detEvento.nProt     := INIRec.ReadString(  sSecao,'nProt' ,'');
             infEvento.detEvento.xJust     := INIRec.ReadString(  sSecao,'xJust' ,'');
           end;
         end;
        Inc(I);
      end;
   finally
      INIRec.Free;
   end;
 end;
end;


end.
