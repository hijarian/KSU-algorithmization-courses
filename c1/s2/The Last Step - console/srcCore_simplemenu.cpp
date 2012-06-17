#include "srcCore_menuitems.h"
#include <iostream>
#include <Windows.h>
#include <conio.h>
#include "ConvOem.h"

using namespace std;

const size_t ItemsNum=8;
HANDLE hCO1=GetStdHandle(STD_OUTPUT_HANDLE);

int viewMenuItems(LPCSTR *arr)
{
	CConvOem sz(128);
	for(size_t i=0; i<ItemsNum; ++i)
	{
		cout << (unsigned)i << " - " << sz.toOemA(arr[i]) << endl;
	}
	return 0;
}

BOOL ClrConScrBuff(HANDLE hCO) //Очистка экрана
{// Код (с) Романовский Э.А. 
	BOOL fOk = TRUE;					// Нет ошибок.
	COORD HomePos;
	// Определение начальной позиции очистки.
	HomePos.X = 0; HomePos.Y = 0;
	CONSOLE_SCREEN_BUFFER_INFO bi;
	DWORD Written;
	// Определение состояния выходного буфера.
	fOk = GetConsoleScreenBufferInfo(hCO, &bi);
	if (!fOk) return fOk;

	// Определение числа очищаемых позиций.
	DWORD SizePos = bi.dwSize.X * bi.dwSize.Y;

	// Заполнение буфера заданным символом.
	fOk = FillConsoleOutputCharacterW(hCO, L' ', SizePos, HomePos, &Written);
	if (!fOk) return fOk;

	// Заполнение буфера заданными атрибутами.
	fOk = FillConsoleOutputAttribute(hCO,
		FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_RED,
		SizePos, HomePos, &Written);
	if (!fOk) return fOk;

	// Установка курсора в начальную позицию.
	COORD CurrPos;
	CurrPos.X = 0; CurrPos.Y = 0;
	fOk = SetConsoleCursorPosition(hCO, CurrPos);
	return fOk;
}

int main()
{
	CConvOem sz(128);
	LPCSTR *ArrayMenuStr;					// Указатель на массив строк.
	// Выделение памяти для массива указателей на строки.
	ArrayMenuStr = new LPCSTR[ItemsNum];
	// Сохранение указателей на строки в массиве.
	ArrayMenuStr[0] = " Ввести список с клавиатуры ";
	ArrayMenuStr[1] = " Вывести список на экран    ";
	ArrayMenuStr[2] = " Добавить запись в список   ";
	ArrayMenuStr[3] = " Удалить запись из списка   ";
	ArrayMenuStr[4] = " Запись в файл              ";
	ArrayMenuStr[5] = " Чтение из файла            ";
	ArrayMenuStr[6] = " Выполнение задач           ";
	ArrayMenuStr[7] = " Выход                      ";

	unsigned k;
	do{
		ClrConScrBuff(hCO1);
		viewMenuItems(ArrayMenuStr);
		cout << sz.toOemA("Введите номер операции: \n");

		cin >> k;
		while(!(k<ItemsNum))
		{
			cout << sz.toOemA("Неверный номер.");
			cin >> k;
		}
		
		ClrConScrBuff(hCO1);
		switch(k)
		{
		case 0: menuInput();break;
		case 1: menuPrint();break;
		case 2: menuAddNode();break;
		case 3: menuRemoveNode();break;
		case 4: menuSave();break;
		case 5: menuLoad();break;
		case 6: menuDoStuff();break;
		case 7: menuExit();break;
		}
		do ; while (!kbhit());
	}while(k!=7);
	return 0;
}