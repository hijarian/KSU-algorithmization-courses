// !!!�-�-�-�!!! ���������, ��������!! =)

// ����� "������������ ���������", ������ ������.
// (�) �������� �� �, ������ 4606 ����� ����
// �������� �� �������� "��������������-11","������� ��������-10,11",
// ������� �������� �� �������� 5.2.1 � 5.2.2 ���������,
// ������� ������������� �������� ����������� (!) ����������, ����������
// ������������ �������� ����-�����, ���� � ���������� � ���������
// �������� ������� �������.

program ex_5_2_1;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  crt32,
  math;

const
// ��� ��������� - �� ������ �� ��������� ������.
// �� ������ ������, ��� ������ ���� ������!
  screenwidth:byte=78;
// ������� ����������� ����� ������ ���������
  subscription:string='// -S- listfile';

  IniPath:string='C:\My.ini';    // ���� � ����� ������������ =)
  DefaultPath:string='C:\1.txt'; // ���� �� ���������

// ���������
  mainheader:string='������������ ��������� v0.7';
  subheader:string='(��� ���������� �����������)';
// �������� ������
  btnLoad:string=' ��������� ������';
  btnNew:string=' ����� �������';
  btnSolve:string=' ������';
  btnEdit:string=' ������������� ������';
  btnExit:string=' ����� � ����������';
  btnNewList:string=' ������� ������ ������';

type                                            //ord('|')=124  !!
  Tdate=record
    Year:integer;
    month:integer;
    day:integer;
    end;
  TRStudent=record           // ��� ��������  ������, ����������� ��������
    Identity:string;         // ���
    BirthDate:Tdate;         // ���� ��������
    IsMale:boolean;          // true = �, false = �
    Physics:byte;            // ������ �� ������
    Math:byte;               // ������ �� ����������
    Informatics:byte;        // ������ �� �����������
    Payment:integer;         // ��������� (����� ���� �������������, ������ =) )
    PhoneNumber:string[12];  // ����� �������� (���������� ������� ������ 5.2.2)
    NextRecord:Pointer;      // ��������� �� ��������� ������
    end;

  TGroupList=array of TRStudent;
  TbtnNames=array of string;

var
// ��� ���������� ����������, � ������������ ����� ���������� � ��� ��������

// �������� ������, ������ ������������ �-�� ��������� ��� �����
  Group:TGrouplist;
  (****************)

  c:char;
  // ���������� ����� (����������� ��� ���������� ����)

  btnNames:TbtnNames;
  // ��-��, ������ � ���������� ��������!!

  isKickedToMenu:boolean=true;
  // �������������, ����������� ����������� � ���� (������, ����������� ��
  // ������������� ����������� � ����)

  CurrentPath:string;
  // ����� �������� ���� � �����, �� �������� ��� �������� ������� ������.


//**********************************���������� �������� � f-�  ���������� �����!
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
// ���������, �������� ������ ������������� �������, ����������� �������
// � ���� =)
Procedure ToMenu();
  var i:byte;
  begin
    writeln;
    writeln(oem('������� � ����'));
    for i:=1 to screenwidth do
      write('*');
    writeln;
    IsKickedToMenu:=true;
    writeln(oem('������� ����� �������'));
    readkey;
  end;
{**********************************************************************}

{***********************************************}
//�������� � ���������� ������ ����� ������- ������
  function CreateAndSubscribe(path:string; subscription:string):boolean;
    var f:TextFile;
    begin
      AssignFile(f,path);
      rewrite(f);
      write(f,subscription);
      CloseFile(f);
      result:=true;
    end;
//�������� � ���������� ������ ����� ������- �����
{***********************************************}

{***********************************************}
//�������, ���������� ������� ����� ���� - ������
function CreateList(var path:string):boolean;
  var
    r:boolean;
    c:char;
  begin
    writeln(oem('������� ���� � ������������ ������ (��� ������ ���)'));
    result:=false;
    repeat
      readln(path);
//    ����������� ������� CreateAndSubscribe, �, ����� ��� ����������� �������,
//    ������� �� �����
      if CreateAndSubscribe(path,subscription)
        then
          begin
            writeln(oem('���� ������ �������'));
            r:=false;
            result:=true;
          end
        else
          begin
            writeln(oem('�� ������� ������� ����'));
            writeln(oem('����������� ��� ���? [1] - �� , [0] - ���'));
            repeat
              c:=readkey;
            until (c='1') or (c='0');
            if c='0'
              then
                begin
                  writeln(oem('���'));
                  r:=false;
                  result:=false;
                end
              else
                begin
                  writeln(oem('��'));
                  r:=true;
                  writeln(oem('������� ��� �����'));
                end;
          end;
    until r=false;
  end;
