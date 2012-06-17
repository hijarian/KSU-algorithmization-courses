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

BOOL ClrConScrBuff(HANDLE hCO) //������� ������
{// ��� (�) ����������� �.�. 
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
	COORD CurrPos;
	CurrPos.X = 0; CurrPos.Y = 0;
	fOk = SetConsoleCursorPosition(hCO, CurrPos);
	return fOk;
}

int main()
{
	CConvOem sz(128);
	LPCSTR *ArrayMenuStr;					// ��������� �� ������ �����.
	// ��������� ������ ��� ������� ���������� �� ������.
	ArrayMenuStr = new LPCSTR[ItemsNum];
	// ���������� ���������� �� ������ � �������.
	ArrayMenuStr[0] = " ������ ������ � ���������� ";
	ArrayMenuStr[1] = " ������� ������ �� �����    ";
	ArrayMenuStr[2] = " �������� ������ � ������   ";
	ArrayMenuStr[3] = " ������� ������ �� ������   ";
	ArrayMenuStr[4] = " ������ � ����              ";
	ArrayMenuStr[5] = " ������ �� �����            ";
	ArrayMenuStr[6] = " ���������� �����           ";
	ArrayMenuStr[7] = " �����                      ";

	unsigned k;
	do{
		ClrConScrBuff(hCO1);
		viewMenuItems(ArrayMenuStr);
		cout << sz.toOemA("������� ����� ��������: \n");

		cin >> k;
		while(!(k<ItemsNum))
		{
			cout << sz.toOemA("�������� �����.");
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