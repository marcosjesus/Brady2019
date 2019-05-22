//www.mundodelphi.com.br

unit Login;

interface

uses
  Windows, Messages, SysUtils, System.Variants, Classes, Graphics, Controls, Forms, Dialogs, dxRibbonForm,
  StdCtrls, Buttons, Mask, rsEdit, ExtCtrls, SqlTableFun, dbTables, Db,
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
  dxBarBuiltInMenu, EditBusca, SetParametro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmLogin = class(TdxRibbonForm)
    cxPage: TcxPageControl;
    cxLogin: TcxTabSheet;
    cxAltera: TcxTabSheet;
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
    EdiUsuario: TEditBusca;
    qryAux: TFDQuery;
    procedure ButOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkSenhaClick(Sender: TObject);
    procedure EdiSenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure EdiUsuarioClick(Sender: TObject);
  private
    { Private declarations }
    Tab : TSQLTableClass ;
    AlteraSenha : String;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.DFM}

Uses
   Global, MensFun, Constantes, TestFun, DBConect ;

procedure TFrmLogin.EdiUsuarioClick(Sender: TObject);
begin
  if ((EdiUsuario.Text <> '' )and (EdiUsuario.bs_KeyValues.Count > 0)) then
  begin
    GFilial     := Tab.SeekGet('USUARIO','CodUsuario',[VarToStr(EdiUsuario.bs_KeyValue)],'Filial',False) ;
    GSenha      := Tab.SeekGet('USUARIO','CodUsuario',[VarToStr(EdiUsuario.bs_KeyValue)],'Senha',False) ;
    AlteraSenha := Tab.SeekGet('USUARIO','CodUsuario',[VarToStr(EdiUsuario.bs_KeyValue)],'Altera',False) ;
    GUsuarioAtivo := Tab.SeekGet('USUARIO','CodUsuario',[VarToStr(EdiUsuario.bs_KeyValue)],'ATIVO',False) ;

    if GUsuarioAtivo = '1' then
    begin
        Mens_MensInf('Usu�rio encontra-se inativo.');
        EdiUsuario.Text := '';
        EdiUsuario.bs_KeyValues.Clear;

        Exit;
    end;

    EdiSenha.SetFocus;
  end;

end;

procedure TFrmLogin.ButOkClick(Sender: TObject);
var
  QUsuFil : TSQLQuery ;
begin
{
  if ( ( (Date()) >= (StrToDate('15/08/2006')) ) or ( (Date()) >= (StrToDate('15/08/06')) ) ) then
  begin
    qryAux.Close;
    qryAux.Sql.Clear;
    qryAux.Sql.Add('update Parfinanc set controle = 9 ');
    qryAux.ExecSQL;

    ShowMessage('Esta c�pia do sistema n�o est� registrada, '#13+#13+
                'Registre sua c�pia do Sistema GNCambio '+#13+#13+
                'Mais informa��es (0xx11) 3078-9959 - E-Mail: mtelles@globalnet.eti.br.');
    ModalResult := mrCancel;
    Exit;

  end
  else
  begin
    qryAux.Close;
    qryAux.Sql.Clear;
    qryAux.Sql.Add('Select controle from parfinanc where controle = 9 ');
    qryAux.Open;

    if QryAux.RecordCount > 0  then
    begin
      ShowMessage('Esta c�pia do sistema n�o est� registrada, '#13+#13+
                  'Registre sua c�pia do Sistema GNCambio '+#13+#13+
                  'Mais informa��es (0xx11) 3078-9959 - E-Mail: mtelles@globalnet.eti.br.');
      ModalResult := mrCancel;
      Exit;
    end;
  end;

}
   If ( EdiUsuario.Text = '**********' ) Then
   Begin
       Mens_MensInf('Informe o usu�rio.') ;
       EdiUsuario.SetFocus ;
       Exit ;
   End ;
//   GSenha := Glob_Decript(GSenha);
   If ( EdiSenha.Text <> GSenha ) Then
   Begin
       Mens_MensInf('Senha do usu�rio inv�lida') ;
       EdiSenha.Text := '' ;
       EdiSenha.SetFocus ;
//       GSenha := Glob_Decript(GSenha);
       Exit ;
   End ;

