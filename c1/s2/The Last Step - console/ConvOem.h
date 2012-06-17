//�����������������������������������������������������������������������������
// ������:
//	ConvOem.h
// ����������:
//	��������� (inrerface), ���������� ���������� ������ ��������������
//	(���������) �������� � ���������� �������� (C-�����) Windows � ���������
//	OEM � ������� (CConvOem).
// ���������:
//	�������������� ���������: ANSI, Unicode.
//�����������������������������������������������������������������������������
// �����:
//	� ����������� �.�., ���������� ���������, �. ���������,
//	�. ���������� �����, �����, ���. ����, 20.02.2004.
// ������������:
//	� ����������� �.�., ���������� ���������, �. ���������,
//	�. ���������� �����, �����, ���. ����, 23.02.2004.
//�����������������������������������������������������������������������������


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

	// ���������������.
	CConvOem(const size_t);
	virtual ~CConvOem();

	// ����������� ��������� ������� ������.
	const size_t & SizeOfBuffer() const { return m_BuffSize; }
	const LPSTR & szBuffer() const { return m_szBuff; }
	const LPWSTR & szBufferW() const { return m_szBuffW; }
	// ���������� true, ���� ���������� ������.
	const bool & isInvalid() const { return m_blInvalidBuff; }

	// ��������� ������� ������ ������� ������.
	CConvOem & resize(const size_t);


	// �������������� �����.
	//	������ ���������� ������ ���������, ���� ��������� ������.

	// �������������� ������ Windows � ������ � ��������� OEM.
	LPCSTR toOemW(LPCWSTR const);
	LPCSTR toOemA(LPCSTR const);
	// �������������� ������ � ��������� OEM � ������ Windows.
	LPCWSTR fromOemW(LPCSTR const);
	LPCSTR fromOemA(LPCSTR const);

	// �������������� ��������.
	//	������ ���������� EOF ��� WEOF, ���� ��������� ������.

	// �������������� ������� Windows � ������ � ��������� OEM.
	const CHAR toOemW(const WCHAR);
	const CHAR toOemA(const CHAR);
	// �������������� ������� � ��������� OEM � ������ Windows.
	const WCHAR fromOemW(const CHAR);
	const CHAR fromOemA(const CHAR);
};


#endif	// !defined(AFX_CONVOEM_H__865DB021_F5BB_4C59_8715_26F61718A721__INCLUDED_)
