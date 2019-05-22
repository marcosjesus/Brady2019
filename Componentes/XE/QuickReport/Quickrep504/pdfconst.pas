{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 5.0 for Delphi and C++Builder               ::
  ::                                                         ::
  :: PDFConst - parts of the PDFDocumentfilter.              ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved
  ::                                                         ::
  :: 09/09/2007 added left and right diagonal lines
  }
  
unit pdfconst;

interface

uses
  Classes, Graphics;

type
  UniGlyph = record
    ID: Word;
    Name: string;
  end;
  //TDictionary, TRGBColor, TPDFItemRec is here because
  //we do not want to appear it in the interface part of QRPDFFilt
  TDictionary = class
   private
    //FCount: Integer;
    function GetCount : Integer;
  protected
    Keys,
    Values: TStringList;
  public
    procedure Add(Key, Value: string);
    procedure Clear;
    function Key(Index: Integer) : string;
    function KeyExists(Key: string) : Boolean;
    function Value(Key: string) : string;
    procedure RemoveKey(Key: string);
    constructor Create;
    destructor Destroy;override;
  //published
    property Count : Integer read GetCount;
  end;
  TRGBColor = packed record //DO NOT CHANGE AT ALL!!!
    Red, Green, Blue: Byte;
  end;
  TPDFItemType = (IT_INVALID, IT_TEXT, IT_NEWPAGE, IT_GRAPHIC, IT_IMAGE );
  TPDFShapeType = (S_BOX, S_CIRCLE, S_HLINE, S_VLINE, S_OBLIQUE, S_TOPBOTTOM,
                   S_LEFTRIGHT, S_RIGHTDIAG, S_LEFTDIAG );

  TPDFItemRec = record
    ItemType: TPDFItemType;
    XPos, YPos: Extended;
    FontName, FText: string;
    FontCharset: TFontCharset;
    FontSize: Integer;
    FColor: PChar;
    fbold, fItalic: Boolean;
    FAlignment: Byte;
    // extra for graphic item
    Filled, staticimage: Boolean;
    Width, Height, thickness, xscale, yscale: Extended;
    //ImageData: utf8string;
    imgstr : TmemoryStream;
    ImageFilter: string;
    Shape: TPDFShapeType;
    pixelWidth, pixelHeight: Integer;
    RGBStrokeColor: TRGBColor;
    RGBFColor: TRGBColor;
  end;



