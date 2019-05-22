{$I QRPP.INC}

unit SupComps;

interface

uses
  Classes, StdCtrls, Forms, Messages, ExtCtrls, Controls,

  QuickRpt,  { if you get a compiler error "File not found: 'qrprnsu.dcu'",
               please go to the QRDesign directory and rename QRPRNSU.P to
               QRPRNSU.PAS !!}

  {$IFDEF WIN32}
  Windows,
  {$ELSE}
  WinProcs, WinTypes,
  {$ENDIF}
  Graphics;

type
  TEnhancedListbox = class(TListbox)
  private
    FOnChange : TNotifyEvent;
    FLastSel : integer;
  protected
    procedure Change; Virtual;
    procedure Click; override;
  public
    constructor Create(AOwner : TComponent); override;
    procedure MoveUp;
    procedure MoveDown;
    procedure MoveItems(DestIndex: Integer);
    procedure MoveItemsRelative(R: Integer);
    procedure MoveFromListbox(Source: TListbox; DestIndex: Integer);
    procedure CopyFromListbox(Source: TListbox; DestIndex: Integer);
  published
    property OnChange : TNotifyEvent Read FOnChange Write FOnChange;
  end;

  TEventScrollbox = class(TScrollBox)
  private
    fOnScrollHorz     : TNotifyEvent;
    fOnScrollVert     : TNotifyEvent;
    {$IFDEF VER130}
    fWheelMousePixels : Integer;
    {$ENDIF}
    procedure WMHScroll(var Msg: TWMHScroll); message wm_HScroll;
    procedure WMVScroll(var Msg: TWMHScroll); message wm_VScroll;
  protected
    {$IFDEF VER130}
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    {$IFDEF VER130}
    procedure AutoScrollInView(AControl: TControl); override;
    {$ENDIF}
  published
    {$IFDEF VER130}
    property WheelMousePixels: Integer Read FWheelMousePixels Write FWheelMousePixels;
    {$ENDIF}
    property OnScrollHorz: TNotifyEvent read fOnScrollHorz write fOnScrollHorz;
    property OnScrollVert: TNotifyEvent read fOnScrollVert write fOnScrollVert;
  end;

  TRulerPanel = class(TPanel)
  private
    fMajorColor : TColor;
    fMinorColor : TColor;
    fMajorStyle : TPenStyle;
    fMinorStyle : TPenStyle;
    fQReport    : TQuickRep;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property MajorColor: TColor Read fMajorColor Write FMajorColor;
    property MajorStyle: TPenStyle Read fMajorStyle Write FMajorStyle;
    property MinorColor: TColor Read fMinorColor Write fMinorColor;
    property MinorStyle: TPenStyle Read fMinorStyle Write fMinorStyle;
    property QReport: TQuickrep Read fQReport Write fQReport;
  end;

implementation

uses
  SysUtils;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

procedure TEnhancedListBox.Change;
begin
  FLastSel := ItemIndex;
  If Assigned(FOnChange) Then FOnChange(Self);
end;

{--------------------------------------------------------------------------------}

procedure TEnhancedListBox.Click;
begin
  Inherited Click;
  If FLastSel <> ItemIndex Then Change;
end;

{--------------------------------------------------------------------------------}

constructor TEnhancedListBox.Create;
begin
  Inherited Create(AOwner);
  FLastSel := -1;
end;

{--------------------------------------------------------------------------------}

procedure TEnhancedListbox.MoveUp;
begin
  MoveItemsRelative(-1);
end;

{--------------------------------------------------------------------------------}

procedure TEnhancedListbox.MoveDown;
begin
  MoveItemsRelative(1);
end;

{--------------------------------------------------------------------------------}

procedure TEnhancedListbox.MoveItems(DestIndex: Integer);
var
  I: Integer;
  L: TStringList;
begin
  If MultiSelect Then
    begin
      L:=TStringlist.Create;
      For I:=Items.Count DownTo 1 Do
        If Selected[I-1] Then
          begin
            L.Add(Items[I-1]);
            Items.Delete(I-1);
          end;
      For I:=1 to L.Count Do
        begin
          Items.Insert(DestIndex,L[I-1]);
          Selected[DestIndex]:=True;
        end;
      L.Free;
    end
  else
    begin
      Items.Move(ItemIndex,DestIndex);
      ItemIndex:=DestIndex;
