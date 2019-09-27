unit uRelatorioAnaliseIQF;

interface

uses
  dxCoreClasses,
  System.DateUtils,
  System.Math,

  System.IOUtils,
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
  dxSkinWhiteprint, dxSkinXmas2008Blue,cxGridExportLink,
  FireDAC.Comp.ScriptCommands, FireDAC.Comp.Script;

type
  TFr_RelatorioAnaliseIQF = class(TForm)
    cxPageControl: TcxPageControl;
    cxTabSheetGrid: TcxTabSheet;
    DataSourceTIQF_Dados: TDataSource;
    FDConnection: TFDConnection;
    FDQueryTIQF_Dados: TFDQuery;
    cxSmallImages: TcxImageList;
    cxStyleRepository: TcxStyleRepository;
    cxStyleSemTurno: TcxStyle;
    cxStyleSetup: TcxStyle;
    cxStyleProdutivo: TcxStyle;
    cxStyleParada: TcxStyle;
    cxStyleSemApontamento: TcxStyle;
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
    FDQueryTIQF_DadosTIQF_DADPERIQFACU: TBCDField;
    cxTabSheetPivot00: TcxTabSheet;
    cxDBPivotGrid00: TcxDBPivotGrid;
    cxDBPivotGrid00FieldTIQF_FORNOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTIQF_PERNOM: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTIQF_DADPERIQFMES: TcxDBPivotGridField;
    cxDBPivotGrid00FieldTIQF_DADPERIQFACU: TcxDBPivotGridField;
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
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    cxGridTMAQ_ApontamentoGrafico01: TcxGrid;
    cxTableViewTMAQ_ApontamentoGrafico01: TcxGridDBChartView;
    cxTableViewTMAQ_ApontamentoGrafico01DataGroup1: TcxGridDBChartDataGroup;
    cxTableViewTMAQ_ApontamentoGrafico01DataGroup2: TcxGridDBChartDataGroup;
    cxTableViewTMAQ_ApontamentoGrafico01Series1: TcxGridDBChartSeries;
    cxTableViewTMAQ_ApontamentoGrafico01Series2: TcxGridDBChartSeries;
    cxGridLevelTMAQ_ApontamentoGrafico01: TcxGridLevel;
    cxGridTMAQ_Apontamento02: TcxGrid;
    cxGridDBChartView1: TcxGridDBChartView;
    cxGridDBChartDataGroup3: TcxGridDBChartDataGroup;
    cxGridDBChartSeries1: TcxGridDBChartSeries;
    cxGridDBChartSeries2: TcxGridDBChartSeries;
    cxGridTMAQ_ApontamentoGrafico02: TcxGridLevel;
    FDScriptCalcIQF: TFDScript;
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
  private
    procedure Mensagem( pMensagem: String );
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

    Mensagem( 'Obtendo dados (01 - IQF)...' );
    //FDQueryTIQF_Dados.ParamByName('TIQF_PERCOD').AsInteger := FDQueryTIQF_PeriodoTIQF_PERCOD.AsInteger;
    FDQueryTIQF_Dados.Open;
    FDQueryTIQF_DadosDetalhe.Open;

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

        if SaveDialog.Execute then
           ExportGridToExcel(SaveDialog.FileName, cxGridTMAQ_Apontamento01, True, True);

     end
     else if cxPageControlGrid.ActivePage = tabDetalhe then
          begin

            if FDQueryTIQF_DadosDetalhe.IsEmpty then
                raise Exception.Create('N�o h� dados para serem exportados ao Excel');

            SaveDialog.InitialDir := GetCurrentDir;

            if SaveDialog.Execute then
               ExportGridToExcel(SaveDialog.FileName, cxGrid_Detalhe, True, True);
          end;
  end;

end;

procedure TFr_RelatorioAnaliseIQF.cxButtonRefreshClick(Sender: TObject);
begin
  FDQueryTIQF_DadosDetalhe.Close;
  FDQueryTIQF_Dados.Close;
  FDQueryTIQF_Periodo.Close;
  FDConnection.Close;
  AbrirDataset;

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

procedure TFr_RelatorioAnaliseIQF.cxPageControlGridChange(Sender: TObject);
begin
  if not FDQueryTIQF_Dados.IsEmpty then
    FDQueryTIQF_DadosDetalhe.Locate('TIQF_FORSAP', FDQueryTIQF_DadosTIQF_FORSAP.AsString,[])
end;

procedure TFr_RelatorioAnaliseIQF.cxTableViewTMAQ_Apontamento01TIQF_DADPERIQFACUCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  if AViewInfo.Value < 50 then
    ACanvas.Brush.Color := clRed
  else
  if AViewInfo.Value < 80 then
    ACanvas.Brush.Color := clYellow
  else
    ACanvas.Brush.Color := clGreen;

end;

procedure TFr_RelatorioAnaliseIQF.cxTableViewTMAQ_Apontamento01TIQF_DADPERIQFMESCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  if AViewInfo.Value < 50 then
    ACanvas.Brush.Color := clRed
  else
  if AViewInfo.Value < 80 then
    ACanvas.Brush.Color := clYellow
  else
    ACanvas.Brush.Color := clGreen;

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
