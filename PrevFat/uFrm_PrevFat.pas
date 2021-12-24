unit uFrm_PrevFat;

interface

uses
  System.DateUtils,
  System.StrUtils,
  ShellAPI,
  dxSpreadSheet,
  dxSpreadSheetTypes,
  dxSpreadSheetCore,
  cxCurrencyEdit,
  uUtils,
  System.IOUtils,
  IniFiles,
  System.RegularExpressions,
  ComObj,
  Excel,

  idGlobal,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL,
  IdIMAP4,
  IdMessage,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdExplicitTLSClientServerBase,
  IdMessageClient,
  IdSMTPBase,
  IdSMTP,
  IdAttachment,
  IdText,
  IdAttachmentFile,
  SQLTimST,
  XML.XMLIntf,
  Xml.XMLDoc,
  Soap.SOAPHTTPClient,



  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Phys, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  dxSkinscxPCPainter, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, Vcl.StdCtrls,
  cxButtons, cxTextEdit, cxMaskEdit, cxButtonEdit, cxLabel, dxGDIPlusClasses,
  Vcl.ExtCtrls, cxPC, Datasnap.Provider, Datasnap.DBClient, cxGroupBox,
  cxCheckGroup, Vcl.Buttons, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid;

type
  TFrm_Previsao = class(TForm)
    FDManager: TFDManager;
    FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
    FDConnection: TFDConnection;
    FDQueryTmp: TFDQuery;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    Page: TcxPageControl;
    TabEmail: TcxTabSheet;
    cxLabel9: TcxLabel;
    cxButtonEditPath: TcxButtonEdit;
    cxButtonProcessar: TcxButton;
    SaveDialog: TSaveDialog;
    FDSSalvaPrevisao: TFDQuery;
    DSSalvaPrevisao: TDataSetProvider;
    CDSSalvaPrevisao: TClientDataSet;
    TabConfig: TcxTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    edtHost: TEdit;
    Panel2: TPanel;
    Label2: TLabel;
    edtPort: TEdit;
    Panel3: TPanel;
    Label3: TLabel;
    edtUserName: TEdit;
    Panel4: TPanel;
    Label4: TLabel;
    edtPassword: TEdit;
    Panel5: TPanel;
    Label5: TLabel;
    edtFrom: TEdit;
    Panel6: TPanel;
    Label6: TLabel;
    edtAssunto: TEdit;
    TabCopia: TcxTabSheet;
    rgSSL: TRadioGroup;
    rgTLS: TRadioGroup;
    btnSalvarINI: TBitBtn;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    FDQueryEmail: TFDQuery;
    DataSourceEmail: TDataSource;
    cxGridEmail: TcxGrid;
    cxTableViewEmail: TcxGridDBTableView;
    cxGridLevelEmail: TcxGridLevel;
    FDQueryEmailTSOP_EMAILCOD: TFDAutoIncField;
    FDQueryEmailTSOP_PROGRAMA: TStringField;
    FDQueryEmailTSOP_EMAIL: TStringField;
    FDQueryEmailTSOP_ATIVO: TStringField;
    cxTableViewEmailTSOP_EMAIL: TcxGridDBColumn;
    cxTableViewEmailTSOP_ATIVO: TcxGridDBColumn;
    FDItem: TFDQuery;
    GroupBox1: TGroupBox;
    FDComprador: TFDQuery;
    FDOrdem: TFDQuery;
    edtPathSalvaExcel: TcxButtonEdit;
    procedure cxButtonEditPathClick(Sender: TObject);
    procedure cxButtonProcessarClick(Sender: TObject);
    procedure PageChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarINIClick(Sender: TObject);
    procedure edtHostKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rgSSLClick(Sender: TObject);
    procedure rgTLSClick(Sender: TObject);
    procedure FDQueryEmailBeforePost(DataSet: TDataSet);
  private
    varSMTP : TStringList;
    Mudou : Boolean;
    procedure Mensagem(pMensagem: String);
    procedure LimparTabela;
    function IsMatch(const Input, Pattern: string): boolean;
    function IsValidEmailRegEx(const EmailAddress: string): boolean;
    function ConectarEmailPadrao : Boolean;
    procedure EnviarMalaDireta;
    procedure CarregaINI;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Previsao: TFrm_Previsao;

