//---------------------------------------------------------------------------
#ifndef OrdNtry2H
#define OrdNtry2H
//---------------------------------------------------------------------------
#include <vcl\Classes.hpp>
#include <vcl\Controls.hpp>
#include <vcl\StdCtrls.hpp>
#include <vcl\Forms.hpp>
#include <vcl\Buttons.hpp>

//---------------------------------------------------------------------------
class TOrdAbout : public TForm
{
__published:	// IDE-managed Components
  TLabel *Label1;
  TLabel *Label2;
  TLabel *Label3;
  TLabel *Label4;
  TLabel *Label5;
    TButton *Button1;
    void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
  __fastcall TOrdAbout(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern TOrdAbout *OrdAbout;
//---------------------------------------------------------------------------
#endif