//�������, ���������� ������� ����� ���� - �����
{***********************************************}

{*******************************************}
//����������, ������� ������ � ���� - ������
// ������������ ��� f-�� ��� ����������� ���������� ��������� �������� ����
// "�������"-"����������"
function Saving(var path:string):boolean;
  var
    f:textfile;
    c:char;
    i:integer;
  begin
    result:=false;
    writeln(oem('���������� �����.'));
    try
      AssignFile(f,path);       //
      Reset(f);
      Close(f);                 //
      Erase(f);                 // ��, ��, � ����������..
    except
      begin
        writeln(oem('���������� �������� ������ � ��������� �����'));
        writeln(oem('������� ����� ���� ������? [anykey] - ��,'),
                oem(' [0] - ������� � ����'));
        c:=readkey;
        if c='0'
          then
            begin
              ToMenu;
              exit;
            end
          else
            begin
              writeln(oem('������� � ��������� �������� �����...'));
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
//������� ������ � ���� - �����
{*******************************************}

{******************************************************************************}
//���� ������ �������� (� ����� record) - ������
function InputRecord: TRStudent;

  {************************************************************}
  procedure subjscore(var subj:byte; caption:string);        {*}
  begin                                                      {*}
    repeat                                                   {*}
      Write(oem(caption),': ');                              {*}
      readln(subj);                                          {*}
      if (subj<2) or (subj>5)                                {*}
        then writeln(oem('��������� ������ �����������.'));  {*}
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
    writeln(oem('������� ��� ������ ��������'));
    writeln(oem('��������� ��� �������, ����� ''|'''));
    read(b);
    result.Identity:=oem(b);
    writeln(oem('���� ��������:'));
    write(oem('��� (� ������� yyyy): '));
    readln(result.BirthDate.Year);
    if result.BirthDate.Year<1900
        then writeln(oem('������ �����, �� ����� ������������ ���'));
    repeat
      write(oem('�����: '));
      readln(result.BirthDate.Month);
    until (result.BirthDate.Month > 0) and (result.BirthDate.Month < 13);
    repeat
      write(oem('����: '));
      readln(result.BirthDate.Day);
    until (result.BirthDate.Day > 0) and (result.BirthDate.Day < 31);
    if result.BirthDate.Day>29
      then writeln(oem('��������� �������� ����������� ����� �� ���������, '),
                   oem(' �. �. ��� ��������� �� ��������� ������ ���������� '),
                   oem('���� � ������'));

    writeln(oem('��� ([1]=�, [2]=�): '));
    repeat
      c:=readkey;
      if c='1'
        then
          begin
            result.IsMale:=True;
            writeln(oem('�'));
          end
        else if c='2'
               then
                 begin
                   result.IsMale:=False;
                   writeln(oem('�'));
                 end
               else writeln(oem('�������� ��������!'));
    until (result.IsMale=True) or (result.IsMale=False);

    Writeln(oem('������ (2-5)'));
    subjscore(result.Physics,'������');
    subjscore(result.Math,'����������');
    subjscore(result.Informatics,'�����������');

    writeln(oem('���������(���.): (���� �� ��� - ������� 0)'));
    readln(result.Payment);

    writeln(oem('����� �������� (��� �������� �/��� �������!).'));
    writeln(oem(' ���� �������� ��� - ��������� 0'));
    readln(result.PhoneNumber);
  end;
//��������� ����� ������ �������� - �����
{****************************************************************************}

procedure MenuAddRecord(var Group:TGroupList);
  var c:integer;
  begin
    c:=Length(Group);
    SetLength(Group,c+1);

    Group[c]:=InputRecord;

    writeln(oem('������ ���������'));
    ToMenu;
  end;

{******************************************************************************}
{*}  function FileStringToRecord(str: string): TRStudent;
{*}    var
{*}      b:string;            // �����
{*}      c:char;
{*}      cur:integer;         // ������� ������� =)
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
{*}// ������ � ������ ���������� �� ������ ������� (������ - '#')
{*}      while str[cur]<>'|' do
{*}        begin
{*}          c:=str[cur];
{*}          b:=b+c;
{*}          inc(cur);
{*}        end;
{*}     result.Identity:=b;
{*}
{*}      inc(cur);        // ���������� ��������� ������ '|'
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
          then b:='�'
          else b:='�';
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
//���� �������������� ������� (!!! �#�, ��� � �����!!! =) ) - ������
procedure MenuEditRecord(var Group:TGroupList);
  label bg;
  var
    i:integer;
    n:integer;        // �������� ������� ����� ������
    c:integer;        // ����� ��� �����
    b:char;           // ����� ��� ��������

  begin
    c:=Length(Group);
    if c=0
      then
        begin
          writeln(oem('������ �� �������� ��� ����.'));
          ToMenu;
          exit;
        end;

