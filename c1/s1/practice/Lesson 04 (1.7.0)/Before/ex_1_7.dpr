program ex_1_7;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  crt32,
  math;

  var
  a,b,c:double;                        //границы отрезка и его центр соответственно
  lim:real;                            //предел измерения
  {fn_a,fn_b,}fn_c:real;               //функция от a,b,c
  sg_a,sg_b,sg_c:integer;              //знаки a,b,c (-1,1)
  flag:boolean;                        //индикатор прекращения выполнения

  function fn_x(x:double):double;          {самовольно объявленная ф-я,    }
   // var a:real;
    begin                                  {вычисляющая х (и не только его)}
      // Здесь должна была быть f-я из задачи, но для нее метод оказ-ся неприменим =)
      result:=sin(x);
    end;

begin
  writeln(oem('Введите верхний и нижний концы отрезка AB (через пробел)'));
  read(a,b);
  writeln(oem('Введите предел измерения'));      //ну почему его нельзя ввести константой!!!
  read(lim);

  if a>b
    then
      begin
        c:=a;
        a:=b;
        b:=c;
      end;

  flag:=false;
//НАЧАЛО MAIN ЦИКЛА... УЖОС!!!
  repeat
    c:=a+(b-a)/2;
    fn_c:=fn_x(c);
{   fn_a:=fn_x(a);
    fn_b:=fn_x(b);  }
    {if fn_c=0                                          //при определении знака f(c)
      then                                             //если f(c)=0 то с-корень
        begin                             // практически нереальный случай =)
          writeln(oem('Искомый корень= '),c:6:2);
          writeln(oem('Функция равна= '),fn_c:6:2);
          writeln(oem('Нажмите кнопку [anykey] :)'));
          readkey;
          halt;                         //тогда насильно вырубаем прогу
        end;}
    if fn_x(a)<0
      then sg_a:=-1
      else sg_a:=1;                {определили знаки f(a) }
    if fn_x(b)<0
      then sg_b:=-1
      else sg_b:=1;                {              ...f(b) }
    if fn_c<0
      then sg_c:=-1                                //...
      else sg_c:=1;                               //...

    if sg_a=sg_b
      then
        begin
          writeln(oem('Знаки f(a) и f(b) одинаковы, метод неприменим'));
          writeln('f(a)= ',fn_x(a):6:2);
          writeln('f(b)= ',fn_x(b):6:2);
          writeln('f(c)= ',fn_c:6:2);
          writeln(oem('Нажмите кнопку [anykey] :)'));
          readkey;
          halt;
        end;
                             //...
    if sg_c=sg_b              //если знаки f(c) и f(b) равны
      then b:=c;               //сдвигаем (b) к текущему (c)
    if sg_c=sg_a
      then a:=c;              //иначе сдвигаем (a) к текущему (c)

    if b-a<lim
      then flag:=true;

  until flag;
//КОНЕЦ MAIN ЦИКЛА
  writeln(oem('По достижении предела измерения (равного '),lim:6:5,')');
  writeln(oem('был достигнут x, равный '),c:6:5,')');
  writeln(oem('Нажмите кнопку [anykey] :)'));
  readkey;
end.
