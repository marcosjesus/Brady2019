unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, QRExport, QRXMLSFilt, QRWebFilt, QRPDFFilt;

type
  TForm1 = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    QRExcelFilter1: TQRExcelFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRCSVFilter1: TQRCSVFilter;
    QRTextFilter1: TQRTextFilter;
    QRXMLSFilter2: TQRXMLSFilter;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses repunit, unireport, qrprntr, qrprev;
{$R *.dfm}

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
     reportfrm.QuickRep1.Preview;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  apdf : TQRPDFDocumentfilter;
begin
     apdf := TQRPDFDocumentfilter.Create('reportexp.pdf');
     reportfrm.QuickRep1.ExportToFilter(apdf);
     apdf.Free;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
var
   ascf : TQRCommaSeparatedFilter;
begin
     ascf := TQRCommaSeparatedFilter.Create('asciireport.csv');
     reportfrm.QuickRep1.ExportToFilter(ascf);
     ascf.Free;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
var
  ahtml : TQRGHTMLDocumentfilter;
begin
     ahtml := TQRGHTMLDocumentfilter.Create('tib-test-Unicode.html');
     ahtml.TextEncoding := UnicodeEncoding;
     reportfrm.QuickRep1.ExportToFilter(ahtml);
     ahtml.Free;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
     reportfrm.QRImage1.Enabled := false;
     reportfrm.QuickRep1.PreviewXML;
     reportfrm.QRImage1.Enabled := true;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
begin
     unirep.QuickRep1.Preview;
end;

end.
