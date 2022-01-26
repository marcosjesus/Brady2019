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
  Vcl.FileCtrl,
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
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, ACBrMail,
  Vcl.ComCtrls, Vcl.ImgList;

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
    StatusBar: TStatusBar;
    BitBtn1: TBitBtn;
    chkCopia: TCheckBox;
    pnlEmail: TPanel;
    Panel7: TPanel;
    btnFecharPnl: TBitBtn;
    memEmail: TMemo;
    cxGroupBox1: TcxGroupBox;
    edtFrom: TEdit;
    cxGroupBox2: TcxGroupBox;
    edtUserName: TEdit;
    cxGroupBox3: TcxGroupBox;
    edtPassword: TEdit;
    cxGroupBox4: TcxGroupBox;
    edtDistriFrom: TEdit;
    cxGroupBox5: TcxGroupBox;
    edtDistriUserName: TEdit;
    cxGroupBox6: TcxGroupBox;
    edtDistriPassword: TEdit;
    rgDistriSSL: TRadioGroup;
    rgDistriTLS: TRadioGroup;
    cxGroupBox7: TcxGroupBox;
    edtInfoFrom: TEdit;
    cxGroupBox8: TcxGroupBox;
    edtInfoUserName: TEdit;
    cxGroupBox9: TcxGroupBox;
    edtInfoPassword: TEdit;
    rgInfoSSL: TRadioGroup;
    rgInfoTLS: TRadioGroup;
    cxGroupBox10: TcxGroupBox;
    edtAssunto: TEdit;
    cxGroupBox11: TcxGroupBox;
    EdiManausFrom: TEdit;
    cxGroupBox12: TcxGroupBox;
    EdiManausUserName: TEdit;
    cxGroupBox13: TcxGroupBox;
    EditManausPassword: TEdit;
    rgManausSSL: TRadioGroup;
    rgManausTLS: TRadioGroup;
    procedure cxButtonEditPathClick(Sender: TObject);
    procedure PageChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarINIClick(Sender: TObject);
    procedure edtHostKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rgSSLClick(Sender: TObject);
    procedure rgTLSClick(Sender: TObject);
    procedure FDQueryEmailBeforePost(DataSet: TDataSet);
    procedure edtPathSalvaExcelClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure chkCopiaClick(Sender: TObject);
    procedure btnFecharPnlClick(Sender: TObject);
    procedure edtPasswordExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    varAnexos: TStringList;
    varEmailInvalido : TStringList;
    dxSpreadSheet : TdxSpreadSheet;
    varSMTP : TStringList;
    Mudou : Boolean;
    ACBrMail: TACBrMail;
    procedure Mensagem(pMensagem: String);
    procedure LimparTabela;
    function IsMatch(const Input, Pattern: string): boolean;
    function IsValidEmailRegEx(const EmailAddress: string): boolean;
    function EnviarEmail (varEmail, varMensagem : String) : Boolean;
    procedure EnviarMalaDireta;
    procedure CarregaINI;
    procedure ConectarEmailPadrao;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Previsao: TFrm_Previsao;

implementation

{$R *.dfm}


procedure TFrm_Previsao.ConectarEmailPadrao;
var
  SSLHandler   : TIdSSLIOHandlerSocketOpenSSL;
  emMessage    : TIdMessage;
  emSMTP       : TIdSMTP;
  bEnvio       : Boolean;
  Attachment   : TIdAttachment;
  I            : Integer;
begin
  emSMTP     := TIdSMTP.Create;
  emMessage := TIdMessage.Create;
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  Try

   SSLHandler.MaxLineAction          := maException;

   SSLHandler.SSLOptions.Method      := sslvTLSv1;

   SSLHandler.SSLOptions.Mode        := sslmUnassigned;
   SSLHandler.SSLOptions.VerifyMode  := [];
   SSLHandler.SSLOptions.VerifyDepth := 0;

   emSMTP.IOHandler := SSLHandler;
   emSMTP.Host      := ACBrMail.Host;
   emSMTP.Port      := StrToInt(ACBrMail.Port);
   emSMTP.Username  := ACBrMail.Username;
   emSMTP.Password  := ACBrMail.Password;

   //emSMTP.UseTLS    := utUseImplicitTLS;

   emSMTP.Disconnect;
   emSMTP.Connect;

   if emSMTP.Connected then
   begin
       with emMessage do
       begin
         Clear;
         Body.Clear;
         Recipients.Clear;
         Subject                :='[Teste] - Envio de E-mail da Ferrament Previs�o de Faturamento';
         From.Address           := ACBrMail.Username;
         From.Name              := ACBrMail.FromName;
         Recipients.Add.Address := ACBrMail.Username;
         ContentType            := 'multipart/alternative';
         ContentDisposition     := 'inline';
         Encoding               := meMIME;
       end;

       with TIdText.Create(emMessage.MessageParts) do
       begin
          Body.Text       := 'This message contains HTML and images.';
          ContentTransfer := '7bit';
          ContentType     := 'text/plain';
       end;

       with TIdText.Create(emMessage.MessageParts) do
       begin
          ContentType     := 'multipart/related';
          Body.Clear;
       end;


       with TIdText.Create(emMessage.MessageParts) do
       begin
         Body.Clear;
         Body.Text       := 'Teste de envio de E-mail da Conta' + ACBrMail.Username;
         ContentTransfer := '7bit';
         ContentType     := 'text/html';
         ParentPart      := 1;
       end;

   end;

   try
       emSMTP.Send(emMessage);
       Application.MessageBox( PChar( 'Conta de E-mail ' + edtFrom.Text + ' Conectou com Sucesso.'), 'Configura��o', MB_ICONINFORMATION)
    except
       on e: exception do
         begin
           Application.MessageBox( Pchar( 'N�o foi poss�vel conectar na Conta de E-mail ' + edtFrom.Text + '.'), 'Configura��o', MB_ICONERROR);

         end;
    end;

   emSMTP.Disconnect;
  Finally
     FreeAndNil(emMessage);
     FreeAndNil(emSMTP);
     FreeAndNil(SSLHandler);
  End;
