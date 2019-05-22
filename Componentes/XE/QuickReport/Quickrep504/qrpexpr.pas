{$I QRPP.INC}

(*

This unit adds a few new functions to Quickreport's expression builder.
It is included automatically by QRPCTRLS, but if you are not using any
Quickreport 2 PowerPack components but still want to use the new expressions,
you must include this unit in the uses clause of one of your application's
units.

*)

unit qrpexpr;

interface

{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

implementation

uses
  WinProcs, WinTypes, Dialogs,
  DBTables, QRCtrls, CSProp, Forms, Classes, SysUtils, QRExpBld, QRPrntr,
  QuickRpt, {$IFDEF WIN32} Registry, {$ENDIF}
  {$IFDEF QR3} QRExpr, {$ENDIF}
  IniFiles, DB, qrpBaseCtrls, qrpCtrls;

type
  TQREvPageCountFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvIsNullFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvAbsFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvFieldLenFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvPadLeftFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvPadRightFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvTrimFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvDetailCountFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvDetailNoFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvColumnNoFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvRecordCountFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvCurrencyFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvStrToIntFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvStrToNumFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvGetCaptionFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvQueryParamFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvReadINIFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvReadRegistryFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvChrFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  {--- date routines ---}

  TQREvReformatDateFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvCalcDateFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvExtractDayFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvExtractMonthFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvExtractYearFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvDayOfWeekFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvDayStringFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvMonthStringFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvCalcTimeFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

function GlobalFindComponent(Name: String;
                             CClass: TComponentClass;
                             FieldName: String): TComponent;
var
  I: Integer;
begin
  Result:=NIL;
  For I:=1 to Screen.FormCount Do
    begin
      Result:=Screen.Forms[I-1].FindComponent(Name);
      If Result is CClass Then
        begin
          If (FieldName='') Then
            Break
          Else
            begin
              If TDataset(Result).FindField(FieldName)<>NIL Then
                Break
              Else
                Result:=NIL;
            end;
        end;
    end;
  {$IFDEF WIN32}
  If Result=NIL Then
    For I:=1 to Screen.DataModuleCount Do
      begin
        Result:=Screen.DataModules[I-1].FindComponent(Name);
        If Result is CClass Then
          begin
            If (FieldName='') Then
              Break
            Else
              begin
                If TDataset(Result).FindField(FieldName)<>NIL Then
                  Break
                Else
                  Result:=NIL;
              end;
          end;
      end;
    {$ENDIF}
end;

{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

function TQREvPageCountFunction.Calculate : TQREvResult;
var
  C: TQRPQuickRep;
begin
  if ArgList.Count=0 then
  begin
    C:=TQRPQuickrep(GlobalFindComponent('QuickReport', TQRPQuickrep, ''));
    If (C<>NIL) and (C is TQRPQuickrep) Then
      begin
        Result.Kind := resInt;
        Result.IntResult := C.TotalPageCount;
      end
    else
      Result.Kind := resError;
  end else
    Result.Kind := resError;
end;

{------------------------------------------------------------------------------}

function TQREvChrFunction.Calculate : TQREvResult;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>1) OR (Argument(0).Kind<>resInt) Then Exit;
  try
    Result.StrResult:=chr(Argument(0).IntResult);
    Result.Kind:=resString;
  except
  end;
end;

{------------------------------------------------------------------------------}

function TQREvIsNullFunction.Calculate: TQREvResult;
var
  CompName, FieldName: String;
  C: TComponent;
  I: Integer;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>2) OR
     (Argument(0).Kind<>resString) OR (Argument(1).Kind<>resString) Then Exit;
  try
    CompName:=Argument(0).StrResult;
    FieldName:=Argument(1).StrResult;
    C:=nil;
    For I:=1 to Screen.FormCount Do
      begin
        C:=Screen.Forms[I-1].FindComponent(CompName);
        If (C<>NIL) and (C is TDataset) and
           (TDataset(C).FindField(FieldName)<>NIL) Then Break;
      end;
    If (C<>NIL) and (C is TDataset) Then
      Result.BooResult:=TDataset(C).FieldByName(FieldName).IsNull;
    Result.Kind:=resBool;
  except
  end;