implementation

{$R *.dfm}


function TFrm_Previsao.ConectarEmailPadrao : Boolean;
var
  IdSSL       : TIdSSLIOHandlerSocketOpenSSL;
  idSMTP      : TIdSMTP;
begin
  idSMTP := TIdSMTP.Create(nil);
  Try
    IdSSL               := TIdSSLIOHandlerSocketOpenSSL.Create(Nil);
    idSMTP.IOHandler    := IdSSL;
    idSMTP.UseTLS       := utUseExplicitTLS;

    idSMTP.Host         := edtHost.Text;
    idSMTP.Username     := edtUserName.Text;
    idSMTP.Password     := edtPassword.Text;
    idSMTP.Port         := StrToInt(edtPort.Text);

    idSMTP.Connect();
    result := idSMTP.Authenticate;

  Finally
    idSMTP.Disconnect();
    FreeAndNil( idSMTP );
    FreeAndNil( IdSSL  );

  End;


end;

procedure TFrm_Previsao.btnSalvarINIClick(Sender: TObject);
Var
  ArqIni: TIniFile;

begin

{   if not ConectarEmailPadrao then
  begin
     Application.MessageBox( 'Configura��o de Conta de E-mail Padr�o Incorreta - N�o foi poss�vel conectar na Conta de E-mail', 'Configura��o', MB_ICONEXCLAMATION);
     Exit;
  end;
 }
  Mensagem('Aguarde...');
  Try

    DeleteFile(MyDocumentsPath + '\SMTP_PREVFAT.ini');

  except
  on E: Exception do
      begin

        ShowMessage( E.Message );

      end;
  End;

  ArqIni := TIniFile.Create(MyDocumentsPath + '\SMTP_PREVFAT.ini');


   try
    ArqIni.WriteString('[EMAIL]','','');

    ArqIni.WriteString('EMAIL', 'HOST', edtHost.Text);
    ArqIni.WriteString('EMAIL', 'PORT', edtPort.Text);

    if  rgSSL.ItemIndex = 0 then
     ArqIni.WriteString('EMAIL', 'SSL', 'Sim')
    else    ArqIni.WriteString('EMAIL', 'SSL', 'N�o');

    if  rgTLS.ItemIndex = 0 then
      ArqIni.WriteString('EMAIL', 'TLS', 'Sim')
    else    ArqIni.WriteString('EMAIL', 'TLS', 'N�o');

    ArqIni.WriteString('EMAIL', 'USER', edtUserName.Text);
    ArqIni.WriteString('EMAIL', 'PWD', edtPassword.Text);
    ArqIni.WriteString('EMAIL', 'FROM', edtFrom.Text);
    ArqIni.WriteString('EMAIL', 'ASSUNTO', edtAssunto.Text);
    ArqIni.WriteString('PASTA', 'SALVAR_EXCEL', edtPathSalvaExcel.Text);

    Mensagem(EmptyStr);
    Application.MessageBox( 'Altera��o do E-mail Padr�o Salvas com Sucesso.', 'Configura��o', MB_ICONINFORMATION);

  finally
     Mudou := False;
     ArqIni.Free;
  end;



end;

procedure TFrm_Previsao.cxButtonEditPathClick(Sender: TObject);
begin
  if SaveDialog.Execute(Handle) then
  begin
    cxButtonEditPath.Text := SaveDialog.FileName;
  end;
end;

procedure  TFrm_Previsao.LimparTabela;
begin
  FDQueryTmp.Close;
  FDQueryTmp.SQL.Clear;
  FDQueryTmp.SQL.Add('Truncate Table TSOP_PREVISAOFAT');
  FDQueryTmp.ExecSQL;