end;

function TFrm_Previsao.EnviarEmail(varEmail, varMensagem : String) : Boolean;
var
  SSLHandler   : TIdSSLIOHandlerSocketOpenSSL;
  emMessage    : TIdMessage;
  emSMTP       : TIdSMTP;
  bEnvio       : Boolean;
  Attachment   : TIdAttachment;
  I            : Integer;
begin
  emSMTP     := TIdSMTP.Create;
  emMessage := TIdMessage.Create;
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  Try

   SSLHandler.MaxLineAction          := maException;
   SSLHandler.SSLOptions.Method      := sslvTLSv1;
   SSLHandler.SSLOptions.Mode        := sslmUnassigned;
   SSLHandler.SSLOptions.VerifyMode  := [];
   SSLHandler.SSLOptions.VerifyDepth := 0;

   emSMTP.IOHandler := SSLHandler;
   emSMTP.Host      := ACBrMail.Host;
   emSMTP.Port      := StrToInt(ACBrMail.Port);
   emSMTP.Username  := ACBrMail.Username;
  // emSMTP.Password  := ACBrMail.Password;
 //  emSMTP.UseTLS    := utUseImplicitTLS;


   emSMTP.Connect;
   Try

      if emSMTP.Connected then
      begin
         with emMessage do
         begin
           Clear;
           Body.Clear;
           Recipients.Clear;
           Subject                := ACBrMail.Subject;
           From.Address           := ACBrMail.Username;
           From.Name              := ACBrMail.FromName;
           Recipients.Add.Address := varEmail;
           FDQueryEmail.Close;
           FDQueryEmail.Filtered := False;
           FDQueryEmail.Filter   := 'TSOP_ATIVO = ''S''';
           FDQueryEmail.Filtered := True;
           FDQueryEmail.Open;

           while not FDQueryEmail.Eof do
           begin
             BccList.Add.Address := FDQueryEmail.FieldByName('TSOP_EMAIL').AsString;
             FDQueryEmail.Next;
           end;

           ContentType            := 'multipart/alternative';
           ContentDisposition     := 'inline';
           Encoding               := meMIME;
         end;

         with TIdText.Create(emMessage.MessageParts) do
         begin
            Body.Text       := 'This message contains HTML and images.';
            ContentTransfer := '7bit';
            ContentType     := 'text/plain';
         end;

         with TIdText.Create(emMessage.MessageParts) do
         begin
            ContentType     := 'multipart/related';
            Body.Clear;
         end;

         with TIdText.Create(emMessage.MessageParts) do
         begin
           Body.Clear;
           Body.Text       := varMensagem;
           ContentTransfer := '7bit';
           ContentType     := 'text/html';
           ParentPart      := 1;
         end;

        for I := 0 to varAnexos.Count-1 do
        begin

           Attachment := TIdAttachmentFile.Create(emMessage.MessageParts, varAnexos[I]);

        end;


      end;

      bEnvio := False;
      try
         emSMTP.Send(emMessage);
         bEnvio := True;
      except
         on e: exception do
           begin
             showmessage( 'Erro ao Enviar: '  + e.Message );

           end;
      end;

    Finally
     emSMTP.Disconnect;

    End;
  Finally
     FreeAndNil(emMessage);
     FreeAndNil(emSMTP);
     FreeAndNil(SSLHandler);
  End;

end;

procedure TFrm_Previsao.BitBtn1Click(Sender: TObject);
var
  I, X, Y, varAno, varMes, varContador, varLinha : Integer;
  dxSpreadSheet: TdxSpreadSheet;
  varOrdemvendas, varCodigoCliente,	varNomeCliente, varCodigoComprador, varEmailComprador,
  varItemOV, varCodigoMaterial, varCodigoMaterialCatalogo, varDescricaoMaterial, varQtdSerEntregue, varUMSerEntregue,
  varQtdedaOrdem, varUMOrdem, varCanal, varCC  : String;

  varDataPrevistaEntrega : TDateTime;


