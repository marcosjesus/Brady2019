unit uFr_UploadDistribuidores;

interface

uses
  System.IOUtils,
  System.DateUtils,
  System.Math,
  ShellAPI,
  dxSpreadSheet,
  dxSpreadSheetTypes,
  dxSpreadSheetCore,
  dxHashUtils,
  uUtils,
  ACBrNFe,
  ACBrMail,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinOffice2013White,
  dxSkinscxPCPainter, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, Vcl.StdCtrls,
  cxButtons, cxTextEdit, cxMaskEdit, cxButtonEdit, cxLabel, Vcl.ExtCtrls,
  cxGroupBox, cxPC, dxGDIPlusClasses;

type
  TFr_UploadDistribuidores = class(TForm)
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    Panel1: TPanel;
    cxLabel9: TcxLabel;
    cxButtonEditPathPreco: TcxButtonEdit;
    cxButtonProcessar: TcxButton;
    cxLabel1: TcxLabel;
    cxButtonEditPathProduto: TcxButtonEdit;
    cxButton1: TcxButton;
    OpenDialog: TOpenDialog;
    PanelSQLSplashScreen: TPanel;
    ImageSQLSplashScreen: TImage;
    cxLabelMensagem: TcxLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButtonEditPathPrecoClick(Sender: TObject);
    procedure cxButtonProcessarClick(Sender: TObject);
    procedure cxButtonEditPathProdutoClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  private
    procedure Importar_TabelaPreco;
    procedure Mensagem(pMensagem: String);
    procedure Importar_NovosProdutos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fr_UploadDistribuidores: TFr_UploadDistribuidores;

implementation

{$R *.dfm}

uses uBrady, uDados;


