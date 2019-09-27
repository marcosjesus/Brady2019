unit uImportarIQFZMP05;

interface

uses
  dxSpreadSheet,
  dxSpreadSheetTypes,
  dxHashUtils,
  dxSpreadSheetCore,
  System.IOUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxCheckBox,
  cxContainer, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxLabel, dxGDIPlusClasses, Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, dxSkinOffice2013White, dxBarBuiltInMenu, Vcl.Menus,
  cxTextEdit, cxButtons, cxPC, Vcl.StdCtrls, cxMemo, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, dxSkinBlack, dxSkinBlue,
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
  dxSkinWhiteprint, dxSkinXmas2008Blue, FireDAC.Comp.ScriptCommands,
  FireDAC.Comp.Script;

type
  TFr_ImportarIQFZMP05 = class(TForm)
    DataSourceTIQF_Periodo: TDataSource;
    FDConnection: TFDConnection;
    OpenDialog: TOpenDialog;
    FDQueryTIQF_Periodo: TFDQuery;
    FDQueryTIQF_PeriodoTIQF_PERCOD: TFDAutoIncField;
    FDQueryTIQF_PeriodoTIQF_PERNOM: TStringField;
    FDQueryTIQF_PeriodoTIQF_PERDAT: TSQLTimeStampField;
    FDQueryTIQF_Dados: TFDQuery;
    FDQueryTIQF_DadosTIQF_DADCOD: TFDAutoIncField;
    FDQueryTIQF_DadosTIQF_PERCOD: TIntegerField;
    FDQueryTIQF_DadosTIQF_FORCOD: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADQTDENT: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADQTDATR: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADQTDRNCEMB: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADQTDFAL: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADPERIQFMES: TBCDField;
    FDQueryTIQF_DadosTIQF_DADPERIQFACU: TBCDField;
    FDQueryTIQF_Fornecedor: TFDQuery;
    FDQueryTIQF_FornecedorTIQF_FORCOD: TFDAutoIncField;
    FDQueryTIQF_FornecedorTIQF_FORSAP: TStringField;
    FDQueryTIQF_FornecedorTIQF_FORNOM: TStringField;
    FDQueryTIQF_FornecedorTIQF_FORATI: TStringField;
    FDQueryTIQF_FornecedorTIQF_FORCER: TStringField;
    cxPageControlFiltro: TcxPageControl;
    cxTabSheetFiltro: TcxTabSheet;
    cxComboBoxSheet: TcxComboBox;
    cxLabelSheet: TcxLabel;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    cxLabelSequenciaInicial: TcxLabel;
    cxLabelDataFinal: TcxLabel;
    cxButtonImportar: TcxButton;
    cxTextEditFileName: TcxTextEdit;
    cxButtonArquivo: TcxButton;
    cxLookupComboBoxPeriodo: TcxLookupComboBox;
    FDScriptCalcIQF: TFDScript;
    FDQueryTIQF_DadosTIQF_DADQN: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADDOCMANUAL: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADDOCCER: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADDOCSUPA: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADDOCBALP: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADNFEXML: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADNFENFP: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADNFEVCT: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADNFEDEI: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADDPO3045: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADDPO4660: TIntegerField;
    FDQueryTIQF_DadosTIQF_DADDPO6190: TIntegerField;
    FDQueryTIQF_FornecedorTIQF_FORCERDATVAL: TSQLTimeStampField;
    FDQueryTIQF_FornecedorTIQF_FORDOCMANUAL: TStringField;
    FDQueryTIQF_FornecedorTIQF_FORDOCSUPA: TStringField;
    FDQueryTIQF_FornecedorTIQF_FORDOCBALP: TStringField;
    FDQueryTIQF_FornecedorTIQF_FORDPODIAS: TIntegerField;
    FDQueryTIQF_FornecedorTIQF_CATEGORIA: TStringField;
    FDQueryTIQF_FornecedorTIQF_DTMANUAL: TSQLTimeStampField;
    FDQueryTIQF_FornecedorTIQF_DTSUPPLY: TSQLTimeStampField;
    FDQueryTIQF_FornecedorTIQF_DTBALANCO: TSQLTimeStampField;
    FDQueryTIQF_FornecedorTIQF_DTDOP: TSQLTimeStampField;
    FDQueryTIQF_DadosTIQF_DADDTMANUAL: TSQLTimeStampField;
    FDQueryTIQF_DadosTIQF_DADDTSUPPLY: TSQLTimeStampField;
    FDQueryTIQF_DadosTIQF_DADDTBALANCO: TSQLTimeStampField;
    FDQueryTIQF_DadosTIQF_DADDTDOP: TSQLTimeStampField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButtonArquivoClick(Sender: TObject);
    procedure cxButtonImportarClick(Sender: TObject);
  private
    procedure Mensagem( pMensagem: String );
    { Private declarations }
  public
    procedure AbrirDataset;
    { Public declarations }
  end;

