// !!!А-А-А-А!!! Копирайты, мазафака!! =)

// Прога "Студенческая ведомость", версия первая.
// (с) Сафронов Мэ А, группа 4606 ПМиИТ фКГУ
// Основана на заданиях "алгоритмизация-11","учебная практика-10,11",
// которые основаны на заданиях 5.2.1 и 5.2.2 задачника,
// которые подразумевают создание консольного (!) приложения, способного
// осуществлять файловый ввод-вывод, ввод с клавиатуры и обработку
// связного массива записей.

program ex_5_2_1;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  crt32,
  math;

const
// Эту константу - не менять во избежание глюков.
// Во всяком случае, она должна быть четной!
  screenwidth:byte=78;
// подпись правильного файла списка студентов
  subscription:string='// -S- listfile';

  IniPath:string='C:\My.ini';    // Путь к файлу конфигурации =)
  DefaultPath:string='C:\1.txt'; // Путь по умолчанию

// Заголовки
  mainheader:string='СТУДЕНЧЕСКАЯ ВЕДОМОСТЬ v0.7';
  subheader:string='(Для служебного пользования)';
// Названия кнопок
  btnLoad:string=' Загрузить список';
  btnNew:string=' Новый студент';
  btnSolve:string=' Задачи';
  btnEdit:string=' Редактировать записи';
  btnExit:string=' Выход и сохранение';
  btnNewList:string=' Создать чистый список';

type                                            //ord('|')=124  !!
  Tdate=record
    Year:integer;
    month:integer;
    day:integer;
    end;
  TRStudent=record           // Тип основной  записи, описывающий студента
    Identity:string;         // Имя
    BirthDate:Tdate;         // Дата рождения
    IsMale:boolean;          // true = М, false = Ж
    Physics:byte;            // Оценка по физике
    Math:byte;               // Оценка по математике
    Informatics:byte;        // Оценка по информатике
    Payment:integer;         // Стипендия (может быть отрицательной, кстати =) )
    PhoneNumber:string[12];  // Номер телефона (реализация условия задачи 5.2.2)
    NextRecord:Pointer;      // Указатель на следующую запись
    end;

  TGroupList=array of TRStudent;
  TbtnNames=array of string;

var
// это глобальные переменные, и подпрограммы ЧАСТО обращаются к ним напрямую

// Основной массив, вокруг обслуживания к-го построена вся прога
  Group:TGrouplist;
  (****************)

  c:char;
  // Символьный буфер (использован при реализации меню)

  btnNames:TbtnNames;
  // Да-да, массив с названиями кнопочек!!

  isKickedToMenu:boolean=true;
  // Переключатель, указывающий присутствие в меню (скорее, указывающий на
  // необходимость присутствия в меню)

  CurrentPath:string;
  // Здесь хранится путь к файлу, из которого был загружен текущий список.


//**********************************Объявление процедур и f-й  начинается здесь!
//
function LoadBtnNames: TbtnNames;
begin
  SetLength(Result,6);
  result[1]:=btnNew;
  result[2]:=btnEdit;
  result[3]:=btnNewList;
  result[4]:=btnLoad;
  result[5]:=btnSolve;
  result[0]:=btnExit;
end;

function FileSubscribed(var f:textfile):boolean;
  var
    b:string;
    c:char;
    i:integer;
  begin
    reset(f);
    b:='';
    for i:=1 to length(subscription) do
      begin
        read(f,c);
        b:=b+c;
      end;
    if b=subscription
      then result:=true
      else result:=false;
  end;

{**********************************************************************}
// Процедура, рисующая всякие оформительные надписи, описывающие возврат
// к меню =)
Procedure ToMenu();
  var i:byte;
  begin
    writeln;
    writeln(oem('Возврат к меню'));
    for i:=1 to screenwidth do
      write('*');
    writeln;
    IsKickedToMenu:=true;
    writeln(oem('Нажмите любую клавишу'));
    readkey;
  end;
{**********************************************************************}

{***********************************************}
//Создание и оформление нового файла списка- НАЧАЛО
  function CreateAndSubscribe(path:string; subscription:string):boolean;
    var f:TextFile;
    begin
      AssignFile(f,path);
      rewrite(f);
      write(f,subscription);
      CloseFile(f);
      result:=true;
    end;
