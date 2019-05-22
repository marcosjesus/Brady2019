unit CadEmail ;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  fcadastro, ComCtrls, StdCtrls, Buttons, ToolWin, ExtCtrls, rsEdit, Mask,
  rsFlyovr, RseditDB, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxStatusBarPainter,
  cxControls, dxStatusBar, jpeg, DB, DBTables, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookAndFeels, dxSkinBlack,
  dxSkinBlue, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, SqlExpr, DateUtils,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue,
  cxGroupBox, dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint;

type
  TFrmCadEmail = class(TFrmCadastro)
    Panel1: TPanel;
    EdiCodigo: TrsSuperEdit;
    Panel3: TPanel;
    EdiNome: TrsSuperEdit;
    Panel11: TPanel;
    Panel5: TPanel;
    EditSenha: TrsSuperEdit;
    Panel12: TPanel;
    editSSL: TrsSuperEdit;
    Panel2: TPanel;
    EditPorta: TrsSuperEdit;
    Panel4: TPanel;
    EditTLS: TrsSuperEdit;
    CbxSSL: TComboBox;
    CbxTLS: TComboBox;
    Panel7: TPanel;
    EditUsuario: TrsSuperEdit;
    EditHost: TrsSuperEdit;
    cxGroupBox1: TcxGroupBox;
    Panel6: TPanel;
    EditPastaEntrada: TrsSuperEdit;
    Panel8: TPanel;
    EditPastaSPAM: TrsSuperEdit;
    Panel9: TPanel;
    EditPastaOutros: TrsSuperEdit;
    Panel10: TPanel;
    EditPastaPDF: TrsSuperEdit;
    Panel13: TPanel;
    EditPastaNFELido: TrsSuperEdit;
    Panel14: TPanel;
    EditPastaCTELido: TrsSuperEdit;
    cbxAtivo: TComboBox;
    EditAtivo: TrsSuperEdit;
    procedure FormCreate(Sender: TObject);
    procedure EdiCodigoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButNovoClick(Sender: TObject);
    procedure EdiRegimeKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure ButSalvarClick(Sender: TObject);
    procedure EditPortaKeyPress(Sender: TObject; var Key: Char);
    procedure CbxSSLClick(Sender: TObject);
    procedure editSSLChange(Sender: TObject);
    procedure CbxTLSClick(Sender: TObject);
    procedure EditTLSChange(Sender: TObject);
    procedure cbxAtivoClick(Sender: TObject);
    procedure EditAtivoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Function Check : Boolean ; Override ;
    Procedure Search ; Override ;
  end;

function DirExists( const Directory: string ): boolean;

var
  FrmCadEmail: TFrmCadEmail;

implementation


{$R *.DFM}

Uses
   Global, ObjFun, MensFun, TestFun, ConsTabFun, Constantes, StrFun , DBConect;

procedure TFrmCadEmail.FormCreate(Sender: TObject);
begin
		LabCadTit.Caption := 'Cadastro de Conta de E-mail ' ;
		FormOperacao := ''; //'CAD_EMPRESA' ;
		FormTabela := 'CTE_EMAIL' ;
		FormChaves := 'CTE_EMAIL_ID' ;
		FormCtrlFocus := 'EdiCodigo' ;
		FormDataFocus := 'EdiNome' ;
		inherited;
end;

procedure TFrmCadEmail.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
end;

function DirExists( const Directory: string ): boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(Directory));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;


procedure TFrmCadEmail.ButNovoClick(Sender: TObject);
begin
  inherited;
  EdiCodigo.AsString := LastCodigo('CTE_EMAIL_ID', 'CTE_EMAIL', '');
  EdiNome.SetFocus; // foco no campo de Codigo.
end;

Function TFrmCadEmail.Check : Boolean ;
var
 xAno, xMes : Integer;
 yAno, yMes : Word;
 lPath : String;
