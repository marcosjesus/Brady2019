unit QRXDocument;
{****************************************************************

  TQRXDocument

 (c) 2006/7 QBS Software

 Created : 15/10/2004
 18-01-05 fixed print bugs DLM     

*****************************************************************}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, OleServer, MSXML_TLB, StdCtrls, ExtCtrls, printers, quickrpt, qrprntr;

const
  IT_TEXT = 1;
  IT_NEWPAGE = 2;
  IT_GRAPHIC = 3;
  IT_IMAGE = 4;
  // shapes
  S_BOX = 0;
  S_CIRCLE = 1;
  S_HLINE = 2;
  S_VLINE = 3;
  S_OBLIQUE = 4;
  S_TOPBOTTOM = 5;
  S_LEFTRIGHT = 6;
  S_ROUNDRECT = 7;
  // ascii
  ORD0 = ord('0');
  ORDA = ord('A');
  mmToPoints = 72.0 / 25.4;
type
  TMouseEvent = procedure( controlName, controlText : string; recNum : integer ) of object;
  TButtonEvent = procedure( sender : TObject ) of object;
  //TQRXZoomType = ( zsOther, zsToWidth, zsToHeight, zs100 );
  TQRXBrowserState = ( bsReady, bsBusy );
   THTMLMode = ( hmSinglePage, hmMultipage );

   TPageItem = class(TObject)
       public
         xpos, ypos, width, height, DBRecord : integer;
         controlID, cText : string;
         constructor Create;
   end;
   THintItem = class(TObject)
       public
         controlID, hint : string;
         constructor Create;
   end;

   TQRXDocument = class(TComponent)
   private
       FDomDocument : TDomDocument;
       FCurrentQR : TCustomQuickrep;
       FDocumentFile : string;
       FCurrentPage : integer;
       FPagewidth : double; // mm page width
       FPageheight : double; // mm page height
       FPagecount : integer;
       PageHasChanged : boolean;
       FShowImagesInThumbs : boolean;
       FImageControl : TImage;
       FPageItems : TStringlist;
       FPageBands : TStringlist;
       FZoomfactor : extended;
       FStream : TStream;
       FNextImage : integer;
       FImagepath : string;
       FDocumentLoaded : boolean;
       FTitle : string;
       FPapername : string;
       FCompressImages : boolean;
       FUseImageURL : boolean;
       FShowprogress : boolean;
       FHTMLImageURL : string;
       FOnClick : TMouseevent;
       FOnBandClick : TMouseevent;
       FOnMouseover : TMouseevent;
       FOnMouseOut : TMouseevent;
       FOnPrintClicked : TButtonevent;
       FOnPrintSetupClicked : TButtonevent;
       FOnSaveClicked : TButtonevent;
       FOnLoadClicked : TButtonevent;
       FShowthumbs : boolean;
       FShowSearch : boolean;
       FShowToolbar : boolean;
       FShowPrintButtons : boolean;
       FShowSave : boolean;
       FShowLoad : boolean;
       FInitwidth : integer;
       FInitHeight : integer;
       FInitTop : integer;
       FInitLeft : integer;
       FInitZoom : extended;
       FInitZoomState : TQRZoomState;
       FInitWindowState : TWindowstate;
       FHintlist : TStringlist;
       FTextindex : TStringlist;
       FSearchText : string;
       FOrientation : integer; // 0=P, 1=Land
       FPrinterOffsetX : extended;
       FPrinterOffsetY : extended;
       FPixelsPerX : extended;
       FPixelsPerY : extended;
       procedure SetDocumentFile( filename : string);
       procedure SetCurrentPage( value : integer);
       procedure RegisterBand( dnode : IXMLDOMNode; acanvas : TCanvas);
       procedure RenderText( dnode : IXMLDOMNode; acanvas : TCanvas);
       procedure RenderGraphic( dnode : IXMLDOMNode; acanvas : TCanvas);
       procedure RenderImage( dnode : IXMLDOMNode; acanvas : TCanvas);
       procedure DummyImage( dnode : IXMLDOMNode; acanvas : TCanvas);
       procedure RenderOnePage( pagenum : integer; aDomDocument : TDomDocument; fpagewidth, fpageheight : integer; ToPrinter : boolean );
       function GetPageCount: integer;
       procedure ReadQXDDocument( aDomDocument : TDomDocument );
       procedure WriteToStream( tx : string);
       procedure HTMLGraphic( dnode : IXMLDOMNode; pagenum : integer );
       procedure HTMLImage( dnode : IXMLDOMNode; pagenum : integer );
       procedure HTMLText( dnode : IXMLDOMNode; pagenum : integer );
       procedure HTMLOnePage( pagenum : integer; aDomDocument : TDomDocument );
       procedure LoadQXDString( instring : string; aDomDocument : TDomDocument );
       procedure LoadQXDFile( filename : string; aDomDocument : TDomDocument );
       procedure GetAttributes( dnode : IXMLDOMNode; var x : double; var y : double; var iwidth : double;
                         var iheight : double; var layer : integer; var fcolor : TColor );
       procedure ViewReportInt( QReport : TCustomquickrep; modal : boolean);
    public
       firstPage, lastPage : integer;
       HTMLExportMode : THTMLMode;
       CurrentFile, HTMLImageURL : string;
       constructor Create(AOwner: TComponent); override;
       destructor Destroy; override;
       procedure RenderPage( pagenum : integer );
       procedure MakeTextIndex;
       procedure FindText( cText : string; matchCase : boolean; resList : TStrings );
       procedure SaveReportAsXML( QReport : TCustomquickrep; fileName : string );
       procedure ViewReport( QReport : TCustomquickrep );
       procedure ViewReportModal( QReport : TCustomquickrep );
       procedure RenderPageToBM( pagemap : TBitmap;pagenum : integer);
       //procedure LoadDocFromFile( filename : string );
       //procedure LoadDocFromStream( qxdstream : TStream );
       procedure SetImageControl( iCont : TImage);
       procedure SetZoomFactor( value : extended);
       function GetControlFromPosition( x, y : integer; var cText : string; var DBRecordNum : integer) : string;
       function GetBandFromPosition( x, y : integer; var cText : string; var DBRecordNum : integer) : string;
       procedure ViewDocument( modal : boolean);
       procedure LoadAndViewXML( filename : string; inStream : TStream ; modal : boolean);
       procedure LoadFromFile( filename : string );
       procedure LoadFromStream( instream : TStream );
       procedure AddPage( pagenode : IXMLDOMNode );
       procedure SaveToFile( filename : string );
       procedure SaveToStream( outstr : TStream );
       procedure InitialiseDoc( title : string; pagewidth, pageheight : double;
                                          papername, orient, stylesheetURI: string );
       procedure SaveAsPDFFile( pdffile : string );
       procedure SaveAsHTMLStream( htmstream : TStream );
       procedure SaveAsHTMLFile( htmfile : string );
       procedure SaveAsPDFStream( pdfstream : TStream );
       procedure Print( aprinter : TPrinter );
       procedure ReplaceToken( token, replacement : string );
       Procedure ReNumberpages( pagetoken, counttoken : string);
       procedure FireEvent(  eventNum : TPrevEventType; cName, CText : string; rec : integer );
       procedure ZoomToWidth( reqWidth : extended );
       procedure ZoomToHeight( reqHeight : extended );
       function RenderOneThumb( pagenum : integer; aDomDocument : TDomDocument;
                                   fpagewidth, fpageheight : integer; thRect : TRect ) : TBitmap;
       function RenderThumbnail( pagenum : integer; thumbRect : TRect ) : TBitmap;
       procedure AddHint( controlName, hintText : string );
       function GetHint( cName : string ) : string;
       function GetZoom : extended;
       procedure SetSearchText( value : string );
       function GetPage( Pagenum : integer) : IXMLDOMNode;
       procedure ShowConnectionDlg;
  published
       property ShowImagesInThumbs : boolean read FShowImagesInThumbs write FShowImagesInThumbs;
       property ShowSaveButton : boolean read FShowSave write FShowSave;
       property ShowLoadButton : boolean read FShowLoad write FShowLoad;
       property ShowPrintButtons : boolean read FShowPrintButtons write FShowPrintButtons;
       property ShowToolbar : boolean read FShowToolbar write FShowToolbar;
       property Showthumbs : boolean read FShowthumbs write FShowthumbs;
       property ShowSearch : boolean read FShowSearch write FShowSearch;
       property DocumentLoaded : boolean read FDocumentLoaded;
       property InitViewerWidth : integer read FInitwidth write FInitwidth;
       property InitViewerHeight : integer read FInitHeight write FInitHeight;
       property InitViewerTop : integer read FInitTop write FInitTop;
       property InitViewerLeft : integer read FInitLeft write FInitLeft;
       property InitViewerZoom : extended read FInitZoom write FInitZoom;
       property InitViewerZoomState : TQRZoomState read FInitZoomState write FInitZoomState;
       property InitViewerState : TWindowstate read FInitWindowState write FInitWindowState;
       property ShowProgress : boolean read FShowProgress write FShowProgress;
       property ZoomFactor : extended read FZoomFactor write SetZoomFactor;
       property DocumentFile : string read FDocumentFile write SetDocumentFile;
       property ReportTitle : string read FTitle write FTitle;
       property CurrentPage : integer read FCurrentPage write SetCurrentPage;
       property Pagecount : integer read GetPagecount;
       property Pagewidth : double read FPagewidth;
       property Pageheight : double read FPageheight;
       property OnClick : TMouseEvent read FOnClick write FOnClick;
       property OnBandClick : TMouseEvent read FOnBandClick write FOnBandClick;
       property OnMouseOver : TMouseEvent read FOnMouseOver write FOnMouseOver;
       property OnMouseOut : TMouseEvent read FOnMouseOut write FOnMouseOut;
       property OnPrintClicked : TButtonevent read FOnPrintClicked write FOnPrintClicked;
       property OnPrintSetupClicked : TButtonevent read FOnPrintSetupClicked write FOnPrintSetupClicked;
       property OnSaveClicked : TButtonevent read FOnSaveClicked write FOnSaveClicked;
       property OnLoadClicked : TButtonevent read FOnLoadClicked write FOnLoadClicked;
       //property Enabled;
  end;

