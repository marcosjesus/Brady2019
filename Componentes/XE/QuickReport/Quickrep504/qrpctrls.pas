{$I QRPP.INC}

{$B-}
{$A-}

unit qrpctrls;

interface

uses
  ComCtrls,
  Controls, SysUtils, Forms, Grids,
  DBGrids, WinProcs, WinTypes, Classes,
  QuickRpt, QRCtrls, CSProp, Graphics, ExtCtrls,
  {$IFDEF QR3} QRExpr, {$ENDIF}
  {$IFDEF QREXPORTS2} grImgCtrl, {$ENDIF}
  QRPExpr, qrpBaseCtrls, QRPrntr;

const
  CellBorderX = 5;
  CellBorderY = 3;

type
  TQRPFrame = class(TQRFrame)
  end;

  {--- printing external graphic files from string field ---}
  TQRPDBImage = class(TQRDBImage)
  private
    FFixBottomPosition       : Boolean;
    FStretchHeightWithBand   : Boolean;
  protected
    procedure Print(OfsX, OfsY : integer); override;
  public
    procedure LoadPicture;
  published
    property FixBottomPosition: Boolean Read FFixBottomPosition
                                        Write FFixBottomPosition;
    property StretchHeightWithBand: Boolean Read FStretchHeightWithBand
                                            write FStretchHeightWithBand;
  end;

  {--- rotated text ---}
  TQRPLabel = class(TQRLabel)
  private
    FDegree                  : Word;
    FFixBottomPosition       : Boolean;
    FStretchHeightWithBand   : Boolean;
  protected
    procedure SetDegree(Value: Word);
    procedure FormatLines; override;
  public
    procedure Print(OfsX, OfsY: Integer); override;
    procedure Paint; override;
  published
    property Degree : Word Read FDegree Write SetDegree;
    property FixBottomPosition: Boolean Read FFixBottomPosition
                                        Write FFixBottomPosition;
    property StretchHeightWithBand: Boolean Read FStretchHeightWithBand
                                            write FStretchHeightWithBand;
  end;

  {--- suppressing repeated values, suppress zero fields, reprint on new page or group ---}
  TQRPDBText = class(TQRDBText)
  private
    FOldOnPrint             : TQRLabelOnPrintEvent;
    FSuppressRepeatedValues : Boolean;
    FReprintOnNewPage       : Boolean;
    FReprintOnNewGroup      : Boolean;
    FBlankIfZero            : Boolean;
    FFixBottomPosition      : Boolean;
    FStretchHeightWithBand  : Boolean;
  protected
    procedure DBTextOnPrint(sender : TObject; var Value : String);
  public
    LastValue       : String;
    LastPage        : Integer;
    procedure Print(OfsX, OfsY: Integer); override;
    property OldOnPrint: TQRLabelOnPrintEvent Read FOldOnPrint Write FOldOnPrint;
  published
    property SuppressRepeatedValues: Boolean Read FSuppressRepeatedValues Write FSuppressRepeatedValues;
    property ReprintOnNewPage: Boolean Read FReprintOnNewPage Write FReprintOnNewPage;
    property ReprintOnNewGroup: Boolean Read FReprintOnNewGroup Write FReprintOnNewGroup;
    property BlankIfZero: Boolean Read FBlankIfZero Write FBlankIfZero;
    property FixBottomPosition: Boolean Read FFixBottomPosition
                                        Write FFixBottomPosition;
    property StretchHeightWithBand: Boolean Read FStretchHeightWithBand
                                            write FStretchHeightWithBand;
  end;

  {--- rotate ---}
  TQRPExpr = class(TQRExpr)
  private
    FDegree                  : Word;
    FFixBottomPosition       : Boolean;
    FStretchHeightWithBand   : Boolean;
  protected
    procedure SetDegree(Value: Word);
  public
    procedure Print(OfsX, OfsY: Integer); override;
    procedure Paint; override;
  published
    property Degree : Word Read FDegree Write SetDegree;
    property FixBottomPosition: Boolean Read FFixBottomPosition
                                        Write FFixBottomPosition;
    property StretchHeightWithBand: Boolean Read FStretchHeightWithBand
                                            write FStretchHeightWithBand;
  end;

  {--- expressions ---}
  TQRPMemo = class(TQRMemo)
  private
    FFixBottomPosition       : Boolean;
    FStretchHeightWithBand   : Boolean;
  protected
  public
    procedure Print(OfsX, OfsY: Integer); override;
  published
    property FixBottomPosition: Boolean Read FFixBottomPosition
                                        Write FFixBottomPosition;
    property StretchHeightWithBand: Boolean Read FStretchHeightWithBand
                                            write FStretchHeightWithBand;
  end;

  {--- expressions ---}
  TQRPRichtext = class(TQRRichtext)
  private
    FFixBottomPosition       : Boolean;
    FStretchHeightWithBand   : Boolean;
  protected
  public
    procedure Print(OfsX, OfsY: Integer); override;
  published
    property FixBottomPosition: Boolean Read FFixBottomPosition
                                        Write FFixBottomPosition;
    property StretchHeightWithBand: Boolean Read FStretchHeightWithBand
                                            write FStretchHeightWithBand;
  end;

  {--- diagonal lines, left/right/bottom line --- }
  TQRPShapeType = (qrpsRectangle,qrpsCircle,qrpsVertLine,qrpsHorLine,
                   qrpsTopAndBottom,qrpsRightAndLeft,
                   qrpsDownLine, qrpsUpLine,
                   qrpsTriangle1,qrpsTriangle2,qrpsTriangle3,qrpsTriangle4);

  TQRPShape = class(TQRShape)
  private
    FQRPShape                : TQRPShapeType;
    FFixBottomPosition       : Boolean;
    FStretchHeightWithBand   : Boolean;
  protected
    procedure SetQRPShape(Value: TQRPShapeType);
  public
    procedure Print(OfsX, OfsY: Integer); override;
    procedure Paint; override;
  published
    property Shape: TQRPShapeType Read FQRPShape Write SetQRPShape;
    property FixBottomPosition: Boolean Read FFixBottomPosition
                                        Write FFixBottomPosition;
    property StretchHeightWithBand: Boolean Read FStretchHeightWithBand
                                            write FStretchHeightWithBand;
  end;

  TQRPCheckmarkType = (cmCross, cmHook, cmGlyph);

  TQRPCheckBox = class(TQRPrintable)
  private
    FFixBottomPosition       : Boolean;
    FStretchHeightWithBand   : Boolean;
    FBrush                   : TBrush;
    FPen                     : TPen;
    FCtl3d                   : Boolean;
    FChecked                 : Boolean;
    FCheckmarkDistance       : Word;
    FCheckmarkType           : TQRPCheckmarkType;
    FGlyphChecked            : TPicture;
    FGlyphUnchecked          : TPicture;
    procedure SetChecked(Value: Boolean);
    procedure SetBrush(Value: TBrush);
    procedure SetPen(Value: TPen);
    procedure SetCtl3d(Value: Boolean);
    procedure SetCheckmarkDistance(Value: Word);
    procedure SetCheckmarkType(Value: TQRPCheckmarkType);
    procedure SetGlyphChecked(Value: TPicture);
    procedure SetGlyphUnchecked(Value: TPicture);
  protected
    procedure StyleChanged(sender : TObject);
    procedure PictureChanged(Sender: TObject);
  public
    constructor Create(AOwner : TComponent); override;
    procedure Paint; override;
    procedure Print(OfsX, OfsY : Integer); override;
    destructor Destroy; override;
  published
    property GlyphChecked: TPicture read FGlyphChecked write SetGlyphChecked;
    property GlyphUnchecked: TPicture read FGlyphUnchecked write SetGlyphUnchecked;
    property CheckmarkType: TQRPCheckmarkType read FCheckmarkType write SetCheckmarkType;
    property CheckmarkDistance : Word read FCheckmarkDistance Write SetCheckmarkDistance;
    property Checked : Boolean read FChecked write SetChecked;
    property Brush : TBrush read FBrush write SetBrush;
    property Pen : TPen read FPen write Setpen;
    property Height default 17;
    property Width default 17;
    property Transparent;
    property Ctl3D: Boolean Read FCtl3d Write SetCtl3d;
    property FixBottomPosition: Boolean Read FFixBottomPosition
                                        Write FFixBottomPosition;
    property StretchHeightWithBand: Boolean Read FStretchHeightWithBand
                                            write FStretchHeightWithBand;
  end;

  TQRPExprCheckbox = class(TQRPCheckbox)
  private
    FExpression: String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure Print(OfsX, OfsY : integer); override;
  published
    property Expression: String Read FExpression Write FExpression;
  end;

  TVertAlignment = (vaNone, vaTop, vaCenter, vaBottom);
  THorizAlignment  = (haNone, haLeft, haCenter, haRight);

  TQRPGridCell = class
    Caption        : String;
    Font           : TFont;
    Brush          : TBrush;
    ParentFont     : Boolean;
    VertAlignment  : TVertAlignment;
    HorizAlignment : THorizAlignment;
    constructor Create;
    destructor Destroy; override;
  end;

  TQRPGrid = class(TQRPrintable)
  private
    FFixBottomPosition       : Boolean;
    FStretchHeightWithBand   : Boolean;
    FCellHorizAlignment: THorizAlignment;
    FCellVertAlignment : TVertAlignment;
    FBrush             : TBrush;
    FPen               : TPen;
    FRows              : Word;
    FColumns           : Word;
    FDrawFirstRowLine  : Boolean;
    FFirstRowHeight    : Word;
    FFirstColumnWidth  : Word;


    FFirstColumnJoined : Boolean;
    FFirstRowJoined    : Boolean;

    FColumnSizes       : TStrings;
    FRowSizes          : TStrings;

    FCellColumns       : TList;
    procedure SetBrush(Value : TBrush);
    procedure SetPen(Value : TPen);
    procedure SetRows(Value: Word);
    procedure SetColumns(Value: Word);


    procedure SetFirstRowColor(Value: TColor);
    procedure SetFirstCellColor(Value: TColor);
    procedure SetFirstColumnColor(Value: TColor);
    function GetFirstRowColor: TColor;
    function GetFirstCellColor: TColor;
    function GetFirstColumnColor: TColor;

    procedure SetFirstColumnJoined(Value: Boolean);
    procedure SetFirstRowJoined(Value: Boolean);
    procedure SetDrawFirstRowLine(Value: Boolean);
    procedure SetRowSizes(Value: TStrings);
    procedure SetColumnSizes(Value: TStrings);
    function GetCells(ACol, ARow: Integer): TQRPGridCell;
    procedure SetCells(ACol, ARow: Integer; const Value: TQRPGridCell);
  protected
    procedure Paint; override;
    procedure Print(OfsX, OfsY: Integer); override;
    procedure StyleChanged(sender : TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Cells[ACol, ARow: Integer]: TQRPGridCell Read GetCells Write SetCells;
  published
    property FixBottomPosition: Boolean Read FFixBottomPosition
                                        Write FFixBottomPosition;
    property StretchHeightWithBand: Boolean Read FStretchHeightWithBand
                                            write FStretchHeightWithBand;
    property CellHorizAlignment: THorizAlignment Read FCellHorizAlignment Write FCellHorizAlignment;
    property CellVertAlignment: TVertAlignment Read FCellVertAlignment Write FCellVertAlignment;
    property Columns: Word Read FColumns Write SetColumns;
    property ColumnSizes: TStrings Read FColumnSizes Write SetColumnSizes;
    property Rows: Word Read FRows Write SetRows;
    property RowSizes: TStrings Read FRowSizes Write SetRowSizes;
    property DrawFirstRowLine: Boolean Read FDrawFirstRowLine Write SetDrawFirstRowLine;


    property FirstRowColor: TColor Read GetFirstRowColor Write SetFirstRowColor;
    property FirstColumnColor: TColor Read GetFirstColumnColor Write SetFirstColumnColor;
    property FirstCellColor: TColor Read GetFirstCellColor Write SetFirstCellColor;
    property FirstColumnJoined: Boolean Read FFirstColumnJoined Write SetFirstColumnJoined;
    property FirstRowJoined: Boolean Read FFirstRowJoined Write SetFirstRowJoined;
    property Transparent;
    property Brush : TBrush read FBrush write SetBrush;
    property Pen : TPen read FPen write Setpen;
    property Height default 65;
    property Width default 65;
  end;

  TQRPBand = class(TQRBand)
  private
    FNotOnFirstPage : Boolean;
    FNotOnLastPage  : Boolean;
    FExpression     : String;
    FAlwaysUseSpace : Boolean;
    FOldBeforePrint : TQRBandBeforePrintEvent;
    InSetBounds     : Boolean;
  protected
    DisabledControls: TList;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure BandBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: integer); override;
  published
    property BeforePrint: TQRBandBeforePrintEvent read FOldBeforePrint write FOldBeforePrint;
    property AlwaysUseSpace: Boolean Read FAlwaysUseSpace Write FAlwaysUseSpace;
    property Expression: String read FExpression write FExpression;
    property NotOnFirstPage: Boolean read FNotOnFirstPage write FNotOnFirstPage;
    property NotOnLastPage: Boolean read FNotOnLastPage write FNotOnLastPage;
  end;

  TQRPChildBand = class(TQRChildBand)
  private
    FNotOnFirstPage : Boolean;
    FNotOnLastPage  : Boolean;
    FExpression     : String;
    FPagePrints     : Integer;
    FOldBeforePrint : TQRBandBeforePrintEvent;
    LastPage        : Integer;
    InSetBounds     : Boolean;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure BandBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean); virtual;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: integer); override;
  published
    property BeforePrint: TQRBandBeforePrintEvent read FOldBeforePrint write FOldBeforePrint;
    property PagePrints: Integer Read FPagePrints Write FPagePrints;
    property Expression: String read FExpression write FExpression;
    property NotOnFirstPage: Boolean read FNotOnFirstPage write FNotOnFirstPage;
    property NotOnLastPage: Boolean read FNotOnLastPage write FNotOnLastPage;
  end;

  TQRPAfterReportFormCreatedEvent = procedure(Form: TForm; QReport: TQuickrep; DoCancel: Boolean) of Object;

  TReportStyle = (rsList, rsTabular, rsForm, rsSingleForm);

  TQRAbstractGridReport = class(TComponent)
  private
  protected
    FReportTitle                 : String;
    FReportTitleDate             : Boolean;
    FQuickRep                    : TQuickRep;
    FPrintGridLines              : Boolean;
    FAfterReportFormCreated      : TQRPAfterReportFormCreatedEvent;
    FSelectedRecordsOnly         : Boolean;
    {$IFDEF QR36}
    FPrevFormStyle               : TFormStyle;
    FPreviewInitialState         : TWindowState;
    FPreviewWidth                : Integer;
    FPreviewHeight               : Integer;
    {$ENDIF}
    function CreateBandClass(AOwner: TComponent): TQRBand; virtual;
    function CreateReportClass(AOwner: TComponent): TQuickRep; virtual;
    function CreateSysDataClass(AOwner: TComponent): TQRSysdata; virtual;
    function CreateLabelClass(AOwner: TComponent): TQRLabel; virtual;
    function CreateDBTextClass(AOwner: TComponent): TQRDBText; virtual;
    function CreateShapeClass(AOwner: TComponent): {$IFDEF QREXPORTS2} TQRPDFShape {$ELSE} TQRShape {$ENDIF}; virtual;
    function CreateExprClass(AOwner: TComponent): TQRExpr; virtual;
    function CreateGroupClass(AOwner: TComponent): TQRGroup; virtual;
    function CreateSubdetailClass(AOwner: TComponent): TQRSubdetail; virtual;

    function CreateSysdata(ParentBand: TCustomPanel;
                           Left, Top: Integer;
                           Datatype: TQRSysDataType): TQRSysData;
    function CreateShape(ParentBand: TCustomPanel;
                         ShapeType: TQRShapeType;
                         Left, Top, Width, Height: Integer;
                         Color: TColor): {$IFDEF QREXPORTS2} TQRPDFShape {$ELSE} TQRShape {$ENDIF}; virtual;
    function CreateLabel(ParentBand: TCustomPanel;
                         Left, Top: Integer): TQRLabel; virtual;
    function CreateExpr(ParentBand: TCustomPanel; Left, Top: Integer): TQRExpr; virtual;
    function CreateDBText(ParentBand: TCustomPanel; Left, Top: Integer): TQRDBText; virtual;
    function CreateBand(Quickrep: TQuickrep;
                        BandType: TQRBandType;
                        Height: Integer): TQRBand; virtual;
    function CreateGroup(Quickrep: TQuickrep;
                         Height: Integer): TQRGroup; virtual;
    function CreateSubdetail(Quickrep: TQuickrep;
                             Height: Integer): TQRSubdetail; virtual;
    function CreateReport(AParent: TComponent): TQuickRep; virtual;

    procedure _PreviewReport(DefaultReport: TQuickRep; Modal: Boolean); virtual;
    procedure CreateTitle; virtual;
    {$IFDEF QR36}
    function GetPreviewHeight: Integer;
    function GetPreviewWidth: Integer;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    function CreateReportFromGrid: Boolean; virtual;
    procedure PrintReport(DefaultReport: TQuickRep {$IFDEF VER110} = nil {$ENDIF}); virtual;
    procedure PreviewReport(DefaultReport: TQuickRep {$IFDEF VER110} = nil {$ENDIF}); virtual;
    {$IFDEF QR3}
    procedure PreviewReportModal(DefaultReport: TQuickRep {$IFDEF VER110} = nil {$ENDIF}); virtual;
    {$ENDIF}
  published
    property ReportTitle: String Read FReportTitle Write FReportTitle;
    property ReportTitleDate: Boolean Read FReportTitleDate Write FReportTitleDate;
    property PrintGridLines: Boolean Read FPrintGridLines Write FPrintGridLines;
    property QuickRep: TQuickRep Read FQuickRep Write FQuickRep;
    property AfterReportFormCreated: TQRPAfterReportFormCreatedEvent Read FAfterReportFormCreated
                                                                     Write FAfterReportFormCreated;
    {$IFDEF QR36}
    property PrevFormStyle: TFormStyle Read FPrevFormStyle Write FPrevFormStyle;
    property PreviewInitialState: TWindowState Read FPreviewInitialState Write FPreviewInitialState;
    property PreviewWidth: Integer Read GetPreviewWidth Write FPreviewWidth default 500;
    property PreviewHeight: Integer Read GetPreviewHeight Write FPreviewHeight default 500;
    {$ENDIF}
  end;

  TQRGridReport = class(TQRAbstractGridReport)
  private
    FDBGrid                      : TDBGrid;
    FUseExprForDatafields        : Boolean;
    FAutoStretchMemos            : Boolean;
    FSpanPagesHorizontally       : Boolean;
  protected
    procedure DetailBandBeforePrint(Sender: TQRCustomBand;
                var PrintBand: Boolean); virtual;
  public
    function CreateReportFromGrid: Boolean; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  published
    property AutoStretchMemos: Boolean Read FAutoStretchMemos Write FAutoStretchMemos;
    property UseExprForDatafields: Boolean Read FUseExprForDatafields Write FUseExprForDatafields;
    property DBGrid: TDBGrid Read FDBGrid Write FDBGrid;
    property SelectedRecordsOnly: Boolean Read FSelectedRecordsOnly Write FSelectedRecordsOnly;
    property SpanPagesHorizontally: Boolean Read FSpanPagesHorizontally Write FSpanPagesHorizontally;
  end;

  TQRStringgridReport = class(TQRAbstractGridReport)
  private
    FStringGrid                  : TStringgrid;
  protected
    procedure DetailBandBeforePrint(Sender: TQRCustomBand;
                var PrintBand: Boolean); virtual;
    procedure NeedData(Sender: TObject; var MoreData: Boolean); virtual;
  public
    CurrentRow: Longint;
    function CreateReportFromGrid: Boolean; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  published
    property StringGrid: TStringGrid Read FStringGrid Write FStringGrid;
    {property SelectedRecordsOnly: Boolean Read FSelectedRecordsOnly Write FSelectedRecordsOnly;}
  end;



