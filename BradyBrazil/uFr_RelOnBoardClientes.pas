unit uFr_RelOnBoardClientes;

interface

uses
  System.DateUtils,
  ComObj,
  Excel,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinOffice2013White,
  dxSkinscxPCPainter, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxContainer, cxEdit, cxButtonEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLabel, Vcl.StdCtrls, cxButtons, cxPC,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxGrid,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  dxGDIPlusClasses, Vcl.ExtCtrls, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
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
  dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TFr_RelOnBoardClientes = class(TForm)
    cxPageControlFiltro: TcxPageControl;
    cxTabSheetFiltro: TcxTabSheet;
    Label1: TLabel;
    Label3: TLabel;
    cxButtonRefresh: TcxButton;
    cxLabel1: TcxLabel;
    cxCanal: TcxComboBox;
    ButExcel: TcxButton;
    cbPeriodo: TcxComboBox;
    cxButtonEditPath: TcxButtonEdit;
    Page: TcxPageControl;
    tabBaseClientes: TcxTabSheet;
    cxGrid1: TcxGrid;
    cxGrid1DBBandedTableView1: TcxGridDBBandedTableView;
    cxGrid1Level1: TcxGridLevel;
    FDQueryBase: TFDQuery;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    FDConnection: TFDConnection;
    dsQueryBase: TDataSource;
    SaveDialog: TSaveDialog;
    lblPeriodo: TLabel;
    procedure Mensagem(pMensagem : String);
    procedure cxButtonRefreshClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButExcelClick(Sender: TObject);
    procedure cxButtonEditPathClick(Sender: TObject);
  private
    { Private declarations }
    MesInicial, MesFinal, PeriodoInicial, PeriodoFinal : TDateTime;
    ABand : TcxGridBand;
    procedure MontaData(iMes : Integer);
    procedure AddColumnGrid1;
    procedure Imprimir;
  public
    { Public declarations }

        procedure AbrirDataset;
  end;

var
  Fr_RelOnBoardClientes: TFr_RelOnBoardClientes;

implementation

{$R *.dfm}

uses uUtils, uBrady;

procedure TFr_RelOnBoardClientes.AbrirDataset;
begin
  Mensagem('Abrindo conex�o...');
  try

    if not FDConnection.Connected then
    begin

      FDConnection.Params.LoadFromFile(MyDocumentsPath + '\DB.ini');
      FDConnection.Open;

    end;

    MontaData(cbPeriodo.ItemIndex);

    Mensagem('Obtendo dados (OnBoard Clientes)...');

    FDQueryBase.Close;
    FDQueryBase.SQL.Clear;

    FDQueryBase.SQL.add('SELECT DISTINCT A01.TSOP_ORDBILCLICOD,A01.TSOP_ORDBILREPNOM,A01.TSOP_ORDBILGRUCLINOM, ');
    FDQueryBase.SQL.add('A01.TSOP_ORDBILCLINOM,A01.TSOP_ORDBILSITNOM,A01.TSOP_ORDBILCANNOM,A01.TSOP_ORDBILREG, ');
    FDQueryBase.SQL.add('A01.TSOP_ORDBILREGEST,  A01.TSOP_REPCSR, ');


    FDQueryBase.SQL.add('	 (SELECT MAX(TSOP_ORDBILDATDOCREQ) FROM VSOP_ORDERBILLINGFULL D01 WITH(NOLOCK)  ');
    FDQueryBase.SQL.add('     WHERE  D01.TSOP_ORDBILTIPDOC  IN (''BILLING'',''RETURN'')   AND D01.TSOP_ORDBILDATDOCREQ <= :PERIODO_FINAL ');
    FDQueryBase.SQL.add('	    AND D01.TSOP_ORDBILCLICOD = A01.TSOP_ORDBILCLICOD ');
    FDQueryBase.SQL.add('		AND D01.TSOP_ORDBILCANNOM = A01.TSOP_ORDBILCANNOM ) AS TSOP_ORDBILDATDOCREQ,  ');

    FDQueryBase.SQL.add('	 (SELECT MAX(TSOP_ORDBILNRODOC) FROM VSOP_ORDERBILLINGFULL D01 WITH(NOLOCK) ');
    FDQueryBase.SQL.add('     WHERE  D01.TSOP_ORDBILTIPDOC  IN (''BILLING'',''RETURN'')   AND D01.TSOP_ORDBILDATDOCREQ <=  :PERIODO_FINAL ');
    FDQueryBase.SQL.add('	    AND D01.TSOP_ORDBILCLICOD = A01.TSOP_ORDBILCLICOD  ');
    FDQueryBase.SQL.add('		AND D01.TSOP_ORDBILCANNOM = A01.TSOP_ORDBILCANNOM ) AS TSOP_ORDBILNRODOC   ');


    FDQueryBase.SQL.add('FROM dbo.VSOP_OrderBillingFull A01 ');
    FDQueryBase.SQL.add('WHERE 1=1  ');
    FDQueryBase.SQL.Add('    &WHERE1  ');
    FDQueryBase.SQL.add('AND A01.TSOP_ORDBILDATDOCREQ BETWEEN :MES_INICIAL  ');
    FDQueryBase.SQL.add('                                 AND :MES_FINAL  ');
    FDQueryBase.SQL.add('AND A01.TSOP_ORDBILTIPDOC <> ''Billing''  AND A01.TSOP_ORDBILTIPDOC <> ''Return''  ');

    FDQueryBase.SQL.add('  AND  NOT EXISTS (SELECT TSOP_ORDBILCLICOD  FROM VSOP_ORDERBILLINGFULL D01 WITH(NOLOCK)   ');
	  FDQueryBase.SQL.add('									WHERE D01.TSOP_ORDBILTIPDOC  IN (''Billing'',''Return'')  ');
 	  FDQueryBase.SQL.add('					    AND D01.TSOP_ORDBILDATDOCREQ >=  :PERIODO_INICIAL ');
 	  FDQueryBase.SQL.add('             AND D01.TSOP_ORDBILDATDOCREQ <= :PERIODO_FINAL ');
 	  FDQueryBase.SQL.add('             AND D01.TSOP_ORDBILCLICOD = A01.TSOP_ORDBILCLICOD )');


    FDQueryBase.ParamByName('MES_INICIAL').AsDateTime     := MesInicial;
    FDQueryBase.ParamByName('MES_FINAL').AsDateTime       := MesFinal;
    FDQueryBase.ParamByName('PERIODO_INICIAL').AsDateTime := PeriodoInicial;
    FDQueryBase.ParamByName('PERIODO_FINAL').AsDateTime   := PeriodoFinal;
    lblPeriodo.Caption := 'Per�odo Avaliado: ' +  DateToStr(PeriodoInicial) + ' At� ' +  DateToStr(PeriodoFinal);



    if cxCanal.Text <> '' then
      FDQueryBase.MacroByName('WHERE1').AsRaw := ' AND A01.TSOP_ORDBILCANNOM = '
        + QuotedStr(cxCanal.Text);

    FDQueryBase.SQL.SaveToFile('C:\Brady\OnBoardCliente_2021.sql');

    // Criando Tabela no Banco
    FDQueryBase.Open;

  finally


    Mensagem(EmptyStr);

  end;

