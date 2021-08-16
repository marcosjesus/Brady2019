unit uFrmImportarNFeEntrada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, cxControls,
  cxCustomData, cxStyles, cxTL, cxTLdxBarBuiltInMenu, dxSkinsCore, FMTBcd,
  StdCtrls, DB, SqlExpr, Mask, rsEdit, cxInplaceContainer, cxButtons, ExtCtrls,
  FileCtrl, cxTextEdit, ACBrNFe, SqlTimSt, dxSkinBlack, dxSkinBlue,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, ACBrBase,  pcnNFeRTXT,
  Global, pcnConversao, DBConect, StrFun, dxSkinCaramel,  pcnConversaoNfe,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, DateUtils, Funcoes,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinHighContrast, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint, EditBusca, ACBrDFe,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  SetParametro, cxContainer, cxEdit, cxLabel, dxGDIPlusClasses;

Type
   TTipoRetorno = record
      trCodCliente       : Integer;
      trCNPJDestinatario : String;
      trCodFornecedor    : Integer;
      trCNPJEmitente     : String;
      //trCodPlanoContatil : String;
      trCodCentroCusto   : String;
      trRegimeICMS       : String;
      procedure Inicializar;
   end;

Type
  TTipoProduto = record
     trCodProdInterno : String;
     trCodGrupo       : String;
     procedure Inicializar;
  end;

type
  TfrmImportarNFeEntrada = class(TForm)
    pnlTop: TPanel;
    tlNFe: TcxTreeList;
    Panel1: TPanel;
    Panel13: TPanel;
    cxTreeList1Column1: TcxTreeListColumn;
    cxTreeList1Column2: TcxTreeListColumn;
    cxTreeList1Column3: TcxTreeListColumn;
    cxTreeList1Column4: TcxTreeListColumn;
    cxTreeList1Column5: TcxTreeListColumn;
    ACBrNFe1: TACBrNFe;
    btnImportar: TcxButton;
    ButSair: TcxButton;
    lblTotalReg: TLabel;
    btnLocalizar: TcxButton;
    Panel2: TPanel;
    lblLocal: TLabel;
    lblTotalImp: TLabel;
    cxTreeList1Column6: TcxTreeListColumn;
    EdtEmitente: TEditBusca;
    qryInsert: TFDQuery;
    qryEmitente: TFDQuery;
    qryAux: TFDQuery;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnLocalizarClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure  RetornarCodigoCliente(CNPJ : String);
    procedure  RetornarCodigoFornecedor(CodFilial : Integer; CNPJ : String);
    function  RetornaCodigoTransportadora(Indice : Integer; CNPJ : String) : String;
    function  NovoCodigoTransportadora : String;
    procedure RetornaCodigoProduto(CodFornecedor, CodProdutoFornecedor, NCM , Descricao: String);
    procedure ButSairClick(Sender: TObject);
    procedure EdtEmitenteExit(Sender: TObject);
     procedure Mensagem(pMensagem: String);
  private
    { Private declarations }
    tpRetorno : TTipoRetorno;
    tpProduto : TTipoProduto;
    lPathNfe        : string;
    lPathImportados : string;
    lPathInvalidos  : string;
    lArquivoImportado : string;
    cPASTA_ARQUIVOS_IMPORTADOS, cPASTA_ARQUIVOS_INVALIDOS : String;
    n : Integer;
    procedure InitForm;
    Function VerificaUnidade(Unidade : String) : String;
    function AtualizaNaturezaOperacao(CFOP, CodFornecedor: string): String;
    procedure GravaCreditoSimplesNacional(pCodFornecedor: String;
      DataEmissao: TDateTime; Percentual: Double);
    function LastCodigo(Chave, Tab, Condicao: String): String;
  public
    { Public declarations }
  end;

var
  frmImportarNFeEntrada: TfrmImportarNFeEntrada;

implementation
uses MensFun,  DateFun ;

{$R *.dfm}

(*
--Leandro 24/08/2012
--Fix/Solu��o tempor�ria para falha do DirectoryExists()
--http://qc.embarcadero.com/wc/qcmain.aspx?d=92183
*)
function DirExists( const Directory: string ): boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(Directory));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

function TfrmImportarNFeEntrada.LastCodigo(Chave, Tab, Condicao: String): String;
var
  QryAux : TFDQuery;
begin
 Result := '';

 QryAux := TFDQuery.Create(Self);
 QryAux.Connection := DB_Conect.SQLConnection ;

  With qryAux do begin

    close;
    Sql.Clear;
    Sql.Add('select Max(' + Chave  +') from ' + Tab + ' '+ Condicao );    // condi��o usado pra gerar subcodigo
    Open;

    if not (Eof) and (Fields[0].AsString <> '') then
      Result :=  IntToStr( StrToInt(Fields[0].AsString) + 1 )
    else if Condicao <> '' then       // � um subcodigo
      Result := '000001'
    else
      Result := '001';                // n�o � subcodigo
  end;
  qryAux.Close;
 QryAux.Destroy;
end;


procedure TfrmImportarNFeEntrada.Mensagem(pMensagem: String);
begin
  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;
end;

procedure TfrmImportarNFeEntrada.btnImportarClick(Sender: TObject);
var
  i, J, D, T      : integer;
  lSQL            : string;
  lArquivo        : string;
  pCodEmitente    : Integer;
  bCancelar       : Boolean;
  bTemParcela     : Boolean;