function FindUniqueComponentName(Owner: TForm; Name: String; UseDefault: Boolean): String;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

implementation

{$R QRPCTRLS.RES}

uses
  Math, Dialogs, DB, QRExpbld;

type
  TQRTempBand = Class(TQRCustomBand)
  end;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

function FindUniqueComponentName(Owner: TForm; Name: String; UseDefault: Boolean): String;
var
  X: Integer;
begin
  If UseDefault AND (Owner.FindComponent(Name)=NIL) Then Result:=Name
  Else
    begin
      X:=0;
      Repeat
        Inc(X);
      Until Owner.FindComponent(Name+IntToStr(X))=NIL;
      Result:=Name+IntToStr(X);
    end;
end;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

procedure TQRPDBImage.LoadPicture;
var
  S: String;
begin
  if (DataField<>'') and (Dataset<>NIL) then
    begin
      try
        If Not (DataSet.FindField(DataField) is TBlobField) Then
          begin
            S:=ExpandFileName(Dataset.FindField(DataField).AsString);
            If ExtractFileExt(S)='' Then S:=ChangeFileExt(S,'.BMP');
            If FileExists(S) Then Picture.LoadFromFile(S);
          end
        Else
          Picture.Assign(Dataset.FindField(DataField));
      except
      end;
    end;
end;

{--------------------------------------------------------------------------------}

procedure TQRPDBImage.Print;

  procedure PrintBitmap(aCanvas : TCanvas; Dest : TRect; Bitmap : TBitmap);
  var
    Info : PBitmapInfo;
{$IFDEF VER120}
    InfoSize : DWord;
{$ELSE}
    InfoSize : integer;
{$ENDIF}
    Image : Pointer;
    ImageSize : DWord;
  begin
    with Bitmap do
    begin
      GetDIBSizes(Handle, InfoSize, ImageSize);
      Info := AllocMem(InfoSize);
      try
        Image := AllocMem(ImageSize);
        try
          GetDIB(Handle, Palette, Info^, Image^);
          if not Monochrome then
            SetStretchBltMode(ACanvas.Handle, STRETCH_DELETESCANS);
          with Info^.bmiHeader do
            StretchDIBits(aCanvas.Handle, Dest.Left, Dest.Top,
              Dest.RIght - Dest.Left, Dest.Bottom - Dest.Top,
              0, 0, biWidth, biHeight, Image, Info^, DIB_RGB_COLORS, SRCCOPY);
        finally
          FreeMem(Image, ImageSize);
        end;
      finally
        FreeMem(Info, InfoSize);
      end;
    end;
  end;


var
  H             : Integer;
  Dest          : TRect;
  DrawPict      : TPicture;
  S             : String;
  OrgHeight     : Integer;
  
begin
  OrgHeight:=Height;

  if FixBottomPosition and (Parent is TQRCustomBand)then
    OfsY:=OfsY+Round(TQRTempBand(Parent).Expanded);
  if StretchHeightWithBand then
    Height:=Height+Round(TQRTempBand(Parent).Expanded*ParentReport.QRPrinter.YFactor);

  If (Datafield<>'') AND (Dataset<>NIL) Then
    begin
      try
        If Dataset.FindField(DataField) is TBlobField Then
          begin
            Inherited Print(OfsX, OfsY);
            Height:=OrgHeight;
            Exit;
          end;
      except
      end;
    end;
  with QRPrinter.Canvas do
  begin
    Brush.Style:=bsSolid;
    Brush.Color:=Color;
    DrawPict:=TPicture.Create;
    H:=0;
    try
      If (Datafield<>'') AND (Dataset<>NIL) Then
      begin
        try
          S:=ExpandFileName(Dataset.FindField(DataField).AsString);
          If ExtractFileExt(S)='' Then S:=ChangeFileExt(S,'.BMP');
          If FileExists(S) Then DrawPict.LoadFromFile(S);
        except
        end;
        if (DrawPict.Graphic is TBitmap) and
          (DrawPict.Bitmap.Palette <> 0) then
        begin
          H:=SelectPalette(Handle, DrawPict.Bitmap.Palette, false);
          RealizePalette(Handle);
        end;
        Dest.Left:=QRPrinter.XPos(OfsX+Size.Left);
        Dest.Top:=QRPrinter.YPos(OfsY+Size.Top);
        Dest.Right:=QRPrinter.XPos(OfsX+Size.Width+Size.Left);
        Dest.Bottom:=QRPrinter.YPos(OfsY+Size.Height+Size.Top);
        if Stretch then
        begin
          if (DrawPict.Graphic = nil) or DrawPict.Graphic.Empty then
            FillRect(Dest)
          else
          if DrawPict.Graphic is TBitmap Then
            PrintBitmap(QRPrinter.Canvas, Dest, TBitmap(DrawPict.Graphic))
          else
            StretchDraw(Dest, DrawPict.Graphic)
        end else
        begin
          IntersectClipRect(Handle,Dest.Left,Dest.Top,Dest.Right,Dest.Bottom);
          Dest.Right := Dest.Left +
            round(DrawPict.Width / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.XFactor);
          Dest.Bottom := Dest.Top +
            round(DrawPict.Height / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.YFactor);
          if Center then OffsetRect(Dest,
            (QRPrinter.XSize(Size.Width) -
              round(DrawPict.Width / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.XFactor)) div 2,
            (QRPrinter.YSize(Size.Height) -
              round(DrawPict.Height / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.YFactor)) div 2);
          QRPrinter.Canvas.StretchDraw(Dest, DrawPict.Graphic);
          SelectClipRgn(Handle, 0);
        end;
      end;
    finally
      if H <> 0 then SelectPalette(Handle, H, True);
      DrawPict.Free;
    end;
  end;
  Inherited Print(OfsX,OfsY);
  Height:=OrgHeight;
end;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

procedure CalculateRotatedPosition(Comp: TQRPrintable;
                                   FontHandle: HFont;
                                   Alignment: TAlignment;
                                   var Rect: TRect;
                                   Zoom : Integer;
                                   Printing: Boolean;
                                   PrintOfsX, PrintOfsY: Integer;
                                   Text: String);
var
  CHeight, CWidth, Width2, Height2, DX, DY : Integer;
  RelPos : Single;
  TW, TH, Degree: Integer;
  Size : TSize;
  DeviceContext : HDC;
  H : HFont;
begin
  DeviceContext:=GetDC(0);
  H:=SelectObject(DeviceContext, FontHandle);
  GetTextExtentPoint32(DeviceContext, @Text[1], Length(Text), Size);
  SelectObject(DeviceContext, H);
  ReleaseDC(0, DeviceContext);
  TW:=Size.cx; TH:=Size.cy;
  Degree:=GetIntegerProperty(Comp,'Degree');
  if (Degree <= 900) then DX:=0 Else
  if (Degree <= 1800) then DX:=Trunc(TW * -cos(Degree * Pi/1800)) Else
  if (Degree <= 2700) then DX:=Trunc(TW * -cos(Degree * Pi/1800) + TH * sin((Degree - 1800) * Pi/1800))
  Else DX:=Trunc(TH * sin((3600 - Degree) * Pi/1800));
  if (Degree <= 900) then DY:=Trunc(TW * Sin(Degree * Pi/1800)) Else
  if (Degree <= 1800) then DY:=Trunc(TW * sin(Degree * Pi/1800) + TH * cos((1800 - Degree) * Pi/1800)) Else
  if (Degree <= 2700) then DY:=Trunc(TH * sin((2700 - Degree) * Pi/1800))
  Else DY:=0;

  If Printing Then
    begin
      Rect.Left:=Rect.Left + DX;
      Rect.Top:=Rect.Top + DY;
      Width2:=Round( Abs(Int(TW * cos(Degree * Pi/1800))) +
                          Abs(Trunc(TH * sin(Degree * Pi/1800))));
      Height2:=Round( Abs(Int(TW * sin(Degree * Pi/1800))) +
                           Abs(Trunc(TH * cos(Degree * Pi/1800))));
      CWidth:=Round(Comp.Width*100/Zoom);
      CHeight:=Round(Comp.Height*100/Zoom);
    end
  Else
    begin
      Rect.Left:=Rect.Left + Round(DX * Zoom / 100);
      Rect.Top:=Rect.Top + Round(DY * Zoom / 100);
      CWidth:=Comp.Width;
      CHeight:=Comp.Height;
      Width2:=Round( (Abs(Trunc(TW * cos(Degree * Pi/1800))) +
                          Abs(Trunc(TH * sin(Degree * Pi/1800))))*Zoom/100);
      Height2:=Round( (Abs(Trunc(TW * sin(Degree * Pi/1800))) +
                           Abs(Trunc(TH * cos(Degree * Pi/1800))))*Zoom/100);
    end;
  if GetBooleanProperty(Comp,'Autosize') then
    begin
      Comp.Width :=Width2;
      Comp.Height:=Height2;
    end
  else
  if Alignment = taLeftJustify then
    begin
      if (Degree <= 1800) then Rect.Top:= Rect.Top + CHeight - Height2;
      if (Degree > 900) and (Degree <= 2700) then Rect.Left:= Rect.Left + CWidth - Width2;
    end
  else
  if Alignment = taCenter then
    begin
      if Degree = 2700 then Rect.Left:= Rect.Left + CWidth - Width2
      else
      if not (Degree = 900) then Rect.Left:= Rect.Left + ((CWidth-Width2) div 2);
      if Degree = 1800 then Rect.Top:= Rect.Top + CHeight - Height2
      else
        Rect.Top:= Rect.Top + ((CHeight-Height2) div 2);
    end
  else
  if Alignment = taRightJustify then
    begin
      if (Degree < 900) or (Degree >= 2700) then Rect.Left:= Rect.Left + CWidth - Width2;
      if (Degree >= 1800) then Rect.Top:= Rect.Top + CHeight - Height2;
    end;
  if Printing and (Comp.ParentReport.QRPrinter.Destination = qrdPrinter) then
    with Comp.ParentReport.QRPrinter, Rect do
      begin
        RelPos:=Left/Right;
        Left:=XPos(PrintOfsX + Comp.Size.Left);
        Right:=XPos(PrintOfsX + Comp.Size.Left + Comp.Size.Width);
        Left:=Round((Right - Left) * RelPos) + Left;

        RelPos:=Top/Bottom;
        Top:=YPos(PrintOfsY + Comp.Size.Top);
        Bottom:=YPos(PrintOfsY + Comp.Size.Top + Comp.Size.Height);
        Top:=Round((Bottom - Top) * RelPos) + Top;
      end;
end;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

procedure TQRPLabel.FormatLines;
begin
  If Degree=0 Then Inherited FormatLines;
end;

{--------------------------------------------------------------------------------}

procedure TQRPLabel.Paint;
var
  Rect, ClipRect : TRect;
  LogFont : TLogFont;
  OldFont: HFont;
