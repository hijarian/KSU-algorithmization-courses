program ex_4_2_4;
//---------------------------------------------
//испльзование формальных массивов в процедурах
//----------------------------------------------
//процедура выполняет вычисление расстояния от исходной точки
//декартовой системы координат до каждой из точек 2D массива с координатами
//прога, в свою очередь, контролирует выполнение процедуры
//...ну и бред =)
{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,math;

const
  rseed=12;

type
  coord=array of integer;

var
  B:coord;
  C:coord;
  n:integer;                       //вводимое юзверем # контрольных точек на плоскости
  x0,y0:integer;                     //вводимые юзверем координаты опорной точки
  i:integer;
  Z:array of real;                //А-А-А-А!!! Массив дистанций. =)

function distance(x,x0,y,y0:integer): real;           //собственно функция, вычисляющая расстояние от опорной точки до текущей
  begin
    distance:=sqrt( sqr(x-x0) + sqr(y-y0) );
  end;

procedure ya_zdesya_hozyain(B,C:coord;var Z:array of real);
var i:integer;                             //приделано, чтобы удовлетворить заданию: процедура, входные (и даже выходные!) данные к-й - массивы =)
  begin
    for i:=0 to high(B) do
      Z[i]:=distance(B[i],x0,C[i],y0);
  end;

begin
  { TODO -oUser -cConsole Main : Insert code here }
  writeln(oem('Юзверь! Сколько точек тебе надо?'));
  writeln(oem('Только не пиши БОЛЬШОЕ число, а то они щас будут перечислены!!'));
  read(n);
  if n>255 then writeln(oem('Я предупреждал!!'));
  SetLength(B,n);
  SetLength(C,n);
  SetLength(Z,n);

  randomize;                                        //
  for i:=0 to n-1 do                                // как обычно: ленивчик,
    begin                                           // чтобы не забивать массивы самостоятельно =)
      B[i]:=random(rseed);                          //
      C[i]:=random(rseed);                          //
    end;
  writeln(oem('Теперь пиши координаты опорной точки Z(x;y) : через пробел и ЦЕЛЫЕ!!'));
  read(x0,y0);

  ya_zdesya_hozyain(B,C,Z);                //вызываем наше чудовище =)

  for i:=0 to n-1 do
    begin
      writeln('A[',i+1:-3,'](',B[i]:2,';',C[i]:2,')',chr(179),Z[i]:10:3);             //Пишем ч-з знак "|" координаты текущ. точки и дистанцию до опорной
      write('  sqrt( sqr( ',B[i]:2,'-',x0:2,' ) + sqr( ',C[i]:2,'-',y0:2,' )=');      //сей ужас - расписанное по шагам
      write('sqrt( ',sqr(B[i]-x0),' + ',sqr(C[i]-y0),' )=');                          //вычисление того, что делает функция
      writeln('sqrt( ',sqr(B[i]-x0) + sqr(C[i]-y0),' )');                             //наша прога должна ей не верить =)
    end;

   writeln(oem('Теперь нажми кнопку [ANYKEY]! =)'));
  readkey;
end.
