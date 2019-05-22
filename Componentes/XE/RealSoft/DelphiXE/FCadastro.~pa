unit FCadastro ;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, StdCtrls, ExtCtrls, Mask, rsEdit,
  Buttons, SqlTableFun, rsFlyovr, RseditDB ;

type
  TFrmCadastro = class(TForm)
    PanFundo: TPanel;
    PanTitulo: TPanel;
    ToolBar: TToolBar;
    ButSair: TrsFlyOverButton;
    ButImprimir: TrsFlyOverButton;
    ButExcluir: TrsFlyOverButton;
    ButAlterar: TrsFlyOverButton;
    ButNovo: TrsFlyOverButton;
    LabCadTit: TLabel;
    TimerCad: TTimer;
    EdiDatabaseName: TEdit;
    EdiKeyValue: TrsDBSuperEdit;
    ImaBarraSup: TImage;
    ButEscape: TrsFlyOverButton;
    ButCancelar: TrsFlyOverButton;
    ToolButton1: TToolButton;
    ButSalvar: TrsFlyOverButton;
    ButPesquisar: TrsFlyOverButton;
    ButInvOk: TButton;
    ButInvCanc: TButton;
    procedure ButVoltarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ButNovoClick(Sender: TObject);
    procedure ButAlterarClick(Sender: TObject);
    procedure ButExcluirClick(Sender: TObject);
    procedure ButPesquisarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure TimerCadTimer(Sender: TObject);
    procedure ButImpClick(Sender: TObject);
    procedure ButSairClick(Sender: TObject);
    Procedure ControlSetFocus ( C : TWinControl ) ;
    procedure ButEscapeClick(Sender: TObject);
    Procedure OnOffConf ( Value : Boolean ) ;
    procedure ButSalvarClick(Sender: TObject);
    procedure ButCancelarClick(Sender: TObject);
  private
    { Private declarations }
    FormNumAltKey : Integer ;
    FormVetAltKey : Array of TComponent ;
    Procedure FillAltKey ;
    Function TranslateMens ( Mens : String ) : String ;
  public
    { Public declarations }
    Tab : TSqlTable ;
    VarOperacao : Byte ;
    FormCheck : Boolean ;
    aFields : Array Of String ;
    aControlFld : Array Of TWinControl ;
    WinFocus : TWinControl ;
    DataFocus : TWinControl ;
    NumFields : Integer ;
    FormOperacao : String ;
    FormTabela : String ;
    FormChaves : String ;
    FormCtrlFocus : String ;
    FormDataFocus : String ;
    FormOpeErro : Boolean ;
    FormMensInc : String ;
    FormMensAlt : String ;
    FormMensExc : String ;
    FormExecCommit : Boolean ;
    FormExecScape : Boolean ;
    FormValueKey : String ;
    FormAlterou : Boolean ;
    Procedure Search ; Virtual ;
    Procedure Scape ;  Virtual ;
    Procedure Exclui ; Virtual ;
    Procedure Altera ; Virtual ;
    Procedure Inclui ; Virtual ;
    Procedure Novo ; Virtual ;
    Procedure Imprime ; Virtual ;
    Procedure FillForm ( bValues : Boolean ) ; Virtual ;
    Function Check : Boolean ; Virtual ;
    Procedure GetDesc ; Virtual ;
  end;

var
  FrmCadastro: TFrmCadastro;

implementation

{$R *.DFM}

Uses
   Global, StrFun, ObjFun, MensFun, TestFun, ConsTabFun, Constantes ;

Const

   TAG_FIELD    = -1 ;
   TAG_KEY      = -2 ;
   TAG_ESPCOMBO = -3 ;
   TAG_ALT_KEY  = -4 ;

procedure TFrmCadastro.FormCreate(Sender: TObject);
Var
    i : Integer ;
