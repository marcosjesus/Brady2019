unit uPrincipal;

interface

uses

  System.DateUtils,
  System.StrUtils,
  ShellAPI,
  dxSpreadSheet,
  dxSpreadSheetTypes,
  dxSpreadSheetCore,
  cxCurrencyEdit,
  uUtils,
  System.IOUtils,
  IniFiles,
  System.RegularExpressions,
  ComObj,
  Excel,
  Vcl.FileCtrl,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxPC, cxContainer, cxEdit, Vcl.StdCtrls, Vcl.Buttons,
  cxTextEdit, cxMaskEdit, cxButtonEdit, cxLabel, dxGDIPlusClasses, Vcl.ExtCtrls,
  cxGroupBox, Vcl.ComCtrls;

type
  TfrmPrincipal = class(TForm)
    Page: TcxPageControl;
    TabEtiqueta: TcxTabSheet;
    TabCadastro: TcxTabSheet;
    cxLabel9: TcxLabel;
    cxButtonEditPath: TcxButtonEdit;
    btnCriar: TBitBtn;
    SaveDialog: TSaveDialog;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    edtOutPut: TcxButtonEdit;
    btnSalvarINI: TBitBtn;
    rgTipo: TRadioGroup;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxGroupBox3: TcxGroupBox;
    cxGroupBox4: TcxGroupBox;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    edtCarroLinha: TcxMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtCarroInter: TcxMaskEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtMotoInter: TcxMaskEdit;
    Label5: TLabel;
    edtCaminhaoLinha: TcxMaskEdit;
    Label6: TLabel;
    edtCaminhaoInter: TcxMaskEdit;
    Label8: TLabel;
    edtOnibusLinha: TcxMaskEdit;
    Label9: TLabel;
    edtOnibusInter: TcxMaskEdit;
    edtURL: TEdit;
    lblUrl: TLabel;
    StatusBar: TStatusBar;
    edtMotoLinha: TcxMaskEdit;
    Label10: TLabel;
    edtCarroBase: TcxMaskEdit;
    Label11: TLabel;
    edtMotoBase: TcxMaskEdit;
    Label12: TLabel;
    edtCaminhaoBase: TcxMaskEdit;
    Label13: TLabel;
    edtOnibusBase: TcxMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarINIClick(Sender: TObject);
    procedure edtOutPutClick(Sender: TObject);
    procedure btnCriarClick(Sender: TObject);
    procedure cxButtonEditPathClick(Sender: TObject);
    procedure rgTipoClick(Sender: TObject);
    procedure edtCarroLinhaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageChange(Sender: TObject);

 Type TVeiculo = class
   Tipo : String;
   Etiqueta  : String;
   Linhas    : Integer;
   Intervalo : Integer;
   Base      : Integer;
 end;

  private
    { Private declarations }
    Veiculo : TVeiculo;
    dxSpreadSheet, dxSpreadSheetOut : TdxSpreadSheet;
    Mudou : Boolean;
    procedure Mensagem(pMensagem: String);
    procedure CarregaINI;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}


procedure TfrmPrincipal.Mensagem(pMensagem: String);
var
  I, X, Y, varAno, varMes : Integer;
  dxSpreadSheet: TdxSpreadSheet;

begin
  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;
end;



procedure TfrmPrincipal.PageChange(Sender: TObject);
begin
  rgTipoClick(Nil);
end;