end;

{------------------------------------------------------------------------------}

function TQREvTrimFunction.Calculate : TQREvResult;
var
  S: String;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>1) OR (Argument(0).Kind<>resString) Then Exit;
  try
    S:=Argument(0).StrResult;
    While (Length(S)>0) and (S[Length(S)]=' ') Do System.Delete(S,Length(S),1);
    While (Length(S)>0) and (S[1]=' ') Do System.Delete(S,1,1);
    Result.StrResult:=S;
    Result.Kind:=resString;
  except
  end;
end;

{------------------------------------------------------------------------------}

function TQREvAbsFunction.Calculate : TQREvResult;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>1) OR
     ((Argument(0).Kind<>resInt) and (Argument(0).Kind<>resDouble)) Then Exit;
  try
    If Argument(0).Kind=resInt Then
      begin
        Result.IntResult:=Abs(Argument(0).IntResult);
        Result.Kind:=resInt;
      end
    Else
    If Argument(0).Kind=resDouble Then
      begin
        Result.DblResult:=Abs(Argument(0).DblResult);
        Result.Kind:=resDouble;
      end;
  except
  end;
end;

{------------------------------------------------------------------------------}

function TQREvFieldLenFunction.Calculate : TQREvResult;
var
  CompName, FieldName: String;
  C: TComponent;
  I: Integer;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>2) OR
     (Argument(0).Kind<>resString) OR (Argument(1).Kind<>resString) Then Exit;
  try
    CompName:=Argument(0).StrResult;
    FieldName:=Argument(1).StrResult;
    C:=nil;
    For I:=1 to Screen.FormCount Do
      begin
        C:=Screen.Forms[I-1].FindComponent(CompName);
        If (C<>NIL) and (C is TDataset) and
           (TDataset(C).FindField(FieldName)<>NIL) Then Break;
      end;
    If (C<>NIL) and (C is TDataset) Then
      Result.IntResult:=TDataset(C).FieldByName(FieldName).Size;
    Result.Kind:=resInt;
  except
  end;
end;

{------------------------------------------------------------------------------}

function TQREvPadLeftFunction.Calculate : TQREvResult;
var
  S: String;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>2) OR
     (Argument(0).Kind<>resString) OR (Argument(1).Kind<>resInt) Then Exit;
  try
    S:=Argument(0).StrResult;
    While Length(S)<Argument(1).IntResult Do S:=' '+S;
    Result.StrResult:=S;
    Result.Kind:=resString;
  except
  end;
end;

{------------------------------------------------------------------------------}

function TQREvPadRightFunction.Calculate : TQREvResult;
var
  S: String;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>2) OR
     (Argument(0).Kind<>resString) OR (Argument(1).Kind<>resInt) Then Exit;
  try
    S:=Argument(0).StrResult;
    While Length(S)<Argument(1).IntResult Do S:=S+' ';
    Result.StrResult:=S;
    Result.Kind:=resString;
  except
  end;
end;

{------------------------------------------------------------------------------}

function TQREvCurrencyFunction.Calculate : TQREvResult;
begin
  Result.Kind:=resString;
  Result.StrResult:=CurrencyString;
end;

{------------------------------------------------------------------------------}

