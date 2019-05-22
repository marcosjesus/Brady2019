unit QRWebFilt;
////////////////////////////////////////////////////////////////////////////
//  Unit : QRWebFilt.pas
//
//  TQRGAbstractExportFilter -> TQRGHTMLDocumentFilter
//
//  The new HTML Export document filter class -
//   No lines, columns or text entries.
//
//  (c) 2001 QBS Software
//      Upgraded to be multi-page  29th September 2001
//      Right align bug fixed 11th October
//      Center align bug fixed 14th October
//      Stuff spaces with &nbsp;  ..
//      Change text coords to pixels. Add VertAdjust to HRule   ..
//      Suppress 'next' on final page
//      Add 'FirstLastLinks', 'FinalPage' property
//      25/11/02 add proportional control
//      24th Feb 2002 Added JPEG file saves
//      3rd March 2002 Added concat, linkfontname
//     21/12/2003 QR 4 added TQRHTMLFilt component
//      20-01-2005  This copy has a special single form multipage mode
//      see comments marked 'SINGLE FORM'
////////////////////////////////////////////////////////////////////////////
{$define VER36}
interface
uses windows, classes, controls, stdctrls,sysutils, graphics, buttons,
     forms, extctrls, dialogs, printers, db, ComCtrls, qrexport,
     QRPrntr, Quickrpt, QR5Const, qrctrls, grimgctrl, jpeg;

type

  TQRGAbstractExportFilter = class(TQRExportFilter)
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
  protected
     function GetEncoding : TTextEncoding;
     procedure SetEncoding( value : TTextEncoding);
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
    constructor Create( filename : string ); override;
    procedure Start(PaperWidth, PaperHeight : integer; Font : TFont); override;
    procedure Finish; override;
    procedure EndPage; override;
    procedure NewPage; override;
    procedure AcceptGraphic( Xoff, Yoff : extended; GControl : TControl); override;
    procedure TextOut(X, Y : extended; Font : TFont; BGColor : TColor;
               Alignment : TAlignment; Text : string); override;
    property TextEncoding : TTextencoding read GetEncoding write setEncoding;
  end;


  TQRGHTMLDocumentFilter = class(TQRGAbstractExportFilter)
  private
    FFreeStream : boolean;         
    FPageLength : integer;
    FBodyColor : TColor;
    FBackgroundPic : String;
    FFirstReport : boolean;
    FReportNumber : integer;
    FExtraBody : String;
    FPageNumber : longint;
    FNextPicnum : longint;
    FPageMaxY : integer;
    HTMFirstPage : boolean;
    HTMLastPage : boolean;
    function getTransparentTextBG : boolean;
    procedure setTransparentTextBG( value : boolean);
    function getPictureDir : string;
    procedure setPictureDir( value : string);
    function getMultiPage : boolean;
    procedure setMultiPage( value : boolean);
    function getFinalPage : integer;
    procedure setFinalPage( value : integer);
    function getFirstLastLinks :boolean;
    procedure setFirstLastLinks( value : boolean);
    function getPageLinks :boolean;
    procedure setPageLinks( value : boolean);
    function getConcatenate : boolean;
    procedure setConcatenate( value : boolean);
    function getConcatCount : integer;
    procedure setConcatCount( value : integer);
    procedure setLinkFontHeight( value : integer);
    function getLinkFontHeight : integer;
    function getLinkFontName : string;
    procedure setLinkFontName( value : string);
  protected
    function GetFilterName : string; override;
    function GetDescription : string; override;
    function GetExtension : string; override;
    function GetStreaming : boolean; override;
    procedure CreateStream(Filename : string); override;
    procedure CloseStream; override;
  public
    LinkPrefix : string;
    constructor Create( filename : string ); override;
    procedure StorePage; override;
    procedure TextOut(X, Y : extended; Font : TFont; BGColor : TColor;
               Alignment : TAlignment; Text : string); override;
    procedure ProcessPage; override;
    procedure Start(PaperWidth, PaperHeight : integer; Font : TFont); override;
    procedure Finish; override;
    procedure SetHTMLBody( BodyCol : TColor; BGPic, BExtra : string );
    property TransparentTextBG : boolean read getTransparentTextBG  write setTransparentTextBG;
    procedure NewPage; override;
    procedure EndPage; override;
    procedure EndConcat;
    procedure AcceptGraphic( Xoff, Yoff : extended; GControl : TControl); override;
    property PictureDir : string read getPictureDir write setPictureDir;
    property MultiPage : boolean read getMultiPage  write setMultiPage;
    property PageLinks : boolean read getPageLinks  write setPageLinks;
    property PageLength : integer read FPageLength write FPageLength;
    property FinalPage : integer read getFinalPage write setFinalPage;
    property FirstLastLinks : boolean read getFirstLastLinks write setFirstLastLinks;
    property Stream;
    property FreeStream : boolean read FFreeStream write FFreeStream;
    property Concat : boolean read getConcatenate write setConcatenate;
    property ConcatCount : integer read getConcatCount write setConcatCount;
    property LinkFontSize : integer read getLinkFontHeight write setLinkFontHeight;
    property LinkFontName : string read getLinkFontName write setLinkFontName;
    property TextEncoding;
  end;

  TQRHTMLFilter = class(TComponent)
  protected
  private
     FImageLinkPrefix : string;
     FPagelinkPrefix : string;
    //function getTransparentTextBG : boolean;
    //procedure setTransparentTextBG( value : boolean);
     function GetEncoding : TTextEncoding;
     procedure SetEncoding( value : TTextEncoding);
    function getPictureDir : string;
    procedure setPictureDir( value : string);
    function getMultiPage : boolean;
    procedure setMultiPage( value : boolean);
    function getFinalPage : integer;
    procedure setFinalPage( value : integer);
    function getFirstLastLinks :boolean;
    procedure setFirstLastLinks( value : boolean);
    function getPageLinks :boolean;
    procedure setPageLinks( value : boolean);
    function getConcatenate : boolean;
    procedure setConcatenate( value : boolean);
    function getConcatCount : integer;
    procedure setConcatCount( value : integer);
    procedure setLinkFontHeight( value : integer);
    function getLinkFontHeight : integer;
    function getLinkFontName : string;
    procedure setLinkFontName( value : string);
    //function getPageLength : integer;
    //procedure setPageLength( value : integer);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property ImageLinkPrefix : string read FImageLinkPrefix write FImageLinkPrefix;
    property PagelinkPrefix : string read FPagelinkPrefix write FPagelinkPrefix;
    property PictureDir : string read getPictureDir write setPictureDir;
    property MultiPage : boolean read getMultiPage  write setMultiPage;
    property PageLinks : boolean read getPageLinks  write setPageLinks;
    //property PageLength : integer read getPageLength write setPageLength;
    property FinalPage : integer read getFinalPage write setFinalPage;
    property FirstLastLinks : boolean read getFirstLastLinks write setFirstLastLinks;
    property Concat : boolean read getConcatenate write setConcatenate;
    property ConcatCount : integer read getConcatCount write setConcatCount;
    property LinkFontSize : integer read getLinkFontHeight write setLinkFontHeight;
    property LinkFontName : string read getLinkFontName write setLinkFontName;
    property TextEncoding : TTextencoding read GetEncoding write setEncoding;
  end;


  function basename( fname : string ) : string;


