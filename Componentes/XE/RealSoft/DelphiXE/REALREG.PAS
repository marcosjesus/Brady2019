unit realreg;

interface

{$I REALSOFT.INC}

procedure Register;

implementation

{$IFDEF WIN32}
{$R realreg.r32}
{$ELSE}
{$R realreg.r16}
{$ENDIF}

uses
  rsFlyovr,
  rsEdit,
  rsEditDB,
  rsMemo;

procedure Register;
begin
  rsFlyovr.	register;
  rsEdit.	register;
  rsEditDB.	register;
  rsMemo.	register;
end;

end.
