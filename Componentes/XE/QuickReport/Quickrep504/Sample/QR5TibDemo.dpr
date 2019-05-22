program QR5TibDemo;

uses
  {fastMM4,}
  Forms,
  main in 'main.pas' {Form1},
  unireport in 'unireport.pas' {Unirep},
  repunit in 'repunit.pas' {Reportfrm},
  biotest in 'biotest.pas' {Biorep};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TUnirep, Unirep);
  Application.CreateForm(TReportfrm, Reportfrm);
  Application.CreateForm(TBiorep, Biorep);
  Application.Run;
end.
