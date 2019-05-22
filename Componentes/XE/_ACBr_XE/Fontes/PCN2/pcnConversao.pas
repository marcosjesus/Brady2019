///////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar NFe                                    //
//                                                                            //
//   Descri��o: Classes para gera��o/leitura dos arquivos xml da NFe          //
//                                                                            //
//        site: www.projetocooperar.org/nfe                                   //
//       email: projetocooperar@zipmail.com.br                                //
//       forum: http://br.groups.yahoo.com/group/projeto_cooperar_nfe/        //
//     projeto: http://code.google.com/p/projetocooperar/                     //
//         svn: http://projetocooperar.googlecode.com/svn/trunk/              //
//                                                                            //
// Coordena��o: (c) 2009 - Paulo Casagrande                                   //
//                                                                            //
//      Equipe: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
// Desenvolvimento                                                            //
//         de Cte: Wiliam Zacarias da Silva Rosa                              //
//                                                                            //
//      Vers�o: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//     Licen�a: GNU Lesser General Public License (GNU LGPL)                  //
//                                                                            //
//              - Este programa � software livre; voc� pode redistribu�-lo    //
//              e/ou modific�-lo sob os termos da Licen�a P�blica Geral GNU,  //
//              conforme publicada pela Free Software Foundation; tanto a     //
//              vers�o 2 da Licen�a como (a seu crit�rio) qualquer vers�o     //
//              mais nova.                                                    //
//                                                                            //
//              - Este programa � distribu�do na expectativa de ser �til,     //
//              mas SEM QUALQUER GARANTIA; sem mesmo a garantia impl�cita de  //
//              COMERCIALIZA��O ou de ADEQUA��O A QUALQUER PROP�SITO EM       //
//              PARTICULAR. Consulte a Licen�a P�blica Geral GNU para obter   //
//              mais detalhes. Voc� deve ter recebido uma c�pia da Licen�a    //
//              P�blica Geral GNU junto com este programa; se n�o, escreva    //
//              para a Free Software Foundation, Inc., 59 Temple Place,       //
//              Suite 330, Boston, MA - 02111-1307, USA ou consulte a         //
//              licen�a oficial em http://www.gnu.org/licenses/gpl.txt        //
//                                                                            //
//    Nota (1): - Esta  licen�a  n�o  concede  o  direito  de  uso  do nome   //
//              "PCN  -  Projeto  Cooperar  NFe", n�o  podendo o mesmo ser    //
//              utilizado sem previa autoriza��o.                             //
//                                                                            //
//    Nota (2): - O uso integral (ou parcial) das units do projeto esta       //
//              condicionado a manuten��o deste cabe�alho junto ao c�digo     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

{*******************************************************************************
|* Historico
|*
|* 28/09/2012: Italo
|*  - Inclu�do constantes com as vers�es atuais dos WebServices
*******************************************************************************}

{$I ACBr.inc}

unit pcnConversao;

interface uses

  SysUtils,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  Classes;

type
  TStatusACBrNFe = (stIdle, stNFeStatusServico, stNFeRecepcao, stNFeRetRecepcao,
                    stNFeConsulta, stNFeCancelamento, stNFeInutilizacao, stNFeRecibo,
                    stNFeCadastro, stNFeEmail, stNFeEnvDPEC, stNFeConsultaDPEC,
                    stNFeCCe, stNFeEvento, stConsNFeDest, stDownloadNFe, stAdmCSCNFCe,
                    stDistDFeInt, stEnvioWebService);

  TStatusACBrCTe = (stCTeIdle, stCTeStatusServico, stCTeRecepcao, stCTeRetRecepcao,
                    stCTeConsulta, stCTeCancelamento, stCTeInutilizacao, stCTeRecibo,
                    stCTeCadastro, stCTeEmail, stCTeCCe, stCTeEvento, stCTeEnvioWebService);

  TStatusACBrMDFe = (stMDFeIdle, stMDFeStatusServico, stMDFeRecepcao, stMDFeRetRecepcao,
                     stMDFeConsulta, stMDFeRecibo, stMDFeEmail, stMDFeEvento, stMDFeDistDFeInt,
                     stMDFeEnvioWebService);

  (* IMPORTANTE - Sempre que alterar um Tipo efetuar a atualiza��o das fun��es de convers�o correspondentes *)
  TLayOut = (LayNfeRecepcao, LayNfeRetRecepcao, LayNfeCancelamento,
             LayNfeInutilizacao, LayNfeConsulta, LayNfeStatusServico,
             LayNfeCadastro, LayNfeEnvDPEC, LayNfeConsultaDPEC, LayNFeCCe,
             LayNFeEvento, LayNFeEventoAN, LayNFeConsNFeDest, LayNFeDownloadNFe,
             LayNfeAutorizacao, LayNfeRetAutorizacao, LayAdministrarCSCNFCe,
             LayDistDFeInt, LayNFCeEPEC);

  TLayOutCTe = (LayCTeRecepcao, LayCTeRetRecepcao, LayCTeCancelamento,
                LayCTeInutilizacao, LayCTeConsultaCT, LayCTeStatusServico,
                LayCTeCadastro, LayCTeEvento, LayCTeEventoEPEC);

//  TLayOutMDFe = (LayMDFeRecepcao, LayMDFeRetRecepcao, LayMDFeConsulta,
//                 LayMDFeStatusServico, LayMDFeEvento);

  TpcnSchema = (TsPL005c, TsPL006,
                TsPL_CTe_103, TsPL_CTe_104,
                TsPL_MDFe_100);

  TpcnTipoLayout = (tlAtuCadEmiDFe, tlCadEmiDFe, tlCancNFe, tlConsCad, tlConsReciNFe,
                    tlConsSitNFe, tlConsStatServ, tlInutNFe, tlNFe, tlProcNFe,
                    tlProcInutNFe, tlRetAtuCadEmiDFe, tlRetCancNFe, tlRetConsCad,
                    tlRetConsReciNFe, tlRetConsStatServ, tlRetConsSitNFe, tlRetEnvNFe,
                    tlRetInutNFe, tlEnvNFe, tlProcCancNFe, tlCancCTe, tlConsReciCTe,
                    tlConsSitCTe, tlInutCTe, tlCTe, tlProcCTe, tlProcInutCTe, tlRetCancCTe,
                    tlRetConsReciCTe, tlRetConsSitCTe, tlRetEnvCTe, tlRetInutCTe,
                    tlEnvCTe, tlProcCancCTe, tlEnvDPEC, tlConsDPEC, tlConsStatServCTe,
                    tlCCeNFe, tlEnvCCeNFe, tlRetEnvCCeNFe, tlEnvEventoNFe, tlRetEnvEventoNFe,
                    tlConsNFeDest, tlDownloadNFe);

  TpcnTipoCampo = (tcStr, tcInt, tcDat, tcDatHor, tcEsp, tcDe2, tcDe3, tcDe4, tcDe10,
                   tcHor, tcDe6, tcDatCFe, tcHorCFe, tcDatVcto); // tcEsp = String: somente numeros;
  TpcnFormatoGravacao = (fgXML, fgTXT);
  TpcnTagAssinatura = (taSempre, taNunca, taSomenteSeAssinada, taSomenteParaNaoAssinada);

  TpcnIndicadorPagamento = (ipVista, ipPrazo, ipOutras);
  TpcnTipoNFe = (tnEntrada, tnSaida);
  TpcnTipoImpressao = (tiSemGeracao, tiRetrato, tiPaisagem, tiSimplificado,
                       tiNFCe, tiMsgEletronica, tiNFCeA4);
  TpcnPercentualTributos = (ptValorProdutos, ptValorNF, ptPersonalizado);

  TpcnTipoEmissao = (teNormal, teContingencia, teSCAN, teDPEC, teFSDA, teSVCAN, teSVCRS, teSVCSP, teOffLine);
  TpcnTipoAmbiente = (taProducao, taHomologacao);
  TpcnSituacaoEmissor = (seHomologacao, seProducao);
  TpcnFinalidadeNFe = (fnNormal, fnComplementar, fnAjuste, fnDevolucao);
  TpcnProcessoEmissao = (peAplicativoContribuinte, peAvulsaFisco, peAvulsaContribuinte, peContribuinteAplicativoFisco);
  TpcnTipoOperacao = (toVendaConcessionaria, toFaturamentoDireto, toVendaDireta, toOutros);
  TpcnCondicaoVeiculo = (cvAcabado, cvInacabado, cvSemiAcabado);
  TpcnTipoArma = (taUsoPermitido, taUsoRestrito);
  TpcnOrigemMercadoria = (oeNacional, oeEstrangeiraImportacaoDireta, oeEstrangeiraAdquiridaBrasil,
                          oeNacionalConteudoImportacaoSuperior40, oeNacionalProcessosBasicos,
                          oeNacionalConteudoImportacaoInferiorIgual40,
                          oeEstrangeiraImportacaoDiretaSemSimilar, oeEstrangeiraAdquiridaBrasilSemSimilar,
                          oeNacionalConteudoImportacaoSuperior70);
  TpcnCSTIcms = (cst00, cst10, cst20, cst30, cst40, cst41, cst45, cst50, cst51,
                 cst60, cst70, cst80, cst81, cst90, cstPart10, cstPart90,
                 cstRep41, cstVazio, cstICMSOutraUF, cstICMSSN); //80 e 81 apenas para CTe
  TpcnCSOSNIcms = (csosnVazio,csosn101, csosn102, csosn103, csosn201, csosn202, csosn203, csosn300, csosn400, csosn500,csosn900 );
  TpcnDeterminacaoBaseIcms = (dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao);
  TpcnDeterminacaoBaseIcmsST = (dbisPrecoTabelado, dbisListaNegativa, dbisListaPositiva, dbisListaNeutra, dbisMargemValorAgregado, dbisPauta);
  TpcnMotivoDesoneracaoICMS = (mdiTaxi, mdiDeficienteFisico, mdiProdutorAgropecuario, mdiFrotistaLocadora, mdiDiplomaticoConsular,
                               mdiAmazoniaLivreComercio, mdiSuframa, mdiVendaOrgaosPublicos, mdiOutros, mdiDeficienteCondutor,
                               mdiDeficienteNaoCondutor, mdiOrgaoFomento );
  TpcnCstIpi = (ipi00, ipi49, ipi50, ipi99, ipi01, ipi02, ipi03, ipi04, ipi05, ipi51, ipi52, ipi53, ipi54, ipi55);
  TpcnCstPis = (pis01, pis02, pis03, pis04, pis05, pis06, pis07, pis08, pis09, pis49, pis50, pis51, pis52, pis53, pis54, pis55, pis56, pis60, pis61, pis62, pis63, pis64, pis65, pis66, pis67, pis70, pis71, pis72, pis73, pis74, pis75, pis98, pis99);
  TpcnCstCofins = (cof01, cof02, cof03, cof04, cof05, cof06, cof07, cof08, cof09, cof49, cof50, cof51, cof52, cof53, cof54, cof55, cof56, cof60, cof61, cof62, cof63, cof64, cof65, cof66, cof67, cof70, cof71, cof72, cof73, cof74, cof75, cof98, cof99);
  TpcnModalidadeFrete = (mfContaEmitente, mfContaDestinatario, mfContaTerceiros, mfSemFrete);
  TpcnIndicadorProcesso = (ipSEFAZ, ipJusticaFederal, ipJusticaEstadual, ipSecexRFB, ipOutros);
  TpcnCRT = (crtSimplesNacional, crtSimplesExcessoReceita, crtRegimeNormal);
  TpcnIndicadorTotal = (itSomaTotalNFe, itNaoSomaTotalNFe );

  TpcteFormaPagamento = (fpPago, fpAPagar, fpOutros);
  TpcteTipoCTe = (tcNormal, tcComplemento, tcAnulacao, tcSubstituto);
  TpcteModal = (mdRodoviario, mdAereo, mdAquaviario, mdFerroviario, mdDutoviario, mdMultimodal);
  TpcteTipoServico = (tsNormal, tsSubcontratacao, tsRedespacho, tsIntermediario, tsMultimodal);
  TpcteRetira = (rtSim, rtNao);
  TpcteTomador = ( tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros);
  TpcteRspSeg = (rsRemetente, rsExpedidor, rsRecebedor, rsDestinatario, rsEmitenteCTe, rsTomadorServico);
  TpcteLotacao = (ltNao, ltSim);
  TpcteProp = (tpTACAgregado, tpTACIndependente, tpOutros);
  TpcteMask = (msk4x2, msk7x2, msk9x2, msk10x2, msk13x2, msk15x2, msk6x3, mskAliq);
  UnidMed = (uM3,uKG, uTON, uUNIDADE, uLITROS, uMMBTU);
  TpcnECFModRef = (ECFModRefVazio, ECFModRef2B,ECFModRef2C,ECFModRef2D);
  TpcnISSQNcSitTrib  = ( ISSQNcSitTribVazio , ISSQNcSitTribNORMAL, ISSQNcSitTribRETIDA, ISSQNcSitTribSUBSTITUTA,ISSQNcSitTribISENTA);
  TpcteDirecao = (drNorte, drLeste, drSul, drOeste);
  TpcteTipoNavegacao = (tnInterior, tnCabotagem);
  TpcteTipoTrafego = (ttProprio, ttMutuo, ttRodoferroviario, ttRodoviario);
  TpcteTipoDataPeriodo = (tdSemData, tdNaData, tdAteData, tdApartirData, tdNoPeriodo, tdNaoInformado);
  TpcteTipoHorarioIntervalo = (thSemHorario, thNoHorario, thAteHorario, thApartirHorario, thNoIntervalo, thNaoInformado);
  TpcteTipoDocumento = (tdDeclaracao, tdDutoviario, tdOutros);
  TpcteTipoDocumentoAnterior = (daCTRC, daCTAC, daACT, daNF7, daNF27, daCAN, daCTMC, daATRE, daDTA, daCAI, daCCPI, daCA, daTIF, daOutros);
  TpcteRspPagPedagio = (rpEmitente, rpRemetente, rpExpedidor, rpRecebedor, rpDestinatario, rpTomadorServico);
  TpcteTipoDispositivo = (tdCartaoMagnetico, tdTAG, tdTicket);
  TpcteTipoPropriedade = (tpProprio, tpTerceiro);
  TpcteTipoVeiculo = (tvTracao, tvReboque);
  TpcteTipoRodado = (trNaoAplicavel, trTruck, trToco, trCavaloMecanico, trVAN, trUtilitario, trOutros);
  TpcteTipoCarroceria = (tcNaoAplicavel, tcAberta, tcFechada, tcGraneleira, tcPortaContainer, tcSider);
  TPosRecibo = (prCabecalho, prRodape);
  TpcteModeloNF = (moNF011AAvulsa, moNFProdutor);
  TpcteTrafegoMutuo = (tmOrigem, tmDestino);

  TpcnTpEvento = (teCCe, teCancelamento, teManifDestConfirmacao, teManifDestCiencia,
                  teManifDestDesconhecimento, teManifDestOperNaoRealizada,
                  teEncerramento, teEPEC, teInclusaoCondutor, teMultiModal,
                  teRegistroPassagem, teRegistroPassagemBRId, teEPECNFe,
                  teRegistroCTe, teRegistroPassagemNFeCancelado,
                  teRegistroPassagemNFeRFID, teCTeCancelado, teMDFeCancelado,
                  teVistoriaSuframa);

  TpcnIndicadorNFe = (inTodas, inSemManifestacaoComCiencia, inSemManifestacaoSemCiencia);
  TpcnIndicadorEmissor = (ieTodos, ieRaizCNPJDiferente);
  TpcnIndicadorContinuacao = (icNaoPossuiMaisDocumentos, icPossuiMaisDocumentos);
  TpcnSituacaoNFe = (snAutorizado,snDenegado,snCancelada);
  TpcnSituacaoManifDest = (smdSemManifestacao, smdConfirmada, smdDesconhecida, smdOperacaoNaoRealizada, smdCiencia);
  TpcnTamanhoPapel = (tpA4, tpA4_2vias, tpA5);

  TpcnModeloDF = (moNFe, moNFCe);
  TpcnVersaoDF = (ve200, ve300, ve310);

  TpcnDestinoOperacao = (doInterna, doInterestadual, doExterior);
  TpcnConsumidorFinal = (cfNao, cfConsumidorFinal);
  TpcnPresencaComprador = (pcNao, pcPresencial, pcInternet, pcTeleatendimento, pcEntregaDomicilio, pcOutros);
  TpcnFormaPagamento = (fpDinheiro, fpCheque, fpCartaoCredito, fpCartaoDebito, fpCreditoLoja,
                        fpValeAlimentacao, fpValeRefeicao, fpValePresente, fpValeCombustivel,
                        fpOutro);
  TpcnBandeiraCartao = (bcVisa, bcMasterCard, bcAmericanExpress, bcSorocred, bcOutros);

  TpcnRegTrib = (RTSimplesNacional, RTRegimeNormal);
  TpcnRegTribISSQN = (RTISSMicroempresaMunicipal, RTISSEstimativa, RTISSSociedadeProfissionais, RTISSCooperativa, RTISSMEI, RTISSMEEPP, RTISSNenhum);
  TpcnindRatISSQN = (irSim, irNao);
  TpcnindRegra = (irArredondamento, irTruncamento);
  TpcnCodigoMP = (mpDinheiro, mpCheque, mpCartaodeCredito, mpCartaodeDebito, mpCreditoLoja, mpValeAlimentacao, mpValeRefeicao, mpValePresente, mpValeCombustivel, mpOutros);
  TpcnUnidTransp = ( utRodoTracao, utRodoReboque, utNavio, utBalsa, utAeronave, utVagao, utOutros );
  TpcnUnidCarga  = ( ucContainer, ucULD, ucPallet, ucOutros );
  TpcnindNegociavel = (inNaoNegociavel, inNegociavel);
  TpcnindIEDest = (inContribuinte, inIsento, inNaoContribuinte);
  TpcnTipoViaTransp = (tvMaritima, tvFluvial, tvLacustre, tvAerea, tvPostal,
                       tvFerroviaria, tvRodoviaria, tvConduto, tvMeiosProprios,
                       tvEntradaSaidaFicta, tvCourier, tvHandcarry);
  TpcnTipoIntermedio = (tiContaPropria, tiContaOrdem, tiEncomenda);
  TpcnindISSRet = (iirSim, iirNao);
  TpcnindISS = (iiExigivel, iiNaoIncidencia, iiIsencao, iiExportacao, iiImunidade, iiExigSuspDecisaoJudicial, iiExigSuspProcessoAdm);
  TpcnindIncentivo = (iiSim, iiNao);
  // Incluido por Italo em 20/05/2014
  TpcnTipoAutor = (taEmpresaEmitente, taEmpresaDestinataria, taEmpresa, taFisco, taRFB, taOutros);
  // Incluido por Italo em 25/08/2014
  TpcnIndOperacao = (ioConsultaCSC, ioNovoCSC, ioRevogaCSC);

  // Incluido por Italo em 18/02/2015
  TpcnTipoSchema = (tsresNFe, tsresEvento, tsprocNFe, tsprocEventoNFe,
                    tsprocMDFe, tsprocEventoMDFe);

