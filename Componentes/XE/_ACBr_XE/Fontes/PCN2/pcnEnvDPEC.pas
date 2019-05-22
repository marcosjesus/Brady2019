////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar NFe                                    //
//                                                                            //
//   Descri��o: Classes para gera��o/leitura dos arquivos xml da NFe          //
//                                                                            //
//        site: www.projetocooperar.org                                       //
//       email: projetocooperar@zipmail.com.br                                //
//       forum: http://br.groups.yahoo.com/group/projeto_cooperar_nfe/        //
//     projeto: http://code.google.com/p/projetocooperar/                     //
//         svn: http://projetocooperar.googlecode.com/svn/trunk/              //
//                                                                            //
// Coordena��o: (c) 2009 - Paulo Casagrande                                   //
//                                                                            //
//      Equipe: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//      Vers�o: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//     Licen�a: GNU Lesser General Public License (GNU LGPL)                  //
//                                                                            //
//              - Este programa � software livre; voc� pode redistribu�-lo    //
//              e/ou modific�-lo sob os termos da Licen�a P�blica Geral GNU,  //
//              conforme publicada pela Free Software Foundation; tanto a     //
//              vers�o 2 da Licen�a como (a seu crit�rio) qualquer vers�o     //
//              mais nova.                                                    //
//                                                                            //
//              - Este programa � distribu�do na expectativa de ser �til,     //
//              mas SEM QUALQUER GARANTIA; sem mesmo a garantia impl�cita de  //
//              COMERCIALIZA��O ou de ADEQUA��O A QUALQUER PROP�SITO EM       //
//              PARTICULAR. Consulte a Licen�a P�blica Geral GNU para obter   //
//              mais detalhes. Voc� deve ter recebido uma c�pia da Licen�a    //
//              P�blica Geral GNU junto com este programa; se n�o, escreva    //
//              para a Free Software Foundation, Inc., 59 Temple Place,       //
//              Suite 330, Boston, MA - 02111-1307, USA ou consulte a         //
//              licen�a oficial em http://www.gnu.org/licenses/gpl.txt        //
//                                                                            //
//    Nota (1): - Esta  licen�a  n�o  concede  o  direito  de  uso  do nome   //
//              "PCN  -  Projeto  Cooperar  NFe", n�o  podendo o mesmo ser    //
//              utilizado sem previa autoriza��o.                             //
//                                                                            //
//    Nota (2): - O uso integral (ou parcial) das units do projeto esta       //
//              condicionado a manuten��o deste cabe�alho junto ao c�digo     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

{$I ACBr.inc}

unit pcnEnvDPEC;

interface

uses
  SysUtils, Classes,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  pcnAuxiliar, pcnConversao, pcnGerador, pcnSignature, ACBrUtil;