implementation
  var
    HTMTransparentTextBG : boolean;
    HTMFinalPage : integer;
    //HTMPageLength : integer;
    HTMMultiPage : boolean;
    HTMPageLinks : boolean;
    HTMConcatenate : boolean;
    HTMConcatCount : integer;
    HTMFirstLastLinks : boolean;
    HTMPictureDir : string;
    HTMLinkFontName : string;
    HTMLinkFontHeight : integer;
    mmToPix : extended;
    HTMLEncoding : TTextEncoding;

constructor TQRHTMLFilter.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  QRExportFilterLibrary.AddFilter(TQRGHTMLDocumentFilter);
end;

destructor TQRHTMLFilter.Destroy;
begin
  QRExportFilterLibrary.RemoveFilter(TQRGHTMLDocumentFilter);
  inherited Destroy;
end;
{
function TQRHTMLFilter.getTransparentTextBG : boolean;
begin
    result := HTMTransparentTextBG;
end;

procedure TQRHTMLFilter.setTransparentTextBG( value : boolean);
begin
     HTMTransparentTextBG := value;
end;
}
function TQRHTMLFilter.getPictureDir : string;
begin
    result := HTMPictureDir;
end;
procedure TQRHTMLFilter.setPictureDir( value : string);
begin
    HTMPictureDir := value;
end;
function TQRHTMLFilter.getMultiPage : boolean;
begin
    result := HTMMultiPage;
end;
procedure TQRHTMLFilter.setMultiPage( value : boolean);
begin
     HTMMultiPage := value;
end;
{
function TQRHTMLFilter.getPageLength : integer;
begin
    result := HTMPageLength;
end;

procedure TQRHTMLFilter.setPageLength( value : integer);
begin
     HTMPageLength := value;
end;
}

function TQRHTMLFilter.GetEncoding : TTextEncoding;
begin
     result := HTMLEncoding;
end;

procedure TQRHTMLFilter.SetEncoding( value : TTextEncoding);
begin
     HTMLEncoding := value;
end;

function TQRHTMLFilter.getFinalPage : integer;
begin
    result := HTMFinalPage;
end;
procedure TQRHTMLFilter.setFinalPage( value : integer);
begin
     HTMFinalPage := value;
end;

function TQRHTMLFilter.getFirstLastLinks :boolean;
begin
    result := HTMFirstLastLinks;
end;
procedure TQRHTMLFilter.setFirstLastLinks( value : boolean);
begin
     HTMFirstLastLinks := value;
end;
function TQRHTMLFilter.getPageLinks :boolean;
begin
    result := HTMPageLinks;
end;
procedure TQRHTMLFilter.setPageLinks( value : boolean);
begin
     HTMPageLinks := value;
end;
function TQRHTMLFilter.getConcatenate : boolean;
begin
    result := HTMConcatenate;
end;
procedure TQRHTMLFilter.setConcatenate( value : boolean);
begin
     HTMConcatenate := value;
end;
function TQRHTMLFilter.getConcatCount : integer;
begin
    result := HTMConcatCount;
end;
procedure TQRHTMLFilter.setConcatCount( value : integer);
begin
     HTMConcatCount := value;
end;
procedure TQRHTMLFilter.setLinkFontHeight( value : integer);
begin
     HTMLinkFontHeight := value;
end;
function TQRHTMLFilter.getLinkFontHeight : integer;
begin
    result := HTMLinkFontHeight;
end;
function TQRHTMLFilter.getLinkFontName : string;
begin
    result := HTMLinkFontName;
end;
procedure TQRHTMLFilter.setLinkFontName( value : string);
begin
     HTMLinkFontName := value;
end;
{TQRGAbstractExportFilter}
constructor TQRGAbstractExportFilter.Create( filename : string );
begin
      inherited Create( filename);
end;

function TQRGAbstractExportFilter.GetEncoding : TTextEncoding;
begin
     result := HTMLEncoding;
end;

procedure TQRGAbstractExportFilter.SetEncoding( value : TTextEncoding);
begin
     HTMLEncoding := value;
end;

procedure TQRGAbstractExportFilter.AcceptGraphic( Xoff, Yoff : extended; GControl : TControl);
begin
end;

