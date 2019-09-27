unit uCadTreinamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FCadastro, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinsdxStatusBarPainter, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls, cxButtons,
  dxStatusBar, Vcl.Mask, rsEdit, RseditDB, cxContainer, cxEdit, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxGroupBox, cxRadioGroup,MensFun,TestFun,Constantes, Data.FMTBcd, Data.DB,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Datasnap.DBClient,
  Datasnap.Provider,  cxLabel, Global, StrFun, dxSkinscxPCPainter,
  dxBarBuiltInMenu, cxPC, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, EditBusca, SetParametro,
   FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.SqlExpr, dxSpreadSheet, dxGDIPlusClasses,
  cxButtonEdit, Vcl.ImgList, ShellApi, Vcl.Buttons;

type
  TFrmCadTreinamento = class(TFrmCadastro)
    editxtObrigacao: TrsSuperEdit;
    dtsTipoTreinamento: TDataSource;
    Page: TcxPageControl;
    tabTreinamento: TcxTabSheet;
    TabParticipante: TcxTabSheet;
    Panel1: TPanel;
    EdiCodigo: TrsSuperEdit;
    Panel2: TPanel;
    EdiCodigoCurso: TrsSuperEdit;
    Panel3: TPanel;
    ediCodigoFornecedor: TrsSuperEdit;
    Panel4: TPanel;
    ediCodigoInstrutor: TrsSuperEdit;
    Panel5: TPanel;
    editxtDtRealizacao: TrsSuperEdit;
    Panel6: TPanel;
    ediCargaHoraria: TrsSuperEdit;
    Panel7: TPanel;
    MemSumario: TMemo;
    editxtSumario: TrsSuperEdit;
    Panel8: TPanel;
    MemObjetivo: TMemo;
    editxtObjetivo: TrsSuperEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    Panel9: TPanel;
    ediTipoTreinamento: TrsSuperEdit;
    cmbTipoTreinamento: TcxLookupComboBox;
    Panel10: TPanel;
    editxtPeriodicidade: TrsSuperEdit;
    Panel11: TPanel;
    rgObrigacao: TcxRadioGroup;
    ediUsuarioCad: TrsSuperEdit;
    EdiNomeCurso: TrsSuperEdit;
    dsPeriodo: TDataSource;
    cmbPeriodo: TcxLookupComboBox;
    Panel14: TPanel;
    Panel21: TPanel;
    ButNovoItem: TcxButton;
    ButAlterarItem: TcxButton;
    ButExcluirItem: TcxButton;
    ButSalvarItem: TcxButton;
    ButCAncelarItem: TcxButton;
    PageItem: TcxPageControl;
    tsbGrid: TcxTabSheet;
    tsbEdicao: TcxTabSheet;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    Panel13: TPanel;
    dsParticipante: TDataSource;
    cxGrid1DBTableView1FUN_MATRICULA: TcxGridDBColumn;
    cxGrid1DBTableView1PAR_SCORE: TcxGridDBColumn;
    cxGrid1DBTableView1PAR_APROVADO: TcxGridDBColumn;
    cxGrid1DBTableView1FUN_CARGO: TcxGridDBColumn;
    cxGrid1DBTableView1FUN_NOME: TcxGridDBColumn;
    cxGrid1DBTableView1ALIASEMPRESA: TcxGridDBColumn;
    Panel15: TPanel;
    cxGroupBox1: TcxGroupBox;
    Panel16: TPanel;
    ediScore: TrsSuperEdit;
    Label1: TLabel;
    pnlAprovado: TPanel;
    pnlReprovado: TPanel;
    spbLimpaScore: TcxButton;
    editxtDtTermino: TrsSuperEdit;
    TabAnexar: TcxTabSheet;
    EditBuscaTreinamento: TEditBusca;
    EditBuscaFornecedor: TEditBusca;
    EditBuscaCurso: TEditBusca;
    EditBuscaInstrutor: TEditBusca;
    EditBuscaParticipante: TEditBusca;
    qryAux: TFDQuery;
    sqlPeriodo: TFDQuery;
    sqlTipoTreinamento: TFDQuery;
    sqlParticipante: TFDQuery;
    spbLimpaTreinamento: TcxButton;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxButton3: TcxButton;
    cxButton5: TcxButton;
    sqlParticipanteTRE_PARTICIPANTES_ID: TFDAutoIncField;
    sqlParticipanteTRE_TREINAMENTO_ID: TIntegerField;
    sqlParticipanteFUN_MATRICULA: TStringField;
    sqlParticipanteFUN_CARGO: TStringField;
    sqlParticipanteFUN_NOME: TStringField;
    sqlParticipanteALIASEMPRESA: TStringField;
    sqlParticipantePAR_SCORE: TBCDField;
    sqlParticipantePAR_APROVADO: TStringField;
    sqlParticipanteCODFILIAL: TStringField;
    EdiDatIni: TcxDateEdit;
    EdiDatFim: TcxDateEdit;
    btnDownload: TcxButton;
    btnUpload: TcxButton;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    Panel12: TPanel;
    cxGrid2: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1CAMINHO: TcxGridDBColumn;
    cxGrid1DBTableView1NOMEARQUIVO: TcxGridDBColumn;
    cxGrid1DBTableView1DATACADASTRO: TcxGridDBColumn;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    Panel17: TPanel;
    cxbEditPath: TcxButtonEdit;
    btnSalvaArq: TcxButton;
    ImageList1: TImageList;
    sqlArquivo: TFDQuery;
    sqlArquivoCAMINHO: TStringField;
    sqlArquivoNOMEARQUIVO: TStringField;
    sqlArquivoDATACADASTRO: TSQLTimeStampField;
    dsArquivo: TDataSource;
    pnlShowLog: TPanel;
    cxGrid3DBTableView1: TcxGridDBTableView;
    cxGrid3Level1: TcxGridLevel;
    cxGrid3: TcxGrid;
    sqlErroImport: TFDQuery;
    dsErroImport: TDataSource;
    sqlErroImportTRE_ERRO_IMPORTACAO_ID: TFDAutoIncField;
    sqlErroImportTRE_TREINAMENTO_ID: TIntegerField;
    sqlErroImportCAMPO: TStringField;
    sqlErroImportMOTIVO: TStringField;
    sqlErroImportDATA_IMPORTACAO: TSQLTimeStampField;
    cxGrid3DBTableView1TRE_ERRO_IMPORTACAO_ID: TcxGridDBColumn;
    cxGrid3DBTableView1TRE_TREINAMENTO_ID: TcxGridDBColumn;
    cxGrid3DBTableView1CAMPO: TcxGridDBColumn;
    cxGrid3DBTableView1MOTIVO: TcxGridDBColumn;
    cxGrid3DBTableView1DATA_IMPORTACAO: TcxGridDBColumn;
    Panel19: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Fechar: TBitBtn;
    Panel18: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ediCodigoInstrutorEnter(Sender: TObject);
    procedure ediCargaHorariaKeyPress(Sender: TObject; var Key: Char);
    procedure ButNovoClick(Sender: TObject);
    procedure ButSalvarClick(Sender: TObject);
    procedure ButCancelarClick(Sender: TObject);
    procedure ButAlterarItemClick(Sender: TObject);
    procedure ButSalvarItemClick(Sender: TObject);
    procedure ButCAncelarItemClick(Sender: TObject);
    procedure ButNovoItemClick(Sender: TObject);
    procedure ButExcluirItemClick(Sender: TObject);
    procedure ediScoreExit(Sender: TObject);
    procedure spbLimpaScoreClick(Sender: TObject);
    procedure EdiCodigoEmpresaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PageChange(Sender: TObject);
    procedure EditBuscaInstrutorEnter(Sender: TObject);
    procedure spbLimpaTreinamentoClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
    procedure EditBuscaTreinamentoClick(Sender: TObject);
    procedure ButExcluirClick(Sender: TObject);
    procedure EditBuscaCursoClick(Sender: TObject);
    procedure EditBuscaFornecedorClick(Sender: TObject);
    procedure EditBuscaInstrutorClick(Sender: TObject);
    procedure btnDownloadClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure cxbEditPathClick(Sender: TObject);
    procedure btnSalvaArqClick(Sender: TObject);
    procedure cxGrid1DBTableView1Column1PropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FecharClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    bLog : Boolean;
    varPathRede : String;
    ContaItem   : integer;
    Var_OperacaoItem : Integer;
    varAprovado : String;
    Function  Check : Boolean ; Override ;
    Procedure Search ; Override;
    procedure LimpaTela;
    procedure ButItensOnOff(S: String);
    procedure FiltroItens;
    function BuscaNotaMinima: Double;
    procedure LimpaTelaItens;
    procedure Mensagem(pMensagem: String);
    function VincularFilial(CNPJ, NomeEmpresa : String): String;
    function VincularCargo(DescCargo: String): Integer;
    function VincularCentroCusto(CentroCustoID,
      DescCentroCusto: String): String;
    function GerarMatricula: String;
    function ChecarCaminhoRede: Boolean;
    procedure AtualizaGridArquivos;
    procedure SalvarLogImport(Campo, Motivo : String);
    procedure AbrirTabelaLog;
  public
    { Public declarations }
  end;

