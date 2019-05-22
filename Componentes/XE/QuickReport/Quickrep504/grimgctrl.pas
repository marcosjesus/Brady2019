unit grimgctrl;
////////////////////////////////////////////////////////////////////////////
//  Unit : grimgctrl.pas
//
//  (c) 2007 QBS Software
//  TQRPrintable -> TQRGrDBImage
//  TQRPrintable -> TQRGrImage
//  TQRPrintable -> TQRHRule
//  TQRPrintable -> TCustomHTMLLabel -> TQRHTMLLabel
//
//  New image controls - export to HTML and PDF export filters
//  New Hyper-text label
//  New Horizontal rule added FVertAdjust property
//  New PDFShape control
//  14th Nov. Changed Print method to scale images when 'stretch' is false.
//  18th Nov . Added keepwidth and keepheight
//  24th nov. - Fixed bug in Keeps.!!!
//  25th nov replaced keeps with FitMode
//  11th Jan 02 added another FitMode - InsideProp
//  2005/11/08  Put centering for KeepHeight, KeepWidth
//  Revision to v4 of QR
//  24/10/2007 added fitmode to QRGrImage
//  Revision to v5 of QR
////////////////////////////////////////////////////////////////////////////
interface
uses messages, windows, classes, controls, stdctrls,sysutils, graphics, buttons,
     forms, extctrls, dialogs, printers, db, ComCtrls, RichEdit,
     QRPrntr, Quickrpt, QR5Const, qrexpr, qrctrls, qrlabled;

