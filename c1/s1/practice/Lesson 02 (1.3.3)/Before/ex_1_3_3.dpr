program ex_1_3_3;

{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,math;
var
  H,r,l:real;       //����������: ������, �����. ������, ������� ������
  pl:real;          //��������� ���������
  V,Vsum,m:real;    //����� �������� ����������, ��������� �����, �������� �����
  N:integer;        // # �����������
  i:integer;        //�����������, ��� ���? :)
  R1:real;          //������ �������� �������� (����������)
begin
  writeln(oem('������� ���������� ������, ������ � ������� ���������, ����� ������:'));
  readln(r,h,l);
  writeln(oem('������� �������� ����� ��������� ���������'));
  readln(pl);
  writeln(oem('������� ���-�� ���������:'));
  readln(n);
  Vsum:=0;
  for i:=1 to n do begin
    R1:=sqr(r*sqrt(i));         //���������� �������� �������
    V:=(pi*(R1+l)-pi*R1)*h;     //����� �������
    V:=V+pi*(R1+l)*l;           //���������� � ��������� ���
    Vsum:=Vsum+V;               //���������� ���� ����� � ����� �������
    end;
  m:=Vsum*pl;
  writeln(oem('�����: '),m:15:4);
  writeln('press any key...');
  readkey;
end.
