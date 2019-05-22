unit uImpFuncionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FrmPrBs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinHighContrast, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinSevenClassic, dxSkinSharpPlus,
  dxSkinTheAsphaltWorld, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinsdxStatusBarPainter, Vcl.Menus, Vcl.StdCtrls, cxButtons, dxStatusBar,
  Vcl.Mask, rsEdit, RseditDB, Vcl.ExtCtrls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, cxLabel, dxGDIPlusClasses, dxSpreadSheet,
  Data.FMTBcd, Data.DB, Data.SqlExpr, StrFun, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmImpFuncionario = class(TParamBase)
    cxLabel1: TcxLabel;
    cxbEditPathF: TcxButtonEdit;
    cxButtonProcessar: TcxButton;
    OpenDialog: TOpenDialog;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    sqlAux: TFDQuery;
    sqlFilial: TFDQuery;
    sqlCargo: TFDQuery;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxbEditPathCC: TcxButtonEdit;
    cxbEditPathC: TcxButtonEdit;
    procedure FormShow(Sender: TObject);
    procedure cxButtonProcessarClick(Sender: TObject);
    procedure cxbEditPathFClick(Sender: TObject);
    procedure cxbEditPathCClick(Sender: TObject);
    procedure cxbEditPathCCClick(Sender: TObject);
  private
    procedure Mensagem(pMensagem: String);
    function VincularFuncionarioComFilial(Alias, Matricula: String) : String;
    function VincularFuncionariocomCargo(DescCargo: String) : Integer;
    function VincularFuncionariocomCentroCusto(CentroCustoID, DescCentroCusto : String) : String;
    function LastCodigo(Chave, Tab, Condicao: String): String;
    procedure ImportarFuncionario;
    procedure ImportarCargo;
    procedure ImportarCentroCusto;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImpFuncionario: TfrmImpFuncionario;

implementation

{$R *.dfm}

uses DBConect;

procedure TfrmImpFuncionario.cxbEditPathCCClick(Sender: TObject);
begin
  inherited;
  if OpenDialog.Execute then
     cxbEditPathCC.Text := OpenDialog.FileName;
end;

procedure TfrmImpFuncionario.cxbEditPathCClick(Sender: TObject);
begin
  inherited;
  if OpenDialog.Execute then
     cxbEditPathC.Text := OpenDialog.FileName;
end;

procedure TfrmImpFuncionario.cxbEditPathFClick(Sender: TObject);
begin
  inherited;
  if OpenDialog.Execute then
     cxbEditPathF.Text := OpenDialog.FileName;

end;

function  TfrmImpFuncionario.VincularFuncionariocomCargo(DescCargo : String) : Integer;
var
 varCargoID : Integer;
begin
  varCargoID := 0;
  sqlCargo.Close;
  sqlCargo.SQL.Clear;
  sqlCargo.SQL.Add('Select * From TRE_CARGO where DESCRICAO = :DESCRICAO');
  sqlCargo.Params.ParamByName('DESCRICAO').AsString := DescCargo;
  sqlCargo.Open;
  if sqlCargo.IsEmpty Then
  begin
     sqlAux.Close;
     sqlAux.Sql.Clear;
     sqlAux.Sql.Add('Select MAX(TRE_CARGO_ID) as TRE_CARGO_ID from TRE_CARGO ') ;
     sqlAux.Open;
     varCargoID := sqlAux.FieldByName('TRE_CARGO_ID').AsInteger + 1 ;
     sqlAux.close;

     sqlAux.Close;
     sqlAux.Sql.Clear;
     sqlAux.SQL.Add('Insert into TRE_CARGO (TRE_CARGO_ID, DESCRICAO) values (:TRE_CARGO_ID, :DESCRICAO) ');
     sqlAux.Params.ParamByName('TRE_CARGO_ID').AsInteger :=  varCargoID;
     sqlAux.Params.ParamByName('DESCRICAO').AsString     :=  DescCargo;
     Try
        sqlAux.ExecSQL;
     Except
       On E:Exception do
        begin
          Mensagem( 'Falha ao Inserir CARGO: ' + E.Message );
        end;
     End;
  end
  else varCargoID := sqlCargo.FieldByName('TRE_CARGO_ID').AsInteger;

  result := varCargoID;

