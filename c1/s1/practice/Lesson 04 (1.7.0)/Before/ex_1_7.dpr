program ex_1_7;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  crt32,
  math;

  var
  a,b,c:double;                        //������� ������� � ��� ����� ��������������
  lim:real;                            //������ ���������
  {fn_a,fn_b,}fn_c:real;               //������� �� a,b,c
  sg_a,sg_b,sg_c:integer;              //����� a,b,c (-1,1)
  flag:boolean;                        //��������� ����������� ����������

  function fn_x(x:double):double;          {���������� ����������� �-�,    }
   // var a:real;
    begin                                  {����������� � (� �� ������ ���)}
      // ����� ������ ���� ���� f-� �� ������, �� ��� ��� ����� ����-�� ���������� =)
      result:=sin(x);
    end;

begin
  writeln(oem('������� ������� � ������ ����� ������� AB (����� ������)'));
  read(a,b);
  writeln(oem('������� ������ ���������'));      //�� ������ ��� ������ ������ ����������!!!
  read(lim);

  if a>b
    then
      begin
        c:=a;
        a:=b;
        b:=c;
      end;

  flag:=false;
//������ MAIN �����... ����!!!
  repeat
    c:=a+(b-a)/2;
    fn_c:=fn_x(c);
{   fn_a:=fn_x(a);
    fn_b:=fn_x(b);  }
    {if fn_c=0                                          //��� ����������� ����� f(c)
      then                                             //���� f(c)=0 �� �-������
        begin                             // ����������� ���������� ������ =)
          writeln(oem('������� ������= '),c:6:2);
          writeln(oem('������� �����= '),fn_c:6:2);
          writeln(oem('������� ������ [anykey] :)'));
          readkey;
          halt;                         //����� �������� �������� �����
        end;}
    if fn_x(a)<0
      then sg_a:=-1
      else sg_a:=1;                {���������� ����� f(a) }
    if fn_x(b)<0
      then sg_b:=-1
      else sg_b:=1;                {              ...f(b) }
    if fn_c<0
      then sg_c:=-1                                //...
      else sg_c:=1;                               //...

    if sg_a=sg_b
      then
        begin
          writeln(oem('����� f(a) � f(b) ���������, ����� ����������'));
          writeln('f(a)= ',fn_x(a):6:2);
          writeln('f(b)= ',fn_x(b):6:2);
          writeln('f(c)= ',fn_c:6:2);
          writeln(oem('������� ������ [anykey] :)'));
          readkey;
          halt;
        end;
                             //...
    if sg_c=sg_b              //���� ����� f(c) � f(b) �����
      then b:=c;               //�������� (b) � �������� (c)
    if sg_c=sg_a
      then a:=c;              //����� �������� (a) � �������� (c)

    if b-a<lim
      then flag:=true;

  until flag;
//����� MAIN �����
  writeln(oem('�� ���������� ������� ��������� (������� '),lim:6:5,')');
  writeln(oem('��� ��������� x, ������ '),c:6:5,')');
  writeln(oem('������� ������ [anykey] :)'));
  readkey;
end.
