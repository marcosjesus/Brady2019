unit uPainelOperador;

interface

uses
  System.IniFiles,
  System.IOUtils,
  uPainelOperador4x1,
  System.DateUtils,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, System.Actions, Vcl.ActnList, Vcl.Touch.GestureMgr, Vcl.Grids, Vcl.ComCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL;

type
  TipoOperacao = ( tpoSemTurno, tpoProdutiva, tpoSetup, tpoNaoProdutiva );

  rPosicaoOperacao = record
    Left: Integer;
    Top: Integer;
  end;

  ROperacao = record
    Nome: string;
    Atividade: string;
    Tipo: TipoOperacao;
    Observaocao: string;
    Tempo: Integer;
    OP: string;
    YNumber: string;
    Quantidade: Extended;
    MetrosFolhasPD7: Extended;
    EncerrarOS: string;
    Observacao: string;
  end;

  TOperacoes = array of ROperacao;

  RHoraHora = record
    Texto: string;
    Inicial: TDateTime;
    Final: TDateTime;
    Operacoes: TOperacoes;
  end;

  THoraHora = array[1..9] of RHoraHora;
  THoraHoraShape = array[1..9] of TShape;

  TFr_PainelOperador = class(TForm)
    ShapeHeader: TShape;
    ShapeHora: TShape;
    ShapeTurno1: TShape;
    ShapeTurno2: TShape;
    ShapeHora01: TShape;
    ShapeHora02: TShape;
    ShapeHora03: TShape;
    ShapeHora04: TShape;
    ShapeHora05: TShape;
    ShapeHora06: TShape;
    ShapeHora07: TShape;
    ShapeHora08: TShape;
    ShapeHora09: TShape;
    ShapeHora1: TShape;
    ShapeHora2: TShape;
    ShapeHora3: TShape;
    ShapeHora4: TShape;
    ShapeHora5: TShape;
    ShapeHora6: TShape;
    ShapeHora7: TShape;
    ShapeHora8: TShape;
    ShapeHora9: TShape;
    LabelHora1: TLabel;
    LabelHora2: TLabel;
    LabelHora3: TLabel;
    LabelHora4: TLabel;
    LabelHora5: TLabel;
    LabelHora6: TLabel;
    LabelHora7: TLabel;
    LabelHora8: TLabel;
    LabelHora9: TLabel;
    LabeledEditCelula: TLabeledEdit;
    LabeledEditMaquina: TLabeledEdit;
    LabeledEditOperador: TLabeledEdit;
    LabeledEditData: TLabeledEdit;
    Timer: TTimer;
    PanelMensagemErro: TPanel;
    LabelMensagemErro: TLabel;
    TimerMensagem: TTimer;
    LabelMensagemErroTime: TLabel;
    PanelOperacao: TPanel;
    LabelHoraHoraOperacao: TLabel;
    TrackBarHour: TTrackBar;
    LabelOperacao6: TLabel;
    LabelOperacao5: TLabel;
    LabelOperacao4: TLabel;
    LabelOperacao3: TLabel;
    LabelOperacao2: TLabel;
    LabelOperacao1: TLabel;
    PanelMensagem: TPanel;
    LabelMensagem: TLabel;
    LabelRemaingMinutes: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    TimerAlarme: TTimer;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape1: TShape;
    Shape2: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Shape20: TShape;
    Shape21: TShape;
    Shape22: TShape;
    Shape23: TShape;
    Shape24: TShape;
    Shape25: TShape;
    Shape26: TShape;
    Shape27: TShape;
    Shape28: TShape;
    Shape29: TShape;
    Shape30: TShape;
    LabelVersion: TLabel;
    FDConnection: TFDConnection;
    FDQueryTSOP_Apontamento: TFDQuery;
    FDQueryTSOP_Maquina: TFDQuery;
    FDQueryTSOP_Operador: TFDQuery;
    FDQueryTSOP_MaquinaTMAQ_MAQCOD: TFDAutoIncField;
    FDQueryTSOP_MaquinaTMAQ_SITCOD: TIntegerField;
    FDQueryTSOP_MaquinaTMAQ_CELCOD: TIntegerField;
    FDQueryTSOP_MaquinaTMAQ_MAQBAR: TStringField;
    FDQueryTSOP_MaquinaTMAQ_MAQNOM: TStringField;
    FDQueryTSOP_Atividade: TFDQuery;
    FDQueryTSOP_Celula: TFDQuery;
    FDQueryTSOP_CelulaTMAQ_CELCOD: TFDAutoIncField;
    FDQueryTSOP_CelulaTMAQ_CELCODPAI: TIntegerField;
    FDQueryTSOP_CelulaTMAQ_CELNOM: TStringField;
    FDQueryTSOP_AtividadeTMAQ_ATICOD: TFDAutoIncField;
    FDQueryTSOP_AtividadeTMAQ_ATIBAR: TStringField;
    FDQueryTSOP_AtividadeTMAQ_ATINOM: TStringField;
    FDQueryTSOP_AtividadeTMAQ_ATITIP: TIntegerField;
    FDQueryTSOP_AtividadeTMAQ_ATIOSEYNU: TStringField;
    FDQueryTSOP_AtividadeTMAQ_ATIQTD: TStringField;
    FDQueryTSOP_AtividadeTMAQ_ATIFINOSE: TStringField;
    FDQueryTSOP_OperadorTMAQ_OPECOD: TFDAutoIncField;
    FDQueryTSOP_OperadorTMAQ_SITCOD: TIntegerField;
    FDQueryTSOP_OperadorTMAQ_OPEBAR: TStringField;
    FDQueryTSOP_OperadorTMAQ_OPENOM: TStringField;
    FDQueryTSOP_MaquinaTMAQ_CELNOM: TStringField;
    FDQueryTSOP_ApontamentoTMAQ_APOCOD: TFDAutoIncField;
    FDQueryTSOP_ApontamentoTMAQ_APOKEY: TStringField;
    FDQueryTSOP_ApontamentoTMAQ_MAQCOD: TIntegerField;
    FDQueryTSOP_ApontamentoTMAQ_ATICOD: TIntegerField;
    FDQueryTSOP_ApontamentoTMAQ_APOOPE: TStringField;
    FDQueryTSOP_ApontamentoTMAQ_APODATINI: TSQLTimeStampField;
    FDQueryTSOP_ApontamentoTMAQ_APOMIN: TIntegerField;
    FDQueryTSOP_ApontamentoTMAQ_APOOSE: TStringField;
    FDQueryTSOP_ApontamentoTMAQ_APOITE: TStringField;
    FDQueryTSOP_ApontamentoTMAQ_APOQTD: TIntegerField;
    FDQueryTSOP_ApontamentoTMAQ_APOMET: TBCDField;
    FDQueryTSOP_ApontamentoTMAQ_APOENCOSE: TStringField;
    FDQueryTSOP_ApontamentoTMAQ_APOOBS: TStringField;
    TimerShowChild: TTimer;
    TimerSyncSQL: TTimer;
    TimerChildAlarme: TTimer;
    FDQueryTSIS_UsuarioMaquina: TFDQuery;
    FDQueryTSIS_UsuarioMaquinaTMAQ_MAQBAR: TStringField;
    FDQueryTSOP_MaquinaTMAQ_MAQPERMAXPAR: TIntegerField;
    FDQueryTSOP_MaquinaTMAQ_MAQPERMAXSET: TIntegerField;
    FDQueryTSOP_MaquinaTMAQ_MAQPERMINPRO: TIntegerField;
    FDQueryTSOP_MaquinaTMAQ_MAQNOMRED: TStringField;
    FDQueryTSOP_MaquinaTMAQ_MAQATI: TStringField;
    FDQueryTSOP_MaquinaTMAQ_MAQWRKCEN: TStringField;
    FDQueryTSOP_MaquinaTMAQ_MAQCOSCEN: TStringField;
    FDQueryTSOP_MaquinaTMAQ_MAQHORINI: TIntegerField;
    FDQueryTSOP_MaquinaTMAQ_MAQHORFIM: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerTimer(Sender: TObject);
    procedure TimerMensagemTimer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LabeledEditEnter(Sender: TObject);
    procedure TimerAlarmeTimer(Sender: TObject);
    procedure TimerShowChildTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure TimerSyncSQLTimer(Sender: TObject);
    procedure TimerChildAlarmeTimer(Sender: TObject);

  private

    FDadosConf: TIniFile;

    FCelula: String;
    FMaquina: String;
    FOperador: String;
    FHoraHora: THoraHora;
    FLastHoraHora: THoraHora;
    FDataBase: TDateTime;
    FTempo: Integer;
    FAtividade: String;
    FOS: string;
    FYNumber: string;
    FQuantidade: Extended;
    FMetrosFolhasPD7: Extended;
    FEncerrarOS: Integer;
    FDuplicar: Integer;
    FObservacao: String;

    FCharRead: string;
    FDBAtividades: TStringList;
    FDBOperador: TStringList;
    FDBMaquina: TStringList;
    FDBOperacao: TStringList;

    procedure DoCreateMyDocumentsPath;

    function cfg_getHoraHora: THoraHora;
    function cfg_getLastHoraHora: THoraHora;

    function db_getOperacoes( pDataHora: TDateTime ): TOperacoes;

    function db_getAtividadeSemTurno( pAtividade: string ): Boolean;
    function db_getAtividadeProdutiva( pAtividade: string ): Boolean;
    function db_getAtividadeNaoProdutiva( pAtividade: string ): Boolean;
    function db_getAtividadeSetup( pAtividade: string ): Boolean;
    function db_getAtividadeOSYNumber( pAtividade: string ): Boolean;
    function db_getAtividadeQuantidade( pAtividade: string ): Boolean;
    function db_getAtividadeMetrosFolhasPD7( pAtividade: string ): Boolean;
    function db_getAtividadeEncerraOS( pAtividade: string ): Boolean;

    procedure db_setAtividade( pMaquina: string; pOperador: string; pHoraIni: TDateTime; pAtividade: string; pTempo: Integer; pOS: string; pYNumber: string; pQuantidade: Extended; pMetrosFolhasPD7: Extended; pEncerraOS: Integer; pObservacao: String );
    procedure db_deleteLastAtividade;
    procedure db_saveAtividades;
    procedure db_SyncSQLDatabase;

    function db_getAtividadeNome( pAtividade: string ): string;
    function db_getMaquinaNome( pMaquina: string ): string;
    function db_getMaquinaHoraFinal(pMaquina: string): TDateTime;
    function db_getMaquinaHoraInicial(pMaquina: string): TDateTime;
    function db_getCelulaNome( pMaquina: string ): string;
    function db_getOperadorNome( pOperador: string ): string;

    procedure db_loadMaquinas;
    procedure db_loadOperadores;
    procedure db_loadOperacoes;

    function getTempoOperacoes( pOperacoes: TOperacoes ): Integer;

    procedure screen_deleteOperacoes;
    procedure screen_deleteOperacoesChild;
    procedure screen_updateOperacoes;
    procedure screen_updateOperacoesChild;
    procedure screen_updateAlarme;
    procedure screen_updateAlarmeChild;

    procedure setScreen_Resolution;

    procedure createChildForms;
    procedure ShowChildForms;
    procedure RefreshShowChildForms;

    function WaitingDuplicar: Boolean;
    function WaitingQuantidade: Boolean;
    function WaitingMetrosFolhasPD7: Boolean;
    function WaitingYNumber: Boolean;
    function WaitingOS: Boolean;
    function WaitingAtividade: Boolean;
    function WaitingTempo: Boolean;
    function WaitingEncerrarOS: Boolean;

    function AddObservacao: String;

    function getCelula: String;
    procedure setCelula(const Value: String);
    function getMaquina: String;
    procedure setMaquina(const Value: String);
    function getOperador: String;
    procedure setOperador(const Value: String);
    function getHoraHora: THoraHora;
    procedure setHoraHora(const Value: THoraHora);
    function getDataBase: TDateTime;
    procedure setDataBase(const Value: TDateTime);
    function getHoraAtual: Integer;
    function getShapeHoraHora: THoraHoraShape;
    function getRGB_BrushProdutivo: TColor;
    function getRGB_BrushSetup: TColor;
    function getRGB_BrushNaoProdutivo: TColor;
    function getRGB_PenSetup: TColor;
    function getRGB_PenNaoProdutivo: TColor;
    function getRGB_PenProdutivo: TColor;
    function getRGB_AlarmeRed: TColor;
    function getRGB_AlarmeWhite: TColor;
    function getOnMensagemErro: Boolean;
    function getRGB_MensagemErro: TColor;
    function getOnOperacao: Boolean;
    function getAtividade: string;
    function getTempo: Integer;
    procedure setAtividade(const Value: string);
    procedure setTempo(const Value: Integer);
    function getRGB_Mensagem: TColor;
    function getOS: string;
    procedure setOS(const Value: string);
    function getYNumber: string;
    procedure setYNumber(const Value: string);
    function getAtividadeSemTurno: Boolean;
    function getAtividadeProdutiva: Boolean;
    function getOnMensagem: Boolean;
    function getAtividadeNaoProdutiva: Boolean;
    function getAtividadeOSYNumber: Boolean;
    function getAtividadeSetup: Boolean;
    function getQuantidade: Extended;
    function getMetrosFolhasPD7: Extended;
    procedure setQuantidade(const Value: Extended);
    procedure setMetrosFolhasPD7(const Value: Extended);
    function getAtividadeQuantidade: Boolean;
    function getAtividadeMetrosFolhasPD7: Boolean;
    function getEncerrarOS: Integer;
    procedure setEncerrarOS(const Value: Integer);
    function getAtividadeEncerraOS: Boolean;
    function getObservacao: String;
    procedure setObservacao(const Value: String);
    function getRGB_BrushSemTurno: TColor;
    function getRGB_PenSemTurno: TColor;
    function getLastHoraHora: THoraHora;
    procedure setLastHoraHora(const Value: THoraHora);
    function getOnSyncSQL: Boolean;
    function getDuplicar: Integer;
    procedure setDuplicar(const Value: Integer);
  protected

    { Protected declarations }
  public

    procedure Inicializar;
    procedure InicializarChild;

    procedure CriarAtividadeSemTurnoAuto;

    procedure OnReadChar;
    procedure OnReadDuplicar;
    procedure OnReadQuantidade;
    procedure OnReadMetrosFolhasPD7;
    procedure OnReadYNumber;
    procedure OnReadOrdemServico;
    procedure OnReadMaquina;
    procedure OnReadOperador;
    procedure OnReadOperacao;
    procedure OnReadAtividade;
    procedure OnReadTempo;
    procedure CriarAtividade;
    procedure GravaLog(pMensagem: String);
    procedure ExibirMensagemErro( pMensagem: string );
    procedure ExibirMensagem( pMensagem: string; pColor: TColor );
    procedure EncerrarMensagem;
    property Celula: String read getCelula write setCelula;
    property Maquina: String read getMaquina write setMaquina;
    property Operador: String read getOperador write setOperador;
    property HoraHora: THoraHora read getHoraHora write setHoraHora;
    property LastHoraHora: THoraHora read getLastHoraHora write setLastHoraHora;
    property DataBase: TDateTime read getDataBase write setDataBase;
    property HoraAtual: Integer read getHoraAtual;
    property ShapeHoraHora: THoraHoraShape read getShapeHoraHora;
    property RGB_BrushSemTurno: TColor read getRGB_BrushSemTurno;
    property RGB_BrushProdutivo: TColor read getRGB_BrushProdutivo;
    property RGB_BrushNaoProdutivo: TColor read getRGB_BrushNaoProdutivo;
    property RGB_BrushSetup: TColor read getRGB_BrushSetup;
    property RGB_PenSemTurno: TColor read getRGB_PenSemTurno;
    property RGB_PenProdutivo: TColor read getRGB_PenProdutivo;
    property RGB_PenNaoProdutivo: TColor read getRGB_PenNaoProdutivo;
    property RGB_PenSetup: TColor read getRGB_PenSetup;
    property RGB_AlarmeRed: TColor read getRGB_AlarmeRed;
    property RGB_AlarmeWhite: TColor read getRGB_AlarmeWhite;
    property RGB_MensagemErro: TColor read getRGB_MensagemErro;
    property RGB_Mensagem: TColor read getRGB_Mensagem;
    property CharRead: string read FCharRead write FCharRead;
    property OnMensagemErro: Boolean read getOnMensagemErro;
    property OnMensagem: Boolean read getOnMensagem;
    property OnOperacao: Boolean read getOnOperacao;
    property OnSyncSQL: Boolean read getOnSyncSQL;
    property Tempo: Integer read getTempo write setTempo;
    property Atividade: string read getAtividade write setAtividade;
    property OS: string read getOS write setOS;
    property YNumber: string read getYNumber write setYNumber;
    property Quantidade: Extended read getQuantidade write setQuantidade;
    property MetrosFolhasPD7: Extended read getMetrosFolhasPD7 write setMetrosFolhasPD7;
    property EncerrarOS: Integer read getEncerrarOS write setEncerrarOS;
    property Duplicar: Integer read getDuplicar write setDuplicar;
    property Observacao: String read getObservacao write setObservacao;
    property AtividadeSemTurno: Boolean read getAtividadeSemTurno;
    property AtividadeProdutiva: Boolean read getAtividadeProdutiva;
    property AtividadeSetup: Boolean read getAtividadeSetup;
    property AtividadeNaoProdutiva: Boolean read getAtividadeNaoProdutiva;
    property AtividadeOSYNumber: Boolean read getAtividadeOSYNumber;
    property AtividadeEncerraOS: Boolean read getAtividadeEncerraOS;
    property AtividadeQuantidade: Boolean read getAtividadeQuantidade;
    property AtividadeMetrosFolhasPD7: Boolean read getAtividadeMetrosFolhasPD7;
    property DBAtividades: TStringList read FDBAtividades;
    property DBMaquina: TStringList read FDBMaquina;
    property DBOperador: TStringList read FDBOperador;
    property DBOperacao: TStringList read FDBOperacao;
    { Public declarations }
  end;

var
  Fr_PainelOperador: array[1..4] of TFr_PainelOperador;

implementation

{$R *.dfm}

uses uAddObservacao, uUtils;

function GetAppVersionStr: string;
var
  Exe: string;
  Size, Handle: DWORD;
  Buffer: TBytes;
  FixedPtr: PVSFixedFileInfo;

