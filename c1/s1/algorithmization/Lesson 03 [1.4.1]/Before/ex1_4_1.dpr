program ex1_4_1;


{$APPTYPE CONSOLE}

uses
  SysUtils,
  crt32;

var
  n:integer;                    //����������� �������
  X:array of real;
  i:integer;
  res:real;                     //������-�
begin
  { TODO -oUser -cConsole Main : Insert code here }
  //i:=1;
  res:=1;
  write(oem('������� ���������� ���������: '));
  read(n);
  n:=n-1;
  SetLength(x,n);

  randomize;             //
  for i:=0 to n do       //�������� ������
    x[i]:=random(4)+1;   //���������� �������

  i:=0;
  while i<=n do begin    //������������
    res:=res*x[i];       //
    i:=i+3;              //
    end;

  write(oem('������ �����: '));
  for i:=0 to n do
    write(x[i]:6:2,' ');

  writeln;

  write(oem('��������� ������������='),res:8:3);
  readkey;
end.
