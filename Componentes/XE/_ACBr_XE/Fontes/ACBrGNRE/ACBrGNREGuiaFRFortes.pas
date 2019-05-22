{******************************************************************************
|* Historico
|*
|* 23/07/2014 - Tiago Shimizu
|*  - Doa��o do componente para o Projeto ACBr
******************************************************************************}
{$I ACBr.inc}

unit ACBrGNREGuiaFRFortes;

interface

uses
  Forms, SysUtils, Classes, Graphics, pcnConversao, pgnreGNRERetorno, RLReport,
  RLBarcode, RLPDFFilter, RLHTMLFilter, RLPrintDialog, RLFilters, RLPrinters,
  Controls, DB, MaskUtils, RLConsts,{$IFDEF FPC} BufDataSet, {$ELSE} DBClient, {$ENDIF} ACBrGNREGuiaClass;

type
  EACBrGNREGuiaFRFortes = class(Exception);

  TACBrGNREGuiaRL = class(TACBrGNREGuiaClass)
  private
    { Private declarations }
  public
    procedure ImprimirGuia(GNRE: TGNRERetorno = nil);override;
    procedure ImprimirGuiaPDF(GNRE: TGNRERetorno = nil); override;
  end;

  TACBrGNREGuiaFR_Fortes = class(TForm)
    RLPDFFilter1: TRLPDFFilter;
    RLHTMLFilter1: TRLHTMLFilter;
    LayoutGNRE: TRLReport;
    dsGuia: TDataSource;
    RLBand1: TRLBand;
    RLDraw1: TRLDraw;
    RLLabel1: TRLLabel;
    RLDraw2: TRLDraw;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLDBText1: TRLDBText;
    RLLabel4: TRLLabel;
    RLDBText2: TRLDBText;
    RLLabel5: TRLLabel;
    RLDBText3: TRLDBText;
    RLDraw3: TRLDraw;
    RLDraw4: TRLDraw;
    RLLabel6: TRLLabel;
    RLDBText4: TRLDBText;
    RLLabel7: TRLLabel;
    RLDBText5: TRLDBText;
    RLLabel8: TRLLabel;
    RLDBText6: TRLDBText;
    RLLabel9: TRLLabel;
    RLDBText7: TRLDBText;
    RLLabel10: TRLLabel;
    RLDBText8: TRLDBText;
    RLLabel11: TRLLabel;
    RLDBText9: TRLDBText;
    RLDraw5: TRLDraw;
    RLDraw6: TRLDraw;
    RLDraw7: TRLDraw;
    RLLabel12: TRLLabel;
    RLDBText10: TRLDBText;
    RLLabel13: TRLLabel;
    RLDBText11: TRLDBText;
    RLLabel14: TRLLabel;
    RLDBText12: TRLDBText;
    RLDraw8: TRLDraw;
    RLDraw9: TRLDraw;
    RLDraw10: TRLDraw;
    RLDraw11: TRLDraw;
    RLDraw12: TRLDraw;
    RLDraw13: TRLDraw;
    RLDraw14: TRLDraw;
    RLDraw15: TRLDraw;
    RLDraw16: TRLDraw;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLDBText14: TRLDBText;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLDBText13: TRLDBText;
    RLDBText15: TRLDBText;
    RLLabel22: TRLLabel;
    RLDBMemo1: TRLDBMemo;
    RLLabel23: TRLLabel;
    RLDBText16: TRLDBText;
    RLDBText17: TRLDBText;
    RLDBBarcode1: TRLDBBarcode;
    RLLabel24: TRLLabel;
    RLDBText18: TRLDBText;
    RLLabel25: TRLLabel;
    RLDraw17: TRLDraw;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLLabel34: TRLLabel;
    RLLabel35: TRLLabel;
    RLLabel36: TRLLabel;
    RLLabel37: TRLLabel;
    RLMemo1: TRLMemo;
    RLMemo2: TRLMemo;
    RLDraw18: TRLDraw;
    RLDraw19: TRLDraw;
    RLDraw20: TRLDraw;
    RLDraw21: TRLDraw;
    RLDraw22: TRLDraw;
    RLDraw23: TRLDraw;
    RLDraw24: TRLDraw;
    RLDraw25: TRLDraw;
    RLDraw26: TRLDraw;
    RLDraw27: TRLDraw;
    RLDraw28: TRLDraw;
    RLDraw29: TRLDraw;
    RLDraw30: TRLDraw;
    RLDraw31: TRLDraw;
    RLDraw32: TRLDraw;
    RLDraw33: TRLDraw;
    RLDraw34: TRLDraw;
    RLMemo3: TRLMemo;
    RLLabel38: TRLLabel;
    RLLabel39: TRLLabel;
    RLLabel40: TRLLabel;
    RLDBText19: TRLDBText;
    RLLabel41: TRLLabel;
    RLDBText20: TRLDBText;
    RLLabel42: TRLLabel;
    RLDBText21: TRLDBText;
    RLLabel43: TRLLabel;
    RLDBText22: TRLDBText;
    RLLabel44: TRLLabel;
    RLDBText23: TRLDBText;
    RLLabel45: TRLLabel;
    RLDBText24: TRLDBText;
    RLLabel46: TRLLabel;
    RLDBText25: TRLDBText;
    RLLabel47: TRLLabel;
    RLDBText26: TRLDBText;
    RLLabel48: TRLLabel;
    RLDBText27: TRLDBText;
    RLLabel49: TRLLabel;
    RLDBText28: TRLDBText;
    RLLabel50: TRLLabel;
    RLDBText29: TRLDBText;
    RLLabel51: TRLLabel;
    RLDBText30: TRLDBText;
    RLLabel52: TRLLabel;
    RLLabel53: TRLLabel;
    RLLabel54: TRLLabel;
    RLDBText31: TRLDBText;
    RLLabel55: TRLLabel;
    RLLabel56: TRLLabel;
    RLLabel57: TRLLabel;
    RLLabel58: TRLLabel;
    RLDBText32: TRLDBText;
    RLDBText33: TRLDBText;
    RLLabel59: TRLLabel;
    RLDBMemo2: TRLDBMemo;
    RLLabel60: TRLLabel;
    RLDBText34: TRLDBText;
    RLDBText35: TRLDBText;
    RLDBBarcode2: TRLDBBarcode;
    RLLabel61: TRLLabel;
    RLDBText36: TRLDBText;
    RLLabel62: TRLLabel;
    RLLabel63: TRLLabel;
    RLLabel64: TRLLabel;
    RLLabel65: TRLLabel;
    RLLabel66: TRLLabel;
    RLLabel67: TRLLabel;
    RLLabel68: TRLLabel;
    RLLabel69: TRLLabel;
    RLLabel70: TRLLabel;
    RLLabel71: TRLLabel;
    RLLabel72: TRLLabel;
    RLMemo4: TRLMemo;
    RLLabel73: TRLLabel;
    RLLabel74: TRLLabel;
    RLDraw35: TRLDraw;
    RLDraw36: TRLDraw;
    RLDraw37: TRLDraw;
    RLDraw38: TRLDraw;
    RLDraw39: TRLDraw;
    RLDraw40: TRLDraw;
    RLDraw41: TRLDraw;
    RLDraw42: TRLDraw;
    RLDraw43: TRLDraw;
    RLDraw44: TRLDraw;
    RLDraw45: TRLDraw;
    RLDraw46: TRLDraw;
    RLDraw47: TRLDraw;
    RLDraw48: TRLDraw;
    RLDraw49: TRLDraw;
    RLDraw50: TRLDraw;
    RLDraw51: TRLDraw;
    RLMemo5: TRLMemo;
    RLLabel75: TRLLabel;
    RLLabel76: TRLLabel;
    RLLabel77: TRLLabel;
    RLDBText37: TRLDBText;
    RLLabel78: TRLLabel;
    RLDBText38: TRLDBText;
    RLLabel79: TRLLabel;
    RLDBText39: TRLDBText;
    RLLabel80: TRLLabel;
    RLDBText40: TRLDBText;
    RLLabel81: TRLLabel;
    RLDBText41: TRLDBText;
    RLLabel82: TRLLabel;
    RLDBText42: TRLDBText;
    RLLabel83: TRLLabel;
    RLDBText43: TRLDBText;
    RLLabel84: TRLLabel;
    RLDBText44: TRLDBText;
    RLLabel85: TRLLabel;
    RLDBText45: TRLDBText;
    RLLabel86: TRLLabel;
    RLDBText46: TRLDBText;
    RLLabel87: TRLLabel;
    RLDBText47: TRLDBText;
    RLLabel88: TRLLabel;
    RLDBText48: TRLDBText;
    RLLabel89: TRLLabel;
    RLLabel90: TRLLabel;
    RLLabel91: TRLLabel;
    RLDBText49: TRLDBText;
    RLLabel92: TRLLabel;
    RLLabel93: TRLLabel;
    RLLabel94: TRLLabel;
    RLLabel95: TRLLabel;
    RLDBText50: TRLDBText;
    RLDBText51: TRLDBText;
    RLLabel96: TRLLabel;
    RLDBMemo3: TRLDBMemo;
    RLLabel97: TRLLabel;
    RLDBText52: TRLDBText;
    RLDBText53: TRLDBText;
    RLDBBarcode3: TRLDBBarcode;
    RLLabel98: TRLLabel;
    RLDBText54: TRLDBText;
    RLLabel99: TRLLabel;
    RLLabel100: TRLLabel;
    RLLabel101: TRLLabel;
    RLLabel102: TRLLabel;
    RLLabel103: TRLLabel;
    RLLabel104: TRLLabel;
    RLLabel105: TRLLabel;
    RLLabel106: TRLLabel;
    RLLabel107: TRLLabel;
    RLLabel108: TRLLabel;
    RLLabel109: TRLLabel;
    RLMemo6: TRLMemo;
    RLLabel110: TRLLabel;
    RLLabel111: TRLLabel;
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    FGNRE: TGNRERetorno;
    cdsGuia: {$IFDEF FPC} TBufDataSet {$ELSE} TClientDataSet {$ENDIF};
  published
    procedure CarregaDados;
    property GNRE: TGNRERetorno read FGNRE write FGNRE;
  end;

