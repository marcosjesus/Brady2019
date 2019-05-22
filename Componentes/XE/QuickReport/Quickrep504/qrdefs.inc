{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 4.0 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRDEFS.PAS - CONDITIONAL DEFINES, INCLUDED IN ALL FILES ::
  ::                                                         ::
  :: Copyright (c) 2001 A Lochert                            ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.qusoft.com                              ::
  ::                                                         ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }
{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}
{$define BDETABLES}

{$ifdef ver130}
{$define ver120}
{$endif}
{$IFDEF VER125}
{$DEFINE VER110}
{$ENDIF}
{$IFDEF VER120}
{$DEFINE VER110}
{$ENDIF}
//{$DEFINE VER110}
{$define VER36PRO}
{$define VER36}

