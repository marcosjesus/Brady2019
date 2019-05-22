{******************************************************}
{            rsDatabaseFile Classes V2.0               }
{        Copyright 1998 Realsoft Development           }
{           support:  www.realsoftdev.com              }
{******************************************************}

unit Datafile;

interface

uses Classes, SysUtils, Forms, WinProcs {$IFDEF WIN32}, Windows {$ENDIF};

const
  LOCK_DELAY = 25;

type
{$IFDEF WIN32}
  TFilePos = packed record
    Hi:	DWord;
    Lo:	DWord;
  end;
{$ENDIF}

  TrsDBFileStream = class(TFileStream)
  private
    FRetry: longint;
    procedure MSDelay(ms: smallint);
{$IFNDEF WIN32}
    function  DoLock(const handle: word; const origin, length: longint; const lock : boolean): word;
    procedure DoFlush(AHandle: word);
{$ELSE}
    function  DoLock(const handle: word; const originH, originL,
                     lengthH, lengthL: DWORD; const lock : boolean): word;
{$ENDIF}
  public
    function Lock(origin, length: longint): boolean;
    function Unlock(origin, length: longint): boolean;
    procedure Flush;
    procedure Truncate;
{$IFDEF WIN32}
    function Lock64(origin, length: TFilePos): boolean;
    function Unlock64(origin, length: TFilePos): boolean;
    function Seek64(offset: TFilePos; origin: word): TFilePos;
    function Position64: TFilePos;
    function Size64: TFilePos;
    function IsZero64(position: TFilePos): boolean;
    function IsEqual64(pos1, pos2: TFilePos): boolean;
    function SetZero64(var position: TFilePos): TFilePos;
    function MakePos64(position: longint): TFilePos;
{$ENDIF}
    constructor Create(const FileName: string; Mode: Word);
    property Retry : longint     read FRetry  write FRetry;
  end;

implementation

constructor TrsDBFileStream.Create(const FileName: string; Mode: Word);
begin
  inherited Create(FileName, Mode);
  FRetry:= 0;
end;

procedure TrsDBFileStream.MSDelay(ms: smallint);
var start, curr: Longint;
begin
  start := GetTickCount;
  repeat
    curr := GetTickCount;
    if curr <> start then Dec(ms);
  until (ms = 0);
end;

procedure TrsDBFileStream.Truncate;
begin
{$IFDEF WIN32}
  SetEndOfFile(Handle);
{$ELSE}
  _lwrite(Handle, NIL, 0);
{$ENDIF}
end;

{$IFNDEF WIN32}
procedure TrsDBFileStream.Flush;
begin
  DoFlush(Handle);
end;

procedure TrsDBFileStream.DoFlush(AHandle: word); assembler;
asm
  MOV	AH,68H
  MOV	BX,AHandle
  INT	21H
end;

function TrsDBFileStream.DoLock(const handle: word; const origin, length: longint; const lock : boolean): word; assembler;
asm
    CMP   Lock, true
    JNE   @@UNLOCK
    MOV	  AX,$5C00
    JMP   @@OVER
  @@UNLOCK:
    MOV	  AX,$5C01
  @@OVER:
    MOV	  BX,Handle
    MOV	  CX,origin.Word[2]
    MOV	  DX,origin.Word[0]
    MOV	  SI,length.Word[2]
    MOV	  DI,length.Word[0]
    INT	  $21
    JC	  @@FAIL
  @@OK:
    MOV	  AX,0
    JMP	  @@END
  @@FAIL:
    CMP	  AX,1
    JE	  @@OK
  @@END:
end;
{$ELSE}
function TrsDBFileStream.DoLock(const handle: word; const originH, originL,
                                lengthH, lengthL: DWORD; const lock : boolean): word;
begin
  result:= 0;
  if lock then begin
    if not LockFile(handle, originH,originL, lengthH,lengthL) then result:= 1
    end
  else begin
    if not UnLockFile(handle, originH,originL, lengthH,lengthL) then result:= 1;
    end;
end;

procedure TrsDBFileStream.Flush;
begin
  FlushFileBuffers(handle);
end;
{$ENDIF}

function TrsDBFileStream.Lock(origin, length: longint): boolean;
var count: integer;
begin
  count:= 0;
  repeat
    {$IFDEF WIN32}
    result:= DoLock(Handle, origin,0, length,0, true) = 0;
    {$ELSE}
    result:= DoLock(Handle, origin, length, true) = 0;
    {$ENDIF}
    if (FRetry > 0) and (not Result) then MSDelay(LOCK_DELAY);
    inc(count);
  until (count >= FRetry) or Result;
end;

function TrsDBFileStream.Unlock(origin, length: longint): boolean;
begin
  {$IFDEF WIN32}
  result:= DoLock(Handle, origin,0, length,0, false) = 0;
  {$ELSE}
  result:= DoLock(Handle, origin, length, false) = 0;
  {$ENDIF}
end;

{$IFDEF WIN32}
function TrsDBFileStream.Lock64(origin, length: TFilePos): boolean;
var count: integer;
begin
  count:= 0;
  repeat
    result:= DoLock(Handle, origin.Hi, origin.Lo, length.Hi, length.Lo, true) = 0;
    if (FRetry > 0) and (not Result) then MSDelay(LOCK_DELAY);
    inc(count);
  until (count >= FRetry) or Result;
end;

function TrsDBFileStream.Unlock64(origin, length: TFilePos): boolean;
begin
  result:= DoLock(Handle, origin.Hi,origin.Lo, length.Hi,length.Lo, false) = 0;
end;

function TrsDBFileStream.Seek64(offset: TFilePos; origin: word): TFilePos;
var tmphi: DWord;
begin
  tmphi:= offset.Hi;
  result.lo:= SetFilePointer(Handle, offset.Lo, @tmphi, origin);
  result.hi:= tmphi;
end;

function TrsDBFileStream.Position64: TFilePos;
var tmphi: DWord;
begin
  result.lo:= SetFilePointer(Handle, 0, @tmphi, FILE_CURRENT);
  result.hi:= tmphi;
end;

function TrsDBFileStream.Size64: TFilePos;
var tmphi: DWord;
begin
  result.lo:= GetFileSize(Handle, @tmphi);
  result.hi:= tmphi;
end;

function TrsDBFileStream.IsZero64(position: TFilePos): boolean;
begin
  result:= (position.Hi = 0) and (position.Lo = 0);
end;

function TrsDBFileStream.SetZero64(var position: TFilePos): TFilePos;
begin
  position.Hi := 0;
  position.Lo := 0;
  result:= position;
end;

function TrsDBFileStream.MakePos64(position: longint): TFilePos;
begin
  result.Hi:= 0;
  result.Lo:= position;
end;

function TrsDBFileStream.IsEqual64(pos1, pos2: TFilePos): boolean;
begin
  result:= (pos1.Hi = pos2.Hi) and (pos1.Lo = pos2.Lo);
end;

{$ENDIF}


end.
