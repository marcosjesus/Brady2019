{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 3.5 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRWIDEWz - DELPHI/C++BUILDER IDE WRAPPER FOR QR WIZARDS ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.qusoft.no                               ::
  ::                                                         ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

{$I QRDEFS.INC }

unit QRIDEWz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  QR5Const, StdCtrls, ExtCtrls, QuickRpt, QRDataWz, QRExtra, ExptIntf,
  ToolIntf, QRWizard, ActiveX, dbtables;

type
  TQReportIDEWizard = class(TIExpert)
  public
    SourceBuffer: PChar;
    function GetName: string; override;
    function GetComment: string; override;
    function GetGlyph: HICON; override;
    function GetStyle: TExpertStyle; override;
    function GetState: TExpertState; override;
    function GetIDString: string; override;
    function GetAuthor: string; override;
    function GetPage: string; override;
    procedure Execute; override;
    function CreateForm(Report : TCustomQuickRep; const FormIdent : string; VarList : TStrings) : TMemoryStream;
    function CreateSource(const UnitIdent, FormIdent: string; VarList : TStrings): TMemoryStream;
  end;

implementation

uses Proxies, VirtIntf, IStreams;

{ Delphi Design Time Wizard }

function TQReportIDEWizard.GetName: string;
begin
  Result := SqrWizardName;
end;

function TQReportIDEWizard.GetComment: string;
begin
  Result := SqrWizardComment;
end;

function TQReportIDEWizard.GetGlyph: HICON;
begin
  Result := LoadIcon(HInstance, 'QREXPERTBITMAP');
end;

function TQReportIDEWizard.GetStyle: TExpertStyle;
begin
  Result := esForm;
end;

function TQReportIDEWizard.GetState: TExpertState;
begin
  Result := [esEnabled];
end;

function TQReportIDEWizard.GetIDString: string;
begin
  Result := 'QuSoft.QuickReportWizard';
end;

function TQReportIDEWizard.GetAuthor: string;
begin
  Result := SqrQuSoft;
end;

function TQReportIDEWizard.GetPage: string;
begin
  Result := SqrBusiness;
end;

function TQReportIDEWizard.CreateForm(Report : TCustomQuickRep; const FormIdent : string; VarList : TStrings) : TMemoryStream;
var
  QRForm: TForm;
  I : integer;
  AComponent : TComponent;
  AList : TList;
  ATable : TTable;
  FormatStr: string;
begin
  FormatStr := '    %s: %s;';
  QRForm := TForm.Create(nil);
  Proxies.CreateSubClass(QRForm, 'T' + FormIdent, TForm);
  QRForm.Name := FormIdent;
  ATable := nil;
  try
    AList := TList.Create;
    try
      for I := 0 to Report.ComponentCount - 1 do
        AList.Add(Report.Components[I]);
      QRForm.InsertComponent(Report);
      for I := 0 to AList.Count - 1 do
      begin
        AComponent := TComponent(AList[I]);
        if (AComponent.Name <> '') and not (AComponent is TQRCustomController) then
        begin
          if AComponent is TTable then
            ATable := TTable(AComponent);
          Report.RemoveComponent(AComponent);
          QRForm.InsertComponent(AComponent);
        end;
      end;
      TQuickRep(Report).Dataset := ATable;
    finally
      AList.Free;
    end;
    Report.Name := Copy(Report.ClassName, 2, 30) + '1';
    Result := TMemoryStream.Create;
    Result.WriteComponentRes(FormIdent, QRForm);
    Result.Position := 0;
    VarList.Clear;
    for I := 0 to QRForm.ComponentCount - 1 do
      VarList.Add(Format(FormatStr, [QRForm.Components[I].Name, QRForm.Components[I].ClassName]));
  finally
    QRForm.Free;
  end;
end;

function TQReportIDEWIzard.CreateSource(const UnitIdent, FormIdent: string; VarList : TStrings): TMemoryStream;
const
  CRLF = #13#10;
  SourceBufferSize = 2048;
var
  I: Integer;
  ALine : string;

  procedure FmtWrite(Stream: TStream; Fmt: PChar; const Args: array of const);
  begin
    if (Stream <> nil) and (SourceBuffer <> nil) then
    begin
      StrLFmt(SourceBuffer, SourceBufferSize, Fmt, Args);
      Stream.Write(SourceBuffer[0], StrLen(SourceBuffer));
    end;
  end;

begin
  SourceBuffer := StrAlloc(SourceBufferSize);
  try
    Result := TMemoryStream.Create;
    try
      FmtWrite(Result,
        'unit %s;' + CRLF + CRLF +
        'interface' + CRLF + CRLF +
        'uses'+CRLF +
        '  SysUtils, Windows, Messages, Classes, Graphics, Controls,'#13#10 +
        '  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;'+CRLF+CRLF, [UnitIdent]);
      FmtWrite(Result,
        'type' + CRLF +
        '  T%s = class(TForm)' + CRLF, [FormIdent]);
      for I := 0 to VarList.Count - 1 do
      begin
        ALine:=VarList[I] + CRLF;
        FmtWrite(Result, PChar(ALine), [nil]);
      end;
      FmtWrite(Result,'  private' + CRLF, [nil]);
      FmtWrite(Result,
        '  end;' + CRLF + CRLF +
        'var' + CRLF +
        '  %s: T%s;' + CRLF + CRLF +
        'implementation' + CRLF + CRLF +
        '{$R *.DFM}' + CRLF + CRLF, [FormIdent, FormIdent]);
      FmtWrite(Result, 'end.' + CRLF, [nil]);
      Result.Position := 0;
    except
      Result.Free;
      raise;
    end;
  finally
    StrDispose(SourceBuffer);
  end;
end;

procedure TQReportIDEWizard.Execute;
var
  UnitIdent, Filename: string;
  ReportName: string;
  CodeStream, HdrStream: IStream;
  DFMString: TStream;
  InCppBuilder: Boolean;
  Report : TCustomQuickRep;
  FormIdent : string;
  VarList : TStrings;
  FormStream : TIMemoryStream;
begin
  DFMString := nil;
  if not ToolServices.GetNewModuleName(UnitIdent, FileName) then Exit;
  ReportName := 'QuickReport' + Copy(UnitIdent, 5, 255);
  InCppBuilder := HexDisplayPrefix <> '$';
  Report := ExecuteQRWizard;
  if Report <> nil then
  begin
    UnitIdent := LowerCase(UnitIdent);
    UnitIdent[1] := Upcase(UnitIdent[1]);
    FormIdent := 'Form' + Copy(UnitIdent, 5, 255);
    VarList := TStringList.Create;
    if InCppBuilder then
    begin
    end else
    try
      FormStream := TIMemoryStream.Create(CreateForm(Report, FormIdent, VarList));
      HdrStream := nil;
      CodeStream := TIStreamAdapter.Create(CreateSource(UnitIdent, FormIdent, VarList));
      ToolServices.CreateCppModule(FileName, ReportName, 'TQuickRep', '',
          HdrStream, CodeStream, FormStream, [cmAddToProject, cmShowSource, cmShowForm,
          cmUnNamed, cmMarkModified]);
    finally
      DFMString.Free;
    end;
  end
end;

end.
