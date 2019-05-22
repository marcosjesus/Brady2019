{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 5.0 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRCtrls.pas - PRINTABLE CONTROLS                        ::
  ::                                                         ::
  :: Copyright (c) 2008 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.quickreport.co.uk                       ::
  :: 15/12/2003 fixed print method of TQRImage               ::
  :: 16/12/2003 Added Richtext export                        ::
  :: 20/12/2003 added TQRMemo expanded height                ::
  :: 21/12/2003 added TQRDBRichText expanded height          ::
  :: 03-03-2005 added TQRCustomRichText expanded height
  :: 24/06/2005 fixed jpeg
  :: 20/07/2006 added canvas lock to QRImage.print/Printbitmap
  :: 10/01/2007 fixed GetExpandedHeight for RichRext controls
  :: 15/01/2007 fixed above !
  :: QR5
  :: 9/9/2007 added left and right diagonal lines to TQRShape
  :: added ExportAs property
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

{$I QRDEFS.INC}
{$define QRXDOC}
unit QRCtrls;

interface

uses Messages, Windows, Classes, Controls, StdCtrls, SysUtils, Graphics, Buttons,
     Forms, ExtCtrls, Dialogs, Printers, DB, ComCtrls, RichEdit,
     QRPrntr, QuickRpt, Qr5Const, QRExpr;

{$R-}
{$B-}

type
  { Forward declarations }
  TQRExpr = class;

  TQRLabelOnPrintEvent = procedure (sender : TObject; var Value : string) of object;

  { TQRCustomLabel - base class for printable text components }
  TQRCustomLabel = class(TQRPrintable)
  private
    FCaptionBased : boolean;
    DoneFormat : boolean;
    FAutoSize : boolean;
    FAutoStretch : boolean;
    FCaption : string;
    FWidecaption : widestring;
    FCurrentLine : integer;
    FPrintCaption : string;
    FWideprintcaption : widestring;
    FFontSize : integer;
    FFormattedLines : TStrings;
    FLines : TStrings;
    FOnPrint : TQRLabelOnPrintevent;
    FWordWrap : boolean;
    UpdatingBounds : boolean;
    function GetCaption : string;
    function GetWidecaption : widestring;
    function GetCaptionBased : boolean; virtual;
    procedure SetAutoStretch(Value : boolean);
    procedure SetCaption(Value : string);
    procedure SetWidecaption(Value : widestring);
    procedure SetLines(Value : TStrings);
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
    property Widecaption : widestring read GetWidecaption write SetWidecaption stored true;
    property Color;
    property Font;
    property Lines : TStrings read FLines write SetLines;
    property WordWrap : boolean read FWordWrap write SetWordWrap;
    property ExportAs;
  end;

  { TQRLabel - printable component with published Caption property }
  TQRLabel = class(TQRCustomLabel)
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
    property Widecaption;
    property Color;
    property Font;
    property OnPrint;
    property ParentFont;
    property Transparent;
    property WordWrap;
    property ExportAs;
  end;

  { TQRMemo - printable memo component (published Lines property) }
  TQRMemo = class(TQRCustomLabel)
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

  { TQRDBText }
  TQRDBText = class(TQRCustomLabel)
  private
    ComboBox : TEdit;
    Field : TField;
    FieldNo : integer;
    FieldOK : boolean;
    //DataSourceName : string[30];
    DataSourceName : string;
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
    procedure GetFieldString( var DataStr : string); override;
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

  { TQRExpr }
  TQRExpr = class(TQRCustomLabel)
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
    property ExportAs;
end;

  { TQRSysData }
  TQRSysDataType = (qrsTime,
                    qrsDate,
                    qrsDateTime,
                    qrsPageNumber,
                    qrsReportTitle,
                    qrsDetailCount,
                    qrsDetailNo);

  TQRSysData = class(TQRCustomLabel)
  private
    FData : TQRSysDataType;
    FText : string;
    procedure SetData(Value : TQRSysDataType);
    procedure SetText(Value : string);
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
    property Text : string read FText write SetText;
    property Transparent;
    property ExportAs;
  end;

  { TQRShape }
  TQRShapeType = (qrsRectangle,qrsCircle, qrsVertLine,qrsHorLine, qrsTopAndBottom, qrsRightAndLeft
                  ,qrsRoundRect, qrsLeftDiagonal, qrsRightDiagonal);

  TQRShape = class(TQRPrintable)
  private
    FShape : TQRShapeType;
    FBrush : TBrush;
    FPen : TPen;
    FRoundFactor : single;
    FVertAdjust : integer;
    procedure SetBrush(Value : TBrush);
    procedure SetPen(Value : TPen);
    procedure SetShape(Value : TQRShapeType);
  protected
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure StyleChanged(sender : TObject);
    procedure SetRoundFactor(value : single);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property Brush : TBrush read FBrush write SetBrush;
    property Height default 65;
    property Pen : TPen read FPen write Setpen;
    property Shape : TQRShapeType Read FShape write SetShape;
    property Width default 65;
    property RoundFactor : single read FRoundFactor write SetRoundFactor;
    property VertAdjust : integer read FVertAdjust write FVertAdjust;
  end;

  { TQRImage }
  TQRImage = class(TQRPrintable)
  private
    FPicture: TPicture;
    FAutoSize: Boolean;
    FStretch: Boolean;
    FCenter: Boolean;
    function GetCanvas: TCanvas;
    procedure PictureChanged(Sender: TObject);
    procedure SetCenter(Value: Boolean);
    procedure SetPicture(Value: TPicture);
    procedure SetStretch(Value: Boolean);
  protected
    procedure SetAutoSize(Value: Boolean); override;
    function GetPalette: HPALETTE; override;
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas: TCanvas read GetCanvas;
{$ifdef QREDIT}
    function GetEditorClass : TQRPrintableEditorClass;override;
{$endif}
  published
    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
    property Center: Boolean read FCenter write SetCenter default False;
    property Picture: TPicture read FPicture write SetPicture;
    property Stretch: Boolean read FStretch write SetStretch default False;
    // QR4
    property Visible;
  end;

  { TQRDBImage }
  TQRDBImage = class(TQRPrintable)
  private
    FField : TField;
    FDataSet : TDataSet;
    FDataField : string;
    FPicture: TPicture;
    FStretch: boolean;
    FCenter: boolean;
    FPictureLoaded: boolean;
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
    procedure GetExpandedHeight(var newheight : extended ); override;
    procedure GetFieldString( var DataStr : string); override;
    procedure LoadPicture;
    property Field: TField read FField;
    property Picture: TPicture read FPicture write SetPicture;
  published
    property Center: boolean read FCenter write SetCenter default True;
    property DataField: string read FDataField write SetDataField;
    property DataSet: TDataSet read FDataSet write SetDataSet;
    property Stretch: boolean read FStretch write SetStretch default False;
  end;


  { TQRRichEdit - TQRCustomRichEdit descendant with some special settings }
  TQRRichEdit = class(TCustomRichEdit)
  public
    property BorderStyle;
  end;

  { TQRRichText }
  TQRCustomRichText = class(TQRPrintable)
  private
    LastChar : integer;
    FAutoStretch : boolean;
    FParentRichEdit : TRichEdit;
    FRichEdit : TQRRichEdit;
    function GetAlignment : TAlignment;
    function GetColor : TColor;
    function GetFont : TFont;
    function GetLines : TStrings;
    procedure SetColor(Value : TColor);
    procedure SetFont(Value : TFont);
    procedure SetLines(Value : TStrings);
    procedure SetParentRichEdit(Value : TRichEdit);
  protected
    procedure SetAlignment(Value : TAlignment); override;
    property Lines : TStrings read GetLines write SetLines;
    property ParentRichEdit : TRichEdit read FParentRichEdit write SetParentRichEdit;
    procedure Print(OfsX, OfsY : integer); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight : integer); override;
    function GetControlsAlignment: TAlignment; override;
    procedure GetExpandedHeight( var newheight : extended);override;
  published
    property Alignment : TAlignment read GetAlignment write SetAlignment;
    property AutoStretch : boolean read FAutoStretch write FAutoStretch;
    property Color : TColor read GetColor write SetColor;
    property Font : TFont read GetFont write SetFont;
  end;

  { TQRRichText }
  TQRRichText = class(TQRCustomRichText)
  published
    property Lines;
    property ParentRichEdit;
  end;

  { TQRDBRichText }
  TQRDBRichText = class(TQRCustomRichText)
  private
{$ifdef NEWX}
    FieldOK : boolean;
    FieldNo : integer;
{$endif}
    Field : TField;
    FDataField : string;
    FDataSet : TDataSet;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetDataSet(Value : TDataSet);
    procedure Prepare; override;
    procedure UnPrepare; override;
    procedure Print(OfsX, OfsY : integer); override;
  published
    procedure GetExpandedHeight( var newheight : extended);override;
    procedure GetFieldString( var DataStr : string);override;
    property DataField : string read FDataField write FDataField;
    property DataSet : TDataSet read FDataSet write SetDataSet;
  end;

  { TQRExprMemo }
  TQRMerger = class
  private
    FOrgLines : TStrings;
    FStrippedLines : TStrings;
    FMergedLines : TStrings;
    FMerged : boolean;
    FPrepared : boolean;
    Expressions : TList;
    FDataSets : TList;
  protected
    function GetOrgLines : TStrings;
    function GetMergedLines : TStrings;
    procedure SetOrgLines(Value : TStrings);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Prepare;
    procedure Merge;
    procedure UnPrepare;
    property Lines : TStrings read GetOrgLines write SetOrgLines;
    property MergedLines : TStrings read GetMergedLines;
    property Merged : boolean read FMerged;
    property Prepared : boolean read FPrepared;
    property DataSets :TList read FDataSets write FDataSets;
  end;

  TQRExprMemo = class(TQRCustomLabel)
  private
    Merger : TQRMerger;
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

