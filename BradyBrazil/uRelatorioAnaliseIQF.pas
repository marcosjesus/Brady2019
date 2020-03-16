unit uRelatorioAnaliseIQF;

interface

uses
  dxCoreClasses,
  System.DateUtils,
  System.Math,
  cxCurrencyEdit,
  System.IOUtils,
  dxSpreadSheet,
  dxSpreadSheetTypes,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxImageComboBox,
  cxContainer, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  cxClasses, Vcl.ImgList, FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxLabel, dxGDIPlusClasses, Vcl.ExtCtrls, cxGridLevel,
  cxGridChartView, cxGridDBChartView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid,
  dxSkinOffice2013White, dxBarBuiltInMenu, cxPC, cxCustomPivotGrid, cxDBPivotGrid, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.StdCtrls, Vcl.Buttons, Vcl.Menus, cxButtons,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxColorComboBox,
  cxGridBandedTableView, cxGridDBBandedTableView, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue,cxGridExportLink, cxExportPivotGridLink,
  FireDAC.Comp.ScriptCommands, FireDAC.Comp.Script, cxCheckBox,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs,
  VCLTee.Chart, VCLTee.DBChart, cxButtonEdit;

type
  TFr_RelatorioAnaliseIQF = class(TForm)
    cxPageControl: TcxPageControl;
    cxTabSheetGrid: TcxTabSheet;
    DataSourceTIQF_Dados: TDataSource;
    FDConnection: TFDConnection;
    FDQueryTIQF_Dados: TFDQuery;
    cxSmallImages: TcxImageList;
    cxStyleRepository: TcxStyleRepository;
    cxStyleInsatisfatorio: TcxStyle;
    cxStyleCondicional: TcxStyle;
    cxStyleSatisfatorio: TcxStyle;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    StyleRepository: TcxStyleRepository;
    styleActiveGroup: TcxStyle;
    cxPageControlFiltro: TcxPageControl;
    cxTabSheetFiltro: TcxTabSheet;
    cxLabelDataInicial: TcxLabel;
    cxButtonRefresh: TcxButton;
    DataSourceTIQF_Periodo: TDataSource;
    FDQueryTIQF_Periodo: TFDQuery;
    FDQueryTIQF_PeriodoTIQF_PERCOD: TFDAutoIncField;
    FDQueryTIQF_PeriodoTIQF_PERNOM: TStringField;
    FDQueryTIQF_PeriodoTIQF_PERDAT: TSQLTimeStampField;
    cxLookupComboBoxPeriodo: TcxLookupComboBox;
    FDQueryTIQF_DadosTIQF_DADCOD: TFDAutoIncField;
    FDQueryTIQF_DadosTIQF_PERNOM: TStringField;
    FDQueryTIQF_DadosTIQF_FORSAP: TStringField;
    FDQueryTIQF_DadosTIQF_FORNOM: TStringField;
    FDQueryTIQF_DadosTIQF_DADQTDENT: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADQTDATR: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADPERIQFMES: TBCDField;
    cxTabSheetPivot00: TcxTabSheet;
    cxDBPivotGrid00: TcxDBPivotGrid;
    cxDBPivotGrid00FieldTIQF_FORNOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTIQF_PERNOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTIQF_DADPERIQFMES: TcxDBPivotGridField;
    cxTabSheetGrafico: TcxTabSheet;
    FDQueryTIQF_DadosTIQF_DADQN: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADNFEXML: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADNFENFP: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADNFEVCT: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADNFEDEI: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADDOCMANUAL: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADDOCCER: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADDOCSUPA: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADDOCBALP: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADDPO3045: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADDPO4660: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADDPO6190: TIntegerField;
    FDQueryTIQF_DadosTIQF_CATEGORIA: TStringField;
    cxPageControlGrid: TcxPageControl;
    tabGrid: TcxTabSheet;
    tabDetalhe: TcxTabSheet;
    cxGridTMAQ_Apontamento01: TcxGrid;
    cxTableViewTMAQ_Apontamento01: TcxGridDBBandedTableView;
    cxTableViewTMAQ_Apontamento01TIQF_DADCOD: TcxGridDBBandedColumn;
    cxTableViewTMAQ_Apontamento01TIQF_PERNOM: TcxGridDBBandedColumn;
    cxTableViewTMAQ_Apontamento01TIQF_FORSAP: TcxGridDBBandedColumn;
    cxTableViewTMAQ_Apontamento01TIQF_FORNOM: TcxGridDBBandedColumn;
    cxTableViewTMAQ_Apontamento01TIQF_DADQTDENT: TcxGridDBBandedColumn;
    cxTableViewTMAQ_Apontamento01TIQF_DADQTDATR: TcxGridDBBandedColumn;
    cxTableViewTMAQ_Apontamento01TIQF_DADQN: TcxGridDBBandedColumn;
    cxTableViewTMAQ_Apontamento01TIQF_DADNFEXML: TcxGridDBBandedColumn;
    cxTableViewTMAQ_Apontamento01TIQF_DADNFENFP: TcxGridDBBandedColumn;
    cxTableViewTMAQ_Apontamento01TIQF_DADNFEVCT: TcxGridDBBandedColumn;
    cxTableViewTMAQ_Apontamento01TIQF_DADNFEDEI: TcxGridDBBandedColumn;
    cxGridLevelTMAQ_Apontamento01: TcxGridLevel;
    cxGrid_DetalheDBTableView1: TcxGridDBTableView;
    cxGrid_DetalheLevel1: TcxGridLevel;
    cxGrid_Detalhe: TcxGrid;
    FDQueryTIQF_DadosDetalhe: TFDQuery;
    DataSourceTIQF_DadosDetalhe: TDataSource;
    cxTableViewTMAQ_Apontamento01TIQF_CATEGORIA: TcxGridDBBandedColumn;
    cxGrid_DetalheDBTableView1TIQF_FORSAP: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_FORNOM: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_FORCER: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_FORDOCMANUAL: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_FORDOCSUPA: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_FORDOCBALP: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_PARENTPRA: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_PARQN: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_PARNFEXML: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_PARNFENFP: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_PARNFEVCT: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_PARNFEDEI: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_DADPERIQFMES: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_DADPERIQFACU: TcxGridDBColumn;
    FDQueryTIQF_DadosDetalheTIQF_DADCOD: TFDAutoIncField;
    FDQueryTIQF_DadosDetalheTIQF_FORSAP: TStringField;
    FDQueryTIQF_DadosDetalheTIQF_FORNOM: TStringField;
    FDQueryTIQF_DadosDetalhetiqf_categoria: TStringField;
    FDQueryTIQF_DadosDetalheTIQF_FORCER: TFMTBCDField;
    FDQueryTIQF_DadosDetalheTIQF_FORDOCMANUAL: TFMTBCDField;
    FDQueryTIQF_DadosDetalheTIQF_FORDOCSUPA: TFMTBCDField;
    FDQueryTIQF_DadosDetalheTIQF_FORDOCBALP: TFMTBCDField;
    FDQueryTIQF_DadosDetalheTIQF_PARDOP3045: TFMTBCDField;
    FDQueryTIQF_DadosDetalheTIQF_PARDOP466: TFMTBCDField;
    FDQueryTIQF_DadosDetalheTIQF_PARDOP6190: TFMTBCDField;
    FDQueryTIQF_DadosDetalheTIQF_PARENTPRA: TFMTBCDField;
    FDQueryTIQF_DadosDetalheTIQF_PARQN: TFMTBCDField;
    FDQueryTIQF_DadosDetalheTIQF_PARNFEXML: TFMTBCDField;
    FDQueryTIQF_DadosDetalheTIQF_PARNFENFP: TFMTBCDField;
    FDQueryTIQF_DadosDetalheTIQF_PARNFEVCT: TFMTBCDField;
    FDQueryTIQF_DadosDetalheTIQF_PARNFEDEI: TFMTBCDField;
    FDQueryTIQF_DadosDetalheTIQF_DADPERIQFMES: TBCDField;
    FDQueryTIQF_DadosDetalheTIQF_DADPERIQFACU: TBCDField;
    FDQueryTIQF_DadosDetalheTIQF_PARDOP0029: TFMTBCDField;
    cxGrid_DetalheDBTableView1tiqf_categoria: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_PARDOP0029: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_PARDOP3045: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_PARDOP466: TcxGridDBColumn;
    cxGrid_DetalheDBTableView1TIQF_PARDOP6190: TcxGridDBColumn;
    ButExcel: TcxButton;
    SaveDialog: TSaveDialog;
    FDScriptCalcIQF: TFDScript;
    FDQueryTIQF_DadosTIQF_DADPERIQFACU: TBCDField;
    cxDBPivotGrid00FieldTIQF_CATEGORIA: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTIQF_CLASSIFICACAO: TcxDBPivotGridField;
    FDQueryTIQF_DadosTIQF_CLASSIFICACAO: TStringField;
    FDQueryAnaliseMensal: TFDQuery;
    DataSourceAnaliseMensal: TDataSource;
    cxGridIQF: TcxGrid;
    cxGridLevelIQF: TcxGridLevel;
    cxGridIQFDBBandedTableView: TcxGridDBBandedTableView;
    FDQueryTIQF_DadosTIQF_PERDAT: TSQLTimeStampField;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxGridTMAQ_ApontamentoGrafico01: TcxGrid;
    cxTableViewTMAQ_ApontamentoGrafico01: TcxGridDBChartView;
    cxTableViewTMAQ_ApontamentoGrafico01DataGroup1: TcxGridDBChartDataGroup;
    cxTableViewTMAQ_ApontamentoGrafico01DataGroup2: TcxGridDBChartDataGroup;
    cxTableViewTMAQ_ApontamentoGrafico01Series1: TcxGridDBChartSeries;
    cxTableViewTMAQ_ApontamentoGrafico01Series2: TcxGridDBChartSeries;
    cxGridLevelTMAQ_ApontamentoGrafico01: TcxGridLevel;
    cxTabSheet2: TcxTabSheet;
    cxGridTMAQ_Apontamento02: TcxGrid;
    cxGridDBChartView1: TcxGridDBChartView;
    cxGridDBChartDataGroup3: TcxGridDBChartDataGroup;
    cxGridDBChartSeries1: TcxGridDBChartSeries;
    cxGridDBChartSeries2: TcxGridDBChartSeries;
    cxGridTMAQ_ApontamentoGrafico02: TcxGridLevel;
    cxLabel2: TcxLabel;
    cxButtonEditPath: TcxButtonEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cxButtonRefreshClick(Sender: TObject);
    procedure cxTableViewTMAQ_Apontamento01TIQF_DADPERIQFMESCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxTableViewTMAQ_Apontamento01TIQF_DADPERIQFACUCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxPageControlGridChange(Sender: TObject);
    procedure ButExcelClick(Sender: TObject);
    procedure cxTableViewTMAQ_ApontamentoGrafico01CategoriesGetValueDisplayText(
      Sender: TObject; const AValue: Variant; var ADisplayText: string);
    procedure cxGridDBChartView1CategoriesGetValueDisplayText(Sender: TObject;
      const AValue: Variant; var ADisplayText: string);

    procedure cxGridIQFDBBandedTableViewMEDIAPERIODOStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxGridIQFDBBandedTableViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxTableViewTMAQ_ApontamentoGrafico01Series1StylesGetValueStyle(
      Sender: TcxGridChartSeries; AValueIndex: Integer; var AStyle: TcxStyle);
    procedure cxTableViewTMAQ_ApontamentoGrafico01DiagramColumnCustomDrawValue(
      Sender: TcxGridChartDiagram; ACanvas: TcxCanvas;
      AViewInfo: TcxGridChartDiagramValueViewInfo; var ADone: Boolean);
    procedure cxButtonEditPathClick(Sender: TObject);
  private
    dxSpreadSheet : TdxSpreadSheet;
    varMesesComLabel,  varMesesComLabelB, varMesesComLabelF, varMesesSemLabelB, varMesesSemLabelF, varMesesSomaLinha : WideString;
    varDtInicial, varDtFinal : TDateTime;
    varMesesArrayB, varMesesArrayF : Array of TDateTime;
    ABand  : TcxGridBand;

    procedure Mensagem( pMensagem: String );
    procedure AnaliseMensal;
    function MontaStringMes(bMostraLabel: Boolean; Alias, Tipo: String;
      SomarL: Boolean): WideString;
    function BuscaMes(Data: TDateTime; bLabel: Boolean; Alias: String;
      SomarLinha: Boolean): String;
    procedure AddColumn;
    procedure Exportar_AnalisaMensal;
    { Private declarations }
  public
    procedure AbrirDataset;
    procedure LoadGridCustomization;
    { Public declarations }
  end;

