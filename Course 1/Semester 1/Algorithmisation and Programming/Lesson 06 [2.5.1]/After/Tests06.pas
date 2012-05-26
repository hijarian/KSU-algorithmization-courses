{
 Ланчер для юнит-тестов задания №06.
 Компилировать отдельно Lesson06 и Tests06.
 Чтобы этот юнит и L06Tests скомпилировались,
 нужно в строку запуска fpc добавить путь к библиотеке FPTest.
}
program Tests06;

uses
   TextTestRunner,
   L06Tests;

begin
   L06Tests.RegisterTests;
   RunRegisteredTests;
end.