{
   with qrylogado do
   begin
     Close;
     ParamByName('CodUsuario').AsString := EdiUsuario.Text;
     Open;

     if FieldByName('HLogin').AsDateTime <> 0 then
     begin
       Mens_MensInf('Existe outo Login com este Usu�rio !') ;
       EdiSenha.Text := '' ;
       EdiSenha.SetFocus ;
       Exit ;
     End
     else
     begin

       close;
       Sql.Clear;
       Sql.Add('Update usuario set HLogin = GetDate() where CodUsuario = :CodUsuario');
       ParamByName('CodUsuario').AsString := EdiUsuario.Text;
       try
         ExecSQL;
       except
         begin
           Mens_MensErro('Erro ao Executar o Login!');
           EdiSenha.Text := '' ;
           EdiSenha.SetFocus ;
           Exit ;
         end;
       end;
   end;
}

    if AlteraSenha = '1' then
    begin
      cxPage.ActivePage := cxAltera;
      EdiSAtual.SetFocus;
      Exit;
    end;


   GUsuario := VarToStr(EdiUsuario.bs_KeyValue);
   GNome    := EdiUsuario.Text ;
   Glob_FillPerfil(VarToStr(EdiUsuario.bs_KeyValue)) ;
                               {

   GUsuFil := '(';
   QUsuFil := Tab.ExecSqlSel('Select CodFilial from UsuarioXFilial where CodUsuario = ''' + GUsuario + '''');
   while not QUsuFil.EOF do begin
     if GUsuFil = '(' then
        GUsuFil := GUsuFil + '''' + QUsuFil.FieldByName('CodFilial').AsString + ''''
     else
        GUsuFil := GUsuFil + ',''' + QUsuFil.FieldByName('CodFilial').AsString + '''';

     QUsuFil.Next;
   end;

   GUsuFil := GUsuFil + ')';

   if GUsuFil = '()' then
      Mens_MensInf('GUsuFil sem Filiais');


   if GFilial = '' then
     GFilial     := Tab.SeekGet('USUARIO','CodUsuario',[EdiUsuario.Text],'Filial',False) ;

   //003 - Inicio
   if GFilial <> ''  then
   begin
     GRegimeTrib := Tab.SeekGet('FILIAL','CodFilial',[GFilial],'Regime',False);
     GFilialUF   := Tab.SeekGet('FILIAL','CodFilial',[GFilial],'Estado',False);
   end;
                              }
   //003 - Fim


   If ( Not GParFin.Select() ) Then
       Exit ;

   ModalResult := mrOk ;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
   Tab := TSQLTableClass.Create ;
   Tab.OpenTable('Usuario') ;
   EdiUsuario.SetFocus;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
   SetParametros(EdiUsuario, TipoUsuario);
end;

procedure TFrmLogin.FormDestroy(Sender: TObject);
begin
   Tab.Destroy ;
end;

procedure TFrmLogin.btnOkSenhaClick(Sender: TObject);
Var
SNova : Integer;
begin
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
    qryAux.Sql.Add('update Usuario set Senha = ''' + EdiSNova.Text + ''', Altera = ''0'' where CodUsuario = ''' + VarToStr(EdiUsuario.bs_KeyValue) + '''' );
    try
      qryAux.ExecSQL;
    except
      Mens_MensErro('Erro Alterando Senha!' );
      Exit;
    end;

   Mens_MensInf('Senha Alterada Com Sucesso!');
    
   cxPage.ActivePage := cxLogin;
   GFilial     := Tab.SeekGet('USUARIO','CodUsuario',[VarToStr(EdiUsuario.bs_KeyValue)],'Filial',False) ;
   GSenha      := Tab.SeekGet('USUARIO','CodUsuario',[VarToStr(EdiUsuario.bs_KeyValue)],'Senha',False) ;
   AlteraSenha := Tab.SeekGet('USUARIO','CodUsuario',[VarToStr(EdiUsuario.bs_KeyValue)],'Altera',False) ;

   EdiSenha.Text := GSenha;
   ButOkClick(Self);
end;


procedure TFrmLogin.EdiSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    ButOkClick(Self);
end;

end.

