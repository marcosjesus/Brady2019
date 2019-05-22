unit ConsTabFun;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, Mask, DBCtrls, DB, DBTables,
  ComCtrls ;

type
  TFormConsTab = class(TForm)
    PanFundo: TPanel;
    LabTitulo: TLabel;
    PanLinha: TPanel;
    Grid: TDBGrid;
    ButOk: TBitBtn;
    ButCancelar: TBitBtn;
    Ds: TDataSource;
    EdiPesq: TEdit;
    LabPesq: TLabel;
    EdiCodigo: TEdit;
    QCons: TQuery;
    procedure FormShow(Sender: TObject);
    procedure ButCancelarClick(Sender: TObject);
    procedure ButOkClick(Sender: TObject);
    procedure GridColEnter(Sender: TObject);
    procedure EdiPesqKeyPress(Sender: TObject; var Key: Char);
    procedure GridKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridTitleClick(Column: TColumn);
   private
    { Private declarations }
  public
    { Public declarations }
    Procedure SetGrid ;
  end;

Procedure ConsTab_Show ( F : TForm ;                   // -> Formulário original
                        Title : String ;               // -> Título da consulta
                        TableName : String ;           // -> Nome da tabela
                        aFields : Array Of String ;    // -> Array dos campos
                        aTitles : Array Of String ;    // -> Array dos títulos das colunas
                        RetField : Integer = 0 ;       // -> Campo para retorno
                        RetComp : TWinControl = Nil ;  // -> Controle a receber o retorno
                        RetField2 : Integer = 0 ;      // -> Segundo campo para retorno
                        RetComp2 : TWinControl = Nil ; // -> Segundo controle p/ retorno
                        Sql : String = '' ;            // -> Sql de pesquisa
                        DBName : String = ''           // -> DatabaseName
                      ) ; Export ;


Procedure ConsTab_SetDBName ( Value : String ) ; Export ;

Function GetSqlSelect : String  ; Export ;

Function ConsTab_GetQCons : TQuery ; Export ;

var
  FormConsTab: TFormConsTab;


implementation

{$R *.DFM}

Uses

   rsFlyovr, rsEdit ;


Const

   TYPE_EDIT   = 1 ;
   TYPE_LABEL  = 2 ;
   TYPE_COMBO  = 3 ;
   TYPE_MASK   = 4 ;
   TYPE_SEDIT  = 5 ;
   TYPE_GNEDIT = 6 ;

Var
   VarForm  : TForm ;
   VarComp  : TWinControl ;
   VarComp2 : TWinControl ;
   VarType  : Integer ;
   VarType2 : Integer ;
   VarTop, VarLeft, VarWidth, VarHeight : Integer ;
   VarSql   : String ;

   VarDBName, VarTableName : String ;
   VarFields, VarTitles  : Array of String ;
   VarNumFields : Integer ;
   VarRetField  : Integer ;
   VarRetField2 : Integer ;
   VarColWid : Array Of Integer ;
   VarFind : String ;

Procedure ConsTab_Show ( F : TForm ;                    // -> Formulário original
                        Title : String ;               // -> Título da consulta
                        TableName : String ;           // -> Nome da tabela
                        aFields : Array Of String ;    // -> Array dos campos
                        aTitles : Array Of String ;    // -> Array dos títulos das colunas
                        RetField : Integer = 0 ;       // -> Campo para retorno
                        RetComp : TWinControl = Nil ;  // -> Controle a receber o retorno
                        RetField2 : Integer = 0 ;      // -> Segundo campo para retorno
                        RetComp2 : TWinControl = Nil ; // -> Segundo controle p/ retorno
                        Sql : String = '' ;            // -> Sql de pesquisa
                        DBName : String = ''           // -> DatabaseName
                      ) ;
Var
   T, H, L, i, ColWidth : Integer ;
