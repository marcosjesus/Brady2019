{*************************}
{* Realsoft Include File *}
{*************************}

{$DEFINE _DEMO}
{$DEFINE LOCATOR}

{$IFNDEF VER80}
 {$IFNDEF VER90}
  {$IFNDEF VER93}
    {$DEFINE D3}         {Delphi 3.0 or higher}
  {$ENDIF}
 {$ENDIF}
{$ENDIF}

{$IFNDEF VER80}
 {$IFNDEF VER90}
  {$IFNDEF VER93}
    {$IFNDEF VER100}
      {$DEFINE D4}         {Delphi 4.0 or higher}
    {$ENDIF}
   {$ENDIF}
  {$ENDIF}
{$ENDIF}
