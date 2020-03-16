unit uEditoEmail;

interface

uses
  System.IOUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Activex, MsHtml, dxSkinsCore,
  dxSkinOffice2013White, dxSkinscxPCPainter, dxBarBuiltInMenu, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxPC, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.ImgList, Vcl.ToolWin, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw, Vcl.Menus,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB,
  cxDBData, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Comp.Client, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, cxLabel, dxGDIPlusClasses, uUtils, cxCheckBox, Vcl.Mask,
  Vcl.DBCtrls, cxEditRepositoryItems, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
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
  dxSkinWhiteprint, dxSkinXmas2008Blue, IdMessage, IdBaseComponent, IdMailBox;

type
  TFr_EditoEmail = class(TForm)
    cxSmallImages: TcxImageList;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ColorDialog: TColorDialog;
    cxPage: TcxPageControl;
    cxTabCadastro: TcxTabSheet;
    cxTabEditor: TcxTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    WebBrowser: TWebBrowser;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    btnNovo: TToolButton;
    btnAbrir: TToolButton;
    btnSalvar: TToolButton;
    ToolButton4: TToolButton;
    btnNegrito: TToolButton;
    BtnItalico: TToolButton;
    BtnSublinhado: TToolButton;
    BtnCor: TToolButton;
    ToolButton8: TToolButton;
    BtnEsquerda: TToolButton;
    btnCentro: TToolButton;
    BtnDireita: TToolButton;
    ToolButton9: TToolButton;
    BtnMarcador: TToolButton;
    BtnNumeracao: TToolButton;
    BtnRecuo: TToolButton;
    BtnAvanco: TToolButton;
    BtnImagem: TToolButton;
    ToolBar2: TToolBar;
    BtnCortar: TToolButton;
    BtnCopiar: TToolButton;
    BtnColar: TToolButton;
    ToolButton18: TToolButton;
    BtnDesfazer: TToolButton;
    BtnLink: TToolButton;
    cxGridTemplate: TcxGrid;
    cxTableViewTemplate: TcxGridDBTableView;
    cxGridLevelTemplate: TcxGridLevel;
    FDConnection: TFDConnection;
    FDQueryTSOP_Template: TFDQuery;
    DataSourceTSOP_Template: TDataSource;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    FDQueryTSOP_TemplateTSOP_MKT_TEMPLATE_ID: TFDAutoIncField;
    FDQueryTSOP_TemplateTSOP_TITULO: TStringField;
    FDQueryTSOP_TemplateTSOP_CAMINHO: TStringField;
    FDQueryTSOP_TemplateTSOP_ARQUIVO: TStringField;
    FDQueryTSOP_TemplateTSOP_ATIVO: TStringField;
    FDQueryTSOP_TemplateTSIS_USUCOD: TIntegerField;
    FDQueryTSOP_TemplateTSOP_DATACAD: TSQLTimeStampField;
    cxTableViewTemplateTSOP_MKT_TEMPLATE_ID: TcxGridDBColumn;
    cxTableViewTemplateTSOP_TITULO: TcxGridDBColumn;
    cxTableViewTemplateTSOP_ATIVO: TcxGridDBColumn;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    cxEditRepository1: TcxEditRepository;
    cxEditRepository1ButtonItem1: TcxEditRepositoryButtonItem;
    cxTableViewTemplateColumn1: TcxGridDBColumn;
    FDQueryTSOP_TemplateTSOP_ARQFISICO: TMemoField;
    Label1: TLabel;
    comboFont: TComboBox;
    Label2: TLabel;
    comboSize: TComboBox;
    FDQueryTSOP_TemplateTSOP_CAMPANHA_ID: TSmallintField;
    cxTableViewTemplateTSOP_CAMPANHA_ID: TcxGridDBColumn;
    cxTableViewTemplateTSOP_BODY: TcxGridDBColumn;
    FDQueryTSOP_TemplateTSOP_ANEXO: TStringField;
    IdMailBox1: TIdMailBox;
    IdMessage1: TIdMessage;
    procedure comboSizeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNegritoClick(Sender: TObject);
    procedure BtnItalicoClick(Sender: TObject);
    procedure BtnSublinhadoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnCorClick(Sender: TObject);
    procedure BtnNumeracaoClick(Sender: TObject);
    procedure BtnMarcadorClick(Sender: TObject);
    procedure BtnRecuoClick(Sender: TObject);
    procedure BtnAvancoClick(Sender: TObject);
    procedure BtnEsquerdaClick(Sender: TObject);
    procedure btnCentroClick(Sender: TObject);
    procedure BtnDireitaClick(Sender: TObject);
    procedure BtnImagemClick(Sender: TObject);
    procedure BtnCortarClick(Sender: TObject);
    procedure BtnCopiarClick(Sender: TObject);
    procedure BtnColarClick(Sender: TObject);
    procedure BtnDesfazerClick(Sender: TObject);
    procedure BtnLinkClick(Sender: TObject);
    procedure comboFontChange(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAbrirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure WebBrowserDocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
    procedure FDQueryTSOP_TemplateAfterEdit(DataSet: TDataSet);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure FDQueryTSOP_TemplateNewRecord(DataSet: TDataSet);
    procedure cxEditRepository1ButtonItem1PropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    procedure DocumentoEmBranco(WebBrowser: TWebBrowser);
    procedure CarregarArquivo(varNomeArq : String);
    function GetIEHandle(WebBrowser: TWebbrowser; ClassName: string): HWND;
    procedure Mensagem(pMensagem: String);
    { Private declarations }
  public
    { Public declarations }
    procedure AbrirDataset;
    procedure LoadGridCustomization;

  end;

var
  Fr_EditoEmail: TFr_EditoEmail;
  HTMLDocumento: IHTMLDocument2;
const
  IDM_MARCADOR = 2184;
  IDM_MARCADOR_LISTA = 2185;
  IDM_OUTDENT = 2187;
  IDM_INDENT = 2186;
  IDM_ALINHARESQ = 59;
  IDM_CENTRALIZAR = 57;
  IDM_ALINHADIR = 60;
  IDM_IMAGEM = 2168;
  IDM_LINHAHORIZ = 2150;
  IDM_RECORTAR = 16;
  IDM_COPIAR = 15;
  IDM_COLAR = 26;
  IDM_HYPERLINK = 2124;
  IDM_DESFAZER = 43;

implementation

{$R *.dfm}

uses uBrady;

procedure TFr_EditoEmail.btnAbrirClick(Sender: TObject);
begin
  {se o Opendialog for executado e o kara selecionar um arquivo ent�o navegaaaa webbrowser rsrsr.}
  if OpenDialog.Execute=true then
  begin
   CarregarArquivo(OpenDialog.FileName);
   FDQueryTSOP_Template.Edit;
   FDQueryTSOP_TemplateTSOP_CAMINHO.AsString := ExtractFilePath(OpenDialog.FileName);
   FDQueryTSOP_TemplateTSOP_ARQUIVO.AsString := ExtractFileName(OpenDialog.FileName);
   FDQueryTSOP_Template.Post;
  end
  else
    abort;
end;

procedure TFr_EditoEmail.BtnAvancoClick(Sender: TObject);
begin
  SendMessage(GetIEHandle(webbrowser, 'Internet Explorer_Server'),
  WM_COMMAND,IDM_INDENT, 0);
end;

procedure TFr_EditoEmail.btnCentroClick(Sender: TObject);
begin
  SendMessage(GetIEHandle(webbrowser, 'Internet Explorer_Server'),
  WM_COMMAND,IDM_CENTRALIZAR, 0);
end;

procedure TFr_EditoEmail.BtnColarClick(Sender: TObject);
begin
  SendMessage(GetIEHandle(webbrowser, 'Internet Explorer_Server'),
  WM_COMMAND,IDM_COLAR, 0);
end;

procedure TFr_EditoEmail.BtnCopiarClick(Sender: TObject);
begin
  SendMessage(GetIEHandle(webbrowser, 'Internet Explorer_Server'),
  WM_COMMAND,IDM_COPIAR, 0)
end;

procedure TFr_EditoEmail.BtnCorClick(Sender: TObject);
begin
  HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
  if Colordialog.Execute then
    HTMLDocumento.execCommand('ForeColor', False,ColorDialog.Color)
  else
    abort;
end;

procedure TFr_EditoEmail.BtnCortarClick(Sender: TObject);
begin
  SendMessage(GetIEHandle(webbrowser, 'Internet Explorer_Server'),
  WM_COMMAND,IDM_RECORTAR, 0);
end;

procedure TFr_EditoEmail.BtnDesfazerClick(Sender: TObject);
begin
  SendMessage(GetIEHandle(webbrowser, 'Internet Explorer_Server'),
  WM_COMMAND,IDM_DESFAZER,0);
end;

procedure TFr_EditoEmail.BtnDireitaClick(Sender: TObject);
begin
  SendMessage(GetIEHandle(webbrowser, 'Internet Explorer_Server'),
  WM_COMMAND,IDM_ALINHADIR, 0);
end;

procedure TFr_EditoEmail.BtnEsquerdaClick(Sender: TObject);
begin
  SendMessage(GetIEHandle(webbrowser, 'Internet Explorer_Server'),
  WM_COMMAND,IDM_ALINHARESQ, 0);
end;

procedure TFr_EditoEmail.BtnImagemClick(Sender: TObject);
begin
  SendMessage(GetIEHandle(webbrowser, 'Internet Explorer_Server'),
  WM_COMMAND,IDM_IMAGEM, 0);
end;

procedure TFr_EditoEmail.BtnItalicoClick(Sender: TObject);
begin
  HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
  HTMLDocumento.execCommand('Italic', False,0);
end;

procedure TFr_EditoEmail.BtnLinkClick(Sender: TObject);
begin
  SendMessage(GetIEHandle(webbrowser, 'Internet Explorer_Server'),
  WM_COMMAND,IDM_HYPERLINK,0);
end;

procedure TFr_EditoEmail.BtnMarcadorClick(Sender: TObject);
begin
  SendMessage(GetIEHandle(webbrowser, 'Internet Explorer_Server'),
  WM_COMMAND,IDM_MARCADOR_LISTA, 0);
end;

procedure TFr_EditoEmail.btnNegritoClick(Sender: TObject);
begin
  {Estamos usando nossa Vari�vel global declarada anteriormente.}

  {Aqui estamos dizendo que HTMLDocumento = A Interface que comanda o design do webbrowser, a interface que ir� inserir em seu texto selecionado um negrito... italico..}
  HTMLDocumento := WebBrowser.Document as IHTMLDocument2;

  {Estamos falando oq queremos aplicar no texto selecionado, ent�o dizemos Bold ou seja Negrito}
  HTMLDocumento.execCommand('Bold', False,0);
end;

procedure TFr_EditoEmail.btnNovoClick(Sender: TObject);
begin
 DocumentoEmBranco(webbrowser);
end;

procedure TFr_EditoEmail.BtnNumeracaoClick(Sender: TObject);
begin
  SendMessage(GetIEHandle(webbrowser, 'Internet Explorer_Server'),
  WM_COMMAND,IDM_MARCADOR, 0);
end;

procedure TFr_EditoEmail.BtnRecuoClick(Sender: TObject);
begin
SendMessage(GetIEHandle(webbrowser, 'Internet Explorer_Server'),
WM_COMMAND,IDM_OUTDENT, 0);
end;

procedure TFr_EditoEmail.btnSalvarClick(Sender: TObject);
var
 HTMLDocument: IHTMLDocument2;
 PersistFile : IPersistFile;
begin
  HTMLDocument := WebBrowser.Document as IHTMLDocument2;
  if SaveDialog.Execute=true then
  begin
   PersistFile := HTMLDocument as IPersistFile;
   PersistFile.Save(StringToOleStr(savedialog.FileName), System.True);
   FDQueryTSOP_Template.Edit;
   FDQueryTSOP_TemplateTSOP_CAMINHO.AsString := ExtractFilePath(savedialog.FileName);
   FDQueryTSOP_TemplateTSOP_ARQUIVO.AsString := ExtractFileName(savedialog.FileName);
   FDQueryTSOP_Template.Post;
  end
  else
  begin
   abort;
  end;
end;

procedure TFr_EditoEmail.BtnSublinhadoClick(Sender: TObject);
begin
  HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
  HTMLDocumento.execCommand('Underline', False,0);
end;

procedure TFr_EditoEmail.CarregarArquivo(varNomeArq: String);
begin
  Fr_EditoEmail.Caption := 'Editor HTML';
  webbrowser.Navigate(varNomeArq);
  Fr_EditoEmail.Caption := Fr_EditoEmail.Caption + '-  Arquivo: ' + varNomeArq;
end;

procedure TFr_EditoEmail.comboFontChange(Sender: TObject);
begin
  HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
  HTMLDocumento.execCommand('FontName', False,ComboFont.Text);
  {no lugar de ComboFonte.text, coloque o nome de seu combobox das fontes}
end;

procedure TFr_EditoEmail.comboSizeChange(Sender: TObject);
begin
   //altera o tamanho da fonte
   HTMLDocumento := WebBrowser.Document as IHTMLDocument2;
    case Combosize.ItemIndex of
      0: HTMLDocumento.execCommand('FontSize', False,1);
      1: HTMLDocumento.execCommand('FontSize', False,2);
      2: HTMLDocumento.execCommand('FontSize', False,3);
      3: HTMLDocumento.execCommand('FontSize', False,5);
      4: HTMLDocumento.execCommand('FontSize', False,6);
      5: HTMLDocumento.execCommand('FontSize', False,7);
    end;
end;

procedure TFr_EditoEmail.cxEditRepository1ButtonItem1PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
   cxPage.ActivePage :=  cxTabEditor;
   if ((FDQueryTSOP_TemplateTSOP_CAMINHO.AsString <> '') and (FDQueryTSOP_TemplateTSOP_ARQUIVO.AsString <> '' )) then
     CarregarArquivo(FDQueryTSOP_TemplateTSOP_CAMINHO.AsString  + FDQueryTSOP_TemplateTSOP_ARQUIVO.AsString)
   else
     btnNovoClick(Nil);

end;

function TFr_EditoEmail.GetIEHandle(WebBrowser: TWebbrowser; ClassName: string): HWND;
var
  hwndChild, hwndTmp: HWND;
  oleCtrl: TOleControl;
  szClass: array [0..255] of char;
begin
  oleCtrl :=WebBrowser;
  hwndTmp := oleCtrl.Handle;
  while (true) do
  begin
    hwndChild := GetWindow(hwndTmp, GW_CHILD);
    GetClassName(hwndChild, szClass, SizeOf(szClass));
    if (string(szClass)=ClassName) then
    begin
      Result :=hwndChild;
      Exit;
    end;
  hwndTmp := hwndChild;
  end;
  Result := 0;
end;

procedure TFr_EditoEmail.WebBrowserDocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
begin
   ((ASender as TWebBrowser).Document as IHTMLDocument2).designMode := 'on';
end;

procedure TFr_EditoEmail.DocumentoEmBranco(WebBrowser: TWebBrowser);
begin
  WebBrowser.Navigate('about:blank');
  Fr_EditoEmail.Caption := 'Editor HTML';
end;

procedure TFr_EditoEmail.FDQueryTSOP_TemplateAfterEdit(DataSet: TDataSet);
begin
  FDQueryTSOP_TemplateTSIS_USUCOD.AsInteger := Fr_Brady.TSIS_USUCOD;
  FDQueryTSOP_TemplateTSOP_DATACAD.AsDateTime := Now;
end;

procedure TFr_EditoEmail.FDQueryTSOP_TemplateNewRecord(DataSet: TDataSet);
begin
  FDQueryTSOP_TemplateTSIS_USUCOD.AsInteger := Fr_Brady.TSIS_USUCOD;
  FDQueryTSOP_TemplateTSOP_DATACAD.AsDateTime := Now;
end;

procedure TFr_EditoEmail.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  FDQueryTSOP_Template.Close;
  FDConnection.Close;

  Fr_EditoEmail := Nil;
  Action := caFree;
end;

procedure TFr_EditoEmail.FormContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  Fr_Brady.PopupGridTools( cxGridTemplate.ActiveView );
end;

procedure TFr_EditoEmail.FormCreate(Sender: TObject);
begin
  LoadGridCustomization;

  //Navega em uma p�gina em Branco (About:Blank)
  DocumentoEmBranco(webbrowser);

  {altera o modo design do webbrowse para ON, ou seja, toda p�gina que abrirmos poderemos alterar, selecionar, excluir .. inserir ...}
  (WebBrowser.Document as IHTMLDocument2).designMode := 'On';

  {Insere todas as fontes instalados no computador dentro do combobox}

  combofont.Items := screen.Fonts;

  {verifique o nome correto do combobox que receber� as fontes.}

  cxPage.ActivePage := cxTabCadastro;
end;



procedure TFr_EditoEmail.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;


procedure TFr_EditoEmail.AbrirDataset;
begin

  if not FDConnection.Connected then
  begin

    Mensagem( 'Abrindo conex�o...' );
    try

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

      Mensagem( 'Obtendo dados (Templates de E-mails)...' );
      FDQueryTSOP_Template.Open;

    finally

      Mensagem( EmptyStr );

    end;

  end;

end;

procedure TFr_EditoEmail.LoadGridCustomization;
begin

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\' + Name + '_' + cxTableViewTemplate.Name + '.ini' ) then
    cxTableViewTemplate.RestoreFromIniFile( MyDocumentsPath + '\' + Name + '_' + cxTableViewTemplate.Name + '.ini' );

end;


end.