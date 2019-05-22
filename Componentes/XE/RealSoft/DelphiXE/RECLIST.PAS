{******************************************************}
{                RecordList Class V1.0                 }
{        Copyright 1998 RealSoft Development           }
{           support:  www.realsoftdev.com              }
{******************************************************}

unit RecList;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Dialogs;

{$DEFINE _CHECKSTAMP}

const
  ITEMSTAMP = $6FED;

type
  ERecListException    = class(Exception);

  PRecListHeader = ^RRecListHeader;
  RRecListHeader = record
    ItemStamp:		smallint;
    ItemID:		smallint;
    ItemType:		smallint;
    ItemSize:		smallint;
    ItemTag:		smallint;
  end;

  TCustomRecordList = class(TComponent)
  private
    FList: TList;
    function _GetCount: integer;
    function _GetSize: integer;
    function _GetItem(Index: integer): pointer;
    function _GetFirstItem: pointer;
    function _GetLastItem: pointer;
    function _GetNextID: smallint;
  public
    constructor Create(AOwner: TComponent);			override;
    destructor Destroy; 					override;
    procedure Clear;
    procedure Add(var Item);
    procedure Update(var Item; Index: integer);
    procedure Delete(Index: integer);
    procedure Resize(Index: integer; NewSize: smallint);
    procedure SaveToFile(Filename: String);
    procedure LoadFromFile(Filename: String);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream);
    function  ReadBuffer(var Dest; MaxBytes: longint): longint;
    function  WriteBuffer(const Source; Count: longint): longint;
    procedure Assign(Source: TPersistent);			override;
    function  FindItem(ID: integer): pointer;
    function  FindIndex(ID: integer): integer;
    procedure Exchange(Index1, Index2: integer);
    property  Count: integer					read _GetCount;
    property  Size: integer					read _GetSize;
    property  First: Pointer					read _GetFirstItem;
    property  Last: Pointer					read _GetLastItem;
    property  Items [Index: integer]: Pointer			read _GetItem;
  end;

  TOnCompareItems = procedure(Sender: TObject; Item1,Item2: pointer; var NeedSwap: boolean) of object;

  TCustomRecordListObject = class
  private
    FRecList: TCustomRecordList;
    FDefType,
    FDefSize: smallint;
    FCompareItems: TOnCompareItems;
    function _GetCount: integer;
    function _GetItem(Index: integer): pointer;
    function _GetFirstItem: pointer;
    function _GetLastItem: pointer;
    function _GetGlobalIndex(Index: integer): integer;
  public
    constructor Create(AParent: TCustomRecordList; AType, ASize: smallint);
    procedure AddNew;						virtual;
    procedure Add(var Item);					virtual;
    procedure Update(var Item; Index: integer);			virtual;
    procedure Delete(Index: integer);				virtual;
    procedure Resize(Index: integer; NewSize: smallint);	virtual;
    procedure Clear;						virtual;
    procedure Sort;						virtual;
    property  DefaultSize: smallint				read FDefSize;
    property  DefaultType: smallint				read FDefType;
    property  Count: integer					read _GetCount;
    property  First: Pointer					read _GetFirstItem;
    property  Last: Pointer					read _GetLastItem;
    property  Items [Index: integer]: Pointer			read _GetItem; 	{$IFDEF WIN32}default;{$ENDIF}
    property  OnCompareItems: TOnCompareItems			read FCompareItems	write FCompareItems;
  end;

implementation

{******************}
{    Main Class    }
{******************}
constructor TCustomRecordList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList:= TList.create;
end;

destructor TCustomRecordList.Destroy;
begin
  Clear;
  FList.free;
  inherited Destroy;
end;

function TCustomRecordList._GetCount: integer;
begin
  result:= FList.count;
end;

function TCustomRecordList._GetSize: integer;
var
  x: integer;
begin
  result:= 0;
  for x:= 0 to FList.count-1 do
    Result:= result + PRecListHeader(FList[x])^.Itemsize;
end;

function TCustomRecordList._GetItem(Index: integer): pointer;
begin
  if (Index < 0) or (Index > FList.count-1) then
    raise ERecListException.create('Index out of bounds ('+inttostr(Index)+')');
  result:= FList[Index];