{ TQRDBCalc - included for backwards compatibility }

  TQRCalcOperation = (qrcSum, qrcCount, qrcMax, qrcMin, qrcAverage);

  TQRDBCalc = class(TQRExpr)
  private
    FDataField : string;
    FDataSource : TDataSource;
    FOperation : TQRCalcOperation;
    FResetBand : TQRBand;
  protected
    function GetPrintMask : string;
    procedure SetDataField(Value : string);
    procedure SetOperation(Value : TQRCalcOperation);
    procedure SetPrintMask(Value : string);
  published
    property DataField : string read FDataField write SetDataField;
    property DataSource : TDataSource read FDataSource write FDataSource;
    property OnPrint;
    property Operation : TQRCalcOperation  read FOperation write SetOperation;
    property ParentFont;
    property PrintMask : string read GetPrintMask write SetPrintMask;
    property ResetBand : TQRBand read FResetBand write FResetBand;
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
  BreakChars : set of WideChar = [' ', #13, '-'];
var
    NextRTFImage : integer;

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

{ TQRCustomLabel }
constructor TQRCustomLabel.Create(AOwner : TComponent);
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
end;

destructor TQRCustomLabel.Destroy;
begin
  FLines.Free;
  FFormattedLines.Free;
  inherited Destroy;
end;

function TQRCustomLabel.GetControlsAlignment: TAlignment;
begin
  Result := Alignment;
end;

function TQRCustomLabel.GetWidecaption : widestring;
begin
  result := FWidecaption;
end;

function TQRCustomLabel.GetCaption : string;
begin
  result := FCaption;
end;

function TQRCustomLabel.GetCaptionBased : boolean;
begin
  Result := FCaptionBased;
end;

procedure TQRCustomLabel.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('FontSize', ReadFontSize, WriteFontSize, true); // Do not translate
  inherited DefineProperties(Filer);
end;

procedure TQRCustomLabel.ReadFontSize(Reader : TReader);
begin
  FFontSize := Reader.ReadInteger;
end;

procedure TQRCustomLabel.WriteFontSize(Writer : TWriter);
begin
  Writer.WriteInteger(Font.Size);
end;

procedure TQRCustomLabel.Loaded;
begin
  inherited Loaded;
  if FFontSize > 0 then
    Font.Size := FFontSize;
end;

procedure TQRCustomLabel.CMFontChanged(var Message: TMessage);
begin
  inherited;
  DoneFormat := false;
 formatlines;
end;

procedure TQRCustomLabel.Prepare;
begin
  inherited Prepare;
  Caption := copy(Caption, 1, length(Caption));
end;

procedure TQRCustomLabel.UnPrepare;
begin
  inherited UnPrepare;
end;

procedure TQRCustomLabel.FormatLines;
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
          until (Line[J] in BreakChars) or (J >= Length(Line));
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

procedure TQRCustomLabel.SetLines(Value : TStrings);
begin
  FLines.Assign(Value);
  DoneFormat := false; {xxx}
  Invalidate;
end;

procedure TQRCustomLabel.PaintToCanvas(aCanvas : TCanvas; aRect : TRect; CanExpand : boolean; LineHeight: integer);
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

procedure TQRCustomLabel.PrintToCanvas(aCanvas : TCanvas; aLeft, aTop, aWidth, aHeight,
                                       LineHeight : extended; CanExpand : boolean);
var
  aRect : TRect;
  ControlBottom : extended;
  X, Y : extended;
  SavedCaption : string;
  NewCaption : string;
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
      ExtTextOut(aCanvas.Handle, QRPrinter.XPos(X), QRPrinter.YPos(Y),
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

procedure TQRCustomLabel.Paint;
begin
  Canvas.Font.Assign(Font);
  if Canvas.Font.Size <> round(Font.Size * Zoom / 100) then
    Canvas.Font.Size := round(Font.Size * Zoom / 100);
  inherited Paint;
  PaintToCanvas(Canvas, rect(0, 0, Width, Height), false, round(Canvas.TextHeight('W')));
  PaintCorners;
end;

procedure TQRCustomLabel.Print(OfsX, OfsY : integer);
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

procedure TQRCustomLabel.SetAutoStretch(Value : boolean);
begin
  FAutoStretch := Value;
  Invalidate;
end;

procedure TQRCustomLabel.SetWidecaption(Value : widestring);
begin
  FWidecaption := Value;
  FWideprintcaption := Value;
  DoneFormat := false;
  FormatLines;
  Invalidate;
end;

procedure TQRCustomLabel.SetCaption(Value : string);
begin
  FCaption := Value;
  FPrintCaption := Value;
  DoneFormat := false;
  FormatLines;
  Invalidate;
end;

procedure TQRCustomLabel.SetName(const Value: TComponentName);
begin
  if ((Caption = '') or (Caption = Name)) then
    Caption := Value;
  inherited SetName(Value);
end;

procedure TQRCustomLabel.SetParent(AParent : TWinControl);
begin
  inherited SetParent(AParent);
  FormatLines;
end;

procedure TQRCustomLabel.SetAlignment(Value : TAlignment);
begin
  inherited SetAlignment(Value);
end;

procedure TQRCustomLabel.SetWordWrap(Value : boolean);
begin
  FWordWrap := Value;
  Invalidate;
end;

{ TQRLabel }

function TQRLabel.GetEditorClass : TQRPrintableEditorClass;
begin
  Result := TQRLabelEditor;
end;

{ TQRMemo }
function TQRMemo.GetCaptionBased : boolean;
begin
  Result := false;
end;

procedure TQRMemo.Paint;
begin
  if (Lines.Count > 0) and (Caption > '') then
    Caption := '';
  inherited Paint;
end;

procedure TQRMemo.Print(OfsX, OfsY : integer);
begin
{  if (Lines.Count > 0) then}
  Caption := '';
  inherited Print(OfsX, OfsY);
  Caption := Name;
end;

procedure TQRMemo.GetExpandedHeight(var newheight : extended );
var
     Nlines : integer;
     lineheight : extended;
     function aLineHeight(Line : string) : integer;
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

{ TQRDBText }

constructor TQRDBText.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  DataSourceName := '';
  ComboBox := nil;
  IsMemo := false;
end;

procedure TQRDBText.GetExpandedHeight(var newheight : extended );
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
      self.getfieldstring( FPrintCaption );
      FormatLines;
      lineheight := aLineHeight( 'W' );
      Nlines := FFormattedLines.Count;
      newheight := nlines * (lineheight);
end;

procedure TQRDBText.GetFieldString( var DataStr : string);
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

procedure TQRDBText.SetDataSet(Value : TDataSet);
begin
  FDataSet := Value;
  if Value <> nil then
    Value.FreeNotification(self);
end;

function TQRDBText.GetCaptionBased : boolean;
begin
  Result := not IsMemo;
end;

procedure TQRDBText.SetDataField(Value : string);
begin
  FDataField := Value;
  Caption := Value;
end;

procedure TQRDBText.Loaded;
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

procedure TQRDBText.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
    if AComponent = FDataSet then
      FDataSet := nil;
end;

procedure TQRDBText.SetMask(Value : string);
begin
  FMask := Value;
end;

procedure TQRDBText.Prepare;
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

procedure TQRDBText.Print(OfsX, OfsY : integer);
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

procedure TQRDBText.UnPrepare;
begin
  Field := nil;
  inherited UnPrepare;
  if DataField <> '' then
    SetDataField(DataField) { Reset component caption }
  else
    SetDataField(Name);
end;

function TQRDBText.UseRightToLeftAlignment: Boolean;
begin
  Result := QRDBUseRightToLeftAlignment(Self, Field);
end;

{ TQRExpr }

constructor TQRExpr.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Evaluator := TQREvaluator.Create;
  FExpression := '';
  FMask := '';
end;

destructor TQRExpr.Destroy;
begin
  Evaluator.Free;
  inherited Destroy;
end;

function TQRExpr.GetValue : TQREvResult;
begin
  if Evaluator.Prepared then
    result := Evaluator.Value
  else
  begin
    //result := TQREvResult.Create;
    result.Kind := resError;
  end;
end;

procedure TQRExpr.Reset;
begin
   Evaluator.Reset;
end;

procedure TQRExpr.SetMaster(AComponent : TComponent);
begin
  FMaster := AComponent;
end;

procedure TQRExpr.QRNotification(Sender : TObject; Operation : TQRNotifyOperation);
begin
  inherited QRNotification(Sender, Operation);
  case Operation of
    qrMasterDataAdvance : Evaluator.DoAggregate;
  end;
end;

{$ifndef QRSTANDARD}
function TQRExpr.GetEditorClass : TQRPrintableEditorClass;
begin
  Result := TQRExprEditor;
end;
{$endif}

procedure TQRExpr.Prepare;
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

procedure TQRExpr.UnPrepare;
begin
  Evaluator.DataSets := nil;
  Evaluator.UnPrepare;
  inherited UnPrepare;
  SetExpression(Expression); { Reset component caption... }
end;

procedure TQRExpr.Print(OfsX, OfsY : integer);
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
    //aValue.Free;
  end;
end;

procedure TQRExpr.SetExpression(Value : string);
begin
  FExpression := Value;
  if Value='' then
    Caption := '(' + SqrNone + ')'
  else
    Caption := Value;
  Invalidate;
end;

procedure TQRExpr.SetMask(Value : string);
begin
  FMask := Value;
  SetExpression(Expression);
end;

{ TQRSysData }

constructor TQRSysData.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FText := '';
  CreateCaption;
end;

procedure TQRSysData.Print(OfsX,OfsY : integer);
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

procedure TQRSysData.CreateCaption;
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

procedure TQRSysData.SetData(Value : TQRSysDataType);
begin
  FData := Value;
  CreateCaption;
end;

procedure TQRSysData.SetText(Value : String);
begin
  FText := Value;
  CreateCaption;
end;

{ TQRShape }

constructor TQRShape.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  width := 65;
  Height := 65;
  FPen := TPen.Create;
  FBrush := TBrush.Create;
  FBrush.OnChange := StyleChanged;
  FPen.OnChange := StyleChanged;
end;

procedure TQRShape.StyleChanged(Sender : TObject);
begin
  invalidate;
end;

procedure TQRShape.SetShape(Value : TQRShapeType);
begin
  if FShape <> value then
  begin
    FShape := Value;
    Invalidate;
  end
end;

procedure TQRShape.SetBrush(Value : TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TQRShape.SetPen(Value : TPen);
begin
  FPen.Assign(value);
end;

procedure TQRShape.SetRoundFactor(Value : single);
begin
  if FRoundFactor <> Value then
  begin
    FRoundFactor := Value;
    Invalidate;
  end;
end;

procedure TQRShape.Paint;
begin
  inherited paint;
  with Canvas do
  begin
    Pen := FPen;
    Brush := FBrush;
    Case FShape of
      qrsRectangle : Rectangle(0,0,Width,Height);
      qrsRoundRect : RoundRect( 0, 0, Width, Height,
             Trunc(Width * RoundFactor), Trunc(Width * RoundFactor));
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
      qrsRightDiagonal : begin
          MoveTo(0,0);
          LineTo(width,Height);
        end;
      qrsLeftDiagonal : begin
          MoveTo(width,0);
          LineTo(0,Height);
        end;
    end;
  end
end;

procedure TQRShape.Print(OfsX,OfsY : Integer);
begin
  if parentreport.Exporting and IsEnabled then   // 3/06/04 bug fix
  begin
         TQRExportFilter(ParentReport.ExportFilter).acceptgraphic(
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
        case FShape of
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
          qrsRoundRect : RoundRect(XPos(OfsX + Size.Left), YPos(OfsY + Size.Top),
                         XPos(OfsX+Size.Left + Size.Width), YPos(OfsY + Size.Top + Size.Height),
                         Trunc(Width * RoundFactor), Trunc(Width * Roundfactor));
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
          qrsRightDiagonal : Begin
              MoveTo(XPos(OfsX + Size.Left), YPos(OfsY + Size.Top));
              LineTo(Xpos(OfsX + Size.Left + Size.Width), YPos(OfsY + Size.Top + Size.Height));
            end;
          qrsLeftDiagonal : Begin
              MoveTo(XPos(OfsX + Size.Left + Size.Width), YPos(OfsY + Size.Top));
              LineTo(Xpos(OfsX + Size.Left), YPos(OfsY + Size.Top + Size.Height));
            end;
        end
      end
    end
  end
end;

destructor TQRShape.Destroy;
begin
  FPen.Free;
  FBrush.Free;
  inherited Destroy;
end;

{ TQRImage }

constructor TQRImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  Height := 105;
  Width := 105;
end;

destructor TQRImage.Destroy;
begin
  FPicture.Free;
  inherited Destroy;
end;

procedure TQRImage.SetAutoSize(Value: Boolean);
begin
  FAutoSize := Value;
  PictureChanged(Self);
end;

function TQRImage.GetPalette: HPALETTE;
begin
  Result := 0;
  if FPicture.Graphic is TBitmap then
    Result := TBitmap(FPicture.Graphic).Palette;
end;

{$ifdef QREDIT}
function TQRImage.GetEditorClass : TQRPrintableEditorClass;
begin
  Result := TQRImageEditor;
end;
{$endif}

procedure TQRImage.Paint;
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

procedure TQRImage.Print(OfsX,OfsY : Integer);
var
  Dest : TRect;
  DC, SavedDC : THandle;
begin
  if parentreport.Exporting then
  begin
         TQRExportFilter(ParentReport.ExportFilter).acceptgraphic(
                              qrprinter.XPos(OfsX + self.Size.Left),
                              qrprinter.YPos(OfsY+ self.size.top ), self );
  end;
  Dest.Top := QRPrinter.YPos(OfsY + Size.Top);
  Dest.Left := QRPrinter.XPos(OfsX + Size.Left);
  Dest.Right := QRPrinter.XPos(OfsX + Size.Width + Size.Left);
  Dest.Bottom := QRPrinter.YPos(OfsY + Size.Height + Size.Top);
  if Stretch then
  begin
        if Picture.Graphic is TBitmap then
              TBitmap(Picture.Graphic).Canvas.Lock;
        QRPrinter.Canvas.StretchDraw(Dest, Picture.Graphic);
        if Picture.Graphic is TBitmap then
              TBitmap(Picture.Graphic).Canvas.Unlock;
  end
  else
  begin
    IntersectClipRect(QRPrinter.Canvas.Handle, Dest.Left, Dest.Top, Dest.Right, Dest.Bottom);
    DC := GetDC(QRPrinter.Canvas.Handle);
    SavedDC := SaveDC(DC);
    Dest.Right := Dest.Left +
      round(Picture.Width / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.XFactor);
    Dest.Bottom := Dest.Top +
      round(Picture.Height / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.YFactor);
    if Center then OffsetRect(Dest, (QRPrinter.XSize(Size.Width) -
        round(Picture.Width / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.XFactor)) div 2,
      (QRPrinter.YSize(Size.Height) -
        round(Picture.Height / Screen.PixelsPerInch * 254 * ParentReport.QRPrinter.YFactor)) div 2);
   // PrintBitmap restored 21/03/2005
    if Picture.Graphic is TBitmap then
    begin
      PrintBitmap( QRPrinter.Canvas, Dest, TBitmap(Picture.Graphic));
    end
    else
    begin // new actions for Metafile case
      if Picture.Graphic is TMetaFile then
      begin
        QRPrinter.Canvas.StretchDraw(Dest, Picture.Metafile);
      end
      else
      begin
          QRPrinter.Canvas.StretchDraw(Dest, Picture.Graphic);
      end;
    end;
    //sleep(20);
    RestoreDC(DC, SavedDC);
    SelectClipRgn(QRPrinter.Canvas.Handle, 0);
  end;
  inherited Print(OfsX,OfsY); // paints the frame
end;

function TQRImage.GetCanvas: TCanvas;
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

procedure TQRImage.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    PictureChanged(Self);
  end;
end;

procedure TQRImage.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TQRImage.SetStretch(Value: Boolean);
begin
  if Value <> FStretch then
  begin
    FStretch := Value;
    PictureChanged(Self);
  end;
end;

procedure TQRImage.PictureChanged(Sender: TObject);
begin
  if AutoSize and (Picture.Width > 0) and (Picture.Height > 0) then
    SetBounds(Left, Top, Picture.Width, Picture.Height);
  if (Picture.Graphic is TBitmap) and (Picture.Width >= Width) and
    (Picture.Height >= Height) then
    ControlStyle := ControlStyle + [csOpaque] else
    ControlStyle := ControlStyle - [csOpaque];
  Invalidate;
end;

{ TQRDBImage }

constructor TQRDBImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csFramed, csOpaque];
  Width := 105;
  Height := 105;
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  FCenter := True;
end;

destructor TQRDBImage.Destroy;
begin
  FPicture.Free;
  inherited Destroy;
end;

procedure TQRDBImage.Prepare;
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

// return value in screen pixels
procedure TQRDBImage.GetExpandedHeight(var newheight : extended );
var
  DrawPict: TPicture;
begin
    newheight := self.Height; // default in case of failure.
    DrawPict := TPicture.Create;
    try
      if assigned(FField) and (FField is TBlobField) then
      begin
        DrawPict.Assign(FField);
        newheight := DrawPict.Bitmap.Height;
      end
    finally
       drawpict.free;
    end;
end;

procedure TQRDBImage.GetFieldString( var DataStr : string);
begin
end;

procedure TQRDBImage.Print(OfsX, OfsY : integer);
var
  H: integer;
  Dest: TRect;
  DrawPict: TPicture;
begin
  if parentreport.Exporting then
  begin
         TQRExportFilter(ParentReport.ExportFilter).acceptgraphic(
                              qrprinter.XPos(OfsX + self.Size.Left),
                              qrprinter.YPos(OfsY+ self.size.top ), self );
  end;
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
        if Stretch then
        begin
          if (DrawPict.Graphic = nil) or DrawPict.Graphic.Empty then
            FillRect(Dest)
          else
            with QRPrinter.Canvas do
              StretchDraw(Dest, DrawPict.Graphic);
        end else
        begin
          IntersectClipRect(Handle, Dest.Left, Dest.Top, Dest.Right, Dest.Bottom);
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
  inherited Print(OfsX,OfsY);
end;

procedure TQRDBImage.UnPrepare;
begin
  FField := nil;
  inherited UnPrepare;
end;

procedure TQRDBImage.SetDataSet(Value: TDataSet);
begin
  FDataSet := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TQRDBImage.SetDataField(const Value: string);
begin
  FDataField := Value;
end;

function TQRDBImage.GetPalette: HPALETTE;
begin
  Result := 0;
  if FPicture.Graphic is TBitmap then
    Result := TBitmap(FPicture.Graphic).Palette;
end;

procedure TQRDBImage.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    Invalidate;
  end;
end;

procedure TQRDBImage.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TQRDBImage.SetStretch(Value: Boolean);
begin
  if FStretch <> Value then
  begin
    FStretch := Value;
    Invalidate;
  end;
end;

procedure TQRDBImage.Paint;
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

procedure TQRDBImage.PictureChanged(Sender: TObject);
begin
  FPictureLoaded := True;
  Invalidate;
end;

procedure TQRDBImage.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = DataSet) then
    DataSet := nil;
end;

procedure TQRDBImage.LoadPicture;
begin
  if not FPictureLoaded and (Field is TBlobField) then
    Picture.Assign(FField);
end;


{ TQRCusomRichText }

constructor TQRCustomRichText.Create(AOwner : TComponent);
begin
  FRichEdit := nil;
  inherited Create(AOwner);
  FRichEdit := TQRRichEdit.Create(self);// was self
  FRichEdit.Parent := self;
  FRichEdit.BorderStyle := bsNone;
  AutoStretch := false;
  PrintFinished := true;
  Width := 100;
  Height := 100;
end;

destructor TQRCustomRichText.Destroy;
begin
  FRichEdit.Free;
  inherited Destroy;
end;

function TQRCustomRichText.GetControlsAlignment: TAlignment;
begin
  Result := FRichEdit.Alignment;
end;

function TQRCustomRichText.GetAlignment : TAlignment;
begin
  result := FRichEdit.Alignment;
end;

function TQRCustomRichText.GetColor : TColor;
begin
  result := FRichEdit.Color;
end;

function TQRCustomRichText.GetFont : TFont;
begin
  result := FRichEdit.Font;
end;

function TQRCustomRichText.GetLines : TStrings;
begin
  result := FRichEdit.Lines;
end;

procedure TQRCustomRichText.Print(OfsX, OfsY : integer);
var
  Range: TFormatRange;
  TextLength : integer;
  HasExpanded : boolean;
  OldMapMode : integer;
  ARichEdit : TCustomRichEdit;
  Expanded : extended;
  RTFImage : TQRImage;
  expht, expwid : integer;
  RTFMeta : TMetafile;
  saveFont : TFont;
  TextLen : TGetTextLengthEx;

  function Render(RenderIt : boolean) : integer;
  begin
    if RenderIt then
      Result := SendMessage(ARichEdit.Handle, EM_FORMATRANGE, 0, Longint(@Range))
    else
      Result := SendMessage(ARichEdit.Handle, EM_FORMATRANGE, 1, Longint(@Range));
  end;

begin
  saveFont := TFont.Create;
  saveFont.Assign(ParentReport.QRPrinter.Canvas.Font);
  if assigned(FParentRichEdit) then
    ARichEdit := ParentRichEdit
  else
    ARichEdit := FRichEdit;
  FillChar(Range, SizeOf(TFormatRange), 0);
  with Range do
  begin
    hdc := ParentReport.QRPrinter.Canvas.Handle;
    if ParentReport.QRPrinter.Destination = qrdMetafile then
            hdcTarget := hdc
    else
            hdcTarget := ParentReport.QRPrinter.PrinterHandle;

    LogX := GetDeviceCaps(hdc, LOGPIXELSX);
    LogY := GetDeviceCaps(hdc, LOGPIXELSY);

    rc := Rect(QRPrinter.XPos(OfsX + Size.Left) * 1440 div LogX,
               QRPrinter.YPos(OfsY + Size.Top) * 1440 div LogY,
               QRPrinter.XPos(OfsX + Size.Left + Size.Width) * 1440 div LogX,
               QRPrinter.YPos(OfsY + Size.Top + Size.Height) * 1440 div LogY);
    rcPage := Rect(0, 0, QRPrinter.XSize(QRPrinter.PaperWidth) * 1440 div LogX,
                         QRPrinter.YSize(QRPrinter.PaperLength) * 1440 div LogY);

    if PrintFinished then
      LastChar := 0;
    HasExpanded := false;
    Expanded := 0;
    TextLen.CodePage := 1200;  // Unicode
    TextLen.Flags := GTL_NUMCHARS;
    TextLength := SendMessage(ARichedit.Handle, EM_GETTEXTLENGTHEX, LPARAM(@TextLen), 0);
    chrg.cpMax := -1;
    chrg.cpMin := LastChar;
    OldMapMode := SetMapMode(hdc, MM_TEXT);
    LastChar := Render(false);
    if (LastChar < TextLength) and AutoStretch and (Parent is TQRCustomBand) and (TextLength > 0) then
    begin
      PrintFinished := false;
      while (LastChar <= TextLength) and TQRCustomBand(Parent).CanExpand(50) do
      begin
        TQRCustomBand(Parent).ExpandBand(50, Expanded, HasExpanded);
        rc.Bottom := QRPrinter.YPos(OfsY + Size.Top + Size.Height + Expanded) * 1440 div LogY;
        LastChar := Render(false);
      end;
      LastChar := Render(true);
      if (LastChar >= TextLength) or (LastChar = -1) then
      begin
        LastChar := TextLength;
        PrintFinished := true;
      end
    end
    else
    begin
      LastChar := Render(true);
      PrintFinished := true;
      inherited;
    end;
  end;

  if parentreport.Exporting then
  begin
       RTFImage := TQRImage.create(nil);
       rtfimage.FAutoSize := true;
       rtfImage.Name := name + '_' + inttostr( nextRTFImage);
       inc(nextRTFImage);
       rtfmeta := TMetafile.Create;
//{$define HIRES}
{$ifdef HIRES}
       // using printer resolution
       printer.BeginDoc;
       LogX := GetDeviceCaps(printer.Canvas.handle, LOGPIXELSX);
       LogY := GetDeviceCaps(printer.Canvas.handle, LOGPIXELSY);
       metacanvas := TMetafilecanvas.Create( rtfmeta, printer.Canvas.handle);
       rtfImage.tag := 12345;
       rtfmeta.height := round((range.rc.bottom-range.rc.top) *LogX/1440.0);
       rtfmeta.width := round((range.rc.Right-range.rc.left) *LogX/1440.0);
{$else}
       rtfmeta.height := round((range.rc.bottom-range.rc.top) *LogX/1440.0);
       rtfmeta.width := round((range.rc.Right-range.rc.left) *LogX/1440.0);
       metacanvas := TMetafilecanvas.Create( rtfmeta, qrprinter.Canvas.handle);
       rtfImage.tag := 0;
{$endif}
       expwid := round((range.rc.Right-range.rc.left) *LogX/1440.0);
       expht := round((range.rc.bottom-range.rc.top) *LogX/1440.0);
       range.hdc := metaCanvas.Handle;
       range.hdcTarget := metaCanvas.Handle;
       SetMapMode(range.hdc, MM_TEXT);
       range.rc := rect( 0, 0, expwid * 1440 div LogX, expht * 1440 div LogY);
       range.rcPage := rect( 0, 0, expwid * 1440 div LogX, 2*expht * 1440 div LogY);
       SendMessage(ARichEdit.Handle, EM_FORMATRANGE, 1, Longint(@Range));
       // MUST free the canvas before the metafile has an image (thanks, Bill)
       metacanvas.free;
       rtfimage.FPicture.Assign( rtfMeta);
       // set up the image control export
       rtfimage.Size.Left := size.Left;
       rtfimage.Size.width := size.width;
       rtfimage.Size.top := size.top;
       rtfimage.Size.height := size.height;
       rtfimage.Width := round((range.rc.Right-range.rc.left) *LogX/1440.0);
       rtfimage.Height := round((range.rc.bottom-range.rc.top) *LogX/1440.0);
{$ifdef HIRES}
       printer.Abort;
{$endif}

       TQRExportFilter(ParentReport.ExportFilter).acceptgraphic(
                              qrprinter.XPos(OfsX + rtfimage.Size.Left),
                              qrprinter.YPos(OfsY+ rtfimage.size.top ), rtfimage );
       rtfimage.free;
       rtfMeta.free;
  end;
  ParentReport.QRPrinter.Canvas.Font.Assign(saveFont);
  saveFont.Free;
  SetMapMode(ParentReport.QRPrinter.Canvas.Handle, OldMapMode);
  if PrintFinished then
    SendMessage(ARichEdit.Handle, EM_FORMATRANGE, 0, 0);
end;

procedure TQRCustomRichText.GetExpandedHeight( var newheight : extended);
var
  Range: TFormatRange;
  LogX, LogY : integer;
  TextLength, heightInc, oldBottom : integer;
  ARichEdit : TCustomRichEdit;
  dummy : string;
  rtfMeta : TMetafile;
  TextLen : TGetTextLengthEx;

begin
    if assigned(FParentRichEdit) then
        ARichEdit := ParentRichEdit
    else
       ARichEdit := FRichEdit;
    GetFieldString( dummy);
    FillChar(Range, SizeOf(TFormatRange), 0);
    if ParentReport.QRPrinter.Canvas <> nil then
          Range.hdc := ParentReport.QRPrinter.Canvas.Handle
    else
    begin
       rtfmeta := TMetafile.Create;
       rtfmeta.height := 2500;
       rtfmeta.width := 2500;
       metacanvas := TMetafilecanvas.Create( rtfmeta, rtfMeta.handle);
       range.hdc := metacanvas.Handle;
       range.hdcTarget := metacanvas.Handle;
    end;
    if ParentReport.QRPrinter.Destination = qrdMetafile then
            Range.hdcTarget := range.hdc
    else
            Range.hdcTarget := ParentReport.QRPrinter.PrinterHandle;

    LogX := GetDeviceCaps(Range.hdc, LOGPIXELSX);
    LogY := GetDeviceCaps(Range.hdc, LOGPIXELSY);
    // twips
    Range.rc := Rect(QRPrinter.XPos(0 + Size.Left) * 1440 div LogX,
               QRPrinter.YPos(0 + Size.Top) * 1440 div LogY,
               QRPrinter.XPos(0 + Size.Left + Size.Width) * 1440 div LogX,
               QRPrinter.YPos(0 + Size.Top + Size.Height) * 1440 div LogY);
    Range.rcPage := Rect(0, 0, QRPrinter.XSize(QRPrinter.PaperWidth) * 1440 div LogX,
                         QRPrinter.YSize(QRPrinter.PaperLength) * 1440 div LogY);

    LastChar := 0;
    TextLen.CodePage := 1200;  // Unicode
    TextLen.Flags := GTL_NUMCHARS;
    TextLength := SendMessage(ARichedit.Handle, EM_GETTEXTLENGTHEX, LPARAM(@TextLen), 0);
    Range.chrg.cpMax := -1;
    Range.chrg.cpMin := LastChar;
    LastChar := SendMessage(ARichEdit.Handle, EM_FORMATRANGE, 0, Longint(@Range));
    heightInc := 50;
    oldBottom := 0;
    if (LastChar < TextLength) and (TextLength > 0) then
    begin
      // text did not fit so keep expanding
      while (LastChar <= TextLength) do
      begin
           Range.rc.Bottom := Range.rc.Bottom + round(QRPrinter.YFactor * heightInc * 1440 / LogY);
           LastChar := SendMessage(ARichEdit.Handle, EM_FORMATRANGE, 0, Longint(@Range));
           if Range.rc.Bottom = oldbottom then
              inc( heightInc, 20);
           oldbottom := Range.rc.Bottom;
           if lastchar = -1 then break; // render failed ?
      end;
    end;
    //result must be in pixels
    newHeight := (range.rc.Bottom - range.rc.Top)/1440;// - round(QRPrinter.YFactor * heightInc * 96) )/ 1440; // inches
    newheight := newheight * 96 * 0.37795; // ??? works because the reverse is done in the band.Expandedheight
    // free resources in control
   SendMessage(ARichEdit.Handle, EM_FORMATRANGE, 0, 0);
end;

procedure TQRCustomRichText.SetAlignment(Value : TAlignment);
begin
  FRichEdit.Alignment := Value;
end;

procedure TQRCustomRichText.SetColor(Value : TColor);
begin
  FRichEdit.Color := Value;
end;

procedure TQRCustomRichText.SetFont(Value : TFont);
begin
  FRichEdit.Font := Value;
end;

procedure TQRCustomRichText.SetBounds(ALeft, ATop, AWidth, AHeight : integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if FRichEdit <> nil then FRichEdit.SetBounds(1, 1, AWidth - 2, AHeight - 2);
end;

procedure TQRCustomRichText.SetLines(Value : TStrings);
begin
  FRichEdit.Lines := Value;
  if assigned(FParentRichEdit) then
    FParentRichEdit.Lines := Value;
end;

procedure TQRCustomRichText.SetParentRichEdit(Value : TRichEdit);
begin
  FParentRichEdit := Value;
  if Value<>nil then
    FRichEdit.Lines := Value.Lines;
end;

{ TQRDBRichText }

procedure TQRDBRichText.SetDataSet(Value : TDataSet);
begin
  FDataSet := Value;
  if Value<>nil then
    Value.FreeNotification(self);
end;

procedure TQRDBRichText.GetFieldString( var DataStr : string);
begin
  if IsEnabled then
  begin
    Prepare;
    if assigned(Field) then
    begin
      try
        if (Field is TMemoField) or (Field is TBlobField) then
        begin
          // caution : Lines is a property of self
          Lines.Text := TMemoField(Field).AsString;
        end
        else
          if (Field is TStringField) then
            if not (Field is TBlobField) then
              DataStr := Field.DisplayText
            else
              DataStr := Field.AsString;
      except
        DataStr := '';
      end;
    end
    else
      DataStr := '';
  end;
end;

procedure TQRDBRichText.GetExpandedHeight( var newheight : extended);
begin
  if assigned(Field) then
    if (Field is TMemoField) or
       (Field is TBlobField) then
       begin
          Lines.Assign(Field);
       end;
  inherited GetExpandedHeight(newheight);
end;

procedure TQRDBRichText.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
    if AComponent=FDataSet then
      FDataSet := nil;
end;

procedure TQRDBRichText.Prepare;
begin
  inherited Prepare;
  if assigned(FDataSet) then
  begin
    Field := FDataSet.FindField(FDataField);
    if (Field is TBlobField) or (Field is TMemoField) then
    begin
      Caption := '';
    end;
  end else
    Field := nil;
end;

{$ifdef NEWX}
procedure TQRDBRichText.Print(OfsX, OfsY : integer);
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

        if assigned(Field) then
          if (Field is TMemoField) or
            (Field is TBlobField) then
            Lines.Assign(Field);

      except

      end;

    end;
    inherited Print(OfsX, OfsY);
  end;
end;
{$else}
procedure TQRDBRichText.Print(OfsX, OfsY : integer);
var s: TMemorystream;
    Function UniToAnsi(value:UniCodeString):AnsiString;
    var uniEnc,AnsiEnc : TEncoding;
    Begin
      uniEnc:=TEncoding.Unicode;
      AnsiEnc:=TEncoding.ASCII;
      result:=AnsiEnc.GetString(uniEnc.convert(uniEnc,AnsiEnc,uniEnc.GetBytes(value)));
    End;
begin
  if assigned(Field) then
    if (Field is TMemoField) or
       (Field is TBlobField) then
       begin
          s:=TMemoryStream.Create;
          try
            s.SetSize(length(field.AsString));
            StrPCopy(s.Memory,UniToAnsi(field.AsString));
            s.Seek(0,sofrombeginning);
            Lines.LoadFromStream(s);
          finally
            s.Free;
          end;
//          Lines.Assign(Field);
       end;
  inherited Print(OfsX,OfsY);
end;
{$endif}
procedure TQRDBRichText.UnPrepare;
begin
  Field := nil;
  inherited UnPrepare;
end;

{ TQRExprMemo }

type
  TMemoEvaluator = class(TQREvaluator)
  public
    Line : integer;
    Position : integer;
  end;

constructor TQRMerger.Create;
begin
  FOrgLines := TStringList.Create;
  FMergedLines := nil;
  FMerged := false;
  FPrepared := false;
  Expressions := nil;
  FDataSets := TList.Create;
end;

destructor TQRMerger.Destroy;
begin
  if Prepared then UnPrepare;
  if FOrgLines <> nil then
    FOrgLines.Free;
  if FDataSets <> nil then
    FDataSets.Free;
  inherited Destroy;
end;

function TQRMerger.GetOrgLines : TStrings;
begin
  Result := FOrgLines;
end;

function TQRMerger.GetMergedLines : TStrings;
begin
  if Merged then
    Result := FMergedLines
  else
    Result := nil;
end;

procedure TQRMerger.SetOrgLines(Value : TStrings);
begin
  if FOrgLines <> nil then
    FOrgLines.Free;
  FOrgLines := Value;
end;

procedure TQRMerger.Prepare;
var
  I, start, stop, Len : integer;
  Expr : String;
  aLine : string;
  aEvaluator : TMemoEvaluator;
begin
  if Prepared then UnPrepare;
  Expressions := TList.Create;
  FMergedLines := TStringList.Create;
  if Lines.Count > 0 then
  begin
    FStrippedLines := TStringList.Create;
    try
      for I := 0 to Lines.Count - 1 do
      begin
        aLine := FOrgLines[I];
        Start := AnsiPos('{', aLine);
        while Start > 0 do
        begin
          stop := AnsiPos('}', aLine);
          Len := Stop - Start - 1;
          if Len > 0 then
          begin
            Expr := copy(aLine, start + 1, Len);
            Delete(aLine, Start, Len + 2);
            aEvaluator := TMemoEvaluator.Create;
            aEvaluator.DataSets := DataSets;
            aEvaluator.Prepare(Expr);
            aEvaluator.Line := I;
            aEvaluator.Position := Start;
            Expressions.Add(aEvaluator);
          end;
          Start := AnsiPos('{', aLine);
        end;
        FStrippedLines.Add(aLine);
      end;
    finally
      FPrepared := true;
    end;
  end;
end;

procedure TQRMerger.UnPrepare;
var
  I : integer;
begin
  if Prepared then
  try
    for I := 0 to Expressions.Count - 1 do
      TMemoEvaluator(Expressions[I]).Free;
    FStrippedLines.Free;
  finally
    FPrepared := false;
    FMerged := false;
  end;
  FMergedLines.Free;
  Expressions.Free;
end;

procedure TQRMerger.Merge;
var
  I : integer;
  aResult : TQREvResult;
  Replacement : string;
  aLine : string;
begin
  if (Expressions.Count > 0) then
  begin
    if Merged then
      FMergedLines.Clear;
    FMergedLines.Assign(FStrippedLines);
    for I := Expressions.Count - 1 downto 0 do
    begin
      with TMemoEvaluator(Expressions[I]) do
      begin
        aResult := Value;
        case aResult.Kind of
          resInt : Replacement := IntToStr(aResult.IntResult);
          resDouble : Replacement := FloatToStr(aResult.dblResult);
          resString : Replacement := aResult.StrResult;
          resError : Replacement := '';
        end;
        aLine := FMergedLines[Line];
        Insert(Replacement, aLine, Position);
        FMergedLines[Line] := aLine;
      end;
    end
  end else
    if not Merged then
      FMergedLines.Assign(FOrgLines);
  FMerged := true;
end;

{ TQRExrMemo component }

constructor TQRExprMemo.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FRemoveBlankLines := false;
end;

function TQRExprMemo.GetCaptionBased : boolean;
begin
  Result := false;
end;

procedure TQRExprMemo.Prepare;
begin
  Merger := TQRMerger.Create;
  Merger.Lines.Assign(Lines);
  Merger.Datasets.Free;  { Free the object already there }
  Merger.Datasets := ParentReport.AllDatasets;
  Merger.Prepare;
  inherited Prepare;
end;

procedure TQRExprMemo.UnPrepare;
begin
  Lines.Assign(Merger.Lines);
  Merger.DataSets := nil;
  Merger.UnPrepare;
  Merger.Free;
  inherited UnPrepare;
end;

procedure TQRExprMemo.Print(OfsX, OfsY : integer);
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

procedure TQRExprMemo.Paint;
begin
  if (Lines.Count > 0) and (Caption > '') then
    Caption := '';
  inherited Paint;
end;

function TQRDBCalc.GetPrintMask : string;
begin
  Result := Mask;
end;

procedure TQRDBCalc.SetDataField(Value : string);
begin
  FDataField := Value;
  SetOperation(Operation);
end;

procedure TQRDBCalc.SetOperation(Value : TQRCalcOperation);
begin
  FOperation := Value;
  case FOperation of
    qrcSum : Expression := 'Sum('+DataField+')';         {<-- do not resource}
    qrcCount : Expression := 'Count';                    {<-- do not resource}
    qrcMax : Expression := 'Max('+DataField+')';         {<-- do not resource}
    qrcMin : Expression := 'Min('+DataField+')';         {<-- do not resource}
    qrcAverage : Expression := 'Average('+DataField+')'; {<-- do not resource}
  end
end;

procedure TQRDBCalc.SetPrintMask(Value : string);
begin
  Mask := Value;
end;

end.