begin
  if cxButtonEditPath.Text = EmptyStr then
    raise Exception.Create('Informe o arquivo primeiro.');

  varEmailInvalido := TStringList.Create;

  Mensagem( 'Iniciando processo de importa��o...' );
  try
    CarregaINI;

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
      varEmailInvalido.Clear;
      varEmailInvalido.Add('Ordem de Venda | E-mail do Comprador');

      for X := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
      begin

         try

          if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0]) then
            Exit;

          if dxSpreadSheet.ActiveSheetAsTable.Rows[X].CellCount < 14 then
            Continue;

          Mensagem( 'E-mail do Comprador (" ' + IntToStr(X) + '/' + IntToStr(dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex) + '") "' + Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[4].AsString) + '" ...' );

          if Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString) = EmptyStr then
            Continue;

        except

          Continue;

        end;
        varOrdemvendas            := '';
        varCodigoCliente          := '';
        varNomeCliente            := '';
        varCodigoComprador        := '';
        varEmailComprador         := '';
        varItemOV                 := '';
        varCodigoMaterial         := '';
        varCodigoMaterialCatalogo := '';
        varDescricaoMaterial      := '';
        varQtdSerEntregue         := '';
        varUMSerEntregue          := '';
        varQtdedaOrdem            := '';
        varUMOrdem                := '';
        varDataPrevistaEntrega    := 0;
        varCanal                  := '';
        varCC                     := '';

        varOrdemvendas            := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString;
        varCodigoCliente          := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[1].AsString;
        varNomeCliente            := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsString;
        varCodigoComprador        := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[3].AsString;
        varEmailComprador         := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[4].AsString;

        if not IsValidEmailRegEx(varEmailComprador) then
        begin
           varEmailInvalido.Add(varOrdemvendas + ' | ' + varEmailComprador);
           Continue;
        end;

        varItemOV                 := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[5].AsString;
        varCodigoMaterial         := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6].AsString;
        varCodigoMaterialCatalogo := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[7].AsString;
        varDescricaoMaterial      := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[8].AsString;

        varQtdSerEntregue         := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[9].AsString;
        varUMSerEntregue          := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[10].AsString;
        varQtdedaOrdem            := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[11].AsString;
        varUMOrdem                := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[12].AsString;
        varDataPrevistaEntrega    := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[13].AsDateTime;
        varCanal                  := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[14].AsString;

         if  Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[15]) then
          varCC                     := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[15].AsString;

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
        CDSSalvaPrevisao.FieldByName('TSOP_ORDBILCANNOM').AsString            :=  varCanal;
        CDSSalvaPrevisao.FieldByName('TSOP_ORDBILCUSTCLASS').AsString         :=  varCC;


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

    finally

      FreeAndNil(dxSpreadSheet);

    end;

    Mensagem( 'Enviando E-mail...' );

    EnviarMalaDireta;

    if varEmailInvalido.Count > 1 then
    begin
      memEmail.Lines.AddStrings(varEmailInvalido);
      pnlEmail.Visible := True;
    end;

  finally
       FreeAndNil(varEmailInvalido);
       Mensagem( EmptyStr );
       cxButtonEditPath.Clear;
  end;


end;

procedure TFrm_Previsao.btnFecharPnlClick(Sender: TObject);
begin
   memEmail.Clear;
   pnlEmail.Visible := False;
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
  Screen.Cursor := crHourGlass;
  Mensagem('Aguarde...');
  Try

    DeleteFile(ExtractFilePath(Application.ExeName) + '\SMTP_PREVFAT.ini');

  except
  on E: Exception do
      begin
        Screen.Cursor := crDefault;
        Application.MessageBox( PwideChar( E.Message ) , 'Configura��o', MB_ICONERROR);
      end;
  End;

  ArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\SMTP_PREVFAT.ini');


   try
    
    ArqIni.WriteString('EMAIL', 'HOST', edtHost.Text);
    ArqIni.WriteString('EMAIL', 'PORT', edtPort.Text);

    //Pedido
    if  rgSSL.ItemIndex = 0 then
     ArqIni.WriteString('PEDIDO', 'SSL', 'Sim')
    else    ArqIni.WriteString('PEDIDO', 'SSL', 'N�o');

    if  rgTLS.ItemIndex = 0 then
      ArqIni.WriteString('PEDIDO', 'TLS', 'Sim')
    else    ArqIni.WriteString('PEDIDO', 'TLS', 'N�o');

    ArqIni.WriteString('PEDIDO', 'USER', edtUserName.Text);
    ArqIni.WriteString('PEDIDO', 'PWD', edtPassword.Text);
    ArqIni.WriteString('PEDIDO', 'FROM', edtFrom.Text);

    // Distribuidor
    if  rgDistriSSL.ItemIndex = 0 then
     ArqIni.WriteString('DISTRIB', 'SSL', 'Sim')
    else    ArqIni.WriteString('DISTRIB', 'SSL', 'N�o');

    if  rgDistriTLS.ItemIndex = 0 then
      ArqIni.WriteString('DISTRIB', 'TLS', 'Sim')
    else    ArqIni.WriteString('DISTRIB', 'TLS', 'N�o');

    ArqIni.WriteString('DISTRIB', 'USER', edtDistriUserName.Text);
    ArqIni.WriteString('DISTRIB', 'PWD', edtDistriPassword.Text);
    ArqIni.WriteString('DISTRIB', 'FROM', edtDistriFrom.Text);

    //Informacoes
    if  rgInfoSSL.ItemIndex = 0 then
     ArqIni.WriteString('INFO', 'SSL', 'Sim')
    else    ArqIni.WriteString('INFO', 'SSL', 'N�o');

    if  rgInfoTLS.ItemIndex = 0 then
      ArqIni.WriteString('INFO', 'TLS', 'Sim')
    else    ArqIni.WriteString('INFO', 'TLS', 'N�o');

    ArqIni.WriteString('INFO', 'USER', edtInfoUserName.Text);
    ArqIni.WriteString('INFO', 'PWD', edtInfoPassword.Text);
    ArqIni.WriteString('INFO', 'FROM', edtInfoFrom.Text);

    //Manaus

    if  rgManausSSL.ItemIndex = 0 then
     ArqIni.WriteString('MANAUS', 'SSL', 'Sim')
    else    ArqIni.WriteString('MANAUS', 'SSL', 'N�o');

    if  rgManausTLS.ItemIndex = 0 then
      ArqIni.WriteString('MANAUS', 'TLS', 'Sim')
    else    ArqIni.WriteString('MANAUS', 'TLS', 'N�o');

    ArqIni.WriteString('MANAUS', 'USER', EdiManausUserName.Text);
    ArqIni.WriteString('MANAUS', 'PWD', EditManausPassword.Text);
    ArqIni.WriteString('MANAUS', 'FROM', EdiManausFrom.Text);




    ArqIni.WriteString('EMAIL', 'ASSUNTO', edtAssunto.Text);

    ArqIni.WriteString('PASTA', 'SALVAR_EXCEL', edtPathSalvaExcel.Text);
    if chkCopia.Checked  then
        ArqIni.WriteString('PASTA', 'SALVAR_COPIA', 'Sim')
    else    ArqIni.WriteString('PASTA', 'SALVAR_COPIA', 'N�o');

    if System.IOUtils.TFile.Exists( MyDocumentsPath + '\SMTP_PREVFAT.ini' ) then
      DeleteFile(MyDocumentsPath + '\SMTP_PREVFAT.ini');

    System.IOUtils.TFile.Copy( ExtractFilePath(Application.ExeName) + '\SMTP_PREVFAT.ini' , MyDocumentsPath + '\SMTP_PREVFAT.ini', True );

    Mensagem(EmptyStr);

    Application.MessageBox( 'Altera��o do E-mail Padr�o Salvas com Sucesso.', 'Configura��o', MB_ICONINFORMATION);

  finally
     Screen.Cursor := crDefault;
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

