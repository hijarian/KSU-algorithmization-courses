#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <ctime>
#include <vector>

using namespace std;

const unsigned arrL=20;
typedef vector <int> ivec;

int m_count( ivec *Y, ivec *X )
{
	int counter=0;
	for (int i=0; (i<arrL); ++i)
	{
		if((*Y)[i]==(*X)[i])
			++counter;
	}
	return counter;
}

int m_otn( ivec *Y, ivec *X)
{
	int counter=0;
	for (int i=0; i<arrL; ++i)
	{
		for (int j=0; j<arrL; ++j)
		{
			if ((*Y)[i]==(*X)[j])
			{
				++counter;
				break;
			}
		}
	}
	return counter;
}
void arrOut( ivec *arr )
{
	for(int i=0; i<arrL; ++i)
	{
		int a=(*arr)[i];
		cout << setw(2) << a << ' ';
	}
	cout << endl;
}
void printline(int length)
{
	cout << char(-60) << char(-59);
	for (int i=1; i<=length; ++i)
		cout << char(-60);
}
int main()
{
	//int Y[arrL], X[arrL];
	//	int (*pY)[arrL]=&Y[arrL], (*pX)[arrL]=&X[arrL];
	ivec vX(arrL), vY(arrL);
	ivec *pY=&vY, *pX=&vX;
	srand((unsigned)time(NULL));
	for (int i=0; i<arrL; ++i)
	{
		vY[i]=(rand()/5-rand()/10)/1000;
		vX[i]=(rand()/5-rand()/10)/1000;
	}
	cout << 'i' << char(-77);
	for (int i=0; i< arrL; ++i)
		cout << setw(2) << i << ' ';
	cout << endl;
	printline(arrL*3-1);
	cout << endl;
	cout << 'Y' << char(-77);
	arrOut(pY);
	printline(arrL*3-1);
	cout << endl;
	cout << 'X' << char(-77);
	arrOut(pX);
	cout << endl;
	cout << "Inner procedure counted " << m_count(pY, pX) << " of straight equalities.\n";
	cout << "Inner procedure counted " << m_otn(pY, pX) << " of non-straight equalities.\n";
	cout << "----------\n";
	cout << endl;
	cout << "Begin checking.\n--Straight equality:\n";
	int counter=0;
	for(int i=0; i<arrL; ++i)
	{
		if (vY[i]==vX[i])
		{
			++counter;
			cout << "Y[" << i << "]=X[" << i << "] : " << vY[i] << '=' << vX[i] << endl;
		}
	}
	cout << "Counted " << counter << " equal elements.\n";
	cout << "--Non-straight equality:\n";
	counter=0;
	for (int i=0; i<arrL; ++i)
	{
		for (int j=0; j<arrL; ++j)
		{
			if (vY[i]==vX[j])
			{
				++counter;
				cout << "Y[" << i << "]=X[" << j << "] : " << vY[i] << '=' << vX[j] << endl;
				break;
			}
		}
	}
	cout << "Counted " << counter << " equal elements.\n";

	return 0;
}