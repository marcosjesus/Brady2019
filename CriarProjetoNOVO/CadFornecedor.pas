unit CadFornecedor ;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  fcadastro, ComCtrls, StdCtrls, Buttons, ToolWin, ExtCtrls, rsEdit, Mask,
  rsFlyovr, RseditDB, ShellApi, DBCtrls, Menus, cxLookAndFeelPainters,
  cxButtons, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxPC,
  cxControls, cxGraphics, dxSkinsdxStatusBarPainter, dxStatusBar,
  cxLookAndFeels, dxSkinBlack, dxSkinBlue, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, FMTBcd, DB, SqlExpr, cxContainer, cxEdit, cxGroupBox,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxDBData, Provider,
  DBClient, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, DBConect, cxLabel, Variants,
  RxLookup, EditBusca, SetParametro, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  dxBarBuiltInMenu, dxCore, cxDateUtils, cxNavigator, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, vcl.FileCtrl;

type
  TFrmCadFornecedor = class(TFrmCadastro)
    Panel1: TPanel;
    EdiCodigo: TrsSuperEdit;
    CBXTipo1Int: TComboBox;
    CBXTipo2Int: TComboBox;
    PgCPrincipal: TcxPageControl;
    TbSFicha: TcxTabSheet;
    Panel2: TPanel;
    EdiNome: TrsSuperEdit;
    Panel6: TPanel;
    EdiTelefone1: TrsSuperEdit;
    Panel10: TPanel;
    EdtCGC: TrsSuperEdit;
    Panel11: TPanel;
    EdiApelido: TrsSuperEdit;
    MEdiCGC: TMaskEdit;
    rsSuperEdit4: TrsSuperEdit;
    Panel4: TPanel;
    EdiEnd: TrsSuperEdit;
    EdiComplemento: TrsSuperEdit;
    EdiNum: TrsSuperEdit;
    EdiCEP: TrsSuperEdit;
    mskCEP: TMaskEdit;
    Panel3: TPanel;
    EdiCidade: TrsSuperEdit;
    EdiUF: TrsSuperEdit;
    CbxUF: TComboBox;
    EdiBairro: TrsSuperEdit;
    Panel5: TPanel;
    rsSuperEdit2: TrsSuperEdit;
    EdiEmailCob: TrsSuperEdit;
    tbsContatos: TcxTabSheet;
    Panel20: TPanel;
    Panel21: TPanel;
    ButNovoItem: TcxButton;
    ButAlterarItem: TcxButton;
    ButExcluirItem: TcxButton;
    ButSalvarItem: TcxButton;
    ButCAncelarItem: TcxButton;
    PageControl: TcxPageControl;
    TbSGrade: TcxTabSheet;
    TbSEdicao: TcxTabSheet;
    dspContatos: TDataSetProvider;
    cdsContatos: TClientDataSet;
    DtSContatos: TDataSource;
    lblTipoPessoa: TLabel;
    lblInscricaoRG: TLabel;
    Panel24: TPanel;
    EdiNomeCont: TrsSuperEdit;
    EdiMailCont: TrsSuperEdit;
    Panel22: TPanel;
    EdiFone1: TrsSuperEdit;
    Tipo1Cont: TComboBox;
    Panel17: TPanel;
    EdiFone2: TrsSuperEdit;
    Tipo2Cont: TComboBox;
    Panel25: TPanel;
    EditCargo: TEditBusca;
    EditProfissao: TEditBusca;
    cxGrid2: TcxGrid;
    DBGContatos: TcxGridDBTableView;
    cxGrid1DBTableView1ChaveSeq: TcxGridDBColumn;
    cxGrid1DBTableView1CodCliente: TcxGridDBColumn;
    cxGrid1DBTableView1Nome_3: TcxGridDBColumn;
    cxGrid1DBTableView1E_Mail: TcxGridDBColumn;
    cxGrid1DBTableView1DescTipo1: TcxGridDBColumn;
    cxGrid1DBTableView1Numero1_3: TcxGridDBColumn;
    cxGrid1DBTableView1DescTipo2: TcxGridDBColumn;
    cxGrid1DBTableView1Numero2_3: TcxGridDBColumn;
    cxGrid1DBTableView1DescFuncao: TcxGridDBColumn;
    cxGrid1DBTableView1codprofissao: TcxGridDBColumn;
    cxGrid1DBTableView1DescProfissao: TcxGridDBColumn;
    cxGrid1DBTableView1CodFuncao: TcxGridDBColumn;
    cxGrid1DBTableView1Tipo1_3: TcxGridDBColumn;
    cxGrid1DBTableView1Tipo2_3: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    QryAux: TFDQuery;
    FDConnection: TFDConnection;
    QryContatos: TFDQuery;
    Panel14: TPanel;
    editPathNfe: TrsSuperEdit;
    EdiFormato: TrsSuperEdit;
    cxButton2: TcxButton;
    Panel12: TPanel;
    edipathinvalido: TrsSuperEdit;
    cxButton3: TcxButton;
    GroupBox1: TGroupBox;
    Panel7: TPanel;
    EdiHost: TrsSuperEdit;
    rsSuperEdit9: TrsSuperEdit;
    rsSuperEdit16: TrsSuperEdit;
    Panel8: TPanel;
    rsSuperEdit15: TrsSuperEdit;
    EdiSenha: TrsSuperEdit;
    Panel16: TPanel;
    rsSuperEdit3: TrsSuperEdit;
    editpastadefault: TrsSuperEdit;
    Panel13: TPanel;
    edipathimportado: TrsSuperEdit;
    cxButton4: TcxButton;
    Panel9: TPanel;
    editpathexcel: TrsSuperEdit;
    cxButton1: TcxButton;
    Panel15: TPanel;
    editpathtemp: TrsSuperEdit;
    cxButton5: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure EdiCodigoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButNovoClick(Sender: TObject);
    procedure EdiTipo1Change(Sender: TObject);
    procedure EdiTipo2Change(Sender: TObject);
    procedure EdiEMailDblClick(Sender: TObject);
    procedure EdiUFChange(Sender: TObject);
    procedure CbxUFClick(Sender: TObject);
    procedure EdiCEPChange(Sender: TObject);
    procedure mskCEPExit(Sender: TObject);
    procedure ButExcluirClick(Sender: TObject);
    procedure CbxContICMSKeyPress(Sender: TObject; var Key: Char);
    procedure CbxRegimeICMSKeyPress(Sender: TObject; var Key: Char);
    procedure ButSalvarClick(Sender: TObject);
    procedure ButNovoItemClick(Sender: TObject);
    procedure ButAlterarItemClick(Sender: TObject);
    procedure ButExcluirItemClick(Sender: TObject);
    procedure ButSalvarItemClick(Sender: TObject);
    procedure ButCAncelarItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButPesquisarClick(Sender: TObject);
    procedure PgCPrincipalChange(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
    procedure ButCancelarClick(Sender: TObject);


  private
    { Private declarations }
    Var_OperacaoItem , ChaveSeq : Integer ;
    Function ExisteRelacionamento : Boolean;
    procedure AtualizaGridProduto;
    procedure ButItensOnOff(S: String);
    procedure NovoItemCont;
    procedure SearchCont;
    procedure ExcluirCont;
    procedure FiltroItens;
    procedure IncluiCont;
    procedure AlteraCont;
    procedure AlteraNatureza;
    function SelectADirectory(Title: string; subPasta : String): string;
    procedure SalvaPaths(Codigo : Integer);
  public
    { Public declarations }
    IncForn : Boolean;
    Function Check : Boolean ; Override ;
    Procedure Search ; Override ;


  end;

var
  FrmCadFornecedor: TFrmCadFornecedor;

implementation

{$R *.DFM}

Uses
   Global, ObjFun, MensFun, TestFun, StrFun, ConsTabFun, Constantes;

procedure TFrmCadFornecedor.FormCreate(Sender: TObject);
begin

    if not FDConnection.Connected then
    begin

      FDConnection.Params.LoadFromFile( ExtractFilePath(Application.ExeName) + '\' +  'ConexaoABC.ini' );
      FDConnection.Open;

    end;

		LabCadTit.Caption := 'Cadastro de Emitentes' ;
		FormOperacao := ''; // 'CAD_FORNECEDOR' ;
		FormTabela := 'fornecedores' ;
		FormChaves := 'codfornecedor' ;
		FormCtrlFocus := 'EdiCodigo' ;
		FormDataFocus := 'EdiApelido' ;
    FormOBS       := 'Observacao';
		inherited;
    PgCPrincipal.ActivePage := TbSFicha;

end;

procedure TFrmCadFornecedor.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
  SetParametros(EditCargo, TipoFuncao);
  SetParametros(EditProfissao, TipoProfissao);
end;

Function TFrmCadFornecedor.Check : Boolean ;
Begin
	 Result := False ;
   // Alias obrigatorio
   If ( Test_IsEmptyStr(EdiApelido.Text) ) Then
	 Begin
    Mens_MensInf('� necess�rio informar o Alias !') ;
    pgCPrincipal.ActivePage := TbSFicha;
		EdiApelido.SetFocus ;
		Exit ;
	 End ;
   // Nome obrigatorio
	 If ( Test_IsEmptyStr(EdiNome.Text) ) Then
	 Begin
	  Mens_MensInf('� necess�rio informar o Nome !') ;
    pgCPrincipal.ActivePage := TbSFicha;
		EdiNome.SetFocus ;
		Exit ;
	 End ;

    // verifica CGC = CNPJ
   if Trim(Copy(MEdiCGC.Text, 1, 1)) <> '' then
   begin
     EdtCGC.AsString := MEdiCGC.Text;

     If (Test_CheckCGC(MEdiCGC.Text) = FALSE) Then // cgc nao bate
     Begin
        Mens_MensInf('N�mero do CNPJ n�o confere.') ;
        PgCPrincipal.ActivePage:=TbsFicha;
        MEdiCGC.SetFocus ;
        Exit ;
     End ;

     // procura por duplicidade de CNPJ
    With QryAux Do
    Begin
       Close;
       Sql.Clear;
       sql.add('select nome from fornecedores');
       sql.add('where codfornecedor<>:p_cli and cnpj=:p_cnpj');
       parambyname('p_cli').asinteger   := edicodigo.asinteger;
       parambyname('p_cnpj').asstring  := edtcgc.text;
       Open;
    End;  // final => with ...

    If (QryAux.IsEmpty = FALSE) Then  // encontro...
    Begin                                        Mens_MensInf('CNPJ: '+ MEdiCGC.Text
                   + ' j� est� cadastrado para o fornecedor '
                   + QryAux.Fields[0].AsString) ;
       PgCPrincipal.ActivePage:=TbSFicha;
       MEdiCGC.SetFocus ;
       Exit ;
    End;   // final =>
   end
   else
   begin
      Mens_MensInf('N�mero do CNPJ n�o informado!') ;
      PgCPrincipal.ActivePage:=TbsFicha;
      MEdiCGC.SetFocus ;
      Exit ;
      EdtCGC.Text := '';
   end;

   if (not (ValidaEMail(EdiEmailCob.AsString))) then
    begin
      Mens_MensInf('Formato de e-mail de cobran�a inv�lido! ') ;
      pgCPrincipal.ActivePage := TbSFicha;
      EdiEmailCob.SetFocus;
      Exit;
    end;


   EdiCEP.AsString  := MskCEP.Text;
   EdiUF.AsString   := CbxUF.Text;

  // Tipo1Enter(Self);
  // Tipo2Enter(Self);


   if not (Test_IsEmptyStr(EdiEmailCob.AsString))  then
     if (not (ValidaEMail(EdiEmailCob.AsString))) then
     begin
       Mens_MensInf('Formato do e-mail Cobran�a inv�lido! ') ;
       pgCPrincipal.ActivePage := TbSFicha;
       EdiEmailCob.SetFocus;
       Exit;
     end;

   if ( Test_IsEmptyStr(editPathNfe.Text) ) Then
   begin
      Mens_MensInf('� necess�rio informar o Path Arqs. NFe !') ;
      pgCPrincipal.ActivePage := TbSFicha;
	  	editPathNfe.SetFocus ;
	  	Exit ;
   end;


   if ( Test_IsEmptyStr(edipathimportado.Text) ) Then
   begin
      Mens_MensInf('� necess�rio informar o Path Arqs. Importados !') ;
      pgCPrincipal.ActivePage := TbSFicha;
	  	edipathimportado.SetFocus ;
	  	Exit ;
   end;

   if ( Test_IsEmptyStr(edipathinvalido.Text) ) Then
   begin
      Mens_MensInf('� necess�rio informar o Path Arqs. Inv�lidos !') ;
      pgCPrincipal.ActivePage := TbSFicha;
	  	edipathinvalido.SetFocus ;
	  	Exit ;
   end;

   if ( Test_IsEmptyStr(editpathexcel.Text) ) Then
   begin
      Mens_MensInf('� necess�rio informar o Path Arqs. Excel !') ;
      pgCPrincipal.ActivePage := TbSFicha;
	  	editpathexcel.SetFocus ;
	  	Exit ;
   end;

   if ( Test_IsEmptyStr(editpathtemp.Text) ) Then
   begin
      Mens_MensInf('� necess�rio informar o Path Arqs. Tempor�rios !') ;
      pgCPrincipal.ActivePage := TbSFicha;
	  	editpathtemp.SetFocus ;
	  	Exit ;
   end;





   Result := True ;
End ;



function TFrmCadFornecedor.SelectADirectory(Title : string; subPasta : String) : string;
var
  Pasta : String;
  PastaPrincipal : String;
begin
  SelectDirectory(Title, '', Pasta);

  if (Trim(Pasta) <> '') then
    if (Pasta[Length(Pasta)] <> '\') then
      Pasta := Pasta;

  PastaPrincipal :=  Pasta + '\' + EdiCodigo.Text;
  ForceDirectories(PastaPrincipal);

  if not ForceDirectories ( IncludeTrailingPathDelimiter( PastaPrincipal ) + subPasta + '_' + EdiCodigo.Text + '\' ) then
  begin
      Mens_MensInf('N�o foi poss�vel criar o Diretorio do Emitente !') ;
      Result := '';
  end
  else
     Result := IncludeTrailingPathDelimiter( PastaPrincipal )  +  subPasta + '_' + EdiCodigo.Text + '\';
end;

procedure TFrmCadFornecedor.cxButton1Click(Sender: TObject);
begin
  inherited;
  editpathexcel.Text := SelectADirectory('Selecione o Path dos Arq. EXCEL (xlsx)', 'EXCEL');
end;

procedure TFrmCadFornecedor.cxButton2Click(Sender: TObject);
begin
  inherited;
  editPathNfe.Text := SelectADirectory('Selecione o Path dos Arq. NFE (xml)', 'NFE');
end;

procedure TFrmCadFornecedor.cxButton3Click(Sender: TObject);
begin
  inherited;
   edipathinvalido.Text :=  SelectADirectory('Selecione o Path dos Arq. Inv�lidos.', 'INVALIDOS');
end;

procedure TFrmCadFornecedor.cxButton4Click(Sender: TObject);
begin
  inherited;
  edipathimportado.Text :=  SelectADirectory('Selecione o Path dos Arq. Importados.', 'IMPORTADOS');
end;

procedure TFrmCadFornecedor.cxButton5Click(Sender: TObject);
begin
  inherited;
   editpathtemp.Text := SelectADirectory('Selecione o Path dos Arq. TEMPOR�RIOS (xml)', 'TEMP');
end;

procedure TFrmCadFornecedor.EdiCodigoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ButPesquisarClick(Self) ;
end;

procedure TFrmCadFornecedor.ButAlterarItemClick(Sender: TObject);
begin
  inherited;
  //CodFuncao.Text := cdsContatosDescFuncao.Value;
  ButItensOnOff('FFFTTFFF');
  Var_OperacaoItem := OPE_ALTERACAO;
  SearchCont;

end;

procedure TFrmCadFornecedor.ButCancelarClick(Sender: TObject);
begin
  inherited;
  MskCEP.Text   := '';
  EdiCEP.Text   := '';
  MEdiCGC.Text  := '';

  editPathNfe.clear;
  edipathinvalido.clear;
  edipathimportado.clear;
  editpastadefault.clear;
  editpathexcel.clear;
  editpathtemp.clear;
end;

procedure TFrmCadFornecedor.ButCAncelarItemClick(Sender: TObject);
begin
  inherited;
  ButItensOnOff('TTTFFTTT');
  PageControl.ActivePage  :=  TbSGrade;
  Var_OperacaoItem := 0;
end;



procedure TFrmCadFornecedor.SearchCont;
begin
  PageControl.ActivePage:=TbSEdicao;
  with DBGContatos.DataController.DataSource.DataSet do
  begin
    EdiNomeCont.Text    :=  FieldByName('Nome').AsString;
    EdiFone1.Text       :=  FieldByName('Numero1').AsString;
    EdiFone2.Text       :=  FieldByName('Numero2').AsString;

    if (FieldByName('Tipo1').AsInteger <> -1) then
       Tipo1Cont.ItemIndex :=  FieldByName('Tipo1').AsInteger;

    if (FieldByName('Tipo2').AsInteger <> -1)  then
       Tipo2Cont.ItemIndex :=  FieldByName('Tipo2').AsInteger;

    EditCargo.SetValue('CodFuncao = ' + QuotedStr(FieldByName('CodFuncao').AsString));
    EditProfissao.SetValue('CodProfissao = ' + QuotedStr(FieldByName('codprofissao').AsString));

    ChaveSeq            :=  FieldByName('CHAVESEQ').AsInteger;
    EdiMailCont.Text    :=  FieldByName('E_Mail').AsString;
  end;
  EdiNomeCont.SetFocus;
end;


procedure TFrmCadFornecedor.ButExcluirClick(Sender: TObject);
begin
  if ExisteRelacionamento then
  begin
    Mens_MensInf('Exclus�o N�o Permitida, Existe lan�amentos relacionado ao mesmo !');
    Exit;
  end;


  inherited;

end;

procedure TFrmCadFornecedor.ButExcluirItemClick(Sender: TObject);
begin
  inherited;
  Try
    ExcluirCont;
    FiltroItens;
  except
    Mens_MensInf('Erro ao Excluir Registro !');
  end;
end;



procedure TFrmCadFornecedor.FiltroItens;
Var
 varSQL : String;
begin
  with QryContatos do
      begin
        cdsContatos.Close;
        SQL.Clear;
        sql.add('select  chaveseq, a.codfornecedor, nome, numero1, ');
        sql.add('numero2, e_mail, descfuncao, a.codprofissao, descprofissao, a.codfuncao,  ');
        sql.add('coalesce(tipo1, -1) as tipo1, coalesce(tipo2, -1) as tipo2,   ');
        sql.add('(select desctpfone from tipofone where codtipofone = tipo1) as desctipo1, ');
        sql.add('(select desctpfone from tipofone where codtipofone = tipo2) as desctipo2 ');
        sql.add('from contatos_fornecedores a left join funcao b on a.codfuncao = b.codfuncao ');
        sql.add('left join profissao p on a.codprofissao = p.codprofissao ');
        sql.add('where codfornecedor = :codfornecedor order by nome');
        Params.ParamByName('codfornecedor').AsInteger := EdiCodigo.AsInteger;
        cdsContatos.Open;
      end;
        ButAlterarItem.Enabled := (cdsContatos.IsEmpty = FALSE);
        ButExcluirItem.Enabled := (cdsContatos.IsEmpty = FALSE);
end;






procedure TFrmCadFornecedor.ExcluirCont;
begin
  If ( Mens_MensConf('Confirma Exclus�o ?') = mrOk ) Then
  Begin        // confirmou exclusao !!!
    with QryAux do
    begin
      Close;
      Sql.Clear;
      Sql.Add('DELETE FROM CONTATOS_FORNECEDORES');
      Sql.Add('WHERE CODFORNECEDOR=:P_CLIE AND CHAVESEQ=:P_CHAVE');
      ParamByName('P_CLIE').AsString   := EdiCodigo.Text;
      ParamByName('P_CHAVE').AsInteger := DBGContatos.DataController.DataSource.DataSet.FieldByName('CHAVESEQ').AsInteger;
      ExecSql;  // apaga dados
    end; // final => with Qry...
  End;  // final =>  If ( Mens_MensCon...
  PageControl.ActivePage:=TbSGrade;
end;


procedure TFrmCadFornecedor.ButNovoClick(Sender: TObject);
begin
  inherited;
  IncForn := False;
  EdiCodigo.AsString := LastCodigo('codfornecedor', 'fornecedores', '');
  MskCEP.Text   := '';
  EdiCEP.Text   := '';
  MEdiCGC.Text  := '';

  editPathNfe.clear;
  edipathinvalido.clear;
  edipathimportado.clear;
  editpastadefault.clear;
  editpathexcel.clear;
  editpathtemp.clear;

  EdiNome.SetFocus;
end;

procedure TFrmCadFornecedor.ButNovoItemClick(Sender: TObject);
begin
  inherited;

  //CodFuncao.ItemIndex := -1;
  ButItensOnOff('FFFTTFFF');
  Var_OperacaoItem := OPE_INCLUSAO;
  NovoItemCont;
end;



procedure TFrmCadFornecedor.ButPesquisarClick(Sender: TObject);
begin
  PgCPrincipal.ActivePage := TbSFicha;

  inherited;
end;


procedure TFrmCadFornecedor.NovoItemCont;
begin
  PageControl.ActivePage := TbSEdicao;
  EdiNomeCont.Text    :=  '';
  EdiFone1.Text       :=  '';
  EdiFone2.Text       :=  '';
  EditCargo.Text      :=  '';
  EditProfissao.Text  :=  '';
  EdiMailCont.Text    :=  '';
  Tipo1Cont.ItemIndex :=  -1;
  Tipo2Cont.ItemIndex :=  -1;
  EdiNomeCont.SetFocus;
end;



procedure TFrmCadFornecedor.PgCPrincipalChange(Sender: TObject);
begin
  inherited;
  if PgCPrincipal.ActivePage = TbSContatos then
    FiltroItens;
end;

procedure TFrmCadFornecedor.ButItensOnOff(S:String);
begin
    ButNovoItem.Enabled     := Copy(S,1,1) = 'T' = True;
    ButAlterarItem.Enabled  := Copy(S,2,1) = 'T' = True;
    ButExcluirItem.Enabled  := Copy(S,3,1) = 'T' = True;
    ButSalvarItem.Enabled   := Copy(S,4,1) = 'T' = True;
    ButCancelarItem.Enabled := Copy(S,5,1) = 'T' = True;
    ButExcluir.Enabled      := Copy(S,6,1) = 'T' = True;
    ButSalvar.Enabled       := Copy(S,7,1) = 'T' = True;
    ButCancelar.Enabled     := Copy(S,8,1) = 'T' = True;

    ButExcluir.Enabled       := Copy(S,6,1) = 'T' = True;
    ButSalvar.Enabled        := Copy(S,7,1) = 'T' = True;
    ButCancelar.Enabled      := Copy(S,8,1) = 'T' = True;

end;


procedure TFrmCadFornecedor.ButSalvarClick(Sender: TObject);
Var
  FornecedorNovo : String;
  varCodigo : Integer;
begin
  FornecedorNovo := EdiCodigo.Text;
  varCodigo := EdiCodigo.AsInteger;

  inherited;
  if Salvo then
    SalvaPaths(varCodigo);
{
  if IncForn then
  begin
    GFornecNovo := FornecedorNovo;
    Close;
  end;
 }
  PgCPrincipal.ActivePage := TbSFicha;

end;

procedure TFrmCadFornecedor.SalvaPaths(Codigo : Integer);
begin
   QryAux.Close;
   QryAux.SQL.Clear;
   QryAux.SQL.Add('Update fornecedores ');
   QryAux.SQL.Add('Set ');

   if editPathNfe.AsString <> '' then
      QryAux.SQL.Add(' path_nfe = :path_nfe ');

   if edipathinvalido.AsString <> '' then
     QryAux.SQL.Add( ' ,path_invalido = :path_invalido   ');

   if edipathimportado.AsString <> '' then
     QryAux.SQL.Add( ' ,path_importado = :path_importado  ');

   if editpastadefault.AsString <> '' then
     QryAux.SQL.Add( ' ,pastadefault = :pastadefault  ');

   if editpathexcel.AsString <> '' then
     QryAux.SQL.Add( ' ,path_excel = :path_excel  ');

   if editpathtemp.AsString <> '' then
     QryAux.SQL.Add( ' ,path_temp = :path_temp  ');


   QryAux.SQL.Add(' Where codfornecedor = :codfornecedor  ');
   QryAux.Params.ParamByName('codfornecedor').AsInteger := Codigo;
   if editPathNfe.AsString <> '' then
     QryAux.Params.ParamByName('path_nfe').AsString       := editPathNfe.AsString;
   if edipathinvalido.AsString <> '' then
     QryAux.Params.ParamByName('path_invalido').AsString  := edipathinvalido.AsString;
   if edipathimportado.AsString <> '' then
     QryAux.Params.ParamByName('path_importado').AsString := edipathimportado.AsString;
   if editpastadefault.AsString <> '' then
     QryAux.Params.ParamByName('pastadefault').AsString   := editpastadefault.AsString;
   if editpathexcel.AsString <> '' then
     QryAux.Params.ParamByName('path_excel').AsString     := editpathexcel.AsString;
   if editpathtemp.AsString <> '' then
     QryAux.Params.ParamByName('path_temp').AsString      := editpathtemp.AsString;

   QryAux.ExecSQL;

end;

procedure TFrmCadFornecedor.ButSalvarItemClick(Sender: TObject);
begin
  inherited;


   if Var_OperacaoItem = OPE_INCLUSAO then
   Begin
      Try
        ButItensOnOff('TTTFFTTT');
        IncluiCont;
        FiltroItens;
      except
        Mens_MensInf('Erro ao Incluir Registro !');
      end; // final =: try...
     end // if ... OPE_INCLUSAO
     else
     begin
       ButItensOnOff('TTTFFTTT');
       AlteraCont ;
       FiltroItens;
       Var_OperacaoItem := 0;
     end; // final => begin...
end;



procedure TFrmCadFornecedor.IncluiCont;
begin
  // salva contatos
  Try
    With QryContatos Do
    Begin
      Close;
      sql.clear;
      sql.add('insert into contatos_fornecedores');
      sql.add('(codfornecedor, nome, numero1, numero2,');
      sql.add('tipo1, tipo2, codfuncao, codprofissao, e_mail)');       // , chaveseq
      sql.add('values(:p_clie, :p_nome, :p_num1, :p_num2,');
      sql.add(':p_tipo1, :p_tipo2, :p_cargo, :p_codprofissao, :p_mail)');    // , :p_chave
      parambyname('p_clie').asinteger   := edicodigo.asinteger;
      parambyname('p_nome').asstring   := edinomecont.text;
      parambyname('p_num1').asstring   := edifone1.text;
      parambyname('p_num2').asstring   := edifone2.text;

      if ((tipo1cont.itemindex >= 0) and (edifone1.text <> '')) then
         parambyname('p_tipo1').asinteger  := tipo1cont.itemindex
      else
         parambyname('p_tipo1').asinteger  := -1;

      if ((tipo2cont.itemindex >= 0) and (edifone2.text <> '')) then
         parambyname('p_tipo2').asinteger  := tipo2cont.itemindex
      else
         parambyname('p_tipo2').asinteger  := -1;

      parambyname('p_cargo').asinteger         :=  editcargo.bs_keyvalue;
      parambyname('p_codprofissao').asinteger  :=  editprofissao.bs_keyvalue;
      parambyname('p_mail').asstring           := edimailcont.text;

      ExecSql;  // descarrega informacoes no Banco de Dados
    End;
  Except
     on E:Exception do
			Mens_MensInf(E.Message);
  End;
  PageControl.ActivePage:=TbSGrade;
end;

procedure TFrmCadFornecedor.AlteraNatureza;     // alteracao de contatos
begin

end;

procedure TFrmCadFornecedor.AlteraCont;     // alteracao de contatos
begin
  With QryContatos Do
  Begin
    Close;
    Sql.Clear;
    sql.add('update contatos_fornecedores set');
    sql.add('nome=:p_nome, numero1=:p_num1, numero2=:p_num2,');
    sql.add('tipo1=:p_tipo1, tipo2=:p_tipo2, codfuncao=:p_cargo, codprofissao = :p_codprofissao, e_mail=:p_mail ');
    sql.add('where codfornecedor=:p_clie and chaveseq=:p_chave');
    parambyname('p_nome').asstring   := edinomecont.text;
    parambyname('p_num1').asstring   := edifone1.text;
    parambyname('p_num2').asstring   := edifone2.text;

    if ((tipo1cont.itemindex >= 0) and (edifone1.text <> '')) then
       parambyname('p_tipo1').asinteger  := tipo1cont.itemindex
    else
       parambyname('p_tipo1').asinteger  := -1;

    if ((tipo2cont.itemindex >= 0) and (edifone2.text <> '')) then
       parambyname('p_tipo2').asinteger  := tipo2cont.itemindex
    else
       parambyname('p_tipo2').asinteger  := -1;

    parambyname('p_cargo').asinteger         := editcargo.bs_keyvalue;
    parambyname('p_codprofissao').asinteger  := editprofissao.bs_keyvalue;
    parambyname('p_mail').asstring   := edimailcont.text;
    parambyname('p_clie').asinteger   := edicodigo.AsInteger;
    parambyname('p_chave').asinteger := chaveseq;
    ExecSql;  // descarrega informacoes no Banco de Dados
  End;
  PageControl.ActivePage:=TbSGrade;
end;

procedure TFrmCadFornecedor.EdiTipo1Change(Sender: TObject);
begin
  inherited;
 { IF (EdiTipo1.Text = '') Then
    Exit ; // vazio na faz nada
  // procura no combo de Int...
  CBxTipo1Int.ItemIndex  :=  CBxTipo1Int.Items.IndexOf(EdiTipo1.Text);
  // atualiza combo de Tipo(1)...
  CBxTipo1.ItemIndex := CBxTipo1Int.ItemIndex; }
end;

procedure TFrmCadFornecedor.EdiTipo2Change(Sender: TObject);
begin
  inherited;
{  IF (EdiTipo2.Text = '') Then
    Exit ; // vazio na faz nada
  // procura no combo de Int...
  CBxTipo2Int.ItemIndex  :=  CBxTipo2Int.Items.IndexOf(EdiTipo2.Text);
  // atualiza combo de Tipo(1)...
  CBxTipo2.ItemIndex := CBxTipo2Int.ItemIndex;}
end;

procedure TFrmCadFornecedor.EdiEMailDblClick(Sender: TObject);
begin
  inherited;
  // Muda cursor
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;
  If (EdiEmailCob.Text = '') Then
    Exit;
   // So envia se estiver preenchido
  ShellExecute(Application.Handle,
               PChar('open'),
               PChar('MailTo:' + EdiEmailCob.Text),
               nil,
               nil,
               SW_SHOWNORMAL);

  Application.ProcessMessages;
  // muda cursor para default
  Screen.Cursor := crDefault;
  Application.ProcessMessages;
end;

procedure TFrmCadFornecedor.EdiUFChange(Sender: TObject);
begin
  inherited;
  CbxUF.ItemIndex := CbxUF.Items.IndexOf(EdiUF.Text);
end;

function TFrmCadFornecedor.ExisteRelacionamento: Boolean;
begin

  QryAux.Close;
  QryAux.SQL.Clear;
  QryAux.SQL.Add('Select Doc_id From ConPag Where CodFornecedor = ' + QuotedStr(EdiCodigo.AsString));
  QryAux.Open;

  Result  := not QryAux.IsEmpty;
  QryAux.Close;

end;

procedure TFrmCadFornecedor.CbxContICMSKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key:=#0;
    SelectNext(ActiveControl,True,True);
  end;
end;

procedure TFrmCadFornecedor.CbxRegimeICMSKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key:=#0;
    SelectNext(ActiveControl,True,True);
  end;
end;

procedure TFrmCadFornecedor.CbxUFClick(Sender: TObject);
begin
  inherited;
  EdiUF.Text := CbxUF.Text;
end;

procedure TFrmCadFornecedor.Search;
begin
  inherited;
  PgCPrincipal.ActivePage := TbSFicha;

  if not FormOpeErro then
  begin

    MEdiCGC.Text := EdtCGC.Text;
    mskCEP.Text  := EdiCEP.Text;
    CbxUF.ItemIndex := CbxUF.Items.IndexOf(EdiUF.Text);
    MEdiCGC.EditMask := '##\.###\.###\/####\-##;0;_';
    lblTipoPessoa.Caption := 'CNPJ';
    lblInscricaoRG.Caption := 'Inscri��o';

    AtualizaGridProduto;

    QryAux.Close;
    QryAux.SQL.Clear;
    QryAux.sql.Add(' Select path_nfe, path_importado, path_invalido, path_temp, path_excel, pastadefault ');
    QryAux.sql.Add(' From fornecedores ');
    QryAux.sql.Add(' Where codfornecedor = :codfornecedor ');
    QryAux.ParamByName( 'codfornecedor').AsInteger := EdiCodigo.AsInteger;
    QryAux.Open;

    editPathNfe.AsString      := QryAux.FieldByName('path_nfe').AsString;
    edipathinvalido.AsString  := QryAux.FieldByName('path_invalido').AsString;
    edipathimportado.AsString := QryAux.FieldByName('path_importado').AsString;
    editpastadefault.AsString  := QryAux.FieldByName('pastadefault').AsString;
    editpathexcel.AsString    := QryAux.FieldByName('path_excel').AsString;
    editpathtemp.AsString     := QryAux.FieldByName('path_temp').AsString;
    QryAux.Close;
  end;

end;

procedure  TFrmCadFornecedor.AtualizaGridProduto;
begin

end;

procedure TFrmCadFornecedor.EdiCEPChange(Sender: TObject);
begin
  inherited;
  if Sender = EdiCEP then
     MskCEP.Text := EdiCEP.Text;
end;

procedure TFrmCadFornecedor.mskCEPExit(Sender: TObject);
begin
  BuscaCEP(mskCEP.Text, EdiEnd, EdiCidade, EdiBairro, EdiUF);
  cbxUF.Enabled   := EdiUF.Enabled;
  CbxUF.ItemIndex := CbxUF.Items.IndexOf(EdiUF.Text);

  if (EdiEnd.Text <> '') and (EdiNum.Enabled) then
    EdiNum.SetFocus;
end;

end.

