unit uRelatorioRecuperacaoContas;

interface

uses
  System.IOUtils,
  System.DateUtils,

  dxSpreadSheet,
  dxSpreadSheetTypes,


  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinscxPCPainter, dxBarBuiltInMenu, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxContainer, cxClasses, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxCustomPivotGrid, cxDBPivotGrid, cxLabel,
  dxGDIPlusClasses, Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGrid, cxPC, dxSkinsDefaultPainters, dxSkinOffice2013White, Vcl.ComCtrls, dxCore, cxDateUtils, Vcl.Menus, Vcl.StdCtrls,
  cxButtons, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxCheckBox, cxCheckComboBox, FireDAC.Comp.ScriptCommands,
  FireDAC.Comp.Script, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, cxEditRepositoryItems, cxImageComboBox,
  cxButtonEdit, cxHyperLinkEdit;

type
  TFr_RelatorioRecuperacaoContas = class(TForm)
    FDConnection: TFDConnection;
    FDQueryVSOP_OrderBilling00: TFDQuery;
    DataSourceVSOP_OrderBilling00: TDataSource;
    cxPageControl: TcxPageControl;
    cxTabSheetGrid: TcxTabSheet;
    cxPageControlFiltro: TcxPageControl;
    cxTabSheetFiltro: TcxTabSheet;
    cxButtonRefresh: TcxButton;
    cxLabel1: TcxLabel;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILCLICOD: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_CLISAPCLINOM: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILITECOD: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ITECLISAPITECLICOD: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILDATDOC: TSQLTimeStampField;
    cxCanal: TcxComboBox;
    Label1: TLabel;
    FDQueryVSOP_OrderBilling00TSOP_SUSPEXCLUIDO: TIntegerField;
    FDQueryVSOP_OrderBilling00TSOP_DTASUSPENSO: TSQLTimeStampField;
    FDQueryVSOP_OrderBilling00TSOP_MOTIVOEXCLUSAO: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILREPNOM: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILGRUCLINOM: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_PRIMARYCATALOG: TStringField;
    SaveDialog: TSaveDialog;
    cxLabel4: TcxLabel;
    cxButtonEditPath: TcxButtonEdit;
    ButExcel: TcxButton;
    FDQueryVSOP_OrderBilling00TSOP_ORINOM: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILSITNOM: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILCANNOM: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILYEADOCCAL: TIntegerField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILMONDOCCAL: TIntegerField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILYEADOC: TIntegerField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILMONDOC: TIntegerField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILNRODOC: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILTIPDOC: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILNRODOCREF: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILYEADOCREQCAL: TIntegerField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILMONDOCREQCAL: TIntegerField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILYEADOCREQ: TIntegerField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILMONDOCREQ: TIntegerField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILDATDOCREQ: TSQLTimeStampField;
    FDQueryVSOP_OrderBilling00TSOP_GRUCLIMER: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_REPNOMINT: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_REPCSR: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_REPMKT: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILITENOM: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILITEUNI: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILITEFAM: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILITEFAMPAI: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILITEFAM001: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILITEFAM002: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILITEFAM003: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILITEFAM004: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILITEFAM005: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILVALLIQ: TBCDField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILQTD: TBCDField;
    FDQueryVSOP_OrderBilling00TSOP_REPACCTYP: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILREGEST: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILREG: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_CUSTOMERPURCHASE: TStringField;
    FDQueryVSOP_OrderBilling00TSOP_LINKSALESFORCE: TStringField;
    cxTabSheet1: TcxTabSheet;
    cxGridContas: TcxGrid;
    cxGridContasDBTableContas: TcxGridDBTableView;
    cxGridContasDBTableContasTSOP_ORINOM: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILSITNOM: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILCANNOM: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILYEADOCCAL: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILMONDOCCAL: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILYEADOC: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILMONDOC: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILGRUCLINOM: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILCLICOD: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILDATDOC: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILDATDOCREQ: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILNRODOC: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILNRODOCREF: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILQTD: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILVALLIQ: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILITECOD: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILTIPDOC: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILYEADOCREQCAL: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILMONDOCREQCAL: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILYEADOCREQ: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILMONDOCREQ: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_GRUCLIMER: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILREPNOM: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_REPNOMINT: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_REPMKT: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_REPCSR: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILITEFAM: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILITEFAM001: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILITEFAM002: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILITEFAM003: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILITEFAM004: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILITEFAM005: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_REPACCTYP: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILREGEST: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILREG: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_ORDBILITEFAMPAI: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_PRIMARYCATALOG: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_CUSTOMERPURCHASE: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_LINKSALESFORCE: TcxGridDBColumn;
    cxGridLevelTableContas: TcxGridLevel;
    cxGridContasDBTableContasTSOP_CLISAPCLINOM: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_SUSPEXCLUIDO: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_DTASUSPENSO: TcxGridDBColumn;
    cxGridContasDBTableContasTSOP_MOTIVOEXCLUSAO: TcxGridDBColumn;
    FDQueryVSOP_OrderBilling00TSOP_ORDBILCOD: TFDAutoIncField;
    cbPeriodo: TcxComboBox;
    FDQueryAux: TFDQuery;
    FDQueryAuxMES: TIntegerField;
    FDQueryVSOP_OrderBilling00NRODIAS: TIntegerField;
    cxGridContasDBTableContasNRODIAS: TcxGridDBColumn;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    FDQueryAux2: TFDQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure cxButtonRefreshClick(Sender: TObject);
    procedure FDQueryVSOP_OrderBilling00BeforePost(DataSet: TDataSet);
    procedure ButExcelClick(Sender: TObject);
    procedure cxButtonEditPathClick(Sender: TObject);
    procedure cxGridContasFocusedViewChanged(Sender: TcxCustomGrid;
      APrevFocusedView, AFocusedView: TcxCustomGridView);
    procedure cxGridContasDBTableContasCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    procedure Mensagem( pMensagem: String );
    { Private declarations }
  public
    procedure AbrirDataset;
    procedure LoadGridCustomization;
    { Public declarations }
  end;

