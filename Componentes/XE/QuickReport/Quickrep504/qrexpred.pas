{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 3.5 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRExprEd - TQRExpr COMPONENT EDITOR                     ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.qusoft.no                               ::
  ::                                                         ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

unit QRExprEd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Mask, QuickRpt, QRLablEd, Buttons;

type
  TQRExprEditorForm = class(TForm)
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
    ShowExprBuilder: TSpeedButton;
    Label4: TLabel;
    Mask: TComboBox;
    procedure ShowExprBuilderClick(Sender: TObject);
  private
    DSForm : TCustomForm;
  public
  end;

  TQRExprEditor = class(TQRLabelEditor)
  protected
    function GetPrintableClass : TQRPrintableClass; override;
    function GetValue : string; override;
    function GetGlyphResName : string; override;
    function GetControlName : string; override;
    procedure SetValue(Value : string); override;
  public
    function ShowEditor : boolean; override;
  end;

implementation

{$R *.DFM}

uses
  QRCtrls, QRExpBld;

function TQRExprEditor.GetPrintableClass : TQRPrintableClass;
begin
  Result := TQRExpr;
end;

function TQRExprEditor.GetGlyphResName : string;
begin
  Result := 'QREXPR';
end;

function TQRExprEditor.GetValue : string;
begin
  Result := TQRExpr(Control).Expression;
end;

function TQRExprEditor.GetControlName : string;
begin
  Result := 'Expression Control'; { <-- do not resource }
end;

procedure TQRExprEditor.SetValue(Value : string);
begin
  TQRExpr(Control).Expression := Value;
end;

function TQRExprEditor.ShowEditor;
var
  acontrol : TControl;
begin
  with TQRExprEditorForm.Create(Application) do
  try
    Value.Text := Self.Value;
    Width.Text := FloatToStr(Control.Size.Width);
    Height.Text := FloatToStr(Control.Size.Height);
    AutoSize.Checked := TQRExpr(Control).AutoSize;
    Stretch.Checked := TQRExpr(Control).AutoStretch;
    Transparent.Checked := TQRExpr(Control).Transparent;
    Mask.Text := TQRExpr(Control).Mask;
    AControl := Control.Parent;
    while (not (AControl is TCustomForm)) and (AControl <> nil) do
      AControl := AControl.Parent;
    if AControl is TCustomForm then
      DSForm := TCustomForm(AControl)
    else
      DSFOrm := nil;

    ShowModal;
    if ModalResult = mrOk then
    begin
      Self.Value := Value.Text;
      Control.Size.Width := StrToFloat(Width.Text);
      Control.Size.Height := StrToFloat(Height.Text);
      TQRExpr(Control).AutoSize := AutoSize.Checked;
      TQRExpr(Control).AutoStretch := Stretch.Checked;
      TQRExpr(Control).Transparent := Transparent.Checked;
      TQRExpr(Control).Mask := Mask.Text;
    end;
    Result := ModalResult = mrOK;
  finally
    Free;
  end;
end;

procedure TQRExprEditorForm.ShowExprBuilderClick(Sender: TObject);
var
  AValue : string;
begin
  AValue := Value.Text;
  if GetExpression('', AValue, DSForm, nil, nil) then
    Value.Text := AValue;
end;

end.
