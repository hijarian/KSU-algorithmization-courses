//—————————————————————————————————————————————————————————————————————————————
// Модуль:
//	ConvOem.h
// Назначение:
//	Интерфейс (inrerface), содержащий объявление класса преобразования
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


#if !defined(AFX_CONVOEM_H__865DB021_F5BB_4C59_8715_26F61718A721__INCLUDED_)
#define AFX_CONVOEM_H__865DB021_F5BB_4C59_8715_26F61718A721__INCLUDED_


#if _MSC_VER > 1000
#pragma once
#endif	// _MSC_VER > 1000


#ifdef UNICODE
#define toOem toOemW
#define fromOem fromOemW
#else
#define toOem toOemA
#define fromOem fromOemA
#endif	// !UNICODE


class CConvOem  
{
	size_t m_BuffSize;
	LPSTR m_szBuff;
	LPWSTR m_szBuffW;
	bool m_blInvalidBuff;

public:

	// Конструирование.
	CConvOem(const size_t);
	virtual ~CConvOem();

	// Определение состояния объекта класса.
	const size_t & SizeOfBuffer() const { return m_BuffSize; }
	const LPSTR & szBuffer() const { return m_szBuff; }
	const LPWSTR & szBufferW() const { return m_szBuffW; }
	// Возвращает true, если обнаружена ошибка.
	const bool & isInvalid() const { return m_blInvalidBuff; }

	// Изменение размера буфера объекта класса.
	CConvOem & resize(const size_t);


	// Преобразование строк.
	//	Методы возвращают пустой указатель, если произошла ошибка.

	// Преобразование строки Windows в строку в кодировке OEM.
	LPCSTR toOemW(LPCWSTR const);
	LPCSTR toOemA(LPCSTR const);
	// Преобразование строки в кодировке OEM в строку Windows.
	LPCWSTR fromOemW(LPCSTR const);
	LPCSTR fromOemA(LPCSTR const);

	// Преобразование символов.
	//	Методы возвращают EOF или WEOF, если произошла ошибка.

	// Преобразование символа Windows в символ в кодировке OEM.
	const CHAR toOemW(const WCHAR);
	const CHAR toOemA(const CHAR);
	// Преобразование символа в кодировке OEM в символ Windows.
	const WCHAR fromOemW(const CHAR);
	const CHAR fromOemA(const CHAR);
};


#endif	// !defined(AFX_CONVOEM_H__865DB021_F5BB_4C59_8715_26F61718A721__INCLUDED_)