bg: clrscr;
    for i:=1 to screenwidth do write('*');
    writeln;
    n:=screenwidth-36-16;         // �������������� n ��� �������
    write(#218#196#196#196#194);
    for i:=1 to n do write(#196);
    write(#194#196#196#196#196#194#196#196#194#196#196#194#196#194);
    write(#196#196#196#194#196#196#196#194#196#196#196#194,
          #196#196#196#196#196#194);
    for i:=1 to 15 do write(#196);
    writeln(#191);

    n:=n-7;
    write(#179,oem(' � '),#179,oem('�������'));for i:=1 to n do write(#32);
    write(#179,oem('��� '),#179,oem('��'),#179,oem('��'),#179,oem(' '),
          #179,oem('���'),#179,oem('���'),#179,oem('���'),#179,oem(' ��-�'),
          #179,oem('�������'));
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

 writeln(oem('������� ����� ������ ��� ��������������, ������ �� �� ������'));
 writeln(oem('([0] - �����): '));
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
        then writeln(oem('��� ����� ������'));
    until (n>=1) and (n<=c);

    writeln(oem('��� �������������� ������ (� ���� ������ ����� =) )'));
    writeln(oem('�� ����� ���������� ������ ������.'));
    write(oem('[1] - ������ ������, [2] - ��������� � ������ ������,'));
    writeln(oem(' [0] - ����� � ����'));
    repeat
      b:=readkey;
      if b='1'
        then
          begin
            writeln(oem('������ ������.'));
            Group[n-1]:=InputRecord;
            writeln(oem('������ ��������'));
            writeln(oem('������� ����� �������'));
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
//���� �������������� ������� - �����
{****************************************************************************}

{****************************************************************************}
//��������� ��� �������������� - ����� ��������� � �������� ���� - ������
procedure DrawHeader();

var
  i:integer;
  c:integer;    // ������������� �����
begin
  // ������
  write(#218); for i:=1 to screenwidth-2 do write(#196); writeln(#191);

// ����������, ����������� ���������, ����� ����� ������ � ����������
  c:=(screenwidth-2-length(mainheader)) shr 1;

  write(#179); for i:=1 to c do write(' ');
  write(oem(mainheader));

  if length(subheader)/2<>length(mainheader) shr 1 then inc(c);
  for i:=1 to c do write(' '); writeln(#179);

  // ������������� ���������
  write(#195); for i:=1 to screenwidth-2 do write(#196); writeln(#180);

  c:=(screenwidth-2-length(subheader)) shr 1;

  write(#179); for i:=1 to c do write(' ');
  write(oem(subheader));

  if length(subheader)/2<>length(subheader) shr 1 then inc(c);
  for i:=1 to c do write(' '); writeln(#179);

  c:=screenwidth-2;
  c:=c shr 1;

  write(#198); for i:=1 to c do write(#205); write(#209);
  for i:=1 to c-1 do write(#205); writeln(#181);                     // ���

end;
//��������� �������������� - ����� ��������� � �������� ���� - �����
{****************************************************************************}

{****************************************************************************}
// ��������� ����������� �������� ���� - ������

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

// ��������� ����������� �������� ���� - �����
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
// '#' - ��������� ������, ���������� ������(�����������) ������
          then
            begin
              if b[2]<>'#'
// '##' - ��������� ������, ���������� ��������� ������.
//���������� �� ������ ������, ��� ��� ���� ��������� ������� ������ � ����,
//��������� ���������
                then
                  begin                    //����� ������ ���-���� ������
                //�� �������� Group �� 1
                    SetLength(Group,i+1);
                // ����� � ����� ��-� Group'a record
                    Group[i]:=FileStringToRecord(b);
                    inc(i);
                  end;
            end
      end;
  end;



{****************************************************************************}
// ��������� �������� ������ �� �����  - ������
procedure MenuReadList(var Group:TGroupList);
    //���� �����: ����� ������ ������ �� ����� � ������ Group, � ��������� �����
    //� ������!! ������ ��� �������� ������ � �������� � �� ������.
    //��� ���������� ����� ����� ������� ���� ������, �������������� �������
    //���������� CurrentPath, ������ ��� ���������, � ������� ������ �� �������.

  label bg;
  var
    f:Textfile;
    c:char;         // ���������� �����
    path:string;
    i:integer;

  begin
    clrscr;
    for i:=1 to screenwidth do write('*');
    writeln;
    writeln(oem('������ ��������� ������ ������ ������ ����� ������,'));
    writeln(oem('��������� �� �����!'));
bg: writeln(oem('������� ������ ���� � �����, � ��������� ����������: '));
    readln(path);

    if not FileExists(path)
      then
        begin
          writeln(oem('���������� ����� �� ����������. ������� ���?'));
          writeln(oem('[1] - ������ ������, [2] - �������, [0] - ������� ����'));
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

    AssignFile(f,path);   // � ������, ������ ���������, ���� ���� ����������
    reset(f);             // ��� ��� ������� �������. ������ �������� =)

    if not FileSubscribed(f)          // �������� ����� �� �����������
      then
        begin
          writeln(oem('��������� ���� ��������� �� �������� ���� ������'));
          writeln(oem('[1] - ������ ������, [0] - ������� ����'));
          repeat
            c:=readkey;
          until (c='1') or (c='0');
          if c='1'
            then goto bg
            else
              begin
                IsKickedToMenu:=true;
// exit �� ��. ������ ������� � ������� ����� ����� ��������� �ase, � ��� ����
                exit;
              end;
// ����� �������� ����� �� �����������.
//C ����� ������� ���� ��������� ������ � ���������� ��� ������
        end;

    ListInFileToArray(f, Group);

    writeln(oem('������ �������� ������� - '), path);
// ��! ��! ��!!! ��� ��� �������!!
    writeln(oem('������� � ������: '), Length(Group));
// ��������� ���� � ����� � ���������� ����������.
    CurrentPath:=path;
    CloseFile(f);

    for i:=1 to screenwidth do write('*');
    writeln;
    IsKickedToMenu:=true;
   end;
// ��������� �������� ������ �� ����� - �����
{****************************************************************************}


procedure Solve521();
  var
    av:real;    // ������� ����
    c:integer;
    i:integer;

  begin
    writeln(oem('������ 5.2.1'));
    writeln(oem('������� ������� � ������� ����� ���������,'));
    writeln(oem('������� "5" �� �����������'));

    c:=0;
    for i:=0 to Length(Group)-1 do
      begin
        if Group[i].Informatics=5
          then
            begin
              av:=(Group[i].Physics+Group[i].Math+Group[i].Informatics)/3;
              writeln(Group[i].Identity, oem('  ������� ���� '), av:3:2);
              inc(c);
            end;
      end;
    if c=0
      then writeln(oem('���������� �� ����������� ���'))
      else writeln(oem('���������� �� �����������: '), c);
  end;


procedure Solve522();
  var
    cr:string[3];
    i,n:integer;
    nmb:string;

  begin
    writeln(oem('������ 5.2.2'));
    writeln(oem('������� ������� <���������>,'));
    writeln(oem('��� ������ ��������� ���������� �� ��� �������� �����'));

    writeln(oem('������� �������� ������ - ����� �� ����� �Ш� ����')) ;
    repeat
      readln(cr);
      try {n:=}strtoint(cr);
      except
        writeln(oem('�� ����� �� �����. ��������� ��� ���'));
      end;
      if not length(cr)=3
        then writeln(oem('�� ����� ���� ����!'));
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
      then writeln(oem('�� ������� ������ �� �������'))
      else writeln(oem('������� �������: '), n);
  end;


procedure SecretWeapon();
  var
    i,L,j:integer;
    RdCount:byte;
    c:char;
    b:string;

  begin
    writeln(oem('���������-�������� ��� ��������� �������'),
            oem(' ���������� ���������� =) '));
    writeln(oem('��������: ������� ������ �� ������� Group ����� ����������!'));

    writeln(oem('������� [0] ��� �������� � ������� ����,'),
            oem(' ��� ����� ������ ������ ��� �������'));
    if readkey='0' then exit;
    randomize;
    writeln(oem('������� ���������� ������� (�� 1 �� 255)'));
    repeat
      try
        readln(RdCount);
      except
        writeln(oem('������ �������������.'));
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
    writeln(oem('������!'));
    writeln(oem('�� �������� ��������� ������ ��� ��������� ��������'))
  end;

procedure MenuTasks(var Group:TGroupList);
  var
    i:integer;
    c:char;
  begin
    for i:=1 to screenwidth do
      write('*');
    writeln;

    writeln(oem('[1] - ������ 1 (��-10 "5.2.1")' ));
    writeln(oem('[2] - ������ 2 (��-11,���-11 "5.2.2")' ));
    writeln(oem('[0] - ������� � ����'));
    writeln(oem('[3] - ��������� �������� =) '));

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
    writeln(oem('������ ������� ������, ���� �� �� ����,'));
    writeln(oem('����� �������� � ����, �� �-�� �� ��� ������, ����� '));
    writeln(oem('��� ����� ���������� ������� ����� ���� ������. ����������?'));
    writeln(oem('[anykey] - ����������, '));
    writeln(oem('[1] - �� ��������� � ����� ������, '));
    writeln(oem('[0] - ������� � ����'));
    c:=readkey;
    if c='0'
      then
        begin
          ToMenu;
          exit;
        end;

    if (c<>'1') and (Length(Group)>0)  // ���� �� ������� �� ���������
      then                             // � � ������ ���� ��-��
        begin
          path:=CurrentPath;
          writeln(oem('������� ���� ����������:'), path);
bg:       if Saving(path)             //���� ��������� �������,
            then
              begin
                writeln(oem('��������� �������'));    //�� �������� �� ����
              end
            else     //� � ������ ����������� ���� �������,
              begin  //��� ������� �� ������� ��������� ���� �� ����
                writeln(oem('�� ������ ��������� �� �������� ����. ������ �����? [1] - ��, [0] - ���'));
                repeat
                  c:=readkey;
                until (c='0') or (c='1');
                if c='1'
                then
                  begin
                    writeln(oem('��'));
                    writeln(oem('������� ����� ���� � �����, � �-� ������ ���� �������� ������'));
                    readln(path);
                    goto bg;
                  end
                else
                  begin
                    writeln(oem('���'));
                    ToMenu;
                    exit;
                  end;
              end;
        end;
// ����� ���������� (��� �������� ����������) ���������� ���������� ��������
    CreateList(path);                         // ������ ������
//CreateList �������� path � ���-�� ��������� ��������!
    CurrentPath:=path;
    writeln(oem('������� ������� ����:'), path);
    SetLength(Group,0);       // ��������� ������� Group !!!
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
    writeln(oem('��������� ������?'));
    writeln(oem('[1] - ��������� � �����, '));
    writeln(oem('[2] - ����� ��� ����������, '));
    writeln(oem('[3] - ��������� ��� ������ :) , '));
    writeln(oem('[0] - ������� � ����.'));
    repeat
      c:=readkey;
    until (c='1') or (c='0') or (c='2') or (c='3');

    case c of
      '2': IsKickedToMenu:=false;
      '0': ToMenu;
      '1': begin

    {}       writeln(oem('��������� �� �������� ����? [Y/N]'));
    {}       repeat
    {}         c:=readkey;
    {}       until (c='N') or (c='n') or (c='Y') or (c='y');
    {}       if (c='n') or (c='N')
    {}         then
    {}           begin
    {}             writeln(oem('������� ����� ���� ����������'));
    {}             readln(CurrentPath);
    {}           end;
    {}
             if Saving(CurrentPath)
               then writeln(oem('��������� �������'));
             WritePathToIni;
             writeln(oem('������� ����� �������'));
             readkey;
           end;
      '3': begin

    {}       writeln(oem('��������� �� �������� ����? [Y/N]'));
    {}       repeat
    {}         c:=readkey;
    {}       until (c='N') or (c='n') or (c='Y') or (c='y');
    {}       if (c='n') or (c='N')
    {}         then
    {}           begin
    {}             writeln(oem('������� ����� ���� ����������'));
    {}             readln(CurrentPath);
    {}           end;

             if Saving(CurrentPath)
               then writeln(oem('��������� �������'));
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
// ����������, ���� ����� =)  - ������
begin
  btnNames:=LoadBtnNames;
  SetLength(Group,0);

  LoadPathFromIni(CurrentPath);
  BackgroundLoading(CurrentPath, Group);

  while IsKickedToMenu do           // ��-�����������: "���� �� � ����..."
    begin
      clrscr;
      DrawHeader;
      DrawMainMenu;
      writeln(#179,oem('������� ������� ����: '), CurrentPath);
      writeln(#179,oem('������� � ������: '), Length(Group));
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
// ����� ����������(���������) ReadList'� ������ ��������� � ���� �������,
// �� � ������� Group ����� ������������� ������ ���������,
// � ���� ����� ��������� ������, ������ � ��� �� �������, ��� � � Group
        '5': MenuTasks(Group);
        '0': MenuExit(Group);
        end;
    end;
  //readkey;  ����� �� ������   =)
end.

