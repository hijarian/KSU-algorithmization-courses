{
 КГУ, семестр 1, курс "Алгоритмизация и программирование", задание 02
 
 ЗДЕСЬ ВСТАВЬТЕ КРАТКОЕ ОПИСАНИЕ ЗАДАЧИ

 Полное задание в приложенном файле Task02.tex (Task02.pdf)

 Автор: hijarian@gmail.com
 Лицензия: Public domain
}

program Lesson02;
uses
   SysUtils,
   L02Code;

var
  x: real;
  n: integer;
  Sum: real;
begin
  writeln('Enter x here:');
  readln(x);

  writeln('Enter number of iterations:');
  readln(n);

  Sum := CalcSum(x, n);

  writeln('result: ',Sum:12:3);               //вывод
end.