procedure TfrmPrincipal.rgTipoClick(Sender: TObject);
begin
  if rgTipo.ItemIndex = 0 then
  begin
    Veiculo.Tipo      := 'Carro';
    Veiculo.Linhas    := StrToInt(edtCarroLinha.Text);
    Veiculo.Intervalo := StrToInt(edtCarroInter.Text);
    Veiculo.Base      := StrToInt(edtCarroBase.Text);
  end
  else if rgTipo.ItemIndex = 1 Then
  begin
    Veiculo.Tipo      := 'Moto';
    Veiculo.Linhas    := StrToInt(edtMotoLinha.Text);
    Veiculo.Intervalo := StrToInt(edtMotoInter.Text);
    Veiculo.Base      := StrToInt(edtMotoBase.Text);
  end
  else if rgTipo.ItemIndex = 2 then
  begin
    Veiculo.Tipo      := 'Caminhao';
    Veiculo.Linhas    := StrToInt(edtCaminhaoLinha.Text);
    Veiculo.Intervalo := StrToInt(edtCaminhaoInter.Text);
    Veiculo.Base      := StrToInt(edtCaminhaoBase.Text);
  end
  else
  begin
    Veiculo.Tipo      := 'Onibus';
    Veiculo.Linhas    := StrToInt(edtOnibusLinha.Text);
    Veiculo.Intervalo := StrToInt(edtOnibusInter.Text);
    Veiculo.Base      := StrToInt(edtOnibusBase.Text);
  end;
end;

procedure TfrmPrincipal.btnCriarClick(Sender: TObject);
var
 varContador, y, z, x, i ,  m: integer;
 varEtiqueta, varEtiquetaOut : String;
 bPrimeiro :Boolean;
