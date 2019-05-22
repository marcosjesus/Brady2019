{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 5.0 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QREPORT.PAS - COMPONENT REGISTRATION & PROPERTY EDITORS ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.quickreport.co.uk                       ::
  ::                                                         ::}
  
{$I QRDEFS.INC}

unit QRNew;

interface

procedure Register;

implementation

uses Windows, ActiveX, SysUtils, Classes, Controls, Forms, ExptIntf, ToolIntf,
  VirtIntf, IStreams, DesignIntf, DesignEditors, QuickRpt, QReport, QR5Const;

type
  TNewQuickReport = class(TIExpert)
    function GetName: string; override;
    function GetComment: string; override;
    function GetGlyph: HICON; override;
    function GetStyle: TExpertStyle; override;
    function GetState: TExpertState; override;
    function GetIDString: string; override;
    function GetAuthor: string; override;
    function GetPage: string; override;
    function GetMenuText: string; override;
    procedure Execute; override;
  end;

{ TNewQuickReport }

function TNewQuickReport.GetName: string;
begin
  Result := SqrReport;
end;

function TNewQuickReport.GetComment: string;
begin
  Result := SqrDesignReport;
end;

function TNewQuickReport.GetGlyph: HICON;
begin
  Result := LoadIcon(HInstance, 'QRNEW');
end;

function TNewQuickReport.GetStyle: TExpertStyle;
begin
  Result := esForm;
end;

function TNewQuickReport.GetState: TExpertState;
begin
  Result := [esEnabled];
end;

function TNewQuickReport.GetIDString: string;
begin
  Result := 'QBSS.NewQuickReport'; { <-- do not resource }
end;

function TNewQuickReport.GetAuthor: string;
begin
  Result := SqrQuSoft;
end;

function TNewQuickReport.GetPage: string;
begin
  Result := SqrNew;
end;

function TNewQuickReport.GetMenuText: string;
begin
  Result := '';
end;

const
  CRLF = #13#10;
  DashLine =
  '//----------------------------------------------------------------------------';

  QuickReportCppSource =
    DashLine + CRLF +
    '#include <vcl\vcl.h>' + CRLF +
    '#pragma hdrstop' + CRLF +
    CRLF +
    '#include "%0:s.h"' + CRLF +
    DashLine + CRLF +
    '#pragma resource "*.dfm"' + CRLF +
    'T%1:s *%1:s;' + CRLF +
    DashLine + CRLF +
    '__fastcall T%1:s::T%1:s(TComponent* Owner)' + CRLF +
    '    : TQuickRep(Owner)' + CRLF +
    '{' + CRLF +
    '}' + CRLF +
    DashLine;

  QuickReportCppHeader =
    DashLine + CRLF +
    '#ifndef %0:sH' + CRLF +
    '#define %0:sH' + CRLF +
    DashLine + CRLF +
    '#include <vcl\Classes.hpp>' + CRLF +
    '#include <vcl\Controls.hpp>' + CRLF +
    '#include <vcl\StdCtrls.hpp>' + CRLF +
    '#include <vcl\Forms.hpp>' + CRLF +
    '#include <vcl\QuickRpt.hpp>' + CRLF +
    '#include <vcl\QRCtrls.hpp>' + CRLF +
    DashLine + CRLF +
    'class T%1:s : public TQuickRep' + CRLF +
    '{' + CRLF +
    '__published:' + CRLF +
    'private:' + CRLF +
    'public:' + CRLF +
    '   __fastcall T%1:s::T%1:s(TComponent* Owner);' + CRLF +
    '};' + CRLF +
    DashLine + CRLF +
    'extern T%1:s *%1:s;' + CRLF +
    DashLine + CRLF +
    '#endif';

  QuickReportUnitSource =
    'unit %0:s;'#13#10 +
    #13#10 +
    'interface'#13#10 +
    #13#10 +
    'uses Windows, SysUtils, Messages, Classes, Graphics, Controls,'#13#10 +
    '  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;'#13#10 +
    #13#10 +
    'type'#13#10 +
    '  T%1:s = class(TQuickRep)'#13#10 +
    '  private'#13#10 +
    #13#10 +
    '  public'#13#10 +
    #13#10 +
    '  end;'#13#10 +
    #13#10 +
    'var'#13#10 +
    '  %1:s: T%1:s;'#13#10 +
    #13#10 +
    'implementation'#13#10 +
    #13#10 +
    '{$R *.DFM}'#13#10 +
    #13#10 +
    'end.'#13#10;

  QuickReportDfmSource = 'object %s: T%0:s end';

