#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;
//1.8 var 9

double f(double x)
{
	return pow(x,2)-sqrt(exp(x));
}

double g(double x)
{
	return 1./(2*x-x*x-2);
}

void printline(int length)
{
	for (int i=1; i<=length; ++i)
		cout << char(-60);
}
int main()
{
	double init=.1;
	double step=.1;	


	{//up
		cout << char(-38);
		printline(8);
		cout << char(-62);
		printline(15);
		cout << char(-62);
		printline(15);
		cout << char(-62);
		printline(15);
		cout << char(-65);
		cout << endl; 
	}
	cout << char(-77) << " x      " << char(-77) << " f(x)          " << char(-77);
	cout << " g(x)          " << char(-77) << " f(x)-g(x)     " << char(-77) << endl;
	{//
		cout << char(-61);
		printline(8);
		cout << char(-59);
		printline(15);
		cout << char(-59);
		printline(15);
		cout << char(-59);
		printline(15);
		cout << char(-76);
		cout << endl; 
	}
	double x=init;
	double f1=f(x);
	double g1=g(x);
	int prevDiffSign=((f1-g1)>=0)?(1):(0);
	int curDiffSign;
	cout << fixed;
	for (double i=init; i<=10; i+=step)
	{
		x=i;
		f1=f(x);
		g1=g(x);
		curDiffSign=((f1-g1)>=0)?(1):(0);
		cout << char(-77) << setw(8) << x << char(-77);
		cout << setw(15) << f1 << char(-77) << setw(15) << g1 << char(-77) << setw(15) << f1-g1 << char(-77) << endl; 
		if (curDiffSign!=prevDiffSign)
			break;

	}


	{//
		cout << char(-64);
		printline(8);
		cout << char(-63);
		printline(15);
		cout << char(-63);
		printline(15);
		cout << char(-63);
		printline(15);
		cout << char(-39);
		cout << endl; 
	}
	return 0;
}