var
  FrmCadTreinamento: TFrmCadTreinamento;

implementation

{$R *.dfm}

uses DBConect;

procedure TFrmCadTreinamento.ButItensOnOff(S: String);
begin
  ButNovoItem.Enabled     := Copy(S,1,1) = 'T' = True;
  ButAlterarItem.Enabled  := Copy(S,2,1) = 'T' = True;
  ButExcluirItem.Enabled  := Copy(S,3,1) = 'T' = True;
  ButSalvarItem.Enabled   := Copy(S,4,1) = 'T' = True;
  ButCancelarItem.Enabled := Copy(S,5,1) = 'T' = True;

  //cxgTotal.Visible        := not ButSalvarItem.Enabled;

end;


procedure TFrmCadTreinamento.ButAlterarItemClick(Sender: TObject);
begin

  PageItem.ActivePage   := tsbEdicao;
  pnlAprovado.Visible   := false;
  pnlReprovado.Visible  := false;

  varAprovado := '';
  EditBuscaParticipante.SetValue('P.FUN_MATRICULA = ' + QuotedStr(sqlParticipanteFUN_MATRICULA.AsString));
  ediScore.AsDouble           := sqlParticipantePAR_SCORE.AsFloat;
  varAprovado                 := sqlParticipantePAR_APROVADO.AsString;

  ediScoreExit(Nil);

  ButItensOnOff('FFFTTFFF');
  Var_OperacaoItem := 2;

  inherited;
end;

procedure TFrmCadTreinamento.ButCancelarClick(Sender: TObject);
begin
  EditBuscaParticipante.Text := '';
  EditBuscaParticipante.bs_KeyValues.Clear;

  Page.ActivePage := tabTreinamento;
  LimpaTela;

  inherited;

end;

procedure TFrmCadTreinamento.FecharClick(Sender: TObject);
begin
  inherited;
  sqlErroImport.Close;
  pnlShowLog.Visible := False;
end;

procedure  TFrmCadTreinamento.FiltroItens;
begin
  sqlParticipante.Close;
  sqlParticipante.Params.ParamByName('TRE_TREINAMENTO_ID').AsInteger := EdiCodigo.AsInteger;
  sqlParticipante.Open;
end;

procedure TFrmCadTreinamento.LimpaTelaItens;
begin
  varAprovado := '';

  EditBuscaParticipante.Text := '';
  EditBuscaParticipante.bs_KeyValues.Clear;

  ediScore.Clear;
  pnlAprovado.Visible := false;
  pnlReprovado.Visible := false;
  Update;
end;

procedure TFrmCadTreinamento.PageChange(Sender: TObject);
begin
  inherited;
  if ((VarOperacao = OPE_INCLUSAO) and (Page.ActivePage =  TabParticipante)) Then
  begin
     Mens_MensInf( 'Salve o Treinamento antes de incluir os Participantes ');
     Page.ActivePage := tabTreinamento;
  end;

  if ((VarOperacao = OPE_INCLUSAO) and (Page.ActivePage =  TabAnexar)) Then
  begin
     Mens_MensInf( 'Salve o Treinamento antes de Anexar Arquivos ');
     Page.ActivePage := tabTreinamento;
  end;
end;

procedure TFrmCadTreinamento.ButCAncelarItemClick(Sender: TObject);
begin
  inherited;
  LimpaTelaItens;

  Dec(ContaItem);
//  FiltroItens;
  ButItensOnOff('TTTFFTTT');
  Var_OperacaoItem := 0;
  PageItem.ActivePage := tsbGrid;
  cxGrid1.SetFocus;
  cxGrid1.Focused;
end;

procedure TFrmCadTreinamento.ButExcluirClick(Sender: TObject);
begin
  inherited;
  Page.ActivePage := tabTreinamento;
  LimpaTela;
end;

procedure TFrmCadTreinamento.ButExcluirItemClick(Sender: TObject);
begin
  inherited;
  varAprovado := '';
  Var_OperacaoItem := 0;
  If Mens_MensConf(pchar('Confirma Exclus�o do Participante ' + sqlParticipanteFUN_NOME.AsString + ' ?')) <> mrOk then
    Exit;

  qryAux.Close;
  qryAux.Sql.Clear;
  qryAux.SQL.Add('Delete from TRE_PARTICIPANTES ');
  qryAux.SQL.Add(' Where TRE_TREINAMENTO_ID = :TRE_TREINAMENTO_ID ');
  qryAux.SQL.Add(' and FUN_MATRICULA = :FUN_MATRICULA ');
  qryAux.Params.ParamByName('TRE_TREINAMENTO_ID').AsString := sqlParticipanteTRE_TREINAMENTO_ID.AsString;
  qryAux.Params.ParamByName('FUN_MATRICULA').AsString      := sqlParticipanteFUN_MATRICULA.AsString;
  Try
    qryAux.ExecSQL;
  Except
     On E:Exception do
      begin
        Mens_MensInf( 'Erro ao Excluir Participante: ' + E.Message );
      end;
  End;

  FiltroItens;
  if PageItem.ActivePage = tsbEdicao then
    LimpaTelaItens;

end;

procedure TFrmCadTreinamento.ButNovoClick(Sender: TObject);
begin
  inherited;
  qryAux.Close;
  qryAux.Sql.Clear;
  qryAux.Sql.Add('Select CodigoTreinamento From Parametros ') ;
  qryAux.Open;
  ediCodigo.AsInteger := qryAux.FieldByName('CodigoTreinamento').AsInteger + 1 ;
  qryAux.close;

  editxtDtRealizacao.Text := Str_DateToStr(Date) ;
  EdiDatIni.Date := editxtDtRealizacao.AsDateTime;

  //EditBuscaTreinamento.SetValue('TRE_TREINAMENTO_ID = ' + EdiCodigo.AsString);
  EditBuscaTreinamento.Text := EdiCodigo.AsString;
  EditBuscaCurso.SetFocus;

end;

procedure TFrmCadTreinamento.ButNovoItemClick(Sender: TObject);
begin
  inherited;

  PageItem.ActivePage     := tsbEdicao;
  LimpaTelaItens;


  ButItensOnOff('FFFTTFFF');
  Var_OperacaoItem    := 1;
  Inc(ContaItem);
end;

procedure TFrmCadTreinamento.ButSalvarClick(Sender: TObject);
var
  Inclui : Boolean;
  varUltCodigo : Integer;
begin
  if Page.ActivePage = tabTreinamento then
  begin

      Inclui := (VarOperacao = OPE_INCLUSAO);
      if Inclui then
         varUltCodigo := EdiCodigo.AsInteger;
      inherited;

      if (not FormOpeErro) and (Inclui) then
      begin

        qryAux.Close;
        qryAux.Sql.Clear;
        qryAux.Sql.Add('update Parametros set CodigoTreinamento = CodigoTreinamento + 1 ') ;
        qryAux.ExecSQL;

        EditBuscaParticipante.Text := '';
        EditBuscaParticipante.bs_KeyValues.Clear;

        LimpaTela;
        EdiCodigo.AsInteger := varUltCodigo;
        EditBuscaTreinamento.SetValue('TRE_TREINAMENTO_ID='+ QuotedStr(EdiCodigo.AsString));
        EditBuscaTreinamentoClick(self);


      end
      else
      begin
         if Inclui = False then
         begin
           EdiCodigo.Clear;
           EditBuscaParticipante.Text := '';
           EditBuscaParticipante.bs_KeyValues.Clear;
           LimpaTela;
         end;
      end;


  end;
end;

procedure TFrmCadTreinamento.ButSalvarItemClick(Sender: TObject);
Var
 sqlGravar : TFDQuery;
 sqlFunc   : TFDQuery;
 varCentroCusto, varCargo : String;