var
  Fr_RelatorioAnaliseIQF: TFr_RelatorioAnaliseIQF;

implementation

{$R *.dfm}

uses uBrady, uUtils;

procedure TFr_RelatorioAnaliseIQF.AbrirDataset;
begin

  Mensagem( 'Abrindo conex�o...' );
  try

    FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
    FDConnection.Open;

    FDQueryTIQF_Periodo.Open;



  finally

    Mensagem( EmptyStr );

  end;

end;

procedure TFr_RelatorioAnaliseIQF.ButExcelClick(Sender: TObject);
begin
  if cxPageControl.ActivePageIndex = 0 then
  begin
     if cxPageControlGrid.ActivePage = tabGrid then
     begin

        if FDQueryTIQF_Dados.IsEmpty then
            raise Exception.Create('N�o h� dados para serem exportados ao Excel');

        SaveDialog.InitialDir := GetCurrentDir;
        Try
           Try
             if SaveDialog.Execute then
              ExportGridToXLSX(SaveDialog.FileName, cxGridTMAQ_Apontamento01, True, True);
          except
             on E: Exception do
                  begin
                     raise Exception.Create(E.Message);
                  end;
           End;
        Finally
             Application.MessageBox( 'Arquivo salvo com sucesso!!!', 'S&OP', MB_ICONINFORMATION );
        End;
     end
     else if cxPageControlGrid.ActivePage = tabDetalhe then
          begin

            if FDQueryTIQF_DadosDetalhe.IsEmpty then
                raise Exception.Create('N�o h� dados para serem exportados ao Excel');

            SaveDialog.InitialDir := GetCurrentDir;
            Try
              try
              if SaveDialog.Execute then
                ExportGridToXLSX(SaveDialog.FileName, cxGrid_Detalhe, True, True);
              except
                   on E: Exception do
                      begin
                         raise Exception.Create(E.Message);
                      end;
              end;
            Finally
                Application.MessageBox( 'Arquivo salvo com sucesso!!!', 'S&OP', MB_ICONINFORMATION );
            End;
          end;
  end
  else if cxPageControl.ActivePageIndex = 1 then
  begin
      if cxButtonEditPath.Text = EmptyStr then
        raise Exception.Create('Informe o arquivo primeiro.');

      if FDQueryAnaliseMensal.IsEmpty then
         raise Exception.Create('N�o h� dados para serem exportados ao Excel');

     // SaveDialog.InitialDir := GetCurrentDir;
      Exportar_AnalisaMensal;
      {
      Try
        try
        if SaveDialog.Execute then
        begin
           ExportGridToXLSX(SaveDialog.FileName, cxGridIQF, True, True);
           MessageDlg( pChar( 'Planilha exportada em  ' + ExtractFilePath(SaveDialog.FileName) )  , mtInformation, [ mbOk ], 0 );
        end;
        except
             on E: Exception do
                begin
                   raise Exception.Create(E.Message);
                end;
        end;
      Finally
          Application.MessageBox( 'Arquivo salvo com sucesso!!!', 'S&OP', MB_ICONINFORMATION );
      End;
      }
  end;

