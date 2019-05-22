program VideoCapDemo;

uses
  Forms,
  mainf in 'mainf.pas' {Main};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
