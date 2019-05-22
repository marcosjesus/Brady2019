unit qrprnsu2;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  printers, winspool, qrprselect;

type

  TQR5PrintDialog = class(TComponent)

   private
    FFromPage: Integer;
    FToPage: Integer;
    FCollate: Integer;
    FOptions: TPrintDialogOptions;
    FPrintToFile: Boolean;
    FPrintRange: TPrintRange;
    FMinPage: Integer;
    FMaxPage: Integer;
    FCopies: Integer;
    FPrintQuality: Integer;
    FColorOption: Integer;
    FOutputBin: Integer;
    FPaperSize: Integer;
    FDuplex : boolean;
    FPaperwidth : extended;
    FPaperlength : extended;
    FdmFields : Cardinal;
    FOrientation : integer;
    FDuplexCode : integer;
    // new fields
    FPrinterIndex : integer;
    FOwnerHandle : system.Cardinal;
    rc : integer;
    pHandle : system.cardinal;
    devName, fDriver, FPort : pWidechar;
    inDevMode, outDevMode : TDeviceMode;
    pinDev, poutDev : pdevmode;
    procedure SetOrientation( value : TPrinterOrientation );
    function GetOrientation : TPrinterOrientation;
   public
    constructor Create( aowner : TComponent); override;
    destructor Destroy; override;
    function Execute : boolean;
   published
    property Duplex : boolean read FDuplex write FDuplex default false;
    property PrinterIndex : Integer read FPrinterIndex write FPrinterIndex default 0;
    property DuplexCode : Integer read FDuplexCode write FDuplexCode default 0;
    property OutputBin: Integer read FOutputBin write FOutputBin default 0;
    property PaperSize: Integer read FPaperSize write FPaperSize default 0;
    property Paperwidth : extended read FPaperwidth write FPaperwidth;
    property Paperlength : extended read FPaperlength write FPaperlength;
    property Collate: integer read FCollate write FCollate default 0;
    property Copies: Integer read FCopies write FCopies default 1;
    property FromPage: Integer read FFromPage write FFromPage default 0;
    property PrintQuality: Integer read FPrintQuality write FPrintQuality default 0;
    property ColorOption: Integer read FColorOption write FColorOption default 0;
    property MinPage: Integer read FMinPage write FMinPage default 0;
    property MaxPage: Integer read FMaxPage write FMaxPage default 0;
    property Options: TPrintDialogOptions read FOptions write FOptions default [];
    property PrintToFile: Boolean read FPrintToFile write FPrintToFile default False;
    property PrintRange: TPrintRange read FPrintRange write FPrintRange default prAllPages;
    property ToPage: Integer read FToPage write FToPage default 0;
    property Orientation: TPrinterOrientation read GetOrientation write SetOrientation;

  end;
  var
    prseldlg : TPRSelect;

implementation

constructor TQR5PrintDialog.Create( aowner : TComponent);
begin
    inherited Create(aowner);
    devName := allocmem( 2048 );
    fDriver := allocmem( 2048 );
    FPort := allocmem( 2048 );
    prseldlg := TPRSelect.Create(self);
end;

destructor TQR5PrintDialog.Destroy;
begin
     freemem( devname );
     freemem( fDriver );
     freemem( FPort );
     prseldlg.Free;
     inherited;
end;

procedure TQR5PrintDialog.SetOrientation( value : TPrinterOrientation );
begin
     if value = poPortrait then
         FOrientation := 0
     else
        FOrientation := 1;

end;
function TQR5PrintDialog.GetOrientation : TPrinterOrientation;
begin
      if FOrientation = 0 then
         result := poPortrait
      else
         result := poLandscape;
end;

function TQR5PrintDialog.Execute : boolean;
var
     tempInt : integer; // for debug display
     qDeviceMode : THandle;
begin
       FPrinterIndex := printer.PrinterIndex;
       prseldlg.ShowModal;
       printer.PrinterIndex := prseldlg.SelectedPrinter;
       FPrinterIndex := printer.PrinterIndex;
       Printer.GetPrinter(devName, FDriver, FPort, qDeviceMode);
       if qDeviceMode = 0 then
            Printer.GetPrinter(devName, FDriver, FPort, qDeviceMode);
       //OpenPrinter (devName, pHandle, pDefault);
       OpenPrinter(devName, pHandle, nil);
       poutDev := pinDev;
       FOwnerHandle := application.handle;
       rc := DocumentProperties( FOwnerHandle, pHandle, devName, outdevMode, indevmode,
                                 DM_OUT_BUFFER or DM_IN_BUFFER or DM_IN_PROMPT );
       if rc < 0 then
       begin
            result := false;
            exit;
       end;

       FdmFields := outdevMode.dmFields;
       tempInt := outdevMode.dmDefaultSource;
       FOutputBin := tempInt;
       FpaperSize := outdevMode.dmpaperSize;
       FPaperwidth := outdevMode.dmpaperWidth;
       FPaperlength := outdevMode.dmpaperLength;
       FOrientation := outdevMode.dmOrientation;
       FPrintquality := outdevMode.dmPrintquality;
       FColorOption := outdevMode.dmColor;
       FDuplexCode :=  outdevMode.dmDuplex;
       FDuplex :=  outdevMode.dmDuplex <> 1;
       FCollate := outdevMode.dmCollate;
       FOrientation := outdevMode.dmOrientation;
       FCopies := outdevMode.dmCopies;
       ClosePrinter( pHandle);
       result := true;
end;

end.