end;

procedure TFrm_Previsao.Mensagem(pMensagem: String);
var
  I, X, Y, varAno, varMes : Integer;
  dxSpreadSheet: TdxSpreadSheet;

begin
  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;
end;

procedure TFrm_Previsao.cxButtonProcessarClick(Sender: TObject);
var
  I, X, Y, varAno, varMes, varContador, varLinha : Integer;
  dxSpreadSheet: TdxSpreadSheet;
  varOrdemvendas, varCodigoCliente,	varNomeCliente, varCodigoComprador, varEmailComprador,
  varItemOV, varCodigoMaterial, varCodigoMaterialCatalogo, varDescricaoMaterial, varQtdSerEntregue, varUMSerEntregue,
  varQtdedaOrdem, varUMOrdem  : String;

  varDataPrevistaEntrega : TDateTime;

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
      LimparTabela;
      CDSSalvaPrevisao.Open;


      Mensagem( 'Lendo linhas da planilha...' );
      varContador := 1;
      varLinha :=  dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex;
      for X := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
      begin

         try

          if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0]) then
            Exit;

          if dxSpreadSheet.ActiveSheetAsTable.Rows[X].CellCount < 14 then
            Continue;

          Mensagem( 'Linha (" ' + IntToStr(X) + '/' + IntToStr(dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex) + '") "' + Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[4].AsString) + '" ...' );

          if Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString) = EmptyStr then
            Continue;

        except

          Continue;

        end;

        varOrdemvendas            := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString;
        varCodigoCliente          := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[1].AsString;
        varNomeCliente            := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsString;
        varCodigoComprador        := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[3].AsString;
        varEmailComprador         := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[4].AsString;

        varItemOV                 := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[5].AsString;
        varCodigoMaterial         := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6].AsString;
        varCodigoMaterialCatalogo := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[7].AsString;
        varDescricaoMaterial      := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[8].AsString;

        varQtdSerEntregue         := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[9].AsString;
        varUMSerEntregue          := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[10].AsString;
        varQtdedaOrdem            := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[11].AsString;
        varUMOrdem                := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[12].AsString;
        varDataPrevistaEntrega    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[13].AsDateTime;

        CDSSalvaPrevisao.Append;
        CDSSalvaPrevisao.FieldByName('TSOP_PREVISAOFAT_ID').AsInteger         :=  varContador;

        CDSSalvaPrevisao.FieldByName('TSOP_ORDBILNRODOCREF').AsString         :=  varOrdemvendas;
        CDSSalvaPrevisao.FieldByName('TSOP_ORDBILCLICOD').AsString            :=  varCodigoCliente;
        CDSSalvaPrevisao.FieldByName('TSOP_ORDBILCLINOM').AsString            :=  varNomeCliente;
        CDSSalvaPrevisao.FieldByName('TSOP_ORDBILREPNOM').AsString            :=  varCodigoComprador;
        CDSSalvaPrevisao.FieldByName('TSOP_ORDBILEMAILCOMPRADOR').AsString    :=  varEmailComprador;

        CDSSalvaPrevisao.FieldByName('TSOP_ORDBILITECOD').AsString            :=  varItemOV;
        CDSSalvaPrevisao.FieldByName('TSOP_CODIGOMATERIAL').AsString          :=  varCodigoMaterial;
        CDSSalvaPrevisao.FieldByName('TSOP_YNUMBER').AsString                 :=  varCodigoMaterialCatalogo;
        CDSSalvaPrevisao.FieldByName('TSOP_ORDBILITENOM').AsString            :=  varDescricaoMaterial;


        CDSSalvaPrevisao.FieldByName('TSOP_ORDBILITEUNIENTREGUE').AsString    :=  UpperCase(varUMSerEntregue);
        CDSSalvaPrevisao.FieldByName('TSOP_ORDBILQTDENTREGUE').AsString       :=  varQtdSerEntregue;
        CDSSalvaPrevisao.FieldByName('TSOP_ORDBILITEUNIQTD').AsString         :=  UpperCase(varUMOrdem);
        CDSSalvaPrevisao.FieldByName('TSOP_ORDBILQTD').AsString               :=  varQtdedaOrdem;
        CDSSalvaPrevisao.FieldByName('TSOP_ORDBILDATPREVENT').AsDateTime      :=  varDataPrevistaEntrega;

        try
          CDSSalvaPrevisao.Post;
        except
          on E: Exception do
          begin
            ShowMessage(E.Message);
            CDSSalvaPrevisao.Cancel;
          end;
        end;


        try

          CDSSalvaPrevisao.ApplyUpdates(-1);

        except

          on E: Exception do
          begin

            ShowMessage( E.Message );

          end;

        end;

        varContador := varContador + 1;

        Application.ProcessMessages;

      end;
      finally

        FDConnection.Close;
        CDSSalvaPrevisao.Close;
      end;

      Mensagem( 'Fim..' );

    finally

      FreeAndNil(dxSpreadSheet);

    end;
  finally
       Mensagem( EmptyStr );
        cxButtonEditPath.Clear;
  end;