begin

  Exe := ParamStr(0);
  Size := GetFileVersionInfoSize(PChar(Exe), Handle);
  if Size = 0 then
    RaiseLastOSError;

  SetLength(Buffer, Size);
  if not GetFileVersionInfo(PChar(Exe), Handle, Size, Buffer) then
    RaiseLastOSError;

  if not VerQueryValue(Buffer, '\', Pointer(FixedPtr), Size) then
    RaiseLastOSError;

  Result := Format('%d.%d.%d.%d',
    [LongRec(FixedPtr.dwFileVersionMS).Hi,  //major
     LongRec(FixedPtr.dwFileVersionMS).Lo,  //minor
     LongRec(FixedPtr.dwFileVersionLS).Hi,  //release
     LongRec(FixedPtr.dwFileVersionLS).Lo]) //build

end;

{ TFr_PainelOperador }

function TFr_PainelOperador.AddObservacao: String;
begin

  Fr_AddObservacao := TFr_AddObservacao.Create(Self);
  try

    Fr_AddObservacao.ShowModal;
    Result := Fr_AddObservacao.MemoObservacao.Text;

  finally

    FreeAndNil(Fr_AddObservacao);

  end;

end;

function TFr_PainelOperador.cfg_getHoraHora: THoraHora;
const
  cHour: array[-8..23] of integer = (16,17,18,19,20,21,22,23,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23);
  cDate: array[-8..23] of integer = (-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);

var
  varHour, varMin, varSec, varMSec: Word;

begin

  DecodeTime( Now, varHour, varMin, varSec, varMSec );

  Result[1].Texto := FormatDateTime( 'hh:00', Now - ((1/HoursPerDay)*8) ) + ' - ' + FormatDateTime( 'hh:00', Now - ((1/HoursPerDay)*7) );
  Result[2].Texto := FormatDateTime( 'hh:00', Now - ((1/HoursPerDay)*7) ) + ' - ' + FormatDateTime( 'hh:00', Now - ((1/HoursPerDay)*6) );
  Result[3].Texto := FormatDateTime( 'hh:00', Now - ((1/HoursPerDay)*6) ) + ' - ' + FormatDateTime( 'hh:00', Now - ((1/HoursPerDay)*5) );
  Result[4].Texto := FormatDateTime( 'hh:00', Now - ((1/HoursPerDay)*5) ) + ' - ' + FormatDateTime( 'hh:00', Now - ((1/HoursPerDay)*4) );
  Result[5].Texto := FormatDateTime( 'hh:00', Now - ((1/HoursPerDay)*4) ) + ' - ' + FormatDateTime( 'hh:00', Now - ((1/HoursPerDay)*3) );
  Result[6].Texto := FormatDateTime( 'hh:00', Now - ((1/HoursPerDay)*3) ) + ' - ' + FormatDateTime( 'hh:00', Now - ((1/HoursPerDay)*2) );
  Result[7].Texto := FormatDateTime( 'hh:00', Now - ((1/HoursPerDay)*2) ) + ' - ' + FormatDateTime( 'hh:00', Now - ((1/HoursPerDay)*1) );
  Result[8].Texto := FormatDateTime( 'hh:00', Now - ((1/HoursPerDay)*1) ) + ' - ' + FormatDateTime( 'hh:00', Now                       );
  Result[9].Texto := FormatDateTime( 'hh:00', Now                       ) + ' - ' + FormatDateTime( 'hh:00', Now + ((1/HoursPerDay)*1) );

  Result[1].Inicial := Trunc(Now) + EncodeTime(cHour[varHour-8],0,0,0) + cDate[varHour-8];
  Result[2].Inicial := Trunc(Now) + EncodeTime(cHour[varHour-7],0,0,0) + cDate[varHour-7];
  Result[3].Inicial := Trunc(Now) + EncodeTime(cHour[varHour-6],0,0,0) + cDate[varHour-6];
  Result[4].Inicial := Trunc(Now) + EncodeTime(cHour[varHour-5],0,0,0) + cDate[varHour-5];
  Result[5].Inicial := Trunc(Now) + EncodeTime(cHour[varHour-4],0,0,0) + cDate[varHour-4];
  Result[6].Inicial := Trunc(Now) + EncodeTime(cHour[varHour-3],0,0,0) + cDate[varHour-3];
  Result[7].Inicial := Trunc(Now) + EncodeTime(cHour[varHour-2],0,0,0) + cDate[varHour-2];
  Result[8].Inicial := Trunc(Now) + EncodeTime(cHour[varHour-1],0,0,0) + cDate[varHour-1];
  Result[9].Inicial := Trunc(Now) + EncodeTime(cHour[varHour  ],0,0,0) + cDate[varHour  ];

  Result[1].Final := Trunc(Now) + EncodeTime(cHour[varHour-8],59,59,999) + cDate[varHour-8];
  Result[2].Final := Trunc(Now) + EncodeTime(cHour[varHour-7],59,59,999) + cDate[varHour-7];
  Result[3].Final := Trunc(Now) + EncodeTime(cHour[varHour-6],59,59,999) + cDate[varHour-6];
  Result[4].Final := Trunc(Now) + EncodeTime(cHour[varHour-5],59,59,999) + cDate[varHour-5];
  Result[5].Final := Trunc(Now) + EncodeTime(cHour[varHour-4],59,59,999) + cDate[varHour-4];
  Result[6].Final := Trunc(Now) + EncodeTime(cHour[varHour-3],59,59,999) + cDate[varHour-3];
  Result[7].Final := Trunc(Now) + EncodeTime(cHour[varHour-2],59,59,999) + cDate[varHour-2];
  Result[8].Final := Trunc(Now) + EncodeTime(cHour[varHour-1],59,59,999) + cDate[varHour-1];
  Result[9].Final := Trunc(Now) + EncodeTime(cHour[varHour  ],59,59,999) + cDate[varHour  ];

  Result[1].Operacoes := db_getOperacoes(Result[1].Inicial);
  Result[2].Operacoes := db_getOperacoes(Result[2].Inicial);
  Result[3].Operacoes := db_getOperacoes(Result[3].Inicial);
  Result[4].Operacoes := db_getOperacoes(Result[4].Inicial);
  Result[5].Operacoes := db_getOperacoes(Result[5].Inicial);
  Result[6].Operacoes := db_getOperacoes(Result[6].Inicial);
  Result[7].Operacoes := db_getOperacoes(Result[7].Inicial);
  Result[8].Operacoes := db_getOperacoes(Result[8].Inicial);
  Result[9].Operacoes := db_getOperacoes(Result[9].Inicial);

end;

function TFr_PainelOperador.cfg_getLastHoraHora: THoraHora;
const
  cHour: array[-8..23] of integer = (16,17,18,19,20,21,22,23,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23);
  cDate: array[-8..23] of integer = (-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);

var
  varHour, varMin, varSec, varMSec: Word;

  I, X: Integer;
  varMinutos: Integer;

begin

  DecodeTime( Now, varHour, varMin, varSec, varMSec );

  Result[1].Inicial := Trunc(Now) + EncodeTime(cHour[varHour-8-9],0,0,0) + cDate[varHour-8-9];
  Result[2].Inicial := Trunc(Now) + EncodeTime(cHour[varHour-7-9],0,0,0) + cDate[varHour-7-9];
  Result[3].Inicial := Trunc(Now) + EncodeTime(cHour[varHour-6-9],0,0,0) + cDate[varHour-6-9];
  Result[4].Inicial := Trunc(Now) + EncodeTime(cHour[varHour-5-9],0,0,0) + cDate[varHour-5-9];
  Result[5].Inicial := Trunc(Now) + EncodeTime(cHour[varHour-4-9],0,0,0) + cDate[varHour-4-9];
  Result[6].Inicial := Trunc(Now) + EncodeTime(cHour[varHour-3-9],0,0,0) + cDate[varHour-3-9];
  Result[7].Inicial := Trunc(Now) + EncodeTime(cHour[varHour-2-9],0,0,0) + cDate[varHour-2-9];
  Result[8].Inicial := Trunc(Now) + EncodeTime(cHour[varHour-1-9],0,0,0) + cDate[varHour-1-9];
  Result[9].Inicial := Trunc(Now) + EncodeTime(cHour[varHour  -9],0,0,0) + cDate[varHour  -9];

  Result[1].Final := Trunc(Now) + EncodeTime(cHour[varHour-8-9],59,59,999) + cDate[varHour-8-9];
  Result[2].Final := Trunc(Now) + EncodeTime(cHour[varHour-7-9],59,59,999) + cDate[varHour-7-9];
  Result[3].Final := Trunc(Now) + EncodeTime(cHour[varHour-6-9],59,59,999) + cDate[varHour-6-9];
  Result[4].Final := Trunc(Now) + EncodeTime(cHour[varHour-5-9],59,59,999) + cDate[varHour-5-9];
  Result[5].Final := Trunc(Now) + EncodeTime(cHour[varHour-4-9],59,59,999) + cDate[varHour-4-9];
  Result[6].Final := Trunc(Now) + EncodeTime(cHour[varHour-3-9],59,59,999) + cDate[varHour-3-9];
  Result[7].Final := Trunc(Now) + EncodeTime(cHour[varHour-2-9],59,59,999) + cDate[varHour-2-9];
  Result[8].Final := Trunc(Now) + EncodeTime(cHour[varHour-1-9],59,59,999) + cDate[varHour-1-9];
  Result[9].Final := Trunc(Now) + EncodeTime(cHour[varHour  -9],59,59,999) + cDate[varHour  -9];

  Result[1].Operacoes := db_getOperacoes(Result[1].Inicial);
  Result[2].Operacoes := db_getOperacoes(Result[2].Inicial);
  Result[3].Operacoes := db_getOperacoes(Result[3].Inicial);
  Result[4].Operacoes := db_getOperacoes(Result[4].Inicial);
  Result[5].Operacoes := db_getOperacoes(Result[5].Inicial);
  Result[6].Operacoes := db_getOperacoes(Result[6].Inicial);
  Result[7].Operacoes := db_getOperacoes(Result[7].Inicial);
  Result[8].Operacoes := db_getOperacoes(Result[8].Inicial);
  Result[9].Operacoes := db_getOperacoes(Result[9].Inicial);

  for I := 1 to 9 do
  begin

    varMinutos := 0;
    for X := Low(Result[I].Operacoes) to High(Result[I].Operacoes) do
      varMinutos := varMinutos + Result[I].Operacoes[X].Tempo;

    if varMinutos < 60 then
    begin

      SetLength( Result[I].Operacoes, Length(Result[I].Operacoes) + 1 );

      Result[I].Operacoes[Length(Result[I].Operacoes) - 1].Tipo := tpoSemTurno;
      Result[I].Operacoes[Length(Result[I].Operacoes) - 1].Tempo := 60 - varMinutos;

    end;

  end;

end;

procedure TFr_PainelOperador.createChildForms;
begin

  if not Assigned(Fr_PainelOperador4x1[Tag]) then
    Fr_PainelOperador4x1[Tag] := TFr_PainelOperador4x1.Create(Self);

  Fr_PainelOperador4x1[Tag].Tag := Tag;

  case Tag of

    1:
    begin
      Fr_PainelOperador4x1[Tag].Top := 0;
      Fr_PainelOperador4x1[Tag].Left := 0;
    end;

    2:
    begin
      Fr_PainelOperador4x1[Tag].Top := 0;
      Fr_PainelOperador4x1[Tag].Left := 510;
    end;

    3:
    begin
      Fr_PainelOperador4x1[Tag].Top := 380;
      Fr_PainelOperador4x1[Tag].Left := 0;
    end;

    4:
    begin
      Fr_PainelOperador4x1[Tag].Top := 380;
      Fr_PainelOperador4x1[Tag].Left := 510;
    end;

  end;

end;

procedure TFr_PainelOperador.CriarAtividade;
var
  varIndex: Integer;
  varOSYNumber: string;
  varMsg: string;

begin

  if TrackBarHour.Position + Tempo > 60 then
  begin

    ExibirMensagemErro( 'Tempo total maior que 60 minutos, informe a ultima opera��o novamente.' );

    FTempo := 0;
    FAtividade := EmptyStr;
    FOS := EmptyStr;
    FYNumber := EmptyStr;
    FQuantidade := -1;
    FMetrosFolhasPD7 := -1;
    FEncerrarOS := -1;
    FObservacao := EmptyStr;

    while OnMensagemErro do
      Application.ProcessMessages;

    CriarAtividade;

  end
  else
  begin

    varMsg := EmptyStr;

    if Duplicar > 0 then
    begin

      if varMsg.Length > 0 then
        varMsg := varMsg + ' - '
      else
        varMsg := #13#10;
      varMsg := varMsg + 'Duplicar: ' + IntToStr(Duplicar) + ' horas.'

    end;

    if Tempo > 0 then
    begin

      if varMsg.Length > 0 then
        varMsg := varMsg + ' - '
      else
        varMsg := #13#10;
      varMsg := varMsg + 'Tempo: ' + IntToStr(Tempo) + ' minutos.'

    end;

    if not Atividade.IsEmpty then
    begin

      if varMsg.Length > 0 then
        varMsg := varMsg + ' - '
      else
        varMsg := #13#10;
      varMsg := varMsg + 'Atividade: ' + db_getAtividadeNome(Atividade) + '.';

    end;

    if not OS.IsEmpty then
    begin

      if varMsg.Length > 0 then
        varMsg := varMsg + ' - '
      else
        varMsg := #13#10;
      varMsg := varMsg + 'OP: ' + OS + '.';

    end;

    if not YNumber.IsEmpty then
    begin

      if varMsg.Length > 0 then
        varMsg := varMsg + ' - '
      else
        varMsg := #13#10;
      varMsg := varMsg + 'Y#: ' + YNumber + '.';

    end;

    if Quantidade >= 0 then
    begin

      if varMsg.Length > 0 then
        varMsg := varMsg + ' - '
      else
        varMsg := #13#10;
      varMsg := varMsg + 'Quantidade: ' + FloatToStr(Quantidade) + '.';

    end;

    if MetrosFolhasPD7 >= 0 then
    begin

      if varMsg.Length > 0 then
        varMsg := varMsg + ' - '
      else
        varMsg := #13#10;
      varMsg := varMsg + 'Metros / Folha: ' + FloatToStr(MetrosFolhasPD7) + '.';

    end;

    if Duplicar = -1 then
    begin

      ExibirMensagem( 'Informe n�mero de horas para duplicar.' + varMsg, clWhite );

    end
    else
    if Tempo = 0 then
    begin

      ExibirMensagem( 'Informe o Tempo.' + varMsg, clSkyBlue );

    end
    else
    if Atividade.IsEmpty then
    begin

      ExibirMensagem( 'Informe a Atividade.' + varMsg, clMoneyGreen );

    end
    else
    if AtividadeOSYNumber and OS.IsEmpty then
    begin

      ExibirMensagem( 'Informe a OP.' + varMsg, clWhite );

    end
    else
    if AtividadeOSYNumber and YNumber.IsEmpty then
    begin

      ExibirMensagem( 'Informe o Y#.' + varMsg, clWhite );

    end
    else
    if AtividadeQuantidade and (Quantidade = -1) then
    begin

      ExibirMensagem( 'Informe a Quantidade.' + varMsg, clWhite );

    end
    else
    if AtividadeMetrosFolhasPD7 and (MetrosFolhasPD7 = -1) then
    begin

      ExibirMensagem( 'Informe o n�mero de Metros / Folhas.' + varMsg, clWhite );

    end
    else
    if AtividadeEncerraOS and (EncerrarOS = -1) then
    begin

      ExibirMensagem( 'Encerrar OP?' + varMsg, cl3DLight );

    end
    else
    begin

      varOSYNumber := EmptyStr;
      if AtividadeOSYNumber then
        varOSYNumber := ' - OP: ' + OS + ' - ' + YNumber;

      TrackBarHour.Position := TrackBarHour.Position + Tempo;

      LabelRemaingMinutes.Caption := '('+ IntTostr(60-TrackBarHour.Position) +' minutos)';

      if LabelOperacao1.Caption = EmptyStr then
        LabelOperacao1.Caption := db_getAtividadeNome(Atividade) + ' - ' + IntToStr(Tempo) + ' minutos' + varOSYNumber
      else
      if LabelOperacao2.Caption = EmptyStr then
        LabelOperacao2.Caption := db_getAtividadeNome(Atividade) + ' - ' + IntToStr(Tempo) + ' minutos' + varOSYNumber
      else
      if LabelOperacao3.Caption = EmptyStr then
        LabelOperacao3.Caption := db_getAtividadeNome(Atividade) + ' - ' + IntToStr(Tempo) + ' minutos' + varOSYNumber
      else
      if LabelOperacao4.Caption = EmptyStr then
        LabelOperacao4.Caption := db_getAtividadeNome(Atividade) + ' - ' + IntToStr(Tempo) + ' minutos' + varOSYNumber
      else
      if LabelOperacao5.Caption = EmptyStr then
        LabelOperacao5.Caption := db_getAtividadeNome(Atividade) + ' - ' + IntToStr(Tempo) + ' minutos' + varOSYNumber
      else
      if LabelOperacao6.Caption = EmptyStr then
        LabelOperacao6.Caption := db_getAtividadeNome(Atividade) + ' - ' + IntToStr(Tempo) + ' minutos' + varOSYNumber;

      varIndex := 0;
      if getTempoOperacoes( HoraHora[1].Operacoes ) < 60 then
        varIndex := 1
      else
      if getTempoOperacoes( HoraHora[2].Operacoes ) < 60 then
        varIndex := 2
      else
      if getTempoOperacoes( HoraHora[3].Operacoes ) < 60 then
        varIndex := 3
      else
      if getTempoOperacoes( HoraHora[4].Operacoes ) < 60 then
        varIndex := 4
      else
      if getTempoOperacoes( HoraHora[5].Operacoes ) < 60 then
        varIndex := 5
      else
      if getTempoOperacoes( HoraHora[6].Operacoes ) < 60 then
        varIndex := 6
      else
      if getTempoOperacoes( HoraHora[7].Operacoes ) < 60 then
        varIndex := 7
      else
      if getTempoOperacoes( HoraHora[8].Operacoes ) < 60 then
        varIndex := 8
      else
      if getTempoOperacoes( HoraHora[9].Operacoes ) < 60 then
        varIndex := 9;

      db_setAtividade( Maquina, Operador, HoraHora[varIndex].Inicial, Atividade, Tempo, OS, YNumber, Quantidade, MetrosFolhasPD7, EncerrarOS, Observacao );

      FTempo := 0;
      FAtividade := EmptyStr;
      FOS := EmptyStr;
      FYNumber := EmptyStr;
      FQuantidade := -1;
      FMetrosFolhasPD7 := -1;
      FEncerrarOS := -1;
      FObservacao := EmptyStr;

      EncerrarMensagem;

      if TrackBarHour.Position = 60 then
      begin

        FDuplicar := 0;

        Timer.Enabled := False;
        try

          db_saveAtividades;
          FOperador := EmptyStr;
          PanelOperacao.Visible := False;

        finally

          Timer.OnTimer(Timer);

        end;

        Application.ProcessMessages;

      end
      else
      begin

        Application.ProcessMessages;
        Sleep(1500);
        CriarAtividade;

      end;

    end;

  end;

end;

procedure TFr_PainelOperador.CriarAtividadeSemTurnoAuto;
var
  I: Integer;
  X: Integer;
  bExists: Boolean;

begin

  // Rafael Petrella - Estava causando erro.
  Exit;

  for I := 1 to 9 do
  begin

    if (not Maquina.IsEmpty) and (getTempoOperacoes( HoraHora[I].Operacoes ) < 60) and not ((HoraHora[I].Inicial >= db_getMaquinaHoraInicial(Maquina)) and (HoraHora[I].Inicial <= db_getMaquinaHoraFinal(Maquina))) then
    begin

      bExists := False;
      for X := Low(HoraHora[I].Operacoes) to High(HoraHora[I].Operacoes) do
        if HoraHora[I].Operacoes[X].Atividade.Equals('310003') then
          bExists := True;     

      if not bExists then
      begin

        if HoraHora[I].Inicial < db_getMaquinaHoraInicial(Maquina) then
        begin

          FTempo := System.DateUtils.MinutesBetween( HoraHora[I].Inicial, db_getMaquinaHoraInicial(Maquina) );
          if FTempo > 60 then
            FTempo := 60;

          FTempo := FTempo - getTempoOperacoes( HoraHora[I].Operacoes );
          
        end;

        if HoraHora[I].Final > db_getMaquinaHoraFinal(Maquina) then
        begin

          FTempo := System.DateUtils.MinutesBetween( db_getMaquinaHoraFinal(Maquina), HoraHora[I].Final );
          if FTempo > 60 then
            FTempo := 60;

          FTempo := FTempo - getTempoOperacoes( HoraHora[I].Operacoes );

        end;

        FAtividade := '310003';
        FOS := EmptyStr;
        FYNumber := EmptyStr;
        FQuantidade := -1;
        FMetrosFolhasPD7 := -1;
        FEncerrarOS := -1;
        FObservacao := 'Criado automaticamente pelo sistema.';

        CriarAtividade;

        CriarAtividadeSemTurnoAuto;
        
      end;

    end;

  end;

end;

function TFr_PainelOperador.db_getAtividadeSetup(pAtividade: string): Boolean;
var
  I: Integer;

begin

  Result := False;
  for I := 0 to DBOperacao.Count-1 do
  begin

    if DBOperacao[I].Split([';'])[0].Equals(pAtividade) then
      Result := DBOperacao[I].Split([';'])[2].Equals('2');

  end;

end;

procedure TFr_PainelOperador.db_deleteLastAtividade;
var
  varStringList: TStringList;
  varStringListDeleted: TStringList;

begin

  varStringList := TStringList.Create;
  varStringListDeleted := TStringList.Create;
  try

    varStringList.LoadFromFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\Atividade.db' );

    varStringListDeleted.LoadFromFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\AtividadeDeleted.db' );
    varStringListDeleted.Add(varStringList[varStringList.Count-1]);
    varStringListDeleted.SaveToFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\AtividadeDeleted.db' );

    varStringList.Delete(varStringList.Count-1);
    varStringList.SaveToFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\Atividade.db' );

    Timer.OnTimer(Timer);

  finally

    FreeAndNil( varStringList );
    FreeAndNil( varStringListDeleted );

  end;

end;

function TFr_PainelOperador.db_getAtividadeEncerraOS(pAtividade: string): Boolean;
var
  I: Integer;

begin

  Result := False;
  for I := 0 to DBOperacao.Count-1 do
  begin

    if DBOperacao[I].Split([';'])[0].Equals(pAtividade) then
      Result := DBOperacao[I].Split([';'])[5].Equals('S');

  end;

end;

function TFr_PainelOperador.db_getAtividadeQuantidade(pAtividade: string): Boolean;
var
  I: Integer;

begin

  Result := False;
  for I := 0 to DBOperacao.Count-1 do
  begin

    if DBOperacao[I].Split([';'])[0].Equals(pAtividade) then
      Result := DBOperacao[I].Split([';'])[4].Equals('S');

  end;

end;

function TFr_PainelOperador.db_getAtividadeMetrosFolhasPD7(pAtividade: string): Boolean;
var
  I: Integer;

begin

  Result := False;
  for I := 0 to DBOperacao.Count-1 do
  begin

    if DBOperacao[I].Split([';'])[0].Equals(pAtividade) then
      Result := DBOperacao[I].Split([';'])[4].Equals('S');

  end;

end;

function TFr_PainelOperador.db_getAtividadeNaoProdutiva(pAtividade: string): Boolean;
var
  I: Integer;
  
begin

  Result := False;
  for I := 0 to DBOperacao.Count-1 do
  begin

    if DBOperacao[I].Split([';'])[0].Equals(pAtividade) then
      Result := DBOperacao[I].Split([';'])[2].Equals('3');
  
  end;

end;

function TFr_PainelOperador.db_getAtividadeNome(pAtividade: string): string;
begin

  if db_getAtividadeSemTurno(pAtividade) then
    Result := 'Sem Turno'
  else
  if db_getAtividadeProdutiva(pAtividade) then
    Result := 'Produtiva'
  else
  if db_getAtividadeNaoProdutiva(pAtividade) then
    Result := 'Parada'
  else
  if db_getAtividadeSetup(pAtividade) then
    Result := 'Setup';
                      
end;

function TFr_PainelOperador.db_getAtividadeOSYNumber(pAtividade: string): Boolean;
var
  I: Integer;
  
begin

  Result := False;
  for I := 0 to DBOperacao.Count-1 do
  begin

    if DBOperacao[I].Split([';'])[0].Equals(pAtividade) then
      Result := DBOperacao[I].Split([';'])[3].Equals('S');
  
  end;

end;

function TFr_PainelOperador.db_getAtividadeSemTurno(pAtividade: string): Boolean;
var
  I: Integer;

begin

  Result := False;
  for I := 0 to DBOperacao.Count-1 do
  begin

    if DBOperacao[I].Split([';'])[0].Equals(pAtividade) then
      Result := DBOperacao[I].Split([';'])[2].Equals('0');

  end;

end;

function TFr_PainelOperador.db_getAtividadeProdutiva(pAtividade: string): Boolean;
var
  I: Integer;

begin

  Result := False;
  for I := 0 to DBOperacao.Count-1 do
  begin

    if DBOperacao[I].Split([';'])[0].Equals(pAtividade) then
      Result := DBOperacao[I].Split([';'])[2].Equals('1');

  end;

end;

function TFr_PainelOperador.db_getCelulaNome(pMaquina: string): string;
var
  I: Integer;
  
begin

  for I := 0 to DBMaquina.Count-1 do
  begin

    if DBMaquina[I].Split([';'])[0].Equals(pMaquina) then
      Result := DBMaquina[I].Split([';'])[1];
  
  end;

end;

function TFr_PainelOperador.db_getMaquinaNome(pMaquina: string): string;
var
  I: Integer;
  
begin

  Result := EmptyStr;
  for I := 0 to DBMaquina.Count-1 do
  begin

    if DBMaquina[I].Split([';'])[0].Equals(pMaquina) then
      Result := DBMaquina[I].Split([';'])[2];
  
  end;

end;

function TFr_PainelOperador.db_getMaquinaHoraInicial(pMaquina: string): TDateTime;
var
  I: Integer;

begin

  Result := -1;
  for I := 0 to DBMaquina.Count-1 do
  begin

    if DBMaquina[I].Split([';'])[0].Equals(pMaquina) then
      Result := Trunc(Now) + EncodeTime( StrToInt(Copy(DBMaquina[I].Split([';'])[3],1,2)), StrToInt(Copy(DBMaquina[I].Split([';'])[3],3,2)), 0, 0 );

  end;

end;

function TFr_PainelOperador.db_getMaquinaHoraFinal(pMaquina: string): TDateTime;
var
  I: Integer;

begin

  Result := -1;
  for I := 0 to DBMaquina.Count-1 do
  begin

    if DBMaquina[I].Split([';'])[0].Equals(pMaquina) then
      Result := Trunc(Now) + EncodeTime( StrToInt(Copy(DBMaquina[I].Split([';'])[4],1,2)), StrToInt(Copy(DBMaquina[I].Split([';'])[4],3,2)), 0, 0 );

  end;

end;

function TFr_PainelOperador.db_getOperacoes(pDataHora: TDateTime): TOperacoes;
var
  varStringList: TStringList;
  I: Integer;

begin

  SetLength( Result, 0 );
  varStringList := TStringList.Create;
  try

    varStringList.LoadFromFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\Atividade.db' );
    for I := 0 to varStringList.Count-1 do
    begin

      if StrToDateTime(varStringList[I].Split([';'])[2]) = pDataHora then
      begin

        SetLength( Result, Length(Result) + 1 );

        if db_getAtividadeSemTurno(varStringList[I].Split([';'])[3]) then
          Result[Length(Result) - 1].Tipo := tpoSemTurno
        else
        if db_getAtividadeProdutiva(varStringList[I].Split([';'])[3]) then
          Result[Length(Result) - 1].Tipo := tpoProdutiva
        else
        if db_getAtividadeSetup(varStringList[I].Split([';'])[3]) then
          Result[Length(Result) - 1].Tipo := tpoSetup
        else
        if db_getAtividadeNaoProdutiva(varStringList[I].Split([';'])[3]) then
          Result[Length(Result) - 1].Tipo := tpoNaoProdutiva;

        Result[Length(Result) - 1].Atividade := varStringList[I].Split([';'])[3];
        Result[Length(Result) - 1].Tempo := StrToInt(varStringList[I].Split([';'])[4]);
        Result[Length(Result) - 1].OP := varStringList[I].Split([';'])[5];
        Result[Length(Result) - 1].YNumber := varStringList[I].Split([';'])[6];
        Result[Length(Result) - 1].Quantidade := StrToFloat(varStringList[I].Split([';'])[7]);
        Result[Length(Result) - 1].MetrosFolhasPD7 := StrToFloat(varStringList[I].Split([';'])[8]);
        Result[Length(Result) - 1].EncerrarOS := varStringList[I].Split([';'])[9];
        Result[Length(Result) - 1].Observaocao := varStringList[I].Split([';'])[10];

      end;

    end;

  finally

    FreeAndNil( varStringList );

  end;

end;

function TFr_PainelOperador.db_getOperadorNome(pOperador: string): string;
var
  I: Integer;

begin

  for I := 0 to DBOperador.Count-1 do
  begin

    if DBOperador[I].Split([';'])[0].Equals(pOperador) then
      Result := DBOperador[I].Split([';'])[1];
  
  end;

end;

procedure TFr_PainelOperador.db_loadMaquinas;
begin

  FDBMaquina.LoadFromFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\Maquina.db' );

  if Assigned(Fr_PainelOperador4x1[Tag]) then
    Fr_PainelOperador4x1[Tag].db_loadMaquinas;

end;

procedure TFr_PainelOperador.db_loadOperacoes;
begin

  FDBOperacao.LoadFromFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\Operacao.db' );

end;

procedure TFr_PainelOperador.db_loadOperadores;
begin

  FDBOperador.LoadFromFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\Operador.db' );

end;

procedure TFr_PainelOperador.db_saveAtividades;
var
  varStringList: TStringList;
  varAtividadesOrdenada: TStringList;
  I: Integer;

begin

  varStringList := TStringList.Create;
  varAtividadesOrdenada := TStringList.Create;
  try

    for I := 0 to DBAtividades.Count -1 do
      if db_getAtividadeProdutiva(DBAtividades[I].Split([';'])[3]) then
        varAtividadesOrdenada.Add(DBAtividades[I]);

    for I := 0 to DBAtividades.Count -1 do
      if db_getAtividadeSetup(DBAtividades[I].Split([';'])[3]) then
        varAtividadesOrdenada.Add(DBAtividades[I]);

    for I := 0 to DBAtividades.Count -1 do
      if db_getAtividadeNaoProdutiva(DBAtividades[I].Split([';'])[3]) then
        varAtividadesOrdenada.Add(DBAtividades[I]);

    for I := 0 to DBAtividades.Count -1 do
      if db_getAtividadeSemTurno(DBAtividades[I].Split([';'])[3]) then
        varAtividadesOrdenada.Add(DBAtividades[I]);

    varStringList.LoadFromFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\Atividade.db' );
    varStringList.AddStrings( varAtividadesOrdenada );
    varStringList.SaveToFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\Atividade.db' );
    DBAtividades.Clear;

  finally

    FreeAndNil( varStringList );
    FreeAndNil( varAtividadesOrdenada );

  end;

end;

procedure TFr_PainelOperador.db_setAtividade( pMaquina: string; pOperador: string; pHoraIni: TDateTime; pAtividade: string; pTempo: Integer; pOS: string; pYNumber: string; pQuantidade: Extended; pMetrosFolhasPD7: Extended; pEncerraOS: Integer; pObservacao: String );
var
  varEncerraOS: String;
  varGUID: TGUID;
  I: Integer;
  varHora: TDateTime;

begin

  if pQuantidade = -1 then
    pQuantidade := 0;

  if pMetrosFolhasPD7 = -1 then
    pMetrosFolhasPD7 := 0;

  if pEncerraOS = 1 then
    varEncerraOS := 'S'
  else
    varEncerraOS := 'N';

  CreateGUID(varGUID);

  DBAtividades.Add( pMaquina + ';' + pOperador.Replace(';','-',[rfReplaceAll]) + ';' + DateTimeToStr( pHoraIni ) + ';' + pAtividade + ';' + IntToStr(pTempo) + ';' + pOS + ';' + pYNumber + ';' + FloatToStr(pQuantidade) + ';' + FloatToStr(pMetrosFolhasPD7) + ';' + varEncerraOS + ';' + pObservacao.Replace(';',',',[rfReplaceAll]) + ';' + GUIDToString(varGUID) + ';' );

  varHora := pHoraIni;
  for I := 1 to Duplicar do
  begin

    varHora := System.DateUtils.IncHour( varHora );

    CreateGUID(varGUID);
    DBAtividades.Add( pMaquina + ';' + pOperador.Replace(';','-',[rfReplaceAll]) + ';' + DateTimeToStr( varHora ) + ';' + pAtividade + ';' + IntToStr(pTempo) + ';' + pOS + ';' + pYNumber + ';' + FloatToStr(pQuantidade) + ';' + FloatToStr(pMetrosFolhasPD7) + ';' + varEncerraOS + ';' + pObservacao.Replace(';',',',[rfReplaceAll]) + ';' + GUIDToString(varGUID) + ';' );

  end;

end;

procedure TFr_PainelOperador.db_SyncSQLDatabase;
var
  I: Integer;
  varGUID: TGUID;
  varLastHourSync: TDateTime;
  varStringList: TStringList;
  varStringListDeleted: TStringList;
  varTMAQ_APOOPE: String;
  X: Integer;

begin

  if not OnOperacao and not OnMensagem and not OnMensagemErro then
  begin

    try
      ExibirMensagem( 'Executando sincroniza��o BD.', clSkyBlue );
      try

        ExibirMensagem( 'Executando sincroniza��o BD.'#13#10'Abrindo conex�o.', clSkyBlue );
        FDConnection.Params.LoadFromFile( MyDocumentsPath + '\DB.ini' );
        FDConnection.Open;
        try

          ExibirMensagem( 'Executando sincroniza��o BD.'#13#10'Atualizando M�quinas do Usu�rio.', clSkyBlue );
          FDQueryTSIS_UsuarioMaquina.ParamByName('TSIS_USULOG').AsString := ComputerName.Trim.ToUpper;
          FDQueryTSIS_UsuarioMaquina.Open;

          for I := 1 to 4 do
            FDadosConf.WriteString( 'Local', 'M�quina'+IntToStr(I), EmptyStr );

          I := 1;
          while not FDQueryTSIS_UsuarioMaquina.Eof do
          begin

            FDadosConf.WriteString( 'Local', 'M�quina'+IntToStr(I), FDQueryTSIS_UsuarioMaquinaTMAQ_MAQBAR.AsString );
            FDQueryTSIS_UsuarioMaquina.Next;
            Inc(I);

          end;

          ExibirMensagem( 'Executando sincroniza��o BD.'#13#10'Atualizando lista de M�quinas.', clSkyBlue );
          FDBMaquina.Clear;
          FDQueryTSOP_Maquina.Open;
          while not FDQueryTSOP_Maquina.Eof do
          begin

            FDBMaquina.Add(FDQueryTSOP_MaquinaTMAQ_MAQBAR.AsString + ';' + FDQueryTSOP_MaquinaTMAQ_CELNOM.AsString + ';' + FDQueryTSOP_MaquinaTMAQ_MAQNOM.AsString + ';' + FormatFloat('0000',FDQueryTSOP_MaquinaTMAQ_MAQHORINI.AsInteger/1.00) + ';' + FormatFloat('0000',FDQueryTSOP_MaquinaTMAQ_MAQHORFIM.AsInteger/1.00));
            FDQueryTSOP_Maquina.Next;

          end;
          FDBMaquina.SaveToFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\Maquina.db' );

          ExibirMensagem( 'Executando sincroniza��o BD.'#13#10'Atualizando lista de Opera��es.', clSkyBlue );
          FDBOperacao.Clear;
          FDQueryTSOP_Atividade.Open;
          while not FDQueryTSOP_Atividade.Eof do
          begin

            FDBOperacao.Add(FDQueryTSOP_AtividadeTMAQ_ATIBAR.AsString + ';' + FDQueryTSOP_AtividadeTMAQ_ATINOM.AsString + ';' + FDQueryTSOP_AtividadeTMAQ_ATITIP.AsString + ';' + FDQueryTSOP_AtividadeTMAQ_ATIOSEYNU.AsString + ';' + FDQueryTSOP_AtividadeTMAQ_ATIQTD.AsString + ';' + FDQueryTSOP_AtividadeTMAQ_ATIFINOSE.AsString);

            FDQueryTSOP_Atividade.Next;

          end;
          FDBOperacao.SaveToFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\Operacao.db' );

          ExibirMensagem( 'Executando sincroniza��o BD.'#13#10'Atualizando lista de Operadores.', clSkyBlue );
          FDBOperador.Clear;
          FDQueryTSOP_Operador.Open;
          while not FDQueryTSOP_Operador.Eof do
          begin

            FDBOperador.Add(FDQueryTSOP_OperadorTMAQ_OPEBAR.AsString + ';' + FDQueryTSOP_OperadorTMAQ_OPENOM.AsString);

            FDQueryTSOP_Operador.Next;

          end;
          FDBOperador.SaveToFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\Operador.db' );

          ExibirMensagem( 'Executando sincroniza��o BD.'#13#10'Atualizando Apontamentos.', clSkyBlue );
          varStringList := TStringList.Create;
          varStringListDeleted := TStringList.Create;
          try

            varStringList.LoadFromFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\Atividade.db' );
            varStringListDeleted.LoadFromFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\AtividadeDeleted.db' );

            if varStringList.Count > 0 then
            begin

              for I := 0 to varStringList.Count-1 do
              begin

                if Length(varStringList[I].Split([';'])) = 11 then
                begin

                  CreateGUID(varGUID);
                  varStringList[I] := varStringList[I] + GUIDToString(varGUID) + ';';

                end;

              end;

              varLastHourSync := 0;
              for I := 0 to varStringList.Count-1 do
              begin

                if Length(varStringList[I].Split([';'])) = 13 then
                begin

                  if (varLastHourSync = 0) or (varLastHourSync < StrToDateTime(varStringList[I].Split([';'])[2])) then
                    varLastHourSync := StrToDateTime(varStringList[I].Split([';'])[2]);

                end;

              end;

              if FDQueryTSOP_Maquina.Locate( 'TMAQ_MAQBAR', varStringList[0].Split([';'])[0] ) then
              begin

                FDQueryTSOP_Apontamento.ParamByName('TMAQ_MAQCOD').AsInteger := FDQueryTSOP_MaquinaTMAQ_MAQCOD.AsInteger;
                FDQueryTSOP_Apontamento.ParamByName('TMAQ_APODATINI').AsDateTime := varLastHourSync;
                FDQueryTSOP_Apontamento.Open;

                if varLastHourSync > 0 then
                  while not FDQueryTSOP_Apontamento.Eof do
                    FDQueryTSOP_Apontamento.Delete;

                for I := 0 to varStringList.Count-1 do
                begin

                  if Length(varStringList[I].Split([';'])) = 12 then
                  begin

                    varTMAQ_APOOPE := ';';
                    for X := 0 to Length(varStringList[I].Split([';'])[1].Split(['-']))-1 do
                      if FDQueryTSOP_Operador.Locate( 'TMAQ_OPEBAR', varStringList[I].Split([';'])[1].Split(['-'])[X] ) then
                        varTMAQ_APOOPE := varTMAQ_APOOPE + IntToStr(Length( FDQueryTSOP_OperadorTMAQ_OPEBAR.AsString + ' - ' + FDQueryTSOP_OperadorTMAQ_OPENOM.AsString )) + ':' + FDQueryTSOP_OperadorTMAQ_OPEBAR.AsString + ' - ' + FDQueryTSOP_OperadorTMAQ_OPENOM.AsString;

                    FDQueryTSOP_Apontamento.Append;

                    FDQueryTSOP_Atividade.Locate( 'TMAQ_ATIBAR', varStringList[I].Split([';'])[3] );

                    FDQueryTSOP_ApontamentoTMAQ_APOKEY.AsString := varStringList[I].Split([';'])[11];
                    FDQueryTSOP_ApontamentoTMAQ_MAQCOD.AsInteger := FDQueryTSOP_MaquinaTMAQ_MAQCOD.AsInteger;
                    FDQueryTSOP_ApontamentoTMAQ_ATICOD.AsInteger := FDQueryTSOP_AtividadeTMAQ_ATICOD.AsInteger;
                    FDQueryTSOP_ApontamentoTMAQ_APOOPE.AsString := varTMAQ_APOOPE;
                    FDQueryTSOP_ApontamentoTMAQ_APODATINI.AsDateTime := StrToDateTime(varStringList[I].Split([';'])[2]);
                    FDQueryTSOP_ApontamentoTMAQ_APOMIN.AsInteger := StrToInt(varStringList[I].Split([';'])[4]);
                    FDQueryTSOP_ApontamentoTMAQ_APOOSE.AsString := varStringList[I].Split([';'])[5];
                    FDQueryTSOP_ApontamentoTMAQ_APOITE.AsString := varStringList[I].Split([';'])[6];
                    FDQueryTSOP_ApontamentoTMAQ_APOQTD.AsFloat := StrToFloat(varStringList[I].Split([';'])[7]);
                    FDQueryTSOP_ApontamentoTMAQ_APOMET.AsFloat := StrToFloat(varStringList[I].Split([';'])[8]);
                    FDQueryTSOP_ApontamentoTMAQ_APOENCOSE.AsString := varStringList[I].Split([';'])[9];
                    FDQueryTSOP_ApontamentoTMAQ_APOOBS.AsString := varStringList[I].Split([';'])[10];

                    FDQueryTSOP_Apontamento.Post;

                    varStringList[I] := varStringList[I] + FDQueryTSOP_ApontamentoTMAQ_APOCOD.AsString + ';';

                  end;

                end;

                if varStringListDeleted.Count > 0 then
                begin

                  FDQueryTSOP_Apontamento.ParamByName('TMAQ_MAQCOD').AsInteger := FDQueryTSOP_MaquinaTMAQ_MAQCOD.AsInteger;
                  FDQueryTSOP_Apontamento.ParamByName('TMAQ_APODATINI').AsDateTime := StrToDateTime(varStringListDeleted[0].Split([';'])[2]);
                  FDQueryTSOP_Apontamento.Open;

                  for I := varStringListDeleted.Count-1 downto 0 do
                  begin

                    if FDQueryTSOP_Apontamento.Locate( 'TMAQ_APOKEY', varStringListDeleted[I].Split([';'])[11] ) then
                      FDQueryTSOP_Apontamento.Delete;

                    varStringListDeleted.Delete(I);

                  end;

                end;

              end;

            end;

            varStringList.SaveToFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\Atividade.db' );
            varStringListDeleted.SaveToFile( MyDocumentsPath + '\DB'+IntToStr(Tag)+'\AtividadeDeleted.db' );

          finally

            FreeAndNil(varStringList);
            FreeAndNil(varStringListDeleted);

          end;

        finally

          FDQueryTSIS_UsuarioMaquina.Close;
          FDQueryTSOP_Apontamento.Close;
          FDQueryTSOP_Maquina.Close;
          FDQueryTSOP_Atividade.Close;
          FDQueryTSOP_Operador.Close;

          FDConnection.Close;

        end;

      finally

        EncerrarMensagem;

      end;

    except

      on E: Exception do
      begin

        ExibirMensagemErro( 'Erro na sincroniza��o BD.'#13#10 + E.Message );

      end;

    end;

  end;

end;

procedure TFr_PainelOperador.DoCreateMyDocumentsPath;
var
  varMyDocument: String;

begin

  varMyDocument := MyDocumentsPath;
  if not System.IOUtils.TDirectory.Exists( varMyDocument ) then
    System.IOUtils.TDirectory.CreateDirectory( varMyDocument );

  if not System.IOUtils.TFile.Exists( varMyDocument + '\DB.ini' ) then
    System.IOUtils.TFile.Copy( ExtractFileDir(ParamStr(0)) + '\DB.ini', varMyDocument + '\DB.ini' );

  if not System.IOUtils.TFile.Exists( varMyDocument + '\DadosConfig.ini' ) then
    System.IOUtils.TFile.Copy( ExtractFileDir(ParamStr(0)) + '\DadosConfig.ini', varMyDocument + '\DadosConfig.ini' );

  varMyDocument := MyDocumentsPath + '\' + 'DB1';
  if not System.IOUtils.TDirectory.Exists( varMyDocument ) then
    System.IOUtils.TDirectory.CreateDirectory( varMyDocument );

  if not System.IOUtils.TFile.Exists( varMyDocument + '\Atividade.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\Atividade.db' ).Free;

  if not System.IOUtils.TFile.Exists( varMyDocument + '\AtividadeDeleted.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\AtividaDedeleted.db' ).Free;

  if not System.IOUtils.TFile.Exists( varMyDocument + '\Maquina.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\Maquina.db' ).Free;

  if not System.IOUtils.TFile.Exists( varMyDocument + '\Operacao.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\Operacao.db' ).Free;

  if not System.IOUtils.TFile.Exists( varMyDocument + '\Operador.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\Operador.db' ).Free;

  varMyDocument := MyDocumentsPath + '\' + 'DB2';
  if not System.IOUtils.TDirectory.Exists( varMyDocument ) then
    System.IOUtils.TDirectory.CreateDirectory( varMyDocument );

  if not System.IOUtils.TFile.Exists( varMyDocument + '\Atividade.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\Atividade.db' ).Free;

  if not System.IOUtils.TFile.Exists( varMyDocument + '\AtividadeDeleted.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\AtividaDedeleted.db' ).Free;

  if not System.IOUtils.TFile.Exists( varMyDocument + '\Maquina.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\Maquina.db' ).Free;

  if not System.IOUtils.TFile.Exists( varMyDocument + '\Operacao.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\Operacao.db' ).Free;

  if not System.IOUtils.TFile.Exists( varMyDocument + '\Operador.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\Operador.db' ).Free;

  varMyDocument := MyDocumentsPath + '\' + 'DB3';
  if not System.IOUtils.TDirectory.Exists( varMyDocument ) then
    System.IOUtils.TDirectory.CreateDirectory( varMyDocument );

  if not System.IOUtils.TFile.Exists( varMyDocument + '\Atividade.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\Atividade.db' ).Free;

  if not System.IOUtils.TFile.Exists( varMyDocument + '\AtividadeDeleted.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\AtividaDedeleted.db' ).Free;

  if not System.IOUtils.TFile.Exists( varMyDocument + '\Maquina.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\Maquina.db' ).Free;

  if not System.IOUtils.TFile.Exists( varMyDocument + '\Operacao.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\Operacao.db' ).Free;

  if not System.IOUtils.TFile.Exists( varMyDocument + '\Operador.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\Operador.db' ).Free;

  varMyDocument := MyDocumentsPath + '\' + 'DB4';
  if not System.IOUtils.TDirectory.Exists( varMyDocument ) then
    System.IOUtils.TDirectory.CreateDirectory( varMyDocument );

  if not System.IOUtils.TFile.Exists( varMyDocument + '\Atividade.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\Atividade.db' ).Free;

  if not System.IOUtils.TFile.Exists( varMyDocument + '\AtividadeDeleted.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\AtividaDedeleted.db' ).Free;

  if not System.IOUtils.TFile.Exists( varMyDocument + '\Maquina.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\Maquina.db' ).Free;

  if not System.IOUtils.TFile.Exists( varMyDocument + '\Operacao.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\Operacao.db' ).Free;

  if not System.IOUtils.TFile.Exists( varMyDocument + '\Operador.db' ) then
    System.IOUtils.TFile.Create( varMyDocument + '\Operador.db' ).Free;

end;

procedure TFr_PainelOperador.EncerrarMensagem;
begin

  PanelMensagem.Visible := False

end;

procedure TFr_PainelOperador.ExibirMensagem(pMensagem: string; pColor: TColor);
begin

  LabelMensagem.Caption := pMensagem;

  PanelMensagem.Color := pColor;
  PanelMensagem.Visible := True;
  PanelMensagem.BringToFront;
  Application.ProcessMessages;

  GravaLog(pMensagem);

end;

procedure TFr_PainelOperador.ExibirMensagemErro(pMensagem: string);
begin

  LabelMensagemErro.Caption := pMensagem;
  LabelMensagemErroTime.Caption := '3';

  PanelMensagemErro.Color := RGB_MensagemErro;
  PanelMensagemErro.Visible := True;
  PanelMensagemErro.BringToFront;
  Application.ProcessMessages;

  TimerMensagem.Enabled := True;

  GravaLog(pMensagem);

end;

procedure TFr_PainelOperador.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Timer.Enabled := False;
  FDadosConf.Free;
  FDBAtividades.Free;
  FDBMaquina.Free;
  FDBOperador.Free;
  FDBOperacao.Free;

  Action := caFree;
  Fr_PainelOperador[Tag] := nil;

end;

procedure TFr_PainelOperador.FormHide(Sender: TObject);
begin

  TimerShowChild.Enabled := False;

end;

procedure TFr_PainelOperador.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if Key = VK_F5 then
  begin

    db_SyncSQLDatabase;

  end;

  if OnMensagemErro then
  begin

    Key := 0;
    CharRead := EmptyStr;

  end
  else
  begin

    if Key = 13 then
    begin

      OnReadChar;
      CharRead := EmptyStr;

    end
    else
    if WaitingDuplicar then
    begin

    end
    else
    if WaitingQuantidade then
    begin


    end
    else
    if WaitingMetrosFolhasPD7 then
    begin

    end
    else
    begin

      if Key > 31 then
        CharRead := CharRead + Char(Key);

    end;

  end;

end;

procedure TFr_PainelOperador.FormKeyPress(Sender: TObject; var Key: Char);
var
  varMsg: string;

begin

  if not (Key = Chr(VK_RETURN)) then
  begin

    if WaitingDuplicar then
    begin

      if Key = Chr(VK_BACK) then
      begin

        CharRead := Copy( CharRead, 1, Length(CharRead)-1 );

      end
      else
      begin

        if CharInSet(Key,['0','1','2','3','4','5','6','7','8','9']) then
          CharRead := CharRead + Char(Key);

      end;

      varMsg := EmptyStr;

      if Duplicar > 0 then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Duplicar: ' + IntToStr(Duplicar) + ' horas.'

      end;

      if Tempo > 0 then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Tempo: ' + IntToStr(Tempo) + ' minutos.'

      end;

      if not Atividade.IsEmpty then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Atividade: ' + db_getAtividadeNome(Atividade) + '.';

      end;

      if not OS.IsEmpty then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'OP: ' + OS + '.';

      end;

      if not YNumber.IsEmpty then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Y#: ' + YNumber + '.';

      end;

      if Quantidade >= 0 then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Quantidade: ' + FloatToStr(Quantidade) + '.';

      end;

      if MetrosFolhasPD7 >= 0 then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Metros / Folha: ' + FloatToStr(MetrosFolhasPD7) + '.';

      end;

      ExibirMensagem( 'Informe n�mero de horas para duplicar.' + #13#10 + CharRead + varMsg, clWhite );

    end
    else
    if WaitingQuantidade then
    begin

      if Key = Chr(VK_BACK) then
      begin

        CharRead := Copy( CharRead, 1, Length(CharRead)-1 );

      end
      else
      begin

        if CharInSet(Key,['0','1','2','3','4','5','6','7','8','9']) then
          CharRead := CharRead + Char(Key);

      end;

      varMsg := EmptyStr;

      if Duplicar > 0 then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Duplicar: ' + IntToStr(Duplicar) + ' horas.'

      end;

      if Tempo > 0 then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Tempo: ' + IntToStr(Tempo) + ' minutos.'

      end;

      if not Atividade.IsEmpty then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Atividade: ' + db_getAtividadeNome(Atividade) + '.';

      end;

      if not OS.IsEmpty then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'OP: ' + OS + '.';

      end;

      if not YNumber.IsEmpty then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Y#: ' + YNumber + '.';

      end;

      if Quantidade >= 0 then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Quantidade: ' + FloatToStr(Quantidade) + '.';

      end;

      if MetrosFolhasPD7 >= 0 then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Metros / Folha: ' + FloatToStr(MetrosFolhasPD7) + '.';

      end;

      ExibirMensagem( 'Informe a Quantidade.' + #13#10 + CharRead + varMsg, clWhite );

    end
    else
    if WaitingMetrosFolhasPD7 then
    begin

      if Key = Chr(VK_BACK) then
      begin

        CharRead := Copy( CharRead, 1, Length(CharRead)-1 );

      end
      else
      begin

        if CharInSet(Key,['0','1','2','3','4','5','6','7','8','9']) then
          CharRead := CharRead + Char(Key)
        else
        if (Key = FormatSettings.DecimalSeparator) and (CharRead.Length > 0) and (not CharRead.Contains(FormatSettings.DecimalSeparator)) then
          CharRead := CharRead + FormatSettings.DecimalSeparator;

      end;

      varMsg := EmptyStr;

      if Duplicar > 0 then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Duplicar: ' + IntToStr(Duplicar) + ' horas.'

      end;

      if Tempo > 0 then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Tempo: ' + IntToStr(Tempo) + ' minutos.'

      end;

      if not Atividade.IsEmpty then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Atividade: ' + db_getAtividadeNome(Atividade) + '.';

      end;

      if not OS.IsEmpty then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'OP: ' + OS + '.';

      end;

      if not YNumber.IsEmpty then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Y#: ' + YNumber + '.';

      end;

      if Quantidade >= 0 then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Quantidade: ' + FloatToStr(Quantidade) + '.';

      end;

      if MetrosFolhasPD7 >= 0 then
      begin

        if varMsg.Length > 0 then
          varMsg := varMsg + ' - '
        else
          varMsg := #13#10;
        varMsg := varMsg + 'Metros / Folha: ' + FloatToStr(MetrosFolhasPD7) + '.';

      end;

      ExibirMensagem( 'Informe o n�mero de Metros / Folhas.' + #13#10 + CharRead + varMsg, clWhite );

    end;

  end;

end;

procedure TFr_PainelOperador.FormShow(Sender: TObject);
begin

  TimerShowChild.Enabled := True;

end;

function TFr_PainelOperador.getAtividade: string;
begin

  Result := FAtividade;

end;

function TFr_PainelOperador.getAtividadeEncerraOS: Boolean;
begin

  Result := db_getAtividadeEncerraOS( Atividade );

end;

function TFr_PainelOperador.getAtividadeQuantidade: Boolean;
begin

  Result := db_getAtividadeQuantidade( Atividade );

end;

function TFr_PainelOperador.getAtividadeMetrosFolhasPD7: Boolean;
begin

  Result := db_getAtividadeMetrosFolhasPD7( Atividade );

end;

function TFr_PainelOperador.getAtividadeNaoProdutiva: Boolean;
begin

  Result := db_getAtividadeNaoProdutiva( Atividade );

end;

function TFr_PainelOperador.getAtividadeOSYNumber: Boolean;
begin

  Result := db_getAtividadeOSYNumber( Atividade );

end;

function TFr_PainelOperador.getAtividadeSemTurno: Boolean;
begin

  Result := db_getAtividadeSemTurno( Atividade );

end;

function TFr_PainelOperador.getAtividadeProdutiva: Boolean;
begin

  Result := db_getAtividadeProdutiva( Atividade );

end;

function TFr_PainelOperador.getAtividadeSetup: Boolean;
begin

  Result := db_getAtividadeSetup( Atividade );

end;

function TFr_PainelOperador.getCelula: String;
begin

  Result := FCelula;

end;

function TFr_PainelOperador.getDataBase: TDateTime;
begin

  Result := FDataBase;

end;

function TFr_PainelOperador.getDuplicar: Integer;
begin

  Result := FDuplicar;

end;

function TFr_PainelOperador.getEncerrarOS: Integer;
begin

  Result := FEncerrarOS;

end;

function TFr_PainelOperador.getHoraAtual: Integer;
begin

  Result := 0;
  if (Now >= HoraHora[1].Inicial) and
     (Now <= HoraHora[1].Final) then
    Result := 1
  else
  if (Now >= HoraHora[2].Inicial) and
     (Now <= HoraHora[2].Final) then
    Result := 2
  else
  if (Now >= HoraHora[3].Inicial) and
     (Now <= HoraHora[3].Final) then
    Result := 3
  else
  if (Now >= HoraHora[4].Inicial) and
     (Now <= HoraHora[4].Final) then
    Result := 4
  else
  if (Now >= HoraHora[5].Inicial) and
     (Now <= HoraHora[5].Final) then
    Result := 5
  else
  if (Now >= HoraHora[6].Inicial) and
     (Now <= HoraHora[6].Final) then
    Result := 6
  else
  if (Now >= HoraHora[7].Inicial) and
     (Now <= HoraHora[7].Final) then
    Result := 7
  else
  if (Now >= HoraHora[8].Inicial) and
     (Now <= HoraHora[8].Final) then
    Result := 8
  else
  if (Now >= HoraHora[9].Inicial) and
     (Now <= HoraHora[9].Final) then
    Result := 9;

end;

function TFr_PainelOperador.getHoraHora: THoraHora;
begin

  Result := FHoraHora;

end;

function TFr_PainelOperador.getLastHoraHora: THoraHora;
begin

  Result := FLastHoraHora;

end;

function TFr_PainelOperador.getMaquina: String;
begin

  Result := FMaquina;

end;

function TFr_PainelOperador.getQuantidade: Extended;
begin

  Result := FQuantidade;

end;

function TFr_PainelOperador.getMetrosFolhasPD7: Extended;
begin

  Result := FMetrosFolhasPD7;

end;

function TFr_PainelOperador.getObservacao: String;
begin

  Result := FObservacao;

end;

function TFr_PainelOperador.getOnMensagem: Boolean;
begin

  Result := PanelMensagem.Visible;

end;

function TFr_PainelOperador.getOnMensagemErro: Boolean;
begin

  Result := PanelMensagemErro.Visible;

end;

function TFr_PainelOperador.getOnOperacao: Boolean;
begin

  Result := PanelOperacao.Visible;

end;

function TFr_PainelOperador.getOnSyncSQL: Boolean;
begin

  Result := FDConnection.Connected;

end;

function TFr_PainelOperador.getOperador: String;
begin

  Result := FOperador;

end;

function TFr_PainelOperador.getOS: string;
begin

  Result := FOS;

end;

function TFr_PainelOperador.getRGB_AlarmeRed: TColor;
begin

  Result := RGB(FDadosConf.ReadInteger( 'Alarme', 'RED R', 0 ),
                FDadosConf.ReadInteger( 'Alarme', 'RED G', 0 ),
                FDadosConf.ReadInteger( 'Alarme', 'RED B', 0 ));

end;

function TFr_PainelOperador.getRGB_AlarmeWhite: TColor;
begin

  Result := RGB(FDadosConf.ReadInteger( 'Alarme', 'WHITE R', 0 ),
                FDadosConf.ReadInteger( 'Alarme', 'WHITE G', 0 ),
                FDadosConf.ReadInteger( 'Alarme', 'WHITE B', 0 ));

end;

function TFr_PainelOperador.getRGB_BrushSemTurno: TColor;
begin

  Result := RGB(FDadosConf.ReadInteger( 'Sem Turno', 'Brush R', 0 ),
                FDadosConf.ReadInteger( 'Sem Turno', 'Brush G', 0 ),
                FDadosConf.ReadInteger( 'Sem Turno', 'Brush B', 0 ));

end;

function TFr_PainelOperador.getRGB_BrushSetup: TColor;
begin

  Result := RGB(FDadosConf.ReadInteger( 'Setup', 'Brush R', 0 ),
                FDadosConf.ReadInteger( 'Setup', 'Brush G', 0 ),
                FDadosConf.ReadInteger( 'Setup', 'Brush B', 0 ));

end;

function TFr_PainelOperador.getRGB_BrushNaoProdutivo: TColor;
begin

  Result := RGB(FDadosConf.ReadInteger( 'N�o Produtivo', 'Brush R', 0 ),
                FDadosConf.ReadInteger( 'N�o Produtivo', 'Brush G', 0 ),
                FDadosConf.ReadInteger( 'N�o Produtivo', 'Brush B', 0 ));

end;

function TFr_PainelOperador.getRGB_BrushProdutivo: TColor;
begin

  Result := RGB(FDadosConf.ReadInteger( 'Produtivo', 'Brush R', 0 ),
                FDadosConf.ReadInteger( 'Produtivo', 'Brush G', 0 ),
                FDadosConf.ReadInteger( 'Produtivo', 'Brush B', 0 ));

end;

function TFr_PainelOperador.getRGB_Mensagem: TColor;
begin

  Result := RGB(FDadosConf.ReadInteger( 'Mensagem', 'R', 0 ),
                FDadosConf.ReadInteger( 'Mensagem', 'G', 0 ),
                FDadosConf.ReadInteger( 'Mensagem', 'B', 0 ));

end;

function TFr_PainelOperador.getRGB_MensagemErro: TColor;
begin

  Result := RGB(FDadosConf.ReadInteger( 'Mensagem', 'ERRO R', 0 ),
                FDadosConf.ReadInteger( 'Mensagem', 'ERRO G', 0 ),
                FDadosConf.ReadInteger( 'Mensagem', 'ERRO B', 0 ));

end;

function TFr_PainelOperador.getRGB_PenSemTurno: TColor;
begin

  Result := RGB(FDadosConf.ReadInteger( 'Sem Turno', 'Pen R', 0 ),
                FDadosConf.ReadInteger( 'Sem Turno', 'Pen G', 0 ),
                FDadosConf.ReadInteger( 'Sem Turno', 'Pen B', 0 ));

end;

function TFr_PainelOperador.getRGB_PenSetup: TColor;
begin

  Result := RGB(FDadosConf.ReadInteger( 'Setup', 'Pen R', 0 ),
                FDadosConf.ReadInteger( 'Setup', 'Pen G', 0 ),
                FDadosConf.ReadInteger( 'Setup', 'Pen B', 0 ));

end;

function TFr_PainelOperador.getRGB_PenNaoProdutivo: TColor;
begin

  Result := RGB(FDadosConf.ReadInteger( 'N�o Produtivo', 'Pen R', 0 ),
                FDadosConf.ReadInteger( 'N�o Produtivo', 'Pen G', 0 ),
                FDadosConf.ReadInteger( 'N�o Produtivo', 'Pen B', 0 ));

end;

function TFr_PainelOperador.getRGB_PenProdutivo: TColor;
begin

  Result := RGB(FDadosConf.ReadInteger( 'Produtivo', 'Pen R', 0 ),
                FDadosConf.ReadInteger( 'Produtivo', 'Pen G', 0 ),
                FDadosConf.ReadInteger( 'Produtivo', 'Pen B', 0 ));

end;

function TFr_PainelOperador.getShapeHoraHora: THoraHoraShape;
begin

  Result[1] := ShapeHora1;
  Result[2] := ShapeHora2;
  Result[3] := ShapeHora3;
  Result[4] := ShapeHora4;
  Result[5] := ShapeHora5;
  Result[6] := ShapeHora6;
  Result[7] := ShapeHora7;
  Result[8] := ShapeHora8;
  Result[9] := ShapeHora9;

end;

function TFr_PainelOperador.getTempo: Integer;
begin

  Result := FTempo;

end;

function TFr_PainelOperador.getTempoOperacoes(pOperacoes: TOperacoes): Integer;
var
  I: Integer;
begin

  Result := 0;
  for I := Low(pOperacoes) to High(pOperacoes) do
    Result := Result + pOperacoes[I].Tempo;

end;

function TFr_PainelOperador.getYNumber: string;
begin

  Result := FYNumber;

end;

procedure TFr_PainelOperador.GravaLog(pMensagem: String);
var
  varStrLog: TStringList;

begin

  varStrLog := TStringList.Create;
  try

    if System.IOUtils.TFile.Exists( MyDocumentsPath + '\Dados' + FormatDateTime( 'yyyymmdd', Now ) + '.log' ) then
      varStrLog.LoadFromFile( MyDocumentsPath + '\Dados' + FormatDateTime( 'yyyymmdd', Now ) + '.log' );
    varStrLog.Add( FormatDateTime( 'dd/mm/yyyy hh:nn:ss', now ) + ': ' + pMensagem);
    varStrLog.SaveToFile( MyDocumentsPath + '\Dados' + FormatDateTime( 'yyyymmdd', Now ) + '.log' );

  finally

    FreeAndNil(varStrLog);

  end;

end;

procedure TFr_PainelOperador.Inicializar;
begin

  DoCreateMyDocumentsPath;

  LabelVersion.Caption := GetAppVersionStr;

  LabeledEditData.Text := EmptyStr;
  LabeledEditCelula.Text := EmptyStr;
  LabeledEditMaquina.Text := EmptyStr;
  LabeledEditOperador.Text := EmptyStr;

  FTempo := 0;
  FAtividade := EmptyStr;
  FOS := EmptyStr;
  FYNumber := EmptyStr;
  FQuantidade := -1;
  FMetrosFolhasPD7 := -1;
  FEncerrarOS := -1;
  FObservacao := EmptyStr;
  FDuplicar := 0;

  setScreen_Resolution;

  FDadosConf := TIniFile.Create( MyDocumentsPath + '\DadosConfig.ini' );

  FDBAtividades := TStringList.Create;
  FDBMaquina := TStringList.Create;
  FDBOperador := TStringList.Create;
  FDBOperacao := TStringList.Create;

  createChildForms;
  ShowChildForms;

  TimerSyncSQL.OnTimer(TimerSyncSQL);

  InicializarChild;

  db_loadMaquinas;
  if not FDadosConf.ReadString( 'Local', 'M�quina'+IntToStr(Tag), EmptyStr ).IsEmpty then
    Maquina := FDadosConf.ReadString( 'Local', 'M�quina'+IntToStr(Tag), EmptyStr );

end;

procedure TFr_PainelOperador.InicializarChild;
begin

  if not Assigned(Fr_PainelOperador4x1[Tag]) then
    Exit;

  Fr_PainelOperador4x1[Tag].LabeledEditData.Text := EmptyStr;
  Fr_PainelOperador4x1[Tag].LabeledEditCelula.Text := EmptyStr;
  Fr_PainelOperador4x1[Tag].LabeledEditMaquina.Text := EmptyStr;
  Fr_PainelOperador4x1[Tag].LabeledEditOperador.Text := EmptyStr;

  if not FDadosConf.ReadString( 'Local', 'M�quina'+IntToStr(Tag), EmptyStr ).IsEmpty then
    Maquina := FDadosConf.ReadString( 'Local', 'M�quina'+IntToStr(Tag), EmptyStr );

  Fr_PainelOperador4x1[Tag].Update;

end;

procedure TFr_PainelOperador.LabeledEditEnter(Sender: TObject);
begin

  ActiveControl := nil;

end;

procedure TFr_PainelOperador.OnReadAtividade;
begin

  if not WaitingAtividade then
  begin

    ExibirMensagemErro( 'A��o n�o permitida.' );
  
  end
  else
  begin

    Atividade := CharRead;
    
  end;

end;

procedure TFr_PainelOperador.OnReadChar;
begin

  if WaitingDuplicar then
  begin

    OnReadDuplicar;

  end
  else
  if WaitingQuantidade then
  begin

    OnReadQuantidade;

  end
  else
  if WaitingMetrosFolhasPD7 then
  begin

    OnReadMetrosFolhasPD7;

  end
  else
  if (Copy( CharRead, 1, 1 ) = 'Y') and (StrToIntDef(Copy( CharRead, 2, 7 ),0) > 0) then
  begin

    OnReadYNumber;

  end
  else
  if ((Copy( CharRead, 1, 2 ) = '23') or (Copy( CharRead, 1, 2 ) = '24') or (Copy( CharRead, 1, 2 ) = '25') or (Copy( CharRead, 1, 2 ) = '26') or (Copy( CharRead, 1, 2 ) = '27') or (Copy( CharRead, 1, 2 ) = '28') ) and (Length(CharRead) = 8) then
  begin

    OnReadOrdemServico;

  end
  else
  if (Copy( CharRead, 1, 3 ) = '100') and (Length(CharRead) = 7) then
  begin

    OnReadMaquina;

  end
  else
  if (Copy( CharRead, 1, 3 ) = '200') and (Length(CharRead) = 6) then
  begin

    OnReadOperador;

  end
  else
  if (Copy( CharRead, 1, 3 ) = '300') and (Length(CharRead) = 6) then
  begin

    OnReadOperacao;

  end
  else
  if (Copy( CharRead, 1, 3 ) = '310') and (Length(CharRead) = 6) then
  begin

    OnReadAtividade;

  end
  else
  if (Copy( CharRead, 1, 3 ) = '320') and (Length(CharRead) = 6) then
  begin

    OnReadTempo;

  end
  else
  begin
  
    ExibirMensagemErro( 'A��o n�o permitida.' );
  
  end;

end;

procedure TFr_PainelOperador.OnReadDuplicar;
begin

  if not WaitingDuplicar then
  begin

    ExibirMensagemErro( 'A��o n�o permitida.' );

  end
  else
  begin

    FTempo := 60;
    Duplicar := StrToInt(CharRead);

  end;

end;

procedure TFr_PainelOperador.OnReadMaquina;
begin

  Maquina := CharRead;

end;

procedure TFr_PainelOperador.OnReadQuantidade;
begin

  if not WaitingQuantidade then
  begin

    ExibirMensagemErro( 'A��o n�o permitida.' );

  end
  else
  begin

    Quantidade := StrToFloat(CharRead);

  end;

end;

procedure TFr_PainelOperador.OnReadMetrosFolhasPD7;
begin

  if not WaitingMetrosFolhasPD7 then
  begin

    ExibirMensagemErro( 'A��o n�o permitida.' );

  end
  else
  begin

    MetrosFolhasPD7 := StrToFloat(CharRead);

  end;

end;

procedure TFr_PainelOperador.OnReadOperacao;
var
  varIndex: Integer;
  varOSYNumber: String;
  I: Integer;

begin

  if CharRead.Equals('300008') then
  begin

    if not OnOperacao then
    begin

      ExibirMensagemErro( 'A��o n�o permitida.' );

    end
    else
    begin

      Duplicar := -1;

    end;

  end
  else
  if CharRead.Equals('300005') then
  begin

    if OnOperacao then
    begin

      ExibirMensagemErro( 'A��o n�o permitida.' );

    end
    else
    if Operador.IsEmpty then
    begin

      ExibirMensagemErro( 'Operador ainda n�o foi informado.' );

    end
    else
    begin

      TimerShowChild.Enabled := False;
      try

        LabelHoraHoraOperacao.Caption := EmptyStr;
        if getTempoOperacoes( HoraHora[1].Operacoes ) < 60 then
          LabelHoraHoraOperacao.Caption := HoraHora[1].Texto
        else
        if getTempoOperacoes( HoraHora[2].Operacoes ) < 60 then
          LabelHoraHoraOperacao.Caption := HoraHora[2].Texto
        else
        if getTempoOperacoes( HoraHora[3].Operacoes ) < 60 then
          LabelHoraHoraOperacao.Caption := HoraHora[3].Texto
        else
        if getTempoOperacoes( HoraHora[4].Operacoes ) < 60 then
          LabelHoraHoraOperacao.Caption := HoraHora[4].Texto
        else
        if getTempoOperacoes( HoraHora[5].Operacoes ) < 60 then
          LabelHoraHoraOperacao.Caption := HoraHora[5].Texto
        else
        if getTempoOperacoes( HoraHora[6].Operacoes ) < 60 then
          LabelHoraHoraOperacao.Caption := HoraHora[6].Texto
        else
        if getTempoOperacoes( HoraHora[7].Operacoes ) < 60 then
          LabelHoraHoraOperacao.Caption := HoraHora[7].Texto
        else
        if getTempoOperacoes( HoraHora[8].Operacoes ) < 60 then
          LabelHoraHoraOperacao.Caption := HoraHora[8].Texto
        else
        if getTempoOperacoes( HoraHora[9].Operacoes ) < 60 then
          LabelHoraHoraOperacao.Caption := HoraHora[9].Texto;

        if LabelHoraHoraOperacao.Caption = EmptyStr then
        begin

          ExibirMensagemErro( 'N�o existe hora disponivel para apontamento.' );

        end
        else
        begin

          varIndex := 0;
          if getTempoOperacoes( HoraHora[1].Operacoes ) < 60 then
            varIndex := 1
          else
          if getTempoOperacoes( HoraHora[2].Operacoes ) < 60 then
            varIndex := 2
          else
          if getTempoOperacoes( HoraHora[3].Operacoes ) < 60 then
            varIndex := 3
          else
          if getTempoOperacoes( HoraHora[4].Operacoes ) < 60 then
            varIndex := 4
          else
          if getTempoOperacoes( HoraHora[5].Operacoes ) < 60 then
            varIndex := 5
          else
          if getTempoOperacoes( HoraHora[6].Operacoes ) < 60 then
            varIndex := 6
          else
          if getTempoOperacoes( HoraHora[7].Operacoes ) < 60 then
            varIndex := 7
          else
          if getTempoOperacoes( HoraHora[8].Operacoes ) < 60 then
            varIndex := 8
          else
          if getTempoOperacoes( HoraHora[9].Operacoes ) < 60 then
            varIndex := 9;

          TrackBarHour.Position := 0;
          LabelRemaingMinutes.Caption := EmptyStr;
          LabelOperacao1.Caption := EmptyStr;
          LabelOperacao2.Caption := EmptyStr;
          LabelOperacao3.Caption := EmptyStr;
          LabelOperacao4.Caption := EmptyStr;
          LabelOperacao5.Caption := EmptyStr;
          LabelOperacao6.Caption := EmptyStr;

          for I := Low(HoraHora[varIndex].Operacoes) to High(HoraHora[varIndex].Operacoes) do
          begin

            varOSYNumber := EmptyStr;
            if AtividadeOSYNumber then
              varOSYNumber := ' - OP: ' + HoraHora[varIndex].Operacoes[I].OP + ' - ' + HoraHora[varIndex].Operacoes[I].YNumber;

            TrackBarHour.Position := TrackBarHour.Position + HoraHora[varIndex].Operacoes[I].Tempo;

            LabelRemaingMinutes.Caption := '('+ IntTostr(60-TrackBarHour.Position) +' minutos)';

            if LabelOperacao1.Caption = EmptyStr then
              LabelOperacao1.Caption := db_getAtividadeNome(HoraHora[varIndex].Operacoes[I].Atividade) + ' - ' + IntToStr(HoraHora[varIndex].Operacoes[I].Tempo) + ' minutos' + varOSYNumber
            else
            if LabelOperacao2.Caption = EmptyStr then
              LabelOperacao2.Caption := db_getAtividadeNome(HoraHora[varIndex].Operacoes[I].Atividade) + ' - ' + IntToStr(HoraHora[varIndex].Operacoes[I].Tempo) + ' minutos' + varOSYNumber
            else
            if LabelOperacao3.Caption = EmptyStr then
              LabelOperacao3.Caption := db_getAtividadeNome(HoraHora[varIndex].Operacoes[I].Atividade) + ' - ' + IntToStr(HoraHora[varIndex].Operacoes[I].Tempo) + ' minutos' + varOSYNumber
            else
            if LabelOperacao4.Caption = EmptyStr then
              LabelOperacao4.Caption := db_getAtividadeNome(HoraHora[varIndex].Operacoes[I].Atividade) + ' - ' + IntToStr(HoraHora[varIndex].Operacoes[I].Tempo) + ' minutos' + varOSYNumber
            else
            if LabelOperacao5.Caption = EmptyStr then
              LabelOperacao5.Caption := db_getAtividadeNome(HoraHora[varIndex].Operacoes[I].Atividade) + ' - ' + IntToStr(HoraHora[varIndex].Operacoes[I].Tempo) + ' minutos' + varOSYNumber
            else
            if LabelOperacao6.Caption = EmptyStr then
              LabelOperacao6.Caption := db_getAtividadeNome(HoraHora[varIndex].Operacoes[I].Atividade) + ' - ' + IntToStr(HoraHora[varIndex].Operacoes[I].Tempo) + ' minutos' + varOSYNumber;

          end;

          DBAtividades.Clear;
          PanelOperacao.Visible := True;
          Application.ProcessMessages;
          CriarAtividade;

        end;

      finally

        TimerShowChild.Enabled := True;

      end;

    end;

  end
  else
  if CharRead.Equals('300007') then
  begin

    if not OnOperacao then
    begin

      ExibirMensagemErro( 'A��o n�o permitida.' );

    end
    else
    begin

      FTempo := 0;
      FAtividade := EmptyStr;
      FOS := EmptyStr;
      FYNumber := EmptyStr;
      FQuantidade := -1;
      FMetrosFolhasPD7 := -1;
      FEncerrarOS := -1;
      FObservacao := EmptyStr;

      EncerrarMensagem;

      Timer.Enabled := False;
      try

        db_saveAtividades;
        FOperador := EmptyStr;
        PanelOperacao.Visible := False;

      finally

        Timer.OnTimer(Timer);

      end;

      Application.ProcessMessages;

    end;

  end
  else
  if CharRead.Equals('300001') then
  begin

    if not OnOperacao then
    begin

      ExibirMensagemErro( 'A��o n�o permitida.' );

    end
    else
    begin

      FTempo := 0;
      FAtividade := EmptyStr;
      FOS := EmptyStr;
      FYNumber := EmptyStr;
      FQuantidade := -1;
      FMetrosFolhasPD7 := -1;
      FEncerrarOS := -1;
      FObservacao := EmptyStr;
      FDuplicar := 0;
      EncerrarMensagem;
      PanelOperacao.Visible := False;

    end;

  end
  else
  if CharRead.Equals('300003') then
  begin

    if not WaitingEncerrarOS then
    begin

      ExibirMensagemErro( 'A��o n�o permitida.' );

    end
    else
    begin

      EncerrarOS := 0;

    end;

  end
  else
  if CharRead.Equals('300002') then
  begin

    if not WaitingEncerrarOS then
    begin

      ExibirMensagemErro( 'A��o n�o permitida.' );

    end
    else
    begin

      EncerrarOS := 1;

    end;

  end
  else
  if CharRead.Equals('300006') then
  begin

    if OnOperacao then
    begin

      ExibirMensagemErro( 'A��o n�o permitida.' );

    end
    else
    begin

      db_deleteLastAtividade;

    end;

  end
  else
  if CharRead.Equals('300004') then
  begin

    if not OnOperacao then
    begin

      ExibirMensagemErro( 'A��o n�o permitida.' );

    end
    else
    if not (WaitingQuantidade or WaitingMetrosFolhasPD7 or WaitingYNumber or WaitingOS or WaitingAtividade or WaitingTempo or WaitingEncerrarOS) then
    begin

      ExibirMensagemErro( 'A��o n�o permitida.' );

    end
    else
    begin

      Observacao := AddObservacao;

    end;

  end;

end;

procedure TFr_PainelOperador.OnReadOperador;
begin

  Operador := CharRead;

end;

procedure TFr_PainelOperador.OnReadOrdemServico;
begin

  if not WaitingOS then
  begin

    ExibirMensagemErro( 'A��o n�o permitida.' );
  
  end
  else
  begin

    OS := CharRead;
    
  end;

end;

procedure TFr_PainelOperador.OnReadTempo;
begin

  if not WaitingTempo then
  begin

    ExibirMensagemErro( 'A��o n�o permitida.' );
  
  end
  else
  begin

    Tempo := StrToInt(CharRead.Substring(4));
    
  end;

end;

procedure TFr_PainelOperador.OnReadYNumber;
begin

  if not WaitingYNumber then
  begin

    ExibirMensagemErro( 'A��o n�o permitida.' );

  end
  else
  begin

    YNumber := CharRead;

  end;

end;

procedure TFr_PainelOperador.RefreshShowChildForms;
var
  I: Integer;

begin

  for I := 1 to 4 do
  begin

    if Assigned(Fr_PainelOperador4x1[I]) then
    begin

      if Fr_PainelOperador4x1[I].Visible then
      begin

        Fr_PainelOperador4x1[I].BringToFront;
        Fr_PainelOperador4x1[I].Update;

      end;

    end;

  end;

end;

procedure TFr_PainelOperador.screen_deleteOperacoes;
var
  I: Integer;

begin

  for I := ComponentCount-1 downto 0 do
  begin

    if Components[I].Tag = 99 then
      Components[I].Free;

  end;

  screen_deleteOperacoesChild;

end;

procedure TFr_PainelOperador.screen_deleteOperacoesChild;
var
  I: Integer;

begin

  if Maquina.IsEmpty then
    Exit;

  for I := Fr_PainelOperador4x1[Tag].ComponentCount-1 downto 0 do
  begin

    if Fr_PainelOperador4x1[Tag].Components[I].Tag = 99 then
      Fr_PainelOperador4x1[Tag].Components[I].Free;

  end;

end;

procedure TFr_PainelOperador.screen_updateAlarme;
begin

  Color := RGB_AlarmeWhite;
  ShapeHeader.Brush.Color := RGB_AlarmeWhite;
  ShapeHora.Brush.Color := RGB_AlarmeWhite;
  ShapeTurno1.Brush.Color := RGB_AlarmeWhite;
  ShapeTurno2.Brush.Color := RGB_AlarmeWhite;
  ShapeHora1.Brush.Color := RGB_AlarmeWhite;
  ShapeHora2.Brush.Color := RGB_AlarmeWhite;
  ShapeHora3.Brush.Color := RGB_AlarmeWhite;
  ShapeHora4.Brush.Color := RGB_AlarmeWhite;
  ShapeHora5.Brush.Color := RGB_AlarmeWhite;
  ShapeHora6.Brush.Color := RGB_AlarmeWhite;
  ShapeHora7.Brush.Color := RGB_AlarmeWhite;
  ShapeHora8.Brush.Color := RGB_AlarmeWhite;
  ShapeHora9.Brush.Color := RGB_AlarmeWhite;
  ShapeHora01.Brush.Color := RGB_AlarmeWhite;
  ShapeHora02.Brush.Color := RGB_AlarmeWhite;
  ShapeHora03.Brush.Color := RGB_AlarmeWhite;
  ShapeHora04.Brush.Color := RGB_AlarmeWhite;
  ShapeHora05.Brush.Color := RGB_AlarmeWhite;
  ShapeHora06.Brush.Color := RGB_AlarmeWhite;
  ShapeHora07.Brush.Color := RGB_AlarmeWhite;
  ShapeHora08.Brush.Color := RGB_AlarmeWhite;
  ShapeHora09.Brush.Color := RGB_AlarmeWhite;
  LabeledEditData.Color := RGB_AlarmeWhite;
  LabeledEditCelula.Color := RGB_AlarmeWhite;
  LabeledEditMaquina.Color := RGB_AlarmeWhite;
  LabeledEditOperador.Color := RGB_AlarmeWhite;

  TimerAlarme.Enabled := False;
  if (not Maquina.IsEmpty) and (getTempoOperacoes( HoraHora[8].Operacoes ) < 60) then
  begin

    Color := RGB_AlarmeRed;
    ShapeHeader.Brush.Color := RGB_AlarmeRed;
    ShapeHora.Brush.Color := RGB_AlarmeRed;
    ShapeTurno1.Brush.Color := RGB_AlarmeRed;
    ShapeTurno2.Brush.Color := RGB_AlarmeRed;
    ShapeHora1.Brush.Color := RGB_AlarmeRed;
    ShapeHora2.Brush.Color := RGB_AlarmeRed;
    ShapeHora3.Brush.Color := RGB_AlarmeRed;
    ShapeHora4.Brush.Color := RGB_AlarmeRed;
    ShapeHora5.Brush.Color := RGB_AlarmeRed;
    ShapeHora6.Brush.Color := RGB_AlarmeRed;
    ShapeHora7.Brush.Color := RGB_AlarmeRed;
    ShapeHora8.Brush.Color := RGB_AlarmeRed;
    ShapeHora9.Brush.Color := RGB_AlarmeRed;
    ShapeHora01.Brush.Color := RGB_AlarmeRed;
    ShapeHora02.Brush.Color := RGB_AlarmeRed;
    ShapeHora03.Brush.Color := RGB_AlarmeRed;
    ShapeHora04.Brush.Color := RGB_AlarmeRed;
    ShapeHora05.Brush.Color := RGB_AlarmeRed;
    ShapeHora06.Brush.Color := RGB_AlarmeRed;
    ShapeHora07.Brush.Color := RGB_AlarmeRed;
    ShapeHora08.Brush.Color := RGB_AlarmeRed;
    ShapeHora09.Brush.Color := RGB_AlarmeRed;
    LabeledEditData.Color := RGB_AlarmeRed;
    LabeledEditCelula.Color := RGB_AlarmeRed;
    LabeledEditMaquina.Color := RGB_AlarmeRed;
    LabeledEditOperador.Color := RGB_AlarmeRed;

    TimerAlarme.Enabled := True;

  end;

  screen_updateAlarmeChild;

end;

procedure TFr_PainelOperador.screen_updateAlarmeChild;
begin

  if not Assigned(Fr_PainelOperador4x1[Tag]) then
    Exit;

  Fr_PainelOperador4x1[Tag].Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHeader.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeTurno1.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeTurno2.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora1.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora2.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora3.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora4.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora5.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora6.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora7.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora8.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora9.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora01.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora02.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora03.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora04.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora05.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora06.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora07.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora08.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].ShapeHora09.Brush.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].LabeledEditData.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].LabeledEditCelula.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].LabeledEditMaquina.Color := RGB_AlarmeWhite;
  Fr_PainelOperador4x1[Tag].LabeledEditOperador.Color := RGB_AlarmeWhite;


  TimerChildAlarme.Enabled := False;
  if (not Maquina.IsEmpty) and (getTempoOperacoes( HoraHora[8].Operacoes ) < 60) then
  begin

    Fr_PainelOperador4x1[Tag].Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHeader.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeTurno1.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeTurno2.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora1.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora2.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora3.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora4.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora5.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora6.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora7.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora8.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora9.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora01.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora02.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora03.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora04.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora05.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora06.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora07.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora08.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora09.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].LabeledEditData.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].LabeledEditCelula.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].LabeledEditMaquina.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].LabeledEditOperador.Color := RGB_AlarmeRed;

    TimerChildAlarme.Enabled := True;

  end;

end;

procedure TFr_PainelOperador.screen_updateOperacoes;
const
  iWidth60Min = 742;
  iHeight540min = 663;

var
  varOperacao: ROperacao;
  I: Integer;
  X: Integer;
  varShape: TShape;
  varLabel: TLabel;
  varWidthTotal: Integer;
  varHeightTotal: Integer;

  varMinutosOperacaoSemTurno: array[0..1] of Integer;
  varMinutosOperacaoSetup: array[0..1] of Integer;
  varMinutosOperacaoProdutivo: array[0..1] of Integer;
  varMinutosOperacaoNaoProdutivo: array[0..1] of Integer;

begin

  if Maquina.IsEmpty then
    Exit;

  for X := 1 to 9 do
  begin

    varWidthTotal := 0;
    for I := 0 to Length(HoraHora[X].Operacoes)-1 do
    begin

      varOperacao := HoraHora[X].Operacoes[I];

      varShape := TShape.Create(Self);
      varShape.Tag := 99;
      varShape.Left := 160 + varWidthTotal;
      varShape.Top := 95 + ( 74 * (X - 1) );

      if varOperacao.Tempo = 60 then
        varShape.Width := iWidth60Min
      else
        varShape.Width := Trunc( iWidth60Min / 60 * varOperacao.Tempo ) -1;

      varWidthTotal := varWidthTotal + varShape.Width + 1;

      if getTempoOperacoes( HoraHora[X].Operacoes ) = 60 then
        if I = Length(HoraHora[X].Operacoes)-1 then
          varShape.Width := varShape.Width + (iWidth60Min - varWidthTotal) + 1;

      varShape.Height := 71;

      if varOperacao.Tipo = tpoSemTurno then
      begin
        varShape.Brush.Color := clGrayText;
        varShape.Pen.Color := clBlack;
        varMinutosOperacaoSemTurno[1] := varMinutosOperacaoSemTurno[1] + varOperacao.Tempo;
      end
      else
      if varOperacao.Tipo = tpoProdutiva then
      begin
        varShape.Brush.Color := RGB_BrushProdutivo;
        varShape.Pen.Color := RGB_PenProdutivo;
        varMinutosOperacaoProdutivo[1] := varMinutosOperacaoProdutivo[1] + varOperacao.Tempo;
      end
      else
      if varOperacao.Tipo = tpoNaoProdutiva then
      begin
        varShape.Brush.Color := RGB_BrushNaoProdutivo;
        varShape.Pen.Color := RGB_PenNaoProdutivo;
        varMinutosOperacaoNaoProdutivo[1] := varMinutosOperacaoNaoProdutivo[1] + varOperacao.Tempo;
      end
      else
      if varOperacao.Tipo = tpoSetup then
      begin
        varShape.Brush.Color := RGB_BrushSetup;
        varShape.Pen.Color := RGB_PenSetup;
        varMinutosOperacaoSetup[1] := varMinutosOperacaoSetup[1] + varOperacao.Tempo;
      end;

      varShape.Shape := stRoundRect;
      varShape.Parent := Self;

      varLabel := TLabel.Create(Self);
      varLabel.Tag := 99;
      varLabel.Left := varShape.Left;
      varLabel.Top := varShape.Top;
      varLabel.Width := varShape.Width;
      varLabel.Height := varShape.Height;
      varLabel.Alignment := taCenter;
      varLabel.AutoSize := False;
      varLabel.WordWrap := True;

      if varOperacao.Tipo in [tpoProdutiva,tpoSetup] then
      begin

        varLabel.Caption := EmptyStr;

        if varOperacao.Observaocao.Length > 0 then
          varLabel.Caption := varLabel.Caption + '#';

        if varOperacao.EncerrarOS.Equals('S') then
          varLabel.Caption := varLabel.Caption + '*';

        varLabel.Caption := Trim(varOperacao.OP + ' - ' + varOperacao.YNumber + ' ' + varLabel.Caption);

      end
      else
      begin

        varLabel.Caption := EmptyStr;

        if varOperacao.Observaocao.Length > 0 then
          varLabel.Caption := '#';

      end;

      varLabel.Layout := tlCenter;
      varLabel.Parent := Self;

    end;

  end;

  for X := 1 to 9 do
  begin

    for I := 0 to Length(LastHoraHora[X].Operacoes)-1 do
    begin

      varOperacao := LastHoraHora[X].Operacoes[I];

      if varOperacao.Tipo = tpoSemTurno then
        varMinutosOperacaoSemTurno[0] := varMinutosOperacaoSemTurno[0] + varOperacao.Tempo
      else
      if varOperacao.Tipo = tpoProdutiva then
        varMinutosOperacaoProdutivo[0] := varMinutosOperacaoProdutivo[0] + varOperacao.Tempo
      else
      if varOperacao.Tipo = tpoNaoProdutiva then
        varMinutosOperacaoNaoProdutivo[0] := varMinutosOperacaoNaoProdutivo[0] + varOperacao.Tempo
      else
      if varOperacao.Tipo = tpoSetup then
        varMinutosOperacaoSetup[0] := varMinutosOperacaoSetup[0] + varOperacao.Tempo;

    end;

  end;

  varHeightTotal := 0;

  varShape := TShape.Create(Self);
  varShape.Tag := 99;
  varShape.Left := 912;
  varShape.Top := 95 + varHeightTotal;
  varShape.Height := Trunc( varMinutosOperacaoProdutivo[0] / 540.00 * iHeight540min );
  varShape.Width := 46;
  varShape.Brush.Color := RGB_BrushProdutivo;
  varShape.Pen.Color := RGB_PenProdutivo;
  varShape.Shape := stRoundRect;
  varShape.Parent := Self;

  varLabel := TLabel.Create(Self);
  varLabel.Tag := 99;
  varLabel.Left := varShape.Left;
  varLabel.Top := varShape.Top;
  varLabel.Width := varShape.Width;
  varLabel.Height := varShape.Height;
  varLabel.Alignment := taCenter;
  varLabel.AutoSize := False;
  varLabel.WordWrap := True;
  varLabel.Font.Size := 10;
  varLabel.Caption := FormatFloat( '#,##0.0', varMinutosOperacaoProdutivo[0] / 540.00 * 100.00 ) + '%';
  varLabel.Layout := tlCenter;
  varLabel.Parent := Self;

  varHeightTotal := varHeightTotal + varShape.Height + 1;

  varShape := TShape.Create(Self);
  varShape.Tag := 99;
  varShape.Left := 912;
  varShape.Top := 95 + varHeightTotal;
  varShape.Height := Trunc( varMinutosOperacaoSetup[0] / 540.00 * iHeight540min );
  varShape.Width := 46;
  varShape.Brush.Color := RGB_BrushSetup;
  varShape.Pen.Color := RGB_PenSetup;
  varShape.Shape := stRoundRect;
  varShape.Parent := Self;

  varLabel := TLabel.Create(Self);
  varLabel.Tag := 99;
  varLabel.Left := varShape.Left;
  varLabel.Top := varShape.Top;
  varLabel.Width := varShape.Width;
  varLabel.Height := varShape.Height;
  varLabel.Alignment := taCenter;
  varLabel.AutoSize := False;
  varLabel.WordWrap := True;
  varLabel.Font.Size := 10;
  varLabel.Caption := FormatFloat( '#,##0.0', varMinutosOperacaoSetup[0] / 540.00 * 100.00 ) + '%';
  varLabel.Layout := tlCenter;
  varLabel.Parent := Self;

  varHeightTotal := varHeightTotal + varShape.Height + 1;

  varShape := TShape.Create(Self);
  varShape.Tag := 99;
  varShape.Left := 912;
  varShape.Top := 95 + varHeightTotal;
  varShape.Height := Trunc( varMinutosOperacaoSemTurno[0] / 540.00 * iHeight540min );
  varShape.Width := 46;
  varShape.Brush.Color := clGrayText;
  varShape.Pen.Color := clBlack;
  varShape.Shape := stRoundRect;
  varShape.Parent := Self;

  varLabel := TLabel.Create(Self);
  varLabel.Tag := 99;
  varLabel.Left := varShape.Left;
  varLabel.Top := varShape.Top;
  varLabel.Width := varShape.Width;
  varLabel.Height := varShape.Height;
  varLabel.Alignment := taCenter;
  varLabel.AutoSize := False;
  varLabel.WordWrap := True;
  varLabel.Font.Size := 10;
  varLabel.Caption := FormatFloat( '#,##0.0', varMinutosOperacaoSemTurno[0] / 540.00 * 100.00 ) + '%';
  varLabel.Layout := tlCenter;
  varLabel.Parent := Self;

  varHeightTotal := varHeightTotal + varShape.Height + 1;

  varShape := TShape.Create(Self);
  varShape.Tag := 99;
  varShape.Left := 912;
  varShape.Top := 95 + varHeightTotal;
  varShape.Height := Trunc( varMinutosOperacaoNaoProdutivo[0] / 540.00 * iHeight540min );
  varShape.Width := 46;
  varShape.Brush.Color := RGB_BrushNaoProdutivo;
  varShape.Pen.Color := RGB_PenNaoProdutivo;
  varShape.Shape := stRoundRect;
  varShape.Parent := Self;

  varLabel := TLabel.Create(Self);
  varLabel.Tag := 99;
  varLabel.Left := varShape.Left;
  varLabel.Top := varShape.Top;
  varLabel.Width := varShape.Width;
  varLabel.Height := varShape.Height;
  varLabel.Alignment := taCenter;
  varLabel.AutoSize := False;
  varLabel.WordWrap := True;
  varLabel.Font.Size := 10;
  varLabel.Caption := FormatFloat( '#,##0.0', varMinutosOperacaoNaoProdutivo[0] / 540.00 * 100.00 ) + '%';
  varLabel.Layout := tlCenter;
  varLabel.Parent := Self;

  varHeightTotal := 0;

  varShape := TShape.Create(Self);
  varShape.Tag := 99;
  varShape.Left := 968;
  varShape.Top := 95 + varHeightTotal;
  varShape.Height := Trunc( varMinutosOperacaoProdutivo[1] / 540.00 * iHeight540min );
  varShape.Width := 46;
  varShape.Brush.Color := RGB_BrushProdutivo;
  varShape.Pen.Color := RGB_PenProdutivo;
  varShape.Shape := stRoundRect;
  varShape.Parent := Self;

  varLabel := TLabel.Create(Self);
  varLabel.Tag := 99;
  varLabel.Left := varShape.Left;
  varLabel.Top := varShape.Top;
  varLabel.Width := varShape.Width;
  varLabel.Height := varShape.Height;
  varLabel.Alignment := taCenter;
  varLabel.AutoSize := False;
  varLabel.WordWrap := True;
  varLabel.Font.Size := 10;
  varLabel.Caption := FormatFloat( '#,##0.0', varMinutosOperacaoProdutivo[1] / 540.00 * 100.00 ) + '%';
  varLabel.Layout := tlCenter;
  varLabel.Parent := Self;

  varHeightTotal := varHeightTotal + varShape.Height + 1;

  varShape := TShape.Create(Self);
  varShape.Tag := 99;
  varShape.Left := 968;
  varShape.Top := 95 + varHeightTotal;
  varShape.Height := Round( varMinutosOperacaoSetup[1] / 540.00 * iHeight540min );
  varShape.Width := 46;
  varShape.Brush.Color := RGB_BrushSetup;
  varShape.Pen.Color := RGB_PenSetup;
  varShape.Shape := stRoundRect;
  varShape.Parent := Self;

  varLabel := TLabel.Create(Self);
  varLabel.Tag := 99;
  varLabel.Left := varShape.Left;
  varLabel.Top := varShape.Top;
  varLabel.Width := varShape.Width;
  varLabel.Height := varShape.Height;
  varLabel.Alignment := taCenter;
  varLabel.AutoSize := False;
  varLabel.WordWrap := True;
  varLabel.Font.Size := 10;
  varLabel.Caption := FormatFloat( '#,##0.0', varMinutosOperacaoSetup[1] / 540.00 * 100.00 ) + '%';
  varLabel.Layout := tlCenter;
  varLabel.Parent := Self;

  varHeightTotal := varHeightTotal + varShape.Height + 1;

  varShape := TShape.Create(Self);
  varShape.Tag := 99;
  varShape.Left := 968;
  varShape.Top := 95 + varHeightTotal;
  varShape.Height := Round( varMinutosOperacaoSemTurno[1] / 540.00 * iHeight540min );
  varShape.Width := 46;
  varShape.Brush.Color := clGrayText;
  varShape.Pen.Color := clBlack;
  varShape.Shape := stRoundRect;
  varShape.Parent := Self;

  varLabel := TLabel.Create(Self);
  varLabel.Tag := 99;
  varLabel.Left := varShape.Left;
  varLabel.Top := varShape.Top;
  varLabel.Width := varShape.Width;
  varLabel.Height := varShape.Height;
  varLabel.Alignment := taCenter;
  varLabel.AutoSize := False;
  varLabel.WordWrap := True;
  varLabel.Font.Size := 10;
  varLabel.Caption := FormatFloat( '#,##0.0', varMinutosOperacaoSemTurno[1] / 540.00 * 100.00 ) + '%';
  varLabel.Layout := tlCenter;
  varLabel.Parent := Self;

  varHeightTotal := varHeightTotal + varShape.Height + 1;

  varShape := TShape.Create(Self);
  varShape.Tag := 99;
  varShape.Left := 968;
  varShape.Top := 95 + varHeightTotal;
  varShape.Height := Round( varMinutosOperacaoNaoProdutivo[1] / 540.00 * iHeight540min );
  varShape.Width := 46;
  varShape.Brush.Color := RGB_BrushNaoProdutivo;
  varShape.Pen.Color := RGB_PenNaoProdutivo;
  varShape.Shape := stRoundRect;
  varShape.Parent := Self;

  varLabel := TLabel.Create(Self);
  varLabel.Tag := 99;
  varLabel.Left := varShape.Left;
  varLabel.Top := varShape.Top;
  varLabel.Width := varShape.Width;
  varLabel.Height := varShape.Height;
  varLabel.Alignment := taCenter;
  varLabel.AutoSize := False;
  varLabel.WordWrap := True;
  varLabel.Font.Size := 10;
  varLabel.Caption := FormatFloat( '#,##0.0', varMinutosOperacaoNaoProdutivo[1] / 540.00 * 100.00 ) + '%';
  varLabel.Layout := tlCenter;
  varLabel.Parent := Self;

  screen_updateOperacoesChild;

end;

procedure TFr_PainelOperador.screen_updateOperacoesChild;
const
  iWidth60Min = 368;
  iHeight540min = 321;

var
  varOperacao: ROperacao;
  I: Integer;
  X: Integer;
  varShape: TShape;
  varLabel: TLabel;
  varWidthTotal: Integer;
  varHeightTotal: Integer;

  varMinutosOperacaoSemTurno: array[0..1] of Integer;
  varMinutosOperacaoSetup: array[0..1] of Integer;
  varMinutosOperacaoProdutivo: array[0..1] of Integer;
  varMinutosOperacaoNaoProdutivo: array[0..1] of Integer;

begin

  if Maquina.IsEmpty then
    Exit;

  if not Assigned(Fr_PainelOperador4x1[Tag]) then
    Exit;

  for X := 1 to 9 do
  begin

    varWidthTotal := 0;
    for I := 0 to Length(HoraHora[X].Operacoes)-1 do
    begin

      varOperacao := HoraHora[X].Operacoes[I];

      varShape := TShape.Create(Fr_PainelOperador4x1[Tag]);
      varShape.Tag := 99;
      varShape.Left := 78 + varWidthTotal;
      varShape.Top := 50 + ( 36 * (X - 1) );

      if varOperacao.Tempo = 60 then
        varShape.Width := iWidth60Min
      else
        varShape.Width := Trunc( iWidth60Min / 60 * varOperacao.Tempo ) -1;

      varWidthTotal := varWidthTotal + varShape.Width + 1;

      if getTempoOperacoes( HoraHora[X].Operacoes ) = 60 then
        if I = Length(HoraHora[X].Operacoes)-1 then
          varShape.Width := varShape.Width + (iWidth60Min - varWidthTotal) + 1;

      varShape.Height := 33;

      if varOperacao.Tipo = tpoSemTurno then
      begin
        varShape.Brush.Color := clGrayText;
        varShape.Pen.Color := clBlack;
        varMinutosOperacaoSemTurno[1] := varMinutosOperacaoSemTurno[1] + varOperacao.Tempo;
      end
      else
      if varOperacao.Tipo = tpoProdutiva then
      begin
        varShape.Brush.Color := RGB_BrushProdutivo;
        varShape.Pen.Color := RGB_PenProdutivo;
        varMinutosOperacaoProdutivo[1] := varMinutosOperacaoProdutivo[1] + varOperacao.Tempo;
      end
      else
      if varOperacao.Tipo = tpoNaoProdutiva then
      begin
        varShape.Brush.Color := RGB_BrushNaoProdutivo;
        varShape.Pen.Color := RGB_PenNaoProdutivo;
        varMinutosOperacaoNaoProdutivo[1] := varMinutosOperacaoNaoProdutivo[1] + varOperacao.Tempo;
      end
      else
      if varOperacao.Tipo = tpoSetup then
      begin
        varShape.Brush.Color := RGB_BrushSetup;
        varShape.Pen.Color := RGB_PenSetup;
        varMinutosOperacaoSetup[1] := varMinutosOperacaoSetup[1] + varOperacao.Tempo;
      end;

      varShape.Shape := stRoundRect;
      varShape.Parent := Fr_PainelOperador4x1[Tag];

      varLabel := TLabel.Create(Fr_PainelOperador4x1[Tag]);
      varLabel.Tag := 99;
      varLabel.Left := varShape.Left;
      varLabel.Top := varShape.Top;
      varLabel.Width := varShape.Width;
      varLabel.Height := varShape.Height;
      varLabel.Alignment := taCenter;
      varLabel.AutoSize := False;
      varLabel.WordWrap := True;
      varLabel.Font.Size := 6;

      if varOperacao.Tipo in [tpoProdutiva,tpoSetup] then
      begin

        varLabel.Caption := EmptyStr;

        if varOperacao.Observaocao.Length > 0 then
          varLabel.Caption := varLabel.Caption + '#';

        if varOperacao.EncerrarOS.Equals('S') then
          varLabel.Caption := varLabel.Caption + '*';

        varLabel.Caption := Trim(varOperacao.OP + ' - ' + varOperacao.YNumber + ' ' + varLabel.Caption);

      end
      else
      begin

        varLabel.Caption := EmptyStr;

        if varOperacao.Observaocao.Length > 0 then
          varLabel.Caption := '#';

      end;

      varLabel.Layout := tlCenter;
      varLabel.Parent := Fr_PainelOperador4x1[Tag];

    end;

  end;

  for X := 1 to 9 do
  begin

    for I := 0 to Length(LastHoraHora[X].Operacoes)-1 do
    begin

      varOperacao := LastHoraHora[X].Operacoes[I];

      if varOperacao.Tipo = tpoSemTurno then
        varMinutosOperacaoSemTurno[0] := varMinutosOperacaoSemTurno[0] + varOperacao.Tempo
      else
      if varOperacao.Tipo = tpoProdutiva then
        varMinutosOperacaoProdutivo[0] := varMinutosOperacaoProdutivo[0] + varOperacao.Tempo
      else
      if varOperacao.Tipo = tpoNaoProdutiva then
        varMinutosOperacaoNaoProdutivo[0] := varMinutosOperacaoNaoProdutivo[0] + varOperacao.Tempo
      else
      if varOperacao.Tipo = tpoSetup then
        varMinutosOperacaoSetup[0] := varMinutosOperacaoSetup[0] + varOperacao.Tempo;

    end;

  end;

  varHeightTotal := 0;

  varShape := TShape.Create(Fr_PainelOperador4x1[Tag]);
  varShape.Tag := 99;
  varShape.Left := 451;
  varShape.Top := 49 + varHeightTotal;
  varShape.Height := Trunc( varMinutosOperacaoProdutivo[0] / 540.00 * iHeight540min );
  varShape.Width := 24;
  varShape.Brush.Color := RGB_BrushProdutivo;
  varShape.Pen.Color := RGB_PenProdutivo;
  varShape.Shape := stRoundRect;
  varShape.Parent := Fr_PainelOperador4x1[Tag];

  varLabel := TLabel.Create(Fr_PainelOperador4x1[Tag]);
  varLabel.Tag := 99;
  varLabel.Left := varShape.Left;
  varLabel.Top := varShape.Top;
  varLabel.Width := varShape.Width;
  varLabel.Height := varShape.Height;
  varLabel.Alignment := taCenter;
  varLabel.AutoSize := False;
  varLabel.WordWrap := True;
  varLabel.Font.Size := 6;
  varLabel.Caption := FormatFloat( '#,##0.0', varMinutosOperacaoProdutivo[0] / 540.00 * 100.00 ) + '%';
  varLabel.Layout := tlCenter;
  varLabel.Parent := Fr_PainelOperador4x1[Tag];

  varHeightTotal := varHeightTotal + varShape.Height + 1;

  varShape := TShape.Create(Fr_PainelOperador4x1[Tag]);
  varShape.Tag := 99;
  varShape.Left := 451;
  varShape.Top := 49 + varHeightTotal;
  varShape.Height := Trunc( varMinutosOperacaoSetup[0] / 540.00 * iHeight540min );
  varShape.Width := 24;
  varShape.Brush.Color := RGB_BrushSetup;
  varShape.Pen.Color := RGB_PenSetup;
  varShape.Shape := stRoundRect;
  varShape.Parent := Fr_PainelOperador4x1[Tag];

  varLabel := TLabel.Create(Fr_PainelOperador4x1[Tag]);
  varLabel.Tag := 99;
  varLabel.Left := varShape.Left;
  varLabel.Top := varShape.Top;
  varLabel.Width := varShape.Width;
  varLabel.Height := varShape.Height;
  varLabel.Alignment := taCenter;
  varLabel.AutoSize := False;
  varLabel.WordWrap := True;
  varLabel.Font.Size := 6;
  varLabel.Caption := FormatFloat( '#,##0.0', varMinutosOperacaoSetup[0] / 540.00 * 100.00 ) + '%';
  varLabel.Layout := tlCenter;
  varLabel.Parent := Fr_PainelOperador4x1[Tag];

  varHeightTotal := varHeightTotal + varShape.Height + 1;

  varShape := TShape.Create(Fr_PainelOperador4x1[Tag]);
  varShape.Tag := 99;
  varShape.Left := 451;
  varShape.Top := 49 + varHeightTotal;
  varShape.Height := Trunc( varMinutosOperacaoSemTurno[0] / 540.00 * iHeight540min );
  varShape.Width := 24;
  varShape.Brush.Color := clGrayText;
  varShape.Pen.Color := clBlack;
  varShape.Shape := stRoundRect;
  varShape.Parent := Fr_PainelOperador4x1[Tag];

  varLabel := TLabel.Create(Fr_PainelOperador4x1[Tag]);
  varLabel.Tag := 99;
  varLabel.Left := varShape.Left;
  varLabel.Top := varShape.Top;
  varLabel.Width := varShape.Width;
  varLabel.Height := varShape.Height;
  varLabel.Alignment := taCenter;
  varLabel.AutoSize := False;
  varLabel.WordWrap := True;
  varLabel.Font.Size := 6;
  varLabel.Caption := FormatFloat( '#,##0.0', varMinutosOperacaoSemTurno[0] / 540.00 * 100.00 ) + '%';
  varLabel.Layout := tlCenter;
  varLabel.Parent := Fr_PainelOperador4x1[Tag];

  varHeightTotal := varHeightTotal + varShape.Height + 1;

  varShape := TShape.Create(Fr_PainelOperador4x1[Tag]);
  varShape.Tag := 99;
  varShape.Left := 451;
  varShape.Top := 49 + varHeightTotal;
  varShape.Height := Trunc( varMinutosOperacaoNaoProdutivo[0] / 540.00 * iHeight540min );
  varShape.Width := 24;
  varShape.Brush.Color := RGB_BrushNaoProdutivo;
  varShape.Pen.Color := RGB_PenNaoProdutivo;
  varShape.Shape := stRoundRect;
  varShape.Parent := Fr_PainelOperador4x1[Tag];

  varLabel := TLabel.Create(Fr_PainelOperador4x1[Tag]);
  varLabel.Tag := 99;
  varLabel.Left := varShape.Left;
  varLabel.Top := varShape.Top;
  varLabel.Width := varShape.Width;
  varLabel.Height := varShape.Height;
  varLabel.Alignment := taCenter;
  varLabel.AutoSize := False;
  varLabel.WordWrap := True;
  varLabel.Font.Size := 6;
  varLabel.Caption := FormatFloat( '#,##0.0', varMinutosOperacaoNaoProdutivo[0] / 540.00 * 100.00 ) + '%';
  varLabel.Layout := tlCenter;
  varLabel.Parent := Fr_PainelOperador4x1[Tag];

  varHeightTotal := 0;

  varShape := TShape.Create(Fr_PainelOperador4x1[Tag]);
  varShape.Tag := 99;
  varShape.Left := 480;
  varShape.Top := 49 + varHeightTotal;
  varShape.Height := Trunc( varMinutosOperacaoProdutivo[1] / 540.00 * iHeight540min );
  varShape.Width := 24;
  varShape.Brush.Color := RGB_BrushProdutivo;
  varShape.Pen.Color := RGB_PenProdutivo;
  varShape.Shape := stRoundRect;
  varShape.Parent := Fr_PainelOperador4x1[Tag];

  varLabel := TLabel.Create(Fr_PainelOperador4x1[Tag]);
  varLabel.Tag := 99;
  varLabel.Left := varShape.Left;
  varLabel.Top := varShape.Top;
  varLabel.Width := varShape.Width;
  varLabel.Height := varShape.Height;
  varLabel.Alignment := taCenter;
  varLabel.AutoSize := False;
  varLabel.WordWrap := True;
  varLabel.Font.Size := 6;
  varLabel.Caption := FormatFloat( '#,##0.0', varMinutosOperacaoProdutivo[1] / 540.00 * 100.00 ) + '%';
  varLabel.Layout := tlCenter;
  varLabel.Parent := Fr_PainelOperador4x1[Tag];

  varHeightTotal := varHeightTotal + varShape.Height + 1;

  varShape := TShape.Create(Fr_PainelOperador4x1[Tag]);
  varShape.Tag := 99;
  varShape.Left := 480;
  varShape.Top := 49 + varHeightTotal;
  varShape.Height := Round( varMinutosOperacaoSetup[1] / 540.00 * iHeight540min );
  varShape.Width := 24;
  varShape.Brush.Color := RGB_BrushSetup;
  varShape.Pen.Color := RGB_PenSetup;
  varShape.Shape := stRoundRect;
  varShape.Parent := Fr_PainelOperador4x1[Tag];

  varLabel := TLabel.Create(Fr_PainelOperador4x1[Tag]);
  varLabel.Tag := 99;
  varLabel.Left := varShape.Left;
  varLabel.Top := varShape.Top;
  varLabel.Width := varShape.Width;
  varLabel.Height := varShape.Height;
  varLabel.Alignment := taCenter;
  varLabel.AutoSize := False;
  varLabel.WordWrap := True;
  varLabel.Font.Size := 6;
  varLabel.Caption := FormatFloat( '#,##0.0', varMinutosOperacaoSetup[1] / 540.00 * 100.00 ) + '%';
  varLabel.Layout := tlCenter;
  varLabel.Parent := Fr_PainelOperador4x1[Tag];

  varHeightTotal := varHeightTotal + varShape.Height + 1;

  varShape := TShape.Create(Fr_PainelOperador4x1[Tag]);
  varShape.Tag := 99;
  varShape.Left := 480;
  varShape.Top := 49 + varHeightTotal;
  varShape.Height := Round( varMinutosOperacaoSemTurno[1] / 540.00 * iHeight540min );
  varShape.Width := 24;
  varShape.Brush.Color := clGrayText;
  varShape.Pen.Color := clBlack;
  varShape.Shape := stRoundRect;
  varShape.Parent := Fr_PainelOperador4x1[Tag];

  varLabel := TLabel.Create(Fr_PainelOperador4x1[Tag]);
  varLabel.Tag := 99;
  varLabel.Left := varShape.Left;
  varLabel.Top := varShape.Top;
  varLabel.Width := varShape.Width;
  varLabel.Height := varShape.Height;
  varLabel.Alignment := taCenter;
  varLabel.AutoSize := False;
  varLabel.WordWrap := True;
  varLabel.Font.Size := 6;
  varLabel.Caption := FormatFloat( '#,##0.0', varMinutosOperacaoSemTurno[1] / 540.00 * 100.00 ) + '%';
  varLabel.Layout := tlCenter;
  varLabel.Parent := Fr_PainelOperador4x1[Tag];

  varHeightTotal := varHeightTotal + varShape.Height + 1;

  varShape := TShape.Create(Fr_PainelOperador4x1[Tag]);
  varShape.Tag := 99;
  varShape.Left := 480;
  varShape.Top := 49 + varHeightTotal;
  varShape.Height := Round( varMinutosOperacaoNaoProdutivo[1] / 540.00 * iHeight540min );
  varShape.Width := 24;
  varShape.Brush.Color := RGB_BrushNaoProdutivo;
  varShape.Pen.Color := RGB_PenNaoProdutivo;
  varShape.Shape := stRoundRect;
  varShape.Parent := Fr_PainelOperador4x1[Tag];

  varLabel := TLabel.Create(Fr_PainelOperador4x1[Tag]);
  varLabel.Tag := 99;
  varLabel.Left := varShape.Left;
  varLabel.Top := varShape.Top;
  varLabel.Width := varShape.Width;
  varLabel.Height := varShape.Height;
  varLabel.Alignment := taCenter;
  varLabel.AutoSize := False;
  varLabel.WordWrap := True;
  varLabel.Font.Size := 6;
  varLabel.Caption := FormatFloat( '#,##0.0', varMinutosOperacaoNaoProdutivo[1] / 540.00 * 100.00 ) + '%';
  varLabel.Layout := tlCenter;
  varLabel.Parent := Fr_PainelOperador4x1[Tag];

end;

procedure TFr_PainelOperador.setAtividade(const Value: string);
begin

  FAtividade := Value;

  if (Duplicar > 0) and not (FAtividade.Contains('310003') or FAtividade.Contains('310018') or FAtividade.Contains('310021') or FAtividade.Contains('310005')) then
  begin

    FAtividade := EmptyStr;
    ExibirMensagemErro( 'Atividade n�o permitida.' );

  end;

  CriarAtividade;

end;

procedure TFr_PainelOperador.setCelula(const Value: String);
begin

  if OnOperacao then
  begin

    ExibirMensagemErro( 'A��o n�o permitida.' );

  end
  else
  begin

    FCelula := Value;
    LabeledEditCelula.Text := Value;

    if Assigned(Fr_PainelOperador4x1[Tag]) then
      Fr_PainelOperador4x1[Tag].LabeledEditCelula.Text := Value;

  end;

end;

procedure TFr_PainelOperador.setDataBase(const Value: TDateTime);
begin

  FDataBase := Value;
  LabeledEditData.Text := FormatDateTime( 'dd/mm/yyyy', Value );

  if Assigned(Fr_PainelOperador4x1[Tag]) then
    Fr_PainelOperador4x1[Tag].LabeledEditData.Text := FormatDateTime( 'dd/mm/yyyy', Value );

end;

procedure TFr_PainelOperador.setDuplicar(const Value: Integer);
begin

  if Value > 24 then
    FDuplicar := 24
  else
    FDuplicar := Value;

  CriarAtividade;

end;

procedure TFr_PainelOperador.setEncerrarOS(const Value: Integer);
begin

  FEncerrarOS := Value;
  CriarAtividade;

end;

procedure TFr_PainelOperador.setHoraHora(const Value: THoraHora);
begin

  LabelHora1.Caption := Value[1].Texto;
  LabelHora2.Caption := Value[2].Texto;
  LabelHora3.Caption := Value[3].Texto;
  LabelHora4.Caption := Value[4].Texto;
  LabelHora5.Caption := Value[5].Texto;
  LabelHora6.Caption := Value[6].Texto;
  LabelHora7.Caption := Value[7].Texto;
  LabelHora8.Caption := Value[8].Texto;
  LabelHora9.Caption := Value[9].Texto;

  FHoraHora := Value;

  if Assigned(Fr_PainelOperador4x1[Tag]) then
  begin

    Fr_PainelOperador4x1[Tag].LabelHora1.Caption := Value[1].Texto;
    Fr_PainelOperador4x1[Tag].LabelHora2.Caption := Value[2].Texto;
    Fr_PainelOperador4x1[Tag].LabelHora3.Caption := Value[3].Texto;
    Fr_PainelOperador4x1[Tag].LabelHora4.Caption := Value[4].Texto;
    Fr_PainelOperador4x1[Tag].LabelHora5.Caption := Value[5].Texto;
    Fr_PainelOperador4x1[Tag].LabelHora6.Caption := Value[6].Texto;
    Fr_PainelOperador4x1[Tag].LabelHora7.Caption := Value[7].Texto;
    Fr_PainelOperador4x1[Tag].LabelHora8.Caption := Value[8].Texto;
    Fr_PainelOperador4x1[Tag].LabelHora9.Caption := Value[9].Texto;

  end;

  screen_updateOperacoes;
  
end;

procedure TFr_PainelOperador.setLastHoraHora(const Value: THoraHora);
begin

  FLastHoraHora := Value;

end;

procedure TFr_PainelOperador.setMaquina(const Value: String);
begin

  if OnOperacao then
  begin

    ExibirMensagemErro( 'A��o n�o permitida.' );

  end
  else
  if Maquina = EmptyStr then
  begin

    if db_getMaquinaNome( Value ).IsEmpty then
    begin

      ExibirMensagemErro( 'M�quina n�o foi encontrada.' );

    end
    else
    begin

      Celula := db_getCelulaNome( Value );

      FMaquina := Value;
      LabeledEditMaquina.Text := db_getMaquinaNome(Value);

      if Assigned(Fr_PainelOperador4x1[Tag]) then
        Fr_PainelOperador4x1[Tag].LabeledEditMaquina.Text := db_getMaquinaNome(Value);

    end;

  end
  else
  begin

    ExibirMensagemErro( 'M�quina j� foi informada. N�o � poss�vel alterar.' );

  end;

end;

procedure TFr_PainelOperador.setQuantidade(const Value: Extended);
begin

  FQuantidade := Value;
  CriarAtividade;

end;

procedure TFr_PainelOperador.setMetrosFolhasPD7(const Value: Extended);
begin

  FMetrosFolhasPD7 := Value;
  CriarAtividade;

end;

procedure TFr_PainelOperador.setObservacao(const Value: String);
begin

  FObservacao := Value;

end;

procedure TFr_PainelOperador.setOperador(const Value: String);
var
  I: Integer;
  varStr: string;
  varStrNome: string;

begin

  if Maquina = EmptyStr then
  begin

    LabeledEditOperador.Text := EmptyStr;

    if Assigned(Fr_PainelOperador4x1[Tag]) then
      Fr_PainelOperador4x1[Tag].LabeledEditOperador.Text := EmptyStr;

    ExibirMensagemErro( 'M�quina ainda n�o foi informada.' );

  end
  else
  begin

    if FOperador.Contains(Value) then
    begin

      if OnOperacao and (Length(FOperador.Split([';'])) <= 1) then
      begin

        ExibirMensagemErro( 'A��o n�o permitida.' );
      
      end
      else
      begin

        varStr := EmptyStr;
        varStrNome := EmptyStr;
        for I := Low(FOperador.Split([';'])) to High(FOperador.Split([';'])) do
        begin

          if not Value.Equals(FOperador.Split([';'])[I]) then
          begin

            if varStr.Length > 0 then
            begin

              varStr := varStr + ';';
              varStrNome := varStrNome + ';';

            end;

            varStr := varStr + FOperador.Split([';'])[I];
            varStrNome := varStrNome + db_getOperadorNome(FOperador.Split([';'])[I]);
            
          end;

        end;

        FOperador := varStr;
        LabeledEditOperador.Text := varStrNome;

        if Assigned(Fr_PainelOperador4x1[Tag]) then
          Fr_PainelOperador4x1[Tag].LabeledEditOperador.Text := varStrNome;

      end;

    end
    else
    begin

      varStr := FOperador;

      if FOperador.IsEmpty then
        varStrNome := EmptyStr
      else
        varStrNome := LabeledEditOperador.Text;

      if varStr.Length > 0 then
      begin

        varStr := varStr + ';';
        if not varStrNome.Contains(db_getOperadorNome(Value)) then
          varStrNome := varStrNome + ';';

      end;

      varStr := varStr + Value;

      if not varStrNome.Contains(db_getOperadorNome(Value)) then
        varStrNome := varStrNome + db_getOperadorNome(Value);

      FOperador := varStr;
      LabeledEditOperador.Text := varStrNome;

      if Assigned(Fr_PainelOperador4x1[Tag]) then
        Fr_PainelOperador4x1[Tag].LabeledEditOperador.Text := varStrNome;

    end;

    if not OnOperacao then
    begin

      CharRead := '300005';
      OnReadChar;

    end;

  end;

end;

procedure TFr_PainelOperador.setOS(const Value: string);
begin

  FOS := Value;
  CriarAtividade;

end;

procedure TFr_PainelOperador.setScreen_Resolution;
var
  cnt: Integer;
  DevMode: TDevMode;

begin

  cnt := 0;
  while EnumDisplaySettings(nil,cnt,DevMode) do
  begin

    with Devmode do
    begin

      if (dmPelsWidth = 1024) and (dmPelsHeight = 768) then
      begin

        ChangeDisplaySettings(DevMode, CDS_UPDATEREGISTRY);
        SendMessage(HWND_BROADCAST, WM_DISPLAYCHANGE, SPI_SETNONCLIENTMETRICS, 0);

      end;

      Inc(cnt);

    end;

  end;

end;

procedure TFr_PainelOperador.setTempo(const Value: Integer);
begin

  FTempo := Value;
  CriarAtividade;

end;

procedure TFr_PainelOperador.setYNumber(const Value: string);
begin

  FYNumber := Value;
  CriarAtividade;

end;

procedure TFr_PainelOperador.ShowChildForms;
var
  I: Integer;

begin

  for I := 1 to 4 do
  begin

    if Assigned(Fr_PainelOperador4x1[I]) then
    begin

      Fr_PainelOperador4x1[I].Visible := True;
      Fr_PainelOperador4x1[I].BringToFront;
      Fr_PainelOperador4x1[I].Update;
      Visible := False;

    end;

  end;

end;

procedure TFr_PainelOperador.TimerAlarmeTimer(Sender: TObject);
begin

  if Color = RGB_AlarmeWhite then
  begin

    Color := RGB_AlarmeRed;
    ShapeHeader.Brush.Color := RGB_AlarmeRed;
    ShapeHora.Brush.Color := RGB_AlarmeRed;
    ShapeTurno1.Brush.Color := RGB_AlarmeRed;
    ShapeTurno2.Brush.Color := RGB_AlarmeRed;
    ShapeHora1.Brush.Color := RGB_AlarmeRed;
    ShapeHora2.Brush.Color := RGB_AlarmeRed;
    ShapeHora3.Brush.Color := RGB_AlarmeRed;
    ShapeHora4.Brush.Color := RGB_AlarmeRed;
    ShapeHora5.Brush.Color := RGB_AlarmeRed;
    ShapeHora6.Brush.Color := RGB_AlarmeRed;
    ShapeHora7.Brush.Color := RGB_AlarmeRed;
    ShapeHora8.Brush.Color := RGB_AlarmeRed;
    ShapeHora9.Brush.Color := RGB_AlarmeRed;
    ShapeHora01.Brush.Color := RGB_AlarmeRed;
    ShapeHora02.Brush.Color := RGB_AlarmeRed;
    ShapeHora03.Brush.Color := RGB_AlarmeRed;
    ShapeHora04.Brush.Color := RGB_AlarmeRed;
    ShapeHora05.Brush.Color := RGB_AlarmeRed;
    ShapeHora06.Brush.Color := RGB_AlarmeRed;
    ShapeHora07.Brush.Color := RGB_AlarmeRed;
    ShapeHora08.Brush.Color := RGB_AlarmeRed;
    ShapeHora09.Brush.Color := RGB_AlarmeRed;
    LabeledEditData.Color := RGB_AlarmeRed;
    LabeledEditCelula.Color := RGB_AlarmeRed;
    LabeledEditMaquina.Color := RGB_AlarmeRed;
    LabeledEditOperador.Color := RGB_AlarmeRed;
    TimerAlarme.Interval := 3000;

  end
  else
  begin

    Color := RGB_AlarmeWhite;
    ShapeHeader.Brush.Color := RGB_AlarmeWhite;
    ShapeHora.Brush.Color := RGB_AlarmeWhite;
    ShapeTurno1.Brush.Color := RGB_AlarmeWhite;
    ShapeTurno2.Brush.Color := RGB_AlarmeWhite;
    ShapeHora1.Brush.Color := RGB_AlarmeWhite;
    ShapeHora2.Brush.Color := RGB_AlarmeWhite;
    ShapeHora3.Brush.Color := RGB_AlarmeWhite;
    ShapeHora4.Brush.Color := RGB_AlarmeWhite;
    ShapeHora5.Brush.Color := RGB_AlarmeWhite;
    ShapeHora6.Brush.Color := RGB_AlarmeWhite;
    ShapeHora7.Brush.Color := RGB_AlarmeWhite;
    ShapeHora8.Brush.Color := RGB_AlarmeWhite;
    ShapeHora9.Brush.Color := RGB_AlarmeWhite;
    ShapeHora01.Brush.Color := RGB_AlarmeWhite;
    ShapeHora02.Brush.Color := RGB_AlarmeWhite;
    ShapeHora03.Brush.Color := RGB_AlarmeWhite;
    ShapeHora04.Brush.Color := RGB_AlarmeWhite;
    ShapeHora05.Brush.Color := RGB_AlarmeWhite;
    ShapeHora06.Brush.Color := RGB_AlarmeWhite;
    ShapeHora07.Brush.Color := RGB_AlarmeWhite;
    ShapeHora08.Brush.Color := RGB_AlarmeWhite;
    ShapeHora09.Brush.Color := RGB_AlarmeWhite;
    LabeledEditData.Color := RGB_AlarmeWhite;
    LabeledEditCelula.Color := RGB_AlarmeWhite;
    LabeledEditMaquina.Color := RGB_AlarmeWhite;
    LabeledEditOperador.Color := RGB_AlarmeWhite;
    TimerAlarme.Interval := 1000;

  end;

  RefreshShowChildForms;

end;

procedure TFr_PainelOperador.TimerChildAlarmeTimer(Sender: TObject);
begin

  if not Assigned(Fr_PainelOperador4x1[Tag]) then
    Exit;

  if Fr_PainelOperador4x1[Tag].Color = RGB_AlarmeWhite then
  begin

    Fr_PainelOperador4x1[Tag].Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHeader.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeTurno1.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeTurno2.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora1.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora2.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora3.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora4.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora5.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora6.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora7.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora8.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora9.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora01.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora02.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora03.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora04.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora05.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora06.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora07.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora08.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].ShapeHora09.Brush.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].LabeledEditData.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].LabeledEditCelula.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].LabeledEditMaquina.Color := RGB_AlarmeRed;
    Fr_PainelOperador4x1[Tag].LabeledEditOperador.Color := RGB_AlarmeRed;
    TimerChildAlarme.Interval := 3000;

  end
  else
  begin

    Fr_PainelOperador4x1[Tag].Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHeader.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeTurno1.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeTurno2.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora1.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora2.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora3.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora4.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora5.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora6.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora7.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora8.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora9.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora01.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora02.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora03.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora04.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora05.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora06.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora07.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora08.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].ShapeHora09.Brush.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].LabeledEditData.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].LabeledEditCelula.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].LabeledEditMaquina.Color := RGB_AlarmeWhite;
    Fr_PainelOperador4x1[Tag].LabeledEditOperador.Color := RGB_AlarmeWhite;
    TimerChildAlarme.Interval := 1000;

  end;

  RefreshShowChildForms;