const
  UniGlyphs : array [0..1050] of UniGlyph = (
    (
      ID: $0041; Name: 'A'),
    (
      ID: $00C6; Name: 'AE'),
    (
      ID: $01FC; Name: 'AEacute'),
    (
      ID: $F7E6; Name: 'AEsmall'),
    (
      ID: $00C1; Name: 'Aacute'),
    (
      ID: $F7E1; Name: 'Aacutesmall'),
    (
      ID: $0102; Name: 'Abreve'),
    (
      ID: $00C2; Name: 'Acircumflex'),
    (
      ID: $F7E2; Name: 'Acircumflexsmall'),
    (
      ID: $F6C9; Name: 'Acute'),
    (
      ID: $F7B4; Name: 'Acutesmall'),
    (
      ID: $00C4; Name: 'Adieresis'),
    (
      ID: $F7E4; Name: 'Adieresissmall'),
    (
      ID: $00C0; Name: 'Agrave'),
    (
      ID: $F7E0; Name: 'Agravesmall'),
    (
      ID: $0391; Name: 'Alpha'),
    (
      ID: $0386; Name: 'Alphatonos'),
    (
      ID: $0100; Name: 'Amacron'),
    (
      ID: $0104; Name: 'Aogonek'),
    (
      ID: $00C5; Name: 'Aring'),
    (
      ID: $01FA; Name: 'Aringacute'),
    (
      ID: $F7E5; Name: 'Aringsmall'),
    (
      ID: $F761; Name: 'Asmall'),
    (
      ID: $00C3; Name: 'Atilde'),
    (
      ID: $F7E3; Name: 'Atildesmall'),
    (
      ID: $0042; Name: 'B'),
    (
      ID: $0392; Name: 'Beta'),
    (
      ID: $F6F4; Name: 'Brevesmall'),
    (
      ID: $F762; Name: 'Bsmall'),
    (
      ID: $0043; Name: 'C'),
    (
      ID: $0106; Name: 'Cacute'),
    (
      ID: $F6CA; Name: 'Caron'),
    (
      ID: $F6F5; Name: 'Caronsmall'),
    (
      ID: $010C; Name: 'Ccaron'),
    (
      ID: $00C7; Name: 'Ccedilla'),
    (
      ID: $F7E7; Name: 'Ccedillasmall'),
    (
      ID: $0108; Name: 'Ccircumflex'),
    (
      ID: $010A; Name: 'Cdotaccent'),
    (
      ID: $F7B8; Name: 'Cedillasmall'),
    (
      ID: $03A7; Name: 'Chi'),
    (
      ID: $F6F6; Name: 'Circumflexsmall'),
    (
      ID: $F763; Name: 'Csmall'),
    (
      ID: $0044; Name: 'D'),
    (
      ID: $010E; Name: 'Dcaron'),
    (
      ID: $0110; Name: 'Dcroat'),
    (
      ID: $2206; Name: 'Delta'),
    (
      ID: $0394; Name: 'Delta'),
    (
      ID: $F6CB; Name: 'Dieresis'),
    (
      ID: $F6CC; Name: 'DieresisAcute'),
    (
      ID: $F6CD; Name: 'DieresisGrave'),
    (
      ID: $F7A8; Name: 'Dieresissmall'),
    (
      ID: $F6F7; Name: 'Dotaccentsmall'),
    (
      ID: $F764; Name: 'Dsmall'),
    (
      ID: $0045; Name: 'E'),
    (
      ID: $00C9; Name: 'Eacute'),
    (
      ID: $F7E9; Name: 'Eacutesmall'),
    (
      ID: $0114; Name: 'Ebreve'),
    (
      ID: $011A; Name: 'Ecaron'),
    (
      ID: $00CA; Name: 'Ecircumflex'),
    (
      ID: $F7EA; Name: 'Ecircumflexsmall'),
    (
      ID: $00CB; Name: 'Edieresis'),
    (
      ID: $F7EB; Name: 'Edieresissmall'),
    (
      ID: $0116; Name: 'Edotaccent'),
    (
      ID: $00C8; Name: 'Egrave'),
    (
      ID: $F7E8; Name: 'Egravesmall'),
    (
      ID: $0112; Name: 'Emacron'),
    (
      ID: $014A; Name: 'Eng'),
    (
      ID: $0118; Name: 'Eogonek'),
    (
      ID: $0395; Name: 'Epsilon'),
    (
      ID: $0388; Name: 'Epsilontonos'),
    (
      ID: $F765; Name: 'Esmall'),
    (
      ID: $0397; Name: 'Eta'),
    (
      ID: $0389; Name: 'Etatonos'),
    (
      ID: $00D0; Name: 'Eth'),
    (
      ID: $F7F0; Name: 'Ethsmall'),
    (
      ID: $20AC; Name: 'Euro'),
    (
      ID: $0046; Name: 'F'),
    (
      ID: $F766; Name: 'Fsmall'),
    (
      ID: $0047; Name: 'G'),
    (
      ID: $0393; Name: 'Gamma'),
    (
      ID: $011E; Name: 'Gbreve'),
    (
      ID: $01E6; Name: 'Gcaron'),
    (
      ID: $011C; Name: 'Gcircumflex'),
    (
      ID: $0122; Name: 'Gcommaaccent'),
    (
      ID: $0120; Name: 'Gdotaccent'),
    (
      ID: $F6CE; Name: 'Grave'),
    (
      ID: $F760; Name: 'Gravesmall'),
    (
      ID: $F767; Name: 'Gsmall'),
    (
      ID: $0048; Name: 'H'),
    (
      ID: $25CF; Name: 'H18533'),
    (
      ID: $25AA; Name: 'H18543'),
    (
      ID: $25AB; Name: 'H18551'),
    (
      ID: $25A1; Name: 'H22073'),
    (
      ID: $0126; Name: 'Hbar'),
    (
      ID: $0124; Name: 'Hcircumflex'),
    (
      ID: $F768; Name: 'Hsmall'),
    (
      ID: $F6CF; Name: 'Hungarumlaut'),
    (
      ID: $F6F8; Name: 'Hungarumlautsmall'),
    (
      ID: $0049; Name: 'I'),
    (
      ID: $0132; Name: 'IJ'),
    (
      ID: $00CD; Name: 'Iacute'),
    (
      ID: $F7ED; Name: 'Iacutesmall'),
    (
      ID: $012C; Name: 'Ibreve'),
    (
      ID: $00CE; Name: 'Icircumflex'),
    (
      ID: $F7EE; Name: 'Icircumflexsmall'),
    (
      ID: $00CF; Name: 'Idieresis'),
    (
      ID: $F7EF; Name: 'Idieresissmall'),
    (
      ID: $0130; Name: 'Idotaccent'),
    (
      ID: $2111; Name: 'Ifraktur'),
    (
      ID: $00CC; Name: 'Igrave'),
    (
      ID: $F7EC; Name: 'Igravesmall'),
    (
      ID: $012A; Name: 'Imacron'),
    (
      ID: $012E; Name: 'Iogonek'),
    (
      ID: $0399; Name: 'Iota'),
    (
      ID: $03AA; Name: 'Iotadieresis'),
    (
      ID: $038A; Name: 'Iotatonos'),
    (
      ID: $F769; Name: 'Ismall'),
    (
      ID: $0128; Name: 'Itilde'),
    (
      ID: $004A; Name: 'J'),
    (
      ID: $0134; Name: 'Jcircumflex'),
    (
      ID: $F76A; Name: 'Jsmall'),
    (
      ID: $004B; Name: 'K'),
    (
      ID: $039A; Name: 'Kappa'),
    (
      ID: $0136; Name: 'Kcommaaccent'),
    (
      ID: $F76B; Name: 'Ksmall'),
    (
      ID: $004C; Name: 'L'),
    (
      ID: $F6BF; Name: 'LL'),
    (
      ID: $0139; Name: 'Lacute'),
    (
      ID: $039B; Name: 'Lambda'),
    (
      ID: $013D; Name: 'Lcaron'),
    (
      ID: $013B; Name: 'Lcommaaccent'),
    (
      ID: $013F; Name: 'Ldot'),
    (
      ID: $0141; Name: 'Lslash'),
    (
      ID: $F6F9; Name: 'Lslashsmall'),
    (
      ID: $F76C; Name: 'Lsmall'),
    (
      ID: $004D; Name: 'M'),
    (
      ID: $F6D0; Name: 'Macron'),
    (
      ID: $F7AF; Name: 'Macronsmall'),
    (
      ID: $F76D; Name: 'Msmall'),
    (
      ID: $039C; Name: 'Mu'),
    (
      ID: $004E; Name: 'N'),
    (
      ID: $0143; Name: 'Nacute'),
    (
      ID: $0147; Name: 'Ncaron'),
    (
      ID: $0145; Name: 'Ncommaaccent'),
    (
      ID: $F76E; Name: 'Nsmall'),
    (
      ID: $00D1; Name: 'Ntilde'),
    (
      ID: $F7F1; Name: 'Ntildesmall'),
    (
      ID: $039D; Name: 'Nu'),
    (
      ID: $004F; Name: 'O'),
    (
      ID: $0152; Name: 'OE'),
    (
      ID: $F6FA; Name: 'OEsmall'),
    (
      ID: $00D3; Name: 'Oacute'),
    (
      ID: $F7F3; Name: 'Oacutesmall'),
    (
      ID: $014E; Name: 'Obreve'),
    (
      ID: $00D4; Name: 'Ocircumflex'),
    (
      ID: $F7F4; Name: 'Ocircumflexsmall'),
    (
      ID: $00D6; Name: 'Odieresis'),
    (
      ID: $F7F6; Name: 'Odieresissmall'),
    (
      ID: $F6FB; Name: 'Ogoneksmall'),
    (
      ID: $00D2; Name: 'Ograve'),
    (
      ID: $F7F2; Name: 'Ogravesmall'),
    (
      ID: $01A0; Name: 'Ohorn'),
    (
      ID: $0150; Name: 'Ohungarumlaut'),
    (
      ID: $014C; Name: 'Omacron'),
    (
      ID: $2126; Name: 'Omega'),
    (
      ID: $03A9; Name: 'Omega'),
    (
      ID: $038F; Name: 'Omegatonos'),
    (
      ID: $039F; Name: 'Omicron'),
    (
      ID: $038C; Name: 'Omicrontonos'),
    (
      ID: $00D8; Name: 'Oslash'),
    (
      ID: $01FE; Name: 'Oslashacute'),
    (
      ID: $F7F8; Name: 'Oslashsmall'),
    (
      ID: $F76F; Name: 'Osmall'),
    (
      ID: $00D5; Name: 'Otilde'),
    (
      ID: $F7F5; Name: 'Otildesmall'),
    (
      ID: $0050; Name: 'P'),
    (
      ID: $03A6; Name: 'Phi'),
    (
      ID: $03A0; Name: 'Pi'),
    (
      ID: $03A8; Name: 'Psi'),
    (
      ID: $F770; Name: 'Psmall'),
    (
      ID: $0051; Name: 'Q'),
    (
      ID: $F771; Name: 'Qsmall'),
    (
      ID: $0052; Name: 'R'),
    (
      ID: $0154; Name: 'Racute'),
    (
      ID: $0158; Name: 'Rcaron'),
    (
      ID: $0156; Name: 'Rcommaaccent'),
    (
      ID: $211C; Name: 'Rfraktur'),
    (
      ID: $03A1; Name: 'Rho'),
    (
      ID: $F6FC; Name: 'Ringsmall'),
    (
      ID: $F772; Name: 'Rsmall'),
    (
      ID: $0053; Name: 'S'),
    (
      ID: $250C; Name: 'SF010000'),
    (
      ID: $2514; Name: 'SF020000'),
    (
      ID: $2510; Name: 'SF030000'),
    (
      ID: $2518; Name: 'SF040000'),
    (
      ID: $253C; Name: 'SF050000'),
    (
      ID: $252C; Name: 'SF060000'),
    (
      ID: $2534; Name: 'SF070000'),
    (
      ID: $251C; Name: 'SF080000'),
    (
      ID: $2524; Name: 'SF090000'),
    (
      ID: $2500; Name: 'SF100000'),
    (
      ID: $2502; Name: 'SF110000'),
    (
      ID: $2561; Name: 'SF190000'),
    (
      ID: $2562; Name: 'SF200000'),
    (
      ID: $2556; Name: 'SF210000'),
    (
      ID: $2555; Name: 'SF220000'),
    (
      ID: $2563; Name: 'SF230000'),
    (
      ID: $2551; Name: 'SF240000'),
    (
      ID: $2557; Name: 'SF250000'),
    (
      ID: $255D; Name: 'SF260000'),
    (
      ID: $255C; Name: 'SF270000'),
    (
      ID: $255B; Name: 'SF280000'),
    (
      ID: $255E; Name: 'SF360000'),
    (
      ID: $255F; Name: 'SF370000'),
    (
      ID: $255A; Name: 'SF380000'),
    (
      ID: $2554; Name: 'SF390000'),
    (
      ID: $2569; Name: 'SF400000'),
    (
      ID: $2566; Name: 'SF410000'),
    (
      ID: $2560; Name: 'SF420000'),
    (
      ID: $2550; Name: 'SF430000'),
    (
      ID: $256C; Name: 'SF440000'),
    (
      ID: $2567; Name: 'SF450000'),
    (
      ID: $2568; Name: 'SF460000'),
    (
      ID: $2564; Name: 'SF470000'),
    (
      ID: $2565; Name: 'SF480000'),
    (
      ID: $2559; Name: 'SF490000'),
    (
      ID: $2558; Name: 'SF500000'),
    (
      ID: $2552; Name: 'SF510000'),
    (
      ID: $2553; Name: 'SF520000'),
    (
      ID: $256B; Name: 'SF530000'),
    (
      ID: $256A; Name: 'SF540000'),
    (
      ID: $015A; Name: 'Sacute'),
    (
      ID: $0160; Name: 'Scaron'),
    (
      ID: $F6FD; Name: 'Scaronsmall'),
    (
      ID: $015E; Name: 'Scedilla'),
    (
      ID: $F6C1; Name: 'Scedilla'),
    (
      ID: $015C; Name: 'Scircumflex'),
    (
      ID: $0218; Name: 'Scommaaccent'),
    (
      ID: $03A3; Name: 'Sigma'),
    (
      ID: $F773; Name: 'Ssmall'),
    (
      ID: $0054; Name: 'T'),
    (
      ID: $03A4; Name: 'Tau'),
    (
      ID: $0166; Name: 'Tbar'),
    (
      ID: $0164; Name: 'Tcaron'),
    (
      ID: $0162; Name: 'Tcommaaccent'),
    (
      ID: $021A; Name: 'Tcommaaccent'),
    (
      ID: $0398; Name: 'Theta'),
    (
      ID: $00DE; Name: 'Thorn'),
    (
      ID: $F7FE; Name: 'Thornsmall'),
    (
      ID: $F6FE; Name: 'Tildesmall'),
    (
      ID: $F774; Name: 'Tsmall'),
    (
      ID: $0055; Name: 'U'),
    (
      ID: $00DA; Name: 'Uacute'),
    (
      ID: $F7FA; Name: 'Uacutesmall'),
    (
      ID: $016C; Name: 'Ubreve'),
    (
      ID: $00DB; Name: 'Ucircumflex'),
    (
      ID: $F7FB; Name: 'Ucircumflexsmall'),
    (
      ID: $00DC; Name: 'Udieresis'),
    (
      ID: $F7FC; Name: 'Udieresissmall'),
    (
      ID: $00D9; Name: 'Ugrave'),
    (
      ID: $F7F9; Name: 'Ugravesmall'),
    (
      ID: $01AF; Name: 'Uhorn'),
    (
      ID: $0170; Name: 'Uhungarumlaut'),
    (
      ID: $016A; Name: 'Umacron'),
    (
      ID: $0172; Name: 'Uogonek'),
    (
      ID: $03A5; Name: 'Upsilon'),
    (
      ID: $03D2; Name: 'Upsilon1'),
    (
      ID: $03AB; Name: 'Upsilondieresis'),
    (
      ID: $038E; Name: 'Upsilontonos'),
    (
      ID: $016E; Name: 'Uring'),
    (
      ID: $F775; Name: 'Usmall'),
    (
      ID: $0168; Name: 'Utilde'),
    (
      ID: $0056; Name: 'V'),
    (
      ID: $F776; Name: 'Vsmall'),
    (
      ID: $0057; Name: 'W'),
    (
      ID: $1E82; Name: 'Wacute'),
    (
      ID: $0174; Name: 'Wcircumflex'),
    (
      ID: $1E84; Name: 'Wdieresis'),
    (
      ID: $1E80; Name: 'Wgrave'),
    (
      ID: $F777; Name: 'Wsmall'),
    (
      ID: $0058; Name: 'X'),
    (
      ID: $039E; Name: 'Xi'),
    (
      ID: $F778; Name: 'Xsmall'),
    (
      ID: $0059; Name: 'Y'),
    (
      ID: $00DD; Name: 'Yacute'),
    (
      ID: $F7FD; Name: 'Yacutesmall'),
    (
      ID: $0176; Name: 'Ycircumflex'),
    (
      ID: $0178; Name: 'Ydieresis'),
    (
      ID: $F7FF; Name: 'Ydieresissmall'),
    (
      ID: $1EF2; Name: 'Ygrave'),
    (
      ID: $F779; Name: 'Ysmall'),
    (
      ID: $005A; Name: 'Z'),
    (
      ID: $0179; Name: 'Zacute'),
    (
      ID: $017D; Name: 'Zcaron'),
    (
      ID: $F6FF; Name: 'Zcaronsmall'),
    (
      ID: $017B; Name: 'Zdotaccent'),
    (
      ID: $0396; Name: 'Zeta'),
    (
      ID: $F77A; Name: 'Zsmall'),
    (
      ID: $0061; Name: 'a'),
    (
      ID: $00E1; Name: 'aacute'),
    (
      ID: $0103; Name: 'abreve'),
    (
      ID: $00E2; Name: 'acircumflex'),
    (
      ID: $00B4; Name: 'acute'),
    (
      ID: $0301; Name: 'acutecomb'),
    (
      ID: $00E4; Name: 'adieresis'),
    (
      ID: $00E6; Name: 'ae'),
    (
      ID: $01FD; Name: 'aeacute'),
    (
      ID: $2015; Name: 'afii00208'),
    (
      ID: $0410; Name: 'afii10017'),
    (
      ID: $0411; Name: 'afii10018'),
    (
      ID: $0412; Name: 'afii10019'),
    (
      ID: $0413; Name: 'afii10020'),
    (
      ID: $0414; Name: 'afii10021'),
    (
      ID: $0415; Name: 'afii10022'),
    (
      ID: $0401; Name: 'afii10023'),
    (
      ID: $0416; Name: 'afii10024'),
    (
      ID: $0417; Name: 'afii10025'),
    (
      ID: $0418; Name: 'afii10026'),
    (
      ID: $0419; Name: 'afii10027'),
    (
      ID: $041A; Name: 'afii10028'),
    (
      ID: $041B; Name: 'afii10029'),
    (
      ID: $041C; Name: 'afii10030'),
    (
      ID: $041D; Name: 'afii10031'),
    (
      ID: $041E; Name: 'afii10032'),
    (
      ID: $041F; Name: 'afii10033'),
    (
      ID: $0420; Name: 'afii10034'),
    (
      ID: $0421; Name: 'afii10035'),
    (
      ID: $0422; Name: 'afii10036'),
    (
      ID: $0423; Name: 'afii10037'),
    (
      ID: $0424; Name: 'afii10038'),
    (
      ID: $0425; Name: 'afii10039'),
    (
      ID: $0426; Name: 'afii10040'),
    (
      ID: $0427; Name: 'afii10041'),
    (
      ID: $0428; Name: 'afii10042'),
    (
      ID: $0429; Name: 'afii10043'),
    (
      ID: $042A; Name: 'afii10044'),
    (
      ID: $042B; Name: 'afii10045'),
    (
      ID: $042C; Name: 'afii10046'),
    (
      ID: $042D; Name: 'afii10047'),
    (
      ID: $042E; Name: 'afii10048'),
    (
      ID: $042F; Name: 'afii10049'),
    (
      ID: $0490; Name: 'afii10050'),
    (
      ID: $0402; Name: 'afii10051'),
    (
      ID: $0403; Name: 'afii10052'),
    (
      ID: $0404; Name: 'afii10053'),
    (
      ID: $0405; Name: 'afii10054'),
    (
      ID: $0406; Name: 'afii10055'),
    (
      ID: $0407; Name: 'afii10056'),
    (
      ID: $0408; Name: 'afii10057'),
    (
      ID: $0409; Name: 'afii10058'),
    (
      ID: $040A; Name: 'afii10059'),
    (
      ID: $040B; Name: 'afii10060'),
    (
      ID: $040C; Name: 'afii10061'),
    (
      ID: $040E; Name: 'afii10062'),
    (
      ID: $F6C4; Name: 'afii10063'),
    (
      ID: $F6C5; Name: 'afii10064'),
    (
      ID: $0430; Name: 'afii10065'),
    (
      ID: $0431; Name: 'afii10066'),
    (
      ID: $0432; Name: 'afii10067'),
    (
      ID: $0433; Name: 'afii10068'),
    (
      ID: $0434; Name: 'afii10069'),
    (
      ID: $0435; Name: 'afii10070'),
    (
      ID: $0451; Name: 'afii10071'),
    (
      ID: $0436; Name: 'afii10072'),
    (
      ID: $0437; Name: 'afii10073'),
    (
      ID: $0438; Name: 'afii10074'),
    (
      ID: $0439; Name: 'afii10075'),
    (
      ID: $043A; Name: 'afii10076'),
    (
      ID: $043B; Name: 'afii10077'),
    (
      ID: $043C; Name: 'afii10078'),
    (
      ID: $043D; Name: 'afii10079'),
    (
      ID: $043E; Name: 'afii10080'),
    (
      ID: $043F; Name: 'afii10081'),
    (
      ID: $0440; Name: 'afii10082'),
    (
      ID: $0441; Name: 'afii10083'),
    (
      ID: $0442; Name: 'afii10084'),
    (
      ID: $0443; Name: 'afii10085'),
    (
      ID: $0444; Name: 'afii10086'),
    (
      ID: $0445; Name: 'afii10087'),
    (
      ID: $0446; Name: 'afii10088'),
    (
      ID: $0447; Name: 'afii10089'),
    (
      ID: $0448; Name: 'afii10090'),
    (
      ID: $0449; Name: 'afii10091'),
    (
      ID: $044A; Name: 'afii10092'),
    (
      ID: $044B; Name: 'afii10093'),
    (
      ID: $044C; Name: 'afii10094'),
    (
      ID: $044D; Name: 'afii10095'),
    (
      ID: $044E; Name: 'afii10096'),
    (
      ID: $044F; Name: 'afii10097'),
    (
      ID: $0491; Name: 'afii10098'),
    (
      ID: $0452; Name: 'afii10099'),
    (
      ID: $0453; Name: 'afii10100'),
    (
      ID: $0454; Name: 'afii10101'),
    (
      ID: $0455; Name: 'afii10102'),
    (
      ID: $0456; Name: 'afii10103'),
    (
      ID: $0457; Name: 'afii10104'),
    (
      ID: $0458; Name: 'afii10105'),
    (
      ID: $0459; Name: 'afii10106'),
    (
      ID: $045A; Name: 'afii10107'),
    (
      ID: $045B; Name: 'afii10108'),
    (
      ID: $045C; Name: 'afii10109'),
    (
      ID: $045E; Name: 'afii10110'),
    (
      ID: $040F; Name: 'afii10145'),
    (
      ID: $0462; Name: 'afii10146'),
    (
      ID: $0472; Name: 'afii10147'),
    (
      ID: $0474; Name: 'afii10148'),
    (
      ID: $F6C6; Name: 'afii10192'),
    (
      ID: $045F; Name: 'afii10193'),
    (
      ID: $0463; Name: 'afii10194'),
    (
      ID: $0473; Name: 'afii10195'),
    (
      ID: $0475; Name: 'afii10196'),
    (
      ID: $F6C7; Name: 'afii10831'),
    (
      ID: $F6C8; Name: 'afii10832'),
    (
      ID: $04D9; Name: 'afii10846'),
    (
      ID: $200E; Name: 'afii299'),
    (
      ID: $200F; Name: 'afii300'),
    (
      ID: $200D; Name: 'afii301'),
    (
      ID: $066A; Name: 'afii57381'),
    (
      ID: $060C; Name: 'afii57388'),
    (
      ID: $0660; Name: 'afii57392'),
    (
      ID: $0661; Name: 'afii57393'),
    (
      ID: $0662; Name: 'afii57394'),
    (
      ID: $0663; Name: 'afii57395'),
    (
      ID: $0664; Name: 'afii57396'),
    (
      ID: $0665; Name: 'afii57397'),
    (
      ID: $0666; Name: 'afii57398'),
    (
      ID: $0667; Name: 'afii57399'),
    (
      ID: $0668; Name: 'afii57400'),
    (
      ID: $0669; Name: 'afii57401'),
    (
      ID: $061B; Name: 'afii57403'),
    (
      ID: $061F; Name: 'afii57407'),
    (
      ID: $0621; Name: 'afii57409'),
    (
      ID: $0622; Name: 'afii57410'),
    (
      ID: $0623; Name: 'afii57411'),
    (
      ID: $0624; Name: 'afii57412'),
    (
      ID: $0625; Name: 'afii57413'),
    (
      ID: $0626; Name: 'afii57414'),
    (
      ID: $0627; Name: 'afii57415'),
    (
      ID: $0628; Name: 'afii57416'),
    (
      ID: $0629; Name: 'afii57417'),
    (
      ID: $062A; Name: 'afii57418'),
    (
      ID: $062B; Name: 'afii57419'),
    (
      ID: $062C; Name: 'afii57420'),
    (
      ID: $062D; Name: 'afii57421'),
    (
      ID: $062E; Name: 'afii57422'),
    (
      ID: $062F; Name: 'afii57423'),
    (
      ID: $0630; Name: 'afii57424'),
    (
      ID: $0631; Name: 'afii57425'),
    (
      ID: $0632; Name: 'afii57426'),
    (
      ID: $0633; Name: 'afii57427'),
    (
      ID: $0634; Name: 'afii57428'),
    (
      ID: $0635; Name: 'afii57429'),
    (
      ID: $0636; Name: 'afii57430'),
    (
      ID: $0637; Name: 'afii57431'),
    (
      ID: $0638; Name: 'afii57432'),
    (
      ID: $0639; Name: 'afii57433'),
    (
      ID: $063A; Name: 'afii57434'),
    (
      ID: $0640; Name: 'afii57440'),
    (
      ID: $0641; Name: 'afii57441'),
    (
      ID: $0642; Name: 'afii57442'),
    (
      ID: $0643; Name: 'afii57443'),
    (
      ID: $0644; Name: 'afii57444'),
    (
      ID: $0645; Name: 'afii57445'),
    (
      ID: $0646; Name: 'afii57446'),
    (
      ID: $0648; Name: 'afii57448'),
    (
      ID: $0649; Name: 'afii57449'),
    (
      ID: $064A; Name: 'afii57450'),
    (
      ID: $064B; Name: 'afii57451'),
    (
      ID: $064C; Name: 'afii57452'),
    (
      ID: $064D; Name: 'afii57453'),
    (
      ID: $064E; Name: 'afii57454'),
    (
      ID: $064F; Name: 'afii57455'),
    (
      ID: $0650; Name: 'afii57456'),
    (
      ID: $0651; Name: 'afii57457'),
    (
      ID: $0652; Name: 'afii57458'),
    (
      ID: $0647; Name: 'afii57470'),
    (
      ID: $06A4; Name: 'afii57505'),
    (
      ID: $067E; Name: 'afii57506'),
    (
      ID: $0686; Name: 'afii57507'),
    (
      ID: $0698; Name: 'afii57508'),
    (
      ID: $06AF; Name: 'afii57509'),
    (
      ID: $0679; Name: 'afii57511'),
    (
      ID: $0688; Name: 'afii57512'),
    (
      ID: $0691; Name: 'afii57513'),
    (
      ID: $06BA; Name: 'afii57514'),
    (
      ID: $06D2; Name: 'afii57519'),
    (
      ID: $06D5; Name: 'afii57534'),
    (
      ID: $20AA; Name: 'afii57636'),
    (
      ID: $05BE; Name: 'afii57645'),
    (
      ID: $05C3; Name: 'afii57658'),
    (
      ID: $05D0; Name: 'afii57664'),
    (
      ID: $05D1; Name: 'afii57665'),
    (
      ID: $05D2; Name: 'afii57666'),
    (
      ID: $05D3; Name: 'afii57667'),
    (
      ID: $05D4; Name: 'afii57668'),
    (
      ID: $05D5; Name: 'afii57669'),
    (
      ID: $05D6; Name: 'afii57670'),
    (
      ID: $05D7; Name: 'afii57671'),
    (
      ID: $05D8; Name: 'afii57672'),
    (
      ID: $05D9; Name: 'afii57673'),
    (
      ID: $05DA; Name: 'afii57674'),
    (
      ID: $05DB; Name: 'afii57675'),
    (
      ID: $05DC; Name: 'afii57676'),
    (
      ID: $05DD; Name: 'afii57677'),
    (
      ID: $05DE; Name: 'afii57678'),
    (
      ID: $05DF; Name: 'afii57679'),
    (
      ID: $05E0; Name: 'afii57680'),
    (
      ID: $05E1; Name: 'afii57681'),
    (
      ID: $05E2; Name: 'afii57682'),
    (
      ID: $05E3; Name: 'afii57683'),
    (
      ID: $05E4; Name: 'afii57684'),
    (
      ID: $05E5; Name: 'afii57685'),
    (
      ID: $05E6; Name: 'afii57686'),
    (
      ID: $05E7; Name: 'afii57687'),
    (
      ID: $05E8; Name: 'afii57688'),
    (
      ID: $05E9; Name: 'afii57689'),
    (
      ID: $05EA; Name: 'afii57690'),
    (
      ID: $FB2A; Name: 'afii57694'),
    (
      ID: $FB2B; Name: 'afii57695'),
    (
      ID: $FB4B; Name: 'afii57700'),
    (
      ID: $FB1F; Name: 'afii57705'),
    (
      ID: $05F0; Name: 'afii57716'),
    (
      ID: $05F1; Name: 'afii57717'),
    (
      ID: $05F2; Name: 'afii57718'),
    (
      ID: $FB35; Name: 'afii57723'),
    (
      ID: $05B4; Name: 'afii57793'),
    (
      ID: $05B5; Name: 'afii57794'),
    (
      ID: $05B6; Name: 'afii57795'),
    (
      ID: $05BB; Name: 'afii57796'),
    (
      ID: $05B8; Name: 'afii57797'),
    (
      ID: $05B7; Name: 'afii57798'),
    (
      ID: $05B0; Name: 'afii57799'),
    (
      ID: $05B2; Name: 'afii57800'),
    (
      ID: $05B1; Name: 'afii57801'),
    (
      ID: $05B3; Name: 'afii57802'),
    (
      ID: $05C2; Name: 'afii57803'),
    (
      ID: $05C1; Name: 'afii57804'),
    (
      ID: $05B9; Name: 'afii57806'),
    (
      ID: $05BC; Name: 'afii57807'),
    (
      ID: $05BD; Name: 'afii57839'),
    (
      ID: $05BF; Name: 'afii57841'),
    (
      ID: $05C0; Name: 'afii57842'),
    (
      ID: $02BC; Name: 'afii57929'),
    (
      ID: $2105; Name: 'afii61248'),
    (
      ID: $2113; Name: 'afii61289'),
    (
      ID: $2116; Name: 'afii61352'),
    (
      ID: $202C; Name: 'afii61573'),
    (
      ID: $202D; Name: 'afii61574'),
    (
      ID: $202E; Name: 'afii61575'),
    (
      ID: $200C; Name: 'afii61664'),
    (
      ID: $066D; Name: 'afii63167'),
    (
      ID: $02BD; Name: 'afii64937'),
    (
      ID: $00E0; Name: 'agrave'),
    (
      ID: $2135; Name: 'aleph'),
    (
      ID: $03B1; Name: 'alpha'),
    (
      ID: $03AC; Name: 'alphatonos'),
    (
      ID: $0101; Name: 'amacron'),
    (
      ID: $0026; Name: 'ampersand'),
    (
      ID: $F726; Name: 'ampersandsmall'),
    (
      ID: $2220; Name: 'angle'),
    (
      ID: $2329; Name: 'angleleft'),
    (
      ID: $232A; Name: 'angleright'),
    (
      ID: $0387; Name: 'anoteleia'),
    (
      ID: $0105; Name: 'aogonek'),
    (
      ID: $2248; Name: 'approxequal'),
    (
      ID: $00E5; Name: 'aring'),
    (
      ID: $01FB; Name: 'aringacute'),
    (
      ID: $2194; Name: 'arrowboth'),
    (
      ID: $21D4; Name: 'arrowdblboth'),
    (
      ID: $21D3; Name: 'arrowdbldown'),
    (
      ID: $21D0; Name: 'arrowdblleft'),
    (
      ID: $21D2; Name: 'arrowdblright'),
    (
      ID: $21D1; Name: 'arrowdblup'),
    (
      ID: $2193; Name: 'arrowdown'),
    (
      ID: $F8E7; Name: 'arrowhorizex'),
    (
      ID: $2190; Name: 'arrowleft'),
    (
      ID: $2192; Name: 'arrowright'),
    (
      ID: $2191; Name: 'arrowup'),
    (
      ID: $2195; Name: 'arrowupdn'),
    (
      ID: $21A8; Name: 'arrowupdnbse'),
    (
      ID: $F8E6; Name: 'arrowvertex'),
    (
      ID: $005E; Name: 'asciicircum'),
    (
      ID: $007E; Name: 'asciitilde'),
    (
      ID: $002A; Name: 'asterisk'),
    (
      ID: $2217; Name: 'asteriskmath'),
    (
      ID: $F6E9; Name: 'asuperior'),
    (
      ID: $0040; Name: 'at'),
    (
      ID: $00E3; Name: 'atilde'),
    (
      ID: $0062; Name: 'b'),
    (
      ID: $005C; Name: 'backslash'),
    (
      ID: $007C; Name: 'bar'),
    (
      ID: $03B2; Name: 'beta'),
    (
      ID: $2588; Name: 'block'),
    (
      ID: $F8F4; Name: 'braceex'),
    (
      ID: $007B; Name: 'braceleft'),
    (
      ID: $F8F3; Name: 'braceleftbt'),
    (
      ID: $F8F2; Name: 'braceleftmid'),
    (
      ID: $F8F1; Name: 'bracelefttp'),
    (
      ID: $007D; Name: 'braceright'),
    (
      ID: $F8FE; Name: 'bracerightbt'),
    (
      ID: $F8FD; Name: 'bracerightmid'),
    (
      ID: $F8FC; Name: 'bracerighttp'),
    (
      ID: $005B; Name: 'bracketleft'),
    (
      ID: $F8F0; Name: 'bracketleftbt'),
    (
      ID: $F8EF; Name: 'bracketleftex'),
    (
      ID: $F8EE; Name: 'bracketlefttp'),
    (
      ID: $005D; Name: 'bracketright'),
    (
      ID: $F8FB; Name: 'bracketrightbt'),
    (
      ID: $F8FA; Name: 'bracketrightex'),
    (
      ID: $F8F9; Name: 'bracketrighttp'),
    (
      ID: $02D8; Name: 'breve'),
    (
      ID: $00A6; Name: 'brokenbar'),
    (
      ID: $F6EA; Name: 'bsuperior'),
    (
      ID: $2022; Name: 'bullet'),
    (
      ID: $0063; Name: 'c'),
    (
      ID: $0107; Name: 'cacute'),
    (
      ID: $02C7; Name: 'caron'),
    (
      ID: $21B5; Name: 'carriagereturn'),
    (
      ID: $010D; Name: 'ccaron'),
    (
      ID: $00E7; Name: 'ccedilla'),
    (
      ID: $0109; Name: 'ccircumflex'),
    (
      ID: $010B; Name: 'cdotaccent'),
    (
      ID: $00B8; Name: 'cedilla'),
    (
      ID: $00A2; Name: 'cent'),
    (
      ID: $F6DF; Name: 'centinferior'),
    (
      ID: $F7A2; Name: 'centoldstyle'),
    (
      ID: $F6E0; Name: 'centsuperior'),
    (
      ID: $03C7; Name: 'chi'),
    (
      ID: $25CB; Name: 'circle'),
    (
      ID: $2297; Name: 'circlemultiply'),
    (
      ID: $2295; Name: 'circleplus'),
    (
      ID: $02C6; Name: 'circumflex'),
    (
      ID: $2663; Name: 'club'),
    (
      ID: $003A; Name: 'colon'),
    (
      ID: $20A1; Name: 'colonmonetary'),
    (
      ID: $002C; Name: 'comma'),
    (
      ID: $F6C3; Name: 'commaaccent'),
    (
      ID: $F6E1; Name: 'commainferior'),
    (
      ID: $F6E2; Name: 'commasuperior'),
    (
      ID: $2245; Name: 'congruent'),
    (
      ID: $00A9; Name: 'copyright'),
    (
      ID: $F8E9; Name: 'copyrightsans'),
    (
      ID: $F6D9; Name: 'copyrightserif'),
    (
      ID: $00A4; Name: 'currency'),
    (
      ID: $F6D1; Name: 'cyrBreve'),
    (
      ID: $F6D2; Name: 'cyrFlex'),
    (
      ID: $F6D4; Name: 'cyrbreve'),
    (
      ID: $F6D5; Name: 'cyrflex'),
    (
      ID: $0064; Name: 'd'),
    (
      ID: $2020; Name: 'dagger'),
    (
      ID: $2021; Name: 'daggerdbl'),
    (
      ID: $F6D3; Name: 'dblGrave'),
    (
      ID: $F6D6; Name: 'dblgrave'),
    (
      ID: $010F; Name: 'dcaron'),
    (
      ID: $0111; Name: 'dcroat'),
    (
      ID: $00B0; Name: 'degree'),
    (
      ID: $03B4; Name: 'delta'),
    (
      ID: $2666; Name: 'diamond'),
    (
      ID: $00A8; Name: 'dieresis'),
    (
      ID: $F6D7; Name: 'dieresisacute'),
    (
      ID: $F6D8; Name: 'dieresisgrave'),
    (
      ID: $0385; Name: 'dieresistonos'),
    (
      ID: $00F7; Name: 'divide'),
    (
      ID: $2593; Name: 'dkshade'),
    (
      ID: $2584; Name: 'dnblock'),
    (
      ID: $0024; Name: 'dollar'),
    (
      ID: $F6E3; Name: 'dollarinferior'),
    (
      ID: $F724; Name: 'dollaroldstyle'),
    (
      ID: $F6E4; Name: 'dollarsuperior'),
    (
      ID: $20AB; Name: 'dong'),
    (
      ID: $02D9; Name: 'dotaccent'),
    (
      ID: $0323; Name: 'dotbelowcomb'),
    (
      ID: $0131; Name: 'dotlessi'),
    (
      ID: $F6BE; Name: 'dotlessj'),
    (
      ID: $22C5; Name: 'dotmath'),
    (
      ID: $F6EB; Name: 'dsuperior'),
    (
      ID: $0065; Name: 'e'),
    (
      ID: $00E9; Name: 'eacute'),
    (
      ID: $0115; Name: 'ebreve'),
    (
      ID: $011B; Name: 'ecaron'),
    (
      ID: $00EA; Name: 'ecircumflex'),
    (
      ID: $00EB; Name: 'edieresis'),
    (
      ID: $0117; Name: 'edotaccent'),
    (
      ID: $00E8; Name: 'egrave'),
    (
      ID: $0038; Name: 'eight'),
    (
      ID: $2088; Name: 'eightinferior'),
    (
      ID: $F738; Name: 'eightoldstyle'),
    (
      ID: $2078; Name: 'eightsuperior'),
    (
      ID: $2208; Name: 'element'),
    (
      ID: $2026; Name: 'ellipsis'),
    (
      ID: $0113; Name: 'emacron'),
    (
      ID: $2014; Name: 'emdash'),
    (
      ID: $2205; Name: 'emptyset'),
    (
      ID: $2013; Name: 'endash'),
    (
      ID: $014B; Name: 'eng'),
    (
      ID: $0119; Name: 'eogonek'),
    (
      ID: $03B5; Name: 'epsilon'),
    (
      ID: $03AD; Name: 'epsilontonos'),
    (
      ID: $003D; Name: 'equal'),
    (
      ID: $2261; Name: 'equivalence'),
    (
      ID: $212E; Name: 'estimated'),
    (
      ID: $F6EC; Name: 'esuperior'),
    (
      ID: $03B7; Name: 'eta'),
    (
      ID: $03AE; Name: 'etatonos'),
    (
      ID: $00F0; Name: 'eth'),
    (
      ID: $0021; Name: 'exclam'),
    (
      ID: $203C; Name: 'exclamdbl'),
    (
      ID: $00A1; Name: 'exclamdown'),
    (
      ID: $F7A1; Name: 'exclamdownsmall'),
    (
      ID: $F721; Name: 'exclamsmall'),
    (
      ID: $2203; Name: 'existential'),
    (
      ID: $0066; Name: 'f'),
    (
      ID: $2640; Name: 'female'),
    (
      ID: $FB00; Name: 'ff'),
    (
      ID: $FB03; Name: 'ffi'),
    (
      ID: $FB04; Name: 'ffl'),
    (
      ID: $FB01; Name: 'fi'),
    (
      ID: $2012; Name: 'figuredash'),
    (
      ID: $25A0; Name: 'filledbox'),
    (
      ID: $25AC; Name: 'filledrect'),
    (
      ID: $0035; Name: 'five'),
    (
      ID: $215D; Name: 'fiveeighths'),
    (
      ID: $2085; Name: 'fiveinferior'),
    (
      ID: $F735; Name: 'fiveoldstyle'),
    (
      ID: $2075; Name: 'fivesuperior'),
    (
      ID: $FB02; Name: 'fl'),
    (
      ID: $0192; Name: 'florin'),
    (
      ID: $0034; Name: 'four'),
    (
      ID: $2084; Name: 'fourinferior'),
    (
      ID: $F734; Name: 'fouroldstyle'),
    (
      ID: $2074; Name: 'foursuperior'),
    (
      ID: $2044; Name: 'fraction'),
    (
      ID: $2215; Name: 'fraction'),
    (
      ID: $20A3; Name: 'franc'),
    (
      ID: $0067; Name: 'g'),
    (
      ID: $03B3; Name: 'gamma'),
    (
      ID: $011F; Name: 'gbreve'),
    (
      ID: $01E7; Name: 'gcaron'),
    (
      ID: $011D; Name: 'gcircumflex'),
    (
      ID: $0123; Name: 'gcommaaccent'),
    (
      ID: $0121; Name: 'gdotaccent'),
    (
      ID: $00DF; Name: 'germandbls'),
    (
      ID: $2207; Name: 'gradient'),
    (
      ID: $0060; Name: 'grave'),
    (
      ID: $0300; Name: 'gravecomb'),
    (
      ID: $003E; Name: 'greater'),
    (
      ID: $2265; Name: 'greaterequal'),
    (
      ID: $00AB; Name: 'guillemotleft'),
    (
      ID: $00BB; Name: 'guillemotright'),
    (
      ID: $2039; Name: 'guilsinglleft'),
    (
      ID: $203A; Name: 'guilsinglright'),
    (
      ID: $0068; Name: 'h'),
    (
      ID: $0127; Name: 'hbar'),
    (
      ID: $0125; Name: 'hcircumflex'),
    (
      ID: $2665; Name: 'heart'),
    (
      ID: $0309; Name: 'hookabovecomb'),
    (
      ID: $2302; Name: 'house'),
    (
      ID: $02DD; Name: 'hungarumlaut'),
    (
      ID: $002D; Name: 'hyphen'),
    (
      ID: $00AD; Name: 'hyphen'),
    (
      ID: $F6E5; Name: 'hypheninferior'),
    (
      ID: $F6E6; Name: 'hyphensuperior'),
    (
      ID: $0069; Name: 'i'),
    (
      ID: $00ED; Name: 'iacute'),
    (
      ID: $012D; Name: 'ibreve'),
    (
      ID: $00EE; Name: 'icircumflex'),
    (
      ID: $00EF; Name: 'idieresis'),
    (
      ID: $00EC; Name: 'igrave'),
    (
      ID: $0133; Name: 'ij'),
    (
      ID: $012B; Name: 'imacron'),
    (
      ID: $221E; Name: 'infinity'),
    (
      ID: $222B; Name: 'integral'),
    (
      ID: $2321; Name: 'integralbt'),
    (
      ID: $F8F5; Name: 'integralex'),
    (
      ID: $2320; Name: 'integraltp'),
    (
      ID: $2229; Name: 'intersection'),
    (
      ID: $25D8; Name: 'invbullet'),
    (
      ID: $25D9; Name: 'invcircle'),
    (
      ID: $263B; Name: 'invsmileface'),
    (
      ID: $012F; Name: 'iogonek'),
    (
      ID: $03B9; Name: 'iota'),
    (
      ID: $03CA; Name: 'iotadieresis'),
    (
      ID: $0390; Name: 'iotadieresistonos'),
    (
      ID: $03AF; Name: 'iotatonos'),
    (
      ID: $F6ED; Name: 'isuperior'),
    (
      ID: $0129; Name: 'itilde'),
    (
      ID: $006A; Name: 'j'),
    (
      ID: $0135; Name: 'jcircumflex'),
    (
      ID: $006B; Name: 'k'),
    (
      ID: $03BA; Name: 'kappa'),
    (
      ID: $0137; Name: 'kcommaaccent'),
    (
      ID: $0138; Name: 'kgreenlandic'),
    (
      ID: $006C; Name: 'l'),
    (
      ID: $013A; Name: 'lacute'),
    (
      ID: $03BB; Name: 'lambda'),
    (
      ID: $013E; Name: 'lcaron'),
    (
      ID: $013C; Name: 'lcommaaccent'),
    (
      ID: $0140; Name: 'ldot'),
    (
      ID: $003C; Name: 'less'),
    (
      ID: $2264; Name: 'lessequal'),
    (
      ID: $258C; Name: 'lfblock'),
    (
      ID: $20A4; Name: 'lira'),
    (
      ID: $F6C0; Name: 'll'),
    (
      ID: $2227; Name: 'logicaland'),
    (
      ID: $00AC; Name: 'logicalnot'),
    (
      ID: $2228; Name: 'logicalor'),
    (
      ID: $017F; Name: 'longs'),
    (
      ID: $25CA; Name: 'lozenge'),
    (
      ID: $0142; Name: 'lslash'),
    (
      ID: $F6EE; Name: 'lsuperior'),
    (
      ID: $2591; Name: 'ltshade'),
    (
      ID: $006D; Name: 'm'),
    (
      ID: $00AF; Name: 'macron'),
    (
      ID: $02C9; Name: 'macron'),
    (
      ID: $2642; Name: 'male'),
    (
      ID: $2212; Name: 'minus'),
    (
      ID: $2032; Name: 'minute'),
    (
      ID: $F6EF; Name: 'msuperior'),
    (
      ID: $00B5; Name: 'mu'),
    (
      ID: $03BC; Name: 'mu'),
    (
      ID: $00D7; Name: 'multiply'),
    (
      ID: $266A; Name: 'musicalnote'),
    (
      ID: $266B; Name: 'musicalnotedbl'),
    (
      ID: $006E; Name: 'n'),
    (
      ID: $0144; Name: 'nacute'),
    (
      ID: $0149; Name: 'napostrophe'),
    (
      ID: $0148; Name: 'ncaron'),
    (
      ID: $0146; Name: 'ncommaaccent'),
    (
      ID: $0039; Name: 'nine'),
    (
      ID: $2089; Name: 'nineinferior'),
    (
      ID: $F739; Name: 'nineoldstyle'),
    (
      ID: $2079; Name: 'ninesuperior'),
    (
      ID: $2209; Name: 'notelement'),
    (
      ID: $2260; Name: 'notequal'),
    (
      ID: $2284; Name: 'notsubset'),
    (
      ID: $207F; Name: 'nsuperior'),
    (
      ID: $00F1; Name: 'ntilde'),
    (
      ID: $03BD; Name: 'nu'),
    (
      ID: $0023; Name: 'numbersign'),
    (
      ID: $006F; Name: 'o'),
    (
      ID: $00F3; Name: 'oacute'),
    (
      ID: $014F; Name: 'obreve'),
    (
      ID: $00F4; Name: 'ocircumflex'),
    (
      ID: $00F6; Name: 'odieresis'),
    (
      ID: $0153; Name: 'oe'),
    (
      ID: $02DB; Name: 'ogonek'),
    (
      ID: $00F2; Name: 'ograve'),
    (
      ID: $01A1; Name: 'ohorn'),
    (
      ID: $0151; Name: 'ohungarumlaut'),
    (
      ID: $014D; Name: 'omacron'),
    (
      ID: $03C9; Name: 'omega'),
    (
      ID: $03D6; Name: 'omega1'),
    (
      ID: $03CE; Name: 'omegatonos'),
    (
      ID: $03BF; Name: 'omicron'),
    (
      ID: $03CC; Name: 'omicrontonos'),
    (
      ID: $0031; Name: 'one'),
    (
      ID: $2024; Name: 'onedotenleader'),
    (
      ID: $215B; Name: 'oneeighth'),
    (
      ID: $F6DC; Name: 'onefitted'),
    (
      ID: $00BD; Name: 'onehalf'),
    (
      ID: $2081; Name: 'oneinferior'),
    (
      ID: $F731; Name: 'oneoldstyle'),
    (
      ID: $00BC; Name: 'onequarter'),
    (
      ID: $00B9; Name: 'onesuperior'),
    (
      ID: $2153; Name: 'onethird'),
    (
      ID: $25E6; Name: 'openbullet'),
    (
      ID: $00AA; Name: 'ordfeminine'),
    (
      ID: $00BA; Name: 'ordmasculine'),
    (
      ID: $221F; Name: 'orthogonal'),
    (
      ID: $00F8; Name: 'oslash'),
    (
      ID: $01FF; Name: 'oslashacute'),
    (
      ID: $F6F0; Name: 'osuperior'),
    (
      ID: $00F5; Name: 'otilde'),
    (
      ID: $0070; Name: 'p'),
    (
      ID: $00B6; Name: 'paragraph'),
    (
      ID: $0028; Name: 'parenleft'),
    (
      ID: $F8ED; Name: 'parenleftbt'),
    (
      ID: $F8EC; Name: 'parenleftex'),
    (
      ID: $208D; Name: 'parenleftinferior'),
    (
      ID: $207D; Name: 'parenleftsuperior'),
    (
      ID: $F8EB; Name: 'parenlefttp'),
    (
      ID: $0029; Name: 'parenright'),
    (
      ID: $F8F8; Name: 'parenrightbt'),
    (
      ID: $F8F7; Name: 'parenrightex'),
    (
      ID: $208E; Name: 'parenrightinferior'),
    (
      ID: $207E; Name: 'parenrightsuperior'),
    (
      ID: $F8F6; Name: 'parenrighttp'),
    (
      ID: $2202; Name: 'partialdiff'),
    (
      ID: $0025; Name: 'percent'),
    (
      ID: $002E; Name: 'period'),
    (
      ID: $00B7; Name: 'periodcentered'),
    (
      ID: $2219; Name: 'periodcentered'),
    (
      ID: $F6E7; Name: 'periodinferior'),
    (
      ID: $F6E8; Name: 'periodsuperior'),
    (
      ID: $22A5; Name: 'perpendicular'),
    (
      ID: $2030; Name: 'perthousand'),
    (
      ID: $20A7; Name: 'peseta'),
    (
      ID: $03C6; Name: 'phi'),
    (
      ID: $03D5; Name: 'phi1'),
    (
      ID: $03C0; Name: 'pi'),
    (
      ID: $002B; Name: 'plus'),
    (
      ID: $00B1; Name: 'plusminus'),
    (
      ID: $211E; Name: 'prescription'),
    (
      ID: $220F; Name: 'product'),
    (
      ID: $2282; Name: 'propersubset'),
    (
      ID: $2283; Name: 'propersuperset'),
    (
      ID: $221D; Name: 'proportional'),
    (
      ID: $03C8; Name: 'psi'),
    (
      ID: $0071; Name: 'q'),
    (
      ID: $003F; Name: 'question'),
    (
      ID: $00BF; Name: 'questiondown'),
    (
      ID: $F7BF; Name: 'questiondownsmall'),
    (
      ID: $F73F; Name: 'questionsmall'),
    (
      ID: $0022; Name: 'quotedbl'),
    (
      ID: $201E; Name: 'quotedblbase'),
    (
      ID: $201C; Name: 'quotedblleft'),
    (
      ID: $201D; Name: 'quotedblright'),
    (
      ID: $2018; Name: 'quoteleft'),
    (
      ID: $201B; Name: 'quotereversed'),
    (
      ID: $2019; Name: 'quoteright'),
    (
      ID: $201A; Name: 'quotesinglbase'),
    (
      ID: $0027; Name: 'quotesingle'),
    (
      ID: $0072; Name: 'r'),
    (
      ID: $0155; Name: 'racute'),
    (
      ID: $221A; Name: 'radical'),
    (
      ID: $F8E5; Name: 'radicalex'),
    (
      ID: $0159; Name: 'rcaron'),
    (
      ID: $0157; Name: 'rcommaaccent'),
    (
      ID: $2286; Name: 'reflexsubset'),
    (
      ID: $2287; Name: 'reflexsuperset'),
    (
      ID: $00AE; Name: 'registered'),
    (
      ID: $F8E8; Name: 'registersans'),
    (
      ID: $F6DA; Name: 'registerserif'),
    (
      ID: $2310; Name: 'revlogicalnot'),
    (
      ID: $03C1; Name: 'rho'),
    (
      ID: $02DA; Name: 'ring'),
    (
      ID: $F6F1; Name: 'rsuperior'),
    (
      ID: $2590; Name: 'rtblock'),
    (
      ID: $F6DD; Name: 'rupiah'),
    (
      ID: $0073; Name: 's'),
    (
      ID: $015B; Name: 'sacute'),
    (
      ID: $0161; Name: 'scaron'),
    (
      ID: $015F; Name: 'scedilla'),
    (
      ID: $F6C2; Name: 'scedilla'),
    (
      ID: $015D; Name: 'scircumflex'),
    (
      ID: $0219; Name: 'scommaaccent'),
    (
      ID: $2033; Name: 'second'),
    (
      ID: $00A7; Name: 'section'),
    (
      ID: $003B; Name: 'semicolon'),
    (
      ID: $0037; Name: 'seven'),
    (
      ID: $215E; Name: 'seveneighths'),
    (
      ID: $2087; Name: 'seveninferior'),
    (
      ID: $F737; Name: 'sevenoldstyle'),
    (
      ID: $2077; Name: 'sevensuperior'),
    (
      ID: $2592; Name: 'shade'),
    (
      ID: $03C3; Name: 'sigma'),
    (
      ID: $03C2; Name: 'sigma1'),
    (
      ID: $223C; Name: 'similar'),
    (
      ID: $0036; Name: 'six'),
    (
      ID: $2086; Name: 'sixinferior'),
    (
      ID: $F736; Name: 'sixoldstyle'),
    (
      ID: $2076; Name: 'sixsuperior'),
    (
      ID: $002F; Name: 'slash'),
    (
      ID: $263A; Name: 'smileface'),
    (
      ID: $0020; Name: 'space'),
    (
      ID: $00A0; Name: 'space'),
    (
      ID: $2660; Name: 'spade'),
    (
      ID: $F6F2; Name: 'ssuperior'),
    (
      ID: $00A3; Name: 'sterling'),
    (
      ID: $220B; Name: 'suchthat'),
    (
      ID: $2211; Name: 'summation'),
    (
      ID: $263C; Name: 'sun'),
    (
      ID: $0074; Name: 't'),
    (
      ID: $03C4; Name: 'tau'),
    (
      ID: $0167; Name: 'tbar'),
    (
      ID: $0165; Name: 'tcaron'),
    (
      ID: $0163; Name: 'tcommaaccent'),
    (
      ID: $021B; Name: 'tcommaaccent'),
    (
      ID: $2234; Name: 'therefore'),
    (
      ID: $03B8; Name: 'theta'),
    (
      ID: $03D1; Name: 'theta1'),
    (
      ID: $00FE; Name: 'thorn'),
    (
      ID: $0033; Name: 'three'),
    (
      ID: $215C; Name: 'threeeighths'),
    (
      ID: $2083; Name: 'threeinferior'),
    (
      ID: $F733; Name: 'threeoldstyle'),
    (
      ID: $00BE; Name: 'threequarters'),
    (
      ID: $F6DE; Name: 'threequartersemdash'),
    (
      ID: $00B3; Name: 'threesuperior'),
    (
      ID: $02DC; Name: 'tilde'),
    (
      ID: $0303; Name: 'tildecomb'),
    (
      ID: $0384; Name: 'tonos'),
    (
      ID: $2122; Name: 'trademark'),
    (
      ID: $F8EA; Name: 'trademarksans'),
    (
      ID: $F6DB; Name: 'trademarkserif'),
    (
      ID: $25BC; Name: 'triagdn'),
    (
      ID: $25C4; Name: 'triaglf'),
    (
      ID: $25BA; Name: 'triagrt'),
    (
      ID: $25B2; Name: 'triagup'),
    (
      ID: $F6F3; Name: 'tsuperior'),
    (
      ID: $0032; Name: 'two'),
    (
      ID: $2025; Name: 'twodotenleader'),
    (
      ID: $2082; Name: 'twoinferior'),
    (
      ID: $F732; Name: 'twooldstyle'),
    (
      ID: $00B2; Name: 'twosuperior'),
    (
      ID: $2154; Name: 'twothirds'),
    (
      ID: $0075; Name: 'u'),
    (
      ID: $00FA; Name: 'uacute'),
    (
      ID: $016D; Name: 'ubreve'),
    (
      ID: $00FB; Name: 'ucircumflex'),
    (
      ID: $00FC; Name: 'udieresis'),
    (
      ID: $00F9; Name: 'ugrave'),
    (
      ID: $01B0; Name: 'uhorn'),
    (
      ID: $0171; Name: 'uhungarumlaut'),
    (
      ID: $016B; Name: 'umacron'),
    (
      ID: $005F; Name: 'underscore'),
    (
      ID: $2017; Name: 'underscoredbl'),
    (
      ID: $222A; Name: 'union'),
    (
      ID: $2200; Name: 'universal'),
    (
      ID: $0173; Name: 'uogonek'),
    (
      ID: $2580; Name: 'upblock'),
    (
      ID: $03C5; Name: 'upsilon'),
    (
      ID: $03CB; Name: 'upsilondieresis'),
    (
      ID: $03B0; Name: 'upsilondieresistonos'),
    (
      ID: $03CD; Name: 'upsilontonos'),
    (
      ID: $016F; Name: 'uring'),
    (
      ID: $0169; Name: 'utilde'),
    (
      ID: $0076; Name: 'v'),
    (
      ID: $0077; Name: 'w'),
    (
      ID: $1E83; Name: 'wacute'),
    (
      ID: $0175; Name: 'wcircumflex'),
    (
      ID: $1E85; Name: 'wdieresis'),
    (
      ID: $2118; Name: 'weierstrass'),
    (
      ID: $1E81; Name: 'wgrave'),
    (
      ID: $0078; Name: 'x'),
    (
      ID: $03BE; Name: 'xi'),
    (
      ID: $0079; Name: 'y'),
    (
      ID: $00FD; Name: 'yacute'),
    (
      ID: $0177; Name: 'ycircumflex'),
    (
      ID: $00FF; Name: 'ydieresis'),
    (
      ID: $00A5; Name: 'yen'),
    (
      ID: $1EF3; Name: 'ygrave'),
    (
      ID: $007A; Name: 'z'),
    (
      ID: $017A; Name: 'zacute'),
    (
      ID: $017E; Name: 'zcaron'),
    (
      ID: $017C; Name: 'zdotaccent'),
    (
      ID: $0030; Name: 'zero'),
    (
      ID: $2080; Name: 'zeroinferior'),
    (
      ID: $F730; Name: 'zerooldstyle'),
    (
      ID: $2070; Name: 'zerosuperior'),
    (
      ID: $03B6; Name: 'zeta') );


