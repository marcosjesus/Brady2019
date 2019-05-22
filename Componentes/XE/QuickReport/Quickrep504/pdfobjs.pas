unit pdfobjs;
////////////////////////////////////////////////////////////////////////////
//  Unit : pdfobjs.pas
//
//  PDF routines : based on PDF Spec 1.3
//
//
//  (c) 2001, 2002, 2003 QBS Software
//      created 10th October 2001 by DLMentz
//
// This code may not be reproduced for any purpose whatever nor any 
// changes made without written permission from QBS Software.
// 
// 04 th dec 2002 added compression see QRPDFFilt.pas.
// 15th Jan 2002 fix compression option and add ZapfDingbats.
// 15th March 2003 added DocumentInfo
// 30th April 2003 Fixed temp directory path on first page.
// 28/12/2003 added TrueType embedding
// 01/01/04  NO MORE TEMPFILES !!!
// 02/02/004  Charset property for TTFonts
// 25/05/2004 Added CustomWidths and CustomEncoding
////////////////////////////////////////////////////////////////////////////
{$define notTEMPFILES}
{$include QRDefs.inc}
interface
uses
  Windows, Messages, SysUtils, Classes, graphics, math, ExtCtrls;

const
  BaseFamilies : array[ 0..4] of string = (
       'Courier',
       'Helvetica',
       'Times',
       'Symbol',
       'ZapfDingbats' );

  BaseFonts : array[0..13] of string = (
       'Courier',
       'Courier-Bold',
       'Courier-BoldOblique',
       'Courier-Oblique',
       'Helvetica',
       'Helvetica-Bold',
       'Helvetica-BoldOblique',
       'Helvetica-Oblique',
       'Times-Roman',
       'Times-Bold',
       'Times-Italic',
       'Times-BoldItalic',
       'Symbol',
       'ZapfDingbats');
  // don't use enum type because of DLL packaging
  IT_TEXT = 1;
  IT_NEWPAGE = 2;
  IT_GRAPHIC = 3;
  IT_IMAGE = 4;
  IT_INVALID = 0;
  // shapes
  S_BOX = 0;
  S_CIRCLE = 1;
  S_HLINE = 2;
  S_VLINE = 3;
  S_OBLIQUE = 4;
  S_TOPBOTTOM = 5;         
  S_LEFTRIGHT = 6;
  // ascii
  ORD0 = ord('0');
  ORDA = ord('A');
  CRLF = chr($0D) + chr($0A);
  // TT font files
   TTFheader = 12;
   TABDIR = 16;

type

  TBuffer = array of byte;
  TRGBColor = record
      red, green, blue : byte;
  end;

  TDictionary = class
       private
          //FCount : integer;
          function GetCount : integer;
       protected
          keys, values : TStringlist;
       public
          procedure Add( key, value : string );
          procedure Clear;
          function Key(index : integer) : string;
          function KeyExists( key : string ) : boolean;
          function Value( key : string ) : string;
          procedure RemoveKey( key : string );
          constructor Create;
       //published
          property Count : integer read GetCount;
  end;

  TTFontrec = record
     firstchar, lastchar, capheight, italica, stemv,
     stemh, xheight : integer;
     flags, NumMetrics, MapMode : integer;
     ascent, descent : short;
     filelength : dword;
     BBox : array[0..3] of integer;
     metrics : array of integer;
  end;

  TPDFItemRec = record
      ItemType : byte;
      Xpos, Ypos : extended;
      Fontname, FText : pchar;
      fontsize : integer;
      FontCharset : integer;
      fcolor : pchar;
      fbold, fitalic : boolean;
      fAlignment : byte;
      Imagefilter : string;
      // extra for graphic item
      filled, staticimage : boolean;
      width, height, thickness, xscale, yscale : extended;
      imagesrc : pchar;
      imagestring : string;
      imagedata : string;
      shape : byte;
      pixelwidth, pixelheight : integer;
      rgbstrokecolor : TRGBColor;
      rgbfcolor : TRGBColor;
  end;

 TPDFPageObj = class(TObject)
  private
  public
      imagedata, textdata : string;
      textlen, grlen : longint;
  end;

var
   CompressionOn, MadeFirstPageFiles : boolean;
   TextFirst : boolean;
   OutputStream : TStream;
   Docdate,DocSubject,DocTitle,DocAuthor : string;
   OldSeparator : char;
   CustomWidths, CustomEncodings : TDictionary;
   // debug vars
   debugstr : string;
   debugbuff : array[0..50] of byte;
   debugint : integer;
   FCharset: TFontCharset;
  // exports
  procedure CloseDownLib;
  procedure InitLib( Mother : pointer );
  procedure AddPDFItem( ItemRec : TPDFItemRec );
  procedure AddImageItem( ItemRec : TPDFItemRec; imgdata : pointer );
  Procedure SetPageParams( w, h, tm, tma, lma : extended );
  Procedure AddFontSub( ssmap : string );
  procedure FinishDoc( FOutFile : string );
  procedure SetTextFirst( bval : boolean );
  procedure SetTempDirectory( tpath : string );
  procedure SetFiltCompression( OnOff : integer );
  procedure SetOutputStream( pstr : TStream );
  procedure SetDocProperties( author, title, subject : string );
  procedure EmbedTTFont( fontname : string);
  procedure SelectCharset( chars : TFontCharset );
  procedure SetWidths( fontname, widthstr : string );
  procedure SetEncoding( fontname, estr : string );
  // end exports
  procedure FinishPage;
  procedure StartPage;
  procedure MakeResourceDict;
  procedure MakeTTFont( fontname, stylename : string; fnumber : integer);
  procedure MakeXRef;
  function MapFontName( oldname : string ) : string;
  function IsNumber( s : string ) : boolean;
  function Pad10( s : string ) : string;
  function RGBString( acol : TRGBColor ) : string;
  procedure HEXImage( ffi : string );
  function PDFArcTo(X1, Y1, X2, Y2, XRadius, YRadius: Extended): String;
  procedure RunLength( source, Target : TStream );
  procedure ASCII85(Source, Target: TStream; soffset : longint);
  procedure SplitString( ss : string; sep : char; var aList : TStringlist );

implementation
uses pdfconst;

