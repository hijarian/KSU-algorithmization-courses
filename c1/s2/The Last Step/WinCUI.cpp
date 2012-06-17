//—————————————————————————————————————————————————————————————————————————————
// Модуль:
//	WinCUI.cpp
// Назначение:
//	Реализация (implementation), содержащая определения системнозависимых
//	функций, упрощающих использование консольного ввода-вывода в Win32.
// Пояснения:
//	Поддерживаются стандарты: ANSI, Unicode.
//—————————————————————————————————————————————————————————————————————————————
// Автор:
//	© Романовский Э.А., Российская Федерация, р. Татарстан,
//	г. Набережные Челны, КамПИ, каф. АиИТ, 04.03.2004.
// Переработано:
//	© Романовский Э.А., Российская Федерация, р. Татарстан,
//	г. Набережные Челны, КамПИ, каф. АиИТ, 04.03.2004.
//—————————————————————————————————————————————————————————————————————————————


#include <windows.h>

#include <cstdio>

#include <conio.h>

#include "ConvOem.h"
#include "WinCUI.h"


// Установка заданных размеров окна и буфера окна.
BOOL SetConScrSize(HANDLE hCO, SHORT x, SHORT y)
{
	BOOL fOk = TRUE;					// Нет ошибок.
	SMALL_RECT srNewWin;
	srNewWin.Left = 0;					// Левый верхний угол.
	srNewWin.Top = 0;
	srNewWin.Right = 0;					// Правый нижний угол.
	srNewWin.Bottom = 0;
	// Размеры окна: 0 на 0.
	fOk = SetConsoleWindowInfo(hCO, TRUE, &srNewWin);
	if (!fOk) return fOk;

	// Предварительно надо установить соответствующие размеры буфера.
	COORD NewBuffSize;
	NewBuffSize.X = x; NewBuffSize.Y = y;
	fOk = SetConsoleScreenBufferSize(hCO, NewBuffSize);
	if (!fOk) return fOk;

	srNewWin.Right = x-1;				// Правый нижний угол.
	srNewWin.Bottom = y-1;
	// Размеры окна: x на y.
	fOk = SetConsoleWindowInfo(hCO, TRUE, &srNewWin);
	return fOk;
}

// Включение и выключение курсора.
BOOL SetConCurVis(HANDLE hCO, DWORD Size, BOOL vis)
{
	CONSOLE_CURSOR_INFO cci;
	cci.dwSize = Size; cci.bVisible = vis;
	return SetConsoleCursorInfo(hCO, &cci);
}

// Установка курсора в заданную позицию.
BOOL SetConCurPos(HANDLE hCO, SHORT x, SHORT y)
{
	COORD CurrPos;
	CurrPos.X = x; CurrPos.Y = y;
	return SetConsoleCursorPosition(hCO, CurrPos);
}

// Очистка содержимого выходного буфера окна и
//	установка курсора в начальную позицию.
BOOL ClrConScrBuff(HANDLE hCO)
{
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
	fOk = SetConCurPos(hCO, 0, 0);
	return fOk;
}

// Установка заданного текущего атрибута (цвет курсора не изменится).
BOOL SetConAttr(HANDLE hCO, WORD attr)
{ return SetConsoleTextAttribute(hCO, attr); }

