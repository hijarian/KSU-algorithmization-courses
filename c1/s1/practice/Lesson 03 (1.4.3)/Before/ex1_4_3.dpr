program ex1_4_3;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  crt32;
var
  a:array of real;
  n:integer;
  min_A:real;
  i:byte;
  res:real;


begin
  Write(oem('������� ������ ���-�� ��������� �������: '));
  repeat                                   //�������� �� ��������
    read(n);                               //
  until (n/2)=(n shr 1);                   //

  SetLength(a,integer(n));

  randomize;                               //���� ������
  for i:=0 to n do                         //
    a[i]:=random(5)+1;                     //��������� =) {1..6}

  min_a:=abs(a[0])-abs(a[n-1]);
  writeln('abs(a[i])-abs(a[n-i+1])');
  writeln('min=abs(a[0])-abs(a[',n-1,']=',min_a:8:1);  //����� ������� ���. ��������

  for i:=1 to n-1 do begin
    res:=abs(a[i])-abs(a[n-i+1]);
    writeln('abs(a[',i,'])-abs(a[',n-i+1,'])=',res:8:1);   //����� �������� ��������
    if min_a>res
      then begin
        min_a:=res;
        writeln('min_a=',min_a:8:1);               //����� ���-�� ���. ��������
        end;
    end;

  writeln(oem('���������� �� ���������: '),min_a:8:1);
  readkey;
end.