end;


procedure TFr_RelatorioAnaliseIQF.Exportar_AnalisaMensal;
var
  I, X : Integer;
  varCor1,varCor2: TColor;
begin

   Screen.Cursor := crHourGlass;
   DeleteFile(PWideChar(MyDocumentsPath+'\Analise_Mensal_IQF.xlsx'));
   CopyFile( PWideChar('\\ghos2024\Brady\Analise_Mensal_IQF.xlsx'), PWideChar(MyDocumentsPath+'\Analise_Mensal_IQF.xlsx'), True );

   Try
       Mensagem( 'Criando Planilha...' );
       dxSpreadSheet := TdxSpreadSheet.Create(nil);
       try
           Mensagem( 'Exportando Grid Analise Mensal IQF...' );
           dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\Analise_Mensal_IQF.xlsx' );
           dxSpreadSheet.BeginUpdate;

           dxSpreadSheet.Sheets[0].Active := True;

           for I := 0 to 12 do
           begin

             with dxSpreadSheet.ActiveSheetAsTable.CreateCell(0,I) do
             begin
                 Style.Brush.BackgroundColor :=  RGB(255,255,225);
                 AsVariant := cxGridIQFDBBandedTableView.Columns[i].Caption;
             end;

           end;

           FDQueryAnaliseMensal.First;
           varCor1 := RGB( 255, 255, 204 );
           varCor2 := RGB(255,255,225);

           X := 1;
           while not FDQueryAnaliseMensal.eof do
           begin

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryAnaliseMensal.Fields.Fields[0].AsString; // Fornecedor
               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryAnaliseMensal.Fields.Fields[1].AsString;   // Cod Fornecedor
               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,2) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryAnaliseMensal.Fields.Fields[2].AsString;   // Categoria
               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,3) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryAnaliseMensal.Fields.Fields[3].AsString;   // Classificacao

               end;

               for I := 4 to 9 do
                 begin
                   with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,I) do
                   begin
                       Style.Brush.BackgroundColor := varCor1;
                       Style.DataFormat.FormatCode := '#,##0.00';
                       AsVariant := FDQueryAnaliseMensal.Fields.Fields[I].AsString;   // Meses

                   end;

                 end;


               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,10) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   Style.DataFormat.FormatCode := '#,##0.00';
                   AsVariant :=  FDQueryAnaliseMensal.Fields.Fields[10].AsString;  // Total Periodo

               end;


               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,11) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   Style.DataFormat.FormatCode := '#,##0.00';
                   AsVariant :=  FDQueryAnaliseMensal.Fields.Fields[11].AsString;  // Media Periodo

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,12) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   Style.DataFormat.FormatCode := '#,##0.00';
                   AsVariant := FDQueryAnaliseMensal.Fields.Fields[16].AsString;  // Meta

               end;
                 {
               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,7) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryVSOP_OrderBilling00Regi�o.AsString;

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,8) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryVSOP_OrderBilling00UF.AsString;

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,9) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   AsVariant := FDQueryVSOP_OrderBilling00UoM.AsString;

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,10) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   Style.DataFormat.FormatCode:='dd-mm-yyyy';
                   AsVariant := FDQueryVSOP_OrderBilling00Periodo.AsString

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,11) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                    Style.DataFormat.FormatCode := '#,###,###';
                   AsVariant := FDQueryVSOP_OrderBilling00TOTAL_VENDAS_QTD.AsFloat;

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,12) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   Style.DataFormat.FormatCode := '#,###,###';
                   AsVariant := FDQueryVSOP_OrderBilling00NET_SALE.AsFloat;

               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,13) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   Style.DataFormat.FormatCode := '#,##0.00';
                   AsVariant := FDQueryVSOP_OrderBilling00GM_VALOR.AsFloat;
               end;

               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,14) do
               begin
                   Style.Brush.BackgroundColor := varCor1;
                   Style.DataFormat.FormatCode := '#,##0.00';
                   AsVariant := FDQueryVSOP_OrderBilling00GM_PERCENTUAL.AsFloat;
               end;
               }

               if Odd(X) then
                varCor1 := RGB(255,255,225)
               else
                varCor1 := RGB(216,234,204);

               Inc(X);

               FDQueryAnaliseMensal.Next;
           end;

           dxSpreadSheet.BeginUpdate;
           dxSpreadSheet.SaveToFile( cxButtonEditPath.Text );
           MessageDlg( pChar( 'Planilha exportada em  ' + ExtractFilePath(SaveDialog.FileName) )  , mtInformation, [ mbOk ], 0 );

       finally
          FreeAndNil(dxSpreadSheet);
       end;
   Finally
          Mensagem( EmptyStr );
          Screen.Cursor := crDefault;
   End;