end;

function TCustomRecordList._GetFirstItem: pointer;
begin
  result:= FList[0];
end;

function TCustomRecordList._GetLastItem: pointer;
begin
  result:= FList[FList.count-1];
end;

function TCustomRecordList._GetNextID: smallint;
var
  x: integer;
begin
  result:= 1;
  for x:= 0 to FList.count-1 do
    if PRecListHeader(FList[x])^.Itemid >= result then
      result:= PRecListHeader(FList[x])^.Itemid + 1;
end;

procedure TCustomRecordList.Clear;
var
  x: integer;
begin
  for x:= 0 to FList.count-1 do
    FreeMem(FList[x], PRecListHeader(FList[x])^.Itemsize);
  FList.Clear;
end;

procedure TCustomRecordList.Add(var Item);
var
  p: pointer;
begin
  if RRecListHeader(Item).Itemtype <= 0 then
    raise ERecListException.create('Add: invalid Itemtype');
  if RRecListHeader(Item).Itemsize < sizeof(RRecListHeader) then
    raise ERecListException.create('Add: invalid Itemsize');
  RRecListHeader(Item).Itemstamp:= ITEMSTAMP;
  RRecListHeader(Item).ItemID:= _GetNextID;
  GetMem(p, RRecListHeader(Item).Itemsize);
  Move(item, p^, RRecListHeader(Item).Itemsize);
  FList.Add(p);
end;

procedure TCustomRecordList.Update(var Item; Index: integer);
begin
  if (Index < 0) or (Index > FList.count-1) then
    raise ERecListException.create('Update: index out of bounds');
  if RRecListHeader(Item).Itemtype <= 0 then
    raise ERecListException.create('Update: invalid Itemtype');
  if RRecListHeader(Item).Itemsize < sizeof(RRecListHeader) then
    raise ERecListException.create('Update: invalid Itemsize');
  if RRecListHeader(Item).Itemsize <> PRecListHeader(FList[Index])^.Itemsize then
    Resize(Index, RRecListHeader(Item).Itemsize);
  RRecListHeader(Item).Itemstamp:= ITEMSTAMP;
  Move(Item, FList[Index]^, RRecListHeader(Item).Itemsize);
end;

procedure TCustomRecordList.Delete(Index: integer);
begin
  if (Index < 0) or (Index > FList.count-1) then
    raise ERecListException.create('Delete: index out of bounds');
  FreeMem(FList[Index], PRecListHeader(FList[Index])^.Itemsize);
  FList.Delete(Index);
end;

procedure TCustomRecordList.Resize(Index: integer; NewSize: smallint);
var
  p: pointer;
begin
  if (Index < 0) or (Index > FList.count-1) then
    raise ERecListException.create('Resize: index out of bounds');
  if NewSize < sizeof(RRecListHeader) then
    raise ERecListException.create('Resize: invalid size');
  p:= FList[Index];
{$IFNDEF WIN32}
  ReAllocMem(p, PRecListHeader(p)^.itemsize, NewSize);
{$ELSE}
  ReAllocMem(p, NewSize);
{$ENDIF}
  PRecListHeader(p)^.itemsize:= NewSize;
  FList[Index]:= p;
end;

procedure TCustomRecordList.SaveToFile(Filename: String);
var
  x: integer;
  FS: TFileStream;
begin
  if FileExists(Filename) then
    sysutils.DeleteFile(Filename);
  FS:= nil;
  try
    FS:= TFileStream.create(Filename, fmCreate);
    for x:= 0 to FList.count-1 do
      FS.Write(FList[x]^, PRecListHeader(FList[x])^.Itemsize);
  finally
    FS.free;
  end;
end;

procedure TCustomRecordList.LoadFromFile(Filename: String);
var
  p: pointer;
  FS: TFileStream;
  Hdr: RRecListHeader;
