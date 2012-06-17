// ������� ������ 13 �� ����� "�������� � �++"
// ���������, ����������� ������� ������ �������� � �������,
// � ����������� ���������� �������� ��� ���� �������.
// ������ 5.2.2 ������� 9
// -----------------------------------
// ������ �1 srcCore_menuitems ������������ ��� ��������� ��������� ������� ����
// �������� ������ � ������ ����� �� ������������, � �������� �� � ������ �2 
// srcCore_datalayer, ������� ���������� ���������������� ���������� ������.
// -----------------------------------
// (�) �������� �.�. ���� �. ���. �����, ���� 2007 ����

#include "srcCore_datalayer.h"
#include <iostream>
#include <iomanip>
#include <Windows.h>
#include <wincon.h>
#include "ConvOem.h"
using namespace std;
CConvOem sz(128);

ptNode listMain=NULL; // ������� ������, ��� ������� ����� � �����������
HANDLE hCi=GetStdHandle(STD_INPUT_HANDLE);	// ����� ������ ����� �������, ����� � ����� ����� ���� =)
HANDLE hCO=GetStdHandle(STD_OUTPUT_HANDLE); // ����� ������ ������ �������
CONSOLE_CURSOR_INFO cci={1, TRUE};			// ����, ��������� ��� ��������� �������

int menuInput(void)
{//�������� ������ ��������� ����� � ���� ��� ��-��� � ����������
	SetConsoleCursorInfo(hCO, &cci);		// ��������� �������.
	char a;
	if(listMain!=NULL)
	{// ����� ����� ������ ��� ����
		cout << sz.toOem(" ������������� �������� ������? Y/N \n");
		do{
			cin >> a;
		}while((a!='y')&&(a!='Y')&&(a!='N')&&(a!='n'));
		if (a=='n'||a=='N')
			return 1;
	}
	cout << sz.toOem("������� �������� ����� ������\n");
	size_t p;
	cin >> p;
	listMain=listConstruct(p); // ������� � datalayer

	ptNode pN=listMain; //������� ��������
	p=1;
	while(pN)
	{// ������ ������ � ����������
		cout << sz.toOem("������ �") << (unsigned)p << endl;
		cout << sz.toOemA("���: ");
		cin >> pN->name;
		cout << sz.toOemA("����� ��������: ");
		cin >> pN->number;
		pN=pN->link;
		++p;
	}
	cout << sz.toOemA("������� ����� ������� ��� ������ � ����.");
	// ���������� ������� ����� ������, ��� ������� � WConMenuEx.cpp
	// ������� ������� �� ������� ����� ���������� ������ ������-���� ������ ����
	return 0;
};
int menuPrint(void)
{// ����� ������ �� �����
	ptNode pN=listMain;
	if(!pN)
	{
		cout << sz.toOemA("������ ����.\n������� ����� ������� ��� ������ � ����.");
		return 1;
	}
	while(pN)
	{// ����, ���� ������� ��������������
		cout << pN->name << " : " << pN->number << endl;
		pN=pN->link;
	}
	cout << sz.toOemA("���������: ");
	cout << (unsigned)listGetSize(listMain) << endl;
	cout << sz.toOemA("������� ����� ������� ��� ������ � ����.");
	return 0;
};
int menuAddNode(void)
{// ������� ������ ����� ������������
	size_t size=listGetSize(listMain);
	SetConsoleCursorInfo(hCO, &cci);		// ��������� �������.
	cout << sz.toOem("� ������ ") << (unsigned)size;
	cout << sz.toOem(" ���������.\n");
	cout << sz.toOem("������� ����� ������, ����� ������� ������� �������� �����.\n");
	cout << sz.toOem("0-�������� ������ � ������ ������.\n");
	size_t nmb;
	do{
		cin >> nmb;
		if(nmb>size)
			cout << sz.toOemA("� ������ ��� ����� ������!");
	}while(/*(nmb==0)||*/(nmb>size));
	cout << sz.toOem("���: ");
	TKey sKey;
	cin >> sKey;
	cout << sz.toOem("����� ��������: ");
	TVal sVal;
	cin >> sVal;
	if(nmb)		//���� ���� ���� �� "0", �� ����� ������� ������� ������� ��-��
		listAddNode(listMain, nmb, sKey, sVal);
	else			//���� �� ���� ���� "0", �� ����� ������ ������ ��-�� ��������.
		listMain=listAdd1st(listMain, sKey, sVal);
	cout << sz.toOemA("������� ����� ������� ��� ������ � ����.");
	return 0;
};
int menuRemoveNode(void)
{// �������� ������������ ������
	SetConsoleCursorInfo(hCO, &cci);		// ��������� �������.
	size_t size=listGetSize(listMain);
	cout << sz.toOem("� ������ ") << (unsigned)size;
	cout << sz.toOem(" ���������.\n");
	cout << sz.toOem("������� ����� ������, ������� ������� �������.\n");
	size_t nmb;
	do{
		cin >> nmb;
		if(nmb>size)
			cout << sz.toOemA("� ������ ��� ����� ������!");
	}while((nmb==0)||(nmb>size));
	cout << sz.toOem(" ������������� �������? Y/N \n");
	char a;
	do{
		cin >> a;
	}while((a!='y')&&(a!='Y')&&(a!='N')&&(a!='n'));
	if (a=='n'||a=='N')
		return 1;
	if(nmb==1)
		listMain=listRemove1st(listMain);
	else 
		listRemoveNode(listMain, nmb);
	cout << sz.toOemA("������� ����� ������� ��� ������ � ����.");
	return 0;
};
int menuSave(void)
{// ���������� ������ � ������������ ����
	SetConsoleCursorInfo(hCO, &cci);		// ��������� �������.
	cout << sz.toOemA("������� ���� � ����� (��������, �������������): ") << endl;
	string Path;
	cin >> Path;
	char* cPath=&(Path[0]);
	ofstream flSave(cPath);
	if(!flSave)
	{
		cout << sz.toOemA("�� ������� ������� ����");
		return -1;
	}
	listSave(listMain, cPath);
	cout << sz.toOemA("������� ����� ������� ��� ������ � ����.");
	return 0;
};
int menuLoad(void)
{// �������� ������ �� �����
	SetConsoleCursorInfo(hCO, &cci);		// ��������� �������.
	cout << sz.toOemA("������� ���� � ����� (��������, �������������): ") << endl;
	string Path;
	cin >> Path;
	char* cPath=&(Path[0]);
	ifstream flLoad(cPath);
	if(!flLoad)
	{
		cout << sz.toOemA("�� ������� ������� ����");
		return -1;
	}
	listMain=listLoad(cPath);
	if(listMain)
	{
		cout << sz.toOemA("������� ���������.");
		cout << sz.toOemA("������� ����� ������� ��� ������ � ����.");
		return 0;
	}
	else
	{
		cout << sz.toOemA("������� ���������, �� �� �����-���� ������������� �������� ������ ����.\n");
		cout << sz.toOemA("������� ����� ������� ��� ������ � ����.");
		return 1;
	}
};
int menuDoStuff(void)
{// ���������� ��������� � ������� �������� ��� �������
	SetConsoleCursorInfo(hCO, &cci);		// ��������� �������.
	ptNode pN=listMain;
	if(!pN)
	{// ���� ������ ���� (������ ����, listMain=NULL)
		cout << sz.toOemA("������ �������� � ������ �������!\n������� ����� ������� ��� ������ � ����.");
		return 1;
	}
	string match="";
	const size_t ln=3; /* ����� ��������� ������ ����� ���� �������� - ��� � �������*/;
// ���������� ����� ������ ����� ln ��������
	cout <<	sz.toOemA("������� ") << ln;
	cout << sz.toOemA(" ����� �������:\n");
	do{
		cin >> match;
		FlushConsoleInputBuffer(hCi); // ��� ����� � ����� ����������� � ��������� ����� ������ �����
									  // ���� �� �������� ����� �����, ����� ����� ������ ��� ����� =)
	}while(match._Mysize!=ln);
// ����� �� ��������, ����� ����� match ����� ����� ����� 3 �������
	size_t MatchedCount=0;
	size_t& mc=MatchedCount;
	while(pN)
	{// ���� ���� ������
		size_t IsFound=0;
		const char* p=match.c_str();
		for(size_t i=0; i<ln; ++i)
		{// i ���������� �� 0 �� ln-1, �� ���� ���������� ����� ln �������� 
			if(*p==pN->number[i])
				++IsFound;
			++p;
		}
		if(IsFound==ln)
		{// ���� ����� ����� ln *�����* ����������� ��������, �� ����� ������������� ������� �������
			cout <<	pN->name << sz.toOemA(" ����� ������ ����� ��������: ") << pN->number << endl;
			++mc;
		}
		pN=pN->link;
	}
	cout << sz.toOemA("�������: ") << (unsigned)mc;
	cout << sz.toOemA(" ��������������� �������.\n");
	while(pN)
	{
		cout << pN->name << " : " << pN->number << endl;
		pN=pN->link;
	}
	cout << sz.toOemA("������� ����� ������� ��� ������ � ����.");
	return 0;
};
int menuExit(void)
{// ����� �� �����
	cout << sz.toOem("����� �� ���������. ��������� ������ �� ������.") << endl;
	listDestroy(listMain);
	cout << sz.toOemA("������� ����� ������� ��� ������ � ����.");
	return 0;
}