#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;

double f(double x)
{
	const double pi=3.149;
	return (abs(sin(sqrt(10.5*x)))/(pow(x,3.0/2.0)-0.143))+2*pi*x;
}

void printline(int length)
{
	for (int i=1; i<=length; ++i)
		cout << char(-60);
}

int main()
{
	//
	double a;
	cout << "Enter starting value:" ;
	cin >> a;
	//
	double b;
	cout << endl << "Enter ending value:" ;
	cin >> b;
	//
	int nmb;
	cout << endl << "Enter number of iterations:" ;
	cin >> nmb;
	//
	double step=(b-a)/(double)(nmb-1);
	//
	{//
		cout << char(-38);
		printline(8);
		cout << char(-62);
		printline(15);
		cout << char(-65);
		cout << endl; 
	}

	//cout << fixed;
	cout << char(-77)  << "   X    " << char(-77) << "  F(X)         " << char(-77) << endl;
	//
	{//
		cout << char(-61);
		printline(8);
		cout << char(-59);
		printline(15);
		cout << char(-76);
		cout << endl; 
	}

	for(double i=a;i<=b;i+=step)
		cout << char(-77) << setw(8) << i << "|" << setw(15) << f(i) << char(-77) << endl;
	{//
		cout << char(-64);
		printline(8);
		cout << char(-63);
		printline(15);
		cout << char(-39);
		cout << endl; 
	}
	char u;
	cin >> u;
	return 0;
}