end;



procedure TFr_RelatorioAnaliseIQF.cxButtonEditPathClick(Sender: TObject);
begin
  if SaveDialog.Execute(Handle) then
  begin
    cxButtonEditPath.Text := SaveDialog.FileName;
  end;
end;

procedure TFr_RelatorioAnaliseIQF.cxButtonRefreshClick(Sender: TObject);
begin
    FDQueryTIQF_DadosDetalhe.Close;
    FDQueryTIQF_Dados.Close;

    Mensagem( 'Obtendo dados (01 - IQF)...' );
    FDQueryTIQF_Dados.Close;


    FDQueryTIQF_Dados.ParamByName( 'TIQF_PERCOD' ).AsInteger := FDQueryTIQF_PeriodoTIQF_PERCOD.AsInteger;
    FDQueryTIQF_Dados.Open;
     {
    FDQueryTIQF_DadosDetalhe.Close;
    FDQueryTIQF_DadosDetalhe.Open;
      }
    AnaliseMensal;

    Mensagem( EmptyStr );

end;

procedure TFr_RelatorioAnaliseIQF.AnaliseMensal;
var
   varDataReferencia: TDateTime;
   varCurrentMonth: Integer;

begin
   cxGridIQFDBBandedTableView.ClearItems;
   if ABand <> Nil then
   begin
       ABand.Bands.Clear;
   end;

  Mensagem( 'Abrindo conex�o...' );
  try

    if not FDConnection.Connected then
    begin

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

    end;

    Mensagem( 'Obtendo dados (IQF)...' );

    varMesesComLabel  := MontaStringMes(True,'','B',False);
    varMesesComLabel  := Copy(varMesesComLabel, 1, Length(varMesesComLabel)-1);

    varMesesSemLabelB  := MontaStringMes(False,'','B',False);
    varMesesSemLabelB  := Copy(varMesesSemLabelB, 1, Length(varMesesSemLabelB)-1);


    FDQueryAnaliseMensal.Close;
    FDQueryAnaliseMensal.SQL.Clear;


    FDQueryAnaliseMensal.SQL.Add('with dados ');
    FDQueryAnaliseMensal.SQL.Add('as ( ');

    FDQueryAnaliseMensal.SQL.Add('SELECT  ');
    FDQueryAnaliseMensal.SQL.Add('TIQF_FORNOM  as Fornecedor, TIQF_FORSAP as Codigo , TIQF_CATEGORIA as Categoria , TIQF_CLASSIFICACAO as Classificacao ,  ');
    FDQueryAnaliseMensal.SQL.Add(varMesesComLabel);
    FDQueryAnaliseMensal.SQL.Add(',[TOTAL PERIODO],[MEDIA PERIODO]  ');
    FDQueryAnaliseMensal.SQL.Add('FROM   ');
    FDQueryAnaliseMensal.SQL.Add('(    ');
    FDQueryAnaliseMensal.SQL.Add('   SELECT D.TIQF_FORCOD, F.TIQF_FORNOM, F.TIQF_FORSAP, F.TIQF_CATEGORIA ,F.TIQF_CLASSIFICACAO,  ');
    FDQueryAnaliseMensal.SQL.Add('   CONVERT(CHAR(4), P.TIQF_PERDAT, 100) + CONVERT(CHAR(4), P.TIQF_PERDAT, 120) AS MES ,  ');
    FDQueryAnaliseMensal.SQL.Add('   COALESCE(TIQF_DADPERIQFMES,0) TIQF_DADPERIQFMES  ');
    FDQueryAnaliseMensal.SQL.Add('   FROM TIQF_DADOS D   ');
    FDQueryAnaliseMensal.SQL.Add('   INNER JOIN TIQF_PERIODO P ON P.TIQF_PERCOD = D.TIQF_PERCOD  ');
    FDQueryAnaliseMensal.SQL.Add('   INNER JOIN TIQF_FORNECEDOR F ON F.TIQF_FORCOD = D.TIQF_FORCOD  ');
    FDQueryAnaliseMensal.SQL.Add('      WHERE P.TIQF_PERCOD >= :PERCOD_INI AND P.TIQF_PERCOD  <= :PERCOD_FIM   ');

    FDQueryAnaliseMensal.SQL.Add(') SQ  ');
    FDQueryAnaliseMensal.SQL.Add('  PIVOT   ');
    FDQueryAnaliseMensal.SQL.Add('  (   ');
    FDQueryAnaliseMensal.SQL.Add('   SUM(TIQF_DADPERIQFMES)   ');
    FDQueryAnaliseMensal.SQL.Add('  FOR Mes IN ( ' + varMesesSemLabelB + ')');
    FDQueryAnaliseMensal.SQL.Add('  ) AS A   ');

    FDQueryAnaliseMensal.SQL.Add('   CROSS APPLY ( SELECT    SUM(X.TIQF_DADPERIQFMES) AS [TOTAL PERIODO] ,   ');
    FDQueryAnaliseMensal.SQL.Add('                           AVG(NULLIF(X.TIQF_DADPERIQFMES,0)) AS [MEDIA PERIODO]   ');
    FDQueryAnaliseMensal.SQL.Add('                      FROM TIQF_DADOS X   ');
    FDQueryAnaliseMensal.SQL.Add('                      INNER JOIN TIQF_PERIODO P ON P.TIQF_PERCOD = X.TIQF_PERCOD  ');
    FDQueryAnaliseMensal.SQL.Add('                      WHERE X.TIQF_FORCOD = A.TIQF_FORCOD  ');
    FDQueryAnaliseMensal.SQL.Add('					  AND  P.TIQF_PERCOD >= :PERCOD_INI AND P.TIQF_PERCOD  <= :PERCOD_FIM    ');
    FDQueryAnaliseMensal.SQL.Add('                    ) B   ');
    FDQueryAnaliseMensal.SQL.Add('  )   ');
    FDQueryAnaliseMensal.SQL.Add('SELECT D.*, M.TITULO, M.VALOR_MINIMO, M.VALOR_MAXIMO, M.COR, X.VALOR FROM DADOS D  ');
    FDQueryAnaliseMensal.SQL.Add(' OUTER APPLY (SELECT VALOR FROM TIQF_META WHERE GETDATE() >= DATA_INICIO  AND GETDATE() <= DATA_FIM ) X ');
    FDQueryAnaliseMensal.SQL.Add(' LEFT OUTER JOIN TIQF_REGRA M ON  D.[MEDIA PERIODO]   >= M.VALOR_MINIMO AND  D.[MEDIA PERIODO]  <= M.VALOR_MAXIMO  ');

    FDQueryAnaliseMensal.SQL.Add('  ORDER BY Codigo   ');

    FDQueryAnaliseMensal.ParamByName( 'PERCOD_INI' ).AsInteger := FDQueryTIQF_PeriodoTIQF_PERCOD.AsInteger - 6;
    FDQueryAnaliseMensal.ParamByName( 'PERCOD_FIM' ).AsInteger := FDQueryTIQF_PeriodoTIQF_PERCOD.AsInteger;


    //FDQueryAnaliseMensal.SQL.SaveToFile('C:\Brady\IQF_OUT_112019.sql');
    FDQueryAnaliseMensal.Open;

    AddColumn;

  finally

    Mensagem( EmptyStr );

  end;
