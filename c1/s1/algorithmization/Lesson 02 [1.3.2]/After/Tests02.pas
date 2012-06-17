{
 Ланчер для юнит-тестов задания №02.
 Компилировать отдельно Lesson02 и Tests02.
 Чтобы этот юнит и L02Tests скомпилировались,
 нужно в строку запуска fpc добавить путь к библиотеке FPTest.
}
program Tests02;

uses
   TextTestRunner,
   L02Tests;

begin
   L02Tests.RegisterTests;
   RunRegisteredTests;
end.