var
   fontrec : TTFontrec;
   buff : array of byte;
   CurrObject, VertAdjust : integer;
   Pagewidth, Pageheight, TopMargin, adjusttm, adjustlm : extended;
   imagecount, pagenumber : longint;
   XRefBytes : tstringlist;
   DocTop, PagesList : TStringlist;
   fontlist : TStringlist;
   TextItems, FontSubs : TStringList;
   pagetextfiles, pagegraphicsfiles : TStringlist;
{$ifdef TEMPFILES}
   CurrPageFile, CurrImageFile : TFilestream;
{$else}
   CurrPageFile, CurrImageFile : TStringlist;
{$endif}
   textlength, graphicslength : longint;
   textlengths, graphicslengths, ttfonts : TStringlist;
   docstream, tempstream : TStream;
   docstreamlen : longint;
   TempDirectory : string;

function cvtDWord( buf : array of byte; p : integer) : dword;
begin
    result := (256*256*256*buf[p]) + (256*256*buf[p+1]) + (256*buf[p+2]) + buf[p+3];
end;

function cvtInt( buf : array of byte; p : integer) : integer;
begin
    result := (256*buf[p]) + (buf[p+1]);
end;

procedure InitLib( mother : pointer );
begin
    // global creations
    XRefBytes := TStringlist.create;
    Pageslist := TStringlist.create;
    Fontlist := TStringlist.create;
    TextItems  := TStringlist.create;
    textlengths  := TStringlist.create;
    graphicslengths  := TStringlist.create;
    ttfonts  := TStringlist.create;
    pagetextfiles := TStringlist.create;
    pagegraphicsfiles := TStringlist.create;
    TempDirectory := '';
    // start a new page
    pagenumber := 0;
    // don't do this beacuse the temp path is not set.
    //Startpage;
    MadeFirstPageFiles := false;
    // load default font subs
    FontSubs := TStringlist.create;
    fontsubs.add('Arial:Helvetica');
    fontsubs.add('Times-new-roman:Times');
    fontsubs.add('Courier-new:Courier');

    CustomWidths := TDictionary.Create;
    CustomEncodings := TDictionary.Create;
    VertAdjust := 20; // points
    imagecount := 0;
    Pagewidth := 595;
    Pageheight := 840;
    // ensure decimal separator
    OutputStream := nil;
    OldSeparator := DecimalSeparator;
end;

procedure EmbedTTFont( fontname : string);
begin
    ttfonts.add( fontname);
end;

procedure SelectCharset( chars : TFontCharset );
begin
      FCharset := chars;
end;

procedure CloseDownLib;
var
    k : integer;
begin
      // global free
      CustomWidths.Free;
      CustomEncodings.Free;
      Fontlist.free;
      xrefbytes.free;
      fontsubs.free;
      pagetextfiles.free;
      textlengths.free;
      ttfonts.Free;
      graphicslengths.free;
      DecimalSeparator := OldSeparator;
      for k := 0 to pagegraphicsfiles.Count-1 do
            TStringlist(pagegraphicsfiles.objects[k]).Free;
      pagegraphicsfiles.free;
end;

procedure SetDocProperties( author, title, subject : string );
begin
     DocAuthor := author;
     DocTitle := title;
     DocSubject := subject;
end;

procedure SetOutputStream( pstr : TStream );
begin
    OutputStream := pstr;
end;

procedure SetTempDirectory( tpath : string );
begin
    TempDirectory := IncludeTrailingBackslash( tpath);
end;

procedure SetFiltCompression( OnOff : integer );
begin
    CompressionOn := onoff > 0;
end;

Procedure SetPageParams( w, h, tm, tma, lma : extended );
begin
    pagewidth := w;
    pageheight := h;
    topmargin := tm;
    adjusttm := tma;
    adjustlm := lma;
end;

procedure SetWidths( fontname, widthstr : string );
begin
     CustomWidths.Add( fontname, widthstr );
end;

procedure SetEncoding( fontname, estr : string );
begin
     CustomEncodings.Add( fontname, estr );
end;

Procedure SetTextFirst( bval : boolean );
begin
    TextFirst := bval;
end;

Procedure AddFontSub( ssmap : string );
var
    k : integer;
begin
    // expecting 'Name-to-be-mapped: base-font'
    k := fontsubs.indexof( ssmap );
    if k <> -1 then
        fontsubs[k] := ssmap
    else
       fontsubs.add( ssmap );
end;

procedure WriteStr( ob : string );
var
  k, b : integer;
begin
    ob := ob + CRLF;
    for k := 1 to length( ob ) do
    begin
         b := ord(ob[k]);
         docstream.WriteBuffer( b, 1 );
    end;
    inc( docstreamlen, length(ob));
end;

procedure WriteStrNoCRLF( ob : string );
var
  k, blen : integer;
  bbuff : array of byte;
begin
    blen := length( ob );
    setlength( bbuff, blen);
    for k := 1 to blen do
    begin
         bbuff[k-1] := ord(ob[k]);
    end;
    docstream.WriteBuffer( bbuff[0], blen );
    inc( docstreamlen, blen);
    setlength( bbuff, 0);
end;

procedure WriteStrNoCRLFold( ob : string );
var
  k, b : integer;
begin
    for k := 1 to length( ob ) do
    begin
         b := ord(ob[k]);
         docstream.WriteBuffer( b, 1 );
    end;
    inc( docstreamlen, length(ob));
end;

procedure WriteByte( ob : byte );
var
  b : integer;
begin
     b := ob;
     docstream.WriteBuffer( b, 1 );
     inc( docstreamlen);
end;

procedure SaveOffset;
begin
       //xrefbytes.add( format( '%-10.10d', [ length( doctop.text )] ));
       xrefbytes.add( format( '%-10.10d', [ docstreamlen] ));
end;

procedure FinishDoc( FOutFile : string );
var
   k, j, p : integer;
   newfname, kidstring, stylename : string;
   streamlen : longint;
   pagetext : TStringlist;