procedure Register;


implementation

uses ACBrGNRE2, ACBrGNREUtil, ACBrUtil, StrUtils, Dialogs, ACBrGNREGuiasRetorno;

{$IFDEF FPC}
  {$R *.lfm}
{$ELSE}
  {$R *.dfm}
  {$R ACBrGNRE.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrGNREGuiaRL]);
end;

{ TACBrGNREGuiaFRFortes }
procedure TACBrGNREGuiaRL.ImprimirGuia(GNRE: TGNRERetorno);
var
  i: integer;
  frACBrGNREFortes: TACBrGNREGuiaFR_Fortes;
begin
  try
    frACBrGNREFortes := TACBrGNREGuiaFR_Fortes.Create(Self);
    if Assigned(GNRE) then
    begin
      frACBrGNREFortes.GNRE := GNRE;
    end
    else
    begin
      if Assigned(ACBrGNRE) then
      begin
        for i := 0 to TACBrGNRE(ACBrGNRE).GuiasRetorno.Count - 1 do
        begin
          frACBrGNREFortes.GNRE := TACBrGNRE(ACBrGNRE).GuiasRetorno.Items[i]
            .GNRE;
          frACBrGNREFortes.CarregaDados;
        end;
      end
      else
        raise EACBrGNREGuiaFRFortes.Create(
          'Propriedade ACBrGNRE n�o assinalada.');
    end;
    with frACBrGNREFortes do
    begin
      RLPrinter.Copies := NumCopias;
      LayoutGNRE.PrintDialog := MostrarPreview;
      if MostrarPreview then
        LayoutGNRE.PreviewModal
      else
        LayoutGNRE.Print;
    end;
  finally
    FreeAndNil(frACBrGNREFortes);
  end;
