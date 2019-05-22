unit uCadPeriodicidade;

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
  dxStatusBar, Vcl.Mask, rsEdit, RseditDB,MensFun,TestFun,Constantes,
  Data.FMTBcd, Data.DB, Data.SqlExpr, SetParametro, EditBusca,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmCadPeriodicidade = class(TFrmCadastro)
    Panel2: TPanel;
    EdiNome: TrsSuperEdit;
    Panel1: TPanel;
    EdiCodigo: TrsSuperEdit;
    Panel3: TPanel;
    ediDias: TrsSuperEdit;
    EditBuscaPeriodo: TEditBusca;
    qryAux: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButNovoClick(Sender: TObject);
    procedure ButSalvarClick(Sender: TObject);
    procedure ButCancelarClick(Sender: TObject);
    procedure EditBuscaPeriodoClick(Sender: TObject);
    procedure ButExcluirClick(Sender: TObject);
  private
    { Private declarations }
    Function Check : Boolean ; Override ;
  public
    { Public declarations }
  end;

var
  FrmCadPeriodicidade: TFrmCadPeriodicidade;

implementation

{$R *.dfm}

procedure TFrmCadPeriodicidade.ButCancelarClick(Sender: TObject);
begin
  inherited;
  EditBuscaPeriodo.Text := '';
  EditBuscaPeriodo.bs_KeyValues.Clear;
end;

procedure TFrmCadPeriodicidade.ButExcluirClick(Sender: TObject);
begin
  inherited;
 EditBuscaPeriodo.Text := '';
 EditBuscaPeriodo.bs_KeyValues.Clear;
end;

procedure TFrmCadPeriodicidade.ButNovoClick(Sender: TObject);
begin
  inherited;
  qryAux.Close;
  qryAux.Sql.Clear;
  qryAux.Sql.Add('Select CodigoPeriodicidade From Parametros ') ;
  qryAux.Open;
  EdiCodigo.AsInteger := qryAux.FieldByName('CodigoPeriodicidade').AsInteger + 1 ;
  qryAux.close;
  EditBuscaPeriodo.Text := EdiCodigo.AsString;
  EdiNome.SetFocus;
end;

procedure TFrmCadPeriodicidade.ButSalvarClick(Sender: TObject);
var
  Inclui : Boolean;
begin

  Inclui := (VarOperacao = OPE_INCLUSAO);
  inherited;

   if (not FormOpeErro) and (Inclui) then
  begin
    qryAux.Close;
    qryAux.Sql.Clear;
    qryAux.Sql.Add('update Parametros set CodigoPeriodicidade = CodigoPeriodicidade + 1 ') ;
    qryAux.ExecSQL;
  end;
  EditBuscaPeriodo.Text := '';
  EditBuscaPeriodo.bs_KeyValues.Clear;

end;

function TFrmCadPeriodicidade.Check: Boolean;
begin
   Result := False ;

   If ( Test_IsEmptyStr(EdiNome.Text) ) Then
   Begin
       Mens_MensInf('� necess�rio informar o campo Periodicidade') ;
       EdiNome.SetFocus ;
       Exit ;
   End ;

   Result := True ;
end;

procedure TFrmCadPeriodicidade.EditBuscaPeriodoClick(Sender: TObject);
begin
  inherited;
  if ((EditBuscaPeriodo.Text <> '') and (EditBuscaPeriodo.bs_KeyValues.Count > 0)) then
  begin
    EdiCodigo.AsInteger :=  StrToInt(VarToStr(EditBuscaPeriodo.bs_KeyValue));
    if VarOperacao <> OPE_INCLUSAO then
      ButPesquisarClick(Self);
  end;

end;

procedure TFrmCadPeriodicidade.FormCreate(Sender: TObject);
begin

  LabCadTit.Caption := 'Periodicidade' ;
  FormOperacao := 'CAD_PERIODICIDADE';
  FormTabela := 'TRE_PERIODICIDADE' ;
  FormChaves := 'PERIODICIDADE_ID' ;
  FormCtrlFocus := 'EditBuscaPeriodo' ;
  FormDataFocus := 'EdiNome' ;

  SetParametros(EditBuscaPeriodo,  TipoPeriodicidadeID);

  inherited;
end;

procedure TFrmCadPeriodicidade.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
end;

end.
