unit uBrady;

interface

uses
  cxGrid,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridDBTableView,
  cxGridExportLink,
  cxExportPivotGridLink,
  dxRibbonForm,
  cxDBPivotGrid,
  System.IOUtils,

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxRibbonSkins, dxSkinsCore, dxSkinsdxRibbonPainter, dxRibbonCustomizationForm, cxContainer, cxEdit,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Phys, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, dxSkinsdxBarPainter, cxPC, dxSkinscxPCPainter, dxBarBuiltInMenu, dxBar, dxRibbonRadialMenu, dxTabbedMDI,
  Vcl.ImgList, dxSkinsForm, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  FireDAC.Comp.UI, dxStatusBar, dxRibbonStatusBar, Vcl.Grids, Vcl.ValEdit, cxTextEdit, cxMaskEdit, cxScrollBox, dxGallery,
  dxGalleryControl, dxRibbonBackstageViewGalleryControl, dxBevel, cxLabel, cxGroupBox, Vcl.ExtCtrls, dxRibbonBackstageView,
  cxClasses, dxRibbon, dxSkinsDefaultPainters, dxSkinOffice2013White,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TFr_Brady = class(TdxRibbonForm)
    dxBarManager: TdxBarManager;
    dxBarManagerBarBarraAcessoRapido: TdxBar;
    dxRibbon: TdxRibbon;
    dxRibbonTabSIOP: TdxRibbonTab;
    dxRibbonBackstageViewSISTEMA: TdxRibbonBackstageView;
    dxRibbonStatusBar: TdxRibbonStatusBar;
    dxSkinController: TdxSkinController;
    dxRibbonTabCargaMaquina: TdxRibbonTab;
    dxRibbonBackstageViewTabSheetConta: TdxRibbonBackstageViewTabSheet;
    dxRibbonBackstageViewTabSheetOpcoes: TdxRibbonBackstageViewTabSheet;
    dxRibbonBackstageViewTabSheetFechar: TdxRibbonBackstageViewTabSheet;
    cxGroupBoxBackstageViewTabSheetOpcoes: TcxGroupBox;
    BevelBackstageViewTabSheetOpcoesSpace2: TBevel;
    BevelBackstageViewTabSheetOpcoesSpace1: TBevel;
    cxLabelBackstageViewTabSheetOpcoes: TcxLabel;
    BevelBackstageViewTabSheetOpcoesSpace3: TBevel;
    cxGroupBoxOpcoesConexaoMain: TcxGroupBox;
    cxGroupBoxOpcoesConexaoPanel: TcxGroupBox;
    BevelBackstageViewTabSheetOpcoesConexaoSpace1: TBevel;
    BevelBackstageViewTabSheetOpcoesConexaoSpace2: TdxBevel;
    dxRibbonBackstageViewGalleryControlOpcoes: TdxRibbonBackstageViewGalleryControl;
    dxRibbonBackstageViewGalleryGroupOpcoesConexao: TdxRibbonBackstageViewGalleryGroup;
    dxRibbonBackstageViewGalleryItemOpcoesConexao: TdxRibbonBackstageViewGalleryItem;
    cxSmallImages: TcxImageList;
    cxLargeImages: TcxImageList;
    cxScrollBoxControlOpcoesPanel: TcxScrollBox;
    BevelOpcoesPanelSpace1: TBevel;
    cxLabelOpcoesConexao: TcxLabel;
    ValueListEditor: TValueListEditor;
    cxGroupBoxBackstageViewTabSheetConta: TcxGroupBox;
    BevelBackstageViewTabSheetContaSpace2: TBevel;
    BevelBackstageViewTabSheetContaSpace1: TBevel;
    cxLabelBackstageViewTabSheetConta: TcxLabel;
    cxGroupBoxContaDadosPessoalMain: TcxGroupBox;
    cxGroupBoxContaDadosPessoalPanel: TcxGroupBox;
    BevelBackstageViewTabSheetContaDadosPessoalSpace1: TBevel;
    BevelBackstageViewTabSheetContaDadosPessoalSpace2: TdxBevel;
    dxRibbonBackstageViewGalleryControlConta: TdxRibbonBackstageViewGalleryControl;
    dxRibbonBackstageViewGalleryGroupContaDadosPessoal: TdxRibbonBackstageViewGalleryGroup;
    dxRibbonBackstageViewGalleryItemContaDadosPessoal: TdxRibbonBackstageViewGalleryItem;
    cxScrollBoxControlContaPanel: TcxScrollBox;
    BevelContaPanelSpace1: TBevel;
    cxLabelOpcoesDadosPessoal: TcxLabel;
    BevelBackstageViewTabSheetContaSpace3: TBevel;
    cxLabelOpcoesDadosPessoalEMail: TcxLabel;
    cxMaskEditOpcoesDadosPessoalEMail: TcxMaskEdit;
    FDManager: TFDManager;
    dxBarManagerBarSIOPRelatorio: TdxBar;
    dxTabbedMDIManager: TdxTabbedMDIManager;
    dxBarButtonBarraAcessoRapidoSalvar: TdxBarButton;
    dxBarButtonBarraAcessoRapidoExcluir: TdxBarButton;
    dxBarButtonBarraAcessoRapidoNovo: TdxBarButton;
    dxBarLargeButtonSIOPRelatoriosTabelaPreco: TdxBarLargeButton;
    dxBarLargeButtonSIOPRelatorioPartNumber: TdxBarLargeButton;
    dxBarLargeButtonSIOPRelatoriosFaturamentoPedido: TdxBarLargeButton;
    dxBarLargeButtonSIOPRelatoriosVendas: TdxBarLargeButton;
    dxBarLargeButtonCargaMaquinaPainelOperador: TdxBarLargeButton;
    dxBarLargeButtonCargaMaquinaPainelLiderTambore: TdxBarLargeButton;
    dxBarLargeButtonCargaMaquinaPainelLiderManaus: TdxBarLargeButton;
    dxBarLargeButtonCargaMaquinaPainelYNumber: TdxBarLargeButton;
    dxBarManagerBarCargaMaquinaPainel: TdxBar;
    FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
    FDConnection: TFDConnection;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDQueryTSIS_Usuario: TFDQuery;
    dxBarManagerBarCargaMaquinaCadastro: TdxBar;
    dxBarLargeButtonCargaMaquinaCadastroSite: TdxBarButton;
    dxBarLargeButtonCargaMaquinaCadastroCelula: TdxBarButton;
    dxBarLargeButtonCargaMaquinaCadastroMaquina: TdxBarButton;
    dxBarLargeButtonCargaMaquinaCadastroOperador: TdxBarButton;
    dxBarLargeButtonCargaMaquinaCadastroAtividade: TdxBarButton;
    dxBarLargeButtonCargaMaquinaCadastroApontamento: TdxBarButton;
    dxRibbonTabAdministrativo: TdxRibbonTab;
    dxBarManagerBarAdministrativoCadastro: TdxBar;
    dxBarLargeButtonAdministrativoCadastroMenu: TdxBarButton;
    dxBarLargeButtonAdministrativoCadastroUsuario: TdxBarButton;
    FDQueryTSIS_UsuarioTSIS_USUCOD: TFDAutoIncField;
    FDQueryTSIS_UsuarioTSIS_USUMEN: TMemoField;
    FDQueryTSIS_UsuarioTSIS_USUNOM: TStringField;
    FDQueryTSIS_UsuarioTSIS_USULOG: TStringField;
    FDQueryTSIS_UsuarioTSIS_USUEML: TStringField;
    FDQueryTSIS_Menu: TFDQuery;
    FDQueryTSIS_MenuTSIS_MENCOD: TFDAutoIncField;
    FDQueryTSIS_MenuTSIS_MENNOM: TStringField;
    FDQueryTSIS_MenuTSIS_MENOBJ: TStringField;
    FDQueryTSIS_UsuarioTSIS_USUATI: TStringField;
    FDQueryTSIS_UsuarioTSIS_USUSREP: TStringField;
    FDQueryTSIS_UsuarioTSIS_USUCSR: TStringField;
    FDQueryTSIS_UsuarioTSIS_USUMNG: TStringField;
    FDQueryTSIS_UsuarioTSIS_USUADM: TStringField;
    FDQueryTSIS_UsuarioTSIS_USUPRD: TStringField;
    dxBarManagerBarSIOPCadastros: TdxBar;
    dxBarButtonSIOPCadastroSiteDePara: TdxBarButton;
    dxBarButtonSIOPCadastroCanalDePara: TdxBarButton;
    dxBarButtonSIOPCadastroFamilia: TdxBarButton;
    dxBarButtonSIOPCadastroFamiliaDePara: TdxBarButton;
    dxBarButtonSIOPCadastroGrupoCliente: TdxBarButton;
    dxBarButtonSIOPCadastroGrupoClienteDePara: TdxBarButton;
    dxBarButtonSIOPCadastroRepresentante: TdxBarButton;
    dxBarButtonSIOPCadastroRepresentanteDePara: TdxBarButton;
    dxBarButtonGridToolsLayoutSalvar: TdxBarButton;
    dxRibbonRadialMenu: TdxRibbonRadialMenu;
    dxBarSubItemGridToolsLayout: TdxBarSubItem;
    dxBarSubItemGridToolsExportar: TdxBarSubItem;
    dxBarButtonGridToolsExportarExcel: TdxBarButton;
    SaveDialogExportGridExcel: TSaveDialog;
    dxBarButtonGridToolsLayoutColunaCaption: TdxBarButton;
    dxSkinController1: TdxSkinController;
    FDQueryTSIS_UsuarioTSIS_USUMAQ: TMemoField;
    FDQueryTSIS_UsuarioTSIS_USULID: TStringField;
    dxBarManagerBarCargaMaquinaRelatorio: TdxBar;
    dxBarLargeButtonCargaMaquinaRelatorioAnaliseApontamento: TdxBarLargeButton;
    dxRibbonTabEngenharia: TdxRibbonTab;
    dxBarManagerBarEngenhariaRelatorio: TdxBar;
    dxBarLargeButtonEngenhariaRelatorioUtilizacaoMaquina: TdxBarLargeButton;
    dxBarLargeButtonSIOPRelatoriosForecast: TdxBarLargeButton;
    dxRibbonTabDetran: TdxRibbonTab;
    dxBarManagerBarDetranProcessamento: TdxBar;
    dxBarLargeButtonDetranProcessamentoGerarListaEtiqueta: TdxBarLargeButton;
    dxRibbonTabCS: TdxRibbonTab;
    dxBarManagerBarCSConsulta: TdxBar;
    dxBarLargeButtonCSConsultaNotaFiscal: TdxBarLargeButton;
    dxRibbonTabInovar: TdxRibbonTab;
    dxBarButtonInovarCadastroCliente: TdxBarButton;
    dxBarButtonInovarCadastroCFOP: TdxBarButton;
    dxBarButtonInovarCadastroParcelaDedutivel: TdxBarButton;
    dxBarManagerBarInovarCadastro: TdxBar;
    dxBarManagerBarInovarConsulta: TdxBar;
    dxBarButtonInovarConsultaParcelaDedutivel: TdxBarButton;
    dxBarButtonInovarCadastroNotaFiscal: TdxBarButton;
    dxRibbonTabIQF: TdxRibbonTab;
    dxBarManagerBarIQFCadastro: TdxBar;
    dxBarButtonIQFCadastroParametros: TdxBarButton;
    dxBarButtonIQFCadastroForncedor: TdxBarButton;
    dxBarButtonIQFCadastroPeriodo: TdxBarButton;
    dxBarManagerBarIQFImportacao: TdxBar;
    dxBarButtonIQFImportacaoImportar: TdxBarButton;
    dxBarLargeButtonIQFKPI: TdxBarLargeButton;
    dxBarManagerBarIQFRelatorio: TdxBar;
    dxRibbonTabGrossMargin: TdxRibbonTab;
    dxBarManagerBarGrossMarginImportacao: TdxBar;
    dxBarButtonGrossMarginImportacaoBOM: TdxBarButton;
    dxBarButtonGrossMarginImportacaoRouting: TdxBarButton;
    dxBarButtonGrossMarginImportacaoCustoEstoque: TdxBarButton;
    dxBarButtonGrossMarginImportacaoTaxasHoras: TdxBarButton;
    dxBarManagerBarGrossMarginRelatorios: TdxBar;
    dxBarButtonGrossMarginImportacaoCalcularGrossMargin: TdxBarButton;
    dxBarLargeButtonSIOPRelatoriosGrossMargin: TdxBarLargeButton;
    dxRibbonTabSeton: TdxRibbonTab;
    dxBarButtonProduto: TdxBarButton;
    dxBarButton1: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarManagerBarProdutoSeton: TdxBar;
    dxBarButtonProdutoSeton: TdxBarButton;
    dxBarManagerBarUploadProdutoSeton: TdxBar;
    dxBarButtonUploadProdutoSeton: TdxBarButton;
    dxBarButtonSetonForecast: TdxBarButton;
    dxBarButtonClientes: TdxBarButton;
    dxBarSubItem2: TdxBarSubItem;
    dxBarButtonSIOPCadastroCliente: TdxBarButton;
    dxBarLargeButtonSIOPRecuperacaodeContas: TdxBarLargeButton;
    dxBarLargeButtonSIOPGestaoMercado: TdxBarLargeButton;
    dxBarButtonIQFImportacaoFornecedor: TdxBarButton;
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
    dxBarButton2: TdxBarButton;
    dxBarLargeButtonSIOPRecuperacaodeClientes: TdxBarLargeButton;
    dxBarLargeButtonSIOPDashBoard: TdxBarLargeButton;
    procedure FormCreate(Sender: TObject);
    procedure dxRibbonBackstageViewSISTEMATabChanged(Sender: TObject);
    procedure ValueListEditorStringsChange(Sender: TObject);
    procedure dxRibbonBackstageViewGalleryControlOpcoesItemClick(Sender: TObject; AItem: TdxRibbonBackstageViewGalleryItem);
    procedure dxRibbonBackstageViewSISTEMATabClick(Sender: TObject; ATab: TdxRibbonBackstageViewTabSheet);
    procedure dxRibbonBackstageViewGalleryControlContaItemClick(Sender: TObject; AItem: TdxRibbonBackstageViewGalleryItem);
    procedure cxMaskEditOpcoesDadosPessoalEMailExit(Sender: TObject);
    procedure dxBarLargeButtonSIOPRelatoriosTabelaPrecoClick(Sender: TObject);
    procedure dxBarLargeButtonSIOPRelatorioPartNumberClick(Sender: TObject);
    procedure dxBarLargeButtonCargaMaquinaCadastroSiteClick(Sender: TObject);
    procedure dxBarLargeButtonCargaMaquinaCadastroCelulaClick(Sender: TObject);
    procedure dxBarLargeButtonCargaMaquinaCadastroMaquinaClick(Sender: TObject);
    procedure dxBarLargeButtonCargaMaquinaCadastroOperadorClick(Sender: TObject);
    procedure dxBarLargeButtonCargaMaquinaCadastroAtividadeClick(Sender: TObject);
    procedure dxBarLargeButtonCargaMaquinaCadastroApontamentoClick(Sender: TObject);
    procedure dxBarLargeButtonCargaMaquinaPainelOperadorClick(Sender: TObject);
    procedure dxBarLargeButtonAdministrativoCadastroMenuClick(Sender: TObject);
    procedure dxBarLargeButtonAdministrativoCadastroUsuarioClick(Sender: TObject);
    procedure dxBarButtonSIOPCadastroSiteDeParaClick(Sender: TObject);
    procedure dxBarButtonGridToolsExportarExcelClick(Sender: TObject);
    procedure dxBarButtonGridToolsLayoutSalvarClick(Sender: TObject);
    procedure dxBarButtonGridToolsLayoutColunaCaptionClick(Sender: TObject);
    procedure dxBarButtonSIOPCadastroCanalDeParaClick(Sender: TObject);
    procedure dxBarButtonSIOPCadastroFamiliaClick(Sender: TObject);
    procedure dxBarButtonSIOPCadastroGrupoClienteClick(Sender: TObject);
    procedure dxBarButtonSIOPCadastroRepresentanteClick(Sender: TObject);
    procedure dxBarButtonSIOPCadastroFamiliaDeParaClick(Sender: TObject);
    procedure dxBarButtonSIOPCadastroGrupoClienteDeParaClick(Sender: TObject);
    procedure dxBarButtonSIOPCadastroRepresentanteDeParaClick(Sender: TObject);
    procedure dxBarLargeButtonSIOPRelatoriosFaturamentoPedidoClick(Sender: TObject);
    procedure dxBarLargeButtonSIOPRelatoriosVendasClick(Sender: TObject);
    procedure dxBarLargeButtonCargaMaquinaPainelLiderTamboreClick(Sender: TObject);
    procedure dxBarLargeButtonCargaMaquinaRelatorioAnaliseApontamentoClick(Sender: TObject);
    procedure dxBarLargeButtonEngenhariaRelatorioUtilizacaoMaquinaClick(Sender: TObject);
    procedure dxBarLargeButtonCargaMaquinaPainelLiderManausClick(Sender: TObject);
    procedure dxBarLargeButtonCargaMaquinaPainelYNumberClick(Sender: TObject);
    procedure dxBarLargeButtonDetranProcessamentoGerarListaEtiquetaClick(Sender: TObject);
    procedure dxBarLargeButtonCSConsultaNotaFiscalClick(Sender: TObject);
    procedure dxBarButtonInovarCadastroClienteClick(Sender: TObject);
    procedure dxBarButtonInovarCadastroNotaFiscalClick(Sender: TObject);
    procedure dxBarButtonInovarCadastroCFOPClick(Sender: TObject);
    procedure dxBarButtonInovarCadastroParcelaDedutivelClick(Sender: TObject);
    procedure dxBarButtonInovarConsultaParcelaDedutivelClick(Sender: TObject);
    procedure dxBarButtonIQFCadastroParametrosClick(Sender: TObject);
    procedure dxBarButtonIQFCadastroPeriodoClick(Sender: TObject);
    procedure dxBarButtonIQFCadastroForncedorClick(Sender: TObject);
    procedure dxBarButtonIQFImportacaoImportarClick(Sender: TObject);
    procedure dxBarLargeButtonSIOPRelatoriosForecastClick(Sender: TObject);
    procedure dxBarLargeButtonIQFKPIClick(Sender: TObject);
    procedure dxBarButtonGrossMarginImportacaoBOMClick(Sender: TObject);
    procedure dxBarButtonGrossMarginImportacaoRoutingClick(Sender: TObject);
    procedure dxBarButtonGrossMarginImportacaoCustoEstoqueClick(
      Sender: TObject);
    procedure dxBarButtonGrossMarginImportacaoTaxasHorasClick(Sender: TObject);
    procedure dxBarLargeButtonSIOPRelatoriosGrossMarginClick(Sender: TObject);
    procedure dxBarButtonGrossMarginImportacaoCalcularGrossMarginClick(
      Sender: TObject);
    procedure dxBarButtonProdutoClick(Sender: TObject);
    procedure dxBarButtonUploadProdutoSetonClick(Sender: TObject);
    procedure dxBarButtonSetonForecastClick(Sender: TObject);
    procedure dxBarLargeButtonSIOPRecuperacaodeContasClick(Sender: TObject);
    procedure dxBarLargeButtonSIOPGestaoMercadoClick(Sender: TObject);
    procedure dxBarButtonIQFImportacaoFornecedorClick(Sender: TObject);
    procedure dxBarLargeButtonSIOPRecuperacaodeClientesClick(Sender: TObject);
    procedure dxBarLargeButtonSIOPDashBoardClick(Sender: TObject);
  private
    FFormatoBR: TFormatSettings;
    FPainelOperador: Boolean;
    FTSIS_USUNOM: String;
    FSalesRep: Boolean;
    FCustomerService: Boolean;
    FActivecxTableView: TcxCustomGridView;
    FActivecxDBPivot: TcxDBPivotGrid;
    FPainelLider: Boolean;
    FTSIS_USUCOD: Integer;
    procedure cxTableViewColumnGetStoredProperties(Sender: TcxCustomGridTableItem; AProperties: TStrings);
    procedure cxDBPivotFieldGetStoredProperties(Sender: TObject; AProperties: TStrings);
    { Private declarations }
  public
    procedure PopupGridTools( pActivecxTableView: TcxCustomGridView );
    procedure PopupPivotTools( pActivecxDBPivot: TcxDBPivotGrid );
    property PainelOperador: Boolean read FPainelOperador;
    property PainelLider: Boolean read FPainelLider;
    property SalesRep: Boolean read FSalesRep write FSalesRep;
    property CustomerService: Boolean read FCustomerService;
    property TSIS_USUCOD: Integer read FTSIS_USUCOD;
    property TSIS_USUNOM: String read FTSIS_USUNOM write FTSIS_USUNOM;
    { Public declarations }
  end;