end;

procedure TACBrGNREGuiaRL.ImprimirGuiaPDF(GNRE: TGNRERetorno);
var
  i: integer;
  frACBrGNREFortes: TACBrGNREGuiaFR_Fortes;
begin
  try
    frACBrGNREFortes := TACBrGNREGuiaFR_Fortes.Create(Self);
    if Assigned(GNRE) then
    begin
      frACBrGNREFortes.GNRE := GNRE;
    end
    else
    begin
      if Assigned(ACBrGNRE) then
      begin
        for i := 0 to TACBrGNRE(ACBrGNRE).GuiasRetorno.Count - 1 do
        begin
          frACBrGNREFortes.GNRE := TACBrGNRE(ACBrGNRE).GuiasRetorno.Items[i]
            .GNRE;
          frACBrGNREFortes.CarregaDados;
        end;
      end
      else
        raise EACBrGNREGuiaFRFortes.Create(
          'Propriedade ACBrGNRE n�o assinalada.');
    end;
    with frACBrGNREFortes do
    begin
      RLPrinter.Copies := NumCopias;
      LayoutGNRE.SaveToFile
        (PathPDF + 'GNRE_' + GNRE.RepresentacaoNumerica + '.pdf');
    end;
  finally
    FreeAndNil(frACBrGNREFortes);
  end;