(*      Items.Insert(DestIndex,Items[ItemIndex]);
      I:=ItemIndex;
      ItemIndex:=DestIndex;
      Items.Delete(I);*)
    end;
end;

{--------------------------------------------------------------------------------}

procedure TEnhancedListbox.MoveItemsRelative(R: Integer);
var
  I: Integer;
begin
  If MultiSelect Then
    begin
      If R<0 Then
        begin
          For I:=1 to Items.Count Do
            If Selected[I-1] Then
              begin
                If I-1+R<0 Then Break;
                Items.Insert(I-1+R,Items[I-1]);
                Selected[I-1+R]:=True;
                Items.Delete(I);
              end;
        end
      else
        begin
          For I:=Items.Count DownTo 1 Do
            If Selected[I-1] Then
              begin
                If I+R>Items.Count Then Break;
                Items.Insert(I+R,Items[I-1]);
                Selected[I+R]:=True;
                Items.Delete(I-1);
              end;
        end;
    end
  else
    begin
      If (ItemIndex+R>=0) and (ItemIndex+R<Items.Count) Then
        begin
          I:=ItemIndex+R;
          Items.Move(ItemIndex,I); 
          ItemIndex:=I;
        end;
    end;
end;

{--------------------------------------------------------------------------------}

procedure TEnhancedListbox.CopyFromListbox(Source: TListbox; DestIndex: Integer);
var
  I: Integer;
begin
  If Source=Self Then Exit;
  If DestIndex=-1 Then DestIndex:=Items.Count;
  For I:=1 to Source.Items.Count Do
    begin
      If Source.Selected[I-1] Then
        begin
          Items.Insert(DestIndex,Source.Items[I-1]);
          Inc(DestIndex);
        end;
    end;
end;

{--------------------------------------------------------------------------------}

procedure TEnhancedListbox.MoveFromListbox(Source: TListbox; DestIndex: Integer);
var
  I: Integer;
begin
  If Source=Self Then Exit;
  CopyFromListbox(Source,DestIndex);
  For I:=Source.Items.Count DownTo 1 Do
    If Source.Selected[I-1] Then Source.Items.Delete(I-1);
end;

{----------------------------------------------------------------------}
{----------------------------------------------------------------------}

{$IFDEF VER130}

procedure TEventScrollbox.AutoScrollInView(AControl: TControl);
var
  Rect: TRect;
begin
  if (AControl = nil) or (csLoading in AControl.ComponentState) or
     (csLoading in ComponentState) then Exit;
  Rect := AControl.ClientRect;
  Dec(Rect.Left, HorzScrollBar.Margin);
  Inc(Rect.Right, HorzScrollBar.Margin);
  Dec(Rect.Top, VertScrollBar.Margin);
  Inc(Rect.Bottom, VertScrollBar.Margin);
  Rect.TopLeft := ScreenToClient(AControl.ClientToScreen(Rect.TopLeft));
  Rect.BottomRight := ScreenToClient(AControl.ClientToScreen(Rect.BottomRight));
  if (Rect.Right  < 10) or (Rect.Left > ClientWidth-10) or
     (Rect.Bottom < 10) or (Rect.Top  > ClientHeight-10) then
    Inherited AutoScrollInView(AControl);
end;

{$ENDIF}

constructor TEventScrollbox.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  {$IFDEF VER130}
  FWheelMousePixels:=38;
  {$ENDIF}
end;

{$IFDEF VER130}

function TEventScrollbox.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result:=Inherited DoMouseWheelDown(Shift, MousePos);
  If Not Result Then
    begin
      VertScrollbar.Position:=VertScrollbar.Position+FWheelMousePixels;
      Result:=True;
    end;
end;

function TEventScrollbox.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result:=Inherited DoMouseWheelUp(Shift, MousePos);
  If Not Result Then
    begin
      VertScrollbar.Position:=VertScrollbar.Position-FWheelMousePixels;
      Result:=True;
    end;
end;

{$ENDIF}

procedure TEventScrollbox.WMHScroll(var Msg: TWMHScroll);
Begin
  Inherited;
  If Assigned(fOnScrollHorz) Then fOnScrollHorz(Self);
End;