const
  BreakChars : set of Char = [' ', #13, '-'];
type

  TQRFixFrame = class(TQRFrame);

  TLinkDef = ( ldHTTPJump, ldNameJump, ldNameLabel );
  TFitMode = ( fmProportional, fmKeepWidth, fmKeepHeight, fmInsideProp );
{ TQRCustomHTMLLabel - base class for printable HTML text components }
  TQRCustomHTMLLabel = class(TQRPrintable)
  private
    FCaptionBased : boolean;
    DoneFormat : boolean;
    FAutoSize : boolean;
    FAutoStretch : boolean;
    FCaption : string;
    FPrintCaption : string;
    FFontSize : integer;
    FFormattedLines : TStrings;
    FLines : TStrings;
    FOnPrint : TQRLabelOnPrintevent;
    FWordWrap : boolean;
    FShowOnDocs : boolean;
    UpdatingBounds : boolean;
    function GetCaption : string;
    function GetCaptionBased : boolean; virtual;
    procedure SetAutoStretch(Value : boolean);
    procedure SetCaption(Value : string);
    procedure SetLines(Value : TStrings);
    procedure SetWordWrap(Value : boolean);
    procedure PaintToCanvas(aCanvas : TCanvas; aRect : TRect; CanExpand : boolean; LineHeight : integer);
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    procedure PrintToCanvas(aCanvas : TCanvas; aLeft, aTop, aWidth, aHeight, LineHeight : extended;
                            CanExpand : boolean); virtual;
    procedure FormatLines; virtual;
    procedure Loaded; override;
    procedure SetName(const Value: TComponentName); override;
    procedure SetParent(AParent: TWinControl); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadFontSize(Reader : TReader); virtual;
    procedure WriteFontSize(Writer : TWriter); virtual;
    procedure Paint; override;
    procedure Prepare; override;
    procedure UnPrepare; override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure SetAlignment(Value : TAlignment); override;
    property OnPrint : TQRLabelOnPrintEvent read FOnPrint write FOnPrint;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function GetControlsAlignment: TAlignment; override;
    property CaptionBased : boolean read GetCaptionBased;
    property Alignment;
    property AutoSize : boolean read FAutoSize write FAutoSize;
    property AutoStretch : boolean read FAutoStretch write SetAutoStretch;
    property Caption : string read GetCaption write SetCaption stored true;
    property Color;
    property Font;
    property Lines : TStrings read FLines write SetLines;
    property WordWrap : boolean read FWordWrap write SetWordWrap;
    property ShowOnDocs : boolean read FShowOnDocs write FShowOnDocs;
  end;

  TQRHTMLLabel = class(TQRCustomHTMLLabel)
  protected
    function GetEditorClass : TQRPrintableEditorClass; override;
    procedure PrintToCanvas(aCanvas : TCanvas; aLeft, aTop, aWidth, aHeight,
                        LineHeight : extended; CanExpand : boolean);override;
  public
     FFlashColor : TColor;
     FLinkText : string;
     FLinkType : TLinkDef;
  published
    // 4 new
    property Flashcolor : TColor read FFlashcolor write FFlashcolor;
    property LinkText : string read FLinkText write FLinkText;
    property LinkType : TLinkDef read FLinkType write FLinkType;
    // inherited
    property Alignment;
    property AlignToBand;
    property AutoSize;
    property AutoStretch;
    property BiDiMode;
    property ParentBiDiMode;
    property Caption;
    property Color;
    property Font;
    property OnPrint;
    property ParentFont;
    property Transparent;
    property WordWrap;
    property ShowOnDocs;
  end;

  TQRHRule = class(TQRPrintable)
  private
    FBrush : TBrush;
    FPen : TPen;
    FVertAdjust : integer;
    procedure SetBrush(Value : TBrush);
    procedure SetPen(Value : TPen);
  protected
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure StyleChanged(sender : TObject);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property VertAdjust : integer read FVertAdjust write FVertAdjust;
    property Brush : TBrush read FBrush write SetBrush;
    property Height default 10;
    property Pen : TPen read FPen write Setpen;
    property Width default 100;
  end;

  {TQRPDFShape}
  TQRPDFShape = class(TQRPrintable)
  private
    FBrush : TBrush;
    FPen : TPen;
    FVertAdjust : integer;
    FShapeType : TQRShapetype;
    procedure SetBrush(Value : TBrush);
    procedure SetPen(Value : TPen);
  protected
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure StyleChanged(sender : TObject);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property VertAdjust : integer read FVertAdjust write FVertAdjust;
    property Brush : TBrush read FBrush write SetBrush;
    property ShapeType : TQRShapetype read FShapeType write FShapeType;
    property Height default 10;
    property Pen : TPen read FPen write Setpen;
    property Width default 100;
  end;

{ TQRGrImage }
  TQRGrImage = class(TQRPrintable)
  private
    FPicture: TPicture;
    FAutoSize: Boolean;
    FStretch: Boolean;
    FCenter: Boolean;
    FClipImage : Boolean;
    FFitMode : TFitMode;
    function GetCanvas: TCanvas;
    procedure PictureChanged(Sender: TObject);
    procedure SetCenter(Value: Boolean);
    procedure SetPicture(Value: TPicture);
    procedure SetStretch(Value: Boolean);
  protected
    procedure SetAutoSize(Value: Boolean);override;
    function GetPalette: HPALETTE; override;
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas: TCanvas read GetCanvas;
  published
    property ClipImage: Boolean read FClipImage write FClipImage default False;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
    property Center: Boolean read FCenter write SetCenter default False;
    property Picture: TPicture read FPicture write SetPicture;
    property Stretch: Boolean read FStretch write SetStretch default False;
    property FitMode : TFitMode read FFitMode write FFitMode default fmProportional;
  end;
  { TQRGrDBImage }
  TQRGrDBImage = class(TQRPrintable)
  private
    FField : TField;
    FDataSet : TDataSet;
    FDataField : string;
    FPicture: TPicture;
    FStretch: boolean;
    FCenter: boolean;
    FPictureLoaded: boolean;
    FClipImage : Boolean;
    FKeepWidth : Boolean;
    FKeepHeight : Boolean;
    FFitMode : TFitMode;
    procedure PictureChanged(Sender: TObject);
    procedure SetCenter(Value: Boolean);
    procedure SetDataField(const Value: string);
    procedure SetDataSet(Value: TDataSet);
    procedure SetPicture(Value: TPicture);
    procedure SetStretch(Value: Boolean);
  protected
    function GetPalette: HPALETTE; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Prepare; override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure UnPrepare; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadPicture;
    property Field: TField read FField;
    property Picture: TPicture read FPicture write SetPicture;
  published
    property Center: boolean read FCenter write SetCenter default True;
    property DataField: string read FDataField write SetDataField;
    property DataSet: TDataSet read FDataSet write SetDataSet;
    property Stretch: boolean read FStretch write SetStretch default False;
    property ClipImage: Boolean read FClipImage write FClipImage default False;
    property FitMode : TFitMode read FFitMode write FFitMode default fmProportional;
  end;

implementation
uses QRWebFilt, QRPDFfilt;

{ TQRHRule }
constructor TQRHRule.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  width := 100;
  Height := 10;
  FVertAdjust := 0;
  FPen := TPen.Create;
  FBrush := TBrush.Create;
  FBrush.OnChange := StyleChanged;
  FPen.OnChange := StyleChanged;
end;

procedure TQRHRule.StyleChanged(Sender : TObject);
begin
  invalidate;
end;

procedure TQRHRule.SetBrush(Value : TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TQRHRule.SetPen(Value : TPen);
begin
  FPen.Assign(value);
end;

procedure TQRHRule.Paint;
begin
  inherited paint;
  with Canvas do
  begin
    Pen := FPen;
    Brush := FBrush;
    MoveTo(0,Height div 2);
    LineTo(Width,Height div 2);
  end;
end;

procedure TQRHRule.Print(OfsX,OfsY : Integer);
begin
  if parentreport.Exporting then
  begin
         // alter ypos to be same as moveto...
         if (ParentReport.ExportFilter is TQRGHTMLDocumentFilter) then
         TQRGHTMLDocumentFilter(ParentReport.ExportFilter).acceptgraphic(
                              qrprinter.XPos(OfsX + self.Size.Left),
                              qrprinter.YPos(OfsY + self.size.top), self )
         else if (ParentReport.ExportFilter is TQRPDFDocumentFilter) then
         TQRPDFDocumentFilter(ParentReport.ExportFilter).acceptgraphic(
                              qrprinter.XPos(OfsX + self.Size.Left),
                              qrprinter.YPos(OfsY+ self.size.top ), self );
  end;


  if ParentReport.FinalPass and IsEnabled then
  begin
    QRPrinter.Canvas.Brush := Brush;
    QRPrinter.Canvas.Pen := Pen;
    with QRPrinter do
    begin
      with Canvas do
      begin
          MoveTo(XPos(OfsX + Size.Left), YPos(OfsY + Size.Top + self.size.height/2));
          LineTo(XPos(OfsX + Size.Left + Size.Width),YPos(OfsY + Size.Top+ self.size.height/2));
        end;
      end;
    end;
end;

destructor TQRHRule.Destroy;
begin
  FPen.Free;
  FBrush.Free;
  inherited Destroy;
end;

{ TQRPDFShape }
constructor TQRPDFShape.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  width := 100;
  Height := 10;
  FVertAdjust := 0;
  FPen := TPen.Create;
  FBrush := TBrush.Create;
  FBrush.OnChange := StyleChanged;
  FPen.OnChange := StyleChanged;
end;

procedure TQRPDFShape.StyleChanged(Sender : TObject);
begin
  invalidate;
end;

procedure TQRPDFShape.SetBrush(Value : TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TQRPDFShape.SetPen(Value : TPen);
begin
  FPen.Assign(value);
end;
procedure TQRPDFShape.Paint;
begin
  inherited paint;
  with Canvas do
  begin
    Pen := FPen;
    Brush := FBrush;
    Case FShapeType of
      qrsRectangle : Rectangle(pen.width,pen.width,Width,Height);
      qrsCircle : Ellipse(0,0,Width,Height);
      qrsHorLine : begin
          MoveTo(0,Height div 2);
          LineTo(Width,Height div 2);
        end;
      qrsVertLine : begin
          MoveTo(Width div 2,0);
          LineTo(Width div 2,Height);
        end;
      qrsTopAndBottom : begin
          MoveTo(0,0);
          LineTo(Width,0);
          MoveTo(0,Height-1);
          LineTo(Width,Height-1);
        end;
      qrsRightAndLeft : begin
          MoveTo(0,0);
          LineTo(0,Height);
          MoveTo(Width-1,0);
          LineTo(Width-1,Height);
        end;
    end
  end
end;

procedure TQRPDFShape.Print(OfsX,OfsY : Integer);
begin
  if parentreport.Exporting and IsEnabled then
  begin
         if (ParentReport.ExportFilter is TQRPDFDocumentFilter) then
         TQRPDFDocumentFilter(ParentReport.ExportFilter).acceptgraphic(
                              qrprinter.XPos(OfsX + self.Size.Left),
                              qrprinter.YPos(OfsY+ self.size.top ), self );
  end;

  if ParentReport.FinalPass and IsEnabled then
  begin
    QRPrinter.Canvas.Brush := Brush;
    QRPrinter.Canvas.Pen := Pen;
    with qrprinter do begin
      with canvas do begin
       case FShapetype of
          qrsRectangle : Rectangle(XPos(OfsX + Size.Left), YPos(OfsY + Size.Top),
            XPos(OfsX+Size.Left + Size.Width), YPos(OfsY + Size.Top + Size.Height));
          qrsCircle : Ellipse(XPos(OfsX + Size.Left), YPos(OfsY + Size.Top),
            XPos(OfsX+Size.Left + Size.Width), YPos(OfsY + Size.Top + Size.Height));
          qrsHorLine : begin
              MoveTo(XPos(OfsX + Size.Left), YPos(OfsY + Size.Top + Size.Height / 2));
              LineTo(XPos(OfsX + Size.Left + Size.Width),YPos(OfsY + Size.Top + Size.Height/2));
            end;
          qrsVertLine : begin
              MoveTo(XPos(OfsX+Size.Left + Size.Width / 2), YPos(OfsY + Size.Top));
              LineTo(XPos(OfsX+Size.Left + Size.Width / 2), Ypos(OfsY + Size.Height + Size.Top));
            end;
          qrsTopAndBottom : begin
              MoveTo(XPos(OfsX + Size.Left), YPos(OfsY + Size.Top));
              LineTo(Xpos(OfsX + Size.Left + Size.Width), YPos(OfsY + Size.Top));
              MoveTo(Xpos(OfsX + Size.Left), YPos(OfsY + Size.Top + Size.Height));
              LineTo(Xpos(OfsX + Size.Left + Size.Width), Ypos(OfsY + Size.Top + Size.Height));
            end;
          qrsRightAndLeft : Begin
              MoveTo(XPos(OfsX + Size.Left), YPos(OfsY + Size.Top));
              LineTo(Xpos(OfsX + Size.Left), YPos(OfsY + Size.Top + Size.Height));
              MoveTo(XPos(OfsX + Size.Left + Size.Width), YPos(OfsY + Size.Top));
              LineTo(XPos(OfsX + Size.Left + Size.Width), YPos(OfsY + Size.Top + Size.Height));
            end;
        end
       end;
      end;
     end;
end;

destructor TQRPDFShape.Destroy;
begin
  FPen.Free;
  FBrush.Free;
  inherited Destroy;
end;

{ TQRGRImage }
  procedure PrintBitmap(aCanvas : TCanvas; Dest : TRect; Bitmap : TBitmap);
  var
    Info : PBitmapInfo;
    InfoSize : DWORD;
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

constructor TQRGRImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  Height := 105;
  Width := 105;
end;

destructor TQRGRImage.Destroy;
begin
  FPicture.Free;
  inherited Destroy;
end;

function TQRGRImage.GetPalette: HPALETTE;
begin
  Result := 0;
  if FPicture.Graphic is TBitmap then
    Result := TBitmap(FPicture.Graphic).Palette;
end;

procedure TQRGRImage.Paint;
var
  Dest: TRect;
begin
  if csDesigning in ComponentState then
    with inherited Canvas do
    begin
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(0, 0, Width, Height);
    end;
  if Stretch then
    Dest := ClientRect
  else if Center then
    Dest := Bounds((Width - Picture.Width) div 2, (Height - Picture.Height) div 2,
      Picture.Width, Picture.Height)
  else
    Dest := Rect(0, 0, Picture.Width, Picture.Height);
  if Zoom <> 100 then
  begin
    Dest.Right := Dest.Left + (Dest.Right - Dest.Left) * Zoom div 100;
    Dest.Bottom := Dest.Top + (Dest.Bottom - Dest.Top) * Zoom div 100;
  end;
  with inherited Canvas do
    StretchDraw(Dest, Picture.Graphic);
//  Inherited Paint;
end;

procedure TQRGRImage.Print(OfsX,OfsY : Integer);
var
  Dest : TRect;
  DC, SavedDC : THandle;
  FKeepHeight, FKeepWidth : boolean;
  drawpict : TBitmap;
  coffset : integer;
  aspectratio, xc : double;
begin
  Dest.Top := QRPrinter.YPos(OfsY + Size.Top);
  Dest.Left := QRPrinter.XPos(OfsX + Size.Left);
  Dest.Right := QRPrinter.XPos(OfsX + Size.Width + Size.Left);
  Dest.Bottom := QRPrinter.YPos(OfsY + Size.Height + Size.Top);
  //adjust the rectangle
  FKeepHeight := false;
  FKeepWidth := false;
  if not FStretch and (FPicture.Graphic is TBitmap) then
  begin
      // adjust dest rect to keep aspect ratio of picture
      AspectRatio := 1.0 * FPicture.Bitmap.Width / FPicture.Bitmap.height;
      drawpict := self.FPicture.Bitmap;
      if FFitMode=fmKeepWidth then
                FKeepWidth := true
      else if FFitMode=fmKeepHeight then
                FKeepHeight := true
      else if FFitMode=fmInsideprop then
      begin
             // picture must shrink or grow to fit control
             if (drawpict.Width/self.width) < (drawpict.Height/self.Height) then
             begin
                  // the height ratio is greater so shrink the width and center horiz
                  coffset := dest.right-dest.left;
                  Dest.Right := QRPrinter.XPos(OfsX + Size.Left)
                            + round(drawpict.width/(drawpict.Height/self.Height));
                  coffset := ( coffset + dest.left-dest.right) div 2;
                  dest.left := dest.left + coffset;
                  dest.right := dest.right + coffset;
             end
             else
             begin
                  coffset := dest.bottom-dest.top;
                  Dest.Bottom := QRPrinter.YPos(OfsY + Size.Top)
                                  + round(drawpict.Height/(drawpict.Width/self.width));
                  coffset := ( coffset - dest.bottom+dest.top) div 2;
                  dest.top := dest.top + coffset;
                  dest.Bottom := dest.Bottom + coffset;
             end;
     end
     else // fmProportional : control grows to fit picture
     begin
             if (drawpict.Width/self.width) < (drawpict.Height/self.Height) then
             begin
                 FKeepWidth := true;
                 FKeepHeight := false;
             end
             else
             begin
                 FKeepWidth := false;
                 FKeepHeight := true;
             end;
     end;
     if FKeepWidth then
     begin
                 Dest.Bottom := QRPrinter.YPos(OfsY + (Size.width/aspectratio) + Size.Top);
                 if Center then
                 begin
                     xc := (Drawpict.Height - self.Height) / 2.0;
                     dest.Top := dest.Top - round(xc);
                     dest.Bottom := dest.Bottom - round(xc);
                 end;
     end
     else if FKeepHeight then
     begin
                 Dest.Right := QRPrinter.XPos(OfsX + (Size.height*aspectratio) + Size.Left);
                 if Center then
                 begin
                     xc := (Drawpict.Width - self.Width) / 2.0;
                     dest.Left := dest.Left - round(xc);
                     dest.Right := dest.Right - round(xc);
                 end;
     end;
  end;

  if Stretch then
  begin
    if Picture.Graphic is TBitmap then
      PrintBitmap(QRPrinter.Canvas, Dest, TBitmap(Picture.Graphic))
    else
      with QRPrinter.Canvas do
        StretchDraw(Dest, Picture.Graphic);
  end else
  begin
    IntersectClipRect(QRPrinter.Canvas.Handle, Dest.Left, Dest.Top, Dest.Right, Dest.Bottom);
    DC := GetDC(QRPrinter.Canvas.Handle);
    SavedDC := SaveDC(DC);
    if FClipImage then
    begin
      Dest.Right := Dest.Left +
        round(Picture.Width / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.XFactor);
      Dest.Bottom := Dest.Top +
        round(Picture.Height / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.YFactor);
      if Center then OffsetRect(Dest,
        (QRPrinter.XSize(Size.Width) -
        round(Picture.Width / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.XFactor)) div 2,
        (QRPrinter.YSize(Size.Height) -
        round(Picture.Height / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.YFactor)) div 2);
    end;
    if Picture.Graphic is TBitmap then
      PrintBitmap(QRPrinter.Canvas, Dest, TBitmap(Picture.Graphic))
    else
      QRPrinter.Canvas.StretchDraw(Dest, Picture.Graphic);
   RestoreDC(DC, SavedDC);
   SelectClipRgn(QRPrinter.Canvas.Handle, 0);
  end;
  inherited Print(OfsX,OfsY);
  if parentreport.Exporting then
  begin
         ParentReport.ExportFilter.acceptgraphic(
                              qrprinter.XPos(OfsX + self.Size.Left),
                              qrprinter.YPos(OfsY + self.Size.Top), self );
  end;
end;

function TQRGRImage.GetCanvas: TCanvas;
var
  Bitmap: TBitmap;
begin
  if Picture.Graphic = nil then
  begin
    Bitmap := TBitmap.Create;
    try
      Bitmap.Width := Width;
      Bitmap.Height := Height;
      Picture.Graphic := Bitmap;
    finally
      Bitmap.Free;
    end;
  end;
  if Picture.Graphic is TBitmap then
    Result := TBitmap(Picture.Graphic).Canvas
  else
    Result := nil;
{    raise EInvalidOperation.CreateRes(SImageCanvasNeedsBitmap)};
end;

procedure TQRGRImage.SetAutoSize(Value: Boolean);
begin
  FAutoSize := Value;
  PictureChanged(Self);
end;

procedure TQRGRImage.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    PictureChanged(Self);
  end;
end;

procedure TQRGRImage.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TQRGRImage.SetStretch(Value: Boolean);
begin
  if Value <> FStretch then
  begin
    FStretch := Value;
    PictureChanged(Self);
  end;
end;

procedure TQRGRImage.PictureChanged(Sender: TObject);
begin
  if AutoSize and (Picture.Width > 0) and (Picture.Height > 0) then
    SetBounds(Left, Top, Picture.Width, Picture.Height);
  if (Picture.Graphic is TBitmap) and (Picture.Width >= Width) and
    (Picture.Height >= Height) then
    ControlStyle := ControlStyle + [csOpaque] else
    ControlStyle := ControlStyle - [csOpaque];
  Invalidate;
end;
{ TQRGrDBImage }
constructor TQRGrDBImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csFramed, csOpaque];
  Width := 105;
  Height := 105;
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  FCenter := True;
end;

destructor TQRGrDBImage.Destroy;
begin
  FPicture.Free;
  inherited Destroy;
end;

procedure TQRGrDBImage.Prepare;
begin
  inherited Prepare;
  if assigned(FDataSet) then
  begin
    FField := DataSet.FindField(FDataField);
    if Field is TBlobField then
    begin
      Caption := '';
    end;
  end else
    FField := nil;
end;

procedure TQRGrDBImage.Print(OfsX, OfsY : integer);
var
  H, coffset : integer;
  Dest: TRect;
  DrawPict: TPicture;
  aspectratio, xc : double;
begin
  with QRPrinter.Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := Color;
    DrawPict := TPicture.Create;
    H := 0;
    try
      if assigned(FField) and (FField is TBlobField) then
      begin
        DrawPict.Assign(FField);
        AspectRatio := 1.0 * drawpict.Graphic.Width / drawpict.Graphic.height;
        if (DrawPict.Graphic is TBitmap) and
          (DrawPict.Bitmap.Palette <> 0) then
        begin
          H := SelectPalette(Handle, DrawPict.Bitmap.Palette, false);
          RealizePalette(Handle);
        end;
        Dest.Left := QRPrinter.XPos(OfsX + Size.Left);
        Dest.Top := QRPrinter.YPos(OfsY + Size.Top);
        Dest.Right := QRPrinter.XPos(OfsX + Size.Width + Size.Left);
        Dest.Bottom := QRPrinter.YPos(OfsY + Size.Height + Size.Top);
        FKeepHeight := false;
        FKeepWidth := false;
        if not FStretch then
        begin
          // adjust dest rect to keep aspect ratio of picture
          if FFitMode=fmKeepWidth then
                FKeepWidth := true
          else if FFitMode=fmKeepHeight then
                FKeepHeight := true
          else if FFitMode=fmInsideprop then
          begin
             // picture must shrink or grow to fit control
             if (drawpict.Width/self.width) < (drawpict.Height/self.Height) then
             begin
                  // the height ratio is greater so shrink the width and center horiz
                  coffset := dest.right-dest.left;
                  Dest.Right := QRPrinter.XPos(OfsX + Size.Left)
                            + round(drawpict.width/(drawpict.Height/self.Height));
                  coffset := ( coffset + dest.left-dest.right) div 2;
                  dest.left := dest.left + coffset;
                  dest.right := dest.right + coffset;
             end
             else
             begin
                  coffset := dest.bottom-dest.top;
                  Dest.Bottom := QRPrinter.YPos(OfsY + Size.Top)
                                  + round(drawpict.Height/(drawpict.Width/self.width));
                  coffset := ( coffset - dest.bottom+dest.top) div 2;
                  dest.top := dest.top + coffset;
                  dest.Bottom := dest.Bottom + coffset;
             end;
          end
          else // fmProportional : control grows to fit picture
          begin
             if (drawpict.Width/self.width) < (drawpict.Height/self.Height) then
             begin
                 FKeepWidth := true;
                 FKeepHeight := false;
             end
             else
             begin
                 FKeepWidth := false;
                 FKeepHeight := true;
             end;
          end;
          if FKeepWidth then
          begin
                 Dest.Bottom := QRPrinter.YPos(OfsY + (Size.width/aspectratio) + Size.Top);
                 if Center then
                 begin
                     xc := (Drawpict.Height - self.Height) / 2.0;
                     dest.Top := dest.Top - round(xc);
                     dest.Bottom := dest.Bottom - round(xc);
                 end;
          end
          else if FKeepHeight then
          begin
                 Dest.Right := QRPrinter.XPos(OfsX + (Size.height*aspectratio) + Size.Left);
                 if Center then
                 begin
                     xc := (Drawpict.Width - self.Width) / 2.0;
                     dest.Left := dest.Left - round(xc);
                     dest.Right := dest.Right - round(xc);
                 end;
          end;
        end;

        if Stretch then
        begin
          if (DrawPict.Graphic = nil) or DrawPict.Graphic.Empty then
            FillRect(Dest)
          else
              QRPrinter.Canvas.StretchDraw(Dest, DrawPict.Graphic);
        end
        else
        begin // stretch is false
          IntersectClipRect(Handle, Dest.Left, Dest.Top, Dest.Right, Dest.Bottom);
          if FClipImage then
          begin
            Dest.Right := Dest.Left +
              round(DrawPict.Width / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.XFactor);
            Dest.Bottom := Dest.Top +
            round(DrawPict.Height / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.YFactor);
            if Center then
             OffsetRect(Dest, (  QRPrinter.XSize(Size.Width) -
              round(DrawPict.Width / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.XFactor)) div 2,
              (QRPrinter.YSize(Size.Height) -
              round(DrawPict.Height / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.YFactor)) div 2);
          end;
          QRPrinter.Canvas.StretchDraw(Dest, DrawPict.Graphic);
          SelectClipRgn(Handle, 0);
        end;
      end;
    finally
      if H <> 0 then SelectPalette(Handle, H, True);
      DrawPict.Free;
    end;
  end;
  inherited Print(OfsX,OfsY);
  if parentreport.Exporting then
  begin
         ParentReport.ExportFilter.acceptgraphic(
                              qrprinter.XPos(OfsX + self.Size.Left),
                              qrprinter.YPos(OfsY + self.Size.Top), self );
  end;

end;

procedure TQRGrDBImage.UnPrepare;
begin
  FField := nil;
  inherited UnPrepare;
end;

procedure TQRGrDBImage.SetDataSet(Value: TDataSet);
begin
  FDataSet := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TQRGrDBImage.SetDataField(const Value: string);
begin
  FDataField := Value;
end;

function TQRGrDBImage.GetPalette: HPALETTE;
begin
  Result := 0;
  if FPicture.Graphic is TBitmap then
    Result := TBitmap(FPicture.Graphic).Palette;
end;

procedure TQRGrDBImage.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    Invalidate;
  end;
end;

procedure TQRGrDBImage.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TQRGrDBImage.SetStretch(Value: Boolean);
begin
  if FStretch <> Value then
  begin
    FStretch := Value;
    Invalidate;
  end;
end;

procedure TQRGrDBImage.Paint;
var
  W, H: Integer;
  R: TRect;
  S: string;
begin
  with Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := Color;
    Font := Self.Font;
    if Field <> nil then
      S := Field.DisplayLabel
    else S := Name;
    S := '(' + S + ')';
    W := TextWidth(S);
    H := TextHeight(S);
    R := ClientRect;
    TextRect(R, (R.Right - W) div 2, (R.Bottom - H) div 2, S);
  end;
  Inherited Paint;
end;

procedure TQRGrDBImage.PictureChanged(Sender: TObject);
begin
  FPictureLoaded := True;
  Invalidate;
end;

procedure TQRGrDBImage.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = DataSet) then
    DataSet := nil;
end;

procedure TQRGrDBImage.LoadPicture;
begin
  if not FPictureLoaded and (Field is TBlobField) then
    Picture.Assign(FField);
end;

{ TQRHTMLLabel }
function TQRHTMLLabel.GetEditorClass : TQRPrintableEditorClass;
begin
  Result := TQRLabelEditor;
end;

procedure TQRHTMLLabel.PrintToCanvas(aCanvas : TCanvas;
                     aLeft, aTop, aWidth, aHeight, LineHeight : extended;
                     CanExpand : boolean);
var
  aRect : TRect;
  ControlBottom : extended;
  X, Y : extended;
  SavedCaption : string;
  NewCaption : string;
  HasSaved : boolean;
  HasExpanded : boolean;
  Flags : integer;
  AAlignment : TAlignment;
  AFExpanded : extended;
  OrgWidth : extended;
  framew : integer;

  function CanPrint : boolean;
  var
    PrevTop : extended;
  begin
    Result := true;
    if Y + LineHeight > ControlBottom then
    begin
      if CanExpand and TQRCustomBand(Parent).CanExpand(LineHeight) then
      begin
        PrevTop := AFExpanded;
        TQRCustomBand(Parent).ExpandBand(LineHeight, AFExpanded, HasExpanded);
        ControlBottom := aTop + aHeight + 1 + AFExpanded;
        if ParentReport.FinalPass and not Transparent then
          with aCanvas do
          begin
            Pen.Width := 0;
            Brush.Color := Color;
            Brush.Style := bsSolid;
            FillRect(rect(QRPrinter.XPos(aLeft),
                          QRPrinter.YPos(aTop + AHeight + PrevTop),
                          QRPrinter.XPos(aLeft + aWidth),
                          QRPrinter.YPos(aTop + aHeight + AFExpanded)));
          end;
      end else
        Result := false;
    end;
  end;

  procedure PrintLine(LineNumber : integer);
  begin
    if ParentReport.FinalPass and (Length(caption) > 0) and FShowOnDocs then
    begin
      ExtTextOut(aCanvas.Handle, QRPrinter.XPos(X), QRPrinter.YPos(Y),
        Flags, @aRect, pointer(pchar(caption)), length(caption), nil);
    end;
    if ParentReport.Exporting then
       if ParentReport.ExportFilter is TQRGHTMLDocumentFilter then
         ParentReport.ExportFilter.TextOut(X, Y, Font, Color, AAlignment,  '%!'+self.name+'!%' );
    Y := Y + LineHeight;
  end;

begin
  Flags := 0;
  AFExpanded := 0;
  OrgWidth := aWidth;
  HasSaved := false;
  if (caption <> '' ) {and (print event assigned)} then
  begin
    SavedCaption := Caption;
    NewCaption := Caption;
    //FOnPrint(Self, NewCaption);

    if Font <> aCanvas.Font then
    begin
      aCanvas.Font := Font;
      aHeight := Size.Height;
      LineHeight := aCanvas.TextHeight('W') / QRPrinter.YFactor;
    end;

    if NewCaption <> Caption then
    begin
      Caption := NewCaption;
      HasSaved := true;
    end;
  end; // fire onprint event
  aWidth := Size.Width;
  if ParentReport.FinalPass and not Transparent then
    with aCanvas do
    begin
      Pen.Width := 0;
      Brush.Color := Color;
      Brush.Style := bsSolid;
      FillRect(rect(QRPrinter.XPos(aLeft),
                    QRPrinter.YPos(aTop),
                    QRPrinter.XPos(aLeft + aWidth),
                    QRPrinter.YPos(aTop + aHeight)));
    end;
  if ParentReport.FinalPass then
    if not AutoSize then;

  if Frame.AnyFrame then
  begin
    if Frame.DrawTop then
      aTop := aTop + round(Frame.Width / 72 * 254 );
    if Frame.DrawLeft then
      aLeft := aLeft + round(Frame.Width / 72 * 254 )
  end;

  { Get our rectangle for the next line }
  aRect := Rect(0, 0, QRPrinter.XSize(aWidth), QRPrinter.YSize(LineHeight));

  AAlignment := Alignment;

  { Calculate some stuff... }
  ControlBottom := aTop + aHeight + 1;
  Y := aTop;
  if not AutoSize then
    X := aLeft
  else
  begin
    case Alignment of
      TaLeftJustify : X := aLeft;
      TaRightJustify: X := aLeft - (aWidth - OrgWidth);
      TaCenter : X := aLeft - ((aWidth - OrgWidth) / 2);
    end;
  end;

  SetBkMode(aCanvas.Handle, Windows.Transparent);
  { Set the attributes and update X for alignment }
  HasExpanded := false;

  if CanPrint then
  begin
    PrintLine(0);
    PrintFinished := true;
  end;

  SelectClipRgn(QRPrinter.Canvas.Handle, 0);

  if HasSaved then
    Caption := SavedCaption;

  if ParentReport.FinalPass and Frame.AnyFrame then
  begin
    // declare framew : integer; locally
    FrameW := round(Frame.Width / 72 * 254 );
    // QBS position frame properly
    if Frame.DrawTop then aTop := aTop - FrameW;
    if Frame.DrawRight then aWidth := aWidth + (3*FrameW);
    if Frame.DrawLeft then aleft := aleft - FrameW;
    TQRFixFrame(Frame).PaintIt(aCanvas,
            rect(QRPrinter.XPos(ALeft),
            QRPrinter.YPos(ATop),
            QRPrinter.XPos(ALeft + aWidth),
            QRPrinter.YPos(Atop + Size.height+ AFExpanded)),
            QRPrinter.XFactor,
            QRPrinter.YFactor);
  end;
end;

{ TQRCustomHTMLLabel }

constructor TQRCustomHTMLLabel.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FAutoSize := true;
  FAutoStretch := false;
  FWordWrap := true;
  FLines := TStringList.Create;
  FFormattedLines := TStringList.Create;
  DoneFormat := false;
  Caption := '';
  Transparent := false;
  UpdatingBounds := false;
  FFontSize := 0;
  FCaptionBased := true;
  FShowonDocs := true;
end;

destructor TQRCustomHTMLLabel.Destroy;
begin
  FLines.Free;
  FFormattedLines.Free;
  inherited Destroy;
end;

function TQRCustomHTMLLabel.GetControlsAlignment: TAlignment;
begin
  Result := Alignment;
end;

function TQRCustomHTMLLabel.GetCaption : string;
begin
  result := FCaption;
end;

function TQRCustomHTMLLabel.GetCaptionBased : boolean;
begin
  Result := FCaptionBased;
end;

procedure TQRCustomHTMLLabel.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('FontSize', ReadFontSize, WriteFontSize, true); // Do not translate
  inherited DefineProperties(Filer);
end;

procedure TQRCustomHTMLLabel.ReadFontSize(Reader : TReader);
begin
  FFontSize := Reader.ReadInteger;
end;

procedure TQRCustomHTMLLabel.WriteFontSize(Writer : TWriter);
begin
  Writer.WriteInteger(Font.Size);
end;

procedure TQRCustomHTMLLabel.Loaded;
begin
  inherited Loaded;
  if FFontSize > 0 then
    Font.Size := FFontSize;
end;

procedure TQRCustomHTMLLabel.CMFontChanged(var Message: TMessage);
begin
  inherited;
  DoneFormat := false;
 formatlines;
end;

procedure TQRCustomHTMLLabel.Prepare;
begin
  inherited Prepare;
  Caption := copy(Caption, 1, length(Caption));
end;

procedure TQRCustomHTMLLabel.UnPrepare;
begin
  inherited UnPrepare;
end;

procedure TQRCustomHTMLLabel.FormatLines;
var
  I, J : integer;
  NewLine : string;
  LineFinished : boolean;
  HasParent : boolean;
  MaxLineWidth : integer;
  AAlignment: TAlignment;

  function aLineWidth(Line : string) : integer;
  begin
    if HasParent then
      result := Muldiv(Longint(ParentReport.TextWidth(Font, Line)),Zoom,100)
    else
      Result := Canvas.TextWidth(Line);
  end;

  procedure FlushLine;
  begin
    FFormattedLines.Add(NewLine);
    NewLine := '';
  end;

  procedure AddWord(aWord : string);
  begin
    if aLineWidth(NewLine + aWord) > Width then
    begin
      if NewLine = '' then
      begin
        while aLineWidth(NewLine + copy(aWord, 1, 1)) < Width do
        begin
          NewLine := NewLine + copy(aWord, 1, 1);
          Delete(aWord, 1, 1);
        end;
        aWord := '';
      end;
      FlushLine;
      if aLineWidth(aWord) > Width then
      begin
        if NewLine = '' then
        begin
          if Width = 0 then
            aWord := ''
          else
            while aLineWidth(aWord) > Width do
                Delete(aWord, Length(aWord), 1);
        end;
        NewLine := aWord;
        FlushLine;
        aWord := '';
      end;
      if not WordWrap then
      begin
        aWord := '';
        LineFinished := true;
      end;
    end;
    NewLine := NewLine + aWord;
  end;

  procedure AddLine(Line : string);
  var
    aPos : integer;
  begin
    while pos(#10, Line) > 0 do
      Delete(Line, Pos(#10, Line), 1);
    aPos := pos(#13, Line);
    if aPos > 0 then
    begin
      repeat
        AddLine(copy(Line, 1, aPos - 1));
        Delete(Line, 1 , aPos);
        aPos := pos(#13, Line);
      until aPos = 0;
      AddLine(Line);
    end else
    begin
      J := 0;
      NewLine := '';
      LineFinished := false;
      if AutoSize then
      begin
        NewLine := Line;
        FlushLine;
        LineFinished := True;
      end else
      begin
        while (J < Length(Line)) and (Length(Line) > 0) do
        begin
          repeat
            inc(J)
          until charInSet(Line[J], BreakChars) or (J >= Length(Line));
          AddWord(copy(Line, 1, J));
          Delete(Line, 1, J);
          J := 0;
        end;
        if not LineFinished then
          FlushLine;
      end;
    end;
  end;

  procedure FormatFromCaption;
  begin
    AddLine(FPrintCaption);
    if not UpdatingBounds and HasParent then
    begin
      UpdatingBounds := true;
      if Height < (longint(ParentReport.TextHeight(Font, 'W') * Zoom div 100) + 1) then
         Height := (longint(ParentReport.TextHeight(Font, 'W')) * Zoom div 100) + 1;
      UpdatingBounds := false;
    end
  end;

  procedure FormatFromStringList;
  var
    J : integer;
  begin
    if (FLines.Count <> 0) then
    begin
      if AutoSize then
        FFormattedLines.Assign(FLines)
      else
        for J := 0 to FLines.Count - 1 do
          AddLine(FLines[J]);
    end else
      if csDesigning in ComponentState then
      begin
        FCaption := Name;
        FormatFromCaption;
        FCaption := '';
      end;
  end;

begin //---------------------------body of formatlines---------------------
  if Parent <> nil then
  begin
    if assigned(FFormattedLines) then
      FFormattedLines.Clear
    else
      FFormattedLines := TStringList.Create;
    HasParent := ParentReport <> nil;
    LineFinished := false;
    if CaptionBased then
      FormatFromCaption
    else
      FormatFromStringList;
    if AutoSize and (not UpdatingBounds) and HasParent then
    begin
      MaxLineWidth := 0;
      for I := 0 to FFormattedLines.Count - 1 do
        if aLineWidth(FFormattedLines[I]) > MaxLineWidth then
          MaxLineWidth := aLineWidth(FFormattedLines[I]);
      if Frame.DrawLeft then
        MaxLineWidth := MaxLineWidth + Frame.Width;
      if Frame.DrawRight then
        MaxLineWidth := MaxLineWidth + Frame.Width;
      UpdatingBounds := true;
      AAlignment := Alignment;
      if UseRightToLeftAlignment then
        ChangeBiDiModeAlignment(AAlignment);
      case AAlignment of
        taCenter : Left := Left + ((Width - MaxLineWidth) div 2);
        taRightJustify : Left := Left + Width - MaxLineWidth;
      end;
      Width := MaxLineWidth;
      if (FFormattedLines.Count = 0) and (csDesigning in ComponentState) then
        Height := (longint(ParentReport.TextHeight(Font, 'W')) * Zoom div 100) + 1;
      if (Height < (longint(ParentReport.TextHeight(Font, 'W') * Zoom div 100) + 1)) then
        Height := (longint(ParentReport.TextHeight(Font, 'W')) * Zoom div 100) + 1;
      UpdatingBounds := false;
    end;
  end;
  DoneFormat := true;
end;

procedure TQRCustomHTMLLabel.SetLines(Value : TStrings);
begin
  FLines.Assign(Value);
  DoneFormat := false; {xxx}
  Invalidate;
end;

procedure TQRCustomHTMLLabel.PaintToCanvas(aCanvas : TCanvas; aRect : TRect; CanExpand : boolean; LineHeight: integer);
var
  I : integer;
  StartX : integer;
  StartY : integer;
  Cap : string;
  VPos : integer;
  Flags : integer;
  AAlignment: TAlignment;
begin
  FormatLines;
  Flags := 0;
{  if AutoSize then Flags := 0 else Flags := ETO_CLIPPED;}
  if not Transparent then
  begin
    aCanvas.Brush.Color := Color;
    aCanvas.Brush.Style := bsSolid;
    aCanvas.Fillrect(aRect);
  end;
  StartY := aRect.Top;
  StartX := aRect.Left;
  if Frame.AnyFrame then
  begin
    if Frame.DrawTop and (Frame.Width > 0 ) then
      StartY := StartY + round(Frame.Width / 72 * Screen.PixelsPerInch * Zoom / 100);
    if Frame.DrawLeft then
      StartX := StartX + round(Frame.Width / 72 * Screen.PixelsPerInch * Zoom / 100)
  end;
  aRect.Right := aRect.Right - aRect.Left;
  aRect.Left := 0;
  aRect.Bottom := aRect.Bottom - aRect.Top;
  aRect.Top := 0;
  SetBkMode(aCanvas.Handle, Windows.Transparent);
  begin
    AAlignment := Alignment;
    if UseRightToLeftAlignment then
      ChangeBiDiModeAlignment(AAlignment);
    case AAlignment of
      TaLeftJustify : SetTextAlign(aCanvas.Handle, TA_Left + TA_Top + TA_NoUpdateCP);
      TaRightJustify: begin
          SetTextAlign(aCanvas.Handle, TA_Right + TA_Top + TA_NoUpdateCP);
          StartX := StartX + aRect.Right;
        end;
      TaCenter : begin
          SetTextAlign(aCanvas.Handle, TA_Center + TA_Top + TA_NoUpdateCP);
          StartX := StartX + (aRect.Right - aRect.Left) div 2;
        end;
    end;
  end;
  for I := 0 to FFormattedLines.Count - 1 do
  begin
    VPos := StartY + I * LineHeight;
    begin
      Cap := FFormattedLines[I];
      if Length(Cap) > 0 then
        ExtTextOut(aCanvas.Handle, StartX, VPos, Flags, @aRect, @Cap[1], length(Cap), nil);
    end;
  end;
end;

procedure TQRCustomHTMLLabel.PrintToCanvas(aCanvas : TCanvas;
                                       aLeft, aTop, aWidth, aHeight,
                                       LineHeight : extended;
                                       CanExpand : boolean);
begin
end;

procedure TQRCustomHTMLLabel.Paint;
begin
  Canvas.Font.Assign(Font);
  if Canvas.Font.Size <> round(Font.Size * Zoom / 100) then
    Canvas.Font.Size := round(Font.Size * Zoom / 100);
  inherited Paint;
  PaintToCanvas(Canvas, rect(0, 0, Width, Height), false, round(Canvas.TextHeight('W')));
  PaintCorners;
end;

procedure TQRCustomHTMLLabel.Print(OfsX, OfsY : integer);
var
  aCanvas : TCanvas;
begin
  if IsEnabled then
  begin
    aCanvas := QRPrinter.Canvas;
    aCanvas.Font := Font;
    with QRPrinter do
      PrintToCanvas(QRPrinter.Canvas,
                    OfsX + Size.Left, OfsY + Size.Top,
                    Size.Width, Size.Height,
                    aCanvas.TextHeight('W') / QRPrinter.YFactor, AutoStretch);
//    inherited Print(OfsX, OfsY);
  end;
end;

procedure TQRCustomHTMLLabel.SetAutoStretch(Value : boolean);
begin
  FAutoStretch := Value;
  Invalidate;
end;

procedure TQRCustomHTMLLabel.SetCaption(Value : string);
begin
  FCaption := Value;
  FPrintCaption := Value;
  DoneFormat := false;
  FormatLines;
  Invalidate;
end;

procedure TQRCustomHTMLLabel.SetName(const Value: TComponentName);
begin
  if ((Caption = '') or (Caption = Name)) then
    Caption := Value;
  inherited SetName(Value);
end;

procedure TQRCustomHTMLLabel.SetParent(AParent : TWinControl);
begin
  inherited SetParent(AParent);
  FormatLines;
end;

procedure TQRCustomHTMLLabel.SetAlignment(Value : TAlignment);
begin
  inherited SetAlignment(Value);
end;

procedure TQRCustomHTMLLabel.SetWordWrap(Value : boolean);
begin
  FWordWrap := Value;
  Invalidate;
end;
end.

