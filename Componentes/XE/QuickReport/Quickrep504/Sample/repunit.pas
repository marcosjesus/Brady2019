unit repunit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls;

type
  TReportfrm = class(TForm)
    QuickRep1: TQuickRep;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRShape1: TQRShape;
    PageHeaderBand1: TQRBand;
    QRImage1: TQRImage;
    QRMemo1: TQRMemo;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRSysData1: TQRSysData;
    SetupDialog1: TPrinterSetupDialog;
    Open1: TOpenDialog;
    procedure QuickRep1NeedData(Sender: TObject; var MoreData: Boolean);
    procedure QuickRep1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRep1StandPrevEvent(Sender: TObject;
      eventType: TStandPrevEventType; contName: string; var Handled: Boolean);
    procedure QuickRep1PrevXEvent(Sender: TObject; eventNum: TPrevEventType;
      cName, CText: string; rec: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Reportfrm: TReportfrm;
  rec : integer;

implementation
uses printers, winspool, qrprntr, qrpdffilt;
{$R *.dfm}

procedure TReportfrm.QuickRep1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
   rec := 0;
end;

procedure TReportfrm.QuickRep1NeedData(Sender: TObject; var MoreData: Boolean);
begin
     qrlabel1.caption := 'Record number : ' + inttostr(rec) + '  ' + chr($9034 + rec);
     inc(rec);
     moredata := rec < 20;
end;

procedure TReportfrm.QuickRep1PrevXEvent(Sender: TObject; eventNum: TPrevEventType;
                          cName, CText: string; rec: Integer);
var
   aPDF : TQRPDFDocumentFilter;
begin
      if eventnum= etSaveButton then
      begin
          apdf := TQRPDFDocumentfilter.Create('savedReport.pdf');
          QuickRep1.exporttofilter(apdf);
          apdf.Free;
          showmessage( 'PDF created');
      end;
end;

procedure TReportfrm.QuickRep1StandPrevEvent(Sender: TObject;
  eventType: TStandPrevEventType; contName: string; var Handled: Boolean);
var
    qDeviceMode : THandle;
    FPrinterIndex : integer;
    FOwnerHandle : system.Cardinal;
    k : TQRBin;
    pHandle : system.cardinal;
    devName, fDriver, FPort : pchar;
    inDevMode, outDevMode : TDeviceMode;
    pinDev, poutDev : pdevmode;
    procedure GPrinter;
    var
     PDevMode : ^TDevMode;
     devSize : integer;
    begin
      Application.ProcessMessages;
      Printer.GetPrinter(devname, FDriver, FPort, qDeviceMode);
      Printer.GetPrinter(devname, FDriver, FPort, qDeviceMode);
      PDevMode := GlobalLock( qDeviceMode );
      devSize := PDevMode.dmSize + PDevMode.dmDriverExtra ;
      GetMem( poutdev, devSize );
      Move( PDevMode^, poutdev^, devSize );
      poutdev := GlobalLock(qDeviceMode);
    end;

begin
     exit;

     if (eventtype = spPrintSetup) then
     begin
        if not setupdialog1.Execute then exit;
        QuickRep1.printersettings.PrinterIndex := printer.PrinterIndex;
        handled := true;
        // if you allow the user to change settings, the printer
        // must be interrogated for the settings
        devName := allocmem( 2048 );
        fDriver := allocmem( 2048 );
        FPort := allocmem( 2048 );
        GPrinter;
        quickrep1.printersettings.duplex :=  poutdev^.dmDuplex<>1;
        if poutdev^.dmDuplex>1 then
        begin
            quickrep1.printersettings.UseExtendedDuplex := true;
            quickrep1.printersettings.ExtendedDuplex :=  poutdev^.dmDuplex;
        end;
        quickrep1.printersettings.OutputBin := Auto;
        for k := First to Last do
          if (cQRBinTranslate[k] = poutdev^.dmDefaultSource)
             or (cQRBinTranslate[k] = (poutdev^.dmDefaultSource-255)) then
          begin
            quickrep1.printersettings.OutputBin := k;
            break;
          end;
        quickrep1.printersettings.copies :=  poutdev^.dmcopies;
        quickrep1.printersettings.collate :=  poutdev^.dmcollate;
        {
        quickrep1.printersettings.Orientation := outdevMode.dmOrientation;
        quickrep1.printersettings.Copies := outdevMode.dmCopies;
        quickrep1.printersettings.paperSize := outdevMode.dmpaperSize;
        quickrep1.printersettings.Paperwidth := outdevMode.dmpaperWidth;
        quickrep1.printersettings.Paperlength := outdevMode.dmpaperLength;
        quickrep1.printersettings.Printquality := outdevMode.dmPrintquality;
        quickrep1.printersettings.ColorOption := outdevMode.dmColor;
        quickrep1.printersettings.DuplexCode :=  outdevMode.dmDuplex;
         }
        globalunlock(qDeviceMode);
        freemem( devname );
        freemem( fDriver );
        freemem( FPort );
     end;
end;


end.
