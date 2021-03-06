//覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧�
// ﾌ�蔘��:
//	WinCUI.cpp
// ﾍ珸�璞褊韃:
//	ﾐ裄�韈璋�� (implementation), ��蒟�赳��� ���裝褄褊�� �頌�褌��鈞粨�韲��
//	�����韜, ��������頷 頌����鉋籵�韃 ���������胛 粐�萵-糺粽萵 � Win32.
// ﾏ����褊��:
//	ﾏ�蒿褞跖籵���� ��瑙萵���: ANSI, Unicode.
//覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧�
// ﾀ糘��:
//	ｩ ﾐ��瑙�糂�韜 ﾝ.ﾀ., ﾐ���韜���� ﾔ裝褞璋��, �. ﾒ瑣瑩��瑙,
//	�. ﾍ珮褞褂��� ﾗ褄��, ﾊ瑟ﾏﾈ, �瑶. ﾀ霾ﾒ, 04.03.2004.
// ﾏ褞褞珮��瑙�:
//	ｩ ﾐ��瑙�糂�韜 ﾝ.ﾀ., ﾐ���韜���� ﾔ裝褞璋��, �. ﾒ瑣瑩��瑙,
//	�. ﾍ珮褞褂��� ﾗ褄��, ﾊ瑟ﾏﾈ, �瑶. ﾀ霾ﾒ, 04.03.2004.
//覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧�


#include <windows.h>

#include <cstdio>

#include <conio.h>

#include "ConvOem.h"
#include "WinCUI.h"


// ﾓ��瑙�粲� 鈞萵���� �珸�褞�� ���� � 碯�褞� ����.
BOOL SetConScrSize(HANDLE hCO, SHORT x, SHORT y)
{
	BOOL fOk = TRUE;					// ﾍ褪 ��鞦��.
	SMALL_RECT srNewWin;
	srNewWin.Left = 0;					// ﾋ裘�� 粢���韜 �胛�.
	srNewWin.Top = 0;
	srNewWin.Right = 0;					// ﾏ�珞�� �韆�韜 �胛�.
	srNewWin.Bottom = 0;
	// ﾐ珸�褞� ����: 0 �� 0.
	fOk = SetConsoleWindowInfo(hCO, TRUE, &srNewWin);
	if (!fOk) return fOk;

	// ﾏ�裝籵�頸褄��� �琅� ���瑙�粨�� ����粢���糒��韃 �珸�褞� 碯�褞�.
	COORD NewBuffSize;
	NewBuffSize.X = x; NewBuffSize.Y = y;
	fOk = SetConsoleScreenBufferSize(hCO, NewBuffSize);
	if (!fOk) return fOk;

	srNewWin.Right = x-1;				// ﾏ�珞�� �韆�韜 �胛�.
	srNewWin.Bottom = y-1;
	// ﾐ珸�褞� ����: x �� y.
	fOk = SetConsoleWindowInfo(hCO, TRUE, &srNewWin);
	return fOk;
}

// ﾂ����褊韃 � 糺����褊韃 �������.
BOOL SetConCurVis(HANDLE hCO, DWORD Size, BOOL vis)
{
	CONSOLE_CURSOR_INFO cci;
	cci.dwSize = Size; cci.bVisible = vis;
	return SetConsoleCursorInfo(hCO, &cci);
}

// ﾓ��瑙�粲� ������� � 鈞萵���� ��鉅���.
BOOL SetConCurPos(HANDLE hCO, SHORT x, SHORT y)
{
	COORD CurrPos;
	CurrPos.X = x; CurrPos.Y = y;
	return SetConsoleCursorPosition(hCO, CurrPos);
}