begin
   if ((EditBuscaParticipante.Text = '') or (EditBuscaParticipante.bs_KeyValues.Count = 0)) Then
   begin
      Mens_MensInf('Informe o nome do Participante.');
      exit;
   end;

   sqlGravar := TFDQuery.Create(Nil);
   sqlFunc := TFDQuery.Create(Nil);
   Try
     sqlGravar.Connection := DB_Conect.SQLConnection;
     sqlFunc.Connection := DB_Conect.SQLConnection;


     sqlFunc.Close;
     sqlFunc.SQL.Clear;
     sqlFunc.SQL.Add('SELECT TRE_CARGO_ID, TRE_CENTROCENTRO FROM tre_funcionario WHERE FUN_MATRICULA = :FUN_MATRICULA');
     sqlFunc.Params.ParamByName('FUN_MATRICULA').AsString :=   VarToStr(EditBuscaParticipante.bs_KeyValue);
     sqlFunc.Open;
     if not sqlFunc.IsEmpty then
     begin
        varCentroCusto  := sqlFunc.FieldByName('TRE_CENTROCENTRO').AsString;
        varCargo        := sqlFunc.FieldByName('TRE_CARGO_ID').AsString;
     end;

     sqlGravar.Close;
     sqlGravar.SQL.Clear;
     if Var_OperacaoItem = 1 then
     begin

        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('Select TRE_TREINAMENTO_ID from TRE_PARTICIPANTES');
        qryAux.SQL.Add(' Where TRE_TREINAMENTO_ID = :TRE_TREINAMENTO_ID ');
        qryAux.SQL.Add(' and FUN_MATRICULA = :FUN_MATRICULA ');
        qryAux.Params.ParamByName('TRE_TREINAMENTO_ID').AsString := EdiCodigo.AsString;
        qryAux.Params.ParamByName('FUN_MATRICULA').AsString      := VarToStr(EditBuscaParticipante.bs_KeyValue);
        qryAux.Open;
        if qryAux.IsEmpty then
        begin

            sqlGravar.SQL.Add('Insert into TRE_PARTICIPANTES (TRE_TREINAMENTO_ID, FUN_MATRICULA, PAR_SCORE, PAR_APROVADO, TRE_CARGO_ID, TRE_CENTROCENTRO)');
            sqlGravar.SQL.Add('Values ( :TRE_TREINAMENTO_ID, :FUN_MATRICULA, :PAR_SCORE, :PAR_APROVADO, :TRE_CARGO_ID, :TRE_CENTROCENTRO)');
            sqlGravar.Params.ParamByName('TRE_TREINAMENTO_ID').AsString := EdiCodigo.AsString;
            sqlGravar.Params.ParamByName('FUN_MATRICULA').AsString      := VarToStr(EditBuscaParticipante.bs_KeyValue);
            sqlGravar.Params.ParamByName('PAR_SCORE').asFloat           := ediScore.asDouble;
            sqlGravar.Params.ParamByName('PAR_APROVADO').AsString       := varAprovado;
            sqlGravar.Params.ParamByName('TRE_CARGO_ID').AsString       := varCargo;
            sqlGravar.Params.ParamByName('TRE_CENTROCENTRO').AsString   := varCentroCusto;

            Try
              sqlGravar.ExecSQL;
            Except
               On E:Exception do
                begin
                  Mens_MensInf( 'Erro ao Inserir Participante: ' + E.Message );
                end;
            End;
        end
        else
        begin
            Mens_MensInf('Participante j� esta inscrito neste Treinamento!');
            LimpaTelaItens;
        end;
     end
     else
     if Var_OperacaoItem = 2 then
     begin
        sqlGravar.SQL.Add(' UPDATE TRE_PARTICIPANTES ');
        sqlGravar.SQL.Add(' SET PAR_SCORE = :PAR_SCORE, ');
        sqlGravar.SQL.Add(' PAR_APROVADO = :PAR_APROVADO  ');
        sqlGravar.SQL.Add(' Where TRE_TREINAMENTO_ID = :TRE_TREINAMENTO_ID ');
        sqlGravar.SQL.Add(' and FUN_MATRICULA = :FUN_MATRICULA ');
        sqlGravar.Params.ParamByName('TRE_TREINAMENTO_ID').AsString := EdiCodigo.AsString;
        sqlGravar.Params.ParamByName('FUN_MATRICULA').AsString      := VarToStr(EditBuscaParticipante.bs_KeyValue);
        sqlGravar.Params.ParamByName('PAR_SCORE').asFloat           := ediScore.asDouble;
        sqlGravar.Params.ParamByName('PAR_APROVADO').AsString       := varAprovado;
        Try
          sqlGravar.ExecSQL;
        Except
           On E:Exception do
            begin
              Mens_MensInf( 'Erro ao Alterar Participante: ' + E.Message );
            end;
        End;
     end;
   Finally
     FreeAndNil(sqlGravar);
     FreeAndNil(sqlFunc);
   End;

  LimpaTelaItens;

  FiltroItens;
  ButItensOnOff('TTTFFTTT');
  Var_OperacaoItem := 0;
  PageItem.ActivePage := tsbGrid;

  inherited;

end;

procedure  TFrmCadTreinamento.LimpaTela;
begin

    Page.ActivePage := TabParticipante;
    PageItem.ActivePage := tsbEdicao;



    PageItem.ActivePage := tsbGrid;
    Page.ActivePage := tabTreinamento;

    EditBuscaTreinamento.Text := '';
    EditBuscaTreinamento.bs_KeyValues.Clear;

    EditBuscaCurso.Text := '';
    EditBuscaCurso.bs_KeyValues.Clear;

    EditBuscaFornecedor.Text := '';
    EditBuscaFornecedor.bs_KeyValues.Clear;

    EditBuscaInstrutor.Text := '';
    EditBuscaInstrutor.bs_KeyValues.Clear;


    EdiNomeCurso.Clear;
    MemSumario.Clear;
    MemObjetivo.Clear;
    if cmbPeriodo.ItemIndex.Size > 0 then
      cmbPeriodo.ItemIndex  := 0;

    if cmbTipoTreinamento.ItemIndex.Size > 0 then
      cmbTipoTreinamento.ItemIndex := 0;

    if rgObrigacao.ItemIndex.Size > 0 then
      rgObrigacao.ItemIndex := 0;
    EdiDatFim.Clear;

end;

