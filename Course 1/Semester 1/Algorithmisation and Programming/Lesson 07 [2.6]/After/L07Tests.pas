unit L07Tests;

interface 

uses
   TestFramework, 
   L07Code;

type
   Lesson07Tests = class(TTestCase)
   published    
      // ЗДЕСЬ ОБЪЯВЛЕНИЯ ТЕСТОВЫХ ПРОЦЕДУР
   end;

procedure RegisterTests;

implementation

procedure RegisterTests;
begin
   TestFramework.RegisterTest(Lesson07Tests.Suite);
end;

// ЗДЕСЬ ТЕСТОВЫЕ ПРОЦЕДУРЫ

initialization
end.



