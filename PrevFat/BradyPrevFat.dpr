program BradyPrevFat;

uses
  Vcl.Forms,
  uFrm_PrevFat in 'uFrm_PrevFat.pas' {Frm_Previsao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrm_Previsao, Frm_Previsao);
  Application.Run;
end.
