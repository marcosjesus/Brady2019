{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 5.0 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRMBCtrls.pas - Double-byte PRINTABLE CONTROLS           ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.quickreport.co.uk                       ::
  :: QR5
  :: New unit based on qrctrls.pas for widestring controls
  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}

{$I QRDEFS.INC}
{$define QRXDOC}
unit  QRMBCtrls;

interface

uses Messages, Windows, Classes, Controls, StdCtrls, SysUtils, Graphics, Buttons,
     Forms, ExtCtrls, Dialogs, Printers, DB, ComCtrls, RichEdit,
     QRPrntr, QuickRpt, Qr5Const, QRExpr, qrctrls, widelist, wideStrMerger;
{$R-}
{$B-}

type
  { Forward declarations }
  TQRMBExpr = class;

  TQRMBLabelOnPrintEvent = procedure (sender : TObject; var Value : WideString) of object;

  { TQRMBCustomLabel - base class for printable text components }
  TQRMBCustomLabel = class(TQRPrintable)
  private
    FCaptionBased : boolean;
    DoneFormat : boolean;
    FAutoSize : boolean;
    FAutoStretch : boolean;
    FCaption : WideString;
    FCurrentLine : integer;
    FPrintCaption : WideString;      
    FFontSize : integer;
    FFormattedLines : TWideStringList;
    FLines : TWideStringList;
    FOnPrint : TQRMBLabelOnPrintevent;
    FWordWrap : boolean;
    UpdatingBounds : boolean;
    function GetCaption : WideString;
    function GetCaptionBased : boolean; virtual;
    procedure SetAutoStretch(Value : boolean);
    procedure SetCaption(Value : WideString);
    procedure SetLines(Value : TWideStringList);
    procedure SetWordWrap(Value : boolean);
    procedure PaintToCanvas(aCanvas : TCanvas; aRect : TRect; CanExpand : boolean; LineHeight : integer);
    procedure PrintToCanvas(aCanvas : TCanvas; aLeft, aTop, aWidth, aHeight, LineHeight : extended;
                            CanExpand : boolean);
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
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
    property OnPrint : TQRMBLabelOnPrintEvent read FOnPrint write FOnPrint;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function GetControlsAlignment: TAlignment; override; 
    property CaptionBased : boolean read GetCaptionBased;
    property Alignment;
    property AutoSize : boolean read FAutoSize write FAutoSize;
    property AutoStretch : boolean read FAutoStretch write SetAutoStretch;
    property Caption : WideString read GetCaption write SetCaption stored true;
    property Color;
    property Font;
    property Lines : TWideStringList read FLines write SetLines;
    property WordWrap : boolean read FWordWrap write SetWordWrap;
  end;

  { TQRMBLabel - printable component with published Caption property }
  TQRMBLabel = class(TQRMBCustomLabel)
  protected
    function GetEditorClass : TQRPrintableEditorClass; override;
  public
  published
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
  end;

  { TQRMBMemo - printable memo component (published Lines property) }
  TQRMBMemo = class(TQRMBCustomLabel)
  protected
    function GetCaptionBased : boolean; override;
  public
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure GetExpandedHeight(var newheight : extended );override;
  published
    property Alignment;
    property AlignToBand;
    property AutoSize;
    property AutoStretch;
    property BiDiMode;
    property ParentBiDiMode;
    property Color;
    property Font;
    property Lines;
    property ParentFont;
    property Transparent;
    property WordWrap;
    property OnPrint;
  end;

  { TQRMBDBText }
  TQRMBDBText = class(TQRMBCustomLabel)
  private
    ComboBox : TEdit;
    Field : TField;
    FieldNo : integer;
    FieldOK : boolean;
    DataSourceName : string[30];
    FDataSet : TDataSet;
    FDataField : string;
    FMask : string;
    IsMemo : boolean;
    procedure SetDataSet(Value : TDataSet);
    procedure SetDataField(Value : string);
    procedure SetMask(Value : string);
  protected
    function GetCaptionBased : boolean; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Prepare; override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure UnPrepare; override;
  public
    constructor Create(AOwner : TComponent); override;
    function UseRightToLeftAlignment: boolean; override;
    procedure GetExpandedHeight(var newheight : extended ); override;
    procedure GetFieldStringW( var DataStr : widestring);
  published
    property Alignment;
    property AlignToBand;
    property AutoSize;
    property AutoStretch;
    property BiDiMode;
    property ParentBiDiMode;
    property Color;
    property DataSet : TDataSet read FDataSet write SetDataSet;
    property DataField : string read FDataField write SetDataField;
    property Font;
    property Mask : string read FMask write SetMask;
    property OnPrint;
    property ParentFont;
    property Transparent;
    property WordWrap;
    property ExportAs;