end;

procedure TFr_RelOnBoardClientes.cxButtonEditPathClick(Sender: TObject);
begin
  SaveDialog.InitialDir := GetCurrentDir;
  if SaveDialog.Execute(Handle) then
  begin
    cxButtonEditPath.Text := SaveDialog.FileName;
  end;
end;

procedure TFr_RelOnBoardClientes.cxButtonRefreshClick(Sender: TObject);
begin
  FDQueryBase.Close;
  lblPeriodo.Caption := 'Per�odo Avaliado:';
  AbrirDataset;

  cxGrid1DBBandedTableView1.ClearItems;

  if ABand <> Nil then
  begin
    ABand.Bands.Clear;
  end;

  AddColumnGrid1;
end;


procedure TFr_RelOnBoardClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FDQueryBase.Close;
  Mensagem('');
  Fr_RelOnBoardClientes := nil;
  Action := caFree;
end;

procedure TFr_RelOnBoardClientes.AddColumnGrid1;
var
  AColumn: TcxGridDBBandedColumn;
  I : Integer;
  sumItem: TcxDataSummaryItem;
begin
  cxGrid1DBBandedTableView1.BeginUpdate();
  cxGrid1DBBandedTableView1.DataController.CreateAllItems;
  //cxGrid1DBBandedTableView1.OptionsView.FixedBandSeparatorWidth := 2;


  try

    ABand := cxGrid1DBBandedTableView1.Bands.Add;
    ABand.Index := 0;
    ABand.HeaderAlignmentHorz := taCenter;
    ABand.Caption := 'OnBoard Clientes';
    ABand.FixedKind := fkLeft;


    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'CSR';
    AColumn.DataBinding.FieldName :=  FDQueryBase.Fields[8].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Acc Owner';
    AColumn.DataBinding.FieldName := FDQueryBase.Fields[0].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Grupo';
    AColumn.DataBinding.FieldName := FDQueryBase.Fields[1].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 180;
    AColumn.Caption := 'C�digo';
    AColumn.DataBinding.FieldName := FDQueryBase.Fields[2].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 350;
    AColumn.Caption := 'Nome';
    AColumn.DataBinding.FieldName := FDQueryBase.Fields[3].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 60;
    AColumn.Caption := 'Site';
    AColumn.DataBinding.FieldName := FDQueryBase.Fields[4].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Canal';
    AColumn.DataBinding.FieldName := FDQueryBase.Fields[5].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 120;
    AColumn.Caption := 'Regi�o';
    AColumn.DataBinding.FieldName := FDQueryBase.Fields[6].FieldName;
    AColumn.Position.BandIndex := 0;

    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 40;
    AColumn.Caption := 'UF';
    AColumn.DataBinding.FieldName := FDQueryBase.Fields[7].FieldName;
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Ultima Compra';
    AColumn.DataBinding.FieldName := FDQueryBase.Fields[9].FieldName;
    AColumn.Position.BandIndex := 0;


    AColumn := cxGrid1DBBandedTableView1.CreateColumn;
    AColumn.Width := 100;
    AColumn.Caption := 'Numero da NF';
    AColumn.DataBinding.FieldName := FDQueryBase.Fields[10].FieldName;
    AColumn.Position.BandIndex := 0;





    cxGrid1DBBandedTableView1.OptionsView.Footer := True;
    cxGrid1DBBandedTableView1.OptionsView.GroupFooters := gfVisibleWhenExpanded;
    cxGrid1DBBandedTableView1.OptionsView.GroupFooterMultiSummaries := True;

    cxGrid1DBBandedTableView1.DataController.DataSource := dsQueryBase;


  finally
    cxGrid1DBBandedTableView1.EndUpdate;
  end;

