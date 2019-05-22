{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 4.0 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRPrnSu.pas - QuickReport Printer setup dialog          ::
  :: This unit is mostly an extract from the Dialogs.pas     ::
  :: unit in the VCL.                                        ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: Portions Copyright (c) 1995,2001 Borland International  ::
  ::                                                         ::
  :: web: http://www.qusoft.com                              ::
  :: 6/1/2004 add new printer dialog properties              ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

unit QRPrnSu;

{$R-}
{$I qrdefs.inc}

interface

uses Windows, Messages, SysUtils, CommDlg, Classes, Graphics, Controls,
  Forms, StdCtrls, Dialogs, Printers;

const
  MaxCustomColors = 16;

type
  TQRCommonDialog = class(TComponent)
  private
    FCtl3D: Boolean;
    FDefWndProc: Pointer;
    FHelpContext: THelpContext;
    FHandle: HWnd;
    FObjectInstance: Pointer;
    FTemplate: PChar;
    FOnClose: TNotifyEvent;
    FOnShow: TNotifyEvent;
    procedure WMDestroy(var Message: TWMDestroy); message WM_DESTROY;
    procedure WMInitDialog(var Message: TWMInitDialog); message WM_INITDIALOG;
    procedure WMNCDestroy(var Message: TWMNCDestroy); message WM_NCDESTROY;
  protected
    procedure WndProc(var Message: TMessage); virtual;
    function MessageHook(var Msg: TMessage): Boolean; virtual;
    function TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool; virtual;
    procedure DoClose; dynamic;
    procedure DoShow; dynamic;
    function Execute: Boolean; virtual; abstract;
    property Template: PChar read FTemplate write FTemplate;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DefaultHandler(var Message); override;
    property Handle: HWnd read FHandle;
  published
    property Ctl3D: Boolean read FCtl3D write FCtl3D default True;
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
  end;

{ TQRPrinterSetupDialog }

  TQRBasePrintDialog = class(TQRCommonDialog)
  private
    FPrinter : TPrinter;
  protected
    Device, Driver, Port: array[0..79] of char;
    function CopyData(Handle: THandle): THandle;
    procedure SetPrinter(DeviceMode, DeviceNames: THandle);
    procedure GetPrinter(var DeviceMode, DeviceNames: THandle);
  public
    constructor Create(AOwner : TComponent); override;
    property Printer : TPrinter read FPrinter write FPrinter;
  end;

  TQRPrinterSetupDialog = class(TQRBasePrintDialog)
  public
    function Execute: Boolean; override;
  end;

  TQRPrintDialog = class(TQRBasePrintDialog)
  private
    FFromPage: Integer;
    FToPage: Integer;
    FCollate: Integer;
    FOptions: TPrintDialogOptions;
    FPrintToFile: Boolean;
    FPrintRange: TPrintRange;
    FMinPage: Integer;
    FMaxPage: Integer;
    FCopies: Integer;
    FPrintQuality: Integer;
    FColorOption: Integer;
    FOutputBin: Integer;
    FPaperSize: Integer;
    FDuplex : boolean;
    FPaperwidth : extended;
    FPaperlength : extended;
    FdmFields : Cardinal;
    FOrientation : Smallint;
    FDuplexCode : integer;
    procedure SetNumCopies(Value: Integer);
  public
    function Execute: Boolean; override;
  published
    property Duplex : boolean read FDuplex write FDuplex default false;
    property DuplexCode : Integer read FDuplexCode write FDuplexCode default 0;
    property OutputBin: Integer read FOutputBin write FOutputBin default 0;
    property PaperSize: Integer read FPaperSize write FPaperSize default 0;
    property Paperwidth : extended read FPaperwidth write FPaperwidth;
    property Paperlength : extended read FPaperlength write FPaperlength;
    property Collate: integer read FCollate write FCollate default 0;
    property Copies: Integer read FCopies write SetNumCopies default 1;
    property FromPage: Integer read FFromPage write FFromPage default 0;
    property PrintQuality: Integer read FPrintQuality write FPrintQuality default 0;
    property ColorOption: Integer read FColorOption write FColorOption default 0;
    property MinPage: Integer read FMinPage write FMinPage default 0;
    property MaxPage: Integer read FMaxPage write FMaxPage default 0;
    property Options: TPrintDialogOptions read FOptions write FOptions default [];
    property PrintToFile: Boolean read FPrintToFile write FPrintToFile default False;
    property PrintRange: TPrintRange read FPrintRange write FPrintRange default prAllPages;
    property ToPage: Integer read FToPage write FToPage default 0;
    property Orientation: smallint read FOrientation write FOrientation default 1;
  end;

implementation

uses ExtCtrls, Consts, Dlgs;

var
  CreationControl: TQRCommonDialog = nil;
  HelpMsg: Cardinal;
  FindMsg: Cardinal;
  WndProcPtrAtom: TAtom = 0;
  HookCtl3D: Boolean;

procedure CenterWindow(Wnd: HWnd);
var
  Rect: TRect;
begin
  GetWindowRect(Wnd, Rect);
  SetWindowPos(Wnd, 0,
    (GetSystemMetrics(SM_CXSCREEN) - Rect.Right + Rect.Left) div 2,
    (GetSystemMetrics(SM_CYSCREEN) - Rect.Bottom + Rect.Top) div 3,
    0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;

function DialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  Result := 0;
  case Msg of
    WM_INITDIALOG:
      begin
        if HookCtl3D then
        begin
{$ifndef VER36}
          Subclass3DDlg(Wnd, CTL3D_ALL);
          SetAutoSubClass(True);
{$endif}
        end;
        CenterWindow(Wnd);
        CreationControl.FHandle := Wnd;
        CreationControl.FDefWndProc := Pointer(SetWindowLong(Wnd, GWL_WNDPROC,
          Longint(CreationControl.FObjectInstance)));
        CallWindowProc(CreationControl.FObjectInstance, Wnd, Msg, WParam, LParam);
        CreationControl := nil;
      end;
    WM_DESTROY:
      if HookCtl3D then
      {$ifndef VER36}SetAutoSubClass(False){$endif};
  end;
end;

{ TQRCommonDialog }

constructor TQRCommonDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCtl3D := True;
  FObjectInstance := MakeObjectInstance(WndProc);
end;

destructor TQRCommonDialog.Destroy;
begin
  if FObjectInstance <> nil then FreeObjectInstance(FObjectInstance);
  inherited Destroy;
end;

function TQRCommonDialog.MessageHook(var Msg: TMessage): Boolean;
begin
  Result := False;
  if (Msg.Msg = HelpMsg) and (FHelpContext <> 0) then
  begin
    Application.HelpContext(FHelpContext);
    Result := True;
  end;
end;

procedure TQRCommonDialog.DefaultHandler(var Message);
begin
  if FHandle <> 0 then
    with TMessage(Message) do
      Result := CallWindowProc(FDefWndProc, FHandle, Msg, WParam, LParam)
  else inherited DefaultHandler(Message);
end;

procedure TQRCommonDialog.WndProc(var Message: TMessage);
begin
  Dispatch(Message);
end;

procedure TQRCommonDialog.WMDestroy(var Message: TWMDestroy);
begin
  inherited;
  DoClose;
end;

procedure TQRCommonDialog.WMInitDialog(var Message: TWMInitDialog);
begin
  DoShow;
  Message.Result := 0;
end;

procedure TQRCommonDialog.WMNCDestroy(var Message: TWMNCDestroy);
begin
  inherited;
  FHandle := 0;
end;

function TQRCommonDialog.TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool;
type
  TDialogFunc = function(var DialogData): Bool stdcall;
var
  ActiveWindow: HWnd;
  WindowList: Pointer;
begin
  ActiveWindow := GetActiveWindow;
  WindowList := DisableTaskWindows(0);
  try
    Application.HookMainWindow(MessageHook);
    try
      CreationControl := Self;
      Result := TDialogFunc(DialogFunc)(DialogData);
    finally
      Application.UnhookMainWindow(MessageHook);
    end;
  finally
    EnableTaskWindows(WindowList);
    SetActiveWindow(ActiveWindow);
  end;
end;

procedure TQRCommonDialog.DoClose;
begin
  if Assigned(FOnClose) then FOnClose(Self);
end;

procedure TQRCommonDialog.DoShow;
begin
  if Assigned(FOnShow) then FOnShow(Self);
end;

{ TQRBasePrintDialog }

procedure TQRBasePrintDialog.GetPrinter(var DeviceMode, DeviceNames: THandle);
var
  DevNames: PDevNames;
  Offset: PChar;
begin
  FPrinter.GetPrinter(Device, Driver, Port, DeviceMode);
  if DeviceMode <> 0 then
  begin
    DeviceNames := GlobalAlloc(GHND, SizeOf(TDevNames) +
     StrLen(Device) + StrLen(Driver) + StrLen(Port) + 3);
    DevNames := PDevNames(GlobalLock(DeviceNames));
    try
      Offset := PChar(DevNames) + SizeOf(TDevnames);
      with DevNames^ do
      begin
        wDriverOffset := Longint(Offset) - Longint(DevNames);
        Offset := StrECopy(Offset, Driver) + 1;
        wDeviceOffset := Longint(Offset) - Longint(DevNames);
        Offset := StrECopy(Offset, Device) + 1;
        wOutputOffset := Longint(Offset) - Longint(DevNames);;
        StrCopy(Offset, Port);
      end;
    finally
      GlobalUnlock(DeviceNames);
    end;
  end;
end;

procedure TQRBasePrintDialog.SetPrinter(DeviceMode, DeviceNames: THandle);
var
  DevNames: PDevNames;
begin
  DevNames := PDevNames(GlobalLock(DeviceNames));
  try
    with DevNames^ do
      if Win32Platform = VER_PLATFORM_WIN32_NT then
        FPrinter.SetPrinter(PChar(DevNames) + wDeviceOffset, Driver, Port, DeviceMode)
      else
        FPrinter.SetPrinter(PChar(DevNames) + wDeviceOffset, Driver, PChar(DevNames) + wOutputOffset, DeviceMode);
  finally
    GlobalUnlock(DeviceNames);
    GlobalFree(DeviceNames);
  end;
end;

function TQRBasePrintDialog.CopyData(Handle: THandle): THandle;
var
  Src, Dest: PChar;
  Size: Integer;
begin
  if Handle <> 0 then
  begin
    Size := GlobalSize(Handle);
    Result := GlobalAlloc(GHND, Size);
    if Result <> 0 then
      try
        Src := GlobalLock(Handle);
        Dest := GlobalLock(Result);
        if (Src <> nil) and (Dest <> nil) then Move(Src^, Dest^, Size);
      finally
        GlobalUnlock(Handle);
        GlobalUnlock(Result);
      end
  end
  else Result := 0;
end;

constructor TQRBasePrintDialog.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FPrinter := Printers.Printer;
end;

{ TQRPrinterSetupDialog }

function TQRPrinterSetupDialog.Execute: Boolean;
var
  PrintDlgRec: TPrintDlg;
  DevHandle: THandle;
begin
  FillChar(PrintDlgRec, SizeOf(PrintDlgRec), 0);
  with PrintDlgRec do
  begin
    lStructSize := SizeOf(PrintDlgRec);
    hInstance := SysInit.HInstance;
    GetPrinter(DevHandle, hDevNames);
    hDevMode := CopyData(DevHandle);
    Flags := PD_ENABLESETUPHOOK or PD_PRINTSETUP;
    HookCtl3D := Ctl3D;
    lpfnSetupHook := DialogHook;
    hWndOwner := Application.Handle;
    Result := TaskModalDialog(@PrintDlg, PrintDlgRec);
    if Result then
      SetPrinter(hDevMode, hDevNames)
    else begin
      if hDevMode <> 0 then GlobalFree(hDevMode);
      if hDevNames <> 0 then GlobalFree(hDevNames);
    end;
  end;
end;

{ TQRPrintDialog }

procedure TQRPrintDialog.SetNumCopies(Value: Integer);
begin
  FCopies := Value;
  FPrinter.Copies := Value;
end;

function TQRPrintDialog.Execute: Boolean;
const
  PrintRanges: array[TPrintRange] of Integer =
    (PD_ALLPAGES, PD_SELECTION, PD_PAGENUMS);
var
  PrintDlgRec: TPrintDlg;
  DevHandle: THandle;
  pDevMode: PDeviceMode;
begin
  FillChar(PrintDlgRec, SizeOf(PrintDlgRec), 0);
  with PrintDlgRec do
  begin
    lStructSize := SizeOf(PrintDlgRec);
    hInstance := SysInit.HInstance;
    GetPrinter(DevHandle, hDevNames);
    hDevMode := CopyData(DevHandle);
    Flags := PrintRanges[FPrintRange] or (PD_ENABLEPRINTHOOK or
      PD_ENABLESETUPHOOK);
    if FCollate<>0 then Inc(Flags, PD_COLLATE);
    if not (poPrintToFile in FOptions) then Inc(Flags, PD_HIDEPRINTTOFILE);
    if not (poPageNums in FOptions) then Inc(Flags, PD_NOPAGENUMS);
    if not (poSelection in FOptions) then Inc(Flags, PD_NOSELECTION);
    if poDisablePrintToFile in FOptions then Inc(Flags, PD_DISABLEPRINTTOFILE);
    if FPrintToFile then Inc(Flags, PD_PRINTTOFILE);
    if poHelp in FOptions then Inc(Flags, PD_SHOWHELP);
    if not (poWarning in FOptions) then Inc(Flags, PD_NOWARNING);
    nFromPage := FFromPage;
    nToPage := FToPage;
    nMinPage := FMinPage;
    nMaxPage := FMaxPage;
    HookCtl3D := Ctl3D;
    lpfnPrintHook := DialogHook;
    lpfnSetupHook := DialogHook;
    hWndOwner := Application.Handle;
    Result := TaskModalDialog(@PrintDlg, PrintDlgRec);
    if Result then
    begin
      SetPrinter(hDevMode, hDevNames);
      FPrintToFile := Flags and PD_PRINTTOFILE <> 0;
      if Flags and PD_SELECTION <> 0 then FPrintRange := prSelection
      else
        if Flags and PD_PAGENUMS <> 0 then FPrintRange := prPageNums
      else
          FPrintRange := prAllPages;
      FFromPage := nFromPage;
      FToPage := nToPage;
      if nCopies = 1 then
        Copies := FPrinter.Copies
      else
        Copies := nCopies;
      pDevMode := GlobalLock(hDevmode);
      FdmFields := TDeviceMode(pDevmode^).dmFields;
      FOutputBin := TDeviceMode(pDevmode^).dmDefaultSource;
      FpaperSize := TDeviceMode(pDevmode^).dmpaperSize;
      FPaperwidth := TDeviceMode(pDevmode^).dmpaperWidth;
      FPaperlength := TDeviceMode(pDevmode^).dmpaperLength;
      FOrientation := TDeviceMode(pDevmode^).dmOrientation;
      FPrintquality := TDeviceMode(pDevmode^).dmPrintquality;
      FColorOption := TDeviceMode(pDevmode^).dmColor;
      FDuplexCode :=  TDeviceMode(pDevmode^).dmDuplex;
      FDuplex :=  TDeviceMode(pDevmode^).dmDuplex <> 1;
      FCollate := TDeviceMode(pDevmode^).dmCollate;
      FOrientation := TDeviceMode(pDevmode^).dmOrientation;
    end
    else
    begin
      if hDevMode <> 0 then GlobalFree(hDevMode);
      if hDevNames <> 0 then GlobalFree(hDevNames);
    end;
  end;
end;

{ Initialization and cleanup }

procedure InitGlobals;
var
  AtomText: array[0..31] of Char;
begin
  HelpMsg := RegisterWindowMessage(HelpMsgString);
  FindMsg := RegisterWindowMessage(FindMsgString);
  WndProcPtrAtom := GlobalAddAtom(StrFmt(AtomText,
    'WndProcPtr%.8X%.8X', [HInstance, GetCurrentThreadID]));
end;

initialization
  InitGlobals;
finalization
  if WndProcPtrAtom <> 0 then GlobalDeleteAtom(WndProcPtrAtom);
end.
