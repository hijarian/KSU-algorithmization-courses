unit L01Tests;

interface 

uses
   TestFramework, L01Code;

type
   Lesson1Tests = class(TTestCase)
   published    
      procedure TestZeroInput;
   end;

procedure RegisterTests;

implementation

procedure RegisterTests;
begin
   TestFramework.RegisterTest(Lesson1Tests.Suite);
end;

procedure Lesson1Tests.TestZeroInput;
begin
   Check(MyFunction(0) = 0, 'Function should be 0 when x is 0');
end; { Lesson1Tests }

initialization
end.