begin

   Left   := GFormLeft ;
   Top    := GFormTop ;
   Height := GFormHeight ;
   Width  := GFormWidth ;

   Tab := TSqlTable.Create ;
   EdiDatabaseName.Text := GDatabase ;

   NumFields := Str_GetNumOccur(FormChaves,';') + 1 ;
   SetLength(aFields,NumFields) ;
   SetLength(aControlFld,NumFields) ;
   For i:=0 To NumFields-1 Do
       aFields[i] := Str_GetToken(FormChaves,';',i+1) ;

   FormMensInc := 'Registro incluído com sucesso' ;
   FormMensAlt := 'Registro alterado com sucesso' ;
   FormMensExc := 'Registro excluído com sucesso' ;
   FormValueKey := '' ;

   OnOffConf(False) ;

end;

procedure TFrmCadastro.FormShow(Sender: TObject);
Var
    i : Integer ;
begin

   If ( Not Tab.OpenTable(FormTabela) ) Then
   Begin
       Mens_MensErro(Tab.GetMensErro) ;
       Tag := -1 ;
       TimerCad.Enabled := True ;
   End ;

   For i:=0 To NumFields-1 Do
       Tab.SetFieldKey(aFields[i]) ;

   FormCheck := False ;

   For i:=0 To NumFields-1 Do
   Begin
       WinFocus := TWinControl(Obj_FindControlByTagName(Self,aFields[i])) ;
       aControlFld[i] := WinFocus ;
   End ;
   WinFocus := TWinControl(Obj_FindControlByName(Self,FormCtrlFocus)) ;
   If ( WinFocus <> Nil ) Then
       ControlSetFocus(WinFocus) ;
   DataFocus := TWinControl(Obj_FindControlByName(Self,FormDataFocus)) ;

   Obj_SetCompsVisible(Self,-1,False) ;

   // Identificar o DatabaseName para as consultas
   ConsTab_SetDBName(GDatabase) ;

   FormExecCommit := True ;
   FormExecScape  := True ;
   FormAlterou   := False ;

   // -- Testar se é para abrir um registro automaticamente
   If ( FormValueKey <> '' ) Then
   Begin
      TEdit(WinFocus).Text := FormValueKey ;
      Search() ;
   End ;

end;

procedure TFrmCadastro.FormActivate(Sender: TObject);
begin
   If ( Not Glob_GetAccess(FormOperacao,'') ) Then
   Begin
       Mens_MensInf('Operação não liberada para o usuário') ;
       Tag := -1 ;
       TimerCad.Enabled := True ;
   End ;
end;

procedure TFrmCadastro.FormDestroy(Sender: TObject);
begin
   Tab.Destroy ;
end;

procedure TFrmCadastro.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   Case Key Of
       33 : Begin
               If ( Tab.Prior() ) Then
               Begin
                  Tab.SetFormObjValue(Nil,TAG_KEY) ;
                  FillForm(True) ;
               End ;
       End ;
       34 : Begin
               If ( Tab.Next() ) Then
               Begin
                  Tab.SetFormObjValue(Nil,TAG_KEY) ;
                  FillForm(True) ;
               End ;
       End ;
       27 : Begin
            If ( ButCancelar.Visible ) Then     // Alt + Esc
            Begin
               ButCancelarClick(Self) ;
            End
            Else Begin
               Scape ;
            End ;
       End ;
       46 : Begin
               If ( Shift = ([ssCtrl]) ) Then
                  Exclui ;
       End ;
       13 : Begin
            If ( (ButSalvar.Visible) And (Shift = ([ssCtrl])) ) Then     // Ctrl + Enter
            Begin
               ButSalvarClick(Self) ;
            End
            Else Begin
               If ( (Screen.ActiveControl.Tag = -1) And
                    ( Not ( (Key = 80) And (Shift = ([ssAlt])) ) ) // Alt+P
                  ) Then
                  FormAlterou := True
               Else
                  FormAlterou := False ;
            End ;
       End ;
       // -- Teste de pesquisa
   End ;
End ;

Procedure TFrmCadastro.ControlSetFocus ( C : TWinControl ) ;
Var
    CompParent : TComponent ;
