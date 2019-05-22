unit uContaSaldo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FCadastro, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  dxSkinsdxStatusBarPainter, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls, cxButtons,
  dxStatusBar, Vcl.Mask, rsEdit, RseditDB, SetParametro, EditBusca, cxContainer,
  cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, TestFun, MensFun, Constantes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmContaSaldo = class(TFrmCadastro)
    Panel3: TPanel;
    ediConta: TrsSuperEdit;
    EditBuscaConta: TEditBusca;
    Panel1: TPanel;
    EdiCodigo: TrsSuperEdit;
    EditBuscaSaldoConta: TEditBusca;
    Panel5: TPanel;
    editxtDtRealizacao: TrsSuperEdit;
    EdiDtExercicioFiscal: TcxDateEdit;
    Panel6: TPanel;
    editSaldo: TrsSuperEdit;
    EditExercicio: TrsSuperEdit;
    EditPeriodoFiscal: TrsSuperEdit;
    QryAux: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButNovoClick(Sender: TObject);
    procedure ButSalvarClick(Sender: TObject);
    procedure EditBuscaSaldoContaClick(Sender: TObject);
    procedure ButExcluirClick(Sender: TObject);
    procedure ButCancelarClick(Sender: TObject);
  private
    { Private declarations }
    procedure ConfiguraAnoFiscal (Data : TDateTime );
    function Check : Boolean ; Override ;
    Procedure Search ; Override;
  public
    { Public declarations }
  end;

var
  FrmContaSaldo: TFrmContaSaldo;

implementation

{$R *.dfm}

uses DBConect;

procedure TFrmContaSaldo.ConfiguraAnoFiscal(Data: TDateTime);
var
 Ano, Mes, Dia: Word;
 MesFiscal : String;
begin
  DecodeDate(Data, Ano, Mes, Dia);


   Case Mes Of
       8  : MesFiscal := '1' ;
       9  : MesFiscal :=  '2' ;
       10 : MesFiscal := '3' ;
       11 : MesFiscal := '4' ;
       12 : MesFiscal := '5' ;
       1  : MesFiscal := '6' ;
       2  : MesFiscal := '7' ;
       3  : MesFiscal := '8' ;
       4  : MesFiscal := '9' ;
       5  : MesFiscal := '10' ;
       6  : MesFiscal := '11' ;
       7  : MesFiscal := '12' ;
   End ;
   EditExercicio.Text     := IntToStr(Ano);
   EditPeriodoFiscal.Text := MesFiscal;

end;

procedure TFrmContaSaldo.EditBuscaSaldoContaClick(Sender: TObject);
begin
  inherited;
  if ((EditBuscaSaldoConta.Text <> '') and (EditBuscaSaldoConta.bs_KeyValues.Count > 0)) then
  begin
   EdiCodigo.AsString := VarToStr(EditBuscaSaldoConta.bs_KeyValue);
   if VarOperacao <> OPE_INCLUSAO then
     ButPesquisarClick(Self);
  end;
end;

procedure TFrmContaSaldo.ButCancelarClick(Sender: TObject);
begin
  inherited;
    EditBuscaSaldoConta.Text := '';
    EditBuscaSaldoConta.bs_KeyValues.Clear;
    EditBuscaConta.Text := '';
    EditBuscaConta.bs_KeyValues.Clear;
    EdiDtExercicioFiscal.Clear;
end;

procedure TFrmContaSaldo.ButExcluirClick(Sender: TObject);
begin
  inherited;
  EditBuscaSaldoConta.Text := '';
  EditBuscaSaldoConta.bs_KeyValues.Clear;
  EditBuscaConta.Text := '';
  EditBuscaConta.bs_KeyValues.Clear;
  EdiDtExercicioFiscal.Clear;
  editSaldo.Clear;
end;