// ﾎ�頌��� ��蒟�跖��胛 糺��蓖�胛 碯�褞� ���� �
//	���瑙�粲� ������� � �璞琿���� ��鉅���.
BOOL ClrConScrBuff(HANDLE hCO)
{
	BOOL fOk = TRUE;					// ﾍ褪 ��鞦��.
	COORD HomePos;
	// ﾎ��裝褄褊韃 �璞琿���� ��鉅�韋 ��頌���.
	HomePos.X = 0; HomePos.Y = 0;
	CONSOLE_SCREEN_BUFFER_INFO bi;
	DWORD Written;
	// ﾎ��裝褄褊韃 ��������� 糺��蓖�胛 碯�褞�.
	fOk = GetConsoleScreenBufferInfo(hCO, &bi);
	if (!fOk) return fOk;

	// ﾎ��裝褄褊韃 �頌�� ��顋瑯��� ��鉅�韜.
	DWORD SizePos = bi.dwSize.X * bi.dwSize.Y;

	// ﾇ瑜���褊韃 碯�褞� 鈞萵���� �韲粽���.
	fOk = FillConsoleOutputCharacterW(hCO, L' ', SizePos, HomePos, &Written);
	if (!fOk) return fOk;

	// ﾇ瑜���褊韃 碯�褞� 鈞萵����� 瑣�鞦��瑟�.
	fOk = FillConsoleOutputAttribute(hCO,
		FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_RED,
		SizePos, HomePos, &Written);
	if (!fOk) return fOk;

	// ﾓ��瑙�粲� ������� � �璞琿���� ��鉅���.
	fOk = SetConCurPos(hCO, 0, 0);
	return fOk;
}

// ﾓ��瑙�粲� 鈞萵���胛 �裲��裙� 瑣�鞦��� (�粢� ������� �� 韈�褊頸��).
BOOL SetConAttr(HANDLE hCO, WORD attr)
{ return SetConsoleTextAttribute(hCO, attr); }