Begin
    CompParent := TPanel( TEdit(TEdit(C)).Parent ).Parent ;
    If ( CompParent Is TTabSheet ) Then
      TPageControl( TTabSheet(CompParent).Parent ).ActivePage := TTabSheet(CompParent) ;
    If ( TEdit(C).Enabled And TEdit(C).Visible ) Then
       TEdit(C).SetFocus ;
End ;

Procedure TFrmCadastro.FillAltKey ;
Var
    i : Integer ;
Begin
    FormNumAltKey := 0 ;
    For i:=0 To Self.ComponentCount-1 Do
  		If ( Self.Components[i].Tag = TAG_ALT_KEY ) Then
       Begin
          FormNumAltKey := FormNumAltKey + 1 ;
          SetLength(FormVetAltKey,FormNumAltKey) ;
          FormVetAltKey[FormNumAltKey] := Self.Components[i] ;
       End ;
End ;

Procedure TFrmCadastro.Scape ;
Var
   i : Integer ;
Begin

   If ( Not FormExecScape ) Then
   Begin
      FormExecScape := True ;
      Exit ;
   End ;

   If ( (FormAlterou) And ( (VarOperacao = OPE_ALTERACAO) Or (VarOperacao = OPE_INCLUSAO) ) ) Then
   Begin
      If ( Mens_MensConf('Deseja cancelar as alterações ?') <> mrOk ) Then
         Exit ;
   End;
   FormAlterou := False ;

   VarOperacao := OPE_ESCAPE ;
   For i:=0 To NumFields-1 Do
   Begin
      If ( Test_IsEmptyStr(TEdit(aControlFld[i]).Text) ) Then
      Begin
          Close ;
          Exit ;
      End ;
   End ;

   FormCheck := False ;
   Obj_SetCompsEmpty(Self,0) ;
   Obj_SetCompsEnable(Self,-2,True) ;
   Obj_SetCompsVisible(Self,-1,False) ;
   Obj_SetNullInFormObj(Self,-3) ;

   OnOffConf(False) ;

   ControlSetFocus(WinFocus) ;

End ;

Procedure TFrmCadastro.Exclui ;
Var
   aKey : Array Of Variant ;
   i : Integer ;
Begin
// ----- Exclusão
   FormOpeErro := True ;
   If ( Mens_MensConf('Confirme a exclusão ?') = mrOk ) Then
   Begin
       SetLength(aKey,NumFields) ;
       For i:=0 To NumFields-1 Do
          aKey[i] := TEdit(aControlFld[i]).Text ;
       Tab.SetKey(aKey) ;
       If ( Not Tab.Delete() ) Then
       Begin
           Mens_MensErro(Tab.GetMensErro) ;
           If ( Tab.GetNumErro() = ERRO_REC_MODIFIED ) Then
              Search() ;
       End
       Else Begin
           If ( FormExecCommit ) Then
           Begin
              If ( Tab.GetTransCount() > 0 ) Then
              Begin
                 If ( Not Tab.ExecCommit() ) Then
                 Begin
                    Mens_MensErro(Tab.GetMensErro()) ;
                    Mens_MensInf('Erro executando o Commit') ;
                 End ;
              End ;
           End ;
           Mens_MensInf(FormMensExc) ;
           FormOpeErro := False ;
           Scape ;
       End ;
       FormAlterou   := False ;
   End ;
end;

