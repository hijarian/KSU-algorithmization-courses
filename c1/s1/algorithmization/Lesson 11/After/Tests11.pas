{
 Ланчер для юнит-тестов задания №11.
 Компилировать отдельно Lesson11 и Tests11.
 Чтобы этот юнит и L11Tests скомпилировались,
 нужно в строку запуска fpc добавить путь к библиотеке FPTest.
}
program Tests11;

uses
   TextTestRunner,
   L11Tests;

begin
   L11Tests.RegisterTests;
   RunRegisteredTests;
end.