begin
   FinishPage;
   Doctop := TStringlist.create;
   //fontobjlines := TStringlist.create;
   pagetext := TStringlist.create;
   docstreamlen := 0;
   if OutputStream = nil then
        docstream := TFilestream.Create( FOutFile, fmCreate )
   else
        docstream := OutputStream;

   // Root catalog
   WriteStr( '%PDF-1.3' );
   SaveOffset;
   WriteStr( '1 0 obj' );
   WriteStr( '<<' );
   WriteStr( '/Type /Catalog' );
   WriteStr( '/Pages 3 0 R' );
   WriteStr( '/Outlines 2 0 R' );
   WriteStr( '/ViewerPreferences << /HideToolbar false /FitWindow true >>' );
   WriteStr( '>>' );
   WriteStr( 'endobj' );
   // empty outlines ( for the moment )
   SaveOffset;
   WriteStr( '2 0 obj' );
   WriteStr( '<<' );
   WriteStr( '/Type /Outlines' );
   WriteStr( '/Count 0' );
   WriteStr( '>>' );
   WriteStr( 'endobj' );
   // Pages object
   SaveOffset;
   WriteStr( '3 0 obj' );
   WriteStr( '<<' );
   WriteStr( '/Type /Pages' );
   WriteStr( format( '/Count %d', [pagenumber]) );
   kidstring := '/Kids [';
   for k := 0 to pagetextfiles.count-1 do
      kidstring := kidstring + format( '%d 0 R ', [4+(2*k)] );
   kidstring := trim(kidstring) + ']';
   WriteStr( kidstring );
   // global stuff inherited by page objs
   WriteStr( format( '/MediaBox [0 0 %d %d]', [trunc(pagewidth), trunc(pageheight)] ) );
   MakeResourceDict;
   WriteStr( '>>' );
   WriteStr( 'endobj' );
   CurrObject := 3;
   SaveOffset;
   for j := 0 to pagetextfiles.count-1 do
   begin
       streamlen := strtoint(textlengths[j])+ strtoint(graphicslengths[j]) +4;
       WriteStr( trim(format( '%d 0 obj', [CurrObject+1])));
       WriteStr( '<<' );
       WriteStr( '/Type /Page' );
       WriteStr( '/Parent 3 0 R' );
       WriteStr( format( '/Contents %d 0 R',[CurrObject+2]) );
       WriteStr( '>>' );
       WriteStr( 'endobj' );

       // Page contents object
       SaveOffset;
       WriteStr(  trim(format( '%d 0 obj', [ CurrObject+2])) );
       WriteStr( format('<< /Length %d >>', [streamlen]));
       WriteStr( 'stream' );
       // optional order of printing.
       if TextFirst then
       begin
           WriteStr( 'BT' );
{$ifdef TEMPFILES}
           // insert the page instructions here
           tempstream := TFilestream.Create( pagetextfiles[j], fmOpenRead );
           docstream.CopyFrom( tempstream, tempstream.Size );
           inc( docstreamlen, tempstream.size );
           tempstream.Free;

           tempstream := TFilestream.Create( pagegraphicsfiles[j], fmOpenRead );
           docstream.CopyFrom( tempstream, tempstream.Size );
           inc( docstreamlen, tempstream.size );
           tempstream.Free;

           deletefile(pagetextfiles[j]);
           deletefile(pagegraphicsfiles[j]);
{$else}
           pagetext := TStringlist( pagetextfiles.Objects[j]);
           WriteStrNoCRLF( pagetext.GetText);

           pagetext := TStringlist( pagegraphicsfiles.Objects[j]);
           WriteStrNoCRLF( pagetext.GetText);

{$endif}
       end
       else
       begin
           // graphics
{$ifdef TEMPFILES}
           tempstream := TFilestream.Create( pagegraphicsfiles[j], fmOpenRead );
           docstream.CopyFrom( tempstream, tempstream.Size );
           inc( docstreamlen, tempstream.size );
           tempstream.Free;
           // text
           WriteStr( 'BT' );
           tempstream := TFilestream.Create( pagetextfiles[j], fmOpenRead );
           docstream.CopyFrom( tempstream, tempstream.Size );
           inc( docstreamlen, tempstream.size );
           tempstream.Free;
           deletefile(pagetextfiles[j]);
           deletefile(pagegraphicsfiles[j]);
{$else}
           pagetext := TStringlist( pagegraphicsfiles.Objects[j]);
           WriteStrNoCRLF( pagetext.GetText);

           WriteStr( 'BT' );
           pagetext := TStringlist( pagetextfiles.Objects[j]);
           WriteStrNoCRLF( pagetext.GetText);

{$endif}
       end;
       WriteStr( 'endstream' );
       WriteStr( 'endobj' );
       inc( currobject, 2 );
       SaveOffset;
   end;
   CurrObject := 4 + (2*pagenumber);
   for k := 0 to fontlist.count-1 do
   begin
        newfname := trim(fontlist[k]);
        stylename := '';
        p := pos(',', newfname);
        if p > 0 then
        begin
           stylename := trim(copy( newfname, p+1, 255));
           newfname := trim(copy( newfname, 1, p-1));
        end;
        if ttfonts.IndexOf( newfname) >=0 then
        begin
            MakeTTFont( newfname, stylename, k );
        end
        else
        begin
           newfname := MapFontName( fontlist[k] );
           WriteStr( trim(format( '%d 0 obj', [CurrObject] )) );
           WriteStr( '<<' );
           WriteStr( '/Type /Font' );
           WriteStr( '/Subtype /Type1' );
           WriteStr( trim(format('/Name /F%-2.2d', [k] )) );
           WriteStr( '/BaseFont /' + trim(newfname) );
           WriteStr( '/Encoding /WinAnsiEncoding' );
           WriteStr( '>>' );
           WriteStr( 'endobj' );
           inc( currobject );
           SaveOffset;
        end;
   end;
   // add an object with the doc properties
   WriteStr( format( '%d 0 obj', [CurrObject]) );
   WriteStr( '<<' );
   DocDate := DateTimeToStr( now );
   WriteStr( '/CreationDate ('+ DocDate+')' );
   WriteStr( '/Producer (QuickReports PDF Export)' );
   WriteStr( '/Subject ('+ DocSubject +' )');
   WriteStr( '/Creator (QuickReports)' );
   WriteStr( '/Title ('+ DocTitle  +')' );
   WriteStr( '/Author ('+ DocAuthor+')' );
   WriteStr( '>>' );
   WriteStr( 'endobj' );
   inc( currobject);
   SaveOffset;

   WriteStr( format( '%d 0 obj', [CurrObject]) );
   WriteStr( '[/PDF /Text]' );
   WriteStr( 'endobj' );
   inc(CurrObject);

   MakeXRef;

   // locally created - localy destroyed
   pagetext.Free;
   doctop.free;
   if docstream is TFilestream then
                      docstream.free;
end;

procedure MakeXRef;
var
   k, ByteCount : longint;