begin
  if cxButtonEditPath.Text = EmptyStr then
    raise Exception.Create('Informe o arquivo primeiro.');


  DeleteFile ( edtOutPut.Text  + '\' + Veiculo.Tipo + '.xlsx' );

  Mensagem( 'Gerando as Linhas para Etiqueta...' );
  try

  dxSpreadSheetOut := TdxSpreadSheet.Create(nil);
  try

    dxSpreadSheetOut.LoadFromFile( MyDocumentsPath+'\Detran_Output.xlsx' );
    dxSpreadSheetOut.BeginUpdate;

    dxSpreadSheetOut.Sheets[0].Active := True;

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    try

      Mensagem( 'Carregando planilha...' );
      dxSpreadSheet.LoadFromFile( cxButtonEditPath.Text );
      dxSpreadSheet.BeginUpdate;

      Mensagem( 'Lendo linhas da planilha...' );
      varContador := 1;

      Y := 1;   // Linha do Excel
      for X := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
      begin

         try

            if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0]) then
              Exit;

            if dxSpreadSheet.ActiveSheetAsTable.Rows[X].CellCount < 5 then
              Continue;

            Mensagem( 'Linha (" ' + IntToStr(X) + '/' + IntToStr(dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex) + '") "' + Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString) + '" ...' );

            if Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString) = EmptyStr then
              Continue;

         except

            Continue;

         end;

         varEtiqueta := dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString;

         if (Veiculo.Tipo = 'Moto') then
         begin
             varContador :=  0;
             bPrimeiro   := True;
             for I := Veiculo.Linhas + Veiculo.Base downto 1  do  // 128
             begin

                if varContador = 0 then
                    varContador :=  Veiculo.Linhas + Veiculo.Base;


                for z := varContador-3 to varContador  do  // 128
                begin

                     if ((bPrimeiro) and ((z = 35) or (z = 36))) then
                     begin
                        varEtiquetaOut := varEtiqueta;
                        if z = 36 then
                          bPrimeiro      := False;
                     end
                     else
                        varEtiquetaOut := varEtiqueta + Format('%3.3d',[z]);

                     with dxSpreadSheetOut.ActiveSheetAsTable.CreateCell(Y,0) do
                     begin

                         AsVariant := varEtiquetaOut;
                     end;

                     with dxSpreadSheetOut.ActiveSheetAsTable.CreateCell(Y,1) do
                     begin

                         AsVariant := edtURL.Text  + varEtiquetaOut;
                     end;
                     Inc(Y);


                end;

                varContador := varContador - 4;

                if varContador <= 0 then
                   Break;
                

                if (varContador = 0)  then  // 128
                   Break;

             end;

         end
         else
         if Veiculo.Tipo = 'Carro' then
         begin
             varContador :=  0;
             bPrimeiro   := True;
             for I := Veiculo.Linhas + Veiculo.Base downto 1  do  // 128
             begin

                if varContador = 0 then
                    varContador :=  Veiculo.Linhas + Veiculo.Base;


                for z := varContador-3 to varContador  do  // 128
                begin

                     if ((bPrimeiro) and ((z = 50) or (z = 51)  or (z = 52) )) then
                     begin
                        varEtiquetaOut := varEtiqueta;
                        if z = 52 then
                          bPrimeiro      := False;
                     end
                     else
                        varEtiquetaOut := varEtiqueta + Format('%3.3d',[z]);

                     with dxSpreadSheetOut.ActiveSheetAsTable.CreateCell(Y,0) do
                     begin

                         AsVariant := varEtiquetaOut;
                     end;

                     with dxSpreadSheetOut.ActiveSheetAsTable.CreateCell(Y,1) do
                     begin

                         AsVariant := edtURL.Text  + varEtiquetaOut;
                     end;
                     Inc(Y);


                end;

                varContador := varContador - 4;

                if varContador <= 0 then
                   Break;


                if (varContador = 0)  then  // 128
                   Break;

             end;

         end
         else
         if Veiculo.Tipo = 'Caminhao' then
         begin
             varContador :=  0;
             bPrimeiro   := True;
             for I := Veiculo.Linhas + Veiculo.Base downto 1  do  // 128
             begin

                if varContador = 0 then
                   varContador :=  Veiculo.Linhas + Veiculo.Base;


                for z := varContador-3 to varContador  do  // 128
                begin

                     if ((bPrimeiro) and ((z = 125) or (z = 126))) then
                     begin
                        varEtiquetaOut := varEtiqueta;
                        if z = 126 then
                          bPrimeiro      := False;
                     end
                     else
                        varEtiquetaOut := varEtiqueta + Format('%3.3d',[z]);

                     with dxSpreadSheetOut.ActiveSheetAsTable.CreateCell(Y,0) do
                     begin

                         AsVariant := varEtiquetaOut;
                     end;

                     with dxSpreadSheetOut.ActiveSheetAsTable.CreateCell(Y,1) do
                     begin

                         AsVariant := edtURL.Text  + varEtiquetaOut;
                     end;


                     Inc(Y);


                end;

                varContador := varContador - 4;

                if varContador <= 63 then
                   Break;


             end;

             bPrimeiro   := True;
             varContador :=  0;
             for I := 64 downto 1  do  // 128
             begin

                if varContador = 0 then
                   varContador :=  64;


                for z := varContador-3 to varContador  do  // 128
                begin

                     if ((bPrimeiro) and ((z = 63) or (z = 64))) then
                     begin
                        varEtiquetaOut := varEtiqueta;
                        if z = 64 then
                          bPrimeiro      := False;
                     end
                     else
                        varEtiquetaOut := varEtiqueta + Format('%3.3d',[z]);

                     with dxSpreadSheetOut.ActiveSheetAsTable.CreateCell(Y,0) do
                     begin

                         AsVariant := varEtiquetaOut;
                     end;

                     with dxSpreadSheetOut.ActiveSheetAsTable.CreateCell(Y,1) do
                     begin

                         AsVariant := edtURL.Text  + varEtiquetaOut;
                     end;


                     Inc(Y);

                end;

                varContador := varContador - 4;

                if varContador <= 0 then
                   Break;


             end;


         end
         else
         if Veiculo.Tipo = 'Onibus' then
         begin

             varContador :=  0;
             bPrimeiro   := True;
             for I := Veiculo.Linhas + Veiculo.Base downto 1  do  // 128
             begin

                if varContador = 0 then
                   varContador :=  Veiculo.Linhas + Veiculo.Base;


                for z := varContador-3 to varContador  do  // 128
                begin

                     if ((bPrimeiro) and ((z = 113) or (z = 114) or (z = 115) or (z = 116) )) then
                     begin
                        varEtiquetaOut := varEtiqueta;
                        if z = 116 then
                          bPrimeiro      := False;
                     end
                     else
                        varEtiquetaOut := varEtiqueta + Format('%3.3d',[z]);

                     with dxSpreadSheetOut.ActiveSheetAsTable.CreateCell(Y,0) do
                     begin

                         AsVariant := varEtiquetaOut;
                     end;

                     with dxSpreadSheetOut.ActiveSheetAsTable.CreateCell(Y,1) do
                     begin

                         AsVariant := edtURL.Text  + varEtiquetaOut;
                     end;


                     Inc(Y);


                end;

                varContador := varContador - 4;

                if varContador <= 59 then
                   Break;


             end;

             bPrimeiro   := True;
             varContador :=  0;
             for I := 60 downto 1  do  // 128
             begin

                if varContador = 0 then
                   varContador :=  60;


                for z := varContador-3 to varContador  do  // 128
                begin

                     if ((bPrimeiro) and ((z = 57) or (z = 58)or (z = 59)or (z = 60))) then
                     begin
                        varEtiquetaOut := varEtiqueta;
                        if z = 60 then
                          bPrimeiro      := False;
                     end
                     else
                        varEtiquetaOut := varEtiqueta + Format('%3.3d',[z]);

                     with dxSpreadSheetOut.ActiveSheetAsTable.CreateCell(Y,0) do
                     begin

                         AsVariant := varEtiquetaOut;
                     end;

                     with dxSpreadSheetOut.ActiveSheetAsTable.CreateCell(Y,1) do
                     begin

                         AsVariant := edtURL.Text  + varEtiquetaOut;
                     end;


                     Inc(Y);

                end;

                varContador := varContador - 4;

                if varContador <= 0 then
                   Break;

             end;

         end;

         if not System.IOUtils.TDirectory.Exists( edtOutPut.Text+ '\'  ) then
            System.IOUtils.TDirectory.CreateDirectory( edtOutPut.Text + '\' );

         if FileExists( edtOutPut.Text  + '\' + Veiculo.Tipo + '.xlsx' ) then
            DeleteFile( edtOutPut.Text  + '\' + Veiculo.Tipo + '.xlsx' );


         varContador := varContador + 1;

         Application.ProcessMessages;

      end;

    finally

      FreeAndNil(dxSpreadSheet);

    end;

    dxSpreadSheetOut.BeginUpdate;
    dxSpreadSheetOut.SaveToFile(  edtOutPut.Text  + '\' + Veiculo.Tipo + '.xlsx' );

    Application.MessageBox( pWideChar( 'Arquivo ' +  edtOutPut.Text  + '\' + Veiculo.Tipo + '.xlsx'  +  ' foi criado. ' ) , 'BradyEtiqueta', MB_ICONINFORMATION);


    finally
      FreeAndNil(dxSpreadSheetOut);
    end;

  finally
    Mensagem( EmptyStr );
    cxButtonEditPath.Clear;
  end;
end;

procedure TfrmPrincipal.btnSalvarINIClick(Sender: TObject);
Var
  ArqIni: TIniFile;

begin

{   if not ConectarEmailPadrao then
  begin
     Application.MessageBox( 'Configura��o de Conta de E-mail Padr�o Incorreta - N�o foi poss�vel conectar na Conta de E-mail', 'Configura��o', MB_ICONEXCLAMATION);
     Exit;
  end;
 }
  Screen.Cursor := crHourGlass;
  Mensagem('Aguarde...');
  Try

    DeleteFile(ExtractFilePath(Application.ExeName) + '\ETIQUETA_DETRAN.ini');

  except
  on E: Exception do
      begin
        Screen.Cursor := crDefault;
        Application.MessageBox( PwideChar( E.Message ) , 'Cadastro', MB_ICONERROR);
      end;
  End;

  ArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + '\ETIQUETA_DETRAN.ini');


   try
    //ArqIni.WriteString('[CARRO]','','');
    ArqIni.WriteString('CARRO', 'LINHAS', edtCarroLinha.Text);
    ArqIni.WriteString('CARRO', 'INTERVALO', edtCarroInter.Text);
    ArqIni.WriteString('CARRO', 'BASE', edtCarroBase.Text);

    //ArqIni.WriteString('[MOTO]','','');
    ArqIni.WriteString('MOTO', 'LINHAS', edtMotoLinha.Text);
    ArqIni.WriteString('MOTO', 'INTERVALO', edtMotoInter.Text);
    ArqIni.WriteString('MOTO', 'BASE', edtMotoBase.Text);

    //ArqIni.WriteString('[CAMINHAO]','','');
    ArqIni.WriteString('CAMINHAO', 'LINHAS', edtCaminhaoLinha.Text);
    ArqIni.WriteString('CAMINHAO', 'INTERVALO', edtCaminhaoInter.Text);
    ArqIni.WriteString('CAMINHAO', 'BASE', edtCaminhaoBase.Text);

    //ArqIni.WriteString('[ONIBUS]','','');
    ArqIni.WriteString('ONIBUS', 'LINHAS', edtOnibusLinha.Text);
    ArqIni.WriteString('ONIBUS', 'INTERVALO', edtOnibusInter.Text);
    ArqIni.WriteString('ONIBUS', 'BASE', edtOnibusBase.Text);

    //ArqIni.WriteString('[SITE]','','');
    ArqIni.WriteString('SITE', 'URL', edtURL.Text);

    //ArqIni.WriteString('[PASTA]','','');
    ArqIni.WriteString('PASTA', 'OUTPUT', edtOutPut.Text);



    if System.IOUtils.TFile.Exists( MyDocumentsPath + '\ETIQUETA_DETRAN.ini' ) then
      DeleteFile(MyDocumentsPath + '\ETIQUETA_DETRAN.ini');

    System.IOUtils.TFile.Copy( ExtractFilePath(Application.ExeName) + '\ETIQUETA_DETRAN.ini' , MyDocumentsPath + '\ETIQUETA_DETRAN.ini', True );

    Mensagem(EmptyStr);

    Application.MessageBox( 'Altera��o salvas com Sucesso.', 'Cadastro', MB_ICONINFORMATION);

  finally
     Screen.Cursor := crDefault;
     Mudou := False;
     ArqIni.Free;
  end;


end;

procedure TfrmPrincipal.edtCarroLinhaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Mudou := True;
end;

procedure TfrmPrincipal.edtOutPutClick(Sender: TObject);

var
  FDir : String;
begin
  inherited;
  if Win32MajorVersion >= 6 then
    with TFileOpenDialog.Create(nil) do
    try
      Title := 'Selecionar Diret�rio';
      Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem]; // YMMV
      OkButtonLabel := 'Selecionar';
      DefaultFolder := FDir;
      FileName := FDir;
      if Execute then
      begin
        edtOutPut.Text := FileName;

      end;
    finally
      Free;
    end
  else
    if SelectDirectory('Selecionar Diret�rio', ExtractFileDrive(FDir), FDir,
             [sdNewUI, sdNewFolder]) then
      edtOutPut.Text := FDir;

  Mudou := True;


end;

Procedure TfrmPrincipal.CarregaINI;
Var
  ArqIni: TIniFile;
begin
   try

      if FileExists(MyDocumentsPath + '\ETIQUETA_DETRAN.ini') then
      begin

         ArqIni := TIniFile.Create(MyDocumentsPath + '\ETIQUETA_DETRAN.ini');

      end
      else
      begin

        ArqIni := TIniFile.Create(ExtractFileDir(ParamStr(0)) + '\ETIQUETA_DETRAN.ini');

      end;

      StatusBar.Panels[0].Text := ExtractFilePath(ArqIni.FileName) + ExtractFileName(ArqIni.FileName);
      edtCarroLinha.Text := ArqIni.ReadString('CARRO', 'LINHAS', edtCarroLinha.Text);
      edtCarroInter.Text := ArqIni.ReadString('CARRO', 'INTERVALO', edtCarroInter.Text);
      edtCarroBase.Text := ArqIni.ReadString('CARRO', 'BASE', edtCarroBase.Text);

      edtMotoLinha.Text := ArqIni.ReadString('MOTO', 'LINHAS', edtMotoLinha.Text);
      edtMotoInter.Text := ArqIni.ReadString('MOTO', 'INTERVALO', edtMotoInter.Text);
      edtMotoBase.Text := ArqIni.ReadString('MOTO', 'BASE', edtMotoBase.Text);

      edtCaminhaoLinha.Text := ArqIni.ReadString('CAMINHAO', 'LINHAS', edtCaminhaoLinha.Text);
      edtCaminhaoInter.Text := ArqIni.ReadString('CAMINHAO', 'INTERVALO', edtCaminhaoInter.Text);
      edtCaminhaoBase.Text := ArqIni.ReadString('CAMINHAO', 'BASE', edtCaminhaoBase.Text);


      edtOnibusLinha.Text := ArqIni.ReadString('ONIBUS', 'LINHAS', edtOnibusLinha.Text);
      edtOnibusInter.Text := ArqIni.ReadString('ONIBUS', 'INTERVALO', edtOnibusInter.Text);
      edtOnibusBase.Text := ArqIni.ReadString('ONIBUS', 'BASE', edtOnibusBase.Text);


      edtOutPut.Text :=  ArqIni.ReadString('PASTA', 'OUTPUT', edtOutPut.Text);
      edtURL.Text   := ArqIni.ReadString('SITE', 'URL', edtURL.Text);


      Mudou := False;


    finally
      ArqIni.Free;
    end;
end;

procedure TfrmPrincipal.cxButtonEditPathClick(Sender: TObject);
begin
  if SaveDialog.Execute(Handle) then
  begin
    cxButtonEditPath.Text := SaveDialog.FileName;
  end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(Veiculo);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  Page.ActivePage := TabEtiqueta;

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\ETIQUETA_DETRAN.ini' ) then
    DeleteFile(MyDocumentsPath + '\ETIQUETA_DETRAN.ini');

  if System.IOUtils.TFile.Exists( MyDocumentsPath + '\Detran_Output.xlsx' ) then
    DeleteFile(MyDocumentsPath + '\Detran_Output.xlsx');


  if not System.IOUtils.TFile.Exists(  ExtractFilePath(Application.ExeName)  + '\ETIQUETA_DETRAN.ini' ) then
  begin
    Application.MessageBox( pWideChar( 'Arquivo ETIQUETA_DETRAN.ini n�o encontrado na pasta ' + ExtractFilePath(Application.ExeName) +  #13#10 + 'Abortar Programa. ' ) , 'BradyEtiqueta', MB_ICONINFORMATION);
    Close;
  end;


  if not System.IOUtils.TFile.Exists(  ExtractFilePath(Application.ExeName)  + '\Detran_Output.xlsx' ) then
  begin
    Application.MessageBox( pWideChar( 'Arquivo Detran_Output.xlsx n�o encontrado na pasta ' + ExtractFilePath(Application.ExeName) +  #13#10 + 'Abortar Programa. ' ) , 'BradyEtiqueta', MB_ICONINFORMATION);
    Close;
  end;


  System.IOUtils.TFile.Copy( ExtractFilePath(Application.ExeName) + '\ETIQUETA_DETRAN.ini' , MyDocumentsPath + '\ETIQUETA_DETRAN.ini', True );

  System.IOUtils.TFile.Copy( ExtractFilePath(Application.ExeName) + '\Detran_Output.xlsx' , MyDocumentsPath + '\Detran_Output.xlsx', True );

  CarregaINI;
  Mudou := False;

  Veiculo := TVeiculo.Create;
  rgTipo.ItemIndex := 0;
  rgTipo.OnClick(Sender);
end;

end.
