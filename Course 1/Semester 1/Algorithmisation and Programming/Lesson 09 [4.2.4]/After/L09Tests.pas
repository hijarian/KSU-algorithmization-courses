unit L09Tests;

interface 

uses
   TestFramework, 
   L09Code;

type
   Lesson09Tests = class(TTestCase)
   published    
      // ЗДЕСЬ ОБЪЯВЛЕНИЯ ТЕСТОВЫХ ПРОЦЕДУР
   end;

procedure RegisterTests;

implementation

procedure RegisterTests;
begin
   TestFramework.RegisterTest(Lesson09Tests.Suite);
end;

// ЗДЕСЬ ТЕСТОВЫЕ ПРОЦЕДУРЫ

initialization
end.



