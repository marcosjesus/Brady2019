{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 3.5 for Delphi and C++Builder               ::
  ::                                                         ::
  :: QRDATAWZ - TABLE/FIELDS SELECTION DIALOG                ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.qusoft.no                               ::
  ::                                                         ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }
{$include QRDefs.inc}
unit QRDataWz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, StdCtrls, FileCtrl, DBTables;

type
  TTableSelector = class(TForm)
    GroupBox2: TGroupBox;
    SelectDir: TButton;
    AliasName: TComboBox;
    GroupBox4: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    AvailableFields: TListBox;
    AddOne: TButton;
    AddAll: TButton;
    RemoveOne: TButton;
    RemoveAll: TButton;
    SelectedFields: TListBox;
    Label1: TLabel;
    TableName: TComboBox;
    Label6: TLabel;
    ContinueBtn: TButton;
    CancelBtn: TButton;
    Table: TTable;
    procedure TableNameChange(Sender: TObject);
    procedure SelectDirClick(Sender: TObject);
    procedure TableNameEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddOneClick(Sender: TObject);
    procedure AddAllClick(Sender: TObject);
    procedure RemoveOneClick(Sender: TObject);
    procedure RemoveAllClick(Sender: TObject);
    procedure AvailableFieldsClick(Sender: TObject);
    procedure SelectedFieldsClick(Sender: TObject);
    procedure AvailableFieldsDblClick(Sender: TObject);
    procedure SelectedFieldsDblClick(Sender: TObject);
    procedure BackBtnClick(Sender: TObject);
    procedure ContinueBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
    procedure PickFields;
    procedure PickTables;
    procedure FixButtons;
  public
    { Public declarations }
  end;

function GetTable(var AAlias, ATable : string; ASelectedFields : TStrings; ParentControl : TWinControl) : integer;

implementation

{$R *.DFM}

procedure MoveList(Source, Dest : TListBox);
var
  I : integer;
begin
  with Source do
  begin
    for I := 0 to Items.Count - 1 do
      if Selected[I] then Dest.Items.AddObject(Items[I], Items.Objects[I]);
    I := 0;
    while I<Items.Count do
    begin
      if Selected[I] then
        Items.Delete(I)
      else
        inc(I);
    end
  end
end;

procedure MoveListAll(Source, Dest : TListBox);
var
  I : integer;
begin
  for I:=0 to Source.Items.Count - 1 do
    Dest.Items.AddObject(Source.Items[I], Source.Items.Objects[I]);
  Source.Clear;
end;

procedure TTableSelector.PickTables;
begin
  try
    Session.GetTableNames(AliasName.Text, '', true, false, TableName.Items);
  except
    AliasName.Text := '';
    TableName.Clear;
  end;
end;

procedure TTableSelector.PickFields;
var
  I : integer;
begin
  if (Table.DatabaseName <> AliasName.Text) or (Table.TableName <> TableName.Text) then
  begin
    Table.Close;
    Table.DatabaseName := AliasName.Text;
    Table.TableName := TableName.Text;
    Table.FieldDefs.Update;
    AvailableFields.Clear;
    SelectedFields.Clear;
    Table.Open;
    for I := 0 to Table.FieldCount - 1 do
      AvailableFields.Items.Add(Table.Fields[I].FieldName);
  end;
end;

procedure TTableSelector.TableNameChange(Sender: TObject);
begin
  PickFields;
end;

procedure TTableSelector.SelectDirClick(Sender: TObject);
var
  ADirectory : string;
begin
  ADirectory := AliasName.Text;
  if not DirectoryExists(ADirectory) then ADirectory := '';
  if SelectDirectory(ADirectory, [], 0) then
    AliasName.Text:=ADirectory;
end;

procedure TTableSelector.TableNameEnter(Sender: TObject);
begin
  PickTables;
end;

procedure TTableSelector.FormCreate(Sender: TObject);
var
  ADir : string;
begin
  Session.GetDatabaseNames(AliasName.Items);
  GetDir(0, ADir);
  AliasName.Text := ADir;
  ExitCode := 0;
end;

procedure TTableSelector.AddOneClick(Sender: TObject);
begin
  MoveList(AvailableFields, SelectedFields);
  FixButtons;
end;

procedure TTableSelector.AddAllClick(Sender: TObject);
begin
  MoveListAll(AVailableFields, SelectedFields);
  FixButtons;
end;

procedure TTableSelector.RemoveOneClick(Sender: TObject);
begin
  MoveList(SelectedFields, AvailableFields);
  FixButtons;
end;

procedure TTableSelector.RemoveAllClick(Sender: TObject);
begin
  MoveListAll(SelectedFields, AvailableFields);
  FixButtons;
end;

procedure TTableSelector.AvailableFieldsClick(Sender: TObject);
begin
  AddOne.Enabled := AvailableFields.SelCount > 0;
  SelectedFields.ItemIndex := -1;
  FixButtons;
end;

procedure TTableSelector.SelectedFieldsClick(Sender: TObject);
begin
  RemoveOne.Enabled := SelectedFields.SelCount > 0;
  AvailableFields.ItemIndex := -1;
  FixButtons;
end;

procedure TTableSelector.AvailableFieldsDblClick(Sender: TObject);
begin
  SelectedFields.Items.Add(AvailableFields.Items[AvailableFields.ItemIndex]);
  AvailableFields.Items.Delete(AvailableFields.ItemIndex);
  FixButtons;
end;

procedure TTableSelector.SelectedFieldsDblClick(Sender: TObject);
begin
  AvailableFields.Items.Add(SelectedFields.items[SelectedFields.ItemIndex]);
  SelectedFields.Items.Delete(SelectedFields.ItemIndex);
  FixButtons;
end;

procedure TTableSelector.FixButtons;
begin
  ContinueBtn.Enabled := SelectedFields.Items.Count > 0;
end;

procedure TTableSelector.BackBtnClick(Sender: TObject);
begin
  ExitCode := 1;
end;

procedure TTableSelector.ContinueBtnClick(Sender: TObject);
begin
  ExitCode := 2;
end;

procedure TTableSelector.CancelBtnClick(Sender: TObject);
begin
  ExitCode := 3;
end;

function GetTable(var AAlias, ATable : string; ASelectedFields : TStrings; ParentControl : TWinControl) : integer;
begin
  with TTableSelector.Create(Application) do
  try
    if ParentControl <> nil then
    begin
      Parent := ParentControl;
      Position := poDesigned;
      Top := 0;
      Left := 0;
      BorderStyle := bsNone;
    end;
    AliasName.Text := AAlias;
    PickTables;
    if TableName.Items.IndexOf(ATable) > -1 then
    begin
      TableName.ItemIndex := TableName.Items.IndexOf(ATable);
      PickFields;
    end;
    if ASelectedFields.Count > 0 then
    begin
      SelectedFields.Items.Assign(ASelectedFields);
      FixButtons;
    end;
    Show;
    repeat
      Application.HandleMessage
    until ExitCode <> 0;
    if ExitCode = 2 then
    begin
      AAlias := AliasName.Text;
      ATable := TableName.Text;
      ASelectedFields.Assign(SelectedFields.Items);
    end;
    Result := ExitCode;
  finally
    Free;
  end;
end;

end.