const
  TpcnTpEventoString : array[0..18] of String =('110110',
                                                '110111',
                                                '210200',
                                                '210210',
                                                '210220',
                                                '210240',
                                                '110112',
                                                '110113',
                                                '110114',
                                                '110160',
                                                '310620',
                                                '510620',
                                                '110140',
                                                '610600',
                                                '610501',
                                                '610550',
                                                '610601',
                                                '610611',
                                                '990900');

  NFeUF: array[0..26] of String =
  ('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA',
   'PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO');
  NFeUFCodigo: array[0..26] of Integer =
  (12,27,16,13,29,23,53,32,52,21,51,50,31,15,25,41,26,22,33,24,43,11,14,42,35,28,17);

  NfVersao        = '2.0.0.0';
  // -----------------------------
  // As constantes abaixo futuramente n�o v�o mais ser necess�rias
  // -----------------------------
//  NFecabMsg       = '2.00';
//  NFeconsStatServ = '2.00';
//  NFenviNFe       = '2.00';
//  NFeconsReciNFe  = '2.00';
//  NFeconsSitNFe   = '2.01';
//  NFecancNFe      = '2.00';
//  NFeinutNFe      = '2.00';
//  NFeconsCad      = '2.00';
//  NFeEnvDPEC      = '1.01';
//  NFeConsDPEC     = '1.01';
//  NFeCCeNFe       = '1.00';
//  NFeEventoNFe    = '1.00';
//  NFeConsNFeDest  = '1.01';
//  NFeDownloadNFe  = '1.00';

//  NFCeCabMsg       = '2.00';
//  NFCeConsStatServ = '3.00';
//  NFCeEnvi         = '3.00';
//  NFCeConsReci     = '3.00';
//  NFCeConsSit      = '3.00';
//  NFCeCanc         = '3.00';
//  NFCeInut         = '3.00';
//  NFCeConsCad      = '2.00';
//  NFCeEnvDPEC      = '1.01';
//  NFCeConsDPEC     = '1.01';
//  NFCeCCe          = '1.00';
//  NFCeEvento       = '1.00';
//  NFCeConsNFeDest  = '1.01';
//  NFCeDownloadNFe  = '1.00';
  // -----------------------------

  MDFeCabMsg       = '1.00';
  MDFeConsStatServ = '1.00';
  MDFeEnviMDFe     = '1.00';
  MDFeConsReciMDFe = '1.00';
  MDFeConsSitMDFe  = '1.00';
  MDFeConsNaoEnc   = '1.00';
  MDFeEventoMDFe   = '1.00';

  MDFeModalRodo    = '1.00';
  MDFeModalAereo   = '1.00';
  MDFeModalAqua    = '1.00';
  MDFeModalFerro   = '1.00';
  MDFeModalDuto    = '1.00';

  // Incluido por Claudemir em 13/03/2013
  GNREEnviGNRE     = '1.00';
  GNREConsConfigUF = '1.00';
  GNREConsResLote  = '1.00';

{$IFDEF PL_103}
  CTecabMsg       = '1.02';
  CTeconsStatServ = '1.03';
  CTeenviCTe      = '1.03';
  CTeconsReciCTe  = '1.03';
  CTeconsSitCTe   = '1.03';
  CTecancCTe      = '1.03';
  CTeinutCTe      = '1.03';
  CTeconsCad      = '2.00';
  CTeEventoCTe    = '0.00';
{$ENDIF}

{$IFDEF PL_104}
  CTecabMsg       = '1.02';
  CTeconsStatServ = '1.04';
  CTeenviCTe      = '1.04';
  CTeconsReciCTe  = '1.04';
  CTeconsSitCTe   = '1.04';
  CTecancCTe      = '1.04';
  CTeinutCTe      = '1.04';
  CTeconsCad      = '2.00';
  CTeEventoCTe    = '1.04';

  CTeModalRodo    = '1.04';
  CTeModalAereo   = '1.04';
  CTeModalAqua    = '1.04';
  CTeModalFerro   = '1.04';
  CTeModalDuto    = '1.04';
  CTeMultiModal   = '0.00';
{$ENDIF}

{$IFDEF PL_200}
  CTecabMsg       = '2.00';
  CTeconsStatServ = '2.00';
  CTeenviCTe      = '2.00';
  CTeconsReciCTe  = '2.00';
  CTeconsSitCTe   = '2.00';
  CTecancCTe      = '1.04';
  CTeinutCTe      = '2.00';
  CTeconsCad      = '2.00';
  CTeEventoCTe    = '2.00';

  CTeModalRodo    = '2.00';
  CTeModalAereo   = '2.00';
  CTeModalAqua    = '2.00';
  CTeModalFerro   = '2.00';
  CTeModalDuto    = '2.00';
  CTeMultiModal   = '2.00';
{$ENDIF}

  Msg_ICMS_123_2006 = 'ICMS a ser recolhido conforme LC 123/2006 - Simples Nacional' ;

  LineBreak = #13#10;

function StrToHex(S: String): String;
function StrToEnumerado(out ok: boolean; const s: string; const AString: array of string;
  const AEnumerados: array of variant): variant;
function EnumeradoToStr(const t: variant; const AString:
  array of string; const AEnumerados: array of variant): variant;

function StrToEnumerado2(out ok: boolean;  const s: string; Const AString: array of string ): variant;
function EnumeradoToStr2(const t: variant; const AString: array of string ): variant;

function SchemaToStr(const t: TpcnSchema): string;
function StrToSchema(out ok: boolean; const s: string): TpcnSchema;
function TipoLayoutToStr(const t: TpcnTipoLayout): string;
function StrToTipoLayout(out ok: boolean; const s: string): TpcnTipoLayout;
function IndpagToStr(const t: TpcnIndicadorPagamento): string;
function StrToIndpag(out ok: boolean; const s: string): TpcnIndicadorPagamento;
function tpNFToStr(const t: TpcnTipoNFe): string;
function StrToTpNF(out ok: boolean; const s: string): TpcnTipoNFe;
function TpImpToStr(const t: TpcnTipoImpressao): string;
function StrToTpImp(out ok: boolean; const s: string): TpcnTipoImpressao;
function PercTribToStr(const t: TpcnPercentualTributos): string;
function StrToPercTrib(out ok: boolean; const s: string): TpcnPercentualTributos;
function TpEmisToStr(const t: TpcnTipoEmissao): string;
function StrToTpEmis(out ok: boolean; const s: string): TpcnTipoEmissao;
function TpAmbToStr(const t: TpcnTipoAmbiente): string;
function StrToTpAmb(out ok: boolean; const s: string): TpcnTipoAmbiente;
function TpSitToStr(const t: TpcnSituacaoEmissor): string;
function StrToTpSit(out ok: boolean; const s: string): TpcnSituacaoEmissor;
function FinNFeToStr(const t: TpcnFinalidadeNFe): string;
function StrToFinNFe(out ok: boolean; const s: string): TpcnFinalidadeNFe;
function procEmiToStr(const t: TpcnProcessoEmissao): string;
function StrToprocEmi(out ok: boolean; const s: string): TpcnProcessoEmissao;
function tpOPToStr(const t: TpcnTipoOperacao): string;
function StrTotpOP(out ok: boolean; const s: string): TpcnTipoOperacao;
function condVeicToStr(const t: TpcnCondicaoVeiculo): string;
function StrTocondVeic(out ok: boolean; const s: string): TpcnCondicaoVeiculo;
function tpArmaToStr(const t: TpcnTipoArma): string;
function StrTotpArma(out ok: boolean; const s: string): TpcnTipoArma;
function OrigToStr(const t: TpcnOrigemMercadoria): string;
function StrToOrig(out ok: boolean; const s: string): TpcnOrigemMercadoria;
function CSTICMSToStr(const t: TpcnCSTIcms): string;
function StrToCSTICMS(out ok: boolean; const s: string): TpcnCSTIcms;
function CSOSNIcmsToStr(const t: TpcnCSOSNIcms): string;
function StrToCSOSNIcms(out ok: boolean; const s: string): TpcnCSOSNIcms;
function CSTICMSToStrTagPos(const t: TpcnCSTIcms): string;
function CSTICMSToStrTagPosText(const t: TpcnCSTIcms): string;
function CSOSNToStrTagPos(const t: TpcnCSOSNIcms): string;
function CSOSNToStrID(const t: TpcnCSOSNIcms): string;

