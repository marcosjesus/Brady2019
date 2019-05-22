program MLDataImport;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  ActiveX,
  SqlExpr,
  Windows,
  ComObj,
  Variants,
  Classes,
  DateUtils,
  ACBrBase,
  ACBrDFe,
  ACBrCTe,
  ACBrNFe,
  ACBrMail,
  Math,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL,
  IdIMAP4,
  IdMessage,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdExplicitTLSClientServerBase,
  IdMessageClient,
  IdSMTPBase,
  IdSMTP,
  IdAttachment,
  SQLTimST,
  pcteConversaoCTe,
  pcteCTe,
  pcnConversao,
  pcnNFe,
  xmldom,
  XMLIntf,
  msxmldom,
  XMLDoc,
  SysUtils,
  IOUtils,
  Forms,
  Global,
  StrFun,
  funcoes,
  DBConect in '..\DBConect.pas' {DB_Conect: TDataModule},
  Md5 in '..\Md5.pas',
  IDEA in '..\IDEA.pas',
  DCPcrypt in '..\DCPcrypt.pas',
  DCPconst in '..\DCPconst.pas',
  Base64 in '..\Base64.pas',
  Sha1 in '..\Sha1.pas';


Type
   TTipoRetorno = record
      trCodigo           : String;
      trCodPlanoContatil : String;
      trCodCentroCusto   : String;
      trRegimeICMS       : String;
      procedure Inicializar;
   end;

Type
  TTipoProduto = record
     trCodProdInterno : String;
     trCodGrupo       : String;
     procedure Inicializar;
  end;

var
  FSearchRecord: TSearchRec;
  FFormatoBR: TFormatSettings;

  // Pastas utilizadas para Leitura de XML (NFE e CTE)
  PastaINBOX               : String;
  PastaLIDO                : String;
  PastaOthers              : String;
  PastaPDF                 : String;
  tpRetorno                : TTipoRetorno;
  tpProduto                : TTipoProduto;
  tpRetornoDestinatario    : TTipoRetorno;
  tpRetornoEmitente        : TTipoRetorno;
  ACBrCTe                  : TACBrCTe;
  ACBrNFe                  : TACBrNFe;
  XMLDoc                   : TXMLDocument;
  infEvento, retEvento , subinfEvento, _subinfEvento: IXMLNode;


procedure RetornarCodigoDestinatarioNFE(Destinatario : pcnNFe.TDest;  NumeroNF : String);
Var
 sSQLUpdate, lSQL : String;
 n : Integer;
