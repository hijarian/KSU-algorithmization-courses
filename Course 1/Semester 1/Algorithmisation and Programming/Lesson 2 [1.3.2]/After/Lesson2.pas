{
  КГУ, семестр 1, курс "Алгоритмизация и программирование", задание 2
  
  Требуется вычислить сложное математическое выражение от x, содержащее в себе
  сумму из n элементов. x и n задаются пользователем.

  Полное задание в приложенном файле Lesson2.task.png

  Автор: hijarian@gmail.com
  Лицензия: Public domain
}

program Lesson2;
uses
  SysUtils,math;

var
  x, sum: real;   // Исходное и итоговые значения
  i, n: integer;  // Счетчик и его верхний предел

begin
  writeln('Enter x here:');
  readln(x);

  writeln('Enter number of iterations:');
  readln(n);

  Sum := 0;
  for i := 1 to n do begin
    Sum := Sum + (sqr(abs(x-i)) * sqrt(exp(i-1)) / (ln(2+power(x,i)) + power(x, (2*i+1))));
  end;

  Sum := Sum*exp(sqrt(x/n));        //сумма множится на коэффициент

  writeln('result: ',sum:12:3);               //вывод
end.