function modBCToStr(const t: TpcnDeterminacaoBaseIcms): string;
function StrTomodBC(out ok: boolean; const s: string): TpcnDeterminacaoBaseIcms;
function modBCSTToStr(const t: TpcnDeterminacaoBaseIcmsST): string;
function StrTomodBCST(out ok: boolean; const s: string): TpcnDeterminacaoBaseIcmsST;
function motDesICMSToStr(const t: TpcnMotivoDesoneracaoICMS): string;
function StrTomotDesICMS(out ok: boolean; const s: string): TpcnMotivoDesoneracaoICMS;
function CSTIPIToStr(const t: TpcnCstIpi): string;
function StrToCSTIPI(out ok: boolean; const s: string): TpcnCstIpi;
function CSTPISToStr(const t: TpcnCstPIS): string;
function StrToCSTPIS(out ok: boolean; const s: string): TpcnCstPIS;
function CSTCOFINSToStr(const t: TpcnCstCOFINS): string;
function StrToCSTCOFINS(out ok: boolean; const s: string): TpcnCstCOFINS;
function modFreteToStr(const t: TpcnModalidadeFrete): string;
function StrTomodFrete(out ok: boolean; const s: string): TpcnModalidadeFrete;
function indProcToStr(const t: TpcnIndicadorProcesso): string;
function StrToindProc(out ok: boolean; const s: string): TpcnIndicadorProcesso;
function CRTToStr(const t: TpcnCRT): string;
function StrToCRT(out ok: boolean; const s: string): TpcnCRT;
function indTotToStr(const t: TpcnIndicadorTotal): string;
function StrToindTot(out ok: boolean; const s: string): TpcnIndicadorTotal;

function tpforPagToStr(const t: TpcteFormaPagamento): string;
function tpforPagToStrText(const t: TpcteFormaPagamento): string;
function StrTotpforPag(out ok: boolean; const s: string): TpcteFormaPagamento;
function tpCTePagToStr(const t: TpcteTipoCTe): string;
function tpCTToStr(const t: TpcteTipoCTe): string;
function tpCTToStrText(const t: TpcteTipoCTe): string;
function StrTotpCTe(out ok: boolean; const s: string): TpcteTipoCTe;
function TpModalToStr(const t: TpcteModal): string;
function TpModalToStrText(const t: TpcteModal): string;
function StrToTpModal(out ok: boolean; const s: string): TpcteModal;
function TpServPagToStr(const t: TpcteTipoServico): string;
function TpServToStrText(const t: TpcteTipoServico): string;
function StrToTpServ(out ok: boolean; const s: string): TpcteTipoServico;
function TpRetiraPagToStr(const t: TpcteRetira): string;
function StrToTpRetira(out ok: boolean; const s: string): TpcteRetira;
function TpTomadorPagToStr(const t: TpcteTomador): string;
function TpTomadorToStr(const t: TpcteTomador): String;
function TpTomadorToStrText(const t: TpcteTomador): String;
function TpRspSeguroToStr(const t: TpcteRspSeg): String;
function TpRspSeguroToStrText(const t: TpcteRspSeg): String;
function TpLotacaoToStr(const t: TpcteLotacao): string;
function TpPropToStr(const t: TpcteProp): String;
function UnidMedToStr(const t: UnidMed): string;
function StrToTpTomador(out ok: boolean; const s: String ): TpcteTomador;
function StrToTpRspSeguro(out ok: boolean; const s: String ): TpcteRspSeg;
function StrToTpLotacao(out ok: boolean; const s: String ): TpcteLotacao;
function StrToTpProp(out ok: boolean; const s: String ): TpcteProp;
function StrToUnidMed(out ok: boolean; const s: String ): UnidMed;
function TpMaskToStrText(const t: TpcteMask): string;
function StrToTpMask(out ok: boolean; const s: string): TpcteMask;

function ECFModRefToStr(const t:  TpcnECFModRef ): string;
function StrToECFModRef(out ok: boolean; const s: string): TpcnECFModRef;

function ISSQNcSitTribToStr(const t: TpcnISSQNcSitTrib ): string;
function StrToISSQNcSitTrib(out ok: boolean; const s: string) : TpcnISSQNcSitTrib;

function TpDirecaoToStr(const t: TpcteDirecao): string;
function StrToTpDirecao(out ok: boolean; const s: string): TpcteDirecao;
function TpNavegacaoToStr(const t: TpcteTipoNavegacao): string;
function StrToTpNavegacao(out ok: boolean; const s: string): TpcteTipoNavegacao;

function TpTrafegoToStr(const t: TpcteTipoTrafego): string;
function StrToTpTrafego(out ok: boolean; const s: string): TpcteTipoTrafego;

function TpDataPeriodoToStr(const t: TpcteTipoDataPeriodo): string;
function StrToTpDataPeriodo(out ok: boolean; const s: string): TpcteTipoDataPeriodo;
function TpHorarioIntervaloToStr(const t: TpcteTipoHorarioIntervalo): string;
function StrToTpHorarioIntervalo(out ok: boolean; const s: string): TpcteTipoHorarioIntervalo;
function TpDocumentoToStr(const t: TpcteTipoDocumento): string;
function StrToTpDocumento(out ok: boolean; const s: string): TpcteTipoDocumento;
function TpDocumentoAnteriorToStr(const t: TpcteTipoDocumentoAnterior): string;
function StrToTpDocumentoAnterior(out ok: boolean; const s: string): TpcteTipoDocumentoAnterior;
function RspPagPedagioToStr(const t: TpcteRspPagPedagio): string;
function StrToRspPagPedagio(out ok: boolean; const s: string): TpcteRspPagPedagio;
function TpDispositivoToStr(const t: TpcteTipoDispositivo): string;
function StrToTpDispositivo(out ok: boolean; const s: string): TpcteTipoDispositivo;
function TpPropriedadeToStr(const t: TpcteTipoPropriedade): string;
function StrToTpPropriedade(out ok: boolean; const s: string): TpcteTipoPropriedade;
function TpVeiculoToStr(const t: TpcteTipoVeiculo): string;
function StrToTpVeiculo(out ok: boolean; const s: string): TpcteTipoVeiculo;
function TpRodadoToStr(const t: TpcteTipoRodado): string;
function StrToTpRodado(out ok: boolean; const s: string): TpcteTipoRodado;
function TpCarroceriaToStr(const t: TpcteTipoCarroceria): string;
function StrToTpCarroceria(out ok: boolean; const s: string): TpcteTipoCarroceria;

function ModeloNFToStr(const t: TpcteModeloNF): string;
function StrToModeloNF(out ok: boolean; const s: string): TpcteModeloNF;
function TrafegoMutuoToStr(const t: TpcteTrafegoMutuo): string;
function StrToTrafegoMutuo(out ok: boolean; const s: string): TpcteTrafegoMutuo;

function StrToTpEvento(out ok: boolean; const s: string): TpcnTpEvento;
function TpEventoToStr(const t: TpcnTpEvento): string;

function IndicadorNFeToStr(const t: TpcnIndicadorNFe): string;
function StrToIndicadorNFe(out ok: boolean; const s: string): TpcnIndicadorNFe;
function IndicadorEmissorToStr(const t: TpcnIndicadorEmissor): string;
function StrToIndicadorEmissor(out ok: boolean; const s: string): TpcnIndicadorEmissor;
function IndicadorContinuacaoToStr(const t: TpcnIndicadorContinuacao): string;
function StrToIndicadorContinuacao(out ok: boolean; const s: string): TpcnIndicadorContinuacao;
function SituacaoNFeToStr(const t: TpcnSituacaoNFe): string;
function StrToSituacaoNFe(out ok: boolean; const s: string): TpcnSituacaoNFe;
function SituacaoManifDestToStr(const t: TpcnSituacaoManifDest): string;
function StrToSituacaoManifDest(out ok: boolean; const s: string): TpcnSituacaoManifDest;

function ModeloDFToStr(const t: TpcnModeloDF): string;
function StrToModeloDF(out ok: boolean; const s: string): TpcnModeloDF;
function DestinoOperacaoToStr(const t: TpcnDestinoOperacao): string;
function StrToDestinoOperacao(out ok: boolean; const s: string): TpcnDestinoOperacao;
function ConsumidorFinalToStr(const t: TpcnConsumidorFinal): string;
function StrToConsumidorFinal(out ok: boolean; const s: string): TpcnConsumidorFinal;
function PresencaCompradorToStr(const t: TpcnPresencaComprador): string;
function StrToPresencaComprador(out ok: boolean; const s: string): TpcnPresencaComprador;
function FormaPagamentoToStr(const t: TpcnFormaPagamento): string;
function FormaPagamentoToDescricao(const t: TpcnFormaPagamento): string;
function StrToFormaPagamento(out ok: boolean; const s: string): TpcnFormaPagamento;
function BandeiraCartaoToStr(const t: TpcnBandeiraCartao): string;
function StrToBandeiraCartao(out ok: boolean; const s: string): TpcnBandeiraCartao;

function RegTribToStr(const t: TpcnRegTrib ): string;
function StrToRegTrib(out ok: boolean; const s: string): TpcnRegTrib ;
function RegTribISSQNToStr(const t: TpcnRegTribISSQN ): string;
function StrToRegTribISSQN(out ok: boolean; const s: string): TpcnRegTribISSQN ;
function indRatISSQNToStr(const t: TpcnindRatISSQN ): string;
function StrToindRatISSQN(out ok: boolean; const s: string): TpcnindRatISSQN ;
function indRegraToStr(const t: TpcnindRegra ): string;
function StrToindRegra(out ok: boolean; const s: string): TpcnindRegra ;
function CodigoMPToStr(const t: TpcnCodigoMP ): string;
function StrToCodigoMP(out ok: boolean; const s: string): TpcnCodigoMP ;
function CodigoMPToDescricao(const t: TpcnCodigoMP ): string;

function UnidTranspToStr(const t: TpcnUnidTransp):string;
function StrToUnidTransp(out ok: boolean; const s: string): TpcnUnidTransp;
function UnidCargaToStr(const t: TpcnUnidCarga):string;
function StrToUnidCarga(out ok: boolean; const s: string):TpcnUnidCarga;
function indNegociavelToStr(const t: TpcnindNegociavel ): string;
function StrToindNegociavel(out ok: boolean; const s: string): TpcnindNegociavel;
function indIEDestToStr(const t: TpcnindIEDest ): string;
function StrToindIEDest(out ok: boolean; const s: string): TpcnindIEDest;
function TipoViaTranspToStr(const t: TpcnTipoViaTransp ): string;
function StrToTipoViaTransp(out ok: boolean; const s: string): TpcnTipoViaTransp;
function TipoIntermedioToStr(const t: TpcnTipoIntermedio ): string;
function StrToTipoIntermedio(out ok: boolean; const s: string): TpcnTipoIntermedio;
function indISSRetToStr(const t: TpcnindISSRet ): string;
function StrToindISSRet(out ok: boolean; const s: string): TpcnindISSRet;
function indISSToStr(const t: TpcnindISS ): string;
function StrToindISS(out ok: boolean; const s: string): TpcnindISS;
function indIncentivoToStr(const t: TpcnindIncentivo ): string;
function StrToindIncentivo(out ok: boolean; const s: string): TpcnindIncentivo;

function StrToVersaoDF(out ok: boolean; const s: string): TpcnVersaoDF;
function VersaoDFToStr(const t: TpcnVersaoDF): string;
function GetVersaoNFe(AModeloDF: TpcnModeloDF; AVersaoDF: TpcnVersaoDF; ALayOut: TLayOut): string;
function GetVersaoCTe(AVersaoDF: TpcnVersaoDF; ALayOut: TLayOutCTe): string;

function TipoAutorToStr(const t: TpcnTipoAutor ): string;
function StrToTipoAutor(out ok: boolean; const s: string): TpcnTipoAutor;

function IndOperacaoToStr(const t: TpcnIndOperacao ): string;
function StrToIndOperacao(out ok: boolean; const s: string): TpcnIndOperacao;

function TipoSchemaToStr(const t: TpcnTipoSchema ): string;
function StrToTipoSchema(out ok: boolean; const s: string): TpcnTipoSchema;

