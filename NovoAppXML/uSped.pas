unit uSped;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, Vcl.Menus, cxButtons, cxTextEdit, cxMaskEdit,
  cxButtonEdit, cxLabel, dxGDIPlusClasses,dxSpreadSheet,dxSpreadSheetTypes,
  cxGroupBox, Vcl.Mask, rsEdit, Vcl.ImgList, Vcl.FileCtrl, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, dxSkinscxPCPainter,
  dxBarBuiltInMenu, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxPC,
  cxCheckBox, cxGridExportLink, System.Math, cxCustomPivotGrid, cxDBPivotGrid,
  Vcl.ComCtrls, SetParametro, EditBusca, cxSplitter;

type
   TApuracao = record
   REGISTRO      : String;
   CST           : String;
   CNPJ          : String;
   PERIODO       : String;
   VALOR_BASE    : Extended;
   PIS_PORC      : Extended;
   VALOR_PIS     : Extended;
   COFINS_PORC   : Extended;
   VALOR_COFINS  : Extended;
   procedure LimpaRecord;
end;

type
  TfrmSped = class(TForm)
    OpenDialog: TOpenDialog;
    ImageList1: TImageList;
    sqlPath: TFDQuery;
    sqlPathARQ_PARAMETRO_ID: TFDAutoIncField;
    sqlPathCAMINHO_SAV_SPED: TStringField;
    Panel3: TPanel;
    ButImportar: TcxButton;
    ButSair: TcxButton;
    Page: TcxPageControl;
    TabProcessar: TcxTabSheet;
    TabApurar: TcxTabSheet;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxButtonEditPath: TcxButtonEdit;
    cxLabel4: TcxLabel;
    cxButtonEditPathExcel: TcxButtonEdit;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    Panel1: TPanel;
    cxGroupBox3: TcxGroupBox;
    Label1: TLabel;
    editSalvarSped: TrsSuperEdit;
    btnSelecionaPath: TcxButton;
    cxGroupBox2: TcxGroupBox;
    editInicio: TLabeledEdit;
    editFim: TLabeledEdit;
    Panel2: TPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    Panel4: TPanel;
    sqlPeriodo: TFDQuery;
    dsPeriodo: TDataSource;
    Panel5: TPanel;
    sqlApuracao: TFDQuery;
    dsApuracao: TDataSource;
    sqlPeriodoCNPJ: TStringField;
    sqlPeriodoPERIODO: TStringField;
    cxGrid1DBTableView1CNPJ: TcxGridDBColumn;
    sqlLog: TFDQuery;
    chkSemLoad: TcxCheckBox;
    TabFaltaProduto: TcxTabSheet;
    Panel6: TPanel;
    cxGrid3: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    sqlfalta: TFDQuery;
    dsfalta: TDataSource;
    sqlfaltaARQ_C180: TFDAutoIncField;
    sqlfaltaCNPJ_SPED: TStringField;
    sqlfaltaFILIAL: TStringField;
    sqlfaltaPERIODO: TStringField;
    sqlfaltaREG: TStringField;
    sqlfaltaCOD_MOD: TStringField;
    sqlfaltaDT_DOC_INI: TStringField;
    sqlfaltaDT_DOC_FIN: TStringField;
    sqlfaltaCOD_ITEM: TStringField;
    sqlfaltaCOD_NCM: TStringField;
    sqlfaltaEX_IPI: TStringField;
    sqlfaltaVL_TOT_ITEM: TBCDField;
    sqlfaltaARQ_C180_ITENS_ID: TFDAutoIncField;
    sqlfaltaARQ_C180_1: TIntegerField;
    sqlfaltaREG_1: TStringField;
    sqlfaltaCST: TStringField;
    sqlfaltaCFOP: TStringField;
    sqlfaltaVL_ITEM: TBCDField;
    sqlfaltaVL_DESC: TBCDField;
    sqlfaltaVL_BC: TBCDField;
    sqlfaltaALIQ: TBCDField;
    sqlfaltaQUANT_BC: TBCDField;
    sqlfaltaALIQ_QUANT: TBCDField;
    sqlfaltaVL: TBCDField;
    sqlfaltaCOD_CT: TStringField;
    sqlfaltaPERCENTUAL: TBCDField;
    cxGridDBTableView1CNPJ_SPED: TcxGridDBColumn;
    cxGridDBTableView1FILIAL: TcxGridDBColumn;
    cxGridDBTableView1PERIODO: TcxGridDBColumn;
    cxGridDBTableView1REG: TcxGridDBColumn;
    cxGridDBTableView1COD_MOD: TcxGridDBColumn;
    cxGridDBTableView1DT_DOC_INI: TcxGridDBColumn;
    cxGridDBTableView1DT_DOC_FIN: TcxGridDBColumn;
    cxGridDBTableView1COD_ITEM: TcxGridDBColumn;
    cxGridDBTableView1COD_NCM: TcxGridDBColumn;
    cxGridDBTableView1EX_IPI: TcxGridDBColumn;
    cxGridDBTableView1VL_TOT_ITEM: TcxGridDBColumn;
    cxGridDBTableView1ARQ_C180_ITENS_ID: TcxGridDBColumn;
    cxGridDBTableView1REG_1: TcxGridDBColumn;
    cxGridDBTableView1CST: TcxGridDBColumn;
    cxGridDBTableView1CFOP: TcxGridDBColumn;
    cxGridDBTableView1VL_ITEM: TcxGridDBColumn;
    cxGridDBTableView1VL_DESC: TcxGridDBColumn;
    cxGridDBTableView1VL_BC: TcxGridDBColumn;
    cxGridDBTableView1ALIQ: TcxGridDBColumn;
    cxGridDBTableView1QUANT_BC: TcxGridDBColumn;
    cxGridDBTableView1ALIQ_QUANT: TcxGridDBColumn;
    cxGridDBTableView1VL: TcxGridDBColumn;
    cxGridDBTableView1COD_CT: TcxGridDBColumn;
    cxButton3: TcxButton;
    SaveDialog: TSaveDialog;
    sqlPeriodoMES: TWideStringField;
    sqlPeriodoANO: TIntegerField;
    cxGrid1DBTableView1MES: TcxGridDBColumn;
    cxGrid1DBTableView1ANO: TcxGridDBColumn;
    lblTituloFaltaProduto: TLabel;
    Button1: TButton;
    sqlApuracaoREGISTRO: TStringField;
    sqlApuracaoCST: TStringField;
    sqlApuracaoPERIODO: TStringField;
    sqlApuracaoVALOR_BASE: TFMTBCDField;
    sqlApuracaoPIS_PORC: TBCDField;
    sqlApuracaoVALOR_PIS: TFMTBCDField;
    sqlApuracaoCOFINS_PORC: TBCDField;
    sqlApuracaoVALOR_COFINS: TFMTBCDField;
    sqlApuracaoGRUPO: TStringField;
    sqlApuracaoDESCRICAO: TStringField;
    tabSpedContabil: TcxTabSheet;
    btnProcessar: TButton;
    btnGerarSpedCtb: TButton;
    Panel7: TPanel;
    Image1: TImage;
    cxLabel2: TcxLabel;
    StatusBar1: TStatusBar;
    Panel8: TPanel;
    Panel9: TPanel;
    cxDBPivotGrid: TcxDBPivotGrid;
    cxDBPivotGrid1Field1: TcxDBPivotGridField;
    cxDBPivotGrid1Field2: TcxDBPivotGridField;
    cxDBPivotGrid1Field3: TcxDBPivotGridField;
    cxDBPivotGrid1Field4: TcxDBPivotGridField;
    cxDBPivotGrid1Field5: TcxDBPivotGridField;
    cxDBPivotGrid1Field6: TcxDBPivotGridField;
    cxDBPivotGrid1Valor_PIS: TcxDBPivotGridField;
    cxDBPivotGrid1Field8: TcxDBPivotGridField;
    cxDBPivotGrid1Valor_COFINS: TcxDBPivotGridField;
    Label2: TLabel;
    mskPis: TcxMaskEdit;
    mskCofins: TcxMaskEdit;
    Label3: TLabel;
    mskPisOriginal: TcxMaskEdit;
    mskCofinsOriginal: TcxMaskEdit;
    Label4: TLabel;
    mskPisDif: TcxMaskEdit;
    mskCofinsDif: TcxMaskEdit;
    Label5: TLabel;
    editBuscaApuracao: TEditBusca;
    cxSplitter1: TcxSplitter;
    cxGroupBox4: TcxGroupBox;
    chckCta005: TcxCheckBox;
    spbLimpaApuracao: TcxButton;
    editLinhaExcel: TLabeledEdit;
    procedure cxButtonEditPathClick(Sender: TObject);
    procedure cxButtonEditPathExcelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSelecionaPathClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButImportarClick(Sender: TObject);
    procedure ButSairClick(Sender: TObject);
    procedure VerApuracaoFilialClick(Sender: TObject);
    procedure chkSemLoadClick(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnProcessarClick(Sender: TObject);
    procedure btnGerarSpedCtbClick(Sender: TObject);
    procedure editBuscaApuracaoClick(Sender: TObject);
    procedure spbLimpaApuracaoClick(Sender: TObject);
  private
    Apuracao : TApuracao;
    varUsuarioLogado : String;
    varPeriodo : String;
    varCNPJSPED : String;
    varArquivo : String;

    sqlDebito ,sqlEstorno ,sqlCredito , sqlSpedOriginal: TFDQuery;

    procedure Mensagem(pMensagem, pTela: String);
    procedure ImportarSPED;
    procedure GravaErro(Periodo, Linha : String);
    function DoMergeDatas : Boolean;
    procedure Import_Excel(CNPJ_SPED : String);
    procedure GerarNovoSPED(CNPJ_SPED : String);
    function StrTran(sOrigem, sLoc, sSub: string): string;
    procedure SalvarPath(Caminho : String);
    function RecuperarPath : String;
    procedure AbrirApuracao(CNPJ, Periodo, Tipo: String);
    procedure GravaLog;
    procedure ComparaArquivos(varSPED_ANT, varSPED_NOVO: String);
    procedure Salvar_Apuracao(Linha : String);
    function IsNumeric(const S: String): Boolean;
    procedure doSaveLogImport(lPath, Msg: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSped: TfrmSped;

implementation

{$R *.dfm}

uses DBConect;


procedure TfrmSped.Mensagem(pMensagem, pTela: String);
begin

  if  pTela = '0' then
  begin
    cxLabelMensagem.Caption := pMensagem;
    PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  end
  else
  begin
    cxLabel2.Caption := pMensagem;
    Panel7.Visible := not pMensagem.IsEmpty;
  end;
  Update;
  Application.ProcessMessages;

end;

function TfrmSped.RecuperarPath: String;
var
 varPath : String;
begin
  sqlPath.Close;
  sqlPath.SQL.Clear;
  sqlPath.SQL.Add('SELECT * FROM ARQ_PARAMETRO');
  sqlPath.Open;
  varPath := sqlPathCAMINHO_SAV_SPED.AsString;
  sqlPath.Close;
  Result := varPath;
end;

procedure TfrmSped.doSaveLogImport(lPath,  Msg: String);
Var
 loLista : TStringList;
 varDataHora : String;
 varArquivo  : String;
begin
 varDataHora := FormatDateTime('ddmmyyyy',Now);
 varArquivo  := '\log_' +  varDataHora  + '.log';
 try
   loLista := TStringList.Create;
   try
   if FileExists(lPath + varArquivo) Then
     loLista.LoadFromFile(lPath + varArquivo);

     loLista.Add(timetostr(now) + ':' + Msg);
   except
    on e: exception do
      loLista.add(timetostr(now) + ': Erro ' + E.Message);
   end;
 Finally
    loLista.SaveToFile(lPath + varArquivo);
    loLista.Free;
 end;

end;


procedure TfrmSped.btnGerarSpedCtbClick(Sender: TObject);
Var
 varNovoArquivo : TStringList;
 varLinha, varNovaLinha       : String;
 varDtInicial, varDtFinal: String;
 varI155       : Array [0..8] of String;
 varI200       : Array [0..4] of String;
 varI250       : Array [0..8] of String;
 var9990155    : Array [0..2] of String;
 var9990355    : Array [0..2] of String;
 varI990       : Array [0..1] of String;
 X, J, T, I, S, W, Z, varConta155, varConta355, varContaI990, TotRegistro : Integer;
begin
  varNovoArquivo := TStringList.Create;
  Try
   with DB_Conect do
   begin
       sqlAux.Close;
       sqlAux.SQL.Clear;
       sqlAux.SQL.Add('SELECT DISTINCT DT_INICIAL, DT_FINAL FROM SPCT_155 where arquivo_id = 1 order by 1, 2');
       sqlAux.Open;
       while not sqlAux.Eof do
       begin

             sqlAuxiliar.Close;
             sqlAuxiliar.SQL.Clear;
             sqlAuxiliar.SQL.Add(' UPDATE SPCT_155 ');
             sqlAuxiliar.SQL.Add(' SET CCUSTO = ''0000002771'' ');
             sqlAuxiliar.SQL.Add(' WHERE arquivo_id = 1 and  CONTA LIKE ''00006%'' AND CCUSTO = ''''  ');
             sqlAuxiliar.SQL.Add(' and DT_INICIAL = :DT_INICIAL and DT_FINAL = :DT_FINAL');
             sqlAuxiliar.Params.ParamByName('DT_INICIAL').AsString := sqlAux.FieldByName('DT_INICIAL').AsString;
             sqlAuxiliar.Params.ParamByName('DT_FINAL').AsString   := sqlAux.FieldByName('DT_FINAL').AsString;

             try
                sqlAuxiliar.ExecSQL;
             except
                on E: Exception do
                begin
                    Application.MessageBox(pWideChar( 'SPCT_155_' + E.Message), 'SPED', mb_iconError+  MB_OK);
                end;
             end;
           sqlAux.Next;
       end;

       sqlAuxiliar.Close;
       sqlAuxiliar.SQL.Clear;
       sqlAuxiliar.SQL.Add(' UPDATE SPCT_250  ');
       sqlAuxiliar.SQL.Add(' SET CCUSTO = ''0000002771''  ');
       sqlAuxiliar.SQL.Add(' WHERE arquivo_id = 1 and CONTA LIKE ''00006%'' AND CCUSTO = '''' ');
       try
          sqlAuxiliar.ExecSQL;
       except
          on E: Exception do
          begin
              Application.MessageBox(pWideChar( 'SPCT_250_' + E.Message), 'SPED', mb_iconError+  MB_OK);
          end;
       end;

       sqlAuxiliar.Close;
       sqlAuxiliar.SQL.Clear;
       sqlAuxiliar.SQL.Add(' UPDATE SPCT_355  ');
       sqlAuxiliar.SQL.Add(' SET CCUSTO = ''0000002771''  ');
       sqlAuxiliar.SQL.Add(' WHERE arquivo_id = 1 and CONTA LIKE ''00006%'' AND CCUSTO = '''' ');
       try
          sqlAuxiliar.ExecSQL;
       except
          on E: Exception do
          begin
              Application.MessageBox(pWideChar( 'SPCT_355_' + E.Message), 'SPED', mb_iconError+  MB_OK);
          end;
       end;
       sqlAuxiliar.Close;



       sqlGeral.Close;
       sqlGeral.SQL.Clear;
       sqlGeral.SQL.Add('Select * from SPCT_GERAL Where not LINHA like ''|I250%'' and not LINHA like ''|I155%'' and not LINHA like  ''|I355%'' and arquivo_id = 1 Order by 1');
       sqlGeral.Open;



      // Mensagem('Aguarde, Processando', '1');
       StatusBar1.Panels[0].Text := 'Status:';
       varNovoArquivo.Clear;
       I := 0;
       varConta155  := 0;
       varConta355  := 0;
       varContaI990 := 0;
       S:= 1;
       sqlGeral.DisableControls;
       while not sqlGeral.Eof do
       begin

           // Mensagem( 'Gerando Novo Arquivo SPED CONT�BIL  (' +  IntToStr(I) + '/' + IntToStr(T)+ ')' );
           Inc(I);


           if (I mod 100000 = 0) and (I > 0) then
           begin
               StatusBar1.Panels[0].Text :=  ' Processado: ' +  IntToStr(I);
               Application.ProcessMessages;
               varArquivo := editSalvarSped.Text + '\' + 'SPED_CONTABIL_2018_COM' + IntToStr(S) + '.txt';
               varNovoArquivo.SaveToFile(varArquivo);
               Inc(S);
               sleep(30);
               varNovoArquivo.Clear;
               FreeAndNil(varNovoArquivo);
               varNovoArquivo := TStringList.Create;
           end;

            varLinha := sqlGeralLINHA.AsString;

            if (varLinha.Split(['|'])[1].Trim = 'I150') Then
            begin
              varNovoArquivo.Add(varLinha);

              varDtInicial :=  varLinha.Split(['|'])[2].Trim;
              varDtFinal   :=  varLinha.Split(['|'])[3].Trim;

              sql155.Close;
              sql155.Params.ParamByName('DT_INICIAL').AsString := varDtInicial;
              sql155.Params.ParamByName('DT_FINAL').AsString   := varDtFinal;
              sql155.Params.ParamByName('ARQUIVO_ID').AsInteger   := 1;
              sql155.Open;

              while not sql155.Eof do
              begin
                  Inc(varContaI990);

                  Inc(varConta155);
                  varLinha   :=   sql155REGISTRO.AsString +
                                  sql155CONTA.AsString +
                                  sql155CCUSTO.AsString +
                                  sql155VALOR1.AsString.Replace('.',',') +
                                  sql155TIPO1.AsString +
                                  sql155VALOR2.AsString.Replace('.',',') +
                                  sql155VALOR3.AsString.Replace('.',',') +
                                  sql155VALOR4.AsString.Replace('.',',') +
                                  sql155TIPO2.AsString;


                   varNovoArquivo.Add(varLinha);

                 sql155.Next;
              end;
              sqlGeral.Next;
              Continue;
            end;


            if (varLinha.Split(['|'])[1].Trim  = 'I200') Then
            begin
              sql200.Close;
              sql200.Params.ParamByName('Numero').AsString := varLinha.Split(['|'])[2].Trim;
              sql200.Params.ParamByName('ARQUIVO_ID').AsInteger   := 1;
              sql200.Open;
              while not sql200.eof do
              begin
                 Inc(varContaI990);

                 varLinha :=  sql200REGISTRO.AsString +
                              sql200NUMERO.AsString +
                              sql200DATA.AsString +
                              sql200VALOR.AsString.Replace('.',',') +
                              Trim(sql200LETRA.AsString) + '||';


                 varNovoArquivo.Add(varLinha);

                 sql250.Close;
                 sql250.Params.ParamByName('SPCT_200_ID').AsString :=  sql200SPCT_200_ID.AsString;
                 sql250.Params.ParamByName('ARQUIVO_ID').AsInteger   := 1;
                 sql250.Open;
                 while not sql250.Eof do
                 begin
                   Inc(I);
                   Inc(varContaI990);
                   varLinha :=  sql250REGISTRO.AsString +
                                sql250CONTA.AsString +
                                sql250CCUSTO.AsString +
                                sql250VALOR1.AsString.Replace('.',',') +
                                sql250TIPO1.AsString +
                                sql250CODIGO.AsString +
                                sql250BRANCO1.AsString +
                                sql250DESCRICAO.AsString +
                                sql250BRANCO2.AsString;

                   if (I mod 100000 = 0) and (I > 0) then
                   begin
                       StatusBar1.Panels[0].Text :=  ' Processado: ' +  IntToStr(I);
                       Application.ProcessMessages;
                       varArquivo := editSalvarSped.Text + '\' + 'SPED_CONTABIL_2018_COM' + IntToStr(S) + '.txt';
                       varNovoArquivo.SaveToFile(varArquivo);
                       Inc(S);
                       sleep(30);
                       varNovoArquivo.Clear;
                       FreeAndNil(varNovoArquivo);
                       varNovoArquivo := TStringList.Create;
                   end;


                   varNovoArquivo.Add(varLinha);

                   sql250.Next;
                 end;
                 sql250.Close;

                 sql200.Next;
              end;
              sqlGeral.Next;
              Continue;
            end;

            sql200.Close;

            if (varLinha.Split(['|'])[1].Trim  = 'I350') Then
            begin

               varNovoArquivo.Add(varLinha);

               sql355.Close;
               sql355.Params.ParamByName('ARQUIVO_ID').AsInteger   := 1;
               sql355.Open;
               while not sql355.Eof do
               begin
                 Inc(varContaI990);
                 Inc(I);
                 Inc(varConta355);
                 varLinha :=  sql355REGISTRO.AsString +
                              sql355CONTA.AsString +
                              sql355CCUSTO.AsString +
                              sql355VALOR.AsString.Replace('.',',') +
                              sql355TIPO.AsString + '|';

                  varNovoArquivo.Add(varLinha);

                  sql355.Next;
               end;
            end
            else
            begin

              if (varLinha.Split(['|'])[2].Trim  = 'I990')  Then
              begin
                 varI990[0] := varLinha.Split(['|'])[1].Trim + '|';
                 varI990[1] := IntToStr(varContaI990) + '|';

                 varLinha := '|' +  varI990[0] + varI990[1];
              end;

              if ((varLinha.Split(['|'])[1].Trim  = '9900') and  (varLinha.Split(['|'])[2].Trim  = 'I155'))  Then
              begin
                 var9990155[0] := varLinha.Split(['|'])[1].Trim + '|';
                 var9990155[1] := varLinha.Split(['|'])[2].Trim + '|';
                 var9990155[2] := IntToStr(varConta155) + '|';

                 varLinha := '|' +  var9990155[0] + var9990155[1] + var9990155[2];
              end;

              if ((varLinha.Split(['|'])[1].Trim  = '9900') and  (varLinha.Split(['|'])[2].Trim  = 'I355'))  Then
              begin
                 var9990355[0] := varLinha.Split(['|'])[1].Trim + '|';
                 var9990355[1] := varLinha.Split(['|'])[2].Trim + '|';
                 var9990355[2] := IntToStr(varConta355) + '|';

                 varLinha := '|' +  var9990355[0] + var9990355[1] + var9990355[2];
              end;

              varNovoArquivo.Add(varLinha);

            end;


          sqlGeral.Next;
       end;

       sqlGeral.EnableControls;

       varArquivo := editSalvarSped.Text + '\' + 'SPED_CONTABIL_2018_COM_Ultimo.txt';
       varNovoArquivo.SaveToFile(varArquivo);
       //Mensagem('', '1');

       Application.MessageBox(pWideChar('Fim do Processo' + #13#10 + ' Arquivo Gerado: ' + varArquivo) , 'SPED', mb_iconinformation +  MB_OK);

   end;
  Finally
     FreeAndNil(varNovoArquivo);
  End;

end;

procedure TfrmSped.btnProcessarClick(Sender: TObject);
var
  varArquivo : TStringList;
  I, varFinal, varIdentity : Integer;
  varDtInicial, varDtFinal : String;
begin
    varArquivo := TStringList.Create;

    Mensagem('Aguarde, Processando...','1');

    with DB_Conect do
    begin

      Try

       // varArquivo.LoadFromFile( 'C:\Brady\Israel-Fiscal\arquivos\4100_01012017_31122017_ECD.txt' ); // 2018

        varArquivo.LoadFromFile( 'C:\Brady\Israel-Fiscal\arquivos\4100_01012018_31122018_ECD_COM ENCERRAMENTO.txt'); // 2019  Arquivo_ID = 1
       // varArquivo.LoadFromFile( 'C:\Brady\Israel-Fiscal\arquivos\4100_01012018_31122018_ECD_SEM ENCERRAMENTO.txt'); // 2019  Arquivo_ID = 2

        Application.ProcessMessages;
        varFinal := varArquivo.Count;
        StatusBar1.Panels[0].Text := 'Status:';
        for I := 0 to varArquivo.Count-1 do
        begin

         // Mensagem( 'Arquivo SPED CONT�BIL  (' +  IntToStr(I) + '/' + IntToStr(varFinal)+ ')' ,'1');
         if (I mod 1000 = 0) and (I > 0) then
         begin
            StatusBar1.Panels[0].Text := ' Processado: ' +  IntToStr(I);
            Application.ProcessMessages;
         end;

          if varArquivo[I].Split(['|'])[1].Trim = 'I150' then
          begin
            varDtInicial :=  varArquivo[I].Split(['|'])[2].Trim;
            varDtFinal   :=  varArquivo[I].Split(['|'])[3].Trim;
          end;

          Try

              if varArquivo[I].Split(['|'])[1].Trim = 'I155' then
              begin
               // |I155|0000211200|0000002642|56,00|D|0|0|56,00|D|
                 sql155.Close;
                 sql155.SQL.Clear;
                 sql155.SQL.Add('Insert Into SPCT_155 ');
                 sql155.SQL.Add('( DT_INICIAL, DT_FINAL, REGISTRO, CONTA, CCUSTO , VALOR1 , TIPO1 , VALOR2 , VALOR3 , VALOR4 , TIPO2, ARQUIVO_ID )');
                 sql155.SQL.Add(' Values( ');
                 sql155.SQL.Add(' :DT_INICIAL, :DT_FINAL,:REGISTRO, :CONTA, :CCUSTO , :VALOR1 , :TIPO1 , :VALOR2 , :VALOR3 , :VALOR4 , :TIPO2, :ARQUIVO_ID ');
                 sql155.SQL.Add(' )');
                 sql155.Params.ParamByName('DT_INICIAL').AsString := varDtInicial;
                 sql155.Params.ParamByName('DT_FINAL').AsString   := varDtFinal;

                 sql155.Params.ParamByName('REGISTRO').AsString := varArquivo[I].Split(['|'])[1].Trim;
                 sql155.Params.ParamByName('CONTA').AsString    := varArquivo[I].Split(['|'])[2].Trim;
                 sql155.Params.ParamByName('CCUSTO').AsString   := varArquivo[I].Split(['|'])[3].Trim;
                 sql155.Params.ParamByName('VALOR1').AsFloat    := StrToFloat(varArquivo[I].Split(['|'])[4].Trim);
                 sql155.Params.ParamByName('TIPO1').AsString    := varArquivo[I].Split(['|'])[5].Trim;
                 sql155.Params.ParamByName('VALOR2').AsFloat    := StrToFloat(varArquivo[I].Split(['|'])[6].Trim);
                 sql155.Params.ParamByName('VALOR3').AsFloat    := StrToFloat(varArquivo[I].Split(['|'])[7].Trim);
                 sql155.Params.ParamByName('VALOR4').AsFloat    := StrToFloat(varArquivo[I].Split(['|'])[8].Trim);
                 sql155.Params.ParamByName('TIPO2').AsString    := varArquivo[I].Split(['|'])[9].Trim;
                 sql155.Params.ParamByName('ARQUIVO_ID').AsInteger  := 1;

                 try
                    sql155.ExecSQL;
                 except
                    on E: Exception do
                    begin
                      Application.MessageBox(pWideChar( 'SPCT_155_' + E.Message + ' - ' +  varArquivo[I]), 'SPED', mb_iconError+  MB_OK);
                    end;
                 end;

              end;

              if varArquivo[I].Split(['|'])[1].Trim = 'I200' then
              begin
                 sql200.Close;
                 sql200.SQL.Clear;
                 sql200.SQL.Add('Insert Into SPCT_200 ');
                 sql200.SQL.Add('( REGISTRO, NUMERO, DATA , VALOR , LETRA, ARQUIVO_ID  )');
                 sql200.SQL.Add(' Values( ');
                 sql200.SQL.Add(' :REGISTRO, :NUMERO, :DATA , :VALOR , :LETRA, :ARQUIVO_ID  ');
                 sql200.SQL.Add(' )');
                 sql200.Params.ParamByName('REGISTRO').AsString := varArquivo[I].Split(['|'])[1].Trim;
                 sql200.Params.ParamByName('NUMERO').AsString   := varArquivo[I].Split(['|'])[2].Trim;
                 sql200.Params.ParamByName('DATA').AsString     := varArquivo[I].Split(['|'])[3].Trim;
                 sql200.Params.ParamByName('VALOR').AsFloat     := StrToFloat(varArquivo[I].Split(['|'])[4].Trim);
                 sql200.Params.ParamByName('LETRA').AsString    := varArquivo[I].Split(['|'])[5].Trim;
                 sql200.Params.ParamByName('ARQUIVO_ID').AsInteger  := 1;
                 Try
                    sql200.ExecSQL;
                 except
                    on E: Exception do
                    begin
                        Application.MessageBox(pWideChar( 'SPCT_200_' + E.Message + '-' + varArquivo[I]), 'SPED', mb_iconError+  MB_OK);
                    end;
                 end;


                 Try
                    varIdentity := 0;
                    sqlAuxiliar.Close;
                    sqlAuxiliar.SQL.Clear;
                    sqlAuxiliar.SQL.Add( 'SELECT @@IDENTITY as SPCT_200_ID ' );
                    sqlAuxiliar.Open;
                    varIdentity := sqlAuxiliar.FieldByName('SPCT_200_ID').AsInteger;

                 except
                    On E:Exception do
                      begin
                        varPeriodo := '';
                        Application.MessageBox(pWideChar( 'Falha ao pegar chave da tabela SPCT_200: ' + E.Message), 'SPED', mb_iconError+  MB_OK);
                      end;
                 end;

              end;



              if varArquivo[I].Split(['|'])[1].Trim = 'I250' then
              begin
               // |I250|0000783000||2915,71|D|||211000 - Valuation on 20161231||
                 sql250.Close;
                 sql250.SQL.Clear;
                 sql250.SQL.Add('Insert Into SPCT_250 ');
                 sql250.SQL.Add('( SPCT_200_ID, REGISTRO, CONTA, CCUSTO , VALOR1 , TIPO1 , CODIGO,  BRANCO1, DESCRICAO, BRANCO2, ARQUIVO_ID )');
                 sql250.SQL.Add(' Values( ');
                 sql250.SQL.Add(' :SPCT_200_ID,  :REGISTRO, :CONTA, :CCUSTO , :VALOR1 , :TIPO1 , :CODIGO, :BRANCO1, :DESCRICAO, :BRANCO2, :ARQUIVO_ID ');
                 sql250.SQL.Add(' )');
                 sql250.Params.ParamByName('SPCT_200_ID').AsInteger := varIdentity;
                 sql250.Params.ParamByName('REGISTRO').AsString     := varArquivo[I].Split(['|'])[1].Trim;
                 sql250.Params.ParamByName('CONTA').AsString        := varArquivo[I].Split(['|'])[2].Trim;
                 sql250.Params.ParamByName('CCUSTO').AsString       := varArquivo[I].Split(['|'])[3].Trim;
                 sql250.Params.ParamByName('VALOR1').AsFloat        := StrToFloat(varArquivo[I].Split(['|'])[4].Trim);
                 sql250.Params.ParamByName('TIPO1').AsString        := varArquivo[I].Split(['|'])[5].Trim;
                 sql250.Params.ParamByName('CODIGO').AsString       := varArquivo[I].Split(['|'])[6].Trim;
                 sql250.Params.ParamByName('BRANCO1').AsString      := varArquivo[I].Split(['|'])[7].Trim;
                 sql250.Params.ParamByName('DESCRICAO').AsString    := varArquivo[I].Split(['|'])[8].Trim;
                 sql250.Params.ParamByName('BRANCO2').AsString      := varArquivo[I].Split(['|'])[9].Trim;
                 sql250.Params.ParamByName('ARQUIVO_ID').AsInteger  := 1;

                 try
                    sql250.ExecSQL;
                 except
                    on E: Exception do
                    begin
                       Application.MessageBox(pWideChar( 'SPCT_250_' + E.Message + ' - ' +  varArquivo[I]), 'SPED', mb_iconError+  MB_OK);
                    end;
                 end;

              end;

              if varArquivo[I].Split(['|'])[1].Trim = 'I355' then
              begin
               //  |I355|0000699000|0000008656|513633,01|D|
                 sql355.Close;
                 sql355.SQL.Clear;
                 sql355.SQL.Add('Insert Into SPCT_355 ');
                 sql355.SQL.Add('(  REGISTRO, CONTA, CCUSTO , VALOR , TIPO, ARQUIVO_ID  )');
                 sql355.SQL.Add(' Values( ');
                 sql355.SQL.Add(' :REGISTRO, :CONTA, :CCUSTO , :VALOR , :TIPO, :ARQUIVO_ID ');
                 sql355.SQL.Add(' )');
                 sql355.Params.ParamByName('REGISTRO').AsString     := varArquivo[I].Split(['|'])[1].Trim;
                 sql355.Params.ParamByName('CONTA').AsString        := varArquivo[I].Split(['|'])[2].Trim;
                 sql355.Params.ParamByName('CCUSTO').AsString       := varArquivo[I].Split(['|'])[3].Trim;
                 sql355.Params.ParamByName('VALOR').AsFloat         := StrToFloat(varArquivo[I].Split(['|'])[4].Trim);
                 sql355.Params.ParamByName('TIPO').AsString         := varArquivo[I].Split(['|'])[5].Trim;
                 sql355.Params.ParamByName('ARQUIVO_ID').AsInteger  := 1;

                 try
                    sql355.ExecSQL;
                 except
                    on E: Exception do
                    begin
                       Application.MessageBox(pWideChar( 'SPCT_355_' + E.Message + ' - ' +  varArquivo[I]), 'SPED', mb_iconError+  MB_OK);
                    end;
                 end;

              end;


              sqlGeral.Close;
              sqlGeral.SQL.Clear;
              sqlGeral.SQL.Add('Insert into SPCT_GERAL (Linha, ARQUIVO_ID) Values (:Linha, :ARQUIVO_ID)');
              sqlGeral.Params.ParamByName('Linha').AsString := varArquivo[I];
              sqlGeral.Params.ParamByName('ARQUIVO_ID').AsInteger  := 1;
              try
                  sqlGeral.ExecSQL;
              except
                  on E: Exception do
                  begin
                    Application.MessageBox(pWideChar( 'SPCT_GERAL_' + E.Message + ' - ' +  varArquivo[I]), 'SPED', mb_iconError+  MB_OK);
                  end;
              end;
          except
              on E: Exception do
              begin
                 Application.MessageBox(pWideChar( 'COMPLETO_' + E.Message), 'SPED', mb_iconError+  MB_OK);
              end;

          End;
        end;
        Mensagem('','1');
        Application.MessageBox('Fim do Processamento.', 'SPED', mb_iconinformation +  MB_OK );

      Finally
        FreeAndNil(varArquivo);
      End;

  end;
end;

procedure TfrmSped.btnSelecionaPathClick(Sender: TObject);
var
  FDir : String;
begin
  inherited;
  if Win32MajorVersion >= 6 then
    with TFileOpenDialog.Create(nil) do
    try
      Title := 'Selecionar Diret�rio';
      Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem]; // YMMV
      OkButtonLabel := 'Selecionar';
      DefaultFolder := FDir;
      FileName := FDir;
      if Execute then
      begin
        editSalvarSped.Text := FileName;

        if editSalvarSped.Text  <> '' then
           SalvarPath(editSalvarSped.Text);
      end;
    finally
      Free;
    end
  else
    if SelectDirectory('Selecionar Diret�rio', ExtractFileDrive(FDir), FDir,
             [sdNewUI, sdNewFolder]) then
      editSalvarSped.Text := FDir;

   if FDir <> '' then
      SalvarPath(FDir);

end;

procedure  TfrmSped.Salvar_Apuracao(Linha : String);
var
  sqlGravar : TFDQuery;
  I: Integer;
  varApuracao : String;
begin
  sqlGravar := TFDQuery.Create(Nil);
  Try
    sqlGravar.Connection := DB_Conect.FDConnection;
    sqlGravar.Close;
    sqlGravar.SQL.Clear;
    sqlGravar.SQL.Add(' Insert into ARQ_APURACAO ');
    sqlGravar.SQL.Add(' (REGISTRO,  CST,  CNPJ,  PERIODO,  VALOR_BASE,  PIS_PORC,  VALOR_PIS, COFINS_PORC,  VALOR_COFINS)');
    sqlGravar.SQL.Add(' Values ');
    sqlGravar.SQL.Add(' (:REGISTRO,  :CST,  :CNPJ,  :PERIODO,  :VALOR_BASE,  :PIS_PORC,  :VALOR_PIS, :COFINS_PORC,  :VALOR_COFINS)');
    sqlGravar.Params.ParamByName('REGISTRO').AsString       := Apuracao.REGISTRO;
    sqlGravar.Params.ParamByName('CST').AsString            := Apuracao.CST;
    sqlGravar.Params.ParamByName('CNPJ').AsString           := Apuracao.CNPJ;
    sqlGravar.Params.ParamByName('PERIODO').AsString        := Apuracao.PERIODO;
    sqlGravar.Params.ParamByName('VALOR_BASE').AsCurrency   := Apuracao.VALOR_BASE;
    sqlGravar.Params.ParamByName('PIS_PORC').AsCurrency     := Apuracao.PIS_PORC;
    sqlGravar.Params.ParamByName('VALOR_PIS').AsCurrency    := Apuracao.VALOR_PIS;
    sqlGravar.Params.ParamByName('COFINS_PORC').AsCurrency  := Apuracao.COFINS_PORC;
    sqlGravar.Params.ParamByName('VALOR_COFINS').AsCurrency := Apuracao.VALOR_COFINS;


    try
      sqlGravar.ExecSQL;
    except
        on E: Exception do
        begin
          Application.MessageBox( pWideChar( Linha + '-' +  E.Message), 'ARQ_APURACAO', mb_iconError+  MB_OK);
        end;
    end;
  Finally
    FreeAndNil(sqlGravar);
  End;

end;

procedure TfrmSped.spbLimpaApuracaoClick(Sender: TObject);
begin
  editBuscaApuracao.Text := '';
  editBuscaApuracao.bs_KeyValues.Clear;

  if Assigned(sqlCredito) then
    sqlCredito.Close;

  if Assigned(sqlDebito) then
    sqlDebito.Close;

  if Assigned(sqlEstorno) then
    sqlEstorno.Close;

  if Assigned(sqlSpedOriginal) then
    sqlSpedOriginal.Close;

   cxDBPivotGrid.DataController.DataSource.DataSet.Close;

   mskPis.Clear;
   mskCofins.Clear;
   mskPisOriginal.Clear;
   mskCofinsOriginal.Clear;
   mskPisDif.Clear;
   mskCofinsDif.Clear;

end;

procedure TfrmSped.ButImportarClick(Sender: TObject);
var
  varResultado : Word;
  varMensagem: String;
  bReprocessar : Boolean;
begin

  if chkSemLoad.Checked = False Then
  begin
      bReprocessar := False;


      if editSalvarSped.Text = EmptyStr then
      begin
        Application.MessageBox('Informe a pasta para salvar o novo SPED.', 'SPED', mb_iconinformation +  MB_OK );
        editSalvarSped.SetFocus;
        exit;
      end;

      if cxButtonEditPath.Text = EmptyStr then
      begin
        Application.MessageBox('Informe o arquivo SPED primeiro', 'SPED', mb_iconinformation +  MB_OK );
        exit;
      end;

      if cxButtonEditPathExcel.Text = EmptyStr then
      begin
           Application.MessageBox('Informe o arquivo EXCEL primeiro.', 'SPED', mb_iconinformation +  MB_OK );
           exit;
      end;

      if editLinhaExcel.Text = EmptyStr then
      begin
           Application.MessageBox('Informe a quantidade de linhas do arquivo EXCEL.', 'SPED', mb_iconinformation +  MB_OK );
           exit;
      end;

      if not IsNumeric(editLinhaExcel.Text) then
      begin
           Application.MessageBox('Informe somente n�meros entre 0 e 9.', 'SPED', mb_iconinformation +  MB_OK );
           editLinhaExcel.Text := '';
           editLinhaExcel.SetFocus;
           exit;
      end;

      if DoMergeDatas then
      begin
          editInicio.Text := TimeToStr(Now);
          Application.ProcessMessages;
          Try
            ImportarSPED;
          except
            on E: Exception do
            begin
              varPeriodo := '';
              Mensagem('' ,'0');

              if E.Message = 'Operation aborted' then
                 Application.MessageBox('Opera��o cancelada pelo usu�rio.' , 'SPED', mb_iconinformation +  MB_OK )
              else
                 Mensagem( E.Message  ,'0');
            end;
          end;

        //  varCNPJSPED := '01111039000149';
        //  varPeriodo  := '01022018_28002018';

          if varPeriodo <> '' then
             Import_Excel(varCNPJSPED);

      end;
  end
  else
  begin
    bReprocessar := True;
    varPeriodo  := sqlPeriodoPERIODO.AsString;
    varCNPJSPED := sqlPeriodoCNPJ.AsString;
  end;

  if ((varPeriodo <> '') and (varCNPJSPED <> '')) Then
  begin
      if bReprocessar then
      begin
        varMensagem := 'Processar CNPJ: ' + varCNPJSPED + ' para o Periodo: ' + varPeriodo + '?' ;
        varResultado := Application.MessageBox(PCHAR(varMensagem),'Gerar Novo SPED.',
                       MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2+MB_APPLMODAL);

        case varResultado of
            IDYES :
            begin
              editInicio.Text := TimeToStr(Now);

              with DB_Conect do
              begin
                  sqlAuxiliar.Close;
                  sqlAuxiliar.SQL.Clear;
                  sqlAuxiliar.SQL.Add('Delete From ARQ_APURACAO ');
                  sqlAuxiliar.SQL.Add('WHERE CNPJ = :CNPJ_SPED ');
                  sqlAuxiliar.SQL.Add('AND PERIODO = :PERIODO');
                  sqlAuxiliar.Params.ParamByName('PERIODO').AsString     :=  varPeriodo;
                  sqlAuxiliar.Params.ParamByName('CNPJ_SPED').AsString   :=  varCNPJSPED;
                  Try
                    sqlAuxiliar.ExecSQL;
                  except
                    On E:Exception do
                      begin
                        varPeriodo := '';
                        Application.MessageBox(pWideChar( 'Falha ao excluir ARQ_APURACAO do banco de dados. (ARQ_APURACAO)  ' + E.Message), 'SPED', mb_iconError+  MB_OK);
                      end;
                  end;

                  sqlAuxiliar.Close;
                  sqlAuxiliar.SQL.Clear;
                  sqlAuxiliar.SQL.Add('Delete From ARQ_APURACAO_ORIGINAL ');
                  sqlAuxiliar.SQL.Add('WHERE CNPJ = :CNPJ_SPED ');
                  sqlAuxiliar.SQL.Add('AND PERIODO = :PERIODO');
                  sqlAuxiliar.Params.ParamByName('PERIODO').AsString     :=  varPeriodo;
                  sqlAuxiliar.Params.ParamByName('CNPJ_SPED').AsString   :=  varCNPJSPED;
                  Try
                    sqlAuxiliar.ExecSQL;
                  except
                    On E:Exception do
                      begin
                        varPeriodo := '';
                        Application.MessageBox(pWideChar( 'Falha ao excluir ARQ_APURACAO_ORIGINAL do banco de dados. (ARQ_APURACAO_ORIGINAL)  ' + E.Message), 'SPED', mb_iconError+  MB_OK);
                      end;
                  end;


              end;

              GerarNovoSPED(varCNPJSPED);
            end;

            IDNO :
            begin
              abort;
            end;
        end;
      end
      else
      begin
        GerarNovoSPED(varCNPJSPED);
      end;
  end;

end;

function TfrmSped.IsNumeric(const S: String): Boolean;
var
    x: SmallInt;
begin
    Result:= True;
    For x:= 1 to Length(S) do
    begin
        if not(S[x] in['0'..'9']) then
        begin
            Result:= False; Break;
        end;
    end;
end;

procedure TfrmSped.ButSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSped.Button1Click(Sender: TObject);
begin
   ComparaArquivos( 'C:\Brady\Israel-Fiscal\SPED_01111039000149_01072017_31072017_Validado.txt', 'C:\Brady\Israel-Fiscal\SPED_01111039000149_01072017_31072017.txt'  );
end;

procedure TfrmSped.chkSemLoadClick(Sender: TObject);
begin
  if chkSemLoad.Checked then
    Application.MessageBox('Selecione CNPJ Principal e o Periodo correspondente para gerar novo SPED.' , 'SPED', mb_iconinformation +  MB_OK )
end;

procedure TfrmSped.cxButton3Click(Sender: TObject);
begin
  SaveDialog.InitialDir := GetCurrentDir;
  if Page.ActivePage = TabFaltaProduto then
  begin
    if  sqlfalta.IsEmpty then
    begin
        Application.MessageBox('N�o h� dados de Produtos para serem exportados.', 'Exportar para Excel - NFe', mb_iconinformation +  MB_OK);
        Exit;
    end;

    if SaveDialog.Execute then
       ExportGridToExcel(SaveDialog.FileName, cxGrid3, True, True);
  end;
end;

procedure TfrmSped.cxButtonEditPathClick(Sender: TObject);
begin
  OpenDialog.Filter := 'Arquivos texto (*.txt)|*.txt';

  if OpenDialog.Execute(Handle) then
  begin
    cxButtonEditPath.Text := OpenDialog.FileName;
  end;

end;

procedure TfrmSped.cxButtonEditPathExcelClick(Sender: TObject);
begin
  OpenDialog.Filter := 'Arquivos texto (*.xlsx)|*.xlsx';
  if OpenDialog.Execute(Handle) then
  begin
    cxButtonEditPathExcel.Text := OpenDialog.FileName;
  end;

end;

function  TfrmSped.DoMergeDatas : Boolean;
var
  varSPED : TStringList;
  dxSpreadSheet: TdxSpreadSheet;
  varDataInicial, varDataFinal, varDataNF  :TDateTime;
  varUltimaColuna, I, X,  varColumnDataNF, varUltimaLinha : Integer;
  varDate: Integer;
begin
  Result := True;
  varSPED       := TStringList.Create;
  dxSpreadSheet := TdxSpreadSheet.Create(nil);
  Try
    Mensagem('Comparando Arquivos...' ,'0');

    varSPED.LoadFromFile( cxButtonEditPath.Text );
    varDataInicial   := StrToDate(Copy(varSPED[0].Split(['|'])[6].Trim,1,2) + '/' + Copy(varSPED[0].Split(['|'])[6].Trim,3,2) + '/' + Copy(varSPED[0].Split(['|'])[6].Trim,5,4));
    varDataFinal     := StrToDate(Copy(varSPED[0].Split(['|'])[7].Trim,1,2) + '/' + Copy(varSPED[0].Split(['|'])[7].Trim,3,2) + '/' + Copy(varSPED[0].Split(['|'])[7].Trim,5,4));

    dxSpreadSheet.LoadFromFile( cxButtonEditPathExcel.Text);
    varUltimaColuna := dxSpreadSheet.ActiveSheetAsTable.Columns.LastIndex;
    varColumnDataNF := -1;

    for I := dxSpreadSheet.ActiveSheetAsTable.Columns.FirstIndex to varUltimaColuna do
    begin
       if not  Assigned(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0]) then
         Break;

       if dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString = 'DATA NF' then
         varColumnDataNF := I;

       if varColumnDataNF > -1 then
         Break;
    end;


    if varColumnDataNF = -1 then
    begin
      Application.MessageBox( 'Coluna (DATA NF) n�o foi encontrada' ,  'SPED', MB_ICONINFORMATION+  MB_OK);
      Abort;
    end;

    varUltimaLinha := StrToInt(editLinhaExcel.Text)-1;

    for X := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to varUltimaLinha do
    begin
      Try

       if (dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[varColumnDataNF].AsString = '' ) then
         Continue;

       if not  Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[varColumnDataNF]) then
         Continue;


        if dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[varColumnDataNF].DataType = cdtDateTime then
          varDataNF := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[varColumnDataNF].AsDateTime
        else
        if TryStrToInt( dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[varColumnDataNF].AsString, varDate ) then
          varDataNF := varDate
        else
          varDataNF := StrToDate(String(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[varColumnDataNF].AsString).Replace( '.', '/' ));

        if ((varDataNF < varDataInicial) or (varDataNF > varDataFinal)) then
        begin
           Mensagem('' ,'0');
           Application.MessageBox( 'Arquivos SPED e Produtos n�o s�o do mesmo per�odo.' + #13#10 + 'Processo cancelado.' ,  'SPED', MB_ICONEXCLAMATION+  MB_OK);
           Result := False;

           if Assigned(varSPED) then
             FreeAndNil(varSPED);

           if Assigned(dxSpreadSheet) then
             FreeAndNil(dxSpreadSheet);

           Abort;
        end;
      except
         on E: Exception do
          begin
              Application.MessageBox(pWideChar( 'Comparar Datas' + E.Message), 'SPED', mb_iconError+  MB_OK);
          end;
      End;

    end;
    Mensagem('' ,'0');

  Finally
    FreeAndNil(varSPED);
    FreeAndNil(dxSpreadSheet);
  End;

end;

procedure TfrmSped.editBuscaApuracaoClick(Sender: TObject);
begin
   if ((editBuscaApuracao.Text <> '') and (editBuscaApuracao.bs_KeyValues.Count > 0)) then
   begin
     Page.ActivePage := TabApurar;
     AbrirApuracao(editBuscaApuracao.bs_KeyValues[0], editBuscaApuracao.bs_KeyValues[3],'1');
   end;
end;

procedure  TfrmSped.GerarNovoSPED(CNPJ_SPED : String);
var
  varSPED  : TStringList;
//  varLista : TStringList;

  varLinha, varCodItem, varCodCNPJ, varCodCNPJTMP, varCodConta, varLinha180, varOldConta181, varOldConta185, varNewConta181, varNewConta185 : String;
  I, T, Y, W, J, varUltimaLinha, varContaArq, varContaC, varConta181, varConta185,  varInicial, varM410Count, varM810Count, varCountM410, varCountM410Del : Integer;
  bApagaUltima : Boolean;
  varDataInicial, varDataFinal : TDateTime;
  sqlUpdateNF : TFDQuery;
  varSumPIS, varSumCofins, varSumProdutos : Extended ;
  ValorSum210065 , ValorSum210165,   ValorSum610300,   ValorSum610760, ValorSum610004 : Extended ;
  ValorSumProd210065 , ValorSumProd210165,   ValorSumProd610300,   ValorSumProd610760 : Extended ;
  varTotalEntradaPIS,    varSumC191,  varSumD101,  varSumM110 : Extended ;
  varTotalEntradaCOFINS, varSumC195 , varSumD105 , VarSumM510 : Extended ;
  varSumAliq06, varSumAliq07, varSumAliq08, varSumCTA06_0000411000, varSUMCTA06_0000414005,
  varSumCTA07_0000411000, varSUMCTA07_0000414005, varSumCTA08_0000411000, varSUMCTA08_0000414005  : Extended ;
  varA170Pis, varA170Cofins, varBaseA170065, varBaseA170165, varBaseA170076  : Extended ;

  varValorPisOriginal, varValorCofinsOriginal, varValorDefault: Extended;

  varF100Pis065, varF100Pis165, varF100Cofins400, varF100Cofins076 : Extended ;
  varF100Total,   varF100PisBase065, varF100PisBase165, varF100CofinsBase400, varF100CofinsBase076 : Extended ;
  bPassouM4001, bPassouM4002, bPassouM4003, bPassouM4004, bPassouM4005, bPassouM4006,
  bPassouM8001, bPassouM8002, bPassouM8003, bPassouM8004, bPassouM8005, bPassouM8006 : Boolean ;

  varRecalcular : Array [0..1]  of String;
  varNovoC18    : Array [0..2]  of String;
  varNovoM410   : Array [0..2]  of String;
  varM200       : Array [0..12] of String;
  varM205       : Array [0..3]  of String;
  varM600       : Array [0..12] of String;
  varM605       : Array [0..3]  of String;
  varM400_800   : Array [0..4]  of String;
  varM210065    : Array [0..12] of String;
  varM210165    : Array [0..12] of String;
  varM610300    : Array [0..12] of String;
  varM610760    : Array [0..12] of String;
  varM610400    : Array [0..12] of String;

  bachouM40008, bachouM80008, varLookupRes, varJaApagou : Boolean;
  sqlCFOP : TFDQuery;
  varIndice : Integer;
begin
  varValorPisOriginal    := 0;
  varValorCofinsOriginal := 0;

  sqlfalta.Close;
  sqlfalta.SQL.Clear;
  sqlfalta.SQL.Add('SELECT * FROM ARQ_C180 C ');
  sqlfalta.SQL.Add('INNER JOIN ARQ_C180_ITENS I ON I.ARQ_C180 = C.ARQ_C180 ');
  sqlfalta.SQL.Add('WHERE C.PERIODO = :PERIODO  ');
  sqlfalta.SQL.Add('AND NOT EXISTS (SELECT F.COD_ITEM FROM ARQ_NF F WHERE F.PERIODO = :PERIODO and C.COD_ITEM = F.COD_ITEM) ');
  sqlfalta.SQL.Add('AND I.CST IN (''01'',''02'') ');
  sqlfalta.SQL.Add('ORDER BY C.COD_ITEM ');
  sqlfalta.Params.ParamByName('PERIODO').AsString := varPeriodo;
  sqlfalta.Open;

  if not sqlfalta.IsEmpty then
  begin
     Application.MessageBox(pWideChar('Falta Produto(s) no arquivo Excel. Verifique.') , 'SPED', mb_iconinformation +  MB_OK);
     lblTituloFaltaProduto.Visible := True;
     lblTituloFaltaProduto.Caption := lblTituloFaltaProduto.Caption + ExtractFileName(cxButtonEditPathExcel.Text);
     Page.ActivePage := TabFaltaProduto;
     Abort;
  end;

  Mensagem( 'Aguarde, Processando...'  ,'0');
  varSPED     := TStringList.Create;
  sqlUpdateNF := TFDQuery.Create(Nil);

  Try
    sqlUpdateNF.Connection := DB_Conect.FDConnection;
    sqlUpdateNF.Close;
    sqlUpdateNF.SQL.Clear;
    sqlUpdateNF.SQL.Add('UPDATE ARQ_NF ');
    sqlUpdateNF.SQL.Add('SET    CST  = (select top 1 I.CST from ARQ_C180_ITENS I Where I.ARQ_C180 = C.ARQ_C180 and I.CFOP = X.CFOP and I.CST in (''01'',''02''))');
    sqlUpdateNF.SQL.Add('FROM   ARQ_NF X  ');
    sqlUpdateNF.SQL.Add('INNER JOIN ARQ_C180 C ON C.COD_ITEM = X.COD_ITEM  ');
    sqlUpdateNF.SQL.Add('       and C.PERIODO = X.PERIODO ');
    sqlUpdateNF.SQL.Add('       and C.FILIAL = X.FILIAL   ');
    sqlUpdateNF.SQL.Add(' WHERE ((X.CST = '''') or (X.CST is NULL)) ');
    Try
      sqlUpdateNF.ExecSQL;
      Sleep(3000);
    except
      On E:Exception do
        begin
          varPeriodo := '';
          Application.MessageBox(pWideChar( 'Falha ao Atulizar CST (ARQ_NF) ' + E.Message), 'SPED', mb_iconError+  MB_OK);
        end;
    end;

    sqlUpdateNF.Close;
    sqlUpdateNF.SQL.Clear;
    sqlUpdateNF.SQL.Add('UPDATE ARQ_NF ');
    sqlUpdateNF.SQL.Add('SET    CST  = (select top 1 I.CST from ARQ_C180_ITENS I Where I.ARQ_C180 = C.ARQ_C180 and I.CFOP = X.CFOP and I.CST in (''01'',''02''))');
    sqlUpdateNF.SQL.Add('FROM   ARQ_NF X  ');
    sqlUpdateNF.SQL.Add('INNER JOIN ARQ_C180 C ON C.COD_ITEM = X.COD_ITEM  ');
    sqlUpdateNF.SQL.Add('       and C.PERIODO = X.PERIODO ');
    sqlUpdateNF.SQL.Add('       and C.FILIAL = X.FILIAL   ');
    sqlUpdateNF.SQL.Add(' WHERE ((X.CST = '''') or (X.CST is NULL)) ');
    Try
      sqlUpdateNF.ExecSQL;
      Sleep(3000);
    except
      On E:Exception do
        begin
          varPeriodo := '';
          Application.MessageBox(pWideChar( 'Falha ao Atulizar CST (ARQ_NF) ' + E.Message), 'SPED', mb_iconError+  MB_OK);
        end;
    end;

    varSPED.Clear;
    with DB_Conect do
    begin
       sqlAuxiliar.Close;
       sqlAuxiliar.SQL.Clear;
       sqlAuxiliar.SQL.Add('Select Count(1) as Total From Arq_Geral');
       sqlAuxiliar.SQL.Add('Where Periodo = :Periodo and CNPJ = :CNPJ ');
       sqlAuxiliar.Params.ParamByName('Periodo').AsString := varPeriodo;
       sqlAuxiliar.Params.ParamByName('CNPJ').AsString    := CNPJ_SPED;
       sqlAuxiliar.Open;
       T := sqlAuxiliar.FieldByName('Total').AsInteger;

       sqlAuxiliar.Close;
       sqlAuxiliar.SQL.Clear;
       sqlAuxiliar.SQL.Add('Select * From Arq_Geral');
       sqlAuxiliar.SQL.Add('Where Periodo = :Periodo and CNPJ = :CNPJ Order BY Arq_Geral_ID ');
       sqlAuxiliar.Params.ParamByName('Periodo').AsString := varPeriodo;
       sqlAuxiliar.Params.ParamByName('CNPJ').AsString    := CNPJ_SPED;

       sqlAuxiliar.Open;
       sqlAuxiliar.First;

       I := 1;
       varCodCNPJTMP := '';
       varCodConta   := '';
       varCodCNPJTMP := '';
       varCodCNPJ    := '';
       StatusBar1.Panels[0].Text := 'Status:';
       bachouM40008  := False;
       bachouM80008  := False;
       varCountM410  := 0;
       while not sqlAuxiliar.Eof do
       begin

              if (I mod 1000 = 0) and (I > 0) then
              begin
                StatusBar1.Panels[0].Text := ' Processado: ' +  IntToStr(I);
                Application.ProcessMessages;
              end;
              Inc(I);

              varLinha       :=  sqlAuxiliar.FieldByName('Linha').AsString;

              varDataInicial := 0;
              varDataFinal   := 0;
              if ((sqlAuxiliar.FieldByName('DTINICIAL').AsString <> '') and (sqlAuxiliar.FieldByName('DTFINAL').AsString <> '')) then
              begin

                varDataInicial   := StrToDate(Copy(sqlAuxiliar.FieldByName('DTINICIAL').AsString,1,2) + '/' + Copy(sqlAuxiliar.FieldByName('DTINICIAL').AsString,3,2) + '/' + Copy(sqlAuxiliar.FieldByName('DTINICIAL').AsString,5,4));
                varDataFinal     := StrToDate(Copy(sqlAuxiliar.FieldByName('DTFINAL').AsString,1,2) + '/' + Copy(sqlAuxiliar.FieldByName('DTFINAL').AsString,3,2) + '/' + Copy(sqlAuxiliar.FieldByName('DTFINAL').AsString,5,4));

              end;

              if (varLinha.Split(['|'])[1].Trim  = 'C181') Then // AND ((varLinha.Split(['|'])[2].Trim  = '01') or (varLinha.Split(['|'])[2].Trim  = '02')) then
              begin
                  sqlAuxiliar.Next;
                  Continue;
              end;

              if (varLinha.Split(['|'])[1].Trim  = 'C185')  Then //AND  ((varLinha.Split(['|'])[2].Trim  = '01') or (varLinha.Split(['|'])[2].Trim  = '02'))  then
              begin
                  sqlAuxiliar.Next;
                  Continue;
              end;

              if (varLinha.Split(['|'])[1].Trim  = 'C180') then
              begin
                varLinha180 :=  varLinha;
                varCodItem  := varLinha.Split(['|'])[5].Trim;

           //     if varLinha.Split(['|'])[5].Trim = 'Y3954170' Then
             //      ShowMessage('achei');
              end
              else varCodItem := '0';


              if (varLinha.Split(['|'])[1].Trim  = 'C010') Then
              begin
                 varCodCNPJ      := varLinha.Split(['|'])[2].Trim;
                 varCodCNPJTMP   := varLinha.Split(['|'])[2].Trim;
              end;

              if chckCta005.Checked then
              begin
                if ((varLinha.Split(['|'])[1].Trim  = 'M400') AND (varLinha.Split(['|'])[2].Trim  = '08')) Then
                begin
                    varSPED.Add(varLinha);
                    bachouM40008 := True;
                    sqlAuxiliar.Next;
                    varLinha       :=  sqlAuxiliar.FieldByName('Linha').AsString;
                    varSPED.Add(varLinha);
                    Continue;
                end;

                if bachouM40008 then
                begin
                    varSPED.Add('|M410|999|0|0000414005||');
                    bachouM40008 := False;
                    sqlAuxiliar.Next;
                    Continue;
                end;

                if ((varLinha.Split(['|'])[1].Trim  = '9900') AND (varLinha.Split(['|'])[2].Trim  = 'M410')) Then
                   varCountM410  := StrToInt(varLinha.Split(['|'])[3].Trim);

                if ((varLinha.Split(['|'])[1].Trim  = 'M800') AND (varLinha.Split(['|'])[2].Trim  = '08')) Then
                begin
                    varSPED.Add(varLinha);
                    bachouM80008 := True;
                    sqlAuxiliar.Next;
                    varLinha       :=  sqlAuxiliar.FieldByName('Linha').AsString;
                    varSPED.Add(varLinha);
                    Continue;
                end;

                if bachouM80008 then
                begin
                    varSPED.Add('|M810|999|0|0000414005||');
                    bachouM80008 := False;
                    sqlAuxiliar.Next;
                    Continue;
                end;
              end;

              sqlAux.Close;
              sqlAux.SQL.Clear;
              sqlAux.SQL.Add('Select * From VW_RECALCULO ');
              sqlAux.SQL.Add('Where COD_ITEM = :COD_ITEM and FILIAL = :FILIAL AND PERIODO = :PERIODO');
              if ((sqlAuxiliar.FieldByName('DTINICIAL').AsString <> '') and (sqlAuxiliar.FieldByName('DTFINAL').AsString <> '')) then
              begin
                sqlAux.SQL.Add(' and DATANF between :DATA1 and :DATA2 ');
                sqlAux.Params.ParamByName('DATA1').AsDateTime  := varDataInicial;
                sqlAux.Params.ParamByName('DATA2').AsDateTime  := varDataFinal;
              end;
              sqlAux.Params.ParamByName('COD_ITEM').AsString := Trim(varCodItem);
              sqlAux.Params.ParamByName('FILIAL').AsString   := varCodCNPJ;
              sqlAux.Params.ParamByName('PERIODO').AsString  := varPeriodo;
              sqlAux.Open;

              if (not sqlAux.IsEmpty)  then
              begin

                sqlAux180.Close;
                sqlAux180.SQL.Clear;
                sqlAux180.SQL.Add('SELECT ''|'' + P.REG AS REG, ''|'' +  ');
                sqlAux180.SQL.Add('P.COD_MOD AS COD_MOD, ''|'' +  ');
                sqlAux180.SQL.Add('P.DT_DOC_INI AS DT_DOC_INI, ''|'' + ');
                sqlAux180.SQL.Add('P.DT_DOC_FIN AS DT_DOC_FIN, ''|'' +  ');
                sqlAux180.SQL.Add('rtrim(ltrim(P.COD_ITEM)) AS COD_ITEM, ''|'' + ');
                sqlAux180.SQL.Add('P.COD_NCM AS COD_NCM,''||'' +  ');
                sqlAux180.SQL.Add('CONVERT(VARCHAR, SUM(CONVERT(DECIMAL(10,2), C.NOVABASE ))) + ''|'' AS NOVABASE  ');
                sqlAux180.SQL.Add('FROM ARQ_C180 P   ');
                sqlAux180.SQL.Add('INNER JOIN VW_RECALCULO C ON C.COD_ITEM = P.COD_ITEM AND C.FILIAL = P.FILIAL AND C.PERIODO = P.PERIODO ');
                sqlAux180.SQL.Add('WHERE P.COD_ITEM = :COD_ITEM ');
                sqlAux180.SQL.Add('AND   C.FILIAL   = :FILIAL ');
                sqlAux180.SQL.Add('AND   P.PERIODO  = :PERIODO ');

                if ((sqlAuxiliar.FieldByName('DTINICIAL').AsString <> '') and (sqlAuxiliar.FieldByName('DTFINAL').AsString <> '')) then
                  sqlAux180.SQL.Add(' and P.DT_DOC_INI = :DTINICIAL and P.DT_DOC_FIN = :DTFINAL ');

                sqlAux180.SQL.Add(' GROUP BY P.REG, P.COD_MOD, P.DT_DOC_INI, P.DT_DOC_FIN, P.COD_ITEM, P.COD_NCM   ');

                sqlAux180.Params.ParamByName('COD_ITEM').AsString := Trim(varCodItem);
                sqlAux180.Params.ParamByName('FILIAL').AsString   := varCodCNPJ;
                sqlAux180.Params.ParamByName('PERIODO').AsString  := varPeriodo;

                if ((sqlAuxiliar.FieldByName('DTINICIAL').AsString <> '') and (sqlAuxiliar.FieldByName('DTFINAL').AsString <> '')) then
                begin
                    sqlAux180.Params.ParamByName('DTINICIAL').AsString   := sqlAuxiliar.FieldByName('DTINICIAL').AsString;
                    sqlAux180.Params.ParamByName('DTFINAL').AsString     := sqlAuxiliar.FieldByName('DTFINAL').AsString;
                end;

                sqlAux180.Open;


                varLinha :=  sqlAux180.FieldByName('REG').AsString +
                             sqlAux180.FieldByName('COD_MOD').AsString +
                             sqlAux180.FieldByName('DT_DOC_INI').AsString +
                             sqlAux180.FieldByName('DT_DOC_FIN').AsString +
                             sqlAux180.FieldByName('COD_ITEM').AsString +
                             sqlAux180.FieldByName('COD_NCM').AsString +
                             sqlAux180.FieldByName('NOVABASE').AsString.Replace('.',',');

                varSPED.Add(varLinha);

                sqlAux180Itens.Close;
                sqlAux180Itens.SQL.Clear;
                sqlAux180Itens.SQL.Add('SELECT ''|C181''  as REG, ''|'' + ');
                sqlAux180Itens.SQL.Add('C.CST AS CST, ''|'' + ');
                sqlAux180Itens.SQL.Add('C.CFOP AS CFOP, ''|'' +  ');
                sqlAux180Itens.SQL.Add('Convert(varchar,SUM(CONVERT(DECIMAL(10,2),C.NOVA_BASE))) as NovaBase, ''|0|'' + ');
                sqlAux180Itens.SQL.Add('Convert(varchar,SUM(CONVERT(DECIMAL(10,2),C.NOVA_BASE))) as NovaBase2, ''|'' +  ');
                sqlAux180Itens.SQL.Add('Convert(varchar,C.ALIQ_PIS*100) as ALIQ, ''|||'' + ');
                sqlAux180Itens.SQL.Add('Convert(varchar,SUM(CONVERT(DECIMAL(10,2),C.NOVO_VALOR_PIS))) as NOVOVALOR, ''|'' + ');
                sqlAux180Itens.SQL.Add('( SELECT TOP 1   CASE F.COD_CT WHEN  ''0000451000'' THEN ''0000451000|'' ');
                sqlAux180Itens.SQL.Add(' ELSE   CONVERT(VARCHAR,   (SELECT CONTA FROM ARQ_CFOP WHERE CFOP = C.CFOP)  ) + ''|'' END ');
                sqlAux180Itens.SQL.Add('   FROM ARQ_C180_ITENS F WHERE P.ARQ_C180 = F.ARQ_C180  AND F.REG = ''C181'') AS COD_CT ');
                sqlAux180Itens.SQL.Add('FROM ARQ_C180 P  ');
                sqlAux180Itens.SQL.Add('INNER JOIN ARQ_NF C ON C.COD_ITEM = P.COD_ITEM ');
                sqlAux180Itens.SQL.Add('                   AND C.FILIAL = P.FILIAL  ');
                sqlAux180Itens.SQL.Add('                   AND C.PERIODO = P.PERIODO  ');
                sqlAux180Itens.SQL.Add('WHERE P.COD_ITEM = :COD_ITEM1 ');
                sqlAux180Itens.SQL.Add('AND C.FILIAL = :FILIAL1 ');
                sqlAux180Itens.SQL.Add('AND P.PERIODO = :PERIODO1 ');

                if ((sqlAuxiliar.FieldByName('DTINICIAL').AsString <> '') and (sqlAuxiliar.FieldByName('DTFINAL').AsString <> '')) then
                   sqlAux180Itens.SQL.Add(' and P.DT_DOC_INI = :DTINICIAL and P.DT_DOC_FIN = :DTFINAL ');

                sqlAux180Itens.SQL.Add(' GROUP BY  C.CFOP , C.ALIQ_PIS,  C.CST,  P.ARQ_C180  ');
                sqlAux180Itens.SQL.Add('   ORDER BY  3  ');

                sqlAux180Itens.Params.ParamByName('COD_ITEM1').AsString := varCodItem;
                sqlAux180Itens.Params.ParamByName('FILIAL1').AsString   := varCodCNPJ;
                sqlAux180Itens.Params.ParamByName('PERIODO1').AsString  := varPeriodo;
                if ((sqlAuxiliar.FieldByName('DTINICIAL').AsString <> '') and (sqlAuxiliar.FieldByName('DTFINAL').AsString <> '')) then
                begin
                    sqlAux180Itens.Params.ParamByName('DTINICIAL').AsString   := sqlAuxiliar.FieldByName('DTINICIAL').AsString;
                    sqlAux180Itens.Params.ParamByName('DTFINAL').AsString     := sqlAuxiliar.FieldByName('DTFINAL').AsString;
                end;
               // GetComando( sqlAux180Itens, true );
                sqlAux180Itens.Open;
                sqlAux180Itens.First;
                while not sqlAux180Itens.Eof do
                begin
                    varLinha :=  sqlAux180Itens.FieldByName('REG').AsString +
                                 sqlAux180Itens.FieldByName('CST').AsString +
                                 sqlAux180Itens.FieldByName('CFOP').AsString +
                                 sqlAux180Itens.FieldByName('NovaBase').AsString.Replace('.',',') +
                                 sqlAux180Itens.FieldByName('NovaBase2').AsString.Replace('.',',') +
                                 sqlAux180Itens.FieldByName('ALIQ').AsString.Replace('.',',') +
                                 sqlAux180Itens.FieldByName('NOVOVALOR').AsString.Replace('.',',') +
                                 sqlAux180Itens.FieldByName('COD_CT').AsString;
              
                    varSPED.Add(varLinha);
                    sqlAux180Itens.Next;
                end;

                sqlAux180Itens.Close;
                sqlAux180Itens.SQL.Clear;
                sqlAux180Itens.SQL.Add('SELECT ''|'' +F.REG as REG, ''|'' + ');
                sqlAux180Itens.SQL.Add('F.CST AS CST, ''|'' + ');
                sqlAux180Itens.SQL.Add('F.CFOP AS CFOP, ''|'' +  ');
                sqlAux180Itens.SQL.Add('Convert(varchar,SUM(CONVERT(DECIMAL(10,2),CASE WHEN F.VL_BC = 0.00 THEN F.VL_ITEM ELSE F.VL_BC END ))) as NovaBase, ''|0|'' + ');
                sqlAux180Itens.SQL.Add('Convert(varchar,SUM(CONVERT(DECIMAL(10,2),CASE WHEN F.VL_BC = 0.00 THEN F.VL_ITEM ELSE F.VL_BC END ))) as NovaBase2, ''|'' +  ');
                sqlAux180Itens.SQL.Add('''0'' as ALIQ, ''|||'' + ');
                sqlAux180Itens.SQL.Add('''0'' as NOVOVALOR, ''|'' + ');
                sqlAux180Itens.SQL.Add('Convert(varchar,   (SELECT CONTA FROM ARQ_CFOP WHERE CFOP = F.CFOP)  ) + ''|''  as COD_CT ');
                sqlAux180Itens.SQL.Add('FROM ARQ_C180 P  ');
                sqlAux180Itens.SQL.Add('INNER JOIN ARQ_C180_ITENS F ON  P.ARQ_C180 = F.ARQ_C180  ');

                sqlAux180Itens.SQL.Add('WHERE P.COD_ITEM = :COD_ITEM1 ');
                sqlAux180Itens.SQL.Add('AND P.FILIAL = :FILIAL1 ');
                sqlAux180Itens.SQL.Add('AND P.PERIODO = :PERIODO1 ');
                sqlAux180Itens.SQL.Add('AND F.REG = ''C181'' ');
                sqlAux180Itens.SQL.Add('and F.CST in (''06'',''07'',''08'')');
                if ((sqlAuxiliar.FieldByName('DTINICIAL').AsString <> '') and (sqlAuxiliar.FieldByName('DTFINAL').AsString <> '')) then
                   sqlAux180Itens.SQL.Add(' and P.DT_DOC_INI = :DTINICIAL and P.DT_DOC_FIN = :DTFINAL ');

                sqlAux180Itens.SQL.Add(' GROUP BY  F.CFOP , F.ALIQ,  F.CFOP,  F.REG, F.CST  ');

                sqlAux180Itens.Params.ParamByName('COD_ITEM1').AsString := varCodItem;
                sqlAux180Itens.Params.ParamByName('FILIAL1').AsString   := varCodCNPJ;
                sqlAux180Itens.Params.ParamByName('PERIODO1').AsString  := varPeriodo;
                if ((sqlAuxiliar.FieldByName('DTINICIAL').AsString <> '') and (sqlAuxiliar.FieldByName('DTFINAL').AsString <> '')) then
                begin
                    sqlAux180Itens.Params.ParamByName('DTINICIAL').AsString   := sqlAuxiliar.FieldByName('DTINICIAL').AsString;
                    sqlAux180Itens.Params.ParamByName('DTFINAL').AsString     := sqlAuxiliar.FieldByName('DTFINAL').AsString;
                end;

                sqlAux180Itens.Open;
                sqlAux180Itens.First;
                while not sqlAux180Itens.Eof do
                begin
                    varLinha :=  sqlAux180Itens.FieldByName('REG').AsString +
                                 sqlAux180Itens.FieldByName('CST').AsString +
                                 sqlAux180Itens.FieldByName('CFOP').AsString +
                                 sqlAux180Itens.FieldByName('NovaBase').AsString.Replace('.',',') +
                                 sqlAux180Itens.FieldByName('NovaBase2').AsString.Replace('.',',') +
                                 sqlAux180Itens.FieldByName('ALIQ').AsString +
                                 sqlAux180Itens.FieldByName('NOVOVALOR').AsString +
                                 sqlAux180Itens.FieldByName('COD_CT').AsString;

                    varSPED.Add(varLinha);
                    sqlAux180Itens.Next;
                end;

                sqlAux180Itens.Close;
                sqlAux180Itens.SQL.Clear;
                sqlAux180Itens.SQL.Add('SELECT  ''|C185''  as REG, ''|'' + ');
                sqlAux180Itens.SQL.Add('            C.CST AS CST, ''|'' +  ');
                sqlAux180Itens.SQL.Add('            C.CFOP AS CFOP, ''|'' +  ');
                sqlAux180Itens.SQL.Add('            Convert(varchar,SUM(CONVERT(DECIMAL(10,2),C.NOVA_BASE))) as NovaBase, ''|0|'' +  ');
                sqlAux180Itens.SQL.Add('            Convert(varchar,SUM(CONVERT(DECIMAL(10,2),C.NOVA_BASE))) as NovaBase2, ''|'' +  ');
                sqlAux180Itens.SQL.Add('            Convert(varchar,C.ALIQ_COFINS*100) as ALIQ, ''|||'' +   ');
                sqlAux180Itens.SQL.Add('            Convert(varchar,SUM(CONVERT(DECIMAL(10,2),C.NOVO_VALOR_COFINS))) as NOVOVALOR, ''|'' +  ');
                sqlAux180Itens.SQL.Add(' ( SELECT TOP 1   CASE F.COD_CT WHEN  ''0000451000'' THEN ''0000451000|'' ');
                sqlAux180Itens.SQL.Add(' ELSE   CONVERT(VARCHAR,   (SELECT CONTA FROM ARQ_CFOP WHERE CFOP = C.CFOP)  ) + ''|'' END ');
                sqlAux180Itens.SQL.Add('   FROM ARQ_C180_ITENS F WHERE P.ARQ_C180 = F.ARQ_C180  AND F.REG = ''C185'') AS COD_CT ');
                sqlAux180Itens.SQL.Add('FROM ARQ_C180 P  ');
                sqlAux180Itens.SQL.Add('INNER JOIN ARQ_NF C ON C.COD_ITEM = P.COD_ITEM ');
                sqlAux180Itens.SQL.Add('                         AND C.FILIAL = P.FILIAL  ');
                sqlAux180Itens.SQL.Add('                         AND C.PERIODO = P.PERIODO  ');
                sqlAux180Itens.SQL.Add(' WHERE P.COD_ITEM = :COD_ITEM2');
                sqlAux180Itens.SQL.Add('AND C.FILIAL = :FILIAL2  ');
                sqlAux180Itens.SQL.Add('AND P.PERIODO = :PERIODO2 ');

                if ((sqlAuxiliar.FieldByName('DTINICIAL').AsString <> '') and (sqlAuxiliar.FieldByName('DTFINAL').AsString <> '')) then
                   sqlAux180Itens.SQL.Add(' and P.DT_DOC_INI = :DTINICIAL and P.DT_DOC_FIN = :DTFINAL ');

                sqlAux180Itens.SQL.Add(' GROUP BY  C.CFOP , C.ALIQ_COFINS,  C.CST,  P.ARQ_C180 ');
                sqlAux180Itens.SQL.Add('   ORDER BY  3  ');


                sqlAux180Itens.Params.ParamByName('COD_ITEM2').AsString := varCodItem;
                sqlAux180Itens.Params.ParamByName('FILIAL2').AsString   := varCodCNPJ;
                sqlAux180Itens.Params.ParamByName('PERIODO2').AsString  := varPeriodo;

                if ((sqlAuxiliar.FieldByName('DTINICIAL').AsString <> '') and (sqlAuxiliar.FieldByName('DTFINAL').AsString <> '')) then
                begin
                    sqlAux180Itens.Params.ParamByName('DTINICIAL').AsString   := sqlAuxiliar.FieldByName('DTINICIAL').AsString;
                    sqlAux180Itens.Params.ParamByName('DTFINAL').AsString     := sqlAuxiliar.FieldByName('DTFINAL').AsString;
                end;
                sqlAux180Itens.Open;
                sqlAux180Itens.First;
                while not sqlAux180Itens.Eof do
                begin
                    varLinha :=  sqlAux180Itens.FieldByName('REG').AsString +
                                 sqlAux180Itens.FieldByName('CST').AsString +
                                 sqlAux180Itens.FieldByName('CFOP').AsString +
                                 sqlAux180Itens.FieldByName('NovaBase').AsString.Replace('.',',') +
                                 sqlAux180Itens.FieldByName('NovaBase2').AsString.Replace('.',',') +
                                 sqlAux180Itens.FieldByName('ALIQ').AsString.Replace('.',',') +
                                 sqlAux180Itens.FieldByName('NOVOVALOR').AsString.Replace('.',',') +
                                 sqlAux180Itens.FieldByName('COD_CT').AsString;


                    varSPED.Add(varLinha);
                    sqlAux180Itens.Next;
                end;

                sqlAux180Itens.Close;
                sqlAux180Itens.SQL.Clear;

                sqlAux180Itens.SQL.Add('SELECT ''|'' +F.REG as REG, ''|'' + ');
                sqlAux180Itens.SQL.Add('F.CST AS CST, ''|'' + ');
                sqlAux180Itens.SQL.Add('F.CFOP AS CFOP, ''|'' +  ');
                sqlAux180Itens.SQL.Add('Convert(varchar,SUM(CONVERT(DECIMAL(10,2),CASE WHEN F.VL_BC = 0.00 THEN F.VL_ITEM ELSE F.VL_BC END ))) as NovaBase, ''|0|'' + ');
                sqlAux180Itens.SQL.Add('Convert(varchar,SUM(CONVERT(DECIMAL(10,2),CASE WHEN F.VL_BC = 0.00 THEN F.VL_ITEM ELSE F.VL_BC END ))) as NovaBase2, ''|'' +  ');
                sqlAux180Itens.SQL.Add('''0'' as ALIQ, ''|||'' + ');
                sqlAux180Itens.SQL.Add('''0'' as NOVOVALOR, ''|'' + ');
                sqlAux180Itens.SQL.Add('Convert(varchar,   (SELECT CONTA FROM ARQ_CFOP WHERE CFOP = F.CFOP)  ) + ''|''  as COD_CT ');
                sqlAux180Itens.SQL.Add('FROM ARQ_C180 P  ');
                sqlAux180Itens.SQL.Add('INNER JOIN ARQ_C180_ITENS F ON  P.ARQ_C180 = F.ARQ_C180  ');

                sqlAux180Itens.SQL.Add('WHERE P.COD_ITEM = :COD_ITEM1 ');
                sqlAux180Itens.SQL.Add('AND P.FILIAL = :FILIAL1 ');
                sqlAux180Itens.SQL.Add('AND P.PERIODO = :PERIODO1 ');
                sqlAux180Itens.SQL.Add('AND F.REG = ''C185'' ');
                sqlAux180Itens.SQL.Add('and F.CST in (''06'',''07'',''08'')');
                if ((sqlAuxiliar.FieldByName('DTINICIAL').AsString <> '') and (sqlAuxiliar.FieldByName('DTFINAL').AsString <> '')) then
                   sqlAux180Itens.SQL.Add(' and P.DT_DOC_INI = :DTINICIAL and P.DT_DOC_FIN = :DTFINAL ');

                sqlAux180Itens.SQL.Add(' GROUP BY  F.CFOP , F.ALIQ,  F.CFOP,  F.REG, F.CST  ');

                sqlAux180Itens.Params.ParamByName('COD_ITEM1').AsString := varCodItem;
                sqlAux180Itens.Params.ParamByName('FILIAL1').AsString   := varCodCNPJ;
                sqlAux180Itens.Params.ParamByName('PERIODO1').AsString  := varPeriodo;

                if ((sqlAuxiliar.FieldByName('DTINICIAL').AsString <> '') and (sqlAuxiliar.FieldByName('DTFINAL').AsString <> '')) then
                begin
                    sqlAux180Itens.Params.ParamByName('DTINICIAL').AsString   := sqlAuxiliar.FieldByName('DTINICIAL').AsString;
                    sqlAux180Itens.Params.ParamByName('DTFINAL').AsString     := sqlAuxiliar.FieldByName('DTFINAL').AsString;
                end;
                sqlAux180Itens.Open;
                sqlAux180Itens.First;
                while not sqlAux180Itens.Eof do
                begin
                    varLinha :=  sqlAux180Itens.FieldByName('REG').AsString +
                                 sqlAux180Itens.FieldByName('CST').AsString +
                                 sqlAux180Itens.FieldByName('CFOP').AsString +
                                 sqlAux180Itens.FieldByName('NovaBase').AsString.Replace('.',',') +
                                 sqlAux180Itens.FieldByName('NovaBase2').AsString.Replace('.',',') +
                                 sqlAux180Itens.FieldByName('ALIQ').AsString +
                                 sqlAux180Itens.FieldByName('NOVOVALOR').AsString +
                                 sqlAux180Itens.FieldByName('COD_CT').AsString;

                    varSPED.Add(varLinha);
                    sqlAux180Itens.Next;
                end;
              end
              else
              begin
                varSPED.Add(varLinha);

                if (varLinha.Split(['|'])[1].Trim  = 'C180')  Then
                begin
                    // C181 SEM PIS
                    sqlAux180Itens.Close;
                    sqlAux180Itens.SQL.Clear;

                    sqlAux180Itens.SQL.Add('SELECT ''|'' +F.REG as REG, ''|'' + ');
                    sqlAux180Itens.SQL.Add('F.CST AS CST, ''|'' + ');
                    sqlAux180Itens.SQL.Add('F.CFOP AS CFOP, ''|'' +  ');
                    sqlAux180Itens.SQL.Add('Convert(varchar,SUM(CONVERT(DECIMAL(10,2),CASE WHEN F.VL_BC = 0.00 THEN F.VL_ITEM ELSE F.VL_BC END ))) as NovaBase, ''|0|'' + ');
                    sqlAux180Itens.SQL.Add('Convert(varchar,SUM(CONVERT(DECIMAL(10,2),CASE WHEN F.VL_BC = 0.00 THEN F.VL_ITEM ELSE F.VL_BC END ))) as NovaBase2, ''|'' +  ');
                    sqlAux180Itens.SQL.Add('''0'' as ALIQ, ''|||'' + ');
                    sqlAux180Itens.SQL.Add('''0'' as NOVOVALOR, ''|'' + ');
                    sqlAux180Itens.SQL.Add('Convert(varchar,   (SELECT CONTA FROM ARQ_CFOP WHERE CFOP = F.CFOP)  ) + ''|''  as COD_CT ');
                    sqlAux180Itens.SQL.Add('FROM ARQ_C180 P  ');
                    sqlAux180Itens.SQL.Add('INNER JOIN ARQ_C180_ITENS F ON  P.ARQ_C180 = F.ARQ_C180  ');

                    sqlAux180Itens.SQL.Add('WHERE P.COD_ITEM = :COD_ITEM1 ');
                    sqlAux180Itens.SQL.Add('AND P.FILIAL = :FILIAL1 ');
                    sqlAux180Itens.SQL.Add('AND P.PERIODO = :PERIODO1 ');
                    sqlAux180Itens.SQL.Add('AND F.REG = ''C181'' ');
                    sqlAux180Itens.SQL.Add('and F.CST in (''06'',''07'',''08'')');
                    if ((sqlAuxiliar.FieldByName('DTINICIAL').AsString <> '') and (sqlAuxiliar.FieldByName('DTFINAL').AsString <> '')) then
                      sqlAux180Itens.SQL.Add(' and P.DT_DOC_INI = :DTINICIAL and P.DT_DOC_FIN = :DTFINAL ');

                    sqlAux180Itens.SQL.Add(' GROUP BY  F.CFOP , F.ALIQ,  F.CFOP,  F.REG, F.CST  ');

                    sqlAux180Itens.Params.ParamByName('COD_ITEM1').AsString := varCodItem;
                    sqlAux180Itens.Params.ParamByName('FILIAL1').AsString   := varCodCNPJ;
                    sqlAux180Itens.Params.ParamByName('PERIODO1').AsString  := varPeriodo;

                    if ((sqlAuxiliar.FieldByName('DTINICIAL').AsString <> '') and (sqlAuxiliar.FieldByName('DTFINAL').AsString <> '')) then
                    begin
                        sqlAux180Itens.Params.ParamByName('DTINICIAL').AsString   := sqlAuxiliar.FieldByName('DTINICIAL').AsString;
                        sqlAux180Itens.Params.ParamByName('DTFINAL').AsString     := sqlAuxiliar.FieldByName('DTFINAL').AsString;
                    end;
                    sqlAux180Itens.Open;
                    sqlAux180Itens.First;
                    while not sqlAux180Itens.Eof do
                    begin
                        varLinha :=  sqlAux180Itens.FieldByName('REG').AsString +
                                     sqlAux180Itens.FieldByName('CST').AsString +
                                     sqlAux180Itens.FieldByName('CFOP').AsString +
                                     sqlAux180Itens.FieldByName('NovaBase').AsString.Replace('.',',') +
                                     sqlAux180Itens.FieldByName('NovaBase2').AsString.Replace('.',',') +
                                     sqlAux180Itens.FieldByName('ALIQ').AsString +
                                     sqlAux180Itens.FieldByName('NOVOVALOR').AsString +
                                     sqlAux180Itens.FieldByName('COD_CT').AsString;

                        varSPED.Add(varLinha);
                        sqlAux180Itens.Next;
                    end;

                    // C185 SEM COFINS
                    sqlAux180Itens.Close;
                    sqlAux180Itens.SQL.Clear;
                    sqlAux180Itens.SQL.Add('SELECT ''|'' +F.REG as REG, ''|'' + ');
                    sqlAux180Itens.SQL.Add('F.CST AS CST, ''|'' + ');
                    sqlAux180Itens.SQL.Add('F.CFOP AS CFOP, ''|'' +  ');
                    sqlAux180Itens.SQL.Add('Convert(varchar,SUM(CONVERT(DECIMAL(10,2),CASE WHEN F.VL_BC = 0.00 THEN F.VL_ITEM ELSE F.VL_BC END ))) as NovaBase, ''|0|'' + ');
                    sqlAux180Itens.SQL.Add('Convert(varchar,SUM(CONVERT(DECIMAL(10,2),CASE WHEN F.VL_BC = 0.00 THEN F.VL_ITEM ELSE F.VL_BC END ))) as NovaBase2, ''|'' +  ');
                    sqlAux180Itens.SQL.Add('''0'' as ALIQ, ''|||'' + ');
                    sqlAux180Itens.SQL.Add('''0'' as NOVOVALOR, ''|'' + ');
                    sqlAux180Itens.SQL.Add('Convert(varchar,   (SELECT CONTA FROM ARQ_CFOP WHERE CFOP = F.CFOP)  ) + ''|''  as COD_CT ');
                    sqlAux180Itens.SQL.Add('FROM ARQ_C180 P  ');
                    sqlAux180Itens.SQL.Add('INNER JOIN ARQ_C180_ITENS F ON  P.ARQ_C180 = F.ARQ_C180  ');
                    sqlAux180Itens.SQL.Add('WHERE P.COD_ITEM = :COD_ITEM1 ');
                    sqlAux180Itens.SQL.Add('AND P.FILIAL = :FILIAL1 ');
                    sqlAux180Itens.SQL.Add('AND P.PERIODO = :PERIODO1 ');
                    sqlAux180Itens.SQL.Add('AND F.REG = ''C185'' ');
                    sqlAux180Itens.SQL.Add('and F.CST in (''06'',''07'',''08'')');
                    if ((sqlAuxiliar.FieldByName('DTINICIAL').AsString <> '') and (sqlAuxiliar.FieldByName('DTFINAL').AsString <> '')) then
                     sqlAux180Itens.SQL.Add(' and P.DT_DOC_INI = :DTINICIAL and P.DT_DOC_FIN = :DTFINAL ');
                    sqlAux180Itens.SQL.Add(' GROUP BY  F.CFOP , F.ALIQ,  F.CFOP,  F.REG, F.CST  ');
                    sqlAux180Itens.Params.ParamByName('COD_ITEM1').AsString := varCodItem;
                    sqlAux180Itens.Params.ParamByName('FILIAL1').AsString   := varCodCNPJ;
                    sqlAux180Itens.Params.ParamByName('PERIODO1').AsString  := varPeriodo;
                    if ((sqlAuxiliar.FieldByName('DTINICIAL').AsString <> '') and (sqlAuxiliar.FieldByName('DTFINAL').AsString <> '')) then
                    begin
                        sqlAux180Itens.Params.ParamByName('DTINICIAL').AsString   := sqlAuxiliar.FieldByName('DTINICIAL').AsString;
                        sqlAux180Itens.Params.ParamByName('DTFINAL').AsString     := sqlAuxiliar.FieldByName('DTFINAL').AsString;
                    end;
                    sqlAux180Itens.Open;
                    sqlAux180Itens.First;
                    while not sqlAux180Itens.Eof do
                    begin
                        varLinha :=  sqlAux180Itens.FieldByName('REG').AsString +
                                     sqlAux180Itens.FieldByName('CST').AsString +
                                     sqlAux180Itens.FieldByName('CFOP').AsString +
                                     sqlAux180Itens.FieldByName('NovaBase').AsString.Replace('.',',') +
                                     sqlAux180Itens.FieldByName('NovaBase2').AsString.Replace('.',',') +
                                     sqlAux180Itens.FieldByName('ALIQ').AsString +
                                     sqlAux180Itens.FieldByName('NOVOVALOR').AsString +
                                     sqlAux180Itens.FieldByName('COD_CT').AsString;

                        varSPED.Add(varLinha);
                        sqlAux180Itens.Next;
                    end;
                end;
              end;
              sqlUpdateNF.Close;
              sqlUpdateNF.SQL.Clear;
              sqlUpdateNF.SQL.Add('Update Arq_Geral Set Lido = ''S'' where ARQ_GERAL_ID = :ARQ_GERAL_ID');
              sqlUpdateNF.Params.ParamByName('ARQ_GERAL_ID').AsString :=  sqlAuxiliar.FieldByName('ARQ_GERAL_ID').AsString;
              sqlUpdateNF.ExecSQL;

          sqlAuxiliar.Next;
       end;

       Mensagem('Consolidando Informa��es...' ,'0');
       varContaArq            := 0;
       varContaC              := 0;
       varInicial             := 0;
       varConta181            := 0;
       varConta185            := 0;
       ValorSum210065         := 0;
       ValorSum210165         := 0;
       ValorSum610300         := 0;
       ValorSum610760         := 0;
       ValorSum610004         := 0;
       varSumProdutos         := 0;
       varSumPIS              := 0;
       varSumCofins           := 0;
       varSumC191             := 0;
       varSumD101             := 0;
       varSumM110             := 0;
       varSumC195             := 0;
       varSumD105             := 0;
       VarSumM510             := 0;
       varSumAliq06           := 0;
       varSumAliq07           := 0;
       varSumAliq08           := 0;
       varM410Count           := 0;
       varM810Count           := 0;
       varSumCTA06_0000411000 := 0;
       varSUMCTA06_0000414005 := 0;
       varSumCTA07_0000411000 := 0;
       varSUMCTA07_0000414005 := 0;
       varSumCTA08_0000411000 := 0;
       varSUMCTA08_0000414005 := 0;
       varTotalEntradaPIS     := 0;
       varTotalEntradaCOFINS  := 0;
       ValorSumProd210065     := 0;
       ValorSumProd210165     := 0;
       ValorSumProd610300     := 0;
       ValorSumProd610760     := 0;
       varCountM410Del        := 0;
       varF100Pis065          := 0;
       varF100Pis165          := 0;
       varF100Cofins400       := 0;
       varF100Cofins076       := 0;

       varA170Pis             := 0;
       varA170Cofins          := 0;

       varBaseA170065         := 0;
       varBaseA170165         := 0;
       varBaseA170076         := 0;

       varF100Total           := 0;
       varF100PisBase065      := 0;
       varF100PisBase165      := 0;
       varF100CofinsBase400   := 0;
       varF100CofinsBase076   := 0;


       bPassouM4001           := False;
       bPassouM4002           := False;
       bPassouM4003           := False;
       bPassouM4004           := False;
       bPassouM4005           := False;
       bPassouM4006           := False;


       bPassouM8001           := False;
       bPassouM8002           := False;
       bPassouM8003           := False;
       bPassouM8004           := False;
       bPassouM8005           := False;
       bPassouM8006           := False;

       varLookupRes           := True;
       varJaApagou            := False;
    //   varLista               := TStringList.Create;
       sqlCFOP                := TFDQuery.Create(Nil);

       sqlCFOP.Connection     := DB_Conect.FDConnection;
       sqlCFOP.Close;
       sqlCFOP.SQL.Clear;
       sqlCFOP.SQL.Add('Select DISTINCT CONTA From ARQ_CFOP');
       sqlCFOP.Open;

       for J := varSPED.Count -1 downto 0 do
       begin

         if ((varSPED[J].Split(['|'])[1].Trim  = '9900') AND (varSPED[J].Split(['|'])[2].Trim  = 'M410')) Then
            varCountM410Del  := StrToInt(varSPED[J].Split(['|'])[3].Trim);


         if (varSPED[J].Split(['|'])[1].Trim  = 'M410') then
         begin
            varLookupRes := sqlCFOP.Locate('Conta', varSPED[J].Split(['|'])[4].Trim, []);
            if (not VarIsNull(varLookupRes)) And (varLookupRes= false) then
              varSPED.Delete(J);
         end;

         if (varSPED[J].Split(['|'])[1].Trim  = 'M810') then
         begin
            varLookupRes := sqlCFOP.Locate('Conta', varSPED[J].Split(['|'])[4].Trim, []);
            if (not VarIsNull(varLookupRes)) And (varLookupRes= false) then
              varSPED.Delete(J);
         end;

       end;


       for Y := varInicial to varSPED.Count-1 do
       begin

          if varSPED[Y].Split(['|'])[1].Trim  = 'C181' Then
          begin
            Try
               Inc(varConta181);
               if ((varSPED[Y].Split(['|'])[2].Trim = '01') or (varSPED[Y].Split(['|'])[2].Trim = '02')) then
               begin
                 Apuracao.LimpaRecord;
                 if  ((Copy(varSPED[Y].Split(['|'])[3].Trim,1,1) = '5') or  (Copy(varSPED[Y].Split(['|'])[3].Trim,1,1) = '6')) then
                 begin
                   varSumProdutos  := varSumProdutos  +  StrToFloat(varSPED[Y].Split(['|'])[4].Trim);
                   varSumPIS       := varSumPIS       +  StrToFloat(varSPED[Y].Split(['|'])[10].Trim);
                //   varLista.Add(varSPED[Y].Split(['|'])[4].Trim + ';' + varSPED[Y].Split(['|'])[10].Trim + ';' + varSPED[Y].Split(['|'])[7].Trim + ';'  + varSPED[y].Trim);

                 end;

                  Apuracao.REGISTRO     := 'C181/C185';
                  Apuracao.CST          := varSPED[Y].Split(['|'])[2].Trim;
                  Apuracao.CNPJ         := CNPJ_SPED;
                  Apuracao.PERIODO      := varPeriodo;
                  Apuracao.VALOR_BASE   := StrToFloat(varSPED[Y].Split(['|'])[4].Trim);
                  Apuracao.PIS_PORC     := StrToFloat(varSPED[Y].Split(['|'])[7].Trim);
                  Apuracao.VALOR_PIS    := StrToFloat(varSPED[Y].Split(['|'])[10].Trim);
                  Apuracao.VALOR_COFINS := 0;
                  Apuracao.COFINS_PORC  := 0;
                  Salvar_Apuracao(varSPED[Y]);

               end;

               if (varSPED[Y].Split(['|'])[2].Trim = '06') Then
               begin
                    varSumAliq06 := varSumAliq06 + StrToFloat(varSPED[Y].Split(['|'])[4].Trim);
                    if (varSPED[Y].Split(['|'])[11].Trim = '0000411000') Then
                       varSumCTA06_0000411000 := varSumCTA06_0000411000 + StrToFloat(varSPED[Y].Split(['|'])[4].Trim)
                    else if  (varSPED[Y].Split(['|'])[11].Trim = '0000414005') Then
                     varSUMCTA06_0000414005 := varSUMCTA06_0000414005 + StrToFloat(varSPED[Y].Split(['|'])[4].Trim);
               end;

               if (varSPED[Y].Split(['|'])[2].Trim = '07') Then
               begin
                    varSumAliq07 := varSumAliq07 + StrToFloat(varSPED[Y].Split(['|'])[4].Trim);
                    if (varSPED[Y].Split(['|'])[11].Trim = '0000411000') Then
                       varSumCTA07_0000411000 := varSumCTA07_0000411000 + StrToFloat(varSPED[Y].Split(['|'])[4].Trim)
                    else if  (varSPED[Y].Split(['|'])[11].Trim = '0000414005') Then
                     varSUMCTA07_0000414005 := varSUMCTA07_0000414005 + StrToFloat(varSPED[Y].Split(['|'])[4].Trim);

               end;


               if (varSPED[Y].Split(['|'])[2].Trim = '08') Then
               begin
                    varSumAliq08 := varSumAliq08 + StrToFloat(varSPED[Y].Split(['|'])[4].Trim);

                    if (varSPED[Y].Split(['|'])[11].Trim = '0000411000') Then
                       varSumCTA08_0000411000 := varSumCTA08_0000411000 + StrToFloat(varSPED[Y].Split(['|'])[4].Trim)

                    else if  (varSPED[Y].Split(['|'])[11].Trim = '0000414005') Then
                     varSUMCTA08_0000414005 := varSUMCTA08_0000414005 + StrToFloat(varSPED[Y].Split(['|'])[4].Trim);

               end;

               if ((varSPED[Y].Split(['|'])[7].Trim = '1,6500') or (varSPED[Y].Split(['|'])[7].Trim = '1,65')) Then
               begin
                  if ((varSPED[Y].Split(['|'])[2].Trim = '01') or
                      (varSPED[Y].Split(['|'])[2].Trim = '51') or
                      (varSPED[Y].Split(['|'])[2].Trim = '02') or
                      (varSPED[Y].Split(['|'])[2].Trim = '52') or
                      (varSPED[Y].Split(['|'])[2].Trim = '31') or
                      (varSPED[Y].Split(['|'])[2].Trim = '32')) Then
                  begin
                    ValorSumProd210165 := ValorSumProd210165 +  StrToFloat(varSPED[Y].Split(['|'])[4].Trim);
                    ValorSum210165 := ValorSum210165 +  StrToFloat(varSPED[Y].Split(['|'])[10].Trim);
                  end;
               end
               else if ((varSPED[Y].Split(['|'])[7].Trim = '0,6500') or (varSPED[Y].Split(['|'])[7].Trim = '0,65')) Then
               begin
                  ValorSumProd210065 := ValorSumProd210065 +  StrToFloat(varSPED[Y].Split(['|'])[4].Trim);
                  ValorSum210065 := ValorSum210065 +  StrToFloat(varSPED[Y].Split(['|'])[10].Trim);
               end;
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 1 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

       //    C191/C195

          if (varSPED[Y].Split(['|'])[1].Trim  = 'C191')    then
          begin
            Try
              Apuracao.LimpaRecord;
              if (varSPED[Y].Split(['|'])[8].Trim  <> '0') then
              begin

                if varSPED[Y].Split(['|'])[8].Trim = '1,65' then
                  Apuracao.REGISTRO     := 'C191/C195A'
                else if  varSPED[Y].Split(['|'])[8].Trim = '0,65' then
                  Apuracao.REGISTRO     := 'C191/C195B'
                else if  varSPED[Y].Split(['|'])[8].Trim = '1' then
                  Apuracao.REGISTRO     := 'C191/C195C'
                else if  varSPED[Y].Split(['|'])[8].Trim = '2,1' then
                  Apuracao.REGISTRO     := 'C191/C195D';


                Apuracao.CST          := varSPED[Y].Split(['|'])[3].Trim;
                Apuracao.CNPJ         := CNPJ_SPED;
                Apuracao.PERIODO      := varPeriodo;

                Apuracao.VALOR_BASE   := StrToFloat(varSPED[Y].Split(['|'])[7].Trim);
                Apuracao.PIS_PORC     := StrToFloat(varSPED[Y].Split(['|'])[8].Trim);
                Apuracao.VALOR_PIS    := StrToFloat(varSPED[Y].Split(['|'])[11].Trim);
                Apuracao.VALOR_COFINS := 0;
                Apuracao.COFINS_PORC  := 0;

                Salvar_Apuracao(varSPED[Y]);
              end;
            except
            On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 2 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if (varSPED[Y].Split(['|'])[1].Trim  = 'C195')    then
          begin
            Try
              Apuracao.LimpaRecord;
              if (varSPED[Y].Split(['|'])[8].Trim  <> '0') then
              begin
                if varSPED[Y].Split(['|'])[8].Trim = '7,6' then
                  Apuracao.REGISTRO     := 'C191/C195A'
                else if  varSPED[Y].Split(['|'])[8].Trim = '3' then
                  Apuracao.REGISTRO     := 'C191/C195B'
                else if  varSPED[Y].Split(['|'])[8].Trim = '4,6' then
                  Apuracao.REGISTRO     := 'C191/C195C'
                else if  varSPED[Y].Split(['|'])[8].Trim = '9,65' then
                  Apuracao.REGISTRO     := 'C191/C195D';

                Apuracao.CST          := varSPED[Y].Split(['|'])[3].Trim;
                Apuracao.CNPJ         := CNPJ_SPED;
                Apuracao.PERIODO      := varPeriodo;

                Apuracao.VALOR_BASE   := StrToFloat(varSPED[Y].Split(['|'])[7].Trim);
                Apuracao.PIS_PORC     := 0;
                Apuracao.VALOR_PIS    := 0;
                Apuracao.VALOR_COFINS := StrToFloat(varSPED[Y].Split(['|'])[11].Trim);
                Apuracao.COFINS_PORC  := StrToFloat(varSPED[Y].Split(['|'])[8].Trim);

                Salvar_Apuracao(varSPED[Y]);
              end;
            except
            On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 3 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;


          if (varSPED[Y].Split(['|'])[1].Trim  = 'C505')    then
          begin
           Try
             Apuracao.LimpaRecord;
            if (varSPED[Y].Split(['|'])[2].Trim  = '56') Then
            begin
              Apuracao.REGISTRO     := 'C501/C505';
              Apuracao.CST          := varSPED[Y].Split(['|'])[2].Trim;
              Apuracao.CNPJ         := CNPJ_SPED;
              Apuracao.PERIODO      := varPeriodo;

              Apuracao.VALOR_BASE   := StrToFloat(varSPED[Y].Split(['|'])[5].Trim);
              Apuracao.PIS_PORC     := 0;
              Apuracao.VALOR_PIS    := 0;
              Apuracao.VALOR_COFINS := StrToFloat(varSPED[Y].Split(['|'])[7].Trim);
              Apuracao.COFINS_PORC  := StrToFloat(varSPED[Y].Split(['|'])[6].Trim);

              Salvar_Apuracao(varSPED[Y]);
            end;
           except
           On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 4 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;


          if (varSPED[Y].Split(['|'])[1].Trim  = 'C501')    then
          begin
           Try
            Apuracao.LimpaRecord;
            if (varSPED[Y].Split(['|'])[2].Trim  = '56') Then
            begin

              Apuracao.REGISTRO     := 'C501/C505';
              Apuracao.CST          := varSPED[Y].Split(['|'])[2].Trim;
              Apuracao.CNPJ         := CNPJ_SPED;
              Apuracao.PERIODO      := varPeriodo;
              Apuracao.VALOR_BASE   := StrToFloat(varSPED[Y].Split(['|'])[5].Trim);
              Apuracao.VALOR_PIS    := StrToFloat(varSPED[Y].Split(['|'])[7].Trim);
              Apuracao.PIS_PORC     := StrToFloat(varSPED[Y].Split(['|'])[6].Trim);
              Apuracao.VALOR_COFINS := 0;
              Apuracao.COFINS_PORC  := 0;

              Salvar_Apuracao(varSPED[Y]);
            end;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 5 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
           End;
          end;

          if (varSPED[Y].Split(['|'])[1].Trim  = 'D101')    then
          begin
           Try
             Apuracao.LimpaRecord;
            if (varSPED[Y].Split(['|'])[4].Trim  = '56') Then
            begin

              Apuracao.REGISTRO     := 'D101/D105';
              Apuracao.CST          := varSPED[Y].Split(['|'])[4].Trim;
              Apuracao.CNPJ         := CNPJ_SPED;
              Apuracao.PERIODO      := varPeriodo;

              Apuracao.VALOR_BASE   := StrToFloat(varSPED[Y].Split(['|'])[6].Trim);
              Apuracao.PIS_PORC     := StrToFloat(varSPED[Y].Split(['|'])[7].Trim);
              Apuracao.VALOR_PIS    := StrToFloat(varSPED[Y].Split(['|'])[8].Trim);


              Apuracao.VALOR_COFINS := 0;
              Apuracao.COFINS_PORC  := 0;

              Salvar_Apuracao(varSPED[Y]);
            end;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 6 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if (varSPED[Y].Split(['|'])[1].Trim  = 'D105')    then
          begin
          Try
             Apuracao.LimpaRecord;
            if (varSPED[Y].Split(['|'])[4].Trim  = '56') Then
            begin

              Apuracao.REGISTRO     := 'D101/D105';
              Apuracao.CST          := varSPED[Y].Split(['|'])[4].Trim;
              Apuracao.CNPJ         := CNPJ_SPED;
              Apuracao.PERIODO      := varPeriodo;

              Apuracao.VALOR_BASE   := StrToFloat(varSPED[Y].Split(['|'])[6].Trim);
              Apuracao.PIS_PORC     := 0;
              Apuracao.VALOR_PIS    := 0;

              Apuracao.COFINS_PORC  := StrToFloat(varSPED[Y].Split(['|'])[7].Trim);
              Apuracao.VALOR_COFINS := StrToFloat(varSPED[Y].Split(['|'])[8].Trim);


              Salvar_Apuracao(varSPED[Y]);
            end;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 7 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if (varSPED[Y].Split(['|'])[1].Trim  = 'F120')    then
          begin
           Try
            Apuracao.LimpaRecord;
            if (varSPED[Y].Split(['|'])[8].Trim  = '56') Then
            begin

              Apuracao.REGISTRO     := 'F120';
              Apuracao.CST          := varSPED[Y].Split(['|'])[8].Trim;
              Apuracao.CNPJ         := CNPJ_SPED;
              Apuracao.PERIODO      := varPeriodo;

              Apuracao.VALOR_BASE   := StrToFloat(varSPED[Y].Split(['|'])[9].Trim);
              Apuracao.PIS_PORC     := StrToFloat(varSPED[Y].Split(['|'])[10].Trim);
              Apuracao.VALOR_PIS    := StrToFloat(varSPED[Y].Split(['|'])[11].Trim);
              Apuracao.VALOR_COFINS := StrToFloat(varSPED[Y].Split(['|'])[15].Trim);
              Apuracao.COFINS_PORC  := StrToFloat(varSPED[Y].Split(['|'])[14].Trim);

              Salvar_Apuracao(varSPED[Y]);
            end;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 8 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;



          if ((varSPED[Y].Split(['|'])[1].Trim  = 'F100') and  (varSPED[Y].Split(['|'])[9].Trim = '0,65')) Then
          begin
           Try
             Apuracao.LimpaRecord;
             if varSPED[Y].Split(['|'])[7].Trim  <> '56' then
             begin
               varF100Pis065 := varF100Pis065 +  StrToFloat(varSPED[Y].Split(['|'])[10].Trim);
               varF100PisBase065 := varF100PisBase065 + StrToFloat(varSPED[Y].Split(['|'])[6].Trim);

             end;

              Apuracao.REGISTRO     := 'F100';
              Apuracao.CST          := varSPED[Y].Split(['|'])[7].Trim;
              Apuracao.CNPJ         := CNPJ_SPED;
              Apuracao.PERIODO      := varPeriodo;
              Apuracao.VALOR_BASE   := StrToFloat(varSPED[Y].Split(['|'])[6].Trim);
              Apuracao.PIS_PORC     := StrToFloat(varSPED[Y].Split(['|'])[9].Trim);
              Apuracao.VALOR_PIS    := StrToFloat(varSPED[Y].Split(['|'])[10].Trim);
              Apuracao.VALOR_COFINS := 0;
              Apuracao.COFINS_PORC  := 0;
               Salvar_Apuracao(varSPED[Y]);
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 9 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'F100') and (varSPED[Y].Split(['|'])[9].Trim = '1,65')) Then
          begin
          Try
             Apuracao.LimpaRecord;
             if varSPED[Y].Split(['|'])[7].Trim  <> '56' then
             begin
               varF100Pis165:= varF100Pis165 +  StrToFloat(varSPED[Y].Split(['|'])[10].Trim);
               varF100PisBase165 := varF100PisBase165   + StrToFloat(varSPED[Y].Split(['|'])[6].Trim);

             end;

              Apuracao.REGISTRO     := 'F100';
              Apuracao.CST          := varSPED[Y].Split(['|'])[7].Trim;
              Apuracao.CNPJ         := CNPJ_SPED;
              Apuracao.PERIODO      := varPeriodo;
              Apuracao.VALOR_BASE   := StrToFloat(varSPED[Y].Split(['|'])[6].Trim);
              Apuracao.PIS_PORC     := StrToFloat(varSPED[Y].Split(['|'])[9].Trim);
              Apuracao.VALOR_PIS    := StrToFloat(varSPED[Y].Split(['|'])[10].Trim);
              Apuracao.VALOR_COFINS := 0;
              Apuracao.COFINS_PORC  := 0;
              Salvar_Apuracao(varSPED[Y]);
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 10 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'F100') and (varSPED[Y].Split(['|'])[13].Trim = '4')) Then
          begin
           Try
             Apuracao.LimpaRecord;
             if varSPED[Y].Split(['|'])[7].Trim  <> '56' then
             begin
               varF100Cofins400 := varF100Cofins400 +  StrToFloat(varSPED[Y].Split(['|'])[14].Trim);
               varF100CofinsBase400 := varF100CofinsBase400 + StrToFloat(varSPED[Y].Split(['|'])[6].Trim);

             end;

              Apuracao.REGISTRO     := 'F100';
              Apuracao.CST          := varSPED[Y].Split(['|'])[7].Trim;
              Apuracao.CNPJ         := CNPJ_SPED;
              Apuracao.PERIODO      := varPeriodo;
              Apuracao.VALOR_BASE   := StrToFloat(varSPED[Y].Split(['|'])[6].Trim);
              Apuracao.PIS_PORC     := 0;
              Apuracao.VALOR_PIS    := 0;
              Apuracao.VALOR_COFINS := StrToFloat(varSPED[Y].Split(['|'])[14].Trim);
              Apuracao.COFINS_PORC  := StrToFloat(varSPED[Y].Split(['|'])[13].Trim);
                 Salvar_Apuracao(varSPED[Y]);
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 11 ' + varSPED[Y] + '-' +   E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'F100')and (varSPED[Y].Split(['|'])[13].Trim = '7,6')) Then
          begin
           Try
             Apuracao.LimpaRecord;
             if varSPED[Y].Split(['|'])[7].Trim  <> '56' then
             begin
               varF100Cofins076 := varF100Cofins076 +  StrToFloat(varSPED[Y].Split(['|'])[14].Trim);
               varF100CofinsBase076 := varF100CofinsBase076 +  StrToFloat(varSPED[Y].Split(['|'])[6].Trim);

             end;

              Apuracao.REGISTRO     := 'F100';
              Apuracao.CST          := varSPED[Y].Split(['|'])[7].Trim;
              Apuracao.CNPJ         := CNPJ_SPED;
              Apuracao.PERIODO      := varPeriodo;
              Apuracao.VALOR_BASE   := StrToFloat(varSPED[Y].Split(['|'])[6].Trim);
              Apuracao.PIS_PORC     := 0;
              Apuracao.VALOR_PIS    := 0;
              Apuracao.VALOR_COFINS := StrToFloat(varSPED[Y].Split(['|'])[14].Trim);
              Apuracao.COFINS_PORC  := StrToFloat(varSPED[Y].Split(['|'])[13].Trim);
               Salvar_Apuracao(varSPED[Y]);
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 12 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'A170') and (varSPED[Y].Split(['|'])[11].Trim = '1,65')) Then
          begin
            Try
            Apuracao.LimpaRecord;
            if varSPED[Y].Split(['|'])[9].Trim <> '56' then
            begin
              varA170Pis  := varA170Pis +   StrToFloat(varSPED[Y].Split(['|'])[12].Trim);
              varBaseA170165 := varBaseA170165 +   StrToFloat(varSPED[Y].Split(['|'])[5].Trim);

            end;

            Apuracao.REGISTRO     := 'A170';
            Apuracao.CST          := varSPED[Y].Split(['|'])[9].Trim;
            Apuracao.CNPJ         := CNPJ_SPED;
            Apuracao.PERIODO      := varPeriodo;
            Apuracao.VALOR_BASE   := StrToFloat(varSPED[Y].Split(['|'])[5].Trim);
            Apuracao.PIS_PORC     := StrToFloat(varSPED[Y].Split(['|'])[11].Trim);
            Apuracao.VALOR_PIS    := StrToFloat(varSPED[Y].Split(['|'])[12].Trim);
            Apuracao.VALOR_COFINS := 0;
            Apuracao.COFINS_PORC  := 0;
            Salvar_Apuracao(varSPED[Y]);

             except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 13 ' + varSPED[Y] + '-' +   E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'A170') and (varSPED[Y].Split(['|'])[15].Trim = '7,6')) Then
          begin
           Try
              Apuracao.LimpaRecord;
              if varSPED[Y].Split(['|'])[13].Trim <> '56' then
              begin
                varA170Cofins  := varA170Cofins +   StrToFloat(varSPED[Y].Split(['|'])[16].Trim);
                varBaseA170076 := varBaseA170076  +   StrToFloat(varSPED[Y].Split(['|'])[5].Trim);

              end;

              Apuracao.REGISTRO     := 'A170';
              Apuracao.CST          := varSPED[Y].Split(['|'])[13].Trim;
              Apuracao.CNPJ         := CNPJ_SPED;
              Apuracao.PERIODO      := varPeriodo;
              Apuracao.VALOR_BASE   := StrToFloat(varSPED[Y].Split(['|'])[5].Trim);
              Apuracao.PIS_PORC     := 0;
              Apuracao.VALOR_PIS    := 0;
              Apuracao.VALOR_COFINS := StrToFloat(varSPED[Y].Split(['|'])[16].Trim);
              Apuracao.COFINS_PORC  := StrToFloat(varSPED[Y].Split(['|'])[15].Trim);
                Salvar_Apuracao(varSPED[Y]);
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 14 ' +  varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if varSPED[Y].Split(['|'])[1].Trim  = 'C191' Then
          begin
             varSumC191 := varSumC191 + StrToFloat(varSPED[Y].Split(['|'])[11].Trim);
          end;

          if varSPED[Y].Split(['|'])[1].Trim  = 'D101' Then
          begin
             varSumD101 := varSumD101 +  StrToFloat(varSPED[Y].Split(['|'])[8].Trim);
          end;

          if varSPED[Y].Split(['|'])[1].Trim  = 'M110' Then
          begin
           Try
             varSumM110 := varSumM110 +   StrToFloat(varSPED[Y].Split(['|'])[3].Trim);
             Apuracao.LimpaRecord;
             Apuracao.REGISTRO     := 'M110/M510';
             Apuracao.CST          := '';
             Apuracao.CNPJ         := CNPJ_SPED;
             Apuracao.PERIODO      := varPeriodo;
             Apuracao.VALOR_BASE   := 0; // NAO SEI
             Apuracao.PIS_PORC     := 1.65;
             Apuracao.VALOR_PIS    := StrToFloat(varSPED[Y].Split(['|'])[3].Trim);
             Apuracao.VALOR_COFINS := 0;
             Apuracao.COFINS_PORC  := 0;
             Salvar_Apuracao(varSPED[Y]);
             except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 15 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if varSPED[Y].Split(['|'])[1].Trim  = 'C185' Then
          begin
           Try
             Inc(varConta185);
             if ((varSPED[Y].Split(['|'])[2].Trim = '01') or (varSPED[Y].Split(['|'])[2].Trim = '02')) then
             begin
                if  (Copy(varSPED[Y].Split(['|'])[3].Trim,1,1) = '5') or (Copy(varSPED[Y].Split(['|'])[3].Trim,1,1) = '6')  then
                begin
                 varValorDefault := 0.0;

                 if TryStrToFloat(varSPED[Y].Split(['|'])[10].Trim, varValorDefault) Then
                   varSumCofins     := varSumCofins     +  StrToFloat(varSPED[Y].Split(['|'])[10].Trim)
                 else   varSumCofins     := varSumCofins     +   varValorDefault;

                end;
             end;

             if ((varSPED[Y].Split(['|'])[7].Trim = '3,0000') or  (varSPED[Y].Split(['|'])[7].Trim = '3'))  Then
             begin
                varValorDefault := 0.0;
                if   TryStrToFloat(varSPED[Y].Split(['|'])[4].Trim,varValorDefault) then
                      ValorSumProd610300 := ValorSumProd610300 + StrToFloat(varSPED[Y].Split(['|'])[4].Trim)
                else  ValorSumProd610300 := ValorSumProd610300 + varValorDefault;

                varValorDefault := 0.0;
                if  TryStrToFloat(varSPED[Y].Split(['|'])[10].Trim,varValorDefault) then
                     ValorSum610300 := ValorSum610300 + StrToFloat(varSPED[Y].Split(['|'])[10].Trim)
                else ValorSum610300 := ValorSum610300 + varValorDefault
             end
             else if ((varSPED[Y].Split(['|'])[7].Trim = '7,6000') or (varSPED[Y].Split(['|'])[7].Trim = '7,6')) Then
             begin
                varValorDefault := 0.0;
                if  TryStrToFloat(varSPED[Y].Split(['|'])[4].Trim,varValorDefault) then
                 ValorSumProd610760 := ValorSumProd610760 +  StrToFloat(varSPED[Y].Split(['|'])[4].Trim)
                else ValorSumProd610760 := ValorSumProd610760 +  varValorDefault;

                varValorDefault := 0.0;
                if TryStrToFloat(varSPED[Y].Split(['|'])[10].Trim,varValorDefault) then
                  ValorSum610760 := ValorSum610760 +  StrToFloat(varSPED[Y].Split(['|'])[10].Trim)
                else  ValorSum610760 := ValorSum610760 +   varValorDefault;
             end;

              Apuracao.LimpaRecord;
              Apuracao.REGISTRO     := 'C181/C185';
              Apuracao.CST          := varSPED[Y].Split(['|'])[2].Trim;

              Apuracao.CNPJ         := CNPJ_SPED;
              Apuracao.PERIODO      := varPeriodo;
              varValorDefault := 0.0;
              if TryStrToFloat(varSPED[Y].Split(['|'])[4].Trim,varValorDefault) then
                Apuracao.VALOR_BASE   :=StrToFloat(varSPED[Y].Split(['|'])[4].Trim)
              else  Apuracao.VALOR_BASE := varValorDefault;


              Apuracao.PIS_PORC     := 0;
              Apuracao.VALOR_PIS    := 0;
              varValorDefault := 0.0;
              if  TryStrToFloat(varSPED[Y].Split(['|'])[10].Trim,varValorDefault) then
                Apuracao.VALOR_COFINS :=  StrToFloat(varSPED[Y].Split(['|'])[10].Trim)
              else  Apuracao.VALOR_COFINS := varValorDefault;


              varValorDefault := 0.0;
              if TryStrToFloat(varSPED[Y].Split(['|'])[7].Trim,varValorDefault) then
                Apuracao.COFINS_PORC  := StrToFloat(varSPED[Y].Split(['|'])[7].Trim)
              else  Apuracao.COFINS_PORC  := varValorDefault;

              Salvar_Apuracao(varSPED[Y]);
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 16 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if varSPED[Y].Split(['|'])[1].Trim  = 'C195' Then
          begin
              varSumC195 := varSumC195 + StrToFloat(varSPED[Y].Split(['|'])[11].Trim);
          end;

          if varSPED[Y].Split(['|'])[1].Trim  = 'D105' Then
          begin
              varSumD105 := varSumD105 +  StrToFloat(varSPED[Y].Split(['|'])[8].Trim);
          end;

          if varSPED[Y].Split(['|'])[1].Trim  = 'M510' Then
          begin
           Try
              VarSumM510 := VarSumM510 +   StrToFloat(varSPED[Y].Split(['|'])[3].Trim);
              Apuracao.LimpaRecord;
              Apuracao.REGISTRO     := 'M110/M510';
              Apuracao.CST          := '';
              Apuracao.CNPJ         := CNPJ_SPED;
              Apuracao.PERIODO      := varPeriodo;
              Apuracao.VALOR_BASE   := 0; // NAO SEI
              Apuracao.PIS_PORC     := 0;
              Apuracao.VALOR_PIS    := 0;
              Apuracao.VALOR_COFINS := StrToFloat(varSPED[Y].Split(['|'])[3].Trim);
              Apuracao.COFINS_PORC  := 7.60;
              Salvar_Apuracao(varSPED[Y]);
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 17 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if varSPED[Y].Split(['|'])[1].Trim  = 'M200' Then
          begin
           Try
              varSumPIS := ValorSum210165 + ValorSum210065 + varA170Pis + varF100Pis065 + varF100Pis165;
              varValorPisOriginal    := StrToFloat(varSPED[Y].Split(['|'])[5].Trim);

              varTotalEntradaPIS := StrToFloat(varSPED[Y].Split(['|'])[3].Trim);
              varM200[0]  := varSPED[Y].Split(['|'])[1].Trim;    //|M200
              varM200[1]  := StrTran(FloatToStrF(varSumPIS, ffGeneral, 12,2),'.','');
              varM200[2]  := varSPED[Y].Split(['|'])[3].Trim;
              varM200[3]  := varSPED[Y].Split(['|'])[4].Trim;
              varM200[4]  := StrTran(FloatToStrF(varSumPIS - varTotalEntradaPIS, ffGeneral, 12, 2),'.','');
              varM200[5]  := varSPED[Y].Split(['|'])[6].Trim;
              varM200[6]  := varSPED[Y].Split(['|'])[7].Trim;
              varM200[7]  := StrTran(FloatToStrF(varSumPIS - varTotalEntradaPIS, ffGeneral, 12, 2),'.','');
              varM200[8]  := varSPED[Y].Split(['|'])[9].Trim;
              varM200[9]  := varSPED[Y].Split(['|'])[10].Trim;
              varM200[10] := varSPED[Y].Split(['|'])[11].Trim;
              varM200[11] := varSPED[Y].Split(['|'])[12].Trim;
              varM200[12] := StrTran(FloatToStrF(varSumPIS - varTotalEntradaPIS, ffGeneral, 12, 2),'.','');

              varSPED[Y]  := '|';
              for W := Low(varM200) to High(varM200) do
              begin
                varSPED[Y] := varSPED[Y] + varM200[W].Trim + '|';
              end;
             except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 18 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if varSPED[Y].Split(['|'])[1].Trim  = 'M205' Then
          begin
           Try
              varM205[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM205[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM205[2] := varSPED[Y].Split(['|'])[3].Trim;
              varM205[3] := StrTran(FloatToStrF(varSumPIS - varTotalEntradaPIS, ffGeneral, 12, 2),'.','');
              varSPED[Y]  := '|';
              for W := Low(varM205) to High(varM205) do
              begin
               varSPED[Y] := varSPED[Y] + varM205[W].Trim + '|';
              end;
           except
           On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 19 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M210') and (varSPED[Y].Split(['|'])[5].Trim  = '1,65'))  Then
          begin
           Try
              ValorSumProd210165 := ValorSumProd210165 +   varF100PisBase165 + varBaseA170165;

              varM210165[0]  := varSPED[Y].Split(['|'])[1].Trim;
              varM210165[1]  := varSPED[Y].Split(['|'])[2].Trim;
              varM210165[2]  := StrTran(FloatToStrF(ValorSumProd210165, ffGeneral, 12, 2),'.','');
              varM210165[3]  := StrTran(FloatToStrF(ValorSumProd210165, ffGeneral, 12, 2),'.','');
              varM210165[4]  := varSPED[Y].Split(['|'])[5].Trim;
              varM210165[5]  := varSPED[Y].Split(['|'])[6].Trim;
              varM210165[6]  := varSPED[Y].Split(['|'])[7].Trim;
              varM210165[7]  := StrTran(FloatToStrF(ValorSum210165 + varA170Pis +  varF100Pis165 , ffGeneral, 12, 2),'.','');
              varM210165[8]  := varSPED[Y].Split(['|'])[9].Trim;
              varM210165[9]  := varSPED[Y].Split(['|'])[10].Trim;
              varM210165[10] := varSPED[Y].Split(['|'])[11].Trim;
              varM210165[11] := varSPED[Y].Split(['|'])[12].Trim;
              varM210165[12] := StrTran(FloatToStrF(ValorSum210165 +  varA170Pis + varF100Pis165 , ffGeneral, 12, 2),'.','');

              varSPED[Y]  := '|';
              for W := Low(varM210165) to High(varM210165) do
              begin
               varSPED[Y] := varSPED[Y] + varM210165[W].Trim + '|';
              end;
           except
           On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 20 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M210') and (varSPED[Y].Split(['|'])[5].Trim  = '0,65'))  Then
          begin
            Try
              ValorSumProd210065 := ValorSumProd210065 +   varF100PisBase065;

              varM210065[0]  := varSPED[Y].Split(['|'])[1].Trim;
              varM210065[1]  := varSPED[Y].Split(['|'])[2].Trim;
              varM210065[2]  := StrTran(FloatToStrF(ValorSumProd210065, ffGeneral, 12, 2),'.','');
              varM210065[3]  := StrTran(FloatToStrF(ValorSumProd210065, ffGeneral, 12, 2),'.','');
              varM210065[4]  := varSPED[Y].Split(['|'])[5].Trim;
              varM210065[5]  := varSPED[Y].Split(['|'])[6].Trim;
              varM210065[6]  := varSPED[Y].Split(['|'])[7].Trim;
              varM210065[7]  := StrTran(FloatToStrF(ValorSum210065 +   varF100Pis065 , ffGeneral, 12, 2),'.','');
              varM210065[8]  := varSPED[Y].Split(['|'])[9].Trim;
              varM210065[9]  := varSPED[Y].Split(['|'])[10].Trim;
              varM210065[10] := varSPED[Y].Split(['|'])[11].Trim;
              varM210065[11] := varSPED[Y].Split(['|'])[12].Trim;
              varM210065[12] := StrTran(FloatToStrF(ValorSum210065 +  varF100Pis065 , ffGeneral, 12, 2),'.','');

              varSPED[Y]  := '|';
              for W := Low(varM210065) to High(varM210065) do
              begin
                varSPED[Y] := varSPED[Y] + varM210065[W].Trim + '|';
              end;
            except
            On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 21 ' +  varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

           if ((varSPED[Y].Split(['|'])[1].Trim  = 'M610') and (varSPED[Y].Split(['|'])[5].Trim  = '4'))  Then
          begin
           Try
              ValorSumProd210065 :=  varF100CofinsBase400;

              varM610400[0]  := varSPED[Y].Split(['|'])[1].Trim;
              varM610400[1]  := varSPED[Y].Split(['|'])[2].Trim;
              varM610400[2]  := StrTran(FloatToStrF(ValorSumProd210065, ffGeneral, 12, 2),'.','');
              varM610400[3]  := StrTran(FloatToStrF(ValorSumProd210065, ffGeneral, 12, 2),'.','');
              varM610400[4]  := varSPED[Y].Split(['|'])[5].Trim;
              varM610400[5]  := varSPED[Y].Split(['|'])[6].Trim;
              varM610400[6]  := varSPED[Y].Split(['|'])[7].Trim;
              varM610400[7]  := StrTran(FloatToStrF(varF100Cofins400, ffGeneral, 12, 2),'.','');
              varM610400[8]  := varSPED[Y].Split(['|'])[9].Trim;
              varM610400[9]  := varSPED[Y].Split(['|'])[10].Trim;
              varM610400[10] := varSPED[Y].Split(['|'])[11].Trim;
              varM610400[11] := varSPED[Y].Split(['|'])[12].Trim;
              varM610400[12] := StrTran(FloatToStrF(varF100Cofins400, ffGeneral, 12, 2),'.','');

              varSPED[Y]  := '|';
              for W := Low(varM610400) to High(varM610400) do
              begin
                varSPED[Y] := varSPED[Y] + varM610400[W].Trim + '|';
              end;
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 22 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;


          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M610') and (varSPED[Y].Split(['|'])[5].Trim  = '3'))  Then
          begin
          try
              varM610300[0]  := varSPED[Y].Split(['|'])[1].Trim;
              varM610300[1]  := varSPED[Y].Split(['|'])[2].Trim;
              varM610300[2]  := StrTran(FloatToStrF(ValorSumProd610300, ffGeneral, 12, 2),'.','');
              varM610300[3]  := StrTran(FloatToStrF(ValorSumProd610300, ffGeneral, 12, 2),'.','');
              varM610300[4]  := varSPED[Y].Split(['|'])[5].Trim;
              varM610300[5]  := varSPED[Y].Split(['|'])[6].Trim;
              varM610300[6]  := varSPED[Y].Split(['|'])[7].Trim;
              varM610300[7]  := StrTran(FloatToStrF(ValorSum610300, ffGeneral, 12, 2),'.','');
              varM610300[8]  := varSPED[Y].Split(['|'])[9].Trim;
              varM610300[9]  := varSPED[Y].Split(['|'])[10].Trim;
              varM610300[10] := varSPED[Y].Split(['|'])[11].Trim;
              varM610300[11] := varSPED[Y].Split(['|'])[12].Trim;
              varM610300[12] := StrTran(FloatToStrF(ValorSum610300, ffGeneral, 12, 2),'.','');

              varSPED[Y]  := '|';
              for W := Low(varM610300) to High(varM610300) do
              begin
                varSPED[Y] := varSPED[Y] + varM610300[W].Trim + '|';
              end;
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 23 ' + varSPED[Y] + '-' +   E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M610') and (varSPED[Y].Split(['|'])[5].Trim  = '7,6'))  Then
          begin
           try
              ValorSumProd610760 := ValorSumProd610760 +   varF100CofinsBase076 + varBaseA170076;

              varM610760[0]  := varSPED[Y].Split(['|'])[1].Trim;
              varM610760[1]  := varSPED[Y].Split(['|'])[2].Trim;
              varM610760[2]  := StrTran(FloatToStrF(ValorSumProd610760, ffGeneral, 12, 2),'.','');
              varM610760[3]  := StrTran(FloatToStrF(ValorSumProd610760, ffGeneral, 12, 2),'.','');
              varM610760[4]  := varSPED[Y].Split(['|'])[5].Trim;
              varM610760[5]  := varSPED[Y].Split(['|'])[6].Trim;
              varM610760[6]  := varSPED[Y].Split(['|'])[7].Trim;
              varM610760[7]  := StrTran(FloatToStrF(ValorSum610760 + varA170Cofins + varF100Cofins076 , ffGeneral, 12, 2),'.','');
              varM610760[8]  := varSPED[Y].Split(['|'])[9].Trim;
              varM610760[9]  := varSPED[Y].Split(['|'])[10].Trim;
              varM610760[10] := varSPED[Y].Split(['|'])[11].Trim;
              varM610760[11] := varSPED[Y].Split(['|'])[12].Trim;
              varM610760[12] := StrTran(FloatToStrF(ValorSum610760 + varA170Cofins + varF100Cofins076 , ffGeneral, 12, 2),'.','');

              varSPED[Y]  := '|';
              for W := Low(varM610760) to High(varM610760) do
              begin
                varSPED[Y] := varSPED[Y] + varM610760[W].Trim + '|';
              end;
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 24 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          //M400
          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M400') and (varSPED[Y].Split(['|'])[2].Trim  = '06') and (varSumAliq06 > 0)) Then
          begin
           try
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSumAliq06, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;
              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 25 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M410') and (varSPED[Y].Split(['|'])[4].Trim  = '0000411000') and (bPassouM4001 = False) and (varSumCTA06_0000411000 > 0)) Then
          begin
           try
              bPassouM4001 := True;
              Inc(varM410Count);
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSumCTA06_0000411000, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;

              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;

              Continue;
             except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 26 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M410') and (varSPED[Y].Split(['|'])[4].Trim  = '0000414005') and (bPassouM4002 = False) and (varSUMCTA06_0000414005 > 0) ) Then
          begin
          try
              bPassouM4002 := True;
              Inc(varM410Count);
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSUMCTA06_0000414005, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;

              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;

              Continue;
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 27 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;


          //M400
          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M400') and (varSPED[Y].Split(['|'])[2].Trim  = '07') and (varSumAliq07 > 0)) Then
          begin
            try
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSumAliq07, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;
              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 28 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M410') and (varSPED[Y].Split(['|'])[4].Trim  = '0000411000') and (bPassouM4005 = False) and (varSumCTA07_0000411000 > 0) ) Then
          begin
           try
              bPassouM4005 := True;
              Inc(varM410Count);
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSumCTA07_0000411000, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;

              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;

              Continue;
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 29 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M410') and (varSPED[Y].Split(['|'])[4].Trim  = '0000414005') and (bPassouM4006 = False) and (varSUMCTA07_0000414005 > 0) ) Then
          begin
           try
              bPassouM4006 := True;
              Inc(varM410Count);
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSUMCTA07_0000414005, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;

              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;

              Continue;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 30 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;


          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M400') and (varSPED[Y].Split(['|'])[2].Trim  = '08') and (varSumAliq08 > 0)) Then
          begin
           try
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSumAliq08, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;

              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 31 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M410') and (varSPED[Y].Split(['|'])[4].Trim  = '0000411000') and (bPassouM4003 = False) and(varSumCTA08_0000411000 > 0) ) Then
          begin
           try
              bPassouM4003 := True;
              Inc(varM410Count);
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSumCTA08_0000411000, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;

              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;

              Continue;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 32 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M410') and (varSPED[Y].Split(['|'])[4].Trim  = '0000414005') and (bPassouM4004 = False) and (varSUMCTA08_0000414005 > 0) ) Then
          begin
           try
              bPassouM4004 := True;
              Inc(varM410Count);
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSUMCTA08_0000414005, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;

              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;

              Continue;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 33 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;


          //M800
          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M800') and (varSPED[Y].Split(['|'])[2].Trim  = '06') and ( varSumAliq06 > 0)) Then
          begin
            try
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSumAliq06, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;
              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 34 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M810') and (varSPED[Y].Split(['|'])[4].Trim  = '0000411000') and (bPassouM8001 = False) and ( varSumCTA06_0000411000 > 0) ) Then
          begin
           try
              bPassouM8001 := True;
              Inc(varM810Count);
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSumCTA06_0000411000, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;

              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;

              Continue;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 35 ' + varSPED[Y] + '-' +   E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M810') and (varSPED[Y].Split(['|'])[4].Trim  = '0000414005') and (bPassouM8002 = False) and ( varSUMCTA06_0000414005 > 0) ) Then
          begin
            try
              bPassouM8002 := True;
              Inc(varM810Count);
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSUMCTA06_0000414005, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;

              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;

              Continue;
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 36 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

         //M800
          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M800') and (varSPED[Y].Split(['|'])[2].Trim  = '07') and ( varSumAliq07 > 0) ) Then
          begin
           try
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSumAliq07, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;
              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 37 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M810') and (varSPED[Y].Split(['|'])[4].Trim  = '0000411000') and (bPassouM8005 = False) and (varSumCTA07_0000411000 > 0)) Then
          begin
            try
              bPassouM8005 := True;
              Inc(varM810Count);
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSumCTA07_0000411000, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;

              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;

              Continue;
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 38 ' + varSPED[Y] + '-' +   E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M810') and (varSPED[Y].Split(['|'])[4].Trim  = '0000414005') and (bPassouM8006 = False) and (varSUMCTA07_0000414005 > 0)) Then
          begin
           try
              bPassouM8006 := True;
              Inc(varM810Count);
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSUMCTA07_0000414005, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;

              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;

              Continue;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 39 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;


          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M800') and (varSPED[Y].Split(['|'])[2].Trim  = '08') and (varSumAliq08 > 0)) Then
          begin
           try
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSumAliq08, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;

              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 40 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M810') and (varSPED[Y].Split(['|'])[4].Trim  = '0000411000') and (bPassouM8003 = False) and (varSumCTA08_0000411000 > 0)) Then
          begin
            try
              bPassouM8003 := True;
              Inc(varM810Count);
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSumCTA08_0000411000, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;

              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;

              Continue;
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 41 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = 'M810') and (varSPED[Y].Split(['|'])[4].Trim  = '0000414005') and (bPassouM8004 = False) and (varSUMCTA08_0000414005 > 0) ) Then
          begin
            try
              bPassouM8004 := True;
              Inc(varM810Count);
              varM400_800[0] := varSPED[Y].Split(['|'])[1].Trim;
              varM400_800[1] := varSPED[Y].Split(['|'])[2].Trim;
              varM400_800[2] := StrTran(FloatToStrF(varSUMCTA08_0000414005, ffGeneral, 12, 2),'.','');
              varM400_800[3] := varSPED[Y].Split(['|'])[4].Trim;
              varM400_800[4] := varSPED[Y].Split(['|'])[5].Trim;

              varSPED[Y]  := '|';
              for W := Low(varM400_800) to High(varM400_800) do
              begin
                varSPED[Y] := varSPED[Y] + varM400_800[W].Trim + '|';
              end;

              Continue;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 42 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if varSPED[Y].Split(['|'])[1].Trim  = 'M600' Then
          begin
            try
              varValorCofinsOriginal := StrToFloat(varSPED[Y].Split(['|'])[5].Trim);

              varTotalEntradaCOFINS  := StrToFloat(varSPED[Y].Split(['|'])[3].Trim);
              varSumCofins := ValorSum610300 +
                              ValorSum610760 +
                              varF100Cofins400 +
                              varF100Cofins076 +
                             varA170Cofins;

              varM600[0]  := varSPED[Y].Split(['|'])[1].Trim;
              varM600[1]  := StrTran(FloatToStrF(varSumCofins, ffNumber, 12, 2),'.','');
              varM600[2]  := varSPED[Y].Split(['|'])[3].Trim;
              varM600[3]  := varSPED[Y].Split(['|'])[4].Trim;
              varM600[4]  := StrTran(FloatToStrF(varSumCofins - varTotalEntradaCOFINS, ffGeneral, 12, 2),'.','');
              varM600[5]  := varSPED[Y].Split(['|'])[6].Trim;
              varM600[6]  := varSPED[Y].Split(['|'])[7].Trim;
              varM600[7]  := StrTran(FloatToStrF(varSumCofins - varTotalEntradaCOFINS, ffGeneral, 12, 2),'.','');
              varM600[8]  := varSPED[Y].Split(['|'])[9].Trim;
              varM600[9]  := varSPED[Y].Split(['|'])[10].Trim;
              varM600[10] := varSPED[Y].Split(['|'])[11].Trim;
              varM600[11] := varSPED[Y].Split(['|'])[12].Trim;
              varM600[12] := StrTran(FloatToStrF(varSumCofins - varTotalEntradaCOFINS, ffGeneral, 12, 2),'.','');

              varSPED[Y]  := '|';
              for W := Low(varM600) to High(varM600) do
              begin
                varSPED[Y] := varSPED[Y] + varM600[W].Trim + '|';
              end;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 43 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if varSPED[Y].Split(['|'])[1].Trim  = 'M605' Then
          begin
            try
              varM605[0] :=  varSPED[Y].Split(['|'])[1].Trim;
              varM605[1] :=  varSPED[Y].Split(['|'])[2].Trim;
              varM605[2] :=  varSPED[Y].Split(['|'])[3].Trim;
              varM605[3] :=  StrTran(FloatToStrF(varSumCofins - varTotalEntradaCOFINS, ffGeneral, 12, 2),'.','');

              varSPED[Y] :=  '|';
              for W := Low(varM605) to High(varM605) do
              begin
               varSPED[Y] := varSPED[Y] + varM605[W].Trim + '|';
              end;
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 44 ' +  varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = '9900') and  (varSPED[Y].Split(['|'])[2].Trim  = 'C181')) Then
          begin
            try
              varNovoC18[0]  := varSPED[Y].Split(['|'])[1].Trim;
              varNovoC18[1]  := varSPED[Y].Split(['|'])[2].Trim;
              varNovoC18[2]   :=    IntToStr(varConta181);

              varSPED[Y]  := '|';
              for W := Low(varNovoC18) to High(varNovoC18) do
              begin
                varSPED[Y] := varSPED[Y] + varNovoC18[W] + '|';
              end;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 45 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = '9900') and  (varSPED[Y].Split(['|'])[2].Trim  = 'C185')) Then
          begin
           try
             varNovoC18[0]  := varSPED[Y].Split(['|'])[1].Trim;
              varNovoC18[1]  := varSPED[Y].Split(['|'])[2].Trim;
              varNovoC18[2]  := IntToStr(varConta185);

              varSPED[Y]  := '|';
              for W := Low(varNovoC18) to High(varNovoC18) do
              begin
                varSPED[Y] := varSPED[Y] + varNovoC18[W] + '|';
              end;
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 46 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = '9900') and  (varSPED[Y].Split(['|'])[2].Trim  = 'M410')) Then
          begin
           try
              varNovoM410[0]  := varSPED[Y].Split(['|'])[1].Trim;
              varNovoM410[1]  := varSPED[Y].Split(['|'])[2].Trim;
              varNovoM410[2]  := IntToStr(varM410Count);

              varSPED[Y]  := '|';
              for W := Low(varNovoM410) to High(varNovoM410) do
              begin
                varSPED[Y] := varSPED[Y] + varNovoM410[W] + '|';
              end;
          except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 47 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if ((varSPED[Y].Split(['|'])[1].Trim  = '9900') and  (varSPED[Y].Split(['|'])[2].Trim  = 'M810')) Then
          begin
           try
              varNovoM410[0]  := varSPED[Y].Split(['|'])[1].Trim;
              varNovoM410[1]  := varSPED[Y].Split(['|'])[2].Trim;
              varNovoM410[2]  := IntToStr(varM810Count);

              varSPED[Y]  := '|';
              for W := Low(varNovoM410) to High(varNovoM410) do
              begin
                varSPED[Y] := varSPED[Y] + varNovoM410[W] + '|';
              end;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 48 ' + varSPED[Y] + '-' +   E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;


          if Copy(varSPED[Y].Split(['|'])[1].Trim,1,1) = 'C'  then
             Inc(varContaC);

          if (varSPED[Y].Split(['|'])[1].Trim  = 'C990') Then
          begin
            try
             varRecalcular[0] :=  varSPED[Y].Split(['|'])[1].Trim;
             varRecalcular[1] :=  IntToStr(varContaC);

             varSPED[Y] := '|';
             for W := Low(varRecalcular) to High(varRecalcular) do
             begin
                varSPED[Y] := varSPED[Y] + varRecalcular[W] + '|';
             end;
           except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 49 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;

          if (varSPED[Y].Split(['|'])[1].Trim  = '9999') Then
          begin
            try
             varRecalcular[0] :=  varSPED[Y].Split(['|'])[1].Trim;
             varRecalcular[1] :=  IntToStr(varSPED.Count);

             varSPED[Y] := '|';
             for W := Low(varRecalcular) to High(varRecalcular) do
             begin
                varSPED[Y] := varSPED[Y] + varRecalcular[W] + '|';
             end;
            except
              On E:Exception do
              begin
                Application.MessageBox(pWideChar('Erro 50 ' + varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
            End;
          end;
       end;

       with DB_Conect do
       begin

          sqlAuxiliar.Close;
          sqlAuxiliar.SQL.Clear;
          sqlAuxiliar.SQL.Add('Insert Into ARQ_APURACAO_ORIGINAL (CNPJ, PERIODO, VALOR_PIS, VALOR_COFINS) ');
          sqlAuxiliar.SQL.Add(' Values (:CNPJ, :PERIODO, :VALOR_PIS, :VALOR_COFINS)');
          sqlAuxiliar.Params.ParamByName('CNPJ').AsString         :=  CNPJ_SPED;
          sqlAuxiliar.Params.ParamByName('PERIODO').AsString      :=  varPeriodo;
          sqlAuxiliar.Params.ParamByName('VALOR_PIS').AsFloat     :=  varValorPisOriginal;
          sqlAuxiliar.Params.ParamByName('VALOR_COFINS').AsFloat  :=  varValorCofinsOriginal;
          Try
            sqlAuxiliar.ExecSQL;
          except
            On E:Exception do
              begin
                Application.MessageBox(pWideChar( 'Falha ao Inserir (ARQ_APURACAO_ORIGINAL) ' +  varSPED[Y] + '-' +  E.Message), 'SPED', mb_iconError+  MB_OK);
              end;
          end;

       end;


       varArquivo := editSalvarSped.Text + '\' + 'SPED_' + CNPJ_SPED + '_' +  varPeriodo + '.txt';

       varSPED.SaveToFile(varArquivo);

   //    varLista.SaveToFile(editSalvarSped.Text + '\LinhaC181.txt');

       editFim.Text := TimeToStr(Now);

    //   ComparaArquivos( cxButtonEditPath.Text, varArquivo  );
       Mensagem('' ,'0');

       Application.MessageBox(pWideChar('Fim do Processo' + #13#10 + ' Arquivo gerado: ' + varArquivo) , 'SPED', mb_iconinformation +  MB_OK);

       GravaLog;

       cxButtonEditPath.Text      := '';
       cxButtonEditPathExcel.Text := '';
       editLinhaExcel.Text        := '';
       chkSemLoad.Checked := False;
       sqlPeriodo.Close;
       sqlPeriodo.Open;
       sqlfalta.Close;
       sqlCFOP.Close;
       lblTituloFaltaProduto.Visible := False;

    end;

  Finally
    FreeAndNil(varSPED);
    FreeAndNil(sqlUpdateNF);
 //   FreeAndNil(varLista);
    FreeAndNil(sqlCFOP);
  End;
end;

procedure TfrmSped.ComparaArquivos (varSPED_ANT, varSPED_NOVO : String);
var
 varSPEDANT, varSPEDNOVO : TStringList;
 I , X , V, N : Integer;
 varYNumber : String;
 varEncontrado : TStringList;
 varSomaPIS : TStringList;
 bAchou : Boolean;
 varAcumulaValor, varAcumulaPis : Double;

begin
   varSPEDANT    := TStringList.Create;
   varSPEDNOVO   := TStringList.Create;
   varEncontrado := TStringList.Create;
   varSomaPIS    := TStringList.Create;
   Try
      varSPEDANT.LoadFromFile(varSPED_ANT);
      varSPEDNOVO.LoadFromFile(varSPED_NOVO);
      V := 0;

      for i :=  0 to varSPEDANT.Count-1 do
      begin
          varYNumber :='';
          if varSPEDANT[I].Split(['|'])[1].Trim = 'C180' Then
          begin
              Inc(V);
              varYNumber  := varSPEDANT[I].Split(['|'])[5].Trim;
              bAchou      := False;
              N := 0;
              varAcumulaValor := 0;
              varAcumulaPis   := 0;

              for X := 0 to varSPEDNOVO.Count - 1 do
              begin


                if varSPEDNOVO[X].Split(['|'])[1].Trim = 'C180' Then
                begin
                   Inc(N);
                  if Pos(varYNumber, varSPEDNOVO[X]) > 0 then
                  begin
                     varEncontrado.Add('OK;Antigo;' + varYNumber + ';Novo;' + varSPEDNOVO[X]);
                     bAchou :=True;
                     Break;
                  end;
                end;


              end;

              if bAchou = False then
               varEncontrado.Add('ERROR;Antigo;' + varYNumber);

          end;
      end;

      varEncontrado.SaveToFile(editSalvarSped.Text + '\Merge_SPED.txt');

      varSomaPIS.Clear;
      for X := 0 to varSPEDNOVO.Count - 1 do
      begin
      {
          if varSPEDNOVO[X].Split(['|'])[1].Trim = 'C181' Then
          begin
              varAcumulaValor := varAcumulaValor  + StrToFloat(varSPEDNOVO[X].Split(['|'])[4].Trim);
              varAcumulaPis   := varAcumulaPis    + StrToFloat(varSPEDNOVO[X].Split(['|'])[11].Trim);
              varSomaPIS.Add(varSPEDNOVO[X].Split(['|'])[1].Trim  + ';' + varSPEDNOVO[X] + ';' + 'CST;' + varSPEDNOVO[X].Split(['|'])[2].Trim +
                                                    ';CFOP;' + varSPEDNOVO[X].Split(['|'])[3].Trim +
                                                    ';Valor; ' + varSPEDNOVO[X].Split(['|'])[4].Trim +
                                                    ';Acum. Valor; ' + StrTran(FloatToStrF(varAcumulaValor, ffGeneral, 12, 2),'.','') +
                                                    ';PIS; ' + varSPEDNOVO[X].Split(['|'])[10].Trim + ';Acum. Pis: ' + StrTran(FloatToStrF(varAcumulaPis, ffGeneral, 12, 2),'.',''));
          end;

          if varSPEDNOVO[X].Split(['|'])[1].Trim = 'C185' Then
          begin
              varAcumulaValor := varAcumulaValor  + StrToFloat(varSPEDNOVO[X].Split(['|'])[4].Trim);
              varAcumulaPis   := varAcumulaPis    + StrToFloat(varSPEDNOVO[X].Split(['|'])[11].Trim);
              varSomaPIS.Add(varSPEDNOVO[X].Split(['|'])[1].Trim  + ';' + varSPEDNOVO[X] + ';' + 'CST;' + varSPEDNOVO[X].Split(['|'])[2].Trim +
                                                    ';CFOP;' + varSPEDNOVO[X].Split(['|'])[3].Trim +
                                                    ';Valor; ' + varSPEDNOVO[X].Split(['|'])[4].Trim +
                                                    ';Acum. Valor; ' + StrTran(FloatToStrF(varAcumulaValor, ffGeneral, 12, 2),'.','') +
                                                    ';PIS; ' + varSPEDNOVO[X].Split(['|'])[10].Trim + ';Acum. Pis: ' + StrTran(FloatToStrF(varAcumulaPis, ffGeneral, 12, 2),'.',''));
          end;

           }
          if (varSPEDNOVO[X].Split(['|'])[1].Trim  = 'F100') Then
              varSomaPIS.Add( varSPEDNOVO[X].Split(['|'])[1].Trim  + ';' +
                              varSPEDNOVO[X].Split(['|'])[13].Trim + ';' +
                              varSPEDNOVO[X].Split(['|'])[7].Trim + ';' +
                              varSPEDNOVO[X].Split(['|'])[14].Trim + ';' +
                              varSPEDNOVO[X].Split(['|'])[6].Trim );

          if (varSPEDNOVO[X].Split(['|'])[1].Trim  = 'A170') Then
              varSomaPIS.Add( varSPEDNOVO[X].Split(['|'])[1].Trim  + ';' +
                              varSPEDNOVO[X].Split(['|'])[15].Trim + ';' +
                              varSPEDNOVO[X].Split(['|'])[13].Trim + ';' +
                              varSPEDNOVO[X].Split(['|'])[12].Trim + ';' +
                              varSPEDNOVO[X].Split(['|'])[10].Trim );



      end;

      varSomaPIS.SaveToFile(editSalvarSped.Text + '\SOMAPIS_NOVO.txt');

      varSomaPIS.Clear;
      for X := 0 to varSPEDANT.Count - 1 do
      begin
      {
          if varSPEDANT[X].Split(['|'])[1].Trim = 'C181' Then
          begin
              varAcumulaValor := varAcumulaValor  + StrToFloat(varSPEDANT[X].Split(['|'])[4].Trim);
              varAcumulaPis   := varAcumulaPis    + StrToFloat(varSPEDANT[X].Split(['|'])[11].Trim);
              varSomaPIS.Add(varSPEDANT[X].Split(['|'])[1].Trim  + ';' +  varSPEDANT[X] + ';' + 'CST;' + varSPEDANT[X].Split(['|'])[2].Trim +
                                                    ';CFOP;' + varSPEDANT[X].Split(['|'])[3].Trim +
                                                    ';Valor; ' + varSPEDANT[X].Split(['|'])[4].Trim +
                                                    ';Acum. Valor; ' + StrTran(FloatToStrF(varAcumulaValor, ffGeneral, 12, 2),'.','') +
                                                    ';PIS; ' + varSPEDANT[X].Split(['|'])[10].Trim + ';Acum. Pis: ' + StrTran(FloatToStrF(varAcumulaPis, ffGeneral, 12, 2),'.',''));
          end;

          if varSPEDANT[X].Split(['|'])[1].Trim = 'C185' Then
          begin

              varAcumulaValor := varAcumulaValor  + StrToFloat(varSPEDANT[X].Split(['|'])[4].Trim);
              varAcumulaPis   := varAcumulaPis    + StrToFloat(varSPEDANT[X].Split(['|'])[11].Trim);
              varSomaPIS.Add(varSPEDANT[X].Split(['|'])[1].Trim  + ';' +  varSPEDANT[X] + ';' + 'CST;' + varSPEDANT[X].Split(['|'])[2].Trim +
                                                    ';CFOP;' + varSPEDANT[X].Split(['|'])[3].Trim +
                                                    ';Valor; ' + varSPEDANT[X].Split(['|'])[4].Trim +
                                                    ';Acum. Valor; ' + StrTran(FloatToStrF(varAcumulaValor, ffGeneral, 12, 2),'.','') +
                                                    ';PIS; ' + varSPEDANT[X].Split(['|'])[10].Trim + ';Acum. Pis: ' + StrTran(FloatToStrF(varAcumulaPis, ffGeneral, 12, 2),'.',''));
          end;
          }
          if (varSPEDANT[X].Split(['|'])[1].Trim  = 'F100') Then
              varSomaPIS.Add( varSPEDANT[X].Split(['|'])[1].Trim  + ';' +
                              varSPEDANT[X].Split(['|'])[13].Trim + ';' +
                              varSPEDANT[X].Split(['|'])[7].Trim + ';' +
                              varSPEDANT[X].Split(['|'])[14].Trim + ';' +
                              varSPEDANT[X].Split(['|'])[6].Trim );

          if (varSPEDANT[X].Split(['|'])[1].Trim  = 'A170') Then
              varSomaPIS.Add( varSPEDANT[X].Split(['|'])[1].Trim  + ';' +
                              varSPEDANT[X].Split(['|'])[15].Trim + ';' +
                              varSPEDANT[X].Split(['|'])[13].Trim + ';' +
                              varSPEDANT[X].Split(['|'])[12].Trim + ';' +
                              varSPEDANT[X].Split(['|'])[10].Trim );


      end;

      varSomaPIS.SaveToFile(editSalvarSped.Text + '\SOMAPIS_VALIDADO.txt');


      ShowMessage('Velho: ' + IntToStr(V) + ' Novo: ' + IntToStr(N));

   Finally
     FreeAndNil (varSPEDANT);
     FreeAndNil (varSPEDNOVO);
     FreeAndNil (varEncontrado);
     FreeAndNil (varSomaPIS);
   End;
end;

procedure TfrmSped.GravaErro(Periodo, Linha: String);
begin
   sqlLog.Close;
   sqlLog.SQL.Clear;
   sqlLog.SQL.Add('Insert into ARQ_ERRO ( ');
   sqlLog.SQL.Add('  PERIODO, ');
   sqlLog.SQL.Add('  LINHA)');
   sqlLog.SQL.Add(' Values ( ');
   sqlLog.SQL.Add('  :PERIODO, ');
   sqlLog.SQL.Add('  :LINHA)');

   sqlLog.Params.ParamByName('PERIODO').AsString       := Periodo;
   sqlLog.Params.ParamByName('LINHA').AsString         := LINHA;
   Try
    sqlLog.ExecSQL;
  except
     Application.MessageBox('Problema ao Salvar a log de ERRO', 'SPED', mb_iconError+  MB_OK);
  End;
end;

procedure TfrmSped.GravaLog;
begin
   sqlLog.Close;
   sqlLog.SQL.Clear;
   sqlLog.SQL.Add('Insert into ARQ_LOG ( ');
   sqlLog.SQL.Add('  ARQ_SPED, ');
   sqlLog.SQL.Add('  ARQ_EXCEL,');
   sqlLog.SQL.Add('  ARQ_NOVOSPED, ');
   sqlLog.SQL.Add('  INICIO_PROCESSO, ');
   sqlLog.SQL.Add('  FIM_PROCESSO,');
   sqlLog.SQL.Add('  NOME_USUARIO) ');
   sqlLog.SQL.Add(' Values ( ');
   sqlLog.SQL.Add('  :ARQ_SPED, ');
   sqlLog.SQL.Add('  :ARQ_EXCEL,');
   sqlLog.SQL.Add('  :ARQ_NOVOSPED, ');
   sqlLog.SQL.Add('  :INICIO_PROCESSO, ');
   sqlLog.SQL.Add('  :FIM_PROCESSO, ');
   sqlLog.SQL.Add('  :NOME_USUARIO)');

   sqlLog.Params.ParamByName('ARQ_SPED').AsString          := cxButtonEditPath.Text;
   sqlLog.Params.ParamByName('ARQ_EXCEL').AsString         := cxButtonEditPathExcel.Text;
   sqlLog.Params.ParamByName('ARQ_NOVOSPED').AsString      := varArquivo;
   sqlLog.Params.ParamByName('INICIO_PROCESSO').AsString   := editInicio.Text;
   sqlLog.Params.ParamByName('FIM_PROCESSO').AsString      := editFim.Text;
   sqlLog.Params.ParamByName('NOME_USUARIO').AsString      := varUsuarioLogado;
   Try
    sqlLog.ExecSQL;
  except
     Application.MessageBox('Erro ao Salvar a Log', 'SPED', mb_iconError+  MB_OK);
  End;
end;



procedure TfrmSped.SalvarPath(Caminho : String);
begin
  if Caminho = '' then
  begin
     Application.MessageBox('Pasta n�o informada.', 'SPED', mb_iconinformation +  MB_OK);
     exit;
  end;

  sqlPath.Close;
  sqlPath.SQL.Clear;
  sqlPath.SQL.Add('UPDATE ARQ_PARAMETRO SET CAMINHO_SAV_SPED = :CAMINHO_SAV_SPED');
  sqlPath.Params.ParamByName('CAMINHO_SAV_SPED').AsString := Caminho;
  Try
    sqlPath.ExecSQL;
  except
     Application.MessageBox('Erro ao Salvar a Pasta', 'SPED', mb_iconError+  MB_OK);
  End;
end;

function TfrmSped.StrTran(sOrigem: string; sLoc: string; sSub: string): string;
var
  Aux: string;
  Calc: integer;
  Posicao: integer;
begin
//Localiza um conjunto de strings e subtitui por outro
  Aux := sOrigem;
  Calc := 0;
  Posicao := Pos(sLoc, Aux);
  while Posicao > 0 do
  begin

    Delete(Aux, Posicao, Length(sLoc));
    Posicao := Posicao + Calc;
    sOrigem := Copy(sOrigem, 1, Posicao - 1) + sSub +
      Copy(sOrigem, Posicao + Length(sLoc), Length(sOrigem));
    Calc := Calc + Length(sSub);
    Posicao := Pos(sLoc, Aux);
  end;
  Result := sOrigem;
end;



procedure TfrmSped.VerApuracaoFilialClick(Sender: TObject);
begin
   if not sqlPeriodo.IsEmpty then
   begin
     Page.ActivePage := TabApurar;
     AbrirApuracao(sqlPeriodoCNPJ.AsString, sqlPeriodoPERIODO.AsString , '0');
   end;
end;

procedure  TfrmSped.AbrirApuracao(CNPJ, Periodo, Tipo : String);
var
 varApuraPIS, varApuraCofins, varPisOriginal, varCofinsOriginal : Extended;
begin

      varApuraPIS       := 0;
      varApuraCofins    := 0;
      varPisOriginal    := 0;
      varCofinsOriginal := 0;

      sqlApuracao.Close;
      sqlApuracao.SQL.Clear;
      sqlApuracao.SQL.Add(' SELECT R.GRUPO, A.REGISTRO,  A.CST, A.PERIODO, R.DESCRICAO, ');
      sqlApuracao.SQL.Add('      SUM(VALOR_BASE) AS VALOR_BASE, ');
      sqlApuracao.SQL.Add('      PIS_PORC, SUM(VALOR_PIS) AS VALOR_PIS,  ');
      sqlApuracao.SQL.Add('      (SELECT TOP 1 COFINS_PORC FROM ARQ_APURACAO FC WHERE FC.REGISTRO = A.REGISTRO AND FC.CST = A.CST AND A.PERIODO = FC.PERIODO AND  COFINS_PORC > 0) AS COFINS_PORC,  ');
      sqlApuracao.SQL.Add('      (SELECT  SUM(VALOR_COFINS) FROM ARQ_APURACAO FC WHERE FC.REGISTRO = A.REGISTRO AND FC.CST = A.CST AND FC.PERIODO = A.PERIODO AND COFINS_PORC > 0) AS VALOR_COFINS  ');
      sqlApuracao.SQL.Add('FROM ARQ_APURACAO A  ');
      sqlApuracao.SQL.Add('INNER JOIN ARQ_REGISTRO R ON R.REGISTRO = A.REGISTRO AND R.CST = A.CST   ');
      sqlApuracao.SQL.Add('WHERE PIS_PORC > 0 AND PERIODO = :PERIODO AND R.GRUPO = ''D�BITOS''   ');
      sqlApuracao.SQL.Add('GROUP BY R.GRUPO,A.REGISTRO, A.CST, A.PERIODO, R.DESCRICAO,  PIS_PORC, COFINS_PORC  ');
      sqlApuracao.SQL.Add('UNION   ');
      sqlApuracao.SQL.Add('SELECT R.GRUPO,A.REGISTRO,  A.CST, A.PERIODO, R.DESCRICAO,  ');
      sqlApuracao.SQL.Add('      SUM(VALOR_BASE) AS VALOR_BASE,  ');
      sqlApuracao.SQL.Add('      PIS_PORC, SUM(VALOR_PIS) AS VALOR_PIS,  ');
      sqlApuracao.SQL.Add('      (SELECT TOP 1 COFINS_PORC FROM ARQ_APURACAO FC WHERE FC.REGISTRO = A.REGISTRO AND FC.CST = A.CST AND A.PERIODO = FC.PERIODO AND  COFINS_PORC > 0) AS COFINS_PORC, ');
      sqlApuracao.SQL.Add('      (SELECT  SUM(VALOR_COFINS) FROM ARQ_APURACAO FC WHERE FC.REGISTRO = A.REGISTRO AND FC.CST = A.CST AND FC.PERIODO = A.PERIODO AND COFINS_PORC > 0) AS VALOR_COFINS  ');
      sqlApuracao.SQL.Add('FROM ARQ_APURACAO A   ');
      sqlApuracao.SQL.Add('INNER JOIN ARQ_REGISTRO R ON R.REGISTRO = A.REGISTRO AND R.CST = A.CST  ');
      sqlApuracao.SQL.Add('WHERE PIS_PORC > 0 AND PERIODO = :PERIODO AND R.GRUPO = ''CR�DITOS''  ');
      sqlApuracao.SQL.Add('GROUP BY R.GRUPO,A.REGISTRO, A.CST, A.PERIODO, R.DESCRICAO,  PIS_PORC, COFINS_PORC  ');
      sqlApuracao.SQL.Add('UNION  ');
      sqlApuracao.SQL.Add('SELECT R.GRUPO,A.REGISTRO,  A.CST, A.PERIODO, R.DESCRICAO,  ');
      sqlApuracao.SQL.Add('      SUM(VALOR_BASE) AS VALOR_BASE,  ');
      sqlApuracao.SQL.Add('      PIS_PORC, SUM(VALOR_PIS) AS VALOR_PIS,  ');
      sqlApuracao.SQL.Add('      (SELECT TOP 1 COFINS_PORC FROM ARQ_APURACAO FC WHERE FC.REGISTRO = A.REGISTRO AND FC.CST = A.CST AND A.PERIODO = FC.PERIODO AND  COFINS_PORC > 0) AS COFINS_PORC,  ');
      sqlApuracao.SQL.Add('      (SELECT  SUM(VALOR_COFINS) FROM ARQ_APURACAO FC WHERE FC.REGISTRO = A.REGISTRO AND FC.CST = A.CST AND FC.PERIODO = A.PERIODO AND COFINS_PORC > 0) AS VALOR_COFINS  ');
      sqlApuracao.SQL.Add('FROM ARQ_APURACAO A  ');
      sqlApuracao.SQL.Add('INNER JOIN ARQ_REGISTRO R ON R.REGISTRO = A.REGISTRO AND R.CST = A.CST  ');
      sqlApuracao.SQL.Add('WHERE PIS_PORC > 0 AND PERIODO = :PERIODO AND R.GRUPO = ''ESTORNOS''  ');
      sqlApuracao.SQL.Add('GROUP BY R.GRUPO,A.REGISTRO, A.CST, A.PERIODO, R.DESCRICAO,  PIS_PORC, COFINS_PORC  ');
      sqlApuracao.SQL.Add('ORDER BY R.GRUPO DESC, A.REGISTRO, A.CST  ');
      sqlApuracao.Params.ParamByName('PERIODO').AsString := Periodo;
      sqlApuracao.Open;

       sqlCredito := TFDQuery.Create(Nil);
       sqlDebito  := TFDQuery.Create(Nil);
       sqlEstorno := TFDQuery.Create(Nil);
       sqlSpedOriginal := TFDQuery.Create(Nil);
       Try
         sqlCredito.Connection      := DB_Conect.FDConnection;
         sqlDebito.Connection       := DB_Conect.FDConnection;
         sqlEstorno.Connection      := DB_Conect.FDConnection;
         sqlSpedOriginal.Connection := DB_Conect.FDConnection;

         sqlCredito.Close;
         sqlCredito.SQL.Clear;
         sqlCredito.SQL.Add('WITH DADOS_CREDITO ');
         sqlCredito.SQL.Add('AS ( ');
         sqlCredito.SQL.Add('SELECT SUM(VALOR_PIS) AS VALOR_PIS, ');
         sqlCredito.SQL.Add('      (SELECT  SUM(VALOR_COFINS) FROM ARQ_APURACAO FC WHERE FC.REGISTRO = A.REGISTRO AND FC.CST = A.CST AND FC.PERIODO = A.PERIODO AND COFINS_PORC > 0) AS VALOR_COFINS  ');
         sqlCredito.SQL.Add('FROM ARQ_APURACAO A   ');
         sqlCredito.SQL.Add('INNER JOIN ARQ_REGISTRO R ON R.REGISTRO = A.REGISTRO AND R.CST = A.CST  ');
         sqlCredito.SQL.Add('WHERE PIS_PORC > 0 AND PERIODO = :PERIODO AND R.GRUPO = ''CR�DITOS''  ');
         sqlCredito.SQL.Add('GROUP BY R.GRUPO,A.REGISTRO, A.CST, A.PERIODO, R.DESCRICAO,  PIS_PORC, COFINS_PORC   ');
         sqlCredito.SQL.Add(')  ');
         sqlCredito.SQL.Add('SELECT SUM(VALOR_PIS) AS VALOR_PIS, SUM(VALOR_COFINS) AS VALOR_COFINS FROM DADOS_CREDITO  ');
         sqlCredito.Params.ParamByName('PERIODO').AsString := Periodo;
         sqlCredito.Open;


         sqlDebito.Close;
         sqlDebito.SQL.Clear;
         sqlDebito.SQL.Add('WITH DADOS_DEBITO ');
         sqlDebito.SQL.Add('AS ( ');
         sqlDebito.SQL.Add('SELECT  SUM(VALOR_PIS) AS VALOR_PIS, ');
         sqlDebito.SQL.Add('      (SELECT  SUM(VALOR_COFINS) FROM ARQ_APURACAO FC WHERE FC.REGISTRO = A.REGISTRO AND FC.CST = A.CST AND FC.PERIODO = A.PERIODO AND COFINS_PORC > 0) AS VALOR_COFINS');
         sqlDebito.SQL.Add('FROM ARQ_APURACAO A ');
         sqlDebito.SQL.Add('INNER JOIN ARQ_REGISTRO R ON R.REGISTRO = A.REGISTRO AND R.CST = A.CST ');
         sqlDebito.SQL.Add('WHERE PIS_PORC > 0 AND PERIODO = :PERIODO AND R.GRUPO = ''D�BITOS''  ');
         sqlDebito.SQL.Add('GROUP BY R.GRUPO,A.REGISTRO, A.CST, A.PERIODO, R.DESCRICAO,  PIS_PORC, COFINS_PORC ');
         sqlDebito.SQL.Add(') ');
         sqlDebito.SQL.Add('SELECT SUM(VALOR_PIS) AS VALOR_PIS, SUM(VALOR_COFINS) AS VALOR_COFINS FROM DADOS_DEBITO ');
         sqlDebito.Params.ParamByName('PERIODO').AsString := Periodo;
         sqlDebito.Open;


         sqlEstorno.Close;
         sqlEstorno.SQL.Clear;
         sqlEstorno.SQL.Add('WITH DADOS_ESTORNO ');
         sqlEstorno.SQL.Add('AS ( ');
         sqlEstorno.SQL.Add('SELECT SUM(VALOR_PIS) AS VALOR_PIS, ');
         sqlEstorno.SQL.Add('     (SELECT  SUM(VALOR_COFINS) FROM ARQ_APURACAO FC WHERE FC.REGISTRO = A.REGISTRO AND FC.CST = A.CST AND FC.PERIODO = A.PERIODO AND COFINS_PORC > 0) AS VALOR_COFINS  ');
         sqlEstorno.SQL.Add('FROM ARQ_APURACAO A  ');
         sqlEstorno.SQL.Add('INNER JOIN ARQ_REGISTRO R ON R.REGISTRO = A.REGISTRO AND R.CST = A.CST ');
         sqlEstorno.SQL.Add('WHERE PIS_PORC > 0 AND PERIODO = :PERIODO AND R.GRUPO = ''ESTORNOS''  ');
         sqlEstorno.SQL.Add('GROUP BY R.GRUPO,A.REGISTRO, A.CST, A.PERIODO, R.DESCRICAO,  PIS_PORC, COFINS_PORC  ');
         sqlEstorno.SQL.Add(')   ');
         sqlEstorno.SQL.Add('SELECT SUM(VALOR_PIS) AS VALOR_PIS, SUM(VALOR_COFINS) AS VALOR_COFINS FROM DADOS_ESTORNO  ');
         sqlEstorno.Params.ParamByName('PERIODO').AsString := Periodo;
         sqlEstorno.Open;

         sqlSpedOriginal.Close;
         sqlSpedOriginal.SQL.Clear;
         sqlSpedOriginal.SQL.Add('Select Valor_PIS, Valor_COFINS From ARQ_APURACAO_ORIGINAL');
         sqlSpedOriginal.SQL.Add(' Where CNPJ = :CNPJ and PERIODO = :PERIODO');
         sqlSpedOriginal.Params.ParamByName('CNPJ').AsString    :=  CNPJ;
         sqlSpedOriginal.Params.ParamByName('PERIODO').AsString :=  Periodo;
         sqlSpedOriginal.Open;

         varPisOriginal := sqlSpedOriginal.FieldByName('Valor_PIS').AsFloat;
         mskPisOriginal.Text := FloatToStrF(varPisOriginal, ffCurrency, 12,2);

         varCofinsOriginal :=  sqlSpedOriginal.FieldByName('Valor_COFINS').AsFloat;
         mskCofinsOriginal.Text := FloatToStrF(varCofinsOriginal, ffCurrency, 12, 2);

         varApuraPIS := sqlDebito.FieldByName('VALOR_PIS').AsFloat - (sqlCredito.FieldByName('VALOR_PIS').AsFloat - sqlEstorno.FieldByName('VALOR_PIS').AsFloat) ;
         mskPis.Text := FloatToStrF(varApuraPIS, ffCurrency,12,2);

         varApuraCofins := sqlDebito.FieldByName('VALOR_COFINS').AsFloat - (sqlCredito.FieldByName('VALOR_COFINS').AsFloat - sqlEstorno.FieldByName('VALOR_COFINS').AsFloat);
         FormatFloat('#,##0.00',varApuraCofins );
         mskCofins.Text := FloatToStrF(varApuraCofins, ffCurrency, 12,2);

         mskPisDif.Text := FloatToStrF(varApuraPIS - varPisOriginal, ffCurrency, 12, 2 );
         mskCofinsDif.Text := FloatToStrF(varApuraCofins - varCofinsOriginal, ffCurrency, 12, 2);


       Finally
         FreeAndNil(sqlCredito);
         FreeAndNil(sqlDebito);
         FreeAndNil(sqlEstorno);
       End;

end;

procedure TfrmSped.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Self   := NIL;
end;

procedure TfrmSped.FormCreate(Sender: TObject);
begin
  if Assigned(DB_Conect) then
    varUsuarioLogado := DB_Conect.GUsuario;

  Page.ActivePage         := TabProcessar;
  editSalvarSped.AsString := RecuperarPath;
  sqlPeriodo.Close;
  sqlPeriodo.Open;

  SetParametros(editBuscaApuracao, TipoApuracao);
end;

procedure   TfrmSped.ImportarSPED;
var
  varSPED: TStringList;
  varInicial, varFinal: Integer;
  I, X: Integer;
  varSQL  : String;
  varIdentity : Integer;
  varLinha : Array [0..13] of String;
  varSubLinha : Array [0..10] of String;

  varValorItem : Double;
  varCNPJ, varCNPJFilial : string;
  varResultado : Word;
  varMensagem: String;
  sqlCFOP : TFDQuery;
  varDtInicial, varDtFinal : String;
begin


  if not Assigned(DB_Conect) then
  begin

    DB_Conect := TDB_Conect.Create(nil);

    with DB_Conect  do
    begin
      FDConnection.Params.Clear;
      FDConnection.Params.LoadFromFile( ExtractFilePath(Application.ExeName) + '\' +  'DB-CECS2002.ini' );
      FDConnection.Open;
    end;

  end;

  sqlCFOP := TFDQuery.Create(Nil);
  sqlCFOP.Connection := DB_Conect.FDConnection;

  varSPED := TStringList.Create;
  try
    sqlCFOP.Close;
    sqlCFOP.SQL.Clear;
    sqlCFOP.SQL.Add('Select CFOP, CONTA From ARQ_CFOP');
    sqlCFOP.Open;

    with DB_Conect do
    begin

      try

            varSPED.LoadFromFile( cxButtonEditPath.Text );
            varPeriodo   := varSPED[I].Split(['|'])[6].Trim + '_' + varSPED[I].Split(['|'])[7].Trim;
            varCNPJ      := varSPED[I].Split(['|'])[9].Trim;
            varCNPJSPED  := varSPED[I].Split(['|'])[9].Trim;

            if (varCNPJ = '') then
            begin
              Application.MessageBox(pWideChar( ' Arquivo de SPED Inv�lido.' ), 'SPED', mb_iconError+  MB_OK);
              Abort;
            end;


            Mensagem( 'Verificando se SPED j� foi processado.'  ,'0');

            sqlAuxiliar.Close;
            sqlAuxiliar.SQL.Clear;
            sqlAuxiliar.SQL.Add('Select top 1 * From ARQ_GERAL ');
            sqlAuxiliar.SQL.Add('Where Periodo = :Periodo and CNPJ = :CNPJ ');
            sqlAuxiliar.Params.ParamByName('Periodo').AsString :=  varPeriodo;
            sqlAuxiliar.Params.ParamByName('CNPJ').AsString    :=  varCNPJ;
            sqlAuxiliar.Open;
            if not sqlAuxiliar.IsEmpty then
            begin
              varMensagem := 'Deseja excluir e processar novamente?';
              varResultado := Application.MessageBox(PCHAR(varMensagem),'SPED j� foi processado.',
                              MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2+MB_APPLMODAL);

              case varResultado of
                IDYES :
                begin
                  Try
                      Cursor  := crHourGlass;
                      sqlAuxiliar.Close;
                      sqlAuxiliar.SQL.Clear;
                      sqlAuxiliar.SQL.Add('DELETE FROM ARQ_C180_ITENS  ');
                      sqlAuxiliar.SQL.Add('WHERE  EXISTS (SELECT * FROM ARQ_C180 C ');
                      sqlAuxiliar.SQL.Add('WHERE ARQ_C180_ITENS.ARQ_C180 = C.ARQ_C180 ');
                      sqlAuxiliar.SQL.Add('AND C.CNPJ_SPED = :CNPJ_SPED ');
                      sqlAuxiliar.SQL.Add('AND C.PERIODO = :Periodo)');
                      sqlAuxiliar.Params.ParamByName('Periodo').AsString :=  varPeriodo;
                      sqlAuxiliar.Params.ParamByName('CNPJ_SPED').AsString    :=  varCNPJ;
                      Try
                        sqlAuxiliar.ExecSQL;
                      except
                        On E:Exception do
                          begin
                            varPeriodo := '';
                            Application.MessageBox(pWideChar( 'Falha ao excluir SPED do banco de dados. (ARQ_C180_ITENS) ' + E.Message), 'SPED', mb_iconError+  MB_OK);
                          end;
                      end;

                      sqlAuxiliar.Close;
                      sqlAuxiliar.SQL.Clear;
                      sqlAuxiliar.SQL.Add('Delete From ARQ_C180 ');
                      sqlAuxiliar.SQL.Add('WHERE CNPJ_SPED = :CNPJ_SPED ');
                      sqlAuxiliar.SQL.Add('AND PERIODO = :Periodo');
                      sqlAuxiliar.Params.ParamByName('Periodo').AsString   :=  varPeriodo;
                      sqlAuxiliar.Params.ParamByName('CNPJ_SPED').AsString :=  varCNPJ;
                      Try
                        sqlAuxiliar.ExecSQL;
                      except
                        On E:Exception do
                          begin
                            varPeriodo := '';
                            Application.MessageBox(pWideChar( 'Falha ao excluir SPED do banco de dados. (ARQ_C180)  ' + E.Message), 'SPED', mb_iconError+  MB_OK);
                          end;
                      end;

                      sqlAuxiliar.Close;
                      sqlAuxiliar.SQL.Clear;
                      sqlAuxiliar.SQL.Add('Delete From ARQ_GERAL ');
                      sqlAuxiliar.SQL.Add('WHERE CNPJ = :CNPJ ');
                      sqlAuxiliar.SQL.Add('AND PERIODO = :Periodo');
                      sqlAuxiliar.Params.ParamByName('Periodo').AsString :=  varPeriodo;
                      sqlAuxiliar.Params.ParamByName('CNPJ').AsString    :=  varCNPJ;
                      Try
                        sqlAuxiliar.ExecSQL;
                      except
                        On E:Exception do
                          begin
                            varPeriodo := '';
                            Application.MessageBox(pWideChar( 'Falha ao excluir SPED do banco de dados. (ARQ_GERAL)  ' + E.Message), 'SPED', mb_iconError+  MB_OK);
                          end;
                      end;

                      sqlAuxiliar.Close;
                      sqlAuxiliar.SQL.Clear;
                      sqlAuxiliar.SQL.Add('Delete From ARQ_NF ');
                      sqlAuxiliar.SQL.Add('WHERE CNPJ_SPED = :CNPJ_SPED ');
                      sqlAuxiliar.SQL.Add('AND PERIODO = :PERIODO');
                      sqlAuxiliar.Params.ParamByName('PERIODO').AsString     :=  varPeriodo;
                      sqlAuxiliar.Params.ParamByName('CNPJ_SPED').AsString   :=  varCNPJ;
                      Try
                        sqlAuxiliar.ExecSQL;
                      except
                        On E:Exception do
                          begin
                            varPeriodo := '';
                            Application.MessageBox(pWideChar( 'Falha ao excluir SPED do banco de dados. (ARQ_NF)  ' + E.Message), 'SPED', mb_iconError+  MB_OK);
                          end;
                      end;

                      sqlAuxiliar.Close;
                      sqlAuxiliar.SQL.Clear;
                      sqlAuxiliar.SQL.Add('Delete From ARQ_APURACAO ');
                      sqlAuxiliar.SQL.Add('WHERE CNPJ = :CNPJ_SPED ');
                      sqlAuxiliar.SQL.Add('AND PERIODO = :PERIODO');
                      sqlAuxiliar.Params.ParamByName('PERIODO').AsString     :=  varPeriodo;
                      sqlAuxiliar.Params.ParamByName('CNPJ_SPED').AsString   :=  varCNPJ;
                      Try
                        sqlAuxiliar.ExecSQL;
                      except
                        On E:Exception do
                          begin
                            varPeriodo := '';
                            Application.MessageBox(pWideChar( 'Falha ao excluir ARQ_APURACAO do banco de dados. (ARQ_APURACAO)  ' + E.Message), 'SPED', mb_iconError+  MB_OK);
                          end;
                      end;

                      sqlAuxiliar.Close;
                      sqlAuxiliar.SQL.Clear;
                      sqlAuxiliar.SQL.Add('Delete From ARQ_APURACAO_ORIGINAL ');
                      sqlAuxiliar.SQL.Add('WHERE CNPJ = :CNPJ_SPED ');
                      sqlAuxiliar.SQL.Add('AND PERIODO = :PERIODO');
                      sqlAuxiliar.Params.ParamByName('PERIODO').AsString     :=  varPeriodo;
                      sqlAuxiliar.Params.ParamByName('CNPJ_SPED').AsString   :=  varCNPJ;
                      Try
                        sqlAuxiliar.ExecSQL;
                      except
                        On E:Exception do
                          begin
                            varPeriodo := '';
                            Application.MessageBox(pWideChar( 'Falha ao excluir ARQ_APURACAO_ORIGINAL do banco de dados. (ARQ_APURACAO_ORIGINAL)  ' + E.Message), 'SPED', mb_iconError+  MB_OK);
                          end;
                      end;

                      Cursor  := crDefault;

                  Finally
                        Application.MessageBox(pWideChar( 'SPED excluido com sucesso.'), 'SPED', MB_ICONINFORMATION +  MB_OK);
                  End;

                end;
                IDNO :
                begin
                  abort;
                end;
              end;

            end;
            Mensagem('Aguarde, Processando...' ,'0');
            StatusBar1.Panels[0].Text := 'Status:';
            varInicial := 0;
            varFinal := varSPED.Count;
            for I := varInicial to varSPED.Count-1 do
            begin

              // Mensagem( 'Arquivo SPED CONT�BIL  (' +  IntToStr(I) + '/' + IntToStr(varFinal)+ ')' ,'1');
             if (I mod 1000 = 0) and (I > 0) then
             begin
                StatusBar1.Panels[0].Text := ' Processado: ' +  IntToStr(I);
                Application.ProcessMessages;
             end;

              if varSPED[I].Split(['|'])[1].Trim = '0000' then
              begin

                varLinha[0]  :=   varSPED[I].Split(['|'])[1].Trim;
                varLinha[1]  :=   varSPED[I].Split(['|'])[2].Trim;
                varLinha[2]  :=   varSPED[I].Split(['|'])[3].Replace('0','1');
                varLinha[3]  :=   varSPED[I].Split(['|'])[4].Trim;
                varLinha[4]  :=   varSPED[I].Split(['|'])[5].Trim;
                varLinha[5]  :=   varSPED[I].Split(['|'])[6].Trim;
                varLinha[6]  :=   varSPED[I].Split(['|'])[7].Trim;
                varLinha[7]  :=   varSPED[I].Split(['|'])[8].Trim;
                varLinha[8]  :=   varSPED[I].Split(['|'])[9].Trim;
                varLinha[9]  :=   varSPED[I].Split(['|'])[10].Trim;
                varLinha[10] :=   varSPED[I].Split(['|'])[11].Trim;
                varLinha[11] :=   varSPED[I].Split(['|'])[12].Trim;
                varLinha[12] :=   varSPED[I].Split(['|'])[13].Trim;
                varLinha[13] :=   varSPED[I].Split(['|'])[14].Trim;

                varSPED[I] := '|';

                for X := Low(varLinha) to High(varLinha) do
                begin
                  varSPED[I] := varSPED[I] + varLinha[X] + '|';
                end;
              end;

              sqlAuxiliar.Close;

              if varSPED[I].Split(['|'])[1].Trim = 'C010' Then
                 varCNPJFilial := varSPED[I].Split(['|'])[2].Trim;


              if varSPED[I].Split(['|'])[1].Trim = 'C180' Then
              begin
                 sqlAuxiliar.Close;
                 sqlAuxiliar.SQL.Clear;
                 sqlAuxiliar.SQL.Add('Insert into ARQ_C180 ( ');
                 sqlAuxiliar.SQL.Add('PERIODO,');
                 sqlAuxiliar.SQL.Add('CNPJ_SPED,');
                 sqlAuxiliar.SQL.Add('FILIAL,');

                 sqlAuxiliar.SQL.Add('REG,');
                 sqlAuxiliar.SQL.Add('COD_MOD,');
                 sqlAuxiliar.SQL.Add('DT_DOC_INI,');
                 sqlAuxiliar.SQL.Add('DT_DOC_FIN,');
                 sqlAuxiliar.SQL.Add('COD_ITEM,');
                 sqlAuxiliar.SQL.Add('COD_NCM,');
                 sqlAuxiliar.SQL.Add('EX_IPI,');
                 sqlAuxiliar.SQL.Add('VL_TOT_ITEM)');
                 sqlAuxiliar.SQL.Add(' VALUES ( ');
                 sqlAuxiliar.SQL.Add(':PERIODO,');
                 sqlAuxiliar.SQL.Add(':CNPJ_SPED,');
                 sqlAuxiliar.SQL.Add(':FILIAL,');
                 sqlAuxiliar.SQL.Add(':REG,');
                 sqlAuxiliar.SQL.Add(':COD_MOD,');
                 sqlAuxiliar.SQL.Add(':DT_DOC_INI,');
                 sqlAuxiliar.SQL.Add(':DT_DOC_FIN,');
                 sqlAuxiliar.SQL.Add(':COD_ITEM,');
                 sqlAuxiliar.SQL.Add(':COD_NCM,');
                 sqlAuxiliar.SQL.Add(':EX_IPI,');
                 sqlAuxiliar.SQL.Add(':VL_TOT_ITEM)');
                 sqlAuxiliar.Params.ParamByName('PERIODO').AsString     :=  varPeriodo;
                 sqlAuxiliar.Params.ParamByName('CNPJ_SPED').AsString   :=  varCNPJ;
                 sqlAuxiliar.Params.ParamByName('FILIAL').AsString      :=  varCNPJFilial;
                 sqlAuxiliar.Params.ParamByName('REG').AsString         :=  varSPED[I].Split(['|'])[1].Trim;
                 sqlAuxiliar.Params.ParamByName('COD_MOD').AsString     :=  varSPED[I].Split(['|'])[2].Trim;
                 varDtInicial  := varSPED[I].Split(['|'])[3].Trim;
                 varDtFinal    := varSPED[I].Split(['|'])[4].Trim;
                 sqlAuxiliar.Params.ParamByName('DT_DOC_INI').AsString  :=  varSPED[I].Split(['|'])[3].Trim;
                 sqlAuxiliar.Params.ParamByName('DT_DOC_FIN').AsString  :=  varSPED[I].Split(['|'])[4].Trim;
                 sqlAuxiliar.Params.ParamByName('COD_ITEM').AsString    :=  varSPED[I].Split(['|'])[5].Trim;
                 sqlAuxiliar.Params.ParamByName('COD_NCM').AsString     :=  varSPED[I].Split(['|'])[6].Trim;
                 sqlAuxiliar.Params.ParamByName('EX_IPI').AsString      :=  varSPED[I].Split(['|'])[7].Trim;
                 sqlAuxiliar.Params.ParamByName('VL_TOT_ITEM').AsFloat  :=  StrToFloat(varSPED[I].Split(['|'])[8].Trim);
                 varValorItem                                           :=  StrToFloat(varSPED[I].Split(['|'])[8].Trim);
                 Try

                     sqlAuxiliar.ExecSQL;

                     Try
                      varIdentity := 0;
                      varSQL  := 'SELECT @@IDENTITY as ARQ_C180_ID ';

                      sqlAuxiliar.Close;
                      sqlAuxiliar.SQL.Clear;
                      sqlAuxiliar.SQL.Add( varSQL );
                      sqlAuxiliar.Open;
                      varIdentity := sqlAuxiliar.FieldByName('ARQ_C180_ID').AsInteger;

                    except
                      On E:Exception do
                        begin
                          GravaErro(varPeriodo, inttostr(varIdentity) + '-' + E.Message);
                          varPeriodo := '';
                          Application.MessageBox(pWideChar( 'Falha ao pegar chave da tabela ARQ_C180: ' + E.Message), 'SPED', mb_iconError+  MB_OK);
                        end;
                    end;

                except

                  on E: Exception do
                  begin
                    GravaErro(varPeriodo, varSPED[I] + '-' + E.Message );
                    Application.MessageBox(pWideChar( E.Message + varSPED[I] ) , 'SPED', mb_iconError+  MB_OK );

                  end;

                end;

              end;

              if ((varSPED[I].Split(['|'])[1].Trim = 'C181') or (varSPED[I].Split(['|'])[1].Trim = 'C185')) Then
              begin

                 //if ((varSPED[I].Split(['|'])[3].Trim = '6102') or (varSPED[I].Split(['|'])[3].Trim = '7102')) then
                 //begin
                    varSubLinha[0]  :=   varSPED[I].Split(['|'])[1].Trim;
                    varSubLinha[1]  :=   varSPED[I].Split(['|'])[2].Trim;
                    varSubLinha[2]  :=   varSPED[I].Split(['|'])[3].Trim;
                    varSubLinha[3]  :=   varSPED[I].Split(['|'])[4].Trim;
                    varSubLinha[4]  :=   varSPED[I].Split(['|'])[5].Trim;
                    varSubLinha[5]  :=   varSPED[I].Split(['|'])[6].Trim;
                    varSubLinha[6]  :=   varSPED[I].Split(['|'])[7].Trim;
                    varSubLinha[7]  :=   varSPED[I].Split(['|'])[8].Trim;
                    varSubLinha[8]  :=   varSPED[I].Split(['|'])[9].Trim;
                    varSubLinha[9]  :=   varSPED[I].Split(['|'])[10].Trim;

                    if  sqlCFOP.Locate('CFOP', varSPED[I].Split(['|'])[3].Trim, []) then
                      varSubLinha[10] :=  sqlCFOP.FieldByName('CONTA').AsString    // '0000414005';
                    else
                    begin
                      Application.MessageBox(pChar('CFOP n�o cadastrado ' + #13#10 + varSPED[I]) , 'SPED', MB_ICONINFORMATION+  MB_OK);
                      varSubLinha[10] := varSPED[I].Split(['|'])[11].Trim;  //  provavel 0000451000
                    end;

                    varSPED[I] := '|';

                    for X := Low(varSubLinha) to High(varSubLinha) do
                    begin
                      varSPED[I] := varSPED[I] + varSubLinha[X] + '|';
                    end;
                 //end;



                 Try
                     sqlAuxiliar.Close;
                     sqlAuxiliar.SQL.Clear;
                     sqlAuxiliar.SQL.Add('Insert into ARQ_C180_ITENS ( ');
                     sqlAuxiliar.SQL.Add(' ARQ_C180');
                     sqlAuxiliar.SQL.Add(',REG');
                     sqlAuxiliar.SQL.Add(',CST');
                     sqlAuxiliar.SQL.Add(',CFOP');
                     sqlAuxiliar.SQL.Add(',VL_ITEM');
                     sqlAuxiliar.SQL.Add(',VL_DESC');
                     sqlAuxiliar.SQL.Add(',VL_BC');
                     sqlAuxiliar.SQL.Add(',ALIQ');
                     sqlAuxiliar.SQL.Add(',QUANT_BC');
                     sqlAuxiliar.SQL.Add(',ALIQ_QUANT');
                     sqlAuxiliar.SQL.Add(',VL');
                     sqlAuxiliar.SQL.Add(',COD_CT');
                     sqlAuxiliar.SQL.Add(',PERCENTUAL)');

                     sqlAuxiliar.SQL.Add(' Values (');
                     sqlAuxiliar.SQL.Add(' :ARQ_C180');
                     sqlAuxiliar.SQL.Add(',:REG');
                     sqlAuxiliar.SQL.Add(',:CST');
                     sqlAuxiliar.SQL.Add(',:CFOP');
                     sqlAuxiliar.SQL.Add(',:VL_ITEM');
                     sqlAuxiliar.SQL.Add(',:VL_DESC');
                     sqlAuxiliar.SQL.Add(',:VL_BC');
                     sqlAuxiliar.SQL.Add(',:ALIQ');
                     sqlAuxiliar.SQL.Add(',:QUANT_BC');
                     sqlAuxiliar.SQL.Add(',:ALIQ_QUANT');
                     sqlAuxiliar.SQL.Add(',:VL');
                     sqlAuxiliar.SQL.Add(',:COD_CT');
                     sqlAuxiliar.SQL.Add(',:PERCENTUAL)');

                     sqlAuxiliar.Params.ParamByName('ARQ_C180').AsInteger   :=  varIdentity;
                     sqlAuxiliar.Params.ParamByName('REG').AsString         :=  varSPED[I].Split(['|'])[1].Trim;
                     sqlAuxiliar.Params.ParamByName('CST').AsString         :=  varSPED[I].Split(['|'])[2].Trim;
                     sqlAuxiliar.Params.ParamByName('CFOP').AsString        :=  varSPED[I].Split(['|'])[3].Trim;

                     if varSPED[I].Split(['|'])[4].Trim <> '' then
                           sqlAuxiliar.Params.ParamByName('VL_ITEM').AsFloat     :=  StrToFloat(varSPED[I].Split(['|'])[4].Trim)
                     else  sqlAuxiliar.Params.ParamByName('VL_ITEM').AsFloat     :=0;

                     if varSPED[I].Split(['|'])[5].Trim <> '' then
                          sqlAuxiliar.Params.ParamByName('VL_DESC').AsFloat      :=  StrToFloat(varSPED[I].Split(['|'])[5].Trim)
                     else sqlAuxiliar.Params.ParamByName('VL_DESC').AsFloat      := 0;

                     if varSPED[I].Split(['|'])[6].Trim <> '' then
                           sqlAuxiliar.Params.ParamByName('VL_BC').AsFloat       :=  StrToFloat(varSPED[I].Split(['|'])[6].Trim)
                     else  sqlAuxiliar.Params.ParamByName('VL_BC').AsFloat       := 0;

                     if varSPED[I].Split(['|'])[7].Trim <> '' then
                          sqlAuxiliar.Params.ParamByName('ALIQ').AsFloat         :=  StrToFloat(varSPED[I].Split(['|'])[7].Trim)
                     else sqlAuxiliar.Params.ParamByName('ALIQ').AsFloat         :=0;

                     if varSPED[I].Split(['|'])[8].Trim <> '' then
                           sqlAuxiliar.Params.ParamByName('QUANT_BC').AsFloat    :=  StrToFloat(varSPED[I].Split(['|'])[8].Trim)
                     else  sqlAuxiliar.Params.ParamByName('QUANT_BC').AsFloat    :=0;

                     if varSPED[I].Split(['|'])[9].Trim <> '' then
                          sqlAuxiliar.Params.ParamByName('ALIQ_QUANT').AsFloat   :=  StrToFloat(varSPED[I].Split(['|'])[9].Trim)
                     else sqlAuxiliar.Params.ParamByName('ALIQ_QUANT').AsFloat   :=0;

                     if varSPED[I].Split(['|'])[10].Trim <> '' then
                           sqlAuxiliar.Params.ParamByName('VL').AsFloat          :=  StrToFloat(varSPED[I].Split(['|'])[10].Trim)
                     else  sqlAuxiliar.Params.ParamByName('VL').AsFloat          := 0;

                     sqlAuxiliar.Params.ParamByName('COD_CT').AsString           :=  varSPED[I].Split(['|'])[11].Trim;

                     sqlAuxiliar.Params.ParamByName('PERCENTUAL').AsFloat        := (StrToFloat(varSPED[I].Split(['|'])[4].Trim)/varValorItem)*100;


                 except

                    on E: Exception do
                    begin
                      GravaErro(varPeriodo, varSPED[I] );
                      varPeriodo := '';
                      Application.MessageBox(pWideChar( E.Message + varSPED[I])  , 'SPED', mb_iconError+  MB_OK);

                    end;

                 end;

                 try
                    sqlAuxiliar.ExecSQL;

                  except

                    on E: Exception do
                    begin
                      varPeriodo := '';
                      Application.MessageBox(pWideChar( E.Message + varSPED[I] ) , 'SPED', mb_iconError+  MB_OK );

                    end;

                 end;

              end;


              sqlAuxiliar.Close;
              sqlAuxiliar.SQL.Clear;
              sqlAuxiliar.SQL.Add('Insert into ARQ_GERAL (PERIODO, CNPJ, DTINICIAL, DTFINAL, CNPJFILIAL, LINHA) Values (:PERIODO, :CNPJ, :DTINICIAL, :DTFINAL, :CNPJFILIAL, :LINHA)');
              sqlAuxiliar.Params.ParamByName('PERIODO').AsString    :=  varPeriodo;
              sqlAuxiliar.Params.ParamByName('CNPJ').AsString       :=  varCNPJ;
              sqlAuxiliar.Params.ParamByName('DTINICIAL').AsString  :=  varDtInicial;
              sqlAuxiliar.Params.ParamByName('DTFINAL').AsString    :=  varDtFinal;

              sqlAuxiliar.Params.ParamByName('CNPJFILIAL').AsString :=  varCNPJFilial;
              sqlAuxiliar.Params.ParamByName('LINHA').AsString      :=  varSPED[I];

              try

                sqlAuxiliar.ExecSQL;

              except

                on E: Exception do
                begin
                  GravaErro(varPeriodo, varSPED[I] + '-' + E.Message );
                  varPeriodo := '';
                  Application.MessageBox( pWideChar( E.Message ),  'SPED', mb_iconError+  MB_OK);

                end;

              end;

              if varSPED[I].Split(['|'])[1].Trim = '9999' Then
                 Exit;

            end;

            sqlAuxiliar.Close;
      except

        on E: Exception do

           Application.MessageBox( pWideChar( E.Message ),  'ERRO GERAL', mb_iconError+  MB_OK);

      end;

    end;

  finally

    FreeAndNil(varSPED);
    FreeAndNil(sqlCFOP);
  end;

end;


procedure TfrmSped.Import_Excel(CNPJ_SPED : String);
var
  I: Integer;

  dxSpreadSheet: TdxSpreadSheet;
  varStringList: TStringList;

  varDate: Integer;

  varColumnFilial: Integer;
  varColumnNF: Integer;
  varColumnDataNF: Integer;
  varColumnCFOP: Integer;
  varColumnCST : Integer;
  varColumnUF: Integer;
  varColumnValorContabil: Integer;
  varColumnValorICMS: Integer;
  varColumnAliq_PIS: Integer;
  varColumnAliq_COFINS: Integer;
  varColumnCodProduto: Integer;
  varColumnNovaBase: Integer;
  varColumnNovoValorPIS: Integer;
  varColumnNovoValorCOFINS: Integer;


  varFilial: String;
  varNF: String;
  varDataNF: TDateTime;
  varCFOP: String;
  varUF: String;
  varValorContabil: Extended;
  varValorICMS: Extended;
  varAliq_PIS: Extended;
  varAliq_COFINS: Extended;
  varCodProduto: String;
  varNovaBase: Extended;
  varNovoValorPIS: Extended;
  varNovoValorCOFINS: Extended;


  varScript: TStringList;
  varUltimaColuna : Integer;
  sqlPlanta : TFDQuery;

begin

  dxSpreadSheet := TdxSpreadSheet.Create(nil);
  sqlPlanta     := TFDQuery.Create(Nil);
  try

    sqlPlanta.Connection := DB_Conect.FDConnection;

    sqlPlanta.Close;
    sqlPlanta.SQL.Clear;
    sqlPlanta.SQL.Add('Select * From XML_PLANTA');
    sqlPlanta.Open;

    Mensagem('Lendo Planilha: '+ cxButtonEditPathExcel.Text ,'0');
    dxSpreadSheet.LoadFromFile( cxButtonEditPathExcel.Text);

    varColumnFilial := -1;
    varColumnNF := -1;
    varColumnDataNF := -1;
    varColumnCFOP := -1;
    varColumnUF := -1;
    varColumnValorContabil := -1;
    varColumnValorICMS := -1;
    varColumnAliq_PIS := -1;
    varColumnAliq_COFINS := -1;
    varColumnCodProduto := -1;
    varColumnNovaBase := -1;
    varColumnNovoValorPIS := -1;
    varColumnNovoValorCOFINS := -1;


    varUltimaColuna := dxSpreadSheet.ActiveSheetAsTable.Columns.LastIndex;
    Mensagem('Descobrindo Colunas' ,'0');
    for I := dxSpreadSheet.ActiveSheetAsTable.Columns.FirstIndex to varUltimaColuna do
    begin

      if not  Assigned(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0]) then
         Break;

      if dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString = 'FILIAL' then
        varColumnFilial := I;

      if dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString = 'NUM. NF' then
        varColumnNF := I;

      if dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString = 'DATA NF' then
        varColumnDataNF := I;


      if dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString = 'CFOP' then
        varColumnCFOP := I;

      if dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString = 'UF' then
        varColumnUF := I;

      if dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString = 'BASE PIS' then
        varColumnValorContabil := I;

      if dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString = 'VLR. ICMS' then
        varColumnValorICMS := I;

      if dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString = 'ALIQ PIS' then
        varColumnAliq_PIS := I;

      if dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString = 'ALIQ COFINS' then
        varColumnAliq_COFINS := I;

      if dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString = 'COD. PRODUTO' then
        varColumnCodProduto := I;

      if dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString = 'NOVA BASE PIS/COFINS' then
        varColumnNovaBase := I;

      if dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString = 'NOVO PIS' then
        varColumnNovoValorPIS := I;

      if dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString = 'NOVO COFINS' then
        varColumnNovoValorCOFINS := I;

      if varColumnNovoValorCOFINS <> -1 then
         Break;

    end;


    if varColumnFilial = -1 then
      Application.MessageBox( 'Coluna (FILIAL) n�o foi encontrada',  'SPED', MB_ICONINFORMATION+  MB_OK);

    if varColumnNF = -1 then
      Application.MessageBox( 'Coluna (NUM. NF) n�o foi encontrada',  'SPED', MB_ICONINFORMATION+  MB_OK );

    if varColumnDataNF = -1 then
      Application.MessageBox( 'Coluna (DATA NF) n�o foi encontrada' ,  'SPED', MB_ICONINFORMATION+  MB_OK);

    if varColumnCFOP = -1 then
      Application.MessageBox( 'Coluna (CFOP) n�o foi encontrada',  'SPED', MB_ICONINFORMATION+  MB_OK );

    if varColumnUF = -1 then
      Application.MessageBox( 'Coluna (UF) n�o foi encontrada',  'SPED', MB_ICONINFORMATION+  MB_OK );

    if varColumnValorContabil = -1 then
      Application.MessageBox( 'Coluna (VLR. CONTABIL) n�o foi encontrada',  'SPED', MB_ICONINFORMATION+  MB_OK );

    if varColumnValorICMS = -1 then
      Application.MessageBox( 'Coluna (VLR. ICMS) n�o foi encontrada',  'SPED', MB_ICONINFORMATION+  MB_OK );

    if varColumnAliq_PIS = -1 then
      Application.MessageBox( 'Coluna (ALIQ PIS) n�o foi encontrada' ,  'SPED', MB_ICONINFORMATION+  MB_OK);

    if varColumnAliq_COFINS = -1 then
      Application.MessageBox( 'Coluna (ALIQ COFINS) n�o foi encontrada',  'SPED', MB_ICONINFORMATION+  MB_OK );

    if varColumnCodProduto = -1 then
      Application.MessageBox( 'Coluna (COD. PRODUTO) n�o foi encontrada',  'SPED', MB_ICONINFORMATION+  MB_OK );

    if varColumnNovaBase = -1 then
      Application.MessageBox( 'Coluna (NOVA BASE PIS/COFINS) n�o foi encontrada' ,  'SPED', MB_ICONINFORMATION+  MB_OK);

    if varColumnNovoValorPIS = -1 then
      Application.MessageBox( 'Coluna (NOVO PIS) n�o foi encontrada',  'SPED', MB_ICONINFORMATION+  MB_OK );

    if varColumnNovoValorCOFINS = -1 then
      Application.MessageBox( 'Coluna (NOVO COFINS) n�o foi encontrada' ,  'SPED', MB_ICONINFORMATION+  MB_OK);

    if ((varColumnFilial = -1) or
        (varColumnNF = -1) or
        (varColumnDataNF = -1) or
        (varColumnCFOP = -1) or
        (varColumnUF = -1) or
        (varColumnValorContabil = -1) or
        (varColumnValorICMS = -1) or
        (varColumnAliq_PIS = -1) or
        (varColumnAliq_COFINS = -1) or
        (varColumnCodProduto = -1) or
        (varColumnNovaBase = -1) or
        (varColumnNovoValorPIS = -1) or
        (varColumnNovoValorCOFINS = -1)) then
    begin
         Application.MessageBox( 'Importa��o do Arquivo Excel Abortado' ,  'SPED', MB_ICONEXCLAMATION+  MB_OK);
         Mensagem('' ,'0');
         Abort;
    end;


   // Writeln( 'Criando DataModule' );


      with DB_Conect do
      begin

        FDConnection.Open;
        try

            StatusBar1.Panels[0].Text := 'Status:';
            Mensagem('Aguarde, Processando...' ,'0');
            for I := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to StrToInt(editLinhaExcel.Text)-1 do
            begin

             if (I mod 1000 = 0) and (I > 0) then
             begin
                StatusBar1.Panels[0].Text := ' Processado: ' +  IntToStr(I);
                Application.ProcessMessages;
             end;

              varFilial := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFilial].AsString);

              if length(varFilial) = 4 then
              begin
                 if sqlPlanta.Locate('NUM_PLANTA', varFilial,[]) then
                   varFilial := sqlPlanta.FieldByName('CNPJ').AsString;
              end;


              varNF := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnNF].AsString);

              if dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDataNF].AsString <> '' then
              begin
                  try

                      if dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDataNF].DataType = cdtDateTime then
                        varDataNF := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDataNF].AsDateTime
                      else
                      if TryStrToInt( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDataNF].AsString, varDate ) then
                        varDataNF := varDate
                      else
                        varDataNF := StrToDate(String(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDataNF].AsString).Replace( '.', '/' ));

                  except
                      on E: Exception do
                       begin
                        varPeriodo := '';
                        Application.MessageBox(pWideChar( 'Erro  ' + varNF +  E.Message ),'SPED', mb_iconError +  MB_OK );

                      end;
                  end;

              end;

              varCFOP := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnCFOP].AsString);

              varUF := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnUF].AsString);
              try
              varValorContabil := StrToFloat(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnValorContabil].AsString) ;

              except
                 on E: Exception do
                       begin
                        varPeriodo := '';
                        Application.MessageBox(pWideChar( 'Erro 1 ' + varNF +  E.Message ),'SPED', mb_iconError +  MB_OK );

                      end;
              end;
              try
              varValorICMS := StrToFloat(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnValorICMS].AsString) ;
               except
                 on E: Exception do
                       begin
                        varPeriodo := '';
                        Application.MessageBox(pWideChar( 'Erro 2 ' + varNF +  E.Message ),'SPED', mb_iconError +  MB_OK );

                      end;
              end;
              try
              varAliq_PIS := StrToFloat(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnAliq_PIS].AsString) ;
                           except
                 on E: Exception do
                       begin
                        varPeriodo := '';
                        Application.MessageBox(pWideChar( 'Erro 3 ' + varNF +  E.Message ),'SPED', mb_iconError +  MB_OK );

                      end;
              end;
              try
              varAliq_COFINS := StrToFloat(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnAliq_COFINS].AsString) ;
                       except
                 on E: Exception do
                       begin
                        varPeriodo := '';
                        Application.MessageBox(pWideChar( 'Erro 4 ' + varNF +  E.Message ),'SPED', mb_iconError +  MB_OK );

                      end;
              end;
              varCodProduto := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnCodProduto].AsString);


              varNovaBase := varValorContabil - varValorICMS; // dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnNovaBase].AsFloat ;

              varNovoValorPIS := (varValorContabil - varValorICMS) * varAliq_PIS; // dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnNovoValorPIS].AsFloat ;

              varNovoValorCOFINS :=  (varValorContabil - varValorICMS) * varAliq_COFINS; // dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnNovoValorCOFINS].AsFloat ;



              sqlAuxiliar.Close;
              sqlAuxiliar.SQL.Clear;
              sqlAuxiliar.SQL.Add('INSERT INTO ARQ_NF ');
              sqlAuxiliar.SQL.Add('(PERIODO ');
              sqlAuxiliar.SQL.Add(',CNPJ_SPED ');
              sqlAuxiliar.SQL.Add(',FILIAL');
              sqlAuxiliar.SQL.Add(',NF');
              sqlAuxiliar.SQL.Add(',DATANF ');
              sqlAuxiliar.SQL.Add(',CFOP ');
              //sqlAuxiliar.SQL.Add(',CST');
              sqlAuxiliar.SQL.Add(',COD_ITEM ');
              sqlAuxiliar.SQL.Add(',VALORCONTABIL ');
              sqlAuxiliar.SQL.Add(',VALOR_ICMS ');
              sqlAuxiliar.SQL.Add(',ALIQ_PIS ');
              sqlAuxiliar.SQL.Add(',ALIQ_COFINS ');
              sqlAuxiliar.SQL.Add(',NOVA_BASE ');
              sqlAuxiliar.SQL.Add(',NOVO_VALOR_PIS ');
              sqlAuxiliar.SQL.Add(',NOVO_VALOR_COFINS)');
              sqlAuxiliar.SQL.Add('VALUES (  ');
              sqlAuxiliar.SQL.Add(' :PERIODO ');
              sqlAuxiliar.SQL.Add(',:CNPJ_SPED ');
              sqlAuxiliar.SQL.Add(',:FILIAL ');
              sqlAuxiliar.SQL.Add(',:NF ');
              sqlAuxiliar.SQL.Add(',:DATANF ');
              sqlAuxiliar.SQL.Add(',:CFOP ');
           //   sqlAuxiliar.SQL.Add(',:CST ');
              sqlAuxiliar.SQL.Add(',:COD_ITEM ');
              sqlAuxiliar.SQL.Add(',:VALORCONTABIL ');
              sqlAuxiliar.SQL.Add(',:VALOR_ICMS ');
              sqlAuxiliar.SQL.Add(',:ALIQ_PIS  ');
              sqlAuxiliar.SQL.Add(',:ALIQ_COFINS ');
              sqlAuxiliar.SQL.Add(',:NOVA_BASE ');
              sqlAuxiliar.SQL.Add(',:NOVO_VALOR_PIS  ');
              sqlAuxiliar.SQL.Add(',:NOVO_VALOR_COFINS)');

              sqlAuxiliar.Params.ParamByName('PERIODO').AsString           :=  varPeriodo;
              sqlAuxiliar.Params.ParamByName('CNPJ_SPED').AsString         :=  CNPJ_SPED;

              sqlAuxiliar.Params.ParamByName('FILIAL').AsString            :=  varFilial;
              sqlAuxiliar.Params.ParamByName('NF').AsString                :=  varNF;
              sqlAuxiliar.Params.ParamByName('DATANF').AsDateTime          :=  varDataNF;
              sqlAuxiliar.Params.ParamByName('CFOP').AsString              :=  varCFOP;
            //  sqlAuxiliar.Params.ParamByName('CST').AsString               :=  varPeriodo;
              sqlAuxiliar.Params.ParamByName('COD_ITEM').AsString          :=  varCodProduto;
              sqlAuxiliar.Params.ParamByName('VALORCONTABIL').asFloat     :=  varValorContabil;
              sqlAuxiliar.Params.ParamByName('VALOR_ICMS').asFloat        :=  varValorICMS;
              sqlAuxiliar.Params.ParamByName('ALIQ_PIS').asFloat          :=  varAliq_PIS;
              sqlAuxiliar.Params.ParamByName('ALIQ_COFINS').asFloat       :=  varAliq_COFINS;
              sqlAuxiliar.Params.ParamByName('NOVA_BASE').asFloat         :=  varNovaBase;
              sqlAuxiliar.Params.ParamByName('NOVO_VALOR_PIS').asFloat    :=  varNovoValorPIS;
              sqlAuxiliar.Params.ParamByName('NOVO_VALOR_COFINS').asFloat :=  varNovoValorCOFINS;

              try
                 sqlAuxiliar.ExecSQL;

              except

                on E: Exception do
                begin
                  varPeriodo := '';
                  Application.MessageBox(pWideChar( 'Erro ao Salvar Registro: ' + E.Message ),'SPED', mb_iconError +  MB_OK );

                end;

              end;

            end;

        finally

          FDConnection.Close;

        end;

      end;


  finally

    FreeAndNil(dxSpreadSheet);
    FreeAndNil(sqlPlanta);
  end;

  Mensagem('' ,'0');

{
  Writeln('Copiando arquivo para backup. ', 'C:\Brady\Files\SOP\Arquivos\'+FSearchRecord.Name );
  CopyFile( PWideChar('C:\Brady\Files\SOP\Arquivos\'+FSearchRecord.Name), PWideChar('C:\Brady\Files\SOP\Arquivos\Backup\'+FSearchRecord.Name), True );

  Writeln('Apagando arquivo. ', MyDocumentsPath+'\'+FSearchRecord.Name );
  DeleteFile( PWideChar('C:\Brady\Files\SOP\Arquivos\'+FSearchRecord.Name) );

  Writeln('Apagando arquivo local. ', MyDocumentsPath+'\'+FSearchRecord.Name );
  DeleteFile(PWideChar(MyDocumentsPath+'\'+FSearchRecord.Name));
 }

end;



{ TApuracao }

procedure TApuracao.LimpaRecord;
begin
   REGISTRO      :='';
   CST           :='';
   CNPJ          :='';
   PERIODO       :='';
   VALOR_BASE    := 0.00;
   PIS_PORC      := 0.00;
   VALOR_PIS     := 0.00;
   COFINS_PORC   := 0.00;
   VALOR_COFINS  := 0.00;
end;

end.


