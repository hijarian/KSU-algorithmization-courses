program ex_1_9_1;

{$APPTYPE CONSOLE}

uses
  SysUtils,crt32;
  var
    a,b,c:integer;
  label bg;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  bg:
  writeln(oem('������� ����� ������ a,b � c:'));
  read(a,b,c);
  if (a-b=c*a)and(b<=c)or not(a<b/c)and(b<>c)
    then writeln('true')
    else writeln('false');
  writeln(oem('������� ''1'', ����� ���������� �����������... '));
  if readkey='1' then goto bg;;
end.
