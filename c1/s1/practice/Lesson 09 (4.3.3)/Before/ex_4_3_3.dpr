program ex_4_3_3;
{��������� ������������� ��-�� � ������ ������� ����, ����� ��������
������ �� �������, ���������� ������������� ��-�� (��� ���� �������)}
{$APPTYPE CONSOLE}

uses
  SysUtils,crt32,U_My;

var
  main:Matrix;

procedure NegDown(var A:Matrix);

  var
    b:integer;            //����� ��� ����������� ��-��
    i,j:integer;          //������, ��� =)
    down:integer;
    //����� ������ ������� ���������������� ���������������� ��-�� ������

  begin
    for j:=Low(A[0]) to High(A[0]) do
    //�� ������ ������ �� ����� ������
      begin
        down:=High(A);
        //����� ������� ��-�� - ����� ����������
        i:=Low(A);
        while i < down do
        //�� ������ ������� �� ���������� �������������� ��-�� �������
// ���� �������� �� �������������� ��-��, �� ��������
          begin
            if A[i,j]<0
              then
                begin

// ������ ��������: ���� ������ ���������������� ��������������� ��-� �������� �������������
// �� �������� ��������� down ����� �� ��� ���, ���� �� ��������� �� �������. ��-�

                  if A[down,j]<0
                    then
                      repeat
                        dec(down);
                      until (A[down,j]>=0) or (down=i);
                      // ��� down=i ����� ��������� ��-� ��� � ����

// ������ ��������: ���������� �����. ��-� A[i,j] �� ����� A[down,j]
                  b:=A[i,j];
                  //������� ������������� ��-� -> �����

                  A[i,j]:=A[down,j];
                  //��������� (��������, ���������������) ��-� -> ������� ��-�

                  A[down,j]:=b;
                  //����� -> ����� ���������� ��-��

                  dec(down);
                  //����������� ��-�, ��-��, ������� ����
                  //������������� ��-��� ����������� �����

                end;
            inc(i);
          end;
      end;
  end;

procedure WriteUntilNeg(A:matrix);
  var i,j:integer;
  begin
    for i:=Low(A) to High(A) do
      begin
        for j:=Low(A[0]) to High(A[0]) do
          if A[i,j]<0 then exit;
        for j:=Low(A[0]) to High(A[0]) do
          write(A[i,j]:3,' ');
        writeln;
      end;
  end;

begin
  EnterMatrix(main,7,4);

  MatrixOutput(main,3,oem('�������� �������:'));

  NegDown(main);
  writeln;

  MatrixOutput(main,3,oem('��������������� �������:'));

  writeln;
  write(oem('������� �� ������ ������,'));
  writeln(oem(' ���������� ������������� �������'));
  WriteUntilNeg(main);

  readkey;
end.
