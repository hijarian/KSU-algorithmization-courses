{
 Код для задачи 02.
 Используется в юнит-тестах, поэтому вынесен в отдельный модуль.
}
unit L02Code;

interface

function CalcSum(x: real; n: integer) : real;

implementation

uses
  Math;

function CalcSum(x: real; n: integer) : real;
var
  Sum: real;
  i: integer;
begin
  Sum := 0;
  for i := 1 to n do begin
    Sum := Sum + (sqr(abs(x-i)) * sqrt(exp(i-1)) / (ln(2+power(x,i)) + power(x, (2*i+1))));
  end;
  Sum := Sum*exp(sqrt(x/n));
end;

initialization
end.
