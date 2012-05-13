{
 Ланчер для юнит-тестов первого задания.
 Компилировать отдельно Lesson01 и Tests01.
 Чтобы этот юнит и L01Tests скомпилировались,
 нужно в строку запуска fpc добавить путь к библиотеке FPTest.
}
program Tests01;


uses
   TextTestRunner,
   L01Tests;

begin
   L01Tests.RegisterTests;
   RunRegisteredTests;
end.

