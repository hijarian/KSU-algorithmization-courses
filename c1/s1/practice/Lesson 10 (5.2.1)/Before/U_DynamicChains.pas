unit U_DynamicChains;
// ������: ����� ���� ���� �������� ���� � ����� TChain � ��������� Unit?
// �����: ����� �� ������� ����  %)
interface

  uses
    SysUtils,
    crt32
    //,ex_5_2_1 in 'ex_5_2_1.dpr'
    ;

  type

  Tdate=record
    Year:integer;
    month:integer;
    day:integer;
    end;
  TRStudent=record           // ��� ��������  ������, ����������� ��������
    Identity:string;         // ���
    BirthDate:Tdate;         // ���� ��������
    IsMale:boolean;          // true = �, false = �
    Physics:byte;            // ������ �� ������
    Math:byte;               // ������ �� ����������
    Informatics:byte;        // ������ �� �����������
    Payment:integer;         // ��������� (����� ���� �������������, ������ =) )
    PhoneNumber:string[12];  // ����� �������� (���������� ������� ������ 5.2.2)
    NextRecord:Pointer;      // ��������� �� ��������� ������
    end;

  TMainCursor=^TRStudent;

{------------------------------------------------------------------------------}
  { ��, �������, ������ ����� �����, �, ��������, ���������  =) ,
  ���� ������������ ������������� ������ �������� =) }
  TChain=class

    CurrentPosition:TMainCursor;
    // ��������� �� ������� ����� ����.
    // ���� ����� ���� ����������� � ���� ���������

    //data:TRStudent;
    // ����� �������� ����� ������ ����, �� �-� ����-� CurrentPosition

    Count:integer;
    //����� ����

    Index:integer;
    //����� �������� ����� ���� (����, �� �-� ��������� CurrentPosition)

    FirstElAddr:TMainCursor;
    //���������, �������� ����� ������� ����� ����

    procedure ToFirst;
    // ������� � ������� ����� ����

    procedure ClearChain();
    // �������� ���� � ������ � ������� ���� ������ �����

    procedure NewElement(idx:integer);
    // ��������� ����� ����� ���� ����� ����-���� � index'� � ����������� Count
    // ������ CurrentPosition �� ����� ������

    procedure AppendElement();
    // ������������ ���������, ����������� ����� ����� ���������� � ����

    procedure Seek(idx:integer);
    // ������������ ������� �� ���� �� ����� � ������� index.
    // �� ��������� �� ������ � data �������� ����� ������ ������, � �
    // CurrentPosition ������� �� �����.

    function EraseElement(idx:integer):byte;
    // ������� ����� � "index" �� ���� � ��������� Count
    // ������ CurrentPosition �� ������, �������������� ���������

    constructor Init;
    // ����� Count=1 � ������� ���� ������ ����� �� ������ FirstElAddr

    destructor Kill;

    procedure OutputList();
    //����� ��������� ��-�� ����
    //(������ ����� - ���)

  end;
{------------------------------------------------------------------------------}

implementation

{----------------------------------------------}
constructor TChain.Init;
  begin
    with self do
      begin
        Count:=1;
        New(FirstElAddr);
        CurrentPosition:=FirstElAddr;
        Index:=1;
       // data:=CurrentPosition^;
      end;
  end;

destructor Tchain.Kill;
  begin
  end;

{----------------------------------------------}
procedure TChain.Seek(idx:integer);
  var
    pos:TMainCursor;
    i:integer;
  begin
    pos:=self.FirstElAddr;
  // ��������� ���� �� ������ ����� ����...
    self.Index:=1;

    i:=2;
    while i<=idx do
  // ...� ������� index-1 ����� �� ���� ������
  // ���� index=1, �� ���� ���� ������ �� ����������
      begin
        pos:=pos^.NextRecord;
        inc(self.Index);
        inc(i);
      end;

   // ��� ��� ������ ���� ����, ������ ������ � ����������, ���� ������ =)
   // self.data:=pos^;
    self.CurrentPosition:=pos;
  end;

{----------------------------------------------}
procedure TChain.AppendElement();
begin
  self.NewElement(self.Count);
end;

{----------------------------------------------}
// ����� ��-� ����������� ����� ���������� � ��� ���� ���������
procedure TChain.NewElement(idx:integer);
  var
    mem:TMainCursor;
    p:TMainCursor;
  begin
    with self do
      begin
        self.Seek(idx);
        mem:=self.CurrentPosition^.NextRecord;
        p:=Self.CurrentPosition^.NextRecord;
        New(p);
      //  writeln(inttostr (longint(p) ) );
        Self.CurrentPosition^.NextRecord:=p;
        inc(self.count);
        self.Seek(idx+1);
        p^.NextRecord:=mem;
      end;
  end;

{----------------------------------------------}
// ���������� ������� �� ������ ��� ������ � ���� � ������� ���� ������ ������.
procedure TChain.ClearChain();
  begin
    self.Kill;
    self.Init;
  end;

{----------------------------------------------}
function TChain.EraseElement(idx:integer):byte;
{���� ����������:
1= ��-� ����� �� �������� ���� � ���� ������������� ����� �����
2= ��-� �� ���������� (index>count ��� index<1)
3= ����� ������ ��-�
����� ��� "4= ����� ��������� ��-�"
}
  var NextPos:Pointer;
  begin
    result:=2; // ������� �� ���������, ��� ������ �� ��������� =)
    if (idx>self.Count) or (idx<1)
      then exit;

    self.Seek(idx);
    NextPos:=self.CurrentPosition^.NextRecord;
    // ��������� ����� ����� ����, �� �-� ����-� ������� (���������) |idx| ,
    // �.�. ��������� ����� ����. ������ |idx+1|

    Dispose(self.CurrentPosition);

    if idx=1  //���� ��������� ������ ��-� ����
      then
        begin
          self.FirstElAddr:=NextPos;
          result:=3;
        end
      else   //� ����� ������ ��-�
        begin
          Seek(idx-1);
          self.CurrentPosition^.NextRecord:=NextPos;
          result:=1;
        end;

    dec(self.Count);
  // ������� ����, ��� � ��� ������ �� ���� ��-� ������
  end;

{----------------------------------------------}
procedure TChain.ToFirst();
begin
  self.CurrentPosition:=self.FirstElAddr;
//  self.data:=self.CurrentPosition^;
end;

{----------------------------------------------}
procedure TChain.OutputList();
  var i:integer;
  begin
    with self do
    for i:=1 to Count do
      begin
        Seek(i);
        write(index);
        with CurrentPosition^ do
          writeln(oem(Identity));
      end;
  end;


end.