implementation

// TDictionary
procedure TDictionary.Clear;
begin
  Keys.Clear;
  Values.Clear;
end;

function TDictionary.Key(Index: Integer) : string;
begin
  Result:=Keys[Index];
end;

function TDictionary.GetCount : Integer;
begin
  Result:=Keys.Count;
end;

procedure TDictionary.Add(Key, Value: string);
begin
  Keys.Add(Key);
  Values.Add(Value);
end;

function TDictionary.KeyExists(Key: string) : Boolean;
begin
  Result:=Keys.IndexOf(Key)>=0;
end;

function TDictionary.Value(Key: string) : string;
var
  P: Integer;
begin
  P:=Keys.IndexOf(Key);
  if P<0 then Result:='' else Result:=Values[P];
end;

procedure TDictionary.RemoveKey(Key: string);
var
  P: Integer;
begin
  P:=Keys.IndexOf(Key);
  if P<0 then Exit;
  Values.Delete(P);
  Keys.Delete(P);
end;

constructor TDictionary.Create;
begin
  Keys:=TStringList.Create;
  Keys.Duplicates:=dupIgnore;
  Values:=TStringList.Create;
end;

destructor TDictionary.Destroy;
begin
  Keys.clear;
  keys.Free;
  Values.Clear;
  values.Free;
  inherited Destroy;
end;


end.
