//---------------------------------------------------------------------------
#include <vcl\vcl.h>
#pragma hdrstop

#include "Mdiedita.h"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TMdiAbout *MdiAbout;
//---------------------------------------------------------------------------
__fastcall TMdiAbout::TMdiAbout(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TMdiAbout::Button1Click(TObject *Sender)
{
  Close();    
}
//---------------------------------------------------------------------------