function TFrmCadTreinamento.Check: Boolean;
begin
	 Result := False ;


   If ( Test_IsEmptyStr(EditBuscaTreinamento.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Codigo do Treinamento ') ;
			 EditBuscaTreinamento.SetFocus ;
			 Exit ;
	 End ;


	 If ( Test_IsEmptyStr(EditBuscaCurso.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Nome do Curso ') ;
			 EditBuscaCurso.SetFocus ;
			 Exit ;
	 End ;

   EdiNomeCurso.AsString := EditBuscaCurso.Text;

   If ( Test_IsEmptyStr(EditBuscaFornecedor.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Nome do Fornecedor ') ;
			 EditBuscaFornecedor.SetFocus ;
			 Exit ;
	 End ;

   If ( Test_IsEmptyStr(ediCodigoInstrutor.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Nome do Instrutor ') ;
			 ediCodigoInstrutor.SetFocus ;
			 Exit ;
	 End ;


   If ( Test_IsEmptyStr(ediCargaHoraria.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar a Carga Hor�ria ') ;
			 ediCargaHoraria.SetFocus ;
			 Exit ;
	 End ;


   if ((cmbTipoTreinamento.EditValue = null) or (cmbTipoTreinamento.EditValue = -1)) then
   begin
			 Mens_MensInf('Tipo do Treinamento n�o Informado! ') ;
			 cmbTipoTreinamento.SetFocus ;
			 Exit ;
   end
   else
     ediTipoTreinamento.AsString   := cmbTipoTreinamento.EditValue;


   if ((cmbPeriodo.EditValue = null) or (cmbPeriodo.EditValue = -1)) then
   begin
			 Mens_MensInf('Periodicidade n�o Informado! ') ;
			 cmbPeriodo.SetFocus ;
			 Exit ;
   end
   else
     editxtPeriodicidade.AsString   := cmbPeriodo.EditValue;

    editxtDtRealizacao.AsDateTime := EdiDatIni.Date;

    If ( editxtDtRealizacao.Text = '00/00/0000' ) Then
    Begin
        Mens_MensInf('Data Inicial n�o pode ser nula') ;
        EdiDatIni.SetFocus ;

        Exit ;
    End;

    editxtDtRealizacao.ValidateData;

    editxtDtTermino.AsDateTime := EdiDatFim.Date;

    If ( editxtDtTermino.Text = '00/00/0000' ) Then
    Begin
        Mens_MensInf('Data T�rmino n�o pode ser nula') ;
        EdiDatFim.SetFocus ;

        Exit ;
    End;
    editxtDtTermino.ValidateData;

    If (( editxtDtTermino.AsDateTime < editxtDtRealizacao.AsDateTime ) and (VarOperacao = OPE_INCLUSAO)) Then
    Begin
        Mens_MensInf('Data T�rmino n�o pode ser anterior � Data Inicial') ;
        editxtDtTermino.SetFocus ;
        Exit ;
    End;


    editxtSumario.Text            := MemSumario.Lines.Text;
    editxtObjetivo.Text           := MemObjetivo.Lines.Text;
   //editxtPeriodicidade.AsInteger := cxbPeriodicidade.ItemIndex;
    editxtObrigacao.Text          := rgObrigacao.EditValue;
    ediUsuarioCad.Text            := GUsuario;

   Result := True;
end;

procedure TFrmCadTreinamento.cxbEditPathClick(Sender: TObject);
begin
  inherited;
  if OpenDialog.Execute then
   cxbEditPath.Text := OpenDialog.FileName;
end;

procedure TFrmCadTreinamento.cxButton1Click(Sender: TObject);
begin
  inherited;
  EditBuscaCurso.Text;
  EditBuscaCurso.bs_KeyValues.Clear;
end;

procedure TFrmCadTreinamento.cxButton2Click(Sender: TObject);
begin
  inherited;
  EditBuscaFornecedor.Text;
  EditBuscaFornecedor.bs_KeyValues.Clear;
end;

procedure TFrmCadTreinamento.cxButton3Click(Sender: TObject);
begin
  inherited;
  EditBuscaInstrutor.Text;
  EditBuscaInstrutor.bs_KeyValues.Clear;
end;

procedure TFrmCadTreinamento.cxButton5Click(Sender: TObject);
begin
  inherited;
  EditBuscaParticipante.Text;
  EditBuscaParticipante.bs_KeyValues.Clear;
end;

procedure TFrmCadTreinamento.cxGrid1DBTableView1Column1PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if FileExists(sqlArquivoCAMINHO.AsString + '\' + sqlArquivoNOMEARQUIVO.AsString) Then
    ShellExecute(handle,'open',PChar(sqlArquivoCAMINHO.AsString + '\' + sqlArquivoNOMEARQUIVO.AsString ), '','',SW_SHOWNORMAL)
  else
    Mens_MensErro('Arquivo n�o encontrado em ' + sqlArquivoCAMINHO.AsString);
end;

procedure TFrmCadTreinamento.ediCargaHorariaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (not ((Key in ['0'..'9',#8]))) then
      Key:= #0;
end;

procedure TFrmCadTreinamento.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;


procedure TFrmCadTreinamento.BitBtn1Click(Sender: TObject);
begin
  inherited;
  If  (Mens_MensConf(  'Confirma Exclus�o do Log do Treinamento Nr� ' + EditBuscaTreinamento.bs_KeyValue + ' ?') = mrOk ) Then
  begin
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('Delete from TRE_ERRO_IMPORTACAO where TRE_TREINAMENTO_ID = :TRE_TREINAMENTO_ID');
    qryAux.Params.ParamByName('TRE_TREINAMENTO_ID').AsInteger := EditBuscaTreinamento.bs_KeyValue;
    Try
      qryAux.ExecSQL;
    Except
         On E:Exception do
          begin
            Mens_MensInf( 'Erro ao Excluir Log: ' + E.Message );
          end;
    End;
    AbrirTabelaLog;
  end;

end;

procedure TFrmCadTreinamento.BitBtn2Click(Sender: TObject);
begin
  inherited;
  If ( Mens_MensConf( 'Confirma Exclus�o de Todos os Logs ?') = mrOk ) Then
  begin
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('Delete from TRE_ERRO_IMPORTACAO');
    Try
      qryAux.ExecSQL;
    Except
         On E:Exception do
          begin
            Mens_MensInf( 'Erro ao Excluir Log: ' + E.Message );
          end;
    End;
    AbrirTabelaLog;
  end;
end;

procedure TFrmCadTreinamento.btnDownloadClick(Sender: TObject);
var
  X, I: Integer;
  dxSpreadSheet: TdxSpreadSheet;
  varData: TDateTime;
  MyDocumentsPath : String;
  varPath : String;
begin

  if SaveDialog.Execute then
      varPath := SaveDialog.FileName;

  if ((Pos('.',VarPath) = 0) or (ExtractFileExt(varPath) <> '.xlsx')) then
  begin
    varPath := Str_Pal(varPath,1,'.');
    varPath := varPath + '.xlsx';
  end;

  Mensagem( 'Iniciando processo de download...' );
  try
    MyDocumentsPath := ExtractFilePath(Application.ExeName);

    Mensagem( 'Criando planilha...' );
    DeleteFile(PWideChar(MyDocumentsPath+'\ListaParticipante.xlsx'));
    CopyFile( PWideChar('\\ghos2024\Brady\ListaParticipante.xlsx'), PWideChar(MyDocumentsPath+'\ListaParticipante.xlsx'), True );

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    try

      Mensagem( 'Carregando modelo da planilha...' );
      dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\ListaParticipante.xlsx' );
      dxSpreadSheet.BeginUpdate;


      for I := 0 to 9 do
      begin

        with dxSpreadSheet.ActiveSheetAsTable.CreateCell(0,I) do;

      end;


        try

           for X := 1 to 3 do

            begin

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
                begin

                  AsVariant := '99.999.9999/9999-99';   // CNPJ da empresa

                end;

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
                begin

                  AsVariant := 'XXXXXXX... - At� 50 Posi��es';   // Nome da empresa

                end;

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,2) do
                begin

                  AsVariant :=  'XXXXXXX... - At� 6 Posi��es';   // Matricula

                end;

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,3) do
                begin

                  AsVariant := 'XXXXXXX... - At� 100 Posi��es';  // Nome do Participante

                end;

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,4) do
                begin

                  AsVariant := 'Masculino ou Feminino';  // Sexo

                end;


                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,5) do
                begin

                  AsVariant := '99/99/9999';  // Data de Nascimento

                end;

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,6) do
                begin

                  AsVariant := '99/99/9999';  // Data de Admiss�o

                end;

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,7) do
                begin

                  AsVariant := '99/99/9999';  // Data de Demiss�o

                end;

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,8) do
                begin

                  AsVariant := 'XXXXXXX... - At� 100 Posi��es';  // Nome do Cargo

                end;

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,9) do
                begin

                  AsVariant := 'XXXXXXX... - At� 20 Posi��es';  // Codigo do Centro de Custo

                end;

                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,10) do
                begin

                  AsVariant := 'XXXXXXX... - At� 100 Posi��es';  // Descri��o do Centro de Custo

                end;


                Application.ProcessMessages;
            end;



        except
            On E:Exception do
            begin
              Mens_MensInf( 'Erro ao Gerar Planilha Participante: ' + E.Message );
            end;

        end;

        Mensagem( 'Salvando a planilha...' );

        Try

         dxSpreadSheet.SaveToFile( varPath );

        except
            On E:Exception do
            begin
              Mens_MensInf( 'Erro ao Gerar Download Planilha Participante: ' + E.Message );
              Exit;
            end;

        end;



    finally

      FreeAndNil(dxSpreadSheet);

    end;

  finally

    Mensagem( EmptyStr );

  end;

  Mens_MensInf('Planilha gerada com sucesso.' + #13#10 + 'Arquivo: ' + varPath );


end;

function TFrmCadTreinamento.VincularFilial(CNPJ, NomeEmpresa : String) : String;
var
 vCodFilial : Integer;
 sqlFilial_C, sqlFilial_I : TFDQuery;
begin
  sqlFilial_C := TFDQuery.Create(Nil);
  sqlFilial_I := TFDQuery.Create(Nil);
  Try
      sqlFilial_C.Connection := DB_Conect.SQLConnection;
      sqlFilial_I.Connection := DB_Conect.SQLConnection;

      vCodFilial := 0;
      sqlFilial_C.Close;
      sqlFilial_C.SQL.Clear;
      sqlFilial_C.SQL.Add('Select CodFilial from Filial Where CNPJ = :CNPJ');
      sqlFilial_C.Params.ParamByName('CNPJ').AsString := Str_OnlyNumbers(CNPJ);
      sqlFilial_C.Open;
      if sqlFilial_C.IsEmpty then
      begin
         sqlFilial_I.Close;
         sqlFilial_I.Sql.Clear;
         sqlFilial_I.Sql.Add('Select MAX(convert(int,CodFilial)) as CodFilial from Filial ') ;
         sqlFilial_I.Open;
         vCodFilial := sqlFilial_I.FieldByName('CodFilial').AsInteger + 1 ;
         sqlFilial_I.close;

         sqlFilial_I.Close;
         sqlFilial_I.SQL.Clear;
         sqlFilial_I.SQL.Add('Insert into Filial ( CodFilial, CNPJ, Razao, AliasEmpresa) values ( :CodFilial, :CNPJ, :Razao, :Alias)');
         sqlFilial_I.Params.ParamByName('CodFilial').AsString := IntToStr(vCodFilial);
         sqlFilial_I.Params.ParamByName('CNPJ').AsString      := Str_OnlyNumbers(CNPJ);

         if Pos('-',NomeEmpresa) > 0  then
         begin
           sqlFilial_I.Params.ParamByName('Razao').AsString := Trim(Str_Pal(NomeEmpresa, 1, '-'));
           sqlFilial_I.Params.ParamByName('Alias').AsString := Trim(Str_Pal(NomeEmpresa, 2, '-'));
         end
         else
         begin
           sqlFilial_I.Params.ParamByName('Razao').AsString := NomeEmpresa;
           sqlFilial_I.Params.ParamByName('Alias').AsString := NomeEmpresa;
         end;

         Try
            sqlFilial_I.ExecSQL;
         Except
           On E:Exception do
            begin
              Mensagem( 'Falha ao Inserir EMPRESA: ' + E.Message );
            end;
         End;
      end
      else
        vCodFilial := sqlFilial_C.FieldByName('CodFilial').AsInteger;

      result := IntToStr(vCodFilial);

  Finally
    FreeAndNil(sqlFilial_C);
    FreeAndNil(sqlFilial_I);
  end;

end;

function  TFrmCadTreinamento.VincularCargo(DescCargo : String) : Integer;
var
 varCargoID : Integer;
 sqlCargo_C,  sqlCargo_I : TFDQuery;
begin
  sqlCargo_C := TFDQuery.Create(Nil);
  sqlCargo_I := TFDQuery.Create(Nil);
  Try
    sqlCargo_C.Connection := DB_Conect.SQLConnection;
    sqlCargo_I.Connection := DB_Conect.SQLConnection;

  varCargoID := 0;
  sqlCargo_C.Close;
  sqlCargo_C.SQL.Clear;
  sqlCargo_C.SQL.Add('Select * From TRE_CARGO where DESCRICAO = :DESCRICAO');
  sqlCargo_C.Params.ParamByName('DESCRICAO').AsString := DescCargo;
  sqlCargo_C.Open;
  if sqlCargo_C.IsEmpty Then
  begin
     sqlCargo_C.Close;
     sqlCargo_C.Sql.Clear;
     sqlCargo_C.Sql.Add('Select MAX(TRE_CARGO_ID) as TRE_CARGO_ID from TRE_CARGO ') ;
     sqlCargo_C.Open;
     varCargoID := sqlCargo_C.FieldByName('TRE_CARGO_ID').AsInteger + 1 ;
     sqlCargo_C.close;

     sqlCargo_I.Close;
     sqlCargo_I.Sql.Clear;
     sqlCargo_I.SQL.Add('Insert into TRE_CARGO (TRE_CARGO_ID, DESCRICAO) values (:TRE_CARGO_ID, :DESCRICAO) ');
     sqlCargo_I.Params.ParamByName('TRE_CARGO_ID').AsInteger :=  varCargoID;
     sqlCargo_I.Params.ParamByName('DESCRICAO').AsString     :=  DescCargo;
     Try
        sqlCargo_I.ExecSQL;
     Except
       On E:Exception do
        begin
          Mensagem( 'Falha ao Inserir CARGO: ' + E.Message );
        end;
     End;
  end
  else varCargoID := sqlCargo_C.FieldByName('TRE_CARGO_ID').AsInteger;

  Finally
     FreeAndNil(sqlCargo_C);
     FreeAndNil(sqlCargo_I);
  End;

  result := varCargoID;


end;


function TFrmCadTreinamento.VincularCentroCusto(CentroCustoID,
  DescCentroCusto: String): String;
var
 varCentroCustoID: String;
 sqlCentroCusto_C, sqlCentroCusto_I : TFDQuery;
begin
  sqlCentroCusto_C := TFDQuery.Create(Nil);
  sqlCentroCusto_I := TFDQuery.Create(Nil);
  Try
      sqlCentroCusto_C.Connection := DB_Conect.SQLConnection;
      sqlCentroCusto_I.Connection := DB_Conect.SQLConnection;

      varCentroCustoID := CentroCustoID;
      sqlCentroCusto_C.Close;
      sqlCentroCusto_C.SQL.Clear;
      sqlCentroCusto_C.SQL.Add('Select * From TRE_CENTROCUSTO where TRE_CENTROCENTRO = :TRE_CENTROCENTRO');
      sqlCentroCusto_C.Params.ParamByName('TRE_CENTROCENTRO').AsString := CentroCustoID;
      sqlCentroCusto_C.Open;
      if sqlCentroCusto_C.IsEmpty Then
      begin
         sqlCentroCusto_I.Close;
         sqlCentroCusto_I.Sql.Clear;
         sqlCentroCusto_I.SQL.Add('Insert into TRE_CENTROCUSTO (TRE_CENTROCENTRO_ID, TRE_CENTROCENTRO, DESCRICAO, ATIVO) values (:TRE_CENTROCENTRO_ID, :TRE_CENTROCENTRO, :DESCRICAO, :ATIVO) ');
         sqlCentroCusto_I.Params.ParamByName('TRE_CENTROCENTRO_ID').AsString :=  LastCodigo ('TRE_CENTROCENTRO_ID','TRE_CENTROCUSTO','');
         sqlCentroCusto_I.Params.ParamByName('TRE_CENTROCENTRO').AsString    :=  CentroCustoID;
         sqlCentroCusto_I.Params.ParamByName('DESCRICAO').AsString           :=  DescCentroCusto;
         sqlCentroCusto_I.Params.ParamByName('ATIVO').AsString               :=  'S';

         Try
            sqlCentroCusto_I.ExecSQL;
         Except
           On E:Exception do
            begin
              Mensagem( 'Falha ao Inserir Centro de Custo: ' + E.Message );
            end;
         End;
      end;

  Finally
     FreeAndNil(sqlCentroCusto_C);
     FreeAndNil(sqlCentroCusto_I);

  End;

  result := varCentroCustoID;

end;


function TFrmCadTreinamento.GerarMatricula : String;
const
 str='1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
 x:integer;
 resultado : string;
begin
 for x:=1 to 6 do
   resultado:= resultado + str[Random(Length(str)) + 1];

   result := resultado
end;


function TFrmCadTreinamento.ChecarCaminhoRede : Boolean;
begin
  Result := False;
  qryAux.Close;
  qryAux.Sql.Clear;
  qryAux.SQL.Add('select PathArqTreinamento From Parametros where ServidorSMTP = 0  ' );
  qryAux.Open;

  if qryAux.FieldByName('PathArqTreinamento').AsString <> '' then
    varPathRede := qryAux.FieldByName('PathArqTreinamento').AsString
  else
  begin
   Mens_MensInf('Diretorio base para armazenar documentos do Treinamento n�o configurado.');
   Exit;
  end;

  Result := True;
end;

procedure TFrmCadTreinamento.btnSalvaArqClick(Sender: TObject);
var
 varPathFull : String;
begin
  inherited;
  if ((EditBuscaTreinamento.Text = '') and (EditBuscaTreinamento.bs_KeyValues.Count = 0)) then
  begin
       Mens_MensInf('Informe o Treinamento.');
       exit;
  end;

  if cxbEditPath.Text = EmptyStr then
  begin
    Mens_MensInf('Informe o arquivo primeiro.');
    cxbEditPath.SetFocus;
    exit;
  end;

  if ChecarCaminhoRede Then
  begin
     varPathFull := varPathRede  + '\' + EditBuscaTreinamento.Text;
     if not DB_Conect.DirExists(  varPathFull ) then
     begin
         if not ForceDirectories(  varPathFull ) then
          Exit;
     end;

     DeleteFile(PWideChar(varPathFull+'\'+ ExtractFileName(cxbEditPath.Text) ));
     if CopyFile( PWideChar(cxbEditPath.Text), PWideChar(varPathFull+'\' + ExtractFileName(cxbEditPath.Text) ), True ) Then
     begin

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('Delete from TRE_TREINAMENTO_ARQ Where ');
      qryAux.SQL.Add(' TRE_TREINAMENTO_ID = :TRE_TREINAMENTO_ID and NOMEARQUIVO = :NOMEARQUIVO and CAMINHO = :CAMINHO ');
      qryAux.Params.ParamByName('TRE_TREINAMENTO_ID').AsString  := VarToStr(EditBuscaTreinamento.bs_KeyValue);
      qryAux.Params.ParamByName('CAMINHO').AsString     := varPathFull;
      qryAux.Params.ParamByName('NOMEARQUIVO').AsString := ExtractFileName(cxbEditPath.Text);

      Try
         qryAux.ExecSQL;
      Except
        On E:Exception do
         begin
           Mens_MensInf( 'Falha ao Apagar Arquivo: ' + E.Message );
         end;
      End;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('Insert into TRE_TREINAMENTO_ARQ (TRE_TREINAMENTO_ID, CAMINHO, NOMEARQUIVO) Values (:TRE_TREINAMENTO_ID, :CAMINHO, :NOMEARQUIVO)');
      qryAux.Params.ParamByName('TRE_TREINAMENTO_ID').AsString  := VarToStr(EditBuscaTreinamento.bs_KeyValue);
      qryAux.Params.ParamByName('CAMINHO').AsString     := varPathFull;
      qryAux.Params.ParamByName('NOMEARQUIVO').AsString := ExtractFileName(cxbEditPath.Text);

      Try
         qryAux.ExecSQL;
      Except
        On E:Exception do
         begin
           Mens_MensInf( 'Falha ao Inserir Arquivo: ' + E.Message );
         end;
      End;

       Mens_MensInf('Arquivo copiado com sucesso.');
       AtualizaGridArquivos;
     end
     else
       Mens_MensErro('Erro ao copiar o arquivo.');

  end;
  cxbEditPath.Clear;

end;

procedure TFrmCadTreinamento.SalvarLogImport(Campo, Motivo : String);
var
 sqlSalvaLog : TFDQuery;
begin
  sqlSalvaLog := TFDQuery.Create(Nil);
  Try
    sqlSalvaLog.Connection := DB_Conect.SQLConnection;
    sqlSalvaLog.Close;
    sqlSalvaLog.SQL.Clear;
    sqlSalvaLog.SQL.Add('Insert into TRE_ERRO_IMPORTACAO (TRE_TREINAMENTO_ID, CAMPO, MOTIVO)');
    sqlSalvaLog.SQL.Add('Values (:TRE_TREINAMENTO_ID, :CAMPO, :MOTIVO)');
    sqlSalvaLog.Params.ParamByName('TRE_TREINAMENTO_ID').AsInteger := EditBuscaTreinamento.bs_KeyValue;
    sqlSalvaLog.Params.ParamByName('CAMPO').AsString               := Campo;
    sqlSalvaLog.Params.ParamByName('MOTIVO').AsString              := Motivo;

    Try
      sqlSalvaLog.ExecSQL;
      bLog := True;
    Except
        On E:Exception do
         begin
           Mens_MensInf( 'Falha ao Inserir Log de Erro de Importa��o: ' + E.Message );
         end;
    End;

  Finally
    FreeAndNil(sqlSalvaLog);
  End;
end;

procedure TFrmCadTreinamento.AtualizaGridArquivos;
begin
   sqlArquivo.Close;
   sqlArquivo.Params.ParamByName('TRE_TREINAMENTO_ID').AsInteger := EditBuscaTreinamento.bs_KeyValue;
   sqlArquivo.Open;
end;

procedure TFrmCadTreinamento.btnUploadClick(Sender: TObject);
var
  I, X: Integer;
  dxSpreadSheet: TdxSpreadSheet;
  varCNPJ_EMPRESA, varNOME_EMPRESA, varMATRICULA, varNOME_PARTICIPANTE, varCARGO, varCODIGO_CENTROCUSTO,
  varDESCRICAO_CENTROCUSTO, varSEXO, varFilial, varCentroCusto :  String;

  varDataNascimento , varDataAdmissao, varDataDemissao : TDateTime;
  varDate, varCargoID : Integer;
  varUltimaLinha : Integer;
  bAchou : Boolean;
  varCodigoFuncionario : String;
  varPath : String;
  R, V : Integer;
begin

  if OpenDialog.Execute then
    varPath := OpenDialog.FileName;

  if varPath = EmptyStr then
    raise Exception.Create('Informe o arquivo primeiro.');

  Mensagem( 'Iniciando processo de importa��o...' );
  try

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    try

      Mensagem( 'Carregando planilha...' );
      dxSpreadSheet.LoadFromFile( varPath );
      dxSpreadSheet.BeginUpdate;

      try

        Mensagem( 'Lendo linhas da planilha...' );
        Application.ProcessMessages;
        Sleep(1000);
        Application.ProcessMessages;
        varUltimaLinha :=  dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex;
        Mensagem( 'Total de linhas: ' + IntToStr(varUltimaLinha) );
        Application.ProcessMessages;
        Sleep(5000);
        Application.ProcessMessages;
        bLog := false;
        for X := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to varUltimaLinha do
        begin

          try

            if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0]) then
             Continue;

            if dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString = EmptyStr then
               Continue;

            if dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[1].AsString = EmptyStr then
               Continue;

            Mensagem( 'Linha (" ' + IntToStr(X) + '/' + IntToStr(varUltimaLinha) + '...' );

            if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0]) then
            begin
             varCNPJ_EMPRESA := '';
             SalvarLogImport('CNPJ', 'CNPJ N�o Informado');
            end
            else varCNPJ_EMPRESA    :=  dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString;

             If (Test_CheckCGC(varCNPJ_EMPRESA) = FALSE) Then
             begin
                SalvarLogImport('CNPJ', varCNPJ_EMPRESA + ' CNPJ Invalido');
                Continue;
             end;

            bAchou := False;
            if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2]) then
            begin
               varMATRICULA := GerarMatricula;
               SalvarLogImport('MATRICULA', 'Valor Randomico de Matricula gerado para participante');
            end
            else varMATRICULA   :=  dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsString;

            if varMATRICULA = '' then
              SalvarLogImport('MATRICULA', 'Numero da Matricula n�o informado.');


            if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[1]) then
            begin
              varNOME_EMPRESA := '';
              SalvarLogImport('Nome Empresa', 'Nome da Empresa n�o informado');
            end
            else varNOME_EMPRESA    :=  dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[1].AsString;

            qryAux.Close;
            qryAux.SQL.Clear;
            qryAux.SQL.Add('Select FUN_MATRICULA From TRE_FUNCIONARIO where FUN_MATRICULA = :FUN_MATRICULA');
            qryAux.Params.ParamByName('FUN_MATRICULA').AsString := varMATRICULA;
            qryAux.Open;

            if not qryAux.IsEmpty then
               bAchou := True;

            varFilial := VincularFilial(varCNPJ_EMPRESA, varNOME_EMPRESA);

            if dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[3].AsString = EmptyStr then
            begin
               SalvarLogImport('Nome Participante', 'Nome da Participante n�o informado');
               Continue;
            end;

            if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[3]) then
               varNOME_PARTICIPANTE := ''
            else varNOME_PARTICIPANTE  :=  dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[3].AsString;


            if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[4]) then
            begin
              varSEXO := '';
              SalvarLogImport('Sexo', 'Sexo n�o informado');
            end
            else varSEXO      :=  dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[4].AsString;

            if  ((UpperCase(Trim(varSEXO)) <> 'MASCULINO') and  (UpperCase(Trim(varSEXO)) <> 'FEMININO')) then
            begin
               SalvarLogImport('Sexo', 'Valor invalido informado para o campo sexo');
               Continue;
            end;


            if ((Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[5]) = False) or (dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[5].AsString = '')) then
            begin
              varDataNascimento := 0;
              SalvarLogImport('Data de Nascimento', 'Data de Nascimento n�o informada');
            end
            else
            begin
              if TryStrToInt( dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[5].AsString, varDate ) then
                varDataNascimento := varDate
              else
                varDataNascimento := StrToDate(String(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[5].AsString).Replace( '.', '/' ));
            end;

            if ((Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6]) = False) or (dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6].AsString = '')) then

            //if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6]) then
            begin
              varDataAdmissao := 0;
              SalvarLogImport('Data de Admiss�o', 'Data de Admiss�o n�o informada');
            end
            else
            begin
              if TryStrToInt( dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6].AsString, varDate ) then
                varDataAdmissao := varDate
              else
                varDataAdmissao := StrToDate(String(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6].AsString).Replace( '.', '/' ));

            end;

            if ((Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[7]) = False) or (dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[7].AsString = '')) then
            //if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[7]) then
            begin
              varDataDemissao := 0;
              SalvarLogImport('Data de Demiss�o', 'Data de Demiss�o n�o informada');
            end
            else
            begin
              if TryStrToInt( dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[7].AsString, varDate ) then
                varDataDemissao := varDate
              else
                if dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[7].AsString <> '' then
                   varDataDemissao := StrToDate(String(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[7].AsString).Replace( '.', '/' ))
                else
                   varDataDemissao := 0;

            end;


            if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[8]) then
            begin
              varCARGO := '';
              SalvarLogImport('Cargo', 'Cargo n�o informado');
            end
            else varCARGO      :=  dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[8].AsString;

            //Vincular Cargo ao Funcionario
             varCargoID := VincularCargo(varCARGO);


            if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[9]) then
            begin
              varCODIGO_CENTROCUSTO := '';
              SalvarLogImport('Centro de Custo', 'Centro de Custo n�o informado');
            end
            else varCODIGO_CENTROCUSTO      :=  dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[9].AsString;

            if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[10]) then
            begin
              varDESCRICAO_CENTROCUSTO := '';
              SalvarLogImport('Descri��o Centro Custo', 'Dscri��o do Centro de Custo n�o informado');
            end
            else varDESCRICAO_CENTROCUSTO      :=  dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[10].AsString;

            varCentroCusto := VincularCentroCusto( varCODIGO_CENTROCUSTO, varDESCRICAO_CENTROCUSTO);

            if ((bAchou = False) and (varMATRICULA <> '')) then
            begin

                qryAux.Close;
                qryAux.Sql.Clear;
                qryAux.Sql.Add('Select FUN_FUNCIONARIO_ID From Parametros  where ServidorSMTP = 0 ') ;
                qryAux.Open;
                varCodigoFuncionario := IntToStr(qryAux.FieldByName('FUN_FUNCIONARIO_ID').AsInteger + 1) ;
                qryAux.close;


                DB_Conect.sqlFunc.Close;
                DB_Conect.sqlFunc.sql.Clear;
                DB_Conect.sqlFunc.SQL.Add('INSERT INTO TRE_FUNCIONARIO ');
                DB_Conect.sqlFunc.SQL.Add('  (FUN_FUNCIONARIO_ID, FUN_MATRICULA ');
                DB_Conect.sqlFunc.SQL.Add('  ,CODFILIAL ');
                DB_Conect.sqlFunc.SQL.Add('  ,FUN_NOME ');
                DB_Conect.sqlFunc.SQL.Add('  ,FUN_SEXO ');
                DB_Conect.sqlFunc.SQL.Add('  ,FUN_DTNASC ');
                DB_Conect.sqlFunc.SQL.Add('  ,FUN_DTADM ');
                DB_Conect.sqlFunc.SQL.Add('  ,FUN_DTDESL ');
                DB_Conect.sqlFunc.SQL.Add('  ,TRE_CARGO_ID ');
                DB_Conect.sqlFunc.SQL.Add('  ,TRE_CENTROCENTRO ');
                DB_Conect.sqlFunc.SQL.Add('  ,FUN_ATIVO) ');
                DB_Conect.sqlFunc.SQL.Add(' VALUES (  ');
                DB_Conect.sqlFunc.SQL.Add('   :FUN_FUNCIONARIO_ID, :FUN_MATRICULA ');
                DB_Conect.sqlFunc.SQL.Add('  ,:CODFILIAL ');
                DB_Conect.sqlFunc.SQL.Add('  ,:FUN_NOME ');
                DB_Conect.sqlFunc.SQL.Add('  ,:FUN_SEXO ');
                DB_Conect.sqlFunc.SQL.Add('  ,:FUN_DTNASC ');
                DB_Conect.sqlFunc.SQL.Add('  ,:FUN_DTADM ');
                DB_Conect.sqlFunc.SQL.Add('  ,:FUN_DTDESL ');
                DB_Conect.sqlFunc.SQL.Add('  ,:TRE_CARGO_ID ');
                DB_Conect.sqlFunc.SQL.Add('  ,:TRE_CENTROCENTRO ');
                DB_Conect.sqlFunc.SQL.Add('  ,:FUN_ATIVO) ');

                DB_Conect.sqlFunc.Params.ParamByName('FUN_FUNCIONARIO_ID').AsString   := varCodigoFuncionario;
                DB_Conect.sqlFunc.Params.ParamByName('FUN_MATRICULA').AsString        := varMatricula;
                DB_Conect.sqlFunc.Params.ParamByName('CODFILIAL').AsString            := varFilial;
                DB_Conect.sqlFunc.Params.ParamByName('FUN_NOME').AsString             := varNOME_PARTICIPANTE;
                DB_Conect.sqlFunc.Params.ParamByName('FUN_SEXO').AsString             := varSexo;

                if ((varDataNascimento = 0) or (varDataNascimento = DB_Conect.ConvertDate('1899-12-30'))) then
                  DB_Conect.sqlFunc.Params.ParamByName('FUN_DTNASC').AsDateTime       := 0
                else  DB_Conect.sqlFunc.Params.ParamByName('FUN_DTNASC').AsDateTime   := varDataNascimento;

                if ((varDataAdmissao = 0) or (varDataAdmissao = DB_Conect.ConvertDate('1899-12-30'))) then
                  DB_Conect.sqlFunc.Params.ParamByName('FUN_DTADM').AsDateTime        := 0
                else  DB_Conect.sqlFunc.Params.ParamByName('FUN_DTADM').AsDateTime    := varDataAdmissao;

                if ((varDataDemissao = 0) or (varDataDemissao = DB_Conect.ConvertDate('1899-12-30'))) then
                  DB_Conect.sqlFunc.Params.ParamByName('FUN_DTDESL').AsDateTime       := 0
                else DB_Conect.sqlFunc.Params.ParamByName('FUN_DTDESL').AsDateTime    := varDataDemissao;


                DB_Conect.sqlFunc.Params.ParamByName('TRE_CARGO_ID').AsInteger        := varCargoID;
                DB_Conect.sqlFunc.Params.ParamByName('TRE_CENTROCENTRO').AsString     := varCentroCusto;
                DB_Conect.sqlFunc.Params.ParamByName('FUN_ATIVO').AsString            := 'S';

                Try
                   DB_Conect.sqlFunc.ExecSQL;

                Except
                   on E: Exception do
                   begin
                    ShowMessage(E.Message);
                   end;
                End;

                qryAux.Close;
                qryAux.SQL.Clear;
                qryAux.SQL.Add('Update Parametros  ');
                qryAux.SQL.Add(' Set FUN_FUNCIONARIO_ID = :FUN_FUNCIONARIO_ID ');
                qryAux.SQL.Add(' where ServidorSMTP = 0 ');
                qryAux.Params.ParamByName('FUN_FUNCIONARIO_ID').AsString := varCodigoFuncionario;

                 Try
                    qryAux.ExecSQL;
                 Except
                   On E:Exception do
                    begin
                      Mens_MensInf( 'Falha ao Atualizar Parametros (FUN_FUNCIONARIO_ID): ' + E.Message );
                    end;
                 End;


                DB_Conect.sqlFunc.Close;
                DB_Conect.sqlFunc.sql.Clear;
                DB_Conect.sqlFunc.SQL.Add('INSERT INTO TRE_FUNCIONARIO_HISTORICO ');
                DB_Conect.sqlFunc.SQL.Add('  (FUN_MATRICULA ');
                DB_Conect.sqlFunc.SQL.Add('  ,CODFILIAL ');
                DB_Conect.sqlFunc.SQL.Add('  ,TRE_CARGO_ID ');
                DB_Conect.sqlFunc.SQL.Add('  ,TRE_CENTROCENTRO ');
                DB_Conect.sqlFunc.SQL.Add('  ,DATA_ATUAL) ');
                DB_Conect.sqlFunc.SQL.Add('   VALUES ');
                DB_Conect.sqlFunc.SQL.Add('  (:FUN_MATRICULA ');
                DB_Conect.sqlFunc.SQL.Add('  ,:CODFILIAL ');
                DB_Conect.sqlFunc.SQL.Add('  ,:TRE_CARGO_ID ');
                DB_Conect.sqlFunc.SQL.Add('  ,:TRE_CENTROCENTRO ');
                DB_Conect.sqlFunc.SQL.Add('  ,:DATA_ATUAL) ');

                DB_Conect.sqlFunc.Params.ParamByName('FUN_MATRICULA').AsString        := varMatricula;
                DB_Conect.sqlFunc.Params.ParamByName('CODFILIAL').AsString            := varFilial;
                DB_Conect.sqlFunc.Params.ParamByName('TRE_CARGO_ID').AsInteger        := varCargoID;
                DB_Conect.sqlFunc.Params.ParamByName('TRE_CENTROCENTRO').AsString     := varCentroCusto;
                DB_Conect.sqlFunc.Params.ParamByName('DATA_ATUAL').AsDateTime         := varDataNascimento;

                Try
                   DB_Conect.sqlFunc.ExecSQL;

                Except
                   on E: Exception do
                   begin
                    ShowMessage(E.Message);
                   end;
                End;
            end;

            if (varMATRICULA <> '') then
            begin
                qryAux.Close;
                qryAux.SQL.Clear;
                qryAux.SQL.Add('Select TRE_TREINAMENTO_ID from TRE_PARTICIPANTES');
                qryAux.SQL.Add(' Where TRE_TREINAMENTO_ID = :TRE_TREINAMENTO_ID ');
                qryAux.SQL.Add(' and FUN_MATRICULA = :FUN_MATRICULA ');
                qryAux.Params.ParamByName('TRE_TREINAMENTO_ID').AsString := EdiCodigo.AsString;
                qryAux.Params.ParamByName('FUN_MATRICULA').AsString      := varMATRICULA;
                qryAux.Open;
                if qryAux.IsEmpty then
                begin

                    DB_Conect.sqlFunc.close;
                    DB_Conect.sqlFunc.sql.Clear;
                    DB_Conect.sqlFunc.sql.Add('Insert into TRE_PARTICIPANTES (TRE_TREINAMENTO_ID, FUN_MATRICULA,   TRE_CARGO_ID, TRE_CENTROCENTRO)');
                    DB_Conect.sqlFunc.sql.Add('Values ( :TRE_TREINAMENTO_ID, :FUN_MATRICULA,   :TRE_CARGO_ID, :TRE_CENTROCENTRO)');
                    DB_Conect.sqlFunc.Params.ParamByName('TRE_TREINAMENTO_ID').AsString := EdiCodigo.AsString;
                    DB_Conect.sqlFunc.Params.ParamByName('FUN_MATRICULA').AsString      := varMatricula;
                    DB_Conect.sqlFunc.Params.ParamByName('TRE_CARGO_ID').AsInteger      := varCargoID;
                    DB_Conect.sqlFunc.Params.ParamByName('TRE_CENTROCENTRO').AsString   := varCentroCusto;

                    Try
                      DB_Conect.sqlFunc.ExecSQL;
                    Except
                       On E:Exception do
                        begin
                          Mens_MensInf( 'Erro ao Inserir Participante: ' + E.Message );
                        end;
                    End;

                end;


            end;

            Application.ProcessMessages;

          except

            on E: Exception do
            begin
              ShowMessage(E.Message);
            end;

          end;

        end;



      finally

        DB_Conect.sqlFunc.Close;

      end;

      if bLog then
      begin
        Application.MessageBox( 'Visualizar Eventos de Log na Importa��o', 'Visualizar', MB_ICONINFORMATION );
        AbrirTabelaLog;
        pnlShowLog.Visible := True;
      end
      else
      Application.MessageBox( 'Planilha carregada com sucesso!!!', 'Treinamento', MB_ICONINFORMATION );

      FiltroItens;



    finally

      FreeAndNil(dxSpreadSheet);

    end;

  finally

    Mensagem( EmptyStr );

  end;

