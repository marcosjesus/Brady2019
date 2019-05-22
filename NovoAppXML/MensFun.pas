unit MensFun ;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     Grids, DBGrids, Buttons, StdCtrls, ExtCtrls,
     Db, DBTables, jpeg, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
  cxLookAndFeels, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue;

type
  TscrErro = class(TForm)
    PanMens: TPanel;
    LabMens: TLabel;
    Image2: TImage;
    lbltipo: TLabel;
    ButOpc1: TcxButton;
    ButOpc2: TcxButton;
    ButOpc3: TcxButton;
    spbYes: TcxButton;
    spbNo: TcxButton;
    spbOk: TcxButton;
    procedure spbNoClick(Sender: TObject);
    procedure spbYesClick(Sender: TObject);
    procedure spbOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButOpc1Click(Sender: TObject);
    procedure ButOpc2Click(Sender: TObject);
    procedure ButOpc3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function Mens_MensErro ( Mensagem: String ): Integer; Export;
function Mens_MensInf  ( Mensagem: String ): Integer; Export;
function Mens_MensConf ( Mensagem: String ): Integer; Export;
Function Mens_MensOpc2 ( Mensagem : String ; But1Cap, But2Cap : String ) : String ; Export ;
Function Mens_MensOpc3 ( Mensagem : String ; But1Cap, But2Cap : String ) : String ; Export ;
//Function Msg ( Num_Mens : Integer ) : String;

var
  scrErro: TscrErro;

implementation

{$R *.DFM}

const
     WND_ERROR = 1;
     WND_INFORMATION = 2;
     WND_CONFIRMATION = 3;

Var
   FormButOpc : String ;

{
Function Msg ( Num_Mens : Integer ) : String;
begin
 Case Num_Mens of
    1 : Result := 'Field Code is necessary !';
    2 : Result := 'Successfully Modified Password!';
    3 : Result := 'Field User is necessary !' ;
    4 : Result := 'Field Password is necessary !' ;
    5 : Result := 'Code Already Registered !';
    6 : Result := 'Category Must Be A, B ou C!';
    7 : Result := 'Invalid Type !';
    8 : Result := 'Existe POD Cadastrado Para Esta Viagem, Exclua-os Primeiro!';
    9 : Result := 'Registered in cadastre Trip Already!';
    10 : Result := 'Set free Operation Only For Users With Master Profile !';
    11 : Result := 'Set free Operation Only For Users With Master Profile !';
    12 : Result := 'It does not forget Recalcular the Commission !'
    13 : Result := 'User Without Permission!'
    14 : Result := 'User Without Permission !'
    15 : Result := 'Regitro For Duplication Does Not Exist!'
    16 : Result := 'To execute This Operation You Must Have Master Profile !'
    17 : Result := 'They exist Itens For This Trip, Excludes Them First !'
    18 : Result := 'Booking of Destination Not Found !'
    19 : Result := 'Successfully Executed Duplication! BKG NR: ';
    20 : Result
    21 : Result :=
    22 : Result :=
    23 : Result :=
    24 : Result :=
    25 : Result :=
    26 : Result :=
    27 : Result :=
    28 : Result :=
    29 : Result :=
    30 : Result :=
  else
    Result := '';
  end;

end;
}
function Mens_MensErro ( Mensagem: String ): Integer ;
begin
  Result := mrCancel ;
  If ( Mensagem = '' ) Then
     Exit ;
  scrErro := TscrErro.Create ( Application );
  try
     scrErro.spbOk.Visible := True ;
     scrErro.spbYes.Visible  := False ;
     scrErro.spbNo.Visible   := False ;
     scrErro.ButOpc1.Visible := False;
     scrErro.ButOpc2.Visible := False;
     scrErro.ButOpc3.Visible := False;
     scrErro.lbltipo.Caption := 'Mensagem de Erro';
     scrErro.LabMens.Caption := Mensagem;
     Application.ProcessMessages ;
     Result := scrErro.ShowModal;
  finally
     scrErro.Release;
  end;
end;

function Mens_MensInf ( Mensagem: String ): Integer;
begin
  Result := mrCancel ;
  If ( Mensagem = '' ) Then
     Exit ;
  scrErro := TscrErro.Create ( Application );
  try
     scrErro.lbltipo.Caption := 'Informa��o';
     scrErro.spbOk.Visible   := True ;
     scrErro.spbYes.Visible  := False ;
     scrErro.spbNo.Visible   := False ;
     scrErro.ButOpc1.Visible := False;
     scrErro.ButOpc2.Visible := False;
     scrErro.ButOpc3.Visible := False;
     scrErro.LabMens.Caption := Mensagem;
     Application.ProcessMessages ;
     Result := scrErro.ShowModal;
  finally
     scrErro.Release;
  end;

end;

