program ex_4_2_3;
{Найти в массиве Y КОЛИЧЕСТВО эл-тов, равных каким-либо(?) элементам из массива X}
{$APPTYPE CONSOLE}

uses
  SysUtils,crt32;
label bg;
const
  MyArrayLength=20;
  rseed=20;

type
  MyArray=array[1..MyArrayLength] of integer;

var
  X:MyArray;
  Y:MyArray;
  i,j:integer;
  counter:byte=0;                   //То, чем прога будет считать =)

function ArrOut:MyArray;                 //очередной ленивчик, б#я !!
  var i:integer;
  begin
    randomize;
    for i:=1 to MyArrayLength do
      begin
        result[i]:=random(rseed);
        write(result[i]:2,' ');
      end;
    writeln;
  end;
// f-я поиска количества прямых совпадений (A[i]=B[i])
function m_count(A,B:MyArray):integer;
  var i:integer;
  begin
    result:=0;
    for i:=1 to MyArrayLength do
      if A[i]=B[i]
        then result:=result+1;
  end;
// f-я поиска количества относительных совпадений (A[i]=B[_])
function m_otn(A,B:MyArray):integer;
  var i,j:integer;
  begin
    result:=0;
    for i:=1 to MyArrayLength do
      for j:=1 to MyArrayLength do
        if A[i]=B[j]
          then
            begin
              result:=result+1;
              break;
            end;
  end;

begin

bg:for i:=0 to 70 do write('*');
  writeln;

  write('i ',chr(179));
  for i:=1 to MyArrayLength do write(i:2,' ');
  writeln;
  write(chr(196),chr(196),chr(197));
  for i:=1 to MyArrayLength*3 do write(chr(196));
  writeln;

  write('X ',chr(179));
  X:=ArrOut;

  write(chr(196),chr(196),chr(197));
  for i:=1 to MyArrayLength*3 do write(chr(196));
  writeln;

  write('Y ',chr(179));
  Y:=ArrOut;

  writeln;
  writeln(oem('Функция нашла прямо совпадающих элементов среди данных массивов: '),m_count(Y,X));
  writeln(oem('Теперь считаем самостоятельно =)'));
  writeln;

  writeln(oem('Прямо совпадающие элементы...'));
  counter:=0;
  for i:=1 to MyArrayLength do
    if X[i]=Y[i]
      then
        begin
          counter:=counter+1;
          writeln('X[',i:2,']=',x[i]:2,'=  Y[',i:2,']  (=',Y[i]:2,')');     //'Xi=[Xi]=Yi    (=[Yi])'
        end;                          //знач-е в скобках - для отладки
  write('...');
  if counter=0
    then writeln(oem('не обнаружены'))
    else case counter of
            1:writeln(counter,oem(' штука'));
            2..4:writeln(counter,oem(' штуки'));
            else writeln(counter,oem(' штук'));
         end;

  //АЦЦКАЯ СОТОНА НАЧИНАЕТСЯ ЗДЕСЬ!!!
  //SetLength(buffer,MyArrayLength);
  writeln;
  writeln(oem('Функция нашла косвенно совпадающих элементов среди данных массивов: '),m_otn(Y,X));
  writeln(oem('И это тоже считаем самостоятельно =)'));
  writeln;

  counter:=0;
  writeln(oem('Косвенно совпадающие эл-ты, (как бы глупо это ни звучало)'));
  for i:=1 to MyArrayLength do
    for j:=1 to MyArrayLength do
      if Y[i]=X[j]
        then
          begin
            counter:=counter+1;
            writeln('Y[',i:2,']= ',Y[i]:2,'=  X[',j:2,']   (=',X[j]:2,')');
            break;
          end;
  if counter>0
    then writeln(oem('Косвенно совпадающих элементов: '),counter)
    else writeln(oem('Косвенно совпадающих элементов нет'));

  for i:=0 to 70 do write('*');
  writeln;

  writeln;
  writeln(oem('Нажмите [1] для перезагрузки или любую другую кнопку для выхода'));
  writeln;writeln;
  if readkey='1' then goto bg;
end.