end;

procedure TFr_PainelOperador.TimerShowChildTimer(Sender: TObject);
begin

  if not OnOperacao and not OnMensagem and not OnMensagemErro then
  begin

    ShowChildForms;

  end;

end;

procedure TFr_PainelOperador.TimerMensagemTimer(Sender: TObject);
begin

  if LabelMensagemErroTime.Caption = '1' then
  begin

    PanelMensagemErro.Visible := False;
    TimerMensagem.Enabled := False;

  end
  else
  begin

    LabelMensagemErroTime.Caption := IntToStr(StrToInt(LabelMensagemErroTime.Caption)-1);

  end;

end;

procedure TFr_PainelOperador.TimerSyncSQLTimer(Sender: TObject);
begin

  Timer.Enabled := False;
  TimerSyncSQL.Enabled := False;
  try

    db_SyncSQLDatabase;
    Timer.OnTimer(Timer);
    RefreshShowChildForms;

  finally

    TimerSyncSQL.Enabled := True;
    Timer.Enabled := True;

  end;

end;

procedure TFr_PainelOperador.TimerTimer(Sender: TObject);
begin

  Timer.Enabled := False;
  try

    Timer.Interval := 60000;

    db_loadMaquinas;
    db_loadOperadores;
    db_loadOperacoes;

    screen_deleteOperacoes;
    DataBase := Now;
    LastHoraHora := cfg_getLastHoraHora;
    HoraHora := cfg_getHoraHora;
    screen_updateAlarme;
    RefreshShowChildForms;
    CriarAtividadeSemTurnoAuto;

  finally

    Timer.Enabled := True;

  end;

