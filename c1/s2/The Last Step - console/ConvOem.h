//覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧覧�
// ﾌ�蔘��:
//	ConvOem.h
// ﾍ珸�璞褊韃:
//	ﾈ��褞�裨� (inrerface), ��蒟�赳�韜 �磅�粱褊韃 ��瑰�� ��褓碣珸�籵���
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

	// ﾊ������頏�籵�韃.
	CConvOem(const size_t);
	virtual ~CConvOem();

	// ﾎ��裝褄褊韃 ��������� �磅裲�� ��瑰��.
	const size_t & SizeOfBuffer() const { return m_BuffSize; }
	const LPSTR & szBuffer() const { return m_szBuff; }
	const LPWSTR & szBufferW() const { return m_szBuffW; }
	// ﾂ�鈔�瓊瑯� true, 褥�� �硼瑩�趺�� ��鞦��.
	const bool & isInvalid() const { return m_blInvalidBuff; }

	// ﾈ銕褊褊韃 �珸�褞� 碯�褞� �磅裲�� ��瑰��.
	CConvOem & resize(const size_t);


	// ﾏ�褓碣珸�籵�韃 �����.
	//	ﾌ褪�蕘 粽鈔�瓊��� ������ ��珸瑣褄�, 褥�� ���韈���� ��鞦��.

	// ﾏ�褓碣珸�籵�韃 ������ Windows � ������ � ��蒻��粲� OEM.
	LPCSTR toOemW(LPCWSTR const);
	LPCSTR toOemA(LPCSTR const);
	// ﾏ�褓碣珸�籵�韃 ������ � ��蒻��粲� OEM � ������ Windows.
	LPCWSTR fromOemW(LPCSTR const);
	LPCSTR fromOemA(LPCSTR const);

	// ﾏ�褓碣珸�籵�韃 �韲粽���.
	//	ﾌ褪�蕘 粽鈔�瓊��� EOF 齏� WEOF, 褥�� ���韈���� ��鞦��.

	// ﾏ�褓碣珸�籵�韃 �韲粽�� Windows � �韲粽� � ��蒻��粲� OEM.
	const CHAR toOemW(const WCHAR);
	const CHAR toOemA(const CHAR);
	// ﾏ�褓碣珸�籵�韃 �韲粽�� � ��蒻��粲� OEM � �韲粽� Windows.
	const WCHAR fromOemW(const CHAR);
	const CHAR fromOemA(const CHAR);
};


#endif	// !defined(AFX_CONVOEM_H__865DB021_F5BB_4C59_8715_26F61718A721__INCLUDED_)