end;

procedure TFrmCadTreinamento.AbrirTabelaLog;
begin
  sqlErroImport.Close;
  sqlErroImport.Params.ParamByName('TRE_TREINAMENTO_ID').AsInteger := EditBuscaTreinamento.bs_KeyValue;
  sqlErroImport.Open;
end;


function  TFrmCadTreinamento.BuscaNotaMinima : Double;
var
 sqlCurso : TFDQuery;
begin
  inherited;
  if ((EdiCodigoCurso.AsInteger > 0) or (EdiCodigoCurso.AsString <> '')) then
  begin
    sqlCurso := TFDQuery.Create(Nil);
    Try
     sqlCurso.Connection := DB_Conect.SQLConnection;
     sqlCurso.Close;
     sqlCurso.SQL.Clear;
     sqlCurso.SQL.Add('Select ISNULL(CUR_NOTAMINIMA,0) as CUR_NOTAMINIMA From TRE_Curso where CUR_ID = :CUR_ID');
     sqlCurso.Params.ParamByName('CUR_ID').AsInteger := EdiCodigoCurso.AsInteger;
     sqlCurso.Open;
     Result := sqlCurso.FieldByName('CUR_NOTAMINIMA').AsFloat;
    Finally
      FreeAndNil(sqlCurso);
    End;
  end;