var
    mmToPix : double;
  procedure UnRLE(Source, Target: TStream);
  procedure BinToAsciiHex(Source, Dest: TStream);
  function MakeZTS( src : string ): pchar;

implementation
uses OleCtrls, jpeg, QRXMLSFilt, QRXBrowser, lzw;
var
    FStandPrev : TQRXStandardViewer;

{TPageItem}
constructor TPageItem.Create;
begin
    inherited Create;
end;

{THintItem}
constructor THintItem.Create;
begin
    inherited Create;
end;

{ TQRXDocument}
constructor TQRXDocument.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
    //ControlStyle := ControlStyle + [csReplicatable];
    //Width := 32;
    //Height := 32;
    FCurrentPage := 0;
    FZoomfactor := 100.0;
    FDocumentloaded := false;
    FDomDocument := TDomDocument.Create( self );
    mmToPix := 96.0 / 25.4;
    FPageItems := TStringlist.Create;
    FPageBands := TStringlist.Create;
    FHintlist := TStringlist.Create;
    FTextindex := TStringlist.Create;
    FSearchtext := '';
    mmToPix := 96.0 / 25.4;
    //visible := false;
    FShowthumbs := false;
    FShowSearch := false;
    FInitwidth := 700;
    FInitHeight := 650;
    FInitTop := 50;
    FInitLeft := 50;
    FInitZoom := 100.0;
    FInitWindowState := wsNormal;
    FShowtoolbar := true;
    FShowprintbuttons := true;
    FShowSave := true;
    FShowload := true;
    FShowImagesInThumbs := true;
    InitViewerZoomState := qrZoomOther;
end;

destructor TQRXDocument.Destroy;
begin
    FDomdocument.free;
    FPageItems.Free;
    FPageBands.Free;
    FHintlist.Free;
    FTextindex.free;
    inherited Destroy;
end;

procedure TQRXDocument.FindText( cText : string; matchCase : boolean; resList : TStrings );
var
    k : integer;
    pItem : TPageItem;
begin
      for k := 0 to FTextindex.count-1 do
      begin
          pItem := TPageItem( FTextindex.objects[k]);
          if matchCase then
          begin
             if pos( cText, pItem.cText) > 0 then
             begin
                 resList.AddObject( pItem.cText, FTextindex.objects[k]);
             end;
          end
          else
          begin
             if pos( lowercase(cText), lowercase(pItem.cText)) > 0 then
             begin
                 resList.AddObject( pItem.cText, FTextindex.objects[k]);
             end;
          end
      end;
end;

procedure TQRXDocument.SetSearchText( value : string );
begin
    FSearchtext := value;
end;

function TQRXDocument.GetZoom : extended;
begin
     result := FZoomfactor;
end;

procedure TQRXDocument.ViewReportModal( QReport : TCustomquickrep );
begin
     ViewReportInt( QReport, true);
end;

procedure TQRXDocument.ViewReport( QReport : TCustomquickrep );
begin
     ViewReportInt( QReport, false);
end;

procedure TQRXDocument.ViewReportInt( QReport : TCustomquickrep ; modal : boolean);
var
    aXML : TQRXDocumentFilter;
    tmplist : TStringlist;
begin
    tmplist := TStringlist.Create;
    FCurrentQR := QReport;
    FStandPrev := TQRXStandardViewer.Create( nil );
    FSearchText := '';
    FImageControl := FStandPrev.Image1;
    aXML := TQRXDocumentFilter.Create( '');
    aXML.CompressImages := true;
    try
       qreport.ShowProgress := FShowprogress;
       QReport.ExportToFilter( aXML );
       // ====================== debug =================
       //aXml.Stream.Position := 0;
       //tmplist.LoadFromStream( aXML.Stream);
       //tmplist.SaveToFile('document.xml');
       //exit;
       // ====================== debug =================

       aXml.Stream.Position := 0;
       LoadFromStream( aXML.stream);
       if not FDocumentLoaded then exit;
       FStandPrev.SetDocument( self );
       RenderPage(FCurrentPage);
       if modal then
          FStandPrev.showModal
       else
          FStandPrev.show;
    finally
      aXML.free;
      tmplist.free;
    end;
end;

procedure TQRXDocument.ShowConnectionDlg;
begin
end;


procedure TQRXDocument.SaveReportAsXML( QReport : TCustomquickrep; fileName : string );
var
    aXML : TQRXDocumentFilter;
begin
    aXML := TQRXDocumentFilter.Create( '');
    aXML.CompressImages := true;
    try
       qreport.ShowProgress := FShowprogress;
       QReport.ExportToFilter( aXML );
       LoadFromStream( aXML.stream);
       if not FDocumentLoaded then exit;
       self.SaveToFile( fileName );
    finally
      aXML.free;
    end;
end;

// a document is already loaded so view it.
procedure TQRXDocument.ViewDocument( modal : boolean);
begin
       if not FDocumentLoaded then exit;
       FStandPrev := TQRXStandardViewer.Create( nil );
       FImageControl := FStandPrev.Image1;
       FStandPrev.SetDocument( self );
       RenderPage(FCurrentPage);
       if modal then
          FStandPrev.showModal
       else
          FStandPrev.show;
end;

procedure TQRXDocument.LoadAndViewXML( filename : string; inStream : TStream ; modal : boolean);
var
    aXML : TQRXDocumentFilter;
begin
    FStandPrev := TQRXStandardViewer.Create( nil );
    //FStandPrev.SetDocument( self );
    FSearchText := '';
    FImageControl := FStandPrev.Image1;
    aXML := TQRXDocumentFilter.Create( '');
    aXML.CompressImages := false;
    try
       if inStream <> nil then
              LoadFromStream( inStream)
       else if FileExists( fileName) then
              LoadFromFile( fileName)
       else
           exit;
       if not FDocumentLoaded then exit;
       FStandPrev.SetDocument( self );
       RenderPage(FCurrentPage);
       if modal then
          FStandPrev.showModal
       else
          FStandPrev.show;
    finally
      aXML.free;
    end;
end;

function TQRXDocument.GetHint( cName : string ) : string;
var
   k : integer;
begin
     k := FHintlist.IndexOf( cName );
     if k < 0 then
        result := ''
     else
        result := THintitem( FHintlist.objects[k]).hint;
end;

procedure TQRXDocument.AddHint( controlName, hintText : string );
var
   aHint : THintitem;
begin
     aHint := THintitem.Create;
     aHint.controlID := controlName;
     aHint.hint := hintText;
     FHintList.AddObject( controlName, aHint);
end;

procedure TQRXDocument.FireEvent( eventNum : TPrevEventType; cName, CText : string; rec : integer );
begin
     if assigned( FCurrentQR.OnPrevxEvent) then
            FCurrentQR.OnPrevxEvent( self, eventNum, cname, ctext, rec);
end;

procedure TQRXDocument.ZoomToWidth( reqWidth : extended );
begin
    Zoomfactor := 100.0 * reqWidth / (FPagewidth*mmToPix);
end;

procedure TQRXDocument.ZoomToHeight( reqHeight : extended );
begin
    Zoomfactor := 100.0 * reqHeight / (FPageheight*mmToPix);
end;

procedure TQRXDocument.InitialiseDoc( title : string; pagewidth, pageheight : double; papername, orient, stylesheetURI: string );
var
   XMLFilt : TQRXDocumentFilter;
   doclist : TStringlist;
begin
     doclist := TStringlist.create;
     XMLFilt := TQRXDocumentFilter.Create( '');
     XMLFilt.XLStyleURL := stylesheetURI;
     xmlfilt.Title := title;
     XMLFilt.NewDocument( doclist, pagewidth, pageheight, papername, orient );
     //doclist.SaveToFile( '_inittext.qrx');
     LoadQXDString( doclist.text, FDomDocument );
     //LoadQXDFile( '_inittext.qrx', domdoc );
     XMLFilt.free;
     doclist.free;
     FDocumentLoaded := true;
     //DeleteFile( '_inittext.qrx' );
end;

procedure TQRXDocument.SetZoomFactor( value : extended);
begin
     FZoomfactor := value;
     RenderPage( FCurrentpage);
end;

