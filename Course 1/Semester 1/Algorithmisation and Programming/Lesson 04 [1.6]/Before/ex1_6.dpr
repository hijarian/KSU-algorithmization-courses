program ex1_6;

{$APPTYPE CONSOLE}

uses
  SysUtils,crt32;
const lim=15;   //ответственная за длину числа константа
var
  n:integer;
  y:real;
  a:real;
  i:integer;
  x,x1:real;
  dx:real;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  write(oem('Введите количество значений: '));
  read(n);
  writeln;
  write(oem('Введите A: '));
  read(a);
  writeln;
  {write(oem('Введите начальный x: '));
  read(x1);
  writeln;
  write(oem('Введите приращение x: '));
  read(dx);
  writeln;}
  x1:=a*(-10);                  //значение х, которое можно и нужно менять
  dx:=a/2;                      //приращение х с теми же св-вами :)
  writeln('x1=',x1:lim:3,'  dx=',dx:lim:3);
  writeln;

  write(chr(218));
  for i:=0 to lim-1 do
    write(chr(196));
  write(chr(194));
  for i:=0 to lim-1 do
    write(chr(196));
  writeln(chr(191));

  write(chr(179));
  for i:=0 to lim-2 do
    write (' ');
  write('x');
  write(chr(179));
  for i:=0 to lim-2 do
    write (' ');
  write('y');
  writeln(chr(179));

  write(chr(195));
  for i:=0 to lim-1 do
    write(chr(196));
  write(chr(197));
  for i:=0 to lim-1 do
    write(chr(196));
  writeln(chr(180));

  for i:=0 to n-1 do
    begin
      x:=x1+dx*i;
      if x>(a*(-6))               //т.к. в условии система, то развилка
        then y:=a*cos(x+3*a)-3*a
        else y:=-1*sqr(x+3*a)-2*a;
      writeln(chr(179),x:lim:3,chr(179),y:lim:3,chr(179));
    end;

  write(chr(192));
  for i:=0 to lim-1 do
    write(chr(196));
  write(chr(193));
  for i:=0 to lim-1 do
    write(chr(196));
  writeln(chr(217));

readkey;
end.
