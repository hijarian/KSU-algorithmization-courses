unit L03Tests;

interface 

uses
   TestFramework, 
   L03Code;

type
   Lesson03Tests = class(TTestCase)
   published    
      // ЗДЕСЬ ОБЪЯВЛЕНИЯ ТЕСТОВЫХ ПРОЦЕДУР
   end;

procedure RegisterTests;

implementation

procedure RegisterTests;
begin
   TestFramework.RegisterTest(Lesson03Tests.Suite);
end;

// ЗДЕСЬ ТЕСТОВЫЕ ПРОЦЕДУРЫ

initialization
end.