procedure TNewQuickReport.Execute;
var
  UnitIdent, Filename: string;
  ReportName: string;
  CodeStream, HdrStream, DFMStream: IStream;
  DFMString, DFMVCLStream: TStream;
  InCppBuilder: Boolean;
begin
  if not ToolServices.GetNewModuleName(UnitIdent, FileName) then Exit;
  ReportName := 'QuickReport' + Copy(UnitIdent, 5, 255);
  InCppBuilder := HexDisplayPrefix <> '$';
  if InCppBuilder then
  begin
    HdrStream := TIStreamAdapter.Create(TStringStream.Create(Format(QuickReportCppHeader,
      [UnitIdent, ReportName])), soOwned);
    CodeStream := TIStreamAdapter.Create(TStringStream.Create(Format(QuickReportCppSource,
      [UnitIdent, ReportName])), soOwned);
  end else
  begin
    HdrStream := nil;
    CodeStream := TIStreamAdapter.Create(TStringStream.Create(Format(QuickReportUnitSource,
      [UnitIdent, ReportName])), soOwned);
  end;
  DFMString := TStringStream.Create(Format(QuickReportDfmSource, [ReportName]));
  try
    DFMVCLStream := TMemoryStream.Create;
    DFMStream := TIStreamAdapter.Create(DFMVCLStream, soOwned);
    ObjectTextToResource(DFMString, DFMVCLStream);
    DFMVCLStream.Position := 0;
    ToolServices.CreateCppModule(FileName, ReportName, 'TQuickRep', '',
      HdrStream, CodeStream, DFMStream, [cmAddToProject, cmShowSource, cmShowForm,
      cmUnNamed, cmMarkModified]);
  finally
    DFMString.Free;
  end;
end;

type
  TQuickReportCustomModule = class(TCustomModule)
  public
    function GetAttributes: TCustomModuleAttributes; override;
    function ValidateComponentClass(ComponentClass: TComponentClass): Boolean; override;
    procedure ValidateComponent(Component: TComponent); override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

function TQuickReportCustomModule.GetAttributes: TCustomModuleAttributes;
begin
  Result := [cmaVirtualSize];
end;

function TQuickReportCustomModule.ValidateComponentClass(ComponentClass: TComponentClass): Boolean;
begin
  Result := inherited ValidateComponentClass(ComponentClass) and
    (not ComponentClass.InheritsFrom(TControl) or
      ComponentClass.InheritsFrom(TQRBasePanel) or
      ComponentClass.InheritsFrom(TQRPrintable));
end;

procedure TQuickReportCustomModule.ValidateComponent(Component: TComponent);
begin
  if (Component = nil) or ((Component is TControl) and not (Component is TQRBasePanel)
    and not (Component is TQRPrintable)) then
    raise Exception.CreateFmt(SqrCannotAdd, [Component.ClassName]);
end;

procedure TQuickReportCustomModule.ExecuteVerb(Index: Integer);
begin
  ExecuteDesignVerb(Index, TQuickRep(Root));
end;

function TQuickReportCustomModule.GetVerb(Index: Integer): string;
begin
  Result := GetDesignVerb(Index);
end;

function TQuickReportCustomModule.GetVerbCount: Integer;
begin
  Result := GetDesignVerbCount;
end;

procedure Register;
begin
  RegisterCustomModule(TQuickRep, TQuickReportCustomModule);
  RegisterLibraryExpert(TNewQuickReport.Create);
end;

end.


