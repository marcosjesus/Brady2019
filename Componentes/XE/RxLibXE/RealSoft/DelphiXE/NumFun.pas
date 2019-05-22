unit NumFun;

interface

Uses
     SysUtils, Windows ;

function  Num_HextoInt(Hex : String) : Longint; Export ;
function  Num_base36toint(str36: String): smallint; Export ;
function  Num_inttobase( number : longint; base : byte) : string; Export ;
function  Num_inttostrZ(value, zeroes: integer): string; Export ;
function  Num_Pow( base, expon : double ) : double; Export ;
function  Num_Pow10(n: Double): Double; Export ;
function  Num_Floor(E: Extended):  Longint; Export ;
function  Num_Ceiling(E: Extended):  Longint; Export ;
function  Num_TrueRound(number : extended; decimals : smallint) : extended; Export ;
function  Num_TrueRoundAuto(number : extended) : longint; Export ;
function  Num_RoundDigits(number : double; digits : smallint) : double; Export ;
function  Num_RoundCents(value : double) : double; Export ;
function  Num_RoundDollars(value : double) : double; Export ;
function  Num_RoundDollarsDown(value : double) : double; Export ;

implementation

function Num_HextoInt(Hex : String) : Longint;
var
  i : byte;
  e : longint;
  function ZeroToF(c : char) : byte;
  begin
    case c of
      '0' : result:= 0;
      '1' : result:= 1;
      '2' : result:= 2;
      '3' : result:= 3;
      '4' : result:= 4;
      '5' : result:= 5;
      '6' : result:= 6;
      '7' : result:= 7;
      '8' : result:= 8;
      '9' : result:= 9;
      'a','A' : result:= 10;
      'b','B' : result:= 11;
      'c','C' : result:= 12;
      'd','D' : result:= 13;
      'e','E' : result:= 14;
      'f','F' : result:= 15;
      else result:= 0;
      end;
  end;
begin
  result:= 0; e:= 1;
  for i:= length(Hex) downto 1 do begin
    result:= result + ZeroToF(Hex[i])*e;
    e:= e * 16;
    end;
end;

function Num_base36toint(str36: String): smallint;
begin
  Result:= 0;
  if length(str36) > 2 then Exit;
  {first digit}
  if (str36[1] >= 'A') and (str36[1] <= 'Z') then
    Result:= Result + (byte(str36[1]) - byte('A') + 10) * 36
  else Result:= Result + (byte(str36[1]) - byte('0')) * 36;
  {second digit}
  if (str36[2] >= 'A') and (str36[2] <= 'Z') then
    Result:= Result + (byte(str36[2]) - byte('A') + 10)
  else Result:= Result + (byte(str36[2]) - byte('0'));
end;

function Num_inttobase( number : longint; base : byte) : string; {base = 2-36}
var division : longint;
    modulus  : byte;
  function ZeroToZ(b : byte) : char;
  begin
    case b of
      0: result:= '0';
      1: result:= '1';
      2: result:= '2';
      3: result:= '3';
      4: result:= '4';
      5: result:= '5';
      6: result:= '6';
      7: result:= '7';
      8: result:= '8';
      9: result:= '9';
      10: result:= 'A';
      11: result:= 'B';
      12: result:= 'C';
      13: result:= 'D';
      14: result:= 'E';
      15: result:= 'F';
      16: result:= 'G';
      17: result:= 'H';
      18: result:= 'I';
      19: result:= 'J';
      20: result:= 'K';
      21: result:= 'L';
      22: result:= 'M';
      23: result:= 'N';
      24: result:= 'O';
      25: result:= 'P';
      26: result:= 'Q';
      27: result:= 'R';
      28: result:= 'S';
      29: result:= 'T';
      30: result:= 'U';
      31: result:= 'V';
      32: result:= 'W';
      33: result:= 'X';
      34: result:= 'Y';
      35: result:= 'Z';
      else result:= #0;
      end;
  end;
begin
  result:= '';
  if number <= 0 then begin
    result:= '0';
    Exit;
    end;
  if (base > 36) or (base < 2) then Exit;
  division:= number div base;
  modulus:= number mod base;
  while (modulus > 0) or (division >= 1) do begin
    result:= zerotoz(modulus) + result;
    number:= division;
    division:= number div base;
    modulus:= number mod base;
    end;
end;

function Num_IntToStrZ(value, zeroes: integer): string;
begin
  result:= inttostr(value);
  while length(result) < zeroes do result:= '0' + result;
end;

function Num_Pow( base, expon : double ) : double;
begin
  Result:= Exp(expon*(ln(base)));
end;

function Num_Pow10(n: Double): Double;
begin
  Result:=Exp(n * Ln(10));
end;

function Num_Floor(E: Extended): Longint;
begin
  if E > 0 then Result:= trunc(E) else Result:= round(E);
end;

function Num_Ceiling(E: Extended): Longint;
begin
  if E > 0 then Result:= round(E) else Result:= trunc(E);
end;

function Num_TrueRound(number : extended; decimals : smallint) : extended;
begin
  number := number * Num_pow10(decimals);
  number := Num_floor(number);
  number := number / Num_pow10(decimals);
  result:= number;
end;

function Num_TrueRoundAuto(number : extended) : longint;
begin
  Result:= Trunc(Number) + Trunc( Frac(Number) * 2)
end;

function Num_RoundDigits(number : double; digits : smallint) : double;
begin
  number := number * Num_pow10(digits);
  number := Num_TrueRoundAuto(number);
  number := number / Num_pow10(digits);
  result:= number;
end;

function Num_RoundCents(value : double) : double;
begin
  result:= Num_RoundDigits(value+0.005,2);
end;

function Num_RoundDollars(value : double) : double;
begin
  result:= Num_Floor(value+0.5);
end;

function Num_RoundDollarsDown(value : double) : double;
begin
  result:= Num_Floor(value-0.5);
end;

end.