end;

function TfrmImpFuncionario.VincularFuncionariocomCentroCusto(CentroCustoID,
  DescCentroCusto: String): String;
var
 varCentroCustoID: String;
begin
  varCentroCustoID := CentroCustoID;
  sqlCargo.Close;
  sqlCargo.SQL.Clear;
  sqlCargo.SQL.Add('Select * From TRE_CENTROCUSTO where TRE_CENTROCENTRO = :TRE_CENTROCENTRO');
  sqlCargo.Params.ParamByName('TRE_CENTROCENTRO').AsString := CentroCustoID;
  sqlCargo.Open;
  if sqlCargo.IsEmpty Then
  begin
     sqlAux.Close;
     sqlAux.Sql.Clear;
     sqlAux.SQL.Add('Insert into TRE_CENTROCUSTO (TRE_CENTROCENTRO_ID, TRE_CENTROCENTRO, DESCRICAO, ATIVO) values (:TRE_CENTROCENTRO_ID, :TRE_CENTROCENTRO, :DESCRICAO, :ATIVO) ');
     sqlAux.Params.ParamByName('TRE_CENTROCENTRO_ID').AsString :=  LastCodigo ('TRE_CENTROCENTRO_ID','TRE_CENTROCUSTO','');
     sqlAux.Params.ParamByName('TRE_CENTROCENTRO').AsString    :=  CentroCustoID;
     sqlAux.Params.ParamByName('DESCRICAO').AsString           :=  DescCentroCusto;
     sqlAux.Params.ParamByName('ATIVO').AsString               :=  'S';

     Try
        sqlAux.ExecSQL;
     Except
       On E:Exception do
        begin
          Mensagem( 'Falha ao Inserir Centro de Custo: ' + E.Message );
        end;
     End;
  end;

  result := varCentroCustoID;

end;

function TfrmImpFuncionario.LastCodigo(Chave, Tab, Condicao: String): String;
var
  QryAux : TFDQuery;
begin
 Result := '';

 QryAux := TFDQuery.Create(Self);
 QryAux.Connection := DB_Conect.SQLConnection ;

  With qryAux do begin

    close;
    Sql.Clear;
    Sql.Add('select Max(' + Chave  +') from ' + Tab + ' '+ Condicao );    // condi��o usado pra gerar subcodigo
    Open;

    if not (Eof) and (Fields[0].AsString <> '') then
      Result :=  IntToStr( StrToInt(Fields[0].AsString) + 1 )
    else if Condicao <> '' then       // � um subcodigo
      Result := '000001'
    else
      Result := '001';                // n�o � subcodigo
  end;
  qryAux.Close;
 QryAux.Destroy;
end;

function TfrmImpFuncionario.VincularFuncionarioComFilial(Alias, Matricula: String) : String;
var
 vCodFilial : Integer;
