program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,math;
var
  x,sum:real;   //�������� � �������� ��������
  k,n:integer;  //������� � ��� ������� ������
begin
  { TODO -oUser -cConsole Main : Insert code here }
  writeln('Enter x here:');              //
  readln(x);                             //
  writeln('Enter number of iterations:');//�������������
  readln(n);                             //
  Sum:=0;                                //

  for k:=1 to n do
    Sum:=Sum+(sqr(abs(x-k))*sqrt(exp(k-1))/(ln(2+power(x,k))+power(x,(2*k+1))));

  Sum:=Sum*exp(power((x/n),0.5));        //����� �������� �� �����������

  writeln('result: ',sum:12:3);               //�����

  writeln('press any key to exit');              //����������
  readkey;
end.