begin
  Clear;
  if not FileExists(Filename) then
    raise ERecListException.create('Load: file not found.. '+Filename);
  FS:= nil;
  try
    FS:= TFileStream.create(Filename, fmOpenRead);
    while FS.Read(Hdr, sizeof(RRecListHeader)) = sizeof(RRecListHeader) do
    begin
      if Hdr.Itemtype <= 0 then
        raise ERecListException.create('Load: invalid Itemtype');
      if Hdr.Itemsize < sizeof(RRecListHeader) then
        raise ERecListException.create('Load: invalid Itemsize');
{$IFDEF CHECKSTAMP}
      if Hdr.ItemStamp <> ITEMSTAMP then
        raise ERecListException.create('Load: invalid Itemstamp');
{$ENDIF}
      GetMem(p, Hdr.Itemsize);
      FList.Add(p);
      move(Hdr, p^, sizeof(RRecListHeader));
      inc(longint(p), sizeof(RRecListHeader));
      FS.Read(p^, Hdr.Itemsize - sizeof(RRecListHeader));
    end;
  finally
    FS.free;
  end;
end;

procedure TCustomRecordList.SaveToStream(Stream: TStream);
var
  x: integer;
begin
  for x:= 0 to FList.count-1 do
    Stream.Write(FList[x]^, PRecListHeader(FList[x])^.Itemsize);
end;

procedure TCustomRecordList.LoadFromStream(Stream: TStream);
var
  p: pointer;
  Hdr: RRecListHeader;
begin
  Clear;
  while Stream.Read(Hdr, sizeof(RRecListHeader)) = sizeof(RRecListHeader) do
  begin
    if Hdr.Itemtype <= 0 then
      raise ERecListException.create('Load: invalid Itemtype');
    if Hdr.Itemsize < sizeof(RRecListHeader) then
      raise ERecListException.create('Load: invalid Itemsize');
{$IFDEF CHECKSTAMP}
    if Hdr.ItemStamp <> ITEMSTAMP then
      raise ERecListException.create('Load: invalid Itemstamp');
{$ENDIF}
    GetMem(p, Hdr.Itemsize);
    move(Hdr, p^, sizeof(RRecListHeader));
    FList.Add(p);
    inc(longint(p), sizeof(RRecListHeader));
    Stream.Read(p^, Hdr.Itemsize - sizeof(RRecListHeader));
  end;
end;

function TCustomRecordList.ReadBuffer(var Dest; MaxBytes: longint): longint;
var
  x, bytes: integer;
  p: pointer;
begin
  bytes:= 0;
  p:= @Dest;
  for x:= 0 to FList.count-1 do
    if bytes + PRecListHeader(FList[x])^.Itemsize <= MaxBytes then
    begin
      move(FList[x]^, p^, PRecListHeader(FList[x])^.Itemsize);
      inc(bytes, PRecListHeader(FList[x])^.Itemsize);
      inc(longint(p), PRecListHeader(FList[x])^.Itemsize);
    end;
  result:= bytes;
end;

function TCustomRecordList.WriteBuffer(const Source; Count: longint): longint;
var
  bytes: integer;
  p1,p2: pointer;
  Hdr: RRecListHeader;
begin
  Clear;
  bytes:= 0;
  p1:= @Source;
  while bytes < Count do
  begin
    move(p1^, Hdr, sizeof(RRecListHeader));
    if Hdr.Itemtype <= 0 then
      raise ERecListException.create('Load: invalid Itemtype');
    if Hdr.Itemsize < sizeof(RRecListHeader) then
      raise ERecListException.create('Load: invalid Itemsize');
{    if Hdr.ItemStamp <> ITEMSTAMP then
      raise ERecListException.create('Load: invalid Itemstamp');}
    GetMem(p2, Hdr.Itemsize);
    FList.Add(p2);
    move(p1^, p2^, Hdr.Itemsize);
    inc(longint(p1), Hdr.Itemsize);
    inc(Bytes, Hdr.Itemsize);
  end;
  result:= count;
end;

procedure TCustomRecordList.Assign(Source: TPersistent);
var
  tmpstream: TMemorystream;
begin
  Clear;
  tmpstream:= nil;
  try
    tmpstream:= TMemorystream.create;
    TCustomRecordList(Source).savetostream(tmpstream);
    tmpstream.seek(0,0);
    LoadFromStream(tmpstream);
  finally
    tmpstream.free;
  end;