end;

  { TQRMBExpr }
  TQRMBExpr = class(TQRMBCustomLabel)
  private
    Evaluator : TQREvaluator;
    FExpression : string;
    FMask : string;
    FMaster : TComponent;
    FResetAfterPrint : boolean;
    function GetValue : TQREvResult;
    procedure SetExpression(Value : string);
    procedure SetMask(Value : string);
  protected
    procedure Prepare; override;
    procedure UnPrepare; override;
    procedure QRNotification(Sender : TObject; Operation : TQRNotifyOperation); override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure SetMaster(AComponent : TComponent);
{$ifndef QRSTANDARD}
    function GetEditorClass : TQRPrintableEditorClass; override;
{$endif}
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Reset;
    property Value : TQREvResult read GetValue;
  published
    property Alignment;
    property AlignToBand;
    property AutoSize;
    property AutoStretch;
    property BiDiMode;
    property ParentBiDiMode;
    property Font;
    property Color;
    property Master : TComponent read FMaster write SetMaster;
    property OnPrint;
    property ParentFont;
    property ResetAfterPrint : boolean read FResetAfterPrint write FResetAfterPrint;
    property Transparent;
    property WordWrap;
    property Expression : string read FExpression write SetExpression;
    property Mask : string read FMask write SetMask;
  end;

  TQRMBSysData = class(TQRMBCustomLabel)
  private
    FData : TQRSysDataType;        
    FText : WideString;
    procedure SetData(Value : TQRSysDataType);
    procedure SetText(Value : WideString);
    procedure CreateCaption;
  protected
    procedure Print(OfsX, OfsY : integer); override;
  public
    constructor Create(AOwner : TComponent); override;
  published
    property Alignment;
    property AlignToBand;
    property AutoSize;
    property BiDiMode;
    property ParentBiDiMode;
    property Color;
    property Data : TQRSysDataType read FData write SetData;
    property Font;
    property OnPrint;
    property ParentFont;
    property Text : WideString read FText write SetText;
    property Transparent;
  end;


  { TQRMBExprMemo }
  TQRMBExprMemo = class(TQRMBCustomLabel)
  private
    Merger : TQRAnsiMerger;
    FRemoveBlankLines : boolean;
  protected
    function GetCaptionBased : boolean; override;
    procedure Prepare; override;
    procedure UnPrepare; override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure Paint; override;
  public
    constructor Create(AOwner : TComponent); override;
  published
    property RemoveBlankLines : boolean read FRemoveBlankLines write FRemoveBlankLines;
    property Alignment;
    property AlignToBand;
    property AutoSize;
    property AutoStretch;
    property Color;
    property Font;
    property Lines;
    property ParentFont;
    property Transparent;
    property WordWrap;
  end;


  var
    metacanvas : TMetafilecanvas;
    LogX, LogY : integer;

     ExportingRecordnumber : integer;
     ExportingControlName : string;
implementation

uses
  QRLablEd, QRExprEd;

