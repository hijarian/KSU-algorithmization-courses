unit U_My;

interface
  type matrix=array of array of real;
  const RndSeed=4;
  procedure EnterMatrix(var a:matrix; length,height:integer);
implementation
  procedure EnterMatrix(var a:matrix; length,height:integer);
    var i,j:integer;
    begin
      randomize;
      SetLength(a,length,height);
      For i:=0 to length-1 do
        for j:=0 to height-1 do
          a[i,j]:=random(RndSeed);
    end;
end.
 