end;

function TFr_PainelOperador.WaitingAtividade: Boolean;
begin

  Result := OnOperacao and OnMensagem and (Pos('Informe a Atividade.', LabelMensagem.Caption) > 0);

end;

function TFr_PainelOperador.WaitingDuplicar: Boolean;
begin

  Result := OnOperacao and OnMensagem and (Pos('Informe n�mero de horas para duplicar.', LabelMensagem.Caption) > 0);

end;

function TFr_PainelOperador.WaitingEncerrarOS: Boolean;
begin

  Result := OnOperacao and OnMensagem and (Pos('Encerrar OP?', LabelMensagem.Caption) > 0);

end;

function TFr_PainelOperador.WaitingQuantidade: Boolean;
begin

  Result := OnOperacao and OnMensagem and (Pos('Informe a Quantidade.', LabelMensagem.Caption) > 0);

end;

function TFr_PainelOperador.WaitingMetrosFolhasPD7: Boolean;
begin

  Result := OnOperacao and OnMensagem and (Pos('Informe o n�mero de Metros / Folhas.', LabelMensagem.Caption) > 0);

end;

function TFr_PainelOperador.WaitingOS: Boolean;
begin

  Result := OnOperacao and OnMensagem and (Pos('Informe a OP.', LabelMensagem.Caption) > 0);

end;

function TFr_PainelOperador.WaitingTempo: Boolean;
begin

  Result := OnOperacao and OnMensagem and (Pos('Informe o Tempo.', LabelMensagem.Caption) > 0);

end;

function TFr_PainelOperador.WaitingYNumber: Boolean;
begin

  Result := OnOperacao and OnMensagem and (Pos('Informe o Y#.', LabelMensagem.Caption) > 0);

end;


end.