end;


procedure TFrm_Previsao.EnviarMalaDireta;
var
  Planilha: OleVariant;
  I, X, J, ContaCliente : Integer;
  varCor1,varCor2: TColor;

begin
  Planilha:= CreateOleObject('Excel.Application');

  Planilha.visible:=false;
  Planilha.workbooks.add(1);

  Planilha.cells[1,1]:='N� Item OV';
  Planilha.cells[1,2]:='C�digo material';
  Planilha.cells[1,3]:='C�digo material cat�logo';
  Planilha.cells[1,4]:='Descri��o material';
  Planilha.cells[1,5]:='Qtd a ser entregue';
  Planilha.cells[1,6]:='UM';
  Planilha.cells[1,7]:='Quantidade da Ordem';
  Planilha.cells[1,8]:='UM';
  Planilha.cells[1,9]:='Data prevista Entrega';

  FDComprador.Close;
  FDComprador.SQL.Clear;
  FDComprador.SQL.Add('SELECT DISTINCT TSOP_ORDBILEMAILCOMPRADOR FROM TSOP_PREVISAOFAT ORDER BY TSOP_ORDBILEMAILCOMPRADOR ');
  FDComprador.Open;
  if not FDComprador.IsEmpty then
  begin
     while not FDComprador.Eof do
     begin

        FDOrdem.Close;
        FDOrdem.SQL.Clear;
        FDOrdem.SQL.Add(' Select TSOP_ORDBILNRODOCREF, TSOP_ORDBILCLICOD, TSOP_ORDBILCLINOM, TSOP_ORDBILREPNOM, TSOP_ORDBILEMAILCOMPRADOR ');
        FDOrdem.SQL.Add(' From TSOP_PREVISAOFAT ');
        FDOrdem.SQL.Add(' Where TSOP_ORDBILEMAILCOMPRADOR = :TSOP_ORDBILEMAILCOMPRADOR ');
        FDOrdem.Params.ParamByName('TSOP_ORDBILEMAILCOMPRADOR').AsString := FDComprador.FieldByName('TSOP_ORDBILEMAILCOMPRADOR').AsString;
        FDOrdem.Open;
        Planilha.caption := FDComprador.FieldByName('TSOP_ORDBILCLINOM').AsString;
        if not FDOrdem.IsEmpty then
        begin
           while not FDOrdem.Eof do
           begin
                FDItem.Close;
                FDItem.SQL.Clear;
                FDItem.SQL.Add( ' SELECT TSOP_ORDBILITECOD, TSOP_CODIGOMATERIAL, TSOP_YNUMBER, TSOP_ORDBILITENOM, TSOP_ORDBILITEUNIENTREGUE, ' );
                FDItem.SQL.Add( ' TSOP_ORDBILQTDENTREGUE, TSOP_ORDBILITEUNIQTD, TSOP_ORDBILQTD, TSOP_ORDBILDATPREVENT ');
                FDItem.SQL.Add( ' FROM TSOP_PREVISAOFAT ');
                FDItem.SQL.Add( ' WHERE  TSOP_ORDBILEMAILCOMPRADOR = :TSOP_ORDBILEMAILCOMPRADOR  AND TSOP_ORDBILNRODOCREF = :TSOP_ORDBILNRODOCREF ');
                FDItem.Params.ParamByName('TSOP_ORDBILEMAILCOMPRADOR').AsString := FDComprador.FieldByName('TSOP_ORDBILEMAILCOMPRADOR').AsString;
                FDItem.Params.ParamByName('TSOP_ORDBILNRODOCREF').AsString      := FDOrdem.FieldByName('TSOP_ORDBILNRODOCREF').AsString;
                FDItem.Open;
                 X := 2;
                if not FDItem.Eof then
                begin
                   Planilha.cells[X, 1] :=  FDItem.Fields[0].AsString; //CSR
                   Planilha.cells[X, 2] :=  FDItem.Fields[1].AsString;  //Vendedor
                   Planilha.cells[X, 3] :=  FDItem.Fields[2].AsString; //Grupo

                   Planilha.cells[X, 4] :=  FDItem.Fields[3].AsString;  //Codigo
                   Planilha.cells[X, 5] :=  FDItem.Fields[4].AsString;  //Cliente
                   Planilha.cells[X, 6] :=  FDItem.Fields[5].AsString;   //Site
                   Planilha.cells[X, 7] :=  FDItem.Fields[6].AsString; //Canal
                   Planilha.cells[X, 8] :=  FDItem.Fields[7].AsString;  //Regi�o
                   Planilha.cells[X, 9] :=  FDItem.Fields[8].AsString; //Estado


                   FDItem.Next;
                end;



                Planilha.columns.autofit;
                Planilha.Visible:=True;
                Planilha.workbooks[1].SaveAs( cxButtonEditPath.Text , xlWorkbookDefault);
                Planilha:= Unassigned;


               FDOrdem.Next;
           end;
        end;

        FDComprador.Next;
     end;

  end;