procedure TFrm_Previsao.EnviarMalaDireta;
var
  I, X, J, ContaCliente : Integer;
  varCor1,varCor2: TColor;
  varMsg: TStringList;
  varEmailPara: String;
  varXML: TStringList;

  varCC: TStringList;

  Data : TDateTime;
  varPastaDoDia : String;
  varEmpresa : String;

begin
  if not System.IOUtils.TDirectory.Exists( edtPathSalvaExcel.Text ) then
  begin
    Application.MessageBox( PWideChar( 'Pasta ' + edtPathSalvaExcel.Text + 'N�o esta criada. Criar Pasta e Corrigir arquivo .INI'),  'Enviando E-mail', MB_ICONERROR);;

    exit;
  end;


  Screen.Cursor := crHourGlass;
  Data := Date;
  varPastaDoDia :=  FormatDateTime('yyyymmdd', Data);


  if not System.IOUtils.TDirectory.Exists( edtPathSalvaExcel.Text + '\' + varPastaDoDia + '\'  ) then
    System.IOUtils.TDirectory.CreateDirectory( edtPathSalvaExcel.Text + '\' + varPastaDoDia + '\' );

  varPastaDoDia := edtPathSalvaExcel.Text + '\' + varPastaDoDia;

  FDComprador.Close;
  FDComprador.SQL.Clear;
  FDComprador.SQL.Add('SELECT DISTINCT TSOP_ORDBILREPNOM, TSOP_ORDBILEMAILCOMPRADOR FROM TSOP_PREVISAOFAT ORDER BY TSOP_ORDBILEMAILCOMPRADOR ');
  FDComprador.Open;

  varMsg    := TStringList.Create;
  varAnexos := TStringList.Create;
  varCC     := TStringList.Create;


  try
      if not FDComprador.IsEmpty then
      begin
         while not FDComprador.Eof do
         begin

            FDOrdem.Close;
            FDOrdem.SQL.Clear;
            FDOrdem.SQL.Add(' Select TSOP_ORDBILNRODOCREF, TSOP_ORDBILCLICOD, TSOP_ORDBILCLINOM, TSOP_ORDBILREPNOM, TSOP_ORDBILEMAILCOMPRADOR, ');
            FDOrdem.SQL.Add(' TSOP_ORDBILCANNOM, TSOP_ORDBILCUSTCLASS From TSOP_PREVISAOFAT ');
            FDOrdem.SQL.Add(' Where TSOP_ORDBILEMAILCOMPRADOR = :TSOP_ORDBILEMAILCOMPRADOR ');
            FDOrdem.Params.ParamByName('TSOP_ORDBILEMAILCOMPRADOR').AsString := FDComprador.FieldByName('TSOP_ORDBILEMAILCOMPRADOR').AsString;
            FDOrdem.Open;
            if not FDOrdem.IsEmpty then
            begin
               while not FDOrdem.Eof do
               begin
                    varEmpresa := '';

                    if FDOrdem.FieldByName('TSOP_ORDBILCANNOM').AsString = '4110' then
                      varEmpresa := 'Seton'
                    else varEmpresa := 'Brady';

                    varMsg.Add('<HTML>');

                    varMsg.Add('<HEAD>');
                    varMsg.Add('<meta http-equiv="content-type" content="text/html"; charset=ISO-8859-1">');

                    //varMsg.Add('<script src="https://kit.fontawesome.com/976b91e952.js" crossorigin="anonymous"></script> ');

                    varMsg.Add('<style>');
                    varMsg.Add('.p_link{font-family:Verdana}');
                    varMsg.Add('</style>');

                    varMsg.Add('</HEAD>');

                    varMsg.Add('<BODY style="font-family:Arial;font-size:11px;">');
                    varMsg.Add('<p><i>Ol�, tudo bem com voc�?</i></p>');
                    varMsg.Add('<BR>');
                    varMsg.Add('<p><i>Eu sou o Assistente Virtual, aqui da ' + varEmpresa + '. Estou enviando esse e-mail para informar a');
                    varMsg.Add('previs�o de faturamento dos seus pedidos em aberto</i></p>');
                    varMsg.Add('<BR>');
                    varMsg.Add('<BR>');
                    varMsg.Add('<BR>');
                    varMsg.Add('<BR>');
                    varMsg.Add('<p><i>Nosso sistema envia automaticamente o PDF da Nota Fiscal, caso n�o receba, nos contate.</i></p>');
                    varMsg.Add('<BR>');
                    varMsg.Add('<p><i>Se houver altera��es no prazo de entrega retornaremos o contato.</i></p>');
                    varMsg.Add('<BR> ');
                    varMsg.Add('<p><i>Agrade�o o seu tempo e, em caso de d�vidas, por favor entre em contato atrav�s do');
                    varMsg.Add('n�mero de telefone da minha assinatura.</i></p>');
                    varMsg.Add('<BR> ');
                    varMsg.Add('<p><i>Poderia avaliar nosso atendimento? Estamos melhorando a cada dia para melhor atend�-lo');
                    varMsg.Add('e para isso precisamos da sua opini�o.</i></p>');
                    varMsg.Add('<BR>');
                    varMsg.Add('<p class="p_link"><i>Basta clicar aqui >>> <a href="https://docs.google.com/forms/d/e/1FAIpQLSd7py85-JZvgwIBiJq3ekNLJQfZZV91e5o_eIFTt6q2ZpL9cw/viewform">Pesquisa de Satisfa��o</a></i></p> ');
                    varMsg.Add('<BR>');
                    varMsg.Add('<p>Obrigado</p>');
                    varMsg.Add('<BR>');
                    varMsg.Add('<p>Assistente Virtual</p>');
                    varMsg.Add('<p>Customer Service Time</p>');
                    varMsg.Add('<p>(11) 4166-1500</p>');

                    varMsg.Add('</BODY>');
                    varMsg.Add('</HTML>');


                    FDItem.Close;
                    FDItem.SQL.Clear;
                    FDItem.SQL.Add( ' SELECT TSOP_ORDBILITECOD, TSOP_CODIGOMATERIAL, TSOP_YNUMBER, TSOP_ORDBILITENOM, TSOP_ORDBILITEUNIENTREGUE, ' );
                    FDItem.SQL.Add( ' TSOP_ORDBILQTDENTREGUE, TSOP_ORDBILITEUNIQTD, TSOP_ORDBILQTD, TSOP_ORDBILDATPREVENT ');
                    FDItem.SQL.Add( ' FROM TSOP_PREVISAOFAT ');
                    FDItem.SQL.Add( ' WHERE  TSOP_ORDBILDATALT IS NULL AND TSOP_ORDBILEMAILCOMPRADOR = :TSOP_ORDBILEMAILCOMPRADOR  AND TSOP_ORDBILNRODOCREF = :TSOP_ORDBILNRODOCREF ');

                    FDItem.Params.ParamByName('TSOP_ORDBILEMAILCOMPRADOR').AsString := FDOrdem.FieldByName('TSOP_ORDBILEMAILCOMPRADOR').AsString;
                    FDItem.Params.ParamByName('TSOP_ORDBILNRODOCREF').AsString      := FDOrdem.FieldByName('TSOP_ORDBILNRODOCREF').AsString;

                    FDItem.Open;

                    FDItem.First;

                    if not FDItem.Eof then
                    begin

                       dxSpreadSheet := TdxSpreadSheet.Create(nil);
                       try

                         dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\MalaDireta.xlsx' );
                         dxSpreadSheet.BeginUpdate;

                         dxSpreadSheet.Sheets[0].Active := True;

                         varCor1 := RGB( 255, 255, 204 );
                         varCor2 := RGB(255,255,225);

                         X := 1;

                         while not FDItem.eof do
                         begin

                               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,0) do
                               begin
                                   Style.Brush.BackgroundColor := varCor1;
                                   AsVariant := FDItem.FieldByName('TSOP_ORDBILITECOD').AsString; // Codigo do Item
                               end;

                               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,1) do
                               begin
                                   Style.Brush.BackgroundColor := varCor1;
                                   AsVariant := FDItem.FieldByName('TSOP_CODIGOMATERIAL').AsString;   // Codigo do Material
                               end;

                               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,2) do
                               begin
                                   Style.Brush.BackgroundColor := varCor1;
                                   AsVariant := FDItem.FieldByName('TSOP_YNUMBER').AsString;  // Codigo do Catalago
                               end;

                               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,3) do
                               begin
                                   Style.Brush.BackgroundColor := varCor1;
                                   AsVariant := FDItem.FieldByName('TSOP_ORDBILITENOM').AsString;  // Nome do Material

                               end;


                               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,4) do
                               begin
                                   Style.Brush.BackgroundColor := varCor1;
                                   AsVariant := FDItem.FieldByName('TSOP_ORDBILITEUNIENTREGUE').AsString; // Unidade de Medida Prometida

                               end;


                               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,5) do
                               begin
                                   Style.Brush.BackgroundColor := varCor1;
                                   AsVariant :=  FDItem.FieldByName('TSOP_ORDBILQTDENTREGUE').AsString;  // Qtde Prometida
                                   Style.DataFormat.FormatCode := '0.00';
                               end;

                               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,6) do
                               begin
                                   Style.Brush.BackgroundColor := varCor1;
                                   AsVariant := FDItem.FieldByName('TSOP_ORDBILITEUNIQTD').AsString; // Unidade de Medida A entregar

                               end;

                               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,7) do
                               begin
                                   Style.Brush.BackgroundColor := varCor1;
                                   AsVariant := FDItem.FieldByName('TSOP_ORDBILQTD').AsString;  // Qtde a Entregar
                                   Style.DataFormat.FormatCode := '0.00';
                               end;

                               with dxSpreadSheet.ActiveSheetAsTable.CreateCell(X,8) do
                               begin
                                   Style.Brush.BackgroundColor := varCor1;
                                   AsDateTime := FDItem.FieldByName('TSOP_ORDBILDATPREVENT').AsDateTime; // Data de Previs�o da Entrega
                                   Style.DataFormat.FormatCode := 'dd/mm/yyyy';

                               end;

                               if Odd(X) then
                                varCor1 := RGB(255,255,225)
                               else
                                varCor1 := RGB(216,234,204);

                               Inc(X);

                               FDItem.Next;
                         end;

                         if not System.IOUtils.TDirectory.Exists( varPastaDoDia + '\' + FDComprador.FieldByName('TSOP_ORDBILREPNOM').AsString + '\'  ) then
                            System.IOUtils.TDirectory.CreateDirectory( varPastaDoDia + '\' + FDComprador.FieldByName('TSOP_ORDBILREPNOM').AsString + '\' );

                         if FileExists(varPastaDoDia+ '\' + FDComprador.FieldByName('TSOP_ORDBILREPNOM').AsString + '\' + 'MalaDireta_' + FDOrdem.FieldByName('TSOP_ORDBILCLICOD').AsString + '.xlsx') then
                            DeleteFile( varPastaDoDia + '\' + FDComprador.FieldByName('TSOP_ORDBILREPNOM').AsString + '\' + 'MalaDireta_' + FDOrdem.FieldByName('TSOP_ORDBILCLICOD').AsString + '.xlsx');

                         dxSpreadSheet.BeginUpdate;
                         dxSpreadSheet.SaveToFile( varPastaDoDia + '\' + FDComprador.FieldByName('TSOP_ORDBILREPNOM').AsString + '\' + 'MalaDireta_' + FDOrdem.FieldByName('TSOP_ORDBILCLICOD').AsString + '.xlsx' );

                         if System.IOUtils.TFile.Exists( varPastaDoDia + '\' + FDComprador.FieldByName('TSOP_ORDBILREPNOM').AsString + '\' + 'MalaDireta_' + FDOrdem.FieldByName('TSOP_ORDBILCLICOD').AsString + '.xlsx'  ) then
                            varAnexos.Add( varPastaDoDia + '\' + FDComprador.FieldByName('TSOP_ORDBILREPNOM').AsString + '\' + 'MalaDireta_' + FDOrdem.FieldByName('TSOP_ORDBILCLICOD').AsString + '.xlsx' );

                         if varAnexos.Count > 0 then
                         begin


                            ACBrMail := TACBrMail.Create(Nil);
                            Try
                                ACBrMail.Clear;

                                ACBrMail.Host     := edtHost.Text;
                                ACBrMail.Port     := edtPort.Text;

                                if FDOrdem.FieldByName('TSOP_ORDBILCANNOM').AsString = '4160' then   //Manaus
                                begin
                                  ACBrMail.SetSSL   := rgManausSSL.ItemIndex = 0;
                                  ACBrMail.SetTLS   := rgManausTLS.ItemIndex = 0;

                                  ACBrMail.Username := EdiManausUserName.Text;
                                  ACBrMail.Password := EditManausPassword.Text;

                                  ACBrMail.From     := EdiManausUserName.Text;
                                  ACBrMail.FromName := EdiManausFrom.Text;


                                end
                                else  if FDOrdem.FieldByName('TSOP_ORDBILCANNOM').AsString = '4110' then  // Informacoes Seton
                                begin
                                  ACBrMail.SetSSL   := rgInfoSSL.ItemIndex = 0;
                                  ACBrMail.SetTLS   := rgInfoTLS.ItemIndex = 0;

                                  ACBrMail.Username := edtInfoUserName.Text;
                                  ACBrMail.Password := edtInfoPassword.Text;

                                  ACBrMail.From     := edtInfoUserName.Text;
                                  ACBrMail.FromName := edtInfoFrom.Text;


                                end
                                else if ((FDOrdem.FieldByName('TSOP_ORDBILCANNOM').AsString = '4150') and  (FDOrdem.FieldByName('TSOP_ORDBILCUSTCLASS').AsString = 'DV')) then  // Distribuidor
                                begin
                                  ACBrMail.SetSSL   := rgDistriSSL.ItemIndex = 0;
                                  ACBrMail.SetTLS   := rgDistriTLS.ItemIndex = 0;

                                  ACBrMail.Username := edtDistriUserName.Text;
                                  ACBrMail.Password := edtDistriPassword.Text;

                                  ACBrMail.From     := edtDistriUserName.Text;
                                  ACBrMail.FromName := edtDistriFrom.Text;

                                end
                                else if ((FDOrdem.FieldByName('TSOP_ORDBILCANNOM').AsString = '4150') and  (FDOrdem.FieldByName('TSOP_ORDBILCUSTCLASS').AsString = 'C1')) then  // Pedidos
                                begin
                                  ACBrMail.SetSSL   := rgSSL.ItemIndex = 0;
                                  ACBrMail.SetTLS   := rgTLS.ItemIndex = 0;

                                  ACBrMail.Username := edtUserName.Text;
                                  ACBrMail.Password := edtPassword.Text;

                                  ACBrMail.From     := edtUserName.Text;
                                  ACBrMail.FromName := edtFrom.Text;

                                end;



                                ACBrMail.AddAddress(FDOrdem.FieldByName('TSOP_ORDBILEMAILCOMPRADOR').AsString);


                                ACBrMail.Subject := edtAssunto.Text;
                                ACBrMail.IsHTML := True;
                               // ACBrMail.Body.Assign(varMsg);

                                for X := 0 to varAnexos.Count-1 do
                                begin

                                  ACBrMail.AddAttachment( varAnexos[X] );

                                end;

                                try

                                  EnviarEmail(FDComprador.FieldByName('TSOP_ORDBILEMAILCOMPRADOR').AsString, varMsg.Text);

                                  FDQueryTmp.Close;
                                  FDQueryTmp.SQL.Clear;
                                  FDQueryTmp.SQL.Add(' Update TSOP_PREVISAOFAT ');
                                  FDQueryTmp.SQL.Add(' SET TSOP_ORDBILDATALT = GETDATE() ');
                                  FDQueryTmp.SQL.Add(' WHERE TSOP_ORDBILEMAILCOMPRADOR = :TSOP_ORDBILEMAILCOMPRADOR  AND TSOP_ORDBILNRODOCREF = :TSOP_ORDBILNRODOCREF ');

                                  FDQueryTmp.Params.ParamByName('TSOP_ORDBILEMAILCOMPRADOR').AsString := FDOrdem.FieldByName('TSOP_ORDBILEMAILCOMPRADOR').AsString;
                                  FDQueryTmp.Params.ParamByName('TSOP_ORDBILNRODOCREF').AsString      := FDOrdem.FieldByName('TSOP_ORDBILNRODOCREF').AsString;
                                  Try
                                      FDQueryTmp.ExecSQL;
                                  except

                                      on E: Exception do
                                      begin

                                        Application.MessageBox( PWideChar( 'Problema ao atualizar Tabela de E-mail: ' + E.Message),  'Enviando E-mail', MB_ICONERROR);

                                      end;

                                  end;

                                except

                                  on E: Exception do
                                  begin

                                    Application.MessageBox( PWideChar( 'Problema ao enviar email: ' + E.Message),  'Enviando E-mail', MB_ICONERROR);
                                    varEmailInvalido.Add( ACBrMail.Username  + ' | ' + E.Message );
                                  end;

                                end;

                            Finally
                               FreeAndNil(ACBrMail);
                            End;

                         end;

                       finally
                          FreeAndNil(dxSpreadSheet);
                       end;

                     end;

                     if not chkCopia.Checked  then
                        DeleteFile (varPastaDoDia + '\' + FDComprador.FieldByName('TSOP_ORDBILREPNOM').AsString + '\' + 'MalaDireta_' + FDOrdem.FieldByName('TSOP_ORDBILCLICOD').AsString + '.xlsx' );

                     varMsg.Clear;
                     varAnexos.Clear;
                     Application.ProcessMessages;
                     FDOrdem.Next;

               end;

            end;

            FDComprador.Next;
         end;

      end;

  Finally

    CopyFile( PWideChar(cxButtonEditPath.Text), PWideChar(varPastaDoDia+ '\' + ExtractFileName(cxButtonEditPath.Text)), True );

    FDQueryEmail.Close;
    FDQueryEmail.Filtered := False;
    FDQueryEmail.Filter := '';
    FDQueryEmail.Filtered := True;
    FDQueryEmail.Open;
    FDComprador.Close;
    FDOrdem.Close;
    FDItem.Close;
    FDQueryEmail.Close;


    FreeAndNil(varMsg);
    FreeAndNil(varAnexos);
    FreeAndNil(varCC);
    Screen.Cursor := crDefault;
  end;

end;

procedure TFrm_Previsao.edtHostKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    Mudou := True;
end;

procedure TFrm_Previsao.edtPasswordExit(Sender: TObject);
begin

  if edtHost.Text = '' then
     raise Exception.Create('Campo Host deve estar preenchido.');

  if edtPort.Text = '' then
     raise Exception.Create('Campo Port deve estar preenchido.');

  if edtFrom.Text = '' then
     raise Exception.Create('Campo From (Pedidos) deve estar preenchido.');


  if edtUserName.Text = '' then
     raise Exception.Create('Campo UserName deve estar preenchido.');

 // if edtPassword.Text = '' then
 //    raise Exception.Create('Campo Password deve estar preenchido.');

  ACBrMail := TACBrMail.Create(Nil);
  Try
    ACBrMail.Clear;

    ACBrMail.Host     := edtHost.Text;
    ACBrMail.Port     := edtPort.Text;
    ACBrMail.From     := edtFrom.Text;
    ACBrMail.Username := edtUserName.Text;
    //ACBrMail.Password := edtPassword.Text;
    ConectarEmailPadrao;

  Finally
    FreeAndNil(ACBrMail);

  End;


end;

procedure TFrm_Previsao.edtPathSalvaExcelClick(Sender: TObject);

var
  FDir : String;
begin
  inherited;
  if Win32MajorVersion >= 6 then
    with TFileOpenDialog.Create(nil) do
    try
      Title := 'Selecionar Diret�rio';
      Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem]; // YMMV
      OkButtonLabel := 'Selecionar';
      DefaultFolder := FDir;
      FileName := FDir;
      if Execute then
      begin
        edtPathSalvaExcel.Text := FileName;

      end;
    finally
      Free;
    end
  else
    if SelectDirectory('Selecionar Diret�rio', ExtractFileDrive(FDir), FDir,
             [sdNewUI, sdNewFolder]) then
      edtPathSalvaExcel.Text := FDir;

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

procedure TFrm_Previsao.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  buttonSelected: integer;
begin
  if Mudou then
  begin
    buttonSelected := MessageDlg('Altera��es na aba Configura��o n�o foram Salvas. ' + #13#10 + 'Deseja realmente fechar o programa?' , mtCustom, [mbYes, mbNo], 0);
    if buttonSelected = mrYES then
    begin
      CanClose:=true;
    end
    else
    begin
      CanClose:=false;
    end;
  end;

end;

procedure TFrm_Previsao.FormShow(Sender: TObject);
begin
 Page.ActivePage := TabEmail;

 if not System.IOUtils.TFile.Exists(  ExtractFilePath(Application.ExeName)  + '\SMTP_PREVFAT.ini' ) then
 begin
    Application.MessageBox( pWideChar( 'Arquivo SMTP_PREVFAT.ini n�o encontrado na pasta ' + ExtractFilePath(Application.ExeName) +  #13#10 + 'Abortar Programa. ' ) , 'BradyEtiqueta', MB_ICONINFORMATION);
    Close;
 end;


 if not System.IOUtils.TFile.Exists(  ExtractFilePath(Application.ExeName)  + '\MalaDireta.xlsx' ) then
 begin
    Application.MessageBox( pWideChar( 'Arquivo MalaDireta.xlsx n�o encontrado na pasta ' + ExtractFilePath(Application.ExeName) +  #13#10 + 'Abortar Programa. ' ) , 'BradyEtiqueta', MB_ICONINFORMATION);
    Close;
 end;

 if not System.IOUtils.TFile.Exists( MyDocumentsPath + '\SMTP_PREVFAT.ini' ) then
    System.IOUtils.TFile.Copy( ExtractFilePath(Application.ExeName) + '\SMTP_PREVFAT.ini' , MyDocumentsPath + '\SMTP_PREVFAT.ini', True );

 if not System.IOUtils.TFile.Exists( MyDocumentsPath + '\MalaDireta.xlsx' ) then
    System.IOUtils.TFile.Copy( ExtractFilePath(Application.ExeName) + '\MalaDireta.xlsx' , MyDocumentsPath + '\MalaDireta.xlsx', True );

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
  varSSLP, varTLSP, varSSLD, varTLSD, varSSLI, varTLSI, varCopiaArq : String;
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

      StatusBar.Panels[0].Text := ExtractFilePath(ArqIni.FileName) + ExtractFileName(ArqIni.FileName);

      StatusBar.Panels[1].Text := uUtils.FileVersion;

      edtHost.Text := ArqIni.ReadString('EMAIL', 'HOST', edtHost.Text);
      edtPort.Text := ArqIni.ReadString('EMAIL', 'PORT', edtPort.Text);

      //Pedido
      varSSLP := ArqIni.ReadString('PEDIDO', 'SSL', varSSLP);
      varTLSP := ArqIni.ReadString('PEDIDO', 'TLS', varTLSP);


      if varSSLP = 'Sim' Then
         rgSSL.ItemIndex := 0
      else rgSSL.ItemIndex := 1;


      if varTLSP = 'Sim' Then
         rgTLS.ItemIndex := 0
      else rgTLS.ItemIndex := 1;

      edtUsername.Text := ArqIni.ReadString('PEDIDO', 'USER', edtUsername.Text);
      edtPassword.Text := ArqIni.ReadString('PEDIDO', 'PWD', edtPassword.Text);
      edtFrom.Text     := ArqIni.ReadString('PEDIDO', 'FROM', edtFrom.Text);

      //Distribuidor
      varSSLD := ArqIni.ReadString('DISTRIB', 'SSL', varSSLD);
      varTLSD := ArqIni.ReadString('DISTRIB', 'TLS', varTLSD);


      if varSSLD = 'Sim' Then
         rgDistriSSL.ItemIndex := 0
      else rgDistriSSL.ItemIndex := 1;


      if varTLSD = 'Sim' Then
         rgDistriTLS.ItemIndex := 0
      else rgDistriTLS.ItemIndex := 1;

      edtDistriUserName.Text := ArqIni.ReadString('DISTRIB', 'USER', edtDistriUserName.Text);
      edtDistriPassword.Text := ArqIni.ReadString('DISTRIB', 'PWD', edtDistriPassword.Text);
      edtDistriFrom.Text     := ArqIni.ReadString('DISTRIB', 'FROM', edtDistriFrom.Text);


          //Informacoes
      varSSLI := ArqIni.ReadString('INFO', 'SSL', varSSLI);
      varTLSI := ArqIni.ReadString('INFO', 'TLS', varTLSI);

      if varSSLI = 'Sim' Then
         rgInfoSSL.ItemIndex := 0
      else rgInfoSSL.ItemIndex := 1;


      if varTLSI = 'Sim' Then
         rgInfoTLS.ItemIndex := 0
      else rgInfoTLS.ItemIndex := 1;

      edtInfoUserName.Text := ArqIni.ReadString('INFO', 'USER', edtInfoUserName.Text);
      edtInfoPassword.Text := ArqIni.ReadString('INFO', 'PWD', edtInfoPassword.Text);
      edtInfoFrom.Text     := ArqIni.ReadString('INFO', 'FROM', edtInfoFrom.Text);

      //Manaus

      varSSLI := ArqIni.ReadString('MANAUS', 'SSL', varSSLI);
      varTLSI := ArqIni.ReadString('MANAUS', 'TLS', varTLSI);

      if varSSLI = 'Sim' Then
         rgManausSSL.ItemIndex := 0
      else rgManausSSL.ItemIndex := 1;


      if varTLSI = 'Sim' Then
         rgManausTLS.ItemIndex := 0
      else rgManausTLS.ItemIndex := 1;

      EdiManausUserName.Text  := ArqIni.ReadString('MANAUS', 'USER', EdiManausUserName.Text);
      EditManausPassword.Text := ArqIni.ReadString('MANAUS', 'PWD', EditManausPassword.Text);
      EdiManausFrom.Text      := ArqIni.ReadString('MANAUS', 'FROM', EdiManausFrom.Text);


      edtAssunto.Text  := ArqIni.ReadString('EMAIL', 'ASSUNTO', edtAssunto.Text);

      edtPathSalvaExcel.Text :=  ArqIni.ReadString('PASTA', 'SALVAR_EXCEL', edtPathSalvaExcel.Text);
      varCopiaArq            := ArqIni.ReadString('PASTA', 'SALVAR_COPIA', varCopiaArq);

      chkCopia.Checked := varCopiaArq = 'Sim';

      Mudou := False;


    finally
      ArqIni.Free;
    end;
end;

procedure TFrm_Previsao.chkCopiaClick(Sender: TObject);
begin
  Mudou := True;
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
