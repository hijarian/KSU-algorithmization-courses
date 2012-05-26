unit L06Tests;

interface 

uses
   TestFramework, 
   L06Code;

type
   Lesson06Tests = class(TTestCase)
   published    
      // ЗДЕСЬ ОБЪЯВЛЕНИЯ ТЕСТОВЫХ ПРОЦЕДУР
   end;

procedure RegisterTests;

implementation

procedure RegisterTests;
begin
   TestFramework.RegisterTest(Lesson06Tests.Suite);
end;

// ЗДЕСЬ ТЕСТОВЫЕ ПРОЦЕДУРЫ

initialization
end.



