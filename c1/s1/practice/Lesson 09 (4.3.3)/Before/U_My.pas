unit U_My;

interface
  uses crt32;
  type matrix=array of array of integer;
  const RndSeed=12;
  procedure EnterMatrix(var a:matrix; length,height:integer);
  procedure MatrixOutput(var a:matrix; Format:integer; caption:string);
implementation

  procedure EnterMatrix(var a:matrix; length,height:integer);
    var i,j:integer;
    begin
      randomize;
      SetLength(a,length,height);
      For i:=0 to length-1 do
        for j:=0 to height-1 do
          a[i,j]:=random(RndSeed)-7;
    end;

  procedure MatrixOutput(var a:matrix; Format:integer; caption:string);
    var i,j:integer;
    begin
      writeln(caption);
      for i:=0 to High(a) do
        begin
          for j:=0 to high(a[i]) do
            write(a[i,j]:Format,' ');
          writeln;
        end;
    end;
end.
