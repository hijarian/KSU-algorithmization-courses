program ex_2_5_2;

{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,
  U_My;                                  //собственноручно написанный модуль :)
var
  n:integer;                             //сторона матрицы
  i,j:integer;
  main:Tmatrix;                           //этот тип описан в U_My.pas
  f:boolean=false;
  //индикатор несоответствия эл-тов текущего столбца условию (меньше полусуммы соседних)
  X:array of byte;                       //искомый массив
begin
  writeln(oem('Введите длину стороны матрицы '));
  read(n);
  EnterMatrix(main,n,n);                 //эта процедура описана в U_My.pas
  SetLength(x,n);

  MatrixOutput(main,1,0,(oem('Исходная матрица:')));
 {ВНИМАНИЕ!!! УСЛОВИЕ ЗАДАНИЯ ИЗМЕНЕНО!!!}
 {Xi=1 ЕСЛИ ХОТЯ БЫ ОДИН ЭЛ-Т В ТОЧНОСТИ РАВЕН ПОЛУСУММЕ ПРЕДЫДУЩЕГО И СЛЕДУЮЩЕГО ЭЛ-ТОВ}
  for j:=0 to n-1 do
    begin
      for i:=1 to n-2 do
        if main[i,j]=(main[i-1,j]+main[i+1,j])/2  //проверка соответствия
          then f:=true;
      if f
        then x[j]:=1
        else x[j]:=0;
      f:=false;
    end;

  writeln(oem('проверка'));                        //задача уже решена, но ее решение необходимо вывести
  for j:=0 to n-1 do
    begin
      writeln(oem('столбик '),j+1);
      writeln(chr(179),oem('эл-т'),chr(179),oem('полусумма'){,chr(179)});
      for i:=1 to n-2 do
        begin
          write(chr(179),main[i,j]:2:0,'  ',chr(179),'(',main[i-1,j]:2:0,'+',
                main[i+1,j]:2:0,')/2=',(main[i-1,j]+main[i+1,j])/2:3:1,
                chr(179),' ');
          //выводим результат сравнения эл-та с соседями
          if main[i,j]<(main[i-1,j]+main[i+1,j])/2
            then writeln('<')
            else if main[i,j]>(main[i-1,j]+main[i+1,j])/2
                    then writeln('>')
                    else writeln('=');
        end;
    end;

  writeln(oem('Искомый массив'));
  for i:=0 to n-1 do
    write(x[i],' ');
  readkey;
end.