Begin

   VarForm  := F ;
   VarSql   := Sql ;

   If ( RetComp = Nil ) Then
       VarComp := F.ActiveControl
   Else
       VarComp := RetComp ;

   If ( VarComp Is TEdit ) Then
       VarType := TYPE_EDIT
   Else If ( VarComp Is TMaskEdit ) Then
       VarType := TYPE_MASK
   Else If ( VarComp Is TrsSuperEdit ) Then
       VarType := TYPE_SEDIT ;

   VarComp2 := RetComp2 ;
   If ( VarComp2 Is TEdit ) Then
       VarType2 := TYPE_EDIT
   Else If ( VarComp2 Is TMaskEdit ) Then
       VarType2 := TYPE_MASK
   Else If ( VarComp2 Is TrsSuperEdit ) Then
       VarType2 := TYPE_SEDIT ;
   VarRetField2 := RetField2 ;

   Case VarType Of
       TYPE_EDIT : Begin
           T := (VarComp As TEdit).Top ;
           L := (VarComp As TEdit).Left ;
           H := (VarComp As TEdit).Height ;
       End ;
       TYPE_MASK : Begin
           T := (VarComp As TMaskEdit).Top ;
           L := (VarComp As TMaskEdit).Left ;
           H := (VarComp As TMaskEdit).Height ;
       End ;
       TYPE_SEDIT : Begin
           T := (VarComp As TrsSuperEdit).Top ;
           L := (VarComp As TrsSuperEdit).Left ;
           H := (VarComp As TrsSuperEdit).Height ;
       End ;
       Else
           T := 0 ;
           L := 0 ;
           H := 0 ;
   End ;

   VarTop    := F.Top + T + H + 25 ;
   VarLeft   := F.Left + L + 4 ;

   If ( DBName <> '' ) Then
       VarDBName := DBName ;
   VarTableName := TableName ;
   VarNumFields := Length(aFields) ;
   VarRetField := RetField ;

   SetLength(VarFields,VarNumFields) ;
   For i:=0 To VarNumFields-1 Do
       VarFields[i] := aFields[i] ;

   SetLength(VarTitles,VarNumFields) ;
   For i:=0 To VarNumFields-1 Do
       VarTitles[i] := aTitles[i] ;

   FormConsTab := TFormConsTab.Create(Application) ;
   FormConsTab.Grid.Visible := False ;
   FormConsTab.LabTitulo.Caption := Title ;

   If ( VarSql = '' ) Then
       VarSql := GetSqlSelect ;
   FormConsTab.QCons.DatabaseName := VarDBName ;
   FormConsTab.QCons.Close ;
   FormConsTab.QCons.Sql.Clear ;
   FormConsTab.QCons.Sql.Add(VarSql) ;
   FormConsTab.QCons.Open ;

   VarWidth := 0 ;
   SetLength(VarColWid,VarNumFields) ;
   For i:=0 To VarNumFields-1 Do
   Begin
       If ( VarFields[i] = '' ) Then
           Continue ;
       ColWidth := (FormConsTab.QCons.FieldByName(VarFields[i]).DisplayWidth * 8) ;
       If ( ColWidth < Length(VarTitles[i]) ) Then
           ColWidth := Length(VarTitles[i]) + 2 ;
       If ( ColWidth <= 16 ) Then
           ColWidth := 25 ;
       VarWidth := VarWidth + ColWidth ;
       VarColWid[i] := ColWidth ;
   End ;
   VarWidth  := VarWidth + 65 ;
   If ( VarWidth > F.Width ) Then
      VarWidth := F.Width - 10 ;
   If ( (VarWidth + L) > F.Width ) Then
      VarLeft := F.Width - VarWidth - 10 ;
   If ( VarLeft < F.Left ) Then
      VarLeft := F.Left + 10 ;

   VarHeight := F.Height - T - H - 75 ;

(*
   If ( (VarWidth + VarLeft) > F.Width ) Then
      VarLeft := F.Width - VarWidth ;
   If ( (VarHeight + VarTop) > F.Height ) Then
      VarTop := F.Height - VarHeight ;
*)

   Try
       FormConsTab.SetGrid ;
       FormConsTab.ShowModal ;
   Finally
       FormConsTab.Release ;
   End ;

End ;

procedure TFormConsTab.FormShow(Sender: TObject);
begin

   If ( VarHeight <= 137 ) Then
   Begin
       VarTop    := VarTop - 100 ;
       VarHeight := 284 ;
   End ;
   If ( VarHeight <= 284 ) Then
       VarHeight := 284 ;

   FormConsTab.Width  := VarWidth ;
   FormConsTab.Height := VarHeight ;
   FormConsTab.Left   := VarLeft ;
   FormConsTab.Top    := VarTop ;

   LabTitulo.Width := FormConsTab.Width - 30 ;
   LabTitulo.Top  := 8 ;
   LabTitulo.Left := 12 ;

   PanLinha.Height := 3 ;
   PanLinha.Width := FormConsTab.Width - 22 ;
   PanLinha.Left := 8 ;
   PanLinha.Top  := LabTitulo.Height + 11 ;

   Grid.Height := PanFundo.Height - LabTitulo.Height - ButOk.Height - 70 ;
   Grid.Width := PanLinha.Width - 4 ;
   Grid.Left := 10 ;
   Grid.Top  := PanLinha.Top + 8 ;

   LabPesq.Top := Grid.Top + Grid.Height + 9 ;
   LabPesq.Left := Grid.Left  ;

   EdiPesq.Width := Grid.Width - LabPesq.Width - 10 ;
   EdiPesq.Left := LabPesq.Left + LabPesq.Width + 10 ;
   EdiPesq.Top := LabPesq.Top - 3 ;

   ButOk.Top := EdiPesq.Top + EdiPesq.Height + 9 ;
   ButOk.Left := Trunc(Grid.Width/2) - 5 - ButOk.Width ;
   ButCancelar.Top := ButOk.Top ;
   ButCancelar.Left := ButOk.Left + 115 ;

   EdiPesq.SetFocus ;

