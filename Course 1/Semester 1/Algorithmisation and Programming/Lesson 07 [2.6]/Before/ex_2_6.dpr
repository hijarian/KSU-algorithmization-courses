program ex_2_6;
//��������� ������� �� �������� �������
{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,U_My;
var
  main:matrix;
  i:integer;

begin
  { TODO -oUser -cConsole Main : Insert code here }

  //������� 2 ������� 10 �����
//  EnterMatrix(main,10,2);
  SetLength(main,10,2);
  randomize;
  for i:=0 to 9 do                 //������ �����������, ���������� �������
    begin                           //���������� ������� :)
      main[i,0]:=50-i*4-2+(random(2));       //�����. ������=����� ������+ ����� �� 0 �� 2
      main[i,1]:=50-i*4-0+(random(2));     //�����. ������=����� ������+ ����� �� 2 �� 4
    end;                            //
  randomize;
  i:=random(9);                     //������� ����������� :)))
  // ���������� ������ ������ �������� ���������� ������ ������������� �� 4
  main[i,0]:=main[i,0]-10;

  MatrixOutput(main,2,0,'main:');   //����� ����� ����� �����

  writeln(oem(' � '),chr(179),oem('�����.R���.'),chr(179),oem('�����.R����.'));
  for i:=0 to 15 do write(chr(196));
  writeln;
  writeln(' 1 ',chr(179),main[0,1]:7:0);        //����� � �����. ������ ������� ������

  for i:=1 to 9 do                              //
    begin                                       //
      writeln(i+1:2,' ',chr(179),main[i,1]:7:0,main[i-1,0]:7:0);            //  MAIN ����
      if main[i,1]>=main[i-1,0] then break;     //
    end;
//  writeln;                                          //
  if i<10
    then writeln(i+1:2,oem('-� ������ �� ��������'))
    else writeln(oem('��� ������ ���� ������� ���� � �����')) ;
  readkey;
end.
