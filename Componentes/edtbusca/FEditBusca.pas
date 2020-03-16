unit FEditBusca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, DB, DBTables, Buttons, ADODB,
  Mask, EditBuscaAux, ActnList, Provider, DBClient, Aguardando,
  ComCtrls, Jpeg ,  DBXMSSQL, SqlExpr, FMTBcd, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxButtons, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint, dxSkinscxPCPainter,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL,System.IOUtils;


type
  TFrmEditBusca = class(TForm)
    Panel2: TPanel;
    lblnome: TLabel;
    dssqlConsulta: TDataSource;
    Panel1: TPanel;
    EdtPesquisa: TMaskEdit;
    Label1: TLabel;
    cbCampos: TComboBox;
    Panel3: TPanel;
    Label2: TLabel;
    btnTxt: TBitBtn;
    btnPdf: TBitBtn;
    SaveDialog: TSaveDialog;
    StatusBar: TStatusBar;
    Panel4: TPanel;
    btnBusca: TcxButton;
    btnConfirma: TcxButton;
    BtnCancelar: TcxButton;
    Image1: TImage;
    sqlConsulta: TFDQuery;
    SQLConnection: TFDConnection;
    FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    procedure DBGridDblClick(Sender: TObject);
    procedure EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cbCamposChange(Sender: TObject);
    procedure btnTxtClick(Sender: TObject);
    procedure CDSConsultaAfterScroll(DataSet: TDataSet);
    procedure cxGrid1DBTableView1DblClick(Sender: TObject);
    procedure cxGrid1DBTableView1KeyPress(Sender: TObject; var Key: Char);
    procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGrid1DBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
  Nome, Apelido, Virgula : ShortString;
  Cond : String;
  NumeroCPF,j : Int64;
  bJaEncontrei : Boolean;

    { Private declarations }
  procedure AguardandoProcesso(Formulario:TForm;Visivel:Boolean;CDSBase:TClientDataSet=nil);
  procedure ExibiArquivo(NomeArquivo : String);
    procedure Le_Imagem_JPEG(Campo: TBlobField; Foto: TImage);
  public
    { Public declarations }
    FFields      : TStringList;
    FTable       : String;
    FJoin       : String;
    FFilter      : String;
    FDefaultBusca: String;
    bSair        : Boolean;
    FOrderBy     : String;
    FSetCPF      : Boolean;
    FSetCNPJ     : Boolean;
    FSetPlaca    : Boolean;
    FDistinct    : Boolean;
    FSelect      : WideString;
   // FConexao     : TFDConnection;
    FColor       : Boolean;
    FNomeCor     : TColor;
    FNomeCampo   : String;
    FIndiceCampo : Integer;
    FValorCor    : String;
    FImagem      : Boolean;
    FLoadConsulta : Boolean;
    FPesquisa     : String;
    FHideTop      : Boolean;
    FTop100       : Boolean;
  end;

var
  FrmEditBusca: TFrmEditBusca;


implementation

{$R *.dfm}

uses  Funcoes;

procedure TFrmEditBusca.DBGridDblClick(Sender: TObject);
begin
  btnConfirma.click;

end;