var
  Fr_ImportarIQFZMP05: TFr_ImportarIQFZMP05;

implementation

{$R *.dfm}

uses uUtils, uBrady;

procedure TFr_ImportarIQFZMP05.AbrirDataset;
begin

  if not FDConnection.Connected then
  begin

    Mensagem( 'Abrindo conexão...' );
    try

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

      Mensagem( 'Obtendo dados (Periodo)...' );
      FDQueryTIQF_Periodo.Open;

      Mensagem( 'Obtendo dados (Fornecedor)...' );
      FDQueryTIQF_Fornecedor.Open;

    finally

      Mensagem( EmptyStr );

    end;

  end;

end;

procedure TFr_ImportarIQFZMP05.cxButtonArquivoClick(Sender: TObject);
var
  I: Integer;
  dxSpreadSheet: TdxSpreadSheet;

begin

  if OpenDialog.Execute(Handle) then
  begin

    cxTextEditFileName.Text := OpenDialog.FileName;

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    try

      dxSpreadSheet.LoadFromFile( cxTextEditFileName.Text );

      cxComboBoxSheet.Properties.Items.Clear;
      for I := 0 to dxSpreadSheet.SheetCount-1 do
        cxComboBoxSheet.Properties.Items.Add( dxSpreadSheet.Sheets[I].Caption );

    finally

      FreeAndNil(dxSpreadSheet);

    end;


  end;

end;

procedure TFr_ImportarIQFZMP05.cxButtonImportarClick(Sender: TObject);
var
  I: Integer;
  varCode: Integer;

  dxSpreadSheet: TdxSpreadSheet;

  varColumnCODFOR         : Integer;
  varColumnNOMFOR         : Integer;
  varColumnDADQTDENT      : Integer;

  varColumnDADQTDATR      : Integer;
  varColumnDADQN          : Integer;
  varColumnDADDOCMANUAL   : Integer;
  varColumnDADDOCCER      : Integer;
  varColumnDADDOCSUPA     : Integer;
  varColumnDADDOCBALP     : Integer;

  varColumnDADDPO3045     : Integer;
  varColumnDADDPO4660     : Integer;
  varColumnDADDPO6190     : Integer;

  varColumnDADNFEXML      : Integer;
  varColumnDADNFENFP      : Integer;
  varColumnDADNFEVCT      : Integer;
  varColumnDADNFEDEI      : Integer;


  varCODFOR        : Integer;
  varNOMFOR        : String;
  varQTDENTREGA    : Integer;

  varDADQTDATR     : Integer;
  varDADQN         : Integer;
  varDADDOCMANUAL  : Integer;
  varDADDOCCER     : Integer;
  varDADDOCSUPA    : Integer;
  varDADDOCBALP    : Integer;

  varDADDPO3045    : Integer;
  varDADDPO4660    : Integer;
  varDADDPO6190    : Integer;

  varDADNFEXML     : Integer;
  varDADNFENFP     : Integer;
  varDADNFEVCT     : Integer;
  varDADNFEDEI     : Integer;

  varTIQF_DTMANUAL  : TDateTime;
  varTIQF_DTSUPPLY  : TDateTime;
  varTIQF_DTBALANCO : TDateTime;
  varTIQF_DTDOP     : TDateTime;