begin

   try
      try
     // AguardandoProcesso(frmImportarNFeEntrada, true, 'Importando Nfe de Sa�da');

      bCancelar := False;
      for i := 0 to tlNFe.Count -1 do
        begin
          lArquivo := lPathNfe + tlNFe.Items[i].Values[4];
          lArquivoImportado := lPathImportados + '\' + tlNFe.Items[i].Values[4];

          if tlNFe.Items[i].Values[5] <> 'Importar' then
          begin
            if FileExists(PWideChar( lArquivo )) then
               DeleteFile(PWideChar( lArquivo ));
            Continue;
          end;

          ACBrNFe1.NotasFiscais.Clear;
          ACBrNFe1.NotasFiscais.LoadFromFile( lArquivo );

          //GCambio.BeginTrans;
          pCodEmitente := EdtEmitente.bs_KeyValue;

          with ACBrNFe1.NotasFiscais.Items[0].NFe do
          begin
           Mensagem('Importando Nota Fiscal Nr� ' + IntToStr(ide.nnf) );
           RetornarCodigoFornecedor(pCodEmitente, Emit.CNPJCPF);

           lsql := ' insert into nfe (';
           lsql := lsql + ' numnf,  ';
           lsql := lsql + ' cnpj_emitente, ';
           lsql := lsql + ' cnpj_destinatario, ';
           lsql := lsql + ' datainclusao, ';
           lsql := lsql + ' datasaida, ';
           lsql := lsql + ' dataemissao, ';
           lsql := lsql + ' vencimento,  ';
           lsql := lsql + ' motivo_canc, ';
           lsql := lsql + ' codnatureza, ';
          // lsql := lsql + ' n_cfop, ';
           lsql := lsql + ' justificativa, ';
           lsql := lsql + ' vlrimcs_st, ';
           lsql := lsql + ' frete, ';
           lsql := lsql + ' tiponf, ';
           lsql := lsql + ' valortotal, ';
           lsql := lsql + ' fretetotal,';
           lsql := lsql + ' totalprod, ';
           lsql := lsql + ' baseicms, ';
           lsql := lsql + ' vlrtoticms, ';
           lsql := lsql + ' baseicms_st, ';
           lsql := lsql + ' datacancelamento, ';
           lsql := lsql + ' situacao, ';
           lsql := lsql + ' instrucao, ';
           lsql := lsql + ' codcondpagto, ';
           lsql := lsql + ' observacao, ';
           lsql := lsql + ' obspagto, ';
           lsql := lsql + ' codtransportadora, ';
           lsql := lsql + ' placaveiculo,';
           lsql := lsql + ' pesobruto, ';
           lsql := lsql + ' pesoliq, ';
           lsql := lsql + ' qtde, ';
           lsql := lsql + ' marca, ';
           lsql := lsql + ' especie, ';
           lsql := lsql + ' nfe, ';
           lsql := lsql + ' recibo, ';
           lsql := lsql + ' protocolo, ';
           lsql := lsql + ' chave_nfe, ';
          // lsql := lsql + ' digvalidadornfe, ';
           lsql := lsql + ' dtrecibo, ';
           lsql := lsql + ' confirmada, ';
           lsql := lsql + ' recibo_canc, ';
           lsql := lsql + ' protocolo_canc,';
           lsql := lsql + ' dtrecibo_canc, ';
           lsql := lsql + ' situacao_nfe, ';
           lsql := lsql + ' arquivo_xml, ';
           lsql := lsql + ' chaveend, ';
           lsql := lsql + ' path_xml, ';
           lsql := lsql + ' totaldesconto, ';
           lsql := lsql + ' cod_pedido, ';
           lsql := lsql + ' codfilialped,';
           lsql := lsql + ' estadoplaca,';
           lsql := lsql + ' vlrtotipi, ';
           lsql := lsql + ' icms_porcinter, ';
           lsql := lsql + ' mesmoendereco,';
           lsql := lsql + ' totalseguro, ';
           lsql := lsql + ' basecofins, ';
           lsql := lsql + ' valorpis, ';
           lsql := lsql + ' valorcofins, ';
           lsql := lsql + ' totaloutrasdespesas, ';
           lsql := lsql + ' baseipi,';
           lsql := lsql + ' basepis, ';
           lsql := lsql + ' totalfrete ';
           lsql := lsql + ' ) values  ( ';
           lsql := lsql + ' :numnf,  ';
           lsql := lsql + ' :cnpj_emitente, ';
           lsql := lsql + ' :cnpj_destinatario, ';
           lsql := lsql + ' :datainclusao, ';
           lsql := lsql + ' :datasaida, ';
           lsql := lsql + ' :dataemissao, ';
           lsql := lsql + ' :vencimento,  ';
           lsql := lsql + ' :motivo_canc, ';
           lsql := lsql + ' :codnatureza, ';
         //  lsql := lsql + ' :n_cfop, ';
           lsql := lsql + ' :justificativa, ';
           lsql := lsql + ' :vlrimcs_st, ';
           lsql := lsql + ' :frete, ';
           lsql := lsql + ' :tiponf, ';
           lsql := lsql + ' :valortotal, ';
           lsql := lsql + ' :fretetotal,';
           lsql := lsql + ' :totalprod, ';
           lsql := lsql + ' :baseicms, ';
           lsql := lsql + ' :vlrtoticms, ';
           lsql := lsql + ' :baseicms_st, ';
           lsql := lsql + ' :datacancelamento, ';
           lsql := lsql + ' :situacao, ';
           lsql := lsql + ' :instrucao, ';
           lsql := lsql + ' :codcondpagto, ';
           lsql := lsql + ' :observacao, ';
           lsql := lsql + ' :obspagto, ';
           lsql := lsql + ' :codtransportadora, ';
           lsql := lsql + ' :placaveiculo,';
           lsql := lsql + ' :pesobruto, ';
           lsql := lsql + ' :pesoliq, ';
           lsql := lsql + ' :qtde, ';
           lsql := lsql + ' :marca, ';
           lsql := lsql + ' :especie, ';
           lsql := lsql + ' :nfe, ';
           lsql := lsql + ' :recibo, ';
           lsql := lsql + ' :protocolo, ';
           lsql := lsql + ' :chave_nfe, ';
         //  lsql := lsql + ' :digvalidadornfe, ';
           lsql := lsql + ' :dtrecibo, ';
           lsql := lsql + ' :confirmada, ';
           lsql := lsql + ' :recibo_canc, ';
           lsql := lsql + ' :protocolo_canc,';
           lsql := lsql + ' :dtrecibo_canc, ';
           lsql := lsql + ' :situacao_nfe, ';
           lsql := lsql + ' :arquivo_xml, ';
           lsql := lsql + ' :chaveend, ';
           lsql := lsql + ' :path_xml, ';
           lsql := lsql + ' :totaldesconto, ';
           lsql := lsql + ' :cod_pedido, ';
           lsql := lsql + ' :codfilialped,';
           lsql := lsql + ' :estadoplaca,';
           lsql := lsql + ' :vlrtotipi, ';
           lsql := lsql + ' :icms_porcinter, ';
           lsql := lsql + ' :mesmoendereco,';
           lsql := lsql + ' :totalseguro, ';
           lsql := lsql + ' :basecofins, ';
           lsql := lsql + ' :valorpis, ';
           lsql := lsql + ' :valorcofins, ';
           lsql := lsql + ' :totaloutrasdespesas, ';
           lsql := lsql + ' :baseipi,';
           lsql := lsql + ' :basepis, ';
           lsql := lsql + ' :totalfrete ';
           lsql := lsql + ' ) ';

           qryinsert.close;
           qryinsert.sql.clear;
           qryinsert.sql.add( lsql );

           // preenche record tiporetorno.
           RetornarCodigoCliente(dest.cnpjcpf);
          // Verifica se Nota Fiscal ja foi importada.
          qryaux.close;
          qryaux.sql.clear;
          qryaux.sql.add('select cnpj_destinatario ');
          qryaux.sql.add('from nfe ');
          qryaux.sql.add('where numnf = :numnf and cnpj_emitente  = :cnpj_emitente and cnpj_destinatario = :cnpj_destinatario ');
          qryaux.parambyname('numnf').AsInteger                     := ide.nnf;
          qryaux.parambyname('cnpj_emitente').AsString              := tpRetorno.trCNPJEmitente;
          qryaux.parambyname('cnpj_destinatario').AsString          := tpRetorno.trCNPJDestinatario;
          qryaux.open;

          if not qryaux.isempty then
          begin
            if fileexists(pwidechar( larquivo )) then
               deletefile(pwidechar( larquivo ));
            continue;
          end;

           qryinsert.parambyname('numnf').asinteger                    := ide.nnf;
           qryinsert.parambyname('cnpj_emitente').asstring             := tpretorno.trCNPJEmitente;
           qryinsert.parambyname('cnpj_destinatario').asstring         := tpretorno.trCNPJDestinatario;
           qryinsert.parambyname('datainclusao').assqltimestamp        := datetimetosqltimestamp(procnfe.dhrecbto);
           qryinsert.parambyname('datasaida').assqltimestamp           := datetimetosqltimestamp(ide.dsaient);
           qryinsert.parambyname('dataemissao').assqltimestamp         := datetimetosqltimestamp(ide.demi);
           qryinsert.parambyname('vencimento').assqltimestamp          := datetimetosqltimestamp(date);
           qryinsert.parambyname('motivo_canc').asstring               := procnfe.xmotivo;
           qryinsert.parambyname('codnatureza').asstring               := '0';
          // qryinsert.parambyname('n_cfop').asstring                    := ide.natop;
           qryinsert.parambyname('justificativa').asstring             := ide.xjust;
           qryinsert.parambyname('vlrimcs_st').asfloat                 := total.icmstot.vst;
           qryinsert.parambyname('frete').asstring                     := modfretetostr(transp.modfrete);
           qryinsert.parambyname('tiponf').asstring                    := 'e';
           qryinsert.parambyname('valortotal').asfloat                 := total.icmstot.vnf;
           qryinsert.parambyname('fretetotal').asfloat                 := total.icmstot.vfrete;
           qryinsert.parambyname('totalprod').asfloat                  := total.icmstot.vprod;
           qryinsert.parambyname('baseicms').asfloat                   := total.icmstot.vbc;
           qryinsert.parambyname('vlrtoticms').asfloat                 := total.icmstot.vicms;
           qryinsert.parambyname('baseicms_st').asfloat                := total.icmstot.vbcst;
           qryinsert.parambyname('datacancelamento').assqltimestamp    := datetimetosqltimestamp(ide.demi);
           qryinsert.parambyname('situacao').asstring                  := 'pendente';
           qryinsert.parambyname('instrucao').asstring                 := '';
           qryinsert.parambyname('codcondpagto').asstring              := '';
           qryinsert.parambyname('observacao').asstring                := infadic.infcpl;
           qryinsert.parambyname('obspagto').asstring                  := '';
           qryinsert.parambyname('codtransportadora').asstring         := '0'; //retornacodigotransportadora(n, transp.transporta.cnpjcpf);
           qryinsert.parambyname('placaveiculo').asstring              := transp.veictransp.placa;
           for t:=0 to transp.vol.count-1 do
            begin
              with transp.vol.items[t] do
               begin
                 qryinsert.parambyname('pesobruto').asfloat            := pesob;
                 qryinsert.parambyname('pesoliq').asfloat              := pesol;
                 qryinsert.parambyname('qtde').asfloat                 := qvol;
               end;

           end;

           if transp.vol.count = 0 then
           begin
                qryinsert.parambyname('pesobruto').asfloat            := 0;
                qryinsert.parambyname('pesoliq').asfloat              := 0;
                qryinsert.parambyname('qtde').asfloat                 := 0;
           end;

           qryinsert.parambyname('marca').asstring                     := '';
           qryinsert.parambyname('especie').asstring                   := '';
           if procnfe.nprot <> ''  then
             qryinsert.parambyname('nfe').asstring                     := 'registrado'
           else qryinsert.parambyname('nfe').asstring                  := '';
           qryinsert.parambyname('recibo').asstring                    := '';
           qryinsert.parambyname('protocolo').asstring                 := procnfe.nprot;
           qryinsert.parambyname('chave_nfe').asstring                 := procnfe.chnfe;
       //    qryinsert.parambyname('digvalidadornfe').asstring           := procnfe.digval;

           qryinsert.parambyname('dtrecibo').assqltimestamp            := datetimetosqltimestamp(procnfe.dhrecbto);
           qryinsert.parambyname('confirmada').asinteger               := 0;
           qryinsert.parambyname('recibo_canc').asstring               := '';
           qryinsert.parambyname('protocolo_canc').asstring            := '';
           qryinsert.parambyname('dtrecibo_canc').assqltimestamp       := datetimetosqltimestamp(ide.demi);
           qryinsert.parambyname('situacao_nfe').asstring              := 'importada';
           qryinsert.parambyname('arquivo_xml').asstring               := larquivo;
           qryinsert.parambyname('chaveend').asinteger                  := 0;
           qryinsert.parambyname('path_xml').asstring                  := lpathimportados;
           qryinsert.parambyname('totaldesconto').asfloat              := total.icmstot.vdesc;
           qryinsert.parambyname('cod_pedido').asinteger               := 0;
           qryinsert.parambyname('codfilialped').asstring              := '';
           qryinsert.parambyname('estadoplaca').asstring               := '';
           qryinsert.parambyname('vlrtotipi').asfloat                  := total.icmstot.vipi;
           qryinsert.parambyname('icms_porcinter').asfloat             := 0;
           qryinsert.parambyname('mesmoendereco').asstring             := '';
           qryinsert.parambyname('totalseguro').asfloat                := total.icmstot.vseg;
           qryinsert.parambyname('basecofins').asfloat                 := 0;
           qryinsert.parambyname('valorpis').asfloat                   := total.icmstot.vpis;
           qryinsert.parambyname('valorcofins').asfloat                := total.icmstot.vcofins;
           qryinsert.parambyname('totaloutrasdespesas').asfloat        := total.icmstot.voutro;
           qryinsert.parambyname('baseipi').asfloat                    := 0;
           qryinsert.parambyname('basepis').asfloat                    := 0;
           qryinsert.parambyname('totalfrete').asfloat                 := total.icmstot.vfrete;

           try
             qryinsert.execsql;

           except
             on e:exception do
               begin
     //            db_conect.getcomando(qryinsert, frmimportarnfeentrada, false);
                 //gcambio.execrollback;

                 btnimportar.enabled  := false;
                 mens_menserro( pchar(larquivo) + #13#10 + 'falha ao incluir nfe.' + e.message );
                 continue;
               end;
           end;
 {
        trvwnfe.items.addchild(node,'vfcpufdest='   +floattostr(total.icmstot.vfcpufdest)) ;
        trvwnfe.items.addchild(node,'vicmsufdest='  +floattostr(total.icmstot.vicmsufdest)) ;
        trvwnfe.items.addchild(node,'vicmsufremet=' +floattostr(total.icmstot.vicmsufremet)) ;
  }

          // itens da nota

          for j := 0 to det.count-1 do
           begin
             with det.items[j] do
              begin

               lsql := 'insert into nfe_itens (';
               lsql := lsql + ' numnf, ';
               lsql := lsql + ' cnpj_destinatario, ';
               lsql := lsql + ' cnpj_emitente, ';
               lsql := lsql + ' codproduto, ';
               lsql := lsql + ' desc_produto, ';
               lsql := lsql + ' unidadeitem, ';
               lsql := lsql + ' numitem,  ';
               lsql := lsql + ' codnatureza, ';
               lsql := lsql + ' i_cfop, ';
              // lsql := lsql + ' codgrupo, ';
 //              lsql := lsql + ' dataentrega, ';
               lsql := lsql + ' qtde, ';
               lsql := lsql + ' valorunitario,  ';
               lsql := lsql + ' valortotal, ';
               lsql := lsql + ' valorliquido, ';
               lsql := lsql + ' nf_tipoicms, ';
               lsql := lsql + ' baseicmsst,  ';
               lsql := lsql + ' valoricms_st, ';
               lsql := lsql + ' nf_iva_st, ';
               lsql := lsql + ' iva_original, ';
               lsql := lsql + ' baseicms_it,  ';
               lsql := lsql + ' baseicms , ';
               lsql := lsql + ' valoricms,';
               lsql := lsql + ' porcicms, ';
               lsql := lsql + ' nf_tipoipi,  ';
               lsql := lsql + ' baseipi, ';
               lsql := lsql + ' valoripi, ';
               lsql := lsql + ' porcipi, ';
               lsql := lsql + ' nf_tipopis,  ';
               lsql := lsql + ' basepis, ';
               lsql := lsql + ' valorpis ,  ';
               lsql := lsql + ' porcpis, ';
               lsql := lsql + ' nf_tipocofins, ';
               lsql := lsql + ' basecofins,';
               lsql := lsql + ' valorcofins, ';
               lsql := lsql + ' porccofins,  ';
               lsql := lsql + ' valorfrete , ';
               lsql := lsql + ' vlroutrasdespesas, ';
               lsql := lsql + ' vlrseguro,  ';
               lsql := lsql + ' porcprovicmspartilha,  ';
               lsql := lsql + ' vlrfcp ,  ';
               lsql := lsql + ' vlricmsufdestino , ';
               lsql := lsql + ' vlricmsufremetente ,  ';
               lsql := lsql + ' aliqfcp, ';
               lsql := lsql + ' difal, ';
               lsql := lsql + ' porcdesconto, ';
               lsql := lsql + ' valordesconto,  ';
               lsql := lsql + ' porccredito, ';
               lsql := lsql + ' vlrcredito ';
               lsql := lsql + ' ) values (';
               lsql := lsql + ' :numnf, ';
               lsql := lsql + ' :cnpj_destinatario, ';
               lsql := lsql + ' :cnpj_emitente, ';
               lsql := lsql + ' :codproduto, ';
               lsql := lsql + ' :desc_produto, ';
               lsql := lsql + ' :unidadeitem, ';
               lsql := lsql + ' :numitem,  ';
               lsql := lsql + ' :codnatureza, ';
               lsql := lsql + ' :i_cfop, ';
             //  lsql := lsql + ' :codgrupo, ';
 //              lsql := lsql + ' :dataentrega, ';
               lsql := lsql + ' :qtde, ';
               lsql := lsql + ' :valorunitario,  ';
               lsql := lsql + ' :valortotal, ';
               lsql := lsql + ' :valorliquido, ';
               lsql := lsql + ' :nf_tipoicms, ';
               lsql := lsql + ' :baseicmsst,  ';
               lsql := lsql + ' :valoricms_st, ';
               lsql := lsql + ' :nf_iva_st, ';
               lsql := lsql + ' :iva_original, ';
               lsql := lsql + ' :baseicms_it,  ';
               lsql := lsql + ' :baseicms , ';
               lsql := lsql + ' :valoricms,';
               lsql := lsql + ' :porcicms, ';
               lsql := lsql + ' :nf_tipoipi,  ';
               lsql := lsql + ' :baseipi, ';
               lsql := lsql + ' :valoripi, ';
               lsql := lsql + ' :porcipi, ';
              lsql := lsql + ' :nf_tipopis,  ';
               lsql := lsql + ' :basepis, ';
               lsql := lsql + ' :valorpis ,  ';
               lsql := lsql + ' :porcpis, ';
               lsql := lsql + ' :nf_tipocofins, ';
               lsql := lsql + ' :basecofins,';
               lsql := lsql + ' :valorcofins, ';
               lsql := lsql + ' :porccofins,  ';
               lsql := lsql + ' :valorfrete , ';
               lsql := lsql + ' :vlroutrasdespesas, ';
               lsql := lsql + ' :vlrseguro,  ';
               lsql := lsql + ' :porcprovicmspartilha,  ';
               lsql := lsql + ' :vlrfcp ,  ';
               lsql := lsql + ' :vlricmsufdestino , ';
               lsql := lsql + ' :vlricmsufremetente ,  ';
               lsql := lsql + ' :aliqfcp, ';
               lsql := lsql + ' :difal, ';
               lsql := lsql + ' :porcdesconto, ';
               lsql := lsql + ' :valordesconto,  ';
               lsql := lsql + ' :porccredito, ';
               lsql := lsql + ' :vlrcredito ';
               lsql := lsql + '  )';

                qryaux.close;
                qryaux.sql.clear;
                qryaux.sql.add(lsql);

                //retornacodigoproduto(tpretorno.trCodCliente,prod.cprod,prod.ncm, prod.xprod);

                qryaux.parambyname('numnf').asinteger        := ide.nnf;
                qryaux.parambyname('cnpj_destinatario').asstring   := tpretorno.trCNPJDestinatario;
                qryaux.parambyname('cnpj_emitente').asstring := tpretorno.trCNPJEmitente;
                qryaux.parambyname('codproduto').asstring    := prod.cprod; //tpproduto.trcodprodinterno;
                qryaux.parambyname('desc_produto').asstring  := prod.xprod;
                qryaux.parambyname('unidadeitem').asstring   := prod.ucom; // verificaunidade( prod.ucom ) ;
                qryaux.parambyname('numitem').asinteger      := prod.nitem;
                qryaux.parambyname('codnatureza').asstring   := prod.cfop; //atualizanaturezaoperacao(prod.cfop, tpretorno.trCodCliente);
                qryaux.parambyname('i_cfop').asstring        := prod.cfop; //atualizanaturezaoperacao(prod.cfop, tpretorno.trCodCliente);
                //qryaux.parambyname('codgrupo').asstring      := tpproduto.trcodgrupo;
               // qryaux.parambyname('dataentrega').assqltimestamp  := datetimetosqltimestamp(ide.demi);
                qryaux.parambyname('qtde').asfloat           := prod.qcom;
                qryaux.parambyname('valorunitario').asfloat  := prod.vuncom;
                qryaux.parambyname('valortotal').asfloat     := prod.vprod;
                qryaux.parambyname('valorliquido').asfloat   := prod.vprod;

                with imposto do
                begin
                     with icms do
                     begin
                        if ((tpretorno.trregimeicms = '1') or (tpretorno.trregimeicms = '2'))  then
                          qryaux.parambyname('nf_tipoicms').asstring   := csosnicmstostr(csosn)
                        else  qryaux.parambyname('nf_tipoicms').asstring   := csticmstostr(cst);

                        qryaux.parambyname('baseicmsst').asfloat     := icms.vbcst;
                        qryaux.parambyname('valoricms_st').asfloat   := icms.vicmsst;
                        qryaux.parambyname('nf_iva_st').asfloat      := 0;
                        qryaux.parambyname('iva_original').asfloat   := icms.pmvast;
                        qryaux.parambyname('baseicms_it').asfloat    := icms.vbcst;

                        qryaux.parambyname('baseicms').asfloat       := icms.vbc;
                        qryaux.parambyname('valoricms').asfloat      := icms.vicms;
                        qryaux.parambyname('porcicms').asfloat       := icms.picms;
                     end;


                     if (ipi.vbc > 0) then
                     begin
                         with ipi do
                         begin
                            qryaux.parambyname('nf_tipoipi').asstring    := cstipitostr(cst);
                            qryaux.parambyname('baseipi').asfloat        := vbc;
                            qryaux.parambyname('valoripi').asfloat       := vipi;
                            qryaux.parambyname('porcipi').asfloat        := pipi;
                         end;
                     end
                     else
                     begin
                         with ipi do
                         begin
                            qryaux.parambyname('nf_tipoipi').asstring    := cstipitostr(cst);
                            qryaux.parambyname('baseipi').asfloat        := 0;
                            qryaux.parambyname('valoripi').asfloat       := 0;
                            qryaux.parambyname('porcipi').asfloat        := 0;
                         end;
                     end;


                     with pis do
                     begin
                        qryaux.parambyname('nf_tipopis').asstring       := cstpistostr(cst) ;
                        if (cst = pis01) or (cst = pis02) then
                         begin
                           qryaux.parambyname('basepis').asfloat        := pis.vbc;
                           qryaux.parambyname('valorpis').asfloat       := pis.vpis;
                           qryaux.parambyname('porcpis').asfloat        := pis.ppis;
                         end
                        else if cst = pis03 then
                         begin
                           qryaux.parambyname('basepis').asfloat        := pis.qbcprod;
                           qryaux.parambyname('valorpis').asfloat       := pis.vpis;
                           qryaux.parambyname('porcpis').asfloat        := pis.valiqprod;
                         end
                        else if cst = pis99 then
                         begin
                           qryaux.parambyname('basepis').asfloat        := pis.vbc;
                           qryaux.parambyname('valorpis').asfloat       := pis.vpis;
                           qryaux.parambyname('porcpis').asfloat        := pis.ppis;
                        end
                        else
                        begin
                           qryaux.parambyname('basepis').asfloat        := 0;
                           qryaux.parambyname('valorpis').asfloat       := 0;
                           qryaux.parambyname('porcpis').asfloat        := 0;
                        end;
                     end;

                     with cofins do
                     begin
                        qryaux.parambyname('nf_tipocofins').asstring    := cstcofinstostr(cst);
                        if (cst = cof01) or (cst = cof02)   then
                         begin
                          qryaux.parambyname('basecofins').asfloat     := cofins.vbc;
                          qryaux.parambyname('valorcofins').asfloat    := cofins.vcofins;
                          qryaux.parambyname('porccofins').asfloat     := cofins.pcofins;
                         end
                        else if cst = cof03 then
                         begin
                          qryaux.parambyname('basecofins').asfloat     := cofins.qbcprod;
                          qryaux.parambyname('valorcofins').asfloat    := cofins.vcofins;
                          qryaux.parambyname('porccofins').asfloat     := cofins.valiqprod;
                         end
                        else if cst = cof99 then
                         begin
                          qryaux.parambyname('basecofins').asfloat     := cofins.vbc;
                          qryaux.parambyname('valorcofins').asfloat    := cofins.vcofins;
                          qryaux.parambyname('porccofins').asfloat     := cofins.valiqprod;
                         end
                         else
                         begin
                          qryaux.parambyname('basecofins').asfloat     := 0;
                          qryaux.parambyname('valorcofins').asfloat    := 0;
                          qryaux.parambyname('porccofins').asfloat     := 0;
                         end;
                     end;


                     qryaux.parambyname('valorfrete').asfloat            := prod.vfrete;
                     qryaux.parambyname('vlroutrasdespesas').asfloat     := prod.voutro;
                     qryaux.parambyname('vlrseguro').asfloat             := prod.vseg;

                     with icmsufdest do
                     begin
                       qryaux.parambyname('porcprovicmspartilha').asfloat  := picmsinterpart;
                       qryaux.parambyname('vlrfcp').asfloat                := vfcpufdest;
                       qryaux.parambyname('vlricmsufdestino').asfloat      := vicmsufdest;
                       qryaux.parambyname('vlricmsufremetente').asfloat    := vicmsufremet;
                       qryaux.parambyname('aliqfcp').asfloat               := pfcpufdest;
                       qryaux.parambyname('difal').asfloat                 := picmsinter;
                     end;

                     qryaux.parambyname('porcdesconto').asfloat   := 0;
                     qryaux.parambyname('valordesconto').asfloat  := prod.vdesc;
                     qryaux.parambyname('porccredito').asfloat    := icms.pcredsn;
                     qryaux.parambyname('vlrcredito').asfloat     := icms.vcredicmssn;

                    // if (icms.pcredsn > 0) then
                    //   gravacreditosimplesnacional(tpretorno.trCodCliente, ide.demi,icms.pcredsn);


                end;

             end ;

             try


               qryaux.execsql;

             except

               on e:exception do
                 begin
   //               db_conect.getcomando(qryaux, frmimportarnfeentrada, false);
                   //gcambio.execrollback;

                   btnimportar.enabled  := false;
                   mens_menserro( pchar(larquivo) + #13#10 + 'falha ao incluir item nfe.' + e.message );
                   continue;
                 end;
             end;

           end;
           {
           if (tpRetorno.trCodPlanoContatil = '') or (tpRetorno.trCodCentroCusto = '') then
           begin
              if (bCancelar = False) then
              begin
                 Application.CreateForm(TfrmInfFinContab, frmInfFinContab);
                 Try

                   frmInfFinContab.Caption  :=   frmInfFinContab.Caption + ' Fornecedor: ' + tpRetorno.trCodFornecedor + ' Nota Fiscal Nr� ' +  IntToStr(Ide.nNF);
                    if (VarToStr(tpRetorno.trCodPlanoContatil) <> '')  then
                    begin
                       frmInfFinContab.ediPlanoContas.SetValue('CodConta = ' + QuotedStr(VarToStr(tpRetorno.trCodPlanoContatil)));
                       frmInfFinContab.ediPlanoContas.ReadOnly := True;
                    end;

                    if (VarToStr(tpRetorno.trCodCentroCusto ) <> '')  then
                    begin
                       frmInfFinContab.ediCentroCusto.SetValue('CodCenCusto = ' + QuotedStr(VarToStr(tpRetorno.trCodCentroCusto)));
                       frmInfFinContab.ediCentroCusto.ReadOnly := True;
                    end;

                    frmInfFInContab.ParametroTela.Inicializar;
                    frmInfFinContab.ParametroTela.pCodFornecedor := tpRetorno.trCodFornecedor;
                    frmInfFinContab.ParametroTela.pNumeroNF      := IntToStr(Ide.nNF);
                    frmInfFinContab.ParametroTela.pCodFilial     := pCodFilial;

                    frmInfFinContab.ShowModal;
                    if frmInfFinContab.Tag = 1 then
                    begin
                       tpRetorno.trCodPlanoContatil := VarToStr(frmInfFinContab.ediPlanoContas.bs_KeyValue);
                       tpRetorno.trCodCentroCusto   := VarToStr(frmInfFinContab.ediCentroCusto.bs_KeyValue);
                    end
                    else
                    begin
                       bCancelar := True;
                       GCambio.ExecRollBack;
                       Mens_MensInf('Nota Fiscal n�o foi importada');
                       Continue;
                    end;


                 Finally
                   FreeAndNil(frmInfFinContab);
                 End;
              end;
           end;
            }
            {
           bTemParcela := False;
           for D:=0 to Cobr.Dup.Count-1 do
           begin
             with Cobr.Dup.Items[D] do
             begin

               lSQL := 'Insert   NF_Entrada_Vencimentos (NumNF, CodFornecedor, CodFilial, Parcela, TParcela, ValParcela, Vencimento) ';
               lSQL := lSQL + ' Values (:NumNF, :CodFornecedor, :CodFilial, :Parcela, :TParcela, :ValParcela, :Vencimento)';
               qryAux.Close;
               qryAux.Sql.Clear;
               qryAux.SQL.Add(lSQL);
               qryAux.ParamByName('NumNF').asInteger            := Ide.nNF;
               qryAux.ParamByName('CodFornecedor').asString     := tpRetorno.trCodFornecedor;
               qryAux.ParamByName('CodFilial').asString         := pCodFilial;
               qryAux.ParamByName('Parcela').asString           := IntToStr(D+1);
               qryAux.ParamByName('TParcela').asString          := IntToStr(Cobr.Dup.Count);
               qryAux.ParamByName('ValParcela').asFloat         := vDup;
               qryAux.ParamByName('Vencimento').AsSQLTimeStamp  := DateTimeToSQLTimeStamp( Date_GetProDiaUtil(dVenc) );

               try
                 qryAux.ExecSQL;
                 bTemParcela := True;
               except
                 On E:Exception do
                   begin
                     GCambio.ExecRollBack;;
                     btnImportar.Enabled  := False;
                     Mens_MensErro(pChar(lArquivo) + #13#10 + 'Falha ao incluir Duplicata.' + E.Message );
                     Continue;
                   end;
               end;

             end;
           end;

           if bTemParcela  then
           begin
             try
               Application.CreateForm(TfrmInfEntradaCondPagto , frmInfEntradaCondPagto );
               frmInfEntradaCondPagto.ParametroTela.Inicializar;
               frmInfEntradaCondPagto.ParametroTela.pCodFornecedor := tpRetorno.trCodFornecedor;
               frmInfEntradaCondPagto.ParametroTela.pNumeroNF      := IntToStr(Ide.nNF);
               frmInfEntradaCondPagto.ParametroTela.pCodFilial     := pCodFilial;
               frmInfEntradaCondPagto.ediFornecedor.Text           := Emit.xNome;
               frmInfEntradaCondPagto.ediDataEmissao.Text          := DateToStr(Ide.dEmi);


               frmInfEntradaCondPagto.ShowModal;

               if frmInfEntradaCondPagto.Tag <> 1 then
               begin
                 GCambio.ExecRollBack;
                 btnImportar.Enabled  := False;
                 if Mens_MensConf ('Condi��o da Pagamento n�o Informada.' + #13#10 +
                                   'Esta Nota Fiscal n�o ser� importada.' + #13#10 +
                                   'Nota Fiscal Nr� ' +  IntToStr(Ide.nNF) + #13#10 +  #13#10 +
                                   'Deseja importar a pr�xima Nota Fiscal ? ' ) = mrOk Then
                   Continue
                 else Break;
               end;

             finally
                FreeAndNil(frmInfEntradaCondPagto);
             end;
           end;
                 }
           // Guardar Arquivo XML
           Mensagem(EmptyStr);
           try
             lSQL := 'insert into nfe_importada(numnfe,dataemissao,cnpj_origem,cnpj_destino, cnpj_emitente )';
             lSQL := lSQL + ' values( :numnfe,:dataemissao,:cnpjorigem,:cnpjdestino, :cnpj_emitente)';

             qryInsert.Close;
             qryInsert.SQL.Clear;
             qryInsert.SQL.Add( lSQL );

             qryInsert.ParamByName('numnfe').AsString      := IntToStr( Ide.nNF );
             qryInsert.ParamByName('dataemissao').AsSQLTimeStamp  := DateTimeToSQLTimeStamp(Ide.dEmi);
             qryInsert.ParamByName('cnpjorigem').AsString  := Emit.CNPJCPF;
             qryInsert.ParamByName('cnpjdestino').AsString := dest.CNPJCPF;
             qryInsert.ParamByName('cnpj_emitente').AsString      := tpRetorno.trCNPJEmitente;

         //    qryInsert.ParamByName('dataentrada').AsSQLTimeStamp  := DateTimeToSQLTimeStamp(date);
             //qryInsert.ParamByName('XML').AsString         := QuotedStr( ACBrNFe1.NotasFiscais.Items[0].XML );

           finally

             try
               qryInsert.ExecSQL;


                MoveFile(PWideChar( lArquivo ) , PWideChar( lArquivoImportado ) );
             //   DeleteFile(PWideChar( lArquivo ));


             except
               On E:Exception do
                 begin
                 // GCambio.ExecRollBack;

                   btnImportar.Enabled  := False;
                   Mens_MensErro( 'Falha ao incluir NFe.' + E.Message );

                 end;
             end;

           end;
           // Fim Guarda Arquivo XML

          //GCambio.ExecCommit;

          end;

        end;
        AguardandoProcesso(frmImportarNFeEntrada, False, 'Fim');
      finally
        tlNFe.Clear;
        Mens_MensInf( 'Importa��o de arquivos conclu�da.' );
      end;
  except
    on E:Exception do
      begin
        btnImportar.Enabled  := False;
        Mens_MensErro( 'Erro Desconhecido ao Importar arquivos.!' + #13 +
                        E.Message );
      end;

  end;
end;

procedure  TfrmImportarNFeEntrada.GravaCreditoSimplesNacional(pCodFornecedor  : String; DataEmissao : TDateTime; Percentual : Double);
Var
 qryAliqSimples : TFDQuery;
begin
  qryAliqSimples := TFDQuery.Create(Nil);
  Try
    qryAliqSimples.Connection :=  DB_Conect.SQLConnection;
    qryAliqSimples.Close;
    qryAliqSimples.SQL.Clear;
    qryAliqSimples.SQL.Add('Select Mes from CreditoSimplesFornecedor');
    qryAliqSimples.SQL.Add(' Where CodFornecedor = :CodFornecedor and Mes = :Mes');
    qryAliqSimples.ParamByName('CodFornecedor').AsString := pCodFornecedor;
    qryAliqSimples.ParamByName('Mes').AsDate             := FirstDayOfMonth(DataEmissao, true);
    qryAliqSimples.Open;
    if qryAliqSimples.IsEmpty then
    begin
       Try
          qryAliqSimples.Close;
          qryAliqSimples.SQL.Clear;
          qryAliqSimples.SQL.Add('Insert into CreditoSimplesFornecedor (CodFornecedor, Mes, CreditoPorc) values (:CodFornecedor, :Mes, :CreditoPorc)');
          qryAliqSimples.ParamByName('CodFornecedor').AsString := pCodFornecedor;
          qryAliqSimples.ParamByName('Mes').AsDate             := FirstDayOfMonth(DataEmissao, true);
          qryAliqSimples.ParamByName('CreditoPorc').AsFloat    := Percentual;
       Except
            On E:Exception do
           begin
             Screen.Cursor := crDefault;
           //  GCambio.ExecRollBack;
             btnImportar.Enabled  := False;
           end;
       End;

    end
    else
    begin
       Try
         qryAliqSimples.Close;
         qryAliqSimples.SQL.Clear;
         qryAliqSimples.SQL.Add('Update CreditoSimplesFornecedor Set CreditoPorc = :CreditoPorc ');
         qryAliqSimples.SQL.Add(' Where CodFornecedor = :CodFornecedor and Mes = :Mes');
         qryAliqSimples.ParamByName('CodFornecedor').AsString := pCodFornecedor;
         qryAliqSimples.ParamByName('Mes').AsDate             := FirstDayOfMonth(DataEmissao, true);
         qryAliqSimples.ParamByName('CreditoPorc').AsFloat    := Percentual;
       Except
            On E:Exception do
           begin
             Screen.Cursor := crDefault;
            // GCambio.ExecRollBack;
             btnImportar.Enabled  := False;
           end;
       End;
    end;

    Try
        qryAliqSimples.ExecSQL;
    Except
        On E:Exception do
           begin
             //GCambio.ExecRollBack;
             Screen.Cursor := crDefault;
             btnImportar.Enabled  := False;
             Mens_MensErro('Erro ao Gravar Credito Simples Nacional');
           end;
    End;

  Finally
     FreeAndNil(qryAliqSimples);
  End;
end;

procedure TfrmImportarNFeEntrada.btnLocalizarClick(Sender: TObject);
var
  lContinua    : boolean;
  sr           : TSearchRec;
  searchResult : integer;
  //lPath        : string;
  I,X          : Integer;
  loNode       : TcxTreeListNode;

begin
  try
    try
      AguardandoProcesso(frmImportarNFeEntrada, true, 'Leitura de XML - NFe');
      lblLocal.Caption := 'Local:';
      tlNFe.Clear;


      if Trim( lPathNfe ) <> '' then
        begin
          if not ForceDirectories( lPathNfe ) then
            begin
              lContinua := False;
              btnImportar.Enabled  := False;
              Mens_MensErro( 'Path NFe no cadastro ( ' +  EdtEmitente.Text + ' ). N�o existe.' );
            end
          else
            begin
              lContinua := True;
              if not ForceDirectories( IncludeTrailingPathDelimiter( lPathNfe ) ) then
                begin
                    lContinua := False;
                end;

                if not ForceDirectories( IncludeTrailingPathDelimiter( lPathImportados ) ) then
                begin
                    lContinua := False;
                end;

                if not ForceDirectories( IncludeTrailingPathDelimiter( lPathInvalidos ) ) then
                begin
                    lContinua := False;
                end;



              if not lContinua  then
                begin
                  btnImportar.Enabled  := False;
                  Mens_MensErro( 'Falha ao verificar Path NFe.' + #13 +
                                 IncludeTrailingPathDelimiter( lPathNfe ) );
                end;

            end
        end
      else
        begin
          lContinua := False;
          btnImportar.Enabled  := False;
          Mens_MensErro( 'Path NFe vazio no cadastro ( ' + EdtEmitente.Text + ' )' );
        end;

      if lContinua then
        begin

          lblLocal.Caption := 'Local: ' + lPathNfe;

          loNode := nil;
          tlNFe.Clear;
          I := 0;
          X := 0;
          searchResult := FindFirst( lPathNfe + '*.XML', faAnyFile, sr );
          while searchResult = 0 do
            begin

              if sr.Name[1] <> '.' then
                begin
                  loNode := tlNfe.Add;
                  loNode.Values[4] := sr.Name;
                end;

              ACBrNFe1.NotasFiscais.Clear;
              try
                ACBrNFe1.NotasFiscais.LoadFromFile( lPathNfe +  sr.Name );

                with ACBrNFe1.NotasFiscais.Items[0].NFe do
                  begin



                    qryAux.Close;
                    qryAux.SQL.Clear;
                    qryAux.SQL.Add(' SELECT numnfe FROM nfe_importada  ');
                    qryAux.SQL.Add(' WHERE numnfe  = :numnfe ');
                    qryAux.SQL.Add(' and dataemissao  = :dataemissao ');
                    qryAux.SQL.Add(' and cnpj_origem = :cnpj_origem ');
                    qryAux.SQL.Add(' and cnpj_destino = :cnpj_destino ');

                    qryAux.ParamByName('numnfe').AsString             := IntToStr( Ide.nNF );
                    qryAux.ParamByName('dataemissao').AsSQLTimeStamp  := DateTimeToSQLTimeStamp(Ide.dEmi);
                    qryAux.ParamByName('cnpj_origem').AsString        := Emit.CNPJCPF;
                    qryAux.ParamByName('cnpj_destino').AsString       := dest.CNPJCPF;
                    qryAux.Open;

                    loNode.Values[0] := Ide.nNF;
                    loNode.Values[1] := Ide.dEmi;
                    loNode.Values[2] := Emit.xNome;
                    loNode.Values[3] := dest.xNome;
                    loNode.Values[5] := 'Importar';

                    if procNFe.nProt = '' then
                    begin
                      loNode.Values[5] := 'Sem Protocolo';
                       MoveFile( PWideChar(  lPathNfe +  sr.Name ) , PWideChar( lPathImportados +  sr.Name ) );
                       ACBrNFe1.NotasFiscais.Clear;
                       searchResult := FindNext(sr);
                       Inc(X);
                       Continue;
                    end;

                    if not qryAux.IsEmpty then
                    begin
                       loNode.Values[5] := 'Existente';
                       MoveFile( PWideChar(  lPathNfe +  sr.Name ) , PWideChar( lPathImportados +  sr.Name ) );
                       ACBrNFe1.NotasFiscais.Clear;
                       searchResult := FindNext(sr);
                       Inc(X);
                       Continue;
                    end;

                    Inc(i);
                  end;
              except

                  loNode.Values[5] := 'Inv�lido';
                  MoveFile( PWideChar(  lPathNfe +  sr.Name ) , PWideChar( lPathInvalidos +  sr.Name ) );
                  ACBrNFe1.NotasFiscais.Clear;
                  searchResult := FindNext(sr);
                  Inc(X);

              end;

              searchResult := FindNext(sr);
            end;
          findClose(sr);

        end;

    finally
      btnImportar.Enabled  := tlNfe.Count > 0;
    end;
    AguardandoProcesso(frmImportarNFeEntrada, False);
  except
    on E:Exception do
      begin
        btnImportar.Enabled  := False;
        Mens_MensErro( 'Erro Desconhecido ao Localizar arquivos.!' + #13 +
                        E.Message );
      end;
  end;
  lblTotalReg.Visible := True;
  lblTotalReg.Caption := 'NFe � Importar.: ' + IntToStr(i);
  lblTotalImp.Visible := True;
  lblTotalImp.Caption := 'NFe Importado(s) Anteriormente.: ' + IntToStr(x);

end;

procedure TfrmImportarNFeEntrada.ButSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmImportarNFeEntrada.EdtEmitenteExit(Sender: TObject);
begin
  if ( Trim( EdtEmitente.Text ) <> '' ) and ( Trim( EdtEmitente.bs_KeyValue ) <> '' ) then
  begin

     qryEmitente.Close;
     qryEmitente.ParamByName( 'codfornecedor').AsInteger := EdtEmitente.bs_KeyValue;
     qryEmitente.Open;

     if qryEmitente.FieldByName( 'path_nfe' ).AsString <> '' then
     begin

       lPathNfe        := IncludeTrailingPathDelimiter( qryEmitente.FieldByName( 'path_nfe' ).AsString ) ;
       lPathImportados := IncludeTrailingPathDelimiter( qryEmitente.FieldByName( 'path_importado' ).AsString  );
       lPathInvalidos  := IncludeTrailingPathDelimiter( qryEmitente.FieldByName( 'path_invalido' ).AsString  );

       btnLocalizar.Enabled := True;
       btnLocalizar.SetFocus;
     end
     else
     begin
        Mens_MensErro( 'Cadastro de Filial - Campo Path NFE n�o informado.');
     end;
  end;
end;

procedure TfrmImportarNFeEntrada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Self := NIL;
end;

procedure TfrmImportarNFeEntrada.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True;
end;

procedure TfrmImportarNFeEntrada.FormShow(Sender: TObject);
begin
  InitForm;
end;

procedure TfrmImportarNFeEntrada.InitForm;
begin
  WindowState          := wsMaximized;
  lblLocal.Caption     := 'Local:';
  btnLocalizar.Enabled := False;
  btnImportar.Enabled  := False;;
  SetParametros( EdtEmitente, TipoFornecedorX);
  EdtEmitente.SetFocus;

end;

procedure TfrmImportarNFeEntrada.RetornaCodigoProduto(CodFornecedor,
  CodProdutoFornecedor, NCM, Descricao: String);
Var
  sSQLUpdate, sSQLInsert  : String;
  CodProduto : String;
  sqlGravaProdF : TFDQuery;
  bResultCodigo : String;
 begin

   sqlGravaProdF := TFDQuery.Create(Nil);
   Try
      sqlGravaProdF.Connection := DB_Conect.SQLConnection;
      bResultCodigo := '0';
      tpProduto.Inicializar;
      sqlGravaProdF.Close;
      sqlGravaProdF.SQL.Clear;
      sqlGravaProdF.SQL.Add('Select fp.codFornecedorProduto, fp.CodProdInterno , fp.CodProdutoFornecedor, pg.CodGrupo ');
      sqlGravaProdF.SQL.Add(' From Fornecedor_Produto fp ');
      sqlGravaProdF.SQL.Add(' left outer join Produto_Grupos pg on pg.CodProdInterno = fp.CodProdInterno  ');
      sqlGravaProdF.SQL.Add('Where fp.CodFornecedor = :CodFornecedor and  fp.CodProdutoFornecedor = :CodProdutoFornecedor ');
      sqlGravaProdF.SQL.Add(' and fp.NCM = :NCM  ');
      sqlGravaProdF.ParamByName('CodFornecedor').AsString          := CodFornecedor;
      sqlGravaProdF.ParamByName('CodProdutoFornecedor').AsString   := CodProdutoFornecedor;
      sqlGravaProdF.ParamByName('NCM').AsString                    := NCM;


      sqlGravaProdF.Open;

      Try
        if not sqlGravaProdF.IsEmpty then
        begin
           if not sqlGravaProdF.FieldByName('CodProdInterno').IsNull then
           begin
               tpProduto.trCodProdInterno :=  sqlGravaProdF.FieldByName('CodProdInterno').AsString;
               tpProduto.trCodGrupo       :=  sqlGravaProdF.FieldByName('CodGrupo').AsString;
           end
           else
           begin
              tpProduto.trCodProdInterno := sqlGravaProdF.FieldByName('CodProdutoFornecedor').AsString;
           end;
        end
        else
        begin
            sqlGravaProdF.Close;
            sqlGravaProdF.SQL.Clear;
            sqlGravaProdF.SQL.Add('Insert into Fornecedor_Produto ');
            sqlGravaProdF.SQL.Add('(CodFornecedor, CodProdutoFornecedor,NCM,DescProduto) Values ( ');
            sqlGravaProdF.SQL.Add(' :CodFornecedor, :CodProdutoFornecedor, :NCM, :DescProduto) ');
            sqlGravaProdF.ParamByName('CodFornecedor').AsString          := CodFornecedor;
            sqlGravaProdF.ParamByName('CodProdutoFornecedor').AsString   := CodProdutoFornecedor;
            sqlGravaProdF.ParamByName('NCM').AsString                    := NCM;
            sqlGravaProdF.ParamByName('DescProduto').AsString            := Descricao;

            Try

               sqlGravaProdF.ExecSQL;
            Except
               On E:Exception do
               begin


                 btnImportar.Enabled  := False;
                 Mens_MensErro( 'Falha ao Inserir Produto do Fornecedor.' + E.Message );
               end;
            End;
            tpProduto.trCodProdInterno := CodProdutoFornecedor;

        end;
      Except
        Mens_MensErro( 'Falha ao localizar Produto do Fornecedor.' );
      End;

   Finally
      FreeAndNil(sqlGravaProdF);
   End;

 end;

function TfrmImportarNFeEntrada.RetornaCodigoTransportadora(Indice : Integer;  CNPJ: String): String;
Var
 sSQLUpdate, sSQLInsert  : String;
 CodTransportadora : String;
begin
   if CNPJ = '' then
   begin
     result := '00001';
     Exit;
   end;

   QryAux.Close;
   QryAux.SQL.Text := 'Select Top 1 CodTransportadora From Transportadora Where CNPJ = ' + QuotedStr(Trim(TiraChars(CNPJ)));
   QryAux.Open;
   Try
     if not QryAux.IsEmpty then
     begin
        CodTransportadora := QryAux.FieldByName('CodTransportadora').AsString;
        // Transportadora sendo alterada para Cliente Retira!! incorretamente.

        {
        with ACBrNFe1.NotasFiscais.Items[Indice].NFe do
        begin

          sSQLUpdate := 'Update Transportadora ';
          sSQLUpdate := sSQLUpdate + ' Set Razao   = :Razao ';
          if Transp.Transporta.IE <> '' then
            sSQLUpdate := sSQLUpdate + ' ,Inscricao   = :Inscricao ';
          if Transp.Transporta.xEnder <> '' then
            sSQLUpdate := sSQLUpdate + ' ,Endereco    = :Endereco ';
          if Transp.Transporta.xMun <> '' then
            sSQLUpdate := sSQLUpdate + ' ,Cidade      = :Cidade ';
          if Transp.Transporta.UF <> '' then
            sSQLUpdate := sSQLUpdate + ' ,Estado      = :Estado ';

          sSQLUpdate := sSQLUpdate + ' Where CNPJ  = :CNPJ';

          QryAux.Close;
          QryAux.SQL.Clear;
          QryAux.SQL.Add(sSQLUpdate);


          QryAux.ParamByName('Razao').AsString          := Utf8ToAnsi(Copy(Transp.Transporta.xNome,1,45));
          if Transp.Transporta.IE <> '' then
            QryAux.ParamByName('Inscricao').AsString      := Transp.Transporta.IE;
          if Transp.Transporta.xEnder <> '' then
            QryAux.ParamByName('Endereco').AsString       := Copy(Transp.Transporta.xEnder,1,50);
          if Transp.Transporta.xMun <> '' then
            QryAux.ParamByName('Cidade').AsString         := Transp.Transporta.xMun;
          if Transp.Transporta.UF <> '' then
            QryAux.ParamByName('Estado').AsString         := Transp.Transporta.UF;

          QryAux.ParamByName('CNPJ').AsString             := CNPJ;
        end;

        try
          QryAux.ExecSQL;

        except
          On E:Exception do
            begin

              btnImportar.Enabled  := False;
              Mens_MensErro( 'Falha ao Alterar Transportadora.' + E.Message );
            end;
        end;
        }
     end
     else
     begin

        sSQLUpdate := 'INSERT INTO Transportadora (CodTransportadora, Razao, CNPJ, Inscricao, Endereco,';
        sSQLUpdate := sSQLUpdate + ' Cidade, Estado) Values (:CodTransportadora, :Razao, :CNPJ, :Inscricao, :Endereco, ';
        sSQLUpdate := sSQLUpdate + ' :Cidade, :Estado)';
        QryAux.Close;
        QryAux.SQL.Clear;
        QryAux.SQL.Add(sSQLUpdate);

        with ACBrNFe1.NotasFiscais.Items[n].NFe do
        begin
          CodTransportadora := NovoCodigoTransportadora;
          QryAux.ParamByName('CodTransportadora').AsString := CodTransportadora;
          QryAux.ParamByName('Razao').AsString          := Utf8ToAnsi(Copy(Transp.Transporta.xNome,1,45));
          QryAux.ParamByName('Inscricao').AsString      := Transp.Transporta.IE;
          QryAux.ParamByName('Endereco').AsString       := Copy(Transp.Transporta.xEnder,1,50);
          QryAux.ParamByName('Cidade').AsString         := Transp.Transporta.xMun;
          QryAux.ParamByName('Estado').AsString         := Transp.Transporta.UF;
          QryAux.ParamByName('CNPJ').AsString           := Transp.Transporta.CNPJCPF;
        end;

        try
          QryAux.ExecSQL;

        except
          On E:Exception do
            begin

              btnImportar.Enabled  := False;
              Mens_MensErro( 'Falha ao Incluir Transportadora.' + E.Message );
            end;
        end;


     end;
   Except
         Mens_MensErro( 'Falha ao Alterar Transportadora.' );
   End;

   result :=  CodTransportadora;

end;

procedure TfrmImportarNFeEntrada.RetornarCodigoCliente(cnpj: String );
Var
 sSQLUpdate, sSQLInsert  : String;
begin
   //tpRetorno.Inicializar;
   qryAux.Close;
   qryAux.SQL.Text := 'Select codcliente,  regimeicms From clientes Where cnpj = ' + QuotedStr(CNPJ);
   qryAux.Open;
   Try
     if not qryAux.IsEmpty then
     begin
        tpRetorno.trCodCliente       := qryAux.FieldByName('codcliente').AsInteger;
        tpRetorno.trRegimeICMS       := qryAux.FieldByName('regimeicms').AsString;
        tpRetorno.trCNPJDestinatario := cnpj;

   ssqlupdate :=
        'update clientes '
        +' set nome          = :nome '
        +',aliascliente      = :aliascliente '
        +',datainclusao      = :datainclusao '
        +',cep               = :cep '
        +',estado            = :estado '
        +',cidade            = :cidade '
        +',endereco          = :endereco '
        +',endnum            = :endnum '
        +',bairro            = :bairro '
        +',complemento       = :complemento '
    //    +',inscricao         = :inscricao '
        +',numero1           = :numero1'
  //      +',regimeicms        = :regimeicms'
        +' where cnpj        = :cnpj';

        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add(sSQLUpdate);

        with ACBrNFe1.NotasFiscais.Items[n].NFe do
        begin
          qryAux.ParamByName('Nome').AsString                 := Utf8ToAnsi(Copy(Dest.xNome,1,60));
          qryAux.ParamByName('aliascliente').AsString         := Utf8ToAnsi(Copy(Dest.xNome,1,25));
          qryAux.ParamByName('datainclusao').AsSQLTimeStamp   := DateTimeToSQLTimeStamp(Now);
          qryAux.ParamByName('cep').AsString                  := IntToStr(Dest.EnderDest.CEP);
          qryAux.ParamByName('estado').AsString               := Dest.EnderDest.UF;
          qryAux.ParamByName('cidade').AsString               := Dest.EnderDest.xMun;
          qryAux.ParamByName('endereco').AsString             := Dest.EnderDest.xLgr;
          qryAux.ParamByName('endnum').AsString               := Dest.EnderDest.nro;
          qryAux.ParamByName('bairro').AsString               := Dest.EnderDest.xBairro;
          qryAux.ParamByName('complemento').AsString          := Dest.EnderDest.xCpl;
   //       qryAux.ParamByName('inscricao').AsString            := Emit.IEST;;
          qryAux.ParamByName('numero1').AsString              := Dest.EnderDest.fone;
 //         qryAux.ParamByName('regimeicms').AsString           := CRTToStr(Emit.CRT);
          qryAux.ParamByName('cnpj').AsString                 := Dest.CNPJCPF;
        end;

        try
          qryAux.ExecSQL;

        except
          On E:Exception do
            begin
              btnImportar.Enabled  := False;
              Mens_MensErro( 'Falha ao Alterar Cliente.' + E.Message );
            end;
        end;

     end
     else
     begin
      //  tpRetorno.trCodFornecedor := dmBaseDocFiscal.LastCodigo('CodFornecedor', 'Fornecedores', '');


		  ssqlinsert :=
        'insert into clientes ('
       // +'codfilial '
        +'codfornecedor '
        +',nome    '
        +',aliascliente  '
        +',datainclusao '
        +',cep     '
        +',estado      '
        +',cidade  '
        +',endereco    '
        +',endnum '
        +',bairro  '
        +',complemento   '
        +',cnpj '
     //   +',inscricao  '
        +',numero1 '
     //   +',regimeicms '
        +') values (   '
       // +' :codfilial '
        +':codfornecedor '
        +',:nome    '
        +',:aliascliente  '
        +',:datainclusao  '
        +',:cep     '
        +',:estado      '
        +',:cidade  '
        +',:endereco    '
        +',:endnum '
        +',:bairro  '
        +',:complemento   '
        +',:cnpj '
     //   +',:inscricao  '
        +',:numero1 )';
       // +',:regimeicms ) ';


        qryaux.close;
        qryaux.sql.clear;
        qryaux.sql.add(ssqlinsert);
        with acbrnfe1.notasfiscais.items[n].nfe do
        begin
         // qryaux.parambyname('codfilial').AsInteger               := EdtFilial.bs_KeyValue;
          qryaux.parambyname('codfornecedor').AsInteger           := tpRetorno.trCodFornecedor;
          qryaux.parambyname('nome').asstring                     := utf8toansi(copy(Dest.xnome,1,45));
          qryaux.parambyname('aliascliente').asstring             := Utf8ToAnsi(Copy(Dest.xNome,1,25));
          qryaux.parambyname('datainclusao').assqltimestamp       := DateTimeToSQLTimeStamp(Now);
          qryaux.parambyname('cep').asstring                      := inttostr(Dest.EnderDest.cep);
          qryaux.parambyname('estado').asstring                   := Dest.EnderDest.uf;
          qryaux.parambyname('cidade').asstring                   := Dest.EnderDest.xmun;
          qryaux.parambyname('endereco').asstring                 := Dest.EnderDest.xlgr;
          qryaux.parambyname('endnum').asstring                   := Dest.EnderDest.nro;
          qryaux.parambyname('bairro').asstring                   := Dest.EnderDest.xbairro;
          qryaux.parambyname('complemento').asstring              := Dest.EnderDest.xcpl;
         // qryaux.parambyname('inscricao').asstring                := Dest.iest;;
          qryaux.parambyname('numero1').asstring                  := Dest.EnderDest.fone;
         // qryaux.parambyname('regimeicms').asstring               := crttostr(Dest.crt);
          qryaux.parambyname('cnpj').asstring                     := Dest.cnpjcpf;
        end;

        try
          qryAux.ExecSQL;

        except
          On E:Exception do
            begin

              btnImportar.Enabled  := False;
              Mens_MensErro( 'Falha ao incluir Cliente.' + E.Message );
            end;
        end;

        qryAux.Close;
        qryAux.SQL.Text := 'Select codcliente,  regimeicms From clientes Where cnpj = ' + QuotedStr(CNPJ);
        qryAux.Open;
        if not qryAux.IsEmpty then
        begin
          tpRetorno.trCodCliente       := qryAux.FieldByName('codcliente').AsInteger;
          tpRetorno.trRegimeICMS       := qryAux.FieldByName('regimeicms').AsString;
          tpRetorno.trCNPJDestinatario := cnpj;
        end;

     end;
   except
    on E:Exception do
       begin
         btnImportar.Enabled  := False;
	  		 Mens_MensInf('Falha do Importar o Cliente');
       end;
   End;

end;




procedure TfrmImportarNFeEntrada.RetornarCodigoFornecedor(CodFilial : Integer;  CNPJ: String);
Var
 sSQLUpdate, sSQLInsert  : String;
begin
   tpRetorno.Inicializar;
   qryAux.Close;
   qryAux.SQL.Text := 'Select codfornecedor From fornecedores Where cnpj = ' + QuotedStr(CNPJ);
   qryAux.Open;
   Try
     if not qryAux.IsEmpty then
     begin
        tpretorno.trcodfornecedor    := qryaux.fieldbyname('codfornecedor').AsInteger;
        tpRetorno.trCNPJEmitente     := CNPJ;
        ssqlupdate :=
        'update fornecedores '
        +' set nome          = :nome '
        +',aliasfornecedor   = :aliasfornecedor '
        +',cep               = :cep '
        +',estado            = :estado '
        +',cidade            = :cidade '
        +',endereco          = :endereco '
        +',endnum            = :endnum '
        +',bairro            = :bairro '
        +',complemento       = :complemento '
        +',inscricao         = :inscricao '
        +',telefone          = :telefone'
        +',regimeicms        = :regimeicms'
        +' where cnpj        = :cnpj';

        qryaux.close;
        qryaux.sql.clear;
        qryaux.sql.add(ssqlupdate);

        with acbrnfe1.notasfiscais.items[n].nfe do
        begin
          qryaux.parambyname('nome').asstring                 := utf8toansi(copy(emit.xnome,1,60));
          qryaux.parambyname('aliasfornecedor').asstring      := utf8toansi(copy(emit.xnome,1,25));
          qryaux.parambyname('cep').asstring                  := inttostr(emit.enderemit.cep);
          qryaux.parambyname('estado').asstring               := emit.enderemit.uf;
          qryaux.parambyname('cidade').asstring               := emit.enderemit.xmun;
          qryaux.parambyname('endereco').asstring             := emit.enderemit.xlgr;
          qryaux.parambyname('endnum').asstring               := emit.enderemit.nro;
          qryaux.parambyname('bairro').asstring               := emit.enderemit.xbairro;
          qryaux.parambyname('complemento').asstring          := emit.enderemit.xcpl;
          qryaux.parambyname('inscricao').asstring            := emit.iest;;
          qryaux.parambyname('telefone').asstring             := emit.enderemit.fone;
          qryaux.parambyname('regimeicms').asstring           := crttostr(emit.crt);
          qryaux.parambyname('cnpj').asstring                 := emit.cnpjcpf;
        end;

        try
          qryaux.execsql;

        except
          on e:exception do
            begin
              btnimportar.enabled  := false;
              mens_menserro( 'falha ao alterar fornecedor.' + e.message );
            end;
        end;

     end
     else
     begin

        ssqlinsert :=
        'insert into fornecedores ('
        +',nome '
        +',aliasfornecedor  '
        +',cep  '
        +',estado '
        +',cidade '
        +',endereco    '
        +',endnum '
        +',bairro '
        +',complemento   '
        +',cnpj '
        +',inscricao  '
        +',telefone '
        +',regimeicms '
        +') values (   '
        +' :nome    '
        +',:aliasfornecedor  '
        +',:cep     '
        +',:estado      '
        +',:cidade  '
        +',:endereco    '
        +',:endnum '
        +',:bairro  '
        +',:complemento   '
        +',:cnpj '
        +',:inscricao  '
        +',:telefone '
        +',:regimeicms ) ';


        qryaux.close;
        qryaux.sql.clear;
        qryaux.sql.add(ssqlinsert);
        with acbrnfe1.notasfiscais.items[n].nfe do
        begin
          qryaux.parambyname('nome').asstring                     := utf8toansi(copy(emit.xnome,1,45));
          qryaux.parambyname('aliasfornecedor').asstring          := utf8toansi(copy(emit.xfant,1,45));
          qryaux.parambyname('cep').asstring                      := inttostr(emit.enderemit.cep);
          qryaux.parambyname('estado').asstring                   := emit.enderemit.uf;
          qryaux.parambyname('cidade').asstring                   := emit.enderemit.xmun;
          qryaux.parambyname('endereco').asstring                 := emit.enderemit.xlgr;
          qryaux.parambyname('endnum').asstring                   := emit.enderemit.nro;
          qryaux.parambyname('bairro').asstring                   := emit.enderemit.xbairro;
          qryaux.parambyname('complemento').asstring              := emit.enderemit.xcpl;
          qryaux.parambyname('inscricao').asstring                := emit.iest;;
          qryaux.parambyname('telefone').asstring                 := emit.enderemit.fone;
          qryaux.parambyname('regimeicms').asstring               := crttostr(emit.crt);
          qryaux.parambyname('cnpj').asstring                     := emit.cnpjcpf;
        end;

        try
          qryaux.execsql;

        except
          On E:Exception do
            begin

              btnImportar.Enabled  := False;
              Mens_MensErro( 'Falha ao incluir Fornecedor.' + E.Message );
            end;
        end;
         qryAux.Close;
         qryAux.SQL.Text := 'Select codfornecedor From fornecedores Where cnpj = ' + QuotedStr(CNPJ);
         qryAux.Open;
         if not qryAux.IsEmpty then
         begin
          tpretorno.trcodfornecedor    := qryaux.fieldbyname('codfornecedor').AsInteger;
          tpRetorno.trCNPJEmitente     := CNPJ;
         end;

     end;
   except
    on E:Exception do
       begin
         btnImportar.Enabled  := False;
	  		 Mens_MensInf('Falha do Importar o Emitente da Nota Fiscal');
       end;
   End;


end;

function TfrmImportarNFeEntrada.VerificaUnidade(Unidade: String): String;
Var
  sqlCons : TFDQuery;
begin
  sqlCons := TFDQuery.Create(Nil);
  Try
    sqlCons.Connection := DB_Conect.SQLConnection;

    with sqlCons do begin
      SQL.Clear;
      SQL.Add('Select Top 1 CodMedida ');
      SQL.Add('From UnidadeMedida ');
      SQL.Add('Where ((CodMedida = ' + QuotedStr(Unidade) + ') or (UnidadeEntrada = '+ QuotedStr(Unidade) + ')) ');
      Open;
    end;

    Result := sqlCons.FieldByName('CodMedida').AsString;
    sqlCons.Close;

  Finally
     freeAndNil(sqlCons);
  End;
end;

function TfrmImportarNFeEntrada.NovoCodigoTransportadora: String;
Var
  sqlNovaT : TFDQuery;
  NovoCodigoTransportora : Integer;
begin
  sqlNovaT := TFDQuery.Create(Nil);
  Try
    sqlNovaT.Connection := DB_Conect.SQLConnection;

    with sqlNovaT do begin
      SQL.Clear;
      SQL.Add('select CodTransportadora from parametros');
      Open;
      NovoCodigoTransportora := FieldByName('CodTransportadora').Value + 1;
      Close;
      SQL.Clear;
      SQL.Add('update parametros set CodTransportadora = ' + IntToStr(NovoCodigoTransportora));
      ExecSQL;
    end;

    Result := IntToStr(NovoCodigoTransportora);

  Finally
     freeAndNil(sqlNovaT);
  End;
end;

{ TTipoRetorno }

procedure TTipoRetorno.Inicializar;
begin
   trCodCliente       := 0;
   trCodFornecedor    := 0;
   //trCodPlanoContatil := '';
   //trCodCentroCusto   := '';
   trRegimeICMS       := '';
end;

{ TTipoProduto }

procedure TTipoProduto.Inicializar;
begin
   trCodProdInterno := '';
   trCodGrupo := '';
end;

function TfrmImportarNFeEntrada.AtualizaNaturezaOperacao(CFOP, CodFornecedor : string) : String;
var
  sqlConfigNatureza: TFDQuery;
  sSQL : String;
begin
  sqlConfigNatureza := TFDQuery.Create(nil);
  try
    sqlConfigNatureza.Connection := DB_Conect.SQLConnection;
    sqlConfigNatureza.Close;
    sqlConfigNatureza.SQL.Clear;
    sqlConfigNatureza.SQL.Add('Select codcliente, cfop1, cfop2 From Natureza_Fornecedor with (nolock) ');
    sqlConfigNatureza.SQL.Add('Where  CFOP1      = :CFOP1   ');
    sqlConfigNatureza.SQL.Add('and CodFornecedor = :CodFornecedor  ');

    sqlConfigNatureza.ParamByName('CFOP1').AsString := CFOP;
    sqlConfigNatureza.ParamByName('CodFornecedor').AsString := CodFornecedor;
    sqlConfigNatureza.Open;
    if sqlConfigNatureza.IsEmpty then
    begin
      sqlConfigNatureza.Close;
      sqlConfigNatureza.SQL.Clear;
      sqlConfigNatureza.SQL.Add('Select Top 1 CFOP1, CodNatureza, CFOP2 From Natureza with (nolock) ');
      sqlConfigNatureza.SQL.Add('Where  CodNatureza         = :CFOP1   ');
      sqlConfigNatureza.ParamByName('CFOP1').AsString := CFOP;
      sqlConfigNatureza.Open;
    end;

    Result := sqlConfigNatureza.FieldByName('CFOP2').AsString;  // << ---- o certo � cfop2

  finally
    FreeAndNil(sqlConfigNatureza);
  end;
end;


end.



//procedure TForm1.btnImportarXMLClick(Sender: TObject);
//var
  i, j, k, n  : integer;
  Nota, Node, NodePai, NodeItem: TTreeNode;
  NFeRTXT: TNFeRTXT;
begin
  OpenDialog1.FileName  :=  '';
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Arquivos TXT (*.TXT)|*.TXT|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    //tenta TXT
    ACBrNFe1.NotasFiscais.Add;
    NFeRTXT := TNFeRTXT.Create(ACBrNFe1.NotasFiscais.Items[0].NFe);
    NFeRTXT.CarregarArquivo(OpenDialog1.FileName);
    if NFeRTXT.LerTxt then
       NFeRTXT.Free
    else
    begin
       NFeRTXT.Free;
       //tenta XML
       ACBrNFe1.NotasFiscais.Clear;
       try
          ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
       except
          ShowMessage('Arquivo NFe Inv�lido');
          exit;
       end;
    end;

    trvwNFe.Items.Clear;

    for n:=0 to ACBrNFe1.NotasFiscais.Count-1 do
    begin
    with ACBrNFe1.NotasFiscais.Items[n].NFe do
     begin

       Nota := trvwNFe.Items.Add(nil,infNFe.ID);
       trvwNFe.Items.AddChild(Nota,'ID= ' +infNFe.ID);
       Node := trvwNFe.Items.AddChild(Nota,'procNFe');

       trvwNFe.Items.AddChild(Node,'tpAmb= '     +TpAmbToStr(procNFe.tpAmb));
       trvwNFe.Items.AddChild(Node,'verAplic= '  +procNFe.verAplic);
       trvwNFe.Items.AddChild(Node,'chNFe= '     +procNFe.chNFe);
       trvwNFe.Items.AddChild(Node,'dhRecbto= '  +DateTimeToStr(procNFe.dhRecbto));
       trvwNFe.Items.AddChild(Node,'nProt= '     +procNFe.nProt);
       trvwNFe.Items.AddChild(Node,'digVal= '    +procNFe.digVal);
       trvwNFe.Items.AddChild(Node,'cStat= '     +IntToStr(procNFe.cStat));
       trvwNFe.Items.AddChild(Node,'xMotivo= '   +procNFe.xMotivo);

       Node := trvwNFe.Items.AddChild(Nota,'Ide');
       trvwNFe.Items.AddChild(Node,'cNF= '     +IntToStr(Ide.cNF));
       trvwNFe.Items.AddChild(Node,'natOp= '   +Ide.natOp );
       trvwNFe.Items.AddChild(Node,'indPag= '  +IndpagToStr(Ide.indPag));
       trvwNFe.Items.AddChild(Node,'modelo= '  +IntToStr(Ide.modelo));
       trvwNFe.Items.AddChild(Node,'serie= '   +IntToStr(Ide.serie));
       trvwNFe.Items.AddChild(Node,'nNF= '     +IntToStr(Ide.nNF));
       trvwNFe.Items.AddChild(Node,'dEmi= '    +DateToStr(Ide.dEmi));
       trvwNFe.Items.AddChild(Node,'dSaiEnt= ' +DateToStr(Ide.dSaiEnt));
       trvwNFe.Items.AddChild(Node,'hSaiEnt= ' +DateToStr(Ide.hSaiEnt));
       trvwNFe.Items.AddChild(Node,'tpNF= '    +tpNFToStr(Ide.tpNF));
       trvwNFe.Items.AddChild(Node,'finNFe= '  +FinNFeToStr(Ide.finNFe));
       trvwNFe.Items.AddChild(Node,'verProc= ' +Ide.verProc);
       trvwNFe.Items.AddChild(Node,'cUF= '     +IntToStr(Ide.cUF));
       trvwNFe.Items.AddChild(Node,'cMunFG= '  +IntToStr(Ide.cMunFG));
       trvwNFe.Items.AddChild(Node,'tpImp= '   +TpImpToStr(Ide.tpImp));
       trvwNFe.Items.AddChild(Node,'tpEmis= '  +TpEmisToStr(Ide.tpEmis));
       trvwNFe.Items.AddChild(Node,'cDV= '     +IntToStr(Ide.cDV));
       trvwNFe.Items.AddChild(Node,'tpAmb= '   +TpAmbToStr(Ide.tpAmb));
       trvwNFe.Items.AddChild(Node,'finNFe= '  +FinNFeToStr(Ide.finNFe));
       trvwNFe.Items.AddChild(Node,'procEmi= ' +procEmiToStr(Ide.procEmi));
       trvwNFe.Items.AddChild(Node,'verProc= ' +Ide.verProc);
       trvwNFe.Items.AddChild(Node,'dhCont= '  +DateTimeToStr(Ide.dhCont));
       trvwNFe.Items.AddChild(Node,'xJust= '   +Ide.xJust);

       for i:=0 to Ide.NFref.Count-1 do
        begin
          if Ide.NFref.Items[i].refNFe <> '' then
          begin
            Node := trvwNFe.Items.AddChild(Node,'NFRef'+IntToStrZero(i+1,3));
            trvwNFe.Items.AddChild(Node,'refNFe= ' +Ide.NFref.Items[i].refNFe);
            trvwNFe.Items.AddChild(Node,'cUF= '    +IntToStr(Ide.NFref.Items[i].RefNF.cUF));
            trvwNFe.Items.AddChild(Node,'AAMM= '   +Ide.NFref.Items[i].RefNF.AAMM);
            trvwNFe.Items.AddChild(Node,'CNPJ= '   +Ide.NFref.Items[i].RefNF.CNPJ);
            trvwNFe.Items.AddChild(Node,'modelo= ' +IntToStr(Ide.NFref.Items[i].RefNF.modelo));
            trvwNFe.Items.AddChild(Node,'serie= '  +IntToStr(Ide.NFref.Items[i].RefNF.serie));
            trvwNFe.Items.AddChild(Node,'nNF= '    +IntToStr(Ide.NFref.Items[i].RefNF.nNF));
          end;

          if Ide.NFref.Items[i].RefECF.nCOO <> '' then
          begin
            Node := trvwNFe.Items.AddChild(Node,'refECF'+IntToStrZero(i+1,3));
            trvwNFe.Items.AddChild(Node,'mod= '  +ECFModRefToStr(Ide.NFref.Items[i].RefECF.modelo));
            trvwNFe.Items.AddChild(Node,'nECF= ' +Ide.NFref.Items[i].RefECF.nECF);
            trvwNFe.Items.AddChild(Node,'nCOO= ' +Ide.NFref.Items[i].RefECF.nCOO);
          end;
        end;

       Node := trvwNFe.Items.AddChild(Nota,'Emit');
       trvwNFe.Items.AddChild(Node,'CNPJCPF= ' +Emit.CNPJCPF);
       trvwNFe.Items.AddChild(Node,'IE='       +Emit.IE);
       trvwNFe.Items.AddChild(Node,'xNome='    +Emit.xNome);
       trvwNFe.Items.AddChild(Node,'xFant='    +Emit.xFant );
       trvwNFe.Items.AddChild(Node,'IEST='     +Emit.IEST);
       trvwNFe.Items.AddChild(Node,'IM='       +Emit.IM);
       trvwNFe.Items.AddChild(Node,'CNAE='     +Emit.CNAE);
       trvwNFe.Items.AddChild(Node,'CRT='      +CRTToStr(Emit.CRT));

       Node := trvwNFe.Items.AddChild(Node,'EnderEmit');
       trvwNFe.Items.AddChild(Node,'Fone='    +Emit.EnderEmit.fone);
       trvwNFe.Items.AddChild(Node,'CEP='     +IntToStr(Emit.EnderEmit.CEP));
       trvwNFe.Items.AddChild(Node,'xLgr='    +Emit.EnderEmit.xLgr);
       trvwNFe.Items.AddChild(Node,'nro='     +Emit.EnderEmit.nro);
       trvwNFe.Items.AddChild(Node,'xCpl='    +Emit.EnderEmit.xCpl);
       trvwNFe.Items.AddChild(Node,'xBairro=' +Emit.EnderEmit.xBairro);
       trvwNFe.Items.AddChild(Node,'cMun='    +IntToStr(Emit.EnderEmit.cMun));
       trvwNFe.Items.AddChild(Node,'xMun='    +Emit.EnderEmit.xMun);
       trvwNFe.Items.AddChild(Node,'UF'       +Emit.EnderEmit.UF);
       trvwNFe.Items.AddChild(Node,'cPais='   +IntToStr(Emit.EnderEmit.cPais));
       trvwNFe.Items.AddChild(Node,'xPais='   +Emit.EnderEmit.xPais);

       if Avulsa.CNPJ  <> '' then
        begin
          Node := trvwNFe.Items.AddChild(Nota,'Avulsa');
          trvwNFe.Items.AddChild(Node,'CNPJ='    +Avulsa.CNPJ);
          trvwNFe.Items.AddChild(Node,'xOrgao='  +Avulsa.xOrgao);
          trvwNFe.Items.AddChild(Node,'matr='    +Avulsa.matr );
          trvwNFe.Items.AddChild(Node,'xAgente=' +Avulsa.xAgente);
          trvwNFe.Items.AddChild(Node,'fone='    +Avulsa.fone);
          trvwNFe.Items.AddChild(Node,'UF='      +Avulsa.UF);
          trvwNFe.Items.AddChild(Node,'nDAR='    +Avulsa.nDAR);
          trvwNFe.Items.AddChild(Node,'dEmi='    +DateToStr(Avulsa.dEmi));
          trvwNFe.Items.AddChild(Node,'vDAR='    +FloatToStr(Avulsa.vDAR));
          trvwNFe.Items.AddChild(Node,'repEmi='  +Avulsa.repEmi);
          trvwNFe.Items.AddChild(Node,'dPag='    +DateToStr(Avulsa.dPag));
        end;
       Node := trvwNFe.Items.AddChild(Nota,'Dest');
       trvwNFe.Items.AddChild(Node,'CNPJCPF= ' +Dest.CNPJCPF);
       trvwNFe.Items.AddChild(Node,'IE='       +Dest.IE);
       trvwNFe.Items.AddChild(Node,'ISUF='     +Dest.ISUF);
       trvwNFe.Items.AddChild(Node,'xNome='    +Dest.xNome);
       trvwNFe.Items.AddChild(Node,'email='    +Dest.Email);

       Node := trvwNFe.Items.AddChild(Node,'EnderDest');
       trvwNFe.Items.AddChild(Node,'Fone='    +Dest.EnderDest.Fone);
       trvwNFe.Items.AddChild(Node,'CEP='     +IntToStr(Dest.EnderDest.CEP));
       trvwNFe.Items.AddChild(Node,'xLgr='    +Dest.EnderDest.xLgr);
       trvwNFe.Items.AddChild(Node,'nro='     +Dest.EnderDest.nro);
       trvwNFe.Items.AddChild(Node,'xCpl='    +Dest.EnderDest.xCpl);
       trvwNFe.Items.AddChild(Node,'xBairro=' +Dest.EnderDest.xBairro);
       trvwNFe.Items.AddChild(Node,'cMun='    +IntToStr(Dest.EnderDest.cMun));
       trvwNFe.Items.AddChild(Node,'xMun='    +Dest.EnderDest.xMun);
       trvwNFe.Items.AddChild(Node,'UF='      +Dest.EnderDest.UF );
       trvwNFe.Items.AddChild(Node,'cPais='   +IntToStr(Dest.EnderDest.cPais));
       trvwNFe.Items.AddChild(Node,'xPais='   +Dest.EnderDest.xPais);

       {if Retirada.CNPJ <> '' then
        begin
          Node := trvwNFe.Items.AddChild(Nota,'Retirada');
          trvwNFe.Items.AddChild(Node,'CNPJ='    +Retirada.CNPJ);
          trvwNFe.Items.AddChild(Node,'xLgr='    +Retirada.xLgr);
          trvwNFe.Items.AddChild(Node,'nro='     +Retirada.nro);
          trvwNFe.Items.AddChild(Node,'xCpl='    +Retirada.xCpl);
          trvwNFe.Items.AddChild(Node,'xBairro=' +Retirada.xBairro);
          trvwNFe.Items.AddChild(Node,'cMun='    +IntToStr(Retirada.cMun));
          trvwNFe.Items.AddChild(Node,'xMun='    +Retirada.xMun);
          trvwNFe.Items.AddChild(Node,'UF='      +Retirada.UF);
        end;

       if Entrega.CNPJ <> '' then
        begin
          Node := trvwNFe.Items.AddChild(Nota,'Entrega');
          trvwNFe.Items.AddChild(Node,'CNPJ='    +Entrega.CNPJ);
          trvwNFe.Items.AddChild(Node,'xLgr='    +Entrega.xLgr);
          trvwNFe.Items.AddChild(Node,'nro='     +Entrega.nro);
          trvwNFe.Items.AddChild(Node,'xCpl='    +Entrega.xCpl);
          trvwNFe.Items.AddChild(Node,'xBairro=' +Entrega.xBairro);
          trvwNFe.Items.AddChild(Node,'cMun='    +IntToStr(Entrega.cMun));
          trvwNFe.Items.AddChild(Node,'xMun='    +Entrega.xMun);
          trvwNFe.Items.AddChild(Node,'UF='      +Entrega.UF);
        end;}

       for I := 0 to Det.Count-1 do
        begin
          with Det.Items[I] do
           begin
               NodeItem := trvwNFe.Items.AddChild(Nota,'Produto'+IntToStrZero(I+1,3));
               trvwNFe.Items.AddChild(NodeItem,'nItem='  +IntToStr(Prod.nItem) );
               trvwNFe.Items.AddChild(NodeItem,'cProd='  +Prod.cProd );
               trvwNFe.Items.AddChild(NodeItem,'cEAN='   +Prod.cEAN);
               trvwNFe.Items.AddChild(NodeItem,'xProd='  +Prod.xProd);
               trvwNFe.Items.AddChild(NodeItem,'NCM='    +Prod.NCM);
               trvwNFe.Items.AddChild(NodeItem,'EXTIPI=' +Prod.EXTIPI);
               //trvwNFe.Items.AddChild(NodeItem,'genero=' +IntToStr(Prod.genero));
               trvwNFe.Items.AddChild(NodeItem,'CFOP='   +Prod.CFOP);
               trvwNFe.Items.AddChild(NodeItem,'uCom='   +Prod.uCom);
               trvwNFe.Items.AddChild(NodeItem,'qCom='   +FloatToStr(Prod.qCom)) ;
               trvwNFe.Items.AddChild(NodeItem,'vUnCom=' +FloatToStr(Prod.vUnCom)) ;
               trvwNFe.Items.AddChild(NodeItem,'vProd='  +FloatToStr(Prod.vProd)) ;

               trvwNFe.Items.AddChild(NodeItem,'cEANTrib=' +Prod.cEANTrib);
               trvwNFe.Items.AddChild(NodeItem,'uTrib='    +Prod.uTrib);
               trvwNFe.Items.AddChild(NodeItem,'qTrib='    +FloatToStr(Prod.qTrib));
               trvwNFe.Items.AddChild(NodeItem,'vUnTrib='  +FloatToStr(Prod.vUnTrib)) ;

               trvwNFe.Items.AddChild(NodeItem,'vFrete='      +FloatToStr(Prod.vFrete)) ;
               trvwNFe.Items.AddChild(NodeItem,'vSeg='        +FloatToStr(Prod.vSeg)) ;
               trvwNFe.Items.AddChild(NodeItem,'vDesc='       +FloatToStr(Prod.vDesc)) ;
               trvwNFe.Items.AddChild(NodeItem,'vOutro='      +FloatToStr(Prod.vOutro)) ;
               trvwNFe.Items.AddChild(NodeItem,'indTot='      +indTotToStr(Prod.IndTot)) ;
               trvwNFe.Items.AddChild(NodeItem,'xPed='        +Prod.xPed) ;
               trvwNFe.Items.AddChild(NodeItem,'nItemPedido=' +Prod.nItemPed) ;

               trvwNFe.Items.AddChild(NodeItem,'infAdProd=' +infAdProd);


               with Imposto do
                begin
                   NodePai := trvwNFe.Items.AddChild(NodeItem,'Imposto');

                   if ISSQN.cSitTrib = ISSQNcSitTribVazio then
                   begin
                     Node := trvwNFe.Items.AddChild(NodePai,'ICMS');
                     with ICMS do
                      begin
                        trvwNFe.Items.AddChild(Node,'CST=' +CSTICMSToStr(CST));
                        trvwNFe.Items.AddChild(Node,'CSOSN=' +CSOSNIcmsToStr(CSOSN));
                        trvwNFe.Items.AddChild(Node,'orig='  +OrigToStr(ICMS.orig));
                        trvwNFe.Items.AddChild(Node,'modBC=' +modBCToStr(ICMS.modBC));
                        trvwNFe.Items.AddChild(Node,'pRedBC=' +FloatToStr(ICMS.pRedBC));
                        trvwNFe.Items.AddChild(Node,'vBC='   +FloatToStr(ICMS.vBC));
                        trvwNFe.Items.AddChild(Node,'pICMS=' +FloatToStr(ICMS.pICMS));
                        trvwNFe.Items.AddChild(Node,'vICMS=' +FloatToStr(ICMS.vICMS));
                        trvwNFe.Items.AddChild(Node,'modBCST='  +modBCSTToStr(ICMS.modBCST));
                        trvwNFe.Items.AddChild(Node,'pMVAST='   +FloatToStr(ICMS.pMVAST));
                        trvwNFe.Items.AddChild(Node,'pRedBCST=' +FloatToStr(ICMS.pRedBCST));
                        trvwNFe.Items.AddChild(Node,'vBCST='    +FloatToStr(ICMS.vBCST));
                        trvwNFe.Items.AddChild(Node,'pICMSST='  +FloatToStr(ICMS.pICMSST));
                        trvwNFe.Items.AddChild(Node,'vICMSST='  +FloatToStr(ICMS.vICMSST));
                        trvwNFe.Items.AddChild(Node,'vBCSTRet='   +FloatToStr(ICMS.vBCSTRet));
                        trvwNFe.Items.AddChild(Node,'vICMSSTRet=' +FloatToStr(ICMS.vICMSSTRet));
                        trvwNFe.Items.AddChild(Node,'pCredSN='   +FloatToStr(ICMS.pCredSN));
                        trvwNFe.Items.AddChild(Node,'vCredICMSSN='   +FloatToStr(ICMS.vCredICMSSN));
                      end;

                      Node := trvwNFe.Items.AddChild(NodePai,'ICMSUFDest');
                      with ICMSUFDest do
                      begin
                        trvwNFe.Items.AddChild(Node,'vBCUFDest='   +FloatToStr(vBCUFDest));
                        trvwNFe.Items.AddChild(Node,'pFCPUFDest='   +FloatToStr(pFCPUFDest));
                        trvwNFe.Items.AddChild(Node,'pICMSUFDest='   +FloatToStr(pICMSUFDest));
                        trvwNFe.Items.AddChild(Node,'pICMSInter='   +FloatToStr(pICMSInter));
                        trvwNFe.Items.AddChild(Node,'pICMSInterPart='   +FloatToStr(pICMSInterPart));
                        trvwNFe.Items.AddChild(Node,'vFCPUFDest='   +FloatToStr(vFCPUFDest));
                        trvwNFe.Items.AddChild(Node,'vICMSUFDest='   +FloatToStr(vICMSUFDest));
                        trvwNFe.Items.AddChild(Node,'vICMSUFRemet='   +FloatToStr(vICMSUFRemet));
                      end;
                   end
                   else
                   begin
                     Node := trvwNFe.Items.AddChild(NodePai,'ISSQN');
                     with ISSQN do
                      begin
                        trvwNFe.Items.AddChild(Node,'vBC='       +FloatToStr(vBC));
                        trvwNFe.Items.AddChild(Node,'vAliq='     +FloatToStr(vAliq));
                        trvwNFe.Items.AddChild(Node,'vISSQN='    +FloatToStr(vISSQN));
                        trvwNFe.Items.AddChild(Node,'cMunFG='    +IntToStr(cMunFG));
                        trvwNFe.Items.AddChild(Node,'cListServ=' +cListServ);
                      end;
                   end;

                   if (IPI.vBC > 0) then
                    begin
                      Node := trvwNFe.Items.AddChild(NodePai,'IPI');
                      with IPI do
                       begin
                         trvwNFe.Items.AddChild(Node,'CST='       +CSTIPIToStr(CST)) ;
                         trvwNFe.Items.AddChild(Node,'clEnq='    +clEnq);
                         trvwNFe.Items.AddChild(Node,'CNPJProd=' +CNPJProd);
                         trvwNFe.Items.AddChild(Node,'cSelo='    +cSelo);
                         trvwNFe.Items.AddChild(Node,'qSelo='    +IntToStr(qSelo));
                         trvwNFe.Items.AddChild(Node,'cEnq='     +cEnq);

                         trvwNFe.Items.AddChild(Node,'vBC='    +FloatToStr(vBC));
                         trvwNFe.Items.AddChild(Node,'qUnid='  +FloatToStr(qUnid));
                         trvwNFe.Items.AddChild(Node,'vUnid='  +FloatToStr(vUnid));
                         trvwNFe.Items.AddChild(Node,'pIPI='   +FloatToStr(pIPI));
                         trvwNFe.Items.AddChild(Node,'vIPI='   +FloatToStr(vIPI));
                       end;
                    end;

                   if (II.vBc > 0) then
                    begin
                      Node := trvwNFe.Items.AddChild(NodePai,'II');
                      with II do
                       begin
                         trvwNFe.Items.AddChild(Node,'vBc='      +FloatToStr(vBc));
                         trvwNFe.Items.AddChild(Node,'vDespAdu=' +FloatToStr(vDespAdu));
                         trvwNFe.Items.AddChild(Node,'vII='      +FloatToStr(vII));
                         trvwNFe.Items.AddChild(Node,'vIOF='     +FloatToStr(vIOF));
                       end;
                    end;

                   Node := trvwNFe.Items.AddChild(NodePai,'PIS');
                   with PIS do
                    begin
                      trvwNFe.Items.AddChild(Node,'CST=' +CSTPISToStr(CST));

                      if (CST = pis01) or (CST = pis02) then
                       begin
                         trvwNFe.Items.AddChild(Node,'vBC='  +FloatToStr(PIS.vBC));
                         trvwNFe.Items.AddChild(Node,'pPIS=' +FloatToStr(PIS.pPIS));
                         trvwNFe.Items.AddChild(Node,'vPIS=' +FloatToStr(PIS.vPIS));
                       end
                      else if CST = pis03 then
                       begin
                         trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(PIS.qBCProd));
                         trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(PIS.vAliqProd));
                         trvwNFe.Items.AddChild(Node,'vPIS='      +FloatToStr(PIS.vPIS));
                       end
                      else if CST = pis99 then
                       begin
                         trvwNFe.Items.AddChild(Node,'vBC='       +FloatToStr(PIS.vBC));
                         trvwNFe.Items.AddChild(Node,'pPIS='      +FloatToStr(PIS.pPIS));
                         trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(PIS.qBCProd));
                         trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(PIS.vAliqProd));
                         trvwNFe.Items.AddChild(Node,'vPIS='      +FloatToStr(PIS.vPIS));
                       end;
                    end;

                   if (PISST.vBc>0) then
                    begin
                      Node := trvwNFe.Items.AddChild(NodePai,'PISST');
                      with PISST do
                       begin
                         trvwNFe.Items.AddChild(Node,'vBc='       +FloatToStr(vBc));
                         trvwNFe.Items.AddChild(Node,'pPis='      +FloatToStr(pPis));
                         trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(qBCProd));
                         trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(vAliqProd));
                         trvwNFe.Items.AddChild(Node,'vPIS='      +FloatToStr(vPIS));
                       end;
                      end;

                   Node := trvwNFe.Items.AddChild(NodePai,'COFINS');
                   with COFINS do
                    begin
                      trvwNFe.Items.AddChild(Node,'CST=' +CSTCOFINSToStr(CST));

                      if (CST = cof01) or (CST = cof02)   then
                       begin
                         trvwNFe.Items.AddChild(Node,'vBC='     +FloatToStr(COFINS.vBC));
                         trvwNFe.Items.AddChild(Node,'pCOFINS=' +FloatToStr(COFINS.pCOFINS));
                         trvwNFe.Items.AddChild(Node,'vCOFINS=' +FloatToStr(COFINS.vCOFINS));
                       end
                      else if CST = cof03 then
                       begin
                         trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(COFINS.qBCProd));
                         trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(COFINS.vAliqProd));
                         trvwNFe.Items.AddChild(Node,'vCOFINS='   +FloatToStr(COFINS.vCOFINS));
                       end
                      else if CST = cof99 then
                       begin
                         trvwNFe.Items.AddChild(Node,'vBC='       +FloatToStr(COFINS.vBC));
                         trvwNFe.Items.AddChild(Node,'pCOFINS='   +FloatToStr(COFINS.pCOFINS));
                         trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(COFINS.qBCProd));
                         trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(COFINS.vAliqProd));
                         trvwNFe.Items.AddChild(Node,'vCOFINS='   +FloatToStr(COFINS.vCOFINS));
                       end;
                    end;

                   if (COFINSST.vBC > 0) then
                    begin
                      Node := trvwNFe.Items.AddChild(NodePai,'COFINSST');
                      with COFINSST do
                       begin
                         trvwNFe.Items.AddChild(Node,'vBC='       +FloatToStr(vBC));
                         trvwNFe.Items.AddChild(Node,'pCOFINS='   +FloatToStr(pCOFINS));
                         trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(qBCProd));
                         trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(vAliqProd));
                         trvwNFe.Items.AddChild(Node,'vCOFINS='   +FloatToStr(vCOFINS));
                       end;
                    end;
                end;
             end;
          end ;

       NodePai := trvwNFe.Items.AddChild(Nota,'Total');
       Node := trvwNFe.Items.AddChild(NodePai,'ICMSTot');
       trvwNFe.Items.AddChild(Node,'vBC='     +FloatToStr(Total.ICMSTot.vBC));
       trvwNFe.Items.AddChild(Node,'vICMS='   +FloatToStr(Total.ICMSTot.vICMS)) ;
       trvwNFe.Items.AddChild(Node,'vBCST='   +FloatToStr(Total.ICMSTot.vBCST)) ;
       trvwNFe.Items.AddChild(Node,'vST='     +FloatToStr(Total.ICMSTot.vST)) ;
       trvwNFe.Items.AddChild(Node,'vProd='   +FloatToStr(Total.ICMSTot.vProd)) ;
       trvwNFe.Items.AddChild(Node,'vFrete='  +FloatToStr(Total.ICMSTot.vFrete)) ;
       trvwNFe.Items.AddChild(Node,'vSeg='    +FloatToStr(Total.ICMSTot.vSeg)) ;
       trvwNFe.Items.AddChild(Node,'vDesc='   +FloatToStr(Total.ICMSTot.vDesc)) ;
       trvwNFe.Items.AddChild(Node,'vII='     +FloatToStr(Total.ICMSTot.vII)) ;
       trvwNFe.Items.AddChild(Node,'vIPI='    +FloatToStr(Total.ICMSTot.vIPI)) ;
       trvwNFe.Items.AddChild(Node,'vPIS='    +FloatToStr(Total.ICMSTot.vPIS)) ;
       trvwNFe.Items.AddChild(Node,'vCOFINS=' +FloatToStr(Total.ICMSTot.vCOFINS)) ;
       trvwNFe.Items.AddChild(Node,'vOutro='  +FloatToStr(Total.ICMSTot.vOutro)) ;
       trvwNFe.Items.AddChild(Node,'vNF='     +FloatToStr(Total.ICMSTot.vNF)) ;
       trvwNFe.Items.AddChild(Node,'vFCPUFDest='   +FloatToStr(Total.ICMSTot.vFCPUFDest)) ;
       trvwNFe.Items.AddChild(Node,'vICMSUFDest='  +FloatToStr(Total.ICMSTot.vICMSUFDest)) ;
       trvwNFe.Items.AddChild(Node,'vICMSUFRemet=' +FloatToStr(Total.ICMSTot.vICMSUFRemet)) ;

       if Total.ISSQNtot.vServ > 0 then
        begin
          Node := trvwNFe.Items.AddChild(NodePai,'ISSQNtot');
          trvwNFe.Items.AddChild(Node,'vServ='   +FloatToStr(Total.ISSQNtot.vServ)) ;
          trvwNFe.Items.AddChild(Node,'vBC='     +FloatToStr(Total.ISSQNTot.vBC)) ;
          trvwNFe.Items.Add1Child(Node,'vISS='    +FloatToStr(Total.ISSQNTot.vISS)) ;
          trvwNFe.Items.AddChild(Node,'vPIS='    +FloatToStr(Total.ISSQNTot.vPIS)) ;
          trvwNFe.Items.AddChild(Node,'vCOFINS=' +FloatToStr(Total.ISSQNTot.vCOFINS)) ;
        end;

       Node := trvwNFe.Items.AddChild(NodePai,'retTrib');
       trvwNFe.Items.AddChild(Node,'vRetPIS='   +FloatToStr(Total.retTrib.vRetPIS)) ;
       trvwNFe.Items.AddChild(Node,'vRetCOFINS='+FloatToStr(Total.retTrib.vRetCOFINS)) ;
       trvwNFe.Items.AddChild(Node,'vRetCSLL='  +FloatToStr(Total.retTrib.vRetCSLL)) ;
       trvwNFe.Items.AddChild(Node,'vBCIRRF='   +FloatToStr(Total.retTrib.vBCIRRF)) ;
       trvwNFe.Items.AddChild(Node,'vIRRF='     +FloatToStr(Total.retTrib.vIRRF)) ;
       trvwNFe.Items.AddChild(Node,'vBCRetPrev='+FloatToStr(Total.retTrib.vBCRetPrev)) ;
       trvwNFe.Items.AddChild(Node,'vRetPrev='  +FloatToStr(Total.retTrib.vRetPrev)) ;

       NodePai := trvwNFe.Items.AddChild(Nota,'Transp');
       Node := trvwNFe.Items.AddChild(NodePai,'Transporta');
       trvwNFe.Items.AddChild(Node,'modFrete=' +modFreteToStr(Transp.modFrete));
       trvwNFe.Items.AddChild(Node,'CNPJCPF='  +Transp.Transporta.CNPJCPF);
       trvwNFe.Items.AddChild(Node,'xNome='    +Transp.Transporta.xNome);
       trvwNFe.Items.AddChild(Node,'IE='       +Transp.Transporta.IE);
       trvwNFe.Items.AddChild(Node,'xEnder='   +Transp.Transporta.xEnder);
       trvwNFe.Items.AddChild(Node,'xMun='     +Transp.Transporta.xMun);
       trvwNFe.Items.AddChild(Node,'UF='       +Transp.Transporta.UF);

       Node := trvwNFe.Items.AddChild(NodePai,'retTransp');
       trvwNFe.Items.AddChild(Node,'vServ='    +FloatToStr(Transp.retTransp.vServ)) ;
       trvwNFe.Items.AddChild(Node,'vBCRet='   +FloatToStr(Transp.retTransp.vBCRet)) ;
       trvwNFe.Items.AddChild(Node,'pICMSRet=' +FloatToStr(Transp.retTransp.pICMSRet)) ;
       trvwNFe.Items.AddChild(Node,'vICMSRet=' +FloatToStr(Transp.retTransp.vICMSRet)) ;
       trvwNFe.Items.AddChild(Node,'CFOP='     +Transp.retTransp.CFOP);
       trvwNFe.Items.AddChild(Node,'cMunFG='   +FloatToStr(Transp.retTransp.cMunFG));

       Node := trvwNFe.Items.AddChild(NodePai,'veicTransp');
       trvwNFe.Items.AddChild(Node,'placa='  +Transp.veicTransp.placa);
       trvwNFe.Items.AddChild(Node,'UF='     +Transp.veicTransp.UF);
       trvwNFe.Items.AddChild(Node,'RNTC='   +Transp.veicTransp.RNTC);

       for I:=0 to Transp.Reboque.Count-1 do
        begin
          Node := trvwNFe.Items.AddChild(NodePai,'Reboque'+IntToStrZero(I+1,3));
          with Transp.Reboque.Items[I] do
           begin
             trvwNFe.Items.AddChild(Node,'placa=' +placa) ;
             trvwNFe.Items.AddChild(Node,'UF='    +UF) ;
             trvwNFe.Items.AddChild(Node,'RNTC='  +RNTC) ;
           end;
        end;

       for I:=0 to Transp.Vol.Count-1 do
        begin
          Node := trvwNFe.Items.AddChild(NodePai,'Volume'+IntToStrZero(I+1,3));
          with Transp.Vol.Items[I] do
           begin
             trvwNFe.Items.AddChild(Node,'qVol='  +IntToStr(qVol)) ;
             trvwNFe.Items.AddChild(Node,'esp='   +esp);
             trvwNFe.Items.AddChild(Node,'marca=' +marca);
             trvwNFe.Items.AddChild(Node,'nVol='  +nVol);
             trvwNFe.Items.AddChild(Node,'pesoL=' +FloatToStr(pesoL)) ;
             trvwNFe.Items.AddChild(Node,'pesoB'  +FloatToStr(pesoB)) ;

             for J:=0 to Lacres.Count-1 do
              begin
                Node := trvwNFe.Items.AddChild(Node,'Lacre'+IntToStrZero(I+1,3)+IntToStrZero(J+1,3) );
                trvwNFe.Items.AddChild(Node,'nLacre='+Lacres.Items[J].nLacre) ;
              end;
           end;
        end;

       NodePai := trvwNFe.Items.AddChild(Nota,'Cobr');
       Node    := trvwNFe.Items.AddChild(NodePai,'Fat');
       trvwNFe.Items.AddChild(Node,'nFat='  +Cobr.Fat.nFat);
       trvwNFe.Items.AddChild(Node,'vOrig=' +FloatToStr(Cobr.Fat.vOrig)) ;
       trvwNFe.Items.AddChild(Node,'vDesc=' +FloatToStr(Cobr.Fat.vDesc)) ;
       trvwNFe.Items.AddChild(Node,'vLiq='  +FloatToStr(Cobr.Fat.vLiq)) ;

       for I:=0 to Cobr.Dup.Count-1 do
        begin
          Node    := trvwNFe.Items.AddChild(NodePai,'Duplicata'+IntToStrZero(I+1,3));
          with Cobr.Dup.Items[I] do
           begin
             trvwNFe.Items.AddChild(Node,'nDup='  +nDup) ;
             trvwNFe.Items.AddChild(Node,'dVenc=' +DateToStr(dVenc));
             trvwNFe.Items.AddChild(Node,'vDup='  +FloatToStr(vDup)) ;
           end;
        end;

       NodePai := trvwNFe.Items.AddChild(Nota,'InfAdic');
       trvwNFe.Items.AddChild(NodePai,'infCpl='     +InfAdic.infCpl);
       trvwNFe.Items.AddChild(NodePai,'infAdFisco=' +InfAdic.infAdFisco);

       for I:=0 to InfAdic.obsCont.Count-1 do
        begin
          Node := trvwNFe.Items.AddChild(NodePai,'obsCont'+IntToStrZero(I+1,3));
          with InfAdic.obsCont.Items[I] do
           begin
             trvwNFe.Items.AddChild(Node,'xCampo=' +xCampo) ;
             trvwNFe.Items.AddChild(Node,'xTexto=' +xTexto);
           end;
        end;

         for I:=0 to InfAdic.obsFisco.Count-1 do
          begin
            Node := trvwNFe.Items.AddChild(NodePai,'obsFisco'+IntToStrZero(I+1,3));
            with InfAdic.obsFisco.Items[I] do
             begin
                trvwNFe.Items.AddChild(Node,'xCampo=' +xCampo) ;
                trvwNFe.Items.AddChild(Node,'xTexto=' +xTexto);
             end;
          end;

         for I:=0 to InfAdic.procRef.Count-1 do
          begin
            Node := trvwNFe.Items.AddChild(NodePai,'procRef'+IntToStrZero(I+1,3));
            with InfAdic.procRef.Items[I] do
             begin
               trvwNFe.Items.AddChild(Node,'nProc='   +nProc) ;
               trvwNFe.Items.AddChild(Node,'indProc=' +indProcToStr(indProc));
             end;
          end;

         if (exporta.UFembarq <> '') then
          begin
            Node := trvwNFe.Items.AddChild(Nota,'exporta');
            trvwNFe.Items.AddChild(Node,'UFembarq='   +exporta.UFembarq) ;
            trvwNFe.Items.AddChild(Node,'xLocEmbarq=' +exporta.xLocEmbarq);
          end;

         if (compra.xNEmp <> '') then
          begin
            Node := trvwNFe.Items.AddChild(Nota,'compra');
            trvwNFe.Items.AddChild(Node,'xNEmp=' +compra.xNEmp) ;
            trvwNFe.Items.AddChild(Node,'xPed='  +compra.xPed);
            trvwNFe.Items.AddChild(Node,'xCont=' +compra.xCont);
          end;
     end;
       pgRespostas.ActivePageIndex := 3;
     end;

  end;
end;



