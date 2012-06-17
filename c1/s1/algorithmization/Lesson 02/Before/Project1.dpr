program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,math;
var
  x,sum:real;   //исходное и итоговые значения
  k,n:integer;  //счетчик и его верхний предел
begin
  { TODO -oUser -cConsole Main : Insert code here }
  writeln('Enter x here:');              //
  readln(x);                             //
  writeln('Enter number of iterations:');//инициализация
  readln(n);                             //
  Sum:=0;                                //

  for k:=1 to n do
    Sum:=Sum+(sqr(abs(x-k))*sqrt(exp(k-1))/(ln(2+power(x,k))+power(x,(2*k+1))));

  Sum:=Sum*exp(power((x/n),0.5));        //сумма множится на коэффициент

  writeln('result: ',sum:12:3);               //вывод

  writeln('press any key to exit');              //завершение
  readkey;
end.