begin

  try
    if cxLookupComboBoxPeriodo.SelectedItem = -1 then
      raise Exception.Create('Selecione um periodo primeiro.');

    if cxTextEditFileName.Text = EmptyStr then
      raise Exception.Create('Selecione um arquivo para importar.');

    if cxComboBoxSheet.SelectedItem = -1 then
      raise Exception.Create('Selecione uma aba da planilha.');

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    try

      Mensagem( 'Carregando planilha...' );
      dxSpreadSheet.LoadFromFile( cxTextEditFileName.Text );

      varColumnCODFOR         := -1;
      varColumnNOMFOR         := -1;
      varColumnDADQTDENT      := -1;

      varColumnDADQTDATR      := -1;
      varColumnDADQN          := -1;

      varColumnDADDOCMANUAL   := -1;
      varColumnDADDOCCER      := -1;
      varColumnDADDOCSUPA     := -1;
      varColumnDADDOCBALP     := -1;

      varColumnDADDPO3045     := -1;
      varColumnDADDPO4660     := -1;
      varColumnDADDPO6190     := -1;

      varColumnDADNFEXML      := -1;
      varColumnDADNFENFP      := -1;
      varColumnDADNFEVCT      := -1;
      varColumnDADNFEDEI      := -1;


      for I := 0 to dxSpreadSheet.SheetCount-1 do
        if cxComboBoxSheet.Properties.Items[cxComboBoxSheet.SelectedItem] = dxSpreadSheet.Sheets[I].Caption then
          dxSpreadSheet.Sheets[I].Active := True;

      for I := dxSpreadSheet.ActiveSheetAsTable.Columns.FirstIndex to dxSpreadSheet.ActiveSheetAsTable.Columns.LastIndex do
      begin

        if not assigned(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0]) then
          Continue;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString)= 'FORNECEDOR' then
           varColumnCODFOR := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'NOME' then
           varColumnNOMFOR := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'QTDE TOTAL ENTREGUE' then
           varColumnDADQTDENT := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'QTDE ENTREGUE NO PRAZO' then
           varColumnDADQTDATR:= I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'QTDE QN' then
           varColumnDADQN := I;
      {
        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'MANUAL FORNECEDOR' then
           varColumnDADDOCMANUAL := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'CERTIFICACAO' then
           varColumnDADDOCCER := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'SUPPLY AGREEMENT' then
           varColumnDADDOCSUPA := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'BALANCO PATRIMONIAL' then
           varColumnDADDOCBALP := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = '30 - 45 DIAS' then
           varColumnDADDPO3045 := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = '46 - 60 DIAS' then
           varColumnDADDPO4660 := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = '61 - 90 DIAS' then
           varColumnDADDPO6190 := I;
       }
        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'QTDE XML' then
           varColumnDADNFEXML := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'NFS PEDIDO' then
           varColumnDADNFENFP := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'VENCIMENTO' then
           varColumnDADNFEVCT := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'DESTAQUE DO IMPOSTO' then
           varColumnDADNFEDEI := I;

      end;

      if varColumnCODFOR = -1 then
        raise Exception.Create('Coluna "Fornecedor" não foi encontrada na planilha selecionada.');

      if varColumnNOMFOR = -1 then
        raise Exception.Create('Coluna "Nome" não foi encontrada na planilha selecionada.');

      if varColumnDADQTDENT = -1 then
        raise Exception.Create('Coluna "Qtde Total Entregue" não foi encontrada na planilha selecionada.');

      if varColumnDADQTDATR = -1 then
        raise Exception.Create('Coluna "Qtde Entregue no Prazo" não foi encontrada na planilha selecionada.');

      if varColumnDADQN        = -1 Then
        raise Exception.Create('Coluna "Qtde QN" não foi encontrada na planilha selecionada.');
     {
      if varColumnDADDOCMANUAL = -1 Then
        raise Exception.Create('Coluna "Manual Fornecedor" não foi encontrada na planilha selecionada.');

      if varColumnDADDOCCER    = -1 Then
        raise Exception.Create('Coluna "Certificacao" não foi encontrada na planilha selecionada.');

      if varColumnDADDOCSUPA   = -1 Then
        raise Exception.Create('Coluna "Supply Agreement" não foi encontrada na planilha selecionada.');

      if varColumnDADDOCBALP   = -1 Then
        raise Exception.Create('Coluna "Balanco Patrimonial" não foi encontrada na planilha selecionada.');

      if varColumnDADDPO3045   = -1 Then
        raise Exception.Create('Coluna "30 - 45 Dias" não foi encontrada na planilha selecionada.');

      if varColumnDADDPO4660   = -1 Then
        raise Exception.Create('Coluna "46 - 60 Dias" não foi encontrada na planilha selecionada.');

      if varColumnDADDPO6190   = -1 Then
        raise Exception.Create('Coluna "61 - 90 Dias" não foi encontrada na planilha selecionada.');
      }
      if varColumnDADNFEXML    = -1 Then
        raise Exception.Create('Coluna "Qtde XML" não foi encontrada na planilha selecionada.');

      if varColumnDADNFENFP    = -1 Then
        raise Exception.Create('Coluna "NFs Pedido" não foi encontrada na planilha selecionada.');

      if varColumnDADNFEVCT    = -1 Then
       raise Exception.Create('Coluna "Vencimento" não foi encontrada na planilha selecionada.');

      if varColumnDADNFEDEI    = -1 Then
       raise Exception.Create('Coluna "Destaque do Imposto" não foi encontrada na planilha selecionada.');



      FDQueryTIQF_Dados.ParamByName('TIQF_PERCOD').AsInteger := FDQueryTIQF_PeriodoTIQF_PERCOD.AsInteger;
      FDQueryTIQF_Dados.Close;
      FDQueryTIQF_Dados.Open;

      while not FDQueryTIQF_Dados.Eof do
        FDQueryTIQF_Dados.Delete;

      for I := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
      begin

        try
          Val( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnCODFOR].AsString, varCODFOR, varCode );
        except
          varCode := 1;
        end;

        if varCode <> 0 then
          Continue;

        varQTDENTREGA     := 0;
        varDADQTDATR      := 0;
        varDADQN          := 0;
        varDADNFEXML      := 0;
        varDADNFENFP      := 0;
        varDADNFEVCT      := 0;
        varDADNFEDEI      := 0;

        varNOMFOR         := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnNOMFOR].AsString;
        varQTDENTREGA     := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDADQTDENT].AsInteger;
        varDADQTDATR      := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDADQTDATR].AsInteger;

        varDADQN          := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDADQN].AsInteger;
       {
        varDADDOCMANUAL   := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDADDOCMANUAL].AsInteger;
        varDADDOCCER      := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDADDOCCER].AsInteger;
        varDADDOCSUPA     := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDADDOCSUPA].AsInteger;
        varDADDOCBALP     := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDADDOCBALP].AsInteger;

        varDADDPO3045     := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDADDPO3045].AsInteger;
        varDADDPO4660     := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDADDPO4660].AsInteger;
        varDADDPO6190     := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDADDPO6190].AsInteger;
        }
        varDADNFEXML      := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDADNFEXML].AsInteger;
        varDADNFENFP      := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDADNFENFP].AsInteger;
        varDADNFEVCT      := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDADNFEVCT].AsInteger;
        varDADNFEDEI      := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDADNFEDEI].AsInteger;

        varTIQF_DTMANUAL  := StrToDate('31/12/9999');
        varTIQF_DTSUPPLY  := StrToDate('31/12/9999');
        varTIQF_DTBALANCO := StrToDate('31/12/9999');
        varTIQF_DTDOP     := StrToDate('31/12/9999');

        if not FDQueryTIQF_Fornecedor.Locate( 'TIQF_FORSAP', varCODFOR, [] ) then
        begin

          Mensagem( 'Criando fornecedor ("' + varNOMFOR + '")...' );
          FDQueryTIQF_Fornecedor.Append;

          FDQueryTIQF_FornecedorTIQF_FORSAP.AsInteger := varCODFOR;
          FDQueryTIQF_FornecedorTIQF_FORNOM.AsString  := varNOMFOR;
          FDQueryTIQF_FornecedorTIQF_FORATI.AsString  := 'S';
          FDQueryTIQF_FornecedorTIQF_FORCER.AsString  := 'N';



          try

            FDQueryTIQF_Fornecedor.Post;

          except

            FDQueryTIQF_Fornecedor.Cancel;

          end;

        end
        else
        begin

             varTIQF_DTMANUAL  := FDQueryTIQF_FornecedorTIQF_DTMANUAL.AsDateTime;
             varTIQF_DTSUPPLY  := FDQueryTIQF_FornecedorTIQF_DTSUPPLY.AsDateTime;
             varTIQF_DTBALANCO := FDQueryTIQF_FornecedorTIQF_DTBALANCO.AsDateTime;
             varTIQF_DTDOP     := FDQueryTIQF_FornecedorTIQF_DTDOP.AsDateTime;

        end;


        Mensagem( 'Criando dados entrega ( "' + varNOMFOR + '" )...' );

        FDQueryTIQF_Dados.Append;

        FDQueryTIQF_DadosTIQF_PERCOD.AsInteger       := FDQueryTIQF_PeriodoTIQF_PERCOD.AsInteger;
        FDQueryTIQF_DadosTIQF_FORCOD.AsInteger       := FDQueryTIQF_FornecedorTIQF_FORCOD.AsInteger;

        FDQueryTIQF_DadosTIQF_DADQTDENT.AsInteger    := varQTDENTREGA;
        FDQueryTIQF_DadosTIQF_DADQTDATR.AsInteger    := varDADQTDATR;

        FDQueryTIQF_DadosTIQF_DADQN.AsInteger        := varDADQN;

        FDQueryTIQF_DadosTIQF_DADDOCMANUAL.AsInteger := 0; //varDADDOCMANUAL;
        FDQueryTIQF_DadosTIQF_DADDOCCER.AsInteger    := 0; //varDADDOCCER;
        FDQueryTIQF_DadosTIQF_DADDOCSUPA.AsInteger   := 0; //varDADDOCSUPA;
        FDQueryTIQF_DadosTIQF_DADDOCBALP.AsInteger   := 0; //varDADDOCBALP;

        FDQueryTIQF_DadosTIQF_DADDPO3045.AsInteger   := 0; //varDADDPO3045;
        FDQueryTIQF_DadosTIQF_DADDPO4660.AsInteger   := 0; //varDADDPO4660;
        FDQueryTIQF_DadosTIQF_DADDPO6190.AsInteger   := 0; //varDADDPO6190;

        FDQueryTIQF_DadosTIQF_DADNFEXML.AsInteger    := varDADNFEXML;
        FDQueryTIQF_DadosTIQF_DADNFENFP.AsInteger    := varDADNFENFP;
        FDQueryTIQF_DadosTIQF_DADNFEVCT.AsInteger    := varDADNFEVCT;
        FDQueryTIQF_DadosTIQF_DADNFEDEI.AsInteger    := varDADNFEDEI;

        FDQueryTIQF_DadosTIQF_DADDTMANUAL.AsDateTime := varTIQF_DTMANUAL;
        FDQueryTIQF_DadosTIQF_DADDTSUPPLY.AsDateTime := varTIQF_DTSUPPLY;
        FDQueryTIQF_DadosTIQF_DADDTBALANCO.AsDateTime  := varTIQF_DTBALANCO;
        FDQueryTIQF_DadosTIQF_DADDTDOP.AsDateTime :=  varTIQF_DTDOP;

        FDQueryTIQF_DadosTIQF_DADQTDRNCEMB.AsInteger := 0;
        FDQueryTIQF_DadosTIQF_DADQTDFAL.AsInteger    := 0;
        FDQueryTIQF_DadosTIQF_DADPERIQFMES.AsFloat   := 0.00;
        FDQueryTIQF_DadosTIQF_DADPERIQFACU.AsFloat   := 0.00;

        try

          FDQueryTIQF_Dados.Post;

        except

          FDQueryTIQF_Dados.Cancel;

        end;

      end;

    finally

      FreeAndNil(dxSpreadSheet);

    end;

    Mensagem( 'Calculando IQF Acumulado...' );
    FDScriptCalcIQF.SQLScripts.Clear;
    FDScriptCalcIQF.SQLScripts.Add.SQL.Add( 'EXEC dbo.PIQF_CalculoIQF_2 ' + FDQueryTIQF_PeriodoTIQF_PERCOD.AsString );
    FDScriptCalcIQF.ExecuteAll;

    Mensagem( 'Importação Concluida...' );

    Sleep(3000);

    Mensagem( EmptyStr );

  except

    on E: Exception do
    begin

      Mensagem( EmptyStr );
      raise Exception.Create('Erro no processamento.' + #13#10 + E.Message);

    end;

  end;

end;

procedure TFr_ImportarIQFZMP05.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  FDQueryTIQF_Periodo.Close;
  FDConnection.Close;

  Fr_ImportarIQFZMP05 := nil;
  Action := caFree;

end;

procedure TFr_ImportarIQFZMP05.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

end.
