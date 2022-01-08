unit Excel;

interface

uses Windows, Activex;

// originally from Excel97.pas
// XlFileFormat constants
type
  XlFileFormat = TOleEnum;
const
  xlAddIn = $00000012;
  xlCSV = $00000006;
  xlCSVMac = $00000016;
  xlCSVMSDOS = $00000018;
  xlCSVWindows = $00000017;
  xlDBF2 = $00000007;
  xlDBF3 = $00000008;
  xlDBF4 = $0000000B;
  xlDIF = $00000009;
  xlExcel2 = $00000010;
  xlExcel2FarEast = $0000001B;
  xlExcel3 = $0000001D;
  xlExcel4 = $00000021;
  xlExcel5 = $00000027;
  xlExcel7 = $00000027;
  xlExcel9795 = $0000002B;
  xlExcel4Workbook = $00000023;
  xlIntlAddIn = $0000001A;
  xlIntlMacro = $00000019;
  xlWorkbookNormal = $FFFFEFD1;
  xlSYLK = $00000002;
  xlTemplate = $00000011;
  xlCurrentPlatformText = $FFFFEFC2;
  xlTextMac = $00000013;
  xlTextMSDOS = $00000015;
  xlTextPrinter = $00000024;
  xlTextWindows = $00000014;
  xlWJ2WD1 = $0000000E;
  xlWK1 = $00000005;
  xlWK1ALL = $0000001F;
  xlWK1FMT = $0000001E;
  xlWK3 = $0000000F;
  xlWK4 = $00000026;
  xlWK3FM3 = $00000020;
  xlWKS = $00000004;
  xlWorks2FarEast = $0000001C;
  xlWQ1 = $00000022;
  xlWJ3 = $00000028;
  xlWJ3FJ3 = $00000029;
  xlExcel12 =50;
  xlExcel8 = 56;
  xlHtml = 44;
  xlOpenXMLAddIn = 55;
  xlOpenXMLTemplate = 54;
  xlOpenXMLTemplateMacroEnabled = 53;
  xlOpenXMLWorkbook = 51;
  xlOpenXMLWorkbookMacroEnabled = 52;
  xlTemplate8 = 17;
  xlUnicodeText = 42;
  xlWebArchive = 45;
  xlWorkbookDefault = 51;
  xlXMLSpreadsheet = 46;

implementation

end.

