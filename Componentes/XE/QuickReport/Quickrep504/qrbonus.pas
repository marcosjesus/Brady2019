{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 4.0 for Delphi                              ::
  ::                                                         ::
  :: QRBONUS - Bonus classes                                 ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.quickreport.co.uk                       ::
  ::                                                         ::
  :: 02/04/07 updated for QR4                                ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

unit QRBonus;

interface

uses
  Windows, Forms, QRPrntr, quickrpt;

type
  { TQRPrintJob
    This class works as a wrapper around TQRPrinter, making your life easier
    if you want to use this independently of the rest of QuickReport.
    Override the CreateOutput method to create the actual output and call the
    AQRPrinter.XPos, YPos, XSize and YSize to convert any coordinates from 0.1mm
    to actual device coordinates. 

 //****** Sample code ******
 //  1. Declare your own descendant class
 type
  TPPreview = class(TQRPrintJob)
  protected
    procedure CreateOutput; override;
  end;

 //  2. Create  procedure CreateOutPut -
procedure TPPreview.CreateOutput;
var
  j: Integer;
begin
  LineNum := 0;
  with qrPrn do begin
    BeginDoc;
    NewPage;
    NewLine(2);
    PPrint(100, 'Start', 'L');
    for j := 1 to 20 do begin
      NewLine(2);
      PPrint(400, 'printed at 400', 'C');
      PPrint(1100, 'printed at 1100', 'R');
    end;
    NewPage;
    LineNum := 0;
    NewLine(2);
    PPrint(100, 'Start', 'L');
    for j := 1 to 20 do begin
      NewLine(2);
      PPrint(400, 'printed at 400', 'C');
      PPrint(1100, 'printed at 400', 'R');
    end;
    EndDoc;
  end;
end;

  // 4. To call the print and preview methods -
procedure TForm1.bImpClick(Sender: TObject);
var
  PPreview: TPPreview;
begin
  PPreview := TPPreview.Create;
  try
    PPreview.Preview; // or Print
  finally
    PPreview.Free;
  end;
end;

// ********* End of sample code **************
    }

  TQRPrintJob = class
    qrPrn: TQRPrinter;
    LineNum: Single;
  protected
    procedure CreateOutput; virtual;
  public
    // qr407
    parentReport : TQuickrep;
    constructor Create;
    destructor Destroy; override;
    procedure Print;
    procedure Preview;
  end;

implementation

procedure TQRPrintJob.CreateOutput;
begin
end;

constructor TQRPrintJob.Create;
begin
  inherited;
  parentReport := TQuickrep.Create(nil);
  qrPrn := TQRPrinter.Create(parentreport);
end;

destructor TQRPrintJob.Destroy;
begin
  parentReport.Free;
  qrPrn.Free;
  inherited Destroy;
end;

procedure TQRPrintJob.Preview;
begin
  with qrPrn do begin
    CleanUp;
    Destination := qrdMetafile;
//    OnGenerateToPrinter := Self.Print;
    Preview;
    Application.ProcessMessages;
    CreateOutput;
    repeat
      Application.ProcessMessages
    until not qrPrn.ShowingPreview;
  end;
end;

procedure TQRPrintJob.Print;
begin
  with qrPrn do begin
    CleanUp;
    Destination := qrdPrinter;
    CreateOutput;
  end;
end;

end.