procedure TEventScrollbox.WMVScroll(var Msg: TWMVScroll);
Begin
  Inherited;
  If Assigned(fOnScrollVert) Then fOnScrollVert(Self);
End;

{--------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------}

constructor TRulerPanel.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  fMajorColor:=clBlack;
  fMinorColor:=clBlack;
  fMajorStyle:=psSolid;
  fMinorStyle:=psSolid;
  Height:=15;
  Font.Name := 'Small Fonts';
  Font.Size := 6;
  Font.Color := clBlack;
end;


procedure TRulerPanel.Paint;

procedure PaintRuler;
var
  TotalLines : integer;
  Resolution : integer;
  Factor : extended;
  PaintMinor : boolean;

  procedure PaintInches;
  var
    I : integer;
    Major : boolean;
  begin
    PaintMinor := QReport.Zoom > 49;
    with Canvas do
    begin
      Factor := Resolution / 4 * QReport.Zoom / 100;
      TotalLines := round(Width / Resolution / QReport.Zoom * 400);
      for i := 1 to TotalLines do
      begin
        if (i mod 4) = 0 then
        begin
          Pen.Color := fMajorColor;
          Pen.Style := fMajorStyle;
          Major := true;
        end else
        begin
          Pen.Color := fMinorColor;
          Pen.Style := fMinorStyle;
          Major := false;
        end;
        if PaintMinor or Major then
        begin
          If Major Then
            MoveTo(round(I * Factor), 2)
          Else
            MoveTo(round(I * Factor), height DIV 2);
          LineTo(round(I * Factor), height);
          if ((I mod 4) = 0) then TextOut(2 + round(I * Factor), 2, IntToStr(i div 4));
        end;
      end;
    end
  end;

  procedure PaintMM;
  var
    I : integer;
  begin
    PaintMinor := QReport.Zoom > 49;
    with Canvas do
    begin
      Factor := 5 / Resolution * 5.08 / QReport.Zoom * 100;
      TotalLines := round(Width * Factor);
      for I := 1 to TotalLines do
      begin
        if (I mod 10) = 0 then
          begin
            Pen.Color := fMajorColor;
            Pen.Style := fMajorStyle;
            TextOut(2 + round(I / Factor), 1, IntToStr(I div 10));
            MoveTo(round(I / Factor), 2);
            LineTo(round(I / Factor), Height);
          end
        else
        if (I mod 5) = 0 then
          begin
            Pen.Color := fMinorColor;
            Pen.Style := fMinorStyle;
            If QReport.Zoom>30 Then
              MoveTo(round(I / Factor), Height DIV 2)
            Else
              MoveTo(round(I / Factor), Height-4);
            LineTo(round(I / Factor), Height);
          end
        else
          begin
            If PaintMinor then
              begin
                Pen.Color := fMinorColor;
                Pen.Style := fMinorStyle;
                MoveTo(round(I / Factor), Height-4);
                LineTo(round(I / Factor), Height);
              end;
          end;
      end;
    end
  end;

  procedure PaintCharacters;

    function CharWidth(Size : integer):extended;
    begin
      result := 80 / Size / 2.54;
    end;

  var
     I : integer;
     FontSize: Integer;
  begin
    FontSize:=8;
    with Canvas do
    begin
      Pen.Style := psDot;
      TotalLines := round(Width / Resolution * 25.4 / CharWidth(FontSize) / 10);
      for I := 1 to TotalLines do
      begin
        MoveTo(round(I * CharWidth(FontSize) * Resolution / 2.54), 2);
        LineTo(Round(I * CharWidth(FontSize) * Resolution / 2.54), Height);
        TextOut(2 + round(I * CharWidth(FontSize) * Resolution / 2.54), 2, IntToStr(I * 10));
      end;
    end
  end;

begin
  with Canvas do
  begin
    Resolution := Screen.PixelsPerInch;
    Pen.Color := clSilver;
    Pen.Width := 1;
    if QReport.Units=Inches then
      PaintInches
    else
      if QReport.Units=MM then
        PaintMM
      else
        if QReport.Units=Characters then
          PaintCharacters;
    Pen.Style := psSolid;
  end
end;

begin
  Inherited Paint;
  If QReport<>NIL Then PaintRuler;
end;


end.