function TQRXDocument.GetPageCount : integer;
var
   pagelist : IXMLDOMNodeList;
begin
      pagelist := FDomDocument.getElementsByTagName( 'Page');
      if pagelist <> nil then
          result := pagelist.Get_length
      else
          result := 0;
end;

function TQRXDocument.GetPage( Pagenum : integer) : IXMLDOMNode;
var
   pagelist : IXMLDOMNodeList;
begin
      result := nil;
      pagelist := FDomDocument.getElementsByTagName( 'Page');
      if pagelist <> nil then
      begin
          FPagecount := pagelist.Get_length;
          if (pagenum >=0) and (pagenum < FPagecount) then
               result := pagelist[pagenum];
      end;
end;

procedure TQRXDocument.LoadFromFile( filename : string );
begin
     LoadQXDFile( filename, FDomDocument );
     if FDocumentLoaded then
     begin
        CurrentFile := filename;
     end
     else
        CurrentFile := '';
end;
procedure TQRXDocument.LoadFromStream( instream : TStream );
var
    doctext : TStringlist;
begin
     doctext := TStringlist.Create;
     instream.seek( 0, 0 );
     doctext.LoadFromStream( instream);
     LoadQXDString( doctext.Text, FDomDocument );
end;

procedure TQRXDocument.AddPage( pagenode : IXMLDOMNode );
var
    newpage : IXMLDOMNode;
begin
    newpage := pagenode.cloneNode( true );
    FDomDocument.documentElement.appendChild( newpage );
    inc(FPagecount);
end;

procedure TQRXDocument.SaveToFile( filename : string );
begin
     if FDocumentLoaded then
           FDomDocument.save( filename );
end;

procedure TQRXDocument.SaveToStream( outstr : TStream );
var
     doctext : TStringlist;
     pcstr : widestring;
begin
     if FDocumentLoaded then
     begin
        doctext := TStringlist.Create;
        pcstr := FDomDocument.documentElement.Get_xml;
        doctext.text := pcstr;
        doctext.SaveToStream( outstr);
        doctext.free;
     end;
end;

procedure TQRXDocument.SaveAsPDFFile( pdffile : string );
var
  ofile : TFilestream;
begin
     ofile := TFilestream.Create( pdffile, fmCreate );
     SaveAsPDFStream( ofile );
      if assigned(ofile ) then ofile.free;
end;

procedure TQRXDocument.Print( aprinter : TPrinter );
var
   numpages, i : integer;
begin
      if not FDocumentLoaded then exit;
      FPixelsPerX := GetDeviceCaps(aprinter.Handle, LOGPIXELSX);
      FPixelsPerY := GetDeviceCaps(aprinter.Handle, LOGPIXELSY);
      FPrinterOffsetX := 25.4*GetDeviceCaps(aprinter.Handle, PHYSICALOFFSETX)/FPixelsPerX;
      FPrinterOffsetY := 25.4*GetDeviceCaps(aprinter.Handle, PHYSICALOFFSETY)/FPixelsPerY;
      FPrinterOffsetY := 0;
      if FOrientation = 0 then
          aPrinter.Orientation := poPortrait
      else
          aPrinter.Orientation := poLandscape;
      FZoomFactor := 100.0;
      aPrinter.BeginDoc;
      numpages := GetPagecount;
      for i := 0 to numpages-1 do
      begin
         RenderOnePage( i , FDomDocument, round(Fpagewidth), round(Fpageheight), true);
         if i < (numPages-1) then aPrinter.NewPage;
      end;
      aPrinter.EndDoc;
end;

procedure TQRXDocument.SaveAsPDFStream( pdfstream : TStream );
begin
end;

procedure TQRXDocument.SaveAsHTMLStream( htmstream : TStream );
var
    i, numpages : integer;
    outbuff : pchar;
    procedure WriteToStream( tx : string );
    begin
         outbuff := MakeZTS( tx );
         htmstream.Write( outbuff[0] , length(tx));
         strdispose(outbuff);
    end;
    procedure NewPage;
    begin
      writetostream( '<html>' +chr($0D) + chr($0A) );
      writetostream( '<head>' +chr($0D) + chr($0A) );
      writetostream( ' <title>'+FTitle+'</title>' +chr($0D) + chr($0A) );
      writetostream( '</head>' +chr($0D) + chr($0A)  );
      writetostream( '<body >' +chr($0D) + chr($0A) );
    end;
    procedure EndPage;
    begin
      writetostream( '</body >' +chr($0D) + chr($0A) );
      writetostream( '</html>' +chr($0D) + chr($0A) );
    end;

begin
      numpages := GetPagecount;
      FNextimage := 0;
      FImagepath := '.';
      FStream := htmstream;
      NewPage;
      for i := 0 to numpages-1 do
      begin
           HTMLOnePage( i, FDomDocument);
      end;
      EndPage;
end;

procedure TQRXDocument.SaveAsHTMLFile( htmfile : string );
var
    ostream : TFilestream;
begin
    ostream := TFilestream.Create( htmfile, fmCreate );
    SaveAsHTMLStream( ostream);
    if assigned(ostream) then
         ostream.free;
end;

procedure TQRXDocument.ReplaceToken( token, replacement : string );
var
     pcstr, dtdstring : widestring;
     DTDtext : TStringlist;
     XMLFilt : TQRXDocumentFilter;
begin
   XMLFilt := TQRXDocumentFilter.Create('');
   DTDtext := TStringlist.Create;
   try
     // always have a DTD - and the only true one is in QRXDocument
     XMLFilt.LoadDTD( DTDtext );
     dtdstring := DTDtext.Text;
     pcstr := FDomDocument.documentElement.Get_xml;
     pcstr := StringReplace( pcstr, token, replacement, [rfReplaceAll] );
     pcstr := dtdstring + pcstr;
     // reload ourself with the new text
     LoadQXDString( pcstr, FDomDocument);
   finally
     DTDtext.free;
     xmlfilt.free;
   end;
end;

procedure TQRXDocument.ReNumberpages( pagetoken, counttoken : string);
var
   XMLFilt : TQRXDocumentFilter;
   pagestr, tokenpos, strpointer : pchar;
   pagecount, i, pagesize, tokenoffset, pagestart : integer;
   doctext : TStringlist;
   pageoffsets : TStringlist;
   pagetag, endpagetag, newdocstring, tempstr : string;
   replace1, replace2 : string;
begin
      // use this to get the proper DTD
      doctext := TStringlist.Create;
      XMLFilt := TQRXDocumentFilter.Create('');
      pageoffsets := TStringlist.Create;
      try
        XMLFilt.LoadDTD( pageoffsets );
        newdocstring := pageoffsets.Text;
        pageoffsets.Clear;
        pagetag := '<Page';
        endpagetag := '</page>';
        doctext.text := FDomDocument.documentElement.Get_xml;
        pagestr := doctext.GetText;
        pagecount := GetPagecount;
        strpointer := pagestr;
        replace2 := format( '%d', [PageCount]);
        for i := 1 to PageCount do
        begin
           // find first pagetoken
           tokenpos := AnsiStrPos( strpointer, @pagetag[1]);
           if tokenpos <> nil then
           begin
                tokenoffset := tokenpos-pagestr;
                pageoffsets.add( format( '%d', [tokenoffset]));
                strpointer := tokenpos+length( pagetag);
           end
           else
              break;
        end;
        pageoffsets.add( format( '%d', [length(pagestr)]));
        //pageoffsets.SaveToFile( 'pageoffsets.txt');
        newdocstring := newdocstring + copy( pagestr, 1, strtoint(pageoffsets[0])-1);
        for i := 1 to PageCount do
        begin
             pagestart := strtoint(pageoffsets[i-1]);
             pagesize := strtoint(pageoffsets[i]) - pagestart;
             tempstr := copy( pagestr, pagestart, pagesize);
             replace1 := format( '%d', [i]);
             tempstr := stringreplace( tempstr, pagetoken, replace1, [rfReplaceAll]);
             tempstr := stringreplace( tempstr, counttoken, replace2, [rfReplaceAll]);
             newdocstring := newdocstring + tempstr;
        end;
        // reload myself
        LoadQXDString( newdocstring, FDomDocument);
      finally
         pageoffsets.free;
         doctext.free;
         Xmlfilt.free;
      end;
end;

function TQRXDocument.GetControlFromPosition( x, y : integer; var cText : string; var DBRecordNum : integer) : string;
var
   k : integer;
   pItem : TPageitem;
begin
   for k := FPageitems.Count-1 downto 0 do
   begin
       pItem := TPageitem( FPageitems.objects[k]);
       if ( x > pitem.xpos) and (x < ( pitem.xpos+pitem.width)) and
          ( y > pitem.ypos) and (y < ( pitem.ypos+pitem.height)) then
       begin
          result := pItem.controlID;
          cText := PItem.cText;
          DBRecordNum := pItem.DBRecord;
          exit;
       end;
   end;
   result := '';
end;

function TQRXDocument.GetBandFromPosition( x, y : integer; var cText : string; var DBRecordNum : integer) : string;
var
   k : integer;
   pItem : TPageitem;
