unit QRXMLSFilt;
////////////////////////////////////////////////////////////////////////////                              
//  Unit : QRXMLSFilt.pas
//
//  TQRXAbstractExportFilter -> TQRXDocumentFilter
//
//  The new XMLS Export document filter classes -
//
//  (c) 2002 QBS Software
//
//  03/04/2003 DLM : added concatenating 
//  26/06/2003 DLM : added graphics position adjust
//  26/01/2004 DLM : Update for QR4
//  25/03/2004 Image handling added
//  10/11/2004 Drill down vars added
//  changed format of QRX to shorter attribute names. 
////////////////////////////////////////////////////////////////////////////
{$include QRDefs.inc}
interface
uses windows, classes, controls, stdctrls, sysutils, graphics, buttons,
     forms, extctrls, dialogs, printers, db, ComCtrls, 
     QRPrntr, Quickrpt, QR5Const, qrctrls, grids;

const
     CRLF = chr($0D) + chr($0A);
     // ascii
     ORD0 = ord('0');
     ORDA = ord('A');
type

  TQRXAbstractExportFilter = class(TQRExportFilter)
  private
    FStream : TStream;
    FCharWidth,
    FCharHeight,
    FPaperWidth,
    FPaperHeight : extended;
    FLineCount,
    FColCount : integer;
    FPageProcessed : boolean;
    FFont : TFont;
    FActiveFont : TFont;
     function GetEncoding : TTextEncoding;
     procedure SetEncoding( value : TTextEncoding);
  protected
    function GetText(X, Y : extended; var Font : TFont) : string;
    function GetFilterName : string; override;
    function GetDescription : string; override;
    function GetExtension : string; override;
    procedure WriteToStream(const AText : string);
    procedure WriteLnToStream(const AText : string);
    procedure CreateStream(Filename : string); virtual;
    procedure CloseStream; virtual;
    procedure ProcessPage; virtual;
    procedure StorePage; virtual;
    property Stream : TStream read FStream write FStream;
    property PageProcessed : boolean read FPageProcessed write FPageProcessed;
    property CharWidth : extended read FCharWidth write FCharWidth;
    property CharHeight : extended read FCharHeight write FCharHeight;
    property PaperWidth : extended read FPaperWidth write FPaperWidth;
    property PaperHeight : extended read FPaperHeight write FPaperHeight;
    property LineCount : integer read FLineCount write FLineCount;
    property ColCount : integer read FColCount write FColCount;
  public
    constructor Create( filename : string );override;
    procedure Start(PaperWidth, PaperHeight : integer; Font : TFont); override;
    procedure Finish; override;
    procedure EndPage; override;
    procedure NewPage; override;
    procedure AcceptBand( aBand : TControl; Xoff, Yoff, Expanded : extended); override;
    procedure AcceptGraphic( Xoff, Yoff : extended; GControl : TControl); override;
    procedure TextOut(X, Y : extended; Font : TFont; BGColor : TColor;
               Alignment : TAlignment; Text : string); override;
    property TextEncoding : TTextencoding read GetEncoding write setEncoding;
  end;

  TQRXImageURLNeeded = procedure(Sender: TObject; ImageCtrl: TControl; var ImageURL: String; var IncludeByRef: Boolean) of object;

  TQRXDocumentFilter = class(TQRXAbstractExportFilter)
  private
    FFreeStream : boolean;
    // doc filter properties
    FLastRecordNum : longint;
    FNextPicNum : longint;
    FPagenumber : longint;
    FDocType : string;
    FCreator : string;
    FTitle : string;
    FAuthor : string;
    FDocDate : string;
    FCopyright : string;
    FOrientation : string;
    FXLStyleURL : string;
    FConcatenating : boolean;
    FCompressImages : boolean;
    FXLEncoding: string;
    FCodepage : integer;
    FDoImages: boolean;
    FOnImageURLNeeded: TQRXImageURLNeeded;
  protected
    function GetFilterName : string; override;    
    function GetDescription : string; override;
    function GetExtension : string; override;
    function GetStreaming : boolean; override;
    procedure CreateStream(Filename : string); override;
    procedure CloseStream; override;
 public
    // graphic finesse properties
    VertLineAdjust, HorizLineAdjust, LeftMarginAdjust : double; // in mm
    constructor Create( filename : string );override;
    procedure NewDocument( doclist : TStringlist; PaperWidth, PaperHeight : double;
              Papername, orient : string);
    procedure TextOut(X, Y : extended; Font : TFont; BGColor : TColor;
               Alignment : TAlignment; Text : string); override;
    procedure LoadDTD( var dlist : TStringlist );
    procedure ProcessPage; override;
    procedure Start(PaperWidth, PaperHeight : integer; Font : TFont); override;
    procedure EndConcat;
    procedure Finish; override;
    procedure NewPage; override;
    procedure EndPage; override;
    procedure AcceptBand( aBand : TControl; Xoff, Yoff, Expanded : extended); override;
    procedure AcceptGraphic( Xoff, Yoff : extended; GControl : TControl); override;
    procedure SetDocumentProperties( author, title, copyright : string );
    property Stream;
    property FreeStream : boolean read FFreeStream write FFreeStream;
    property Orientation : string read FOrientation write FOrientation;
    property Creator : string read FCreator write FCreator;
    property Author : string read FAuthor write FAuthor;
    property Title : string read FTitle write FTitle;
    property DocDate : string read FDocDate write FDocDate;
    property Copyright : string read FCopyright write FCopyright;
    property DocType : string read FDocType write FDocType;
    property XLEncoding: string read FXLEncoding write FXLEncoding;
    property XLStyleURL : string read FXLStyleURL write FXLStyleURL;
    property CompressImages : boolean read FCompressImages write FCompressImages;
    property DoImages: boolean read FDoImages write FDoImages;
    property Concatenating : boolean read FConcatenating write FConcatenating;
    property OnImageURLNeeded: TQRXImageURLNeeded read FOnImageURLNeeded write FOnImageURLNeeded;
    property TextEncoding;
  end;

  TQRXMLSFilter = class(TComponent)
  protected
     function GetEncoding : TTextEncoding;
     procedure SetEncoding( value : TTextEncoding);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property TextEncoding : TTextencoding read GetEncoding write setEncoding;
  end;

  function basename( fname : string ) : string;
  procedure RunLength(Source, Target: TStream);

