unit QRSearchDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, qr5const;

type
  TSearchDlg = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cancel : boolean;
    procedure GetText( var atext : string);
    function GetCase : boolean;
  end;

var
  SearchDlg: TSearchDlg;

implementation

{$R *.dfm}

procedure TSearchDlg.FormCreate(Sender: TObject);
begin
      // set captions
      label1.Caption := sqrSearchText;
      checkBox1.Caption := sqrMatchCase;
      speedButton2.Caption := sqrSearchButtonCaption;
      speedButton1.Caption := sqrCancel;
      caption := sqrSearchDialogCaption;
end;

procedure TSearchDlg.GetText( var atext : string);
begin
    atext := edit1.text;
end;

function TSearchDlg.GetCase : boolean;
begin
   result := self.CheckBox1.Checked;
end;

procedure TSearchDlg.SpeedButton1Click(Sender: TObject);
begin
     cancel := true;
     close;
end;

procedure TSearchDlg.SpeedButton2Click(Sender: TObject);
begin
     cancel := false;
     close;

end;

end.