end;

procedure TFr_RelatorioAnaliseIQF.AddColumn;
var
  AColumn: TcxGridDBBandedColumn;
  I, X, Y   : Integer;
  Ano, Mes, Dia: Word;

  sumItem: TcxDataSummaryItem;
begin
   cxGridIQFDBBandedTableView.BeginUpdate();
   cxGridIQFDBBandedTableView.DataController.CreateAllItems;
   cxGridIQFDBBandedTableView.OptionsView.FixedBandSeparatorWidth := 2;

   try

    ABand := cxGridIQFDBBandedTableView.Bands.Add;
    ABand.Index := 0;
    ABand.HeaderAlignmentHorz := taCenter;
    ABand.Caption := 'Informa��es de Fornecedores';
    ABand.FixedKind :=  fkLeft;

    ABand := cxGridIQFDBBandedTableView.Bands.Add;
    ABand.Index := 1;
    ABand.HeaderAlignmentHorz := taCenter;
    ABand.Caption := 'Per�odo';


    AColumn := cxGridIQFDBBandedTableView.CreateColumn;
    AColumn.Width := 200;
    AColumn.Caption := 'Fornecedor';
    AColumn.DataBinding.FieldName := FDQueryAnaliseMensal.Fields[0].FieldName;
    AColumn.Position.BandIndex := 0;


    AColumn := cxGridIQFDBBandedTableView.CreateColumn;
    AColumn.Width := 90;
    AColumn.Caption := 'C�d. Fornecedor';
    AColumn.DataBinding.FieldName := FDQueryAnaliseMensal.Fields[1].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGridIQFDBBandedTableView.CreateColumn;
    AColumn.Width := 80;
    AColumn.Caption := 'Categoria';
    AColumn.DataBinding.FieldName := FDQueryAnaliseMensal.Fields[2].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGridIQFDBBandedTableView.CreateColumn;
    AColumn.Width := 70;
    AColumn.Caption := 'Classifica��o';
    AColumn.DataBinding.FieldName := FDQueryAnaliseMensal.Fields[3].FieldName;
    AColumn.Position.BandIndex := 0;



    for I := 4 to 9  do
    begin


          AColumn := cxGridIQFDBBandedTableView.CreateColumn;
          AColumn.DataBinding.FieldName := FDQueryAnaliseMensal.Fields[I].FieldName;
          AColumn.Caption := FormatDateTime('mmm',varMesesArrayB[i-4]) + '-' + IntToStr(Yearof(varMesesArrayB[i-4]));
          AColumn.Width := 80;
          AColumn.Position.BandIndex := 1;
          AColumn.PropertiesClass := TcxMaskEditProperties;
          TcxMaskEditProperties(AColumn.Properties).DisplayFormat := '#.##;(#.##)';

          cxGridIQFDBBandedTableView.DataController.Summary.FooterSummaryItems.Add(AColumn, spFooter, skSum, '##.##');

    end;

    AColumn := cxGridIQFDBBandedTableView.CreateColumn;
    AColumn.DataBinding.FieldName := FDQueryAnaliseMensal.Fields[10].FieldName; //16
    AColumn.Caption := 'Total Per�odo';
    AColumn.Width := 80;
    AColumn.Position.BandIndex := 1;
    AColumn.PropertiesClass := TcxMaskEditProperties;
    TcxMaskEditProperties(AColumn.Properties).DisplayFormat := '#.##;(#.##)';
    cxGridIQFDBBandedTableView.DataController.Summary.FooterSummaryItems.Add(AColumn, spFooter, skAverage, '##.##');


    AColumn := cxGridIQFDBBandedTableView.CreateColumn;
    AColumn.DataBinding.FieldName := FDQueryAnaliseMensal.Fields[11].FieldName;  //17
    AColumn.Caption := 'M�dia Per�odo';
    AColumn.Width := 80;
    AColumn.Position.BandIndex := 1;
    AColumn.PropertiesClass := TcxMaskEditProperties;
    TcxMaskEditProperties(AColumn.Properties).DisplayFormat := '#.##;(#.##)';
    cxGridIQFDBBandedTableView.DataController.Summary.FooterSummaryItems.Add(AColumn, spFooter, skAverage, '##.##');


    AColumn := cxGridIQFDBBandedTableView.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Meta';
    AColumn.DataBinding.FieldName := FDQueryAnaliseMensal.Fields[16].FieldName;     //22
    AColumn.Position.BandIndex := 1;


    cxGridIQFDBBandedTableView.OptionsView.Footer := True;
    cxGridIQFDBBandedTableView.OptionsView.GroupFooters := gfVisibleWhenExpanded;
    cxGridIQFDBBandedTableView.OptionsView.GroupFooterMultiSummaries := True;

    cxGridIQFDBBandedTableView.DataController.DataSource := DataSourceAnaliseMensal;
  finally
    cxGridIQFDBBandedTableView.EndUpdate;
  end;
