program Brady;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  ShellApi,
  Windows;

function FileVersion( sFileName: String ): String;
var
  VerInfoSize: Cardinal;
  VerValueSize: Cardinal;
  Dummy: Cardinal;
  PVerInfo: Pointer;
  PVerValue: PVSFixedFileInfo;
  FileName: TFileName;

begin

  Result := '';
  FileName := sFileName;
  VerInfoSize := GetFileVersionInfoSize(PChar(FileName), Dummy);
  GetMem(PVerInfo, VerInfoSize);
  try
    if GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, PVerInfo) then
      if VerQueryValue(PVerInfo, '\', Pointer(PVerValue), VerValueSize) then
        with PVerValue^ do
          Result := Format('v%d.%d.%d build %d', [
            HiWord(dwFileVersionMS), //Major
            LoWord(dwFileVersionMS), //Minor
            HiWord(dwFileVersionLS), //Release
            LoWord(dwFileVersionLS)]); //Build
  finally
    FreeMem(PVerInfo, VerInfoSize);
  end;

end;

begin

  try

    if not ParamStr(1).Equals('-carga_maquina') then
    begin

      Writeln( 'Abrindo BradyBrazil.exe (normal)' );
      ShellExecute(0, nil, '\\ghos2024\Brady\BradyBrazil.exe', '', nil, SW_HIDE);

    end
    else
    begin
      Writeln( 'Abrindo BradyBrazil.exe (carga maquina)' );
      try

        Writeln('BradyBrazil - Vers�o server: ' + FileVersion('S:\Carga_Maquina\BradyBrazil.exe'));
        Writeln('BradyBrazil - Vers�o client: ' + FileVersion('C:\Brady\BradyBrazil.exe'));

        if not FileVersion('S:\Carga_Maquina\BradyBrazil.exe').Equals( FileVersion('C:\Brady\BradyBrazil.exe') ) then
        begin

          Writeln('BradyBrazil - Atualizando Vers�o client.');
          CopyFile( 'S:\Carga_Maquina\BradyBrazil.exe', 'C:\Brady\BradyBrazil.exe', False );

        end;

      except
      end;

      Sleep(5000);

      Writeln('Executando C:\Brady\BradyBrazil.bat');
      ShellExecute(0, nil, 'C:\Brady\BradyBrazil.bat', '', nil, SW_HIDE);
      Sleep(5000);
    end;

  except

    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);

  end;

end.