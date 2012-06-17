// Решение задачи 13 по курсу "Введение в С++"
// Программа, реализующая связный список структур с данными,
// и выполняющая простейшие операции над этим списком.
// Задача 5.2.2 вариант 9
// -----------------------------------
// Модуль №1 srcCore_menuitems предназначен для обработки различных пунктов меню
// получает данные с потока ввода от пользователя, и передает их в модуль №2 
// srcCore_datalayer, который занимается непосредственной обработкой списка.
// -----------------------------------
// (с) Сафронов М.А. фКГУ г. Наб. Челны, март 2007 года

#include "srcCore_datalayer.h"
#include <iostream>
#include <iomanip>
#include <Windows.h>
#include <wincon.h>
#include "ConvOem.h"
using namespace std;
CConvOem sz(128);

ptNode listMain=NULL; // Главный список, над которым прога и извращается
HANDLE hCi=GetStdHandle(STD_INPUT_HANDLE);	// хэндл потока ввода консоли, нужен в одном месте кода =)
HANDLE hCO=GetStdHandle(STD_OUTPUT_HANDLE); // хэндл потока вывода консоли
CONSOLE_CURSOR_INFO cci={1, TRUE};			// инфа, требуемая для включения курсора

int menuInput(void)
{//Создание списка требуемой длины и ввод его эл-тов с клавиатуры
	SetConsoleCursorInfo(hCO, &cci);		// Включение курсора.
	char a;
	if(listMain!=NULL)
	{// Ежели вдруг список уже есть
		cout << sz.toOem(" Действительно обнулить список? Y/N \n");
		do{
			cin >> a;
		}while((a!='y')&&(a!='Y')&&(a!='N')&&(a!='n'));
		if (a=='n'||a=='N')
			return 1;
	}
	cout << sz.toOem("Введите желаемую длину списка\n");
	size_t p;
	cin >> p;
	listMain=listConstruct(p); // Переход в datalayer

	ptNode pN=listMain; //Создаем итератор
	p=1;
	while(pN)
	{// вводим список с клавиатуры
		cout << sz.toOem("Запись №") << (unsigned)p << endl;
		cout << sz.toOemA("Имя: ");
		cin >> pN->name;
		cout << sz.toOemA("Номер телефона: ");
		cin >> pN->number;
		pN=pN->link;
		++p;
	}
	cout << sz.toOemA("Нажмите любую клавишу для выхода в меню.");
	// предыдущая строчка нужна потому, что менюшка в WConMenuEx.cpp
	// ожидает нажатия на клавишу после завершения работы какого-либо пункта меню
	return 0;
};
int menuPrint(void)
{// Вывод списка на экран
	ptNode pN=listMain;
	if(!pN)
	{
		cout << sz.toOemA("Список пуст.\nНажмите любую клавишу для выхода в меню.");
		return 1;
	}
	while(pN)
	{// Тупо, безо всякого форматирования
		cout << pN->name << " : " << pN->number << endl;
		pN=pN->link;
	}
	cout << sz.toOemA("Элементов: ");
	cout << (unsigned)listGetSize(listMain) << endl;
	cout << sz.toOemA("Нажмите любую клавишу для выхода в меню.");
	return 0;
};
int menuAddNode(void)
{// Вставка записи после произвольной
	size_t size=listGetSize(listMain);
	SetConsoleCursorInfo(hCO, &cci);		// Включение курсора.
	cout << sz.toOem("В списке ") << (unsigned)size;
	cout << sz.toOem(" элементов.\n");
	cout << sz.toOem("Введите номер записи, после которой следует вставить новую.\n");
	cout << sz.toOem("0-вставить запись в начало списка.\n");
	size_t nmb;
	do{
		cin >> nmb;
		if(nmb>size)
			cout << sz.toOemA("В списке нет такой записи!");
	}while(/*(nmb==0)||*/(nmb>size));
	cout << sz.toOem("Имя: ");
	TKey sKey;
	cin >> sKey;
	cout << sz.toOem("Номер телефона: ");
	TVal sVal;
	cin >> sVal;
	if(nmb)		//Если юзер ввел не "0", то вызов обычной функции вставки эл-та
		listAddNode(listMain, nmb, sKey, sVal);
	else			//Если же юзер ввел "0", то адрес начала списка тр-ся изменить.
		listMain=listAdd1st(listMain, sKey, sVal);
	cout << sz.toOemA("Нажмите любую клавишу для выхода в меню.");
	return 0;
};
int menuRemoveNode(void)
{// Удаление произвольной записи
	SetConsoleCursorInfo(hCO, &cci);		// Включение курсора.
	size_t size=listGetSize(listMain);
	cout << sz.toOem("В списке ") << (unsigned)size;
	cout << sz.toOem(" элементов.\n");
	cout << sz.toOem("Введите номер записи, которую следует удалить.\n");
	size_t nmb;
	do{
		cin >> nmb;
		if(nmb>size)
			cout << sz.toOemA("В списке нет такой записи!");
	}while((nmb==0)||(nmb>size));
	cout << sz.toOem(" Действительно удалить? Y/N \n");
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
	cout << sz.toOemA("Нажмите любую клавишу для выхода в меню.");
	return 0;
};
int menuSave(void)
{// Сохранение списка в произвольный файл
	SetConsoleCursorInfo(hCO, &cci);		// Включение курсора.
	cout << sz.toOemA("Введите путь к файлу (возможно, относмтельный): ") << endl;
	string Path;
	cin >> Path;
	char* cPath=&(Path[0]);
	ofstream flSave(cPath);
	if(!flSave)
	{
		cout << sz.toOemA("Не удалось создать файл");
		return -1;
	}
	listSave(listMain, cPath);
	cout << sz.toOemA("Нажмите любую клавишу для выхода в меню.");
	return 0;
};
int menuLoad(void)
{// Загрузка списка из файла
	SetConsoleCursorInfo(hCO, &cci);		// Включение курсора.
	cout << sz.toOemA("Введите путь к файлу (возможно, относмтельный): ") << endl;
	string Path;
	cin >> Path;
	char* cPath=&(Path[0]);
	ifstream flLoad(cPath);
	if(!flLoad)
	{
		cout << sz.toOemA("Не удалось открыть файл");
		return -1;
	}
	listMain=listLoad(cPath);
	if(listMain)
	{
		cout << sz.toOemA("Успешно загружено.");
		cout << sz.toOemA("Нажмите любую клавишу для выхода в меню.");
		return 0;
	}
	else
	{
		cout << sz.toOemA("Успешно загружено, но по каким-либо эзотерическим причинам список пуст.\n");
		cout << sz.toOemA("Нажмите любую клавишу для выхода в меню.");
		return 1;
	}
};
int menuDoStuff(void)
{// Выполнение указанных в задании операций над списком
	SetConsoleCursorInfo(hCO, &cci);		// Включение курсора.
	ptNode pN=listMain;
	if(!pN)
	{// Если список пуст (вообще пуст, listMain=NULL)
		cout << sz.toOemA("Нельзя работать с пустым списком!\nНажмите любую клавишу для выхода в меню.");
		return 1;
	}
	string match="";
	const size_t ln=3; /* длина эталонной строки равна трем символам - как в задании*/;
// Заставляем юзера ввести ровно ln символов
	cout <<	sz.toOemA("Введите ") << ln;
	cout << sz.toOemA(" любых символа:\n");
	do{
		cin >> match;
		FlushConsoleInputBuffer(hCi); // Вот здеся и нужен объявленный в заголовке хэндл потока ввода
									  // Если не очистить поток ввода, прога будет читать его вечно =)
	}while(match._Mysize!=ln);
// Здесь мы окажемся, когда длина match будет равна ровно 3 символа
	size_t MatchedCount=0;
	size_t& mc=MatchedCount;
	while(pN)
	{// Пока есть записи
		size_t IsFound=0;
		const char* p=match.c_str();
		for(size_t i=0; i<ln; ++i)
		{// i изменяется от 0 до ln-1, то есть происходит ровно ln итераций 
			if(*p==pN->number[i])
				++IsFound;
			++p;
		}
		if(IsFound==ln)
		{// Если нашли ровно ln *прямо* совпадающих символов, то номер удовлетворяет условию задания
			cout <<	pN->name << sz.toOemA(" имеет верный номер телефона: ") << pN->number << endl;
			++mc;
		}
		pN=pN->link;
	}
	cout << sz.toOemA("Найдено: ") << (unsigned)mc;
	cout << sz.toOemA(" соответствующих записей.\n");
	while(pN)
	{
		cout << pN->name << " : " << pN->number << endl;
		pN=pN->link;
	}
	cout << sz.toOemA("Нажмите любую клавишу для выхода в меню.");
	return 0;
};
int menuExit(void)
{// Выход из проги
	cout << sz.toOem("Выход из программы. Выгружаем список из памяти.") << endl;
	listDestroy(listMain);
	cout << sz.toOemA("Нажмите любую клавишу для выхода в меню.");
	return 0;
}