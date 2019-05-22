unit qrFramelines;
{====================================================================
  Class TQRFrameline

  Placed on a band, these controls make vertical lines
  at the XPos location.

  (c) 2005 QBS Software
  DLM - march 2005 : Thanks to Mark Yang for the notion of a frame grid.
====================================================================}

interface

uses Classes, Controls, StdCtrls, SysUtils, Graphics, Buttons,
      ComCtrls, QuickRpt, Qr5Const;

type

  TQRFrameline = class(TQRPrintable)
  protected
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
  public
    constructor Create( aOwner : TComponent); override;
  published
    property Left;

  end;

  procedure  Register;

implementation

procedure Register;
begin
    RegisterComponents( 'QReport', [TQRFrameline] );
end;


constructor TQRFrameline.Create( aOwner : TComponent);
begin
    // we don't do anything but maybe in a later version
    inherited Create( aOwner);
end;

procedure TQRFrameline.Print(OfsX, OfsY : integer);
begin
   // do nothing. Painted by TQRFrame.PaintIt
end;

procedure TQRFrameline.Paint;
begin
    inherited paint;
    canvas.MoveTo(Width div 2,0);
    canvas.LineTo(Width div 2,Height);
end;

end.
