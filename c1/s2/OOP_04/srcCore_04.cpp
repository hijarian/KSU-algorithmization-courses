#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;
// 1.7 var 9

double f(double x)
{
	return (log(1+x)+10.0/3.0*exp(0.01*x))/(2*sqrt(x))-x;
}

int main()
{
	cout << "Next function will be processed: \n";
	cout << "f(x)=(log(1+x)+10.0/3.0*exp(0.01*x))/(2*sqrt(x))-x\n";
	cout << "So, negative values not allowed\n";
	double a;
	cout << "Enter POSITIVE lower edge of segment: ";
	cin >> a;
	double b;
	cout << "Enter POSITIVE upper edge of segment: ";
	cin >> b;
	double e;
	cout << "Enter accuracy factor: ";
	cin >> e; 
	if(a>b)
	{
		cout << "Lower edge greater than upper - swapped\n";
		double c=a;
		a=b;
		b=c;
	}
	cout << "Proccessing\n";
	double x;
	while((b-a)>e)
	{
		x=a+((b-a)/2.0);
		cout << fixed;
		cout << "Current segment: [" << a << ";" << b << "] and it's middle point is " << x << endl;
		int sign_a=(f(a)>=0)?(1):(0);
		int sign_b=(f(b)>=0)?(1):(0);
		int sign_x=(f(x)>=0)?(1):(0);
		if (sign_a!=sign_x)
			b=x;
		else 
		{
			if (sign_x!=sign_b)
				a=x;
			else 
			{
				cout << "Cannot be completed\n";
				break;
			}
		}
	}

	cout << "Accuracy limit reached. Root found: " << x << endl;
	cout << "f(" << x << ")=" << f(x) << endl;

	return 0;
}