program InovarAuto;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  uInovarAuto in 'uInovarAuto.pas' {GridForm},
  uConexao in 'uConexao.pas' {ConfiguracaoForm},
  uDataModule in 'uDataModule.pas' {dInovarAuto: TDataModule},
  uCliente in 'uCliente.pas' {ClienteForm},
  uGerarXML in 'uGerarXML.pas' {GerarXMLForm},
  uImportaNF in 'uImportaNF.pas' {ImportaNF};

{$R *.res}

begin
  Application.Initialize;
  Application.UseMetropolisUI;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Metropolis UI Blue');
  Application.Title := 'Metropolis UI Application';
  Application.CreateForm(TGridForm, GridForm);
  Application.CreateForm(TConfiguracaoForm, ConfiguracaoForm);
  Application.CreateForm(TdInovarAuto, dInovarAuto);
  Application.CreateForm(TClienteForm, ClienteForm);
  Application.CreateForm(TGerarXMLForm, GerarXMLForm);
  Application.CreateForm(TImportaNF, ImportaNF);
  Application.Run;
end.