Procedure TFrmCadastro.Inclui ;
Begin
// ----- Inclusão
   FormOpeErro := True ;
   If ( Not Check() ) Then
       Exit ;
   If ( Mens_MensConf('Confirma a inclusão ?') = mrOk ) Then
   Begin
       If ( Not Tab.FormSetFieldValue(Self,0) ) Then
          Mens_MensInf('Problemas no preenchimento dos campos para atualização')
       Else Begin
          If ( Not Tab.Insert ) Then
          Begin
              Mens_MensErro(Tab.GetMensErro) ;
              VarOperacao := OPE_ALTERACAO ;
              If ( Tab.GetNumErro() = ERRO_KEYVIOLATION ) Then
                  Search ;
          End
          Else Begin
              If ( FormExecCommit ) Then
              Begin
                 If ( Tab.GetTransCount() > 0 ) Then
                 Begin
                    If ( Not Tab.ExecCommit() ) Then
                    Begin
                       Mens_MensErro(Tab.GetMensErro()) ;
                       Mens_MensInf('Erro executando o Commit') ;
                    End ;
                 End ;
              End ;
              FormMensInc := TranslateMens(FormMensInc) ;
              Mens_MensInf(FormMensInc) ;
              FormAlterou := False ;
              FormOpeErro := False ;
              Scape ;
          End ;
       End ;
       FormAlterou := False ;
   End ;
   OnOffConf(False) ;
End ;

Procedure TFrmCadastro.Altera ;
Begin
// ----- Alteração
   FormOpeErro := True ;
   If ( Not Check() ) Then
       Exit ;
   If ( Mens_MensConf('Confirma as alterações ?') = mrOk ) Then
   Begin
       If ( Not Tab.FormSetFieldValue(Self,-1) ) Then
          Mens_MensInf('Problemas no preenchimento dos campos para atualização')
       Else Begin
         If ( Not Tab.Update ) Then
         Begin
             Mens_MensErro(Tab.GetMensErro) ;
             If ( Tab.GetNumErro() = ERRO_REC_MODIFIED ) Then
                Search() ;
         End
         Else Begin
             If ( FormExecCommit ) Then
             Begin
                If ( Tab.GetTransCount() > 0 ) Then
                Begin
                   If ( Not Tab.ExecCommit() ) Then
                   Begin
                      Mens_MensErro(Tab.GetMensErro()) ;
                      Mens_MensInf('Erro executando o Commit') ;
                   End ;
                End ;
             End ;
             Mens_MensInf(FormMensAlt) ;
             FormOpeErro := False ;
             FormAlterou := False ;
             Scape ;
         End ;
         FormAlterou   := False ;
       End ;
   End ;
   OnOffConf(False) ;
End ;

Procedure TFrmCadastro.Novo ;
Begin
   FormOpeErro := True ;
   If ( Not Glob_GetAccess(FormOperacao,'I') ) Then
   Begin
       Mens_MensInf('Operação não liberada para o usuário') ;
       Exit ;
   End ;
   VarOperacao := OPE_INCLUSAO ;
   Obj_SetCompsEmpty(Nil,0) ;
   Obj_SetNullInFormObj(Self,-3) ;
   Obj_SetCompsVisible(Self,-1,True) ;
   Obj_SetCompsEnable(Self,-2,True) ;
   TEdit(WinFocus).Enabled := True ;
   ControlSetFocus(WinFocus) ;
   FormCheck := True ;
   FormOpeErro := False ;
End ;

Procedure TFrmCadastro.Search ;
Var
   aKey : Array Of Variant ;
   i : Integer ;
