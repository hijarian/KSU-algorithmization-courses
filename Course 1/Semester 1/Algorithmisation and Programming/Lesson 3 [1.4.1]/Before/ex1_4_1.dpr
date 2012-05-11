program ex1_4_1;


{$APPTYPE CONSOLE}

uses
  SysUtils,
  crt32;

var
  n:integer;                    //РАЗМЕРность массива
  X:array of real;
  i:integer;
  res:real;                     //произв-е
begin
  { TODO -oUser -cConsole Main : Insert code here }
  //i:=1;
  res:=1;
  write(oem('Введите количество элементов: '));
  read(n);
  n:=n-1;
  SetLength(x,n);

  randomize;             //
  for i:=0 to n do       //забиваем массив
    x[i]:=random(4)+1;   //случайными числами

  i:=0;
  while i<=n do begin    //произведение
    res:=res*x[i];       //
    i:=i+3;              //
    end;

  write(oem('Массив чисел: '));
  for i:=0 to n do
    write(x[i]:6:2,' ');

  writeln;

  write(oem('Результат произведения='),res:8:3);
  readkey;
end.
