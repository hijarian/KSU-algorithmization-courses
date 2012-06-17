// ���. ���-11 ������������ ���������� �������� ������ ������� � ��������������
// ���������� � ������������� ������������� ������.

program ex_Final;
{$APPTYPE CONSOLE}

uses
  SysUtils,
  CRT32,
  U_DynamicChains ;

const
// ��� ��������� - �� ������ �� ��������� ������.
// �� ������ ������, ��� ������ ���� ������!
  screenwidth:byte=78;
// ������� ����������� ����� ������ ���������
  subscription:string='// -S- listfile';

// ���������
  mainheader:string='������������ ��������� v0.9';
  subheader:string='(���������� ����)';
// �������� ������
  btnLoad:string=' ��������� ������';
  btnNew:string=' ����� �������';
  btnSolve:string=' ������';
  btnEdit:string=' ������������� ������';
  btnExit:string=' �����';
  btnNewList:string=' ���������� ������';

type                                            //ord('|')=124  !!
//  TGroupList=array of TRStudent;
  TbtnNames=array[0..5] of string;

var
// ��� ���������� ����������, � ������������ ����� ���������� � ��� ��������

// �������� ������, ������ ������������ �-�� ��������� ��� �����
//  Group:TGrouplist;
  (****************)

// ����, ����������� ������� ������ "���-11" � ������� ������� �������.
  chain:TChain;
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
  //SetLength(Result,6);
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

{procedure RecordToFile(rd:TRStudent);
  var i:integer;
  begin

  end;}


{*******************************************}
//����������, ������� ������ � ���� - ������
// ������������ ��� f-�� ��� ����������� ���������� ��������� �������� ����
// "�������"-"����������"
function Saving(var path:string):boolean;
  var
    f:textfile;
    i:integer;
    data:TRStudent;
  begin
    writeln(oem('���������� �����.'));
    writeln(oem('������� ���� ����������:'));
    read(path);
    AssignFile(f,path);
    Rewrite(f);
    writeln(f,subscription);

    for i:=1 to chain.Count do
      begin
        chain.Seek(i);
        data:=chain.CurrentPosition^;
        write(f,'#', data.Identity,'|');
        write(f,inttostr(data.BirthDate.Year),'|');
        write(f,inttostr(data.BirthDate.Month),'|');
        write(f,inttostr(data.BirthDate.Day),'|');
        if data.IsMale
          then write(f,'M|')
          else write(f,'F|');
        write(f,inttostr(data.Physics),'|');
        write(f,inttostr(data.Math),'|');
        write(f,inttostr(data.Informatics),'|');
        write(f,inttostr(data.Payment),'|');
        writeln(f,data.PhoneNumber,'|');
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

    writeln(oem('����� ��������'));
    readln(result.PhoneNumber);
  end;
//��������� ����� ������ �������� - �����
{****************************************************************************}

procedure MenuAddRecord(var Chain:TChain);
  begin
    Chain.AppendElement;
    Chain.CurrentPosition^:=InputRecord;

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

