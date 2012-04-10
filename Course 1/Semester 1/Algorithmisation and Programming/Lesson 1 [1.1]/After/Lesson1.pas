{
  КГУ, семестр 1, курс "Алгоритмизация и программирование", задание 1
  
  Требуется получить от пользователя число из заданного интервала и вычислить
  сложное математическое выражение от этого числа.

  Полное задание в приложенном файле Lesson1.task.png

  Автор: hijarian@gmail.com
  Лицензия: Public domain
}

program Lesson1;
uses
  SysUtils, Math;

var
  x: real;
  answer: real;

begin
  writeln('Enter 0.1 =< x <= 0.6 here:');
  repeat readln(x)
    until (x>=0.1) and (x<=0.6);

  answer:= abs(sin(power(10.5*x, 1/2))) / (power(x, 2/3) - 0.143) + 2*pi*x;

  writeln('Answer is ',answer:12:3);
end.