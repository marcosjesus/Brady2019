unit uImportarIQFFornecedor;

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
  TFr_ImportarIQFFornecedor = class(TForm)
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
    cxLabelDataFinal: TcxLabel;
    cxButtonImportar: TcxButton;
    cxTextEditFileName: TcxTextEdit;
    cxButtonArquivo: TcxButton;
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
    FDQueryTIQF_FornecedorTIQF_CLASSIFICACAO: TStringField;
    FDQueryCategoria: TFDQuery;
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
  Fr_ImportarIQFFornecedor: TFr_ImportarIQFFornecedor;

implementation

{$R *.dfm}

uses uUtils, uBrady;

procedure TFr_ImportarIQFFornecedor.AbrirDataset;
begin

  if not FDConnection.Connected then
  begin

    Mensagem( 'Abrindo conex�o...' );
    try

      FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
      FDConnection.Open;

      Mensagem( 'Obtendo dados (Periodo)...' );
      FDQueryTIQF_Periodo.Open;

      Mensagem( 'Obtendo dados (Fornecedor)...' );
      FDQueryTIQF_Fornecedor.Open;

      Mensagem( 'Obtendo dados (Categoria)...' );
      FDQueryCategoria.Open;


    finally

      Mensagem( EmptyStr );

    end;

  end;

end;

procedure TFr_ImportarIQFFornecedor.cxButtonArquivoClick(Sender: TObject);
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

procedure TFr_ImportarIQFFornecedor.cxButtonImportarClick(Sender: TObject);
var
  I: Integer;
  varCode: Integer;

  dxSpreadSheet: TdxSpreadSheet;

  varColumnCODFOR         : Integer;
  varColumnNOMFOR         : Integer;
  varColumnFORATIVO       : Integer;
  varColumnFORDOCCER      : Integer;
  //varColumnFORCERDATVAL   : Integer;

  varColumnFORDOCMANUAL   : Integer;
  varColumnFORDOCSUPA     : Integer;
  varColumnFORDOCBALP     : Integer;

  varColumnFORDPO0029     : Integer;
  varColumnFORDPO3045     : Integer;
  varColumnFORDPO4660     : Integer;
  varColumnFORDPO6190     : Integer;
 {
  varColumnTIQF_DTMANUAL  : Integer;
  varColumnTIQF_DTSUPPLY  : Integer;
  varColumnTIQF_DTBALANCO : Integer;
  varColumnTIQF_DTDOP     : Integer;
  }
  varColumnClassificacao  : Integer;


  varColumnTIQF_Categoria : Integer;

  varDate           : Integer;
  varCODFOR         : Integer;
  varNOMFOR         : String;
  varFORATIVO       : String;
  varFORDOCCER      : String;
  {
  varFORCERDATVAL   : TDateTime;
  varTIQF_DTMANUAL  : TDateTime;
  varTIQF_DTSUPPLY  : TDateTime;
  varTIQF_DTBALANCO : TDateTime;
  varTIQF_DTDOP     : TDateTime;
  }
  varClassificacao  : String;



  varFORDOCMANUAL  : String;
  varFORDOCSUPA    : String;
  varFORDOCBALP    : String;

  varFORDPO0029    : String;
  varFORDPO3045    : String;
  varFORDPO4660    : String;
  varFORDPO6190    : String;
  varTIQF_CATEGORIA : String;

  varCategoriaNova : TStringList;
  varBCategoriaNova : Boolean;