implementation
uses lzw, DBTables, grimgctrl;

var
   XMLEncoding : TTextencoding;

constructor TQRXMLSFilter.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  QRExportFilterLibrary.AddFilter(TQRXDocumentFilter);
end;

destructor TQRXMLSFilter.Destroy;
begin
  QRExportFilterLibrary.RemoveFilter(TQRXDocumentFilter);
  inherited Destroy;
end;

function TQRXMLSFilter.GetEncoding : TTextEncoding;
begin
     result := XMLEncoding;
end;

procedure TQRXMLSFilter.SetEncoding( value : TTextEncoding);
begin
     XMLEncoding := value;
end;


{TQRXAbstractExportFilter}
constructor TQRXAbstractExportFilter.Create( filename : string);
begin
     inherited Create(filename);
end;

procedure TQRXAbstractExportFilter.AcceptBand( aBand : TControl; Xoff, Yoff, Expanded : extended);
begin
end;

function TQRXAbstractExportFilter.GetEncoding : TTextEncoding;
begin
     result := XMLEncoding;
end;

procedure TQRXAbstractExportFilter.SetEncoding( value : TTextEncoding);
begin
     XMLEncoding := value;
end;

procedure TQRXAbstractExportFilter.AcceptGraphic( Xoff, Yoff : extended; GControl : TControl);
begin
end;

function TQRXAbstractExportFilter.GetFilterName : string;
begin
  result := 'QRAbstract'; // Do not translate
end;

function TQRXAbstractExportFilter.GetDescription : string;
begin
  Result := '';
end;

function TQRXAbstractExportFilter.GetExtension : string;
begin
  Result := '';
end;

procedure TQRXAbstractExportFilter.Start(PaperWidth, PaperHeight : integer; Font : TFont);
begin
  CreateStream(Filename);
  finaldoc := TStringlist.Create;
  FFont := TFont.Create;
  FActiveFont := TFont.Create;
  FFont.Assign(Font);
  CharHeight := Font.Size * (254 / 72);
  CharWidth := Font.Size * (254 / 72);
  FPaperHeight := PaperHeight;
  FPaperWidth := PaperWidth;
  LineCount := round(PaperHeight / CharHeight);
  FPageProcessed := false;
  inherited Start(PaperWidth, PaperHeight, Font);
end;


procedure TQRXAbstractExportFilter.CreateStream(Filename : string);
begin
  FStream := TFileStream.Create(Filename, fmCreate);
end;

procedure TQRXAbstractExportFilter.CloseStream;
begin
  FStream.Free;
end;

procedure TQRXAbstractExportFilter.WriteToStream(const AText : string);
var
   stext : string;
begin
  if length(AText)>0 then
  begin
    // trim off the crlf
    stext := atext;
    finaldoc.Add(sText);
  end;
    //Stream.Write(AText[1], length(AText)*2);
end;