var
  Fr_Brady: TFr_Brady;

implementation

{$R *.dfm}

uses uUtils, uRelatorioPreco, uRelatorioPartNumber, uCadastroSite, AsyncCalls, uCadastroCelula, uCadastroMaquina,
  uCadastroOperador, uCadastroAtividade, uCadastroApontamento, uPainelOperador, uCadastroMenu, uCadastroUsuario, uAddObservacao,
  uUtilsColuna, uCadastroDeParaSite, uCadastroDeParaCanal, uCadastroFamilia, uCadastroGrupoCliente, uCadastroRepresentante,
  uCadastroDeParaFamilia, uCadastroDeParaGrupoCliente, uCadastroDeParaRepresentante, uRelatorioFaturamentoPedidos, uPainelLider,
  uRelatorioAnaliseApontamento, uRelatorioUtilizacaoMaquina, uPainelItem, uRelatorioVendas, uCadastroDetran, uRelatorioForecast,
  uRelatGrossMargin, uConsultaNotaFiscal, uCadastroInovarCliente,
  uCadastroInovarCFOP, uCadastroInovarParcelaDedutivel,
  uConsultaInovarParcelaDedutivel, uCadastroInovarNotaFiscal,
  uCadastroIQFFornecedor, uCadastroIQFParametro, uCadastroIQFPeriodo,
  uCadastroSetonForecast,
  uImportarIQFZMP05, uImportarIQFFornecedor, uUploadForecast, uRelatorioAnaliseIQF, uUploadBOM,
  uUploadCustosEstoque, uUploadRouting, uUploadTaxasHoras, uCalcGM, uCadastroProdutoSeton,
  uUploadProdutoSeton, uRelatorioRecuperacaoContas, uRelatorioGestaoMercados,uRelatorioRecuperacaoClientes,
  uExibeForecast, uDashBoard;

