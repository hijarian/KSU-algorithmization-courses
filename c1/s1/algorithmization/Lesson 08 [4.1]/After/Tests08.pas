{
 Ланчер для юнит-тестов задания №08.
 Компилировать отдельно Lesson08 и Tests08.
 Чтобы этот юнит и L08Tests скомпилировались,
 нужно в строку запуска fpc добавить путь к библиотеке FPTest.
}
program Tests08;

uses
   TextTestRunner,
   L08Tests;

begin
   L08Tests.RegisterTests;
   RunRegisteredTests;
end.