var
  Fr_RelatorioRecuperacaoContas: TFr_RelatorioRecuperacaoContas;

implementation

{$R *.dfm}

uses uBrady, uUtils, uUtilsOwner, ShellAPI;

procedure TFr_RelatorioRecuperacaoContas.AbrirDataset;
var
 iPeriodo : Integer;
begin

  Mensagem( 'Abrindo conex�o...' );
  try

    if not FDConnection.Connected then
    begin

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

    end;

    // Volta registro aparecer na consulta ap�s ser suspenso depois de 90 dias.
    FDQueryAux2.Close;
    FDQueryAux2.SQL.clear;
    FDQueryAux2.SQL.Add('UPDATE TSOP_ORDERBILLING  ');
    FDQueryAux2.SQL.Add('SET TSOP_DTASUSPENSO = NULL, TSOP_SUSPEXCLUIDO = NULL   ');
    FDQueryAux2.SQL.Add('WHERE DATEDIFF(DAY,  TSOP_DTASUSPENSO, GETDATE()) > 90 AND TSOP_SUSPEXCLUIDO = 1 ');
    FDQueryAux2.SQL.Add('AND  TSOP_ORDBILTIPDOC = ''BILLING'' ');
    Try
     FDQueryAux2.ExecSQL;
    except
      on E : Exception do
        begin
          MessageDlg( 'Erro ao Alterar Tabela TSOP_OrderBilling: ' + #13 + #13 +
                       E.Message, mtError, [ mbOk ], 0 );
        end;
    end;


    Mensagem( 'Obtendo dados (Recupera��o de Contas)...' );
    if cbPeriodo.ItemIndex = 0 then
      iPeriodo := 90
    else if cbPeriodo.ItemIndex = 1 then
      iPeriodo := 280
    else if cbPeriodo.ItemIndex = 2 then
      iPeriodo := 270
    else if cbPeriodo.ItemIndex = 3 then
      iPeriodo := 360
    else if cbPeriodo.ItemIndex = 4 then
      iPeriodo := 720
    else if cbPeriodo.ItemIndex = 5 then
    begin
      FDQueryAux.Close;
      FDQueryAux.Open;
      iPeriodo := FDQueryAuxMES.AsInteger;
    end;

    if cxCanal.Text <> '' then
      FDQueryVSOP_OrderBilling00.MacroByName( 'WHERE1' ).AsRaw := ' AND  TSOP_ORDBILCANNOM = ' + QuotedStr(cxCanal.Text);

    FDQueryVSOP_OrderBilling00.ParamByName( 'MESES' ).AsInteger := iPeriodo;

    if Fr_Brady.SalesRep then
      FDQueryVSOP_OrderBilling00.MacroByName( 'WHERE' ).AsRaw := 'AND TSOP_ORDBILREPNOM  =  ' + QuotedStr(Fr_Brady.TSIS_USUNOM);

    FDQueryVSOP_OrderBilling00.Open;

  finally

    Mensagem( EmptyStr );

  end;

end;

