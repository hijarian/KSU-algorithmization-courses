//—————————————————————————————————————————————————————————————————————————————
// Модуль:
//	ConvOem.cpp
// Назначение:
//	Реализация (implementation), содержащая определение класса преобразования
//	(конверсии) символов и символьных массивов (C-строк) Windows в кодировку
//	OEM и обратно (CConvOem).
// Пояснения:
//	Поддерживаются стандарты: ANSI, Unicode.
//—————————————————————————————————————————————————————————————————————————————
// Автор:
//	© Романовский Э.А., Российская Федерация, р. Татарстан,
//	г. Набережные Челны, КамПИ, каф. АиИТ, 20.02.2004.
// Переработано:
//	© Романовский Э.А., Российская Федерация, р. Татарстан,
//	г. Набережные Челны, КамПИ, каф. АиИТ, 23.02.2004.
//—————————————————————————————————————————————————————————————————————————————


#include <windows.h>

#include <cstdio>

#include "ConvOem.h"


// ————————————————————————————————————————————————————————————————————————————
// Реализация класса CConvOem.
// ————————————————————————————————————————————————————————————————————————————


// ————————————————————————————————————————————————————————————————————————————
// Конструирование.
// ————————————————

CConvOem::CConvOem(const size_t BS = 256) :
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

// ————————————————————————————————————————————————————————————————————————————
// Изменение состояния объекта класса (размера буфера).
// ————————————————————————————————————————————————————

CConvOem & CConvOem::resize(const size_t BS = 256)
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

// ————————————————————————————————————————————————————————————————————————————
// Преобразование строк.
// —————————————————————

// Преобразование строки Windows в строку в кодировке OEM.
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

// Преобразование строки в кодировке OEM в строку Windows.
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

// Преобразование символа Windows в символ в кодировке OEM.
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

// Преобразование символа в кодировке OEM в символ Windows.
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
