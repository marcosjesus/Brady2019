{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 4.0 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRLablEd - TQRLabel COMPONENT EDITOR                    ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.qusoft.com                              ::
  ::                                                         ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

{$I QRDEFS.INC}

unit QRLablEd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Mask, QuickRpt;

type
  TQRLabelEditorForm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Value: TEdit;
    AutoSize: TCheckBox;
    Stretch: TCheckBox;
    FontDialog1: TFontDialog;
    OKBtn: TButton;
    Button4: TButton;
    Transparent: TCheckBox;
    Width: TMaskEdit;
    Height: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
  private
  public
  end;

  TQRLabelEditor = class(TQRPrintableEditor)
  protected
    function GetColor : TColor; override;
    function GetFont : TFont; override;
    function GetPrintableClass : TQRPrintableClass; override;
    function GetValue : string; override;
    function GetGlyphResName : string; override;
    function GetControlName : string; override;
{$ifndef QRSTANDARD}
    function GetAlignment : TAlignment; override;
    procedure SetAlignment(Value : TAlignment); override;
{$endif}
    procedure SetColor(Value : TColor); override;
    procedure SetFont(Value : TFont); override;
    procedure SetValue(Value : string); override;
  public
    function ShowEditor : boolean; override;
  end;

implementation

{$R *.DFM}

uses
  QRCtrls;

function TQRLabelEditor.GetColor : TColor;
begin
  Result := TQRCustomLabel(Control).Color;
end;

function TQRLabelEditor.GetFont : TFont;
begin
  Result := TQRCustomLabel(Control).Font;
end;

function TQRLabelEditor.GetPrintableClass : TQRPrintableClass;
begin
  Result := TQRLabel;
end;

function TQRLabelEditor.GetGlyphResName : string;
begin
  Result := 'QRLABEL';
end;

function TQRLabelEditor.GetValue : string;
begin
  Result := TQRCustomLabel(Control).Caption;
end;

function TQRLabelEditor.GetControlName : string;
begin
  Result := 'Text Control'; { <-- Do not localize }
end;

procedure TQRLabelEditor.SetColor(Value : TColor);
begin
  TQRCustomLabel(Control).Color := Value;
end;

procedure TQRLabelEditor.SetFont(Value : TFont);
begin
  TQRCustomLabel(Control).Font := Value;
end;

procedure TQRLabelEditor.SetValue(Value : string);
begin
  TQRCustomLabel(Control).Caption := Value;
end;

{$ifndef QRSTANDARD}
function TQRLabelEditor.GetAlignment : TAlignment;
begin
  Result := TQRCustomLabel(Control).Alignment;
end;

procedure TQRLabelEditor.SetAlignment(Value : TAlignment);
begin
  TQRCustomLabel(Control).Alignment := Value;
end;
{$endif}

function TQRLabelEditor.ShowEditor;
begin
  with TQRLabelEditorForm.Create(Application) do
  try
    Value.Text := Self.Value;
    Width.Text := FloatToStr(Control.Size.Width);
    Height.Text := FloatToStr(Control.Size.Height);
    AutoSize.Checked := TQRCustomLabel(Control).AutoSize;
    Stretch.Checked := TQRCustomLabel(Control).AutoStretch;
    Transparent.Checked := TQRLabel(Control).Transparent;
    ShowModal;
    if ModalResult = mrOk then
    begin
      Self.Value := Value.Text;
      Control.Size.Width := StrToFloat(Width.Text);
      Control.Size.Height := StrToFloat(Height.Text);
      TQRCustomLabel(Control).AutoSize := AutoSize.Checked;
      TQRCustomLabel(Control).AutoStretch := Stretch.Checked;
      TQRLabel(Control).Transparent := Transparent.Checked;
    end;
    Result := ModalResult = mrOK;
  finally
    Free;
  end;
end;

end.


