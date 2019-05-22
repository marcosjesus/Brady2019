unit biotest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, QRCtrls, QuickRpt, ExtCtrls;

type
  TBiorep = class(TForm)
    QuickRep1: TQuickRep;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRExpr1: TQRExpr;
    Query1: TQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Biorep: TBiorep;

implementation

{$R *.dfm}

end.