end;


function TFr_RelatorioAnaliseIQF.MontaStringMes(bMostraLabel : Boolean; Alias : String; Tipo : String; SomarL : Boolean): WideString;
var
 I            : Integer;
 NovaData     : TDateTime;
 varResultado : String;
begin
  SetLength(varMesesArrayB, 6);
  SetLength(varMesesArrayF, 7);

  NovaData := System.DateUtils.StartOfTheMonth(FDQueryTIQF_PeriodoTIQF_PERDAT.AsDateTime);

  if ((Alias = '')or (Alias = 'B'))  and (Tipo = 'B') then
    NovaData     :=  IncMonth(System.DateUtils.StartOfTheMonth(NovaData), -5);

  varResultado := '';
  if ((Alias = '')or (Alias = 'B')) and (Tipo = 'B') then
  begin
    for I := 0 to 5 do
    begin
      varMesesArrayB[I] := NovaData;
      varResultado      := varResultado + BuscaMes(NovaData, bMostraLabel,Alias,SomarL);
      NovaData          := IncMonth(NovaData,1);
    end;
  end
  else
  begin
    for I := 0 to 6 do
    begin
      varMesesArrayF[I] := NovaData;
      varResultado      := varResultado + BuscaMes(NovaData, bMostraLabel,Alias, SomarL);
      NovaData          := IncMonth(NovaData,1);
    end;
  end;

  result := varResultado;
