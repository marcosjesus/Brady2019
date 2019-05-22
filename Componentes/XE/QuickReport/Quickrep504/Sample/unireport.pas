unit unireport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, QuickRpt, QRCtrls, ExtCtrls, DBTables, QRAbsDatas, qrprntr;

type
  TUnirep = class(TForm)
    QuickRep1: TQuickRep;
    QRLoopBand1: TQRLoopBand;
    QRLabel1: TQRLabel;
    TitleBand1: TQRBand;
    QRLabel2: TQRLabel;
    SetupDialog1: TPrinterSetupDialog;
    procedure QRLoopBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRep1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRep1StandPrevEvent(Sender: TObject;
      eventType: TStandPrevEventType; contName: string; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Unirep: TUnirep;
  tmpl : TStringlist;
  enc : TQRTextEncoding;
  rec : integer;

implementation
uses main, printers;

{$R *.dfm}

procedure TUnirep.QRLoopBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     qrlabel1.Caption := tmpl[rec];
     inc(rec);
end;

procedure TUnirep.QuickRep1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
   enc := TQRTextEncoding.Create;
   tmpl := TStringlist.Create;
   tmpl.LoadFromFile(adir + '/Chinese-text.txt', enc.UTF8);
   qrloopband1.PrintCount := tmpl.Count;
   rec := 0;

end;

procedure TUnirep.QuickRep1StandPrevEvent(Sender: TObject;
  eventType: TStandPrevEventType; contName: string; var Handled: Boolean);
begin
     if eventtype = spPrintSetup  then
     begin
         if setupdialog1.Execute then
           QuickRep1.printersettings.PrinterIndex := printer.PrinterIndex;
         handled := true;
     end;

end;

end.
