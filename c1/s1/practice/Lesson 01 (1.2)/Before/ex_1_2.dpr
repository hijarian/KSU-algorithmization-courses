program ex_1_2;
// ������������� f-��
{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,math;
var
  x,x1,res:real;  //�������� � �������� ��������
  a,b:real;    //�������
  n:integer;   // # ����� � �������
  step:real;  //� ���������� ����������� ����� ���������, ������� ��� - ��� ����� x-���
  i:integer;  //������������ �������
begin
  write(oem('������� ��������� ��������: '));
  readln(a);
  write(oem('������� �������� ��������: '));
  readln(b);
  write(oem('������� ���-�� �����: '));
  readln(n);
  if a>b                //���� ������ ������ �������� ������� :)
    then begin
      x:=a;
      a:=b;
      b:=x;
      end;
  x1:=a;
  step:=(b-a)/n;        //���������� a-b ������� �� n ��������
  writeln;              //����� ������ ���� ������ - ��������� ������� ;)

  for i:=0 to n do begin
    x:=x1+step*i;
    res:=abs(sin(power((10.5*x),0.5)))/(power(x,(2/3))-0.143)+2*pi*x;
    writeln(x:15:3,res:15:3);
    //writeln('press any key');
    //readkey;
    end;

  writeln('press any key');
  readkey;
end.