function TQREvCalcTimeFunction.Calculate : TQREvResult;
var
  _H,_M,_S,_MS: Word;
  H,M,S: Longint;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>4) OR
     (Argument(0).Kind<>resString) OR
     (Argument(1).Kind<>resInt) OR
     (Argument(2).Kind<>resInt) OR
     (Argument(3).Kind<>resInt) Then Exit;
  try
    DecodeTime(StrToTime(Argument(0).StrResult),_H,_M,_S,_MS);
    H:=_H; S:=_S; M:=_M;
    S:=S+Argument(3).IntResult;
    M:=M+Argument(2).IntResult;
    H:=H+Argument(1).IntResult;
    While S<0 Do begin S:=S+60; M:=M-1; end;
    While S>60 Do begin S:=S-60; M:=M+1; end;
    While M<0 Do begin M:=M+60; H:=H-1; end;
    While M>60 Do begin M:=M-60; H:=H+1; end;
    While H<0 Do begin H:=H+24; end;
    While H>24 Do begin H:=H-24; end;
    Result.StrResult:=TimeToStr(EncodeTime(H,M,S,_MS));
    Result.Kind:=resString;
  except
  end;
end;



function TQREvCalcDateFunction.Calculate : TQREvResult;

  { The following routines were taken from SWAG Delphi snippets }

  procedure DMYtoDate(Day,Month,Year: Word; var Julian: Word);
    { Convert from day,month,year to a date }
    { Stored as number of days since January 1, 1900 }
  begin
  if (Year=1900) and (Month<3) then
    if Month = 1 then
      Julian := pred(Day)
    else
      Julian := Day + 30
  else
    begin
      if Month > 2 then
        dec(Month,3)
      else
        begin
          inc(Month,9);
          dec(Year)

        end;
      dec(Year,1900);
      Julian := (1461*longint(Year) div 4) + ((153*Month+2) div 5) + Day + 58;
    end
  end;

  procedure DateToDMY(Julian: Word; var Day,Month,Year: Word);
    { Convert from a date to day,month,year }
  var
    LongTemp: longint;
        Temp: Word;
  begin
    if Julian <= 58 then
      begin
        Year := 1900;
        if Julian <= 30 then
          begin
            Month := 1;
            Day := succ(Julian)
          end
        else
          begin
            Month := 2;
            Day := Julian - 30
          end
      end
    else
      begin
        LongTemp := 4*longint(Julian) - 233;

        Year := LongTemp div 1461;
        Temp := LongTemp mod 1461 div 4 * 5 + 2;
        Month := Temp div 153;
        Day := Temp mod 153 div 5 + 1;
        inc(Year,1900);
        if Month < 10 then
          inc(Month,3)
        else
          begin
            dec(Month,9);
            inc(Year)
          end
      end
  end;

  function BumpDate(Julian: Word; Days,Months,Years: Integer): Word;
  { Add (or subtract) the number of days, months, and years to a date }
  var Day: Word;
      Month: Word;
      Year: Word;
      M: Integer;
  begin
    DateToDMY(Julian,Day,Month,Year);
    M := Month + Months - 1;
    Year := Year + Years + (M div 12) - ord(M<0);
    Month := (M + 12000) mod 12 + 1;
    DMYtoDate(Day,Month,Year,Julian);
    BumpDate := Julian + Days
  end;


var
  TmpD: Word;
  Y,M,D: Word;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>4) OR
     (Argument(0).Kind<>resString) OR
     (Argument(1).Kind<>resInt) OR
     (Argument(2).Kind<>resInt) OR
     (Argument(3).Kind<>resInt) Then Exit;
  try
    DecodeDate(StrToDateTime(Argument(0).StrResult),Y,M,D);
    DMYToDate(D,M,Y,TmpD);
    TmpD:=BumpDate(TmpD,Argument(1).IntResult,Argument(2).IntResult,Argument(3).IntResult);
    DateToDMY(TmpD,D,M,Y);
    Result.StrResult:=DateToStr(EncodeDate(Y,M,D));
    Result.Kind:=resString;
  except
  end;
end;

function TQREvExtractDayFunction.Calculate : TQREvResult;
var
  Y,M,D: Word;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>1) OR (Argument(0).Kind<>resString) Then Exit;
  try
    DecodeDate(StrToDateTime(Argument(0).StrResult),Y,M,D);
    Result.IntResult:=D;
    Result.Kind:=resInt;
  except
  end;