Begin
	 Result := False ;

   If ( Test_IsEmptyStr(EdiNome.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Nome da Conta de E-mail!') ;
			 EdiNome.SetFocus ;
			 Exit ;
	 End ;

   If ( Test_IsEmptyStr(EditHost.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Nome do Servidor!') ;
			 EditHost.SetFocus ;
			 Exit ;
	 End ;

   If ( Test_IsEmptyStr(EditUsuario.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Nome do Usu�rio!') ;
			 EditUsuario.SetFocus ;
			 Exit ;
	 End ;

   If ( Test_IsEmptyStr(EditSenha.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar a Senha!') ;
			 EditSenha.SetFocus ;
			 Exit ;
	 End ;

   If ( Test_IsEmptyStr(EditPorta.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o N�mero da Porta!') ;
			 EditPorta.SetFocus ;
			 Exit ;
	 End ;

   If ( Test_IsEmptyStr(EditPastaEntrada.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Nome da Pasta de Entrada!') ;
			 EditPastaEntrada.SetFocus ;
			 Exit ;
	 End ;

   If ( Test_IsEmptyStr(EditPastaSPAM.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Nome da Pasta de SPAM!') ;
			 EditPastaSPAM.SetFocus ;
			 Exit ;
	 End ;

   If ( Test_IsEmptyStr(EditPastaPDF.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Nome da Pasta de PDF!') ;
			 EditPastaPDF.SetFocus ;
			 Exit ;
	 End ;

   If ( Test_IsEmptyStr(EditPastaNFELido.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Nome da Pasta de NFE Lido!') ;
			 EditPastaNFELido.SetFocus ;
			 Exit ;
	 End ;

   If ( Test_IsEmptyStr(EditPastaCTELido.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Nome da Pasta de CTE Lido!') ;
			 EditPastaCTELido.SetFocus ;
			 Exit ;
	 End ;

   // todos os campos obrigatorios preenchidos retorna TRUE
   Result := True ;
End ;

procedure TFrmCadEmail.EditTLSChange(Sender: TObject);
begin
  inherited;
  CbxTLS.ItemIndex := CbxTLS.Items.IndexOf(EditTLS.Text);
end;

procedure TFrmCadEmail.EdiCodigoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ButPesquisarClick(Self) ;
end;


procedure TFrmCadEmail.ButSalvarClick(Sender: TObject);
begin

 if not Check then
    Exit;

 { if VarOperacao = OPE_INCLUSAO then
  begin

  end;
  }

  inherited;

end;

procedure TFrmCadEmail.cbxAtivoClick(Sender: TObject);
begin
  inherited;
  EditAtivo.Text := cbxAtivo.Text;
end;

procedure TFrmCadEmail.CbxSSLClick(Sender: TObject);
begin
  inherited;
  editSSL.Text := CbxSSL.Text;
end;

procedure TFrmCadEmail.CbxTLSClick(Sender: TObject);
begin
  inherited;
  EditTLS.Text := CbxTLS.Text;
end;

procedure TFrmCadEmail.Search;
begin
  inherited;

  if not FormOpeErro then
  begin
    CbxSSL.ItemIndex   := CbxSSL.Items.IndexOf(editSSL.Text);
    CbxTLS.ItemIndex   := CbxTLS.Items.IndexOf(EditTLS.Text);
    cbxAtivo.ItemIndex := cbxAtivo.Items.IndexOf(EditAtivo.Text);
  end;

end;

procedure TFrmCadEmail.EdiRegimeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key <> 'S') and (Key <> 'N') and (Key <> 's') and (Key <> 'n') then Key := #0;
end;


procedure TFrmCadEmail.EditAtivoChange(Sender: TObject);
begin
  inherited;
  cbxAtivo.ItemIndex := cbxAtivo.Items.IndexOf(EditAtivo.Text);
end;

procedure TFrmCadEmail.EditPortaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  if (not ((Key in ['0'..'9',#8]))) then
      Key:= #0;

end;

procedure TFrmCadEmail.editSSLChange(Sender: TObject);
begin
  inherited;
  CbxSSL.ItemIndex := CbxSSL.Items.IndexOf(editSSL.Text);
end;

end.

