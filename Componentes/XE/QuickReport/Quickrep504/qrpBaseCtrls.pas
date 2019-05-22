{$I QRPP.INC}
unit qrpBaseCtrls;

interface

uses
  Classes,
  QRCtrls, QRPrntr, Quickrpt;

type
  TLabelSettings = class(TPersistent)
  private
    fFirstLabel             : Longint;
    fLabelCount             : Longint;
  protected
  public
  published
    property FirstLabel: Longint Read fFirstLabel Write fFirstLabel;
    property LabelCount: Longint Read fLabelCount Write fLabelCount;
  end;

  TQRPQuickrep = class(TQuickRep)
  private
    FLabelSettings               : TLabelSettings;
    FPrepareAutomatically        : Boolean;
    BandsHidden                  : Boolean;
  protected
    ReportPrintPrepared          : Boolean;
    SkipLabelsBand1              : TQRCustomBand;
    SkipLabelsBand2              : TQRChildband;
    SkipLabelsBand3              : TQRChildband;
  public
    DetailBand                   : TQRCustomBand;
    TotalPageCount               : Integer;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Print;
    procedure Preview;
    procedure Prepare;
    procedure PrintBackground;
    procedure ExportToFilter(AFilter: TQRExportFilter);
    procedure PreviewModal;
    procedure PreviewModeless;

    function PrepareReportPrint: Boolean; virtual;
    procedure DoneReportPrint; virtual;
  published
    property LabelSettings: TLabelSettings Read FLabelSettings Write FLabelSettings;
    property PrepareAutomatically: Boolean Read FPrepareAutomatically Write FPrepareAutomatically;
  end;

implementation

uses
  Controls, Dialogs, Forms, QRPCtrls;


constructor TQRPQuickrep.Create(AOwner : TComponent);
begin
  Inherited Create(AOwner);
  FLabelSettings:=TLabelSettings.Create;
end;

destructor TQRPQuickrep.Destroy;
begin
  FLabelSettings.Free;
  Inherited Destroy;
end;

procedure TQRPQuickrep.Print;
begin
  If PrepareReportPrint Then
    begin
      Inherited Print;
      DoneReportPrint;
    end;
end;

procedure TQRPQuickrep.Preview;
begin
  If PrepareReportPrint Then
    begin
      Inherited Preview;
      DoneReportPrint;
    end;
end;

procedure TQRPQuickrep.Prepare;
begin
  If PrepareReportPrint Then
    begin
      Inherited Prepare;
    end;
end;

function TQRPQuickrep.PrepareReportPrint: Boolean;
var
  DetailBand: TQRCustomBand;
  RowSpaceBand: TQRCustomBand;
  SkipLabels: Integer;
  ColumnLabels: Integer;
begin
  Result:=True;

  If ReportPrintPrepared Then Exit;
  ReportPrintPrepared:=True;

  {---  create temporary label skip bands ---}
  DetailBand:=TQRCustomBand(Owner.FindComponent('LabelBand'));
  If DetailBand=NIL Then DetailBand:=TQRCustomBand(Owner.FindComponent('DetailBand'));

  {$IFDEF QR3}
  If (DetailBand is TQRLoopband) and (DetailBand.Name='LabelBand') Then
    TQRLoopband(DetailBand).PrintCount:=LabelSettings.LabelCount;
  {$ENDIF}

  If (Labelsettings.FirstLabel>1) and (DetailBand<>NIL) Then
    begin
      SkipLabels:=Labelsettings.FirstLabel-1;
      {$IFDEF QR3}
      If DetailBand is TQRLoopband Then
        begin
          SkipLabelsBand1:=TQRLoopband.Create(Owner);
          SkipLabelsBand1.Parent:=Self;
          TQRLoopband(SkipLabelsBand1).Master:=Self;
          TQRLoopband(SkipLabelsBand1).PrintCount:=1;
          TQRLoopband(Detailband).Master:=SkiplabelsBand1;
        end
      else
      {$ENDIF}
        begin
          SkipLabelsBand1:=TQRGroup.Create(Owner);
        end;

      SkipLabelsBand2:=TQRPChildband.Create(Owner);
      SkipLabelsBand3:=TQRPChildband.Create(Owner);
      SkipLabelsBand1.Parent:=Self;
      SkipLabelsBand2.Parent:=Self;
      SkipLabelsBand3.Parent:=Self;
      SkipLabelsBand1.Height:=0;
      SkipLabelsBand2.Height:=0;
      SkipLabelsBand2.ParentBand:=SkipLabelsBand1;
      SkipLabelsBand3.ParentBand:=SkipLabelsBand2;

      RowSpaceBand:=TQRPChildBand(Owner.FindComponent('RowSpace'));
      If DetailBand<>NIL Then
        begin
          If RowSpaceBand<>NIL Then
            ColumnLabels:=Round((Page.Length-Page.TopMargin-Page.BottomMargin+RowSpaceBand.Size.Height)
                                /(DetailBand.Size.Height+RowSpaceband.Size.Height))
          else
            ColumnLabels:=Round((Page.Length-Page.TopMargin-Page.BottomMargin)
                                /DetailBand.Size.Height);

          If SkipLabels>=ColumnLabels Then
            begin
              While SkipLabels>=ColumnLabels Do SkipLabels:=SkipLabels-ColumnLabels;
              SkipLabelsBand2.ForceNewColumn:=True;
              SkipLabelsBand3.ForceNewColumn:=True;
            end;
          If RowSpaceBand<>NIL Then
            SkipLabelsBand3.Height:=(DetailBand.Height+RowSpaceBand.Height)*SkipLabels
          else
            SkipLabelsBand3.Height:=DetailBand.Height*SkipLabels;
        end;
    end;
  If PrepareAutomatically Then
    begin
      BandsHidden:=HideBands;
      Hidebands:=True;
      try
        Screen.Cursor:=crHourGlass;
        Inherited Prepare;
      finally
        Screen.Cursor:=crDefault;
      end;
      TotalPageCount:=QRPrinter.PageCount;
    end;
end;

procedure TQRPQuickrep.DoneReportPrint;
begin
  If Not ReportPrintPrepared Then Exit;
  ReportPrintPrepared:=False;
  SkipLabelsBand1.Free;
  SkipLabelsBand2.Free;
  SkipLabelsBand3.Free;
  SkipLabelsBand1:=NIL;
  SkipLabelsBand2:=NIL;
  SkipLabelsBand3:=NIL;
  DetailBand:=NIL;
  TotalPageCount:=0;
  If PrepareAutomatically Then Hidebands:=BandsHidden;
end;

procedure TQRPQuickrep.PrintBackground;
begin
  If PrepareReportPrint Then
    begin
      Inherited PrintBackground;
      DoneReportPrint;
    end;
end;

procedure TQRPQuickrep.ExportToFilter(AFilter: TQRExportFilter);
begin
  If PrepareReportPrint Then
    begin
      Inherited ExportToFilter(AFilter);
      DoneReportPrint;
    end;
end;

procedure TQRPQuickrep.PreviewModal;
begin
  If PrepareReportPrint Then
    begin
      {$IFDEF QR3}
      Inherited PreviewModal;
      {$ELSE}
      Inherited Preview;
      {$ENDIF}
      DoneReportPrint;
    end;
end;

procedure TQRPQuickrep.PreviewModeless;
begin
  If PrepareReportPrint Then
    begin
      {$IFDEF QR3}
      Inherited PreviewModeless;
      {$ELSE}
      Inherited Preview;
      {$ENDIF}
      DoneReportPrint;
    end;
end;

end.
