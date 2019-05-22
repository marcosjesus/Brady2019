{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 5.0 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QREPORT.PAS - COMPONENT REGISTRATION & PROPERTY EDITORS ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.quickreport.co.uk                       ::
  :: Added Gr controls, removed HTML filter control          ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

{$I QRDEFS.INC}
{$define QRPP}
unit Qreport;       

interface
                                                                                                                       
uses
  Classes, QuickRpt, DesignIntf, DesignEditors, ExptIntf, QRWizard, QRIDEWz
  {$ifdef QRPP}
  , qrpctrls, qrpBaseCtrls, SupComps
  {$endif}
  ;

procedure Register;

type
  { TQRFloatProperty - Floating point property editor with 3 fixed decimal places and support for
    unit settings }
  TQRFloatProperty = class(TFloatProperty)
  public
    function GetValue : string; override;
    procedure SetValue(const Value : string); override;
  end;

  { TQRMasterProperty - property editor for the Master property, showing
    TQuickRep and TQRController components only }
  TQRMasterProperty = class(TComponentProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { TQRCaptionProperty - just a copy of TCaptionProperty }
  TQRCaptionProperty = class(TStringProperty);

  { TQRGraphicsEditor - Component editor for TQRImage, copied from
    PICEDIT.PAS for Delphi 3.0 compatibility }

  TQRGraphicEditor = class(TDefaultEditor)
  public
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;

//    procedure EditProperty(PropertyEditor : TPropertyEditor; var Continue, FreeEditor : Boolean); override;
  end;

  { TDataFieldProperty }
  TQRDBStringProperty = class(TStringProperty)
  public
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValueList(List : TStrings); virtual; abstract;
    procedure GetValues(Proc : TGetStrProc); override;
  end;

  TQRDataFieldProperty = class(TQRDBStringProperty)
  public
    function GetDataSetPropName : string; virtual;
    procedure GetValueList(List : TStrings); override;
  end;

  { TQRExprPropEditor }
  TQRExprProperty = class(TStringProperty)
  public
    function GetAttributes : TPropertyAttributes; override;
    procedure Edit; override;
  end;

  { TQREnvPropEditor }
  TQREnvProperty = class(TPropertyEditor)
  public
    function GetAttributes : TPropertyAttributes; override;
    procedure Edit; override;
  end;

{$ifdef QRPP}
  TQRGridReportDesignModeMenu = class(TComponentEditor)
  protected
    FGridReport:  TQRGridReport;
  public
    constructor Create(AComponent: TComponent;
                       ADesigner: IDesigner ); override;
    procedure Edit; override;
    procedure ExecuteVerb(Index: integer); override;
    function GetVerb(Index: integer): String; override;
    function GetVerbCount : integer; override;
  end;
{$endif}

function GetDesignVerb(Index: Integer): string;
function GetDesignVerbCount: Integer;
procedure ExecuteDesignVerb(Index: Integer; Report: TQuickRep);

implementation

uses
  sysutils, windows, typinfo, controls, stdctrls, forms, qrprntr,
  db, QRCtrls, QRExtra, Dialogs, QRAbout, QRComped, QRExpbld, QR5Const,
  QRExport, QREditor, QREnvEd, QRExpr,GrImgctrl, QRXMLSFilt,
  QRPDFFilt, QRWebfilt, QRAbsDatas, qrframelines;

{$R QRNEW.RES}

{$ifdef QRPP}
{------------------------------------------------------------------------------}

constructor TQRGridReportDesignModeMenu.Create(AComponent: TComponent;
                       ADesigner: IDesigner );
begin
  inherited Create(AComponent, ADesigner);
  FGridReport:=TQRGridReport(AComponent);
end;

procedure TQRGridReportDesignModeMenu.Edit;
begin
end;

function TQRGridReportDesignModeMenu.GetVerb(Index: integer): string;
begin
  case Index of
    0 : result := 'QRGridReport by QBS Software';
    1 : result := 'http://www.QuickReport.co.uk';
    2 : result := '-';
    3 : result := 'Create report from grid';
  end
end;

function TQRGridReportDesignModeMenu.GetVerbCount : integer;
begin
  Result:=4
end;

procedure TQRGridReportDesignModeMenu.ExecuteVerb(Index: integer);
begin
  case Index of
    3: FGridReport.CreateReportFromGrid;
  end;
end;

{------------------------------------------------------------------------------}
{$endif}

function TQRDBStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TQRDBStringProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

function TQRDataFieldProperty.GetDataSetPropName: string;
begin
  Result := 'DataSet'; {<-- do not resource}
end;

procedure TQRDataFieldProperty.GetValueList(List: TStrings);
var
  Instance: TComponent;
  PropInfo: PPropInfo;
  DataSet: TDataSet;
begin
  Instance := TComponent(GetComponent(0));
  PropInfo := TypInfo.GetPropInfo(Instance.ClassInfo, GetDataSetPropName);
  if (PropInfo <> nil) and (PropInfo^.PropType^.Kind = tkClass) then
  begin
    DataSet := TObject(GetOrdProp(Instance, PropInfo)) as TDataSet;
    if (DataSet <> nil) then
      DataSet.GetFieldNames(List);
  end;
end;

{ TQRFloatProperty }

function TQRFloatProperty.GetValue : String;
var
  AUnit : TQRUnit;
begin
  AUnit := TQRUnitBase(GetComponent(0)).Units;
  case AUnit of
    MM : result := FloatToStrF(GetFloatValue, ffFixed, 18, 1) + 'mm'; // Do not translate
    Inches : result := FloatToStrF(GetFloatValue, ffFixed, 18, 3) + 'in'; // Do not translate
  end;
end;

procedure TQRFloatProperty.SetValue(const Value : string);
var
  FixedValue : string;
  AUnit : TQRUnit;
  NewUnit : TQRUnit;

  procedure Remove(What : string; var From : string);
  begin
    while Pos(What, From) > 0 do
      Delete(From, Pos(What, From), Length(What));
  end;

begin
  AUnit := TQRUnitBase(GetComponent(0)).Units;
  NewUnit := AUnit;
  FixedValue := Value;

  if (Copy(FixedValue, Length(FixedValue), 1) = '"') or
    (UpperCase(Copy(FixedValue, Length(FixedValue) - 1, 2)) = 'IN')  then // Do not translate
    NewUnit := Inches
  else
    if UpperCase(Copy(FixedValue, Length(FixedValue) - 1, 2)) = 'MM' then // Do not translate
      NewUnit := MM;

  Remove('mm', FixedValue); // Do not translate
  Remove(' ', FixedValue);
  Remove('"', FixedValue);
  Remove('in', FixedValue); // Do not translate

  if AUnit <> NewUnit then
  begin
    case AUnit of
      MM : begin end;
    end;
  end;
  inherited SetValue(FixedValue);
end;

{ TQRMasterProperty }

procedure TQRMasterProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Root: TComponent;
  Component: TComponent;
begin
{$ifndef ver100}
  Root := Designer.GetRoot;
{$else}
  Root := TFormDesigner(Designer).GetRoot;
{$endif}
  if Root is TQuickRep then Proc(Root.Name);
  for I := 0 to Root.ComponentCount - 1 do
  begin
    Component := Root.Components[I];
    if ((Component is TCustomQuickRep) or (Component is TQRController) or
       (Component is TQRControllerBand)) and
       (Component.Name <> '') then
      Proc(Component.Name);
  end;
end;

{ TQRGraphicsEditor }

procedure TQRGraphicEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
//procedure TQRGraphicEditor.EditProperty(PropertyEditor: TPropertyEditor; var Continue, FreeEditor: Boolean);
var
  PropName: string;
begin
  PropName := Prop.GetName;
  if (CompareText(PropName, 'PICTURE') = 0) then // Do not translate
  begin
    Prop.Edit;
    Continue := False;
  end;
end;

{ TQRExprProperty }

function TQRExprProperty.GetAttributes : TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

procedure TQRExprProperty.Edit;
var
  AValue : string;
  AExpr : TQRExpr;
  AGroup : TQRGroup;
  aenv : TQREvEnvironment;
begin
  AValue:=Value;
  if GetComponent(0) is TQRExpr then
  begin
    AExpr := TQRExpr(GetComponent(0));
    if AExpr.ParentReport <> nil then
    begin
      aEnv := AExpr.ParentReport.Functions;
      if GetExpression('', AValue, TCustomForm(AExpr.Owner), nil, AEnv) then
        Value := AValue
    end
  end else
    if GetComponent(0) is TQRGroup then
    begin
      AGroup := TQRGroup(GetComponent(0));
      if AGroup.PArentReport <> nil then
        if GetExpression('', AValue, TCustomForm(Agroup.Owner), nil, AGroup.ParentReport.Functions) then
          Value := AValue
    end
end;

{ TQREnvProperty }

function TQREnvProperty.GetAttributes : TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

procedure TQREnvProperty.Edit;
begin
  EditEnvironment(TCustomQuickRep(GetComponent(0)).Functions, false, nil);
end;

function GetDesignVerb(Index: Integer): string;
begin
  case Index of
    0 : result := cQRName;
    1 : result := SqrCopyright;
    2 : result := '-';
    3 : result := SqrAboutQR;
    4 : result := SqrReportSettings;
    5 : result := SqrPreview;
    6 : result := '-';
    7 : result := SqrZoomIn;
    8 : result := SqrZoomOut;
  end;
end;

function GetDesignVerbCount: Integer;
begin
  Result := 9;
end;

procedure EditReport(Report: TQuickRep);
begin
  with TQRCompEd.Create(Application) do
  try
    QuickRep:=Report;
    ShowModal;
  finally
    free;
  end;
end;

procedure ShowAboutBox;
begin
  with TQRAboutBox.Create(Application) do
  try
    ShowModal;
  finally
    free;
  end;
end;

procedure MarkModified(Report: TQuickRep);
var
  Component: TComponent;
begin
  Component := Report;
  while Component <> nil do
    if Component is TForm then
    begin
      if TForm(Component).Designer <> nil then
        TForm(Component).Designer.Modified;
      Break;
    end
    else Component := Component.Owner;
end;

procedure ExecuteDesignVerb(Index: Integer; Report: TQuickRep);
begin
  case Index of
    3 : ShowAboutBox;
    4 : EditReport(Report);
    5 : Report.PreviewModal;
    7 : Report.Zoom:=Report.Zoom + 20;
    8 : Report.Zoom:=Report.Zoom - 20;
  end;
  if Index in [4, 7, 8] then MarkModified(Report);
end;

{ TQReportDesignModeMenu }

type
  TQReportDesignModeMenu = Class(TComponentEditor)
  protected
    FReport : TQuickRep;
  public
{$ifndef ver100}
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
{$else}
    constructor Create(AComponent: TComponent; ADesigner: TFormDesigner); override;
{$endif}
    procedure Edit; override;
    procedure ExecuteVerb(Index: integer); override;
    function GetVerb(Index: integer): string; override;
    function GetVerbCount : integer; override;
  end;

constructor TQReportDesignModeMenu.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FReport:=TQuickRep(aComponent);
end;

procedure TQReportDesignModeMenu.Edit;
begin
  EditReport(FReport);
end;

function TQReportDesignModeMenu.GetVerb(Index: integer): string;
begin
  case Index of
    0 : result := cQRName;
    1 : result := SqrCopyright;
    2 : result := '-';
    3 : result := SqrAboutQR;
    4 : result := SqrReportSettings;
    5 : result := SqrPreview;
    6 : result := '-';
    7 : result := SqrZoomIn;
    8 : result := SqrZoomOut;
    9 : result := '-';
    10 : result := SqrRotateBands;
    11 : result := SqrHideBands;
    12 : result := SqrResetBands;
  end
end;

function TQReportDesignModeMenu.GetVerbCount : integer;
begin
  Result:=13;
end;

procedure TQReportDesignModeMenu.ExecuteVerb(Index: integer);
begin
  case Index of
    0, 1, 3 : ShowAboutBox;
    4 : EditReport(FReport);
    5 : FReport.PreviewModal;
    7 : FReport.Zoom := FReport.Zoom + 20;
    8 : FReport.Zoom := FReport.Zoom - 20;
    10 : FReport.RotateBands := FReport.RotateBands + 1;
    11 : FReport.HideBands := true;
    12 : begin
           FReport.RotateBands := 0;
           FReport.HideBands := false;
         end;
  end;
  if Index in [4, 7, 8] then MarkModified(FReport);
end;

{ TQRGroupDesignModeMenu }

type
  TQRGroupDesignModeMenu = Class(TComponentEditor)
  protected
    FGroup : TQRGroup;
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
    procedure ExecuteVerb(Index: integer); override;
    function GetVerb(Index: integer): string; override;
    function GetVerbCount : integer; override;
  end;

constructor TQRGroupDesignModeMenu.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FGroup:=TQRGroup(aComponent);
end;

function TQRGroupDesignModeMenu.GetVerb(Index: integer): string;
begin
  case Index of
    0 : result := cQRName;
    1 : result := SqrCopyright;
    2 : result := '-';
    3 : result := SqrMoveGroupUp;
  end;
end;

function TQRGroupDesignModeMenu.GetVerbCount : integer;
begin
  Result:=4;
end;

procedure TQRGroupDesignModeMenu.ExecuteVerb(Index: integer);
var
  aOwner : TComponent;
  aParent : TWinControl;
  CompList : TList;
  I : integer;
  CurGroup : integer;
begin
  AOwner := FGroup.Owner;
  AParent := FGroup.Parent;
  CompList := nil;
  try
    CompList := TList.Create;
    for I := 0 to AOwner.ComponentCount - 1 do
      if (AOwner.Components[I] is TQRGroup) and
        (TQRGroup(AOwner.Components[I]).Master = FGroup.Master) then
        CompList.Add(AOwner.Components[I]);
    if CompList.Count > 1 then
    begin
      CurGroup := CompList.IndexOf(FGroup);
      case Index of
        3 : if CurGroup > 0 then CompList.Move(CurGroup, 0);
      end;
      for I := 0 to CompList.Count - 1 do
      begin
        AOwner.RemoveComponent(CompList[I]);
        TQRGroup(CompList[I]).Parent := nil;
      end;
      for I := 0 to CompList.Count - 1 do
      begin
        AOwner.InsertComponent(CompList[I]);
        TQRGroup(CompList[I]).Parent := AParent;
        TQRGroup(CompList[I]).Master := TQRGroup(CompList[I]).Master;
      end;
    end;
  finally
    CompList.Free;
  end;
end;

{ TQRSubDetailDesignModeMenu }

type
  TQRSubDetailDesignModeMenu = Class(TComponentEditor)
  protected
    FSubDetail : TQRSubDetail;
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
    procedure ExecuteVerb(Index: integer); override;
    function GetVerb(Index: integer): string; override;
    function GetVerbCount : integer; override;
  end;

constructor TQRSubDetailDesignModeMenu.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited Create(AComponent, ADesigner);
  FSubDetail:=TQRSubDetail(aComponent);
end;

function TQRSubDetailDesignModeMenu.GetVerb(Index: integer): string;
begin
  case Index of
    0 : result := cQRName;
    1 : result := SqrCopyright;
    2 : result := '-';
    3 : result := SqrMoveSubdetailUp;
  end;
end;

function TQRSubDetailDesignModeMenu.GetVerbCount : integer;
begin
  Result:=4;
end;

procedure TQRSubDetailDesignModeMenu.ExecuteVerb(Index: integer);
var
  aOwner : TComponent;
  aParent : TWinControl;
  CompList : TList;
  I : integer;
  CurSub : integer;
begin
  AOwner := FSubDetail.Owner;
  AParent := FSubDetail.Parent;
  if AParent is TQuickRep then
  begin
    CompList := TList.Create;
    try
      for I := 0 to AOwner.ComponentCount - 1 do
        if (AOwner.Components[I] is TQRSubDetail) and
          (TQRSubDetail(AOwner.Components[I]).Master = FSubDetail.Master) then
          CompList.Add(AOwner.Components[I]);
      if CompList.Count > 1 then
      begin
        CurSub := CompList.IndexOf(FSubDetail);
        if CurSub > - 1 then
        case Index of
          3 : if CurSub > 0 then CompList.Move(CurSub, 0);
        end;
        for I := 0 to CompList.Count - 1 do
        begin
          AOwner.RemoveComponent(CompList[I]);
          TQRSubDetail(CompList[I]).Parent := nil;
        end;
        for I := 0 to CompList.Count - 1 do
        begin
          AOwner.InsertComponent(CompList[I]);
          TQRSubDetail(CompList[I]).Parent := AParent;
          TQRSubDetail(CompList[I]).Master := TQRSubDetail(CompList[I]).Master;
        end;
      end;
    finally
      CompList.Free;
    end;
  end;
end;

{ Register components and property editors }

procedure Register;
begin
  RegisterComponents(SqrPaletteQReport,[TQuickRep, TQuickAbstractRep, TQRSubDetail, TQRLoopBand, TQRStringsBand,
    TQRBand, TQRWildband, TQRChildBand, TQRGroup, TQRLabel,TQRDBText, TQRExpr, TQRSysData, TQRMemo, TQRExprMemo,
    TQRRichText, TQRDBRichText, TQRShape, TQRImage, TQRDBImage, TQRCompositeReport,
    TQRPreview, TQRTextFilter, TQRCSVFilter, TQRPDFFilter, TQRXMLSFilter, TQRHTMLFilter, TQRExcelFilter, TQRRTFFilter, TQRWMFFilter,
    TQREditor, TQRGrImage, TQrGrDBImage, TQRPDFShape, TQRFrameLine, TQRAbsTable, TQRHTMLLabel, TQRHRule
    {$ifdef QRPP}
    ,TQRPQuickrep,
    TQRPBand,
    TQRPChildBand,
    TQRPLabel,
    TQRPDBText,
    TQRPDBImage,
    TQRPExpr,
    TQRPMemo,
    {$IFDEF WIN32}
    TQRPRichtext,
    {$ENDIF}
    TQRPGrid,
    TQRPCheckbox,
    TQRPShape,
    TQRPExprCheckbox,
    TQRStringgridReport,
    TQRGridReport,
    TEnhancedListbox]);
    {$else}
    ]);
    {$endif}

  {$ifdef QRPP}
  RegisterPropertyEditor(TypeInfo(string), TQRPExprCheckbox, 'Expression', TQRExprProperty);
  RegisterPropertyEditor(TypeInfo(string), TQRPBand, 'Expression', TQRExprProperty);
  RegisterPropertyEditor(TypeInfo(string), TQRPChildBand, 'Expression', TQRExprProperty);
  RegisterComponentEditor(TQRGridReport, TQRGridReportDesignModeMenu);
  {$endif}

  RegisterPropertyEditor(TypeInfo(string), TQRDBRichText, 'DataField', TQRDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(extended), TQRPage, '', TQRFloatProperty);
  RegisterPropertyEditor(TypeInfo(extended), TQRLabelSetup, '', TQRFloatProperty);
  RegisterPropertyEditor(TypeInfo(extended), TQRBandSize, '', TQRFloatProperty);
  RegisterPropertyEditor(TypeInfo(extended), TQRPrintableSize, '', TQRFloatProperty);
  RegisterPropertyEditor(TypeInfo(string), TQRCustomLabel, 'Caption', TQRCaptionProperty); {<-- do not resource }
  RegisterPropertyEditor(TypeInfo(TComponent), TQRExpr, 'Master', TQRMasterProperty);      {<-- do not resource }
  RegisterPropertyEditor(TypeInfo(TComponent), TQRGroup, 'Master', TQRMasterProperty);     {<-- do not resource }
  RegisterPropertyEditor(TypeInfo(TComponent), TQRSubDetail, 'Master', TQRMasterProperty); {<-- do not resource }
  RegisterPropertyEditor(TypeInfo(string), TQRDBText, 'DataField', TQRDataFieldProperty);  {<-- do not resource }
  RegisterPropertyEditor(TypeInfo(string), TQRDBImage, 'DataField', TQRDataFieldProperty); {<-- do not resource }
  RegisterPropertyEditor(TypeInfo(string), TQRGrDBImage, 'DataField', TQRDataFieldProperty); {<-- do not resource }
  RegisterPropertyEditor(TypeInfo(string), TQRExpr, 'Expression', TQRExprProperty);        {<-- do not resource }
  RegisterPropertyEditor(TypeInfo(string), TQRGroup, 'Expression', TQRExprProperty);       {<-- do not resource }
  RegisterPropertyEditor(TypeInfo(TQREvEnvironment), TCustomQuickRep, 'Functions', TQREnvProperty);

  RegisterComponentEditor(TCustomQuickRep,TQReportDesignModeMenu);
  RegisterComponentEditor(TQRImage, TQRGraphicEditor);
  RegisterComponentEditor(TQRGroup, TQRGroupDesignModeMenu);
  RegisterComponentEditor(TQRSubDetail, TQRSubDetailDesignModeMenu);
  RegisterClasses([TQRDBCalc]);
  RegisterNonActiveX([TQuickRep, TQRSubDetail, TQRChildBand, TQRGroup,
    TQRDBText, TQRExpr, TQRSysData, TQRMemo, TQRDBRichText, TQRShape, TQRImage,
    TQRDBImage, TQRCompositeReport, TQRPreview,
    TQRBasePanel, TQRCustomBand, TQRCustomLabel, TQRCustomRichText, TQRBand,
    TQRControllerBand, TQRLabel, TQRPrintable, TQRRichText], axrIncludeDescendants);

  RegisterLibraryExpert(TQReportIDEWizard.Create);
  RegisterPropertiesInCategory('Localizable', TCustomQuickRep,    ['ReportTitle']);
  RegisterPropertiesInCategory('Localizable', TQRCompositeReport, ['ReportTitle']);
end;

end.