procedure TFrmEditBusca.EdtPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin

    If ((FSetCPF) Or (FSetCNPJ)) and ((UpperCase(cbCampos.Text) = 'CPF')
        or (UpperCase(cbCampos.Text) = 'CNPJ')) Then
    begin
     If not( key in['0'..'9',#8,#13] ) then
     begin
        beep;{somente delphi 2.0 ou >}
        key:=#0;
     end
    end;

    If ( key in[''''] ) then
          key:=#0;

    if (key = #13) then
      btnBuscaClick(nil);

end;

procedure TFrmEditBusca.DBGridKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    DBGridDblClick(nil);
    bJaEncontrei := True;
  end;
end;

procedure TFrmEditBusca.FormShow(Sender: TObject);
var i, iDefault : Integer;
    Nome, Apelido : String;

begin

  SQLConnection.Params.Clear;
  if TFile.Exists( ExtractFilePath(Application.ExeName) + 'DB-Treinamento.ini' ) then
    SQLConnection.Params.LoadFromFile( ExtractFilePath(Application.ExeName) + '\' +  'DB-Treinamento.ini' )
  else if TFile.Exists( ExtractFilePath(Application.ExeName) + 'DB-CECS2002.ini' ) then
    SQLConnection.Params.LoadFromFile( ExtractFilePath(Application.ExeName) + '\' +  'DB-CECS2002.ini' );
  SQLConnection.Open;

  if SQLConnection.Connected then
    StatusBar.Panels[1].Text := 'Conectado em ' + SQLConnection.Params[0]
  else StatusBar.Panels[1].Text := 'N�o Conectado ';

  bJaEncontrei := False;
  iDefault:= 0;
  for i:=0 to FFields.Count -1 do
  begin
    Nome    := Trim(Pal(FFields[i],1,';'));
    Apelido := Trim(Pal(FFields[i],2,';'));
    if Nome <> '' then
    begin
      if pos(';',FFields[i]) > 0 then
        cbCampos.Items.Add(Apelido)
      else cbCampos.Items.Add(Nome);
      if (AnsiUpperCase(Trim(FDefaultBusca)) = AnsiUpperCase(Nome)) or
         (AnsiUpperCase(Trim(FDefaultBusca)) = AnsiUpperCase(Apelido)) then
        iDefault:= i;
    end else FFields.Delete(i);
  end;
  cbCampos.ItemIndex:= iDefault;
  EdtPesquisa.EditMask:= Trim(Pal(FFields[iDefault],3,';'));
  EdtPesquisa.SetFocus;
  EdtPesquisa.SelStart:=Length(EdtPesquisa.Text);
  //DBGrid.Columns.Clear;

  If (FSetCPF) and  (UpperCase(cbCampos.Text) = 'CPF') Then
   EdtPesquisa.MaxLength := 11
  else If (FSetCNPJ) and (UpperCase(cbCampos.Text) = 'CNPJ')Then
   EdtPesquisa.MaxLength := 14
  else EdtPesquisa.MaxLength := 45;

  FrmEditBusca.Height := 470;
  Panel2.Enabled := True;
  if FPesquisa <> '' then
  begin
     Panel2.Enabled := False;
     EdtPesquisa.Text := FPesquisa;
  end;

  Image1.Visible := FImagem;


  if FLoadConsulta then
     btnBuscaClick(Self);

//  if FImagem Then
//    FrmEditBusca.Height := 630;
end;

procedure TFrmEditBusca.btnBuscaClick(Sender: TObject);
var i : Integer;
    Apelido, Virgula : ShortString;
    Nome : WideString;
    Cond:String;
    iTamanhoColuna : Integer;
    Coluna : TcxGridDBColumn;
begin



   // if ((EdtPesquisa.Text = '') and (FTop100 = False)) then
  //   abort;

   If cbCampos.Text  = '' Then
   Begin
    Application.MessageBox('Selecione o Campo para Pesquisar!', 'Aten��o', MB_ICONINFORMATION + MB_OK);
    cbCampos.SetFocus;
    Exit;
   end;

  // Caso CPF tenha mascara
  If (FSetCPF) and (Length(Trim(EdtPesquisa.Text)) = 14) Then
  begin
    EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'-','');
    EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'.','');
  end;

  // Caso CNPJ tenha mascara
  If (FSetCNPJ) and (Length(Trim(EdtPesquisa.Text)) = 18) Then
  begin
    EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'-','');
    EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'.','');
    EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'/','');
  end;

  If TryStrToInt64(EdtPesquisa.Text, NumeroCPF) Then
  begin
    If (FSetCPF) and (Length(Trim(EdtPesquisa.Text)) = 11) Then
    begin
      EdtPesquisa.Text := FormataCPF(EdtPesquisa.Text);
      If Not TestaCpf(EdtPesquisa.Text) Then
      begin
       Application.MessageBox('CPF Inv�lido!', 'Aten��o', MB_ICONERROR + MB_OK);
       EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'-','');
       EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'.','');
       EdtPesquisa.SetFocus;
       Exit;
      end;
    end
    else If (FSetCNPJ) and (Length(Trim(EdtPesquisa.Text)) = 14) Then
    begin
      EdtPesquisa.Text := FormataCNPJ(EdtPesquisa.Text);
      If Not TestaCNPJ(EdtPesquisa.Text) Then
      begin
       Application.MessageBox('CNPJ Inv�lido!', 'Aten��o', MB_ICONERROR + MB_OK);
       EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'-','');
       EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'.','');
       EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'/','');
       EdtPesquisa.SetFocus;
       Exit;
      end;
    end;
  end;

  If (FSetPlaca) and (Length(Trim(EdtPesquisa.Text)) = 7) Then
    EdtPesquisa.Text := Pal(EdtPesquisa.Text,1,'=') + ' = ' + Copy(Trim(Pal(EdtPesquisa.Text,2,'=')),1,3) + '-' + Copy(Trim(Pal(EdtPesquisa.Text,2,'=')),4,4);


  sqlConsulta.close;

      //Connection:= FConexao;

  sqlConsulta.Connection := SQLConnection;
  sqlConsulta.close;
  sqlConsulta.sql.clear;

     if FDistinct Then
      sqlConsulta.sql.Add('Select Distinct ')
     else sqlConsulta.sql.Add('Select ');

     if ((EdtPesquisa.Text = '') and (FDistinct = False))   then
     begin
        sqlConsulta.sql.Clear;
        sqlConsulta.SQL.Add('Select Top 100 ');
     end;


     for i := 0 to FFields.Count -1 do
     begin
       Nome    := Trim(Pal(FFields[i],1,';'));
       Apelido := Trim(Pal(FFields[i],2,';'));
       if i = 0 then
         Virgula := ''
       else Virgula := ',';

       sqlConsulta.sql.Add(Virgula+Nome);
     end;
     sqlConsulta.sql.Add('From '+FTable);
     sqlConsulta.sql.Add(FJoin);

     if (EdtPesquisa.Text <> '')  then
     begin
        if Trim(FFilter) <> '' then
          sqlConsulta.sql.Add('Where '+FFilter+ ' and ')
        else sqlConsulta.sql.Add('Where ');


        Cond:= '';

        for i := 0 to cbCampos.Items.Count-1 do
          if Trim(Pal(FFields[i],2,';')) <> '#' then
            Cond:= Cond + ' or '+  'UPPER(' + Copy(FFields[i],1,pos(';',FFields[i])-1)  + ') Like ''%' + trim(EdtPesquisa.Text)+ '%''';

        sqlConsulta.sql.Add( '('+Copy(Cond, 4, Length(Cond)) + ')');
     end
     else
     begin
       if Trim(FFilter) <> '' then
        sqlConsulta.sql.Add('Where '+ FFilter );
     end;


     If Trim(FOrderBy) <> EmptyStr Then
       sqlConsulta.sql.Add(' Order by ' + FOrderBy);



  Try
     sqlConsulta.Open;

  Except
     On E:Exception do
       raise Exception.Create('Erro ao Abrir consulta ' + E.Message);
  End;




  If sqlConsulta.RecordCount = 0 Then
  begin
    Application.MessageBox(' N�o existe dados para exibi��o!', 'Informa��o', MB_ICONINFORMATION + MB_OK);
    EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'-','');
    EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'.','');
    if (FLoadConsulta = False) and (EdtPesquisa.CanFocus) then
      EdtPesquisa.SetFocus
    else Close;
  end;

  StatusBar.Panels[0].Text := ' Total de Registros : ' + IntToStr(sqlConsulta.RecordCount);

  If (FSetCPF) and (sqlConsulta.RecordCount = 0) Then
  begin
   EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'-','');
   EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'.','');
  end;

  If (FSetCNPJ) and (sqlConsulta.RecordCount = 0) Then
  begin
   EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'-','');
   EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'.','');
   EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'/','');
  end;

  If (FSetPlaca) and (sqlConsulta.RecordCount = 0) Then
    EdtPesquisa.Text := StrTran(EdtPesquisa.Text,'-','');


  cxGrid1DBTableView1.ApplyBestFit;
  cxGrid1DBTableView1.ClearItems;
   Try
      for i := 0 to FFields.Count -1 do
      begin
        Apelido := Trim(Pal(FFields[i],2,';'));

        Coluna := cxGrid1DBTableView1.CreateColumn;
        Coluna.Tag := 1;

        if Apelido = '#' then
          Coluna.Visible := False;

    //    if Trim(Pal(FFields[i],5,';')) <> '' then
      //     CDSConsulta.Fields[i].EditMask := Trim(Pal(FFields[i],5,';'));

      end;


  Except
     On E:Exception do
       raise Exception.Create('1-'+ E.Message);
  End;
  Try

  for i := 0 to FFields.Count -1 do
  begin

    Apelido := Trim(Pal(FFields[i],2,';'));
    sqlConsulta.FieldList.Fields[i].DisplayLabel := Apelido;

    cxGrid1DBTableView1.Columns[i].DataBinding.FieldName := sqlConsulta.Fields[i].FieldName;

    if Trim(Pal(FFields[i],5,';')) <> '' then
    begin
      with  cxGrid1DBTableView1.DataController do
       (DataSet.FindField(cxGrid1DBTableView1.Columns[i].DataBinding.FieldName) as  TFMTBCDField).DisplayFormat := Trim(Pal(FFields[i],5,';'));
    end;

    cxGrid1DBTableView1.Columns[i].Options.Editing := False;
    cxGrid1DBTableView1.Columns[i].Options.Focusing := False;

    if Apelido = '#' then
      cxGrid1DBTableView1.Columns[i].Visible := False;

    cxGrid1DBTableView1.Columns[i].Caption := Apelido;


    iTamanhoColuna := 0;
