program ex_2_5_2;

{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,
  U_My;                                  //��������������� ���������� ������ :)
var
  n:integer;                             //������� �������
  i,j:integer;
  main:Tmatrix;                           //���� ��� ������ � U_My.pas
  f:boolean=false;
  //��������� �������������� ��-��� �������� ������� ������� (������ ��������� ��������)
  X:array of byte;                       //������� ������
begin
  writeln(oem('������� ����� ������� ������� '));
  read(n);
  EnterMatrix(main,n,n);                 //��� ��������� ������� � U_My.pas
  SetLength(x,n);

  MatrixOutput(main,1,0,(oem('�������� �������:')));
 {��������!!! ������� ������� ��������!!!}
 {Xi=1 ���� ���� �� ���� ��-� � �������� ����� ��������� ����������� � ���������� ��-���}
  for j:=0 to n-1 do
    begin
      for i:=1 to n-2 do
        if main[i,j]=(main[i-1,j]+main[i+1,j])/2  //�������� ������������
          then f:=true;
      if f
        then x[j]:=1
        else x[j]:=0;
      f:=false;
    end;

  writeln(oem('��������'));                        //������ ��� ������, �� �� ������� ���������� �������
  for j:=0 to n-1 do
    begin
      writeln(oem('������� '),j+1);
      writeln(chr(179),oem('��-�'),chr(179),oem('���������'){,chr(179)});
      for i:=1 to n-2 do
        begin
          write(chr(179),main[i,j]:2:0,'  ',chr(179),'(',main[i-1,j]:2:0,'+',
                main[i+1,j]:2:0,')/2=',(main[i-1,j]+main[i+1,j])/2:3:1,
                chr(179),' ');
          //������� ��������� ��������� ��-�� � ��������
          if main[i,j]<(main[i-1,j]+main[i+1,j])/2
            then writeln('<')
            else if main[i,j]>(main[i-1,j]+main[i+1,j])/2
                    then writeln('>')
                    else writeln('=');
        end;
    end;

  writeln(oem('������� ������'));
  for i:=0 to n-1 do
    write(x[i],' ');
  readkey;
end.