{ TForm3 }

procedure TFr_Brady.cxDBPivotFieldGetStoredProperties(Sender: TObject; AProperties: TStrings);
begin

  AProperties.Add('Caption');

end;

procedure TFr_Brady.cxMaskEditOpcoesDadosPessoalEMailExit(Sender: TObject);
begin

  FDConnection.Open;
  try

    FDQueryTSIS_Usuario.ParamByName('TSIS_USULOG').AsString := WUserName.Trim.ToUpper;
    FDQueryTSIS_Usuario.Close;
    FDQueryTSIS_Usuario.Open;
    try

      FDQueryTSIS_Usuario.Edit;
      FDQueryTSIS_Usuario.FieldByName('TSIS_USUEML').AsString := cxMaskEditOpcoesDadosPessoalEMail.Text;
      FDQueryTSIS_Usuario.Post;

    finally

      FDQueryTSIS_Usuario.Close;

    end;

  finally

    FDConnection.Close;

  end;

end;

procedure TFr_Brady.cxTableViewColumnGetStoredProperties(Sender: TcxCustomGridTableItem; AProperties: TStrings);
begin

  AProperties.Add('Caption');

end;

procedure TFr_Brady.dxBarButtonSetonForecastClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroSetonForecast.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroSetonForecast) then
    Fr_CadastroSetonForecast := TFr_CadastroSetonForecast.Create(Self);

  Fr_CadastroSetonForecast.Visible := True;
  Fr_CadastroSetonForecast.Update;

  LocalAsyncVclCall( @AbrirDataset );