//     (cxGrid1DBTableView1.Columns[i].Width > 150) and
    if (cxGrid1DBTableView1.Columns[i].Visible) then
    begin
        if TryStrToInt(Pal(FFields[i],4,';'),iTamanhoColuna) then
           cxGrid1DBTableView1.Columns[i].Width  :=  iTamanhoColuna
        else cxGrid1DBTableView1.Columns[i].Width  := 80;
    end;

  end;

  Except
     On E:Exception do
       raise Exception.Create('2-'+E.Message);
  End;

  {
  SetLength(Combo,DBGrid.FieldCount);
  For i := 0 to DBGrid.DataSource.DataSet.FieldCount - 1 do
  begin
   If DBGrid.Columns[i].Visible Then
   begin
       Combo[i]         := TComboBox.Create(FrmEditBusca);
       Combo[i].Parent  := Panel2;
    //   Combo[i].Items.Add(AdicionaItems(DBGrid.DataSource.DataSet.FieldList.Fields[i].FullName));
       DBGrid.DataSource.DataSet.DisableControls;
       DBGrid.DataSource.DataSet.First;
       while not  DBGrid.DataSource.DataSet.Eof do
       begin
          Combo[i].Items.Add(DBGrid.DataSource.DataSet.FieldList.Fields[i].DisplayText);
          DBGrid.DataSource.DataSet.Next;
       end;
       DBGrid.DataSource.DataSet.EnableControls;
       Combo[i].Width   := DBGrid.Columns[i].Width;
       Combo[i].Style   := csOwnerDrawFixed;
       Combo[i].Top     := 64;


       if DBGrid.DataSource.DataSet.FieldList.Fields[i].Size > 0 Then
       begin
        Combo[i].Width := DBGrid.DataSource.DataSet.FieldList.Fields[i].Size*4;
        if (DBGrid.DataSource.DataSet.FieldList.Fields[i].Size*4) < canvas.TextWidth(Apelido) Then
          Combo[i].Width := Canvas.TextWidth(Apelido)+10;
       end
       else Combo[i].Width := 100;

       If I = 0 Then
         Combo[i].Left    := 0 else Combo[i].Left := Combo[i].Left + Combo[i-1].Width+4;
   end;
  end;
  }

  Try
    cxGrid1.SetFocus;

    if FHideTop then
    begin
       Panel2.Visible      := False;
       btnConfirma.Visible := False;
       BtnCancelar.Left    := (ClientWidth - BtnCancelar.Width) div 2;
    end;
   Except
     On E:Exception do
       raise Exception.Create('3-'+E.Message);
  End;

