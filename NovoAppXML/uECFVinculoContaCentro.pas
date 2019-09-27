unit uECFVinculoContaCentro;

interface

uses
  System.DateUtils,
  dxHashUtils,
  dxSpreadSheet,
  dxSpreadSheetTypes,
  dxSpreadSheetCore,
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
  dxStatusBar, Vcl.Mask, rsEdit, RseditDB, EditBusca,SetParametro,TestFun,MensFun,Constantes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxLabel, dxGDIPlusClasses,
  Vcl.Buttons;




type
  TFrmECFVinculoContaCentro = class(TFrmCadastro)
    Panel1: TPanel;
    EdiCodigo: TrsSuperEdit;
    EditBuscaVinculo: TEditBusca;
    Panel4: TPanel;
    ediCCFilho: TrsSuperEdit;
    Panel3: TPanel;
    ediConta: TrsSuperEdit;
    EditBuscaCC: TEditBusca;
    EditBuscaConta: TEditBusca;
    sqlAux: TFDQuery;
    Panel2: TPanel;
    edi_CENTRO_CUSTO_ID: TrsSuperEdit;
    EditBuscaCCPrincipal: TEditBusca;
    Panel5: TPanel;
    editxtDtRealizacao: TrsSuperEdit;
    EdiDtExercicioFiscal: TcxDateEdit;
    Panel6: TPanel;
    ediPercentual: TrsSuperEdit;
    EditExercicio: TrsSuperEdit;
    EditPeriodoFiscal: TrsSuperEdit;
    OpenDialog: TOpenDialog;
    Panel7: TPanel;
    Image1: TImage;
    cxLabel2: TcxLabel;
    sqlCC: TFDQuery;
    sqlGrupo: TFDQuery;
    btnImportar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditBuscaVinculoClick(Sender: TObject);
    procedure ButSalvarClick(Sender: TObject);
    procedure ButExcluirClick(Sender: TObject);
    procedure ButNovoClick(Sender: TObject);
    procedure EditBuscaCCClick(Sender: TObject);
    procedure EditBuscaContaClick(Sender: TObject);
    procedure EditBuscaCCEnter(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
  private
    { Private declarations }

    ArrayCentroCusto : Variant;
    pECF_Centro_Custo_ID_OLD : String;
    Function Check : Boolean ; Override ;
    Procedure Search ; Override;
    Function SomaPercentual(pECF_Centro_Custo_ID : String; fPercentualAtual : Double = 0.0) : String;
    procedure ConfiguraAnoFiscal(Data: TDateTime);
    procedure Mensagem(pMensagem: String);

    Function BuscaCentroCustoID (pCentroCusto : String) : Integer;
    Function BuscaGrupoID(pCentroCusto : String ) : Integer;
    procedure GravaVinculoCentroCusto;

  public
    { Public declarations }
  end;

var
  FrmECFVinculoContaCentro: TFrmECFVinculoContaCentro;

implementation

{$R *.dfm}

uses DBConect;

procedure TFrmECFVinculoContaCentro.Mensagem(pMensagem : String);
begin

  cxLabel2.Caption := pMensagem;
  Panel7.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;



procedure TFrmECFVinculoContaCentro.btnImportarClick(Sender: TObject);
var
 varNomeArq : String;
  I, X: Integer;
  dxSpreadSheet: TdxSpreadSheet;
  varMes, varAno: Integer;
  varData: TDateTime;
  varPlanta, varBudget, varCentro: String;
  varSetup, varMachine, varLabor, varOverhead: Extended;

  varCC : Integer;
  var2642,	var9216,	varCOEM,	var9211,	var2640,	var9215,	varCMAO,	var9229,	varADMIN : Extended;
  varCCFilho : array[0..8] of Integer;


begin
  inherited;
  if not OpenDialog.Execute then
    exit;

  varNomeArq := OpenDialog.FileName;

  DB_Conect := TDB_Conect.Create(nil);
  Try
      with DB_Conect do
      begin
      Mensagem( 'Iniciando processo de importa��o...' );
      try

        dxSpreadSheet := TdxSpreadSheet.Create(nil);
        try

          Mensagem( 'Carregando planilha...' );
          dxSpreadSheet.LoadFromFile( varNomeArq );
          dxSpreadSheet.BeginUpdate;

          //FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );

          Mensagem( 'Abrindo Conex�o...' );
          FDConnection.Open;
          try

            //FDQueryTSOP_GMHoras.Open;
            try

              ArrayCentroCusto := VarArrayCreate([0, 6], varVariant);

              varCCFilho[0]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[2].AsString);
              varCCFilho[1]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[3].AsString);
              varCCFilho[2]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[4].AsString);
              varCCFilho[3]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[5].AsString);
              varCCFilho[4]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[6].AsString);
              varCCFilho[5]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[7].AsString);
              varCCFilho[6]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[8].AsString);
              varCCFilho[7]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[9].AsString);
              varCCFilho[8]    := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[0].Cells[10].AsString);



              Mensagem( 'Lendo linhas da planilha...' );
              for X := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
              begin
                var2642    := 0;
                var9216    := 0;
                varCOEM    := 0;
                var9211    := 0;
                var2640    := 0;
                var9215    := 0;
                varCMAO    := 0;
                var9229    := 0;
                varADMIN   := 0;

                try
                  {
                  if dxSpreadSheet.ActiveSheetAsTable.Rows[X].CellCount = 0 then
                    Continue;

                  if dxSpreadSheet.ActiveSheetAsTable.Rows[X].CellCount < 9 then
                    Continue;
                   }

                  Mensagem( 'Linha (" ' + IntToStr(X) + '/' + IntToStr(dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex) + '") "' + Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsString) + '" ...' );

                  if Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString) = EmptyStr then
                    Continue;

                except

                  Continue;

                end;

                varCC               := BuscaCentroCustoID(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString);

                //Grupo
                ArrayCentroCusto[0] := BuscaGrupoID(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString);
                // Centro Custo PAI
                ArrayCentroCusto[1] := varCC;

                // Periodo
                ArrayCentroCusto[4] := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[11].AsString;
                ConfiguraAnoFiscal(ArrayCentroCusto[4]);
                //Exercicio
                ArrayCentroCusto[5] :=  EditExercicio.Text;
                //Periodo Fiscal
                ArrayCentroCusto[6] :=  EditPeriodoFiscal.Text;

                var2642    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsFloat;
                if var2642 <> 0 then
                begin
                   // Centro Custo FILHO
                   ArrayCentroCusto[2] := varCCFilho[0];
                   // Percentual
                   ArrayCentroCusto[3] := var2642;
                   GravaVinculoCentroCusto;

                end;

                var9216    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[3].AsFloat;
                if var9216 <> 0 then
                begin
                    ArrayCentroCusto[2] := varCCFilho[1];
                    ArrayCentroCusto[3] := var9216;
                    GravaVinculoCentroCusto;
                end;


                varCOEM    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[4].AsFloat;
                if varCOEM <> 0 then
                begin
                    ArrayCentroCusto[2] := varCCFilho[2];
                    ArrayCentroCusto[3] := varCOEM;
                    GravaVinculoCentroCusto;
                end;


                var9211    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[5].AsFloat;
                if var9211 <> 0 then
                begin
                   ArrayCentroCusto[2] := varCCFilho[3];
                   ArrayCentroCusto[3] := var9211;
                   GravaVinculoCentroCusto;
                end;

                var2640    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6].AsFloat;
                if var2640 <> 0 then
                begin
                   ArrayCentroCusto[2] := varCCFilho[4];
                   ArrayCentroCusto[3] := var2640;
                   GravaVinculoCentroCusto;
                end;

                var9215    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[7].AsFloat;
                if var9215 <> 0 then
                begin
                   ArrayCentroCusto[2] := varCCFilho[5];
                   ArrayCentroCusto[3] := var9215;
                   GravaVinculoCentroCusto;
                end;

                varCMAO    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[8].AsFloat;
                if varCMAO <> 0 then
                begin
                   ArrayCentroCusto[2] := varCCFilho[6];
                   ArrayCentroCusto[3] := varCMAO;
                   GravaVinculoCentroCusto;
                end;

                var9229    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[9].AsFloat;
                if var9229 <> 0 then
                begin
                   ArrayCentroCusto[2] := varCCFilho[7];
                   ArrayCentroCusto[3] := var9229;
                   GravaVinculoCentroCusto;
                end;


                varADMIN   := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[10].AsFloat;
                if varADMIN <> 0 then
                begin
                   ArrayCentroCusto[2] := varCCFilho[8];
                   ArrayCentroCusto[3] := varADMIN;
                   GravaVinculoCentroCusto;
                end;

                Application.ProcessMessages;

              end;

            finally

              //FDQueryTSOP_GMHoras.Close;

            end;

          finally

            FDConnection.Close;

          end;

        finally

          FreeAndNil(dxSpreadSheet);

        end;

      finally

        Mensagem( EmptyStr );

      end;


      end;
  Finally
     FreeAndNil (DB_Conect);
  End;