end;

procedure TFr_Brady.dxBarButtonGridToolsExportarExcelClick(Sender: TObject);
begin

  if SaveDialogExportGridExcel.Execute(Handle) then
  begin

    if Assigned(FActivecxTableView) then
      cxGridExportLink.ExportGridToXLSX( SaveDialogExportGridExcel.FileName, (FActivecxTableView.Control as TcxGrid))
    else
      cxExportPivotGridLink.cxExportPivotGridToExcel( SaveDialogExportGridExcel.FileName, FActivecxDBPivot);

  end;

end;

procedure TFr_Brady.dxBarButtonGridToolsLayoutColunaCaptionClick(Sender: TObject);
var
  I: Integer;

begin

  if Assigned(FActivecxTableView) then
  begin

    Fr_UtilColuna := TFr_UtilColuna.Create(Self);
    try

      Fr_UtilColuna.ValueListEditorColumn.Strings.Clear;
      for I := 0 to (FActivecxTableView as TcxGridDBTableView).ColumnCount-1 do
        Fr_UtilColuna.ValueListEditorColumn.Strings.Add( (FActivecxTableView as TcxGridDBTableView).Columns[I].Caption + '=' + (FActivecxTableView as TcxGridDBTableView).Columns[I].Caption );

      if Fr_UtilColuna.ShowModal = mrOk then
      begin

        for I := 0 to (FActivecxTableView as TcxGridDBTableView).ColumnCount-1 do
        begin

          (FActivecxTableView as TcxGridDBTableView).Columns[I].OnGetStoredProperties := cxTableViewColumnGetStoredProperties;
          (FActivecxTableView as TcxGridDBTableView).Columns[I].Caption := Fr_UtilColuna.ValueListEditorColumn.Strings.ValueFromIndex[I];

        end;

        if dxBarButtonGridToolsLayoutSalvar.Visible = ivAlways then
          dxBarButtonGridToolsLayoutSalvar.Click;

      end;

    finally

      FreeAndNil(Fr_UtilColuna);

    end;

  end
  else
  begin

    Fr_UtilColuna := TFr_UtilColuna.Create(Self);
    try

      Fr_UtilColuna.ValueListEditorColumn.Strings.Clear;
      for I := 0 to FActivecxDBPivot.FieldCount-1 do
        Fr_UtilColuna.ValueListEditorColumn.Strings.Add( FActivecxDBPivot.Fields[I].Caption + '=' + FActivecxDBPivot.Fields[I].Caption );

      if Fr_UtilColuna.ShowModal = mrOk then
      begin

        for I := 0 to FActivecxDBPivot.FieldCount-1 do
        begin

          FActivecxDBPivot.Fields[I].OnGetStoredProperties := cxDBPivotFieldGetStoredProperties;
          FActivecxDBPivot.Fields[I].Caption := Fr_UtilColuna.ValueListEditorColumn.Strings.ValueFromIndex[I];

        end;

        if dxBarButtonGridToolsLayoutSalvar.Visible = ivAlways then
          dxBarButtonGridToolsLayoutSalvar.Click;

      end;

    finally

      FreeAndNil(Fr_UtilColuna);

    end;

  end;

end;

