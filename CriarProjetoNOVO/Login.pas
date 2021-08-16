//www.mundodelphi.com.br

unit Login;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, dxRibbonForm,
  StdCtrls, Buttons, Mask,  ExtCtrls,  dbTables, Db,
  dxSkinsCore, dxSkinsDefaultPainters, cxLookAndFeels, dxSkinsForm , cxControls,
  dxSkinscxPCPainter, cxPC, cxContainer, cxEdit, cxLabel, Menus,
  cxLookAndFeelPainters, cxButtons, cxGraphics, dxSkinBlack, dxSkinBlue,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, FMTBcd, SqlExpr, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinSevenClassic,
  dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint,
  dxBarBuiltInMenu, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Global;

type
  TFrmLogin = class(TdxRibbonForm)
    cxPage: TcxPageControl;
    cxLogin: TcxTabSheet;
    cxAltera: TcxTabSheet;
    EdiUsuNome: TEdit;
    EdiSenha: TMaskEdit;
    EdiSAtual: TMaskEdit;
    EdiSNova: TMaskEdit;
    EdiSConf: TMaskEdit;
    cxLabel2: TcxLabel;
    cxLabel1: TcxLabel;
    butOk: TcxButton;
    butCancel: TcxButton;
    btnOKSenha: TcxButton;
    cxButton2: TcxButton;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    FQ_Auxiliar: TFDQuery;
    procedure EdiUsuarioExit(Sender: TObject);
    procedure ButOkClick(Sender: TObject);
    procedure btnOkSenhaClick(Sender: TObject);
    procedure EdiSenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
 //   Tab : TSQLTableClass ;
    AlteraSenha : String;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.DFM}

uses DBConect;

//Uses    Global, MensFun, Constantes, TestFun, DBConect ;

procedure TFrmLogin.EdiUsuarioExit(Sender: TObject);
begin
 { EdiUsuNome.Text := Tab.SeekGet('USUARIOS','CodUsuario',[EdiUsuario.Text],'Nome',True) ;

  GFilial     := Tab.SeekGet('USUARIOS','CodUsuario',[EdiUsuario.Text],'Filial',False) ;
  GVendedor   := Tab.SeekGet('USUARIOS','CodUsuario',[EdiUsuario.Text],'CodVendedor',False) ;
  GSenha      := Tab.SeekGet('USUARIOS','CodUsuario',[EdiUsuario.Text],'Senha',False) ;
  AlteraSenha := Tab.SeekGet('USUARIOS','CodUsuario',[EdiUsuario.Text],'Altera',False) ;
  }
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
   FQ_Auxiliar.Connection := DB_Conect.SQLConnection;
end;

procedure TFrmLogin.ButOkClick(Sender: TObject);

begin

   If ( EdiUsuNome.Text = '' ) Then
   Begin
       Application.MessageBox( 'Informe o Nome do Usu�rio', 'AppXML',  MB_ICONINFORMATION+MB_OK );
       EdiUsuNome.SetFocus ;
       Exit ;
   End ;

   FQ_Auxiliar.Close;
   FQ_Auxiliar.SQL.Clear;
   FQ_Auxiliar.SQL.Add('Select codusuario, nome, senha From usuario ');
   FQ_Auxiliar.SQL.Add(' Where nome = :nome and senha = :senha');
   FQ_Auxiliar.Params.ParamByName('nome').AsString  := EdiUsuNome.Text;
   FQ_Auxiliar.Params.ParamByName('senha').AsString := EdiSenha.Text;
   FQ_Auxiliar.Open;

   if  FQ_Auxiliar.IsEmpty then
   begin
       Application.MessageBox( 'Usuario n�o encontrado.', 'AppXML', MB_ICONINFORMATION+MB_OK );
       Exit;
   end;


   if Glob_FillPerfilPG(FQ_Auxiliar.FieldByName('codusuario').AsInteger) = False Then
   begin
        Application.MessageBox( '[Glob_SetPerfil] - Este usu�rio n�o apresenta perfil cadastrado', 'AppABC',  MB_ICONINFORMATION+MB_OK  );
   end;

   ModalResult := mrOk ;
end;

procedure TFrmLogin.btnOkSenhaClick(Sender: TObject);
Var
SNova : Integer;
begin
{
     if EdiSAtual.Text <> GSenha then
       Begin
         Mens_MensInf('A Senha atual n�o coincide com a senha digitada anteriormente !');
         EdiSAtual.SetFocus;
         Exit;
       end;

     if ( Test_IsEmptyStr(EdiSNova.Text) )  then
       Begin
         Mens_MensInf('A Nova Senha N�o Informada!');
         EdiSNova.SetFocus;
         Exit;
       end;

     if ( Test_IsEmptyStr(EdiSConf.Text) )  then
       Begin
         Mens_MensInf('A Confirma��o de Senha N�o Informado!');
         EdiSConf.SetFocus;
         Exit;
       end;

     if EdiSNova.Text <> EdiSConf.Text then
       Begin
         Mens_MensInf('A Nova senha n�o coincide com a Confirma��o ! Favor digite novamente.');
         EdiSNova.Text := '';
         EdiSConf.Text := '';
         EdiSNova.SetFocus;
         Exit;
       end;


    qryAux.Close;
    qryAux.Sql.Clear;
    qryAux.Sql.Add('update Usuarios set Senha = ''' + EdiSNova.Text + ''', Altera = ''0'' where CodUsuario = ''' + EdiUsuario.Text + '''' );
    try
      qryAux.ExecSQL;
    except
      Mens_MensErro('Erro Alterando Senha!' );
      Exit;
    end;

   Mens_MensInf('Senha Alterada Com Sucesso!');
    
   cxPage.ActivePage := cxLogin;
   EdiUsuarioExit(Self);
   EdiSenha.Text := GSenha;
   ButOkClick(Self);
   }
end;


procedure TFrmLogin.EdiSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    ButOkClick(Self);
end;

end.