Begin
// ----- Pesquisa
   FormOpeErro := True ;

   If ( Not Test_IsEmptyStr(TEdit(WinFocus).Text) ) Then
   Begin
     SetLength(aKey,NumFields) ;
     For i:=0 To NumFields-1 Do
        aKey[i] := TEdit(aControlFld[i]).Text ;
     If ( NumFields > 0 ) Then
        Tab.SetKey(aKey) ;
     If ( Tab.Find(True) ) Then
     Begin
         Obj_SetCompsVisible(Self,-1,True) ;
         VarOperacao := OPE_ALTERACAO ;
         Obj_SetCompsEnable(Self,-2,False) ;
         Obj_SetCompsEnable(FrmCadastro,-1,True) ;
         FillForm(True) ;
         ControlSetFocus(DataFocus) ;
         FormCheck := True ;
         FormOpeErro := False ;
     End
     Else Begin
         Mens_MensInf(Tab.GetMensErro()) ;
         Mens_MensInf('Registro não encontrado') ;
         VarOperacao := OPE_ESCAPE ;
         TEdit(WinFocus).Enabled := True ;
         ControlSetFocus(WinFocus) ;
         FormOpeErro := True ;
     End ;
     Exit ;
   End ;

   FillAltKey() ;
   If ( FormNumAltKey <> 0 ) Then
   Begin
     SetLength(aKey,FormNumAltKey) ;
     For i:=0 To FormNumAltKey-1 Do
        aKey[i] := TEdit(FormVetAltKey[i]).Text ;
     Tab.SetKey(aKey) ;
     If ( Tab.Find(True) ) Then
     Begin
         Obj_SetCompsVisible(Self,-1,True) ;
         FillForm(True) ;
         VarOperacao := OPE_ALTERACAO ;
         Obj_SetCompsEnable(Self,-2,False) ;
         ControlSetFocus(DataFocus) ;
         FormCheck := True ;
     End
     Else Begin
         Mens_MensInf('Registro não encontrado') ;
         VarOperacao := OPE_ESCAPE ;
         TEdit(WinFocus).Enabled := True ;
         ControlSetFocus(WinFocus) ;
         FormCheck := False ;
         FormOpeErro := True ;
     End ;
     Exit ;
   End ;

End ;

Procedure TFrmCadastro.Imprime ;
Begin
// ----- Imprimir
End ;

Function TFrmCadastro.Check : Boolean ;
Var
    i : Integer ;
    Comp, CompParent : TComponent ;
    ValInt : Integer ;
    ValDoub : Double ;
Begin
    Result := False ;
    For i:=0 To Self.ComponentCount-1 Do
    Begin
       Comp := Self.Components[i] ;
       If ( Not (Comp Is TrsSuperEdit) ) Then
          Continue ;
       If ( Not TrsSuperEdit(Comp).CT_Test ) Then
          Continue ;
       If ( Not TrsSuperEdit(Comp).Visible ) Then
          Continue ;
       CompParent := TPanel( TrsSuperEdit(Comp).Parent ).Parent ;
       Case TrsSuperEdit(Comp).Format Of
          foCurrency ,
          foReal     : Begin
             ValDoub := Str_MoneyToFloat(TrsSuperEdit(Comp).Text) ;
             If ( (ValDoub < TrsSuperEdit(Comp).MinValue) Or
                  (ValDoub > TrsSuperEdit(Comp).MaxValue) ) Then
             Begin
                If ( CompParent Is TTabSheet ) Then
                   TPageControl( TTabSheet(CompParent).Parent ).ActivePage := TTabSheet(CompParent) ;
                TrsSuperEdit(Comp).SetFocus ;
                FormOpeErro := True ;
                If ( TrsSuperEdit(Comp).CT_MensErro = '' ) Then
                    Mens_MensInf('Valor fora dos limites permitidos')
                Else
                    Mens_MensInf(TrsSuperEdit(Comp).CT_MensErro) ;
                Exit ;
             End ;
          End ;
          foInteger  : Begin
             ValInt := Str_StrToInt(TrsSuperEdit(Comp).Text) ;
             If ( (ValInt < TrsSuperEdit(Comp).MinValue) Or
                  (ValInt > TrsSuperEdit(Comp).MaxValue) ) Then
             Begin
                If ( TrsSuperEdit(Comp).CT_MensErro = '' ) Then
                    Mens_MensInf('Valor fora dos limites permitidos')
                Else
                    Mens_MensInf(TrsSuperEdit(Comp).CT_MensErro) ;
                FormOpeErro := True ;
                If ( CompParent Is TTabSheet ) Then
                   TPageControl( TTabSheet(CompParent).Parent ).ActivePage := TTabSheet(CompParent) ;
                TrsSuperEdit(Comp).SetFocus ;
                Exit ;
             End ;
          End ;
          foText     : Begin
             If ( TrsSuperEdit(Comp).CT_Search ) Then
             Begin
                If ( Not TrsSuperEdit(Comp).SeekGet() ) Then
                Begin
                    If ( CompParent Is TTabSheet ) Then
                       TPageControl( TTabSheet(CompParent).Parent ).ActivePage := TTabSheet(CompParent) ;
                    TrsSuperEdit(Comp).SetFocus ;
                    Mens_MensInf(TrsSuperEdit(Comp).CT_MensErro) ;
                    FormOpeErro := True ;
                    Exit ;
                End ;
             End ;
             If ( (TrsSuperEdit(Comp).MinValue = -1) And (TrsSuperEdit(Comp).MaxValue = -1) And
                  (Test_IsEmptyStr(TrsSuperEdit(Comp).Text)) ) Then
             Begin
                If ( CompParent Is TTabSheet ) Then
                   TPageControl( TTabSheet(CompParent).Parent ).ActivePage := TTabSheet(CompParent) ;
                TrsSuperEdit(Comp).SetFocus ;
                If ( TrsSuperEdit(Comp).CT_MensErro = '' ) Then
                    Mens_MensInf('Valor não pode ser nulo')
                Else
                    Mens_MensInf(TrsSuperEdit(Comp).CT_MensErro) ;
                FormOpeErro := True ;
                Exit ;
             End ;
          End ;
          foFullDate,
          foDate : Begin
             If ( (TrsSuperEdit(Comp).Text = '  /  /  ') Or (TrsSuperEdit(Comp).Text = '  /  /    ') ) Then
             Begin
                If ( CompParent Is TTabSheet ) Then
                   TPageControl( TTabSheet(CompParent).Parent ).ActivePage := TTabSheet(CompParent) ;
                TrsSuperEdit(Comp).SetFocus ;
                If ( TrsSuperEdit(Comp).CT_MensErro = '' ) Then
                    Mens_MensInf('Data inválida')
                Else
                    Mens_MensInf(TrsSuperEdit(Comp).CT_MensErro) ;
                FormOpeErro := True ;
                Exit ;
             End ;
          End ;
       End ;
    End ;
    Result := True ;
