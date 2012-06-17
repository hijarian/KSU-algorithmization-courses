{
 КГУ, семестр 1, курс "Алгоритмизация и программирование", задание 1

 Требуется получить от пользователя число из заданного интервала и вычислить
 сложное математическое выражение от этого числа.

 Полное задание в приложенном файле Task01.tex

 Автор: hijarian@gmail.com
 Лицензия: Public domain
}

program Lesson01;
uses
   SysUtils,
   L01Code;

var
   x: real;
   answer: real;

begin
   writeln('Enter 0.1 =< x <= 0.6 here:');
   repeat
      readln(x)
   until
      (x>=0.1) and (x<=0.6);

   answer:= MyFunction(x);

   writeln('Answer is ',answer:12:3);
end.
