// ������� ������ 13 �� ����� "�������� � �++"
// ���������, ����������� ������� ������ �������� � �������,
// � ����������� ���������� �������� ��� ���� �������.
// ������ 5.2.2 ������� 9
// -----------------------------------
// ������ srcCore_datalayer ��������� ��������������� �������� ��
// �������, ��������� ������ �������� � ��������� �����������.
// ������ ������������ ������� srcCore_menuitems, ������� 
// �������� ����������� ������������ ���� ������
// -----------------------------------
// (�) �������� �.�. ���� �. ���. �����, ���� 2007 ����

#include "srcCore_datalayer.h"

ptNode listConstruct(size_t size)
{//��� (�)����������� �.�.
	size_t i;
	ptNode pN, plist(0);
	if (size)						// ���� size != 0.
	{
		pN = plist = new TNode;			// �������� ���������� ����.
		for (i = 1; i < size; ++i)		// �������� ��������� �����.
			pN = pN->link = new TNode;
		pN->link = 0;			// ��������� ���� �������� ������ ���������.
	}
	return plist;
}
void listDestroy(ptNode plist)
{//��� (�)����������� �.�.
	ptNode pN(plist);
	while (plist)					// ���� ������ ��������.
	{
		pN = plist->link;
		delete plist;					// �������� ���������� ����.
		plist = pN;
	}
}
ptNode listInverse(ptNode plist)
{//��� (�)����������� �.�.
	ptNode ptemp, pnrev(plist), prev(0);
	while (pnrev)
	{
		ptemp = pnrev->link;
		pnrev->link = prev;
		prev = pnrev;
		pnrev = ptemp;
	}
	return prev;
}
ptNode listGetElem(ptNode pStart, size_t nmb)
{
	ptNode pN=pStart;
	for (size_t i=1; i<nmb; ++i)
		if(pN)
			pN=pN->link;
		else return NULL;
		return pN;
}
size_t listGetSize(ptNode pStart)
{
	size_t count=0;
	ptNode pN=pStart;	
	while(pN)
	{
		pN=pN->link;
		++count;
	}
	return count;
}

int listAddNode(ptNode pStart, size_t nmb, TKey key, TVal val)
{
	ptNode pN=listGetElem(pStart, nmb);
	if(pN)
	{		// ����� ��-� ����, �� ��������
		ptNode pT=new TNode;	// ������� ����� ����
		pT->link=pN->link;		// ����� ���� ��������� �� 
								// ��� �� ����, ��� � ��������
		pN->link=pT;			// �������� ���� ��������� �� 
								// �����
		pT->name=key;
		pT->number=val;
	}	
	else	// ����� ��-�� ���, �� ����������� =) 
		return 1;
	return 0;
}
ptNode listAdd1st(ptNode plist, TKey key, TVal val)
{
	ptNode pT=new TNode;
	pT->name=key;
	pT->number=val;
	pT->link=plist;
	return pT;
}
int listRemoveNode(ptNode pStart, size_t nmb)
{
	ptNode pN=pStart;

	if(nmb==1)
		return -1;
	
	pN=listGetElem(pStart, nmb-1);
	if(pN)
	{
		ptNode pT=pN->link;
		pN->link=pT->link;
		delete pT;
	}
	else
		return 1;
	return 0;
}
ptNode listRemove1st(ptNode pFirst)
{
	pFirst=pFirst->link;
	return pFirst;
}
int listSave(ptNode pList, const char* sPath)
{
	ofstream flSave(sPath);
	ptNode pN=pList;
	while(pN)
	{
		flSave << pN->name << endl;
		flSave << pN->number << endl;
		pN=pN->link;
	}
	return 0;
}

ptNode listLoad(const char* sPath)
{
	ifstream flLoad(sPath);
	ptNode plist = new TNode;
	ptNode pN=plist;
	pN->link=pN;
	string t;
	while(flLoad >> t)
	{
		pN=pN->link;
		pN->link = new TNode;
		pN->name=t;
		flLoad >> t;
		pN->number=t;
	}
	delete pN->link;
	pN->link=NULL;
	return plist;
}