// ----- Check
End ;

procedure TFrmCadastro.ButNovoClick(Sender: TObject);
begin
   If ( Not Glob_GetAccess(FormOperacao,'I') ) Then
   Begin
       Mens_MensInf('Operação não liberada para o usuário') ;
       Exit ;
   End ;
   If ( VarOperacao <> OPE_INCLUSAO ) Then
   Begin
      Novo ;
      If ( Not FormOpeErro ) Then
         OnOffConf(True) ;
   End ;
end;

procedure TFrmCadastro.ButAlterarClick(Sender: TObject);
begin
   If ( Not Glob_GetAccess(FormOperacao,'A') ) Then
   Begin
       Mens_MensInf('Operação não liberada para o usuário') ;
       Exit ;
   End ;
   Search ;
   If ( Not FormOpeErro ) Then
      OnOffConf(True) ;
end;

procedure TFrmCadastro.ButExcluirClick(Sender: TObject);
begin
   If ( Not Glob_GetAccess(FormOperacao,'E') ) Then
   Begin
       Mens_MensInf('Operação não liberada para o usuário') ;
       Exit ;
   End ;
   If ( VarOperacao = OPE_ALTERACAO ) Then
      Exclui
   Else
      Search ;
end;

procedure TFrmCadastro.ButImpClick(Sender: TObject);
begin
   If ( Not Glob_GetAccess(FormOperacao,'I') ) Then
   Begin
       Mens_MensInf('Operação não liberada para o usuário') ;
       Exit ;
   End ;
   Imprime ;
end;

procedure TFrmCadastro.ButPesquisarClick(Sender: TObject);
begin
   Search ;
(*
   If ( Not FormOpeErro ) Then
   Begin
      Obj_SetCompsEnable(FrmCadastro,-1,False) ;
      If ( WinFocus <> Nil ) Then
          ControlSetFocus(WinFocus) ;
   End;
*)   
end;

procedure TFrmCadastro.ButVoltarClick(Sender: TObject);
begin
   Close ;
end;

