//�����������������������������������������������������������������������������
// ������:
//	WConMenuEx.cpp
// ����������:
//	������ ���������� ���������, ��������������� �������� � ������������� �
//	���������� ���� ���������� ����.
// ���������:
//	�������������� ������ �������� ANSI.
//�����������������������������������������������������������������������������
// �����������:
//	� ����������� �.�., ���������� ���������, �. ���������,
//	�. ���������� �����, �����, ���. ����, 02.03.2004.
// ������������:
//	� ����������� �.�., ���������� ���������, �. ���������,
//	�. ���������� �����, �����, ���. ����, 01.05.2004.
//�����������������������������������������������������������������������������
// ������������:
// �������� �.�. ��. 4606
// ���� 2007 =)
// ������ 5.2.2


#include "srcCore_menuitems.h"

#include <cstdio>

#include <Windows.h>
#include <conio.h>

#include "ConvOem.h"
#include "WinCUI.h"

int main()
{
	// ����� �������������� ���������.
	CConvOem szBuff(128);

	// ������ ����� ����.
	const size_t NStr = 8, LenStr = 31;		// ����� ����� � 30 ��������.
	LPCSTR *ArrayMenuStr;					// ��������� �� ������ �����.
	// ��������� ������ ��� ������� ���������� �� ������.
	ArrayMenuStr = new LPCSTR [NStr];
	// ���������� ���������� �� ������ � �������.
	ArrayMenuStr[0] = " ������ ������ � ���������� ";
	ArrayMenuStr[1] = " ������� ������ �� �����    ";
	ArrayMenuStr[2] = " �������� ������ � ������   ";
	ArrayMenuStr[3] = " ������� ������ �� ������   ";
	ArrayMenuStr[4] = " ������ � ����              ";
	ArrayMenuStr[5] = " ������ �� �����            ";
	ArrayMenuStr[6] = " ���������� �����           ";
	ArrayMenuStr[7] = " �����                      ";

	// ����������� ������������ ����������� �������� � ��������� ������� ����.
	HANDLE hCI = GetStdHandle(STD_INPUT_HANDLE);
	HANDLE hCO = GetStdHandle(STD_OUTPUT_HANDLE);

	// ��������� ������ ��������� ����������� ����.
	LPCSTR ConsoleTitle = "������ 5.2.2 � ��������� ����";
	SetConsoleTitle(szBuff.toOem(ConsoleTitle));

	// ����������� �������� ��������� ���� ��� �� �������������� � �����.
	CONSOLE_SCREEN_BUFFER_INFO csbi;
	GetConsoleScreenBufferInfo(hCO, &csbi);
	CONSOLE_CURSOR_INFO cci;
	GetConsoleCursorInfo(hCO, &cci);

	SetConScrSize(hCO, 80, 50);			// ��������� �������� ����: 80 x 50.
	size_t k(0);
	const size_t ExitNmb=7;				// ����� ���� "�����" - �� ������� �������
	do {

		ClrConScrBuff(hCO);				// ������� ��������� ������.
		SetConCurVis(hCO, 1, FALSE);	// ���������� �������.
		ConsoleMenu(					// ����� ������ ����.
			hCO, &k, ArrayMenuStr, NStr, 10, 10, 0x17, 0x5e);
		ClrConScrBuff(hCO);				// ������� ��������� ������.
		//SetConCurPos(hCO, 15, 15);		// ���������� ��������� ��������.
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
		do ; while (!kbhit());			// �������� ������� ���������� ������.
		FlushConsoleInputBuffer(hCI);	// ������� �������� ������ ����.
	} while ( k != ExitNmb );					// ���� �� ������ ����� �� ����.

	// �������������� �������� ��������� ����.
	// ������ ����.
	SetConScrSize(hCO, csbi.srWindow.Right+1, csbi.srWindow.Bottom+1);
	// ������ ������.
	SetConsoleScreenBufferSize(hCO, csbi.dwSize);
	// ������� ��������� ������.
	ClrConScrBuff(hCO);
	// ������� ��������.
	SetConAttr(hCO, csbi.wAttributes);
	// ������� ��������� �������.
	SetConCurVis(hCO, cci.dwSize, cci.bVisible);

	// ������������ ������, ���������� ��� ������� ���������� �� ������.
	delete[] ArrayMenuStr;

	return 0;
}