implementation

function StrToHex(S: String): String;
var I: Integer;
begin
  Result:= '';
  for I := 1 to length (S) do
    Result:= Result+IntToHex(ord(S[i]),2);
end;

function StrToEnumerado(out ok: boolean; const s: string; const AString:
  array of string; const AEnumerados: array of variant): variant;
var
  i: integer;
begin
  result := -1;
  for i := Low(AString) to High(AString) do
    if AnsiSameText(s, AString[i]) then
      result := AEnumerados[i];
  ok := result <> -1;
  if not ok then
    result := AEnumerados[0];
end;

function EnumeradoToStr(const t: variant; const AString:
  array of string; const AEnumerados: array of variant): variant;
var
  i: integer;
begin
  result := '';
  for i := Low(AEnumerados) to High(AEnumerados) do
    if t = AEnumerados[i] then
      result := AString[i];
end;

// Tipo de Schema **************************************************************

function SchemaToStr(const t: TpcnSchema): string;
begin
  result := EnumeradoToStr(t, ['PL005C'], [TsPL005c]);
end;

function StrToSchema(out ok: boolean; const s: string): TpcnSchema;
begin
  result := StrToEnumerado(ok, s, ['PL005C'], [TsPL005c]);
end;

// Tipo do Layout **************************************************************
function TipoLayoutToStr(const t: TpcnTipoLayout): string;
begin
  result := EnumeradoToStr(t, ['AtuCadEmiDFe', 'CadEmiDFe', 'CancNFe', 'ConsCad',
                               'ConsReciNFe', 'ConsSitNFe', 'ConsStatServ', 'InutNFe',
                               'NFe', 'ProcNFe', 'ProcInutNFe', 'RetAtuCadEmiDFe',
                               'RetCancNFe', 'RetConsCad', 'RetConsReciNFe', 'RetConsStatServ',
                               'RetConsSitNFe', 'RetEnvNFe', 'RetInutNFe', 'EnvNFe',
                               'ProcCancNFe', 'ConsStatServ', 'EnvCCeNFe', 'EnvEventoNFe',
                               'ConsNFeDest', 'DownloadNFe' {, 'ProcMDFe'}],
      [tlAtuCadEmiDFe, tlCadEmiDFe, tlCancCTe, tlConsCad, tlConsReciCTe, tlConsSitCTe,
       tlConsStatServ, tlInutCTe, tlCTe, tlProcCTe, tlProcInutCTe, tlRetAtuCadEmiDFe,
       tlRetCancCTe, tlRetConsCad, tlRetConsReciCTe, tlRetConsStatServ, tlRetConsSitCTe,
       tlRetEnvCTe, tlRetInutCTe, tlEnvCTe, tlProcCancCTe, tlConsStatServCTe, tlEnvCCeNFe,
       tlEnvEventoNFe, tlConsNFeDest, tlDownloadNFe{, tlProcMDFe}]);
end;

function StrToTipoLayout(out ok: boolean; const s: string): TpcnTipoLayout;
begin
  result := StrToEnumerado(ok, s, ['AtuCadEmiDFe', 'CadEmiDFe', 'CancNFe', 'ConsCad',
                                   'ConsReciNFe', 'ConsSitNFe', 'ConsStatServ', 'InutNFe',
                                   'NFe', 'ProcNFe', 'ProcInutNFe', 'RetAtuCadEmiDFe',
                                   'RetCancNFe', 'RetConsCad', 'RetConsReciNFe', 'RetConsStatServ',
                                   'RetConsSitNFe', 'RetEnvNFe', 'RetInutNFe', 'EnvNFe',
                                   'ConsStatServ', 'EnvCCeNFe', 'EnvEventoNFe',
                                   'ConsNFeDest', 'DownloadNFe'{, 'ProcMDFe'}],
      [tlAtuCadEmiDFe, tlCadEmiDFe, tlCancCTe, tlConsCad, tlConsReciCTe, tlConsSitCTe,
       tlConsStatServ, tlInutCTe, tlCTe, tlProcCTe, tlProcInutCTe, tlRetAtuCadEmiDFe,
       tlRetCancCTe, tlRetConsCad, tlRetConsReciCTe, tlRetConsStatServ, tlRetConsSitCTe,
       tlRetEnvCTe, tlRetInutCTe, tlEnvCTe, tlConsStatServCTe, tlEnvCCeNFe, tlEnvEventoNFe,
       tlConsNFeDest, tlDownloadNFe{, tlProcMDFe}]);
end;

// Indicador do Tipo de pagamento **********************************************
function IndpagToStr(const t: TpcnIndicadorPagamento): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2'], [ipVista, ipPrazo, ipOutras]);
end;

function StrToIndpag(out ok: boolean; const s: string): TpcnIndicadorPagamento;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2'], [ipVista, ipPrazo, ipOutras]);
end;

// B11 - Tipo do Documento Fiscal **********************************************
function tpNFToStr(const t: TpcnTipoNFe): string;
begin
  result := EnumeradoToStr(t, ['0', '1'], [tnEntrada, tnSaida]);
end;

function tpCTToStr(const t: TpcteTipoCTe): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3'], [tcNormal, tcComplemento, tcAnulacao, tcSubstituto]);
end;

function tpCTToStrText(const t: TpcteTipoCTe): string;
begin
  result := EnumeradoToStr(t, ['NORMAL', 'COMPLEMENTO', 'ANULA��O', 'SUBSTITUTO'], [tcNormal, tcComplemento, tcAnulacao, tcSubstituto]);
end;

function StrToTpNF(out ok: boolean; const s: string): TpcnTipoNFe;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [tnEntrada, tnSaida]);
end;

// B21 - Formato de Impress�o do DANFE *****************************************
function TpImpToStr(const t: TpcnTipoImpressao): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '5', '4'],
                              [tiSemGeracao, tiRetrato, tiPaisagem, tiSimplificado,
                               tiNFCe, tiMsgEletronica, tiNFCeA4]);
end;

function StrToTpImp(out ok: boolean; const s: string): TpcnTipoImpressao;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '5', '4'],
                                  [tiSemGeracao, tiRetrato, tiPaisagem, tiSimplificado,
                                   tiNFCe, tiMsgEletronica, tiNFCeA4]);
end;

function PercTribToStr(const t: TpcnPercentualTributos): string;
begin
  result := EnumeradoToStr(t, ['0', '1'],
                              [ptValorProdutos, ptValorNF]);
end;

function StrToPercTrib(out ok: boolean; const s: string): TpcnPercentualTributos;
begin
  result := StrToEnumerado(ok, s, ['0', '1'],
                                  [ptValorProdutos, ptValorNF]);
end;

function TpMaskToStrText(const t: TpcteMask): string;
begin
  result := EnumeradoToStr(t, ['#,##0.00', '#,###,##0.00', '###,###,##0.00', '#,###,###,##0.00', '#,###,###,###,##0.00', '###,###,###,###,##0.00', '###,##0.000', '#00%'],
    [msk4x2, msk7x2, msk9x2, msk10x2, msk13x2, msk15x2, msk6x3, mskAliq]);
end;

function StrToTpMask(out ok: boolean; const s: string): TpcteMask;
begin
  result := StrToEnumerado(ok, s, ['#,##0.00', '#,###,##0.00', '#,###,###,##0.00', '#,###,###,###,##0.00', '###,###,###,###,##0.00', '###,##0.000', '#00%'],
    [msk4x2, msk7x2, msk10x2, msk13x2, msk15x2, msk6x3, mskAliq]);
end;

// B22 - Forma de Emiss�o da NF-e **********************************************
function TpEmisToStr(const t: TpcnTipoEmissao): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '4', '5', '6', '7', '8', '9'],
                              [teNormal, teContingencia, teSCAN, teDPEC, teFSDA, teSVCAN, teSVCRS, teSVCSP, teOffLine]);
end;

function StrToTpEmis(out ok: boolean; const s: string): TpcnTipoEmissao;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '4', '5', '6', '7', '8', '9'],
                                  [teNormal, teContingencia, teSCAN, teDPEC, teFSDA, teSVCAN, teSVCRS, teSVCSP, teOffLine]);
end;

// B24 - Identifica��o do Ambiente *********************************************
 function TpAmbToStr(const t: TpcnTipoAmbiente): string;
begin
  result := EnumeradoToStr(t, ['1', '2'], [taProducao, taHomologacao]);
end;

function StrToTpAmb(out ok: boolean; const s: string): TpcnTipoAmbiente;
begin
  result := StrToEnumerado(ok, s, ['1', '2'], [taProducao, taHomologacao]);
end;

// *** - Situacao Emissor ******************************************************
function TpSitToStr(const t: TpcnSituacaoEmissor): string;
begin
  result := EnumeradoToStr(t, ['0', '1'], [seHomologacao, seProducao]);
end;

function StrToTpSit(out ok: boolean; const s: string): TpcnSituacaoEmissor;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [seHomologacao, seProducao]);
end;

// B25 - Finalidade de emiss�o da NF-e *****************************************
function FinNFeToStr(const t: TpcnFinalidadeNFe): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '4'],
                              [fnNormal, fnComplementar, fnAjuste, fnDevolucao]);
end;

function StrToFinNFe(out ok: boolean; const s: string): TpcnFinalidadeNFe;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '4'],
                                  [fnNormal, fnComplementar, fnAjuste, fnDevolucao]);
end;

// B26 - Processo de emiss�o da NF-e *******************************************
function procEmiToStr(const t: TpcnProcessoEmissao): string;
begin
  // 0 - emiss�o de NF-e com aplicativo do contribuinte;
  // 1 - emiss�o de NF-e avulsa pelo Fisco;
  // 2 - emiss�o de NF-e avulsa, pelo contribuinte com seu certificado digital, atrav�s do site do Fisco;
  // 3 - emiss�o NF-e pelo contribuinte com aplicativo fornecido pelo Fisco.
  result := EnumeradoToStr(t, ['0', '1', '2', '3'], [peAplicativoContribuinte, peAvulsaFisco, peAvulsaContribuinte, peContribuinteAplicativoFisco]);
end;

function StrToprocEmi(out ok: boolean; const s: string): TpcnProcessoEmissao;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3'], [peAplicativoContribuinte, peAvulsaFisco, peAvulsaContribuinte, peContribuinteAplicativoFisco]);
end;

// J02 - Tipo da opera��o ******************************************************
 function tpOPToStr(const t: TpcnTipoOperacao): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '0'], [toVendaConcessionaria, toFaturamentoDireto, toVendaDireta, toOutros]);
end;

function StrTotpOP(out ok: boolean; const s: string): TpcnTipoOperacao;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '0'], [toVendaConcessionaria, toFaturamentoDireto, toVendaDireta, toOutros]);
end;

// J22 - Condi��o do Ve�culo ***************************************************
function condVeicToStr(const t: TpcnCondicaoVeiculo): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3'], [cvAcabado, cvInacabado, cvSemiAcabado]);
end;

function StrTocondVeic(out ok: boolean; const s: string): TpcnCondicaoVeiculo;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3'], [cvAcabado, cvInacabado, cvSemiAcabado]);
end;

// L02 - Indicador do tipo de arma de fogo *************************************
function tpArmaToStr(const t: TpcnTipoArma): string;
begin
  result := EnumeradoToStr(t, ['0', '1'], [taUsoPermitido, taUsoRestrito]);
end;

function StrTotpArma(out ok: boolean; const s: string): TpcnTipoArma;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [taUsoPermitido, taUsoRestrito]);
end;

// N11 - Origem da mercadoria **************************************************
function OrigToStr(const t: TpcnOrigemMercadoria): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '5', '6', '7', '8'],
     [oeNacional, oeEstrangeiraImportacaoDireta, oeEstrangeiraAdquiridaBrasil,
      oeNacionalConteudoImportacaoSuperior40, oeNacionalProcessosBasicos,
      oeNacionalConteudoImportacaoInferiorIgual40,
      oeEstrangeiraImportacaoDiretaSemSimilar, oeEstrangeiraAdquiridaBrasilSemSimilar,
      oeNacionalConteudoImportacaoSuperior70]);
end;

function StrToOrig(out ok: boolean; const s: string): TpcnOrigemMercadoria;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '5', '6', '7', '8'],
     [oeNacional, oeEstrangeiraImportacaoDireta, oeEstrangeiraAdquiridaBrasil,
      oeNacionalConteudoImportacaoSuperior40, oeNacionalProcessosBasicos,
      oeNacionalConteudoImportacaoInferiorIgual40,
      oeEstrangeiraImportacaoDiretaSemSimilar, oeEstrangeiraAdquiridaBrasilSemSimilar,
      oeNacionalConteudoImportacaoSuperior70]);
end;

//CST CSON ICMS ***********************************************************
function CSOSNIcmsToStr(const t: TpcnCSOSNIcms): string;
begin
  result := EnumeradoToStr(t, ['0','101', '102', '103', '201', '202', '203', '300', '400', '500','900'],
    [csosnVazio,csosn101, csosn102, csosn103, csosn201, csosn202, csosn203, csosn300, csosn400, csosn500,csosn900]);
end;

