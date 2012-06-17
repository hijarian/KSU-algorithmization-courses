#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;
// 1.6 var 9
// A=0.7
// X1=-10*A
// DX=1/2*A

double f1(double A, double x)
{
	return -1*pow((x+3*A),2)-2*A;
}

double f2(double A, double x)
{
	return A*cos(x-3*A)-3*A;
}

void printline(int length)
{
	for (int i=1; i<=length; ++i)
		cout << char(-60);
}

int main()
{
	double A=.7, x1=(-10)*A, dx=A/2.;
	unsigned nmb;
	cout << "Enter number of values: ";
	cin >> nmb;
	{//
		cout << char(-38);
		printline(8);
		cout << char(-62);
		printline(15);
		cout << char(-65);
		cout << endl; 
	}

	cout << char(-77) << " X      " << char(-77) << " f(X)          " << char(-77) << endl;

	{//
		cout << char(-61);
		printline(8);
		cout << char(-59);
		printline(15);
		cout << char(-76);
		cout << endl; 
	}

	double x=x1;

	for (unsigned i=0; i<nmb; ++i)
	{
		x+=(dx*i);
		double y;
		if (x<=(-6)*A)
			y=f1(A,x);
		else
			y=f2(A,x);
		cout << char(-77) << setw(8) << x << char(-77);
		cout << setw(15) << y << char(-77) << endl;
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