procedure TFr_RelatorioRecuperacaoContas.ButExcelClick(Sender: TObject);
var
   dxSpreadSheet: TdxSpreadSheet;
   I , X, Y, toFIM : Integer;
   varCor1,varCor2: TColor;
begin
  if cxButtonEditPath.Text = EmptyStr then
    raise Exception.Create('Informe o arquivo primeiro.');

  if (FDQueryVSOP_OrderBilling00.IsEmpty) then
       raise Exception.Create('N�o h� dados para serem exportados ao Excel');

  Mensagem( 'Iniciando processo de exporta��o...' );
  try

    Mensagem( 'Criando planilha...' );
    DeleteFile(PWideChar(MyDocumentsPath+'\Gerenciamento_Itens.xlsx'));
    CopyFile( PWideChar('\\ghos2024\Brady\Gerenciamento_Itens.xlsx'), PWideChar(MyDocumentsPath+'\Gerenciamento_Itens.xlsx'), True );

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    try
      toFIM := cxGridContasDBTableContas.ColumnCount;
       Y:= 0;
      for I := 0 to toFIM-1 do
      begin
        if cxGridContasDBTableContas.Columns[I].Visible then
        begin

           with dxSpreadSheet.ActiveSheetAsTable.CreateCell(0,Y) do;
           Inc(Y);
        end;
      end;

      varCor1 := RGB( 255, 255, 204 );
      varCor2 := RGB(255,255,225);

      Y := 0;
      for I := 0 to toFIM-1  do
      begin
        if cxGridContasDBTableContas.Columns[I].Visible then
        begin
          with dxSpreadSheet.ActiveSheetAsTable.CreateCell(0,Y) do
          begin
            Style.Brush.BackgroundColor := varCor1;
            AsString := cxGridContasDBTableContas.Columns[I].Caption;
            Inc(Y);
          end;
        end;
      end;
      FDQueryVSOP_OrderBilling00.First;
      FDQueryVSOP_OrderBilling00.DisableControls;

      X := 1;
      while not FDQueryVSOP_OrderBilling00.eof do
      begin


          Mensagem( 'Exportando linha (" ' + IntToStr(X) + '/' + IntToStr(FDQueryVSOP_OrderBilling00.RecordCount) + '")');

          if not Odd(X) then
            varCor1 := RGB(216,234,204)
          else
            varCor1 := RGB(255,255,225);
          Y := 0;
          for  I := 0 to toFIM-1  do
          begin
            if cxGridContasDBTableContas.Columns[I].Visible then
            begin
                with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,Y) do
                begin

                   Style.Brush.BackgroundColor := varCor1;
                   if cxGridContasDBTableContas.Columns[I].DataBinding.ValueType = 'SQLTimeStamp' then
                     AsVariant := FormatDateTime('dd-mm-yyyy', cxGridContasDBTableContas.Columns[I].DataBinding.Field.Value)
                   else
                     AsVariant := cxGridContasDBTableContas.Columns[I].DataBinding.Field.Value;

                   Inc(Y);
                end;
            end;
          end;




          Inc(X);
          FDQueryVSOP_OrderBilling00.Next;
      end;



      FDQueryVSOP_OrderBilling00.EnableControls;
      FDQueryVSOP_OrderBilling00.First;
      Mensagem( 'Salvando a planilha...' );
      dxSpreadSheet.SaveToFile( cxButtonEditPath.Text );

    finally
       FreeAndNil(dxSpreadSheet);
    end;

  finally
    Mensagem( EmptyStr );
  end;
end;

procedure TFr_RelatorioRecuperacaoContas.Mensagem(pMensagem: String);
begin
  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;
end;

procedure TFr_RelatorioRecuperacaoContas.cxButtonEditPathClick(Sender: TObject);
begin
  if SaveDialog.Execute(Handle) then
  begin
    cxButtonEditPath.Text := SaveDialog.FileName;
  end;
end;

procedure TFr_RelatorioRecuperacaoContas.cxButtonRefreshClick(Sender: TObject);
begin

  FDQueryVSOP_OrderBilling00.Close;
  AbrirDataset;

end;

procedure TFr_RelatorioRecuperacaoContas.cxGridContasDBTableContasCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  AValue, aURL : string;
begin

  if not (TcxGridDBColumn(ACellViewInfo.Item).DataBinding.FieldName = 'TSOP_ORDBILCLICOD') then
    Exit;

  if FDQueryVSOP_OrderBilling00TSOP_LINKSALESFORCE.AsString = '' then
     raise Exception.Create('N�o h� link cadastrado para este cliente.');

  if (ACellViewInfo.Item = cxGridContasDBTableContasTSOP_ORDBILCLICOD) and (AButton = mbLeft) then
  begin
    aURL := 'https://insidebrady.okta.com/home/salesforce/0oa1kietmbVQZCMLGIOU/46';
    AValue := FDQueryVSOP_OrderBilling00TSOP_LINKSALESFORCE.AsString;
    ShellExecute(0, 'OPEN', PChar(aURL), nil, nil, SW_SHOWMAXIMIZED);
    Sleep(4000);
    ShellExecute(0, 'OPEN', PChar(AValue), nil, nil, SW_SHOWMAXIMIZED);
  end;

