unit U_My;

interface
  uses crt32;
  type Tmatrix=array of array of real;
  const RndSeed=5;
  procedure EnterMatrix(var a:Tmatrix; length,height:integer);
  procedure MatrixOutput(var a:Tmatrix; WholeFormat,DecFormat:integer; caption:string);
implementation

  procedure EnterMatrix(var a:Tmatrix; length,height:integer);
    var i,j:integer;
    begin
      randomize;
      SetLength(a,length,height);
      For i:=0 to length-1 do
        for j:=0 to height-1 do
          a[i,j]:=random(RndSeed);
    end;

  procedure MatrixOutput(var a:Tmatrix; WholeFormat,DecFormat:integer; caption:string);
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