type

  TEnvDPEC              = class;
  TinfDPEC              = class;
  TideDec               = class;
  TresNFeCollection     = class;
  TresNFeCollectionItem = class;
  TGeradorOpcoes        = class;

  TEnvDPEC = class(TPersistent)
  private
    FGerador: TGerador;
    FOpcoes: TGeradorOpcoes;
    FinfDPEC: TinfDPEC;
    FSignature: TSignature;
    FVersao: String;
  public
    constructor Create;
    destructor Destroy; override;
    function GerarXML: Boolean;
  published
    property Gerador: TGerador      read FGerador   write FGerador;
    property Opcoes: TGeradorOpcoes read FOpcoes    write FOpcoes;
    property infDPEC: TinfDPEC      read FinfDPEC   write FinfDPEC;
    property signature: Tsignature  read Fsignature write Fsignature;
    property Versao: String         read FVersao    write FVersao;
  end;

  TGeradorOpcoes = class(TPersistent)
  private
    FValidarInscricao: Boolean;
    FGerarTagAssinatura: TpcnTagAssinatura;
  published
    property ValidarInscricao: Boolean             read FValidarInscricao   write FValidarInscricao;
    property GerarTagAssinatura: TpcnTagAssinatura read FGerarTagAssinatura write FGerarTagAssinatura;
  end;

  TinfDPEC = class(TPersistent)
  private
    FID: String;
    FIdeDec: TideDec;
    FresNFe: TresNFeCollection;

    procedure SetresNFe(Value: TresNFeCollection);
  public
    constructor Create(AOwner: TEnvDPEC);
    destructor Destroy; override;
  published
    property ID: String                read FID     write FID;
    property IdeDec: TIdeDec           read FIdeDec write FIdeDec;
    property resNFe: TresNFeCollection read FresNFe write SetresNFe;
  end;

  TideDec = class(TPersistent)
  private
    FcUF: Integer;
    FtpAmb: TpcnTipoAmbiente;
    FverProc: String;
    FCNPJ: String;
    FIE: String;
  published
    property cUF: Integer            read FcUF     write FcUF;
    property tpAmb: TpcnTipoAmbiente read FtpAmb   write FtpAmb default taHomologacao;
    property verProc: String         read FverProc write FverProc;
    property CNPJ: String            read FCNPJ    write FCNPJ;
    property IE: String              read FIE      write FIE;
  end;

  TresNFeCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TresNFeCollectionItem;
    procedure SetItem(Index: Integer; Value: TresNFeCollectionItem);
  public
    constructor Create(AOwner: TinfDPEC); reintroduce;
    function Add: TresNFeCollectionItem;
    property Items[Index: Integer]: TresNFeCollectionItem read GetItem write SetItem; default;
  end;

  TresNFeCollectionItem = class(TCollectionItem)
  private
    FchNFe: String;
    FCNPJCPF: String;
    FUF: String;
    FvNF: Currency;
    FvICMS: Currency;
    FvST: Currency;
  published
    property chNFe: String   read FchNFe   write FchNFe;
    property CNPJCPF: String read FCNPJCPF write FCNPJCPF;
    property UF: String      read FUF      write FUF;
    property vNF: Currency   read FvNF     write FvNF;
    property vICMS: Currency read FvICMS   write FvICMS;
    property vST: Currency   read FvST     write FvST;
  end;

implementation

{ TEnvDPEC }

constructor TEnvDPEC.Create;
begin
  FGerador := TGerador.Create;
  FinfDPEC := TinfDPEC.Create(self);
  FOpcoes  := TGeradorOpcoes.Create;
  FOpcoes.FGerarTagAssinatura := taNunca;
  FOpcoes.FValidarInscricao   := False;
  Fsignature := Tsignature.create;
end;

destructor TEnvDPEC.Destroy;
begin
  FGerador.Free;
  FinfDPEC.Free;
  Fsignature.Free;
  FOpcoes.Free;
  inherited Destroy;
end;

{ TInfDPEC }

constructor TInfDPEC.Create(AOwner: TEnvDPEC);
begin
  inherited Create;
  FIdeDec := TideDec.Create;
  FresNFe := TresNFeCollection.Create(Self);
end;

destructor TInfDPEC.Destroy;
begin
  FIdeDec.Free;
  FresNFe.Free;
  inherited Destroy;
end;

procedure TInfDPEC.SetresNFe(Value: TresNFeCollection);
begin
  FresNFe.Assign(Value);
end;

{resNFeCollection}

constructor TresNFeCollection.Create(AOwner: TinfDPEC);
begin
  inherited Create(TresNFeCollectionItem);
end;

function TresNFeCollection.Add: TresNFeCollectionItem;
begin
  Result := TresNFeCollectionItem(inherited Add);
end;

function TresNFeCollection.GetItem(Index: Integer): TresNFeCollectionItem;
begin
  Result := TresNFeCollectionItem(inherited GetItem(Index));
end;