end;

procedure TFrmCadTreinamento.ediCodigoInstrutorEnter(Sender: TObject);
begin
  inherited;
{  ediCodigoInstrutor.CT_Sql.Clear;
  if ediCodigoFornecedor.Text <> '' then
  begin
     ediCodigoInstrutor.CT_Sql.Clear;
     ediCodigoInstrutor.CT_Sql.Add('SELECT INS_ID, INS_NOMINSTRUTOR FROM TRE_INSTRUTOR ');
     ediCodigoInstrutor.CT_Sql.Add('WHERE EMP_ID = ' + ediCodigoFornecedor.AsString );
  end;
 }
end;



procedure TFrmCadTreinamento.ediScoreExit(Sender: TObject);
begin
  inherited;
  if ediScore.AsDouble > 0 then
  begin
    if ediScore.AsDouble >= BuscaNotaMinima then
    begin
      varAprovado          := 'S';
      pnlAprovado.Visible  := true;
      pnlReprovado.Visible := false;
    end
    else
    begin
      varAprovado          := 'N';
      pnlAprovado.Visible  := false;
      pnlReprovado.Visible := true;
    end;
    BringToFront;
    Update;

  end;
end;

procedure TFrmCadTreinamento.EditBuscaCursoClick(Sender: TObject);
begin
  inherited;
  if ((EditBuscaCurso.Text <> '') and (EditBuscaCurso.bs_KeyValues.Count > 0)) then
  begin
    EdiCodigoCurso.AsInteger :=  StrToInt(VarToStr(EditBuscaCurso.bs_KeyValue));
    ediCargaHoraria.Text     :=  VarToStr(EditBuscaCurso.bs_KeyValues[1]);
  end;