function StrToCSOSNIcms(out ok: boolean; const s: string): TpcnCSOSNIcms;
begin
  result := StrToEnumerado(ok, s, [ '','101', '102', '103', '201', '202', '203', '300', '400', '500','900'],
    [csosnVazio, csosn101, csosn102, csosn103, csosn201, csosn202, csosn203, csosn300, csosn400, csosn500,csosn900]);
end;

function CSOSNToStrTagPos(const t: TpcnCSOSNIcms): string;
begin
  case  t of
    csosn101                               : result := '101';
    csosn102, csosn103, csosn300, csosn400 : result := '102';
    csosn201                               : result := '201';
    csosn202,csosn203                      : result := '202';
    csosn500                               : result := '500';
    csosn900                               : result := '900';
  end;
end;

function CSOSNToStrID(const t: TpcnCSOSNIcms): string;
begin
  case  t of
    csosn101                               : result := '10c';
    csosn102, csosn103, csosn300, csosn400 : result := '10d';
    csosn201                               : result := '10e';
    csosn202,csosn203                      : result := '10f';
    csosn500                               : result := '10g';
    csosn900                               : result := '10h';
  end;
end;

//***************************************************************************

// CST ICMS ********************************************************************
function CSTICMSToStr(const t: TpcnCSTIcms): string;
begin
  // ID -> N02  - Tributada integralmente
  // ID -> N03  - Tributada e com cobran�a do ICMS por substitui��o tribut�ria
  // ID -> N04  - Com redu��o de base de c�lculo
  // ID -> N05  - Isenta ou n�o tributada e com cobran�a do ICMS por substitui��o tribut�ria
  // ID -> N06  - Isenta
  // ID -> N06  - N�o tributada
  // ID -> N06  - Suspens�o
  // ID -> N07  - Diferimento A exig�ncia do preenchimento das informa��es do ICMS diferido fica � crit�rio de cada UF.
  // ID -> N08  - ICMS cobrado anteriormente por substitui��o
  // ID -> N09  - Com redu��o de base de c�lculo e cobran�a do ICMS por substitui��o tribut�ria
  // ID -> N10  - ICMS pagto atribu�do ao tomador ou ao terceiro previsto na legisla��o p/ ST
  // ID -> N10a - Opera��o interestadual para consumidor final com partilhado ICMS devido na opera��oentre a UF de origem e a UF do destinat�rio ou a UF definida na legisla��o. (Ex. UF daconcession�ria de entrega do ve�culos) (v2.0)
  // ID -> N10b - Grupo de informa��o do ICMS ST devido para a UF de destino,nas opera��es interestaduais de produtos que tiveram reten��o antecipada de ICMS por ST na UF do remetente. Repasse via Substituto Tribut�rio. (v2.0)
  // ID -> N11  - ICMS devido para outras UF
  // ID -> N12  - Outros
  result := EnumeradoToStr(t, ['00' , '10' , '20' , '30' , '40' , '41' , '50' , '51' , '60' , '70' , '80' , '81', '90', '10', '90', '41', '90', 'SN'],
                              [cst00, cst10, cst20, cst30, cst40, cst41, cst50, cst51, cst60, cst70, cst80, cst81, cst90, cstPart10 , cstPart90 , cstRep41, cstICMSOutraUF, cstICMSSN]);
end;

function StrToCSTICMS(out ok: boolean; const s: string): TpcnCSTIcms;
begin
  result := StrToEnumerado(ok, s, ['00', '10', '20', '30', '40', '41', '50', '51', '60', '70', '80', '81', '90', '91', '92'],
    [cst00, cst10, cst20, cst30, cst40, cst41, cst50, cst51, cst60, cst70, cst80, cst81, cst90, cstICMSOutraUF, cstICMSSN]);
end;

function CSTICMSToStrTagPos(const t: TpcnCSTIcms): string;
begin
  result := EnumeradoToStr(t, ['02', '03', '04', '05', '06', '06', '06', '07', '08', '09', '10', '11', '12', '10a', '10a', '10b'],
    [cst00, cst10, cst20, cst30, cst40, cst41, cst50, cst51, cst60, cst70, cst80, cst81, cst90, cstPart10 , cstPart90 , cstRep41]);
end;

function CSTICMSToStrTagPosText(const t: TpcnCSTIcms): string;
begin
  result := EnumeradoToStr(t,
   ['TRIBUTA��O NORMAL DO ICMS',
    'TRIBUTA��O COM COBRAN�A DO ICMS POR SUBST. TRIBUT�RIA',
    'TRIBUTA��O COM REDU��O DE BC DO ICMS',
    'TRIBUTA��O ISENTA E COM COBRAN�A DO ICMS POR SUBST. TRIBUT�RIA',
    'ICMS ISEN��O',
    'ICMS N�O TRIBUTADO',
    'ICMS ISENTO, N�O TRIBUTADO OU DIFERIDO',
    'ICMS SUSPENS�O',
    'ICMS DIFERIDO',
    'ICMS COBRADO ANTERIORMENTE POR SUBSTITUI��O TRIBUT�RIA',
    'TRIBUTA��O COM REDU��O DE BC E COBRAN�A DO ICMS POR SUBST. TRIBUT�RIA',
    'RESPONSABILIDADE DO RECOLHIMENTO DO ICMS ATRIBU�DO AO TOMADOR OU 3� POR ST',
    'ICMS DEVICO � OUTRA UF',
    'ICMS OUTROS',
    'ICMS DEVIDO A UF DE ORIGEM DA PRESTACAO, QUANDO DIFERENTE DA UF DO EMITENTE',
    'SIMPLES NACIONAL'],
    [cst00, cst10, cst20, cst30, cst40, cst41, cst45, cst50, cst51, cst60, cst70, cst80, cst81, cst90, cstICMSOutraUF, cstICMSSN]);
end;

// N13 - Modalidade de determina��o da BC do ICMS ******************************
function modBCToStr(const t: TpcnDeterminacaoBaseIcms): string;
begin
  // 0 - Margem Valor Agregado (%);
  // 1 - Pauta (Valor);
  // 2 - Pre�o Tabelado M�x. (valor);
  // 3 - valor da opera��o.
  result := EnumeradoToStr(t, ['0', '1', '2', '3'],
    [dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao]);
end;

function StrTomodBC(out ok: boolean; const s: string): TpcnDeterminacaoBaseIcms;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3'],
    [dbiMargemValorAgregado, dbiPauta, dbiPrecoTabelado, dbiValorOperacao]);
end;

// N18 - Modalidade de determina��o da BC do ICMS ST ***************************
function modBCSTToStr(const t: TpcnDeterminacaoBaseIcmsST): string;
begin
  // 0 � Pre�o tabelado ou m�ximo sugerido;
  // 1 - Lista Negativa (valor);
  // 2 - Lista Positiva (valor);
  // 3 - Lista Neutra (valor);
  // 4 - Margem Valor Agregado (%);
  // 5 - Pauta (valor);
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '5'],
    [dbisPrecoTabelado, dbisListaNegativa, dbisListaPositiva, dbisListaNeutra, dbisMargemValorAgregado, dbisPauta]);
end;

function StrTomodBCST(out ok: boolean; const s: string): TpcnDeterminacaoBaseIcmsST;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '5'],
    [dbisPrecoTabelado, dbisListaNegativa, dbisListaPositiva, dbisListaNeutra, dbisMargemValorAgregado, dbisPauta]);
end;

// N28 - Motivo da desonera��o do ICMS ***************************
function motDesICMSToStr(const t: TpcnMotivoDesoneracaoICMS): string;
begin
    // 1 � T�xi;
    // 2 � Deficiente F�sico;
    // 3 � Produtor Agropecu�rio;
    // 4 � Frotista/Locadora;
    // 5 � Diplom�tico/Consular;
    // 6 � Utilit�rios e Motocicletas da
    // Amaz�nia Ocidental e �reas de
    // Livre Com�rcio (Resolu��o
    // 714/88 e 790/94 � CONTRAN e
    // suas altera��es);
    // 7 � SUFRAMA;
    // 8 � Venda a Org�os Publicos;
    // 9 � outros. (v2.0)
    // 10 � Deficiente Condutor (Conv�nio ICMS 38/12). (v3.1)
    // 11 � Deficiente n�o Condutor (Conv�nio ICMS 38/12). (v3.1)
    // 12 - Org�o Fomento
  result := EnumeradoToStr(t, ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
    [mdiTaxi, mdiDeficienteFisico, mdiProdutorAgropecuario, mdiFrotistaLocadora,
     mdiDiplomaticoConsular, mdiAmazoniaLivreComercio, mdiSuframa, mdiVendaOrgaosPublicos,
     mdiOutros, mdiDeficienteCondutor, mdiDeficienteNaoCondutor, mdiOrgaoFomento]);
end;

function StrTomotDesICMS(out ok: boolean; const s: string): TpcnMotivoDesoneracaoICMS;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
    [mdiTaxi, mdiDeficienteFisico, mdiProdutorAgropecuario, mdiFrotistaLocadora,
     mdiDiplomaticoConsular, mdiAmazoniaLivreComercio, mdiSuframa, mdiVendaOrgaosPublicos,
     mdiOutros, mdiDeficienteCondutor, mdiDeficienteNaoCondutor, mdiOrgaoFomento]);
end;

// CST IPI *********************************************************************
function CSTIPIToStr(const t: TpcnCstIpi): string;
begin
  result := EnumeradoToStr(t, ['00', '49', '50', '99', '01', '02', '03', '04', '05', '51', '52', '53', '54', '55'],
    [ipi00, ipi49, ipi50, ipi99, ipi01, ipi02, ipi03, ipi04, ipi05, ipi51, ipi52, ipi53, ipi54, ipi55]);
end;

function StrToCSTIPI(out ok: boolean; const s: string): TpcnCstIpi;
begin
  result := StrToEnumerado(ok, s, ['00', '49', '50', '99', '01', '02', '03', '04', '05', '51', '52', '53', '54', '55'],
    [ipi00, ipi49, ipi50, ipi99, ipi01, ipi02, ipi03, ipi04, ipi05, ipi51, ipi52, ipi53, ipi54, ipi55]);
end;

// CST PIS *********************************************************************
function CSTPISToStr(const t: TpcnCstPIS): string;
begin
  result := EnumeradoToStr(t, ['01', '02', '03', '04', '05', '06', '07', '08', '09', '49', '50', '51', '52', '53', '54', '55', '56', '60', '61', '62', '63', '64', '65', '66', '67', '70', '71', '72', '73', '74', '75', '98', '99'],
    [pis01, pis02, pis03, pis04, pis05, pis06, pis07, pis08, pis09, pis49, pis50, pis51, pis52, pis53, pis54, pis55, pis56, pis60, pis61, pis62, pis63, pis64, pis65, pis66, pis67, pis70, pis71, pis72, pis73, pis74, pis75, pis98, pis99]);
end;

function StrToCSTPIS(out ok: boolean; const s: string): TpcnCstPIS;
begin
  result := StrToEnumerado(ok, s, ['01', '02', '03', '04', '05', '06', '07', '08', '09', '49', '50', '51', '52', '53', '54', '55', '56', '60', '61', '62', '63', '64', '65', '66', '67', '70', '71', '72', '73', '74', '75', '98', '99'],
    [pis01, pis02, pis03, pis04, pis05, pis06, pis07, pis08, pis09, pis49, pis50, pis51, pis52, pis53, pis54, pis55, pis56, pis60, pis61, pis62, pis63, pis64, pis65, pis66, pis67, pis70, pis71, pis72, pis73, pis74, pis75, pis98, pis99]);
end;

// CST COFINS ******************************************************************
function CSTCOFINSToStr(const t: TpcnCstCOFINS): string;
begin
  result := EnumeradoToStr(t, ['01', '02', '03', '04', '05', '06', '07', '08', '09', '49', '50', '51', '52', '53', '54', '55', '56', '60', '61', '62', '63', '64', '65', '66', '67', '70', '71', '72', '73', '74', '75', '98', '99'],
    [cof01, cof02, cof03, cof04, cof05, cof06, cof07, cof08, cof09, cof49, cof50, cof51, cof52, cof53, cof54, cof55, cof56, cof60, cof61, cof62, cof63, cof64, cof65, cof66, cof67, cof70, cof71, cof72, cof73, cof74, cof75, cof98, cof99]);
end;

function StrToCSTCOFINS(out ok: boolean; const s: string): TpcnCstCOFINS;
begin
  result := StrToEnumerado(ok, s, ['01', '02', '03', '04', '05', '06', '07', '08', '09', '49', '50', '51', '52', '53', '54', '55', '56', '60', '61', '62', '63', '64', '65', '66', '67', '70', '71', '72', '73', '74', '75', '98', '99'],
    [cof01, cof02, cof03, cof04, cof05, cof06, cof07, cof08, cof09, cof49, cof50, cof51, cof52, cof53, cof54, cof55, cof56, cof60, cof61, cof62, cof63, cof64, cof65, cof66, cof67, cof70, cof71, cof72, cof73, cof74, cof75, cof98, cof99]);
end;

// ??? - Modalidade do frete ***************************************************
function modFreteToStr(const t: TpcnModalidadeFrete): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '9'], [mfContaEmitente, mfContaDestinatario, mfContaTerceiros, mfSemFrete]);
end;

function StrTomodFrete(out ok: boolean; const s: string): TpcnModalidadeFrete;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '9'], [mfContaEmitente, mfContaDestinatario, mfContaTerceiros, mfSemFrete]);
end;