procedure TQRXAbstractExportFilter.WriteLnToStream(const AText : string);
begin
  WriteToStream(AText + #13 + #10);
end;


procedure TQRXAbstractExportFilter.Finish;
begin
  FFont.Free;
  FActiveFont.Free;
  CloseStream;
  inherited Finish;
end;

procedure TQRXAbstractExportFilter.NewPage;
begin
  FPageProcessed := False;
  FActiveFont.Free;
  FActiveFont := TFont.Create;
  inherited NewPage;
end;

procedure TQRXAbstractExportFilter.EndPage;
begin
  //EndPage;??
  ProcessPage;
  inherited EndPage;
end;

procedure TQRXAbstractExportFilter.ProcessPage;
begin
  FPageProcessed := True;
end;

procedure TQRXAbstractExportFilter.StorePage;
begin
end;

procedure TQRXAbstractExportFilter.TextOut(X, Y : extended; Font : TFont;
                      BGColor : TColor; Alignment : TAlignment; Text : string);
begin
end;

function TQRXAbstractExportFilter.GetText(X, Y : extended; var Font : TFont) : string;
begin
end;

{TQRXDocumentFilter}
function TQRXDocumentFilter.GetFilterName : string;
begin
  Result := SqrQRXDocument;
end;

function TQRXDocumentFilter.GetDescription : string;
begin
  Result := SqrQRXDocumentForWeb;
end;

function TQRXDocumentFilter.GetExtension : string;
begin
  Result := 'QRX'; // Do not translate
end;

function TQRXDocumentFilter.GetStreaming : boolean;
begin
  Result := false;// stream multipage report mode
end;

procedure TQRXDocumentFilter.CreateStream(Filename : string);
begin
  if (Filename = '') or true then
  begin
    FStream := TMemoryStream.Create;
    FreeStream := false;
  end else
  begin
    FreeStream := true;
    inherited CreateStream(Filename);
  end;
end;

procedure TQRXDocumentFilter.CloseStream;
begin
  // the stream is not freed if it's a memory stream
  if FreeStream then
    inherited CloseStream;
end;

constructor TQRXDocumentFilter.Create( filename : string );
begin
   inherited Create( filename);
   FLastRecordNum := 0;
   FNextpicNum := 0;
   FPagenumber := 1;
   FCreator := 'QRXDocumentFilter';
   FDocDate := datetostr( date );
   FOrientation := 'Portrait';
   FCompressImages := true;
   FXLEncoding := 'windows-1252';
   FDoImages := true;
   HorizLineAdjust := 0.0;
   VertLineAdjust := 0.0;
end;

// QBSS : override method to skip converttoxxx
procedure TQRXDocumentFilter.ProcessPage;
begin
  FPageProcessed := True;
  StorePage;
end;

procedure TQRXDocumentFilter.SetDocumentProperties( author, title, copyright : string );
begin
      FAuthor := author;
      FTitle := title;
      FCopyright := copyright;

end;
procedure TQRXDocumentFilter.LoadDTD( var dlist : TStringlist );
var
    ssurl : string;
    aFont : TFont;
begin
     aFont := TFont.Create;
     case aFont.Charset of
               BALTIC_CHARSET: FCodePage:=1257;
          CHINESEBIG5_CHARSET: FCodePage:=950;
           EASTEUROPE_CHARSET: FCodePage:=1250;
               GB2312_CHARSET: FCodePage:=936;
                GREEK_CHARSET: FCodePage:=1253;
                  OEM_CHARSET: FCodePage:=CP_OEMCP;
              RUSSIAN_CHARSET: FCodePage:=1251;
             SHIFTJIS_CHARSET: FCodePage:=932;
              TURKISH_CHARSET: FCodePage:=1254;
               HEBREW_CHARSET: FCodePage:=1255;
               ARABIC_CHARSET: FCodePage:=1256;
                 THAI_CHARSET: FCodePage:=874;
           VIETNAMESE_CHARSET: FCodePage:=1258;
     else
           FCodePage:=1252;
     end;
     //dlist.add('<?xml version="1.0" encoding="'+inttostr(FCodepage)+'"?>');
     dlist.add('<?xml version="1.0"?>');
     if trim( FXLStyleURL) = '' then
       ssurl := 'QXDStylesheet.xsl'
     else
       ssurl := FXLStyleURL;

     dlist.add('<?xml-stylesheet type="text/xsl" href="'+ssurl+'"?>');
     dlist.add('<!DOCTYPE QXDocument [');
     dlist.add('<!ELEMENT QXDocument (Header, Page*)>');
     dlist.add('<!ELEMENT Header (Title*, DocType*, Creator*, Author*, Date*, Copyright*, Orientation*)>');
     dlist.add('<!ELEMENT DocType (#PCDATA)>');
     dlist.add('<!ELEMENT Title (#PCDATA)>');
     dlist.add('<!ELEMENT Creator (#PCDATA)>');
     dlist.add('<!ELEMENT Author (#PCDATA)>');
     dlist.add('<!ELEMENT Date (#PCDATA)>');
     dlist.add('<!ELEMENT Copyright (#PCDATA)>');
     dlist.add('<!ELEMENT Orientation (#PCDATA)>');
     dlist.add('<!ELEMENT Page (Item*)>');
     dlist.add('<!ELEMENT Item (#PCDATA)>');
     dlist.add('<!ELEMENT Contents (#PCDATA)>');
     dlist.add('<!ATTLIST Header Units CDATA "mm">');
     dlist.add('<!ATTLIST Header Pagewidth CDATA "210">');
     dlist.add('<!ATTLIST Header Pageheight CDATA "297">');
     dlist.add('<!ATTLIST Header PaperName CDATA "A4">');
     dlist.add('<!ATTLIST Header Layers CDATA "3">');
     dlist.add('<!ATTLIST Item Type CDATA "Text">');
     dlist.add('<!ATTLIST Item X CDATA "0">');
     dlist.add('<!ATTLIST Item Y CDATA "0">');
     dlist.add('<!ATTLIST Item Font CDATA "Arial">');
     dlist.add('<!ATTLIST Item Height CDATA "12">');
     dlist.add('<!ATTLIST Item Color CDATA "Black">');
     dlist.add('<!ATTLIST Item BC CDATA "White">');
     dlist.add('<!ATTLIST Item FW CDATA "Normal">');
     dlist.add('<!ATTLIST Item Dec CDATA "None">');
     dlist.add('<!ATTLIST Item Width CDATA "1">');
     dlist.add('<!ATTLIST Item Height CDATA "1">');
     dlist.add('<!ATTLIST Item SP CDATA "0">');
     dlist.add('<!ATTLIST Item CID CDATA "000000">');
     dlist.add('<!ATTLIST Item DBR CDATA "0">');
     dlist.add('<!-- 0=rect, 1=ellipse, 2=hline,3=vline,4=roundrect,5=rightdiag,6=leftdiag-->');
     dlist.add('<!ATTLIST Item LW CDATA "1">');
     dlist.add('<!ATTLIST Item FT CDATA "0">');
     dlist.add('<!ATTLIST Item LY CDATA "0">');
     dlist.add('<!ATTLIST Item Op CDATA "1">');
     dlist.add('<!ATTLIST Item ImageFile CDATA "">');
     dlist.add('<!ATTLIST Item Cmp CDATA "None">');
     dlist.add('<!ATTLIST Item XS CDATA "1.0">');
     dlist.add('<!ATTLIST Item YS CDATA "1.0">');
     dlist.add('<!ATTLIST Item Extra CDATA "">');
     dlist.add('<!ATTLIST Page Number CDATA "1">');
     dlist.add(']>');
end;

procedure TQRXDocumentFilter.AcceptBand( aBand : TControl; Xoff, Yoff, Expanded : extended);
var
    ctext : string;
begin
      ctext := format('<Item Type="Band" X="%-4.2f" Y="%-4.2f" Width="%-d" Height="%-d" LY="1" XS="%6.3f" YS="%6.3f" Cmp="none" CID="%-s" DBR="%-d"></Item>',
                      [ Xoff, Yoff, aBand.width, aBand.height+round(Expanded), 1.0, 1.0, aBand.name, ExportingRecordnumber ]);

    writetostream( ctext+ CRLF);
end;

// strip off file extension
function basename( fname : string ) : string;
var
   p : integer;
   ps,fs : string;
begin
    basename := fname;
    ps:=sysutils.ExtractFilePath(fname);
    fs:=sysutils.ExtractFileName(fname); 
    p := pos( '.', fs );
    if p = 0 then exit;
    basename := ps + copy( fs, 1, p - 1 );
end;


function EntityReplace( var ctext : string ) : string;
begin
     ctext :=  stringreplace( ctext, '&', '&amp;', [rfReplaceAll] ); // must be first
     ctext :=  stringreplace( ctext, '<', '&lt;', [rfReplaceAll] );
     ctext :=  stringreplace( ctext, '>', '&gt;', [rfReplaceAll] );
     ctext :=  stringreplace( ctext, '''', '&apos;', [rfReplaceAll] );
     ctext :=  stringreplace( ctext, '"', '&quot;', [rfReplaceAll] );
     result := ctext;
end;

function ColTrans( ct : TColor ) : string;
var
   tempstr : string;
begin
    if ct < 0 then
    begin
        ct := ct and $FFFFFF;
    end;
    tempstr := format ( '%6.6x', [longint(ct)]);
    result := '#' + copy( tempstr, 5, 2 ) +copy( tempstr, 3, 2 )  +copy( tempstr, 1, 2 ) ;
end;

// places a blank document in the stringlist
procedure TQRXDocumentFilter.NewDocument( doclist : TStringlist; PaperWidth, PaperHeight : double;
              Papername, orient : string);
begin
//Title*, DocType*, Creator*, Author*, Date*, Copyright*, Orientation*
    LoadDTD( doclist );
    doclist.Add( '<QXDocument>' );
    doclist.Add( '<Header Pagewidth="'+format( '%6.2f', [PaperWidth])+
                      '" Pageheight="'+format( '%6.2f', [Paperheight])
                      +'" PaperName="A4" Units="mm">' );
    doclist.Add( '   <Title>'+EntityReplace(FTitle)+'</Title>' );
    doclist.Add( '   <DocType>'+EntityReplace(FDocType)+'</DocType>' );
    doclist.Add( '   <Creator>'+EntityReplace(FCreator)+'</Creator>' );
    doclist.Add( '   <Author>'+EntityReplace(FAuthor)+'</Author>'  );
    doclist.Add( '   <Date>'+EntityReplace(FDocDate)+'</Date>' );
    doclist.Add( '   <Copyright>'+EntityReplace(FCopyright)+'</Copyright>'  );
    doclist.Add( '   <Orientation>'+EntityReplace(FOrientation)+'</Orientation>' );
    doclist.Add( '</Header>'  );
    doclist.Add( '</QXDocument>' );
end;

// Overridden Start
procedure TQRXDocumentFilter.Start(PaperWidth, PaperHeight : integer; Font : TFont);
var
    dlist : TStringlist;
    k : integer;
begin
    inherited;  // creates a stream
    // output the dtd now because the data will stream out
    dlist := TStringlist.create;
    LoadDTD( dlist );
    for k := 0 to dlist.count-1 do
        writetostream( dlist[k]);
    writetostream( '<QXDocument>' );
    writetostream( '<Header Pagewidth="'+format( '%6.2f', [PaperWidth*0.1])+
                      '" Pageheight="'+format( '%6.2f', [Paperheight*0.1])+'" PaperName="A4" Units="mm">' );
    writetostream( '   <Title>'+EntityReplace(FTitle)+'</Title>'  );
    writetostream( '   <DocType>'+EntityReplace(FDocType)+'</DocType>' );
    writetostream( '   <Creator>'+EntityReplace(FCreator)+'</Creator>'  );
    writetostream( '   <Author>'+EntityReplace(FAuthor)+'</Author>'  );
    writetostream( '   <Date>'+EntityReplace(FDocDate)+'</Date>' );
    writetostream( '   <Copyright>'+EntityReplace(FCopyright)+'</Copyright>'  );
    writetostream( '   <Orientation>'+EntityReplace(FOrientation)+'</Orientation>' );
    writetostream( '</Header>' + CRLF );
end;

// overridden Finish
procedure TQRXDocumentFilter.Finish;
var
  enc : TQRTextEncoding;
  penc : TEncoding;
begin
    penc := nil;
    if fconcatenating then exit;
    enc := TQRTextEncoding.Create;
    writetostream( '</Page>');
    writetostream( '</QXDocument>' );
    case TextEncoding of
      ASCIIEncoding: penc := enc.ASCII;
      BigEndianUnicodeEncoding:  penc := enc.BigEndianUnicode;
      DefaultEncoding: penc := enc.Default;
      UnicodeEncoding: penc := enc.Unicode;
      UTF7Encoding: penc := enc.UTF7;
      UTF8Encoding: penc := enc.UTF8;
    end;

    if filename <> '' then
       finaldoc.SaveToFile(filename, penc)
    else
       finaldoc.SaveToStream(FStream, penc);
    enc.Free;
    finaldoc.Free;
    inherited;
end;

procedure TQRXDocumentFilter.EndConcat;
begin
     fconcatenating := false;
     Finish;
end;

procedure TQRXDocumentFilter.TextOut(X, Y : extended; Font : TFont; BGColor : TColor;
               Alignment : TAlignment; Text : string);
var
  I  : integer;
  parentrep : TQuickrep;
  ctext,fbold, fitalic, funderline, fstrike : string;
  textlen, Xmm, Ymm : double;
  xp : integer;
begin
    //
    parentrep := tquickrep( self.owner );
    // catch the current record
    fBold := 'normal';
    fitalic := 'none';
    funderline := 'none';
    Xmm := LeftMarginAdjust + (X/10.0);
    Ymm := Y/10.0;
    // deal with alignment
    if (Alignment = taRightJustify) and true then
    begin
         // mm/10 to pixels
         xp := parentrep.QRPrinter.XPos( X );
         parentrep.QRPrinter.Canvas.font := font;
         textlen := parentrep.QRPrinter.Canvas.TextWidth( trim(text) );
         xp := round(xp-textlen);
         // pixels to mm
         Xmm := 0.1 * xp / parentrep.QRPrinter.xfactor;
    end
    else if Alignment = taCenter then
    begin
         xp := parentrep.QRPrinter.XPos( X );
         parentrep.QRPrinter.Canvas.font := font;
         textlen := parentrep.QRPrinter.Canvas.TextWidth( trim(text) );
         xp := round(xp-(textlen/2.0));
         // pixels to mm
         Xmm := 0.1 * xp / parentrep.QRPrinter.xfactor;
    end;

    if fsBold in Font.Style then fbold := 'Bold';
    if fsItalic in Font.Style then fitalic := 'Italic';
    if fsUnderline in Font.Style then funderline := 'Underline';
    if fsStrikeout in Font.Style then fstrike := 'Strikeout';
    i := font.size;
    ctext := format('<Item Type="Text" LY="0" Font="%-s" X="%-4.2f" Y="%-4.2f" Height="%-d" Color="%-s" FW="%s" Dec="%-s" CID="%-s" DBR="%-d">',
                    [ font.name, Xmm, Ymm, i, coltrans(font.color),fbold, fitalic, ExportingControlname, ExportingRecordnumber ]);
    writetostream( ctext);
    ctext := text;
    writetostream( EntityReplace(ctext) );
    writetostream( '</Item>'  );
    if parentrep.DataSet is TTable then
       FLastRecordNum := parentrep.DataSet.RecNo;
end;

// turns a byte into 2 hex digits
procedure Hexit( var c1 : char; var c2 : char; b : byte );
var
       b1, b2 : byte;
begin
      b1 := b shr 4;
      b2 := b and $0F;
      if b1 < 10 then
          c1 := chr( b1 + ORD0 )
      else
          c1 := chr( (b1-10) + ORDA );
      if b2 < 10 then
          c2 := chr( b2 + ORD0 )
      else
          c2 := chr( (b2-10) + ORDA );
end;

procedure TQRXDocumentFilter.AcceptGraphic( Xoff, Yoff : extended; GControl : TControl);
const
     REC_SIZE = 2048;
var
    conwidth, conheight : integer;
    ctext : string;
    tempmap : TBitmap;
    SSCont : TQRShape;
    qrdbcont : TQRDBImage;
    drawpict : TPicture;
    istream, rlestream : TMemoryStream;
    C1, C2 : char;
    cc : array[0..REC_SIZE] of byte;
    bytesin, i, ishape : integer;
    lineout, fill, layer : string;
    Xmm, Ymm, xscale, yscale, rectheight, rectwidth : double;
    xrescale, yrescale, widthDivHeight: double;
    imgbyref: boolean;
    imgurl: string;
    dest : TRect;
    coffset, imgwidth, imgheight : integer;
begin
  tempmap := TBitmap.create;
  istream := TMemoryStream.Create;
  rlestream := TMemoryStream.create;
  drawpict := TPicture.Create;
  Xmm := LeftMarginAdjust + (25.4* Xoff / Screen.PixelsPerInch);
  Ymm := 25.4* Yoff / Screen.PixelsPerInch;
  try
     if( GControl is TQRShape ) then
     begin
         SSCont := (GControl as TQRShape);
         // apply adjust to all shapes. Frames are exported as rects
         Ymm := Ymm + VertLineAdjust;
         Xmm := Xmm + HorizLineAdjust;
         fill := 'Out';
         layer := '1';
         if (sscont.Brush.Style <> bsClear) and (( sscont.shape=qrsRectangle) or (sscont.shape=qrsCircle)) then
         begin
             layer := '2';
             fill := 'Fill';
         end;
         ishape := integer(sscont.Shape);
         // swap h and v lines to match QXD spec
         if ishape=2 then
           ishape := 3
         else if ishape = 3 then
           ishape := 2;
           // make sure the thing doesn't disappear.
         rectwidth := 25.4*sscont.width/ Screen.PixelsPerInch;
         if rectwidth < 0.5 then rectwidth := 0.5;
         rectheight := 25.4*sscont.height/ Screen.PixelsPerInch;
         if rectheight < 0.5 then rectheight := 0.5;
         ctext := format('<Item Type="Graphic" LY="'+layer+'" X="%-4.2f" Y="%-4.2f" LW="%-4.2f" '+
                  'SP="%-d" Width="%-4.2f" Height="%-4.2f" Color="%s" BC="%s" FT="%s" CID="%-s" DBR="%-d">',
                    [  Xmm, Ymm, 25.4*sscont.pen.width / Screen.PixelsPerInch, ishape, rectwidth, rectheight,
                      coltrans(sscont.pen.color),coltrans(sscont.Brush.color), fill, GControl.name, exportingRecordNumber ]);
         writetostream( ctext);
         writetostream( '</Item>' );
         exit;
    end;
    // It's a picture
    tempmap.width := GControl.Width;
    tempmap.height := GControl.height;
    xrescale := 1.0;
    yrescale := 1.0;
    conwidth := GControl.Width;
    conheight := Gcontrol.height;
    if (GControl is TQRImage) then
    begin
         if TQRImage(GControl).stretch then
             tempmap.canvas.stretchdraw( Rect( 0, 0, tempmap.width, tempmap.height),
                                             TQRImage(GControl).Picture.graphic)
         else
         begin
             tempmap.canvas.draw(  0, 0, TQRImage(GControl).Picture.graphic)
         end;
         xrescale := ((25.4*TQRImage(GControl).width/ Screen.PixelsPerInch) / tempmap.width);
         yrescale := ((25.4*TQRImage(GControl).height/ Screen.PixelsPerInch) / tempmap.height);
    end
    else if (GControl is TQRGrImage) then
    begin
         dest.left := trunc(Xoff);
         dest.top := trunc(YOff);
         dest.right := trunc( XOff + conWidth);
         dest.bottom := trunc( YOff + conHeight);
         imgwidth := TQRGrImage(GControl).Picture.graphic.Width;
         imgheight := TQRGrImage(GControl).Picture.graphic.height;
         conwidth := TQRGrImage(GControl).Width;
         conheight := TQRGrImage(GControl).height;
         widthDivHeight := imgwidth / imgheight;
         if TQRGrImage(GControl).stretch then
             tempmap.canvas.stretchdraw( Rect( 0, 0, tempmap.width, tempmap.height),
                                             TQRGrImage(GControl).Picture.graphic)
         else
         begin
             // handle the proportional resizing fmProportional, fmKeepWidth, fmKeepHeight, fmInsideProp
             if TQRGrImage(GControl).FitMode = fmProportional then
             begin
                  // picture grows or shrinks but stays proportional
             end
             else if TQRGrImage(GControl).FitMode = fmKeepWidth then
             begin
                  // keep the control width and the picture proportional

             end
             else if TQRGrImage(GControl).FitMode = fmKeepHeight then
             begin
                  // keep the control height and the picture proportional

             end
             else if TQRGrImage(GControl).FitMode = fmInsideProp then
             begin
                  // picture shrinks/grows to fit control but stays proportional
                  if (imgWidth/conwidth) < (imgHeight/conHeight) then
                  begin
                     // the height ratio is greater so shrink the width and center horiz
                     Dest.Right := dest.left + round(imgwidth/(imgHeight/conHeight));
                     coffset := (conwidth - round(imgwidth/(imgHeight/conHeight))) div 2;
                     dest.left := dest.left + coffset;
                     dest.right := dest.right + coffset;
                     Xmm := Xmm + (25.4* coffset / Screen.PixelsPerInch);
                 end
                 else
                 begin
                     Dest.Bottom := dest.top + round(imgHeight/(imgWidth/conwidth));
                     coffset := ( conheight - round(imgHeight/(imgWidth/conwidth))) div 2;
                     dest.top := dest.top + coffset;
                     dest.Bottom := dest.Bottom + coffset;
                     Ymm := Ymm + (25.4* coffset / Screen.PixelsPerInch);
                end;
             end;
             tempmap.Width := dest.Right - dest.Left;
             tempmap.Height := dest.Bottom - dest.Top;
             tempmap.canvas.StretchDraw( rect(0,0,tempmap.Width,tempmap.Height), TQRGrImage(GControl).Picture.graphic);
         end;
         xrescale := ((25.4*TQRGrImage(GControl).width/ Screen.PixelsPerInch) / tempmap.width);
         yrescale := ((25.4*TQRGrImage(GControl).height/ Screen.PixelsPerInch) / tempmap.height);
    end
    else if (GControl is TQRDBImage) then
    begin
       qrdbcont := GControl as TQRDBImage;
       if qrdbcont.field <> nil then
       begin
          drawpict.Assign( qrdbcont.field );
          //AspectRatio := 1.0 * drawpict.Width / drawpict.height;
          if not qrdbcont.Stretch then
          begin
              // the picture shrinks or grows to fit the control
              // this tiresome code is a mirror of that in the DBImage print
              if (drawpict.Width/conwidth) < (drawpict.Height/conHeight) then
              begin
                  // the height ratio is greater so shrink the width and center horiz
                  conwidth := round(drawpict.width/(drawpict.Height/conHeight));
              end
              else
              begin
                  conheight := round(drawpict.Height/(drawpict.Width/conwidth));
              end;
          end;
          if qrdbcont.stretch then
          begin
               tempmap.assign( qrdbcont.field );
               conwidth := tempmap.Width;
               conheight := tempmap.height;
          end
          else
          begin
               tempmap.canvas.StretchDraw( Rect( 0, 0, tempmap.width, tempmap.height), drawpict.graphic);
          end;

          xrescale := ((25.4*qrdbcont.width/ Screen.PixelsPerInch) / tempmap.width);
          yrescale := ((25.4*qrdbcont.height/ Screen.PixelsPerInch) / tempmap.height);
       end;
    end;
    // stream out the ascii encoded picture data
    //FCompressImages := false;
    if FCompressImages then
         lineout := 'lzw'
    else
         lineout := 'None';

    xscale := 1.0 * conWidth / tempmap.Width * xrescale;
    yscale := 1.0 * conheight / tempmap.height * yrescale;

    imgbyref := false;
    imgurl := '';
    if Assigned(FOnImageURLNeeded) then
      FOnImageURLNeeded(Self,GControl,imgurl,imgbyref);

    if imgbyref then
      ctext := format('<Item Type="Image" X="%-4.2f" Y="%-4.2f" Width="%-d" Height="%-d" LY="1" XS="%6.3f" YS="%6.3f" Cmp="'+lineout+'" ImageFile="%s">',
                      [ Xmm, Ymm, tempmap.width, tempmap.height, xscale, yscale, imgurl ])
    else
      ctext := format('<Item Type="Image" X="%-4.2f" Y="%-4.2f" Width="%-d" Height="%-d" LY="1" XS="%6.3f" YS="%6.3f" Cmp="'+lineout+'" CID="%-s" DBR="%-d">',
                      [ Xmm, Ymm, tempmap.width, tempmap.height, xscale, yscale, GControl.name, ExportingRecordNumber ]);
    writetostream( ctext);

    if FDoImages and (not imgbyref) then
    begin
      if FCompressImages then
      begin
         tempmap.SaveToStream( rlestream );
         rlestream.Seek( 0, 0 );
         LZWEncode( rlestream, istream);
      end
      else
      begin
         tempmap.SaveToStream( istream );
         istream.Seek( 0, 0 );
      end;
      // convert to ASCIIHEX rep.
      istream.Seek( 0, 0 );
      bytesin := istream.Read( cc, REC_SIZE );
      lineout := '';
      while( bytesin > 0 ) do
      begin
           for i := 0 to bytesin-1 do
           begin
              Hexit( C1, C2, cc[i] );
              lineout := lineout +C1+C2;
           end;
           writetostream( lineout );
           lineout := '';
           bytesin := istream.Read( cc, REC_SIZE );
      end;
    end;
    writetostream( '</Item>' );
  finally
    tempmap.free;
    drawpict.free;
    istream.Free;
    rlestream.free;
  end;
end;

procedure TQRXDocumentFilter.EndPage;
begin
     //do nothing;
end;

procedure TQRXDocumentFilter.NewPage;
begin
     if FPagenumber > 1 then  writetostream( '</Page>');
     writetostream( '<Page Number="'+inttostr( FPagenumber)+'">' );
     inc(FPagenumber);
end;

// Standard run-length encoding code - translated from C
procedure RunLength(Source, Target: TStream);
var
  Buffer, C, LastOut, LastBuf: String;
  LastCnt: Integer;
begin

  C := ' ';
  Buffer := '';
  LastOut := '';
  LastCnt := 0;
  Source.Position := 0;
  Target.Position := 0;

  while Source.Position < Source.Size do
  begin
    Source.Read(C[1], 1);
    if (C = LastOut) and (LastCnt <= 127) then
    begin
       if Length(LastBuf) > 0 then
       begin
          Buffer := Buffer + CHR(Length(LastBuf) - 1) + LastBuf;
          LastBuf := '';
       end;
       Inc(LastCnt);
    end
    else
    begin
       if LastCnt = 0 then
       begin
       end
       else
       if LastCnt > 1 then
       begin
          Buffer := Buffer + CHR(257 - LastCnt) + LastOut;
       end
       else
       begin
          LastBuf := LastBuf + LastOut;
          if Length(LastBuf) >= 128 then
          begin
             Buffer := Buffer + CHR(Length(LastBuf) - 1) + LastBuf;
             LastBuf := '';
          end;
       end;
       LastCnt := 1;
       LastOut := C;
    end;

    if Length(Buffer) > 0 then
    begin
       Target.Write(Buffer[1], Length(Buffer));
    end;
    Buffer := '';

  end;

  if Length(LastBuf) > 0 then begin
     Buffer := Buffer + CHR(Length(LastBuf) - 1) + LastBuf;
  end;

  if LastCnt = 1 then begin
     Buffer := Buffer + CHR(0) + LastOut;
  end;

  if LastCnt > 1 then begin
     Buffer := Buffer + CHR(257 - LastCnt) + LastOut;
  end;

  Buffer := Buffer + CHR(128) + '>';
  Target.Write(Buffer[1], Length(Buffer));

  Source.Position := 0;
  Target.Position := 0;
end;

initialization
   XMLEncoding := DefaultEncoding;


end.

