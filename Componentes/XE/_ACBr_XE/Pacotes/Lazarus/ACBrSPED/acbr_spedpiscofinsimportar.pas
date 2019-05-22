{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ACBR_SPEDPisCofinsImportar;

interface

uses
  ACBrSpedPCImportar, ACBrSpedPCImportar_Base, ACBrSpedPCImportar_Bloco0, 
  ACBrSpedPCImportar_Bloco1, ACBrSpedPCImportar_BlocoA, 
  ACBrSpedPCImportar_BlocoC, ACBrSpedPCImportar_BlocoD, 
  ACBrSpedPCImportar_BlocoF, ACBrSpedPCImportar_BlocoI, 
  ACBrSpedPCImportar_BlocoM, ACBrSpedPCImportar_BlocoP, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ACBrSpedPCImportar', @ACBrSpedPCImportar.Register);
end;

initialization
  RegisterPackage('ACBR_SPEDPisCofinsImportar', @Register);
end.
