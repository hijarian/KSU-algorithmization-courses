// 1.4.2 #22
program test_1_4_2;

{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,math;

type
  MyArr=array of integer;

var
  X,Y:MyArr;   // �������� �������
  T:MyArr;     // �������������� ������
  i:integer;
  n,c:integer;   // ������  =)

// ��������
function RndLinArr(length:integer):MyArr;
  var i:integer;
  begin
    randomize;
    SetLength(result,length);
    for i:=0 to length-1 do
      result[i]:=random(length)-(length shr 1);
  end;

//�������� �����
begin
  writeln(oem('������� ����� ��������'));
  readln(n);

  //��������� � f-�� ��������� �������� ���������� �������
  X:=RndLinArr(n);
  Y:=RndLinArr(n);
  SetLength(T,n);

  n:=0;   //������ n ���-�� ��� �����
  for i:=0 to High(X) do
    begin
      c:=max(X[i],Y[i]);
      if c=X[i] then Inc(n);
      T[i]:=c;
    end;

//������� � ��������
  writeln;
  write('i',#179,' ');
  for i:=1 to (High(X)+1) do write(i:3,' ');
  writeln;
  for i:=0 to 70 do write(#196);


// ������� � ��-���� ������� X. ��-��, �������� � ������ T �������� �������
  writeln;
  write('X',#179,' ');
  for i:=0 to High(X) do
    begin
      if X[i]=T[i]
        then
          begin
            textcolor(12);
            write(X[i]:3,' ');
            textcolor(7);
          end
        else write(X[i]:3,' ');
    end;
  writeln;
  for i:=0 to 70 do write(#196);

  writeln;
  write('Y',#179,' ');
  for i:=0 to High(Y) do write(Y[i]:3,' ');
  writeln;
  for i:=0 to 70 do write(#196);

  writeln;
  write('T',#179,' ');
  for i:=0 to High(T) do write(T[i]:3,' ');
  writeln;
  for i:=0 to 70 do write(#196);

  writeln;
  writeln(oem('���������� ��������� ������� T, ���������� �� ������� X:'));
  writeln(n);

  writeln(oem('������� anykey'));
  readkey;
end.
