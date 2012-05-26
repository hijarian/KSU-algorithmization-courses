{
 Ланчер для юнит-тестов задания №NN.
 Компилировать отдельно LessonNN и TestsNN.
 Чтобы этот юнит и LNNTests скомпилировались,
 нужно в строку запуска fpc добавить путь к библиотеке FPTest.
}
program TestsNN;

uses
   TextTestRunner,
   LNNTests;

begin
   LNNTests.RegisterTests;
   RunRegisteredTests;
end.

