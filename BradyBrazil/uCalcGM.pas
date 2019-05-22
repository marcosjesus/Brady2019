unit uCalcGM;

interface

uses
  System.IOUtils,
  System.DateUtils,
  ShellAPI,
  dxSpreadSheet,
  dxSpreadSheetTypes,
  dxSpreadSheetCore,
  dxHashUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinOffice2013White, dxSkinscxPCPainter,
  dxBarBuiltInMenu, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, cxPC, cxContainer, cxEdit, cxTextEdit, cxLabel,
  cxMaskEdit, cxButtonEdit, cxGroupBox, cxRadioGroup, Vcl.Menus, Vcl.StdCtrls,
  cxButtons, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  dxGDIPlusClasses, Vcl.ExtCtrls, cxMemo, cxDropDownEdit,
  FireDAC.Comp.ScriptCommands, FireDAC.Comp.Script, Vcl.ImgList, Vcl.ComCtrls;

type
  TFr_CalcGM = class(TForm)
    cxPageControl1: TcxPageControl;
    cxTabSheetProcessar: TcxTabSheet;
    Shape2: TShape;
    Shape1: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    cxLabel5: TcxLabel;
    cxLabel7: TcxLabel;
    cxButtonProcessarBOM1: TcxButton;
    cxLabel8: TcxLabel;
    cxButtonProcessarBOM2: TcxButton;
    cxButtonProcessarITEM: TcxButton;
    cxButtonProcessarROUTING: TcxButton;
    cxButtonProcessarCUSTO: TcxButton;
    cxButtonProcessarUOM: TcxButton;
    cxLabel10: TcxLabel;
    cxButtonAtualizaBOM: TcxButton;
    cxButtonAtualizaBOM2: TcxButton;
    cxButtonAtualizaItem: TcxButton;
    cxButtonAtualizaRouting: TcxButton;
    cxButtonAtualizaCusto: TcxButton;
    cxButtonAtualizaUOM: TcxButton;
    cxButtonAtualizaOrdemMPR: TcxButton;
    cxButtonAtualizaMPR: TcxButton;
    cxLabel6: TcxLabel;
    cxButtonInicio: TcxButton;
    cxButtonInsertSQL: TcxButton;
    cxButtonVerBom1: TcxButton;
    cxButtonVerBom2: TcxButton;
    cxButtonVerItem: TcxButton;
    cxButtonVerRouting: TcxButton;
    cxButtonVerCusto: TcxButton;
    cxButtonVerUOM: TcxButton;
    cxLabel9: TcxLabel;
    cxButtonEditPath: TcxButtonEdit;
    cxButtonProcessar: TcxButton;
    SaveDialog: TSaveDialog;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    cxSmallImages: TcxImageList;
    FDQueryTSOP_GMHoras: TFDQuery;
    FDQueryTSOP_GMHorasTSOP_GMHCOD: TFDAutoIncField;
    FDQueryTSOP_GMHorasTSOP_GMHSIT: TStringField;
    FDQueryTSOP_GMHorasTSOP_GMHCCU: TStringField;
    FDQueryTSOP_GMHorasTSOP_GMHSUP: TBCDField;
    FDQueryTSOP_GMHorasTSOP_GMHMAQ: TBCDField;
    FDQueryTSOP_GMHorasTSOP_GMHLAB: TBCDField;
    FDQueryTSOP_GMHorasTSOP_GMHOVE: TBCDField;
    FDQueryTSOP_GMHorasTSOP_GMHDAT: TSQLTimeStampField;
    FDQueryTSOP_GMHorasTSOP_GMHBUD: TStringField;
    FDQueryGMHoras: TFDQuery;
    FDScriptInsert: TFDScript;
    Shape9: TShape;
    FDConnection: TFDConnection;
    FDScriptTMAQ_ItemBOM: TFDScript;
    FDScriptTMAQ_Item: TFDScript;
    FDScriptTSOP_GMCustos: TFDScript;
    FDScriptTMAQ_ItemRouting: TFDScript;
    FDScriptTSOP_UOM: TFDScript;
    FDQueryItemBom: TFDQuery;
    FDQueryItemBomTMAQ_ITEBOMCOD: TFDAutoIncField;
    FDQueryItemBomTMAQ_ITEBOMITECOD: TStringField;
    FDQueryItemBomTMAQ_ITEBOMSIT: TStringField;
    FDQueryItemBomTMAQ_ITEBOMITEMPRCOD: TStringField;
    FDQueryItemBomTMAQ_ITEBOMITEMTRTYP: TStringField;
    FDQueryItemBomTMAQ_ITEBOMITEMPRQTDBAS: TBCDField;
    FDQueryItemBomTMAQ_ITEBOMITEMPRFIX: TStringField;
    FDQueryItemBomTMAQ_ITEBOMITEMPRQTD: TBCDField;
    FDQueryItemBomTMAQ_ITEBOMITEMPRQTDREF: TBCDField;
    FDQueryItemBomTMAQ_ITEBOMITEMPRCOSREL: TStringField;
    FDQueryItemBomTMAQ_ITEBOMITEMPRBUK: TStringField;
    FDQueryItemBomTMAQ_ITEBOMITEMPRUOM: TStringField;
    FDQueryItemBomTMAQ_ITEBOMORDPRO: TStringField;
    FDQueryItemBomTMAQ_ITEBOMSALORD: TStringField;
    FDQueryItemBomTMAQ_ITEBOMSALORDITE: TIntegerField;
    FDQueryItemBomTMAQ_ITEBOMDAT: TSQLTimeStampField;
    FDQueryCusto: TFDQuery;
    FDQueryCustoTSOP_GMCCOD: TFDAutoIncField;
    FDQueryCustoTSOP_GMCITE: TStringField;
    FDQueryCustoTSOP_GMCSIT: TStringField;
    FDQueryCustoTSOP_GMCLOT: TBCDField;
    FDQueryCustoTSOP_GMCDAT: TSQLTimeStampField;
    FDQueryCustoTSOP_GMCCUSSTD: TBCDField;
    FDQueryCustoTSOP_GMCCUSMOV: TBCDField;
    FDQueryCustoTSOP_GMCPRIUNI: TBCDField;
    FDQueryCustoTSOP_GMCBUD: TStringField;
    FDQueryCustoTSOP_DTIMPORTACAO: TSQLTimeStampField;
    FDQueryRouting: TFDQuery;
    FDQueryRoutingTMAQ_ITEROUCOD: TFDAutoIncField;
    FDQueryRoutingTMAQ_ITEROUSIT: TStringField;
    FDQueryRoutingTMAQ_ITEROUITECOD: TStringField;
    FDQueryRoutingTMAQ_ITEROUDATINI: TSQLTimeStampField;
    FDQueryRoutingTMAQ_ITEROUWKCCOD: TStringField;
    FDQueryRoutingTMAQ_ITEROUCCU: TStringField;
    FDQueryRoutingTMAQ_ITEROUCTR: TStringField;
    FDQueryRoutingTMAQ_ITEROUOPE: TIntegerField;
    FDQueryRoutingTMAQ_ITEROUTXT: TStringField;
    FDQueryRoutingTMAQ_ITEROUQTDBAS: TBCDField;
    FDQueryRoutingTMAQ_ITEROUMINSEP: TBCDField;
    FDQueryRoutingTMAQ_ITEROUMINMAC: TBCDField;
    FDQueryRoutingTMAQ_ITEROUMINLAB: TBCDField;
    FDQueryRoutingTMAQ_ITEROUMINOVE: TBCDField;
    FDQueryRoutingTMAQ_ITEROUDAT: TSQLTimeStampField;
    procedure ImportarHoras;
    procedure ImportarPlanilhaAnterior;
    procedure cxButtonProcessarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButtonEditPathClick(Sender: TObject);
    procedure cxButtonInicioClick(Sender: TObject);
    procedure cxButtonVerBom1Click(Sender: TObject);
    procedure cxButtonProcessarBOM1Click(Sender: TObject);
    procedure cxButtonProcessarBOM2Click(Sender: TObject);
    procedure cxButtonProcessarITEMClick(Sender: TObject);
    procedure cxButtonProcessarROUTINGClick(Sender: TObject);
    procedure cxButtonProcessarCUSTOClick(Sender: TObject);
    procedure cxButtonProcessarUOMClick(Sender: TObject);
    procedure cxButtonAtualizaBOMClick(Sender: TObject);
    procedure cxButtonAtualizaBOM2Click(Sender: TObject);
    procedure cxButtonAtualizaItemClick(Sender: TObject);
    procedure cxButtonAtualizaOrdemMPRClick(Sender: TObject);
    procedure cxButtonAtualizaMPRClick(Sender: TObject);
    procedure cxButtonAtualizaRoutingClick(Sender: TObject);
    procedure cxButtonAtualizaCustoClick(Sender: TObject);
    procedure cxButtonAtualizaUOMClick(Sender: TObject);
    procedure cxButtonInsertSQLClick(Sender: TObject);
  private
    procedure Mensagem(pMensagem: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_CalcGM: TFr_CalcGM;

implementation

{$R *.dfm}

uses uBrady, uUtils, uDados;



procedure TFr_CalcGM.cxButtonAtualizaBOM2Click(Sender: TObject);
begin
 try
     Mensagem( 'Atualizando Bill of Material - Parte 2' );
     WinExec('\\GHOS2024\Brady\BradyDataImport.exe -eng_bom2', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonAtualizaBOM2.OptionsImage.ImageIndex := 39;
     cxButtonAtualizaItem.Enabled := True;
 end;
end;

procedure TFr_CalcGM.cxButtonAtualizaBOMClick(Sender: TObject);
begin
 try
     Mensagem( 'Atualizando Bill of Material - Parte 1' );
     WinExec('\\GHOS2024\Brady\BradyDataImport.exe -eng_bom', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonAtualizaBOM.OptionsImage.ImageIndex := 39;
     cxButtonAtualizaBOM2.Enabled := True;
 end;
end;

procedure TFr_CalcGM.cxButtonAtualizaCustoClick(Sender: TObject);
begin
  try
     Mensagem( 'Atualizando Custo' );
     WinExec('\\GHOS2024\Brady\BradyDataImport.exe -gm_custos', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonAtualizaCusto.OptionsImage.ImageIndex := 39;
     cxButtonAtualizaUOM.Enabled := True;
 end;
end;

procedure TFr_CalcGM.cxButtonAtualizaItemClick(Sender: TObject);
begin
 try
     Mensagem( 'Atualizando Item' );
     WinExec('\\GHOS2024\Brady\BradyDataImport.exe -eng_item', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonAtualizaItem.OptionsImage.ImageIndex := 39;
     cxButtonAtualizaOrdemMPR.Enabled := True;
 end;

end;

procedure TFr_CalcGM.cxButtonAtualizaMPRClick(Sender: TObject);
begin
 try
     Mensagem( 'Atualizando Ordem de Produ��o' );
     WinExec('\\GHOS2024\Brady\BradyDataImport.exe -eng_op', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonAtualizaMPR.OptionsImage.ImageIndex := 39;
     cxButtonAtualizaRouting.Enabled := True;
 end;
end;

procedure TFr_CalcGM.cxButtonAtualizaOrdemMPRClick(Sender: TObject);
begin
 try
     Mensagem( 'Atualizando Ordem de Produ��o MPR' );
     WinExec('\\GHOS2024\Brady\BradyDataImport.exe -eng_opmpr', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonAtualizaOrdemMPR.OptionsImage.ImageIndex := 39;
     cxButtonAtualizaMPR.Enabled := True;
 end;
end;

procedure TFr_CalcGM.cxButtonAtualizaRoutingClick(Sender: TObject);
begin
  try
     Mensagem( 'Atualizando Routing' );
     WinExec('\\GHOS2024\Brady\BradyDataImport.exe -eng_routing', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonAtualizaRouting.OptionsImage.ImageIndex := 39;
     cxButtonAtualizaCusto.Enabled := True;
 end;
end;

procedure TFr_CalcGM.cxButtonAtualizaUOMClick(Sender: TObject);
begin
   try
     Mensagem( 'Atualizando UOM' );
     WinExec('\\GHOS2024\Brady\BradyDataImport.exe -uom', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonAtualizaBOM.Enabled := False;
     cxButtonAtualizaBOM2.Enabled := False;
     cxButtonAtualizaItem.Enabled := False;
     cxButtonAtualizaRouting.Enabled := False;
     cxButtonAtualizaOrdemMPR.Enabled := False;
     cxButtonAtualizaMPR.Enabled := False;
     cxButtonAtualizaCusto.Enabled := False;
     cxButtonAtualizaUOM.Enabled := False;
     cxButtonInsertSQL.Enabled := True;
     cxButtonAtualizaUOM.OptionsImage.ImageIndex := 39;
 end;
end;

procedure TFr_CalcGM.cxButtonEditPathClick(Sender: TObject);
begin
  if SaveDialog.Execute(Handle) then
  begin
    cxButtonEditPath.Text := SaveDialog.FileName;
  end;
end;

procedure TFr_CalcGM.cxButtonInicioClick(Sender: TObject);
Var
  VarMesAnterior, varDataInicial, varDataFinal : TDateTime;
begin

  VarMesAnterior :=  StartOfTheMonth(Now)-1;
  varDataInicial := StartOfTheMonth(VarMesAnterior);
  varDataFinal := EndOfTheMonth(VarMesAnterior);
  FDQueryGMHoras.Close;
  FDQueryGMHoras.SQL.Clear;
  FDQueryGMHoras.SQL.Add('SELECT * FROM TSOP_GMHORAS  WHERE TSOP_GMHDAT BETWEEN ');
  FDQueryGMHoras.SQL.Add(' :V_BILLING_INI and :V_BILLING_FIM  ');
  FDQueryGMHoras.ParamByName( 'V_BILLING_INI' ).AsDateTime := varDataInicial;
  FDQueryGMHoras.ParamByName( 'V_BILLING_FIM' ).AsDateTime := varDataFinal;
  FDQueryGMHoras.Open;
  if FDQueryGMHoras.IsEmpty then
      raise Exception.Create('Taxas Horas n�o encontrada para o per�odo informado.');


  cxButtonInicio.OptionsImage.ImageIndex := 39;
  cxButtonProcessarBOM1.Enabled    := True;
  cxButtonProcessarROUTING.Enabled := True;
  cxButtonProcessarITEM.Enabled := True;
  cxButtonProcessarBOM2.Enabled := True;
  cxButtonProcessarUOM.Enabled := True;
  cxButtonProcessarCUSTO.Enabled := True;
end;

procedure TFr_CalcGM.cxButtonInsertSQLClick(Sender: TObject);
begin
  try
    Mensagem( 'Calculando Custo...' );
    FDScriptInsert.SQLScripts.Clear;
    FDScriptInsert.SQLScripts.Add.SQL.Add( 'EXEC dbo.PSOP_ProcessoGMCustos ' );
    FDScriptInsert.ExecuteAll;

    Mensagem( 'Calculo Finalizado.' );
  finally
    Mensagem( EmptyStr );
    cxButtonProcessarBOM1.Enabled    := False;
    cxButtonProcessarBOM2.Enabled    := False;
    cxButtonProcessarITEM.Enabled    := False;
    cxButtonProcessarROUTING.Enabled := False;
    cxButtonProcessarCUSTO.Enabled   := False;
    cxButtonProcessarUOM.Enabled := False;

    cxButtonAtualizaBOM.Enabled := False;
    cxButtonAtualizaBOM2.Enabled := False;
    cxButtonAtualizaItem.Enabled := False;
    cxButtonAtualizaRouting.Enabled := False;
    cxButtonAtualizaOrdemMPR.Enabled := False;
    cxButtonAtualizaMPR.Enabled := False;
    cxButtonAtualizaCusto.Enabled := False;
    cxButtonAtualizaUOM.Enabled := False;
    cxButtonInsertSQL.Enabled := False;

    cxButtonVerBom1.Enabled := False;
    cxButtonVerBom2.Enabled := False;
    cxButtonVerItem.Enabled := False;
    cxButtonVerRouting.Enabled := False;
    cxButtonVerCusto.Enabled := False;
    cxButtonVerUOM.Enabled := False;

    cxButtonProcessarBOM1.OptionsImage.ImageIndex    := 38;
    cxButtonProcessarBOM2.OptionsImage.ImageIndex    := 38;
    cxButtonProcessarITEM.OptionsImage.ImageIndex    := 38;
    cxButtonProcessarROUTING.OptionsImage.ImageIndex := 38;
    cxButtonProcessarCUSTO.OptionsImage.ImageIndex   := 38;
    cxButtonProcessarUOM.OptionsImage.ImageIndex     := 38;

    cxButtonAtualizaBOM.OptionsImage.ImageIndex      := 38;
    cxButtonAtualizaBOM2.OptionsImage.ImageIndex     := 38;
    cxButtonAtualizaItem.OptionsImage.ImageIndex     := 38;
    cxButtonAtualizaRouting.OptionsImage.ImageIndex  := 38;
    cxButtonAtualizaOrdemMPR.OptionsImage.ImageIndex := 38;
    cxButtonAtualizaMPR.OptionsImage.ImageIndex      := 38;
    cxButtonAtualizaCusto.OptionsImage.ImageIndex    := 38;
    cxButtonAtualizaUOM.OptionsImage.ImageIndex      := 38;

    cxButtonInsertSQL.OptionsImage.ImageIndex        := 38;
    cxButtonInicio.OptionsImage.ImageIndex := 38

  end;
end;

procedure TFr_CalcGM.cxButtonProcessarBOM1Click(Sender: TObject);
begin


 try
     Mensagem( 'Exportando do SAP -> Bill of Material - Parte 1' );
     WinExec('\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000448 BR-ENG-BOM BR-ENG-BOM \\ghos2024\Brady\Files\ENG\BR-ENG-BOM.TXT', 1);
 finally
    cxButtonProcessarBOM1.OptionsImage.ImageIndex := 39;
     Mensagem( EmptyStr );
     cxButtonVerBom1.Enabled := True;
 end;
end;

procedure TFr_CalcGM.cxButtonProcessarBOM2Click(Sender: TObject);
begin
 Try
   Mensagem( 'Exportando do SAP -> Bill of Material - Parte 2' );
   WinExec('\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000449 BR-ENG-BOM2 BR-ENG-BOM2 \\ghos2024\Brady\Files\ENG\BR-ENG-BOM2.TXT', 1);
 Finally
   Mensagem( EmptyStr );
   cxButtonProcessarBOM2.OptionsImage.ImageIndex := 39;
   cxButtonVerBom2.Enabled := True;
 End;
end;

procedure TFr_CalcGM.cxButtonProcessarClick(Sender: TObject);
begin

  if cxButtonEditPath.Text = EmptyStr then
    raise Exception.Create('Informe o arquivo primeiro.');

  ImportarHoras;
  //ImportarPlanilhaAnterior;
end;

procedure TFr_CalcGM.cxButtonProcessarCUSTOClick(Sender: TObject);
begin
 try
   Mensagem( 'Exportando do SAP -> Custo 2' );
   WinExec('\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000449 BR-GM-002 BR-GM-002 \\ghos2024\Brady\Files\ENG\BR-GM-001.TXT', 1);
 finally
   Mensagem( EmptyStr );
   cxButtonProcessarCUSTO.OptionsImage.ImageIndex := 39;

   cxButtonVerCusto.Enabled := true;
 end;
end;

procedure TFr_CalcGM.cxButtonProcessarITEMClick(Sender: TObject);
begin
 try
   Mensagem( 'Exportando do SAP -> Item' );
   WinExec('\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000448 BR-ENG-ITEM BR-ENG-ITEM \\ghos2024\Brady\Files\ENG\BR-ENG-ITEM.TXT', 1);
 finally
   Mensagem( EmptyStr );
   cxButtonProcessarITEM.OptionsImage.ImageIndex := 39;

   cxButtonVerItem.Enabled := True;
 end;
end;

procedure TFr_CalcGM.cxButtonProcessarROUTINGClick(Sender: TObject);
begin
 try
     Mensagem( 'Exportando do SAP -> Routing' );
     WinExec('\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000449 BR-ROUT-001 BR-ROUT-001 \\ghos2024\Brady\Files\ENG\BR-ENG-ROUTING.TXT', 1);
 finally
     Mensagem( EmptyStr );
     cxButtonProcessarROUTING.OptionsImage.ImageIndex := 39;

     cxButtonVerRouting.Enabled := True;
 end;
end;

procedure TFr_CalcGM.cxButtonProcessarUOMClick(Sender: TObject);
begin
 try
    Mensagem( 'Exportando do SAP -> UOM' );
    WinExec('\\GHOS2024\Brady\CielSapReadTable.exe Q 10.240.10.11 30 500 sondapwce U333Een3 SYSTQV000449 BR-UOM-001 BR-UOM-001 \\ghos2024\Brady\Files\ENG\BR-UOM-001.TXT', 1);
 finally
   cxButtonAtualizaBOM.Enabled      := True;
   cxButtonVerUOM.Enabled := True;
   cxButtonProcessarUOM.OptionsImage.ImageIndex := 39;
   Mensagem( EmptyStr );
 end;
end;

procedure TFr_CalcGM.cxButtonVerBom1Click(Sender: TObject);
begin
   if FileExists(TButton(Sender).Hint) then
     ShellExecute(Handle,'open', 'c:\windows\notepad.exe', pChar( TButton(Sender).Hint ), nil, SW_SHOWNORMAL)
   else   raise Exception.Create(' Arquivo ' + pChar( TButton(Sender).Hint ) + ' n�o encontrado.');

end;

procedure TFr_CalcGM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Fr_CalcGM := nil;
  Action := caFree;

end;



procedure TFr_CalcGM.ImportarHoras;
var
  I, X: Integer;
  dxSpreadSheet: TdxSpreadSheet;
  varMes, varAno: Integer;
  varData: TDateTime;
  varPlanta, varBudget, varCentro: String;
  varSetup, varMachine, varLabor, varOverhead: Extended;

begin

  Mensagem( 'Iniciando processo de importa��o...' );
  try

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    try

      Mensagem( 'Carregando planilha...' );
      dxSpreadSheet.LoadFromFile( cxButtonEditPath.Text );
      dxSpreadSheet.BeginUpdate;

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );

      Mensagem( 'Abrindo Conex�o...' );
      FDConnection.Open;
      try

        FDQueryTSOP_GMHoras.Open;
        try

          Mensagem( 'Lendo linhas da planilha...' );
          for X := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
          begin

            try

              if dxSpreadSheet.ActiveSheetAsTable.Rows[X].CellCount = 0 then
                Continue;

              if dxSpreadSheet.ActiveSheetAsTable.Rows[X].CellCount < 9 then
                Continue;

              Mensagem( 'Linha (" ' + IntToStr(X) + '/' + IntToStr(dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex) + '") "' + Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsString) + '" ...' );

              if Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString) = EmptyStr then
                Continue;

            except

              Continue;

            end;

            varAno := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsInteger;
            varMes := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[1].AsInteger;
            varData := EncodeDate( varAno, varMes, 01 );
            varBudget := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsString;
            varPlanta := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[3].AsString;
            varCentro := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[4].AsString;
            varSetup := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[5].AsFloat;
            varMachine := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6].AsFloat;
            varLabor := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[7].AsFloat;
            varOverhead := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[8].AsFloat;

            if FDQueryTSOP_GMHoras.Locate( 'TSOP_GMHDAT;TSOP_GMHBUD;TSOP_GMHSIT;TSOP_GMHCCU', VarArrayOf( [varData,varBudget,varPlanta,varCentro] ) ) then
            begin

              if (varSetup+varMachine+varLabor+varOverhead) > 0.00 then
              begin

                FDQueryTSOP_GMHoras.Edit;
                FDQueryTSOP_GMHorasTSOP_GMHSUP.AsFloat := varSetup;
                FDQueryTSOP_GMHorasTSOP_GMHMAQ.AsFloat := varMachine;
                FDQueryTSOP_GMHorasTSOP_GMHLAB.AsFloat := varLabor;
                FDQueryTSOP_GMHorasTSOP_GMHOVE.AsFloat := varOverhead;

                try
                  FDQueryTSOP_GMHoras.Post;
                except
                  FDQueryTSOP_GMHoras.Cancel;
                end;

              end
              else
              begin

                try
                  FDQueryTSOP_GMHoras.Delete;
                except
                end;

              end;

            end
            else
            begin

              if (varSetup+varMachine+varLabor+varOverhead) > 0.00 then
              begin

                FDQueryTSOP_GMHoras.Append;

                FDQueryTSOP_GMHorasTSOP_GMHSIT.AsString := varPlanta;
                FDQueryTSOP_GMHorasTSOP_GMHBUD.AsString := varBudget;
                FDQueryTSOP_GMHorasTSOP_GMHCCU.AsString := varCentro;
                FDQueryTSOP_GMHorasTSOP_GMHDAT.AsDateTime := varData;

                FDQueryTSOP_GMHorasTSOP_GMHSUP.AsFloat := varSetup;
                FDQueryTSOP_GMHorasTSOP_GMHMAQ.AsFloat := varMachine;
                FDQueryTSOP_GMHorasTSOP_GMHLAB.AsFloat := varLabor;
                FDQueryTSOP_GMHorasTSOP_GMHOVE.AsFloat := varOverhead;

                try
                  FDQueryTSOP_GMHoras.Post;
                except
                  FDQueryTSOP_GMHoras.Cancel;
                end;

              end;

            end;

            Application.ProcessMessages;

          end;

        finally

          FDQueryTSOP_GMHoras.Close;

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

procedure TFr_CalcGM.ImportarPlanilhaAnterior;
var
  I, X: Integer;
  dxSpreadSheet: TdxSpreadSheet;
  varMes, varAno: Integer;
  var_ITEBOMITECOD    : String;
  var_ITESIT          : String;
  var_ITEBOMITEMPRCOD : String;
  var_ITEBOMITEMPRFIX : String;
  var_ITEBOMITEMPRQTD : Double;
  var_ITEBOMORDPRO    : String;
  var_ITEBOMDAT       : TDateTime;


begin
  Mensagem( 'Iniciando processo de importa��o...' );
  try

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    try

      Mensagem( 'Carregando planilha...' );
      dxSpreadSheet.LoadFromFile( cxButtonEditPath.Text );
      dxSpreadSheet.BeginUpdate;

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );

      Mensagem( 'Abrindo Conex�o...' );
      FDConnection.Open;
      try

        FDQueryItemBom.Open;
        try
          dxSpreadSheet.Sheets[1].Active := True;

          Mensagem( 'Lendo linhas da planilha...' );
          for X := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
          begin

            try

              if dxSpreadSheet.ActiveSheetAsTable.Rows[X].CellCount = 0 then
                Continue;

              if dxSpreadSheet.ActiveSheetAsTable.Rows[X].CellCount < 11 then
                Continue;

              Mensagem( 'Linha (" ' + IntToStr(X) + '/' + IntToStr(dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex) + '") "' + Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsString) + '" ...' );

              if Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString) = EmptyStr then
                Continue;

            except

              Continue;

            end;

            var_ITEBOMITECOD    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[1].AsString;
            var_ITESIT          := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString;
            var_ITEBOMITEMPRCOD := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[3].AsString;
            var_ITEBOMITEMPRFIX := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6].AsString;
            var_ITEBOMITEMPRQTD := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[8].AsFloat;
           // var_ITEBOMORDPRO    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[10].AsString;
           // var_ITEBOMDAT       := DateTimeImportacao.Date;

            FDQueryItemBom.Append;
            FDQueryItemBomTMAQ_ITEBOMITECOD.AsString    := var_ITEBOMITECOD;
            FDQueryItemBomTMAQ_ITEBOMSIT.AsString       := var_ITESIT;
            FDQueryItemBomTMAQ_ITEBOMITEMPRCOD.AsString := var_ITEBOMITEMPRCOD;
            FDQueryItemBomTMAQ_ITEBOMITEMPRFIX.AsString := var_ITEBOMITEMPRFIX;

            FDQueryItemBomTMAQ_ITEBOMITEMPRQTD.AsFloat  := var_ITEBOMITEMPRQTD;
           // FDQueryItemBomTMAQ_ITEBOMORDPRO.AsString    := var_ITEBOMORDPRO;
            FDQueryItemBomTMAQ_ITEBOMDAT.asDateTime     := var_ITEBOMDAT;

            try
               FDQueryItemBom.Post;
            except
               FDQueryItemBom.Cancel;
            end;

        end;

        finally
            FDQueryItemBom.Close;
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

procedure TFr_CalcGM.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

end.