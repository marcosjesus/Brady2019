unit GN_RadioGroup;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, StdCtrls, ExtCtrls ;

Type

  TCustomGNRadioGroup = class(TCustomGroupBox)
  private
	FButtons: TList;
	FItems: TStrings;
	FDBItems : TStrings ;
	FItemIndex: Integer;
	FColumns: Integer;
	FReading: Boolean;
	FUpdating: Boolean;
	FFieldName : String ;
	FItemChoice : String ;
	procedure ArrangeButtons;
	procedure ButtonClick(Sender: TObject);
	procedure ItemsChange(Sender: TObject);
	procedure SetButtonCount(Value: Integer);
	procedure SetColumns(Value: Integer);
	procedure SetItemIndex(Value: Integer);
	procedure SetItems(Value: TStrings);
	procedure SetDBItems(Value: TStrings);
	procedure SetItemChoice (Value: String);
	procedure UpdateButtons;
	procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
	procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
	procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
	procedure ReadState(Reader: TReader); override;
	function CanModify: Boolean; virtual;
	procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
	property Columns: Integer read FColumns write SetColumns default 1;
	property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
	property Items: TStrings read FItems write SetItems;
	property DBItems: TStrings read FDBItems write SetDBItems;
	property FieldName : String read FFieldName Write FFieldName ;
	property ItemChoice : String read FItemChoice Write SetItemChoice ;
  public
	constructor Create(AOwner: TComponent); override;
	destructor Destroy; override;
	procedure FlipChildren(AllLevels: Boolean); override;
  end;

  TGNRadioGroup = class(TCustomGNRadioGroup)
  published
	property Align;
	property Anchors;
	property BiDiMode;
	property Caption;
	property Color;
	property Columns;
	property Ctl3D;
	property DragCursor;
	property DragKind;
	property DragMode;
	property Enabled;
	property Font;
	property ItemIndex;
	property ItemChoice ;
	property Items;
	property DBItems ;
	property Constraints;
	property ParentBiDiMode;
	property ParentColor;
	property ParentCtl3D;
	property ParentFont;
	property ParentShowHint;
	property PopupMenu;
	property ShowHint;
	property TabOrder;
	property TabStop;
	property Visible;
	property FieldName ;
	property OnClick;
	property OnDragDrop;
	property OnDragOver;
	property OnEndDock;
	property OnEndDrag;
	property OnEnter;
	property OnExit;
	property OnStartDock;
	property OnStartDrag;
  end;

procedure Register;

Var
	FCNCmd : Boolean ;

implementation

{ TGroupButton }

type
  TGroupButton = class(TRadioButton)
  private
	FInClick: Boolean;
	procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
	procedure KeyDown(var Key: Word; Shift: TShiftState); override;
	procedure KeyPress(var Key: Char); override;
  public
	constructor InternalCreate(RadioGroup: TCustomGNRadioGroup);
	destructor Destroy; override;
  end;

constructor TGroupButton.InternalCreate(RadioGroup: TCustomGNRadioGroup);
begin
  inherited Create(RadioGroup);
  RadioGroup.FButtons.Add(Self);
  Visible := False;
  Enabled := RadioGroup.Enabled;
  ParentShowHint := False;
  OnClick := RadioGroup.ButtonClick;
  Parent := RadioGroup;
end;

destructor TGroupButton.Destroy;
begin
  TCustomGNRadioGroup(Owner).FButtons.Remove(Self);
  inherited Destroy;
end;

procedure TGroupButton.CNCommand(var Message: TWMCommand);
begin
  if not FInClick then
  begin
	FInClick := True;
	try
	  if ((Message.NotifyCode = BN_CLICKED) or
		 (Message.NotifyCode = BN_DOUBLECLICKED)) and
		 TCustomGNRadioGroup(Parent).CanModify then
		 If ( Not FCNCmd ) Then
			  inherited ;
	except
	  Application.HandleException(Self);
	end;
	FInClick := False;
    FCNCmd := False ;
  end;
end;

procedure TGroupButton.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  TCustomGNRadioGroup(Parent).KeyPress(Key);
  if (Key = #8) or (Key = ' ') then
  begin
    if not TCustomGNRadioGroup(Parent).CanModify then Key := #0;
  end;
end;

procedure TGroupButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  TCustomGNRadioGroup(Parent).KeyDown(Key, Shift);
end;

{ TCustomGNRadioGroup }

constructor TCustomGNRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csSetCaption, csDoubleClicks];
  FButtons := TList.Create;
  FItems := TStringList.Create;
  TStringList(FItems).OnChange := ItemsChange;
  FDBItems := TStringList.Create;
  TStringList(FDBItems).OnChange := ItemsChange;
  FItemIndex := -1;
  FColumns := 1;
  FFieldName := '' ;
  FCNCmd := False ;
end;

destructor TCustomGNRadioGroup.Destroy;
begin
  SetButtonCount(0);
  TStringList(FItems).OnChange := nil;
  FItems.Free;
  TStringList(FDBItems).OnChange := nil;
  FDBItems.Free;
  FButtons.Free;
  inherited Destroy;
end;

procedure TCustomGNRadioGroup.FlipChildren(AllLevels: Boolean);
begin
  { The radio buttons are flipped using BiDiMode }
end;