end;

procedure TFrmEditBusca.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmEditBusca.btnConfirmaClick(Sender: TObject);
begin
  if sqlConsulta.IsEmpty Then
  begin
    Application.MessageBox('N�o existe informa��es!', 'Aten��o', MB_ICONINFORMATION + MB_OK);
    EdtPesquisa.SetFocus;
    abort;
  end;

   bSair:= True;
   close;
end;

procedure TFrmEditBusca.cbCamposChange(Sender: TObject);
begin
  EdtPesquisa.EditMask:= Trim(Pal(FFields[cbCampos.ItemIndex],3,';'))
end;



procedure TFrmEditBusca.btnTxtClick(Sender: TObject);
var conteudo : TStringList;
    linha    : String;
    c        : integer;
    NomeArquivo : String;
begin
 {
  if not  cxGrid1DBTableView1.DataController.DataSet.IsEmpty then
  begin
    conteudo:= TStringList.Create;
    linha:= '';

    for c:= 0 to cxGrid1DBTableView1.DataController.DataSet.FieldCount - 1 do
    begin
      if cxGrid1DBTableView1.Columns[c].Visible then
        linha:= linha + cxGrid1DBTableView1.Columns[c].Caption + ';';
    end;

    linha:= Copy( linha,1,(length(linha) - 1) );
    conteudo.Add(linha);
    Try
      AguardandoProcesso(FrmEditBusca,true,CDSConsulta);
      with cxGrid1DBTableView1 do
      begin
        DataController.DataSet.First;
        DataController.DataSet.DisableControls;
        while not DataController.DataSet.Eof do
        begin
          linha:= '';
          for c:= 0 to DataController.DataSet.FieldCount - 1 do
          begin
            if Columns[c].Visible then
              linha:= linha + DataController.DataSet.Fields[c].AsString + ';';
          end;
          linha:= Copy( linha,1,(length(linha) - 1) );
          conteudo.Add(linha);
          DataController.DataSet.Next;
        end;
        DataController.DataSet.EnableControls;
      end;
    finally
      AguardandoProcesso(FrmEditBusca,false);
    end;

    if SaveDialog.Execute then
    begin
      conteudo.SaveToFile(SaveDialog.FileName + '.txt');
      NomeArquivo := SaveDialog.FileName + '.txt';
    end;
    if FileExists(SaveDialog.FileName + '.txt') then
    begin
      ExibiArquivo(NomeArquivo);
      Application.MessageBox('Arquivo texto gerado com sucesso.','Aviso',MB_OK+MB_ICONINFORMATION);
    end
    else
      Application.MessageBox(pchar('Erro ao gerar o arquivo texto.' + #13 +
                                   'Tente novamente.'),'Aviso',MB_OK+MB_ICONERROR);
  end;
  }
