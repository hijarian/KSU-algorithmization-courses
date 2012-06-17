unit U_DynamicChains;
// Вопрос: зачем надо было выделять типы и класс TChain в отдельный Unit?
// Ответ: чтобы не вскипел моск  %)
interface

  uses
    SysUtils,
    crt32
    //,ex_5_2_1 in 'ex_5_2_1.dpr'
    ;

  type

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

  TMainCursor=^TRStudent;

{------------------------------------------------------------------------------}
  { Ну, пожалуй, создав новый КЛАСС, я, возможно, смухлевал  =) ,
  зато динамическое распределение памяти работает =) }
  TChain=class

    CurrentPosition:TMainCursor;
    // Указатель на текущее звено цепи.
    // Весь смысл цепи заключается в этом указателе

    //data:TRStudent;
    // Здесь хранится КОПИЯ записи цепи, на к-ю указ-т CurrentPosition

    Count:integer;
    //Длина цепи

    Index:integer;
    //Номер текущего звена цепи (того, на к-й указывает CurrentPosition)

    FirstElAddr:TMainCursor;
    //Указатель, хранящий адрес первого звена цепи

    procedure ToFirst;
    // Переход к первому звену цепи

    procedure ClearChain();
    // Взрывает цепь к чертям и создает одно пустое звено

    procedure NewElement(idx:integer);
    // Вставляет новое звено цепи после указ-ного в index'е и увеличивает Count
    // Ставит CurrentPosition на новую запись

    procedure AppendElement();
    // Однострочная процедура, добавляющая звено после последнего в цепи

    procedure Seek(idx:integer);
    // Осуществляет переход по цепи до звена с номером index.
    // По окончании ее работы в data записана копия нужной записи, и в
    // CurrentPosition записан ее адрес.

    function EraseElement(idx:integer):byte;
    // Удаляет звено № "index" из цепи и уменьшает Count
    // Ставит CurrentPosition на запись, предшествующую удаленной

    constructor Init;
    // Пишет Count=1 и создает одно пустое звено по адресу FirstElAddr

    destructor Kill;

    procedure OutputList();
    //Пишет построчно эл-ты цепи
    //(формат номер - имя)

  end;
{------------------------------------------------------------------------------}

implementation

{----------------------------------------------}
constructor TChain.Init;
  begin
    with self do
      begin
        Count:=1;
        New(FirstElAddr);
        CurrentPosition:=FirstElAddr;
        Index:=1;
       // data:=CurrentPosition^;
      end;
  end;

destructor Tchain.Kill;
  begin
  end;

{----------------------------------------------}
procedure TChain.Seek(idx:integer);
  var
    pos:TMainCursor;
    i:integer;
  begin
    pos:=self.FirstElAddr;
  // Поставили ногу на первое звено цепи...
    self.Index:=1;

    i:=2;
    while i<=idx do
  // ...и сделали index-1 шагов по цепи вперед
  // Если index=1, то этот цикл вообще не выполнится
      begin
        pos:=pos^.NextRecord;
        inc(self.Index);
        inc(i);
      end;

   // Так как пришли куда надо, читаем данные и запоминаем, куда пришли =)
   // self.data:=pos^;
    self.CurrentPosition:=pos;
  end;

{----------------------------------------------}
procedure TChain.AppendElement();
begin
  self.NewElement(self.Count);
end;

{----------------------------------------------}
// Новый эл-т вставляется ПОСЛЕ указанного в ФРА этой процедуры
procedure TChain.NewElement(idx:integer);
  var
    mem:TMainCursor;
    p:TMainCursor;
  begin
    with self do
      begin
        self.Seek(idx);
        mem:=self.CurrentPosition^.NextRecord;
        p:=Self.CurrentPosition^.NextRecord;
        New(p);
      //  writeln(inttostr (longint(p) ) );
        Self.CurrentPosition^.NextRecord:=p;
        inc(self.count);
        self.Seek(idx+1);
        p^.NextRecord:=mem;
      end;
  end;

{----------------------------------------------}
// прооцедура стирает из памяти ВСЕ записи в цепи и создает одну пустую запись.
procedure TChain.ClearChain();
  begin
    self.Kill;
    self.Init;
  end;

{----------------------------------------------}
function TChain.EraseElement(idx:integer):byte;
{Коды результата:
1= Эл-т стерт из середины цепи и цепь восстановлена после этого
2= Эл-т не существует (index>count или index<1)
3= Стерт первый эл-т
можно еще "4= Стерт последний эл-т"
}
  var NextPos:Pointer;
  begin
    result:=2; // считаем по умолчанию, что ничего не получится =)
    if (idx>self.Count) or (idx<1)
      then exit;

    self.Seek(idx);
    NextPos:=self.CurrentPosition^.NextRecord;
    // Сохранить адрес звена цепи, на к-е указ-т текущее (удаляемое) |idx| ,
    // т.е. сохранить адрес след. записи |idx+1|

    Dispose(self.CurrentPosition);

    if idx=1  //Если удаляется первый эл-т цепи
      then
        begin
          self.FirstElAddr:=NextPos;
          result:=3;
        end
      else   //В любом другом сл-е
        begin
          Seek(idx-1);
          self.CurrentPosition^.NextRecord:=NextPos;
          result:=1;
        end;

    dec(self.Count);
  // сказали цепи, что у нее теперь на один эл-т меньше
  end;

{----------------------------------------------}
procedure TChain.ToFirst();
begin
  self.CurrentPosition:=self.FirstElAddr;
//  self.data:=self.CurrentPosition^;
end;

{----------------------------------------------}
procedure TChain.OutputList();
  var i:integer;
  begin
    with self do
    for i:=1 to Count do
      begin
        Seek(i);
        write(index);
        with CurrentPosition^ do
          writeln(oem(Identity));
      end;
  end;


end.
