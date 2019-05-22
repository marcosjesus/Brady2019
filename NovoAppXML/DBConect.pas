unit DBConect;

interface

uses
  System.SysUtils, System.Classes, Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,System.IOUtils,
  Vcl.Forms;



type
  TCredenciais = record
    Host      : string;
    DataBase  : string;
    UserName  : string;
    Password  : string;
  end;

type
  TDB_Conect = class(TDataModule)
    FDConnection: TFDConnection;
    sqlAuxiliar: TFDQuery;
    sqlAux: TFDQuery;
    sqlAux180: TFDQuery;
    sqlAux180Itens: TFDQuery;
    sql155: TFDQuery;
    sql250: TFDQuery;
    sqlGeral: TFDQuery;
    sqlGeralSPCT_GERAL_ID: TFDAutoIncField;
    sqlGeralLINHA: TStringField;
    sql200: TFDQuery;
    sql155REGISTRO: TStringField;
    sql155CONTA: TStringField;
    sql155CCUSTO: TStringField;
    sql155VALOR1: TStringField;
    sql155TIPO1: TStringField;
    sql155VALOR2: TStringField;
    sql155VALOR3: TStringField;
    sql155VALOR4: TStringField;
    sql155TIPO2: TStringField;
    sql200SPCT_200_ID: TFDAutoIncField;
    sql200REGISTRO: TStringField;
    sql200DATA: TStringField;
    sql200VALOR: TStringField;
    sql200LETRA: TStringField;
    sql250REGISTRO: TStringField;
    sql250CONTA: TStringField;
    sql250CCUSTO: TStringField;
    sql250VALOR1: TStringField;
    sql250TIPO1: TStringField;
    sql250CODIGO: TStringField;
    sql250BRANCO1: TStringField;
    sql250DESCRICAO: TStringField;
    sql250BRANCO2: TStringField;
    sql355: TFDQuery;
    sql355REGISTRO: TStringField;
    sql355CONTA: TStringField;
    sql355CCUSTO: TStringField;
    sql355VALOR: TStringField;
    sql355TIPO: TStringField;
    FDQuery_Insert_F01: TFDQuery;
    FDQuery_Insert_F01ECF_MOV_F01_ID: TFDAutoIncField;
    FDQuery_Insert_F01NUMERO_CONTA: TStringField;
    FDQuery_Insert_F01TIPO: TStringField;
    FDQuery_Insert_F01VALOR_FIS_01: TBCDField;
    FDQuery_Insert_F01VALOR_FIS_02: TBCDField;
    FDQuery_Insert_F01VALOR_FIS_03: TBCDField;
    FDQuery_Insert_F01VALOR_FIS_04: TBCDField;
    FDQuery_Insert_F01VALOR_FIS_05: TBCDField;
    FDQuery_Insert_F01VALOR_FIS_06: TBCDField;
    FDQuery_Insert_F01VALOR_FIS_07: TBCDField;
    FDQuery_Insert_F01VALOR_FIS_08: TBCDField;
    FDQuery_Insert_F01VALOR_FIS_09: TBCDField;
    FDQuery_Insert_F01VALOR_FIS_10: TBCDField;
    FDQuery_Insert_F01VALOR_FIS_11: TBCDField;
    FDQuery_Insert_F01VALOR_FIS_12: TBCDField;
    FDQuery_Insert_F01DATA_IMPORT: TSQLTimeStampField;
    FDQuery_Insert_F01VALOR_FIS_13: TBCDField;
    FDQuery_Insert_KE5Z: TFDQuery;
    FDQuery_Insert_KE5ZECF_MOV_KE5Z_ID: TFDAutoIncField;
    FDQuery_Insert_KE5ZPlant: TStringField;
    FDQuery_Insert_KE5ZDC: TStringField;
    FDQuery_Insert_KE5ZACC_NUMBER: TStringField;
    FDQuery_Insert_KE5ZPURCHASING_DOC: TStringField;
    FDQuery_Insert_KE5ZACC_NUMBER_VEN_CRE: TStringField;
    FDQuery_Insert_KE5ZNAME: TStringField;
    FDQuery_Insert_KE5ZPOSITION_PERIODO: TStringField;
    FDQuery_Insert_KE5ZFISCAL_YEAR: TStringField;
    FDQuery_Insert_KE5ZAMOUNT: TBCDField;
    FDQuery_Insert_KE5ZMOEDA: TStringField;
    FDQuery_Insert_KE5ZPAIS: TStringField;
    FDQuery_Insert_KE5ZDATA_IMPORT: TSQLTimeStampField;
    FDQuery_FBL3N: TFDQuery;
    FDQuery_FBL3NFBL3N_ID: TFDAutoIncField;
    FDQuery_FBL3NCD: TStringField;
    FDQuery_FBL3NNUMERO_CONTA: TStringField;
    FDQuery_FBL3NCENTRO_CUSTO: TStringField;
    FDQuery_FBL3NDATA: TDateField;
    FDQuery_FBL3NVALOR: TBCDField;
    FDQuery_FBL3NMOEDA: TStringField;
    FDQuery_FBL3NDC: TStringField;
    FDQuery_FBL3NDATA_IMPORT: TSQLTimeStampField;
    FDQuery_FBL3NANO_FISCAL: TStringField;
    FDQuery_FBL3NMES_FISCAL: TStringField;
    FDQuery_Insert_F01ANO: TIntegerField;
    FDQuery_Insert_F01EMPRESA: TStringField;
    FDQuery_Insert_F01ECF_CONTROLE_ID: TIntegerField;
    FDQuery_Insert_KE5ZECF_CONTROLE_ID: TIntegerField;
    FDQuery_FBL3NECF_CONTROLE_ID: TIntegerField;
    FDQuery_Controle: TFDQuery;
    FDQuery_ControleECF_CONTROLE_ID: TFDAutoIncField;
    FDQuery_ControleANO: TStringField;
    FDQuery_ControleANO_ANTERIOR: TStringField;
    FDQuery_ControleDATA_IMPORT: TSQLTimeStampField;
    FDQuery_Insert_KE5ZANO_BASE: TStringField;
    FDQuery_FBL3NANO_BASE: TStringField;
    sql200NUMERO: TStringField;
    FDQuery_Insert_KE5ZCENTRO_CUSTO: TStringField;
  private

    { Private declarations }
  public
    { Public declarations }
    GUsuario : String;
    procedure LerCredenciais;

    function GetComando(ObjetoQuery: TFDQuery; bMostra: Boolean = false): String;
  end;