end;


procedure TFrmEditBusca.AguardandoProcesso(Formulario:TForm;Visivel:Boolean;CDSBase:TClientDataSet=nil);
var i: integer;
begin
  if FrmAguardando <> nil then
  begin
    FreeAndNil(FrmAguardando);
  end;

  if Visivel then
  begin
    FrmAguardando := TFrmAguardando.Create(application);
    FrmAguardando.Show;
    if Assigned(CDSBase) then
    begin
      i:= -1;
      while i <> CDSBase.RecordCount do
      begin
        i:= CDSBase.RecordCount;
        CDSBase.GetNextPacket;
        FrmAguardando.LbInfo.Caption:= 'Carregando '+ IntToStr(CDSBase.RecordCount);
        FrmAguardando.Refresh;
      end;
    end;
  end;
end;


procedure TFrmEditBusca.ExibiArquivo(NomeArquivo : String);
var
  Form: TForm; { Vari�vel para o Form }
  ShowArquivo : TMemo;
begin
  Form := TForm.Create(Application);
  try
    Form.BorderStyle := bsDialog;
    Form.Caption := 'Visualizar Arquivo';
    Form.Position := poScreenCenter;
    Form.Width := 660;
    Form.Height := 328;

    ShowArquivo := TMemo.Create(FrmEditBusca);

    With ShowArquivo do
    begin
      ShowArquivo.Parent  := Form;
     // ShowArquivo.Left    := cxGrid1.Left;
     // ShowArquivo.Top     := cxGrid1.Top;
     // ShowArquivo.Height  := cxGrid1.Height + 40;
      //ShowArquivo.Width   := cxGrid1.Width;
      ShowArquivo.Align   := alTop;
      ShowArquivo.ScrollBars := ssBoth;
      ShowArquivo.Lines.LoadFromFile(NomeArquivo);
    end;

    with TLabel.Create(Form) do begin
     Parent := Form;
     Font.Style := [fsBold];
     Font.Size := 10;
     Caption := 'Arquivo : ' + NomeArquivo;
     Left := 5;
     Top := 260;
    end;

    { Coloca o bot�o OK }
    with TBitBtn.Create(Form) do begin
      Parent := Form;
      Left :=  Form.ClientWidth - Width - 10;
      Top := 260;
      Kind := bkOK; { Bot�o Ok }
    end;
    if Form.ShowModal = mrOK then Close;
  finally
  Form.Free;
  end;
end;

Procedure TFrmEditBusca.Le_Imagem_JPEG(Campo:TBlobField; Foto:TImage);
var
  BlobStream : TBlobStream;
  Jpg: TJPEGImage;
  b:TStream;
begin
 b := sqlConsulta.CreateBlobStream(sqlConsulta.FieldByName('IMAGEM'),bmRead);
 Try
  if b.Size > 0 then
  begin
      Jpg := TJpegImage.Create;
      Try
        Jpg.LoadFromStream(b);
        Image1.Picture.Assign(Jpg);
      Finally
        FreeAndNil(jpg);
      end;
  end;
 finally
  FreeAndNil(b);
 end;
