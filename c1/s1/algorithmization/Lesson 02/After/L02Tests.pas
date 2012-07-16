unit L02Tests;

interface 

uses
   TestFramework, 
   L02Code;

type
   Lesson02Tests = class(TTestCase)
   published    
      procedure TestMymodWithValidInput;
      procedure TestMysqreWithValidInput;
      procedure TestMylnWithValidInput;
      procedure TestCannotDivideByZero; 
      procedure TestIterationShouldRunWithAnyX;
   end;

procedure RegisterTests;

implementation

uses
   math, sysutils;

const
   precision = 0.0001;

procedure RegisterTests;
begin
   TestFramework.RegisterTest(Lesson02Tests.Suite);
end;

procedure Lesson02Tests.TestMymodWithValidInput;
begin
   Check(Mymod(2, 4) - 4 < precision);
   Check(Mymod(4, 2) - 4 < precision);
   Check(Mymod(-4, 2) - 36 < precision);
   Check(Mymod(4, -2) - 36 < precision);
   Check(Mymod(0, -3) - 9 < precision);
   Check(Mymod(-3, 0) - 9 < precision);
end;

procedure Lesson02Tests.TestMysqreWithValidInput;
begin
   Check(Mysqre(1)  - 1.0000000 < precision);
   Check(Mysqre(2)  - 1.6487212 < precision);
   Check(Mysqre(0)  - 0.6065306 < precision);
   Check(Mysqre(-1) - 0.3678794 < precision);
end;

procedure Lesson02Tests.TestMylnWithValidInput;
begin
   Check(Myln(0, 2)      - 1.609438 < precision);
   Check(Myln(1, 2)      - 2.484906 < precision);
   Check(Myln(34, -1)    - 0.693147 < precision);
   Check(Myln(5, 2.1525) - 8.443364 < precision);
   Check(Myln(-2, 3)     - 0.7646061 < precision);
end;

procedure Lesson02Tests.TestCannotDivideByZero;
begin
   StartExpectingException(EInvalidArgument);
   MyIteration(0, -2);
   StopExpectingException();
end;

procedure Lesson02Tests.TestIterationShouldRunWithAnyX;
var temp: real;
begin
   Check(MyIteration(1, 1) - 0 < precision);
   Check(MyIteration(1, 10)   - 11.705737 < precision);
   Check(MyIteration(2, -1) - 21.407417 < precision);
   temp := MyIteration(20, 0.5);
   Check(temp - 7328937.5 < precision, 'Expected: 7328937.5, got:' + floattostr(temp));
end;

initialization
end.