end;

function TQREvExtractMonthFunction.Calculate : TQREvResult;
var
  Y,M,D: Word;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>1) OR (Argument(0).Kind<>resString) Then Exit;
  try
    DecodeDate(StrToDateTime(Argument(0).StrResult),Y,M,D);
    Result.IntResult:=M;
    Result.Kind:=resInt;
  except
  end;
end;

function TQREvExtractYearFunction.Calculate : TQREvResult;
var
  Y,M,D: Word;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>1) OR (Argument(0).Kind<>resString) Then Exit;
  try
    DecodeDate(StrToDateTime(Argument(0).StrResult),Y,M,D);
    Result.IntResult:=Y;
    Result.Kind:=resInt;
  except
  end;
end;

function TQREvDayOfWeekFunction.Calculate : TQREvResult;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>1) OR (Argument(0).Kind<>resString) Then Exit;
  try
    Result.IntResult:=DayOfWeek(StrToDateTime(Argument(0).StrResult));
    Result.Kind:=resInt;
  except
  end;
end;

function TQREvDayStringFunction.Calculate : TQREvResult;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>1) OR (Argument(0).Kind<>resInt) Then Exit;
  try
    Result.StrResult:=LongDayNames[Argument(0).IntResult];
    Result.Kind:=resString;
  except
  end;
end;

function TQREvMonthStringFunction.Calculate : TQREvResult;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>1) OR (Argument(0).Kind<>resInt) Then Exit;
  try
    Result.StrResult:=LongMonthNames[Argument(0).IntResult];
    Result.Kind:=resString;
  except
  end;
end;

{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

function TQREvQueryParamFunction.Calculate: TQREvResult;
var
  CompName, ParamName: String;
  C: TComponent;
  I: Integer;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>2) OR
     (Argument(0).Kind<>resString) OR (Argument(1).Kind<>resString) Then Exit;
  try
    CompName:=Argument(0).StrResult;
    ParamName:=Argument(1).StrResult;
    C:=NIL;
    For I:=1 to Screen.FormCount Do
      begin
        C:=Screen.Forms[I-1].FindComponent(CompName);
        If (C<>NIL) AND (C is TQuery) Then Break;
      end;
    If (C<>NIL) AND (C is TQuery) Then
      Case TQuery(C).ParamByName(ParamName).DataType of
        ftDate       : Result.StrResult:=DateToStr(TQuery(C).ParamByName(ParamName).AsDateTime);
        ftTime       : Result.StrResult:=TimeToStr(TQuery(C).ParamByName(ParamName).AsDateTime);
        ftDateTime   : Result.StrResult:=DateTimeToStr(TQuery(C).ParamByName(ParamName).AsDateTime);
      else
        Result.StrResult:=TQuery(C).ParamByName(ParamName).AsString;
      end;

    Result.Kind:=resString;
  except
  end;
end;

{------------------------------------------------------------------------------}

function TQREvReadINIFunction.Calculate: TQREvResult;
var
  TI: TIniFile;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>3) OR
     (Argument(0).Kind<>resString) OR
     (Argument(1).Kind<>resString) OR
     (Argument(2).Kind<>resString) Then Exit;
  try
    TI:=TIniFile.Create(ExpandFileName(Argument(0).StrResult));
    Result.StrResult:=TI.ReadString(Argument(1).StrResult,Argument(2).StrResult,'');
    TI.Free;
    Result.Kind:=resString;
  except
  end;
end;

{------------------------------------------------------------------------------}