end;

function TFrmECFVinculoContaCentro.BuscaCentroCustoID(
  pCentroCusto: String): Integer;
var
 varResultado : Integer;
begin
  varResultado := 0;
  sqlCC.Close;
  sqlCC.Params.ParamByName('CENTRO_CUSTO').AsString := pCentroCusto;
  sqlCC.Open;
  if not sqlCC.IsEmpty then
    varResultado := sqlCC.FieldByName('ECF_CENTRO_CUSTO_ID').AsInteger;

  result := varResultado;
end;

function TFrmECFVinculoContaCentro.BuscaGrupoID(pCentroCusto: String): Integer;
var
 varResultado : Integer;
begin
  varResultado := 0;
  sqlGrupo.Close;
  sqlGrupo.Params.ParamByName('CENTRO_CUSTO').AsString := pCentroCusto;
  sqlGrupo.Open;
  if not sqlGrupo.IsEmpty then
    varResultado := sqlGrupo.FieldByName('GRUPO').AsInteger;

  result := varResultado;

end;

procedure TFrmECFVinculoContaCentro.ButExcluirClick(Sender: TObject);
begin
  inherited;
  EditBuscaVinculo.Text := '';
  EditBuscaVinculo.bs_KeyValues.Clear;
  EditBuscaCC.Text := '';
  EditBuscaCC.bs_KeyValues.Clear;
  EditBuscaConta.Text := '';
  EditBuscaConta.bs_KeyValues.Clear;
  pECF_Centro_Custo_ID_OLD := '';

