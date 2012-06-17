program ex_4_3_3;
{Спихиваем отрицательные эл-ты в каждой колонке вниз, затем печатаем
массив до строчек, содержащих отрицательные эл-ты (без этих строчек)}
{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,U_My;

var
  main:Matrix;

procedure NegDown(var A:Matrix);

  var
    b:integer;            //буфер для перемещения эл-та
    i,j:integer;          //угадай, кто =)
    down:integer;
    //номер самого нижнего предположительно неотрицательного эл-та строки

  begin
    for j:=Low(A[0]) to High(A[0]) do
    //от начала строки до конца строки
      begin
        down:=High(A);
        //номер нижнего эл-та - номер последнего
        i:=Low(A);
        while i < down do
        //от начала колонки до последнего непроверенного эл-та колонки
// Если доползли до отрицательного эл-та, то начинаем
          begin
            if A[i,j]<0
              then
                begin

// Первое действие: если нижний предположительно неотрицательный эл-т оказался отрицательным
// то сдвигаем указатель down вверх до тех пор, пока не наткнемся на неотриц. эл-т

                  if A[down,j]<0
                    then
                      repeat
                        dec(down);
                      until (A[down,j]>=0) or (down=i);
                      // при down=i прога перепишет эл-т сам в себя

// Второе действие: перемещаем текущ. эл-т A[i,j] на место A[down,j]
                  b:=A[i,j];
                  //текущий отрицательный эл-т -> буфер

                  A[i,j]:=A[down,j];
                  //последний (вероятно, неотрицательный) эл-т -> текущий эл-т

                  A[down,j]:=b;
                  //буфер -> место последнего эл-та

                  dec(down);
                  //переставили эл-т, сл-но, граница кучи
                  //отрицательных эл-тов подвинулась вверх

                end;
            inc(i);
          end;
      end;
  end;

procedure WriteUntilNeg(A:matrix);
  var i,j:integer;
  begin
    for i:=Low(A) to High(A) do
      begin
        for j:=Low(A[0]) to High(A[0]) do
          if A[i,j]<0 then exit;
        for j:=Low(A[0]) to High(A[0]) do
          write(A[i,j]:3,' ');
        writeln;
      end;
  end;

begin
  EnterMatrix(main,7,4);

  MatrixOutput(main,3,oem('Исходная матрица:'));

  NegDown(main);
  writeln;

  MatrixOutput(main,3,oem('Преобразованная матрица:'));

  writeln;
  write(oem('Матрица до первой строки,'));
  writeln(oem(' содержащей отрицательный элемент'));
  WriteUntilNeg(main);

  readkey;
end.