end;


procedure TFr_RelOnBoardClientes.ButExcelClick(Sender: TObject);
begin
if Page.ActivePageIndex = 0 then
  begin

      if cxButtonEditPath.Text = EmptyStr then
        raise Exception.Create('Informe o arquivo primeiro.');


      if FDQueryBase.IsEmpty then
        raise Exception.Create('N�o h� dados para serem exportados ao Excel');

      Screen.Cursor := crHourGlass;
      Try
          Mensagem('Aguarde, Gerando a Planilha...');
          Imprimir;
      Finally
          Mensagem( EmptyStr );
          Screen.Cursor := crDefault;
      End;
  end;
end;



procedure   TFr_RelOnBoardClientes.Imprimir;
var
  Planilha: OleVariant;
  I, X, J, ContaCliente : Integer;
  varCor1,varCor2: TColor;
begin
  Planilha:= CreateOleObject('Excel.Application');
  Planilha.caption := 'OnBoard Cliente';
  Planilha.visible:=false;
  Planilha.workbooks.add(1);

  Planilha.cells[1,1]:='CSR';
  Planilha.cells[1,2]:='Vendedor';
  Planilha.cells[1,3]:='Grupo';
  Planilha.cells[1,4]:='C�digo';
  Planilha.cells[1,5]:='Cliente';
  Planilha.cells[1,6]:='Site';
  Planilha.cells[1,7]:='Canal';
  Planilha.cells[1,8]:='Regi�o';
  Planilha.cells[1,9]:='UF';
  Planilha.cells[1,10]:='Ultima Compra';
  Planilha.cells[1,11]:='Numero da NF';




  FDQueryBase.DisableControls;
  FDQueryBase.First;

  X := 2;
  ContaCliente := 0;
  while not FDQueryBase.eof do
  begin
       Planilha.cells[X, 1] :=  FDQueryBase.Fields[8].AsString; //CSR
       Planilha.cells[X, 2] :=  FDQueryBase.Fields[0].AsString;  //Vendedor
       Planilha.cells[X, 3] :=  FDQueryBase.Fields[1].AsString; //Grupo
       Planilha.cells[X, 4] :=  FDQueryBase.Fields[2].AsString;  //Codigo
       Planilha.cells[X, 5] :=  FDQueryBase.Fields[3].AsString;  //Cliente
       Planilha.cells[X, 6] :=  FDQueryBase.Fields[4].AsString;   //Site
       Planilha.cells[X, 7] :=  FDQueryBase.Fields[5].AsString; //Canal
       Planilha.cells[X, 8] :=  FDQueryBase.Fields[6].AsString;  //Regi�o
       Planilha.cells[X, 9] :=  FDQueryBase.Fields[7].AsString; //Estado
       Planilha.cells[X,10] :=  FDQueryBase.Fields[9].AsString;  //Ultima Compra
       Planilha.cells[X,11] :=  FDQueryBase.Fields[10].AsString;  //Numero da NF




       if Odd(X) then
        varCor1 := RGB(255,255,225)
       else
        varCor1 := RGB(216,234,204);

       Inc(X);


       FDQueryBase.Next;
  end;



  FDQueryBase.EnableControls;

  Planilha.columns.autofit;
  Planilha.Visible:=True;
  Planilha.workbooks[1].SaveAs( cxButtonEditPath.Text , xlWorkbookDefault);
  Planilha:= Unassigned;
  FDQueryBase.First;

end;


procedure TFr_RelOnBoardClientes.Mensagem(pMensagem: String);
begin
  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;
end;

procedure TFr_RelOnBoardClientes.MontaData(iMes: Integer);
var
  Ano, Mes, Dia : Word;
begin

  DecodeDate(Now, Ano, Mes, Dia);
  iMes           := iMes + 1;
  MesInicial     := EncodeDate(  Ano , iMes , 1);
  MesFinal       := EncodeDate(  Ano , iMes , DaysInaMonth(Ano,iMes));
  PeriodoInicial := IncMonth(System.DateUtils.StartOfTheMonth(MesInicial), -12);
  PeriodoFinal   := System.DateUtils.EndOfTheMonth(MesInicial);

end;

end.
