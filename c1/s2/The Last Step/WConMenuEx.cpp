//—————————————————————————————————————————————————————————————————————————————
// Модуль:
//	WConMenuEx.cpp
// Назначение:
//	Модуль реализации программы, демонстрирующей создание и использование в
//	консольном окне текстового меню.
// Пояснения:
//	Поддерживается только стандарт ANSI.
//—————————————————————————————————————————————————————————————————————————————
// Разработчик:
//	© Романовский Э.А., Российская Федерация, р. Татарстан,
//	г. Набережные Челны, КамПИ, каф. АиИТ, 02.03.2004.
// Переработано:
//	© Романовский Э.А., Российская Федерация, р. Татарстан,
//	г. Набережные Челны, КамПИ, каф. АиИТ, 01.05.2004.
//—————————————————————————————————————————————————————————————————————————————
// Использовано:
// Сафронов М.А. гр. 4606
// март 2007 =)
// Задача 5.2.2


#include "srcCore_menuitems.h"

#include <cstdio>

#include <Windows.h>
#include <conio.h>

#include "ConvOem.h"
#include "WinCUI.h"

int main()
{
	// Буфер преобразования кодировок.
	CConvOem szBuff(128);

	// Массив строк меню.
	const size_t NStr = 8, LenStr = 31;		// Длина строк — 30 символов.
	LPCSTR *ArrayMenuStr;					// Указатель на массив строк.
	// Выделение памяти для массива указателей на строки.
	ArrayMenuStr = new LPCSTR [NStr];
	// Сохранение указателей на строки в массиве.
	ArrayMenuStr[0] = " Ввести список с клавиатуры ";
	ArrayMenuStr[1] = " Вывести список на экран    ";
	ArrayMenuStr[2] = " Добавить запись в список   ";
	ArrayMenuStr[3] = " Удалить запись из списка   ";
	ArrayMenuStr[4] = " Запись в файл              ";
	ArrayMenuStr[5] = " Чтение из файла            ";
	ArrayMenuStr[6] = " Выполнение задач           ";
	ArrayMenuStr[7] = " Выход                      ";

	// Определение дескрипторов стандартных входного и выходного буферов окна.
	HANDLE hCI = GetStdHandle(STD_INPUT_HANDLE);
	HANDLE hCO = GetStdHandle(STD_OUTPUT_HANDLE);

	// Установка строки заголовка консольного окна.
	LPCSTR ConsoleTitle = "Задача 5.2.2 с текстовым меню";
	SetConsoleTitle(szBuff.toOem(ConsoleTitle));

	// Определение исходных установок окна для их восстановления в конце.
	CONSOLE_SCREEN_BUFFER_INFO csbi;
	GetConsoleScreenBufferInfo(hCO, &csbi);
	CONSOLE_CURSOR_INFO cci;
	GetConsoleCursorInfo(hCO, &cci);

	SetConScrSize(hCO, 80, 50);			// Установка размеров окна: 80 x 50.
	size_t k(0);
	const size_t ExitNmb=7;				// Пункт меню "выход" - на седьмой позиции
	do {

		ClrConScrBuff(hCO);				// Очистка выходного буфера.
		SetConCurVis(hCO, 1, FALSE);	// Выключение курсора.
		ConsoleMenu(					// Выбор пункта меню.
			hCO, &k, ArrayMenuStr, NStr, 10, 10, 0x17, 0x5e);
		ClrConScrBuff(hCO);				// Очистка выходного буфера.
		//SetConCurPos(hCO, 15, 15);		// Выполнение выбранных действий.
		SetConAttr(hCO, 0x0b);
		switch (k) {
		case 0:
			menuInput();
			break;
		case 1:
			menuPrint();
			break;
		case 2:
			menuAddNode();
			break;
		case 3:
			menuRemoveNode();
			break;
		case 4:
			menuSave();
			break;
		case 5:
			menuLoad();
			break;
		case 6:
			menuDoStuff();
			break;
		case ExitNmb:
			menuExit();
			break;
		}
		do ; while (!kbhit());			// Ожидание нажатия комбинации клавиш.
		FlushConsoleInputBuffer(hCI);	// Очистка входного буфера окна.
	} while ( k != ExitNmb );					// Пока не выбран выход из меню.

	// Восстановление исходных установок окна.
	// Размер окна.
	SetConScrSize(hCO, csbi.srWindow.Right+1, csbi.srWindow.Bottom+1);
	// Размер буфера.
	SetConsoleScreenBufferSize(hCO, csbi.dwSize);
	// Очистка выходного буфера.
	ClrConScrBuff(hCO);
	// Текущие атрибуты.
	SetConAttr(hCO, csbi.wAttributes);
	// Текущее состояние курсора.
	SetConCurVis(hCO, cci.dwSize, cci.bVisible);

	// Освобождение памяти, выделенной для массива указателей на строки.
	delete[] ArrayMenuStr;

	return 0;
}
