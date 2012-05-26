{
 Ланчер для юнит-тестов задания №10.
 Компилировать отдельно Lesson10 и Tests10.
 Чтобы этот юнит и L10Tests скомпилировались,
 нужно в строку запуска fpc добавить путь к библиотеке FPTest.
}
program Tests10;

uses
   TextTestRunner,
   L10Tests;

begin
   L10Tests.RegisterTests;
   RunRegisteredTests;
end.