end;

procedure TFrmEditBusca.CDSConsultaAfterScroll(DataSet: TDataSet);
begin
  if FImagem Then
    if not sqlConsulta.IsEmpty Then
      Le_Imagem_JPEG(TBlobField(sqlConsulta.FieldbyName('IMAGEM')),Image1);
end;



procedure TFrmEditBusca.cxGrid1DBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
   btnConfirmaClick(Nil);
end;

procedure TFrmEditBusca.cxGrid1DBTableView1DblClick(Sender: TObject);
begin
   btnConfirmaClick(Nil);
end;

procedure TFrmEditBusca.cxGrid1DBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then
    btnConfirmaClick(Nil);
end;

procedure TFrmEditBusca.cxGrid1DBTableView1KeyPress(Sender: TObject;
  var Key: Char);
begin

end;

 {
Procedure Tform1.GeraGridSugestao();
var
i,B : Integer;
Nome : String;
indexGroup : Integer;
Begin
indexGroup := -1;
// gera Bandas
GrdSugestaoTBDBBandedTableView1.Bands[0].Caption := 'FUN��O';
// Gera as colunas

i := 0;
GrdSugestaoTBDBBandedTableView1.Columns[i].DataBinding.FieldName := dmSMF.cdsGrid.FieldList.Fields[i].FieldName;

GrdSugestaoTBDBBandedTableView1.Columns[i].Options.Editing := False;
GrdSugestaoTBDBBandedTableView1.Columns[i].Options.Focusing := False;
GrdSugestaoTBDBBandedTableView1.Columns[i].Position.BandIndex := I;
GrdSugestaoTBDBBandedTableView1.Columns[i].Position.ColIndex := 0;
GrdSugestaoTBDBBandedTableView1.Columns[i].Visible := true;
GrdSugestaoTBDBBandedTableView1.Columns[i].Caption := '';

dmSMF.cdsBlocos.First;

while not cdsBlocos.eof do
begin
  B:= cdsBlocosBLOCO.AsInteger;

   inc(i);

   TRY
    nome := cdsGrid.FieldList.Fields[i+1].FieldName;
  EXCEPT
    exit;
   END;

GrdSugestaoTBDBBandedTableView1.Bands.Add;
GrdSugestaoTBDBBandedTableView1.Bands[b].Caption := cdsBlocosNOM_BLOCO.AsString;
GrdSugestaoTBDBBandedTableView1.CreateColumn;
GrdSugestaoTBDBBandedTableView1.Columns[i].DataBinding.FieldName := cdsGrid.FieldList.Fields[i+1].FieldName;
GrdSugestaoTBDBBandedTableView1.Columns[i].Options.Editing := False;
GrdSugestaoTBDBBandedTableView1.Columns[i].Options.Focusing := False;
GrdSugestaoTBDBBandedTableView1.Columns[i].Visible := true;
GrdSugestaoTBDBBandedTableView1.Columns[i].Position.BandIndex := B;
GrdSugestaoTBDBBandedTableView1.Columns[i].Position.ColIndex := 0;
GrdSugestaoTBDBBandedTableView1.Columns[i].Caption := 'PLAN.';
GrdSugestaoTBDBBandedTableView1.Columns[i].Summary.FooterKind := GrdSugestaoTBDBBandedTableView1Column1.Summary.FooterKind;

inc(i);

TRY
nome := cdsGrid.FieldList.Fields[i+1].FieldName;
EXCEPT
exit;
END;

GrdSugestaoTBDBBandedTableView1.CreateColumn;
GrdSugestaoTBDBBandedTableView1.Columns[i].DataBinding.FieldName := cdsGrid.FieldList.Fields[i+1].FieldName;
GrdSugestaoTBDBBandedTableView1.Columns[i].Options.Editing := False;
GrdSugestaoTBDBBandedTableView1.Columns[i].Options.Focusing := False;
GrdSugestaoTBDBBandedTableView1.Columns[i].Position.BandIndex := B;
GrdSugestaoTBDBBandedTableView1.Columns[i].Position.ColIndex := 1;
GrdSugestaoTBDBBandedTableView1.Columns[i].Visible := true;
GrdSugestaoTBDBBandedTableView1.Columns[i].Caption := 'REAL';
GrdSugestaoTBDBBandedTableView1.Columns[i].Summary.FooterKind := GrdSugestaoTBDBBandedTableView1Column1.Summary.FooterKind;

cdsBlocos.Next;
END;

End;
}


end.

