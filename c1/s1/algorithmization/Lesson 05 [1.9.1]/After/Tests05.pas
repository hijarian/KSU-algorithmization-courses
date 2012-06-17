{
 Ланчер для юнит-тестов задания №05.
 Компилировать отдельно Lesson05 и Tests05.
 Чтобы этот юнит и L05Tests скомпилировались,
 нужно в строку запуска fpc добавить путь к библиотеке FPTest.
}
program Tests05;

uses
   TextTestRunner,
   L05Tests;

begin
   L05Tests.RegisterTests;
   RunRegisteredTests;
end.