begin
  If Degree=0 Then
    begin
      Inherited Paint
    end
  Else
    begin
      if not Transparent then
        begin
          Canvas.Brush.Color:=Color;
          Canvas.Brush.Style:=bsSolid;
          Canvas.FillRect(ClientRect);
        end;
      PaintCorners;
      Canvas.Brush.Style:=bsClear;
      Canvas.Font:=Font;
      Canvas.Font.Size:=round(Canvas.Font.Size * Zoom/100);
      Canvas.Font.Color:=Font.Color;
      Rect:=ClientRect;
      ClipRect:=Rect;
      CalculateRotatedPosition(Self, Font.Handle, Alignment, Rect,
                               Zoom, False, 0, 0, Caption);
      GetObject(Canvas.Font.Handle, SizeOf(LogFont), @LogFont);
      LogFont.lfEscapement:=Degree;
      OldFont:=SelectObject(Canvas.Handle, CreateFontIndirect(LogFont));
      SetTextAlign(Canvas.Handle, TA_LEFT);
      Canvas.TextRect(ClipRect, Rect.Left, Rect.Top, Caption);
      DeleteObject(SelectObject(Canvas.Handle, OldFont));
    end;

  Rect := GetClientRect;
  dec(Rect.Bottom);
  dec(Rect.Right);
  TQRPFrame(Frame).PaintIt(Canvas, Rect, Screen.PixelsPerInch / 254 * Zoom/100, Screen.PixelsPerInch / 254 * Zoom/100);
end;

{--------------------------------------------------------------------------------}

procedure TQRPLabel.Print(OfsX, OfsY: Integer);
var
  R, ClipRect : TRect;
  LogFont     : TLogFont;
  OldFont     : HFont;
  OrgHeight   : Integer;
  BStyle      : TBrushStyle;
  AAlignment  : TAlignment;
begin
  OrgHeight:=Height;

  if FixBottomPosition and (Parent is TQRCustomBand)then
    OfsY:=OfsY+Round(TQRTempBand(Parent).Expanded);
  if StretchHeightWithBand then
    Height:=Height+Round(TQRTempBand(Parent).Expanded*ParentReport.QRPrinter.YFactor);

  If Degree=0 Then
    begin
      Inherited Print(OfsX, OfsY);
      Height:=OrgHeight;
      exit;
    end;
  R.Left:=ParentReport.QRPrinter.XPos(OfsX + Size.Left);
  R.Top:=ParentReport.QRPrinter.YPos(OfsY + Size.Top);
  R.Right:=ParentReport.QRPrinter.XPos(OfsX + Size.Left + Size.Width);
  R.Bottom:=ParentReport.QRPrinter.YPos(OfsY + Size.Top + Size.Height);

  BStyle:=ParentReport.QRPrinter.Canvas.Brush.Style;
  if not Transparent then
    begin
      ParentReport.QRPrinter.Canvas.Brush.Style:=bsSolid;
      ParentReport.QRPrinter.Canvas.Brush.Color:=Color;
      ParentReport.QRPrinter.Canvas.FillRect(R);
    end
  else
    ParentReport.QRPrinter.Canvas.Brush.Style:=bsClear;
  with ParentReport.QRPrinter do
    begin
      Canvas.Font:=Font;
      Canvas.Font.Color:=Font.Color;
      ClipRect:=R;
      if (Destination = qrdPrinter) then
        begin
          R:=ClientRect;
          R.Left:=Round(R.Left * 100/Zoom);
          R.Right:=Round(R.Right * 100/Zoom);
          R.Top:=Round(R.Top * 100/Zoom);
          R.Bottom:=Round(R.Bottom * 100/Zoom);
        end;
      AAlignment := Alignment;
      {$IFDEF VER110}
      if UseRightToLeftAlignment then
        ChangeBiDiModeAlignment(AAlignment);
      {$ENDIF}
      SetTextAlign(Canvas.Handle, TA_Left + TA_Top + TA_NoUpdateCP);
      CalculateRotatedPosition(Self, Font.Handle, AAlignment, R,
                               Zoom, True, OfsX, OfsY, Caption);
      GetObject(Canvas.Font.Handle, SizeOf(LogFont), @LogFont);
      LogFont.lfEscapement:=Degree;
      OldFont:=SelectObject(Canvas.Handle, CreateFontIndirect(LogFont));
      SetTextAlign(Canvas.Handle, TA_LEFT);
      Canvas.TextRect(ClipRect, R.Left, R.Top, Caption);
      DeleteObject(SelectObject(Canvas.Handle, OldFont));
    end;
  if ParentReport.FinalPass and Frame.AnyFrame then
    TQRPFrame(Frame).PaintIt(ParentReport.QRPrinter.Canvas,
      Rect(ParentReport.QRPrinter.XPos(OfsX + Size.Left),
      ParentReport.QRPrinter.YPos(OfsY + Size.Top),
      ParentReport.QRPrinter.XPos(OfsX + Size.Left + Size.Width),
      ParentReport.QRPrinter.YPos(OfsY + Size.Top + Size.Height)),
      ParentReport.QRPrinter.XFactor,
      ParentReport.QRPrinter.YFactor);
  Height:=OrgHeight;
  ParentReport.QRPrinter.Canvas.Brush.Style:=BStyle;
end;

{--------------------------------------------------------------------------------}

procedure TQRPLabel.SetDegree(Value: Word);
begin
  If Value<>FDegree Then
    begin
      If Value<>0 Then AutoSize:=False;
      While Value>3600 Do Value:=Value-3600;
      FDegree:=Value;
      Invalidate;
    end;
end;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

procedure TQRPDBText.Print(OfsX, OfsY: Integer);
var
  OrgHeight     : Integer;
begin
  OrgHeight:=Height;

  if FixBottomPosition and (Parent is TQRCustomBand)then
    OfsY:=OfsY+Round(TQRTempBand(Parent).Expanded);
  if StretchHeightWithBand then
    Height:=Height+Round(TQRTempBand(Parent).Expanded*ParentReport.QRPrinter.YFactor);

  OldOnPrint:=OnPrint;
  OnPrint:=DBTextOnPrint;
  Inherited Print(OfsX, OfsY);
  OnPrint:=OldOnPrint;

  Height:=OrgHeight;
end;

{--------------------------------------------------------------------------------}

procedure TQRPDBText.DBTextOnPrint;
begin
  If SuppressRepeatedValues Then
    begin
      If Value=LastValue Then
        begin
          If Not(ReprintOnNewPage and (ParentReport.PageNumber<>LastPage))
            Then Value:=''
        end
      Else
        LastValue:=Value;
      LastPage:=ParentReport.PageNumber;
    end;
  If BlankIfZero Then
    begin
      try
        If Dataset.FieldByName(DataField).AsFloat=0 Then Value:='';
      except
      end;
    end;
  If Assigned(FOldOnPrint) Then OldOnPrint(Sender, Value);
  If Value<>Caption Then Caption:=Value;
  FormatLines;
end;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

procedure TQRPExpr.Paint;
var
  Rect, ClipRect : TRect;
  LogFont : TLogFont;
  OldFont: HFont;
begin
  If Degree=0 Then
    begin
      Inherited Paint
    end
  Else
    begin
      if not Transparent then
        begin
          Canvas.Brush.Color:=Color;
          Canvas.Brush.Style:=bsSolid;
          Canvas.FillRect(ClientRect);
        end;
      PaintCorners;
      Canvas.Brush.Style:=bsClear;
      Canvas.Font:=Font;
      Canvas.Font.Size:=round(Canvas.Font.Size * Zoom/100);
      Canvas.Font.Color:=Font.Color;

      Rect:=ClientRect;
      ClipRect:=Rect;
      CalculateRotatedPosition(Self, Font.Handle, Alignment, Rect,
                               Zoom, False, 0, 0, Caption);
      GetObject(Canvas.Font.Handle, SizeOf(LogFont), @LogFont);
      LogFont.lfEscapement:=Degree;
      OldFont:=SelectObject(Canvas.Handle, CreateFontIndirect(LogFont));
      SetTextAlign(Canvas.Handle, TA_LEFT);
      Canvas.TextRect(ClipRect, Rect.Left, Rect.Top, Caption);
      DeleteObject(SelectObject(Canvas.Handle, OldFont));
    end;
  Rect := GetClientRect;
  dec(Rect.Bottom);
  dec(Rect.Right);
  TQRPFrame(Frame).PaintIt(Canvas, Rect, Screen.PixelsPerInch / 254 * Zoom/100, Screen.PixelsPerInch / 254 * Zoom/100);
end;

{--------------------------------------------------------------------------------}

procedure TQRPExpr.Print(OfsX, OfsY: Integer);
var
  R, ClipRect : TRect;
  LogFont     : TLogFont;
  OldFont     : HFont;
  aValue      : TQREvResult;
  OrgHeight   : Integer;
  AAlignment  : TAlignment;

begin
  OrgHeight:=Height;

  if FixBottomPosition and (Parent is TQRCustomBand)then
    OfsY:=OfsY+Round(TQRTempBand(Parent).Expanded);
  if StretchHeightWithBand then
    Height:=Height+Round(TQRTempBand(Parent).Expanded*ParentReport.QRPrinter.YFactor);

  If Degree=0 Then
    begin
      Inherited Print(OfsX, OfsY);
      Height:=OrgHeight;
      exit;
    end;
  aValue:=Value;
  case aValue.Kind of
    resInt : Caption:=FormatFloat(Mask, aValue.IntResult*1.0);
    resString : Caption:=aValue.strResult;
    resDouble : Caption:=FormatFloat(Mask,aValue.DblResult);
    resBool : if aValue.booResult then Caption:='True' else Caption:='False'; {<-- do not resource }
    resError : Caption:=Expression;
  end;
  R.Left:=ParentReport.QRPrinter.XPos(OfsX + Size.Left);
  R.Top:=ParentReport.QRPrinter.YPos(OfsY + Size.Top);
  R.Right:=ParentReport.QRPrinter.XPos(OfsX + Size.Left + Size.Width);
  R.Bottom:=ParentReport.QRPrinter.YPos(OfsY + Size.Top + Size.Height);
  if not Transparent then
    begin
      ParentReport.QRPrinter.Canvas.Brush.Style:=bsSolid;
      ParentReport.QRPrinter.Canvas.Brush.Color:=Color;
      ParentReport.QRPrinter.Canvas.FillRect(R);
    end;
  ParentReport.QRPrinter.Canvas.Brush.Style:=bsClear;
  with ParentReport.QRPrinter do
    begin
      Canvas.Font:=Font;
      Canvas.Font.Color:=Font.Color;
      ClipRect:=R;
      if (Destination = qrdPrinter) then
        begin
          R:=ClientRect;
          R.Left:=Round(R.Left * 100/Zoom);
          R.Right:=Round(R.Right * 100/Zoom);
          R.Top:=Round(R.Top * 100/Zoom);
          R.Bottom:=Round(R.Bottom * 100/Zoom);
        end;
      AAlignment := Alignment;
      {$IFDEF VER110}
      if UseRightToLeftAlignment then
        ChangeBiDiModeAlignment(AAlignment);
      {$ENDIF}
      SetTextAlign(Canvas.Handle, TA_Left + TA_Top + TA_NoUpdateCP);
      CalculateRotatedPosition(Self, Font.Handle, AAlignment, R,
                               Zoom, True, OfsX, OfsY, Caption);
      GetObject(Canvas.Font.Handle, SizeOf(LogFont), @LogFont);
      LogFont.lfEscapement:=Degree;
      OldFont:=SelectObject(Canvas.Handle, CreateFontIndirect(LogFont));
      SetTextAlign(Canvas.Handle, TA_LEFT);
      Canvas.TextRect(ClipRect, R.Left, R.Top, Caption);
      DeleteObject(SelectObject(Canvas.Handle, OldFont));
    end;
  if ParentReport.FinalPass and Frame.AnyFrame then
    TQRPFrame(Frame).PaintIt(ParentReport.QRPrinter.Canvas,
      Rect(ParentReport.QRPrinter.XPos(OfsX + Size.Left),
      ParentReport.QRPrinter.YPos(OfsY + Size.Top),
      ParentReport.QRPrinter.XPos(OfsX + Size.Left + Size.Width),
      ParentReport.QRPrinter.YPos(OfsY + Size.Top + Size.Height)),
      ParentReport.QRPrinter.XFactor,
      ParentReport.QRPrinter.YFactor);
  if ResetAfterPrint then Reset;

  Height:=OrgHeight;
end;

{--------------------------------------------------------------------------------}

procedure TQRPExpr.SetDegree(Value: Word);
begin
  If Value<>FDegree Then
    begin
      If Value<>0 Then AutoSize:=False;
      While Value>3600 Do Value:=Value-3600;
      FDegree:=Value;
      Invalidate;
    end;
end;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

function EvalStringExpression(E: String; ParentReport: TQuickRep): String;
var
  aValue : TQREvResult;
  Evaluator : TQREvaluator;
begin
  EvalStringExpression:='';
  If E='' Then Exit;
  Evaluator := TQREvaluator.Create;
  Evaluator.DataSets := ParentReport.AllDataSets;
  Evaluator.Prepare(E);
  aValue := Evaluator.Value;
  If aValue.Kind=resString Then
    EvalStringExpression:=aValue.StrResult
  Else
    EvalStringExpression:='';
  Evaluator.Unprepare;
  Evaluator.Free;
end;

{--------------------------------------------------------------------------------}

function EvalBoolExpression(E: String; ParentReport: TQuickRep): Boolean;
var
  aValue : TQREvResult;
  Evaluator : TQREvaluator;
begin
  EvalBoolExpression:=True;
  If E='' Then Exit;
  Evaluator := TQREvaluator.Create;
  Try
    Evaluator.DataSets := ParentReport.AllDataSets;
    Evaluator.Prepare(E);
    aValue := Evaluator.Value;
    If aValue.Kind=resBool Then
      EvalBoolExpression:=aValue.booResult
    Else
      EvalBoolExpression:=True;
    Evaluator.Unprepare;
  Finally
    Evaluator.Free;
  End;
end;

{--------------------------------------------------------------------------------}

procedure TQRPMemo.Print(OfsX, OfsY: Integer);
var
  TempLines: TStrings;
  X: Integer;
  E,S: String;
  P,P2: Byte;
  OrgHeight     : Integer;
  
begin
  OrgHeight:=Height;

  if FixBottomPosition and (Parent is TQRCustomBand)then
    OfsY:=OfsY+Round(TQRTempBand(Parent).Expanded);
  if StretchHeightWithBand then
    Height:=Height+Round(TQRTempBand(Parent).Expanded*ParentReport.QRPrinter.YFactor);

  TempLines:=TStringList.Create;
  Try
    TempLines.Assign(Lines);

    { evaluate expressions embedded with %%....%% }
    If Lines.Count>0 Then
      For X:=0 to Lines.Count-1 Do
        begin
          S:=Lines[X];
          Repeat
            P:=Pos('%%',S);
            If P<>0 Then
              begin
                System.Delete(S,P,2);
                P2:=Pos('%%',S);
                If P2=0 Then P2:=Length(S)+1
                Else
                  System.Delete(S,P2,2);
                E:=Copy(S,P,P2-P);
                System.Delete(S,P,P2-P);
                System.Insert(EvalStringExpression(E,TQuickRep(ParentReport)),S,P);
                Lines[X]:=S;
              end;
          Until P=0;
        end;

    { remove empty lines with %DEL command }
    If Lines.Count>0 Then
      For X:=Lines.Count-1 DownTo 0 Do
        If Trim(Lines[X])='%DEL' Then Lines.Delete(X);

    { remove remaining %DEL commands }
    If Lines.Count>0 Then
      For X:=0 to Lines.Count-1 Do
        begin
          S:=Lines[X];
          Repeat
            P:=Pos('%DEL',S);
            If P<>0 Then
              begin
                System.Delete(S,P,4);
                Lines[X]:=S;
              end;
          Until P=0;
        end;
    Caption:='';
    Inherited Print(OfsX,OfsY);
    Lines.Assign(TempLines);
    Caption:='';
  finally
    TempLines.Free;
  end;

  Height:=OrgHeight;