procedure TresNFeCollection.SetItem(Index: Integer; Value: TresNFeCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

function TEnvDPEC.GerarXML: Boolean;
var
  i: Integer;
  Gerar: Boolean;
begin
  Result := False;

  Self.infDPEC.IdeDec.CNPJ := OnlyNumber(Self.infDPEC.IdeDec.CNPJ);
  Self.infDPEC.IdeDec.IE := OnlyNumber(Self.infDPEC.IdeDec.IE);
    //
  Gerador.ArquivoFormatoXML := '';
  
  Gerador.wGrupo(ENCODING_UTF8, '', False);
  Gerador.wGrupo('envDPEC versao="'+  Versao + '" ' + NAME_SPACE );
  Gerador.wGrupo('infDPEC Id="DPEC' + OnlyNumber( Self.infDPEC.Id) + '"');
  Gerador.wGrupo('ideDec');
  Gerador.wCampo(tcInt, 'AP06', 'cUF    ', 02, 02, 1, Self.infDPEC.IdeDec.cUF, DSC_CUF);
  if not ValidarCodigoUF(Self.infDPEC.IdeDec.cUF) then
    Gerador.wAlerta('AP06', 'cUF', DSC_CUF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, 'AP07', 'tpAmb  ', 01, 01, 1, tpAmbToStr(Self.infDPEC.IdeDec.FtpAmb), DSC_TPAMB);
  Gerador.wCampo(tcStr, 'AP08', 'verProc', 01, 20, 1, Self.infDPEC.IdeDec.verProc, DSC_VERPROC);
  Gerador.wCampo(tcStr, 'AP09', 'CNPJ   ', 14, 14, 1, Self.infDPEC.IdeDec.CNPJ, DSC_CNPJ);
  if not ValidarCNPJ(Self.infDPEC.IdeDec.CNPJ) then
    Gerador.wAlerta('AP09', 'CNPJ', DSC_CNPJ, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, 'AP10', 'IE     ', 02, 14, 1, Self.infDPEC.IdeDec.IE, DSC_IE);
  if (FOpcoes.ValidarInscricao) and (Self.infDPEC.IdeDec.IE <> '') then
    if not ValidarIE(Self.infDPEC.IdeDec.IE, codigoParaUF(Self.infDPEC.IdeDec.cUF)) then
      Gerador.wAlerta('AP10', 'IE', DSC_IE, ERR_MSG_INVALIDO);
  Gerador.wGrupo('/ideDec');
  for i := 0 to Self.infDPEC.resNFe.Count - 1 do
  begin
    Self.infDPEC.resNFe[i].CNPJCPF := OnlyNumber(Self.infDPEC.resNFe[i].CNPJCPF);
    Gerador.wGrupo('resNFe');
    Gerador.wCampo(tcStr, 'AP12', 'chNFe', 044, 044, 1, OnlyNumber(Self.infDPEC.resNFe[i].chNFe), DSC_CHNFE);
    Gerador.wCampoCNPJCPF('AP13', 'AP14', Self.infDPEC.resNFe[i].CNPJCPF, CODIGO_BRASIL);
    Gerador.wCampo(tcStr, 'AP15', 'UF   ', 02, 02, 1, Self.infDPEC.resNFe[i].UF, DSC_UF);
    Gerador.wCampo(tcDe2, 'AP16', 'vNF  ', 01, 15, 1, Self.infDPEC.resNFe[i].vNF, DSC_VNF);
    Gerador.wCampo(tcDe2, 'AP17', 'vICMS', 01, 15, 1, Self.infDPEC.resNFe[i].vICMS, DSC_VICMS);
    Gerador.wCampo(tcDe2, 'AP18', 'vST  ', 01, 15, 1, Self.infDPEC.resNFe[i].vST, DSC_VST);
    Gerador.wGrupo('/resNFe');
  end;
  Gerador.wGrupo('/infDPEC');
    //
  if FOpcoes.GerarTagAssinatura <> taNunca then
  begin
    Gerar := true;
    if FOpcoes.GerarTagAssinatura = taSomenteSeAssinada then
      Gerar := ((Self.signature.DigestValue <> '') and (Self.signature.SignatureValue <> '') and (Self.signature.X509Certificate <> ''));
    if FOpcoes.GerarTagAssinatura = taSomenteParaNaoAssinada then
      Gerar := ((Self.signature.DigestValue = '') and (Self.signature.SignatureValue = '') and (Self.signature.X509Certificate = ''));
    if Gerar then
    begin
      Self.signature.URI := OnlyNumber(Self.infDPEC.Id);
      Self.signature.Gerador.Opcoes.IdentarXML := Gerador.Opcoes.IdentarXML;
      Self.signature.GerarXML;
      Gerador.ArquivoFormatoXML := Gerador.ArquivoFormatoXML + Self.signature.Gerador.ArquivoFormatoXML;
    end;
  end;
    //
  Gerador.wGrupo('/envDPEC');

  Result := (Gerador.ListaDeAlertas.Count = 0);
end;

end.