const
  //BreakChars : set of WideChar = [' ', #13, '-'];
  BreakChars : array[0..2] of WideChar = (' ', #13, '-');
{$ifdef HIRES}
var
    NextRTFImage : integer;
{$endif}
{ BiDiMode support routines }
function OkToChangeFieldAlignment(AField: TField; Alignment: TAlignment): Boolean;
begin
  { dont change the alignment for these fields:
    ftSmallInt     ftInteger      ftWord         ftFloat        ftCurrency
    ftBCD          ftDate         ftTime         ftDateTime     ftAutoInc }
  if Assigned(AField) then with AField do
    Result := (DataType < ftSmallInt) or
              (DataType = ftBoolean) or
              ((DataType > ftDateTime) and (DataType <> ftAutoInc))
  else
    Result := Alignment <> taCenter;
end;

function QRDBUseRightToLeftAlignment(AControl: TControl; AField: TField): Boolean;
var
  AAlignment: TAlignment;
begin
  if Assigned(AField) then
    AAlignment := AField.Alignment
  else
    AAlignment := taLeftJustify;
  { Calling AControl.UseRightToLeftAlignment cause an endless recursion }
  Result := (AControl.BiDiMode = bdRightToLeft) and
    (OkToChangeFieldAlignment(AField, AAlignment));
end;

  procedure PrintBitmap(aCanvas : TCanvas; Dest : TRect; Bitmap : TBitmap);
  var
    Info : PBitmapInfo;
    InfoSize : DWORD;
    Image : Pointer;
    HInfo:HGLOBAL;        //Declare this new var
    HImage:HGLOBAL;    //Declare this new var
{$ifdef ver80}
    ImageSize : Longint;
{$else}
    ImageSize : DWord;
{$endif}
  begin
    with Bitmap do
    begin
      GetDIBSizes(Handle, InfoSize, ImageSize);

      HInfo := GlobalAlloc(GMEM_MOVEABLE or GMEM_SHARE,InfoSize);
      Info := PBitmapInfo(GlobalLock(HInfo));
      try
        HImage := GlobalAlloc(GMEM_MOVEABLE or GMEM_SHARE,ImageSize);
        Image := Pointer(GlobalLock(HImage));
        try
          GetDIB(Handle, Palette, Info^, Image^);
          aCanvas.Lock;
          if not Monochrome then
            SetStretchBltMode(ACanvas.Handle, STRETCH_DELETESCANS);
          with Info^.bmiHeader do
            StretchDIBits(aCanvas.Handle, Dest.Left, Dest.Top,
              Dest.RIght - Dest.Left, Dest.Bottom - Dest.Top,
              0, 0, biWidth, biHeight, Image, Info^, DIB_RGB_COLORS, SRCCOPY);
        finally
         aCanvas.Unlock;
         GlobalUnlock(HImage);         // We first unlock the previously locked memory
         GlobalFree(HImage);           // and then we free it
        end;
      finally
         GlobalUnlock(HInfo);         // We first unlock the previously locked memory
         GlobalFree(HInfo);           // and then we free it
      end;
    end;
  end;

{ TQRMBCustomLabel }
constructor TQRMBCustomLabel.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FAutoSize := true;
  FAutoStretch := false;
  FWordWrap := true;
  FLines := TWideStringList.Create;
  FFormattedLines := TWideStringList.Create;
  DoneFormat := false;
  Caption := '';
  Transparent := false;
  UpdatingBounds := false;
  FFontSize := 0;
  FCaptionBased := true;
end;

destructor TQRMBCustomLabel.Destroy;
begin
  FLines.Free;
  FFormattedLines.Free;
  inherited Destroy;
end;

function TQRMBCustomLabel.GetControlsAlignment: TAlignment;
begin
  Result := Alignment;
end;

function TQRMBCustomLabel.GetCaption : WideString;
begin
  result := FCaption;
end;

function TQRMBCustomLabel.GetCaptionBased : boolean;
begin
  Result := FCaptionBased;
end;

procedure TQRMBCustomLabel.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('FontSize', ReadFontSize, WriteFontSize, true); // Do not translate
  inherited DefineProperties(Filer);
end;

procedure TQRMBCustomLabel.ReadFontSize(Reader : TReader);
begin
  FFontSize := Reader.ReadInteger;
end;

procedure TQRMBCustomLabel.WriteFontSize(Writer : TWriter);
begin
  Writer.WriteInteger(Font.Size);
end;

procedure TQRMBCustomLabel.Loaded;
begin
  inherited Loaded;
  if FFontSize > 0 then
    Font.Size := FFontSize;
end;

procedure TQRMBCustomLabel.CMFontChanged(var Message: TMessage);
begin
  inherited;
  DoneFormat := false;
 formatlines;
end;

procedure TQRMBCustomLabel.Prepare;
begin
  inherited Prepare;
  Caption := copy(Caption, 1, length(Caption));
end;

procedure TQRMBCustomLabel.UnPrepare;
begin
  inherited UnPrepare;
end;

procedure TQRMBCustomLabel.FormatLines;
var
  I, J : integer;
  NewLine : WideString;
  LineFinished : boolean;
  HasParent : boolean;
  MaxLineWidth : integer;
  AAlignment: TAlignment;

  function aLineWidth(Line : WideString) : integer;
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

  procedure AddWord(aWord : WideString);
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

  procedure AddLine(Line : WideString);
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
          until (Line[J] = BreakChars[0]) or (J >= Length(Line));
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

begin
  if Parent <> nil then
  begin
    if assigned(FFormattedLines) then
      FFormattedLines.Clear
    else
      FFormattedLines := TWideStringList.Create;
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

procedure TQRMBCustomLabel.SetLines(Value : TWideStringList);
begin
  FLines.Assign(Value);
  DoneFormat := false; {xxx}
  Invalidate;
end;

procedure TQRMBCustomLabel.PaintToCanvas(aCanvas : TCanvas; aRect : TRect; CanExpand : boolean; LineHeight: integer);
var
  I : integer;
  StartX : integer;
  StartY : integer;
  Cap : WideString;
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
        ExtTextOutW(aCanvas.Handle, StartX, VPos, Flags, @aRect, @Cap[1], length(Cap), nil);
    end;
  end;
  // reset the alignment
  //Alignment := AAlignment;
end;

type
  TQRFixFrame = class(TQRFrame)
  end;

{procedure TQRFixFrame.PaintFit(ACanvas : TCanvas; ARect : TRect; XFact, YFact : extended);
var
  FWX, FWY : integer;
begin
  FWX := round(XFact / 72 * 254 * Width);
  if ((FWX < 1) and (Width >= 1)) or (Width = -1) then
    FWX := 1;
  FWY := round(YFact / 72 * 254 * Width);
  if ((FWY < 1) and (Width >= 1)) or (Width = -1) then
    FWY := 1;
  ACanvas.Brush.Style := bsSolid;
  ACanvas.Brush.Color := Color;
  SetPen(ACanvas.Pen);
  with aCanvas do
  begin
    if DrawTop then
      FillRect(Rect(ARect.Left, ARect.Top, ARect.Right, ARect.Top + FWY));
    if DrawBottom then
      FillRect(Rect(ARect.Left, ARect.Bottom, ARect.Right, ARect.Bottom - FWY));
    if DrawLeft then
      FillRect(Rect(ARect.Left, ARect.Top, ARect.Left + FWX, ARect.Bottom));
    if DrawRight then
      FillRect(Rect(ARect.Right - FWX, ARect.Top, ARect.Right, ARect.Bottom));
  end;
  ACanvas.Brush.Style := bsClear;
end;}

procedure TQRMBCustomLabel.PrintToCanvas(aCanvas : TCanvas; aLeft, aTop, aWidth, aHeight,
                                       LineHeight : extended; CanExpand : boolean);
var
  aRect : TRect;
  ControlBottom : extended;
  X, Y : extended;
  SavedCaption : WideString;
  NewCaption : WideString;
  HasSaved : boolean;
  HasExpanded : boolean;
  Flags : integer;
  TAFlags : integer;
  AAlignment : TAlignment;
  AFExpanded : extended;
  OrgWidth : extended;
  framebit : TQRShape;

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
        begin
            aCanvas.Pen.Width := 0;
            aCanvas.Brush.Color := Color;
            aCanvas.Brush.Style := bsSolid;
            // there's a gap below ...
            aCanvas.FillRect(rect(QRPrinter.XPos(aLeft),
                          QRPrinter.YPos(aTop + AHeight + PrevTop),
                          QRPrinter.XPos(aLeft + aWidth),
                          QRPrinter.YPos(aTop + aHeight + AFExpanded)));
        end;
      end
      else
      begin
        Result := false;
      end;
    end;
  end;

  procedure PrintLine(LineNumber : integer);
  begin
    if ParentReport.FinalPass and (Length(FFormattedLines[LineNumber]) > 0) then
    begin
      ExtTextOutW(aCanvas.Handle, QRPrinter.XPos(X), QRPrinter.YPos(Y),
        Flags, @aRect, @FFormattedLines[LineNumber][1], length(FFormattedLines[LineNumber]), nil);
    end;
    if ParentReport.Exporting then
      ParentReport.ExportFilter.TextOut(X, Y, Font, Color, AAlignment, FFormattedLines[LineNumber]);
    Y := Y + LineHeight;
  end;

begin
  Flags := 0;
  AFExpanded := 0;
  OrgWidth := aWidth;
{$ifdef QRXDOC}
  ExportingControlName := self.Name;
{$endif}
{  if AutoSize then Flags := 0; else Flags := ETO_CLIPPED;}
{  if Transparent then Flags := Flags + ETO_OPAQUE;}
  HasSaved := false;
  //if (FPrintCaption <> '') and assigned(FOnPrint) then
  if assigned(FOnPrint) then
  //if assigned(FOnPrint) then
  begin
    SavedCaption := FPrintCaption;
    NewCaption := FprintCaption;
    FOnPrint(Self, NewCaption);

    if Font <> aCanvas.Font then
    begin
      aCanvas.Font := Font;
      aHeight := Size.Height;
      LineHeight := aCanvas.TextHeight('W') / QRPrinter.YFactor;
    end;

    if NewCaption <> FPrintCaption then
    begin
      FPrintCaption := NewCaption;
      FormatLines;
      HasSaved := true;
    end;
  end;
  FormatLines;
  {if not Autosize then }aWidth := Size.Width;
  // export the control background
  if parentreport.Exporting and not Transparent and ( Color <> clWhite) then
  begin
         framebit := TQRShape.Create(self);
         framebit.Brush.style := bsSolid;
         framebit.Pen.Style := psClear;
         framebit.Brush.color := color;
         framebit.left := QRPrinter.XPos(ALeft);
         framebit.top := QRPrinter.YPos(ATop);
         framebit.Width := QRPrinter.XPos(aWidth);
         framebit.Height := QRPrinter.YPos( AFExpanded + Size.height);
         TQRExportFilter(parentreport.ExportFilter).acceptgraphic( framebit.left, framebit.top, framebit );
         framebit.Free;
  end;

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
  if UseRightToLeftAlignment then
    ChangeBiDiModeAlignment(AAlignment);

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
// used in QR3.5
  TAFlags := TA_Top + TA_NoUpdateCP;
  AAlignment := Alignment;
  if UseRightToLeftAlignment then
    ChangeBiDiModeAlignment(AAlignment);
  if UseRightToLeftReading then
  begin
    Flags := Flags or ETO_RTLREADING;
    TAFlags := TAFlags + TA_RTLREADING;
  end;
  case AAlignment of
    TaLeftJustify : SetTextAlign(aCanvas.Handle, TA_Left + TAFlags);
    TaRightJustify: begin
      SetTextAlign(aCanvas.Handle, TA_Right + TAFlags);
      X := X + aWidth;
    end;
    TaCenter : begin
      SetTextAlign(aCanvas.Handle, TA_Center + TAFlags);
      X := X + aWidth / 2;
    end;
  end;

  HasExpanded := false;
  if PrintFinished then
    FCurrentLine := 0;

  while (FCurrentLine <= FFormattedLines.Count - 1) and CanPrint do
  begin
    PrintLine(FCurrentLine);
    inc(FCurrentLine);
  end;

  if (FCurrentLine <= FFormattedLines.Count - 1) and AutoStretch then
    PrintFinished := false
  else
    PrintFinished := true;
  SelectClipRgn(QRPrinter.Canvas.Handle, 0);
// end new code

  if HasSaved then
    FPrintCaption := SavedCaption;

  if (ParentReport.FinalPass or ParentReport.Exporting) and Frame.AnyFrame then
    TQRFixFrame(Frame).PaintIt(aCanvas,
      rect(QRPrinter.XPos(ALeft- round(Frame.Width / 72 * 254 )),
        QRPrinter.YPos(ATop- round(Frame.Width / 72 * 254 )),
        QRPrinter.XPos(ALeft + aWidth),
        QRPrinter.YPos(Atop + Size.height + AFExpanded)),
      QRPrinter.XFactor,
      QRPrinter.YFactor);

end;

procedure TQRMBCustomLabel.Paint;
begin
  Canvas.Font.Assign(Font);
  if Canvas.Font.Size <> round(Font.Size * Zoom / 100) then
    Canvas.Font.Size := round(Font.Size * Zoom / 100);
  inherited Paint;
  PaintToCanvas(Canvas, rect(0, 0, Width, Height), false, round(Canvas.TextHeight('W')));
  PaintCorners;
end;

procedure TQRMBCustomLabel.Print(OfsX, OfsY : integer);
var
  aCanvas : TCanvas;
begin
  if IsEnabled then
  begin
    if qrprinter = nil then prepare;
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

procedure TQRMBCustomLabel.SetAutoStretch(Value : boolean);
begin
  FAutoStretch := Value;
  Invalidate;
end;

procedure TQRMBCustomLabel.SetCaption(Value : WideString);
begin
  FCaption := Value;
  FPrintCaption := Value;
  DoneFormat := false;
  FormatLines;
  Invalidate;
end;

procedure TQRMBCustomLabel.SetName(const Value: TComponentName);
begin
  if ((Caption = '') or (Caption = Name)) then
    Caption := Value;
  inherited SetName(Value);
end;

procedure TQRMBCustomLabel.SetParent(AParent : TWinControl);
begin
  inherited SetParent(AParent);
  FormatLines;
end;

procedure TQRMBCustomLabel.SetAlignment(Value : TAlignment);
begin
  inherited SetAlignment(Value);
end;

procedure TQRMBCustomLabel.SetWordWrap(Value : boolean);
begin
  FWordWrap := Value;
  Invalidate;
end;

{ TQRMBLabel }
function TQRMBLabel.GetEditorClass : TQRPrintableEditorClass;
begin
  Result := TQRLabelEditor;
end;

{ TQRDBText }
constructor TQRMBDBText.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  DataSourceName := '';
  ComboBox := nil;
  IsMemo := false;
end;

procedure TQRMBDBText.GetExpandedHeight(var newheight : extended );
var
     Nlines : integer;
     lineheight : integer;
     function aLineHeight(Line : string) : integer;
     begin
        if HasParent then
            result := Muldiv(Longint(ParentReport.TextHeight(Font, Line)),Zoom,100)
        else
          Result := Canvas.TextWidth(Line);
     end;
begin
      self.getfieldstringw( FPrintCaption );
      FormatLines;
      lineheight := aLineHeight( 'W' );
      Nlines := FFormattedLines.Count;
      newheight := nlines * (lineheight);
end;

procedure TQRMBDBText.GetFieldStringw( var DataStr : widestring);
begin
  if IsEnabled then
  begin
    if FieldOK then
    begin
      if FDataSet.DefaultFields then
        Field := FDataSet.Fields[FieldNo];
    end
    else
      Field := nil;
    if assigned(Field) then
    begin
      try
        if (Field is TMemoField) or
           (Field is TBlobField) then
        begin
          // caution : Lines is a property of self
          Lines.Text := TMemoField(Field).AsString;
        end
        else
          if (Mask = '') or (Field is TStringField) then
            if not (Field is TBlobField) then
              DataStr := Field.DisplayText
            else
              DataStr := Field.AsString
          else
          begin
            if (Field is TIntegerField) or
               (Field is TSmallIntField) or
               (Field is TWordField) then
               DataStr := FormatFloat(Mask, TIntegerField(Field).Value * 1.0)
            else if (Field is TBCDField) or
                 (Field is TFmtBCDField) then
                 DataStr := FormatFloat(Mask,TNumericField(Field).Value)
            else if (Field is TFloatField) or
                 (Field is TCurrencyField)then
                 DataStr := FormatFloat(Mask,TFloatField(Field).Value)
            else if (Field is TDateTimeField) or
                   (Field is TDateField) or
                   (Field is TTimeField) then
                  DataStr := FormatDateTime(Mask,TDateTimeField(Field).Value);
          end;
      except
        DataStr := '';
      end;
    end else
      DataStr := '';
  end;
end;

procedure TQRMBDBText.SetDataSet(Value : TDataSet);
begin
  FDataSet := Value;
  if Value <> nil then
    Value.FreeNotification(self);
end;

function TQRMBDBText.GetCaptionBased : boolean;
begin
  Result := not IsMemo;
end;

procedure TQRMBDBText.SetDataField(Value : string);
begin
  FDataField := Value;
  Caption := Value;
end;

procedure TQRMBDBText.Loaded;
var
  aComponent : TComponent;
begin
  inherited Loaded;
  if DataSourceName<>'' then
  begin
    aComponent := Owner.FindComponent(DataSourceName);
    if (aComponent <> nil) and (aComponent is TDataSource) then
      DataSet:=TDataSource(aComponent).DataSet;
  end;
end;

procedure TQRMBDBText.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
    if AComponent = FDataSet then
      FDataSet := nil;
end;

procedure TQRMBDBText.SetMask(Value : string);
begin
  FMask := Value;
end;

procedure TQRMBDBText.Prepare;
begin
  inherited Prepare;
  if assigned(FDataSet) then
  begin
    Field := FDataSet.FindField(FDataField);
    if Field <> nil then
    begin
      FieldNo := Field.Index;
      FieldOK := true;
      if (Field is TMemoField) or (Field is TBlobField) then
      begin
        FPrintCaption := '';
        IsMemo := true;
      end
        else IsMemo := false;
    end;
  end else
  begin
    Field := nil;
    FieldOK := false;
  end;
end;

procedure TQRMBDBText.Print(OfsX, OfsY : integer);
begin
  if IsEnabled then
  begin
    if FieldOK then
    begin
      if FDataSet.DefaultFields then
        Field := FDataSet.Fields[FieldNo];
    end
    else
      Field := nil;
    if assigned(Field) then
    begin
      try
        if (Field is TMemoField) or
           (Field is TBlobField) then
        begin
          Lines.Text := TMemoField(Field).AsString;
        end else
          if (Mask = '') or (Field is TStringField) then
            if not (Field is TBlobField) then
              FPrintCaption := Field.DisplayText
            else
              FPrintCaption := Field.AsString
          else
          begin
            if (Field is TIntegerField) or
               (Field is TSmallIntField) or
               (Field is TWordField) then
                   FPrintCaption := FormatFloat(Mask, TIntegerField(Field).Value * 1.0)
            else if (Field is TBCDField) or
                    (Field is TFMTBCDField) then
                       FPrintCaption := FormatFloat(Mask,TNumericField(Field).Value)
            else if (Field is TFloatField) or
                 (Field is TCurrencyField) then
                    FPrintCaption := FormatFloat(Mask,TFloatField(Field).Value)
            else if (Field is TDateTimeField) or
                   (Field is TDateField) or
                   (Field is TTimeField) then
                       FPrintCaption := FormatDateTime(Mask,TDateTimeField(Field).Value);
          end;
      except
        FPrintCaption := '';
      end;
    end else
      FPrintCaption := '';
    DoneFormat := false;
    inherited Print(OfsX,OfsY);
  end;
end;

procedure TQRMBDBText.UnPrepare;
begin
  Field := nil;
  inherited UnPrepare;
  if DataField <> '' then
    SetDataField(DataField) { Reset component caption }
  else
    SetDataField(Name);
end;

function TQRMBDBText.UseRightToLeftAlignment: Boolean;
begin
  Result := QRDBUseRightToLeftAlignment(Self, Field);
end;

{ TQRMBMemo }
function TQRMBMemo.GetCaptionBased : boolean;
begin
  Result := false;
end;

procedure TQRMBMemo.Paint;
begin
  if (Lines.Count > 0) and (Caption > '') then
    Caption := '';
  inherited Paint;
end;

procedure TQRMBMemo.Print(OfsX, OfsY : integer);
begin
{  if (Lines.Count > 0) then}
  Caption := '';
  inherited Print(OfsX, OfsY);
  Caption := Name;
end;

procedure TQRMBMemo.GetExpandedHeight(var newheight : extended );
var
     Nlines : integer;
     lineheight : extended;
     function aLineHeight(Line : WideString) : integer;
     begin
        if HasParent then
            result := Muldiv(Longint(ParentReport.TextHeight(Font, Line)),Zoom,100)
        else
          Result := Canvas.TextWidth(Line);
     end;
begin
      FormatLines;
      lineheight := aLineHeight( 'W' );
      Nlines := FFormattedLines.Count;
      newheight := nlines * (lineheight);
end;


{ TQRMBExpr }
constructor TQRMBExpr.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Evaluator := TQREvaluator.Create;
  FExpression := '';
  FMask := '';
end;

destructor TQRMBExpr.Destroy;
begin
  Evaluator.Free;
  inherited Destroy;
end;

function TQRMBExpr.GetValue : TQREvResult;
begin
  if Evaluator.Prepared then
    result := Evaluator.Value
  else
    result.Kind := resError;
end;

procedure TQRMBExpr.Reset;
begin
   Evaluator.Reset;
end;

procedure TQRMBExpr.SetMaster(AComponent : TComponent);
begin
  FMaster := AComponent;
end;

procedure TQRMBExpr.QRNotification(Sender : TObject; Operation : TQRNotifyOperation);
begin
  inherited QRNotification(Sender, Operation);
  case Operation of
    qrMasterDataAdvance : Evaluator.DoAggregate;
  end;
end;

{$ifndef QRSTANDARD}
function TQRMBExpr.GetEditorClass : TQRPrintableEditorClass;
begin
  Result := TQRExprEditor;
end;
{$endif}

procedure TQRMBExpr.Prepare;
begin
  inherited Prepare;
  Evaluator.DataSets := ParentReport.AllDataSets;
  Evaluator.Environment := ParentReport.Functions;
  Evaluator.Prepare(FExpression);
  if assigned(FMaster) then
  begin
    if Master is TQuickRep then
      TCustomQuickRep(Master).AddNotifyClient(Self)
    else
      if Master is TQRSubDetail then
        TQRSubDetail(Master).AddNotifyClient(Self);
  end else
    if Evaluator.IsAggreg then ParentReport.AddNotifyClient(Self);
  Reset;
end;

procedure TQRMBExpr.UnPrepare;
begin
  Evaluator.DataSets := nil;
  Evaluator.UnPrepare;
  inherited UnPrepare;
  SetExpression(Expression); { Reset component caption... }
end;

procedure TQRMBExpr.Print(OfsX, OfsY : integer);
var
  aValue : TQREvResult;
begin
  if IsEnabled then
  begin
    aValue := Evaluator.Value;
    case aValue.Kind of
      resInt : FPrintCaption := FormatFloat(Mask, aValue.IntResult * 1.0);
      resString : FPrintCaption := aValue.strResult;
      resDouble :
      begin
          if pos('%m', Mask) > 0 then
             FPrintCaption := Format(Mask,[aValue.DblResult])
          else
             FPrintCaption := FormatFloat(Mask,aValue.DblResult);
      end;
      resBool : if aValue.booResult then FPrintCaption := 'True' else FPrintCaption := 'False'; {<-- do not resource }
      resError : FPrintCaption := aValue.strResult;
    end;
    inherited Print(OfsX, OfsY);
    if ResetAfterPrint then Reset;
  end;
end;

procedure TQRMBExpr.SetExpression(Value : string);
begin
  FExpression := Value;
  if Value='' then
    Caption := '(' + SqrNone + ')'
  else
    Caption := Value;
  Invalidate;
end;

procedure TQRMBExpr.SetMask(Value : string);
begin
  FMask := Value;
  SetExpression(Expression);
end;

{ TQRMBSysData }

constructor TQRMBSysData.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FText := '';
  CreateCaption;
end;

procedure TQRMBSysData.Print(OfsX,OfsY : integer);
begin
  case FData of
    qrsTime : Caption := FText + FormatDateTime('t',SysUtils.Time);
    qrsDate : Caption := FText + FormatDateTime('c',SysUtils.Date);
    qrsDateTime : Caption := FText + FormatDateTime('c',Now);
    qrsPageNumber : Caption := FText + IntToStr(ParentReport.PageNumber);
    qrsReportTitle: Caption := FText + ParentReport.ReportTitle;
    qrsDetailCount: if ParentReport is TQuickRep then
      Caption := FText+IntToStr(TQUickRep(ParentReport).RecordCount);
    qrsDetailNo : if ParentReport is TQuickRep then
      Caption := FText+IntToStr(TQuickRep(ParentReport).RecordNumber);
  end;
  inherited Print(OfsX,OfsY);
end;

procedure TQRMBSysData.CreateCaption;
begin
  case FData of
    qrsTime : Caption := FText + '(' + SqrTime + ')';
    qrsDate : Caption := FText + '(' + SqrDate + ')';
    qrsDateTime : Caption := FText + '(' + SqrDateTime + ')';
    qrsPageNumber : Caption := FText + '(' + SqrPageNum + ')';
    qrsReportTitle: Caption := FText + '(' + SqrReportTitle + ')';
    qrsDetailCount: Caption := FText + '(' + SqrDetailCount + ')';
    qrsDetailNo : Caption := Ftext + '(' + SqrDetailNo + ')';
  end;
  Invalidate;
end;

procedure TQRMBSysData.SetData(Value : TQRSysDataType);
begin
  FData := Value;
  CreateCaption;
end;

procedure TQRMBSysData.SetText(Value : WideString);
begin
  FText := Value;
  CreateCaption;
end;


{ TQRMBExrMemo component }
constructor TQRMBExprMemo.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FRemoveBlankLines := false;
end;

function TQRMBExprMemo.GetCaptionBased : boolean;
begin
  Result := false;
end;

procedure TQRMBExprMemo.Prepare;
begin
  Merger := TQRAnsiMerger.Create;
  Merger.Lines.Assign(Lines);
  Merger.Datasets.Free;  { Free the object already there }
  Merger.Datasets := ParentReport.AllDatasets;
  Merger.Prepare;
  inherited Prepare;
end;

procedure TQRMBExprMemo.UnPrepare;
begin
  Lines.Assign(Merger.Lines);
  Merger.DataSets := nil;
  Merger.UnPrepare;
  Merger.Free;
  inherited UnPrepare;
end;

procedure TQRMBExprMemo.Print(OfsX, OfsY : integer);
var
  I, J : integer;
begin
  Caption := '';
  Merger.Merge;
  if Merger.Prepared then
  begin
    if RemoveBlankLines then
    begin
      J := Merger.MergedLines.Count - 1;
      I := 0;
      while I <= J do
      begin
        if Merger.MergedLines[I] = '' then
        begin
          Merger.MergedLines.Delete(I);
          dec(J);
        end else
          inc(I);
      end;
    end;
    Lines := Merger.MergedLines;
    if (Lines.Count > 0) and (Caption > '') then
      Caption := '';
  end;
  inherited Print(OfsX, OfsY);
  Caption := Name;
end;

procedure TQRMBExprMemo.Paint;
begin
  if (Lines.Count > 0) and (Caption > '') then
    Caption := '';
  inherited Paint;
end;

end.