end;

procedure TACBrGNREGuiaFR_Fortes.CarregaDados;
  function FormatarData(Str: string): string;
  begin
    Result := Copy(Str, 1, 2) + '/' + Copy(Str, 3, 2) + '/' + Copy(Str, 5, 4);
  end;

  function RemoverZeros(Str: string): string;
  begin
    if Str <> '' then
    begin
      while Str[1] = '0' do
        Str := Copy(Str, 2, Length(Str));
    end;

    Result := Str;
  end;

begin
  with cdsGuia do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Ambiente', ftInteger);
    FieldDefs.Add('SequencialGuia', ftInteger);
    FieldDefs.Add('UFFavorecida', ftString, 2);
    FieldDefs.Add('CodReceita', ftInteger);
    FieldDefs.Add('TipoDocEmitente', ftInteger);
    FieldDefs.Add('DocEmitente', ftString, 18);
    FieldDefs.Add('RazaoSocialEmitente', ftString, 60);
    FieldDefs.Add('EnderecoEmitente', ftString, 60);
    FieldDefs.Add('MunicipioEmitente', ftString, 50);
    FieldDefs.Add('UFEmitente', ftString, 2);
    FieldDefs.Add('CEPEmitente', ftString, 8);
    FieldDefs.Add('TelefoneEmitente', ftString, 11);
    FieldDefs.Add('TipoDocDestinatario', ftInteger);
    FieldDefs.Add('DocDestinatario', ftString, 18);
    FieldDefs.Add('MunicipioDestinatario', ftString, 50);
    FieldDefs.Add('Produto', ftString, 255);
    FieldDefs.Add('NumDocOrigem', ftString, 18);
    FieldDefs.Add('Convenio', ftString, 30);
    FieldDefs.Add('InfoComplementares', ftString, 300);
    FieldDefs.Add('DataVencimento', ftDate);
    FieldDefs.Add('DataLimitePagamento', ftDate);
    FieldDefs.Add('PeriodoReferencia', ftString, 1);
    FieldDefs.Add('MesAnoReferencia', ftString, 6);
    FieldDefs.Add('Parcela', ftString, 2);
    FieldDefs.Add('ValorPrincipal', ftFloat);
    FieldDefs.Add('AtualizacaoMonetaria', ftFloat);
    FieldDefs.Add('Juros', ftFloat);
    FieldDefs.Add('Multa', ftFloat);
    FieldDefs.Add('RepresentacaoNumerica', ftString, 48);
    FieldDefs.Add('CodigoBarras', ftString, 54);
    FieldDefs.Add('QtdeVias', ftInteger);
    FieldDefs.Add('NumeroControle', ftString, 16);
    FieldDefs.Add('IdentificadorGuia', ftString, 10);
    FieldDefs.Add('Reservado', ftString, 126);
    CreateDataSet;
    Append;

    with GNRE do
    begin
      FieldByName('Ambiente').AsInteger := InfoCabec.Ambiente;
      FieldByName('SequencialGuia').AsInteger := SequencialGuia;
      FieldByName('UFFavorecida').AsString := UFFavorecida;
      FieldByName('CodReceita').AsInteger := CodReceita;
      FieldByName('TipoDocEmitente').AsInteger := TipoDocEmitente;

      case TipoDocEmitente of
        1:
          FieldByName('DocEmitente').AsString := FormatMaskText
            ('000\.000\.000\-00;0', DocEmitente);
        2:
          FieldByName('DocEmitente').AsString := FormatMaskText
            ('00\.000\.000\/0000\-00;0', DocEmitente);
        3:
          FieldByName('DocEmitente').AsString := RemoverZeros(DocEmitente);
      end;

      FieldByName('RazaoSocialEmitente').AsString := RazaoSocialEmitente;
      FieldByName('EnderecoEmitente').AsString := EnderecoEmitente;
      FieldByName('MunicipioEmitente').AsString := MunicipioEmitente;
      FieldByName('UFEmitente').AsString := UFEmitente;
      FieldByName('CEPEmitente').AsString := CEPEmitente;
      FieldByName('TelefoneEmitente').AsString := RemoverZeros
        (TelefoneEmitente);
      FieldByName('TipoDocDestinatario').AsInteger := TipoDocDestinatario;

      case TipoDocDestinatario of
        1:
          FieldByName('DocDestinatario').AsString := FormatMaskText
            ('000\.000\.000\-00;0', DocDestinatario);
        2:
          FieldByName('DocDestinatario').AsString := FormatMaskText
            ('00\.000\.000\/0000\-00;0', DocDestinatario);
        3:
          FieldByName('DocDestinatario').AsString := RemoverZeros
            (DocDestinatario);
      end;

      FieldByName('MunicipioDestinatario').AsString := MunicipioDestinatario;
      FieldByName('Produto').AsString := Produto;
      FieldByName('NumDocOrigem').AsString := RemoverZeros(NumDocOrigem);
      FieldByName('Convenio').AsString := Convenio;
      FieldByName('InfoComplementares').AsString := InfoComplementares;
      FieldByName('DataVencimento').AsDateTime := StrToDate
        (FormatarData(DataVencimento));
      FieldByName('DataLimitePagamento').AsDateTime := StrToDate
        (FormatarData(DataLimitePagamento));
      FieldByName('PeriodoReferencia').AsString := PeriodoReferencia;
      FieldByName('MesAnoReferencia').AsString := MesAnoReferencia;
      FieldByName('Parcela').AsString := IntToStr(Parcela);
      FieldByName('ValorPrincipal').AsCurrency := ValorPrincipal;
      FieldByName('AtualizacaoMonetaria').AsCurrency := AtualizacaoMonetaria;
      FieldByName('Juros').AsCurrency := Juros;
      FieldByName('Multa').AsCurrency := Multa;
      FieldByName('RepresentacaoNumerica').AsString := RepresentacaoNumerica;
      FieldByName('CodigoBarras').AsString := CodigoBarras;
      FieldByName('QtdeVias').AsInteger := QtdeVias;
      FieldByName('NumeroControle').AsString := NumeroControle;
      FieldByName('IdentificadorGuia').AsString := IdentificadorGuia;
      FieldByName('Reservado').AsString := Reservado;
    end;
    Post;
  end;