function TQRGAbstractExportFilter.GetFilterName : string;
begin
  result := 'QRAbstract'; // Do not translate
end;

function TQRGAbstractExportFilter.GetDescription : string;
begin
  Result := '';
end;

function TQRGAbstractExportFilter.GetExtension : string;
begin
  Result := '';
end;

procedure TQRGAbstractExportFilter.Start(PaperWidth, PaperHeight : integer; Font : TFont);
begin
  CreateStream(Filename);
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

procedure TQRGAbstractExportFilter.CreateStream(Filename : string);
begin
  FStream := TFileStream.Create(Filename, fmCreate);
end;

procedure TQRGAbstractExportFilter.CloseStream;
begin
  FStream.Free;
end;

procedure TQRGAbstractExportFilter.WriteToStream(const AText : string);
begin
  finaldoc.Add(atext);
  exit;

  Stream.Write(AText[1], length(AText)*2);
end;

procedure TQRGAbstractExportFilter.WriteLnToStream(const AText : string);
begin
  WriteToStream(AText + #13 + #10);
end;


procedure TQRGAbstractExportFilter.Finish;
var
  enc : TQRTextEncoding;
begin
   enc := TQRTextEncoding.Create;
   case TextEncoding of
     ASCIIEncoding: finaldoc.SaveToFile(Filename, enc.ASCII);
     BigEndianUnicodeEncoding:  finaldoc.SaveToFile(Filename, enc.BigEndianUnicode);
     DefaultEncoding: finaldoc.SaveToFile(Filename, enc.ASCII);
     UnicodeEncoding: finaldoc.SaveToFile(Filename, enc.Unicode);
     UTF7Encoding: finaldoc.SaveToFile(Filename, enc.UTF7);
     UTF8Encoding: finaldoc.SaveToFile(Filename, enc.UTF8);
   end;
   enc.Free;
   FFont.Free;
   FActiveFont.Free;
   finaldoc.Free;
   CloseStream;

   inherited Finish; // doesn't do owt
end;

procedure TQRGAbstractExportFilter.NewPage;
begin
  FPageProcessed := False;
  FActiveFont.Free;
  FActiveFont := TFont.Create;
  inherited NewPage;
end;

procedure TQRGAbstractExportFilter.EndPage;
begin
  ProcessPage;
  inherited EndPage;
end;

procedure TQRGAbstractExportFilter.ProcessPage;
begin
  FPageProcessed := True;
end;

procedure TQRGAbstractExportFilter.StorePage;
begin
end;

procedure TQRGAbstractExportFilter.TextOut(X, Y : extended; Font : TFont;
                      BGColor : TColor; Alignment : TAlignment; Text : string);
begin
end;

function TQRGAbstractExportFilter.GetText(X, Y : extended; var Font : TFont) : string;
begin
end;


{TQRGHTMLDocumentFilter}
function TQRGHTMLDocumentFilter.getTransparentTextBG : boolean;
begin
    result := HTMTransparentTextBG;
end;
procedure TQRGHTMLDocumentFilter.setTransparentTextBG( value : boolean);
begin
     HTMTransparentTextBG := value;
end;
function TQRGHTMLDocumentFilter.getPictureDir : string;
begin
    result := HTMPictureDir;
end;
procedure TQRGHTMLDocumentFilter.setPictureDir( value : string);
begin
    HTMPictureDir := value;
end;
function TQRGHTMLDocumentFilter.getMultiPage : boolean;
begin
    result := HTMMultiPage;
end;
procedure TQRGHTMLDocumentFilter.setMultiPage( value : boolean);
begin
     HTMMultiPage := value;
end;
function TQRGHTMLDocumentFilter.getFinalPage : integer;
begin
    result := HTMFinalPage;
end;
procedure TQRGHTMLDocumentFilter.setFinalPage( value : integer);
begin
     HTMFinalPage := value;
end;
function TQRGHTMLDocumentFilter.getFirstLastLinks :boolean;
begin
    result := HTMFirstLastLinks;
end;
procedure TQRGHTMLDocumentFilter.setFirstLastLinks( value : boolean);
begin
     HTMFirstLastLinks := value;
end;
function TQRGHTMLDocumentFilter.getPageLinks :boolean;
begin
    result := HTMPageLinks;
end;
procedure TQRGHTMLDocumentFilter.setPageLinks( value : boolean);
begin
     HTMPageLinks := value;
end;
function TQRGHTMLDocumentFilter.getConcatenate : boolean;
begin
    result := HTMConcatenate;
end;
procedure TQRGHTMLDocumentFilter.setConcatenate( value : boolean);
begin
     HTMConcatenate := value;
end;
function TQRGHTMLDocumentFilter.getConcatCount : integer;
begin
    result := HTMConcatCount;
end;
procedure TQRGHTMLDocumentFilter.setConcatCount( value : integer);
begin
     HTMConcatCount := value;
end;
procedure TQRGHTMLDocumentFilter.setLinkFontHeight( value : integer);
begin
     HTMLinkFontHeight := value;
end;
function TQRGHTMLDocumentFilter.getLinkFontHeight : integer;
begin
    result := HTMLinkFontHeight;
end;
function TQRGHTMLDocumentFilter.getLinkFontName : string;
begin
    result := HTMLinkFontName;
end;
procedure TQRGHTMLDocumentFilter.setLinkFontName( value : string);
begin
     HTMLinkFontName := value;
end;

function TQRGHTMLDocumentFilter.GetFilterName : string;
begin
  Result := SqrHtmlDocument;
end;

function TQRGHTMLDocumentFilter.GetDescription : string;
begin
  Result := SqrHTMLDocumentForWeb;
end;

function TQRGHTMLDocumentFilter.GetExtension : string;
begin
  Result := 'HTM'; // Do not translate
end;

function TQRGHTMLDocumentFilter.GetStreaming : boolean;
begin
  //Result := not MultiPage;// stream for 1 page report mode
  /// ************** SINGLE FORM
  result := false;
end;

procedure TQRGHTMLDocumentFilter.CreateStream(Filename : string);
begin
  if Filename = '' then
  begin
    FStream := TMemoryStream.Create;
    FreeStream := false;
  end {else
  begin
    FreeStream := true;
    inherited CreateStream(Filename);
  end};
end;

procedure TQRGHTMLDocumentFilter.CloseStream;
begin
  if FreeStream then
    inherited CloseStream;
end;

// QBS Upgraded HTML filter starts
constructor TQRGHTMLDocumentFilter.Create( filename : string );
begin
   inherited Create( Filename);
   FBackgroundpic := '';
   FBodyColor := clWhite;
   FExtraBody := '';
   HTMTransparentTextBG := false;
   HTMFirstPage := true;
   FFirstReport := true;
   HTMConcatenate := false;
   HTMMultiPage := false;
   HTMPageLinks := false;
   FPageNumber := 1;
   HTMLastPage := false;
   HTMFinalPage := 0;
   FPageLength := 2500;
   HTMPictureDir := '';
   FNextPicnum := 0;
   HTMLinkFontName := 'Arial';
   HTMLinkFontHeight := 12;
   FReportNumber := 1;
   HTMConcatCount := 1;
   mmToPix := 96.0 / 25.4;
   finaldoc := TStringlist.Create;
end;
// Give user access to new properties
procedure TQRGHTMLDocumentFilter.SetHTMLBody( BodyCol : TColor; BGPic, BExtra : string );
begin
    FBodyColor := BodyCol;
    FBackGroundPic := BGPic;
    FExtraBody := BExtra;
end;


// QBSS : override method to skip converttoxxx
procedure TQRGHTMLDocumentFilter.ProcessPage;
begin
  FPageProcessed := True;
  StorePage;
end;

function ColTrans( ct : TColor ) : string;
var 
   RGBColour: longint; 
begin 
   RGBColour := ColorToRGB(ct); 
   result := Format('#%2.2x%2.2x%2.2x',[GetRValue(RGBColour),GetGValue(RGBColour),GetBValue(RGBColour)]); 
end;

// Overridden Start
procedure TQRGHTMLDocumentFilter.Start(PaperWidth, PaperHeight : integer; Font : TFont);
var
    propstr : string;
begin
  if not multipage then
  begin
    inherited;  // creates a stream
    propstr := ' bgcolor="'+coltrans( FBodycolor)+'" ';
    if trim(FBackgroundpic) <> '' then
          propstr := propstr + ' background="'+FBackgroundpic+'"';
    if trim(FExtraBody) <> '' then
          propstr := propstr + ' ' + FExtraBody;

    writetostream( '<html>' +chr($0D) + chr($0A) );
    writetostream( '<head>' +chr($0D) + chr($0A) );
    writetostream( ' <title>'+self.Filename+'</title>' +chr($0D) + chr($0A) );
    writetostream( '</head>' +chr($0D) + chr($0A)  );
    writetostream( '<body '+propstr+'>' +chr($0D) + chr($0A) );
  end;
end;

// overridden Finish
procedure TQRGHTMLDocumentFilter.Finish;
begin

  if not multipage then
  begin
    writetostream( '</body>' +chr($0D) + chr($0A) );
    writetostream( '</html>' +chr($0D) + chr($0A) );
  end;
  // inherited closes the stream. don't in Concat mode
  if not HTMConcatenate and not multipage then
      inherited finish
  else;
      Dec( FPagenumber);
  FFirstReport := false;
  inc(FReportNumber);
end;

procedure TQRGHTMLDocumentFilter.EndConcat;
begin
     HTMConcatenate := false;
     multipage := false;
     Finish;
end;


procedure TQRGHTMLDocumentFilter.EndPage;
var
     Linkstr, hfilename, hdr, prstr, nextstr : string;
     firststr, laststr : string;
begin
    inc(FPageNumber); // ********************* SINGLE FORM *****
    if not MultiPage or HTMFirstPage then
    begin
        HTMFirstPage := false;
        exit;
    end;
    // put in links to other pages
    if pagelinks and multipage then
    begin
      hdr := '<div style="position:absolute;top:%-dpx;left:10mm;font-family:' + HTMlinkfontname +
                    ';font-size:%-dpt;'+ 'text-decoration:none;text-align:left;">';
      linkstr := format( hdr, [FPageMaxY + 30, HTMlinkfontheight] );
      prstr := '';
      nextstr := '';
      if not HTMLastPage then
      begin
          hfilename := basename(filename) + format( '%-d.html', [FPageNumber+1] );
          nextstr := '<a href="'+ LinkPrefix + hfilename +'">Next page</a>';
      end;
      if fpagenumber > 1 then
      begin // put in a back link
         hfilename := basename(filename) + format( '%-d.html', [FPageNumber-1] );
         prstr := '<a href="'+ LinkPrefix + hfilename +'">Previous page</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
      end;
      if HTMFirstlastLinks then
      begin
          if (fpagenumber = 1) then // need to know last pageno
          begin
             hfilename := basename(filename) + format( '%-d.html', [HTMFinalPage] );
             laststr := '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="'+ hfilename +'">Last page</a>';
          end;
          if HTMLastPage then
          begin
             hfilename := basename(filename) + format( '%-d.html', [1] );
             firststr := '<a href="'+ LinkPrefix + hfilename +'">First page</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
          end;
      end;
      linkstr := linkstr + firststr + prstr + nextstr + laststr + '<br><br></div>';
    end;
    writetostream( linkstr + chr($0D) + chr($0A) );
    writetostream( '</body>' +chr($0D) + chr($0A) );
    writetostream( '</html>' +chr($0D) + chr($0A) );
    inc(FPageNumber);
end;

// QBSS : override method to skip converttoxxx
procedure TQRGHTMLDocumentFilter.NewPage;
var
     hfilename, propstr : string;
begin
    if not HTMMultiPage then
    begin
        HTMFirstPage := false; // if it's not multipage do nowt
        exit;
    end;
    HTMFirstPage := false;
    closestream;
    FPageMaxY := 0; // can be any small value
    hfilename := basename(filename) + format( '%-d.html', [FPageNumber] );
    createstream( hfilename );
    propstr := ' bgcolor="'+coltrans( FBodycolor)+'" ';
    if trim(FBackgroundpic) <> '' then
          propstr := propstr + ' background="'+FBackgroundpic+'"';
    if trim(FExtraBody) <> '' then
          propstr := propstr + ' ' + FExtraBody;
    writetostream( '<html>' +chr($0D) + chr($0A) );
    writetostream( '<head>' +chr($0D) + chr($0A) );
    writetostream( ' <title>' + hfilename + '</title>' +chr($0D) + chr($0A) );
    writetostream( '</head>' +chr($0D) + chr($0A)  );
    writetostream( '<body '+propstr+'>' +chr($0D) + chr($0A) );
end;

procedure TQRGHTMLDocumentFilter.StorePage;
begin
     // do nothing.
end;

// Using absolute positions we can output immediately
procedure TQRGHTMLDocumentFilter.TextOut(X, Y : extended; Font : TFont; BGColor : TColor;
               Alignment : TAlignment; Text : string);
//<DIV style="position:absolute;left:1px;top:184px;"><hr width="500" size="2" color="black"></div>
const
    // 12/10/01 top, left of <DIV now in pixels.
    DivStrDef = '<div style="position:absolute;top:!toppx;left:!leftpx;font-family:!fontname;'
                +'font-size:!fontsizept;';
                 //'color:!color;text-decoration:!deco;text-align:left;background-color:!bgcolor;'+
                 //'font-style:!style;font-weight :!weight;">';
var
  I, K, afontheight, xp, yp, pixely : integer;
  textsize : integer;
  Fontcolor : TColor;
  AText, afontname, fitalic, fbold, funderline, fstrike, fbgcolor : string;
  NewDivStr, aLinkText, originaltext : string;
  parentrep : TQuickrep;
  CBand : TQRCustomband;
  break2 : boolean;
  cLinkType : TLinkDef;
  tmap : TBitmap;

  procedure FixDivStr;
  begin
        newdivstr := stringreplace( newdivstr, '!top', format( '%-d', [yp] ), [rfReplaceAll] );
        newdivstr := stringreplace( newdivstr, '!left', format( '%-d', [xp] ), [rfReplaceAll] );
        newdivstr := stringreplace( newdivstr, '!fontname', trim(afontname), [rfReplaceAll] );
        newdivstr := stringreplace( newdivstr, '!fontsize', format( '%-d', [afontheight] ), [rfReplaceAll] );
  end;

begin
      tmap := TBitmap.create;
      try
        atext := Text;
        originaltext := Text;
        aLinktext := '';
        clinktype := ldHTTPJump; // keep compiler quiet !
        parentrep := TQuickrep( self.owner );
        if parentrep.DataSet <> nil then
              HTMLastPage := ( parentrep.DataSet.Eof and ( HTMConcatcount = FReportNumber ));
        break2 := false;
        for i := 0 to parentrep.ControlCount-1 do
        begin
             if  parentrep.Controls[i].InheritsFrom( TQRCustomBand ) then
             begin
                  CBand := TQRCustomBand(parentrep.Controls[i]);
                  for k := 0 to CBand.controlcount-1 do
                    if atext = '%!'+CBand.controls[k].name+'!%' then
                    begin
                          if (CBand.controls[k] is TQRHTMLLabel ) then
                          begin
                               aLinkText := TQRHTMLLabel( CBand.controls[k]).linktext;
                               aText := TQRHTMLLabel( CBand.controls[k]).caption;
                               originaltext := aText;
                               cLinkType := TQRHTMLLabel( CBand.controls[k]).LinkType;
                               break2 := true;
                               break;
                          end;
                    end;
                    if break2 then break;
             end;
        end;
        // must be a standard text or label control
        newdivstr := divstrdef;
        atext := stringreplace( atext, '&', '&amp;', [rfReplaceAll] );
        atext := stringreplace( atext, '<', '&lt;', [rfReplaceAll] );
        atext := stringreplace( atext, '>', '&gt;', [rfReplaceAll] );
        // 15/10/01 stuff spaces in text
        atext := stringreplace( atext, ' ', '&nbsp;', [rfReplaceAll] );
        afontname := Font.Name;
        aFontheight := Font.Size;
        if alinktext <> '' then
        begin
              if cLinkType = ldHTTPJump then
                 atext := '<a href="' + aLinktext + '">' + aText + '</a>'
              else if cLinkType = ldNameJump then
                 atext := '<a href="#' + aLinktext + '">' + aText + '</a>'
              else
                 atext := '<a name="' + aLinktext + '">';
        end;
        // 12/10/01 try pixels ? map the same as graphic elements
        xp := parentrep.QRPrinter.XPos( X );
        yp := parentrep.QRPrinter.YPos( Y );
        // 08/10/01 Alignment - recalculate positions
        case alignment of
            taLeftJustify : ;// do nothing
            taRightJustify :
            begin
                // the xpos is the right of the text pos
                tmap.canvas.Font.Assign( font );
                // must use 'originaltext' not 'atext' because we may have added html
                textsize := tmap.canvas.textwidth( originaltext );
                xp := xp - textsize;
            end;
            taCenter:
            begin
                // the xpos is the center of the text pos
                tmap.canvas.Font.Assign( font );
                // must use 'originaltext' not 'atext' because we may have added html
                textsize := tmap.canvas.textwidth( originaltext );
                xp := xp - (textsize div 2);
            end;
        end;
        // used to position links at page bottom
        pixely := yp; // to pixels
        if pixely > FPageMaxY then FPageMaxY := pixely;

        // ********* SINGLE FORM
        yp := round(((FPagenumber-2) * (mmToPix*FPaperHeight/10.0)) + yp);
        FixDivStr;

        Fontcolor := Font.Color;
        fBold := 'normal';
        fitalic := 'none';
        funderline := 'none';
        if HTMTransparentTextBG then
            fbgcolor := 'Transparent'
        else
            fbgcolor := 'white';
        if fsBold in Font.Style then
               fbold := 'Bold';
        if fsItalic in Font.Style then
               fitalic := 'Italic';
        if fsUnderline in Font.Style then
               funderline := 'Underline';
        if fsStrikeout in Font.Style then
               fstrike := 'Strikeout';
        if fitalic = 'Italic' then
          newdivstr := newdivstr + 'font-style:italic;';
        if fbold = 'Bold' then
          newdivstr := newdivstr + 'font-weight:bold;';
        if Fontcolor <> clBlack then
          newdivstr := newdivstr + 'color:'+trim(coltrans(fontcolor))+';';

        newdivstr := newdivstr + '">';
        writeToStream( newdivstr + chr($0D)+chr($0A));
        writeToStream( atext+ chr($0D)+chr($0A) );
        writeToStream('</DIV>'+ chr($0D)+chr($0A));
      finally
          tmap.free;
      end;
end;

// strip off file extension
function basename( fname : string ) : string;
var
   p : integer;
begin
    basename := fname;
    p := pos( '.', fname );
    if p = 0 then exit;
    basename := copy( fname, 1, p - 1 );
end;

procedure TQRGHTMLDocumentFilter.AcceptGraphic( Xoff, Yoff : extended; GControl : TControl);
var
    xpos, ypos, xdim, ydim, conwidth, conheight : integer;
    imgfile, divstr, FText : string;
    tempmap : TBitmap;
    SCont : TQRHRule;
    dbcont : TQRGrDBImage;
    SSCont : TQRShape;
    SPDFCont : TQRPDFShape;
    qrdbcont : TQRDBImage;
    gdest : TRect;
    aspectratio : double;
    drawpict : TPicture;
    jpeg : TJPEGImage;
begin
  tempmap := TBitmap.create;
  drawpict := TPicture.create;
  jpeg := TJPEGImage.create;
  try
    gdest.Left := trunc(Xoff);
    gdest.Top := round(Yoff);
    // ********* SINGLE FORM
    gdest.Top := round(((FPagenumber-2) * (mmToPix*FPaperHeight/10.0)) + gdest.Top);

    gdest.Right := gdest.left + GControl.Width;
    gdest.Bottom := gdest.top + GControl.height;
    conheight := GControl.height;
    conwidth := GControl.Width;
    if GControl is TQRHRule then
    begin
         SCont := (GControl as TQRHRule);
         //gdest.top := gdest.top - 8 - scont.VertAdjust;
         divstr := '<DIV style="position:absolute;left:'+
         format( '%-d', [gdest.left]) + 'px;top:' +
         format( '%-d', [gdest.top]) +
         format('px;height:%-dpx;"><hr width="', [ SCont.pen.width] ) +
         format( '%-d', [scont.width]) + '" size="' +
         format( '%-d', [SCont.pen.width]) + '" color="' +
         coltrans(scont.pen.color)+'"></div>';
         writeToStream( divstr + chr($0D)+chr($0A));
         if (gdest.top) > FPageMaxY then FPageMaxY := gdest.top;
         exit;
    end
    else if GControl is TQRShape then
    begin
         SSCont := (GControl as TQRShape);
         //gdest.top := gdest.top - 8 - sscont.VertAdjust;
         if SSCont.Shape = qrsHorLine then
         begin
            divstr := '<DIV style="position:absolute;left:'+ format( '%-d', [gdest.left]) +
            'px;top:' + format( '%-d', [gdest.top-8]) +
            format('px;height:%-dpx;"><hr width="', [ SSCont.pen.width] ) +
            format( '%-d', [sScont.width]) + '" size="' + format( '%-d', [SSCont.pen.width]) +
            '" color="' + coltrans(sscont.pen.color)+'"></div>';
            writeToStream( divstr + chr($0D)+chr($0A));
         end
         else if SSCont.Shape = qrsVertLine then
         begin
            divstr := '<DIV style="position:absolute;left:'+
            format( '%-d', [(gdest.left+gdest.right) div 2]) + 'px;top:' + format( '%-d', [gdest.top]) +
            format('px;height:%-dpx;width:', [ SSCont.height] ) +
            format( '%-d', [SSCont.pen.width]) + 'px; background-color: '
                   + coltrans(sscont.pen.color)+'"></div>';
            writeToStream( divstr + chr($0D)+chr($0A));
         end
         else if SSCont.Shape = qrsRectangle then
         begin
            if sscont.brush.style = bsSolid then
            begin
               divstr := '<DIV style="position:absolute;left:'+
               format( '%-d', [gdest.left]) + 'px;top:' + format( '%-d', [gdest.top]) +
               format('px;height:%-dpx;width:', [ SSCont.height] ) +
               format( '%-d', [SSCont.width]) + 'px; background-color: '
                   + coltrans(sscont.brush.color)+'"></div>';
               writeToStream( divstr + chr($0D)+chr($0A));
               exit;
            end;
            // groan we have to do 4 lines 2 h, 2 vert
            // vline left
            divstr := '<DIV style="position:absolute;left:'+
            format( '%-d', [gdest.left]) + 'px;top:' + format( '%-d', [gdest.top]) +
            format('px;height:%-dpx;width:', [ SSCont.height] ) +
            format( '%-d', [SSCont.pen.width]) + 'px; background-color: '
                   + coltrans(sscont.pen.color)+'"></div>';
            writeToStream( divstr + chr($0D)+chr($0A));
            // vline right
            divstr := '<DIV style="position:absolute;left:'+
            format( '%-d', [gdest.right-SSCont.pen.width]) + 'px;top:' + format( '%-d', [gdest.top]) +
            format('px;height:%-dpx;width:', [ SSCont.height] ) +
            format( '%-d', [SSCont.pen.width]) + 'px; background-color: '
                   + coltrans(sscont.pen.color)+'"></div>';
            writeToStream( divstr + chr($0D)+chr($0A));
            // pull up hlines
            gdest.top := gdest.top - 8 - sscont.VertAdjust;
            // hline upper
            divstr := '<DIV style="position:absolute;left:'+
            format( '%-d', [gdest.left]) + 'px;top:' + format( '%-d', [gdest.top]) +
            format('px;height:%-dpx;"><hr width="', [ SSCont.pen.width] ) +
            format( '%-d', [sScont.width]) + '" size="' +
            format( '%-d', [SSCont.pen.width]) + '" color="' +
            coltrans(sscont.pen.color)+'"></div>';
            writeToStream( divstr + chr($0D)+chr($0A));
            // hline lower
            divstr := '<DIV style="position:absolute;left:'+
            format( '%-d', [gdest.left]) + 'px;top:' +
            format( '%-d', [gdest.bottom-8]) +
            format('px;height:%-dpx;"><hr width="', [ SSCont.pen.width] ) +
            format( '%-d', [sScont.width]) + '" size="' +
            format( '%-d', [SSCont.pen.width]) + '" color="' +
            coltrans(sscont.pen.color)+'"></div>';
            writeToStream( divstr + chr($0D)+chr($0A));

         end;
         if (gdest.top) > FPageMaxY then FPageMaxY := gdest.top;
         exit;
    end
    else if GControl is TQRPDFShape then
    begin
         SPDFCont := (GControl as TQRPDFShape);
         //gdest.top := gdest.top - 8 - SPDFCont.VertAdjust;
         if SPDFCont.ShapeType = qrsHorLine then
         begin
            divstr := '<DIV style="position:absolute;left:'+ format( '%-d', [gdest.left]) +
            'px;top:' + format( '%-d', [gdest.top]) +
            format('px;height:%-dpx;"><hr width="', [ SPDFCont.pen.width] ) +
            format( '%-d', [SPDFCont.width]) + '" size="' + format( '%-d', [SPDFCont.pen.width]) +
            '" color="' + coltrans(SPDFCont.pen.color)+'"></div>';
            writeToStream( divstr + chr($0D)+chr($0A));
         end
         else if SPDFCont.ShapeType = qrsVertLine then
         begin
            divstr := '<DIV style="position:absolute;left:'+
            format( '%-d', [(gdest.left+gdest.right) div 2]) + 'px;top:' + format( '%-d', [gdest.top]) +
            format('px;height:%-dpx;width:', [ SPDFCont.height] ) +
            format( '%-d', [SPDFCont.pen.width]) + 'px; background-color: '
                   + coltrans(SPDFCont.pen.color)+'"></div>';
            writeToStream( divstr + chr($0D)+chr($0A));
         end
         else if SPDFCont.ShapeType = qrsRectangle then
         begin
            if SPDFCont.brush.style = bsSolid then
            begin
               divstr := '<DIV style="position:absolute;left:'+
               format( '%-d', [gdest.left]) + 'px;top:' + format( '%-d', [gdest.top]) +
               format('px;height:%-dpx;width:', [ SPDFCont.height] ) +
               format( '%-d', [SPDFCont.width]) + 'px; background-color: '
                   + coltrans(SPDFCont.brush.color)+'"></div>';
               writeToStream( divstr + chr($0D)+chr($0A));
               exit;
            end;
            // groan we have to do 4 lines 2 h, 2 vert
            // vline left
            divstr := '<DIV style="position:absolute;left:'+
            format( '%-d', [gdest.left]) + 'px;top:' + format( '%-d', [gdest.top]) +
            format('px;height:%-dpx;width:', [ SPDFCont.height] ) +
            format( '%-d', [SPDFCont.pen.width]) + 'px; background-color: '
                   + coltrans(SPDFCont.pen.color)+'"></div>';
            writeToStream( divstr + chr($0D)+chr($0A));
            // vline right
            divstr := '<DIV style="position:absolute;left:'+
            format( '%-d', [gdest.right-SPDFCont.pen.width]) + 'px;top:' + format( '%-d', [gdest.top]) +
            format('px;height:%-dpx;width:', [ SPDFCont.height] ) +
            format( '%-d', [SPDFCont.pen.width]) + 'px; background-color: '
                   + coltrans(SPDFCont.pen.color)+'"></div>';
            writeToStream( divstr + chr($0D)+chr($0A));
            // pull up hlines
            gdest.top := gdest.top - 8 - SPDFCont.VertAdjust;
            // hline upper
            divstr := '<DIV style="position:absolute;left:'+
            format( '%-d', [gdest.left]) + 'px;top:' + format( '%-d', [gdest.top]) +
            format('px;height:%-dpx;"><hr width="', [ SPDFCont.pen.width] ) +
            format( '%-d', [SPDFCont.width]) + '" size="' +
            format( '%-d', [SPDFCont.pen.width]) + '" color="' +
            coltrans(SPDFCont.pen.color)+'"></div>';
            writeToStream( divstr + chr($0D)+chr($0A));
            // hline lower
            divstr := '<DIV style="position:absolute;left:'+
            format( '%-d', [gdest.left]) + 'px;top:' +
            format( '%-d', [gdest.bottom-8]) +
            format('px;height:%-dpx;"><hr width="', [ SPDFCont.pen.width] ) +
            format( '%-d', [SPDFCont.width]) + '" size="' +
            format( '%-d', [SPDFCont.pen.width]) + '" color="' +
            coltrans(SPDFCont.pen.color)+'"></div>';
            writeToStream( divstr + chr($0D)+chr($0A));

         end;
         if (gdest.top) > FPageMaxY then FPageMaxY := gdest.top;
         exit;
    end
    else if GControl is TQRGrImage then
    begin
       tempmap.width := GDest.right-gdest.left;
       tempmap.height := gdest.bottom-gdest.top;
       imgfile := GControl.Name + '.jpg';
       if trim(picturedir) <> '' then
                 imgfile := IncludeTrailingPathDelimiter( HTMPictureDir ) + imgfile;
       if (GControl as TQRGrImage).Picture.Graphic is TBitmap then
       begin
            jpeg.Assign((GControl as TQRGrImage).Picture.bitmap);
            jpeg.savetofile(imgfile);
       end
       else
       begin
            tempmap.canvas.stretchdraw( Rect( 0, 0, tempmap.width, tempmap.height),
                                   (GControl as TQRGrImage).Picture.graphic);
            jpeg.Assign(tempmap);
            jpeg.savetofile(imgfile);
       end;
    end
    else if GControl is TQRImage then
    begin
       tempmap.width := GDest.right-gdest.left;
       tempmap.height := gdest.bottom-gdest.top;
       imgfile := GControl.Name + '.jpg';
       if trim(picturedir) <> '' then
                 imgfile := IncludeTrailingPathDelimiter( HTMPictureDir ) + imgfile;
       if (GControl as TQRImage).Picture.Graphic is TBitmap then
       begin
            jpeg.Assign((GControl as TQRImage).Picture.bitmap);
            jpeg.savetofile(imgfile);
       end
       else
       begin
            tempmap.canvas.stretchdraw( Rect( 0, 0, tempmap.width, tempmap.height),
                                   (GControl as TQRImage).Picture.graphic);
            jpeg.Assign(tempmap);
            jpeg.savetofile(imgfile);
       end;
    end
    else if (GControl is TQRDBImage) then
    begin
      qrdbcont := GControl as TQRDBImage;
      // proportional sizing
      drawpict.assign( qrdbcont.field );
      AspectRatio := 1.0 * drawpict.Width / drawpict.height;
      if not qrdbcont.stretch then
      begin
         if (drawpict.Width/conwidth) < (drawpict.Height/conHeight) then
               conHeight := trunc( conwidth / aspectratio )
         else
              conwidth := trunc( conheight * aspectratio );
      end;
      tempmap.width := conwidth;
      tempmap.height := conheight;

      inc( FNextPicnum );
      imgfile := GControl.Name + format( '%-d', [FNextPicnum] ) + '.jpg';
      if trim(picturedir) <> '' then
            imgfile := IncludeTrailingPathDelimiter( HTMPictureDir ) + imgfile;
      if qrdbcont.field <> nil then
      begin
            tempmap.assign( qrdbcont.field );
            jpeg.Assign(tempmap);
      end;
      jpeg.savetofile( imgfile );// blank pic for nil field
    end
    else if (GControl is TQRGrDBImage) then
    begin
      dbcont := GControl as TQRGrDBImage;
      // proportional sizing
      drawpict.assign( dbcont.field );
      AspectRatio := 1.0 * drawpict.Width / drawpict.height;
      if not dbcont.stretch then
      begin
       if dbcont.FitMode=fmProportional then
       begin
         if (drawpict.Width/conwidth) < (drawpict.Height/conHeight) then
               conHeight := trunc( conwidth / aspectratio )
         else
              conwidth := trunc( conheight * aspectratio );
       end
       else if dbcont.FitMode=fmKeepWidth then
               conHeight := trunc( conwidth / aspectratio )
       else if dbcont.FitMode=fmKeepHeight then
                conwidth := trunc( conheight * aspectratio );
      end;
      tempmap.width := conwidth;
      tempmap.height := conheight;

      inc( FNextPicnum );
      imgfile := GControl.Name + format( '%-d', [FNextPicnum] ) + '.jpg';
      if trim(picturedir) <> '' then
            imgfile := IncludeTrailingPathDelimiter( HTMPictureDir ) + imgfile;
      if (GControl as TQRGrDBImage).field <> nil then
      begin
            tempmap.assign( (GControl as TQRGrDBImage).field );
            jpeg.Assign(tempmap);
      end;
      jpeg.savetofile( imgfile );// blank pic for nil field
    end;
    FText := imgfile;
    XPos := GDest.left;
    YPos := GDest.top;
    XDim := conwidth;
    YDim := conheight;
    if (YPos+ydim) > FPageMaxY then FPageMaxY := (YPos+ydim);
    // graphic link : units pixels
    divstr := '<DIV style="position:absolute;left:'+
                       format( '%-d', [xpos]) +'px;top:'+
                       format( '%-d', [ypos]) +'px;">'+
                       '<img src="'+FText+'" width=' +
                       format( '%-d', [xdim])+' height=' +
                       format( '%-d', [ydim])+'></div>';
    writeToStream( divstr + chr($0D)+chr($0A));
  finally
    tempmap.free;
    drawpict.free;
    jpeg.free;
  end;
end;


end.