end;

function TCustomRecordList.FindItem(ID: integer): pointer;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to FList.count-1 do
    if PRecListHeader(FList[x])^.ItemID = ID then
    begin
      result:= FList[x];
      break;
    end;
end;

function TCustomRecordList.FindIndex(ID: integer): integer;
var
  x: integer;
begin
  result:= -1;
  for x:= 0 to FList.count-1 do
    if PRecListHeader(FList[x])^.ItemID = ID then
    begin
      result:= x;
      break;
    end;
end;

procedure TCustomRecordList.Exchange(Index1, Index2: integer);
begin
  if Index1 <> Index2 then
    FList.Exchange(Index1, Index2);
end;

{******************}
{     Sub Class    }
{******************}
constructor TCustomRecordListObject.Create(AParent: TCustomRecordList; AType, ASize: smallint);
begin
  inherited Create;
  FRecList:= AParent;
  FDeftype:= AType;
  FDefsize:= ASize;
end;

function TCustomRecordListObject._GetGlobalIndex(Index: integer): integer;
var
  x,y: integer;
begin
  result:= -1;
  y:= 0;
  for x:= 0 to FRecList.Count-1 do
  begin
    if PRecListHeader(FRecList.items[x])^.itemtype = FDeftype then
    begin
      if y = Index then
      begin
        result:= x;
        break;
      end;
      inc(y);
    end;
  end;
end;

function TCustomRecordListObject._GetCount: integer;
var
  x: integer;
begin
  result:= 0;
  for x:= 0 to FRecList.Count-1 do
    if PRecListHeader(FRecList.items[x])^.itemtype = FDeftype then
      result:= result + 1;
end;

function TCustomRecordListObject._GetItem(Index: integer): pointer;
var i: integer;
begin
  i:= _GetGlobalIndex(Index);
  if i = -1 then
    raise ERecListException.create('Index not found (type='+inttostr(fdeftype)+')');

  result:= FRecList.Items[i];
end;

function TCustomRecordListObject._GetFirstItem: pointer;
begin
  result:= _GetItem(0);
end;

function TCustomRecordListObject._GetLastItem: pointer;
begin
  result:= _GetItem(_GetCount-1);
end;

procedure TCustomRecordListObject.AddNew;
var
  p: pointer;
begin
  p:= nil;
  try
    GetMem(p, FDefsize);
    fillchar(p^, FDefsize, 0);
    Add(p^);
  finally
    FreeMem(p, FDefsize);
  end;
end;

procedure TCustomRecordListObject.Add(var Item);
begin
  if RRecListHeader(Item).Itemsize = 0 then
    RRecListHeader(Item).Itemsize:= FDefsize;
  RRecListHeader(Item).Itemtype:= FDeftype;
  FRecList.Add(Item);
end;

procedure TCustomRecordListObject.Update(var Item; Index: integer);
begin
  FRecList.Update(Item, _GetGlobalIndex(Index));
end;

procedure TCustomRecordListObject.Delete(Index: integer);
begin
  FRecList.Delete(_GetGlobalIndex(Index));
end;

procedure TCustomRecordListObject.Resize(Index: integer; NewSize: smallint);
begin
  FRecList.Resize(_GetGlobalIndex(Index), NewSize);
end;

procedure TCustomRecordListObject.Clear;
var
  x: integer;
begin
  x:= 0;
  while x < FRecList.count-1 do
  begin
    if PRecListHeader(FRecList.items[x])^.itemtype = FDeftype then
    begin
      FRecList.Delete(x);
      dec(x);
    end;
    inc(x);
  end;
end;

procedure TCustomRecordListObject.Sort;
var
  i,j: integer;
  NeedSwap: boolean;
begin
  if not assigned(FCompareitems) then Exit;
  for i:= 0 to Count-1 do
  begin
    for j:= 0 to Count-2 do
    begin
      NeedSwap:= false;
      FCompareItems(Self, Items[j], Items[j+1], NeedSwap);
      if NeedSwap then
        FRecList.FList.Exchange(_GetGlobalIndex(j), _GetGlobalIndex(j+1));
    end;
  end;
end;


end.
