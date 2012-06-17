program ex_4_2_3;
{����� � ������� Y ���������� ��-���, ������ �����-����(?) ��������� �� ������� X}
{$APPTYPE CONSOLE}

uses
  SysUtils,crt32;
label bg;
const
  MyArrayLength=20;
  rseed=20;

type
  MyArray=array[1..MyArrayLength] of integer;

var
  X:MyArray;
  Y:MyArray;
  i,j:integer;
  counter:byte=0;                   //��, ��� ����� ����� ������� =)

function ArrOut:MyArray;                 //��������� ��������, �#� !!
  var i:integer;
  begin
    randomize;
    for i:=1 to MyArrayLength do
      begin
        result[i]:=random(rseed);
        write(result[i]:2,' ');
      end;
    writeln;
  end;
// f-� ������ ���������� ������ ���������� (A[i]=B[i])
function m_count(A,B:MyArray):integer;
  var i:integer;
  begin
    result:=0;
    for i:=1 to MyArrayLength do
      if A[i]=B[i]
        then result:=result+1;
  end;
// f-� ������ ���������� ������������� ���������� (A[i]=B[_])
function m_otn(A,B:MyArray):integer;
  var i,j:integer;
  begin
    result:=0;
    for i:=1 to MyArrayLength do
      for j:=1 to MyArrayLength do
        if A[i]=B[j]
          then
            begin
              result:=result+1;
              break;
            end;
  end;

begin

bg:for i:=0 to 70 do write('*');
  writeln;

  write('i ',chr(179));
  for i:=1 to MyArrayLength do write(i:2,' ');
  writeln;
  write(chr(196),chr(196),chr(197));
  for i:=1 to MyArrayLength*3 do write(chr(196));
  writeln;

  write('X ',chr(179));
  X:=ArrOut;

  write(chr(196),chr(196),chr(197));
  for i:=1 to MyArrayLength*3 do write(chr(196));
  writeln;

  write('Y ',chr(179));
  Y:=ArrOut;

  writeln;
  writeln(oem('������� ����� ����� ����������� ��������� ����� ������ ��������: '),m_count(Y,X));
  writeln(oem('������ ������� �������������� =)'));
  writeln;

  writeln(oem('����� ����������� ��������...'));
  counter:=0;
  for i:=1 to MyArrayLength do
    if X[i]=Y[i]
      then
        begin
          counter:=counter+1;
          writeln('X[',i:2,']=',x[i]:2,'=  Y[',i:2,']  (=',Y[i]:2,')');     //'Xi=[Xi]=Yi    (=[Yi])'
        end;                          //����-� � ������� - ��� �������
  write('...');
  if counter=0
    then writeln(oem('�� ����������'))
    else case counter of
            1:writeln(counter,oem(' �����'));
            2..4:writeln(counter,oem(' �����'));
            else writeln(counter,oem(' ����'));
         end;

  //������ ������ ���������� �����!!!
  //SetLength(buffer,MyArrayLength);
  writeln;
  writeln(oem('������� ����� �������� ����������� ��������� ����� ������ ��������: '),m_otn(Y,X));
  writeln(oem('� ��� ���� ������� �������������� =)'));
  writeln;

  counter:=0;
  writeln(oem('�������� ����������� ��-��, (��� �� ����� ��� �� �������)'));
  for i:=1 to MyArrayLength do
    for j:=1 to MyArrayLength do
      if Y[i]=X[j]
        then
          begin
            counter:=counter+1;
            writeln('Y[',i:2,']= ',Y[i]:2,'=  X[',j:2,']   (=',X[j]:2,')');
            break;
          end;
  if counter>0
    then writeln(oem('�������� ����������� ���������: '),counter)
    else writeln(oem('�������� ����������� ��������� ���'));

  for i:=0 to 70 do write('*');
  writeln;

  writeln;
  writeln(oem('������� [1] ��� ������������ ��� ����� ������ ������ ��� ������'));
  writeln;writeln;
  if readkey='1' then goto bg;
end.