// 401i - Indicador da origem do processo **************************************
function indProcToStr(const t: TpcnIndicadorProcesso): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '9'], [ipSEFAZ, ipJusticaFederal, ipJusticaEstadual, ipSecexRFB, ipOutros]);
end;

function StrToindProc(out ok: boolean; const s: string): TpcnIndicadorProcesso;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '9'], [ipSEFAZ, ipJusticaFederal, ipJusticaEstadual, ipSecexRFB, ipOutros]);
end;

// 49a - C�digo do Regime Tribut�rio **************************************
function CRTToStr(const t: TpcnCRT): string;
begin
  result := EnumeradoToStr(t, ['','1', '2', '3'], [crtRegimeNormal,crtSimplesNacional, crtSimplesExcessoReceita, crtRegimeNormal]);
end;

function StrToCRT(out ok: boolean; const s: string): TpcnCRT;
begin
  result := StrToEnumerado(ok, s, ['','1', '2', '3'],[crtRegimeNormal,crtSimplesNacional,crtSimplesExcessoReceita, crtRegimeNormal]);
end;

// 117b - Indicador de soma no total da NFe **************************************
function indTotToStr(const t: TpcnIndicadorTotal): string;
begin
  result := EnumeradoToStr(t, ['0', '1'], [itNaoSomaTotalNFe, itSomaTotalNFe]);
end;

function StrToindTot(out ok: boolean; const s: string): TpcnIndicadorTotal;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [itNaoSomaTotalNFe, itSomaTotalNFe]);
end;

function tpforPagToStr(const t: TpcteFormaPagamento): string;
begin
  result := EnumeradoToStr(t, ['0','1', '2'], [fpPago, fpAPagar, fpOutros]);
end;

function tpforPagToStrText(const t: TpcteFormaPagamento): string;
begin
  result := EnumeradoToStr(t, ['PAGO','A PAGAR', 'OUTROS'], [fpPago, fpAPagar, fpOutros]);
end;

function StrTotpforPag(out ok: boolean; const s: string): TpcteFormaPagamento;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2'], [fpPago, fpAPagar, fpOutros]);
end;

function tpCTePagToStr(const t: TpcteTipoCTe): string;
begin
  result := EnumeradoToStr(t, ['0','1', '2', '3'], [tcNormal, tcComplemento, tcAnulacao, tcSubstituto]);
end;

function StrTotpCTe(out ok: boolean; const s: string): TpcteTipoCTe;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3'], [tcNormal, tcComplemento, tcAnulacao, tcSubstituto]);
end;

function TpModalToStr(const t: TpcteModal): string;
begin
  result := EnumeradoToStr(t, ['01','02', '03', '04', '05', '06'],
                              [mdRodoviario, mdAereo, mdAquaviario, mdFerroviario, mdDutoviario, mdMultimodal]);
end;

function TpModalToStrText(const t: TpcteModal): string;
begin
  result := EnumeradoToStr(t, ['RODOVI�RIO','A�REO', 'AQUAVI�RIO', 'FERROVI�RIO', 'DUTOVI�RIO', 'MULTIMODAL'],
                              [mdRodoviario, mdAereo, mdAquaviario, mdFerroviario, mdDutoviario, mdMultimodal]);
end;

function StrToTpModal(out ok: boolean; const s: string): TpcteModal;
begin
  result := StrToEnumerado(ok, s, ['01', '02', '03', '04', '05', '06'],
                                  [mdRodoviario, mdAereo, mdAquaviario, mdFerroviario, mdDutoviario, mdMultimodal]);
end;

function TpServPagToStr(const t: TpcteTipoServico): string;
begin
  result := EnumeradoToStr(t, ['0','1', '2', '3', '4'],
                              [tsNormal, tsSubcontratacao, tsRedespacho, tsIntermediario, tsMultimodal]);
end;

function TpServToStrText(const t: TpcteTipoServico): string;
begin
  result := EnumeradoToStr(t, ['NORMAL','SUBCONTRATA��O', 'REDESPACHO', 'REDESP. INTERMEDI�RIO', 'VINC. A MULTIMODAL'],
                              [tsNormal, tsSubcontratacao, tsRedespacho, tsIntermediario, tsMultimodal]);
end;

function StrToTpServ(out ok: boolean; const s: string): TpcteTipoServico;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4'],
                                  [tsNormal, tsSubcontratacao, tsRedespacho, tsIntermediario, tsMultimodal]);
end;

function TpRetiraPagToStr(const t: TpcteRetira): string;
begin
  result := EnumeradoToStr(t, ['0','1'], [rtSim, rtNao]);
end;

function StrToTpRetira(out ok: boolean; const s: string): TpcteRetira;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [rtSim, rtNao]);
end;

function TpTomadorPagToStr(const t: TpcteTomador): string;
begin
  result := EnumeradoToStr(t, ['0','1', '2', '3', '4'], [tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros]);
end;

function TpTomadorToStr(const t: TpcteTomador): String;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4'], [tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros]);
end;

function TpTomadorToStrText(const t: TpcteTomador): String;
begin
  result := EnumeradoToStr(t, ['REMETENTE', 'EXPEDIDOR', 'RECEBEDOR', 'DESTINATARIO', 'OUTROS'],
    [tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros]);
end;

function TpRspSeguroToStr(const t: TpcteRspSeg): String;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '5'], [rsRemetente, rsExpedidor, rsRecebedor, rsDestinatario, rsEmitenteCTe, rsTomadorServico]);
end;

function TpRspSeguroToStrText(const t: TpcteRspSeg): String;
begin
  result := EnumeradoToStr(t, ['REMETENTE', 'EXPEDIDOR', 'RECEBEDOR', 'DESTINATARIO', 'EMITENTE', 'TOMADOR SERVICO'],
    [rsRemetente, rsExpedidor, rsRecebedor, rsDestinatario, rsEmitenteCTe, rsTomadorServico]);
end;

function TpLotacaoToStr(const t: TpcteLotacao): string;
begin
  result := EnumeradoToStr(t, ['0','1'], [ltNao, ltSim]);
end;

function TpPropToStr(const t: TpcteProp): String;
begin
  result := EnumeradoToStr(t, ['0', '1', '2'], [tpTACAgregado, tpTACIndependente, tpOutros]);
end;

function StrToTpTomador(out ok: boolean; const s: String ): TpcteTomador;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4'], [tmRemetente, tmExpedidor, tmRecebedor, tmDestinatario, tmOutros]);
end;

function StrToTpRspSeguro(out ok: boolean; const s: String ): TpcteRspSeg;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '5'], [rsRemetente, rsExpedidor, rsRecebedor, rsDestinatario, rsEmitenteCTe, rsTomadorServico]);
end;

function StrToTpLotacao(out ok: boolean; const s: String ): TpcteLotacao;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [ltNao, ltSim]);
end;

function StrToTpProp(out ok: boolean; const s: String ): TpcteProp;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2'], [tpTACAgregado, tpTACIndependente, tpOutros]);
end;

function UnidMedToStr(const t: UnidMed): string;
begin
  result := EnumeradoToStr(t, ['00', '01', '02', '03', '04', '05'],
   [uM3,uKG, uTON, uUNIDADE, uLITROS, uMMBTU]);
end;

function StrToUnidMed(out ok: boolean; const s: String ): UnidMed;
begin
  result := StrToEnumerado(ok, s, ['00', '01', '02', '03', '04', '05'],
   [uM3,uKG, uTON, uUNIDADE, uLITROS, uMMBTU]);
end;

// B20k - Modelo Refenciado  **************************************
function ECFModRefToStr(const t: TpcnECFModRef): string;
begin
    result := EnumeradoToStr(t, ['', '2B', '2C','2D'],[ECFModRefVazio ,ECFModRef2B,ECFModRef2C,ECFModRef2D]);
end;

function StrToECFModRef(out ok: boolean; const s: string): TpcnECFModRef;
begin
  result := StrToEnumerado(ok, s, ['', '2B', '2C','2D'],[ECFModRefVazio, ECFModRef2B,ECFModRef2C,ECFModRef2D]);
end;

function ISSQNcSitTribToStr(const t: TpcnISSQNcSitTrib ): string;
begin
    result := EnumeradoToStr(t, ['','N','R','S','I'],[ISSQNcSitTribVazio , ISSQNcSitTribNORMAL, ISSQNcSitTribRETIDA, ISSQNcSitTribSUBSTITUTA,ISSQNcSitTribISENTA]);
end;

function StrToISSQNcSitTrib(out ok: boolean; const s: string) : TpcnISSQNcSitTrib;
begin
  result := StrToEnumerado(ok, s, ['','N','R','S','I'],[ISSQNcSitTribVazio , ISSQNcSitTribNORMAL, ISSQNcSitTribRETIDA, ISSQNcSitTribSUBSTITUTA,ISSQNcSitTribISENTA]);
end;

function TpDirecaoToStr(const t: TpcteDirecao): string;
begin
  result := EnumeradoToStr(t, ['N','L','S','O'], [drNorte , drLeste, drSul, drOeste]);
end;

function StrToTpDirecao(out ok: boolean; const s: string): TpcteDirecao;
begin
  result := StrToEnumerado(ok, s, ['N','L','S','O'], [drNorte , drLeste, drSul, drOeste]);
end;

function TpNavegacaoToStr(const t: TpcteTipoNavegacao): string;
begin
  result := EnumeradoToStr(t, ['0','1'], [tnInterior , tnCabotagem]);
end;

function StrToTpNavegacao(out ok: boolean; const s: string): TpcteTipoNavegacao;
begin
  result := StrToEnumerado(ok, s, ['0','1'], [tnInterior , tnCabotagem]);
end;

function TpTrafegoToStr(const t: TpcteTipoTrafego): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3'], [ttProprio , ttMutuo, ttRodoferroviario, ttRodoviario]);
end;

function StrToTpTrafego(out ok: boolean; const s: string): TpcteTipoTrafego;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3'], [ttProprio , ttMutuo, ttRodoferroviario, ttRodoviario]);
end;

function TpDataPeriodoToStr(const t: TpcteTipoDataPeriodo): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3','4','N'],
                              [tdSemData, tdNaData, tdAteData, tdApartirData, tdNoPeriodo, tdNaoInformado]);
end;

function StrToTpDataPeriodo(out ok: boolean; const s: string): TpcteTipoDataPeriodo;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3','4','N'],
                                  [tdSemData, tdNaData, tdAteData, tdApartirData, tdNoPeriodo, tdNaoInformado]);
end;

function TpHorarioIntervaloToStr(const t: TpcteTipoHorarioIntervalo): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3','4','N'],
                              [thSemHorario, thNoHorario, thAteHorario, thApartirHorario, thNoIntervalo, thNaoInformado]);
end;

function StrToTpHorarioIntervalo(out ok: boolean; const s: string): TpcteTipoHorarioIntervalo;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3','4','N'],
                                  [thSemHorario, thNoHorario, thAteHorario, thApartirHorario, thNoIntervalo, thNaoInformado]);
end;

function TpDocumentoToStr(const t: TpcteTipoDocumento): string;
begin
  result := EnumeradoToStr(t, ['00','10','99'], [tdDeclaracao, tdDutoviario, tdOutros]);
end;

function StrToTpDocumento(out ok: boolean; const s: string): TpcteTipoDocumento;
begin
  result := StrToEnumerado(ok, s, ['00','10','99'], [tdDeclaracao, tdDutoviario, tdOutros]);
end;

function TpDocumentoAnteriorToStr(const t: TpcteTipoDocumentoAnterior): string;
begin
  result := EnumeradoToStr(t, ['00','01','02','03','04','05','06','07','08','09','10','11','12','99'],
   [daCTRC, daCTAC, daACT, daNF7, daNF27, daCAN, daCTMC, daATRE, daDTA, daCAI, daCCPI, daCA, daTIF, daOutros]);
end;

function StrToTpDocumentoAnterior(out ok: boolean; const s: string): TpcteTipoDocumentoAnterior;
begin
  result := StrToEnumerado(ok, s, ['00','01','02','03','04','05','06','07','08','09','10','11','12','99'],
   [daCTRC, daCTAC, daACT, daNF7, daNF27, daCAN, daCTMC, daATRE, daDTA, daCAI, daCCPI, daCA, daTIF, daOutros]);
end;

function RspPagPedagioToStr(const t: TpcteRspPagPedagio): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3','4','5'], [rpEmitente, rpRemetente, rpExpedidor, rpRecebedor, rpDestinatario, rpTomadorServico]);
end;

function StrToRspPagPedagio(out ok: boolean; const s: string): TpcteRspPagPedagio;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3','4','5'], [rpEmitente, rpRemetente, rpExpedidor, rpRecebedor, rpDestinatario, rpTomadorServico]);
end;

function TpDispositivoToStr(const t: TpcteTipoDispositivo): string;
begin
  result := EnumeradoToStr(t, ['1','2','3'], [tdCartaoMagnetico, tdTAG, tdTicket]);
end;

function StrToTpDispositivo(out ok: boolean; const s: string): TpcteTipoDispositivo;
begin
  result := StrToEnumerado(ok, s, ['1','2','3'], [tdCartaoMagnetico, tdTAG, tdTicket]);