procedure TFrmContaSaldo.ButNovoClick(Sender: TObject);
begin
  inherited;
  EdiCodigo.AsString := LastCodigo('ECF_CONTA_SALDO_ID', 'ECF_CONTA_SALDO', '');
  EdiConta.Clear;


  EditBuscaSaldoConta.Text := EdiCodigo.AsString;
  EditBuscaConta.SetFocus; // foco no campo de Codigo.
end;

procedure TFrmContaSaldo.ButSalvarClick(Sender: TObject);
begin
  if Check then
  begin
    inherited;
    EditBuscaSaldoConta.Text := '';
    EditBuscaSaldoConta.bs_KeyValues.Clear;
    EditBuscaConta.Text := '';
    EditBuscaConta.bs_KeyValues.Clear;
    EdiDtExercicioFiscal.Clear;
  end;

end;

function TFrmContaSaldo.Check: Boolean;
begin
   Result := False ;

   If ( Test_IsEmptyStr(EditBuscaConta.Text) ) Then
	 Begin
			 Mens_MensInf('É necessário informar o Número da CONTA !') ;        //EdiApelido
			 ediConta.SetFocus ;
			 Exit ;
	 End ;

   if EdiDtExercicioFiscal.Text = '' then
   begin
       Mens_MensInf('É necessário informar o Exercício Fiscal !') ;
       editxtDtRealizacao.Text := '';
       exit;
   end

   else
   begin
     editxtDtRealizacao.Text :=  EdiDtExercicioFiscal.Text;
     editxtDtRealizacao.ValidateData;
   end;

   If ( Test_IsEmptyStr(editSaldo.Text) ) Then
	 Begin
			 Mens_MensInf('É necessário informar o Saldo !') ;        //EdiApelido
			 ediConta.SetFocus ;
			 Exit ;
	 End ;

   ediConta.Text     := VarToStr(EditBuscaConta.bs_KeyValue);
   ConfiguraAnoFiscal( editxtDtRealizacao.AsDateTime );

   if VarOperacao = OPE_INCLUSAO then
   begin

       QryAux.Close;
       QryAux.SQL.Clear;
       QryAux.SQL.Add('Select * From ECF_CONTA_SALDO Where ECF_CONTA_ID = :ECF_CONTA_ID and EXERCICIO = :EXERCICIO AND PERIODO_FISCAL = :PERIODO_FISCAL' );
       QryAux.Params.ParamByName('ECF_CONTA_ID').AsString   :=  VarToStr(EditBuscaConta.bs_KeyValue);
       QryAux.Params.ParamByName('EXERCICIO').AsString      :=  EditExercicio.Text;
       QryAux.Params.ParamByName('PERIODO_FISCAL').AsString :=  EditPeriodoFiscal.Text;

       QryAux.Open;
       if not QryAux.IsEmpty then
       begin
           Mens_MensInf('Número de Conta já cadastrada para o perido informado !') ;        //EdiApelido
           ediConta.SetFocus ;
           QryAux.Close;
           Exit ;
       end;
   end;


   Result := True ;

end;

procedure TFrmContaSaldo.FormCreate(Sender: TObject);
begin

  LabCadTit.Caption := 'Lançamento de Saldo de Conta' ;
  FormOperacao      := 'CAD-CONTASALDO';
  FormTabela        := 'ECF_CONTA_SALDO' ;
  FormChaves        := 'ECF_CONTA_SALDO_ID' ;
  FormCtrlFocus     := 'EditBuscaSaldoConta' ;
  FormDataFocus     := 'EditBuscaConta' ;

  inherited;

  SetParametros(EditBuscaSaldoConta, TipoContaSaldo);
  SetParametros(EditBuscaConta, TipoECFConta);
end;

procedure TFrmContaSaldo.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
end;

procedure TFrmContaSaldo.Search;
begin
  inherited;
  EditBuscaConta.SetValue('ECF_CONTA_ID=' + QuotedStr(EdiConta.AsString));

  EdiDtExercicioFiscal.Date := editxtDtRealizacao.AsDateTime;

end;

end.