begin
   for k := FPagebands.Count-1 downto 0 do
   begin
       pItem := TPageitem( FPagebands.objects[k]);
       if ( x > pitem.xpos) and (x < ( pitem.xpos+pitem.width)) and
          ( y > (pitem.ypos-pitem.height)) and (y < pitem.ypos) then
       begin
          result := pItem.controlID;
          cText := 'band';
          DBRecordNum := pItem.DBRecord;
          exit;
       end;
   end;
   result := '';
end;

{$ifdef ISGRAPHIC}
procedure TQRXDocument.Paint;
begin
  Canvas.Font := Font;
  Canvas.Brush.Color := Color;
  if not Documentloaded or (csDesigning in Componentstate) then
  begin
      Canvas.Pen.Style := psDash;
      Canvas.Brush.Style := bsClear;
      Canvas.Rectangle(0, 0, Width, Height);
  end
  else
  begin
       if PageHasChanged then
                 RenderPage( FCurrentPage );
       PageHasChanged := false;
  end;
end;
{$endif}

procedure TQRXDocument.SetImageControl( iCont : TImage);
begin
    FImageControl := iCont;
end;

procedure TQRXDocument.RenderPage( pagenum : integer );
var
     width, height : integer;
begin
      if not FDocumentLoaded then exit;
      if (pagenum < 0) or (pagenum >= FPagecount) then exit;
      mmToPix := 96.0 / 25.4; // after a print, mmToPix is wrong
      width := round(FPagewidth*mmToPix);
      height := round(FPageheight*mmToPix);
      RenderOnePage( pagenum, FDomDocument, width, height, false );
end;

function TQRXDocument.RenderThumbnail( pagenum : integer; thumbRect : TRect ) : TBitmap;
var
     width, height : integer;
begin
      result := nil;
      if not FDocumentLoaded then exit;
      if (pagenum < 0) or (pagenum >= FPagecount) then exit;
      width := round(FPagewidth*mmToPix);
      height := round(FPageheight*mmToPix);
      result := RenderOneThumb( pagenum, FDomDocument, width, height, thumbRect );
end;

procedure TQRXDocument.SetDocumentFile( filename : string);
begin
     if not ( csDesigning in componentstate ) then
     begin
           LoadFromFile( filename );
           if FDocumentloaded then
           begin
               RenderPage(FCurrentPage);
           end;
     end;
     FDocumentfile := filename;
end;

procedure TQRXDocument.SetCurrentPage( value : integer);
begin
      if (FCurrentPage <> value) and not (csDesigning in ComponentState) then
      begin
         PageHasChanged := true;
         RenderPage( value);
      end;
      FCurrentPage := value;
end;

function  HexStrToInt( hstr : string ) : TColor;
var
    cstr : string;
    sl, i, doubler : integer;
    res : longint;
    cc : char;
begin
   result := clWhite;
   if length( hstr ) < 6 then exit;
  try
     doubler := 1;
     sl := length( hstr );
     cstr := copy( hstr, sl-6+1, 6 );
     cstr := lowercase( cstr);
     cstr := copy( cstr,5, 2) + copy( cstr, 3, 2 ) + copy( cstr, 1, 2 );
     res := 0;
     for i := 6 downto 1 do
     begin
         cc := cstr[i];
         if (cc<='9') and ( cc>='0') then
               res := res + (doubler*(ord( cc) - ord('0')))
         else
               res := res + (doubler*( 10 + ord( cc)- ord('a') ));
         doubler := doubler * 16;
     end;
     result:= TColor( res );
  except
    result := clWhite;
  end;
end;

function  Hex8StrToInt( hstr : string ) : TColor;
var
    cstr, ss : string;
    i, doubler : integer;
    res : longint;
    cc : char;
begin
     doubler := 1;
     cstr := lowercase( hstr);
     ss := copy(cstr, 5, 4) + copy( cstr, 1, 4 );
     cstr := copy(ss, 3, 2) + copy( ss, 1, 2 ) + copy(ss, 7, 2) + copy( ss, 5, 2 );
     res := 0;
     for i := 8 downto 1 do
     begin
         cc := cstr[i];
         if (cc<='9') and ( cc>='0') then
               res := res + (doubler*(ord( cc) - ord('0')))
         else
               res := res + (doubler*( 10 + ord( cc)- ord('a') ));
         doubler := doubler * 16;
     end;
     result:= TColor( res );
end;

procedure TQRXDocument.GetAttributes( dnode : IXMLDOMNode; var x : double; var y : double; var iwidth : double;
                         var iheight : double; var layer : integer; var fcolor : TColor );
var
   anode : IXMLDOMNode;
begin
   x := 0.0;
   y := 0.0;
   iwidth := 0.0;
   iheight := 0.0;
   layer := 0;
   fcolor := clWhite;
   try
     anode := dnode.attributes.getNamedItem( 'X');
     if anode <> nil then
        x := strtofloat(anode.nodeValue);
     x := x + FPrinterOffsetX;
     x := x * FZoomfactor/ 100.0;
     anode := dnode.attributes.getNamedItem( 'Y');
     if anode <> nil then
         y := strtofloat(anode.nodeValue);
     y := y + FPrinterOffsetY;
     y := y * FZoomfactor/ 100.0;
     anode := dnode.attributes.getNamedItem( 'Width');
     if anode <> nil then
         iwidth := strtofloat(anode.nodeValue);
     iwidth := iwidth * FZoomfactor/ 100.0;
     anode := dnode.attributes.getNamedItem( 'Height');
     if anode <> nil then
         iheight := strtofloat(anode.nodeValue);
     iheight := iheight * FZoomfactor/ 100.0;
     anode := dnode.attributes.getNamedItem( 'LY');
     if anode <> nil then
         layer := strtoint(anode.nodeValue);
     anode := dnode.attributes.getNamedItem( 'Color');
     if anode <> nil then
         fcolor := HexStrToInt(anode.nodeValue);
   except

   end;
end;

procedure TQRXDocument.RenderText( dnode : IXMLDOMNode; acanvas : TCanvas);
var
   anode, recnode : IXMLDOMNode;
   layer, rec : integer;
   tstr : string;
   xpos, ypos, fheight, fwidth : double;
   fname : string;
   bold, italic : boolean;
   fcolor : TColor;
   pitem : TPageitem;
begin
// <Item Type="Text" XPos="10.0" YPos="10.6"  Font="Times New Roman" FW="Bold"
// Decoration="None"  Height="15.75" Color="6FC00000" Layer="0" >NW Employees</Item>

   try
     GetAttributes(dnode, xpos, ypos, fwidth, fheight, layer, fcolor );
     anode := dnode.attributes.getNamedItem( 'Font');
     fname := anode.nodeValue;
     anode := dnode.attributes.getNamedItem( 'FW');
     bold := lowercase(anode.nodeValue) = 'bold';

     anode := dnode.attributes.getNamedItem( 'Dec');
     italic := lowercase(anode.nodeValue) = 'italic';

     tstr := dnode.Get_text;
     aCanvas.Font.Name := fname;
     aCanvas.Font.Size := round(fheight);
     aCanvas.Font.Color:= fcolor;
     aCanvas.Font.Style := [];
     if bold and italic then
          aCanvas.Font.Style := [fsBold, fsItalic]
     else if italic then
          aCanvas.Font.Style :=[fsItalic]
     else if bold then
          aCanvas.Font.Style := [fsBold];
     if pos( lowerCase(FSearchtext), lowercase(tstr )) > 0 then
     begin
         aCanvas.pen.Color := clRed;
         aCanvas.pen.Style := psSolid;
         aCanvas.brush.Style := bsClear;
         fwidth := aCanvas.TextWidth( tstr );
         fheight := aCanvas.TextHeight( 'M');
         aCanvas.Rectangle( round( xpos*mmtopix), round( ypos*mmtopix),
                   round( xpos*mmtopix)+ round(fwidth), round( ypos*mmtopix)+round(fheight));
     end;
     SetBkMode( acanvas.handle, TRANSPARENT );
     aCanvas.TextOut( round( xpos*mmtopix), round( ypos*mmtopix), tstr);
     PItem := Tpageitem.Create;
     anode := dnode.attributes.getNamedItem( 'CID');
     if anode <> nil then
     begin
        PItem.controlID := anode.nodeValue;
        PItem.xpos := round( xpos*mmtopix);
        PItem.ypos := round( ypos*mmtopix);
        PItem.width := aCanvas.TextWidth( tstr);
        PItem.height := aCanvas.TextHeight( 'M' );
        PItem.cText := tstr;
        recnode := dnode.attributes.getNamedItem( 'DBR');
        if recnode <> nil then
        begin
             val( recnode.nodeValue, rec, layer);
             pItem.DBRecord := rec;
        end;
        fpageItems.addobject( anode.nodeValue, pitem);
     end;
   except

   end;

end;

procedure TQRXDocument.RegisterBand( dnode : IXMLDOMNode; acanvas : TCanvas);
var
   anode, recnode : IXMLDOMNode;
   layer, rec : integer;
   //tstr : string;
   xpos, ypos, fheight, fwidth : double;
   //fname : string;
   fcolor : TColor;
   pitem : TPageitem;