end;

function TpPropriedadeToStr(const t: TpcteTipoPropriedade): string;
begin
  result := EnumeradoToStr(t, ['P','T'], [tpProprio, tpTerceiro]);
end;

function StrToTpPropriedade(out ok: boolean; const s: string): TpcteTipoPropriedade;
begin
  result := StrToEnumerado(ok, s, ['P','T'], [tpProprio, tpTerceiro]);
end;

function TpVeiculoToStr(const t: TpcteTipoVeiculo): string;
begin
  result := EnumeradoToStr(t, ['0','1'], [tvTracao, tvReboque]);
end;

function StrToTpVeiculo(out ok: boolean; const s: string): TpcteTipoVeiculo;
begin
  result := StrToEnumerado(ok, s, ['0','1'], [tvTracao, tvReboque]);
end;

function TpRodadoToStr(const t: TpcteTipoRodado): string;
begin
  result := EnumeradoToStr(t, ['00','01','02','03','04','05','06'],
   [trNaoAplicavel, trTruck, trToco, trCavaloMecanico, trVAN, trUtilitario, trOutros]);
end;

function StrToTpRodado(out ok: boolean; const s: string): TpcteTipoRodado;
begin
  result := StrToEnumerado(ok, s, ['00','01','02','03','04','05','06'],
   [trNaoAplicavel, trTruck, trToco, trCavaloMecanico, trVAN, trUtilitario, trOutros]);
end;

function TpCarroceriaToStr(const t: TpcteTipoCarroceria): string;
begin
  result := EnumeradoToStr(t, ['00','01','02','03','04','05'],
   [tcNaoAplicavel, tcAberta, tcFechada, tcGraneleira, tcPortaContainer, tcSider]);
end;

function StrToTpCarroceria(out ok: boolean; const s: string): TpcteTipoCarroceria;
begin
  result := StrToEnumerado(ok, s, ['00','01','02','03','04','05'],
   [tcNaoAplicavel, tcAberta, tcFechada, tcGraneleira, tcPortaContainer, tcSider]);
end;

function ModeloNFToStr(const t: TpcteModeloNF): string;
begin
  result := EnumeradoToStr(t, ['01','04'],
   [moNF011AAvulsa, moNFProdutor]);
end;

function StrToModeloNf(out ok: boolean; const s: string): TpcteModeloNF;
begin
  result := StrToEnumerado(ok, s, ['01','04'],
   [moNF011AAvulsa, moNFProdutor]);
end;

function TrafegoMutuoToStr(const t: TpcteTrafegoMutuo): string;
begin
  result := EnumeradoToStr(t, ['1','2'],
   [tmOrigem, tmDestino]);
end;

function StrToTrafegoMutuo(out ok: boolean; const s: string): TpcteTrafegoMutuo;
begin
  result := StrToEnumerado(ok, s, ['1','2'],
   [tmOrigem, tmDestino]);
end;

function StrToTpEvento(out ok: boolean;const s: string): TpcnTpEvento;
begin
  result  := TpcnTpEvento( StrToEnumerado2(ok , s, TpcnTpEventoString ) );
end;

function TpEventoToStr(const t: TpcnTpEvento): String;
begin
  result := EnumeradoToStr2( t , TpcnTpEventoString );
end;

function StrToEnumerado2(out ok: boolean;  const s: string; Const AString: array of string ): variant;
// Atencao  N�o Funciona em Alguns Enumerados ja existentes
var
  i: integer;
begin
  Result  := 0;
  ok      := False;
  try
    for i := Low(AString) to High(AString) do
      if AnsiSameText(s, AString[i]) then
      begin
        result  := i;
        ok      := True;
        exit;
      end;
  Except
    ok := False;
  End;
end;

function EnumeradoToStr2(const t: variant; const AString: array of string ): variant;
// Atencao N�o Funciona em Alguns Enumerados ja existentes
begin
  result := AString[ integer( t ) ];
end;

function IndicadorNFeToStr(const t: TpcnIndicadorNFe): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2'],
                              [inTodas, inSemManifestacaoComCiencia,
                               inSemManifestacaoSemCiencia]);
end;

function StrToIndicadorNFe(out ok: boolean; const s: string): TpcnIndicadorNFe;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2'],
                                  [inTodas, inSemManifestacaoComCiencia,
                                   inSemManifestacaoSemCiencia]);
end;

function IndicadorEmissorToStr(const t: TpcnIndicadorEmissor): string;
begin
  result := EnumeradoToStr(t, ['0', '1'],
                              [ieTodos, ieRaizCNPJDiferente]);
end;

function StrToIndicadorEmissor(out ok: boolean; const s: string): TpcnIndicadorEmissor;
begin
  result := StrToEnumerado(ok, s, ['0', '1'],
                                  [ieTodos, ieRaizCNPJDiferente]);
end;

function IndicadorContinuacaoToStr(const t: TpcnIndicadorContinuacao): string;
begin
  result := EnumeradoToStr(t, ['0', '1'],
                              [icNaoPossuiMaisDocumentos, icPossuiMaisDocumentos]);
end;

function StrToIndicadorContinuacao(out ok: boolean; const s: string): TpcnIndicadorContinuacao;
begin
  result := StrToEnumerado(ok, s, ['0', '1'],
                                  [icNaoPossuiMaisDocumentos, icPossuiMaisDocumentos]);
end;

function SituacaoNFeToStr(const t: TpcnSituacaoNFe): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3'],
                              [snAutorizado,snDenegado,snCancelada]);
end;

function StrToSituacaoNFe(out ok: boolean; const s: string): TpcnSituacaoNFe;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3'],
                                  [snAutorizado,snDenegado,snCancelada]);
end;

function SituacaoManifDestToStr(const t: TpcnSituacaoManifDest): string;
begin
  result := EnumeradoToStr(t, ['0','1','2','3','4'],
                              [smdSemManifestacao, smdConfirmada, smdDesconhecida, smdOperacaoNaoRealizada, smdCiencia]);
end;

function StrToSituacaoManifDest(out ok: boolean; const s: string): TpcnSituacaoManifDest;
begin
  result := StrToEnumerado(ok, s, ['0','1','2','3','4'],
                                  [smdSemManifestacao, smdConfirmada, smdDesconhecida, smdOperacaoNaoRealizada, smdCiencia]);
end;

function ModeloDFToStr(const t: TpcnModeloDF): string;
begin
  result := EnumeradoToStr(t, ['55', '65'],
                              [moNFe, moNFCe]);
end;

function StrToModeloDF(out ok: boolean; const s: string): TpcnModeloDF;
begin
  result := StrToEnumerado(ok, s, ['55', '65'],
                                  [moNFe, moNFCe]);
end;

function DestinoOperacaoToStr(const t: TpcnDestinoOperacao): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3'],
                              [doInterna, doInterestadual, doExterior]);
end;

function StrToDestinoOperacao(out ok: boolean; const s: string): TpcnDestinoOperacao;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3'],
                                  [doInterna, doInterestadual, doExterior]);
end;

function ConsumidorFinalToStr(const t: TpcnConsumidorFinal): string;
begin
  result := EnumeradoToStr(t, ['0', '1'],
                              [cfNao, cfConsumidorFinal]);
end;

function StrToConsumidorFinal(out ok: boolean; const s: string): TpcnConsumidorFinal;
begin
  result := StrToEnumerado(ok, s, ['0', '1'],
                                  [cfNao, cfConsumidorFinal]);
end;

function PresencaCompradorToStr(const t: TpcnPresencaComprador): string;
begin
  result := EnumeradoToStr(t, ['0', '1', '2', '3', '4', '9'],
                              [pcNao, pcPresencial, pcInternet, pcTeleatendimento, pcEntregaDomicilio, pcOutros]);
end;

function StrToPresencaComprador(out ok: boolean; const s: string): TpcnPresencaComprador;
begin
  result := StrToEnumerado(ok, s, ['0', '1', '2', '3', '4', '9'],
                                  [pcNao, pcPresencial, pcInternet, pcTeleatendimento, pcEntregaDomicilio, pcOutros]);
end;

function FormaPagamentoToStr(const t: TpcnFormaPagamento): string;
begin
  result := EnumeradoToStr(t, ['01', '02', '03', '04', '05', '10', '11', '12', '13', '99'],
                              [fpDinheiro, fpCheque, fpCartaoCredito, fpCartaoDebito, fpCreditoLoja,
                               fpValeAlimentacao, fpValeRefeicao, fpValePresente, fpValeCombustivel,
                               fpOutro]);
end;

function FormaPagamentoToDescricao(const t: TpcnFormaPagamento): string;
begin
  result := EnumeradoToStr(t,  ['Dinheiro', 'Cheque', 'Cart�o de Cr�dito', 'Cart�o de D�bito', 'Cr�dito Loja',
                               'Vale Alimenta��o', 'Vale Refei��o', 'Vale Presente', 'Vale Combust�vel',
                               'Outro'],
                               [fpDinheiro, fpCheque, fpCartaoCredito, fpCartaoDebito, fpCreditoLoja,
                               fpValeAlimentacao, fpValeRefeicao, fpValePresente, fpValeCombustivel,
                               fpOutro]);
end;


function StrToFormaPagamento(out ok: boolean; const s: string): TpcnFormaPagamento;
begin
  result := StrToEnumerado(ok, s, ['01', '02', '03', '04', '05', '10', '11', '12', '13', '99'],
                                  [fpDinheiro, fpCheque, fpCartaoCredito, fpCartaoDebito, fpCreditoLoja,
                                   fpValeAlimentacao, fpValeRefeicao, fpValePresente, fpValeCombustivel,
                                   fpOutro]);
end;

function BandeiraCartaoToStr(const t: TpcnBandeiraCartao): string;
begin
  result := EnumeradoToStr(t, ['01', '02', '03', '04', '99'],
                              [bcVisa, bcMasterCard, bcAmericanExpress, bcSorocred, bcOutros]);
end;

function StrToBandeiraCartao(out ok: boolean; const s: string): TpcnBandeiraCartao;
begin
  result := StrToEnumerado(ok, s, ['01', '02', '03', '04', '99'],
                                  [bcVisa, bcMasterCard, bcAmericanExpress, bcSorocred, bcOutros]);
end;

function RegTribToStr(const t: TpcnRegTrib ): string;
begin
  result := EnumeradoToStr(t, ['','1', '3'], [RTRegimeNormal, RTSimplesNacional, RTRegimeNormal]);
end;

function StrToRegTrib(out ok: boolean; const s: string): TpcnRegTrib ;
begin
  result := StrToEnumerado(ok, s, ['','1', '3'],[RTRegimeNormal, RTSimplesNacional, RTRegimeNormal]);
end;

function RegTribISSQNToStr(const t: TpcnRegTribISSQN ): string;
begin
  result := EnumeradoToStr(t, ['', '1', '2', '3', '4', '5', '6'],
                              [ RTISSNenhum, RTISSMicroempresaMunicipal, RTISSEstimativa, RTISSSociedadeProfissionais,
                               RTISSCooperativa, RTISSMEI, RTISSMEEPP]);
end;

function StrToRegTribISSQN(out ok: boolean; const s: string): TpcnRegTribISSQN ;
begin
  result := StrToEnumerado(ok, s, ['', '1', '2', '3', '4', '5', '6'],
                                  [RTISSNenhum, RTISSMicroempresaMunicipal, RTISSEstimativa, RTISSSociedadeProfissionais,
                                   RTISSCooperativa, RTISSMEI, RTISSMEEPP]);
end;

function indRatISSQNToStr(const t: TpcnindRatISSQN ): string;
begin
  result := EnumeradoToStr(t, ['S', 'N'], [irSim, irNao]);
end;

function StrToindRatISSQN(out ok: boolean; const s: string): TpcnindRatISSQN ;
begin
  result := StrToEnumerado(ok, s, ['S', 'N'],[irSim, irNao]);
end;

function indRegraToStr(const t: TpcnindRegra  ): string;
begin
  result := EnumeradoToStr(t, ['A', 'T'], [irArredondamento, irTruncamento]);
end;

function StrToindRegra(out ok: boolean; const s: string): TpcnindRegra  ;
begin
  result := StrToEnumerado(ok, s, ['A', 'T'],[irArredondamento, irTruncamento]);
end;

function CodigoMPToStr(const t: TpcnCodigoMP ): string;
begin
  result := EnumeradoToStr(t, ['01', '02', '03', '04', '05', '10', '11', '12', '13', '99'], [MPDinheiro, MPCheque, MPCartaodeCredito, MPCartaodeDebito, MPCreditoLoja, MPValeAlimentacao, MPValeRefeicao, MPValePresente, MPValeCombustivel, MPOutros]);
end;

function StrToCodigoMP(out ok: boolean; const s: string): TpcnCodigoMP ;
begin
  result := StrToEnumerado(ok, s, ['01', '02', '03', '04', '05', '10', '11', '12', '13', '99'],[MPDinheiro, MPCheque, MPCartaodeCredito, MPCartaodeDebito, MPCreditoLoja, MPValeAlimentacao, MPValeRefeicao, MPValePresente, MPValeCombustivel, MPOutros]);
end;

