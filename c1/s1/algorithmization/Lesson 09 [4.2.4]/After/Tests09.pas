{
 Ланчер для юнит-тестов задания №09.
 Компилировать отдельно Lesson09 и Tests09.
 Чтобы этот юнит и L09Tests скомпилировались,
 нужно в строку запуска fpc добавить путь к библиотеке FPTest.
}
program Tests09;

uses
   TextTestRunner,
   L09Tests;

begin
   L09Tests.RegisterTests;
   RunRegisteredTests;
end.

