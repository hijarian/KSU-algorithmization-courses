program ex_2_5_1;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  crt32,
  U_My in 'U_My.pas';

var
  main: matrix;
  i,j:integer;
  SC:integer=0;                  //������� ����� � ������ (StringCounter)
  CSZC:integer=0;                //������� ����� � ������� ������ (CurStrZeroCounter)
begin
  { TODO -oUser -cConsole Main : Insert code here }
  EnterMatrix(main,6,3);
  for i:=0 to 5 do
    begin
      for j:=0 to 2 do
        begin
          write(main[i,j]:1:0,' ');
          if main[i,j]=0
            then CSZC:=CSZC+1;
        end;
      write(chr(179)+' ');
      if CSZC>=2
        then
          begin
            writeln(oem(' � ���� ������ �� ������ ���� �����'));
            SC:=SC+1;
          end
        else writeln;
      CSZC:=0;
    end;
  if SC<>0
    then writeln(oem('����� � ������: '),SC)
    else writeln(oem('����� � ������ ���'));
  readkey;
end.