function CodigoMPToDescricao(const t: TpcnCodigoMP ): string;
begin
  result := EnumeradoToStr(t, ['Dinheiro', 'Cheque', 'Cart�o de Cr�dito',
                               'Cart�o de D�bito', 'Cr�dito Loja', 'Vale Alimenta��o',
                               'Vale Refei��o', 'Vale Presente', 'Vale Combust�vel',
                               'Outros'],
                               [MPDinheiro, MPCheque, MPCartaodeCredito,
                               MPCartaodeDebito, MPCreditoLoja, MPValeAlimentacao,
                               MPValeRefeicao, MPValePresente, MPValeCombustivel,
                               MPOutros]);
end;

// Tipo da Unidade de Transporte ***********************************************

function UnidTranspToStr(const t: TpcnUnidTransp):string;
begin
  result := EnumeradoToStr(t,
                           ['1', '2', '3', '4', '5', '6', '7'],
                           [utRodoTracao, utRodoReboque, utNavio, utBalsa,
                            utAeronave, utVagao, utOutros]);
end;

function StrToUnidTransp(out ok: boolean; const s: string): TpcnUnidTransp;
begin
  result := StrToEnumerado(ok, s,
                           ['1', '2', '3', '4', '5', '6', '7'],
                           [utRodoTracao, utRodoReboque, utNavio, utBalsa,
                            utAeronave, utVagao, utOutros]);
end;

// Tipo da Unidade de Carga ****************************************************

function UnidCargaToStr(const t: TpcnUnidCarga):string;
begin
  result := EnumeradoToStr(t,
                           ['1', '2', '3', '4'],
                           [ucContainer, ucULD, ucPallet, ucOutros]);
end;

function StrToUnidCarga(out ok: boolean; const s: string): TpcnUnidCarga;
begin
  result := StrToEnumerado(ok, s,
                           ['1', '2', '3', '4'],
                           [ucContainer, ucULD, ucPallet, ucOutros]);
end;

function indNegociavelToStr(const t: TpcnindNegociavel ): string;
begin
  result := EnumeradoToStr(t, ['0', '1'], [inNaoNegociavel, inNegociavel]);
end;

function StrToindNegociavel(out ok: boolean; const s: string): TpcnindNegociavel;
begin
  result := StrToEnumerado(ok, s, ['0', '1'], [inNaoNegociavel, inNegociavel]);
end;

function indIEDestToStr(const t: TpcnindIEDest ): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '9'], [inContribuinte, inIsento, inNaoContribuinte]);
end;

function StrToindIEDest(out ok: boolean; const s: string): TpcnindIEDest;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '9'], [inContribuinte, inIsento, inNaoContribuinte]);
end;

function TipoViaTranspToStr(const t: TpcnTipoViaTransp ): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '4', '5', '6', '7', '8', '9',
                               '10', '11', '12'],
                              [tvMaritima, tvFluvial, tvLacustre, tvAerea, tvPostal,
                               tvFerroviaria, tvRodoviaria, tvConduto, tvMeiosProprios,
                               tvEntradaSaidaFicta, tvCourier, tvHandcarry]);
end;

function StrToTipoViaTransp(out ok: boolean; const s: string): TpcnTipoViaTransp;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '4', '5', '6', '7', '8', '9',
                                   '10', '11', '12'],
                                  [tvMaritima, tvFluvial, tvLacustre, tvAerea, tvPostal,
                                   tvFerroviaria, tvRodoviaria, tvConduto, tvMeiosProprios,
                                   tvEntradaSaidaFicta, tvCourier, tvHandcarry]);
end;

function TipoIntermedioToStr(const t: TpcnTipoIntermedio ): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3'],
                              [tiContaPropria, tiContaOrdem, tiEncomenda]);
end;

function StrToTipoIntermedio(out ok: boolean; const s: string): TpcnTipoIntermedio;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3'],
                                  [tiContaPropria, tiContaOrdem, tiEncomenda]);
end;

function indISSRetToStr(const t: TpcnindISSRet ): string;
begin
  result := EnumeradoToStr(t, ['1', '2'],
                              [iirSim, iirNao]);
end;

function StrToindISSRet(out ok: boolean; const s: string): TpcnindISSRet;
begin
  result := StrToEnumerado(ok, s, ['1', '2'],
                                  [iirSim, iirNao]);
end;

function indISSToStr(const t: TpcnindISS ): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '4', '5', '6', '7'],
                              [iiExigivel, iiNaoIncidencia, iiIsencao, iiExportacao,
                               iiImunidade, iiExigSuspDecisaoJudicial, iiExigSuspProcessoAdm]);
end;

function StrToindISS(out ok: boolean; const s: string): TpcnindISS;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '4', '5', '6', '7'],
                                  [iiExigivel, iiNaoIncidencia, iiIsencao, iiExportacao,
                                   iiImunidade, iiExigSuspDecisaoJudicial, iiExigSuspProcessoAdm]);
end;

function indIncentivoToStr(const t: TpcnindIncentivo ): string;
begin
  result := EnumeradoToStr(t, ['1', '2'],
                              [iiSim, iiNao]);
end;

function StrToindIncentivo(out ok: boolean; const s: string): TpcnindIncentivo;
begin
  result := StrToEnumerado(ok, s, ['1', '2'],
                                  [iiSim, iiNao]);
end;

function StrToVersaoDF(out ok: boolean; const s: string): TpcnVersaoDF;
begin
  result := StrToEnumerado(ok, s, ['2.00', '3.00', '3.10'],
                                  [ve200, ve300, ve310]);
end;

function VersaoDFToStr(const t: TpcnVersaoDF): string;
begin
  result := EnumeradoToStr(t, ['2.00', '3.00', '3.10'],
                              [ve200, ve300, ve310]);
end;

function GetVersaoNFe(AModeloDF: TpcnModeloDF; AVersaoDF: TpcnVersaoDF; ALayOut: TLayOut): string;
begin
  result := '';

  case AModeloDF of
    moNFe:
      begin
        case AVersaoDF of
          ve200:
            begin
              case ALayOut of
                LayNfeStatusServico:  result := '2.00';
                LayNfeRecepcao:       result := '2.00';
                LayNfeRetRecepcao:    result := '2.00';
                LayNfeConsulta:       result := '2.01';
                LayNfeCancelamento:   result := '2.00';
                LayNfeInutilizacao:   result := '2.00';
                LayNfeCadastro:       result := '2.00';
                LayNfeEnvDPEC:        result := '1.01';
                LayNfeConsultaDPEC:   result := '1.01';
                LayNFeCCe:            result := '1.00';
                LayNFeEvento:         result := '1.00';
                LayNFeEventoAN:       result := '1.00';
                LayNFeConsNFeDest:    result := '1.01';
                LayNFeDownloadNFe:    result := '1.00';
                LayNfeAutorizacao:    result := '2.00';
                LayNfeRetAutorizacao: result := '2.00';
                LayDistDFeInt:        result := '1.00';
                LayAdministrarCSCNFCe:result := '0.00';
              end;
            end;

          ve310:
            begin
              case ALayOut of
                LayNfeStatusServico:  result := '3.10';
                LayNfeRecepcao:       result := '3.10';
                LayNfeRetRecepcao:    result := '3.10';
                LayNfeConsulta:       result := '3.10';
                LayNfeCancelamento:   result := '3.10';
                LayNfeInutilizacao:   result := '3.10';
                LayNfeCadastro:       result := '2.00';
                LayNfeEnvDPEC:        result := '1.01';
                LayNfeConsultaDPEC:   result := '1.01';
                LayNFeCCe:            result := '1.00';
                LayNFeEvento:         result := '1.00';
                LayNFeEventoAN:       result := '1.00';
                LayNFeConsNFeDest:    result := '1.01';
                LayNFeDownloadNFe:    result := '1.00';
                LayNfeAutorizacao:    result := '3.10';
                LayNfeRetAutorizacao: result := '3.10';
                LayDistDFeInt:        result := '1.00';
                LayAdministrarCSCNFCe: result := '0.00';
              end;
            end;
        end;
      end;

    moNFCe:
      begin
        case AVersaoDF of
          ve300:
            begin
              case ALayOut of
                LayNfeStatusServico:  result := '3.00';
                LayNfeRecepcao:       result := '3.00';
                LayNfeRetRecepcao:    result := '3.00';
                LayNfeConsulta:       result := '3.00';
                LayNfeCancelamento:   result := '3.00';
                LayNfeInutilizacao:   result := '3.00';
                LayNfeCadastro:       result := '2.00';
                LayNfeEnvDPEC:        result := '1.01';
                LayNfeConsultaDPEC:   result := '1.01';
                LayNFeCCe:            result := '1.00';
                LayNFeEvento:         result := '1.00';
                LayNFeEventoAN:       result := '1.00';
                LayNFeConsNFeDest:    result := '1.01';
                LayNFeDownloadNFe:    result := '1.00';
                LayNfeAutorizacao:    result := '3.00';
                LayNfeRetAutorizacao: result := '3.00';
                LayDistDFeInt:        result := '1.00';
                LayAdministrarCSCNFCe: result := '1.00';
                LayNFCeEPEC:          result := '1.00';
              end;
            end;

          ve310:
            begin
              case ALayOut of
                LayNfeStatusServico:  result := '3.10';
                LayNfeRecepcao:       result := '3.10';
                LayNfeRetRecepcao:    result := '3.10';
                LayNfeConsulta:       result := '3.10';
                LayNfeCancelamento:   result := '3.10';
                LayNfeInutilizacao:   result := '3.10';
                LayNfeCadastro:       result := '2.00';
                LayNfeEnvDPEC:        result := '1.01';
                LayNfeConsultaDPEC:   result := '1.01';
                LayNFeCCe:            result := '1.00';
                LayNFeEvento:         result := '1.00';
                LayNFeEventoAN:       result := '1.00';
                LayNFeConsNFeDest:    result := '1.01';
                LayNFeDownloadNFe:    result := '1.00';
                LayNfeAutorizacao:    result := '3.10';
                LayNfeRetAutorizacao: result := '3.10';
                LayDistDFeInt:        result := '1.00';
                LayNFCeEPEC:          result := '1.00';

                LayAdministrarCSCNFCe: result := '1.00';
              end;
            end;
        end;
      end;
  end;
end;

function GetVersaoCTe(AVersaoDF: TpcnVersaoDF; ALayOut: TLayOutCTe): string;
begin
  result := '';

  case AVersaoDF of
    ve200: begin
             case ALayOut of
               LayCTeStatusServico: result := '2.00';
               LayCTeRecepcao:      result := '2.00';
               LayCTeRetRecepcao:   result := '2.00';
               LayCTeConsultaCT:    result := '2.00';
               LayCTeCancelamento:  result := '1.04';
               LayCTeInutilizacao:  result := '2.00';
               LayCTeCadastro:      result := '2.00';
               LayCTeEvento:        result := '2.00';
               LayCTeEventoEPEC:    result := '2.00';
             end;
           end;
  end;
end;

function TipoAutorToStr(const t: TpcnTipoAutor ): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3', '5', '6', '9'],
                              [taEmpresaEmitente, taEmpresaDestinataria,
                               taEmpresa, taFisco, taRFB, taOutros]);
end;

function StrToTipoAutor(out ok: boolean; const s: string): TpcnTipoAutor;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3', '5', '6', '9'],
                                  [taEmpresaEmitente, taEmpresaDestinataria,
                                   taEmpresa, taFisco, taRFB, taOutros]);
end;

function IndOperacaoToStr(const t: TpcnIndOperacao ): string;
begin
  result := EnumeradoToStr(t, ['1', '2', '3'],
                              [ioConsultaCSC, ioNovoCSC, ioRevogaCSC]);
end;

function StrToIndOperacao(out ok: boolean; const s: string): TpcnIndOperacao;
begin
  result := StrToEnumerado(ok, s, ['1', '2', '3'],
                                  [ioConsultaCSC, ioNovoCSC, ioRevogaCSC]);
end;

function TipoSchemaToStr(const t: TpcnTipoSchema ): string;
begin
  result := EnumeradoToStr(t, ['resNFe_v1.00.xsd', 'resEvento_v1.00.xsd',
                               'procNFe_v1.00.xsd', 'procNFe_v2.00.xsd',
                               'procNFe_v3.10.xsd', 'procEventoNFe_v1.00.xsd',
                               'procMDFe_v1.00.xsd', 'procEventoMDFe_v1.00.xsd'],
                              [tsresNFe, tsresEvento, tsprocNFe, tsprocNFe,
                               tsprocNFe, tsprocEventoNFe,
                               tsprocMDFe, tsprocEventoMDFe]);
end;

function StrToTipoSchema(out ok: boolean; const s: string): TpcnTipoSchema;
begin
  result := StrToEnumerado(ok, s, ['resNFe_v1.00.xsd', 'resEvento_v1.00.xsd',
                                   'procNFe_v1.00.xsd', 'procNFe_v2.00.xsd',
                                   'procNFe_v3.10.xsd', 'procEventoNFe_v1.00.xsd',
                                   'procMDFe_v1.00.xsd', 'procEventoMDFe_v1.00.xsd'],
                                  [tsresNFe, tsresEvento, tsprocNFe, tsprocNFe,
                                   tsprocNFe, tsprocEventoNFe,
                                   tsprocMDFe, tsprocEventoMDFe]);
end;

end.