end;

procedure TFrmCadTreinamento.EditBuscaFornecedorClick(Sender: TObject);
begin
  inherited;
  if ((EditBuscaFornecedor.Text <> '') and (EditBuscaFornecedor.bs_KeyValues.Count > 0)) then
   ediCodigoFornecedor.AsInteger := StrToInt(VarToStr(EditBuscaFornecedor.bs_KeyValue));
end;

procedure TFrmCadTreinamento.EditBuscaInstrutorClick(Sender: TObject);
begin
  inherited;
  if ((EditBuscaInstrutor.Text <> '') and (EditBuscaInstrutor.bs_KeyValues.Count > 0)) then
    ediCodigoInstrutor.AsInteger :=  StrToInt(VarToStr(EditBuscaInstrutor.bs_KeyValue));
end;

procedure TFrmCadTreinamento.EditBuscaInstrutorEnter(Sender: TObject);
begin
  inherited;
  if ((EditBuscaFornecedor.Text <> '') and (EditBuscaFornecedor.bs_KeyValues.Count > 0)) then
    EditBuscaInstrutor.bs_Filter := 'EMP_ID = ' +  VarToStr(EditBuscaFornecedor.bs_KeyValue);
end;

procedure TFrmCadTreinamento.EditBuscaTreinamentoClick(Sender: TObject);
begin
  inherited;
  if ((EditBuscaTreinamento.Text <> '') and (EditBuscaTreinamento.bs_KeyValues.Count > 0)) Then
  begin
   EdiCodigo.AsInteger := StrToInt(VarToStr(EditBuscaTreinamento.bs_KeyValue));
   if VarOperacao <> OPE_INCLUSAO then
     ButPesquisarClick(Self);
  end;
