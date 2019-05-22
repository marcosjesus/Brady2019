{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::  :: QuickReport 3.5 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRWIZARD - WIZARD WRAPPER AND BASIC WIZARDS             ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Sofware                          ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.qusoft.no                               ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

unit QRWizard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  QR5Const, StdCtrls, ExtCtrls, QuickRpt, DBTables, QRDataWz, QRExtra;

type
  TQRWizard = class;

  TMainWizardForm = class(TForm)
    SelectPanel: TPanel;
    StartWizardBtn: TButton;
    Button1: TButton;
    GroupBox1: TGroupBox;
    WizardCB: TComboBox;
    Description: TMemo;
    Image2: TImage;
    procedure FormActivate(Sender: TObject);
    procedure WizardCBChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StartWizardBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FReport : TCustomQuickRep;
    ActiveWizard : TQRWizard;
  public
    property Report : TCustomQuickRep read FReport;
  end;

  TQRWizard = class  public
    function Name : string; virtual; abstract;
    function Description : string; virtual; abstract;
    function CanClose : boolean; virtual; abstract;
    function Picture : TPicture; virtual; abstract;
    function Execute(Parent : TWinControl) : TCustomQuickRep; virtual; abstract;
  end;

  TQRWizardClass = class of TQRWizard;

  TQRPlainWizard = class(TQRWizard)
  public
    function Name : string; override;
    function Description : string; override;
    function CanClose : boolean; override;
    function Execute(Parent : TWinControl) : TCustomQuickRep; override;
  end;

  TQRPlainWizardClass = class of TQRPlainWizard;

  TQRListWizard = class(TQRWizard)
  public
    function Name : string; override;
    function Description : string; override;
    function CanClose : boolean; override;
    function Execute(Parent : TWinControl) : TCustomQuickRep; override;
  end;
           
  TQRListWizardClass = class of TQRListWizard;

  TQRMasterDetailWizard = class(TQRWizard)
  public
    function Name : string; override;
    function Description : string; override;
    function CanClose : boolean; override;
    function Execute(Parent : TWinControl) : TCustomQuickRep; override;
  end;

  TQRMasterDetailWizardClass = class of TQRMasterDetailWizard;

  TQRLabelWizard = class(TQRWizard)
  public
    function Name : string; override;
    function Description : string; override;
    function CanClose : boolean; override;
    function Execute(Parent : TWinControl) : TCustomQuickRep; override;
  end;

  TQRLabelWizardClass = class of TQRLabelWizard;

  procedure RegisterQRWizard(WizardClass : TQRWizardClass);
  function ExecuteQRWizard : TCustomQuickRep;
  function WizardList : TList;

implementation

{$R *.DFM}

function ExecuteQRWizard : TCustomQuickRep;
begin
  with TMainWizardForm.Create(Application) do
  try
    ShowModal;
    if ModalResult = mrOK then
      Result := Report
    else
      Result := nil;
  finally
    Free;
  end;
end;

procedure TMainWizardForm.FormActivate(Sender: TObject);
var
  I : integer;
begin
  WizardCB.Items.Clear;
  for I := 0 to WizardList.Count - 1 do
    WizardCB.Items.Add(TQRWizard(WizardList[I]).Name);
  WizardCB.ItemIndex := 0;
  WizardCBChange(Self);
end;

procedure TMainWizardForm.WizardCBChange(Sender: TObject);
begin
  Description.Lines.Clear;
  if WizardList.Count > 0 then
    Description.Lines.Add(TQRWizard(WizardList[WizardCB.ItemIndex]).Description);
end;

procedure TMainWizardForm.FormCreate(Sender: TObject);
begin
  FReport := nil;
  ActiveWizard := nil;
end;

procedure TMainWizardForm.StartWizardBtnClick(Sender: TObject);
begin
  if WizardList.Count > 0 then
  begin
    ActiveWizard := TQRWizard(WizardList[WizardCB.ItemIndex]);
    FReport := ActiveWizard.Execute(SelectPanel);
  end;
  if FReport <> nil then ModalResult := mrOK;
  ActiveWizard := nil;
end;

function TQRPlainWizard.Name : string;
begin
  Result := SqrPlainWizardName;
end;

function TQRPlainWizard.Description : string;
begin
  Result := SqrPlainWizardDescription;
end;

function TQRPlainWizard.CanClose : boolean;
begin
  Result := true;
end;

function TQRPlainWizard.Execute(Parent : TWinControl) : TCustomQuickRep;
begin
  Result := TQuickRep.Create(nil);
  with TQuickRep(Result).Bands do
  begin
    HasTitle := true;
    HasPageHeader := true;
    HasPageFooter := true;
    HasSummary := true;
    HasDetail := true;
  end;
end;

function TQRListWizard.Name : string;
begin
  Result := SqrListWizardName;
end;

function TQRListWizard.Description : string;
begin
  Result := SqrListWizardDescription;
end;

function TQRListWizard.CanClose : boolean;
begin
  Result := true;
end;

function TQRListWizard.Execute(Parent : TWinControl) : TCustomQuickRep;
var
  PageNumber : integer;
  PageResult : integer;
  TableName : string;
  AliasName : string;
  FieldList : TStrings;
  ATable : TTable;
begin
  FieldList := TStringList.Create;
  AliasName := '';
  TableName := '';
  PageNumber := 1;
  pageresult := 1;
  Result := nil;
  repeat
    case PageNumber of
      1 : PageResult := GetTable(AliasName, TableName, FieldList, Parent);
    end;
  until (PageResult = 3) or ((PageResult = 2) and (PageNumber = 1));
  if PageResult = 2 then
  begin
    ATable := TTable.Create(nil);
    ATable.DatabaseName := AliasName;
    ATable.TableName := TableName;
    ATable.FieldDefs.Update;
    ATable.Active := true;
    ATable.Name := 'Table1';
    QRCreateList(Result, nil, ATable, '', FieldList);
    Result.InsertComponent(ATable);
    TQuickRep(Result).DataSet := ATable;
    Result.Visible := true;
  end;
end;

function TQRMasterDetailWizard.Name : string;
begin
  Result := SqrMasterDetailWizardName;
end;

function TQRMasterDetailWizard.Description : string;
begin
  Result := SqrMasterDetailWizardDescription;
end;

function TQRMasterDetailWizard.CanClose : boolean;
begin
  Result := true;
end;

function TQRMasterDetailWizard.Execute(Parent : TWinControl) : TCustomQuickRep;
begin
  Result := nil;
end;

function TQRLabelWizard.Name : string;
begin
  Result := SqrLabelWizardName;
end;

function TQRLabelWizard.Description : string;
begin
  Result := SqrLabelWizardDescription;
end;

function TQRLabelWizard.CanClose : boolean;
begin
  Result := true;
end;

function TQRLabelWizard.Execute(Parent : TWinControl) : TCustomQuickRep;
begin
  Result := nil;
end;

var
  AWizardList : TList;

function WizardList : TList;
begin
  if AWizardList = nil then
    AWizardList := TList.Create;
  Result := AWizardList;
end;

procedure RegisterQRWizard(WizardClass : TQRWizardClass);
begin
  if AWizardList = nil then
    AWizardList := TList.Create;
  AWizardList.Add(WizardClass.Create);
end;

procedure TMainWizardForm.Button1Click(Sender: TObject);
begin
  Close
end;

initialization
  AWizardList := nil;

finalization
  if WizardList <> nil then
  begin
    while WizardList.Count > 0 do
    begin
      TObject(WizardList[0]).Free;
      WizardList.Delete(0);
    end;
    WizardList.Free;
  end;

end.