begin
   try
     GetAttributes(dnode, xpos, ypos, fwidth, fheight, layer, fcolor );
     PItem := Tpageitem.Create;
     anode := dnode.attributes.getNamedItem( 'CID');
     if anode <> nil then
     begin
        PItem.controlID := anode.nodeValue;
        PItem.xpos := round(mmToPix*xpos/10.0);
        PItem.ypos := round(mmToPix*ypos/10.0);
        PItem.width := round(fwidth);
        PItem.height := round(fheight);
        PItem.cText := 'band';
        recnode := dnode.attributes.getNamedItem( 'DBR');
        if recnode <> nil then
        begin
             val( recnode.nodeValue, rec, layer);
             pItem.DBRecord := rec;
        end;
        FPageBands.addobject( anode.nodeValue, pitem);
     end;
   except

   end;

end;

//<Item Type="Graphic" Layer="1" XPos="48.15" YPos="19.71" Linewidth="0.79" Shape="2" Width="152.66" Height="2.38" Color="#C0C0C0" BC="#FFFFFF" FT="Out" >Graphic item</Item>
//<Item Type="Graphic" Layer="2" XPos="10.00" YPos="10.00" Linewidth="1.00" Shape="0" Width="189.97" Height="15.23" Color="#0000FF" BC="#0000FF" FT="Fill" >
//Graphic item</Item>
procedure TQRXDocument.RenderGraphic( dnode : IXMLDOMNode; acanvas : TCanvas);
var
   anode : IXMLDOMNode;
   layer, shape : integer;
   xpos, ypos, fheight, fwidth, linewidth : double;
   fcolor, bcolor : TColor;
   fill : boolean;
begin
   try
     GetAttributes(dnode, xpos, ypos, fwidth, fheight, layer, fcolor );
     anode := dnode.attributes.getNamedItem( 'Font');
     anode := dnode.attributes.getNamedItem( 'BC');
     bcolor := HexStrToInt(anode.nodeValue);
     anode := dnode.attributes.getNamedItem( 'FT');
     fill :=  lowercase(anode.nodeValue)='fill';
     anode := dnode.attributes.getNamedItem( 'LW');
     linewidth := strtofloat(anode.nodeValue);
     lineWidth := lineWidth * mmToPix * FZoomfactor / 100.0;
     if lineWidth < 1.0 then LineWidth := 1.0;
     anode := dnode.attributes.getNamedItem( 'SP');
     shape := strtoint(anode.nodeValue);
     aCanvas.Pen.Color := fcolor;
     acanvas.brush.Color := bcolor;
     acanvas.Pen.style := psSolid;
     acanvas.Pen.width := round(linewidth);
     acanvas.brush.Style := bsSolid;
     case shape of
       0, 1 : // rect or circle
       begin
           if fill then
              acanvas.Pen.style := psClear
           else
              acanvas.brush.Style := bsClear;
           if shape=0 then
               acanvas.Rectangle( round(xpos*mmToPix), round(ypos*mmToPix),
                         round((xpos+fwidth)*mmToPix), round((fheight+ypos)*mmToPix))
           else
               acanvas.Ellipse( round(xpos*mmToPix), round(ypos*mmToPix),
                         round((xpos+fwidth)*mmToPix), round((fheight+ypos)*mmToPix));
       end ;
       2 :  // hline
        begin
           acanvas.moveto( round(xpos*mmToPix), round(ypos*mmToPix));
           acanvas.lineto( round((xpos+fwidth)*mmToPix), round(ypos*mmToPix));
       end;
       3 :  // vline
       begin
           acanvas.moveto( round(xpos*mmToPix), round(ypos*mmToPix));
           acanvas.lineto( round(xpos*mmToPix), round((fheight+ypos)*mmToPix));
       end;

       7 :  // left diagline /
       begin
           acanvas.moveto( round((xpos+fwidth)*mmToPix), round(ypos*mmToPix));
           acanvas.lineto( round(xpos*mmToPix), round((fheight+ypos)*mmToPix));
       end;

       8 :  // right diagline  \
       begin
           acanvas.moveto( round(xpos*mmToPix), round(ypos*mmToPix));
           acanvas.lineto( round((xpos+fwidth)*mmToPix), round((fheight+ypos)*mmToPix));
       end;

       else ;

     end;
{$ifdef TAGGRAP}
     PItem := TPageitem.Create;
     anode := dnode.attributes.getNamedItem( 'CID');
     PItem.controlID := anode.nodeValue;
     PItem.xpos := round( xpos*mmtopix);
     PItem.ypos := round( ypos*mmtopix);
     PItem.width := round( fwidth*mmtopix);
     PItem.height := round( fheight*mmtopix);
        recnode := dnode.attributes.getNamedItem( 'DBR');
     if recnode <> nil then
     begin
          val( recnode.nodeValue, xpos, layer);
          pItem.DBRecord := xpos;
     end;
     fpageItems.addobject( anode.nodeValue, pitem);
{$endif}
   except

   end;
end;

function IsHex( c : byte ) : boolean;
begin
    result := ((c <= ord('9')) and (c>=ord('0'))) or
              ((c <= ord('F')) and (c>=ord('A')))
end;

function HexToBin( c1, c2 : byte) : byte;
var
     cc : char;
     res : byte;
begin
     cc := chr( c1);
     if (cc<='9') and ( cc>='0') then
           res := (16*(ord( cc) - ord('0')))
     else
           res := (16*( 10 + ord( cc)- ord('A') ));
     cc := chr( c2);
     if (cc<='9') and ( cc>='0') then
           res := res + ((ord( cc) - ord('0')))
     else
           res := res + (( 10 + ord( cc)- ord('A') ));
     result := res;
end;

// data in a string -> to stream
procedure AsciiHexToBinary( instring : string; outstream : TStream);
var
     inchar1, inchar2, outb : byte;
     inbytes, spos : longint;
begin
     spos := 1;
     inbytes := length(instring);
     while spos <= inbytes do
     begin
         // read 2 hex bytes 'A8' -> binary 8 bit
         inchar1 := ord( instring[spos]);
         while (not IsHex( inchar1)) and (spos <= inbytes) do
         begin
            inc(spos);
            inchar1 := ord( instring[spos]);
         end;
         if spos > inbytes then break;
         inc(spos);
         inchar2 := ord( instring[spos]);
         while (not IsHex( inchar2)) and (spos <= inbytes) do
         begin
            inc(spos);
            inchar2 := ord( instring[spos]);
         end;
         outb := HexToBin( inchar1, inchar2 );
         outstream.Write( outb, 1 );
         inc(spos);
     end;
end;

procedure TQRXDocument.RenderImage( dnode : IXMLDOMNode; acanvas : TCanvas);
var
   anode, recnode : IXMLDOMNode;
   layer, bitmapres, canvasres, rec : integer;
   xpos, ypos, fheight, fwidth : double;
   fcolor : TColor;
   binstream, tempstream : TMemoryStream;
   imagemap : TBitmap;
   PItem : TPageitem;
begin
   imagemap := TBitmap.Create;
   binstream := TMemoryStream.Create;
   tempstream := TMemoryStream.Create;
   try
     try
        GetAttributes(dnode, xpos, ypos, fwidth, fheight, layer, fcolor );
        xpos := mmToPix*xpos;
        ypos := mmToPix*ypos;
        anode := dnode.attributes.getNamedItem( 'Cmp');
        if (lowercase(anode.get_text) = 'none') then
              AsciiHexToBinary( dnode.Get_text, binstream )
        else if lowercase(anode.get_text) = 'lzw' then
        begin
              AsciiHexToBinary( dnode.Get_text, tempstream );
              tempstream.position := 0;
              try
                 lzwDecode( tempstream, binstream );
              except

              end;
        end;
        try
          binstream.Seek( 0, 0 );
          imagemap.LoadFromStream(binstream);
        except
          exit;
        end;
        // ************ debug *******
        //imagemap.SaveToFile( 'imagemap.bmp');
        // ************ debug *******
        bitmapres := GetDeviceCaps( imagemap.canvas.handle, LOGPIXELSX );
        canvasres := GetDeviceCaps( acanvas.handle, LOGPIXELSX );
        if (bitmapres = canvasres) and ( FZoomfactor = 100.0) then
             acanvas.Draw( trunc(xpos), trunc(ypos), imagemap)
        else
             acanvas.StretchDraw( rect( trunc(xpos), trunc(ypos),
                                         trunc(xpos)+trunc( fwidth*canvasres/bitmapres),
                                         trunc(ypos)+trunc( fheight*canvasres/bitmapres)),
                                         imagemap);
        PItem := TPageitem.Create;
        anode := dnode.attributes.getNamedItem( 'CID');
        if anode <> nil then
        begin
          PItem.controlID := anode.nodeValue;
          PItem.xpos := round( xpos);
          PItem.ypos := round( ypos);
          PItem.width := round( fwidth);
          PItem.height := round( fheight);
          recnode := dnode.attributes.getNamedItem( 'DBR');
          if recnode <> nil then
          begin
             val( recnode.nodeValue, rec, layer);
             pItem.DBRecord := rec;
          end;
          fpageItems.addobject( anode.nodeValue, pitem);
        end;
     except
        acanvas.textout(trunc(xpos*mmToPix), trunc(ypos*mmToPix), 'Image not available');
     end;
   finally
        imagemap.free;
        binstream.Free;
        tempstream.free;
   end;