//Создание и оформление нового файла списка- КОНЕЦ
{***********************************************}

{***********************************************}
//Функция, пытающаяся создать новый файл - НАЧАЛО
function CreateList(var path:string):boolean;
  var
    r:boolean;
    c:char;
  begin
    writeln(oem('Введите путь к создаваемому списку (его полное имя)'));
    result:=false;
    repeat
      readln(path);
//    Запускается функция CreateAndSubscribe, и, ежели она завершилась успешно,
//    выходим из цикла
      if CreateAndSubscribe(path,subscription)
        then
          begin
            writeln(oem('Файл создан успешно'));
            r:=false;
            result:=true;
          end
        else
          begin
            writeln(oem('Не удалось создать файл'));
            writeln(oem('Попробовать еще раз? [1] - Да , [0] - Нет'));
            repeat
              c:=readkey;
            until (c='1') or (c='0');
            if c='0'
              then
                begin
                  writeln(oem('Нет'));
                  r:=false;
                  result:=false;
                end
              else
                begin
                  writeln(oem('Да'));
                  r:=true;
                  writeln(oem('Введите имя файла'));
                end;
          end;
    until r=false;
  end;
//Функция, пытающаяся создать новый файл - КОНЕЦ
{***********************************************}

{*******************************************}
//Собственно, функция записи в файл - НАЧАЛО
// организована как f-ия для возможности возвращать результат операции вида
// "успешно"-"безуспешно"
function Saving(var path:string):boolean;
  var
    f:textfile;
    c:char;
    i:integer;
  begin
    result:=false;
    writeln(oem('Сохранение файла.'));
    try
      AssignFile(f,path);       //
      Reset(f);
      Close(f);                 //
      Erase(f);                 // Да, да, я извращенец..
    except
      begin
        writeln(oem('Невозможно получить доступ к исходному файлу'));
        writeln(oem('Создать новый файл списка? [anykey] - Да,'),
                oem(' [0] - Возврат в меню'));
        c:=readkey;
        if c='0'
          then
            begin
              ToMenu;
              exit;
            end
          else
            begin
              writeln(oem('Переход к процедуре создания файла...'));
              if not CreateList(path)
                then
                  begin
                    ToMenu;
                    exit;
                  end
            end;
      end;
    end;
    AssignFile(f,path);
    Rewrite(f);
    writeln(f,subscription);
    for i:=0 to length(Group)-1 do
      begin
        write(f,'#', Group[i].Identity,'|');
        write(f,inttostr(Group[i].BirthDate.Year),'|');
        write(f,inttostr(Group[i].BirthDate.Month),'|');
        write(f,inttostr(Group[i].BirthDate.Day),'|');
        if Group[i].IsMale
          then write(f,'M|')
          else write(f,'F|');
        write(f,inttostr(Group[i].Physics),'|');
        write(f,inttostr(Group[i].Math),'|');
        write(f,inttostr(Group[i].Informatics),'|');
        write(f,inttostr(Group[i].Payment),'|');
        write(f,{inttostr(}Group[i].PhoneNumber{)},'|');
        writeln(f,'');
      end;
    Close(f);
    result:=true;
  end;
//Функция записи в файл - КОНЕЦ
{*******************************************}

