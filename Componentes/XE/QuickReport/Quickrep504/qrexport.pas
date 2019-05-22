{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 5.0 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QREXPORT.PAS - EXPORT FILTERS                           ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.qusoft.com                              ::
  :: Removed old HTML code                                   ::
  :: Fixed concatenating code                                ::
  :: 2008/08 Add text encoding properties and code           ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

{$I QRDEFS.INC}
unit QRExport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, QRPrntr,
  QuickRpt, Db, StdCtrls, QRCtrls, QR5Const, Printers, forms;

type
  TTextEntry = class(TPersistent)
  private
    FText : string;
    XPos, YPos : extended;
    FAlignment : TAlignment;
    TextFont : TFont;
  end;

  TQRAbstractExportFilter = class(TQRExportFilter)
  private
    Entries : TList;
    FStream : TStream;
    FCharWidth,
    FCharHeight,
    FPaperWidth,
    FPaperHeight : extended;
    FLineCount,
    FColCount : integer;
    FLastSheetrow : integer;
    FPageProcessed : boolean;
    FFont : TFont;
    FActiveFont : TFont;
  protected
     function GetEncoding : TTextEncoding;
     procedure SetEncoding( value : TTextEncoding);
    function GetLinecount : Integer;
    procedure SetLinecount( value : integer);
    function GetText(X, Y : extended; var Font : TFont) : string;
    function GetFilterName : string; override;
    function GetDescription : string; override;
    function GetExtension : string; override;
    procedure WriteToStream(const AText : string);
    procedure WriteLnToStream(const AText : string);
    procedure CreateStream(Filename : string); virtual;
    procedure CloseStream; virtual;
    procedure ClearEntries;
    procedure ProcessPage; virtual;
    procedure ConvertToColumns;
    procedure ConvertToLines;
    procedure StorePage; virtual;
    property Stream : TStream read FStream write FStream;
    property PageProcessed : boolean read FPageProcessed write FPageProcessed;
    property CharWidth : extended read FCharWidth write FCharWidth;
    property CharHeight : extended read FCharHeight write FCharHeight;
    property PaperWidth : extended read FPaperWidth write FPaperWidth;
    property PaperHeight : extended read FPaperHeight write FPaperHeight;
    property LineCount : integer read GetLineCount write SetLineCount;
    property ColCount : integer read FColCount write FColCount;
  public
    PositionLatitude : extended;
    procedure Start(PaperWidth, PaperHeight : integer; Font : TFont); override;
    procedure EndPage; override;
    procedure Finish; override;
    procedure NewPage; override;
    procedure AcceptGraphic( Xoff, Yoff : extended; GControl : TControl); override;
    procedure TextOut(X, Y : extended; Font : TFont; BGColor : TColor; Alignment : TAlignment; Text : string); override;
    property TextEncoding : TTextEncoding read GetEncoding write SetEncoding;
  end;

  TQRCommaSeparatedFilter = class(TQRAbstractExportFilter)
  protected
    function GetFilterName : string; override;
    function GetDescription : string; override;
    function GetExtension : string; override;
  public
    procedure StorePage; override;
    procedure Finish; override;
    property TextEncoding;
  end;

  TQRCSVFilter = class(TComponent)
  protected
    function GetSeparator : char;
    procedure SetSeparator(Value : char);
  private
     function GetEncoding : TTextEncoding;
     procedure SetEncoding( value : TTextEncoding);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property Separator : char read GetSeparator write SetSeparator;
    property TextEncoding : TTextEncoding read GetEncoding write SetEncoding;
  end;

{$ifndef QRSTANDARD}
  //TCellType = (CellBlank, CellInteger, CellDouble, CellLabel, CellBoolean, CellFormula);
  TCellType = (CellBlank, CellInteger, CellDouble, CellLabel, CellBoolean);

  TQRXLSFilter = class(TQRAbstractExportFilter)
  protected
    function GetFilterName : string; override;
    function GetDescription : string; override;
    function GetExtension : string; override;
    function GetStreaming : boolean; override;
    procedure CreateStream(Filename : string); override;
    procedure CloseStream; override;
    procedure WriteRecordHeader(RecType, Size : integer);
    procedure WriteData(CellType : TCellType; ARow, ACol: Integer; Cell : string); virtual;
  private
    FReportNum : integer;
  public
    Concatenating : boolean;
    constructor Create( filename : string); override;
    procedure StorePage; override;
    procedure EndConcat;
    procedure Start(PaperWidth, PaperHeight : integer; Font : TFont); override;
    procedure TextOut(X, Y : extended; Font : TFont; BGColor : TColor; Alignment : TAlignment; Text : string); override;
    procedure Finish; override;
    property TextEncoding;
  end;

  TQRExcelFilter = class(TComponent)
  private
     function GetEncoding : TTextEncoding;
     procedure SetEncoding( value : TTextEncoding);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property TextEncoding : TTextencoding read GetEncoding write SetEncoding;
  end;

const
  // This a lookup table of the Delphi defined colors
  QRRTFColors: array[0..17] of TColor =
    (clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal,
    clGray, clSilver, clRed, clLime, clYellow, clBlue, clFuchsia,
    clAqua, clLtGray, clDkGray, clWhite);

  // We define a quick lookup table of the RTF font family control
  // words.  Windows only supports items 0-5, the last two are defined
  // by Microsoft but are not used in the LOGFONT structure
  QRRTFFontFamily: array[0..7] of string =
   ('\fnil', '\froman', '\fswiss', '\fmodern', '\fscript', '\fdecor',
    '\ftech', '\fbidi');

type
  // The TQRRTFItem class defines an object that represents a field
  // from the report.  Multiple line fields will generate an TQRRTFItem
  // for each line.

  TQRRTFItem = class
    FontColor: TColor;
    FontStyle: TFontStyles;
    FontSize: integer;
    RTFFont: integer;
    x,y: extended;
    Alignment: TAlignment;
    Text: string;
  end;

  // the TQRRTFLineItem class is a container of TQRRTFItem objects.
  // It is basicly a list of fields for a line from the report

  TQRRTFLineItem = class
    RTFItems: TList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ClearLineItems;
    procedure Add(value: TQRRTFItem);
  end;

  TQRRTFExportFilter = class(TQRExportFilter)
  private
    LineCount : integer;
    RTFLines: TList;
    aFile : text;
    XFactor,
    YFactor : extended;

    Header,
    FontTable,
    ColorTable,
    DefaultLanguage,
    NewPar,
    ResetPar : string;
    PendingPageBreak : boolean;
    Started : boolean;
    Concatenating : boolean;
    aTop, aBottom, aLeft, aRight, aLength, aWidth: extended;
  protected
    function GetFilterName : string; override;
    function GetDescription : string; override;
    function GetExtension : string; override;
    procedure CreateRTFLines;
    procedure DestroyRTFLines;
     function GetEncoding : TTextEncoding;
     procedure SetEncoding( value : TTextEncoding);
  public
    procedure StartConcat;
    procedure EndConcat;
    procedure Start(PaperWidth, PaperHeight : integer; Font : TFont); override;
    procedure EndPage; override;
    procedure Finish; override;
    procedure NewPage; override;
    procedure TextOut(X,Y : extended; Font : TFont; BGColor : TColor; Alignment : TAlignment; Text : string); override;
    property TextEncoding : TTextEncoding read GetEncoding write SetEncoding;
  end;

  TQRRTFFilter = class(TComponent)
  private
    function GetEncoding : TTextEncoding;
    procedure SetEncoding( value : TTextEncoding);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property TextEncoding : TTextencoding read GetEncoding write SetEncoding;
  end;

  TQRWMFExportFilter = class(TQRExportFilter)
  private
    aBase: string;
  protected
    function GetFilterName : string; override;
    function GetDescription : string; override;
    function GetExtension : string; override;
     function GetEncoding : TTextEncoding;
     procedure SetEncoding( value : TTextEncoding);
  public
    procedure Start(PaperWidth, PaperHeight : integer; Font : TFont); override;
    procedure EndPage; override;
    procedure Finish; override;
    procedure NewPage; override;
    procedure TextOut(X,Y : extended; Font : TFont; BGColor : TColor; Alignment : TAlignment; Text : string); override;
    property TextEncoding : TTextEncoding read GetEncoding write SetEncoding;
  end;

  TQRWMFFilter = class(TComponent)
  protected
    function GetEnhanced : boolean;
    procedure SetEnhanced(Value : boolean);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property Enhanced : boolean read GetEnhanced write SetEnhanced;
  end;

{$endif}

  { TQRAsciiExportFilter }
  TQRAsciiExportFilter = class(TQRExportFilter)
  private
    Lines : array[0..200] of string;
    LineCount : integer;
    XFactor,
    YFactor : extended;
    FinalDoc : TStringlist;
  protected
    function GetFilterName : string; override;
    function GetDescription : string; override;
    function GetExtension : string; override;
     function GetEncoding : TTextEncoding;
     procedure SetEncoding( value : TTextEncoding);
  public
    procedure Start(PaperWidth, PaperHeight : integer; Font : TFont); override;
    procedure EndPage; override;
    procedure Finish; override;
    procedure NewPage; override;
    procedure TextOut(X,Y : extended; Font : TFont; BGColor : TColor; Alignment : TAlignment; Text : string); override;
    property TextEncoding : TTextEncoding read GetEncoding write SetEncoding;
  end;

  TQRTextFilter = class(TComponent)
  private
    function GetEncoding : TTextEncoding;
    procedure SetEncoding( value : TTextEncoding);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property TextEncoding : TTextencoding read GetEncoding write SetEncoding;
  end;
 //var
 //   trace : TStringlist;

implementation

uses qrexpr;

type
  TQRPositions = class
  protected
    function CloseTo( p1, p2 : extended) : boolean;
  private
    List : TList;
    Updating : boolean;
    IgnoreClientCount : boolean;
    FPositionLatitude : extended;
  public
    constructor Create;
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Add(Position : extended);
    function NewPosition(Position : extended) : integer;
  end;

  TQRPositionEntry = class
  private
    ExactPosition : extended;
    NewPosition : integer;
    Clients : integer;
    Stored : boolean;
  public
    constructor Create(Position : extended);
  end;

var
  CSV_Separator : char;
  WMF_Enhanced : boolean;
  RTF_VertAdj: integer;
  GTextEncoding : TTextEncoding;

function ColorToHTMLColor(Color : TColor) : string;
begin
  Result := IntToHex(Color, 6);
  Result := copy(Result, 5,2) + copy(result, 3, 2) + copy(Result, 1, 2);
end;

constructor TQRPositionEntry.Create(Position : extended);
begin
  NewPosition := 0;
  Clients := 1;
  ExactPosition := Position;
  Stored := False;
end;

constructor TQRPositions.Create;
begin
  List := TList.Create;
  Updating := False;
  IgnoreClientCount := False;
  FPositionLatitude := 4.0;
end;

destructor TQRPositions.Destroy;
begin
  while List.Count > 0 do
  begin
    TQRPositionEntry(List[0]).Free;
    List.Delete(0);
  end;
  List.Free;
  inherited Destroy;
end;

procedure TQRPositions.BeginUpdate;
begin
  Updating := True;
end;

procedure TQRPositions.EndUpdate;
var
  I, J : integer;
  Min : extended;
  No : integer;
begin
  Updating := False;
  No := 0;
  for I := 0 to List.Count - 1 do
  begin
    Min := 9999999;
    for J := 0 to List.Count - 1 do
      with TQRPositionEntry(List[J]) do
      begin
        if (ExactPosition > 0) and
           (ExactPosition < Min) and
//           ((Clients > 1) or (IgnoreClientCount)) and
           not Stored then
        begin
           Min := ExactPosition;
           No := J;
        end;
      end;
    with TQRPositionEntry(List[No]) do
    begin
      NewPosition := I + 1;
      Stored := True;
    end;
  end;
end;

function TQRPositions.CloseTo( p1, p2 : extended ): boolean;
begin
     result := abs( p1-p2) <= FPositionLatitude;
end;

function TQRPositions.NewPosition(Position : extended) : integer;
var
  I : integer;
begin
  Result := 0;
  for I := 0 to List.Count - 1 do
  begin
    // use a much looser test
    if CloseTo( TQRPositionEntry(List[I]).ExactPosition, Position) then
    //if round(TQRPositionEntry(List[I]).ExactPosition) = round(Position) then
    begin
      Result := TQRPositionEntry(List[I]).NewPosition;
      Exit;
    end;
  end;
end;

procedure TQRPositions.Add(Position : extended);
var
  I : integer;
begin
  if Updating then
  begin
    for I := 0 to List.Count - 1 do
      if round(TQRPositionEntry(List[I]).ExactPosition) = round(Position) then
      begin
        inc(TQRPositionEntry(List[I]).Clients);
        Exit;
      end;
    List.Add(TQRPositionEntry.Create(Position));
  end;
end;

function TQRAbstractExportFilter.GetEncoding : TTextEncoding;
begin
     result := GTextEncoding;
end;

procedure TQRAbstractExportFilter.SetEncoding( value : TTextEncoding);
begin
     GTextEncoding := value;
end;

function TQRAbstractExportFilter.GetLinecount : Integer;
begin
    result := FLinecount;
end;

procedure TQRAbstractExportFilter.SetLinecount( value : integer);
begin
    FLinecount := value;
end;

function TQRAbstractExportFilter.GetFilterName : string;
begin
  result := 'QRAbstract'; // Do not translate
end;

function TQRAbstractExportFilter.GetDescription : string;
begin
  Result := '';
end;

function TQRAbstractExportFilter.GetExtension : string;
begin
  Result := '';
end;

procedure TQRAbstractExportFilter.Start(PaperWidth, PaperHeight : integer; Font : TFont);
begin
  CreateStream(Filename);
  Entries := TList.Create;
  FFont := TFont.Create;
  FActiveFont := TFont.Create;
  FFont.Assign(Font);
  CharHeight := Font.Size * (254 / 72);
  CharWidth := Font.Size * (254 / 72);
  FPaperHeight := PaperHeight;
  FPaperWidth := PaperWidth;
  LineCount := round(PaperHeight / CharHeight);
  FPageProcessed := false;
  positionlatitude := 4.0;
  inherited Start(PaperWidth, PaperHeight, Font);
end;


procedure TQRAbstractExportFilter.CreateStream(Filename : string);
begin
  FStream := TFileStream.Create(Filename, fmCreate);
end;

procedure TQRAbstractExportFilter.CloseStream;
begin
  FStream.Free;
end;

procedure TQRAbstractExportFilter.WriteToStream(const AText : string);
begin
  Stream.Write(AText[1], length(AText)*2);
end;

procedure TQRAbstractExportFilter.WriteLnToStream(const AText : string);
begin
  WriteToStream(AText + #13 + #10);
end;


procedure TQRAbstractExportFilter.Finish;
begin
  ClearEntries;
  Entries.Free;
  FFont.Free;
  FActiveFont.Free;
  CloseStream;
  inherited Finish;
end;

procedure TQRAbstractExportFilter.ClearEntries;
var
  aEntry : TTextEntry;
begin
  while Entries.Count > 0 do
  begin
    aEntry := Entries[0];
    Entries.Delete(0);
    AEntry.TextFont.Free;
    aEntry.Free;
  end;
end;

procedure TQRAbstractExportFilter.NewPage;
begin
  if Entries.Count > 0 then
    ClearEntries;
  FPageProcessed := False;
  FActiveFont.Free;
  FActiveFont := TFont.Create;
  inherited NewPage;
end;

procedure TQRAbstractExportFilter.EndPage;
begin
  ProcessPage;
  ClearEntries;
  inherited EndPage;
end;

procedure TQRAbstractExportFilter.ConvertToColumns;
var
  I : integer;
begin
  //trace.Add('ConvertToCols');
  with TQRPositions.Create do
  try
    FPositionLatitude := PositionLatitude;
    BeginUpdate;
    for I := 0 to Entries.Count - 1 do
      if TObject(Entries[I]) is TTextEntry then
      begin
        Add(TTextEntry(Entries[I]).XPos);
        //trace.add( 'add to positions ' + inttostr(I) + ' '
        //              + floattostr( TTextEntry(Entries[I]).XPos));
      end;
    EndUpdate;
    FColCount := 0;
    for I := 0 to Entries.Count - 1 do
      if TObject(Entries[I]) is TTextEntry then
      begin
          TTextEntry(Entries[I]).XPos := NewPosition(TTextEntry(Entries[I]).XPos);
          //trace.add( 'new position ' + inttostr(I) + ' '
          //            + floattostr( TTextEntry(Entries[I]).XPos));
          if TTextEntry(Entries[I]).XPos > FColCount then
            FColCount := round(TTextEntry(Entries[I]).XPos);
      end;
  finally
    Free;
  end;
end;

procedure TQRAbstractExportFilter.ConvertToLines;
var
  I : integer;
begin
  with TQRPositions.Create do
  try
    IgnoreClientCount := True;
    BeginUpdate;
    for I := 0 to Entries.Count - 1 do
      if TObject(Entries[I]) is TTextEntry then
        with TTextEntry(Entries[I]) do
          Add(YPos);
    EndUpdate;
    LineCount := 0;
    for I := 0 to Entries.Count - 1 do
      if TObject(Entries[I]) is TTextEntry then
        with TTextEntry(Entries[I]) do
        begin
          YPos := NewPosition(YPos);
          if YPos > FLineCount then
            LineCount := round(YPos);
        end;
  finally
    Free;
  end;
end;

procedure TQRAbstractExportFilter.ProcessPage;
begin
  FPageProcessed := True;
  ConvertToColumns;
  ConvertToLines;
  StorePage;
end;

procedure TQRAbstractExportFilter.StorePage;
begin
end;

procedure TQRAbstractExportFilter.AcceptGraphic( Xoff, Yoff : extended; GControl : TControl);
begin
    inherited;
end; 

procedure TQRAbstractExportFilter.TextOut(X, Y : extended; Font : TFont; BGColor : TColor; Alignment : TAlignment; Text : string);
var
  aTextEntry : TTextEntry;
begin
  aTextEntry := TTextEntry.Create;
  with aTextEntry do
  begin
    XPos := X;
    YPos := Y;
    FText := Text;
    FAlignment := Alignment;
    TextFont := TFont.Create;
    TextFont.Assign(Font);
  end;
  Entries.Add(aTextEntry);
end;

function TQRAbstractExportFilter.GetText(X, Y : extended; var Font : TFont) : string;
var
  I : integer;
begin
  Result := '';
  for I := 0 to Entries.Count - 1 do
  begin
    if TObject(Entries[I]) is TTextEntry then
      with TTextEntry(Entries[I]) do
        if (X = XPos) and (Y = YPos) then
        begin
          Result := FText;
          Font := TextFont;
          Exit;
        end;
  end;
end;

{CSV filter}
procedure TQRCommaSeparatedFilter.finish;
var
  enc : TQRTextEncoding;
begin
   FStream.Free;
   enc := TQRTextEncoding.Create;
   case TextEncoding of
     ASCIIEncoding: finaldoc.SaveToFile(Filename, enc.ASCII);
     BigEndianUnicodeEncoding: finaldoc.SaveToFile(Filename, enc.BigEndianUnicode);
     DefaultEncoding: finaldoc.SaveToFile(Filename, enc.Default);
     UnicodeEncoding: finaldoc.SaveToFile(Filename, enc.Unicode);
     UTF7Encoding: finaldoc.SaveToFile(Filename, enc.UTF7);
     UTF8Encoding: finaldoc.SaveToFile(Filename, enc.UTF8);
   end;
   finaldoc.free;
   enc.Free;
end;

function TQRCommaSeparatedFilter.GetFilterName : string;
begin
  Result := SqrCommaSeparated;
end;

function TQRCommaSeparatedFilter.GetDescription : string;
begin
  Result := SqrCommaSeparatedTextFilter;
end;

function TQRCommaSeparatedFilter.GetExtension : string;
begin
  Result := 'CSV'; // Do not translate
end;

procedure TQRCommaSeparatedFilter.StorePage;
var
  X, Y : integer;
  Font : TFont;
  outstr : string;
begin
  for Y := 1 to LineCount do
  begin
    outstr := '';
    for X := 1 to ColCount do
    begin
      outstr := outstr + '"'+GetText(X, Y, Font)+'"';
      if X = ColCount then
          finaldoc.Add(outstr)
      else
          outstr := outstr + CSV_Separator;
    end;
  end;
end;

constructor TQRCSVFilter.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  QRExportFilterLibrary.AddFilter(TQRCommaSeparatedFilter);
  Separator := ',';
end;

destructor TQRCSVFilter.Destroy;
begin
  QRExportFilterLibrary.RemoveFilter(TQRCommaSeparatedFilter);
  inherited Destroy;
end;

function TQRCSVFilter.GetEncoding : TTextEncoding;
begin
     result := GTextEncoding;
end;

procedure TQRCSVFilter.SetEncoding( value : TTextEncoding);
begin
     GTextEncoding := value;
end;

function TQRCSVFilter.GetSeparator : char;
begin
  Result := CSV_Separator;
end;

procedure TQRCSVFilter.SetSeparator(Value : char);
begin
  CSV_Separator := Value;
end;

function FontValue(Size : integer) : integer;
begin
  if Size <= 8 then Result := 0
  else
    if Size <= 10 then Result := 1
    else
      if Size <= 12 then Result := 2
      else
        if Size <= 14 then Result := 3
        else
          if Size <= 18 then Result := 4
          else
            if Size <= 24 then Result := 5
            else
              Result := 7;
end;

function HTMLFontSizeAdjust(Size1, Size2 : integer) : string;
var
  Diff : integer;
begin
  Diff := FontValue(Size1) - FontValue(Size2);
  if Diff >= 0 then
    Result := '+' + IntToStr(Diff)
  else
    Result := IntToStr(Diff);
end;


const
  BOF       = $0009;
  BIT_BIFF5 = $0800;
  BOF_BIFF5 = BOF or BIT_BIFF5;
  BIFF_EOF = $000a;
  DIMENSIONS = $0200;
  DOCTYPE_XLS = $0010;
  LEN_RECORDHEADER = 4;
  XLACCUMROW = '___XLGlobRow';


{$ifndef QRSTANDARD}
constructor TQRXLSFilter.Create( filename : string);
begin
      inherited Create( filename);
      PositionLatitude := 1.0;
end;

procedure TQRXLSFilter.TextOut(X, Y : extended; Font : TFont; BGColor : TColor; Alignment : TAlignment; Text : string);
var
    NY : extended;
begin
     NY := Y;
     inherited TextOut(X, NY, Font, BGColor, Alignment, Text );
end;

procedure TQRXLSFilter.EndConcat;
begin
    Concatenating := false;
    Finish;
end;

procedure TQRXLSFilter.Start(PaperWidth, PaperHeight : integer; Font : TFont);
begin
     if concatenating and (FReportNum > 0 ) then
          exit;
     inherited Start(PaperWidth, PaperHeight, Font);
     //trace := tstringlist.create;
     FLastSheetrow := -1;
end;

procedure TQRXLSFilter.Finish;
begin
    inc( FReportnum);
    if not concatenating then
    begin
        //trace.SaveToFile('xlstrace.txt');
        //trace.Free;
        inherited Finish;
    end
    else
       FPaperheight := FReportNum * FPaperheight;
end;

function TQRXLSFilter.GetFilterName : string;
begin
  Result := SqrExcel;
end;

function TQRXLSFilter.GetDescription : string;
begin
  Result := SqrExcelFile;
end;

function TQRXLSFilter.GetExtension : string;
begin
  Result := 'XLS'; // Do not translate
end;

function TQRXLSFilter.GetStreaming : boolean;
begin
  Result := true;
end;

procedure TQRXLSFilter.CreateStream(Filename : string);
var
  Buffer : array[0..4] of word;
  EvSheetRow : TQREvElement;
begin
  inherited CreateStream(Filename);
  Buffer[0] := 0;
  Buffer[1] := DOCTYPE_XLS;
  Buffer[2] := 0;
  WriteRecordHeader(BOF_BIFF5, 6);
  Stream.Write(Buffer, 6);
  Buffer[0] := 0;
  Buffer[1] := LineCount;
  Buffer[2] := 0;
  Buffer[3] := ColCount;
  Buffer[4] := 0;
  WriteRecordHeader(Dimensions, 10);
  Stream.Write(Buffer, 10);
  if (owner <> nil) and (owner is TCustomQuickRep) then begin
    EvSheetRow := TCustomQuickRep(owner).Functions.GetConstant(XLACCUMROW);
    if EvSheetRow = nil then
      TCustomQuickRep(owner).Functions.AddFunction(XLACCUMROW, '0')
    else
      TCustomQuickRep(owner).Functions.SetIntegerConstant(EvSheetRow, 0);
  end;
end;

procedure TQRXLSFilter.CloseStream;
begin
  WriteRecordHeader(BIFF_EOF, 0);
  inherited CloseStream;
end;

// CJM: Added code to update the progress bar as the data is being exported
procedure TQRXLSFilter.StorePage;
var
  I, J : integer;
  Cell, sCell : string;
  Font : TFont;
  NotUsed: extended;
  aQRPrinter: TQRPrinter;
  SheetRow: integer;
  EvSheetRow : TQREvElement;
  Env: TQREvEnvironment;
  NewPageWasForced: boolean;
  aForm: TForm;
  function StripSep(inval : string): string;
  var i : integer;
  begin
    result := '';
    for i := 1 to length(inval) do begin
      if inval[i] <> SysUtils.ThousandSeparator then
        result := result + inval[i];
    end;
  end;
begin
  //if not concatenating or (FReportNum = 0) then
  //begin
      SheetRow := 0;
      EvSheetRow := nil;
      Env := nil;
      aForm := nil;
      NewPageWasForced := false;
      if (owner <> nil) and (owner is TCustomQuickRep) then
      begin
        aQRPrinter := TCustomQuickRep(owner).QRPrinter;
        try
          Env := TCustomQuickRep(owner).Functions;
          if Env.IndexOf(XLACCUMROW) >= 0 then
          begin
            EvSheetRow := Env.GetConstant(XLACCUMROW);
            SheetRow := EvSheetRow.Value(nil).intResult;
            // A quick check to see if this report has forced
            // a new page.
            NewPageWasForced := SheetRow > 0;
          end;
         finally
        end;
      end
    else
      aQRPrinter := nil;
  //end;

  // If the report did not force a new page, the StorePage method will
  // only get called once, after all the data has been read.  The
  // following code will change the caption of the progress form
  // so that user has some visual feedback to what is going on.
  if (not NewPageWasForced) and (LineCount > 0) then begin
    for i := pred(Screen.FormCount) downto 0 do
      with Screen.Forms[i] do
        if ClassName = 'TQRProgressForm' then begin
          aForm := Screen.Forms[i];
          break;
        end;
    if Assigned(aForm) then
      aForm.Caption := SqrWritingXLS;
  end;
  if FReportNum > 0 then
                 Sheetrow := FLastSheetrow;
  for I := 0 to LineCount - 1 do
  begin
    // If a new page was forced in the report, StorePage will be
    // called repeatedly.  The NewPageWasForced check will keep the
    // progress form from "ping-ponging"
    if (aQRPrinter <> nil) and (not NewPageWasForced) then begin
      aQRPrinter.Progress := (longint(I) * 100) div LineCount;
      Application.ProcessMessages;
    end;
    for J := 0 to ColCount - 1 do
    begin
      Cell := GetText(J + 1, I + 1, Font);
      if Cell <> '' then
      begin
        // CJM
        // Check to see what kind of value we have.  Strip out the
        // thousands separator in a copy of the value so we can check
        // to see if it is numeric.
        sCell := StripSep(Cell);
        if TextToFloat(PChar(sCell), NotUsed, fvExtended) then
          WriteData(CellDouble, SheetRow, J, sCell)
        //else if sCell[1]='=' then
        //  WriteData(CellFormula, SheetRow, J, Cell)
        else
          WriteData(CellLabel, SheetRow, J, Cell);
      end;
    end;
    inc(SheetRow);
  end;
  if sheetrow > FLastSheetrow then FLastsheetrow := sheetrow;
  if Assigned(Env) then
  begin
    Env.SetIntegerConstant(EvSheetRow, SheetRow);
  end;
end;

procedure TQRXLSFilter.WriteRecordHeader(RecType, Size : integer);
var
  Buffer : array[0..1] of word;
begin
  Buffer[0] := RecType;
  Buffer[1] := Size;
  Stream.Write(Buffer, SizeOf(Buffer));
end;

procedure TQRXLSFilter.WriteData(CellType : TCellType; ARow, ACol: Integer; Cell : string);
const
  Attribute: Array[0..2] Of Byte = (0, 0, 0); { 24 bit bitfield }
var
  Buffer : array[0..1] of word;
  RecType : word;
  Size : word;
  AString : ShortString;
  aInt: integer;
  aDbl: double;
  Data: Pointer;
begin
  Buffer[0] := ARow;
  Buffer[1] := ACol;
  AString := Cell;
  Data := nil;

  case CellType of
    CellInteger   : begin
                    RecType := 2;
                    //Size := 9;
                    Size := 11;
                    WriteRecordHeader(RecType, Size);
                    //Size := 2;
                    Size := 4;
                    aInt := StrToInt(Cell);
                    Data := @aInt;
                  end;
    CellDouble   : begin
                    RecType := 3;
                    Size := 15;
                    WriteRecordHeader(RecType, Size);
                    Size := 8;
                    aDbl := StrToFloat(Cell);
                    Data := @aDbl;
                  end;
    CellLabel   : begin
                    RecType := 4;
                    Size := length(Cell) + 8;
                    WriteRecordHeader(RecType, Size);
                  end;
                  {
    CellFormula   : begin
                    RecType := 6; // from spec. code 0x022 is DATEMODE
                    Size := length(Cell) + 8;
                    WriteRecordHeader(RecType, Size);
                  end;  }
  else
    exit;
  end;
  Stream.Write(Buffer, SizeOf(Buffer));
  Stream.Write(Attribute, SizeOf(Attribute));
  if CellType = CellLabel then
    Stream.Write(AString, Length(AString) + 1)
//else if CellType = CellFormula then
//  Stream.Write(AString, Length(AString) + 1)
  else
    Stream.Write(Data^, Size);
end;

constructor TQRExcelFilter.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  QRExportFilterLibrary.AddFilter(TQRXLSFilter);
end;

destructor TQRExcelFilter.Destroy;
begin
  QRExportFilterLibrary.RemoveFilter(TQRXLSFilter);
  inherited Destroy;
end;

function TQRExcelFilter.GetEncoding : TTextEncoding;
begin
     result := GTextEncoding;
end;

procedure TQRExcelFilter.SetEncoding( value : TTextEncoding);
begin
     GTextEncoding := value;
end;

var
  RTFFontList: TStringList;

// This is a callback function to get a list of all of the installed
// fonts.
function QRRTFEnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
var
  S: TStrings;
  Temp: string;
  Family: integer;
begin
  S := TStrings(Data);
  Temp := LogFont.lfFaceName;
  Family := LogFont.lfPitchAndFamily shr 4;
  if (S.Count = 0) or (AnsiCompareText(S[S.Count-1], Temp) <> 0) then
    S.AddObject(Temp, TObject(Family));
  Result := 1;
end;

procedure GetAllFonts;
var
  DC: HDC;
  LFont: TLogFont;
begin
  DC := GetDC(0);
  RTFFontList.Clear;

  try
    RTFFontList.Sorted := False;
    if Lo(GetVersion) >= 4 then
    begin
      FillChar(LFont, sizeof(LFont), 0);
      LFont.lfCharset := DEFAULT_CHARSET;
      EnumFontFamiliesEx(DC, LFont, @QRRTFEnumFontsProc, LongInt(RTFFontList), 0);
    end
    else
      EnumFonts(DC, nil, @QRRTFEnumFontsProc, Pointer(RTFFontList));
    RTFFontList.Sorted := TRUE;
  finally
    ReleaseDC(0, DC);
  end;
end;

// This function will build a RTF color tag for the specified
// color if it can find it on the list.  Colors not in this
// list will be considered black.  This should be addressed
// in a future release.
function RTFColorTag(Color : TColor): string;
var
  i: integer;
begin
  // If the color is not in the predefined list, then ignore it
  result := '';

  // Black is assumed to be the default color, we check the rest
  // of the colors
  for i := low(QRRTFColors) + 1 to high(QRRTFColors) do
    if QRRTFColors[i] = Color then
    begin
      result := '\cf' + IntToStr(i) + ' ';
      break;
    end;
end;

// Take a TColor variable and convert it to the RTF color table
function ColorToRTFColor(Color : TColor) : string;
begin
  Result := IntToHex(Color, 6);
  Result := format('\red%.1d\green%.1d\blue%.1d;',
             [StrToInt('$'+copy(Result, 5, 2)),
             StrToInt('$'+copy(Result, 3, 2)),
             StrToInt('$'+copy(Result, 1, 2))]);
end;

constructor TQRRTFLineItem.Create;
begin
  inherited Create;
  RTFItems := TList.Create;
end;

destructor TQRRTFLineItem.Destroy;
begin
  ClearLineItems;
  RTFItems.Free;
  inherited Destroy;
end;

// TQRRTFLineItem.Add
// function: Adds field to the lineitem list.  The horizontal location
// is checked to place the control in the list in the correct order
procedure TQRRTFLineItem.Add(value: TQRRTFItem);
var
  NewPos,
  nIdx: integer;
begin
  NewPos := -1;
  for nIdx := 0 to RTFItems.Count-1 do
  begin
    if TQRRTFItem(RTFItems[nIdx]).x > value.x then
    begin
      NewPos := nIdx;
      break;
    end;
  end;

  if NewPos = -1 then
    RTFItems.Add(value)
  else
    RTFItems.insert(NewPos, value)
end;

procedure TQRRTFLineItem.ClearLineItems;
var
  nIdx: integer;
begin
  for nIdx := 0 to RTFItems.Count-1 do
  begin
    TQRRTFItem(RTFItems[nIdx]).Free;
    RTFItems[nIdx] := nil;
  end;
  RTFItems.Clear;
end;

function TQRRTFExportFilter.GetEncoding : TTextEncoding;
begin
     result := GTextEncoding;
end;

procedure TQRRTFExportFilter.SetEncoding( value : TTextEncoding);
begin
     GTextEncoding := value;
end;

function TQRRTFExportFilter.GetDescription : string;
begin
  result := SqrRTFExportFilter;
end;

function TQRRTFExportFilter.GetFilterName : string;
begin
  result := SqrRTFFile;
end;

function TQRRTFExportFilter.GetExtension : string;
begin
  result := 'RTF';    // Do not localize
end;

procedure TQRRTFExportFilter.Start(PaperWidth, PaperHeight : integer; Font : TFont);
var
  I : integer;
  aReport: TCustomQuickRep;
  aUnit: TQRUnit;
  IsLandScape: boolean;
begin
  if started then exit;
  started := true;
  if (owner <> nil) and (owner is TCustomQuickRep) then
    aReport := TCustomQuickRep(owner)
  else
    aReport := nil;

  // Starting with QR 3.0.2, the export filter's owner property
  // is set to the report that called it.  This allows us to get
  // page settings for the report.
  if aReport = nil then
  begin
    // Set the default margins of for some reason we don't have the
    // owner property set correctly
    aTop := 720;
    aBottom := 720;
    aLeft := 720;
    aRight := 720;
    aLength := 0;
    aWidth := 0;
    IsLandScape := false;
  end
  else
  begin
    with aReport do
    begin
      // Save the current units
      aUnit := Units;

      // Set the units to Inches to make it easy to convert margins
      // to twips
      Units := Inches;

      aLength := Page.Length * 1440;
      aWidth := Page.Width * 1440;
      aTop := Page.TopMargin * 1440;
      aBottom := Page.BottomMargin * 1440;
      aLeft := Page.LeftMargin * 1440;
      aRight := Page.RightMargin * 1440;

      IsLandScape := Page.Orientation = poLandscape;

      // restore the units - may not be needed
      Units := aUnit;
    end;
  end;

  GetAllFonts;
  AssignFile(aFile, Filename);
  Rewrite(aFile);

  // Make sure that the frst page doesn't start with a pagebreak
  PendingPageBreak := False;

  // Best guess approximation of the number of lines on a page
  YFactor := Font.Size * (254 / 72);

  // CJM: We raised the line count to fix a problem when the user
  // used smaller fonts than the report's main font.
  YFactor := (254 / 72);

  XFactor := Font.Size * (254 / 72);
  LineCount := round(PaperHeight / YFactor);

  Header := '{\rtf1';  // RTF version - do not change
  Header := Header +'\ansi';  // Character set
  Header := Header +'\deff0';
  Header := Header +'\deftab720'; // Default tab width in twips (the default is 720)

  // Set the paper size
  if aLength > 0 then begin
    Header := Header + '\paperh' + IntToStr(round(aLength)); // Set page length
    Header := Header + '\paperw' + IntToStr(round(aWidth));  // Set page width
    Header := Header + '\psz' + IntToStr(integer(aReport.PrinterSettings.PaperSize));  // Set paper size
  end;


  Header := Header + '\margl' + IntToStr(round(aLeft));  // Set the left margin
  Header := Header + '\margr' + IntToStr(round(aRight));  // Set the right margin
  Header := Header + '\margt' + IntToStr(round(aTop));  // Set the top margin
  Header := Header + '\margb' + IntToStr(round(aBottom));  // Set the bottom margin

  if IsLandScape then
    Header := header + '\landscape';

  // Since the programmer can change the fonts at runtime, the fastest
  // way to build a list of fons that can be used is to store a list
  // in memory of all of the fonts in the system
  FontTable := '{\fonttbl';
  for i := 0 to RTFFontList.Count -1 do
  begin
    FontTable := FontTable + '{\f' + IntToStr(I) +
      QRRTFFontFamily[Integer(RTFFontList.Objects[I])] +
      ' ' + RTFFontList[I] + ';}';  // Font #, name
  end;
  FontTable := FontTable + '}';  // End of font table definition;

  // Build a color table from the usual Delphi defines
  ColorTable := '{\colortbl';
  for i := low(QRRTFColors) to high(QRRTFColors) do
    ColorTable := ColorTable + ColorToRTFColor(QRRTFColors[i]);
  ColorTable := ColorTable + '}';

  DefaultLanguage := '\deflang1033'; // English

  ResetPar := '\pard\plain'; // default paragraph, default fonts
  NewPar := '\par ';

  Writeln(aFile, Header + FontTable);
  Writeln(aFile, ColorTable);
  Writeln(aFile, DefaultLanguage);
end;

procedure TQRRTFExportFilter.StartConcat;
begin
    Started := false;
    Concatenating := true;
end;

procedure TQRRTFExportFilter.EndConcat;
begin
    concatenating := false;
    Finish;
end;

procedure TQRRTFExportFilter.EndPage;
var
  I, j : integer;
  twipx, twipy, MaxFontY : integer;
  LastY: extended;
  TabStops, s, row: string;
  aQRRTFItem: TQRRTFItem;
begin
  // On pages after the 1st page, output the pagebreak tag for
  // the preceding page
  if PendingPageBreak then
    Writeln(aFile, '{\page }');

  // We go through each line and generate the RTF code to format it.
  // The export filter code will call EndPage before the first page
  // so we make sure that RTFLines is assigned (in NewPage) before
  // processing the data
  if Assigned(RTFLines) then
  begin
    LastY := aTop * (254.0/1440.0);
    MaxFontY := 0;
    for I := 0 to RTFLines.Count -1 do
    begin
      s := '{\plain';
      TabStops := '';
      row := '';
      with TQRRTFLineItem(RTFLines[I]) do
      begin
        // Get each field from the current line
        for j := 0 to RTFItems.Count-1 do
        begin
          aQRRTFItem := TQRRTFItem(RTFItems[j]);

          // Calculate how far down this line is from the previous
          // line.  We only need to do this once per line
          if TabStops = '' then begin
            TabStops := '\pard\plain';
            TwipY := round((aQRRTFItem.y - LastY) * (1440.0/254.0)) -
              (MaxFontY * 10) - RTF_VertAdj;
            // If vertical spacing is required, add it to the line
            // This may not display correctly in WordPad or in the TRichEdit
            // control
            if TwipY > 0 then
              TabStops := TabStops + '\sb' + IntToStr(TwipY);
          end;

          // Store the largest font size
          if aQRRTFItem.FontSize > MaxFontY then
            MaxFontY := aQRRTFItem.FontSize;

          // Store the highest Y value for this line
          if aQRRTFItem.y > LastY then
            LastY := aQRRTFItem.y;

          // Convert the quickreport coordinates to
          // twips.  Each QR unit is 1/254 of an inch
          // and there 1440 twips to an inch
          // We subtract the left margin to get the correct tab stop.
          // RTF does not like a tab stop of 0, so we add 20 to keep
          // the formatting intact.
          twipx := round((aQRRTFItem.x * (1440.0/254.0)) - aLeft) + 20;

          // Set the alignment.  Please note that this tag is
          // ignored by the RichEdit common control and will
          // not be used by WordPad or the Delphi/C++Builder RTF
          // controls.
          case aQRRTFItem.Alignment of
            taLeftJustify: TabStops := TabStops + '\tql';
            taRightJustify: TabStops := TabStops + '\tqr';
            taCenter: TabStops := TabStops + '\tqc';
          end;

          // Set the positions of each item on this line
          TabStops := TabStops + '\tx' + IntToStr(twipx);

          // Output each item starting with the tab
          // We include the \plain tag so that attributes
          // will be reset for each field
          row := row + '\tab\plain';

          // If we know the font (we should), we specify it now.
          if aQRRTFItem.RTFFont >= 0 then
            row := row + '\f' + IntToStr(aQRRTFItem.RTFFont);

          // Set the font size
          row := row + '\fs' +  IntToStr(aQRRTFItem.FontSize);

          // set the font style(s)
          if fsBold in aQRRTFItem.FontStyle then row := row + '\b';
          if fsItalic in aQRRTFItem.FontStyle then row := row + '\i';
          if fsUnderline in aQRRTFItem.FontStyle then row := row + '\ul';
          if fsStrikeOut in aQRRTFItem.FontStyle then row := row + '\strike';


          // Get the color tag for the font
          row := row + RTFColorTag(aQRRTFItem.FontColor);

          // finally output the text
          row := row + ' ' + aQRRTFItem.Text;
        end;
//        s := s + row + ' {\par}}';
        // fix:  Need code to determine location of next line on
        // page so we can space the lines closer to how the report
        // looks
        s := s + row + '{\fs1\par}}';
      end;
      if row <> '' then
      begin
        // write the tabstops for this line
        Writeln(aFile, TabStops);
        // write the fields
        Writeln(aFile, s);
        // Set the flag so that we know that new page will generate a page break
        PendingPageBreak := True;
      end;
    end;
  end;
end;

procedure TQRRTFExportFilter.Finish;
begin
  if concatenating then exit;
  // write the closing part of the RTF formatting
  Writeln(aFile, '\par }');
  // All done, close the file
  CloseFile(aFile);
  // free the allocated memory
  DestroyRTFLines;
end;

procedure TQRRTFExportFilter.DestroyRTFLines;
var
 aQRRtfLineItem : TQRRtfLineItem;
begin
  if assigned(RTFLines) then // check to see if it's already created
  begin
    while RTFLines.Count > 0 do
    begin
      if RTFLines[RTFLines.Count-1] <> nil then
      begin
        aQRRtfLineItem := TQRRtfLineItem(RTFLines[RTFLines.Count-1]); // for faster access
        RTFLines[RTFLines.Count-1] := nil; // remove from list
        aQRRtfLineItem.ClearLineItems; // clear the embedded items.
        aQRRtfLineItem.Free; // and clear the TQrRtfLineItem;
      end;
      RTFLines.Delete(RTFLines.Count-1); // and finally remove it
    end;
    RTFLines.Free;
    RTFLines := nil;
  end;
end;

procedure TQRRTFExportFilter.CreateRTFLines;
var
  I : integer;
begin
  DestroyRTFLines; // if already there remove it.
  RTFLines := TList.Create; // create a new one
  for I := 0 to LineCount - 1 do // and fill it up
    RTFLines.Add(TQRRTFLineItem.Create);
end;

procedure TQRRTFExportFilter.NewPage;
begin
  // Initialize the buffer
  CreateRTFLines;
end;

procedure TQRRTFExportFilter.TextOut(X, Y : Extended; Font : TFont; BGColor : TColor; Alignment : TAlignment; Text : string);
var
  aQRRTFItem: TQRRTFItem;
  function RTFSafeText(const str: string): string;
  var ll: integer;
  begin
    result := '';
    for ll := 1 to length(str) do begin
      if (str[ll] = '\') or (str[ll] = '}') or (str[ll] = '{') then
        result := result + '\';
      result := result + str[ll];
    end;
  end;
begin
  // Create a new field item and set it's properties
  aQRRTFItem := TQRRTFItem.Create;
  aQRRTFItem.x := x;
  aQRRTFItem.y := y;
  aQRRTFItem.Text := RTFSafeText(Text);
  aQRRTFItem.Alignment := Alignment;
  aQRRTFItem.RTFFont := RTFFontList.IndexOf(Font.Name);
  aQRRTFItem.FontColor := Font.Color;
  aQRRTFItem.FontStyle := Font.Style;

  // RTF font size is measured in 1/2 points, so we need to
  // double the size value
  aQRRTFItem.FontSize := Font.Size shl 1;

  // Get an approximate guess to where the line is in the list
  Y := Y / YFactor;

  // Add this field to list of fields for the current line
  // Added check to ignore controls that are below the printable
  // page area
  if round(y) < RTFLines.Count then
    TQRRTFLineItem(RTFLines[round(y)]).Add(aQRRTFItem)
  else
     aQRRTFItem.Free;
end;

// control TQRRTFFilter
constructor TQRRTFFilter.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  QRExportFilterLibrary.AddFilter(TQRRTFExportFilter);
end;

destructor TQRRTFFilter.Destroy;
begin
  QRExportFilterLibrary.RemoveFilter(TQRRTFExportFilter);
  inherited Destroy;
end;

function TQRRTFFilter.GetEncoding : TTextEncoding;
begin
     result := GTextEncoding;
end;

procedure TQRRTFFilter.SetEncoding( value : TTextEncoding);
begin
     GTextEncoding := value;
end;

// control WMFfilter
function TQRWMFExportFilter.GetEncoding : TTextEncoding;
begin
     result := GTextEncoding;
end;

procedure TQRWMFExportFilter.SetEncoding( value : TTextEncoding);
begin
     GTextEncoding := value;
end;
function TQRWMFExportFilter.GetDescription : string;
begin
  result := SqrWMFExportFilter;
end;

function TQRWMFExportFilter.GetFilterName : string;
begin
  result := SqrWMFFile;
end;

function TQRWMFExportFilter.GetExtension : string;
begin
  result := 'WMF'; // Do not locallize
end;

procedure TQRWMFExportFilter.Start(PaperWidth, PaperHeight : integer; Font : TFont);
var
  i: integer;
begin
  // If the user specifies a file extension, we get rid of it.
  aBase := filename;
  i := length(aBase);

  while i > 0 do
  begin
    if aBase[i] = '.' then
    begin
      aBase := copy(aBase, 1, i-1);
      break;
    end;
    dec(i);
  end;
end;

procedure TQRWMFExportFilter.EndPage;
begin
  // Stub code for filter
end;

procedure TQRWMFExportFilter.Finish;
var
  i: integer;
  aMetaFile: TMetaFile;
begin
  if Owner is TCustomQuickRep then
  begin
    with TCustomQuickRep(Owner) do
    begin
      if OriginalQRPrinter <> nil then
      begin
        with OriginalQRPrinter do
        begin
          // Get each page and save it as a metafile
          // At this point in time, the PageList.PageCount
          // has not been set.  We'll force it here
          for i := 1 to PageNumber do
          begin
            // Retrieve the current page as a metafile
            aMetaFile := GetPage(i);

            if Assigned(aMetaFile) then
            begin
              aMetaFile.Enhanced := WMF_Enhanced;
              if aMetaFile.Enhanced then
                aMetaFile.SaveToFile(aBase + format('%3.3d', [i]) + '.emf')
              else
                aMetaFile.SaveToFile(aBase + format('%3.3d', [i]) + '.wmf');

              aMetaFile.Free;
            end;
          end;
        end;
      end;
    end
  end;
end;

procedure TQRWMFExportFilter.NewPage;
begin
  // Stub code for filter
end;

procedure TQRWMFExportFilter.TextOut(X, Y : Extended; Font : TFont; BGColor : TColor; Alignment : TAlignment; Text : string);
begin
  // Stub code for filter
end;

constructor TQRWMFFilter.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  WMF_Enhanced := False;
  QRExportFilterLibrary.AddFilter(TQRWMFExportFilter);
end;

destructor TQRWMFFilter.Destroy;
begin
  QRExportFilterLibrary.RemoveFilter(TQRWMFExportFilter);
  inherited Destroy;
end;

function TQRWMFFilter.GetEnhanced : boolean;
begin
  Result := WMF_Enhanced;
end;

procedure TQRWMFFilter.SetEnhanced(Value : boolean);
begin
  WMF_Enhanced := Value;
end;


{$endif}

{ TQRAsciiExportFilter }
function dup(aChar : Char; Count : integer) : string;
var
  I : integer;
begin
  result := '';
  for I := 1 to Count do result := result + aChar;
end;

function TQRAsciiExportFilter.GetEncoding : TTextEncoding;
begin
     result := GTextEncoding;
end;

procedure TQRAsciiExportFilter.SetEncoding( value : TTextEncoding);
begin
     GTextEncoding := value;
end;

function TQRAsciiExportFilter.GetDescription : string;
begin
  result := SqrAsciiFilterDescription;
end;

function TQRAsciiExportFilter.GetFilterName : string;
begin
  result := SqrAsciiFilterName;
end;

function TQRAsciiExportFilter.GetExtension : string;
begin
  result := SQrAsciiFilterExtension;
end;

procedure TQRAsciiExportFilter.Start(PaperWidth, PaperHeight : integer; Font : TFont);
begin
  if LineCount = 0 then // fix crash with composite report.
  begin
    finaldoc := TStringlist.Create;
  end;
  YFactor := Font.Size * (254 / 72);
  XFactor := Font.Size * (254 / 72);
  LineCount:=round(PaperHeight / YFactor);
end;

procedure TQRAsciiExportFilter.EndPage;
var
  I : integer;
begin
  for I := 0 to LineCount - 1 do
    if length(Lines[I]) > 0 then finaldoc.Add( Lines[I]);
end;

procedure TQRAsciiExportFilter.Finish;
var
  enc : TQRTextEncoding;
begin
   enc := TQRTextEncoding.Create;
   case TextEncoding of
     ASCIIEncoding: finaldoc.SaveToFile(Filename, enc.ASCII);
     BigEndianUnicodeEncoding: ;
     DefaultEncoding: finaldoc.SaveToFile(Filename, enc.Default);
     UnicodeEncoding: finaldoc.SaveToFile(Filename, enc.Unicode);
     UTF7Encoding: finaldoc.SaveToFile(Filename, enc.UTF7);
     UTF8Encoding: finaldoc.SaveToFile(Filename, enc.UTF8);
   end;
   finaldoc.free;
   enc.Free;
end;

procedure TQRAsciiExportFilter.NewPage;
var
  I : integer;
begin
  for I := 0 to 200 do
    Lines[I] := '';
end;

procedure TQRAsciiExportFilter.TextOut(X, Y : Extended; Font : TFont; BGColor : TColor;
                                                Alignment : TAlignment; Text : string);
var
  aLine : string;
begin
  X := X / XFactor * 1.7;
  Y := Y / YFactor;
  if Alignment=taRightJustify then
    X := X - Length(Text);
  aLine := Lines[round(Y)];
  if length(aLine) < X then
    aLine:=aLine + dup(' ', round(X) - length(aLine));
  Delete(aLine, round(X), Length(Text));
  Insert(Text, aLine, round(X));
  Lines[trunc(Y+0.5)] := aLine;
end;

constructor TQRTextFilter.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  QRExportFilterLibrary.AddFilter(TQRAsciiExportFilter);
end;

destructor TQRTextFilter.Destroy;
begin
  QRExportFilterLibrary.RemoveFilter(TQRAsciiExportFilter);
  inherited Destroy;
end;

function TQRTextFilter.GetEncoding : TTextEncoding;
begin
     result := GTextEncoding;
end;

procedure TQRTextFilter.SetEncoding( value : TTextEncoding);
begin
     GTextEncoding := value;
end;

{$ifndef QRSTANDARD}
initialization
  RTFFontList := TStringList.Create;
  RTF_VertAdj := 50;
  GTextEncoding := DefaultEncoding;
  {$ifdef DELPHI6}
  GroupDescendentsWith(TQRCSVFilter, TControl);
  GroupDescendentsWith(TQRTextFilter, TControl);
  {$endif}
finalization
  RTFFontList.Free;
{$endif}

end.


