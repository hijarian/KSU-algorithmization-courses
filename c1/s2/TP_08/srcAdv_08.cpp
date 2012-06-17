#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;
//4.2.1 -> 2.3 -> 1.5 var 9

double ctrl(double x)
{
	return (cos(x)/pow(x,2))+.5;
}

double f(double x, int i, double imult, double e)
{
	cout << fixed;
	cout << "----------\n";
	cout << "iteration #" << i << endl;
	double imult2=imult*(2*i+1)*(2*i+2);
	cout << "factorial equals " << setw(8) << setprecision(0) << imult2 << endl;
	double el=(pow(x, 2*i)/imult2);
	cout << "current addend equals " << setw(2) << setprecision(0) << pow(-1,i+1);
	cout << setprecision(8) << '*' << el << endl;
	if (abs(el)<e)
	{
		cout << "addend lower than accuracy factor\n";
		cout << "Counting finished\nBegan summarizing\n";
		cout << "----------\n";
		return el;
	}
	else
	{
		cout << "addend greater than accuracy factor\n";
			cout << "moving to iteration #" << i+1 << endl;
			return el - f(x, i+1, imult2, e);
	}
}

int main()
{
	double x;
	double e;
	cout << fixed;
	cout << "x=";
	cin >> x;
	cout << "e=";
	cin >> e;
	double a=ctrl(x);
	cout << "Control function result: " << a << endl;
	double b=1/pow(x,2)+f(x,1,2,e);
	cout << "Main function result: " << b << endl;
	return 0;
}