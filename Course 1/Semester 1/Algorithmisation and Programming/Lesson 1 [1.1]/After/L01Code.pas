{
 Код для первого упражнения.
 Используется в юнит-тестах.
}
unit L01Code;

interface

function MyFunction(x: real) : real;

implementation

uses
   Math;

function MyFunction(x: real) : real;
begin
   MyFunction := abs(sin(power(10.5*x, 1/2))) / (power(x, 2/3) - 0.143) + 2*pi*x;
end;

initialization
end.