var
  DB_Conect: TDB_Conect;
  Credencias               : TCredenciais;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


function StrTran(sOrigem: string; sLoc: string; sSub: string): string;
var
  Aux: string;
  Calc: integer;
  Posicao: integer;
begin
//Localiza um conjunto de strings e subtitui por outro
  Aux := sOrigem;
  Calc := 0;
  Posicao := Pos(sLoc, Aux);
  while Posicao > 0 do
  begin

    Delete(Aux, Posicao, Length(sLoc));
    Posicao := Posicao + Calc;
    sOrigem := Copy(sOrigem, 1, Posicao - 1) + sSub +
      Copy(sOrigem, Posicao + Length(sLoc), Length(sOrigem));
    Calc := Calc + Length(sSub);
    Posicao := Pos(sLoc, Aux);
  end;
  Result := sOrigem;
end;

Function TDB_Conect.GetComando(ObjetoQuery: TFDQuery; bMostra : Boolean = false) : String;
var
 i        : Integer;
 strQuery : String;
 sGetComando : String;
begin

  strQuery := UpperCase(ObjetoQuery.SQL.Text);

  For  i := 0 to ObjetoQuery.Params.Count - 1 do
    strQuery := StrTran(strQuery,':' + UpperCase(ObjetoQuery.Params[i].Name), QuotedStr(ObjetoQuery.Params[i].Value) );

   strQuery :=  StrTran(StrTran(strQuery, ''#$D#$A'', ' '), ''#$D#$A'', '');

  {
  sGetComando := ExisteRegistroComValor('PARAMETROS', 'VL_PARAM', 'NM_PARAM = ''GETCOMANDONATELA'' ');

  if (sGetComando = 'S') or (sGetComando = '') Then
     MostrarScriptnaTela := True;

  if not MostrarScriptnaTela Then
     LogWriter(GUsuario, strQuery, Tela)
  else
  }
  if bMostra  then
     ShowMessage(strQuery);

  result := strQuery;

end;

procedure TDB_Conect.LerCredenciais;
var
   varParam : TStringList;
begin
  if TFile.Exists( ExtractFilePath(Application.ExeName) + 'DB-CECS2002.ini' ) then
  begin
     varParam := TStringList.Create;
     Try
       varParam.LoadFromFile(ExtractFilePath(Application.ExeName)  + 'DB-CECS2002.ini');
       Credencias.Host         := varParam.Values['SERVER'];
       Credencias.Username     := varParam.Values['User_Name'];
       Credencias.Password     := varParam.Values['Password'];
       Credencias.DataBase     := varParam.Values['DATABASE'];


     Finally
       FreeAndNil(varParam);
     End;
  end;
end;

end.
