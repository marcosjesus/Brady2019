unit QRPRSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TPRSelect = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ComboBox1: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
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
    function GetSettings : boolean;
  public
    SelectedPrinter : integer;
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
  PRSelect: TPRSelect;

implementation
uses printers, winspool;
{$R *.dfm}

procedure TPRSelect.ComboBox1Click(Sender: TObject);
var
    k : integer;
begin
      SelectedPrinter := printer.PrinterIndex;
      for k := 0 to printer.printers.Count - 1 do
         if printer.printers[k]=combobox1.text then
                  SelectedPrinter := k;
end;

procedure TPRSelect.FormCreate(Sender: TObject);
begin
     combobox1.Items.assign(printer.Printers);
     selectedPrinter := printer.PrinterIndex;
end;

procedure TPRSelect.SetOrientation( value : TPrinterOrientation );
begin
     if value = poPortrait then
         FOrientation := 0
     else
        FOrientation := 1;

end;
function TPRSelect.GetOrientation : TPrinterOrientation;
begin
      if FOrientation = 0 then
         result := poPortrait
      else
         result := poLandscape;
end;

 function TPRSelect.GetSettings : boolean;
 var
     tempInt : integer; // for debug display
     qDeviceMode : THandle;
begin
       printer.PrinterIndex := SelectedPrinter;
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

procedure TPRSelect.SpeedButton1Click(Sender: TObject);
begin
      SelectedPrinter := printer.PrinterIndex;
      close;
end;

procedure TPRSelect.SpeedButton2Click(Sender: TObject);
begin
     close;
end;

end.
