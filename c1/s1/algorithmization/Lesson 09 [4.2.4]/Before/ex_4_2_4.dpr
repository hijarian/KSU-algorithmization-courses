program ex_4_2_4;
//---------------------------------------------
//������������ ���������� �������� � ����������
//----------------------------------------------
//��������� ��������� ���������� ���������� �� �������� �����
//���������� ������� ��������� �� ������ �� ����� 2D ������� � ������������
//�����, � ���� �������, ������������ ���������� ���������
//...�� � ���� =)
{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,math;

const
  rseed=12;

type
  coord=array of integer;

var
  B:coord;
  C:coord;
  n:integer;                       //�������� ������� # ����������� ����� �� ���������
  x0,y0:integer;                     //�������� ������� ���������� ������� �����
  i:integer;
  Z:array of real;                //�-�-�-�!!! ������ ���������. =)

function distance(x,x0,y,y0:integer): real;           //���������� �������, ����������� ���������� �� ������� ����� �� �������
  begin
    distance:=sqrt( sqr(x-x0) + sqr(y-y0) );
  end;

procedure ya_zdesya_hozyain(B,C:coord;var Z:array of real);
var i:integer;                             //���������, ����� ������������� �������: ���������, ������� (� ���� ��������!) ������ �-� - ������� =)
  begin
    for i:=0 to high(B) do
      Z[i]:=distance(B[i],x0,C[i],y0);
  end;

begin
  { TODO -oUser -cConsole Main : Insert code here }
  writeln(oem('������! ������� ����� ���� ����?'));
  writeln(oem('������ �� ���� ������� �����, � �� ��� ��� ����� �����������!!'));
  read(n);
  if n>255 then writeln(oem('� ������������!!'));
  SetLength(B,n);
  SetLength(C,n);
  SetLength(Z,n);

  randomize;                                        //
  for i:=0 to n-1 do                                // ��� ������: ��������,
    begin                                           // ����� �� �������� ������� �������������� =)
      B[i]:=random(rseed);                          //
      C[i]:=random(rseed);                          //
    end;
  writeln(oem('������ ���� ���������� ������� ����� Z(x;y) : ����� ������ � �����!!'));
  read(x0,y0);

  ya_zdesya_hozyain(B,C,Z);                //�������� ���� �������� =)

  for i:=0 to n-1 do
    begin
      writeln('A[',i+1:-3,'](',B[i]:2,';',C[i]:2,')',chr(179),Z[i]:10:3);             //����� �-� ���� "|" ���������� �����. ����� � ��������� �� �������
      write('  sqrt( sqr( ',B[i]:2,'-',x0:2,' ) + sqr( ',C[i]:2,'-',y0:2,' )=');      //��� ���� - ����������� �� �����
      write('sqrt( ',sqr(B[i]-x0),' + ',sqr(C[i]-y0),' )=');                          //���������� ����, ��� ������ �������
      writeln('sqrt( ',sqr(B[i]-x0) + sqr(C[i]-y0),' )');                             //���� ����� ������ �� �� ������ =)
    end;

   writeln(oem('������ ����� ������ [ANYKEY]! =)'));
  readkey;
end.
