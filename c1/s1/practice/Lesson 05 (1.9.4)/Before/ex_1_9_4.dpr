program ex_1_9_4;

{$APPTYPE CONSOLE}

uses
  SysUtils
  ,crt32
  ,math
  ;

var
  x,y:real;
  coord:array of string;    //������ ��������� � ��������� ����
  count:byte;               //������ ���-�� ������� �����
  i:integer;                //�������
  n:integer;                //���������� �����
begin
  count:=0;
  writeln(oem('������� ���������� �����:'));
  read(n);
  setLength(coord,n);
  for i:=0 to n-1 do
    begin
      writeln(oem('���������� ����� �'),i+1);
      read(x,y);
      if (sqr(x)+sqr(y)<=4) and ( (y<=abs(x)-1) or (y>=abs(x)*(-1)+1) )
          then
            begin
              coord[count]:='('+floattostr(x)+';'+floattostr(y)+')';
              count:=count+1;
              writeln (oem('�����������'));
            end
    end;

  if count<>0
    then
      begin
        writeln(oem('���������� ������������� ������� �����:'),count);
        writeln(oem('�� ����������:'));
        for i:=0 to count-1 do
          writeln(coord[i]);
      end
    else writeln(oem('������ ����� ���'));
  readkey;
end.
