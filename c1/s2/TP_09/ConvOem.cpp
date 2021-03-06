//覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧�
// ﾌ�蔘��:
//	ConvOem.cpp
// ﾍ珸�璞褊韃:
//	ﾐ裄�韈璋�� (implementation), ��蒟�赳��� ���裝褄褊韃 ��瑰�� ��褓碣珸�籵���
//	(���粢��韋) �韲粽��� � �韲粽����� �瑰�鞣�� (C-�����) Windows � ��蒻��粲�
//	OEM � �碣瑣�� (CConvOem).
// ﾏ����褊��:
//	ﾏ�蒿褞跖籵���� ��瑙萵���: ANSI, Unicode.
//覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧�
// ﾀ糘��:
//	ｩ ﾐ��瑙�糂�韜 ﾝ.ﾀ., ﾐ���韜���� ﾔ裝褞璋��, �. ﾒ瑣瑩��瑙,
//	�. ﾍ珮褞褂��� ﾗ褄��, ﾊ瑟ﾏﾈ, �瑶. ﾀ霾ﾒ, 20.02.2004.
// ﾏ褞褞珮��瑙�:
//	ｩ ﾐ��瑙�糂�韜 ﾝ.ﾀ., ﾐ���韜���� ﾔ裝褞璋��, �. ﾒ瑣瑩��瑙,
//	�. ﾍ珮褞褂��� ﾗ褄��, ﾊ瑟ﾏﾈ, �瑶. ﾀ霾ﾒ, 23.02.2004.
//覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧�


#include <windows.h>
#include <cstdio>

#include "ConvOem.h"


// 覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧
// ﾐ裄�韈璋�� ��瑰�� CConvOem.
// 覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧


// 覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧
// ﾊ������頏�籵�韃.
// 覧覧覧覧覧覧覧覧

CConvOem::CConvOem(const size_t BS) :
m_BuffSize(BS), m_szBuff(0), m_szBuffW(0), m_blInvalidBuff(false)
{
	if (!m_BuffSize) m_BuffSize++;
	m_szBuff = new CHAR[m_BuffSize];
	m_szBuffW = new WCHAR[m_BuffSize];
	if (!m_szBuff || !m_szBuffW)
	{
		m_blInvalidBuff = true;
		SetLastError(ERROR_INVALID_ADDRESS);
	}
	else
	{
		m_szBuff[0] = 0; m_szBuffW[0] = 0;
	}
}

CConvOem::~CConvOem()
{
	delete[] m_szBuff; delete[] m_szBuffW;
}

// 覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧
// ﾈ銕褊褊韃 ��������� �磅裲�� ��瑰�� (�珸�褞� 碯�褞�).
// 覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧

CConvOem & CConvOem::resize(const size_t BS)
{
	m_BuffSize = BS; if (!m_BuffSize) m_BuffSize++;
	m_blInvalidBuff = false;
	delete[] m_szBuff; delete[] m_szBuffW;
	m_szBuff = new CHAR[m_BuffSize];
	m_szBuffW = new WCHAR[m_BuffSize];
	if (!m_szBuff || !m_szBuffW)
	{
		m_blInvalidBuff = true;
		SetLastError(ERROR_INVALID_ADDRESS);
	}
	else
	{
		m_szBuff[0] = 0; m_szBuffW[0] = 0;
	}
	return *this;
}

// 覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧
// ﾏ�褓碣珸�籵�韃 �����.
// 覧覧覧覧覧覧覧覧覧覧�

// ﾏ�褓碣珸�籵�韃 ������ Windows � ������ � ��蒻��粲� OEM.
LPCSTR CConvOem::toOemW(LPCWSTR const lpszSrc)
{
	if (m_blInvalidBuff || !lpszSrc)
	{
		SetLastError(ERROR_INVALID_ADDRESS);
		return 0;
	}
	size_t len(wcslen(lpszSrc)); len++;
	if (len > m_BuffSize)
	{
		SetLastError(ERROR_INVALID_ADDRESS);
		return 0;
	}
	CharToOemW(lpszSrc, m_szBuff);
	return m_szBuff;
}

LPCSTR CConvOem::toOemA(LPCSTR const lpszSrc)
{
	if (m_blInvalidBuff || !lpszSrc)
	{
		SetLastError(ERROR_INVALID_ADDRESS);
		return 0;
	}
	size_t len(strlen(lpszSrc)); len++;
	if (len > m_BuffSize)
	{
		SetLastError(ERROR_INVALID_ADDRESS);
		return 0;
	}
	CharToOemA(lpszSrc, m_szBuff);
	return m_szBuff;
}

// ﾏ�褓碣珸�籵�韃 ������ � ��蒻��粲� OEM � ������ Windows.
LPCWSTR CConvOem::fromOemW(LPCSTR const lpszSrc)
{
	if (m_blInvalidBuff || !lpszSrc)
	{
		SetLastError(ERROR_INVALID_ADDRESS);
		return 0;
	}
	size_t len(strlen(lpszSrc)); len++;
	if (len > m_BuffSize)
	{
		SetLastError(ERROR_INVALID_ADDRESS);
		return 0;
	}
	OemToCharW(lpszSrc, m_szBuffW);
	return m_szBuffW;
}

LPCSTR CConvOem::fromOemA(LPCSTR const lpszSrc)
{
	if (m_blInvalidBuff || !lpszSrc)
	{
		SetLastError(ERROR_INVALID_ADDRESS);
		return 0;
	}
	size_t len(strlen(lpszSrc)); len++;
	if (len > m_BuffSize)
	{
		SetLastError(ERROR_INVALID_ADDRESS);
		return 0;
	}
	OemToCharA(lpszSrc, m_szBuff);
	return m_szBuff;
}

// ﾏ�褓碣珸�籵�韃 �韲粽�� Windows � �韲粽� � ��蒻��粲� OEM.
const CHAR CConvOem::toOemW(const WCHAR chSrc)
{
	if (m_blInvalidBuff)
	{
		SetLastError(ERROR_INVALID_ADDRESS);
		return EOF;
	}
	CharToOemBuffW(&chSrc, m_szBuff, 1);
	return *m_szBuff;
}

const CHAR CConvOem::toOemA(const CHAR chSrc)
{
	if (m_blInvalidBuff)
	{
		SetLastError(ERROR_INVALID_ADDRESS);
		return EOF;
	}
	CharToOemBuffA(&chSrc, m_szBuff, 1);
	return *m_szBuff;
}

// ﾏ�褓碣珸�籵�韃 �韲粽�� � ��蒻��粲� OEM � �韲粽� Windows.
const WCHAR CConvOem::fromOemW(const CHAR chSrc)
{
	if (m_blInvalidBuff)
	{
		SetLastError(ERROR_INVALID_ADDRESS);
		return WEOF;
	}
	OemToCharBuffW(&chSrc, m_szBuffW, 1);
	return *m_szBuffW;
}

const CHAR CConvOem::fromOemA(const CHAR chSrc)
{
	if (m_blInvalidBuff)
	{
		SetLastError(ERROR_INVALID_ADDRESS);
		return EOF;
	}
	OemToCharBuffA(&chSrc, m_szBuff, 1);
	return *m_szBuff;
}
