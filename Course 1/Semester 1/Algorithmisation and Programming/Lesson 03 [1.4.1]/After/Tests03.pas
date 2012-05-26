{
 Ланчер для юнит-тестов задания №03.
 Компилировать отдельно Lesson03 и Tests03.
 Чтобы этот юнит и L03Tests скомпилировались,
 нужно в строку запуска fpc добавить путь к библиотеке FPTest.
}
program Tests03;

uses
   TextTestRunner,
   L03Tests;

begin
   L03Tests.RegisterTests;
   RunRegisteredTests;
end.