begin

  try

    if cxTextEditFileName.Text = EmptyStr then
      raise Exception.Create('Selecione um arquivo para importar.');

    if cxComboBoxSheet.SelectedItem = -1 then
      raise Exception.Create('Selecione uma aba da planilha.');

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    varCategoriaNova := TStringList.Create;
    try

      Mensagem( 'Carregando planilha...' );
      dxSpreadSheet.LoadFromFile( cxTextEditFileName.Text );

      varColumnCODFOR         := -1;
      varColumnNOMFOR         := -1;
      varColumnFORATIVO       := -1;
      varColumnFORDOCCER      := -1;
      {
      varColumnFORCERDATVAL   := -1;
      varColumnTIQF_DTMANUAL  := -1;
      varColumnTIQF_DTSUPPLY  := -1;
      varColumnTIQF_DTBALANCO := -1;
      varColumnTIQF_DTDOP     := -1;
       }
      varColumnFORDOCMANUAL   := -1;
      varColumnFORDOCSUPA     := -1;
      varColumnFORDOCBALP     := -1;
      varColumnFORDPO0029     := -1;
      varColumnFORDPO3045     := -1;
      varColumnFORDPO4660     := -1;
      varColumnFORDPO6190     := -1;
      varColumnTIQF_Categoria := -1;
      varColumnClassificacao  := -1;


      for I := 0 to dxSpreadSheet.SheetCount-1 do
        if cxComboBoxSheet.Properties.Items[cxComboBoxSheet.SelectedItem] = dxSpreadSheet.Sheets[I].Caption then
          dxSpreadSheet.Sheets[I].Active := True;

      for I := dxSpreadSheet.ActiveSheetAsTable.Columns.FirstIndex to dxSpreadSheet.ActiveSheetAsTable.Columns.LastIndex do
      begin

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString)= 'FORNECEDOR' then
           varColumnCODFOR := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'CATEGORIA' then
           varColumnTIQF_Categoria := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'NOME' then
           varColumnNOMFOR := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'ATIVO' then
           varColumnFORATIVO := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'CERTIFICACAO' then
           varColumnFORDOCCER := I;

        //if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'DATA DE VALIDADE' then
        //   varColumnFORCERDATVAL := I;


        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'MANUAL FORNECEDOR' then
           varColumnFORDOCMANUAL := I;

        //if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'DT MANUAL FORNECEDOR' then
        //   varColumnTIQF_DTMANUAL := I;


        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'SUPPLY AGREEMENT' then
           varColumnFORDOCSUPA := I;

        //if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'DT SUPPLY AGREEMENT' then
        //   varColumnTIQF_DTSUPPLY := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'SERASA' then
           varColumnFORDOCBALP := I;

        //if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'DT SERASA' then
         //  varColumnTIQF_DTBALANCO := I;


        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = '0 - 29 DIAS' then
           varColumnFORDPO0029 := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = '30 - 44 DIAS' then
           varColumnFORDPO3045 := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = '45 - 59 DIAS' then
           varColumnFORDPO4660 := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'ACIMA DE 60 DIAS' then
           varColumnFORDPO6190 := I;

        //if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'DT DPO' then
        //   varColumnTIQF_DTDOP := I;

        if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'CLASSIFICACAO' then
           varColumnClassificacao := I;

      end;

      if varColumnCODFOR = -1 then
        raise Exception.Create('Coluna "Fornecedor" n�o foi encontrada na planilha selecionada.');

      if varColumnTIQF_Categoria = -1 then
        raise Exception.Create('Coluna "Categoria" n�o foi encontrada na planilha selecionada.');

      if varColumnNOMFOR = -1 then
        raise Exception.Create('Coluna "Nome" n�o foi encontrada na planilha selecionada.');

      if varColumnFORATIVO = -1 then
        raise Exception.Create('Coluna "Ativo" n�o foi encontrada na planilha selecionada.');

      if varColumnFORDOCCER = -1 then
        raise Exception.Create('Coluna "Certificacao" n�o foi encontrada na planilha selecionada.');

     // if varColumnFORCERDATVAL        = -1 Then
     //   raise Exception.Create('Coluna "Data de Validade" n�o foi encontrada na planilha selecionada.');

      if varColumnFORDOCMANUAL = -1 Then
        raise Exception.Create('Coluna "Manual Fornecedor" n�o foi encontrada na planilha selecionada.');

     // if varColumnTIQF_DTMANUAL = -1 Then
     //   raise Exception.Create('Coluna "DT Manual Fornecedor" n�o foi encontrada na planilha selecionada.');

      if varColumnFORDOCCER    = -1 Then
        raise Exception.Create('Coluna "Certificacao" n�o foi encontrada na planilha selecionada.');

      if varColumnFORDOCSUPA   = -1 Then
        raise Exception.Create('Coluna "Supply Agreement" n�o foi encontrada na planilha selecionada.');

      //if varColumnTIQF_DTSUPPLY   = -1 Then
      //  raise Exception.Create('Coluna "DT Supply Agreement" n�o foi encontrada na planilha selecionada.');

      if varColumnFORDOCBALP   = -1 Then
        raise Exception.Create('Coluna "Serasa" n�o foi encontrada na planilha selecionada.');

      //if varColumnTIQF_DTBALANCO   = -1 Then
      //  raise Exception.Create('Coluna "DT Serasa" n�o foi encontrada na planilha selecionada.');

      if varColumnFORDPO0029 = -1 then
        raise Exception.Create('Coluna "0 - 29 DIAS" n�o foi encontrada na planilha selecionada.');

      if varColumnFORDPO3045   = -1 Then
        raise Exception.Create('Coluna "30 - 44 Dias" n�o foi encontrada na planilha selecionada.');

      if varColumnFORDPO4660   = -1 Then
        raise Exception.Create('Coluna "45 - 59 Dias" n�o foi encontrada na planilha selecionada.');

      if varColumnFORDPO6190   = -1 Then
        raise Exception.Create('Coluna "Acima de 60" n�o foi encontrada na planilha selecionada.');

      //if varColumnTIQF_DTDOP   = -1 Then
      //  raise Exception.Create('Coluna "DT DPO" n�o foi encontrada na planilha selecionada.');

      if varColumnClassificacao = -1 then
          raise Exception.Create('Coluna "Classificacao" n�o foi encontrada na planilha selecionada.');

      varCategoriaNova.Add('Fornecedor' + ';' +
                           'Categoria' + ';' +
                           'Nome' + ';' +
                           'Ativo' + ';' +
                           'Certificacao' + ';' +
                           'Manual Fornecedor' + ';' +
                           'Supply Agreement' + ';' +
                           'Serasa' + ';' +
                           '0 - 29 Dias' + ';' +
                           '30 - 44 Dias' + ';' +
                           '45 - 59 Dias' + ';' +
                           'Acima de 60' + ';' +
                           'Classificacao');

      varBCategoriaNova := False;
      FDQueryTIQF_Fornecedor.Close;
      FDQueryTIQF_Fornecedor.Open;

      for I := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
      begin

        try
          Val( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnCODFOR].AsString, varCODFOR, varCode );
        except
          varCode := 1;
        end;

        if varCode <> 0 then
          Continue;

        varNOMFOR         := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnNOMFOR].AsString;
        {
        //data do certificado
        if assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORCERDATVAL]) then
        begin

          if dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORCERDATVAL].DataType = cdtDateTime then
             varFORCERDATVAL := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORCERDATVAL].AsDateTime
            else
            if TryStrToInt( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORCERDATVAL].AsString, varDate ) then
               varFORCERDATVAL := varDate
            else
               varFORCERDATVAL := StrToDate(String( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORCERDATVAL].AsString).Replace( '-', '/' ));

        end
        else  varFORCERDATVAL := StrToDate('31/12/9999');

         //data do manual do fornecedor
        if assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTMANUAL]) then
        begin
          if dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTMANUAL].DataType = cdtDateTime then
             varTIQF_DTMANUAL := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTMANUAL].AsDateTime
            else
            if TryStrToInt( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTMANUAL].AsString, varDate ) then
               varTIQF_DTMANUAL := varDate
            else
               if String( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTMANUAL].AsString).Replace( '-', '/' ) <> '' then
                varTIQF_DTMANUAL := StrToDate(String( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTMANUAL].AsString).Replace( '-', '/' ))
               else varTIQF_DTMANUAL := StrToDate('31/12/9999');

        end
        else  varTIQF_DTMANUAL := StrToDate('31/12/9999');

         //data do suplly agreement
        if assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTSUPPLY]) then
        begin
          if dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTSUPPLY].DataType = cdtDateTime then
             varTIQF_DTSUPPLY := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTSUPPLY].AsDateTime
            else
            if TryStrToInt( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTSUPPLY].AsString, varDate ) then
               varTIQF_DTSUPPLY := varDate
            else
               if String( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTSUPPLY].AsString).Replace( '-', '/' ) <> '' then
                 varTIQF_DTSUPPLY := StrToDate(String( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTSUPPLY].AsString).Replace( '-', '/' ))
               else  varTIQF_DTSUPPLY := StrToDate('31/12/9999');

        end
        else  varTIQF_DTSUPPLY := StrToDate('31/12/9999');

         //data do serasa
        if assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTBALANCO]) then
        begin
          if dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTBALANCO].DataType = cdtDateTime then
             varTIQF_DTBALANCO := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTBALANCO].AsDateTime
            else
            if TryStrToInt( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTBALANCO].AsString, varDate ) then
               varTIQF_DTBALANCO := varDate
            else
                if String( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTBALANCO].AsString).Replace( '-', '/' ) <> '' then
                  varTIQF_DTBALANCO := StrToDate(String( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTBALANCO].AsString).Replace( '-', '/' ))
                else  varTIQF_DTBALANCO := StrToDate('31/12/9999');

        end
        else  varTIQF_DTBALANCO := StrToDate('31/12/9999');

         //data do DOP
        if assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTDOP]) then
        begin
        if dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTDOP].DataType = cdtDateTime then
           varTIQF_DTDOP := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTDOP].AsDateTime
          else
          if TryStrToInt( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTDOP].AsString, varDate ) then
             varTIQF_DTDOP := varDate
          else
             if String( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTDOP].AsString).Replace( '-', '/' ) <> '' then
               varTIQF_DTDOP := StrToDate(String( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_DTDOP].AsString).Replace( '-', '/' ))
             else varTIQF_DTDOP := StrToDate('31/12/9999');

        end
        else  varTIQF_DTDOP := StrToDate('31/12/9999');
         }
        varFORATIVO       := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORATIVO].AsString;
        varFORDOCCER      := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORDOCCER].AsString;

        varFORDOCMANUAL   := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORDOCMANUAL].AsString;
        varFORDOCSUPA     := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORDOCSUPA].AsString;
        varFORDOCBALP     := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORDOCBALP].AsString;

        if assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_Categoria]) then
           varTIQF_CATEGORIA   := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTIQF_Categoria].AsString
        else  varTIQF_CATEGORIA := '';

        if assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORDPO0029]) then
           varFORDPO0029     := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORDPO0029].AsString
        else varFORDPO0029 := '';

        if assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORDPO3045]) then
           varFORDPO3045     := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORDPO3045].AsString
        else varFORDPO3045 := '';

        if assigned( dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORDPO4660]) then
           varFORDPO4660     := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORDPO4660].AsString
        else  varFORDPO4660 := '';

        if assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORDPO6190]) then
           varFORDPO6190     := dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFORDPO6190].AsString
        else  varFORDPO6190 := '';

        if assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnClassificacao]) then
            varClassificacao :=  dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnClassificacao].AsString
        else  varClassificacao := '';


        if not FDQueryCategoria.Locate( 'TIQF_CATEGORIA_DESCRICAO', varTIQF_CATEGORIA, [] ) then
        begin


            varCategoriaNova.Add(IntToStr(varCODFOR)  + ';' +
                                 varTIQF_CATEGORIA + ';' +
                                 varNOMFOR + ';' +
                                 varFORATIVO + ';' +
                                 varFORDOCCER + ';' +
                                 varFORDOCMANUAL + ';' +
                                 varFORDOCSUPA + ';' +
                                 varFORDOCBALP + ';' +
                                 varFORDPO0029  + ';' +
                                 varFORDPO3045 + ';' +
                                 varFORDPO4660 + ';' +
                                 varFORDPO6190 + ';' +
                                 varClassificacao + ';');

            varBCategoriaNova := True;

        end
        else
        begin

            if not FDQueryTIQF_Fornecedor.Locate( 'TIQF_FORSAP', varCODFOR, [] ) then
            begin

              Mensagem( 'Criando fornecedor ("' + varNOMFOR + '")...' );
              FDQueryTIQF_Fornecedor.Append;

              FDQueryTIQF_FornecedorTIQF_FORSAP.AsInteger        := varCODFOR;
              FDQueryTIQF_FornecedorTIQF_FORNOM.AsString         := varNOMFOR;
              FDQueryTIQF_FornecedorTIQF_FORATI.AsString         := varFORATIVO;
              FDQueryTIQF_FornecedorTIQF_FORCER.AsString         := varFORDOCCER;

            //  FDQueryTIQF_FornecedorTIQF_FORCERDATVAL.AsDateTime := varFORCERDATVAL;
              FDQueryTIQF_FornecedorTIQF_FORDOCMANUAL.AsString   := varFORDOCMANUAL;
              FDQueryTIQF_FornecedorTIQF_FORDOCSUPA.AsString     := varFORDOCSUPA;
              FDQueryTIQF_FornecedorTIQF_FORDOCBALP.AsString     := varFORDOCBALP;

              FDQueryTIQF_FornecedorTIQF_CATEGORIA.AsString      := varTIQF_CATEGORIA;
             { FDQueryTIQF_FornecedorTIQF_DTMANUAL.AsDateTime     := varTIQF_DTMANUAL;
              FDQueryTIQF_FornecedorTIQF_DTSUPPLY.AsDateTime     := varTIQF_DTSUPPLY;
              FDQueryTIQF_FornecedorTIQF_DTBALANCO.AsDateTime    := varTIQF_DTBALANCO;
              FDQueryTIQF_FornecedorTIQF_DTDOP.AsDateTime        := varTIQF_DTDOP;
             }
              FDQueryTIQF_FornecedorTIQF_CLASSIFICACAO.AsString  := varClassificacao;


              if varFORDPO0029 <> '' then
                 FDQueryTIQF_FornecedorTIQF_FORDPODIAS.AsString :=  '0'
              else if varFORDPO3045 <> '' then
                 FDQueryTIQF_FornecedorTIQF_FORDPODIAS.AsString :=  '1'
              else if varFORDPO4660 <> '' then
                 FDQueryTIQF_FornecedorTIQF_FORDPODIAS.AsString :=  '2'
              else if varFORDPO6190 <> '' then
                 FDQueryTIQF_FornecedorTIQF_FORDPODIAS.AsString :=  '3';

              try

                FDQueryTIQF_Fornecedor.Post;

              except

                FDQueryTIQF_Fornecedor.Cancel;

              end;

            end
            else
            begin

              Mensagem( 'Alterando fornecedor ("' + varNOMFOR + '")...' );
              FDQueryTIQF_Fornecedor.Edit;

              FDQueryTIQF_FornecedorTIQF_FORSAP.AsInteger        := varCODFOR;
              FDQueryTIQF_FornecedorTIQF_FORNOM.AsString         := varNOMFOR;
              FDQueryTIQF_FornecedorTIQF_FORATI.AsString         := varFORATIVO;
              FDQueryTIQF_FornecedorTIQF_FORCER.AsString         := varFORDOCCER;

            //  FDQueryTIQF_FornecedorTIQF_FORCERDATVAL.AsDateTime := varFORCERDATVAL;
              FDQueryTIQF_FornecedorTIQF_FORDOCMANUAL.AsString   := varFORDOCMANUAL;
              FDQueryTIQF_FornecedorTIQF_FORDOCSUPA.AsString     := varFORDOCSUPA;
              FDQueryTIQF_FornecedorTIQF_FORDOCBALP.AsString     := varFORDOCBALP;

              FDQueryTIQF_FornecedorTIQF_CATEGORIA.AsString      := varTIQF_CATEGORIA;
             { FDQueryTIQF_FornecedorTIQF_DTMANUAL.AsDateTime     := varTIQF_DTMANUAL;
              FDQueryTIQF_FornecedorTIQF_DTSUPPLY.AsDateTime     := varTIQF_DTSUPPLY;
              FDQueryTIQF_FornecedorTIQF_DTBALANCO.AsDateTime    := varTIQF_DTBALANCO;
              FDQueryTIQF_FornecedorTIQF_DTDOP.AsDateTime        := varTIQF_DTDOP;
             }
              FDQueryTIQF_FornecedorTIQF_CLASSIFICACAO.AsString  := varClassificacao;


              if varFORDPO0029 <> '' then
                 FDQueryTIQF_FornecedorTIQF_FORDPODIAS.AsString :=  '0'
              else if varFORDPO3045 <> '' then
                 FDQueryTIQF_FornecedorTIQF_FORDPODIAS.AsString :=  '1'
              else if varFORDPO4660 <> '' then
                 FDQueryTIQF_FornecedorTIQF_FORDPODIAS.AsString :=  '2'
              else if varFORDPO6190 <> '' then
                 FDQueryTIQF_FornecedorTIQF_FORDPODIAS.AsString :=  '3';

              try

                FDQueryTIQF_Fornecedor.Post;

              except

                FDQueryTIQF_Fornecedor.Cancel;

              end;

            end;
        end;

      end;

      if varBCategoriaNova then
      begin
          varCategoriaNova.SaveToFile( ExtractFilePath( cxTextEditFileName.Text ) + 'NovaCategoria.csv' );
          Application.MessageBox( pchar('Categoria(s) Nova(s). Registro(s) n�o importado(s)' + #13#10 +
           ExtractFilePath( cxTextEditFileName.Text ) + 'NovaCategoria.csv'), 'S&OP', MB_ICONINFORMATION );
      end;


    finally

      FreeAndNil(dxSpreadSheet);
      FreeAndNil(varCategoriaNova);
    end;


    Application.MessageBox( 'Importa��o conclu�da com sucesso!!!', 'S&OP', MB_ICONINFORMATION );

    Mensagem( EmptyStr );

  except

    on E: Exception do
    begin

      Mensagem( EmptyStr );
      raise Exception.Create('Erro no processamento.' + #13#10 + E.Message);

    end;

  end;

end;

procedure TFr_ImportarIQFFornecedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  FDQueryTIQF_Periodo.Close;
  FDConnection.Close;

  Fr_ImportarIQFFornecedor := nil;
  Action := caFree;

end;

procedure TFr_ImportarIQFFornecedor.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;

end.