end;

Procedure ConsTab_SetDBName ( Value : String ) ;
Begin
    VarDBName := Value ;
End ;

Procedure TFormConsTab.ButOkClick(Sender: TObject);
begin
   With VarForm Do
   Begin
       Try
         Case VarType Of
               TYPE_EDIT   : (VarComp As TEdit).Text := FormConsTab.QCons.Fields[VarRetField].AsVariant ;
               TYPE_MASK   : (VarComp As TMaskEdit).Text := FormConsTab.QCons.Fields[VarRetField].AsVariant ;
               TYPE_SEDIT  : (VarComp As TRsSuperEdit).Text := FormConsTab.QCons.Fields[VarRetField].AsVariant ;
         End ;
       Except
       End ;
       If ( VarRetField2 <> 0 ) Then
       Begin
           Try
             Case VarType2 Of
                 TYPE_EDIT   : (VarComp2 As TEdit).Text := FormConsTab.QCons.Fields[VarRetField2].AsVariant ;
                 TYPE_MASK   : (VarComp2 As TMaskEdit).Text := FormConsTab.QCons.Fields[VarRetField2].AsVariant ;
                 TYPE_SEDIT  : (VarComp2 As TRsSuperEdit).Text := FormConsTab.QCons.Fields[VarRetField2].AsVariant ;
             End ;
           Except
           End ;
       End ;
   End ;
   Close ;
end;

procedure TFormConsTab.ButCancelarClick(Sender: TObject);
begin
   Close ;
end;

Procedure TFormConsTab.SetGrid ;
Var
   i : Integer ;
Begin
   For i:=0 To VarNumFields-1 Do
   Begin
       If ( VarTitles[i] = '' ) Then
           Continue ;
       Grid.Columns.Add ;
       Grid.Columns[i].FieldName := VarFields[i] ;
       Grid.Columns[i].Width := VarColWid[i] ;
       Grid.Columns[i].Title.Caption := VarTitles[i] ;
   End ;
   VarFind := '' ;
   Grid.Visible := True ;
End ;

(* ------------------------------------------------------------------------- *
 * GetSqlSelect -> Devolve o comando sql de SELECT * FROM ...                *
(* ------------------------------------------------------------------------- *)
Function GetSqlSelect : String  ;
Var
   Sql : String ;
   i : Integer ;
Begin
   Result := '' ;
   If ( VarNumFields = 0 ) Then
       Exit ;
   Sql := 'Select ' ;
   For i:=0 To VarNumFields-1 Do
   Begin
       If ( VarFields[i] = '' ) Then
           Continue ;
       Sql := Sql + VarFields[i] + ', ' ;
   End ;
   Sql := Copy(Sql,1,Length(Sql)-2) ;
   Sql := Sql + ' From ' + VarTableName ;
   Sql := Sql + ' Order By ' + VarFields[0] ;
   Result := Sql ;
End ;

procedure TFormConsTab.GridColEnter(Sender: TObject);
begin
   VarFind := '' ;
end;

procedure TFormConsTab.EdiPesqKeyPress(Sender: TObject; var Key: Char);
Var
   Col : Integer ;
begin
   If ( Key = #8 ) Then
       VarFind := Copy(VarFind,1,Length(VarFind)-1)
   Else
       VarFind := VarFind + Key ;
   VarFind := UpperCase(VarFind) ;
   Col := Grid.SelectedIndex ;
   FormConsTab.QCons.Locate(VarFields[Col],VarFind,[loPartialKey]) ;
end;

procedure TFormConsTab.GridKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   If ( (Key = 80) And (Shift = [ssAlt]) ) Then
       EdiPesq.SetFocus ;
end;

procedure TFormConsTab.GridTitleClick(Column: TColumn);
Var
   Sql : String ;
   p : Integer ;
begin
   Sql := VarSql ;
   p := Pos('Order By',Sql) ;
   If ( p <> 0 ) Then
      Sql := Copy(Sql,1,p-1) ;
   Sql := Sql + ' Order By ' + Column.FieldName ;
   FormConsTab.QCons.Close ;
   FormConsTab.QCons.Sql.Clear ;
   FormConsTab.QCons.Sql.Add(Sql) ;
   FormConsTab.QCons.Open ;
end;

Function ConsTab_GetQCons : TQuery ;
Begin
   Result := FormConsTab.QCons ;
End ;

end.

