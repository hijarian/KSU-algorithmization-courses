program ex_1_3_3;

{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,math;
var
  H,r,l:real;       //резервуары: высота, внутр. радиус, толщина стенки
  pl:real;          //плотность материала
  V,Vsum,m:real;    //объем текущего резервуара, суммарный объем, итоговая масса
  N:integer;        // # резервуаров
  i:integer;        //догадайтесь, что это? :)
  R1:real;          //радиус текущего цилиндра (внутренний)
begin
  writeln(oem('Введите внутренний радиус, высоту и толщину цилиндров, через пробел:'));
  readln(r,h,l);
  writeln(oem('Введите удельную массу материала цилиндров'));
  readln(pl);
  writeln(oem('Введите кол-во цилиндров:'));
  readln(n);
  Vsum:=0;
  for i:=1 to n do begin
    R1:=sqr(r*sqrt(i));         //вычисление внешнего радиуса
    V:=(pi*(R1+l)-pi*R1)*h;     //объем боковин
    V:=V+pi*(R1+l)*l;           //прибавляем к боковинам дно
    Vsum:=Vsum+V;               //прибавляем этот объем к сумме объемов
    end;
  m:=Vsum*pl;
  writeln(oem('МАССА: '),m:15:4);
  writeln('press any key...');
  readkey;
end.
