// Решение задачи 13 по курсу "Введение в С++"
// Программа, реализующая связный список структур с данными,
// и выполняющая простейшие операции над этим списком.
// Задача 5.2.2 вариант 9
// -----------------------------------
// Модуль srcCore_datalayer реализует непосредственно операции со
// списком, пользуясь только входными и выходными параметрами.
// Модуль используется модулем srcCore_menuitems, который 
// здешними процедурами обрабатывает свой список
// -----------------------------------
// (с) Сафронов М.А. фКГУ г. Наб. Челны, март 2007 года

#include "srcCore_datalayer.h"

ptNode listConstruct(size_t size)
{//Код (с)Романовский Э.А.
	size_t i;
	ptNode pN, plist(0);
	if (size)						// Если size != 0.
	{
		pN = plist = new TNode;			// Создание начального узла.
		for (i = 1; i < size; ++i)		// Создание остальных узлов.
			pN = pN->link = new TNode;
		pN->link = 0;			// Последний узел содержит пустой указатель.
	}
	return plist;
}
void listDestroy(ptNode plist)
{//Код (с)Романовский Э.А.
	ptNode pN(plist);
	while (plist)					// Пока список непустой.
	{
		pN = plist->link;
		delete plist;					// Удаление очередного узла.
		plist = pN;
	}
}
ptNode listInverse(ptNode plist)
{//Код (с)Романовский Э.А.
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
	{		// Ежели эл-т есть, то начинаем
		ptNode pT=new TNode;	// Создали новый узел
		pT->link=pN->link;		// Новый узел указывает на 
								// тот же узел, что и исходный
		pN->link=pT;			// Исходный узел указывает на 
								// новый
		pT->name=key;
		pT->number=val;
	}	
	else	// Ежели эл-та нет, то заканчиваем =) 
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