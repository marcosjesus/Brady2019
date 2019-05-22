{*********************************************************}
{*                   OVCNFPE.PAS 4.06                    *}
{*********************************************************}

{* ***** BEGIN LICENSE BLOCK *****                                            *}
{* Version: MPL 1.1                                                           *}
{*                                                                            *}
{* The contents of this file are subject to the Mozilla Public License        *}
{* Version 1.1 (the "License"); you may not use this file except in           *}
{* compliance with the License. You may obtain a copy of the License at       *}
{* http://www.mozilla.org/MPL/                                                *}
{*                                                                            *}
{* Software distributed under the License is distributed on an "AS IS" basis, *}
{* WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License   *}
{* for the specific language governing rights and limitations under the       *}
{* License.                                                                   *}
{*                                                                            *}
{* The Original Code is TurboPower Orpheus                                    *}
{*                                                                            *}
{* The Initial Developer of the Original Code is TurboPower Software          *}
{*                                                                            *}
{* Portions created by TurboPower Software Inc. are Copyright (C)1995-2002    *}
{* TurboPower Software Inc. All Rights Reserved.                              *}
{*                                                                            *}
{* Contributor(s):                                                            *}
{*                                                                            *}
{* ***** END LICENSE BLOCK *****                                              *}

{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{.W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

unit OvcNfPe;
  {-Property editor for the picture field component}

interface

uses
  Windows, Classes, Graphics, Forms, Controls, Buttons, StdCtrls,
  {$IFDEF VERSION6} DesignIntf, DesignEditors, {$ELSE} DsgnIntf, {$ENDIF}
  SysUtils, ExtCtrls, OvcConst, OvcData, OvcMisc, OvcStr, OvcBase;

type
  TOvcfrmNumericMask = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    lblMask: TLabel;
    lblMaskEdit: TLabel;
    Bevel1: TBevel;
    lblMaskDescription: TLabel;
    lblMaskList: TLabel;
    lbMask: TListBox;
    edMask: TEdit;
    procedure lbMaskClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  protected
    { Private declarations }
    Ex : TStringList;
  end;

type
  {property editor for numeric picture masks}
  TNumericMaskProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes;
      override;
    function AllEqual: Boolean;
      override;
    procedure Edit;
      override;
  end;


implementation

uses
  OvcNf, OvcAe, OvcTCNum;

{$R *.DFM}


{*** TNumericMaskProperty ***}

type
  TLocalNF = class(TOvcCustomNumericField);

function TNumericMaskProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paMultiSelect]
end;

function TNumericMaskProperty.AllEqual: Boolean;
begin
  Result := True;
end;

procedure TNumericMaskProperty.Edit;
var
  NfPE : TOvcfrmNumericMask;
  I, J : Integer;
  Mask : string;
  C    : TComponent;
begin
  NfPE := TOvcfrmNumericMask.Create(Application);
  try
    with NfPE do begin
      C := TComponent(GetComponent(0));
      if C is TOvcCustomNumericField then
        Mask := TLocalNF(C).PictureMask
      else if C is TOvcNumericArrayEditor then
        Mask := TOvcNumericArrayEditor(C).PictureMask
      else if C is TOvcTCNumericField then
        Mask := TOvcTCNumericField(C).PictureMask;

      J := -1;
      {if only one field is selected select the combo box item}
      {that corresponds to the current mask character}
      if PropCount = 1 then begin
        with NfPE.lbMask do begin
          for I := 0 to Items.Count-1 do begin
            if Items[I] = Mask then begin
              J := I;
              Break;
            end;
          end;
        end;
      end else
        Mask := '';

      {show current mask at top of combo box list}
      edMask.Text := Mask;

      {set explanation text, if any}
      if J >= 0 then begin
        lbMask.ItemIndex := J;
        lblMask.Caption := Ex.Strings[J]
      end else
        lblMask.Caption := '';

      {show the form}
      ShowModal;

      if ModalResult = idOK then begin
        {update all selected components with new mask}
        for I := 1 to PropCount do begin
          C := TComponent(GetComponent(I-1));
          if C is TOvcCustomNumericField then
            TLocalNF(C).PictureMask := edMask.Text
          else if C is TOvcNumericArrayEditor then
            TOvcNumericArrayEditor(C).PictureMask := edMask.Text
          else if C is TOvcTCNumericField then
            TOvcTCNumericField(C).PictureMask := edMask.Text;
        end;
        Modified;
      end;
    end;
  finally
    NfPE.Free;
  end;

end;

procedure TOvcfrmNumericMask.FormCreate(Sender: TObject);
var
  I    : Word;
  S1   : string;
  S    : string;
begin
  Top := (Screen.Height - Height) div 3;
  Left := (Screen.Width - Width) div 2;

  {create a string list for the mask explanation strings}
  Ex := TStringList.Create;

  {load the picture mask strings from the resource file}
  for I := stnmFirst to stnmLast do begin
    {first 20 characters is the sample mask--remaining part}
    {of the string is a short description of the mask}
    S := GetOrphStr(I);
    {trim the left portion and add it to the combo box}
    S1 := Trim(Copy(S, 1, 20));
    lbMask.Items.Add(S1);
    {take the remaining portion of the string, trim it and}
    {add it to the string list}
    S := Trim(Copy(S, 21, 255));
    Ex.Add(S);
  end;
end;

procedure TOvcfrmNumericMask.lbMaskClick(Sender: TObject);
var
  I : Integer;
begin
  I := lbMask.ItemIndex;
  if (I >= 0) and (I < Ex.Count) then begin
    lblMask.Caption := Ex.Strings[I];
    edMask.Text := lbMask.Items[I];
  end else
    lblMask.Caption := '';
end;

procedure TOvcfrmNumericMask.FormDestroy(Sender: TObject);
begin
  {destroy string list}
  Ex.Free;
end;


end.
