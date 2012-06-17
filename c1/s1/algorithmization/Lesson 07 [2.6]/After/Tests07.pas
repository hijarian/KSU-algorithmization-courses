{
 Ланчер для юнит-тестов задания №07.
 Компилировать отдельно Lesson07 и Tests07.
 Чтобы этот юнит и L07Tests скомпилировались,
 нужно в строку запуска fpc добавить путь к библиотеке FPTest.
}
program Tests07;

uses
   TextTestRunner,
   L07Tests;

begin
   L07Tests.RegisterTests;
   RunRegisteredTests;
end.