end;


function TFr_RelatorioAnaliseIQF.BuscaMes(Data: TDateTime; bLabel : Boolean; Alias : String; SomarLinha : Boolean) : String;
var
 Ano, Mes, Dia: Word;
 MesFiscal, MesAbrev : String;
 strFormatDate : string;
begin
   DecodeDate(Data, Ano, Mes, Dia);
   MesAbrev := formatdatetime('mmm', Data);

   MesAbrev := StringReplace(MesAbrev,'dez','Dec',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'set','Sep',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'abr','Apr',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'ago','Aug',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'mai','May',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'out','Oct',[rfReplaceAll, rfIgnoreCase]);
   MesAbrev := StringReplace(MesAbrev,'fev','Feb',[rfReplaceAll, rfIgnoreCase]);

   strFormatDate :=  '[' + MesAbrev  + ' ' + IntToStr(Ano)  +  ']';



   if bLabel then
   begin
     Case Mes Of
         1   : MesFiscal := strFormatDate + ','; // + ' AS JANEIRO,' ;
         2   : MesFiscal := strFormatDate + ','; // + ' AS FEVEREIRO,' ;
         3   : MesFiscal := strFormatDate + ','; // + ' AS MAR�O,' ;
         4   : MesFiscal := strFormatDate + ','; // + ' AS ABRIL,' ;
         5   : MesFiscal := strFormatDate + ','; // + ' AS MAIO,' ;
         6   : MesFiscal := strFormatDate + ','; // + ' AS JUNHO,' ;
         7   : MesFiscal := strFormatDate + ','; // + ' AS JULHO,' ;
         8   : MesFiscal := strFormatDate + ','; // + ' AS AGOSTO,' ;
         9   : MesFiscal := strFormatDate + ','; // + ' AS SETEMBRO,' ;
         10  : MesFiscal := strFormatDate + ','; // + ' AS OUTUBRO,' ;
         11  : MesFiscal := strFormatDate + ','; // + ' AS NOVEMBRO,' ;
         12  : MesFiscal := strFormatDate + ','; // + ' AS DEZEMBRO,' ;
     End ;
   end
   else
   begin
     Case Mes Of
         1   : MesFiscal := strFormatDate + ',' ;
         2   : MesFiscal := strFormatDate + ',' ;
         3   : MesFiscal := strFormatDate + ',' ;
         4   : MesFiscal := strFormatDate + ',' ;
         5   : MesFiscal := strFormatDate + ',' ;
         6   : MesFiscal := strFormatDate + ',' ;
         7   : MesFiscal := strFormatDate + ',' ;
         8   : MesFiscal := strFormatDate + ',' ;
         9   : MesFiscal := strFormatDate + ',' ;
         10  : MesFiscal := strFormatDate + ',' ;
         11  : MesFiscal := strFormatDate + ',' ;
         12  : MesFiscal := strFormatDate + ',' ;
     End ;
   end;


   //if (Alias <> '') then
   //    MesFiscal := Alias + '.' + MesFiscal;
   if SomarLinha then
   begin
      MesFiscal := Copy(MesFiscal,1,length(MesFiscal)-1);

      Case Mes Of
         1   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         2   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         3   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         4   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         5   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         6   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         7   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         8   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         9   : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         10  : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         11  : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
         12  : MesFiscal := 'IsNull(' +  Alias +  '.' + MesFiscal + ',0) +' ;
     End ;
   end
   else
   begin
     if (Alias <> '') and (bLabel) then
     begin
        MesFiscal := Copy(MesFiscal,1,length(MesFiscal)-1);

        Case Mes Of
           1   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Jan_' + IntToStr(Ano) + ',' ;
           2   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Fev_' + IntToStr(Ano) + ',' ;
           3   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Mar_' + IntToStr(Ano) + ',' ;
           4   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Abr_' + IntToStr(Ano) + ',' ;
           5   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Mai_' + IntToStr(Ano) + ',' ;
           6   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Jun_' + IntToStr(Ano) + ',' ;
           7   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Jul_' + IntToStr(Ano) + ',' ;
           8   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Ago_' + IntToStr(Ano) + ',' ;
           9   : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Set_' + IntToStr(Ano) + ',' ;
           10  : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Out_' + IntToStr(Ano) + ',' ;
           11  : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Nov_' + IntToStr(Ano) + ',' ;
           12  : MesFiscal :=  Alias +  '.' + MesFiscal + ' AS Dez_' + IntToStr(Ano) + ',' ;
       End ;
     end;
   end;



   Result :=  MesFiscal;

end;

procedure TFr_RelatorioAnaliseIQF.cxGridDBChartView1CategoriesGetValueDisplayText(
  Sender: TObject; const AValue: Variant; var ADisplayText: string);

   function GetValueIndex: Integer;

  begin

    for Result := 0 to cxGridDBChartView1.Categories.VisibleValueCount - 1 do

      if cxGridDBChartView1.Categories.VisibleValues[Result] = AValue then

        Exit;

    Result := -1;

  end;

var

  AValueIndex: Integer;

  AValueCaption: string;


begin
  AValueIndex := GetValueIndex;

  if AValueIndex = -1 then

    Exit;

  AValueCaption := 'M�s:' + cxGridDBChartView1.DiagramPie.GetValueCaption(cxGridDBChartSeries1, AValueIndex);
  AValueCaption := AValueCaption + ' Acumulado:' +  cxGridDBChartView1.DiagramPie.GetValueCaption(cxGridDBChartSeries2, AValueIndex);
  ADisplayText := ADisplayText + ' - ' + AValueCaption;
end;

