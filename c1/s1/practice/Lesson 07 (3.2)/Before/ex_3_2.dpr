program ex_3_2;

{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,math;
var
  x,z:array[0..4] of real;
//  main:array[0..4,0..4] of real;
  i,j:integer;
  res:real;

begin
  //начало вывода таблицы, б#€!!

  for i:=0 to 4 do x[i]:=i+1;
  for i:=0 to 4 do z[i]:=1+0.1*(i+2);

  write(chr(218));
  for j:=0 to 4 do write(chr(196),chr(196),chr(196),chr(196),chr(196),chr(194));
  write(chr(196),chr(196),chr(196),chr(196),chr(196),chr(191));
  writeln;

  write(chr(179),' z\x ',chr(179));
  for i:=0 to 4 do write(' ',x[i]:3:1,' ',chr(179));
  writeln;

  for i:=0 to 4 do
    begin

      write(chr(195));
      for j:=0 to 4 do write(chr(196),chr(196),chr(196),chr(196),chr(196),chr(197));
      write(chr(196),chr(196),chr(196),chr(196),chr(196),chr(180));
      writeln;
      write(chr(179),' ',z[i]:3:1,' ',chr(179));

      for j:=0 to 4 do
        begin
          // вывод значени€ f-ии в тек. €чейке
          res:=((abs(x[j]-z[i]))/(1/3+cos(x[j]/z[i])))*exp(z[i]/3);
          write(res:5:1,chr(179));
        end;
      writeln;
    end;

  write(chr(192));
  for j:=0 to 4 do write(chr(196),chr(196),chr(196),chr(196),chr(196),chr(193));
  write(chr(196),chr(196),chr(196),chr(196),chr(196),chr(217));
  writeln;

  readkey;
end.