end;





procedure TFrm_Previsao.edtHostKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    Mudou := True;
end;

procedure TFrm_Previsao.FDQueryEmailBeforePost(DataSet: TDataSet);
begin
  if IsValidEmailRegEx(FDQueryEmailTSOP_EMAIL.AsString) then
      FDQueryEmailTSOP_EMAIL.AsString := UpperCase(FDQueryEmailTSOP_EMAIL.AsString)
  else
  begin
      Application.MessageBox( 'E-mail Inv�lido, Verifique.', 'Configura��o', MB_ICONEXCLAMATION);
      FDQueryEmail.Cancel;
      Exit;
  end;
  FDQueryEmailTSOP_PROGRAMA.AsString := 'SOP_PREVISAOFATURAMENTO';
  FDQueryEmailTSOP_ATIVO.AsString := UpperCase(FDQueryEmailTSOP_ATIVO.AsString);
end;

procedure TFrm_Previsao.FormShow(Sender: TObject);
begin
 if not System.IOUtils.TFile.Exists( MyDocumentsPath + '\SMTP_PREVFAT.ini' ) then
   System.IOUtils.TFile.Copy( ExtractFilePath(Application.ExeName) + '\SMTP_PREVFAT.ini' , MyDocumentsPath + '\SMTP_PREVFAT.ini', True );

 CarregaINI;
end;

function TFrm_Previsao.IsMatch(const Input, Pattern: string): boolean;
begin
 Result := TRegEx.IsMatch(Input, Pattern);
end;