procedure TFr_UploadDistribuidores.Importar_NovosProdutos;
var
  I: Integer;

  dxSpreadSheet        : TdxSpreadSheet;
  varStringList        : TStringList;

  varColumnYNumber     : Integer;
  varColumnCatalogo    : Integer;
  varColumnUN          : Integer;
  varColumnQtde_Itens  : Integer;
  varColumnQtde_Minima : Integer;
  varColumnFamilia     : Integer;
  varColumnDescricao   : Integer;
  varColumnSug_Venda   : Integer;
  varColumnTabela_A    : Integer;
  varColumnTabela_B    : Integer;
  varColumnTabela_C    : Integer;
  varColumnTabela_D    : Integer;
  VarColumnImagem      : Integer;

  varTMKT_PROCOD       : Integer;
  varTMKT_PRECOD       : Integer;
  varYNumber           : String;
  varCatalogo          : String;
  varUN                : String;
  varQtde_Itens        : String;
  varQtde_Minima       : String;
  varFamilia           : String;
  varDescricao         : String;
  varSug_Venda         : Extended;
  varTabela_A          : Extended;
  varTabela_B          : Extended;
  varTabela_C          : Extended;
  varTabela_D          : Extended;
  varImagem            : String;

  varUltimaColuna      : Integer;

  procedure WritelnMail( varStr: String );
  var
    varACBrNFe: TACBrNFe;
    varACBrMail: TACBrMail;
    varMensagem: TStringList;
    varCC: TStringList;

  begin

    Writeln( varStr );

    varCC := TStringList.Create;
    varMensagem := TStringList.Create;
    varACBrNFe := TACBrNFe.Create(nil);
    varACBrMail := TACBrMail.Create(nil);
    varACBrNFe.MAIL := varACBrMail;
    try

      varMensagem.Add(MyDocumentsPath+'\'+ExtractFileName(cxButtonEditPathProduto.Text));
      varMensagem.Add( varStr );

      varACBrMail.Clear;
      varACBrMail.Host := 'smtp.gmail.com';
      varACBrMail.Port := '465';
      varACBrMail.SetSSL := True;
      varACBrMail.SetTLS := False;

      varACBrMail.Username := 'suportebrasil@bradycorp.com';
      varACBrMail.Password := 'spUhurebRuF5';

      varACBrMail.From := 'suportebrasil@bradycorp.com';
      varACBrMail.FromName := 'SUPORTE BRASIL';
      varACBrMail.AddAddress('isabella_ares@bradycorp.com', 'Isabella Ares');
      varACBrMail.AddAddress('LEANDRO_LOPES@BRADYCORP.COM', 'LEANDRO LOPES');
      varACBrMail.AddAddress('LUCIANA_PONTIERI@BRADYCORP.COM', 'LUCIANA PONTIERI');
      varACBrMail.AddAddress('marcos.jesus.external@k2partnering.com', 'Marcos');

      varACBrMail.Subject := '[PRODUTO J� CADASTRADO] IMPORT TABELA NOVOS PRODUTOS TMKT ' + FormatDateTime( 'dd/mm/yyyy', Now );
      varACBrMail.IsHTML := True;
      varACBrMail.AltBody.Text := varMensagem.Text;

      try

        varACBrMail.Send;

      except

        on E: Exception do
        begin

          Writeln( E.Message );

        end;

      end;

    finally

      FreeAndNil(varACBrNFe);
      FreeAndNil(varACBrMail);
      FreeAndNil(varMensagem);
      FreeAndNil(varCC);

    end;

  end;
begin
  Mensagem('Import Tabela Novos Produtos TMKT');

  Mensagem('Apagando arquivo. ' + MyDocumentsPath+'\'+ ExtractFileName(cxButtonEditPathProduto.Text) );
  DeleteFile(PWideChar(MyDocumentsPath+'\'+ ExtractFileName(cxButtonEditPathProduto.Text)));

  Mensagem('Copiando arquivo local. ' + cxButtonEditPathProduto.Text + ' para: ' + MyDocumentsPath );
  CopyFile( PWideChar(cxButtonEditPathProduto.Text), PWideChar(MyDocumentsPath+'\'+ ExtractFileName(cxButtonEditPathProduto.Text)), True );

  dxSpreadSheet := TdxSpreadSheet.Create(nil);
  try

    Mensagem('Lendo Planilha ' +  MyDocumentsPath+'\'+ ExtractFileName(cxButtonEditPathProduto.Text));
    dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\'+ ExtractFileName(cxButtonEditPathProduto.Text) );

    varColumnYNumber     := -1;
    varColumnCatalogo    := -1;
    varColumnUN          := -1;
    varColumnQtde_Itens  := -1;
    varColumnQtde_Minima := -1;
    varColumnFamilia     := -1;
    varColumnDescricao   := -1;
    varColumnSug_Venda   := -1;
    varColumnTabela_A    := -1;
    varColumnTabela_B    := -1;
    varColumnTabela_C    := -1;
    varColumnTabela_D    := -1;
    VarColumnImagem      := -1;


    varUltimaColuna := 12;
    Mensagem('Descobrindo Colunas');
    for I := dxSpreadSheet.ActiveSheetAsTable.Columns.FirstIndex to varUltimaColuna do
    begin

      if not  Assigned(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0]) then
         Continue;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'YNUMBER' then
        varColumnYNumber := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'CATALOGO' then
        varColumnCatalogo := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'UN' then
        varColumnUN := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'QTDE_ITENS' then
        varColumnQtde_Itens := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'QTDE_MINIMA' then
        varColumnQtde_Minima := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'FAMILIA' then
        varColumnFamilia := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'DESCRICAO' then
        varColumnDescricao := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'SUG_VENDAS' then
        varColumnSug_Venda := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'TABELA_A' then
        varColumnTabela_A := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'TABELA_B' then
        varColumnTabela_B := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'TABELA_C' then
        varColumnTabela_C := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'TABELA_D' then
        varColumnTabela_D := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'IMAGEM' then
        VarColumnImagem := I;

    end;

    if varColumnYNumber = -1 then
      WritelnMail( 'Coluna (YNumber) n�o foi encontrada' );
    if varColumnCatalogo = -1 then
      WritelnMail( 'Coluna (Catalogo) n�o foi encontrada' );
    if varColumnUN = -1 then
      WritelnMail( 'Coluna (UN) n�o foi encontrada' );
    if varColumnQtde_Itens = -1 then
      WritelnMail( 'Coluna (Qtde_Itens) n�o foi encontrada' );
    if varColumnQtde_Minima = -1 then
      WritelnMail( 'Coluna (Qtde_Minima) n�o foi encontrada' );
    if varColumnFamilia = -1 then
      WritelnMail( 'Coluna (Familia) n�o foi encontrada' );
    if varColumnDescricao = -1 then
      WritelnMail( 'Coluna (Descricao) n�o foi encontrada' );
    if varColumnSug_Venda = -1 then
      WritelnMail( 'Coluna (Sug_Venda) n�o foi encontrada' );
    if varColumnTabela_A = -1 then
      WritelnMail( 'Coluna (Tabela_A) n�o foi encontrada' );
    if varColumnTabela_B = -1 then
      WritelnMail( 'Coluna (Tabela_B) n�o foi encontrada' );
    if varColumnTabela_C = -1 then
      WritelnMail( 'Coluna (Tabela_C) n�o foi encontrada' );
    if varColumnTabela_D = -1 then
      WritelnMail( 'Coluna (Tabela_D) n�o foi encontrada' );
    if VarColumnImagem = -1 then
      WritelnMail( 'Coluna (Imagem) n�o foi encontrada' );

    Mensagem( 'Criando DataModule' );
    Fr_Dados := TFr_Dados.Create(nil);
    varStringList := TStringList.Create;
    try

      with Fr_Dados do
      begin

        Mensagem('Config FDConnection');
        FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB-MySQL.ini' );

        Mensagem('Open FDConnection');
        FDConnection.Open;
        try


            varStringList.Clear;
            Writeln('Looping pelas linhas');
            for I := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
            begin

              if not  Assigned(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[0]) then
                Continue;


              Mensagem( 'Linhas (' + IntToStr(I-1) + '/' + IntToStr(dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex-1) + ')' );

              varYNumber     := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnYNumber].AsString);
              varCatalogo    := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnCatalogo].AsString);
              varUN          := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnUN].AsString);
              varQtde_Itens  := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnQtde_Itens].AsString);
              varQtde_Minima := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnQtde_Minima].AsString);
              varFamilia     := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFamilia].AsString);
              varDescricao   := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDescricao].AsString);

              varSug_Venda   := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnSug_Venda].AsFloat,-2);
              varTabela_A    := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTabela_A].AsFloat,-2);
              varTabela_B    := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTabela_B].AsFloat,-2);
              varTabela_C    := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTabela_C].AsFloat,-2);
              varTabela_D    := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTabela_D].AsFloat,-2);
              varImagem      := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[VarColumnImagem].AsString);

              varTMKT_PROCOD := -1;
              FDQueryConsultaPreco.Close;
              FDQueryConsultaPreco.SQL.Clear;
              FDQueryConsultaPreco.SQL.Add('Select  COALESCE(tmkt_procod ,0) as tmkt_procod From TMKT_PRODUTO where tmkt_procodsap = :tmkt_procodsap');
              FDQueryConsultaPreco.Params.ParamByName('tmkt_procodsap').AsString := varYNumber;
              FDQueryConsultaPreco.Open;
              varTMKT_PROCOD :=  FDQueryConsultaPreco.FieldByName('tmkt_procod').AsInteger;

              if varTMKT_PROCOD = 0 then
              begin

                 varTMKT_PROCOD := -1;
                 FDQueryConsultaPreco.Close;
                 FDQueryConsultaPreco.SQL.Clear;
                 FDQueryConsultaPreco.SQL.Add('SELECT MAX(TMKT_PROCOD)+1 AS TMKT_PROCOD  FROM TMKT_PRODUTO');
                 FDQueryConsultaPreco.Open;
                 varTMKT_PROCOD :=  FDQueryConsultaPreco.FieldByName('TMKT_PROCOD').AsInteger;

                 if varTMKT_PROCOD <> -1 then
                 begin

                     FDQueryGravaPreco.Close;
                     FDQueryGravaPreco.SQL.Clear;
                     FDQueryGravaPreco.SQL.Add('INSERT INTO TMKT_PRODUTO (TMKT_PROCOD,TMKT_PROCODSAP, TMKT_PROCODCAT, TMKT_PROCODAUX,');
                     FDQueryGravaPreco.SQL.Add('TMKT_PRODES, TMKT_PROIMG) VALUES (');
                     FDQueryGravaPreco.SQL.Add(':TMKT_PROCOD,:TMKT_PROCODSAP, :TMKT_PROCODCAT, :TMKT_PROCODAUX, :TMKT_PRODES, :TMKT_PROIMG) ');

                     FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger     := varTMKT_PROCOD;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PROCODSAP').AsString   := varYNumber;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PROCODCAT').AsString   := varCatalogo;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PROCODAUX').AsString   := varFamilia;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRODES').AsString      := varDescricao;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PROIMG').AsString      := varImagem;
                     Try
                       FDQueryGravaPreco.ExecSQL;
                     except
                        on E: Exception do
                          begin

                            Mensagem( 'Novo Produto: ' + E.Message );

                          end;
                     End;


                     FDQueryConsultaPreco.Close;
                     FDQueryConsultaPreco.SQL.Clear;
                     FDQueryConsultaPreco.SQL.Add('SELECT MAX(TMKT_PRECOD)+1 AS TMKT_PRECOD  FROM TMKT_PRECO');
                     FDQueryConsultaPreco.Open;
                     varTMKT_PRECOD :=  FDQueryConsultaPreco.FieldByName('TMKT_PRECOD').AsInteger;


                     FDQueryGravaPreco.Close;
                     FDQueryGravaPreco.SQL.Clear;
                     FDQueryGravaPreco.SQL.Add('Insert Into TMKT_PRECO(TMKT_PRECOD,TMKT_PROCOD, TMKT_PRECAT, TMKT_PRELIQCOM, TMKT_PRESUGVEN, TMKT_PREQTDMIN) ');
                     FDQueryGravaPreco.SQL.Add('Values (:TMKT_PRECOD,:TMKT_PROCOD, :TMKT_PRECAT,  :TMKT_PRELIQCOM, :TMKT_PRESUGVEN, :TMKT_PREQTDMIN) ');
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRECOD').AsInteger    := varTMKT_PRECOD;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger    := varTMKT_PROCOD;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString     := 'A';
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat   := varTabela_A;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat   := varSug_Venda;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PREQTDMIN').AsInteger := 1;

                     Try
                       FDQueryGravaPreco.ExecSQL;
                     except
                        on E: Exception do
                          begin

                            Mensagem( 'Salvar Pre�o: ' +  E.Message );

                          end;
                     End;

                     FDQueryConsultaPreco.Close;
                     FDQueryConsultaPreco.SQL.Clear;
                     FDQueryConsultaPreco.SQL.Add('SELECT MAX(TMKT_PRECOD)+1 AS TMKT_PRECOD  FROM TMKT_PRECO');
                     FDQueryConsultaPreco.Open;
                     varTMKT_PRECOD :=  FDQueryConsultaPreco.FieldByName('TMKT_PRECOD').AsInteger;



                     FDQueryGravaPreco.Close;
                     FDQueryGravaPreco.SQL.Clear;
                     FDQueryGravaPreco.SQL.Add('Insert Into TMKT_PRECO(TMKT_PRECOD,TMKT_PROCOD, TMKT_PRECAT, TMKT_PRELIQCOM, TMKT_PRESUGVEN, TMKT_PREQTDMIN) ');
                     FDQueryGravaPreco.SQL.Add('Values (:TMKT_PRECOD,:TMKT_PROCOD, :TMKT_PRECAT,  :TMKT_PRELIQCOM, :TMKT_PRESUGVEN, :TMKT_PREQTDMIN) ');
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRECOD').AsInteger    := varTMKT_PRECOD;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger    := varTMKT_PROCOD;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString     := 'B';
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat   := varTabela_B;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat   := varSug_Venda;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PREQTDMIN').AsInteger := 1;
                     Try
                       FDQueryGravaPreco.ExecSQL;
                     except
                        on E: Exception do
                          begin

                            Mensagem( 'Salvar Pre�o: ' + E.Message );

                          end;
                     End;

                     FDQueryConsultaPreco.Close;
                     FDQueryConsultaPreco.SQL.Clear;
                     FDQueryConsultaPreco.SQL.Add('SELECT MAX(TMKT_PRECOD)+1 AS TMKT_PRECOD  FROM TMKT_PRECO');
                     FDQueryConsultaPreco.Open;
                     varTMKT_PRECOD :=  FDQueryConsultaPreco.FieldByName('TMKT_PRECOD').AsInteger;



                     FDQueryGravaPreco.Close;
                     FDQueryGravaPreco.SQL.Clear;
                     FDQueryGravaPreco.SQL.Add('Insert Into TMKT_PRECO(TMKT_PRECOD,TMKT_PROCOD, TMKT_PRECAT, TMKT_PRELIQCOM, TMKT_PRESUGVEN, TMKT_PREQTDMIN) ');
                     FDQueryGravaPreco.SQL.Add('Values (:TMKT_PRECOD,:TMKT_PROCOD, :TMKT_PRECAT,  :TMKT_PRELIQCOM, :TMKT_PRESUGVEN, :TMKT_PREQTDMIN) ');
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRECOD').AsInteger  := varTMKT_PRECOD;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger  := varTMKT_PROCOD;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString   := 'C';
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat := varTabela_C;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat := varSug_Venda;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PREQTDMIN').AsInteger := 1;
                     Try
                       FDQueryGravaPreco.ExecSQL;
                     except
                        on E: Exception do
                          begin

                            Mensagem( 'Salvar Pre�o: ' + E.Message );

                          end;
                     End;

                     FDQueryConsultaPreco.Close;
                     FDQueryConsultaPreco.SQL.Clear;
                     FDQueryConsultaPreco.SQL.Add('SELECT MAX(TMKT_PRECOD)+1 AS TMKT_PRECOD  FROM TMKT_PRECO');
                     FDQueryConsultaPreco.Open;
                     varTMKT_PRECOD :=  FDQueryConsultaPreco.FieldByName('TMKT_PRECOD').AsInteger;

                     FDQueryGravaPreco.Close;
                     FDQueryGravaPreco.SQL.Clear;
                     FDQueryGravaPreco.SQL.Add('Insert Into TMKT_PRECO(TMKT_PRECOD,TMKT_PROCOD, TMKT_PRECAT, TMKT_PRELIQCOM, TMKT_PRESUGVEN, TMKT_PREQTDMIN) ');
                     FDQueryGravaPreco.SQL.Add('Values (:TMKT_PRECOD,:TMKT_PROCOD, :TMKT_PRECAT,  :TMKT_PRELIQCOM, :TMKT_PRESUGVEN, :TMKT_PREQTDMIN) ');
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRECOD').AsInteger    := varTMKT_PRECOD;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger    := varTMKT_PROCOD;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString     := 'D';
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat   := varTabela_D;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat   := varSug_Venda;
                     FDQueryGravaPreco.Params.ParamByName('TMKT_PREQTDMIN').AsInteger := 1;
                     Try
                       FDQueryGravaPreco.ExecSQL;
                     except
                        on E: Exception do
                          begin

                            Mensagem( 'Salvar Pre�o: ' + E.Message );

                          end;
                     End;
                 end;


              end
              else
              begin
                 varStringList.Add('YNumber: ' + varYNumber + ';Catalogo: ' + varCatalogo + ';Familia: ' + varFamilia + ';Descricao: ' + varDescricao);
              end;


            end;

            if varStringList.Count > 0 then
               WritelnMail(varStringList.Text);


        finally

          FDConnection.Close;

        end;

      end;

    finally

      FreeAndNil(Fr_Dados);

      FreeAndNil(varStringList);

      Mensagem ('Apagando arquivo local. ' + MyDocumentsPath+'\'+ ExtractFileName(cxButtonEditPathProduto.Text) );
      DeleteFile( PWideChar(MyDocumentsPath+'\'+ ExtractFileName(cxButtonEditPathProduto.Text)));

    end;

  finally
    FreeAndNil(dxSpreadSheet);
  end;


end;



procedure TFr_UploadDistribuidores.cxButton1Click(Sender: TObject);
begin
  Importar_NovosProdutos;
end;

procedure TFr_UploadDistribuidores.cxButtonEditPathPrecoClick(Sender: TObject);
begin
  if OpenDialog.Execute(Handle) then
  begin
    cxButtonEditPathPreco.Text := OpenDialog.FileName;
  end;
end;

procedure TFr_UploadDistribuidores.cxButtonEditPathProdutoClick(
  Sender: TObject);
begin
  if OpenDialog.Execute(Handle) then
  begin
    cxButtonEditPathProduto.Text := OpenDialog.FileName;
  end;
end;

procedure TFr_UploadDistribuidores.Mensagem(pMensagem: String);
begin

  cxLabelMensagem.Caption := pMensagem;
  PanelSQLSplashScreen.Visible := not pMensagem.IsEmpty;
  Update;
  Application.ProcessMessages;

end;


procedure TFr_UploadDistribuidores.cxButtonProcessarClick(Sender: TObject);
begin
  Importar_TabelaPreco;
end;

procedure TFr_UploadDistribuidores.Importar_TabelaPreco;
var
  I: Integer;

  dxSpreadSheet        : TdxSpreadSheet;
  varStringList        : TStringList;

  varColumnYNumber     : Integer;
  varColumnCatalogo    : Integer;
  varColumnUN          : Integer;
  varColumnQtde_Itens  : Integer;
  varColumnQtde_Minima : Integer;
  varColumnFamilia     : Integer;
  varColumnDescricao   : Integer;
  varColumnSug_Venda   : Integer;
  varColumnTabela_A    : Integer;
  varColumnTabela_B    : Integer;
  varColumnTabela_C    : Integer;
  varColumnTabela_D    : Integer;

  varTMKT_PROCOD       : Integer;
  varYNumber           : String;
  varCatalogo          : String;
  varUN                : String;
  varQtde_Itens        : String;
  varQtde_Minima       : String;
  varFamilia           : String;
  varDescricao         : String;
  varSug_Venda         : Extended;
  varTabela_A          : Extended;
  varTabela_B          : Extended;
  varTabela_C          : Extended;
  varTabela_D          : Extended;

  varUltimaColuna      : Integer;

  procedure WritelnMail( varStr: String );
  var
    varACBrNFe: TACBrNFe;
    varACBrMail: TACBrMail;
    varMensagem: TStringList;
    varCC: TStringList;

  begin

    Writeln( varStr );

    varCC := TStringList.Create;
    varMensagem := TStringList.Create;
    varACBrNFe := TACBrNFe.Create(nil);
    varACBrMail := TACBrMail.Create(nil);
    varACBrNFe.MAIL := varACBrMail;
    try

      varMensagem.Add(MyDocumentsPath+'\'+cxButtonEditPathPreco.Text);
      varMensagem.Add( varStr );

      varACBrMail.Clear;
      varACBrMail.Host := 'smtp.gmail.com';
      varACBrMail.Port := '465';
      varACBrMail.SetSSL := True;
      varACBrMail.SetTLS := False;

      varACBrMail.Username := 'suportebrasil@bradycorp.com';
      varACBrMail.Password := 'spUhurebRuF5';

      varACBrMail.From := 'suportebrasil@bradycorp.com';
      varACBrMail.FromName := 'SUPORTE BRASIL';

     // varACBrMail.AddAddress('LEANDRO_LOPES@BRADYCORP.COM', 'LEANDRO LOPES');
      varACBrMail.AddAddress('isabella_ares@bradycorp.com', 'Isabella Ares');
      varACBrMail.AddAddress('marcos.jesus.external@k2partnering.com', 'Marcos');
      varACBrMail.Subject := '[PRODUTO N�O CADASTRADO] IMPORT TABELA PRECO TMKT ' + FormatDateTime( 'dd/mm/yyyy', Now );
      varACBrMail.IsHTML := True;
      varACBrMail.AltBody.Text := varMensagem.Text;

      try

        varACBrMail.Send;

      except

        on E: Exception do
        begin

          ShowMessage( E.Message );

        end;

      end;

    finally

      FreeAndNil(varACBrNFe);
      FreeAndNil(varACBrMail);
      FreeAndNil(varMensagem);
      FreeAndNil(varCC);

    end;

  end;


begin
  Mensagem('Import Tabela de Pre�o TMKT');

  Mensagem('Apagando arquivo. ' +  MyDocumentsPath+'\'+ExtractFileName(cxButtonEditPathPreco.Text) );
  DeleteFile(PWideChar(MyDocumentsPath+'\'+ExtractFileName(cxButtonEditPathPreco.Text)));

  Mensagem('Copiando arquivo local. ' +  cxButtonEditPathPreco.Text + ' para: ' + MyDocumentsPath );
  CopyFile( PWideChar(cxButtonEditPathPreco.Text), PWideChar(MyDocumentsPath+'\'+ExtractFileName(cxButtonEditPathPreco.Text)), True );


  dxSpreadSheet := TdxSpreadSheet.Create(nil);
  try

    Mensagem('Lendo Planilha ' +  MyDocumentsPath+'\'+ExtractFileName(cxButtonEditPathPreco.Text));
    dxSpreadSheet.LoadFromFile( MyDocumentsPath+'\'+ExtractFileName(cxButtonEditPathPreco.Text) );

    varColumnYNumber     := -1;
    varColumnCatalogo    := -1;
    varColumnUN          := -1;
    varColumnQtde_Itens  := -1;
    varColumnQtde_Minima := -1;
    varColumnFamilia     := -1;
    varColumnDescricao   := -1;
    varColumnSug_Venda   := -1;
    varColumnTabela_A    := -1;
    varColumnTabela_B    := -1;
    varColumnTabela_C    := -1;
    varColumnTabela_D    := -1;


    varUltimaColuna := 11;
    Mensagem('Descobrindo Colunas');
    for I := dxSpreadSheet.ActiveSheetAsTable.Columns.FirstIndex to varUltimaColuna do
    begin

      if not  Assigned(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0]) then
         Continue;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'YNUMBER' then
        varColumnYNumber := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'CATALOGO' then
        varColumnCatalogo := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'UN' then
        varColumnUN := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'QTDE_ITENS' then
        varColumnQtde_Itens := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'QTDE_MINIMA' then
        varColumnQtde_Minima := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'FAMILIA' then
        varColumnFamilia := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'DESCRICAO' then
        varColumnDescricao := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'SUG_VENDAS' then
        varColumnSug_Venda := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'TABELA_A' then
        varColumnTabela_A := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'TABELA_B' then
        varColumnTabela_B := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'TABELA_C' then
        varColumnTabela_C := I;

      if UpperCase(dxSpreadSheet.ActiveSheetAsTable.Columns[I].Cells[0].AsString) = 'TABELA_D' then
        varColumnTabela_D := I;


    end;

    if varColumnYNumber = -1 then
      WritelnMail( 'Coluna (YNumber) n�o foi encontrada' );
    if varColumnCatalogo = -1 then
      WritelnMail( 'Coluna (Catalogo) n�o foi encontrada' );
    if varColumnUN = -1 then
      WritelnMail( 'Coluna (UN) n�o foi encontrada' );
    if varColumnQtde_Itens = -1 then
      WritelnMail( 'Coluna (Qtde_Itens) n�o foi encontrada' );
    if varColumnQtde_Minima = -1 then
      WritelnMail( 'Coluna (Qtde_Minima) n�o foi encontrada' );
    if varColumnFamilia = -1 then
      WritelnMail( 'Coluna (Familia) n�o foi encontrada' );
    if varColumnDescricao = -1 then
      WritelnMail( 'Coluna (Descricao) n�o foi encontrada' );
    if varColumnSug_Venda = -1 then
      WritelnMail( 'Coluna (Sug_Venda) n�o foi encontrada' );
    if varColumnTabela_A = -1 then
      WritelnMail( 'Coluna (Tabela_A) n�o foi encontrada' );
    if varColumnTabela_B = -1 then
      WritelnMail( 'Coluna (Tabela_B) n�o foi encontrada' );
    if varColumnTabela_C = -1 then
      WritelnMail( 'Coluna (Tabela_C) n�o foi encontrada' );
    if varColumnTabela_D = -1 then
      WritelnMail( 'Coluna (Tabela_D) n�o foi encontrada' );

    Mensagem( 'Criando DataModule' );
    Fr_Dados := TFr_Dados.Create(nil);
    varStringList := TStringList.Create;
    try

      with Fr_Dados do
      begin

        Mensagem('Config FDConnection');
        FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB-MySQL.ini' );

        Mensagem('Open FDConnection');
        FDConnection.Open;
        try


            varStringList.Clear;
            Mensagem('Looping pelas linhas');
            for I := dxSpreadSheet.ActiveSheetAsTable.Rows.FirstIndex+1 to dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
            begin

              Mensagem( 'Linhas ('+ IntToStr(I-1) + '/' + IntToStr(dxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex-1) + ')' );

              varYNumber     := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnYNumber].AsString);
              varCatalogo    := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnCatalogo].AsString);
              varUN          := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnUN].AsString);
              varQtde_Itens  := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnQtde_Itens].AsString);
              varQtde_Minima := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnQtde_Minima].AsString);
              varFamilia     := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnFamilia].AsString);
              varDescricao   := Trim(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnDescricao].AsString);

              varSug_Venda   := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnSug_Venda].AsFloat,-2);
              varTabela_A    := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTabela_A].AsFloat,-2);
              varTabela_B    := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTabela_B].AsFloat,-2);
              varTabela_C    := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTabela_C].AsFloat,-2);
              varTabela_D    := RoundTo(dxSpreadSheet.ActiveSheetAsTable.Rows[I].Cells[varColumnTabela_D].AsFloat,-2);

              varTMKT_PROCOD := 0;
              FDQueryConsultaPreco.Close;
              FDQueryConsultaPreco.SQL.Clear;
              FDQueryConsultaPreco.SQL.Add('Select  tmkt_procod From TMKT_PRODUTO where tmkt_procodsap = :tmkt_procodsap');
              FDQueryConsultaPreco.Params.ParamByName('tmkt_procodsap').AsString := varYNumber;
              FDQueryConsultaPreco.Open;
              varTMKT_PROCOD :=  FDQueryConsultaPreco.FieldByName('tmkt_procod').AsInteger;

              if varTMKT_PROCOD <> 0 then
              begin

                 FDQueryGravaPreco.Close;
                 FDQueryGravaPreco.SQL.Clear;
                 FDQueryGravaPreco.SQL.Add('Update TMKT_PRODUTO');
                 FDQueryGravaPreco.SQL.Add(' Set TMKT_PRODES = :TMKT_PRODES ');
                 FDQueryGravaPreco.SQL.Add( '   where tmkt_procodsap = :tmkt_procodsap ');
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PRODES').AsString    := varDescricao;
                 FDQueryGravaPreco.Params.ParamByName('tmkt_procodsap').AsString := varYNumber;

                  Try
                   FDQueryGravaPreco.ExecSQL;
                 except
                    on E: Exception do
                      begin

                        ShowMessage( 'Salvar Pre�o: ' + E.Message );

                      end;
                 End;

                 FDQueryGravaPreco.Close;
                 FDQueryGravaPreco.SQL.Clear;
                 FDQueryGravaPreco.SQL.Add('Update TMKT_PRECO');
                 FDQueryGravaPreco.SQL.Add('Set TMKT_PRELIQCOM = :TMKT_PRELIQCOM, TMKT_PRESUGVEN = :TMKT_PRESUGVEN');
                 FDQueryGravaPreco.SQL.Add('Where TMKT_PROCOD = :TMKT_PROCOD and TMKT_PRECAT = :TMKT_PRECAT');
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger  := varTMKT_PROCOD;
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString   := 'A';
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat := varTabela_A;
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat := varSug_Venda;

                 Try
                   FDQueryGravaPreco.ExecSQL;
                 except
                    on E: Exception do
                      begin

                        ShowMessage( 'Salvar Pre�o: ' +  E.Message );

                      end;
                 End;

                 FDQueryGravaPreco.Close;
                 FDQueryGravaPreco.SQL.Clear;
                 FDQueryGravaPreco.SQL.Add('Update TMKT_PRECO');
                 FDQueryGravaPreco.SQL.Add('Set TMKT_PRELIQCOM = :TMKT_PRELIQCOM, TMKT_PRESUGVEN = :TMKT_PRESUGVEN');
                 FDQueryGravaPreco.SQL.Add('Where TMKT_PROCOD = :TMKT_PROCOD and TMKT_PRECAT = :TMKT_PRECAT');
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger  := varTMKT_PROCOD;
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString   := 'B';
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat := varTabela_B;
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat := varSug_Venda;

                 Try
                   FDQueryGravaPreco.ExecSQL;
                 except
                    on E: Exception do
                      begin

                        ShowMessage( 'Salvar Pre�o: ' +  E.Message );

                      end;
                 End;

                 FDQueryGravaPreco.Close;
                 FDQueryGravaPreco.SQL.Clear;
                 FDQueryGravaPreco.SQL.Add('Update TMKT_PRECO');
                 FDQueryGravaPreco.SQL.Add('Set TMKT_PRELIQCOM = :TMKT_PRELIQCOM, TMKT_PRESUGVEN = :TMKT_PRESUGVEN');
                 FDQueryGravaPreco.SQL.Add('Where TMKT_PROCOD = :TMKT_PROCOD and TMKT_PRECAT = :TMKT_PRECAT');
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger  := varTMKT_PROCOD;
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString   := 'C';
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat := varTabela_C;
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat := varSug_Venda;

                 Try
                   FDQueryGravaPreco.ExecSQL;
                 except
                    on E: Exception do
                      begin

                        ShowMessage( 'Salvar Pre�o: ' + E.Message );

                      end;
                 End;

                 FDQueryGravaPreco.Close;
                 FDQueryGravaPreco.SQL.Clear;
                 FDQueryGravaPreco.SQL.Add('Update TMKT_PRECO');
                 FDQueryGravaPreco.SQL.Add('Set TMKT_PRELIQCOM = :TMKT_PRELIQCOM, TMKT_PRESUGVEN = :TMKT_PRESUGVEN');
                 FDQueryGravaPreco.SQL.Add('Where TMKT_PROCOD = :TMKT_PROCOD and TMKT_PRECAT = :TMKT_PRECAT');
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PROCOD').AsInteger  := varTMKT_PROCOD;
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PRECAT').AsString   := 'D';
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PRELIQCOM').AsFloat := varTabela_D;
                 FDQueryGravaPreco.Params.ParamByName('TMKT_PRESUGVEN').AsFloat := varSug_Venda;

                 Try
                   FDQueryGravaPreco.ExecSQL;
                 except
                    on E: Exception do
                      begin

                        ShowMessage( 'Salvar Pre�o: ' + E.Message );

                      end;
                 End;


              end
              else
              begin
                 varStringList.Add('YNumber: ' + varYNumber + ';Catalogo: ' + varCatalogo + ';Familia: ' + varFamilia + ';Descricao: ' + varDescricao);
              end;


            end;

            if varStringList.Count > 0 then
               WritelnMail(varStringList.Text);


        finally

          FDConnection.Close;

        end;

      end;

    finally

      FreeAndNil(Fr_Dados);

      FreeAndNil(varStringList);

      Mensagem('Apagando arquivo local. ' +  MyDocumentsPath+'\'+ExtractFileName(cxButtonEditPathPreco.Text));
      DeleteFile( PWideChar( MyDocumentsPath+'\'+ExtractFileName(cxButtonEditPathPreco.Text)));

    end;

  finally
    FreeAndNil(dxSpreadSheet);
  end;
end;


procedure TFr_UploadDistribuidores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Fr_UploadDistribuidores := nil;
  Action := caFree;
end;

end.
