unit U_My;

interface
  uses crt32;
  type matrix=array of array of real;
  const RndSeed=8;
  procedure EnterMatrix(var a:matrix; rows,cols:integer);
  procedure MatrixOutput(var a:matrix; WholeFormat,DecFormat:integer; caption:string);
implementation

  procedure EnterMatrix(var a:matrix; rows,cols:integer);
    var i,j:integer;
    begin
      randomize;
      SetLength(a,rows,cols);
      For i:=0 to rows-1 do
        for j:=0 to cols-1 do
          a[i,j]:=random(RndSeed);
    end;

  procedure MatrixOutput(var a:matrix; WholeFormat,DecFormat:integer; caption:string);
    var i,j:integer;
    begin
      writeln(caption);
      for i:=0 to High(a) do
        begin
          for j:=0 to high(a[i]) do
            write(a[i,j]:WholeFormat:DecFormat,' ');
          writeln;
        end;
    end;
end.