procedure TFr_Brady.dxBarButtonGridToolsLayoutSalvarClick(Sender: TObject);
begin

  if Assigned(FActivecxTableView) then
    FActivecxTableView.StoreToIniFile( MyDocumentsPath + '\' + ActiveMDIChild.Name + '_' + FActivecxTableView.Name + '.ini', True, [gsoUseFilter, gsoUseSummary] )
  else
    FActivecxDBPivot.StoreToIniFile( MyDocumentsPath + '\' + ActiveMDIChild.Name + '_' + FActivecxDBPivot.Name + '.ini', True );

end;

procedure TFr_Brady.dxBarButtonGrossMarginImportacaoBOMClick(Sender: TObject);
begin

  if not Assigned(Fr_UploadBOM) then
    Fr_UploadBOM := TFr_UploadBOM.Create(Self);

  Fr_UploadBOM.Visible := True;
  Fr_UploadBOM.Update;

end;

procedure TFr_Brady.dxBarButtonGrossMarginImportacaoCalcularGrossMarginClick(
  Sender: TObject);
begin

  if not Assigned(Fr_CalcGM) then
    Fr_CalcGM := TFr_CalcGM.Create(Self);

  Fr_CalcGM.Visible := True;
  Fr_CalcGM.Update;

end;

procedure TFr_Brady.dxBarButtonGrossMarginImportacaoCustoEstoqueClick(
  Sender: TObject);
begin

  if not Assigned(Fr_UploadCustosEstoque) then
    Fr_UploadCustosEstoque := TFr_UploadCustosEstoque.Create(Self);

  Fr_UploadCustosEstoque.Visible := True;
  Fr_UploadCustosEstoque.Update;

end;

procedure TFr_Brady.dxBarButtonGrossMarginImportacaoRoutingClick(
  Sender: TObject);
begin

  if not Assigned(Fr_UploadRouting) then
    Fr_UploadRouting := TFr_UploadRouting.Create(Self);

  Fr_UploadRouting.Visible := True;
  Fr_UploadRouting.Update;

end;

procedure TFr_Brady.dxBarButtonGrossMarginImportacaoTaxasHorasClick(
  Sender: TObject);
begin

  if not Assigned(Fr_RelatGrossMargin) then
    Fr_RelatGrossMargin := TFr_RelatGrossMargin.Create(Self);

  Fr_RelatGrossMargin.Visible := True;
  Fr_RelatGrossMargin.Update;

end;

procedure TFr_Brady.dxBarButtonSIOPCadastroCanalDeParaClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroDeParaCanal.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroDeParaCanal) then
    Fr_CadastroDeParaCanal := TFr_CadastroDeParaCanal.Create(Self);

  Fr_CadastroDeParaCanal.Visible := True;
  Fr_CadastroDeParaCanal.BringToFront;
  Fr_CadastroDeParaCanal.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;


procedure TFr_Brady.dxBarButtonSIOPCadastroFamiliaClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroFamilia.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroFamilia) then
    Fr_CadastroFamilia := TFr_CadastroFamilia.Create(Self);

  Fr_CadastroFamilia.Visible := True;
  Fr_CadastroFamilia.BringToFront;
  Fr_CadastroFamilia.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonSIOPCadastroFamiliaDeParaClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroDeParaFamilia.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroDeParaFamilia) then
    Fr_CadastroDeParaFamilia := TFr_CadastroDeParaFamilia.Create(Self);

  Fr_CadastroDeParaFamilia.Visible := True;
  Fr_CadastroDeParaFamilia.BringToFront;
  Fr_CadastroDeParaFamilia.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonSIOPCadastroGrupoClienteClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroGrupoCliente.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroGrupoCliente) then
    Fr_CadastroGrupoCliente := TFr_CadastroGrupoCliente.Create(Self);

  Fr_CadastroGrupoCliente.Visible := True;
  Fr_CadastroGrupoCliente.BringToFront;
  Fr_CadastroGrupoCliente.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonSIOPCadastroGrupoClienteDeParaClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroDeParaGrupoCliente.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroDeParaGrupoCliente) then
    Fr_CadastroDeParaGrupoCliente := TFr_CadastroDeParaGrupoCliente.Create(Self);

  Fr_CadastroDeParaGrupoCliente.Visible := True;
  Fr_CadastroDeParaGrupoCliente.BringToFront;
  Fr_CadastroDeParaGrupoCliente.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonSIOPCadastroRepresentanteClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroRepresentante.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroRepresentante) then
    Fr_CadastroRepresentante := TFr_CadastroRepresentante.Create(Self);

  Fr_CadastroRepresentante.Visible := True;
  Fr_CadastroRepresentante.BringToFront;
  Fr_CadastroRepresentante.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonSIOPCadastroRepresentanteDeParaClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroDeParaRepresentante.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroDeParaRepresentante) then
    Fr_CadastroDeParaRepresentante := TFr_CadastroDeParaRepresentante.Create(Self);

  Fr_CadastroDeParaRepresentante.Visible := True;
  Fr_CadastroDeParaRepresentante.BringToFront;
  Fr_CadastroDeParaRepresentante.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonSIOPCadastroSiteDeParaClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroDeParaSite.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroDeParaSite) then
    Fr_CadastroDeParaSite := TFr_CadastroDeParaSite.Create(Self);

  Fr_CadastroDeParaSite.Visible := True;
  Fr_CadastroDeParaSite.BringToFront;
  Fr_CadastroDeParaSite.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonUploadProdutoSetonClick(Sender: TObject);


begin

  if not Assigned(Fr_UploadPodutoSeton) then
    Fr_UploadPodutoSeton := TFr_UploadPodutoSeton.Create(Self);

  Fr_UploadPodutoSeton.Visible := True;
  Fr_UploadPodutoSeton.BringToFront;
  Fr_UploadPodutoSeton.Update;



end;

procedure TFr_Brady.dxBarLargeButtonAdministrativoCadastroMenuClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroMenu.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroMenu) then
    Fr_CadastroMenu := TFr_CadastroMenu.Create(Self);

  Fr_CadastroMenu.Visible := True;
  Fr_CadastroMenu.BringToFront;
  Fr_CadastroMenu.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonAdministrativoCadastroUsuarioClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroUsuario.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroUsuario) then
    Fr_CadastroUsuario := TFr_CadastroUsuario.Create(Self);

  Fr_CadastroUsuario.Visible := True;
  Fr_CadastroUsuario.BringToFront;
  Fr_CadastroUsuario.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonCargaMaquinaCadastroApontamentoClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroApontamento.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroApontamento) then
    Fr_CadastroApontamento := TFr_CadastroApontamento.Create(Self);

  Fr_CadastroApontamento.Visible := True;
  Fr_CadastroApontamento.BringToFront;
  Fr_CadastroApontamento.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonCargaMaquinaCadastroAtividadeClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroAtividade.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroAtividade) then
    Fr_CadastroAtividade := TFr_CadastroAtividade.Create(Self);

  Fr_CadastroAtividade.Visible := True;
  Fr_CadastroAtividade.BringToFront;
  Fr_CadastroAtividade.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonCargaMaquinaCadastroCelulaClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroCelula.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroCelula) then
    Fr_CadastroCelula := TFr_CadastroCelula.Create(Self);

  Fr_CadastroCelula.Visible := True;
  Fr_CadastroCelula.BringToFront;
  Fr_CadastroCelula.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonCargaMaquinaCadastroMaquinaClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroMaquina.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroMaquina) then
    Fr_CadastroMaquina := TFr_CadastroMaquina.Create(Self);

  Fr_CadastroMaquina.Visible := True;
  Fr_CadastroMaquina.BringToFront;
  Fr_CadastroMaquina.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonCargaMaquinaCadastroOperadorClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroOperador.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroOperador) then
    Fr_CadastroOperador := TFr_CadastroOperador.Create(Self);

  Fr_CadastroOperador.Visible := True;
  Fr_CadastroOperador.BringToFront;
  Fr_CadastroOperador.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonCargaMaquinaCadastroSiteClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroSite.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroSite) then
    Fr_CadastroSite := TFr_CadastroSite.Create(Self);

  Fr_CadastroSite.Visible := True;
  Fr_CadastroSite.BringToFront;
  Fr_CadastroSite.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonCargaMaquinaPainelLiderManausClick(Sender: TObject);
begin

  dxSkinController.UseSkins := False;

  if not Assigned(Fr_PainelLider) then
    Fr_PainelLider := TFr_PainelLider.Create(Self);

  Fr_PainelLider.Tambore := False;
  Fr_PainelLider.ClearScreen;
  Fr_PainelLider.Visible := True;
  Fr_PainelLider.BringToFront;
  Fr_PainelLider.Update;

end;

procedure TFr_Brady.dxBarLargeButtonCargaMaquinaPainelLiderTamboreClick(Sender: TObject);
begin

  dxSkinController.UseSkins := False;

  if not Assigned(Fr_PainelLider) then
    Fr_PainelLider := TFr_PainelLider.Create(Self);

  Fr_PainelLider.Tambore := True;
  Fr_PainelLider.ClearScreen;
  Fr_PainelLider.Visible := True;
  Fr_PainelLider.BringToFront;
  Fr_PainelLider.Update;

end;

procedure TFr_Brady.dxBarLargeButtonCargaMaquinaPainelOperadorClick(Sender: TObject);
var
  I: Integer;
