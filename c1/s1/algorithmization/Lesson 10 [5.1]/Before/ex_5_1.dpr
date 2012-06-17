program ex_5_1;
//найти во внешнем файле все слова, начинающиеся с заданного символа
{$APPTYPE CONSOLE}

uses
  SysUtils,crt32;

const
  path='C:\test.txt';

var
  f:Text;
  buffer:string;
  s:char;
  k:char;

begin
  { TODO -oUser -cConsole Main : Insert code here }
  writeln(oem('Введите символ'));
  Readln(s);                            //прочитали букву-образец

  AssignFile(f,path);               //Блок, описывающий открытие файла в Read-only
//  FileMode:=0;                      //Собственно Read-only, хотя эта строка нафиг не нужна,
  Reset(f);                         //так как эта строка и так открывает в Read-only

  textcolor(3);                        //буквы текста будут бледно-зеленые
  while not Eof(f) do
    begin
      buffer:='';                                     //обнуляем буфер
      repeat
        read(f,k);                                    //читаем по буквам
        buffer:=buffer+k;                             //пишем буквы в буфер
      until (k=#13) or (k=#32) or (k=#$A);            //если только что прочитанная буква - пробел или знак абзаца заканчиваем читать. Теперь buffer - это слово

      if buffer[1]=s                   //Если первая буква buffer - образец, то
        then
          begin
            textcolor(15);              //она печатается белым цветом
            writeln(oem(buffer));
            textcolor(3);
          end
        else if (buffer<>#13) and (buffer<>#32) and (buffer<>#$A)
        {если слово состоит ТОЛЬКО из знака абзаца или пробела
        (прога же все равно его записала в буфер), ничего не печатаем}
          then writeln(oem(buffer)); //если первая буква любая другая - слово просто печатается
    end;
  CloseFile(f);        //разорвали связь с файлом
  readkey;
end.
