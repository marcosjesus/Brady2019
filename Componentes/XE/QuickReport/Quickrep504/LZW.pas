unit LZW;

////////////////////////////////////////////////////////////////////////////
//
//  LZW compression routines
//
//  (c) 2004 SCH
//
//  Upgraded to use byte arrays instead of strings. Delphi 2009 compatible
//  DLM Sept 2008
////////////////////////////////////////////////////////////////////////////
interface

{$DEFINE noLZWOnProgress}
{$DEFINE DECODE}
uses
  Classes, SysUtils;


type
  TLZWStats = record
    Elapsed: TDateTime;
    Speed, // bytes/sec
    Ratio: real;
    {$IFDEF LZWOnProgress}
    OnProgress: procedure(const Position, Size: Integer) of object;
    {$ENDIF}
    end;

var
  LZWEncodeStat,
  LZWDecodeStat: TLZWStats;

procedure LZWEncode(sInput, sOutput: TMemoryStream); overload;
{$ifdef DECODE}
procedure LZWDecode(sInput, sOutput: TMemoryStream); overload;
{$ENDIF}
implementation

type
  ELZWError = Exception;

const
  cMAX_LZW_TABLE_ENTRY = $1000-1;
  CRLF = #$D#$A;
  TAB = #$9;

//cMAX_LZW_TABLE_ENTRY = $110-1;
{$IFDEF LZWDebugTXTs}
var
  debS: string;

{$ENDIF}

function ByteLComp( Str1, Str2: TBytes; MaxLen: Cardinal) : Integer;
var
    k : integer;
begin
  try
     for k := 0 to maxlen-1 do
     begin
        if str1[k] <> str2[k] then
        begin
             result := str1[k]- str2[k];
             exit;
        end;
     end;
     result := 0;
  except
     result := 1;
  end;
end;

procedure LZWEncode(sInput, sOutput: TMemoryStream); overload;
const
  cClear = 256;
  cEOD = 257;
type
  TIdxElem = record
    code, Len: Cardinal;
  end;
  TIdx = array of TIdxElem;
  var
  CodeTable: array [0..cMAX_LZW_TABLE_ENTRY] of TBytes;
  CodeSt: array [0..255] of TIdx;
  LongestCode,
  idxCodeTable,
  code,
  prevCode: Cardinal;
  wrCodeLen,
  wrBuffer,
  wrBitCnt: Cardinal;
  Cnt: Integer;
  Buf: utf8string;
  posI: Int64;
  codelen : cardinal;
  {$IFDEF LZWOnProgress}
  OnProgressCtr: Integer;
  {$ENDIF}
  flBuffer: array [0..8191] of Byte;
  flCnt: Integer;

  procedure WriteCode(code: Cardinal); forward;

  procedure InitTable;
  var
    I: Integer;
  begin
    WriteCode(cClear);
    wrCodeLen:=9;
    for I := 0 to 255 do
    begin
      SetLength(CodeTable[I], 1);
      CodeTable[I][0]:= I;
      SetLength(CodeSt[I], 1);
      CodeSt[I][0].code:=I;
      CodeSt[I][0].Len:=1;
    end;
    idxCodeTable:=cEOD+1;
    LongestCode:=1;
  end;

  procedure ExpandTable(code: Cardinal; StartingChar: Byte);
  var
    I: Integer;
    J: Cardinal;
    T: TIdxElem;
  begin
    prevCode:=code;
    //trc.Add(' ET : code ' + inttostr(code) + ' start ' + inttostr( startingchar));
    CodeTable[idxCodeTable]:=CodeTable[code];
    //trc.Add(' CodeTable['+inttostr(idxCodeTable)+'] ' + CodeTable[idxCodeTable]);
    I:=High(CodeSt[StartingChar])+1;
    SetLength(CodeSt[StartingChar], I+1);
    CodeSt[StartingChar][I].code:=idxCodeTable;
    //J:=Length(CodeTable[idxCodeTable])+1;
    J:=High(CodeTable[idxCodeTable])+2; // caution - changed
    if J>LongestCode then LongestCode:=J;
    //trc.Add(inttostr(I) + ' ' + inttostr(J));
    CodeSt[StartingChar][I].Len:=J;
    //CodeSt[..] should be sorted to increasing order to find longest match first
    I:=High(CodeSt[StartingChar]);
    while I>0 do
    begin
      if CodeSt[StartingChar][I].Len<CodeSt[StartingChar][I-1].Len then
      begin
        T:=CodeSt[StartingChar][I];
        CodeSt[StartingChar][I]:=CodeSt[StartingChar][I-1];
        CodeSt[StartingChar][I-1]:=T;
      end;
      Dec(I);
    end;
    Inc(idxCodeTable);
    case idxCodeTable of
      $200 ,
      $400 ,
      $800//,$1000,$2000,$4000,$8000
        : Inc(wrCodeLen);
    end;
  end;

  procedure FlushBuffer;
  begin
    if flCnt>0 then sOutput.Write(flBuffer[0], flCnt);
    flCnt:=0;
  end;

  procedure WriteCode(code: Cardinal);
  var
    tmp: Byte;
  begin
    //trc.Add('code '+ inttostr(code));
    wrBuffer:=(wrBuffer shl wrCodeLen) or code;
    wrBitCnt:=wrBitCnt+wrCodeLen;
    while wrBitCnt>=8 do
    begin
      tmp:=Byte(wrBuffer shr (wrBitCnt-8));
      flBuffer[flCnt]:=tmp;
      Inc(flCnt);
      wrBitCnt:=wrBitCnt-8;
    end;
    if (code=cEOD) and (wrBitCnt>0) then
    begin
      tmp:=Byte(wrBuffer shl (8-wrBitCnt));
      flBuffer[flCnt]:=tmp;
      Inc(flCnt);
    end;
    if flCnt>High(flBuffer)-5 then FlushBuffer;
  end;

  function SearchMatch : Integer;
  var
    I: Integer;
    T: ^ TIdx;
    lb, lcode, ctind : integer;
    bs1, bs2 : TBytes;
  begin
    ctind := Ord(Buf[1]);
    T:=@CodeSt[ctind];
    for I := High(T^) downto 0 do
    begin
        lb := length(buf);
        lcode := high(CodeTable[T^[I].code]) + 1;
        if lb < lcode then continue;
        bs1 := bytesof(buf);
        bs2 := CodeTable[T^[I].code];
        if ByteLComp(bs1, bs2, lcode )=0 then
        begin
         //  trc.add('compare ' + CodeTable[T^[I].code] + '<>' + Buf + '   ' +
         //      inttostr(Length(CodeTable[T^[I].code])) + '  ' + inttostr(T^[I].code));
           Result:=T^[I].code;
           Exit;
        end;
    end;
    result := -1;
  end;