end;

procedure TFr_RelatorioRecuperacaoContas.cxGridContasFocusedViewChanged(
  Sender: TcxCustomGrid; APrevFocusedView, AFocusedView: TcxCustomGridView);
begin
  try
    cxPageControlFiltro.Visible := AFocusedView = cxGridContasDBTableContas;
  except
  end;

end;

procedure TFr_RelatorioRecuperacaoContas.FDQueryVSOP_OrderBilling00BeforePost(
  DataSet: TDataSet);
var
 varOpcao : Integer;
begin
   if FDQueryVSOP_OrderBilling00.State in [dsEdit] then
   begin

    if ((FDQueryVSOP_OrderBilling00TSOP_SUSPEXCLUIDO.AsInteger = 2) and
       (FDQueryVSOP_OrderBilling00TSOP_MOTIVOEXCLUSAO.AsString = '')) then
       begin
           FDQueryVSOP_OrderBilling00.Cancel;
           raise Exception.Create('Informe primeiro o motivo da exclus�o do item.');
       end;
       varOpcao := FDQueryVSOP_OrderBilling00TSOP_SUSPEXCLUIDO.AsInteger;

       if varOpcao = 2 then
       begin
         if messagedlg('Deseja Realmente Excluir?',mtConfirmation,[mbyes,mbno],0) = mrno then
         begin
           FDQueryVSOP_OrderBilling00.Cancel;
           Exit;
         end;
       end;
  //     FDQueryVSOP_OrderBilling00TSOP_DTASUSPENSO.AsDateTime := Date;

       FDQueryAux2.Close;
       FDQueryAux2.SQL.clear;
       FDQueryAux2.SQL.Add('Update TSOP_OrderBilling ');
       FDQueryAux2.SQL.Add(' Set TSOP_SUSPEXCLUIDO = :TSOP_SUSPEXCLUIDO ');
       FDQueryAux2.SQL.Add(' ,TSOP_DTASUSPENSO = :TSOP_DTASUSPENSO ');
       FDQueryAux2.SQL.Add(' ,TSOP_MOTIVOEXCLUSAO = :TSOP_MOTIVOEXCLUSAO ');
       FDQueryAux2.SQL.Add('  Where TSOP_ORDBILCOD = :TSOP_ORDBILCOD');

       FDQueryAux2.Params.ParamByName('TSOP_SUSPEXCLUIDO').AsInteger   := varOpcao;
       FDQueryAux2.Params.ParamByName('TSOP_DTASUSPENSO').AsDateTime   := Date;
       FDQueryAux2.Params.ParamByName('TSOP_MOTIVOEXCLUSAO').AsString  := FDQueryVSOP_OrderBilling00TSOP_MOTIVOEXCLUSAO.AsString;
       FDQueryAux2.Params.ParamByName('TSOP_ORDBILCOD').AsInteger      := FDQueryVSOP_OrderBilling00TSOP_ORDBILCOD.AsInteger;

       Try
         FDQueryAux2.ExecSQL;
       except
          on E : Exception do
            begin
              MessageDlg( 'Erro ao Alterar Tabela TSOP_OrderBilling: ' + #13 + #13 +
                           E.Message, mtError, [ mbOk ], 0 );
            end;
       end;
   end;
end;

procedure TFr_RelatorioRecuperacaoContas.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  FDQueryVSOP_OrderBilling00.Close;
  FDConnection.Close;

  Fr_RelatorioRecuperacaoContas := nil;
  Action := caFree;

end;

procedure TFr_RelatorioRecuperacaoContas.FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin

  if cxPageControl.ActivePage = cxTabSheetGrid then
    Fr_Brady.PopupGridTools( cxGridContas.ActiveView );

end;

procedure TFr_RelatorioRecuperacaoContas.FormCreate(Sender: TObject);
var
  I: Integer;

begin

  LoadGridCustomization;
  cbPeriodo.ItemIndex := 0;
  cxCanal.ItemIndex := 0;




end;

procedure TFr_RelatorioRecuperacaoContas.LoadGridCustomization;
begin

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxGridContasDBTableContas.Name + '.ini' ) then
    cxGridContasDBTableContas.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxGridContasDBTableContas.Name + '.ini' );

end;


end.