function TQREvReadRegistryFunction.Calculate: TQREvResult;
{$IFDEF WIN32}
var
  TI: TRegIniFile;
{$ENDIF}
begin
  Result.Kind:=resError;
  If (ArgList.Count<>3) OR
     (Argument(0).Kind<>resString) OR
     (Argument(1).Kind<>resString) OR
     (Argument(2).Kind<>resString) Then Exit;
  try
    {$IFDEF WIN32}
    TI:=TRegIniFile.Create(Argument(0).StrResult);
    Result.StrResult:=TI.ReadString(Argument(1).StrResult,Argument(2).StrResult,'');
    TI.Free;
    {$ELSE}
    Result.StrResult:='';
    {$ENDIF}
    Result.Kind:=resString;
  except
  end;
end;

{------------------------------------------------------------------------------}

function TQREvReformatDateFunction.Calculate: TQREvResult;
var
  DT: TDateTime;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>2) OR
     (Argument(0).Kind<>resString) OR (Argument(1).Kind<>resString) Then Exit;
  try
    DT:=StrToDateTime(Argument(0).StrResult);
    Result.StrResult:=FormatDateTime(Argument(1).StrResult, DT);
    Result.Kind:=resString;
  except
  end;
end;

{------------------------------------------------------------------------------}

function FindQuickReport: TQuickRep;
var
  I, J: Integer;
begin
  Result:=NIL;
  For I:=1 to Screen.FormCount Do
    begin
      For J:=1 to Screen.Forms[I-1].ComponentCount Do
        If Screen.Forms[I-1].Components[J-1] is TQuickRep Then
          begin
            Result:=TQuickRep(Screen.Forms[I-1].Components[J-1]);
            Break;
          end;
      If Result<>NIL Then Break;
    end;
end;


function TQREvDetailCountFunction.Calculate: TQREvResult;
var
  ParentReport: TQuickRep;
begin
  Result.Kind:=resError;
  try
    ParentReport:=FindQuickReport;
    If ParentReport<>NIL Then
      begin
        {$IFDEF QR3}
        If (ParentReport.Dataset<>NIL) and
           ParentReport.Dataset.Active Then
          Result.IntResult:=ParentReport.Dataset.RecordCount;
        {$ELSE}
        Result.IntResult:=ParentReport.RecordCount;
        {$ENDIF}
        Result.Kind:=resInt;
      end;
  except
  end;
end;

{------------------------------------------------------------------------------}

type
  TMyQuickRep = class(TQuickRep);

function TQREvDetailNoFunction.Calculate: TQREvResult;
var
  ParentReport: TQuickRep;
begin
  Result.Kind:=resError;
  try
    ParentReport:=FindQuickReport;
    If ParentReport<>NIL Then
      begin
        {$IFDEF QR3}
        Result.IntResult:=TQRController(TMyQuickRep(ParentReport).Controller).DetailNumber;
        {$ELSE}
        Result.IntResult:=ParentReport.RecordNumber;
        {$ENDIF}
        Result.Kind:=resInt;
      end;
  except
  end;
end;

{------------------------------------------------------------------------------}

function TQREvColumnNoFunction.Calculate: TQREvResult;
var
  ParentReport: TQuickRep;
begin
  Result.Kind:=resError;
  try
    ParentReport:=FindQuickReport;
    If ParentReport<>NIL Then
      begin
        Result.IntResult:=ParentReport.CurrentColumn;
        Result.Kind:=resInt;
      end;
  except
  end;
end;

{------------------------------------------------------------------------------}

function TQREvStrToIntFunction.Calculate: TQREvResult;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>1) OR (Argument(0).Kind<>resString) Then Exit;
  try
    Result.IntResult:=StrToInt(Argument(0).StrResult);
    Result.Kind:=resInt;
  except
  end;
end;

{------------------------------------------------------------------------------}

function TQREvStrToNumFunction.Calculate: TQREvResult;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>1) OR (Argument(0).Kind<>resString) Then Exit;
  try
    Result.DblResult:=StrToFloat(Argument(0).StrResult);
    Result.Kind:=resDouble;
  except
  end;
end;

{------------------------------------------------------------------------------}