begin
   tpRetornoDestinatario.Inicializar;
   With DB_Conect do
   begin
     sqlAux.Close;
     sqlAux.SQL.Text := 'Select cte_destinatario From CTE_DESTINATARIO Where CNPJ = ' + QuotedStr( Destinatario.CNPJCPF);
     sqlAux.Open;
     Try
       if not sqlAux.IsEmpty then
       begin
          tpRetornoDestinatario.trCodigo           := sqlAux.FieldByName('cte_destinatario').AsString;

          sSQLUpdate :=
          'Update CTE_DESTINATARIO '
          +' Set xNome         = :xNome '
          +',cCT               = :cCT '
          +',xFant             = :xFant '
          +',DataInclusao      = :DataInclusao '
          +',CEP               = :CEP '
          +',UF                = :UF '
          +',cMun              = :cMun '
          +',xMun              = :xMun '
          +',xLgr              = :xLgr '
          +',nro               = :nro '
          +',xBairro           = :xBairro '
          +',xCpl              = :xCpl '
        //  +',IEST              = :IEST '
         // +',Fone              = :Fone'
          +' Where CNPJ     = :CNPJ';

          sqlAux.Close;
          sqlAux.SQL.Clear;
          sqlAux.SQL.Add(sSQLUpdate);


            sqlAux.ParamByName('xNome').AsString                := Utf8ToAnsi(Copy(Destinatario.xNome,1,100));
            sqlAux.ParamByName('cCT').AsString                  := NumeroNF;
            sqlAux.ParamByName('xFant').AsString                := Utf8ToAnsi(Copy(Destinatario.xNome,1,40));
            sqlAux.ParamByName('DataInclusao').AsSQLTimeStamp   := DateTimeToSQLTimeStamp(GParFin.DtTrab);
            sqlAux.ParamByName('CEP').AsString                  := IntToStr(Destinatario.enderDest.CEP);
            sqlAux.ParamByName('UF').AsString                   := Destinatario.enderDest.UF;
            sqlAux.ParamByName('cMun').asInteger                := Destinatario.enderDest.cMun;
            sqlAux.ParamByName('xMun').AsString                 := Destinatario.enderDest.xMun;
            sqlAux.ParamByName('xLgr').AsString                 := Destinatario.enderDest.xLgr;
            sqlAux.ParamByName('nro').AsString                  := Destinatario.enderDest.nro;
            sqlAux.ParamByName('xBairro').AsString              := Destinatario.enderDest.xBairro;
            sqlAux.ParamByName('xCpl').AsString                 := Destinatario.enderDest.xCpl;
          //  qryAux.ParamByName('IEST').AsString                 := Dest.IEST;;
            //sqlAux.ParamByName('Fone').AsString                 := enderDest.fone;
            sqlAux.ParamByName('CNPJ').AsString                 := Destinatario.CNPJCPF;


          try
            sqlAux.ExecSQL;

          except
            On E:Exception do
              begin
                Writeln( 'Falha ao Alterar CTE_DESTINATARIO.' + E.Message );
              end;
          end;

       end
     else
       begin
          lSQL := ' INSERT INTO [dbo].[CTE_Destinatario]( ';
          lSQL := lSQL + ' cCT ';
          lSQL := lSQL + ',CNPJ';
          lSQL := lSQL + ',IE';
       //   lSQL := lSQL + ',IEST';
          lSQL := lSQL + ',xNome';
          lSQL := lSQL + ',xFant';
       //   lSQL := lSQL + ',Fone';
          lSQL := lSQL + ',xCpl';
          lSQL := lSQL + ',xLgr';
          lSQL := lSQL + ',nro';
          lSQL := lSQL + ',xBairro';
          lSQL := lSQL + ',cMun';
          lSQL := lSQL + ',xMun';
          lSQL := lSQL + ',CEP';
          lSQL := lSQL + ',UF)';
          lSQL := lSQL + ' VALUES ( ' ;
          lSQL := lSQL + ':cCT ';
          lSQL := lSQL +',:CNPJ ';
          lSQL := lSQL +',:IE ';
     //     lSQL := lSQL +',:IEST ';
          lSQL := lSQL +',:xNome ';
          lSQL := lSQL +',:xFant ';
  //         lSQL := lSQL +',:Fone ';
          lSQL := lSQL +',:xCpl ';
          lSQL := lSQL +',:xLgr ';
          lSQL := lSQL +',:nro ';
          lSQL := lSQL +',:xBairro ';
          lSQL := lSQL +',:cMun';
          lSQL := lSQL +',:xMun';
          lSQL := lSQL +',:CEP';
          lSQL := lSQL +',:UF)';

          sqlAux.Close;
          sqlAux.SQL.Clear;
          sqlAux.SQL.Add( lSQL );

              sqlAux.ParamByName('cCT').AsString                     := NumeroNF;
              sqlAux.ParamByName('CNPJ').AsString                    := Destinatario.CNPJCPF;
              sqlAux.ParamByName('IE').AsString                      := Destinatario.IE;
             // qryInsert.ParamByName('IEST').AsString                  := Dest.IEST;
              sqlAux.ParamByName('xNome').AsString                   := Utf8ToAnsi(Copy(Destinatario.xNome,1,100));
              sqlAux.ParamByName('xFant').AsString                   := Utf8ToAnsi(Copy(Destinatario.xNome,1,40));
      //      qryInsert.ParamByName('Fone').AsString                 := Dest.enderDest.fone;
              sqlAux.ParamByName('xCpl').AsString                    := Destinatario.enderDest.xCpl;
              sqlAux.ParamByName('xLgr').AsString                    := Destinatario.enderDest.xLgr;
              sqlAux.ParamByName('nro').AsString                     := Destinatario.enderDest.nro;
              sqlAux.ParamByName('xBairro').AsString                 := Destinatario.enderDest.xBairro;
              sqlAux.ParamByName('cMun').AsString                    := IntToStr(Destinatario.enderDest.cMun);
              sqlAux.ParamByName('xMun').AsString                    := Destinatario.enderDest.xMun;

              sqlAux.ParamByName('CEP').AsString                     := IntToStr(Destinatario.enderDest.CEP);
              sqlAux.ParamByName('UF').AsString                      := Destinatario.enderDest.UF;

          try
            sqlAux.ExecSQL;
            Try
               lSQL  := 'SELECT @@IDENTITY as CTE_Destinatario ';

               sqlAux.Close;
               sqlAux.SQL.Clear;
               sqlAux.SQL.Add( lSQL );
               sqlAux.Open;
               tpRetornoDestinatario.trCodigo := sqlAux.FieldByName('CTE_Destinatario').AsString;

             except
               On E:Exception do
                 begin
                    DB_Conect.doSaveLogImport(PastaLOG, Db_Conect.GetComando(sqlAux) + #13#10 + 'Falha ao pegar chave da CTE_Destinatario.' + E.Message);
                  end;
             end;

          except
            On E:Exception do
              begin
                DB_Conect.doSaveLogImport(PastaLOG, Db_Conect.GetComando(sqlAux) + #13#10 + 'Falha ao incluir CTE_Destinatario.' + E.Message);
              end;
          end;
       end;
      except
      on E:Exception do
         begin
           Writeln('Falha do Importar o CTE_Destinatario');
         end;

     End;
   end;
end;

procedure RetornarCodigoFornecedorNFE(Emitente : pcnNFe.TEmit;  NumeroNF: String );
Var
 sSQLUpdate, lSQL  : String;
 n :Integer;
begin
   tpRetornoEmitente.Inicializar;
   with DB_Conect do
   begin
     sqlAux.Close;
     sqlAux.SQL.Text := 'Select CTE_EMITENTE_ID, CDContabil, CdCentroCusto, RegimeICMS From CTE_EMITENTE Where CNPJCPF = ' + QuotedStr(Emitente.CNPJCPF);
     sqlAux.Open;
     Try
       if not sqlAux.IsEmpty then
       begin
          tpRetornoEmitente.trCodigo           := sqlAux.FieldByName('CTE_EMITENTE_ID').AsString;
          tpRetornoEmitente.trCodPlanoContatil := sqlAux.FieldByName('CDContabil').AsString;
          tpRetornoEmitente.trCodCentroCusto   := sqlAux.FieldByName('CdCentroCusto').AsString;
          tpRetornoEmitente.trRegimeICMS       := sqlAux.FieldByName('RegimeICMS').AsString;

          sSQLUpdate :=
          'Update CTE_EMITENTE '
          +' Set xNome         = :xNome '
          +',cCT               = :cCT '
          +',xFant             = :xFant '
          +',DataInclusao      = :DataInclusao '
          +',CEP               = :CEP '
          +',UF                = :UF '
          +',cMun              = :cMun '
          +',xMun              = :xMun '
          +',xLgr              = :xLgr '
          +',nro               = :nro '
          +',xBairro           = :xBairro '
          +',xCpl              = :xCpl '
          +',IEST              = :IEST '
          +',Fone              = :Fone'
      //    +',RegimeICMS        = :RegimeICMS'
          +' Where CNPJCPF     = :CNPJCPF';

          sqlAux.Close;
          sqlAux.SQL.Clear;
          sqlAux.SQL.Add(sSQLUpdate);
         Try

           sqlAux.ParamByName('xNome').AsString                := Utf8ToAnsi(Copy(Emitente.xNome,1,100));
           sqlAux.ParamByName('cCT').AsString                  := NumeroNF;
           sqlAux.ParamByName('xFant').AsString                := Utf8ToAnsi(Copy(Emitente.xFant,1,40));
           sqlAux.ParamByName('DataInclusao').AsSQLTimeStamp   := DateTimeToSQLTimeStamp(GParFin.DtTrab);
           sqlAux.ParamByName('CEP').AsString                  := IntToStr(Emitente.EnderEmit.CEP);
           sqlAux.ParamByName('UF').AsString                   := Emitente.EnderEmit.UF;
           sqlAux.ParamByName('cMun').asInteger                := Emitente.EnderEmit.cMun;
           sqlAux.ParamByName('xMun').AsString                 := Emitente.EnderEmit.xMun;
           sqlAux.ParamByName('xLgr').AsString                 := Emitente.EnderEmit.xLgr;
           sqlAux.ParamByName('nro').AsString                  := Emitente.EnderEmit.nro;
           sqlAux.ParamByName('xBairro').AsString              := Emitente.EnderEmit.xBairro;
           sqlAux.ParamByName('xCpl').AsString                 := Emitente.EnderEmit.xCpl;
           sqlAux.ParamByName('IEST').AsString                 := Emitente.IEST;;
           sqlAux.ParamByName('Fone').AsString                 := Emitente.EnderEmit.fone;
      //     sqlAux.ParamByName('RegimeICMS').AsString           := CRTToStr(EnderEmit.CRT);
           sqlAux.ParamByName('CNPJCPF').AsString              := Emitente.CNPJCPF;

         except
            On E:Exception do
                DB_Conect.doSaveLogImport(PastaLOG, GetComando(sqlAux) + #13#10 + 'Falha ao Alterar CTE_EMITENTE.' + E.Message);
         End;
          try
            sqlAux.ExecSQL;

          except
            On E:Exception do
              begin
                DB_Conect.doSaveLogImport(PastaLOG, GetComando(sqlAux) + #13#10 + 'Falha ao Alterar CTE_EMITENTE.' + E.Message);
              end;
          end;

       end
       else
       begin

          lSQL := ' INSERT INTO [dbo].[CTE_EMITENTE]( ';
          lSQL := lSQL + ' cCT ';
          lSQL := lSQL + ',CNPJCPF';
          lSQL := lSQL + ',IE';
          lSQL := lSQL + ',IEST';
          lSQL := lSQL + ',xNome';
          lSQL := lSQL + ',xFant';
          lSQL := lSQL + ',Fone';
          lSQL := lSQL + ',xCpl';
          lSQL := lSQL + ',xLgr';
          lSQL := lSQL + ',nro';
          lSQL := lSQL + ',xBairro';
          lSQL := lSQL + ',cMun';
          lSQL := lSQL + ',xMun';
          lSQL := lSQL + ',CEP';
          lSQL := lSQL + ',UF)';
          lSQL := lSQL + ' VALUES ( ' ;
          lSQL := lSQL + ':cCT ';
          lSQL := lSQL +',:CNPJCPF ';
          lSQL := lSQL +',:IE ';
          lSQL := lSQL +',:IEST ';
          lSQL := lSQL +',:xNome ';
          lSQL := lSQL +',:xFant ';
          lSQL := lSQL +',:Fone ';
          lSQL := lSQL +',:xCpl ';
          lSQL := lSQL +',:xLgr ';
          lSQL := lSQL +',:nro ';
          lSQL := lSQL +',:xBairro ';
          lSQL := lSQL +',:cMun';
          lSQL := lSQL +',:xMun';
          lSQL := lSQL +',:CEP';
          lSQL := lSQL +',:UF)';

          sqlAux.Close;
          sqlAux.SQL.Clear;
          sqlAux.SQL.Add(lSQL);

             sqlAux.ParamByName('cCT').AsString                     := NumeroNF;
             sqlAux.ParamByName('CNPJCPF').AsString                 := Emitente.CNPJCPF;
             sqlAux.ParamByName('IE').AsString                      := Emitente.IE;
             sqlAux.ParamByName('IEST').AsString                    := Emitente.IEST;
             sqlAux.ParamByName('xNome').AsString                   := Utf8ToAnsi(Copy(Emitente.xNome,1,100));
             sqlAux.ParamByName('xFant').AsString                   := Utf8ToAnsi(Copy(Emitente.xFant,1,40));
             sqlAux.ParamByName('Fone').AsString                    := Emitente.EnderEmit.fone;
             sqlAux.ParamByName('xCpl').AsString                    := Emitente.EnderEmit.xCpl;
             sqlAux.ParamByName('xLgr').AsString                    := Emitente.EnderEmit.xLgr;
             sqlAux.ParamByName('nro').AsString                     := Emitente.EnderEmit.nro;
             sqlAux.ParamByName('xBairro').AsString                 := Emitente.EnderEmit.xBairro;
             sqlAux.ParamByName('cMun').AsString                    := IntToStr(Emitente.EnderEmit.cMun);
             sqlAux.ParamByName('xMun').AsString                    := Emitente.EnderEmit.xMun;
             sqlAux.ParamByName('CEP').AsString                     := IntToStr(Emitente.EnderEmit.CEP);
             sqlAux.ParamByName('UF').AsString                      := Emitente.EnderEmit.UF;


          try
            sqlAux.ExecSQL;
            tpRetornoEmitente.Inicializar;
            Try
               lSQL  := 'SELECT @@IDENTITY as CTE_EMITENTE_ID ';

               sqlAux.Close;
               sqlAux.SQL.Clear;
               sqlAux.SQL.Add( lSQL );
               sqlAux.Open;
               tpRetornoEmitente.trCodigo := sqlAux.FieldByName('CTE_EMITENTE_ID').AsString;

             except
               On E:Exception do
                 begin
                    DB_Conect.doSaveLogImport(PastaLOG, Db_Conect.GetComando(sqlAux) + #13#10 + 'Falha ao pegar chave da CTE_EMITENTE_ID.' + E.Message);
                  end;
             end;

          except
            On E:Exception do
              begin
                DB_Conect.doSaveLogImport(PastaLOG, GetComando(sqlAux) + #13#10 + 'Falha ao Incluir CTE_EMITENTE.' + E.Message);
              end;
          end;

       end;
     except
      on E:Exception do
         begin
           Writeln('Falha do Importar o CTE_EMITENTE');
         end;
     End;
   end;

end;

procedure RetornarCodigoDestinatarioCTE(Destinatario  : pcteCTe.TDest;  NumeroNF : String);
Var
 sSQLUpdate, lSQL : String;
 n : Integer;
begin
   tpRetornoDestinatario.Inicializar;
   With DB_Conect do
   begin
     sqlAux.Close;
     sqlAux.SQL.Text := 'Select cte_destinatario From CTE_DESTINATARIO Where CNPJ = ' + QuotedStr( Destinatario.CNPJCPF);
     sqlAux.Open;
     Try
       if not sqlAux.IsEmpty then
       begin
          tpRetornoDestinatario.trCodigo           := sqlAux.FieldByName('cte_destinatario').AsString;

          sSQLUpdate :=
          'Update CTE_DESTINATARIO '
          +' Set xNome         = :xNome '
          +',cCT               = :cCT '
          +',xFant             = :xFant '
          +',DataInclusao      = :DataInclusao '
          +',CEP               = :CEP '
          +',UF                = :UF '
          +',cMun              = :cMun '
          +',xMun              = :xMun '
          +',xLgr              = :xLgr '
          +',nro               = :nro '
          +',xBairro           = :xBairro '
          +',xCpl              = :xCpl '
        //  +',IEST              = :IEST '
         // +',Fone              = :Fone'
          +' Where CNPJ     = :CNPJ';

          sqlAux.Close;
          sqlAux.SQL.Clear;
          sqlAux.SQL.Add(sSQLUpdate);


            sqlAux.ParamByName('xNome').AsString                := Utf8ToAnsi(Copy(Destinatario.xNome,1,100));
            sqlAux.ParamByName('cCT').AsString                  := NumeroNF;
            sqlAux.ParamByName('xFant').AsString                := Utf8ToAnsi(Copy(Destinatario.xNome,1,40));
            sqlAux.ParamByName('DataInclusao').AsSQLTimeStamp   := DateTimeToSQLTimeStamp(GParFin.DtTrab);
            sqlAux.ParamByName('CEP').AsString                  := IntToStr(Destinatario.enderDest.CEP);
            sqlAux.ParamByName('UF').AsString                   := Destinatario.enderDest.UF;
            sqlAux.ParamByName('cMun').asInteger                := Destinatario.enderDest.cMun;
            sqlAux.ParamByName('xMun').AsString                 := Destinatario.enderDest.xMun;
            sqlAux.ParamByName('xLgr').AsString                 := Destinatario.enderDest.xLgr;
            sqlAux.ParamByName('nro').AsString                  := Destinatario.enderDest.nro;
            sqlAux.ParamByName('xBairro').AsString              := Destinatario.enderDest.xBairro;
            sqlAux.ParamByName('xCpl').AsString                 := Destinatario.enderDest.xCpl;
          //  qryAux.ParamByName('IEST').AsString                 := Dest.IEST;;
            //sqlAux.ParamByName('Fone').AsString                 := enderDest.fone;
            sqlAux.ParamByName('CNPJ').AsString                 := Destinatario.CNPJCPF;


          try
            sqlAux.ExecSQL;

          except
            On E:Exception do
              begin
                Writeln( 'Falha ao Alterar CTE_DESTINATARIO.' + E.Message );
              end;
          end;

       end
     else
       begin
          lSQL := ' INSERT INTO [dbo].[CTE_Destinatario]( ';
          lSQL := lSQL + ' cCT ';
          lSQL := lSQL + ',CNPJ';
          lSQL := lSQL + ',IE';
       //   lSQL := lSQL + ',IEST';
          lSQL := lSQL + ',xNome';
          lSQL := lSQL + ',xFant';
       //   lSQL := lSQL + ',Fone';
          lSQL := lSQL + ',xCpl';
          lSQL := lSQL + ',xLgr';
          lSQL := lSQL + ',nro';
          lSQL := lSQL + ',xBairro';
          lSQL := lSQL + ',cMun';
          lSQL := lSQL + ',xMun';
          lSQL := lSQL + ',CEP';
          lSQL := lSQL + ',UF)';
          lSQL := lSQL + ' VALUES ( ' ;
          lSQL := lSQL + ':cCT ';
          lSQL := lSQL +',:CNPJ ';
          lSQL := lSQL +',:IE ';
     //     lSQL := lSQL +',:IEST ';
          lSQL := lSQL +',:xNome ';
          lSQL := lSQL +',:xFant ';
  //         lSQL := lSQL +',:Fone ';
          lSQL := lSQL +',:xCpl ';
          lSQL := lSQL +',:xLgr ';
          lSQL := lSQL +',:nro ';
          lSQL := lSQL +',:xBairro ';
          lSQL := lSQL +',:cMun';
          lSQL := lSQL +',:xMun';
          lSQL := lSQL +',:CEP';
          lSQL := lSQL +',:UF)';

          sqlAux.Close;
          sqlAux.SQL.Clear;
          sqlAux.SQL.Add( lSQL );
          with Destinatario do
          begin
              sqlAux.ParamByName('cCT').AsString                     := NumeroNF;
              sqlAux.ParamByName('CNPJ').AsString                    := Destinatario.CNPJCPF;
              sqlAux.ParamByName('IE').AsString                      := IE;
             // qryInsert.ParamByName('IEST').AsString                  := Dest.IEST;
              sqlAux.ParamByName('xNome').AsString                   := Utf8ToAnsi(Copy(Destinatario.xNome,1,100));
              sqlAux.ParamByName('xFant').AsString                   := Utf8ToAnsi(Copy(Destinatario.xNome,1,40));
      //           qryInsert.ParamByName('Fone').AsString               := Dest.enderDest.fone;
              sqlAux.ParamByName('xCpl').AsString                    := enderDest.xCpl;
              sqlAux.ParamByName('xLgr').AsString                    := enderDest.xLgr;
              sqlAux.ParamByName('nro').AsString                     := enderDest.nro;
              sqlAux.ParamByName('xBairro').AsString                 := enderDest.xBairro;
              sqlAux.ParamByName('cMun').AsString                    := IntToStr(enderDest.cMun);
              sqlAux.ParamByName('xMun').AsString                    := enderDest.xMun;

              sqlAux.ParamByName('CEP').AsString                     := IntToStr(enderDest.CEP);
              sqlAux.ParamByName('UF').AsString                      := enderDest.UF;

          end;

          try
            sqlAux.ExecSQL;


            Try
               lSQL  := 'SELECT @@IDENTITY as CTE_Destinatario ';

               sqlAux.Close;
               sqlAux.SQL.Clear;
               sqlAux.SQL.Add( lSQL );
               sqlAux.Open;
               tpRetornoDestinatario.trCodigo := sqlAux.FieldByName('CTE_Destinatario').AsString;

             except
               On E:Exception do
                 begin
                    DB_Conect.doSaveLogImport(PastaLOG, Db_Conect.GetComando(sqlAux) + #13#10 + 'Falha ao pegar chave da CTE_Destinatario.' + E.Message);
                  end;
             end;

          except
            On E:Exception do
              begin
                DB_Conect.doSaveLogImport(PastaLOG, Db_Conect.GetComando(sqlAux) + #13#10 + 'Falha ao incluir CTE_Destinatario.' + E.Message);
              end;
          end;
       end;
      except
      on E:Exception do
         begin
           Writeln('Falha do Importar o CTE_Destinatario');
         end;

     End;
   end;
end;

procedure RetornarCodigoFornecedorCTE(Emitente : pcteCTe.TEmit;  NumeroNF: String );
Var
 sSQLUpdate, lSQL  : String;
 n :Integer;
begin
   tpRetornoEmitente.Inicializar;
   with DB_Conect do
   begin
     sqlAux.Close;
     sqlAux.SQL.Text := 'Select CTE_EMITENTE_ID, CDContabil, CdCentroCusto, RegimeICMS From CTE_EMITENTE Where CNPJCPF = ' + QuotedStr(Emitente.CNPJ );
     sqlAux.Open;
     Try
       if not sqlAux.IsEmpty then
       begin
          tpRetornoEmitente.trCodigo           := sqlAux.FieldByName('CTE_EMITENTE_ID').AsString;
          tpRetornoEmitente.trCodPlanoContatil := sqlAux.FieldByName('CDContabil').AsString;
          tpRetornoEmitente.trCodCentroCusto   := sqlAux.FieldByName('CdCentroCusto').AsString;
          tpRetornoEmitente.trRegimeICMS       := sqlAux.FieldByName('RegimeICMS').AsString;

          sSQLUpdate :=
          'Update CTE_EMITENTE '
          +' Set xNome         = :xNome '
          +',cCT               = :cCT '
          +',xFant             = :xFant '
          +',DataInclusao      = :DataInclusao '
          +',CEP               = :CEP '
          +',UF                = :UF '
          +',cMun              = :cMun '
          +',xMun              = :xMun '
          +',xLgr              = :xLgr '
          +',nro               = :nro '
          +',xBairro           = :xBairro '
          +',xCpl              = :xCpl '
          +',IEST              = :IEST '
          +',Fone              = :Fone'
      //    +',RegimeICMS        = :RegimeICMS'
          +' Where CNPJCPF     = :CNPJCPF';

          sqlAux.Close;
          sqlAux.SQL.Clear;
          sqlAux.SQL.Add(sSQLUpdate);
         Try
          with Emitente do
          begin
            sqlAux.ParamByName('xNome').AsString                := Utf8ToAnsi(Copy(xNome,1,100));
            sqlAux.ParamByName('cCT').AsString                  := NumeroNF;
            sqlAux.ParamByName('xFant').AsString                := Utf8ToAnsi(Copy(Emitente.xFant,1,40));
            sqlAux.ParamByName('DataInclusao').AsSQLTimeStamp   := DateTimeToSQLTimeStamp(GParFin.DtTrab);
            sqlAux.ParamByName('CEP').AsString                  := IntToStr(EnderEmit.CEP);
            sqlAux.ParamByName('UF').AsString                   := EnderEmit.UF;
            sqlAux.ParamByName('cMun').asInteger                := EnderEmit.cMun;
            sqlAux.ParamByName('xMun').AsString                 := EnderEmit.xMun;
            sqlAux.ParamByName('xLgr').AsString                 := EnderEmit.xLgr;
            sqlAux.ParamByName('nro').AsString                  := EnderEmit.nro;
            sqlAux.ParamByName('xBairro').AsString              := EnderEmit.xBairro;
            sqlAux.ParamByName('xCpl').AsString                 := EnderEmit.xCpl;
            sqlAux.ParamByName('IEST').AsString                 := IEST;;
            sqlAux.ParamByName('Fone').AsString                 := EnderEmit.fone;
       //     sqlAux.ParamByName('RegimeICMS').AsString           := CRTToStr(EnderEmit.CRT);
            sqlAux.ParamByName('CNPJCPF').AsString              := Emitente.CNPJ;
          end;

         except
            On E:Exception do
                DB_Conect.doSaveLogImport(PastaLOG, GetComando(sqlAux) + #13#10 + 'Falha ao Alterar CTE_EMITENTE.' + E.Message);
         End;
          try
            sqlAux.ExecSQL;

          except
            On E:Exception do
              begin
                DB_Conect.doSaveLogImport(PastaLOG, GetComando(sqlAux) + #13#10 + 'Falha ao Alterar CTE_EMITENTE.' + E.Message);
              end;
          end;

       end
       else
       begin

          lSQL := ' INSERT INTO [dbo].[CTE_EMITENTE]( ';
          lSQL := lSQL + ' cCT ';
          lSQL := lSQL + ',CNPJCPF';
          lSQL := lSQL + ',IE';
          lSQL := lSQL + ',IEST';
          lSQL := lSQL + ',xNome';
          lSQL := lSQL + ',xFant';
          lSQL := lSQL + ',Fone';
          lSQL := lSQL + ',xCpl';
          lSQL := lSQL + ',xLgr';
          lSQL := lSQL + ',nro';
          lSQL := lSQL + ',xBairro';
          lSQL := lSQL + ',cMun';
          lSQL := lSQL + ',xMun';
          lSQL := lSQL + ',CEP';
          lSQL := lSQL + ',UF)';
          lSQL := lSQL + ' VALUES ( ' ;
          lSQL := lSQL + ':cCT ';
          lSQL := lSQL +',:CNPJCPF ';
          lSQL := lSQL +',:IE ';
          lSQL := lSQL +',:IEST ';
          lSQL := lSQL +',:xNome ';
          lSQL := lSQL +',:xFant ';
          lSQL := lSQL +',:Fone ';
          lSQL := lSQL +',:xCpl ';
          lSQL := lSQL +',:xLgr ';
          lSQL := lSQL +',:nro ';
          lSQL := lSQL +',:xBairro ';
          lSQL := lSQL +',:cMun';
          lSQL := lSQL +',:xMun';
          lSQL := lSQL +',:CEP';
          lSQL := lSQL +',:UF)';

          sqlAux.Close;
          sqlAux.SQL.Clear;
          sqlAux.SQL.Add(lSQL);
          with Emitente do
          begin
             sqlAux.ParamByName('cCT').AsString                     := NumeroNF;
             sqlAux.ParamByName('CNPJCPF').AsString                 := Emitente.CNPJ;
             sqlAux.ParamByName('IE').AsString                      := IE;
             sqlAux.ParamByName('IEST').AsString                    := IEST;
             sqlAux.ParamByName('xNome').AsString                   := Utf8ToAnsi(Copy(xNome,1,100));
             sqlAux.ParamByName('xFant').AsString                   := Utf8ToAnsi(Copy(xNome,1,40));
             sqlAux.ParamByName('Fone').AsString                    := EnderEmit.fone;
             sqlAux.ParamByName('xCpl').AsString                    := EnderEmit.xCpl;
             sqlAux.ParamByName('xLgr').AsString                    := EnderEmit.xLgr;
             sqlAux.ParamByName('nro').AsString                     := EnderEmit.nro;
             sqlAux.ParamByName('xBairro').AsString                 := EnderEmit.xBairro;
             sqlAux.ParamByName('cMun').AsString                    := IntToStr(EnderEmit.cMun);
             sqlAux.ParamByName('xMun').AsString                    := EnderEmit.xMun;

             sqlAux.ParamByName('CEP').AsString                     := IntToStr(EnderEmit.CEP);
             sqlAux.ParamByName('UF').AsString                      := EnderEmit.UF;
          end;

          try
            sqlAux.ExecSQL;
            tpRetornoEmitente.Inicializar;
            Try
               lSQL  := 'SELECT @@IDENTITY as CTE_EMITENTE_ID ';

               sqlAux.Close;
               sqlAux.SQL.Clear;
               sqlAux.SQL.Add( lSQL );
               sqlAux.Open;
               tpRetornoEmitente.trCodigo := sqlAux.FieldByName('CTE_EMITENTE_ID').AsString;

             except
               On E:Exception do
                 begin
                    DB_Conect.doSaveLogImport(PastaLOG, Db_Conect.GetComando(sqlAux) + #13#10 + 'Falha ao pegar chave da CTE_EMITENTE_ID.' + E.Message);
                  end;
             end;

          except
            On E:Exception do
              begin
                DB_Conect.doSaveLogImport(PastaLOG, GetComando(sqlAux) + #13#10 + 'Falha ao Incluir CTE_EMITENTE.' + E.Message);
              end;
          end;

       end;
     except
      on E:Exception do
         begin
           Writeln('Falha do Importar o CTE_EMITENTE');
         end;
     End;
   end;

end;

Function ConectarNoBanco : Boolean;
begin
   result := False;
   DB_Conect.LerCredenciais;
   if Credencias.Host = '' then
   begin
     Writeln('Problemas na Leitura do Arquivo DB_MLSistemas.Ini !');
     Application.Terminate;
     Exit;
   end;

   Writeln( 'Criando DataModule' );

   DB_Conect := TDB_Conect.Create(nil);
   DB_Conect.SQLConnection.ConnectionName := 'Treinamento';
   DB_Conect.SQLConnection.Params.Clear;
   DB_Conect.SQLConnection.Params.Add('DriverName=MSSQL');
   DB_Conect.SQLConnection.Params.Add('HostName=' + Credencias.Host);
   DB_Conect.SQLConnection.Params.Add('DataBase=' + Credencias.DataBase);
   DB_Conect.SQLConnection.Params.Add('User_Name=' + Credencias.UserName);
   if Credencias.Password = '474952665A2B317A54424D3D' then
     DB_Conect.SQLConnection.Params.Add('Password=cte123');
   DB_Conect.SQLConnection.Params.Add('BlobSize=-1');
   DB_Conect.SQLConnection.Params.Add('ErrorResourceFile=');
   DB_Conect.SQLConnection.Params.Add('LocaleCode=0000');
   DB_Conect.SQLConnection.Params.Add('MSSQL TransIsolation=ReadCommited');
   DB_Conect.SQLConnection.Params.Add('OS Authentication=False');

   DB_Conect.SQLConnection.KeepConnection := false;
   DB_Conect.SQLConnection.Connected := True;

   if DB_Conect.SQLConnection.Connected Then
     result := True;
end;

function SegundoDiaUtil: Boolean;
var
  iCurrentDay: Integer;
  iWorkDay: Integer;

begin

  iWorkDay := 0;
  for iCurrentDay := Trunc(DateUtils.StartOfTheMonth(Now)) to Trunc(Now) do
  begin

    if not (DateUtils.DayOfTheWeek(iCurrentDay) in [DaySaturday,DayMonday]) then
      Inc(iWorkDay);

  end;

  Result := iWorkDay = 2;

end;


Function CriarPastadoCliente(pTipo, pArquivo : String) : String;
Var
  PastaCNPJ, PastaOrigem: String;
  dia, mes, ano: Word;
  DataCCE : String;
begin

  with DB_Conect do
  begin
     if pTipo = 'CTE' then
     begin
        with ACBrCTe.Conhecimentos.Items[0].CTe do
        begin
           FD_Consulta_EntregaXML.Close;
           FD_Consulta_EntregaXML.SQL.Clear;
           FD_Consulta_EntregaXML.SQL.Add('Select CTE_FILIAL_ID from CTE_FILIAL Where cnpj = :cnpj');
           FD_Consulta_EntregaXML.ParamByName('cnpj').AsString := Dest.CNPJCPF;
           FD_Consulta_EntregaXML.Open;

           if FD_Consulta_EntregaXML.IsEmpty then
           begin
              FD_Consulta_EntregaXML.Close;
              FD_Consulta_EntregaXML.SQL.Clear;
              FD_Consulta_EntregaXML.SQL.Add('Select CTE_FILIAL_ID from CTE_FILIAL Where cnpj = :cnpj');
              FD_Consulta_EntregaXML.ParamByName('cnpj').AsString := Emit.CNPJ;
              FD_Consulta_EntregaXML.Open;
              if not FD_Consulta_EntregaXML.IsEmpty then
              begin
                 PastaCNPJ   := Emit.CNPJ;
                 PastaOrigem := 'CTE_SAIDA';

              end
              else
              begin
                 DB_Conect.doSaveLogImport(PastaLOG, pChar(pArquivo)  + ' - CNPJ N�o Cadastrado.');
              end;
           end
           else
           begin
              PastaCNPJ   :=  Dest.CNPJCPF;
              PastaOrigem := 'CTE_ENTRADA';
           end;

           DecodeDate(ide.dhEmi,ano,mes,dia);
        end;
     end
     else if pTipo = 'NFE' then
     begin
        with ACBrNFe.NotasFiscais.Items[0].NFe do
        begin
           FD_Consulta_EntregaXML.Close;
           FD_Consulta_EntregaXML.SQL.Clear;
           FD_Consulta_EntregaXML.SQL.Add('Select CTE_FILIAL_ID from CTE_FILIAL Where cnpj = :cnpj');
           FD_Consulta_EntregaXML.ParamByName('cnpj').AsString := Dest.CNPJCPF;
           FD_Consulta_EntregaXML.Open;

           if FD_Consulta_EntregaXML.IsEmpty then
           begin
              FD_Consulta_EntregaXML.Close;
              FD_Consulta_EntregaXML.SQL.Clear;
              FD_Consulta_EntregaXML.SQL.Add('Select CTE_FILIAL_ID from CTE_FILIAL Where cnpj = :cnpj');
              FD_Consulta_EntregaXML.ParamByName('cnpj').AsString := Emit.CNPJCPF;
              FD_Consulta_EntregaXML.Open;
              if not FD_Consulta_EntregaXML.IsEmpty then
              begin
                 PastaCNPJ   := Emit.CNPJCPF;
                 PastaOrigem := 'NFE_SAIDA';

              end
              else
              begin
                 DB_Conect.doSaveLogImport(PastaLOG, pChar(pArquivo)  + ' - CNPJ N�o Cadastrado.');
              end;
           end
           else
           begin
              PastaCNPJ   :=  Dest.CNPJCPF;
              PastaOrigem := 'NFE_ENTRADA';
           end;

           DecodeDate(ide.dEmi,ano,mes,dia);
        end;
     end
     else if pTipo = 'CCE' then
     begin


        FD_Consulta_EntregaXML.Close;
        FD_Consulta_EntregaXML.SQL.Clear;
        FD_Consulta_EntregaXML.SQL.Add('Select CTE_FILIAL_ID from CTE_FILIAL Where cnpj = :cnpj');
        FD_Consulta_EntregaXML.ParamByName('cnpj').AsString := _subinfEvento.ChildNodes['CNPJ'].Text;
        FD_Consulta_EntregaXML.Open;

        if FD_Consulta_EntregaXML.IsEmpty then
        begin
           FD_Consulta_EntregaXML.Close;
           FD_Consulta_EntregaXML.SQL.Clear;
           FD_Consulta_EntregaXML.SQL.Add('Select CTE_FILIAL_ID from CTE_FILIAL Where cnpj = :cnpj');
           FD_Consulta_EntregaXML.ParamByName('cnpj').AsString := infEvento.ChildNodes['CNPJDest'].Text;
           FD_Consulta_EntregaXML.Open;
           if not FD_Consulta_EntregaXML.IsEmpty then
           begin
              PastaCNPJ   := infEvento.ChildNodes['CNPJDest'].Text;
              PastaOrigem := 'CCE_SAIDA';

           end
           else
           begin
              DB_Conect.doSaveLogImport(PastaLOG, pChar(pArquivo)  + ' - CNPJ N�o Cadastrado.');
           end;
        end
        else
        begin
           PastaCNPJ   := _subinfEvento.ChildNodes['CNPJ'].Text;
           PastaOrigem := 'CCE_ENTRADA';
        end;

        DataCCE := Str_Pal(infEvento.ChildNodes['dhRegEvento'].Text,1,'T');

        DecodeDate(ConvertDate(DataCCE),ano,mes,dia);


     end;

     if not DirExists(  PastaRAIZ  + PastaCNPJ ) then
     begin
         if not ForceDirectories(  PastaRAIZ  + PastaCNPJ ) then
          Exit;
     end;

     if not DirExists(  PastaRAIZ  + PastaCNPJ + '\' + IntToStr(ano) ) then
     begin
         if not ForceDirectories(  PastaRAIZ  + PastaCNPJ + '\' + IntToStr(ano) ) then
          Exit;
     end;

     if not DirExists(  PastaRAIZ  + PastaCNPJ  + IntToStr(ano)  + '\' + IntToStr(mes)) then
     begin
         if not ForceDirectories(  PastaRAIZ  + PastaCNPJ + '\' + IntToStr(ano) + '\' + IntToStr(mes) ) then
          Exit;
     end;

     if not DirExists(  PastaRAIZ  + PastaCNPJ + '\' + IntToStr(ano)   + '\' + IntToStr(mes) + '\'  + PastaOrigem) then
     begin
         if not ForceDirectories(  PastaRAIZ  + PastaCNPJ + '\' + IntToStr(ano)  + '\' + IntToStr(mes) + '\' + PastaOrigem) then
          Exit;
     end;
  end;

  result := IncludeTrailingPathDelimiter (PastaRAIZ  + PastaCNPJ + '\' + IntToStr(ano)  + '\' + IntToStr(mes) + '\' + PastaOrigem);
end;

procedure ReceberEmailNFE;
var
  varSSL               : TIdSSLIOHandlerSocketOpenSSL;
  varIdIMAP41          : TIdIMAP4;
  varMsgXml            : TIdMessage;
  varSMTP              : TStringList;
  varFolderSistema     : String;
  TheFlags             : TIdMessageFlagsSet;
  varSearch            : array of TIdIMAP4SearchRec;
  TheUID               : string;
  i,j, nCount, x       : integer;
  varXML, varTmp,  varToday, varDataEmail : string;

  bMoverNFE, bMoverCTE : Boolean;
  bOthers, bPDF        : Boolean;


  NivelNo1, Nivelno2   : String;
  PastadoCliente       : String;
  Conecta :  Boolean;

begin

  varFolderSistema := ExtractFilePath(Application.ExeName);
//  if not DirExists( IncludeTrailingPathDelimiter( varFolderSistema )  ) then
  //  varFolderSistema := 'T:\';

  // Carrega Pastas do XML
  if not DB_Conect.CarregaPastaXML then
  begin
     Writeln( varFolderSistema + 'MLParametros.ini' + 'Arquivo de Configura��o das Pastas.' );
     Exit;
  end;

  varSMTP     := TStringList.Create;
  varSSL      := TIdSSLIOHandlerSocketOpenSSL.Create(Nil);
  varIdIMAP41 := TIdIMAP4.Create(Nil);
  varMsgXml   := TIdMessage.Create(Nil);
  Try

      if TFile.Exists( varFolderSistema + 'MLParametros.ini' ) then
      begin
        varSMTP.LoadFromFile(varFolderSistema  + 'MLParametros.ini');
        varIdIMAP41.Host         := varSMTP.Values['HOST'];
        varIdIMAP41.Username     := varSMTP.Values['USER'];
        varIdIMAP41.Password     := varSMTP.Values['PWD'];
        varIdIMAP41.Port         := StrToInt(varSMTP.Values['PORT']);
        PastaOthers              := varSMTP.Values['PastaOTHERS'];
        PastaPDF                 := varSMTP.Values['PastaPDF'];
      end
      else
      begin
        Writeln( varFolderSistema + 'MLParametros.ini' + 'Arquivo de Configura��o de Conta de E-mail n�o encontrado.' );
        Exit;
      end;


    //  Writeln( 'Criando DataModule' );
      with DB_Conect do
      begin
         sqlAUX.Close;
         sqlAUX.SQL.Clear;
         sqlAUX.SQL.Add('Select * From CTE_EMAIL where Ativo= ''SIM''');
         sqlAUX.Open;
         if sqlAUX.IsEmpty then
         begin
            Writeln( ' N�o h� Conta de E-mail Configurada no Sistema. Processo ser� abortado' );
            Exit;
         end;

         while not sqlAUX.Eof do
         begin
            varIdIMAP41.Host         := sqlAUX.FieldByName('HOST').AsString;
            varIdIMAP41.Username     := sqlAUX.FieldByName('USERNAME').AsString;
            varIdIMAP41.Password     := sqlAUX.FieldByName('PWD').AsString;
            varIdIMAP41.Port         := sqlAUX.FieldByName('PORT').AsInteger;
            PastaOthers              := sqlAUX.FieldByName('PastaOTHERS').AsString;
            PastaPDF                 := sqlAUX.FieldByName('PastaPDF').AsString;

            varSSL.Host              := varIdIMAP41.Host;
            varSSL.Port              := varIdIMAP41.Port;
            varSSL.Destination       := varSSL.Host + ':' + IntToStr(varSSL.Port);
            varSSL.MaxLineLength     := MaxInt;
            varSSL.SSLOptions.Method := sslvTLSv1;
            varIdIMAP41.IOHandler    := varSSL;
            varIdIMAP41.UseTLS       := utUseImplicitTLS;

            Try
              Writeln('Inicio: ','Conectando na Conta de E-mail (XML) .');
              varIdIMAP41.Disconnect();
              varIdIMAP41.Connect ();

              Try
                  Writeln('Inicio: ','Conectado com Sucesso na Conta -> ' + varIdIMAP41.Username );
                  for x := 0 to 1 do
                  begin
                      if x = 0 then
                         PastaINBOX   := sqlAUX.FieldByName('PASTAINBOXNFE').AsString
                      else
                         PastaINBOX   := sqlAUX.FieldByName('PASTASPAM').AsString;

                      if varIdIMAP41.SelectMailBox(PastaINBOX) = False then begin
                          Writeln( 'Erro ao selecionar Pasta '+PastaINBOX);
                          varIdIMAP41.Disconnect();
                          Exit;
                      end;

                      nCount := varIdIMAP41.MailBox.TotalMsgs;

                      Writeln( 'Total de Email na Caixa : ' + PastaINBOX + ' -> ' + IntToStr(nCount));

                      if nCount = 0 then begin
                          Writeln('N�o h� mensagens na pasta '+PastaINBOX);
                      end else begin
                          for i := 0 to nCount -1 do
                          begin
                              varIdIMAP41.GetUID(i+1, TheUID);
                              varIdIMAP41.Retrieve(i+1,varMsgXml);
                              varIdIMAP41.UIDRetrieveFlags(TheUID, TheFlags);

                              PastaLIDO := '';
                              bMoverNFE := False;
                              bMoverCTE := False;
                              bOthers   := True;
                              bPDF      := False;
                              varTmp := '';
                              varXML := '';
                              for j := 0 to pred(varMsgXml.MessageParts.Count) do
                              begin
                                if (varMsgXml.MessageParts.Items[j] is TIdAttachment) then
                                begin

                                  varXML := TIdAttachment(varMsgXml.MessageParts.Items[j]).FileName;
                                  varTmp := PastaSERVIDORTEMP  + varXML;

                                  bPDF := False;
                                  if lowercase(ExtractFileExt(varTmp)) = '.pdf' then
                                  begin
                                    bOthers := False;
                                    bPDF   := True;
                                    TIdAttachment(varMsgXml.MessageParts.Items[j]).SaveToFile(varTmp);

                                  end
                                  else
                                  if lowercase(ExtractFileExt(varTmp)) = '.xml' then
                                  begin

                                      TIdAttachment(varMsgXml.MessageParts.Items[j]).SaveToFile(varTmp);
                                      ACBrCTe := TACBrCTe.Create(Nil);
                                      ACBrNFe := TACBrNFe.Create(Nil);
                                      Try
                                         TACBrCTe(ACBrCTe).Conhecimentos.Clear;
                                         TACBrNFe(ACBrNFe).NotasFiscais.Clear;
                                         Try
                                             if TACBrCTe(ACBrCTe).Conhecimentos.LoadFromFile(varTmp) then
                                             begin
                                                 bPDF      := False;
                                                 bOthers   := False;
                                                 bMoverCTE := True;
                                                 PastadoCliente := CriarPastadoCliente('CTE', varXML);
                                                 PastaLIDO := sqlAUX.FieldByName('PASTACTE_LIDO').AsString;
                                             end
                                             else
                                             if  TACBrNFe(ACBrNFe).NotasFiscais.LoadFromFile(varTmp) Then
                                             begin
                                                 bOthers   := False;
                                                 bMoverNFE := True;
                                                 bPDF      := False;
                                                 PastadoCliente := CriarPastadoCliente('NFE', varXML);
                                                 PastaLIDO      := sqlAUX.FieldByName('PastaNFE_LIDO').AsString;
                                             end
                                             else
                                             if (Trim(varXML) <> '') then
                                             begin
                                                 XMLDoc := TXMLDocument.Create(application);
                                                 NivelNo1 := '';
                                                 Nivelno2 := '';
                                                 Try
                                                   XMLDoc.XML.Clear;
                                                   try
                                                      XMLDoc.LoadFromFile(PChar(varTmp));
                                                      XMLDoc.Active := True;
                                                      Try
                                                         retEvento := XMLDoc.DocumentElement.ChildNodes.FindNode('retEvento');
                                                         infEvento := retEvento.ChildNodes.FindNode('infEvento');
                                                         NivelNo1  := infEvento.ChildNodes['xMotivo'].Text;
                                                         if NivelNo1 <> '' then
                                                         begin
                                                           bOthers        := False;
                                                           bPDF           := False;
                                                           bMoverNFE      := True;
                                                           PastadoCliente := CriarPastadoCliente('CCE', varXML);
                                                           PastaLIDO := sqlAUX.FieldByName('PastaNFE_LIDO').AsString;
                                                           Writeln(' XML-Outro Lido: ' +  PWideChar(PastaSERVIDORNFE_ENTRADA  + varXML));
                                                         end;
                                                      except
                                                           try
                                                              infEvento := retEvento.ChildNodes.FindNode('retEnvEvento');
                                                              Nivelno2 := infEvento.ChildNodes['xMotivo'].Text;
                                                              if Nivelno2 <> '' then
                                                              begin
                                                                bPDF           := False;
                                                                bOthers        := False;
                                                                bMoverNFE      := True;
                                                                PastadoCliente := CriarPastadoCliente('CCE', varXML);
                                                                PastaLIDO := sqlAUX.FieldByName('PastaNFE_LIDO').AsString;
                                                                Writeln(' XML-Outro Lido: ' +  PWideChar(PastaSERVIDORNFE_ENTRADA  + varXML));
                                                              end;
                                                           except
                                                              Try
                                                                  Nivelno2 := '';
                                                                  retEvento     := XMLDoc.DocumentElement.ChildNodes.FindNode('evento');
                                                                  infEvento     := retEvento.ChildNodes.FindNode('envEvento');

                                                                  subinfEvento  := infEvento.ChildNodes.FindNode('evento');
                                                                  _subinfEvento := subinfEvento.ChildNodes.FindNode('infEvento');
                                                                  Nivelno2      := _subinfEvento.ChildNodes['CNPJ'].Text;
                                                                  if Nivelno2 <> '' then
                                                                  begin
                                                                    bPDF           := False;
                                                                    bOthers        := False;
                                                                    bMoverNFE      := True;
                                                                    PastadoCliente := CriarPastadoCliente('CCE', varXML);
                                                                    PastaLIDO := sqlAUX.FieldByName('PastaNFE_LIDO').AsString;
                                                                    Writeln(' XML-Outro Lido: ' +  PWideChar(PastaSERVIDORNFE_ENTRADA  + varXML));
                                                                  end;
                                                              except
                                                                  DB_Conect.doSaveLogImport(PastaLOG, 'Arquivo Inv�lido ' +  PWideChar(  PChar(varTmp) ));
                                                                  DeleteFile(PChar(varTmp));
                                                                  Continue;
                                                              End;
                                                           end;
                                                      End;

                                                   except
                                                     DB_Conect.doSaveLogImport(PastaLOG, 'Arquivo Inv�lido ' +  PWideChar(  PChar(varTmp) ));
                                                     DeleteFile(PChar(varTmp));
                                                     Continue;
                                                   end;
                                                 Finally
                                                    FreeAndNil(XMLDoc);
                                                 End;
                                             end;

                                         except

                                             on E: Exception do
                                                 begin
                                                  DB_Conect.doSaveLogImport(PastaLOG, E.Message);
                                                  Writeln( 'Erro: ', E.Message );
                                                  Continue;
                                                 end;
                                         End;

                                         TACBrCTe(ACBrCTe).Conhecimentos.Clear;
                                         TACBrNFe(ACBrNFe).NotasFiscais.Clear;

                                      Finally
                                        FreeAndNil(ACBrCTe);
                                        FreeAndNil(ACBrNFe);
                                      End;

                                  end;
                                end;

                                if bMoverCTE then
                                begin
                                    CopyFile( PChar(varTmp) , PWideChar(PastadoCliente  + varXML) , False);
                                    DeleteFile(varTmp);
                                    Writeln(' XML Lido: ' + PWideChar(PastadoCliente  + varXML));
                                end
                                else if bMoverNFE then
                                begin
                                   CopyFile( PChar(varTmp) , PWideChar(PastadoCliente  + varXML), False);
                                   DeleteFile(varTmp);
                                   Writeln(' XML Lido: ' +  PWideChar(PastadoCliente  + varXML));
                                end
                                else if bPDF then
                                begin
                                    CopyFile( PChar(varTmp) , PWideChar(PastaSERVIDORNFE_ENTRADA  + varXML), False);
                                    DeleteFile(varTmp);
                                    Writeln(' XML Lido: ' +  PWideChar(PastaSERVIDORNFE_ENTRADA  + varXML));
                                end;



                                if (PastaLIDO <> '') then
                                begin
                                   if  varIdIMAP41.UIDCopyMsg(TheUID, PastaLIDO )= True then
                                    begin
                                        if varIdIMAP41.UIDDeleteMsg(TheUID) = True then
                                        begin
                                            if varIdIMAP41.ExpungeMailBox = False then
                                              Writeln(' Sucesso em marcar a Mensagem como Deletada mas ela n�o foi eliminada');
                                        end else begin
                                              Writeln('Falha em Apagar Mensagem. Esta Past � Somente Leitura?');
                                        end;
                                    end;
                                end;
                             end;


                              if bPDF then
                              begin
                                if  varIdIMAP41.UIDCopyMsg(TheUID, PastaPDF )= True then
                                begin
                                    if varIdIMAP41.UIDDeleteMsg(TheUID) = True then
                                    begin
                                        if varIdIMAP41.ExpungeMailBox = False then
                                          Writeln(' Sucesso em marcar a Mensagem como Deletada mas ela n�o foi eliminada');
                                    end else begin
                                          Writeln('Falha em Apagar Mensagem. Esta Past � Somente Leitura?');
                                    end;
                                end;
                              end
                              else
                              if bOthers then
                              begin
                                if  varIdIMAP41.UIDCopyMsg(TheUID, PastaOthers )= True then
                                begin
                                    if varIdIMAP41.UIDDeleteMsg(TheUID) = True then
                                    begin
                                        if varIdIMAP41.ExpungeMailBox = False then
                                          Writeln(' Sucesso em marcar a Mensagem como Deletada mas ela n�o foi eliminada');
                                    end else begin
                                          Writeln('Falha em Apagar Mensagem. Esta Past � Somente Leitura?');
                                    end;
                                end;
                              end;

                              varMsgXml.Clear;
                          end;
                      end;
                  end;
              Finally
                  varIdIMAP41.Disconnect;
              end;
            except
            on E: Exception do
               begin
                  varIdIMAP41.Disconnect;
                  DB_Conect.doSaveLogImport(PastaLOG, E.Message);
                  Writeln( 'N�o foi possivel Conectar no Servidor de Email: ', E.Message );
                  Exit;

                end;
            End;

            sqlAUX.Next;
         end;
      end;

  Finally
     FreeAndNil(varSMTP);
     FreeAndNil(varSSL);
     FreeAndNil(varIdIMAP41);
     FreeAndNil(varMsgXml);
  End;

end;

procedure SalvarXMLNFE_CTE;
var
  lContinua                   : boolean;
  varTipoNota                 : smallint;
  i,x,n,y, T, J, IDENTITY_ID, IDENTITY_CTE_CAPA_ID, cct  : Integer;
  lPathSemProtocolo, lPathExistente,  varSQL : String;
  ACBrCTe                     : TACBrCTe;
  ACBrNFe                     : TACBrNFe;
  varSMTP                     : TStringList;
  lSQL                        : WideString;
  varFilialID                 : String;
  OrigemDaNota                : String;
  lArquivo, lArquivoImportado, pNovoCFOP : String;
  Listtemp3                    : TStringList;
begin
  varSMTP := TStringList.Create;
  Try
      varFolderSistema := ExtractFilePath(Application.ExeName);
    //  if not DirExists( IncludeTrailingPathDelimiter( varFolderSistema )  ) then
    //    varFolderSistema := 'T:\';

      // Carrega Pastas do XML
      {
      if TFile.Exists( varFolderSistema + 'MLParametros.ini' ) then
      begin

           varSMTP.LoadFromFile(varFolderSistema  + 'MLParametros.ini');
           PastaSERVIDORTEMP        := varSMTP.Values['PastaSERVIDORTEMP'];
           PastaSERVIDORNFE_ENTRADA := varSMTP.Values['PastaSERVIDORNFE_ENTRADA'];
           PastaSERVIDORCTE_ENTRADA := varSMTP.Values['PastaSERVIDORCTE_ENTRADA'];
           PastaSERVIDORNFE_LIDO    := varSMTP.Values['PastaSERVIDORNFE_LIDO'];
           PastaSERVIDORCTE_LIDO    := varSMTP.Values['PastaSERVIDORCTE_LIDO'];
           PastaLOG                 := varSMTP.Values['PastaLOG'];

           PastaSERVIDORNFE_ENTRADA := IncludeTrailingPathDelimiter( PastaSERVIDORNFE_ENTRADA );
           PastaSERVIDORCTE_ENTRADA := IncludeTrailingPathDelimiter( PastaSERVIDORCTE_ENTRADA );
           PastaSERVIDORNFE_LIDO    := IncludeTrailingPathDelimiter( PastaSERVIDORNFE_LIDO );
           PastaSERVIDORCTE_LIDO    := IncludeTrailingPathDelimiter( PastaSERVIDORCTE_LIDO );
           PastaLOG                 := IncludeTrailingPathDelimiter( PastaLOG );

      end
      else
      }
      if not DB_Conect.CarregaPastaXML then
      begin
         Writeln( varFolderSistema + 'MLParametros.ini' + 'Arquivo de Configura��o das Pastas.' );
         Exit;
      end;


      if Trim( varFolderSistema ) <> '' then
      begin
          if not DB_Conect.DirExists( varFolderSistema ) then
          begin
            lContinua := False;
            Writeln( 'DB_MLSistemas.ini - ' + pchar('Caminho ' + varFolderSistema + ' n�o encontrado!!!') );
          end
          else
          begin
            lContinua := True;
            if not DB_Conect.DirExists(  varFolderSistema  ) then
            begin
               if not CreateDir(  varFolderSistema ) then
                 lContinua := False;
            end;

            if not lContinua  then
            begin
               Writeln( 'DB_MLSistemas.ini - ' + pChar('Falha o verificar caminho ' + varFolderSistema) );
            end;
          end
      end;

      if lContinua then
      begin
          Try
          Writeln( 'Criando DataModule' );
          ACBrCTe := TACBrCTe.Create(Nil);
          ACBrNFe := TACBrNFe.Create(Nil);

          with DB_Conect do
          begin


              Writeln( 'Abrindo Conex�o' );
              SQLConnection.Open;
              I := 0;
              X := 0;
              //for y := 0 to 1 do
              //begin

                   Listtemp2               := TStringList.Create;
                   ListarArquivos(PastaRAIZ, '*.XML', true, true);
                   Try
                     Listtemp3               := TStringList.Create;
                     Listtemp3.Text          := Listtemp2.Text;
                     FreeAndNil(Listtemp2);
                     i := 0;

                     for i:= 0 to Listtemp3.Count - 1 do
                     begin

                        lArquivo          :=  Listtemp3.Strings[i];
                        Writeln( 'Lendo pasta: ' + lArquivo  );
                        TACBrCTe(ACBrCTe).Conhecimentos.Clear;
                        TACBrNFe(ACBrNFe).NotasFiscais.Clear;
                        varTipoNota := -1;

                        if TACBrCTe(ACBrCTe).Conhecimentos.LoadFromFile(  lArquivo ) then
                        begin
                           varTipoNota := 0;
                           lArquivoImportado := 'C:\MLSISTEMAS_LIDOS\'  + StrTran(ExtractFilePath( Listtemp3.Strings[i]), PastaRAIZ, '');
                           if not DirExists(  lArquivoImportado ) then
                           begin
                             if not ForceDirectories(  lArquivoImportado ) then
                               Exit;
                           end;
                          lArquivoImportado := lArquivoImportado  + ExtractFileName(lArquivo);
                        end;

                        if  TACBrNFe(ACBrNFe).NotasFiscais.LoadFromFile(  lArquivo ) Then
                        begin
                           varTipoNota := 1;
                           lArquivoImportado := 'C:\MLSISTEMAS_LIDOS\'  + StrTran(ExtractFilePath( Listtemp3.Strings[i]), PastaRAIZ, '');
                           if not DirExists(  lArquivoImportado ) then
                           begin
                             if not ForceDirectories(  lArquivoImportado ) then
                               Exit;
                           end;
                           lArquivoImportado := lArquivoImportado  + ExtractFileName(lArquivo);
                        end;


                        if (varTipoNota = 0) then
                        begin
                          try
                             with TACBrCTe(ACBrCTe).Conhecimentos.Items[n].CTe do
                             begin

                                if procCTe.nProt = '' then
                                begin
                                   Writeln( 'Sem Protocolo: ' + lArquivo  );
                                   MoveFile( PWideChar( lArquivo) , PWideChar( lArquivoImportado ) );
                                   DB_Conect.doSaveLogImport(PastaLOG, 'Sem Protocolo ' +  PWideChar( ExtractFileName(lArquivoImportado) ));
                                   varTipoNota := -2;
                                   Inc(X);
                                   Continue;
                                end;

                                with FD_Consulta_EntregaXML do
                                begin
                                  Close;
                                  SQL.Clear;
                                  SQL.Add(' SELECT cCT FROM XML_IMPORTADA  ');
                                  SQL.Add(' WHERE cCT  = :cCT ');
                                  SQL.Add(' and DataEmissao  = :DataEmissao ');
                                  SQL.Add(' and nCT = :nCT ');
                                  SQL.Add(' and CHCTE = :CHCTE ');
                                  SQL.Add(' and TipoXML = :TipoXML ');
                                  ParamByName('cCT').asInteger               := ide.cCT;
                                  ParamByName('DataEmissao').AsSQLTimeStamp  := DateTimeToSQLTimeStamp(Ide.dhEmi);
                                  ParamByName('nCT').AsString             := IntToStr(Ide.nCT);
                                  ParamByName('CHCTE').AsString              := procCTe.chCTe;
                                  ParamByName('TipoXML').AsString            := 'CTE';
                                  Open;
                                end;


                                if not FD_Consulta_EntregaXML.IsEmpty then
                                begin
                                   Writeln( 'Existente: ' + lArquivo  );
                                   MoveFile( PWideChar(  lArquivo ) , PWideChar( lArquivoImportado ) );
                                   DB_Conect.doSaveLogImport(PastaLOG, 'Existente ' +  PWideChar(  ExtractFileName(lArquivoImportado) ));
                                   varTipoNota := -2;
                                   Inc(X);
                                   Continue;
                                end;


                                if FD_Consulta_EntregaXML.IsEmpty then
                                begin

                                    lSQL := ' INSERT INTO CTE_PROTOCOLO (';
                                    lSQL := lSQL + ' ID,  ';
                                    lSQL := lSQL + ' tpAmb, ';
                                    lSQL := lSQL + ' verAplic, ';
                                    lSQL := lSQL + ' chCTe, ';
                                    lSQL := lSQL + ' dhRecbto, ';
                                    lSQL := lSQL + ' nProt,  ';
                                    lSQL := lSQL + ' digVal, ';
                                    lSQL := lSQL + ' cStat, ';
                                    lSQL := lSQL + ' xMotivo, ';
                                    lSQL := lSQL + ' nCT, ';
                                    lSQL := lSQL + ' cCT ';
                                    lSQL := lSQL + ' ) VALUES  ( ';
                                    lSQL := lSQL + ' :ID,  ';
                                    lSQL := lSQL + ' :tpAmb, ';
                                    lSQL := lSQL + ' :verAplic, ';
                                    lSQL := lSQL + ' :chCTe, ';
                                    lSQL := lSQL + ' :dhRecbto, ';
                                    lSQL := lSQL + ' :nProt,  ';
                                    lSQL := lSQL + ' :digVal, ';
                                    lSQL := lSQL + ' :cStat, ';
                                    lSQL := lSQL + ' :xMotivo, ';
                                    lSQL := lSQL + ' :nCT, ';
                                    lSQL := lSQL + ' :cCT) ';


                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );


                                    FD_Insert_EntregaXML.ParamByName('ID').AsString                        := infCTe.ID;
                                    FD_Insert_EntregaXML.ParamByName('tpAmb').AsString                     := TpAmbToStr(procCTe.tpAmb);
                                    FD_Insert_EntregaXML.ParamByName('verAplic').AsString                  := procCTe.verAplic;
                                    FD_Insert_EntregaXML.ParamByName('chCTe').AsString                     := procCTe.chCTe;
                                    FD_Insert_EntregaXML.ParamByName('dhRecbto').AsSQLTimeStamp            := DateTimeToSQLTimeStamp(procCTe.dhRecbto);
                                    FD_Insert_EntregaXML.ParamByName('nProt').AsString                     := procCTe.nProt;
                                    FD_Insert_EntregaXML.ParamByName('digVal').AsString                    := procCTe.digVal;
                                    FD_Insert_EntregaXML.ParamByName('cStat').AsString                     := IntToStr(procCTe.cStat);
                                    FD_Insert_EntregaXML.ParamByName('xMotivo').AsString                   := procCTe.xMotivo;
                                    FD_Insert_EntregaXML.ParamByName('nCT').AsString                       := IntToStr(ide.nCT);
                                    FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                      := ide.cCT;
                                    try
                                      FD_Insert_EntregaXML.ExecSQL;

                                    except
                                      On E:Exception do
                                        begin

                                          DB_Conect.doSaveLogImport(PastaLOG, lArquivo  + ' - Falha ao incluir CTE_PROTOCOLO.' + E.Message);
                                          Continue;
                                        end;
                                    end;

                                    FD_BuscaFilial.Close;
                                    FD_BuscaFilial.SQL.Clear;
                                    FD_BuscaFilial.SQL.Add('Select CTE_FILIAL_ID from cte_filial where cnpj = :cnpj');
                                    FD_BuscaFilial.ParamByName('cnpj').AsString := Emit.CNPJ;
                                    FD_BuscaFilial.Open;

                                    if FD_BuscaFilial.IsEmpty then
                                    begin
                                          FD_BuscaFilial.Close;
                                          FD_BuscaFilial.SQL.Clear;
                                          FD_BuscaFilial.SQL.Add('Select CTE_FILIAL_ID from cte_filial where cnpj = :cnpj');
                                          FD_BuscaFilial.ParamByName('cnpj').AsString := dest.CNPJCPF;
                                          FD_BuscaFilial.Open;
                                          if FD_BuscaFilial.IsEmpty then
                                          begin
                                            DB_Conect.doSaveLogImport(PastaLOG, lArquivo  + ' - NF Entrada - Filial N�o Cadastrada');
                                            Continue;
                                          end;
                                    end;

                                     varFilialID :=  FD_BuscaFilial.FieldByName('CTE_FILIAL_ID').AsString;


                                    lSQL := ' INSERT INTO CTE_CAPA (';
                                    lSQL := lSQL + ' CTE_FILIAL_ID ';
                                    lSQL := lSQL + ' ,cUF ';
                                    lSQL := lSQL + ' ,cCT';
                                    lSQL := lSQL + ' ,CFOP';
                                    lSQL := lSQL + ' ,natOp';
                                    lSQL := lSQL + ' ,forPag';
                                    lSQL := lSQL + ' ,mod_';
                                    lSQL := lSQL + ' ,serie';
                                    lSQL := lSQL + ' ,nCT';
                                    lSQL := lSQL + ' ,dhEmi';
                                    lSQL := lSQL + ' ,tpImp';
                                    lSQL := lSQL + ' ,tpEmis';
                                    lSQL := lSQL + ' ,cDV';
                                    lSQL := lSQL + ' ,tpAmb';
                                    lSQL := lSQL + ' ,tpCTe';
                                    lSQL := lSQL + ' ,procEmi';
                                    lSQL := lSQL + ' ,verProc';
                                    lSQL := lSQL + ' ,cMunEnv';
                                    lSQL := lSQL + ' ,xMunEnv';
                                    lSQL := lSQL + ' ,UFEnv';
                                    lSQL := lSQL + ' ,modal';
                                    lSQL := lSQL + ' ,tpServ';
                                    lSQL := lSQL + ' ,cMunIni';
                                    lSQL := lSQL + ' ,xMunIni';
                                    lSQL := lSQL + ' ,UFIni';
                                    lSQL := lSQL + ' ,cMunFim';
                                    lSQL := lSQL + ' ,xMunFim';
                                    lSQL := lSQL + ' ,UFFim';
                                    lSQL := lSQL + ' ,retira';
                                    lSQL := lSQL + ' ,toma03';
                                    lSQL := lSQL + ' ,xCaracAd';
                                    lSQL := lSQL + ' ,xCaracSer';
                                    lSQL := lSQL + ' ,xEmi';
                                    lSQL := lSQL + ' ,xOrig';
                                    lSQL := lSQL + ' ,xDest';
                                    lSQL := lSQL + ' ,tpPer';
                                    lSQL := lSQL + ' ,dProg';
                                    lSQL := lSQL + ' ,tpHor';
                                    lSQL := lSQL + ' ,hProg';
                                    lSQL := lSQL + ' ,xObs)';
                                    lSQL := lSQL + ' VALUES ';
                                    lSQL := lSQL + ' ( :CTE_FILIAL_ID,';
                                    lSQL := lSQL + '  :cUF,';
                                    lSQL := lSQL + '  :cCT, ';
                                    lSQL := lSQL + '  :CFOP, ';
                                    lSQL := lSQL + '  :natOp, ';
                                    lSQL := lSQL + '  :forPag, ';
                                    lSQL := lSQL + '  :mod_, ';
                                    lSQL := lSQL + '  :serie, ';
                                    lSQL := lSQL + '  :nCT, ';
                                    lSQL := lSQL + '  :dhEmi, ';
                                    lSQL := lSQL + '  :tpImp, ';
                                    lSQL := lSQL + '  :tpEmis, ';
                                    lSQL := lSQL + '  :cDV, ';
                                    lSQL := lSQL + '  :tpAmb, ';
                                    lSQL := lSQL + '  :tpCTe, ';
                                    lSQL := lSQL + '  :procEmi, ';
                                    lSQL := lSQL + '  :verProc, ';
                                    lSQL := lSQL + '  :cMunEnv, ';
                                    lSQL := lSQL + '  :xMunEnv,';
                                    lSQL := lSQL + '  :UFEnv, ';
                                    lSQL := lSQL + '  :modal, ';
                                    lSQL := lSQL + '  :tpServ, ';
                                    lSQL := lSQL + '  :cMunIni, ';
                                    lSQL := lSQL + '  :xMunIni, ';
                                    lSQL := lSQL + '  :UFIni, ';
                                    lSQL := lSQL + '  :cMunFim, ';
                                    lSQL := lSQL + '  :xMunFim, ';
                                    lSQL := lSQL + '  :UFFim, ';
                                    lSQL := lSQL + '  :retira, ';
                                    lSQL := lSQL + '  :toma03, ';
                                    lSQL := lSQL + '  :xCaracAd, ';
                                    lSQL := lSQL + '  :xCaracSer, ';
                                    lSQL := lSQL + '  :xEmi, ';
                                    lSQL := lSQL + '  :xOrig, ';
                                    lSQL := lSQL + '  :xDest, ';
                                    lSQL := lSQL + '  :tpPer, ';
                                    lSQL := lSQL + '  :dProg, ';
                                    lSQL := lSQL + '  :tpHor, ';
                                    lSQL := lSQL + '  :hProg, ';
                                    lSQL := lSQL + '  :xObs) ';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    FD_Insert_EntregaXML.ParamByName('CTE_FILIAL_ID').AsString           := varFilialID;
                                    FD_Insert_EntregaXML.ParamByName('cUF').AsString                     := IntToStr(Ide.cUF);
                                    FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                    := ide.cCT;
                                    FD_Insert_EntregaXML.ParamByName('CFOP').AsString                    := IntToStr(ide.CFOP);
                                    FD_Insert_EntregaXML.ParamByName('natOp').AsString                   := ide.natOp;
                                    FD_Insert_EntregaXML.ParamByName('forPag').AsString                  := tpforPagToStr(ide.forPag);
                                    FD_Insert_EntregaXML.ParamByName('mod_').AsString                    := IntToStr(ide.modelo);
                                    FD_Insert_EntregaXML.ParamByName('serie').AsString                   := IntToStr(ide.serie);
                                    FD_Insert_EntregaXML.ParamByName('nCT').AsString                     := IntToStr(ide.nCT);
                                    FD_Insert_EntregaXML.ParamByName('dhEmi').AsSQLTimeStamp             := DateTimeToSQLTimeStamp(ide.dhEmi);
                                    FD_Insert_EntregaXML.ParamByName('tpImp').AsString                   := TpImpToStr(ide.tpImp);
                                    FD_Insert_EntregaXML.ParamByName('tpEmis').AsString                  := TpEmisToStr(ide.tpEmis);
                                    FD_Insert_EntregaXML.ParamByName('cDV').AsString                     := IntToStr(ide.cDV);
                                    FD_Insert_EntregaXML.ParamByName('tpAmb').AsString                   := TpAmbToStr(ide.tpAmb);
                                    FD_Insert_EntregaXML.ParamByName('tpCTe').AsString                   := tpCTToStr(ide.tpCTe);
                                    FD_Insert_EntregaXML.ParamByName('procEmi').AsString                 := procEmiToStr(ide.procEmi);
                                    FD_Insert_EntregaXML.ParamByName('verProc').AsString                 := ide.verProc;
                                    FD_Insert_EntregaXML.ParamByName('cMunEnv').AsString                 := InTToStr(ide.cMunEnv);
                                    FD_Insert_EntregaXML.ParamByName('xMunEnv').AsString                 := ide.xMunEnv;
                                    FD_Insert_EntregaXML.ParamByName('UFEnv').AsString                   := ide.UFEnv;
                                    FD_Insert_EntregaXML.ParamByName('modal').AsString                   := TpModalToStr(ide.modal);
                                    FD_Insert_EntregaXML.ParamByName('tpServ').AsString                  := TpServPagToStr(ide.tpServ);
                                    FD_Insert_EntregaXML.ParamByName('cMunIni').AsInteger                := ide.cMunIni;
                                    FD_Insert_EntregaXML.ParamByName('xMunIni').AsString                 := ide.xMunIni;
                                    FD_Insert_EntregaXML.ParamByName('UFIni').AsString                   := ide.UFIni;
                                    FD_Insert_EntregaXML.ParamByName('cMunFim').AsInteger                := ide.cMunFim;
                                    FD_Insert_EntregaXML.ParamByName('xMunFim').AsString                 := ide.xMunFim;
                                    FD_Insert_EntregaXML.ParamByName('UFFim').AsString                   := ide.UFFim;
                                    FD_Insert_EntregaXML.ParamByName('retira').AsString                  := TpRetiraPagToStr(ide.retira);
                                    FD_Insert_EntregaXML.ParamByName('toma03').AsString                  := TpTomadorToStr(ide.toma03.Toma);
                                    FD_Insert_EntregaXML.ParamByName('xCaracAd').AsString                := compl.xCaracAd ;
                                    FD_Insert_EntregaXML.ParamByName('xCaracSer').AsString               := compl.xCaracSer;
                                    FD_Insert_EntregaXML.ParamByName('xEmi').AsString                    := compl.xEmi;
                                    FD_Insert_EntregaXML.ParamByName('xOrig').AsString                   := compl.fluxo.xOrig;
                                    FD_Insert_EntregaXML.ParamByName('xDest').AsString                   := compl.fluxo.xDest;
                                    FD_Insert_EntregaXML.ParamByName('tpPer').AsString                   := TpDataPeriodoToStr(compl.Entrega.comData.tpPer);
                                    FD_Insert_EntregaXML.ParamByName('dProg').AsSQLTimeStamp             := DateTimeToSQLTimeStamp(compl.Entrega.comData.dProg);
                                    FD_Insert_EntregaXML.ParamByName('tpHor').AsString                   := TpHorarioIntervaloToStr(compl.Entrega.comHora.tpHor);
                                    FD_Insert_EntregaXML.ParamByName('hProg').AsSQLTimeStamp             := DateTimeToSQLTimeStamp(compl.Entrega.comHora.hProg);
                                    FD_Insert_EntregaXML.ParamByName('xObs').AsString                    := compl.xObs;


                                    try
                                      FD_Insert_EntregaXML.ExecSQL;

                                    except
                                      On E:Exception do
                                        begin

                                          DB_Conect.doSaveLogImport(PastaLOG, lArquivo + #13#10 + 'Falha ao incluir CTE_CAPA.' + E.Message);
                                          Continue;
                                        end;
                                    end;

                                    IDENTITY_CTE_CAPA_ID := 0;
                                    Try
                                      varSQL  := 'SELECT @@IDENTITY as CTE_CAPA_ID ';

                                      FD_Insert_EntregaXML.Close;
                                      FD_Insert_EntregaXML.SQL.Clear;
                                      FD_Insert_EntregaXML.SQL.Add( varSQL );
                                      FD_Insert_EntregaXML.Open;
                                      IDENTITY_CTE_CAPA_ID := FD_Insert_EntregaXML.FieldByName('CTE_CAPA_ID').AsInteger;

                                    except
                                      On E:Exception do
                                        begin
                                           Writeln( 'Falha ao pegar Chave CTE_CAPA_ID.: ' +  PWideChar(  lArquivo ) );
                                           DB_Conect.doSaveLogImport(PastaLOG, GetComando(FD_Insert_EntregaXML) + #13#10 + 'Falha ao pegar chave da CTE_CAPA_ID.' + E.Message);
                                           Continue;
                                         end;
                                    end;


                                    lSQL := ' INSERT INTO [dbo].[CTE_OBSCONT]( ';
                                    lSQL := lSQL + ' cCT ';
                                    lSQL := lSQL + ',CTE_CAPA_ID ';
                                    lSQL := lSQL + ',xCampo';
                                    lSQL := lSQL + ',xTexto)';
                                    lSQL := lSQL + ' Values (';
                                    lSQL := lSQL + ' :cCT ';
                                    lSQL := lSQL + ',:CTE_CAPA_ID ';
                                    lSQL := lSQL + ',:xCampo';
                                    lSQL := lSQL + ',:xTexto)';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    for T := 0 to compl.ObsCont.Count-1 do
                                    begin
                                      with compl.ObsCont[T] do
                                      begin
                                         FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                    := ide.cCT;
                                         FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                         FD_Insert_EntregaXML.ParamByName('xCampo').AsString                  := compl.ObsCont[T].xCampo;
                                         FD_Insert_EntregaXML.ParamByName('xTexto').AsString                  := compl.ObsCont[T].xTexto;
                                      end;

                                      try
                                        FD_Insert_EntregaXML.ExecSQL;

                                      except
                                        On E:Exception do
                                          begin

                                            DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_OBSCONT.' + E.Message);
                                            Continue;
                                          end;
                                      end;
                                    end;

                                    RetornarCodigoFornecedorCTE(Emit,IntToStr(ide.cCT));

                                    RetornarCodigoDestinatarioCTE(Dest,IntToStr(ide.cCT));


                                    Try

                                       lSQL  := 'UPDATE CTE_CAPA SET CODFORNECEDOR = :CODFORNECEDOR, CODDESTINATARIO = :CODDESTINATARIO WHERE CTE_CAPA_ID = :CTE_CAPA_ID';

                                       FD_Insert_EntregaXML.Close;
                                       FD_Insert_EntregaXML.SQL.Clear;
                                       FD_Insert_EntregaXML.SQL.Add( lSQL );
                                       FD_Insert_EntregaXML.ParamByName('CODFORNECEDOR').AsString   := tpRetornoEmitente.trCodigo;
                                       FD_Insert_EntregaXML.ParamByName('CODDESTINATARIO').AsString := tpRetornoDestinatario.trCodigo;

                                       FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger   := IDENTITY_CTE_CAPA_ID;
                                       FD_Insert_EntregaXML.ExecSQL;

                                    except
                                      On E:Exception do
                                        begin
                                           DB_Conect.doSaveLogImport(PastaLOG, Db_Conect.GetComando(FD_Insert_EntregaXML) + #13#10 + 'Falha ao pegar chave da CTE_EMITENTE_ID.' + E.Message);
                                           Continue;
                                         end;
                                    end;
                                    {
                                    lSQL := ' INSERT INTO [dbo].[CTE_EMITENTE]( ';
                                    lSQL := lSQL + ' cCT ';
                                    lSQL := lSQL + ',CTE_CAPA_ID ';
                                    lSQL := lSQL + ',CNPJCPF';
                                    lSQL := lSQL + ',IE';
                                    lSQL := lSQL + ',IEST';
                                    lSQL := lSQL + ',xNome';
                                    lSQL := lSQL + ',xFant';
                                    lSQL := lSQL + ',Fone';
                                    lSQL := lSQL + ',xCpl';
                                    lSQL := lSQL + ',xLgr';
                                    lSQL := lSQL + ',nro';
                                    lSQL := lSQL + ',xBairro';
                                    lSQL := lSQL + ',cMun';
                                    lSQL := lSQL + ',xMun';
                                    lSQL := lSQL + ',CEP';
                                    lSQL := lSQL + ',UF)';
                                    lSQL := lSQL + ' VALUES ( ' ;
                                    lSQL := lSQL + ':cCT ';
                                    lSQL := lSQL + ',:CTE_CAPA_ID ';
                                    lSQL := lSQL +',:CNPJCPF ';
                                    lSQL := lSQL +',:IE ';
                                    lSQL := lSQL +',:IEST ';
                                    lSQL := lSQL +',:xNome ';
                                    lSQL := lSQL +',:xFant ';
                                    lSQL := lSQL +',:Fone ';
                                    lSQL := lSQL +',:xCpl ';
                                    lSQL := lSQL +',:xLgr ';
                                    lSQL := lSQL +',:nro ';
                                    lSQL := lSQL +',:xBairro ';
                                    lSQL := lSQL +',:cMun';
                                    lSQL := lSQL +',:xMun';
                                    lSQL := lSQL +',:CEP';
                                    lSQL := lSQL +',:UF)';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                    := ide.cCT;
                                    FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                    FD_Insert_EntregaXML.ParamByName('CNPJCPF').AsString                 := Emit.CNPJ;
                                    FD_Insert_EntregaXML.ParamByName('IE').AsString                      := Emit.IE;
                                    FD_Insert_EntregaXML.ParamByName('IEST').AsString                    := Emit.IEST;
                                    FD_Insert_EntregaXML.ParamByName('xNome').AsString                   := Emit.xNome;
                                    FD_Insert_EntregaXML.ParamByName('xFant').AsString                   := Emit.xFant;
                                    FD_Insert_EntregaXML.ParamByName('Fone').AsString                    := Emit.EnderEmit.fone;
                                    FD_Insert_EntregaXML.ParamByName('xCpl').AsString                    := Emit.EnderEmit.xCpl;
                                    FD_Insert_EntregaXML.ParamByName('xLgr').AsString                    := Emit.EnderEmit.xLgr;
                                    FD_Insert_EntregaXML.ParamByName('nro').AsString                     := Emit.EnderEmit.nro;
                                    FD_Insert_EntregaXML.ParamByName('xBairro').AsString                 := Emit.EnderEmit.xBairro;
                                    FD_Insert_EntregaXML.ParamByName('cMun').AsString                    := IntToStr(Emit.EnderEmit.cMun);
                                    FD_Insert_EntregaXML.ParamByName('xMun').AsString                    := Emit.EnderEmit.xMun;

                                    FD_Insert_EntregaXML.ParamByName('CEP').AsString                     := IntToStr(Emit.EnderEmit.CEP);
                                    FD_Insert_EntregaXML.ParamByName('UF').AsString                      := Emit.EnderEmit.UF;

                                    try
                                      FD_Insert_EntregaXML.ExecSQL;

                                    except
                                      On E:Exception do
                                        begin

                                          DB_Conect.doSaveLogImport(PastaLOG, pChar(sr.Name ) + #13#10 + 'Falha ao incluir CTE_EMITENTE.' + E.Message);
                                          Continue;
                                        end;
                                    end;
                                    }

                                    lSQL := 'INSERT INTO [dbo].[CTE_INFCTESUB]  ';
                                    lSQL := lSQL +'(cCT';
                                    lSQL := lSQL + ',CTE_CAPA_ID ';
                                    lSQL := lSQL +',CteChave';
                                    lSQL := lSQL +',RefCteAnu';
                                    lSQL := lSQL +',RefNfe';
                                    lSQL := lSQL +',CNPJCPF';
                                    lSQL := lSQL +',modelo';
                                    lSQL := lSQL +',serie';
                                    lSQL := lSQL +',subserie';
                                    lSQL := lSQL +',numero';
                                    lSQL := lSQL +',valor';
                                    lSQL := lSQL +',dEmi)';
                                    lSQL := lSQL +' VALUES (';
                                    lSQL := lSQL +' :cCT';
                                    lSQL := lSQL +',:CTE_CAPA_ID ';
                                    lSQL := lSQL +',:CteChave';
                                    lSQL := lSQL +',:RefCteAnu';
                                    lSQL := lSQL +',:RefNfe';
                                    lSQL := lSQL +',:CNPJCPF';
                                    lSQL := lSQL +',:modelo';
                                    lSQL := lSQL +',:serie';
                                    lSQL := lSQL +',:subserie';
                                    lSQL := lSQL +',:numero';
                                    lSQL := lSQL +',:valor';
                                    lSQL := lSQL +',:dEmi)';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    FD_Insert_EntregaXML.ParamByName('cCT').asInteger                     := ide.cCT;
                                    FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger             := IDENTITY_CTE_CAPA_ID;
                                    FD_Insert_EntregaXML.ParamByName('CteChave').asString                 := infCTeNorm.infCteSub.chCte;
                                    FD_Insert_EntregaXML.ParamByName('RefCteAnu').asString                := infCTeNorm.infCteSub.refCteAnu;
                                    FD_Insert_EntregaXML.ParamByName('RefNfe').asString                   := infCTeNorm.infCteSub.tomaICMS.refNFe;
                                    FD_Insert_EntregaXML.ParamByName('CNPJCPF').asString                  := infCTeNorm.infCteSub.tomaICMS.refNF.CNPJCPF;
                                    FD_Insert_EntregaXML.ParamByName('modelo').asString                   := infCTeNorm.infCteSub.tomaICMS.refNF.modelo;
                                    FD_Insert_EntregaXML.ParamByName('serie').AsInteger                   := infCTeNorm.infCteSub.tomaICMS.refNF.serie;
                                    FD_Insert_EntregaXML.ParamByName('subserie').AsInteger                := infCTeNorm.infCteSub.tomaICMS.refNF.subserie;
                                    FD_Insert_EntregaXML.ParamByName('numero').AsInteger                  := infCTeNorm.infCteSub.tomaICMS.refNF.nro;
                                    FD_Insert_EntregaXML.ParamByName('valor').AsFloat                     := infCTeNorm.infCteSub.tomaICMS.refNF.valor;
                                    FD_Insert_EntregaXML.ParamByName('dEmi').AsSQLTimeStamp               := DateTimeToSQLTimeStamp(infCTeNorm.infCteSub.tomaICMS.refNF.dEmi);

                                    try
                                      FD_Insert_EntregaXML.ExecSQL;

                                    except
                                      On E:Exception do
                                        begin

                                          DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_INFCTESUB.' + E.Message);
                                          Continue;
                                        end;
                                    end;



                                    lSQL := ' INSERT INTO [dbo].[CTE_INFServico]( ';
                                    lSQL := lSQL + ' cCT ';
                                    lSQL := lSQL + ',CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,xDescServ ';
                                    lSQL := lSQL + ' ,qCarga) ';
                                    lSQL := lSQL + '  Values ( ';
                                    lSQL := lSQL + ' :cCT ';
                                    lSQL := lSQL + ',:CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,:xDescServ ';
                                    lSQL := lSQL + ' ,:qCarga) ';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    FD_Insert_EntregaXML.ParamByName('cCT').asInteger                      := ide.cCT;
                                    FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger              := IDENTITY_CTE_CAPA_ID;
                                    FD_Insert_EntregaXML.ParamByName('xDescServ').asString                 := infCTeNorm.infServico.xDescServ;
                                    FD_Insert_EntregaXML.ParamByName('qCarga').AsFloat                     := infCTeNorm.infServico.qCarga;

                                    try
                                      FD_Insert_EntregaXML.ExecSQL;

                                    except
                                      On E:Exception do
                                        begin

                                          DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_INFServico.' + E.Message);
                                          Continue;
                                        end;
                                    end;
                                   {

                                    lSQL := ' INSERT INTO [dbo].[CTE_Destinatario]( ';
                                    lSQL := lSQL + ' cCT ';
                                    lSQL := lSQL + ',CTE_CAPA_ID ';
                                    lSQL := lSQL + ',CNPJ';
                                    lSQL := lSQL + ',IE';
                                 //   lSQL := lSQL + ',IEST';
                                    lSQL := lSQL + ',xNome';
                                //    lSQL := lSQL + ',xFant';
                                 //   lSQL := lSQL + ',Fone';
                                    lSQL := lSQL + ',xCpl';
                                    lSQL := lSQL + ',xLgr';
                                    lSQL := lSQL + ',nro';
                                    lSQL := lSQL + ',xBairro';
                                    lSQL := lSQL + ',cMun';
                                    lSQL := lSQL + ',xMun';
                                    lSQL := lSQL + ',CEP';
                                    lSQL := lSQL + ',UF)';
                                    lSQL := lSQL + ' VALUES ( ' ;
                                    lSQL := lSQL + ':cCT ';
                                    lSQL := lSQL + ',:CTE_CAPA_ID ';
                                    lSQL := lSQL +',:CNPJ ';
                                    lSQL := lSQL +',:IE ';
                               //     lSQL := lSQL +',:IEST ';
                                    lSQL := lSQL +',:xNome ';
                             //       lSQL := lSQL +',:xFant ';
                           //         lSQL := lSQL +',:Fone ';
                                    lSQL := lSQL +',:xCpl ';
                                    lSQL := lSQL +',:xLgr ';
                                    lSQL := lSQL +',:nro ';
                                    lSQL := lSQL +',:xBairro ';
                                    lSQL := lSQL +',:cMun';
                                    lSQL := lSQL +',:xMun';
                                    lSQL := lSQL +',:CEP';
                                    lSQL := lSQL +',:UF)';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                    := ide.cCT;
                                    FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                    FD_Insert_EntregaXML.ParamByName('CNPJ').AsString                    := Dest.CNPJCPF;
                                    FD_Insert_EntregaXML.ParamByName('IE').AsString                      := Dest.IE;
                                   // FD_Insert_EntregaXML.ParamByName('IEST').AsString                    := Dest.IEST;
                                    FD_Insert_EntregaXML.ParamByName('xNome').AsString                   := Dest.xNome;
                         //           FD_Insert_EntregaXML.ParamByName('xFant').AsString                   := Dest.xFant;
                         //           FD_Insert_EntregaXML.ParamByName('Fone').AsString                    := Dest.enderDest.fone;
                                    FD_Insert_EntregaXML.ParamByName('xCpl').AsString                    := Dest.enderDest.xCpl;
                                    FD_Insert_EntregaXML.ParamByName('xLgr').AsString                    := Dest.enderDest.xLgr;
                                    FD_Insert_EntregaXML.ParamByName('nro').AsString                     := Dest.enderDest.nro;
                                    FD_Insert_EntregaXML.ParamByName('xBairro').AsString                 := Dest.enderDest.xBairro;
                                    FD_Insert_EntregaXML.ParamByName('cMun').AsString                    := IntToStr(Dest.enderDest.cMun);
                                    FD_Insert_EntregaXML.ParamByName('xMun').AsString                    := Dest.enderDest.xMun;

                                    FD_Insert_EntregaXML.ParamByName('CEP').AsString                     := IntToStr(Dest.enderDest.CEP);
                                    FD_Insert_EntregaXML.ParamByName('UF').AsString                      := Dest.enderDest.UF;

                                    try
                                      FD_Insert_EntregaXML.ExecSQL;

                                    except
                                      On E:Exception do
                                        begin

                                          DB_Conect.doSaveLogImport(PastaLOG, pChar(sr.Name ) + #13#10 + 'Falha ao incluir CTE_Destinatario.' + E.Message);
                                          Continue;
                                        end;
                                    end;


                                     }
                                    lSQL := ' INSERT INTO [dbo].[CTE_Remetente]( ';
                                    lSQL := lSQL + ' cCT ';
                                    lSQL := lSQL + ',CTE_CAPA_ID ';
                                    lSQL := lSQL + ',CNPJ';
                                    lSQL := lSQL + ',IE';
                                 //   lSQL := lSQL + ',IEST';
                                    lSQL := lSQL + ',xNome';
                                //    lSQL := lSQL + ',xFant';
                                 //   lSQL := lSQL + ',Fone';
                                    lSQL := lSQL + ',xCpl';
                                    lSQL := lSQL + ',xLgr';
                                    lSQL := lSQL + ',nro';
                                    lSQL := lSQL + ',xBairro';
                                    lSQL := lSQL + ',cMun';
                                    lSQL := lSQL + ',xMun';
                                    lSQL := lSQL + ',CEP';
                                    lSQL := lSQL + ',UF';
                                    lSQL := lSQL + ',Email)';

                                    lSQL := lSQL + ' VALUES ( ' ;
                                    lSQL := lSQL + ':cCT ';
                                    lSQL := lSQL + ',:CTE_CAPA_ID ';
                                    lSQL := lSQL +',:CNPJ ';
                                    lSQL := lSQL +',:IE ';
                               //     lSQL := lSQL +',:IEST ';
                                    lSQL := lSQL +',:xNome ';
                             //       lSQL := lSQL +',:xFant ';
                           //         lSQL := lSQL +',:Fone ';
                                    lSQL := lSQL +',:xCpl ';
                                    lSQL := lSQL +',:xLgr ';
                                    lSQL := lSQL +',:nro ';
                                    lSQL := lSQL +',:xBairro ';
                                    lSQL := lSQL +',:cMun';
                                    lSQL := lSQL +',:xMun';
                                    lSQL := lSQL +',:CEP';
                                    lSQL := lSQL +',:UF';
                                    lSQL := lSQL +',:Email)';


                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );



                                    FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                    := ide.cCT;
                                    FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                    FD_Insert_EntregaXML.ParamByName('CNPJ').AsString                    := rem.CNPJCPF;
                                    FD_Insert_EntregaXML.ParamByName('IE').AsString                      := rem.IE;
                                   // FD_Insert_EntregaXML.ParamByName('IEST').AsString                    := Dest.IEST;
                                    FD_Insert_EntregaXML.ParamByName('xNome').AsString                   := rem.xNome;
                         //           FD_Insert_EntregaXML.ParamByName('xFant').AsString                   := Dest.xFant;
                         //           FD_Insert_EntregaXML.ParamByName('Fone').AsString                    := Dest.enderDest.fone;
                                    FD_Insert_EntregaXML.ParamByName('xCpl').AsString                    := rem.enderReme.xCpl;
                                    FD_Insert_EntregaXML.ParamByName('xLgr').AsString                    := rem.enderReme.xLgr;
                                    FD_Insert_EntregaXML.ParamByName('nro').AsString                     := rem.enderReme.nro;
                                    FD_Insert_EntregaXML.ParamByName('xBairro').AsString                 := rem.enderReme.xBairro;
                                    FD_Insert_EntregaXML.ParamByName('cMun').AsString                    := IntToStr(rem.enderReme.cMun);
                                    FD_Insert_EntregaXML.ParamByName('xMun').AsString                    := rem.enderReme.xMun;

                                    FD_Insert_EntregaXML.ParamByName('CEP').AsString                     := IntToStr(rem.enderReme.CEP);
                                    FD_Insert_EntregaXML.ParamByName('UF').AsString                      := rem.enderReme.UF;
                                    FD_Insert_EntregaXML.ParamByName('Email').AsString                   := rem.email;


                                    try
                                      FD_Insert_EntregaXML.ExecSQL;

                                    except
                                      On E:Exception do
                                        begin

                                          DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_Remetente.' + E.Message);
                                          Continue;
                                        end;
                                    end;

                                    lSQL := ' INSERT INTO [dbo].[CTE_Tomador]( ';
                                    lSQL := lSQL + ' cCT ';
                                    lSQL := lSQL + ',CTE_CAPA_ID ';
                                    lSQL := lSQL + ',CNPJ';
                                    lSQL := lSQL + ',IE';
                                 //   lSQL := lSQL + ',IEST';
                                    lSQL := lSQL + ',xNome';
                                    lSQL := lSQL + ',xFant';
                                    lSQL := lSQL + ',Fone';
                                    lSQL := lSQL + ',xCpl';
                                    lSQL := lSQL + ',xLgr';
                                    lSQL := lSQL + ',nro';
                                    lSQL := lSQL + ',xBairro';
                                    lSQL := lSQL + ',cMun';
                                    lSQL := lSQL + ',xMun';
                                    lSQL := lSQL + ',CEP';
                                    lSQL := lSQL + ',UF';
                                    lSQL := lSQL + ',Email)';

                                    lSQL := lSQL +' VALUES ( ' ;
                                    lSQL := lSQL +' :cCT ';
                                    lSQL := lSQL +',:CTE_CAPA_ID';
                                    lSQL := lSQL +',:CNPJ ';
                                    lSQL := lSQL +',:IE ';
                               //     lSQL := lSQL +',:IEST ';
                                    lSQL := lSQL +',:xNome ';
                                    lSQL := lSQL +',:xFant ';
                                    lSQL := lSQL +',:Fone ';
                                    lSQL := lSQL +',:xCpl ';
                                    lSQL := lSQL +',:xLgr ';
                                    lSQL := lSQL +',:nro ';
                                    lSQL := lSQL +',:xBairro ';
                                    lSQL := lSQL +',:cMun';
                                    lSQL := lSQL +',:xMun';
                                    lSQL := lSQL +',:CEP';
                                    lSQL := lSQL +',:UF';
                                    lSQL := lSQL +',:Email)';


                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    if (ide.toma03.Toma = tmRemetente) then
                                    begin

                                       FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                    := ide.cCT;
                                       FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                       FD_Insert_EntregaXML.ParamByName('CNPJ').AsString                    := rem.CNPJCPF;
                                       FD_Insert_EntregaXML.ParamByName('IE').AsString                      := rem.IE;
                                      // FD_Insert_EntregaXML.ParamByName('IEST').AsString                    := Dest.IEST;
                                       FD_Insert_EntregaXML.ParamByName('xNome').AsString                   := rem.xNome;
                                       FD_Insert_EntregaXML.ParamByName('xFant').AsString                   := rem.xFant;
                                       FD_Insert_EntregaXML.ParamByName('Fone').AsString                    := rem.fone;
                                       FD_Insert_EntregaXML.ParamByName('xCpl').AsString                    := rem.enderReme.xCpl;
                                       FD_Insert_EntregaXML.ParamByName('xLgr').AsString                    := rem.enderReme.xLgr;
                                       FD_Insert_EntregaXML.ParamByName('nro').AsString                     := rem.enderReme.nro;
                                       FD_Insert_EntregaXML.ParamByName('xBairro').AsString                 := rem.enderReme.xBairro;
                                       FD_Insert_EntregaXML.ParamByName('cMun').AsString                    := IntToStr(rem.enderReme.cMun);
                                       FD_Insert_EntregaXML.ParamByName('xMun').AsString                    := rem.enderReme.xMun;

                                       FD_Insert_EntregaXML.ParamByName('CEP').AsString                     := IntToStr(rem.enderReme.CEP);
                                       FD_Insert_EntregaXML.ParamByName('UF').AsString                      := rem.enderReme.UF;
                                       FD_Insert_EntregaXML.ParamByName('Email').AsString                   := rem.email;

                                    end
                                    else if (ide.toma03.Toma = tmExpedidor)  then
                                    begin
                                       FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                    := ide.cCT;
                                       FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                       FD_Insert_EntregaXML.ParamByName('CNPJ').AsString                    := emit.CNPJ;
                                       FD_Insert_EntregaXML.ParamByName('IE').AsString                      := emit.IE;
                                      // FD_Insert_EntregaXML.ParamByName('IEST').AsString                    := Dest.IEST;
                                       FD_Insert_EntregaXML.ParamByName('xNome').AsString                   := emit.xNome;
                                       FD_Insert_EntregaXML.ParamByName('xFant').AsString                   := emit.xFant;
                                       FD_Insert_EntregaXML.ParamByName('Fone').AsString                    := emit.enderEmit.fone;
                                       FD_Insert_EntregaXML.ParamByName('xCpl').AsString                    := emit.enderEmit.xCpl;
                                       FD_Insert_EntregaXML.ParamByName('xLgr').AsString                    := emit.enderEmit.xLgr;
                                       FD_Insert_EntregaXML.ParamByName('nro').AsString                     := emit.enderEmit.nro;
                                       FD_Insert_EntregaXML.ParamByName('xBairro').AsString                 := emit.enderEmit.xBairro;
                                       FD_Insert_EntregaXML.ParamByName('cMun').AsString                    := IntToStr(emit.enderEmit.cMun);
                                       FD_Insert_EntregaXML.ParamByName('xMun').AsString                    := emit.enderEmit.xMun;
                                       FD_Insert_EntregaXML.ParamByName('CEP').AsString                     := IntToStr(emit.enderEmit.CEP);
                                       FD_Insert_EntregaXML.ParamByName('UF').AsString                      := emit.enderEmit.UF;
                                       FD_Insert_EntregaXML.ParamByName('Email').AsString                   := '';

                                    end
                                    else if (ide.toma03.Toma = tmDestinatario)  then
                                    begin
                                       FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                    := ide.cCT;
                                       FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                       FD_Insert_EntregaXML.ParamByName('CNPJ').AsString                    := Dest.CNPJCPF;
                                       FD_Insert_EntregaXML.ParamByName('IE').AsString                      := Dest.IE;
                                    //   FD_Insert_EntregaXML.ParamByName('IEST').AsString                    := Dest.enderDest.
                                       FD_Insert_EntregaXML.ParamByName('xNome').AsString                   := Dest.xNome;
                                       FD_Insert_EntregaXML.ParamByName('xFant').AsString                   := Copy(Dest.xNome,1,40);
                                       FD_Insert_EntregaXML.ParamByName('Fone').AsString                    := Dest.fone;
                                       FD_Insert_EntregaXML.ParamByName('xCpl').AsString                    := Dest.enderDest.xCpl;
                                       FD_Insert_EntregaXML.ParamByName('xLgr').AsString                    := Dest.enderDest.xLgr;
                                       FD_Insert_EntregaXML.ParamByName('nro').AsString                     := Dest.enderDest.nro;
                                       FD_Insert_EntregaXML.ParamByName('xBairro').AsString                 := Dest.enderDest.xBairro;
                                       FD_Insert_EntregaXML.ParamByName('cMun').AsString                    := IntToStr(Dest.enderDest.cMun);
                                       FD_Insert_EntregaXML.ParamByName('xMun').AsString                    := Dest.enderDest.xMun;
                                       FD_Insert_EntregaXML.ParamByName('CEP').AsString                     := IntToStr(Dest.enderDest.CEP);
                                       FD_Insert_EntregaXML.ParamByName('UF').AsString                      := Dest.enderDest.UF;
                                       FD_Insert_EntregaXML.ParamByName('Email').AsString                   := Dest.email;

                                    end
                                    else if (ide.toma4.Toma = tmOutros) then
                                    begin
                                       FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                    := ide.cCT;
                                       FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                       FD_Insert_EntregaXML.ParamByName('CNPJ').AsString                    := ide.toma4.CNPJCPF;
                                       FD_Insert_EntregaXML.ParamByName('IE').AsString                      := ide.toma4.IE;
                                      // FD_Insert_EntregaXML.ParamByName('IEST').AsString                    := ide.toma4.IE;
                                       FD_Insert_EntregaXML.ParamByName('xNome').AsString                   := ide.toma4.xNome;
                                       FD_Insert_EntregaXML.ParamByName('xFant').AsString                   := ide.toma4.xFant;
                                       FD_Insert_EntregaXML.ParamByName('Fone').AsString                    := ide.toma4.fone;
                                       FD_Insert_EntregaXML.ParamByName('xCpl').AsString                    := ide.toma4.enderToma.xCpl;
                                       FD_Insert_EntregaXML.ParamByName('xLgr').AsString                    := ide.toma4.enderToma.xLgr;
                                       FD_Insert_EntregaXML.ParamByName('nro').AsString                     := ide.toma4.enderToma.nro;
                                       FD_Insert_EntregaXML.ParamByName('xBairro').AsString                 := ide.toma4.enderToma.xBairro;
                                       FD_Insert_EntregaXML.ParamByName('cMun').AsString                    := IntToStr(ide.toma4.enderToma.cMun);
                                       FD_Insert_EntregaXML.ParamByName('xMun').AsString                    := ide.toma4.enderToma.xMun;
                                       FD_Insert_EntregaXML.ParamByName('CEP').AsString                     := IntToStr(ide.toma4.enderToma.CEP);
                                       FD_Insert_EntregaXML.ParamByName('UF').AsString                      := ide.toma4.enderToma.UF;
                                       FD_Insert_EntregaXML.ParamByName('Email').AsString                   := ide.toma4.email;

                                    end;

                                    try
                                      FD_Insert_EntregaXML.ExecSQL;

                                    except
                                      On E:Exception do
                                        begin

                                          DB_Conect.doSaveLogImport(PastaLOG, GetComando(FD_Insert_EntregaXML) + #13#10 + 'Falha ao incluir CTE_Tomador.' + E.Message);
                                          Continue;
                                        end;
                                    end;

                                    lSQL := ' INSERT INTO [dbo].[CTE_VPrest]( ';
                                    lSQL := lSQL + ' cCT ';
                                    lSQL := lSQL + ',CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,vTPrest ';
                                    lSQL := lSQL + ' ,vRec )';
                                    lSQL := lSQL + ' Values (';
                                    lSQL := lSQL + ' :cCT ';
                                    lSQL := lSQL + ',:CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,:vTPrest ';
                                    lSQL := lSQL + ' ,:vRec )';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                    := ide.cCT;
                                    FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                    FD_Insert_EntregaXML.ParamByName('vTPrest').asFloat                  := vPrest.vTPrest;
                                    FD_Insert_EntregaXML.ParamByName('vRec').asFloat                     := vPrest.vRec;

                                    try
                                      FD_Insert_EntregaXML.ExecSQL;

                                    except
                                      On E:Exception do
                                        begin

                                          DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_VPrest.' + E.Message);
                                          Continue;
                                        end;
                                    end;

                                    lSQL := ' INSERT INTO [dbo].[CTE_COMP_VALORES]( ';
                                    lSQL := lSQL + ' cCT ';
                                    lSQL := lSQL + ' ,CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,Nome ';
                                    lSQL := lSQL + ' ,Valor )';
                                    lSQL := lSQL + ' Values (';
                                    lSQL := lSQL + ' :cCT ';
                                    lSQL := lSQL + ',:CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,:Nome ';
                                    lSQL := lSQL + ' ,:Valor )';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    for T := 0 to vPrest.Comp.Count-1 do
                                    begin
                                      with vPrest.Comp[T] do
                                      begin
                                        FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                     := ide.cCT;
                                        FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                        FD_Insert_EntregaXML.ParamByName('Nome').asString                     := vPrest.Comp[T].xNome;
                                        FD_Insert_EntregaXML.ParamByName('Valor').asFloat                     := vPrest.Comp[T].vComp;

                                        try
                                          FD_Insert_EntregaXML.ExecSQL;

                                        except
                                          On E:Exception do
                                            begin

                                              DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_COMP_VALORES.' + E.Message);
                                              Continue;
                                            end;
                                        end;
                                      end;
                                    end;


                                    lSQL := ' INSERT INTO [dbo].[CTE_IMPOSTOS]( ';
                                    lSQL := lSQL + ' cCT';
                                    lSQL := lSQL + ' ,CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,SituTrib';
                                    lSQL := lSQL + ' ,CST';
                                    lSQL := lSQL + ' ,pRedBC';
                                    lSQL := lSQL + ' ,vBC';
                                    lSQL := lSQL + ' ,pICMS';
                                    lSQL := lSQL + ' ,vICMS';
                                    lSQL := lSQL + ' ,vCred';
                                    lSQL := lSQL + ' ,infAdFisco';
                                    lSQL := lSQL + ' ,vTotTrib';
                                    lSQL := lSQL + ' ,vPIS';
                                    lSQL := lSQL + ' ,vCOFINS';
                                    lSQL := lSQL + ' ,vIR';
                                    lSQL := lSQL + ' ,vINSS';
                                    lSQL := lSQL + ' ,vCSLL';
                                    lSQL := lSQL + ' ,CFOP)';
                                    lSQL := lSQL + ' Values (';
                                    lSQL := lSQL + ' :cCT';
                                    lSQL := lSQL + ',:CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,:SituTrib';
                                    lSQL := lSQL + ' ,:CST';
                                    lSQL := lSQL + ' ,:pRedBC';
                                    lSQL := lSQL + ' ,:vBC';
                                    lSQL := lSQL + ' ,:pICMS';
                                    lSQL := lSQL + ' ,:vICMS';
                                    lSQL := lSQL + ' ,:vCred';
                                    lSQL := lSQL + ' ,:infAdFisco';
                                    lSQL := lSQL + ' ,:vTotTrib';
                                    lSQL := lSQL + ' ,:vPIS';
                                    lSQL := lSQL + ' ,:vCOFINS';
                                    lSQL := lSQL + ' ,:vIR';
                                    lSQL := lSQL + ' ,:vINSS';
                                    lSQL := lSQL + ' ,:vCSLL';
                                    lSQL := lSQL + ' ,:CFOP)';


                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                     := ide.cCT;
                                    FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;

                                    Case  TpcnCSTIcms(Imp.ICMS.SituTrib) of
                                    cst00: begin
                                           FD_Insert_EntregaXML.ParamByName('SituTrib').asString                 := CSTICMSToStr(cst00);
                                           FD_Insert_EntregaXML.ParamByName('CST').asString                      := CSTICMSToStr(Imp.ICMS.ICMS00.CST);
                                           FD_Insert_EntregaXML.ParamByName('pRedBC').AsFloat                    := 0;
                                           FD_Insert_EntregaXML.ParamByName('vBC').AsFloat                       := Imp.ICMS.ICMS00.vBC;
                                           FD_Insert_EntregaXML.ParamByName('pICMS').AsFloat                     := Imp.ICMS.ICMS00.pICMS;
                                           FD_Insert_EntregaXML.ParamByName('vICMS').AsFloat                     := Imp.ICMS.ICMS00.vICMS;
                                           FD_Insert_EntregaXML.ParamByName('vCred').AsFloat                     := 0;
                                        end;
                                    cst20: begin
                                           FD_Insert_EntregaXML.ParamByName('SituTrib').asString                 := CSTICMSToStr(cst20);
                                           FD_Insert_EntregaXML.ParamByName('CST').asString                      := CSTICMSToStr(Imp.ICMS.ICMS20.CST);
                                           FD_Insert_EntregaXML.ParamByName('pRedBC').AsFloat                    := Imp.ICMS.ICMS20.pRedBC;
                                           FD_Insert_EntregaXML.ParamByName('vBC').AsFloat                       := Imp.ICMS.ICMS20.vBC;
                                           FD_Insert_EntregaXML.ParamByName('pICMS').AsFloat                     := Imp.ICMS.ICMS20.pICMS;
                                           FD_Insert_EntregaXML.ParamByName('vICMS').AsFloat                     := Imp.ICMS.ICMS20.vICMS;
                                           FD_Insert_EntregaXML.ParamByName('vCred').AsFloat                     := 0;
                                        end;
                                    cst40: begin
                                           FD_Insert_EntregaXML.ParamByName('SituTrib').asString                 := CSTICMSToStr(cst40);
                                           FD_Insert_EntregaXML.ParamByName('CST').asString                      := CSTICMSToStr(Imp.ICMS.ICMS45.CST);
                                           FD_Insert_EntregaXML.ParamByName('pRedBC').AsFloat                    := 0;
                                           FD_Insert_EntregaXML.ParamByName('vBC').AsFloat                       := 0;
                                           FD_Insert_EntregaXML.ParamByName('pICMS').AsFloat                     := 0;
                                           FD_Insert_EntregaXML.ParamByName('vICMS').AsFloat                     := 0;
                                           FD_Insert_EntregaXML.ParamByName('vCred').AsFloat                     := 0;
                                        end;
                                    cst41: begin
                                           FD_Insert_EntregaXML.ParamByName('SituTrib').asString                 := CSTICMSToStr(cst41);
                                           FD_Insert_EntregaXML.ParamByName('CST').asString                      := CSTICMSToStr(Imp.ICMS.ICMS45.CST);
                                           FD_Insert_EntregaXML.ParamByName('pRedBC').AsFloat                    := 0;
                                           FD_Insert_EntregaXML.ParamByName('vBC').AsFloat                       := 0;
                                           FD_Insert_EntregaXML.ParamByName('pICMS').AsFloat                     := 0;
                                           FD_Insert_EntregaXML.ParamByName('vICMS').AsFloat                     := 0;
                                           FD_Insert_EntregaXML.ParamByName('vCred').AsFloat                     := 0;
                                        end;
                                    cst51: begin
                                           FD_Insert_EntregaXML.ParamByName('SituTrib').asString                 := CSTICMSToStr(cst51);
                                           FD_Insert_EntregaXML.ParamByName('CST').asString                      := CSTICMSToStr(Imp.ICMS.ICMS45.CST);
                                           FD_Insert_EntregaXML.ParamByName('pRedBC').AsFloat                    := 0;
                                           FD_Insert_EntregaXML.ParamByName('vBC').AsFloat                       := 0;
                                           FD_Insert_EntregaXML.ParamByName('pICMS').AsFloat                     := 0;
                                           FD_Insert_EntregaXML.ParamByName('vICMS').AsFloat                     := 0;
                                           FD_Insert_EntregaXML.ParamByName('vCred').AsFloat                     := 0;
                                        end;
                                    cst60: begin
                                           FD_Insert_EntregaXML.ParamByName('SituTrib').asString                 := CSTICMSToStr(cst60);
                                           FD_Insert_EntregaXML.ParamByName('CST').asString                      := CSTICMSToStr(Imp.ICMS.ICMS60.CST);
                                           FD_Insert_EntregaXML.ParamByName('pRedBC').AsFloat                    := 0;
                                           FD_Insert_EntregaXML.ParamByName('vBC').AsFloat                       := imp.ICMS.ICMS60.vBCSTRet;
                                           FD_Insert_EntregaXML.ParamByName('pICMS').AsFloat                     := imp.ICMS.ICMS60.pICMSSTRet;
                                           FD_Insert_EntregaXML.ParamByName('vICMS').AsFloat                     := imp.ICMS.ICMS60.vICMSSTRet;
                                           FD_Insert_EntregaXML.ParamByName('vCred').AsFloat                     := imp.ICMS.ICMS60.vCred;

                                    end;
                                    cst80: begin
                                           FD_Insert_EntregaXML.ParamByName('SituTrib').asString                 := CSTICMSToStr(cst80);
                                           FD_Insert_EntregaXML.ParamByName('CST').asString                      := CSTICMSToStr(Imp.ICMS.ICMS90.CST);
                                           FD_Insert_EntregaXML.ParamByName('pRedBC').AsFloat                    := 0;
                                           FD_Insert_EntregaXML.ParamByName('vBC').AsFloat                       := 0;
                                           FD_Insert_EntregaXML.ParamByName('pICMS').AsFloat                     := 0;
                                           FD_Insert_EntregaXML.ParamByName('vICMS').AsFloat                     := 0;
                                           FD_Insert_EntregaXML.ParamByName('vCred').AsFloat                     := 0;
                                        end;
                                    cst81: begin
                                           FD_Insert_EntregaXML.ParamByName('SituTrib').asString                 := CSTICMSToStr(cst81);
                                           FD_Insert_EntregaXML.ParamByName('CST').asString                      := CSTICMSToStr(Imp.ICMS.ICMS90.CST);
                                           FD_Insert_EntregaXML.ParamByName('pRedBC').AsFloat                    := 0;
                                           FD_Insert_EntregaXML.ParamByName('vBC').AsFloat                       := 0;
                                           FD_Insert_EntregaXML.ParamByName('pICMS').AsFloat                     := 0;
                                           FD_Insert_EntregaXML.ParamByName('vICMS').AsFloat                     := 0;
                                           FD_Insert_EntregaXML.ParamByName('vCred').AsFloat                     := 0;
                                        end;
                                    cst90: begin
                                           FD_Insert_EntregaXML.ParamByName('SituTrib').asString                 := CSTICMSToStr(cst90);
                                           FD_Insert_EntregaXML.ParamByName('CST').asString                      := CSTICMSToStr(Imp.ICMS.ICMS90.CST);
                                           FD_Insert_EntregaXML.ParamByName('pRedBC').AsFloat                    := Imp.ICMS.ICMS90.pRedBC;
                                           FD_Insert_EntregaXML.ParamByName('vBC').AsFloat                       := Imp.ICMS.ICMS90.vBC;
                                           FD_Insert_EntregaXML.ParamByName('pICMS').AsFloat                     := Imp.ICMS.ICMS90.pICMS;
                                           FD_Insert_EntregaXML.ParamByName('vICMS').AsFloat                     := Imp.ICMS.ICMS90.vICMS;
                                           FD_Insert_EntregaXML.ParamByName('vCred').AsFloat                     := Imp.ICMS.ICMS90.vCred;
                                     end;
                                     cstICMSOutraUF:
                                        begin
                                           FD_Insert_EntregaXML.ParamByName('SituTrib').asString                 := CSTICMSToStr(cst90);
                                           FD_Insert_EntregaXML.ParamByName('CST').asString                      := CSTICMSToStr(Imp.ICMS.ICMSOutraUF.CST);
                                           FD_Insert_EntregaXML.ParamByName('pRedBC').AsFloat                    := Imp.ICMS.ICMSOutraUF.pRedBCOutraUF;
                                           FD_Insert_EntregaXML.ParamByName('vBC').AsFloat                       := Imp.ICMS.ICMSOutraUF.vBCOutraUF;
                                           FD_Insert_EntregaXML.ParamByName('pICMS').AsFloat                     := Imp.ICMS.ICMSOutraUF.pICMSOutraUF;
                                           FD_Insert_EntregaXML.ParamByName('vICMS').AsFloat                     := Imp.ICMS.ICMSOutraUF.vICMSOutraUF;
                                           FD_Insert_EntregaXML.ParamByName('vCred').AsFloat                     := 0;
                                        end;
                                    end;

                                    FD_Insert_EntregaXML.ParamByName('infAdFisco').AsString                          := Imp.infAdFisco;
                                    FD_Insert_EntregaXML.ParamByName('vTotTrib').AsFloat                             := imp.vTotTrib ;
                                    FD_Insert_EntregaXML.ParamByName('vPIS').AsFloat                                 := imp.infTribFed.vPIS;
                                    FD_Insert_EntregaXML.ParamByName('vCOFINS').AsFloat                              := imp.infTribFed.vCOFINS;
                                    FD_Insert_EntregaXML.ParamByName('vIR').AsFloat                                  := imp.infTribFed.vIR;
                                    FD_Insert_EntregaXML.ParamByName('vINSS').AsFloat                                := imp.infTribFed.vINSS;
                                    FD_Insert_EntregaXML.ParamByName('vCSLL').AsFloat                                := imp.infTribFed.vCSLL;
                                    FD_Insert_EntregaXML.ParamByName('CFOP').AsString                                := IntToStr(ide.CFOP);

                                    try
                                      FD_Insert_EntregaXML.ExecSQL;

                                    except
                                      On E:Exception do
                                        begin

                                          DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_IMPOSTOS.' + E.Message);
                                          Continue;
                                        end;
                                    end;

                                    lSQL := ' INSERT INTO [dbo].[CTE_INFCARGA]( ';
                                    lSQL := lSQL + ' cCT';
                                    lSQL := lSQL + ' ,CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,VCARGA ';
                                    lSQL := lSQL + ' ,PROPRED';
                                    lSQL := lSQL + ' ,XOUTCAT)';
                                    lSQL := lSQL + ' Values ( ';
                                    lSQL := lSQL + ' :cCT';
                                    lSQL := lSQL + ' ,:CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,:VCARGA ';
                                    lSQL := lSQL + ' ,:PROPRED';
                                    lSQL := lSQL + ' ,:XOUTCAT)';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                     := ide.cCT;
                                    FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                    FD_Insert_EntregaXML.ParamByName('VCARGA').AsFloat                    := infCTeNorm.infCarga.vCarga;
                                    FD_Insert_EntregaXML.ParamByName('PROPRED').AsString                  := infCTeNorm.infCarga.proPred;
                                    FD_Insert_EntregaXML.ParamByName('XOUTCAT').AsString                  := infCTeNorm.infCarga.xOutCat;

                                    try
                                      FD_Insert_EntregaXML.ExecSQL;

                                    except
                                      On E:Exception do
                                        begin

                                          DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_INFCARGA.' + E.Message);
                                          Continue;
                                        end;
                                    end;

                                    lSQL := ' INSERT INTO [dbo].[CTE_SEGURADORA]( ';
                                    lSQL := lSQL + ' cCT';
                                    lSQL := lSQL + ' ,CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,RESPSEG';
                                    lSQL := lSQL + ' ,XSEG';
                                    lSQL := lSQL + ' ,NAPOLICE';
                                    lSQL := lSQL + ' ,VCARGA)';
                                    lSQL := lSQL + '  Values (';
                                    lSQL := lSQL + ' :cCT';
                                    lSQL := lSQL + ' ,:CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,:RESPSEG';
                                    lSQL := lSQL + ' ,:XSEG';
                                    lSQL := lSQL + ' ,:NAPOLICE';
                                    lSQL := lSQL + ' ,:VCARGA)';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    for T := 0 to infCTeNorm.Seg.Count-1 do
                                    begin
                                      with infCTeNorm.Seg[T] do
                                      begin

                                        FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                     := ide.cCT;
                                        FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                        FD_Insert_EntregaXML.ParamByName('RESPSEG').AsString                  := TpRspSeguroToStr(infCTeNorm.Seg.Items[T].respSeg);
                                        FD_Insert_EntregaXML.ParamByName('XSEG').AsString                     := infCTeNorm.Seg.Items[T].xSeg;
                                        FD_Insert_EntregaXML.ParamByName('NAPOLICE').AsString                 := infCTeNorm.Seg.Items[T].nApol;
                                        FD_Insert_EntregaXML.ParamByName('VCARGA').AsFloat                    := infCTeNorm.Seg.Items[T].vCarga;

                                        try
                                          FD_Insert_EntregaXML.ExecSQL;

                                        except
                                          On E:Exception do
                                            begin

                                              DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_SEGURADORA.' + E.Message);
                                              Continue;
                                            end;
                                        end;
                                      end;
                                    end;

                                    lSQL := ' INSERT INTO [dbo].[CTE_INFMODAL]( ';
                                    lSQL := lSQL + ' cCT';
                                    lSQL := lSQL + ' ,CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,DPREVAEREO';
                                    lSQL := lSQL + ' ,IDT';
                                    lSQL := lSQL + ' ,CL';
                                    lSQL := lSQL + ' ,VTARIFA';
                                    lSQL := lSQL + ' ,nMinu ';
                                    lSQL := lSQL + ' ,nOCA ';
                                    lSQL := lSQL + ' ,cTar ';
                                    lSQL := lSQL + ' ,xLAgEmi) ';


                                    lSQL := lSQL + ' Values (';
                                    lSQL := lSQL + ' :cCT';
                                    lSQL := lSQL + ' ,:CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,:DPREVAEREO';
                                    lSQL := lSQL + ' ,:IDT';
                                    lSQL := lSQL + ' ,:CL';
                                    lSQL := lSQL + ' ,:VTARIFA';

                                    lSQL := lSQL + ' ,:nMinu ';
                                    lSQL := lSQL + ' ,:nOCA ';
                                    lSQL := lSQL + ' ,:cTar ';
                                    lSQL := lSQL + ' ,:xLAgEmi) ';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                     := ide.cCT;
                                    FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                    FD_Insert_EntregaXML.ParamByName('DPREVAEREO').AsSQLTimeStamp         := DateTimeToSQLTimeStamp(infCTeNorm.aereo.dPrevAereo);
                                    FD_Insert_EntregaXML.ParamByName('IDT').AsString                      := infCTeNorm.aereo.IdT;
                                    FD_Insert_EntregaXML.ParamByName('CL').AsString                       := infCTeNorm.aereo.tarifa.CL;
                                    FD_Insert_EntregaXML.ParamByName('VTARIFA').AsFloat                   := infCTeNorm.aereo.tarifa.vTar;
                                    FD_Insert_EntregaXML.ParamByName('cTar').AsString                     := infCTeNorm.aereo.tarifa.cTar;

                                    FD_Insert_EntregaXML.ParamByName('nMinu').AsInteger                    := infCTeNorm.aereo.nMinu;
                                    FD_Insert_EntregaXML.ParamByName('nOCA').AsString                      := infCTeNorm.aereo.nOCA;
                                    FD_Insert_EntregaXML.ParamByName('xLAgEmi').AsString                   := infCTeNorm.aereo.xLAgEmi;

                                    IDENTITY_ID := 0;
                                    try
                                      FD_Insert_EntregaXML.ExecSQL;
                                      lSQL  := 'SELECT @@IDENTITY as ICTE_INFMODAL ';

                                      FD_Insert_EntregaXML.Close;
                                      FD_Insert_EntregaXML.SQL.Clear;
                                      FD_Insert_EntregaXML.SQL.Add( lSQL );
                                      FD_Insert_EntregaXML.Open;
                                      IDENTITY_ID := FD_Insert_EntregaXML.FieldByName('ICTE_INFMODAL').AsInteger;

                                    except
                                      On E:Exception do
                                        begin

                                          DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_INFMODAL.' + E.Message);
                                          Continue;
                                        end;
                                    end;

                                    lSQL := ' INSERT INTO [dbo].[CTE_INFMANU]( ';
                                    lSQL := lSQL + ' cCT';
                                    lSQL := lSQL + ',CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,CTE_INFMODAL';
                                    lSQL := lSQL + ' ,CINFMANU';
                                    lSQL := lSQL + ' ,CIMP ';
                                    lSQL := lSQL + ' ,XDIME)';
                                    lSQL := lSQL + ' VALUES (';
                                    lSQL := lSQL + ' :cCT';
                                    lSQL := lSQL + ' ,:CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,:CTE_INFMODAL';
                                    lSQL := lSQL + ' ,:CINFMANU';
                                    lSQL := lSQL + ' ,:CIMP';
                                    lSQL := lSQL + ' ,:XDIME)';
                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    for T := 0 to infCTeNorm.aereo.natCarga.cinfManu.Count-1 do
                                    begin
                                      with infCTeNorm.aereo.natCarga.cinfManu[T] do
                                      begin
                                        FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                     := ide.cCT;
                                        FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger             := IDENTITY_CTE_CAPA_ID;
                                        FD_Insert_EntregaXML.ParamByName('CTE_INFMODAL').AsInteger            := IDENTITY_ID;
                                        FD_Insert_EntregaXML.ParamByName('CINFMANU').AsString                 := TpInfManuToStr(infCTeNorm.aereo.natCarga.cinfManu[T].nInfManu);
                                        FD_Insert_EntregaXML.ParamByName('CIMP').AsString                     := infCTeNorm.aereo.natCarga.cIMP;
                                        FD_Insert_EntregaXML.ParamByName('XDIME').AsString                    := infCTeNorm.aereo.natCarga.xDime;

                                        try
                                          FD_Insert_EntregaXML.ExecSQL;

                                        except
                                          On E:Exception do
                                            begin

                                              DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_INFMANU.' + E.Message);
                                              Continue;
                                            end;
                                        end;
                                      end;
                                    end;


                                    lSQL := ' INSERT INTO [dbo].[CTE_NFE]( ';
                                    lSQL := lSQL + ' cCT';
                                    lSQL := lSQL + ' ,CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,CHAVENFE) ';
                                    lSQL := lSQL + ' Values ( ';
                                    lSQL := lSQL + ' :cCT';
                                    lSQL := lSQL + ' ,:CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,:CHAVENFE) ';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    for T := 0 to infCTeNorm.infDoc.infNFe.Count-1 do
                                    begin
                                      with infCTeNorm.infDoc.infNFe[T] do
                                      begin
                                        FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                     := ide.cCT;
                                        FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                        FD_Insert_EntregaXML.ParamByName('CHAVENFE').AsString                 := infCTeNorm.infDoc.infNFe[T].chave;

                                        try
                                          FD_Insert_EntregaXML.ExecSQL;

                                        except
                                          On E:Exception do
                                            begin

                                              DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_NFE.' + E.Message);
                                              Continue;
                                            end;
                                        end;

                                      end;
                                    end;


                                    lSQL := ' INSERT INTO [dbo].[CTE_INFQ]( ';
                                    lSQL := lSQL + ' cCT';
                                    lSQL := lSQL + ' ,CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,CUNID';
                                    lSQL := lSQL + ' ,TPMED';
                                    lSQL := lSQL + ' ,QCARGA)';
                                    lSQL := lSQL + ' Values (';
                                    lSQL := lSQL + ' :cCT';
                                    lSQL := lSQL + ' ,:CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,:CUNID';
                                    lSQL := lSQL + ' ,:TPMED';
                                    lSQL := lSQL + ' ,:QCARGA)';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    for T := 0 to infCTeNorm.infCarga.infQ.Count-1 do
                                    begin
                                      with infCTeNorm.infCarga.infQ[T] do
                                      begin
                                        FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                  := ide.cCT;
                                        FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                        FD_Insert_EntregaXML.ParamByName('CUNID').AsString                 := UnidMedToStr(infCTeNorm.infCarga.infQ[T].cUnid);
                                        FD_Insert_EntregaXML.ParamByName('TPMED').AsString                 := infCTeNorm.infCarga.infQ[T].tpMed;
                                        FD_Insert_EntregaXML.ParamByName('QCARGA').AsFloat                 := infCTeNorm.infCarga.infQ[T].qCarga;

                                        try
                                          FD_Insert_EntregaXML.ExecSQL;

                                        except
                                          On E:Exception do
                                            begin

                                              DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_INFQ.' + E.Message);
                                              Continue;
                                            end;
                                        end;

                                      end;
                                    end;

                                    lSQL := ' INSERT INTO [dbo].[CTE_RODO]( ';
                                    lSQL := lSQL + ' cCT';
                                    lSQL := lSQL + ' ,CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,RNTRC';
                                    lSQL := lSQL + ' ,dPrev';
                                    lSQL := lSQL + ' ,lota';
                                    lSQL := lSQL + ' ,CIOT)';
                                    lSQL := lSQL + ' Values (';
                                    lSQL := lSQL + ' :cCT';
                                    lSQL := lSQL + ' ,:CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,:RNTRC';
                                    lSQL := lSQL + ' ,:dPrev';
                                    lSQL := lSQL + ' ,:lota';
                                    lSQL := lSQL + ' ,:CIOT)';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                  := ide.cCT;
                                    FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                    FD_Insert_EntregaXML.ParamByName('RNTRC').AsString                 := infCTeNorm.rodo.RNTRC;
                                    FD_Insert_EntregaXML.ParamByName('dPrev').AsSQLTimeStamp           := DateTimeToSQLTimeStamp(infCTeNorm.rodo.dPrev);
                                    FD_Insert_EntregaXML.ParamByName('lota').AsString                  := TpLotacaoToStr(infCTeNorm.rodo.lota);
                                    FD_Insert_EntregaXML.ParamByName('CIOT').AsString                  := infCTeNorm.rodo.CIOT;

                                    try
                                     FD_Insert_EntregaXML.ExecSQL;
                                     IDENTITY_ID := 0;
                                     lSQL  := 'SELECT @@IDENTITY as CTE_RODO_ID ';

                                     FD_Insert_EntregaXML.Close;
                                     FD_Insert_EntregaXML.SQL.Clear;
                                     FD_Insert_EntregaXML.SQL.Add( lSQL );
                                     FD_Insert_EntregaXML.Open;
                                     IDENTITY_ID := FD_Insert_EntregaXML.FieldByName('CTE_RODO_ID').AsInteger;

                                    except
                                      On E:Exception do
                                        begin

                                          DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_RODO.' + E.Message);
                                          Continue;
                                        end;
                                    end;

                                    lSQL := ' INSERT INTO [dbo].[CTE_RODO_OCC]( ';
                                    lSQL := lSQL + ' cCT';
                                    lSQL := lSQL + ' ,CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,CTE_RODO_ID';
                                    lSQL := lSQL + ' ,serie';
                                    lSQL := lSQL + ' ,nOcc';
                                    lSQL := lSQL + ' ,dEmi';
                                    lSQL := lSQL + ' ,CNPJ';
                                    lSQL := lSQL + ' ,cInt';
                                    lSQL := lSQL + ' ,IE';
                                    lSQL := lSQL + ' ,UF';
                                    lSQL := lSQL + ' ,fone)';
                                    lSQL := lSQL + ' Values';
                                    lSQL := lSQL + ' :cCT';
                                    lSQL := lSQL + ' ,:CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,:CTE_RODO_ID';
                                    lSQL := lSQL + ' ,:serie';
                                    lSQL := lSQL + ' ,:nOcc';
                                    lSQL := lSQL + ' ,:dEmi';
                                    lSQL := lSQL + ' ,:CNPJ';
                                    lSQL := lSQL + ' ,:cInt';
                                    lSQL := lSQL + ' ,:IE';
                                    lSQL := lSQL + ' ,:UF';
                                    lSQL := lSQL + ' ,:fone)';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    for T := 0 to infCTeNorm.rodo.occ.Count-1 do
                                    begin
                                      with infCTeNorm.rodo.occ[T] do
                                      begin
                                        FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                  := ide.cCT;
                                        FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                        FD_Insert_EntregaXML.ParamByName('CTE_RODO_ID').AsInteger          := IDENTITY_ID;
                                        FD_Insert_EntregaXML.ParamByName('serie').AsString                 := infCTeNorm.rodo.occ[T].serie;
                                        FD_Insert_EntregaXML.ParamByName('nOcc').AsInteger                 := infCTeNorm.rodo.occ[T].nOcc;
                                        FD_Insert_EntregaXML.ParamByName('dEmi').AsSQLTimeStamp            := DateTimeToSQLTimeStamp(infCTeNorm.rodo.occ[T].dEmi);
                                        FD_Insert_EntregaXML.ParamByName('CNPJ').AsString                  := infCTeNorm.rodo.occ[T].emiOcc.CNPJ;
                                        FD_Insert_EntregaXML.ParamByName('cInt').AsString                  := infCTeNorm.rodo.occ[T].emiOcc.cInt;
                                        FD_Insert_EntregaXML.ParamByName('IE').AsString                    := infCTeNorm.rodo.occ[T].emiOcc.IE;
                                        FD_Insert_EntregaXML.ParamByName('UF').AsString                    := infCTeNorm.rodo.occ[T].emiOcc.UF;
                                        FD_Insert_EntregaXML.ParamByName('fone').AsString                  := infCTeNorm.rodo.occ[T].emiOcc.fone;
                                       end;

                                       try
                                         FD_Insert_EntregaXML.ExecSQL;

                                       except
                                         On E:Exception do
                                           begin

                                             DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_RODO_OCC.' + E.Message);
                                             Continue;
                                           end;
                                       end;
                                    end;


                                    lSQL := ' INSERT INTO [dbo].[CTE_AUTXML]( ';
                                    lSQL := lSQL + ' cCT';
                                    lSQL := lSQL + ' ,CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,CNPJ )';
                                    lSQL := lSQL + ' Values (';
                                    lSQL := lSQL + ' :cCT';
                                    lSQL := lSQL + ' ,:CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,:CNPJ )';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    for T := 0 to autXML.Count-1 do
                                    begin
                                      with autXML[T] do
                                      begin
                                       FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                  := ide.cCT;
                                       FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger          := IDENTITY_CTE_CAPA_ID;
                                       FD_Insert_EntregaXML.ParamByName('CNPJ').AsString                  := autXML[T].CNPJCPF;
                                      end;

                                      try
                                        FD_Insert_EntregaXML.ExecSQL;

                                      except
                                        On E:Exception do
                                          begin

                                            DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_AUTXML.' + E.Message);
                                            Continue;
                                          end;
                                      end;
                                    end;

                                    lSQL := ' INSERT INTO [dbo].[CTE_COBR]( ';
                                    lSQL := lSQL + ' cCT';
                                    lSQL := lSQL + ' ,CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,nFat';
                                    lSQL := lSQL + ' ,vOrig';
                                    lSQL := lSQL + ' ,vDesc';
                                    lSQL := lSQL + ' ,vLiq';
                                    lSQL := lSQL + ' ,nDup';
                                    lSQL := lSQL + ' ,dVenc';
                                    lSQL := lSQL + ' ,vDup )';
                                    lSQL := lSQL + ' Values (';
                                    lSQL := lSQL + ' :cCT';
                                    lSQL := lSQL + ' ,:CTE_CAPA_ID ';
                                    lSQL := lSQL + ' ,:nFat';
                                    lSQL := lSQL + ' ,:vOrig';
                                    lSQL := lSQL + ' ,:vDesc';
                                    lSQL := lSQL + ' ,:vLiq';
                                    lSQL := lSQL + ' ,:nDup';
                                    lSQL := lSQL + ' ,:dVenc';
                                    lSQL := lSQL + ' ,:vDup )';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );

                                    for T := 0 to infCTeNorm.cobr.dup.Count-1 do
                                    begin
                                      with infCTeNorm.cobr.dup[T] do
                                      begin
                                       FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                 := ide.cCT;
                                       FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger         := IDENTITY_CTE_CAPA_ID;
                                       FD_Insert_EntregaXML.ParamByName('nFat').AsString                 := infCTeNorm.cobr.fat.nFat;
                                       FD_Insert_EntregaXML.ParamByName('vOrig').AsFloat                 := infCTeNorm.cobr.fat.vOrig;
                                       FD_Insert_EntregaXML.ParamByName('vDesc').AsFloat                 := infCTeNorm.cobr.fat.vDesc;
                                       FD_Insert_EntregaXML.ParamByName('vLiq').AsFloat                  := infCTeNorm.cobr.fat.vLiq;
                                       FD_Insert_EntregaXML.ParamByName('nDup').AsString                 := infCTeNorm.cobr.dup[T].nDup;
                                       FD_Insert_EntregaXML.ParamByName('dVenc').AsSQLTimeStamp          := DateTimeToSQLTimeStamp(infCTeNorm.cobr.dup[T].dVenc);
                                       FD_Insert_EntregaXML.ParamByName('vDup').AsFloat                  := infCTeNorm.cobr.dup[T].vDup;
                                      end;

                                      try
                                        FD_Insert_EntregaXML.ExecSQL;

                                      except
                                        On E:Exception do
                                          begin

                                            DB_Conect.doSaveLogImport(PastaLOG, pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_COBR.' + E.Message);
                                            Continue;
                                          end;
                                      end;

                                    end;

                                    { Falta Criar a Tabela no Banco de Dados
                                    lSQL := ' INSERT INTO [dbo].[CTE_VALEPED]( ';
                                    lSQL := lSQL + ' cCT';
                                    lSQL := lSQL + ' ,CNPJForn';
                                    lSQL := lSQL + ' ,nCompra';
                                    lSQL := lSQL + ' ,CNPJPg';
                                    lSQL := lSQL + ' ,ID)';
                                    lSQL := lSQL + ' Values (';
                                    lSQL := lSQL + ' :cCT';
                                    lSQL := lSQL + ' ,:CNPJForn';
                                    lSQL := lSQL + ' ,:nCompra';
                                    lSQL := lSQL + ' ,:CNPJPg';
                                    lSQL := lSQL + ' ,:ID)';

                                    for T := 0 to infCTeNorm.rodo.valePed.Count-1 do
                                    begin
                                      with infCTeNorm.rodo.valePed[T] do
                                      begin
                                       FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                 := ide.cCT;
                                       FD_Insert_EntregaXML.ParamByName('CNPJForn').AsString             := infCTeNorm.rodo.valePed[T].CNPJForn;
                                       FD_Insert_EntregaXML.ParamByName('nCompra').AsString              := infCTeNorm.rodo.valePed[T].nCompra;
                                       FD_Insert_EntregaXML.ParamByName('CNPJPg').AsString               := infCTeNorm.rodo.valePed[T].CNPJPg;
                                       FD_Insert_EntregaXML.ParamByName('ID').AsInteger                  := infCTeNorm.rodo.valePed[T].ID;
                                      end;

                                      try
                                        FD_Insert_EntregaXML.ExecSQL;

                                      except
                                        On E:Exception do
                                          begin
                                //            DB_Conect.GetComando(FD_Insert_EntregaXML, frmImportarNFeEntrada, False);
                                            //GCambio.ExecRollBack;

                                            btnImportar.Enabled  := False;

                                            MessageDlg( pChar(lArquivo) + #13#10 + 'Falha ao incluir CTE_VALEPED.' + E.Message, mtError, [mbOK],0);
                                            Continue;
                                          end;
                                      end;

                                    end;
                                   }

                                   { Falta Criar a Tabela no Banco de Dados
                                   lSQL := ' INSERT INTO [dbo].[CTE_ROD_VEICULO]( ';
                                   lSQL := lSQL + ' cCT';
                                   lSQL := lSQL + ' ,cInt';
                                   lSQL := lSQL + ' ,RENAVAM';
                                   lSQL := lSQL + ' ,placa';
                                   lSQL := lSQL + ' ,tara';
                                   lSQL := lSQL + ' ,capKG';
                                   lSQL := lSQL + ' ,capM3';
                                   lSQL := lSQL + ' ,tpProp';
                                   lSQL := lSQL + ' ,tpVeic';
                                   lSQL := lSQL + ' ,tpRod';
                                   lSQL := lSQL + ' ,tpCar';
                                   lSQL := lSQL + ' ,UF';
                                   lSQL := lSQL + ' ,CNPJCF';
                                   lSQL := lSQL + ' ,RNTRC';
                                   lSQL := lSQL + ' ,xNome';
                                   lSQL := lSQL + ' ,IE';
                                   lSQL := lSQL + ' ,UF';
                                   lSQL := lSQL + ' ,tpProp)';
                                   lSQL := lSQL + ' Values(';
                                   lSQL := lSQL + ' :cCT';
                                   lSQL := lSQL + ' ,:cInt';
                                   lSQL := lSQL + ' ,:RENAVAM';
                                   lSQL := lSQL + ' ,:placa';
                                   lSQL := lSQL + ' ,:tara';
                                   lSQL := lSQL + ' ,:capKG';
                                   lSQL := lSQL + ' ,:capM3';
                                   lSQL := lSQL + ' ,:tpProp';
                                   lSQL := lSQL + ' ,:tpVeic';
                                   lSQL := lSQL + ' ,:tpRod';
                                   lSQL := lSQL + ' ,:tpCar';
                                   lSQL := lSQL + ' ,:UF';
                                   lSQL := lSQL + ' ,:CNPJCF';
                                   lSQL := lSQL + ' ,:RNTRC';
                                   lSQL := lSQL + ' ,:xNome';
                                   lSQL := lSQL + ' ,:IE';
                                   lSQL := lSQL + ' ,:UF';
                                   lSQL := lSQL + ' ,:tpProp)';


                                    for T := 0 to infCTeNorm.rodo.veic.Count-1 do
                                    begin
                                      with infCTeNorm.rodo.veic[T] do
                                      begin
                                       FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                 := ide.cCT;
                                       FD_Insert_EntregaXML.ParamByName('cInt').AsString                 := infCTeNorm.rodo.veic[T].cInt;
                                       FD_Insert_EntregaXML.ParamByName('RENAVAM').AsString              := infCTeNorm.rodo.veic[T].RENAVAM;
                                       FD_Insert_EntregaXML.ParamByName('placa').AsString                := infCTeNorm.rodo.veic[T].placa;
                                       FD_Insert_EntregaXML.ParamByName('tara').AsInteger                := infCTeNorm.rodo.veic[T].tara;
                                       FD_Insert_EntregaXML.ParamByName('capKG').AsInteger               := infCTeNorm.rodo.veic[T].capKG;
                                       FD_Insert_EntregaXML.ParamByName('capM3').AsInteger               := infCTeNorm.rodo.veic[T].capM3;
                                       FD_Insert_EntregaXML.ParamByName('tpProp').AsString               := TpPropriedadeToStr(infCTeNorm.rodo.veic[T].tpProp);
                                       FD_Insert_EntregaXML.ParamByName('tpVeic').AsString               := TpVeiculoToStr(infCTeNorm.rodo.veic[T].tpVeic);
                                       FD_Insert_EntregaXML.ParamByName('tpRod').AsString                := TpRodadoToStr(infCTeNorm.rodo.veic[T].tpRod);
                                       FD_Insert_EntregaXML.ParamByName('tpCar').AsString                := TpCarroceriaToStr(infCTeNorm.rodo.veic[T].tpCar);
                                       FD_Insert_EntregaXML.ParamByName('UF').AsString                   := infCTeNorm.rodo.veic[T].UF;
                                       FD_Insert_EntregaXML.ParamByName('CNPJCF').AsString               := infCTeNorm.rodo.veic[T].Prop.CNPJCPF;
                                       FD_Insert_EntregaXML.ParamByName('RNTRC').AsString                := infCTeNorm.rodo.veic[T].Prop.RNTRC;
                                       FD_Insert_EntregaXML.ParamByName('xNome').AsString                := infCTeNorm.rodo.veic[T].Prop.xNome;
                                       FD_Insert_EntregaXML.ParamByName('IE').AsString                   := infCTeNorm.rodo.veic[T].Prop.IE;
                                       FD_Insert_EntregaXML.ParamByName('UF').AsString                   := infCTeNorm.rodo.veic[T].Prop.UF;
                                       FD_Insert_EntregaXML.ParamByName('tpProp').AsString               := TpPropToStr(infCTeNorm.rodo.veic[T].Prop.tpProp);
                                      end;

                                      try
                                        FD_Insert_EntregaXML.ExecSQL;

                                      except
                                        On E:Exception do
                                          begin
                                //            DB_Conect.GetComando(FD_Insert_EntregaXML, frmImportarNFeEntrada, False);
                                            //GCambio.ExecRollBack;

                                            btnImportar.Enabled  := False;

                                            MessageDlg( pChar(sr.Name ) + #13#10 + 'Falha ao incluir CTE_ROD_VEICULO.' + E.Message, mtError, [mbOK],0);
                                            Continue;
                                          end;
                                      end;

                                    end;
                                   }


                                    {


                                    infCTeNorm.rodoOS.TAF;
                                    infCTeNorm.rodoOS.NroRegEstadual;
                                    infCTeNorm.rodoOS.veic.placa;
                                    infCTeNorm.rodoOS.veic.RENAVAM;
                                    infCTeNorm.rodoOS.veic.prop;
                                    infCTeNorm.rodoOS.veic.UF;

                                    infCTeNorm.aquav.vPrest;
                                    infCTeNorm.aquav.vAFRMM;
                                    infCTeNorm.aquav.nBooking;
                                    infCTeNorm.aquav.nCtrl;
                                    infCTeNorm.aquav.xNavio;
                                    infCTeNorm.aquav.balsa[0].ID;
                                    infCTeNorm.aquav.balsa[0].xBalsa;
                                    infCTeNorm.aquav.nViag;
                                    infCTeNorm.aquav.direc;
                                    infCTeNorm.aquav.prtEmb;
                                    infCTeNorm.aquav.prtTrans;
                                    infCTeNorm.aquav.prtDest;
                                    infCTeNorm.aquav.tpNav;
                                    infCTeNorm.aquav.irin;
                                    infCTeNorm.aquav.detCont[0].nCont;
                                    infCTeNorm.aquav.detCont[0].Lacre[0].nLacre;
                                    infCTeNorm.aquav.detCont[0].Lacre[0].ID;
                                    infCTeNorm.aquav.detCont[0].infDoc.infNF[0].serie;
                                    infCTeNorm.aquav.detCont[0].infDoc.infNF[0].nDoc;
                                    infCTeNorm.aquav.detCont[0].infDoc.infNF[0].unidRat;
                                    infCTeNorm.aquav.detCont[0].infDoc.infNF[0].ID;

                                    infCTeNorm.ferrov.tpTraf;
                                    infCTeNorm.ferrov.trafMut.respFat;
                                    infCTeNorm.ferrov.trafMut.ferrEmi;
                                    infCTeNorm.ferrov.fluxo;
                                    infCTeNorm.ferrov.idTrem;
                                    infCTeNorm.ferrov.vFrete;
                                    infCTeNorm.ferrov.ferroEnv[0].CNPJ;
                                    infCTeNorm.ferrov.ferroEnv[0].cInt;
                                    infCTeNorm.ferrov.ferroEnv[0].IE;
                                    infCTeNorm.ferrov.ferroEnv[0].xNome;
                                    infCTeNorm.ferrov.ferroEnv[0].enderFerro.xLgr;
                                    infCTeNorm.ferrov.ferroEnv[0].enderFerro.nro;
                                    infCTeNorm.ferrov.ferroEnv[0].enderFerro.xCpl;
                                    infCTeNorm.ferrov.ferroEnv[0].enderFerro.xBairro;
                                    infCTeNorm.ferrov.ferroEnv[0].enderFerro.cMun;
                                    infCTeNorm.ferrov.ferroEnv[0].enderFerro.xMun;
                                    infCTeNorm.ferrov.ferroEnv[0].enderFerro.CEP;
                                    infCTeNorm.ferrov.ferroEnv[0].enderFerro.UF;
                                    infCTeNorm.ferrov.detVag[0].nVag;
                                    infCTeNorm.ferrov.detVag[0].cap;
                                    infCTeNorm.ferrov.detVag[0].tpVag;
                                    infCTeNorm.ferrov.detVag[0].pesoR;
                                    infCTeNorm.ferrov.detVag[0].pesoBC;
                                    infCTeNorm.ferrov.detVag[0].ID;

                                    infCTeNorm.duto.vTar;
                                    infCTeNorm.duto.dIni;
                                    infCTeNorm.duto.dFim;

                                    infCTeNorm.multimodal.COTM;
                                    infCTeNorm.multimodal.indNegociavel;
                                    infCTeNorm.peri[0].nONU;
                                    infCTeNorm.peri[0].xNomeAE;
                                    infCTeNorm.peri[0].xClaRisco;
                                    infCTeNorm.peri[0].grEmb;
                                    infCTeNorm.peri[0].qTotProd;
                                    infCTeNorm.peri[0].qVolTipo;
                                    infCTeNorm.peri[0].pontoFulgor;


                                    infCTeNorm.veicNovos[0].cCor;
                                    infCTeNorm.veicNovos[0].xCor;
                                    infCTeNorm.veicNovos[0].cMod;
                                    infCTeNorm.veicNovos[0].vUnit;
                                    infCTeNorm.veicNovos[0].vFrete;

                                    infCTeNorm.cobr.fat;
                                    infCTeNorm.cobr.dup[0].nDup;
                                    infCTeNorm.cobr.dup[0].dVenc;
                                    infCTeNorm.cobr.dup[0].vDup;

                                    infCTeNorm.infCteSub.chCte;
                                    infCTeNorm.infCteSub.refCteAnu;
                                    infCTeNorm.infCteSub.tomaICMS;
                                    infCTeNorm.infCteSub.tomaNaoICMS;

                                    infCTeNorm.infCteSub.indAlteraToma.tiSim;

                                     }




                                  // Guardar Arquivo XML
                                  try
                                    varSQL := 'Insert into XML_IMPORTADA(cCT, CTE_CAPA_ID, DataEmissao,nCT,CHCTE,CodUsuario, TipoXML)';
                                    varSQL := varSQL + ' values( :cCT, :CTE_CAPA_ID, :DataEmissao,:nCT,:CHCTE,:CodUsuario, :TipoXML)';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( varSQL );

                                    FD_Insert_EntregaXML.ParamByName('cCT').asInteger               := ide.cCT;
                                    FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger       := IDENTITY_CTE_CAPA_ID;
                                    FD_Insert_EntregaXML.ParamByName('DataEmissao').AsSQLTimeStamp  := DateTimeToSQLTimeStamp(Ide.dhEmi);
                                    FD_Insert_EntregaXML.ParamByName('nCT').AsString             := IntToStr(Ide.nCT);
                                    FD_Insert_EntregaXML.ParamByName('CHCTE').AsString              := procCTe.chCTe;
                                    FD_Insert_EntregaXML.ParamByName('CodUsuario').AsString         := '1';
                                    FD_Insert_EntregaXML.ParamByName('TipoXML').AsString            := 'CTE';

                                  finally

                                    try
                                      FD_Insert_EntregaXML.ExecSQL;
                                      MoveFile( PWideChar(  lArquivo ) , PWideChar( lArquivoImportado ) );
                                    except
                                      On E:Exception do
                                        begin

                                          Writeln( 'Falha ao Inserir XML_IMPORTADA: ' + E.Message );
                                          DB_Conect.doSaveLogImport(PastaLOG, GetComando(FD_Insert_EntregaXML) + ' ' +  'Falha ao incluir XML.' + E.Message);
                                        end;
                                    end;

                                  end;
                                  // Fim Guarda Arquivo XML

                                end;

                              end;
                          except

                            DB_Conect.doSaveLogImport(PastaLOG, ' Arquivo ' + PWideChar( lArquivo ));
                            Continue;
                          end;

                        end
                        else if varTipoNota = 1 then
                        begin
                          try
                              with TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe do
                              begin

                                if (procNFe.nProt = '') then
                                begin
                                   Writeln( 'Sem Protocolo: ' +  PWideChar(  lArquivoImportado ) );
                                   MoveFile( PWideChar( lArquivo ) , PWideChar( lArquivoImportado ) );
                                   Inc(X);
                                   varTipoNota := -2;
                                   DB_Conect.doSaveLogImport(PastaLOG, 'Sem Protocolo ' +  PWideChar( lArquivoImportado ));
                                   Continue;
                                end;


                                with FD_Consulta_EntregaXML do
                                begin
                                  Close;
                                  SQL.Clear;
                                  SQL.Add(' SELECT cCT FROM XML_IMPORTADA  ');
                                  SQL.Add(' WHERE cCT  = :cCT ');
                                  SQL.Add(' and DataEmissao  = :DataEmissao ');
                                  SQL.Add(' and nCT = :nCT ');
                                  SQL.Add(' and CHCTE = :CHCTE ');
                                  SQL.Add(' and TipoXML = :TipoXML ');
                                  ParamByName('cCT').AsInteger               := Ide.nNF ;
                                  ParamByName('DataEmissao').AsSQLTimeStamp  := DateTimeToSQLTimeStamp(Ide.dEmi);
                                  ParamByName('nCT').AsString             := IntToStr( Ide.nNF );
                                  ParamByName('CHCTE').AsString              := procNFe.chNFe;
                                  ParamByName('TipoXML').AsString            := 'NFE';
                                  Open;
                                end;


                                if not FD_Consulta_EntregaXML.IsEmpty then
                                begin
                                   Writeln( 'Existente: ' +  PWideChar(  lArquivoImportado ) );
                                   MoveFile( PWideChar(  lArquivo ) , PWideChar( lArquivoImportado ) );
                                   Inc(X);
                                   varTipoNota := -2;
                                   DB_Conect.doSaveLogImport(PastaLOG, 'Existente ' +  PWideChar( lArquivoImportado));
                                   Continue;
                                end;


                                with TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe do
                                begin
                                 varSQL := ' INSERT INTO CTE_PROTOCOLO (';
                                 varSQL := varSQL + ' ID,  ';
                                 varSQL := varSQL + ' tpAmb, ';
                                 varSQL := varSQL + ' verAplic, ';
                                 varSQL := varSQL + ' chCTe, ';
                                 varSQL := varSQL + ' dhRecbto, ';
                                 varSQL := varSQL + ' nProt,  ';
                                 varSQL := varSQL + ' digVal, ';
                                 varSQL := varSQL + ' cStat, ';
                                 varSQL := varSQL + ' xMotivo, ';
                                 varSQL := varSQL + ' NCT, ';
                                 varSQL := varSQL + ' cCT ';
                                 varSQL := varSQL + ' ) VALUES  ( ';
                                 varSQL := varSQL + ' :ID,  ';
                                 varSQL := varSQL + ' :tpAmb, ';
                                 varSQL := varSQL + ' :verAplic, ';
                                 varSQL := varSQL + ' :chCTe, ';
                                 varSQL := varSQL + ' :dhRecbto, ';
                                 varSQL := varSQL + ' :nProt,  ';
                                 varSQL := varSQL + ' :digVal, ';
                                 varSQL := varSQL + ' :cStat, ';
                                 varSQL := varSQL + ' :xMotivo, ';
                                 varSQL := varSQL + ' :NCT, ';
                                 varSQL := varSQL + ' :cCT) ';

                                 FD_Insert_EntregaXML.Close;
                                 FD_Insert_EntregaXML.SQL.Clear;
                                 FD_Insert_EntregaXML.SQL.Add( varSQL );

                                 FD_Insert_EntregaXML.ParamByName('ID').AsString                        := infNFe.ID;
                                 FD_Insert_EntregaXML.ParamByName('tpAmb').AsString                     := TpAmbToStr(procNFe.tpAmb);
                                 FD_Insert_EntregaXML.ParamByName('verAplic').AsString                  := procNFe.verAplic;
                                 FD_Insert_EntregaXML.ParamByName('chCTe').AsString                     := procNFe.chNFe;
                                 FD_Insert_EntregaXML.ParamByName('dhRecbto').AsSQLTimeStamp            := DateTimeToSQLTimeStamp(procNFe.dhRecbto);
                                 FD_Insert_EntregaXML.ParamByName('nProt').AsString                     := procNFe.nProt;
                                 FD_Insert_EntregaXML.ParamByName('digVal').AsString                    := procNFe.digVal;
                                 FD_Insert_EntregaXML.ParamByName('cStat').AsString                     := IntToStr(procNFe.cStat);
                                 FD_Insert_EntregaXML.ParamByName('xMotivo').AsString                   := procNFe.xMotivo;
                                 FD_Insert_EntregaXML.ParamByName('NCT').AsString                    := IntToStr(ide.nNF);
                                 FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                      := ide.nNF;
                                 try
                                   FD_Insert_EntregaXML.ExecSQL;
                                 except
                                   On E:Exception do
                                     begin
                                     //  DB_Conect.SQLConnection.RollBack;

                                       Writeln( 'Falha ao incluir CTE_PROTOCOLO.: ' +  PWideChar( lArquivo ) );
                                       DB_Conect.doSaveLogImport(PastaLOG, GetComando(FD_Insert_EntregaXML)  + ' - Falha ao incluir CTE_PROTOCOLO.' + E.Message);
                                       Continue;
                                     end;
                                 end;

                                 FD_BuscaFilial.Close;
                                 FD_BuscaFilial.SQL.Clear;
                                 FD_BuscaFilial.SQL.Add('Select CTE_FILIAL_ID from CTE_FILIAL Where cnpj = :cnpj');
                                 FD_BuscaFilial.ParamByName('cnpj').AsString := Dest.CNPJCPF;
                                 FD_BuscaFilial.Open;

                                 if FD_BuscaFilial.IsEmpty then
                                 begin
                                      FD_BuscaFilial.Close;
                                      FD_BuscaFilial.SQL.Clear;
                                      FD_BuscaFilial.SQL.Add('Select CTE_FILIAL_ID from CTE_FILIAL Where cnpj = :cnpj');
                                      FD_BuscaFilial.ParamByName('cnpj').AsString := Emit.CNPJCPF;
                                      FD_BuscaFilial.Open;
                                      if not FD_BuscaFilial.IsEmpty then
                                         OrigemDaNota := 'S'
                                      else
                                      begin
                                          DB_Conect.doSaveLogImport( PastaLOG , lArquivo  + ' - CNPJ N�o Cadastrado.');
                                          Continue;
                                      end;
                                 end
                                 else
                                 begin
                                    OrigemDaNota := 'E';
                                 end;

                                 varFilialID :=  FD_BuscaFilial.FieldByName('CTE_FILIAL_ID').AsString;

                                 varSQL := ' INSERT INTO CTE_CAPA (';
                                 varSQL := varSQL + ' CTE_FILIAL_ID ';
                                 varSQL := varSQL + ' ,cUF ';
                                 varSQL := varSQL + ' ,cCT';
                                 varSQL := varSQL + ' ,CFOP';
                                 varSQL := varSQL + ' ,natOp';
                                 varSQL := varSQL + ' ,forPag';
                                 varSQL := varSQL + ' ,mod_';
                                 varSQL := varSQL + ' ,serie';
                                 varSQL := varSQL + ' ,NCT';
                                 varSQL := varSQL + ' ,dhEmi';
                                 varSQL := varSQL + ' ,tpImp';
                                 varSQL := varSQL + ' ,tpEmis';
                                 varSQL := varSQL + ' ,cDV';
                                 varSQL := varSQL + ' ,tpAmb';
                                 varSQL := varSQL + ' ,tpCTe';
                                 varSQL := varSQL + ' ,procEmi';
                                 varSQL := varSQL + ' ,verProc';
                                 varSQL := varSQL + ' ,cMunEnv';
                                 varSQL := varSQL + ' ,xMunEnv';
                                 varSQL := varSQL + ' ,UFEnv';
                                 varSQL := varSQL + ' ,modal';
                                 varSQL := varSQL + ' ,tpServ';
                                 varSQL := varSQL + ' ,cMunIni';
                                 varSQL := varSQL + ' ,xMunIni';
                                 varSQL := varSQL + ' ,UFIni';
                                 varSQL := varSQL + ' ,cMunFim';
                                 varSQL := varSQL + ' ,xMunFim';
                                 varSQL := varSQL + ' ,UFFim';
                                 varSQL := varSQL + ' ,retira';
                                 varSQL := varSQL + ' ,toma03';
                                 varSQL := varSQL + ' ,xCaracAd';
                                 varSQL := varSQL + ' ,xCaracSer';
                                 varSQL := varSQL + ' ,xEmi';
                                 varSQL := varSQL + ' ,xOrig';
                                 varSQL := varSQL + ' ,xDest';
                                 varSQL := varSQL + ' ,tpPer';
                                 varSQL := varSQL + ' ,dProg';
                                 varSQL := varSQL + ' ,tpHor';
                                 varSQL := varSQL + ' ,hProg';
                                 varSQL := varSQL + ' ,OrigemNota';
                                 varSQL := varSQL + ' ,xObs)';
                                 varSQL := varSQL + ' VALUES ';
                                 varSQL := varSQL + ' ( :CTE_FILIAL_ID,';
                                 varSQL := varSQL + '   :cUF,';
                                 varSQL := varSQL + '  :cCT, ';
                                 varSQL := varSQL + '  :CFOP, ';
                                 varSQL := varSQL + '  :natOp, ';
                                 varSQL := varSQL + '  :forPag, ';
                                 varSQL := varSQL + '  :mod_, ';
                                 varSQL := varSQL + '  :serie, ';
                                 varSQL := varSQL + '  :NCT, ';
                                 varSQL := varSQL + '  :dhEmi, ';
                                 varSQL := varSQL + '  :tpImp, ';
                                 varSQL := varSQL + '  :tpEmis, ';
                                 varSQL := varSQL + '  :cDV, ';
                                 varSQL := varSQL + '  :tpAmb, ';
                                 varSQL := varSQL + '  :tpCTe, ';
                                 varSQL := varSQL + '  :procEmi, ';
                                 varSQL := varSQL + '  :verProc, ';
                                 varSQL := varSQL + '  :cMunEnv, ';
                                 varSQL := varSQL + '  :xMunEnv,';
                                 varSQL := varSQL + '  :UFEnv, ';
                                 varSQL := varSQL + '  :modal, ';
                                 varSQL := varSQL + '  :tpServ, ';
                                 varSQL := varSQL + '  :cMunIni, ';
                                 varSQL := varSQL + '  :xMunIni, ';
                                 varSQL := varSQL + '  :UFIni, ';
                                 varSQL := varSQL + '  :cMunFim, ';
                                 varSQL := varSQL + '  :xMunFim, ';
                                 varSQL := varSQL + '  :UFFim, ';
                                 varSQL := varSQL + '  :retira, ';
                                 varSQL := varSQL + '  :toma03, ';
                                 varSQL := varSQL + '  :xCaracAd, ';
                                 varSQL := varSQL + '  :xCaracSer, ';
                                 varSQL := varSQL + '  :xEmi, ';
                                 varSQL := varSQL + '  :xOrig, ';
                                 varSQL := varSQL + '  :xDest, ';
                                 varSQL := varSQL + '  :tpPer, ';
                                 varSQL := varSQL + '  :dProg, ';
                                 varSQL := varSQL + '  :tpHor, ';
                                 varSQL := varSQL + '  :hProg, ';
                                 varSQL := varSQL + '  :OrigemNota, ';
                                 varSQL := varSQL + '  :xObs) ';

                                 FD_Insert_EntregaXML.Close;
                                 FD_Insert_EntregaXML.SQL.Clear;
                                 FD_Insert_EntregaXML.SQL.Add( varSQL );

                                 FD_Insert_EntregaXML.ParamByName('CTE_FILIAL_ID').AsString           := varFilialID;
                                 FD_Insert_EntregaXML.ParamByName('cUF').AsString                     := IntToStr(Ide.cUF);
                                 FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                    := ide.nNF;
                                 FD_Insert_EntregaXML.ParamByName('CFOP').AsString                    := '';
                                 FD_Insert_EntregaXML.ParamByName('natOp').AsString                   := ide.natOp;
                                 FD_Insert_EntregaXML.ParamByName('forPag').AsString                  := '';
                                 FD_Insert_EntregaXML.ParamByName('mod_').AsString                    := IntToStr(ide.modelo);
                                 FD_Insert_EntregaXML.ParamByName('serie').AsString                   := IntToStr(ide.serie);
                                 FD_Insert_EntregaXML.ParamByName('NCT').AsString                  := IntToStr(ide.nNF);
                                 FD_Insert_EntregaXML.ParamByName('dhEmi').AsSQLTimeStamp             := DateTimeToSQLTimeStamp(ide.dEmi);
                                 FD_Insert_EntregaXML.ParamByName('tpImp').AsString                   := TpImpToStr(ide.tpImp);
                                 FD_Insert_EntregaXML.ParamByName('tpEmis').AsString                  := TpEmisToStr(ide.tpEmis);
                                 FD_Insert_EntregaXML.ParamByName('cDV').AsString                     := IntToStr(ide.cDV);
                                 FD_Insert_EntregaXML.ParamByName('tpAmb').AsString                   := TpAmbToStr(ide.tpAmb);
                                 FD_Insert_EntregaXML.ParamByName('tpCTe').AsString                   := '';
                                 FD_Insert_EntregaXML.ParamByName('procEmi').AsString                 := procEmiToStr(ide.procEmi);
                                 FD_Insert_EntregaXML.ParamByName('verProc').AsString                 := ide.verProc;
                                 FD_Insert_EntregaXML.ParamByName('cMunEnv').AsString                 := InTToStr(Dest.EnderDest.cMun);
                                 FD_Insert_EntregaXML.ParamByName('xMunEnv').AsString                 := Dest.EnderDest.xMun;
                                 FD_Insert_EntregaXML.ParamByName('UFEnv').AsString                   := Dest.EnderDest.UF;
                                 FD_Insert_EntregaXML.ParamByName('modal').AsString                   := '';
                                 FD_Insert_EntregaXML.ParamByName('tpServ').AsString                  := '';
                                 FD_Insert_EntregaXML.ParamByName('cMunIni').AsInteger                := Emit.EnderEmit.cMun;
                                 FD_Insert_EntregaXML.ParamByName('xMunIni').AsString                 := Emit.EnderEmit.xMun;
                                 FD_Insert_EntregaXML.ParamByName('UFIni').AsString                   := Emit.EnderEmit.UF;
                                 FD_Insert_EntregaXML.ParamByName('cMunFim').AsInteger                := Dest.EnderDest.cMun;
                                 FD_Insert_EntregaXML.ParamByName('xMunFim').AsString                 := Dest.EnderDest.xMun;
                                 FD_Insert_EntregaXML.ParamByName('UFFim').AsString                   := Dest.EnderDest.UF;
                                 FD_Insert_EntregaXML.ParamByName('retira').AsString                  := '';
                                 FD_Insert_EntregaXML.ParamByName('toma03').AsString                  := '';
                                 FD_Insert_EntregaXML.ParamByName('xCaracAd').AsString                := '' ;
                                 FD_Insert_EntregaXML.ParamByName('xCaracSer').AsString               := '';
                                 FD_Insert_EntregaXML.ParamByName('xEmi').AsString                    := '';
                                 FD_Insert_EntregaXML.ParamByName('xOrig').AsString                   := '';
                                 FD_Insert_EntregaXML.ParamByName('xDest').AsString                   := '';
                                 FD_Insert_EntregaXML.ParamByName('tpPer').AsString                   := '';
                                 FD_Insert_EntregaXML.ParamByName('dProg').AsSQLTimeStamp             := DateTimeToSQLTimeStamp(Date);
                                 FD_Insert_EntregaXML.ParamByName('tpHor').AsString                   := '';
                                 FD_Insert_EntregaXML.ParamByName('hProg').AsSQLTimeStamp             := DateTimeToSQLTimeStamp(Date);
                                 FD_Insert_EntregaXML.ParamByName('OrigemNota').AsString              := OrigemDaNota;
                                 FD_Insert_EntregaXML.ParamByName('xObs').AsString                    := '';

                                 try
                                   FD_Insert_EntregaXML.ExecSQL;
                                 except
                                   On E:Exception do
                                     begin
                                       Writeln( 'Falha ao incluir CTE_CAPA.: ' +  PWideChar( lArquivo ) );
                                       DB_Conect.doSaveLogImport(PastaLOG, GetComando(FD_Insert_EntregaXML) + #13#10 + 'Falha ao incluir CTE_CAPA.' + E.Message);
                                       Continue;
                                     end;
                                 end;

                                 IDENTITY_CTE_CAPA_ID := 0;
                                 Try

                                   varSQL  := 'SELECT @@IDENTITY as CTE_CAPA_ID ';

                                   FD_Insert_EntregaXML.Close;
                                   FD_Insert_EntregaXML.SQL.Clear;
                                   FD_Insert_EntregaXML.SQL.Add( varSQL );
                                   FD_Insert_EntregaXML.Open;
                                   IDENTITY_CTE_CAPA_ID := FD_Insert_EntregaXML.FieldByName('CTE_CAPA_ID').AsInteger;

                                 except
                                   On E:Exception do
                                     begin
                                      //  DB_Conect.SQLConnection.RollBack;

                                        Writeln( 'Falha ao pegar Chave CTE_CAPA.: ' +  PWideChar(  lArquivo ) );
                                        DB_Conect.doSaveLogImport(PastaLOG, GetComando(FD_Insert_EntregaXML) + #13#10 + 'Falha ao pegar chave da CTE_CAPA.' + E.Message);
                                        Continue;
                                      end;
                                 end;


                                 RetornarCodigoFornecedorNFE(Emit,IntToStr(ide.nNF));

                                 RetornarCodigoDestinatarioNFE(Dest,IntToStr(ide.nNF));
                                {
                                 varSQL := ' INSERT INTO [dbo].[CTE_EMITENTE]( ';
                                 varSQL := varSQL + ' cCT ';
                                 varSQL := varSQL + ',CTE_CAPA_ID ';
                                 varSQL := varSQL + ',CNPJCPF';
                                 varSQL := varSQL + ',IE';
                                 varSQL := varSQL + ',IEST';
                                 varSQL := varSQL + ',xNome';
                                 varSQL := varSQL + ',xFant';
                                 varSQL := varSQL + ',Fone';
                                 varSQL := varSQL + ',xCpl';
                                 varSQL := varSQL + ',xLgr';
                                 varSQL := varSQL + ',nro';
                                 varSQL := varSQL + ',xBairro';
                                 varSQL := varSQL + ',cMun';
                                 varSQL := varSQL + ',xMun';
                                 varSQL := varSQL + ',CEP';
                                 varSQL := varSQL + ',UF)';
                                 varSQL := varSQL + ' VALUES ( ' ;
                                 varSQL := varSQL + ':cCT ';
                                 varSQL := varSQL + ',:CTE_CAPA_ID ';
                                 varSQL := varSQL +',:CNPJCPF ';
                                 varSQL := varSQL +',:IE ';
                                 varSQL := varSQL +',:IEST ';
                                 varSQL := varSQL +',:xNome ';
                                 varSQL := varSQL +',:xFant ';
                                 varSQL := varSQL +',:Fone ';
                                 varSQL := varSQL +',:xCpl ';
                                 varSQL := varSQL +',:xLgr ';
                                 varSQL := varSQL +',:nro ';
                                 varSQL := varSQL +',:xBairro ';
                                 varSQL := varSQL +',:cMun';
                                 varSQL := varSQL +',:xMun';
                                 varSQL := varSQL +',:CEP';
                                 varSQL := varSQL +',:UF)';

                                 FD_Insert_EntregaXML.Close;
                                 FD_Insert_EntregaXML.SQL.Clear;
                                 FD_Insert_EntregaXML.SQL.Add( varSQL );

                                 FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                    := ide.nNF;
                                 FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                 FD_Insert_EntregaXML.ParamByName('CNPJCPF').AsString                 := Emit.CNPJCPF;
                                 FD_Insert_EntregaXML.ParamByName('IE').AsString                      := Emit.IE;
                                 FD_Insert_EntregaXML.ParamByName('IEST').AsString                    := Emit.IEST;
                                 FD_Insert_EntregaXML.ParamByName('xNome').AsString                   := Emit.xNome;
                                 FD_Insert_EntregaXML.ParamByName('xFant').AsString                   := Copy(Emit.xFant,1,40);
                                 FD_Insert_EntregaXML.ParamByName('Fone').AsString                    := Emit.EnderEmit.fone;
                                 FD_Insert_EntregaXML.ParamByName('xCpl').AsString                    := Emit.EnderEmit.xCpl;
                                 FD_Insert_EntregaXML.ParamByName('xLgr').AsString                    := Emit.EnderEmit.xLgr;
                                 FD_Insert_EntregaXML.ParamByName('nro').AsString                     := Emit.EnderEmit.nro;
                                 FD_Insert_EntregaXML.ParamByName('xBairro').AsString                 := Emit.EnderEmit.xBairro;
                                 FD_Insert_EntregaXML.ParamByName('cMun').AsString                    := IntToStr(Emit.EnderEmit.cMun);
                                 FD_Insert_EntregaXML.ParamByName('xMun').AsString                    := Emit.EnderEmit.xMun;

                                 FD_Insert_EntregaXML.ParamByName('CEP').AsString                     := IntToStr(Emit.EnderEmit.CEP);
                                 FD_Insert_EntregaXML.ParamByName('UF').AsString                      := Emit.EnderEmit.UF;

                                 try
                                   FD_Insert_EntregaXML.ExecSQL;
                                 except
                                   On E:Exception do
                                     begin
                                    //   DB_Conect.SQLConnection.RollBack;

                                       Writeln( 'Falha ao incluir CTE_EMITENTE: ' +  PWideChar(  PastaXML +  sr.Name ) );
                                       DB_Conect.doSaveLogImport(PastaLOG, GetComando(FD_Insert_EntregaXML) + #13#10 + 'Falha ao incluir CTE_EMITENTE.' + E.Message);
                                       Continue;
                                     end;
                                 end;

                                 tpRetorno.Inicializar;
                                 Try

                                   lSQL  := 'SELECT @@IDENTITY as CTE_EMITENTE_ID ';

                                   FD_Insert_EntregaXML.Close;
                                   FD_Insert_EntregaXML.SQL.Clear;
                                   FD_Insert_EntregaXML.SQL.Add( lSQL );
                                   FD_Insert_EntregaXML.Open;
                                   tpRetorno.trCodigo := FD_Insert_EntregaXML.FieldByName('CTE_EMITENTE_ID').AsString;

                                 except
                                   On E:Exception do
                                     begin
                                        DB_Conect.doSaveLogImport(PastaLOG, Db_Conect.GetComando(FD_Insert_EntregaXML) + #13#10 + 'Falha ao pegar chave da CTE_EMITENTE_ID.' + E.Message);
                                        Continue;
                                      end;
                                 end;
                                 }

                                 Try

                                    lSQL  := 'UPDATE CTE_CAPA SET CODFORNECEDOR = :CODFORNECEDOR, CODDESTINATARIO = :CODDESTINATARIO WHERE CTE_CAPA_ID = :CTE_CAPA_ID';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( lSQL );
                                    FD_Insert_EntregaXML.ParamByName('CODFORNECEDOR').AsString   := tpRetornoEmitente.trCodigo;
                                    FD_Insert_EntregaXML.ParamByName('CODDESTINATARIO').AsString := tpRetornoDestinatario.trCodigo;

                                    FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger   := IDENTITY_CTE_CAPA_ID;
                                    FD_Insert_EntregaXML.ExecSQL;

                                 except
                                   On E:Exception do
                                     begin
                                        DB_Conect.doSaveLogImport(PastaLOG, Db_Conect.GetComando(FD_Insert_EntregaXML) + #13#10 + 'Falha ao pegar chave da CTE_EMITENTE_ID.' + E.Message);
                                        Continue;
                                      end;
                                 end;
                                {
                                 varSQL := ' INSERT INTO [dbo].[CTE_Destinatario]( ';
                                 varSQL := varSQL + ' cCT ';
                                 varSQL := varSQL + ',CTE_CAPA_ID ';
                                 varSQL := varSQL + ',CNPJ';
                                 varSQL := varSQL + ',IE';
                              //   varSQL := varSQL + ',IEST';
                                 varSQL := varSQL + ',xNome';
                             //    varSQL := varSQL + ',xFant';
                              //   varSQL := varSQL + ',Fone';
                                 varSQL := varSQL + ',xCpl';
                                 varSQL := varSQL + ',xLgr';
                                 varSQL := varSQL + ',nro';
                                 varSQL := varSQL + ',xBairro';
                                 varSQL := varSQL + ',cMun';
                                 varSQL := varSQL + ',xMun';
                                 varSQL := varSQL + ',CEP';
                                 varSQL := varSQL + ',UF)';
                                 varSQL := varSQL + ' VALUES ( ' ;
                                 varSQL := varSQL + ':cCT ';
                                 varSQL := varSQL + ',:CTE_CAPA_ID ';
                                 varSQL := varSQL +',:CNPJ ';
                                 varSQL := varSQL +',:IE ';
                            //     varSQL := varSQL +',:IEST ';
                                 varSQL := varSQL +',:xNome ';
                          //       varSQL := varSQL +',:xFant ';
                        //         varSQL := varSQL +',:Fone ';
                                 varSQL := varSQL +',:xCpl ';
                                 varSQL := varSQL +',:xLgr ';
                                 varSQL := varSQL +',:nro ';
                                 varSQL := varSQL +',:xBairro ';
                                 varSQL := varSQL +',:cMun';
                                 varSQL := varSQL +',:xMun';
                                 varSQL := varSQL +',:CEP';
                                 varSQL := varSQL +',:UF)';

                                 FD_Insert_EntregaXML.Close;
                                 FD_Insert_EntregaXML.SQL.Clear;
                                 FD_Insert_EntregaXML.SQL.Add( varSQL );

                                 FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                    := ide.nNF;
                                 FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                 FD_Insert_EntregaXML.ParamByName('CNPJ').AsString                    := Dest.CNPJCPF;
                                 FD_Insert_EntregaXML.ParamByName('IE').AsString                      := Dest.IE;
                                // FD_Insert_EntregaXML.ParamByName('IEST').AsString                    := Dest.IEST;
                                 FD_Insert_EntregaXML.ParamByName('xNome').AsString                   := Dest.xNome;
                      //           FD_Insert_EntregaXML.ParamByName('xFant').AsString                   := Dest.xFant;
                      //           FD_Insert_EntregaXML.ParamByName('Fone').AsString                    := Dest.enderDest.fone;
                                 FD_Insert_EntregaXML.ParamByName('xCpl').AsString                    := Dest.enderDest.xCpl;
                                 FD_Insert_EntregaXML.ParamByName('xLgr').AsString                    := Dest.enderDest.xLgr;
                                 FD_Insert_EntregaXML.ParamByName('nro').AsString                     := Dest.enderDest.nro;
                                 FD_Insert_EntregaXML.ParamByName('xBairro').AsString                 := Dest.enderDest.xBairro;
                                 FD_Insert_EntregaXML.ParamByName('cMun').AsString                    := IntToStr(Dest.enderDest.cMun);
                                 FD_Insert_EntregaXML.ParamByName('xMun').AsString                    := Dest.enderDest.xMun;

                                 FD_Insert_EntregaXML.ParamByName('CEP').AsString                     := IntToStr(Dest.enderDest.CEP);
                                 FD_Insert_EntregaXML.ParamByName('UF').AsString                      := Dest.enderDest.UF;

                                 try
                                   FD_Insert_EntregaXML.ExecSQL;
                                 except
                                   On E:Exception do
                                     begin
                                     //  DB_Conect.SQLConnection.RollBack;

                                       Writeln( 'Falha ao incluir CTE_Destinatario: ' +  PWideChar(  PastaXML +  sr.Name ) );
                                       DB_Conect.doSaveLogImport(PastaLOG, GetComando(FD_Insert_EntregaXML) + #13#10 + 'Falha ao incluir CTE_Destinatario.' + E.Message);
                                       Continue;
                                     end;
                                 end;

                                  }

                                 varSQL := ' INSERT INTO [dbo].[CTE_Remetente]( ';
                                 varSQL := varSQL + ' cCT ';
                                 varSQL := varSQL + ',CTE_CAPA_ID ';
                                 varSQL := varSQL + ',CNPJ';
                                 varSQL := varSQL + ',IE';
                              //   varSQL := varSQL + ',IEST';
                                 varSQL := varSQL + ',xNome';
                             //    varSQL := varSQL + ',xFant';
                              //   varSQL := varSQL + ',Fone';
                                 varSQL := varSQL + ',xCpl';
                                 varSQL := varSQL + ',xLgr';
                                 varSQL := varSQL + ',nro';
                                 varSQL := varSQL + ',xBairro';
                                 varSQL := varSQL + ',cMun';
                                 varSQL := varSQL + ',xMun';
                                 varSQL := varSQL + ',CEP';
                                 varSQL := varSQL + ',UF';
                                 varSQL := varSQL + ',Email)';

                                 varSQL := varSQL + ' VALUES ( ' ;
                                 varSQL := varSQL + ':cCT ';
                                 varSQL := varSQL + ',:CTE_CAPA_ID ';
                                 varSQL := varSQL +',:CNPJ ';
                                 varSQL := varSQL +',:IE ';
                            //     varSQL := varSQL +',:IEST ';
                                 varSQL := varSQL +',:xNome ';
                          //       varSQL := varSQL +',:xFant ';
                        //         varSQL := varSQL +',:Fone ';
                                 varSQL := varSQL +',:xCpl ';
                                 varSQL := varSQL +',:xLgr ';
                                 varSQL := varSQL +',:nro ';
                                 varSQL := varSQL +',:xBairro ';
                                 varSQL := varSQL +',:cMun';
                                 varSQL := varSQL +',:xMun';
                                 varSQL := varSQL +',:CEP';
                                 varSQL := varSQL +',:UF';
                                 varSQL := varSQL +',:Email)';

                                 FD_Insert_EntregaXML.Close;
                                 FD_Insert_EntregaXML.SQL.Clear;
                                 FD_Insert_EntregaXML.SQL.Add( varSQL );

                                 FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                    := ide.nNF;
                                 FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                 FD_Insert_EntregaXML.ParamByName('CNPJ').AsString                    := Emit.CNPJCPF;
                                 FD_Insert_EntregaXML.ParamByName('IE').AsString                      := Emit.IE;
                                // FD_Insert_EntregaXML.ParamByName('IEST').AsString                    := Dest.IEST;
                                 FD_Insert_EntregaXML.ParamByName('xNome').AsString                   := Emit.xNome;
                      //           FD_Insert_EntregaXML.ParamByName('xFant').AsString                   := Dest.xFant;
                      //           FD_Insert_EntregaXML.ParamByName('Fone').AsString                    := Dest.enderDest.fone;
                                 FD_Insert_EntregaXML.ParamByName('xCpl').AsString                    := Emit.EnderEmit.xCpl;
                                 FD_Insert_EntregaXML.ParamByName('xLgr').AsString                    := Emit.EnderEmit.xLgr;
                                 FD_Insert_EntregaXML.ParamByName('nro').AsString                     := Emit.EnderEmit.nro;
                                 FD_Insert_EntregaXML.ParamByName('xBairro').AsString                 := Emit.EnderEmit.xBairro;
                                 FD_Insert_EntregaXML.ParamByName('cMun').AsString                    := IntToStr(Emit.EnderEmit.cMun);
                                 FD_Insert_EntregaXML.ParamByName('xMun').AsString                    := Emit.EnderEmit.xMun;

                                 FD_Insert_EntregaXML.ParamByName('CEP').AsString                     := IntToStr(Emit.EnderEmit.CEP);
                                 FD_Insert_EntregaXML.ParamByName('UF').AsString                      := Emit.EnderEmit.UF;
                                 FD_Insert_EntregaXML.ParamByName('Email').AsString                   := '';


                                 try
                                   FD_Insert_EntregaXML.ExecSQL;
                                 except
                                   On E:Exception do
                                     begin
                                  //     DB_Conect.SQLConnection.RollBack;

                                       Writeln( 'Falha ao incluir CTE_Remetente: ' +  PWideChar( lArquivo ) );
                                       DB_Conect.doSaveLogImport(PastaLOG, GetComando(FD_Insert_EntregaXML) + #13#10 + 'Falha ao incluir CTE_Remetente.' + E.Message);
                                       Continue;
                                     end;
                                 end;

                                 varSQL := ' INSERT INTO [dbo].[CTE_VPrest]( ';
                                 varSQL := varSQL + ' cCT ';
                                 varSQL := varSQL + ',CTE_CAPA_ID ';
                                 varSQL := varSQL + ' ,vTPrest ';
                                 varSQL := varSQL + ' ,vRec )';
                                 varSQL := varSQL + ' Values (';
                                 varSQL := varSQL + ' :cCT ';
                                 varSQL := varSQL + ',:CTE_CAPA_ID ';
                                 varSQL := varSQL + ' ,:vTPrest ';
                                 varSQL := varSQL + ' ,:vRec )';

                                 FD_Insert_EntregaXML.Close;
                                 FD_Insert_EntregaXML.SQL.Clear;
                                 FD_Insert_EntregaXML.SQL.Add( varSQL );

                                 FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                    := ide.nNF;
                                 FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                 FD_Insert_EntregaXML.ParamByName('vTPrest').asFloat                  := Total.ICMSTot.vNF;
                                 FD_Insert_EntregaXML.ParamByName('vRec').asFloat                     := Total.ICMSTot.vNF;

                                 try
                                   FD_Insert_EntregaXML.ExecSQL;
                                 except
                                   On E:Exception do
                                     begin
                                  //     DB_Conect.SQLConnection.RollBack;

                                       Writeln( 'Falha ao incluir CTE_VPrest: ' +  PWideChar( lArquivo ) );
                                       DB_Conect.doSaveLogImport(PastaLOG, GetComando(FD_Insert_EntregaXML) + #13#10 + 'Falha ao incluir CTE_VPrest.' + E.Message);
                                       Continue;
                                     end;
                                 end;


                                 for J := 0 to Det.Count-1 do
                                    begin
                                      with Det.Items[J] do
                                       begin
                                         pNovoCFOP := '';
                                         if OrigemDaNota = 'S' then
                                          pNovoCFOP := Prod.CFOP
                                         else if OrigemDaNota = 'E' then
                                           pNovoCFOP := DB_Conect.TrocarCFOP(Prod.CFOP);

                                        lSQL := 'Insert into CTE_Itens (';
                                        lSQL := lSQL + ' NumNf, ';
                                        lSQL := lSQL + ' CTE_CAPA_ID, ';
                                        lSQL := lSQL + ' CodFornecedor, ';
                                        lSQL := lSQL + ' CodProduto, ';
                                        lSQL := lSQL + ' DescProduto, ';
                                        lSQL := lSQL + ' UnidadeItem, ';
                                        lSQL := lSQL + ' CodFilial, ';
                                        lSQL := lSQL + ' NumItem,  ';
                                        lSQL := lSQL + ' CodNatureza, ';
                                        lSQL := lSQL + ' I_CFOP, ';
                                        lSQL := lSQL + ' CodGrupo, ';
                          //              lSQL := lSQL + ' DataEntrega, ';
                                        lSQL := lSQL + ' Qtde, ';
                                        lSQL := lSQL + ' ValorUnitario,  ';
                                        lSQL := lSQL + ' ValorTotal, ';
                                        lSQL := lSQL + ' ValorLiquido, ';
                                        lSQL := lSQL + ' Nf_TipoICMS, ';
                                        lSQL := lSQL + ' BaseICMSST,  ';
                                        lSQL := lSQL + ' ValorICMS_ST, ';
                                        lSQL := lSQL + ' Nf_IVA_ST, ';
                                        lSQL := lSQL + ' IVA_Original, ';
                                        lSQL := lSQL + ' BaseICMS_It,  ';
                                        lSQL := lSQL + ' BaseICMS , ';
                                        lSQL := lSQL + ' ValorICMS,';
                                        lSQL := lSQL + ' PorcICMS, ';
                                        lSQL := lSQL + ' Nf_TipoIPI,  ';
                                        lSQL := lSQL + ' BaseIPI, ';
                                        lSQL := lSQL + ' ValorIPI, ';
                                        lSQL := lSQL + ' PorcIPI, ';
                                        lSQL := lSQL + ' NF_TipoPIS,  ';
                                        lSQL := lSQL + ' BasePIS, ';
                                        lSQL := lSQL + ' ValorPIS ,  ';
                                        lSQL := lSQL + ' PorcPIS, ';
                                        lSQL := lSQL + ' NF_TipoCofins, ';
                                        lSQL := lSQL + ' BaseCOFINS,';
                                        lSQL := lSQL + ' ValorCofins, ';
                                        lSQL := lSQL + ' PorcCOFINS,  ';
                                        lSQL := lSQL + ' ValorFrete , ';
                                        lSQL := lSQL + ' VlrOutrasDespesas, ';
                                        lSQL := lSQL + ' VlrSeguro,  ';
                                        lSQL := lSQL + ' PorcProvICMSPartilha,  ';
                                        lSQL := lSQL + ' VlrFCP ,  ';
                                        lSQL := lSQL + ' VlrICMSUFDestino , ';
                                        lSQL := lSQL + ' VlrICMSUFRemetente ,  ';
                                        lSQL := lSQL + ' AliqFCP, ';
                                        lSQL := lSQL + ' DIFAL, ';
                                        lSQL := lSQL + ' PorcDesconto, ';
                                        lSQL := lSQL + ' ValorDesconto,  ';
                                        lSQL := lSQL + ' PorcCredito, ';
                                        lSQL := lSQL + ' NCM, ';
                                        lSQL := lSQL + ' VlrCredito ';
                                        lSQL := lSQL + ' ) Values (';
                                        lSQL := lSQL + ' :NumNf, ';
                                        lSQL := lSQL + ' :CTE_CAPA_ID, ';
                                        lSQL := lSQL + ' :CodFornecedor, ';
                                        lSQL := lSQL + ' :CodProduto, ';
                                        lSQL := lSQL + ' :DescProduto, ';
                                        lSQL := lSQL + ' :UnidadeItem, ';
                                        lSQL := lSQL + ' :CodFilial, ';
                                        lSQL := lSQL + ' :NumItem,  ';
                                        lSQL := lSQL + ' :CodNatureza, ';
                                        lSQL := lSQL + ' :I_CFOP, ';
                                        lSQL := lSQL + ' :CodGrupo, ';
                          //              lSQL := lSQL + ' :DataEntrega, ';
                                        lSQL := lSQL + ' :Qtde, ';
                                        lSQL := lSQL + ' :ValorUnitario,  ';
                                        lSQL := lSQL + ' :ValorTotal, ';
                                        lSQL := lSQL + ' :ValorLiquido, ';
                                        lSQL := lSQL + ' :Nf_TipoICMS, ';
                                        lSQL := lSQL + ' :BaseICMSST,  ';
                                        lSQL := lSQL + ' :ValorICMS_ST, ';
                                        lSQL := lSQL + ' :Nf_IVA_ST, ';
                                        lSQL := lSQL + ' :IVA_Original, ';
                                        lSQL := lSQL + ' :BaseICMS_It,  ';
                                        lSQL := lSQL + ' :BaseICMS , ';
                                        lSQL := lSQL + ' :ValorICMS,';
                                        lSQL := lSQL + ' :PorcICMS, ';
                                        lSQL := lSQL + ' :Nf_TipoIPI,  ';
                                        lSQL := lSQL + ' :BaseIPI, ';
                                        lSQL := lSQL + ' :ValorIPI, ';
                                        lSQL := lSQL + ' :PorcIPI, ';
                                        lSQL := lSQL + ' :NF_TipoPIS,  ';
                                        lSQL := lSQL + ' :BasePIS, ';
                                        lSQL := lSQL + ' :ValorPIS ,  ';
                                        lSQL := lSQL + ' :PorcPIS, ';
                                        lSQL := lSQL + ' :NF_TipoCofins, ';
                                        lSQL := lSQL + ' :BaseCOFINS,';
                                        lSQL := lSQL + ' :ValorCofins, ';
                                        lSQL := lSQL + ' :PorcCOFINS,  ';
                                        lSQL := lSQL + ' :ValorFrete , ';
                                        lSQL := lSQL + ' :VlrOutrasDespesas, ';
                                        lSQL := lSQL + ' :VlrSeguro,  ';
                                        lSQL := lSQL + ' :PorcProvICMSPartilha,  ';
                                        lSQL := lSQL + ' :VlrFCP ,  ';
                                        lSQL := lSQL + ' :VlrICMSUFDestino , ';
                                        lSQL := lSQL + ' :VlrICMSUFRemetente ,  ';
                                        lSQL := lSQL + ' :AliqFCP, ';
                                        lSQL := lSQL + ' :DIFAL, ';
                                        lSQL := lSQL + ' :PorcDesconto, ';
                                        lSQL := lSQL + ' :ValorDesconto,  ';
                                        lSQL := lSQL + ' :PorcCredito, ';
                                        lSQL := lSQL + ' :NCM, ';
                                        lSQL := lSQL + ' :VlrCredito ';
                                        lSQL := lSQL + '  )';

                                         FD_Insert_EntregaXML.Close;
                                         FD_Insert_EntregaXML.Sql.Clear;
                                         FD_Insert_EntregaXML.SQL.Add(lSQL);

                                         //RetornaCodigoProduto(tpRetorno.trCodFornecedor,Prod.cProd,Prod.NCM, Prod.xProd);

                                         FD_Insert_EntregaXML.ParamByName('NumNf').AsInteger        := Ide.nNF;
                                         FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger  := IDENTITY_CTE_CAPA_ID;

                                         FD_Insert_EntregaXML.ParamByName('CodFornecedor').AsString := tpRetorno.trCodigo;

                                         FD_Insert_EntregaXML.ParamByName('CodProduto').AsString    := Prod.cProd;
                                         FD_Insert_EntregaXML.ParamByName('DescProduto').AsString   := Prod.xProd;

                                         FD_Insert_EntregaXML.ParamByName('UnidadeItem').AsString   := prod.uCom;
                                         FD_Insert_EntregaXML.ParamByName('CodFilial').AsString     := varFilialID;
                                         FD_Insert_EntregaXML.ParamByName('NumItem').AsInteger      := Prod.nItem;
                                         FD_Insert_EntregaXML.ParamByName('CodNatureza').AsString   := pNovoCFOP;
                                         FD_Insert_EntregaXML.ParamByName('I_CFOP').AsString        := pNovoCFOP;
                                         FD_Insert_EntregaXML.ParamByName('CodGrupo').AsString      := '0'; //tpProduto.trCodGrupo;
                                        // qryAux.ParamByName('DataEntrega').AsSQLTimeStamp  := DateTimeToSQLTimeStamp(Ide.dEmi);
                                         FD_Insert_EntregaXML.ParamByName('Qtde').asFloat           := Prod.qCom;
                                         FD_Insert_EntregaXML.ParamByName('ValorUnitario').asFloat  := Prod.vUnCom;
                                         FD_Insert_EntregaXML.ParamByName('ValorTotal').asFloat     := Prod.vProd;
                                         FD_Insert_EntregaXML.ParamByName('ValorLiquido').asFloat   := Prod.vProd;

                                         with Imposto do
                                         begin
                                              with ICMS do
                                              begin
                                                 if ((tpRetorno.trRegimeICMS = '1') or (tpRetorno.trRegimeICMS = '2'))  then
                                                   FD_Insert_EntregaXML.ParamByName('Nf_TipoICMS').AsString   := CSOSNIcmsToStr(CSOSN)
                                                 else  FD_Insert_EntregaXML.ParamByName('Nf_TipoICMS').AsString   := CSTICMSToStr(CST);

                                                 FD_Insert_EntregaXML.ParamByName('BaseICMSST').AsFloat     := ICMS.vBCST;
                                                 FD_Insert_EntregaXML.ParamByName('ValorICMS_ST').AsFloat   := ICMS.vICMSST;
                                                 FD_Insert_EntregaXML.ParamByName('Nf_IVA_ST').asFloat      := 0;
                                                 FD_Insert_EntregaXML.ParamByName('IVA_Original').asFloat   := ICMS.pMVAST;
                                                 FD_Insert_EntregaXML.ParamByName('BaseICMS_It').asFloat    := ICMS.vBCST;

                                                 FD_Insert_EntregaXML.ParamByName('BaseICMS').AsFloat       := ICMS.vBC;
                                                 FD_Insert_EntregaXML.ParamByName('ValorICMS').AsFloat      := ICMS.vICMS;
                                                 FD_Insert_EntregaXML.ParamByName('PorcICMS').asFloat       := ICMS.pICMS;
                                              end;


                                              if (IPI.vBC > 0) then
                                              begin
                                                  with IPI do
                                                  begin
                                                     FD_Insert_EntregaXML.ParamByName('Nf_TipoIPI').AsString    := CSTIPIToStr(CST);
                                                     FD_Insert_EntregaXML.ParamByName('BaseIPI').AsFloat        := vBC;
                                                     FD_Insert_EntregaXML.ParamByName('ValorIPI').AsFloat       := vIPI;
                                                     FD_Insert_EntregaXML.ParamByName('PorcIPI').asFloat        := pIPI;
                                                  end;
                                              end
                                              else
                                              begin
                                                  with IPI do
                                                  begin
                                                     FD_Insert_EntregaXML.ParamByName('Nf_TipoIPI').AsString    := CSTIPIToStr(CST);
                                                     FD_Insert_EntregaXML.ParamByName('BaseIPI').AsFloat        := 0;
                                                     FD_Insert_EntregaXML.ParamByName('ValorIPI').AsFloat       := 0;
                                                     FD_Insert_EntregaXML.ParamByName('PorcIPI').asFloat        := 0;
                                                  end;
                                              end;


                                              with PIS do
                                              begin
                                                 FD_Insert_EntregaXML.ParamByName('NF_TipoPIS').AsString       := CSTPISToStr(CST) ;
                                                 if (CST = pis01) or (CST = pis02) then
                                                  begin
                                                    FD_Insert_EntregaXML.ParamByName('BasePIS').AsFloat        := PIS.vBC;
                                                    FD_Insert_EntregaXML.ParamByName('ValorPIS').AsFloat       := PIS.vPIS;
                                                    FD_Insert_EntregaXML.ParamByName('PorcPIS').asFloat        := PIS.pPIS;
                                                  end
                                                 else if CST = pis03 then
                                                  begin
                                                    FD_Insert_EntregaXML.ParamByName('BasePIS').AsFloat        := PIS.qBCProd;
                                                    FD_Insert_EntregaXML.ParamByName('ValorPIS').AsFloat       := PIS.vPIS;
                                                    FD_Insert_EntregaXML.ParamByName('PorcPIS').asFloat        := PIS.vAliqProd;
                                                  end
                                                 else if CST = pis99 then
                                                  begin
                                                    FD_Insert_EntregaXML.ParamByName('BasePIS').AsFloat        := PIS.vBC;
                                                    FD_Insert_EntregaXML.ParamByName('ValorPIS').AsFloat       := PIS.vPIS;
                                                    FD_Insert_EntregaXML.ParamByName('PorcPIS').asFloat        := PIS.pPIS;
                                                 end
                                                 else
                                                 begin
                                                    FD_Insert_EntregaXML.ParamByName('BasePIS').AsFloat        := 0;
                                                    FD_Insert_EntregaXML.ParamByName('ValorPIS').AsFloat       := 0;
                                                    FD_Insert_EntregaXML.ParamByName('PorcPIS').asFloat        := 0;
                                                 end;
                                              end;

                                              with COFINS do
                                              begin
                                                 FD_Insert_EntregaXML.ParamByName('NF_TipoCofins').AsString    := CSTCOFINSToStr(CST);
                                                 if (CST = cof01) or (CST = cof02)   then
                                                  begin
                                                   FD_Insert_EntregaXML.ParamByName('BaseCOFINS').AsFloat     := COFINS.vBC;
                                                   FD_Insert_EntregaXML.ParamByName('ValorCofins').AsFloat    := COFINS.vCOFINS;
                                                   FD_Insert_EntregaXML.ParamByName('PorcCOFINS').asFloat     := COFINS.pCOFINS;
                                                  end
                                                 else if CST = cof03 then
                                                  begin
                                                   FD_Insert_EntregaXML.ParamByName('BaseCOFINS').AsFloat     := COFINS.qBCProd;
                                                   FD_Insert_EntregaXML.ParamByName('ValorCofins').AsFloat    := COFINS.vCOFINS;
                                                   FD_Insert_EntregaXML.ParamByName('PorcCOFINS').asFloat     := COFINS.vAliqProd;
                                                  end
                                                 else if CST = cof99 then
                                                  begin
                                                   FD_Insert_EntregaXML.ParamByName('BaseCOFINS').AsFloat     := COFINS.vBC;
                                                   FD_Insert_EntregaXML.ParamByName('ValorCofins').AsFloat    := COFINS.vCOFINS;
                                                   FD_Insert_EntregaXML.ParamByName('PorcCOFINS').asFloat     := COFINS.vAliqProd;
                                                  end
                                                  else
                                                  begin
                                                   FD_Insert_EntregaXML.ParamByName('BaseCOFINS').AsFloat     := 0;
                                                   FD_Insert_EntregaXML.ParamByName('ValorCofins').AsFloat    := 0;
                                                   FD_Insert_EntregaXML.ParamByName('PorcCOFINS').asFloat     := 0;
                                                  end;
                                              end;


                                              FD_Insert_EntregaXML.ParamByName('ValorFrete').AsFloat            := Prod.vFrete;
                                              FD_Insert_EntregaXML.ParamByName('VlrOutrasDespesas').AsFloat     := Prod.vOutro;
                                              FD_Insert_EntregaXML.ParamByName('VlrSeguro').AsFloat             := Prod.vSeg;

                                              with ICMSUFDest do
                                              begin
                                                FD_Insert_EntregaXML.ParamByName('PorcProvICMSPartilha').AsFloat  := pICMSInterPart;
                                                FD_Insert_EntregaXML.ParamByName('VlrFCP').AsFloat                := vFCPUFDest;
                                                FD_Insert_EntregaXML.ParamByName('VlrICMSUFDestino').AsFloat      := vICMSUFDest;
                                                FD_Insert_EntregaXML.ParamByName('VlrICMSUFRemetente').AsFloat    := vICMSUFRemet;
                                                FD_Insert_EntregaXML.ParamByName('AliqFCP').AsFloat               := pFCPUFDest;
                                                FD_Insert_EntregaXML.ParamByName('DIFAL').AsFloat                 := pICMSInter;
                                              end;

                                              FD_Insert_EntregaXML.ParamByName('PorcDesconto').asFloat   := 0;
                                              FD_Insert_EntregaXML.ParamByName('ValorDesconto').asFloat  := Prod.vDesc;
                                              FD_Insert_EntregaXML.ParamByName('PorcCredito').asFloat    := ICMS.pCredSN;
                                              FD_Insert_EntregaXML.ParamByName('NCM').AsString           := Prod.NCM;
                                              FD_Insert_EntregaXML.ParamByName('VlrCredito').AsFloat     := ICMS.vCredICMSSN;

                                              if (ICMS.pCredSN > 0) then
                                               DB_Conect.GravaCreditoSimplesNacional(tpRetorno.trCodigo, Ide.dEmi,ICMS.pCredSN);


                                         end;

                                      end ;

                                      try
                                          FD_Insert_EntregaXML.ExecSQL;
                                      except

                                        On E:Exception do
                                          begin

                                             DB_Conect.doSaveLogImport(PastaLOG, lArquivo + #13#10 + 'Falha ao incluir CTE_ITENS.' + E.Message);
                                             Continue;
                                          end;
                                      end;

                                    end;

                                    // Itens da Nota
                                 for J := 0 to Det.Count-1 do
                                  begin
                                    with Det.Items[J] do
                                     begin

                                       lSQL := ' INSERT INTO [dbo].[CTE_IMPOSTOS]( ';
                                       lSQL := lSQL + ' cCT';
                                       lSQL := lSQL + ',CTE_CAPA_ID ';
                                       lSQL := lSQL + ' ,SituTrib';
                                       lSQL := lSQL + ' ,CST';
                                       lSQL := lSQL + ' ,pRedBC';
                                       lSQL := lSQL + ' ,pICMS';
                                       lSQL := lSQL + ' ,vCred';
                                       lSQL := lSQL + ' ,vBC';
                                       lSQL := lSQL + ' ,vICMS';
                                       lSQL := lSQL + ' ,infAdFisco';
                                       lSQL := lSQL + ' ,vTotTrib';
                                       lSQL := lSQL + ' ,vPIS';
                                       lSQL := lSQL + ' ,vCOFINS';
                                       lSQL := lSQL + ' ,vIR';
                                       lSQL := lSQL + ' ,vINSS';
                                       lSQL := lSQL + ' ,vCSLL';
                                       lSQL := lSQL + ' ,CFOP)';


                                       lSQL := lSQL + ' Values (';
                                       lSQL := lSQL + ' :cCT';
                                       lSQL := lSQL + ' ,:CTE_CAPA_ID ';
                                       lSQL := lSQL + ' ,:SituTrib';
                                       lSQL := lSQL + ' ,:CST';
                                       lSQL := lSQL + ' ,:pRedBC';
                                       lSQL := lSQL + ' ,:pICMS';
                                       lSQL := lSQL + ' ,:vCred';
                                       lSQL := lSQL + ' ,:vBC';
                                       lSQL := lSQL + ' ,:vICMS';
                                       lSQL := lSQL + ' ,:infAdFisco';
                                       lSQL := lSQL + ' ,:vTotTrib';
                                       lSQL := lSQL + ' ,:vPIS';
                                       lSQL := lSQL + ' ,:vCOFINS';
                                       lSQL := lSQL + ' ,:vIR';
                                       lSQL := lSQL + ' ,:vINSS';
                                       lSQL := lSQL + ' ,:vCSLL';
                                       lSQL := lSQL + ' ,:CFOP)';


                                       FD_Insert_EntregaXML.Close;
                                       FD_Insert_EntregaXML.SQL.Clear;
                                       FD_Insert_EntregaXML.SQL.Add( lSQL );
                                       FD_Insert_EntregaXML.ParamByName('cCT').AsInteger                    := ide.nNF;
                                       FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger            := IDENTITY_CTE_CAPA_ID;
                                       if (CSTICMSToStr(Imposto.ICMS.CST) <> '') then
                                       begin
                                         FD_Insert_EntregaXML.ParamByName('SituTrib').asString               := CSTICMSToStr(Imposto.ICMS.CST);
                                         FD_Insert_EntregaXML.ParamByName('CST').asString                    := CSTICMSToStr(Imposto.ICMS.CST);
                                       end
                                       else
                                       begin
                                         FD_Insert_EntregaXML.ParamByName('SituTrib').asString               := CSOSNIcmsToStr(Imposto.ICMS.CSOSN);
                                         FD_Insert_EntregaXML.ParamByName('CST').asString                    := CSOSNIcmsToStr(Imposto.ICMS.CSOSN);
                                       end;

                                       FD_Insert_EntregaXML.ParamByName('pRedBC').AsFloat                    := 0;
                                       FD_Insert_EntregaXML.ParamByName('pICMS').AsFloat                     := Imposto.ICMS.pICMS;
                                       FD_Insert_EntregaXML.ParamByName('vCred').AsFloat                     := 0;


                                       if (Imposto.ICMS.vBCST > 0) then
                                       begin
                                         FD_Insert_EntregaXML.ParamByName('vBC').AsFloat                       := Imposto.ICMS.vBCST;
                                         FD_Insert_EntregaXML.ParamByName('vICMS').AsFloat                     := Imposto.ICMS.vICMSST;
                                        end
                                        else
                                        begin
                                         FD_Insert_EntregaXML.ParamByName('vBC').AsFloat                       := Imposto.ICMS.vBC;
                                         FD_Insert_EntregaXML.ParamByName('vICMS').AsFloat                     := Imposto.ICMS.vICMS;
                                       end;
                                       FD_Insert_EntregaXML.ParamByName('infAdFisco').AsString                 := '';
                                       FD_Insert_EntregaXML.ParamByName('vTotTrib').AsFloat                    := Imposto.vTotTrib ;
                                       FD_Insert_EntregaXML.ParamByName('vPIS').AsFloat                        := Imposto.PIS.vPIS;
                                       FD_Insert_EntregaXML.ParamByName('vCOFINS').AsFloat                     := Imposto.COFINS.vCOFINS;
                                       FD_Insert_EntregaXML.ParamByName('vIR').AsFloat                         := 0;
                                       FD_Insert_EntregaXML.ParamByName('vINSS').AsFloat                       := 0;
                                       FD_Insert_EntregaXML.ParamByName('vCSLL').AsFloat                       := 0;
                                       FD_Insert_EntregaXML.ParamByName('CFOP').AsString                       := pNovoCFOP;


                                       try
                                         FD_Insert_EntregaXML.ExecSQL;

                                       except
                                         On E:Exception do
                                           begin

                                             DB_Conect.doSaveLogImport(PastaLOG, lArquivo + #13#10 + 'Falha ao incluir CTE_IMPOSTOS.' + E.Message);
                                             Continue;
                                           end;
                                       end;


                                     end;
                                  end;


                                 try
                                   varSQL := 'insert into XML_IMPORTADA(cCT,CTE_CAPA_ID,DataEmissao,nCT,CHCTE,CodUsuario, TipoXML)';
                                   varSQL := varSQL + ' values( :cCT,:CTE_CAPA_ID,:DataEmissao,:nCT,:CHCTE,:CodUsuario, :TipoXML)';


                                   FD_Insert_EntregaXML.Close;
                                   FD_Insert_EntregaXML.SQL.Clear;
                                   FD_Insert_EntregaXML.SQL.Add( varSQL );

                                   FD_Insert_EntregaXML.ParamByName('cCT').asInteger               := ide.nNF;
                                   FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger       := IDENTITY_CTE_CAPA_ID;
                                   FD_Insert_EntregaXML.ParamByName('DataEmissao').AsSQLTimeStamp  := DateTimeToSQLTimeStamp(Ide.dEmi);
                                   FD_Insert_EntregaXML.ParamByName('nCT').AsString                := IntToStr(Ide.nNF);
                                   FD_Insert_EntregaXML.ParamByName('CHCTE').AsString              := procNFe.chNFe;
                                   FD_Insert_EntregaXML.ParamByName('CodUsuario').AsString         := '1';
                                   FD_Insert_EntregaXML.ParamByName('TipoXML').AsString            := 'NFE';


                                 finally

                                   try
                                     FD_Insert_EntregaXML.ExecSQL;
                                     MoveFile( PWideChar( lArquivo ) , PWideChar( lArquivoImportado ) );
                                   except
                                     On E:Exception do
                                       begin
                                  //      DB_Conect.SQLConnection.RollBack;

                                        DB_Conect.doSaveLogImport(PastaLOG, GetComando(FD_Insert_EntregaXML) + ' ' +  'Falha ao incluir XML_IMPORTADA.' + E.Message);
                                        Writeln( 'Falha ao incluir XML_IMPORTADA: ' +  PWideChar( lArquivo  ) );
                                       end;
                                   end;

                                 end;

                                    // Fim Guarda Arquivo XML
                                end;

                              end;
                                //DB_Conect.SQLConnection.Commit;
                          except
                           // btnImportar.Enabled  := False;

                          //  DB_Conect.DB_Conect.doSaveLogImport(lPathLog, ' Arquivo ' + rgXML.Properties.Items[rgXML.ItemIndex].Caption  + ' Inv�lido ' + PWideChar(  lPath +  sr.Name ));
                            Continue;
                          end;
                        end;
                        varSQL := '';

                        if varTipoNota = -1 then
                        begin
                             XMLDoc := TXMLDocument.Create(application);
                             XMLDoc.XML.Clear;

                             lArquivoImportado := 'C:\MLSISTEMAS_LIDOS\'  + StrTran(ExtractFilePath( Listtemp3.Strings[i]), PastaRAIZ, '');
                             if not DirExists(  lArquivoImportado ) then
                             begin
                               if not ForceDirectories(  lArquivoImportado ) then
                                 Exit;
                             end;
                             lArquivoImportado := lArquivoImportado  + ExtractFileName(lArquivo);

                             try
                               XMLDoc.LoadFromFile(lArquivo);
                             except
                                 XMLDoc.XML.Clear;
                                 MoveFile( PWideChar(   lArquivo) , PWideChar( lArquivoImportado ) );
                                 DB_Conect.doSaveLogImport(PastaLOG, 'Arquivo Inv�lido ' +  PWideChar(  lArquivoImportado ));
                                 Continue;
                             end;

                             XMLDoc.Active := True;
                             Try
                                retEvento := XMLDoc.DocumentElement.ChildNodes.FindNode('retEvento');
                                infEvento := retEvento.ChildNodes.FindNode('infEvento');
                             except
                                  MoveFile( PWideChar(   lArquivo) , PWideChar( lArquivoImportado ) );
                                  DB_Conect.doSaveLogImport(PastaLOG, 'N� Inv�lido ' +  PWideChar(  lArquivoImportado ));
                                  XMLDoc.XML.Clear;
                                  Continue;
                             End;

                             Try
                                with FD_Consulta_EntregaXML do
                                begin
                                  Close;
                                  SQL.Clear;
                                  SQL.Add(' SELECT cCT FROM XML_IMPORTADA  ');
                                  SQL.Add(' WHERE cCT  = :cCT ');
                                  SQL.Add(' and nCT = :nCT ');
                                  SQL.Add(' and CHCTE = :CHCTE ');
                                  SQL.Add(' and TipoXML = :TipoXML ');

                                  ParamByName('cCT').asInteger               := StrToInt(infEvento.ChildNodes['tpEvento'].Text);
                                  ParamByName('nCT').AsString                := infEvento.ChildNodes['tpEvento'].Text;
                                  ParamByName('CHCTE').AsString              := infEvento.ChildNodes['chNFe'].Text;
                                  ParamByName('TipoXML').AsString            := 'CCE';
                                  Open;
                                end;
                             except
                                Try
                                  with FD_Consulta_EntregaXML do
                                  begin
                                        Close;
                                        SQL.Clear;
                                        SQL.Add(' SELECT cCT FROM XML_IMPORTADA  ');
                                        SQL.Add(' WHERE cCT  = :cCT ');
                                        SQL.Add(' and nCT = :nCT ');
                                        SQL.Add(' and CHCTE = :CHCTE ');
                                        SQL.Add(' and TipoXML = :TipoXML ');
                                        infEvento := retEvento.ChildNodes.FindNode('retEnvEvento');
                                        ParamByName('cCT').asInteger               := StrToInt(infEvento.ChildNodes['tpEvento'].Text);
                                        ParamByName('nCT').AsString                := infEvento.ChildNodes['tpEvento'].Text;
                                        ParamByName('CHCTE').AsString              := infEvento.ChildNodes['chNFe'].Text;
                                        ParamByName('TipoXML').AsString            := 'CCE';
                                        Open;
                                  end;
                                 except
                                     with FD_Consulta_EntregaXML do
                                     begin
                                      Close;
                                      SQL.Clear;
                                      SQL.Add(' SELECT cCT FROM XML_IMPORTADA  ');
                                      SQL.Add(' WHERE cCT  = :cCT ');
                                      SQL.Add(' and nCT = :nCT ');
                                      SQL.Add(' and CHCTE = :CHCTE ');
                                      SQL.Add(' and TipoXML = :TipoXML ');
                                      infEvento      := retEvento.ChildNodes.FindNode('retEnvEvento');
                                      subinfEvento   := infEvento.ChildNodes.FindNode('retEvento');
                                      _subinfEvento  := subinfEvento.ChildNodes.FindNode('infEvento');
                                      ParamByName('cCT').asInteger               := StrToInt(_subinfEvento.ChildNodes['tpEvento'].Text);
                                      ParamByName('nCT').AsString                := _subinfEvento.ChildNodes['tpEvento'].Text;
                                      ParamByName('CHCTE').AsString              := _subinfEvento.ChildNodes['chNFe'].Text;
                                      ParamByName('TipoXML').AsString            := 'CCE';
                                      Open;
                                     end;
                                  end;
                             end;


                             if not FD_Consulta_EntregaXML.IsEmpty then
                             begin
                                XMLDoc.XML.Clear;
                                MoveFile( PWideChar(  lArquivo ) , PWideChar(  lArquivoImportado ) );
                                DB_Conect.doSaveLogImport(PastaLOG, 'Existente ' +  PWideChar(  lArquivoImportado));
                                Continue;
                             end;

                             lSQL := ' Insert into CTE_OUTRAS (xMotivo, chNFe, tpEvento, xEvento, dhRegEvento, nProt) ';
                             lSQL := lSQL +             ' Values ( :xMotivo, :chNFe, :tpEvento, :xEvento, :dhRegEvento, :nProt) ';

                             FD_Consulta_EntregaXML.Close;
                             FD_Consulta_EntregaXML.SQL.Clear;
                             FD_Consulta_EntregaXML.SQL.Add( lSQL );
                             Try
                                 FD_Consulta_EntregaXML.ParamByName('xMotivo').asString     := infEvento.ChildNodes['xMotivo'].Text;
                                 FD_Consulta_EntregaXML.ParamByName('chNFe').asString       := infEvento.ChildNodes['chNFe'].Text;
                                 if FD_Consulta_EntregaXML.ParamByName('chNFe').asString <> '' then
                                 begin
                                   FD_Consulta_EntregaXML.ParamByName('tpEvento').asString    := infEvento.ChildNodes['tpEvento'].Text;
                                   FD_Consulta_EntregaXML.ParamByName('xEvento').asString     := infEvento.ChildNodes['xEvento'].Text;
                                   FD_Consulta_EntregaXML.ParamByName('dhRegEvento').asString := infEvento.ChildNodes['dhRegEvento'].Text;
                                   FD_Consulta_EntregaXML.ParamByName('nProt').asString       := infEvento.ChildNodes['nProt'].Text;
                                 end
                                 else
                                 begin
                                   infEvento      := retEvento.ChildNodes.FindNode('retEnvEvento');
                                   subinfEvento   := infEvento.ChildNodes.FindNode('retEvento');
                                   _subinfEvento  := subinfEvento.ChildNodes.FindNode('infEvento');
                                   FD_Consulta_EntregaXML.ParamByName('xMotivo').asString     := _subinfEvento.ChildNodes['xMotivo'].Text;
                                   FD_Consulta_EntregaXML.ParamByName('chNFe').asString       := _subinfEvento.ChildNodes['chNFe'].Text;
                                   FD_Consulta_EntregaXML.ParamByName('tpEvento').asString    := _subinfEvento.ChildNodes['tpEvento'].Text;
                                   FD_Consulta_EntregaXML.ParamByName('xEvento').asString     := _subinfEvento.ChildNodes['xEvento'].Text;
                                   FD_Consulta_EntregaXML.ParamByName('dhRegEvento').asString := _subinfEvento.ChildNodes['dhRegEvento'].Text;
                                   FD_Consulta_EntregaXML.ParamByName('nProt').asString       := _subinfEvento.ChildNodes['nProt'].Text;
                                 end;
                             except
                                   Try
                                       FD_Consulta_EntregaXML.ParamByName('xMotivo').asString     := infEvento.ChildNodes['xMotivo'].Text;
                                       FD_Consulta_EntregaXML.ParamByName('chNFe').asString       := infEvento.ChildNodes['chNFe'].Text;
                                       FD_Consulta_EntregaXML.ParamByName('tpEvento').asString    := infEvento.ChildNodes['tpEvento'].Text;
                                       FD_Consulta_EntregaXML.ParamByName('xEvento').asString     := infEvento.ChildNodes['xEvento'].Text;
                                       FD_Consulta_EntregaXML.ParamByName('dhRegEvento').asString := infEvento.ChildNodes['dhRegEvento'].Text;
                                       FD_Consulta_EntregaXML.ParamByName('nProt').asString       := infEvento.ChildNodes['nProt'].Text;
                                   except
                                       infEvento      := retEvento.ChildNodes.FindNode('retEnvEvento');
                                       subinfEvento   := infEvento.ChildNodes.FindNode('retEvento');
                                       _subinfEvento  := subinfEvento.ChildNodes.FindNode('infEvento');
                                       FD_Consulta_EntregaXML.ParamByName('xMotivo').asString     := _subinfEvento.ChildNodes['xMotivo'].Text;
                                       FD_Consulta_EntregaXML.ParamByName('chNFe').asString       := _subinfEvento.ChildNodes['chNFe'].Text;
                                       FD_Consulta_EntregaXML.ParamByName('tpEvento').asString    := _subinfEvento.ChildNodes['tpEvento'].Text;
                                       FD_Consulta_EntregaXML.ParamByName('xEvento').asString     := _subinfEvento.ChildNodes['xEvento'].Text;
                                       FD_Consulta_EntregaXML.ParamByName('dhRegEvento').asString := _subinfEvento.ChildNodes['dhRegEvento'].Text;
                                       FD_Consulta_EntregaXML.ParamByName('nProt').asString       := _subinfEvento.ChildNodes['nProt'].Text;
                                   End;
                             End;
                             try
                                    FD_Consulta_EntregaXML.ExecSQL;
                                    IDENTITY_ID := 0;
                                    Try

                                      lSQL  := 'SELECT @@IDENTITY as CTE_CAPA_ID ';

                                      FD_Consulta_EntregaXML.Close;
                                      FD_Consulta_EntregaXML.SQL.Clear;
                                      FD_Consulta_EntregaXML.SQL.Add( lSQL );
                                      FD_Consulta_EntregaXML.Open;
                                      IDENTITY_ID := FD_Consulta_EntregaXML.FieldByName('CTE_CAPA_ID').AsInteger;

                                    except
                                      On E:Exception do
                                        begin
                                           DB_Conect.doSaveLogImport(PastaLOG, DB_Conect.GetComando(FD_Consulta_EntregaXML) + #13#10 + 'Falha ao pegar chave da CTE_OUTRAS.' + E.Message);
                                           Continue;
                                         end;
                                    end;

                                     // Guardar Arquivo XML
                                   try
                                     lSQL := 'Insert into XML_IMPORTADA(cCT,  CTE_CAPA_ID, nCT,CHCTE,CodUsuario, TipoXML, ArquivoXML)';
                                     lSQL := lSQL + ' values( :cCT,  :CTE_CAPA_ID, :nCT,:CHCTE,:CodUsuario, :TipoXML ';
                                     lSQL := lSQL + ',' + QuotedStr( XMLDoc.XML.Text ) + ')';


                                     FD_Consulta_EntregaXML.Close;
                                     FD_Consulta_EntregaXML.SQL.Clear;
                                     FD_Consulta_EntregaXML.SQL.Add( lSQL );
                                     Try
                                        FD_Consulta_EntregaXML.ParamByName('cCT').asInteger               := StrToInt(infEvento.ChildNodes['tpEvento'].Text);
                                        FD_Consulta_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger       := IDENTITY_ID;
                                        FD_Consulta_EntregaXML.ParamByName('nCT').AsString                := infEvento.ChildNodes['tpEvento'].Text;
                                        FD_Consulta_EntregaXML.ParamByName('CHCTE').AsString              := infEvento.ChildNodes['chNFe'].Text;
                                        FD_Consulta_EntregaXML.ParamByName('CodUsuario').AsString         := '2';
                                        FD_Consulta_EntregaXML.ParamByName('TipoXML').AsString            := 'CCE';
                                     except
                                        infEvento      := retEvento.ChildNodes.FindNode('retEnvEvento');
                                        subinfEvento   := infEvento.ChildNodes.FindNode('retEvento');
                                        _subinfEvento  := subinfEvento.ChildNodes.FindNode('infEvento');
                                        FD_Consulta_EntregaXML.ParamByName('cCT').asInteger               := StrToInt(_subinfEvento.ChildNodes['tpEvento'].Text);
                                        FD_Consulta_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger       := IDENTITY_ID;
                                        FD_Consulta_EntregaXML.ParamByName('nCT').AsString                := _subinfEvento.ChildNodes['tpEvento'].Text;
                                        FD_Consulta_EntregaXML.ParamByName('CHCTE').AsString              := _subinfEvento.ChildNodes['chNFe'].Text;
                                        FD_Consulta_EntregaXML.ParamByName('CodUsuario').AsString         := '2';
                                        FD_Consulta_EntregaXML.ParamByName('TipoXML').AsString            := 'CCE';
                                     End;

                                   finally

                                     try
                                       FD_Consulta_EntregaXML.ExecSQL;
                                       XMLDoc.XML.Clear;
                                       MoveFile( PWideChar(  lArquivo ) , PWideChar( lArquivoImportado) );
                                     except
                                       On E:Exception do
                                         begin
                                           DB_Conect.doSaveLogImport(PastaLOG, DB_Conect.GetComando(FD_Consulta_EntregaXML) + ' ' +  'Falha ao incluir XML.' + E.Message);
                                         end;
                                     end;

                                   end;

                                except
                                  On E:Exception do
                                    begin
                                     DB_Conect.doSaveLogImport(PastaLOG, DB_Conect.GetComando(FD_Consulta_EntregaXML) + ' ' +  'Falha ao incluir Outro Tipo de Nota.' + E.Message);
                                    end;
                                end;
                          {
                           XMLDoc := TXMLDocument.Create(application);
                           Try
                            XMLDoc.XML.Clear;
                            try
                              XMLDoc.LoadFromFile(PastaXML +  sr.Name);
                            except
                               MoveFile( PWideChar(   PastaXML  +  sr.Name ) , PWideChar( PastaXML_LIDO +  sr.Name ) );
                               DB_Conect.doSaveLogImport(PastaLOG, 'Arquivo Inv�lido ' +  PWideChar(  PastaXML_LIDO +  sr.Name ));
                               Writeln( 'Arquivo Inv�lido: ' +  PWideChar(  PastaXML_LIDO +  sr.Name ) );

                               //DeleteFile(PastaXML  +  sr.Name);
                               searchResult := FindNext(sr);
                               Continue;
                            end;
                            XMLDoc.Active := True;
                            Try
                               retEvento := XMLDoc.DocumentElement.ChildNodes.FindNode('retEvento');
                               infEvento := retEvento.ChildNodes.FindNode('infEvento');
                            except
                                 DB_Conect.doSaveLogImport(PastaLOG, 'N� Inv�lido ' +  PWideChar(  PastaXML +  sr.Name ));
                                 Writeln( 'N� Invalido: ' +  PWideChar(  PastaXML +  sr.Name ) );
                                 DeleteFile(PastaXML  +  sr.Name);
                                 searchResult := FindNext(sr);
                                 Continue;
                            End;

                            with FD_Consulta_EntregaXML do
                            begin
                              Close;
                              SQL.Clear;
                              SQL.Add(' SELECT cCT FROM XML_IMPORTADA  ');
                              SQL.Add(' WHERE cCT  = :cCT ');
                              SQL.Add(' and nCT = :nCT ');
                              SQL.Add(' and CHCTE = :CHCTE ');
                              SQL.Add(' and TipoXML = :TipoXML ');

                              ParamByName('cCT').asInteger               := StrToInt(infEvento.ChildNodes['tpEvento'].Text);
                              ParamByName('nCT').AsString             := infEvento.ChildNodes['tpEvento'].Text;
                              ParamByName('CHCTE').AsString              := infEvento.ChildNodes['chNFe'].Text;
                              ParamByName('TipoXML').AsString            := 'CCE';
                              Open;
                            end;

                            if not FD_Consulta_EntregaXML.IsEmpty then
                            begin
                                   MoveFile( PWideChar(  PastaXML + sr.Name ) , PWideChar(  PastaXML_LIDO +  sr.Name ) );
                                   Writeln( 'CCE Existente: ' +  PWideChar(  PastaXML_LIDO +  sr.Name ) );
                                   DB_Conect.doSaveLogImport(PastaLOG, 'Existente ' +  PWideChar(  PastaXML_LIDO +  sr.Name ));


                                   Inc(X);


                                   searchResult := FindNext(sr);
                                   Continue;
                            end;


                            varSQL := ' Insert into CTE_OUTRAS (xMotivo, chNFe, tpEvento, xEvento, dhRegEvento, nProt) ';
                            varSQL := varSQL +             ' Values ( :xMotivo, :chNFe, :tpEvento, :xEvento, :dhRegEvento, :nProt) ';

                            FD_Insert_EntregaXML.Close;
                            FD_Insert_EntregaXML.SQL.Clear;
                            FD_Insert_EntregaXML.SQL.Add( varSQL );
                            Try
                                FD_Insert_EntregaXML.ParamByName('xMotivo').asString     := infEvento.ChildNodes['xMotivo'].Text;
                                FD_Insert_EntregaXML.ParamByName('chNFe').asString       := infEvento.ChildNodes['chNFe'].Text;
                                FD_Insert_EntregaXML.ParamByName('tpEvento').asString    := infEvento.ChildNodes['tpEvento'].Text;
                                FD_Insert_EntregaXML.ParamByName('xEvento').asString     := infEvento.ChildNodes['xEvento'].Text;
                                FD_Insert_EntregaXML.ParamByName('dhRegEvento').asString := infEvento.ChildNodes['dhRegEvento'].Text;
                                FD_Insert_EntregaXML.ParamByName('nProt').asString       := infEvento.ChildNodes['nProt'].Text;
                            except
                                  Try
                                      infEvento := retEvento.ChildNodes.FindNode('retEnvEvento');
                                      FD_Insert_EntregaXML.ParamByName('xMotivo').asString     := infEvento.ChildNodes['xMotivo'].Text;
                                      FD_Insert_EntregaXML.ParamByName('chNFe').asString       := infEvento.ChildNodes['chNFe'].Text;
                                      FD_Insert_EntregaXML.ParamByName('tpEvento').asString    := infEvento.ChildNodes['tpEvento'].Text;
                                      FD_Insert_EntregaXML.ParamByName('xEvento').asString     := infEvento.ChildNodes['xEvento'].Text;
                                      FD_Insert_EntregaXML.ParamByName('dhRegEvento').asString := infEvento.ChildNodes['dhRegEvento'].Text;
                                      FD_Insert_EntregaXML.ParamByName('nProt').asString       := infEvento.ChildNodes['nProt'].Text;
                                  except
                                      MoveFile( PWideChar(  PastaXML + sr.Name ) , PWideChar(  PastaXML_LIDO +  sr.Name ) );
                                      Writeln( 'Arquivo Invalido II: ' +  PWideChar(  PastaXML_LIDO +  sr.Name ) );
                                      DB_Conect.doSaveLogImport(PastaLOG, 'Arquivo Inv�lido ' +  PWideChar(  PastaXML_LIDO +  sr.Name ));

                                    //  DeleteFile(PastaXML  +  sr.Name);
                                      searchResult := FindNext(sr);
                                      Continue;
                                  End;
                            End;
                            try
                                   FD_Insert_EntregaXML.ExecSQL;
                                  // MoveFile( PWideChar(   PastaXML  +  sr.Name ) , PWideChar( PastaXML_LIDO +  sr.Name ) );

                                   IDENTITY_ID := 0;
                                   Try

                                     varSQL  := 'SELECT @@IDENTITY as CTE_CAPA_ID ';

                                     FD_Insert_EntregaXML.Close;
                                     FD_Insert_EntregaXML.SQL.Clear;
                                     FD_Insert_EntregaXML.SQL.Add( varSQL );
                                     FD_Insert_EntregaXML.Open;
                                     IDENTITY_ID := FD_Insert_EntregaXML.FieldByName('CTE_CAPA_ID').AsInteger;

                                   except
                                     On E:Exception do
                                       begin
                                     //     DB_Conect.SQLConnection.RollBack;

                                          Writeln( 'Falha ao pegar Chave CTE_CAPA.: ' +  PWideChar(  PastaXML +  sr.Name ) );
                                          DB_Conect.doSaveLogImport(PastaLOG, GetComando(FD_Insert_EntregaXML) + #13#10 + 'Falha ao pegar chave da CTE_OUTRAS.' + E.Message);
                                          Continue;
                                        end;
                                   end;

                                    // Guardar Arquivo XML
                                  try
                                    varSQL := 'Insert into XML_IMPORTADA(cCT, CTE_CAPA_ID, nCT,CHCTE,CodUsuario, TipoXML)';
                                    varSQL := varSQL + ' values( :cCT, :CTE_CAPA_ID, :nCT,:CHCTE,:CodUsuario, :TipoXML)';

                                    FD_Insert_EntregaXML.Close;
                                    FD_Insert_EntregaXML.SQL.Clear;
                                    FD_Insert_EntregaXML.SQL.Add( varSQL );

                                    FD_Insert_EntregaXML.ParamByName('cCT').asInteger               := StrToInt(infEvento.ChildNodes['tpEvento'].Text);
                                    FD_Insert_EntregaXML.ParamByName('CTE_CAPA_ID').AsInteger       := IDENTITY_ID;
                                    FD_Insert_EntregaXML.ParamByName('nCT').AsString                := infEvento.ChildNodes['tpEvento'].Text;
                                    FD_Insert_EntregaXML.ParamByName('CHCTE').AsString              := infEvento.ChildNodes['chNFe'].Text;
                                    FD_Insert_EntregaXML.ParamByName('CodUsuario').AsString         := '2';
                                    FD_Insert_EntregaXML.ParamByName('TipoXML').AsString            := 'CCE';

                                  finally

                                    try
                                      FD_Insert_EntregaXML.ExecSQL;
                                      MoveFile( PWideChar(   PastaXML  +  sr.Name ) , PWideChar( PastaXML_LIDO +  sr.Name ) );
                                    except
                                      On E:Exception do
                                        begin
                                      //    DB_Conect.SQLConnection.RollBack;

                                          Writeln( 'Falha ao Inserir XML_IMPORTADA: ' + E.Message );
                                          DB_Conect.doSaveLogImport(PastaLOG, GetComando(FD_Insert_EntregaXML) + ' ' +  'Falha ao incluir XML.' + E.Message);
                                        end;
                                    end;

                                  end;




                               except
                                 On E:Exception do
                                   begin
                                   // DB_Conect.SQLConnection.RollBack;

                                    DB_Conect.doSaveLogImport(PastaLOG, GetComando(FD_Insert_EntregaXML) + ' ' +  'Falha ao incluir Outro Tipo de Nota.' + E.Message);
                                    Writeln( 'Falha ao incluir Outro Tipo de Nota: ' +  PWideChar(  PastaXML +  sr.Name ) );
                                   end;
                               end;

                           Finally
                              FreeAndNil(XMLDoc);
                           End;

                       //    DB_Conect.doSaveLogImport(PastaLOG, 'Arquivo Inv�lido ' +  PWideChar(  PastaXML_LIDO +  sr.Name ));
                       //    MoveFile( PWideChar(   PastaXML  +  sr.Name ) , PWideChar( PastaXML_LIDO +  sr.Name ) );

                        }
                        end;

                       // Inc(i);

                      end;
                   Finally
                      FreeAndNil(Listtemp3);
                   End;
              end;

//          end;

          finally
           FreeAndNil(DB_Conect);
          end;

     end;

  Finally
     FreeAndNil(varSMTP);
  End;
end;
         {

function WinExecAndWait32(FileName: String; WorkDir: String; Visibility: integer): integer;
var
   zAppName: array[0..512] of char;
   zCurDir: array[0..255] of char;
   StartupInfo: TStartupInfo;
   ProcessInfo: TProcessInformation;
begin
  StrPCopy(zAppName,FileName);
  StrPCopy(zCurDir,WorkDir);
  FillChar(StartupInfo,Sizeof(StartupInfo),#0);
  StartupInfo.cb:=Sizeof(StartupInfo);
  StartupInfo.dwFlags:=STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow:=Visibility;

  if not CreateProcess(nil,zAppName,nil,nil,False,CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS,nil,zCurDir,StartupInfo,ProcessInfo) then
	 Result:=-1
  else
  begin
	 WaitforSingleObject(ProcessInfo.hProcess,INFINITE);
	 GetExitCodeProcess(ProcessInfo.hProcess,DWORD(Result));
  end;

end;


function ExecutaBAT(comando: string; NomeBat: String): boolean;
var
   txt: TextFile;
   dir: string;
   ret: boolean;
begin
  ret:=False;
  try

	 dir:=ExtractFilePath(Application.ExeName);
	 AssignFile(txt, dir  + NomeBat);
	 Rewrite(txt);
   writeln(txt, '@ECHO OFF');
   writeln(txt, ' ECHO *** Inicializando  Data Import. Aguarde... ***');
	 Write(txt,comando);

	 CloseFile(txt);
   //   ShowMessage(dir);
	 if WinExecAndWait32(NomeBat,dir,SW_ShowNormal) = 0 then
		 ret:=True;
	   DeleteFile(dir + NomeBat);
  finally
	  ExecutaBAT := ret;
  end;
end;
     }


{
function ComparaData(DataFiltro, DataEmail : TDateTime) : Boolean;
var
    varDataFiltro, varDataEmail : TDate;
begin
    varDataFiltro := Trunc(DataFiltro);
    varDataEmail := Trunc(DataEmail);

    Result := varDataEmail >= varDataFiltro;

end;
}


{ TTipoRetorno }

procedure TTipoRetorno.Inicializar;
begin
   trCodigo           := '';
   trCodPlanoContatil := '';
   trCodCentroCusto   := '';
   trRegimeICMS       := '';
end;

{ TTipoProduto }

procedure TTipoProduto.Inicializar;
begin
   trCodProdInterno := '';
   trCodGrupo := '';
end;

begin

  FFormatoBR := TFormatSettings.Create;

  FFormatoBR.ThousandSeparator := '.';
  FFormatoBR.DecimalSeparator := ',';
  FFormatoBR.CurrencyDecimals := 2;
  FFormatoBR.DateSeparator := '/';
  FFormatoBR.ShortDateFormat := 'dd/mm/yyyy';
  FFormatoBR.LongDateFormat := 'dd/mm/yyyy';


  if ParamStr(2) <> '' then
  begin

    FFormatoBR.ShortDateFormat := ParamStr(2);
    FFormatoBR.LongDateFormat := ParamStr(2);

  end;

  FFormatoBR.TimeSeparator := ':';
  FFormatoBR.TimeAMString := 'AM';
  FFormatoBR.TimePMString := 'PM';
  FFormatoBR.ShortTimeFormat := 'hh:mm';
  FFormatoBR.LongTimeFormat := 'hh:mm:ss';
  FFormatoBR.CurrencyString := 'R$ ';
  FormatSettings := FFormatoBR;


  if ParamStr(1) = '' then
  begin

    Writeln( 'Informe um parametro.' );
    Sleep(10000);

  end
  else
  if ParamStr(1) =  '-ReceberEmail' then
  begin


    try
       if ConectarNoBanco then
         ReceberEmailNFE;

    except

      on E: Exception do
      begin

        Writeln(E.ClassName, ' : ', E.Message);
        Sleep(60000);

      end;

    end;
  end
  else
  if ParamStr(1) = '-SalvarXMLNFE' then
  begin

    try
      if ConectarNoBanco then
        SalvarXMLNFE_CTE;
    except

      on E: Exception do
      begin

        Writeln(E.ClassName, ' : ', E.Message);
        Sleep(60000);

      end;

    end;

  end;

end.