{******************************************************************************}
//ввод нового студента (в новый record) - НАЧАЛО
function InputRecord: TRStudent;

  {************************************************************}
  procedure subjscore(var subj:byte; caption:string);        {*}
  begin                                                      {*}
    repeat                                                   {*}
      Write(oem(caption),': ');                              {*}
      readln(subj);                                          {*}
      if (subj<2) or (subj>5)                                {*}
        then writeln(oem('Введенная оценка некорректна.'));  {*}
    until (subj>=2) and (subj<=5);                           {*}
  end;                                                       {*}
  {************************************************************}
  var
    i:integer;
    b:string;
    c:char;
  begin
    clrscr;
    for i:=1 to screenwidth do write('*');
    writeln;
    writeln(oem('Введите имя нового студента'));
    writeln(oem('Разрешены все символы, кроме ''|'''));
    read(b);
    result.Identity:=oem(b);
    writeln(oem('Дата рождения:'));
    write(oem('Год (в формате yyyy): '));
    readln(result.BirthDate.Year);
    if result.BirthDate.Year<1900
        then writeln(oem('Скорее всего, вы ввели неправильный год'));
    repeat
      write(oem('Месяц: '));
      readln(result.BirthDate.Month);
    until (result.BirthDate.Month > 0) and (result.BirthDate.Month < 13);
    repeat
      write(oem('День: '));
      readln(result.BirthDate.Day);
    until (result.BirthDate.Day > 0) and (result.BirthDate.Day < 31);
    if result.BirthDate.Day>29
      then writeln(oem('Проверьте точность введеннного числа по календарю, '),
                   oem(' т. к. эта программа не учитывает точное количество '),
                   oem('дней в месяце'));

    writeln(oem('Пол ([1]=М, [2]=Ж): '));
    repeat
      c:=readkey;
      if c='1'
        then
          begin
            result.IsMale:=True;
            writeln(oem('М'));
          end
        else if c='2'
               then
                 begin
                   result.IsMale:=False;
                   writeln(oem('Ж'));
                 end
               else writeln(oem('Неверное значение!'));
    until (result.IsMale=True) or (result.IsMale=False);

    Writeln(oem('Оценки (2-5)'));
    subjscore(result.Physics,'Физика');
    subjscore(result.Math,'Математика');
    subjscore(result.Informatics,'Информатика');

    writeln(oem('Стипендия(руб.): (Если ее нет - введите 0)'));
    readln(result.Payment);

    writeln(oem('Номер телефона (БЕЗ пробелов и/или дефисов!).'));
    writeln(oem(' Если телефона нет - поставьте 0'));
    readln(result.PhoneNumber);
  end;
//Процедура ввода нового студента - КОНЕЦ
{****************************************************************************}

procedure MenuAddRecord(var Group:TGroupList);
  var c:integer;
  begin
    c:=Length(Group);
    SetLength(Group,c+1);

    Group[c]:=InputRecord;

    writeln(oem('Запись добавлена'));
    ToMenu;
  end;

{******************************************************************************}
{*}  function FileStringToRecord(str: string): TRStudent;
{*}    var
{*}      b:string;            // буфер
{*}      c:char;
{*}      cur:integer;         // позиция курсора =)
{*}    //----------------------------------------------------------
{*}    function NumberToRecord(str:string; var cur:integer):integer;
{*}      var
{*}        b:string;
{*}        c:char;
{*}      begin
{*}       b:='';
{*}        while str[cur]<>'|' do
{*}          begin
{*}            c:=str[cur];
{*}            b:=b+c;
{*}            inc(cur);
{*}          end;
{*}        result:=strtoint(b);
{*}      end;
{*}    //----------------------------------------------------------
{*}    procedure KillSpaces(var str:string);
{*}      var
{*}        i:integer;
{*}        b:string;
{*}        c:char;
{*}      begin
{*}        for i:=1 to length(str) do
{*}          if str[i]<>#32
{*}            then
{*}              begin
{*}                c:=str[i];
{*}                b:=b+c;
{*}              end;
{*}        str:=b;
{*}      end;
{*}    //----------------------------------------------------------
{*}
{*}    begin
{*}      KillSpaces(str);
{*}      b:='';
{*}      cur:=2;
{*}// Курсор в строке установлен на втором символе (первый - '#')
{*}      while str[cur]<>'|' do
{*}        begin
{*}          c:=str[cur];
{*}          b:=b+c;
{*}          inc(cur);
{*}        end;
{*}     result.Identity:=b;
{*}
{*}      inc(cur);        // пропускаем служебный символ '|'
{*}      result.BirthDate.Year:=NumberToRecord(str,cur);
{*}      inc(cur);
{*}      result.BirthDate.Month:=NumberToRecord(str,cur);
{*}      inc(cur);
{*}      result.BirthDate.Day:=NumberToRecord(str,cur);
{*}      inc(cur);
{*}
{*}      if str[cur]='M'
{*}        then result.IsMale:=true
{*}        else result.IsMale:=false;
{*}      inc(cur);
{*}      inc(cur);
{*}
{*}      result.Physics:=NumberToRecord(str,cur);
{*}      inc(cur);
{*}      result.Math:=NumberToRecord(str,cur);
{*}      inc(cur);
{*}      result.Informatics:=NumberToRecord(str,cur);
{*}      inc(cur);
{*}
{*}      result.Payment:=NumberToRecord(str,cur);
{*}      inc(cur);
{*}      //result.PhoneNumber:=NumberToRecord(str,cur);
{*}      b:='';
{*}      while str[cur]<>'|' do
{*}        begin
{*}          c:=str[cur];
{*}          b:=b+c;
{*}          inc(cur);
{*}        end;
{*}      result.PhoneNumber:=b;
{*}
{*}    end;
{******************************************************************************}

