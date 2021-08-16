unit CadEmpresa ;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  fcadastro, ComCtrls, StdCtrls, Buttons, ToolWin, ExtCtrls, rsEdit, Mask,
  rsFlyovr, RseditDB, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxStatusBarPainter,
  cxControls, dxStatusBar, jpeg, DB, DBTables, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookAndFeels, dxSkinBlack,
  dxSkinBlue, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinscxPCPainter, cxPC,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  dxBarBuiltInMenu, Vcl.FileCtrl;

type
  TFrmCadEmpresa = class(TFrmCadastro)
    Panel1: TPanel;
    EdiCodigo: TrsSuperEdit;
    OpenDialog1: TOpenDialog;
    cxPageControl1: TcxPageControl;
    TabGeral: TcxTabSheet;
    tabConfiguracao: TcxTabSheet;
    Panel3: TPanel;
    EdiApelido: TrsSuperEdit;
    Panel2: TPanel;
    EdiNome: TrsSuperEdit;
    Panel11: TPanel;
    EdiCGC: TrsSuperEdit;
    MEdiCGC: TMaskEdit;
    EdiRegime: TrsSuperEdit;
    Panel4: TPanel;
    EdiEnd: TrsSuperEdit;
    EdiComplemento: TrsSuperEdit;
    EdiNum: TrsSuperEdit;
    EdiCEP: TrsSuperEdit;
    mskCEP: TMaskEdit;
    Panel5: TPanel;
    EdiCidade: TrsSuperEdit;
    EdiUF: TrsSuperEdit;
    CbxUF: TComboBox;
    EdiBairro: TrsSuperEdit;
    Panel7: TPanel;
    EdiTelefone2: TrsSuperEdit;
    EdiTipo2: TrsSuperEdit;
    Tipo2: TComboBox;
    Panel6: TPanel;
    EdiTelefone1: TrsSuperEdit;
    EdiTipo1: TrsSuperEdit;
    Tipo1: TComboBox;
    Panel8: TPanel;
    EdiTelefone3: TrsSuperEdit;
    EdiTipo3: TrsSuperEdit;
    Tipo3: TComboBox;
    Panel9: TPanel;
    EdiTelefone4: TrsSuperEdit;
    EdiTipo4: TrsSuperEdit;
    Tipo4: TComboBox;
    Panel10: TPanel;
    EdiEMail: TrsSuperEdit;
    rsSuperEdit10: TrsSuperEdit;
    Panel14: TPanel;
    editPathNfe: TrsSuperEdit;
    Panel15: TPanel;
    Label2: TLabel;
    EdiLogoPremio: TrsSuperEdit;
    cxButton1: TcxButton;
    EdiLogo: TrsSuperEdit;
    SpeedButton2: TcxButton;
    Label6: TLabel;
    EdiFormato: TrsSuperEdit;
    cxButton2: TcxButton;
    GroupBox1: TGroupBox;
    Panel20: TPanel;
    EdiHost: TrsSuperEdit;
    rsSuperEdit9: TrsSuperEdit;
    rsSuperEdit16: TrsSuperEdit;
    Panel21: TPanel;
    rsSuperEdit15: TrsSuperEdit;
    EdiSenha: TrsSuperEdit;
    Panel16: TPanel;
    rsSuperEdit1: TrsSuperEdit;
    rsSuperEdit3: TrsSuperEdit;
    Panel13: TPanel;
    edipathimportado: TrsSuperEdit;
    cxButton4: TcxButton;
    Panel12: TPanel;
    edipathinvalido: TrsSuperEdit;
    cxButton3: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure EdiCodigoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Tipo1Enter(Sender: TObject);
    procedure Tipo2Enter(Sender: TObject);
    procedure Tipo3Enter(Sender: TObject);
    procedure Tipo4Enter(Sender: TObject);
    procedure ButNovoClick(Sender: TObject);
    procedure CbxUFClick(Sender: TObject);
    procedure EdiUFChange(Sender: TObject);
    procedure EdiCGCChange(Sender: TObject);
    procedure Tipo1Click(Sender: TObject);
    procedure Tipo2Click(Sender: TObject);
    procedure Tipo3Click(Sender: TObject);
    procedure Tipo4Click(Sender: TObject);
    procedure mskCEPExit(Sender: TObject);
    procedure EdiCEPChange(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure EdiRegimeKeyPress(Sender: TObject; var Key: Char);
    procedure cxButton1Click(Sender: TObject);
    procedure EdiCreditoSNChange(Sender: TObject);
    procedure ButSalvarClick(Sender: TObject);
    procedure ButCancelarClick(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
  private
    function SelectADirectory(Title: string): string;
    { Private declarations }
  public
    { Public declarations }
    Function Check : Boolean ; Override ;
    Procedure Search ; Override ;
  end;

var
  FrmCadEmpresa: TFrmCadEmpresa;

implementation

{$R *.DFM}

Uses
   Global, ObjFun, MensFun, TestFun, ConsTabFun, Constantes, StrFun ;

function TFrmCadEmpresa.SelectADirectory(Title : string) : string;
var
  Pasta : String;
begin
  SelectDirectory(Title, '', Pasta);

  if (Trim(Pasta) <> '') then
    if (Pasta[Length(Pasta)] <> '\') then
      Pasta := Pasta;

  if not CreateDir( IncludeTrailingPathDelimiter( Pasta ) + EdiCodigo.Text ) then
  begin
      Mens_MensInf('N�o foi poss�vel criar o Diretorio da Empresa !') ;
      Result := '';
  end
  else
     Result := Pasta + '\Empresa_' + EdiCodigo.Text + '\';
end;


procedure TFrmCadEmpresa.FormCreate(Sender: TObject);
begin
		LabCadTit.Caption := 'Cadastro de Empresas' ;
		FormOperacao := '';// 'CAD_EMPRESA' ;
		FormTabela := 'filial' ;
		FormChaves := 'codfilial' ;
		FormCtrlFocus := 'EdiCodigo' ;
		FormDataFocus := 'EdiApelido' ;
    FormOBS       := 'MsgValores';
    WindowState := wsMaximized;
		inherited;
end;

procedure TFrmCadEmpresa.ButCancelarClick(Sender: TObject);
begin
  EdiCodigo.Enabled := True;
  inherited;

end;

procedure TFrmCadEmpresa.ButNovoClick(Sender: TObject);
begin
  inherited;
  Tipo1.ItemIndex:=-1;
  Tipo2.ItemIndex:=-1;
  Tipo3.ItemIndex:=-1;
  Tipo4.ItemIndex:=-1;


  EdiCodigo.AsString := LastCodigo('codfilial', 'filial', '');
  EdiCodigo.Enabled := False;
  mskCEP.Text := '';
  EdiApelido.SetFocus; // foco no campo de Codigo.
end;

Function TFrmCadEmpresa.Check : Boolean ;
Begin
	 Result := False ;
   // Alias Obrigatorio
   If ( Test_IsEmptyStr(EdiApelido.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Alias !') ;        //EdiApelido
			 EdiApelido.SetFocus ;
			 Exit ;
	 End ;

	 If ( Test_IsEmptyStr(EdiNome.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar a Raz�o !') ;        // EdiNome
			 EdiNome.SetFocus ;
			 Exit ;
	 End ;


    // verifica CGC = CNPJ
   if Trim(Copy(MEdiCGC.Text, 1, 1)) <> '' then
      begin
        If ( Test_IsEmptyStr(MEdiCGC.Text) = FALSE ) Then
        Begin
         EdiCGC.Text := MEdiCGC.Text;
         If (Test_CheckCGC(MEdiCGC.Text) = FALSE) Then // cgc nao bate
         Begin
            Mens_MensInf('N�mero do CNPJ n�o confere.') ;
            MEdiCGC.SetFocus ;
            Exit ;
         End ;
        End;
      end
   else
      EdiCGC.Text := '';

   // Se telefone preenchido o Respectivo Tipo e obrigatorio
   If ( Test_IsEmptyStr(EdiTelefone1.Text) = FALSE)
   AND (Tipo1.ItemIndex < 0 ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Tipo do Telefone (1) !') ;
			 Tipo1.SetFocus ;
			 Exit ;
	 End ;
   If ( Test_IsEmptyStr(EdiTelefone2.Text) = FALSE)
   AND (Tipo2.ItemIndex < 0 ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Tipo do Telefone (2) !') ;
			 Tipo2.SetFocus ;
			 Exit ;
	 End ;
   If ( Test_IsEmptyStr(EdiTelefone3.Text) = FALSE)
   AND (Tipo3.ItemIndex < 0 ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Tipo do Telefone (3) !') ;
			 Tipo3.SetFocus ;
			 Exit ;
	 End ;
   If ( Test_IsEmptyStr(EdiTelefone4.Text) = FALSE)
   AND (Tipo4.ItemIndex < 0 ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Tipo do Telefone (4) !') ;
			 Tipo4.SetFocus ;
			 Exit ;
	 End ;


   EdiCEP.AsString     := MskCEP.Text;



   // todos os campos obrigatorios preenchidos retorna TRUE
   Result := True ;
End ;

procedure TFrmCadEmpresa.cxButton1Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.DefaultEXT := 'png';
  OpenDialog1.Filter := 'Arquivo de Imagem (bmp,png, jpg)|*.png;*.jpg;*.bmp';
  if not OpenDialog1.Execute then Exit;

  EdiLogoPremio.AsString := OpenDialog1.FileName;

end;

procedure TFrmCadEmpresa.cxButton2Click(Sender: TObject);
begin
  inherited;
  editPathNfe.Text := SelectADirectory('Selecione o Path dos Arq. NFE (xml)');
end;

procedure TFrmCadEmpresa.cxButton3Click(Sender: TObject);
begin
  inherited;
  edipathimportado.Text :=  SelectADirectory('Selecione o Path dos Arq. Importados');
end;

procedure TFrmCadEmpresa.cxButton4Click(Sender: TObject);
begin
  inherited;
   edipathinvalido.Text :=  SelectADirectory('Selecione o Path dos Arq. Inv�lidos.');
end;

procedure TFrmCadEmpresa.EdiCodigoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ButPesquisarClick(Self) ;
end;

procedure TFrmCadEmpresa.EdiCreditoSNChange(Sender: TObject);
begin
  inherited;

end;

// ***** 1 - Se Telefone em branco tipo tambem sera
procedure TFrmCadEmpresa.Tipo1Enter(Sender: TObject);
begin
  inherited;
  If ( Test_IsEmptyStr(EdiTelefone1.Text))  Then
			 Tipo1.ItemIndex := -1;
end;

procedure TFrmCadEmpresa.Tipo2Enter(Sender: TObject);
begin
  inherited;
  If ( Test_IsEmptyStr(EdiTelefone2.Text))  Then
			 Tipo2.ItemIndex := -1;
end;

procedure TFrmCadEmpresa.Tipo3Enter(Sender: TObject);
begin
  inherited;
  If ( Test_IsEmptyStr(EdiTelefone3.Text))  Then
			 Tipo3.ItemIndex := -1;
end;

procedure TFrmCadEmpresa.Tipo4Enter(Sender: TObject);
begin
  inherited;
  If ( Test_IsEmptyStr(EdiTelefone4.Text))  Then
			 Tipo4.ItemIndex := -1;
end;
// ***** FINAL 1 *****

procedure TFrmCadEmpresa.ButSalvarClick(Sender: TObject);
begin
  EdiCodigo.Enabled := True;
  inherited;

end;

procedure TFrmCadEmpresa.CbxUFClick(Sender: TObject);
begin
  inherited;
  EdiUF.Text := CbxUF.Text;
end;

procedure TFrmCadEmpresa.EdiUFChange(Sender: TObject);
begin
  inherited;
  CbxUF.ItemIndex := CbxUF.Items.IndexOf(EdiUF.Text);
end;

procedure TFrmCadEmpresa.EdiCGCChange(Sender: TObject);
begin
  inherited;
  MEdiCGC.EditMask := '##\.###\.###\/####\-##;0;_';
  MEdiCGC.Text := EdiCGC.AsString;
end;

procedure TFrmCadEmpresa.Tipo1Click(Sender: TObject);
begin
  inherited;
  EdiTipo1.AsString := IntToStr(Tipo1.ItemIndex);
  EdiTipo1.ValidateData;
end;

procedure TFrmCadEmpresa.Tipo2Click(Sender: TObject);
begin
  inherited;
  EdiTipo2.AsString := IntToStr(Tipo2.ItemIndex);
  EdiTipo2.ValidateData;
end;

procedure TFrmCadEmpresa.Tipo3Click(Sender: TObject);
begin
  inherited;
  EdiTipo3.AsString := IntToStr(Tipo3.ItemIndex);
  EdiTipo3.ValidateData;
end;

procedure TFrmCadEmpresa.Tipo4Click(Sender: TObject);
begin
  inherited;
  EdiTipo4.AsString := IntToStr(Tipo4.ItemIndex);
  EdiTipo4.ValidateData;
end;

procedure TFrmCadEmpresa.mskCEPExit(Sender: TObject);
begin
  inherited;

  BuscaCEP(mskCEP.Text, EdiEnd, EdiCidade, EdiBairro, EdiUF);
  cbxUF.Enabled   := EdiUF.Enabled;
  CbxUF.ItemIndex := CbxUF.Items.IndexOf(EdiUF.Text);

  if (EdiEnd.Text <> '') and (EdiNum.Enabled) then
    EdiNum.SetFocus;

end;

procedure TFrmCadEmpresa.EdiCEPChange(Sender: TObject);
begin
  inherited;
  MskCEP.Text := EdiCEP.Text
end;

procedure TFrmCadEmpresa.Search;
begin
  inherited;
  Tipo1.ItemIndex:=-1;
  Tipo2.ItemIndex:=-1;
  Tipo3.ItemIndex:=-1;
  Tipo4.ItemIndex:=-1;

  if not FormOpeErro then
  begin
    if EdiTipo1.AsString <> '' then
      Tipo1.ItemIndex := StrToInt(EdiTipo1.AsString);

    if EdiTipo2.AsString <> '' then
      Tipo2.ItemIndex := StrToInt(EdiTipo2.AsString);

    if EdiTipo3.AsString <> '' then
      Tipo3.ItemIndex := StrToInt(EdiTipo3.AsString);

    if EdiTipo4.AsString <> '' then
      Tipo4.ItemIndex := StrToInt(EdiTipo4.AsString);

  end;

end;

procedure TFrmCadEmpresa.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  OpenDialog1.DefaultEXT := 'png';
  OpenDialog1.Filter := 'Arquivo de Imagem (bmp,png, jpg)|*.png;*.jpg;*.bmp';
  if not OpenDialog1.Execute then Exit;

  EdiLogo.AsString := OpenDialog1.FileName;
end;

procedure TFrmCadEmpresa.EdiRegimeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key <> 'S') and (Key <> 'N') and (Key <> 's') and (Key <> 'n') then Key := #0;
end;

end.
