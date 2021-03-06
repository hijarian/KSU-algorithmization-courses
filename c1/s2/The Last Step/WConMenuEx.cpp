//覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧�
// ﾌ�蔘��:
//	WConMenuEx.cpp
// ﾍ珸�璞褊韃:
//	ﾌ�蔘�� �裄�韈璋韋 ���胙瑟��, 蒟������頏���裨 ��鈕瑙韃 � 頌����鉋籵�韃 �
//	���������� ���� �裲���粽胛 �褊�.
// ﾏ����褊��:
//	ﾏ�蒿褞跖籵褪�� ������ ��瑙萵�� ANSI.
//覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧�
// ﾐ珸�珮���韭:
//	ｩ ﾐ��瑙�糂�韜 ﾝ.ﾀ., ﾐ���韜���� ﾔ裝褞璋��, �. ﾒ瑣瑩��瑙,
//	�. ﾍ珮褞褂��� ﾗ褄��, ﾊ瑟ﾏﾈ, �瑶. ﾀ霾ﾒ, 02.03.2004.
// ﾏ褞褞珮��瑙�:
//	ｩ ﾐ��瑙�糂�韜 ﾝ.ﾀ., ﾐ���韜���� ﾔ裝褞璋��, �. ﾒ瑣瑩��瑙,
//	�. ﾍ珮褞褂��� ﾗ褄��, ﾊ瑟ﾏﾈ, �瑶. ﾀ霾ﾒ, 01.05.2004.
//覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧�
// ﾈ�����鉋籵��:
// ﾑ瑶����� ﾌ.ﾀ. 胙. 4606
// �瑩� 2007 =)
// ﾇ琅璞� 5.2.2


#include "srcCore_menuitems.h"

#include <cstdio>

#include <Windows.h>
#include <conio.h>

#include "ConvOem.h"
#include "WinCUI.h"

int main()
{
	// ﾁ��褞 ��褓碣珸�籵��� ��蒻��粽�.
	CConvOem szBuff(128);

	// ﾌ瑰�鞣 ����� �褊�.
	const size_t NStr = 8, LenStr = 31;		// ﾄ�竟� ����� � 30 �韲粽���.
	LPCSTR *ArrayMenuStr;					// ﾓ�珸瑣褄� �� �瑰�鞣 �����.
	// ﾂ�蒟�褊韃 �瑟��� 蓁� �瑰�鞣� ��珸瑣褄裨 �� ������.
	ArrayMenuStr = new LPCSTR [NStr];
	// ﾑ���瑙褊韃 ��珸瑣褄裨 �� ������ � �瑰�鞣�.
	ArrayMenuStr[0] = " ﾂ粢��� ��頌�� � ��珞鞨���� ";
	ArrayMenuStr[1] = " ﾂ�粢��� ��頌�� �� ���瑙    ";
	ArrayMenuStr[2] = " ﾄ�矜粨�� 鈞�頌� � ��頌��   ";
	ArrayMenuStr[3] = " ﾓ萵�頸� 鈞�頌� 韈 ��頌��   ";
	ArrayMenuStr[4] = " ﾇ瑜頌� � �琺�              ";
	ArrayMenuStr[5] = " ﾗ�褊韃 韈 �琺��            ";
	ArrayMenuStr[6] = " ﾂ�����褊韃 鈞萵�           ";
	ArrayMenuStr[7] = " ﾂ����                      ";

	// ﾎ��裝褄褊韃 蒟���韵����� ��瑙萵����� 糢�蓖�胛 � 糺��蓖�胛 碯�褞�� ����.
	HANDLE hCI = GetStdHandle(STD_INPUT_HANDLE);
	HANDLE hCO = GetStdHandle(STD_OUTPUT_HANDLE);

	// ﾓ��瑙�粲� ������ 鈞胛��粲� ���������胛 ����.
	LPCSTR ConsoleTitle = "ﾇ琅璞� 5.2.2 � �裲���糺� �褊�";
	SetConsoleTitle(szBuff.toOem(ConsoleTitle));

	// ﾎ��裝褄褊韃 頌��蓖�� ���瑙�粽� ���� 蓁� 頷 粽���瑙�粱褊�� � �����.
	CONSOLE_SCREEN_BUFFER_INFO csbi;
	GetConsoleScreenBufferInfo(hCO, &csbi);
	CONSOLE_CURSOR_INFO cci;
	GetConsoleCursorInfo(hCO, &cci);

	SetConScrSize(hCO, 80, 50);			// ﾓ��瑙�粲� �珸�褞�� ����: 80 x 50.
	size_t k(0);
	const size_t ExitNmb=7;				// ﾏ���� �褊� "糺���" - �� �裝���� ��鉅�韋
	do {

		ClrConScrBuff(hCO);				// ﾎ�頌��� 糺��蓖�胛 碯�褞�.
		SetConCurVis(hCO, 1, FALSE);	// ﾂ�����褊韃 �������.
		ConsoleMenu(					// ﾂ�碚� ������ �褊�.
			hCO, &k, ArrayMenuStr, NStr, 10, 10, 0x17, 0x5e);
		ClrConScrBuff(hCO);				// ﾎ�頌��� 糺��蓖�胛 碯�褞�.
		//SetConCurPos(hCO, 15, 15);		// ﾂ�����褊韃 糺碣瑙��� 蒟鴦�粨�.
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
		do ; while (!kbhit());			// ﾎ跖萵�韃 �琥瑣�� ���礪�璋韋 ��珞顏.
		FlushConsoleInputBuffer(hCI);	// ﾎ�頌��� 糢�蓖�胛 碯�褞� ����.
	} while ( k != ExitNmb );					// ﾏ��� �� 糺碣瑙 糺��� 韈 �褊�.

	// ﾂ����瑙�粱褊韃 頌��蓖�� ���瑙�粽� ����.
	// ﾐ珸�褞 ����.
	SetConScrSize(hCO, csbi.srWindow.Right+1, csbi.srWindow.Bottom+1);
	// ﾐ珸�褞 碯�褞�.
	SetConsoleScreenBufferSize(hCO, csbi.dwSize);
	// ﾎ�頌��� 糺��蓖�胛 碯�褞�.
	ClrConScrBuff(hCO);
	// ﾒ裲��韃 瑣�鞦���.
	SetConAttr(hCO, csbi.wAttributes);
	// ﾒ裲��裹 �������韃 �������.
	SetConCurVis(hCO, cci.dwSize, cci.bVisible);

	// ﾎ�粽碚趾褊韃 �瑟���, 糺蒟�褊��� 蓁� �瑰�鞣� ��珸瑣褄裨 �� ������.
	delete[] ArrayMenuStr;

	return 0;
}