begin
   bytecount := docstreamlen;
   WriteStr( 'xref' );
   WriteStr( format( '0 %d', [xrefbytes.count+1] ));
   WriteStr( '0000000000 65535 f' );
   for k := 0 to xrefbytes.count-1 do
       WriteStr( xrefbytes[k] + ' 00000 n' );
   // trailer
   WriteStr( 'trailer' );
   WriteStr( '<<' );
   WriteStr( format ('/Size %d', [xrefbytes.count+1] ));
   WriteStr( '/Root 1 0 R' );
   WriteStr( format('/Info %d 0 R',[xrefbytes.count-1]) );
   WriteStr( '>>' );
   WriteStr( 'startxref' );
   WriteStr( format ('%d', [ByteCount] ) );
   WriteStr( '%%EOF' );
end;

function MapFontName( oldname : string ) : string;
var
  k, p : integer;
  basename, s1 : string;
  isbold, isitalic : boolean;
begin
   // oldname is 'fontname[, bold][,italic]'
   isbold := AnsiPos( 'bold', Ansilowercase( oldname ) ) > 0;
   isitalic := AnsiPos( 'italic', Ansilowercase( oldname ) ) > 0;
   k := pos( ',', oldname );
   if k > 0 then
       basename := copy( oldname, 1, k-1 )
   else
       basename := oldname;
   // Is it mapped ?
   for k := 0 to fontsubs.count-1 do
   begin
       s1 := fontsubs[k];
       if AnsiPos( Ansilowercase(basename), Ansilowercase( s1 ) ) = 1 then
       begin
            p := AnsiPos( ':', fontsubs[k] );
            if p > 0 then
               basename := copy( fontsubs[k], p+1, 512 )
            else
               basename := 'Courier'; // bad mapping, no colon
            break;
       end;
   end;
   p := AnsiPos( '-', basename );
   if p > 0 then
       basename := Copy( basename, 1, p-1 );
   // Do we now have one of the pre-defined type1's
   p := -1;
   for k := 0 to 4 do
    if AnsiSametext( basefamilies[k], basename ) then
    begin
       p := k;
       break;
    end;
   if p = -1 then
   begin
       p := 0;// Courier
       basename := 'Courier';
   end;
   // now amend the name to the full name
   case p of
   0, 1 : // courier, helv
      if isbold and isitalic then
        basename := basename + '-BoldOblique'
      else if isbold then
        basename := basename + '-Bold'
      else if isitalic then
        basename := basename + '-Oblique';
   2 :  // Times
      if isbold and isitalic then
        basename := basename + '-BoldItalic'
      else if isbold then
        basename := basename + '-Bold'
      else if isitalic then
        basename := basename + '-Italic'
      else
        basename := basename + '-Roman'
   end;
   result := basename;
end;

procedure GetMetrics( buff : array of byte; offset : dword);
var
  k : word;
begin
     setlength( fontrec.metrics, fontrec.numMetrics);
     // each element is a USHORT and a SHORT
     for k := 0 to fontrec.NumMetrics-1 do
     begin
          fontrec.metrics[k] := cvtInt( buff, offset+(k*4));
          //TTFtestfrm.memo1.lines.add( inttostr( metrics[k]));
     end;
end;

procedure AnalyseTTFont( fontname, stylename : string; var encoding : string);
var
    fsize, offset, res, headOff, boxOff : dword;
    codePage : word;
    k, ntabs, toff, tlen, i : integer;
    widthstr, tabTag, localfontname, charString, fullfontname, encodestr : string;
    pbox : TImage;
    Found : boolean;
    otmetric : OUTLINETEXTMETRIC;
    widths : array[0..16000] of integer;
    charCodes : array[0..255] of word;
    wresult : boolean;
    widlist : TStringList;