end;

procedure TQRXDocument.DummyImage( dnode : IXMLDOMNode; acanvas : TCanvas);
var
   xpos, ypos, fheight, fwidth : double;
   layer : integer;
   fcolor : TColor;
begin
     try
        GetAttributes(dnode, xpos, ypos, fwidth, fheight, layer, fcolor );
        xpos := mmToPix*xpos;
        ypos := mmToPix*ypos;
        aCanvas.brush.color := clSilver;
        aCanvas.Pen.Color := clBlack;
        aCanvas.fillrect( Rect(round(xpos), round(ypos), round(xpos + fwidth), round(ypos + fheight)));
        aCanvas.rectangle( Rect(round(xpos), round(ypos), round(xpos + fwidth), round(ypos + fheight)));
     except

     end;
end;

procedure TQRXDocument.LoadQXDString( instring : string; aDomDocument : TDomDocument );
begin
     try
         aDomDocument.loadXML( instring);
         ReadQXDDocument( aDomDocument );
     except
         FDocumentLoaded := false;
     end;
end;

procedure TQRXDocument.LoadQXDFile( filename : string; aDomDocument : TDomDocument );
begin
     try
         aDomDocument.load( filename);
         ReadQXDDocument( aDomDocument );
     except
         FDocumentLoaded := false;
     end;
end;

procedure TQRXDocument.ReadQXDDocument( aDomDocument : TDomDocument );
var
   clist, Docnodes : IXMLDOMNodeList;
   dnode, headnode : IXMLDOMNode;
   params : IXMLDOMNamedNodeMap;
   tstr : string;
begin
   try
      Docnodes := aDomDocument.documentElement.getElementsByTagName('Header');
      headnode := Docnodes.item[0];
      clist := headnode.Get_childNodes;
      // attributes of header
      params := headnode.Get_attributes;
      Fpagewidth := 0;
      Fpageheight := 0;
      dnode := params.getNamedItem( 'Pagewidth' );
      if dnode <> nil then
      begin
          tstr := string(dnode.nodeValue);
          Fpagewidth := strtofloat( tstr );
      end
      else
          raise ERangeError.Create('page width missing');

      dnode := params.getNamedItem( 'Pageheight' );
      if dnode <> nil then
      begin
          tstr := string(dnode.nodeValue);
          Fpageheight := strtofloat( tstr );
      end
      else
          raise ERangeError.Create('page height missing');


      dnode := params.getNamedItem( 'PaperName' );
      if dnode <> nil then
          Fpapername := string(dnode.nodeValue)
      else
          Fpapername := string('Unknown');

      Docnodes := aDomDocument.documentElement.getElementsByTagName('Orientation');
      headnode := Docnodes.item[0];
      if headnode <> nil then
      begin
          tstr := headnode.Get_text;
          if lowercase( tstr) = 'portrait' then
              FOrientation := 0
          else
              FOrientation := 1;
      end;

      Fpagecount := aDomDocument.documentElement.getElementsByTagName('Page').Get_length;
      FDocumentLoaded := true;
   except
      FDocumentLoaded := false;
   end;
end;

function MakeZTS( src : string ): pchar;
var
    res : pchar;
begin
    res := stralloc( length(src)+1);
    strPcopy( res, src );
    res[length(src)] := chr(0);
    result := res;
end;


procedure TQRXDocument.WriteToStream( tx : string);
begin
    Fstream.Write( tx[1], length(tx));
end;

function ColTrans( ct : TColor ) : string;
var
   tempstr : string;
begin
    if ct < 0 then
    begin
        result := '#FFFFFF';
        exit;
    end;
    tempstr := format ( '%6.6x', [longint(ct)]);
    result := '#' + copy( tempstr, 5, 2 ) +copy( tempstr, 3, 2 )  +copy( tempstr, 1, 2 ) ;
end;


procedure TQRXDocument.HTMLGraphic( dnode : IXMLDOMNode; pagenum : integer );
var
    anode : IXMLDOMNode;
    xpos, ypos, fwidth, fheight, thickness : double;
    ixpos, iypos, iwidth, ipageoffset, iheight : integer;
    layer, shape, yfix : integer;
    fcolor, bcolor : TColor;
    filled : boolean;
    divstr : string;
begin
   yfix := 10;
   try
     GetAttributes(dnode, xpos, ypos, fwidth, fheight, layer, fcolor );
     ixpos := round( mmToPix * xpos );
     ipageoffset := round(pagenum*mmToPix*Fpageheight);
     iypos := round( mmToPix * ypos ) + ipageoffset -yfix;
     iwidth := round( fwidth * mmToPix);
     iheight := round( fheight * mmToPix);
     anode := dnode.attributes.getNamedItem( 'SP');
     shape := strtoint( anode.get_text);
     anode := dnode.attributes.getNamedItem( 'LW');
     thickness := strtofloat( anode.get_text)*mmToPoints;
     anode := dnode.attributes.getNamedItem( 'FT');
     filled := lowercase( anode.get_text) = 'fill';
     anode := dnode.attributes.getNamedItem( 'BC');
     bcolor := HexStrToInt(anode.nodeValue);
     case shape of
           0:
           begin
              if filled then
              begin
                 divstr := '<DIV style="position:absolute;left:'+format( '%-d', [ixpos])+'px;top:'+
                 format( '%-d', [iypos])+'px;width:'+format( '%-d', [iwidth])+'px;height:'+
                 format( '%-d', [iheight])+'px;'
                 + 'background-color:'+coltrans(bcolor)+';"></DIV>';
                 writeToStream( divstr + chr($0D)+chr($0A));
              end
              else
              begin
                 // left vert
                 divstr := '<DIV style="position:absolute;left:'+format( '%-d', [ixpos])+'px;top:'+
                 format( '%-d', [iypos+yfix])+'px;width:'+format( '%-d', [trunc(thickness*mmToPoints)])+'px;height:'+
                 format( '%-d', [iheight])+'px;' + 'background-color:'+coltrans(fcolor)+';"></DIV>';
                 writeToStream( divstr + chr($0D)+chr($0A));
                 //right vert
                 divstr := '<DIV style="position:absolute;left:'+format( '%-d', [ixpos+iwidth-trunc(thickness*mmToPoints)])+'px;top:'+
                 format( '%-d', [iypos+yfix])+'px;width:'+format( '%-d', [trunc(thickness*mmToPoints)])+'px;height:'+
                 format( '%-d', [iheight])+'px;' + 'background-color:'+coltrans(fcolor)+';"></DIV>';
                 writeToStream( divstr + chr($0D)+chr($0A));
                 // top horiz
                 divstr := '<DIV style="position:absolute;left:'+
                 format( '%-d', [ixpos]) + 'px;top:' +
                 format( '%-d', [iypos]) +
                 format('px;height:%-dpx;"><hr width="', [ trunc(thickness*mmToPoints)] ) +
                 format( '%-d', [iwidth]) + '" size="' +
                 format( '%-d', [trunc(thickness*mmToPoints)]) + '" color="' +
                 coltrans(fcolor)+'"></div>';
                 writeToStream( divstr + chr($0D)+chr($0A));
                 // botton horiz
                 divstr := '<DIV style="position:absolute;left:'+
                 format( '%-d', [ixpos]) + 'px;top:' +
                 format( '%-d', [iypos+iheight]) +
                 format('px;height:%-dpx;"><hr width="', [ trunc(thickness*mmToPoints)] ) +
                 format( '%-d', [iwidth]) + '" size="' +
                 format( '%-d', [trunc(thickness*mmToPoints)]) + '" color="' +
                 coltrans(fcolor)+'"></div>';
                 writeToStream( divstr + chr($0D)+chr($0A));
              end;
           end;
           1: exit;
           3: begin
                 divstr := '<DIV style="position:absolute;left:'+format( '%-d', [ixpos])+'px;top:'+
                 format( '%-d', [iypos+yfix])+'px;width:'+format( '%-d', [trunc(thickness*mmToPoints)])+'px;height:'+
                 format( '%-d', [iheight])+'px;' + 'background-color:'+coltrans(fcolor)+';"></DIV>';
                 writeToStream( divstr + chr($0D)+chr($0A));
              end;
           2: begin
                 divstr := '<DIV style="position:absolute;left:'+
                 format( '%-d', [ixpos]) + 'px;top:' +
                 format( '%-d', [iypos]) +
                 format('px;height:%-dpx;"><hr width="', [ trunc(thickness*mmToPoints)] ) +
                 format( '%-d', [iwidth]) + '" size="' +
                 format( '%-d', [trunc(thickness*mmToPoints)]) + '" color="' +
                 coltrans(fcolor)+'"></div>';
                 writeToStream( divstr + chr($0D)+chr($0A));
            end;

           else;
     end;
   except

   end;
end;
procedure TQRXDocument.HTMLImage( dnode : IXMLDOMNode; pagenum : integer );
var
    anode : IXMLDOMNode;
    xpos, ypos, fwidth, fheight, xscale, yscale, height, width : double;
    layer, ipageoffset : integer;
    fcolor : TColor;
    divstr, strcompress, imgfilename, imgdata : string;
    imgstrings : TStringlist;
    binstream, tempstream : TStream;
    imagemap, picmap : TBitmap;
    jpgimg : TJpegImage;