end;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

procedure TQRPShape.SetQRPShape(Value: TQRPShapeType);
begin
  FQRPShape:=Value;
  Invalidate;
end;

{--------------------------------------------------------------------------------}

procedure TQRPShape.Print(OfsX, OfsY: Integer);

  procedure _Print;
  begin
    QRPrinter.Canvas.Brush.Assign(Brush);
    QRPrinter.Canvas.Pen.Assign(Pen);
  end;

var
  OrgHeight: Integer;
begin
  if Not (ParentReport.FinalPass and Enabled) then Exit;

  OrgHeight:=Height;
  if FixBottomPosition and (Parent is TQRCustomBand)then
    OfsY:=OfsY+Round(TQRTempBand(Parent).Expanded);
  if StretchHeightWithBand then
    Height:=Height+Round(TQRTempBand(Parent).Expanded*ParentReport.QRPrinter.YFactor);

  Case FQRPShape of
    qrpsRectangle: begin
                     Inherited Shape:=qrsRectangle;
                     Inherited Print(OfsX, OfsY);
                   end;
    qrpsCircle:    begin
                     Inherited Shape:=qrsCircle;
                     Inherited Print(OfsX, OfsY);
                   end;
    qrpsVertLine:  begin
                     Inherited Shape:=qrsVertLine;
                     Inherited Print(OfsX, OfsY);
                   end;
    qrpsHorLine: begin
                     Inherited Shape:=qrsHorLine;
                     Inherited Print(OfsX, OfsY);
                   end;
    qrpsTopAndBottom: begin
                     Inherited Shape:=qrsTopAndBottom;
                     Inherited Print(OfsX, OfsY);
                   end;
    qrpsRightAndLeft: begin
                     Inherited Shape:=qrsRightAndLeft;
                     Inherited Print(OfsX, OfsY);
                   end;
    qrpsDownLine:  With QRPrinter Do
                   begin
                     _Print;
                     Canvas.MoveTo(XPos(OfsX + Size.Left),YPos(OfsY + Size.Top));
                     Canvas.LineTo(XPos(OfsX+Size.Left + Size.Width),
                                             YPos(OfsY + Size.Top + Size.Height));
                   end;
    qrpsUpLine:    with QRPrinter Do
                   begin
                     _Print;
                     Canvas.MoveTo(XPos(OfsX + Size.Left),YPos(OfsY + Size.Top + Size.Height));
                     Canvas.LineTo(XPos(OfsX+Size.Left + Size.Width),
                                             YPos(OfsY + Size.Top));
                   end;
    qrpsTriangle1: with QRPrinter Do
                   begin
                     _Print;
                     Canvas.Polygon([Point(XPos(OfsX + Size.Left),YPos(OfsY + Size.Top)),
                                     Point(XPos(OfsX+Size.Left + Size.Width),YPos(OfsY + Size.Top)),
                                     Point(XPos(OfsX + Size.Left),YPos(OfsY + Size.Top + Size.Height))]);
                   end;
    qrpsTriangle2: with QRPrinter Do
                   begin
                     _Print;
                     Canvas.Polygon([Point(XPos(OfsX + Size.Left),YPos(OfsY + Size.Top)),
                                     Point(XPos(OfsX+Size.Left + Size.Width),YPos(OfsY + Size.Top)),
                                     Point(XPos(OfsX+Size.Left + Size.Width),YPos(OfsY + Size.Top + Size.Height))]);
                   end;
    qrpsTriangle3: with QRPrinter Do
                   begin
                     _Print;
                     Canvas.Polygon([Point(XPos(OfsX + Size.Left),YPos(OfsY + Size.Top)),
                                     Point(XPos(OfsX+Size.Left + Size.Width),YPos(OfsY + Size.Top + Size.Height)),
                                     Point(XPos(OfsX + Size.Left),YPos(OfsY + Size.Top + Size.Height))]);
                   end;
    qrpsTriangle4: with QRPrinter Do
                   begin
                     _Print;
                     Canvas.Polygon([Point(XPos(OfsX+Size.Left + Size.Width),YPos(OfsY + Size.Top)),
                                     Point(XPos(OfsX + Size.Left),YPos(OfsY + Size.Top + Size.Height)),
                                     Point(XPos(OfsX+Size.Left + Size.Width),YPos(OfsY + Size.Top + Size.Height))]);
                   end;
  end;
  if ParentReport.FinalPass and Frame.AnyFrame then
    TQRPFrame(Frame).PaintIt(ParentReport.QRPrinter.Canvas,
      Rect(ParentReport.QRPrinter.XPos(OfsX + Size.Left),
      ParentReport.QRPrinter.YPos(OfsY + Size.Top),
      ParentReport.QRPrinter.XPos(OfsX + Size.Left + Size.Width),
      ParentReport.QRPrinter.YPos(OfsY + Size.Top + Size.Height)),
      ParentReport.QRPrinter.XFactor,
      ParentReport.QRPrinter.YFactor);
      
  Height:=OrgHeight;
end;

procedure TQRPShape.Paint;

  procedure _Paint;
  begin
    if not Transparent then
      begin
        Canvas.Brush.Color := clWhite;
        Canvas.Brush.Style := bsSolid;
        Canvas.FillRect(ClientRect);
      end;
    PaintCorners;
    Canvas.Pen.Assign(Pen);
    Canvas.Brush.Assign(Brush);
  end;

begin
  Case FQRPShape of
    qrpsRectangle: begin
                     Inherited Shape:=qrsRectangle;
                     Inherited Paint;
                   end;
    qrpsCircle:    begin
                     Inherited Shape:=qrsCircle;
                     Inherited Paint;
                   end;
    qrpsVertLine:  begin
                     Inherited Shape:=qrsVertLine;
                     Inherited Paint;
                   end;
    qrpsHorLine:   begin
                     Inherited Shape:=qrsHorLine;
                     Inherited Paint;
                   end;
    qrpsTopAndBottom: begin
                        Inherited Shape:=qrsTopAndBottom;
                        Inherited Paint;
                      end;
    qrpsRightAndLeft: begin
                        Inherited Shape:=qrsRightAndLeft;
                        Inherited Paint;
                      end;
    qrpsDownLine:  begin
                     _Paint;
                     Canvas.MoveTo(0,0);
                     Canvas.LineTo(Width-1,Height-1);
                   end;
    qrpsUpLine:    begin
                     _Paint;
                     Canvas.MoveTo(0,Height-1);
                     Canvas.LineTo(Width-1,0);
                   end;
    qrpsTriangle1: begin
                     _Paint;
                     Canvas.Polygon([Point(0,0),Point(Width-1,0),Point(0,Height-1)]);
                   end;
    qrpsTriangle2: begin
                     _Paint;
                     Canvas.Polygon([Point(0,0),Point(Width-1,0),Point(Width-1,Height-1)]);
                   end;
    qrpsTriangle3: begin
                     _Paint;
                     Canvas.Polygon([Point(0,0),Point(Width-1,Height-1),Point(0,Height-1)]);
                   end;
    qrpsTriangle4: begin
                     _Paint;
                     Canvas.Polygon([Point(Width-1,0),Point(0,Height-1),Point(Width-1,Height-1)]);
                   end;
  end;
  TQRPFrame(Frame).PaintIt(Canvas, GetClientRect,
                           Screen.PixelsPerInch / 254 * Zoom/100,
                           Screen.PixelsPerInch / 254 * Zoom/100);
end;


