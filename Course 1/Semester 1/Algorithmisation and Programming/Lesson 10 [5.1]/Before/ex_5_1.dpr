program ex_5_1;
//����� �� ������� ����� ��� �����, ������������ � ��������� �������
{$APPTYPE CONSOLE}

uses
  SysUtils,crt32;

const
  path='C:\test.txt';

var
  f:Text;
  buffer:string;
  s:char;
  k:char;

begin
  { TODO -oUser -cConsole Main : Insert code here }
  writeln(oem('������� ������'));
  Readln(s);                            //��������� �����-�������

  AssignFile(f,path);               //����, ����������� �������� ����� � Read-only
//  FileMode:=0;                      //���������� Read-only, ���� ��� ������ ����� �� �����,
  Reset(f);                         //��� ��� ��� ������ � ��� ��������� � Read-only

  textcolor(3);                        //����� ������ ����� ������-�������
  while not Eof(f) do
    begin
      buffer:='';                                     //�������� �����
      repeat
        read(f,k);                                    //������ �� ������
        buffer:=buffer+k;                             //����� ����� � �����
      until (k=#13) or (k=#32) or (k=#$A);            //���� ������ ��� ����������� ����� - ������ ��� ���� ������ ����������� ������. ������ buffer - ��� �����

      if buffer[1]=s                   //���� ������ ����� buffer - �������, ��
        then
          begin
            textcolor(15);              //��� ���������� ����� ������
            writeln(oem(buffer));
            textcolor(3);
          end
        else if (buffer<>#13) and (buffer<>#32) and (buffer<>#$A)
        {���� ����� ������� ������ �� ����� ������ ��� �������
        (����� �� ��� ����� ��� �������� � �����), ������ �� ��������}
          then writeln(oem(buffer)); //���� ������ ����� ����� ������ - ����� ������ ����������
    end;
  CloseFile(f);        //��������� ����� � ������
  readkey;
end.