begin
  vCodFilial := 0;
  sqlFilial.Close;
  sqlFilial.SQL.Clear;
  sqlFilial.SQL.Add('Select CodFilial from Filial Where AliasEmpresa = :AliasEmpresa');
  if Pos('-',Alias) > 0  then
      sqlFilial.Params.ParamByName('AliasEmpresa').AsString := Trim(Str_Pal(Alias, 2, '-'))
  else sqlFilial.Params.ParamByName('AliasEmpresa').AsString := Alias;

  sqlFilial.Open;
  if sqlFilial.IsEmpty then
  begin
     sqlAux.Close;
     sqlAux.Sql.Clear;
     sqlAux.Sql.Add('Select MAX(convert(int,CodFilial)) as CodFilial from Filial ') ;
     sqlAux.Open;
     vCodFilial := sqlAux.FieldByName('CodFilial').AsInteger + 1 ;
     sqlAux.close;

     sqlAux.Close;
     sqlAux.SQL.Clear;
     sqlAux.SQL.Add('Insert into Filial ( CodFilial, Razao, AliasEmpresa) values ( :CodFilial, :Razao, :Alias)');
     sqlAux.Params.ParamByName('CodFilial').AsString := IntToStr(vCodFilial);
     if Pos('-',Alias) > 0  then
     begin
       sqlAux.Params.ParamByName('Razao').AsString := Trim(Str_Pal(Alias, 1, '-'));
       sqlAux.Params.ParamByName('Alias').AsString := Trim(Str_Pal(Alias, 2, '-'));
     end
     else
     begin
       sqlAux.Params.ParamByName('Razao').AsString := Alias;
       sqlAux.Params.ParamByName('Alias').AsString := Alias;
     end;

     Try
        sqlAux.ExecSQL;
     Except
       On E:Exception do
        begin
          Mensagem( 'Falha ao Inserir EMPRESA: ' + E.Message );
        end;
     End;
  end
  else
    vCodFilial := sqlFilial.FieldByName('CodFilial').AsInteger;

  result := IntToStr(vCodFilial);
     {
  sqlAux.Close;
  sqlAux.SQL.Clear;
  sqlAux.SQL.Add('Select FUN_MATRICULA From TRE_FILIAL_FUNCIONARIO Where CODFILIAL = :CODFILIAL and FUN_MATRICULA = :FUN_MATRICULA');
  sqlAux.Params.ParamByName('CODFILIAL').AsString      := IntToStr(vCodFilial);
  sqlAux.Params.ParamByName('FUN_MATRICULA').AsString  := Matricula;
  sqlAux.Open;
  if sqlAux.IsEmpty then
  begin
      sqlAux.Close;
      sqlAux.SQL.Clear;
      sqlAux.SQL.Add('Insert into TRE_FILIAL_FUNCIONARIO (CODFILIAL, FUN_MATRICULA)');
      sqlAux.SQL.Add('Values ( :CODFILIAL, :FUN_MATRICULA)');
      sqlAux.Params.ParamByName('CODFILIAL').AsString      := IntToStr(vCodFilial);
      sqlAux.Params.ParamByName('FUN_MATRICULA').AsString  := Matricula;
      Try
          sqlAux.ExecSQL;
      Except
         On E:Exception do
          begin
            Mensagem( 'Falha ao Vincular Funcionario � Empresa: ' + E.Message );
          end;
      End;
  end;   }
end;

procedure  TfrmImpFuncionario.ImportarCentroCusto;
begin

end;

procedure  TfrmImpFuncionario.ImportarCargo;
begin

end;


procedure  TfrmImpFuncionario.ImportarFuncionario;
var
  I, X: Integer;
  varCodFilial, varCargoID : Integer;
  dxSpreadSheet: TdxSpreadSheet;

  varFilial, varCentroCustoID, varEstabelecimento, varMatricula, varNome, varSexo, varCargo, varCodCentroResultado, varNomeCentroResultado : String;
  varDataNascimento , varDataAdmissao  , varDataDesligamento : TDateTime;
  varDate: Integer;
  varUltimaLinha : Integer;
  bAchou : Boolean;