function Mens_MensConf ( Mensagem: String ): Integer;
begin
  Result := mrCancel ;
  If ( Mensagem = '' ) Then
     Exit ;
    scrErro := TscrErro.Create ( Application );
  try
     scrErro.lbltipo.Caption := 'Confirma��o';
     scrErro.spbOk.Visible   := false ;
     scrErro.spbYes.Visible  := true ;
     scrErro.spbNo.Visible   := true ;
     scrErro.ButOpc1.Visible := False;
     scrErro.ButOpc2.Visible := False;
     scrErro.ButOpc3.Visible := False;
     scrErro.LabMens.Caption := Mensagem;
     Application.ProcessMessages ;
     Result := scrErro.ShowModal;
   finally
     FreeAndNil(scrErro);
   end;
end;

Function Mens_MensOpc2 ( Mensagem : String ; But1Cap, But2Cap : String ) : String ;
Begin
  Result := '' ;
  If ( Mensagem = '' ) Then
     Exit ;
  FormButOpc := '' ;
  scrErro := TscrErro.Create ( Application );
  try
     scrErro.Tag := WND_INFORMATION;
//     scrErro.Top := 110;
//     scrErro.Left := 226;
     //scrErro.ImaFundo.Picture.LoadFromFile ( '.\FundoMens.bmp' );
     scrErro.Caption         := 'Op��es:';
     scrErro.lbltipo.Caption := '';
     scrErro.spbYes.Visible := False ;
     scrErro.spbOK.Visible := False ;
     scrErro.spbNo.Visible := False ;
     if Length(But1Cap) > 20 then
     begin
       scrErro.ButOpc1.Left := 12;
       scrErro.ButOpc2.Left := 224;
       scrErro.ButOpc1.Width := 199;
       scrErro.ButOpc2.Width := 199;
//       scrErro.Width := 447;
     end
     else
     begin
       scrErro.ButOpc1.Left := 139 ;
       scrErro.ButOpc2.Left := 251 ;
       scrErro.ButOpc1.Width := 97;
       scrErro.ButOpc2.Width := 97;
//       scrErro.Width := 386;
     end;
     scrErro.ButOpc1.Visible := True ;
     scrErro.ButOpc2.Visible := True ;
     scrErro.ButOpc1.Caption := But1Cap ;
     scrErro.ButOpc2.Caption := But2Cap ;
     scrErro.ButOpc3.Visible := False;
     scrErro.LabMens.Caption := Mensagem;
     Application.ProcessMessages ;
     scrErro.ShowModal;
     Result := FormButOpc ;
  finally
     scrErro.Release;
  end;
End ;

Function Mens_MensOpc3 ( Mensagem : String ; But1Cap, But2Cap : String ) : String ;
Begin
  Result := '' ;
  If ( Mensagem = '' ) Then
     Exit ;
  FormButOpc := '' ;
  scrErro := TscrErro.Create ( Application );
  try
     scrErro.Tag := WND_INFORMATION;
//     scrErro.Top := 110;
//     scrErro.Left := 226;
     //scrErro.ImaFundo.Picture.LoadFromFile ( '.\FundoMens.bmp' );
     scrErro.Caption         := 'Op��es:';
     scrErro.lbltipo.Caption := '';
     scrErro.spbYes.Visible := False ;
     scrErro.spbOK.Visible := False ;
     scrErro.spbNo.Visible := False ;
     if Length(But1Cap) > 20 then
     begin
       scrErro.ButOpc1.Left := 12;
       scrErro.ButOpc2.Left := 224;
       scrErro.ButOpc3.Left := 327 ;
       scrErro.ButOpc1.Width := 199;
       scrErro.ButOpc2.Width := 199;
//       scrErro.Width := 447;
     end
     else
     begin
       scrErro.ButOpc1.Left := 120 ;
       scrErro.ButOpc2.Left := 222 ;
       scrErro.ButOpc3.Left := 325 ;
       scrErro.ButOpc1.Width := 97;
       scrErro.ButOpc2.Width := 97;
//       scrErro.Width := 386;
     end;
     scrErro.ButOpc1.Visible := True ;
     scrErro.ButOpc2.Visible := True ;
     scrErro.ButOpc1.Caption := But1Cap ;
     scrErro.ButOpc2.Caption := But2Cap ;
     scrErro.ButOpc3.Visible := True;
     scrErro.LabMens.Caption := Mensagem;
     Application.ProcessMessages ;
     scrErro.ShowModal;
     Result := FormButOpc ;
  finally
     scrErro.Release;
  end;
End ;

procedure TscrErro.spbNoClick(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TscrErro.spbYesClick(Sender: TObject);
begin
   ModalResult := mrOk ;
end;

procedure TscrErro.spbOkClick(Sender: TObject);
begin
   ModalResult := mrOk ;
end;

procedure TscrErro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
       if key = VK_RETURN then ModalResult := mrOk
  else if key = VK_ESCAPE then ModalResult := mrCancel;
end;

procedure TscrErro.ButOpc1Click(Sender: TObject);
begin
   FormButOpc := ButOpc1.Caption ;
   Close ;
end;

procedure TscrErro.ButOpc2Click(Sender: TObject);
begin
   FormButOpc := ButOpc2.Caption ;
   Close ;
end;

procedure TscrErro.ButOpc3Click(Sender: TObject);
begin
   FormButOpc := '';
   Close ;
end;

end.

