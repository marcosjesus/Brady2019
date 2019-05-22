unit MensFun ;

interface

uses SysUtils, Forms, StdCtrls, Classes, Controls, ExtCtrls, Graphics,
  rsFlyovr;

type
  TscrErro = class(TForm)
    PanMens: TPanel;
    ImaFundo: TImage;
    LabMens: TLabel;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    LabTipoMens: TLabel;
    ImaTitulo: TImage;
    ButOk: TrsFlyOverButton;
    ButCancelar: TrsFlyOverButton;
    procedure FormShow(Sender: TObject);
    procedure ButCancelarClick(Sender: TObject);
    procedure ButOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function Mens_MensErro ( Mensagem: String ): Integer; Export;
function Mens_MensInf ( Mensagem: String ): Integer; Export;
function Mens_MensConf ( Mensagem: String ): Integer; Export;

var
  scrErro: TscrErro;

implementation

{$R *.DFM}

const
     WND_ERROR = 1;
     WND_INFORMATION = 2;
     WND_CONFIRMATION = 3;

function Mens_MensErro ( Mensagem: String ): Integer ;
begin
  scrErro := TscrErro.Create ( Application );
  try
     scrErro.Tag := WND_ERROR;
     scrErro.Top := 110;
     scrErro.Left := 226;
     scrErro.ImaFundo.Picture.LoadFromFile ( 'FundoMens.bmp' );
     scrErro.ImaTitulo.Picture.LoadFromFile ( 'FundoMens.bmp' );
     scrErro.ButOk.Visible := True ;
     scrErro.ButCancelar.Visible := False ;
     scrErro.Caption := 'Mensagem de Erro';
     scrErro.LabTipoMens.Caption := 'MENSAGEM DE ERRO';
     scrErro.LabMens.Caption := Mensagem;
     Application.ProcessMessages ;
     Result := scrErro.ShowModal;
  finally
     scrErro.Release;
  end;
end;

function Mens_MensInf ( Mensagem: String ): Integer;
begin
  scrErro := TscrErro.Create ( Application );
  try
     scrErro.Tag := WND_INFORMATION;
     scrErro.Top := 110;
     scrErro.Left := 226;
     scrErro.ImaFundo.Picture.LoadFromFile ( 'FundoMens.bmp' );
     scrErro.ImaTitulo.Picture.LoadFromFile ( 'FundoMens.bmp' );
     scrErro.Caption := 'Informação';
     scrErro.LabTipoMens.Caption := 'INFORMAÇÃO';
     scrErro.ButOk.Visible := True ;
     scrErro.ButCancelar.Visible := False ;
     scrErro.LabMens.Caption := Mensagem;
     Application.ProcessMessages ;
     Result := scrErro.ShowModal;
  finally
     scrErro.Release;
  end;
end;

function Mens_MensConf ( Mensagem: String ): Integer;
begin
  scrErro := TscrErro.Create ( Application );
  try
     scrErro.Tag := WND_CONFIRMATION;
     scrErro.Top := 110;
     scrErro.Left := 226;
     scrErro.ImaFundo.Picture.LoadFromFile ( 'FundoMens.bmp' );
     scrErro.ImaTitulo.Picture.LoadFromFile ( 'FundoMens.bmp' );
     scrErro.Caption := 'Confirmação';
     scrErro.LabTipoMens.Caption := 'CONFIRMAÇÃO';
     scrErro.ButOk.Visible := True ;
     scrErro.ButCancelar.Visible := True ;
     scrErro.LabMens.Caption := Mensagem;
     Application.ProcessMessages ;
     Result := scrErro.ShowModal;
   finally
     scrErro.Release;
   end;
end;

procedure TscrErro.FormShow(Sender: TObject);
begin
(*
   if scrErro.LabTipoMens.Caption = 'CONFIRMAÇÃO' then
       scrErro.ImaOk.Picture.LoadFromFile ( 'ImaBotOk.bmp' )
   else
       scrErro.ImaOk.Picture.LoadFromFile ( 'ImaBotCancelar.bmp' );
*)
end;

procedure TscrErro.ButCancelarClick(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TscrErro.ButOkClick(Sender: TObject);
begin
   ModalResult := mrOk ;
end;

end.

