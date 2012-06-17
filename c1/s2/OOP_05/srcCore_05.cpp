#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;

int f(int k)
{
	return (int) ceil(pow(k,3)-25*pow(k,2)+50*k+1000);
}

void printline(int length)
{
	for (int i=1; i<=length; ++i)
		cout << char(-60);
}
int main()
{
	//
	int a;
	cout << "Enter \'A\' value: ";
	cin >> a;
	int b;
	cout << "Enter \'B\' value: ";
	cin >> b;
	int m;
	cout << "Enter \'M\' value: ";
	cin >> m;

	double t=a*b*m;
	double T1=sqrt(t);
	double T2=a+b+m;
	double T3=sqrt(T2);
	t=b+m;
	double T4=a+sqrt(t);
	cout << "T1=" << T1 << "\nT2=" << T2 << "\nT3=" << T3 << "\nT4=" << T4 << endl;
	cout << "20 values from (-30..60) will be checked.\n";
	cout << "Only matched results will be displayed. \n";

	{//
		cout << char(-38);
		printline(8);
		cout << char(-62);
		printline(15);
		cout << char(-65);
		cout << endl; 
	}

	cout << char(-77) << " K      " << char(-77) << " f(K)          " << char(-77) << endl;

	{//
		cout << char(-61);
		printline(8);
		cout << char(-59);
		printline(15);
		cout << char(-76);
		cout << endl; 
	}

	int step=88/20;
	int e;
	for (int i=-29; i<60; i+=step)
	{
		e=f(i);
		if (((e>T1)&&(e>T2))||((e>T3)&&(e<T4)))
		{
			cout << char(-77) << setw(8) << i << char(-77);
			cout << setw(15) << e << char(-77);
			if (e>T1)
				cout << " >T1 ";
			if (e>T2)
				cout << " >T2 ";
			if (e>T3)
				cout << " >T3 ";
			if (e<T4)
				cout << " <T4 ";
			cout << endl;
		}
	}
	{//
		cout << char(-64);
		printline(8);
		cout << char(-63);
		printline(15);
		cout << char(-39);
		cout << endl; 
	}

	return 0;
}