end;

procedure TACBrGNREGuiaFR_Fortes.FormCreate(Sender: TObject);
begin
  cdsGuia := {$IFDEF FPC}  TBufDataSet.Create(Self) {$ELSE} TClientDataSet.Create(Self) {$ENDIF};
  dsGuia.DataSet := cdsGuia;
end;

procedure TACBrGNREGuiaFR_Fortes.RLBand1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  // 1� Via
  if cdsGuia.FieldByName('DocDestinatario').AsString <> '0' then
    RLLabel18.Caption := cdsGuia.FieldByName('DocDestinatario').AsString;

  if cdsGuia.FieldByName('Parcela').AsString <> '0' then
    RLLabel26.Caption := cdsGuia.FieldByName('Parcela').AsString;

  RLLabel28.Caption := FormatFloat('R$ ###,###,###,##0.00',
    cdsGuia.FieldByName('ValorPrincipal').AsFloat);

  RLLabel30.Caption := FormatFloat('R$ ###,###,###,##0.00',
    cdsGuia.FieldByName('AtualizacaoMonetaria').AsFloat);

  if cdsGuia.FieldByName('Juros').AsFloat > 0 then
    RLLabel32.Caption := FormatFloat('R$ ###,###,###,##0.00',
      cdsGuia.FieldByName('Juros').AsFloat);

  if cdsGuia.FieldByName('Multa').AsFloat > 0 then
    RLLabel34.Caption := FormatFloat('R$ ###,###,###,##0.00',
      cdsGuia.FieldByName('Multa').AsFloat);

  RLLabel36.Caption := FormatFloat('R$ ###,###,###,##0.00',
    (cdsGuia.FieldByName('ValorPrincipal')
        .AsFloat + cdsGuia.FieldByName('AtualizacaoMonetaria')
        .AsFloat + cdsGuia.FieldByName('Juros').AsFloat + cdsGuia.FieldByName
        ('Multa').AsFloat));

  RLMemo2.Visible := cdsGuia.FieldByName('Ambiente').AsInteger = 9;

  // 2� Via
  if cdsGuia.FieldByName('DocDestinatario').AsString <> '0' then
    RLLabel55.Caption := cdsGuia.FieldByName('DocDestinatario').AsString;

  if cdsGuia.FieldByName('Parcela').AsString <> '0' then
    RLLabel63.Caption := cdsGuia.FieldByName('Parcela').AsString;

  RLLabel65.Caption := FormatFloat('R$ ###,###,###,##0.00',
    cdsGuia.FieldByName('ValorPrincipal').AsFloat);

  RLLabel66.Caption := FormatFloat('R$ ###,###,###,##0.00',
    cdsGuia.FieldByName('AtualizacaoMonetaria').AsFloat);

  if cdsGuia.FieldByName('Juros').AsFloat > 0 then
    RLLabel67.Caption := FormatFloat('R$ ###,###,###,##0.00',
      cdsGuia.FieldByName('Juros').AsFloat);

  if cdsGuia.FieldByName('Multa').AsFloat > 0 then
    RLLabel69.Caption := FormatFloat('R$ ###,###,###,##0.00',
      cdsGuia.FieldByName('Multa').AsFloat);

  RLLabel71.Caption := FormatFloat('R$ ###,###,###,##0.00',
    (cdsGuia.FieldByName('ValorPrincipal')
        .AsFloat + cdsGuia.FieldByName('AtualizacaoMonetaria')
        .AsFloat + cdsGuia.FieldByName('Juros').AsFloat + cdsGuia.FieldByName
        ('Multa').AsFloat));

  RLMemo3.Visible := cdsGuia.FieldByName('Ambiente').AsInteger = 9;

  // 3� Via
  if cdsGuia.FieldByName('DocDestinatario').AsString <> '0' then
    RLLabel92.Caption := cdsGuia.FieldByName('DocDestinatario').AsString;

  if cdsGuia.FieldByName('Parcela').AsString <> '0' then
    RLLabel100.Caption := cdsGuia.FieldByName('Parcela').AsString;

  RLLabel102.Caption := FormatFloat('R$ ###,###,###,##0.00',
    cdsGuia.FieldByName('ValorPrincipal').AsFloat);

  RLLabel103.Caption := FormatFloat('R$ ###,###,###,##0.00',
    cdsGuia.FieldByName('AtualizacaoMonetaria').AsFloat);

  if cdsGuia.FieldByName('Juros').AsFloat > 0 then
    RLLabel104.Caption := FormatFloat('R$ ###,###,###,##0.00',
      cdsGuia.FieldByName('Juros').AsFloat);

  if cdsGuia.FieldByName('Multa').AsFloat > 0 then
    RLLabel106.Caption := FormatFloat('R$ ###,###,###,##0.00',
      cdsGuia.FieldByName('Multa').AsFloat);

  RLLabel108.Caption := FormatFloat('R$ ###,###,###,##0.00',
    (cdsGuia.FieldByName('ValorPrincipal').AsFloat + cdsGuia.FieldByName
        ('AtualizacaoMonetaria').AsFloat + cdsGuia.FieldByName('Juros')
        .AsFloat + cdsGuia.FieldByName('Multa').AsFloat));
  RLMemo5.Visible := cdsGuia.FieldByName('Ambiente').AsInteger = 9;
end;

end.
