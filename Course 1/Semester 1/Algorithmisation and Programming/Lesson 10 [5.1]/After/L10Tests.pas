unit L10Tests;

interface 

uses
   TestFramework, 
   L10Code;

type
   Lesson10Tests = class(TTestCase)
   published    
      // ЗДЕСЬ ОБЪЯВЛЕНИЯ ТЕСТОВЫХ ПРОЦЕДУР
   end;

procedure RegisterTests;

implementation

procedure RegisterTests;
begin
   TestFramework.RegisterTest(Lesson10Tests.Suite);
end;

// ЗДЕСЬ ТЕСТОВЫЕ ПРОЦЕДУРЫ

initialization
end.



