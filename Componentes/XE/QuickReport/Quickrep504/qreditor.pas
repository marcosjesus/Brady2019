{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 4.0 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QREDIT - END USER REPORT EDITOR                         ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.qusoft.com                               ::
  ::                                                         ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

{$I QRDEFS.INC}

unit QREditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, QuickRpt, QRCtrls, StdCtrls, ComCtrls, ToolWin, Buttons, DB,
  ImgList;

type
  TCustomEditor = class;

  TGrabPosition = (gpN, gpNE, gpE, gpSE, gpS, gpSW, gpW, gpNW);
  TGrabHandle = class(TCustomControl)
  private
    FPosition : TGrabPosition;
    FSize : integer;
    FParentControl : TControl;
    FDim : boolean;
    Offset : integer;
    procedure SetSize(Value : integer);
    procedure SetDim(Value : boolean);
    procedure SetCursor;
  protected
    procedure Paint; override;
  public
    constructor CreateGrab(AOwner : TComponent; ParentControl : TControl; Position : TGrabPosition);
    property Size : integer read FSize write SetSize;
    property Dim : boolean read FDim write SetDim;
    procedure UpdatePosition;
  end;

  TFocusFrameState = (fsNormal, fsDim, fsFrame);
  TFocusFrame = class(TWinControl)
  private
    CurrentRect : TRect;
    GrabHandles : TList;
    FParentControl : TControl;
    FState : TFocusFrameState;
    procedure SetState(Value : TFocusFrameState);
    procedure PaintFrame;
  public
    constructor CreateParented(AOwner : TComponent; ParentControl : TControl);
    destructor Destroy; override;
    procedure SizeFrame(ALeft, AUp, ARight, ADown : integer);
    procedure MoveFrame(ALeft, AUp : integer);
    procedure UpdateGrabHandles;
    property State : TFocusFrameState read FState write SetState;
  end;

  TSelectionList = class
  private
    ControlList : TList;
    FocusList : TList;
    FState : TFocusFrameState;
    FEditor : TCustomEditor;
    MovedUp : integer;
    MovedLeft : integer;
    SizedUp : integer;
    SizedDown : integer;
    SizedLeft : integer;
    SizedRight : integer;
  protected
    procedure SetState(Value : TFocusFrameState);
    procedure FindMaxValues(var ALeft, ATop, ARight, ABottom : integer);
    procedure AlignTo(Position : TGrabPosition);
    function GetCount : integer;
    function GetItem(Index : integer) : TControl;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AlignLefts;
    procedure AlignRights;
    procedure AlignTops;
    procedure AlignBottoms;
    procedure Add(AControl : TControl);
    procedure Remove(AControl : TControl);
    procedure Clear;
    procedure Size(ALeft, AUp, ARight, ADown : integer);
    procedure Move(ALeft, AUp : integer);
    procedure BringToFront;
    procedure SendToBack;
    procedure Copy(var Stream : TStream);
    procedure UnselectChildren;
    function UpdateControls : boolean;
    function IsSelected(AControl : TControl) : boolean;
    property Items[index : integer] : TControl read GetItem; default;
    property State : TFocusFrameState read FState write SetState;
    property Count : integer read GetCount;
    property Editor : TCustomEditor read FEditor write FEditor;
  end;

  TNewComponentClass = class of TComponent;
  TEditorState = (esNormal, esResize, esMove, esAdd);

  TCustomEditor = class(TCustomPanel)
  private
    FSelectionList : TSelectionList;
    FEditing : boolean;
    MouseIsDown : boolean;
    Clipboard : TStream;
    SizeUp : boolean;
    SizeDown : boolean;
    SizeLeft : boolean;
    SizeRight : boolean;
    Origin : TPoint;
    NewComponentClass : TNewComponentClass;
    FClipboardAvailable : boolean;
    FMainControl : TWinControl;
    FState : TEditorState;
    FOnAddedControl : TNotifyEvent;
    FOnSelectControl : TNotifyEvent;
    FOnUnselectControl : TNotifyEvent;
    FOnClipboardStateChange : TNotifyEvent;
    FOnModified : TNotifyEvent;
    FModified : boolean;
  protected
    procedure DoAdd(X, Y : integer); virtual;
    procedure DoPopup(X, Y : integer); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure SetEditing(Value : boolean); virtual;
    procedure MouseDownHandler(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : integer); virtual;
    procedure MouseMoveHandler(Sender : TObject; Shift : TShiftState; X, Y : integer); virtual;
    procedure MouseUpHandler(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : integer); virtual;
    procedure StartResize(Position : TGrabPosition; APoint : TPoint); virtual;
    procedure ResizeTo(APoint : TPoint); virtual;
    procedure EndResize(APoint : TPoint); virtual;
    procedure StartMove(APoint : TPoint); virtual;
    procedure MoveTo(APoint : TPoint); virtual;
    procedure EndMove(APoint : TPoint); virtual;
    procedure SetModified(Value : boolean); virtual;
    property State : TEditorState read FState;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure AddClass(ComponentClass : TNewComponentClass);
    procedure Add(AComponent : TComponent; AParent : TWinControl);
    procedure ClearAll;
    procedure Select(AControl : TControl; MultiSelect : boolean); virtual;
    procedure Unselect(AControl : TControl); virtual;
    procedure UnselectAll; virtual;
    procedure DeleteSelected; virtual;
    procedure CopySelected;
    procedure CutSelected;
    procedure Paste;
    procedure SaveToStream(Stream : TStream);
    procedure Save(Filename : string);
    procedure SetEvents(AControl : TWinControl);
    procedure LoadFromStream(Stream : TStream);
    procedure Load(Filename : string);
    property ClipboardAvailable : boolean read FClipboardAvailable;
    property SelectionList : TSelectionList read FSelectionList;
    property Editing : boolean read FEditing write SetEditing;
    property MainControl : TWinControl read FMainControl write FMainControl;
    property Modified : boolean read FModified write SetModified;
  published
    property OnAddedControl : TNotifyEvent read FOnAddedControl write FOnAddedControl;
    property OnSelectControl : TNotifyEvent read FOnSelectControl write FOnSelectControl;
    property OnUnselectControl : TNotifyEvent read FOnUnselectControl write FOnUnselectControl;
    property OnClipboardStateChange : TNotifyEvent read FOnClipboardStateChange write FOnClipboardStateChange;
    property OnModified : TNotifyEvent read FOnModified write FOnModified;
  end;

  TQRCustomComponentEditor = class
  protected
    function GetName : string; virtual; abstract;
    function GetBitmap : TBitmap; virtual; abstract;
  public
    procedure Popup; virtual; abstract;
    procedure Edit; virtual; abstract;
    procedure Settings; virtual; abstract;
    property Name : string read GetName;
    property Bitmap : TBitmap read GetBitmap;
  end;

  TQRCustomEditor = class(TCustomEditor)
  published
    property Align;
    property OnSelectControl;
    property OnUnselectControl;
    property OnClipboardStateChange;
    property OnModified;
  end;

  TQReportEditor = class(TForm)
    MainPanel: TPanel;
    ScrollArea: TScrollBox;
    CoolBar1: TCoolBar;
    FileTB: TToolBar;
    NewBtn: TToolButton;
    OpenBtn: TToolButton;
    SaveBtn: TToolButton;
    ToolButton4: TToolButton;
    PrintBtn: TToolButton;
    PreviewBtn: TToolButton;
    ToolButton7: TToolButton;
    CutBtn: TToolButton;
    CopyBtn: TToolButton;
    PasteBtn: TToolButton;
    AttributeTB: TToolBar;
    FontNameCB: TComboBox;
    ToolButton12: TToolButton;
    FontSizeCB: TComboBox;
    ToolButton13: TToolButton;
    BoldBtn: TToolButton;
    ItalicBtn: TToolButton;
    UnderLnBtn: TToolButton;
    ToolButton17: TToolButton;
    LeftAlBtn: TToolButton;
    CenterAlBtn: TToolButton;
    RightAlBtn: TToolButton;
    ToolButton21: TToolButton;
    ComponentsTB: TToolBar;
    ControlTB: TToolBar;
    ControlOKBtn: TToolButton;
    ControlCancelBtn: TToolButton;
    ToolButton6: TToolButton;
    ControlValue: TEdit;
    ControlEditBtn: TToolButton;
    ToolButton1: TToolButton;
    StatusBar: TStatusBar;
    QREMainMenu: TMainMenu;
    Insert1: TMenuItem;
    NewMI: TMenuItem;
    OpenMI: TMenuItem;
    SaveMI: TMenuItem;
    SaveAsMI: TMenuItem;
    load1: TMenuItem;
    ReportSetupMI: TMenuItem;
    PreviewMI: TMenuItem;
    PrintMI: TMenuItem;
    N1: TMenuItem;
    ExitMI: TMenuItem;
    View1: TMenuItem;
    CutMI: TMenuItem;
    CopyMI: TMenuItem;
    PasteMI: TMenuItem;
    N2: TMenuItem;
    ClearMI: TMenuItem;
    SelectAllMI: TMenuItem;
    Data1: TMenuItem;
    SelectDataMI: TMenuItem;
    AddChildtable1: TMenuItem;
    NormalImages: TImageList;
    ToolButton2: TToolButton;
    SettingsBtn: TToolButton;
    DataSetupBtn: TToolButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OpenMIClick(Sender: TObject);
    procedure EditorSelectControl(Sender: TObject);
    procedure EditorClipboardStateChange(Sender: TObject);
    procedure ControlTBResize(Sender: TObject);
    procedure ControlValueEnter(Sender: TObject);
    procedure ControlValueExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnClick(Sender: TObject);
    procedure EditorAddedControl(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FontNameCBChange(Sender: TObject);
    procedure ControlValueKeyPress(Sender: TObject; var Key: Char);
  private
    FFilename : string;
    FDesignTime : boolean;
    ControlEditors : TList;
    function GetFormEditor: TQRCustomEditor;
  protected
    Editor: TQRCustomEditor;
    procedure SetFilename(Value : String);
    procedure EnableAndDisable;
    procedure CreateComponentButtons;
    procedure AddControlClick(Sender : TObject);
    procedure SetStyle(Sender : TObject);
    procedure SetValue;
    procedure CancelValue;
    procedure SetDesignTime(Value : boolean);
    function EditControl(AQRPrintable : TQRPrintable) : boolean;
    function PrintableEditor : TQRPrintableEditor;
  public
    property DesignTime : boolean read FDesignTime write SetDesignTime;
    property Filename : string read FFilename write SetFilename;
    property FormEditor : TQRCustomEditor read GetFormEditor;
    procedure ShowEditor;
    procedure NewReport;
    procedure OpenReport;
    procedure SaveReport;
    procedure PrintReport;
    procedure PreviewReport;
    procedure SaveReportAs;
    procedure ReportSettings;
    procedure SelectData;
    procedure Cut;
    procedure Copy;
    procedure Paste;
  end;

  TQREditor = class(TWinControl)
  private
    QReportEditorForm : TQReportEditor;
    FShowMenu: boolean;
    function GetShowStatusLine: boolean;
    function GetFilename : string;
    procedure SetFilename(const Value: string);
    function GetReportEditor: TQReportEditor;
  protected
    procedure SetParent(AControl : TWinControl); override;
    procedure SetShowMenu(Value : boolean);
    procedure SetShowStatusLine(Value : boolean);
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property Filename : string read GetFilename write SetFilename;
    property ReportEditor : TQReportEditor read GetReportEditor;
  published
    property ShowMenu : boolean read FShowMenu write SetShowMenu;
    property ShowStatusLine : boolean read GetShowStatusLine write SetShowStatusLine;
    property Align;
    procedure ShowEditor;
    procedure NewReport;
    procedure OpenReport;
    procedure SaveReport;
    procedure PrintReport;
    procedure PreviewReport;
    procedure SaveReportAs;
    procedure ReportSettings;
    procedure SelectData;
    procedure Cut;
    procedure Copy;
    procedure Paste;
    procedure Show;
    procedure OpenReportFile(AFilename : string);
  end;

  procedure RegisterEditorControl(APrintableClass : TQRPrintableClass);

implementation

{$R *.DFM}
{$R QREDITOR.RES}

uses
  QRPrntr, QRExtra, QRWizard, QRCompEd, QRDatasu, dbtables, qrlabled
   {$ifdef QREDIT}, qrimageed {$endif};

var
  EditorClassList : TList;

function CalcOffset(AControl : TControl) : TPoint;
begin
  Result := Point(AControl.Left, AControl.Top);
  AControl := AControl.Parent;
  while not (AControl is TCustomEditor) and (AControl <> nil) do
  begin
    Result.X := Result.X + AControl.Left;
    Result.Y := Result.Y + AControl.Top;
    AControl := AControl.Parent;
  end;
end;

constructor TGrabHandle.CreateGrab(AOwner : TComponent; ParentControl : TControl; Position : TGrabPosition);
begin
  Create(AOwner);
  FParentControl := ParentControl;
  FPosition := Position;
  Parent := TWinControl(AOwner);
  Dim := false;
  Size := 5;
  OnMouseMove := TCustomEditor(Owner).MouseMoveHandler;
  OnMouseDown := TCustomEditor(Owner).MouseDownHandler;
  OnMouseUp := TCustomEditor(Owner).MouseUpHandler;
end;

procedure TGrabHandle.SetCursor;
begin
  if Dim then Cursor := crDefault
  else
    case FPosition of
      gpN, gpS : Cursor := crSizeNS;
      gpE, gpW : Cursor := crSizeWE;
      gpNE, gpSW : Cursor := crSizeNESW;
      gpNW, gpSE : Cursor := crSizeNWSE;
    end;
end;

procedure TGrabHandle.SetSize(Value : integer);
begin
  FSize := Value;
  Height := Size;
  Width := Size;
  Offset := FSize div 2;
  UpdatePosition;
end;

procedure TGrabHandle.SetDim(Value : boolean);
begin
  FDim := Value;
  SetCursor;
  Invalidate;
  UpdatePosition;
end;

procedure TGrabHandle.UpdatePosition;
var
  TopLeft : TPoint;
begin
  TopLeft := CalcOffset(FParentControl);
  if not Dim then
  begin
    case FPosition of
      gpNW : begin
               Top := TopLeft.Y - Offset;
               Left := TopLeft.X - Offset;
             end;
      gpN  : begin
               Top := TopLeft.Y - Offset;
               Left := TopLeft.X + (FParentControl.Width div 2) - Offset;
             end;
      gpNE : begin
               Top := TopLeft.Y - Offset;
               Left := TopLeft.X + FParentControl.Width - Offset - 1;
             end;
      gpE  : begin
               Top := TopLeft.Y + (FParentControl.Height div 2) - Offset;
               Left := TopLeft.X + FParentControl.Width - Offset - 1;
             end;
      gpSE : begin
               Top := TopLeft.Y + FParentControl.Height - Offset - 1;
               Left := TopLeft.X + FParentControl.Width - Offset - 1;
             end;
      gpS  : begin
               Top := TopLeft.Y + FParentControl.Height - Offset - 1;
               Left := TopLeft.X + (FParentControl.Width div 2) - Offset;
             end;
      gpSW : begin
               Top := TopLeft.Y + FParentControl.Height - Offset - 1;
               Left := TopLeft.X - Offset;
             end;
      gpW  : begin
               Top := TopLeft.Y + (FParentControl.Height div 2) - Offset;
               Left := TopLeft.X - Offset;
             end;
    end;
    Visible := true;
  end else
    case FPosition of
      gpNW : begin
               Top := TopLeft.Y;
               Left := TopLeft.X;
               Visible := true;
             end;
      gpNE : begin
               Top := TopLeft.Y;
               Left := TopLeft.X + FParentControl.Width - Size;
               Visible := true;
             end;
      gpSE : begin
               Top := TopLeft.Y + FParentControl.Height - Size;
               Left := TopLeft.X + FParentControl.Width - Size;
               Visible := true;
             end;
      gpSW : begin
               Top := TopLeft.Y + FParentControl.Height - Size;
               Left := TopLeft.X;
               Visible := true;
             end;
    else
      Visible := false;
    end;
end;

procedure TGrabHandle.Paint;
begin
  if Visible then
  begin
    if Dim then
    begin
      if FPosition in [gpNE, gpNW, gpSE, gpSW] then
      begin
        Canvas.Brush.Color := clGray;
        Canvas.Pen.Color := clGray;
        Canvas.FillRect(ClientRect);
      end;
    end else
    begin
      Canvas.Brush.Color := clBlack;
      Canvas.Pen.Color := clBlack;
      Canvas.FillRect(ClientRect);
    end;
  end;
end;

constructor TFocusFrame.CreateParented(AOwner : TComponent; ParentControl : TControl);
var
  Corner : TGrabPosition;
begin
  Create(AOwner);
  GrabHandles := TList.Create;
  for Corner := gpN to gpNW do
    GrabHandles.Add(TGrabHandle.CreateGrab(AOwner, ParentControl, Corner));
  State := fsNormal;
  FParentControl := ParentControl;
end;

destructor TFocusFrame.Destroy;
begin
  while GrabHandles.Count > 0 do
  begin
    TObject(GrabHandles[0]).Free;
    GrabHandles.Delete(0);
  end;
  GrabHandles.Free;
  inherited Destroy;
end;

procedure TFocusFrame.UpdateGrabHandles;
var
  Corner : integer;
begin
  for Corner := 0 to 7 do
    TGrabHandle(GrabHandles[Corner]).UpdatePosition;
end;

procedure TFocusFrame.PaintFrame;
var
  AHandle : THandle;
begin
  AHandle := GetDCEx(TWinControl(Owner).Handle, 0, DCX_WINDOW or DCX_PARENTCLIP);
  DrawFocusRect(AHandle, CurrentRect);
  ReleaseDC(TWinControl(Owner).Handle, AHandle);
end;

procedure TFocusFrame.SetState(Value : TFocusFrameState);
var
  I : integer;
  Ofs : TPoint;
begin
  if FState = fsFrame then PaintFrame;
  if Value = fsFrame then
  begin
    for I := 0 to GrabHandles.Count - 1 do
      TGrabHandle(GrabHandles[I]).Visible := false;
    FParentControl.Refresh;
    CurrentRect := FParentControl.BoundsRect;
    Ofs := CalcOffset(FParentControl);
    OffsetRect(CurrentRect, Ofs.X - CurrentRect.Left, Ofs.Y - CurrentRect.Top);
    PaintFrame;
  end else
  begin
    for I := 0 to GrabHandles.Count - 1 do
      TGrabHandle(GrabHandles[I]).Dim := Value = fsDim;
  end;
  FState := Value;
end;

procedure TFocusFrame.SizeFrame(ALeft, AUp, ARight, ADown : integer);
begin
  if FState = fsFrame then PaintFrame;
  CurrentRect.Left := CurrentRect.Left - ALeft;
  CurrentRect.Top := CurrentRect.Top - AUp;
  CurrentRect.Right := CurrentRect.Right + ARight;
  CurrentRect.Bottom := CurrentRect.Bottom + ADown;
  if FState = fsFrame then PaintFrame;
end;

procedure TFocusFrame.MoveFrame(ALeft, AUp : integer);
begin
  if FState = fsFrame then PaintFrame;
  OffsetRect(CurrentRect, -ALeft, -AUp);
  if FState = fsFrame then PaintFrame;
end;

constructor TSelectionList.Create;
begin
  ControlList := TList.Create;
  FocusList := TList.Create;
  FState := fsNormal;
  MovedLeft := 0;
  MovedUp := 0;
  SizedLeft := 0;
  SizedRight := 0;
  SizedUp := 0;
  SizedDown := 0;
end;

destructor TSelectionList.Destroy;
begin
  Clear;
  ControlList.Free;
  FocusList.Free;
  inherited Destroy;
end;

procedure TSelectionList.Add(AControl : TControl);
var
  aFrame : TFocusFrame;
begin
  ControlList.Add(AControl);
  aFrame :=TFocusFrame.CreateParented(Editor, AControl);
  aFrame.State := FState;
  FocusList.Add(aFrame);
end;

procedure TSelectionList.Remove(AControl : TControl);
var
  I : integer;
begin
  I := ControlList.IndexOf(AControl);
  if I <> - 1 then
  begin
    ControlList.Delete(I);
    TObject(FocusList[I]).Free;
    FocusList.Delete(I);
  end;
end;

procedure TSelectionList.Clear;
var
  I : integer;
begin
  for I := 0 to FocusList.Count - 1 do
    TObject(FocusList[I]).Free;
  FocusList.Clear;
  ControlList.Clear;
end;

function TSelectionList.IsSelected(AControl : TControl) : boolean;
begin
  Result := ControlList.IndexOf(AControl) <> -1;
end;

procedure TSelectionList.SetState(Value : TFocusFrameState);
var
  I : integer;
begin
  for I := 0 to FocusList.Count - 1 do
    TFocusFrame(FocusList[I]).State := Value;
  FState := Value;
end;

function TSelectionList.GetCount : integer;
begin
  Result := ControlList.Count;
end;

function TSelectionList.GetItem(Index : integer) : TControl;
begin
  Result := TControl(ControlList[Index]);
end;

function TSelectionList.UpdateControls : boolean;
var
  I : integer;
begin
  Result := (SizedRight <> 0) or (SizedLeft <> 0) or (SizedUp <> 0) or
            (SizedDown <> 0) or (MovedUp <> 0) or (MovedLeft <> 0);
  for I := 0 to Count - 1 do
  begin
    with TControl(ControlList[I]) do
    begin
      Left := Left - MovedLeft - SizedLeft;
      Top := Top - MovedUp - SizedUp;
      Height := Height + SizedUp + SizedDown;
      Width := Width + SizedLeft + SizedRight;
    end;
    TFocusFrame(FocusList[I]).UpdateGrabHandles;
  end;
  SizedRight := 0;
  SizedLeft := 0;
  SizedDown := 0;
  SizedUp := 0;
  MovedUp := 0;
  MovedLeft := 0;
end;

procedure TSelectionList.UnselectChildren;
var
  UnselectList : TList;
  I : integer;
begin
  UnselectList := TList.Create;
  for I := 0 to Count - 1 do
    if ControlList.IndexOf(TControl(ControlList[I]).Parent) > - 1 then
      UnselectList.Add(ControlList[I]);
  for I := 0 to UnselectList.Count - 1 do
    Remove(TControl(UnselectList[I]));
  UnselectList.Clear;
end;

procedure TSelectionList.Size(ALeft, AUp, ARight, ADown : integer);
var
  I : integer;
begin
  for I := 0 to Count - 1 do
    TFocusFrame(FocusList[I]).SizeFrame(ALeft, AUp, ARight, ADown);
  Inc(SizedRight, ARight);
  Inc(SizedLeft, ALeft);
  Inc(SizedDown, ADown);
  Inc(SizedUp, AUp);
end;

procedure TSelectionList.Move(ALeft, AUp : integer);
var
  I : integer;
begin
  if (ALeft <> 0) or (AUp <> 0) then UnselectChildren;
  for I := 0 to Count - 1 do
    TFocusFrame(FocusList[I]).MoveFrame(ALeft, AUp);
  Inc(MovedLeft, ALeft);
  Inc(MovedUp, AUp);
end;

procedure TSelectionList.BringToFront;
var
  I : integer;
begin
  for I := 0 to ControlList.Count - 1 do
    TControl(ControlList[I]).BringToFront;
end;

procedure TSelectionList.SendToBack;
var
  I : integer;
begin
  for I := 0 to ControlList.Count - 1 do
    TControl(ControlList[I]).SendToBack;
end;

procedure TSelectionList.FindMaxValues(var ALeft, ATop, ARight, ABottom : integer);
var
  I : integer;
begin
  if Count > 0 then
    with Items[0] do
    begin
      ALeft := Left;
      ATop := Top;
      ARight := Left + Width;
      ABottom := Top + Height;
    end;
  if Count > 1 then
  for I := 1 to Count - 1 do
    with Items[I] do
    begin
      if Left < ALeft then ALeft := Left;
      if Top < ATop then ATop := Top;
      if ARight > Left + Width then ARight := Left + Width;
      if ABottom > Top + Height then ABottom := Top + Height;
    end;
end;

procedure TSelectionList.AlignTo(Position : TGrabPosition);
var
  I : integer;
  MaxLeft, MaxRight, MaxTop, MaxBottom : integer;
begin
  FindMaxValues(MaxLeft, MaxTop, MaxRight, MaxBottom);
  for I := 0 to Count - 1 do
    with TFocusFrame(FocusList[I]) do
      case Position of
        gpW : Move(MaxLeft - Left, 0);
        gpE : Move(MaxRight - Left - Width, 0);
        gpN : Top := MaxTop;
        gpS : Top := MaxBottom - Height;
      end;
  UpdateControls;
end;

procedure TSelectionList.AlignLefts;
begin
  AlignTo(gpW);
end;

procedure TSelectionList.AlignRights;
begin
  AlignTo(gpE);
end;

procedure TSelectionList.AlignTops;
begin
  AlignTo(gpN);
end;

procedure TSelectionList.AlignBottoms;
begin
  AlignTo(gpS);
end;

procedure TSelectionList.Copy(var Stream : TStream);
var
  I, J : integer;
  AComponent : TComponent;
  AChild : TComponent;
begin
  if Stream <> nil then Stream.Free;
  Stream := TMemoryStream.Create;
  Stream.Position := 0;
  UnselectChildren;
  for I := 0 to Count - 1 do
  begin
    AComponent := TComponent(ControlList[I]);
    if AComponent is TWinControl then
      for J := 0 to TWinControl(AComponent).ControlCount - 1 do
      begin
        AChild := TWinControl(AComponent).Controls[J];
        AChild.Owner.RemoveComponent(AChild);
        AComponent.InsertComponent(AChild);
      end;
    Stream.WriteComponent(TComponent(ControlList[I]));
    if AComponent is TWinControl then
      for J := 0 to TWinControl(AComponent).ControlCount - 1 do
      begin
        AChild := TWinControl(AComponent).Controls[J];
        AChild.Owner.RemoveComponent(AChild);
        AComponent.Owner.InsertComponent(AChild);
      end;
  end;
end;

constructor TCustomEditor.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FSelectionList := TSelectionList.Create;
  FSelectionList.Editor := Self;
  FEditing := false;
  MouseIsDown := false;
  FClipboardAvailable := false;
  FMainControl := nil;
  FOnSelectControl := nil;
  FOnUnselectControl := nil;
  FOnModified := nil;
  FOnClipboardStateChange := nil;
  FOnAddedControl := nil;
  Clipboard := nil;
  BevelInner := bvNone;
  BevelOuter := bvNone;
end;

destructor TCustomEditor.Destroy;
begin
  FSelectionList.Free;
  if Clipboard <> nil then Clipboard.Free;
  inherited Destroy;
end;

procedure TCustomEditor.SetEvents(AControl : TWinControl);
var
  I : integer;
begin
  for I := 0 to AControl.ControlCount - 1 do with AControl do
  begin
    TCustomEditor(Controls[I]).OnMouseDown := MouseDownHandler;
    TCustomEditor(Controls[I]).OnMouseMove := MouseMoveHandler;
    TCustomEditor(Controls[I]).OnMouseUp := MouseUpHandler;
    if Controls[I] is TWinControl then SetEvents(TWinControl(Controls[I]));
  end;
end;

procedure TCustomEditor.SetEditing(Value : boolean);
begin
  if Value then
  begin
    SetEvents(Self);
    FModified := false;
  end;
  SetFocus;
  FEditing := Value;
end;

procedure TCustomEditor.SetModified(Value : boolean);
begin
  if (not FModified) and Value and Assigned(FOnModified) then
    FOnModified(Self);
  FModified := Value;
end;

procedure TCustomEditor.Add(AComponent : TComponent; AParent : TWinControl);
begin
  InsertComponent(AComponent);
  if AComponent is TControl then
  begin
    TControl(AComponent).Parent := AParent;
    Select(TControl(AComponent), true);
  end;
end;

procedure TCustomEditor.DoAdd(X, Y : integer);
var
  AComponent : TComponent;
  AParent : TWinControl;
begin
  AParent := nil;
  AComponent := NewComponentClass.Create(nil);
  if AComponent is TControl then with TControl(AComponent) do
  begin
    if (SelectionList.Count = 1) and (SelectionList[0] is TWinControl) then
      AParent := TWinControl(SelectionList[0])
    else
      AParent := Self;
    Left := X;
    Top := Y;
  end;
  SelectionList.Clear;
  Add(AComponent, AParent);
  SetEvents(Self);
  FState := esNormal;
  if Assigned(FOnAddedControl) then FOnAddedControl(AComponent);
end;

procedure TCustomEditor.DoPopup(X, Y : integer);
begin
  if SelectionList.Count = 1 then;
end;

procedure TCustomEditor.AddClass(ComponentClass : TNewComponentClass);
begin
  NewComponentClass := ComponentClass;
  FState := esAdd;
end;

procedure TCustomEditor.Select(AControl : TControl; MultiSelect : boolean);
begin
  if AControl <> MainControl then
  begin
    if not MultiSelect then SelectionList.Clear;
    SelectionList.Add(AControl);
    if SelectionList.Count > 1 then SelectionList.State := fsDim else SelectionList.State := fsNormal;
    if Assigned(FOnSelectControl) then FOnSelectControl(AControl);
  end;
end;

procedure TCustomEditor.Unselect(AControl : TControl);
begin
  SelectionList.Remove(AControl);
  if Assigned(FOnUnselectControl) then
    FOnUnselectControl(AControl);
end;

procedure TCustomEditor.UnselectAll;
var
  I : integer;
  AControl : TControl;
begin
  for I := 0 to SelectionList.Count - 1 do
  begin
    AControl := SelectionList[0];
    SelectionList.Remove(AControl);
    if Assigned(FOnUnselectControl) then
      FOnUnselectControl(AControl);
  end;
end;

procedure TCustomEditor.StartResize(Position : TGrabPosition; APoint : TPoint);
begin
  if State = esAdd then Exit;
  case Position of
    gpNW, gpN, gpNE : begin
                        SizeUp := true;
                        SizeDown := false;
                      end;
    gpSW, gpS, gpSE : begin
                        SizeUp := false;
                        SizeDown := true;
                      end;
  else
    SizeUp := false;
    SizeDown := false;
  end;
  case Position of
    gpNW, gpW, gpSW : begin
                        SizeLeft := true;
                        SizeRight := false;
                      end;
    gpNE, gpE, gpSE : begin
                  SizeLeft := false;
                  SizeRight := true;
                end;
  else
    SizeLeft := false;
    SizeRight := false;
  end;
  Origin := APoint;
  FState := esResize;
  SelectionList.State := fsFrame;
end;

procedure TCustomEditor.ResizeTo(APoint : TPoint);
var
  ChangeLeft,
  ChangeTop,
  ChangeBottom,
  ChangeRight : integer;
begin
  if SizeLeft then ChangeLeft := Origin.X - APoint.X else ChangeLeft := 0;
  if SizeRight then ChangeRight := APoint.X - Origin.X else ChangeRight := 0;
  if SizeUp then ChangeTop := Origin.Y - APoint.Y else ChangeTop := 0;
  if SizeDown then ChangeBottom := APoint.Y - Origin.Y else ChangeBottom := 0;
  SelectionList.Size(ChangeLeft, ChangeTop, ChangeRight, ChangeBottom);
  Origin := APoint;
end;

procedure TCustomEditor.EndResize(APoint : TPoint);
begin
  ResizeTo(APoint);
  if SelectionList.Count = 1 then SelectionList.State := fsNormal
  else SelectionList.State := fsDim;
  FState := esNormal;
  Modified := SelectionList.UpdateControls or Modified;
end;

procedure TCustomEditor.StartMove(APoint : TPoint);
begin
  if State = esAdd then Exit;
  SelectionList.State := fsFrame;
  FState := esMove;
  Origin := APoint;
end;

procedure TCustomEditor.MoveTo(APoint : TPoint);
begin
  SelectionList.Move(Origin.X - APoint.X, Origin.Y - APoint.Y);
  Origin := APoint;
end;

procedure TCustomEditor.EndMove(APoint : TPoint);
begin
  MoveTo(APoint);
  if SelectionList.Count = 1 then SelectionList.State := fsNormal
  else SelectionList.State := fsDim;
  FState := esNormal;
  Modified := SelectionList.UpdateControls or Modified;
end;

procedure TCustomEditor.MouseDownHandler(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : integer);
var
  AControl : TControl;
begin
  AControl := TControl(Sender);
  if Sender is TGrabHandle then with TGrabHandle(Sender) do
  begin
    if Cursor <> crDefault then
      StartResize(FPosition, Self.ScreenToClient(ClientToScreen(Point(X, Y))))
    else
      StartMove(Self.ScreenToClient(ClientToScreen(Point(X, Y))));
  end
  else
    if SelectionList.IsSelected(AControl) then
    begin
      if (SelectionList.Count > 1) and (ssShift in Shift) then Unselect(AControl)
      else StartMove(Self.ScreenToClient(AControl.ClientToScreen(Point(X, Y))));
    end else
    begin
      if ssShift in Shift then Select(AControl, true)
      else Select(AControl, false);
      StartMove(Self.ScreenToClient(AControl.ClientToScreen(Point(X, Y))));
    end;
  if Button = mbRight then DoPopup(X, Y)
  else if State = esAdd then DoAdd(X, Y);
  MouseIsDown := true;
end;

procedure TCustomEditor.MouseMoveHandler(Sender : TObject; Shift : TShiftState; X, Y : integer);
begin
  if MouseIsDown then
  case FState of
    esMove : MoveTo(ScreenToClient(TControl(Sender).ClientToScreen(Point(X, Y))));
    esResize : ResizeTo(ScreenToClient(TControl(Sender).ClientToScreen(Point(X, Y))));
  end;
end;

procedure TCustomEditor.MouseUpHandler(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : integer);
begin
  MouseIsDown := false;
  case FState of
    esMove : EndMove(ScreenToClient(TControl(Sender).ClientToScreen(Point(X, Y))));
    esResize : EndResize(ScreenToClient(TControl(Sender).ClientToScreen(Point(X, Y))));
  end;
  FState := esNormal;
end;

procedure TCustomEditor.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  UnselectAll;
  if State = esAdd then
    DoAdd(X, Y)
end;

procedure TCustomEditor.DeleteSelected;
var
  I : integer;
begin
  for I := 0 to SelectionList.Count - 1 do
    SelectionList.Items[I].Free;
  SelectionList.Clear;
end;

procedure TCustomEditor.CopySelected;
begin
  if SelectionList.Count > 0 then
    SelectionList.Copy(Clipboard);
  FClipboardAvailable := (Clipboard <> nil) and (Clipboard.Size > 0);
  if assigned(FOnClipboardStateChange) then FOnClipboardStateChange(Self);
end;

procedure TCustomEditor.CutSelected;
begin
  CopySelected;
  DeleteSelected;
end;

procedure TCustomEditor.Paste;
var
  NewComponent : TComponent;
  AParent : TWinControl;
begin
  if (SelectionList.Count = 1) and (SelectionList[0] is TWinControl) then
    AParent := TWinControl(SelectionList[0])
  else AParent := MainControl;
  SelectionList.Clear;
  if (Clipboard <> nil) and (Clipboard.Size > 0) then
  begin
    Clipboard.Position := 0;
    repeat
      NewComponent := Clipboard.ReadComponent(nil);
      Add(NewComponent, AParent);
    until Clipboard.Position >= Clipboard.Size - 1;
    SetEvents(Self);
    Modified := true;
  end;
end;

procedure TCustomEditor.ClearAll;
begin
  UnselectAll;
  while ControlCount > 0 do
    Controls[0].Free;
end;

procedure TCustomEditor.SaveToStream(Stream : TStream);
var
  I : integer;
  TempList : TList;
begin
  UnSelectAll;
  TempList := TList.Create;
  for I := 0 to ComponentCount - 1 do
    if Components[I] <> MainControl then TempList.Add(Components[I]);
  for I := 0 to TempList.Count - 1 do
  begin
    RemoveComponent(TempList[I]);
    MainControl.InsertComponent(TempList[I]);
  end;
  if MainControl <> nil then
    Stream.WriteComponent(MainControl);
  TempList.Free;
end;

procedure TCustomEditor.Save(Filename : string);
var
  Stream : TFileStream;
begin
  Stream := TFileStream.Create(Filename, fmCreate);
  try
    SaveToStream(Stream)
  finally
    Stream.Free;
  end;
end;

procedure TCustomEditor.LoadFromStream(Stream : TStream);
begin
  ClearAll;
  Stream.Position := 0;
  repeat
    Add(Stream.ReadComponent(nil), Self);
  until Stream.Position >= Stream.Size - 1;
  SetEvents(Self);
  if ControlCount > 0 then
    MainControl := TWinControl(Controls[0]);
  Modified := true;
end;

procedure TCustomEditor.Load(Filename : string);
resourcestring
  sLoadError = 'error';
var
  Stream : TFileStream;
  aForm : TForm;
  I : integer;
  AComponent : TComponent;
begin
  MainControl := nil;
  try
    Stream := TFileStream.Create(Filename, fmOpenRead + fmShareDenyNone);
    try
      LoadFromStream(Stream)
    finally
      Stream.Free;
    end;
  except
    try
      aForm := TForm.Create(Application);
      ReadComponentResFile(Filename, aForm);
      I := 0;
      while I < aForm.ComponentCount do
      begin
        if (aForm.Components[I] is TQuickRep) then
          MainControl := TQuickRep(aForm.Components[0]);
        inc(i);
      end;
      if MainControl <> nil then
      begin
        while AForm.ComponentCount > 0 do
        begin
          AComponent := AForm.Components[0];
          AForm.RemoveComponent(AComponent);
          if AComponent <> MainControl then
            MainControl.InsertComponent(AComponent);
        end;
        Add(MainControl, self);
        SetEvents(Self);
        aForm.Free;
      end;
    except
      ShowMessage(sLoadError);
    end;
  end;
end;

function AskFilename(var AFilename : string) : boolean;
resourcestring
  sAskFileNameFilter = 'QuickReport file|*.qr';
begin
  with TSaveDialog.Create(Application) do
  try
    Filter := sAskFileNameFilter;
    DefaultExt := 'qr';
    Filename := AFilename;
    if Execute then
    begin
      AFilename := Filename;
      Result := true;
    end else
      Result := false;
  finally
    Free;
  end
end;

procedure TQReportEditor.SetFilename(Value : string);
begin
  FFilename := Value;
  Caption := 'QuickReport - ' + Filename; { do not localize }
end;

procedure TQReportEditor.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_DELETE : Editor.DeleteSelected;
    ord('C') : if ssCtrl in Shift then Copy;
    ord('X') : if ssCtrl in Shift then Cut;
    ord('V') : if ssCtrl in Shift then Paste;
  end;
end;

procedure TQReportEditor.NewReport;
var
  AReport : TCustomQuickRep;
begin
  Editor.ClearAll;
  AReport := ExecuteQRWizard;
  if AReport <> nil then
  begin
    Editor.MainControl := AReport;
    Editor.Add(AReport, Editor);
    AReport.Top := 0;
    AReport.Left := 0;
    ScrollArea.VertScrollBar.Range := AReport.Height;
    ScrollArea.HorzScrollBar.Range := AReport.Width;
  end;
  Editor.Editing := true;
  EnableAndDisable;
end;

procedure TQReportEditor.OpenMIClick(Sender: TObject);
begin
  Editor.AddClass(TQRExpr);
end;

function TQReportEditor.PrintableEditor : TQRPrintableEditor;
begin
  Result := TQRPrintable(Editor.SelectionList[0]).EditorClass.Create(TQRPrintable(Editor.SelectionList[0]));
end;

procedure TQReportEditor.EditorSelectControl(Sender: TObject);
var
   contEd : TQRPrintableEditor;

  procedure StyleBtns(Value : boolean);
  begin
    BoldBtn.Enabled := Value;
    ItalicBtn.Enabled := Value;
    UnderLnBtn.Enabled := Value;
    LeftAlBtn.Enabled := Value;
    CenterAlBtn.Enabled := Value;
    RightAlBtn.Enabled := Value;
  end;

begin
  EnableAndDisable;
  if FontNameCB.Items.Count = 0 then
    FontNameCB.Items := GetFonts;
  FontNameCB.Sorted := True;
  if FontSizeCB.Items.Count = 0 then
    PopulateFontSizeCombo(FontSizeCB);
  if (Editor.SelectionList.Count = 1) and (Editor.SelectionList[0] is TQRPrintable) then
  begin
    contEd := PrintableEditor;
{$ifdef QREDIT}
    if conted is TQRImageEditor then
    begin
    end
    else
{$endif}
    if conted is TQRLabelEditor then
    begin
      with contEd do
      try
        ControlValue.Text := Value;
        FontSizeCB.Text := IntToStr(Font.Size);
        FontNameCB.ItemIndex := FontNameCB.Items.IndexOf(Font.Name);
        BoldBtn.Down := fsBold in Font.Style;
        ItalicBtn.Down := fsItalic in Font.Style;
        UnderLnBtn.Down := fsUnderline in Font.Style;
{$ifndef QRSTANDARD}
        case Alignment of
          taLeftJustify : LeftAlBtn.Down := true;
          taCenter : CenterAlBtn.Down := true;
          taRightJustify : RightAlBtn.Down := true;
        end;
{$endif}
        StyleBtns(True);
      finally
        Free;
      end;
    end;
  end
  else
  begin
    ControlValue.Text := '';
    StyleBtns(False);
  end;
end;

procedure TQReportEditor.EditorClipboardStateChange(Sender: TObject);
begin
  EnableAndDisable;
end;

procedure TQReportEditor.Paste;
begin
  Editor.Paste;
end;

procedure TQReportEditor.Cut;
begin
  Editor.CutSelected;
end;

procedure TQReportEditor.Copy;
begin
  Editor.CopySelected ;
end;

procedure TQReportEditor.OpenReport;
resourcestring
  sOpenReportFilter = 'QuickReport file|*.qr';
var
  I : integer;
  ADS : TDatasource;
begin
  ADS := nil;
  with TOpenDialog.Create(Self) do
  try
    Filter := sOpenReportFilter;
    DefaultExt := 'qr';
    if Execute then
    begin
      Editor.Load(Filename);
      Self.Filename := Filename;
      if Editor.MainControl is TQuickRep then
      begin
        for I := 0 to Editor.MainControl.ComponentCount - 1 do
          if Editor.MainControl.Components[I] is TDataSource then
            ADS := TDataSource(Editor.MainControl.Components[I]);
        for I := 0 to Editor.MainControl.ControlCount - 1 do
          if Editor.MainControl.Controls[I] is TQRSubDetail then
            TTable(TQRSubDetail(Editor.MainControl.Controls[I]).DataSet).MasterSource := ADS;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TQReportEditor.ControlTBResize(Sender: TObject);
begin
  ControlValue.Width := ControlTB.Width - ControlValue.Left - ControlTB.ButtonWidth;
end;

procedure TQReportEditor.ControlValueEnter(Sender: TObject);
begin
  ControlOKBtn.Enabled := true;
  ControlCancelBtn.Enabled := true;
  AttributeTB.Enabled := false;
  FileTB.Enabled := false;
end;

procedure TQReportEditor.ControlValueExit(Sender: TObject);
begin
  ControlOKBtn.Enabled := false;
  ControlCancelBtn.Enabled := false;
  AttributeTB.Enabled := true;
  FileTB.Enabled := true;
end;

procedure TQReportEditor.SaveReport;
begin
  if (Filename <> '') or AskFilename(FFilename) then
  begin
    Editor.Save(Filename);
    Filename := Filename;
  end;
end;

procedure TQReportEditor.FormCreate(Sender: TObject);
begin
  Editor := TQRCustomEditor.Create(Self);
  FDesignTime := false;
  with Editor do
  begin
    Parent := ScrollArea;
    OnAddedControl := EditorAddedControl;
    OnClipboardStateChange := EditorClipboardStateChange;
    OnSelectControl := EditorSelectControl;
    OnUnselectControl := EditorSelectControl;
    Align := alClient;
  end;
  ControlValue.Text := '';
  FontSizeCB.Text := '';
  Filename := '';
  ControlEditors := TList.Create;
  CreateComponentButtons;
  EnableAndDisable;
end;

procedure TQReportEditor.SetDesignTime(Value : boolean);
begin
  FDesignTime := value;
  FileTB.Enabled := not Value;
  ComponentsTB.Enabled := not Value;
  ControlTB.Enabled := not Value;
  AttributeTB.Enabled := not Value;
end;

procedure TQReportEditor.SaveReportAs;
begin
  if AskFilename(FFilename) then
  begin
    Editor.Save(Filename);
    Filename := filename;
  end;
end;

procedure TQReportEditor.ReportSettings;
begin
  with TQRCompEd.Create(Application) do
  try
    QuickRep := TQuickRep(Editor.MainControl);
    ShowModal;
  finally
    free;
  end;
end;

procedure TQReportEditor.PrintReport;
begin
  TCustomQuickRep(Editor.MainControl).Print;
end;

procedure TQReportEditor.PreviewReport;
begin
  TCustomQuickRep(Editor.MainControl).Preview;
end;

procedure TQReportEditor.SetValue;
begin
  with PrintableEditor do
  try
    Value := ControlValue.Text;
  finally
    Free;
  end;
end;

procedure TQReportEditor.CancelValue;
begin
  with PrintableEditor do
  try
    ControlValue.Text := Value;
  finally
    Free;
  end;
end;

procedure TQReportEditor.SetStyle(Sender : TObject);
var
  AFontStyle : TFontStyles;
begin
  with TToolButton(Sender) do
  begin
    with PrintableEditor do
    try
      AFontStyle := [];
      if BoldBtn.Down then include(AFontStyle, fsBold);
      if ItalicBtn.Down then include(AFontStyle, fsItalic);
      if UnderLnBtn.Down then include(AFontStyle, fsUnderLine);
{$ifndef QRSTANDARD}
      if LeftAlBtn.Down then Alignment := taLeftJustify
      else
        if CenterAlBtn.Down then Alignment := taCenter
        else
          if RightAlBtn.Down then Alignment := taRightJustify;
{$endif}
      Font.Style := AFontStyle;
    finally
      Free;
    end;
  end;
end;

procedure TQReportEditor.BtnClick(Sender: TObject);
begin
  if ((Sender = NewBtn) or (Sender = NewMI)) then NewReport
  else
  if ((Sender = OpenBtn) or (Sender = OpenMI)) then OpenReport
  else
  if ((Sender = SaveBtn) or (Sender = SaveMI)) then SaveReport
  else
  if (Sender = SaveAsMI) then SaveReportAS
  else
  if ((Sender = PrintBtn) or (Sender = PrintMI)) then PrintReport
  else
  if ((Sender = PreviewBtn) or (Sender = PreviewMI)) then PreviewReport
  else
  if ((Sender = CopyBtn) or (Sender = CopyMI)) then Copy
  else
  if ((Sender = CutBtn) or (Sender = CutMI)) then Cut
  else
  if ((Sender = PasteBtn) or (Sender = PasteMI)) then Paste
  else
  if (Sender = ControlEditBtn) then EditControl(TQRPrintable(Editor.SelectionList[0]))
  else
  if (sender = ReportSetupMI) or (Sender = SettingsBtn) then ReportSettings
  else
  if (Sender = BoldBtn) or (Sender = ItalicBtn) or (Sender = UnderLnBtn) or
    (sender = LeftAlBtn) or (Sender = CenterAlBtn) or (Sender = RightAlBtn) then
    SetStyle(Sender)
  else
  if (Sender = ControlOkBtn) then SetValue
  else
  if (Sender = ControlCancelBtn) then CancelValue
  else
  if (Sender = SelectDataMI) or (Sender = DataSetupBtn) then SelectData;
  EnableAndDisable;
end;

procedure TQReportEditor.EnableAndDisable;

   procedure SetToolBars(ABar: TToolbar; Enable : boolean);
   var i: integer;
   begin
     for i := 0 to ABar.ControlCount-1 do
       ABar.Controls[i].Enabled := Enable;
   end;
begin
  CopyBtn.Enabled := Editor.SelectionList.Count > 0;
  CopyMI.Enabled := CopyBtn.Enabled;
  CutBtn.Enabled := CopyBtn.Enabled;
  CutMI.Enabled := CopyBtn.Enabled;

  PasteBtn.Enabled := Editor.ClipboardAvailable;
  PasteMI.Enabled := PasteBtn.Enabled;

{  AlignTopBtn.Enabled := Editor.SelectionList.Count > 1;
  AlignBottomBtn.Enabled := AlignTopBtn.Enabled;
  AlignLeftBtn.Enabled := AlignTopBtn.Enabled;
  AlignRightBtn.Enabled := AlignTopBtn.Enabled;}

  ControlTB.Enabled := (Editor.SelectionList.Count = 1) and (Editor.SelectionList[0] is TQRPrintable);
  AttributeTB.Enabled := Editor.SelectionList.Count > 0;
  SaveMI.Enabled := Editor.MainControl <> nil;
  SaveAsMI.Enabled := SaveMI.Enabled;
  ReportSetupMI.Enabled := SaveMI.Enabled;
  PreviewMI.Enabled := SaveMI.Enabled;
  PrintMI.Enabled := SaveMI.Enabled;
  SaveBtn.Enabled := SaveMI.Enabled;
  PreviewBtn.Enabled := SaveMI.Enabled;
  PrintBtn.Enabled := SaveMI.Enabled;
  DataSetupBtn.Enabled := SaveMI.Enabled;
  SelectDataMI.Enabled := SaveMI.Enabled;
  SettingsBtn.Enabled := SaveMI.Enabled;
  SetToolBars(ControlTB, SaveMI.Enabled);
  SetToolBars(AttributeTB, SaveMI.Enabled);
  SetToolBars(ComponentsTB, SaveMI.Enabled);

end;

procedure TQReportEditor.AddControlClick(Sender : TObject);
begin
  with Sender as TSpeedButton do
  begin
    Editor.AddClass(TQRPrintableEditor(ControlEditors[Tag]).PrintableClass);
    Down := True;
  end;
end;

procedure TQReportEditor.CreateComponentButtons;
var
  I : integer;
  ResName : array[0..79] of char;
begin
  for I := 0 to EditorClassList.Count - 1 do
  begin
    with TSpeedButton.Create(Self) do
    begin
      Parent := ComponentsTB;
      Tag := I;
      Flat := true;
      with TQRPrintableClass(EditorClassList[I]).Create(nil) do
      try
        ControlEditors.Add(EditorClass.Create(nil));
      finally
        Free;
      end;
      with TQRPrintableEditor(ControlEditors[ControlEditors.Count - 1]) do
      begin
        StrPCopy(ResName, GlyphResName);
        Glyph.Handle := LoadBitmap(hinstance,ResName);
        Hint := ControlName;
        OnClick := AddControlClick;
      end;
    end;
  end;
end;

function TQReportEditor.EditControl(AQRPrintable : TQRPrintable) : boolean;
begin
  with AQRPrintable.EditorClass.Create(AQRPrintable) do
  try
    Result := ShowEditor
  finally
    Free;
  end;
end;

procedure TQReportEditor.EditorAddedControl(Sender: TObject);
begin
  if Sender is TQRPrintable then
    if not EditControl(TQRPrintable(Sender)) then Editor.DeleteSelected;
end;

procedure TQReportEditor.ShowEditor;
begin
  ShowModal;
end;

procedure TQReportEditor.FormActivate(Sender: TObject);
begin
  if FontNameCB.Items.Count = 0 then
    FontNameCB.Items := GetFonts;
  FontNameCB.Sorted := True;
  if FontSizeCB.Items.Count = 0 then
    PopulateFontSizeCombo(FontSizeCB);
end;

procedure TQReportEditor.SelectData;
begin
  with TQRDataSetup.Create(Application) do
  try
    QuickRep := TQuickRep(Editor.MainControl);
    ReportEditor := Editor;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TQReportEditor.FontNameCBChange(Sender: TObject);
begin
  if (Editor.SelectionList.Count > 0) and (Editor.SelectionList[0] is TQRPrintable) then
    with PrintableEditor do
    try
      Font.Name := FontNameCB.Text;
      try
        Font.Size := StrToInt(FontSizeCB.Text);
      except
        FontSizeCB.Text := IntToStr(Font.Size);
      end;
    finally
      Free;
    end;
end;

function TQReportEditor.GetFormEditor: TQRCustomEditor;
begin
  Result := Editor;
end;

procedure RegisterEditorControl(APrintableClass : TQRPrintableClass);
begin
  EditorClassList.Add(APrintableClass);
  RegisterClass(APrintableClass);
end;

procedure TQReportEditor.ControlValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then BtnClick(ControlOkBtn);
end;

constructor TQREditor.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  QReportEditorForm := TQReportEditor.Create(nil);
  Width := 660;
  Height := 300;
end;

destructor TQREditor.Destroy;
begin
  ShowMenu := false;
  QReportEditorForm.MainPanel.Parent := QReportEditorForm;
  QREportEditorForm.Free;
  inherited Destroy;
end;

procedure TQREditor.Copy;
begin
  QReportEditorForm.Copy;
end;

procedure TQREditor.Cut;
begin
  QReportEditorForm.Cut;
end;

function TQREditor.GetShowStatusLine: boolean;
begin
  Result := QReportEditorForm.StatusBar.Visible;
end;

procedure TQREditor.NewReport;
begin
  QReportEditorForm.NewReport;
end;

procedure TQREditor.OpenReport;
begin
  QReportEditorForm.OpenReport;
end;

procedure TQREditor.Paste;
begin
  QReportEditorForm.Paste;
end;

procedure TQREditor.PreviewReport;
begin
  QReportEditorForm.PreviewReport;
end;

procedure TQREditor.PrintReport;
begin
  QReportEditorForm.PrintReport;
end;

procedure TQREditor.ReportSettings;
begin
  QReportEditorForm.ReportSettings;
end;

procedure TQREditor.SaveReport;
begin
  QReportEditorForm.SaveReport;
end;

procedure TQREditor.SaveReportAs;
begin
  QReportEditorForm.SaveReportAs;
end;

procedure TQREditor.SelectData;
begin
  QReportEditorForm.SelectData;
end;

procedure TQREditor.SetFilename(const Value: string);
begin
  QReportEditorForm.Filename := value;
end;

function TQREditor.GetFilename : string;
begin
  Result := QReportEditorForm.Filename;
end;

procedure TQREditor.SetParent(AControl : TWinControl);
begin
  inherited SetParent(AControl);
  if (not (csDestroying in ComponentState)) and (AControl <> nil) then
  begin
    QReportEditorForm.MainPanel.Parent := Self;
    QReportEditorForm.DesignTime := (csDesigning in ComponentState);
    if QReportEditorForm.Owner = nil then
      Self.InsertComponent(QReportEditorForm);
  end;

end;

procedure TQREditor.SetShowMenu(Value: boolean);
begin
  FShowMenu := Value;
  if not ((csCreating in ControlState) or (csReading in ComponentState)) then
    if (Owner is TCustomForm) then
    begin
      if ShowMenu then
      begin
        QReportEditorForm.Menu := nil;
        TCustomForm(Owner).Menu := QReportEditorForm.QREMainMenu
      end else
        if TCustomForm(Owner).Menu = QReportEditorForm.QREMainMenu then
          TCustomForm(Owner).Menu := nil;
    end;
end;

procedure TQREditor.SetShowStatusLine(Value: boolean);
begin
  QReportEditorForm.StatusBar.Visible := Value;
end;

function TQREditor.GetReportEditor: TQReportEditor;
begin
  Result := QReportEditorForm;
end;

procedure TQREditor.Show;
begin
  Visible := true;
end;

procedure TQREditor.ShowEditor;
begin
  Visible := true;
end;

procedure TQREditor.OpenReportFile(AFilename : string);
var
   I : integer;
   ADS : TDatasource;
begin
   ADS := nil;
   with QReportEditorForm do
   begin
     FormEditor.Load(AFilename);
     Filename := AFilename;

     if FormEditor.MainControl is TQuickRep then
     begin
       for I := 0 to FormEditor.MainControl.ComponentCount - 1 do
         if FormEditor.MainControl.Components[I] is TDataSource then
           ADS := TDataSource(FormEditor.MainControl.Components[I]);
       for I := 0 to FormEditor.MainControl.ControlCount - 1 do
         if FormEditor.MainControl.Controls[I] is TQRSubDetail then
           TTable(TQRSubDetail(FormEditor.MainControl.Controls[I]).DataSet).MasterSource := ADS;
     end;
     EnableAndDisable;
   end;
end;

initialization
  EditorClassList := TList.Create;
  RegisterEditorControl(TQRLabel);
  RegisterEditorControl(TQRExpr);
{$ifdef QREDIT}
  RegisterEditorControl(TQRImage);
{$endif}
  RegisterQRWizard(TQRPlainWizard);
  RegisterQRWizard(TQRListWizard);
//  RegisterClass(TQRSubDetail);
  RegisterClass(TTable);
  RegisterClass(TQuery);
  RegisterClass(TDatasource);

finalization
  while EditorClassList.Count > 0 do
    EditorClassList.Delete(0);
  EditorClassList.Free;
end.
