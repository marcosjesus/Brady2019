unit QRXSearchFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TQRXSearchDlg = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cancel : boolean;
    procedure GetText( var atext : string);
    function GetCase : boolean;
  end;

var
  QRXSearchDlg: TQRXSearchDlg;

implementation

{$R *.dfm}

procedure TQRXSearchDlg.GetText( var atext : string);
begin
    atext := edit1.text;
end;

function TQRXSearchDlg.GetCase : boolean;
begin
   result := self.CheckBox1.Checked;
end;

procedure TQRXSearchDlg.SpeedButton1Click(Sender: TObject);
begin
     cancel := true;
     close;
end;

procedure TQRXSearchDlg.SpeedButton2Click(Sender: TObject);
begin
     cancel := false;
     close;

end;

end.