function TQREvGetCaptionFunction.Calculate: TQREvResult;
var
  CompName: String;
  C: TComponent;
  I: Integer;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>1) OR (Argument(0).Kind<>resString) Then Exit;
  try
    CompName:=Argument(0).StrResult;
    C:=NIL;
    For I:=1 to Screen.FormCount Do
      begin
        C:=Screen.Forms[I-1].FindComponent(CompName);
        If (C<>NIL) AND (PropertyExists(C,'Caption') or (C is TQRExpr)) Then Break;
      end;
    If C<>NIL Then
      begin
        If C is TQRExpr Then Result.StrResult:=TQRExpr(C).Caption
        Else
          Result.StrResult:=GetStringProperty(C,'Caption');
        Result.Kind:=resString;
      end;
  except
  end;
end;

{------------------------------------------------------------------------------}

function TQREvRecordCountFunction.Calculate: TQREvResult;
var
  CompName: String;
  C: TComponent;
  I: Integer;
begin
  Result.Kind:=resError;
  If (ArgList.Count<>1) OR (Argument(0).Kind<>resString) Then Exit;
  try
    CompName:=Argument(0).StrResult;
    C:=NIL;
    For I:=1 to Screen.FormCount Do
      begin
        C:=Screen.Forms[I-1].FindComponent(CompName);
        If (C<>NIL) AND (C is TDataset) Then Break;
      end;
    If C<>NIL Then
      begin
        If C is TTable Then
          begin
            Result.IntResult:=TTable(C).RecordCount;
            Result.Kind:=resInt;
          end
        Else
        If C is TQuery Then
          begin
            Result.IntResult:=TQuery(C).RecordCount;
            Result.Kind:=resInt;
          end;
      end;
  except
  end;
end;

{------------------------------------------------------------------------------}
{------------------------------------------------------------------------------}

procedure _RegisterQRFunction(FunctionClass : TQRLibraryItemClass; Name, Description, Vendor, Arguments : string);
begin
  If QRFunctionLibrary.EntryList.IndexOf(Name)=-1 Then
    RegisterQRFunction(FunctionClass, Name, Description, Vendor, Arguments);
end;

