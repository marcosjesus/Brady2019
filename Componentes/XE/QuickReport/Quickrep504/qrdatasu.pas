{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 3.5 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRDATASU.PAS -  QuickReport data setup dialog           ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }
{$include QRDefs.inc}

unit QRDatasu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, DB, DBTables, FileCtrl, QuickRpt, QREditor,
  QRMDSU;

type
  TQRDataSetup = class(TForm)
    DataType: TRadioGroup;
    AliasGB: TGroupBox;
    BrowseButton: TButton;
    DataBaseName: TComboBox;
    TableGroup: TGroupBox;
    TableName: TComboBox;
    FilterExpression: TEdit;
    Label1: TLabel;
    FilterLabel: TLabel;
    SQLGroup: TGroupBox;
    SQL: TMemo;
    OpenSQL: TButton;
    OKButton: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    IndexName: TComboBox;
    GroupBox1: TGroupBox;
    MDEnable: TCheckBox;
    MDSetupButton: TButton;
    procedure DataTypeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BrowseButtonClick(Sender: TObject);
    procedure DataBaseNameChange(Sender: TObject);
    procedure TableNameChange(Sender: TObject);
    procedure SQLChange(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure MDEnableClick(Sender: TObject);
    procedure MDSetupButtonClick(Sender: TObject);
  private
    FReport : TQuickRep;
    TableComp : TTable;
    QueryComp : TQuery;
    MasterDS : TDataSource;
    DetailTable : TTable;
    FReportEditor : TQRCustomEditor;
    FSubDetail : TQRSubDetail;
  protected
    procedure GetEditValues;
    procedure SetReport(Value : TQuickRep);
    procedure SetData;
  public
    property QuickRep : TQuickRep read FReport write SetReport;
    property SubDetail : TQRSubDetail read FSubDetail write FSubDetail;
    property ReportEditor : TQRCustomEditor read FReportEditor write FReportEditor;
  end;

var
  QRDataSetup: TQRDataSetup;

implementation

{$R *.DFM}

procedure Enable(Control : TWinControl; Enabled : boolean);
var
  i : integer;
begin
  Control.Enabled:=Enabled;
  for i:=0 to Control.ControlCount-1 do
    Control.Controls[I].Enabled:=Enabled;
end;

procedure TQRDataSetup.GetEditValues;
begin
  case DataType.ItemIndex of
    0 : begin
          TableName.Items.Clear;
          IndexName.Items.Clear;
          TableName.Text := '';
          IndexName.Text := '';
          FilterExpression.Text := '';
          SQL.Lines.Clear;
        end;
    1 : begin
          if TableComp.DatabaseName <> '' then
          begin
            DatabaseNameChange(Self);
            DatabaseName.Text := TableComp.DatabaseName
          end else
            TableComp.DatabaseName := DatabaseName.Text;
          TableName.Text := TableComp.TableName;
          IndexName.Text := TableComp.IndexName;
          FilterExpression.Text := TableComp.Filter;
          SQL.Lines.Clear;
        end;
    2 : begin
          TableName.Items.Clear;
          IndexName.Items.Clear;
          TableName.Text := '';
          IndexName.Text := '';
          FilterExpression.Text := '';
          SQL.Lines.Assign(QueryComp.SQL);
          if QueryComp.DatabaseName <> '' then
          begin
            DatabaseName.Text := QueryComp.DatabaseName;
            DatabaseNameChange(Self)
          end else
            QueryComp.DatabaseName := DatabaseName.Text;
        end;
  end;
end;

procedure TQRDataSetup.SetData;
begin
  case DataType.ItemIndex of
    1 : begin
          TableComp.Active := false;
          TableComp.DatabaseName := DatabaseName.Text;
          TableComp.TableName := TableName.Text;
          TableComp.IndexName := IndexName.Text;
          TableComp.Filter := FilterExpression.Text;
          if FilterExpression.Text <> '' then
            TableComp.Filtered := true;
          if TableComp.TableName <> '' then
            TableComp.Active := true;
        end;
    2: begin
         QueryComp.Active := false;
         QueryComp.SQL.Assign(SQL.Lines);
         QueryComp.DatabaseName := DatabaseName.Text;
         QueryComp.Active := true;
       end;
  end
end;

procedure TQRDataSetup.DataTypeClick(Sender: TObject);
begin
  Enable(TableGroup,DataType.ItemIndex = 1);
  Enable(SQLGroup, DataType.ItemIndex = 2);
  case DataType.ItemIndex of
    0 : begin
          if TableComp <> nil then
          begin
            TableComp.Free;
            TableComp := nil;
          end;
          if assigned(QueryComp) then
          begin
            QueryComp.Free;
            QueryComp := nil;
          end;
          if Assigned(MasterDS) then
          begin
            MasterDS.Free;
            MasterDS := nil;
          end;
        end;
    1 : begin
          if TableComp = nil then
          begin
            TableComp := TTable.Create(FReport);
            TableComp.Name := UniqueName(FReport.Owner, 'MasterTable'); {<-- do not resource}
            FReport.DataSet := TableComp;
          end;
          if assigned(QueryComp) then
          begin
            QueryComp.Free;
            QueryComp := nil;
          end;
          if MasterDS = nil then
            MasterDS := TDataSource.Create(FReport);
          MasterDS.Dataset := TableComp;
        end;
    2 : begin
          if QueryComp = nil then
          begin
            QueryComp := TQuery.Create(FReport);
            QueryComp.Name := UniqueName(FReport.Owner, 'MasterQuery');  {<-- do not resource}
            FReport.DataSet := QueryComp;
          end;
          if assigned(TableComp) then begin
            TableComp.Free;
            TableComp := nil;
          end;
          if MasterDS = nil then
            MasterDS := TDataSource.Create(FReport);
          MasterDS.Dataset := QueryComp;
        end;
    end;
{    for I := 0 to FReport.ComponentCount - 1 do
      if FReport.Components[I] is TDataSource then
      begin
        FReport.Components[I].Free;
        Break;
      end;}
    GetEditValues;
end;

procedure TQRDataSetup.FormCreate(Sender: TObject);
begin
  Session.GetDatabaseNames(DataBaseName.Items);
  FilterExpression.Visible := false;
  FilterLabel.Visible := false;
  MasterDS := nil;
  GetEditValues;
end;

procedure TQRDataSetup.SetReport(Value : TQuickRep);
var
  I : integer;
begin
  SubDetail := nil;
  FReport := Value;
  if FReport.DataSet <> nil then
  begin
    if FReport.DataSet is TTable then
    begin
      TableComp := TTable(FReport.DataSet);
      DataType.ItemIndex := 1;
    end;
    if FReport.DataSet is TQuery then
    begin
      QueryComp := TQuery(FReport.DataSet);
      DataType.ItemIndex := 2;
    end;
  end;
  for I := 0 to FReport.ControlCount - 1 do
    if FReport.Controls[I] is TQRSubDetail then
    begin
      SubDetail := TQRSubDetail(FReport.Controls[I]);
      mdEnable.Checked := true;
    end;
  for I := 0 to FReport.ComponentCount - 1 do
  if FReport.Components[I] is TDataSource then
  begin
    MasterDS := TDataSource(FReport.Components[I]);
  end;
  MDEnable.Checked := SubDetail <> nil;
  MDSetupButton.Enabled := MDEnable.Checked;

  DataTypeClick(Self);
end;

procedure TQRDataSetup.BrowseButtonClick(Sender: TObject);
var
  ADirectory : String;
begin
  ADirectory := '';
  if SelectDirectory(ADirectory,[],0) then
    DatabaseName.Text:=ADirectory;
  DatabaseNameChange(Self);
end;

procedure TQRDataSetup.DataBaseNameChange(Sender: TObject);
begin
  Session.GetTableNames(DatabaseName.Text, '', true, false, TableName.Items);
  case DataType.ItemIndex of
    1 : if TableName.Items.IndexOf(TableName.Text) = -1 then
           TableName.Text := '';
  end;
end;


procedure TQRDataSetup.TableNameChange(Sender: TObject);
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

procedure TQRDataSetup.SQLChange(Sender: TObject);
begin
  OpenSQL.Enabled := true;
end;

procedure TQRDataSetup.OKButtonClick(Sender: TObject);
begin
  SetData;
end;

procedure TQRDataSetup.MDEnableClick(Sender: TObject);
var
  ASubDetail : TQRSubDetail;
begin
  if MDEnable.Checked and (SubDetail = nil) then
  begin
    ASubDetail := TQRSubDetail.Create(nil);
    ASubDetail.Parent := FReport;
    ReportEditor.Add(ASubDetail, FReport);
    ReportEditor.SetEvents(ReportEditor);
    DetailTable := TTable.Create(FReport);
    DetailTable.Name := UniqueName(FReport, 'DetailTable'); {<-- do not resource}
    DetailTable.MasterSource := MasterDS;
    ASubDetail.Dataset := DetailTable;
    SubDetail := ASubDetail;
  end
  else if not MDEnable.Checked then
    begin
      ReportEditor.Select(SubDetail, false);
      ReportEditor.DeleteSelected;
      SubDetail := nil;
      DetailTable.Free;
    end;
  MDSetupButton.Enabled := MDEnable.Checked;
end;

procedure TQRDataSetup.MDSetupButtonClick(Sender: TObject);
begin
  SetupSubDetail(SubDetail, FReport, MasterDS, ReportEditor);
end;

end.
