{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 5.0 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRExpr - EXPRESSION EVALUATOR                           ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.qusoft.com                              ::
  ::                                                         ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

{$I QRDEFS.INC}

unit QRExpr;

{$R-}
{$T-}
{$B-}

interface

uses
  Windows, Sysutils, Classes, DB, Forms, DBTables, QR5Const;

type
  TQRLibraryItemClass = class of TObject;

  TQRLibraryEntry = class
  private
    FDescription : string;
    FData : string;
    FItem : TQRLibraryItemClass;
    FName : string;
    FVendor : string;
  public
    property Data : string read FData write FData;
    property Description : string read FDescription write FDescription;
    property Name : string read FName write FName;
    property Vendor : string read FVendor write FVendor;
    property Item : TQRLibraryItemClass read FItem write FItem;
  end;

  TQRLibrary = class
  protected
    Entries : TStrings;
    function GetEntry(Index : integer) : TQRLibraryEntry; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(aItem : TQRLibraryItemClass; AName, ADescription, AVendor, AData : string);
    property EntryList : TStrings read Entries write Entries;
    property Entry[Index : integer] : TQRLibraryEntry read GetEntry;
  end;

  TQREvElementFunction = class;
  TQREvElement = class;
  TQREvEnvironment = class;
  TQREvaluator = class;

  TQREvOperator = (opLess, opLessOrEqual, opGreater, opGreaterOrEqual, opEqual,
                   opUnequal, opPlus, opMinus, opOr, opMul, opDiv, opAnd);

  TQREvResultType = (resInt, resDouble, resString, resBool, resError);

  TQREvResult = record
    case Kind : TQREvResultType of
      resInt    : (intResult : longint);
      resDouble : (dblResult : double);
      resString : (strResult : string[255]);
      resBool   : (booResult : boolean);
  end;

  TQREvResultClass = class
  public
    EvResult : TQREvResult;
  end;

  TQRFiFo = class
  private
    FAggreg : boolean;
    FiFo : TList;
    FNextItem : integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Put(Value : TObject);
    procedure Start;
    function Get : TObject;
    function GetAndFree : TObject;
    property Aggreg : boolean read FAggreg write FAggreg;
  end;

  TQREvElement = class
  private
    FIsAggreg : boolean;
  public
    constructor Create; virtual;
    function Value(FiFo : TQRFiFo) : TQREvResult; virtual;
    procedure Reset; virtual;
    property IsAggreg : boolean read FIsAggreg write FIsAggreg;
  end;

  TQREvElementFunction = class(TQREvElement)
  private
  protected
    ArgList : TList;
    function ArgumentOK(Value : TQREvElement) : boolean;
    function Argument(Index : integer) : TQREvResult;
    procedure FreeArguments;
    procedure GetArguments(FiFo : TQRFiFo);
    procedure Aggregate; virtual;
    function Calculate : TQREvResult; virtual;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Value(FiFo : TQRFiFo) : TQREvResult; override;
  end;

  TQREvElementFunctionClass = class of TQREvElementFunction;

  {$warnings off}
  TQREvElementWrapper = class(TQREvElement)
  private
    FEmbeddedFunction : TQREvElement;
  public
    constructor Create(AEmbeddedFunction : TQREvElement);
    function Value(FiFo : TQRFiFo) : TQREvResult; override;
    property EmbeddedFunction : TQREvElement read FEmbeddedFunction;
  end;

  TQREvEmbeddedFunction = class(TQREvElement)
  private
    Evaluator : TQREvaluator;
    FExpression : string;
    FInEvaluate : boolean;
  public
    constructor Create(Expression : string);
    destructor Destroy; override;
    function Value(FiFo : TQRFiFo) : TQREvResult; override;
    procedure Reset; override;
    function Peek(Index : integer) : TQREvElement;
    function Expression : string;
  end;
  {$warnings on}

  TQREvElementArgumentEnd = class(TQREvElement);

  TQREvElementDataField = class(TQREvElement)
  private
    FDataSet : TDataSet;
    FFieldNo : integer;
    FField : TField;
  public
    constructor CreateField(aField : TField); virtual;
    function Value(FiFo : TQRFiFo) : TQREvResult; override;
  end;

  {$warnings off}
  TQREvElementError = class(TQREvElement)
  private
    FErrorMessage : string;
  public
    constructor Create(ErrorMessage : string);
    function Value(FiFo : TQRFiFo) : TQREvResult; override;
  end;
  {$warnings on}

  { TQREvaluator }
  TQREvaluator = class (TObject)
  private
    OwnDataSets : TList;
    FDataSets : TList;
    FiFo : TQRFiFo;
    FPrepared : boolean;
    FEnvironment : TQREvEnvironment;
    function  EvalEnvironment(strVariable : string) : TQREvResult;
    function  EvalFunctionExpr(const strFunc : string) : TQREvResult;
    function  EvalSimpleExpr(const strSimplExpr : string) : TQREvResult;
    function  EvalTerm(const strTermExpr : string) : TQREvResult;
    function  EvalFactor(strFactorExpr : string) : TQREvResult;
    function  EvalString(const strString : string) : TQREvResult;
    function  EvalConstant(const strConstant : string) : TQREvResult;
    function  GetAggregate : boolean;
    function  Evaluate(const strExpr : string) : TQREvResult;
    procedure FindDelimiter(strArg : string; var Pos : integer);
    procedure SetAggregate(Value : boolean);
    procedure TrimString(var strString : string);
  protected
    function EvalFunction(strFunc : string; const strArg : string) : TQREvResult; virtual;
    function EvalVariable(strVariable : string) : TQREvResult; virtual;
    function GetIsAggreg : boolean;
    function GetDatasets : TList;
    procedure SetDatasets(Value : TList);
  public
    constructor Create;
    destructor Destroy; override;
    function Calculate(const StrExpr : string) : TQREvResult;
    function Value : TQREvResult;
    function AsString : string;
    function AsInteger : integer;
    function AsFloat : extended;
    function AsBoolean : boolean;
    function AsVariant : Variant;
    procedure Prepare(const StrExpr : string);
    procedure Reset;
    procedure UnPrepare;
    procedure DoAggregate;
    property Environment : TQREvEnvironment read FEnvironment write FEnvironment;
    property IsAggreg : boolean read GetIsAggreg;
    property Aggregate : boolean read GetAggregate write SetAggregate;
    property DataSets : TList read GetDatasets write SetDataSets;
    property Prepared : boolean read FPrepared write FPrepared;
  end;

  { TQREvEnvironment }
  TQREvEnvironment = class(TStringList)
  private
    PrepareCount : integer;
    OwnDataSets : TList;
    FDatasets : TList;
  protected
    procedure DefineProperties(Filer : TFiler); override;
    procedure ReadProperties(Reader : TReader);
    procedure WriteProperties(Writer : TWriter);
    function GetDatasets : TList;
    procedure SetDatasets(Value : TList);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddFunction(AName, AExpression : string);
    procedure Clear; override;
    procedure DeleteFunction(AName : string);
    procedure Update;
    procedure Prepare;
    procedure UpdateConstant(Name : string; Value : TQREvResult);
    procedure SetConstant(Constant : TQREvElement; Value : TQREvResult);
    procedure SetStringConstant(Constant : TQREvElement; Value : string);
    procedure SetIntegerConstant(Constant : TQREvElement; Value : integer);
    procedure SetFloatConstant(Constant : TQREvElement; Value : double);
    procedure SetBooleanConstant(Constant : TQREvElement; Value : boolean);
    procedure Unprepare;
    function Prepared : boolean;
    function Value(Name : string) : TQREvResult;
    function Element(Name : string) : TQREvElement;
    function GetConstant(Name : string) : TQREvElement;
    property Datasets : TList read GetDatasets write SetDatasets;
  end;

  { TQRFunctionLibrary }
  TQRFunctionLibrary = class(TQRLibrary)
  public
    function GetFunction(Name : string) : TQREvElement;
  end;

  procedure UpdateConstant(AConstant : TQREvElement; Value : TQREvResult);

  procedure RegisterQRFunction(FunctionClass : TQRLibraryItemClass; Name, Description, Vendor, Arguments : string);

  function QREvResultToString(const AValue : TQREvResult) : string;
  function QREvResultToInt(const AValue : TQREvResult) : integer;
  function QREvResultToFloat(const AValue : TQREvResult) : extended;
  function QREvResultToVariant(const AValue : TQREvResult) : Variant;

  function QRGlobalEnvironment : TQREvEnvironment;

var
  QRFunctionLibrary : TQRFunctionLibrary;

implementation
//uses CustomFunc;

var
  ArgSeparator : Char;
  FGlobalEnvironment : TQREvEnvironment;
  UnpreparingGlobalEnvironment : boolean; { should be moved to interface section }

function QREvResultToString(const AValue : TQREvResult) : string;
begin
  case AValue.Kind of
    resString : Result := AValue.StrResult;
    resInt : Result := IntToStr(AValue.IntResult);
    resDouble : Result := FloatToStr(AValue.DblResult);
    resBool : if AValue.booResult then
                   Result := SqrTrue
                 else
                   Result := SqrFalse;
  else
    Raise Exception.Create(Format(SqrExpError, [AValue.strResult]));
  end;
end;

function QREvResultToInt(const AValue : TQREvResult) : integer;
begin
  case AValue.Kind of
    resInt : Result := AValue.IntResult;
    resDouble : Result := Round(AValue.DblResult);
  else
    Raise Exception.Create(Format(SqrNotValue, [SqrExpNumeric]));
  end;
end;

function QREvResultToFloat(const AValue : TQREvResult) : extended;
begin
  case AValue.Kind of
    resInt : Result := AValue.IntResult;
    resDouble : Result := AValue.DblResult;
  else
    Raise Exception.Create(Format(SqrNotValue, [SqrExpNumeric]));
  end;
end;

function QREvResultToBoolean(const AValue : TQREvResult) : boolean;
begin
  case AValue.Kind of
    resBool : Result := AValue.BooResult;
    resString : if AnsiUppercase(AValue.StrResult) = 'TRUE' then // Do not translate
                  Result := true
                else
                  if AnsiUppercase(AValue.StrResult) = 'FALSE' then // Do not translate
                    Result := false
                  else
                    Raise Exception.Create(Format(SqrNotValue, [SqrExpBoolean]));
  else
    Raise Exception.Create(Format(SqrNotValue, [SqrExpBoolean]));
  end;
end;

function QREvResultToVariant(const AValue : TQREvResult) : Variant;
begin
  case AValue.Kind of
    resString : Result := AValue.StrResult;
    resInt : Result := AValue.IntResult;
    resDouble : Result := AValue.dblResult;
    resBool : Result := AValue.BooResult;
  else
    Raise Exception.Create(Format(SqrExpError, [AValue.StrResult]));
  end;
end;


function QRGlobalEnvironment : TQREvEnvironment;
begin
  Result := FGlobalEnvironment;
end;

{ TQRLibrary }

constructor TQRLibrary.Create;
begin
  inherited Create;
  Entries := TStringList.Create;
end;

destructor TQRLibrary.Destroy;
var
  I : integer;
begin
  for I := 0 to Entries.Count - 1 do
    Entries.Objects[I].Free;
  Entries.Free;
  inherited Destroy;
end;

procedure TQRLibrary.Add(aItem : TQRLibraryItemClass; AName, ADescription, AVendor, AData : string);
var
  aLibraryEntry : TQRLibraryEntry;
begin
  aLibraryEntry := TQRLibraryEntry.Create;
  with aLibraryEntry do
  begin
    Name := AName;
    Description := ADescription;
    Vendor := AVendor;
    Data := AData;
    Item := aItem;
  end;
  Entries.AddObject(aName,aLibraryEntry);
end;

function TQRLibrary.GetEntry(Index : integer) : TQRLibraryEntry;
begin
  if Index <= Entries.Count then
    result := TQRLibraryEntry(Entries.Objects[Index])
  else
    result := nil;
end;

{ TQRFunctionLibrary }

function TQRFunctionLibrary.GetFunction(Name : string) : TQREvElement;
var
  I : integer;
  AObject : TQREvElementFunctionClass;
  aLibraryEntry : TQRLibraryEntry;
begin
  I := Entries.IndexOf(Name);
  if I >= 0 then
  begin
    aLibraryEntry := TQRLibraryEntry(Entry[I]);
    aObject := TQREvElementFunctionClass(aLibraryEntry.Item);
    result := aObject.Create;
  end else
    result := TQREvElementError.Create(Format(SqrExpUnknownFunction, [Name]));
end;

{ TQREvaluator }

constructor TQRFiFo.Create;
begin
  FiFo := TList.Create;
  FAggreg := false;
  FNextItem := 0;
end;

destructor TQRFiFo.Destroy;
var
  I : integer;
begin
  for I := 0 to FiFo.Count-1 do
    TObject(FiFo[I]).Free;
  FiFo.Free;
  inherited Destroy;
end;

procedure TQRFiFo.Start;
begin
  FNextItem := 0;
end;

procedure TQRFiFo.Put(Value : TObject);
begin
  FiFo.Add(Value);
end;

function TQRFiFo.GetAndFree : TObject;
begin
  if FiFo.Count>0 then
  begin
    result := FiFo[0];
    FiFo.Delete(0);
  end else
    result := nil;
end;

function TQRFiFo.Get : TObject;
begin
  if FNextItem<FiFo.Count then
  begin
    result := FiFo[FNextItem];
    inc(FNextItem);
  end else
    result := nil;
end;

{ TQREvElement }

constructor TQREvElement.Create;
begin
  inherited Create;
  FIsAggreg := false;
end;

function TQREvElement.Value(FiFo : TQRFiFo) : TQREvResult;
begin
end;

procedure TQREvElement.Reset;
begin
end;

{ TQREvElementOperator }

type
  TQREvElementOperator = class(TQREvElement)
  private
    FOpCode :  TQREvOperator;
    procedure ConverTQREvResults(var Res1 : TQREvResult; var Res2 : TQREvResult);
  public
    constructor CreateOperator(OpCode : TQREvOperator);
    function Value(FiFo : TQRFiFo) : TQREvResult; override;
  end;

function ErrorCreate(Value : string) : TQREvResult;
begin
  Result.Kind := resError;
  Result.strResult := Value;
end;

constructor TQREvElementOperator.CreateOperator(OpCode : TQREvOperator);
begin
  inherited Create;
  FOpCode := OpCode;
end;

procedure TQREvElementOperator.ConverTQREvResults(var Res1 : TQREvResult; var Res2 : TQREvResult);
begin
  if (Res1.Kind <> resError) and (Res2.Kind <> resError) then
    if Res1.Kind <> Res2.Kind then
    begin
      if ((Res1.Kind = resInt) and (Res2.Kind = resDouble)) then
      begin
        Res1.Kind := resDouble;
        Res1.dblResult := Res1.intResult;
      end else
        if ((Res1.Kind = resDouble) and (Res2.Kind = resInt)) then
        begin
          Res2.Kind := resDouble;
          Res2.dblResult := Res2.intResult;
        end else
        begin
          Res1.StrResult := QREvResultToString(Res1);
          Res1.Kind := resString;
          Res2.StrResult := QREvResultToString(Res2);
          Res2.Kind := resString;
        end;
    end
end;

function TQREvElementOperator.Value(FiFo : TQRFiFo) : TQREvResult;
var
  Res1,
  Res2 : TQREvResult;
begin
  Res1 := TQREvElement(FiFo.Get).Value(FiFo);
  Res2 := TQREvElement(FiFo.Get).Value(FiFo);
  ConverTQREvResults(Res1, Res2);
  Result.Kind := Res1.Kind;
  if Res2.Kind = resError then
    Result.Kind := res2.Kind;
  if result.Kind <> resError then
    case FOpCode of
      opPlus: case result.Kind of
                resInt:    result.intResult := Res1.intResult + Res2.intResult;
                resDouble: result.dblResult := Res1.dblResult + Res2.dblResult;
                resString: result.strResult := Res1.strResult + Res2.strResult;
                resBool:   result := ErrorCreate(Format(SqrExpCannotOperator, [SqrExpAdd, SqrExpBoolean]));
              end;
      opMinus:  case result.Kind of
                  resInt:    result.intResult := Res1.intResult - Res2.intResult;
                  resDouble: result.dblResult := Res1.dblResult - Res2.dblResult;
                  resString: result := ErrorCreate(Format(SqrExpCannotOperator, [SqrExpSubtract, SqrExpString]));
                  resBool:   result := ErrorCreate(Format(SqrExpCannotOperator, [SqrExpSubtract, SqrExpBoolean]));
                end;
      opMul: case result.Kind of
               resInt:    result.intResult := Res1.intResult * Res2.intResult;
               resDouble: result.dblResult := Res1.dblResult * Res2.dblResult;
               resString: result := ErrorCreate(Format(SqrExpCannotOperator, [SqrExpMultiply, SqrExpString]));
               resBool:   result := ErrorCreate(Format(SqrExpCannotOperator, [SqrExpMultiply, SqrExpBoolean]));
             end;
      opDiv: case result.Kind of
               resInt:    if Res2.intResult <> 0 then
                          begin
                            result.dblResult := Res1.intResult / Res2.intResult;
                            result.Kind := resDouble;
                          end else
                            result := ErrorCreate(SqrExpDivideByZero);
               resDouble: if Res2.dblResult <> 0 then
                            result.dblResult := Res1.dblResult / Res2.dblResult
                          else
                            result := ErrorCreate(SqrExpDivideByZero);
               resString: result := ErrorCreate(Format(SqrExpCannotOperator, [SqrExpDivide, SqrExpString]));
               resBool:   result := ErrorCreate(Format(SqrExpCannotOperator, [SqrExpDivide, SqrExpBoolean]));
             end;
      opGreater: begin
                   result.Kind := resBool;
                   case Res1.Kind of
                     resInt:    result.booResult := Res1.intResult > Res2.intResult;
                     resDouble: result.booResult := Res1.dblResult > Res2.dblResult;
                     resString: result.booResult := Res1.strResult > Res2.strResult;
                     resBool:   result := ErrorCreate(Format(SqrExpOperatorNotCompatible, ['>', SqrExpBoolean]));
                   end;
                 end;
      opGreaterOrEqual: begin
                result.Kind := resBool;
                case Res1.Kind of
                  resInt:    result.booResult := Res1.intResult >= Res2.intResult;
                  resDouble: result.booResult := Res1.dblResult >= Res2.dblResult;
                  resString: result.booResult := Res1.strResult >= Res2.strResult;
                  resBool:   result := ErrorCreate(Format(SqrExpOperatorNotCompatible, ['>=', SqrExpBoolean]));
                end;
             end;
      opLess: begin
                result.Kind := resBool;
                case Res1.Kind of
                  resInt:    result.booResult := Res1.intResult < Res2.intResult;
                  resDouble: result.booResult := Res1.dblResult < Res2.dblResult;
                  resString: result.booResult := Res1.strResult < Res2.strResult;
                  resBool:   result := ErrorCreate(Format(SqrExpOperatorNotCompatible, ['<', SqrExpBoolean]));
                end;
              end;
      opLessOrEqual: begin
                 result.Kind := resBool;
                 case Res1.Kind of
                   resInt:    result.booResult := Res1.intResult <= Res2.intResult;
                   resDouble: result.booResult := Res1.dblResult <= Res2.dblResult;
                   resString: result.booResult := Res1.strResult <= Res2.strResult;
                   resBool:   result := ErrorCreate(Format(SqrExpOperatorNotCompatible, ['<=', SqrExpBoolean]));
                 end;
               end;
      opEqual: begin
                 result.Kind := resBool;
                 case Res1.Kind of
                   resInt:    result.booResult := Res1.intResult = Res2.intResult;
                   resDouble: result.booResult := Res1.dblResult = Res2.dblResult;
                   resString: result.booResult := Res1.strResult = Res2.strResult;
                   resBool:   result.booResult := Res1.booResult = Res2.booResult;
                 end;
               end;
      opUnequal: begin
                   result.Kind := resBool;
                   case Res1.Kind of
                     resInt:    result.booResult := Res1.intResult <> Res2.intResult;
                     resDouble: result.booResult := Res1.dblResult <> Res2.dblResult;
                     resString: result.booResult := Res1.strResult <> Res2.strResult;
                     resBool:   result.booResult := Res1.booResult <> Res2.booResult;
                   end;
                 end;
      opOr: begin
              result.Kind := Res1.Kind;
              case Res1.Kind of
                resInt:    result.intResult := Res1.intResult or Res2.intResult;
                resDouble: result := ErrorCreate(Format(SqrExpOperatorNotCompatible, ['OR', SqrExpNumeric]));
                resString: Result := ErrorCreate(Format(SqrExpOperatorNotCompatible, ['OR', SqrExpString]));
                resBool:   result.booResult := Res1.booResult or Res2.booResult;
              end;
            end;
      opAnd: begin
               result.Kind := Res1.Kind;
               case Res1.Kind of
                 resInt:    result.intResult := Res1.intResult and Res2.intResult;
                 resDouble: result := ErrorCreate(Format(SqrExpOperatorNotCompatible, ['AND', SqrExpNumeric]));
                 resString: Result := ErrorCreate(Format(SqrExpOperatorNotCompatible, ['AND', SqrExpString]));
                 resBool:   result.booResult := Res1.booResult and Res2.booResult;
               end;
             end;
    end else
      if Res1.Kind = resError then
        Result := Res1
      else
        Result := Res2;
end;

{ TQREvElementConstant }

type
  TQREvElementConstant = class(TQREvElement)
  private
    FValue : TQREvResult;
  public
    constructor CreateConstant(Value : TQREvResult);
    function Value(FiFo : TQRFiFo) : TQREvResult; override;
  end;

constructor TQREvElementConstant.CreateConstant(Value : TQREvresult);
begin
  inherited Create;
  FValue := Value;
end;

function TQREvElementConstant.Value(FiFo : TQRFiFo): TQREvResult;
begin
  Result := FValue;
end;

{ TQREvElementString }

type
  TQREvElementString = class(TQREvElement)
  private
    FValue : string;
  public
    constructor CreateString(Value : string);
    function Value(FiFo : TQRFiFo) : TQREvResult; override;
  end;

constructor TQREvElementString.CreateString(Value : string);
begin
  inherited Create;
  FValue := Value;
end;

function TQREvElementString.Value(FiFo : TQRFiFo) : TQREvResult;
begin
  result.Kind := resString;
  result.StrResult := FValue;
end;

{ TQREvElementFunction }

constructor TQREvElementFunction.Create;
begin
  inherited Create;
  ArgList := TList.Create;
end;

destructor TQREvElementFunction.Destroy;
begin
  ArgList.Free;
  inherited Destroy;
end;

procedure TQREvElementFunction.GetArguments(FiFo : TQRFiFo);
var
  aArgument : TQREvElement;
  AResult : TQREvResultClass;
begin
  repeat
    aArgument := TQREvElement(FiFo.Get);
    if not (aArgument is TQREvElementArgumentEnd) then
    begin
      aResult := TQREvResultClass.Create;
      aResult.EvResult := aArgument.Value(FiFo);
      ArgList.Add(aResult);
    end;
  until aArgument is TQREvElementArgumentEnd;
end;

procedure TQREvElementFunction.FreeArguments;
var
  I : integer;
begin
  for I := 0 to ArgList.Count - 1 do
    TQREvElement(ArgList.Items[I]).Free;
  ArgList.Clear;
end;

function TQREvElementFunction.Argument(Index : integer): TQREvResult;
begin
  if Index <= ArgList.Count then
    Result := TQREvResultClass(ArgList[Index]).EvResult;
end;

function TQREvElementFunction.Value(FiFo : TQRFiFo) : TQREvResult;
begin
  GetArguments(FiFo);
  if FiFo.Aggreg then
    Aggregate;
  Result := Calculate;
  FreeArguments;
end;

function TQREvElementFunction.ArgumentOK(Value : TQREvElement) : boolean;
begin
  Result := not (Value is TQREvElementArgumentEnd) and not (Value is TQREvElementError);
end;

procedure TQREvElementFunction.Aggregate;
begin
end;

function TQREvElementFunction.Calculate : TQREvResult;
begin
  Result.Kind := resError;
end;

{ TQREvElementDataField }

constructor TQREvElementDataField.CreateField(aField : TField);
begin
  inherited Create;
  FDataSet := aField.DataSet;
  FFieldNo := aField.Index;
  FField := aField;
end;

function TQREvElementDataField.Value(FiFo : TQRFiFo) : TQREvResult;
begin
  if FDataSet.DefaultFields then
    FField := FDataSet.Fields[FFieldNo];
  if FField is TStringField then
  begin
    result.Kind := resString;
    result.strResult := TStringField(FField).Value;
  end
  else if (FField is TIntegerField) or
       (FField is TSmallIntField) or
       (FField is TLargeIntField) or
       (FField is TWordField) then
  begin
      result.Kind := resInt;
      result.intResult := FField.AsInteger;
  end
  // numeric fields
  else if (FField is TBCDField) or
          (FField is TFMTBCDField) then
  begin
        result.Kind := resDouble;
        result.dblResult := TNumericField(FField).AsFloat;
  end
  else if (FField is TFloatField)  or
         (FField is TCurrencyField) or
         (FField.DataType = ftFMTbcd) then
  begin
        result.Kind := resDouble;
        result.dblResult := TFloatField(FField).AsFloat;
  end
  else if FField is TBooleanField then
  begin
        result.Kind := resBool;
        result.BooResult := TBooleanField(FField).Value;
  end
  else if (FField is TDateField) or (FField.DataType = ftTimestamp) then
  begin
       result.Kind := resString;
       result.strResult := TDateField(FField).AsString;
  end
  else if FField is TDateTimeField then
  begin
       result.Kind := resString;
       result.strResult := TDateField(FField).AsString;
  end
  else
      result := ErrorCreate(Format(SqrExpUnknownFieldType, [FField.FieldName]));
end;

constructor TQREvElementError.Create(ErrorMessage : string);
begin
  FErrorMessage := ErrorMessage;
end;

function TQREvElementError.Value(FiFo : TQRFiFo) : TQREvResult;
begin
  Result.Kind := resError;
  Result.strResult := FErrorMessage;
end;

function Flip(aString : string; a, b : char) : string;
var
  ParLevel : integer;
  isString : boolean;
  I : integer;
  aChar : string;
begin
  ParLevel := 0;
  isString := False;
  I := 1;
  while I <= Length(aString) do
  begin
    aChar := aString[I];
    if aChar = '''' then
      isString := not IsString
    else
      if not isString then
      begin
        if aChar = '(' then
          inc(ParLevel)
        else
          if aChar = ')' then
            dec(parLevel)
          else
            if ParLevel = 0 then
              if aChar = a then
                aString[I] := b
              else
                if aChar = b then
                  aString[I] := a;
     end;
     inc(i);
   end;
   result := aString;
end;

{ TQREvaluator }

constructor TQREvaluator.Create;
begin
  Prepared := false;
  Environment := nil;
  FDatasets := nil;
  OwnDatasets := nil;
end;

destructor TQREvaluator.Destroy;
begin
  if Prepared then Unprepare;
  if (FDatasets <> nil) and (FDataSets = OwnDatasets) then
    FDatasets.Free;
  inherited Destroy;
end;

procedure TQREvaluator.SetDatasets(Value : TList);
begin
  if (FDatasets <> nil) and (FDatasets <> Value) and (FDatasets = OwnDatasets) then
    FDatasets.Free;
  FDatasets := Value;
end;

function TQREvaluator.GetDatasets : TList;
begin
  if FDatasets = nil then
  begin
    FDatasets := TList.Create;
    OwnDatasets := FDatasets;
  end;
  Result := FDatasets;
end;

procedure TQREvaluator.TrimString(var strString : string);
var
  intStart,
  intEnd : integer;
begin
  intStart := 1;
  intEnd := Length(strString);
  while (strString[intStart] = ' ') and (intStart < intEnd) do
    inc(intStart);
  while (strString[intEnd] = ' ') and (intEnd > intStart) do
    dec(intEnd);
  strString := Copy(strString, intStart, intEnd - intStart + 1);
end;

procedure TQREvaluator.FindDelimiter(strArg : string; var Pos : integer);
var
  n : integer;
  FoundDelim : boolean;
  booString : boolean;
  intParenteses : integer;
begin
  if strArg='' then
    Pos := 0
  else
  begin
    FoundDelim := false;
    BooString := false;
    intParenteses := 0;
    N := 1;
    while (N<length(strArg)) and not FoundDelim do
    begin
      case StrArg[N] of
        '(' : if not booString then inc(intParenteses);
        ')' : if not booString then dec(intParenteses);
        '''' : booString := not booString;
      end;
      if (intParenteses=0) and not booString then
        if strArg[N]=ArgSeparator then
        begin
          FoundDelim := true;
          break;
        end;
      inc(N);
    end;
    if FoundDelim then
      Pos := N
    else
      Pos := 0;
  end;
end;

function TQREvaluator.EvalEnvironment(strVariable : string) : TQREvResult;
var
  AElement : TQREvElement;
begin
  if (FEnvironment <> nil) then
  begin
    AElement := FEnvironment.Element(strVariable);
    if AElement is TQREvElementError then
    begin
      AElement.Free;
      AElement := FGlobalEnvironment.Element(strVariable);
    end
  end else
    AElement := FGlobalEnvironment.Element(strVariable);
  FiFo.Put(AElement);
end;

function TQREvaluator.EvalVariable(strVariable : string) : TQREvResult;
var
  SeparatorPos : integer;
  DSName : string;
  FieldName : string;
  aDataSet : TDataSet;
  aField : TField;
  I : integer;
begin
  if assigned(FDataSets) then
  begin
    SeparatorPos := AnsiPos('.', strVariable);
    DSName := AnsiUpperCase(copy(StrVariable, 1, SeparatorPos - 1));
    FieldName := AnsiUpperCase(copy(strVariable, SeparatorPos + 1, length(StrVariable) - SeparatorPos));
    aField := nil;
    aDataSet := nil;
    if length(DSName) > 0 then
    begin
      for I := 0 to FDataSets.Count - 1 do
        if AnsiUpperCase(TDataSet(FDataSets[I]).Name) = DSName then
        begin
          aDataSet := TDataSet(FDataSets[I]);
          break;
        end;
      if aDataSet<>nil then
        aField := aDataSet.FindField(FieldName);
    end else
    begin
      for I := 0 to FDataSets.Count - 1 do
        with TDataSet(FDataSets[I]) do
        begin
          aField := FindField(FieldName);
          if aField <> nil then break;
        end;
    end;
    if aField <> nil then
      FiFo.Put(TQREvElementDataField.CreateField(aField))
    else
      EvalEnvironment(strVariable);
  end else
    EvalEnvironment(strVariable);
end;

function TQREvaluator.EvalString(const strString : string) : TQREvResult;
begin
  result.Kind := resString;
  result.strResult := strString;
  FiFo.Put(TQREvElementString.CreateString(Result.StrResult));
end;

function TQREvaluator.EvalFunction(strFunc : string; const strArg : string) : TQREvResult;
var
  DelimPos : integer;
  aString : string;
  Res : TQREvResult;
  aFunc : TQREvElement;
begin
  StrFunc := AnsiUpperCase(StrFunc);
  aFunc := QRFunctionLibrary.GetFunction(strFunc);
  if AFunc is TQREvElementError then
  begin
    if StrArg = '' then
    begin
      AFunc.Free;
      EvalVariable(StrFunc)
    end else
      FiFo.Put(AFunc);
  end else
  begin
    FiFo.Put(AFunc);
    if not (aFunc is TQREvElementError) then
    begin
      aString := strArg;
      repeat
        FindDelimiter(aString, DelimPos);
        if DelimPos > 0 then
          Res := Evaluate(copy(aString, 1, DelimPos - 1))
        else
          if length(aString) > 0 then Res := Evaluate(aString);
        Delete(aString, 1, DelimPos);
      until DelimPos = 0;
    end;
    FiFo.Put(TQREvElementArgumentEnd.Create);
  end;
end;

function TQREvaluator.EvalConstant(const strConstant : string) : TQREvResult;
var
  N : integer;
  aString : string;
begin
  N := 1;
  aString := strConstant;
  while (N <= Length(aString)) and  (aString[N] in ['0'..'9']) do
    inc(N);
  result.Kind := resInt;
  while ((N <= Length(aString)) and (aString[N] in ['0'..'9', '.', 'e', 'E', '+', '-'])) do
  begin
    inc(N);
    result.Kind := resDouble;
  end;
  if N - 1 <> Length(aString) then
    result := ErrorCreate(Format(SqrExpIllegalCharInNumeric, [aString]))
  else
  begin
    if result.Kind = resInt then
    begin
      try
        result.intResult := StrToInt(aString)
      except
        result.Kind := resDouble;
      end;
    end;
    if result.Kind = resDouble then
    begin
      if DecimalSeparator <> '.' then
      begin
        while pos('.', aString) > 0 do
          aString[pos('.', aString)] := DecimalSeparator;
      end;
      try
        result.dblResult := StrToFloat(aString);
      except
        result := ErrorCreate(Format(SqrExpIllegalCharInNumeric, [aString]))
      end;
    end;
  end;
  if result.Kind = resError then
    FiFo.Put(TQREvElementError.Create(Result.strResult))
  else
    FiFo.Put(TQREvElementConstant.CreateConstant(Result));
end;

function TQREvaluator.EvalFunctionExpr(const strFunc : string) : TQREvResult;
var
  argRes : TQREvResult;
  po : integer;
begin
  po := AnsiPos('(', StrFunc);
  if po > 0 then
  begin
    if strFunc[length(StrFunc)] = ')' then
    begin
      result := EvalFunction(copy(StrFunc, 1, po - 1), copy(StrFunc, po + 1, length(strFunc) - po - 1));
    end else
    begin
//      Result := ErrorCreate(Format(SqrExpMissing, [')']));
//      argRes.Kind := resError;
      result := EvalFunction('', '');
    end;
  end else
  begin
    argRes.Kind := resError;
    result := EvalFunction(StrFunc, '');
  end;
end;

function TQREvaluator.EvalFactor(strFactorExpr : string) : TQREvResult;
var
  aString : string[255];
  aResult : TQREvResult;
begin
  TrimString(strFactorExpr);
  aString := strFactorExpr;
  if (AnsiLowerCase(Copy(strFactorExpr, 1, 3)) = 'not') then
  begin
    aResult := EvalSimpleExpr(Copy(strFactorExpr, 4, Length(strFactorExpr)));
    if aResult.Kind = resBool then
    begin
      Result.booResult := not aResult.booResult;
      Result.Kind := aResult.Kind;
    end else
      Result := ErrorCreate(SqrInvalidNot);
  end else
    case aString[1] of
      '(' : if strFactorExpr[Length(strFactorExpr)] = ')' then
              result := Evaluate(Copy(strFactorExpr, 2, Length(strFactorExpr) - 2))
            else
            begin
              result := ErrorCreate(Format(SqrExpMissing, [')']));
              FiFo.Put(TQREvElementError.Create(Result.strResult));
            end;
      '-' : result := EvalSimpleExpr('0-' + Copy(strFactorExpr, 2, Length(strFactorExpr)));
      '+' : result := EvalFactor(Copy(strFactorExpr, 2, Length(strFactorExpr)));
      '0'..'9' : result := EvalConstant(strFactorExpr);
      '''' : if aString[Length(strFactorExpr)] = '''' then
               result := EvalString(Copy(strFactorExpr, 2, Length(strFactorExpr) - 2))
             else
             begin
               Result := ErrorCreate(Format(SqrExpMissing, [')']));
               FiFo.Put(TQREvElementError.Create(Result.strResult));
             end;
{$ifdef ver100}
      '[' : if (aString[Length(strFactorExpr)] = ']') and
              (ByteType(strFactorExpr, Length(strFactorExpr)) = mbSingleByte) then
{$else}
      '[' : if aString[Length(strFactorExpr)] = ']' then
{$endif}
              result := EvalVariable(Copy(strFactorExpr, 2, Length(strFactorExpr) - 2))
            else
            begin
              Result := ErrorCreate(Format(SqrExpMissing, [']']));
              FiFo.Put(TQREvElementError.Create(Result.strResult));
            end;
      'A'..'Z', 'a'..'z' : result := EvalFunctionExpr(strFactorExpr);
    else
    begin
      result := ErrorCreate(Format(SqrExpError, [aString]));
      FiFo.Put(TQREvElementError.Create(Result.strResult));
    end;
  end;
end;

function TQREvaluator.EvalSimpleExpr(const strSimplExpr : string) : TQREvResult;
var
  Op : TQREvOperator;
  intStart,
  intLen : integer;
  Res1,
  Res2 : TQREvResult;
  n : integer;
  intParenteses : integer;
  booFound : boolean;
  booString : boolean;
  booBracket : boolean;
begin
  n := 1;
  Op := TQREvOperator(nil);
  intParenteses := 0;
  booFound := false;
  booString := false;
  booBracket := false;
  intLen := 1;
  while (n < Length(strSimplExpr)) and (not booFound) do
  begin
    booFound := true;
    case strSimplExpr[N] of
      '(' : if not (booString or booBracket) then inc(intParenteses);
      ')' : if not (booString or booBracket) then dec(intParenteses);
      '[' : if not (booString or booBracket) then booBracket := true;
      ']' : if (not booString) and booBracket then booBracket := false;
      '''': if (not booBracket) then booString := not booString;
    end;
    if (intParenteses = 0) and (not (booString or booBracket)) and (N > 1) then
      case strSimplExpr[N] of
        '+' : Op := opPlus;
        '-' : Op := opMinus;
        ' ' : if (AnsiLowercase(copy(strSimplExpr, N + 1, 3)) = 'or ') then
              begin
                Op := opOr;
                intLen := 2;
                inc(N);
              end else
                booFound := false;
      else
        booFound := false;
    end else
      booFound := false;
    inc(N);
  end;
  if booFound then
    intStart := N - 1
  else
    intStart := -1;
  if intStart > 0 then
  begin
    FiFo.Put(TQREvElementOperator.CreateOperator(Op));
    Res1 := EvalTerm(Copy(strSimplExpr, 1, intStart - 1));
    if Op = opMinus then
      Res2 := EvalSimpleExpr(Flip(Copy(strSimplExpr, intStart + intLen, Length(strSimplExpr)), '+', '-'))
    else
      Res2 :=EvalSimpleExpr(Copy(strSimplExpr, intStart + intLen, Length(strSimplExpr)))
  end else
    result := EvalTerm(strSimplExpr);
end;

function TQREvaluator.EvalTerm(const strTermExpr : string) : TQREvResult;
var
  Op : TQREvOperator;
  intStart,
  intLen : integer;
  Res1,
  Res2 : TQREvResult;
  N : integer;
  booString : boolean;
  booFound : boolean;
  booBracket : boolean;
  intParenteses : integer;
begin
  n := 1;
  Op := TQREvOperator(nil);
  intParenteses := 0;
  booFound := false;
  booString := false;
  booBracket := false;
  intLen := 1;
  while (N < Length(strTermExpr)) and (not booFound) do
  begin
    booFound := true;
    case strTermExpr[N] of
      '(' : if not (booString or booBracket) then inc(intParenteses);
      ')' : if not (booString or booBracket) then dec(intParenteses);
      '[' : if not (booString or booBracket) then booBracket := true;
      ']' : if (not booString) and booBracket then booBracket := false;
      '''': if (not booBracket) then booString := not booString;
    end;
    if (intParenteses = 0) and (not (booString or booBracket)) and (N > 1) then
    begin
      case strTermExpr[N] of
        '*' : Op := opMul;
        '/' : Op := opDiv;
        ' ' : if (AnsiLowercase(copy(strTermExpr, n + 1, 4)) = 'and ') then
              begin
                Op := opAnd;
                IntLen := 3;
                inc(N);
              end else
                booFound := false;
      else
        booFound := false;
    end;
  end else
    booFound := false;
    inc(N);
  end;
  if booFound then
    intStart := N - 1
  else
    intStart := -1;
  if intStart > 0 then
  begin
    FiFo.Put(TQREvElementOperator.CreateOperator(Op));
    Res1 := EvalFactor(Copy(strTermExpr, 1, intStart - 1));
    if Op = opDiv then
      Res2 := EvalTerm(Flip(Copy(strTermExpr, intStart + intLen, Length(strTermExpr)), '*', '/'))
    else
      Res2 := EvalTerm(Copy(strTermExpr, intStart + intLen, Length(strTermExpr)));
  end else
    result := EvalFactor(strTermExpr);
end;

function TQREvaluator.Evaluate(const strExpr : string) : TQREvResult;
var
  n : integer;
  booFound : boolean;
  intParenteses : integer;
  booString : boolean;
  booBracket : boolean;
  Op : TQREvOperator;
  intStart,
  intLen : integer;
  Res1,
  Res2 : TQREvResult;
begin
  Op := OpEqual;
  n := 1;
  intParenteses := 0;
  booFound := false;
  intLen := 1;
  booString := false;
  booBracket := false;
  while (n < Length(strExpr)) and (not booFound) do
  begin
    booFound := true;
    case StrExpr[N] of
      '(' : if not (booString or booBracket) then inc(intParenteses);
      ')' : if not (booString or booBracket) then dec(intParenteses);
      '[' : if not (booString or booBracket) then booBracket := true;
      ']' : if (not booString ) and booBracket then booBracket := false;
      '''': if (not booBracket) then booString := not booString;
    end;
    if (intParenteses = 0) and (n > 1) and not (booString  or booBracket) then
      case StrExpr[N] of
        '<' : begin
                if StrExpr[N + 1] = '>' then
                begin
                  Op := opUnequal;
                  intLen := 2;
                end else
                  if StrExpr[N + 1] = '=' then
                  begin
                    Op := opLessOrEqual;
                    intLen := 2;
                  end else
                    Op := opLess;
                end;
        '>' : if StrExpr[N + 1] = '=' then
              begin
                Op := opGreaterOrEqual;
                intLen := 2;
              end else
                Op := opGreater;
        '=' : Op := opEqual;
      else
        booFound := false;
      end
    else
      booFound := false;
    inc(N);
  end;
  if booFound then
    IntStart := n - 1
  else
    IntStart := -1;
  if intStart > 0 then
  begin
    FiFo.Put(TQREvElementOperator.CreateOperator(Op));
    Res1 := EvalSimpleExpr(Copy(strExpr, 1, intStart - 1));
    Res2 := EvalSimpleExpr(Copy(strExpr, intStart + intLen, Length(strExpr)));
  end else
    result := EvalSimpleExpr(strExpr);
end;

procedure TQREvaluator.Prepare(const strExpr : string);
var
  Value : TQREvResult;
begin
  if Prepared then Unprepare;
  QRGlobalEnvironment.Prepare;
  FiFo := TQRFiFo.Create;
  if strExpr = '' then
    Value := Evaluate(''' ''')
  else
    Value := Evaluate(strExpr);
  Prepared := true;
end;

procedure TQREvaluator.UnPrepare;
begin
  //FiFo.Free;
  FreeAndNil(FiFo);
  QRGlobalEnvironment.Unprepare;
  Prepared := false;
end;

procedure TQREvaluator.Reset;
var
  I : integer;
begin
  for I := 0 to FiFo.FiFo.Count - 1 do
    TQREvElement(FiFo.FiFo[I]).Reset;
end;

function TQREvaluator.Value : TQREvResult;
var
  F : TObject;
begin
  if not Prepared then
    Raise Exception.Create(SqrEvalNotPrepared);
  if assigned(fifo) then
  begin
    FiFo.Start;
    F := FiFo.Get;
  end
  else
    f := nil;
  if F = nil then
    Result.Kind := resError
  else
    Result := TQREvElement(F).Value(FiFo);
end;

procedure TQREvaluator.DoAggregate;
begin
  Aggregate := true;
  Value;
  Aggregate := false;
end;

function TQREvaluator.AsString : string;
var
  AValue : TQREvResult;
begin
  AValue := Value;
  case AValue.Kind of
    resString : Result := AValue.StrResult;
    resInt : Result := IntToStr(AValue.IntResult);
    resDouble : Result := FloatToStr(AValue.DblResult);
    resBool : if AValue.booResult then
                   Result := SqrTrue
                 else
                   Result := SqrFalse;
  else
    Raise Exception.Create(Format(SqrExpError, [AValue.strResult]));
  end;
end;

function TQREvaluator.AsInteger : integer;
var
  AValue : TQREvResult;
begin
  AValue := Value;
  case AValue.Kind of
    resInt : Result := AValue.IntResult;
    resDouble : Result := Round(AValue.DblResult);
  else
    Raise Exception.Create(Format(SqrNotValue, [SqrExpNumeric]));
  end;
end;

function TQREvaluator.AsFloat : extended;
var
  AValue : TQREvResult;
begin
  AValue := Value;
  case AValue.Kind of
    resInt : Result := AValue.IntResult;
    resDouble : Result := AValue.DblResult;
  else
    Raise Exception.Create(Format(SqrNotValue, [SqrExpNumeric]));
  end;
end;

function TQREvaluator.AsBoolean : boolean;
var
  AValue : TQREvResult;
begin
  AValue := Value;
  case AValue.Kind of
    resBool : Result := AValue.BooResult;
    resString : if AnsiUppercase(AValue.StrResult) = 'TRUE' then // Do not translate
                  Result := true
                else
                  if AnsiUppercase(AValue.StrResult) = 'FALSE' then // Do not translate
                    Result := false
                  else
                    Raise Exception.Create(Format(SqrNotValue, [SqrExpBoolean]));
  else
    Raise Exception.Create(Format(SqrNotValue, [SqrExpBoolean]));
  end;
end;

function TQREvaluator.AsVariant : Variant;
var
  AValue : TQREvResult;
begin
  AValue := Value;
  case AValue.Kind of
    resString : Result := AValue.StrResult;
    resInt : Result := AValue.IntResult;
    resDouble : Result := AValue.dblResult;
    resBool : Result := AValue.BooResult;
  else
    Raise Exception.Create(Format(SqrExpError, [AValue.StrResult]));
  end;
end;

function TQREvaluator.GetIsAggreg : boolean;
var
  I : integer;
begin
  Result := false;
  for I := 0 to FiFo.FiFo.Count - 1 do
    Result := Result or TQREvElement(FiFo.FiFo[I]).IsAggreg;
end;

function TQREvaluator.GetAggregate : boolean;
begin
  Result := FiFo.Aggreg;
end;

procedure TQREvaluator.SetAggregate(Value : boolean);
begin
  FiFo.Aggreg := Value;
end;

function TQREvaluator.Calculate(const strExpr : string) : TQREvResult;
begin
  Prepare(strExpr);
  result := Value;
  UnPrepare;
end;

{ Expression evaluator functions }

{ TQREvTrue }

type
  TQREvTrue = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

  TQREvFalse = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

function TQREvTrue.Calculate : TQREvResult;
begin
  if ArgList.Count = 0 then
  begin
    Result.Kind := resBool;
    Result.booResult := true;
  end else
    Result := ErrorCreate(SqrExpTooManyArgs);
end;

function TQREvFalse.Calculate : TQREvResult;
begin
  if ArgList.Count = 0 then
  begin
    Result.Kind := resBool;
    Result.booResult := false;
  end else
    Result := ErrorCreate(SqrExpTooManyArgs);
end;

{ TQREvIfFunction }

type
  TQREvIfFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

function TQREvIfFunction.Calculate : TQREvResult;
begin
  if (ArgList.Count = 3) and (Argument(0).Kind = resBool) then
  begin
    if Argument(0).BooResult then
      Result := Argument(1)
    else
      Result := Argument(2);
  end else
    Result := ErrorCreate(Format(SqrExpWrongArguments, ['IF'])); // Do not translate
end;

{ TQREvTypeOfFunction }

type
  TQREvTypeOfFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

function TQREvTypeOfFunction.Calculate : TQREvResult;
begin
  Result.Kind := resString;
  if ArgList.Count = 1 then
  begin
    case Argument(0).Kind of
      resInt : Result.StrResult := 'INTEGER';    // Do not translate
      resDouble : Result.StrResult := 'FLOAT';   // Do not translate
      resString : Result.StrResult := 'STRING';  // Do not translate
      resBool : Result.StrResult := 'BOOLEAN';   // Do not translate
      resError : Result.StrResult := 'ERROR';    // Do not translate
    else
      Result := ErrorCreate(SqrExpUnknownType);
    end
  end else
    Result := ErrorCreate(Format(SqrExpWrongArguments, ['TypeOf'])); // Do not translate
end;

{ TQREvIntFunction }

type
  TQREvIntFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

function TQREvIntFunction.Calculate : TQREvResult;
begin
  Result.Kind := resInt;
  if ArgList.Count = 1 then
  begin
    case Argument(0).Kind of
      resInt : Result.IntResult := Argument(0).IntResult;
      resDouble : Result.IntResult := Round(Int(Argument(0).DblResult));
    else
      Result := ErrorCreate(Format(SqrExpWrongArguments, ['INT'])); // Do not translate
    end
  end else
    Result := ErrorCreate(Format(SqrExpWrongArguments, ['INT'])); // Do not translate
end;

{ TQREvFracFunction }

type
  TQREvFracFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

function TQREvFracFunction.Calculate : TQREvResult;
begin
  Result.Kind := resDouble;
  if ArgList.Count = 1 then
  begin
    case Argument(0).Kind of
      resInt : Result.DblResult := 0;
      resDouble : Result.DblResult := Frac(Argument(0).DblResult);
    else
      Result.Kind := resError;
    end
  end else
    Result.Kind := resError;
end;

{ TQREvSQRTFunction }

type
  TQREvSQRTFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

function TQREvSQRTFunction.Calculate : TQREvResult;
begin
  Result.Kind := resDouble;
  if ArgList.Count = 1 then
  begin
    try
      case Argument(0).Kind of
        resInt : Result.DblResult := SQRT(Argument(0).IntResult);
        resDouble : Result.DblResult := SQRT(Argument(0).DblResult);
      else
        Result.Kind := resError;
      end
    except
      Result.Kind := resError
    end;
  end else
    Result.Kind := resError;
  if Result.Kind = resError then
    Result.StrResult := SqrSQRTInvalid;
end;

type
  TQREvDivFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

function TQREvDivFunction.Calculate : TQREvResult;
var
  v1, v2 : Longint;
begin
  if (ArgList.Count = 2) and
     ((Argument(0).Kind = ResInt) or (Argument(0).Kind = resDouble)) and
     ((Argument(1).Kind = ResInt) or (Argument(1).Kind = resDouble)) then
  begin
    Result.Kind := ResInt;
    if Argument(0).Kind = ResInt then
      v1 := Argument(0).intResult
    else
      v1 := Round(Argument(0).dblResult);
    if Argument(1).Kind = ResInt then
      v2 := Argument(1).intResult
    else
      v2 := Round(Argument(1).dblResult);
    if v2 <> 0 then
      Result.IntResult := v1 div v2
    else
    begin
      Result.Kind := resError;
      Result.strResult := SqrDivisionByZero;
    end
  end else
  begin
    Result.Kind := resError;
    Result.StrResult := Format(SqrExpWrongArguments, ['DIV']);
  end;
end;

{ TQREvStrFunction }

type
  TQREvStrFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

function TQREvStrFunction.Calculate : TQREvResult;
var
  ArgRes : TQREvResult;
begin
  if ArgList.Count = 1 then
  begin
    ArgRes := Argument(0);
    Result.Kind := resString;
    case ArgRes.Kind of
      resInt : Result.strResult := IntToStr(ArgRes.IntResult);
      resDouble : Result.strResult := FloatToStr(ArgRes.DblResult);
      resBool : if ArgRes.booResult then
                result.StrResult := 'True' // Do not translate
              else
                result.StrResult := 'False'; // Do not translate
    else
      result.Kind := resError;
    end
  end else
    Result.Kind := resError;
  if Result.Kind = resError then
    Result.strResult := SqrConversionError;
end;

{ TQREvUpperFunction }

type
  TQREvUpperFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

function TQREvUpperFunction.Calculate : TQREvResult;
begin
  if (ArgList.Count = 1) and (Argument(0).Kind = resString) then
  begin
    Result.Kind := resString;
    Result.StrResult := AnsiUpperCase(Argument(0).StrResult);
  end else
  begin
    Result.Kind := resError;
    if ArgList.Count = 1 then
      Result.strResult :=Argument(0).strResult
    else
      Result.strResult := Format(SqrMissingArgument, ['UPPER']);
  end;
end;

{ TQREvLowerFunction }

type
  TQREvLowerFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

function TQREvLowerFunction.Calculate : TQREvResult;
begin
  if (ArgList.Count = 1) and (Argument(0).Kind = resString) then
  begin
    Result.Kind := resString;
    Result.StrResult := AnsiLowerCase(Argument(0).StrResult);
  end else
  begin
    Result.Kind := resError;
    if ArgList.Count = 1 then
      Result.strResult :=Argument(0).strResult
    else
      Result.strResult := Format(SqrMissingArgument, ['LOWER']);
  end;
end;

{ TQREvUpperFunction }

type
  TQREvPrettyFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

function TQREvPrettyFunction.Calculate : TQREvResult;
begin
  if (ArgList.Count = 1) and (Argument(0).Kind = resString) then
  begin
    Result.Kind := resString;

    if (Length(Argument(0).StrResult) > 0) and (Argument(0).StrResult[1] in LeadBytes) then
      Result.StrResult := AnsiUpperCase(Copy(Argument(0).StrResult, 1, 2)) +
                          AnsiLowerCase(Copy(Argument(0).StrResult, 3, length(Argument(0).StrResult)))
    else
      Result.StrResult := AnsiUpperCase(Copy(Argument(0).StrResult, 1, 1)) +
                          AnsiLowerCase(Copy(Argument(0).StrResult, 2, length(Argument(0).StrResult)));
  end else
  begin
    Result.Kind := resError;
    if ArgList.Count = 1 then
      Result.strResult :=Argument(0).strResult
    else
      Result.strResult := Format(SqrMissingArgument, ['PRETTY']);
  end;
end;

{ TQREvTimeFunction }

type
  TQREvTimeFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

function TQREvTimeFunction.Calculate : TQREvResult;
begin
  if ArgList.Count = 0 then
  begin
    Result.Kind := resString;
    Result.StrResult := TimeToStr(Now);
  end else
    Result.Kind := resError;
end;

{ TQREvTimeFunction }

type
  TQREvDateFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

function TQREvDateFunction.Calculate : TQREvResult;
begin
  if ArgList.Count=0 then
  begin
    Result.Kind := resString;
    Result.StrResult := DateToStr(Date);
  end else
    Result.Kind := resError;
end;

{ TQREvCopyFunction }

type
  TQREvCopyFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

function TQREvCopyFunction.Calculate : TQREvResult;
var
  Start, Len : integer;
begin
  if (ArgList.Count = 3) and
    (Argument(0).Kind = resString) and
    (Argument(1).Kind = resInt) and
    (Argument(2).Kind = resInt) then
  begin
    Start := Argument(1).IntResult;
    Len   := Argument(2).IntResult;
    if (Start = 0) then Start := 1;
    if (ByteType(Argument(0).strResult, Start) = mbTrailByte) and (Len > 0) then
    begin
      Inc(Start);
      Dec(Len);
    end;
    if (ByteType(Argument(0).strResult, Start + Len - 1) = mbLeadByte) and (Len > 0) then Dec(Len);
    Result.StrResult := copy(Argument(0).strResult, Start, Len);
    Result.Kind := resString;
  end else
    Result.Kind := resError;
end;

{ TQREvFormatNumericFunction }

type
  TQREvFormatNumericFunction = class(TQREvElementFunction)
  public
    function Calculate : TQREvResult; override;
  end;

function TQREvFormatNumericFunction.Calculate : TQREvResult;
begin
  if (ArgList.Count = 2) and
     ((Argument(1).Kind = resInt) or (Argument(1).Kind = resDouble)) and
     (Argument(0).Kind = resString) then
  begin
    Result.Kind := resString;
    try
      if Argument(1).Kind = resInt then
        Result.StrResult := FormatFloat(Argument(0).StrResult, Argument(1).IntResult * 1.0)
      else
        Result.StrResult := FormatFloat(Argument(0).StrResult, Argument(1).DblResult);
    except
      Result.Kind := resError;
      Result.StrResult := SqrInvalidFormatnumeric;
    end;
  end else
    Result.Kind := resError;
end;

{ TQREvSumFunction }

type
  TQREvSumFunction = class(TQREvElementFunction)
  private
    SumResult : TQREvResult;
    ResAssigned : boolean;
  public
    constructor Create; override;
    procedure Aggregate; override;
    function Calculate : TQREvResult; override;
    procedure Reset; override;
  end;

constructor TQREvSumFunction.Create;
begin
  inherited Create;
  ResAssigned := false;
  IsAggreg := true;
end;

procedure TQREvSumFunction.Reset;
begin
  ResAssigned := false;
end;

procedure TQREvSumFunction.Aggregate;
var
  aValue : TQREvResult;
begin
  if ArgList.Count = 1 then
  begin
    aValue := Argument(0);
    if ResAssigned then
    begin
      case aValue.Kind of
        resInt : SumResult.IntResult := SumResult.IntResult + aValue.IntResult;
        resDouble : SumResult.dblResult := SumResult.dblResult + aValue.dblResult;
        resString : SumResult.Kind := resError;
      end;
    end else
    begin
      SumResult.Kind := aValue.Kind;
      case aValue.Kind of
        resInt : SumResult.IntResult := aValue.IntResult;
        resDouble : SumResult.dblResult := aValue.dblResult;
      else
        SumResult.Kind := resError;
      end;
    end;
    ResAssigned := true;
  end else
    SumResult.Kind := resError;
end;

function TQREvSumFunction.Calculate : TQREvResult;
begin
  if ResAssigned then
    Result := SumResult
  else
  begin
    Result.Kind := resInt;
    Result.intResult := 0;
  end;
end;

{ TQREvAverageFunction }

type
  TQREvAverageFunction = class(TQREvSumFunction)
  private
    Count : longint;
    aResult : TQREvResult;
  public
    function Calculate : TQREvResult; override;
    procedure Aggregate; override;
    procedure Reset; override;
  end;

procedure TQREvAverageFunction.Reset;
begin
  inherited Reset;
  aResult.Kind := resDouble;
  aResult.dblResult := 0;
  Count := 0;
  IsAggreg := true;
end;

procedure TQREvAverageFunction.Aggregate;
var
  aValue : TQREvResult;
begin
  inherited Aggregate;
  inc(Count);
  aValue := inherited Calculate;
  aResult.Kind := resDouble;
  case aValue.Kind of
    ResInt : aResult.DblResult := aValue.IntResult / Count;
    ResDouble : aResult.DblResult := aValue.DblResult / Count;
  else
    aResult.Kind := resError;
  end;
end;

function TQREvAverageFunction.Calculate : TQREvResult;
begin
  Result := aResult
end;

{ TQREvMaxFunction }

type
  TQREvMaxFunction = class(TQREvElementFunction)
  private
    MaxResult : TQREvResult;
    ResAssigned : boolean;
  public
    constructor Create; override;
    function Calculate : TQREvResult; override;
    procedure Aggregate; override;
    procedure Reset; override;
  end;

constructor TQREvMaxFunction.Create;
begin
  inherited Create;
  ResAssigned := false;
  IsAggreg := true;
end;

procedure TQREvMaxFunction.Reset;
begin
  ResAssigned := false;
end;

procedure TQREvMaxFunction.Aggregate;
var
  aValue : TQREvResult;
begin
  if ArgList.Count = 1 then
  begin
    aValue := Argument(0);
    if ResAssigned then
    begin
      case MaxResult.Kind of
        resInt : if aValue.IntResult > MaxResult.IntResult then
                   MaxResult.IntResult := aValue.IntResult;
        resDouble : if aValue.DblResult > MaxResult.DblResult then
                      MaxResult.DblResult := aValue.DblResult;
        resString : if aValue.StrResult > MaxResult.StrResult then
                      MaxResult.StrResult := aValue.StrResult;
        resBool : if aValue.booResult > MaxResult.BooResult then
                    MaxResult.BooResult := aValue.BooResult;
      else
        MaxResult.Kind := resError;
      end
    end else
    begin
      MaxResult := aValue;
      ResAssigned := true;
    end
  end else
    MaxResult.Kind := resError;
end;

function TQREvMaxFunction.Calculate : TQREvResult;
begin
  if ResAssigned then
    Result := MaxResult
  else
  begin
    Result.Kind := resInt;
    Result.IntResult := 0;
  end;
end;

{ TQREvMinFunction }

type
  TQREvMinFunction = class(TQREvElementFunction)
  private
    MinResult : TQREvResult;
    ResAssigned : boolean;
  public
    constructor Create; override;
    function Calculate : TQREvResult; override;
    procedure Aggregate; override;
    procedure Reset; override;
  end;

constructor TQREvMinFunction.Create;
begin
  inherited Create;
  ResAssigned := false;
  IsAggreg := true;
end;

procedure TQREvMinFunction.Reset;
begin
  ResAssigned := false;
end;

procedure TQREvMinFunction.Aggregate;
var
  aValue : TQREvResult;
begin
  if ArgList.Count = 1 then
  begin
    aValue := Argument(0);
    if ResAssigned then
    begin
      case MinResult.Kind of
        resInt : if aValue.IntResult < MinResult.IntResult then
                   MinResult.IntResult := aValue.IntResult;
        resDouble : if aValue.DblResult < MinResult.DblResult then
                      MinResult.DblResult := aValue.DblResult;
        resString : if aValue.StrResult < MinResult.StrResult then
                      MinResult.StrResult := aValue.StrResult;
        resBool : if aValue.booResult > MinResult.BooResult then
                    MinResult.BooResult := aValue.BooResult;
      else
        MinResult.Kind := resError;
      end
    end else
    begin
      MinResult := aValue;
      ResAssigned := true;
    end
  end else
    MinResult.Kind := resError;
end;

function TQREvMinFunction.Calculate : TQREvResult;
begin
  if ResAssigned then
    Result := MinResult
  else
  begin
    Result.Kind := resInt;
    Result.IntResult := 0;
  end;
end;

{ TQREvCountFunction }

type
  TQREvCountFunction = class(TQREvElementFunction)
  private
    FCount : integer;
  public
    constructor Create; override;
    function Value(FiFo : TQRFiFo) : TQREvResult; override;
    procedure Reset; override;
  end;

constructor TQREvCountFunction.Create;
begin
  inherited Create;
  FCount := 0;
  IsAggreg := true;
end;

function TQREvCountFunction.Value(FiFo : TQRFiFo) : TQREvResult;
begin
  GetArguments(FiFo);
  if (ArgList.Count = 0) then
  begin
    if FiFo.Aggreg then
      inc(FCount);
    Result.Kind := resInt;
    Result.intResult := FCount;
  end else
    Result := ErrorCreate('COUNT - ' + SqrExpTooManyARgs);
  FreeArguments;
end;

procedure TQREvCountFunction.Reset;
begin
  FCount := 0;
end;

constructor TQREvElementWrapper.Create(AEmbeddedFunction : TQREvElement);
begin
  inherited Create;
  FEmbeddedFunction := AEmbeddedFunction;
end;

function TQREvElementWrapper.Value(FiFo : TQRFifo) : TQREvResult;
begin
  Result := FEmbeddedFunction.Value(FiFo);
end;

constructor TQREvEmbeddedFunction.Create(Expression : string);
begin
  inherited Create;
  FExpression := Expression;
  Evaluator := TQREvaluator.Create;
  FInEvaluate := false;
end;

destructor TQREvEmbeddedFunction.Destroy;
begin
  Evaluator.Free;
  inherited Destroy;
end;

function TQREvEmbeddedFunction.Value(FiFo : TQRFiFo) : TQREvResult;
begin
  if not FInEvaluate then
  begin
    FInEvaluate := true;
    Result := Evaluator.Value;
    FInEvaluate := false;
  end else
    Result := ErrorCreate(SqrExpRecursive);
end;

procedure TQREvEmbeddedFunction.Reset;
begin
  Evaluator.Reset;
end;

function TQREvEmbeddedFunction.Expression : string;
begin
  Result := FExpression;
end;

function TQREvEmbeddedFunction.Peek(Index : integer) : TQREvElement;
begin
  if Evaluator.Prepared and (Index <= Evaluator.Fifo.Fifo.Count) then
    Result := Evaluator.FiFo.FiFo[Index]
  else
    Result := nil;
end;

constructor TQREvEnvironment.Create;
begin
  inherited Create;
  PrepareCount := 0;
  FDatasets := nil;
  OwnDatasets := nil;
end;

destructor TQREvEnvironment.Destroy;
begin
  if (FDatasets <> nil) and (FDataSets = OwnDatasets) then
    FDatasets.Free;
  Clear;
  inherited Destroy;
end;

procedure TQREvEnvironment.Clear;
var
  AObject : TObject;
  I : integer;
begin
  for I := Count - 1 downto 0 do
  begin
    if Objects[i] <> nil then
    begin
      AObject := Objects[I];
      Delete(I);
      AObject.Free;
    end;
  end;
  inherited Clear;
end;

procedure TQREvEnvironment.DefineProperties(Filer : TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('DATA', ReadProperties, WriteProperties, True);
end;

procedure TQREvEnvironment.WriteProperties(Writer : TWriter);
var
  I : integer;
begin
  Writer.WriteListBegin;
  for I := 0 to Count - 1 do
    Writer.WriteString(TQREvEmbeddedFunction(Objects[I]).Expression);
  Writer.WriteListEnd;
end;

procedure TQREvEnvironment.ReadProperties(Reader : TReader);
var
  I : integer;
  AString : string;
begin
  I := 0;
  Reader.ReadListBegin;
  while not Reader.EndOfList do
  begin
    AString := Reader.ReadString;
    objects[I].Free;
    Objects[I] := TQREvEmbeddedFunction.Create(AString);
    inc(I);
  end;
  Reader.ReadListEnd;
end;

procedure TQREvEnvironment.Prepare;
var
  I : integer;
begin
  inc(PrepareCount);
  if PrepareCount = 1 then
    for I := 0 to Count - 1 do
      with TQREvEmbeddedFunction(Objects[I]) do
      begin
        Evaluator.Datasets := Self.Datasets;
        Evaluator.Environment := self;
        Evaluator.Prepare(Expression);
      end;
end;

procedure TQREvEnvironment.SetDatasets(Value : TList);
begin
  if (FDatasets <> nil) and (FDatasets <> Value) and (FDatasets = OwnDatasets) then
    FDatasets.Free;
  FDatasets := Value;
end;

function TQREvEnvironment.GetDatasets : TList;
begin
  if FDatasets = nil then
  begin
    FDatasets := TList.Create;
    OwnDatasets := FDatasets;
  end;
  Result := FDatasets;
end;

procedure TQREvEnvironment.Unprepare;
var
  I : integer;
begin
  if (Self <> QRGlobalEnvironment) or not UnpreparingGlobalEnvironment then
  begin
    UnpreparingGlobalEnvironment := true;
    dec(PrepareCount);
     if PrepareCount = 0 then
       for I := 0 to Count - 1 do
         TQREvEmbeddedFunction(Objects[I]).Evaluator.Unprepare;
    UnpreparingGlobalEnvironment := false;
  end;
end;

function TQREVEnvironment.Prepared : boolean;
begin
  Result := PrepareCount > 0;
end;

procedure TQREvEnvironment.AddFunction(AName, AExpression : string);
begin
  AName := AnsiUppercase(AName);
  if IndexOf(AName) = -1 then
    AddObject(AName, TQREvEmbeddedFunction.Create(AExpression));
  if Prepared then with TQREvEmbeddedFunction(Objects[Count - 1]) do
  begin
    Evaluator.Datasets := Self.Datasets;
{$ifdef VER36}
    if Assigned(Evaluator.Environment) and (Evaluator.Environment <> self) then
                 Evaluator.Environment.Free;
{$endif}                 
    Evaluator.Environment := self;
    Evaluator.Prepare(Expression);
  end;
end;

function TQREvEnvironment.GetConstant(Name : string) : TQREvElement;
var
  AWrapper : TQREvElement;
begin
  AWrapper := Element(Name);
  try
    if AWrapper is TQREvElementError then
      Result := nil
    else
      Result := TQREvEmbeddedFunction(TQREvElementWrapper(AWrapper).EmbeddedFunction).Peek(0);
  finally
    AWrapper.Free;
  end;
end;

procedure TQREvEnvironment.UpdateConstant(Name : string; Value : TQREvResult);
var
  Element : TQREvElement;
begin
  Element := GetConstant(Name);
  SetConstant(Element, Value);
end;

procedure TQREvEnvironment.SetStringConstant(Constant : TQREvElement; Value : string);
begin
  if (Constant is TQREvElementString) then
    TQREvElementString(Constant).FValue := Value;
end;

procedure TQREvEnvironment.SetIntegerConstant(Constant : TQREvElement; Value : integer);
var
  AResult : TQREvResult;
begin
  if Constant is TQREvElementConstant then
  begin
    AResult.Kind := ResInt;
    AResult.IntResult := Value;
    TQREvElementConstant(Constant).FValue := AResult;
  end;
end;

procedure TQREvEnvironment.SetFloatConstant(Constant : TQREvElement; Value : Double);
var
  AResult : TQREvResult;
begin
  if Constant is TQREvElementConstant then
  begin
    AResult.Kind := ResDouble;
    AResult.dblResult := Value;
    TQREvElementConstant(Constant).FValue := AResult;
  end;
end;

procedure TQREvEnvironment.SetBooleanConstant(Constant : TQREvElement; Value : boolean);
var
  AResult : TQREvResult;
begin
  if Constant is TQREvElementConstant then
  begin
    AResult.Kind := ResBool;
    AResult.BooResult := Value;
    TQREvElementConstant(Constant).FValue := AResult;
  end;
end;

procedure TQREvEnvironment.SetConstant(Constant : TQREvElement; Value : TQREvResult);
begin
  if Constant is TQREvElementConstant then
    TQREvElementConstant(Constant).FValue := Value
  else
    if (Constant is TQREvElementString) and (Value.Kind = resString) then
      TQREvElementString(Constant).FValue := Value.StrResult;
end;

procedure TQREvEnvironment.DeleteFunction(AName : string);
var
  I : Integer;
begin
  I := IndexOf(AName);
  if (I <> -1) then begin
    Objects[ I ].Free;
    Delete( I );
  end;
end;

procedure TQREvEnvironment.Update;
begin
end;

function TQREvEnvironment.Value(Name : string) : TQREvResult;
var
  Index : integer;
begin
  Index := IndexOf(AnsiUppercase(Name));
  if Index <> -1 then
    Result := TQREvElement(Objects[Index]).Value(nil)
  else
    Result.Kind := resError;
end;

function TQREvEnvironment.Element(Name : string) : TQREvElement;
var
  Index : integer;
begin
  Index := IndexOf(AnsiUppercase(Name));
  if Index <> -1 then
    Result := TQREvElementWrapper.Create(TQREvElement(Objects[Index]))
  else
    Result := TQREvElementError.Create(Format(SqrExpUnknownFunction, [Name]));
end;

procedure UpdateConstant(AConstant : TQREvElement; Value : TQREvResult);
begin
  if AConstant is TQREvElementConstant then
    TQREvElementConstant(AConstant).FValue := Value
  else
    if (AConstant is TQREvElementString) and (Value.Kind = resString) then
      TQREvElementString(AConstant).FValue := Value.StrResult;
end;

procedure RegisterQRFunction(FunctionClass : TQRLibraryItemClass; Name, Description, Vendor, Arguments : string);
begin
  QRFunctionLibrary.Add(FunctionClass, Name, Description, Vendor, Arguments);
end;


initialization
  UnpreparingGlobalEnvironment := false;
  ArgSeparator := ',';
  { Register QREvaluator functions }
  QRFunctionLibrary := TQRFunctionLibrary.Create;
  // custom function
  //RegisterQRFunction(TQREvCustomFunction,'Custom', 'Custom( V1, ..)' + 'Custom Function', SqrQuSoft, '5BVV');
  RegisterQRFunction(TQREvIfFunction,'IF', 'IF(<Exp>, <X>, <Y>)|' + SqrIfDesc, SqrQuSoft, '5BVV');
  RegisterQRFunction(TQREvStrFunction, 'STR', 'STR(<X>)|' + SqrStrDesc, SqrQuSoft, '7N');
  RegisterQRFunction(TQREvUpperFunction, 'UPPER', 'UPPER(<X>)|' + SqrUpperDesc, SqrQuSoft, '7S');
  RegisterQRFunction(TQREvLowerFunction, 'LOWER', 'LOWER(<X>)|' + SqrLowerDesc, SqrQuSoft, '7S');
  RegisterQRFunction(TQREvPrettyFunction, 'PRETTY', 'PRETTY(<X>)|' + SqrPrettyDesc, SqrQuSoft, '7S');
  RegisterQRFunction(TQREvTimeFunction, 'TIME', 'TIME|' + SqrTimeDesc, SqrQuSoft, '1');
  RegisterQRFunction(TQREvDateFunction, 'DATE', 'DATE|' + SqrDateDesc, SqrQuSoft, '1');
  RegisterQRFunction(TQREvCopyFunction, 'COPY', 'COPY(<X>, <St>,<Len>)|' + SqrCopyDesc, SqrQuSoft, '7SNN');
  RegisterQRFunction(TQREvSumFunction, 'SUM', 'SUM(<X>)|' + SqrSumDesc, SqrQuSoft, '3N');
  RegisterQRFunction(TQREvCountFunction, 'COUNT', 'COUNT|'+ SqrCountDesc, SqrQuSoft, '3');
  RegisterQRFunction(TQREvMaxFunction, 'MAX', 'MAX(<X>)|' + SqrMaxDesc, SqrQuSoft, '3V');
  RegisterQRFunction(TQREvMinFunction, 'MIN', 'MIN(<X>)|' + SqrMinDesc, SqrQuSoft, '3V');
  RegisterQRFunction(TQREvAverageFunction, 'AVERAGE', 'AVERAGE(<X>)|' + SqrAverageDesc, SqrQuSoft, '3N');
  RegisterQRFunction(TQREvTrue, 'TRUE', 'TRUE|' + SqrBoolDesc, SqrQuSoft, '5');
  RegisterQRFunction(TQREvFalse, 'FALSE', 'FALSE|' + SqrBoolDesc, SqrQuSoft, '5');
  RegisterQRFunction(TQREvIntFunction, 'INT', 'INT(<X>)|' + SqrIntDesc, SqrQuSoft, '2N');
  RegisterQRFunction(TQREvFracFunction, 'FRAC', 'FRAC(<X>)|' + SqrFracDesc, SqrQuSoft, '2N');
  RegisterQRFunction(TQREvSQRTFunction, 'SQRT', 'SQRT(<X>)|' + SqrSqrtDesc, SqrQuSoft, '2N');
  RegisterQRFunction(TQREvDivFunction, 'DIV', 'DIV(<X>, <Y>) | ' + SqrDivDesc, SqrQuSoft,'2NN');
  RegisterQRFunction(TQREvTypeOfFunction, 'TYPEOF', 'TYPEOF(<Exp>)|' + SqrTypeofDesc, SqrQuSoft, '6N');
  RegisterQRFunction(TQREvFormatNumericFunction,'FORMATNUMERIC', 'FORMATNUMERIC(<F>,<N>)|' + SqrFormatNumericDesc,
                     SqrQuSoft, '7SN');

  FGlobalEnvironment := TQREvEnvironment.Create;
  FGlobalEnvironment.AddFunction('AppStartTime', '''' + TimeToStr(Time) + '''');
  FGlobalEnvironment.AddFunction('AppStartDate','''' + DateToStr(Date) + '''');
  FGlobalEnvironment.AddFunction('AppName', '''' + Application.Title + '''');

finalization
  QRFunctionLibrary.Free;
  FGlobalEnvironment.Free;

end.