procedure RecordOutput(i:integer;NameFieldLength:integer);
  var
    b:char;
    j:byte;
  begin
    with Group[i] do
      begin
        if IsMale
          then b:='М'
          else b:='Ж';
        write(#179,(i+1):3,#179,oem(Identity));
        for j:=1 to NameFieldLength-length(Identity) do write(' ');
        write(#179, BirthDate.Year:4,
          #179, BirthDate.Month:2,#179, BirthDate.Day:2,
          #179, oem(b), #179, Physics:3,
          #179, Math:3, #179, Informatics:3,
          #179, Payment:5,#179);
        writeln(PhoneNumber:15,#179);
      end;
  end;

{****************************************************************************}
//Меню редактирования записей (!!! Б#я, что я творю!!! =) ) - НАЧАЛО
procedure MenuEditRecord(var Group:TGroupList);
  label bg;
  var
    i:integer;
    n:integer;        // вводимый юзверем номер записи
    c:integer;        // буфер для чисел
    b:char;           // буфер для символов

  begin
    c:=Length(Group);
    if c=0
      then
        begin
          writeln(oem('Список не загружен или пуст.'));
          ToMenu;
          exit;
        end;

bg: clrscr;
    for i:=1 to screenwidth do write('*');
    writeln;
    n:=screenwidth-36-16;         // воспользовался n как буфером
    write(#218#196#196#196#194);
    for i:=1 to n do write(#196);
    write(#194#196#196#196#196#194#196#196#194#196#196#194#196#194);
    write(#196#196#196#194#196#196#196#194#196#196#196#194,
          #196#196#196#196#196#194);
    for i:=1 to 15 do write(#196);
    writeln(#191);

    n:=n-7;
    write(#179,oem(' № '),#179,oem('Фамилия'));for i:=1 to n do write(#32);
    write(#179,oem('Год '),#179,oem('Мс'),#179,oem('Дн'),#179,oem(' '),
          #179,oem('Физ'),#179,oem('Мат'),#179,oem('Инф'),#179,oem(' Ст-я'),
          #179,oem('Телефон'));
    for i:=1 to n-11 do write(#32); writeln(#179);
    n:=n+7;
    write(#195#196#196#196#197);
    for i:=1 to n do write(#196);
    write(#197#196#196#196#196#197#196#196#197#196#196#197#196#197);
    write(#196#196#196#197#196#196#196#197,
          #196#196#196#197#196#196#196#196#196#197);
    for i:=1 to 15 do write(#196); writeln(#180);

    for i:=0 to c-1 do
      RecordOutput(i,n);

 writeln(oem('Введите номер записи для редактирования, выбрав ее из списка'));
 writeln(oem('([0] - Выход): '));
    repeat
      readln(n);
      if n=0
        then
          begin
            for i:=1 to screenwidth do write('*');
            writeln;
            IsKickedToMenu:=true;
            exit;
          end;
      if n>c
        then writeln(oem('Нет такой записи'));
    until (n>=1) and (n<=c);

    writeln(oem('Для редактирования записи (в этой версии проги =) )'));
    writeln(oem('ее будет предложено ввести заново.'));
    write(oem('[1] - Ввести заново, [2] - Вернуться к выбору записи,'));
    writeln(oem(' [0] - Выход в меню'));
    repeat
      b:=readkey;
      if b='1'
        then
          begin
            writeln(oem('Ввести заново.'));
            Group[n-1]:=InputRecord;
            writeln(oem('Запись заменена'));
            writeln(oem('Нажмите любую клавишу'));
            readkey;
            goto bg;
          end;
      if b='2'
        then goto bg;
      if b='0'
        then
          begin
            ToMenu;
            exit;
          end;
    until (b='0') or (b='1') or (b='2');

    for i:=1 to screenwidth do write('*');
    writeln;
  end;
//Меню редактирования записей - КОНЕЦ
{****************************************************************************}

{****************************************************************************}
//Процедура для оформительства - вывод заголовка и главного меню - НАЧАЛО
procedure DrawHeader();

var
  i:integer;
  c:integer;    // Целочисленный буфер
begin
  // Крышка
  write(#218); for i:=1 to screenwidth-2 do write(#196); writeln(#191);

// Промежуток, заполненный пробелами, между краем экрана и заголовком
  c:=(screenwidth-2-length(mainheader)) shr 1;

  write(#179); for i:=1 to c do write(' ');
  write(oem(mainheader));

  if length(subheader)/2<>length(mainheader) shr 1 then inc(c);
  for i:=1 to c do write(' '); writeln(#179);

  // подчеркивание заголовка
  write(#195); for i:=1 to screenwidth-2 do write(#196); writeln(#180);

  c:=(screenwidth-2-length(subheader)) shr 1;

  write(#179); for i:=1 to c do write(' ');
  write(oem(subheader));

  if length(subheader)/2<>length(subheader) shr 1 then inc(c);
  for i:=1 to c do write(' '); writeln(#179);

  c:=screenwidth-2;
  c:=c shr 1;

  write(#198); for i:=1 to c do write(#205); write(#209);
  for i:=1 to c-1 do write(#205); writeln(#181);                     // Дно

end;
//Процедура оформительства - вывод заголовка и главного меню - КОНЕЦ
{****************************************************************************}

{****************************************************************************}
// Процедура отображения главного меню - НАЧАЛО

  procedure DrawMainMenu();
    var
      i:integer;
      c,c1:integer;

    begin
      c:=screenwidth - 2;
      c:=c shr 1;

      write(#179,'[1]', oem(btnNames[1]));
      c1:=c-length(btnNames[1])-3;
      for i:=1 to c1 do write(' ');

      write(#179,'[2]', oem(btnNames[2]));
      c1:=c-length(btnNames[2])-4;
      for i:=1 to c1 do write(' '); writeln(#179);

      write(#195); for i:=1 to c do write(#196); write(#197);
      for i:=1 to c-1 do write(#196); writeln(#180);

      write(#179,'[3]', oem(btnNames[3]));
      c1:=c-length(btnNames[3])-3;
      for i:=1 to c1 do write(' ');

      write(#179,'[4]', oem(btnNames[4]));
      c1:=c-length(btnNames[4])-4;
      for i:=1 to c1 do write(' '); writeln(#179);

      write(#195); for i:=1 to c do write(#196); write(#197);
      for i:=1 to c-1 do write(#196); writeln(#180);

      write(#179,'[5]', oem(btnNames[5]));
      c1:=c-length(btnNames[5])-3;
      for i:=1 to c1 do write(' ');

      write(#179,'[0]', oem(btnNames[0]));
      c1:=c-length(btnNames[0])-4;
      for i:=1 to c1 do write(' '); writeln(#179);

      write(#195); for i:=1 to c do write(#196); write(#193);
      for i:=1 to c-1 do write(#196); writeln(#217);

    end;

// Процедура отображения главного меню - КОНЕЦ
{****************************************************************************}

procedure ListInFileToArray(var f:textfile; var Group:TGroupList);
  var
    b:string;
    i:integer;
  begin
    reset(f);
    i:=0;
    while not eof(f) do
      begin
        b:='';
        readln(f,b);
        if b[1]='#'
// '#' - служебный символ, означающий начало(присутствие) записи
          then
            begin
              if b[2]<>'#'
// '##' - служебный символ, означающий удаленную запись.
//Поставлено на всякий случай, так как сама программа запишет записи в файл,
//пропуская удаленные
                then
                  begin                    //Ежели запись все-таки верная
                //то удлиняем Group на 1
                    SetLength(Group,i+1);
                // пишем в новый эл-т Group'a record
                    Group[i]:=FileStringToRecord(b);
                    inc(i);
                  end;
            end
      end;
  end;



{****************************************************************************}
// Процедура загрузки списка из файла  - НАЧАЛО
procedure MenuReadList(var Group:TGroupList);
    //Маза такая: прога грузит записи из файла в массив Group, и закрывает связь
    //с файлом!! Дальше она работает ТОЛЬКО с массивом в ее памяти.
    //При сохранении прога снова откроет файл списка, руководствуясь данными
    //переменной CurrentPath, СОТРЕТ ЕГО ПОЛНОСТЬЮ, и запишет данные из массива.

  label bg;
  var
    f:Textfile;
    c:char;         // символьный буфер
    path:string;
    i:integer;

  begin
    clrscr;
    for i:=1 to screenwidth do write('*');
    writeln;
    writeln(oem('Данная программа читает только верные файлы списка,'));
    writeln(oem('созданные ею самой!'));
bg: writeln(oem('Введите ПОЛНЫЙ путь к файлу, с указанием расширения: '));
    readln(path);

    if not FileExists(path)
      then
        begin
          writeln(oem('Указанного файла не существует. Создать его?'));
          writeln(oem('[1] - Ввести заново, [2] - Создать, [0] - Главное меню'));
          repeat
            c:=readkey;
          until (c='1') or (c='0') or (c='2');
          if c='1'
            then goto bg
            else if c='2'
              then CreateAndSubscribe(path,subscription)
              else
                begin
                  IsKickedToMenu:=true;
                  exit;
                end;
        end;

    AssignFile(f,path);   // В теории, досюда доползаем, если файл существует
    reset(f);             // или его удалось создать. Должно работать =)

    if not FileSubscribed(f)          // Проверка файла на подлинность
      then
        begin
          writeln(oem('Введенный путь указывает на неверный файл списка'));
          writeln(oem('[1] - Ввести заново, [0] - Главное меню'));
          repeat
            c:=readkey;
          until (c='1') or (c='0');
          if c='1'
            then goto bg
            else
              begin
                IsKickedToMenu:=true;
// exit на сл. строке выкинет в главную прогу после оператора сase, а там цикл
                exit;
              end;
// Конец проверки файла на подлинность.
//C этого момента файл считается верным и начинается его чтение
        end;

    ListInFileToArray(f, Group);

    writeln(oem('Список загружен успешно - '), path);
// Да! Да! ДА!!! Она это сделала!!
    writeln(oem('Записей в списке: '), Length(Group));
// Сохраняем путь к файлу в глобальной переменной.
    CurrentPath:=path;
    CloseFile(f);

    for i:=1 to screenwidth do write('*');
    writeln;
    IsKickedToMenu:=true;
   end;
// Процедура загрузки списка из файла - КОНЕЦ
{****************************************************************************}


procedure Solve521();
  var
    av:real;    // средний балл
    c:integer;
    i:integer;

  begin
    writeln(oem('Задача 5.2.1'));
    writeln(oem('Вывести фамилии и средние баллы студентов,'));
    writeln(oem('имеющих "5" по информатике'));

    c:=0;
    for i:=0 to Length(Group)-1 do
      begin
        if Group[i].Informatics=5
          then
            begin
              av:=(Group[i].Physics+Group[i].Math+Group[i].Informatics)/3;
              writeln(Group[i].Identity, oem('  средний балл '), av:3:2);
              inc(c);
            end;
      end;
    if c=0
      then writeln(oem('Отличников по информатике нет'))
      else writeln(oem('Отличников по информатике: '), c);
  end;


procedure Solve522();
  var
    cr:string[3];
    i,n:integer;
    nmb:string;

  begin
    writeln(oem('Задача 5.2.2'));
    writeln(oem('Вывести фамилии <студентов>,'));
    writeln(oem('чьи номера телефонов начинаются на три заданные цифры'));

    writeln(oem('Введите критерий отбора - число из РОВНО ТРЁХ цифр')) ;
    repeat
      readln(cr);
      try {n:=}strtoint(cr);
      except
        writeln(oem('Вы ввели не число. Повторите еще раз'));
      end;
      if not length(cr)=3
        then writeln(oem('из РОВНО ТРЕХ ЦИФР!'));
    until length(cr)=3;

    n:=0;
    for i:=0 to Length(Group)-1 do
      begin
        nmb:={inttostr(}Group[i].PhoneNumber{)};
        if pos(cr,nmb)=1
          then
            begin
              RecordOutput(i,screenwidth-36-16);
              inc(n);
            end;
      end;

    if n=0
      then writeln(oem('По запросу ничего не найдено'))
      else writeln(oem('Найдено записей: '), n);
  end;


procedure SecretWeapon();
  var
    i,L,j:integer;
    RdCount:byte;
    c:char;
    b:string;

  begin
    writeln(oem('Процедура-ленивчик для забивания массива'),
            oem(' случайными значениями =) '));
    writeln(oem('Внимание: текущие данные из массива Group будут УНИЧТОЖЕНЫ!'));

    writeln(oem('Нажмите [0] для возврата в главное меню,'),
            oem(' или любую другую кнопку для запуска'));
    if readkey='0' then exit;
    randomize;
    writeln(oem('Введите количество записей (от 1 до 255)'));
    repeat
      try
        readln(RdCount);
      except
        writeln(oem('Кончай прикалываться.'));
        RdCount:=0;
      end;
    until RdCount>0;
    SetLength(Group,RdCount);
    for i:=0 to RdCount-1 do
      begin
        L:=random(8)+4;
        b:='';
        for j:=1 to L do
          begin
            c:=chr(65+random(25));
            b:=b+c;
          end;
        Group[i].Identity:=b;
        Group[i].BirthDate.Year:=1980+random(20);
        Group[i].BirthDate.month:=1+random(12);
        Group[i].BirthDate.day:=1+random(28);
        Group[i].Physics:=random(4)+2;
        Group[i].Math:=random(4)+2;
        Group[i].Informatics:=random(4)+2;
        Group[i].Payment:=(random(13) shl random(4))*100;
        Group[i].PhoneNumber:=inttostr(1000000+random(8999999));
        if random(2)=1
          then Group[i].IsMale:=true
          else Group[i].IsMale:=false;
      end;
    writeln(oem('Готово!'));
    writeln(oem('Не забудьте сохранить только что созданное чудовище'))
  end;

procedure MenuTasks(var Group:TGroupList);
  var
    i:integer;
    c:char;
  begin
    for i:=1 to screenwidth do
      write('*');
    writeln;

    writeln(oem('[1] - Задача 1 (УП-10 "5.2.1")' ));
    writeln(oem('[2] - Задача 2 (УП-11,АиП-11 "5.2.2")' ));
    writeln(oem('[0] - Возврат в меню'));
    writeln(oem('[3] - Запустить ленивчик =) '));

    repeat
      c:=readkey;
    until (c='0') or (c='1') or (c='2') or (c='3');
    case c of
      '1' : Solve521;
      '2' : Solve522;
      '3' : SecretWeapon;
      end;
    ToMenu;
  end;

procedure MenuBlanking(var Group:TGroupList);
  var
    path:string;
    c:char;
    i:byte;
  label bg;
  begin
    clrscr;
    for i:=1 to screenwidth do
      write('*');
    writeln;
    writeln(oem('Сейчас текущий список, если он не пуст,'));
    writeln(oem('будет сохранен в файл, из к-го он был открыт, затем '));
    writeln(oem('вам будет предложено создать новый файл списка. Продолжить?'));
    writeln(oem('[anykey] - Продолжить, '));
    writeln(oem('[1] - Не сохранять в любом случае, '));
    writeln(oem('[0] - Возврат в меню'));
    c:=readkey;
    if c='0'
      then
        begin
          ToMenu;
          exit;
        end;

    if (c<>'1') and (Length(Group)>0)  // если не сказано НЕ сохранять
      then                             // и в списке есть эл-ты
        begin
          path:=CurrentPath;
          writeln(oem('Текущий путь сохранения:'), path);
bg:       if Saving(path)             //Если сохранено успешно,
            then
              begin
                writeln(oem('Сохранено успешно'));    //то сообщаем об этом
              end
            else     //Я с трудом представляю себе причину,
              begin  //при которой не удастся сохранить файл на диск
                writeln(oem('Не удаётся сохранить по текущему пути. Ввести новый? [1] - Да, [0] - Нет'));
                repeat
                  c:=readkey;
                until (c='0') or (c='1');
                if c='1'
                then
                  begin
                    writeln(oem('Да'));
                    writeln(oem('Введите новый путь к файлу, в к-й должен быть сохранен список'));
                    readln(path);
                    goto bg;
                  end
                else
                  begin
                    writeln(oem('Нет'));
                    ToMenu;
                    exit;
                  end;
              end;
        end;
// После сохранения (или пропуска сохранения) происходит собственно создание
    CreateList(path);                         // нового списка
//CreateList ПЕРЕДАЕТ path в кач-ве ВЫХОДНОГО значения!
    CurrentPath:=path;
    writeln(oem('Текущий рабочий путь:'), path);
    SetLength(Group,0);       // ОБНУЛЕНИЕ массива Group !!!
    ToMenu;
  end;

procedure WritePathToIni();
  var ini:textfile;
  begin
    AssignFile(ini,IniPath);
    rewrite(ini);
    writeln(ini,Currentpath);
    close(ini);
  end;

procedure MenuExit(var Group:TGroupList);
  var c:char;
  begin
    clrscr;
    writeln(oem('Сохранить список?'));
    writeln(oem('[1] - Сохранить и выйти, '));
    writeln(oem('[2] - Выйти без сохранения, '));
    writeln(oem('[3] - Сохранить без выхода :) , '));
    writeln(oem('[0] - Возврат к меню.'));
    repeat
      c:=readkey;
    until (c='1') or (c='0') or (c='2') or (c='3');

    case c of
      '2': IsKickedToMenu:=false;
      '0': ToMenu;
      '1': begin

    {}       writeln(oem('Сохранить по текущему пути? [Y/N]'));
    {}       repeat
    {}         c:=readkey;
    {}       until (c='N') or (c='n') or (c='Y') or (c='y');
    {}       if (c='n') or (c='N')
    {}         then
    {}           begin
    {}             writeln(oem('Введите новый путь сохранения'));
    {}             readln(CurrentPath);
    {}           end;
    {}
             if Saving(CurrentPath)
               then writeln(oem('Сохранено успешно'));
             WritePathToIni;
             writeln(oem('Нажмите любую клавишу'));
             readkey;
           end;
      '3': begin

    {}       writeln(oem('Сохранить по текущему пути? [Y/N]'));
    {}       repeat
    {}         c:=readkey;
    {}       until (c='N') or (c='n') or (c='Y') or (c='y');
    {}       if (c='n') or (c='N')
    {}         then
    {}           begin
    {}             writeln(oem('Введите новый путь сохранения'));
    {}             readln(CurrentPath);
    {}           end;

             if Saving(CurrentPath)
               then writeln(oem('Сохранено успешно'));
             WritePathToIni;
             ToMenu;
           end;
      end;

  end;

procedure BackgroundLoading(path:string; var Group:TGroupList);
  var
    f:text;
  begin
    if FileExists(path)
      then
        begin
          AssignFile(f,path);
          if FileSubscribed(f)
            then ListInFileToArray(f, Group)
            else CurrentPath:=DefaultPath;
          closeFile(f);
        end
      else CurrentPath:=DefaultPath;
  end;

procedure LoadPathFromIni(var path:string);
  var ini:textfile;
  begin
    try
      AssignFile(Ini,IniPath);
      Reset(Ini);
      readln(Ini,Path);
      Close(Ini);
    except
      AssignFile(Ini,IniPath);
      rewrite(ini);
      path:=DefaultPath;
      writeln(Ini,path);
      close(Ini);
    end;
  end;

{****************************************************************************}
// Собственно, сама прога =)  - НАЧАЛО
begin
  btnNames:=LoadBtnNames;
  SetLength(Group,0);

  LoadPathFromIni(CurrentPath);
  BackgroundLoading(CurrentPath, Group);

  while IsKickedToMenu do           // По-человечески: "Пока мы в меню..."
    begin
      clrscr;
      DrawHeader;
      DrawMainMenu;
      writeln(#179,oem('Текущий рабочий путь: '), CurrentPath);
      writeln(#179,oem('Записей в списке: '), Length(Group));
      writeln(#192#196#196);
      IsKickedToMenu:=false;
      repeat
        c:=readkey;
        try
          strtoint(c);
        except
          c:='6'
        end;
      until (strtoint(c)<=5) and (strtoint(c)>=0) ;
      writeln(oem(btnNames[strtoint(c)]));

      case c of
        '1': MenuAddRecord(Group);
        '2': MenuEditRecord(Group);
        '3': MenuBlanking(Group);
        '4': MenuReadList(Group);
// После выполнения(успешного) ReadList'а юзверь останется в этой менюшке,
// но в массиве Group будет располагаться список студентов,
// и цепь будет содержать записи, причем в том же порядке, что и в Group
        '5': MenuTasks(Group);
        '0': MenuExit(Group);
        end;
    end;
  //readkey;  нафиг не нужный   =)
end.