begin
  //trc := TStringlist.Create;
  LZWEncodeStat.Elapsed:=Now;
  flCnt:=0;
  sInput.Position:=0;
  wrCodeLen:=9;
  wrBitCnt:=0;
  wrBuffer:=0;
  InitTable;
  {$IFDEF LZWOnProgress}
  OnProgressCtr:=0;
    {$ENDIF}
  prevCode:=cEOD;
  repeat
    SetLength(Buf, LongestCode);
    posI:=sInput.Position;
    Cnt:=sInput.Read(Buf[1], LongestCode);
    //trc.Add('----------------------------------------------');
    //trc.Add('input (' + inttostr(cnt)+ ') ' + buf);
    if Cnt>0 then
    begin
      {$IFDEF LZWOnProgress}
      if Assigned(LZWEncodeStat.OnProgress) and ((sInput.Position and not $FFFF)<>OnProgressCtr) then
      begin
        OnProgressCtr:=sInput.Position and not $FFFF;
        LZWEncodeStat.OnProgress(sInput.Position, sInput.Size);
      end;
      {$ENDIF}
      //adding char to previous code in table
      if idxCodeTable>cMAX_LZW_TABLE_ENTRY then
      begin
        InitTable;
      end
      else
      begin
        if idxCodeTable-1>cEOD then
        begin //ExpandPrev(Buf[1]);
          //trc.add( '<<' + CodeTable[idxCodeTable-1] + '  ' + inttostr(idxCodeTable-1));
          codelen := high(CodeTable[idxCodeTable-1]) + 1;
          setLength( CodeTable[idxCodeTable-1], codelen+1);
          CodeTable[idxCodeTable-1][codelen]:= ord(Buf[1]);
          //trc.add( '>>' + CodeTable[idxCodeTable-1]);
        end;
      end;
      SetLength(Buf, Cnt);
      //getting longest matching code
      //trc.add( 'sm>>' + Buf);
      code:=SearchMatch;
      sInput.Position:=posI+high(CodeTable[code])+1;
      WriteCode(code);
      //expanding table with code + next char
      ExpandTable(code, Ord(Buf[1]));
    end;

  until Cnt=0;
  WriteCode(cEOD);
  FlushBuffer;
  with LZWEncodeStat do
  begin
    Elapsed:=Now-Elapsed;
    if sInput.Size<>0 then
      Ratio:=sOutput.Size/sInput.Size
    else Ratio:=sOutput.Size/1;
      Speed:=Elapsed/EncodeTime(0, 0, 1, 0);
    if Speed<>0 then Speed:=sInput.Size/Speed;
  end;
  //trc.SaveToFile('traceout-32.txt');
  //ShowCodeTable;
  //trc.free;

  {$IFDEF LZWOnProgress}
  LZWEncodeStat.OnProgress:=nil;
  {$ENDIF}
  end;