function TFrm_Previsao.IsValidEmailRegEx(const EmailAddress: string): boolean;
const
  EMAIL_REGEX = '^((?>[a-zA-Z\d!#$%&''*+\-/=?^_`{|}~]+\x20*|"((?=[\x01-\x7f])'
             +'[^"\\]|\\[\x01-\x7f])*"\x20*)*(?<angle><))?((?!\.)'
             +'(?>\.?[a-zA-Z\d!#$%&''*+\-/=?^_`{|}~]+)+|"((?=[\x01-\x7f])'
             +'[^"\\]|\\[\x01-\x7f])*")@(((?!-)[a-zA-Z\d\-]+(?<!-)\.)+[a-zA-Z]'
             +'{2,}|\[(((?(?<!\[)\.)(25[0-5]|2[0-4]\d|[01]?\d?\d))'
             +'{4}|[a-zA-Z\d\-]*[a-zA-Z\d]:((?=[\x01-\x7f])[^\\\[\]]|\\'
             +'[\x01-\x7f])+)\])(?(angle)>)$';
begin
  Result := IsMatch(EmailAddress, EMAIL_REGEX);
end;


Procedure TFrm_Previsao.CarregaINI;
Var
  ArqIni: TIniFile;
  varSSL, varTLS : String;
begin
         try

        if FileExists(MyDocumentsPath + '\SMTP_PREVFAT.ini') then
        begin

           ArqIni := TIniFile.Create(MyDocumentsPath + '\SMTP_PREVFAT.ini');

        end
        else
        begin

          ArqIni := TIniFile.Create(ExtractFileDir(ParamStr(0)) + '\SMTP_PREVFAT.ini');

        end;
         edtHost.Text := ArqIni.ReadString('EMAIL', 'HOST', edtHost.Text);
         edtPort.Text := ArqIni.ReadString('EMAIL', 'PORT', edtPort.Text);


         varSSL := ArqIni.ReadString('EMAIL', 'SSL', varSSL);
         varTLS := ArqIni.ReadString('EMAIL', 'TLS', varTLS);


          if varSSL = 'Sim' Then
            rgSSL.ItemIndex := 0
           else rgSSL.ItemIndex := 1;


           if varTLS = 'Sim' Then
            rgTLS.ItemIndex := 0
           else rgTLS.ItemIndex := 1;

         edtUsername.Text := ArqIni.ReadString('EMAIL', 'USER', edtUsername.Text);
         edtPassword.Text := ArqIni.ReadString('EMAIL', 'PWD', edtPassword.Text);
         edtFrom.Text     := ArqIni.ReadString('EMAIL', 'FROM', edtFrom.Text);
         edtAssunto.Text  := ArqIni.ReadString('EMAIL', 'ASSUNTO', edtAssunto.Text);

         edtPathSalvaExcel.Text :=  ArqIni.ReadString('PASTA', 'SALVAR_EXCEL', edtPathSalvaExcel.Text);

         Mudou := False;


      finally
         ArqIni.Free;
      end;
end;


procedure TFrm_Previsao.PageChange(Sender: TObject);

begin

  if Page.ActivePage <> TabConfig then
  begin
    if Mudou then
    begin
      Application.MessageBox( 'Altera��o do E-mail Padr�o N�o Foram Salvas...', 'Configura��o', MB_ICONEXCLAMATION);
      Exit;
    end;
  end else if Page.ActivePage = TabConfig then
  begin
     CarregaINI;

  end;

  if Page.ActivePage = TabCopia then
  begin

    try

      Mensagem( 'Obtendo dados (E-mail (CC))...' );
      FDQueryEmail.Open;

    finally

      Mensagem( EmptyStr );

    end;


  end;


end;

procedure TFrm_Previsao.rgSSLClick(Sender: TObject);
begin
  Mudou := True;
end;

procedure TFrm_Previsao.rgTLSClick(Sender: TObject);
begin
  Mudou := True;
end;

end.
