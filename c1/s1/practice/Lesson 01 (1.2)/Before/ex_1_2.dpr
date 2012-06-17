program ex_1_2;
// Табулирование f-ии
{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,math;
var
  x,x1,res:real;  //исходное и итоговое значения
  a,b:real;    //пределы
  n:integer;   // # строк в таблице
  step:real;  //х равномерно распределен между пределами, поэтому это - шаг между x-ами
  i:integer;  //классический счетчик
begin
  write(oem('Введите начальное значение: '));
  readln(a);
  write(oem('Введите конечное значение: '));
  readln(b);
  write(oem('Введите кол-во строк: '));
  readln(n);
  if a>b                //если нижний предел оказался верхним :)
    then begin
      x:=a;
      a:=b;
      b:=x;
      end;
  x1:=a;
  step:=(b-a)/n;        //промежуток a-b делится на n отрезков
  writeln;              //здесь должна быть строка - заголовок таблицы ;)

  for i:=0 to n do begin
    x:=x1+step*i;
    res:=abs(sin(power((10.5*x),0.5)))/(power(x,(2/3))-0.143)+2*pi*x;
    writeln(x:15:3,res:15:3);
    //writeln('press any key');
    //readkey;
    end;

  writeln('press any key');
  readkey;
end.
