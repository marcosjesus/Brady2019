unit Aguardando;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrmAguardando = class(TForm)
    LbInfo: TLabel;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
  end;

var
  FrmAguardando: TFrmAguardando;

implementation

{$R *.dfm}

procedure TFrmAguardando.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
end;

end.
