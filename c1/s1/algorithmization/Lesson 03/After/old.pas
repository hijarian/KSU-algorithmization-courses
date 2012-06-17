{
  КГУ, семестр 1, курс "Алгоритмизация и программирование", задание 3
  
  Требуется перемножить друг с другом каждый третий член заданного массива.

  Полное задание в приложенном файле Lesson3.task.png

  Автор: hijarian@gmail.com
  Лицензия: Public domain
}

program Lesson3;
uses
  SysUtils;

var
   source  : array of real;
   length  : integer;
   i       : integer;
   product : real; 

begin
   // Initialisation
   writeln('Enter array length:');
   write('  ');
   read(length);

   SetLength(source, length);
   Randomize;
   for i := 0 to length - 1 do begin  
      source[i] := random();  
   end;

   // Processing
   i := 0;
   product := 1;
   while i < length do begin
      product := product * source[i];
      i := i + 3;
   end;
   
   // Reporting
   writeln;
   writeln('Source array: ');
   for i := 0 to length - 1 do begin
      writeln(source[i]:6:2);
   end;
   
   writeln;
   writeln('Product is: ');
   writeln(product:6:2);
end.