begin

  for I := 1 to 4 do
  begin

    if not Assigned(Fr_PainelOperador[I]) then
      Fr_PainelOperador[I] := TFr_PainelOperador.Create(Self);

    Fr_PainelOperador[I].Tag := I;
    Fr_PainelOperador[I].Visible := True;
    Fr_PainelOperador[I].BringToFront;
    Fr_PainelOperador[I].Update;

    Fr_PainelOperador[I].Inicializar;

  end;

end;

procedure TFr_Brady.dxBarLargeButtonCargaMaquinaPainelYNumberClick(Sender: TObject);
begin

  dxSkinController.UseSkins := False;

  if not Assigned(Fr_PainelItem) then
    Fr_PainelItem := TFr_PainelItem.Create(Self);

  //Fr_PainelLider.Tambore := False;
  //Fr_PainelItem.ClearScreen;
  Fr_PainelItem.Visible := True;
  Fr_PainelItem.BringToFront;
  Fr_PainelItem.Update;

end;

procedure TFr_Brady.dxBarLargeButtonCargaMaquinaRelatorioAnaliseApontamentoClick(Sender: TObject);

//  procedure AbrirDataset;
//  begin
//
//    Fr_RelatorioAnaliseApontamento.AbrirDataset;
//
//  end;

begin

  if not Assigned(Fr_RelatorioAnaliseApontamento) then
    Fr_RelatorioAnaliseApontamento := TFr_RelatorioAnaliseApontamento.Create(Self);

  Fr_RelatorioAnaliseApontamento.Visible := True;
  Fr_RelatorioAnaliseApontamento.Update;

//  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonCSConsultaNotaFiscalClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroDetran.AbrirDataset;

  end;

begin

  if not Assigned(Fr_ConsultaNotaFiscal) then
    Fr_ConsultaNotaFiscal := TFr_ConsultaNotaFiscal.Create(Self);

  Fr_ConsultaNotaFiscal.Visible := True;
  Fr_ConsultaNotaFiscal.BringToFront;
  Fr_ConsultaNotaFiscal.Update;

//  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonDetranProcessamentoGerarListaEtiquetaClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroDetran.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroDetran) then
    Fr_CadastroDetran := TFr_CadastroDetran.Create(Self);

  Fr_CadastroDetran.Visible := True;
  Fr_CadastroDetran.BringToFront;
  Fr_CadastroDetran.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonEngenhariaRelatorioUtilizacaoMaquinaClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_RelatorioUtilizacaoMaquina.AbrirDataset;

  end;

begin

  if not Assigned(Fr_RelatorioUtilizacaoMaquina) then
    Fr_RelatorioUtilizacaoMaquina := TFr_RelatorioUtilizacaoMaquina.Create(Self);

  Fr_RelatorioUtilizacaoMaquina.Visible := True;
  Fr_RelatorioUtilizacaoMaquina.BringToFront;
  Fr_RelatorioUtilizacaoMaquina.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonIQFKPIClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_RelatorioAnaliseIQF.AbrirDataset;

  end;

begin

  if not Assigned(Fr_RelatorioAnaliseIQF) then
    Fr_RelatorioAnaliseIQF := TFr_RelatorioAnaliseIQF.Create(Self);

  Fr_RelatorioAnaliseIQF.Visible := True;
  Fr_RelatorioAnaliseIQF.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonInovarCadastroClienteClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroInovarCliente.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroInovarCliente) then
    Fr_CadastroInovarCliente := TFr_CadastroInovarCliente.Create(Self);

  Fr_CadastroInovarCliente.Visible := True;
  Fr_CadastroInovarCliente.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonInovarCadastroNotaFiscalClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroInovarNotaFiscal.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroInovarNotaFiscal) then
    Fr_CadastroInovarNotaFiscal := TFr_CadastroInovarNotaFiscal.Create(Self);

  Fr_CadastroInovarNotaFiscal.Visible := True;
  Fr_CadastroInovarNotaFiscal.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonInovarCadastroCFOPClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroInovarCFOP.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroInovarCFOP) then
    Fr_CadastroInovarCFOP := TFr_CadastroInovarCFOP.Create(Self);

  Fr_CadastroInovarCFOP.Visible := True;
  Fr_CadastroInovarCFOP.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonInovarCadastroParcelaDedutivelClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroInovarParcelaDedutivel.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroInovarParcelaDedutivel) then
    Fr_CadastroInovarParcelaDedutivel := TFr_CadastroInovarParcelaDedutivel.Create(Self);

  Fr_CadastroInovarParcelaDedutivel.Visible := True;
  Fr_CadastroInovarParcelaDedutivel.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonInovarConsultaParcelaDedutivelClick(
  Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_ConsultaInovarParcelaDedutivel.AbrirDataset;

  end;

begin

  if not Assigned(Fr_ConsultaInovarParcelaDedutivel) then
    Fr_ConsultaInovarParcelaDedutivel := TFr_ConsultaInovarParcelaDedutivel.Create(Self);

  Fr_ConsultaInovarParcelaDedutivel.Visible := True;
  Fr_ConsultaInovarParcelaDedutivel.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonIQFCadastroForncedorClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroIQFFornecedor.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroIQFFornecedor) then
    Fr_CadastroIQFFornecedor := TFr_CadastroIQFFornecedor.Create(Self);

  Fr_CadastroIQFFornecedor.Visible := True;
  Fr_CadastroIQFFornecedor.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonIQFCadastroParametrosClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroIQFParametro.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroIQFParametro) then
    Fr_CadastroIQFParametro := TFr_CadastroIQFParametro.Create(Self);

  Fr_CadastroIQFParametro.Visible := True;
  Fr_CadastroIQFParametro.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonIQFCadastroPeriodoClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroIQFPeriodo.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroIQFPeriodo) then
    Fr_CadastroIQFPeriodo := TFr_CadastroIQFPeriodo.Create(Self);

  Fr_CadastroIQFPeriodo.Visible := True;
  Fr_CadastroIQFPeriodo.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonIQFImportacaoFornecedorClick(Sender: TObject);
  procedure AbrirDataset;
  begin

    Fr_ImportarIQFFornecedor.AbrirDataset;

  end;

begin

  if not Assigned(Fr_ImportarIQFFornecedor) then
    Fr_ImportarIQFFornecedor := TFr_ImportarIQFFornecedor.Create(Self);

  Fr_ImportarIQFFornecedor.Visible := True;
  Fr_ImportarIQFFornecedor.Update;

  LocalAsyncVclCall( @AbrirDataset );
end;

procedure TFr_Brady.dxBarButtonIQFImportacaoImportarClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_ImportarIQFZMP05.AbrirDataset;

  end;

begin

  if not Assigned(Fr_ImportarIQFZMP05) then
    Fr_ImportarIQFZMP05 := TFr_ImportarIQFZMP05.Create(Self);

  Fr_ImportarIQFZMP05.Visible := True;
  Fr_ImportarIQFZMP05.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarButtonProdutoClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_CadastroProdutoSeton.AbrirDataset;

  end;

begin

  if not Assigned(Fr_CadastroProdutoSeton) then
    Fr_CadastroProdutoSeton := TFr_CadastroProdutoSeton.Create(Self);

  Fr_CadastroProdutoSeton.Visible := True;
  Fr_CadastroProdutoSeton.BringToFront;
  Fr_CadastroProdutoSeton.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonSIOPDashBoardClick(Sender: TObject);
begin
  if not Assigned(frmExibeDashBoard) then
    frmExibeDashBoard := TfrmExibeDashBoard.Create(Self);

  frmExibeDashBoard.Visible := True;
  frmExibeDashBoard.BringToFront;
  frmExibeDashBoard.Update;

