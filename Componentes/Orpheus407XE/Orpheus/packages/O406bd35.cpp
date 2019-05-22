/* ***** BEGIN LICENSE BLOCK *****                                            */
/* Version: MPL 1.1                                                           */
/*                                                                            */
/* The contents of this file are subject to the Mozilla Public License Version*/
/* 1.1 (the "License"); you may not use this file except in compliance with   */
/* the License. You may obtain a copy of the License at                       */
/* http://www.mozilla.org/MPL/                                                */
/*                                                                            */
/* Software distributed under the License is distributed on an "AS IS" basis, */
/* WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License   */
/* for the specific language governing rights and limitations under the       */
/* License.                                                                   */
/*                                                                            */
/* The Original Code is TurboPower Orpheus                                    */
/*                                                                            */
/* The Initial Developer of the Original Code is TurboPower Software          */
/*                                                                            */
/* Portions created by TurboPower Software Co. are Copyright (C) 1995-2002    */
/* TurboPower SOftware Co. All Rights Reserved.                               */
/*                                                                            */
/* Contributor(s):                                                            */
/*                                                                            */
/* ***** END LICENSE BLOCK *****                                              */

//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("O406bd35.res");
USEPACKAGE("VCL35.bpi");
USEPACKAGE("VCLX35.bpi");
USEPACKAGE("VCLDB35.bpi");
USEUNIT("OvcDbAE0.pas");
USEUNIT("OvcDbAE1.pas");
USEUNIT("OvcDbAE2.pas");
USEUNIT("OvcDbAe3.pas");
USEUNIT("OvcDbHBD.pas");
USEUNIT("Ovcdbtb0.pas");
USEUNIT("OvcDbTb1.pas");
USEUNIT("OvcRegBD.pas");
USEUNIT("OvcRegDb.pas");
USEPACKAGE("O406br35.bpi");
USEPACKAGE("O406_r35.bpi");
USEPACKAGE("O406_d35.bpi");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
  return 1;
}
//---------------------------------------------------------------------------