begin

  if cxbEditPathF.Text = EmptyStr then
    raise Exception.Create('Informe o arquivo primeiro.');


  Mensagem( 'Iniciando processo de importa��o...' );
  try

    dxSpreadSheet := TdxSpreadSheet.Create(nil);
    try

      Mensagem( 'Carregando planilha...' );
      dxSpreadSheet.LoadFromFile( cxbEditPathF.Text );
      dxSpreadSheet.BeginUpdate;



      Mensagem( 'Abrindo Conex�o...' );
      DB_Conect.SQLConnection.Open;
      try

        {  Mensagem( 'Apagando Funcion�rios' );
          DB_Conect.sqlAUX.Close;
          DB_Conect.sqlAUX.SQL.Clear;
          DB_Conect.sqlAUX.SQL.Add('TRUNCATE TABLE TRE_FUNCIONARIO');
          DB_Conect.sqlAUX.ExecSQL;
          DB_Conect.sqlAUX.Close;
     }

          try

            Mensagem( 'Lendo linhas da planilha...' );
            Application.ProcessMessages;
            Sleep(1000);
            Application.ProcessMessages;
            varUltimaLinha :=  dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex;
            Mensagem( 'Total de linhas: ' + IntToStr(varUltimaLinha) );
            Application.ProcessMessages;
            Sleep(5000);
            Application.ProcessMessages;

            for X := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to varUltimaLinha do
            begin

              try

                if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0]) then
                 Continue;

                if dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[1].AsString = EmptyStr then
                   Continue;

                Mensagem( 'Linha (" ' + IntToStr(X) + '/' + IntToStr(varUltimaLinha) + '...' );


                if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0]) then
                 varEstabelecimento := ''
                else varEstabelecimento    :=  dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[0].AsString;


                if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[1]) then
                  varMatricula := ''
                else varMatricula   :=  dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[1].AsString;
                bAchou := False;

                sqlAux.Close;
                sqlAux.SQL.Clear;
                sqlAux.SQL.Add('Select FUN_MATRICULA From TRE_FUNCIONARIO where FUN_MATRICULA = :FUN_MATRICULA');
                sqlAux.Params.ParamByName('FUN_MATRICULA').AsString := varMatricula;
                sqlAux.Open;

                if not sqlAux.IsEmpty then
                begin
                    bAchou := True;
                    varFilial := VincularFuncionarioComFilial(varEstabelecimento, varMatricula);
                    Continue;
                end
                else  varFilial := VincularFuncionarioComFilial(varEstabelecimento, varMatricula);

                if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2]) then
                   varNome := ''
                else varNome  :=  dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[2].AsString;

                if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[3]) then
                  varSexo := ''
                else varSexo      :=  dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[3].AsString;

                if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[4]) then
                  varDataNascimento := Date
                else
                begin
                  if dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[4].AsString <> '' then
                  begin
                    if TryStrToInt( dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[4].AsString, varDate ) then
                      varDataNascimento := varDate
                    else
                      varDataNascimento := StrToDate(String(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[4].AsString).Replace( '.', '/' ));
                  end
                  else varDataNascimento := 0;
                end;

                if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[5]) then
                  varDataAdmissao := Date
                else
                begin
                  if  dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[5].AsString <> '' then
                  begin
                    if TryStrToInt( dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[5].AsString, varDate ) then
                      varDataAdmissao := varDate
                    else
                      varDataAdmissao := StrToDate(String(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[5].AsString).Replace( '.', '/' ));
                  end
                  else  varDataAdmissao := 0
                end;

                if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6]) then
                  varDataDesligamento := 0
                else
                begin
                  if dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6].AsString <> '' then
                  begin

                    if TryStrToInt( dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6].AsString, varDate ) then
                      varDataDesligamento := varDate
                    else
                      varDataDesligamento := StrToDate(String(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[6].AsString).Replace( '.', '/' ));

                  end
                  else varDataDesligamento := 0;
                end;


                if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[7]) then
                  varCargo := ''
                else varCargo      :=  dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[7].AsString;

                //Vincular Cargo ao Funcionario
                if bAchou then
                begin
                   varCargoID := VincularFuncionariocomCargo(varCargo);
                    Continue;
                end
                else  varCargoID := VincularFuncionariocomCargo(varCargo);


                if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[8]) then
                  varCodCentroResultado := ''
                else varCodCentroResultado      :=  dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[8].AsString;

                if not Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[9]) then
                  varNomeCentroResultado := ''
                else varNomeCentroResultado      :=  dxSpreadSheet.ActiveSheetAsTable.Rows[X].Cells[9].AsString;

                if bAchou then
                begin
                    varCentroCustoID := VincularFuncionariocomCentroCusto( varCodCentroResultado, varNomeCentroResultado);
                    Continue;
                end
                else varCentroCustoID := VincularFuncionariocomCentroCusto( varCodCentroResultado, varNomeCentroResultado);

                with DB_Conect.sqlFunc do
                begin
                    Close;
                    sql.Clear;
                    SQL.Add('INSERT INTO TRE_FUNCIONARIO ');
                    SQL.Add('  (FUN_MATRICULA ');
                    SQL.Add('  ,CODFILIAL ');
                    SQL.Add('  ,FUN_NOME ');
                    SQL.Add('  ,FUN_SEXO ');
                    SQL.Add('  ,FUN_DTNASC ');
                    SQL.Add('  ,FUN_DTADM ');
                    SQL.Add('  ,FUN_DTDESL ');
                    SQL.Add('  ,TRE_CARGO_ID ');
                    SQL.Add('  ,TRE_CENTROCENTRO ');
                    SQL.Add('  ,FUN_ATIVO) ');
                    SQL.Add(' VALUES (  ');
                    SQL.Add('   :FUN_MATRICULA ');
                    SQL.Add('  ,:CODFILIAL ');
                    SQL.Add('  ,:FUN_NOME ');
                    SQL.Add('  ,:FUN_SEXO ');
                    SQL.Add('  ,:FUN_DTNASC ');
                    SQL.Add('  ,:FUN_DTADM ');
                    if (DateToStr(varDataDesligamento) = '30/12/1899') then
                      SQL.Add('  ,NULL ')
                    else
                      SQL.Add('  ,:FUN_DTDESL ');

                    SQL.Add('  ,:TRE_CARGO_ID ');
                    SQL.Add('  ,:TRE_CENTROCENTRO ');
                    SQL.Add('  ,:FUN_ATIVO) ');

                    Params.ParamByName('FUN_MATRICULA').AsString        := varMatricula;
                    Params.ParamByName('CODFILIAL').AsString            := varFilial;
                    Params.ParamByName('FUN_NOME').AsString             := varNome;
                    Params.ParamByName('FUN_SEXO').AsString             := varSexo;
                    Params.ParamByName('FUN_DTNASC').AsDateTime         := varDataNascimento;
                    Params.ParamByName('FUN_DTADM').AsDateTime          := varDataAdmissao;
                    if (DateToStr(varDataDesligamento) <> '30/12/1899') then
                     Params.ParamByName('FUN_DTDESL').AsDateTime         := varDataDesligamento;

                    Params.ParamByName('TRE_CARGO_ID').AsInteger        := varCargoID;
                    Params.ParamByName('TRE_CENTROCENTRO').AsString     := varCentroCustoID;
                    Params.ParamByName('FUN_ATIVO').AsString            := 'S';

                    Try
                       ExecSQL;

                    Except
                       on E: Exception do
                       begin
                        ShowMessage(E.Message);
                       end;
                    End;

                    Close;
                    sql.Clear;
                    SQL.Add('INSERT INTO TRE_FUNCIONARIO_HISTORICO ');
                    SQL.Add('  (FUN_MATRICULA ');
                    SQL.Add('  ,CODFILIAL ');
                    SQL.Add('  ,TRE_CARGO_ID ');
                    SQL.Add('  ,TRE_CENTROCENTRO ');
                    SQL.Add('  ,DATA_ATUAL) ');
                    SQL.Add('   VALUES ');
                    SQL.Add('  (:FUN_MATRICULA ');
                    SQL.Add('  ,:CODFILIAL ');
                    SQL.Add('  ,:TRE_CARGO_ID ');
                    SQL.Add('  ,:TRE_CENTROCENTRO ');
                    SQL.Add('  ,:DATA_ATUAL) ');

                    Params.ParamByName('FUN_MATRICULA').AsString        := varMatricula;
                    Params.ParamByName('CODFILIAL').AsString            := varFilial;
                    Params.ParamByName('TRE_CARGO_ID').AsInteger        := varCargoID;
                    Params.ParamByName('TRE_CENTROCENTRO').AsString     := varCentroCustoID;
                    Params.ParamByName('DATA_ATUAL').AsDateTime         := varDataNascimento;

                    Try
                       ExecSQL;

                    Except
                       on E: Exception do
                       begin
                        ShowMessage(E.Message);
                       end;
                    End;
                end;


                Application.ProcessMessages;

              except

                on E: Exception do
                begin
                  ShowMessage(E.Message);
                end;

              end;

            end;

          finally

            DB_Conect.sqlFunc.Close;

          end;


        Application.MessageBox( 'Dados carregados com sucesso!!!', 'Treinamento', MB_ICONINFORMATION );

      finally

        DB_Conect.SQLConnection.Close;

      end;

    finally

      FreeAndNil(dxSpreadSheet);

    end;

  finally

    Mensagem( EmptyStr );

  end;

end;

procedure TfrmImpFuncionario.cxButtonProcessarClick(Sender: TObject);
begin
    if cxbEditPathCC.Text <> '' then
      ImportarCentroCusto;
    if cxbEditPathC.Text <> '' then
      ImportarCargo;
    if cxbEditPathF.Text <> '' then
      ImportarFuncionario;
end;

procedure TfrmImpFuncionario.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;


procedure TfrmImpFuncionario.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
end;

end.