procedure LZWDecode(sInput, sOutput: TMemoryStream); overload;
const
  cClear = 256;
  cEOD = 257;
var
  CodeTable: array [0..cMAX_LZW_TABLE_ENTRY] of TBytes;
  idxCodeTable,
  code: Integer;
  rdCodeLen,
  rdBuffer,
  rdBitCnt: Cardinal;
  codelen : cardinal;
  {$IFDEF LZWOnProgress}
  OnProgressCtr: Integer;
  {$ENDIF}
  procedure InitTable;
  var
    I: Integer;
  begin
    rdCodeLen:=9;
    for I := 0 to cEOD do
    begin
      setlength(CodeTable[I], 1);
      CodeTable[I][0]:=Byte(I);
    end;
    idxCodeTable:=cEOD+1;
  end;

  function ReadCode : Cardinal;
  var
    tmp: Byte;
    I: Integer;
  begin
    while rdBitCnt<rdCodeLen do
    begin
      I:=sInput.Read(tmp, 1);
      if I<>1 then raise ELZWError.Create('LZWDecode: End of stream');
      rdBuffer:=rdBuffer shl 8+tmp;
      rdBitCnt:=rdBitCnt+8;
    end;
    Result:=rdBuffer shr (rdBitCnt-rdCodeLen);
    rdBitCnt:=rdBitCnt-rdCodeLen;
    if rdBitCnt>0 //
    then rdBuffer:=rdBuffer shl (32-rdBitCnt) shr (32-rdBitCnt) //
    else rdBuffer:=0;
  end;
begin
  LZWDecodeStat.Elapsed:=Now;
  sInput.Position:=0;
  rdBitCnt:=0;
  rdBuffer:=0;
  InitTable; //just for sure
  code:=ReadCode;
  {$IFDEF LZWOnProgress}
  OnProgressCtr:=0;
    {$ENDIF}
  while code<>cEOD do
  begin
    {$IFDEF LZWOnProgress}
    if Assigned(LZWDecodeStat.OnProgress) and ((sInput.Position and not $FFFF)<>OnProgressCtr) then
    begin
      OnProgressCtr:=sInput.Position and not $FFFF;
      LZWDecodeStat.OnProgress(sInput.Position, sInput.Size);
    end;
    {$ENDIF}
    case code of
        cEOD:;
      cClear: InitTable;
    else
     begin
      if code>=idxCodeTable then raise ELZWError.Create('LZWDecode: code>=idxCodeTable');
      {
      CodeTable[idxCodeTable-1]:=CodeTable[idxCodeTable-1]+CodeTable[code][1];
      sOutput.Write(CodeTable[code][1], Length(CodeTable[code]));
      CodeTable[idxCodeTable]:=CodeTable[code];
       }
      codelen := high(CodeTable[idxCodeTable-1])+1;
      setlength( CodeTable[idxCodeTable-1], codelen+1);
      CodeTable[idxCodeTable-1][codelen]:= CodeTable[code][0];
      sOutput.Write(CodeTable[code][0], high(CodeTable[code])+1);
      CodeTable[idxCodeTable]:=CodeTable[code];
      Inc(idxCodeTable);
      case idxCodeTable of
        $200 ,
        $400 ,
        $800//,$1000,$2000,$4000,$8000
          : Inc(rdCodeLen);
      end;
    end;
  end;
    code:=ReadCode;
  end;
  with LZWDecodeStat
  do
  begin
    Elapsed:=Now-Elapsed;
    if sInput.Size<>0 then Ratio:=sOutput.Size/sInput.Size else Ratio:=sOutput.Size/1;
    Speed:=Elapsed/EncodeTime(0, 0, 1, 0);
    if Speed<>0 then Speed:=sInput.Size/Speed;
  end;

  {$IFDEF LZWOnProgress}
  LZWEncodeStat.OnProgress:=nil;
  {$ENDIF}
  end;


begin
  {$IFDEF LZWOnProgress}
  LZWEncodeStat.OnProgress:=nil;
  LZWDecodeStat.OnProgress:=nil;
  {$ENDIF}
end.