end;

procedure TFr_Brady.dxBarLargeButtonSIOPGestaoMercadoClick(Sender: TObject);
  procedure AbrirDataset;
  begin

    Fr_RelatorioGestaoMercados.AbrirDataset;

  end;

begin

  if not Assigned(Fr_RelatorioGestaoMercados) then
    Fr_RelatorioGestaoMercados := TFr_RelatorioGestaoMercados.Create(Self);

  Fr_RelatorioGestaoMercados.Visible := True;
  Fr_RelatorioGestaoMercados.BringToFront;
  Fr_RelatorioGestaoMercados.Update;

  LocalAsyncVclCall( @AbrirDataset );
end;

procedure TFr_Brady.dxBarLargeButtonSIOPRecuperacaodeClientesClick(
  Sender: TObject);
  procedure AbrirDataset;
  begin

    Fr_RelatorioRecuperacaoClientes.AbrirDataset;

  end;

begin

  if not Assigned(Fr_RelatorioRecuperacaoClientes) then
    Fr_RelatorioRecuperacaoClientes := TFr_RelatorioRecuperacaoClientes.Create(Self);

  Fr_RelatorioRecuperacaoClientes.Visible := True;
  Fr_RelatorioRecuperacaoClientes.BringToFront;
  Fr_RelatorioRecuperacaoClientes.Update;

  LocalAsyncVclCall( @AbrirDataset );


end;

procedure TFr_Brady.dxBarLargeButtonSIOPRecuperacaodeContasClick(
  Sender: TObject);
  procedure AbrirDataset;
  begin

    Fr_RelatorioRecuperacaoContas.AbrirDataset;

  end;

begin

  if not Assigned(Fr_RelatorioRecuperacaoContas) then
    Fr_RelatorioRecuperacaoContas := TFr_RelatorioRecuperacaoContas.Create(Self);

  Fr_RelatorioRecuperacaoContas.Visible := True;
  Fr_RelatorioRecuperacaoContas.BringToFront;
  Fr_RelatorioRecuperacaoContas.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonSIOPRelatorioPartNumberClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_RelatorioPartNumber.AbrirDataset;

  end;

begin

  if not Assigned(Fr_RelatorioPartNumber) then
    Fr_RelatorioPartNumber := TFr_RelatorioPartNumber.Create(Self);

  Fr_RelatorioPartNumber.Visible := True;
  Fr_RelatorioPartNumber.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonSIOPRelatoriosFaturamentoPedidoClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_RelatorioFaturamentoPedidos.AbrirDataset;

  end;

begin

  if not Assigned(Fr_RelatorioFaturamentoPedidos) then
    Fr_RelatorioFaturamentoPedidos := TFr_RelatorioFaturamentoPedidos.Create(Self);

  Fr_RelatorioFaturamentoPedidos.Visible := True;
  Fr_RelatorioFaturamentoPedidos.BringToFront;
  Fr_RelatorioFaturamentoPedidos.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonSIOPRelatoriosForecastClick(
  Sender: TObject);
begin
  {
  if not Assigned(Fr_UploadForecast) then
    Fr_UploadForecast := TFr_UploadForecast.Create(Self);

  Fr_UploadForecast.Visible := True;
  Fr_UploadForecast.BringToFront;
  Fr_UploadForecast.Update;
   }


  if not Assigned(frmExibeForecast) then
    frmExibeForecast := TfrmExibeForecast.Create(Self);

  frmExibeForecast.Visible := True;
  frmExibeForecast.BringToFront;
  frmExibeForecast.Update;

end;