end;

procedure TFrmECFVinculoContaCentro.ButNovoClick(Sender: TObject);
begin
  inherited;
  EdiCodigo.AsString := LastCodigo('ECF_VINCULO_ID', 'ECF_VINCULO', '');
  EdiConta.Clear;
  ediCCFilho.Clear;
  EditBuscaConta.Clear;
  ediPercentual.Clear;

  EditBuscaVinculo.Text := EdiCodigo.AsString;
  EditBuscaConta.SetFocus; // foco no campo de Codigo.
end;

procedure TFrmECFVinculoContaCentro.ButSalvarClick(Sender: TObject);
begin
  if Check then
  begin
    VarIDENTITY := True;
    inherited;
    EditBuscaVinculo.Text := '';
    EditBuscaVinculo.bs_KeyValues.Clear;
    EditBuscaCC.Text := '';
    EditBuscaCC.bs_KeyValues.Clear;
    EditBuscaConta.Text := '';
    ediCCFilho.Text := '';
    EditBuscaCCPrincipal.bs_KeyValues.Clear;
    EditBuscaCCPrincipal.Text := '';
    EditBuscaConta.bs_KeyValues.Clear;
    pECF_Centro_Custo_ID_OLD := '';
     VarIDENTITY := False;
  end;
end;

function TFrmECFVinculoContaCentro.Check: Boolean;
begin

  Result := False ;

   If ( Test_IsEmptyStr(EditBuscaConta.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o N�mero da Grupo de CONTA !') ;        //EdiApelido
			 EditBuscaConta.SetFocus ;
			 Exit ;
	 End ;

   ediConta.AsInteger := StrToInt(EditBuscaConta.Text);

   If ( Test_IsEmptyStr(EditBuscaCCPrincipal.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Centro de Custo Principal !') ;        //EdiApelido
			 EditBuscaCC.SetFocus ;
			 Exit ;
	 End ;

   edi_CENTRO_CUSTO_ID.AsInteger := EditBuscaCCPrincipal.bs_KeyValue;

   If ( Test_IsEmptyStr(EditBuscaCC.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar o Centro de Custo !') ;        //EdiApelido
			 EditBuscaCC.SetFocus ;
			 Exit ;
	 End ;

   ediCCFilho.AsInteger := EditBuscaCC.bs_KeyValue;

   if EdiDtExercicioFiscal.Text = '' then
   begin
       Mens_MensInf('� necess�rio informar o Exerc�cio Fiscal !') ;
       editxtDtRealizacao.Text := '';
       exit;
   end

   else
   begin
     editxtDtRealizacao.Text :=  EdiDtExercicioFiscal.Text;
     editxtDtRealizacao.ValidateData;
   end;

   If ( Test_IsEmptyStr(ediPercentual.Text) ) Then
	 Begin
			 Mens_MensInf('� necess�rio informar a Percentual !') ;        //EdiApelido
			 ediPercentual.SetFocus ;
			 Exit ;
	 End ;
 {
   if ((VarOperacao = OPE_INCLUSAO)  or  (VarOperacao = OPE_ALTERACAO)) then
   begin


     if StrToFloat(SomaPercentual('',0.0)) > 100.00 then
       begin
           Mens_MensInf('Total percentual maior que 100.00 n�o � permitido !') ;        //EdiApelido
           EditBuscaCC.SetFocus ;
           Exit ;
       end;

   end;
  }

   ConfiguraAnoFiscal( editxtDtRealizacao.AsDateTime );

   {
   if VarOperacao = OPE_INCLUSAO then
   begin



      sqlAux.Close;
      sqlAux.SQL.Clear;
      sqlAux.SQL.Add('SELECT ECF_VINCULO_ID ');
      sqlAux.SQL.Add('FROM ECF_VINCULO ');
      sqlAux.SQL.Add('WHERE ECF_CONTA_ID = :ECF_CONTA_ID AND ECF_CENTRO_CUSTO_ID = :ECF_CENTRO_CUSTO_ID ');
      sqlAux.Params.ParamByName('ECF_CONTA_ID').AsInteger        := EditBuscaConta.bs_KeyValue;
      sqlAux.Params.ParamByName('ECF_CENTRO_CUSTO_ID').AsInteger := EditBuscaCC.bs_KeyValue;
      sqlAux.Open;
      if not sqlAux.IsEmpty then
      begin
           sqlAux.Close;
           Mens_MensInf('Este Centro de Custo j� esta associada a este N�mero de Conta !') ;        //EdiApelido
           EditBuscaCC.SetFocus ;
           Exit ;
       End ;
   end;
  }
  Result := True ;

end;

procedure TFrmECFVinculoContaCentro.EditBuscaCCClick(Sender: TObject);
begin
  inherited;
  {
  if ((EditBuscaCC.Text <> '') and (EditBuscaCC.bs_KeyValues.Count > 0)) then
  begin
   ediCC.AsString              := VarToStr(EditBuscaCC.bs_KeyValue);
   ediPercentual.AsString      := EditBuscaCC.bs_KeyValues[1];

   if((ediPercentual.AsString  <> '') and (VarToStr(EditBuscaCC.bs_KeyValue) <> pECF_Centro_Custo_ID_OLD)) then
     ediTotalPercentual.AsString := SomaPercentual(pECF_Centro_Custo_ID_OLD,StrToFloat(ediPercentual.AsString))
   else   ediTotalPercentual.AsString := SomaPercentual('',0.0)
  end
  else
  begin
    ediCC.Clear;
    ediPercentual.Clear;
  end;
  }
end;

procedure TFrmECFVinculoContaCentro.EditBuscaCCEnter(Sender: TObject);
begin
    if ((EditBuscaConta.Text <> '') and (EditBuscaConta.bs_KeyValues.Count > 0)) then

       EditBuscaCC.bs_Filter:= 'not exists (select ECF_CENTRO_CUSTO_ID from ECF_VINCULO x  ' +
                               ' where x.grupo = ' + VarToStr(EditBuscaConta.Text) +
                               ' and  x.ECF_CENTRO_CUSTO_ID = CC.ECF_CENTRO_CUSTO_ID) ';

    if ((EditBuscaCC.Text <> '') and (EditBuscaCC.bs_KeyValues.Count > 0)) then
      pECF_Centro_Custo_ID_OLD :=  VarToStr(EditBuscaCC.bs_KeyValue);

  inherited;

end;

procedure TFrmECFVinculoContaCentro.EditBuscaContaClick(Sender: TObject);
begin
  inherited;
  if ((EditBuscaConta.Text <> '') and (EditBuscaConta.bs_KeyValues.Count > 0)) then
  begin
   ediConta.AsString := VarToStr(EditBuscaConta.bs_KeyValue);
  end else ediConta.Clear;
end;

procedure TFrmECFVinculoContaCentro.EditBuscaVinculoClick(Sender: TObject);
begin
  inherited;
  if ((EditBuscaVinculo.Text <> '') and (EditBuscaVinculo.bs_KeyValues.Count > 0)) then
  begin
   EdiCodigo.AsString := VarToStr(EditBuscaVinculo.bs_KeyValue);
   if VarOperacao <> OPE_INCLUSAO then
     ButPesquisarClick(Self);
  end;

end;

procedure TFrmECFVinculoContaCentro.FormCreate(Sender: TObject);
begin

  LabCadTit.Caption := 'Vincular Conta x Centro de Custo' ;
  FormOperacao      := 'CAD-CONTACENTRO';
  FormTabela        := 'ECF_VINCULO' ;
  FormChaves        := 'ECF_VINCULO_ID' ;
  FormCtrlFocus     := 'EditBuscaVinculo' ;
  FormDataFocus     := 'EditBuscaCC' ;

  SetParametros(EditBuscaVinculo, TipoECFVinculo);
  SetParametros(EditBuscaConta, TipoECFConta);

  SetParametros(EditBuscaCCPrincipal, TipoECFCentroCusto);
  SetParametros(EditBuscaCC, TipoECFCentroCusto);


  inherited;

end;

procedure TFrmECFVinculoContaCentro.ConfiguraAnoFiscal(Data: TDateTime);
var
 Ano, Mes, Dia: Word;
 MesFiscal : String;
begin
  DecodeDate(Data, Ano, Mes, Dia);



   Case Mes Of
       8  : MesFiscal := '1' ;
       9  : MesFiscal := '2' ;
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
   if Mes >= 8 then
     Ano := Ano + 1;

   EditExercicio.Text     := IntToStr(Ano);
   EditPeriodoFiscal.Text := MesFiscal;

end;



procedure TFrmECFVinculoContaCentro.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
end;


procedure TFrmECFVinculoContaCentro.GravaVinculoCentroCusto;
begin
   sqlAux.Close;
   sqlAux.SQL.Clear;
   sqlAux.SQL.Add('INSERT INTO ECF_VINCULO(GRUPO, ECF_CENTRO_CUSTO_ID, ECF_CENTRO_CUSTO_FILHO, PERCENTUAL, DT_EXERCICIOFISCAL, EXERCICIO, PERIODO_FISCAL) ');
   sqlAux.SQL.Add('VALUES (:GRUPO, :ECF_CENTRO_CUSTO_ID, :ECF_CENTRO_CUSTO_FILHO, :PERCENTUAL, :DT_EXERCICIOFISCAL, :EXERCICIO, :PERIODO_FISCAL) ');
   sqlAux.Params.ParamByName('GRUPO').AsInteger                  :=  ArrayCentroCusto[0];
   sqlAux.Params.ParamByName('ECF_CENTRO_CUSTO_ID').AsInteger    :=  ArrayCentroCusto[1];
   sqlAux.Params.ParamByName('ECF_CENTRO_CUSTO_FILHO').AsInteger :=  ArrayCentroCusto[2];
   sqlAux.Params.ParamByName('PERCENTUAL').AsFloat               :=  ArrayCentroCusto[3];
   sqlAux.Params.ParamByName('DT_EXERCICIOFISCAL').asDateTime    :=  ArrayCentroCusto[4];
   sqlAux.Params.ParamByName('EXERCICIO').AsString               :=  ArrayCentroCusto[5];
   sqlAux.Params.ParamByName('PERIODO_FISCAL').AsString          :=  ArrayCentroCusto[6];

    try

      sqlAux.ExecSQL;
    except

      on E: Exception do
      begin

        Mensagem( 'Erro ao Gravar:  ' + E.Message );

      end;

    end;

end;

procedure TFrmECFVinculoContaCentro.Search;
begin
  inherited;
  EditBuscaCC.SetValue('ECF_CENTRO_CUSTO_ID=' + QuotedStr(ediCCFilho.AsString));
  EditBuscaCCPrincipal.SetValue('ECF_CENTRO_CUSTO_ID=' + QuotedStr(edi_CENTRO_CUSTO_ID.AsString));

  EditBuscaConta.SetValue('ECF_CONTA_ID=' + QuotedStr(EdiConta.AsString));

  EdiDtExercicioFiscal.Date := editxtDtRealizacao.AsDateTime;



  {if ((EditBuscaCC.Text <> '') and (EditBuscaCC.bs_KeyValues.Count > 0)) then
  begin
    ediPercentual.AsString   := EditBuscaCC.bs_KeyValues[1];
    pECF_Centro_Custo_ID_OLD := VarToStr(EditBuscaCC.bs_KeyValue);
  end;
   }
  if ((EditBuscaConta.Text <> '') and (EditBuscaConta.bs_KeyValues.Count > 0)) then
  begin
    //EdiTotalPercentual.AsString := SomaPercentual('',0.0);
    EditBuscaCC.bs_Filter:= 'not exists (select ECF_CENTRO_CUSTO_ID from ECF_VINCULO x  ' +
                               ' where x.GRUPO = ' + VarToStr(EditBuscaConta.Text) +
                               ' and  x.ECF_CENTRO_CUSTO_ID = CC.ECF_CENTRO_CUSTO_ID) ';
  end;
end;




function TFrmECFVinculoContaCentro.SomaPercentual(
  pECF_Centro_Custo_ID : String; fPercentualAtual: Double): String;

begin
    sqlAux.Close;
    sqlAux.SQL.Clear;
    sqlAux.SQL.Add('Select COALESCE(SUM(cc.percentual),0) as Total ');
    sqlAux.SQL.Add('from ECF_CENTRO_CUSTO cc ');
    sqlAux.SQL.Add('where cc.ecf_centro_custo_id in (select ecf_centro_custo_id from ecf_vinculo v ');
    if pECF_Centro_Custo_ID <> '' then
    begin
      sqlAux.SQL.Add('								where v.ecf_conta_id = :ecf_conta_id ');
      sqlAux.SQL.Add('               and v.ECF_CENTRO_CUSTO_ID <> :ecf_centro_custo_id)');
    end
    else
    begin
       sqlAux.SQL.Add('								where v.ecf_conta_id = :ecf_conta_id) ')
    end;

    if pECF_Centro_Custo_ID <> '' then
      sqlAux.Params.ParamByName('ecf_centro_custo_id').AsString              :=   pECF_Centro_Custo_ID;

    sqlAux.Params.ParamByName('ecf_conta_id').AsString  := VarToStr(EditBuscaConta.bs_KeyValue);
    sqlAux.Open;

    result := FloatToStr(sqlAux.FieldByName('Total').AsFloat + fPercentualAtual);

end;




end.
