{$IFDEF WIN32}
  {$H+}
{$ENDIF}

unit csProp;
{
 //--------------------------------------------------------------------
 // Property access routines.
 // Contributed to public domain by Ken Revak Catalyst Systems.
 //
 // some minor modifications and 2 additional routines by Timo Hartmann
 //--------------------------------------------------------------------
}

interface
uses
  Classes, Graphics;

function PropertyExists(Component : TComponent; const PropName : string) : boolean;
procedure SetPointerProperty(Component : TComponent;const PropName : String; ptr : Pointer);
function  GetPointerProperty(Component : TComponent;const PropName :String) : Pointer;
procedure SetBooleanProperty(Component : TComponent;const PropName : String; B : Boolean);
function GetBooleanProperty(Component : TComponent;const PropName :String) : Boolean;
procedure SetStringProperty(Component : TComponent;const PropName : String; Value : String);
function GetStringProperty(Component : TComponent;const PropName :String) : string;
procedure SetMethodProperty(Component : TComponent;const PropName : string; Code, Data : Pointer);
function GetFontProperty(Component : TComponent) : TFont;
function GetIntegerProperty(Component : TComponent; const PropName :String) : Longint;
procedure SetIntegerProperty(Component : TComponent; const PropName : String; L: Longint);
function GetFloatProperty(Component : TComponent; const PropName :String) : Extended;
procedure SetFloatProperty(Component : TComponent; const PropName : String; Value: Extended);

implementation
uses                 
  TypInfo, SysUtils;

function PropertyExists(Component : TComponent; const PropName : string) : boolean;
begin
   Result:=GetPropInfo(Component.ClassInfo, PropName) <> nil;
end;

procedure SetPointerProperty(Component : TComponent; const PropName : String; ptr : Pointer);
var
   ptrPropInfo : PPropInfo;
begin
   ptrPropInfo := GetPropInfo(Component.ClassInfo, PropName);
   if ptrPropInfo <> nil
      then SetOrdProp(Component, ptrPropInfo, LongInt(ptr));
end;

function GetPointerProperty(Component : TComponent; const PropName :String) : Pointer;
var
   ptrPropInfo : PPropInfo;
begin
   ptrPropInfo := GetPropInfo(Component.ClassInfo, PropName);
   if ptrPropInfo = nil
      then Result := nil
      else Result := Pointer(GetOrdProp(Component, ptrPropInfo));
end;

procedure SetBooleanProperty(Component : TComponent; const PropName : String; B : Boolean);
var
   ptrPropInfo : PPropInfo;
begin
   ptrPropInfo := GetPropInfo(Component.ClassInfo, PropName);
   if ptrPropInfo <> nil
      then SetOrdProp(Component, ptrPropInfo, LongInt(B));
end;

function GetBooleanProperty(Component : TComponent; const PropName :String) : Boolean;
var
   ptrPropInfo : PPropInfo;
begin
   ptrPropInfo := GetPropInfo(Component.ClassInfo, PropName);
   if ptrPropInfo = nil
      then Result := False
      else Result := GetOrdProp(Component, ptrPropInfo) = 1;
end;

procedure SetIntegerProperty(Component : TComponent; const PropName : String; L: Longint);
var
   ptrPropInfo : PPropInfo;
begin
   ptrPropInfo := GetPropInfo(Component.ClassInfo, PropName);
   if ptrPropInfo <> nil
      then SetOrdProp(Component, ptrPropInfo, L);
end;

function GetIntegerProperty(Component : TComponent; const PropName :String) : Longint;
var
   ptrPropInfo : PPropInfo;
begin
   ptrPropInfo := GetPropInfo(Component.ClassInfo, PropName);
   if ptrPropInfo = nil
      then Result := 0
      else Result := GetOrdProp(Component, ptrPropInfo);
end;

procedure SetFloatProperty(Component : TComponent; const PropName : String; Value : Extended);
var
   ptrPropInfo : PPropInfo;
begin
   ptrPropInfo := GetPropInfo(Component.ClassInfo, PropName);
   if ptrPropInfo <> nil
      then SetFloatProp(Component, ptrPropInfo, Value);
end;

function GetFloatProperty(Component : TComponent;const PropName :String) : Extended;
var
   ptrPropInfo : PPropInfo;
begin
   ptrPropInfo := GetPropInfo(Component.ClassInfo, PropName);
   if ptrPropInfo = nil
      then Result := 0
      else Result := GetFloatProp(Component, ptrPropInfo);
end;


procedure SetStringProperty(Component : TComponent; const PropName : String; Value : string);
var
   ptrPropInfo : PPropInfo;
begin
   ptrPropInfo := GetPropInfo(Component.ClassInfo, PropName);
   if ptrPropInfo <> nil
      then SetStrProp(Component, ptrPropInfo, Value);
end;

function GetStringProperty(Component : TComponent;const PropName :String) : string;
var
   ptrPropInfo : PPropInfo;
begin
   ptrPropInfo := GetPropInfo(Component.ClassInfo, PropName);
   if ptrPropInfo = nil
      then Result := ''
      else Result := GetStrProp(Component, ptrPropInfo);
end;

procedure SetMethodProperty(Component : TComponent;const PropName : string; Code, Data : Pointer);
var
   Method : TMethod;
   ptrPropInfo : PPropInfo;
begin
   ptrPropInfo := GetPropInfo(Component.ClassInfo, PropName);
   if ptrPropInfo <> nil then begin
      Method.Code := Code;
      Method.Data := Data;
      SetMethodProp(Component, ptrPropInfo, Method);
   end;
end;

function GetFontProperty(Component : TComponent) : TFont;
begin
   Result := TFont(GetPointerProperty(Component, 'Font'));
end;

end.