procedure TFr_Brady.dxBarLargeButtonSIOPRelatoriosGrossMarginClick(
  Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_RelatGrossMargin.AbrirDataset;

  end;

begin

  if not Assigned(Fr_RelatGrossMargin) then
    Fr_RelatGrossMargin := TFr_RelatGrossMargin.Create(Self);

  Fr_RelatGrossMargin.Visible := True;
  Fr_RelatGrossMargin.BringToFront;
  Fr_RelatGrossMargin.Update;

  //LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonSIOPRelatoriosVendasClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_RelatorioVendas.AbrirDataset;

  end;

begin

  if not Assigned(Fr_RelatorioVendas) then
    Fr_RelatorioVendas := TFr_RelatorioVendas.Create(Self);

  Fr_RelatorioVendas.Visible := True;
  Fr_RelatorioVendas.BringToFront;
  Fr_RelatorioVendas.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxBarLargeButtonSIOPRelatoriosTabelaPrecoClick(Sender: TObject);

  procedure AbrirDataset;
  begin

    Fr_RelatorioPreco.AbrirDataset;

  end;

begin

  if not Assigned(Fr_RelatorioPreco) then
    Fr_RelatorioPreco := TFr_RelatorioPreco.Create(Self);

  Fr_RelatorioPreco.Visible := True;
  Fr_RelatorioPreco.Update;

  LocalAsyncVclCall( @AbrirDataset );

end;

procedure TFr_Brady.dxRibbonBackstageViewGalleryControlContaItemClick(Sender: TObject;
  AItem: TdxRibbonBackstageViewGalleryItem);
begin

  if not (csLoading in ComponentState) then
  begin

    if dxRibbonBackstageViewGalleryItemContaDadosPessoal.Checked then
    begin

      if not String(cxLabelOpcoesDadosPessoal.Caption).Contains(WUserName.Trim.ToUpper) then
      begin

        FDConnection.Open;
        try

          FDQueryTSIS_Usuario.ParamByName('TSIS_USULOG').AsString := WUserName.Trim.ToUpper;
          FDQueryTSIS_Usuario.Close;
          FDQueryTSIS_Usuario.Open;
          try

            cxLabelOpcoesDadosPessoal.Caption :=
                     FDQueryTSIS_Usuario.FieldByName('TSIS_USUNOM').AsString + ' (' + FDQueryTSIS_Usuario.FieldByName('TSIS_USULOG').AsString + ')';

            cxMaskEditOpcoesDadosPessoalEMail.Text := FDQueryTSIS_Usuario.FieldByName('TSIS_USUEML').AsString;

          finally

            FDQueryTSIS_Usuario.Close;

          end;

        finally

          FDConnection.Close;

        end;

      end;

    end;

    cxScrollBoxControlContaPanel.Visible := dxRibbonBackstageViewGalleryItemContaDadosPessoal.Checked;

  end;

end;

procedure TFr_Brady.dxRibbonBackstageViewGalleryControlOpcoesItemClick(Sender: TObject;
  AItem: TdxRibbonBackstageViewGalleryItem);
begin

  if not (csLoading in ComponentState) then
  begin

    cxScrollBoxControlOpcoesPanel.Visible := dxRibbonBackstageViewGalleryItemOpcoesConexao.Checked;

  end;

end;

procedure TFr_Brady.dxRibbonBackstageViewSISTEMATabChanged(Sender: TObject);
var
  varStrDBParams: TStringList;

begin

  if dxRibbonBackstageViewSISTEMA.ActiveTab = dxRibbonBackstageViewTabSheetConta then
  begin

    dxRibbonBackstageViewGalleryControlConta.Gallery.ClickItem(dxRibbonBackstageViewGalleryItemContaDadosPessoal);

  end
  else
  if dxRibbonBackstageViewSISTEMA.ActiveTab = dxRibbonBackstageViewTabSheetOpcoes then
  begin

    if FileExists( MyDocumentsPath + '\DB.ini') then
    begin

      varStrDBParams := TStringList.Create;
      try

        ValueListEditor.Strings.BeginUpdate;
        try

          ValueListEditor.Strings.LoadFromFile( MyDocumentsPath + '\DB.ini' );

        finally

          ValueListEditor.Strings.EndUpdate;

        end;

      finally

        FreeAndNil(varStrDBParams);

      end;

    end;

  end;

end;

procedure TFr_Brady.dxRibbonBackstageViewSISTEMATabClick(Sender: TObject; ATab: TdxRibbonBackstageViewTabSheet);
begin

  if ATab = dxRibbonBackstageViewTabSheetFechar then
  begin

    Close;

  end;

end;

procedure TFr_Brady.FormCreate(Sender: TObject);
var
  I, X: Integer;
  Y: Integer;

begin

  try

    DisableAero := True;

    FFormatoBR := TFormatSettings.Create;

    FFormatoBR.ThousandSeparator := '.';
    FFormatoBR.DecimalSeparator := ',';
    FFormatoBR.CurrencyDecimals := 2;
    FFormatoBR.DateSeparator := '/';
    FFormatoBR.ShortDateFormat := 'dd/mm/yyyy';
    FFormatoBR.LongDateFormat := 'dd/mm/yyyy';
    FFormatoBR.TimeSeparator := ':';
    FFormatoBR.TimeAMString := 'AM';
    FFormatoBR.TimePMString := 'PM';
    FFormatoBR.ShortTimeFormat := 'hh:mm';
    FFormatoBR.LongTimeFormat := 'hh:mm:ss';
    FFormatoBR.CurrencyString := 'R$ ';
    FormatSettings := FFormatoBR;

    dxRibbonBackstageViewSISTEMA.ActiveTab := dxRibbonBackstageViewTabSheetFechar;

    dxRibbonStatusBar.Panels[1].Text := 'Usu�rio: ' + WUserName.Trim;
    dxRibbonStatusBar.Panels[3].Text := 'Vers�o: ' + uUtils.FileVersion;
    dxRibbonStatusBar.Panels[5].Text := 'M�quina: ' + ComputerName;
    dxRibbonStatusBar.Panels[7].Text := 'Documentos: ' + MyDocumentsPath;

    if not System.IOUtils.TFile.Exists( MyDocumentsPath + '\DB.ini' ) then
      System.IOUtils.TFile.Copy( ExtractFilePath(Application.ExeName) + '\DB.ini' , MyDocumentsPath + '\DB.ini', True );


    FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );

    FDConnection.Open;
    try
      dxRibbonStatusBar.Panels[8].Text := FDConnection.Params[4];
      FDQueryTSIS_Usuario.ParamByName('TSIS_USULOG').AsString := WUserName.Trim.ToUpper;
      FDQueryTSIS_Usuario.Close;
      FDQueryTSIS_Usuario.Open;
      try

        if FDQueryTSIS_Usuario.Eof and FDQueryTSIS_Usuario.Bof then
          raise Exception.Create('Usu�rio ("' + WUserName.Trim.ToUpper + '") n�o existe no sistema.');

        if FDQueryTSIS_UsuarioTSIS_USUATI.AsString.Equals('N') then
          raise Exception.Create('Usu�rio ("' + WUserName.Trim.ToUpper + '") n�o esta ativo no sistema.');

        FPainelOperador := FDQueryTSIS_UsuarioTSIS_USUPRD.AsString.Equals('S');
        FPainelLider := FDQueryTSIS_UsuarioTSIS_USULID.AsString.Equals('S');
        FTSIS_USUCOD := FDQueryTSIS_UsuarioTSIS_USUCOD.AsInteger;
        FTSIS_USUNOM := FDQueryTSIS_UsuarioTSIS_USUNOM.AsString;
        FSalesRep := FDQueryTSIS_UsuarioTSIS_USUSREP.AsString.Equals('S');
        FCustomerService := FDQueryTSIS_UsuarioTSIS_USUCSR.AsString.Equals('S');

      finally

        FDQueryTSIS_Usuario.Close;

      end;

      FDQueryTSIS_Menu.ParamByName('TSIS_USUCOD').AsInteger := TSIS_USUCOD;
      FDQueryTSIS_Menu.Close;
      FDQueryTSIS_Menu.Open;
      try

        dxRibbon.ActiveTab := nil;
        for I := 0 to dxRibbon.TabCount-1 do
        begin

          dxRibbon.Tabs[I].Visible := FDQueryTSIS_Menu.Locate( 'TSIS_MENOBJ', dxRibbon.Tabs[I].Name );
          if dxRibbon.Tabs[I].Visible then
            if not Assigned(dxRibbon.ActiveTab) then
              dxRibbon.ActiveTab := dxRibbon.Tabs[I];

          for X := 0 to dxRibbon.Tabs[I].Groups.Count-1 do
          begin

            dxRibbon.Tabs[I].Groups[X].ToolBar.Visible := FDQueryTSIS_Menu.Locate( 'TSIS_MENOBJ', dxRibbon.Tabs[I].Groups[X].ToolBar.Name );

            for Y := 0 to dxRibbon.Tabs[I].Groups[X].ToolBar.ItemLinks.Count-1 do
            begin

              if FDQueryTSIS_Menu.Locate( 'TSIS_MENOBJ', dxRibbon.Tabs[I].Groups[X].ToolBar.ItemLinks[Y].Item.Name ) then
                dxRibbon.Tabs[I].Groups[X].ToolBar.ItemLinks[Y].Item.Visible := ivAlways
              else
                dxRibbon.Tabs[I].Groups[X].ToolBar.ItemLinks[Y].Item.Visible := ivNever;

            end;

          end;

          for X := 0 to dxRibbonRadialMenu.ItemLinks.Count-1 do
          begin

            if FDQueryTSIS_Menu.Locate( 'TSIS_MENOBJ', dxRibbonRadialMenu.ItemLinks[X].Item.Name ) then
              dxRibbonRadialMenu.ItemLinks[X].Item.Visible := ivAlways
            else
              dxRibbonRadialMenu.ItemLinks[X].Item.Visible := ivNever;

          end;

        end;

      finally

        FDQueryTSIS_Menu.Close;

      end;

    finally

      FDConnection.Close;

    end;

  except

    on E: Exception do
    begin

      Application.MessageBox( PWideChar(E.Message), 'N�o foi possivel acessar o sistema', MB_ICONERROR+MB_OK );
      Application.Terminate;

    end;

  end;

end;

procedure TFr_Brady.PopupGridTools( pActivecxTableView: TcxCustomGridView );
begin

  if pActivecxTableView is TcxGridDBTableView then
  begin

    FActivecxDBPivot := nil;
    FActivecxTableView := pActivecxTableView;
    dxRibbonRadialMenu.PopupFromCursorPos;

  end;

end;

procedure TFr_Brady.PopupPivotTools(pActivecxDBPivot: TcxDBPivotGrid);
begin

  FActivecxTableView := nil;
  FActivecxDBPivot := pActivecxDBPivot;
  dxRibbonRadialMenu.PopupFromCursorPos;

end;

procedure TFr_Brady.ValueListEditorStringsChange(Sender: TObject);
var
  varStrDBParams: TStringList;

begin

  varStrDBParams := TStringList.Create;
  try

    varStrDBParams.AddStrings(ValueListEditor.Strings);
    varStrDBParams.SaveToFile( MyDocumentsPath + '\DB.ini' );

  finally

    FreeAndNil(varStrDBParams);

  end;

end;

end.
