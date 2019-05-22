{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 3.5 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRMDSU.PAS -  QuickReport master/detail setup dialog    ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }
{$include QRDefs.inc}

unit QRMDSU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, DB, FileCtrl, QuickRpt, QREditor, dbtables;

type
  TQRSubdetailSetup = class(TForm)
    AliasGB: TGroupBox;
    BrowseButton: TButton;
    DataBaseName: TComboBox;
    TableGroup: TGroupBox;
    TableName: TComboBox;
    FilterExpression: TEdit;
    Label1: TLabel;
    FilterLabel: TLabel;
    OKButton: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    IndexName: TComboBox;
    GroupBox1: TGroupBox;
    Hasheader: TCheckBox;
    HasFooter: TCheckBox;
    MasterFieldDD: TComboBox;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BrowseButtonClick(Sender: TObject);
    procedure DataBaseNameChange(Sender: TObject);
    procedure TableNameChange(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    FReport : TQuickRep;
    TableComp : TTable;
    FMasterDS : TDataSource;
    FDetailTable : TTable;
    FReportEditor : TQRCustomEditor;
    FSubDetail : TQRSubDetail;
  protected
    procedure GetEditValues;
    procedure SetReport(Value : TQuickRep);
    procedure SetData;
  public
    property QuickRep : TQuickRep read FReport write SetReport;
    property SubDetail : TQRSubDetail read FSubDetail write FSubDetail;
    property DetailTable : TTable read FDetailTable write FDetailTable;
    property ReportEditor : TQRCustomEditor read FReportEditor write FReportEditor;
    property MasterDS : TDatasource read FMasterDS write FMasterDS;
  end;

  procedure SetupSubDetail(ASubDetail : TQRSubDetail; AReport : TQuickRep; AMasterSource : TDataSource; AEditor : TQRCustomEditor);

var
  QRSubdetailSetup: TQRSubdetailSetup;

implementation

{$R *.DFM}

procedure SetupSubDetail(ASubDetail : TQRSubDetail; AReport : TQuickRep; AMasterSource : TDataSource; AEditor : TQRCustomEditor);
begin
  with TQRSubDetailSetup.Create(Application) do
  try
    QuickRep := AReport;
    SubDetail := ASubDetail;
    TableComp := TTable(SubDetail.Dataset);
    ReportEditor := AEditor;
    MasterDS := AMasterSource;
    GetEditValues;
    ShowModal;
  finally
    Free;
  end;
end;

procedure Enable(Control : TWinControl; Enabled : boolean);
var
  i : integer;
begin
  Control.Enabled:=Enabled;
  for i:=0 to Control.ControlCount-1 do
    Control.Controls[I].Enabled:=Enabled;
end;

procedure TQRSubdetailSetup.GetEditValues;
var
  I : integer;
begin
  if TableComp.DatabaseName <> '' then
  begin
    DatabaseNameChange(Self);
    DatabaseName.Text := TableComp.DatabaseName
  end else
    TableComp.DatabaseName := DatabaseName.Text;
  TableName.Text := TableComp.TableName;
  IndexName.Text := TableComp.IndexName;
  FilterExpression.Text := TableComp.Filter;
  for I := 0 to MasterDS.Dataset.FieldCount - 1 do
    MasterFieldDD.Items.Add(MasterDS.Dataset.Fields[I].FieldName);
  MasterFieldDD.Text := TableComp.MasterFields;
  HasHeader.Checked := SubDetail.Bands.HasHeader;
  HasFooter.Checked := SubDetail.Bands.HasFooter;
end;

procedure TQRSubdetailSetup.SetData;
begin
  TableComp.Active := false;
  TableComp.DatabaseName := DatabaseName.Text;
  TableComp.TableName := TableName.Text;
  TableComp.IndexName := IndexName.Text;
  TableComp.Filter := FilterExpression.Text;
  TableComp.MasterFields := MasterFieldDD.Text;
  SubDetail.Bands.HasHeader := HasHeader.Checked;
  SubDetail.Bands.HasFooter := HasFooter.Checked;
  if FilterExpression.Text <> '' then
    TableComp.Filtered := true;
  if TableComp.TableName <> '' then
    TableComp.Active := true;
end;

procedure TQRSubdetailSetup.FormCreate(Sender: TObject);
begin
  Session.GetDatabaseNames(DataBaseName.Items);
  FilterExpression.Visible := false;
  FilterLabel.Visible := false;
  MasterDS := nil;
end;

procedure TQRSubdetailSetup.SetReport(Value : TQuickRep);
begin
  FReport := Value;
end;

procedure TQRSubdetailSetup.BrowseButtonClick(Sender: TObject);
var
  ADirectory : String;
begin
  ADirectory := '';
  if SelectDirectory(ADirectory,[],0) then
    DatabaseName.Text:=ADirectory;
  DatabaseNameChange(Self);
end;

procedure TQRSubdetailSetup.DataBaseNameChange(Sender: TObject);
begin
  Session.GetTableNames(DatabaseName.Text, '', true, false, TableName.Items);
  if TableName.Items.IndexOf(TableName.Text) = -1 then
    TableName.Text := '';
end;


procedure TQRSubdetailSetup.TableNameChange(Sender: TObject);
begin
  if TableName.Text <> TableComp.TableName then
  begin
    TableComp.Active := false;
    TableComp.IndexName := '';
    TableComp.DatabaseName := DatabaseName.Text;
    TableComp.TableName := TableName.Text;
    if TableName.Text <> '' then
      TableComp.Active := true;
    IndexName.Items.Clear;
    IndexName.Text := '';
    TableComp.GetIndexNames(IndexName.Items);
  end
end;

procedure TQRSubdetailSetup.OKButtonClick(Sender: TObject);
begin
  SetData;
end;

end.
