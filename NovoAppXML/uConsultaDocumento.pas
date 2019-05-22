unit uConsultaDocumento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
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
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, cxButtons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, ShellApi,
  cxGridExportLink, Clipbrd ;

type
  TfrmConsultaDocumento = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    editCNPJ: TLabeledEdit;
    EditDocumento: TLabeledEdit;
    Page: TPageControl;
    TabNFe: TTabSheet;
    TabCTe: TTabSheet;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid2: TcxGrid;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    GroupBox1: TGroupBox;
    DataIni: TDateTimePicker;
    DataFim: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    sqlConsultaNFE: TFDQuery;
    sqlConsultaCTE: TFDQuery;
    dsConsultaNFE: TDataSource;
    dsConsultaCTE: TDataSource;
    sqlConsultaNFETipoXML: TStringField;
    sqlConsultaNFENumero: TStringField;
    sqlConsultaNFESerie: TStringField;
    sqlConsultaNFENatOp: TStringField;
    sqlConsultaNFEdhEmi: TSQLTimeStampField;
    sqlConsultaNFECNPJEmitente: TStringField;
    sqlConsultaNFEEmitente: TStringField;
    sqlConsultaNFECNPJDEstinatario: TStringField;
    sqlConsultaNFEDestinatario: TStringField;
    sqlConsultaNFECHAVE: TStringField;
    sqlConsultaNFEValor: TBCDField;
    cxGrid1DBTableView1Numero: TcxGridDBColumn;
    cxGrid1DBTableView1Serie: TcxGridDBColumn;
    cxGrid1DBTableView1NatOp: TcxGridDBColumn;
    cxGrid1DBTableView1dhEmi: TcxGridDBColumn;
    cxGrid1DBTableView1CNPJEmitente: TcxGridDBColumn;
    cxGrid1DBTableView1Emitente: TcxGridDBColumn;
    cxGrid1DBTableView1CNPJDEstinatario: TcxGridDBColumn;
    cxGrid1DBTableView1Destinatario: TcxGridDBColumn;
    cxGrid1DBTableView1CHAVE: TcxGridDBColumn;
    cxGrid1DBTableView1Valor: TcxGridDBColumn;
    sqlConsultaCTETipoXML: TStringField;
    sqlConsultaCTENumero: TStringField;
    sqlConsultaCTESerie: TStringField;
    sqlConsultaCTENatOp: TStringField;
    sqlConsultaCTEdhEmi: TSQLTimeStampField;
    sqlConsultaCTECNPJEmitente: TStringField;
    sqlConsultaCTEEmitente: TStringField;
    sqlConsultaCTECNPJDestinatario: TStringField;
    sqlConsultaCTEDestinatario: TStringField;
    sqlConsultaCTECNPJTomador: TStringField;
    sqlConsultaCTETomador: TStringField;
    sqlConsultaCTECHAVE: TStringField;
    sqlConsultaCTEValor: TBCDField;
    cxGrid2DBTableView1Numero: TcxGridDBColumn;
    cxGrid2DBTableView1Serie: TcxGridDBColumn;
    cxGrid2DBTableView1NatOp: TcxGridDBColumn;
    cxGrid2DBTableView1dhEmi: TcxGridDBColumn;
    cxGrid2DBTableView1CNPJEmitente: TcxGridDBColumn;
    cxGrid2DBTableView1Emitente: TcxGridDBColumn;
    cxGrid2DBTableView1CNPJDestinatario: TcxGridDBColumn;
    cxGrid2DBTableView1Destinatario: TcxGridDBColumn;
    cxGrid2DBTableView1CNPJTomador: TcxGridDBColumn;
    cxGrid2DBTableView1Tomador: TcxGridDBColumn;
    cxGrid2DBTableView1CHAVE: TcxGridDBColumn;
    cxGrid2DBTableView1Valor: TcxGridDBColumn;
    sqlConsultaNFEDESC_PLANTA: TStringField;
    cxGrid1DBTableView1DESC_PLANTA: TcxGridDBColumn;
    sqlConsultaCTEDESC_PLANTA: TStringField;
    cxGrid2DBTableView1DESC_PLANTA: TcxGridDBColumn;
    SaveDialog: TSaveDialog;
    Panel3: TPanel;
    ButPesquisar: TcxButton;
    cxButton3: TcxButton;
    btnLimpar: TcxButton;
    ButSair: TcxButton;
    sqlConsultaNFEObservacao: TStringField;
    sqlConsultaCTEObservacao: TStringField;
    cxGrid1DBTableView1Observacao: TcxGridDBColumn;
    cxGrid2DBTableView1Observacao: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    CopiarChaveNFe1: TMenuItem;
    CopiarChaveCTe1: TMenuItem;
    cxButton1: TcxButton;
    pnlDica: TPanel;
    Memo1: TMemo;
    Panel4: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxGrid2DBTableView1DblClick(Sender: TObject);
    procedure cxGrid1DBTableView1DblClick(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure ButSairClick(Sender: TObject);
    procedure CopiarChaveNFe1Click(Sender: TObject);
    procedure CopiarChaveCTe1Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaDocumento: TfrmConsultaDocumento;

implementation

{$R *.dfm}

uses DBConect;

procedure TfrmConsultaDocumento.btnLimparClick(Sender: TObject);
begin
  Page.ActivePage := TabNFe;
  editCNPJ.Text := '';
  EditDocumento.Text := '';
  DataIni.Date := Now-7;
  DataFim.Date := Now;
  sqlConsultaNFE.Close;
  sqlConsultaCTE.Close;
end;

procedure TfrmConsultaDocumento.ButPesquisarClick(Sender: TObject);
Var
 Filtro : String;
begin

   Filtro := ' Where dhEmi between :DataINI and :DataFIM';

  if editCNPJ.Text <> '' then
  begin
      Filtro := Filtro + ' AND CNPJEmitente = :CNPJEmitente ';
  end;
  if EditDocumento.Text <> '' then
  begin
     Filtro := Filtro + ' AND NUMERO = :Numero ';
  end;

  Screen.Cursor := crHourGlass;

  if Page.ActivePage = TabNFe then
  begin
    sqlConsultaNFE.Close;
    sqlConsultaNFE.SQL.Clear;
    sqlConsultaNFE.SQL.Add('Select * From VW_NFE ');
    sqlConsultaNFE.SQL.Add(Filtro);

    sqlConsultaNFE.Params.ParamByName('DataINI').AsDateTime :=  DataIni.DateTime;
    sqlConsultaNFE.Params.ParamByName('DataFIM').AsDateTime :=  DataFim.DateTime;
    if editCNPJ.Text <> '' then
       sqlConsultaNFE.Params.ParamByName('CNPJEmitente').AsString :=  editCNPJ.Text;
    if EditDocumento.Text <> '' then
       sqlConsultaNFE.Params.ParamByName('Numero').AsString :=  EditDocumento.Text;
    sqlConsultaNFE.Open;

    if sqlConsultaNFE.IsEmpty then
      Application.MessageBox('Dados de NF-e n�o encontrados.', 'Consultar - NF-e', mb_iconinformation +  MB_OK);



  end
  else if Page.ActivePage = TabCTe then
       begin
          sqlConsultaCTE.Close;
          sqlConsultaCTE.SQL.Clear;
          sqlConsultaCTE.SQL.Add('Select * From VW_CTE');
          sqlConsultaCTE.SQL.Add(Filtro);
          sqlConsultaCTE.Params.ParamByName('DataINI').AsDateTime :=  DataIni.DateTime;
          sqlConsultaCTE.Params.ParamByName('DataFIM').AsDateTime :=  DataFim.DateTime;
          if editCNPJ.Text <> '' then
             sqlConsultaCTE.Params.ParamByName('CNPJEmitente').AsString := editCNPJ.Text;
          if EditDocumento.Text <> '' then
             sqlConsultaCTE.Params.ParamByName('Numero').AsString :=  EditDocumento.Text;
          sqlConsultaNFE.Open;

          sqlConsultaCTE.Open;

          if sqlConsultaCTE.IsEmpty then
             Application.MessageBox('Dados de CT-e n�o encontrados.', 'Consultar - CT-e', mb_iconinformation +  MB_OK);

       end;
  Screen.Cursor := crDefault;
end;

procedure TfrmConsultaDocumento.ButSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConsultaDocumento.CopiarChaveCTe1Click(Sender: TObject);
begin
  Clipboard.AsText := sqlConsultaCTECHAVE.AsString;
end;

procedure TfrmConsultaDocumento.CopiarChaveNFe1Click(Sender: TObject);
begin
  Clipboard.AsText := sqlConsultaNFECHAVE.AsString;
end;

procedure TfrmConsultaDocumento.cxButton1Click(Sender: TObject);
begin
   pnlDica.Visible := not pnlDica.Visible;
end;

procedure TfrmConsultaDocumento.cxButton3Click(Sender: TObject);
begin

  SaveDialog.InitialDir := GetCurrentDir;
  if Page.ActivePage = TabNFe then
  begin
    if sqlConsultaNFE.IsEmpty then
    begin
        Application.MessageBox('N�o h� dados de NF-e para serem exportados.', 'Exportar para Excel - NFe', mb_iconinformation +  MB_OK);
        Exit;
    end;

    if SaveDialog.Execute then
       ExportGridToExcel(SaveDialog.FileName, cxGrid1, True, True);
  end
  else
  begin

    if sqlConsultaCTE.IsEmpty then
    begin
        Application.MessageBox('N�o h� dados de CT-e para serem exportados.', 'Exportar para Excel - CTe', mb_iconinformation +  MB_OK);
        Exit;
    end;

    if SaveDialog.Execute then
       ExportGridToExcel(SaveDialog.FileName, cxGrid2, True, True);
  end;
end;

procedure TfrmConsultaDocumento.cxGrid1DBTableView1DblClick(Sender: TObject);
Var
 sURL : String;
 sChave : String;
begin
  //sURL := 'http://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=&nfe=' + sqlConsultaNFECHAVE.AsString;
  sChave := '';
  if Clipboard.HasFormat(CF_TEXT) then
    sChave := Clipboard.AsText;

  if Length(sChave) <> 44 then
     MessageDlg('Tamanho da Chave NF-e Incompativel', mtInformation, [mbOK], 0)
  else
  begin
    sURL := 'https://www.danfeonline.com.br/';
    ShellExecute(Handle,'open',pChar(sURL),nil,nil,SW_SHOW)
  end
end;

procedure TfrmConsultaDocumento.cxGrid2DBTableView1DblClick(Sender: TObject);
Var
 sURL : String;
 sChave : String;
begin

  sChave := '';
  if Clipboard.HasFormat(CF_TEXT) then
    sChave := Clipboard.AsText;

  if Length(sChave) <> 44 then
     MessageDlg('Tamanho da Chave CT-e Incompativel', mtInformation, [mbOK], 0)
  else
  begin
    sURL := 'https://www.danfeonline.com.br/';
    ShellExecute(Handle,'open',pChar(sURL),nil,nil,SW_SHOW)
  end

end;

procedure TfrmConsultaDocumento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Self := NIL;
end;

procedure TfrmConsultaDocumento.FormCreate(Sender: TObject);
begin
  Page.ActivePage := TabNFe;
  DataIni.Date := Now-7;
  DataFim.Date := Now;
  editCNPJ.Text := '';
end;

procedure TfrmConsultaDocumento.FormShow(Sender: TObject);
begin
// pnlDica.Left := (Self.Width - pnlDica.Width) div 2;
// pnlDica.Top := (Self.Height - pnlDica.Height) div 2;
end;

end.
