program Project1;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  DBConect in 'DBConect.pas' {DB_Conect: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDB_Conect, DB_Conect);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
