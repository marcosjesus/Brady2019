{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{             THE UNREGISTERED VERSION OF QRPP IS                        }
{             NOT AFFECTED BY CHANGES TO THIS FILE!                      }
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

{------------------------------------------------------------------------}
{--- Check for active compiler (do not change)                       ----}
{------------------------------------------------------------------------}
{-} {$IFDEF VER150} {$DEFINE VER140} {$DEFINE CK} {$ENDIF}  {Delphi 7} {-}
{-} {$IFDEF VER140} {$DEFINE VER135} {$DEFINE CK} {$ENDIF}  {Delphi 6} {-}
{-} {$IFDEF VER135} {$DEFINE VER130} {$DEFINE CK} {$ENDIF}  {   BCB 6} {-}
{-} {$IFDEF VER130} {$DEFINE VER120} {$DEFINE CK} {$ENDIF}  {D5+BCB 5} {-}
{-} {$IFDEF VER125} {$DEFINE VER120} {$DEFINE CK} {$ENDIF}  {   BCB 4} {-}
{-} {$IFDEF VER120} {$DEFINE VER110} {$DEFINE CK} {$ENDIF}  {Delphi 4} {-}
{-} {$IFDEF VER110} {$DEFINE VER100} {$DEFINE CK} {$ENDIF}  {   BCB 3} {-}
{-} {$IFDEF VER100}                  {$DEFINE CK} {$ENDIF}  {Delphi 3} {-}
{-} {$IFDEF VER90}  {$DEFINE VER80}  {$DEFINE CK} {$ENDIF}  {Delphi 2} {-}
{-} {$IFDEF VER93}                   {$DEFINE CK} {$ENDIF}  {   BCB 1} {-}
{-} {$IFDEF VER80}                   {$DEFINE CK} {$ENDIF}  {Delphi 1} {-}
{-}                                                                    {-}
{-} {$IFNDEF CK}  { if unknown compiler, assume D7 compatibility }     {-}
{-}   {$DEFINE VER150}  {$DEFINE VER140} {$DEFINE VER135}              {-}
{-}   {$DEFINE VER130}  {$DEFINE VER120} {$DEFINE VER100}              {-}
{-} {$ENDIF}                                                           {-}
{-} {$UNDEF CK}                                                        {-}
{------------------------------------------------------------------------}
{------------------------------------------------------------------------}

{------------------------------------------------------------------------}
{----- Quickreport 3 support                                        -----}
{------------------------------------------------------------------------}
{$DEFINE QR3}     { installed Quickreport version is Quickreport 3.x }
{$DEFINE QR36}    { installed Quickreport version is Quickreport 3.6.x }
{$DEFINE QR4}     { installed Quickreport version is Quickreport 4.x }

{.$DEFINE QREXPORTS2}   { use TQRPDFShape for grid report generation }

{------------------------------------------------------------------------}
{----- registered version of QRPP                                   -----}
{------------------------------------------------------------------------}
{$DEFINE REGISTERED}

{------------------------------------------------------------------------}

{$IFDEF VER140}
  {$WARN UNIT_PLATFORM OFF}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_DEPRECATED OFF}
  {$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}

{$IFDEF VER150}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CAST OFF}
{$ENDIF}

{$IFDEF QR4}
  {$DEFINE QR36}
{$ENDIF}

{$IFDEF QR36}
  {$DEFINE QR3}
{$ENDIF}