begin
     pbox := TImage.create( nil);
     headOff := 0;
     fsize := 0;
     localfontname := stringreplace( trim(fontname), '-',' ', [rfReplaceAll]);
     fullfontname := localfontname;
     if trim(stylename) <> '' then
          fullfontname := fullfontname + '-' + stylename;
     pbox.canvas.Font.Name := localfontname;
     pbox.Canvas.Font.Charset := FCharset;

     fontrec.MapMode := GetMapMode(pbox.canvas.handle);
     fontrec.ascent := pbox.canvas.Font.Height;
     pbox.canvas.Font.Height := -1024;

     if lowercase( stylename) = 'bold' then
             pbox.canvas.Font.Style := [fsBold]
     else if lowercase( stylename) = 'italic' then
             pbox.canvas.Font.Style := [fsItalic]
     else if lowercase( stylename) = 'underline' then
             pbox.canvas.Font.Style := [fsUnderline];
      
     res := GetFontData( pbox.canvas.handle,0,0, nil, fsize);
     fsize := res;
     fontrec.filelength := res;
     setlength( buff, fsize);
     GetFontData( pbox.canvas.handle,0,0, buff, fsize);
     ntabs := cvtInt( buff, 4);
     for k := 0 to ntabs-1 do
     begin
         offset :=  (k*TABDIR)+TTFheader;
         // four 4-byte fields
         Tabtag := chr(buff[offset]) + chr(buff[offset+1]) + chr(buff[offset+2]) + chr(buff[offset+3]);
         toff := cvtDWord( buff, offset+8 );
         tlen := cvtDWord( buff, offset+12 );
         if tabTag = 'head' then
             headOff := toff;
         if tabTag = 'hhea' then
         begin
            // get num metrics, Ascender, Descender.
            fontrec.numMetrics := cvtInt( buff, toff+tlen-2);
            //fontrec.ascent := cvtInt( buff, toff+4);
            //fontrec.descent := cvtInt( buff, toff+4+2);
         end;
     end;
     GetOutlineTextMetrics( pbox.canvas.handle, sizeof(otmetric), @otmetric );
     fontrec.firstchar := ord(otmetric.otmTextMetrics.tmFirstChar);
     fontrec.lastchar := ord(otmetric.otmTextMetrics.tmLastChar);
     fontrec.ascent := otmetric.otmAscent;
     fontrec.descent := otmetric.otmDescent;
     fontrec.italica := otmetric.otmItalicAngle;
     fontrec.firstchar := 0;
     fontrec.NumMetrics := fontrec.lastchar-fontrec.firstchar+1;
     // custom widths
     widthstr := CustomWidths.Value( fullfontname);
     if widthstr <> '' then
     begin
        widlist := TStringList.create;
        Splitstring( widthstr, ' ', widlist );
        if widlist.Count < 256 then
        begin
            raise ERangeError.CreateFmt( 'Not enough Custom widths (%d < 256) for font "%s"  ', [ widlist.Count, fontname]);
            exit;
        end;
        setlength(fontrec.metrics, 256);
        for k := 0 to 255 do
           if k < widlist.Count then
            fontrec.metrics[k] := strtoint( widlist[k]);
     end
     else
     begin
        wresult := GetCharWidth32( pbox.canvas.handle, fontrec.firstchar, fontrec.lastchar, widths);
        if not wresult then
        begin
           k := GetLastError;
           raise ERangeError.CreateFmt( 'Font widths for "%s" not obtainable (%d)', [fontname, k]);
           exit;
        end;
        setlength(fontrec.metrics, 256);
        for k := 0 to 255 do
            fontrec.metrics[k] := widths[k];
     end;
     // get fontBBox , flags
     fontrec.flags := cvtInt( buff, HeadOff + 16);
     boxOff := 36;
     fontrec.BBox[0] := cvtInt( buff, headOff + boxOff);
     fontrec.BBox[1] := cvtInt( buff, headOff + boxOff + 2);
     fontrec.BBox[2] := cvtInt( buff, headOff + boxOff + 4);
     fontrec.BBox[3] := cvtInt( buff, headOff + boxOff + 6);
     pbox.Free;
     // custom encoding
     encodestr := CustomEncodings.Value( fullfontname);
     if encodestr <> '' then
     begin
         encoding := ' <</Type/Encoding /Differences [ ' + encodestr + ' ]>>';
         exit;
     end;

     // get the encoding string
     case FCHARSET of
          BALTIC_CHARSET: CodePage := 1257;
          CHINESEBIG5_CHARSET: CodePage := 950;
          EASTEUROPE_CHARSET: CodePage := 1250;
          GB2312_CHARSET: CodePage := 936;
          GREEK_CHARSET: CodePage := 1253;
          OEM_CHARSET: CodePage := CP_OEMCP;
          RUSSIAN_CHARSET: CodePage := 1251;
          SHIFTJIS_CHARSET: CodePage := 932;
          TURKISH_CHARSET: CodePage := 1254;
          HEBREW_CHARSET: CodePage := 1255;
          ARABIC_CHARSET: CodePage := 1256;
          THAI_CHARSET: CodePage := 874;
          VIETNAMESE_CHARSET: CodePage := 1258;
          else
             CodePage := 1252;
     end;
     charString := '';
     for i := 1 to 255 do
            charString := charString + chr(i);

     k := MultiByteToWideChar(CodePage, 0, PansiChar(charString), 255, @charCodes, 255);
     if k <> 0 then
     begin
          encoding := ' <</Type/Encoding /Differences [ ' + inttostr(fontrec.firstChar+2) + ' ';
          for i := 1 to 255 do
          begin
              if i < fontrec.firstchar then continue;
              Found := False;
              for k := 0 to 1050 do
              begin
                if charCodes[i] = UniGlyphs[k].ID then
                begin
                  encoding := encoding + '/' + UniGlyphs[k].Name;
                  Found := True;
                  Break;
                end;
              end;
              if not Found then
              begin
                if charCodes[I] > 256 then
                  //encoding := encoding + '/uni' + WordToHex(charCodes[I])
                else
                  encoding := encoding + '/space';
              end;
          end;
          encoding := encoding + ']';
     end
     else
     begin
            encoding := encoding + '/BaseEncoding /WinAnsiEncoding';
     end;
     encoding := encoding + '>>';
end;

procedure MakeTTFont( fontname, stylename : string; fnumber : integer);
var
   k : integer;
   //ob : array[0..1] of byte;
   mstr, localname, encoding : string;
begin
     encoding := '';
     AnalyseTTFont( fontname, stylename, encoding);
     WriteStr( trim(format( '%d 0 obj', [CurrObject] )) );
     WriteStr( '<<' );
     WriteStr( '/Type /Font' );
     WriteStr( '/Subtype /TrueType' );
     localname := trim(format('F%-2.2d', [fnumber] ));
     WriteStr( trim(format('/Name /F%-2.2d', [fnumber] )) );
     {
     if stylename <> '' then
                  WriteStr( '/BaseFont /' + trim(fontname) + ',' + trim(stylename) )
     else
     }
        WriteStr( '/BaseFont /' + trim(fontname) );
     //fontrec.firstchar := 0;
     //fontrec.lastchar := 255;
     WriteStr( '/FirstChar ' + inttostr(fontrec.firstchar) );
     WriteStr( '/LastChar ' + inttostr(fontrec.lastchar) );
     // output the width array
     WriteStr( '/Widths [ ' );
     mstr := '';
     for k := 0 to high(fontrec.metrics) do
        mstr := mstr + format( '%-d ',[fontrec.metrics[k]]);
     WriteStr( mstr + ' ]' );
{$define notENC}
{$ifndef ENC}
     WriteStr( '/Encoding '+encoding );
     WriteStr( '/FontDescriptor '+inttostr( CurrObject+1)+' 0 R' );
{$else}
     WriteStr( '/FontDescriptor '+inttostr( CurrObject+2)+' 0 R' );
     WriteStr( '/Encoding '+inttostr( CurrObject+1)+' 0 R' );
{$endif}
     WriteStr( '>>' );
     WriteStr( 'endobj' );
     SaveOffset;
     inc( currobject );

     WriteStr( trim(format( '%d 0 obj', [CurrObject] )) );
     WriteStr( '<<' );
     WriteStr( '/Type /FontDescriptor' );
     WriteStr( '/Ascent ' + inttostr(fontrec.ascent) );
     WriteStr( '/Descent ' + inttostr(fontrec.descent) );
     //WriteStr( '/CapHeight 700' );
     //WriteStr( '/Flags ' + inttostr(fontrec.flags) );
     WriteStr( '/Flags 40' );
     WriteStr( format('/FontBBox [ %-d %-d %-d %-d ]',[fontrec.bbox[0],
                          fontrec.bbox[1],fontrec.bbox[2],fontrec.bbox[3]]) );
     WriteStr( '/FontName /' + localname );
     WriteStr( '/ItalicAngle ' + inttostr(fontrec.italica) );
     //WriteStr( '/StemV ' + inttostr(fontrec.descent) );
     //WriteStr( '/StemH ' + inttostr(fontrec.descent) );
     //WriteStr( '/XHeight ' + inttostr(fontrec.descent) );
     // can we do without the embedding ?
     WriteStr( '/FontFile2 '+inttostr( CurrObject+1)+' 0 R' );
     WriteStr( '>>' );
     WriteStr( 'endobj' );
     SaveOffset;
     inc( currobject );
     // now the actual font file
     WriteStr( trim(format( '%d 0 obj', [CurrObject] )) );
     WriteStr( '<<' );
     WriteStr( '/Length '+inttostr( CurrObject+1)+' 0 R /Length1 '+inttostr( CurrObject+1)+' 0 R ' );
     // compressing font file
     WriteStr( '>>' );
     WriteStr( 'stream' );
     mstr := '';
     for k := 0 to fontrec.filelength-1 do
     begin
        WriteByte( buff[k]);
     end;
     WriteStr( CRLF + 'endstream' );
     WriteStr( 'endobj' );
     SaveOffset;
     inc( currobject );
     WriteStr( trim(format( '%d 0 obj', [CurrObject] )) );
     WriteStr( '   ' + inttostr(fontrec.filelength) );
     WriteStr( 'endobj' );
     SaveOffset;
     inc( currobject );
