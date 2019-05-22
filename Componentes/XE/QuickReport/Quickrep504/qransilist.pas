unit QRAnsiList;

interface
uses classes, sysutils;

type
   TAnsiStringHolder = class(TObject)
    public
      stringValue : AnsiString;
      constructor Create;
   end;

   TAnsiStringList = class(TStringlist)
    private
        FNumElements : integer;
    public
        procedure AddString( s : AnsiString );
        function GetString( index : integer ) : AnsiString;
        procedure Clear;override;
        procedure Assign( Source: TPersistent);override;
        {
        procedure Delete( index : integer);override;
        procedure Insert(Index: Integer; const S: string);override;
        function Get(Index: Integer): string; override;
        function GetCount: Integer; override;
        }
   end;

  TQRAnsiMerger = class
  private
    FOrgLines : TAnsiStringList;
    FStrippedLines : TAnsiStringList;
    FMergedLines : TAnsiStringList;
    FMerged : boolean;
    FPrepared : boolean;
    Expressions : TList;
    FDataSets : TList;
  protected
    function GetOrgLines : TAnsiStringList;
    function GetMergedLines : TAnsiStringList;
    procedure SetOrgLines(Value : TAnsiStringList);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Prepare;
    procedure Merge;
    procedure UnPrepare;
    property Lines : TAnsiStringList read GetOrgLines write SetOrgLines;
    property MergedLines : TAnsiStringList read GetMergedLines;
    property Merged : boolean read FMerged;
    property Prepared : boolean read FPrepared;
    property DataSets : TList read FDataSets write FDataSets;
  end;
  
implementation
uses qrexpr;



{TAnsiStringHolder}
constructor TAnsiStringHolder.create;
begin
    stringValue := '';
end;

{TAnsiStringList}
{
function TAnsiStringList.Get(Index: Integer): string;
begin

end;

function TAnsiStringList.GetCount: Integer;
begin
    result := FNumElements;
end;

procedure TAnsiStringList.Insert(Index: Integer; const S: string);
begin

end;

procedure TAnsiStringList.Delete( index : integer);
begin

end;
}
procedure TAnsiStringList.Assign( source : TPersistent);
var
   k : integer;
begin
    inherited assign( source);
    for k := 0 to count-1 do
       AddObject( '', TAnsiStringHolder(TStrings(source).Objects[k]));
    FNumElements := count;
end;

procedure TAnsiStringList.Clear;
var
   k : integer;
begin
    for k := 0 to count-1 do
       TAnsiStringHolder(self.Objects[k]).Free;
    inherited Clear;
    fNumElements := 0;
end;

procedure TAnsiStringList.AddString( s : AnsiString );
var
    sh : TAnsiStringHolder;
begin
     sh := TAnsiStringHolder.Create;
     sh.stringValue := s;
     self.AddObject('', sh);
     inc(FNumElements);
end;

function TAnsiStringList.GetString( index : integer ) : AnsiString;
begin
    result := TAnsiStringHolder(self.Objects[index]).stringValue;
end;

{TQRAnsiMerger}
constructor TQRAnsiMerger.Create;
begin
  FOrgLines := TAnsiStringList.Create;
  FMergedLines := nil;
  FMerged := false;
  FPrepared := false;
  Expressions := nil;
  FDataSets := TList.Create;
end;

destructor TQRAnsiMerger.Destroy;
begin
  if Prepared then UnPrepare;
  if FOrgLines <> nil then
    FOrgLines.Free;
  if FDataSets <> nil then
    FDataSets.Free;
  inherited Destroy;
end;

function TQRAnsiMerger.GetOrgLines : TAnsiStringList;
begin
  Result := FOrgLines;
end;

function TQRAnsiMerger.GetMergedLines : TAnsiStringList;
begin
  if Merged then
    Result := FMergedLines
  else
    Result := nil;
end;

procedure TQRAnsiMerger.SetOrgLines(Value : TAnsiStringList);
begin
  if FOrgLines <> nil then
    FOrgLines.Free;
  FOrgLines := Value;
end;

type
  TMemoEvaluator = class(TQREvaluator)
  public
    Line : integer;
    Position : integer;
  end;

procedure TQRAnsiMerger.Prepare;
var
  I, start, stop, Len : integer;
  Expr : String;
  aLine : string;
  aEvaluator : TMemoEvaluator;
begin
  if Prepared then UnPrepare;
  Expressions := TList.Create;
  FMergedLines := TAnsiStringList.Create;
  if Lines.Count > 0 then
  begin
    FStrippedLines := TAnsiStringList.Create;
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

procedure TQRAnsiMerger.UnPrepare;
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

procedure TQRAnsiMerger.Merge;
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

end.