begin
   jpgimg := TJpegImage.Create;
   imagemap := TBitmap.Create;
   picmap := TBitmap.Create;
   binstream := TMemoryStream.Create;
   tempstream := TMemoryStream.Create;
   imgstrings := TStringlist.Create;
   try
    try
     GetAttributes(dnode, xpos, ypos, fwidth, fheight, layer, fcolor );
     anode := dnode.attributes.getNamedItem( 'XS');
     xscale := strtofloat(anode.nodeValue);
     anode := dnode.attributes.getNamedItem( 'YS');
     yscale := strtofloat(anode.nodeValue);
     height := fheight/yscale;
     width := fwidth/xscale;
     picmap.Width := round( width );
     picmap.Height := round(height );
     ipageoffset := round(pagenum*mmToPix*Fpageheight);
     Ypos := (Ypos * mmToPix) - 5.0 + ipageoffset;
     anode := dnode.attributes.getNamedItem( 'Cmp');
     strcompress := lowercase(anode.nodeValue);
     imgdata := dnode.Get_text;
     if strcompress = 'none' then
              AsciiHexToBinary( imgdata, binstream )
     else if strcompress = 'rle' then
     begin
              AsciiHexToBinary( imgdata, tempstream );
              tempstream.Seek( 0, 0 );
              UnRLE( tempstream, binstream );
     end;
     binstream.Seek( 0, 0 );
     imagemap.LoadFromStream(binstream);
     // scale the bitmap
     picmap.canvas.StretchDraw( rect(0, 0, picmap.width, picmap.height ), imagemap);
     imgfilename := IncludetrailingPathDelimiter(FImagePath) + format( 'Image%d.jpg', [FNextimage]);
     inc(FNextimage);
     // make it into a JPEG and save
     jpgimg.Assign( picmap);
     jpgimg.SaveToFile(  imgfilename );
     if FUseImageURL then
         imgfilename := FHTMLImageURL + format( 'Image%d.jpg', [FNextimage]);
     divstr := '<DIV style="position:absolute;left:'+
        format( '%-d', [round(xpos*mmToPix)])+'px;top:'+ format( '%-d', [round(ypos)])+'px;"><img src="'+imgfilename+'"></DIV>';
     writeToStream( divstr + chr($0D)+chr($0A));

    except
    // fails
    end;
   finally
     imagemap.Free;
     picmap.free;
     binstream.free;
     tempstream.free;
     imgstrings.free;
   end;
end;

procedure TQRXDocument.HTMLText( dnode : IXMLDOMNode; pagenum : integer );
const
    // 12/10/01 top, left of <DIV now in pixels.
    DivStrDef = '<div style="position:absolute;top:!toppx;left:!leftpx;font-family:!fontname;'
                +'font-size:!fontsizept;'+
                 'color:!color;text-decoration:!deco;text-align:left;background-color:!bgcolor;'+
                 'font-style:!style;font-weight :!weight;">';
var
    bold, italic : boolean;
    anode : IXMLDOMNode;
    xpos, ypos, fwidth, fheight : double;
    ixpos, iypos, ipageoffset : integer;
    layer : integer;
    fcolor : TColor;
    ftext, decostr, boldstr, fontname, newdivstr, funderline : string;
  procedure FixDivStr;
  begin
        newdivstr := stringreplace( newdivstr, '!top', format( '%-d', [iypos] ), [rfReplaceAll] );
        newdivstr := stringreplace( newdivstr, '!left', format( '%-d', [ixpos] ), [rfReplaceAll] );
        newdivstr := stringreplace( newdivstr, '!fontname', trim(fontname), [rfReplaceAll] );
        newdivstr := stringreplace( newdivstr, '!fontsize', format( '%-4.1f', [fheight] ), [rfReplaceAll] );
        newdivstr := stringreplace( newdivstr, '!color', trim(coltrans(fcolor)), [rfReplaceAll] );
        newdivstr := stringreplace( newdivstr, '!style', decostr, [rfReplaceAll] );
        newdivstr := stringreplace( newdivstr, '!weight', boldstr, [rfReplaceAll] );
        newdivstr := stringreplace( newdivstr, '!deco', funderline, [rfReplaceAll] );
  end;
begin
   try
     GetAttributes(dnode, xpos, ypos, fwidth, fheight, layer, fcolor );
     ixpos := round( mmToPix * xpos );
     ipageoffset := round(pagenum*mmToPix*Fpageheight);
     iypos := round( mmToPix * ypos ) + ipageoffset;
     anode := dnode.attributes.getNamedItem( 'Font');
     Fontname := anode.nodeValue;
     anode := dnode.attributes.getNamedItem( 'Weight');
     bold := lowercase(anode.nodeValue) = 'bold';
     anode := dnode.attributes.getNamedItem( 'Dec');
     italic := lowercase(anode.nodeValue) = 'italic';
     FText := dnode.Get_text;
     decostr := 'none';
     boldstr := 'normal';
     if bold and italic then
     begin
         decostr := 'italic';
         boldstr := 'bold';
     end
     else if italic then
         decostr := 'italic'
     else if bold then
         boldstr := 'bold';
     funderline := 'none';
     newdivstr := divstrdef;
     FixDivStr;
     writeToStream( newdivstr + chr($0D)+chr($0A));
     writeToStream( ftext+ chr($0D)+chr($0A) );
     writeToStream('</DIV>'+ chr($0D)+chr($0A));
   except

   end;
end;

procedure TQRXDocument.HTMLOnePage( pagenum : integer; aDomDocument : TDomDocument );
var
   rlist, clist : IXMLDOMNodeList;
   dnode, anode : IXMLDOMNode;
   i, layer, n : integer;
   tstr : string;
begin
   try
      if not FDocumentLoaded then exit;
      rlist := aDomDocument.documentElement.getElementsByTagName('Page');
      clist := rlist.item[pagenum].Get_childNodes;
      for n := 3 downto 0 do // layers
      begin
          for i := 0 to clist.length-1 do
          begin
               dnode := clist.item[i];
               anode := dnode.attributes.getNamedItem( 'LY');
               layer := strtoint( string(anode.nodeValue));
               if layer <> n then
                   continue;
               anode := dnode.attributes.getNamedItem( 'Type');
               tstr := lowercase(string(anode.nodeValue));
               if tstr = 'text' then
                   HTMLText( dnode, pagenum)
               else if tstr = 'graphic' then
                   HTMLGraphic( dnode, pagenum)
               else if tstr = 'image' then
                   HTMLImage( dnode, pagenum);
          end;
      end; // layer loop
   finally
      // done
   end;
end;


function TQRXDocument.RenderOneThumb( pagenum : integer; aDomDocument : TDomDocument;
                    fpagewidth, fpageheight : integer; thRect : TRect ) : TBitmap;
var
   rlist, clist : IXMLDOMNodeList;
   dnode, anode : IXMLDOMNode;
   i, layer, n, xres : integer;
   tstr : string;
   pageMap : TBitmap;
   aCanvas : TCanvas;
   saveZoom : extended;
begin
      pageMap := TBitmap.Create;
      aCanvas := pageMap.canvas;
      xres := GetDeviceCaps( aCanvas.handle, LOGPIXELSX );
      mmToPix := xres / 25.4;
      saveZoom := FZoomfactor;
      result := nil;
   try
      if not FDocumentLoaded then exit;
      FZoomfactor := 80.0 * (thRect.right-thRect.Left) / fpagewidth;
      pageMap.Width := round(fpageWidth * ( FZoomfactor / 100.0));
      pageMap.Height := round(fPageHeight * ( FZoomfactor / 100.0));
      acanvas.brush.Color := clWhite;
      acanvas.rectangle( 0, 0, fpageWidth, fpageheight);
      rlist := aDomDocument.documentElement.getElementsByTagName('Page');
      clist := rlist.item[pagenum].Get_childNodes;
      for n := 2 downto 0 do // layers
      begin
          for i := 0 to clist.length-1 do
          begin
               dnode := clist.item[i];
               anode := dnode.attributes.getNamedItem( 'LY');
               layer := strtoint( string(anode.nodeValue));
               if layer <> n then
                   continue;
               anode := dnode.attributes.getNamedItem( 'Type');
               tstr := lowercase(string(anode.nodeValue));
               if tstr = 'text' then
                   RenderText( dnode, acanvas)
               else if tstr = 'graphic' then
                   RenderGraphic( dnode, acanvas)
               else if (tstr = 'image') and FShowImagesInThumbs then
                   RenderImage( dnode, acanvas)
               else if (tstr = 'image') and not FShowImagesInThumbs then
                   DummyImage( dnode, acanvas);
          end;
      end; // layer loop
      result := pageMap;
   finally
      // done
      FZoomfactor := saveZoom;
   end;
end;

procedure TQRXDocument.MakeTextIndex;
var
   rlist, clist : IXMLDOMNodeList;
   dnode, anode : IXMLDOMNode;
   i, k, layer : integer;
   tstr : string;
   xpos, ypos, fheight, fwidth : double;
   fcolor : TColor;
   xitem : TPageitem;