initialization

  _RegisterQRFunction(TQREvPageCountFunction, 'PAGECOUNT','PAGENUMBER|Returns the total number of pages','THSD','7');
  _RegisterQRFunction(TQREvDetailCountFunction,'DETAILCOUNT','DETAILCOUNT|Returns the number of detail records','THSD','4');
  _RegisterQRFunction(TQREvDetailNoFunction,'DETAILNO','DETAILNO|Returns the current record number','THSD','4');
  _RegisterQRFunction(TQREvColumnNoFunction,'COLUMNNO','COLUMNNO|Returns the current column number','THSD','4');

  _RegisterQRFunction(TQREvCurrencyFunction, 'CURRENCY',
                'CURRENCY|Returns Windows'''' default currency ','THSD','7');
  _RegisterQRFunction(TQREvQueryParamFunction, 'QUERYPARAM',
                'QUERYPARAM(<Q>,<P>)|Gets parameter value from a query','THSD','7SS');
  _RegisterQRFunction(TQREvStrToIntFunction, 'STRTOINT','STRTOINT(<X>)|Converts String to Integer','THSD','7S');
  _RegisterQRFunction(TQREvStrToNumFunction, 'STRTONUM','STRTONUM(<X>)|Converts String to number','THSD','7S');
  _RegisterQRFunction(TQREvGetCaptionFunction, 'GETCAPTION','GETCAPTION(<S>)|Returns a component''''s caption','THSD','7S');
  _RegisterQRFunction(TQREvRecordCountFunction, 'RECORDCOUNT','RECORDCOUNT(<DS>)|Returns a dataset''s record count',
                                                'THSD','7S');
  _RegisterQRFunction(TQREvReadINIFunction,
                     'READINI','READINI(<S1>,<S2>,<S3>)|Reads entry S3 in section S2 from INI file S1','THSD','7SSS');
  {$IFDEF WIN32}
  _RegisterQRFunction(TQREvReadRegistryFunction,
                     'READREGISTRY','READREGISTRY(S1,S2,S3)|Reads entry S3 in section S2 from registry key S1','THSD','7SSS');
  {$ENDIF}
  _RegisterQRFunction(TQREvReformatDateFunction,
                     'REFORMATDATE','REFORMATDATE(<D>,<F>)|Formats a date (and time)','THSD','7SS');
  _RegisterQRFunction(TQREvCalcDateFunction, 'CALCDATE','CALCDATE( DT, D, M, Y )|'
                      +'Adds D days, M months and Y years to a given date DT','THSD','1SNNN');
  _RegisterQRFunction(TQREvExtractDayFunction, 'EXTRACTDAY','EXTRACTDAY(<DATE>)|'
                      +'Gets only the day from a given date.','THSD','1S');
  _RegisterQRFunction(TQREvExtractMonthFunction, 'EXTRACTMONTH','EXTRACTMONTH(<DATE>)|'
                      +'Gets only the month from a given date.','THSD','1S');
  _RegisterQRFunction(TQREvExtractYearFunction, 'EXTRACTYEAR','EXTRACTYEAR(<DATE>)|'
                      +'Gets only the year from a given date.','THSD','1S');
  _RegisterQRFunction(TQREvDayOfWeekFunction, 'DAYOFWEEK','DAYOFWEEK(<DATE>)|'
                      +'Returns the day of the week (1..7) for a given date.','THSD','1S');
  _RegisterQRFunction(TQREvDayStringFunction, 'DAYSTRING','DAYSTRING(<D>)|'
                      +'Returns the day name for the given day (1=Sunday,2=...).','THSD','1N');
  _RegisterQRFunction(TQREvMonthStringFunction, 'MONTHSTRING','MONTHSTRING(<M>)|'
                      +'Returns the month name for the given month (1..12).','THSD','1N');
  _RegisterQRFunction(TQREvCalcTimeFunction, 'CALCTIME','CALCTIME( T, H, M, S )|'
                      +'Adds H hours, M minutes and S seconds to a given time T','THSD','1SNNN');
  _RegisterQRFunction(TQREvTrimFunction, 'TRIM','TRIM(<S>)|'
                      +'Removes leading and trailing blanks from a string','THSD','7S');
  _RegisterQRFunction(TQREvChrFunction, 'CHR','CHR(<I>)|'
                      +'Converts the ordinal ASCII value to a character','THSD','7N');
  _RegisterQRFunction(TQREvIsNullFunction, 'ISNULL','ISNULL(TABLE,FIELD)|'
                      +'Checks if a table''s field contains no data.','THSD','4SS');
  _RegisterQRFunction(TQREvAbsFunction, 'ABS','ABS(<I>)|'
                      +'Returns the absolute value of I.','THSD','2N');
  _RegisterQRFunction(TQREvFieldLenFunction, 'FIELDLEN','FIELDLEN(TABLE,FIELD)|'
                      +'Returns the data field size in characters.','THSD','4SS');
  _RegisterQRFunction(TQREvPadLeftFunction, 'PADLEFT','PADLEFT(<S>,<Len>)|'
                      +'Fills up the string S to Len characters.','THSD','7SN');
  _RegisterQRFunction(TQREvPadRightFunction, 'PADRIGHT','PADRIGHT(<S>,<Len>)|'
                      +'Fills up the string S to Len characters','THSD','7SN');
{$IFNDEF Registered}
xxx
  If FindWindow('TAppBuilder',NIL)=0 Then
    begin
      MessageDlg('UNREGISTERED QUICKREPORT 2 POWERPACK  - '
              +'This shareware version will only run if the Delphi IDE is loaded!',mtinformation,[mbok],0);
      Halt;
    end;
{$ENDIF}
end.