procedure TCustomGNRadioGroup.ArrangeButtons;
var
  ButtonsPerCol, ButtonWidth, ButtonHeight, TopMargin, I: Integer;
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
  DeferHandle: THandle;
  ALeft: Integer;
begin
  if (FButtons.Count <> 0) and not FReading then
  begin
	DC := GetDC(0);
	SaveFont := SelectObject(DC, Font.Handle);
	GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
    ReleaseDC(0, DC);
    ButtonsPerCol := (FButtons.Count + FColumns - 1) div FColumns;
    ButtonWidth := (Width - 10) div FColumns;
    I := Height - Metrics.tmHeight - 5;
    ButtonHeight := I div ButtonsPerCol;
    TopMargin := Metrics.tmHeight + 1 + (I mod ButtonsPerCol) div 2;
	DeferHandle := BeginDeferWindowPos(FButtons.Count);
    try
	  for I := 0 to FButtons.Count - 1 do
		 with TGroupButton(FButtons[I]) do
        begin
			BiDiMode := Self.BiDiMode;
			ALeft := (I div ButtonsPerCol) * ButtonWidth + 8;
          if UseRightToLeftAlignment then
            ALeft := Self.ClientWidth - ALeft - ButtonWidth;
          DeferHandle := DeferWindowPos(DeferHandle, Handle, 0,
            ALeft,
            (I mod ButtonsPerCol) * ButtonHeight + TopMargin,
            ButtonWidth, ButtonHeight,
			  SWP_NOZORDER or SWP_NOACTIVATE);
          Visible := True;
		 end;
    finally
      EndDeferWindowPos(DeferHandle);
    end;
  end;
end;

procedure TCustomGNRadioGroup.ButtonClick(Sender: TObject);
begin
  if not FUpdating then
  begin
	FItemIndex := FButtons.IndexOf(Sender);
	FItemChoice := FDBItems[FItemIndex] ;
	Changed;
	Click;
  end;
end;

procedure TCustomGNRadioGroup.ItemsChange(Sender: TObject);
begin
  if not FReading then
  begin
	if FItemIndex >= FItems.Count then FItemIndex := FItems.Count - 1;
	UpdateButtons;
  end;
end;

procedure TCustomGNRadioGroup.ReadState(Reader: TReader);
begin
  FReading := True;
  inherited ReadState(Reader);
  FReading := False;
  UpdateButtons;
end;

procedure TCustomGNRadioGroup.SetButtonCount(Value: Integer);
begin
  while FButtons.Count < Value do TGroupButton.InternalCreate(Self);
  while FButtons.Count > Value do TGroupButton(FButtons.Last).Free;
end;

procedure TCustomGNRadioGroup.SetColumns(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 16 then Value := 16;
  if FColumns <> Value then
  begin
	FColumns := Value;
	ArrangeButtons;
	Invalidate;
  end;
end;

procedure TCustomGNRadioGroup.SetItemIndex(Value: Integer);
begin
  if FReading then FItemIndex := Value else
  begin
	FItemChoice := '' ;
	if Value < -1 then Value := -1;
	if Value >= FButtons.Count then Value := FButtons.Count - 1;
	if FItemIndex <> Value then
	begin
	  if FItemIndex >= 0 then
		 TGroupButton(FButtons[FItemIndex]).Checked := False;
	  FItemIndex := Value;
	  if FItemIndex >= 0 then
	  Begin
		 TGroupButton(FButtons[FItemIndex]).Checked := True;
	  End ;
	end;
  end;
end;

procedure TCustomGNRadioGroup.SetItems(Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TCustomGNRadioGroup.SetDBItems(Value: TStrings);
begin
  FDBItems.Assign(Value);
end;

Procedure TCustomGNRadioGroup.SetItemChoice ( Value : String ) ;
Var
	i : Integer ;
Begin
	FItemChoice := Value ;
	For i:=0 To FDBItems.Count-1 Do
	Begin
		If ( FDBItems[i] = Value ) Then
		Begin
			 FCNCmd := True ;
			 If ( Value = '' ) Then
				  SetItemIndex(-2)
			 Else
               SetItemIndex(i) ;
			 Break ;
		End ;
	End ;
End ;

procedure TCustomGNRadioGroup.UpdateButtons;
var
  I: Integer;
begin
  SetButtonCount(FItems.Count);
  for I := 0 to FButtons.Count - 1 do
	TGroupButton(FButtons[I]).Caption := FItems[I];
  if FItemIndex >= 0 then
  begin
	FUpdating := True;
	TGroupButton(FButtons[FItemIndex]).Checked := True;
	FItemChoice := FDBItems[FItemIndex] ;
	FUpdating := False;
  end;
  ArrangeButtons;
  Invalidate;
end;

procedure TCustomGNRadioGroup.CMEnabledChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  for I := 0 to FButtons.Count - 1 do
	TGroupButton(FButtons[I]).Enabled := Enabled;
end;

procedure TCustomGNRadioGroup.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ArrangeButtons;
end;

procedure TCustomGNRadioGroup.WMSize(var Message: TWMSize);
begin
  inherited;
  ArrangeButtons;
end;

function TCustomGNRadioGroup.CanModify: Boolean;
begin
  Result := True;
end;

procedure TCustomGNRadioGroup.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;

procedure Register;
begin
  RegisterComponents('GlobalNet', [TGNRadioGroup]);
end;


end.