end;

procedure MakeResourceDict;
var
   k, foff, numfontobjs, p : integer;
   newfname : string;
begin
   WriteStr( '/Resources << ');
   WriteStr( '/Font << ' );
   foff := 0;
   numfontobjs := 0;
   for k := 0 to fontlist.count-1 do
   begin
        WriteStr( format('  /F%-2.2d %d 0 R ', [k, foff + 4 +(2*pagenumber)] ));
        newfname := trim(fontlist[k]);
        p := pos(',', newfname);
        if p > 0 then
        begin
           newfname := trim(copy( newfname, 1, p-1));
        end;
        if ttFonts.IndexOf( newfname) >= 0 then
        begin
{$ifndef ENC}
             inc( foff, 3);
             inc( numfontobjs, 3);
{$else}
             inc( foff, 4);
             inc( numfontobjs, 4);
{$endif}
        end;
        inc(foff);
        inc(numfontobjs);
   end;
   WriteStr( '  >>' );
   WriteStr( format('/ProcSet %d 0 R', [5 +(2*pagenumber)+numfontobjs ] ));
   WriteStr( '>>' );
end;

{$ifdef TEMPFILES}
procedure PTWrite( ob : string );
var
  k, b : integer;
begin
    ob := ob + CRLF;
    for k := 1 to length( ob ) do
    begin
         b := ord(ob[k]);
         currpagefile.WriteBuffer( b, 1 );
    end;
     inc(textlength, length(ob));
end;

procedure GRWrite( ob : string );
var
  k, b : integer;
begin
    ob := ob + CRLF;
    for k := 1 to length( ob ) do
    begin
         b := ord(ob[k]);
         CurrImageFile.WriteBuffer( b, 1 );
    end;
     inc(graphicslength, length(ob));
end;

procedure StartPage;
var
   thetime : TTimeStamp;
   tmpfile : string;
begin
       inc(pagenumber);
       thetime := DateTimeToTimeStamp(now);
       tmpfile := TempDirectory+format( 'I%-d%-d%-6.6d.tmp', [thetime.Date, theTime.time, pagenumber] );
       pagetextfiles.Add( tmpfile);
       tmpfile := TempDirectory+format( 'T%-d%-d%-6.6d.tmp', [thetime.Date, TheTime.time, pagenumber] );
       pagegraphicsfiles.Add( tmpfile);
       currpagefile := TFilestream.Create( pagetextfiles[pagenumber-1], fmCreate );
       CurrImageFile := TFilestream.Create( pagegraphicsfiles[pagenumber-1], fmCreate );
       textlength := 0;
       graphicslength := 0;
       MadeFirstPageFiles := true;
end;

procedure FinishPage;
begin
     ptwrite( 'ET' );
     currpagefile.free;
     currimagefile.free;
     textlengths.add( format( '%d', [ textlength] ));
     graphicslengths.add( format( '%d', [ graphicslength] ));
end;
{$else}
procedure PTWrite( ob : string );
begin
    currpagefile.Add(ob);
    inc(textlength, length(ob)+2);
end;

procedure GRWrite( ob : string );
begin
    CurrImageFile.Add(ob);
    inc(graphicslength, length(ob)+2);
end;

procedure StartPage;
var
   tmplist : TStringlist;
begin
       inc(pagenumber);
       tmplist := TStringlist.Create;
       currpagefile := tmplist;
       pagetextfiles.AddObject( inttostr(pagenumber), tmplist);
       tmplist := TStringlist.Create;
       pagegraphicsfiles.AddObject( inttostr(pagenumber), tmplist);
       CurrImageFile := tmplist;
       textlength := 0;
       graphicslength := 0;
       MadeFirstPageFiles := true;
end;

procedure FinishPage;
begin
     ptwrite( 'ET' );
     textlengths.add( format( '%d', [ textlength] ));
     graphicslengths.add( format( '%d', [ graphicslength] ));
end;
{$endif}

function FLong( b : array of byte ) : longint;
begin
    result := b[0];
end;

procedure ProcessItem( ir : TPDFItemRec; pimagefile : string );
var
    fontnum: integer;
    xradius, yradius : extended;
    currfont, tstr, tfname : string;
    //tempfile, compfile : TFilestream;
    //thetime : TTimestamp;
    cc : string;
    //bx : byte;
