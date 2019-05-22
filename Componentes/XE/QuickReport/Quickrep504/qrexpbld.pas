{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 4.0 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRExpBld.pas - EXPRESSION BUILDER                       ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.qusoft.com                              ::
  ::                                                         ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

unit QRExpBld;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, QRExpr, QR5Const;

type
  TQRExpressionBuilder = class(TForm)
    MainPage: TPanel;
    DataFieldPage: TPanel;
    FunctionPage: TPanel;
    FuncParamsPage: TPanel;
    Heading: TLabel;
    GroupBox1: TGroupBox;
    InsertDataFieldBtn: TButton;
    InsertFunctionBtn: TButton;
    InsertVariableBtn: TButton;
    AddPlus: TButton;
    AddMinus: TButton;
    AddMul: TButton;
    AddDiv: TButton;
    AddEqual: TButton;
    AddSmaller: TButton;
    AddLarger: TButton;
    AddNotEqual: TButton;
    AddLessEqual: TButton;
    AddGreaterEqual: TButton;
    AddNot: TButton;
    AddAnd: TButton;
    AddOr: TButton;
    ValidateBtn: TButton;
    Clear: TButton;
    OK: TButton;
    Cancel: TButton;
    DataFieldOKBtn: TButton;
    DataFieldCancelBtn: TButton;
    DataFieldGB: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    DataSet: TComboBox;
    DataField: TListBox;
    FunctionOKBtn: TButton;
    FunctionCancelBtn: TButton;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    AvailableFields: TListBox;
    GroupBox4: TGroupBox;
    Categories: TListBox;
    Label6: TLabel;
    AvailableFunc: TListBox;
    Label7: TLabel;
    FuncName: TLabel;
    FuncDescription: TLabel;
    GroupBox3: TGroupBox;
    CopyFuncName: TLabel;
    CopyFuncDescription: TLabel;
    FuncParamSB: TScrollBox;
    FuncParamOkBtn: TButton;
    FuncArgCancelBtn: TButton;
    AvailableDatasets: TListBox;
    VariablePage: TPanel;
    GroupBox5: TGroupBox;
    VariableOKBtn: TButton;
    VariableCancelBtn: TButton;
    AvailableVariables: TListBox;
    VariableValue: TLabel;
    Label1: TLabel;
    ModifyVariables: TButton;
    TopPanel: TPanel;
    TopImage: TImage;
    Label8: TLabel;
    Shape1: TShape;
    procedure InsertDataFieldBtnClick(Sender: TObject);
    procedure DataFieldCancelBtnClick(Sender: TObject);
    procedure DataFieldOKBtnClick(Sender: TObject);
    procedure FunctionOKBtnClick(Sender: TObject);
    procedure CategoriesClick(Sender: TObject);
    procedure AvailableFuncClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InsertFunctionBtnClick(Sender: TObject);
    procedure FuncParamOkBtnClick(Sender: TObject);
    procedure FuncArgCancelBtnClick(Sender: TObject);
    procedure FunctionCancelBtnClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure AddSomeClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AvailableDatasetsClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure ValidateBtnClick(Sender: TObject);
    procedure InsertVariableBtnClick(Sender: TObject);
    procedure VariableOKBtnClick(Sender: TObject);
    procedure VariableCancelBtnClick(Sender: TObject);
    procedure AvailableVariablesClick(Sender: TObject);
    procedure ModifyVariablesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    Expr: TEdit;
    FFuncParamsResult : integer;
    FFuncResult : integer;
    FDatafieldResult : integer;
    FExprResult : integer;
    FDatasetForm : TCustomForm;
    FVariableResult : integer;
    FLocalEnvironment : TQREvEnvironment;
    procedure GetParamExprClick(Sender : TObject);
    procedure GetFunctionsCat(Index : integer);
    procedure SelectFunc(Index : integer);
    procedure InsertText(AText : string);
    procedure PickDataSets;
    procedure PickVariables;
    function GetParams(ParamList : string; var ParamResult : string) : boolean;
    function GetFunc(var Func : string) : boolean;
    function GetDatafield(var Field : string) : boolean;
    function GetVariable(var Variable : string) : boolean;
  public
    Cancelled : boolean;
    property DatasetForm : TCustomForm read FDatasetForm write FDatasetForm;
    property LocalEnvironment : TQREvEnvironment read FLocalEnvironment write FLocalEnvironment;
  end;

    function GetExpression(ACaption : string; var Value : string; ADataSetForm : TCustomForm; AParentControl : TWinControl; ALocalEnvironment : TQREvEnvironment) : boolean;

implementation

uses QRPrntr, QRExtra, Buttons, DB, QREnvEd;

{$R *.DFM}

function TrimExpr(AExpr : string) : string;
begin
  while pos(#13, AExpr) > 0 do
    Delete(AExpr, Pos(#13, AExpr), 2);
  Result := AExpr;
end;

function GetExpression(ACaption : string; var Value : string; ADataSetForm : TCustomForm; AParentControl : TWinControl; ALocalEnvironment : TQREvEnvironment) : boolean;
begin
  with TQRExpressionBuilder.Create(Application) do
  try
    DatasetForm := ADatasetForm;
    LocalEnvironment := ALocalEnvironment;
    if AParentControl <> nil then
    begin
      Parent := AParentControl;
      Top := 0;
      Left := 0;
      BorderStyle := bsNone;
      PickDatasets;
      PickVariables;
      Position := poDesigned;
    end;
    if ACaption <> '' then
      Heading.Caption := ACaption;
    Expr.Text := Value;
    Expr.SelStart := 0;
    Expr.SelLength := Length(Value);
    FExprResult := 0;
    MainPage.BringToFront;
    Cancelled := false;
    if Parent = nil then
      ShowModal
      //Show
    else
    begin
      Show;
      repeat
        Application.HandleMessage
      until (FExprResult <> 0) or (Cancelled);
    end;
    Result := FExprResult = 1;
    if Result then
      Value := TrimExpr(Expr.Text)
    else
      Value := '';
  finally
    Free;
  end;
end;

type
  TWordWrapEdit = class(TEdit)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

procedure TWordWrapEdit.CreateParams(var Params: TCreateParams);
const
  WordWraps: array[Boolean] of LongInt = (0, ES_AUTOHSCROLL);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style and not WordWraps[True] or ES_MULTILINE
  end;
end;

procedure TQRExpressionBuilder.InsertDataFieldBtnClick(Sender: TObject);
var
  AField : string;
begin
  MainPage.Enabled := false;
  if GetDatafield(AField) then
  begin
    MainPage.Enabled := true;
    InsertText(AField);
  end else
    MainPage.Enabled := true;
  MainPage.BringToFront;
  Expr.SetFocus;
end;

procedure TQRExpressionBuilder.DataFieldCancelBtnClick(Sender: TObject);
begin
  FDatafieldResult := 2;
end;

procedure TQRExpressionBuilder.DataFieldOKBtnClick(Sender: TObject);
begin
  FDatafieldResult := 1;
end;

procedure TQRExpressionBuilder.FunctionOKBtnClick(Sender: TObject);
begin
  FFuncResult := 1;
end;

procedure TQRExpressionBuilder.CategoriesClick(Sender: TObject);
begin
  GetFunctionsCat(Categories.ItemIndex);
end;

procedure TQRExpressionBuilder.GetFunctionsCat(Index : integer);
var
  I : integer;
begin
  AvailableFunc.Items.Clear;
  for I:=0 to QRFunctionLibrary.EntryList.Count-1 do
  begin
    with TQRLibraryEntry(QRFunctionLibrary.Entry[I]) do
    begin
      if (Index = 0) or (StrToInt(Copy(Data, 1, 1)) = Index) then
        AvailableFunc.Items.AddObject(Name, TQRLibraryEntry(QRFunctionLibrary.Entry[I]));
    end;
  end;
  SelectFunc(0);
end;

procedure TQRExpressionBuilder.SelectFunc(Index : integer);
var
  AText : string;
begin
  if (Index < AvailableFunc.Items.Count) then
  begin
    AText := TQRLibraryEntry(AvailableFunc.Items.Objects[Index]).Description;
    FuncName.Caption := copy(AText, 1, AnsiPos('|', AText) - 1);
    FuncDescription.Caption := copy(AText,AnsiPos('|', AText) + 1, Length(AText));
  end else
  begin
    FuncDescription.Caption := '';
    FuncName.Caption := '';
  end;
end;

procedure TQRExpressionBuilder.AvailableFuncClick(Sender: TObject);
begin
  SelectFunc(AvailableFunc.ItemIndex);
end;

procedure TQRExpressionBuilder.FormCreate(Sender: TObject);
begin
  GetFunctionsCat(0);
  Expr := TWordWrapEdit.Create(Self);
  with Expr do
  begin
    AutoSize := false;
    Parent := MainPage;
    Top := 36;
    Left := 20;
    Width := 341;
    Height := 91;
  end;
end;

function TQRExpressionBuilder.GetFunc(var Func : string) : boolean;
var
  AllArguments : string;
  Arguments : string;
begin
  FunctionPage.Enabled := true;
  FunctionPage.BringToFront;
  FFuncResult := 0;
  repeat
    Application.HandleMessage
  until FFuncResult <> 0;
  if FFuncResult = 1 then
  begin
    Result := true;
    if (AvailableFunc.ItemIndex >= 0) and
       (AvailableFunc.ItemIndex <= AvailableFunc.Items.Count - 1) then
      with TQRLibraryEntry(AvailableFunc.Items.Objects[AvailableFunc.ItemIndex]) do
      begin
        Func := Name;
        Arguments := Data;
      end;
    if Length(Arguments) > 1 then
    begin
      FunctionPage.Enabled := false;
      if GetParams(Copy(Arguments, 2, length(Arguments)), AllArguments) then
        Func := Func + '(' + AllArguments + ')'
      else
        Result := false;
      FunctionPage.Enabled := true;
    end;
    FunctionPage.BringToFront;
  end else
    Result := false;
  if not Result then
    Func := '';
  FunctionPage.Enabled := false;
end;

function TQRExpressionBuilder.GetParams(ParamList : string; var ParamResult : string) : boolean;
var
  I : integer;
begin
  FuncParamsPage.Enabled := true;
  FuncParamsPage.BringToFront;
  CopyFuncName.Caption := FuncName.Caption;
  CopyFuncDescription.Caption := FuncDescription.Caption;
  for I := 0 to length(ParamList) - 1 do
  begin
    with TLabel.Create(Self) do
    begin
      Parent := FuncParamSB;
      Left := 10;
      Top := I * 40;
      Tag := 1;
      case ParamList[I + 1] of
        'N' : Caption := SqrExpBldNumeric;
        'B' : Caption := SqrExpBldLogical;
        'S' : Caption := SqrExpBldText;
        'V' : Caption := SqrExpBldValue;
      end;
      Caption := Format(Caption, [I + 1]);
    end;
    with TEdit.Create(Self) do
    begin
      Parent := FuncParamSB;
      Left := 10;
      Top := I * 40 + 15;
      Width := Parent.Width - 60;
      Tag := I;
    end;
    with TSpeedButton.Create(Self) do
    begin
      Parent := FuncParamSB;
      Left := Parent.Width - 40;
      Width := 20;
      Height := 20;
      Top := I * 40 + 15;
      Caption := '...';
      Tag := I;
      OnClick := GetParamExprClick;
    end;
    FuncParamSB.VertScrollBar.Range := Length(ParamList) * 40;
    FuncParamSB.VertScrollBar.Increment := 40;
  end;
  FFuncParamsResult := 0;
  repeat
    Application.HandleMessage
  until FFuncParamsResult <> 0;
  Result := FFuncParamsResult = 1;
  if Result then
  begin
    ParamResult := '';
    for I := 0 to FuncParamSB.ControlCount - 1 do
    begin
      if FuncParamSB.Controls[I] is TEdit then
      begin
        if ParamResult <> '' then
          ParamResult := ParamResult + ',';
        ParamResult := ParamResult + TEdit(FuncParamSB.Controls[I]).Text;
      end;
    end;
  end;
  while FuncParamSB.ControlCount > 0 do
    FuncParamSB.Controls[0].Free;
  FuncParamsPage.Enabled := false;
end;

procedure TQRExpressionBuilder.GetParamExprClick(Sender : TObject);
var
  I : integer;
  ParamExpr : string;
begin
  for I := 0 to FuncParamSB.ControlCount - 1 do
    if (FuncParamSB.Controls[I] is TEdit) and
      (TEdit(FuncParamSB.Controls[I]).Tag = TSpeedButton(Sender).Tag) then
      with TEdit(FuncParamSB.Controls[I]) do
      begin
        ParamExpr := Text;
        if GetExpression(Format(SqrExpBldEnterParam, [Tag + 1, FuncName.Caption]),
          ParamExpr, DataSetForm, Self, FLocalEnvironment) then
          Text := ParamExpr;
        FuncParamsPage.BringToFront;
        SetFocus;
        SelStart := 0;
        SelLength := Length(Text);
        Exit;
      end;
end;

procedure TQRExpressionBuilder.InsertFunctionBtnClick(Sender: TObject);
var
  AFunction : string;
begin
  MainPage.Enabled := false;
  if GetFunc(AFunction) then
  begin
    MainPage.Enabled := true;
    InsertText(AFunction);
  end else
    MainPage.Enabled := true;
  MainPage.BringToFront;
  Expr.SetFocus;
end;

procedure TQRExpressionBuilder.FuncParamOkBtnClick(Sender: TObject);
begin
  FFuncParamsResult := 1;
end;

procedure TQRExpressionBuilder.FuncArgCancelBtnClick(Sender: TObject);
begin
  FFuncParamsResult := 2;
end;

procedure TQRExpressionBuilder.FunctionCancelBtnClick(Sender: TObject);
begin
  FFuncResult := 2;
end;

procedure TQRExpressionBuilder.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  FFuncResult := 2;
  FFuncParamsResult := 2;
  FDataFieldResult := 2;
  if FExprResult <> 1 then FExprResult := 2;
  FVariableResult := 2;
  CanClose := true;
end;

function TQRExpressionBuilder.GetDatafield(var Field : string) : boolean;
begin
  FDatafieldResult := 0;
  DataFieldPage.Enabled := true;
  DataFieldPage.BringToFront;
  repeat
    Application.HandleMessage
  until (FDatafieldResult <> 0) or Cancelled;
  Result := FDatafieldResult = 1;
  if Result and (AvailableDataSets.ItemIndex > -1) and (AvailableFields.ItemIndex > -1) then
    Field := AvailableDatasets.Items[AvailableDataSets.ItemIndex] + '.' + AvailableFields.Items[AvailableFields.ItemIndex]
  else
    Field := '';
  DataFieldPage.Enabled := false;
end;

function TQRExpressionBuilder.GetVariable(var Variable : string) : boolean;
begin
  FVariableResult := 0;
  VariablePage.Enabled := true;
  VariablePage.BringToFront;
  repeat
    Application.HandleMessage
  until (FVariableResult <> 0) or Cancelled;
  Result := FVariableResult = 1;
  if Result then
    Variable := AvailableVariables.Items[AvailableVariables.ItemIndex]
  else
    Variable := '';
  VariablePage.Enabled := false;
end;

procedure TQRExpressionBuilder.InsertText(AText : string);
begin
  Expr.SelText := AText;
  Expr.SelStart := Expr.SelStart + Expr.SelLength;
  Expr.SelLength := 0;
  Expr.SetFocus;
end;

procedure TQRExpressionBuilder.AddSomeClick(Sender: TObject);
begin
  InsertText(' ' + TSpeedButton(Sender).Caption + ' ');
end;

procedure TQRExpressionBuilder.PickDatasets;
var
    dslist : TStrings;
begin
 dslist := nil;
 try
  dslist := AllDataSets(DatasetForm, true);
  AvailableDataSets.Items := dslist;
  AvailableDataSets.ItemIndex := 0;
  AvailableDataSetsClick(self);
 finally
   dslist.Free;
 end;
end;

procedure TQRExpressionBuilder.PickVariables;
var
  I : integer;
begin
  AvailableVariables.Items.Clear;
  if LocalEnvironment <> nil then
    for I := 0 to LocalEnvironment.Count - 1 do
      AvailableVariables.Items.Add(LocalEnvironment[I]);
  for I := 0 to QRGlobalEnvironment.Count - 1 do
    AvailableVariables.Items.Add(QRGlobalEnvironment[I]);
  AvailableVariables.ItemIndex := 0;
  AvailableVariablesClick(Self);
end;

procedure TQRExpressionBuilder.FormActivate(Sender: TObject);
begin
  PickDataSets;
  PickVariables;
  Expr.SetFocus;
end;

procedure TQRExpressionBuilder.AvailableDatasetsClick(Sender: TObject);
var
  I : integer;
begin
  AvailableFields.Items.Clear;
  if AvailableDataSets.Items.Count > 0 then
    with TDataSet(AvailableDataSets.Items.Objects[AvailableDataSets.ItemIndex]) do
    begin
      for I := 0 to FieldCount - 1 do
        AvailableFields.Items.Add(Fields[I].FieldName);
    end;
end;

procedure TQRExpressionBuilder.OKClick(Sender: TObject);
begin
  FExprResult := 1;
end;

procedure TQRExpressionBuilder.CancelClick(Sender: TObject);
begin
  FExprResult := 2;
end;

procedure TQRExpressionBuilder.ClearClick(Sender: TObject);
begin
  Expr.Text := '';
end;

procedure TQRExpressionBuilder.ValidateBtnClick(Sender: TObject);
var
  I : integer;
  AResult : TQREvResult;
  TextResult : string;
begin
  QRGlobalEnvironment.Prepare;
  if LocalEnvironment <> nil then
    LocalEnvironment.Prepare;
  with TQREvaluator.Create do
  try
    DataSets := TList.Create;
    Environment := LocalEnvironment;
    for I := 0 to AvailableDataSets.Items.Count - 1 do
      DataSets.Add(TDataSet(AvailableDataSets.Items.Objects[I]));
    AResult := Calculate(TrimExpr(Expr.Text));
    TextResult := '';
    case AResult.Kind of
      resInt : TextResult := IntToStr(AResult.IntResult);
      resDouble : TextResult := FloatToStr(AResult.DblResult);
      resString : TextResult := AResult.StrResult;
      resBool : if AResult.booResult then
                  TextResult := 'True'
                else
                  TextResult := 'False';
    end;
    if TextResult = '' then
      ShowMessage(SqrExpBldError + AResult.strResult)
    else
      ShowMessage(SqrExpBldNoError + TextResult);
      DataSets.Free;
  finally
    free;
  end;
  if LocalEnvironment <> nil then LocalEnvironment.Unprepare;
  QRGlobalEnvironment.Unprepare;
end;

procedure TQRExpressionBuilder.InsertVariableBtnClick(Sender: TObject);
var
  AVariable : string;
begin
  MainPage.Enabled := false;
  if GetVariable(AVariable) then
  begin
    MainPage.Enabled := true;
    InsertText(AVariable);
  end else
    MainPage.Enabled := true;
  MainPage.BringToFront;
end;

procedure TQRExpressionBuilder.VariableOKBtnClick(Sender: TObject);
begin
  FVariableResult := 1;
end;

procedure TQRExpressionBuilder.VariableCancelBtnClick(Sender: TObject);
begin
  FVariableResult := 2;
end;

procedure TQRExpressionBuilder.AvailableVariablesClick(Sender: TObject);
var
  VarName : string;
begin
  VarName := AvailableVariables.Items[AvailableVariables.ItemIndex];
  if (LocalEnvironment <> nil) and (LocalEnvironment.IndexOf(VarName) >= 0) then
  begin
    with TQREvEmbeddedFunction(TQREvElementWrapper(LocalEnvironment.Element(VarName)).EmbeddedFunction) do
      VariableValue.Caption := Expression;
  end else
    with TQREvEmbeddedFunction(TQREvElementWrapper(QRGlobalEnvironment.Element(VarName)).EmbeddedFunction) do
      VariableValue.Caption := Expression;
end;


procedure TQRExpressionBuilder.ModifyVariablesClick(Sender: TObject);
begin
  EditEnvironment(LocalEnvironment, true, self);
end;

procedure TQRExpressionBuilder.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if (key = 27) or (key=ord(' '))then
         Cancelled := true;
end;

procedure TQRExpressionBuilder.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
      if (key = chr(27)) or (key=' ')then
         Cancelled := true; 

end;

end.
