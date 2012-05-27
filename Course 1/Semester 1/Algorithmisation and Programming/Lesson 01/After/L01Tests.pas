unit L01Tests;

interface 

uses
   TestFramework, L01Code;

type
   Lesson1Tests = class(TTestCase)
   published    
      procedure TestValidInput;
      procedure TestNegativeXShouldThrowError;
      procedure TestMinimumAllowedX;
      procedure TestMaximumAllowedX;
   end;

procedure RegisterTests;

implementation
uses
   math;

const
   precision = 0.0001;

procedure RegisterTests;
begin
   TestFramework.RegisterTest(Lesson1Tests.Suite);
end;

procedure Lesson1Tests.TestValidInput;
begin
   Check(MyFunction(0.1) - 12.4244944 < precision, 'On the left edge function should be calculable');
   Check(MyFunction(0.35) - 4.8590140 < precision, 'Function should be calculable in the middle of interval');
   Check(MyFunction(0.6)  - 4.8087379 < precision, 'On the right edge function should be calculable');
end; 

procedure Lesson1Tests.TestNegativeXShouldThrowError;
begin
   StartExpectingException(EInvalidArgument);
   MyFunction(-1);
   StopExpectingException();
end;

procedure Lesson1Tests.TestMinimumAllowedX;
begin
   StartExpectingException(EInvalidArgument);
   MyFunction(0.1 - precision);
   StopExpectingException();
end;   

procedure Lesson1Tests.TestMaximumAllowedX;
begin
   StartExpectingException(EInvalidArgument);
   MyFunction(0.6 + precision);
   StopExpectingException();
end;   

                  
initialization
end.