begin
         DecimalSeparator := '.';
        // transform upside-down
        ir.Ypos := pageheight - ir.ypos;
        ir.ypos := ir.ypos + VertAdjust;
        if ir.itemtype = IT_NEWPAGE then
        begin
            FinishPage;
            StartPage;
            exit;
        end;
        if ir.itemtype = IT_TEXT then
        begin
           // stuff escapes THEN brackets
           tstr := string(ir.FText);
           tstr := stringreplace( tstr, '\', '\\', [rfReplaceAll] );
           tstr := stringreplace( tstr, '(', '\(', [rfReplaceAll] );
           tstr := stringreplace( tstr, ')', '\)', [rfReplaceAll] );
           tfname := string(ir.fontname);
           tfname := stringreplace( tfname, ' ', '-', [rfReplaceAll] );
           // modify the font name with the deco
           if ir.fbold then
               tfname := tfname + ', bold';
           if ir.fitalic then
               tfname := tfname + ', italic';
           fontnum := fontlist.indexof( tfname );
           if fontnum = -1 then
           begin
             fontlist.add( tfname );
             fontnum := fontlist.count-1;
           end;
           // set the color r g b rg
           ptwrite( RGBString(ir.rgbfcolor) + ' rg' );
           currfont := format( 'F%-2.2d', [fontnum ] );
           // output the text rendering instructions
           // try Tm instead of Td
           ptwrite( '/' + currfont + format( ' %d Tf', [ir.fontsize]));
           ptwrite( format( ' 1 0 0 1 %d %d Tm (%s) Tj',
                       [ trunc(ir.xpos), trunc(ir.ypos), tstr]));
        end; // text items
        if ir.itemtype = IT_GRAPHIC then
        begin
             case ir.shape of
              S_BOX: // 0
              begin
                  GRWrite( format( '%f w',[ir.thickness]));
                  tstr := format( '%d %d %d %d re ',
                            [ trunc(ir.xpos),trunc(ir.ypos-ir.height),
                              trunc(ir.width),trunc(ir.height)]);
                  if ir.filled then
                  begin
                     GRWrite( RGBString(ir.rgbfcolor) + ' rg' );
                     tstr := tstr + 'f'
                  end
                  else
                  begin
                     GRWrite( RGBString(ir.rgbstrokecolor) + ' RG' );
                     tstr := tstr + 's'
                  end;
                  GRWrite( tstr );
              end;
              S_CIRCLE :  // 1
              begin
                  GRWrite( format( '%2.0f w',[ir.thickness]));
                  GRWrite( RGBString(ir.rgbstrokecolor) + ' RG' );
                  XRadius := ir.Width / 2;
                  YRadius := ir.Height / 2;
                  GRWrite(format( '%6.1f ', [ir.xpos + XRadius]) + format('%6.1f',[ir.ypos]) + ' m');
                  GRWrite(PDFArcTo(ir.xpos + XRadius, ir.ypos, ir.xpos + ir.Width,
                                                         ir.ypos - YRadius, XRadius, YRadius));
                  GRWrite(PDFArcTo(ir.xpos + ir.Width, ir.ypos - YRadius,
                                       ir.xpos + XRadius, ir.ypos - ir.Height, XRadius, YRadius));
                  GRWrite(PDFArcTo(ir.xpos + XRadius, ir.ypos - ir.Height, ir.xpos,
                                                           ir.ypos - YRadius, XRadius, YRadius));
                  GRWrite(PDFArcTo(ir.xpos, ir.ypos - YRadius, ir.xpos + XRadius,
                                                           ir.ypos, XRadius, YRadius) + ' s');
              end;
              S_HLINE: // 2
              begin
                  GRWrite( format( '%2.0f w',[ir.thickness]));
                  GRWrite( RGBString(ir.rgbstrokecolor) + ' RG');// stroke colour
                  tstr := format( '%d %d m %d %d l s',
                            [ trunc(ir.xpos),trunc(ir.ypos-(ir.height / 2)),
                              trunc(ir.xpos+ir.width),trunc(ir.ypos-(ir.height / 2))]);
                  GRWrite( tstr );
              end;
              S_VLINE: // 3
              begin
                  GRWrite( format( '%2.0f w',[ir.thickness]));
                  GRWrite( RGBString(ir.rgbstrokecolor) + ' RG');// stroke colour
                  tstr := format( '%d %d m %d %d l s',
                            [ trunc(ir.xpos+(ir.width/2)),trunc(ir.ypos-ir.height),
                              trunc(ir.xpos+(ir.width/2)),trunc(ir.ypos)]);
                  GRWrite( trim(tstr) );
              end;
              S_OBLIQUE: // 4
              begin
                  GRWrite( format( '%f w',[ir.thickness]));
                  GRWrite( RGBString(ir.rgbstrokecolor) + ' RG' );// stroke colour
                  tstr := format( '%d %d m %d %d l s',
                            [ trunc(ir.xpos),trunc(ir.ypos),
                              trunc(ir.xpos+ir.width),trunc(ir.ypos-ir.height)]);
                  GRWrite( tstr );
              end;
              S_TOPBOTTOM: // 4
              begin
                  GRWrite( format( '%2.0f w',[ir.thickness]));
                  GRWrite( RGBString(ir.rgbstrokecolor) + ' RG');// stroke colour
                  tstr := format( '%d %d m %d %d l s',
                            [ trunc(ir.xpos),trunc(ir.ypos),
                              trunc(ir.xpos+ir.width),trunc(ir.ypos)]);
                  GRWrite( tstr );
                  tstr := format( '%d %d m %d %d l s',
                            [ trunc(ir.xpos),trunc(ir.ypos-ir.height),
                              trunc(ir.xpos+ir.width),trunc(ir.ypos-ir.height)]);
                  GRWrite( tstr );
              end;
              S_LEFTRIGHT: // 4
              begin
                  GRWrite( format( '%2.0f w',[ir.thickness]));
                  GRWrite( RGBString(ir.rgbstrokecolor) + ' RG');// stroke colour
                  tstr := format( '%d %d m %d %d l s',
                            [ trunc(ir.xpos),trunc(ir.ypos-ir.height),
                              trunc(ir.xpos),trunc(ir.ypos)]);
                  GRWrite( trim(tstr) );
                  tstr := format( '%d %d m %d %d l s',
                            [ trunc(ir.xpos+ir.width),trunc(ir.ypos-ir.height),
                              trunc(ir.xpos+ir.width),trunc(ir.ypos)]);
                  GRWrite( trim(tstr) );
              end;
             end;
        end;
        if ir.itemtype = IT_IMAGE then
        begin
            GRWrite( format('q %d 0 0 %d %d %d cm',
                                      [ trunc(ir.width*ir.xscale), trunc( ir.height*ir.yscale ),
                                        trunc(ir.xpos), trunc(ir.ypos) ]));
            GRWrite( 'BI' );
            GRWrite( format( '/Width %d', [ir.pixelwidth]) );
            GRWrite( format( '/Height %d', [ir.pixelheight]) );
            GRWrite( '/BitsPerComponent 8' );
            GRWrite( '/ColorSpace /DeviceRGB' );
            if CompressionOn then
                GRWrite( '/Filter [/ASCIIHexDecode /RunLengthDecode]' )
            else
                GRWrite( '/Filter [/ASCIIHexDecode]' );
            GRWrite( 'ID' );
            GRWrite( ir.imagestring); // the image is asciihex in this string
            cc := '>';
            GRWrite( cc );
            GRWrite( 'EI' );
            GRWrite( 'Q' );
        end;
        DecimalSeparator := OldSeparator;
end;

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

// Exported : add image
procedure AddImageItem( ItemRec : TPDFItemRec; imgdata : pointer );
begin
    if not MadeFirstPageFiles then StartPage;
    itemrec.ypos := ItemRec.Ypos+topmargin+adjusttm;
    itemrec.Xpos := itemrec.Xpos + adjustlm;
    ProcessItem( itemrec, itemrec.imagesrc );
end;

// Exported procedure - receive item data
procedure AddPDFItem( ItemRec : TPDFItemRec );
begin
    if not MadeFirstPageFiles then StartPage;
    itemrec.ypos := ItemRec.Ypos+topmargin+adjusttm;
    itemrec.Xpos := itemrec.Xpos + adjustlm;
    ProcessItem( itemrec, itemrec.imagesrc );
end;


//======================= Filters ===========================
// this code has not been tested. See QRPDFFilt.pas for working RLE
procedure ASCII85(Source, Target: TStream; soffset : longint);
var
  Bytes: Integer;
  I: Integer;
  Total: Cardinal;
  InBuffer: array[0..3] of Byte;
  OutBuffer: array[0..4] of Byte;
begin

  Source.Position := soffset;
  Target.Position := 0;

  while Source.Position < Source.Size do begin

    for I := 0 to High(InBuffer) do begin
      InBuffer[I] := 0;
    end;

    for I := 0 to High(OutBuffer) do begin
      OutBuffer[I] := 0;
    end;

    Bytes := Source.Read(InBuffer, 4);

    Total := 0;
    for I := 0 to High(InBuffer) do begin
      Total := Total + (InBuffer[I] * Trunc(IntPower(256, 3 - I)));
    end;

    if (Total = 0) and (Bytes = 4) then begin
       OutBuffer[0] := 122;
       Target.Write(OutBuffer, 1);
    end else begin
       for I := 0 to High(OutBuffer) do begin
         OutBuffer[I] := Trunc(Total / IntPower(85, 4 - I));
         Total := Total - (OutBuffer[I] * Trunc(IntPower(85, 4 - I)));
         OutBuffer[I] := OutBuffer[I] + 33;
       end;
       Target.Write(OutBuffer, Bytes + 1);
    end;

  end;

  OutBuffer[0] := Ord('~');
  OutBuffer[1] := Ord('>');
  Target.Write(OutBuffer, 2);

  Source.Position := 0;
  Target.Position := 0;

end;


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

procedure HEXImage( ffi : string );
begin
end;

function RGBString( acol : TRGBColor ) : string;
begin
   result := trim(format( '%4.2f %4.2f %4.2f', [ acol.red/255.0,
                                             acol.green/255.0,
                                             acol.blue/255.0 ] ));
end;

function Isdigit( c : char ) : boolean;
begin
  result := (c>='0' ) and (c<='9');
end;

function IsNumber( s : string ) : boolean;
var
   k : integer;
begin
    result := false;
    for k := 1 to length(s) do
      if not isdigit( s[k]) then
          exit;
    result := true;
end;

function Pad10( s : string ) : string;
begin
    result := copy( '0000000000', 1, 10-length(s)) + s;
end;
// see AD chapter 10. 'Bezier curves' 
function PDFArcTo(X1, Y1, X2, Y2, XRadius, YRadius: Extended): String;
var
  C : array[1..6] of Extended;
  I : Integer;
  W, Y : Extended;
begin
  Result := '';
  C[5] := X2;
  C[6] := Y2;
  W := XRadius * 0.55229;
  Y := YRadius * 0.55229;

  if X2 > X1 then begin
     if Y2 > Y1 then begin
        C[1] := X1;
        C[2] := Y1 + Y;
        C[3] := X2 - W;
        C[4] := Y2;
     end else begin
        C[1] := X1 + W;
        C[2] := Y1;
        C[3] := X2;
        C[4] := Y2 + Y;
     end;
  end else begin
     if Y2 > Y1 then begin
        C[1] := X1 - W;
        C[2] := Y1;
        C[3] := X2;
        C[4] := Y2 - Y;
     end else begin
        C[1] := X1;
        C[2] := Y1 - Y;
        C[3] := X2 + W;
        C[4] := Y2;
     end;
  end;

  for I := 1 to 6 do begin
    Result := Result + Format(' %6.1f', [C[I]]) + ' ';
  end;
  Result := trim(Result) + ' c';
end;
// only suitable for numbers because of the Trims
procedure SplitString( ss : string; sep : char; var aList : TStringlist );
var
    k : integer;
    defstr, tstr : string;
begin
      defstr := ss;
      aList.Clear;
      while length( defstr) > 0 do
      begin
         k := pos( sep, defstr );
         if k = 0 then
         begin
               if length( defstr) > 0 then
                           alist.add(trim(defstr));
               defstr := '';
         end
         else
         begin
              tstr := trim(copy( defstr, 1, k-1));
              if tstr <> '' then
                  alist.add(tstr);
              defstr := copy( defstr, k+1, 65536 );
         end;
      end;
end;

// TDictionary
procedure TDictionary.clear;
begin
    keys.clear;
    values.clear;
end;

function TDictionary.Key(index : integer) : string;
begin
   result := keys[index];
end;

function TDictionary.GetCount : integer;
begin
   result := keys.count;
end;

procedure TDictionary.Add( key, value : string );
begin
    keys.add( key);
    values.add(value);
end;

function TDictionary.KeyExists( key : string ) : boolean;
begin
     result := keys.indexof( key) >= 0;
end;

function TDictionary.Value( key : string ) : string;
var
   p : integer;
begin
     p := keys.indexof( key);
     if p < 0 then
         result := ''
     else
         result := values[p];
end;

procedure TDictionary.RemoveKey( key : string );
var
   p : integer;
begin
     p := keys.indexof( key);
     if p < 0 then exit;
     values.Delete(p);
     keys.Delete(p);
end;

constructor TDictionary.Create;
begin
    keys := TStringlist.create;
    keys.Duplicates := dupIgnore;
    values := TStringlist.create;
end;
end.