end;

procedure TFrmCadTreinamento.FormCreate(Sender: TObject);
begin

  LabCadTit.Caption := 'Treinamento' ;
  FormOperacao      := 'CAD_TREINAMENTO';
  FormTabela        := 'TRE_TREINAMENTO' ;
  FormChaves        := 'TRE_TREINAMENTO_ID' ;
  FormCtrlFocus     := 'EditBuscaTreinamento' ;
  FormDataFocus     := 'EditBuscaCurso' ;

  sqlTipoTreinamento.Close;
  sqlTipoTreinamento.Open;
  cmbTipoTreinamento.ItemIndex := 0;

  sqlPeriodo.Close;
  sqlPeriodo.Open;
  cmbPeriodo.ItemIndex := 0;


  Page.ActivePage     := tabTreinamento;
  PageItem.ActivePage := tsbGrid;

 { EdiCodigo.CT_Sql.Clear;
  EdiCodigo.CT_Sql.Add(' Select T.TRE_TREINAMENTO_ID, T.CUR_ID, T.CUR_NOMCURSO, T.TRE_DTREALIZACAO ');
  EdiCodigo.CT_Sql.Add(' from TRE_TREINAMENTO T  ');
  EdiCodigo.CT_Sql.Add(' inner join TRE_CURSO C on C.CUR_ID = T.CUR_ID  ');
  }
  SetParametros(EditBuscaTreinamento, TipoTreinamentoID);
  SetParametros(EditBuscaFornecedor, TipoFornecedor);
  SetParametros(EditBuscaCurso, TipoCurso);
  SetParametros(EditBuscaInstrutor, TipoInstrutor);

  SetParametros(EditBuscaParticipante, TipoParticipanteFILIAL);


  inherited;

end;


procedure TFrmCadTreinamento.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;

end;

procedure TFrmCadTreinamento.Search;
begin
  inherited;
  //if not FormOpeErro then
  //begin


   EditBuscaCurso.SetValue('CUR_ID=' + QuotedStr(EdiCodigoCurso.AsString));
   EditBuscaFornecedor.SetValue('EMP_ID=' + QuotedStr(ediCodigoFornecedor.AsString));
   EditBuscaInstrutor.SetValue('INS_ID=' + QuotedStr(ediCodigoInstrutor.AsString));


    MemSumario.Text  := editxtSumario.AsString;
    MemObjetivo.Text := editxtObjetivo.AsString;

    if ((ediTipoTreinamento.AsString = '') or (ediTipoTreinamento.AsString = 'null'))  then
      cmbTipoTreinamento.EditValue := -1
    else
      cmbTipoTreinamento.EditValue := ediTipoTreinamento.AsString;

     if ((editxtPeriodicidade.AsString = '') or (editxtPeriodicidade.AsString = 'null'))  then
      cmbPeriodo.EditValue := -1
    else
      cmbPeriodo.EditValue := editxtPeriodicidade.AsString;


    if editxtObrigacao.Text = 'S' then
       rgObrigacao.ItemIndex := 0
    else rgObrigacao.ItemIndex := 1;

    EdiDatIni.Date := editxtDtRealizacao.AsDateTime;
    EdiDatFim.Date := editxtDtTermino.AsDateTime;

    FiltroItens;

     AtualizaGridArquivos;

  //end;
end;

procedure TFrmCadTreinamento.spbLimpaScoreClick(Sender: TObject);
begin
  inherited;
  varAprovado := '';
  pnlAprovado.Visible := false;
  pnlReprovado.Visible := false;
  ediScore.Clear;
  ediScore.SetFocus;
end;

procedure TFrmCadTreinamento.spbLimpaTreinamentoClick(Sender: TObject);
begin
  inherited;
  EditBuscaTreinamento.Text;
  EditBuscaTreinamento.bs_KeyValues.Clear;
end;

procedure TFrmCadTreinamento.EdiCodigoEmpresaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
    ButPesquisarClick(Self);
end;

end.
