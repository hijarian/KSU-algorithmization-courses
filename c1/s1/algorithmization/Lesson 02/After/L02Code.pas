{
 Код для задачи 02.
 Используется в юнит-тестах, поэтому вынесен в отдельный модуль.
}
unit L02Code;

interface

function CalcSum(x: real; n: integer) : real;

function Mymod(k: integer; x: real) : real;
function Mysqre(k: integer) : real;
function Myln(k: integer; x: real) : real;
function MyIteration(k: integer; x: real) : real;

implementation

uses
   Math;

function Mymod(k: integer; x: real) : real;
begin
   result := sqr(abs(x - k));
end;

function Mysqre(k: integer) : real;
begin
   result := sqrt(exp(k - 1));
end;

function Myln(k: integer; x: real) : real;
begin
   result := ln ( 2 + power(x, k)  + power(x, (2*k+1)) );
end;

function MyIteration(k: integer; x: real) : real;
begin
   if (k = 0) and (x = -2) then
      raise EInvalidArgument.Create('if k = 0 and x = -2 then the iteration will divide by zero, it''s not allowed!');

   result := Mymod(k, x) * Mysqre(k) / Myln(k, x);
end;

function CalcSum(x: real; n: integer) : real;
var
   Sum: real;
   i: integer;
begin
   Sum := 0;
   for i := 1 to n do begin
      Sum := Sum + MyIteration(i, x);
   end;
   Sum := Sum * exp(sqrt(x/n));
   result := Sum;
end;

initialization
end.