procedure RecordOutput(var chain:TChain; i:integer; NameFieldLength:integer);
  var
    b:char;
    j:byte;
  begin
    chain.Seek(i);
    with chain.CurrentPosition^ do
      begin
        if IsMale
          then b:='�'
          else b:='�';
        write(#179,(i):3,#179,oem(Identity));
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
procedure MenuEditRecord(var Chain:TChain);
  label bg;
  var
    i:integer;
    n:integer;        // �������� ������� ����� ������
    c:integer;        // ����� ��� �����
    b:char;           // ����� ��� ��������

  begin
    if chain.Count=0
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

 c:=chain.Count;
{---------------------------------}
    for i:=1 to c do
      RecordOutput(chain,i,n);
{---------------------------------}

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
            chain.Seek(n);
            chain.CurrentPosition^:=InputRecord;
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

procedure ListInFileToChain(var f:textfile; var chain:TChain);
  var
    b:string;
  begin
    reset(f);
    Chain.ToFirst;
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
                // ����� � ����� ��-� Group'a record
                    chain.CurrentPosition^:=FileStringToRecord(b);
                    chain.AppendElement;
                  end;
            end
      end;
    chain.EraseElement(chain.Count);
  end;



{****************************************************************************}
// ��������� �������� ������ �� �����  - ������
procedure MenuReadList(var Chain:TChain);
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

    ListInFileToChain(f, Chain);

    writeln(oem('������ �������� ������� - '), path);
// ��! ��! ��!!! ��� ��� �������!!
    writeln(oem('������� � ������: '), chain.count);
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
    data:TRStudent;

  begin
    writeln(oem('������ 5.2.1'));
    writeln(oem('������� ������� � ������� ����� ���������,'));
    writeln(oem('������� "5" �� �����������'));

    c:=0;
    for i:=1 to chain.Count do
      begin
        chain.Seek(i);
        data:=chain.CurrentPosition^;
        if data.Informatics=5
          then
            begin
              av:=(data.Physics+data.Math+data.Informatics)/3;
              writeln(data.Identity, oem('  ������� ���� '), av:3:2);
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
      try strtoint(cr);
      except
        writeln(oem('�� ����� �� �����. ��������� ��� ���'));
      end;
      if not length(cr)=3
        then writeln(oem('�� ����� ���� ����!'));
    until length(cr)=3;

    n:=0;
    for i:=1 to chain.Count do
      begin
        Chain.Seek(i);
        nmb:=Chain.CurrentPosition^.PhoneNumber;
        if pos(cr,nmb)=1
          then
            begin
              RecordOutput(chain,i,screenwidth-36-16);
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
    writeln(oem('��������: ������� ������ � ���� ����� ����������!'));

    writeln(oem('������� [0] ��� �������� � ������� ����,'),
            oem(' ��� ����� ������ ������ ��� �������'));
    if readkey='0' then exit;

    randomize;

    writeln(oem('������� ���������� ������� (�� 1 �� 255)'));
    readln(RdCount);

    chain.ToFirst;
    for i:=1 to RdCount do
      begin
        L:=random(8)+4;                  {}
        b:='';                           {  ��� ������� ��������� �����}
        for j:=1 to L do                 {  ���� ������ 4-12 ��-���}
          begin                          {}
            c:=chr(65+random(25));       {}
            b:=b+c;                      {}
          end;                           {}
        with chain.CurrentPosition^ do
          begin
            Identity:=b;                 {}
            BirthDate.Year:=1980+random(20);
            BirthDate.month:=1+random(12);
            BirthDate.day:=1+random(28);
            Physics:=random(4)+2;
            Math:=random(4)+2;
            Informatics:=random(4)+2;
            Payment:=(random(13) shl random(4))*100;
            PhoneNumber:=inttostr(1000000+random(8999999));
        if random(2)=1
          then IsMale:=true
          else IsMale:=false;
          end;  // with chain.currentposition^
        chain.AppendElement;
      end;
    chain.EraseElement(chain.Count);
    writeln(oem('������!'));
    writeln(oem('�� �������� ��������� ������ ��� ��������� ��������'))
  end;

procedure MenuTasks(var Chain:TChain);
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

procedure MenuExit(var Chain:TChain);
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
    {}'1': begin
    {}       if Saving(CurrentPath)
    {}         then writeln(oem('��������� �������'));
    {}       writeln(oem('������� ����� �������'));
    {}       readkey;
           end;
    {}'3': begin
    {}       if Saving(CurrentPath)
    {}         then writeln(oem('��������� �������'));
    {}       ToMenu;
           end;
      end;
  end;

{****************************************************************************}
// ����������, ���� ����� =)  - ������
begin
  btnNames:=LoadBtnNames;
  chain:=TChain.Create;
  chain.Init;

  while IsKickedToMenu do           // ��-�����������: "���� �� � ����..."
    begin
      clrscr;
      DrawHeader;
      DrawMainMenu;
      writeln(#179,oem('������� ������� ����: '), CurrentPath);
      writeln(#179,oem('������� � ������: '), chain.count);
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
        '1': MenuAddRecord(Chain);
        '2': MenuEditRecord(Chain);
        '3': Saving(CurrentPath);
        '4': MenuReadList(Chain);
// ����� ����������(���������) ReadList'� ������ ��������� � ���� �������,
// �� � ������� Group ����� ������������� ������ ���������,
// � ���� ����� ��������� ������, ������ � ��� �� �������, ��� � � Group
        '5': MenuTasks(Chain);
        '0': MenuExit(Chain);
        end;
    end;
  //readkey;  ����� �� ������   =)
end.