begin
     if not FDocumentLoaded then exit;
     rlist := FDomDocument.documentElement.getElementsByTagName('Page');
     for k := 0 to rlist.Get_length-1 do
     begin
         clist := rlist.item[k].Get_childNodes;
         for i := 0 to clist.length-1 do
         begin
               dnode := clist.item[i];
               anode := dnode.attributes.getNamedItem( 'Type');
               tstr := lowercase(string(anode.nodeValue));
               if tstr = 'text' then
               begin
                   GetAttributes(dnode, xpos, ypos, fwidth, fheight, layer, fcolor );
                   tstr := dnode.Get_text;
                   xitem := TPageitem.Create;
                   xItem.cText := tstr;
                   xItem.DBRecord := k; // pagenumber actually
                   xItem.xpos := round( mmToPix * xpos );
                   xItem.ypos := round( mmToPix * ypos );
                   FTextIndex.AddObject( tstr, xItem );
               end;
         end;
     end;
end;

procedure TQRXDocument.RenderOnePage( pagenum : integer;
            aDomDocument : TDomDocument; fpagewidth, fpageheight : integer; ToPrinter : boolean );
var
   rlist, clist : IXMLDOMNodeList;
   dnode, anode : IXMLDOMNode;
   i, layer, n, xres : integer;
   tstr : string;
   pageMap : TBitmap;
   aCanvas : TCanvas;
begin
      pageMap := TBitmap.Create;
      if not ToPrinter then
              aCanvas := pageMap.Canvas
      else
              aCanvas := printer.Canvas;
      xres := GetDeviceCaps( aCanvas.handle, LOGPIXELSX );
      mmToPix := xres / 25.4;
   try
      if not FDocumentLoaded then exit;
      if not ToPrinter then
      begin
               FPageitems.clear;
               FPagebands.Clear;
               acanvas.rectangle( 0,0, fpageWidth, fpageheight);
               FPrinterOffsetX := 0.0;
               FPrinterOffsetY := 0.0;
               pageMap.Width := round(fpageWidth * ( FZoomfactor / 100.0));
               pageMap.Height := round(fPageHeight * ( FZoomfactor / 100.0));
               acanvas.brush.Color := clWhite;
      end;
      rlist := aDomDocument.documentElement.getElementsByTagName('Page');
      clist := rlist.item[pagenum].Get_childNodes;
      for n := 2 downto 0 do // layers
      begin
          for i := 0 to clist.length-1 do
          begin
               dnode := clist.item[i];
               anode := dnode.attributes.getNamedItem( 'LY');
               layer := strtoint( string(anode.nodeValue));
               if layer <> n then
                   continue;
               anode := dnode.attributes.getNamedItem( 'Type');
               tstr := lowercase(string(anode.nodeValue));
               if tstr = 'text' then
                   RenderText( dnode, acanvas)
               else if tstr = 'graphic' then
                   RenderGraphic( dnode, acanvas)
               else if tstr = 'image' then
                   RenderImage( dnode, acanvas)
               else if tstr = 'band' then
                   RegisterBand( dnode, acanvas);
          end;
      end; // layer loop
      if not ToPrinter then
      begin
         FImageControl.Width := fPagewidth;
         FImageControl.Height := fPageHeight;
         FImageControl.Picture.Assign( pageMap);
      end;
   finally
      // done
      pageMap.free;
   end;
end;

procedure TQRXDocument.RenderPageToBM( pagemap : TBitmap; pagenum : integer );
var
   rlist, clist : IXMLDOMNodeList;
   dnode, anode : IXMLDOMNode;
   i, layer, n, xres : integer;
   tstr : string;
   aCanvas : TCanvas;
   saveZoom : extended;
   pheight, pwidth : integer;
begin
      saveZoom := FZoomFactor;
      if pageMap = nil then exit;
      aCanvas := pageMap.Canvas;
      xres := GetDeviceCaps( aCanvas.handle, LOGPIXELSX );
      mmToPix := xres / 25.4;
   try
      if not FDocumentLoaded then exit;
      FZoomFactor := 100.0;
      pWidth := round(fpageWidth*mmToPix);
      pHeight := round(fPageHeight*mmToPix);
      pageMap.Width := pWidth;
      pageMap.Height := pHeight;
      acanvas.rectangle( 0,0, pwidth, pheight);
      FPrinterOffsetX := 0.0;
      FPrinterOffsetY := 0.0;
      acanvas.brush.Color := clWhite;
      rlist := FDomDocument.documentElement.getElementsByTagName('Page');
      clist := rlist.item[pagenum].Get_childNodes;
      for n := 2 downto 0 do // layers
      begin
          for i := 0 to clist.length-1 do
          begin
               dnode := clist.item[i];
               anode := dnode.attributes.getNamedItem( 'LY');
               layer := strtoint( string(anode.nodeValue));
               if layer <> n then
                   continue;
               anode := dnode.attributes.getNamedItem( 'Type');
               tstr := lowercase(string(anode.nodeValue));
               if tstr = 'text' then
                   RenderText( dnode, acanvas)
               else if tstr = 'graphic' then
                   RenderGraphic( dnode, acanvas)
               else if tstr = 'image' then
                   RenderImage( dnode, acanvas)
               else if tstr = 'band' then
                   RegisterBand( dnode, acanvas);
          end;
      end; // layer loop
   finally
      // done
      FZoomFactor := saveZoom;
   end;
end;

// data in stream -> stream
procedure AsciiHexToBinary2( instream, outstream : TStream);
var
     inchar1, inchar2, outb : byte;
     inbytes : longint;
     outbuffer : array[0..2048] of byte;
     buffindex : integer;
begin
     instream.Seek( 0, 0 );
     inbytes := instream.Size;
     buffindex := 0;
     while instream.Position < inbytes do
     begin
         // read 2 hex bytes 'A8' -> binary 8 bit
         instream.Read( inchar1, 1 );
         while (not IsHex( inchar1)) and (instream.Position < inbytes) do
         begin
            instream.Read( inchar1, 1 );
         end;
         if instream.Position >= inbytes then break;
         instream.Read( inchar2, 1 );
         while (not IsHex( inchar2)) and (instream.Position < inbytes) do
         begin
            instream.Read( inchar2, 1 );
         end;
         outb := HexToBin( inchar1, inchar2 );
         outbuffer[buffindex] := outb;
         inc( buffindex );
         if buffindex >= 2047 then
         begin
             outstream.Write( outbuffer, buffindex );
             buffindex := 0;
         end;
     end;
     if buffindex > 0 then
             outstream.Write( outbuffer, buffindex );
end;

procedure Hexit( var c1 : byte; var c2 : byte; b : byte );
var
       b1, b2 : byte;
begin
      b1 := b shr 4;
      b2 := b and $0F;
      if b1 < 10 then
          c1 := b1 + ORD0
      else
          c1 := (b1-10) + ORDA;
      if b2 < 10 then
          c2 := b2 + ORD0
      else
          c2 := (b2-10) + ORDA;
end;

procedure BinToAsciiHex(Source, Dest: TStream);
const
     REC_SIZE = 2048;
     CRLF = chr($0D) + chr($0A);
var
    C1, C2 : byte;
    cc : array[0..REC_SIZE] of byte;
    bytesin : longint;
    lineout : array[0..REC_SIZE*2] of byte;
    outindex : integer;
    i : integer;
begin
    source.Seek( 0, 0 );
    bytesin := Source.Read( cc, REC_SIZE );
    outindex := 0;
    while( bytesin > 0 ) do
    begin
         for i := 0 to bytesin-1 do
         begin
            Hexit( C1, C2, cc[i] );
            lineout[outindex] := C1;
            inc(outindex);
            lineout[outindex] := C2;
            inc(outindex);
         end;
         lineout[outindex] := $0A;
         inc(outindex);
         lineout[outindex] := $0D;
         inc(outindex);
         dest.write( lineout , outindex );
         outindex := 0;
         bytesin := Source.Read( cc, REC_SIZE );
    end;
end;


procedure UnRLE(Source, Target: TStream);
var
  C : String;
  i : Integer;
  cn : byte;
  outbuffer : array[0..2048] of char;
  buffindex : integer;
  procedure AddToBuffer( c : char );
  begin
      outbuffer[buffindex] := c;
      inc(buffindex);
      if buffindex >= 2047 then
      begin
           Target.Write( outbuffer, buffindex );
           buffindex := 0;
      end;
  end;
begin
  C := ' ';
  Source.Position := 0;
  Target.Position := 0;
  buffindex := 0;
  while Source.Position < Source.Size do
  begin
    Source.Read(C[1], 1);
    cn := ord( C[1]);
    if cn >= 128 then
    begin
        // replicate next input char  257 - cn times
        cn := 257 - cn;
        Source.Read(C[1], 1);
        for i := 1 to cn do
            AddToBuffer( C[1]);
    end
    else if cn <= 127 then
    begin
        // literal run of cn +1
        for i := 0 to cn do
        begin
           Source.Read(C[1], 1);
           AddToBuffer( C[1]);
        end;
    end;
  end;
  if buffindex > 0 then
           Target.Write( outbuffer, buffindex );
end;

end.