{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

procedure TQRPRichtext.Print(OfsX, OfsY: Integer);
var
  MS: TMemoryStream;
  I,I2: Integer;
  RE: TRichEdit;
  //E: String[255];
  E: String;
  OrgHeight     : Integer;
  
begin
  OrgHeight:=Height;

  if FixBottomPosition and (Parent is TQRCustomBand)then
    OfsY:=OfsY+Round(TQRTempBand(Parent).Expanded);
  if StretchHeightWithBand then
    Height:=Height+Round(TQRTempBand(Parent).Expanded*ParentReport.QRPrinter.YFactor);

  RE:=NIL;
  If ParentRichEdit<>NIL Then RE:=ParentRichEdit
  Else
  For I:=1 to ControlCount Do
    If Controls[I-1] is TQRRichEdit Then RE:=TRichEdit(Controls[I-1]);
  MS:=NIL;
  If RE<>NIL Then
    begin
      MS:=TMemoryStream.Create;
      Try
        RE.Lines.SaveToStream(MS);

        { evaluate expressions embedded with %%....%% }
        repeat
          I:=RE.FindText('%%',0,Length(RE.Text)-1,[stMatchCase]);
          If I>=0 Then
            begin
              RE.SelStart:=I;
              RE.SelLength:=2;
              RE.ClearSelection;
              I2:=RE.FindText('%%',0,Length(RE.Text)-1,[stMatchCase]);
              If I2>=0 Then
                begin
                  RE.SelStart:=I2;
                  RE.SelLength:=2;
                  RE.ClearSelection;
                  RE.SelStart:=I;
                  RE.SelLength:=I2-I;
                  // rad 6
                  //E[0]:=Chr(RE.GetSelTextBuf(@E[1],256));
                  RE.SelText:=EvalStringExpression(E,TQuickRep(ParentReport));
                end;
            end;
        until I<0;

        { remove empty lines with %DEL command }
        If RE.Lines.Count>0 Then
          For I:=RE.Lines.Count-1 DownTo 0 Do
            If Trim(RE.Lines[I])='%DEL' Then Lines.Delete(I);

        { remove remaining %DEL commands }
        repeat
          I:=RE.FindText('%DEL',0,Length(RE.Text)-1,[stMatchCase]);
          If I>=0 Then
            begin
              RE.SelStart:=I;
              RE.SelLength:=4;
              RE.ClearSelection;
            end;
        until I<0;

      except
      end;
    end;
  Inherited Print(OfsX,OfsY);
  If RE<>NIL Then
    begin
      try
        MS.Seek(0,0);
        RE.Lines.LoadFromStream(MS);
      finally
        MS.Free;
      end;
    end;

  Height:=OrgHeight;
end;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

constructor TQRPGrid.Create(AOwner : TComponent);
var
  I, J : Integer;
  L    : TList;
begin
  inherited Create(AOwner);
  FCellColumns:=TList.Create;
  FColumnSizes:=TStringList.Create;
  FRowSizes:=TStringList.Create;
  Width:=65;
  Height:=65;
  FPen:=TPen.Create;
  FBrush:=TBrush.Create;
  FBrush.Color:=clWhite;
  FBrush.OnChange:=StyleChanged;
  FPen.OnChange:=StyleChanged;
  FRows:=3;
  FColumns:=3;
  For I:=1 to 3 Do
    begin
      L:=TList.Create;
      For J:=1 to 3 Do L.Add(TQRPGridCell.Create);
      FCellColumns.Add(L);
    end;
  Transparent:=False;
  FFirstRowHeight:=0;
  FFirstColumnWidth:=0;
  FirstRowColor:=clWhite;
  FirstColumnColor:=clWhite;
  FFirstColumnJoined:=False;
  FFirstRowJoined:=False;
  FirstCellColor:=clWhite;
  FDrawFirstRowLine:=True;
end;

function TQRPGrid.GetCells(ACol, ARow: Integer): TQRPGridCell;
begin
  try
    Result:=TQRPGridCell(TList(FCellColumns[ACol])[ARow]);
  except
    Result:=NIL;
  end;
end;

procedure TQRPGrid.SetCells(ACol, ARow: Integer; const Value: TQRPGridCell);
begin
end;

procedure TQRPGrid.SetColumnSizes(Value: TStrings);
var
  PAll, X: Integer;
begin
  FColumnSizes.Assign(Value);
  While FColumnSizes.Count>FColumns Do FColumnSizes.Delete(FColumnSizes.Count-1);
  PAll:=0;
  For X:=1 to FColumnSizes.Count Do
    begin
      try
        PAll:=PAll+StrToInt(FColumnSizes[X-1]);
      except
        FColumnSizes[X-1]:='20';
        PAll:=PAll+20;
      end;
    end;
  If FColumnSizes.Count=Columns Then
    begin
      If Frame.DrawLeft Then PAll:=PAll+Frame.Width;
      If Frame.DrawRight Then PAll:=PAll+Frame.Width;
      Width:=Pall;
    end;
  Invalidate;
end;

procedure TQRPGrid.SetRowSizes(Value: TStrings);
var
  PAll, X: Integer;
begin
  FRowSizes.Assign(Value);
  While FRowSizes.Count>FRows Do FRowSizes.Delete(FRowSizes.Count-1);
  PAll:=0;
  For X:=1 to FRowSizes.Count Do
    begin
      try
        PAll:=PAll+StrToInt(FRowSizes[X-1]);
      except
        FRowSizes[X-1]:='20';
        PAll:=PAll+20;
      end;
    end;
  If FRowSizes.Count=Rows Then
    begin
      If Frame.DrawTop Then PAll:=PAll+Frame.Width;
      If Frame.DrawBottom Then PAll:=PAll+Frame.Width;
      Height:=Pall;
    end;
  Invalidate;
end;


destructor TQRPGrid.Destroy;
var
  I, J : Integer;
  L    : TList;
begin
  FPen.Free;
  FBrush.Free;
  FColumnSizes.Free;
  FRowSizes.Free;
  For I:=1 to FCellColumns.Count Do
    begin
      L:=TList(FCellColumns[I-1]);
      For J:=L.Count DownTo 1 Do TQRPGridCell(L[J-1]).Free;
      L.Free;
    end;
  FCellColumns.Free;
  inherited Destroy;
end;

procedure TQRPGrid.SetColumns(Value: Word);
var
  L: TList;
  I: Integer;
begin
  FColumns:=Value;
  While FColumnSizes.Count>FColumns Do FColumnSizes.Delete(FColumnSizes.Count-1);
  While FCellColumns.Count>Value Do
    begin
      L:=TList(FCellColumns[FCellColumns.Count-1]);
      For I:=1 to L.Count Do TQRPGridCell(L[I-1]).Free;
      FCellColumns.Delete(FCellColumns.Count-1);
      L.Free;
    end;
  While FCellColumns.Count<Value Do
    begin
      L:=TList.Create;
      For I:=1 to Rows Do L.Add(TQRPGridCell.Create);
      FCellColumns.Add(L);
    end;
  Invalidate;
end;

procedure TQRPGrid.SetRows(Value: Word);
var
  I : Integer;
  L : TList;
begin
  FRows:=Value;
  While FRowSizes.Count>FRows Do FRowSizes.Delete(FRowSizes.Count-1);
  For I:=1 to FColumns Do
    begin
      L:=FCellColumns[I-1];
      While L.Count>Value Do
        begin
          TQRPGridCell(L[L.Count-1]).Free;
          L.Delete(L.Count-1);
        end;
      While L.Count<Value Do L.Add(TQRPGridCell.Create);
    end;
  Invalidate;
end;

procedure TQRPGrid.StyleChanged(Sender : TObject);
begin
(*  If (Sender is TBrush) AND (Not (FFirstRowJoined or FFirstColumnJoined)) Then
    begin
      FFirstCellColor:=FBrush.Color;
      FFirstColumnColor:=FBrush.Color;
      FFirstRowColor:=FBrush.Color;
    end;*)
  Invalidate;
end;

procedure TQRPGrid.SetBrush(Value : TBrush);
begin
  If (Not (FFirstRowJoined or FFirstColumnJoined)) AND
     (Value.Color<>FBrush.Color) Then
    begin
      If FirstCellColor=FBrush.Color Then FirstCellColor:=Value.Color;
      If FirstColumnColor=FBrush.Color Then FirstColumnColor:=Value.Color;
      If FirstRowColor=FBrush.Color Then FirstRowColor:=Value.Color;
    end;
  FBrush.Assign(Value);
  Invalidate;
end;

procedure TQRPGrid.SetPen(Value : TPen);
begin
  FPen.Assign(value);
end;

procedure TQRPGrid.SetDrawFirstRowLine(Value: Boolean);
begin
  FDrawFirstRowLine:=Value;
  Invalidate;
end;
{
procedure TQRPGrid.SetFirstRowHeight(Value: Word);
begin
  FFirstRowHeight:=Value;
  Invalidate;
end;

procedure TQRPGrid.SetFirstColumnWidth(Value: Word);
begin
  FFirstColumnWidth:=Value;
  Invalidate;
end;
}

procedure TQRPGrid.SetFirstCellColor(Value: TColor);
begin
  Cells[0,0].Brush.Color:=Value;
  Invalidate;
end;

procedure TQRPGrid.SetFirstRowColor(Value: TColor);
var
  I: Integer;
begin
  For I:=1 to Columns-1 do
    Cells[I,0].Brush.Color:=Value;
  Invalidate;
end;

procedure TQRPGrid.SetFirstColumnColor(Value: TColor);
var
  I: Integer;
begin
  For I:=1 to Rows-1 do
    Cells[0,I].Brush.Color:=Value;
  Invalidate;
end;

function TQRPGrid.GetFirstColumnColor: TColor;
begin
  Result:=Cells[0,Rows-1].Brush.Color;

end;

function TQRPGrid.GetFirstRowColor: TColor;
begin
  Result:=Cells[Columns-1,0].Brush.Color;

end;

function TQRPGrid.GetFirstCellColor: TColor;
begin
  Result:=Cells[0,0].Brush.Color;
end;


procedure TQRPGrid.SetFirstColumnJoined(Value: Boolean);
begin
  FFirstColumnJoined:=Value;
  Invalidate;
end;

procedure TQRPGrid.SetFirstRowJoined(Value: Boolean);
begin
  FFirstRowJoined:=Value;
  Invalidate;
end;

procedure TQRPGrid.Paint;
var
  aRect: TRect;
  AllWidth, AllHeight,
  X, Y, Q, I, J,
  RestHeight, RestWidth, P, DX, DY: Integer;


  function GetColWidth(I: Integer): Integer;
  begin
    If I<FColumnSizes.Count Then
      Result:=StrToInt(FColumnSizes[I])
    Else
    If FColumnSizes.Count>0 Then
      Result:=Round(RestWidth/(Columns-FColumnSizes.Count))
    Else
      Result:=AllWidth DIV Columns;
  end;

  function GetRowHeight(I: Integer): Integer;
  begin
    If I<FRowSizes.Count Then
      Result:=StrToInt(FRowSizes[I])
    Else
    If FRowSizes.Count>0 Then
      Result:=Round(RestHeight/(Rows-FRowSizes.Count))
    Else
      Result:=AllHeight DIV Rows;
  end;

begin
  with Canvas do
    begin
      Pen := FPen;
      Brush := FBrush;


      AllWidth:=Width;
      If Frame.DrawLeft Then
        begin
          AllWidth:=AllWidth-Frame.Width;
          DX:=Frame.Width;
        end
      Else
        DX:=0;
      If Frame.DrawRight Then AllWidth:=AllWidth-Frame.Width;

      AllHeight:=Height;
      If Frame.DrawTop Then
        begin
          AllHeight:=AllHeight-Frame.Width;
          DY:=Frame.Width;
        end
      Else
        DY:=0;
      If Frame.DrawBottom Then AllHeight:=AllHeight-Frame.Width;

      RestWidth:=AllWidth;
      For X:=1 to FColumnSizes.Count Do RestWidth:=RestWidth-StrToInt(FColumnsizes[X-1]);
      RestHeight:=AllHeight;
      For X:=1 to FRowSizes.Count Do RestHeight:=RestHeight-StrToInt(FRowsizes[X-1]);

      If Not Transparent Then
        begin
          Q:=0;
          For I:=0 to Columns-1 Do
            begin
              P:=0;
              For J:=0 to Rows-1 Do
                begin
                  Brush.Assign(Cells[I,J].Brush);
                  FillRect(Rect(Q+DX,P+DY,Q+GetColWidth(I)+DX,P+GetRowHeight(J)+DY));
                  P:=P+GetRowHeight(J);
                end;
              Q:=Q+GetColWidth(I);
            end;
        end;

      If Rows>1 Then
        begin
          P:=0;
          For Y:=1 to Rows-1 Do
            begin
              P:=P+GetRowHeight(Y-1);
              If (Y<>1) OR DrawFirstRowLine Then
                begin
                  If FirstColumnJoined Then
                    MoveTo(GetColWidth(0)+DX,P+DY)
                  Else
                    MoveTo(0,P+DY);
                  LineTo(Width,P+DY);
                end;
            end;
        end;
      If Columns>1 Then
        begin
          P:=0;
          For X:=1 to Columns-1 Do
            begin
              P:=P+GetColWidth(X-1);
              If FirstRowJoined Then
                MoveTo(P+DX,GetRowHeight(0)+DY)
              Else
                MoveTo(P+DX,0);
              LineTo(P+DX,Height);
            end;
        end;
    end;
  PaintCorners;
  aRect := GetClientRect;
  dec(aRect.Bottom);
  dec(aRect.Right);
  TQRPFrame(Frame).PaintIt(Canvas, aRect, Screen.PixelsPerInch / 254 * Zoom/100, Screen.PixelsPerInch / 254 * Zoom/100);
end;

procedure TQRPGrid.Print(OfsX, OfsY: Integer);
var
  PX, PY, P,
  RestWidth,
  RestHeight,
  AllWidth,
  AllHeight  : Extended;
  X, Y       : Integer;
  DX, DY     : Extended;
  C          : TQRPGridCell;

  function GetColWidth(I: Integer): Extended;
  begin
    If I<FColumnSizes.Count Then
      Result:=StrToFloat(FColumnSizes[I]) / Screen.PixelsPerInch * 254
    Else
    If FColumnSizes.Count>0 Then
      Result:=RestWidth/(Columns-FColumnSizes.Count)
    Else
      Result:=AllWidth/Columns;
  end;

  function GetRowHeight(I: Integer): Extended;
  begin
    If I<FRowSizes.Count Then
      Result:=StrToFloat(FRowSizes[I]) / Screen.PixelsPerInch * 254
    Else
    If FRowSizes.Count>0 Then
      Result:=RestHeight/(Rows-FRowSizes.Count)
    Else
      Result:=AllHeight/Rows;
  end;

var
  AX, AY    : Real;
  ACaption  : String;
  ARect     : TRect;
  HA        : THorizAlignment;
  VA        : TVertAlignment;
  BKMode    : Integer;
  OrgHeight : Integer;

begin
  If (Columns=0) or (Rows=0) Then Exit;

  OrgHeight:=Height;

  if FixBottomPosition and (Parent is TQRCustomBand)then
    OfsY:=OfsY+Round(TQRTempBand(Parent).Expanded);
  if StretchHeightWithBand then
    Height:=Height+Round(TQRTempBand(Parent).Expanded*ParentReport.QRPrinter.YFactor);

  if ParentReport.FinalPass and Enabled then
    begin
      BKMode:=GetBKMode(QRPrinter.Canvas.Handle);
      If Transparent Then
        SetBkMode(QRPrinter.Canvas.Handle, 1)
      Else
        SetBkMode(QRPrinter.Canvas.Handle, 0);

      QRPrinter.Canvas.Brush := Brush;
      QRPrinter.Canvas.Pen := Pen;
      with QRPrinter, Canvas do
        begin

          {---- draw grid ---}
          If not Transparent Then
            FillRect(rect(XPos(OfsX + Size.Left),
                          YPos(OfsY + Size.Top),
                          XPos(OfsX+Size.Left + Size.Width),
                          YPos(OfsY + Size.Top + Size.Height)));
          AllWidth:=Size.Width;
          If Frame.DrawLeft Then
            begin
              AllWidth:=AllWidth-round(Frame.Width / Screen.PixelsPerInch * 254 );
              DX:=round(Frame.Width / Screen.PixelsPerInch * 254 );
            end
          Else
            DX:=0;
          If Frame.DrawRight Then AllWidth:=AllWidth-round(Frame.Width / Screen.PixelsPerInch * 254 );

          AllHeight:=Size.Height;
          If Frame.DrawTop Then
            begin
              AllHeight:=AllHeight-round(Frame.Width / Screen.PixelsPerInch * 254 );
              DY:=round(Frame.Width / Screen.PixelsPerInch * 254 );
            end
          Else
            DY:=0;
          If Frame.DrawBottom Then AllHeight:=AllHeight-round(Frame.Width / Screen.PixelsPerInch * 254 );

          RestWidth:=AllWidth;
          For X:=1 to FColumnSizes.Count Do RestWidth:=RestWidth-GetColWidth(X-1);
          RestHeight:=AllHeight;
          For X:=1 to FRowSizes.Count Do RestHeight:=RestHeight-GetRowHeight(X-1);

          If Not Transparent Then
            begin
              AX:=0;
              For X:=0 to Columns-1 Do
                begin
                  AY:=0;
                  For Y:=0 to Rows-1 Do
                    begin
                      Brush.Assign(Cells[X,Y].Brush);
                      FillRect(Rect(XPos(OfsX + Size.Left + AX + DX),
                                    YPos(OfsY + Size.Top + AY + DY),
                                    XPos(OfsX + Size.Left + AX + GetColWidth(X) + DX),
                                    YPos(OfsY + Size.Top + AY + GetRowHeight(Y) + DY)));
                      AY:=AY+GetRowHeight(Y);
                    end;
                  AX:=AX+GetColWidth(X);
                end;
            end;

          If Rows>1 Then
            begin
              P:=0;
              For Y:=1 to Rows-1 Do
                begin
                  P:=P+GetRowHeight(Y-1);
                  If (Y<>1) OR DrawFirstRowLine Then
                    begin
                      If FirstColumnJoined Then
                        MoveTo(XPos(OfsX + Size.Left + GetColWidth(0) + DX),
                               YPos(OfsY + Size.Top + P+DY))
                      Else
                        MoveTo(XPos(OfsX + Size.Left),
                               YPos(OfsY + Size.Top + P+DY));
                      LineTo(XPos(OfsX + Size.Left + Size.Width),
                             YPos(OfsY + Size.Top + P+DY));
                    end;
                end;
            end;
          If Columns>1 Then
            begin
              P:=0;
              For X:=1 to Columns-1 Do
                begin
                  P:=P+GetColWidth(X-1);
                  If FirstRowJoined Then
                    MoveTo(XPos(OfsX + Size.Left + P+DX),
                           YPos(OfsY + Size.Top + GetRowHeight(0)+DY))
                  Else
                    MoveTo(XPos(OfsX + Size.Left + P+DX),
                           YPos(OfsY + Size.Top));
                  LineTo(XPos(OfsX + Size.Left + P+DX),
                         YPos(OfsY + Size.Top + Size.Height));
                end;
            end;

          {--- draw cell captions ---}

          PX:=Pen.Width+CellBorderX;
          For X:=0 to Columns-1 Do
            begin
              PY:=Pen.Width+CellBorderY;
              For Y:=0 to Rows-1 Do
                begin
                  If Cells[X,Y].Caption<>'' Then
                    begin
                      C:=Cells[X,Y];
                      aCaption:=C.Caption;

                      AX := OfsX + Size.Left + PX + DX;
                      AY := OfsY + Size.Top + PY + DY;

                      If Not C.ParentFont Then Canvas.Font.Assign(C.Font)
                      Else Canvas.Font.Assign(Self.Font);

                      If C.HorizAlignment=haNone Then
                        HA:=CellHorizAlignment
                      Else
                        HA:=C.HorizAlignment;

                      aRect := Rect(XPos(AX),
                                    YPos(AY),
                                    XPos(AX - 2 * (Pen.Width + CellBorderX) + GetColWidth(X)),
                                    YPos(AY - 2 * (Pen.Width + CellBorderY) + GetRowHeight(Y)));

                      case HA of
                        haNone,
                        haLeft  : SetTextAlign(Canvas.Handle, TA_Left + TA_Top + TA_NoUpdateCP);
                        haRight : begin
                                    SetTextAlign(Canvas.Handle, TA_Right + TA_Top + TA_NoUpdateCP);
                                    AX := AX + GetColWidth(X) - 2 * (Pen.Width + CellBorderX);
                                    if fsItalic in Font.Style then
                                      AX := AX - (Self.ParentReport.TextWidth(Font, ' '));
                                  end;
                        haCenter: begin
                                    SetTextAlign(Canvas.Handle, TA_Center + TA_Top + TA_NoUpdateCP);
                                    AX := AX + (GetColWidth(X) - 2 * (Pen.Width + CellBorderX)) / 2;
                                  end;
                      end;

                      If C.VertAlignment=vaNone Then
                        VA:=CellVertAlignment
                      Else
                        VA:=C.VertAlignment;
                      Case VA of
                        vaNone,
                        vaTop    : ;
                        vaCenter : begin
                                     AY := AY + (aRect.Bottom-ARect.Top-Self.ParentReport.TextHeight(Font,'Yy'))
                                               /(2*Self.ParentReport.QRPrinter.YFactor);
                                   end;
                        vaBottom : begin
                                     AY := AY + (aRect.Bottom-ARect.Top-Self.ParentReport.TextHeight(Font,'Yy'))
                                               /(Self.ParentReport.QRPrinter.YFactor);
                                   end;
                      end;

                      Canvas.Brush.Assign(Cells[X,Y].Brush);
                      Canvas.Font.Assign(Cells[X,Y].Font);
                      ExtTextOut(Canvas.Handle, XPos(AX), YPos(AY),
                                 ETO_CLIPPED, @aRect, @aCaption[1], length(aCaption), nil);
                    end;
                  PY:=PY+GetRowHeight(Y);
                end;
              PX:=PX+GetColWidth(X);
            end;
        end;
      SetBkMode(QRPrinter.Canvas.Handle, BKMode)
    end;
  if ParentReport.FinalPass and Frame.AnyFrame then
    TQRPFrame(Frame).PaintIt(ParentReport.QRPrinter.Canvas,
      Rect(ParentReport.QRPrinter.XPos(OfsX + Size.Left),
      ParentReport.QRPrinter.YPos(OfsY + Size.Top),
      ParentReport.QRPrinter.XPos(OfsX + Size.Left + Size.Width),
      ParentReport.QRPrinter.YPos(OfsY + Size.Top + Size.Height)),
      ParentReport.QRPrinter.XFactor,
      ParentReport.QRPrinter.YFactor);

  Height:=OrgHeight;
end;


{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

constructor TQRPGridCell.Create;
begin
  Font:=TFont.Create;
  Brush:=TBrush.Create;
  ParentFont:=True;
end;

{--------------------------------------------------------------------------------}

destructor TQRPGridCell.Destroy;
begin
  Font.Free;
  Brush.Free;
  Inherited Destroy;
end;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

constructor TQRPCheckBox.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FPen:=TPen.Create;
  FBrush:=TBrush.Create;
  FBrush.Color:=clWhite;
  FBrush.OnChange:=StyleChanged;
  FPen.OnChange:=StyleChanged;
  FChecked:=True;
  Frame.DrawTop:=True;
  Frame.DrawLeft:=True;
  Frame.DrawBottom:=True;
  Frame.DrawRight:=True;
  Height:=17;
  Width:=17;
  Transparent:=False;
  FCtl3D:=False;
  FCheckmarkDistance:=3;
  FGlyphChecked := TPicture.Create;
  FGlyphUnchecked := TPicture.Create;
  FGlyphChecked.OnChange := PictureChanged;
  FGlyphUnchecked.OnChange := PictureChanged;
end;

{--------------------------------------------------------------------------------}

destructor TQRPCheckbox.Destroy;
begin
  FPen.Free;
  FBrush.Free;
  FGlyphChecked.Free;
  FGlyphUnchecked.Free;
  inherited Destroy;
end;

{--------------------------------------------------------------------------------}

procedure TQRPCheckbox.PictureChanged(Sender: TObject);
begin
  Invalidate;
end;

{--------------------------------------------------------------------------------}

procedure TQRPCheckBox.SetBrush(Value : TBrush);
begin
  FBrush.Assign(Value);
  Invalidate;
end;

{--------------------------------------------------------------------------------}

procedure TQRPCheckBox.SetGlyphChecked(Value: TPicture);
begin
  FGlyphChecked.Assign(Value);
  Invalidate;
end;

{--------------------------------------------------------------------------------}

procedure TQRPCheckBox.SetGlyphUnchecked(Value: TPicture);
begin
  FGlyphUnchecked.Assign(Value);
  Invalidate;
end;

{--------------------------------------------------------------------------------}

procedure TQRPCheckBox.SetCheckmarkDistance(Value: Word);
begin
  FCheckmarkDistance:=Value;
  Invalidate;
end;

{--------------------------------------------------------------------------------}

procedure TQRPCheckBox.SetCheckmarkType(Value: TQRPCheckmarkType);
begin
  FCheckmarkType:=Value;
  Invalidate;
end;

{--------------------------------------------------------------------------------}

procedure TQRPCheckBox.SetPen(Value : TPen);
begin
  FPen.Assign(Value);
  Invalidate;
end;

{--------------------------------------------------------------------------------}

procedure TQRPCheckBox.SetChecked(Value : boolean);
begin
  if Value <> FChecked then
  begin
    FChecked := Value;
    Invalidate;
  end;
end;

{--------------------------------------------------------------------------------}

procedure TQRPCheckBox.SetCtl3D(Value : boolean);
begin
  FCtl3D := Value;
  Invalidate;
end;

{--------------------------------------------------------------------------------}

procedure TQRPCheckBox.Paint;
var
  Dest, aRect: TRect;
begin
  Canvas.Pen:=FPen;
  Canvas.Brush:=FBrush;
  with Canvas do
    begin
      If not Transparent Then FillRect(ClientRect);
      If FCtl3d Then
        begin
          Canvas.Pen.Color:=clGray;
          Canvas.Pen.Width:=1;
          Canvas.Pen.Style:=psSolid;
          MoveTo(Frame.Width,Frame.Width);
          LineTo(Width-Frame.Width,Frame.Width);
          MoveTo(Frame.Width,Frame.Width);
          LineTo(Frame.Width,Height-Frame.Width);
          Canvas.Pen.Color:=clSilver;
          MoveTo(Frame.Width+1,Frame.Width+1);
          LineTo(Width-Frame.Width,Frame.Width+1);
          MoveTo(Frame.Width+1,Frame.Width+1);
          LineTo(Frame.Width+1,Height-Frame.Width);
          Canvas.Pen:=FPen;
        end;
      if Checked then
        begin
          If CheckmarkType=cmCross Then
            begin
              MoveTo(FCheckMarkDistance, FCheckMarkDistance);
              LineTo(Width - FCheckMarkDistance, Height - FCheckMarkDistance);
              If Pen.Width=1 Then
                begin
                  MoveTo(FCheckMarkDistance, Height - FCheckMarkDistance -1);
                  LineTo(Width - FCheckMarkDistance, FCheckMarkDistance -1);
                end
              Else
                begin
                  MoveTo(FCheckMarkDistance, Height - FCheckMarkDistance);
                  LineTo(Width - FCheckMarkDistance, FCheckMarkDistance);
                end
            end
          Else
          If CheckmarkType=cmHook Then
            begin
              MoveTo(FCheckmarkDistance,((Height-2*FCheckMarkDistance) DIV 2)+FCheckmarkDistance);
              LineTo(((Width-2*FCheckMarkDistance) DIV 3)+FCheckmarkDistance,Height-FCheckmarkDistance);
              LineTo(Width-FCheckmarkDistance,FCheckmarkDistance);
            end
          Else
          If CheckmarkType=cmGlyph Then
            begin
              Dest := ClientRect;
              Dest.Left:=Dest.Left+CheckmarkDistance;
              Dest.Top:=Dest.Top+CheckmarkDistance;
              Dest.Bottom:=Dest.Bottom-CheckmarkDistance;
              Dest.Right:=Dest.Right-CheckmarkDistance;
              if Zoom <> 100 then
                begin
                  Dest.Right := Dest.Left + (Dest.Right - Dest.Left) * Zoom div 100;
                  Dest.Bottom := Dest.Top + (Dest.Bottom - Dest.Top) * Zoom div 100;
                end;
              with inherited Canvas do
                StretchDraw(Dest, GlyphChecked.Graphic);
            end;
        end
      Else {checked=false}
        begin
          If CheckmarkType=cmGlyph then
            begin
              Dest := ClientRect;
              Dest.Left:=Dest.Left+CheckmarkDistance;
              Dest.Top:=Dest.Top+CheckmarkDistance;
              Dest.Bottom:=Dest.Bottom-CheckmarkDistance;
              Dest.Right:=Dest.Right-CheckmarkDistance;
              if Zoom <> 100 then
                begin
                  Dest.Right := Dest.Left + (Dest.Right - Dest.Left) * Zoom div 100;
                  Dest.Bottom := Dest.Top + (Dest.Bottom - Dest.Top) * Zoom div 100;
                end;
              with inherited Canvas do
                StretchDraw(Dest, GlyphUnchecked.Graphic);
            end;
        end;
    end;
  PaintCorners;
  aRect := GetClientRect;
  dec(aRect.Bottom);
  dec(aRect.Right);
  TQRPFrame(Frame).PaintIt(Canvas, aRect, Screen.PixelsPerInch / 254 * Zoom/100, Screen.PixelsPerInch / 254 * Zoom/100);
end;

{--------------------------------------------------------------------------------}

  procedure PrintBitmap(aCanvas : TCanvas; Dest : TRect; Bitmap : TBitmap);
  var
    Info : PBitmapInfo;
{$IFDEF VER120}
    InfoSize : DWord;
{$ELSE}
    InfoSize : integer;
{$ENDIF}
    Image : Pointer;
    ImageSize : DWord;
  begin
    with Bitmap do
    begin
      GetDIBSizes(Handle, InfoSize, ImageSize);
      Info := AllocMem(InfoSize);
      try
        Image := AllocMem(ImageSize);
        try
          GetDIB(Handle, Palette, Info^, Image^);
          if not Monochrome then
            SetStretchBltMode(ACanvas.Handle, STRETCH_DELETESCANS);
          with Info^.bmiHeader do
            StretchDIBits(aCanvas.Handle, Dest.Left, Dest.Top,
              Dest.RIght - Dest.Left, Dest.Bottom - Dest.Top,
              0, 0, biWidth, biHeight, Image, Info^, DIB_RGB_COLORS, SRCCOPY);
        finally
          FreeMem(Image, ImageSize);
        end;
      finally
        FreeMem(Info, InfoSize);
      end;
    end;
  end;

{--------------------------------------------------------------------------------}

procedure TQRPCheckBox.Print(OfsX, OfsY : integer);
var
  cmDist: Extended;
  Dest: TRect;
  OrgHeight     : Integer;
  
begin
  OrgHeight:=Height;

  if FixBottomPosition and (Parent is TQRCustomBand)then
    OfsY:=OfsY+Round(TQRTempBand(Parent).Expanded);
  if StretchHeightWithBand then
    Height:=Height+Round(TQRTempBand(Parent).Expanded*ParentReport.QRPrinter.YFactor);

  if ParentReport.FinalPass and Enabled then
    begin
      QRPrinter.Canvas.Brush := Brush;
      QRPrinter.Canvas.Pen := Pen;
      with QRPrinter do
        begin
          with Canvas do
            begin
              If not Transparent Then
                FillRect(rect(XPos(OfsX + Size.Left),
                              YPos(OfsY + Size.Top),
                              XPos(OfsX + Size.Left + Size.Width),
                              YPos(OfsY + Size.Top + Size.Height)));
              If FCtl3d Then
                begin
                  QRPrinter.Canvas.Pen.Color:=clGray;
                  QRPrinter.Canvas.Pen.Width:=1;
                  QRPrinter.Canvas.Pen.Style:=psSolid;
                  MoveTo(XPos(OfsX + Size.Left + (Frame.Width/ Screen.PixelsPerInch * 254)),
                         YPos(OfsY + Size.Top + (Frame.Width/ Screen.PixelsPerInch * 254)));
                  LineTo(XPos(OfsX + Size.Left + Size.Width-(Frame.Width/ Screen.PixelsPerInch * 254)),
                         YPos(OfsY + Size.Top + (Frame.Width/ Screen.PixelsPerInch * 254)));
                  MoveTo(XPos(OfsX + Size.Left + (Frame.Width/ Screen.PixelsPerInch * 254)),
                         YPos(OfsY + Size.Top + (Frame.Width/ Screen.PixelsPerInch * 254)));
                  LineTo(XPos(OfsX + Size.Left + (Frame.Width/ Screen.PixelsPerInch * 254)),
                         YPos(OfsY + Size.Top + Size.Height-(Frame.Width/ Screen.PixelsPerInch * 254)));
                  QRPrinter.Canvas.Pen.Color:=clSilver;
                  MoveTo(XPos(OfsX + Size.Left + ((Frame.Width+1)/ Screen.PixelsPerInch * 254)),
                         YPos(OfsY + Size.Top + ((Frame.Width+1)/ Screen.PixelsPerInch * 254)));
                  LineTo(XPos(OfsX + Size.Left + Size.Width-(Frame.Width/ Screen.PixelsPerInch * 254)),
                         YPos(OfsY + Size.Top + ((Frame.Width+1)/ Screen.PixelsPerInch * 254)));
                  MoveTo(XPos(OfsX + Size.Left + ((Frame.Width+1)/ Screen.PixelsPerInch * 254)),
                         YPos(OfsY + Size.Top + ((Frame.Width+1)/ Screen.PixelsPerInch * 254)));
                  LineTo(XPos(OfsX + Size.Left + ((Frame.Width+1)/ Screen.PixelsPerInch * 254)),
                         YPos(OfsY + Size.Top + Size.Height-(Frame.Width/ Screen.PixelsPerInch * 254)));
                  QRPrinter.Canvas.Pen:=FPen;
                end;

              cmdist:=FCheckmarkDistance / Screen.PixelsPerInch * 254;
              if Checked then
                begin
                  If CheckmarkType=cmCross Then
                    begin
                      MoveTo(XPos(OfsX + Size.Left + cmdist),
                             YPos(OfsY + Size.Top + cmdist));
                      LineTo(XPos(OfsX + Size.Left + Size.Width - cmdist),
                             YPos(OfsY + Size.Top + Size.Height - cmdist));
                     (* If Pen.Width=1 Then
                        begin
                          MoveTo(XPos(OfsX + Size.Left + cmdist),
                                 YPos(OfsY + Size.Top + Size.Height - cmdist -(1/ 72 * 254)));
                          LineTo(XPos(OfsX + Size.Left + Size.Width - cmdist),
                                 YPos(OfsY + Size.Top + cmdist - (1 / 72 * 254)));
                        end
                      Else*)
                        begin
                          MoveTo(XPos(OfsX + Size.Left + cmdist),
                                 YPos(OfsY + Size.Top + Size.Height - cmdist ));
                          LineTo(XPos(OfsX + Size.Left + Size.Width - cmdist),
                                 YPos(OfsY + Size.Top + cmdist ));
                        end
                    end
                  Else
                  If CheckmarkType=cmHook Then
                    begin
                      MoveTo(XPos(OfsX + Size.Left + cmdist),
                             YPos(OfsY + Size.Top + ((Size.Height-2*cmdist)/2)+cmdist));
                      LineTo(XPos(OfsX + Size.Left + ((Size.Width-2*cmdist)/3)+cmdist),
                             YPos(OfsY + Size.Top + Size.Height-cmdist));
                      LineTo(XPos(OfsX + Size.Left + Size.Width-cmdist),
                             YPos(OfsY + Size.Top + cmdist));
                    end
                  Else
                  If CheckmarkType=cmGlyph Then
                    begin
                      Dest.Top := QRPrinter.YPos(OfsY + Size.Top + cmdist);
                      Dest.Left := QRPrinter.XPos(OfsX + Size.Left + cmdist);
                      Dest.Right := QRPrinter.XPos(OfsX + Size.Width + Size.Left - cmdist);
                      Dest.Bottom := QRPrinter.YPos(OfsY + Size.Height + Size.Top - cmdist);
                      if GlyphChecked.Graphic is TBitmap then
                        PrintBitmap(QRPrinter.Canvas, Dest, TBitmap(GlyphChecked.Graphic))
                      else
                        with QRPrinter.Canvas do
                          StretchDraw(Dest, GlyphChecked.Graphic);
                    end;
                end
              Else {checked=false}
                begin
                  If CheckmarkType=cmGlyph then
                    begin
                      Dest.Top := QRPrinter.YPos(OfsY + Size.Top + cmdist);
                      Dest.Left := QRPrinter.XPos(OfsX + Size.Left + cmdist);
                      Dest.Right := QRPrinter.XPos(OfsX + Size.Width + Size.Left - cmdist);
                      Dest.Bottom := QRPrinter.YPos(OfsY + Size.Height + Size.Top - cmdist);
                      if GlyphUnchecked.Graphic is TBitmap then
                        PrintBitmap(QRPrinter.Canvas, Dest, TBitmap(GlyphUnchecked.Graphic))
                      else
                        with QRPrinter.Canvas do
                          StretchDraw(Dest, GlyphUnchecked.Graphic);
                    end;
                end;
            end;
        end;
    end;
  if ParentReport.FinalPass and Frame.AnyFrame then
    TQRPFrame(Frame).PaintIt(ParentReport.QRPrinter.Canvas,
      Rect(ParentReport.QRPrinter.XPos(OfsX + Size.Left),
      ParentReport.QRPrinter.YPos(OfsY + Size.Top),
      ParentReport.QRPrinter.XPos(OfsX + Size.Left + Size.Width),
      ParentReport.QRPrinter.YPos(OfsY + Size.Top + Size.Height)),
      ParentReport.QRPrinter.XFactor,
      ParentReport.QRPrinter.YFactor);

  Height:=OrgHeight;
end;

{--------------------------------------------------------------------------------}

procedure TQRPCheckbox.StyleChanged(Sender : TObject);
begin
  Invalidate;
end;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

procedure TQRPExprCheckbox.Print(OfsX, OfsY : integer);
var
  OrgHeight     : Integer;
  
begin
  OrgHeight:=Height;

  if FixBottomPosition and (Parent is TQRCustomBand)then
    OfsY:=OfsY+Round(TQRTempBand(Parent).Expanded);
  if StretchHeightWithBand then
    Height:=Height+Round(TQRTempBand(Parent).Expanded*ParentReport.QRPrinter.YFactor);

  Checked:=EvalBoolExpression(Expression, TQuickRep(ParentReport));
  Inherited Print(OfsX, OfsY);
  Checked:=True;

  Height:=OrgHeight;
end;

{--------------------------------------------------------------------------------}

constructor TQRPExprCheckbox.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  Checked:=True;
end;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

function Max_Int(I1,I2: Integer): Integer;
begin
  If I1>I2 Then Result:=I1 Else Result:=I2;
end;

procedure TQRPBand.SetBounds(ALeft, ATop, AWidth, AHeight: integer);
var
  j, OldHeight: Integer;
begin
  If Not InSetBounds Then OldHeight:=Height Else OldHeight:=-1;
  InSetBounds:=True;
  Inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if OldHeight>=0 Then
  if {(csDesigning in ComponentState) and} (AHeight<>OldHeight) then
    for j := 1 to ControlCount do
      begin
        if GetBooleanProperty(Controls[j-1],'FixBottomPosition') then
          Controls[j-1].Top:=Max_Int(0,Controls[j-1].Top+Height-OldHeight);
        if GetBooleanProperty(Controls[j-1],'StretchHeightWithBand') then
          Controls[j-1].Height:=Max_Int(0,Controls[j-1].Height+Height-OldHeight);
      end;
  InSetBounds:=False;
end;

procedure TQRPBand.BandBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  X: Integer;
begin
  If DisabledControls<>NIL Then
    begin
      For X:=1 to DisabledControls.Count Do
        SetBooleanProperty(DisabledControls[X-1],'Enabled',True);
      DisabledControls.Free;
      DisabledControls:=NIL;
    end;
  PrintBand:=EvalBoolExpression(Expression, TQuickRep(ParentReport));
  If (Not PrintBand) and (AlwaysUseSpace) Then
    begin
      DisabledControls:=TList.Create;
      For X:=1 to Sender.ControlCount Do
        If GetBooleanProperty(Sender.Controls[X-1],'Enabled') Then
          begin
            SetBooleanProperty(Sender.Controls[X-1],'Enabled',False);
            DisabledControls.Add(Sender.Controls[X-1]);
          end;
      PrintBand:=True;
    end;
  If Not PrintBand Then Exit;
  If Assigned(FOldBeforePrint) Then BeforePrint(Self, PrintBand);
end;

{--------------------------------------------------------------------------------}

constructor TQRPBand.Create(AOwner : TComponent);
begin
  Inherited Create(AOwner);
  Inherited BeforePrint:=BandBeforePrint;
  DisabledControls:=NIL;
end;

{--------------------------------------------------------------------------------}

destructor TQRPBand.Destroy;
begin
  DisabledControls.Free;
  Inherited Destroy;
end;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

constructor TQRPChildBand.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  Inherited BeforePrint:=BandBeforePrint;
  LastPage:=0;
end;

{--------------------------------------------------------------------------------}

procedure TQRPChildBand.BandBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  CRows: Integer;
begin
  PrintBand:=EvalBoolExpression(Expression, TQuickRep(ParentReport));
  If Not PrintBand Then Exit;
  If LastPage<>TQuickrep(Parent).Pagenumber Then
    begin
      PagePrints:=1;
      LastPage:=TQuickrep(Parent).Pagenumber;
    end
  else
    PagePrints:=PagePrints+1;
  If (Name='RowSpace') and (ParentBand<>NIL) Then
    With TQRPQuickrep(Parent) Do
      begin
        CRows:=Round((Page.Length-Page.TopMargin-Page.BottomMargin+Size.Height)
              /(Size.Height+ParentBand.Size.Height));
        If LastPage=1 Then
          PrintBand:=((PagePrints+(LabelSettings.FirstLabel-1)) MOD CRows)<>0
        else
          PrintBand:=(PagePrints MOD CRows)<>0
      end;
  If Assigned(FOldBeforePrint) Then BeforePrint(Self, PrintBand);
end;

{--------------------------------------------------------------------------------}

procedure TQRPChildBand.SetBounds(ALeft, ATop, AWidth, AHeight: integer);
var
  j, OldHeight: Integer;
begin
  If Not InSetBounds Then OldHeight:=Height Else OldHeight:=-1;
  InSetBounds:=True;
  Inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if OldHeight>=0 Then
  if {(csDesigning in ComponentState) and} (Height<>OldHeight) then
    for j := 1 to ControlCount do
      begin
        if GetBooleanProperty(Controls[j-1],'FixBottomPosition') then
          Controls[j-1].Top:=Max_Int(0,Controls[j-1].Top+Height-OldHeight);
        if GetBooleanProperty(Controls[j-1],'StretchHeightWithBand') then
          Controls[j-1].Height:=Max_Int(0,Controls[j-1].Height+Height-OldHeight);
      end;
  InSetBounds:=False;
end;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

type
  TQRPDBGrid = class(TDBGrid)
  end;

{------------------------------------------------------------------------------}

constructor TQRAbstractGridReport.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  PrintGridLines:=True;
  FSelectedRecordsOnly:=False;
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateGroupClass(AOwner: TComponent): TQRGroup;
begin
  Result:=TQRGroup.Create(AOwner);
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateSubdetailClass(AOwner: TComponent): TQRSubdetail;
begin
  Result:=TQRSubdetail.Create(AOwner);
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateBandClass(AOwner: TComponent): TQRBand;
begin
  Result:=TQRPBand.Create(AOwner);
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateReportClass(AOwner: TComponent): TQuickRep;
begin
  Result:=TQuickRep.Create(AOwner);
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateSysDataClass(AOwner: TComponent): TQRSysdata;
begin
  Result:=TQRSysData.Create(AOwner);
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateLabelClass(AOwner: TComponent): TQRLabel;
begin
  Result:=TQRPLabel.Create(AOwner);
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateDBTextClass(AOwner: TComponent): TQRDBText;
begin
  Result:=TQRPDBText.Create(AOwner);
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateShapeClass(AOwner: TComponent): {$IFDEF QREXPORTS2} TQRPDFShape {$ELSE} TQRShape {$ENDIF};
begin
  {$IFDEF QREXPORTS2}
  Result:=TQRPDFShape.Create(AOwner);
  {$ELSE}
  Result:=TQRPShape.Create(AOwner);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateExprClass(AOwner: TComponent): TQRExpr;
begin
  Result:=TQRPExpr.Create(AOwner);
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateBand(Quickrep: TQuickrep;
                                          BandType: TQRBandType;
                                          Height: Integer): TQRBand;
begin
  Result:=CreateBandClass(QuickRep.Owner);
  Result.Parent:=QuickRep;
  Result.BandType:=BandType;
  Result.Height:=Height;
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateSubdetail(Quickrep: TQuickrep;
                                               Height: Integer): TQRSubdetail;
begin
  Result:=CreateSubdetailClass(QuickRep.Owner);
  Result.Parent:=QuickRep;
  Result.Height:=Height;
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateGroup(Quickrep: TQuickrep;
                                           Height: Integer): TQRGroup;
begin
  Result:=CreateGroupClass(QuickRep.Owner);
  Result.Parent:=QuickRep;
  Result.Height:=Height;
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateReport(AParent: TComponent): TQuickRep;
begin
  Result:=CreateReportClass(AParent.Owner);
  Result.Parent:=TWinControl(AParent);
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateSysdata(ParentBand: TCustomPanel;
                                             Left, Top: Integer;
                                             Datatype: TQRSysDataType): TQRSysData;
begin
  Result:=CreateSysDataClass(Parentband.Owner);
  Result.Parent:=Parentband;
  Result.Name:=FindUniqueComponentName(TForm(Parentband.Owner),'QRSysData',False);
  Result.Top:=Top;
  Result.Left:=Left;
  Result.Data:=qrsDate;
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateLabel(ParentBand: TCustomPanel;
                                           Left, Top: Integer): TQRLabel;
begin
  Result:=CreateLabelClass(ParentBand.Owner);
  Result.Parent:=ParentBand;
  Result.Name:=FindUniqueComponentName(TForm(ParentBand.Owner),'QRLabel',False);
  Result.Top:=Top;
  Result.Left:=Left;
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateExpr(ParentBand: TCustomPanel;
                                          Left, Top: Integer): TQRExpr;
begin
  Result:=CreateExprClass(QuickRep.Owner);
  Result.Parent:=ParentBand;
  Result.Name:=FindUniqueComponentName(TForm(ParentBand.Owner),'QRExpr',False);
  Result.Top:=Top;
  Result.Left:=Left;
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateDBText(ParentBand: TCustomPanel;
                                            Left, Top: Integer): TQRDBText;
begin
  Result:=CreateDBTextClass(ParentBand.Owner);
  Result.Parent:=ParentBand;
  Result.Name:=FindUniqueComponentName(TForm(ParentBand.Owner),'QRDBText',False);
  Result.Top:=Top;
  Result.Left:=Left;
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateShape(ParentBand: TCustomPanel;
                                   ShapeType: TQRShapeType;
                                   Left, Top, Width, Height: Integer;
                                   Color: TColor): {$IFDEF QREXPORTS2} TQRPDFShape {$ELSE} TQRShape {$ENDIF};
var
  S: {$IFDEF QREXPORTS2} TQRPDFShape {$ELSE} TQRShape {$ENDIF};
begin
  S:=CreateShapeClass(ParentBand.Owner);
  S.Parent:=ParentBand;
  {$IFDEF QREXPORTS2}
  S.ShapeType:=ShapeType;
  {$ELSE}
  S.Shape:=ShapeType;
  {$ENDIF}
  S.Top:=Top;
  S.Left:=Left;
  S.Width:=Width;
  S.Height:=Height;
  S.Name:=FindUniqueComponentName(TForm(ParentBand.Owner),'Shape',False);
  S.Pen.Color:=Color;
  Result:=S;
end;

{------------------------------------------------------------------------------}

procedure TQRAbstractGridReport.PrintReport(DefaultReport: TQuickRep {$IFDEF VER110} = nil {$ENDIF});
var
  aForm: TForm;
  aReport, QR: TQuickRep;
  TL: TList;
  X: Integer;
  DoCancel: Boolean;
begin
  If DefaultReport=NIL Then
    begin
      aForm:=TForm.Create(Owner);
      aReport:=CreateReport(aForm);
      aReport.Name:='QuickReport';
      TL:=NIL;
    end
  Else
    begin
      aForm:=TForm(DefaultReport.Owner);
      aReport:=DefaultReport;
      TL:=TList.Create;
      For X:=0 to aForm.ComponentCount-1 Do TL.Add(aForm.Components[X]);
    end;
  QR:=QuickRep;
  QuickRep:=aReport;
  CreateReportFromGrid;
  DoCancel:=False;
  If Assigned(FAfterReportFormCreated) Then
    AfterReportFormCreated(aForm, aReport, DoCancel);
  If Not DoCancel Then aReport.Print;
  If DefaultReport=NIL Then aForm.Free
  Else
    begin
      For X:=aForm.ComponentCount-1 DownTo 0 Do
        If TL.IndexOf(aForm.Components[X])=-1 Then aForm.Components[X].Free;
      TL.Free;
    end;
  QuickRep:=QR;
end;

{------------------------------------------------------------------------------}

{$IFDEF QR36}

function TQRAbstractGridReport.GetPreviewHeight: Integer;
begin
  if FPreviewHeight>0 then Result:=FPreviewHeight else Result:=500;
end;

{--------------------------------------------------------------------------------}

function TQRAbstractGridReport.GetPreviewWidth: Integer;
begin
  if FPreviewWidth>0 then Result:=FPreviewWidth else Result:=500;
end;

{$ENDIF}

{------------------------------------------------------------------------------}

procedure TQRAbstractGridReport._PreviewReport(DefaultReport: TQuickRep; Modal: Boolean);
var
  aForm: TForm;
  aReport, QR: TQuickRep;
  TL: TList;
  X: Integer;
  DoCancel: Boolean;
begin
  If DefaultReport=NIL Then
    begin
      aForm:=TForm.Create(Owner);
      aReport:=CreateReport(aForm);
      aReport.Name:='QuickReport';
      {$IFDEF QR36}
      aReport.PrevFormStyle:=FPrevFormStyle;
      aReport.PreviewInitialState:=FPreviewInitialState;
      aReport.PreviewWidth:=FPreviewWidth;
      aReport.PreviewHeight:=FPreviewHeight;
      {$ENDIF}
      TL:=NIL;
    end
  Else
    begin
      aForm:=TForm(DefaultReport.Owner);
      aReport:=DefaultReport;
      TL:=TList.Create;
      For X:=0 to aForm.ComponentCount-1 Do TL.Add(aForm.Components[X]);
    end;
  QR:=QuickRep;
  QuickRep:=aReport;
  CreateReportFromGrid;
  DoCancel:=False;
  If Assigned(FAfterReportFormCreated) Then
    AfterReportFormCreated(aForm, aReport, DoCancel);
  If Not DoCancel Then
    begin
      {$IFDEF QR3}
      If Modal Then aReport.PreviewModal Else
      {$ENDIF}
      aReport.Preview;
    end;
  If DefaultReport=NIL Then aForm.Free
  Else
    begin
      For X:=aForm.ComponentCount-1 DownTo 0 Do
        If TL.IndexOf(aForm.Components[X])=-1 Then aForm.Components[X].Free;
      TL.Free;
    end;
  QuickRep:=QR;
end;

{------------------------------------------------------------------------------}

procedure TQRAbstractGridReport.PreviewReport(DefaultReport: TQuickRep {$IFDEF VER110} = nil {$ENDIF});
begin
  _PreviewReport(DefaultReport,False);
end;

{------------------------------------------------------------------------------}

{$IFDEF QR3}
procedure TQRAbstractGridReport.PreviewReportModal(DefaultReport: TQuickRep {$IFDEF VER110} = nil {$ENDIF});
begin
  _PreviewReport(DefaultReport,True);
end;
{$ENDIF}

{------------------------------------------------------------------------------}

procedure TQRGridReport.DetailBandBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:=FDBGrid.SelectedRows.CurrentRowSelected;
end;

{------------------------------------------------------------------------------}

function TQRAbstractGridReport.CreateReportFromGrid: Boolean;
begin
  Result:=True;
end;

{------------------------------------------------------------------------------}

procedure TQRAbstractGridReport.CreateTitle;
var
  DB  : TQRBand;
  LBL : TQRLabel;
begin
  If (FReportTitle='') and (Not FReportTitleDate) Then Exit;
  DB:=CreateBand(QuickRep, rbTitle, 50);
  DB.Name:=FindUniqueComponentName(TForm(QuickRep.Owner),'Title',True);
  If ReportTitle<>'' Then
    begin
      LBL:=CreateLabel(DB,0,0);
      LBL.Caption:=ReportTitle;
      LBL.Font.Size:=20;
    end;
  If FReportTitleDate then CreateSysData(DB, DB.Width-80, 0, qrsDate);
end;

{-----------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

{$IFNDEF VER100}
function ReplaceUnderscore(S: String): String;
var
  I: Integer;
begin
  For I:=1 to Length(S) Do
    If S[I]='_' Then S[I]:=' ';
  Result:=S;
end;
{$ENDIF}

{-----------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

{$IFNDEF VER110}

function Min(I1, I2: Integer): Integer;
begin
  If I1<I2 Then
    Result:=I1
  else
    Result:=I2;
end;

{--------------------------------------------------------------------------------}

function Max(I1, I2: Integer): Integer;
begin
  If I1>I2 Then
    Result:=I1
  else
    Result:=I2;
end;

{$ENDIF}

{------------------------------------------------------------------------------}

function TQRGridReport.CreateReportFromGrid: Boolean;
var
  DB, TB: TQRBand;
  GB: TQRGroup;
  DBS: TQRSubdetail;
  SHP: {$IFDEF QREXPORTS2} TQRPDFShape {$ELSE} TQRShape {$ENDIF};
  DX: Longint;
  {$IFNDEF VER100}
  DD, Y: Integer;
  {$ENDIF}
  X: Integer;
  DSet: TDataset;
  NextColumn      : Integer;
  PageFirstColumn : Integer;
  ColWidth        : Integer;
  BandCounter     : Integer;

  procedure CreateDetailbandDatafield;
  var
    QRP: TQRPrintable;
  begin
    If FUseExprForDatafields Then
      begin
        QRP:=CreateExpr(DB,DX+3,3);
        TQRExpr(QRP).Expression:=DBGrid.Columns[X].FieldName;
        TQRExpr(QRP).Font.Assign(DBGrid.Columns[X].Font);
      end
    Else
      begin
        QRP:=CreateDBText(DB, DX+3, 3);
        TQRDBText(QRP).Dataset:=DSet;
        TQRDBText(QRP).Datafield:=DBGrid.Columns[X].FieldName;
        TQRDBText(QRP).Font.Assign(DBGrid.Columns[X].Font);
      end;
    DX:=DX+DBGrid.Columns[X].Width;
    QRP.Width:=Max_Int(0,DBGrid.Columns[X].Width-5);
    SetBooleanProperty(QRP,'AutoSize',False);
    SetBooleanProperty(QRP,'WordWrap',False);
    SetIntegerProperty(QRP,'Alignment',Integer(DBGrid.Columns[X].Alignment));
    SetIntegerProperty(QRP,'Color',DBGrid.Columns[X].Color);
    SetBooleanProperty(QRP,'Transparent',True);
    SetBooleanProperty(QRP,'AutoStretch',FAutoStretchMemos);
  end;

  procedure CreateHorizontalGridline;
  var
    X: Integer;
  begin
    {--- calculate total width of columns ---}
    DX:=0;
    For X:=NextColumn to DBGrid.Columns.Count-1 Do
      begin
        If DX+3+DBGrid.Columns[X].Width+1>DB.Width Then Break;
        DX:=DX+DBGrid.Columns[X].Width;
      end;
    {--- create horizontal grid line ---}
    SHP:=CreateShape(DB, qrsHorLine, 0, DB.Height-1, DX+1, 1, clGray);
    SHP.BringToFront;
  end;

  procedure CreateDetailband;
  var
    TmpBand: TQRBand;
  begin
    If SpanPagesHorizontally Then
      begin
        Quickrep.Dataset:=NIL;
        DBS:=CreateSubdetail(Quickrep,TQRPDBGrid(DBGrid).DefaultRowHeight);
        DBS.Dataset:=DSet;
        If BandCounter>1 Then
          begin
            TmpBand:=CreateBand(QuickRep, rbGroupHeader, 0);
            TmpBand.ForceNewPage:=True;
            If (FReportTitle<>'') or FReportTitleDate Then TmpBand.Height:=50;
            TmpBand.Name:=FindUniqueComponentName(TForm(QuickRep.Owner),'NewPageBand',True);
            DBS.HeaderBand:=TmpBand;
          end;
        DB:=TQRBand(DBS);
        DB.Name:=FindUniqueComponentName(TForm(QuickRep.Owner),'SubdetailBand',True);
      end
    else
      begin
        QuickRep.Dataset:=DSet;
        DB:=CreateBand(QuickRep, rbDetail, TQRPDBGrid(DBGrid).DefaultRowHeight);
        DB.Name:=FindUniqueComponentName(TForm(QuickRep.Owner),'DetailBand',True);
      end;

    If FSelectedRecordsOnly Then
      begin
        FDBGrid.SelectedRows.Refresh;
        DB.BeforePrint:=DetailBandBeforePrint;
      end;

    If PrintGridLines Then
      begin
        DB.Frame.Color:=clGray;
        DB.Frame.Width:=1;
        If dgColLines in DBGrid.Options Then DB.Frame.DrawLeft:=True;
        If dgRowLines in DBGrid.Options Then CreateHorizontalGridLine;
      end;
  end;

  procedure CreateHeaderLabel;
  var
    LBL: TQRLabel;
  begin
    LBL:=CreateLabel(TB,DX+3,3);
    LBL.Font.Assign(DBGrid.Columns[X].Title.Font);
    LBL.Caption:=DBGrid.Columns[X].Title.Caption;
    LBL.Color:=DBGrid.Columns[X].Title.Color;
    LBL.Alignment:=DBGrid.Columns[X].Title.Alignment;
    LBL.AutoSize:=False;
    LBL.WordWrap:=False;
    LBL.Width:=Max_Int(0,ColWidth{-5});
    LBL.Transparent:=True;
  end;

begin
  Result:=False;
  NextColumn:=0;
  If (QuickRep=NIL) or (DBGrid=NIL) or
     (DBGrid.Datasource=NIL) or
     (DBGrid.Datasource.Dataset=NIL) Then Exit;
  DSet:=DBGrid.Datasource.Dataset;

  CreateTitle;
  BandCounter:=0;
  Repeat
    Inc(BandCounter);
    CreateDetailBand;

    (*If DBGrid.Color<>clWhite Then
      begin
        SHP:=CreateShape(DB, qrsRectangle, 0, 0, DX+1, DB.Height+1, DBGrid.Color);
        SHP.Brush.Color:=DBGrid.Color;
        SHP.SendToBack;
      end;*)

    PageFirstColumn:=NextColumn;

    {--- create detailband data fields ---}
    DX:=0;
    For X:=PageFirstColumn to DBGrid.Columns.Count-1 Do
      begin
        {$IFDEF VER110}
        If DBGrid.Columns[X].Visible Then
        {$ENDIF}
          begin
            If DX+3+DBGrid.Columns[X].Width+1>DB.Width Then Break;
            CreateDetailbandDatafield;
            If (PrintGridLines) and (dgColLines in DBGrid.Options) Then
              CreateShape(DB, qrsVertLine, DX, 0, 1, DB.Height, clGray);
          end;
        Inc(NextColumn);
      end;

    If dgTitles in DBGrid.Options Then
      begin
        {--- create header band ---}
        If SpanPagesHorizontally Then
          begin
            GB:=CreateGroup(Quickrep,TQRPDBGrid(DBGrid).RowHeights[0]);
            GB.Master:=DB;
            {$IFDEF QR3}
            GB.ReprintOnNewPage:=True;
            {$ENDIF}
            TB:=TQRBand(GB);
          end
        else
          begin
            TB:=CreateBand(QuickRep, rbColumnHeader, TQRPDBGrid(DBGrid).RowHeights[0]);
          end;
        TB.Name:=FindUniqueComponentName(TForm(QuickRep.Owner),'ColumnHeader',True);
        DX:=0;

        For X:=PageFirstColumn to DBGrid.Columns.Count-1 Do
          begin
            {$IFDEF VER110}
            If DBGrid.Columns[X].Visible Then
            {$ENDIF}
              begin
                {--- max column width is band width - 4 --- }
                ColWidth:=Min(DBGrid.Columns[X].Width,TB.Width-4);
                {--- stop if element would be past right band edge ---}
                If DX+3+ColWidth+1>TB.Width Then Break;
                CreateHeaderLabel;
                DX:=DX+ColWidth;
                If (PrintGridLines) and (dgColLines in DBGrid.Options) Then
                  CreateShape(TB, qrsVertLine, DX, 0, 1, TB.Height, clGray);
              end;
          end;

        SHP:=CreateShape(TB, qrsRectangle, 0, 0, DX+1, TB.Height, DBGrid.FixedColor);
        SHP.Brush.Color:=DBGrid.FixedColor;
        SHP.SendToBack;

        If PrintGridLines Then
          begin
            TB.Frame.Color:=clGray;
            TB.Frame.Width:=1;
            if dgRowLines in DBGrid.Options Then
              begin
                CreateShape(TB, qrsHorLine, 0, 0, DX+1, 1, clGray);
                CreateShape(TB, qrsHorLine, 0, TB.Height-1, DX+1, 1, clGray);
              end;
            If dgColLines in DBGrid.Options Then TB.Frame.DrawLeft:=True;
          end;
      end;

  until (SpanPagesHorizontally=FALSE) or
        (NextColumn>DBGrid.Columns.Count-1);
  Result:=True;
end;

{--------------------------------------------------------------------------------}

procedure TQRGridReport.Notification(AComponent: TComponent; Operation: TOperation);
begin
  Inherited Notification(AComponent, Operation);
  If (Operation=opRemove) and (AComponent=FQuickRep) Then QuickRep:=NIL
  Else
  If (Operation=opRemove) and (AComponent=FDBGrid) Then DBGrid:=NIL;
end;

{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

procedure TQRStringgridReport.DetailBandBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:=True;
end;

{------------------------------------------------------------------------------}

procedure TQRStringgridReport.NeedData(Sender: TObject; var MoreData: Boolean);
var
  L: TQRPLabel;
  I: Integer;
begin
  For I:=0 to Stringgrid.ColCount Do
    begin
      L:=TQRPLabel(QuickRep.Owner.FindComponent('Col'+IntToStr(I)+'Label'));
      If L<>NIL Then
        L.Caption:=Stringgrid.Cells[I,CurrentRow];
    end;
  Inc(CurrentRow);
  MoreData:=CurrentRow<Stringgrid.RowCount;
  If CurrentRow=Stringgrid.RowCount Then CurrentRow:=StringGrid.FixedRows;
end;

{------------------------------------------------------------------------------}

function TQRStringgridReport.CreateReportFromGrid: Boolean;
var
  DB, TB: TQRBand;
  LBL: TQRLabel;
  SHP: {$IFDEF QREXPORTS2} TQRPDFShape {$ELSE} TQRShape {$ENDIF};
  DX: Longint;
  X: Integer;

begin
  Result:=False;
  CurrentRow:=StringGrid.FixedRows;
  If (QuickRep=NIL) or (StringGrid=NIL) Then Exit;
  QuickRep.OnNeedData:=NeedData;
  If StringGrid.FixedRows>0 Then
    begin
      TB:=CreateBand(QuickRep, rbColumnHeader, StringGrid.RowHeights[0]);
      TB.Name:=FindUniqueComponentName(TForm(QuickRep.Owner),'ColumnHeader',True);
      DX:=0;
      For X:=0 to StringGrid.ColCount-1 Do
        begin
          LBL:=CreateLabel(TB,DX+3,3);
          LBL.Font.Assign(StringGrid.Font);
          LBL.Caption:=StringGrid.Cells[X,0];
          DX:=DX+StringGrid.ColWidths[X];
          LBL.AutoSize:=False;
          LBL.WordWrap:=False;
          LBL.Width:=Max_Int(0,StringGrid.ColWidths[X]-5);
          LBL.Transparent:=True;
          If PrintGridLines and (goVertLine in Stringgrid.Options) Then
            CreateShape(TB, qrsVertLine, DX, 0, 1, TB.Height, clGray);
        end;

      SHP:=CreateShape(TB, qrsRectangle, 0, 0, DX+1, TB.Height, StringGrid.FixedColor);
      SHP.Brush.Color:=StringGrid.FixedColor;
      SHP.SendToBack;

      TB.Frame.Color:=clGray;
      TB.Frame.Width:=1;
      If PrintGridLines and (goHorzLine in StringGrid.Options) Then
        begin
          CreateShape(TB, qrsHorLine, 0, 0, DX+1, 1, clGray);
          CreateShape(TB, qrsHorLine, 0, TB.Height-1, DX+1, 1, clGray);
        end;
      If PrintGridLines and (goVertLine in StringGrid.Options) Then TB.Frame.DrawLeft:=True;
    end;
  DB:=CreateBand(QuickRep, rbDetail, StringGrid.DefaultRowHeight);

  DB.BeforePrint:=DetailBandBeforePrint;
  DB.Name:=FindUniqueComponentName(TForm(QuickRep.Owner),'DetailBand',True);
  DB.Frame.Color:=clGray;
  DB.Frame.Width:=1;
  DX:=0;
  For X:=0 to StringGrid.ColCount-1 Do
    DX:=DX+StringGrid.ColWidths[X];
  If (PrintGridLines) and (goHorzLine in StringGrid.Options) Then
    begin
      SHP:=CreateShape(DB, qrsHorLine, 0, DB.Height-1, DX+1, 1, clGray);
      SHP.BringToFront;
    end;
  If PrintGridLines and (goVertLine in StringGrid.Options) Then DB.Frame.DrawLeft:=True;
  DX:=0;

  For X:=0 to StringGrid.ColCount-1 Do
    begin
      LBL:=CreateLabel(DB,DX+3,3);
      LBL.Name:='Col'+IntToStr(X)+'Label';
      LBL.Font.Assign(Stringgrid.Font);
      LBL.Caption:=LBL.Name;
      DX:=DX+Stringgrid.ColWidths[X];
      LBL.AutoSize:=False;
      LBL.WordWrap:=False;
      LBL.Width:=Max_Int(0,Stringgrid.ColWidths[X]-5);
      LBL.Color:=Stringgrid.Color;
      LBL.Transparent:=True;

      If X<StringGrid.FixedCols Then
        begin
          SHP:=CreateShape(DB, qrsRectangle, 0, 0, StringGrid.FixedCols*StringGrid.ColWidths[X], DB.Height, StringGrid.FixedColor);
          SHP.Brush.Color:=StringGrid.FixedColor;
          SHP.Brush.Style:=bsSolid;
          SHP.SendToBack;
        end;

      If (PrintGridLines) and (goVertLine in Stringgrid.Options) Then
        CreateShape(DB, qrsVertLine, DX, 0, 1, DB.Height, clGray);
    end;
  Result:=True;
end;

{--------------------------------------------------------------------------------}

procedure TQRStringgridReport.Notification(AComponent: TComponent; Operation: TOperation);
begin
  Inherited Notification(AComponent, Operation);
  If (Operation=opRemove) and (AComponent=FQuickRep) Then QuickRep:=NIL
  Else
  If (Operation=opRemove) and (AComponent=FStringGrid) Then StringGrid:=NIL;
end;

{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

{$IFNDEF Registered}
xxx
begin
  If FindWindow('TAppBuilder',NIL)=0 Then
    begin
      MessageDlg('UNREGISTERED QUICKREPORT 2+3 POWERPACK  - '
              +'This shareware version will only run if the Delphi IDE is loaded!',mtinformation,[mbok],0);
      Halt;
    end;
{$ENDIF}
end.


