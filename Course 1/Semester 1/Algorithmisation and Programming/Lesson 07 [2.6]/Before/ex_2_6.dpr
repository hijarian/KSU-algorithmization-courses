program ex_2_6;
//обработка массива по сложному условию
{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,U_My;
var
  main:matrix;
  i:integer;

begin
  { TODO -oUser -cConsole Main : Insert code here }

  //матрица 2 столбца 10 строк
//  EnterMatrix(main,10,2);
  SetLength(main,10,2);
  randomize;
  for i:=0 to 9 do                 //жуткая конструкция, забивающая матрицу
    begin                           //случайными числами :)
      main[i,0]:=50-i*4-2+(random(2));       //внутр. радиус=номер строки+ число от 0 до 2
      main[i,1]:=50-i*4-0+(random(2));     //внешн. радиус=номер строки+ число от 2 до 4
    end;                            //
  randomize;
  i:=random(9);                     //элемент случайности :)))
  // внутренний радиус одного случайно выбранного кольца увеличивается на 4
  main[i,0]:=main[i,0]-10;

  MatrixOutput(main,2,0,'main:');   //вывод всего этого ужаса

  writeln(oem(' № '),chr(179),oem('внешн.Rтек.'),chr(179),oem('внутр.Rпред.'));
  for i:=0 to 15 do write(chr(196));
  writeln;
  writeln(' 1 ',chr(179),main[0,1]:7:0);        //номер и внешн. радиус первого кольца

  for i:=1 to 9 do                              //
    begin                                       //
      writeln(i+1:2,' ',chr(179),main[i,1]:7:0,main[i-1,0]:7:0);            //  MAIN ЦИКЛ
      if main[i,1]>=main[i-1,0] then break;     //
    end;
//  writeln;                                          //
  if i<10
    then writeln(i+1:2,oem('-е кольцо не подходит'))
    else writeln(oem('Все кольца были вложены друг в друга')) ;
  readkey;
end.