// Текстовое меню.
BOOL ConsoleMenuW(						// Не 0, если выполнена успешно.
				  HANDLE hCO,			// Дескриптор выходного буфера.
				  size_t *pj,			// Указатель на номер пункта меню.
				  // Указатель на массив строк Unicode.
				  LPCWSTR const *ArrayStrW,
				  const size_t l,		// Длина массива строк.
				  SHORT x,				// Начальная позиция меню по оси X.
				  SHORT y,				// Начальная позиция меню по оси Y.
				  WORD as,				// Атрибуты строк.
				  WORD asv				// Атрибуты выделенной строки.
				  )
{
	BOOL fOk = TRUE;					// Нет ошибок.
	CConvOem szmBuff(64);
	if (szmBuff.isInvalid()) return !fOk; 	// Ошибка создания буфера.

	fOk = SetConAttr(hCO, as);			// Вывод строк меню.
	if (!fOk) return fOk;
	size_t i;
	for (i = 0; i < l; i++)
	{
		fOk = SetConCurPos(hCO, x, y + i);
		if (!fOk) return fOk;
		puts(szmBuff.toOemW(ArrayStrW[i]));
	}
	fOk = SetConAttr(hCO, asv);			// Вывод выделенной строки.
	if (!fOk) return fOk;
	fOk = SetConCurPos(hCO, x, y + *pj);
	if (!fOk) return fOk;
	puts(szmBuff.toOemW(ArrayStrW[*pj]));
	unsigned char sym1, sym2;
	do {
		sym1 = getch();
		if (!sym1 || sym1 == 224)		// Если 0 или 224.
			sym2 = getch();
		else sym2 = 0;
		if (sym1 ==0 || sym1 ==224)
		{
			fOk = SetConAttr(hCO, as);	// Снятие выделения.
			if (!fOk) return fOk;
			fOk = SetConCurPos(hCO, x, y + *pj);
			if (!fOk) return fOk;
			puts(szmBuff.toOemW(ArrayStrW[*pj]));
			switch (sym2) {
			case 72:					// Нажата «Стрелка вверх».
				if (*pj > 0) (*pj)--; else *pj = l - 1;
				break;
			case 80:					// Нажата «Стрелка вниз».
				if (*pj < l-1) (*pj)++; else *pj = 0;
				break;
			}
			fOk = SetConAttr(hCO, asv);	// Установка нового выделения.
			if (!fOk) return fOk;
			fOk = SetConCurPos(hCO, x, y + *pj);
			if (!fOk) return fOk;
			puts(szmBuff.toOemW(ArrayStrW[*pj]));
		}
	}
	while (sym1 != 13);					// Пока не нажата клавиша «Enter».
	return fOk;
}
BOOL ConsoleMenuA(						// Не 0, если выполнена успешно.
				  HANDLE hCO,			// Дескриптор выходного буфера.
				  size_t *pj,			// Указатель на номер пункта меню.
				  // Указатель на массив строк ANSI.
				  LPCSTR const *ArrayStr,
				  const size_t l,		// Длина массива строк.
				  SHORT x,				// Начальная позиция меню по оси X.
				  SHORT y,				// Начальная позиция меню по оси Y.
				  WORD as,				// Атрибуты строк.
				  WORD asv				// Атрибуты выделенной строки.
				  )
{
	BOOL fOk = TRUE;

	// Выделение памяти.
	size_t *ArrayNLenStrW = new size_t [l];	// Под массив длин строк.
	if (!ArrayNLenStrW) fOk = FALSE;
	LPWSTR *ArrayStrW = new LPWSTR [l];		// Под массив строк.
	if (!ArrayStrW) fOk = FALSE;
	size_t i;								// Под сами строки в массиве.
	for (i = 0; i < l; i++)
	{
		ArrayNLenStrW[i] = strlen(ArrayStr[i]) + 1;
		ArrayStrW[i] = new WCHAR [ArrayNLenStrW[i]];
		if (!ArrayStrW[i]) fOk = FALSE;
	}

	// Если возникла ошибка выделения памяти, то происходит освобождение
	//	уже выделенной памяти и завершение функции.
	if (!fOk)
	{
		for (i = 0; i < l; i++) delete[] ArrayStrW[i];
		delete[] ArrayStrW;
		delete[] ArrayNLenStrW;
		return fOk;
	}

	// Преобразование массива ANSI-строк в Unicode-строки.
	for (i = 0; i < l; i++)
		MultiByteToWideChar(CP_ACP, 0, ArrayStr[i], -1, ArrayStrW[i],
		ArrayNLenStrW[i]);
	
	// Выполнение широкосимвольной версии функции.
	fOk = ConsoleMenuW(hCO, pj, ArrayStrW, l, x, y, as, asv);

	// Освобождение выделенной памяти.
	for (i = 0; i < l; i++) delete[] ArrayStrW[i];
	delete[] ArrayStrW;
	delete[] ArrayNLenStrW;
	return fOk;
}
