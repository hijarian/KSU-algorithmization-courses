//�����������������������������������������������������������������������������
// ������:
//	WinCUI.cpp
// ����������:
//	���������� (implementation), ���������� ����������� �����������������
//	�������, ���������� ������������� ����������� �����-������ � Win32.
// ���������:
//	�������������� ���������: ANSI, Unicode.
//�����������������������������������������������������������������������������
// �����:
//	� ����������� �.�., ���������� ���������, �. ���������,
//	�. ���������� �����, �����, ���. ����, 04.03.2004.
// ������������:
//	� ����������� �.�., ���������� ���������, �. ���������,
//	�. ���������� �����, �����, ���. ����, 04.03.2004.
//�����������������������������������������������������������������������������


#include <windows.h>

#include <cstdio>

#include <conio.h>

#include "ConvOem.h"
#include "WinCUI.h"


// ��������� �������� �������� ���� � ������ ����.
BOOL SetConScrSize(HANDLE hCO, SHORT x, SHORT y)
{
	BOOL fOk = TRUE;					// ��� ������.
	SMALL_RECT srNewWin;
	srNewWin.Left = 0;					// ����� ������� ����.
	srNewWin.Top = 0;
	srNewWin.Right = 0;					// ������ ������ ����.
	srNewWin.Bottom = 0;
	// ������� ����: 0 �� 0.
	fOk = SetConsoleWindowInfo(hCO, TRUE, &srNewWin);
	if (!fOk) return fOk;

	// �������������� ���� ���������� ��������������� ������� ������.
	COORD NewBuffSize;
	NewBuffSize.X = x; NewBuffSize.Y = y;
	fOk = SetConsoleScreenBufferSize(hCO, NewBuffSize);
	if (!fOk) return fOk;

	srNewWin.Right = x-1;				// ������ ������ ����.
	srNewWin.Bottom = y-1;
	// ������� ����: x �� y.
	fOk = SetConsoleWindowInfo(hCO, TRUE, &srNewWin);
	return fOk;
}

// ��������� � ���������� �������.
BOOL SetConCurVis(HANDLE hCO, DWORD Size, BOOL vis)
{
	CONSOLE_CURSOR_INFO cci;
	cci.dwSize = Size; cci.bVisible = vis;
	return SetConsoleCursorInfo(hCO, &cci);
}

// ��������� ������� � �������� �������.
BOOL SetConCurPos(HANDLE hCO, SHORT x, SHORT y)
{
	COORD CurrPos;
	CurrPos.X = x; CurrPos.Y = y;
	return SetConsoleCursorPosition(hCO, CurrPos);
}

// ������� ����������� ��������� ������ ���� �
//	��������� ������� � ��������� �������.
BOOL ClrConScrBuff(HANDLE hCO)
{
	BOOL fOk = TRUE;					// ��� ������.
	COORD HomePos;
	// ����������� ��������� ������� �������.
	HomePos.X = 0; HomePos.Y = 0;
	CONSOLE_SCREEN_BUFFER_INFO bi;
	DWORD Written;
	// ����������� ��������� ��������� ������.
	fOk = GetConsoleScreenBufferInfo(hCO, &bi);
	if (!fOk) return fOk;

	// ����������� ����� ��������� �������.
	DWORD SizePos = bi.dwSize.X * bi.dwSize.Y;

	// ���������� ������ �������� ��������.
	fOk = FillConsoleOutputCharacterW(hCO, L' ', SizePos, HomePos, &Written);
	if (!fOk) return fOk;

	// ���������� ������ ��������� ����������.
	fOk = FillConsoleOutputAttribute(hCO,
		FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_RED,
		SizePos, HomePos, &Written);
	if (!fOk) return fOk;

	// ��������� ������� � ��������� �������.
	fOk = SetConCurPos(hCO, 0, 0);
	return fOk;
}

// ��������� ��������� �������� �������� (���� ������� �� ���������).
BOOL SetConAttr(HANDLE hCO, WORD attr)
{ return SetConsoleTextAttribute(hCO, attr); }