// ﾒ裲���粽� �褊�.
BOOL ConsoleMenuW(						// ﾍ� 0, 褥�� 糺����褊� ���褸��.
				  HANDLE hCO,			// ﾄ褥��韵��� 糺��蓖�胛 碯�褞�.
				  size_t *pj,			// ﾓ�珸瑣褄� �� ���褞 ������ �褊�.
				  // ﾓ�珸瑣褄� �� �瑰�鞣 ����� Unicode.
				  LPCWSTR const *ArrayStrW,
				  const size_t l,		// ﾄ�竟� �瑰�鞣� �����.
				  SHORT x,				// ﾍ璞琿���� ��鉅��� �褊� �� ��� X.
				  SHORT y,				// ﾍ璞琿���� ��鉅��� �褊� �� ��� Y.
				  WORD as,				// ﾀ��鞦��� �����.
				  WORD asv				// ﾀ��鞦��� 糺蒟�褊��� ������.
				  )
{
	BOOL fOk = TRUE;					// ﾍ褪 ��鞦��.
	CConvOem szmBuff(64);
	if (szmBuff.isInvalid()) return !fOk; 	// ﾎ�鞦�� ��鈕瑙�� 碯�褞�.

	fOk = SetConAttr(hCO, as);			// ﾂ�粽� ����� �褊�.
	if (!fOk) return fOk;
	size_t i;
	for (i = 0; i < l; i++)
	{
		fOk = SetConCurPos(hCO, x, y + i);
		if (!fOk) return fOk;
		puts(szmBuff.toOemW(ArrayStrW[i]));
	}
	fOk = SetConAttr(hCO, asv);			// ﾂ�粽� 糺蒟�褊��� ������.
	if (!fOk) return fOk;
	fOk = SetConCurPos(hCO, x, y + *pj);
	if (!fOk) return fOk;
	puts(szmBuff.toOemW(ArrayStrW[*pj]));
	unsigned char sym1, sym2;
	do {
		sym1 = getch();
		if (!sym1 || sym1 == 224)		// ﾅ��� 0 齏� 224.
			sym2 = getch();
		else sym2 = 0;
		if (sym1 ==0 || sym1 ==224)
		{
			fOk = SetConAttr(hCO, as);	// ﾑ���韃 糺蒟�褊��.
			if (!fOk) return fOk;
			fOk = SetConCurPos(hCO, x, y + *pj);
			if (!fOk) return fOk;
			puts(szmBuff.toOemW(ArrayStrW[*pj]));
			switch (sym2) {
			case 72:					// ﾍ琥瑣� ｫﾑ��褄�� 粐褞�ｻ.
				if (*pj > 0) (*pj)--; else *pj = l - 1;
				break;
			case 80:					// ﾍ琥瑣� ｫﾑ��褄�� 粹韈ｻ.
				if (*pj < l-1) (*pj)++; else *pj = 0;
				break;
			}
			fOk = SetConAttr(hCO, asv);	// ﾓ��瑙�粲� ��粽胛 糺蒟�褊��.
			if (!fOk) return fOk;
			fOk = SetConCurPos(hCO, x, y + *pj);
			if (!fOk) return fOk;
			puts(szmBuff.toOemW(ArrayStrW[*pj]));
		}
	}
	while (sym1 != 13);					// ﾏ��� �� �琥瑣� ��珞顏� ｫEnterｻ.
	return fOk;
}
BOOL ConsoleMenuA(						// ﾍ� 0, 褥�� 糺����褊� ���褸��.
				  HANDLE hCO,			// ﾄ褥��韵��� 糺��蓖�胛 碯�褞�.
				  size_t *pj,			// ﾓ�珸瑣褄� �� ���褞 ������ �褊�.
				  // ﾓ�珸瑣褄� �� �瑰�鞣 ����� ANSI.
				  LPCSTR const *ArrayStr,
				  const size_t l,		// ﾄ�竟� �瑰�鞣� �����.
				  SHORT x,				// ﾍ璞琿���� ��鉅��� �褊� �� ��� X.
				  SHORT y,				// ﾍ璞琿���� ��鉅��� �褊� �� ��� Y.
				  WORD as,				// ﾀ��鞦��� �����.
				  WORD asv				// ﾀ��鞦��� 糺蒟�褊��� ������.
				  )
{
	BOOL fOk = TRUE;

	// ﾂ�蒟�褊韃 �瑟���.
	size_t *ArrayNLenStrW = new size_t [l];	// ﾏ�� �瑰�鞣 蓁竟 �����.
	if (!ArrayNLenStrW) fOk = FALSE;
	LPWSTR *ArrayStrW = new LPWSTR [l];		// ﾏ�� �瑰�鞣 �����.
	if (!ArrayStrW) fOk = FALSE;
	size_t i;								// ﾏ�� �瑟� ������ � �瑰�鞣�.
	for (i = 0; i < l; i++)
	{
		ArrayNLenStrW[i] = strlen(ArrayStr[i]) + 1;
		ArrayStrW[i] = new WCHAR [ArrayNLenStrW[i]];
		if (!ArrayStrW[i]) fOk = FALSE;
	}

	// ﾅ��� 粽鈿韭�� ��鞦�� 糺蒟�褊�� �瑟���, �� ���頌��蒻� ��粽碚趾褊韃
	//	�趺 糺蒟�褊��� �瑟��� � 鈞粢��褊韃 �����韋.
	if (!fOk)
	{
		for (i = 0; i < l; i++) delete[] ArrayStrW[i];
		delete[] ArrayStrW;
		delete[] ArrayNLenStrW;
		return fOk;
	}

	// ﾏ�褓碣珸�籵�韃 �瑰�鞣� ANSI-����� � Unicode-������.
	for (i = 0; i < l; i++)
		MultiByteToWideChar(CP_ACP, 0, ArrayStr[i], -1, ArrayStrW[i],
		ArrayNLenStrW[i]);
	
	// ﾂ�����褊韃 �頏����韲粽����� 粢��韋 �����韋.
	fOk = ConsoleMenuW(hCO, pj, ArrayStrW, l, x, y, as, asv);

	// ﾎ�粽碚趾褊韃 糺蒟�褊��� �瑟���.
	for (i = 0; i < l; i++) delete[] ArrayStrW[i];
	delete[] ArrayStrW;
	delete[] ArrayNLenStrW;
	return fOk;
}
