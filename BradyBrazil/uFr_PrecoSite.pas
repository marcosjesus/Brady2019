unit uFr_PrecoSite;

interface

uses
  uUtils,
  dxSpreadSheet,
  dxSpreadSheetTypes,
  dxSpreadSheetCore,
  cxCurrencyEdit,
  cxGridDBDataDefinitions,
  cxGridExportLink,
  System.Math,
  ACBrMail,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinOffice2013White,
  dxSkinscxPCPainter, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, cxPC, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxGridBandedTableView, cxGridDBBandedTableView, cxContainer,
  Vcl.Menus, Vcl.StdCtrls, cxButtons, cxTextEdit, cxMaskEdit, cxButtonEdit,
  cxLabel, Vcl.ExtCtrls, dxGDIPlusClasses, dxSkinBlack, dxSkinBlue,
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
  dxSkinWhiteprint, dxSkinXmas2008Blue, ACBrBase, ACBrDFe, ACBrNFe;

type
  TFr_PrecoSite = class(TForm)
    Page: TcxPageControl;
    TabGrid: TcxTabSheet;
    FDConnection: TFDConnection;
    FDQueryConsultaPreco: TFDQuery;
    dsQueryConsultaPreco: TDataSource;
    cxGrid1: TcxGrid;
    cxGrid1DBBandedTableView1: TcxGridDBBandedTableView;
    cxGrid1Level1: TcxGridLevel;
    Panel1: TPanel;
    cxLabel4: TcxLabel;
    cxButtonEditPath: TcxButtonEdit;
    SaveDialog: TSaveDialog;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    cxLabel9: TcxLabel;
    cxButtonEditPathPreco: TcxButtonEdit;
    btnImportar: TcxButton;
    btnExportar: TcxButton;
    FDConnectionSQL: TFDConnection;
    FDSalvaPlanilha: TFDQuery;
    tabEditar: TcxTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtYNumber: TEdit;
    edtCatalogo: TEdit;
    Autorizado: TcxCurrencyEdit;
    Platino: TcxCurrencyEdit;
    Bronze: TcxCurrencyEdit;
    Prata: TcxCurrencyEdit;
    Ouro: TcxCurrencyEdit;
    Label8: TLabel;
    edtDescricao: TEdit;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    FDQueryGravaPreco: TFDQuery;
    FDQueryTSOP_EMAIL: TFDQuery;
    Shape1: TShape;
    Label9: TLabel;
    Ouro_PEI_Bronze: TcxCurrencyEdit;
    Label10: TLabel;
    Ouro_PEI_Prata: TcxCurrencyEdit;
    Label11: TLabel;
    Prata_PEI_Bronze: TcxCurrencyEdit;
    Label12: TLabel;
    Prata_PEI_Ouro: TcxCurrencyEdit;
    Label13: TLabel;
    PrecoSugerido: TcxCurrencyEdit;
    procedure AddColumnGrid1;
    procedure cxButtonEditPathClick(Sender: TObject);
    procedure Mensagem(pMensagem: String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExportarClick(Sender: TObject);
    procedure cxButtonEditPathPrecoClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure cxGrid1DBBandedTableView1DblClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure PageChange(Sender: TObject);
  private
    { Private declarations }
    varDoubleClick : Boolean;
    ABand: TcxGridBand;
    varProCod : Integer;
    procedure WritelnMail(varStr: String);
  public
    { Public declarations }
      procedure AbrirDataset;
  end;

var
  Fr_PrecoSite: TFr_PrecoSite;

implementation

{$R *.dfm}

uses uBrady;



procedure TFr_PrecoSite.AbrirDataset;
begin
  Page.ActivePage := TabGrid;
  if not FDConnection.Connected then
  begin

    Mensagem( 'Abrindo conex�o...' );
    try

     if not  FDConnection.Connected then
     begin
       FDConnection.Close;
       FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB-MySQL.ini' );
       FDConnection.Open;
     end;


     Mensagem('Aguarde, Consulta Banco de dados do Site...');

     FDQueryConsultaPreco.Close;
     FDQueryConsultaPreco.Open;
     AddColumnGrid1;

    finally

      Mensagem( EmptyStr );

    end;

  end;
end;

procedure TFr_PrecoSite.AddColumnGrid1;
var
  AColumn: TcxGridDBBandedColumn;
  I : Integer;
  sumItem: TcxDataSummaryItem;
begin
  cxGrid1DBBandedTableView1.BeginUpdate();
  cxGrid1DBBandedTableView1.DataController.CreateAllItems;



  try

    ABand := cxGrid1DBBandedTableView1.Bands.Add;
    ABand.Index := 0;
    ABand.HeaderAlignmentHorz := taCenter;
    ABand.Caption := 'Tabela de Pre�o - Seton';
    ABand.FixedKind := fkLeft;



    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Cod. SAP';
    AColumn.DataBinding.FieldName := FDQueryConsultaPreco.Fields[1].FieldName;
    AColumn.Position.BandIndex := 0;
    cxGrid1DBBandedTableView1.DataController.Summary.FooterSummaryItems.Add
        (AColumn, spFooter, skCount, '####');

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 120;
    AColumn.Caption := 'Cod. Cat';
    AColumn.DataBinding.FieldName := FDQueryConsultaPreco.Fields[2].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 535;
    AColumn.Caption := 'Descri��o do Produto';
    AColumn.DataBinding.FieldName := FDQueryConsultaPreco.Fields[3].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'SALDO';
    AColumn.DataBinding.FieldName := FDQueryConsultaPreco.Fields[14].FieldName;
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Sugerido Vendas';
    AColumn.DataBinding.FieldName := FDQueryConsultaPreco.Fields[4].FieldName;
    AColumn.Position.BandIndex := 0;
      AColumn.PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Autorizado';
    AColumn.DataBinding.FieldName := FDQueryConsultaPreco.Fields[5].FieldName;
    AColumn.Position.BandIndex := 0;
      AColumn.PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Platino';
    AColumn.DataBinding.FieldName := FDQueryConsultaPreco.Fields[6].FieldName;
    AColumn.Position.BandIndex := 0;
      AColumn.PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Bronze';
    AColumn.DataBinding.FieldName := FDQueryConsultaPreco.Fields[7].FieldName;
    AColumn.Position.BandIndex := 0;
       AColumn.PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Prata';
    AColumn.DataBinding.FieldName := FDQueryConsultaPreco.Fields[8].FieldName;
    AColumn.Position.BandIndex := 0;
      AColumn.PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';



     AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Ouro';
    AColumn.DataBinding.FieldName := FDQueryConsultaPreco.Fields[9].FieldName;
    AColumn.Position.BandIndex := 0;
      AColumn.PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';

     AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Ouro_PEI_Bronze';
    AColumn.DataBinding.FieldName := FDQueryConsultaPreco.Fields[10].FieldName;
    AColumn.Position.BandIndex := 0;
      AColumn.PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';

     AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Ouro_PEI_Prata';
    AColumn.DataBinding.FieldName := FDQueryConsultaPreco.Fields[11].FieldName;
    AColumn.Position.BandIndex := 0;
      AColumn.PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';

      AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Prata_PEI_Bronze';
    AColumn.DataBinding.FieldName := FDQueryConsultaPreco.Fields[12].FieldName;
    AColumn.Position.BandIndex := 0;
      AColumn.PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';

      AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Prata_PEI_Ouro';
    AColumn.DataBinding.FieldName := FDQueryConsultaPreco.Fields[13].FieldName;
    AColumn.Position.BandIndex := 0;
      AColumn.PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(AColumn.Properties).DisplayFormat :=
      'R$,0.00;(R$,0.00)';





    cxGrid1DBBandedTableView1.OptionsView.Footer := True;
    cxGrid1DBBandedTableView1.OptionsView.GroupFooters := gfVisibleWhenExpanded;
    cxGrid1DBBandedTableView1.OptionsView.GroupFooterMultiSummaries := True;

    cxGrid1DBBandedTableView1.DataController.DataSource := dsQueryConsultaPreco;


  finally
    cxGrid1DBBandedTableView1.EndUpdate;
  end;


end;

procedure TFr_PrecoSite.btnExportarClick(Sender: TObject);
begin
   if FDQueryConsultaPreco.IsEmpty then
      raise Exception.Create('N�o h� informa��es para exportar ao exportar ao Excel ') ;


    if cxButtonEditPath.Text = EmptyStr then
       raise Exception.Create('Informe o nome arquivo primeiro.');

    Screen.Cursor := crHourGlass;
    Try
        Mensagem('Aguarde, Salvando Planilha...');

        ExportGridToExcel(cxButtonEditPath.Text, cxGrid1, True, True);
        MessageDlg( pChar( 'Planilha exportada em  ' + ExtractFilePath(cxButtonEditPath.Text) )  , mtInformation, [ mbOk ], 0 );

    Finally
        Mensagem( EmptyStr );
        Screen.Cursor := crDefault;
    End;
end;

procedure TFr_PrecoSite.btnImportarClick(Sender: TObject);
var
  I: Integer;

  dxSpreadSheet        : TdxSpreadSheet;


  varColumnYNumber     : Integer;
  varColumnCatalogo    : Integer;
  varColumnUN          : Integer;
  varColumnQtde_Itens  : Integer;
  varColumnQtde_Minima : Integer;
  varColumnFamilia     : Integer;
  varColumnDescricao   : Integer;
  varColumnSug_Venda   : Integer;

  varColumnAutorizado        : Integer;
  varColumnPlatino           : Integer;
  varColumnBronze            : Integer;
  varColumnPrata             : Integer;
  varColumnOuro              : Integer;
  varColumnOuro_PEI_Prata    : Integer;
  varColumnOuro_PEI_Bronze   : Integer;
  varColumnPrata_PEI_Bronze  : Integer;
  varColumnPrata_PEI_Ouro    : Integer;


  varTMKT_PROCOD       : Integer;
  varYNumber           : String;
  varCatalogo          : String;
  varUN                : String;
  varQtde_Itens        : String;
  varQtde_Minima       : String;
  varFamilia           : String;
  varDescricao         : String;

  varSug_Venda               : Extended;
  varTabelaAutorizado        : Extended;
  varTabelaPlatino           : Extended;
  varTabelaBronze            : Extended;
  varTabelaPrata             : Extended;
  varTabelaOuro              : Extended;
  varTabelaOuro_PEI_Prata    : Extended;
  varTabelaOuro_PEI_Bronze   : Extended;
  varTabelaPrata_PEI_Bronze  : Extended;
  varTabelaPrata_PEI_Ouro    : Extended;

  varUltimaColuna      : Integer;
  varStringList        : TStringList;
  varStringList2       : TStringList;


begin
  Mensagem('Import Tabela de Pre�o TMKT');

  Mensagem('Apagando arquivo. ' +  MyDocumentsPath+'\'+ExtractFileName(cxButtonEditPathPreco.Text) );
  DeleteFile(PWideChar(MyDocumentsPath+'\'+ExtractFileName(cxButtonEditPathPreco.Text)));

  Mensagem('Copiando arquivo local. ' +  cxButtonEditPathPreco.Text + ' para: ' + MyDocumentsPath );
  CopyFile( PWideChar(cxButtonEditPathPreco.Text), PWideChar(MyDocumentsPath+'\'+ExtractFileName(cxButtonEditPathPreco.Text)), True );


  dxSpreadSheet := TdxSpreadSheet.Create(nil);
  try

    Mensagem('Lendo Planilha ' +  MyDocumentsPath+'\'+ExtractFileName(cxButtonEditPathPreco.Text));
    dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\'+ExtractFileName(cxButtonEditPathPreco.Text) );

    varColumnYNumber     := -1;
    varColumnCatalogo    := -1;
    varColumnUN          := -1;
    varColumnQtde_Itens  := -1;
    varColumnQtde_Minima := -1;
    varColumnFamilia     := -1;
    varColumnDescricao   := -1;
    varColumnSug_Venda   := -1;

    varColumnAutorizado        := -1;
    varColumnPlatino           := -1;
    varColumnBronze            := -1;
    varColumnPrata             := -1;
    varColumnOuro              := -1;
    varColumnOuro_PEI_Prata    := -1;
    varColumnOuro_PEI_Bronze   := -1;
    varColumnPrata_PEI_Bronze  := -1;
    varColumnPrata_PEI_Ouro    := -1;


    varUltimaColuna := 11;
    Mensagem('Descobrindo Colunas');
    for I := dxSpreadSheet.ActiveSheetAsTable.Columns.FirstIndex to varUltimaColuna do
    begin

      if not  Assigned(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0]) then
         Continue;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'YNUMBER' then
        varColumnYNumber := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'CATALOGO' then
        varColumnCatalogo := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'UN' then
        varColumnUN := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'QTDE_ITENS' then
        varColumnQtde_Itens := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'QTDE_MINIMA' then
        varColumnQtde_Minima := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'FAMILIA' then
        varColumnFamilia := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'DESCRICAO' then
        varColumnDescricao := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'SUG_VENDAS' then
        varColumnSug_Venda := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'Autorizado' then
        varColumnAutorizado := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'Platino' then
        varColumnPlatino := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'Bronze' then
        varColumnBronze := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'Prata' then
        varColumnPrata := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'Ouro' then
        varColumnOuro := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'Ouro_PEI_Bronze' then
        varColumnOuro_PEI_Bronze := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'Ouro_PEI_Prata' then
        varColumnOuro_PEI_Prata := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'Prata_PEI_Bronze' then
        varColumnPrata_PEI_Bronze := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'Prata_PEI_Ouro' then
        varColumnPrata_PEI_Ouro := I;


    end;

    if varColumnYNumber = -1 then
       raise Exception.Create( 'Coluna (YNumber) n�o foi encontrada' );
    if varColumnCatalogo = -1 then
      raise Exception.Create( 'Coluna (Catalogo) n�o foi encontrada' );
    if varColumnUN = -1 then
      raise Exception.Create( 'Coluna (UN) n�o foi encontrada' );
    if varColumnQtde_Itens = -1 then
      raise Exception.Create( 'Coluna (Qtde_Itens) n�o foi encontrada' );
    if varColumnQtde_Minima = -1 then
      raise Exception.Create( 'Coluna (Qtde_Minima) n�o foi encontrada' );
    if varColumnFamilia = -1 then
      raise Exception.Create( 'Coluna (Familia) n�o foi encontrada' );
    if varColumnDescricao = -1 then
      raise Exception.Create( 'Coluna (Descricao) n�o foi encontrada' );
    if varColumnSug_Venda = -1 then
      raise Exception.Create( 'Coluna (Sug_Venda) n�o foi encontrada' );


    if varColumnAutorizado = -1 then
      raise Exception.Create( 'Coluna (Autorizado) n�o foi encontrada' );
    if varColumnPlatino = -1 then
      raise Exception.Create( 'Coluna (Platino) n�o foi encontrada' );
    if varColumnBronze = -1 then
      raise Exception.Create( 'Coluna (Bronze) n�o foi encontrada' );
    if varColumnPrata = -1 then
      raise Exception.Create( 'Coluna (Prata) n�o foi encontrada' );
    if varColumnOuro = -1 then
      raise Exception.Create( 'Coluna (Ouro) n�o foi encontrada' );
    if varColumnOuro_PEI_Prata = -1 then
      raise Exception.Create( 'Coluna (Ouro_PEI_Prata) n�o foi encontrada' );
    if varColumnOuro_PEI_Bronze = -1 then
      raise Exception.Create( 'Coluna (Ouro_PEI_Bronze) n�o foi encontrada' );
    if varColumnPrata_PEI_Bronze = -1 then
      raise Exception.Create( 'Coluna (Prata_PEI_Bronze) n�o foi encontrada' );
    if varColumnPrata_PEI_Ouro = -1 then
      raise Exception.Create( 'Coluna (Prata_PEI_Ouro) n�o foi encontrada' );


    Mensagem( 'Criando DataModule' );

    try


        Mensagem('Config FDConnection');
        FDConnectionSQL.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );

        Mensagem('Open FDConnection');
        FDConnectionSQL.Open;
        varStringList := TStringList.Create;
        varStringList.Add('Pesquisa Por Ynumber + Catalogo');
        varStringList2 := TStringList.Create;
        varStringList2.Add('Pesquisa Por Ynumber');
        try

            Mensagem('Looping pelas linhas');


            for I := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
            begin

              Mensagem( 'Linhas ('+ IntToStr(I-1) + '/' + IntToStr(dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex-1) + ')' );

              varYNumber     := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnYNumber].AsString);
              varCatalogo    := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnCatalogo].AsString);
              varUN          := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnUN].AsString);
              varQtde_Itens  := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnQtde_Itens].AsString);
              varQtde_Minima := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnQtde_Minima].AsString);
              varFamilia     := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFamilia].AsString);
              varDescricao   := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDescricao].AsString);

              varSug_Venda   := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnSug_Venda].AsFloat,-2);


              varTabelaAutorizado       := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnAutorizado].AsFloat,-2);
              varTabelaPlatino          := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnPlatino].AsFloat,-2);
              varTabelaBronze           := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnBronze].AsFloat,-2);
              varTabelaPrata            := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnPrata].AsFloat,-2);
              varTabelaOuro             := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnOuro].AsFloat,-2);
              varTabelaOuro_PEI_Prata   := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnOuro_PEI_Prata].AsFloat,-2);
              varTabelaOuro_PEI_Bronze  := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnOuro_PEI_Bronze].AsFloat,-2);
              varTabelaPrata_PEI_Bronze := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnPrata_PEI_Bronze].AsFloat,-2);
              varTabelaPrata_PEI_Ouro   := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnPrata_PEI_Ouro].AsFloat,-2);


               if  FDQueryConsultaPreco.Locate('TMKT_PROCODSAP;TMKT_PROCODCAT',VarArrayOf([varYNumber, varCatalogo]) , [loPartialKey]) Then
               begin
                   if RoundTo(FDQueryConsultaPreco.FieldByName('Autorizado').AsFloat,-2) <>  varTabelaAutorizado then
                      varStringList.Add('YNumber:' + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Autorizado: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Autorizado').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaAutorizado));

                   if RoundTo(FDQueryConsultaPreco.FieldByName('Platino').AsFloat,-2) <>  varTabelaPlatino then
                      varStringList.Add('YNumber:' + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Platino: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Platino').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaPlatino));

                   if RoundTo(FDQueryConsultaPreco.FieldByName('Bronze').AsFloat,-2) <>  varTabelaBronze then
                      varStringList.Add('YNumber:' + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Bronze: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Bronze').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaBronze));

                   if RoundTo(FDQueryConsultaPreco.FieldByName('Prata').AsFloat,-2) <>  varTabelaPrata then
                      varStringList.Add('YNumber:'  + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Prata: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Prata').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaPrata));

                   if RoundTo(FDQueryConsultaPreco.FieldByName('Ouro').AsFloat,-2) <>  varTabelaOuro then
                      varStringList.Add('YNumber:' + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Ouro: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Ouro').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaOuro));


                   if RoundTo(FDQueryConsultaPreco.FieldByName('Ouro_PEI_Prata').AsFloat,-2) <>  varTabelaOuro_PEI_Prata then
                      varStringList.Add('YNumber:' + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Ouro_PEI_Prata: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Ouro_PEI_Prata').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaOuro_PEI_Prata));

                   if RoundTo(FDQueryConsultaPreco.FieldByName('Ouro_PEI_Bronze').AsFloat,-2) <>  varTabelaOuro_PEI_Bronze then
                      varStringList.Add('YNumber:'  + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Ouro_PEI_Bronze: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Ouro_PEI_Bronze').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaOuro_PEI_Bronze));


                   if RoundTo(FDQueryConsultaPreco.FieldByName('Prata_PEI_Bronze').AsFloat,-2) <>  varTabelaPrata_PEI_Bronze then
                      varStringList.Add('YNumber:' + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Prata_PEI_Bronze: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Prata_PEI_Bronze').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaPrata_PEI_Bronze));


                   if RoundTo(FDQueryConsultaPreco.FieldByName('Prata_PEI_Ouro').AsFloat,-2) <>  varTabelaPrata_PEI_Ouro then
                      varStringList.Add('YNumber:'  + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Prata_PEI_Ouro: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Prata_PEI_Ouro').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaPrata_PEI_Ouro));


                    if RoundTo(FDQueryConsultaPreco.FieldByName('PrecoSugerido').AsFloat,-2) <>  varSug_Venda then
                      varStringList.Add('YNumber:'  + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Sugerido: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('PrecoSugerido').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varSug_Venda));


               end;


               if  FDQueryConsultaPreco.Locate('TMKT_PROCODSAP', varYNumber , [loPartialKey]) Then
               begin
                   if RoundTo(FDQueryConsultaPreco.FieldByName('Autorizado').AsFloat,-2) <>  varTabelaAutorizado then
                      varStringList.Add('YNumber:' + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Autorizado: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Autorizado').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaAutorizado));

                   if RoundTo(FDQueryConsultaPreco.FieldByName('Platino').AsFloat,-2) <>  varTabelaPlatino then
                      varStringList.Add('YNumber:' + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Platino: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Platino').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaPlatino));

                   if RoundTo(FDQueryConsultaPreco.FieldByName('Bronze').AsFloat,-2) <>  varTabelaBronze then
                      varStringList.Add('YNumber:' + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Bronze: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Bronze').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaBronze));

                   if RoundTo(FDQueryConsultaPreco.FieldByName('Prata').AsFloat,-2) <>  varTabelaPrata then
                      varStringList.Add('YNumber:'  + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Prata: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Prata').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaPrata));

                   if RoundTo(FDQueryConsultaPreco.FieldByName('Ouro').AsFloat,-2) <>  varTabelaOuro then
                      varStringList.Add('YNumber:' + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Ouro: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Ouro').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaOuro));


                   if RoundTo(FDQueryConsultaPreco.FieldByName('Ouro_PEI_Prata').AsFloat,-2) <>  varTabelaOuro_PEI_Prata then
                      varStringList.Add('YNumber:' + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Ouro_PEI_Prata: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Ouro_PEI_Prata').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaOuro_PEI_Prata));

                   if RoundTo(FDQueryConsultaPreco.FieldByName('Ouro_PEI_Bronze').AsFloat,-2) <>  varTabelaOuro_PEI_Bronze then
                      varStringList.Add('YNumber:'  + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Ouro_PEI_Bronze: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Ouro_PEI_Bronze').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaOuro_PEI_Bronze));


                   if RoundTo(FDQueryConsultaPreco.FieldByName('Prata_PEI_Bronze').AsFloat,-2) <>  varTabelaPrata_PEI_Bronze then
                      varStringList.Add('YNumber:' + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Prata_PEI_Bronze: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Prata_PEI_Bronze').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaPrata_PEI_Bronze));


                   if RoundTo(FDQueryConsultaPreco.FieldByName('Prata_PEI_Ouro').AsFloat,-2) <>  varTabelaPrata_PEI_Ouro then
                      varStringList.Add('YNumber:'  + varYNumber + ';Catalogo:' + varCatalogo + ';Valor Site Prata_PEI_Ouro: ' + FloatToStr( RoundTo(FDQueryConsultaPreco.FieldByName('Prata_PEI_Ouro').AsFloat,-2)) +
                            ';Valor Planilha: ' + FloatToStr(varTabelaPrata_PEI_Ouro));


               end;

              {
              FDSalvaPlanilha.Close;
              FDSalvaPlanilha.SQL.Clear;
              FDSalvaPlanilha.SQL.Add('INSERT INTO dbo.TSOP_PlanilhaSeton  ');
              FDSalvaPlanilha.SQL.Add('(ColumnYNumber ');
              FDSalvaPlanilha.SQL.Add(',ColumnCatalogo');
              FDSalvaPlanilha.SQL.Add(',ColumnUN ');
              FDSalvaPlanilha.SQL.Add(',ColumnQtde_Itens ');
              FDSalvaPlanilha.SQL.Add(',ColumnQtde_Minima ');
              FDSalvaPlanilha.SQL.Add(',ColumnFamilia ');
              FDSalvaPlanilha.SQL.Add(',ColumnDescricao ');
              FDSalvaPlanilha.SQL.Add(',ColumnSug_Venda ');
              FDSalvaPlanilha.SQL.Add(',ColumnTabela_A ');
              FDSalvaPlanilha.SQL.Add(',ColumnTabela_B ');
              FDSalvaPlanilha.SQL.Add(',ColumnTabela_C ');
              FDSalvaPlanilha.SQL.Add(',ColumnTabela_D)');
              FDSalvaPlanilha.SQL.Add(' Values ');

              FDSalvaPlanilha.SQL.Add('(:ColumnYNumber ');
              FDSalvaPlanilha.SQL.Add(',:ColumnCatalogo ');
              FDSalvaPlanilha.SQL.Add(',:ColumnUN ');
              FDSalvaPlanilha.SQL.Add(',:ColumnQtde_Itens ');
              FDSalvaPlanilha.SQL.Add(',:ColumnQtde_Minima ');
              FDSalvaPlanilha.SQL.Add(',:ColumnFamilia ');
              FDSalvaPlanilha.SQL.Add(',:ColumnDescricao ');
              FDSalvaPlanilha.SQL.Add(',:ColumnSug_Venda ');
              FDSalvaPlanilha.SQL.Add(',:ColumnTabela_A  ');
              FDSalvaPlanilha.SQL.Add(',:ColumnTabela_B ');
              FDSalvaPlanilha.SQL.Add(',:ColumnTabela_C ');
              FDSalvaPlanilha.SQL.Add(',:ColumnTabela_D)  ');


              FDSalvaPlanilha.Params.ParamByName('ColumnYNumber').AsString      := varYNumber;
              FDSalvaPlanilha.Params.ParamByName('ColumnCatalogo').AsString     := varCatalogo;
              FDSalvaPlanilha.Params.ParamByName('ColumnUN').AsString           := varUN;
              FDSalvaPlanilha.Params.ParamByName('ColumnQtde_Itens').AsString   := varQtde_Itens;
              FDSalvaPlanilha.Params.ParamByName('ColumnQtde_Minima').AsString  := varQtde_Minima;
              FDSalvaPlanilha.Params.ParamByName('ColumnFamilia').AsString      := varFamilia;
              FDSalvaPlanilha.Params.ParamByName('ColumnDescricao').AsString    := varDescricao;
              FDSalvaPlanilha.Params.ParamByName('ColumnSug_Venda').AsFloat     := varSug_Venda;
              FDSalvaPlanilha.Params.ParamByName('ColumnTabela_A').AsFloat      := varTabela_A;
              FDSalvaPlanilha.Params.ParamByName('ColumnTabela_B').AsFloat      := varTabela_B;
              FDSalvaPlanilha.Params.ParamByName('ColumnTabela_C').AsFloat      := varTabela_C;
              FDSalvaPlanilha.Params.ParamByName('ColumnTabela_D').AsFloat      := varTabela_D;



              Try
               FDSalvaPlanilha.ExecSQL;
              except
                on E: Exception do
                  begin

                    ShowMessage( 'Salvar Pre�o: ' + E.Message );

                  end;
              End;

              }
            end;

            if varStringList.Count > 0 then
              varStringList.SaveToFile(ExtractFilePath(cxButtonEditPathPreco.Text) +'\Pesquisa_YNumber_Catalogo.csv');

            if varStringList2.Count > 0 then
              varStringList2.SaveToFile(ExtractFilePath(cxButtonEditPathPreco.Text) +'\Pesquisa_YNumber.csv');

        finally

          FDConnectionSQL.Close;
          FreeAndNil(varStringList);
          FreeAndNil(varStringList2);
          Mensagem( EmptyStr );
        end;


    finally


    // Mensagem('Apagando arquivo local. ' +  MyDocumentsPath+'\'+ExtractFileName(cxButtonEditPathPreco.Text));
    //  DeleteFile( PWideChar( MyDocumentsPath+'\'+ExtractFileName(cxButtonEditPathPreco.Text)));

    end;

  finally
    FreeAndNil(dxSpreadSheet);
  end;
end;



procedure TFr_PrecoSite.WritelnMail( varStr: String );
  var
    varACBrNFe: TACBrNFe;
    varACBrMail: TACBrMail;
    varMensagem: TStringList;
    varCC: TStringList;

  begin


    varCC := TStringList.Create;
    varMensagem := TStringList.Create;
    varACBrNFe := TACBrNFe.Create(nil);
    varACBrMail := TACBrMail.Create(nil);
    varACBrNFe.MAIL := varACBrMail;
    try

      if not FDConnectionSQL.Connected then
      begin

        Mensagem('Config FDConnection');
        FDConnectionSQL.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );

      end;
      varMensagem.Add( varStr );

      varACBrMail.Clear;
      varACBrMail.Host := 'smtp.gmail.com';
      varACBrMail.Port := '465';
      varACBrMail.SetSSL := True;
      varACBrMail.SetTLS := False;

      varACBrMail.Username := 'suportebrasil@bradycorp.com';
      varACBrMail.Password := 'spUhurebRuF5';

      varACBrMail.From := 'suportebrasil@bradycorp.com';
      varACBrMail.FromName := 'SUPORTE BRASIL';

      FDQueryTSOP_EMAIL.Close;
      FDQueryTSOP_EMAIL.SQL.Clear;
      FDQueryTSOP_EMAIL.SQL.Add('Select TSOP_EMAIL From TSOP_EMAIL where TSOP_ATIVO = ''S'' AND');
      FDQueryTSOP_EMAIL.SQL.Add(' TSOP_PROGRAMA = ''TSOP_ALTERAPRECOSITESETON''');
      FDQueryTSOP_EMAIL.Open;
      FDQueryTSOP_EMAIL.First;
      while not FDQueryTSOP_EMAIL.eof do
      begin
        varACBrMail.AddAddress(FDQueryTSOP_EMAIL.FieldByName('TSOP_EMAIL').AsString);
        FDQueryTSOP_EMAIL.Next;
      end;
      FDQueryTSOP_EMAIL.Close;

      varACBrMail.Subject := '[SITE SETON] ALTERA��O DO PRE�O DO PRODUTO ' + FormatDateTime( 'dd/mm/yyyy', Now );
      varACBrMail.IsHTML := True;
      varACBrMail.AltBody.Text := varMensagem.Text;

      try

        varACBrMail.Send;

      except

        on E: Exception do
        begin

          Writeln( E.Message );

        end;

      end;

    finally

      FreeAndNil(varACBrNFe);
      FreeAndNil(varACBrMail);
      FreeAndNil(varMensagem);
      FreeAndNil(varCC);

      Mensagem( EmptyStr );

    end;

  end;


procedure TFr_PrecoSite.cxButton1Click(Sender: TObject);
var
   varEnviarEmail : TStringList;
begin


   if messagedlg(pchar('Confirma Altera��o do Pre�o do Produto '+ edtYNumber.Text  +' ?') ,mtConfirmation,[mbyes,mbno],0) = mrYes then
   begin

        Mensagem('Aguarde...');
       if not FDConnection.Connected then
       begin
         FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB-MySQL.ini' );
         FDConnection.Open;
       end;

       varEnviarEmail := TStringList.Create;
       varEnviarEmail.Clear;
       Try
         varEnviarEmail.Add('Produto : ' + edtYNumber.Text );
         varEnviarEmail.Add('Catalogo : ' + edtCatalogo.Text );
         varEnviarEmail.Add('Descri��o : ' + edtDescricao.Text );
         varEnviarEmail.Add('' );
         varEnviarEmail.Add('Altera��o do Pre�o em : '  + DateTimeToStr(Now()));
         varEnviarEmail.Add('Por: '  + Fr_Brady.TSIS_USUNOM );


         varEnviarEmail.Add('-------------------------------' );
         varEnviarEmail.Add('Pre�o Antigo' );


         varEnviarEmail.Add(' Valor Sugerido : ' + FloatToStr(RoundTo(FDQueryConsultaPreco.FieldByName('PrecoSugerido').AsFloat,-2)));
         varEnviarEmail.Add(' Valor Autorizado : ' + FloatToStr(RoundTo(FDQueryConsultaPreco.FieldByName('Autorizado').AsFloat,-2)));
         varEnviarEmail.Add(' Valor Platino : ' + FloatToStr(RoundTo(FDQueryConsultaPreco.FieldByName('Platino').AsFloat,-2)));
         varEnviarEmail.Add(' Valor Bronze : ' + FloatToStr(RoundTo(FDQueryConsultaPreco.FieldByName('Bronze').AsFloat,-2)));
         varEnviarEmail.Add(' Valor Prata : ' + FloatToStr(RoundTo(FDQueryConsultaPreco.FieldByName('Prata').AsFloat,-2)));
         varEnviarEmail.Add(' Valor Ouro : ' + FloatToStr(RoundTo(FDQueryConsultaPreco.FieldByName('Ouro').AsFloat,-2)));

         varEnviarEmail.Add(' Valor Ouro_PEI_Bronze : ' + FloatToStr(RoundTo(FDQueryConsultaPreco.FieldByName('Ouro_PEI_Bronze').AsFloat,-2)));
         varEnviarEmail.Add(' Valor Ouro_PEI_Prata : ' + FloatToStr(RoundTo(FDQueryConsultaPreco.FieldByName('Ouro_PEI_Prata').AsFloat,-2)));
         varEnviarEmail.Add(' Valor Prata_PEI_Bronze : ' + FloatToStr(RoundTo(FDQueryConsultaPreco.FieldByName('Prata_PEI_Bronze').AsFloat,-2)));
         varEnviarEmail.Add(' Valor Prata_PEI_Ouro : ' + FloatToStr(RoundTo(FDQueryConsultaPreco.FieldByName('Prata_PEI_Ouro').AsFloat,-2)));




         varEnviarEmail.Add('-------------------------------' );
         varEnviarEmail.Add('' );
         varEnviarEmail.Add('Pre�o Novo' );
         varEnviarEmail.Add(' Valor Sugerido : ' + FloatToStr(RoundTo(PrecoSugerido.Value,-2)));

         varEnviarEmail.Add(' Valor Autorizado : ' + FloatToStr(RoundTo(Autorizado.Value,-2)));
         varEnviarEmail.Add(' Valor Platino : ' + FloatToStr(RoundTo(Platino.Value,-2)));
         varEnviarEmail.Add(' Valor Bronze : ' + FloatToStr(RoundTo(Bronze.Value,-2)));
         varEnviarEmail.Add(' Valor Prata : ' + FloatToStr(RoundTo(Prata.Value,-2)));
         varEnviarEmail.Add(' Valor Ouro : ' + FloatToStr(RoundTo(Ouro.Value,-2)));

         varEnviarEmail.Add(' Valor Ouro_PEI_Bronze : ' + FloatToStr(RoundTo(Ouro_PEI_Bronze.Value,-2)));
         varEnviarEmail.Add(' Valor Ouro_PEI_Prata : ' + FloatToStr(RoundTo(Ouro_PEI_Prata.Value,-2)));
         varEnviarEmail.Add(' Valor Prata_PEI_Bronze : ' + FloatToStr(RoundTo(Prata_PEI_Bronze.Value,-2)));
         varEnviarEmail.Add(' Valor Prata_PEI_Ouro : ' + FloatToStr(RoundTo(Prata_PEI_Ouro.Value,-2)));



         varEnviarEmail.Add('-------------------------------' );
         varEnviarEmail.Add('' );
         varEnviarEmail.Add('Feito por S&OP' );



         FDQueryGravaPreco.Close;
         FDQueryGravaPreco.SQL.Clear;
         FDQueryGravaPreco.SQL.Add('Update TMKT_PRECO');
         FDQueryGravaPreco.SQL.Add('Set TMKT_PRELIQCOM = :TMKT_PRELIQCOM, TMKT_PRESUGVEN = :TMKT_PRESUGVEN');
         FDQueryGravaPreco.SQL.Add('Where TMKT_PROCOD = :TMKT_PROCOD and TMKT_PRECAT = :TMKT_PRECAT');
         FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger  := varProCod;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString   := 'Autorizado';
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat := Autorizado.Value;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat := PrecoSugerido.Value;

         Try
           FDQueryGravaPreco.ExecSQL;
         except
            on E: Exception do
              begin
                 Application.MessageBox( pchar('Valor Autorizado - ' + E.Message) , 'S&OP', MB_ICONERROR );
              end;
         End;

         FDQueryGravaPreco.Close;
         FDQueryGravaPreco.SQL.Clear;
         FDQueryGravaPreco.SQL.Add('Update TMKT_PRECO');
         FDQueryGravaPreco.SQL.Add('Set TMKT_PRELIQCOM = :TMKT_PRELIQCOM, TMKT_PRESUGVEN = :TMKT_PRESUGVEN');
         FDQueryGravaPreco.SQL.Add('Where TMKT_PROCOD = :TMKT_PROCOD and TMKT_PRECAT = :TMKT_PRECAT');
         FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger  := varProCod;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString   := 'Platino';
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat := Platino.Value;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat := PrecoSugerido.Value;;

         Try
           FDQueryGravaPreco.ExecSQL;
         except
            on E: Exception do
              begin
                 Application.MessageBox( pChar('Valor Platino - ' + E.Message) , 'S&OP', MB_ICONERROR );
              end;
         End;

         FDQueryGravaPreco.Close;
         FDQueryGravaPreco.SQL.Clear;
         FDQueryGravaPreco.SQL.Add('Update TMKT_PRECO');
         FDQueryGravaPreco.SQL.Add('Set TMKT_PRELIQCOM = :TMKT_PRELIQCOM, TMKT_PRESUGVEN = :TMKT_PRESUGVEN');
         FDQueryGravaPreco.SQL.Add('Where TMKT_PROCOD = :TMKT_PROCOD and TMKT_PRECAT = :TMKT_PRECAT');
         FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger  := varProCod;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString   := 'Bronze';
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat := Bronze.Value;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat := PrecoSugerido.Value;;

         Try
           FDQueryGravaPreco.ExecSQL;
         except
            on E: Exception do
              begin

                Application.MessageBox( pChar('Valor Bronze - ' +  E.Message) , 'S&OP', MB_ICONERROR );

              end;
         End;

         FDQueryGravaPreco.Close;
         FDQueryGravaPreco.SQL.Clear;
         FDQueryGravaPreco.SQL.Add('Update TMKT_PRECO');
         FDQueryGravaPreco.SQL.Add('Set TMKT_PRELIQCOM = :TMKT_PRELIQCOM, TMKT_PRESUGVEN = :TMKT_PRESUGVEN');
         FDQueryGravaPreco.SQL.Add('Where TMKT_PROCOD = :TMKT_PROCOD and TMKT_PRECAT = :TMKT_PRECAT');
         FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger  := varProCod;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString   := 'Prata';
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat := Prata.Value;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat := PrecoSugerido.Value;;

         Try
           FDQueryGravaPreco.ExecSQL;
         except
            on E: Exception do
              begin

                 Application.MessageBox( pChar('Valor Prata - ' +  E.Message) , 'S&OP', MB_ICONERROR );

              end;
         End;



         FDQueryGravaPreco.Close;
         FDQueryGravaPreco.SQL.Clear;
         FDQueryGravaPreco.SQL.Add('Update TMKT_PRECO');
         FDQueryGravaPreco.SQL.Add('Set TMKT_PRELIQCOM = :TMKT_PRELIQCOM, TMKT_PRESUGVEN = :TMKT_PRESUGVEN');
         FDQueryGravaPreco.SQL.Add('Where TMKT_PROCOD = :TMKT_PROCOD and TMKT_PRECAT = :TMKT_PRECAT');
         FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger  := varProCod;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString   := 'Ouro';
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat := Ouro.Value;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat := PrecoSugerido.Value;;

         Try
           FDQueryGravaPreco.ExecSQL;
         except
            on E: Exception do
              begin

                 Application.MessageBox( pChar('Valor Ouro - ' +  E.Message) , 'S&OP', MB_ICONERROR );

              end;
         End;

         FDQueryGravaPreco.Close;
         FDQueryGravaPreco.SQL.Clear;
         FDQueryGravaPreco.SQL.Add('Update TMKT_PRECO');
         FDQueryGravaPreco.SQL.Add('Set TMKT_PRELIQCOM = :TMKT_PRELIQCOM, TMKT_PRESUGVEN = :TMKT_PRESUGVEN');
         FDQueryGravaPreco.SQL.Add('Where TMKT_PROCOD = :TMKT_PROCOD and TMKT_PRECAT = :TMKT_PRECAT');
         FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger  := varProCod;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString   := 'Ouro_PEI_Bronze';
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat := Ouro_PEI_Bronze.Value;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat := PrecoSugerido.Value;;

         Try
           FDQueryGravaPreco.ExecSQL;
         except
            on E: Exception do
              begin

                 Application.MessageBox( pChar('Valor Ouro_PEI_Bronze - ' +  E.Message) , 'S&OP', MB_ICONERROR );

              end;
         End;

         FDQueryGravaPreco.Close;
         FDQueryGravaPreco.SQL.Clear;
         FDQueryGravaPreco.SQL.Add('Update TMKT_PRECO');
         FDQueryGravaPreco.SQL.Add('Set TMKT_PRELIQCOM = :TMKT_PRELIQCOM, TMKT_PRESUGVEN = :TMKT_PRESUGVEN');
         FDQueryGravaPreco.SQL.Add('Where TMKT_PROCOD = :TMKT_PROCOD and TMKT_PRECAT = :TMKT_PRECAT');
         FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger  := varProCod;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString   := 'Ouro_PEI_Prata';
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat := Ouro_PEI_Prata.Value;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat := PrecoSugerido.Value;;

         Try
           FDQueryGravaPreco.ExecSQL;
         except
            on E: Exception do
              begin

                 Application.MessageBox( pChar('Valor Ouro_PEI_Prata - ' +  E.Message) , 'S&OP', MB_ICONERROR );

              end;
         End;


         FDQueryGravaPreco.Close;
         FDQueryGravaPreco.SQL.Clear;
         FDQueryGravaPreco.SQL.Add('Update TMKT_PRECO');
         FDQueryGravaPreco.SQL.Add('Set TMKT_PRELIQCOM = :TMKT_PRELIQCOM, TMKT_PRESUGVEN = :TMKT_PRESUGVEN');
         FDQueryGravaPreco.SQL.Add('Where TMKT_PROCOD = :TMKT_PROCOD and TMKT_PRECAT = :TMKT_PRECAT');
         FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger  := varProCod;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString   := 'Prata_PEI_Bronze';
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat := Prata_PEI_Bronze.Value;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat := PrecoSugerido.Value;;

         Try
           FDQueryGravaPreco.ExecSQL;
         except
            on E: Exception do
              begin

                 Application.MessageBox( pChar('Valor Prata_PEI_Bronze - ' +  E.Message) , 'S&OP', MB_ICONERROR );

              end;
         End;


         FDQueryGravaPreco.Close;
         FDQueryGravaPreco.SQL.Clear;
         FDQueryGravaPreco.SQL.Add('Update TMKT_PRECO');
         FDQueryGravaPreco.SQL.Add('Set TMKT_PRELIQCOM = :TMKT_PRELIQCOM, TMKT_PRESUGVEN = :TMKT_PRESUGVEN');
         FDQueryGravaPreco.SQL.Add('Where TMKT_PROCOD = :TMKT_PROCOD and TMKT_PRECAT = :TMKT_PRECAT');
         FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger  := varProCod;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString   := 'Prata_PEI_Ouro';
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat := Prata_PEI_Ouro.Value;
         FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat := PrecoSugerido.Value;;

         Try
           FDQueryGravaPreco.ExecSQL;
         except
            on E: Exception do
              begin

                 Application.MessageBox( pChar('Valor Prata_PEI_Ouro - ' +  E.Message) , 'S&OP', MB_ICONERROR );

              end;
         End;

         WritelnMail(varEnviarEmail.Text);
         Mensagem(EmptyStr);
         Application.MessageBox( 'Valores Alterado com Sucesso!', 'S&OP', MB_ICONINFORMATION );

       Finally
         FreeAndNil(varEnviarEmail);
       End;

   end;


end;

procedure TFr_PrecoSite.cxButtonEditPathClick(Sender: TObject);
begin
 SaveDialog.InitialDir := GetCurrentDir;
  if SaveDialog.Execute(Handle) then
  begin
    cxButtonEditPath.Text := SaveDialog.FileName;
  end;
end;

procedure TFr_PrecoSite.cxButtonEditPathPrecoClick(Sender: TObject);
begin
   SaveDialog.InitialDir := GetCurrentDir;
  if SaveDialog.Execute(Handle) then
  begin
    cxButtonEditPathPreco.Text := SaveDialog.FileName;
  end;
end;

procedure TFr_PrecoSite.cxGrid1DBBandedTableView1DblClick(Sender: TObject);
begin
  if not FDQueryConsultaPreco.IsEmpty then
  begin
    varDoubleClick := True;
    varProCod         := FDQueryConsultaPreco.FieldByName('TMKT_PROCOD').AsInteger;
    edtYNumber.Hint   := 'PK: ' +   FDQueryConsultaPreco.FieldByName('TMKT_PROCOD').AsString;
    edtYNumber.Text   := FDQueryConsultaPreco.FieldByName('TMKT_PROCODSAP').AsString;
    edtDescricao.Text := FDQueryConsultaPreco.FieldByName('TMKT_PRODES').AsString;
    edtCatalogo.Text  := FDQueryConsultaPreco.FieldByName('TMKT_PROCODCAT').AsString;

    PrecoSugerido.Value := RoundTo(FDQueryConsultaPreco.FieldByName('PrecoSugerido').AsFloat,-2);
    Autorizado.Value   := RoundTo(FDQueryConsultaPreco.FieldByName('Autorizado').AsFloat,-2);
    Platino.Value   := RoundTo(FDQueryConsultaPreco.FieldByName('Platino').AsFloat,-2);
    Bronze.Value   := RoundTo(FDQueryConsultaPreco.FieldByName('Bronze').AsFloat,-2);
    Prata.Value   := RoundTo(FDQueryConsultaPreco.FieldByName('Prata').AsFloat,-2);
    Ouro.Value   := RoundTo(FDQueryConsultaPreco.FieldByName('Ouro').AsFloat,-2);

    Ouro_PEI_Bronze.Value   := RoundTo(FDQueryConsultaPreco.FieldByName('Ouro_PEI_Bronze').AsFloat,-2);
    Ouro_PEI_Prata.Value   := RoundTo(FDQueryConsultaPreco.FieldByName('Ouro_PEI_Prata').AsFloat,-2);
    Prata_PEI_Bronze.Value   := RoundTo(FDQueryConsultaPreco.FieldByName('Prata_PEI_Bronze').AsFloat,-2);
    Prata_PEI_Ouro.Value   := RoundTo(FDQueryConsultaPreco.FieldByName('Prata_PEI_Ouro').AsFloat,-2);

    Page.ActivePage   := tabEditar;
    varDoubleClick   := False;
    PrecoSugerido.SetFocus;
  end;

end;

procedure TFr_PrecoSite.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FDConnection.Close;
  Fr_PrecoSite := Nil;
  Action := caFree;

end;

procedure TFr_PrecoSite.Mensagem(pMensagem: String);
begin
  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;
end;

procedure TFr_PrecoSite.PageChange(Sender: TObject);
begin
  if Page.ActivePage =  tabEditar then
   begin
    if varDoubleClick = False then
    begin
      varProCod         := 0;
      edtYNumber.Hint   := '';
      edtYNumber.Text   := '';
      edtDescricao.Text := '';
      edtCatalogo.Text  := '';
      PrecoSugerido.Value := 0;
      Autorizado.Value   := 0;
      Platino.Value   := 0;
      Bronze.Value   := 0;
      Prata.Value   := 0;

      Ouro.Value   := 0;
      Ouro_PEI_Bronze.Value   := 0;
      Ouro_PEI_Prata.Value   := 0;
      Prata_PEI_Bronze.Value   := 0;
      Prata_PEI_Ouro.Value := 0;

    end;
  end;

end;

end.