// ��������� ����.
BOOL ConsoleMenuW(						// �� 0, ���� ��������� �������.
				  HANDLE hCO,			// ���������� ��������� ������.
				  size_t *pj,			// ��������� �� ����� ������ ����.
				  // ��������� �� ������ ����� Unicode.
				  LPCWSTR const *ArrayStrW,
				  const size_t l,		// ����� ������� �����.
				  SHORT x,				// ��������� ������� ���� �� ��� X.
				  SHORT y,				// ��������� ������� ���� �� ��� Y.
				  WORD as,				// �������� �����.
				  WORD asv				// �������� ���������� ������.
				  )
{
	BOOL fOk = TRUE;					// ��� ������.
	CConvOem szmBuff(64);
	if (szmBuff.isInvalid()) return !fOk; 	// ������ �������� ������.

	fOk = SetConAttr(hCO, as);			// ����� ����� ����.
	if (!fOk) return fOk;
	size_t i;
	for (i = 0; i < l; i++)
	{
		fOk = SetConCurPos(hCO, x, y + i);
		if (!fOk) return fOk;
		puts(szmBuff.toOemW(ArrayStrW[i]));
	}
	fOk = SetConAttr(hCO, asv);			// ����� ���������� ������.
	if (!fOk) return fOk;
	fOk = SetConCurPos(hCO, x, y + *pj);
	if (!fOk) return fOk;
	puts(szmBuff.toOemW(ArrayStrW[*pj]));
	unsigned char sym1, sym2;
	do {
		sym1 = getch();
		if (!sym1 || sym1 == 224)		// ���� 0 ��� 224.
			sym2 = getch();
		else sym2 = 0;
		if (sym1 ==0 || sym1 ==224)
		{
			fOk = SetConAttr(hCO, as);	// ������ ���������.
			if (!fOk) return fOk;
			fOk = SetConCurPos(hCO, x, y + *pj);
			if (!fOk) return fOk;
			puts(szmBuff.toOemW(ArrayStrW[*pj]));
			switch (sym2) {
			case 72:					// ������ �������� ������.
				if (*pj > 0) (*pj)--; else *pj = l - 1;
				break;
			case 80:					// ������ �������� ����.
				if (*pj < l-1) (*pj)++; else *pj = 0;
				break;
			}
			fOk = SetConAttr(hCO, asv);	// ��������� ������ ���������.
			if (!fOk) return fOk;
			fOk = SetConCurPos(hCO, x, y + *pj);
			if (!fOk) return fOk;
			puts(szmBuff.toOemW(ArrayStrW[*pj]));
		}
	}
	while (sym1 != 13);					// ���� �� ������ ������� �Enter�.
	return fOk;
}
BOOL ConsoleMenuA(						// �� 0, ���� ��������� �������.
				  HANDLE hCO,			// ���������� ��������� ������.
				  size_t *pj,			// ��������� �� ����� ������ ����.
				  // ��������� �� ������ ����� ANSI.
				  LPCSTR const *ArrayStr,
				  const size_t l,		// ����� ������� �����.
				  SHORT x,				// ��������� ������� ���� �� ��� X.
				  SHORT y,				// ��������� ������� ���� �� ��� Y.
				  WORD as,				// �������� �����.
				  WORD asv				// �������� ���������� ������.
				  )
{
	BOOL fOk = TRUE;

	// ��������� ������.
	size_t *ArrayNLenStrW = new size_t [l];	// ��� ������ ���� �����.
	if (!ArrayNLenStrW) fOk = FALSE;
	LPWSTR *ArrayStrW = new LPWSTR [l];		// ��� ������ �����.
	if (!ArrayStrW) fOk = FALSE;
	size_t i;								// ��� ���� ������ � �������.
	for (i = 0; i < l; i++)
	{
		ArrayNLenStrW[i] = strlen(ArrayStr[i]) + 1;
		ArrayStrW[i] = new WCHAR [ArrayNLenStrW[i]];
		if (!ArrayStrW[i]) fOk = FALSE;
	}

	// ���� �������� ������ ��������� ������, �� ���������� ������������
	//	��� ���������� ������ � ���������� �������.
	if (!fOk)
	{
		for (i = 0; i < l; i++) delete[] ArrayStrW[i];
		delete[] ArrayStrW;
		delete[] ArrayNLenStrW;
		return fOk;
	}

	// �������������� ������� ANSI-����� � Unicode-������.
	for (i = 0; i < l; i++)
		MultiByteToWideChar(CP_ACP, 0, ArrayStr[i], -1, ArrayStrW[i],
		ArrayNLenStrW[i]);
	
	// ���������� ���������������� ������ �������.
	fOk = ConsoleMenuW(hCO, pj, ArrayStrW, l, x, y, as, asv);

	// ������������ ���������� ������.
	for (i = 0; i < l; i++) delete[] ArrayStrW[i];
	delete[] ArrayStrW;
	delete[] ArrayNLenStrW;
	return fOk;
}
