unit EditBuscaAux;

interface

uses Windows, Messages, SysUtils, Variants, Classes;

  Function Pal(cOrig:String; nPos:Word; cSep:ShortString):String;

implementation



Function Pal(cOrig:String; nPos:Word; cSep:ShortString):String;
var nCount:Word;
    nAtPos:Word;
begin
  nCount := 1;
  while TRUE do
  begin
    if (nPos = nCount) then
      Result := cOrig
    else
      Result := '';

    nAtPos := Pos(cSep,cOrig);
    if not (nAtPos > 0) then EXIT;
    Result := Copy(cOrig,1,nAtPos-1);
    if nCount = nPos then EXIT;
    cOrig := Copy(cOrig,nAtPos+1,Length(cOrig));
    Inc(nCount);
  end;
end;

end.