Procedure TFrmCadastro.GetDesc ;
Var
   i : Integer ;
Begin
   // ----- GetDesc
   For i:=0 To Self.ComponentCount-1 Do
   Begin
       If ( Self.Components[i] Is TrsSuperEdit ) Then
       Begin
           If ( TrsSuperEdit(Self.Components[i]).CT_Search ) Then
           Begin
               TrsSuperEdit(Self.Components[i]).SeekGet() ;
           End ;
       End ;
   End ;
End ;

Procedure TFrmCadastro.FillForm ( bValues : Boolean ) ;
Begin
// ----- FillForm
   If ( bValues ) Then
   Begin
       Tab.SetFormObjValue(Nil,TAG_FIELD) ;
       Tab.SetFormObjValue(Nil,TAG_ALT_KEY) ;
       GetDesc ;
   End
   Else Begin
       Obj_SetCompsEmpty(Nil,0)
   End ;
End ;

procedure TFrmCadastro.TimerCadTimer(Sender: TObject);
begin
   If ( Tag = -1 ) Then
       Close ;
end;

procedure TFrmCadastro.ButSairClick(Sender: TObject);
begin
   ToolBar.SetFocus ;
   If ( (FormAlterou) And ( (VarOperacao = OPE_ALTERACAO) Or (VarOperacao = OPE_INCLUSAO) ) ) Then
   Begin
      If ( Mens_MensConf('Deseja cancelar as alterações ?') <> mrOk ) Then
         Exit ;
   End;
   EdiKeyValue.Text := TrsSuperEdit(WinFocus).Text ;
   Close ;
end;

procedure TFrmCadastro.ButEscapeClick(Sender: TObject);
begin
   Scape() ;
end;

Function TFrmCadastro.TranslateMens ( Mens : String ) : String ;
Var
   p : Integer ;
Begin
   Result := Mens ;
   // -- Testar ID
   p := Pos('#ID',Mens) ;
   If ( p <> 0 ) Then
      Result := Copy(Mens,1,p-1) + Tab.GetFieldValue(aFields[0]) + Copy(Mens,p+3,Length(Mens)) ;
End ;

Procedure TFrmCadastro.OnOffConf ( Value : Boolean ) ;
Begin
   If ( Value ) Then
   Begin
      ButSalvar.Visible    := True ;
      ButCancelar.Visible  := True ;
      ButInvOk.Enabled     := True ;
      ButInvCanc.Enabled   := True ;
      ButNovo.Visible      := False ;
      ButAlterar.Visible   := False ;
      ButExcluir.Visible   := False ;
      ButPesquisar.Visible := False ;
      ButImprimir.Visible  := False ;
      ButEscape.Visible    := False ;
      ButSair.Visible      := False ;
   End
   Else Begin
      ButSalvar.Visible    := False ;
      ButCancelar.Visible  := False ;
      ButInvOk.Enabled     := False ;
      ButInvCanc.Enabled   := False ;
      ButNovo.Visible      := True ;
      ButAlterar.Visible   := True ;
      ButExcluir.Visible   := True ;
      ButPesquisar.Visible := True ;
      ButImprimir.Visible  := True ;
      ButEscape.Visible    := True ;
      ButSair.Visible      := True ;
      VarOperacao          := OPE_ESCAPE ;
   End ;
End ;

procedure TFrmCadastro.ButSalvarClick(Sender: TObject);
begin
   If ( VarOperacao = OPE_INCLUSAO ) Then
      Inclui ;
   If ( VarOperacao = OPE_ALTERACAO ) Then
      Altera ;
end;

procedure TFrmCadastro.ButCancelarClick(Sender: TObject);
begin
   FormCheck := False ;
   Obj_SetCompsEmpty(Self,0) ;
   Obj_SetCompsEnable(Self,-2,True) ;
   Obj_SetCompsVisible(Self,-1,False) ;
   Obj_SetNullInFormObj(Self,-3) ;
   ControlSetFocus(WinFocus) ;
   OnOffConf(False) ;
end;

end.


