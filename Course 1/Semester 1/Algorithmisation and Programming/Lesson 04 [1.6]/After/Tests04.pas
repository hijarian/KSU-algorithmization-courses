{
 Ланчер для юнит-тестов задания №04.
 Компилировать отдельно Lesson04 и Tests04.
 Чтобы этот юнит и L04Tests скомпилировались,
 нужно в строку запуска fpc добавить путь к библиотеке FPTest.
}
program Tests04;

uses
   TextTestRunner,
   L04Tests;

begin
   L04Tests.RegisterTests;
   RunRegisteredTests;
end.

