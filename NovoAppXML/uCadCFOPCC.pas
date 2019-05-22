unit uCadCFOPCC;

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
  dxStatusBar, Vcl.Mask, rsEdit, RseditDB, EditBusca, SetParametro, TestFun, MensFun,
  Constantes;

type
  TFrmCadCFOPCC = class(TFrmCadastro)
    Panel1: TPanel;
    EdiCodigo: TrsSuperEdit;
    EditBuscaCFOPCC: TEditBusca;
    Panel3: TPanel;
    EdiConta: TrsSuperEdit;
    Panel2: TPanel;
    ediCFOP: TrsSuperEdit;
    procedure FormCreate(Sender: TObject);
    procedure ButNovoClick(Sender: TObject);
    procedure ButExcluirClick(Sender: TObject);
    procedure ButSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditBuscaCFOPCCClick(Sender: TObject);
  private
    { Private declarations }
    Function Check : Boolean ; Override ;
  public
    { Public declarations }
  end;

var
  FrmCadCFOPCC: TFrmCadCFOPCC;

implementation

{$R *.dfm}

procedure TFrmCadCFOPCC.ButExcluirClick(Sender: TObject);
begin
  inherited;
  EditBuscaCFOPCC.Text := '';
  EditBuscaCFOPCC.bs_KeyValues.Clear;
end;

procedure TFrmCadCFOPCC.ButNovoClick(Sender: TObject);
begin
  inherited;
  EdiCodigo.AsString := LastCodigo('ARQ_CFOP_ID', 'ARQ_CFOP', '');
  EdiCFOP.Clear;
  EdiConta.Clear;

  EditBuscaCFOPCC.Text := EdiCodigo.AsString;
  EdiCFOP.SetFocus; // foco no campo de Codigo.
end;

procedure TFrmCadCFOPCC.ButSalvarClick(Sender: TObject);
begin
  if Check then
  begin
    inherited;
    EditBuscaCFOPCC.Text := '';
    EditBuscaCFOPCC.bs_KeyValues.Clear;
  end;

end;

function TFrmCadCFOPCC.Check: Boolean;
begin
	 Result := False ;

   If ( Test_IsEmptyStr(ediCFOP.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o CFOP !') ;        //EdiApelido
			 ediCFOP.SetFocus ;
			 Exit ;
	 End ;

   If ( Test_IsEmptyStr(EdiConta.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar a Conta Cont�bil !') ;        //EdiApelido
			 EdiConta.SetFocus ;
			 Exit ;
	 End ;

   Result := True ;
end;

procedure TFrmCadCFOPCC.EditBuscaCFOPCCClick(Sender: TObject);
begin
  inherited;
  if ((EditBuscaCFOPCC.Text <> '') and (EditBuscaCFOPCC.bs_KeyValues.Count > 0)) then
  begin
   EdiCodigo.AsString := VarToStr(EditBuscaCFOPCC.bs_KeyValue);
   if VarOperacao <> OPE_INCLUSAO then
     ButPesquisarClick(Self);
  end;
end;

procedure TFrmCadCFOPCC.FormCreate(Sender: TObject);
begin

  LabCadTit.Caption := 'Cadastro de CFOP x Conta Cont�bil ' ;
  FormOperacao      := 'CAD_CFOPCC';
  FormTabela        := 'ARQ_CFOP' ;
  FormChaves        := 'ARQ_CFOP_ID' ;
  FormCtrlFocus     := 'EditBuscaCFOPCC' ;
  FormDataFocus     := 'EdiCFOP' ;

  SetParametros(EditBuscaCFOPCC, TipoCFOPCC);

  inherited;

end;

procedure TFrmCadCFOPCC.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
end;

end.
