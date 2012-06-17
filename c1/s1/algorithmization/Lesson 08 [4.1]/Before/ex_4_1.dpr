program ex_4_1;

{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,math;

const
  c=24;
  err='НЕ РАВНЫЙ НУЛЮ!!!';
var
  x,y,a,b,p:integer;
  t,t1,t2,t3,t4:real;

function m_abs(st1,st2:real):real;
  begin
    result:=abs(1+c+st1*st2+power(st1,-1)+power(st2,-1));      //result:= | 1 + c + st1*st2 + 1/st1 + 1/st2 |
  end;

begin
  { TODO -oUser -cConsole Main : Insert code here }
  writeln(oem('Введите ЦЕЛЫЕ коэффициенты выражения: a, b, p, x и y, не равные нулю!'));
  repeat
    write('a=');readln(a);
    if a=0 then writeln(oem(err));
  until a<>0;
  repeat
    write('b=');readln(b);
    if b=0 then writeln(oem(err));
  until b<>0;
  repeat
    write('p=');readln(p);
    if p=0 then writeln(oem(err));
  until p<>0;
  repeat
    write('x=');readln(x);
    if x=0 then writeln(oem(err));
  until x<>0;
  repeat
    write('y=');readln(y);
    if y=0 then writeln(oem(err));
  until y<>0;

  if (x=0) or (y=0) or (a=0) or (b=0) or (p=0)                                 //
    then                                                                       //
      begin                                                                    //
        writeln(oem('По неизвестной причине, один из коэффициентов - ноль'));  //защита от АБСОЛЮТНОГО дурака
        readkey;                                                               //
        halt;                                                                  //
      end;

  t1:=m_abs(p,power(y,2));             //t1:=| 1 + c + p*y^2 + 1/p + 1/(y^2) |
  t2:=m_abs(x,y);
  t3:=power(m_abs(a,b),3);             //t3:=| 1 + c + a*b + 1/a + 1/b |

  if t3=0                                                                       //
    then                                                                        //
      begin                                                                     //Это пришлось вставить,
        writeln(oem('Знаменатель обратился в ноль, задача не ммеет решения'));  //т.к мне лениво вычислять
        readkey;                                                                //ОДЗ ф-ии от
        halt;                                                                   //двух переменных
      end                                                                       //a*b + 1/a + 1/b <> -(c+1)
    else t4:=t2/t3;
  t:=t1-t4;

  writeln(oem('1-я итерация: '),t1:8:2);
  writeln(oem('2-я итерация: '),t2:8:2);
  writeln(oem('3-я итерация: '),t3:8:2);
  writeln(oem('Деление: '),t4:8:7);
  writeln(oem('Результат: '),t:8:2);
  readkey;
end.
