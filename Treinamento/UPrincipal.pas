unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ActnList, ImgList, ToolWin, ExtCtrls, StdCtrls, Variants,
  ActnMan, ActnCtrls, ActnMenus, UrlMon, jpeg, Registry, Shellapi,
  DB, DBTables, dxSkinsCore,   cxClasses,
  cxLookAndFeels, dxSkinsForm, cxControls,
  IdBaseComponent, U_Cipher, IniFiles,
  IdComponent, IdTCPConnection, IdTCPClient, IdFTP, cxGraphics,
  IdExplicitTLSClientServerBase,
  System.Actions, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Buttons, cxLookAndFeelPainters, dxNavBarCollns, dxNavBarBase, dxNavBar,
  dxStatusBar, dxRibbonStatusBar, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
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
  dxSkinsdxNavBarPainter;

type
  TfrmPrincipal = class(TForm)
    dlpImprime: TPrintDialog;
    Timer: TTimer;
    ImageList1: TImageList;
    popJanela: TPopupMenu;
    OrganizarJanelasemCascata1: TMenuItem;
    JanelasLadoaLado1: TMenuItem;
    Horizontal1: TMenuItem;
    Vertical1: TMenuItem;
    stb: TdxRibbonStatusBar;
    ActionList: TActionList;
    actOperacao: TAction;
    actPerfilOper: TAction;
    actSair: TAction;
    actUsuario: TAction;
    actParametros: TAction;
    actPerfil: TAction;
    IdFTP: TIdFTP;
    MainImage: TImage;
    cxImageList1: TcxImageList;
    dxn: TdxNavBar;
    dxnImportar: TdxNavBarGroup;
    dxnRelatorio: TdxNavBarGroup;
    dxnSair: TdxNavBarGroup;
    dxnUtilitarios: TdxNavBarGroup;
    dxnUsuarios: TdxNavBarItem;
    dxnPerfilOper: TdxNavBarItem;
    dxnOperacao: TdxNavBarItem;
    dxnManutencao: TdxNavBarItem;
    MainMenu1: TMainMenu;
    dxnCadastros: TdxNavBarGroup;
    dxnPerfil: TdxNavBarItem;
    dxnImpFuncionario: TdxNavBarItem;
    dxnCurso: TdxNavBarItem;
    dxnTreinamento: TdxNavBarItem;
    actCurso: TAction;
    actFuncionario: TAction;
    actTreinamento: TAction;
    dxnFornecedor: TdxNavBarItem;
    dxnInstrutor: TdxNavBarItem;
    actFornecedor: TAction;
    actInstrutor: TAction;
    dxnEmpresa: TdxNavBarItem;
    actEmpresa: TAction;
    dxnTipoTreinamento: TdxNavBarItem;
    actTipoTreinamento: TAction;
    dxnPeriodicidade: TdxNavBarItem;
    actPeriodicidade: TAction;
    dxnPorParticipante: TdxNavBarItem;
    dxnPorTreinamento: TdxNavBarItem;
    actPorParticipante: TAction;
    actPorTreinamento: TAction;
    qryAux: TFDQuery;
    actCadParticipante: TAction;
    dxnParticipante: TdxNavBarItem;
    dxncargo: TdxNavBarItem;
    dxnCentroCusto: TdxNavBarItem;
    actCargo: TAction;
    actCentroCusto: TAction;
    dxnParametros: TdxNavBarItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actFecharExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure stbResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure OrganizarJanelasemCascata1Click(Sender: TObject);
    procedure JanelasLadoaLado1Click(Sender: TObject);
    procedure Horizontal1Click(Sender: TObject);
    procedure Vertical1Click(Sender: TObject);
    procedure actPerfilOperExecute(Sender: TObject);
    procedure actParametrosExecute(Sender: TObject);
    procedure actUsuarioExecute(Sender: TObject);
    procedure actPerfilExecute(Sender: TObject);
    procedure actConsultaNFExecute(Sender: TObject);
    procedure dxnSairClick(Sender: TObject);
    procedure stbPanels1Click(Sender: TObject);
    procedure actManutNFeExecute(Sender: TObject);
    procedure actOperacaoExecute(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actImpXLExecute(Sender: TObject);
    procedure actConsultaCTEExecute(Sender: TObject);
    procedure actGeradorGIAExecute(Sender: TObject);
    procedure actRelNFeExecute(Sender: TObject);
    procedure actContaEmailExecute(Sender: TObject);
    procedure actConsultaItensExecute(Sender: TObject);
    procedure actNaturezaExecute(Sender: TObject);
    procedure actImportarFilialExecute(Sender: TObject);
    procedure actCursoExecute(Sender: TObject);
    procedure actFuncionarioExecute(Sender: TObject);
    procedure actTreinamentoExecute(Sender: TObject);
    procedure actFornecedorExecute(Sender: TObject);
    procedure actInstrutorExecute(Sender: TObject);
    procedure actEmpresaExecute(Sender: TObject);
    procedure actTipoTreinamentoExecute(Sender: TObject);
    procedure actPeriodicidadeExecute(Sender: TObject);
    procedure actPorParticipanteExecute(Sender: TObject);
    procedure actPorTreinamentoExecute(Sender: TObject);
    procedure actCadParticipanteExecute(Sender: TObject);
    procedure actCargoExecute(Sender: TObject);
    procedure actCentroCustoExecute(Sender: TObject);
  private
    { Private declarations }
    pHost : string;
    Function VerODBC : String;
    procedure DownLoad(NomeArquivo : String);
    Function Limite( Tabela:String; Condicao:String; Maximo:Integer ): boolean;
    procedure LerIni(Ambiente : Integer ; Var Banco : String; var Host: String; Var Usuario: String; Var Senha : String);
  public
    { Public declarations }
    aux,  CodCli, CodCompra, FilialMatriz : String;
    DataServer : TDateTime;
    AcessoBtn, cVez: Integer;
    ProgAnt : Integer ;
    NatAjuste, UsuResp : String ;
    FFormatoBR: TFormatSettings;
  end;

var
  frmPrincipal: TfrmPrincipal;

  UsuFil   : String ;
  Master   : Boolean;
  aux, Tela : string;

implementation

uses  Global, SqlTableFun, MensFun , Login, DBConect, DateFun, Usuario, Parametros,
      PerfilOpe, Perfil, Operacao, CadCurso,uImpFuncionario,uCadTreinamento, uEntidade,
      uInstrutor,CadFilial, uTipoTreinamento, uCadPeriodicidade, uRelParticipante, uRelTreinamento,
      uParticipante, uCargos, uCentroCusto;

{$R *.DFM}

procedure CreateODBCDriver(Const
cDSNName,cExclusive,cDescription,cDataBase,cDefaultPath,cConfigSql,cDriver: string);
type
  TSQLConfigDataSource = function( hwndParent: HWND; fRequest: WORD; lpszDriver: LPCSTR;
lpszAttributes: LPCSTR ): BOOL; stdcall;
const
  ODBC_ADD_DSN = 1; // Adiciona uma fonte de dados (data source)
  ODBC_CONFIG_DSN = 2; // Configura a fonte de dados (data source)
  ODBC_REMOVE_DSN = 3; // Remove a fonte de dados (data source)
  ODBC_ADD_SYS_DSN = 4; // Adiciona um DSN no sistema
  ODBC_CONFIG_SYS_DSN = 5; // Configura o DSN do sistema
  ODBC_REMOVE_SYS_DSN = 6; // Remove o DSN do sistema
var
  pFn: TSQLConfigDataSource;
  hLib: LongWord;
  strDriver: string;
  strHome: string;
  strAttr: string;
  strFile: string;
  fResult: BOOL;
  ModName: array[0..MAX_PATH] of Char;
  srInfo : TSearchRec;
begin
  Windows.GetModuleFileName( HInstance, ModName, SizeOf(ModName) );
  strHome := ModName;
  while ( strHome[length(strHome)] <> '\' ) do
  Delete( strHome, length(strHome), 1 );
  strFile := strHome + cDatabase; // Teste com access (Axes = Access)
  hLib := LoadLibrary( pChar(cDefaultPath) ); // carregando para o diret�rio padr�o
  if( hLib <> NULL ) then
  begin
    @pFn := GetProcAddress( hLib, pChar(cConfigSql) );
    if( @pFn <> nil ) then
    begin
      strDriver := cDriver;
      strAttr := Format( 'DSN=%s'+#0+
        'DBQ=%s'+#0+
        'Exclusive=%s'+#0+
        'Description=%s'+#0+#0,
        [cDSNName,strFile,cExclusive,cDescription] );
      fResult := pFn( 0, ODBC_ADD_SYS_DSN, @strDriver[1], @strAttr[1] );
      if( fResult = false ) then
        ShowMessage( 'Falha ao tentar criar o DSN (Data source).' );
      if( FindFirst( strFile, 0, srInfo ) <> 0 ) then
      begin
        strDriver := cDriver;
        strAttr := Format( 'DSN=%s'+#0+
          'DBQ=%s'+#0+
          'Exclusive=%s'+#0+
          'Description= %s'+#0+#0+
          'CREATE_DB="%s"'#0+#0,
          [cDSNName,strFile,cExclusive,cDescription,strFile]);
        fResult := pFn( 0, ODBC_ADD_SYS_DSN, @strDriver[1], @strAttr[1] );
        if( fResult = false ) then
          ShowMessage( 'Falha ao tentar criar o banco de dados' );
      end;
      FindClose( srInfo );
    end;
    FreeLibrary( hLib );
//    if fResult then
//      ShowMessage( 'Banco de dados criado.' );
  end
  else
  begin
    ShowMessage( 'o sistema n�o pode carregar a biblioteca ODBCCP32.DLL' );
  end;
end;

function TfrmPrincipal.Limite(Tabela: String; Condicao: String; Maximo: Integer): boolean;
begin
  Result := True;
  with qryAux do
  begin
    Close;
    Sql.Clear;
    Sql.Add('select count(*) as Reg from ' + Tabela  );
    if Condicao <> '' then
      Sql.Add(' Where ' + Condicao );
    Open;
    if FieldByName('Reg').Value >= Maximo then
    begin
      ShowMessage('Esta � uma C�pia de Demonstra��o e cadastra apenas '+IntToStr(Maximo)+' registros neste m�dulo.'#13+#13+
                  'Para continuar efetuando o cadastro, registre sua c�pia do Sistema Gerenciador de Dados '+#13+#13+
                  'Mais informa��es (0xx11) 4243-8225 - E-Mail: elias.coelho@gmail.com '#13+#13+
                  'Este m�dulo n�o poder� cadastrar mais registros.'+#13+#13+
                  'Por�m o aplicativo continuar� funcionando normalmente.'+#13+#13+
                  'Voc� poder� Alterar/Consultar os dados deste M�dulo.');
      Result := False;
    end;
  end;


{  demo == parametros
  if Button = nbInsert then
  begin
    if ( Demo ) and ( not Limite('clientes','',10) ) then
       Abort;
  end;

}

end;


procedure TfrmPrincipal.FormCreate(Sender: TObject);

begin
  {  FFormatoBR := TFormatSettings.Create;

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
           }
    dxnCadastros.Visible       := False;
    dxnImportar.Visible        := False;
    dxnUtilitarios.Visible     := False;

//   LerIni(1,pBanco,pHost,Usuario,Senha);

    DB_Conect.LerCredenciais;

    if Credencias.Host = '' then
    begin
      Mens_MensInf('Problemas na Leitura do Arquivo DB-Treinamento.Ini !');
      Application.Terminate;
      Close;
      Exit;
    end;

   with DB_Conect  do
   begin
      SQLConnection.Params.Clear;
      SQLConnection.Params.LoadFromFile( ExtractFilePath(Application.ExeName) + '\' +  'DB-Treinamento.ini' );
      SQLConnection.Open;
   end;

        {

   // INI
    DB_Conect.SQLConnection.ConnectionName := 'ESCGESTAO';
    DB_Conect.SQLConnection.Params.Clear;
    DB_Conect.SQLConnection.Params.Add('DriverName=MSSQL');
    DB_Conect.SQLConnection.Params.Add('DriverUnit=Data.DBXMsSQL');
    DB_Conect.SQLConnection.Params.Add('HostName=' +  Credencias.Host);
    DB_Conect.SQLConnection.Params.Add('DataBase=' + Credencias.DataBase);
    DB_Conect.SQLConnection.Params.Add('User_Name=' + Credencias.UserName);

    //if Credencias.Password = '474952665A2B317A54424D3D' then
    DB_Conect.SQLConnection.Params.Add('Password=' + Credencias.Password);

    DB_Conect.SQLConnection.Params.Add('BlobSize=-1');
    DB_Conect.SQLConnection.Params.Add('ErrorResourceFile=');
    DB_Conect.SQLConnection.Params.Add('LocaleCode=0000');
    DB_Conect.SQLConnection.Params.Add('MSSQL TransIsolation=ReadCommited');
    DB_Conect.SQLConnection.Params.Add('OS Authentication=False');
  //  DB_Conect.SQLConnection.Params.Add('GetDriverFunc=getSQLDriverMSSQL ');
    DB_Conect.SQLConnection.Params.Add('LibraryName=dbxmss.dll');;
    DB_Conect.SQLConnection.Params.Add('VendorLib=sqlncli10.dll');
    DB_Conect.SQLConnection.Params.Add('VendorLibWin64=sqlncli10.dll');
     }
    GDatabase := 'ESCGESTAO' ;
    SQLTable_Start('ESCGESTAO',DBTYPE_SQLSERVER_70) ;

    Glob_GetParFin() ;

end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

if Odd( GetKeyState(VK_CAPITAL) ) then
   stb.Panels[3].Text := 'CAPS'
else
   stb.Panels[3].Text := '';

if Odd( GetKeyState(VK_INSERT) ) then
   stb.Panels[4].Text := 'INS'
else
   stb.Panels[4].Text := '';

if Odd( GetKeyState(VK_NUMLOCK) ) then
   stb.Panels[5].Text := 'NUM'
else
   stb.Panels[5].Text := '';

end;

procedure TfrmPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin

end;

{-----------------------------------------------------------------------}
{               CHECA SE EXISTE ODBC - ELIAS - 24-04-06 23:33           }
{-----------------------------------------------------------------------}

function TfrmPrincipal.VerODBC: String;
var
  Reg:TRegistry;
begin
  Result := '';
  try
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_LOCAL_MACHINE;
    Reg.OpenKey('SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources\',true);
    Result := Reg.ReadString('Comercial');
    Reg.CloseKey;
    Reg.Free;
  except

  end;
end;

{-----------------------------------------------------------------------}
{               EXECUTADA QUANDO frmPrincipal FOR FECHADO               }
{-----------------------------------------------------------------------}
procedure TfrmPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i: Integer;
begin

{ Fecha todas as janelas filhas, provocando a execu��o do evento
  OnClose de cada uma, que verifica se o texto foi salvo ou n�o }
{ Percorre as janelas filhas abertas (na ordem de abertura) e
  fecha cada uma delas }

for i := MDIChildCount - 1 downto 0 do
    MDIChildren[ i ].Close;

{ Processa as mensagens do Windows para atualizar o conte�do da
  propriedade MDIChildCount }
  Application.ProcessMessages;


  { Se sobrou alguma janela filha aberta, n�o fechar a janela m�e }
 { if MDIChildCount > 0 then
  begin
    Action := caNone;
    Mens_MensInf( IntToStr(MDIChildCount) + ' Janela(s) Abertas, O Sistema N�o Pode Ser Fechado!');
    Exit;
  end;
  Application.Terminate;
  Exit;
  }
{
if Mens_MensConf('Confirma Sair do Sistema?') <> mrOK then
  Action := caNone;
}

end; // PROCEDURE

{-----------------------------------------------------------------------}
{                    FECHA JANELA FILHA ATIVA                           }
{-----------------------------------------------------------------------}
procedure TfrmPrincipal.actFecharExecute(Sender: TObject);
begin
{ Se n�o existir nenhuma janela filha aberta ent�o saia da procedure}
if MDIChildCount = 0 then Exit;
{ Fecha a janela atualmente ativa }
ActiveMDIChild.Close;
end;

procedure TfrmPrincipal.actGeradorGIAExecute(Sender: TObject);
begin
   If ( Not Glob_GetAccess('EXPORTAR_DOC','') ) Then
   Begin
       Mens_MensInf('Opera��o n�o liberada para o usu�rio !') ;
       Exit;
   End ;

 //  frmGerador:=TfrmGerador.Create(Self);
//   frmGerador.Show;

end;

procedure TfrmPrincipal.actImportarFilialExecute(Sender: TObject);
begin
    If ( Not Glob_GetAccess('IMPORTAR_DOC','') ) Then
   Begin
       Mens_MensInf('Opera��o n�o liberada para o usu�rio !') ;
       Exit;
   End ;

  // FrmImportarFilial:=TFrmImportarFilial.Create(Self);
 //  FrmImportarFilial.Show;
end;

procedure TfrmPrincipal.actImpXLExecute(Sender: TObject);
begin
   If ( Not Glob_GetAccess('IMPORTAR_DOC','') ) Then
   Begin
       Mens_MensInf('Opera��o n�o liberada para o usu�rio !') ;
       Exit;
   End ;

 //  frmImportador:=TfrmImportador.Create(Self);
 //  frmImportador.Show;

end;

procedure TfrmPrincipal.actInstrutorExecute(Sender: TObject);
begin
   If ( Not Glob_GetAccess('CAD_INSTRUTOR','') ) Then
   Begin
       Mens_MensInf('Opera��o (CAD_INSTRUTOR) n�o liberada para o usu�rio !') ;
       Exit;
   End ;

  FrmCadInstrutor:=TFrmCadInstrutor.Create(Self);
  FrmCadInstrutor.Show;

end;

{-----------------------------------------------------------------------}
{                       SAI DA APLICA��O                                }
{-----------------------------------------------------------------------}
procedure TfrmPrincipal.actSairExecute(Sender: TObject);
begin
   Application.Terminate;
   // Close;
end;

procedure TfrmPrincipal.actTipoTreinamentoExecute(Sender: TObject);
begin
    If ( Not Glob_GetAccess('CAD_TIPOTREINAMENTO','') ) Then
   Begin
       Mens_MensInf('Opera��o (CAD_TIPOTREINAMENTO) n�o liberada para o usu�rio !') ;
       Exit;
   End ;

   FrmCadTipoTreinamento := TFrmCadTipoTreinamento.Create(Self);
   FrmCadTipoTreinamento.Show;


end;

procedure TfrmPrincipal.actTreinamentoExecute(Sender: TObject);
begin

   If ( Not Glob_GetAccess('CAD_TREINAMENTO','') ) Then
   Begin
       Mens_MensInf('Opera��o (CAD_TREINAMENTO) n�o liberada para o usu�rio !') ;
       Exit;
   End ;

   FrmCadTreinamento := TFrmCadTreinamento.Create(Self);
   FrmCadTreinamento.Show;

end;

{-----------------------------------------------------------------------}
{  PROCEDURE DO TIMER - ATUALIZA BARRA DE STATUS E BOT�ES DA BARRA  DE  }
{  FERRAMENTAS QUE INDICAM O ESTILO DE LETRA DO TRECHO DE TEXTO ATUAL   }
{-----------------------------------------------------------------------}
procedure TfrmPrincipal.TimerTimer(Sender: TObject);
var
  Endereco : String;
  Dia, Mes, Ano : Word;
begin
   Timer.Enabled := False ;


   DB_Conect.LerCredenciais;

   if Credencias.Host = '' then
   begin
      Mens_MensInf('Problemas na Leitura do Arquivo DB-Treinamento.Ini !');
      Application.Terminate;
      Close;
      Exit;
    end;

   with DB_Conect  do
   begin
      SQLConnection.Params.Clear;
      SQLConnection.Params.LoadFromFile( ExtractFilePath(Application.ExeName) + '\' +  'DB-Treinamento.ini' );
      SQLConnection.Open;
   end;

   if not DB_Conect.SQLConnection.Connected then
   begin
     Mens_MensErro('Erro Conectando Banco de Dados!');
     Close;
     Exit;
   end;

    qryAux.Close;
    qryAux.Sql.Clear;
    qryAux.SQL.Add('select versao From Parametros  ' );
    try
      qryAux.Open;
    Except
    End;

    GVersao := qryAux.FieldByName('Versao').AsString;

   If ( GVersao <> '1000' ) Then
     Begin
       Mens_MensInf('Programa necessita de Atualizac�o, clique e aguarde o DOWNLOAD !!') ;
       Endereco := 'http://www.escsistemas.com.br/ESCGestao' + GVersao + '.exe';
       shellExecute(Handle, 'Open', PChar(Endereco), nil, nil, sw_shownormal);
       Application.Terminate ;
       Exit ;
     end;

   frmPrincipal.Enabled := False;

   FrmLogin := TFrmLogin.Create(Self) ;
   If ( FrmLogin.Showmodal <> mrOk ) Then
   Begin
       FrmLogin.Close ;
       Close ;
       Exit ;
   End ;
   frmPrincipal.Enabled := True;


   qryAux.Close;
   qryAux.Sql.Clear;
//   qryAux.SQL.Add('Select Convert(DateTime, (convert(varchar(10), getdate(), 103))) as DataServer ');
   qryAux.SQL.Add('Select getdate() as DataServer ');
   qryAux.Open;

   DecodeDate(qryAux.FieldByName('DataServer').AsDateTime, Ano, Mes, Dia);

   DataServer := EncodeDate(Ano, Mes, Dia);
   qryAux.Close;

   stb.panels[0].Text := 'Usu�rio - ' + FrmLogin.EdiUsuario.Text;
   stb.panels[1].Text := 'Servidor ' + pHost;
   stb.panels[2].Text := 'Data de Trabalho..: ' + DateToStr(Date);

   FrmLogin.Close ;
   dxn.Visible                := True;

   dxnCadastros.Visible       := ( Glob_GetAccess('MENU-CAD','') ) ;
   dxnImportar.Visible        := ( Glob_GetAccess('IMPORTAR_FUN','') ) ;
   dxnUtilitarios.Visible     := ( Glob_GetAccess('MENU-UTIL','') ) ;
   dxnRelatorio.Visible       := ( Glob_GetAccess('MENU-REL','') ) ;
   dxnUsuarios.Visible        := ( Glob_GetAccess('CAD_USUARIO','') ) ;
   dxnCurso.Visible           := ( Glob_GetAccess('CAD_CURSO','') ) ;
   dxnTreinamento.Visible     := ( Glob_GetAccess('CAD_TREINAMENTO','') ) ;
   dxnEmpresa.Visible         := ( Glob_GetAccess('CAD_EMPRESA','') ) ;
   dxnInstrutor.Visible       := ( Glob_GetAccess('CAD_INSTRUTOR','') ) ;
   dxnFornecedor.Visible      := ( Glob_GetAccess('CAD_FORNECEDOR','') ) ;
   dxnTipoTreinamento.Visible := ( Glob_GetAccess('CAD_TIPOTREINAMENTO','') ) ;
   dxnPeriodicidade.Visible   := ( Glob_GetAccess('CAD_PERIODICIDADE','') ) ;
   dxnPerfilOper.Visible      := ( Glob_GetAccess('PER-OPE','') ) ;
   dxnOperacao.Visible        := ( Glob_GetAccess('SIS_OPERACAO','') ) ;
   dxnPorParticipante.Visible := ( Glob_GetAccess('REL-PARTICIPANTE','') ) ;
   dxnPorTreinamento.Visible  := ( Glob_GetAccess('REL-TREINAMENTO','') ) ;

//   if dxnProcedimentos.Visible then
//     dxn.ActiveGroupIndex := 1
//   else if dxnCadastros.Visible then
   dxn.ActiveGroupIndex := 0;
        {
   If ( DataServer > StrToDate('2014-11-20'))  Then
   begin
     Application.Terminate ;
     Exit ;
   end;
       }

if Odd( GetKeyState(VK_CAPITAL) ) then
   stb.Panels[3].Text := 'CAPS'
else
   stb.Panels[3].Text := '';

if Odd( GetKeyState(VK_INSERT) ) then
   stb.Panels[4].Text := 'INS'
else
   stb.Panels[4].Text := '';

if Odd( GetKeyState(VK_NUMLOCK) ) then
   stb.Panels[5].Text := 'NUM'
else
   stb.Panels[5].Text := '';

end;
{-----------------------------------------------------------------------}
{ CORRIGE O TAMANHO DOS PANELS DA STATUSBAR QUANDO ELA � REDIMENSIONADA }
{-----------------------------------------------------------------------}
procedure TfrmPrincipal.stbResize(Sender: TObject);
begin
  stb.Panels[0].width := stb.Width - 180;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
 // Date_FillFeriado() ;
  MainImage.Transparent := True;
{
  if FileExists(ExtractFileDir(Application.ExeName) + '\Fundo.jpg') then
    MainImage.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\Fundo.jpg')
  else if FileExists(ExtractFileDir(Application.ExeName) + '\Fundo.bmp') then
    MainImage.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) + '\Fundo.bmp')
  else
    MainImage.Picture.CleanupInstance;
 }
end;

procedure TfrmPrincipal.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  If ( FrmLogin <> Nil ) and (GUsuario <> '') Then
  begin
    canclose := false;

    if Mens_MensConf('Tem Certeza Que Deseja Sair do Sistema ?') = mrOK then
    begin
      canclose := True;
    end;
  end;

end;

procedure TfrmPrincipal.OrganizarJanelasemCascata1Click(Sender: TObject);
begin
{ Organiza em cascata }
  Cascade;
end;

procedure TfrmPrincipal.JanelasLadoaLado1Click(Sender: TObject);
begin
  { Define o modo de organiza��o lado a lado }
  TileMode := tbHorizontal;
  { Organiza lado a lado }
  Tile;

end;

procedure TfrmPrincipal.Horizontal1Click(Sender: TObject);
begin
{ Define o modo de organiza��o lado a lado }
TileMode := tbHorizontal;
{ Organiza lado a lado }
Tile;

end;

procedure TfrmPrincipal.Vertical1Click(Sender: TObject);
begin
{ Define o modo de organiza��o lado a lado }
TileMode := tbVertical;
{ Organiza lado a lado }
Tile;

end;

procedure TfrmPrincipal.actPerfilOperExecute(Sender: TObject);
begin
  If ( Not Glob_GetAccess('PER-OPE','') ) Then
  Begin
      Mens_MensInf('Opera��o ( PER-OPE ) n�o liberada para o usu�rio !') ;
      Exit;
  End ;

  FrmPerfilOpe := TFrmPerfilOpe.Create(Application);
  FrmPerfilOpe.Show;
end;

procedure TfrmPrincipal.actPeriodicidadeExecute(Sender: TObject);
begin

   If ( Not Glob_GetAccess('CAD_PERIODICIDADE','') ) Then
   Begin
       Mens_MensInf('Opera��o (CAD_PERIODICIDADE) n�o liberada para o usu�rio !') ;
       Exit;
   End ;

   FrmCadPeriodicidade:=TFrmCadPeriodicidade.Create(Self);
   FrmCadPeriodicidade.Show;


end;

procedure TfrmPrincipal.actPorParticipanteExecute(Sender: TObject);
begin
   If ( Not Glob_GetAccess('REL-PARTICIPANTE','') ) Then
   Begin
       Mens_MensInf('Opera��o (REL-PARTICIPANTE) n�o liberada para o usu�rio !') ;
       Exit;
   End ;

   FrmRelParticipante:=TFrmRelParticipante.Create(Self);
   FrmRelParticipante.Show;
end;

procedure TfrmPrincipal.actPorTreinamentoExecute(Sender: TObject);
begin
    If ( Not Glob_GetAccess('REL-TREINAMENTO','') ) Then
   Begin
       Mens_MensInf('Opera��o (REL-TREINAMENTO) n�o liberada para o usu�rio !') ;
       Exit;
   End ;

   FrmRelTreinamento:=TFrmRelTreinamento.Create(Self);
   FrmRelTreinamento.Show;
end;

procedure TfrmPrincipal.actRelNFeExecute(Sender: TObject);
begin

   If ( Not Glob_GetAccess('CONS_DOCUMENTO','') ) Then
   Begin
       Mens_MensInf('Opera��o n�o liberada para o usu�rio !') ;
       Exit;
   End ;

 //  frmConsultaDocumento:=TfrmConsultaDocumento.Create(Self);
//   frmConsultaDocumento.Show;
end;

procedure TfrmPrincipal.actParametrosExecute(Sender: TObject);
begin
  If ( Not Glob_GetAccess('SIS_PARAM','') ) Then
  Begin
      Mens_MensInf('Opera��o ( SIS_PARAM ) n�o liberada para o usu�rio !') ;
      Exit;
  End ;

   FrmParametros := TFrmParametros.Create(Self) ;
   FrmParametros.Show ;
end;

procedure TfrmPrincipal.actFuncionarioExecute(Sender: TObject);
begin
  If ( Not Glob_GetAccess('IMPORTAR_FUN','') ) Then
  Begin
      Mens_MensInf('Opera��o ( IMPORTAR_FUN ) n�o liberada para o usu�rio !') ;
      Exit;
  End ;

  frmImpFuncionario := TfrmImpFuncionario.Create(Self) ;
  frmImpFuncionario.Show ;
end;

procedure TfrmPrincipal.actUsuarioExecute(Sender: TObject);
begin
  If ( Not Glob_GetAccess('CAD_USUARIO','') ) Then
  Begin
      Mens_MensInf('Opera��o ( CAD_USUARIO ) n�o liberada para o usu�rio !') ;
      Exit;
  End ;

  FrmUsuario := TFrmUsuario.Create(Self) ;
  FrmUsuario.Show ;
end;

procedure TfrmPrincipal.actPerfilExecute(Sender: TObject);
begin
  If ( Not Glob_GetAccess('PER-OPE','') ) Then
  Begin
      Mens_MensInf('Opera��o ( PER-OPE ) n�o liberada para o usu�rio !') ;
      Exit;
  End ;

  FrmPerfil := TFrmPerfil.Create(Application);
  FrmPerfil.Show;
end;

procedure TfrmPrincipal.DownLoad(NomeArquivo: String);
function TamArquivo(Arquivo: string): Integer;
begin
  with TFileStream.Create(Arquivo, fmOpenRead or fmShareExclusive) do
    try
      Result := Size;
    finally
       Free;
  end;
end;

Var
  DownDestino : String;
  dirDestino  : String;
  Tamanho_Arquivo : Integer;
begin
  DownDestino := ExtractFileDir(Application.ExeName) + '\' + NomeArquivo ;

  if (FileExists(DownDestino)) and (TamArquivo(DownDestino) = 0) then
    DeleteFile(DownDestino);

  if (FileExists(DownDestino)) then
    Exit;

  DirDestino := 'Web/update/' ;//+ NomeArquivo;

  try
    IdFTP.Username := '';
    IdFTP.Password := '';
    IdFTP.Host     := '';
    IdFTP.Connect;
    IdFTP.ChangeDir(dirDestino);
  except
    IdFTP.Disconnect;
    Exit;
  end;

  Tamanho_Arquivo := IdFTP.Size(NomeArquivo);

  if (Tamanho_Arquivo = 0) then
  begin
    Mens_MensInf('Arquivo JPG Com Tamanho (0), Pode Ter Ocorrido Erro Durante UPLoad da Imagem !');
    try
      IdFTP.Delete(NomeArquivo);
    Except
    end;
    Exit;
  end;

  try
    Screen.Cursor:=crSQLWait;
    // DOWNLOAD.
    IdFTP.GET(PChar(NomeArquivo),PChar(DownDestino), True);

    Screen.Cursor:=crDefault;
  except
    DownDestino := '';
    Screen.Cursor:=crDefault;
    Mens_MensErro('Erro Carregando Logo !');
    Exit;
  end;

  Screen.Cursor:=crDefault;
  IdFTP.Disconnect;

end;

procedure TfrmPrincipal.actCadParticipanteExecute(Sender: TObject);
begin
   If ( Not Glob_GetAccess('CAD_PARTICIPANTE','') ) Then
   Begin
       Mens_MensInf('Opera��o (CAD_PARTICIPANTE) n�o liberada para o usu�rio !') ;
       Exit;
   End ;


   FrmCadParticipante := TFrmCadParticipante.Create(Self);
   FrmCadParticipante.Show;

end;

procedure TfrmPrincipal.actCargoExecute(Sender: TObject);
begin
   If ( Not Glob_GetAccess('CAD_CARGO','') ) Then
   Begin
       Mens_MensInf('Opera��o (CAD_CARGO) n�o liberada para o usu�rio !') ;
       Exit;
   End ;


   FrmCargos := TFrmCargos.Create(Self);
   FrmCargos.Show;
end;

procedure TfrmPrincipal.actCentroCustoExecute(Sender: TObject);
begin
  If ( Not Glob_GetAccess('CAD_CENTROCUSTO','') ) Then
   Begin
       Mens_MensInf('Opera��o (CAD_CENTROCUSTO) n�o liberada para o usu�rio !') ;
       Exit;
   End ;


   FrmCentroCusto := TFrmCentroCusto.Create(Self);
   FrmCentroCusto.Show;
end;

procedure TfrmPrincipal.actConsultaCTEExecute(Sender: TObject);
begin

  If ( Not Glob_GetAccess('CONS_DOCUMENTO','') ) Then
   Begin
       Mens_MensInf('Opera��o n�o liberada para o usu�rio !') ;
       Exit;
   End ;


 //  FrmConsultaCTE := TFrmConsultaCTE.Create(Self);
 //  FrmConsultaCTE.Show;

end;

procedure TfrmPrincipal.actConsultaItensExecute(Sender: TObject);
begin
  If ( Not Glob_GetAccess('CONS_DOCUMENTO','') ) Then
   Begin
       Mens_MensInf('Opera��o n�o liberada para o usu�rio !') ;
       Exit;
   End ;


 //  frmConsultaItens := TfrmConsultaItens.Create(Self);
 //  frmConsultaItens.Show;

end;

procedure TfrmPrincipal.actConsultaNFExecute(Sender: TObject);
begin
{
  If ( Not Glob_GetAccess('CONS_NF','') ) Then
   Begin
       Mens_MensInf('Opera��o n�o liberada para o usu�rio !') ;
       Exit;
   End ;

   FrmConsNotaFiscal := TFrmConsNotaFiscal.Create(Self);
   FrmConsNotaFiscal.Show;
   }
end;

procedure TfrmPrincipal.actContaEmailExecute(Sender: TObject);
begin
   If ( Not Glob_GetAccess('CAD_CONTAEMAIL','') ) Then
   Begin
       Mens_MensInf('Opera��o n�o liberada para o usu�rio !') ;
       Exit;
   End ;

 //  FrmCadEmail:=TFrmCadEmail.Create(Self);
  // FrmCadEmail.Show;
end;

procedure TfrmPrincipal.actCursoExecute(Sender: TObject);
begin

   If ( Not Glob_GetAccess('CAD_CURSO','') ) Then
   Begin
       Mens_MensInf('Opera��o (CAD_CURSO) n�o liberada para o usu�rio !') ;
       Exit;
   End ;

   FrmCadCurso:=TFrmCadCurso.Create(Self);
   FrmCadCurso.Show;
end;

procedure TfrmPrincipal.actEmpresaExecute(Sender: TObject);
begin
   If ( Not Glob_GetAccess('CAD_EMPRESA','') ) Then
   Begin
       Mens_MensInf('Opera��o (CAD_EMPRESA) n�o liberada para o usu�rio !') ;
       Exit;
   End ;

  FrmCadFilial := TFrmCadFilial.Create(Self);
  FrmCadFilial.Show;
end;

procedure TfrmPrincipal.actFornecedorExecute(Sender: TObject);
begin
   If ( Not Glob_GetAccess('CAD_FORNECEDOR','') ) Then
   Begin
       Mens_MensInf('Opera��o (CAD_FORNECEDOR) n�o liberada para o usu�rio !') ;
       Exit;
   End ;

   FrmCadEntidade:=TFrmCadEntidade.Create(Self);
   FrmCadEntidade.Show;
end;

procedure TfrmPrincipal.dxnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.stbPanels1Click(Sender: TObject);
var
  Mail : String;
begin
  Mail := 'mailto:marcos.luiz.jesus@hotmail.com';
  ShellExecute(GetDesktopWindow,'open',pchar(Mail),nil,nil,sw_ShowNormal);
end;

procedure TfrmPrincipal.LerIni(Ambiente: Integer; var Banco, Host, Usuario,
  Senha: String);
var
  ArqIni : TIniFile;
begin
  ArqIni := tIniFile.Create(ExtractFilePath(Application.ExeName) + 'DB-Treinamento.ini');
  Try
    Banco   := ArqIni.ReadString('Banco' + IntToStr(Ambiente), 'DataBase', Banco);
    Host    := ArqIni.ReadString('Banco' + IntToStr(Ambiente), 'HostName', Host );
    Usuario := ArqIni.ReadString('Banco' + IntToStr(Ambiente), 'User_Name', Usuario );
    Senha   := ArqIni.ReadString('Banco' + IntToStr(Ambiente), 'Password', Senha );
  Finally
    ArqIni.Free;
  end;
end;


procedure TfrmPrincipal.actNaturezaExecute(Sender: TObject);
begin
   If ( Not Glob_GetAccess('CAD_NATUREZA','') ) Then
   Begin
       Mens_MensInf('Opera��o n�o liberada para o usu�rio !') ;
       Exit;
   End ;

 // FrmNatureza := TFrmNatureza.Create(Self) ;
 // FrmNatureza.Show ;
end;

procedure TfrmPrincipal.actManutNFeExecute(Sender: TObject);
var
  i : integer;
begin
{
  for i := MDIChildCount - 1 downto 0 do
  begin
   if MDIChildren[ i ].Name = 'FrmEmissaoNFe' then
   begin
      Mens_MensInf('Por favor, Fechar a Tela de Emiss�o de Nota Fiscal Para Continuar ! ');
      MDIChildren[ i ].Show;
      Exit;
   end;
  end;
}

end;

procedure TfrmPrincipal.actOperacaoExecute(Sender: TObject);
begin
  If ( Not Glob_GetAccess('SIS_OPERACAO','') ) Then
   Begin
       Mens_MensInf('Opera��o n�o liberada para o usu�rio !') ;
       Exit;
   End ;

  FrmOperacao := TFrmOperacao.Create(Self) ;
  FrmOperacao.Show ;
end;

end.




BACKUP DATABASE ESCGestao To disk = 'D:\testeDB.bak'