procedure TFr_RelatorioAnaliseIQF.cxGridIQFDBBandedTableViewMEDIAPERIODOStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
{
  if ARecord.Values[AItem.Index] < 50 then
    AStyle := cxStyleInsatisfatorio
  else if ARecord.Values[AItem.Index] < 80 then
    AStyle := cxStyleCondicional
  else
     AStyle := cxStyleSatisfatorio;
     }
end;



procedure TFr_RelatorioAnaliseIQF.cxGridIQFDBBandedTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  AColumn: TcxGridDBColumn;
begin
{
   if AItem = nil then exit;


   if ARecord.Values[11] < 50 then
     AStyle := cxStyleInsatisfatorio
   else if  ARecord.Values[11] < 80 then
     AStyle := cxStyleCondicional
   else if ARecord.Values[11] >= 80 Then
     AStyle := cxStyleSatisfatorio;
     }

end;

procedure TFr_RelatorioAnaliseIQF.cxPageControlGridChange(Sender: TObject);
begin
  if not FDQueryTIQF_Dados.IsEmpty then
    FDQueryTIQF_DadosDetalhe.Locate('TIQF_FORSAP', FDQueryTIQF_DadosTIQF_FORSAP.AsString,[])
end;



procedure TFr_RelatorioAnaliseIQF.cxTableViewTMAQ_Apontamento01TIQF_DADPERIQFACUCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
               {
  if AViewInfo.Value < 50 then
    ACanvas.Brush.Color := clRed
  else
  if AViewInfo.Value < 80 then
    ACanvas.Brush.Color := clYellow
  else
    ACanvas.Brush.Color := clGreen;
    }

end;

procedure TFr_RelatorioAnaliseIQF.cxTableViewTMAQ_Apontamento01TIQF_DADPERIQFMESCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
    {
  if AViewInfo.Value < 50 then
    ACanvas.Brush.Color := clRed
  else
  if AViewInfo.Value < 80 then
    ACanvas.Brush.Color := clYellow
  else
    ACanvas.Brush.Color := clGreen;
    }

end;

procedure TFr_RelatorioAnaliseIQF.cxTableViewTMAQ_ApontamentoGrafico01CategoriesGetValueDisplayText(
  Sender: TObject; const AValue: Variant; var ADisplayText: string);

  function GetValueIndex: Integer;

  begin

    for Result := 0 to cxTableViewTMAQ_ApontamentoGrafico01.Categories.VisibleValueCount - 1 do

      if cxTableViewTMAQ_ApontamentoGrafico01.Categories.VisibleValues[Result] = AValue then

        Exit;

    Result := -1;

  end;


var

  AValueIndex: Integer;

  AValueCaption: string;


begin
  AValueIndex := GetValueIndex;

  if AValueIndex = -1 then

    Exit;

  AValueCaption := 'M�s:' + cxTableViewTMAQ_ApontamentoGrafico01.DiagramPie.GetValueCaption(cxTableViewTMAQ_ApontamentoGrafico01Series1, AValueIndex);
  AValueCaption := AValueCaption + ' Acumulado:' +  cxTableViewTMAQ_ApontamentoGrafico01.DiagramPie.GetValueCaption(cxTableViewTMAQ_ApontamentoGrafico01Series2, AValueIndex);
  ADisplayText := ADisplayText + ' - ' + AValueCaption;

end;

procedure TFr_RelatorioAnaliseIQF.cxTableViewTMAQ_ApontamentoGrafico01DiagramColumnCustomDrawValue(
  Sender: TcxGridChartDiagram; ACanvas: TcxCanvas;
  AViewInfo: TcxGridChartDiagramValueViewInfo; var ADone: Boolean);

var
  AColor: TColor;
  ARecIndex, ColIndex: Integer;
  AValue : Variant;
begin
  ARecIndex := AViewInfo.ValueIndex;
  ColIndex := AViewInfo.Series.ID;

  AValue := AViewInfo.GridView.DataController.Values[ARecIndex, ColIndex];

  // draw values in different colors
  if AValue < 50 then
    AColor := clRed
  else
  if AValue < 80 then
     AColor := clYellow
  else if AValue >= 80 then
    AColor := clGreen;

  ACanvas.FillRect(AViewInfo.Bounds, AColor);

end;

procedure TFr_RelatorioAnaliseIQF.cxTableViewTMAQ_ApontamentoGrafico01Series1StylesGetValueStyle(
  Sender: TcxGridChartSeries; AValueIndex: Integer; var AStyle: TcxStyle);
var
  AColumn: TcxGridChartSeries;
  varValor : Variant;
begin
      {
    if AValueIndex = -1 then exit;

   if AColumn.Values[AValueIndex] < 50 then
     AStyle := cxStyleInsatisfatorio
   else if  AColumn.Values[AValueIndex]  < 80 then
     AStyle := cxStyleCondicional
   else if AColumn.Values[AValueIndex]  >= 80 Then
     AStyle := cxStyleSatisfatorio;
           }
end;

procedure TFr_RelatorioAnaliseIQF.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  FDQueryTIQF_DadosDetalhe.Close;
  FDQueryTIQF_Dados.Close;
  FDQueryTIQF_Periodo.Close;
  FDConnection.Close;

  Fr_RelatorioAnaliseIQF := nil;
  Action := caFree;

end;

procedure TFr_RelatorioAnaliseIQF.FormCreate(Sender: TObject);
begin

  LoadGridCustomization;
  cxPageControl.ActivePage := tabGrid;
end;

procedure TFr_RelatorioAnaliseIQF.LoadGridCustomization;
begin

 if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxTableViewTMAQ_Apontamento01.Name + '.ini' ) then
    cxTableViewTMAQ_Apontamento01.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxTableViewTMAQ_Apontamento01.Name + '.ini' );

end;

procedure TFr_RelatorioAnaliseIQF.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

end.
